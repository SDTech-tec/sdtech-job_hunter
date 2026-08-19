#!/usr/bin/env bash
# ============================================================
# db-create.sh — Cria banco e usuário de aplicação
# SDTech Soluctions — Database V1.0
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

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
DB_PASSWORD="${DB_PASSWORD:-}"

echo "============================================================"
echo " SDTech Soluctions — Criando banco de dados"
echo "============================================================"
echo " Host:        $DB_HOST:$DB_PORT"
echo " Banco:       $DB_NAME"
echo " Owner:       $DB_ADMIN_USER"
echo " App User:    $DB_USER"
echo "============================================================"

# Conecta como postgres superuser para criar recursos
PGPASSWORD="${DB_ADMIN_PASSWORD}" psql \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "${POSTGRES_SUPERUSER:-postgres}" \
    -v ON_ERROR_STOP=1 \
    <<SQL
-- Cria o usuário owner do banco (sem superuser)
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '$DB_ADMIN_USER') THEN
        CREATE ROLE $DB_ADMIN_USER
            WITH LOGIN
            PASSWORD '$DB_ADMIN_PASSWORD'
            NOSUPERUSER NOCREATEDB NOCREATEROLE;
        RAISE NOTICE 'Usuário $DB_ADMIN_USER criado.';
    ELSE
        RAISE NOTICE 'Usuário $DB_ADMIN_USER já existe. Pulando.';
    END IF;
END \$\$;

-- Cria o usuário de aplicação (privilégios mínimos)
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '$DB_USER') THEN
        CREATE ROLE $DB_USER
            WITH LOGIN
            PASSWORD '$DB_PASSWORD'
            NOSUPERUSER NOCREATEDB NOCREATEROLE;
        RAISE NOTICE 'Usuário $DB_USER criado.';
    ELSE
        RAISE NOTICE 'Usuário $DB_USER já existe. Pulando.';
    END IF;
END \$\$;

-- Cria o banco de dados
SELECT 'CREATE DATABASE $DB_NAME OWNER $DB_ADMIN_USER ENCODING ''UTF8'' LC_COLLATE ''pt_BR.UTF-8'' LC_CTYPE ''pt_BR.UTF-8'' TEMPLATE template0'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME') \gexec

SQL

echo ""
echo "✅ Banco criado com sucesso."
echo ""
echo "Próximo passo: make db-migrate"
