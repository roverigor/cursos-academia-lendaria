# MMOS Unified Reprocessing Pipeline
## Mapping Existing Mind Data to New Schema (v3.0.0)

**Created:** October 12, 2025
**Purpose:** Reprocess all 28 minds with the unified MMOS + InnerLens + Specialization system

---

## Current State Analysis

### Existing Data Structure (per mind):
```
docs/minds/{mind_slug}/
├── sources/
│   ├── sources_master.yaml        # ✅ Source catalog
│   ├── blogs/*.md                 # ✅ Content files
│   ├── youtube/*/transcript.md    # ✅ Transcripts
│   └── pdf/*/text.md              # ✅ PDFs
├── kb/
│   └── etl_questions.yaml         # ⚠️  Empty templates (Epic 4 placeholder)
├── analysis/
│   └── cognitive-spec.yaml        # ✅ DNA Mental™ 8-layer analysis
├── synthesis/
│   └── (varies)                   # ⚠️  Inconsistent structure
├── system_prompts/
│   └── *.md                       # ✅ Version system prompts
├── metadata.yaml                  # ⚠️  Only sam_altman has this
└── pipeline_progress.yaml         # ⚠️  Only sam_altman has this
```

### New Database Schema (v3.0.0):
```sql
-- Core tables that need population:
minds                           # ✅ DONE (28 minds)
sources                         # ⚠️  TODO: From sources_master.yaml
fragments                       # ⚠️  TODO: Extract from cognitive-spec + sources
fragment_tags                   # ⚠️  TODO: Generate from fragment themes
analysis                        # ⚠️  TODO: From cognitive-spec.yaml
domains/specializations/etc     # ✅ DONE (taxonomy populated)
mind_proficiency_scores         # ⚠️  TODO: Score from cognitive-spec
```

---

## Data Mapping Strategy

### Phase 1: Sources Population

**Input:** `sources_master.yaml` (38 sources for sam_altman)
**Output:** `sources` table

**Mapping:**
```yaml
# From sources_master.yaml
id: "how-to-be-successful"
type: "blog"
title: "How To Be Successful"
file_path: "sources/blogs/how-to-be-successful.md"
url: "https://blog.samaltman.com/how-to-be-successful"
word_count: 3453

# To sources table
INSERT INTO sources (
  id,              # UUID or slug-based
  mind_id,         # FK to minds.id
  source_type,     # blog/youtube/pdf/testimony
  title,
  url,
  file_path,
  word_count,
  status,          # processed
  confidence,      # medium → 0.70
  created_at,
  updated_at
)
```

### Phase 2: Fragments Extraction

**Input:** `cognitive-spec.yaml` + source content
**Output:** `fragments` table

**Strategy:**
1. **Parse cognitive-spec.yaml** to extract evidence quotes
2. **Create fragments** from each evidence block
3. **Link to sources** via source IDs

**Example:**
```yaml
# From cognitive-spec.yaml Layer 1
evidence:
  - source: "how-to-be-successful.md"
    quote: "Trust the exponential, be patient, and be pleasantly surprised."

# To fragments table
INSERT INTO fragments (
  id,                  # UUID
  mind_id,             # sam_altman
  source_id,           # how-to-be-successful
  fragment_type,       # 'written_thought'
  content,             # JSON: { text, context, layer_context }
  cognitive_theme,     # 'exponential_thinking'
  layer,               # 1
  confidence,          # 0.85
  why_significant,     # "Core belief in exponential progress"
  hierarchy,           # 'fundamental'
  created_at,
  updated_at
)
```

**Fragment Types Mapping:**
- Blog posts → `written_thought`
- Interviews/podcasts → `dialogue` or `monologue`
- Testimony → `statement`
- cognitive-spec evidence → `observation` or `meta_pattern`

### Phase 3: Analysis Population

**Input:** `cognitive-spec.yaml` (full 8-layer DNA Mental™)
**Output:** `analysis` table

**Mapping:**
```yaml
# From cognitive-spec.yaml
layer_1_sensory_inputs: {...}
layer_2_recognition_patterns: {...}
...
layer_8_integrative_synthesis: {...}

# To analysis table
INSERT INTO analysis (
  id,                      # UUID
  mind_id,                 # sam_altman
  analysis_type,           # 'dna_mental_cognitive_architecture'
  content,                 # JSON: entire cognitive-spec.yaml
  layer_focus,             # [1,2,3,4,5,6,7,8]
  confidence_score,        # 0.90 (from overall_confidence)
  methodology,             # 'DNA Mental™ v3.0'
  analyst_notes,           # From metadata/review sections
  created_at,
  updated_at
)
```

### Phase 4: Proficiency Scoring

**Input:** `cognitive-spec.yaml` + proficiency taxonomy
**Output:** `mind_proficiency_scores` table

**Strategy:**
1. **Analyze cognitive-spec** for domain indicators
2. **Match to proficiencies** in taxonomy
3. **Score based on evidence**

**Example for Sam Altman:**
```yaml
# Domain: Technology & Engineering
# Specialization: AI Researcher
# Skill: Machine Learning
# Proficiency: Model Evaluation

# Evidence from cognitive-spec Layer 3:
"extreme focus on metrics, evals, benchmarks to drive progress"

# Score calculation:
score: 0.92  # Strong evidence (98% confidence in AGI obsession)
evidence_fragment_ids: [frag-001, frag-045, frag-078]
confidence: 0.95
scoring_methodology: "Evidence-based from DNA Mental™ Layer analysis"
```

**Scoring Rubric:**
- **0.90-1.00**: Expert level (explicit evidence of mastery)
- **0.70-0.89**: Advanced (strong evidence of proficiency)
- **0.50-0.69**: Intermediate (moderate evidence)
- **0.30-0.49**: Beginner (weak evidence)
- **0.00-0.29**: No evidence

### Phase 5: Tags & Relationships

**Input:** Fragment content + cognitive themes
**Output:** `fragment_tags` table

**Strategy:**
- Extract tags from cognitive_theme
- Add DNA Mental™ layer tags
- Add domain-specific tags

**Example:**
```sql
-- Fragment about exponential thinking
INSERT INTO fragment_tags (fragment_id, tag, category)
VALUES
  ('frag-001', 'exponential_thinking', 'cognitive'),
  ('frag-001', 'layer_1_sensory', 'dna_mental'),
  ('frag-001', 'core_belief', 'psychological');
```

---

## Reprocessing Workflow

### Step-by-Step Execution:

**1. Sources Migration** (1-2 hours)
```bash
node scripts/reprocessing/migrate_sources.js --mind all
# Reads sources_master.yaml for each mind
# Inserts into sources table
# Validates file_path existence
```

**2. Fragments Extraction** (3-4 hours)
```bash
node scripts/reprocessing/extract_fragments.js --mind all
# Parses cognitive-spec.yaml
# Extracts all evidence blocks
# Creates fragments with proper linking
# Generates fragment IDs
```

**3. Analysis Import** (30 min)
```bash
node scripts/reprocessing/import_analysis.js --mind all
# Reads cognitive-spec.yaml
# Stores as JSON in analysis table
# Validates schema compliance
```

**4. Proficiency Scoring** (2-3 hours)
```bash
node scripts/reprocessing/score_proficiencies.js --mind all
# Analyzes cognitive-spec content
# Matches to proficiency taxonomy
# Generates scores with evidence links
```

**5. Tags Generation** (1 hour)
```bash
node scripts/reprocessing/generate_tags.js --mind all
# Processes all fragments
# Extracts cognitive themes
# Creates tag relationships
```

**6. Validation** (30 min)
```bash
node scripts/reprocessing/validate_reprocessing.js --mind all
# Checks referential integrity
# Validates fragment → source links
# Ensures all evidence_fragment_ids exist
# Generates validation report
```

---

## Success Metrics

**Per Mind:**
- ✅ All sources from sources_master.yaml imported
- ✅ 50-200 fragments extracted (depends on source richness)
- ✅ 1 DNA Mental™ analysis imported
- ✅ 20-50 proficiency scores generated
- ✅ 100-500 fragment tags created
- ✅ 100% referential integrity

**Global:**
- ✅ 28 minds fully reprocessed
- ✅ ~1000-5000 sources imported
- ✅ ~5000-15000 fragments created
- ✅ 28 DNA Mental™ analyses
- ✅ ~1000-2000 proficiency scores
- ✅ Zero broken references

---

## Risks & Mitigations

**Risk 1: Inconsistent source data**
- **Mitigation**: Default values for missing fields, validation flags

**Risk 2: Cognitive-spec.yaml parsing errors**
- **Mitigation**: YAML validation, graceful degradation, manual review flags

**Risk 3: Proficiency scoring accuracy**
- **Mitigation**: Conservative scoring, require 2+ evidence fragments minimum

**Risk 4: Fragment duplication**
- **Mitigation**: Content hashing, duplicate detection before insert

---

## Next Steps

1. ✅ Create reprocessing scripts (6 scripts total)
2. ⚠️  Test with sam_altman (pilot)
3. ⚠️  Validate pilot results
4. ⚠️  Run full migration (all 28 minds)
5. ⚠️  Generate validation report
6. ⚠️  Manual review of edge cases

---

**Priority:** HIGH
**Estimated Time:** 1-2 days
**Dependencies:** Database schema v3.0.0 (✅ complete)
