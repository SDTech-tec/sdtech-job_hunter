-- ============================================================
-- SDTech Soluctions — Seed 001
-- Papéis (roles) iniciais do sistema
-- ============================================================
-- Papéis são criados pela SDTech e marcados como is_system=true.
-- NÃO devem ser editados ou removidos pelo tenant.
--
-- Papéis previstos:
--   platform_admin — ADM Master da SDTech (uso transversal)
--   owner          — Dono da conta do tenant
--   admin          — Administrador do tenant
--   manager        — Gerente operacional
--   attendant      — Atendente (acesso básico)
-- ============================================================

BEGIN;

INSERT INTO roles (id, name, description, is_system)
VALUES
    (gen_random_uuid(), 'platform_admin', 'ADM Master da SDTech. Acesso transversal à plataforma.', true),
    (gen_random_uuid(), 'owner',          'Proprietário da conta do tenant. Acesso completo ao tenant.', true),
    (gen_random_uuid(), 'admin',          'Administrador do tenant. Gerencia usuários e configurações.', true),
    (gen_random_uuid(), 'manager',        'Gerente operacional. Supervisiona atendimentos e relatórios.', true),
    (gen_random_uuid(), 'attendant',      'Atendente. Acesso às conversas e contatos atribuídos.', true)
ON CONFLICT (name) DO NOTHING;

COMMIT;
