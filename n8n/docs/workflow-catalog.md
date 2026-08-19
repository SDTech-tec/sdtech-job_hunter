# Catálogo Oficial de Workflows n8n — SDTech Soluctions V1.0

## Tabela de Versões dos Workflows

| Workflow | Versão | Objetivo | Gatilho | Tabela(s) Acessada(s) |
|----------|--------|----------|---------|-----------------------|
| `SDTECH — CORE — Health Check` | `v1.0.0` | Teste readonly de conectividade e versão do banco | Manual | Nenhuma (função `now()`) |
| `SDTECH — CORE — Tenant Test` | `v1.0.0` | Valida existência e status de um tenant por `tenant_id` | Manual / Sub-workflow | `tenants` |
| `SDTECH — CORE — Contact Resolver` | `v1.0.0` | Localiza contato por `tenant_id` e `phone` sem criar registros | Manual / Sub-workflow | `contacts` |
| `SDTECH — CORE — Conversation Resolver` | `v1.0.0` | Localiza conversa aberta por `tenant_id`, `contact_id` e `channel_id` | Manual / Sub-workflow | `conversations` |
| `SDTECH — CORE — Message Test` | `v1.0.0` | Grava mensagem de teste parametrizada em `messages` | Manual / Sub-workflow | `messages` |
| `SDTECH — CORE — Audit Test` | `v1.0.0` | Grava registro de auditoria parametrizado em `audit_logs` | Manual / Sub-workflow | `audit_logs` |
