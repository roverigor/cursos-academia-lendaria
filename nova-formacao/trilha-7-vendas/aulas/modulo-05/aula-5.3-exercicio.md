# Aula 5.3: Monte Seu Dashboard Comercial

> **Tipo:** Exercício
> **Duração:** 20 minutos
> **Entregável:** Dashboard + Plano de Otimização

---

## Objetivo

Criar seu **Dashboard Comercial** para acompanhar performance e tomar decisões.

---

## Build Sprint (20 min)

### Passo 1: Crie o Dashboard do Funil (7 min)

Preencha com dados do mês atual:

```markdown
# DASHBOARD COMERCIAL - [Mês/Ano]

## Funil do Mês

| Etapa | Volume | Taxa | Meta | Gap | Status |
|-------|--------|------|------|-----|--------|
| Leads | ___ | - | ___ | ___ | ⬜ |
| MQL | ___ | ___% | ___% | ___ | ⬜ |
| SQL | ___ | ___% | ___% | ___ | ⬜ |
| Call | ___ | ___% | ___% | ___ | ⬜ |
| Proposta | ___ | ___% | ___% | ___ | ⬜ |
| Venda | ___ | ___% | ___% | ___ | ⬜ |

## Métricas Principais

| Métrica | Atual | Meta | Status |
|---------|-------|------|--------|
| Taxa total (Lead→Venda) | ___% | ___% | ⬜ |
| Ticket médio | R$ ___ | R$ ___ | ⬜ |
| Ciclo de venda (dias) | ___ | ___ | ⬜ |
| Receita do mês | R$ ___ | R$ ___ | ⬜ |
```

### Passo 2: Calcule o Forecast (5 min)

```markdown
## Forecast Próximo Mês

| Pipeline Atual | Volume | Taxa Histórica | Receita Prevista |
|----------------|--------|----------------|------------------|
| Em qualificação | ___ | ___% | R$ ___ |
| Em negociação | ___ | ___% | R$ ___ |
| Proposta enviada | ___ | ___% | R$ ___ |
| **TOTAL** | | | **R$ ___** |

Meta: R$ ___
Gap: R$ ___
```

### Passo 3: Identifique o Gargalo (3 min)

```markdown
## Análise de Gargalos

Etapa com pior taxa: _______________
Taxa atual: ___%
Benchmark: ___%
Gap: ___%

Por que está baixo?
[ ] Qualificação fraca
[ ] Follow-up inconsistente
[ ] Calls sem preparo
[ ] Proposta fraca
[ ] Outro: _______________
```

### Passo 4: Defina Ações (5 min)

```markdown
## Plano de Otimização

### Prioridade 1: Corrigir Gargalo
- Etapa: _______________
- Ação: _______________
- Responsável: _______________
- Prazo: _______________
- Métrica de sucesso: Taxa de ___% → ___%

### Prioridade 2: Quick Win
- Ação: _______________
- Impacto esperado: _______________

### Prioridade 3: Médio Prazo
- Ação: _______________
- Prazo: _______________
```

---

## Prompt IA para Análise

```
Aqui estão meus dados comerciais do último mês:

Funil:
- Leads: [X]
- MQL: [X] (taxa: %)
- SQL: [X] (taxa: %)
- Calls: [X] (taxa: %)
- Propostas: [X] (taxa: %)
- Vendas: [X] (taxa: %)

Ticket médio: R$ [X]
Meta de receita: R$ [X]

Analise e responda:
1. Qual minha taxa de conversão total?
2. Qual meu forecast para o próximo mês?
3. Qual o maior gargalo (etapa com pior taxa)?
4. Se eu melhorar esse gargalo em 30%, qual seria a nova receita?
5. Quais 3 ações você recomenda para melhorar?
```

---

## Template Final

```markdown
# PLANO DE OTIMIZAÇÃO COMERCIAL

## Diagnóstico Atual
- Taxa total: ___%
- Receita atual: R$ ___
- Meta: R$ ___
- Gap: R$ ___

## Gargalo Principal
- Etapa: ___
- Taxa atual: ___%
- Meta: ___%

## Ações Priorizadas
1. [Ação urgente]
2. [Quick win]
3. [Médio prazo]

## Próximo Review
- Data: ___
- Métrica a checar: ___
```

---

## Checkpoint

Antes de ir para próxima aula:

- [x] Dashboard preenchido com dados reais
- [x] Forecast calculado
- [x] Gargalo identificado
- [x] 3 ações definidas

---

**Próxima aula:** [5.4 Validação: Rotina Semanal](aula-5.4-validacao.md)
