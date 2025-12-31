# Aula 5.4: Template de Painel + IA para Relatórios

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 5 - Painel do CEO com IA |
| **Aula** | 5.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Template completo + Prompt de relatório) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter o template completo do Painel do CEO — e um prompt de IA para gerar relatórios semanais automáticos.**
>
> Ferramentas prontas para usar.

---

## 🗺️ P - POSITION (Origem)

> "Onde monto o painel? Como gero relatórios?"
>
> Com template e IA.
>
> Vou te dar as duas ferramentas.
>
> Você só precisa preencher e usar.

---

## 🛤️ S - STEPS (Rota)

### O Template Completo do Painel

```markdown
# PAINEL DO CEO - [Nome da Empresa]

**Atualização:** [DD/MM/AAAA] | **Período:** Semana [X]

---

## 🚨 ALERTAS (O que precisa de atenção AGORA)

| Alerta | Métrica | Status | Ação Necessária |
|--------|---------|--------|-----------------|
| | | 🔴 | |
| | | 🔴 | |

---

## 💰 FINANCEIRO

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| Faturamento | R$ | R$ | % | ↑/↓/→ | 🟢/🟡/🔴 |
| Margem líquida | % | % | - | ↑/↓/→ | 🟢/🟡/🔴 |
| Caixa (meses) | | | - | ↑/↓/→ | 🟢/🟡/🔴 |

**Observação:** [Nota relevante]

---

## 📈 COMERCIAL

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| Leads/mês | | | % | ↑/↓/→ | 🟢/🟡/🔴 |
| Conversão | % | % | - | ↑/↓/→ | 🟢/🟡/🔴 |
| Churn | % | % | - | ↑/↓/→ | 🟢/🟡/🔴 |

**Observação:** [Nota relevante]

---

## ⚙️ OPERACIONAL

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| NPS/CSAT | | | - | ↑/↓/→ | 🟢/🟡/🔴 |
| Capacidade equipe | % | <85% | - | ↑/↓/→ | 🟢/🟡/🔴 |
| SLA/Entregas no prazo | % | % | - | ↑/↓/→ | 🟢/🟡/🔴 |

**Observação:** [Nota relevante]

---

## 🎯 ESTRATÉGICO

| Métrica | Atual | Meta | % | Tendência | Status |
|---------|-------|------|---|-----------|--------|
| OKRs (progresso geral) | % | % esperado | - | ↑/↓/→ | 🟢/🟡/🔴 |
| Maior cliente (% receita) | % | <20% | - | ↑/↓/→ | 🟢/🟡/🔴 |
| Runway (meses) | | 6+ | - | ↑/↓/→ | 🟢/🟡/🔴 |

**Observação:** [Nota relevante]

---

## 📊 RESUMO DA SEMANA

**Vitórias:**
-
-

**Desafios:**
-
-

**Foco da próxima semana:**
-

---

## 📈 HISTÓRICO (últimas 4 semanas)

| Semana | Fat. | Leads | Conv. | Churn | OKRs |
|--------|------|-------|-------|-------|------|
| S-4 | | | | | |
| S-3 | | | | | |
| S-2 | | | | | |
| S-1 | | | | | |
| Atual | | | | | |

---

*Próxima atualização: [DATA]*
```

---

### Sistema de Cores

| Cor | Significado | Quando usar |
|-----|-------------|-------------|
| 🟢 Verde | No target ou acima | Meta atingida ou >90% |
| 🟡 Amarelo | Atenção necessária | Entre 70-90% da meta |
| 🔴 Vermelho | Ação urgente | <70% da meta ou piora 2+ semanas |

---

### Prompt de IA para Relatório Semanal

**Cole no Claude/ChatGPT toda segunda-feira:**

```
Sou CEO de [TIPO DE NEGÓCIO] com [X] funcionários.

Aqui estão os números da semana:

FINANCEIRO:
- Faturamento: R$[X] (meta R$[X])
- Margem: [X]% (meta [X]%)
- Caixa: [X] meses

COMERCIAL:
- Leads: [X] (meta [X])
- Conversão: [X]% (meta [X]%)
- Churn: [X]% (meta [X]%)

OPERACIONAL:
- NPS: [X] (meta [X])
- Capacidade equipe: [X]%
- SLA: [X]% entregas no prazo

ESTRATÉGICO:
- OKRs: [X]% progresso (semana [X] de 12)
- Maior cliente: [X]% da receita

Gere um relatório executivo com:

1. RESUMO EM 3 FRASES
   O que mais importa essa semana

2. ALERTAS (🔴)
   O que precisa de ação imediata

3. TENDÊNCIAS
   O que está melhorando/piorando

4. RECOMENDAÇÕES
   Top 3 ações para próxima semana

5. PERGUNTA ESTRATÉGICA
   Uma pergunta que eu deveria me fazer

Seja direto e objetivo. Formato: bullet points.
```

---

### Exemplo de Relatório Gerado pela IA

```markdown
# RELATÓRIO EXECUTIVO - Semana 5

## 1. RESUMO
Faturamento 15% abaixo da meta pressionado por conversão
em queda. Churn controlado pela primeira vez em 3 semanas.
OKRs no ritmo, mas dependem de resolver o funil comercial.

## 2. ALERTAS 🔴
• Conversão caiu pela 3ª semana (de 12% para 8%)
• Margem abaixo de 20% - risco de caixa no Q2
• Leads estagnados há 2 semanas

## 3. TENDÊNCIAS
↑ Melhorando: Churn (de 4.5% para 3.5%)
↓ Piorando: Conversão, Margem
→ Estável: NPS, Capacidade

## 4. RECOMENDAÇÕES
1. Auditar funil: onde leads estão travando?
2. Revisar precificação para proteger margem
3. Implementar follow-up D+1 para oportunidades

## 5. PERGUNTA ESTRATÉGICA
"Se a conversão não melhorar em 2 semanas, qual
o impacto no faturamento do trimestre?"

---
Gerado em: 13/01/2025
```

---

### Onde Criar o Painel

| Ferramenta | Vantagem | Dificuldade |
|------------|----------|-------------|
| **Google Sheets** | Gratuito, colaborativo, fórmulas | Fácil |
| **Notion** | Bonito, integra tudo | Fácil |
| **Looker Studio** | Conecta com dados automaticamente | Médio |
| **Power BI** | Poderoso, dashboards dinâmicos | Difícil |

**Recomendação para começar:** Google Sheets ou Notion.
Depois migre para algo mais automatizado.

---

### Fluxo Semanal

```
[DIAGRAMA: Ritual de Atualização]

SEGUNDA-FEIRA - 45 MINUTOS

09:00 │ Coletar números (15 min)
      │ ├── Puxar faturamento do ERP
      │ ├── Atualizar leads do CRM
      │ └── Verificar OKRs
      │
09:15 │ Atualizar painel (10 min)
      │ ├── Preencher números
      │ ├── Calcular tendências
      │ └── Atribuir cores
      │
09:25 │ Gerar relatório com IA (10 min)
      │ ├── Colar prompt com números
      │ └── Revisar insights
      │
09:35 │ Definir foco (10 min)
      │ ├── Escolher 1-3 prioridades
      │ └── Comunicar equipe

45 min → Visão completa da semana
```

---

### 🤔 Pergunta Reflexiva

> "Se você tivesse esse relatório toda segunda às 9h..."
>
> "...quão mais rápido reagiria aos problemas?"
>
> Informação na hora certa = ação na hora certa.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Template estruturado acelera** — Não inventa, preenche.

2. **IA como analista semanal** — Ela vê padrões que você pode perder.

**A Transformação:**
- **Antes:** "Não tenho tempo de fazer relatórios"
- **Depois:** "Relatório em 45 min toda segunda"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Copie o template do painel
2. Cole num Google Sheets ou Notion
3. Preencha o nome da empresa e período

**Funcionou se:** Você tem o template criado e acessível.

---

## 🎬 HOOK - Próxima Aula

> Você tem a ferramenta.
>
> Agora vai me ver USANDO.
>
> Na próxima aula, vou montar meu painel ao vivo — do zero ao relatório pronto.
>
> **Próxima aula: 5.5 - Montando Meu Painel ao Vivo**

---

*Aula 5.4 - Trilha 5 - Academia Lendária*
