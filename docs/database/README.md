# SDTech Soluctions — Banco de Dados V1.0

## Visão Geral

O banco de dados do **SDTech Soluctions** é o repositório central de dados para o sistema de atendimento inteligente via WhatsApp com IA.

**Stack:** PostgreSQL 16  
**Banco:** `sdtech_soluctions`  
**Arquitetura:** Multi-tenant, com isolamento por `tenant_id`

---

## Arquitetura

```
WhatsApp
    ↓
Evolution API
    ↓
n8n (orquestração)
    ↓
Supervisor IA → Recepcionista IA
    ↓
PostgreSQL (sdtech_soluctions)
```

### Princípios

- **Multi-tenancy:** toda entidade operacional possui `tenant_id`
- **UUID como PK:** entidades principais usam `gen_random_uuid()`
- **Timestamps com timezone:** `TIMESTAMPTZ` em todos os campos de data
- **Imutabilidade:** `messages` e `audit_logs` não possuem `updated_at`
- **Menor privilégio:** usuário de aplicação sem superuser
- **JSONB para dados variáveis:** `metadata`, `config`, `configuration`

---

## Banco de Dados

| Propriedade | Valor |
|-------------|-------|
| Engine | PostgreSQL 16 |
| Banco | `sdtech_soluctions` |
| Encoding | UTF-8 |
| Timezone padrão | `America/Sao_Paulo` |
| Extensões | `pgcrypto` |

---

## Tabelas

| Tabela | Descrição |
|--------|-----------|
| `tenants` | Empresas/clientes da SDTech |
| `users` | Usuários vinculados a tenants |
| `roles` | Papéis de acesso (RBAC) |
| `permissions` | Permissões individuais |
| `user_roles` | Associação usuário × papel (N:N) |
| `role_permissions` | Associação papel × permissão (N:N) |
| `contacts` | Contatos/clientes por tenant |
| `channels` | Canais de comunicação por tenant |
| `conversations` | Conversas entre contatos e tenant |
| `messages` | Mensagens de conversas |
| `agents` | Agentes de IA da plataforma |
| `agent_sessions` | Sessões de agentes em conversas |
| `audit_logs` | Log de auditoria imutável |
| `schema_migrations` | Controle de migrations aplicadas |

---

## Relacionamentos

```
tenants
  ├── users (tenant_id → tenants.id)
  ├── contacts (tenant_id → tenants.id)
  ├── channels (tenant_id → tenants.id)
  ├── conversations (tenant_id → tenants.id)
  │     ├── contact_id → contacts.id
  │     ├── channel_id → channels.id
  │     ├── assigned_user_id → users.id
  │     └── assigned_agent_id → agents.id
  ├── messages (tenant_id → tenants.id)
  │     └── conversation_id → conversations.id
  ├── agents (tenant_id → tenants.id, nullable)
  ├── agent_sessions (tenant_id → tenants.id)
  │     ├── conversation_id → conversations.id
  │     └── agent_id → agents.id
  └── audit_logs (tenant_id → tenants.id, nullable)

users
  ├── user_roles (user_id → users.id)
  └── user_roles.role_id → roles.id → role_permissions → permissions
```

---

## Usuários do Banco

| Usuário | Papel | Permissões |
|---------|-------|-----------|
| `postgres` | Superuser | Apenas para manutenção crítica |
| `sdtech_owner` | Owner do banco | CREATE, migrations, DDL |
| `sdtech_app` | Aplicação | SELECT, INSERT, UPDATE, DELETE apenas |

> **Regra:** Nenhuma aplicação (n8n, Evolution API) usa o usuário `postgres`.

---

## Migrations

Aplicadas em ordem sequencial via `make db-migrate`.

| Migration | Descrição |
|-----------|-----------|
| `001_extensions.sql` | Extensão `pgcrypto` |
| `002_tenants.sql` | Tabela tenants |
| `003_users_rbac.sql` | users, roles, permissions, user_roles, role_permissions |
| `004_contacts.sql` | Tabela contacts |
| `005_channels.sql` | Tabela channels |
| `006_conversations.sql` | Tabela conversations |
| `007_messages.sql` | Tabela messages |
| `008_agents.sql` | Tabela agents |
| `009_agent_sessions.sql` | Tabela agent_sessions |
| `010_audit_logs.sql` | Tabela audit_logs |
| `011_indexes_constraints.sql` | FK pendentes, índices, triggers |

---

## Seeds

| Seed | Descrição |
|------|-----------|
| `001_roles.sql` | Papéis: platform_admin, owner, admin, manager, attendant |
| `002_permissions.sql` | 18 permissões fundamentais do MVP |
| `003_role_permissions.sql` | Matriz de permissões por papel |

---

## Índices

### Simples
- `tenants`: `status`, `tenant_code`
- `users`: `tenant_id`, `email`, `(tenant_id, status)`, `is_platform_admin`
- `contacts`: `tenant_id`, `phone`, `email`, `(tenant_id, status)`, `(tenant_id, created_at)`
- `channels`: `tenant_id`, `(tenant_id, type)`, `(tenant_id, status)`
- `conversations`: `tenant_id`, `(tenant_id, status)`, `contact_id`, `channel_id`, `last_message_at`
- `messages`: `tenant_id`, `conversation_id`, `(tenant_id, conversation_id, created_at)`
- `agents`: `tenant_id`, `type`, `status`
- `agent_sessions`: `tenant_id`, `conversation_id`, `agent_id`, `status`
- `audit_logs`: `tenant_id`, `(tenant_id, created_at)`, `action`, `(entity_type, entity_id)`

### Parciais (WHERE clause)
- Conversas abertas: `WHERE status = 'open'`
- Sessões ativas: `WHERE status = 'active'`
- Platform admins: `WHERE is_platform_admin = true`
- Mensagens com external_id: `WHERE external_message_id IS NOT NULL`

---

## Constraints

| Constraint | Tabela | Descrição |
|-----------|--------|-----------|
| `uq_tenants_tenant_code` | tenants | Código externo único |
| `uq_users_tenant_email` | users | Email único por tenant |
| `uq_contacts_tenant_phone` | contacts | Telefone único por tenant |
| `uq_messages_external_per_conversation` | messages | external_message_id único por conversa |
| `CHECK status` | todas | Valores permitidos por domínio |
| `trg_conversations_tenant_integrity` | conversations | Bloqueia cross-tenant |
| `trg_messages_tenant_integrity` | messages | Bloqueia cross-tenant |
| `trg_*_updated_at` | múltiplas | Auto-atualiza updated_at |

---

## Segurança

1. **Menor privilégio:** `sdtech_app` possui apenas DML, sem DDL
2. **Isolamento de tenant:** triggers bloqueiam inserções cross-tenant
3. **Sem secrets no banco:** `config` e `configuration` referenciam vault externo
4. **Auditoria imutável:** `audit_logs` sem UPDATE/DELETE
5. **Senhas hasheadas:** `users.password_hash` (bcrypt — responsabilidade da aplicação)

---

## Backup

```bash
# Backup manual
make db-backup

# Arquivo gerado em: ./backups/sdtech_soluctions_YYYYMMDD_HHMMSS.dump
# Retenção padrão: 30 dias
```

### Estratégia de backup em produção

| Tipo | Frequência | Retenção |
|------|-----------|---------|
| Full | Diário | 30 dias |
| WAL archiving | Contínuo | 7 dias |

> ⚠️ **REGRA ABSOLUTA:** Executar `make db-backup` antes de qualquer migration em produção.

---

## Restore

```bash
# Listar backups disponíveis
ls ./backups/

# Restaurar
make db-restore FILE=./backups/sdtech_soluctions_20260819_000000.dump
```

---

## Comandos

```bash
make help           # Lista todos os comandos
make setup          # Setup completo (Docker + migrate + seed)
make db-up          # Inicia PostgreSQL local
make db-down        # Para PostgreSQL local
make db-create      # Cria banco e usuários
make db-migrate     # Aplica migrations
make db-seed        # Aplica seeds
make db-backup      # Backup
make db-restore     # Restore
make db-status      # Status
make db-rollback    # Orientação de rollback
make test           # Executa todos os testes
make test-mt        # Teste de multi-tenancy
```

---

## Troubleshooting

### Conexão recusada
```bash
# Verificar se container está rodando
docker ps | grep sdtech-soluctions-postgres

# Ver logs
make db-logs
```

### Migration falhou
```bash
# Ver estado atual
make db-status

# A migration com erro NÃO será registrada em schema_migrations
# Corrija o erro e re-execute make db-migrate
```

### Erro de permissão
```bash
# Verificar usuário configurado no .env
grep DB_USER .env

# Reconectar como owner para verificar grants
psql -h localhost -p 5434 -U sdtech_owner -d sdtech_soluctions
\dp  -- lista permissões das tabelas
```

### Dados de teste em produção
```bash
# Verificar tenants de teste
SELECT id, name FROM tenants WHERE name LIKE '%TESTE%';

# Se encontrar, remover via scripts/test-multitenancy.sh (cleanup)
```

---

## Pendências Documentadas

| Item | Status | Descrição |
|------|--------|-----------|
| `tenant_code` hash | ⏳ Pendente | Algoritmo definitivo a definir pela SDTech |
| `is_platform_admin` escopo | ⏳ Pendente | Lógica de autorização platform_admin a definir |
| Vault para secrets | ⏳ Pendente | Config de canal sem secrets em texto puro |
| WAL archiving | ⏳ Pendente | Backup contínuo em produção |

---

## Próximos Passos

1. **Aplicar no servidor:** Conectar VPS e executar `make setup`
2. **N8N Core:** Configurar workflows com usuário `sdtech_app`
3. **Evolution API:** Integrar canais WhatsApp via tabela `channels`
4. **API REST:** Implementar endpoints sobre esta estrutura
