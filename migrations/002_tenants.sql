-- ============================================================
-- SDTech Soluctions — Migration 002
-- Tabela: tenants
-- ============================================================
-- Entidade central do sistema multi-tenant.
-- Cada tenant representa uma empresa/cliente da SDTech.
--
-- DECISÃO ARQUITETURAL:
--   tenant_code: campo para o identificador externo/público do
--   tenant, formado por hash de: sdtech + data_inicio +
--   nome_empresa + sequencial(5 dígitos).
--   O algoritmo definitivo de hash ainda será especificado pela
--   SDTech. O campo é reservado agora com UNIQUE constraint.
--   NÃO usar tenant_code como FK interna — usar id (UUID).
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS tenants (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Identificador externo/público (hash a definir pela SDTech)
    -- Formato conceitual: sdtech + data_inicio + nome + seq(5)
    -- PENDENTE: algoritmo de hash definitivo
    tenant_code     TEXT        UNIQUE,

    name            TEXT        NOT NULL,
    legal_name      TEXT,

    -- Status do tenant
    -- Valores permitidos: active | suspended | inactive
    status          TEXT        NOT NULL DEFAULT 'active'
                    CHECK (status IN ('active', 'suspended', 'inactive')),

    timezone        TEXT        NOT NULL DEFAULT 'America/Sao_Paulo',

    -- Metadados adicionais para uso futuro (ex: plan, features)
    metadata        JSONB       NOT NULL DEFAULT '{}',

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_tenants_status
    ON tenants (status);

CREATE INDEX IF NOT EXISTS idx_tenants_tenant_code
    ON tenants (tenant_code)
    WHERE tenant_code IS NOT NULL;

-- Comentários
COMMENT ON TABLE tenants IS 'Tenants (empresas/clientes) do SDTech Soluctions';
COMMENT ON COLUMN tenants.id IS 'UUID interno — chave primária, uso interno apenas';
COMMENT ON COLUMN tenants.tenant_code IS 'Identificador externo/público. Hash de: sdtech+data+nome+seq. Algoritmo pendente.';
COMMENT ON COLUMN tenants.legal_name IS 'Razão social da empresa';
COMMENT ON COLUMN tenants.status IS 'active | suspended | inactive';
COMMENT ON COLUMN tenants.metadata IS 'Dados adicionais variáveis do tenant (plano, features, etc)';

COMMIT;
