---
lesson_id: "3.2"
title: "SDR Agent (Parte 1): Fluxo de Qualificação no N8N"
module: "Módulo 3 - Construção Essencial"
duration_minutes: 15
lesson_type: "hands-on"
learning_objectives:
  - "Criar fluxo básico: webhook → GPT → decisão → ação"
  - "Configurar qualificação de leads"
gps_validation:
  has_goal: true
  has_position: true
  has_steps: true
  analogy_count: 0
  diagram_count: 1
  reflective_questions: 1
voice_fidelity_target: 90
instructor: "Marcondes"
---

# Aula 3.2: SDR Agent - Fluxo de Qualificação

---

## 🎯 GOAL

Você vai ter o **fluxo básico** de qualificação no N8N (recebe → qualifica → notifica).

---

## 🗺️ POSITION

Não precisa ser dev sênior. N8N é **visual** (arrastar e soltar).

---

## 🛤️ STEPS

### **Estrutura do Fluxo**

**[FLOWCHART]**

```
WEBHOOK (WhatsApp)
        ↓
GPT-4 (Qualifica lead)
        ↓
IF (Lead quente?)
    SIM → Notifica corretor
    NÃO → Follow-up automático
```

### **Passos Práticos**

1. **Webhook:** Recebe mensagem do WhatsApp
2. **GPT Node:** Envia pra GPT-4 com prompt de qualificação
3. **IF Node:** Decide se lead é quente ou frio
4. **Action:** Notifica ou agenda follow-up

🤔 **Reflita:**
- Qual parte você tem mais dúvida?

---

## 🛠️ AÇÃO IMEDIATA

Importe template N8N fornecido.

Teste enviando **1 mensagem**.

---

## 💡 O QUE VOCÊ DOMINOU

**Fluxo básico: webhook → GPT → decisão → ação**

É isso. Resto é variação disso.

---

## 🔗 PRÓXIMA

**Integração WhatsApp + CRM** (conectar tudo).

🚀

---

**Marcondes** | CEO - Agência Lendária
