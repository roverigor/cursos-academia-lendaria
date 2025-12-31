# Aula 5.5: Montando Meu Painel ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 5 - Painel do CEO com IA |
| **Aula** | 5.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 2 (Montagem do painel + Geração de relatório) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter visto um Painel do CEO sendo montado do zero — com números, cores e relatório gerado por IA.**
>
> Você vai saber exatamente como fazer o seu.

---

## 🗺️ P - POSITION (Origem)

> "Entendi o template. Mas como preencher na prática?"
>
> Vou te mostrar.
>
> Vou montar o painel do nosso exemplo (SaaS Analytics Pro).
>
> Do zero ao relatório.

---

## 🛤️ S - STEPS (Rota)

### Contexto: A Empresa de Exemplo

**SaaS Analytics Pro**
- Faturamento: R$ 120K/mês
- 12 funcionários
- Semana 5 do Q1
- OKRs definidos nos módulos anteriores

---

### Passo 1: Coletar os Números (5 min)

**Fontes de dados:**

| Número | Onde encontrar | Valor atual |
|--------|----------------|-------------|
| Faturamento | ERP/Contabilidade | R$ 105K |
| Margem | Planilha financeira | 19% |
| Caixa | Banco + previsão | 2.8 meses |
| Leads | CRM | 480 |
| Conversão | CRM (fechados/total) | 9% |
| Churn | Planilha CS | 3.2% |
| NPS | Ferramenta de pesquisa | 55 |
| Capacidade | Feeling + timesheet | 88% |
| SLA | Sistema de tickets | 94% |
| OKRs | Template de OKRs | 45% |
| Maior cliente | Planilha | 24% |
| Runway | Caixa ÷ burn | 9 meses |

---

### Passo 2: Preencher o Template (5 min)

```markdown
# PAINEL DO CEO - SaaS Analytics Pro

**Atualização:** 13/01/2025 | **Período:** Semana 5/12 do Q1

---

## 🚨 ALERTAS

| Alerta | Métrica | Status | Ação Necessária |
|--------|---------|--------|-----------------|
| Faturamento abaixo | R$105K vs R$120K meta | 🔴 | Acelerar fechamentos |
| Capacidade alta | 88% (limite 85%) | 🔴 | Revisar alocação |

---

## 💰 FINANCEIRO

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| Faturamento | R$105K | R$120K | 88% | ↓ | 🔴 |
| Margem líquida | 19% | 25% | 76% | → | 🔴 |
| Caixa (meses) | 2.8 | 4 | 70% | ↑ | 🟡 |

**Observação:** Margem pressionada por custo de aquisição alto.

---

## 📈 COMERCIAL

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| Leads/mês | 480 | 500 | 96% | ↑ | 🟢 |
| Conversão | 9% | 12% | 75% | ↑ | 🟡 |
| Churn | 3.2% | 2% | - | ↓ | 🟡 |

**Observação:** Conversão melhorando após implementar follow-up D+1.

---

## ⚙️ OPERACIONAL

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| NPS | 55 | 60 | 92% | ↑ | 🟢 |
| Capacidade equipe | 88% | <85% | - | ↑ | 🔴 |
| SLA | 94% | 95% | 99% | → | 🟢 |

**Observação:** Equipe no limite - precisa de contratação ou redução de escopo.

---

## 🎯 ESTRATÉGICO

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| OKRs (progresso) | 45% | 42% esperado | 107% | ↑ | 🟢 |
| Maior cliente | 24% | <20% | - | ↓ | 🟡 |
| Runway | 9 meses | 6+ | 150% | → | 🟢 |

**Observação:** OKRs no ritmo. Concentração melhorando com novos clientes.

---

## 📊 RESUMO DA SEMANA

**Vitórias:**
- Conversão subiu de 8% para 9%
- Churn caiu para 3.2%
- OKRs acima do esperado

**Desafios:**
- Faturamento 12% abaixo
- Equipe no limite de capacidade

**Foco da próxima semana:**
- Fechar 3 deals pendentes
- Definir priorização de projetos (liberar capacidade)
```

---

### Passo 3: Gerar Relatório com IA (3 min)

**Prompt enviado:**

```
Sou CEO de um SaaS B2B com 12 funcionários.

Números da semana 5 do Q1:

FINANCEIRO:
- Faturamento: R$105K (meta R$120K)
- Margem: 19% (meta 25%)
- Caixa: 2.8 meses

COMERCIAL:
- Leads: 480 (meta 500)
- Conversão: 9% (meta 12%)
- Churn: 3.2% (meta 2%)

OPERACIONAL:
- NPS: 55 (meta 60)
- Capacidade: 88% (limite 85%)
- SLA: 94%

ESTRATÉGICO:
- OKRs: 45% (semana 5/12, esperado 42%)
- Maior cliente: 24% da receita

Gere relatório executivo com resumo, alertas, tendências,
recomendações e pergunta estratégica.
```

**Relatório gerado:**

```markdown
# RELATÓRIO EXECUTIVO - Semana 5

## RESUMO
Faturamento 12% abaixo da meta é o principal alerta, mas
indicadores leading (conversão, churn) estão melhorando.
Equipe sobrecarregada pode comprometer entregas se não
houver intervenção.

## ALERTAS 🔴
• Faturamento R$105K vs R$120K meta (-12%)
• Capacidade equipe 88% - acima do limite saudável
• Margem 19% ainda longe dos 25% target

## TENDÊNCIAS
↑ Melhorando: Conversão (8%→9%), Churn (4%→3.2%), Leads
↓ Piorando: Capacidade (85%→88%)
→ Estável: Margem, SLA, NPS

## RECOMENDAÇÕES
1. **Priorizar fechamentos:** 3 deals pendentes podem
   resolver gap de faturamento
2. **Aliviar equipe:** Pausar 1-2 projetos não-críticos
   ou terceirizar tarefa específica
3. **Proteger margem:** Revisar custo de aquisição das
   campanhas menos eficientes

## PERGUNTA ESTRATÉGICA
"Se a conversão chegar a 12% e churn a 2% (metas do Q1),
qual será o impacto no faturamento? Isso fecha o gap?"

---
Status geral: 🟡 Atenção
Próxima atualização: 20/01/2025
```

---

### Passo 4: Definir Foco (2 min)

**Baseado no relatório:**

```
FOCO DA SEMANA 6:

1. FECHAMENTOS
   - João liga para os 3 deals pendentes até quarta
   - Meta: fechar pelo menos 2

2. CAPACIDADE
   - Reunião com líderes terça: priorizar projetos
   - Identificar o que pode pausar sem impacto crítico

3. MARGEM
   - Ana analisa CAC por canal até sexta
   - Pausa campanha menos eficiente
```

---

### Resultado Final

```
[DIAGRAMA: Painel Completo]

┌─────────────────────────────────────────────────────┐
│                 PAINEL DO CEO                       │
│              SaaS Analytics Pro                     │
│              Semana 5/12 - Q1/2025                 │
│                                                     │
│  🚨 ALERTAS: 2 (Faturamento, Capacidade)           │
│                                                     │
│  ┌─────────────────┐  ┌─────────────────┐          │
│  │ 💰 FINANCEIRO   │  │ 📈 COMERCIAL    │          │
│  │                 │  │                 │          │
│  │ Fat: R$105K 🔴  │  │ Leads: 480 🟢   │          │
│  │ Marg: 19% 🔴    │  │ Conv: 9% 🟡    │          │
│  │ Caixa: 2.8m 🟡  │  │ Churn: 3.2% 🟡 │          │
│  └─────────────────┘  └─────────────────┘          │
│                                                     │
│  ┌─────────────────┐  ┌─────────────────┐          │
│  │ ⚙️ OPERACIONAL  │  │ 🎯 ESTRATÉGICO  │          │
│  │                 │  │                 │          │
│  │ NPS: 55 🟢      │  │ OKRs: 45% 🟢   │          │
│  │ Cap: 88% 🔴     │  │ Conc: 24% 🟡   │          │
│  │ SLA: 94% 🟢     │  │ Runway: 9m 🟢  │          │
│  └─────────────────┘  └─────────────────┘          │
│                                                     │
│  FOCO: Fechar 3 deals + Aliviar capacidade         │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### 🤔 Pergunta Reflexiva

> "Você consegue ver como 15 minutos geram visão completa?"
>
> Sem painel: 1 hora juntando informação.
> Com painel: 15 minutos e decisão pronta.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Coleta + Template + IA = Clareza** — O processo é simples quando estruturado.

2. **Relatório de IA complementa** — Ela vê padrões e faz perguntas que você não faria.

**A Transformação:**
- **Antes:** "Não tenho tempo de analisar números"
- **Depois:** "Em 15 minutos tenho visão e foco da semana"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Liste as fontes dos seus 12 números (onde cada um vive)
2. Estime quanto tempo levaria para coletar todos
3. Identifique 1 número que é difícil de achar

**Funcionou se:** Você sabe onde buscar cada número.

---

## 🎬 HOOK - Próxima Aula

> Você viu como se faz.
>
> Agora é SUA VEZ.
>
> Na próxima aula, você vai construir seu Painel do CEO — com seus números reais.
>
> **Próxima aula: 5.6 - Seu Turno: Construa Seu Painel**

---

*Aula 5.5 - Trilha 5 - Academia Lendária*
