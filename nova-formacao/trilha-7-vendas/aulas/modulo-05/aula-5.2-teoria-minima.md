# Aula 5.2: Forecast e Gargalos

> **Tipo:** Teoria Mínima
> **Duração:** 15 minutos
> **Conceito:** Previsão + Identificação de problemas

---

## O que é Forecast (5 min)

### Definição

> **Forecast = Previsão de receita baseada em dados do pipeline**

Não é:
- ❌ Chute otimista
- ❌ Meta de vendas
- ❌ "Se tudo der certo"

É:
- ✅ Leads atuais × Taxa histórica × Ticket
- ✅ Matemática, não esperança
- ✅ Base para decisões

### Fórmula Simples

```
FORECAST = Leads no pipeline × Taxa de conversão × Ticket médio
```

### Exemplo

```
Pipeline atual:
- 50 leads em qualificação
- 20 leads em negociação
- 10 propostas enviadas

Taxas históricas:
- Qualificação → Venda: 5%
- Negociação → Venda: 25%
- Proposta → Venda: 40%

Ticket: R$ 5.000

Forecast:
- 50 × 5% × 5.000 = R$ 12.500
- 20 × 25% × 5.000 = R$ 25.000
- 10 × 40% × 5.000 = R$ 20.000
TOTAL: R$ 57.500
```

---

## Identificando Gargalos (5 min)

### O que é Gargalo

> **Gargalo = Etapa onde você mais perde leads**

### Como Identificar

Compare taxas por etapa:

| Etapa | Volume | Taxa | Benchmark | Status |
|-------|--------|------|-----------|--------|
| Lead → MQL | 100→40 | 40% | 50% | ⚠️ Abaixo |
| MQL → SQL | 40→30 | 75% | 60% | ✅ OK |
| SQL → Call | 30→15 | 50% | 70% | 🔴 GARGALO |
| Call → Proposta | 15→10 | 67% | 60% | ✅ OK |
| Proposta → Venda | 10→3 | 30% | 35% | ⚠️ Abaixo |

**Gargalo principal:** SQL → Call (50% vs benchmark 70%)

### Impacto do Gargalo

```
Cenário atual:
100 leads → 3 vendas (3%)

Se corrigir gargalo (50% → 70%):
100 leads → 4.2 vendas (4.2%)

Impacto: +40% de receita
```

---

## Framework de Otimização (5 min)

### O Ciclo

```
1. MEDIR   → Calcular taxas por etapa
2. COMPARAR → Identificar gargalo (vs benchmark)
3. HIPÓTESE → "Se melhorar X, receita aumenta Y"
4. TESTAR  → Implementar ação por 2 semanas
5. MEDIR   → Validar se funcionou
6. REPETIR → Próximo gargalo
```

### Ações por Tipo de Gargalo

| Gargalo | Causa Provável | Ação |
|---------|----------------|------|
| Lead → MQL baixo | Qualificação fraca | Melhorar perguntas/scoring |
| SQL → Call baixo | Follow-up fraco | Cadência mais agressiva |
| Call → Proposta baixo | Calls ruins | Preparação + script |
| Proposta → Venda baixo | Objeções não tratadas | Follow-up pós-proposta |

---

## Resumo

```
FORECAST = Pipeline × Taxa × Ticket
GARGALO = Etapa com pior taxa vs benchmark
OTIMIZAÇÃO = Focar no gargalo, não em tudo
```

---

## Checkpoint

Antes de ir para próxima aula:

- [x] Sabe calcular forecast
- [x] Entende o que é gargalo
- [x] Conhece o framework de otimização

---

**Próxima aula:** [5.3 Exercício: Monte Seu Dashboard](aula-5.3-exercicio.md)
