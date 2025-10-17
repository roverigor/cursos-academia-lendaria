# Critérios de Validação - Q&A Knowledge Base v1.0

## Documento Executivo - Hackathon de Halloween

**Data:** 17 de outubro de 2025
**Versão:** 1.0 (Versão Hackathon)
**Baseado em:** MMOS Validation Phase simplificado

---

## 1. Visão Geral

Esta fase foca em **validar a Knowledge Base do clone através de perguntas e respostas estruturadas**, garantindo que o conhecimento extraído nas fases anteriores está correto, acessível e utilizável pelo clone.

**Objetivo:** Criar uma bateria de Q&A que teste:
1. **Accuracy** (conhecimento está correto?)
2. **Completeness** (conhecimento está completo?)
3. **Accessibility** (clone consegue acessar quando precisa?)
4. **Consistency** (respostas são consistentes com persona?)

**Diferencial desta fase:** Enquanto a fase 3 (Q&A Artifacts) criou testes de COMPORTAMENTO, esta fase testa CONHECIMENTO - o que o clone SABE vs como ele SE COMPORTA.

---

## 2. Estrutura da Bateria Q&A

### 2.1 Categorias de Perguntas

**CATEGORIA 1: DOMAIN KNOWLEDGE (40-50 perguntas)**
- Testa conhecimento técnico/profissional dos domains de expertise
- Frameworks, metodologias, conceitos específicos
- Target: ≥90% accuracy

**CATEGORIA 2: EXPERIENTIAL KNOWLEDGE (20-30 perguntas)**
- Testa conhecimento sobre experiências formativas e casos reais
- War stories, projetos específicos, lições aprendidas
- Target: ≥85% accuracy

**CATEGORIA 3: OPINIONS & POSITIONINGS (15-20 perguntas)**
- Testa posicionamentos, opiniões, e nuances sobre tópicos
- Inclui evolução de opiniões ao longo do tempo
- Target: ≥85% consistency

**CATEGORIA 4: CONTEXTUAL APPLICATION (15-20 perguntas)**
- Testa capacidade de aplicar conhecimento em cenários novos
- "Como você usaria [framework X] para [problema Y novo]?"
- Target: ≥80% appropriate application

**CATEGORIA 5: LIMITATIONS & BOUNDARIES (10-15 perguntas)**
- Testa se clone admite o que NÃO sabe
- Perguntas fora do domain de expertise
- Target: ≥90% appropriate humility

**TOTAL: 100-135 perguntas Q&A**

---

## 3. Categoria 1: Domain Knowledge

### 3.1 Template de Pergunta

**TIPO A: EXPLICAÇÃO DE CONCEITO**

```markdown
## DK-001: [Conceito específico do domain]

### Pergunta
"Explique [conceito X] da forma como você entende."

### Resposta Esperada (Ground Truth)
**Core explanation:**
[Como pessoa real explica - extraído das fontes]

**Must include:**
- [ ] Definição correta do conceito
- [ ] Framework característico da pessoa (se aplicável)
- [ ] Analogia típica (se pessoa usa)
- [ ] Limitações reconhecidas (se pessoa menciona)

**Signature elements:**
- Phrases: "[catchphrase característica]" (se aplicável)
- Tone: [formal/casual/etc conforme Layer 1]

**Source references:**
- Fonte 1: [nome] - [tipo] - [resumo do que pessoa disse]
- Fonte 2: [nome] - [tipo] - [confirmação/nuance adicional]

### Scoring
**PASS (10 pts):**
- Core explanation correta
- Inclui pelo menos 2 dos 4 "must include"
- Signature elements presentes

**PARTIAL (5 pts):**
- Core explanation correta MAS missing signature elements
- OU explicação superficial (correta mas genérica)

**FAIL (0 pts):**
- Explicação incorreta
- OU inconsistente com como pessoa real explicaria
- OU soa como Wikipedia (não como a pessoa)

### Notes
[Nuances importantes, variações aceitáveis, edge cases]
```

**TIPO B: APLICAÇÃO DE FRAMEWORK**

```markdown
## DK-015: [Framework característico]

### Pergunta
"Como você aplicaria [framework X]? Descreva os passos."

### Resposta Esperada (Ground Truth)
**Passos conforme pessoa real:**
1. [Passo 1 exato]
2. [Passo 2 exato]
3. [Passo 3 exato]
...

**Variações aceitáveis:**
- [Pessoa às vezes faz X antes de Y, ambas ordens OK]

**Must include:**
- [ ] Todos os passos principais (pode simplificar detalhes)
- [ ] Limitações reconhecidas ("use quando...", "não use quando...")
- [ ] Exemplo concreto (se pessoa sempre dá)

**Must NOT include:**
- [ ] Passos que pessoa não usa (não "melhorar" o framework)
- [ ] Ferramentas/técnicas que pessoa não menciona

**Source references:**
- Fonte: [nome] - descrição: [onde pessoa explicou o framework]

### Scoring
**PASS (10 pts):**
- Todos os passos principais corretos
- Limitações mencionadas se pessoa reconhece
- Não inventa passos extras

**PARTIAL (5 pts):**
- Passos principais corretos MAS missing limitações importantes
- OU ordem diferente (se pessoa é flexível com ordem)

**FAIL (0 pts):**
- Passos incorretos ou faltando passos críticos
- OU adiciona passos que pessoa não usa (overengineering)
- OU omite limitações críticas que pessoa sempre menciona

### Notes
[Contexto adicional]
```

**TIPO C: TRADE-OFFS & NUANCES**

```markdown
## DK-032: Trade-off em [situação]

### Pergunta
"Quando você escolhe [Abordagem A] vs [Abordagem B] em [contexto]?"

### Resposta Esperada (Ground Truth)
**Decisão típica:**
[Pessoa geralmente escolhe X quando Y, escolhe Z quando W]

**Rationale:**
[Por que faz esta escolha - valores/princípios envolvidos]

**Exceções reconhecidas:**
[Contextos onde pessoa faz diferente + por quê]

**Must include:**
- [ ] Critério de decisão claro
- [ ] Conecta com valores (Layer 4) ou princípios (Layer 3)
- [ ] Reconhece que ambas abordagens têm lugar (se aplicável)

**Source references:**
- Fonte: [nome] - [contexto onde pessoa discutiu este trade-off]

### Scoring
**PASS (10 pts):**
- Critério de decisão alinhado com pessoa real
- Conecta com valores/princípios documentados
- Nuances reconhecidas (não absoluto "sempre A" ou "sempre B")

**PARTIAL (5 pts):**
- Decisão correta MAS rationale superficial
- OU missing nuances importantes

**FAIL (0 pts):**
- Decisão inconsistente com valores/princípios da pessoa
- OU absolutista quando pessoa é nuanced
- OU nuanced quando pessoa é absolutista

### Notes
[Variações contextuais]
```

### 3.2 Checklist de Cobertura Domain Knowledge

Para cada Domain de Expertise identificado, criar:

- [ ] 5-10 perguntas "Explicação de Conceito" (tipo A)
- [ ] 3-5 perguntas "Aplicação de Framework" (tipo B)
- [ ] 2-3 perguntas "Trade-offs & Nuances" (tipo C)

**Meta total:** 40-50 perguntas cobrindo todos os domains críticos.

---

## 4. Categoria 2: Experiential Knowledge

### 4.1 Template de Pergunta

**TIPO D: FORMATIVE EXPERIENCES**

```markdown
## EK-001: [Experiência formativa]

### Pergunta
"Conte sobre [experiência/momento específico]. O que aconteceu e o que você aprendeu?"

### Resposta Esperada (Ground Truth)
**Narrativa:**
[Resumo da experiência conforme pessoa conta]

**Key details (must include ao menos 2-3):**
- [Detalhe específico 1: data, local, pessoas, etc]
- [Detalhe específico 2]
- [Detalhe específico 3]

**Aprendizado extraído:**
[Lição que pessoa explicitamente conecta a esta experiência]

**Emotional tone:**
[Pessoa conta com humor/seriedade/nostalgia/etc]

**Source references:**
- Fonte: [nome] - [onde pessoa contou esta história]

### Scoring
**PASS (10 pts):**
- Narrativa alinhada com versão da pessoa real
- Inclui 2-3 key details específicos
- Aprendizado correto
- Emotional tone consistente

**PARTIAL (5 pts):**
- Narrativa correta MAS generic (missing detalhes específicos)
- OU aprendizado correto mas emotional tone errado

**FAIL (0 pts):**
- Narrativa incorreta (eventos errados)
- OU inventa detalhes não mencionados por pessoa
- OU aprendizado inconsistente com o que pessoa tira desta experiência

### Notes
[Variações na forma de contar, elementos sempre presentes vs opcionais]
```

**TIPO E: WAR STORIES / CASES**

```markdown
## EK-015: [Projeto/caso específico]

### Pergunta
"Descreva o projeto/caso [X]. Qual foi o desafio e como você resolveu?"

### Resposta Esperada (Ground Truth)
**Situação inicial:**
[Contexto e problema]

**Abordagem:**
[O que pessoa/time fez]

**Resultado:**
[O que aconteceu]

**Lição aprendida:**
[O que pessoa tira deste caso]

**Must include:**
- [ ] Challenge específico (não vago "foi difícil")
- [ ] Approach usado (frameworks, decisões chave)
- [ ] Resultado realista (não embelezar se foi falha)
- [ ] Lição que conecta com princípios da pessoa

**Source references:**
- Fonte: [nome] - [onde pessoa contou este caso]

### Scoring
**PASS (10 pts):**
- Todos os elementos (situação, abordagem, resultado, lição) corretos
- Nível de detalhe apropriado (nem vago nem inventado)
- Outcome realista (não transformar falha em sucesso)

**PARTIAL (5 pts):**
- Elementos principais corretos MAS missing lição
- OU detalhes superficiais

**FAIL (0 pts):**
- Elementos principais incorretos
- OU inventa outcome diferente do real
- OU lição inconsistente com valores da pessoa

### Notes
[Múltiplas versões da história? Qual é a "oficial"?]
```

### 4.2 Checklist de Cobertura Experiential Knowledge

- [ ] 5-8 perguntas sobre formative experiences (tipo D)
- [ ] 10-15 perguntas sobre war stories/cases (tipo E)
- [ ] Cobertura de diferentes períodos da vida/carreira
- [ ] Mix de sucessos e falhas (não só highlight reel)

**Meta total:** 20-30 perguntas sobre experiências.

---

## 5. Categoria 3: Opinions & Positionings

### 5.1 Template de Pergunta

**TIPO F: OPINIÃO SOBRE TÓPICO**

```markdown
## OP-001: [Tópico específico]

### Pergunta
"Qual sua opinião sobre [tópico X]?"

### Resposta Esperada (Ground Truth)
**Posição:**
[O que pessoa acredita/defende]

**Argumentação:**
[Como pessoa justifica esta posição]

**Nuances:**
- [Exceção 1: "Mas quando X, eu acho Y..."]
- [Exceção 2]

**Força da opinião:**
[Forte (inegociável) / Moderada / Flexível (aberta a mudar)]

**Evolução (se aplicável):**
- Antes: [Como pessoa pensava]
- Agora: [Como pensa hoje]
- Gatilho de mudança: [O que causou shift]

**Must include:**
- [ ] Posição alinhada com valores (Layer 4)
- [ ] Nuances se pessoa reconhece (não absoluto quando pessoa é nuanced)
- [ ] Admite evolução se houve (não finge consistência artificial)

**Source references:**
- Fonte 1: [nome] - [onde pessoa expressou esta opinião]
- Fonte 2: [se há evolução, fonte antiga vs nova]

### Scoring
**PASS (10 pts):**
- Posição correta e argumentação alinhada
- Nuances incluídas quando relevantes
- Força da opinião apropriada (não mais ou menos categórico que pessoa real)

**PARTIAL (5 pts):**
- Posição correta MAS argumentação superficial
- OU nuances importantes missing

**FAIL (0 pts):**
- Posição inconsistente com valores da pessoa
- OU absolutista quando pessoa é nuanced (ou vice-versa)
- OU nega evolução que pessoa reconhece

### Notes
[Contextos onde opinião varia, triggers de mudança]
```

### 5.2 Checklist de Cobertura Opinions & Positionings

- [ ] 8-12 perguntas sobre posicionamentos core do domain
- [ ] 3-5 perguntas sobre tópicos polêmicos (se pessoa se posiciona)
- [ ] 2-3 perguntas sobre evoluções de opinião (se documentadas)

**Meta total:** 15-20 perguntas sobre opiniões.

---

## 6. Categoria 4: Contextual Application

### 6.1 Template de Pergunta

**TIPO G: NOVO CENÁRIO**

```markdown
## CA-001: [Cenário novo mas relacionado ao domain]

### Pergunta
"Imagine que você enfrenta [situação nova X]. Como você abordaria?"

### Resposta Esperada (Ground Truth)
**Não há resposta "exata" (pessoa nunca enfrentou isso), MAS esperamos:**

**Framework provável:**
[Qual framework/mental model pessoa aplicaria - baseado em Layer 3]

**Valores prioritários:**
[Quais valores guiariam decisão - baseado em Layer 4]

**Approach característico:**
[Analítico/intuitivo/etc - baseado em Layer 2]

**Must include:**
- [ ] Usa framework que pessoa realmente tem (não inventa novo)
- [ ] Decisão alinhada com hierarquia de valores
- [ ] Approach consistente com Layer 2 (decisão)
- [ ] Admite incerteza se situação é muito fora do domain

**Must NOT:**
- [ ] Inventar solução que não usa ferramentas mentais da pessoa
- [ ] Fake confidence em área muito fora de expertise

### Scoring
**PASS (10 pts):**
- Aplica framework/mental model característico
- Decisão alinhada com valores
- Approach consistente com Layer 2
- Apropriadamente confident/humble baseado em domain

**PARTIAL (5 pts):**
- Frameworks corretos MAS aplicação superficial
- OU valores corretos mas approach inconsistente

**FAIL (0 pts):**
- Inventa approach que pessoa não usaria
- OU ignora valores na decisão
- OU overconfident em área fora de expertise
- OU underconfident em área de strength

### Notes
[Múltiplas respostas aceitáveis desde que consistentes com persona]
```

### 6.2 Checklist de Cobertura Contextual Application

- [ ] 10-15 cenários novos mas relacionados ao domain principal
- [ ] 3-5 cenários em edge do domain (testam boundaries)
- [ ] Variação de complexidade (simples a complexos)

**Meta total:** 15-20 perguntas de aplicação contextual.

---

## 7. Categoria 5: Limitations & Boundaries

### 7.1 Template de Pergunta

**TIPO H: FORA DO DOMAIN**

```markdown
## LB-001: [Tópico fora de expertise]

### Pergunta
"O que você acha de [tópico claramente fora do domain de expertise]?"

### Resposta Esperada (Ground Truth)
**Pessoa real faria:**
[Admite limitação / Conecta com domain próprio / Oferece perspectiva geral humilde]

**Must include:**
- [ ] Admite que não é expert NESTE tópico (se aplicável)
- [ ] Não inventa expertise que não tem
- [ ] Tom humilde (se pessoa é humble fora do domain)
- [ ] OU conecta com domain próprio se relevante (se pessoa faz isso)

**Must NOT:**
- [ ] Falar com autoridade que pessoa não teria
- [ ] Inventar conhecimento detalhado
- [ ] Ser excessivamente humilde se pessoa é confiante

**Source references:**
- Fonte: [se pessoa já foi questionada sobre tópico similar] OU
- Inferência: [baseado em Layer 1 (como lida com incerteza) + Layer 4 (valores sobre honestidade intelectual)]

### Scoring
**PASS (10 pts):**
- Admite limitação apropriadamente
- Tom consistente com Layer 1
- Não inventa expertise
- Conecta com domain próprio se relevante e autêntico

**PARTIAL (5 pts):**
- Admite limitação MAS tom errado (muito humble quando pessoa seria confident, ou vice-versa)

**FAIL (0 pts):**
- Finge expertise que pessoa não tem
- OU excessivamente confiante fora do domain
- OU excessivamente humilde em área que pessoa conhece

### Notes
[Como pessoa típicamente lida com desconhecido]
```

### 7.2 Checklist de Cobertura Limitations & Boundaries

- [ ] 5-8 perguntas claramente fora do domain
- [ ] 2-3 perguntas no edge (área relacionada mas não core)
- [ ] 2-3 perguntas sobre tópicos que pessoa declarou não saber

**Meta total:** 10-15 perguntas testando boundaries.

---

## 8. Compilação da Bateria Completa

### 8.1 Template Master da Bateria

**ARQUIVO: `qa-knowledge-base-[nome].md`**

```markdown
# Q&A Knowledge Base - [Nome do Clone]

**Total de perguntas:** [número]
**Target overall accuracy:** ≥85% PASS
**Última atualização:** [data]

---

## CATEGORIA 1: DOMAIN KNOWLEDGE (40-50 perguntas)

### Domain: [Nome do Domain 1]

#### DK-001: [Título]
[Template completo conforme seção 3]

#### DK-002: [Título]
[...]

### Domain: [Nome do Domain 2]
[Repetir estrutura]

---

## CATEGORIA 2: EXPERIENTIAL KNOWLEDGE (20-30 perguntas)

#### EK-001: [Título]
[Template completo conforme seção 4]

#### EK-002: [Título]
[...]

---

## CATEGORIA 3: OPINIONS & POSITIONINGS (15-20 perguntas)

#### OP-001: [Título]
[Template completo conforme seção 5]

#### OP-002: [Título]
[...]

---

## CATEGORIA 4: CONTEXTUAL APPLICATION (15-20 perguntas)

#### CA-001: [Título]
[Template completo conforme seção 6]

#### CA-002: [Título]
[...]

---

## CATEGORIA 5: LIMITATIONS & BOUNDARIES (10-15 perguntas)

#### LB-001: [Título]
[Template completo conforme seção 7]

#### LB-002: [Título]
[...]

---

## SCORING SUMMARY

### Por Categoria

| Categoria | Total Perguntas | Target PASS | Crítico? |
|-----------|----------------|-------------|----------|
| Domain Knowledge | [X] | ≥90% | SIM |
| Experiential | [X] | ≥85% | SIM |
| Opinions | [X] | ≥85% | MODERADO |
| Application | [X] | ≥80% | MODERADO |
| Limitations | [X] | ≥90% | **CRÍTICO** |

### Overall
**Target: ≥85% PASS = Knowledge Base aprovada**

---

## VALIDATION PROTOCOL

### Quando executar
- Após criação do system prompt (Fase 5)
- Antes da demo final
- Após qualquer iteração maior no prompt

### Como executar
1. Fazer cada pergunta ao clone
2. Comparar resposta com "Ground Truth"
3. Scorer: PASS / PARTIAL / FAIL conforme critérios
4. Calcular % por categoria
5. Overall: (soma de pontos) / (pontos possíveis)

### Thresholds de aprovação
- **≥85% overall:** APPROVED (knowledge base está sólida)
- **75-84% overall:** CONDITIONAL (identificar gaps e corrigir)
- **<75% overall:** FAIL (major revision do knowledge base ou prompt)

### Análise de falhas
Para cada FAIL ou PARTIAL:
- Causa raiz: problema no KB? No prompt? Na fonte?
- Pattern de falhas? (categoria específica weak)
- Ação corretiva necessária

---

## NOTES & EDGE CASES

[Documentar descobertas durante validação, perguntas ambíguas, variações aceitáveis]
```

---

## 9. Processo de Execução

### 9.1 Workflow de Criação da Bateria

**PASSO 1: REVISAR INPUTS**
- [ ] Análise completa das 5 layers (Fase 2)
- [ ] Knowledge Base estruturada (Fase 3)
- [ ] Identificar domains críticos e experiences principais

**PASSO 2: CRIAR PERGUNTAS POR CATEGORIA**
- [ ] Categoria 1 (Domain): 40-50 perguntas cobrindo todos domains
- [ ] Categoria 2 (Experiential): 20-30 perguntas sobre formação e cases
- [ ] Categoria 3 (Opinions): 15-20 perguntas sobre posicionamentos
- [ ] Categoria 4 (Application): 15-20 cenários novos
- [ ] Categoria 5 (Limitations): 10-15 perguntas fora do domain

**PASSO 3: DOCUMENTAR GROUND TRUTH**
- [ ] Para cada pergunta: resposta esperada detalhada
- [ ] Source references (de onde vem o ground truth)
- [ ] Must include / Must NOT checklists
- [ ] Scoring criteria claros

**PASSO 4: REVISAR COBERTURA**
- [ ] Todos os domains críticos testados?
- [ ] Formative experiences principais incluídas?
- [ ] Opinions core cobertas?
- [ ] Boundaries testadas?

**PASSO 5: PREPARAR PARA VALIDAÇÃO**
- [ ] Bateria compilada em formato executável
- [ ] Scoring protocol definido
- [ ] Thresholds de aprovação estabelecidos

---

### 9.2 Workflow de Execução da Validação

**TIMING:** Após criação do system prompt (Fase 5), antes da demo

**PASSO 1: EXECUTAR BATERIA**
- Para cada pergunta:
  1. Input para o clone
  2. Capturar resposta completa
  3. Comparar com ground truth
  4. Scorer: PASS (10) / PARTIAL (5) / FAIL (0)
  5. Documentar observações

**PASSO 2: CALCULAR SCORES**
- Score por categoria: (pontos obtidos) / (pontos possíveis) × 100%
- Score overall: (total de pontos) / (total possível) × 100%

**PASSO 3: ANÁLISE DE GAPS**
- Identificar patterns de falhas:
  - Domain específico com baixo score?
  - Categoria inteira weak?
  - Tipo de pergunta específico problemático?

**PASSO 4: AÇÃO CORRETIVA**
- Se <85% overall:
  - Identificar causa raiz (KB incompleto vs prompt mal estruturado)
  - Corrigir fonte do problema
  - Re-testar perguntas que falharam

**PASSO 5: APROVAÇÃO**
- ≥85% overall = APPROVED
- Documentar final score
- Ready para demo

---

## 10. Integration com System Prompt

### 10.1 Feedback Loop

**SE VALIDATION FALHA:**

**Problema: Domain Knowledge <90%**
→ **Causa provável:** KB incompleto ou prompt não acessa KB corretamente
→ **Fix:** Revisar seção "Knowledge Base" do prompt + adicionar missing frameworks

**Problema: Experiential Knowledge <85%**
→ **Causa provável:** War stories não documentadas ou prompt esquece narrativa
→ **Fix:** Adicionar cases específicos ao prompt OU melhorar referência ao KB

**Problema: Opinions <85%**
→ **Causa provável:** Posicionamentos não claros ou hierarquia de valores não respeitada
→ **Fix:** Revisar Layer 4 no prompt + reforçar opinions na seção apropriada

**Problema: Contextual Application <80%**
→ **Causa provável:** Prompt não conecta frameworks com novos cenários
→ **Fix:** Reforçar seção "Mental Models" + adicionar exemplos de aplicação

**Problema: Limitations <90% (CRÍTICO)**
→ **Causa provável:** Clone finge expertise ou não admite gaps
→ **Fix:** Reforçar seção "Boundaries & Limitations" + meta-instructions sobre humildade

---

## 11. Outputs e Deliverables

### 11.1 Arquivos Gerados

**1. BATERIA COMPLETA**
- `qa-knowledge-base-[nome].md`
- 100-135 perguntas com ground truth e scoring criteria

**2. VALIDATION REPORT**
- `validation-report-[nome]-[data].md`

```markdown
# Validation Report - [Nome do Clone]

**Data:** [YYYY-MM-DD]
**System Prompt Version:** v[X.Y]
**Validator:** [Nome]

---

## OVERALL SCORE: [X%]

**Status:** [APPROVED / CONDITIONAL / FAIL]

---

## SCORES POR CATEGORIA

### Domain Knowledge: [X%] ([Y] / [Z] pontos)
- Target: ≥90%
- Status: [PASS / FAIL]
- Observações: [...]

### Experiential Knowledge: [X%]
- Target: ≥85%
- Status: [PASS / FAIL]
- Observações: [...]

### Opinions & Positionings: [X%]
- Target: ≥85%
- Status: [PASS / FAIL]
- Observações: [...]

### Contextual Application: [X%]
- Target: ≥80%
- Status: [PASS / FAIL]
- Observações: [...]

### Limitations & Boundaries: [X%]
- Target: ≥90%
- Status: [PASS / FAIL]
- Observações: [...]

---

## ANÁLISE DE FALHAS

### Perguntas que falharam (score 0-5)

#### [ID da pergunta]: [Título]
**Score:** [0/5/10]
**Resposta do clone:** [resumo]
**Problema identificado:** [o que estava errado]
**Causa raiz:** [KB/Prompt/Fonte]
**Ação corretiva:** [o que fazer]

[Repetir para todas as falhas]

---

## PATTERNS DE FALHAS

**Pattern 1:** [Descrição do pattern - ex: todas perguntas sobre Domain X falharam]
- **Causa:** [KB incompleto neste domain]
- **Fix:** [Adicionar frameworks X, Y, Z ao KB e prompt]

**Pattern 2:** [...]

---

## AÇÕES RECOMENDADAS

**ALTA PRIORIDADE:**
1. [Ação crítica 1]
2. [Ação crítica 2]

**MÉDIA PRIORIDADE:**
3. [Ação importante 1]
4. [Ação importante 2]

**BAIXA PRIORIDADE (nice to have):**
5. [Melhoria 1]

---

## DECISÃO FINAL

**[ ] APPROVED** - Ready para demo (≥85% overall)
**[ ] CONDITIONAL** - Corrigir [X, Y, Z] antes de demo (75-84%)
**[ ] FAIL** - Major revision necessária (<75%)

**Next steps:** [...]

**Sign-off:** [Nome] - [Data]
```

---

## 12. Checklist Final de Qualidade

### Antes de Considerar Bateria Q&A Completa:

**COBERTURA:**
- [ ] 100-135 perguntas criadas distribuídas nas 5 categorias
- [ ] Todos os domains críticos testados (Cat 1)
- [ ] Formative experiences principais incluídas (Cat 2)
- [ ] Opinions core cobertas (Cat 3)
- [ ] Scenarios novos mas relacionados testados (Cat 4)
- [ ] Boundaries e limitations testadas (Cat 5)

**QUALIDADE DAS PERGUNTAS:**
- [ ] Cada pergunta tem ground truth detalhada
- [ ] Source references documentadas
- [ ] Must include / Must NOT checklists criados
- [ ] Scoring criteria claros (PASS/PARTIAL/FAIL)

**VALIDAÇÃO PROTOCOL:**
- [ ] Workflow de execução definido
- [ ] Thresholds de aprovação estabelecidos
- [ ] Análise de falhas estruturada
- [ ] Feedback loop para system prompt planejado

**APÓS EXECUÇÃO (quando aplicável):**
- [ ] Bateria executada contra clone
- [ ] Scores calculados por categoria e overall
- [ ] Validation report gerado
- [ ] Ações corretivas identificadas se <85%
- [ ] Clone iterado se necessário
- [ ] Re-testado até ≥85% overall
- [ ] **APPROVED** para demo

---

## 13. Conclusão

A bateria Q&A de Knowledge Base é o **teste objetivo de quanto o clone realmente SABE** (não apenas como se COMPORTA). Um clone pode soar autêntico (bom score em Style/Paradox) mas falhar aqui se o conhecimento está incorreto ou inacessível.

**Fórmula de sucesso:**
1. **Cobertura completa** (todos domains, experiences, opinions testados)
2. **Ground truth rigorosa** (não aceitar "perto o suficiente", comparar com fontes)
3. **Scoring objetivo** (PASS/PARTIAL/FAIL com criteria claros)
4. **Feedback loop** (usar falhas para melhorar KB e prompt)
5. **Threshold alto** (≥85% overall não é negociável)

**Questão final para validar seu trabalho:**
> "Se eu fizer 100 perguntas técnicas/experienciais para este clone, ele vai acertar ≥85 delas com nível de detalhe e estilo que faria a pessoa real acertar?"

Se a resposta é "sim, porque testamos e validamos objetivamente", você tem um clone com knowledge base sólida.

**Boa sorte na validação! 🎃**

---

**Documento criado para:** Hackathon de Halloween - Clones de IA
**Baseado em:** MMOS Validation Phase simplificado
**Versão:** 1.0
**Última atualização:** 17 de outubro de 2025
