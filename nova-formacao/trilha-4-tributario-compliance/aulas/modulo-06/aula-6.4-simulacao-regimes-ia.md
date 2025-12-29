# AULA 6.4 | Simulacao de Regimes com IA

## Modulo 6 - IA para Gestao Tributaria | Trilha 4

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 15 minutos |
| **Tipo** | Pratico |
| **Formato** | Video |
| **Entregavel** | Simulacao comparativa de regimes via IA |

---

## OBJETIVO DA AULA

Aluno aprende:
- Como usar IA para simular diferentes regimes
- Prompts para comparacao Simples vs Presumido vs Real
- Como analisar cenarios de crescimento
- Conexao com Matriz do Modulo 2

---

## ROTEIRO DE GRAVACAO

[TELA: "SIMULACAO DE REGIMES COM IA"]

[CONEXAO COM MODULO 2 - 2 min]
Locucao: "No Modulo 2, voce criou a Matriz de Regimes.
Com IA, voce pode:
- Simular TODOS os regimes rapidamente
- Testar cenarios de crescimento
- Identificar ponto de virada
- Atualizar quando faturamento mudar"

---

[TELA: Prompt de simulacao]

[PROMPT PRINCIPAL - 5 min]
Locucao: "Use este prompt para simular regimes:

---
Atue como contador tributarista. Simule os 3 regimes para minha empresa:

DADOS ATUAIS:
- Faturamento: R$ X/mes
- Margem de lucro: X%
- Folha pagamento: R$ X/mes
- Pro-labore: R$ X/mes
- Atividade: [descrever]

SIMULE:
1. Simples Nacional (identifique anexo)
2. Lucro Presumido
3. Lucro Real

PARA CADA REGIME, CALCULE:
- Impostos totais/mes
- % sobre faturamento
- % sobre lucro
- Vantagens
- Desvantagens

FORMATO: Tabela comparativa
ADICIONE: Recomendacao final com justificativa
---"

---

[TELA: Analise de cenarios]

[CENARIOS - 4 min]
Locucao: "Teste CENARIOS de crescimento:

'Agora simule se meu faturamento aumentar:
- Cenario atual: R$ 50K/mes
- Cenario +20%: R$ 60K/mes
- Cenario +50%: R$ 75K/mes
- Cenario +100%: R$ 100K/mes

Em qual ponto devo mudar de regime?'

A IA vai calcular o PONTO DE VIRADA."

---

[TELA: Ponto de virada]

[PONTO DE VIRADA - 4 min]
Locucao: "O ponto de virada e quando um regime passa a ser melhor que outro.

Exemplo:
- Ate R$ 80K: Simples melhor
- Acima de R$ 80K: Presumido melhor

A IA calcula isso para voce:
'Qual o faturamento exato em que devo mudar de Simples para Presumido?'

Valide com contador antes de mudar!"

---

## PROMPT DE SIMULACAO DE REGIMES

```
Atue como contador tributarista especialista em regimes tributarios brasileiros.

DADOS DA MINHA EMPRESA:

Identificacao:
- Atividade: [descrever]
- CNAE: [se souber]
- Estado: [UF]

Faturamento:
- Mensal atual: R$ [valor]
- Anual atual: R$ [valor x 12]
- Projecao proximo ano: R$ [valor]

Custos e Folha:
- Custo fixo mensal: R$ [valor]
- Custo variavel (% do faturamento): [X%]
- Folha de pagamento: R$ [valor]
- Pro-labore socios: R$ [valor]

Lucro:
- Margem de lucro bruta: [X%]
- Margem de lucro liquida: [X%]

SIMULE OS 3 REGIMES:

1. SIMPLES NACIONAL
   - Anexo aplicavel: ___
   - Aliquota efetiva: ___%
   - DAS mensal: R$ ___
   - Outros custos: R$ ___
   - Total mensal: R$ ___
   - Total anual: R$ ___
   - % sobre faturamento: ___%

2. LUCRO PRESUMIDO
   - Base de calculo IRPJ: R$ ___
   - IRPJ: R$ ___
   - CSLL: R$ ___
   - PIS/COFINS: R$ ___
   - ISS/ICMS: R$ ___
   - INSS patronal: R$ ___
   - Total mensal: R$ ___
   - Total anual: R$ ___
   - % sobre faturamento: ___%

3. LUCRO REAL
   - Lucro tributavel: R$ ___
   - IRPJ: R$ ___
   - CSLL: R$ ___
   - PIS/COFINS (nao cumulativo): R$ ___
   - ISS/ICMS: R$ ___
   - INSS patronal: R$ ___
   - Total mensal: R$ ___
   - Total anual: R$ ___
   - % sobre faturamento: ___%

TABELA COMPARATIVA:

| Regime | Imposto/Mes | Imposto/Ano | % Faturamento | Ranking |
|--------|-------------|-------------|---------------|---------|
| Simples | R$ | R$ | % | |
| Presumido | R$ | R$ | % | |
| Real | R$ | R$ | % | |

ECONOMIA COM MELHOR REGIME:
- Melhor regime: ___
- Economia vs atual: R$ ___/ano
- Economia vs pior opcao: R$ ___/ano

ANALISE:
- Por que [regime] e melhor: ___
- Quando reconsiderar: ___
- Riscos da mudanca: ___

RECOMENDACAO FINAL:
___
```

---

## PROMPT DE CENARIOS DE CRESCIMENTO

```
Atue como planejador tributario. Simule cenarios de crescimento:

SITUACAO ATUAL:
- Faturamento: R$ [valor]/mes
- Regime atual: [Simples/Presumido/Real]
- Carga atual: ___% do faturamento

CENARIOS A SIMULAR:

| Cenario | Faturamento | Crescimento |
|---------|-------------|-------------|
| Atual | R$ [valor] | 0% |
| Otimista | R$ [valor x 1.2] | +20% |
| Muito bom | R$ [valor x 1.5] | +50% |
| Dobrar | R$ [valor x 2] | +100% |

PARA CADA CENARIO, CALCULE:

| Cenario | Faturamento | Simples | Presumido | Real | Melhor |
|---------|-------------|---------|-----------|------|--------|
| Atual | R$ | R$ | R$ | R$ | |
| +20% | R$ | R$ | R$ | R$ | |
| +50% | R$ | R$ | R$ | R$ | |
| +100% | R$ | R$ | R$ | R$ | |

PONTO DE VIRADA:
- Faturamento em que Presumido passa a ser melhor que Simples: R$ ___
- Faturamento em que Real passa a ser melhor: R$ ___
- Faturamento em que excede limite do Simples: R$ ___

ALERTA DE MUDANCA:
Quando meu faturamento atingir R$ ___, devo:
1. ___
2. ___
3. ___

RECOMENDACAO PARA CADA CENARIO:
___
```

---

## ARTEFATO DA AULA: Simulacao de Regimes via IA

### O Que Voce Vai Criar
Simulacao completa dos 3 regimes + cenarios de crescimento, pronta para comparar com sua Matriz do Modulo 2.

### Por Que Isso Importa
Simulacao com IA:
- Testa multiplos cenarios em minutos
- Identifica pontos de virada
- Prepara para crescimento
- Base para decisao informada

**Linha do DRE:** Economia Tributaria (escolher regime certo = menos imposto)

### Quando Usar
- Ao avaliar mudanca de regime
- Todo Janeiro (revisao anual)
- Quando faturamento mudar significativamente
- Antes de captacao de investimento

### Como Criar
1. Preencha prompt com dados atuais
2. Rode simulacao base
3. Teste cenarios de crescimento
4. Compare com Matriz do Modulo 2
5. Valide com contador

### Template de Resultado

```
RESULTADO DA SIMULACAO - REGIMES

Data: ___/___/______
Faturamento base: R$ ___/mes

COMPARATIVO:
| Regime | Mensal | Anual | % Fat | Status |
|--------|--------|-------|-------|--------|
| Simples | R$ | R$ | % | [ ] Atual [ ] Recomendado |
| Presumido | R$ | R$ | % | [ ] Atual [ ] Recomendado |
| Real | R$ | R$ | % | [ ] Atual [ ] Recomendado |

ECONOMIA POSSIVEL: R$ ___/ano

PONTO DE VIRADA:
- Mudar de Simples para Presumido em: R$ ___
- Meu faturamento esta: [ ] Longe [ ] Proximo [ ] Acima

PROXIMA ACAO:
[ ] Manter regime atual
[ ] Avaliar mudanca para ___
[ ] Agendar com contador

COMPARACAO COM MATRIZ MODULO 2:
- Resultado coincide? [ ] Sim [ ] Nao
- Diferenca: ___
```

---

**Criar agora?** ✅ Sim, durante a aula (15 min)
**Tempo estimado:** 15 minutos
**Onde salvar:** Junto com Matriz de Regimes

---

## IA NA PRATICA

### Prompt Principal: Simulador de Regimes Completo

```
[USAR PROMPT DE SIMULACAO ACIMA]
```

### Prompt Alternativo: Identificador de Ponto de Virada

```
Atue como consultor tributario. Identifique meu ponto de virada entre regimes:

MINHA SITUACAO:
- Regime atual: [Simples/Presumido/Real]
- Faturamento atual: R$ [valor]/mes
- Crescimento esperado: ___% ao ano
- Margem de lucro: ___%
- Folha/Faturamento: ___%

CALCULE:

1. PONTO DE VIRADA SIMPLES → PRESUMIDO:
   Faturamento em que Presumido passa a ser melhor: R$ ___/mes
   Motivo: ___

2. PONTO DE VIRADA PRESUMIDO → REAL:
   Faturamento em que Real passa a ser melhor: R$ ___/mes
   Motivo: ___

3. LIMITE DO SIMPLES:
   Faturamento maximo: R$ 4.8M/ano = R$ ___/mes
   Quanto falta: R$ ___

4. PROJECAO:
   Com crescimento de ___% ao ano:
   - Em 1 ano: R$ ___/mes → Regime ideal: ___
   - Em 2 anos: R$ ___/mes → Regime ideal: ___
   - Em 3 anos: R$ ___/mes → Regime ideal: ___

5. QUANDO DEVO COMECAR A PLANEJAR MUDANCA:
   ___

6. CHECKLIST DE TRANSICAO:
   [ ] Prazo para solicitar mudanca: ___
   [ ] Documentos necessarios: ___
   [ ] Impacto no fluxo de caixa: ___
```

### Como Usar o Resultado

| Simulacao | Proxima Acao |
|-----------|--------------|
| Regime atual e melhor | Manter, revisar em 6 meses |
| Outro regime e melhor | Avaliar com contador |
| Proximo do ponto de virada | Planejar transicao |
| Acima do limite | Mudanca obrigatoria |

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Tabela comparativa grande
- Grafico de ponto de virada
- Cenarios com cores (verde/amarelo/vermelho)
- Timeline de crescimento

### Orientacoes
- Mostrar calculos passo a passo
- Enfatizar validacao com contador
- Conectar com Modulo 2
- Tom pratico

---

**Proxima Aula:** 6.5 - Planejamento Tributario Assistido por IA
