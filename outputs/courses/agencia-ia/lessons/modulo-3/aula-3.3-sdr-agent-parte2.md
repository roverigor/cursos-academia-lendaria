---
lesson_id: "3.3"
title: "SDR Agent (Parte 2): Integração WhatsApp + CRM"
module: "Módulo 3 - Construção Essencial"
duration_minutes: 15
lesson_type: "hands-on"
learning_objectives:
  - "Conectar Evolution API (WhatsApp)"
  - "Integrar com CRM (Pipedrive/HubSpot)"
  - "Sincronizar dados automaticamente"
gps_validation:
  has_goal: true
  has_position: true
  has_steps: true
  analogy_count: 0
  diagram_count: 1
  reflective_questions: 0
voice_fidelity_target: 90
instructor: "Marcondes"
---

# Aula 3.3: Integração WhatsApp + CRM

---

## 🎯 GOAL

Conectar **WhatsApp → N8N → CRM** pra dados fluírem automaticamente.

---

## 🗺️ POSITION

Integração parece complexa. Mas é só API + webhook.

---

## 🛤️ STEPS

**[DIAGRAMA]**

```
WhatsApp (Evolution API)
        ↓ webhook
N8N (Processa)
        ↓ API call
CRM (Pipedrive)
```

### **Configuração**

1. **Evolution API:** Cria instância WhatsApp
2. **Webhook:** N8N recebe mensagens
3. **CRM API:** Cria/atualiza contato

---

## 🛠️ AÇÃO IMEDIATA

Configure **Evolution API** (tutorial fornecido).

Teste webhook com **1 mensagem**.

---

## 💡 O QUE VOCÊ DOMINOU

**Integrações = APIs + webhooks**

Não é magia. É chamada HTTP.

---

## 🔗 PRÓXIMA

**Personalização do prompt** (voz da empresa).

🚀

---

**Marcondes**
