-- ============================================================
-- SDTech Soluctions — Migration 006
-- Tabela: conversations
-- ============================================================
-- Conversa é o elo central entre contato, canal, agentes e
-- mensagens. Toda interação ocorre dentro de uma conversa.
--
-- assigned_agent_id: FK para agents (criada após 008_agents)
--   Definida aqui como coluna sem FK; a FK é adicionada em
--   011_indexes_constraints.sql após agents existir.
--
-- ON DELETE nas FKs críticas: RESTRICT
--   Conversas são registros de negócio — não devem ser perdidas
--   ao remover usuário/agente. Usar SET NULL quando aplicável.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS conversations (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID        NOT NULL REFERENCES tenants(id) ON DELETE RESTRICT,
    contact_id          UUID        NOT NULL REFERENCES contacts(id) ON DELETE RESTRICT,
    channel_id          UUID        NOT NULL REFERENCES channels(id) ON DELETE RESTRICT,

    -- Status da conversa
    -- Valores: open | pending | resolved | closed
    status              TEXT        NOT NULL DEFAULT 'open'
                        CHECK (status IN ('open', 'pending', 'resolved', 'closed')),

    -- Usuário humano responsável (NULL = não atribuído)
    assigned_user_id    UUID        REFERENCES users(id) ON DELETE SET NULL,

    -- Agente IA responsável (FK adicionada em 011 após agents)
    assigned_agent_id   UUID,

    -- IA habilitada nesta conversa
    ai_enabled          BOOLEAN     NOT NULL DEFAULT true,

    -- Prioridade da conversa
    -- Valores: low | normal | high | urgent
    priority            TEXT        NOT NULL DEFAULT 'normal'
                        CHECK (priority IN ('low', 'normal', 'high', 'urgent')),

    -- Timestamp da última mensagem (para ordenação de fila)
    last_message_at     TIMESTAMPTZ,

    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    closed_at           TIMESTAMPTZ
);

-- Índices principais
CREATE INDEX IF NOT EXISTS idx_conversations_tenant_id
    ON conversations (tenant_id);

CREATE INDEX IF NOT EXISTS idx_conversations_tenant_status
    ON conversations (tenant_id, status);

CREATE INDEX IF NOT EXISTS idx_conversations_tenant_contact
    ON conversations (tenant_id, contact_id);

CREATE INDEX IF NOT EXISTS idx_conversations_contact_id
    ON conversations (contact_id);

CREATE INDEX IF NOT EXISTS idx_conversations_channel_id
    ON conversations (channel_id);

CREATE INDEX IF NOT EXISTS idx_conversations_assigned_user
    ON conversations (assigned_user_id)
    WHERE assigned_user_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_conversations_assigned_agent
    ON conversations (assigned_agent_id)
    WHERE assigned_agent_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_conversations_last_message
    ON conversations (tenant_id, last_message_at DESC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_conversations_open_queue
    ON conversations (tenant_id, created_at DESC)
    WHERE status = 'open';

-- Comentários
COMMENT ON TABLE conversations IS 'Conversas entre contatos e o tenant via canais de comunicação';
COMMENT ON COLUMN conversations.assigned_agent_id IS 'FK para agents.id adicionada em 011_indexes_constraints.sql';
COMMENT ON COLUMN conversations.ai_enabled IS 'Controla se IA está ativa nesta conversa específica';
COMMENT ON COLUMN conversations.last_message_at IS 'Atualizado a cada nova mensagem. Usado para ordenar fila.';

COMMIT;
