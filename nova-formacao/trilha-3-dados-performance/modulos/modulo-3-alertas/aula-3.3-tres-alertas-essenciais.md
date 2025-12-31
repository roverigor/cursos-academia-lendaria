# Aula 3.3: Os 3 Alertas que Todo Negócio Precisa

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.3 |
| **Tipo** | Conceitual |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Framework + 3 tipos de alerta) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai saber QUAIS alertas configurar — os 3 tipos que cobrem 80% das situações críticas.**
>
> Você vai sair com uma lista concreta do que monitorar.

---

## 🗺️ P - POSITION (Origem)

> "Posso criar alerta pra tudo?"
>
> Pode. Mas não deve.
>
> Alerta demais = ruído. Você começa a ignorar.
>
> O segredo é escolher os CERTOS.
>
> Vou te mostrar os 3 que não podem faltar.

---

## 🛤️ S - STEPS (Rota)

### O Framework dos 3 Alertas

```
[DIAGRAMA: 3 Tipos de Alerta]

┌─────────────────────────────────────────────┐
│          🚨 ALERTA 1: CRISE                 │
│          "O prédio está pegando fogo"       │
│          → Ação IMEDIATA (minutos)          │
├─────────────────────────────────────────────┤
│          ⚠️ ALERTA 2: TENDÊNCIA             │
│          "A temperatura está subindo"       │
│          → Ação em HORAS/DIAS               │
├─────────────────────────────────────────────┤
│          📊 ALERTA 3: META                  │
│          "Estamos longe do objetivo"        │
│          → Ação em DIAS/SEMANA              │
└─────────────────────────────────────────────┘
```

---

### Alerta 1: CRISE (Urgente)

**Quando dispara:** Algo está CRITICAMENTE errado AGORA.

**Exemplos:**
| Negócio | Alerta de Crise |
|---------|-----------------|
| E-commerce | Site fora do ar |
| SaaS | Churn diário > 3x média |
| Agência | Campanha pausada por falta de saldo |
| Varejo | Estoque zerou em produto-chave |

**Configuração:**
- Frequência: **Tempo real ou a cada hora**
- Canal: **WhatsApp** (alta prioridade)
- Ação: Resolver em minutos/horas

**Regra de ouro:** Se não precisa acordar às 3h da manhã pra isso, não é alerta de crise.

---

### Alerta 2: TENDÊNCIA (Atenção)

**Quando dispara:** Algo está PIORANDO de forma consistente.

**Exemplos:**
| Negócio | Alerta de Tendência |
|---------|---------------------|
| Qualquer | Faturamento 3 dias seguidos abaixo da média |
| SaaS | Conversão trial→pago caiu 20% na semana |
| E-commerce | Ticket médio caindo há 5 dias |
| Serviços | Tempo de entrega aumentando |

**Configuração:**
- Frequência: **Diário (manhã)**
- Canal: **WhatsApp ou E-mail**
- Ação: Investigar e planejar

**Regra de ouro:** Se está piorando por 3+ dias, algo está errado.

---

### Alerta 3: META (Acompanhamento)

**Quando dispara:** Estamos LONGE de atingir a meta do período.

**Exemplos:**
| Negócio | Alerta de Meta |
|---------|----------------|
| Qualquer | Dia 15: <40% da meta mensal |
| Vendas | Semana 3: <75% da meta semanal |
| Marketing | Leads da semana <50% esperado |

**Configuração:**
- Frequência: **Semanal ou quinzenal**
- Canal: **E-mail ou WhatsApp**
- Ação: Ajustar estratégia

**Regra de ouro:** Se no meio do período você está muito longe, precisa mudar algo.

---

### 🤔 Pergunta Reflexiva

> "Olha pros seus 5-7 métricas do dashboard."
>
> "Qual merece alerta de CRISE? De TENDÊNCIA? De META?"
>
> Nem toda métrica precisa de alerta. Só as que exigem AÇÃO.

---

### Template de Alertas

| # | Tipo | Métrica | Condição | Canal |
|---|------|---------|----------|-------|
| 1 | 🚨 Crise | Faturamento diário | < R$500 | WhatsApp |
| 2 | 🚨 Crise | Churn diário | > 2 clientes | WhatsApp |
| 3 | ⚠️ Tendência | Conversão | 3 dias < 5% | WhatsApp |
| 4 | ⚠️ Tendência | Leads | 3 dias < média | E-mail |
| 5 | 📊 Meta | Faturamento | Dia 15 < 40% meta | WhatsApp |

---

## 💡 Revisão

**Os 2 Insights:**

1. **3 tipos cobrem tudo** — Crise (imediato), Tendência (atenção), Meta (acompanhamento).

2. **Menos é mais** — 5-7 alertas bem escolhidos > 50 alertas que você ignora.

**A Transformação:**
- **Antes:** "Vou criar alerta pra tudo"
- **Depois:** "Vou criar 5-7 alertas estratégicos"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Copie o template acima
2. Preencha com SUAS métricas e condições
3. Defina pelo menos: 2 de crise, 2 de tendência, 1 de meta

**Funcionou se:** Você tem 5 alertas definidos com condições específicas.

---

## 🎬 HOOK - Próxima Aula

> Você sabe QUAIS alertas criar.
>
> Agora precisa de uma FERRAMENTA.
>
> Na próxima aula, vou te apresentar o n8n + Evolution API — a combinação que envia alertas pro seu WhatsApp.
>
> Gratuito. Potente. E mais fácil do que parece.
>
> **Próxima aula: 3.4 - n8n + WhatsApp: A Combinação Poderosa**

---

*Aula 3.3 - Trilha 3 - Academia Lendária*
