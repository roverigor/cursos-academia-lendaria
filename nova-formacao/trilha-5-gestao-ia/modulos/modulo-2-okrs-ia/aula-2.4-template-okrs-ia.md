# Aula 2.4: Template de OKRs + IA como Tracker

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Sistema de OKRs com IA |
| **Aula** | 2.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Template completo + Check-in com IA) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter o template completo de OKRs — e um prompt de IA para fazer check-ins semanais.**
>
> Ferramenta pronta para usar.

---

## 🗺️ P - POSITION (Origem)

> "Entendi OKR. Mas como organizo na prática?"
>
> Com template e ritual.
>
> Vou te dar os dois.
>
> E a IA vai te ajudar a manter consistência.

---

## 🛤️ S - STEPS (Rota)

### O Template Completo de OKRs

```markdown
# OKRs - [Nome da Empresa] - Q[X]/[ANO]

**Período:** [Data início] a [Data fim]
**Última atualização:** [DD/MM/AAAA]

---

## 🎯 OBJETIVO 1: [Título inspirador]

**Responsável:** [Nome]
**Progresso geral:** [X]%

| Key Result | Início | Meta | Atual | % | Status |
|------------|--------|------|-------|---|--------|
| KR1: [Descrição] | [valor] | [valor] | [valor] | [X]% | 🟢/🟡/🔴 |
| KR2: [Descrição] | [valor] | [valor] | [valor] | [X]% | 🟢/🟡/🔴 |
| KR3: [Descrição] | [valor] | [valor] | [valor] | [X]% | 🟢/🟡/🔴 |

**Principais iniciativas:**
- [ ] Iniciativa 1
- [ ] Iniciativa 2
- [ ] Iniciativa 3

**Bloqueios atuais:**
- [Descrever bloqueio se houver]

**Notas da semana:**
- [Insight ou aprendizado]

---

## 🎯 OBJETIVO 2: [Título inspirador]

[Mesmo formato acima]

---

## 🎯 OBJETIVO 3: [Título inspirador]

[Mesmo formato acima]

---

## 📊 HISTÓRICO DE CHECK-INS

| Semana | O1 | O2 | O3 | Foco da Semana |
|--------|----|----|----|----|
| Sem 1 | [X]% | [X]% | [X]% | [Descrição] |
| Sem 2 | [X]% | [X]% | [X]% | [Descrição] |
| ... | | | | |
| Sem 12 | [X]% | [X]% | [X]% | [Descrição] |

---

*Revisão final do trimestre: [DD/MM/AAAA]*
```

---

### Cálculo de Progresso

**Fórmula para cada Key Result:**

```
Progresso = (Atual - Início) / (Meta - Início) × 100

Exemplo:
- Início: 8%
- Meta: 15%
- Atual: 11%

Progresso = (11 - 8) / (15 - 8) × 100 = 3/7 × 100 = 43%
```

**Progresso do Objetivo = Média dos KRs**

---

### Sistema de Cores

| Cor | Significado | Ação |
|-----|-------------|------|
| 🟢 Verde | No ritmo ou acima (>60% do esperado) | Manter |
| 🟡 Amarelo | Levemente atrasado (40-60% do esperado) | Atenção |
| 🔴 Vermelho | Atrasado (<40% do esperado) | Intervenção |

**Expectativa por semana:**

| Semana | Progresso Esperado |
|--------|-------------------|
| 1/12 | ~8% |
| 4/12 | ~33% |
| 8/12 | ~67% |
| 12/12 | ~100% |

---

### Prompt de Check-in Semanal com IA

**Cole no Claude/ChatGPT toda segunda-feira:**

```
Sou dono de um negócio e uso OKRs trimestrais.

Aqui estão meus OKRs atuais com o progresso:

[COLAR SEU TEMPLATE DE OKRs ATUALIZADO]

Estamos na semana [X] de 12 do trimestre.

Analise e me diga:

1. DIAGNÓSTICO: Qual OKR está mais em risco? Por quê?

2. PRIORIDADE: O que eu deveria focar ESTA SEMANA para destravar?

3. ALERTA: Tem algum KR que, no ritmo atual, não vai bater a meta?

4. SUGESTÃO: Uma ação específica de alto impacto para os próximos 7 dias.

5. CELEBRAÇÃO: Algum progresso que mereço reconhecer?

Seja direto. Prefiro honestidade a otimismo.
```

---

### O Que Esperar da Resposta da IA

A IA normalmente vai:

| Tipo de Análise | Exemplo de Resposta |
|-----------------|---------------------|
| **Identificar risco** | "KR2 de conversão está 20% abaixo do ritmo necessário" |
| **Recomendar foco** | "Priorize resolver o gargalo no follow-up antes de gerar mais leads" |
| **Projetar resultado** | "No ritmo atual, você chega em 11%, não 15%" |
| **Sugerir ação** | "Implemente script de follow-up D+1 para oportunidades" |
| **Reconhecer avanço** | "Churn caiu 0.5% - é um bom sinal de que onboarding melhorou" |

---

### Ritual de Check-in Semanal

```
[DIAGRAMA: Ritual Segunda-feira]

┌─────────────────────────────────────────────────────┐
│  SEGUNDA-FEIRA - 30 MINUTOS                         │
│                                                     │
│  09:00 │ Atualizar números (10 min)                │
│        │ - Puxar dados de vendas, financeiro, etc. │
│        │ - Atualizar "Atual" em cada KR            │
│        │                                           │
│  09:10 │ Calcular progresso (5 min)                │
│        │ - Atualizar % de cada KR                  │
│        │ - Atualizar % geral do Objetivo           │
│        │                                           │
│  09:15 │ Rodar prompt de check-in (10 min)         │
│        │ - Colar template na IA                    │
│        │ - Ler análise                             │
│        │                                           │
│  09:25 │ Definir foco da semana (5 min)            │
│        │ - 1 ação principal baseada na análise     │
│        │ - Anotar em "Notas da semana"             │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### Onde Criar

| Ferramenta | Vantagem |
|------------|----------|
| **Notion** | Dashboards visuais, colaborativo |
| **Google Sheets** | Automação de cálculos |
| **Google Docs** | Simples, acessível |
| **Obsidian** | Integra com outras notas |

**Recomendação:** Comece no Google Sheets para ter os cálculos automáticos.

---

### 🤔 Pergunta Reflexiva

> "Você já teve uma meta que não olhou por semanas?"
>
> O que aconteceu com ela?
>
> OKR sem check-in semanal vira decoração.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Template estruturado acelera** — Não precisa inventar, só preencher.

2. **IA como coach semanal** — Check-in assistido mantém você honesto e focado.

**A Transformação:**
- **Antes:** "Defino metas e esqueço"
- **Depois:** "Tenho ritual semanal de acompanhamento"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Copie o template acima
2. Cole num Google Sheets ou Notion
3. Preencha pelo menos o nome do seu negócio e o período

**Funcionou se:** Você tem o template criado e acessível.

---

## 🎬 HOOK - Próxima Aula

> Você tem a ferramenta.
>
> Agora vai me ver USANDO.
>
> Na próxima aula, vou criar OKRs ao vivo para um negócio real — do zero ao template preenchido.
>
> **Próxima aula: 2.5 - Criando OKRs do Trimestre ao Vivo**

---

*Aula 2.4 - Trilha 5 - Academia Lendária*
