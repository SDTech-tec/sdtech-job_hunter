# Relatório de inspeção (leitura‑somente)

## Visão geral do sistema
- **SO:** Ubuntu 26.04.1 LTS (Resolute Raccoon)
- **Kernel:** exibido por `uname -a`
- **CPU:** 12 vCPUs – Intel Core i7‑1355U (até 5 GHz)
- **Memória:** 14 Gi total – 11 Gi usadas, 449 Mi livres
- **Disco:** 468 Gi (`/`) – 38 % usado
- **Swap:** 2 Gi (1,2 Gi usados)
- **Arquitetura:** x86 64
- **Virtualização:** VT‑x suportado

## Serviços em execução (systemd)
- ssh, cron, ollama (porta 7070), tailscaled, gdm, avahi, cups, fwupd, polkit, rsyslog, systemd‑oomd, systemd‑resolved, unattended‑upgrades, entre outros.
- **PostgreSQL não aparece** na lista → possivelmente roda em container ou ainda não está instalado.

## Sockets de escuta (`ss -tuln`)
- **TCP 0.0.0.0:22** – SSH.
- **TCP 0.0.0.0:7070** – Serviço **Ollama** (IA local).
- Diversas portas localhost usadas por ferramentas de desenvolvimento (Vite, etc.).
- **Nenhuma porta HTTP/HTTPS** (80/443) está aberta atualmente.

## Docker / Contêineres
- Comando `docker` inexistente → **Docker não está instalado** no host.

## Estrutura do repositório
Caminho: **`/home/pp/repo/SDTech_Soluctions`**
Pastas relevantes:
- **frontend/** – app React + Vite (TSX/TS, CSS puro, Workbox).
- **migrations/** – scripts SQL de migração.
- **n8n/** – workflows e scripts de automação.
- **scripts/** – helpers de banco (backup, migração, etc.).
- **seeds/** – dados de semente.

## Configurações & Segredos
`.env.example` define variáveis como:
```
APP_ENV=development
DB_HOST=localhost
DB_PORT=5434
DB_USER=sdtech_app
DB_PASSWORD=CHANGE_ME_APP_PASSWORD
...
```
Todos os valores são **placeholders**; nenhum segredo real está no repositório.

## Riscos imediatos
| Área | Observação | Impacto |
|------|------------|---------|
| PostgreSQL | Não há service ativo; sem Docker, não há contêiner pronto. | Falha nas rotinas que dependem de persistência. |
| Docker | Ausente → impossibilidade de rodar contêineres críticos. | Impossível iniciar componentes críticos. |
| Portas HTTP | Não há listener externo. | UI web não será acessível externamente. |
| Segredos | Senhas ainda são `CHANGE_ME_*`. | Necessário gerar e armazenar senhas seguras antes de iniciar. |
| Ollama | Consome recursos (CPU/RAM). | Avaliar necessidade ou desativar para liberar memória. |
| Backup | Diretório `./backups` vazio. | Criar backup inicial antes de alterações no schema. |

## Próximos passos sugeridos
1. **Confirmar onde o PostgreSQL será executado** (host, contêiner ou serviço externo).
2. **Instalar Docker** (se for a estratégia) e criar volumes dedicados para o banco e para o n8n.
3. **Gerar senhas seguras** e preencher um arquivo `.env` (não versionado).
4. **Criar backup inicial** com `scripts/db-backup.sh` assim que o DB estiver ativo.
5. **Planejar exposição HTTP** – escolher um reverse‑proxy (Caddy, Nginx ou Traefik) e liberar a porta no firewall.
6. **Rever necessidade do Ollama** – manter para IA local ou substituir por API externa.
7. **Documentar tudo** em um artefato (`inspection_report.md`).

## Repositório Git
URL: `git@github.com:SDTech-tec/sdtech-job_hunter.git`

---
*Este relatório foi gerado automaticamente após a inspeção de leitura‑somente.*
