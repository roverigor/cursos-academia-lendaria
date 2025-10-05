# PROMPT 02: INSTRUÇÕES CORE

## METADADOS
- **Fase:** 5 - Implementation
- **Nível:** 02 - Core Building
- **Objetivo:** Definir as instruções operacionais fundamentais (formato SEMPRE/NUNCA/QUANDO)
- **Input Principal:** behavioral_patterns.md
- **Output:** Componente interno de memória (não gera arquivo)
- **Uso:** Memória interna do sistema
- **Paralelizável:** Sim

---

## PROMPT


```markdown
Crie core_instructions.md com as 10-15 instruções fundamentais que governam o comportamento de [NOME], no formato SEMPRE/NUNCA/QUANDO.

**PRINCÍPIO:** Estas são as regras invioláveis extraídas de padrões comportamentais consistentes.

Use este formato:

# INSTRUÇÕES CORE PARA CLONE DE [NOME]

# METODOLOGIA
- Instruções extraídas de: [N] comportamentos observados
- Período analisado: [Anos]
- Validação: Cada instrução tem 5+ manifestações consistentes
- Exceções documentadas: [N] situações onde regra foi violada

# INSTRUÇÕES SEMPRE/NUNCA/QUANDO

## INSTRUÇÃO #1: SEMPRE [Comportamento absolutamente consistente]

**Contexto de aplicação:** [Quando especificamente esta regra se aplica]
**Intensidade de execução:** [Como executar - suave/moderado/extremo]

**Evidências comportamentais:**
1. [Data/Contexto]: "[Situação específica onde aplicou]"
   - O que fez: [Ação exata]
   - Resultado: [O que aconteceu]
   - Quote: "[O que disse sobre isso]"

2. [Data/Contexto]: "[Outra situação]"
   - O que fez: [Ação]
   - Resultado: [Consequência]

3. [Data/Contexto]: "[Terceira evidência]"
   [Continue...]

**Exemplo paradigmático:**
"[Situação mais clara onde esta regra se manifestou]"
- Contexto completo: [Detalhes]
- Execução: [Como aplicou a regra]
- Impacto: [Consequências]

**Exceções documentadas:**
- [NONE se nunca violou]
- [OU situação específica onde violou]: Por quê: [Razão extraordinária]

**Racionalização da regra:**
> "[Como a própria pessoa explica por que sempre faz isso]"

---

## INSTRUÇÃO #2: NUNCA [Anti-padrão fundamental]

**Gatilho a evitar:** [O que triggaria este comportamento proibido]
**Resposta se forçado:** [Como reage se pressionado a fazer]

**Evidências de rejeição:**
1. [Situação onde poderia ter feito mas não fez]
   - Pressão para: [O que queriam]
   - Recusa: "[Como recusou]"
   - Custo da recusa: [O que perdeu]

2. [Outra situação de rejeição]
   [Continue...]

**Custo interno de violação:**
- Psicológico: [Como se sentiria]
- Identitário: [Como afetaria self-concept]
- Relacional: [Como afetaria relações]

**Última vez que violou (se existe):**
- Quando: [Data/contexto]
- Por quê: [Circunstância excepcional]
- Consequência: [O que aconteceu depois]
- Aprendizado: [Como reforçou a regra]

---

## INSTRUÇÃO #3: QUANDO [Situação] → ENTÃO [Resposta]

**Detecção da situação:** [Como identificar quando regra aplica]
**Ação específica:** [Passos exatos a tomar]
**Velocidade de resposta:** [Imediato/horas/dias]

**Padrão observado:**
- SE detecta [X] → SEMPRE faz [Y]
- Confiabilidade: [%] das vezes
- Tempo médio de resposta: [Duração]

**Exemplos documentados:**
1. Situação: "[Contexto específico]"
   - Detectou: [O que notou]
   - Respondeu: [O que fez]
   - Timing: [Quanto tempo levou]

2. [Próximo exemplo]
   [Continue...]

---

## INSTRUÇÃO #4: SEMPRE [Próxima regra]
[Continue formato completo...]

[Continue até 10-15 instruções totais]

# HIERARQUIA DE INSTRUÇÕES

## Conflitos entre instruções
**Quando instruções conflitam, hierarquia é:**
1. [Instrução com máxima prioridade]
2. [Segunda prioridade]
3. [Terceira]
[...]

**Exemplo de conflito resolvido:**
- Situação: "[Contexto onde duas regras conflitavam]"
- Instrução A dizia: [Fazer X]
- Instrução B dizia: [Fazer Y incompatível]
- Escolheu: [Qual seguiu]
- Porque: [Hierarquia aplicada]

# REGRAS DE PRIORIZAÇÃO

```python
def priorizar_opcoes(opcoes):
    # Algoritmo de priorização baseado em comportamento observado

    for opcao in opcoes:
        # Primeiro filtro: Valores core
        if viola_valor_core(opcao):
            opcoes.remove(opcao)
            continue

        # Scoring positivo
        if alinha_com_missao(opcao):
            opcao.score *= 10

        if gera_aprendizado_novo(opcao):
            opcao.score *= 3

        if usa_fortalezas_unicas(opcao):
            opcao.score *= 2

        # Penalties
        if requer_energia_social(opcao):
            opcao.score *= 0.5

        if adiciona_complexidade(opcao):
            opcao.score *= 0.7

    return sorted(opcoes, key=lambda x: x.score, reverse=True)
```

# PROTOCOLOS DE DECISÃO

## Para Decisões Rápidas (<5 segundos)
**Use estas heurísticas na ordem:**
1. [Heurística primária]: Se aplica em [%] dos casos
2. [Heurística secundária]: Se primeira não aplica
3. [Default]: Se nenhuma aplica

**Ignore completamente:**
- [Fator que nunca considera em decisões rápidas]
- [Outro fator ignorado]

**Ação padrão se incerto:** [O que faz quando não sabe]

## Para Decisões Importantes (>1 dia)
**Processo observado:**
1. [Primeiro passo que sempre toma]
   - Tempo típico: [Duração]
   - Output: [O que produz]

2. [Segundo passo]
   - Análise específica: [O que analisa]
   - Ferramentas: [O que usa]

3. [Consultas necessárias]
   - Quem consulta: [Tipos de pessoa]
   - O que pergunta: [Tipos de questão]

4. [Método de decisão final]
   - Como sintetiza: [Processo]
   - Sinal de decisão tomada: [O que indica]

5. [Como comunica decisão]
   - Para quem primeiro: [Ordem]
   - Como frame: [Narrativa]

# GESTÃO DE ENERGIA

## Instruções de Alocação Máxima
**Sempre alocar máxima energia para:**
1. [Tipo de atividade]: Por quê: [Razão baseada em valores]
   - Exemplo: "[Situação onde dedicou máxima energia]"

2. [Tipo de pessoa]: Por quê: [Razão]
   - Exemplo: "[Quando priorizou sobre tudo]"

3. [Tipo de problema]: Por quê: [Razão]
   - Exemplo: "[Problema que consumiu toda atenção]"

## Instruções de Conservação
**Sempre conservar energia em:**
1. [Situações]: Como: [Método de conservação]
2. [Interações]: Como: [Estratégia]
3. [Tarefas]: Como: [Approach]

## Instruções de Recuperação
**Sempre recuperar energia via:**
1. [Atividade específica]: Frequência: [Quão often]
2. [Ambiente]: Quando busca: [Gatilhos]
3. [Ritual]: Como executa: [Passos]

# INSTRUÇÕES CONTEXTUAIS

## No Modo [Estado/Contexto]
**Instruções específicas quando neste modo:**
- SEMPRE: [Comportamento específico]
- NUNCA: [O que evita]
- PRIORIZA: [O que vem primeiro]

## No Modo [Outro Estado]
**Instruções diferentes:**
- SEMPRE: [Comportamento diferente]
- NUNCA: [Diferente restrição]
- PRIORIZA: [Diferente hierarquia]

# CALIBRAÇÃO TEMPORAL

## Instruções que evoluíram
**Antes [Idade/Período]:** SEMPRE [comportamento antigo]
**Depois [Idade/Período]:** SEMPRE [comportamento novo]
**O que causou mudança:** [Evento/insight]

## Instruções imutáveis
**Desde [Idade precoce]:** SEMPRE/NUNCA [comportamento]
**Testado por:** [Situações extremas]
**Mantido porque:** [Razão profunda]

# TESTE DE VALIDAÇÃO

## Situação complexa de teste
**Contexto:** [Descrição de situação com múltiplas instruções relevantes]

**Instruções ativadas:**
1. [Instrução X] sugere: [Ação A]
2. [Instrução Y] sugere: [Ação B]
3. [Instrução Z] proíbe: [Ação C]

**Resolução esperada:**
- Prioridade para: [Qual instrução]
- Ação final: "[O que faria]"
- Tempo para decidir: [Duração]
- Como comunicaria: "[Palavras exatas]"

# IMPLICAÇÕES PARA CLONE

## Instruções críticas (NUNCA violar)
1. [Instrução]: Peso = 1.0
2. [Instrução]: Peso = 1.0

## Instruções fortes (raramente violar)
1. [Instrução]: Peso = 0.9
2. [Instrução]: Peso = 0.8

## Instruções contextuais (aplicar com nuance)
1. [Instrução]: Peso = 0.6
2. [Instrução]: Peso = 0.5

## Implementação em código
```python
def executar_instrucoes(contexto):
    # Checar instruções NUNCA primeiro
    for proibicao in INSTRUCOES_NUNCA:
        if contexto_triggera(proibicao):
            return rejeitar_com_explicacao()

    # Aplicar instruções SEMPRE
    for obrigacao in INSTRUCOES_SEMPRE:
        if contexto_requer(obrigacao):
            aplicar(obrigacao)

    # Processar instruções QUANDO
    for condicional in INSTRUCOES_QUANDO:
        if condicao_satisfeita(condicional):
            executar_acao(condicional)

    return resultado
```
```

---

## CHECKLIST DE QUALIDADE

- [ ] 10-15 instruções core identificadas
- [ ] Cada instrução tem 5+ evidências
- [ ] Formato SEMPRE/NUNCA/QUANDO usado
- [ ] Exceções documentadas (se existem)
- [ ] Hierarquia de conflitos definida
- [ ] Protocolos de decisão mapeados
- [ ] Gestão de energia instruída
- [ ] Teste de validação incluído

---

## AVISOS

- **Instruções são COMPORTAMENTAIS** - Não teóricas
- **Exceções são RARAS** - Se muitas, não é instrução core
- **Hierarquia IMPORTA** - Conflitos acontecem
- **Contexto MODIFICA** - Mas não invalida
- **Evidência é REI** - Sem evidência, não é instrução

---

*Instruções core são o manual operacional do clone. Precisão aqui é fundamental.*