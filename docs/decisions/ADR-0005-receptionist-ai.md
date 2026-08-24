# ADR-0005: Arquitetura e Guardrails da Recepcionista IA V1.0

- **Status:** Aprovado
- **Data:** 2026-08-24
- **Autor:** Equipe SDTech Soluctions
- **Decisores:** Arquitetura do Sistema Core

---

## Contexto e Problema

No ecossistema SDTech Soluctions, o Supervisor IA é responsável pela triagem de mensagens. Uma vez identificada a intenção inicial de atendimento (ex: saudação, agendamento básico, informações), a conversa deve ser conduzida por um agente conversacional especializado: a **Recepcionista IA V1.0**.

Desafios fundamentais:
1. Impedir que a IA invente preços, horários, disponibilidade ou políticas comerciais inexistentes no cadastro do Tenant.
2. Manter estrito isolamento Multi-Tenant (`tenant_id`).
3. Retornar dados estruturados JSON validados.
4. Tratar handoff para atendentes humanos de forma transparente.
5. Evitar loops de mensagens (`fromMe = true`).

---

## Decisão Tomada

1. **Separação em Workflow Dedicado (`010_ai_receptionist.json`):**
   A Recepcionista opera como um agente isolado no n8n e no banco de dados (`agents.type = 'receptionist'`), preservando o princípio modular do SDTech Soluctions.

2. **Guardrails de Não Invenção:**
   Se uma informação não estiver cadastrada no contexto do Tenant, a Recepcionista não inventará dados. Ela responderá informando a indisponibilidade pontual e transferirá o atendimento para o fluxo humano (`HUMAN_HANDOFF`).

3. **Validação de Saída Estruturada:**
   A Recepcionista deve retornar um objeto JSON obrigatório com o esquema `{"success": true, "action": "...", "message": {"text": "..."}, "handoff": boolean}`. Caso a saída seja inválida, dispara o evento `RECEPTIONIST_OUTPUT_INVALID`.

4. **Persistência Completa:**
   Todas as sessões são auditadas em `agent_sessions`, as mensagens são gravadas em `messages` como `sender_type = 'agent'`, a conversa tem seu `assigned_agent_id` atualizado e o evento é registrado em `audit_logs`.

---

## Consequências

### Positivas
- **Confiabilidade:** Zero alucinações sobre preços, horários ou regras de negócio.
- **Rastreabilidade:** Histórico completo de sessões e trocas de agente gravado no banco.
- **Resiliência:** Suporte nativo a fallback determinístico (Modo MOCK) quando credenciais de LLM não estiverem configuradas.

### Negativas / Limitações
- Informações complexas ou específicas do Tenant requerem cadastro no banco de dados para serem respondidas pela IA (resolvido em versões futuras com RAG / Base de Conhecimento).
