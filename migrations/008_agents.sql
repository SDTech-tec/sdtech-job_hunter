-- ============================================================
-- SDTech Soluctions — Migration 008
-- Tabela: agents
-- ============================================================
-- Agentes de IA disponibilizados pela SDTech para os tenants.
--
-- REGRA DE NEGÓCIO CRÍTICA:
--   Agentes são criados/gerenciados pela SDTech.
--   O tenant NÃO possui liberdade irrestrita para criar agentes.
--   A arquitetura permite futuramente:
--     - Relacionar agentes com módulos/planos contratados
--     - Controlar quais tenants têm acesso a quais agentes
--     - Versionar agentes por tenant
--
-- is_platform_agent: true = agente base da SDTech (não editável
--   pelo tenant). false = customização futura do tenant.
--
-- tenant_id: NULLABLE para agentes globais da plataforma.
--   Um agente global pode ser compartilhado entre tenants.
--   Um agente específico pertence a um tenant.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS agents (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),

    -- NULL = agente global da plataforma SDTech
    -- NOT NULL = agente específico de um tenant
    tenant_id           UUID        REFERENCES tenants(id) ON DELETE RESTRICT,

    name                TEXT        NOT NULL,

    -- Tipo do agente
    -- V1.0: supervisor | receptionist
    -- Reservado: sales | support | real_estate_sales
    type                TEXT        NOT NULL
                        CHECK (type IN (
                            'supervisor', 'receptionist',
                            'sales', 'support', 'real_estate_sales'
                        )),

    description         TEXT,

    -- Status do agente
    -- Valores: active | inactive | maintenance
    status              TEXT        NOT NULL DEFAULT 'active'
                        CHECK (status IN ('active', 'inactive', 'maintenance')),

    -- Agente gerenciado pela SDTech (não editável pelo tenant)
    is_platform_agent   BOOLEAN     NOT NULL DEFAULT true,

    -- Configurações do agente (prompts, parâmetros, etc)
    -- Dados não-sensíveis apenas
    configuration       JSONB       NOT NULL DEFAULT '{}',

    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_agents_tenant_id
    ON agents (tenant_id)
    WHERE tenant_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_agents_type
    ON agents (type);

CREATE INDEX IF NOT EXISTS idx_agents_status
    ON agents (status);

CREATE INDEX IF NOT EXISTS idx_agents_platform
    ON agents (is_platform_agent);

CREATE INDEX IF NOT EXISTS idx_agents_tenant_type
    ON agents (tenant_id, type)
    WHERE tenant_id IS NOT NULL;

-- Comentários
COMMENT ON TABLE agents IS 'Agentes de IA disponibilizados pela SDTech aos tenants';
COMMENT ON COLUMN agents.tenant_id IS 'NULL = agente global da plataforma. NOT NULL = agente de tenant específico.';
COMMENT ON COLUMN agents.type IS 'supervisor | receptionist | sales | support | real_estate_sales';
COMMENT ON COLUMN agents.is_platform_agent IS 'true = gerenciado pela SDTech, não editável pelo tenant';
COMMENT ON COLUMN agents.configuration IS 'Parâmetros não-sensíveis do agente. Secrets via vault.';

COMMIT;
