# Aula 1.7: Exercicio - Seu Mapa Tributario

## Trilha 4 | Modulo 1 | Diagnostico Tributario

---

> **Duracao:** 30 minutos
> **Tipo:** Pratica
> **Entregavel:** Mapa Tributario Empresarial preenchido

---

## Objetivo

Preencher seu proprio Mapa Tributario Empresarial com dados REAIS da sua empresa.

---

## Materiais Necessarios

Antes de comecar, tenha em maos:

- [ ] Guias de impostos dos ultimos 6 meses
- [ ] Folha de pagamento (valor bruto total)
- [ ] Regime tributario (Simples/Presumido/Real)
- [ ] CNAE principal da empresa
- [ ] Faturamento medio mensal

**Nao tem algum dado?** Peca ao contador AGORA. Este exercicio vale a espera.

---

## Passo 1: Dados Gerais (5 min)

Preencha os dados basicos:

```
DADOS DA EMPRESA
================
Razao Social: _______________________________________
CNPJ: __.___.___ /____-__
CNAE Principal: _____ - ____________________________
Regime Tributario: [ ] Simples [ ] Presumido [ ] Real
Faturamento Mensal Medio: R$ _______________
Numero de Funcionarios: _______
Folha Bruta Mensal: R$ _______________
```

---

## Passo 2: Tributos Explicitos (10 min)

### Se voce e SIMPLES NACIONAL:

```
SIMPLES NACIONAL (DAS)
======================
Anexo: _____
Aliquota efetiva: _____%
Valor DAS mensal: R$ _______________

Decomposicao (ver DAS ou usar calculadora):
| Componente | % | Valor/Mes |
|------------|---|-----------|
| IRPJ | % | R$ |
| CSLL | % | R$ |
| COFINS | % | R$ |
| PIS | % | R$ |
| CPP | % | R$ |
| ISS/ICMS | % | R$ |
| TOTAL | % | R$ |
```

### Se voce e LUCRO PRESUMIDO ou REAL:

```
TRIBUTOS FEDERAIS
=================
| Tributo | Valor/Mes | % Faturamento |
|---------|-----------|---------------|
| IRPJ | R$ | % |
| CSLL | R$ | % |
| PIS | R$ | % |
| COFINS | R$ | % |
| INSS Patronal | R$ | % |

TRIBUTOS ESTADUAIS
==================
| Tributo | Valor/Mes | % Faturamento |
|---------|-----------|---------------|
| ICMS | R$ | % |

TRIBUTOS MUNICIPAIS
===================
| Tributo | Valor/Mes | % Faturamento |
|---------|-----------|---------------|
| ISS | R$ | % |

TOTAL EXPLICITO: R$ ___________ (____%)
```

---

## Passo 3: Encargos - Carga Implicita (10 min)

```
ENCARGOS SOBRE FOLHA
====================
Folha bruta mensal: R$ _______________

| Item | % | Valor/Mes |
|------|---|-----------|
| FGTS | 8% | R$ |
| Provisao Ferias + 1/3 | 11% | R$ |
| Provisao 13o | 8% | R$ |
| FGTS sobre provisoes | 8% de (ferias+13o) | R$ |
| INSS Patronal* | 20%** | R$ |
| RAT/SAT | ___% | R$ |
| TOTAL ENCARGOS | | R$ |

* Se Simples, INSS ja esta no DAS (CPP)
** Lucro Presumido/Real: 20% sobre folha
```

### Calculo rapido (se Simples):

```
Encargos = Folha x 0.27 (FGTS + Provisoes)
Encargos = R$ _______ x 0.27 = R$ _______
```

### Calculo rapido (se Presumido/Real):

```
Encargos = Folha x 0.47 (FGTS + Provisoes + INSS)
Encargos = R$ _______ x 0.47 = R$ _______
```

---

## Passo 4: Custos Ocultos (5 min)

Revise os ultimos 12 meses:

```
CUSTOS OCULTOS
==============
| Item | Teve? | Valor Total | Valor/Mes |
|------|-------|-------------|-----------|
| Multas de atraso | [ ] | R$ | R$ |
| Juros de mora | [ ] | R$ | R$ |
| Honorarios extras | [ ] | R$ | R$ |
| Autuacoes | [ ] | R$ | R$ |
| TOTAL OCULTO | | R$ | R$ |

Se nao teve nenhum: Parabens! Coloque R$ 0.
Se nao sabe: Pergunte ao contador.
```

---

## Passo 5: Consolidar (5 min)

```
RESUMO - CARGA TRIBUTARIA TOTAL
===============================
Faturamento mensal: R$ _______________

| Tipo | Valor/Mes | Valor/Ano | % Faturamento |
|------|-----------|-----------|---------------|
| Explicita | R$ | R$ | % |
| Implicita | R$ | R$ | % |
| Oculta | R$ | R$ | % |
| TOTAL | R$ | R$ | % |

Lucro mensal estimado: R$ _______________
Carga sobre LUCRO: _____% (Total / Lucro x 100)
```

---

## Passo 6: Analise Inicial

### Compare com benchmarks:

| Seu Regime | Sua Carga Explicita | Benchmark |
|------------|---------------------|-----------|
| Simples (servicos) | ____% | 9-13% |
| Simples (comercio) | ____% | 5-10% |
| Presumido (servicos) | ____% | 12-17% |
| Presumido (comercio) | ____% | 7-12% |

**Voce esta:**
- [ ] Abaixo da media (investigar se esta correto)
- [ ] Na media (ok, mas ha espaco para otimizar)
- [ ] Acima da media (prioridade alta para revisao)

### Carga sobre lucro:

| Sua Carga/Lucro | Situacao |
|-----------------|----------|
| < 50% | Excelente |
| 50-70% | Bom |
| 70-85% | Atencao |
| > 85% | Critico - revisar urgente |

---

## IA NA PRATICA

### Prompt Principal: Validador de Mapa Completo

```
Atue como auditor tributario. Valide meu Mapa Tributario Empresarial:

DADOS DA EMPRESA:
- Razao Social: [nome]
- CNPJ: [numero]
- CNAE: [codigo] - [descricao]
- Regime: [Simples/Presumido/Real]
- Faturamento mensal: R$ [valor]
- Funcionarios: [numero]
- Folha bruta: R$ [valor]/mes

MINHA CARGA CALCULADA:
- Tributos explicitos: R$ [valor]/mes ([__]%)
- Encargos (implicita): R$ [valor]/mes ([__]%)
- Custos ocultos: R$ [valor]/mes ([__]%)
- TOTAL: R$ [valor]/mes ([__]%)
- Carga sobre lucro: [__]%

VALIDE:
1. Os percentuais estao coerentes para meu regime e CNAE?
2. Ha algum valor que parece fora do padrao? (muito alto ou muito baixo)
3. Estou esquecendo algum tributo ou encargo relevante?
4. O calculo de encargos sobre folha esta correto?
5. A carga sobre lucro faz sentido para minha margem?

DIAGNOSTICO:
- [ ] Mapa parece correto
- [ ] Mapa tem inconsistencias (listar quais)
- [ ] Precisa validar com contador (listar pontos)

PERGUNTAS PARA O CONTADOR:
[Gere 3-5 perguntas especificas baseadas nos meus dados]
```

### Prompt Alternativo: Identificador de Oportunidades

```
Com base no meu Mapa Tributario, identifique oportunidades de economia:

MEU MAPA RESUMIDO:
- Regime: [Simples/Presumido/Real]
- Faturamento: R$ [valor]/mes
- Carga total: [__]%
- Carga sobre lucro: [__]%
- Maior imposto: [nome] - R$ [valor]
- Segundo maior: [nome] - R$ [valor]
- Proporcao folha/faturamento: [__]%

IDENTIFIQUE:
1. Meus 3 maiores "vazamentos" tributarios
2. Estrategias LICITAS para cada um (elisao fiscal)
3. Economia potencial estimada (% ou R$)
4. Complexidade de implementacao (Facil/Media/Complexa)
5. O que perguntar ao contador sobre cada uma

IMPORTANTE: Apenas estrategias legais e defensaveis.
```

### Como Usar o Resultado

| Resultado da Validacao | Proxima Acao |
|------------------------|--------------|
| Mapa correto | Seguir para analise com contador |
| Inconsistencias encontradas | Revisar dados e recalcular |
| Oportunidades identificadas | Anotar para Modulo 3 |
| Perguntas geradas | Levar para reuniao com contador |

---

## Checklist de Validacao

Antes de seguir, confirme:

- [ ] Todos os campos preenchidos (sem "nao sei")
- [ ] Valores baseados em dados reais (nao chutados)
- [ ] Percentuais calculados corretamente
- [ ] Comparado com benchmark do seu regime
- [ ] Carga sobre lucro calculada

---

## ARTEFATO DA AULA: Mapa Tributario Empresarial Preenchido

### O Que Voce Vai Criar
Seu Mapa Tributario Empresarial completo, com dados REAIS da sua empresa, validado por IA e pronto para apresentar ao contador.

### Por Que Isso Importa
Este e o ENTREGAVEL PRINCIPAL do Modulo 1:
- Primeira vez que ve carga TOTAL (nao so guias)
- Base para todas as decisoes da trilha
- Documento para reuniao com contador
- Comparativo com benchmark do setor

**Linha do DRE:** Visibilidade Total de Custos Tributarios (explicitos + implicitos + ocultos)

### Quando Usar
- Agora: criar durante a aula
- Mensalmente: atualizar valores
- Anualmente: revisar estrutura
- Antes de decisoes: consultar baseline

### Como Criar
1. **Passo 1 (5 min):** Preencher dados gerais
2. **Passo 2 (10 min):** Mapear tributos explicitos
3. **Passo 3 (10 min):** Calcular encargos implicitos
4. **Passo 4 (5 min):** Revisar custos ocultos
5. **Passo 5 (5 min):** Consolidar e analisar

### Template Final

```
===========================================
MAPA TRIBUTARIO EMPRESARIAL
===========================================

Empresa: _______________
Data: ___/___/______
Periodo de referencia: _______________

DADOS GERAIS:
- CNPJ: _______________
- CNAE: _______________
- Regime: _______________
- Faturamento: R$ _______/mes
- Funcionarios: ___
- Folha: R$ _______/mes

CARGA EXPLICITA:
Total: R$ _______/mes (____% do faturamento)

CARGA IMPLICITA:
Total: R$ _______/mes (____% do faturamento)

CARGA OCULTA:
Total: R$ _______/mes (____% do faturamento)

RESUMO:
| Tipo | Valor | % Fat |
|------|-------|-------|
| Explicita | R$ _____ | ___% |
| Implicita | R$ _____ | ___% |
| Oculta | R$ _____ | ___% |
| TOTAL | R$ _____ | ___% |

CARGA SOBRE LUCRO: _____%

COMPARATIVO BENCHMARK:
[ ] Abaixo da media - investigar
[ ] Na media - ok, ha espaco
[ ] Acima da media - prioridade alta

TOP 3 MAIORES IMPOSTOS:
1. _________ - R$ _______
2. _________ - R$ _______
3. _________ - R$ _______

STATUS: [ ] Completo [ ] Parcial (falta: ___)
VALIDADO COM IA: [ ] Sim [ ] Nao

===========================================
```

---

**Criar agora?** ✅ Sim, OBRIGATORIO durante a aula (30 min)
**Tempo estimado:** 30-40 minutos
**Onde salvar:** Documento principal - base para todo o curso

---

## Proximo Passo

Com seu Mapa pronto, vamos validar se esta correto e definir os proximos passos.

→ Aula 1.8: Validacao e Proximos Passos

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Timer de 30 minutos visivel
- Template completo na tela
- Campos divididos por etapa
- Prompt de IA destacado

### Orientacoes
- Dar tempo real para preenchimento
- Pausas para cada etapa
- Lembrar de usar dados reais
- Incentivar validacao com IA

---

**Duracao real:** 30 minutos
**Proximo:** Aula 1.8
