-- ============================================================
-- SDTech Soluctions — Migration 009
-- Tabela: agent_sessions
-- ============================================================
-- Registra a atuação de agentes IA em conversas.
-- Permite auditoria completa do ciclo:
--   Supervisor → Recepcionista → Supervisor → Humano
--
-- Uma conversa pode ter múltiplas sessões de agente ao longo
-- do tempo (handoffs, retomadas, etc).
--
-- ON DELETE em conversation_id: RESTRICT
--   Histórico de atuação do agente é auditoria — não deve ser
--   perdido mesmo se a conversa for encerrada/arquivada.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS agent_sessions (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID        NOT NULL REFERENCES tenants(id) ON DELETE RESTRICT,
    conversation_id     UUID        NOT NULL REFERENCES conversations(id) ON DELETE RESTRICT,
    agent_id            UUID        NOT NULL REFERENCES agents(id) ON DELETE RESTRICT,

    started_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at            TIMESTAMPTZ,

    -- Status da sessão
    -- Valores: active | completed | transferred | error
    status              TEXT        NOT NULL DEFAULT 'active'
                        CHECK (status IN ('active', 'completed', 'transferred', 'error')),

    -- Metadados da sessão (tokens usados, raciocínio, handoff info)
    metadata            JSONB       NOT NULL DEFAULT '{}'
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_agent_sessions_tenant_id
    ON agent_sessions (tenant_id);

CREATE INDEX IF NOT EXISTS idx_agent_sessions_conversation_id
    ON agent_sessions (conversation_id);

CREATE INDEX IF NOT EXISTS idx_agent_sessions_agent_id
    ON agent_sessions (agent_id);

CREATE INDEX IF NOT EXISTS idx_agent_sessions_tenant_conversation
    ON agent_sessions (tenant_id, conversation_id, started_at DESC);

CREATE INDEX IF NOT EXISTS idx_agent_sessions_status
    ON agent_sessions (status);

CREATE INDEX IF NOT EXISTS idx_agent_sessions_active
    ON agent_sessions (conversation_id, started_at DESC)
    WHERE status = 'active';

-- Comentários
COMMENT ON TABLE agent_sessions IS 'Sessões de agentes IA em conversas. Registra ciclo Supervisor→Recepcionista→Humano.';
COMMENT ON COLUMN agent_sessions.status IS 'active | completed | transferred | error';
COMMENT ON COLUMN agent_sessions.metadata IS 'Dados da sessão: tokens, raciocínio, motivo do handoff, etc.';

COMMIT;
