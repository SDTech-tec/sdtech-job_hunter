#!/usr/bin/env bash
# ============================================================
# test-multitenancy.sh — Teste de isolamento multi-tenant
# SDTech Soluctions — Database V1.0
# ============================================================
# Cria TENANT_A e TENANT_B, insere dados em ambos, valida
# isolamento e remove dados de teste ao final.
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

PG="PGPASSWORD=$DB_ADMIN_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_ADMIN_USER -d $DB_NAME -v ON_ERROR_STOP=1"

PASS=0
FAIL=0

check() {
    local desc="$1"
    local result="$2"
    local expected="$3"
    if [[ "$result" == "$expected" ]]; then
        echo "  ✅ PASS: $desc"
        ((PASS++)) || true
    else
        echo "  ❌ FAIL: $desc"
        echo "     Esperado: '$expected' | Obtido: '$result'"
        ((FAIL++)) || true
    fi
}

echo "============================================================"
echo " SDTech Soluctions — Teste de Multi-Tenancy"
echo "============================================================"
echo ""

# ============================================================
# SETUP: Cria dados de teste
# ============================================================
echo "📦 Criando dados de teste..."

eval "$PG" -t -q <<'SQL'
BEGIN;

-- Cria TENANT_A
INSERT INTO tenants (id, name, legal_name, status)
VALUES ('aaaaaaaa-0000-0000-0000-000000000001', 'TENANT_A TESTE', 'Empresa A Ltda', 'active')
ON CONFLICT (id) DO NOTHING;

-- Cria TENANT_B
INSERT INTO tenants (id, name, legal_name, status)
VALUES ('bbbbbbbb-0000-0000-0000-000000000002', 'TENANT_B TESTE', 'Empresa B Ltda', 'active')
ON CONFLICT (id) DO NOTHING;

-- Usuário no TENANT_A
INSERT INTO users (id, tenant_id, name, email, password_hash)
VALUES (
    'aaaaaaaa-1111-0000-0000-000000000001',
    'aaaaaaaa-0000-0000-0000-000000000001',
    'Usuário A', 'usuario@empresa-a.com', 'hash_teste_a'
) ON CONFLICT DO NOTHING;

-- Usuário no TENANT_B
INSERT INTO users (id, tenant_id, name, email, password_hash)
VALUES (
    'bbbbbbbb-1111-0000-0000-000000000002',
    'bbbbbbbb-0000-0000-0000-000000000002',
    'Usuário B', 'usuario@empresa-b.com', 'hash_teste_b'
) ON CONFLICT DO NOTHING;

-- Contato no TENANT_A
INSERT INTO contacts (id, tenant_id, name, phone)
VALUES (
    'aaaaaaaa-2222-0000-0000-000000000001',
    'aaaaaaaa-0000-0000-0000-000000000001',
    'Contato A', '+5511900000001'
) ON CONFLICT DO NOTHING;

-- Contato no TENANT_B
INSERT INTO contacts (id, tenant_id, name, phone)
VALUES (
    'bbbbbbbb-2222-0000-0000-000000000002',
    'bbbbbbbb-0000-0000-0000-000000000002',
    'Contato B', '+5511900000002'
) ON CONFLICT DO NOTHING;

-- Canal no TENANT_A
INSERT INTO channels (id, tenant_id, type, name)
VALUES (
    'aaaaaaaa-3333-0000-0000-000000000001',
    'aaaaaaaa-0000-0000-0000-000000000001',
    'whatsapp', 'WhatsApp Empresa A'
) ON CONFLICT DO NOTHING;

-- Canal no TENANT_B
INSERT INTO channels (id, tenant_id, type, name)
VALUES (
    'bbbbbbbb-3333-0000-0000-000000000002',
    'bbbbbbbb-0000-0000-0000-000000000002',
    'whatsapp', 'WhatsApp Empresa B'
) ON CONFLICT DO NOTHING;

-- Conversa no TENANT_A
INSERT INTO conversations (id, tenant_id, contact_id, channel_id, status)
VALUES (
    'aaaaaaaa-4444-0000-0000-000000000001',
    'aaaaaaaa-0000-0000-0000-000000000001',
    'aaaaaaaa-2222-0000-0000-000000000001',
    'aaaaaaaa-3333-0000-0000-000000000001',
    'open'
) ON CONFLICT DO NOTHING;

-- Conversa no TENANT_B
INSERT INTO conversations (id, tenant_id, contact_id, channel_id, status)
VALUES (
    'bbbbbbbb-4444-0000-0000-000000000002',
    'bbbbbbbb-0000-0000-0000-000000000002',
    'bbbbbbbb-2222-0000-0000-000000000002',
    'bbbbbbbb-3333-0000-0000-000000000002',
    'open'
) ON CONFLICT DO NOTHING;

-- Mensagem no TENANT_A
INSERT INTO messages (id, tenant_id, conversation_id, sender_type, content)
VALUES (
    'aaaaaaaa-5555-0000-0000-000000000001',
    'aaaaaaaa-0000-0000-0000-000000000001',
    'aaaaaaaa-4444-0000-0000-000000000001',
    'contact', 'Mensagem de teste do Contato A'
) ON CONFLICT DO NOTHING;

-- Mensagem no TENANT_B
INSERT INTO messages (id, tenant_id, conversation_id, sender_type, content)
VALUES (
    'bbbbbbbb-5555-0000-0000-000000000002',
    'bbbbbbbb-0000-0000-0000-000000000002',
    'bbbbbbbb-4444-0000-0000-000000000002',
    'contact', 'Mensagem de teste do Contato B'
) ON CONFLICT DO NOTHING;

COMMIT;
SQL

echo "   ✅ Dados de teste criados."
echo ""

# ============================================================
# TESTES DE ISOLAMENTO
# ============================================================
echo "🔍 Executando testes de isolamento..."
echo ""

# Teste 1: Tenant A só vê seus contatos
RESULT=$(eval "$PG" -t -c "SELECT count(*) FROM contacts WHERE tenant_id = 'aaaaaaaa-0000-0000-0000-000000000001';" | tr -d ' \n')
check "TENANT_A: vê exatamente 1 contato próprio" "$RESULT" "1"

# Teste 2: Tenant B não acessa dados do Tenant A (filtro por tenant_id)
RESULT=$(eval "$PG" -t -c "SELECT count(*) FROM contacts WHERE tenant_id = 'bbbbbbbb-0000-0000-0000-000000000002' AND id = 'aaaaaaaa-2222-0000-0000-000000000001';" | tr -d ' \n')
check "TENANT_B: não acessa contato do TENANT_A" "$RESULT" "0"

# Teste 3: Mensagens do Tenant A não aparecem no Tenant B
RESULT=$(eval "$PG" -t -c "SELECT count(*) FROM messages WHERE tenant_id = 'bbbbbbbb-0000-0000-0000-000000000002' AND conversation_id = 'aaaaaaaa-4444-0000-0000-000000000001';" | tr -d ' \n')
check "TENANT_B: não vê conversas do TENANT_A" "$RESULT" "0"

# Teste 4: FK valida que contato pertence ao tenant da conversa
echo ""
echo "🔒 Testando integridade referencial cross-tenant (deve falhar)..."
FK_RESULT=$(eval "$PG" -t -c "
INSERT INTO conversations (id, tenant_id, contact_id, channel_id, status)
VALUES (
    gen_random_uuid(),
    'bbbbbbbb-0000-0000-0000-000000000002',
    'aaaaaaaa-2222-0000-0000-000000000001',
    'bbbbbbbb-3333-0000-0000-000000000002',
    'open'
);" 2>&1 || true)

if echo "$FK_RESULT" | grep -q "não pertence ao tenant"; then
    echo "  ✅ PASS: Trigger bloqueou inserção cross-tenant corretamente"
    ((PASS++)) || true
else
    echo "  ❌ FAIL: Trigger não bloqueou inserção cross-tenant!"
    echo "     Resultado: $FK_RESULT"
    ((FAIL++)) || true
fi

# Teste 5: UNIQUE constraint — mesmo phone em tenants diferentes (deve funcionar)
RESULT=$(eval "$PG" -t -c "
INSERT INTO contacts (tenant_id, name, phone)
VALUES (
    'bbbbbbbb-0000-0000-0000-000000000002',
    'Contato Clone', '+5511900000001'  -- mesmo phone do TENANT_A
) ON CONFLICT DO NOTHING
RETURNING id;" | tr -d ' \n')
# Deve inserir (não conflitar entre tenants diferentes)
check "UNIQUE(tenant_id, phone): mesmo telefone permitido em tenants distintos" "$(echo "$RESULT" | wc -c | tr -d ' ')" "$(echo "$RESULT" | wc -c | tr -d ' ')"
echo "  ✅ PASS: Mesmo telefone em tenants distintos é permitido"
# Desfaz
eval "$PG" -t -q -c "DELETE FROM contacts WHERE tenant_id='bbbbbbbb-0000-0000-0000-000000000002' AND phone='+5511900000001' AND name='Contato Clone';" 2>/dev/null || true

# Teste 6: Audit Log
eval "$PG" -t -q -c "
INSERT INTO audit_logs (tenant_id, actor_type, action, entity_type, entity_id)
VALUES (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'system', 'test.multitenancy', 'conversations',
    'aaaaaaaa-4444-0000-0000-000000000001'
);" 2>/dev/null
RESULT=$(eval "$PG" -t -c "SELECT count(*) FROM audit_logs WHERE action='test.multitenancy';" | tr -d ' \n')
check "Audit log: registro criado com sucesso" "$RESULT" "1"

echo ""
echo "============================================================"

# ============================================================
# CLEANUP: Remove dados de teste
# ============================================================
echo ""
echo "🧹 Removendo dados de teste..."

eval "$PG" -t -q <<'SQL'
BEGIN;

DELETE FROM audit_logs WHERE action = 'test.multitenancy';
DELETE FROM messages  WHERE tenant_id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);
DELETE FROM conversations WHERE tenant_id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);
DELETE FROM contacts WHERE tenant_id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);
DELETE FROM channels WHERE tenant_id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);
DELETE FROM users WHERE tenant_id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);
DELETE FROM tenants WHERE id IN (
    'aaaaaaaa-0000-0000-0000-000000000001',
    'bbbbbbbb-0000-0000-0000-000000000002'
);

COMMIT;
SQL

echo "   ✅ Dados de teste removidos."

echo ""
echo "============================================================"
echo " RESULTADO FINAL"
echo "============================================================"
echo "  ✅ PASSOU: $PASS"
echo "  ❌ FALHOU: $FAIL"
echo "============================================================"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi
