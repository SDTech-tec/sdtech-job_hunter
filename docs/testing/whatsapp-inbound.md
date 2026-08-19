# Suíte de Testes e Troubleshooting — WhatsApp Inbound Flow

Este documento detalha os procedimentos de teste, cargas de teste (payloads) e rotinas de solução de problemas para o fluxo real de entrada de mensagens do WhatsApp no **SDTech Soluctions**.

---

## 🧪 Cenários de Teste

### 1. Teste de Sucesso de Ingestão (Contato Novo + Conversa Nova)

**Payload Enviado via Webhook HTTP POST (`/webhook/sdtech-whatsapp-inbound`):**

```json
{
  "event": "messages.upsert",
  "instance": "empresa-wpp-01",
  "data": {
    "key": {
      "remoteJid": "5511988887777@s.whatsapp.net",
      "fromMe": false,
      "id": "MSG_TEST_SUCCESS_001"
    },
    "pushName": "Carlos Eduardo",
    "message": {
      "conversation": "Teste SDTech 001 — Mensagem de Entrada Real"
    },
    "messageType": "conversation"
  }
}
```

**Resultado Esperado:**
- Resposta HTTP 200:
  ```json
  {
    "success": true,
    "status": "processed",
    "code": "MESSAGE_PROCESSED",
    "message": "Mensagem inbound processada e gravada no PostgreSQL"
  }
  ```
- **Banco de Dados:**
  - Contato criado na tabela `contacts` com `phone = '+5511988887777'` e `name = 'Carlos Eduardo'`.
  - Conversa criada na tabela `conversations` com `status = 'open'`.
  - Mensagem gravada na tabela `messages` com `sender_type = 'contact'`, `content = 'Teste SDTech 001 — Mensagem de Entrada Real'` e `external_message_id = 'MSG_TEST_SUCCESS_001'`.
  - Evento gravado na tabela `audit_logs` com `action = 'WHATSAPP_MESSAGE_RECEIVED'`.

---

### 2. Teste de Idempotência (Duplicidade)

Submeter o mesmo payload do Teste 1 uma segunda vez com o mesmo `key.id = 'MSG_TEST_SUCCESS_001'`.

**Resultado Esperado:**
- Resposta HTTP 200:
  ```json
  {
    "success": true,
    "status": "duplicate_ignored",
    "code": "DUPLICATE_MESSAGE_IGNORED",
    "message": "Mensagem duplicada já existente no PostgreSQL"
  }
  ```
- **Banco de Dados:** Nenhuma segunda mensagem é criada na tabela `messages`.

---

### 3. Teste de Instância / Tenant Inválido

Enviar payload com uma instância não cadastrada na tabela `channels`:

```json
{
  "event": "messages.upsert",
  "instance": "instancia_desconhecida_xyz",
  "data": {
    "key": {
      "remoteJid": "5511988887777@s.whatsapp.net",
      "fromMe": false,
      "id": "MSG_UNMAPPED_001"
    },
    "message": {
      "conversation": "Teste Instância Desconhecida"
    }
  }
}
```

**Resultado Esperado:**
- Resposta HTTP 200:
  ```json
  {
    "resolved": false,
    "status": "tenant_not_resolved",
    "code": "TENANT_NOT_RESOLVED",
    "message": "Nenhum tenant/canal ativo associado à instância 'instancia_desconhecida_xyz'"
  }
  ```
- **Banco de Dados:** Nenhum registro criado em `contacts`, `conversations` ou `messages`.

---

### 4. Teste de Payload Malformado

Enviar payload sem `instance` ou sem `key.id`:

```json
{
  "event": "messages.upsert",
  "data": {}
}
```

**Resultado Esperado:**
- Resposta HTTP 400 (`VALIDATION_ERROR`):
  ```json
  {
    "is_valid": false,
    "reason": "VALIDATION_ERROR",
    "status": "validation_error",
    "message": "Campos obrigatórios ausentes: instance, remoteJid ou message_id"
  }
  ```

---

## 🛠️ Procedimento de Troubleshooting

### Mensagem não aparece no banco de dados
1. Verifique se o evento era `messages.upsert` e se `fromMe` era `false`.
2. Consulte se a instância está cadastrada na tabela `channels`:
   ```sql
   SELECT * FROM channels WHERE config->>'instance_name' = 'nome-da-sua-instancia';
   ```
3. Verifique os logs do n8n para confirmar se o webhook respondeu HTTP 200.

### Erro de permissão no banco
- O workflow executa queries com o usuário `sdtech_app`. Garanta que a conta possui permissão de `INSERT` nas tabelas `contacts`, `conversations`, `messages` e `audit_logs`.
