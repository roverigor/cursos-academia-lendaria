# Template: Prompts de Análise com IA

## Instruções de Uso

1. Escolha os 4 prompts mais relevantes para seu negócio
2. Personalize com suas métricas e contexto
3. Teste cada prompt com dados reais
4. Calibre até obter respostas úteis
5. Salve os prompts calibrados para uso recorrente

---

## Passo 1: Configure seu Contexto Base

### Contexto do Negócio (Usar em todos os prompts)

```
CONTEXTO DO MEU NEGÓCIO:

Empresa: _______________________
Tipo de negócio: _______________________
Faturamento médio mensal: R$ _______________________
Número de funcionários: _______________________
Modelo de receita: ⬜ Recorrente ⬜ Transacional ⬜ Projeto ⬜ Misto
Principais produtos/serviços: _______________________
Público-alvo: _______________________
Maior desafio atual: _______________________
```

---

## Passo 2: Escolha seus 4 Prompts

### Prompt 1: Análise de Performance Geral

**Quando usar:** Início da semana, verificação rápida de saúde do negócio

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

DADOS DA SEMANA:
- Faturamento: R$ [X] (meta: R$ [Y])
- Leads gerados: [X] (meta: [Y])
- Taxa de conversão: [X]% (meta: [Y]%)
- Ticket médio: R$ [X] (meta: R$ [Y])
- Churn: [X]% (meta: <[Y]%)
- NPS: [X] (meta: >[Y])

ANÁLISE SOLICITADA:

1. DIAGNÓSTICO (3 linhas máximo):
   - Qual a saúde geral do negócio esta semana?
   - Estamos no caminho certo para bater a meta mensal?

2. ALERTAS (se houver):
   - Qual métrica precisa de atenção URGENTE?
   - Por que essa métrica é preocupante?

3. OPORTUNIDADES (1-2 máximo):
   - Existe alguma métrica acima do esperado que podemos explorar?

4. AÇÃO RECOMENDADA (1 única ação):
   - Qual a ÚNICA coisa mais importante para fazer esta semana?
   - Por que essa e não outra?

Seja direto e prático. Não quero teoria, quero ação.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

### Prompt 2: Investigação de Problema

**Quando usar:** Quando uma métrica está fora do normal

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

PROBLEMA DETECTADO:
- Métrica afetada: [NOME DA MÉTRICA]
- Valor atual: [X]
- Valor esperado: [Y]
- Variação: [Z]% (acima/abaixo)
- Desde quando: [DATA]
- Duração: [X] dias/semanas

DADOS RELACIONADOS:
[Cole aqui dados que possam estar relacionados ao problema]

INVESTIGAÇÃO SOLICITADA:

1. HIPÓTESES (top 3):
   - Quais as causas mais prováveis deste problema?
   - Ordene por probabilidade

2. VALIDAÇÃO:
   - Que dados eu precisaria ver para confirmar cada hipótese?
   - O que posso verificar AGORA?

3. CONEXÕES:
   - Este problema pode estar afetando outras métricas?
   - Quais métricas devo monitorar junto?

4. AÇÃO IMEDIATA:
   - O que posso fazer nas próximas 24h para investigar melhor?
   - Se eu tivesse que apostar em UMA causa, qual seria?

Seja específico. Use os números que forneci.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

### Prompt 3: Previsão e Tendência

**Quando usar:** Meio do mês, planejamento de fechamento

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

DADOS DO MÊS ATUAL:
- Dia do mês: [X] de [TOTAL]
- Dias úteis restantes: [X]

Faturamento:
- Realizado até agora: R$ [X]
- Meta mensal: R$ [Y]
- % atingido: [Z]%

Vendas:
- Vendas fechadas: [X]
- Meta de vendas: [Y]
- Pipeline atual: R$ [Z]

Leads:
- Leads gerados: [X]
- Taxa de conversão histórica: [Y]%

HISTÓRICO (últimos 3 meses):
- Mês 1: R$ [X] ([Y]% da meta)
- Mês 2: R$ [X] ([Y]% da meta)
- Mês 3: R$ [X] ([Y]% da meta)

ANÁLISE DE TENDÊNCIA:

1. PROJEÇÃO:
   - Se mantivermos o ritmo atual, onde fechamos o mês?
   - Qual a probabilidade de bater a meta?

2. CENÁRIOS:
   - Cenário pessimista: R$ [X]
   - Cenário realista: R$ [X]
   - Cenário otimista: R$ [X]

3. GAP ANALYSIS:
   - Quanto falta para a meta?
   - Quantas vendas/leads/ações precisamos para cobrir?
   - É realista?

4. PLANO DE AÇÃO (se meta em risco):
   - O que precisa acontecer para reverter?
   - Quais alavancas temos disponíveis?
   - Priorize por impacto vs esforço

Seja realista nas projeções. Prefiro verdade dura a otimismo vazio.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

### Prompt 4: Comparativo de Períodos

**Quando usar:** Início do mês, análise de evolução

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

COMPARATIVO: [MÊS ATUAL] vs [MÊS ANTERIOR]

| Métrica | Mês Anterior | Mês Atual | Variação |
|---------|--------------|-----------|----------|
| Faturamento | R$ [X] | R$ [Y] | [Z]% |
| Leads | [X] | [Y] | [Z]% |
| Conversão | [X]% | [Y]% | [Z]pp |
| Ticket Médio | R$ [X] | R$ [Y] | [Z]% |
| Clientes Ativos | [X] | [Y] | [Z]% |
| Churn | [X]% | [Y]% | [Z]pp |
| NPS | [X] | [Y] | [Z] pts |

CONTEXTO DO PERÍODO:
- Houve alguma ação especial no mês anterior? [Descrever]
- Houve algum evento/sazonalidade? [Descrever]
- Mudanças no time/produto/processo? [Descrever]

ANÁLISE COMPARATIVA:

1. EVOLUÇÃO GERAL:
   - Estamos melhorando ou piorando?
   - Qual a tendência dos últimos 3 meses?

2. DESTAQUES POSITIVOS:
   - Quais métricas melhoraram significativamente?
   - O que explica essa melhora?
   - Como manter/amplificar?

3. PONTOS DE ATENÇÃO:
   - Quais métricas pioraram?
   - É variação normal ou sinal de problema?
   - Ação necessária?

4. PADRÕES:
   - Existe correlação entre métricas?
   - Algum padrão que devemos observar?

5. FOCO DO MÊS:
   - Baseado nesta análise, qual deve ser o foco principal?
   - Por quê?

Compare sempre em contexto. Números sem contexto não significam nada.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

### Prompt 5: Análise de Cliente/Segmento

**Quando usar:** Análise de cohort, segmentação

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

DADOS DE CLIENTES:

Por Segmento:
| Segmento | Qtd | Faturamento | Ticket Médio | Churn | NPS |
|----------|-----|-------------|--------------|-------|-----|
| [A] | [X] | R$ [Y] | R$ [Z] | [W]% | [V] |
| [B] | [X] | R$ [Y] | R$ [Z] | [W]% | [V] |
| [C] | [X] | R$ [Y] | R$ [Z] | [W]% | [V] |

Por Tempo de Casa:
| Tempo | Qtd | % do Total | Ticket Médio | Churn |
|-------|-----|------------|--------------|-------|
| 0-3 meses | [X] | [Y]% | R$ [Z] | [W]% |
| 3-12 meses | [X] | [Y]% | R$ [Z] | [W]% |
| 1-2 anos | [X] | [Y]% | R$ [Z] | [W]% |
| +2 anos | [X] | [Y]% | R$ [Z] | [W]% |

ANÁLISE DE CLIENTES:

1. PERFIL IDEAL:
   - Qual segmento/perfil é mais rentável?
   - Qual tem menor churn?
   - Qual deveríamos buscar mais?

2. RISCO:
   - Qual segmento apresenta maior risco?
   - Estamos muito dependentes de algum grupo?
   - Ação de mitigação?

3. EXPANSÃO:
   - Onde há oportunidade de crescimento?
   - Qual segmento está subexplorado?

4. RETENÇÃO:
   - Em que momento os clientes mais cancelam?
   - O que podemos fazer para prevenir?

5. RECOMENDAÇÃO ESTRATÉGICA:
   - Se pudéssemos focar em UM segmento, qual seria?
   - Por que esse e não outro?

Seja específico sobre qual ação tomar com cada segmento.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

### Prompt 6: Análise de Funil

**Quando usar:** Otimização de conversão, diagnóstico comercial

**Template:**

```
[CONTEXTO DO NEGÓCIO - colar acima]

FUNIL DE VENDAS (período: [MÊS/SEMANA]):

| Etapa | Volume | Conversão p/ próxima | Benchmark |
|-------|--------|---------------------|-----------|
| Visitantes | [X] | [Y]% | [Z]% |
| Leads | [X] | [Y]% | [Z]% |
| MQLs | [X] | [Y]% | [Z]% |
| SQLs | [X] | [Y]% | [Z]% |
| Propostas | [X] | [Y]% | [Z]% |
| Vendas | [X] | - | - |

TEMPO MÉDIO EM CADA ETAPA:
- Lead → MQL: [X] dias
- MQL → SQL: [X] dias
- SQL → Proposta: [X] dias
- Proposta → Venda: [X] dias
- Ciclo total: [X] dias

ANÁLISE DE FUNIL:

1. GARGALO:
   - Em qual etapa estamos perdendo mais?
   - Essa perda é normal ou excessiva?

2. DIAGNÓSTICO:
   - Por que essa etapa está com problema?
   - O que pode estar causando?

3. QUICK WIN:
   - Se melhorássemos 10% em UMA etapa, qual teria maior impacto?
   - Quanto isso representaria em vendas?

4. VELOCIDADE:
   - O ciclo de venda está adequado?
   - Onde está demorando mais?
   - Como acelerar?

5. AÇÃO PRIORITÁRIA:
   - Qual a única coisa para fazer esta semana para melhorar o funil?

Foque em impacto. Não quero melhorar tudo, quero melhorar o que importa.
```

**Meu prompt calibrado:**

```
[Copie o template acima e personalize]
```

---

## Passo 3: Meus 4 Prompts Escolhidos

| # | Prompt | Frequência | Quando Usar |
|---|--------|------------|-------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |

---

## Passo 4: Calibração dos Prompts

### Processo de Calibração

1. **Rode o prompt** com dados reais
2. **Avalie a resposta:**
   - É específica ou genérica?
   - Usa os números que forneci?
   - As recomendações são acionáveis?
3. **Ajuste conforme necessário:**
   - Adicione mais contexto se respostas genéricas
   - Peça formato específico se output confuso
   - Inclua restrições se respostas muito longas

### Log de Calibração

| Prompt | Data | Problema | Ajuste Feito | Resultado |
|--------|------|----------|--------------|-----------|
| | | | | |
| | | | | |
| | | | | |

---

## Passo 5: Boas Práticas

### Formato de Dados para IA

**Ruim:**
```
vendemos 50 mil esse mes e o mes passado foi 45
```

**Bom:**
```
| Mês | Faturamento | Variação |
|-----|-------------|----------|
| Anterior | R$ 45.000 | - |
| Atual | R$ 50.000 | +11% |
```

### Estrutura que Funciona

1. **Contexto primeiro** - Quem você é, o que faz
2. **Dados organizados** - Tabelas > texto corrido
3. **Pergunta específica** - O que quer saber exatamente
4. **Formato de resposta** - Como quer receber

### Erros Comuns

| Erro | Problema | Solução |
|------|----------|---------|
| Dados incompletos | IA inventa números | Forneça todos os dados relevantes |
| Pergunta vaga | Resposta genérica | Seja específico no que quer |
| Sem contexto | Conselho não aplicável | Sempre inclua contexto do negócio |
| Muito longo | IA perde foco | Limite a 4-5 perguntas por vez |

---

## Checklist de Validação

- [ ] Defini contexto base do meu negócio
- [ ] Escolhi 4 prompts mais relevantes
- [ ] Personalizei cada prompt com minhas métricas
- [ ] Testei cada prompt com dados reais
- [ ] Calibrei até obter respostas úteis
- [ ] Salvei os prompts calibrados
- [ ] Defini frequência de uso de cada prompt

---

## Troubleshooting

| Problema | Causa Provável | Solução |
|----------|----------------|---------|
| Resposta muito genérica | Pouco contexto | Adicione mais dados do seu negócio |
| IA "inventa" números | Dados incompletos | Forneça todos os números relevantes |
| Recomendações não aplicáveis | Contexto errado | Revise descrição do negócio |
| Resposta muito longa | Muitas perguntas | Limite a 3-4 perguntas por prompt |
| Resposta superficial | Pergunta vaga | Seja mais específico |

---

## Próxima Ação (48h)

**Tarefa:** Ter pelo menos 1 prompt calibrado e funcionando

**Qual prompt vou calibrar primeiro?** ______________________

**Com quais dados vou testar?** ______________________

---

*Template Trilha 3 - Módulo 4*
*Academia Lendária*
