#!/usr/bin/env bash
# ============================================================
# db-backup.sh — Realiza backup do banco SDTech Soluctions
# SDTech Soluctions — Database V1.0
# ============================================================
# IMPORTANTE: Execute ANTES de qualquer alteração estrutural.
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
BACKUP_DIR="${BACKUP_DIR:-$ROOT_DIR/backups}"
BACKUP_RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-30}"

# Cria diretório de backup
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.dump"

echo "============================================================"
echo " SDTech Soluctions — Backup"
echo "============================================================"
echo " Banco:   $DB_NAME"
echo " Arquivo: $BACKUP_FILE"
echo " Data:    $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "============================================================"

# Realiza backup no formato custom (comprimido, restaurável com pg_restore)
PGPASSWORD="$DB_ADMIN_PASSWORD" pg_dump \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_ADMIN_USER" \
    -d "$DB_NAME" \
    --format=custom \
    --compress=9 \
    --verbose \
    --file="$BACKUP_FILE"

BACKUP_SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)

echo ""
echo "✅ Backup concluído!"
echo "   Arquivo:  $BACKUP_FILE"
echo "   Tamanho:  $BACKUP_SIZE"
echo "   Data/Hora: $(date '+%Y-%m-%d %H:%M:%S %Z')"

# Remove backups antigos
echo ""
echo "🧹 Removendo backups com mais de $BACKUP_RETENTION_DAYS dias..."
find "$BACKUP_DIR" -name "*.dump" -mtime "+$BACKUP_RETENTION_DAYS" -delete
echo "   Limpeza concluída."

# Registra no log
echo "$(date '+%Y-%m-%d %H:%M:%S') | BACKUP | $DB_NAME | $BACKUP_FILE | $BACKUP_SIZE" \
    >> "$BACKUP_DIR/backup.log"
