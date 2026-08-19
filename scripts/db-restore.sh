#!/usr/bin/env bash
# ============================================================
# db-restore.sh — Restaura backup do banco SDTech Soluctions
# SDTech Soluctions — Database V1.0
# ============================================================
# Uso: ./scripts/db-restore.sh caminho/para/backup.dump
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

if [[ -f "$ROOT_DIR/.env" ]]; then
    set -a && source "$ROOT_DIR/.env" && set +a
fi

BACKUP_FILE="${1:-}"

if [[ -z "$BACKUP_FILE" ]]; then
    echo "❌ Uso: $0 <arquivo_de_backup.dump>"
    echo ""
    echo "Backups disponíveis:"
    ls -lh "${BACKUP_DIR:-$ROOT_DIR/backups}"/*.dump 2>/dev/null || echo "  Nenhum backup encontrado."
    exit 1
fi

if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "❌ Arquivo não encontrado: $BACKUP_FILE"
    exit 1
fi

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-sdtech_soluctions}"
DB_ADMIN_USER="${DB_ADMIN_USER:-sdtech_owner}"
DB_ADMIN_PASSWORD="${DB_ADMIN_PASSWORD:-}"

echo "============================================================"
echo " SDTech Soluctions — RESTAURAÇÃO DE BACKUP"
echo "============================================================"
echo " ⚠️  ATENÇÃO: Esta operação substitui dados existentes!"
echo "============================================================"
echo " Banco:   $DB_NAME"
echo " Arquivo: $BACKUP_FILE"
echo " Tamanho: $(du -sh "$BACKUP_FILE" | cut -f1)"
echo "============================================================"
echo ""
read -p "Confirma restauração? (yes/N): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Operação cancelada."
    exit 0
fi

echo ""
echo "🔄 Restaurando..."

PGPASSWORD="$DB_ADMIN_PASSWORD" pg_restore \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" \
    -d "$DB_NAME" \
    --clean \
    --if-exists \
    --verbose \
    "$BACKUP_FILE"

echo ""
echo "✅ Restauração concluída: $(date '+%Y-%m-%d %H:%M:%S %Z')"
