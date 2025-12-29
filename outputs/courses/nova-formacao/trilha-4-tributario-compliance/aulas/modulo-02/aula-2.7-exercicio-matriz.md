# Aula 2.7: Exercicio - Sua Matriz de Regimes

## Trilha 4 | Modulo 2 | Regime e Enquadramento

---

> **Duracao:** 25 minutos
> **Tipo:** Pratica
> **Entregavel:** Matriz Regime x Estrutura preenchida

---

## Objetivo

Comparar seu regime atual com pelo menos 2 alternativas e tomar uma decisao fundamentada.

---

## Materiais Necessarios

Antes de comecar, tenha em maos:

- [ ] Mapa Tributario (Modulo 1)
- [ ] Faturamento anual
- [ ] Lucro anual estimado
- [ ] Folha de pagamento anual
- [ ] CNAE principal

---

## Passo 1: Dados Basicos (5 min)

```
DADOS PARA SIMULACAO
====================
Razao Social: _______________________________________
Faturamento Anual: R$ _______________
Lucro Anual Estimado: R$ _______________
Margem de Lucro: _____% (Lucro / Faturamento x 100)
Folha de Pagamento Anual: R$ _______________
Fator R: _____% (Folha / Faturamento x 100)
CNAE Principal: _____ - ____________________________
```

---

## Passo 2: Simular Simples Nacional (5 min)

### Se voce JA e Simples:
Anote sua situacao atual.

### Se voce NAO e Simples:
Verifique se poderia ser (faturamento < R$ 4.8M).

```
SIMPLES NACIONAL
================

Anexo atual/potencial: _____
(I = Comercio, II = Industria, III-V = Servicos)

Fator R: _____%
Se servicos e Fator R >= 28%: Anexo III
Se servicos e Fator R < 28%: Anexo V

Faixa de faturamento: _____
(use RBT12 = faturamento ultimos 12 meses)

| Faixa | RBT12 | Aliquota |
|-------|-------|----------|
| 1a | Ate 180K | 6% (III) ou 15.5% (V) |
| 2a | 180K-360K | 11.2% (III) ou 18% (V) |
| 3a | 360K-720K | 13.5% (III) ou 19.5% (V) |
| 4a | 720K-1.8M | 16% (III) ou 20.5% (V) |
| 5a | 1.8M-3.6M | 21% (III) ou 23% (V) |
| 6a | 3.6M-4.8M | 33% (III) ou 30.5% (V) |

Calculo da aliquota efetiva:
Aliquota efetiva = (RBT12 x Aliquota - Parcela deduzir) / RBT12

Sua aliquota efetiva: _____%
Imposto anual Simples: R$ _______________
```

---

## Passo 3: Simular Lucro Presumido (5 min)

```
LUCRO PRESUMIDO
===============

Faturamento anual: R$ _______________

Presuncao de lucro:
- Servicos em geral: 32%
- Comercio/Industria: 8%
- Transporte passageiros: 16%
- Transporte cargas: 8%

Sua presuncao: _____%

CALCULO:
Lucro presumido = Faturamento x Presuncao
Lucro presumido = R$ _______ x ___% = R$ _______

IRPJ = Lucro presumido x 15% = R$ _______
(Se lucro > R$ 240K/ano, adicional de 10% sobre excedente)
Adicional IRPJ = (Lucro - 240.000) x 10% = R$ _______

CSLL = Lucro presumido x 9% = R$ _______
PIS = Faturamento x 0.65% = R$ _______
COFINS = Faturamento x 3% = R$ _______
ISS = Faturamento x ___% (sua cidade) = R$ _______

INSS Patronal = Folha x 20% = R$ _______
(Este custo nao existe no Simples!)

TOTAL LUCRO PRESUMIDO: R$ _______________
```

---

## Passo 4: Simular Lucro Real (se aplicavel) (5 min)

```
LUCRO REAL
==========

Faturamento anual: R$ _______________
Lucro contabil real: R$ _______________

Se lucro for BAIXO ou NEGATIVO, vale simular.
Se lucro for ALTO (> presuncao), provavelmente nao compensa.

CALCULO (simplificado):
IRPJ = Lucro real x 15% = R$ _______
Adicional IRPJ = (Lucro - 240.000) x 10% = R$ _______
CSLL = Lucro real x 9% = R$ _______
PIS = Faturamento x 1.65% (com creditos) = R$ _______
COFINS = Faturamento x 7.6% (com creditos) = R$ _______

Creditos estimados de PIS/COFINS: R$ _______
PIS/COFINS liquido: R$ _______

INSS Patronal = Folha x 20% = R$ _______

TOTAL LUCRO REAL: R$ _______________

(Este calculo e simplificado. Lucro Real requer analise profissional.)
```

---

## Passo 5: Preencher Comparativo (3 min)

```
COMPARATIVO DE REGIMES
======================

| Criterio | ATUAL | ALTERNATIVA 1 | ALTERNATIVA 2 |
|----------|-------|---------------|---------------|
| Regime | | | |
| Carga tributaria (%) | % | % | % |
| Imposto anual (R$) | R$ | R$ | R$ |
| Economia vs atual | - | R$ | R$ |
| Custo contabil | R$/mes | R$/mes | R$/mes |
| Complexidade | | | |
| Risco | | | |
| Score (1-10) | | | |
```

---

## Passo 6: Analise e Decisao (2 min)

```
ANALISE
=======

Melhor opcao financeira: _______________
Economia potencial: R$ ___/ano

Tradeoffs:
- Complexidade: _______________________
- Custo adicional: _______________________
- Risco: _______________________


DECISAO
=======

[ ] Manter regime atual
    Motivo: _______________________

[ ] Migrar para _______________
    Motivo: _______________________
    Economia: R$ _______/ano
    Proximo passo: _______________________

[ ] Preciso validar com contador
    Duvida principal: _______________________
```

---

## IA NA PRATICA

### Prompt Principal: Validador Completo da Matriz

```
Atue como auditor tributario. Valide minha Matriz Regime x Estrutura:

MEUS DADOS:
- Razao Social: [nome]
- Faturamento anual: R$ [valor]
- Lucro anual: R$ [valor] ([__]% margem)
- Folha anual: R$ [valor]
- Fator R: [__]%
- CNAE: [codigo]

MINHAS SIMULACOES:
- Simples Nacional (Anexo [III/V]): R$ [valor]/ano ([__]%)
- Lucro Presumido: R$ [valor]/ano ([__]%)
- Lucro Real: R$ [valor]/ano ([__]%) [se aplicavel]

MINHA CONCLUSAO: [regime X parece melhor] porque [justificativa]

VALIDE:
1. Os calculos do Simples estao corretos? (aliquota, Fator R, anexo)
2. O Lucro Presumido inclui TODOS os tributos + INSS patronal?
3. Esqueci algum custo importante? (contabilidade, transicao)
4. Minha conclusao faz sentido para meu perfil?
5. Ha alguma armadilha que nao estou vendo?

DIAGNOSTICO:
[ ] Calculos corretos, conclusao valida
[ ] Calculos corretos, mas conclusao questionavel porque ___
[ ] Calculos com erro: [apontar qual]
[ ] Falta considerar: [o que falta]

PERGUNTAS PARA O CONTADOR:
[Gere 3-5 perguntas especificas baseadas nos meus dados]
```

### Prompt Alternativo: Simulador Completo Automatico

```
Faca a simulacao completa dos regimes para minha empresa:

DADOS:
- Faturamento anual: R$ [valor]
- Lucro anual estimado: R$ [valor]
- Folha anual: R$ [valor]
- Atividade: [descrever]
- CNAE: [codigo]
- Estado: [UF]

SIMULE DETALHADAMENTE:

1. SIMPLES NACIONAL:
   - Fator R = Folha / Faturamento = ?
   - Anexo = [I a V]
   - RBT12 = R$ ___
   - Faixa = ___
   - Aliquota nominal = ___
   - Parcela a deduzir = R$ ___
   - Aliquota efetiva = ___
   - Imposto anual = R$ ___

2. LUCRO PRESUMIDO:
   - Presuncao para [atividade] = ___
   - Lucro presumido = R$ ___
   - IRPJ = R$ ___
   - CSLL = R$ ___
   - PIS = R$ ___
   - COFINS = R$ ___
   - ISS = R$ ___
   - INSS Patronal = R$ ___
   - TOTAL = R$ ___

3. LUCRO REAL (se margem < 32%):
   - [Calculo simplificado]

COMPARATIVO FINAL:
| Regime | Carga | Valor/ano | Recomendacao |
```

### Como Usar o Resultado

| Resultado da Validacao | Acao |
|------------------------|------|
| Calculos corretos | Levar para contador confirmar |
| Erro identificado | Corrigir e recalcular |
| Armadilha apontada | Incluir custo esquecido |
| Conclusao questionada | Reavaliar decisao |

---

## Checklist de Validacao

Antes de seguir:

- [ ] Dados basicos preenchidos corretamente
- [ ] Pelo menos 2 alternativas simuladas
- [ ] Calculos conferidos (ou feitos com IA)
- [ ] Comparativo preenchido
- [ ] Decisao registrada (mesmo que "preciso validar")

---

## ARTEFATO DA AULA: Matriz Regime x Estrutura Preenchida

### O Que Voce Vai Criar
Sua Matriz de comparacao de regimes completa, com dados reais da empresa, simulacoes de alternativas, analise de tradeoffs e decisao documentada.

### Por Que Isso Importa
Esta e o ENTREGAVEL PRINCIPAL do Modulo 2:
- Compara seu regime com alternativas reais
- Quantifica economia (ou prejuizo) de migrar
- Documenta decisao para contador
- Base para acao concreta

**Linha do DRE:** Economia Tributaria Potencial (quanto pode economizar com regime otimo)

### Quando Usar
- Agora: criar durante a aula
- Em reuniao com contador
- Revisao anual (janeiro)
- Quando faturamento mudar 30%+

### Como Criar
1. **Passo 1 (5 min):** Dados basicos
2. **Passo 2 (5 min):** Simular Simples
3. **Passo 3 (5 min):** Simular Presumido
4. **Passo 4 (5 min):** Simular Real (se aplicavel)
5. **Passo 5 (3 min):** Comparar e decidir
6. **Passo 6 (2 min):** Validar com IA

### Template Final

```
===========================================
MATRIZ REGIME X ESTRUTURA
===========================================

Empresa: _______________
Data: ___/___/______

DADOS:
- Faturamento anual: R$ _______________
- Lucro anual: R$ _______________ (___%)
- Folha anual: R$ _______________
- Fator R: _____%
- CNAE: _______________

COMPARATIVO FINAL:
| Criterio | ATUAL | ALT 1 | ALT 2 |
|----------|-------|-------|-------|
| Regime | | | |
| Carga (%) | % | % | % |
| Imposto/ano | R$ | R$ | R$ |
| Economia | - | R$ | R$ |
| Custo contabil | R$/mes | R$/mes | R$/mes |
| Complexidade | | | |
| Score 1-10 | | | |

MELHOR OPCAO FINANCEIRA: _______________
ECONOMIA POTENCIAL: R$ ___/ano

DECISAO:
[ ] Manter regime atual
    Motivo: _______________
[ ] Migrar para _______________
    Quando: _______________
    Economia: R$ ___/ano
[ ] Validar com contador antes de decidir

PROXIMA ACAO: _______________

STATUS: [ ] Completo [ ] Precisa validar
===========================================
```

---

**Criar agora?** ✅ Sim, OBRIGATORIO durante a aula (25 min)
**Tempo estimado:** 25-30 minutos
**Onde salvar:** Documento principal - base para decisao de regime

---

## Proximo Passo

Com a Matriz pronta, vamos validar sua analise e definir os proximos passos concretos.

→ Aula 2.8: Validacao e Proximos Passos

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Timer de 25 minutos
- Template dividido por etapas
- Formulas de calculo na tela
- Prompt de IA destacado

### Orientacoes
- Dar tempo real para calculos
- Permitir uso de calculadora/IA
- Lembrar de incluir INSS no Presumido
- Incentivar validacao com contador

---

**Duracao real:** 25 minutos
**Proximo:** Aula 2.8
