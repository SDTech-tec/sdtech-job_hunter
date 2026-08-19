-- ============================================================
-- SDTech Soluctions — Migration 003
-- Tabelas: users, roles, permissions, user_roles, role_permissions
-- ============================================================
-- RBAC (Role-Based Access Control) do sistema.
--
-- DECISÃO ARQUITETURAL — is_platform_admin:
--   Campo booleano para marcar o ADM Master da SDTech.
--   Permite que um usuário exista além do contexto de um tenant
--   comum, com acesso transversal à plataforma.
--   A lógica de autorização deverá verificar este campo
--   ANTES de avaliar tenant_id.
--   Futuramente, o role 'platform_admin' será reservado
--   na tabela roles para complementar esta funcionalidade.
--
-- email: único POR TENANT (não globalmente único).
--   Um mesmo email pode existir em tenants diferentes.
--
-- ON DELETE em tenant_id: RESTRICT
--   Não apagar usuários em cascata ao apagar tenant.
--   Tenant deve ser desativado (status=inactive), não deletado.
-- ============================================================

BEGIN;

-- ------------------------------------------------------------
-- ROLES
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS roles (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    name        TEXT    NOT NULL UNIQUE,
    description TEXT,
    is_system   BOOLEAN NOT NULL DEFAULT false,  -- papel criado pela SDTech
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE roles IS 'Papéis de acesso do RBAC';
COMMENT ON COLUMN roles.is_system IS 'true = papel gerenciado pela SDTech, não editável pelo tenant';

-- ------------------------------------------------------------
-- PERMISSIONS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS permissions (
    id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
    name        TEXT    NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE permissions IS 'Permissões individuais do RBAC';

-- ------------------------------------------------------------
-- USERS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID        REFERENCES tenants(id) ON DELETE RESTRICT,
    name                TEXT        NOT NULL,
    email               TEXT        NOT NULL,
    phone               TEXT,
    password_hash       TEXT        NOT NULL,

    -- Status do usuário
    -- Valores: active | inactive | suspended
    status              TEXT        NOT NULL DEFAULT 'active'
                        CHECK (status IN ('active', 'inactive', 'suspended')),

    -- ADM Master da SDTech: acesso transversal à plataforma
    -- PENDENTE: definir escopo completo de autorização platform_admin
    is_platform_admin   BOOLEAN     NOT NULL DEFAULT false,

    last_login_at       TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

    -- Email único por tenant
    -- Platform admins podem ter tenant_id NULL
    CONSTRAINT uq_users_tenant_email UNIQUE (tenant_id, email)
);

COMMENT ON TABLE users IS 'Usuários do SDTech Soluctions';
COMMENT ON COLUMN users.tenant_id IS 'NULL apenas para platform_admins da SDTech';
COMMENT ON COLUMN users.is_platform_admin IS 'ADM Master SDTech: acesso transversal. Algoritmo de autorização pendente.';
COMMENT ON COLUMN users.password_hash IS 'Hash bcrypt da senha. Nunca armazenar senha em texto puro.';

-- Índices de users
CREATE INDEX IF NOT EXISTS idx_users_tenant_id
    ON users (tenant_id);

CREATE INDEX IF NOT EXISTS idx_users_email
    ON users (email);

CREATE INDEX IF NOT EXISTS idx_users_tenant_status
    ON users (tenant_id, status);

CREATE INDEX IF NOT EXISTS idx_users_platform_admin
    ON users (is_platform_admin)
    WHERE is_platform_admin = true;

-- ------------------------------------------------------------
-- USER_ROLES (N:N)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_roles (
    user_id     UUID    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id     UUID    NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    granted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    granted_by  UUID    REFERENCES users(id) ON DELETE SET NULL,

    PRIMARY KEY (user_id, role_id)
);

COMMENT ON TABLE user_roles IS 'Associação N:N entre usuários e papéis';

-- ------------------------------------------------------------
-- ROLE_PERMISSIONS (N:N)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id         UUID    NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    permission_id   UUID    NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,

    PRIMARY KEY (role_id, permission_id)
);

COMMENT ON TABLE role_permissions IS 'Associação N:N entre papéis e permissões';

COMMIT;
