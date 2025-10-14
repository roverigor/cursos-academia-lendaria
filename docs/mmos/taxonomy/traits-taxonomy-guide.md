# Traits Taxonomy Design Guide

**Document Version:** 2.0.0
**Last Updated:** 2025-10-13
**Owner:** Product Owner / Database Architect
**Status:** Enhanced with Automated Detection Framework

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Database Schema](#database-schema)
3. [Core Field Definitions](#core-field-definitions)
4. [Advanced Fields for Automated Detection](#advanced-fields-for-automated-detection)
5. [Cross-Model Integration](#cross-model-integration)
6. [Computational Ontologies](#computational-ontologies)
7. [Automated Detection Patterns](#automated-detection-patterns)
8. [Ethical Considerations](#ethical-considerations)
9. [Design Guidelines](#design-guidelines)
10. [YAML Templates](#yaml-templates)
11. [Examples](#examples)
12. [Integration](#integration)
13. [Checklist](#checklist)

---

## 🎯 Overview

### Purpose

The **traits** table stores a comprehensive taxonomy of psychological traits used for profiling minds in the MMOS system. Traits are fundamental characteristics that describe cognitive patterns, behavioral tendencies, emotional regulation, motivation drivers, social behaviors, and core values.

### Why Traits Matter

- **Psychometric Profiling:** Enable 94% fidelity clones by capturing psychological dimensions
- **DNA Mental™ Integration:** Complement the 8-layer cognitive architecture
- **Quantifiable Assessment:** Provide measurable dimensions (0-100 scores) for each mind
- **Cross-Framework Mapping:** Bridge scientific frameworks (Big Five, HEXACO, VIA, Schwartz, Reiss) with custom traits
- **System Prompt Enhancement:** Inform personality parameters for AI clones
- **Automated Detection:** Enable AI-powered psychometric inference from multimodal data sources
- **Interoperability:** Support computational ontologies for research and clinical applications

### Scope

**Target:** 60-80 traits (recommended)
- **Minimum Viable:** 30-40 traits (Big Five + DNA Mental™ core)
- **Recommended:** 60-80 traits (Big Five + DNA Mental™ + domain-specific)
- **Comprehensive:** 100-120 traits (research-grade taxonomy)

---

## 🗄️ Database Schema

### Table Structure

```sql
CREATE TABLE traits (
  code INTEGER PRIMARY KEY,              -- Unique identifier (1-120)
  name TEXT NOT NULL UNIQUE,             -- Trait name
  description TEXT NOT NULL,             -- Clear explanation
  domain TEXT NOT NULL,                  -- Category (cognitive, emotional, etc.)
  subdomain TEXT,                        -- Subcategory (optional)
  scale_min_label TEXT,                  -- Low pole label
  scale_max_label TEXT,                  -- High pole label
  related_frameworks TEXT,               -- JSON: ["Framework: Factor"]
  inverse_of INTEGER REFERENCES traits(code),  -- Inverse trait code
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  version TEXT DEFAULT '1.0'
);

CREATE INDEX idx_traits_domain ON traits(domain);
```

### Domains

The `domain` field must be one of these CHECK-constrained values:

- **`cognitive`** - Mental processes, thinking patterns
- **`emotional`** - Emotional regulation, affect
- **`motivation`** - Drives, goals, incentives
- **`social`** - Interpersonal behavior, relationships
- **`behavioral`** - Observable actions, habits
- **`values`** - Core principles, beliefs
- **`other`** - Miscellaneous traits

---

## 📖 Core Field Definitions

**Note:** These are the foundational fields stored in the database `traits` table. For advanced detection and automation fields, see the [Advanced Fields](#advanced-fields-for-automated-detection) section.

### 1. code (INTEGER PRIMARY KEY)

**Type:** INTEGER
**Required:** YES
**Constraints:** PRIMARY KEY, UNIQUE
**Range:** 1-120 (or more if needed)

**Purpose:**
Unique numeric identifier for the trait.

**Numbering Convention:**
Organize by domain for clarity:
- 1-20: cognitive traits
- 21-40: emotional traits
- 41-60: motivation traits
- 61-80: social traits
- 81-100: behavioral traits
- 101-120: values traits

**Examples:**
```yaml
code: 1    # First cognitive trait
code: 42   # A motivation trait
code: 85   # A behavioral trait
```

---

### 2. name (TEXT NOT NULL UNIQUE)

**Type:** TEXT
**Required:** YES
**Constraints:** NOT NULL, UNIQUE
**Format:** Title Case, 2-4 words

**Purpose:**
Short, memorable name for the trait. Must be unique across all traits.

**Naming Guidelines:**
- ✅ Use nouns or noun phrases (e.g., "Risk Tolerance", "Analytical Thinking")
- ✅ Be specific and descriptive
- ✅ Use established psychological terms when possible
- ❌ Avoid verbs or action phrases
- ❌ Don't use generic terms like "Trait 1" or "Characteristic A"

**Good Examples:**
```yaml
name: "Epistemic Curiosity"
name: "Risk Tolerance"
name: "Autonomy Drive"
name: "Long-term Thinking"
name: "Analytical Reasoning"
name: "Emotional Regulation"
name: "Internal Motivation"
name: "Abstract Thinking"
name: "Decision Velocity"
```

**Bad Examples:**
```yaml
name: "Being Curious"           # ❌ Verb phrase
name: "Thinks Analytically"     # ❌ Verb
name: "Good at Risk"            # ❌ Vague
name: "Trait Number One"        # ❌ Generic
```

---

### 3. description (TEXT NOT NULL)

**Type:** TEXT
**Required:** YES
**Constraints:** NOT NULL
**Length:** 50-200 characters (1-3 sentences)

**Purpose:**
Clear, concise explanation of what the trait measures. Should be understandable to non-psychologists but precise for experts.

**Writing Guidelines:**
- ✅ Start with "The capacity to...", "The tendency to...", "Preference for...", or "Willingness to..."
- ✅ Explain WHAT is measured (not WHY it matters)
- ✅ Include nuances or distinguishing characteristics
- ✅ Be specific about the psychological construct
- ❌ Avoid jargon unless necessary
- ❌ Don't explain applications or benefits

**Good Examples:**
```yaml
description: "The drive to seek knowledge, ask questions, and explore new ideas purely for intellectual satisfaction, not instrumental gain."

description: "Willingness to take calculated risks and embrace uncertainty in pursuit of significant outcomes, even with potential for loss."

description: "Preference for self-directed action and decision-making without external control or excessive input from others."

description: "Capacity to maintain focus on long-term goals (years/decades) over short-term gratification or immediate results."

description: "Ability to break down complex problems into logical components, identify patterns, and derive conclusions through systematic thinking."
```

**Bad Examples:**
```yaml
description: "Being curious."  # ❌ Too vague

description: "This trait is important for success and helps people learn."  # ❌ Explains WHY, not WHAT

description: "Super-duper analytical thinking skillz."  # ❌ Unprofessional

description: "Thinking in a way that uses the neocortex and prefrontal regions to process information via neural pathways..."  # ❌ Too technical
```

---

### 4. domain (TEXT NOT NULL)

**Type:** TEXT
**Required:** YES
**Constraints:** CHECK constraint (must be one of allowed values)

**Allowed Values:**
- `cognitive`
- `emotional`
- `motivation`
- `social`
- `behavioral`
- `values`
- `other`

**Purpose:**
High-level category for organizing traits by psychological domain.

**Domain Classification Guide:**

#### **cognitive** - Mental Processes
- Analytical thinking, abstract reasoning, pattern recognition
- Memory, attention, processing speed
- Problem-solving styles, decision-making patterns
- Learning styles, conceptual thinking

**Examples:** Analytical Reasoning, Abstract Thinking, Pattern Recognition, First-Principles Thinking

#### **emotional** - Affect and Regulation
- Emotional stability, mood patterns
- Empathy, emotional intelligence
- Stress response, emotional resilience
- Affect expression, emotional awareness

**Examples:** Emotional Regulation, Empathy, Resilience, Emotional Stability

#### **motivation** - Drives and Goals
- Achievement drive, ambition
- Intrinsic vs extrinsic motivation
- Goal-orientation (learning vs performance)
- Persistence, determination

**Examples:** Achievement Drive, Autonomy Drive, Mastery Orientation, Internal Motivation

#### **social** - Interpersonal Behavior
- Extraversion, sociability
- Trust, cooperation
- Communication style, influence
- Relationship-building, networking

**Examples:** Extraversion, Trust Propensity, Influence Style, Collaboration Preference

#### **behavioral** - Observable Actions
- Risk-taking, impulsivity
- Persistence, consistency
- Work habits, routines
- Decision velocity, action bias

**Examples:** Risk Tolerance, Decision Velocity, Action Bias, Impulsivity

#### **values** - Core Principles
- Integrity, honesty
- Autonomy, independence
- Fairness, justice
- Truth-seeking, intellectual honesty

**Examples:** Intellectual Honesty, Autonomy Value, Fairness Orientation, Integrity

**Examples:**
```yaml
domain: "cognitive"      # For "Analytical Reasoning"
domain: "motivation"     # For "Achievement Drive"
domain: "values"         # For "Intellectual Honesty"
domain: "behavioral"     # For "Risk Tolerance"
domain: "social"         # For "Extraversion"
```

---

### 5. subdomain (TEXT, nullable)

**Type:** TEXT
**Required:** NO (optional)
**Constraints:** None
**Format:** snake_case, 2-3 words

**Purpose:**
More specific subcategory within the domain for granular organization.

**Common Subdomains by Domain:**

#### **cognitive:**
- `reasoning` - Logical, analytical, abstract thinking
- `learning` - Knowledge acquisition, curiosity
- `attention` - Focus, concentration, multitasking
- `memory` - Retention, recall, working memory
- `creativity` - Divergent thinking, originality
- `processing` - Speed, efficiency, patterns

#### **emotional:**
- `regulation` - Emotional control, stability
- `empathy` - Understanding others' emotions
- `resilience` - Bounce-back, stress management
- `expression` - Emotional openness, authenticity
- `awareness` - Self-awareness, emotional intelligence

#### **motivation:**
- `achievement` - Drive to succeed, ambition
- `autonomy` - Independence, self-direction
- `mastery` - Skill development, excellence
- `purpose` - Meaning, contribution
- `persistence` - Grit, determination

#### **social:**
- `relationships` - Connection, intimacy
- `influence` - Persuasion, leadership
- `collaboration` - Teamwork, cooperation
- `status` - Recognition, prestige
- `communication` - Style, clarity

#### **behavioral:**
- `decision_making` - Risk, speed, deliberation
- `execution` - Action, persistence, follow-through
- `habits` - Routines, consistency
- `communication` - Style, clarity, directness
- `work_style` - Productivity, focus

#### **values:**
- `ethics` - Honesty, integrity
- `agency` - Autonomy, self-determination
- `truth_seeking` - Intellectual honesty
- `fairness` - Justice, equity

**Examples:**
```yaml
subdomain: "reasoning"        # For cognitive traits
subdomain: "achievement"      # For motivation traits
subdomain: "decision_making"  # For behavioral traits
subdomain: null               # If no specific subdomain
```

---

### 6. scale_min_label (TEXT, nullable)

**Type:** TEXT
**Required:** NO (but highly recommended)
**Constraints:** None
**Length:** 1-4 words

**Purpose:**
Descriptive label for the **low pole** of the trait scale (low scores). Used for interpreting trait scores.

**Guidelines:**
- ✅ Describe the characteristic at LOW levels
- ✅ Use positive alternative (not negative)
- ✅ Be neutral in value (avoid "bad", "deficient", "lacking")
- ✅ Match the opposite pole (scale_max_label)
- ❌ Don't use "Not X" or "Low X"

**Common Continuums:**
```
Risk Averse ↔ Risk Seeking
Conservative ↔ Open
Reactive ↔ Proactive
Intuitive ↔ Analytical
Concrete ↔ Abstract
Present-focused ↔ Future-focused
Spontaneous ↔ Planned
Reserved ↔ Outgoing
Flexible ↔ Structured
Trusting ↔ Skeptical
Emotional ↔ Rational
Collaborative ↔ Independent
Deliberate ↔ Decisive
```

**Good Examples:**
```yaml
# Risk Tolerance
scale_min_label: "Risk Averse"
scale_max_label: "Risk Seeking"

# Autonomy Drive
scale_min_label: "Collaborative"
scale_max_label: "Independent"

# Analytical Thinking
scale_min_label: "Intuitive"
scale_max_label: "Analytical"

# Long-term Thinking
scale_min_label: "Present-focused"
scale_max_label: "Future-focused"

# Extraversion
scale_min_label: "Reserved"
scale_max_label: "Outgoing"
```

**Bad Examples:**
```yaml
scale_min_label: "Not risk-taking"  # ❌ Negative framing
scale_min_label: "Low"              # ❌ Not descriptive
scale_min_label: "Bad at risk"      # ❌ Judgmental
scale_min_label: "Lacks courage"    # ❌ Deficit framing
```

---

### 7. scale_max_label (TEXT, nullable)

**Type:** TEXT
**Required:** NO (but highly recommended)
**Constraints:** None
**Length:** 1-4 words

**Purpose:**
Descriptive label for the **high pole** of the trait scale (high scores). Complementary pair with `scale_min_label`.

**Guidelines:**
- ✅ Describe the characteristic at HIGH levels
- ✅ Form a clear continuum with scale_min_label
- ✅ Neutral in value (not "better" or "worse")
- ✅ Concise (1-4 words)

**Examples:** See examples in `scale_min_label` section above - always come in pairs.

**Interpretation:**

Trait scores are 0-100 scale:
- **0-40:** Strong tendency toward `scale_min_label`
- **40-60:** Moderate/balanced
- **60-100:** Strong tendency toward `scale_max_label`

**Example:**
```yaml
# Trait: Risk Tolerance
scale_min_label: "Risk Averse"
scale_max_label: "Risk Seeking"

# Score interpretation:
# 20 = Very risk averse (toward min)
# 50 = Moderate/balanced risk approach
# 85 = Very risk-seeking (toward max)
```

---

### 8. related_frameworks (TEXT, nullable)

**Type:** TEXT (JSON array format)
**Required:** NO (optional)
**Constraints:** None
**Format:** `'["Framework: Factor", "Framework: Factor"]'` (JSON string)

**Purpose:**
Map this trait to established psychological frameworks for validation, research, and cross-referencing.

**Common Frameworks:**

#### Scientific Frameworks:
- **Big Five (OCEAN):**
  - Openness to Experience
  - Conscientiousness
  - Extraversion
  - Agreeableness
  - Neuroticism (Emotional Stability)

- **HEXACO:**
  - Honesty-Humility
  - Emotionality
  - eXtraversion
  - Agreeableness
  - Conscientiousness
  - Openness to Experience

- **Eysenck's Model:**
  - Psychoticism
  - Extraversion
  - Neuroticism

- **Cattell 16PF:** 16 personality factors

#### Popular Frameworks:
- **MBTI:** 16 types (INTJ, ENFP, etc.)
  - Dimensions: Extraversion/Introversion, Sensing/Intuition, Thinking/Feeling, Judging/Perceiving

- **Enneagram:** 9 personality types

#### Specialized Frameworks:
- **Holland RIASEC:** Realistic, Investigative, Artistic, Social, Enterprising, Conventional
- **Dark Triad:** Narcissism, Machiavellianism, Psychopathy
- **Grit Scale:** Perseverance and passion for long-term goals
- **Growth Mindset:** Carol Dweck's theory
- **Sensation Seeking Scale:** Zuckerman's model
- **Locus of Control:** Internal vs external
- **Achievement Motivation Theory:** Need for achievement

**Format:**
```json
["Framework Name: Specific Factor", "Another Framework: Factor"]
```

**Examples:**
```yaml
related_frameworks: '["Big Five: Openness to Experience", "MBTI: Intuition (N)"]'

related_frameworks: '["Big Five: Conscientiousness", "Grit: Perseverance"]'

related_frameworks: '["Big Five: Extraversion", "MBTI: Extraversion (E)", "Eysenck: Extraversion"]'

related_frameworks: '["Growth Mindset (Dweck)", "Big Five: Openness"]'

related_frameworks: '["Dark Triad: Machiavellianism", "Big Five: Low Agreeableness"]'

related_frameworks: '["Holland RIASEC: Investigative", "Big Five: Openness (Intellect)"]'

related_frameworks: null  # No established framework mapping
```

**Use Cases:**
- Cross-reference with scientific literature
- Validate construct against established research
- Compare with existing psychological assessments
- Enable research citations and credibility

---

### 9. inverse_of (INTEGER, nullable)

**Type:** INTEGER
**Required:** NO (optional)
**Constraints:** FOREIGN KEY to `traits(code)`
**Format:** Trait code number

**Purpose:**
Reference the trait code that represents the **conceptual inverse** of this trait. Used when two traits measure opposite poles of the same construct.

**When to Use:**

Use `inverse_of` when:
- Two traits measure opposite ends of the same underlying dimension
- They are conceptually distinct enough to warrant separate traits
- You want to ensure consistency in scoring (if one is high, other is low)

**Important Rules:**
- ⚠️ Only ONE trait in the pair should reference the other (avoid circular references)
- ⚠️ Don't use if it's a single continuum (use scale_min/max_label instead)

**Decision Tree:**

```
Are these two separate constructs or one continuum?
│
├─ ONE CONTINUUM (same construct, opposite poles)
│  └─ Use ONE trait with scale_min_label + scale_max_label
│     Example: "Risk Tolerance" with labels "Risk Averse ↔ Risk Seeking"
│
└─ TWO CONSTRUCTS (different but inverse concepts)
   └─ Use TWO traits with inverse_of reference
      Example: "Analytical Thinking" ↔ "Creative Thinking" (different processes)
```

**Examples:**

```yaml
# Example 1: Two separate constructs
# Trait: Internal Motivation (code: 50)
name: "Internal Motivation"
inverse_of: 51  # References "External Motivation"

# Trait: External Motivation (code: 51)
name: "External Motivation"
inverse_of: null  # Don't double-reference

# Example 2: One continuum (don't use inverse_of)
# Trait: Risk Tolerance (code: 42)
name: "Risk Tolerance"
scale_min_label: "Risk Averse"
scale_max_label: "Risk Seeking"
inverse_of: null  # Single continuum, use labels

# Example 3: Separate but inverse traits
# Trait: Long-term Thinking (code: 10)
name: "Long-term Thinking"
inverse_of: 11

# Trait: Short-term Focus (code: 11)
name: "Short-term Focus"
inverse_of: null
```

**Common Inverse Pairs:**
```
Analytical Thinking ↔ Intuitive Thinking
Internal Motivation ↔ External Motivation
Long-term Orientation ↔ Short-term Focus
Abstract Thinking ↔ Concrete Thinking
Systematic Approach ↔ Spontaneous Approach
```

---

### 10. created_at (TEXT, auto)

**Type:** TEXT (ISO 8601 datetime)
**Required:** AUTO
**Default:** CURRENT_TIMESTAMP
**Format:** `'YYYY-MM-DD HH:MM:SS'`

**Purpose:**
Automatic timestamp of when the trait was created in the database.

**Note:** This field is **automatically populated** - you don't need to provide it.

---

### 11. updated_at (TEXT, auto)

**Type:** TEXT (ISO 8601 datetime)
**Required:** AUTO
**Default:** CURRENT_TIMESTAMP
**Format:** `'YYYY-MM-DD HH:MM:SS'`

**Purpose:**
Timestamp of the last update to the trait record.

**Note:** SQLite does NOT auto-update this. If you modify a trait, update this field manually in your UPDATE statement.

---

### 12. version (TEXT)

**Type:** TEXT
**Required:** NO
**Default:** `'1.0'`
**Format:** Semantic versioning (MAJOR.MINOR)

**Purpose:**
Track the conceptual version of the trait definition. Increment when making significant changes.

**Versioning Guide:**
- `1.0` - Initial trait definition
- `1.1` - Minor clarification (description tweak, label refinement)
- `1.2` - Additional mappings to frameworks
- `2.0` - Major reconceptualization (different construct, significant redefinition)

**Examples:**
```yaml
version: "1.0"  # Initial definition
version: "1.1"  # Updated description for clarity
version: "2.0"  # Reconceptualized the trait entirely
```

---

## 🔬 Advanced Fields for Automated Detection

This section documents the extended data structure for automated psychometric detection from multimodal sources. These fields are **not stored in the database** but are used in YAML configuration files, AI detection systems, and computational models.

### Overview

The advanced trait structure enables:
- **Automated inference** from text, speech, behavioral patterns
- **Multimodal detection** across WhatsApp, meetings, documents, code
- **Linguistic analysis** with pattern matching and NLP
- **Cross-framework mapping** for research interoperability
- **Ethical safeguards** with privacy sensitivity levels

### Complete Field Catalog

#### 1. canonical (TEXT, REQUIRED)

**Purpose:** Unique lowercase identifier for programmatic access and cross-system integration.

**Format:** `snake_case`, Portuguese or English, no special characters

**Examples:**
```yaml
canonical: "ansiedade"
canonical: "risk_tolerance"
canonical: "criatividade_divergente"
```

**Usage:**
- Key for JSON/YAML objects
- API endpoints (`/traits/ansiedade`)
- Database foreign keys
- Cross-system references

---

#### 2. aliases (ARRAY[TEXT])

**Purpose:** Alternative names, translations, and colloquial terms for the trait.

**Format:** Array of strings in multiple languages

**Examples:**
```yaml
aliases:
  - "anxiété"  # French
  - "ansiedad"  # Spanish
  - "anxiety"  # English
  - "preocupação crônica"  # Colloquial Portuguese
  - "nervosismo"
```

**Usage:**
- Multilingual NLP matching
- Search optimization
- User-facing translations
- Colloquial pattern detection

---

#### 3. psychometric_type (ENUM)

**Purpose:** Classification of the psychological construct type.

**Allowed Values:**
- `traço` - Stable personality trait (Big Five facets)
- `valor` - Core value or principle (Schwartz Values)
- `motivação` - Motivational driver (Reiss Basic Desires)
- `virtude` - Character strength (VIA Classification)
- `habilidade` - Cognitive/social ability
- `estilo` - Behavioral or cognitive style

**Examples:**
```yaml
psychometric_type: "traço"  # For "Extraversion"
psychometric_type: "valor"  # For "Autonomy"
psychometric_type: "motivação"  # For "Achievement Drive"
psychometric_type: "virtude"  # For "Honesty"
```

**Cross-Framework Mapping:**
- Big Five → `traço`
- HEXACO → `traço`
- Schwartz Values → `valor`
- Reiss 16 → `motivação`
- VIA Character Strengths → `virtude`

---

#### 4. validation_criteria (TEXT, LONG-FORM)

**Purpose:** Detailed criteria for validating the presence and intensity of the trait through observable evidence.

**Format:** Multi-paragraph text with behavioral markers, linguistic patterns, decision-making indicators

**Structure:**
- **Behavioral markers:** Observable actions and patterns
- **Communication style:** How they express themselves
- **Decision-making:** Patterns in choices and priorities
- **Contextual indicators:** Situational responses

**Example:**
```yaml
validation_criteria: |
  Linguagem repleta de termos negativos, hiperatenção a cenários catastróficos,
  menção recorrente de incertezas, uso frequente de expressões de dúvida
  ("e se...?", "será que...?", "tenho medo que...").

  Comportamentalmente: evitação de situações desconhecidas, necessidade de
  controle excessivo sobre o ambiente, procrastinação por medo de erro.

  Em contextos de decisão: paralisia por análise, necessidade de validação
  externa, preferência por "jogar seguro" mesmo com baixo risco real.

  Padrões de comunicação: respostas longas e circularmente justificadas,
  antecipação de problemas futuros, redirecionamento de conversas para
  preocupações pessoais.
```

---

#### 5. detection_confidence_threshold (FLOAT)

**Purpose:** Minimum confidence level (0.0-1.0) required to assert the trait's presence.

**Format:** Decimal between 0.0 and 1.0

**Guidelines:**
- **0.60-0.70:** Broad traits with clear markers (e.g., Extraversion)
- **0.70-0.80:** Moderate traits requiring multiple signals
- **0.80-0.90:** Nuanced traits needing strong evidence (e.g., Intellectual Humility)
- **0.90+:** Clinical traits requiring expert validation

**Examples:**
```yaml
detection_confidence_threshold: 0.75  # For Anxiety
detection_confidence_threshold: 0.65  # For Extraversion
detection_confidence_threshold: 0.85  # For Machiavellianism
```

---

#### 6. linguistic_markers (OBJECT)

**Purpose:** Structured patterns for NLP-based detection from text data.

**Structure:**
```yaml
linguistic_markers:
  palavras_frequentes:
    - "palavra1"
    - "palavra2"
  construções_frasais:
    - "padrão regex 1"
    - "padrão regex 2"
  intensificadores:
    - "muito"
    - "extremamente"
  hedges:  # Linguistic hedging patterns
    - "talvez"
    - "possivelmente"
  negações:
    - "nunca"
    - "jamais"
  tópicos_recorrentes:
    - "incerteza"
    - "controle"
```

**Example (Ansiedade):**
```yaml
linguistic_markers:
  palavras_frequentes:
    - "sempre"
    - "nunca"
    - "preciso"
    - "tenho que"
    - "medo"
    - "preocupado"
  construções_frasais:
    - "me sinto (ansioso|preocupado|nervoso) quando"
    - "e se (.*?) der errado"
    - "será que (.*?)\\?"
    - "tenho medo (de|que)"
  intensificadores:
    - "muito"
    - "extremamente"
    - "sempre"
    - "constantemente"
  hedges:
    - "talvez"
    - "não sei se"
    - "acho que"
  tópicos_recorrentes:
    - "incerteza"
    - "risco"
    - "controle"
    - "segurança"
```

**Implementation:**
- Use regex for `construções_frasais`
- Count frequency for `palavras_frequentes`
- Weight with `intensificadores`
- Detect hedging with `hedges`

---

#### 7. detection_patterns (OBJECT)

**Purpose:** Comprehensive behavioral and textual patterns for multi-source detection.

**Structure:**
```yaml
detection_patterns:
  text_patterns:
    - "padrão de texto 1"
    - "padrão de texto 2"
  behavioral_markers:
    - "comportamento observável 1"
    - "comportamento observável 2"
  communication_style:
    - "estilo de comunicação 1"
  decision_indicators:
    - "indicador de decisão 1"
  temporal_patterns:
    - "padrão temporal 1"
```

**Example (Introversão):**
```yaml
detection_patterns:
  text_patterns:
    - "prefiro ficar sozinho"
    - "preciso de tempo a sós para recarregar"
    - "encontros sociais me deixam cansado"
  behavioral_markers:
    - "respostas curtas em conversas em grupo"
    - "iniciativa limitada em conversas sociais"
    - "cancela eventos sociais frequentemente"
  communication_style:
    - "comunicação escrita mais elaborada que oral"
    - "preferência por mensagens assíncronas"
    - "pauses longas antes de responder"
  decision_indicators:
    - "escolhe atividades solitárias quando tem opção"
    - "prioriza trabalho individual sobre colaborativo"
  temporal_patterns:
    - "ativo em horários de menor movimento social"
    - "longos intervalos entre interações sociais"
```

---

#### 8. multimodal_indicators (OBJECT)

**Purpose:** Detection patterns specific to different communication channels and data sources.

**Channels:**
- `whatsapp` - Messaging behavior patterns
- `meetings` - Video/audio meeting behaviors
- `documents` - Writing and document creation patterns
- `code` - Programming and technical work patterns
- `social_media` - Public social media behaviors
- `calendar` - Time management and scheduling patterns

**Structure:**
```yaml
multimodal_indicators:
  whatsapp:
    - "indicador WhatsApp 1"
    - "indicador WhatsApp 2"
  meetings:
    - "indicador meetings 1"
    - "indicador meetings 2"
  documents:
    - "indicador documentos 1"
  code:
    - "indicador código 1"
  social_media:
    - "indicador redes sociais 1"
  calendar:
    - "indicador calendário 1"
```

**Example (Introversão):**
```yaml
multimodal_indicators:
  whatsapp:
    - "tempos de resposta longos (>2h média)"
    - "mensagens curtas e objetivas"
    - "raramente inicia conversas"
    - "não participa ativamente de grupos"
    - "desativa 'última vez visto' frequentemente"
  meetings:
    - "câmera frequentemente desligada"
    - "participa apenas quando solicitado diretamente"
    - "contribuições curtas e pontuais"
    - "sai da reunião rapidamente após o fim"
  documents:
    - "documentos longos e bem estruturados (preferência escrita)"
    - "revisões e edições solitárias vs colaborativas"
  code:
    - "commits com mensagens detalhadas"
    - "preferência por code reviews assíncronas"
    - "trabalha em horários alternativos (menos colaboração)"
  social_media:
    - "posts raros e bem pensados"
    - "interações limitadas com conteúdo de outros"
    - "perfil privado ou restrito"
  calendar:
    - "blocos grandes de 'focus time' sem reuniões"
    - "rejeita ou evita eventos sociais opcionais"
    - "preferência por reuniões 1:1 vs grandes grupos"
```

---

#### 9. activation_trigger (TEXT)

**Purpose:** Situational contexts that activate or intensify the trait's expression.

**Format:** Descriptive text explaining triggering situations

**Examples:**
```yaml
# Ansiedade
activation_trigger: "Situações de incerteza, mudanças inesperadas, prazos apertados, avaliações externas, perda de controle sobre o ambiente"

# Criatividade Divergente
activation_trigger: "Problemas abertos sem soluções óbvias, brainstorming sessions, ambiente sem julgamento, tempo livre sem pressão de performance"

# Liderança Autoritativa
activation_trigger: "Crises que requerem decisões rápidas, equipes desorientadas, necessidade de direção clara, baixa competência da equipe"
```

**Usage:**
- Contextual scoring (trait may vary by situation)
- Scenario-based assessment
- Understanding trait variability

---

#### 10. related_traits (ARRAY[TEXT])

**Purpose:** Other traits that correlate positively with this trait.

**Format:** Array of trait names (canonical or full names)

**Examples:**
```yaml
related_traits:
  - "neuroticismo"
  - "perfeccionismo"
  - "need_for_control"
  - "conscientiousness_order"

# For Creativity
related_traits:
  - "openness_to_experience"
  - "risk_tolerance"
  - "divergent_thinking"
  - "intellectual_curiosity"
```

**Usage:**
- Correlation analysis
- Network analysis of trait relationships
- Validation (expect correlated traits to co-occur)

---

#### 11. inverse_traits (ARRAY[TEXT])

**Purpose:** Traits that correlate negatively (conceptual opposites).

**Format:** Array of trait names

**Examples:**
```yaml
# For Ansiedade
inverse_traits:
  - "emotional_stability"
  - "risk_tolerance"
  - "spontaneity"

# For Extraversion
inverse_traits:
  - "introversion"
  - "social_anxiety"
```

---

#### 12. model_mappings (OBJECT)

**Purpose:** Explicit mappings to established psychological frameworks for research and validation.

**Frameworks:**
- `big_five` - OCEAN model
- `hexaco` - HEXACO model
- `via` - VIA Character Strengths
- `schwartz` - Schwartz Values
- `reiss` - Reiss 16 Basic Desires
- `mbti` - Myers-Briggs Type Indicator
- `ipip` - International Personality Item Pool

**Structure:**
```yaml
model_mappings:
  big_five:
    factor: "Neuroticism"
    facet: "Anxiety"
    direction: "positive"  # or "negative" for inverse
  hexaco:
    factor: "Emotionality"
    facet: "Anxiety"
    direction: "positive"
  via:
    strength: null  # No direct mapping
  schwartz:
    value: null
  reiss:
    desire: "Tranquility"
    direction: "negative"  # High anxiety = low tranquility
```

**Example (Extraversion):**
```yaml
model_mappings:
  big_five:
    factor: "Extraversion"
    facet: null  # Broad factor
    direction: "positive"
  hexaco:
    factor: "Extraversion"
    facet: "Social Self-Esteem"
    direction: "positive"
  mbti:
    dimension: "E vs I"
    pole: "E"
  ipip:
    scale: "Extraversion"
```

---

#### 13. facet_of (TEXT, nullable)

**Purpose:** If this trait is a facet/subfacet of a broader trait, reference the parent trait.

**Format:** Canonical name of parent trait

**Examples:**
```yaml
# Assertiveness is a facet of Extraversion
canonical: "assertiveness"
facet_of: "extraversion"

# Anxiety is a facet of Neuroticism
canonical: "anxiety"
facet_of: "neuroticism"

# First-principles thinking is a facet of Openness
canonical: "first_principles_thinking"
facet_of: "openness_to_experience"
```

**Hierarchy Example:**
```
openness_to_experience (broad factor)
├── intellectual_curiosity (facet)
├── aesthetic_appreciation (facet)
├── creative_imagination (facet)
│   ├── divergent_thinking (subfacet)
│   └── originality (subfacet)
└── openness_to_ideas (facet)
```

---

#### 14. measurement_instruments (ARRAY[OBJECT])

**Purpose:** Standardized psychological assessments that measure this trait.

**Structure:**
```yaml
measurement_instruments:
  - name: "NEO-PI-R"
    scale: "Neuroticism - Anxiety Facet"
    items: 8
    citation: "Costa & McCrae, 1992"
  - name: "HEXACO-PI-R"
    scale: "Emotionality - Anxiety"
    items: 10
    citation: "Ashton & Lee, 2009"
```

**Usage:**
- Validation against established measures
- Research citations
- Comparison with clinical assessments
- Item generation for custom instruments

---

#### 15. prevalence_distribution (OBJECT)

**Purpose:** Statistical distribution of the trait in the general population.

**Structure:**
```yaml
prevalence_distribution:
  mean: 50.0  # Population mean (0-100 scale)
  std_dev: 15.0  # Standard deviation
  percentiles:
    p10: 30.0
    p25: 40.0
    p50: 50.0  # Median
    p75: 60.0
    p90: 70.0
  source: "Big Five norms, Costa & McCrae, 1992"
```

**Usage:**
- Normalize scores
- Identify outliers (e.g., top 10% risk-takers)
- Comparative analysis
- Research benchmarking

---

#### 16. development_trajectory (TEXT)

**Purpose:** How the trait typically develops across the lifespan.

**Format:** Descriptive text

**Examples:**
```yaml
development_trajectory: "Geralmente estável após os 30 anos. Pode diminuir levemente com a idade devido a maior exposição e habituação a situações estressantes. Traumas ou mudanças de vida significativas podem aumentar temporariamente."

# For Conscientiousness
development_trajectory: "Tende a aumentar dos 20 aos 40 anos (efeito de maturação). Estabiliza-se na meia-idade. Pode diminuir após aposentadoria se estruturas externas forem removidas."
```

---

#### 17. gender_differences (TEXT, nullable)

**Purpose:** Document any statistically significant gender differences (if ethically relevant).

**Format:** Descriptive text with citations

**Example:**
```yaml
gender_differences: "Meta-análises mostram diferença pequena a moderada (d=0.40), com mulheres pontuando ligeiramente mais alto em ansiedade em média. Importante: variação intra-grupo é muito maior que entre-grupos. (Schmitt et al., 2008)"
```

**Ethical Note:** Include only when scientifically validated and relevant. Always emphasize within-group variance > between-group variance.

---

#### 18. cultural_considerations (TEXT)

**Purpose:** How the trait manifests or is interpreted differently across cultures.

**Format:** Descriptive text

**Examples:**
```yaml
cultural_considerations: "Expressão de ansiedade varia culturalmente. Culturas individualistas tendem a expressar ansiedade verbalmente e buscar suporte emocional. Culturas coletivistas podem somatizar ou expressar através de queixas físicas. Normas de 'face' em culturas asiáticas podem inibir expressão aberta."

# For Assertiveness
cultural_considerations: "Assertividade é valorizada em culturas ocidentais individualistas (EUA, Europa Ocidental) mas pode ser vista como agressiva ou desrespeitosa em culturas coletivistas (Ásia Oriental, América Latina). Comunicação indireta é preferida em culturas de alto contexto (Japão, China)."
```

---

#### 19. clinical_relevance (TEXT, nullable)

**Purpose:** Relevance to clinical psychology, psychiatry, or mental health.

**Format:** Descriptive text with DSM-5/ICD-11 references if applicable

**Examples:**
```yaml
clinical_relevance: "Escores extremamente altos (>85) associados com Transtornos de Ansiedade (DSM-5: 300.xx). Ansiedade patológica diferencia-se por intensidade, duração, e prejuízo funcional. Triagem clínica recomendada para escores >90."

# For Low Empathy
clinical_relevance: "Escores extremamente baixos (<15) podem indicar traços de Transtorno de Personalidade Antissocial (DSM-5: 301.7) ou Transtorno do Espectro Autista (déficit em empatia afetiva). Requer avaliação clínica para diagnóstico diferencial."
```

---

#### 20. privacy_sensitivity (ENUM)

**Purpose:** Ethical classification of how sensitive this trait is for privacy and data protection.

**Levels:**
- `public` - Safe to display publicly (e.g., Curiosity, Creativity)
- `private` - Should be kept private, shared only with consent (e.g., Introversion)
- `sensitive` - Ethically sensitive, special protections needed (e.g., Anxiety, Low Self-Esteem)
- `clinical` - Clinical significance, medical privacy laws apply (e.g., Depression indicators)

**Examples:**
```yaml
privacy_sensitivity: "sensitive"  # For Anxiety
privacy_sensitivity: "public"  # For Creativity
privacy_sensitivity: "clinical"  # For traits associated with mental disorders
privacy_sensitivity: "private"  # For most personality traits
```

**Usage:**
- Access control in applications
- Compliance with GDPR, HIPAA, LGPD
- Informed consent requirements
- Display/sharing permissions

**Guidelines by Level:**

**public:**
- Display in public profiles
- Use in marketing/recommendations
- Aggregate for research without consent

**private:**
- Require user consent to display
- Share only with explicit permission
- Encrypt in transit and at rest

**sensitive:**
- Require explicit informed consent
- Never display without user control
- Implement additional access controls
- Provide opt-out mechanisms

**clinical:**
- Require clinical consent forms
- HIPAA/GDPR medical data protections
- Access limited to licensed professionals
- Mandatory encryption and audit logs

---

#### 21. computational_ontology (OBJECT)

**Purpose:** Machine-readable ontology references for interoperability with research databases.

**Structure:**
```yaml
computational_ontology:
  ipip_code: "A1"  # International Personality Item Pool
  facetmap_uri: "http://www.facetmap.org/trait/anxiety"
  owl_class: "PersonalityTrait:Anxiety"
  wikidata_id: "Q378835"
  snomed_ct: "48694002"  # For clinical traits
```

**Usage:**
- Semantic web integration
- Research database linkage
- Cross-study meta-analysis
- Clinical system integration

---

#### 22. confidence_modifiers (OBJECT)

**Purpose:** Factors that increase or decrease detection confidence.

**Structure:**
```yaml
confidence_modifiers:
  increase:
    - "múltiplas fontes convergentes"
    - "padrões consistentes ao longo do tempo (>6 meses)"
    - "expressão explícita do indivíduo"
  decrease:
    - "fontes contraditórias"
    - "contexto situacional forte (pode ser resposta situacional vs traço estável)"
    - "impressão management (indivíduo pode estar ocultando)"
```

---

#### 23. false_positive_risks (ARRAY[TEXT])

**Purpose:** Common scenarios that may produce false positives in automated detection.

**Examples:**
```yaml
false_positive_risks:
  - "Ansiedade situacional (ex: véspera de apresentação importante) confundida com traço ansioso"
  - "Uso de linguagem hedging por prudência profissional (ex: pesquisadores) vs ansiedade real"
  - "Preocupação pontual com evento específico vs padrão crônico"
```

---

#### 24. nlp_config (OBJECT)

**Purpose:** Technical configuration for NLP-based detection systems.

**Structure:**
```yaml
nlp_config:
  min_document_length: 500  # Minimum words for reliable detection
  context_window: 50  # Words before/after keywords to analyze
  sentiment_weight: 0.3  # How much sentiment analysis contributes
  frequency_weight: 0.4  # How much keyword frequency contributes
  pattern_weight: 0.3  # How much regex pattern matching contributes
  models:
    - "bert-base-multilingual-cased"
    - "gpt-3.5-turbo"
  preprocessing:
    - "lowercase"
    - "remove_punctuation"
    - "lemmatization"
```

---

#### 25. update_history (ARRAY[OBJECT])

**Purpose:** Version history and change log for the trait definition.

**Structure:**
```yaml
update_history:
  - version: "2.0"
    date: "2025-10-13"
    changes: "Added multimodal indicators and NLP configuration"
    author: "Product Owner"
  - version: "1.1"
    date: "2025-08-15"
    changes: "Refined validation criteria based on sam_altman analysis"
    author: "Mind Mapper Agent"
  - version: "1.0"
    date: "2025-06-01"
    changes: "Initial trait definition"
    author: "Database Architect"
```

---

### Field Summary Table

| Field | Type | Storage | Purpose |
|-------|------|---------|---------|
| `canonical` | TEXT | YAML/JSON | Unique identifier |
| `aliases` | ARRAY | YAML/JSON | Alternative names, translations |
| `psychometric_type` | ENUM | YAML/JSON | Trait classification |
| `validation_criteria` | TEXT | YAML/JSON | Observable evidence criteria |
| `detection_confidence_threshold` | FLOAT | YAML/JSON | Minimum confidence for assertion |
| `linguistic_markers` | OBJECT | YAML/JSON | NLP text patterns |
| `detection_patterns` | OBJECT | YAML/JSON | Behavioral/textual patterns |
| `multimodal_indicators` | OBJECT | YAML/JSON | Channel-specific indicators |
| `activation_trigger` | TEXT | YAML/JSON | Situational triggers |
| `related_traits` | ARRAY | YAML/JSON | Positively correlated traits |
| `inverse_traits` | ARRAY | YAML/JSON | Negatively correlated traits |
| `model_mappings` | OBJECT | YAML/JSON | Framework mappings |
| `facet_of` | TEXT | YAML/JSON | Parent trait reference |
| `measurement_instruments` | ARRAY | YAML/JSON | Standardized assessments |
| `prevalence_distribution` | OBJECT | YAML/JSON | Population norms |
| `development_trajectory` | TEXT | YAML/JSON | Lifespan development |
| `gender_differences` | TEXT | YAML/JSON | Gender-related patterns |
| `cultural_considerations` | TEXT | YAML/JSON | Cross-cultural variations |
| `clinical_relevance` | TEXT | YAML/JSON | Mental health significance |
| `privacy_sensitivity` | ENUM | YAML/JSON | Privacy classification |
| `computational_ontology` | OBJECT | YAML/JSON | Semantic web references |
| `confidence_modifiers` | OBJECT | YAML/JSON | Detection confidence factors |
| `false_positive_risks` | ARRAY | YAML/JSON | False positive scenarios |
| `nlp_config` | OBJECT | YAML/JSON | NLP system configuration |
| `update_history` | ARRAY | YAML/JSON | Version control |

---

## 🔗 Cross-Model Integration

### Overview

The MMOS traits taxonomy integrates five major psychological frameworks for comprehensive coverage and scientific validation:

1. **Big Five (OCEAN)** - Most empirically validated, 5 broad factors
2. **HEXACO** - Adds Honesty-Humility, 6 factors
3. **VIA Character Strengths** - 24 positive character traits
4. **Schwartz Values** - 10 universal human values
5. **Reiss 16 Basic Desires** - 16 fundamental motivational drivers

### Integration Strategy

#### Hierarchical Mapping

```
MMOS Trait ──┬── Big Five Factor ──── Big Five Facet
             ├── HEXACO Factor ──── HEXACO Facet
             ├── VIA Strength
             ├── Schwartz Value
             └── Reiss Desire
```

**Example: "Intellectual Curiosity"**
```yaml
model_mappings:
  big_five:
    factor: "Openness to Experience"
    facet: "Ideas"
    direction: "positive"
  hexaco:
    factor: "Openness to Experience"
    facet: "Inquisitiveness"
    direction: "positive"
  via:
    strength: "Curiosity"
  schwartz:
    value: "Self-Direction (thought)"
  reiss:
    desire: "Idealism"
```

---

### Framework Comparison Matrix

| Framework | # Dimensions | Focus | Strengths | Limitations |
|-----------|--------------|-------|-----------|-------------|
| **Big Five** | 5 factors, ~30 facets | Broad personality structure | Most validated, extensive research | Lacks Honesty-Humility |
| **HEXACO** | 6 factors, ~24 facets | Big Five + Honesty | Captures dark triad better | Newer, less research |
| **VIA** | 24 strengths | Positive psychology | Strength-based, practical | Not full personality coverage |
| **Schwartz** | 10 values | Core values & motivations | Cross-cultural validation | Values ≠ traits |
| **Reiss 16** | 16 basic desires | Motivational drivers | Practical for coaching | Less empirical validation |

---

### Domain-Specific Mappings

#### Emotional Domain (Emocional)

**Big Five: Neuroticism (inverse = Emotional Stability)**

| MMOS Trait (PT) | MMOS Trait (EN) | Big Five Facet | HEXACO Mapping |
|-----------------|-----------------|----------------|----------------|
| ansiedade | Anxiety | N1: Anxiety | Emotionality: Anxiety |
| medo | Fearfulness | N1: Anxiety | Emotionality: Fearfulness |
| depressividade | Depression | N2: Angry Hostility | Emotionality: (low) |
| vulnerabilidade | Vulnerability | N6: Vulnerability | Emotionality: Dependence |
| impulsividade | Impulsivity | N5: Impulsiveness | (Conscientiousness: low) |
| regulação_emocional | Emotional Regulation | (N inverse) | Emotionality (inverse) |

**VIA Character Strengths:**
- Emotional Intelligence
- Self-Regulation

**Reiss 16:**
- Tranquility (inverse of Anxiety)
- Social Contact (affiliation needs)

---

#### Social Domain (Social)

**Big Five: Extraversion & Agreeableness**

| MMOS Trait (PT) | MMOS Trait (EN) | Big Five Mapping | HEXACO Mapping |
|-----------------|-----------------|------------------|----------------|
| afabilidade | Warmth | E1: Warmth | Agreeableness: Gentleness |
| sociabilidade | Gregariousness | E2: Gregariousness | Extraversion: Sociability |
| assertividade | Assertiveness | E3: Assertiveness | Extraversion: Social Boldness |
| altruísmo | Altruism | A3: Altruism | Honesty-Humility: Altruism |
| modéstia | Modesty | A5: Modesty | Honesty-Humility: Modesty |
| confiança | Trust | A1: Trust | Agreeableness: Forgiveness |

**VIA Character Strengths:**
- Kindness
- Love
- Social Intelligence
- Teamwork

**Schwartz Values:**
- Benevolence (caring for close others)
- Universalism (concern for all people)

**Reiss 16:**
- Social Contact (need for companionship)
- Family (need for parenting)

---

#### Cognitive Domain (Cognitivo)

**Big Five: Openness to Experience**

| MMOS Trait (PT) | MMOS Trait (EN) | Big Five Mapping | HEXACO Mapping |
|-----------------|-----------------|------------------|----------------|
| imaginação | Imagination | O1: Fantasy | Openness: Aesthetic Appreciation |
| criatividade | Creativity | O2: Aesthetics, O4: Actions | Openness: Creativity |
| curiosidade | Curiosity | O5: Ideas | Openness: Inquisitiveness |
| abertura_intelectual | Intellectual Openness | O5: Ideas | Openness: Unconventionality |

**VIA Character Strengths:**
- Creativity
- Curiosity
- Love of Learning
- Perspective (wisdom)

**Schwartz Values:**
- Self-Direction (thought)
- Stimulation

**Reiss 16:**
- Idealism (need for meaning)
- Independence (need for autonomy)

---

#### Motivational Domain (Motivacional)

**Big Five: Conscientiousness (partially)**

| MMOS Trait (PT) | MMOS Trait (EN) | Big Five Mapping | HEXACO Mapping |
|-----------------|-----------------|------------------|----------------|
| ambição | Ambition | C4: Achievement Striving | Conscientiousness: (high) |
| organização | Organization | C2: Order | Conscientiousness: Organization |
| perfeccionismo | Perfectionism | C6: Deliberation | Conscientiousness: Perfectionism |
| resiliência | Resilience | (Neuroticism inverse) | Emotionality (inverse) |
| autodisciplina | Self-Discipline | C5: Self-Discipline | Conscientiousness: Diligence |

**VIA Character Strengths:**
- Perseverance
- Zest
- Hope
- Self-Regulation

**Schwartz Values:**
- Achievement
- Power

**Reiss 16:**
- Power (need for influence)
- Status (need for prestige)
- Acceptance (need for approval)

---

#### Moral/Values Domain (Moral)

**HEXACO: Honesty-Humility (primary)**

| MMOS Trait (PT) | MMOS Trait (EN) | HEXACO Mapping | Big Five |
|-----------------|-----------------|----------------|----------|
| honestidade | Honesty | H1: Sincerity | (not captured) |
| equidade | Fairness | H2: Fairness | A4: Compliance |
| humildade | Humility | H4: Modesty | A5: Modesty |
| integridade | Integrity | H (broad) | (not captured) |

**VIA Character Strengths:**
- Honesty
- Fairness
- Humility
- Forgiveness

**Schwartz Values:**
- Benevolence
- Universalism
- Conformity
- Tradition

**Reiss 16:**
- Honor (need for moral principles)

---

### Cross-Framework Translation Examples

#### Example 1: High Ansiedade (Anxiety)

**Profile:**
- **Big Five:** High Neuroticism (N1: Anxiety facet)
- **HEXACO:** High Emotionality (Anxiety facet)
- **VIA:** Low Self-Regulation
- **Reiss 16:** High need for Tranquility (unmet = anxiety)

**Interpretation:**
All frameworks converge on emotional vulnerability to stress and worry.

---

#### Example 2: High Criatividade (Creativity)

**Profile:**
- **Big Five:** High Openness (O2: Aesthetics, O4: Actions)
- **HEXACO:** High Openness (Creativity facet)
- **VIA:** High Creativity strength
- **Schwartz:** High Self-Direction, Stimulation values
- **Reiss 16:** High Idealism

**Interpretation:**
Converges on openness to novel experiences and creative expression.

---

#### Example 3: Low Altruísmo (Low Altruism)

**Profile:**
- **Big Five:** Low Agreeableness (A3: Altruism facet)
- **HEXACO:** Low Honesty-Humility (H3: Greed Avoidance inverse)
- **VIA:** Low Kindness, low Fairness
- **Schwartz:** Low Benevolence, low Universalism
- **Reiss 16:** High Power, low Idealism

**Interpretation:**
HEXACO captures this better than Big Five (Honesty-Humility dimension). Suggests potential for exploitative behavior if extreme.

---

### Integration Benefits

1. **Comprehensive Coverage:** HEXACO fills Big Five gaps (Honesty-Humility)
2. **Positive Psychology:** VIA adds strength-based framing
3. **Values & Motivation:** Schwartz and Reiss add motivational depth
4. **Cross-Validation:** Multiple frameworks confirm trait presence
5. **Research Linkage:** Connect to vast scientific literature
6. **Clinical Translation:** Map to DSM-5/ICD-11 when relevant

---

### Mapping Template

```yaml
model_mappings:
  big_five:
    factor: "Factor Name"
    facet: "Facet Name"  # or null if broad factor
    direction: "positive"  # or "negative" for inverse
    correlation: 0.75  # Optional: expected correlation
  hexaco:
    factor: "Factor Name"
    facet: "Facet Name"
    direction: "positive"
  via:
    strength: "Strength Name"  # or null if no mapping
    rank_expectation: "high"  # high, medium, low
  schwartz:
    value: "Value Name"  # or null
    priority: "high"  # high, medium, low
  reiss:
    desire: "Desire Name"  # or null
    intensity: "high"  # high, medium, low
```

---

## 🖥️ Computational Ontologies

### Overview

Computational ontologies enable **machine-readable** trait definitions for interoperability with research databases, clinical systems, and semantic web applications.

### Supported Ontologies

#### 1. IPIP (International Personality Item Pool)

**Purpose:** Public-domain personality items mapped to Big Five and other models

**URL:** https://ipip.ori.org/

**Integration:**
```yaml
computational_ontology:
  ipip_code: "A1"  # Agreeableness scale 1
  ipip_items:
    - "I feel others' emotions"
    - "I am interested in other people's problems"
```

**Usage:**
- Generate assessment items
- Cross-reference with research studies using IPIP
- Public-domain alternative to proprietary instruments (NEO-PI-R)

---

#### 2. FacetMap

**Purpose:** Network visualization of personality trait relationships

**URL:** http://www.facetmap.org/

**Integration:**
```yaml
computational_ontology:
  facetmap_uri: "http://www.facetmap.org/trait/anxiety"
```

**Features:**
- Visual trait networks
- Correlation matrices
- Hierarchical factor structures

---

#### 3. OWL (Web Ontology Language)

**Purpose:** Semantic web ontology for trait definitions

**Integration:**
```yaml
computational_ontology:
  owl_class: "PersonalityTrait:Anxiety"
  owl_ontology: "http://mmos.ai/ontology/traits.owl"
  rdfs_label: "Anxiety Trait"
  rdfs_comment: "Tendency toward worry and fear"
```

**RDF Triple Example:**
```turtle
@prefix mmos: <http://mmos.ai/ontology/> .
@prefix big5: <http://big5.org/ontology/> .

mmos:anxiety a mmos:PersonalityTrait ;
  rdfs:label "Anxiety" ;
  mmos:domain "emotional" ;
  mmos:mapsTo big5:NeuroticismAnxiety ;
  mmos:inverseOf mmos:emotional_stability .
```

---

#### 4. Wikidata

**Purpose:** Structured data from Wikipedia for entity linking

**Integration:**
```yaml
computational_ontology:
  wikidata_id: "Q378835"  # Wikidata ID for Anxiety
```

**Usage:**
- Link to multilingual descriptions
- Cross-reference with other knowledge bases
- Enrich with structured data (e.g., related conditions, researchers)

---

#### 5. SNOMED CT (Clinical Terms)

**Purpose:** Clinical healthcare terminology for traits with medical relevance

**Integration:**
```yaml
computational_ontology:
  snomed_ct: "48694002"  # SNOMED code for Anxiety disorder
```

**Use Cases:**
- Clinical system integration
- EHR (Electronic Health Record) compatibility
- ICD-10/11 mapping for diagnostic codes

---

#### 6. DBpedia

**Purpose:** Structured content from Wikipedia

**Integration:**
```yaml
computational_ontology:
  dbpedia_uri: "http://dbpedia.org/resource/Big_Five_personality_traits"
```

---

### Ontology Use Cases

#### Research Interoperability

```python
# Query all studies measuring "Anxiety" across different frameworks
SELECT ?study ?instrument ?trait
WHERE {
  ?study research:measures ?trait .
  ?trait owl:equivalentClass mmos:anxiety .
  ?study research:uses ?instrument .
}
```

#### Clinical Integration

```python
# Map MMOS trait to ICD-11 diagnostic codes
if trait_score["anxiety"] > 90:
    icd_code = ontology.map("anxiety", "ICD11")
    # Returns: 6B00 (Generalized Anxiety Disorder)
```

#### Meta-Analysis

```python
# Aggregate findings from studies using different trait names
traits = ontology.get_equivalent_traits("anxiety")
# Returns: ["neuroticism_anxiety", "hexaco_anxiety", "trait_anxiety"]
```

---

### Creating an MMOS Ontology

**File:** `docs/mmos/ontology/traits.owl`

```xml
<?xml version="1.0"?>
<rdf:RDF xmlns="http://mmos.ai/ontology#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:owl="http://www.w3.org/2002/07/owl#">

  <!-- Class Definitions -->
  <owl:Class rdf:about="http://mmos.ai/ontology#PersonalityTrait">
    <rdfs:label>Personality Trait</rdfs:label>
    <rdfs:comment>A stable characteristic pattern of thinking, feeling, or behaving</rdfs:comment>
  </owl:Class>

  <!-- Individual Trait: Anxiety -->
  <owl:NamedIndividual rdf:about="http://mmos.ai/ontology#anxiety">
    <rdf:type rdf:resource="http://mmos.ai/ontology#PersonalityTrait"/>
    <rdfs:label xml:lang="en">Anxiety</rdfs:label>
    <rdfs:label xml:lang="pt">Ansiedade</rdfs:label>
    <mmos:domain>emotional</mmos:domain>
    <mmos:code>21</mmos:code>
    <owl:sameAs rdf:resource="http://big5.org/neuroticism/anxiety"/>
    <owl:sameAs rdf:resource="http://hexaco.org/emotionality/anxiety"/>
  </owl:NamedIndividual>

</rdf:RDF>
```

---

## 🤖 Automated Detection Patterns

### Detection Architecture

```
Input Sources
    ↓
Multimodal Collectors
    ↓
Feature Extraction
    ↓
ML Models + Rule-Based
    ↓
Confidence Scoring
    ↓
Trait Score (0-100)
```

### Detection Pipeline

#### Stage 1: Data Collection

**Sources:**
- Text: Blogs, articles, books, tweets, transcripts
- Audio: Podcast/interview transcripts (via Whisper)
- Video: Meeting recordings (visual + audio)
- Behavioral: GitHub commits, calendar patterns, email metadata

#### Stage 2: Feature Extraction

**Text Features:**
```python
features = {
    "linguistic_markers": count_markers(text, trait.linguistic_markers),
    "sentiment": analyze_sentiment(text),
    "lexical_diversity": calculate_diversity(text),
    "syntax_complexity": analyze_syntax(text),
    "topic_modeling": extract_topics(text),
    "embeddings": get_embeddings(text, model="bert")
}
```

**Behavioral Features:**
```python
features = {
    "response_times": calculate_avg_response_time(messages),
    "message_length": avg_message_length(messages),
    "initiation_rate": count_initiated_conversations(messages),
    "group_participation": calc_group_participation_rate(messages)
}
```

#### Stage 3: Detection Models

**Rule-Based Detection:**
```python
def detect_anxiety_rule_based(text, markers):
    score = 0

    # Count linguistic markers
    for word in markers["palavras_frequentes"]:
        score += text.lower().count(word) * 2

    # Regex pattern matching
    for pattern in markers["construções_frasais"]:
        score += len(re.findall(pattern, text)) * 5

    # Normalize to 0-100
    return min(score / max_expected_score * 100, 100)
```

**ML-Based Detection:**
```python
from transformers import pipeline

classifier = pipeline("text-classification",
                      model="bert-base-multilingual-cased-finetuned-traits")

def detect_anxiety_ml(text):
    result = classifier(text, candidate_labels=["anxious", "calm"])
    anxiety_score = result["scores"][0] * 100
    return anxiety_score
```

**Hybrid Approach:**
```python
def detect_trait(text, trait):
    rule_score = detect_rule_based(text, trait)
    ml_score = detect_ml(text, trait)

    # Weighted combination
    final_score = (rule_score * 0.4) + (ml_score * 0.6)

    # Confidence based on agreement
    confidence = 1.0 - abs(rule_score - ml_score) / 100

    return {
        "score": final_score,
        "confidence": confidence,
        "rule_score": rule_score,
        "ml_score": ml_score
    }
```

#### Stage 4: Confidence Scoring

**Factors Increasing Confidence:**
- ✅ Multiple data sources converge (text + behavior)
- ✅ Patterns consistent over time (>6 months)
- ✅ High volume of data (>10,000 words analyzed)
- ✅ Rule-based and ML scores agree (diff <15 points)
- ✅ Explicit self-reported statements

**Factors Decreasing Confidence:**
- ❌ Single data source only
- ❌ Limited data (<1,000 words)
- ❌ Contradictory signals
- ❌ Strong situational context (may be temporary)
- ❌ Impression management detected

---

### Multimodal Detection Examples

#### Example 1: Introversion Detection

**Text Signals:**
```python
text_score = analyze_text(blog_posts, patterns={
    "self_references": ["I prefer", "I need time alone"],
    "social_avoidance": ["social events drain me", "I recharge alone"]
})
```

**WhatsApp Signals:**
```python
whatsapp_score = analyze_whatsapp(messages, indicators={
    "response_time": avg_response_time > 2_hours,
    "message_length": avg_length < 50_chars,
    "initiation_rate": initiation_rate < 0.2,
    "group_participation": group_participation < 0.1
})
```

**Meeting Signals:**
```python
meeting_score = analyze_meetings(recordings, indicators={
    "camera_off_rate": camera_off > 0.7,
    "speaking_time": speaking_time < 10_percent,
    "voluntary_participation": voluntary_participation < 0.3
})
```

**Combined Score:**
```python
scores = [text_score, whatsapp_score, meeting_score]
weights = [0.4, 0.3, 0.3]
final_score = weighted_average(scores, weights)
confidence = calculate_confidence(scores)  # Higher if scores agree
```

---

#### Example 2: Risk Tolerance Detection

**Text Signals:**
```python
patterns = {
    "risk_seeking": [
        "I bet on",
        "calculated risk",
        "trust the exponential",
        "contrarian",
        "10x potential"
    ],
    "uncertainty_comfort": [
        "embrace uncertainty",
        "thrive in chaos",
        "first-mover advantage"
    ]
}
```

**Behavioral Signals (for tech founders):**
```python
behavioral_indicators = {
    "startup_founding": founded_companies > 0,  # +20 points
    "investment_profile": invests_in_startups,  # +15 points
    "career_moves": career_pivots > 2,  # +10 points
    "public_statements": analyzes_statements()  # 0-40 points
}
```

**Decision Pattern Analysis:**
```python
decision_patterns = analyze_decisions(blog_posts, indicators={
    "speed": "makes decisions quickly with incomplete info",
    "magnitude": "pursues high-upside, high-risk opportunities",
    "frequency": "takes multiple bets simultaneously"
})
```

---

### Detection Implementation

**Python Class:**
```python
class TraitDetector:
    def __init__(self, trait_config):
        self.trait = trait_config
        self.rule_engine = RuleBasedDetector(trait_config)
        self.ml_model = MLDetector(trait_config)

    def detect(self, sources: Dict[str, Any]) -> Dict:
        scores = {}

        # Detect from each source
        if "text" in sources:
            scores["text"] = self.detect_from_text(sources["text"])

        if "whatsapp" in sources:
            scores["whatsapp"] = self.detect_from_whatsapp(sources["whatsapp"])

        if "meetings" in sources:
            scores["meetings"] = self.detect_from_meetings(sources["meetings"])

        # Aggregate
        final_score = self.aggregate_scores(scores)
        confidence = self.calculate_confidence(scores)

        # Check threshold
        if confidence < self.trait["detection_confidence_threshold"]:
            return {
                "score": None,
                "confidence": confidence,
                "status": "insufficient_confidence",
                "detail_scores": scores
            }

        return {
            "score": final_score,
            "confidence": confidence,
            "status": "detected",
            "detail_scores": scores,
            "evidence": self.extract_evidence(sources)
        }

    def detect_from_text(self, text: str) -> float:
        rule_score = self.rule_engine.detect(text)
        ml_score = self.ml_model.detect(text)
        return (rule_score * 0.4) + (ml_score * 0.6)
```

---

## 🛡️ Ethical Considerations

### Privacy Framework

#### Privacy Levels

**Level 1: Public (Low Sensitivity)**
- Traits: Curiosity, Creativity, Analytical Thinking
- Display: Public profiles allowed
- Consent: Implied consent sufficient
- Usage: Marketing, recommendations, public research

**Level 2: Private (Moderate Sensitivity)**
- Traits: Most personality traits (Introversion, Risk Tolerance, etc.)
- Display: Require explicit user consent
- Consent: Opt-in with clear explanation
- Usage: Personal insights, controlled sharing

**Level 3: Sensitive (High Sensitivity)**
- Traits: Anxiety, Low Self-Esteem, Impulsivity
- Display: Never without user initiation
- Consent: Explicit informed consent required
- Usage: Personal insights only, strong encryption

**Level 4: Clinical (Medical Sensitivity)**
- Traits: Depression indicators, pathological patterns
- Display: Licensed professionals only
- Consent: Clinical consent forms (HIPAA/GDPR compliant)
- Usage: Clinical diagnosis/treatment only

---

### Ethical Guidelines

#### 1. Informed Consent

**Requirements:**
```yaml
consent_requirements:
  information_disclosure:
    - "What traits are being measured"
    - "What data sources are used"
    - "How traits will be inferred"
    - "Who will have access"
    - "How data can be deleted"
  explicit_consent:
    - "User must actively opt-in (no pre-checked boxes)"
    - "Separate consent for sensitive traits"
    - "Consent can be withdrawn at any time"
  comprehension_check:
    - "Verify user understands before proceeding"
```

**Example Consent Flow:**
```
We will analyze your blog posts, tweets, and public interviews to
infer personality traits including:
- Cognitive traits (e.g., Analytical Thinking, Creativity)
- Social traits (e.g., Extraversion, Collaboration Style)
- Motivation traits (e.g., Achievement Drive)

☐ I understand and consent to personality trait analysis

We will also analyze sensitive traits including:
- Emotional patterns (e.g., Anxiety, Emotional Stability)

⚠️ These traits may reveal mental health information.

☐ I understand the sensitivity and consent to emotional trait analysis
```

---

#### 2. Right to Explanation

**Users have the right to know:**
- Which trait scores they have
- What evidence was used
- How the score was calculated
- Why the score is what it is

**Implementation:**
```python
def explain_trait_score(mind_id, trait_code):
    score = get_trait_score(mind_id, trait_code)
    evidence = get_evidence(mind_id, trait_code)

    explanation = {
        "trait": trait_code,
        "score": score.value,
        "interpretation": interpret_score(score),
        "evidence": {
            "sources": evidence.sources,  # ["blog_post_1", "interview_2"]
            "quotes": evidence.quotes[:5],  # Top 5 supporting quotes
            "patterns": evidence.patterns,  # Detected linguistic patterns
            "confidence": score.confidence
        },
        "methodology": "Hybrid NLP (40% rule-based, 60% ML)",
        "can_contest": True
    }

    return explanation
```

---

#### 3. Right to Contest

**Users can:**
- Challenge incorrect trait scores
- Provide counter-evidence
- Request manual review
- Exclude specific data sources

**Contest Process:**
```yaml
contest_process:
  step1_submit:
    - "User submits contest with explanation"
  step2_review:
    - "System re-analyzes with contested evidence excluded"
    - "Human reviewer examines edge cases"
  step3_decision:
    - "Score adjusted OR contest denied with explanation"
  step4_appeal:
    - "User can appeal to senior reviewer"
```

---

#### 4. Data Minimization

**Principles:**
- Collect only data necessary for trait inference
- Delete raw data after trait scoring (retain only aggregates)
- Minimize retention period (e.g., 90 days for raw data)

**Example:**
```python
# GOOD: Retain only aggregate statistics
trait_evidence = {
    "linguistic_marker_counts": {"anxiety_words": 47, "hedge_words": 23},
    "average_sentiment": -0.15,
    "pattern_matches": 12
}

# BAD: Retaining full raw text indefinitely
# raw_text = "..." # 10MB of private messages
```

---

#### 5. Algorithmic Fairness

**Bias Mitigation:**

**Gender Bias:**
```python
# Don't use gender as a feature
# DO adjust for known research biases
def adjust_for_gender_bias(trait, score, gender):
    if trait == "anxiety" and gender == "female":
        # Research shows small gender difference (d=0.40)
        # but individual variance >> group variance
        # DO NOT adjust score
        pass
    return score
```

**Cultural Bias:**
```yaml
cultural_adjustments:
  assertiveness:
    note: "Assertiveness norms vary by culture"
    adjustment: "Compare to cultural baseline, not universal norm"
    example: "Score of 40 may be 'average' in Japan, 'low' in USA"
```

**Language Bias:**
```yaml
language_considerations:
  multilingual_support:
    - "Train models on multiple languages"
    - "Don't penalize non-native speakers"
  idiom_handling:
    - "Culture-specific expressions need localized patterns"
```

---

#### 6. No Discrimination

**Prohibited Uses:**
```yaml
prohibited_uses:
  employment:
    - "Using trait scores for hiring decisions (without validation)"
    - "Firing based on personality traits"
  insurance:
    - "Adjusting premiums based on personality"
  credit:
    - "Denying loans based on traits"
  housing:
    - "Denying housing based on personality"
```

**Allowed Uses:**
```yaml
allowed_uses:
  personal_development:
    - "Self-insight and growth"
  coaching:
    - "Personalized coaching with consent"
  research:
    - "Aggregate, de-identified research"
  matching:
    - "Team compatibility (with consent of all parties)"
```

---

#### 7. Security Requirements

**Data Protection:**
```yaml
security_requirements:
  encryption:
    in_transit: "TLS 1.3+"
    at_rest: "AES-256"
  access_control:
    authentication: "Multi-factor required for sensitive traits"
    authorization: "Role-based access control"
    audit_logs: "All access logged and monitored"
  anonymization:
    research_data: "K-anonymity (k≥5) for research datasets"
    public_aggregates: "No cell sizes <10"
```

---

### Ethical Review Checklist

Before deploying trait detection:

- [ ] Privacy impact assessment completed
- [ ] Informed consent process designed and tested
- [ ] Right to explanation implemented
- [ ] Contest/appeal process established
- [ ] Data minimization policies enforced
- [ ] Bias testing completed across demographics
- [ ] Security audit passed
- [ ] Legal review (GDPR/HIPAA/LGPD compliance)
- [ ] Ethics committee approval (if research context)
- [ ] User testing with diverse participants

---

## 🎨 Design Guidelines

### Trait Selection Principles

#### 1. **Relevance to Mind Profiling**
- Does this trait help differentiate between minds?
- Is it observable/inferable from public sources (blogs, interviews, writing)?
- Does it contribute to the 94% fidelity goal?

#### 2. **Scientific Validity**
- Is the trait grounded in psychological research?
- Can it be mapped to established frameworks?
- Is the construct well-defined and measurable?

#### 3. **Orthogonality (Independence)**
- Is this trait distinct from other traits in the taxonomy?
- Avoid redundancy (e.g., don't have "Risk Tolerance" and "Risk-Taking Behavior" as separate if they measure the same thing)
- Test: If two traits correlate >0.85, consider merging

#### 4. **Actionability**
- Can this trait inform system prompt parameters?
- Does it have clear behavioral implications?
- Is it useful for creating AI clones?

### Coverage Strategy

**Core Coverage (Must-Have):**
- ✅ Big Five personality traits + facets (~35 traits)
- ✅ DNA Mental™ 8-layer specific traits (~15-20 traits)
- ✅ Decision-making styles (~5 traits)
- ✅ Cognitive styles (~5 traits)

**Extended Coverage (Nice-to-Have):**
- 🟡 Domain-specific expertise traits (~10 traits)
- 🟡 Communication styles (~5 traits)
- 🟡 Leadership traits (~5 traits)
- 🟡 Creative/innovative thinking (~5 traits)

**Total Target:** 60-80 traits

### Naming Conventions

**DO:**
- ✅ Use established psychological terminology when possible
- ✅ Be specific and descriptive
- ✅ Use Title Case consistently
- ✅ Keep names concise (2-4 words)

**DON'T:**
- ❌ Invent jargon unnecessarily
- ❌ Use vague terms ("Personality Type 1")
- ❌ Use acronyms without explanation (unless widely known like "IQ")
- ❌ Mix naming styles (stick to nouns, not verbs)

### Scale Design

**Bipolar Scales (Recommended):**
Most traits should have clear opposite poles:
```
Low Pole ←──────────────────→ High Pole
(scale_min_label)         (scale_max_label)
```

**Examples:**
- Risk Averse ↔ Risk Seeking
- Intuitive ↔ Analytical
- Present-focused ↔ Future-focused

**Unipolar Scales (Use Sparingly):**
Some traits may measure presence/absence:
```
Absent/Low ←──────────────────→ Present/High
```

**Examples:**
- Low Empathy ↔ High Empathy
- Low Grit ↔ High Grit

**Guidelines:**
- Prefer bipolar scales (more informative)
- Ensure poles are semantically opposite
- Use neutral, non-judgmental language
- Both poles should represent valid approaches (not "good" vs "bad")

### Domain Balance

Aim for balanced coverage across domains:

| Domain | Target Count | Percentage |
|--------|--------------|------------|
| cognitive | 12-15 | 20% |
| emotional | 10-12 | 15% |
| motivation | 10-12 | 15% |
| social | 10-12 | 15% |
| behavioral | 12-15 | 20% |
| values | 8-10 | 12% |
| other | 2-4 | 3% |
| **Total** | **60-80** | **100%** |

---

## 📝 YAML Templates

### Basic Database Template (Minimal)

**Purpose:** For database `traits` table population (core fields only)

```yaml
- code: 1
  name: "Trait Name Here"
  description: "Clear, concise description of what this trait measures. Should be 1-3 sentences explaining the psychological construct."
  domain: "cognitive"  # or emotional, motivation, social, behavioral, values, other
  subdomain: "reasoning"  # Optional: specific subcategory
  scale_min_label: "Low Pole Label"
  scale_max_label: "High Pole Label"
  related_frameworks: '["Framework: Factor", "Another: Factor"]'  # Optional
  inverse_of: null  # or trait code number
  version: "1.0"
```

---

### Extended Detection Template (Complete)

**Purpose:** For AI detection systems and computational models (all advanced fields)

```yaml
# ══════════════════════════════════════════════════════════════
# TRAIT: [Trait Name]
# Domain: [domain]
# Version: 2.0
# ══════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────
# Core Database Fields
# ─────────────────────────────────────────────────────────────
code: 1
canonical: "trait_canonical_name"
name: "Trait Name"
description: |
  Clear, concise description of what this trait measures.
  1-3 sentences explaining the psychological construct.
domain: "cognitive"  # cognitive, emotional, motivation, social, behavioral, values
subdomain: "reasoning"  # Optional subcategory
scale_min_label: "Low Pole Label"
scale_max_label: "High Pole Label"
related_frameworks: '["Big Five: Factor", "HEXACO: Factor"]'
inverse_of: null
version: "2.0"

# ─────────────────────────────────────────────────────────────
# Advanced Detection Fields
# ─────────────────────────────────────────────────────────────

aliases:
  - "alternative name 1"
  - "nome em português"
  - "colloquial term"

psychometric_type: "traço"  # traço, valor, motivação, virtude, habilidade, estilo

validation_criteria: |
  Detailed behavioral markers and observational criteria.

  Behavioral markers: [describe observable behaviors]

  Communication style: [describe communication patterns]

  Decision-making: [describe decision patterns]

  Contextual indicators: [describe situational responses]

detection_confidence_threshold: 0.75  # 0.0-1.0

linguistic_markers:
  palavras_frequentes:
    - "palavra1"
    - "palavra2"
    - "palavra3"
  construções_frasais:
    - "padrão regex 1"
    - "padrão regex 2"
  intensificadores:
    - "muito"
    - "extremamente"
  hedges:
    - "talvez"
    - "possivelmente"
  negações:
    - "nunca"
    - "jamais"
  tópicos_recorrentes:
    - "tópico1"
    - "tópico2"

detection_patterns:
  text_patterns:
    - "text pattern 1"
    - "text pattern 2"
  behavioral_markers:
    - "behavioral marker 1"
    - "behavioral marker 2"
  communication_style:
    - "communication style 1"
  decision_indicators:
    - "decision indicator 1"
  temporal_patterns:
    - "temporal pattern 1"

multimodal_indicators:
  whatsapp:
    - "WhatsApp indicator 1"
    - "WhatsApp indicator 2"
  meetings:
    - "meetings indicator 1"
    - "meetings indicator 2"
  documents:
    - "documents indicator 1"
  code:
    - "code indicator 1"
  social_media:
    - "social media indicator 1"
  calendar:
    - "calendar indicator 1"

activation_trigger: "Situational contexts that activate this trait"

related_traits:
  - "related_trait_1"
  - "related_trait_2"

inverse_traits:
  - "inverse_trait_1"
  - "inverse_trait_2"

model_mappings:
  big_five:
    factor: "Factor Name"
    facet: "Facet Name"  # or null
    direction: "positive"  # or "negative"
    correlation: 0.75  # optional
  hexaco:
    factor: "Factor Name"
    facet: "Facet Name"
    direction: "positive"
  via:
    strength: "Strength Name"  # or null
    rank_expectation: "high"  # high, medium, low
  schwartz:
    value: "Value Name"  # or null
    priority: "high"
  reiss:
    desire: "Desire Name"  # or null
    intensity: "high"

facet_of: null  # or "parent_trait_canonical"

measurement_instruments:
  - name: "NEO-PI-R"
    scale: "Scale Name"
    items: 8
    citation: "Author, Year"
  - name: "HEXACO-PI-R"
    scale: "Scale Name"
    items: 10
    citation: "Author, Year"

prevalence_distribution:
  mean: 50.0
  std_dev: 15.0
  percentiles:
    p10: 30.0
    p25: 40.0
    p50: 50.0
    p75: 60.0
    p90: 70.0
  source: "Research citation"

development_trajectory: "How this trait develops across the lifespan"

gender_differences: "Any gender differences (if relevant and validated)"  # or null

cultural_considerations: "How this trait manifests across cultures"

clinical_relevance: "Clinical significance (DSM-5/ICD-11 references if applicable)"  # or null

privacy_sensitivity: "private"  # public, private, sensitive, clinical

computational_ontology:
  ipip_code: "A1"  # or null
  facetmap_uri: "http://www.facetmap.org/trait/..."  # or null
  owl_class: "PersonalityTrait:TraitName"  # or null
  wikidata_id: "Q123456"  # or null
  snomed_ct: "12345678"  # or null (for clinical traits)

confidence_modifiers:
  increase:
    - "factor that increases confidence"
    - "another factor"
  decrease:
    - "factor that decreases confidence"
    - "another factor"

false_positive_risks:
  - "scenario that may cause false positive"
  - "another scenario"

nlp_config:
  min_document_length: 500
  context_window: 50
  sentiment_weight: 0.3
  frequency_weight: 0.4
  pattern_weight: 0.3
  models:
    - "bert-base-multilingual-cased"
    - "gpt-3.5-turbo"
  preprocessing:
    - "lowercase"
    - "remove_punctuation"
    - "lemmatization"

update_history:
  - version: "2.0"
    date: "2025-10-13"
    changes: "Added advanced detection fields"
    author: "Product Owner"
  - version: "1.0"
    date: "2025-06-01"
    changes: "Initial definition"
    author: "Database Architect"
```

### Complete YAML File Template

```yaml
# ══════════════════════════════════════════════════════════════
# MMOS Traits Taxonomy - Seed Data
# Version: 1.0.0
# Date: YYYY-MM-DD
# Total Traits: XX
# ══════════════════════════════════════════════════════════════

traits:
  # ══════════════════════════════════════════════════════════════
  # COGNITIVE TRAITS (1-20)
  # ══════════════════════════════════════════════════════════════

  - code: 1
    name: "Analytical Reasoning"
    description: "The capacity to break down complex problems into logical components, identify patterns, and derive conclusions through systematic thinking rather than intuition."
    domain: "cognitive"
    subdomain: "reasoning"
    scale_min_label: "Intuitive"
    scale_max_label: "Analytical"
    related_frameworks: '["Big Five: Openness (Intellect)", "MBTI: Thinking (T)"]'
    inverse_of: null
    version: "1.0"

  - code: 2
    name: "Abstract Thinking"
    description: "Ability to work with concepts, ideas, and theories rather than concrete, tangible information. Comfort with complexity and ambiguity."
    domain: "cognitive"
    subdomain: "reasoning"
    scale_min_label: "Concrete"
    scale_max_label: "Abstract"
    related_frameworks: '["Big Five: Openness", "Cognitive Styles: Abstract vs Concrete"]'
    inverse_of: null
    version: "1.0"

  # ... Add more cognitive traits (3-20)

  # ══════════════════════════════════════════════════════════════
  # EMOTIONAL TRAITS (21-40)
  # ══════════════════════════════════════════════════════════════

  - code: 21
    name: "Emotional Regulation"
    description: "Capacity to manage and modulate emotional responses, maintaining composure under stress and preventing emotional reactions from disrupting judgment."
    domain: "emotional"
    subdomain: "regulation"
    scale_min_label: "Reactive"
    scale_max_label: "Composed"
    related_frameworks: '["Big Five: Neuroticism (inverse)", "Emotional Intelligence"]'
    inverse_of: null
    version: "1.0"

  # ... Add more emotional traits (22-40)

  # ══════════════════════════════════════════════════════════════
  # MOTIVATION TRAITS (41-60)
  # ══════════════════════════════════════════════════════════════

  - code: 41
    name: "Achievement Drive"
    description: "Strong internal motivation to accomplish difficult goals, excel in one's field, and pursue mastery. Intrinsic desire for accomplishment beyond external rewards."
    domain: "motivation"
    subdomain: "achievement"
    scale_min_label: "Content"
    scale_max_label: "Driven"
    related_frameworks: '["Big Five: Conscientiousness", "Achievement Motivation Theory"]'
    inverse_of: null
    version: "1.0"

  # ... Add more motivation traits (42-60)

  # ══════════════════════════════════════════════════════════════
  # SOCIAL TRAITS (61-80)
  # ══════════════════════════════════════════════════════════════

  - code: 61
    name: "Extraversion"
    description: "Tendency to seek social interaction, draw energy from others, and engage actively in group settings. Comfort with being the center of attention."
    domain: "social"
    subdomain: "relationships"
    scale_min_label: "Reserved"
    scale_max_label: "Outgoing"
    related_frameworks: '["Big Five: Extraversion", "MBTI: Extraversion (E)", "Eysenck: Extraversion"]'
    inverse_of: null
    version: "1.0"

  # ... Add more social traits (62-80)

  # ══════════════════════════════════════════════════════════════
  # BEHAVIORAL TRAITS (81-100)
  # ══════════════════════════════════════════════════════════════

  - code: 81
    name: "Risk Tolerance"
    description: "Willingness to embrace uncertainty and potential loss in pursuit of significant gains. Comfort with calculated risks in business, career, and personal decisions."
    domain: "behavioral"
    subdomain: "decision_making"
    scale_min_label: "Risk Averse"
    scale_max_label: "Risk Seeking"
    related_frameworks: '["Big Five: Openness (Experience-seeking)", "Sensation Seeking Scale"]'
    inverse_of: null
    version: "1.0"

  # ... Add more behavioral traits (82-100)

  # ══════════════════════════════════════════════════════════════
  # VALUES TRAITS (101-120)
  # ══════════════════════════════════════════════════════════════

  - code: 101
    name: "Intellectual Honesty"
    description: "Commitment to truth-seeking, willingness to acknowledge errors, and resistance to self-deception or motivated reasoning. Values accuracy over being right."
    domain: "values"
    subdomain: "truth_seeking"
    scale_min_label: "Confirmation-seeking"
    scale_max_label: "Truth-seeking"
    related_frameworks: '["Big Five: Openness", "Epistemic Virtues"]'
    inverse_of: null
    version: "1.0"

  # ... Add more values traits (102-120)
```

---

## 💡 Examples

### Example 1: Complete Cognitive Trait

```yaml
- code: 5
  name: "First-Principles Thinking"
  description: "Tendency to break down problems to fundamental truths and reason upward from basic principles, rather than reasoning by analogy or convention. Comfort with questioning assumptions."
  domain: "cognitive"
  subdomain: "reasoning"
  scale_min_label: "Analogical"
  scale_max_label: "First-Principles"
  related_frameworks: '["Scientific Reasoning", "Critical Thinking"]'
  inverse_of: null
  version: "1.0"
```

**Scoring interpretation:**
- **Score 85:** Consistently questions assumptions, builds arguments from foundational truths (Elon Musk)
- **Score 50:** Balances first-principles with analogical reasoning
- **Score 15:** Prefers using established patterns and analogies to solve problems

---

### Example 2: Behavioral Trait with Inverse

```yaml
- code: 85
  name: "Decision Velocity"
  description: "Speed at which decisions are made. Preference for rapid decision-making and bias toward action, even with incomplete information."
  domain: "behavioral"
  subdomain: "decision_making"
  scale_min_label: "Deliberate"
  scale_max_label: "Decisive"
  related_frameworks: '["Cognitive Styles: Impulsive vs Reflective"]'
  inverse_of: 86
  version: "1.0"

- code: 86
  name: "Decision Deliberation"
  description: "Preference for thorough analysis and consideration before making decisions. Values gathering complete information over speed."
  domain: "behavioral"
  subdomain: "decision_making"
  scale_min_label: "Decisive"
  scale_max_label: "Deliberate"
  related_frameworks: '["Cognitive Styles: Reflective"]'
  inverse_of: null  # Don't double-reference
  version: "1.0"
```

---

### Example 3: Values Trait with Framework Mapping

```yaml
- code: 105
  name: "Autonomy Value"
  description: "Importance placed on independence, self-direction, and freedom from external control. Preference for making own decisions without oversight or consensus."
  domain: "values"
  subdomain: "agency"
  scale_min_label: "Collaborative"
  scale_max_label: "Independent"
  related_frameworks: '["Self-Determination Theory: Autonomy", "Big Five: Openness", "Individualism-Collectivism"]'
  inverse_of: null
  version: "1.0"
```

---

### Example 4: DNA Mental™ Specific Trait

```yaml
- code: 10
  name: "Long-term Thinking"
  description: "Capacity to maintain focus on goals and outcomes spanning years or decades, resisting short-term temptations. Comfort with delayed gratification."
  domain: "cognitive"
  subdomain: "temporal_orientation"
  scale_min_label: "Present-focused"
  scale_max_label: "Future-focused"
  related_frameworks: '["Time Perspective Theory", "Delay of Gratification", "Big Five: Conscientiousness"]'
  inverse_of: null
  version: "1.0"
```

**DNA Mental™ Context:**
Maps to Layer 5 (Mental Models) and Layer 6 (Values Hierarchy). Critical for sam_altman profile.

---

### Real-World Examples from Research

These examples are based on the comprehensive catalog of atomic human characteristics integrating Big Five, HEXACO, VIA, Schwartz Values, and Reiss 16 Basic Desires.

---

#### Example 1: Ansiedade (Anxiety) - COMPLETE

```yaml
# ══════════════════════════════════════════════════════════════
# TRAIT: Ansiedade (Anxiety)
# Domain: Emotional
# Version: 2.0
# ══════════════════════════════════════════════════════════════

# Core Database Fields
code: 21
canonical: "ansiedade"
name: "Ansiedade"
description: |
  Tendência a preocupação intensa, antecipação de cenários negativos e
  hipervigilância a ameaças potenciais. Caracteriza-se por estado emocional
  de apreensão, tensão e desconforto diante de incertezas ou situações
  percebidas como ameaçadoras.
domain: "emotional"
subdomain: "regulation"
scale_min_label: "Calmo"
scale_max_label: "Ansioso"
related_frameworks: '["Big Five: Neuroticism - Anxiety", "HEXACO: Emotionality - Anxiety"]'
inverse_of: null
version: "2.0"

# Advanced Detection Fields

aliases:
  - "anxiety"
  - "ansiedad"
  - "preocupação crônica"
  - "nervosismo"
  - "inquietação"

psychometric_type: "traço"

validation_criteria: |
  Linguagem repleta de termos negativos, hiperatenção a cenários catastróficos,
  menção recorrente de incertezas, uso frequente de expressões de dúvida
  ("e se...?", "será que...?", "tenho medo que...").

  Comportamentalmente: evitação de situações desconhecidas, necessidade de
  controle excessivo sobre o ambiente, procrastinação por medo de erro,
  busca constante de reasseguramento.

  Em contextos de decisão: paralisia por análise, necessidade de validação
  externa frequente, preferência por "jogar seguro" mesmo com baixo risco real,
  dificuldade em tomar decisões sem ter todas as informações.

  Padrões de comunicação: respostas longas e circularmente justificadas,
  antecipação de problemas futuros antes mesmo de surgirem, redirecionamento
  frequente de conversas para preocupações pessoais, tom defensivo.

detection_confidence_threshold: 0.75

linguistic_markers:
  palavras_frequentes:
    - "sempre"
    - "nunca"
    - "preciso"
    - "tenho que"
    - "medo"
    - "preocupado"
    - "nervoso"
    - "ansioso"
    - "incerto"
    - "dúvida"
  construções_frasais:
    - "me sinto (ansioso|preocupado|nervoso) quando"
    - "e se (.*?) der errado"
    - "será que (.*?)\\?"
    - "tenho medo (de|que)"
    - "não sei se (consigo|vou conseguir)"
    - "preciso ter certeza"
  intensificadores:
    - "muito"
    - "extremamente"
    - "sempre"
    - "constantemente"
    - "o tempo todo"
  hedges:
    - "talvez"
    - "não sei se"
    - "acho que"
    - "pode ser que"
    - "não tenho certeza"
  negações:
    - "nunca vou"
    - "não consigo"
    - "jamais conseguirei"
  tópicos_recorrentes:
    - "incerteza"
    - "risco"
    - "controle"
    - "segurança"
    - "fracasso"
    - "julgamento"

detection_patterns:
  text_patterns:
    - "antecipação de problemas futuros"
    - "catastrofização de situações comuns"
    - "busca excessiva de reasseguramento"
    - "dificuldade com ambiguidade"
  behavioral_markers:
    - "evitação de situações novas ou desconhecidas"
    - "adiamento de decisões importantes"
    - "verificação repetida de informações"
    - "busca constante de validação externa"
  communication_style:
    - "justificativas excessivas para decisões"
    - "uso frequente de expressões de dúvida"
    - "tom defensivo ou cauteloso"
    - "respostas longas e circularmente elaboradas"
  decision_indicators:
    - "paralisia por análise (overthinking)"
    - "preferência extrema por opções seguras"
    - "necessidade de ter 100% de informação antes de decidir"
  temporal_patterns:
    - "preocupação com eventos futuros distantes"
    - "ruminação sobre decisões passadas"
    - "dificuldade em viver o presente"

multimodal_indicators:
  whatsapp:
    - "múltiplas mensagens de follow-up buscando confirmação"
    - "uso frequente de 'você tem certeza?' ou 'será que está certo?'"
    - "responde com muitas perguntas ao invés de afirmações"
    - "edita mensagens frequentemente após enviar"
  meetings:
    - "solicita confirmação de entendimento múltiplas vezes"
    - "faz muitas perguntas 'e se...?' em discussões"
    - "expressa hesitação verbalmente ('hmm', 'não sei', 'talvez')"
    - "busca consenso antes de expressar opinião"
  documents:
    - "uso excessivo de hedging language ('talvez', 'possivelmente')"
    - "múltiplas ressalvas e cláusulas de escape"
    - "revisões excessivas antes de compartilhar"
  code:
    - "comentários excessivos justificando decisões técnicas"
    - "múltiplas verificações de erro (defensive programming ao extremo)"
    - "hesitação em fazer commits (muitas alterações locais)"
  social_media:
    - "posts raros devido a medo de julgamento"
    - "deleta posts que receberam feedback negativo"
    - "pede opinião antes de compartilhar conteúdo"
  calendar:
    - "buffers excessivos entre compromissos"
    - "evita eventos sem agenda clara"
    - "confirma múltiplas vezes antes de reuniões"

activation_trigger: |
  Situações de incerteza, mudanças inesperadas, prazos apertados, avaliações
  externas, perda de controle sobre o ambiente, exposição a julgamento público,
  decisões de alto impacto, ambientes novos ou desconhecidos.

related_traits:
  - "neuroticismo"
  - "perfeccionismo"
  - "need_for_control"
  - "low_risk_tolerance"
  - "conscientiousness_order"

inverse_traits:
  - "emotional_stability"
  - "risk_tolerance"
  - "spontaneity"
  - "confidence"

model_mappings:
  big_five:
    factor: "Neuroticism"
    facet: "Anxiety"
    direction: "positive"
    correlation: 0.85
  hexaco:
    factor: "Emotionality"
    facet: "Anxiety"
    direction: "positive"
  via:
    strength: null
  schwartz:
    value: "Security"
    priority: "high"
  reiss:
    desire: "Tranquility"
    intensity: "high"
    direction: "negative"  # High anxiety = low tranquility

facet_of: "neuroticism"

measurement_instruments:
  - name: "NEO-PI-R"
    scale: "Neuroticism - Anxiety Facet"
    items: 8
    citation: "Costa & McCrae, 1992"
  - name: "HEXACO-PI-R"
    scale: "Emotionality - Anxiety"
    items: 10
    citation: "Ashton & Lee, 2009"
  - name: "STAI"
    scale: "State-Trait Anxiety Inventory"
    items: 20
    citation: "Spielberger, 1983"

prevalence_distribution:
  mean: 50.0
  std_dev: 15.0
  percentiles:
    p10: 32.0
    p25: 42.0
    p50: 50.0
    p75: 58.0
    p90: 68.0
  source: "Big Five norms, Costa & McCrae, 1992"

development_trajectory: |
  Geralmente estável após os 30 anos, com pequenas variações situacionais.
  Pode diminuir levemente com a idade devido a maior exposição e habituação a
  situações estressantes. Traumas ou mudanças de vida significativas (mudança
  de carreira, perda, doença) podem aumentar temporariamente. Intervenções
  terapêuticas (CBT, mindfulness) podem reduzir significativamente.

gender_differences: |
  Meta-análises mostram diferença pequena a moderada (d=0.40), com mulheres
  pontuando ligeiramente mais alto em ansiedade em média. IMPORTANTE: variação
  intra-grupo é muito maior que entre-grupos (>80% da variância é individual,
  não de grupo). Não usar gênero como preditor automático. (Schmitt et al., 2008)

cultural_considerations: |
  Expressão de ansiedade varia culturalmente. Culturas individualistas (EUA,
  Europa Ocidental) tendem a expressar ansiedade verbalmente e buscar suporte
  emocional direto. Culturas coletivistas (Ásia Oriental, América Latina) podem
  somatizar (expressar através de sintomas físicos) ou usar linguagem indireta.
  Normas de 'face' em culturas asiáticas podem inibir expressão aberta de
  vulnerabilidade. Ajustar detecção para contexto cultural.

clinical_relevance: |
  Escores extremamente altos (>85) associados com Transtornos de Ansiedade
  (DSM-5: 300.xx - GAD, Social Anxiety, Panic Disorder). Ansiedade patológica
  diferencia-se por: (1) intensidade desproporcional, (2) duração prolongada
  (>6 meses), (3) prejuízo funcional significativo. Triagem clínica recomendada
  para escores >90. Comorbidade comum com depressão (r=0.60).

privacy_sensitivity: "sensitive"

computational_ontology:
  ipip_code: "N1"
  facetmap_uri: "http://www.facetmap.org/trait/anxiety"
  owl_class: "PersonalityTrait:Anxiety"
  wikidata_id: "Q378835"
  snomed_ct: "48694002"  # Anxiety disorder

confidence_modifiers:
  increase:
    - "múltiplas fontes convergentes (texto + comportamento)"
    - "padrões consistentes ao longo do tempo (>6 meses de dados)"
    - "expressão explícita do indivíduo ('sou uma pessoa ansiosa')"
    - "uso frequente de linguagem ansiosa em contextos diversos"
  decrease:
    - "fontes contraditórias (texto ansioso mas comportamento confiante)"
    - "contexto situacional forte (ex: véspera de apresentação importante)"
    - "impressão management detectada (pessoa ocultando ansiedade)"
    - "dados insuficientes (<1000 palavras analisadas)"

false_positive_risks:
  - "Ansiedade situacional (ex: véspera de evento importante) confundida com traço ansioso estável"
  - "Uso de linguagem hedging por prudência profissional (ex: cientistas, advogados) vs ansiedade real"
  - "Preocupação pontual com evento específico vs padrão crônico de preocupação generalizada"
  - "Perfeccionismo (busca de excelência) confundido com ansiedade (medo de erro)"

nlp_config:
  min_document_length: 800
  context_window: 50
  sentiment_weight: 0.25
  frequency_weight: 0.35
  pattern_weight: 0.40
  models:
    - "bert-base-multilingual-cased"
    - "gpt-3.5-turbo"
    - "xlm-roberta-base"
  preprocessing:
    - "lowercase"
    - "remove_punctuation"
    - "lemmatization_pt"

update_history:
  - version: "2.0"
    date: "2025-10-13"
    changes: "Added comprehensive multimodal detection patterns from unified catalog research"
    author: "Product Owner"
  - version: "1.1"
    date: "2025-08-15"
    changes: "Refined validation criteria based on sam_altman cognitive analysis"
    author: "Mind Mapper Agent"
  - version: "1.0"
    date: "2025-06-01"
    changes: "Initial trait definition"
    author: "Database Architect"
```

---

#### Example 2: Criatividade Divergente (Divergent Creativity) - COMPLETE

```yaml
# ══════════════════════════════════════════════════════════════
# TRAIT: Criatividade Divergente
# Domain: Cognitive
# Version: 2.0
# ══════════════════════════════════════════════════════════════

# Core Database Fields
code: 5
canonical: "criatividade_divergente"
name: "Criatividade Divergente"
description: |
  Capacidade de gerar múltiplas soluções originais e não-convencionais para
  problemas abertos. Caracteriza-se por pensamento lateral, flexibilidade
  cognitiva e preferência por exploração de ideias inusitadas. Fluidez,
  originalidade e elaboração de ideias.
domain: "cognitive"
subdomain: "creativity"
scale_min_label: "Convergente"
scale_max_label: "Divergente"
related_frameworks: '["Big Five: Openness - Actions & Ideas", "Guilford Divergent Thinking"]'
inverse_of: null
version: "2.0"

# Advanced Detection Fields

aliases:
  - "divergent thinking"
  - "pensamento divergente"
  - "criatividade"
  - "originalidade"
  - "lateral thinking"

psychometric_type: "habilidade"

validation_criteria: |
  Geração espontânea de múltiplas alternativas para problemas, uso frequente
  de analogias e metáforas inusitadas, conexões inesperadas entre conceitos
  aparentemente não relacionados.

  Comportamentalmente: busca ativa de perspectivas alternativas, resistência
  a soluções óbvias ou tradicionais, experimentação frequente com abordagens
  não convencionais, valorização de originalidade sobre eficiência.

  Em contextos de decisão: explora amplamente antes de convergir, considera
  opções "fora da caixa", questiona premissas estabelecidas, combina ideias
  de domínios diferentes.

  Padrões de comunicação: uso de metáforas criativas, analogias surpreendentes,
  histórias para ilustrar pontos, linguagem colorida e imagética.

detection_confidence_threshold: 0.70

linguistic_markers:
  palavras_frequentes:
    - "imagina"
    - "e se"
    - "poderia"
    - "diferente"
    - "novo"
    - "inovador"
    - "criativo"
    - "original"
    - "único"
  construções_frasais:
    - "e se (a gente|nós) (tentasse|fizesse) (.*?)\\?"
    - "uma maneira diferente de (.*?) seria"
    - "isso me lembra (.*?)"
    - "conectando (.*?) com (.*?)"
    - "nunca pensei em"
  intensificadores:
    - "completamente diferente"
    - "radicalmente novo"
    - "nunca visto antes"
  tópicos_recorrentes:
    - "inovação"
    - "experimentação"
    - "possibilidades"
    - "alternativas"
    - "insights"

detection_patterns:
  text_patterns:
    - "geração espontânea de múltiplas alternativas"
    - "uso de analogias entre domínios diferentes"
    - "questionamento de pressupostos estabelecidos"
    - "propostas de ideias não-convencionais"
  behavioral_markers:
    - "experimenta abordagens diferentes para mesmos problemas"
    - "combina conceitos de áreas distintas"
    - "propõe soluções inusitadas em brainstormings"
    - "resiste a primeira solução óbvia"
  communication_style:
    - "uso frequente de metáforas e analogias criativas"
    - "histórias ilustrativas de pontos conceituais"
    - "linguagem imagética e colorida"
  decision_indicators:
    - "explora amplamente antes de decidir"
    - "considera opções não-convencionais"
    - "desafia status quo e premissas"
  temporal_patterns:
    - "períodos de exploração ampla seguidos de convergência"

multimodal_indicators:
  whatsapp:
    - "usa emojis de forma criativa e inusitada"
    - "cria metáforas espontâneas em conversas"
    - "compartilha ideias 'fora da caixa'"
  meetings:
    - "propõe soluções não-convencionais em brainstormings"
    - "faz conexões inesperadas entre tópicos"
    - "usa quadro branco para visualizar ideias abstratas"
  documents:
    - "estruturas narrativas não-lineares"
    - "uso de diagramas e visualizações criativas"
    - "analogias de domínios diferentes"
  code:
    - "soluções elegantes e não-óbvias para problemas"
    - "experimenta com novas bibliotecas/frameworks"
    - "refatorações criativas da arquitetura"
  social_media:
    - "compartilha ideias originais e insights únicos"
    - "combina conceitos de áreas diferentes"
    - "conteúdo visualmente criativo"
  calendar:
    - "agenda tempo para 'exploração' e experimentação"
    - "participa de eventos de áreas diversas"

activation_trigger: |
  Problemas abertos sem soluções óbvias, brainstorming sessions, ambiente
  psicologicamente seguro (sem julgamento), tempo livre sem pressão de
  performance, exposição a estímulos diversos e novos, interações com pessoas
  de backgrounds diferentes.

related_traits:
  - "openness_to_experience"
  - "intellectual_curiosity"
  - "risk_tolerance"
  - "non_conformity"
  - "imagination"

inverse_traits:
  - "conventional_thinking"
  - "rigidity"
  - "need_for_closure"

model_mappings:
  big_five:
    factor: "Openness to Experience"
    facet: "Actions & Ideas"
    direction: "positive"
    correlation: 0.70
  hexaco:
    factor: "Openness to Experience"
    facet: "Creativity"
    direction: "positive"
  via:
    strength: "Creativity"
    rank_expectation: "high"
  schwartz:
    value: "Self-Direction (thought)"
    priority: "high"
  reiss:
    desire: "Idealism"
    intensity: "high"

facet_of: "openness_to_experience"

measurement_instruments:
  - name: "Torrance Tests of Creative Thinking (TTCT)"
    scale: "Divergent Thinking"
    items: 5
    citation: "Torrance, 1966"
  - name: "Guilford's Alternate Uses Task"
    scale: "Divergent Production"
    items: 1
    citation: "Guilford, 1967"

prevalence_distribution:
  mean: 50.0
  std_dev: 18.0
  percentiles:
    p10: 28.0
    p25: 40.0
    p50: 50.0
    p75: 62.0
    p90: 73.0
  source: "Openness norms, Costa & McCrae, 1992"

development_trajectory: |
  Pico na adolescência e early adulthood (criatividade "rebelde"). Tende a
  estabilizar na adulthood, mas pode ser cultivada através de prática deliberada,
  exposição a estímulos diversos, e ambientes que encorajam risk-taking. Pode
  diminuir se o ambiente profissional punir experimentação ou exigir apenas
  soluções convencionais.

gender_differences: "Diferenças mínimas (d<0.10). Criatividade é igualmente distribuída entre gêneros."

cultural_considerations: |
  Culturas individualistas (EUA) valorizam mais criatividade individual e
  originalidade radical. Culturas coletivistas (Ásia) podem valorizar criatividade
  colaborativa e inovação incremental. Definição de "criativo" varia: no Ocidente,
  quebrar regras é criativo; no Oriente, harmonizar elementos existentes de forma
  nova também é criativo.

clinical_relevance: |
  Criatividade extremamente alta pode estar associada com alguns transtornos de
  humor (bipolaridade, depressão) em amostras clínicas, mas causalidade é incerta.
  Não é indicador patológico. Pode ser fator protetor em alguns contextos (coping
  criativo com stress).

privacy_sensitivity: "public"

computational_ontology:
  ipip_code: "O4"  # Openness - Actions
  facetmap_uri: "http://www.facetmap.org/trait/creativity"
  owl_class: "CognitiveAbility:DivergentThinking"
  wikidata_id: "Q1917203"
  snomed_ct: null

confidence_modifiers:
  increase:
    - "múltiplos exemplos de soluções não-convencionais"
    - "histórico documentado de ideias originais implementadas"
    - "feedback de terceiros sobre originalidade"
  decrease:
    - "contexto que exige apenas soluções convencionais"
    - "ambiente restritivo pode suprimir expressão criativa"

false_positive_risks:
  - "Contrarianism (ser do contra) confundido com criatividade genuína"
  - "Randomness (aleatoriedade sem propósito) vs divergência intencional"
  - "Uso de linguagem 'criativa' vs capacidade de gerar soluções criativas"

nlp_config:
  min_document_length: 1000
  context_window: 60
  sentiment_weight: 0.10
  frequency_weight: 0.30
  pattern_weight: 0.60
  models:
    - "gpt-4"  # Better at detecting conceptual creativity
    - "bert-base-multilingual-cased"
  preprocessing:
    - "lowercase"
    - "lemmatization_pt"

update_history:
  - version: "2.0"
    date: "2025-10-13"
    changes: "Added comprehensive detection patterns from research"
    author: "Product Owner"
  - version: "1.0"
    date: "2025-06-01"
    changes: "Initial definition"
    author: "Database Architect"
```

---

#### Example 3: Sociabilidade (Sociability) - COMPLETE

```yaml
# ══════════════════════════════════════════════════════════════
# TRAIT: Sociabilidade
# Domain: Social
# Version: 2.0
# ══════════════════════════════════════════════════════════════

# Core Database Fields
code: 62
canonical: "sociabilidade"
name: "Sociabilidade"
description: |
  Preferência por interações sociais frequentes e energização através do contato
  com outras pessoas. Caracteriza-se por iniciativa social, conforto em grupos,
  busca ativa de companhia e energia derivada de situações sociais. Faceta de
  Extraversão.
domain: "social"
subdomain: "relationships"
scale_min_label: "Reservado"
scale_max_label: "Sociável"
related_frameworks: '["Big Five: Extraversion - Gregariousness", "HEXACO: Extraversion - Sociability"]'
inverse_of: null
version: "2.0"

# Advanced Detection Fields

aliases:
  - "sociability"
  - "gregariousness"
  - "extraversão social"
  - "gregarismo"

psychometric_type: "traço"

validation_criteria: |
  Iniciação frequente de interações sociais, presença regular em eventos sociais,
  energia observável em situações de grupo, desconforto com solidão prolongada.

  Comportamentalmente: busca ativa de companhia, organiza encontros sociais,
  mantém rede social ampla, responde rapidamente a convites sociais, participa
  ativamente de conversas em grupo.

  Em contextos de decisão: prioriza opções que envolvem interação social,
  prefere trabalho colaborativo a solitário, escolhe atividades sociais sobre
  solitárias quando possível.

  Padrões de comunicação: inicia conversas com desconhecidos, mantém múltiplas
  conversas simultâneas, compartilha experiências pessoais abertamente,
  linguagem inclusiva ("a gente", "vamos").

detection_confidence_threshold: 0.65

linguistic_markers:
  palavras_frequentes:
    - "nós"
    - "a gente"
    - "vamos"
    - "encontrar"
    - "pessoal"
    - "galera"
    - "turma"
    - "amigos"
  construções_frasais:
    - "(vamos|vou) (sair|encontrar) (.*?)\\?"
    - "adoro (conversar|estar com)"
    - "conheci (.*?) pessoas"
    - "foi (ótimo|legal) (ver|encontrar) (.*?)"
  intensificadores:
    - "muitas pessoas"
    - "sempre rodeado de"
    - "constantemente interagindo"
  tópicos_recorrentes:
    - "encontros sociais"
    - "eventos"
    - "festas"
    - "networking"
    - "amizades"

detection_patterns:
  text_patterns:
    - "menção frequente a interações sociais"
    - "descrição de eventos sociais com entusiasmo"
    - "referências a rede social ampla"
  behavioral_markers:
    - "inicia conversas com desconhecidos"
    - "organiza encontros e eventos"
    - "participa ativamente de grupos sociais"
    - "mantém contato regular com muitas pessoas"
  communication_style:
    - "comunicação animada e expressiva"
    - "compartilha experiências pessoais facilmente"
    - "uso de linguagem inclusiva"
  decision_indicators:
    - "prioriza atividades sociais"
    - "prefere trabalho em equipe a individual"
    - "aceita convites sociais prontamente"
  temporal_patterns:
    - "agenda social frequentemente preenchida"
    - "múltiplas interações sociais por semana"

multimodal_indicators:
  whatsapp:
    - "múltiplos grupos ativos"
    - "iniciador frequente de conversas"
    - "respostas rápidas e engajadas"
    - "compartilha conteúdo regularmente"
    - "organiza encontros via mensagens"
  meetings:
    - "câmera sempre ligada"
    - "participa ativamente sem ser solicitado"
    - "inicia small talk antes/depois de reuniões"
    - "propõe reuniões follow-up"
  documents:
    - "estilo narrativo e pessoal"
    - "usa 'nós' e 'a gente' frequentemente"
    - "menciona colaboradores pelo nome"
  code:
    - "pair programming frequente"
    - "code reviews detalhadas e conversacionais"
    - "mensagens de commit com tom pessoal"
  social_media:
    - "posts frequentes sobre interações sociais"
    - "muitos comentários e interações"
    - "compartilha fotos de eventos sociais"
    - "rede social ampla (muitos conexões)"
  calendar:
    - "calendário com múltiplos eventos sociais"
    - "aceita maioria de convites para reuniões"
    - "agenda coffee chats e 1:1s regularmente"

activation_trigger: |
  Ambientes sociais estimulantes, eventos com muitas pessoas, oportunidades de
  networking, trabalho colaborativo, celebrações e festividades, discussões
  em grupo.

related_traits:
  - "extraversion"
  - "warmth"
  - "positive_emotionality"
  - "assertiveness"

inverse_traits:
  - "introversion"
  - "social_anxiety"
  - "need_for_solitude"

model_mappings:
  big_five:
    factor: "Extraversion"
    facet: "Gregariousness"
    direction: "positive"
    correlation: 0.80
  hexaco:
    factor: "Extraversion"
    facet: "Sociability"
    direction: "positive"
  via:
    strength: "Social Intelligence"
    rank_expectation: "high"
  schwartz:
    value: "Benevolence"
    priority: "medium"
  reiss:
    desire: "Social Contact"
    intensity: "high"

facet_of: "extraversion"

measurement_instruments:
  - name: "NEO-PI-R"
    scale: "Extraversion - Gregariousness"
    items: 8
    citation: "Costa & McCrae, 1992"
  - name: "HEXACO-PI-R"
    scale: "Extraversion - Sociability"
    items: 10
    citation: "Ashton & Lee, 2009"

prevalence_distribution:
  mean: 50.0
  std_dev: 15.0
  percentiles:
    p10: 32.0
    p25: 42.0
    p50: 50.0
    p75: 58.0
    p90: 68.0
  source: "Extraversion norms, Costa & McCrae, 1992"

development_trajectory: |
  Relativamente estável após young adulthood. Pode diminuir levemente com a idade
  (após 60 anos) devido a menor energia física e mudanças na rede social. Eventos
  de vida (parenthood, mudança de cidade) podem afetar temporariamente.

gender_differences: "Diferenças mínimas (d<0.15). Homens e mulheres igualmente sociáveis em média."

cultural_considerations: |
  Expressão de sociabilidade varia culturalmente. Culturas individualistas valorizam
  redes sociais amplas e interações com desconhecidos. Culturas coletivistas
  valorizam profundidade de relações com in-group. Definição de 'sociável' varia:
  no Ocidente, ser expansivo com estranhos; no Oriente, manter harmonia em grupo
  conhecido.

clinical_relevance: "Sociabilidade extremamente baixa pode indicar Social Anxiety Disorder (DSM-5: 300.23) se acompanhada de sofrimento e prejuízo funcional. Avaliação clínica necessária para distinguir introversão saudável de fobia social."

privacy_sensitivity: "private"

computational_ontology:
  ipip_code: "E2"  # Extraversion - Gregariousness
  facetmap_uri: "http://www.facetmap.org/trait/sociability"
  owl_class: "PersonalityTrait:Sociability"
  wikidata_id: "Q1368943"
  snomed_ct: null

confidence_modifiers:
  increase:
    - "evidência comportamental (participa de muitos eventos)"
    - "feedback de terceiros sobre sociabilidade"
    - "padrões consistentes em múltiplos canais"
  decrease:
    - "introversão situacional (ex: burnout social temporário)"
    - "contexto profissional pode exigir sociabilidade forçada"

false_positive_risks:
  - "Sociabilidade profissional (networking por obrigação) vs preferência genuína"
  - "Solidão situacional (ex: mudança de cidade) interpretada como baixa sociabilidade"
  - "Extroversão performática (esconde introversão) detectada como alta sociabilidade"

nlp_config:
  min_document_length: 600
  context_window: 50
  sentiment_weight: 0.30
  frequency_weight: 0.40
  pattern_weight: 0.30
  models:
    - "bert-base-multilingual-cased"
    - "gpt-3.5-turbo"
  preprocessing:
    - "lowercase"
    - "lemmatization_pt"

update_history:
  - version: "2.0"
    date: "2025-10-13"
    changes: "Added multimodal indicators and comprehensive detection patterns"
    author: "Product Owner"
  - version: "1.0"
    date: "2025-06-01"
    changes: "Initial definition"
    author: "Database Architect"
```

---

## 🔗 Integration

### How Traits Are Used

#### 1. **trait_scores Table**

Once traits are defined, they are scored for each mind:

```sql
CREATE TABLE trait_scores (
  mind_id INTEGER NOT NULL,
  trait_code INTEGER NOT NULL,
  score REAL NOT NULL CHECK(score BETWEEN 0 AND 100),
  confidence REAL CHECK(confidence BETWEEN 0 AND 1),
  evidence TEXT,  -- JSON: {"sources": [...], "quotes": [...], "reasoning": "..."}
  scored_by TEXT,  -- 'human', 'ai_inference', 'psychological_assessment'
  scored_at TEXT DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (mind_id, trait_code),
  FOREIGN KEY (mind_id) REFERENCES minds(id),
  FOREIGN KEY (trait_code) REFERENCES traits(code)
);
```

**Example:**
```sql
-- Sam Altman's Risk Tolerance score
INSERT INTO trait_scores (mind_id, trait_code, score, confidence, evidence, scored_by)
VALUES (
  22,  -- sam_altman
  81,  -- Risk Tolerance trait
  85,  -- High risk tolerance (toward "Risk Seeking")
  0.90,  -- High confidence
  '{"sources": ["startup-playbook.md", "lex-fridman-419"], "quotes": ["Trust the exponential", "Most highly successful people have been really right about the future at least once at a time when people thought they were wrong"], "reasoning": "Consistent pattern of contrarian bets (OpenAI when mocked, AGI focus when dismissed). Explicitly advocates for risk-taking in writing and interviews."}',
  'ai_inference'
);
```

**Score Interpretation:**
- **0-100 scale** (not 0-1)
- **50 = neutral/middle**
- **< 50 = toward scale_min_label**
- **> 50 = toward scale_max_label**

---

#### 2. **System Prompt Generation**

Trait scores inform personality parameters in AI clones:

```python
# Example: Generate personality parameters from trait scores
def generate_personality_params(mind_id):
    traits = get_trait_scores(mind_id)

    params = {
        "risk_tolerance": traits["Risk Tolerance"].score / 100,  # 0.85
        "analytical_style": traits["Analytical Reasoning"].score / 100,
        "time_orientation": traits["Long-term Thinking"].score / 100,
        "autonomy_preference": traits["Autonomy Value"].score / 100,
        # ...
    }

    return params

# Use in system prompt
system_prompt = f"""
You are {mind_name}. Your personality parameters:
- Risk Tolerance: {params['risk_tolerance']:.2f} (high - embrace uncertainty)
- Analytical Style: {params['analytical_style']:.2f} (balanced)
- Time Orientation: {params['time_orientation']:.2f} (very future-focused)
...
"""
```

---

#### 3. **Mind Comparison & Clustering**

Traits enable quantitative comparison:

```sql
-- Compare two minds on Risk Tolerance
SELECT
  m.name,
  ts.score as risk_tolerance_score,
  CASE
    WHEN ts.score < 40 THEN t.scale_min_label
    WHEN ts.score > 60 THEN t.scale_max_label
    ELSE 'Moderate'
  END as risk_profile
FROM minds m
JOIN trait_scores ts ON m.id = ts.mind_id
JOIN traits t ON ts.trait_code = t.code
WHERE t.name = 'Risk Tolerance'
  AND m.slug IN ('sam_altman', 'elon_musk', 'nassim_taleb');
```

---

#### 4. **Specialist Matching**

Match minds to specialist roles based on trait profiles:

```sql
-- Find minds with high analytical reasoning + long-term thinking
SELECT m.name,
       AVG(ts.score) as cognitive_score
FROM minds m
JOIN trait_scores ts ON m.id = ts.mind_id
JOIN traits t ON ts.trait_code = t.code
WHERE t.name IN ('Analytical Reasoning', 'Long-term Thinking', 'First-Principles Thinking')
GROUP BY m.id
HAVING AVG(ts.score) > 75
ORDER BY cognitive_score DESC;
```

---

## ✅ Design Checklist

Use this checklist when creating your traits taxonomy:

### Planning Phase
- [ ] Decide total number of traits (30-120)
- [ ] Choose base frameworks (Big Five? DNA Mental™? Hybrid?)
- [ ] Define domain distribution targets
- [ ] Identify trait categories to cover

### Design Phase

For each trait:
- [ ] Assign sequential `code` number (organized by domain)
- [ ] Create concise, unique `name` (2-4 words)
- [ ] Write clear `description` (1-3 sentences, 50-200 chars)
- [ ] Classify into `domain` (cognitive, emotional, motivation, social, behavioral, values)
- [ ] Assign `subdomain` if applicable
- [ ] Define `scale_min_label` (low pole, 1-4 words)
- [ ] Define `scale_max_label` (high pole, 1-4 words)
- [ ] Map to `related_frameworks` if applicable (JSON array)
- [ ] Identify `inverse_of` trait if applicable
- [ ] Set `version` to "1.0"

### Review Phase
- [ ] Check for trait redundancy (correlations >0.85)
- [ ] Verify naming consistency (all Title Case, all nouns)
- [ ] Validate domain distribution (balanced coverage)
- [ ] Ensure scale labels form clear continuums
- [ ] Confirm all `inverse_of` references are one-way
- [ ] Verify related_frameworks JSON formatting
- [ ] Review descriptions for clarity and precision
- [ ] Check for typos and formatting issues

### Quality Checks
- [ ] All traits have unique names
- [ ] All traits have unique codes
- [ ] All required fields filled (code, name, description, domain)
- [ ] All domains use allowed values
- [ ] All scale labels are neutral (not judgmental)
- [ ] All JSON fields properly formatted
- [ ] Subdomains use snake_case consistently
- [ ] No circular `inverse_of` references

### Export Phase
- [ ] Format as YAML (use template structure)
- [ ] Add header with metadata (version, date, total count)
- [ ] Group by domain with clear section headers
- [ ] Add comments for clarity
- [ ] Validate YAML syntax
- [ ] Final proofread

---

## 🚀 Next Steps

Once you complete your traits taxonomy design:

1. **Share the YAML file** with the development team
2. **Review & validation** - Technical review of structure and content
3. **Implementation** - Create `populate-traits.js` script
4. **Database population** - Run seed script to populate traits table
5. **Validation queries** - Verify all traits loaded correctly
6. **Documentation** - Update taxonomy documentation
7. **Pilot scoring** - Score 1-2 minds manually to test the system

---

## 📚 References & Resources

### Scientific Literature
- Costa, P. T., & McCrae, R. R. (1992). *Revised NEO Personality Inventory (NEO-PI-R)*
- Ashton, M. C., & Lee, K. (2007). *Empirical, theoretical, and practical advantages of the HEXACO model of personality structure*
- Duckworth, A. L., et al. (2007). *Grit: Perseverance and passion for long-term goals*
- Dweck, C. S. (2006). *Mindset: The new psychology of success*

### Frameworks
- Big Five: https://en.wikipedia.org/wiki/Big_Five_personality_traits
- HEXACO: http://hexaco.org/
- MBTI: https://www.myersbriggs.org/
- Grit Scale: https://angeladuckworth.com/grit-scale/

### DNA Mental™
- Internal documentation: `docs/mmos/dna-mental-framework.md`
- 8-Layer Architecture: `docs/mmos/cognitive-architecture.md`

---

**Document Version:** 1.0.0
**Maintainer:** Product Owner
**Last Updated:** 2025-10-13

---

**Ready to design your traits taxonomy?** 🎯

Use this guide as your reference and create a comprehensive, scientifically-grounded traits taxonomy that will power the MMOS psychometric profiling system.
