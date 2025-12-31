# Aula 5.5: Executando a Rotina ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 5 - Rotina de Decisão |
| **Aula** | 5.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 2 (Execução prática + Timing real) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter visto a rotina OIAD executada — 15 minutos cronometrados, do início ao fim.**
>
> Você vai saber exatamente como fazer a sua.

---

## 🗺️ P - POSITION (Origem)

> "Entendi a teoria. Mas na prática, como é?"
>
> Vou te mostrar.
>
> Vou fazer minha rotina na sua frente.
>
> Cronômetro rodando, passos reais.

---

## 🛤️ S - STEPS (Rota)

### Preparação (30 segundos)

**Antes de começar:**
- Dashboard aberto em uma aba
- Claude/ChatGPT aberto em outra aba
- Documento de anotações aberto
- Cronômetro iniciado

```
[SETUP]
┌─────────────────────────────────────────────────┐
│  🌐 Tab 1: Dashboard (Looker Studio)            │
│  🌐 Tab 2: IA (Claude ou ChatGPT)               │
│  🌐 Tab 3: Anotações (Google Doc)               │
│  ⏱️ Cronômetro: 15:00                           │
└─────────────────────────────────────────────────┘
```

---

### PASSO 1: OLHAR (0:00 - 3:00)

**Ações:**
1. Abro o dashboard
2. Olho rapidamente as métricas principais:
   - Faturamento do dia/mês
   - Conversão
   - Número de leads/vendas
3. Comparo com meta ou dia anterior
4. Verifico alertas (se tem algum pendente)

**O que procuro:**
- Algo muito acima ou abaixo do normal?
- Algum alerta disparou?
- Tendência preocupante?

**Exemplo de execução:**
```
[OLHAR - 3 minutos]

📊 Faturamento hoje: R$ 3.200 (meta: R$ 3.000) ✅
📈 Conversão: 4,2% (média: 5%) ⚠️ Abaixo
👥 Leads: 45 (ontem: 42) ✅
🔔 Alertas: Nenhum pendente ✅

➡️ Conversão abaixo do normal. Vou investigar.
```

---

### PASSO 2: INVESTIGAR (3:00 - 8:00)

**Ações:**
1. Algo chamou atenção (conversão abaixo)
2. Abro Claude/ChatGPT
3. Cole contexto + dados + pergunta
4. Leio a análise
5. Entendo a hipótese

**Prompt usado:**
```
Contexto: SaaS B2B, ticket médio R$500, conversão trial→pago normal é 5%.

Dados de hoje:
- Leads: 45 (normal)
- Trials iniciados: 12 (normal)
- Conversões: 5 (abaixo)
- Conversão: 4,2% (média 5%)

Por que a conversão pode ter caído?
O que devo investigar?
```

**Resposta da IA (resumo):**
```
Hipóteses:
1. Trials mais recentes (ainda não converteram)
2. Problema no onboarding (verificar conclusão)
3. Mudança no perfil de lead (verificar origem)

Sugestão: Checar taxa de conclusão de onboarding.
```

---

### PASSO 3: ANOTAR (8:00 - 11:00)

**Ações:**
1. Abro documento de anotações
2. Escrevo data + observação
3. Registro a hipótese

**Anotação do dia:**
```
30/01/2025 - Conversão 4,2% (abaixo da média 5%)
- Hipótese: leads mais recentes ainda não converteram
- IA sugeriu checar onboarding
- Volume de leads normal, conversão que caiu
```

---

### PASSO 4: DECIDIR (11:00 - 15:00)

**Ações:**
1. Baseado no que vi, defino 1 ação
2. Algo específico e executável hoje
3. Anoto a ação no documento
4. Fecho a rotina

**Ação do dia:**
```
AÇÃO: Verificar taxa de conclusão de onboarding no Pendo/Amplitude.
Se < 70%, criar ticket pra produto investigar.
```

**Rotina concluída:**
```
✅ OLHAR - Conversão abaixo
✅ INVESTIGAR - Hipótese: onboarding
✅ ANOTAR - Registrado
✅ DECIDIR - Checar taxa de onboarding

Tempo total: 14:32 ⏱️
```

---

### Visualização Completa

```
[DIAGRAMA: Execução Real]

⏱️ 0:00 ─────────────────────────────────────── 15:00

   OLHAR          INVESTIGAR       ANOTAR      DECIDIR
   (3 min)           (5 min)       (3 min)     (4 min)
     │                  │             │           │
     ▼                  ▼             ▼           ▼
┌─────────┐      ┌─────────┐    ┌─────────┐  ┌─────────┐
│Dashboard│ →    │Prompt IA│ →  │Registrar│→ │1 Ação   │
│Métricas │      │Análise  │    │Insight  │  │do Dia   │
│Alertas  │      │Hipótese │    │         │  │         │
└─────────┘      └─────────┘    └─────────┘  └─────────┘
     │                                            │
     └────────────────────────────────────────────┘
              14 minutos e 32 segundos
```

---

### Se Nada Estiver Fora do Normal

```
[CENÁRIO: Dia Normal]

OLHAR (3 min)
└── Tudo dentro do esperado ✅

INVESTIGAR (1 min)
└── Nada pra investigar, pulo

ANOTAR (2 min)
└── "Dia normal, métricas no padrão"

DECIDIR (2 min)
└── "Manter execução atual"

TEMPO TOTAL: 8 minutos ⏱️
```

**Dias normais são mais rápidos. E tudo bem.**

---

### 🤔 Pergunta Reflexiva

> "Você consegue imaginar fazendo isso todo dia?"
>
> 15 minutos. Passo a passo. Sem pensar muito.
>
> A mágica está na consistência.

---

## 💡 Revisão

**Os 2 Insights:**

1. **15 minutos são suficientes** — Se você segue o OIAD, dá tempo de sobra.

2. **Dias normais são mais rápidos** — Quando tudo está ok, 8-10 minutos bastam.

**A Transformação:**
- **Antes:** "Não sei como fazer na prática"
- **Depois:** "Vi exatamente como funciona"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Abra seu dashboard em uma aba
2. Abra Claude/ChatGPT em outra
3. Abra seu doc de anotações
4. Está pronto pra próxima aula (sua vez de fazer)

**Funcionou se:** Você tem as 3 tabs prontas.

---

## 🎬 HOOK - Próxima Aula

> Você viu como funciona.
>
> Agora é SUA VEZ.
>
> Na próxima aula, você vai executar sua primeira rotina OIAD com seus dados reais.
>
> Cronômetro ligado. 15 minutos. Vai.
>
> **Próxima aula: 5.6 - Seu Turno: Primeira Execução**

---

*Aula 5.5 - Trilha 3 - Academia Lendária*
