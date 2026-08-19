#!/usr/bin/env bash
# ============================================================
# db-migrate.sh — Aplica migrations em ordem
# SDTech Soluctions — Database V1.0
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
MIGRATIONS_DIR="$ROOT_DIR/migrations"

# Carrega .env se existir
if [[ -f "$ROOT_DIR/.env" ]]; then
    set -a && source "$ROOT_DIR/.env" && set +a
fi

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-sdtech_soluctions}"
DB_ADMIN_USER="${DB_ADMIN_USER:-sdtech_owner}"
DB_ADMIN_PASSWORD="${DB_ADMIN_PASSWORD:-}"
DB_USER="${DB_USER:-sdtech_app}"

echo "============================================================"
echo " SDTech Soluctions — Aplicando Migrations"
echo "============================================================"
echo " Host:    $DB_HOST:$DB_PORT"
echo " Banco:   $DB_NAME"
echo " Usuário: $DB_ADMIN_USER"
echo " Dir:     $MIGRATIONS_DIR"
echo "============================================================"

# Cria tabela de controle de migrations se não existir
PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -v ON_ERROR_STOP=1 \
    -c "
    CREATE TABLE IF NOT EXISTS schema_migrations (
        version     TEXT        PRIMARY KEY,
        applied_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
        checksum    TEXT
    );
    "

# Aplica migrations em ordem
APPLIED=0
SKIPPED=0

for migration_file in $(ls "$MIGRATIONS_DIR"/*.sql | sort); do
    version=$(basename "$migration_file" .sql)

    # Verifica se já foi aplicada
    ALREADY_APPLIED=$(PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
        -h "$DB_HOST" -p "$DB_PORT" \
        -U "$DB_ADMIN_USER" -d "$DB_NAME" \
        -t -c "SELECT COUNT(*) FROM schema_migrations WHERE version = '$version';" | tr -d ' ')

    if [[ "$ALREADY_APPLIED" == "1" ]]; then
        echo "  ⏭  SKIP  $version (já aplicada)"
        ((SKIPPED++)) || true
        continue
    fi

    echo "  ▶  APPLY $version"

    # Calcula checksum do arquivo
    CHECKSUM=$(sha256sum "$migration_file" | awk '{print $1}')

    # Aplica a migration
    PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
        -h "$DB_HOST" -p "$DB_PORT" \
        -U "$DB_ADMIN_USER" -d "$DB_NAME" \
        -v ON_ERROR_STOP=1 \
        -f "$migration_file"

    # Registra como aplicada
    PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
        -h "$DB_HOST" -p "$DB_PORT" \
        -U "$DB_ADMIN_USER" -d "$DB_NAME" \
        -c "INSERT INTO schema_migrations (version, checksum) VALUES ('$version', '$CHECKSUM');"

    echo "     ✅ $version aplicada"
    ((APPLIED++)) || true
done

echo ""
echo "============================================================"
echo " Resultado: $APPLIED migrations aplicadas | $SKIPPED puladas"
echo "============================================================"

# Configura permissões do usuário de aplicação
echo ""
echo "⚙️  Configurando permissões do usuário de aplicação ($DB_USER)..."

PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -v ON_ERROR_STOP=1 \
    <<SQL
-- Revoga acesso público por padrão
REVOKE ALL ON SCHEMA public FROM PUBLIC;

-- Garante acesso ao schema public para o usuário de aplicação
GRANT USAGE ON SCHEMA public TO $DB_USER;

-- Permissões de leitura/escrita nas tabelas
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO $DB_USER;

-- Permissões em sequências (para IDs se houver)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;

-- Garante permissões em tabelas futuras automaticamente
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $DB_USER;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO $DB_USER;

SQL

echo "✅ Permissões configuradas para $DB_USER"
echo ""
echo "Próximo passo: make db-seed"
