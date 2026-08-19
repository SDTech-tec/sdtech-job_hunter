# SDTech Soluctions — Contrato de Webhooks (Evolution API → n8n)

Este documento especifica o contrato esperado para a integração futura via Webhook entre a **Evolution API** e os workflows do **n8n Core**.

---

## 📌 Visão Geral do Webhook

- **Evento Principal:** `MESSAGES_UPSERT` (ou `messages.upsert`)
- **Método HTTP:** `POST`
- **Content-Type:** `application/json`
- **Destino n8n (Futuro):** `http://n8n:5678/webhook/sdtech-soluctions/inbound`

---

## 📥 Payload Esperado (Inbound WhatsApp Message)

```json
{
  "event": "messages.upsert",
  "instance": "empresa-wpp-01",
  "data": {
    "key": {
      "remoteJid": "5511999999999@s.whatsapp.net",
      "fromMe": false,
      "id": "BAE5F1234567890ABCDEF"
    },
    "pushName": "João Silva",
    "message": {
      "conversation": "Olá, gostaria de saber mais informações sobre os serviços."
    },
    "messageType": "conversation",
    "messageTimestamp": 1776595200
  }
}
