#!/usr/bin/env bash
# ============================================================
# db-status.sh — Verifica status do banco SDTech Soluctions
# SDTech Soluctions — Database V1.0
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

if [[ -f "$ROOT_DIR/.env" ]]; then
    set -a && source "$ROOT_DIR/.env" && set +a
fi

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-sdtech_soluctions}"
DB_ADMIN_USER="${DB_ADMIN_USER:-sdtech_owner}"
DB_ADMIN_PASSWORD="${DB_ADMIN_PASSWORD:-}"

echo "============================================================"
echo " SDTech Soluctions — Status do Banco"
echo "============================================================"

# Testa conexão
echo ""
echo "📡 Testando conexão..."
if PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -c "SELECT version();" -t -q 2>/dev/null; then
    echo "✅ Conexão OK"
else
    echo "❌ Falha na conexão com $DB_HOST:$DB_PORT/$DB_NAME"
    exit 1
fi

# Migrations aplicadas
echo ""
echo "📋 Migrations aplicadas:"
PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -c "SELECT version, applied_at FROM schema_migrations ORDER BY applied_at;" 2>/dev/null \
    || echo "  Tabela schema_migrations não encontrada. Execute db-migrate primeiro."

# Contagem de registros por tabela
echo ""
echo "📊 Registros por tabela:"
PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -c "
    SELECT
        schemaname,
        tablename,
        n_live_tup AS registros
    FROM pg_stat_user_tables
    WHERE schemaname = 'public'
    ORDER BY tablename;
    " 2>/dev/null

# Tamanho do banco
echo ""
echo "💾 Tamanho do banco:"
PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -c "SELECT pg_size_pretty(pg_database_size('$DB_NAME')) AS tamanho_banco;" 2>/dev/null

echo ""
echo "============================================================"
echo " Status verificado em: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "============================================================"
