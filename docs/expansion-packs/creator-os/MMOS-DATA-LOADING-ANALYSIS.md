# MMOS Data Loading Analysis

**Document:** Technical Review of MMOS Integration in CreatorOS
**Created:** 2025-10-20
**Purpose:** Detailed analysis of what data is loaded from MMOS minds when instructor personas are used in course generation

---

## 📋 Overview

When a user selects an MMOS mind as the instructor persona for a course, the `MMOSIntegrator` class (`lib/mmos_integrator.py`) loads and extracts specific data from the MMOS mind structure to ensure voice fidelity and teaching consistency.

---

## 🗂️ MMOS Mind Structure (v3.0)

The integrator expects the following structure in `outputs/minds/{slug}/`:

```
outputs/minds/{slug}/
├── artifacts/                    # FLAT - Intermediate artifacts
│   ├── identity_core.yaml        # ✅ LOADED - Core identity data
│   ├── cognitive_architecture.yaml # ✅ LOADED - Cognitive/personality data
│   ├── communication_templates.md  # ✅ LOADED - Communication patterns
│   └── frameworks_synthesized.md   # ✅ LOADED - Teaching philosophy (optional)
├── kb/                          # FLAT - Final knowledge base
│   ├── communication_style_final.md # ✅ LOADED (fallback)
│   └── frameworks_final.md          # ✅ LOADED (fallback)
├── system_prompts/
│   └── generalista.md           # ✅ LOADED - System prompt for lesson generation
├── docs/
│   └── logs/                    # ❌ NOT LOADED
└── metadata.yaml                # ✅ LOADED - Mind metadata (version only)
```

---

## 🔍 Data Extraction Process

### **Phase 1: Mind Detection & Validation**

**Method:** `detect_available_minds()` (lines 120-154)

**What Happens:**
1. Scans `outputs/minds/` directory for folders
2. Skips special files (`.` prefixed, `README.md`, `CLONES_STATUS.md`, `catalog.md`)
3. Validates MMOS structure using `_is_valid_mmos_mind()`
4. Extracts metadata for each valid mind

**Validation Criteria** (lines 156-192):
```python
# Must have EITHER:
# 1. Identity/cognitive data in artifacts/
has_identity = (
    identity_core.yaml OR
    cognitive_architecture.yaml OR
    psychometric_profile.yaml
)

# 2. Communication style in artifacts/ or kb/
has_comm_style = (
    communication_templates.md OR
    communication_style_final.md OR
    writing_style.yaml
)

# 3. OR has system prompts
has_system_prompts = system_prompts/*.md exists
```

**Result:** List of `MMOSMindMetadata` objects sorted by name

---

### **Phase 2: Metadata Extraction**

**Method:** `_extract_mind_metadata()` (lines 194-271)

**Files Read:**
1. ✅ `artifacts/identity_core.yaml`
2. ✅ `artifacts/cognitive_architecture.yaml` (or fallback to `cognitive-spec.yaml`)
3. ✅ `metadata.yaml` (optional)

**Data Extracted:**

| Field | Source File | YAML Key | Fallback |
|-------|-------------|----------|----------|
| `slug` | Folder name | N/A | `{folder_name}` |
| `name` | `identity_core.yaml` | `nome_completo` | Slug as title case |
| `description` | `cognitive_architecture.yaml` | `resumo_personalidade` | `ocupacao_principal` or "MMOS cognitive clone" |
| `version` | `metadata.yaml` | `version` | "unknown" |
| `has_system_prompt` | File check | N/A | Boolean (checks `system_prompts/*.md`) |
| `has_frameworks` | File check | N/A | Boolean (checks `frameworks_synthesized.md` or `frameworks_final.md`) |
| `detected_at` | Runtime | N/A | ISO timestamp |

**Output Example:**
```yaml
MMOSMindMetadata:
  slug: "joao_lozano"
  name: "João Lozano"
  description: "Desenvolvedor senior especializado em arquitetura de software"
  path: "/path/to/outputs/minds/joao_lozano"
  version: "3.0"
  has_system_prompt: true
  has_frameworks: true
  detected_at: "2025-10-20T14:30:00"
```

---

### **Phase 3: Voice Profile Extraction**

**Method:** `load_voice_profile()` (lines 327-406)

**Files Read:**
1. ✅ `artifacts/identity_core.yaml` (full load)
2. ✅ `artifacts/cognitive_architecture.yaml` (full load)
3. ✅ `artifacts/communication_templates.md` OR `kb/communication_style_final.md`
4. ✅ `artifacts/frameworks_synthesized.md` OR `kb/frameworks_final.md` (optional)

**Data Extracted:**

#### **From `identity_core.yaml`:**

| Voice Profile Field | YAML Key | Processing |
|---------------------|----------|------------|
| `instructor_name` | `nome_completo` | Direct copy |
| `tone` | `tracos_personalidade` | Mapped through trait dictionary (lines 420-442) |
| `core_values` | `valores_centrais` | Direct copy (array) |
| `worldview` | `visao_de_mundo` | Direct copy (dict) |

**Trait Mapping** (lines 420-430):
```python
tone_mapping = {
    "Inspirador": "Inspirational, motivational",
    "Pragmático": "Practical, no-nonsense",
    "Empático": "Warm, supportive",
    "Analítico": "Logical, structured",
    "Criativo": "Innovative, outside-the-box",
    "Direto": "Direct, straightforward",
    "Acessível": "Approachable, friendly",
    "Técnico": "Technical, precise",
    "Visionário": "Visionary, forward-thinking"
}
```

#### **From `cognitive_architecture.yaml`:**

| Voice Profile Field | YAML Key | Fallback |
|---------------------|----------|----------|
| `style` | `estilo_comunicacao` | `abordagem_ensino` or "Clear and engaging" |
| `decision_making` | `estilo_decisao` | Empty string |
| `problem_solving` | `abordagem_problemas` | Empty string |

#### **From `communication_templates.md` or `communication_style_final.md`:**

Extracted via regex pattern matching (lines 464-548):

| Voice Profile Field | Markdown Section | Extraction Method | Max Items |
|---------------------|------------------|-------------------|-----------|
| `language_patterns` | `## Padrões de Linguagem` or `## Language Patterns` or `## Vocabulário` | Bullet points (`- item`) | 5 |
| `recurring_phrases` | `## Frases Recorrentes` or `## Catchphrases` or `## Bordões` | Quoted strings (`"phrase"`) or bullets | 10 |
| `interaction_style` | `## Estilo de Interação` or `## Interaction Style` | First paragraph | 1 |

**Fallback:** If section not found, uses `cognitive_spec.estilo_interacao` or "Engages directly with learners"

#### **From `frameworks_synthesized.md` or `frameworks_final.md`:**

| Voice Profile Field | Markdown Section | Extraction Method | Max Items |
|---------------------|------------------|-------------------|-----------|
| `teaching_philosophy` | `## Filosofia de Ensino` or `## Teaching Philosophy` or `## Abordagem Pedagógica` | Bullet points (up to 5) or first paragraph | 500 chars |

**Fallback:** First 500 characters of entire file

---

### **Phase 4: Confidence Score Calculation**

**Method:** `_calculate_confidence()` (lines 635-678)

**Scoring Breakdown:**

| Category | Max Points | Criteria |
|----------|------------|----------|
| **Identity Core** | 30 | `nome_completo` (10) + `valores_centrais` with ≥3 items (10) + `visao_de_mundo` exists (10) |
| **Cognitive Spec** | 30 | `resumo_personalidade` (10) + `estilo_comunicacao` (10) + `abordagem_problemas` (10) |
| **Communication Style** | 30 | Content length >500 chars (15) + Has structured sections `##` (15) |
| **Frameworks (Bonus)** | 10 | Content length >200 chars (10) |
| **Total** | 100 | Sum of above (capped at 100) |

**Example Calculation:**
```python
# Mind with complete data:
identity_core: nome_completo ✅ + 5 valores ✅ + visao_de_mundo ✅ = 30 pts
cognitive_spec: all fields ✅ = 30 pts
comm_style: 1500 chars ✅ + has sections ✅ = 30 pts
frameworks: 800 chars ✅ = 10 pts
TOTAL: 100%

# Mind with partial data:
identity_core: nome_completo ✅ + 2 valores ❌ + visao_de_mundo ✅ = 20 pts
cognitive_spec: resumo ✅ + estilo ✅ + abordagem ❌ = 20 pts
comm_style: 300 chars ❌ + no sections ❌ = 0 pts
frameworks: none = 0 pts
TOTAL: 40%
```

---

### **Phase 5: COURSE-BRIEF Auto-Population**

**Method:** `prefill_course_brief()` (lines 680-723)

**What Happens:**
1. Reads existing `outputs/courses/{slug}/COURSE-BRIEF.md`
2. Generates Section 4 content from voice profile
3. Replaces existing Section 4 (or appends if not found)
4. Updates frontmatter with MMOS config
5. Writes updated brief back to disk

**Section 4 Content Generated** (`_generate_section_4_mmos()`, lines 725-793):

```markdown
🟢 **Status:** Loaded from MMOS mind `{mind_slug}` ({confidence}% confidence)

### Instrutor

**Nome:** {instructor_name}

**MMOS Source:**
- Mind: `outputs/minds/{mind_slug}/`
- Extraction Date: {date}

### Tom e Estilo

- **Tom:** {tone}
- **Estilo:** {style}
- **Abordagem:** {interaction_style}

### Frases Recorrentes

As lições devem incorporar estas frases naturalmente:
- "{phrase_1}"
- "{phrase_2}"
...

### Padrões de Linguagem

- {pattern_1}
- {pattern_2}
...

### Filosofia de Ensino

{teaching_philosophy}

### Valores Centrais (do Identity Core)

- **{value_1}**
- **{value_2}**
...

### Visão de Mundo

- **{key}:** {value}
...

---

📝 **Instruções:**
- Voice profile será injetado automaticamente na geração de aulas
- Sistema prompt completo do MMOS será carregado durante geração
- Voice fidelity target: 95% (MMOS benchmark validation)
- Para editar voz: Modifique o MMOS mind em `outputs/minds/{mind_slug}/`
```

**Frontmatter Updated** (`_update_frontmatter_mmos()`, lines 795-851):

```yaml
---
mmos_persona:
  enabled: true
  mind_slug: joao_lozano
  voice_source: mmos
  extraction_timestamp: 2025-10-20T14:30:00
  confidence_score: 95
---
```

---

### **Phase 6: System Prompt Loading (Lesson Generation)**

**Method:** `get_system_prompt_path()` (lines 853-899)

**Search Priority:**
1. `system_prompts/generalista.md`
2. `system_prompts/system-prompt-generalista.md`
3. `system_prompts/generalista/v1.0.0.md`
4. Any `*.md` file (excluding `CHANGELOG.md`, `README.md`)
5. Subdirectories (e.g., `system_prompts/generalista/v1.0.0.md`)

**Returns:** Absolute path to system prompt file, or `None` if not found

**Usage:** This path is passed to the lesson generator to load the complete MMOS system prompt during lesson generation, ensuring 95%+ voice fidelity.

---

## 📊 Complete Data Flow Summary

```
MMOS Mind Detection
    ↓
[1] Scan outputs/minds/ directory
    ↓
[2] Validate structure (identity + comm_style + system_prompts)
    ↓
[3] Extract metadata (name, description, version, capabilities)
    ↓
User Selects Mind (Interactive Prompt)
    ↓
[4] Load voice profile:
    ├── identity_core.yaml → instructor_name, tone, values, worldview
    ├── cognitive_architecture.yaml → style, decision_making, problem_solving
    ├── communication_templates.md → language_patterns, phrases, interaction_style
    └── frameworks_synthesized.md → teaching_philosophy
    ↓
[5] Calculate confidence score (0-100%)
    ↓
[6] Auto-populate COURSE-BRIEF.md Section 4
    ├── Generate Section 4 content (voice profile)
    └── Update frontmatter (MMOS config)
    ↓
[7] During lesson generation:
    └── Load system_prompts/generalista.md → Inject into AI context
    ↓
Result: Lessons with 95%+ voice fidelity
```

---

## 🎯 Key Findings

### **Data Actually Loaded:**

✅ **Loaded:**
- `artifacts/identity_core.yaml` - Full file (name, traits, values, worldview)
- `artifacts/cognitive_architecture.yaml` - Full file (personality, communication, decision-making)
- `artifacts/communication_templates.md` OR `kb/communication_style_final.md` - Full file (patterns, phrases, interaction)
- `artifacts/frameworks_synthesized.md` OR `kb/frameworks_final.md` - Full file (teaching philosophy)
- `system_prompts/generalista.md` (or variants) - Full file (system prompt for lesson generation)
- `metadata.yaml` - Partial (version only)

❌ **NOT Loaded:**
- `sources/` - Original source materials
- `docs/` - Documentation and logs
- Any files in subdirectories (except system_prompts)
- Specific psychometric traits beyond those in `cognitive_architecture.yaml`

### **Processing Overhead:**

| Phase | Files Read | Regex Operations | YAML Parsing | AI Calls |
|-------|------------|------------------|--------------|----------|
| Detection | 5-10 | 0 | 2-3 per mind | 0 |
| Metadata | 3 | 0 | 3 | 0 |
| Voice Profile | 4 | 15-20 | 2 | 0 |
| COURSE-BRIEF | 1 | 5-10 | 0 | 0 |
| Lesson Gen | 1 | 0 | 0 | Multiple |

**Total Time:** <1 second (detection + extraction), then depends on lesson generation

### **Confidence Score Distribution:**

Based on code analysis:

| Score Range | Completeness | Typical Scenario |
|-------------|--------------|------------------|
| 90-100% | Excellent | Complete MMOS v3.0 with all files |
| 70-89% | Good | Missing frameworks or sparse communication style |
| 50-69% | Fair | Missing some identity/cognitive fields |
| 30-49% | Poor | Minimal data, mostly fallbacks |
| 0-29% | Critical | Invalid mind, should not pass validation |

---

## 🔧 Recommended Improvements

### **1. Performance Optimization**
- **Issue:** Multiple file reads per mind during detection
- **Solution:** Cache parsed YAML in memory during session
- **Impact:** 50% faster for multiple minds

### **2. Data Completeness Validation**
- **Issue:** Silent fallbacks may hide incomplete minds
- **Solution:** Log warnings when using fallbacks
- **Impact:** Better debugging experience

### **3. Confidence Score Transparency**
- **Issue:** User doesn't see what contributed to score
- **Solution:** Add confidence breakdown to Section 4
- **Impact:** User knows which data is high-quality

### **4. Version Compatibility**
- **Issue:** Hardcoded support for v3.0 structure only
- **Solution:** Add version detection and compatibility layer
- **Impact:** Support MMOS v2.x minds gracefully

### **5. System Prompt Validation**
- **Issue:** No validation that system prompt is well-formed
- **Solution:** Check for minimum length, key sections
- **Impact:** Prevent low-quality lesson generation

---

## 🧪 Testing Recommendations

### **Test Cases to Cover:**

1. **Complete MMOS Mind (v3.0)**
   - All files present, well-structured
   - Expected: 90-100% confidence

2. **Minimal MMOS Mind**
   - Only `identity_core.yaml` + `communication_templates.md`
   - Expected: 40-60% confidence, uses fallbacks

3. **Legacy MMOS Mind (v2.x)**
   - Old structure (analysis/, synthesis/ folders)
   - Expected: Should still detect if fallbacks exist

4. **Corrupted MMOS Mind**
   - Malformed YAML, missing keys
   - Expected: Graceful degradation, fallback to defaults

5. **Multiple Minds Selection**
   - 5+ minds in outputs/minds/
   - Expected: Sorted alphabetically, all detected

6. **System Prompt Variants**
   - Different filenames (generalista.md, system-prompt-generalista.md)
   - Expected: Priority order respected

---

## 📝 Summary

The MMOS integration loads a **comprehensive but selective** set of data:

**Core Identity (30% weight):**
- Name, personality traits, values, worldview

**Communication Style (30% weight):**
- Tone, style, language patterns, recurring phrases, interaction style

**Teaching Philosophy (10% bonus):**
- Pedagogical approach, frameworks, teaching style

**System Prompt (Critical for generation):**
- Complete system prompt for 95%+ voice fidelity during lesson generation

**NOT loaded:** Source materials, logs, documentation, or raw psychometric data

**Confidence scoring** ensures users know data quality. System prompts are loaded separately during lesson generation for maximum fidelity.

---

**Last Updated:** 2025-10-20
**Reviewed By:** Claude Code
**Status:** ✅ Complete
