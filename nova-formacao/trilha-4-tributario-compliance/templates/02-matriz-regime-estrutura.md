# Template: Matriz Regime x Estrutura

## Trilha 4 - Tributario e Compliance | Modulo 2

---

## Instrucoes de Uso

1. Preencha seus dados atuais
2. Simule cada regime tributario
3. Compare custos totais
4. Avalie mudancas de estrutura
5. Defina a melhor combinacao

---

## 1. SITUACAO ATUAL

| Campo | Valor |
|-------|-------|
| **Regime Atual** | Simples / Presumido / Real |
| **Estrutura Atual** | LTDA / SLU / EIRELI / SA / Holding |
| **Faturamento Anual** | R$ |
| **Lucro Estimado** | R$ (___%) |
| **Folha de Pagamento** | R$ /mes |
| **Carga Tributaria Atual** | R$ /mes (___%) |

---

## 2. SIMULACAO: SIMPLES NACIONAL

### Elegibilidade

| Criterio | Status |
|----------|--------|
| Faturamento < R$ 4.8M/ano | Sim / Nao |
| Atividade permitida | Sim / Nao |
| Socios PJ ou holding? | Sim / Nao |
| Debitos tributarios? | Sim / Nao |
| **ELEGIVEL?** | **Sim / Nao** |

### Calculo

| Faixa Faturamento | Aliquota | Valor Mensal |
|-------------------|----------|--------------|
| Ate R$ 180k | ___% | R$ |
| R$ 180k - 360k | ___% | R$ |
| R$ 360k - 720k | ___% | R$ |
| R$ 720k - 1.8M | ___% | R$ |
| R$ 1.8M - 3.6M | ___% | R$ |
| R$ 3.6M - 4.8M | ___% | R$ |

| Metrica | Valor |
|---------|-------|
| **DAS Mensal Estimado** | R$ |
| **Carga Anual** | R$ |
| **% do Faturamento** | % |

---

## 3. SIMULACAO: LUCRO PRESUMIDO

### Premissas

| Campo | Valor |
|-------|-------|
| Base de calculo (% receita) | ___% (8% comercio, 32% servicos) |
| Receita mensal | R$ |
| Base presumida | R$ |

### Tributos

| Tributo | Aliquota | Base | Valor Mensal |
|---------|----------|------|--------------|
| IRPJ | 15% | R$ | R$ |
| IRPJ Adicional (>20k) | 10% | R$ | R$ |
| CSLL | 9% | R$ | R$ |
| PIS | 0,65% | Receita | R$ |
| COFINS | 3% | Receita | R$ |
| ISS (servicos) | ___% | R$ | R$ |
| **TOTAL MENSAL** | | | **R$** |
| **TOTAL ANUAL** | | | **R$** |
| **% do Faturamento** | | | **%** |

---

## 4. SIMULACAO: LUCRO REAL

### Premissas

| Campo | Valor |
|-------|-------|
| Receita mensal | R$ |
| Custos dedutiveis | R$ |
| Lucro real (base) | R$ |

### Tributos

| Tributo | Aliquota | Base | Valor Mensal |
|---------|----------|------|--------------|
| IRPJ | 15% | Lucro | R$ |
| IRPJ Adicional | 10% | Excedente | R$ |
| CSLL | 9% | Lucro | R$ |
| PIS | 1,65% | Receita-Creditos | R$ |
| COFINS | 7,6% | Receita-Creditos | R$ |
| ISS | ___% | R$ | R$ |
| **TOTAL MENSAL** | | | **R$** |
| **TOTAL ANUAL** | | | **R$** |
| **% do Faturamento** | | | **%** |

### Creditos Aproveitaveis

| Tipo de Credito | Valor Mensal |
|-----------------|--------------|
| PIS/COFINS s/ insumos | R$ |
| ICMS s/ compras | R$ |
| Depreciacao | R$ |
| **TOTAL CREDITOS** | **R$** |

---

## 5. MATRIZ COMPARATIVA

| Regime | Carga Mensal | Carga Anual | % Fat. | Complexidade |
|--------|--------------|-------------|--------|--------------|
| Simples Nacional | R$ | R$ | % | Baixa |
| Lucro Presumido | R$ | R$ | % | Media |
| Lucro Real | R$ | R$ | % | Alta |
| **Atual** | **R$** | **R$** | **%** | |

### Economia Potencial

| De → Para | Economia Anual | % Reducao |
|-----------|----------------|-----------|
| Atual → Simples | R$ | % |
| Atual → Presumido | R$ | % |
| Atual → Real | R$ | % |

---

## 6. ESTRUTURA JURIDICA

### Opcoes de Estrutura

| Estrutura | Caracteristica | Quando Usar |
|-----------|----------------|-------------|
| MEI | Faturamento < R$ 81k, 1 funcionario | Inicio |
| SLU | 1 socio, sem capital minimo | Pequenos |
| LTDA | 2+ socios, flexivel | Maioria |
| Holding | Patrimonio separado | Protecao |
| SA | Capital aberto possivel | Crescimento |

### Sua Analise

| Pergunta | Resposta |
|----------|----------|
| Quantos socios? | |
| Plano de crescimento? | |
| Patrimonio pessoal a proteger? | |
| Plano de saida/venda? | |
| **Estrutura Recomendada** | |

---

## 7. CENARIOS COMBINADOS

| Cenario | Regime | Estrutura | Carga Anual | Observacao |
|---------|--------|-----------|-------------|------------|
| Atual | | | R$ | Baseline |
| Cenario A | | | R$ | |
| Cenario B | | | R$ | |
| Cenario C | | | R$ | |
| **Melhor** | | | **R$** | |

---

## 8. CUSTOS DE TRANSICAO

| Item | Custo | Prazo |
|------|-------|-------|
| Honorarios contador | R$ | |
| Alteracao contrato | R$ | |
| Junta Comercial | R$ | |
| Certidoes | R$ | |
| Tempo de adaptacao | ___ meses | |
| **TOTAL TRANSICAO** | **R$** | |

### Payback

```
Payback = Custo transicao / Economia mensal
Payback = R$ ___ / R$ ___ = ___ meses
```

---

## 9. PROMPT DE IA PARA SIMULACAO

```
Simule regimes tributarios para minha empresa:

DADOS:
- Faturamento anual: R$ ___
- Lucro estimado: ___% (R$ ___)
- Setor: ___
- Folha: R$ ___/mes
- Funcionarios: ___
- Compras/insumos: R$ ___/mes

REGIME ATUAL: ___
CARGA ATUAL: R$ ___/mes (___%)

Simule:
1. Simples Nacional (se elegivel)
2. Lucro Presumido
3. Lucro Real

Para cada um, calcule:
- Tributos mensais
- Carga total anual
- % do faturamento
- Prós e contras

Qual regime recomenda e por que?
```

---

## 10. CHECKLIST DE VALIDACAO

- [ ] Simulei todos os regimes aplicaveis
- [ ] Considerei custos de transicao
- [ ] Calculei payback
- [ ] Validei elegibilidade (Simples)
- [ ] Considerei estrutura juridica
- [ ] Discuti com contador

---

## 11. DECISAO

| Campo | Resposta |
|-------|----------|
| **Regime escolhido** | |
| **Estrutura escolhida** | |
| **Economia esperada** | R$ /ano |
| **Quando implementar** | |
| **Responsavel** | |

---

**Template versao:** 1.0
**Trilha:** Tributario e Compliance
**Modulo:** 2 - Regime e Estrutura
