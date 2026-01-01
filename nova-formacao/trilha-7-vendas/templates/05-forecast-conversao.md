# Template: Forecast e Conversao

## Trilha 7 - Vendas com IA | Modulo 5

---

## Instrucoes de Uso

1. Mapeie seu pipeline atual
2. Calcule o forecast do mes
3. Identifique gargalos
4. Defina acoes de melhoria
5. Acompanhe semanalmente

---

## 1. PIPELINE ATUAL

### Oportunidades por Etapa

| Etapa | Qtd | Valor Total | Probabilidade | Valor Ponderado |
|-------|-----|-------------|---------------|-----------------|
| Lead | | R$ | 10% | R$ |
| MQL | | R$ | 20% | R$ |
| SQL | | R$ | 40% | R$ |
| Proposta | | R$ | 60% | R$ |
| Negociacao | | R$ | 80% | R$ |
| **TOTAL** | | **R$** | | **R$** |

### Calculo do Valor Ponderado

```
Valor Ponderado = Valor da Oportunidade x Probabilidade

Exemplo:
Proposta de R$ 10.000 com 60% de prob
Valor Ponderado = R$ 10.000 x 0,60 = R$ 6.000
```

---

## 2. FORECAST DO MES

### Formula

```
Forecast = Σ (Oportunidades x Probabilidade por etapa)
```

### Seu Forecast

| Cenario | Calculo | Valor |
|---------|---------|-------|
| **Pessimista** | Apenas Negociacao (80%) | R$ |
| **Realista** | Proposta (60%) + Negociacao (80%) | R$ |
| **Otimista** | SQL + Proposta + Negociacao | R$ |

### Meta vs Forecast

| Campo | Valor |
|-------|-------|
| Meta do mes | R$ |
| Forecast realista | R$ |
| Gap | R$ |
| % da meta | ___% |

---

## 3. PREVISAO POR VENDEDOR (se aplicavel)

| Vendedor | Pipeline | Forecast | Meta | % Meta |
|----------|----------|----------|------|--------|
| | R$ | R$ | R$ | % |
| | R$ | R$ | R$ | % |
| | R$ | R$ | R$ | % |
| **TOTAL** | **R$** | **R$** | **R$** | **%** |

---

## 4. ANALISE DE CONVERSAO

### Taxas por Etapa (Ultimos 30 dias)

| Transicao | Taxa Atual | Meta | Gap | Status |
|-----------|------------|------|-----|--------|
| Lead → MQL | ___% | ___% | | ✅ ⚠️ ❌ |
| MQL → SQL | ___% | ___% | | ✅ ⚠️ ❌ |
| SQL → Proposta | ___% | ___% | | ✅ ⚠️ ❌ |
| Proposta → Fechamento | ___% | ___% | | ✅ ⚠️ ❌ |
| **Geral (Lead→Cliente)** | **___%** | **___%** | | |

### Identificacao de Gargalos

| Pergunta | Resposta |
|----------|----------|
| Qual etapa tem menor conversao? | |
| Por que leads estao parando ai? | |
| O que fazer para melhorar? | |

---

## 5. MOTIVOS DE PERDA (Ultimos 30 dias)

| Motivo | Quantidade | % | Valor Perdido |
|--------|------------|---|---------------|
| Preco alto | | % | R$ |
| Escolheu concorrente | | % | R$ |
| Nao responde | | % | R$ |
| Nao era fit | | % | R$ |
| Sem budget | | % | R$ |
| Timing ruim | | % | R$ |
| Outro: ___ | | % | R$ |
| **TOTAL** | | **100%** | **R$** |

### Analise

**Principal motivo:** ___
**Hipotese:** ___
**Acao:** ___

---

## 6. PLANO DE ACAO (5 acoes)

### Acao 1: ___

| Campo | Descricao |
|-------|-----------|
| **Gargalo atacado** | |
| **O que fazer** | |
| **Responsavel** | |
| **Prazo** | |
| **Metrica de sucesso** | |

### Acao 2: ___

| Campo | Descricao |
|-------|-----------|
| **Gargalo atacado** | |
| **O que fazer** | |
| **Responsavel** | |
| **Prazo** | |
| **Metrica de sucesso** | |

### Acao 3: ___

| Campo | Descricao |
|-------|-----------|
| **Gargalo atacado** | |
| **O que fazer** | |
| **Responsavel** | |
| **Prazo** | |
| **Metrica de sucesso** | |

### Acao 4: ___

| Campo | Descricao |
|-------|-----------|
| **Gargalo atacado** | |
| **O que fazer** | |
| **Responsavel** | |
| **Prazo** | |
| **Metrica de sucesso** | |

### Acao 5: ___

| Campo | Descricao |
|-------|-----------|
| **Gargalo atacado** | |
| **O que fazer** | |
| **Responsavel** | |
| **Prazo** | |
| **Metrica de sucesso** | |

---

## 7. ROTINA SEMANAL (30 min)

### Segunda-feira: Review

| Acao | Tempo |
|------|-------|
| Atualizar pipeline | 10 min |
| Calcular forecast | 5 min |
| Identificar oportunidades paradas | 10 min |
| Definir prioridades da semana | 5 min |

### Template de Review

```
📊 REVIEW SEMANAL - ___/___

PIPELINE:
- Oportunidades: ___
- Valor total: R$ ___
- Forecast: R$ ___

META DO MES: R$ ___
REALIZADO: R$ ___ (__%)
FALTA: R$ ___

OPORTUNIDADES PARADAS (>7 dias):
1. ___
2. ___
3. ___

PRIORIDADES DA SEMANA:
1. ___
2. ___
3. ___
```

---

## 8. PROMPT DE IA PARA ANALISE

```
Analise meu pipeline de vendas:

PIPELINE ATUAL:
| Etapa | Qtd | Valor |
| Lead | ___ | R$ ___ |
| MQL | ___ | R$ ___ |
| SQL | ___ | R$ ___ |
| Proposta | ___ | R$ ___ |
| Negociacao | ___ | R$ ___ |

TAXAS DE CONVERSAO:
- Lead → MQL: ___%
- MQL → SQL: ___%
- SQL → Proposta: ___%
- Proposta → Fechamento: ___%

META DO MES: R$ ___
DIAS RESTANTES: ___

MOTIVOS DE PERDA (top 3):
1. ___ (__%)
2. ___ (__%)
3. ___ (__%)

Perguntas:
1. Vou bater a meta? Qual a probabilidade?
2. Qual o maior gargalo do meu funil?
3. Quais 3 acoes priorizar esta semana?
4. Quantos novos leads preciso gerar?
5. Algum padrao nos motivos de perda?
```

---

## 9. DASHBOARD VISUAL

```
┌─────────────────────────────────────────────────────────────────┐
│                    FORECAST DO MES ___/___                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  META: R$ ___________      FORECAST: R$ ___________            │
│                                                                 │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ___%     │
│                                                                 │
│  Realizado: R$ _______  │  Falta: R$ _______                   │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│  PIPELINE                    │  CONVERSAO                       │
│  ──────────                  │  ─────────                       │
│  Lead:       ___  R$ ___    │  Lead→MQL:    ___% [▓▓▓░░░]     │
│  MQL:        ___  R$ ___    │  MQL→SQL:     ___% [▓▓▓▓░░]     │
│  SQL:        ___  R$ ___    │  SQL→Prop:    ___% [▓▓▓▓▓░]     │
│  Proposta:   ___  R$ ___    │  Prop→Close:  ___% [▓▓░░░░]     │
│  Negociacao: ___  R$ ___    │                                   │
│                              │  GERAL: ___% [▓▓░░░░░░░░░]      │
├─────────────────────────────────────────────────────────────────┤
│  🎯 ACOES PRIORIZADAS        │  ⚠️ ALERTAS                      │
│  1. ___________________      │  • ___________________           │
│  2. ___________________      │  • ___________________           │
│  3. ___________________      │  • ___________________           │
└─────────────────────────────────────────────────────────────────┘
```

---

## 10. CHECKLIST DE VALIDACAO

- [ ] Pipeline atualizado
- [ ] Forecast calculado
- [ ] Taxas de conversao mapeadas
- [ ] Gargalos identificados
- [ ] 5 acoes definidas
- [ ] Rotina semanal estabelecida

---

## 11. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Calcular forecast do mes
- [ ] Identificar principal gargalo
- [ ] Definir 3 acoes prioritarias

**Forecast:** R$ ___
**Meta:** R$ ___
**Principal gargalo:** ___

---

**Template versao:** 1.0
**Trilha:** Vendas com IA
**Modulo:** 5 - Conversao e Forecast
