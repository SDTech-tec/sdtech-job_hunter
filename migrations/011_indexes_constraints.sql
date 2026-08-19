-- ============================================================
-- SDTech Soluctions — Migration 011
-- FKs pendentes, índices compostos finais e constraints adicionais
-- ============================================================
-- Esta migration finaliza relacionamentos que não puderam ser
-- declarados em migrations anteriores devido à ordem de criação
-- das tabelas (ex: conversations → agents).
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- FK pendente: conversations.assigned_agent_id → agents.id
-- Declarada aqui pois agents foi criada DEPOIS de conversations
-- ------------------------------------------------------------
ALTER TABLE conversations
    ADD CONSTRAINT fk_conversations_assigned_agent
    FOREIGN KEY (assigned_agent_id)
    REFERENCES agents(id)
    ON DELETE SET NULL;

-- ------------------------------------------------------------
-- Índices compostos adicionais de alta utilidade
-- ------------------------------------------------------------

-- Fila de atendimento: conversas abertas ordenadas por prioridade
CREATE INDEX IF NOT EXISTS idx_conversations_queue
    ON conversations (tenant_id, priority, last_message_at ASC NULLS LAST)
    WHERE status = 'open';

-- Mensagens recentes por tenant (dashboard)
CREATE INDEX IF NOT EXISTS idx_messages_tenant_recent
    ON messages (tenant_id, created_at DESC);

-- Agent sessions ativas por tenant
CREATE INDEX IF NOT EXISTS idx_agent_sessions_tenant_active
    ON agent_sessions (tenant_id, started_at DESC)
    WHERE status = 'active';

-- Audit logs por entidade específica (timeline de um contato, conversa, etc)
CREATE INDEX IF NOT EXISTS idx_audit_tenant_entity_time
    ON audit_logs (tenant_id, entity_type, entity_id, created_at DESC)
    WHERE entity_type IS NOT NULL AND entity_id IS NOT NULL;

-- ------------------------------------------------------------
-- Constraints de integridade de tenant (multi-tenancy safety)
-- ------------------------------------------------------------
-- Garante que contact_id e channel_id pertencem ao mesmo tenant
-- da conversation. Implementado via trigger (abaixo).
-- ------------------------------------------------------------

-- Trigger function: valida que contact pertence ao mesmo tenant
CREATE OR REPLACE FUNCTION check_conversation_tenant_integrity()
RETURNS TRIGGER AS $$
BEGIN
    -- Valida contact_id
    IF NOT EXISTS (
        SELECT 1 FROM contacts
        WHERE id = NEW.contact_id AND tenant_id = NEW.tenant_id
    ) THEN
        RAISE EXCEPTION 'contact_id % não pertence ao tenant %', NEW.contact_id, NEW.tenant_id;
    END IF;

    -- Valida channel_id
    IF NOT EXISTS (
        SELECT 1 FROM channels
        WHERE id = NEW.channel_id AND tenant_id = NEW.tenant_id
    ) THEN
        RAISE EXCEPTION 'channel_id % não pertence ao tenant %', NEW.channel_id, NEW.tenant_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_conversations_tenant_integrity
    BEFORE INSERT OR UPDATE ON conversations
    FOR EACH ROW
    EXECUTE FUNCTION check_conversation_tenant_integrity();

-- Trigger function: valida que message pertence ao tenant da conversation
CREATE OR REPLACE FUNCTION check_message_tenant_integrity()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM conversations
        WHERE id = NEW.conversation_id AND tenant_id = NEW.tenant_id
    ) THEN
        RAISE EXCEPTION 'conversation_id % não pertence ao tenant %', NEW.conversation_id, NEW.tenant_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_messages_tenant_integrity
    BEFORE INSERT ON messages
    FOR EACH ROW
    EXECUTE FUNCTION check_message_tenant_integrity();

-- Trigger function: auto-atualiza updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplica updated_at automático em todas as tabelas que possuem o campo
CREATE TRIGGER trg_tenants_updated_at
    BEFORE UPDATE ON tenants
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_contacts_updated_at
    BEFORE UPDATE ON contacts
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_channels_updated_at
    BEFORE UPDATE ON channels
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_conversations_updated_at
    BEFORE UPDATE ON conversations
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_agents_updated_at
    BEFORE UPDATE ON agents
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMIT;
