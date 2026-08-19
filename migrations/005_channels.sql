-- ============================================================
-- SDTech Soluctions — Migration 005
-- Tabela: channels
-- ============================================================
-- Canais de comunicação disponíveis para cada tenant.
-- V1.0: foco em whatsapp. Estrutura extensível para demais.
--
-- SEGURANÇA:
--   config JSONB NÃO deve armazenar tokens/secrets em texto puro.
--   Tokens sensíveis devem ser referenciados por ID de um vault
--   externo (ex: Secrets Manager, variáveis de ambiente do n8n).
--   Documentar como pendência de segurança até vault ser definido.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS channels (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id   UUID        NOT NULL REFERENCES tenants(id) ON DELETE RESTRICT,

    -- Tipo do canal
    -- V1.0 obrigatório: whatsapp
    -- Reservado: instagram | telegram | webchat
    type        TEXT        NOT NULL
                CHECK (type IN ('whatsapp', 'instagram', 'telegram', 'webchat')),

    name        TEXT        NOT NULL,

    -- Status do canal
    -- Valores: active | inactive | error
    status      TEXT        NOT NULL DEFAULT 'active'
                CHECK (status IN ('active', 'inactive', 'error')),

    -- Configurações do canal (NÃO armazenar secrets aqui)
    -- Use referências a IDs de vault ou envvar keys
    -- Ex: {"instance_name": "empresa-wpp", "webhook_url": "..."}
    config      JSONB       NOT NULL DEFAULT '{}',

    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_channels_tenant_id
    ON channels (tenant_id);

CREATE INDEX IF NOT EXISTS idx_channels_tenant_type
    ON channels (tenant_id, type);

CREATE INDEX IF NOT EXISTS idx_channels_tenant_status
    ON channels (tenant_id, status);

-- Comentários
COMMENT ON TABLE channels IS 'Canais de comunicação (WhatsApp, Instagram, etc) por tenant';
COMMENT ON COLUMN channels.type IS 'whatsapp | instagram | telegram | webchat';
COMMENT ON COLUMN channels.config IS 'Config não-sensível do canal. Tokens/secrets via vault externo.';

COMMIT;
