# Visão Geral de Deployment — SDTech Soluctions

## Estratégia de Implantação

O SDTech Soluctions utiliza a infraestrutura de containers Docker da SDTECH.

---

## Ambientes

### 1. Desenvolvimento Local
- Gerenciado via `docker/docker-compose.yml` e `Makefile`.
- Banco de Dados local rodando PostgreSQL 16 na porta `5434`.
- Redis local rodando na porta `6380`.

### 2. Produção (VPS Oracle Cloud)
- Executa no container PostgreSQL 16 oficial na porta `5432` conectado à rede Docker privada `sdtech-net`.
- Utiliza Nginx Proxy Manager para gerenciamento de SSL e roteamento de domínio público.

---

## Procedimento para Atualização do Banco em Produção

```bash
# 1. Realizar backup obrigatório
make db-backup

# 2. Executar migrations em ordem
make db-migrate

# 3. Executar seeds se houver novidades
make db-seed

# 4. Verificar integridade e status
make db-status
```
