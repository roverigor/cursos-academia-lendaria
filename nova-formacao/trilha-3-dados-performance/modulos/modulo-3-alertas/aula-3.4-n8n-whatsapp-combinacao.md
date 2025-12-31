# Aula 3.4: n8n + WhatsApp - A Combinação Poderosa

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Ferramenta principal + Alternativas) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai entender como n8n + Evolution API funcionam juntos pra enviar alertas no WhatsApp — e conhecer as alternativas.**
>
> Você vai saber qual caminho seguir pro seu contexto.

---

## 🗺️ P - POSITION (Origem)

> "Automação? Isso é pra quem é técnico."
>
> Eu entendo o receio.
>
> Mas o n8n é visual. Você arrasta blocos, conecta, e funciona.
>
> Se você conseguiu criar o dashboard no Looker, consegue fazer isso.
>
> E vou te mostrar alternativas mais simples também.

---

## 🛤️ S - STEPS (Rota)

### Por Que n8n + WhatsApp?

**A Analogia do Carteiro**

> Imagine que você quer ser avisado toda vez que algo importante acontece.
>
> **n8n** = O carteiro. Ele verifica seus dados, vê se tem algo errado, e decide se precisa enviar mensagem.
>
> **Evolution API** = O telefone. É o canal por onde a mensagem chega (WhatsApp).
>
> **Você** = Recebe a mensagem no celular e age.
>
> O n8n olha seus dados → encontra problema → manda via Evolution → você recebe no WhatsApp.

---

### O Fluxo Completo

```
[DIAGRAMA: Fluxo de Alerta]

┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   DADOS     │     │    n8n      │     │  EVOLUTION  │     │  WHATSAPP   │
│  (Sheets)   │────▶│ (Verifica)  │────▶│    API      │────▶│   (Você)    │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
                           │
                           ▼
                    "Faturamento < R$1K?"
                           │
                    ┌──────┴──────┐
                    │             │
                   SIM           NÃO
                    │             │
                    ▼             ▼
               🔔 Envia      ⏸️ Não faz
                alerta         nada
```

---

### Comparativo de Ferramentas

| Ferramenta | Preço | Dificuldade | Melhor pra |
|------------|-------|-------------|------------|
| **n8n + Evolution** | Grátis (self-host) | ⭐⭐⭐ Médio | Controle total, gratuito |
| **Zapier + Twilio** | $20-50/mês | ⭐⭐ Fácil | Quem quer simplicidade |
| **Make (Integromat)** | $10-30/mês | ⭐⭐ Fácil | Alternativa ao Zapier |
| **Google Apps Script** | Grátis | ⭐⭐⭐⭐ Técnico | Quem já programa |
| **Pabbly Connect** | $25/mês | ⭐⭐ Fácil | Custo-benefício |

**Minha recomendação:**
- Quer gratuito e controle? → **n8n + Evolution API**
- Quer mais fácil (pago)? → **Zapier ou Make**
- Quer gratuito e simples? → **Google Apps Script** (mas precisa código)

---

### Setup Básico do n8n

**Opção 1: Cloud (mais fácil)**
- Acesse n8n.io
- Crie conta gratuita (limited)
- Ou plano pago ($20/mês)

**Opção 2: Self-hosted (gratuito, mais técnico)**
- Instala no seu servidor
- Controle total
- Precisa de conhecimento técnico

**Evolution API:**
- API gratuita pra WhatsApp
- Conecta via QR Code
- evolution-api.com

---

### 🤔 Pergunta Reflexiva

> "Qual seu nível de conforto com ferramentas técnicas?"
>
> Se você é iniciante: Zapier ou Make (pago, mas simples).
>
> Se você quer aprender: n8n (gratuito, curva de aprendizado).
>
> Se você tem time técnico: n8n self-hosted (controle total).

---

### O Que Vamos Usar na Demo

Na próxima aula, vou demonstrar com **n8n cloud**.

Mas a lógica é a mesma pra qualquer ferramenta:
1. Conectar à fonte de dados
2. Definir condição (se X < Y)
3. Enviar mensagem (WhatsApp/E-mail)

---

## 💡 Revisão

**Os 2 Insights:**

1. **n8n = cérebro, WhatsApp = canal** — Um verifica, outro entrega. São complementares.

2. **Alternativas existem** — Zapier/Make são mais fáceis se você preferir pagar.

**A Transformação:**
- **Antes:** "Automação é coisa de programador"
- **Depois:** "Posso criar alertas visuais sem código"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Decida qual ferramenta usar (n8n, Zapier, Make)
2. Crie conta na ferramenta escolhida
3. Explore a interface por 2 minutos

**Funcionou se:** Você está logado na ferramenta de automação.

---

## 🎬 HOOK - Próxima Aula

> Você tem a ferramenta.
>
> Agora vem a parte prática: configurar seu primeiro alerta.
>
> Na próxima aula, você vai me ver criando um alerta do zero — da conexão ao recebimento no WhatsApp.
>
> **Próxima aula: 3.5 - Configurando Seu Primeiro Alerta**

---

*Aula 3.4 - Trilha 3 - Academia Lendária*
