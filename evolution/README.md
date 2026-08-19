# Módulo Evolution API — SDTech Soluctions

## Visão Geral

A **Evolution API** é o gateway oficial de integração entre a rede do WhatsApp e o SDTech Soluctions.

---

## Configuração na Infraestrutura SDTECH

- **Container:** `evolution`
- **Porta Interna:** `8080`
- **Rede Docker:** `sdtech-net`
- **URL de Comunicação Interna:** `http://evolution:8080`
- **Autenticação:** Header HTTP `apikey: <EVOLUTION_API_TOKEN>`

---

## Instâncias e Mapeamento

Cada instância criada na Evolution API deve corresponder a um registro na tabela `channels` do respectivo tenant no PostgreSQL `sdtech_soluctions`:

```sql
-- Exemplo conceitual de cadastro de canal para uma instância Evolution
INSERT INTO channels (tenant_id, type, name, status, config)
VALUES (
  '<TENANT_UUID>',
  'whatsapp',
  'WhatsApp Comercial',
  'active',
  '{"instance_name": "empresa-wpp-01", "server_url": "http://evolution:8080"}'::jsonb
);
```

---

## Configuração do Webhook na Evolution API

Para que a instância envie mensagens ao n8n:

- **URL do Webhook:** `http://n8n:5678/webhook/evolution-test` (ou endpoint de produção)
- **Eventos Habilitados:** `MESSAGES_UPSERT`, `MESSAGES_UPDATE`, `CONNECTION_UPDATE`, `QRCODE_UPDATED`
- **Webhook por Instância:** Sim

---

## Diretrizes de Operação & Segurança

- **NUNCA** apague ou reinicie instâncias sem autorização prévia.
- **NUNCA** exponha chaves de API da Evolution em texto claro nos arquivos de documentação ou repositório Git. Use `<EVOLUTION_API_TOKEN>`.
