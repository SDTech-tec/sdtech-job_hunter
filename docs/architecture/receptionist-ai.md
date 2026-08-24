# Arquitetura — Recepcionista IA V1.0

## Visão Geral

A Recepcionista IA V1.0 é o primeiro agente conversacional ativo do SDTech Soluctions. Ela atua logo após a triagem do Supervisor IA, gerando respostas estruturadas para o cliente no WhatsApp, realizando saudações, esclarecendo dúvidas básicas autorizadas e encaminhando para atendimento humano quando necessário.

---

## Fluxo da Arquitetura de Comunicação

```
WhatsApp Client
      ↓
Evolution API (Webhook Inbound)
      ↓
008_whatsapp_inbound.json (Resolução de Tenant/Contact/Conversation)
      ↓
Supervisor IA (Triagem, Intenção e Decisão de Roteamento)
      ↓
010_ai_receptionist.json (Recepcionista IA V1.0)
      ↓
1. Validação de Payload & Prevenção de Loop (fromMe)
2. Resolução do Agente no Banco (agents where type = 'receptionist')
3. Carregamento do Contexto do Tenant, Contato Seguro e Histórico (20 mensagens)
4. Geração da Resposta Conversacional (MOCK / LLM) + Guardrails de Não Invenção
5. Validação Estrita do JSON de Saída
6. Persistência em agent_sessions, messages e audit_logs
      ↓
Preparação para Envio WhatsApp / Evolution API (Outbox / Direct Send)
      ↓
WhatsApp Client
```

---

## Separação de Responsabilidades

| Camada | Responsabilidade |
|---|---|
| **Inbound Core** (`008_whatsapp_inbound.json`) | Validação do webhook, deduplicação por `external_message_id`, resolução de Tenant, Contato e Conversa. |
| **Supervisor IA** | Análise de intenção (`GREETING`, `SCHEDULING`, `INFORMATION`, `UNKNOWN`), cálculo de confiança e decisão de roteamento (`TRANSFER_TO_AGENT`, `HUMAN_HANDOFF`). |
| **Orquestrador Recepcionista** (`010_ai_receptionist.json`) | Resolução do agente, montagem de contexto multi-tenant, chamada MOCK/LLM, validação de JSON e persistência de histórico. |
| **Prompt System** (`system.md`) | Guardrails de não invenção, tom de voz, regras de handoff e formatação JSON. |

---

## Regra Fundamental de Não Invenção (Hallucination Prevention)

A Recepcionista opera sob rígido isolamento de dados por Tenant (`tenant_id` obrigatório em todas as queries).
Se o cliente solicitar informações que não constem explicitamente no cadastro do Tenant (como preços, horários de agenda ou políticas comerciais específicas), a Recepcionista:
1. Informa educadamente que não possui a informação disponível.
2. Encaminha automaticamente a solicitação para atendimento humano (`action = "HUMAN_HANDOFF"`, `handoff = true`).

---

## Persistência e Auditability

Após cada resposta gerada e validada:
1. **`agent_sessions`**: Grava uma sessão com `status = 'active'` ou `'transferred'`.
2. **`messages`**: Grava a mensagem do assistente com `sender_type = 'agent'` e `sender_id = agent.id`.
3. **`conversations`**: Atualiza `assigned_agent_id` e `last_message_at`.
4. **`audit_logs`**: Registra evento `RECEPTIONIST_RESPONSE_GENERATED` ou `RECEPTIONIST_HANDOFF`.
