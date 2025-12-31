# Aula 5.4: Analise de Padroes com IA

## Trilha 8 - CS e Atendimento | Modulo 5

---

> **Duracao:** 8 minutos
> **Tipo:** Template (Prompts de Analise)
> **Entregavel:** Prompt de Analise de Padroes
> **Linha do DRE:** Inteligencia de Atendimento

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM ESTRATEGICO]

"Voce tem dados de QA Score.
Tem NPS e CSAT.
Tem comentarios dos clientes.

Mas o que fazer com tudo isso?

Analisar manualmente leva horas.
IA faz em segundos.

Nos proximos 8 minutos, voce vai aprender
a usar IA pra encontrar PADROES nos seus dados."
```

---

### TIPOS DE PADROES (2 minutos)

```
[MOSTRAR FRAMEWORK]

"Existem 5 tipos de padroes pra procurar.

[MOSTRAR LISTA]

1. PADROES DE RECLAMACAO
   - O que os detratores reclamam?
   - Quais palavras aparecem mais?
   - Qual categoria tem mais problema?

2. PADROES DE ELOGIO
   - O que os promotores elogiam?
   - O que diferencia o atendimento bom?
   - Qual atendente recebe mais elogios?

3. PADROES DE TEMPO
   - Horarios com mais reclamacao?
   - Dias da semana piores?
   - Epoca do mes com mais tickets?

4. PADROES DE ATENDENTE
   - Quem tem melhor QA Score?
   - Quem tem mais reclamacoes?
   - Qual a diferenca entre eles?

5. PADROES DE CATEGORIA
   - Qual tipo de ticket tem pior CSAT?
   - Qual categoria demora mais?
   - Onde precisa treinar?

[MOSTRAR INSIGHT]

Encontrar padroes = encontrar CAUSA RAIZ.
Resolver causa raiz = resolver problema de vez."
```

---

### PROMPT ANALISADOR DE RECLAMACOES (1.5 minutos)

```
[MOSTRAR PROMPT]

"Primeiro: analisar reclamacoes.

[MOSTRAR PROMPT COMPLETO]

---
PROMPT: ANALISADOR DE RECLAMACOES

Analise estes comentarios negativos de clientes:

COMENTARIOS:
[Cole todos os comentarios de notas 1-2 ou NPS 0-6]

Encontre:
1. TOP 5 TEMAS mais reclamados
   - Liste em ordem de frequencia
   - Quantas vezes cada um aparece

2. PALAVRAS MAIS COMUNS
   - Liste as 10 palavras negativas mais frequentes
   - Agrupe sinonimos

3. CATEGORIAS AFETADAS
   - Quais tipos de ticket geram mais reclamacao?

4. PADROES ESCONDIDOS
   - Algo que aparece de forma indireta?
   - Alguma conexao entre reclamacoes?

5. ACOES RECOMENDADAS
   - Para cada tema, 1 acao especifica
---

[MOSTRAR EXEMPLO]

Rodei esse prompt com 50 comentarios.
Descobri que 40% reclamavam de 'demora na resposta'.
Acao: definir SLA de 30 minutos."
```

---

### PROMPT COMPARADOR DE ATENDENTES (1.5 minutos)

```
[MOSTRAR PROMPT]

"Segundo: comparar atendentes.

[MOSTRAR PROMPT COMPLETO]

---
PROMPT: COMPARADOR DE ATENDENTES

Analise o desempenho destes atendentes:

DADOS:
[Cole tabela com: Atendente | QA Score | CSAT | Tickets/dia | Tempo medio]

Atendente 1: [dados]
Atendente 2: [dados]
Atendente 3: [dados]

Encontre:
1. RANKING GERAL
   - Quem e o melhor overall?
   - Quem precisa de mais ajuda?

2. PONTOS FORTES DE CADA UM
   - Em que cada um se destaca?

3. OPORTUNIDADES DE CADA UM
   - O que cada um pode melhorar?

4. MELHORES PRATICAS
   - O que o top performer faz diferente?
   - O que pode ser replicado?

5. PLANO DE DESENVOLVIMENTO
   - Para cada um, 1 acao de melhoria
---

[MOSTRAR EXEMPLO]

Rodei esse prompt com 5 atendentes.
Descobri que a melhor sempre começa com 'Entendo sua frustracao'.
Repliquei pro time. CSAT subiu 8%."
```

---

### PROMPT DE TENDENCIAS (1.5 minutos)

```
[MOSTRAR PROMPT]

"Terceiro: identificar tendencias.

[MOSTRAR PROMPT COMPLETO]

---
PROMPT: DETECTOR DE TENDENCIAS

Analise a evolucao destas metricas:

DADOS POR SEMANA/MES:
[Cole tabela com: Periodo | Tickets | QA Score | CSAT | NPS | Tempo medio]

Semana 1: [dados]
Semana 2: [dados]
Semana 3: [dados]
Semana 4: [dados]

Encontre:
1. TENDENCIAS
   - O que esta melhorando?
   - O que esta piorando?
   - O que esta estagnado?

2. CORRELACOES
   - Quando X sobe, Y tambem sobe?
   - Alguma relacao entre metricas?

3. ANOMALIAS
   - Alguma semana/mes fora do padrao?
   - O que pode ter causado?

4. PREVISAO
   - Se continuar assim, onde estaremos em 30 dias?

5. ALERTAS
   - Algo preocupante que precisa de atencao?
---

[MOSTRAR EXEMPLO]

Rodei esse prompt com 12 semanas.
Descobri que QA cai toda sexta-feira.
Motivo: time reduzido. Acao: escalar plantao."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Agora voce tem 3 prompts poderosos:
- Analisador de reclamacoes
- Comparador de atendentes
- Detector de tendencias

Na proxima aula, vou te mostrar
como transformar essas analises
em uma ROTINA de melhoria continua.

Toda semana.
De forma sistematica.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Os 5 Tipos de Padroes

| Padrao | O que procurar | Pergunta-chave |
|--------|----------------|----------------|
| Reclamacao | Temas negativos recorrentes | O que mais irrita? |
| Elogio | Temas positivos recorrentes | O que encanta? |
| Tempo | Variacao por horario/dia | Quando piora? |
| Atendente | Variacao por pessoa | Quem faz diferente? |
| Categoria | Variacao por tipo de ticket | Onde dói mais? |

### Prompt 1: Analisador de Reclamacoes

```
Analise estes comentarios negativos de clientes:

COMENTARIOS:
[Cole todos os comentarios de notas 1-2 ou NPS 0-6]

Encontre:
1. TOP 5 TEMAS mais reclamados (ordem de frequencia)
2. PALAVRAS MAIS COMUNS (10 principais)
3. CATEGORIAS AFETADAS
4. PADROES ESCONDIDOS
5. ACOES RECOMENDADAS (1 por tema)

Formato:
- Use bullet points
- Seja especifico
- Inclua numeros quando possivel
```

### Prompt 2: Comparador de Atendentes

```
Analise o desempenho destes atendentes:

DADOS:
| Atendente | QA Score | CSAT | Tickets/dia | Tempo medio |
|-----------|----------|------|-------------|-------------|
| [nome1] | [X] | [X%] | [X] | [X min] |
| [nome2] | [X] | [X%] | [X] | [X min] |
| [nome3] | [X] | [X%] | [X] | [X min] |

Encontre:
1. RANKING GERAL (melhor a pior)
2. PONTOS FORTES de cada um
3. OPORTUNIDADES de cada um
4. MELHORES PRATICAS do top performer
5. PLANO de 1 acao por atendente
```

### Prompt 3: Detector de Tendencias

```
Analise a evolucao destas metricas:

DADOS POR PERIODO:
| Periodo | Tickets | QA Score | CSAT | Tempo medio |
|---------|---------|----------|------|-------------|
| [S1] | [X] | [X] | [X%] | [X min] |
| [S2] | [X] | [X] | [X%] | [X min] |
| [S3] | [X] | [X] | [X%] | [X min] |
| [S4] | [X] | [X] | [X%] | [X min] |

Encontre:
1. TENDENCIAS (subindo/caindo/estagnado)
2. CORRELACOES entre metricas
3. ANOMALIAS e possiveis causas
4. PREVISAO para proximos 30 dias
5. ALERTAS que precisam de atencao
```

---

## PROMPT DE IA PARA ANALISE COMPLETA

```
Faca uma analise completa dos meus dados de atendimento:

METRICAS GERAIS:
- Total de tickets/mes: ___
- QA Score medio: ___
- CSAT: ___%
- NPS: ___
- Tempo medio de resposta: ___ min

DISTRIBUICAO POR CATEGORIA:
[Liste as categorias e % de cada]

COMENTARIOS NEGATIVOS MAIS FREQUENTES:
[Liste os principais]

COMENTARIOS POSITIVOS MAIS FREQUENTES:
[Liste os principais]

DADOS POR ATENDENTE:
[Cole tabela]

Perguntas:
1. Qual meu maior problema de qualidade?
2. Qual minha maior forca?
3. O que os melhores atendentes fazem diferente?
4. Quais 3 acoes trariam mais impacto?
5. O que monitorar nas proximas semanas?
```

---

## CHECKPOINT

- [ ] Entendi os 5 tipos de padroes
- [ ] Tenho o prompt de reclamacoes
- [ ] Tenho o prompt de atendentes
- [ ] Tenho o prompt de tendencias
- [ ] Sei aplicar os prompts nos meus dados

---

## CONEXAO COM PROXIMA AULA

> Prompts de analise prontos. Agora vamos criar a ROTINA de uso.

**Proxima:** Aula 5.5 - Rotina de Melhoria Continua

---

**Tempo real:** 8 minutos
**Impacto DRE:** Capacidade de analise de padroes
