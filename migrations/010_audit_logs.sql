-- ============================================================
-- SDTech Soluctions — Migration 010
-- Tabela: audit_logs
-- ============================================================
-- Registro imutável de eventos importantes do sistema.
-- Auditoria NÃO deve ser deletada junto com registros operacionais.
-- ON DELETE RESTRICT em todas as FKs.
--
-- actor_type: quem realizou a ação
--   user   = usuário humano do tenant
--   agent  = agente IA
--   system = processo automático/interno
--
-- Eventos esperados (não exaustivos):
--   tenant.created, tenant.suspended
--   user.created, user.login, user.logout
--   conversation.created, conversation.assigned
--   conversation.takeover, conversation.released, conversation.closed
--   agent.started, agent.completed, agent.transferred, agent.error
--   message.sent, message.received
--   settings.updated, channel.created, channel.updated
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS audit_logs (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id       UUID        REFERENCES tenants(id) ON DELETE RESTRICT,

    -- Quem realizou a ação
    -- Valores: user | agent | system
    actor_type      TEXT        NOT NULL
                    CHECK (actor_type IN ('user', 'agent', 'system')),

    -- ID do ator (NULL para system sem identidade)
    actor_id        UUID,

    -- Ação realizada (formato: entidade.ação)
    -- Ex: conversation.assigned, user.login, agent.transferred
    action          TEXT        NOT NULL,

    -- Entidade afetada
    entity_type     TEXT,
    entity_id       UUID,

    -- Dados contextuais do evento
    -- Ex: {"before": {...}, "after": {...}, "reason": "..."}
    metadata        JSONB       NOT NULL DEFAULT '{}',

    -- Imutável — sem updated_at
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_audit_logs_tenant_id
    ON audit_logs (tenant_id);

CREATE INDEX IF NOT EXISTS idx_audit_logs_tenant_created
    ON audit_logs (tenant_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_audit_logs_action
    ON audit_logs (action);

CREATE INDEX IF NOT EXISTS idx_audit_logs_entity
    ON audit_logs (entity_type, entity_id)
    WHERE entity_type IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_audit_logs_actor
    ON audit_logs (actor_type, actor_id)
    WHERE actor_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_audit_logs_tenant_action
    ON audit_logs (tenant_id, action, created_at DESC);

-- Comentários
COMMENT ON TABLE audit_logs IS 'Log de auditoria imutável de eventos do sistema. Nunca deletar.';
COMMENT ON COLUMN audit_logs.tenant_id IS 'NULL para eventos globais da plataforma (ex: tenant.created)';
COMMENT ON COLUMN audit_logs.action IS 'Formato: entidade.ação. Ex: conversation.assigned, user.login';
COMMENT ON COLUMN audit_logs.metadata IS 'Contexto do evento: estado antes/depois, motivo, IPs, etc.';

COMMIT;
