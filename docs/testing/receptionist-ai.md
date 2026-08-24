# Guia de Testes — Recepcionista IA V1.0

Este documento descreve os cenários de homologação e a execução de testes automatizados para a Recepcionista IA V1.0 do SDTech Soluctions.

---

## 🚀 Execução Rápida de Testes

Para executar a suíte de validação de workflows e simulação de cenários da Recepcionista:

```bash
# Validação de sintaxe e nomenclatura dos workflows n8n
./n8n/scripts/validate-workflows.sh

# Testes automatizados dos cenários da Recepcionista
./n8n/scripts/test-receptionist.sh
```

---

## 🧪 Matriz de Cenários de Homologação

| ID | Cenário de Teste | Entrada Simulada | Saída Esperada |
|---|---|---|---|
| **TC-01** | Saudação (`GREETING`) | `intent: "GREETING"`, `content: "Olá"` | `action: "RESPOND"`, mensagem de boas-vindas com nome da empresa |
| **TC-02** | Pergunta sem cadastro (Não Invenção) | `content: "Qual o preço?"` | `action: "HUMAN_HANDOFF"`, informa falta de dados e transfere |
| **TC-03** | Agendamento Inicial (`SCHEDULING`) | `intent: "SCHEDULING"`, `content: "Quero agendar"` | `action: "RESPOND"`, solicita nome e serviço de interesse |
| **TC-04** | Baixa Confiança (`confidence < 0.70`) | `intent: "UNKNOWN"`, `confidence: 0.50` | `action: "ASK_CLARIFICATION"`, envia pergunta de esclarecimento |
| **TC-05** | Handoff Solicitado (`HUMAN_HANDOFF`) | `action: "HUMAN_HANDOFF"`, `content: "Falar com pessoa"` | `action: "HUMAN_HANDOFF"`, mensagem de transição e `handoff: true` |
| **TC-06** | Prevenção de Loop (`fromMe = true`) | `fromMe: true` | Payload rejeitado com `OUTBOUND_LOOP_PREVENTED` |
| **TC-07** | Isolamento Multi-Tenant | Queries com `tenant_id` de Tenant A | Nenhum dado de Tenant B retornado |

---

## 📊 Registros e Persistência no Banco de Dados

Ao processar uma mensagem válida, verifique a gravação nas seguintes tabelas:

```sql
-- Verificar última sessão de agente gravada
SELECT * FROM agent_sessions ORDER BY started_at DESC LIMIT 1;

-- Verificar mensagem gerada pela Recepcionista
SELECT * FROM messages WHERE sender_type = 'agent' ORDER BY created_at DESC LIMIT 1;

-- Verificar log de auditoria
SELECT * FROM audit_logs WHERE action IN ('RECEPTIONIST_RESPONSE_GENERATED', 'RECEPTIONIST_HANDOFF') ORDER BY created_at DESC LIMIT 1;
```
