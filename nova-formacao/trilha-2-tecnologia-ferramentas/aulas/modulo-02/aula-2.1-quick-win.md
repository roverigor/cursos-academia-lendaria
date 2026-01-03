# Aula 2.1: Primeira Automacao em 10 Minutos

## Tipo: Quick Win | Duracao: 10 minutos

---

## GPS

### Goal (30s)
Criar sua primeira automacao funcional em 10 minutos — sem codigo, sem complicacao.

### Position (60s)
Automacao parece dificil ate voce fazer a primeira. Depois disso, voce ve possibilidades em tudo.

### Steps
1. Acessar n8n (2 min)
2. Criar fluxo simples (5 min)
3. Testar e ver funcionando (3 min)

---

## Passo 1: Acesse o n8n

**Opcao A: n8n Cloud (mais facil)**
1. Acesse: https://n8n.io
2. Clique em "Start Free"
3. Crie conta

**Opcao B: n8n Local (gratis total)**
```bash
npx n8n
```

---

## Passo 2: Sua Primeira Automacao

Vamos criar: **Webhook que envia email**

### 2.1 Adicione o Trigger

1. Clique em "+"
2. Busque "Webhook"
3. Selecione "Webhook"
4. Copie a URL do webhook

### 2.2 Adicione a Acao

1. Clique no "+" apos o Webhook
2. Busque "Send Email" ou "Gmail"
3. Configure:
   - To: seu email
   - Subject: "Teste n8n funcionando!"
   - Body: "Se voce recebeu isso, sua automacao funciona!"

### 2.3 Conecte

1. Arraste a linha do Webhook para o Email
2. Clique em "Execute Workflow"
3. Ative o workflow (toggle no topo)

---

## Passo 3: Teste

1. Copie a URL do Webhook
2. Abra em uma nova aba do navegador
3. Verifique seu email

**Funcionou?** Parabens! Voce criou sua primeira automacao.

---

## O Que Acabou de Acontecer

```
[Voce acessou URL] → [n8n recebeu] → [n8n enviou email] → [Voce recebeu]
```

Isso e a base de TODA automacao:
- **Trigger**: algo inicia o fluxo
- **Acao**: algo acontece como resultado

---

## Variacoes Rapidas

| Em vez de email... | Use... |
|-------------------|--------|
| Slack | Node "Slack" |
| WhatsApp | Node "WhatsApp" (via Evolution API) |
| Planilha | Node "Google Sheets" |
| CRM | Node do seu CRM |

---

## Reflexao

| Pergunta | Resposta |
|----------|----------|
| Funcionou de primeira? | Sim / Nao |
| Quanto tempo levou? | ___ min |
| O que mais eu poderia automatizar com isso? | |

---

## Proximo Passo

Na proxima aula, vamos entender todos os conceitos do n8n para criar automacoes mais complexas.
