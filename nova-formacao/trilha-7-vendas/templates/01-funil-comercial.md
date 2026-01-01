# Template: Funil Comercial Instrumentado

## Trilha 7 - Vendas com IA | Modulo 1

---

## Instrucoes de Uso

1. Defina as etapas do seu funil
2. Estabeleca criterios de passagem
3. Calcule taxas de conversao
4. Identifique gargalos
5. Configure no CRM

---

## 1. IDENTIFICACAO

| Campo | Valor |
|-------|-------|
| **Empresa** | |
| **Responsavel** | |
| **Data** | |
| **CRM utilizado** | |

---

## 2. ETAPAS DO FUNIL

### Modelo Padrao (5 etapas)

```
LEAD ──► MQL ──► SQL ──► PROPOSTA ──► CLIENTE
  │        │       │         │           │
  ▼        ▼       ▼         ▼           ▼
 ___      ___     ___       ___         ___
```

### Suas Etapas

| # | Etapa | Descricao | Criterio de Entrada |
|---|-------|-----------|---------------------|
| 1 | **Lead** | Contato inicial | Demonstrou interesse |
| 2 | **MQL** | Marketing Qualified | |
| 3 | **SQL** | Sales Qualified | |
| 4 | **Proposta** | Proposta enviada | |
| 5 | **Cliente** | Fechou negocio | |

---

## 3. CRITERIOS DE PASSAGEM

### Lead → MQL

| Criterio | Obrigatorio? | Como Verificar |
|----------|--------------|----------------|
| | Sim / Nao | |
| | Sim / Nao | |
| | Sim / Nao | |

**Quem move:** Marketing / Automatico

### MQL → SQL

| Criterio | Obrigatorio? | Como Verificar |
|----------|--------------|----------------|
| | Sim / Nao | |
| | Sim / Nao | |
| | Sim / Nao | |

**Quem move:** SDR / Vendedor

### SQL → Proposta

| Criterio | Obrigatorio? | Como Verificar |
|----------|--------------|----------------|
| | Sim / Nao | |
| | Sim / Nao | |
| | Sim / Nao | |

**Quem move:** Vendedor

### Proposta → Cliente

| Criterio | Obrigatorio? | Como Verificar |
|----------|--------------|----------------|
| | Sim / Nao | |
| | Sim / Nao | |

**Quem move:** Vendedor

---

## 4. TAXAS DE CONVERSAO

### Baseline (Ultimos 3 meses)

| Transicao | Quantidade | Taxa | Benchmark |
|-----------|------------|------|-----------|
| Lead → MQL | ___/___  | ___% | 20-30% |
| MQL → SQL | ___/___ | ___% | 30-50% |
| SQL → Proposta | ___/___ | ___% | 50-70% |
| Proposta → Cliente | ___/___ | ___% | 20-40% |
| **Lead → Cliente** | ___/___ | **___%** | 2-5% |

### Calculo

```
Taxa = (Saidas da etapa / Entradas da etapa) x 100

Exemplo:
100 Leads entraram
30 viraram MQL
Taxa Lead→MQL = 30/100 = 30%
```

---

## 5. TEMPO MEDIO POR ETAPA

| Etapa | Tempo Medio | Meta | Status |
|-------|-------------|------|--------|
| Lead → MQL | ___ dias | ___ dias | ✅ ⚠️ ❌ |
| MQL → SQL | ___ dias | ___ dias | ✅ ⚠️ ❌ |
| SQL → Proposta | ___ dias | ___ dias | ✅ ⚠️ ❌ |
| Proposta → Cliente | ___ dias | ___ dias | ✅ ⚠️ ❌ |
| **Ciclo Total** | **___ dias** | **___ dias** | |

---

## 6. CAMPOS OBRIGATORIOS NO CRM

### Por Etapa

| Etapa | Campo | Tipo | Obrigatorio |
|-------|-------|------|-------------|
| **Lead** | Nome | Texto | Sim |
| | Email | Email | Sim |
| | Telefone | Telefone | Sim |
| | Origem | Lista | Sim |
| **MQL** | Qualificacao (score) | Numero | Sim |
| | Interesse | Lista | Sim |
| **SQL** | BANT confirmado | Checkbox | Sim |
| | Decisor identificado | Texto | Sim |
| **Proposta** | Valor | Moeda | Sim |
| | Data envio | Data | Sim |
| **Cliente** | Contrato assinado | Data | Sim |
| | Valor fechado | Moeda | Sim |

---

## 7. MOTIVOS DE PERDA

### Categorias

| Motivo | Quantidade | % | Acao |
|--------|------------|---|------|
| Preco | | % | |
| Timing | | % | |
| Concorrente | | % | |
| Nao responde | | % | |
| Sem orcamento | | % | |
| Nao era fit | | % | |
| Outro | | % | |
| **TOTAL** | | **100%** | |

---

## 8. VISUALIZACAO DO FUNIL

```
┌─────────────────────────────────────────────────────────────────┐
│                         FUNIL COMERCIAL                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  LEAD          │████████████████████████████│  ___ (100%)      │
│                │                            │                   │
│  MQL           │██████████████████          │  ___ (__%)       │
│                │                            │                   │
│  SQL           │████████████                │  ___ (__%)       │
│                │                            │                   │
│  PROPOSTA      │████████                    │  ___ (__%)       │
│                │                            │                   │
│  CLIENTE       │████                        │  ___ (__%)       │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│  Ciclo: ___ dias  │  Ticket: R$ ___  │  Conversao: ___%        │
└─────────────────────────────────────────────────────────────────┘
```

---

## 9. ANALISE DE GARGALOS

### Onde Esta o Problema?

| Etapa | Taxa | Benchmark | Gap | Prioridade |
|-------|------|-----------|-----|------------|
| Lead → MQL | ___% | 25% | | Alta/Media/Baixa |
| MQL → SQL | ___% | 40% | | Alta/Media/Baixa |
| SQL → Proposta | ___% | 60% | | Alta/Media/Baixa |
| Proposta → Cliente | ___% | 30% | | Alta/Media/Baixa |

**Principal gargalo:** ___

**Hipotese do problema:** ___

**Acao proposta:** ___

---

## 10. PROMPT DE IA PARA ANALISE

```
Analise meu funil comercial:

ETAPAS E TAXAS:
- Lead → MQL: ___% (de ___)
- MQL → SQL: ___% (de ___)
- SQL → Proposta: ___% (de ___)
- Proposta → Cliente: ___% (de ___)

TEMPO MEDIO:
- Ciclo total: ___ dias

MOTIVOS DE PERDA (top 3):
1. ___ (__%)
2. ___ (__%)
3. ___ (__%)

TICKET MEDIO: R$ ___

Perguntas:
1. Meu funil esta saudavel?
2. Qual etapa e o maior gargalo?
3. O que pode estar causando isso?
4. Quais acoes priorizar?
5. Meta realista de melhoria?
```

---

## 11. CHECKLIST DE VALIDACAO

- [ ] Todas as etapas definidas
- [ ] Criterios de passagem claros
- [ ] Taxas de conversao calculadas
- [ ] Tempos medios mapeados
- [ ] Gargalo identificado
- [ ] Configurado no CRM

---

## 12. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Configurar funil no CRM
- [ ] Preencher com dados reais
- [ ] Identificar principal gargalo

**CRM:** ___
**Gargalo:** ___
**Acao:** ___

---

**Template versao:** 1.0
**Trilha:** Vendas com IA
**Modulo:** 1 - Funil Comercial
