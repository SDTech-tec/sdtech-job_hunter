-- ============================================================
-- SDTech Soluctions — Migration 007
-- Tabela: messages
-- ============================================================
-- Mensagens são imutáveis após criação (sem updated_at).
-- Histórico de auditoria deve ser preservado mesmo se a
-- conversa ou contato for removido — ON DELETE RESTRICT.
--
-- sender_type: identifica quem enviou
--   contact  = cliente externo
--   user     = atendente humano do tenant
--   agent    = agente IA da SDTech
--   system   = mensagem automática do sistema
--
-- external_message_id: ID da mensagem no canal externo
--   Ex: message ID do WhatsApp via Evolution API
--   Usado para deduplicação e rastreamento
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS messages (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID        NOT NULL REFERENCES tenants(id) ON DELETE RESTRICT,
    conversation_id     UUID        NOT NULL REFERENCES conversations(id) ON DELETE RESTRICT,

    -- Quem enviou
    -- Valores: contact | user | agent | system
    sender_type         TEXT        NOT NULL
                        CHECK (sender_type IN ('contact', 'user', 'agent', 'system')),

    -- ID do remetente (NULL para system)
    -- Referência lógica — não FK estrita (sender pode ser de tabelas diferentes)
    sender_id           UUID,

    -- Tipo do conteúdo
    -- Valores: text | image | audio | video | document | location | system
    message_type        TEXT        NOT NULL DEFAULT 'text'
                        CHECK (message_type IN (
                            'text', 'image', 'audio', 'video',
                            'document', 'location', 'system'
                        )),

    -- Conteúdo textual (URL para mídia, texto para text/system)
    content             TEXT,

    -- Metadados variáveis (caption, duration, coordinates, etc)
    metadata            JSONB       NOT NULL DEFAULT '{}',

    -- ID da mensagem no canal externo (ex: WhatsApp message ID)
    external_message_id TEXT,

    -- Mensagens são imutáveis — sem updated_at
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_messages_tenant_id
    ON messages (tenant_id);

CREATE INDEX IF NOT EXISTS idx_messages_conversation_id
    ON messages (conversation_id);

CREATE INDEX IF NOT EXISTS idx_messages_tenant_conversation
    ON messages (tenant_id, conversation_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_messages_sender
    ON messages (sender_type, sender_id)
    WHERE sender_id IS NOT NULL;

-- Índice para deduplicação via external_message_id
CREATE INDEX IF NOT EXISTS idx_messages_external_id
    ON messages (external_message_id)
    WHERE external_message_id IS NOT NULL;

-- Unique para evitar mensagens duplicadas por conversa
CREATE UNIQUE INDEX IF NOT EXISTS uq_messages_external_per_conversation
    ON messages (conversation_id, external_message_id)
    WHERE external_message_id IS NOT NULL;

-- GIN para queries em metadata
CREATE INDEX IF NOT EXISTS idx_messages_metadata
    ON messages USING GIN (metadata);

-- Comentários
COMMENT ON TABLE messages IS 'Mensagens trocadas em conversas. Imutáveis após inserção.';
COMMENT ON COLUMN messages.sender_type IS 'contact | user | agent | system';
COMMENT ON COLUMN messages.sender_id IS 'ID lógico do remetente. Referência ao tenant_id da entidade.';
COMMENT ON COLUMN messages.external_message_id IS 'ID da mensagem no canal externo (ex: WhatsApp via Evolution API)';
COMMENT ON COLUMN messages.metadata IS 'Dados variáveis: caption, duration, mime_type, coordinates, etc.';

COMMIT;
