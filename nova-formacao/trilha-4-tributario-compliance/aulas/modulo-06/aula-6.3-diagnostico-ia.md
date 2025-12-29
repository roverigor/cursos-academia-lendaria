# AULA 6.3 | Diagnostico Tributario com IA

## Modulo 6 - IA para Gestao Tributaria | Trilha 4

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 15 minutos |
| **Tipo** | Pratico |
| **Formato** | Video |
| **Entregavel** | Diagnostico tributario gerado com IA |

---

## OBJETIVO DA AULA

Aluno aprende:
- Como usar IA para fazer diagnostico tributario
- Prompts especificos para cada analise
- Como interpretar e validar resultados
- Conexao com o Mapa Tributario do Modulo 1

---

## ROTEIRO DE GRAVACAO

[TELA: "DIAGNOSTICO TRIBUTARIO COM IA"]

[CONEXAO COM MODULO 1 - 2 min]
Locucao: "No Modulo 1, voce criou o Mapa Tributario manualmente.
Agora, vamos usar IA para:
- Acelerar o diagnostico
- Identificar gaps
- Comparar com benchmarks
- Gerar insights automaticos"

---

[TELA: Prompt de diagnostico]

[PROMPT PRINCIPAL - 5 min]
Locucao: "Use este prompt para diagnostico completo:

---
Atue como consultor tributario. Faca um diagnostico completo:

DADOS DA MINHA EMPRESA:
- Faturamento: R$ X/mes
- Regime: [atual]
- Atividade: [descrever]
- Funcionarios: [quantidade]
- Pro-labore socios: R$ X
- Folha de pagamento: R$ X

CALCULE E ANALISE:
1. Carga tributaria atual (% do faturamento)
2. Principais impostos pagos
3. Se o regime atual e o melhor
4. Oportunidades de economia
5. Riscos identificados

FORMATO: Tabela + recomendacoes
---"

---

[TELA: Exemplo de resposta]

[INTERPRETACAO - 4 min]
Locucao: "A IA vai retornar algo assim:

DIAGNOSTICO:
| Metrica | Valor |
|---------|-------|
| Carga tributaria | 18% |
| Principal imposto | DAS (67%) |
| Regime atual | Simples |
| Regime recomendado | Simples (correto) |

OPORTUNIDADES:
1. Otimizar pro-labore: economia de R$ 5K/mes
2. Revisar CNAEs: possivel reducao de aliquota

RISCOS:
1. Fator R abaixo de 28% → Anexo V
2. Faturamento proximo do limite

Valide esses numeros com seu contador!"

---

[TELA: Validacao]

[VALIDACAO - 4 min]
Locucao: "IMPORTANTE: A IA pode errar.

Valide sempre:
1. Os calculos batem com seu DRE?
2. As aliquotas estao corretas?
3. O Fator R esta certo?
4. As sugestoes fazem sentido?

Use o prompt de validacao:
'Confira estes calculos. Meu contador disse que pago X. A IA disse Y. Qual esta certo?'"

---

## PROMPT DE DIAGNOSTICO COMPLETO

```
Atue como consultor tributario especialista em PMEs brasileiras.

DADOS DA MINHA EMPRESA:

Identificacao:
- Atividade principal: [descrever]
- CNAE principal: [se souber]
- Estado: [UF]

Numeros:
- Faturamento mensal: R$ [valor]
- Faturamento anual: R$ [valor x 12]
- Margem de lucro estimada: [X%]

Regime atual:
- Regime tributario: [Simples/Presumido/Real]
- Anexo do Simples (se aplicavel): [I a V]

Folha e socios:
- Numero de funcionarios: [quantidade]
- Folha de pagamento mensal: R$ [valor]
- Numero de socios: [quantidade]
- Pro-labore total dos socios: R$ [valor]
- Distribuicao de lucros mensal: R$ [valor]

FACA DIAGNOSTICO COMPLETO:

1. CARGA TRIBUTARIA ATUAL
   - Total de impostos/mes: R$ ___
   - % sobre faturamento: ___%
   - % sobre lucro: ___%
   - Composicao por imposto: ___

2. BENCHMARK DO SETOR
   - Media do setor: ___%
   - Minha empresa esta: [ ] Acima [ ] Na media [ ] Abaixo

3. ANALISE DO REGIME
   - Regime atual e adequado? [ ] Sim [ ] Nao
   - Se nao, qual seria melhor: ___
   - Economia estimada com mudanca: R$ ___/ano

4. FATOR R (se Simples)
   - Fator R atual: ___%
   - Anexo atual: ___
   - Anexo ideal: ___
   - Gap para mudar de anexo: R$ ___

5. OPORTUNIDADES IDENTIFICADAS
   | Oportunidade | Economia Potencial | Risco | Prioridade |
   |--------------|-------------------|-------|------------|
   | | R$ | | |

6. RISCOS IDENTIFICADOS
   | Risco | Impacto | Probabilidade | Acao Sugerida |
   |-------|---------|---------------|---------------|
   | | R$ | | |

7. TOP 3 ACOES RECOMENDADAS
   1. ___: Economia R$ ___, Risco ___
   2. ___: Economia R$ ___, Risco ___
   3. ___: Economia R$ ___, Risco ___

FORMATO: Resposta estruturada com tabelas e numeros claros
```

---

## ARTEFATO DA AULA: Diagnostico Tributario via IA

### O Que Voce Vai Criar
Diagnostico tributario completo gerado com IA, validado e pronto para comparar com seu Mapa Tributario do Modulo 1.

### Por Que Isso Importa
IA acelera o diagnostico:
- Minutos em vez de horas
- Identifica gaps automaticamente
- Compara com benchmarks
- Sugere acoes

**Linha do DRE:** Custo de Analise (tempo do consultor substituido por IA)

### Quando Usar
- Para fazer diagnostico inicial rapido
- Para segunda opiniao sobre seu Mapa
- Trimestralmente como check-up
- Quando faturamento mudar

### Como Criar
1. Preencha o prompt com seus dados
2. Rode na IA (ChatGPT, Claude, etc.)
3. Revise criticamente
4. Compare com Mapa Tributario
5. Valide com contador se divergir

### Template de Comparacao

```
COMPARACAO: MAPA vs DIAGNOSTICO IA

| Metrica | Meu Mapa (Modulo 1) | Diagnostico IA | Diferenca |
|---------|---------------------|----------------|-----------|
| Carga tributaria | ___% | ___% | ___% |
| Principal imposto | ___ | ___ | |
| Fator R | ___% | ___% | ___% |
| Regime recomendado | ___ | ___ | |

DIVERGENCIAS ENCONTRADAS:
1. ___: Meu valor = ___, IA = ___, Verificar: ___
2. ___: Meu valor = ___, IA = ___, Verificar: ___

VALIDACAO:
- [ ] Calculos conferem
- [ ] Aliquotas corretas
- [ ] Sugestoes fazem sentido
- [ ] Validei com contador

CONCLUSAO:
[ ] Diagnostico IA correto
[ ] Precisa ajustes: ___
[ ] Meu Mapa precisa correcao: ___
```

---

**Criar agora?** ✅ Sim, durante a aula (15 min)
**Tempo estimado:** 15 minutos
**Onde salvar:** Junto com Mapa Tributario

---

## IA NA PRATICA

### Prompt Principal: Diagnosticador Tributario Completo

```
Atue como consultor tributario. Faca diagnostico completo da minha empresa:

[USAR TEMPLATE ACIMA COM SEUS DADOS]
```

### Prompt Alternativo: Validador de Diagnostico

```
Atue como auditor tributario. Valide meu diagnostico:

MEU DIAGNOSTICO ATUAL:
- Carga tributaria: ___% do faturamento
- Regime: [Simples/Presumido/Real]
- Principal oportunidade: ___
- Principal risco: ___

DADOS REAIS DA EMPRESA:
- Faturamento: R$ [valor]/mes
- Impostos pagos ultimo mes: R$ [valor]
- Folha de pagamento: R$ [valor]

VERIFIQUE:

1. CALCULO DA CARGA TRIBUTARIA:
   - Meu calculo: ___%
   - Calculo correto: ___%
   - Diferenca: ___%
   - Erro identificado: ___

2. REGIME TRIBUTARIO:
   - Estou no regime certo? [ ] Sim [ ] Nao
   - Se nao, qual seria: ___
   - Economia com mudanca: R$ ___

3. OPORTUNIDADES NAO IDENTIFICADAS:
   Para meu tipo de empresa, tambem deveria considerar:
   - ___
   - ___

4. RISCOS NAO IDENTIFICADOS:
   Riscos adicionais:
   - ___
   - ___

5. SCORE DO DIAGNOSTICO:
   Completude: ___/10
   Precisao: ___/10
   Acoes claras: ___/10

RECOMENDACOES DE MELHORIA:
___
```

### Como Usar o Resultado

| Resultado | Proxima Acao |
|-----------|--------------|
| Diagnostico completo | Comparar com Mapa do Modulo 1 |
| Divergencias | Verificar qual esta correto |
| Oportunidades novas | Adicionar ao plano |
| Riscos novos | Incluir no checklist |

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Prompt grande e destacado
- Exemplo de resposta da IA
- Checklist de validacao
- Comparativo visual

### Orientacoes
- Mostrar prompt sendo usado
- Mostrar resposta real da IA
- Enfatizar validacao
- Conectar com Modulo 1

---

**Proxima Aula:** 6.4 - Simulacao de Regimes com IA
