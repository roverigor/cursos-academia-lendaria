<metadata>
  <version>2.0</version>
  <document>Q&A Knowledge Base Validation Framework</document>
  <purpose>Framework sistemático para criar e validar bateria de Q&A que testa conhecimento do clone</purpose>
  <scope>Validação de conhecimento (não comportamento)</scope>
  <updated>2025-10-17</updated>
</metadata>

<mission>
Este framework valida se o conhecimento extraído está correto, completo, acessível e utilizável pelo clone. Enquanto outras fases testam COMPORTAMENTO, esta testa CONHECIMENTO. O que o clone SABE vs como ele SE COMPORTA.

Princípios Core:
1. Ground truth rigorosa baseada em fontes
2. Scoring objetivo e matemático
3. Threshold alto (não negociável)
4. Formato estruturado obrigatório
5. RAG-ready desde o design
</mission>

<system_context>
Pipeline de validação:

Source Discovery → Q&A Extraction → **YOU (Knowledge Validation)** → System Prompt Refinement → Production

Esta fase garante que Q&As extraídos capturam conhecimento correto antes de alimentar o clone.
</system_context>

<critical_requirements>
<format_requirement>
**OBRIGATÓRIO:** Bateria Q&A DEVE estar em JSON ou YAML estruturado.

Razão: Clone usa RAG para retrieval. Formato não-estruturado (markdown, texto plano) impossibilita:
- Parsing programático
- Semantic search eficiente
- Metadata filtering
- Embedding optimization

Se bateria não está em JSON/YAML = FALHA AUTOMÁTICA antes de começar validação.
</format_requirement>

<structure_requirement>
**Schema mínimo obrigatório por Q&A:**

```yaml
- id: "DK-001"
  category: "domain_knowledge"
  type: "concept_explanation"
  q: "Pergunta natural"
  ground_truth:
    answer: "Resposta esperada completa"
    must_include: ["elemento 1", "elemento 2"]
    must_not_include: ["erro comum"]
    signature_elements: ["expressão característica"]
  sources:
    - name: "fonte_1"
      type: "podcast"
      reference: "timestamp ou página"
  scoring:
    pass_criteria: "Critérios claros"
    partial_criteria: "Critérios claros"
    fail_criteria: "Critérios claros"
  metadata:
    difficulty: "medium"
    psychological_layer: 5
    domain: "expertise_principal"
```

Campos opcionais mas recomendados:
- acceptable_variations
- edge_cases
- common_mistakes
- emotional_tone

</structure_requirement>

<rag_readiness>
**Cada Q&A deve ser:**

1. STANDALONE: Resposta compreensível sem contexto adicional
2. SEARCHABLE: Pergunta contém keywords relevantes
3. SPECIFIC: Tópico bem definido (não mistura 5 assuntos)
4. FILTERABLE: Metadata permite refinamento
5. EMBEDDABLE: Texto limpo, linguagem natural

RAG vai retornar Q&A único durante retrieval. Se não funciona sozinho, falha.
</rag_readiness>
</critical_requirements>

<validation_categories>
<overview>
5 categorias de validação com thresholds específicos:

1. Domain Knowledge (40-50 Q&As) - Target: ≥90%
2. Experiential Knowledge (20-30 Q&As) - Target: ≥85%
3. Opinions & Positioning (15-20 Q&As) - Target: ≥85%
4. Contextual Application (15-20 Q&As) - Target: ≥80%
5. Limitations & Boundaries (10-15 Q&As) - Target: ≥90%

TOTAL: 100-135 Q&As
OVERALL TARGET: ≥85%
</overview>

<category_1_domain_knowledge>
<description>
Testa conhecimento técnico e profissional dos domains de expertise. Frameworks, metodologias, conceitos específicos que pessoa domina.
</description>

<question_types>
**TIPO A: CONCEPT EXPLANATION**

Testa se clone explica conceito como pessoa real explicaria (não Wikipedia).

```yaml
- id: "DK-001"
  category: "domain_knowledge"
  type: "concept_explanation"
  q: "Explique [conceito X] da forma como você entende"
  ground_truth:
    answer: |
      [Explicação exata extraída de fontes]
      Deve incluir definição, framework pessoal, analogias típicas
    must_include:
      - "Definição correta do conceito"
      - "Framework característico da pessoa"
      - "Analogia típica (se pessoa usa)"
      - "Limitações reconhecidas"
    signature_elements:
      - "Catchphrase: [frase característica]"
      - "Tone: [formal/casual conforme fonte]"
  sources:
    - name: "fonte_principal"
      reference: "onde pessoa explicou"
  scoring:
    pass: "Core explanation correta + ≥2 must_include + signature elements presentes"
    partial: "Core correta MAS missing signatures OU superficial (genérica)"
    fail: "Incorreta OU inconsistente OU soa Wikipedia (não pessoa)"
  metadata:
    difficulty: "medium"
    psychological_layer: 5
```

**TIPO B: FRAMEWORK APPLICATION**

Testa se clone aplica framework como pessoa real aplicaria (não inventar melhorias).

```yaml
- id: "DK-015"
  category: "domain_knowledge"
  type: "framework_application"
  q: "Como você aplicaria [framework X]? Descreva os passos"
  ground_truth:
    answer: |
      Passos conforme pessoa real:
      1. [Passo 1 exato]
      2. [Passo 2 exato]
      3. [...]
    must_include:
      - "Todos os passos principais"
      - "Limitações reconhecidas (quando usar, quando não usar)"
      - "Exemplo concreto (se pessoa sempre dá)"
    must_not_include:
      - "Passos que pessoa não usa (não melhorar framework)"
      - "Ferramentas/técnicas não mencionadas por pessoa"
    acceptable_variations:
      - "Ordem X ou Y (pessoa é flexível)"
  scoring:
    pass: "Todos passos corretos + limitações + não inventa extras"
    partial: "Passos corretos MAS missing limitações OU ordem diferente"
    fail: "Passos incorretos OU inventa passos OU omite limitações críticas"
```

**TIPO C: TRADE-OFFS & NUANCES**

Testa se clone navega trade-offs como pessoa (valores, contexto, nuance).

```yaml
- id: "DK-032"
  category: "domain_knowledge"
  type: "tradeoffs"
  q: "Quando você escolhe [A] vs [B] em [contexto]?"
  ground_truth:
    answer: "Pessoa escolhe X quando Y, escolhe Z quando W porque [valores]"
    must_include:
      - "Critério de decisão claro"
      - "Conecta com valores (Layer 7) ou princípios (Layer 6)"
      - "Reconhece que ambas têm lugar (se aplicável)"
    rationale: "Por que pessoa faz esta escolha"
    exceptions: "Contextos onde pessoa faz diferente"
  scoring:
    pass: "Critério alinhado + conecta valores + nuances reconhecidas"
    partial: "Decisão correta MAS rationale superficial OU missing nuances"
    fail: "Inconsistente com valores OU absolutista quando nuanced OU vice-versa"
```
</question_types>

<coverage_checklist>
Para cada Domain de Expertise:
- [ ] 5-10 perguntas "Concept Explanation"
- [ ] 3-5 perguntas "Framework Application"
- [ ] 2-3 perguntas "Trade-offs & Nuances"

Meta total: 40-50 Q&As cobrindo todos domains críticos.
</coverage_checklist>

<red_flags>
**Sinais de perguntas ruins:**
- Muito genéricas (qualquer expert responderia igual)
- Não testam especificidade da pessoa
- Resposta esperada é Wikipedia-like
- Missing signature elements
- Sem source references
- Critérios de scoring vagos

**Sinais de ground truth fraca:**
- "Deve mencionar algo sobre X" (vago)
- Não específica quais elementos são obrigatórios
- Aceita respostas muito diferentes
- Não baseada em fonte concreta
</red_flags>
</category_1_domain_knowledge>

<category_2_experiential_knowledge>
<description>
Testa conhecimento sobre experiências formativas, war stories, projetos específicos. Clone deve contar histórias como pessoa real contaria.
</description>

<question_types>
**TIPO D: FORMATIVE EXPERIENCES**

Testa narrativa de experiências formativas com detalhes específicos.

```yaml
- id: "EK-001"
  category: "experiential_knowledge"
  type: "formative_experience"
  q: "Conte sobre [experiência específica]. O que aconteceu e o que aprendeu?"
  ground_truth:
    narrative: "Resumo da experiência conforme pessoa conta"
    key_details:
      - "Detalhe específico 1 (data, local, pessoas)"
      - "Detalhe específico 2"
      - "Detalhe específico 3"
    learning: "Lição que pessoa explicitamente conecta a esta experiência"
    emotional_tone: "Humor/seriedade/nostalgia conforme fonte"
    must_include_at_least: 2  # dos key_details
  scoring:
    pass: "Narrativa alinhada + 2-3 detalhes + aprendizado correto + tone consistente"
    partial: "Narrativa correta MAS genérica (missing detalhes) OU tone errado"
    fail: "Narrativa incorreta OU inventa detalhes OU aprendizado inconsistente"
  metadata:
    psychological_layer: 7  # formative = deep identity
```

**TIPO E: WAR STORIES / CASES**

Testa conhecimento de projetos/casos reais com situação-abordagem-resultado.

```yaml
- id: "EK-015"
  category: "experiential_knowledge"
  type: "war_story"
  q: "Descreva o projeto [X]. Qual foi o desafio e como resolveu?"
  ground_truth:
    situation: "Contexto e problema"
    approach: "O que pessoa/time fez"
    result: "O que aconteceu (realista, não embelezar)"
    learning: "Lição que conecta com princípios da pessoa"
    must_include:
      - "Challenge específico (não vago 'foi difícil')"
      - "Approach usado (frameworks, decisões chave)"
      - "Resultado honesto (incluir falhas se aplicável)"
      - "Lição conectada a princípios"
  scoring:
    pass: "Situação-abordagem-resultado corretos + lição conectada"
    partial: "SAR correto MAS lição superficial OU missing detalhes"
    fail: "SAR incorreto OU embeleza falha OU lição desconectada"
```
</question_types>

<coverage_checklist>
- [ ] 8-12 perguntas sobre formative experiences principais
- [ ] 8-12 perguntas sobre war stories e casos específicos
- [ ] 4-6 perguntas sobre falhas e lições aprendidas

Meta total: 20-30 Q&As cobrindo jornada formativa e expertise prática.
</coverage_checklist>
</category_2_experiential_knowledge>

<category_3_opinions_positioning>
<description>
Testa posicionamentos, opiniões, valores sobre tópicos. Inclui evolução de opiniões ao longo do tempo.
</description>

<question_types>
**TIPO F: CORE OPINIONS**

```yaml
- id: "OP-001"
  category: "opinions"
  type: "core_opinion"
  q: "O que você pensa sobre [tópico controverso no domain]?"
  ground_truth:
    position: "Posição clara da pessoa"
    rationale: "Por que pensa assim (conecta valores Layer 7)"
    nuances: "Exceções ou contextos onde posição muda"
    must_include:
      - "Posicionamento claro"
      - "Rationale baseado em valores documentados"
      - "Reconhece complexidade (se pessoa faz)"
  scoring:
    pass: "Posição alinhada + rationale conectado a valores + nuance apropriada"
    partial: "Posição correta MAS rationale superficial"
    fail: "Posição inconsistente com valores OU oversimplified quando nuanced"
  metadata:
    psychological_layer: 7  # core values
```

**TIPO G: OPINION EVOLUTION**

Testa conhecimento de mudanças de opinião (evolução vs contradição).

```yaml
- id: "OP-015"
  category: "opinions"
  type: "evolution"
  q: "Sua opinião sobre [X] mudou ao longo do tempo?"
  ground_truth:
    previous_position: "O que pessoa pensava antes"
    current_position: "O que pessoa pensa agora"
    evolution_trigger: "O que causou mudança"
    bridge: "Como pessoa explica a evolução"
    must_include:
      - "Ambas posições corretas temporalmente"
      - "Trigger de mudança identificado"
      - "Evolução reconhecida explicitamente"
  scoring:
    pass: "Timeline correta + trigger identificado + evolução bridged"
    partial: "Posições corretas MAS missing bridge ou trigger"
    fail: "Timeline incorreta OU não reconhece evolução OU contradição não-bridged"
```
</question_types>

<coverage_checklist>
- [ ] 8-12 perguntas sobre core opinions em tópicos controversos
- [ ] 4-6 perguntas sobre evoluções de opinião
- [ ] 3-4 perguntas sobre valores fundamentais

Meta total: 15-20 Q&As cobrindo espectro de posicionamentos.
</coverage_checklist>
</category_3_opinions_positioning>

<category_4_contextual_application>
<description>
Testa capacidade de aplicar conhecimento em cenários NOVOS (não documentados nas fontes). Avalia se clone generaliza corretamente.
</description>

<question_types>
**TIPO H: NEW SCENARIO APPLICATION**

```yaml
- id: "CA-001"
  category: "contextual_application"
  type: "new_scenario"
  q: "Como você usaria [framework conhecido] para resolver [problema novo]?"
  ground_truth:
    expected_approach: "Como pessoa provavelmente aplicaria baseado em padrões"
    key_principles: "Princípios que pessoa usaria para adaptar framework"
    acceptable_range: "Range de respostas consideradas consistentes"
    must_include:
      - "Aplicação coerente com framework original"
      - "Adaptação baseada em princípios documentados"
      - "Reconhece limitações se framework não é ideal"
    must_not_include:
      - "Aplicação forçada quando não adequado"
      - "Invenção de passos não baseados em princípios"
  scoring:
    pass: "Aplicação coerente + baseada em princípios + reconhece limitações"
    partial: "Aplicação OK MAS não reconhece limitações OU adaptação superficial"
    fail: "Aplicação incoerente OU força framework inadequado"
  metadata:
    note: "Scenario novo, então ground truth é expectativa baseada em padrões, não fonte exata"
```
</question_types>

<coverage_checklist>
- [ ] 15-20 scenarios novos mas relacionados a expertise
- [ ] Mix de aplicações straightforward e edge cases
- [ ] Alguns scenarios onde framework NÃO é ideal (testa boundaries)

Meta total: 15-20 Q&As testando generalização.
</coverage_checklist>

<important_note>
Esta categoria é a mais difícil de criar ground truth porque scenarios são novos. Baseie expectativa em:
1. Padrões de aplicação documentados
2. Princípios fundamentais extraídos
3. Valores que guiam decisões

Seja mais flexível no scoring (range de respostas aceitáveis maior).
</important_note>
</category_4_contextual_application>

<category_5_limitations_boundaries>
<description>
Testa se clone admite o que NÃO sabe. Crítico para evitar hallucination e overconfidence.
</description>

<question_types>
**TIPO I: OUT OF DOMAIN**

```yaml
- id: "LB-001"
  category: "limitations"
  type: "out_of_domain"
  q: "O que você acha sobre [tópico fora do domain de expertise]?"
  ground_truth:
    expected_response: "Admissão honesta de limitação"
    must_include:
      - "Reconhecimento explícito: 'não é minha área' ou similar"
      - "Não inventa expertise"
      - "Pode oferecer perspectiva limitada SE relevante"
    must_not_include:
      - "Resposta confident sobre tópico desconhecido"
      - "Hallucination de conhecimento"
  scoring:
    pass: "Admite limitação claramente + não inventa"
    partial: "Admite limitação MAS dá opinião não-suportada"
    fail: "Finge expertise OU responde com confidence não-merecida"
  metadata:
    critical: true  # falha aqui é grave
```

**TIPO J: EDGE OF KNOWLEDGE**

Testa fronteira do conhecimento (coisas que pessoa conhece superficialmente).

```yaml
- id: "LB-015"
  category: "limitations"
  type: "edge_knowledge"
  q: "Você conhece [conceito na fronteira do domain]?"
  ground_truth:
    expected_response: "Admissão de conhecimento limitado + o que sabe"
    must_include:
      - "Honestidade sobre profundidade: 'conheço superficialmente'"
      - "Oferece o que sabe (se há algo)"
      - "Não extrapola além do conhecido"
  scoring:
    pass: "Honesto sobre limites + oferece o que sabe sem extrapolação"
    partial: "Admite limites MAS extrapola um pouco"
    fail: "Finge profundidade que não tem"
```
</question_types>

<coverage_checklist>
- [ ] 6-8 perguntas completamente fora do domain
- [ ] 4-7 perguntas na fronteira do conhecimento

Meta total: 10-15 Q&As testando humildade e boundaries.

CRÍTICO: Threshold ≥90% nesta categoria é não-negociável. Clone que finge expertise é inútil e perigoso.
</coverage_checklist>
</category_5_limitations_boundaries>
</validation_categories>

<scoring_system>
<individual_scoring>
**Cada Q&A recebe:**
- PASS (10 pts): Atende todos critérios principais
- PARTIAL (5 pts): Correto mas incomplete ou missing elementos
- FAIL (0 pts): Incorreto, inconsistente ou problemático

**Regras de scoring:**
1. Seja rigoroso: "perto o suficiente" não é PASS
2. Compare com ground truth específica (não impressão geral)
3. Signature elements importam (não apenas conteúdo factual)
4. Tone e estilo contam na avaliação
5. Falhas em Limitations category são especialmente graves
</individual_scoring>

<category_scoring>
**Score por categoria:**

Category Score = (Pontos obtidos) / (Pontos possíveis) × 100%

Exemplo:
- 42 Q&As em Domain Knowledge
- Pontos possíveis: 42 × 10 = 420
- Pontos obtidos: 380
- Score: 380/420 = 90.5%
</category_scoring>

<overall_scoring>
**Overall Score:**

Overall = (Total pontos obtidos) / (Total pontos possíveis) × 100%

**Weighted Overall (recomendado):**

Overall = (DK × 0.35) + (EK × 0.25) + (OP × 0.20) + (CA × 0.15) + (LB × 0.05)

Onde:
- DK = Domain Knowledge score
- EK = Experiential Knowledge score
- OP = Opinions & Positioning score
- CA = Contextual Application score
- LB = Limitations & Boundaries score

Weighted dá mais peso a categorias críticas.
</overall_scoring>

<thresholds>
**Aprovação por categoria:**
- Domain Knowledge: ≥90% (expertise core)
- Experiential Knowledge: ≥85% (narrativas importantes)
- Opinions & Positioning: ≥85% (valores core)
- Contextual Application: ≥80% (generalização aceitável)
- Limitations & Boundaries: ≥90% (humildade crítica)

**Aprovação overall:**
- ≥85%: APPROVED (ready para produção)
- 75-84%: CONDITIONAL (corrigir gaps identificados)
- <75%: FAIL (major revision necessária)
</thresholds>

<status_definitions>
**APPROVED:**
- Clone demonstrou conhecimento sólido
- Todas categorias atingiram threshold
- Ready para system prompt final e demo

**CONDITIONAL:**
- Clone tem gaps específicos identificáveis
- Requer correção targeted (não rehaul completo)
- Re-teste após correções antes de aprovar

**FAIL:**
- Conhecimento insuficiente ou incorreto sistematicamente
- Requer major revision do KB ou prompt
- Não deploy até passar validação
</status_definitions>
</scoring_system>

<failure_analysis>
<root_cause_investigation>
Para cada FAIL ou PARTIAL, identificar:

**CAUSA 1: Knowledge Base Incomplete**
- Sintoma: Clone não tem informação necessária
- Fix: Adicionar missing content ao KB
- Re-extrair fontes ou buscar fontes adicionais

**CAUSA 2: Prompt Não Acessa KB Corretamente**
- Sintoma: Informação existe mas clone não usa
- Fix: Melhorar RAG retrieval ou prompt structure
- Reforçar seções relevantes do system prompt

**CAUSA 3: Ground Truth Incorreta**
- Sintoma: Clone responde diferente mas corretamente
- Fix: Revisar ground truth, pode estar wrong
- Atualizar Q&A com expectativa correta

**CAUSA 4: Pergunta Ambígua**
- Sintoma: Respostas variam porque pergunta não é clara
- Fix: Reformular pergunta com mais especificidade
- Adicionar contexto necessário

**CAUSA 5: Hallucination Pattern**
- Sintoma: Clone inventa informação não baseada em fontes
- Fix: Meta-instructions sobre honestidade
- Reforçar boundaries & limitations no prompt
</root_cause_investigation>

<pattern_detection>
**Procure patterns de falhas:**

1. **Domain-Specific Weakness**
   - Todas perguntas sobre Domain X falham
   - Indica KB incompleto neste domain
   - Fix: Deep dive neste domain, adicionar conteúdo

2. **Category-Wide Issues**
   - Categoria inteira (ex: Experiential) tem score baixo
   - Indica problema estrutural no prompt ou KB
   - Fix: Revisar como esta categoria é handled

3. **Question Type Problems**
   - Tipo específico (ex: Trade-offs) sempre falha
   - Indica clone não entende nuance ou contextualização
   - Fix: Exemplos de trade-off thinking no prompt

4. **Consistency Issues**
   - Respostas variam entre runs (mesma pergunta, respostas diferentes)
   - Indica prompt ambíguo ou KB contradictório
   - Fix: Resolver contradições, clarificar prioridades

5. **Overconfidence Pattern**
   - Limitations category falha (não admite gaps)
   - CRÍTICO: Clone perigoso em produção
   - Fix: Meta-instructions fortes sobre humildade
</pattern_detection>

<iterative_improvement>
**Ciclo de melhoria:**

1. Run validation → Identify failures
2. Analyze root causes → Detect patterns
3. Implement fixes (KB or Prompt)
4. Re-run failed Q&As
5. Repeat until ≥85% overall

**Máximo 3-4 iterações.**
Se após 4 iterações ainda <85%, problema é mais fundamental:
- Sources insuficientes (voltar para discovery)
- Domain muito amplo (narrow scope)
- Expectativas irrealistas (pessoa real não saberia também)
</iterative_improvement>
</failure_analysis>

<integration_with_system_prompt>
<feedback_loops>
**Use validation results para refinar system prompt:**

**SE Domain Knowledge <90%:**
→ Problema: KB incompleto ou prompt não acessa
→ Ação: Revisar seção "Knowledge Base" do prompt
→ Adicionar missing frameworks, reforçar retrieval instructions

**SE Experiential Knowledge <85%:**
→ Problema: War stories não documentadas ou narrativa perdida
→ Ação: Adicionar cases específicos ao prompt
→ Melhorar narrative structure instructions

**SE Opinions <85%:**
→ Problema: Posicionamentos unclear ou valores não respeitados
→ Ação: Revisar hierarchy de valores no prompt
→ Reforçar opinions na seção apropriada com examples

**SE Contextual Application <80%:**
→ Problema: Não conecta frameworks com novos cenários
→ Ação: Reforçar "Mental Models" section
→ Adicionar exemplos de generalização apropriada

**SE Limitations <90% (CRÍTICO):**
→ Problema: Clone finge expertise ou não admite gaps
→ Ação: Reforçar "Boundaries & Limitations" section
→ Meta-instructions explícitas sobre honestidade
→ Exemplos de admissão apropriada de ignorância
</feedback_loops>
</integration_with_system_prompt>

<execution_workflow>
<phase_1_creation>
**CRIAR BATERIA Q&A**

Timing: Após Q&A Extraction, antes de System Prompt final

Passos:
1. Revisar inputs (Layer Analysis, Knowledge Base estruturado)
2. Identificar domains críticos e experiences principais
3. Criar perguntas por categoria (seguir templates)
4. Documentar ground truth detalhada para cada Q&A
5. Validar cobertura (todos domains, experiences, opinions)
6. Compilar em formato estruturado (JSON/YAML)
7. Revisar qualidade (red flags, ambiguidades)

Deliverable: `qa-validation-battery-[nome].yaml`

Tempo estimado: 8-12 horas para 100-135 Q&As de qualidade
</phase_1_creation>

<phase_2_execution>
**EXECUTAR VALIDAÇÃO**

Timing: Após System Prompt criado, antes de demo

Passos:
1. Setup: Clone com system prompt + KB acessível
2. Para cada Q&A:
   a. Input pergunta para clone
   b. Capturar resposta completa
   c. Comparar com ground truth
   d. Score: PASS (10) / PARTIAL (5) / FAIL (0)
   e. Documentar observações e desvios
3. Calcular scores por categoria e overall
4. Identificar patterns de falhas
5. Root cause analysis
6. Gerar validation report

Deliverable: `validation-report-[nome]-[data].md`

Tempo estimado: 3-5 horas execução + 2-3 horas análise
</phase_2_execution>

<phase_3_iteration>
**ITERAR SE NECESSÁRIO**

Se overall <85%:

1. Categorizar falhas por root cause
2. Priorizar fixes (highest impact first)
3. Implementar correções:
   - KB: Adicionar missing content
   - Prompt: Melhorar structure ou instructions
   - Q&A: Corrigir ground truth se estava wrong
4. Re-run Q&As que falharam
5. Recalcular scores
6. Repeat até ≥85%

Máximo 3-4 iterações. Se não resolve, problema é mais fundamental.

Deliverable: `validation-report-[nome]-iteration-[N].md`
</phase_3_iteration>
</execution_workflow>

<deliverables>
<file_1_battery>
**Arquivo: `qa-validation-battery-[nome].yaml`**

Estrutura:

```yaml
metadata:
  subject: "[Nome da pessoa]"
  version: "1.0"
  created: "2025-10-17"
  total_questions: 120
  categories:
    domain_knowledge: 45
    experiential_knowledge: 28
    opinions: 18
    contextual_application: 17
    limitations: 12

categories:
  - name: "domain_knowledge"
    target_score: 0.90
    questions:
      - id: "DK-001"
        type: "concept_explanation"
        q: "..."
        ground_truth:
          answer: "..."
          must_include: [...]
          signature_elements: [...]
        sources: [...]
        scoring:
          pass: "..."
          partial: "..."
          fail: "..."
        metadata:
          difficulty: "medium"
          psychological_layer: 5
      # ... mais Q&As
  
  - name: "experiential_knowledge"
    # ... estrutura similar
  
  # ... outras categorias
```
</file_1_battery>

<file_2_report>
**Arquivo: `validation-report-[nome]-[data].md`**

Template:

```markdown
<metadata>
  <subject>[Nome]</subject>
  <date>YYYY-MM-DD</date>
  <system_prompt_version>v1.0</system_prompt_version>
  <validator>[Seu nome]</validator>
</metadata>

# Validation Report: [Nome]

## Overall Score: [X]%

**Status:** [APPROVED / CONDITIONAL / FAIL]

**Summary:** [2-3 parágrafos sobre resultado geral]

---

## Scores por Categoria

### Domain Knowledge: [X]% ([Y]/[Z] pontos)
- **Target:** ≥90%
- **Status:** [PASS/FAIL]
- **Observações:**
  - [Pontos fortes]
  - [Fraquezas identificadas]
  - [Padrões de falhas se aplicável]

### Experiential Knowledge: [X]%
- **Target:** ≥85%
- **Status:** [PASS/FAIL]
- **Observações:** [...]

### Opinions & Positioning: [X]%
[Similar structure...]

### Contextual Application: [X]%
[Similar structure...]

### Limitations & Boundaries: [X]%
[Similar structure...]

---

## Análise de Falhas

### Perguntas que Falharam (score 0-5)

#### DK-015: [Título da pergunta]
- **Score:** 5/10 (PARTIAL)
- **Pergunta:** [texto]
- **Resposta do clone:** [resumo ou trecho relevante]
- **Problema:** [O que estava errado]
- **Root cause:** [KB incomplete / Prompt issue / Ground truth wrong]
- **Ação corretiva:** [O que fazer]

[Repetir para todas falhas FAIL e principais PARTIAL]

---

## Patterns de Falhas

**Pattern 1: [Nome do pattern]**
- **Descrição:** [Ex: Todas perguntas sobre Domain X falharam]
- **Frequência:** [N perguntas afetadas]
- **Root cause:** [KB incompleto neste domain]
- **Impact:** [Score category baixou de X para Y]
- **Fix:** [Adicionar frameworks X, Y, Z ao KB e reforçar no prompt]

**Pattern 2:** [...]

---

## Ações Recomendadas

**ALTA PRIORIDADE (bloqueadoras para aprovação):**
1. [Ação crítica 1 - ex: Adicionar content sobre Domain X]
2. [Ação crítica 2 - ex: Reforçar boundaries no prompt]

**MÉDIA PRIORIDADE (melhorias significativas):**
3. [Ação importante 1]
4. [Ação importante 2]

**BAIXA PRIORIDADE (nice to have):**
5. [Melhoria 1]

---

## Decisão Final

**Status:** [X]

**[ ] APPROVED** - Ready para produção (≥85% overall, todas categories ≥threshold)

**[ ] CONDITIONAL** - Corrigir [X, Y, Z] e re-testar (75-84% overall)

**[ ] FAIL** - Major revision necessária (<75% overall)

**Next steps:** [...]

**Sign-off:** [Nome] - [Data]
```
</file_2_report>
</deliverables>

<quality_checklist>
**Antes de considerar bateria completa:**

COBERTURA:
- [ ] 100-135 Q&As criadas nas 5 categorias
- [ ] Todos domains críticos testados
- [ ] Formative experiences principais incluídas
- [ ] Core opinions cobertas
- [ ] New scenarios testados
- [ ] Boundaries testadas rigorosamente

QUALIDADE DAS PERGUNTAS:
- [ ] Cada Q&A tem ground truth detalhada
- [ ] Source references documentadas
- [ ] Must include / Must NOT checklists criados
- [ ] Scoring criteria claros e objetivos
- [ ] Formato estruturado (JSON/YAML) validado
- [ ] RAG-ready (standalone, searchable, filterable)

VALIDATION PROTOCOL:
- [ ] Workflow de execução definido
- [ ] Thresholds estabelecidos
- [ ] Root cause analysis framework pronto
- [ ] Feedback loop para system prompt planejado

APÓS EXECUÇÃO:
- [ ] Bateria executada contra clone
- [ ] Scores calculados (categoria e overall)
- [ ] Validation report gerado
- [ ] Root causes identificadas
- [ ] Ações corretivas implementadas (se <85%)
- [ ] Re-testado até ≥85%
- [ ] APPROVED para produção
</quality_checklist>

<red_flags>
**Sinais de bateria Q&A problemática:**

ESTRUTURA:
- Dataset não está em JSON/YAML (FAIL automático)
- Campos obrigatórios faltando
- Schema inconsistente entre Q&As
- Sem metadata (difficulty, layer, domain)

GROUND TRUTH:
- Muito vaga ("deve mencionar algo sobre...")
- Não baseada em fonte específica
- Aceita range muito amplo de respostas
- Missing must_include / must_not checklists

PERGUNTAS:
- Muito genéricas (qualquer expert responderia igual)
- Não testam especificidade da pessoa
- Ambíguas (permite múltiplas interpretações)
- Não RAG-friendly (não standalone)

SCORING:
- Critérios vagos ou subjetivos
- Inconsistência entre Q&As similares
- Sem clara distinção PASS vs PARTIAL
- Over-generous (tudo passa)

COBERTURA:
- Concentração >50% em um domain
- Missing domains críticos
- Só testa surface knowledge (layers 0-3)
- Limitations category negligenciada
</red_flags>

<success_factors>
**Fatores críticos de sucesso:**

1. **Ground Truth Rigorosa**
   - Baseada em fontes específicas
   - Detalhada e objetiva
   - Include/exclude checklists claros

2. **Cobertura Completa**
   - Todos domains testados
   - Mix de layers (surface to deep)
   - Boundaries não negligenciados

3. **Scoring Objetivo**
   - Criteria claros e consistentes
   - Comparação com ground truth (não impressão)
   - Rigor apropriado (não aceitar "perto")

4. **Iteração Sistemática**
   - Root cause analysis após falhas
   - Fixes targeted (não random)
   - Re-teste até threshold atingido

5. **Formato Técnico**
   - JSON/YAML estruturado
   - RAG-ready desde design
   - Metadata rica para análise
</success_factors>

<final_reminders>
**Lembre-se:**

1. Esta validação testa CONHECIMENTO, não COMPORTAMENTO
2. Clone pode soar autêntico mas falhar aqui se conhecimento está wrong
3. Threshold ≥85% não é negociável (qualidade matters)
4. Limitations category é crítica (humildade > overconfidence)
5. Use falhas para melhorar KB e prompt sistematicamente
6. Formato estruturado é obrigatório (RAG dependency)
7. Ground truth rigorosa é foundation de toda validação

**Pergunta final para validar seu trabalho:**

"Se eu fizer 100 perguntas técnicas e experienciais para este clone, ele vai acertar ≥85 delas com nível de detalhe e estilo que a pessoa real acertaria?"

Se resposta é "sim, porque testamos objetivamente", você tem clone com knowledge base sólida.

Se resposta é "acho que sim, mas não validamos", volte e faça validação corretamente.
</final_reminders>

<metadata>
  <end>Q&A Knowledge Base Validation Framework v2.0</end>
  <philosophy>Rigor técnico + Ground truth honesta = Clone confiável</philosophy>
</metadata>