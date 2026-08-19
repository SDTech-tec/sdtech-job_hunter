# Arquitetura e Estrutura da Landing Page Institucional & Comercial

## Visão Geral

A Landing Page comercial e institucional do **SDTech Soluctions** é uma aplicação web moderna, responsiva, acessível e de alto nível estético desenvolvida em **React 18 + TypeScript + Vite 5 + Tailwind CSS**.

Ela está completamente isolada da lógica do Core SaaS, sem qualquer dependência direta do banco de dados PostgreSQL, n8n ou Evolution API.

---

## 🛠️ Pilha Tecnológica

- **Framework Frontend:** React 18
- **Linguagem:** TypeScript 5
- **Build Tool / Bundler:** Vite 5
- **Estilização:** Tailwind CSS v3 + CSS Glassmorphism utilitários
- **Ícones:** Lucide React
- **Tipografia:** Google Fonts (*Plus Jakarta Sans* & *Inter*)

---

## 📁 Estrutura de Arquivos

```
SDTech_Soluctions/
└── frontend/
    ├── public/
    │   └── assets/                     # Logos e imagens da marca SDTECH
    ├── src/
    │   ├── components/
    │   │   ├── Navbar.tsx              # Menu fixo com logo SDTECH e navegação mobile
    │   │   ├── Hero.tsx                # Hero section oficial
    │   │   ├── AboutSDTech.tsx         # Sobre a empresa SDTECH
    │   │   ├── ProductOverview.tsx     # Visão geral do SDTech Soluctions
    │   │   ├── ModularArchitecture.tsx # Fluxo de contratação de módulos e ADM Master
    │   │   ├── Features.tsx            # Cards dos 6 recursos principais
    │   │   ├── AgentArchitecture.tsx   # Arquitetura evolutiva Supervisor IA -> Agentes
    │   │   ├── SupportAI.tsx           # SDTech Support AI (Em desenvolvimento)
    │   │   ├── Channels.tsx            # WhatsApp (Ativo) + Roadmap de Canais Futuros
    │   │   ├── Integrations.tsx        # APIs, Webhooks e ecossistema n8n/Go
    │   │   ├── SecurityGovernance.tsx  # Arquitetura enterprise (RBAC, Multi-tenant)
    │   │   ├── Evolution.tsx           # Conceito "Uma plataforma que evolui com sua empresa"
    │   │   ├── Roadmap.tsx             # ATUAL, EM DESENVOLVIMENTO e FUTURO
    │   │   ├── Differentials.tsx       # 6 cards dos diferenciais oficiais
    │   │   ├── HowItWorks.tsx          # 4 passos da jornada do cliente
    │   │   ├── ContactForm.tsx         # Formulário comercial de contato (frontend)
    │   │   ├── CTA.tsx                 # Chamada final para ação
    │   │   └── Footer.tsx              # Rodapé com logo, slogan e termos
    │   ├── App.tsx                     # Componente raiz da Landing Page
    │   ├── main.tsx                    # Ponto de entrada React
    │   └── index.css                   # Estilos globais e glassmorphism
    ├── package.json
    ├── vite.config.ts
    ├── tailwind.config.js
    └── index.html
```

---

## 🚀 Como Executar e Gerar Build

### Desenvolvimento Local
```bash
cd frontend
npm install
npm run dev
# Acesse http://localhost:3000
```

### Build de Produção
```bash
cd frontend
npm run build
# Os arquivos estáticos otimizados serão gerados na pasta `frontend/dist/`
```

### Validação de Tipagem / Linting
```bash
cd frontend
npm run lint
```

---

## 🌐 SEO & Acessibilidade

- HTML5 semântico com tags `<header>`, `<main>`, `<section>`, `<footer>` e múltiplos títulos hierárquicos `<h1>`, `<h2>`, `<h3>`.
- Meta tags de OpenGraph, Twitter Cards, Canonical URL e suporte a navegação por teclado e alto contraste.
