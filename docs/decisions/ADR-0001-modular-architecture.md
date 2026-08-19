# ADR-0001: Arquitetura Modular do SaaS SDTech Soluctions

- **Status:** Aceito
- **Data:** 2026-08-19
- **Autor:** SDTECH / Antigravity

---

## Contexto
O **SDTech Soluctions** é uma plataforma SaaS projetada para atender clientes de diferentes nichos de mercado (clínicas, estética, automação empresarial, e-commerce, etc.). Cada segmento exige funcionalidades e integrações específicas que não devem poluir a base de código principal.

---

## Decisão
Adotar uma **Arquitetura Core + Módulos Independentes**.

1. O **Core V1.0** provê o motor essencial de multi-tenancy, usuários, RBAC, contatos, canais, conversas, mensagens, agentes e logs de auditoria.
2. Qualquer nova funcionalidade expressiva (ex: agendamento médico, catálogo de produtos, integração com CRM externo) será desenvolvida como um **módulo independente**.
3. A ativação/desativação de cada módulo por tenant será gerida de forma centralizada pelo **ADM Master da SDTECH** (`is_platform_admin`).

---

## Consequências

### Positivas
- **Manutenibilidade:** O Core permanece enxuto e estável.
- **Escalabilidade Comercial:** Facilidade para vender pacotes e planos diferenciados por módulo.
- **Isolamento de Erros:** Falhas em um módulo específico não afetam o fluxo de mensagens principal.

### Mitigações
- As tabelas de módulos e permissões devem manter o isolamento estrito por `tenant_id`.
