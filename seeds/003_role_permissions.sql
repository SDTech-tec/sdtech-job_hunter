-- ============================================================
-- SDTech Soluctions — Seed 003
-- Associação Roles × Permissions
-- ============================================================
-- Define quais permissões cada papel possui por padrão.
-- Usa subqueries para referenciar IDs por nome (idempotente).
-- ============================================================

BEGIN;

-- platform_admin: todas as permissões
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.name = 'platform_admin'
ON CONFLICT DO NOTHING;

-- owner: todas exceto platform-level
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.name = 'owner'
  AND p.name IN (
    'conversation.read', 'conversation.send', 'conversation.assign',
    'conversation.takeover', 'conversation.release', 'conversation.close',
    'contact.read', 'contact.create', 'contact.update',
    'agent.use', 'agent.configure',
    'channel.read', 'channel.manage',
    'user.read', 'user.manage',
    'settings.read', 'settings.manage',
    'audit.read'
  )
ON CONFLICT DO NOTHING;

-- admin: gestão completa do tenant, sem audit
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.name = 'admin'
  AND p.name IN (
    'conversation.read', 'conversation.send', 'conversation.assign',
    'conversation.takeover', 'conversation.release', 'conversation.close',
    'contact.read', 'contact.create', 'contact.update',
    'agent.use', 'agent.configure',
    'channel.read', 'channel.manage',
    'user.read', 'user.manage',
    'settings.read', 'settings.manage',
    'audit.read'
  )
ON CONFLICT DO NOTHING;

-- manager: supervisão operacional, sem gestão de usuários/config
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.name = 'manager'
  AND p.name IN (
    'conversation.read', 'conversation.send', 'conversation.assign',
    'conversation.takeover', 'conversation.release', 'conversation.close',
    'contact.read', 'contact.create', 'contact.update',
    'agent.use',
    'channel.read',
    'user.read',
    'settings.read'
  )
ON CONFLICT DO NOTHING;

-- attendant: atendimento básico
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.name = 'attendant'
  AND p.name IN (
    'conversation.read', 'conversation.send',
    'conversation.release',
    'contact.read', 'contact.update',
    'agent.use'
  )
ON CONFLICT DO NOTHING;

COMMIT;
