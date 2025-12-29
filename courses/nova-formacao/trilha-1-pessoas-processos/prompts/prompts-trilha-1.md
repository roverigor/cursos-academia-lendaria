# Prompts IA - Trilha 1: Pessoas & Processos

## Compilacao de Todos os Prompts da Trilha

---

## Indice

1. [Modulo 1: Mapa de Dependencia Humana](#modulo-1-mapa-de-dependencia-humana)
2. [Modulo 2: Matriz Funcao x Decisao](#modulo-2-matriz-funcao-x-decisao)
3. [Modulo 3: SOP Inteligente](#modulo-3-sop-inteligente)
4. [Modulo 4: Delegacao Assistida](#modulo-4-delegacao-assistida)
5. [Modulo 5: ROI de Pessoas](#modulo-5-roi-de-pessoas)

---

## Modulo 1: Mapa de Dependencia Humana

### Prompt 1.1: Analise de Riscos de Dependencia

```
Voce e um consultor de gestao de riscos organizacionais.

Analise o seguinte Mapa de Dependencia Humana:

---
[COLAR MAPA AQUI - incluir: Funcao, Pessoa, Impacto se sair, Horas/semana, Documentado?, Backup?]
---

Para cada funcao, avalie:

1. **Nivel de Risco Real** (ALTO/MEDIO/BAIXO)
   - ALTO: Empresa para ou perde receita significativa
   - MEDIO: Atrasos, retrabalho, clientes insatisfeitos
   - BAIXO: Inconveniente, mas contornavel

2. **Custo estimado do risco** (R$/mes se a pessoa sair)
   - Considere: receita perdida, custo de reposicao, tempo de treinamento

3. **Prioridade de mitigacao** (1-5)
   - 1 = Urgente (resolver esta semana)
   - 5 = Pode esperar

Entregue:
- Lista ordenada por prioridade
- TOP 3 riscos criticos com plano de acao imediata
- Estimativa de custo total de exposicao (soma dos riscos)
```

### Prompt 1.2: Plano de Mitigacao de Risco

```
Voce e um especialista em continuidade de negocios.

Para o seguinte risco identificado:

---
Funcao: [NOME DA FUNCAO]
Pessoa: [NOME]
Impacto se sair: [DESCRICAO]
Custo estimado: R$ [VALOR]/mes
Conhecimento documentado: [SIM/NAO/PARCIAL]
Backup existe: [SIM/NAO]
---

Crie um plano de mitigacao em 4 etapas:

1. **Documentacao (48h)**
   - O que documentar primeiro?
   - Formato recomendado (SOP, video, checklist)?

2. **Backup humano (7 dias)**
   - Quem pode ser treinado?
   - Qual o treinamento minimo?

3. **Automacao (30 dias)**
   - Quais tarefas podem ser automatizadas?
   - Ferramentas sugeridas?

4. **Validacao (continuo)**
   - Como testar se o plano funciona?
   - Frequencia de revisao?

Seja especifico e pratico.
```

---

## Modulo 2: Matriz Funcao x Decisao

### Prompt 2.1: Classificacao de Decisoes

```
Voce e um especialista em automacao de processos.

Analise as seguintes decisoes do negocio:

---
[COLAR LISTA DE DECISOES - incluir: Decisao, Quem decide, Frequencia, Impacto]
---

Para cada decisao, classifique:

1. **Tipo de Decisao**
   - ESTRATEGICA: Muda direcao do negocio (NAO automatizar)
   - TATICA: Escolhe entre opcoes conhecidas (automacao PARCIAL)
   - OPERACIONAL: Segue regras pre-definidas (automacao TOTAL)

2. **Potencial de Automacao** (0-100%)
   - 0%: Requer julgamento humano unico
   - 50%: IA sugere, humano aprova
   - 100%: IA decide sozinha

3. **Regra Se/Entao**
   - Escreva a regra logica da decisao
   - Se nao conseguir escrever, marque como NAO automatizavel

Entregue:
- Matriz classificada
- TOP 5 decisoes para automacao imediata
- Economia estimada de tempo/mes
```

### Prompt 2.2: Criacao de Regra de Automacao

```
Voce e um arquiteto de automacao.

Para a seguinte decisao:

---
Decisao: [NOME DA DECISAO]
Frequencia: [X] vezes por [DIA/SEMANA/MES]
Quem decide hoje: [PESSOA/CARGO]
Tempo por decisao: [X] minutos
---

Crie a regra de automacao:

1. **Gatilho**
   - O que dispara esta decisao?
   - Quais dados sao necessarios?

2. **Condicoes**
   - SE [CONDICAO 1] E [CONDICAO 2]
   - ENTAO [ACAO]
   - SENAO [ACAO ALTERNATIVA]

3. **Excecoes**
   - Quando NAO aplicar a regra?
   - Quando escalar para humano?

4. **Validacao**
   - Como saber se a decisao esta correta?
   - Metricas de qualidade?

5. **Implementacao sugerida**
   - Ferramenta: ChatGPT / n8n / Zapier / Outro
   - Complexidade: Baixa / Media / Alta
   - Tempo estimado de setup: [X] horas

Seja pratico e especifico.
```

---

## Modulo 3: SOP Inteligente

### Prompt 3.1: Validacao de Entrega (Universal)

```
Voce e um validador de qualidade. Revise o seguinte [TIPO DE ENTREGA]:

---
[COLAR AQUI O RESULTADO DO PROCESSO]
---

Verifique os seguintes criterios:

1. [CRITERIO 1 - copiar da secao de criterios do SOP]
2. [CRITERIO 2]
3. [CRITERIO 3]
4. [CRITERIO 4]
5. [CRITERIO 5]

Para cada criterio, responda:
- OK: Se atende completamente
- PARCIAL: Se atende mas pode melhorar
- FALHA: Se nao atende

Ao final:
- Se TODOS forem OK: Responda "APROVADO - Pode entregar"
- Se algum for PARCIAL: Liste sugestoes de melhoria
- Se algum for FALHA: Liste o que precisa ser refeito ANTES de entregar

Seja objetivo e especifico.
```

### Prompt 3.2: Execucao de Tarefa (Universal)

```
Voce e um assistente especializado em [AREA].

Preciso que voce execute o seguinte:
[DESCREVER A TAREFA ESPECIFICA]

Contexto:
[INFORMACOES RELEVANTES]

Restricoes:
- [O QUE NAO PODE FAZER]
- [LIMITES]

Formato de entrega:
[COMO QUER O OUTPUT]

Exemplo de resultado esperado:
[MOSTRAR EXEMPLO]
```

### Prompt 3.3: Criacao de SOP a partir de Descricao

```
Voce e um especialista em documentacao de processos.

Preciso criar um SOP para o seguinte processo:

---
Nome do processo: [NOME]
Objetivo: [O QUE ENTREGA, PARA QUEM, EM QUANTO TEMPO]
Executado por: [CARGO/FUNCAO]
Frequencia: [DIARIA/SEMANAL/MENSAL]
---

Crie o SOP completo com:

1. **Objetivo** (1-2 frases)

2. **Quando usar / Quando NAO usar**

3. **Pre-requisitos** (o que precisa ter antes)

4. **Passo a passo** (max 10 passos)
   - Cada passo com: Acao | Responsavel | Tempo | Output

5. **Criterios de qualidade** (3-5 criterios mensuraveis)

6. **Erros comuns** (3 erros + como evitar)

7. **Prompt de validacao** (para IA validar o resultado)

Seja pratico. O SOP deve ser executavel por alguem que nunca fez o processo.
```

---

## Modulo 4: Delegacao Assistida

### Prompt 4.1: Assistente de Execucao (Para Delegado)

```
Voce e um assistente de execucao para [NOME DO DELEGADO].

Tarefa atual: [NOME DA TAREFA]

Sua funcao:
1. Guiar passo a passo pela execucao
2. Validar cada etapa antes de avancar
3. Alertar se algo estiver fora do padrao
4. Sugerir correcoes quando necessario

Etapas da tarefa:
1. [ETAPA 1]
2. [ETAPA 2]
3. [ETAPA 3]
4. [ETAPA 4]
5. [ETAPA 5]

Criterios de qualidade:
- [CRITERIO 1]
- [CRITERIO 2]
- [CRITERIO 3]

Regras:
- Se o delegado pular uma etapa, avise
- Se o resultado nao atender criterios, sugira correcao
- Se houver duvida critica, oriente a consultar [NOME DO DELEGANTE]

Formato de resposta:
✅ Etapa X: [OK / Precisa ajuste]
💡 Sugestao: [Se aplicavel]
➡️ Proxima etapa: [Instrucao]
```

### Prompt 4.2: Validacao de Tarefa Delegada

```
Voce e um validador de qualidade para a tarefa: [NOME DA TAREFA]

Revise o seguinte resultado:

---
[COLAR RESULTADO AQUI]
---

Verifique os criterios:
1. [CRITERIO 1]
2. [CRITERIO 2]
3. [CRITERIO 3]

Para cada criterio:
✅ OK - Atende completamente
⚠️ PARCIAL - Atende com ressalvas
❌ FALHA - Nao atende

Veredicto final:
- Se todos ✅: "APROVADO - Pode entregar"
- Se algum ⚠️: "APROVADO COM RESSALVAS - Melhorias sugeridas: [lista]"
- Se algum ❌: "REPROVADO - Refazer: [lista do que corrigir]"
```

### Prompt 4.3: Analise de Delegabilidade

```
Voce e um consultor de produtividade.

Analise a seguinte tarefa para delegacao:

---
Tarefa: [NOME DA TAREFA]
Quem faz hoje: [PESSOA/CARGO]
Tempo gasto: [X] horas/semana
Complexidade percebida: [BAIXA/MEDIA/ALTA]
---

Avalie:

1. **Decomposicao**
   - Quebre em etapas menores
   - Identifique quais etapas sao delegaveis

2. **Nivel de autonomia recomendado** (1-5)
   - 1: Esperar comando
   - 2: Fazer e reportar
   - 3: Fazer e avisar se problema
   - 4: Fazer e validar com IA
   - 5: Autonomia total

3. **Checkpoints necessarios**
   - Onde colocar validacoes?
   - Quem valida (IA ou humano)?

4. **Riscos da delegacao**
   - O que pode dar errado?
   - Como mitigar?

5. **Plano de transicao**
   - Dia 1-2: O que fazer
   - Dia 3-5: O que fazer
   - Semana 2: O que esperar

Seja pratico e especifico.
```

---

## Modulo 5: ROI de Pessoas

### Prompt 5.1: Analise de ROI Organizacional

```
Voce e um analista de eficiencia organizacional.

Analise os seguintes dados de funcoes:

---
[COLAR MATRIZ DE ROI - incluir: Funcao, Custo Total, Valor Gerado, ROI]
---

Para cada funcao, avalie:

1. **O ROI esta adequado para o tipo de funcao?**
   - Funcoes de receita direta: ROI > 200% esperado
   - Funcoes de suporte: ROI > 50% esperado
   - Funcoes de compliance: ROI pode ser 0% (custo evitado)

2. **O valor gerado foi calculado corretamente?**
   - Receita direta: facil de medir
   - Receita influenciada: estimativa conservadora?
   - Custo evitado: esta sendo contabilizado?

3. **Quais funcoes tem maior potencial de automacao?**
   - % repetitivo > 70%
   - Regras claras documentadas
   - Ferramentas disponiveis no mercado

Entregue:
- Ranking de funcoes por ROI
- TOP 3 candidatas a automacao
- TOP 3 candidatas a expansao
- Recomendacao de reestruturacao
```

### Prompt 5.2: Calculo de Custo Total de Funcao

```
Voce e um analista financeiro de RH.

Calcule o custo total da seguinte funcao:

---
Funcao: [NOME]
Tipo de contrato: [CLT/PJ/FREELANCER]
Salario/valor bruto: R$ [VALOR]/mes
Carga horaria: [X] horas/semana
---

Inclua no calculo:

1. **Salario/Valor base**

2. **Encargos** (se CLT)
   - INSS patronal: ~20%
   - FGTS: 8%
   - Ferias + 1/3: ~11%
   - 13o salario: ~8%
   - Outros: ~3%
   - TOTAL ENCARGOS: ~50-80% do salario

3. **Beneficios**
   - Vale refeicao: R$ [estimativa]
   - Vale transporte: R$ [estimativa]
   - Plano de saude: R$ [estimativa]

4. **Custos indiretos**
   - Ferramentas/software: R$ [estimativa]
   - Equipamento (amortizado): R$ [estimativa]
   - Espaco (% do aluguel): R$ [estimativa]
   - Tempo de gestao: R$ [estimativa]

Entregue:
- Custo total mensal
- Custo por hora trabalhada
- Comparacao com mercado (se possivel)
```

### Prompt 5.3: Analise de Automacao de Funcao

```
Voce e um especialista em automacao e IA.

Analise o potencial de automacao da seguinte funcao:

---
Funcao: [NOME]
Atividades principais:
1. [ATIVIDADE 1] - [X]% do tempo
2. [ATIVIDADE 2] - [X]% do tempo
3. [ATIVIDADE 3] - [X]% do tempo

Custo atual: R$ [VALOR]/mes
---

Para cada atividade, avalie:

1. **Potencial de automacao** (0-100%)
   - 0%: Requer julgamento humano complexo
   - 50%: IA auxilia, humano decide
   - 100%: IA executa sozinha

2. **Ferramenta sugerida**
   - ChatGPT/Claude: Para analise, redacao, classificacao
   - n8n/Zapier: Para fluxos automatizados
   - Scripts customizados: Para integracao especifica

3. **Custo da automacao**
   - Setup inicial: R$ [estimativa]
   - Custo mensal: R$ [estimativa]

4. **ROI da automacao**
   - Economia mensal: R$ [calculo]
   - Payback: [X] meses

Entregue:
- Percentual total automatizavel da funcao
- Plano de automacao priorizado
- Economia projetada em 12 meses
- Recomendacao: Automatizar / Nao automatizar / Automatizar parcialmente
```

### Prompt 5.4: Plano de Reestruturacao

```
Voce e um consultor de reestruturacao organizacional.

Com base na analise de ROI:

---
[COLAR RESUMO DA ANALISE - funcoes, ROIs, recomendacoes]
---

Crie um plano de reestruturacao que:

1. **Preserve as pessoas** (quando possivel)
   - Realocacao antes de demissao
   - Treinamento para novas funcoes

2. **Maximize o ROI da equipe**
   - Eliminar atividades de baixo valor
   - Expandir atividades de alto valor

3. **Implemente gradualmente**
   - Fase 1 (30 dias): Quick wins
   - Fase 2 (60 dias): Automacoes principais
   - Fase 3 (90 dias): Reestruturacao completa

4. **Minimize riscos**
   - Backup de conhecimento antes de mudancas
   - Periodo de transicao

Entregue:
- Organograma atual vs proposto
- Economia projetada mensal
- Timeline de implementacao
- Riscos e mitigacoes
```

---

## Prompts Bonus: Uso Geral

### Prompt Bonus 1: Diagnostico Rapido da Equipe

```
Voce e um consultor organizacional.

Faca um diagnostico rapido da seguinte equipe:

---
Empresa: [NOME]
Faturamento: R$ [VALOR]/mes
Numero de funcionarios: [X]
Folha de pagamento: R$ [VALOR]/mes

Funcoes:
[LISTAR FUNCOES E PESSOAS]
---

Analise:

1. **Saude geral**
   - % folha / faturamento (ideal: 20-35%)
   - Funcoes essenciais vs funcoes de suporte

2. **Riscos imediatos**
   - Dependencias perigosas
   - Funcoes sem backup

3. **Oportunidades rapidas**
   - Automacoes obvias
   - Reestruturacoes simples

4. **Proximos passos**
   - 3 acoes para esta semana
   - 3 acoes para este mes

Seja direto e pratico.
```

### Prompt Bonus 2: Sessao de Mapeamento Guiado

```
Voce e um facilitador de mapeamento organizacional.

Vou te passar informacoes sobre minha empresa aos poucos.
Seu papel e:
1. Fazer perguntas claras e especificas
2. Organizar as informacoes em formato estruturado
3. Identificar gaps e pedir mais detalhes

Comece perguntando:
1. Nome da empresa e o que ela faz
2. Faturamento mensal aproximado
3. Numero de pessoas na equipe

Depois, para cada pessoa, pergunte:
- Nome e funcao
- O que ela faz no dia a dia
- O que acontece se ela sair amanha
- Se o conhecimento dela esta documentado

Ao final, entregue:
- Mapa de Dependencia Humana preenchido
- TOP 3 riscos identificados
- Proximos passos recomendados
```

---

## Como Usar Esta Compilacao

1. **Escolha o prompt** adequado para sua necessidade
2. **Substitua os placeholders** [ENTRE COLCHETES] por seus dados reais
3. **Cole no ChatGPT/Claude** e execute
4. **Revise o resultado** e ajuste se necessario
5. **Documente a saida** no template correspondente

---

**Compilacao versao:** 1.0
**Trilha:** Pessoas & Processos
**Total de prompts:** 14 + 2 bonus
