#!/usr/bin/env bash
# ============================================================
# db-seed.sh — Aplica seeds de dados essenciais
# SDTech Soluctions — Database V1.0
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
SEEDS_DIR="$ROOT_DIR/seeds"

if [[ -f "$ROOT_DIR/.env" ]]; then
    set -a && source "$ROOT_DIR/.env" && set +a
fi

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-sdtech_soluctions}"
DB_ADMIN_USER="${DB_ADMIN_USER:-sdtech_owner}"
DB_ADMIN_PASSWORD="${DB_ADMIN_PASSWORD:-}"

echo "============================================================"
echo " SDTech Soluctions — Aplicando Seeds"
echo "============================================================"
echo " Host:  $DB_HOST:$DB_PORT | Banco: $DB_NAME"
echo "============================================================"

for seed_file in $(ls "$SEEDS_DIR"/*.sql | sort); do
    seed_name=$(basename "$seed_file")
    echo "  ▶  SEED $seed_name"
    PGPASSWORD="$DB_ADMIN_PASSWORD" psql \
        -h "$DB_HOST" -p "$DB_PORT" \
        -U "$DB_ADMIN_USER" -d "$DB_NAME" \
        -v ON_ERROR_STOP=1 \
        -f "$seed_file"
    echo "     ✅ $seed_name aplicado"
done

echo ""
echo "✅ Seeds aplicados com sucesso."
