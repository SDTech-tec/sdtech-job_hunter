# SDTech Soluctions — Documentação Técnica

Bem-vindo à central de documentação técnica do **SDTech Soluctions**, a plataforma SaaS modular multi-tenant da SDTECH.

---

## 📚 Índice da Documentação

- [**Contexto Geral do Projeto**](../PROJECT_CONTEXT.md)
- [**Arquitetura de Alto Nível**](architecture/overview.md)
- [**Banco de Dados Core V1.0**](database/README.md)
- [**Modelo Lógico e Diagrama ER**](database/schema.md)
- [**Guias de Deployment e Infraestrutura**](deployment/overview.md)
- [**Registros de Decisões Arquiteturais (ADRs)**](decisions/)
  - [ADR-0001: Arquitetura Modular e Habilitação de Módulos](decisions/ADR-0001-modular-architecture.md)

---

## 🎯 Objetivo do Projeto

O **SDTech Soluctions** tem como objetivo fornecer uma infraestrutura completa e modular de atendimento inteligente via WhatsApp e múltiplos canais, impulsionada por agentes de IA especializados (Supervisor IA e Recepcionista IA).

---

## 🛠️ Pilha Tecnológica

- **Database:** PostgreSQL 16 (Multi-tenant, UUID v4, JSONB, Triggers)
- **Cache/Queue:** Redis 7
- **Orquestrador:** n8n
- **Canal WhatsApp:** Evolution API
- **Infraestrutura:** Docker, Cloudflare, Nginx Proxy Manager, Uptime Kuma
- **Futuro Backend:** Go (REST API)

---

## 🚀 Próximos Passos

1. **PROMPT 02 (Etapa seguinte):** Configuração e preparação do n8n Core e conexão com o PostgreSQL `sdtech_soluctions`.
2. **Integração Evolution API:** Conexão de instâncias WhatsApp aos workflows.
3. **Desenvolvimento dos Agentes IA:** Prompts e fluxos de atendimento para o Supervisor IA e Recepcionista IA.
