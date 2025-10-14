# Universal Fragments Architecture: Timeless Behavioral Evidence

**Version:** 2.0.0
**Date:** 2025-01-14
**Philosophy:** "Extract evidence that remains valid for 100+ years, regardless of future psychological frameworks"

---

## 🎯 Core Principle

> **"Fragments must capture WHAT HAPPENED (evidence) independent of HOW WE INTERPRET IT (frameworks)."**

Just as fossil evidence remains valid regardless of which evolutionary theory we use to interpret it, behavioral fragments must remain valid regardless of which psychological framework we apply.

---

## 1. The Problem with Current Approach

### ❌ Framework-Dependent Extraction (Wrong)

```json
{
  "fragment_id": 42,
  "behavioral_category": "openness_exploration",  // ← BIG FIVE BIAS
  "potential_frameworks": ["big_five_openness"],  // ← LOCKS TO CURRENT FRAMEWORKS
  "text": "I love exploring unconventional ideas"
}
```

**Problems:**
1. `behavioral_category` assumes Big Five taxonomy
2. `potential_frameworks` assumes we know which frameworks exist in 2125
3. Pre-categorizes evidence before analysis
4. Cannot support frameworks not yet invented

**Expiration Date:** ~5-10 years (when Big Five is superseded by new frameworks)

---

### ✅ Framework-Agnostic Extraction (Correct)

```json
{
  "fragment_id": "uuid-v7-timestamp",
  "type": "explicit_statement",
  "subject_id": "person_uuid",
  "source": {
    "document_id": "doc_uuid",
    "document_type": "interview_transcript",
    "timestamp": "2025-01-14T15:30:00Z",
    "char_range": [1420, 1486],
    "speaker": "subject",
    "context_before": "When asked about his creative process...",
    "context_after": "...which leads him to unconventional solutions."
  },
  "content": {
    "verbatim": "I love exploring unconventional ideas and finding unexpected connections between disparate fields",
    "who": "Alan Nicolas",
    "what": "exploring unconventional ideas",
    "how": "finding unexpected connections",
    "where": "between disparate fields",
    "when": "ongoing behavior (present tense)",
    "why": null  // Not stated explicitly
  },
  "observables": {
    "emotional_valence": "positive",  // Observable: "love"
    "intensity_markers": ["love"],
    "cognitive_indicators": ["unconventional", "unexpected", "disparate"],
    "behavioral_verbs": ["exploring", "finding"],
    "domain_references": ["ideas", "fields"],
    "self_attribution": true,  // "I" statement
    "certainty_level": "definite",  // No hedging
    "temporal_scope": "habitual"  // Present tense suggests pattern
  },
  "linguistic_features": {
    "sentence_type": "declarative",
    "grammatical_person": "first_person",
    "tense": "present_simple",
    "modality": null,
    "complexity_score": 0.72,
    "vocabulary_sophistication": 0.81,
    "gerunds": ["exploring", "finding"],
    "adjectives": ["unconventional", "unexpected", "disparate"]
  },
  "metadata": {
    "confidence": 1.0,  // Verbatim quote
    "extraction_method": "unified_extractor_v2.0",
    "extraction_timestamp": "2025-01-14T16:00:00Z",
    "validator": "self_critique_passed",
    "language": "en-US",
    "word_count": 13,
    "unique_concepts": 6
  }
}
```

**Why this works for 100+ years:**
1. ✅ No framework-specific categorization
2. ✅ Captures WHAT HAPPENED (observables)
3. ✅ Preserves original context
4. ✅ Can be reinterpreted by any future framework
5. ✅ Linguistic features are timeless
6. ✅ Emotional observables are universal

**Expiration Date:** Never (evidence doesn't expire, only interpretations change)

---

## 2. Universal Fragment Schema

### Core Principle: Evidence vs Interpretation

```
┌─────────────────────────────────────────────────────────────┐
│                    FRAGMENT (Evidence)                       │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ RAW OBSERVABLES (What Actually Happened)           │    │
│  │ - Verbatim quote                                   │    │
│  │ - Context (before/after)                           │    │
│  │ - Emotional markers (observed, not inferred)       │    │
│  │ - Behavioral verbs                                 │    │
│  │ - Linguistic features                              │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ STRUCTURAL METADATA (How It Was Said)             │    │
│  │ - Source attribution                               │    │
│  │ - Timestamp                                        │    │
│  │ - Speaker identification                           │    │
│  │ - Document type                                    │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              INTERPRETATION LAYER (Separate)                 │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Big Five    │  │    HEXACO    │  │ Framework    │     │
│  │  Detector    │  │   Detector   │  │ Invented in  │     │
│  │   (2025)     │  │    (2025)    │  │    (2125)    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│         │                  │                  │             │
│         ▼                  ▼                  ▼             │
│  All operate on SAME fragments, produce DIFFERENT traits   │
└─────────────────────────────────────────────────────────────┘
```

---

### 2.1 Fragment Types (Universal)

Based on **HOW the evidence was generated**, not what it means:

```typescript
enum FragmentType {
  // VERBAL EVIDENCE (Spoken/Written)
  EXPLICIT_STATEMENT = 'explicit_statement',           // "I believe X"
  IMPLICIT_REVEAL = 'implicit_reveal',                 // Reveals belief indirectly
  QUESTION_RESPONSE = 'question_response',             // Q&A exchange
  MONOLOGUE = 'monologue',                            // Extended thought
  DIALOGUE_EXCHANGE = 'dialogue_exchange',             // Multi-turn conversation

  // BEHAVIORAL EVIDENCE (Observed Actions)
  BEHAVIOR_DESCRIBED = 'behavior_described',           // Description of actions
  BEHAVIOR_OBSERVED = 'behavior_observed',             // Direct observation
  DECISION_MADE = 'decision_made',                     // Choice with reasoning
  PATTERN_REPORTED = 'pattern_reported',               // Self-reported habit

  // CONTEXTUAL EVIDENCE (Circumstances)
  BIOGRAPHICAL_FACT = 'biographical_fact',             // Life event
  ENVIRONMENTAL_CONTEXT = 'environmental_context',     // Situational factors
  TEMPORAL_PATTERN = 'temporal_pattern',               // Time-based patterns

  // META-EVIDENCE (About Evidence)
  CONTRADICTION = 'contradiction',                     // Conflicting statements
  ELABORATION = 'elaboration',                        // Adds detail to previous
  CORRECTION = 'correction',                          // Corrects previous statement
  META_REFLECTION = 'meta_reflection'                 // Reflection on own patterns
}
```

**Why these are universal:**
- Based on **how evidence emerges**, not what it means
- Will be valid in 2125 (people will still make statements, act, have life events)
- Framework-agnostic

---

### 2.2 Complete Universal Fragment Schema

```typescript
interface UniversalFragment {
  // ═══════════════════════════════════════════════════════════
  // IDENTITY (Who/What/When/Where)
  // ═══════════════════════════════════════════════════════════

  fragment_id: string;              // UUID v7 (timestamp-ordered)
  subject_id: string;               // Person being analyzed

  // ═══════════════════════════════════════════════════════════
  // TYPE & SOURCE (How Was This Captured?)
  // ═══════════════════════════════════════════════════════════

  type: FragmentType;               // See enum above

  source: {
    document_id: string;            // Source document
    document_type: DocumentType;    // podcast, email, chat, etc.
    timestamp: ISO8601;             // When it happened
    char_range: [number, number];  // Position in document
    speaker: string | null;         // Who said it (if applicable)
    addressee: string | null;       // Who it was said to
    context_before: string;         // 100 chars before
    context_after: string;          // 100 chars after
    medium: Medium;                 // spoken, written, digital
  };

  // ═══════════════════════════════════════════════════════════
  // CONTENT (What Actually Happened - VERBATIM)
  // ═══════════════════════════════════════════════════════════

  content: {
    verbatim: string;               // Exact quote/description
    language: string;               // ISO 639-1 code
    translation?: string;           // If translated

    // 5W1H Decomposition (Universal Journalistic Structure)
    who: string;                    // Agent/subject
    what: string;                   // Action/state
    how: string | null;             // Manner
    where: string | null;           // Location/domain
    when: string | null;            // Temporal scope
    why: string | null;             // Stated reason (if any)
  };

  // ═══════════════════════════════════════════════════════════
  // OBSERVABLES (What Can Be Directly Observed)
  // ═══════════════════════════════════════════════════════════

  observables: {
    // Emotional (Based on explicit emotional words)
    emotional_valence: 'positive' | 'negative' | 'neutral' | 'mixed';
    emotional_intensity: number;    // 0.0-1.0 based on intensity markers
    emotional_words: string[];      // ["love", "frustrated", "excited"]

    // Cognitive (Based on cognitive verbs/adjectives)
    cognitive_indicators: string[]; // ["analyze", "abstract", "complex"]
    cognitive_complexity: number;   // 0.0-1.0 based on sentence structure

    // Behavioral (Based on action verbs)
    behavioral_verbs: string[];     // ["exploring", "avoiding", "creating"]
    behavioral_frequency: string;   // "always", "never", "sometimes", null

    // Domain References (What topics/areas mentioned)
    domain_references: string[];    // ["technology", "relationships", "philosophy"]

    // Attribution (Who claims this?)
    self_attribution: boolean;      // "I" statement vs "people say"
    certainty_level: string;        // "definite", "probable", "uncertain"
    hedging_detected: boolean;      // "maybe", "perhaps", "might"

    // Temporal (When/how often)
    temporal_scope: string;         // "habitual", "one-time", "aspirational"
    tense: string;                  // "past", "present", "future"
  };

  // ═══════════════════════════════════════════════════════════
  // LINGUISTIC FEATURES (How It Was Said)
  // ═══════════════════════════════════════════════════════════

  linguistic: {
    sentence_type: string;          // declarative, interrogative, imperative
    grammatical_person: string;     // first, second, third
    tense: string;                  // present, past, future
    aspect: string | null;          // simple, continuous, perfect
    modality: string | null;        // "can", "must", "should", "might"
    voice: string;                  // active, passive

    complexity_metrics: {
      sentence_length: number;      // Word count
      avg_word_length: number;      // Characters per word
      vocabulary_sophistication: number; // 0.0-1.0
      syntactic_complexity: number; // 0.0-1.0 based on clause depth
    };

    rhetorical_devices: string[];   // ["metaphor", "hyperbole", "irony"]
    gerunds: string[];              // [-ing forms]
    adjectives: string[];
    adverbs: string[];
  };

  // ═══════════════════════════════════════════════════════════
  // RELATIONAL (Connection to Other Fragments)
  // ═══════════════════════════════════════════════════════════

  relations: {
    contradicts: string[];          // Fragment IDs that conflict
    elaborates: string | null;      // Fragment ID this expands on
    corrects: string | null;        // Fragment ID this corrects
    supports: string[];             // Fragment IDs this confirms
  };

  // ═══════════════════════════════════════════════════════════
  // QUALITY METADATA (How Good Is This Evidence?)
  // ═══════════════════════════════════════════════════════════

  quality: {
    confidence: number;             // 0.0-1.0 (based on verbatim vs paraphrased)
    significance: number;           // 0.0-1.0 (how psychologically rich)
    uniqueness: number;             // 0.0-1.0 (how unique vs redundant)

    self_critique: {
      passed: boolean;
      tests_run: string[];
      issues_detected: string[];
      refinements_applied: string[];
    };

    why_significant: string;        // Human-readable explanation
  };

  // ═══════════════════════════════════════════════════════════
  // EXTRACTION METADATA (Provenance)
  // ═══════════════════════════════════════════════════════════

  extraction: {
    method: string;                 // "unified_extractor_v2.0"
    version: string;                // Extractor version
    timestamp: ISO8601;             // When extracted
    model: string;                  // "claude-sonnet-4-20250514"
    cost_usd: number;               // Extraction cost
  };

  // ═══════════════════════════════════════════════════════════
  // AUDIT TRAIL
  // ═══════════════════════════════════════════════════════════

  created_at: ISO8601;
  updated_at: ISO8601;
  deleted_at: ISO8601 | null;
}
```

---

## 3. Example: Universal Fragment (Real)

### Scenario: Podcast Interview Transcript

**Verbatim Quote:**
> "I tend to avoid delegating because I've been burned before by team members who don't move at my pace, so I end up just doing everything myself even though I know it's unsustainable."

### ❌ OLD APPROACH (Framework-Biased):

```json
{
  "fragment_id": 42,
  "text": "I tend to avoid delegating because I've been burned before...",
  "behavioral_category": "autonomy_behavior",
  "potential_frameworks": ["big_five_conscientiousness", "big_five_agreeableness"],
  "confidence": 0.85
}
```

**Problems:**
- Pre-categorizes as "autonomy_behavior" (assumes framework)
- Tags with Big Five only
- Loses most context
- Cannot support Schema Therapy, Enneagram, DISC, or future frameworks

---

### ✅ NEW APPROACH (Universal Evidence):

```json
{
  "fragment_id": "01930e8c-7890-7890-9abc-def012345678",
  "subject_id": "alan_nicolas_uuid",
  "type": "explicit_statement",

  "source": {
    "document_id": "podcast_tim_ferriss_uuid",
    "document_type": "interview_transcript",
    "timestamp": "2025-01-14T10:45:30Z",
    "char_range": [12450, 12598],
    "speaker": "alan_nicolas",
    "addressee": "tim_ferriss",
    "context_before": "Tim asks: 'What's your biggest operational challenge right now?' Alan responds:",
    "context_after": "Tim follows up: 'Have you tried any delegation frameworks?'",
    "medium": "spoken_transcribed"
  },

  "content": {
    "verbatim": "I tend to avoid delegating because I've been burned before by team members who don't move at my pace, so I end up just doing everything myself even though I know it's unsustainable.",
    "language": "en-US",

    "who": "I (Alan)",
    "what": "avoid delegating, do everything myself",
    "how": "due to past negative experiences",
    "where": "team/work context",
    "when": "habitual pattern (present tense)",
    "why": "been burned before, pace mismatch, know it's unsustainable"
  },

  "observables": {
    "emotional_valence": "negative",
    "emotional_intensity": 0.72,
    "emotional_words": ["burned"],

    "cognitive_indicators": ["know"],
    "cognitive_complexity": 0.81,

    "behavioral_verbs": ["avoid", "delegating", "doing", "move"],
    "behavioral_frequency": "tend to (habitual)",

    "domain_references": ["delegation", "team", "pace", "sustainability"],

    "self_attribution": true,
    "certainty_level": "definite",
    "hedging_detected": false,

    "temporal_scope": "habitual",
    "tense": "present"
  },

  "linguistic": {
    "sentence_type": "declarative_compound",
    "grammatical_person": "first_person",
    "tense": "present_simple",
    "aspect": "simple",
    "modality": null,
    "voice": "active",

    "complexity_metrics": {
      "sentence_length": 29,
      "avg_word_length": 4.8,
      "vocabulary_sophistication": 0.65,
      "syntactic_complexity": 0.78
    },

    "rhetorical_devices": ["self_awareness"],
    "gerunds": ["delegating", "doing"],
    "adjectives": ["unsustainable"],
    "adverbs": []
  },

  "relations": {
    "contradicts": [],
    "elaborates": null,
    "corrects": null,
    "supports": ["fragment_uuid_about_control_needs", "fragment_uuid_about_trust_issues"]
  },

  "quality": {
    "confidence": 1.0,
    "significance": 0.92,
    "uniqueness": 0.85,

    "self_critique": {
      "passed": true,
      "tests_run": [
        "significance_check",
        "verbatim_validation",
        "context_completeness",
        "duplicate_check",
        "bias_check"
      ],
      "issues_detected": [],
      "refinements_applied": []
    },

    "why_significant": "Reveals habitual avoidance pattern, past trauma ('burned'), self-awareness of unsustainability, pace mismatch with team, and autonomy/control coping mechanism"
  },

  "extraction": {
    "method": "unified_extractor_v2.0",
    "version": "2.0.0",
    "timestamp": "2025-01-14T11:00:00Z",
    "model": "claude-sonnet-4-20250514",
    "cost_usd": 0.0003
  },

  "created_at": "2025-01-14T11:00:00Z",
  "updated_at": "2025-01-14T11:00:00Z",
  "deleted_at": null
}
```

---

### Why This Fragment Works for 100+ Years

**In 2025 (Big Five Framework):**
```python
# Big Five Detector
if fragment.observables.behavioral_verbs contains "avoid":
    if fragment.observables.domain_references contains "delegation":
        detect_trait("Low Agreeableness", intensity=0.70)
        detect_trait("High Neuroticism", intensity=0.65)  # "burned" = anxiety
```

**In 2025 (Schema Therapy Framework):**
```python
# Schema Therapy Detector
if fragment.observables.emotional_words contains "burned":
    if fragment.content.why contains "past negative experiences":
        detect_schema("Mistrust/Abuse Schema", intensity=0.75)
        detect_coping_style("Overcompensation", intensity=0.80)  # does everything himself
```

**In 2025 (Enneagram Framework):**
```python
# Enneagram Detector
if fragment.observables.domain_references contains "pace":
    if fragment.observables.behavioral_verbs contains "control":
        detect_type("Type 1 (Perfectionist)", intensity=0.68)  # high standards
        detect_type("Type 8 (Challenger)", intensity=0.72)     # control needs
```

**In 2125 (Framework Not Yet Invented):**
```python
# NeuroQuantum Personality Matrix (fictional future framework)
if fragment.linguistic.complexity_metrics.syntactic_complexity > 0.75:
    if fragment.observables.self_attribution == true:
        if fragment.quality.significance > 0.90:
            detect_dimension("Self-Reflective Autonomy Index", value=8.7)
            detect_pattern("Adaptive Control Compensation", severity="moderate")
```

**The fragment remains 100% valid** because it captures:
- ✅ What was said (verbatim)
- ✅ How it was said (linguistic features)
- ✅ Observable features (emotions, behaviors, cognitions)
- ✅ Context (source, speaker, timestamp)
- ✅ Relational structure (contradictions, elaborations)

**NO framework-specific categorization** = timeless reusability.

---

## 4. Storage Schema

### 4.1 PostgreSQL + JSONB (Recommended for Professional)

```sql
-- Universal Fragments Table
CREATE TABLE fragments (
  -- Identity
  id UUID PRIMARY KEY DEFAULT uuid_v7(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,

  -- Type & Source
  type TEXT NOT NULL CHECK (type IN (
    'explicit_statement', 'implicit_reveal', 'question_response',
    'monologue', 'dialogue_exchange', 'behavior_described',
    'behavior_observed', 'decision_made', 'pattern_reported',
    'biographical_fact', 'environmental_context', 'temporal_pattern',
    'contradiction', 'elaboration', 'correction', 'meta_reflection'
  )),

  source JSONB NOT NULL,              -- Full source metadata

  -- Content
  content JSONB NOT NULL,             -- Verbatim + 5W1H

  -- Observables (Searchable)
  observables JSONB NOT NULL,
  emotional_valence TEXT,             -- Indexed for quick filtering
  behavioral_verbs TEXT[],            -- Indexed for pattern detection
  domain_references TEXT[],           -- Indexed for domain analysis

  -- Linguistic
  linguistic JSONB NOT NULL,

  -- Relations
  relations JSONB,

  -- Quality
  quality JSONB NOT NULL,
  confidence NUMERIC(3,2) NOT NULL,
  significance NUMERIC(3,2) NOT NULL,

  -- Extraction
  extraction JSONB NOT NULL,

  -- Audit
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- Indexes for Performance
CREATE INDEX idx_fragments_subject ON fragments(subject_id);
CREATE INDEX idx_fragments_type ON fragments(type);
CREATE INDEX idx_fragments_emotional_valence ON fragments(emotional_valence);
CREATE INDEX idx_fragments_behavioral_verbs ON fragments USING GIN(behavioral_verbs);
CREATE INDEX idx_fragments_domain_references ON fragments USING GIN(domain_references);
CREATE INDEX idx_fragments_significance ON fragments(significance DESC);
CREATE INDEX idx_fragments_created ON fragments(created_at DESC);

-- Full-Text Search on Verbatim Content
CREATE INDEX idx_fragments_content_fts ON fragments
  USING GIN(to_tsvector('english', content->>'verbatim'));

-- JSONB Indexes for Deep Queries
CREATE INDEX idx_fragments_observables ON fragments USING GIN(observables);
CREATE INDEX idx_fragments_linguistic ON fragments USING GIN(linguistic);
```

---

### 4.2 JSON File Storage (Lite Version)

```
fragments/
├── subject_uuid/
│   ├── fragments.json              # All fragments for subject
│   ├── fragments_by_type/
│   │   ├── explicit_statements.json
│   │   ├── behaviors.json
│   │   └── ...
│   └── metadata.json               # Subject-level stats
```

**fragments.json:**
```json
{
  "subject_id": "alan_nicolas_uuid",
  "total_fragments": 287,
  "extraction_date": "2025-01-14",
  "extractor_version": "2.0.0",

  "fragments": [
    {
      "fragment_id": "01930e8c-7890-7890-9abc-def012345678",
      "type": "explicit_statement",
      "source": { /* ... */ },
      "content": { /* ... */ },
      "observables": { /* ... */ },
      "linguistic": { /* ... */ },
      "relations": { /* ... */ },
      "quality": { /* ... */ },
      "extraction": { /* ... */ }
    },
    // ... 286 more fragments
  ]
}
```

---

## 5. Interpretation Layer (Separate from Fragments)

### Framework-Specific Detectors Operate on Universal Fragments

```
┌─────────────────────────────────────────────────────────────┐
│                  UNIVERSAL FRAGMENTS                         │
│                  (Evidence Layer)                            │
│                                                              │
│  287 fragments extracted in 2025                            │
│  Stored with zero framework assumptions                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│            INTERPRETATION LAYER (2025-2125+)                 │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ Big Five Detector (2025)                           │    │
│  │ Input:  287 universal fragments                    │    │
│  │ Output: 5 traits × scores + evidence mapping       │    │
│  │ Storage: big_five_detections table                 │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ Schema Therapy Detector (2025)                     │    │
│  │ Input:  287 universal fragments                    │    │
│  │ Output: Schemas + Modes + Coping styles           │    │
│  │ Storage: schema_therapy_detections table           │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │ NeuroQuantum Framework Detector (2125)             │    │
│  │ Input:  287 universal fragments (unchanged!)       │    │
│  │ Output: New dimensions not yet invented            │    │
│  │ Storage: neuroquantum_detections table (future)    │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  Key: ALL detectors read from SAME universal fragments     │
└─────────────────────────────────────────────────────────────┘
```

---

### Example: Big Five Detector (2025)

```sql
-- Interpretation Storage (Separate from Fragments)
CREATE TABLE big_five_detections (
  id UUID PRIMARY KEY,
  fragment_id UUID REFERENCES fragments(id),
  subject_id UUID REFERENCES subjects(id),

  -- Big Five Trait
  trait TEXT NOT NULL CHECK (trait IN (
    'openness', 'conscientiousness', 'extraversion',
    'agreeableness', 'neuroticism'
  )),

  -- Detection Result
  intensity NUMERIC(3,2) NOT NULL,
  confidence NUMERIC(3,2) NOT NULL,
  evidence_mapping TEXT NOT NULL,  -- WHY this fragment → this trait

  -- Detection Metadata
  detector_version TEXT NOT NULL,
  detection_timestamp TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(fragment_id, trait)  -- One detection per fragment per trait
);
```

**Query Example:**
```sql
-- Get all fragments that indicate High Openness
SELECT
  f.*,
  bfd.intensity,
  bfd.confidence,
  bfd.evidence_mapping
FROM fragments f
JOIN big_five_detections bfd ON f.id = bfd.fragment_id
WHERE bfd.trait = 'openness'
  AND bfd.intensity > 0.70
ORDER BY bfd.intensity DESC;
```

---

### Example: Schema Therapy Detector (2025)

```sql
CREATE TABLE schema_therapy_detections (
  id UUID PRIMARY KEY,
  fragment_id UUID REFERENCES fragments(id),
  subject_id UUID REFERENCES subjects(id),

  -- Schema Therapy Constructs
  detection_type TEXT NOT NULL CHECK (detection_type IN (
    'early_maladaptive_schema',
    'schema_mode',
    'coping_style',
    'emotional_need'
  )),

  construct_name TEXT NOT NULL,  -- e.g., "Mistrust/Abuse Schema"
  intensity NUMERIC(3,2) NOT NULL,
  confidence NUMERIC(3,2) NOT NULL,
  evidence_mapping TEXT NOT NULL,

  -- Detection Metadata
  detector_version TEXT NOT NULL,
  detection_timestamp TIMESTAMPTZ DEFAULT NOW()
);
```

**Query Example:**
```sql
-- Get all fragments indicating Mistrust/Abuse Schema
SELECT
  f.*,
  std.construct_name,
  std.intensity
FROM fragments f
JOIN schema_therapy_detections std ON f.id = std.fragment_id
WHERE std.detection_type = 'early_maladaptive_schema'
  AND std.construct_name = 'Mistrust/Abuse'
ORDER BY std.intensity DESC;
```

---

## 6. Implementation for InnerLens Lite

### 6.1 Updated Fragment Extractor Agent

**Agent:** `@fragment-extractor`
**Input:** Text document (transcript, email, chat, etc.)
**Output:** `fragments.json` (universal format)
**Time:** ~60 seconds (vs 30 seconds before, due to richer extraction)
**Cost:** ~$0.08 (vs $0.05 before)

**Extraction Prompt:**

```markdown
# Universal Fragment Extraction

You are a behavioral evidence extraction specialist. Your task is to extract
UNIVERSAL FRAGMENTS from text that will remain valid for 100+ years, regardless
of which psychological frameworks are applied.

## Core Principle

Extract WHAT HAPPENED (observables), not WHAT IT MEANS (interpretation).

## Fragment Types to Extract

1. EXPLICIT_STATEMENT - Direct statements ("I believe X")
2. IMPLICIT_REVEAL - Indirect revelations
3. QUESTION_RESPONSE - Q&A exchanges
4. BEHAVIOR_DESCRIBED - Descriptions of actions
5. DECISION_MADE - Choices with reasoning
6. PATTERN_REPORTED - Self-reported habits

## Extraction Rules

### DO:
✅ Capture verbatim quotes
✅ Preserve full context (before/after)
✅ Identify observable emotional words ("love", "hate", "excited")
✅ Extract behavioral verbs ("avoid", "create", "delegate")
✅ Note cognitive indicators ("analyze", "think", "believe")
✅ Record domain references (what topics are mentioned)
✅ Identify self-attribution ("I" statements vs "people say")
✅ Mark certainty level (definite, uncertain, hedged)
✅ Note temporal scope (habitual, one-time, aspirational)

### DON'T:
❌ Categorize as "openness behavior" (framework-specific)
❌ Tag with "potential_frameworks" (limits future use)
❌ Infer traits (that's the INTERPRETATION layer's job)
❌ Psychologize ("this shows low self-esteem") - extract observables only

## Output Format

```json
{
  "fragment_id": "uuid-v7",
  "type": "explicit_statement",
  "source": { /* full source metadata */ },
  "content": {
    "verbatim": "...",
    "who": "...",
    "what": "...",
    "how": "...",
    "where": "...",
    "when": "...",
    "why": "..."
  },
  "observables": {
    "emotional_valence": "positive|negative|neutral|mixed",
    "emotional_words": [...],
    "cognitive_indicators": [...],
    "behavioral_verbs": [...],
    "domain_references": [...],
    "self_attribution": true|false,
    "certainty_level": "definite|probable|uncertain",
    "temporal_scope": "habitual|one-time|aspirational"
  },
  "linguistic": { /* linguistic features */ },
  "quality": {
    "confidence": 0.0-1.0,
    "significance": 0.0-1.0,
    "why_significant": "..."
  }
}
```

## Self-Critique (5 Tests)

After extracting each fragment, run these tests:

1. **Significance Check** - Is this psychologically rich?
2. **Verbatim Validation** - Is the quote exact?
3. **Observable-Only Check** - Did I avoid interpretation?
4. **Context Completeness** - Is context sufficient?
5. **Duplicate Check** - Is this redundant with previous fragments?

If any test fails, refine the fragment before outputting.

## Target Extraction

Extract 100-150 fragments from a 3000-word document.
Prioritize quality over quantity.
```

---

### 6.2 Updated Psychologist Agent

**Agent:** `@psychologist`
**Input:** `fragments.json` (universal format)
**Task:** `tasks/analyze-bigfive.md`
**Output:** `big_five_detections.json`
**Time:** ~90 seconds (unchanged)
**Cost:** ~$0.12 (unchanged)

**Analysis Prompt:**

```markdown
# Big Five Trait Detection from Universal Fragments

You are analyzing **universal behavioral fragments** to detect Big Five traits.

## Input Format

You receive fragments in UNIVERSAL format:
- `observables.*` - Observable features (emotions, behaviors, cognitions)
- `linguistic.*` - How it was said
- `content.verbatim` - What was actually said
- NO framework-specific categorization

## Your Task

For each trait (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism):

1. **Filter Relevant Fragments**
   - Read `observables.emotional_words`, `behavioral_verbs`, `cognitive_indicators`
   - Identify fragments that MAY inform this trait

2. **Detect Trait Indicators**
   - Openness: "unconventional", "abstract", "creative", "explore"
   - Conscientiousness: "organized", "plan", "deadline", "thorough"
   - Extraversion: "social", "energizing", "party", "talkative"
   - Agreeableness: "empathy", "harmony", "helping", "compassion"
   - Neuroticism: "anxious", "worried", "stressed", "emotional"

3. **Calculate Intensity**
   - 0.0-0.3: Low indicator
   - 0.4-0.6: Moderate indicator
   - 0.7-1.0: Strong indicator

4. **Assign Confidence**
   - Based on fragment `quality.confidence` and evidence strength

5. **Generate Evidence Mapping**
   - Explain WHY this fragment indicates this trait
   - Reference specific `observables.*` fields

## Output Format

```json
{
  "fragment_id": "uuid",
  "trait": "openness",
  "intensity": 0.85,
  "confidence": 0.78,
  "evidence_mapping": "Fragment shows high openness via cognitive_indicators ['unconventional', 'abstract'] and behavioral_verbs ['exploring']. Self-attribution is true and certainty_level is 'definite', increasing confidence."
}
```

## Key Insight

You are INTERPRETING universal evidence through a Big Five lens.
The fragments themselves contain NO Big Five categorization.
This same set of fragments can be interpreted by other frameworks later.
```

---

### 6.3 File Structure (Lite)

```
innerlens-lite-output/
├── alan_nicolas/
│   ├── fragments.json                    # Universal fragments (evidence layer)
│   ├── interpretations/
│   │   ├── big_five_detections.json      # Big Five interpretations
│   │   ├── big_five_profile.yaml         # Final Big Five profile
│   │   └── hexaco_detections.json        # (v1.1) HEXACO interpretations
│   └── metadata.json                     # Subject-level metadata
```

---

## 7. Migration Path for Professional

### Current Professional Fragments → Universal Fragments

**Step 1: Schema Migration**

```sql
-- Add new universal fields to existing fragments table
ALTER TABLE fragments
  ADD COLUMN content_structured JSONB,          -- 5W1H decomposition
  ADD COLUMN observables JSONB,                 -- Observable features
  ADD COLUMN linguistic JSONB,                  -- Linguistic features
  ADD COLUMN relations JSONB;                   -- Fragment relations

-- Backfill from existing data
UPDATE fragments SET
  content_structured = jsonb_build_object(
    'verbatim', content->>'text',
    'who', extract_who(content->>'text'),        -- New function
    'what', extract_what(content->>'text'),      -- New function
    -- ... etc
  ),
  observables = jsonb_build_object(
    'emotional_words', emotional_markers,
    'behavioral_verbs', extract_verbs(content->>'text'),
    -- ... etc
  );
```

**Step 2: Maintain Backward Compatibility**

```sql
-- Create view for legacy code
CREATE VIEW fragments_legacy AS
SELECT
  id,
  subject_id,
  fragment_type AS type,
  content->>'text' AS text,
  psychological_theme,
  layer,
  domains,
  emotional_markers,
  confidence
FROM fragments;
```

**Step 3: Update Detectors**

- Big Five detector: Read from `observables.*` instead of pre-categorized fields
- Schema Therapy detector: Read from `observables.*` + `linguistic.*`
- All detectors write to SEPARATE interpretation tables

---

## 8. Benefits of Universal Architecture

### 8.1 True Framework Independence

```
YEAR 2025: Extract 287 fragments
  ↓
  ├─ Big Five Detector → 5 traits
  ├─ Schema Therapy Detector → Schemas + Modes
  ├─ Enneagram Detector → Type + Wing
  └─ HEXACO Detector → 6 traits

YEAR 2050: Same 287 fragments (unchanged!)
  ↓
  ├─ Big Five Detector v5.0 → Better accuracy
  ├─ NeuroPersonality Framework → New dimensions
  └─ Quantum Consciousness Model → New insights

YEAR 2125: Same 287 fragments (unchanged!)
  ↓
  └─ Frameworks not yet invented → Can still analyze
```

**Key:** Fragments never expire, only interpretations improve.

---

### 8.2 Research Validity

**Longitudinal Studies (100+ years):**
- Extract fragments in 2025
- Re-analyze same fragments in 2050 with better frameworks
- Re-analyze same fragments in 2100 with even better frameworks
- **Evidence remains constant, interpretations improve**

**Cross-Cultural Research:**
- Same observable features (emotions, behaviors, cognitions) across cultures
- Framework-specific interpretations may vary
- Universal fragments enable meta-analysis

---

### 8.3 Legal/Ethical Durability

**Data Retention Policies:**
- Store evidence (fragments) with 100-year retention
- Interpretation results (trait detections) can be deleted/regenerated
- Complies with "right to explanation" (show original evidence)
- Supports "right to reinterpretation" (re-run with new frameworks)

---

### 8.4 AI Training Data

**For Future AI Models:**
- Universal fragments = gold standard training data
- No framework bias baked into evidence
- Can train ANY personality detection model
- Can evaluate model accuracy against ground truth (verbatim evidence)

---

## 9. Cost/Performance Impact (Lite)

### Old Architecture (Framework-Biased)

```
Agent 1: @fragment-extractor (Simple)
  - Extraction: 30 seconds
  - Cost: $0.05
  - Output: 127 generic fragments

Agent 2: @psychologist (Big Five)
  - Analysis: 90 seconds
  - Cost: $0.12
  - Output: Big Five profile

Agent 3: @quality-assurance
  - Validation: 30 seconds
  - Cost: $0.03
  - Output: Validated profile

Total: 150 seconds, $0.20
```

---

### New Architecture (Universal)

```
Agent 1: @fragment-extractor (Universal)
  - Extraction: 60 seconds (+30s for rich extraction)
  - Cost: $0.08 (+$0.03)
  - Output: 100-150 UNIVERSAL fragments

Agent 2: @psychologist (Big Five)
  - Analysis: 90 seconds (unchanged)
  - Cost: $0.12 (unchanged)
  - Output: Big Five detections

Agent 3: @quality-assurance
  - Validation: 30 seconds (unchanged)
  - Cost: $0.03 (unchanged)
  - Output: Validated profile

Total: 180 seconds, $0.23
```

**Impact:**
- ⏱️ +30 seconds (2.5 min → 3 min, still well under 5 min target)
- 💰 +$0.03 per profile (15% increase, negligible)
- 🚀 **INFINITE future value** (fragments never expire)

**ROI Calculation:**
- Upfront cost: +$0.03 per profile
- Future benefit: Can add HEXACO, MBTI, Enneagram, etc. WITHOUT re-extraction
- Break-even: After 2 frameworks (saves $0.08 extraction cost each time)
- 10-year ROI: **$0.03 investment → $0.40+ savings** (assuming 5+ frameworks)

---

## 10. Implementation Checklist

### Phase 1: Schema Design (Week 1)

- [x] Define UniversalFragment interface
- [x] Create fragment type enum
- [x] Design observables structure
- [x] Design linguistic features structure
- [x] Create example fragments
- [ ] Review with user for approval

### Phase 2: Extractor Implementation (Week 1-2)

- [ ] Update `@fragment-extractor` agent specification
- [ ] Create universal extraction prompt
- [ ] Implement 5-test self-critique
- [ ] Create `fragments.json` template
- [ ] Test extraction on 3 sample documents

### Phase 3: Detector Updates (Week 2)

- [ ] Update `@psychologist` agent for universal fragments
- [ ] Create Big Five detector prompt
- [ ] Implement fragment → trait mapping logic
- [ ] Create `big_five_detections.json` template
- [ ] Test detection on universal fragments

### Phase 4: Validation (Week 2)

- [ ] Run full pipeline on 10 test subjects
- [ ] Validate fragment quality (significance, uniqueness)
- [ ] Validate detection accuracy (75%+ correlation)
- [ ] Compare old vs new architecture results
- [ ] Document any issues/refinements

### Phase 5: Documentation (Week 2)

- [ ] Update FINAL-ARCHITECTURE.md with universal fragments
- [ ] Create UNIVERSAL-FRAGMENTS-SPEC.md (this document)
- [ ] Update PRD.md with new schema
- [ ] Update EPIC-0-FOUNDATION.md stories
- [ ] Create migration guide for v1.1+ frameworks

---

## 11. Future Framework Support

### v1.1: HEXACO (Honesty-Humility)

**New Detector:** `tasks/analyze-hexaco.md`
**Input:** Same universal fragments
**Output:** `hexaco_detections.json`
**Additional Cost:** $0.12 (detection only, NO re-extraction)
**Timeline:** 1 week (just create new detector)

---

### v1.2: Schema Therapy

**New Detector:** `tasks/analyze-schema-therapy.md`
**Input:** Same universal fragments
**Output:** `schema_therapy_detections.json`
**Detects:**
- Early Maladaptive Schemas
- Schema Modes
- Coping Styles
- Emotional Needs

**Additional Cost:** $0.15 (more complex detection)
**Timeline:** 2 weeks

---

### v2.0: MBTI + Enneagram + DISC

**New Detectors:**
- `tasks/analyze-mbti.md`
- `tasks/analyze-enneagram.md`
- `tasks/analyze-disc.md`

**Input:** Same universal fragments
**Output:** 3 separate detection files
**Additional Cost:** $0.30 total (3 × $0.10)
**Timeline:** 3-4 weeks

---

### v3.0: Professional Integration

**Merge:** Universal fragments from Lite can be imported into Professional
**Benefit:** Start with Lite (free), upgrade to Professional later
**Migration:** Zero cost (fragments are compatible)

---

## 12. Conclusion

### The 100-Year Test

**Question:** Will these fragments still be useful in 2125?

**Answer:** YES, because they capture:

1. ✅ **What was said** (verbatim quotes never expire)
2. ✅ **How it was said** (linguistic features are timeless)
3. ✅ **Observable features** (emotions, behaviors, cognitions are universal)
4. ✅ **Source context** (who, when, where, medium)
5. ✅ **No framework assumptions** (interpretation happens separately)

**Analogy:**
```
Universal Fragments = Fossil Evidence
  ↓
Big Five Framework = Evolutionary Theory v1.0 (1990s)
Schema Therapy = Evolutionary Theory v2.0 (2000s)
Future Framework = Evolutionary Theory v5.0 (2125)
  ↑
Fossils remain valid regardless of which theory interprets them
```

### Final Recommendation

**Adopt universal fragments architecture NOW** because:

1. ✅ Minimal cost increase (+$0.03 per profile)
2. ✅ Minimal time increase (+30 seconds)
3. ✅ Infinite future scalability (add frameworks without re-extraction)
4. ✅ True framework independence (as user requested)
5. ✅ Research-grade evidence quality
6. ✅ Legal/ethical durability (100-year retention)
7. ✅ AI training data gold standard

**This is the RIGHT architecture for the 100-year vision.**

---

**Document Status:** 🎯 **READY FOR APPROVAL**
**Next Step:** User review and decision
**Implementation Impact:** +1-2 days for enhanced extraction, +$0.03/profile
**Strategic Value:** Incalculable (enables all future framework expansion)

---

**Author:** Dev Lead
**Reviewer:** Product Owner, User
**Approved:** [PENDING USER DECISION]
**Date:** 2025-01-14
