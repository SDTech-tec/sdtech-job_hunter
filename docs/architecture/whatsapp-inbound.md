# Arquitetura de Entrada de Mensagens WhatsApp (Inbound Message Flow)

## Visão Geral do Fluxo Real Inbound

O fluxo real de ingestão de mensagens do WhatsApp no **SDTech Soluctions V1.0** opera sem intervenção de IA nesta etapa, garantindo a resolução estrita de Tenant, Contato, Conversa e Persistência da Mensagem no PostgreSQL com controle de idempotência e log de auditoria.

```mermaid
sequenceDiagram
    participant W as WhatsApp (Cliente)
    participant E as Evolution API
    participant N as n8n (SDTECH — WHATSAPP — Inbound Message)
    participant DB as PostgreSQL (sdtech_soluctions)

    W->>E: Envia mensagem ("Teste SDTech 001")
    E->>N: Webhook HTTP POST (/webhook/sdtech-whatsapp-inbound)
    N->>N: 1. Valida Payload (Rejeita fromMe=true ou params inválidos)
    N->>DB: 2. Resolve Instance -> Channel -> Tenant
    alt Instância não cadastrada
        N-->>E: HTTP 200 (status: tenant_not_resolved)
    else Tenant Resolvido
        N->>DB: 3. Resolver / Criar Contact (phone + tenant_id)
        N->>DB: 4. Resolver / Criar Conversation (open)
        N->>DB: 5. Checar Idempotência (external_message_id)
        alt Mensagem Duplicada
            N-->>E: HTTP 200 (status: duplicate_ignored)
        else Nova Mensagem
            N->>DB: 6. Persistir Message (sender_type='contact')
            N->>DB: 7. Update last_message_at & Inserir Audit Log
            N->>N: 8. Prepara Objeto de Contexto para IA Futura
            N-->>E: HTTP 200 (status: processed)
        end
    end
```

---

## Mapeamento Transacional Detalhado

1. **Validação de Entrada:**
   - Descarta mensagens enviadas pelo próprio usuário do sistema (`fromMe = true`).
   - Processa apenas eventos do tipo `messages.upsert` (ou `MESSAGES_UPSERT`).
2. **Resolução de Instância / Tenant:**
   - Consulta `channels` filtrando por `config->>'instance_name' = $1` e `status = 'active'`.
   - Obtém `tenant_id` e `channel_id`.
3. **Resolução de Contato (`contacts`):**
   - Procura por `(tenant_id, phone)`. Se não existir, cria novo contato atrelado ao `tenant_id`.
4. **Resolução de Conversa (`conversations`):**
   - Busca conversa com `status IN ('open', 'pending')` para `(tenant_id, contact_id, channel_id)`. Se não existir, cria com `status = 'open'` e `ai_enabled = true`.
5. **Deduplicação / Idempotência:**
   - Consulta se `external_message_id` já existe na conversa. Se sim, desvia e retorna `DUPLICATE_IGNORED`.
6. **Persistência de Mensagem (`messages`):**
   - Grava mensagem com `sender_type = 'contact'`, `external_message_id` original do WhatsApp e metadados.
7. **Atualização & Auditoria:**
   - Atualiza `conversations.last_message_at = now()`.
   - Insere evento em `audit_logs` (`action = 'WHATSAPP_MESSAGE_RECEIVED'`).
8. **Saída Estruturada:**
   - Retorna HTTP 200 e deixa o objeto `ai_context` pronto para consumo do futuro **Supervisor IA**.
