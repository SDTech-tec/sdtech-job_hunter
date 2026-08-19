# ADR-0002: Integração com Evolution API, Normalização de Eventos e Webhooks

- **Status:** Aceito
- **Data:** 2026-08-19
- **Autor:** SDTECH / Antigravity

---

## Contexto
O **SDTech Soluctions** necessita de uma camada estável para conexão com o WhatsApp. A **Evolution API** é a solução oficial adotada pela infraestrutura da SDTECH por oferecer gerenciamento robusto de instâncias, suporte a múltiplos canais WhatsApp e envio de eventos por webhook.

---

## Decisões Tomadas

1. **Papel da Evolution API:** Atua exclusivamente como gateway de transporte de mensagens do WhatsApp. Não armazena estado de atendimento ou regras de negócio do SaaS.
2. **Papel do n8n:** Recebe os webhooks da Evolution API, executa o mapa de normalização para a estrutura padrão do SDTech Soluctions e orquestra a persistência e a lógica de atendimento.
3. **Papel do PostgreSQL (`sdtech_soluctions`):** Armazena a verdade oficial dos contatos, canais, conversas, mensagens e auditoria.
4. **Normalização Obrigatória:** Todo payload nativo recebido da Evolution API é traduzido em um contrato interno único (`source`, `event`, `instance`, `received_at`, `contact`, `message`, `raw_event`).
5. **Resolução de Multi-Tenancy:** A associação do tenant é resolvida a partir do mapeamento `instance_name` → `channels.config->>'instance_name'` no PostgreSQL.
6. **Estratégia de Idempotência:** A deduplicação é garantida pelo índice único do PostgreSQL em `messages(conversation_id, external_message_id)`.

---

## Consequências

### Positivas
- **Independência de Fornecedor:** Se no futuro o gateway de WhatsApp for alterado, apenas o nó de normalização do n8n precisa ser adaptado, sem alterar o banco ou os agentes de IA.
- **Segurança Multi-Tenant:** Garantia de que nenhuma mensagem é gravada sem associação prévia de instância ao tenant.
- **Resiliência:** Tratamento nativo de retentativas e deduplicação de mensagens repetidas.

### Requisitos de Segurança
- Secrets de webhook (`<EVOLUTION_API_TOKEN>`, `<N8N_WEBHOOK_SECRET>`) devem ser configurados via variáveis de ambiente/credenciais protegidas, nunca expostas no Git ou documentações.
