# ADR-0003: Fluxo Real de Entrada WhatsApp Sem Resposta Automática de IA

- **Status:** Aceito
- **Data:** 2026-08-19
- **Autor:** SDTECH / Antigravity

---

## Contexto
A integração com o WhatsApp exige um fluxo estável e seguro para receber, validar, normalizar e persistir as mensagens dos contatos na base PostgreSQL `sdtech_soluctions`. Nesta etapa (Prompt 04), o foco é a **confiabilidade transacional de entrada**, sem gerar respostas automáticas ou acionar LLMs/agentes de IA.

---

## Decisões Tomadas

1. **Primeiro Canal Operacional:** O WhatsApp (via Evolution API) é confirmado como o primeiro canal de comunicação ativo.
2. **Camada de Orquestração:** O n8n é o único responsável por receber o webhook, validar o payload, resolver a cadeia `Instance → Tenant → Contact → Conversation → Message` e gravar no PostgreSQL.
3. **Persistência Obrigatória sem Resposta:** A mensagem é inserida na tabela `messages` e auditada na `audit_logs`. Nenhuma mensagem é enviada ao cliente nesta fase.
4. **Resolução de Contato e Conversa:**
   - Se o contato não existir no tenant, ele é criado automaticamente com `status = 'active'`.
   - Se a conversa não existir no canal do tenant para o contato, ela é criada com `status = 'open'`.
5. **Idempotência Rigorosa:** Verificação prévia do `external_message_id` na conversa. Se já existir, retorna HTTP 200 `DUPLICATE_IGNORED` sem reinscrever.
6. **Preparação para IA Futura:** O workflow termina gerando o objeto estruturado `ai_context` contendo as chaves primárias necessárias para consumo do futuro **Supervisor IA**.

---

## Consequências

### Positivas
- **Segurança de Teste:** É possível enviar mensagens reais para o WhatsApp de teste sem risco de disparar respostas indesejadas ou alucinações de IA.
- **Rastreabilidade:** 100% das mensagens e eventos de entrada são auditados.
- **Resiliência Multi-Tenant:** Garantia de que instâncias não cadastradas são rejeitadas como `TENANT_NOT_RESOLVED` sem poluir a base.
