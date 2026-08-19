# PROJECT CONTEXT — SDTech Soluctions

## 📌 Informações Básicas

- **Nome do Projeto:** SDTech Soluctions
- **Empresa:** SDTECH
- **Tipo de Produto:** SaaS modular multi-tenant
- **Arquitetura Core:** Core central + módulos independentes
- **Status Atual:** Auditado e Preparado (Base do Banco de Dados Core V1.0 implementada)

---

## 🌐 Canais de Comunicação

### Canal Inicial (MVP / V1.0)
- **WhatsApp** (via Evolution API)

### Canais Futuros (Roadmap)
- **Instagram** (Direct Messages)
- **Telegram**
- **Web Chat**
- **Chat Widget**
- **Live Chat Widget**

---

## 🤖 Agentes de IA

### Agentes Iniciais (Core V1.0)
- **Supervisor IA:** Responsável pela análise de intenção, triagem, roteamento e controle de handoff (transição entre IAs ou atendente humano).
- **Recepcionista IA:** Responsável pelo primeiro atendimento, saudação, coleta de dados primários e respostas a dúvidas frequentes.

### Agentes Futuros (Especializados por Nicho)
- **Vendedor IA / Comercial**
- **Suporte Técnico IA**
- **Agente de Agendamento Clinico / Estética**
- **Outros Agentes Especializados por nicho de mercado**

---

## 🏗️ Infraestrutura Prevista

| Componente | Tecnologia | Função |
|------------|------------|--------|
| **Banco de Dados Central** | PostgreSQL 16 | Armazenamento relacional e auditado |
| **Cache & Mensageria** | Redis | Cache, gerenciamento de sessões e filas |
| **Orquestrador de Automação** | n8n | Orquestração de workflows, integrações e webhooks |
| **API de Comunicação** | Evolution API | Integração oficial com WhatsApp |
| **Containers** | Docker / Docker Compose | Padronização e isolamento de microsserviços |
| **Proteção & DNS** | Cloudflare | Proxy, SSL e proteção DDoS |
| **Proxy Reverso** | Nginx Proxy Manager (NPM) | Roteamento HTTPS interno e SSL automático |
| **Observabilidade** | Uptime Kuma | Monitoramento contínuo de uptime e alertas |
| **Backend Futuro** | REST API em Go (Golang) | API performática de alto throughput para o Core |

---

## 🔄 Arquitetura de Alto Nível

```
Cliente
   ↓
Canal (ex: WhatsApp)
   ↓
Evolution API / APIs de Integração
   ↓
n8n (Orquestrador de Workflows)
   ↓
Supervisor IA (Triagem e Roteamento)
   ↓
Agente Especializado (ex: Recepcionista IA)
   ↓
Core (Módulos & REGRAS de Negócio)
   ↓
PostgreSQL (sdtech_soluctions)
```

---

## 🧩 Princípio Modular

Toda nova funcionalidade relevante do SDTech Soluctions deverá ser implementada como **módulo independente** quando tecnicamente e comercialmente apropriado.

### Características de um Módulo:
- **Status:** ativo | inativo | em manutenção.
- **Versão:** versionamento semântico (`v1.0.0`).
- **Permissões:** escopo específico no RBAC do sistema.
- **Configuração:** parâmetros dinâmicos por tenant.
- **Dependências:** declaração de dependências de outros módulos.
- **Habilitação por Tenant:** controle exclusivo do ADM Master da SDTECH (`is_platform_admin`), conforme contrato comercial.

---

## 🔒 Regra Absoluta Multi-Tenant

Toda e qualquer informação operacional deve possuir **isolamento rigoroso por Tenant** (`tenant_id`).

> [!CAUTION]
> **REGRA ABSOLUTA:** É estritamente proibido que o Tenant A acesse dados do Tenant B.
> Esta regra deve ser garantida e aplicada em todas as camadas da aplicação:
> - **Banco de Dados:** Triggers de validação referencial e índices compostos por `tenant_id`.
> - **Backend / API:** Middleware obrigatorio de escopo de tenant.
> - **n8n:** Filtros explícitos em todas as consultas SQL/HTTP.
> - **Agentes IA:** Prompt injection guardrails e contexto estritamente delimitado pelo `tenant_id`.
> - **Frontend:** Filtros no estado local e roteamento isolado.

---

## 🔐 Diretrizes de Segurança

- Uso exclusivo de contas de banco com privilégios mínimos (`sdtech_app` para operações).
- Proibido o uso do superusuário `postgres` em aplicações.
- Nenhuma chave de API, secret ou token em texto puro commitado no Git.
- Uso obrigatorio de `.env` e variáveis de ambiente em todos os microsserviços.
