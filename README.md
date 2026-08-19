# SDTech Soluctions

Sistema de atendimento inteligente via WhatsApp com IA.

## Banco de Dados V1.0

Estrutura de banco PostgreSQL para o core do SDTech Soluctions.

### Stack

- **PostgreSQL 16** — banco principal
- **Redis** — cache/filas (infraestrutura preparada)
- **Docker Compose** — ambiente de desenvolvimento

### Pré-requisitos

- Docker e Docker Compose instalados
- `make` disponível
- PostgreSQL client (`psql`, `pg_dump`) para scripts diretos

### Início Rápido (dev local)

```bash
# Clone o repositório
git clone git@github.com:SDTech-tec/sdtech_soluctins.git
cd sdtech_soluctins

# Configure o ambiente
cp .env.example .env
# Edite .env com suas credenciais

# Setup completo (Docker + migrate + seed)
make setup

# Verifique o status
make db-status

# Execute os testes
make test
```

### Comandos disponíveis

```bash
make help       # Lista todos os comandos disponíveis
make setup      # Setup completo
make db-backup  # Backup (execute ANTES de qualquer alteração)
make test       # Testes de multi-tenancy e integridade
```

### Documentação

- [Documentação do Banco](docs/database/README.md)
- [Modelo Lógico e Diagrama ER](docs/database/schema.md)

### Segurança

- **NUNCA** commite o arquivo `.env`
- **NUNCA** use o usuário `postgres` nas aplicações
- Execute `make db-backup` antes de qualquer migration em produção
- Consulte `docs/database/README.md` para detalhes de segurança

### Próxima etapa

Após validação do banco:
- N8N Core → Evolution API → WhatsApp → Supervisor IA → Recepcionista IA

---

© 2026 SDTech — Pedro Dantas
