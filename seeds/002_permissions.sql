-- ============================================================
-- SDTech Soluctions — Seed 002
-- Permissões (permissions) fundamentais do MVP
-- ============================================================
-- Permissões mínimas para o fluxo WhatsApp → IA → Atendimento.
-- Novas permissões serão adicionadas em seeds futuras conforme
-- novos módulos forem implementados.
-- ============================================================

BEGIN;

INSERT INTO permissions (id, name, description)
VALUES
    -- Conversas
    (gen_random_uuid(), 'conversation.read',      'Visualizar conversas'),
    (gen_random_uuid(), 'conversation.send',      'Enviar mensagens em conversas'),
    (gen_random_uuid(), 'conversation.assign',    'Atribuir conversa a usuário ou agente'),
    (gen_random_uuid(), 'conversation.takeover',  'Assumir conversa de outro atendente ou agente'),
    (gen_random_uuid(), 'conversation.release',   'Liberar conversa (remover atribuição)'),
    (gen_random_uuid(), 'conversation.close',     'Encerrar conversa'),

    -- Contatos
    (gen_random_uuid(), 'contact.read',           'Visualizar contatos'),
    (gen_random_uuid(), 'contact.create',         'Criar novos contatos'),
    (gen_random_uuid(), 'contact.update',         'Editar dados de contatos'),

    -- Agentes IA
    (gen_random_uuid(), 'agent.use',              'Acionar agentes IA em conversas'),
    (gen_random_uuid(), 'agent.configure',        'Configurar agentes IA disponíveis no tenant'),

    -- Canais
    (gen_random_uuid(), 'channel.read',           'Visualizar canais configurados'),
    (gen_random_uuid(), 'channel.manage',         'Criar e configurar canais de comunicação'),

    -- Usuários
    (gen_random_uuid(), 'user.read',              'Visualizar usuários do tenant'),
    (gen_random_uuid(), 'user.manage',            'Criar, editar e desativar usuários'),

    -- Configurações
    (gen_random_uuid(), 'settings.read',          'Visualizar configurações do tenant'),
    (gen_random_uuid(), 'settings.manage',        'Editar configurações do tenant'),

    -- Auditoria
    (gen_random_uuid(), 'audit.read',             'Visualizar logs de auditoria')

ON CONFLICT (name) DO NOTHING;

COMMIT;
