# ============================================================
# Makefile — SDTech Soluctions Database V1.0
# ============================================================
# Uso: make <target>
# ============================================================

.PHONY: help db-up db-down db-create db-migrate db-seed db-backup \
        db-restore db-status db-rollback test test-mt clean

# Shell e flags
SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

# Diretório dos scripts
SCRIPTS := ./scripts

help: ## Exibe esta ajuda
	@echo ""
	@echo "============================================================"
	@echo "  SDTech Soluctions — Banco de Dados V1.0"
	@echo "============================================================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
	@echo ""

# ------------------------------------------------------------
# DOCKER (desenvolvimento local)
# ------------------------------------------------------------

db-up: ## Inicia PostgreSQL e Redis locais via Docker
	@echo "🐳 Iniciando containers de desenvolvimento..."
	@docker compose -f docker/docker-compose.yml up -d
	@echo "⏳ Aguardando PostgreSQL estar pronto..."
	@sleep 3
	@docker compose -f docker/docker-compose.yml ps

db-down: ## Para e remove containers locais
	@echo "🛑 Parando containers..."
	@docker compose -f docker/docker-compose.yml down

db-logs: ## Exibe logs do PostgreSQL local
	@docker compose -f docker/docker-compose.yml logs -f postgres

# ------------------------------------------------------------
# BANCO DE DADOS
# ------------------------------------------------------------

db-create: ## Cria banco de dados e usuários
	@bash $(SCRIPTS)/db-create.sh

db-migrate: ## Aplica todas as migrations pendentes
	@bash $(SCRIPTS)/db-migrate.sh

db-seed: ## Aplica seeds de dados essenciais
	@bash $(SCRIPTS)/db-seed.sh

db-backup: ## Realiza backup do banco (execute antes de alterações)
	@bash $(SCRIPTS)/db-backup.sh

db-restore: ## Restaura um backup (uso: make db-restore FILE=caminho.dump)
	@bash $(SCRIPTS)/db-restore.sh $(FILE)

db-status: ## Exibe status do banco, migrations e contagem de registros
	@bash $(SCRIPTS)/db-status.sh

db-rollback: ## Orienta rollback de migrations
	@bash $(SCRIPTS)/db-rollback.sh

# ------------------------------------------------------------
# SETUP COMPLETO (dev local)
# ------------------------------------------------------------

setup: db-up db-migrate db-seed db-status ## Setup completo: sobe Docker, migrate e seed
	@echo ""
	@echo "✅ SDTech Soluctions pronto para desenvolvimento!"

# ------------------------------------------------------------
# TESTES
# ------------------------------------------------------------

test: test-mt ## Executa todos os testes

test-mt: ## Testa isolamento multi-tenant
	@bash $(SCRIPTS)/test-multitenancy.sh

# ------------------------------------------------------------
# UTILITÁRIOS
# ------------------------------------------------------------

clean: ## Remove containers e volumes (CUIDADO: apaga dados locais)
	@echo "⚠️  ATENÇÃO: Isso removerá todos os dados locais!"
	@read -p "Confirma? (yes/N): " c && [[ "$$c" == "yes" ]] || exit 0
	@docker compose -f docker/docker-compose.yml down -v
	@echo "✅ Containers e volumes removidos."
