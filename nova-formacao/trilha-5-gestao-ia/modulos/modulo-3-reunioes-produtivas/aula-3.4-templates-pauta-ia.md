# Aula 3.4: Templates de Pauta + IA para Atas

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Reuniões Produtivas com IA |
| **Aula** | 3.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Templates de pauta + Prompt para atas) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter templates prontos para Daily, Weekly e Monthly — e um prompt de IA para gerar atas automaticamente.**
>
> Ferramentas prontas para usar amanhã.

---

## 🗺️ P - POSITION (Origem)

> "Como organizo a pauta de cada reunião?"
>
> Com template.
>
> E a IA pode transformar anotações bagunçadas em ata estruturada.
>
> Vou te dar os dois.

---

## 🛤️ S - STEPS (Rota)

### Template: DAILY (15 min)

```markdown
# DAILY - [DATA]

**Horário:** [HH:MM] | **Duração:** 15 min

---

## RODADA (2 min por pessoa)

| Pessoa | Ontem | Hoje | Bloqueio |
|--------|-------|------|----------|
| [Nome 1] | | | |
| [Nome 2] | | | |
| [Nome 3] | | | |
| [Nome 4] | | | |

---

## BLOQUEIOS A RESOLVER

| Bloqueio | Responsável | Prazo |
|----------|-------------|-------|
| | | |
| | | |

---

*Próxima daily: [DATA] às [HH:MM]*
```

---

### Template: WEEKLY (1 hora)

```markdown
# WEEKLY - [DATA]

**Horário:** [HH:MM] | **Duração:** 60 min
**Facilitador:** [Nome]

---

## 1. VITÓRIAS (5 min)
*Cada pessoa compartilha 1 vitória da semana*

- 🎉 [Pessoa 1]:
- 🎉 [Pessoa 2]:
- 🎉 [Pessoa 3]:

---

## 2. NÚMEROS (15 min)

### OKRs - Semana [X] de 12

| Objetivo | Progresso | Status | Nota |
|----------|-----------|--------|------|
| O1: [Nome] | [X]% | 🟢/🟡/🔴 | |
| O2: [Nome] | [X]% | 🟢/🟡/🔴 | |

### Métricas Críticas

| Métrica | Semana Passada | Esta Semana | Tendência |
|---------|----------------|-------------|-----------|
| Faturamento | R$ | R$ | ↑/↓/→ |
| Leads | | | ↑/↓/→ |
| Conversão | | | ↑/↓/→ |

---

## 3. PROBLEMAS (20 min)
*Top 3 problemas que precisam de decisão*

### Problema 1: [Título]
- **Contexto:**
- **Opções:**
- **Decisão:**
- **Responsável:**
- **Prazo:**

### Problema 2: [Título]
- **Contexto:**
- **Opções:**
- **Decisão:**
- **Responsável:**
- **Prazo:**

### Problema 3: [Título]
- **Contexto:**
- **Opções:**
- **Decisão:**
- **Responsável:**
- **Prazo:**

---

## 4. PRÓXIMA SEMANA (15 min)

| Área | Prioridade #1 | Compromisso |
|------|---------------|-------------|
| [Área 1] | | |
| [Área 2] | | |
| [Área 3] | | |

---

## 5. DECISÕES E AÇÕES (5 min)

| Decisão/Ação | Responsável | Prazo |
|--------------|-------------|-------|
| | | |
| | | |
| | | |

---

*Próxima weekly: [DATA] às [HH:MM]*
```

---

### Template: MONTHLY (2-3 horas)

```markdown
# MONTHLY - [MÊS/ANO]

**Data:** [DD/MM/AAAA] | **Duração:** 2-3h
**Participantes:** [Nomes]
**Facilitador:** [Nome]

---

## BLOCO 1: RETROSPECTIVA (45 min)

### Resultados Financeiros

| Métrica | Meta | Realizado | % | Status |
|---------|------|-----------|---|--------|
| Faturamento | R$ | R$ | % | 🟢/🟡/🔴 |
| Margem | % | % | % | 🟢/🟡/🔴 |
| Caixa | R$ | R$ | - | 🟢/🟡/🔴 |

### Progresso OKRs (Mês [X] de 3)

| Objetivo | Meta Trimestre | Atual | % Conclusão |
|----------|---------------|-------|-------------|
| O1 | | | % |
| O2 | | | % |

### O Que Funcionou
-
-
-

### O Que Não Funcionou
-
-
-

### Aprendizados
-
-

---

## BLOCO 2: ANÁLISE (45 min)

### Tendências Identificadas
-
-

### Riscos
| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| | Alto/Médio/Baixo | Alto/Médio/Baixo | |

### Oportunidades
| Oportunidade | Potencial | Próximo Passo |
|--------------|-----------|---------------|
| | | |

### Saúde do Time
- **Engajamento:** 🟢/🟡/🔴
- **Sobrecarga:** 🟢/🟡/🔴
- **Observações:**

---

## BLOCO 3: PLANEJAMENTO (45 min)

### Prioridades do Próximo Mês

| # | Prioridade | Responsável | Entregável |
|---|------------|-------------|------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |

### Ajustes em OKRs
- [ ] Manter como está
- [ ] Ajustar meta de KR: [qual e por quê]
- [ ] Adicionar KR: [qual]
- [ ] Remover KR: [qual e por quê]

### Decisões Estratégicas

| Decisão | Contexto | Aprovado |
|---------|----------|----------|
| | | ✅/❌ |

---

## BLOCO 4: FECHAMENTO (15 min)

### Resumo de Decisões
1.
2.
3.

### Comunicação para Equipe
- **O que comunicar:**
- **Quando:**
- **Por quem:**

### Próxima Monthly
- **Data:** [DD/MM/AAAA]
- **Horário:** [HH:MM]
- **Preparação necessária:**

---

*Monthly de [MÊS] - Concluída*
```

---

### Prompt de IA para Gerar Atas

**Após a reunião, cole suas anotações no Claude/ChatGPT:**

```
Acabei de ter uma reunião [WEEKLY/MONTHLY/DAILY].

Aqui estão minhas anotações brutas:

[COLAR ANOTAÇÕES BAGUNÇADAS]

Transforme em uma ata estruturada com:

1. RESUMO EXECUTIVO (3 frases)
   - O que discutimos
   - Principais decisões
   - Próximos passos críticos

2. DECISÕES TOMADAS
   - Lista de decisões com responsável e prazo

3. AÇÕES COMBINADAS
   - Tabela: Ação | Responsável | Prazo | Status

4. PONTOS EM ABERTO
   - O que ficou pendente para próxima reunião

5. PRÓXIMA REUNIÃO
   - Data e pauta preliminar

Formato: Markdown limpo, fácil de compartilhar com a equipe.
```

---

### Exemplo de Uso do Prompt

**Anotações brutas:**

```
weekly sexta
- faturamento 85k, meta era 100k, ficou vermelho
- joao falou q lead caiu pq campanha parou
- decidimos reiniciar campanha segunda
- maria vai ajustar landing page
- churn subiu, pedro vai ligar pros cancelados
- proximo mes foco em retenção
- celebramos aniversario da ana
```

**Ata gerada pela IA:**

```markdown
# ATA - Weekly 03/01/2025

## Resumo Executivo
Revisamos resultados de dezembro que ficaram 15% abaixo da meta
de faturamento. Identificamos queda de leads por pausa em campanhas.
Definimos reinício de marketing e foco em retenção para janeiro.

## Decisões Tomadas
1. Reiniciar campanhas de marketing na segunda-feira
2. Priorizar retenção no Q1
3. Contatar clientes que cancelaram para entender motivos

## Ações Combinadas
| Ação | Responsável | Prazo |
|------|-------------|-------|
| Reiniciar campanhas | João | 06/01 |
| Ajustar landing page | Maria | 08/01 |
| Ligar para churns | Pedro | 10/01 |

## Pontos em Aberto
- Análise detalhada do motivo de churn
- Budget de marketing para janeiro

## Próxima Reunião
- Data: 10/01/2025, 14h
- Pauta: Resultados primeira semana + feedback dos churns
```

---

### 🤔 Pergunta Reflexiva

> "Quanto tempo você gasta escrevendo atas depois de reuniões?"
>
> Com IA, isso vira 2 minutos.
>
> O tempo que você economiza paga o esforço de usar o prompt.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Template antes, produtividade depois** — Pauta estruturada = reunião focada.

2. **IA transforma bagunça em ata** — Cole anotações brutas, receba ata limpa.

**A Transformação:**
- **Antes:** "Reunião sem pauta, ata nunca sai"
- **Depois:** "Pauta pronta, ata automática"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Copie o template da WEEKLY
2. Cole num Google Docs ou Notion
3. Preencha com a próxima data
4. Envie para quem participa

**Funcionou se:** Você tem template pronto para próxima weekly.

---

## 🎬 HOOK - Próxima Aula

> Você tem os templates.
>
> Agora vai me ver USANDO.
>
> Na próxima aula, vou conduzir uma weekly ao vivo — do início ao fim, com pauta, discussão e fechamento.
>
> **Próxima aula: 3.5 - Conduzindo uma Weekly ao Vivo**

---

*Aula 3.4 - Trilha 5 - Academia Lendária*
