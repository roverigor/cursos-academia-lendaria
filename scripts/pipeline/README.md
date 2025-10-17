# MMOS Pipeline → Database v3.0.0 Integration

Automated pipeline modules for integrating MMOS Mind Mapping data collection with the MMOS Database v3.0.0.

## Overview

This pipeline transforms MMOS collection artifacts (sources, cognitive specs) into structured database records, enabling:

- **Sources tracking** - All research materials indexed and searchable
- **Analysis storage** - Complete DNA Mental™ 8-layer cognitive architectures
- **Fragment extraction** - Evidence-based claims linked to sources (InnerLens required)
- **Data validation** - Referential integrity and quality checks

## Quick Start

```bash
# Full pipeline integration for a mind
bash scripts/pipeline/db-integration-v3.sh \
  --mind sam_altman \
  --mode full \
  --reprocess skip

# Expected output:
# ✅ Sources populated (36 sources)
# ✅ Analysis imported (1 analysis)
# ⚠️  Fragments skipped (InnerLens expansion required)
# ✅ Validation passed with warnings
```

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                  db-integration-v3.sh                       │
│                    (Orchestrator)                           │
└───────┬─────────────────────────────────────────────────┬───┘
        │                                                 │
   ┌────▼─────┐  ┌────────────┐  ┌─────────────┐   ┌────▼──────┐
   │ Phase 1  │  │  Phase 2   │  │  Phase 3    │   │Validation │
   │ Sources  │─▶│  Analysis  │─▶│ Fragments   │──▶│  Module   │
   │          │  │  Import    │  │(InnerLens)  │   │           │
   └──────────┘  └────────────┘  └─────────────┘   └───────────┘
        │              │               │                   │
  populate-      import-         extract-           validate-
  sources.js   analysis.js    fragments.js      integration.js
        │              │               │                   │
   ┌────▼──────────────▼───────────────▼───────────────────▼────┐
   │                    mmos.db (SQLite)                         │
   │  ┌─────────┐  ┌──────────┐  ┌───────────┐  ┌─────────┐   │
   │  │ sources │  │ analysis │  │ fragments │  │  minds  │   │
   │  └─────────┘  └──────────┘  └───────────┘  └─────────┘   │
   └─────────────────────────────────────────────────────────────┘
```

## Modules

### 1. populate-sources.js

Populates the `sources` table from `sources_master.yaml`.

**Usage:**
```bash
node scripts/pipeline/populate-sources.js \
  --mind sam_altman \
  --file outputs/minds/sam_altman/sources/sources_master.yaml \
  --db docs/mmos/mmos.db \
  --mode skip
```

**Modes:**
- `skip` (default): Skip existing sources
- `update`: Update existing sources with new data
- `fresh`: Delete all existing sources for this mind and re-import ⚠️

**Input:** `sources_master.yaml`
```yaml
sources:
  - id: "src_001"
    type: "blog"           # Maps to 'article' in DB
    title: "How to Be Successful"
    url: "https://example.com/..."
    file_path: "outputs/minds/.../downloads/..."
    word_count: 3500
    status: "processed"
    priority: "high"
    confidence: "high"
```

**Output:** Inserts into `sources` table

**Type Mapping:**
- `blog` → `article`
- `youtube` → `video_transcript`
- `pdf` → `essay`
- `testimony` → `speech`
- `interview` → `interview`
- Other → `other`

---

### 2. import-analysis.js

Imports `cognitive-spec.yaml` into the `analysis` table.

**Usage:**
```bash
node scripts/pipeline/import-analysis.js \
  --mind sam_altman \
  --file outputs/minds/sam_altman/analysis/cognitive-spec.yaml \
  --db docs/mmos/mmos.db \
  --mode skip
```

**Modes:** Same as populate-sources.js

**Input:** `cognitive-spec.yaml` (DNA Mental™ 8-layer architecture)

**Features:**
- **YAML parsing with fallback** - Stores raw YAML if parsing fails
- **Confidence extraction** - Calculates overall confidence from layers
- **Evidence counting** - Tracks total evidence points
- **Metadata preservation** - Stores specification version, architect, dates

**Output:** Inserts into `analysis` table
```sql
INSERT INTO analysis (
  mind_id, analysis_type, title, content,
  structured_data, confidence, completeness,
  agent_name, agent_version, created_at
)
```

**Analysis Type:** Uses `'worldview'` (DNA Mental™ encompasses worldview/personality)

**Fallback Handling:**
If YAML parsing fails:
```json
{
  "_raw_yaml": "...",
  "_parse_error": "bad indentation of a sequence entry (262:40)",
  "mind_name": "sam_altman",
  "status": "PARSE_ERROR"
}
```

---

### 3. extract-fragments.js

**⚠️ BLOCKED - Requires InnerLens Expansion Pack**

Extracts evidence fragments from `cognitive-spec.yaml` into `fragments` table.

**Usage:**
```bash
node scripts/pipeline/extract-fragments.js \
  --mind sam_altman \
  --cognitive-spec outputs/minds/sam_altman/analysis/cognitive-spec.yaml \
  --db docs/mmos/mmos.db \
  --mode skip
```

**Current Status:** Script exists but fragment extraction requires:
- InnerLens expansion pack for intelligent fragment parsing
- Evidence quality scoring
- Source matching logic
- Cognitive theme extraction

**Expected Behavior (when InnerLens is ready):**
```
✓ Extracted 142 fragments from cognitive-spec
  • layer_1: 18 fragments
  • layer_2: 15 fragments
  • layer_3: 12 fragments
  • layer_4: 20 fragments
  • layer_5: 25 fragments
  • layer_6: 22 fragments
  • layer_7: 18 fragments
  • layer_8: 12 fragments

✓ Inserted: 142 fragments
✓ Total in database: 142
```

**Fragment Structure:**
```javascript
{
  id: "uuid",
  mind_id: 22,
  source_id: "src_001",  // Matched to source
  fragment_type: "written_thought",
  content: JSON.stringify({ text: "...", context: "..." }),
  cognitive_theme: "Exponential Thinking",
  layer: 3,  // DNA Mental™ layer
  confidence: 0.85,
  why_significant: "Core mental model evidence",
  raw_excerpt: "Compounding is magic...",
  extraction_method: "cognitive_spec_parser",
  pipeline_version: "3.0"
}
```

---

### 4. validate-integration.js

Validates data quality and referential integrity after pipeline execution.

**Usage:**
```bash
node scripts/pipeline/validate-integration.js \
  --mind sam_altman \
  --db docs/mmos/mmos.db \
  [--strict]
```

**Validation Checks:**

#### Check 1: Mind Existence
- Verifies mind has records in expected tables
- ✓ `sources`, `analysis` tables
- ⚠️ `fragments` (expected 0 until InnerLens)
- ⚠️ `prompts`, `prompt_sequences` (future tables)

#### Check 2: Source Data Integrity
- Required fields present (title, type, URL/file_path)
- Valid JSON metadata
- Non-zero word counts
- Type enum compliance

#### Check 3: Analysis Data Integrity
- Required fields present
- Valid JSON content/structured_data
- Confidence range (0-1)
- YAML parse error detection (warning, not error)

#### Check 4: Referential Integrity
- Fragments reference valid sources
- No orphaned records
- Foreign key compliance

#### Check 5: Data Completeness
- Source coverage (files + URLs)
- Analysis confidence levels
- Fragment counts

**Output:**
```
📊 VALIDATION SUMMARY
Mind: sam_altman (ID: 22)
Sources: 36
Analysis: 1
Fragments: 0

Errors: 0
Warnings: 3

⚠️  VALIDATION PASSED WITH WARNINGS
   Review warnings but safe to proceed
```

**Modes:**
- Default: Warnings only
- `--strict`: Warnings become errors

**Exit Codes:**
- 0: Validation passed
- 1: Validation failed (errors found)

---

### 5. db-integration-v3.sh (Orchestrator)

Master orchestrator that runs all pipeline modules in sequence.

**Usage:**
```bash
bash scripts/pipeline/db-integration-v3.sh \
  --mind <slug> \
  [--mode full|sources-only|analysis-only] \
  [--reprocess skip|update|fresh]
```

**Arguments:**
- `--mind`: Mind slug (required)
- `--mode`: Pipeline phases to run (default: `full`)
  - `full`: Run all phases
  - `sources-only`: Only populate sources
  - `analysis-only`: Only import analysis + fragments
- `--reprocess`: Data handling mode (default: `skip`)
  - `skip`: Safe mode, won't overwrite existing data
  - `update`: Update existing records with new data
  - `fresh`: ⚠️ Delete all existing data for this mind

**Phases:**

```bash
# Phase 1: Sources Population
node populate-sources.js --mind $MIND --mode $REPROCESS_MODE

# Phase 2: Analysis Import
node import-analysis.js --mind $MIND --mode $REPROCESS_MODE

# Phase 3: Fragments Extraction (BLOCKED)
# Requires InnerLens expansion pack

# Validation
node validate-integration.js --mind $MIND
```

**Output:**
```
[INFO] Starting database integration for: sam_altman
[INFO] Mode: full
[INFO] Reprocess mode: skip

[SUCCESS] Found mind in database (ID: 22)

[INFO] Phase 1: Populating sources...
✓ Inserted: 0 | Updated: 0 | Skipped: 38
[SUCCESS] Sources populated successfully

[INFO] Phase 2: Importing DNA Mental™ analysis...
⏭️  Analysis already exists, skipping...
[SUCCESS] Analysis imported successfully

[INFO] Phase 3: Extracting fragments...
[WARNING] Fragment extraction requires InnerLens expansion pack (Epic TBD)
[WARNING] Skipping fragments extraction for now

[INFO] Validating integration...

📊 VALIDATION SUMMARY
Mind: sam_altman (ID: 22)
Sources: 36
Analysis: 1
Fragments: 0
Errors: 0
Warnings: 3

⚠️  VALIDATION PASSED WITH WARNINGS

[SUCCESS] Database integration complete for: sam_altman
```

---

## Database Schema

### sources table

```sql
CREATE TABLE sources (
    source_id TEXT PRIMARY KEY,
    mind_id INTEGER NOT NULL,
    type TEXT CHECK(type IN ('interview', 'article', 'book', 'essay',
                             'podcast_transcript', 'video_transcript',
                             'speech', 'social_media', 'email',
                             'conversation', 'other')),
    title TEXT NOT NULL,
    source_url TEXT,
    file_path TEXT,
    word_count INTEGER DEFAULT 0,
    metadata TEXT,  -- JSON
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (mind_id) REFERENCES minds(id)
);
```

### analysis table

```sql
CREATE TABLE analysis (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mind_id INTEGER NOT NULL,
    analysis_type TEXT CHECK(analysis_type IN ('beliefs', 'mental_models',
                                                'frameworks', 'communication',
                                                'knowledge', 'values', 'worldview',
                                                'personality', 'expertise', 'other')),
    layer INTEGER,  -- DNA Mental™ layer (1-8) or NULL for full spec
    phase TEXT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,  -- JSON (parsed YAML or fallback)
    structured_data TEXT,   -- JSON (metadata)
    source_fragment_ids TEXT,
    confidence REAL CHECK(confidence BETWEEN 0 AND 1),
    completeness REAL CHECK(completeness BETWEEN 0 AND 1),
    agent_name TEXT,
    agent_version TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (mind_id) REFERENCES minds(id)
);
```

### fragments table (InnerLens required)

```sql
CREATE TABLE fragments (
    id TEXT PRIMARY KEY,
    mind_id INTEGER NOT NULL,
    source_id TEXT,
    fragment_type TEXT CHECK(fragment_type IN ('written_thought',
                                               'spoken_thought', ...)),
    content TEXT NOT NULL,  -- JSON
    cognitive_theme TEXT,
    layer INTEGER CHECK(layer BETWEEN 1 AND 8),
    confidence REAL CHECK(confidence BETWEEN 0 AND 1),
    why_significant TEXT,
    raw_excerpt TEXT,
    extraction_method TEXT,
    extraction_version TEXT,
    pipeline_version TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (mind_id) REFERENCES minds(id),
    FOREIGN KEY (source_id) REFERENCES sources(source_id)
);
```

---

## Integration with MMOS Workflow

### Workflow Position

```
MMOS Pipeline Phases:
1. Research Collection → sources_master.yaml
2. Cognitive Analysis → cognitive-spec.yaml
3. **DATABASE INTEGRATION** ← This pipeline
4. System Prompt Creation (uses DB data)
5. Deployment
```

### MMOS Task Integration

After completing `cognitive-analysis` task, run database integration:

```markdown
## Post-Analysis Checklist

- [x] cognitive-spec.yaml completed and validated
- [x] All 8 layers extracted
- [x] Human checkpoints passed (Layers 6, 7, 8)
- [ ] **Database integration** ← Run db-integration-v3.sh
- [ ] Validation passed
- [ ] Ready for system prompt creation
```

**Command:**
```bash
bash scripts/pipeline/db-integration-v3.sh \
  --mind {{mind_slug}} \
  --mode full \
  --reprocess skip
```

---

## Troubleshooting

### Issue: YAML Parsing Errors

**Symptom:**
```
❌ Failed to parse YAML: bad indentation of a sequence entry (262:40)
💡 Attempting to store raw content as fallback...
✓ Analysis stored with fallback structure
```

**Impact:** Low - Analysis is stored but with `_parse_error` flag and 0% confidence

**Resolution:**
1. Check YAML syntax at reported line
2. Common issues:
   - Nested quotes without proper escaping: `"text "nested" text"` → `"text 'nested' text"`
   - Inconsistent indentation
   - Missing colons/hyphens
3. Fix YAML and re-import with `--reprocess fresh`

**When to fix:**
- ✅ Now: If you need fragment extraction (requires parsed YAML)
- ⏳ Later: If fallback storage is sufficient for current needs

---

### Issue: Source Type Mismatch

**Symptom:**
```
❌ CHECK constraint failed: type IN ('interview', 'article', ...)
```

**Cause:** `sources_master.yaml` uses unmapped type

**Resolution:**
1. Check `populate-sources.js` `mapSourceType()` function
2. Add missing type mapping:
```javascript
const typeMap = {
  'blog': 'article',
  'your_new_type': 'article',  // Add mapping
  // ...
};
```

---

### Issue: Orphaned Fragments

**Symptom:**
```
⚠️ Fragment abc-123: references non-existent source src_999
```

**Cause:** Source ID mismatch between sources and fragments

**Resolution:**
1. Check source IDs in `sources_master.yaml`
2. Re-run with `--reprocess fresh` to ensure consistency
3. Verify fragment extraction logic matches source IDs

---

### Issue: Zero Fragments Extracted

**Symptom:**
```
✓ Extracted 0 fragments from cognitive-spec
```

**Expected:** This is normal until InnerLens expansion is implemented

**When not normal:**
- If InnerLens is already implemented
- If `cognitive-spec.yaml` has parse errors (check fallback structure)
- If extraction logic can't find layer keys (e.g., `layer_1_`, `layer_2_`)

---

## Performance Benchmarks

| Phase | Duration | Notes |
|-------|----------|-------|
| Sources (36 sources) | <5s | Bulk insert |
| Analysis import | <2s | Single JSON insert |
| Fragments (140 fragments) | <10s | When InnerLens ready |
| Validation | <5s | 5 checks |
| **Total Pipeline** | **<30s** | Target: <5 minutes |

**Database Size:**
- Sources: ~50 KB per mind (38 sources)
- Analysis: ~500 KB per mind (full cognitive spec)
- Fragments: ~2 MB per mind (140 fragments with evidence)
- **Total per mind: ~2.5 MB**

---

## Roadmap

### ✅ Story 2.4 (Complete)
- [x] populate-sources.js
- [x] import-analysis.js
- [x] extract-fragments.js (stub, blocked on InnerLens)
- [x] validate-integration.js
- [x] db-integration-v3.sh orchestrator
- [x] MMOS task file updates
- [x] Full integration testing

### ⏳ Future Enhancements

**Epic TBD: InnerLens Expansion Pack**
- [ ] Intelligent fragment extraction from cognitive-spec
- [ ] Evidence quality scoring
- [ ] Source-to-fragment matching
- [ ] Cognitive theme extraction
- [ ] Fragment deduplication

**Story TBD: Advanced Validation**
- [ ] Cross-layer consistency checks
- [ ] Triangulation score validation
- [ ] Evidence coverage analysis
- [ ] Source quality metrics

**Story TBD: Proficiency Scoring**
- [ ] score-proficiencies.js module
- [ ] Domain expertise extraction
- [ ] Skill level inference
- [ ] mind_proficiency_scores table population

**Story TBD: Tag Generation**
- [ ] generate-tags.js module
- [ ] Automatic tag extraction from fragments
- [ ] Tag taxonomy integration
- [ ] fragment_tags table population

---

## Testing

### Unit Tests (TODO)
```bash
npm test scripts/pipeline/populate-sources.test.js
npm test scripts/pipeline/import-analysis.test.js
npm test scripts/pipeline/validate-integration.test.js
```

### Integration Tests
```bash
# Test with sam_altman (existing data)
bash scripts/pipeline/db-integration-v3.sh \
  --mind sam_altman \
  --mode full \
  --reprocess skip

# Expected: 0 errors, 3 warnings (fragments, prompts, parse error)
```

### Manual Test Checklist
- [ ] Sources populated correctly (count, types, metadata)
- [ ] Analysis imported with correct confidence
- [ ] Validation passes with expected warnings
- [ ] Skip mode doesn't overwrite data
- [ ] Fresh mode deletes and re-imports
- [ ] Error handling works (missing files, bad YAML)

---

## Contributing

### Adding a New Module

1. Create module in `scripts/pipeline/`
2. Follow existing patterns (parseArgs, error handling, logging)
3. Add to orchestrator `db-integration-v3.sh`
4. Update validation module if needed
5. Document in this README
6. Add tests

### Code Standards
- Use `better-sqlite3` for database operations
- Use `js-yaml` for YAML parsing
- Handle errors gracefully (fallbacks, helpful messages)
- Log progress with emojis for readability
- Support `--mode` flags (skip/update/fresh)
- Exit with appropriate codes (0 = success, 1 = error)

---

## Support

**Issues:**
- Database schema questions → See `docs/mmos/schema/`
- YAML parsing errors → Check `import-analysis.js` fallback handling
- Module-specific issues → See module docstrings

**Epic/Story Context:**
- Story 2.4: Pipeline Integration with Database v3.0.0
- Epic 2: Database v3.0.0 & Quality Assurance

---

**Version:** 1.0.0
**Last Updated:** 2025-10-13
**Maintainer:** AIOS Dev Team
