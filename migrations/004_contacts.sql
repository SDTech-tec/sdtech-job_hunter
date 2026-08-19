-- ============================================================
-- SDTech Soluctions — Migration 004
-- Tabela: contacts
-- ============================================================
-- Contatos são clientes/leads de um tenant específico.
-- Acesso cruzado entre tenants é PROIBIDO.
-- phone: obrigatório (canal principal via WhatsApp)
-- email: opcional, indexado quando presente
-- metadata: dados variáveis (histórico, tags, origem, etc)
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS contacts (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id   UUID        NOT NULL REFERENCES tenants(id) ON DELETE RESTRICT,
    name        TEXT        NOT NULL,
    email       TEXT,
    phone       TEXT        NOT NULL,

    -- Status do contato
    -- Valores: active | blocked | archived
    status      TEXT        NOT NULL DEFAULT 'active'
                CHECK (status IN ('active', 'blocked', 'archived')),

    -- Dados variáveis: tags, origem, campos customizados, etc
    metadata    JSONB       NOT NULL DEFAULT '{}',

    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),

    -- Telefone único por tenant (evitar duplicidade)
    CONSTRAINT uq_contacts_tenant_phone UNIQUE (tenant_id, phone)
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_contacts_tenant_id
    ON contacts (tenant_id);

CREATE INDEX IF NOT EXISTS idx_contacts_phone
    ON contacts (phone);

CREATE INDEX IF NOT EXISTS idx_contacts_email
    ON contacts (email)
    WHERE email IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_contacts_tenant_status
    ON contacts (tenant_id, status);

CREATE INDEX IF NOT EXISTS idx_contacts_tenant_created
    ON contacts (tenant_id, created_at DESC);

-- GIN index para queries em metadata JSONB
CREATE INDEX IF NOT EXISTS idx_contacts_metadata
    ON contacts USING GIN (metadata);

-- Comentários
COMMENT ON TABLE contacts IS 'Contatos (clientes/leads) de cada tenant';
COMMENT ON COLUMN contacts.phone IS 'Telefone principal. Obrigatório. Único por tenant.';
COMMENT ON COLUMN contacts.metadata IS 'Dados variáveis: tags, origem, campos customizados pelo tenant';

COMMIT;
