# Task: Save Fragments to MMOS Database

**Task ID:** save-fragments-to-mmos
**Agent:** @data-integrator (or manual execution)
**Version:** 1.0.0
**Dependencies:** MIU fragments.json file, MMOS database

---

## Purpose

Save InnerLens MIU fragments to the MMOS database for persistent storage and cross-framework reuse.

**Why This Matters:**
- MIUs are framework-agnostic (extracted once, used for Big Five, HEXACO, etc)
- Database persistence enables historical tracking
- Integration with MMOS Mind Mapper for AI cloning

---

## Inputs

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `mind_slug` | string | Yes | Mind identifier (slug format) | `"alan_nicolas"` |
| `fragments_file` | path | Yes | Path to fragments.json | `"testing/results/alan_fragments.json"` |
| `source_file` | path | Yes | Path to original text source | `"testing/data/alan_text.txt"` |
| `source_title` | string | Yes | Human-readable title | `"Estilo Escrita Provocativa"` |
| `source_type` | enum | Yes | Type of source | `"self_analysis"`, `"blog_post"`, `"podcast_transcript"`, etc |

---

## Preconditions

- [ ] **MMOS database exists** at `/outputs/database/mmos.db`
- [ ] **Mind already exists** in `minds` table (create if missing)
- [ ] **Fragments file is valid** (follows InnerLens MIU schema)
- [ ] **Source file readable** (UTF-8 encoding)

---

## Steps

### Step 1: Validate Inputs

```bash
# Check fragments file exists and is valid JSON
test -f "${fragments_file}" || exit 1
python3 -m json.tool "${fragments_file}" > /dev/null || exit 1
```

**Exit if:**
- Fragments file missing
- Invalid JSON format
- Missing required fields in fragments

---

### Step 2: Get or Create Mind Entry

**Query database:**
```sql
SELECT id FROM minds WHERE slug = ?
```

**If not found, create:**
```sql
INSERT INTO minds (slug, display_name, created_at)
VALUES (?, ?, CURRENT_TIMESTAMP)
```

**Output:** `mind_id` (integer)

---

### Step 3: Create Source Entry

**Read source file:**
```python
with open(source_file, 'r', encoding='utf-8') as f:
    content = f.read()
    word_count = len(content.split())
    char_count = len(content)
```

**Insert source:**
```sql
INSERT INTO sources (
    source_id, mind_id, title, file_path, type,
    clean_content, word_count, char_count,
    structural_format, status, processed_at,
    tier, priority_score
) VALUES (
    '{mind_slug}_{source_type}_{YYYYMMDD}',
    mind_id,
    source_title,
    source_file,
    source_type,
    content,
    word_count,
    char_count,
    'auto_detected',
    'extracted',
    CURRENT_TIMESTAMP,
    1,
    1.0
)
```

**Output:** `source_id` (integer)

---

### Step 4: Save Fragments

**For each fragment in fragments.json:**

```sql
INSERT OR REPLACE INTO fragments (
    id,                  -- fragment_id from JSON
    mind_id,            -- From Step 2
    source_id,          -- From Step 3
    fragment_type,      -- 'written_thought'
    content,            -- JSON with verbatim + structure
    cognitive_theme,    -- Generic theme
    layer,              -- NULL (not assigned yet)
    domains,            -- JSON array ["cognitive", "linguistic"]
    confidence,         -- 1.0 (verbatim extraction)
    why_significant,    -- "MIU from InnerLens extraction"
    evidence_type,      -- 'explicit_statement'
    hierarchy,          -- 'fundamental'
    raw_excerpt,        -- verbatim text
    char_start,         -- From JSON
    char_end,           -- From JSON
    extraction_method,  -- From JSON
    extraction_version, -- From JSON
    pipeline_version,   -- 'innerlens_v1.1'
    created_at          -- From JSON timestamp
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
```

**Progress logging:**
```
💾 Saved 10/103 fragments...
💾 Saved 20/103 fragments...
...
✅ Saved all 103 fragments
```

---

### Step 5: Verify Save

**Query database:**
```sql
SELECT COUNT(*) FROM fragments
WHERE mind_id = ? AND source_id = ?
```

**Expected:** Count matches fragments in JSON file

**If mismatch:**
- ❌ FAIL - Rollback transaction
- Log error details
- Exit with error code

---

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `mind_id` | integer | Database ID for the mind |
| `source_id` | integer | Database ID for the source |
| `fragments_saved` | integer | Count of fragments saved |
| `success` | boolean | True if all steps completed |

---

## Error Handling

| Error | Cause | Resolution |
|-------|-------|------------|
| `Mind not found` | mind_slug doesn't exist | Auto-create mind entry |
| `Duplicate source_id` | Source already processed | Use existing source, skip creation |
| `Invalid fragments.json` | Malformed JSON | Fix JSON and retry |
| `Database locked` | Concurrent writes | Retry with exponential backoff |
| `Missing required field` | Incomplete MIU | Log warning, skip fragment |

---

## Success Criteria

- [x] All fragments saved to database
- [x] No data loss (count matches)
- [x] Source entry created
- [x] Mind entry exists
- [x] Transaction committed successfully

---

## Usage Examples

### Example 1: Alan Nicolas Self-Analysis

```bash
python3 scripts/save_fragments_to_mmos.py \
  --mind alan_nicolas \
  --fragments testing/validation/profiles/alan_fragments.json \
  --source testing/validation/text_samples/alan_nicolas.txt \
  --title "Estilo Escrita Provocativa" \
  --type self_analysis
```

### Example 2: Sam Altman Blog Post

```bash
python3 scripts/save_fragments_to_mmos.py \
  --mind sam_altman \
  --fragments testing/results/sam_altman_fragments.json \
  --source testing/data/sam_altman_sample.txt \
  --title "Three Observations" \
  --type article
```

### Example 3: Naval Ravikant Podcast

```bash
python3 scripts/save_fragments_to_mmos.py \
  --mind naval_ravikant \
  --fragments testing/results/naval_fragments.json \
  --source testing/data/naval_sample.txt \
  --title "A Calm Mind, A Fit Body, A House Full of Love" \
  --type podcast_transcript
```

---

## Performance

**Benchmarks (N=103 fragments):**
- Database insert: ~500ms
- JSON parsing: ~50ms
- Total time: <2 seconds

**Optimization:**
- Use batch inserts (100 fragments/batch)
- Single transaction for all writes
- Prepared statements for SQL

---

## Related Tasks

- `tasks/extract-fragments.md` - Extract MIUs from text
- `tasks/analyze-bigfive.md` - Analyze personality using fragments
- `tasks/detect-traits-quick.md` - Full pipeline (extract + analyze + validate)

---

## Notes

- **MIU fragments are framework-agnostic** - Once saved, can be reused for Big Five, HEXACO, VIA, Schwartz, etc.
- **No personality inference** - Fragments contain ONLY linguistic structure + verbatim text
- **Database schema** - See `/docs/mmos/schema.sql` for full structure
- **Language support** - Currently handles pt-BR and en-US, but structure is language-agnostic

---

**Task Status:** ✅ Specification Complete
**Last Updated:** 2025-10-16
**Version:** 1.0.0
**Owner:** Dev Lead
