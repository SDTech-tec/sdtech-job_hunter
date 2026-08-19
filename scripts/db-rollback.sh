#!/usr/bin/env bash
# ============================================================
# db-rollback.sh — Exibe migrations disponíveis e orienta rollback
# SDTech Soluctions — Database V1.0
# ============================================================
# NOTA: Rollback automático em PostgreSQL requer planejamento.
# Este script lista o que foi aplicado e fornece orientação.
# Rollbacks manuais devem ser realizados com cuidado e backup.
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
echo " SDTech Soluctions — Rollback de Migrations"
echo "============================================================"
echo ""
echo "⚠️  ATENÇÃO: Realize backup antes de qualquer rollback!"
echo "    make db-backup"
echo ""
echo "📋 Migrations aplicadas:"
PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
    -h "$DB_HOST" -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" -d "$DB_NAME" \
    -c "SELECT version, applied_at FROM schema_migrations ORDER BY applied_at DESC;" 2>/dev/null

echo ""
echo "Para realizar rollback manual de uma migration específica:"
echo "  1. Execute: make db-backup"
echo "  2. Conecte ao banco: psql -h $DB_HOST -p $DB_PORT -U $DB_ADMIN_USER -d $DB_NAME"
echo "  3. Execute os comandos DROP/ALTER necessários manualmente"
echo "  4. Remova o registro: DELETE FROM schema_migrations WHERE version = '<versão>';"
echo "  5. Execute: make db-status para verificar o estado"
echo ""
echo "Cada migration está documentada em: migrations/<versao>.sql"
