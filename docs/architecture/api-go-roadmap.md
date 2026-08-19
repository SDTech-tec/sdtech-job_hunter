# Roadmap da API REST em Go (Golang) — SDTech Soluctions

## Visão Geral

Nas fases avançadas da plataforma **SDTech Soluctions**, será desenvolvida uma **API REST de alta performance em Go (Golang)** responsável por centralizar a lógica de negócio do Core, substituir consultas diretas de microsserviços e expor endpoints seguros para o frontend/dashboard.

---

## Papel da API Go na Arquitetura

```
Frontend / Dashboard / Mobile
       ↓ (HTTPS / REST API)
REST API em Go (Golang)
       ↓
PostgreSQL (sdtech_soluctions) & Redis
       ↑
n8n Orquestrador (Webhooks & Agentes IA)
```

---

## Responsabilidades Previstas para a API Go

- **Autenticação & RBAC:** Emissão e validação de JWTs, verificação de permissões e controle de papéis (`roles`, `permissions`).
- **Gestão de Tenants:** Endpoints de onboarding, configuração e ativação/desativação de módulos por tenant.
- **Inbox & Atendimento Humano:** Endpoints para listagem de filas de conversas, envio manual de mensagens, takeover e encerramento de atendimentos.
- **Gerenciamento de Canais & Instâncias:** CRUD de canais WhatsApp/Instagram e status de conexão da Evolution API.
- **Módulos SaaS:** Endpoints específicos para módulos verticais (agendamentos, cadastros específicos, relatórios).

---

## Diretrizes de Implementação Futura

1. **Framework/Lib:** Utilização do router nativo ou `Chi` / `Fiber` para concorrência e alta vazão.
2. **Conexão com Banco:** `pgx` / `sqlx` nativo para execução parametrizada de queries sem ORMs pesados.
3. **Isolamento Multi-Tenant:** Middleware obrigatório que injeta o `tenant_id` a partir do JWT em todas as requisições.
