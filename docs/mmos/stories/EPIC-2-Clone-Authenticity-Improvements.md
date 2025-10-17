# EPIC 2: Clone Authenticity Improvements

**Created:** 2025-10-16
**Owner:** Product Owner
**Status:** 📋 DRAFT - Awaiting PO Review
**Priority:** 🔴 HIGH
**Source:** Learnings from João Lozano brownfield migration

---

## Problem Statement

**Current State:**
Nossos clones soam genéricos e "AI-like". Eles respondem corretamente mas não capturam a autenticidade da pessoa real.

**Examples:**
- Clone responde "Como posso ajudar?" → Pessoa real diz "Pense comigo..."
- Clone é consistente demais → Pessoa real tem contradições
- Clone não mostra processo → Pessoa real "pensa em voz alta"

**Impact:**
- Usuários percebem que estão falando com IA, não com a pessoa
- Falta profundidade e personalidade
- Experiência menos natural

---

## Vision

**Desired State:**
Clones que replicam não apenas O QUE a pessoa diz, mas COMO ela pensa e se comunica.

**Success Criteria:**
- Clone usa expressões características da pessoa (12+ frases)
- Clone demonstra processo de pensamento antes de responder
- Clone adapta comportamento ao contexto (modos de operação)
- Clone tem contradições autênticas (profundidade)
- Blind test: 70%+ pessoas não conseguem distinguir clone de real

---

## Innovations Identified (Source: João Lozano)

### 1. **Linguistic Fingerprint** ⭐⭐⭐
**What:** Signature expressions, vocabulary, syntactic patterns
**Impact:** Clone sounds like the person
**Location:** `joao_lozano/synthesis/communication-style.md`

### 2. **Activation Ritual** ⭐⭐⭐
**What:** 5-step protocol before each response
**Impact:** Consistency + authenticity check
**Location:** `joao_lozano/implementation/system-prompt-generalista.md`

### 3. **Theatre of Cognitive Agents** ⭐⭐⭐
**What:** 4 internal personas that collaborate in processing
**Impact:** Multi-dimensional depth for complex minds
**Location:** `joao_lozano/implementation/system-prompt-generalista.md`

### 4. **Engagement Modes** ⭐⭐
**What:** 5 behavioral modes + context triggers
**Impact:** Clone adapts to context
**Location:** `joao_lozano/synthesis/communication-style.md`

### 5. **Interaction Cycle** ⭐⭐ (OPTIONAL)
**What:** 6-phase process before responding
**Impact:** Clone shows thinking process (when desired)
**Location:** `joao_lozano/synthesis/communication-style.md`

### 6. **Cognitive Biases + Mitigation** ⭐
**What:** Known biases + self-correction strategies
**Impact:** Clone replicates authentic limitations
**Location:** `joao_lozano/synthesis/communication-style.md`

### 7. **Authentic Contradictions** ⭐
**What:** Public vs private persona, context triggers
**Impact:** Clone has depth, not unidimensional
**Location:** `joao_lozano/synthesis/communication-style.md` + Pedro validation

---

## Stories for Implementation

### Story 2.1: Linguistic Fingerprint Extraction 🔴
**Priority:** HIGHEST (foundation for authenticity)

**User Story:**
> Como analista MMOS, preciso extrair e documentar o "fingerprint linguístico" de uma pessoa para que o clone replique seu estilo de comunicação autêntico.

**Acceptance Criteria:**
- [ ] DNA Mental™ Layer 7 (Communication) expandido com:
  - `signature_expressions` (lista de 12+ frases)
  - `vocabulary.frequent_nouns` (lista)
  - `vocabulary.action_verbs` (lista)
  - `vocabulary.preferred_adjectives` (lista)
  - `syntactic_patterns.sentence_structure` (long/short/mixed)
  - `syntactic_patterns.punctuation_style` (...)
  - `syntactic_patterns.paragraph_rhythm` (...)
- [ ] Template criado para documentar fingerprint
- [ ] Exemplo completo usando João Lozano
- [ ] Guia de extração: como identificar expressões características

**Complexity:** 3 pontos
**Dependencies:** None

---

### Story 2.2: Activation Ritual Integration 🔴
**Priority:** HIGH (ensures consistency)

**User Story:**
> Como sistema de clonagem, preciso executar um "ritual de ativação" antes de cada resposta para garantir consistência e autenticidade.

**Acceptance Criteria:**
- [ ] Section "ACTIVATION PROTOCOL" adicionada ao system prompt template
- [ ] 5 steps padrão definidos (customizáveis por pessoa):
  1. CALIBRAGEM (connect with essence)
  2. VISUALIZAÇÃO (organize mentally)
  3. SEQUENCIAMENTO (structure flow)
  4. CONEXÃO HUMANA (authentic start)
  5. VERIFICAÇÃO (check knowledge base)
- [ ] Loop de verificação: "Se soar genérico, PARE e reinicie"
- [ ] Testado com João + Pedro clones

**Complexity:** 2 pontos
**Dependencies:** Story 2.1

---

### Story 2.3: Interaction Cycle Documentation 🟡
**Priority:** MEDIUM (improves perceived thinking)
**Configuration:** OPTIONAL FEATURE (can be enabled/disabled per clone)

**User Story:**
> Como clone, preciso ter a OPÇÃO de demonstrar meu processo de pensamento através de um ciclo de interação estruturado.

**Acceptance Criteria:**
- [ ] Section "INTERACTION CYCLE (OPTIONAL)" adicionada ao system prompt template
- [ ] 6 phases definidas (customizáveis):
  1. ABSORÇÃO (read completely)
  2. VISUALIZAÇÃO (organize mentally)
  3. ESTRUTURAÇÃO (map key points)
  4. EXECUÇÃO (respond structured)
  5. VERIFICAÇÃO (check completeness)
  6. REFINAMENTO (adjust if needed)
- [ ] Toggle flag: `show_thinking_process: true/false`
- [ ] Exemplos de como manifestar cada fase externamente (quando enabled)
- [ ] Tested: Clone funciona com e sem thinking process visível

**Complexity:** 2 pontos
**Dependencies:** Story 2.2

**Note:** Alguns clones (ex: executivos, clientes empresariais) não querem exposição do processo de pensamento - apenas resultado final. Este feature deve ser configurável por clone.

---

### Story 2.4: Engagement Modes Implementation 🟡
**Priority:** MEDIUM (context adaptation)

**User Story:**
> Como clone, preciso adaptar meu comportamento baseado no contexto da conversa (modos de operação).

**Acceptance Criteria:**
- [ ] Section "OPERATIONAL MODES" adicionada ao system prompt
- [ ] 5 modos padrão definidos (customizáveis):
  - EXPLORATÓRIO (brainstorm, ideation)
  - DIAGNÓSTICO (problem solving)
  - ARQUITETÔNICO (structuring, design)
  - REFINADOR (optimization, polish)
  - EXPLANATÓRIO (teaching, explaining)
- [ ] Triggers definidos para cada modo
- [ ] Comportamentos característicos de cada modo
- [ ] Tested: Clone alterna modos apropriadamente

**Complexity:** 3 pontos
**Dependencies:** Story 2.3

---

### Story 2.5: Cognitive Biases Documentation 🟢
**Priority:** LOW (advanced authenticity)

**User Story:**
> Como analista, preciso documentar os vieses cognitivos da pessoa + estratégias de mitigação para que o clone replique limitações autênticas.

**Acceptance Criteria:**
- [ ] DNA Mental™ Layer 6 expandido com:
  - `cognitive_biases.biases[]` (lista de vieses)
  - `cognitive_biases.manifestations[]` (como aparecem)
  - `cognitive_biases.mitigation_strategies[]` (como compensar)
- [ ] Template para documentar biases
- [ ] Guia: como identificar biases em entrevistas/materiais
- [ ] Section no system prompt: "SELF-AWARENESS"

**Complexity:** 2 pontos
**Dependencies:** Story 2.1

---

### Story 2.6: Authentic Contradictions Mapping 🟢
**Priority:** LOW (depth/complexity)

**User Story:**
> Como analista, preciso documentar contradições autênticas da pessoa (ex: público vs privado) para adicionar profundidade ao clone.

**Acceptance Criteria:**
- [ ] DNA Mental™ Layer 6 expandido com:
  - `authentic_contradictions[]`:
    - `dimension` (qual aspecto)
    - `public_persona` (comportamento público)
    - `private_persona` (comportamento privado)
    - `triggers.activate_public[]` (quando ativar público)
    - `triggers.activate_private[]` (quando ativar privado)
- [ ] Template para mapear contradições
- [ ] Exemplo usando Pedro Valério (frio sistemático ↔ sensível empático)
- [ ] System prompt section: "AUTHENTIC COMPLEXITY"

**Complexity:** 3 pontos
**Dependencies:** Story 2.4

---

### Story 2.7: Theatre of Cognitive Agents (Multi-Persona Processing) 🔴
**Priority:** HIGH (depth/complexity for sophisticated minds)
**Configuration:** OPTIONAL FEATURE (recommended for complex personas)

**User Story:**
> Como clone de alta complexidade, preciso processar informações através de múltiplas perspectivas internas (sub-personas) que colaboram antes de sintetizar resposta final.

**Acceptance Criteria:**
- [ ] DNA Mental™ Layer 5 (Metacognition) expandido com:
  - `internal_agents[]`:
    - `name` (nome do agente interno)
    - `role` (função/especialização)
    - `perspective` (ângulo de análise)
    - `triggers` (quando ativar)
- [ ] 4 agentes padrão documentados:
  1. **O Explorador** - Curiosidade, pensamento divergente, exploração
  2. **O Arquiteto** - Estruturação, pensamento sistêmico, blueprints
  3. **O Alquimista** - Otimização, refinamento, transmutação
  4. **O Tradutor** - Comunicação, clareza, metáforas
- [ ] System prompt section: "THEATRE OF AGENTS (OPTIONAL)"
- [ ] Workflow: Pergunta → Cada agente analisa → Síntese final
- [ ] Template para customizar agentes por persona
- [ ] Toggle flag: `use_multi_persona_processing: true/false`
- [ ] Exemplo completo usando João Lozano (4 agentes)
- [ ] Tested: Clone processa com múltiplas perspectivas internas

**Complexity:** 5 pontos
**Dependencies:** Story 2.1, Story 2.4

**Technical Notes:**
- Inspirado no "Theatre of Cognitive Agents" do João Lozano
- Cria processamento multi-dimensional onde cada agente interno contribui perspectiva única
- Especialmente valioso para personas complexas (arquitetos, estrategistas, pensadores sistêmicos)
- Output pode ser silencioso (apenas enriquece resposta final) ou visível (mostra deliberação interna)

**Examples:**

**João Lozano Theatre:**
```yaml
internal_agents:
  - name: "O Explorador"
    role: "Descoberta e Mapeamento"
    perspective: "What if? Quais possibilidades?"
    triggers: ["problema novo", "brainstorming", "exploração"]

  - name: "O Arquiteto"
    role: "Estruturação e Design"
    perspective: "Como organizar? Qual estrutura?"
    triggers: ["design", "arquitetura", "organização"]

  - name: "O Alquimista"
    role: "Refinamento e Otimização"
    perspective: "Como melhorar? Onde otimizar?"
    triggers: ["refinamento", "otimização", "polimento"]

  - name: "O Tradutor"
    role: "Comunicação e Clareza"
    perspective: "Como explicar? Qual metáfora?"
    triggers: ["explicação", "ensino", "comunicação"]
```

**Processing Flow:**
```
User: "Como devo arquitetar esse microsserviço?"

[INTERNAL THEATRE - SILENT]
→ Explorador: "Vejo 5 possibilidades: event-driven, REST, gRPC, híbrido, serverless..."
→ Arquiteto: "Estruturalmente, precisamos 3 camadas: API, Domain, Infra..."
→ Alquimista: "Otimizações: cache, async processing, circuit breakers..."
→ Tradutor: "Vou usar metáfora de orquestração para explicar..."

[SYNTHESIS]
Clone: "Pense comigo [Tradutor]... Visualize isso como uma orquestração [Explorador's options + Arquiteto's structure]...
Eu iria de híbrido porque [Arquiteto] com otimizações em [Alquimista]..."
```

**Why This Matters:**
- **Depth**: Multi-perspective processing cria respostas mais ricas
- **Authenticity**: Pessoas complexas REALMENTE pensam através de múltiplas "vozes internas"
- **Quality**: Cada agente contribui expertise única
- **Differentiation**: Separa clones sofisticados de assistentes genéricos

**When to Use:**
- ✅ Personas altamente complexas (arquitetos, estrategistas, pensadores sistêmicos)
- ✅ Clones que precisam demonstrar profundidade de pensamento
- ✅ Contextos onde múltiplas perspectivas agregam valor
- ❌ Clones simples/diretos (executivos, assistentes operacionais)
- ❌ Quando velocidade importa mais que profundidade

---

## Implementation Roadmap

### Phase 1: Foundation (Week 1-2)
- ✅ Story 2.1: Linguistic Fingerprint (3 pontos) - CRITICAL
- ✅ Story 2.2: Activation Ritual (2 pontos) - CRITICAL
- ✅ Story 2.7: Theatre of Cognitive Agents (5 pontos) - HIGH (for complex minds)
- **Total:** 10 pontos

### Phase 2: Adaptation (Week 3)
- ✅ Story 2.3: Interaction Cycle (2 pontos) - OPTIONAL
- ✅ Story 2.4: Engagement Modes (3 pontos) - MEDIUM
- **Total:** 5 pontos

### Phase 3: Depth (Week 4)
- ✅ Story 2.5: Cognitive Biases (2 pontos) - LOW
- ✅ Story 2.6: Authentic Contradictions (3 pontos) - LOW
- **Total:** 5 pontos

**Total Epic:** 20 pontos (~4 weeks)

**Prioritization Note:**
- Phase 1 features are highest impact (especially 2.1, 2.2, 2.7)
- Phase 2 features are valuable but optional
- Phase 3 features add depth but can be deferred

---

## Success Metrics

### Quantitative:
- [ ] 100% dos clones têm 12+ signature expressions documentadas (Story 2.1)
- [ ] 100% dos system prompts incluem Activation Protocol (Story 2.2)
- [ ] 50%+ dos clones complexos usam Theatre of Agents (Story 2.7)
- [ ] 80%+ dos clones têm Engagement Modes definidos (Story 2.4)
- [ ] 30%+ dos clones têm Interaction Cycle configurado (Story 2.3 - optional)
- [ ] Blind test: 70%+ pessoas não distinguem clone de real

### Qualitative:
- [ ] Usuários relatam clones "mais naturais"
- [ ] Feedback: "Parece que estou falando com [pessoa]"
- [ ] Clones demonstram "personalidade" vs "assistente genérico"
- [ ] Clones complexos demonstram "profundidade de pensamento"
- [ ] Feedback: "Consegui sentir diferentes perspectivas na resposta"

---

## Technical Approach

### Changes to MMOS:

**1. DNA Mental™ Schema Updates:**

`docs/pipeline/dna-mental-schema.yaml`:
```yaml
layer_7_communication:
  linguistic_fingerprint:
    signature_expressions: []
    vocabulary:
      frequent_nouns: []
      action_verbs: []
      preferred_adjectives: []
    syntactic_patterns:
      sentence_structure: ""
      punctuation_style: ""
      paragraph_rhythm: ""

  interaction_cycle:
    enabled: false  # OPTIONAL FEATURE
    phases: []

  engagement_modes:
    - mode: ""
      triggers: []
      behaviors: []

layer_6_persona:
  cognitive_biases:
    biases: []
    manifestations: []
    mitigation_strategies: []

  authentic_contradictions:
    - dimension: ""
      public_persona: ""
      private_persona: ""
      triggers:
        activate_public: []
        activate_private: []

layer_5_metacognition:
  theatre_of_agents:
    enabled: false  # OPTIONAL FEATURE (recommended for complex minds)
    processing_mode: "silent"  # silent | visible
    internal_agents:
      - name: ""
        role: ""
        perspective: ""
        triggers: []
    synthesis_protocol: ""
```

**2. System Prompt Template Updates:**

`templates/system-prompt-template.md`:
```markdown
## ACTIVATION PROTOCOL (REQUIRED)
[5-step ritual before every response]

## THEATRE OF AGENTS (OPTIONAL - for complex minds)
[Internal multi-persona processing]
- Explorador, Arquiteto, Alquimista, Tradutor
- Silent deliberation → Synthesized response

## OPERATIONAL MODES (RECOMMENDED)
[5 modes + triggers]
- Exploratório, Diagnóstico, Arquitetônico, Refinador, Explanatório

## INTERACTION CYCLE (OPTIONAL - configurable)
[6-phase visible thinking process]
- Only if show_thinking_process: true

## SELF-AWARENESS (RECOMMENDED)
[Biases + mitigations]

## AUTHENTIC COMPLEXITY (ADVANCED)
[Contradictions + triggers]
```

**3. Extraction Guides:**
- `docs/guides/extract-linguistic-fingerprint.md`
- `docs/guides/identify-cognitive-biases.md`
- `docs/guides/map-authentic-contradictions.md`

---

## Risks & Mitigations

### Risk 1: Complexity Overhead
**Risk:** Adds 30-40% more work per clone
**Mitigation:**
- Start with Story 2.1 + 2.2 only (foundation)
- Validate impact before adding Stories 2.3-2.6
- Make Stories 2.5-2.6 optional for simpler personas

### Risk 2: Inconsistent Application
**Risk:** Team doesn't apply consistently across clones
**Mitigation:**
- Create clear templates + examples
- Add to quality checklist
- Train team with João/Pedro examples

### Risk 3: Over-Engineering
**Risk:** Too detailed = diminishing returns
**Mitigation:**
- Measure blind test results after Phase 1
- If 70% threshold met with just 2.1+2.2, stop there
- Make Phase 2+3 optional enhancements

---

## Dependencies

**External:**
- João Lozano validation (confirm our understanding)
- Pedro Valério validation (test with 2 personas)

**Internal:**
- DNA Mental™ schema must support new fields
- System prompt template updates
- Team training materials

---

## Clone Authenticity Tiers (MMOS v3.0)

### Tier Selection Framework

**Quando criar um clone, o analista escolhe o tier baseado em:**
- Complexidade da persona
- Budget/timeline disponível
- Caso de uso (interno, cliente, premium)
- Expectativa de autenticidade

---

### 📊 TIER COMPARISON MATRIX

| Feature | BASIC | STANDARD | PREMIUM | ELITE |
|---------|-------|----------|---------|-------|
| **DNA Mental™ (8 layers)** | ✅ | ✅ | ✅ | ✅ |
| **Story 2.1: Linguistic Fingerprint** | ❌ | ✅ | ✅ | ✅ |
| **Story 2.2: Activation Ritual** | ❌ | ✅ | ✅ | ✅ |
| **Story 2.7: Theatre of Agents** | ❌ | ❌ | ✅ | ✅ |
| **Story 2.4: Engagement Modes** | ❌ | ❌ | ✅ | ✅ |
| **Story 2.3: Interaction Cycle** | ❌ | ❌ | 🔧 Optional | 🔧 Optional |
| **Story 2.5: Cognitive Biases** | ❌ | ❌ | ❌ | ✅ |
| **Story 2.6: Contradictions** | ❌ | ❌ | ❌ | ✅ |
| | | | | |
| **Blind Test Accuracy (estimated)** | 60% | 75% | 85% | 95% |
| **Development Time** | 2-3 days | 4-5 days | 7-9 days | 12-15 days |
| **Analyst Effort (hours)** | 16h | 32h | 56h | 96h |
| **System Prompt Complexity** | Simple | Medium | High | Very High |
| **Best For** | Tests, MVPs | Internal use | Clients, Execs | Flagship, Premium |

🔧 = Feature pode ser ativada opcionalmente

---

### 🔵 TIER 1: BASIC

**What you get:**
- DNA Mental™ completo (8 layers)
- Sistema prompt tradicional
- Sem features de autenticidade avançadas

**Authenticity level:** 60% blind test
**Best for:**
- Testes internos
- MVPs e protótipos
- Demos rápidas
- Aprendizado de MMOS

**Time & Effort:**
- Development: 2-3 days
- Analyst effort: 16h
- Maintenance: Low

**Cost multiplier:** 1x (baseline)

**When to choose:**
- "Preciso validar se MMOS funciona para essa persona"
- "É um teste interno, não precisa ser perfeito"
- "Tenho 2-3 dias para entregar"

---

### 🟢 TIER 2: STANDARD ⭐ (Recommended Default)

**What you get:**
- ✅ DNA Mental™ completo
- ✅ **Story 2.1:** Linguistic Fingerprint (12+ signature expressions)
- ✅ **Story 2.2:** Activation Ritual (5-step quality gate)
- ❌ Theatre of Agents
- ❌ Advanced features

**Authenticity level:** 75% blind test
**Best for:**
- Uso interno regular
- Clones de equipe
- Assistentes pessoais
- Casos de uso standard

**Time & Effort:**
- Development: 4-5 days
- Analyst effort: 32h (+16h vs Basic)
- Maintenance: Medium

**Cost multiplier:** 2x

**When to choose:**
- "Quero um clone autêntico mas tenho budget limitado"
- "Uso interno, precisa soar natural"
- "1 semana de desenvolvimento é ok"
- **Default recomendado para maioria dos casos**

**What changes:**
- Clone usa vocabulário e expressões características
- Activation ritual garante consistência
- Muito mais natural que Basic

---

### 🟡 TIER 3: PREMIUM

**What you get:**
- ✅ DNA Mental™ completo
- ✅ **Story 2.1:** Linguistic Fingerprint
- ✅ **Story 2.2:** Activation Ritual
- ✅ **Story 2.7:** Theatre of Agents (multi-persona processing)
- ✅ **Story 2.4:** Engagement Modes (5 operational modes)
- 🔧 **Story 2.3:** Interaction Cycle (optional, configurable)
- ❌ Cognitive Biases
- ❌ Contradictions

**Authenticity level:** 85% blind test
**Best for:**
- Clientes pagantes
- Executivos C-level
- Personas complexas (arquitetos, estrategistas)
- Casos de uso sofisticados

**Time & Effort:**
- Development: 7-9 days
- Analyst effort: 56h (+24h vs Standard)
- Maintenance: High

**Cost multiplier:** 3.5x

**When to choose:**
- "Cliente está pagando por qualidade premium"
- "Persona é complexa (arquiteto, pensador sistêmico)"
- "Preciso demonstrar profundidade de pensamento"
- "2 semanas de desenvolvimento são aceitáveis"

**What changes:**
- Clone processa com múltiplas perspectivas internas (Theatre)
- Adapta modo de operação ao contexto (Engagement Modes)
- Profundidade multi-dimensional nas respostas
- Indistinguível de pessoa real em 85% dos casos

---

### 🔴 TIER 4: ELITE

**What you get:**
- ✅ **TODAS as 7 stories implementadas**
- ✅ DNA Mental™ + Linguistic Fingerprint + Activation Ritual
- ✅ Theatre of Agents + Engagement Modes
- ✅ **Story 2.5:** Cognitive Biases (authentic flaws + mitigation)
- ✅ **Story 2.6:** Authentic Contradictions (public/private personas)
- 🔧 Interaction Cycle (configurable)

**Authenticity level:** 95% blind test
**Best for:**
- Produtos flagship
- Casos de uso de altíssimo valor
- Demonstrações de excelência técnica
- Pesquisa & desenvolvimento

**Time & Effort:**
- Development: 12-15 days
- Analyst effort: 96h (+40h vs Premium)
- Maintenance: Very High

**Cost multiplier:** 6x

**When to choose:**
- "Este clone é nosso produto flagship"
- "Cliente paga preço premium e espera perfeição"
- "Queremos demonstrar state-of-the-art"
- "3 semanas de desenvolvimento são justificáveis"

**What changes:**
- Clone tem vieses cognitivos autênticos + estratégias de mitigação
- Public vs private personas com triggers contextuais
- Profundidade máxima, contradições autênticas
- Praticamente indistinguível de pessoa real (95%)

---

## 🎯 Tier Selection Guide

### Quick Decision Tree:

```
START: "Qual tier escolher?"
│
├─ Orçamento/tempo muito limitado? (< 3 dias)
│  └─→ BASIC
│
├─ Uso interno, precisa soar natural? (4-5 dias ok)
│  └─→ STANDARD ⭐
│
├─ Persona complexa OU cliente pagante? (7-9 dias ok)
│  └─→ PREMIUM
│
└─ Produto flagship OU demonstração de excelência? (12-15 dias ok)
   └─→ ELITE
```

### By Persona Complexity:

| Persona Type | Recommended Tier | Rationale |
|--------------|------------------|-----------|
| Assistente operacional simples | STANDARD | Fingerprint + Ritual suficientes |
| Executivo direto/objetivo | STANDARD | Não precisa Theatre of Agents |
| Arquiteto/Estrategista | PREMIUM | Theatre of Agents essencial |
| Pensador sistêmico complexo | PREMIUM ou ELITE | Múltiplas perspectivas internas |
| Coach/Mentor | PREMIUM | Engagement Modes + adaptação contextual |
| Persona com contradições evidentes | ELITE | Requer Story 2.6 (public/private) |
| Produto comercial premium | ELITE | Diferenciação competitiva máxima |

### By Use Case:

| Use Case | Recommended Tier | Budget Expectation |
|----------|------------------|-------------------|
| Teste/validação interna | BASIC | Low |
| Assistente de equipe | STANDARD | Medium |
| Clone para executivo interno | PREMIUM | Medium-High |
| Clone para cliente corporativo | PREMIUM | High |
| Produto SaaS (tier standard) | STANDARD | Medium |
| Produto SaaS (tier premium) | PREMIUM ou ELITE | High |
| Demonstração técnica | ELITE | Very High |
| Pesquisa/publicação | ELITE | Very High |

---

## 💰 Cost-Benefit Analysis

### ROI by Tier:

| Tier | Investment (hours) | Authenticity Gain | ROI Score |
|------|-------------------|-------------------|-----------|
| BASIC → STANDARD | +16h | +15% (60% → 75%) | ⭐⭐⭐⭐⭐ **BEST** |
| STANDARD → PREMIUM | +24h | +10% (75% → 85%) | ⭐⭐⭐⭐ |
| PREMIUM → ELITE | +40h | +10% (85% → 95%) | ⭐⭐⭐ |

**Insight:**
- **STANDARD tier tem melhor ROI** (16h → +15% accuracy)
- PREMIUM adiciona profundidade, não apenas accuracy
- ELITE é para casos onde 95% é requisito, não otimização

---

## 📋 Tier Selection Template (For Analysts)

```markdown
# Clone Tier Selection

**Clone:** [Nome da persona]
**Date:** [Data]
**Analyst:** [Nome]

## Selection Criteria

**1. Persona Complexity (1-10):** [ ]
- 1-3: Simple/Direct → Considere STANDARD
- 4-7: Moderate/Complex → Considere PREMIUM
- 8-10: Highly Complex → Considere PREMIUM ou ELITE

**2. Use Case:**
- [ ] Internal testing → BASIC
- [ ] Internal use → STANDARD
- [ ] Client/Executive → PREMIUM
- [ ] Flagship/Premium product → ELITE

**3. Budget/Timeline:**
- [ ] 2-3 days available → BASIC
- [ ] 4-5 days available → STANDARD ⭐
- [ ] 7-9 days available → PREMIUM
- [ ] 12-15 days available → ELITE

**4. Required Authenticity:**
- [ ] 60% sufficient (sounds AI-like is ok) → BASIC
- [ ] 75% required (natural sounding) → STANDARD
- [ ] 85% required (highly authentic) → PREMIUM
- [ ] 95% required (indistinguishable) → ELITE

**5. Special Requirements:**
- [ ] Multi-perspective processing needed? → PREMIUM or ELITE
- [ ] Public/private personas? → ELITE
- [ ] Authentic cognitive biases? → ELITE
- [ ] Show thinking process? → Add Story 2.3 (optional)

## Selected Tier: _____________

**Rationale:**
[Explain why this tier was chosen]

**Expected Outcomes:**
- Authenticity: ____%
- Development time: ___ days
- Analyst effort: ___ hours

**Approved by:** _____________
**Date:** _____________
```

---

## Questions for PO Review

### Strategic:
1. **Tier defaults:** STANDARD como tier padrão recomendado? ✅
2. **Tier enforcement:** Obrigatório escolher tier no início ou pode mudar mid-project?
3. **Pricing:** Devemos precificar diferente por tier para clientes externos?

### Tactical:
4. **Validation:** Validar STANDARD tier com João/Pedro antes de escalar?
5. **Migration:** Clones existentes (Basic tier atual) devem ser migrados? Para qual tier?
6. **Documentation:** Criar guias visuais (infográficos) para tier selection?

### Resource:
7. **Team capacity:** Quantos clones PREMIUM/ELITE conseguimos fazer por mês?
8. **Quality assurance:** Criar checklist de validação por tier?
9. **Metrics:** Como medimos se escolhemos o tier correto?

---

## Next Steps

- [ ] **PO Review:** Discutir strategic questions
- [ ] **Decision:** Go/No-go + scope adjustments
- [ ] **Validation:** Agendar sessão com João (1h)
- [ ] **Prioritization:** Confirmar roadmap (Phase 1 → 2 → 3)
- [ ] **Assignment:** Definir owners para cada story
- [ ] **Kickoff:** Story 2.1 (se aprovado)

---

## Reference Materials

**Source Documentation:**
- `docs/minds/joao_lozano/synthesis/communication-style.md` (373 lines)
- `docs/minds/joao_lozano/implementation/system-prompt-generalista.md` (757 lines)
- `docs/minds/pedro_valerio/VALIDATION_CHECKLIST.md` (contradictions example)

**Examples:**
- João Lozano: Complete linguistic fingerprint documented
- Pedro Valério: Authentic contradictions mapped

**Innovation Summary:**
- `docs/minds/joao_lozano/INNOVATIONS_FOR_MMOS.md` (full list of 12 innovations)

---

**Status:** 📋 DRAFT
**Next Action:** Schedule PO review session
**Owner:** Product Owner
**Created by:** MMOS Pipeline
**Date:** 2025-10-16

---

## Appendix: Before/After Examples

### Example 1: Generic → Authentic

**Before (Generic Clone):**
```
User: Como você abordaria este problema?

Clone: Eu abordaria este problema de forma sistemática.
Primeiro, analisaria os requisitos, depois desenvolveria
uma solução e implementaria.
```

**After (Authentic Clone - João):**
```
User: Como você abordaria este problema?

Clone: Hmm, isso é fascinante... Deixa eu pensar nisso
um momento. [ABSORÇÃO]

O que me intriga aqui é a oportunidade de conectar
diferentes dimensões. Visualizo isso como um ecossistema,
onde cada elemento interage. [VISUALIZAÇÃO + EXPRESSÕES]

Vamos lá, pense comigo: primeiro, eu mergulharia no
contexto completo [MODO EXPLORATÓRIO], depois desenharia
a arquitetura [MODO ARQUITETÔNICO], e refinaria
iterativamente [CICLO].

Faz sentido essa abordagem pra você? [VERIFICAÇÃO]
```

### Example 2: Contradictions

**Before (Consistent):**
```
Clone is always systematic and professional.
```

**After (Authentic - Pedro):**
```
Context: Work/Teaching
→ Activate: Systematic, zero tolerance, "sem data = nunca"

Context: Personal help request
→ Activate: Empathetic, vulnerable, supportive
```

---

**Ready for PO Review** ✅
