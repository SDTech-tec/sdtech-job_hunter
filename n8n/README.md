# n8n Core — SDTech Soluctions V1.0

## Visão Geral

O **n8n** é o **ORQUESTRADOR DE AUTOMAÇÕES E WORKFLOWS** do **SDTech Soluctions**.

> [!IMPORTANT]
> **REGRAS DE ARQUITETURA:**
> - O n8n **NÃO É** o banco de dados oficial.
> - O n8n **NÃO É** o sistema de autenticação ou fonte de verdade de usuários.
> - O **PostgreSQL (`sdtech_soluctions`)** é a única fonte oficial da verdade.
> - Todas as consultas SQL devem ser parametrizadas (`$1, $2`) e obrigatoriamente filtradas por `tenant_id`.

---

## Conexão com o PostgreSQL (`SDTECH_POSTGRES`)

Os workflows utilizam a credencial de banco `SDTECH_POSTGRES`:

- **Database:** `sdtech_soluctions`
- **Usuário:** `sdtech_app` (privilégios mínimos: `SELECT, INSERT, UPDATE, DELETE` — sem privilégios de DDL/superuser)
- **Host / Rede:** `postgres` (via rede Docker `sdtech-net`)
- **Porta Interna:** `5432`

---

## Catálogo de Workflows Core V1.0

Todos os workflows seguem o padrão de nomenclatura `SDTECH — CORE — <Nome>`:

| Workflow | Arquivo JSON | Versão | Objetivo |
|----------|--------------|--------|----------|
| `SDTECH — CORE — Health Check` | `workflows/001_health_check.json` | `v1.0.0` | Testa conexão readonly com o PostgreSQL (`SELECT NOW()`) |
| `SDTECH — CORE — Tenant Test` | `workflows/002_tenant_test.json` | `v1.0.0` | Valida acesso a um `tenant_id` específico na tabela `tenants` |
| `SDTECH — CORE — Contact Resolver` | `workflows/003_contact_resolver.json` | `v1.0.0` | Consulta contato por `tenant_id` e `phone` sem criar registros |
| `SDTECH — CORE — Conversation Resolver` | `workflows/004_conversation_resolver.json` | `v1.0.0` | Busca conversa aberta por `tenant_id`, `contact_id`, `channel_id` |
| `SDTECH — CORE — Message Test` | `workflows/005_message_test.json` | `v1.0.0` | Grava mensagem de teste isolada por `tenant_id` em `messages` |
| `SDTECH — CORE — Audit Test` | `workflows/006_audit_test.json` | `v1.0.0` | Grava log de auditoria parametrizado em `audit_logs` |

---

## Tratamento de Erros e Padrão de Resposta

Todos os workflows retornam um objeto JSON padronizado com os seguintes status possíveis:

- `status: "success"` — Operação concluída com êxito.
- `status: "error"` — Erro técnico ou de banco de dados.
- `status: "validation_error"` — Parâmetros de entrada inválidos ou ausentes.

Nenhum log ou nó deve expor senhas, tokens, API keys ou credenciais de banco.

---

## Validação de Workflows

Um script utilitário está disponível em `scripts/validate-workflows.sh` para verificar a integridade sintática e de estrutura dos arquivos JSON dos workflows.

```bash
chmod +x n8n/scripts/validate-workflows.sh
./n8n/scripts/validate-workflows.sh
```
