# Workflow: Extract → Analyze → Save

**Workflow ID:** extract-analyze-save
**Version:** 1.0.0
**Purpose:** Complete InnerLens pipeline from raw text to analyzed personality profile in MMOS database
**Orchestrator:** @aios-master
**Agents:** @fragment-extractor, @quality-assurance, @psychologist, @data-integrator

---

## Overview

This workflow orchestrates the complete InnerLens personality analysis pipeline:

```
Raw Text
   ↓
[@fragment-extractor] → Extract MIUs (LLM-based)
   ↓
[fragments.json]
   ↓
[@quality-assurance] → Validate MIUs (quality gate)
   ↓
   ├─ ✅ VALIDATED → Continue
   └─ ❌ FAILED → STOP (require re-extract)
   ↓
[save to MMOS database]
   ↓
[@psychologist] → Analyze Big Five (optional)
   ↓
[Complete Personality Profile]
```

**Quality Enforcement:**
- Validation is BLOCKING (not optional)
- Low-quality MIUs cannot reach database
- Re-extraction required if validation fails

---

## Inputs

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `mind_slug` | string | Yes | Mind identifier (slug format) | `"alan_nicolas"` |
| `source_file` | path | Yes | Path to raw text source | `"testing/validation/text_samples/alan_nicolas.txt"` |
| `source_title` | string | Yes | Human-readable source title | `"Estilo Escrita Provocativa"` |
| `source_type` | enum | Yes | Type of source material | `"self_analysis"`, `"article"`, `"podcast_transcript"`, `"interview"` |
| `run_analysis` | boolean | No | Run Big Five analysis after save (default: true) | `false` |
| `strict_validation` | boolean | No | Fail on warnings (default: false) | `true` |
| `output_dir` | path | No | Where to save intermediate files | `"testing/validation/profiles/"` |

---

## Preconditions

- [ ] **Source file exists** and is readable (UTF-8)
- [ ] **Mind configured** (or will be auto-created)
- [ ] **MMOS database accessible** at `/docs/mmos/mmos.db`
- [ ] **Claude API key configured** (for LLM extraction)
- [ ] **Agents available**: @fragment-extractor, @quality-assurance, @psychologist

---

## Workflow Steps

### Step 1: Initialize Workflow

```bash
echo "======================================================================"
echo "InnerLens Workflow: Extract → Analyze → Save"
echo "======================================================================"
echo ""
echo "📋 Configuration:"
echo "   Mind: ${mind_slug}"
echo "   Source: ${source_file}"
echo "   Title: ${source_title}"
echo "   Type: ${source_type}"
echo "   Output: ${output_dir}"
echo ""
```

**Validate inputs:**
```python
# Check source file exists
assert Path(source_file).exists(), f"Source file not found: {source_file}"

# Create output directory
Path(output_dir).mkdir(parents=True, exist_ok=True)

# Define output paths
fragments_file = Path(output_dir) / f"{mind_slug}_fragments.json"
analysis_file = Path(output_dir) / f"{mind_slug}_bigfive.json"
```

**Output:**
```
✅ Workflow initialized
   Source: 1,426 words, Portuguese (pt-BR)
   Output directory: testing/validation/profiles/
```

---

### Step 2: Extract MIUs (@fragment-extractor)

**Activate agent:**
```bash
@fragment-extractor
```

**Execute extraction task:**
```bash
*task extract-fragments \
  --source ${source_file} \
  --subject-id ${mind_slug} \
  --output ${fragments_file} \
  --language auto-detect \
  --use-llm true
```

**Expected behavior:**
- @fragment-extractor reads source text
- Applies 6 MIU fragmentation rules
- Uses Claude Sonnet 4 for linguistic analysis
- Generates `fragments.json` with metadata + fragments array

**Progress logging:**
```
🔍 Step 2: Extracting MIUs with @fragment-extractor...
   📂 Source: alan_nicolas.txt (1,426 words)
   🤖 Using: Claude Sonnet 4 (LLM extraction)
   ⚙️  Applying: 6 MIU fragmentation rules

   [Agent @fragment-extractor working...]

   ✅ Extraction complete!
      📊 MIUs extracted: 103
      📊 Avg words/MIU: 13.8
      📊 Avg clauses/MIU: 2.1
      💰 Cost: $0.15
      📄 Output: alan_nicolas_fragments.json
```

**Exit conditions:**
- ✅ SUCCESS → fragments.json created, proceed to Step 3
- ❌ FAIL → Extraction failed (API error, timeout, etc) → STOP WORKFLOW

---

### Step 3: Validate MIUs (@quality-assurance)

**Activate agent:**
```bash
@quality-assurance
```

**Execute validation task:**
```bash
*task validate-mius \
  --fragments ${fragments_file} \
  --subject ${mind_slug} \
  --strict-mode ${strict_validation}
```

**Expected behavior:**
- @quality-assurance loads `checklists/miu-quality.md`
- Runs 10 validation checks
- Returns: VALIDATED_HIGH, VALIDATED_PROVISIONAL, or VALIDATION_FAILED

**Progress logging:**
```
🔍 Step 3: Validating MIUs with @quality-assurance...
   📂 Input: alan_nicolas_fragments.json (103 MIUs)
   📋 Checklist: checklists/miu-quality.md
   ⚙️  Strict Mode: false

   Running 10 validation checks...
   ✅ Check 1: Schema validation - PASS
   ✅ Check 2: Grammatical completeness - 100% (103/103)
   ✅ Check 3: Clear attribution - 100%
   ✅ Check 4: Causal links preserved - PASS
   ✅ Check 5: Temporal links preserved - PASS
   ✅ Check 6: Contrasts separated - PASS
   ✅ Check 7: Zero-inference compliance - 100%
   🟡 Check 8: Context preservation - WARN (3 elliptical)
   ✅ Check 9: Metadata quality checks - all TRUE
   ✅ Check 10: Statistical sanity - PASS

   🟡 Validation: PROVISIONAL (quality score: 0.85)
```

**Decision Point: Quality Gate**

```python
if validation_status == "VALIDATION_FAILED":
    print("❌ QUALITY GATE: BLOCKED")
    print("   Validation failed - MIUs do not meet quality standards")
    print("   Action required:")
    print("   1. Review failed checks in validation report")
    print("   2. Fix @fragment-extractor prompt/logic")
    print("   3. Re-run Step 2 (extraction)")
    print("")
    print("❌ WORKFLOW STOPPED - Database save prevented")
    exit(1)

elif validation_status in ["VALIDATED_HIGH", "VALIDATED_PROVISIONAL"]:
    print("✅ QUALITY GATE: PASSED")
    print(f"   Status: {validation_status}")
    print(f"   Quality score: {quality_score}")
    print("   → Proceeding to database save")
    # Continue to Step 4

```

**Exit conditions:**
- ✅ VALIDATED_HIGH or VALIDATED_PROVISIONAL → Proceed to Step 4
- ❌ VALIDATION_FAILED → **STOP WORKFLOW** (database save blocked)

---

### Step 4: Save Fragments to MMOS Database

**Execute database save task:**
```bash
*task save-fragments-to-mmos \
  --mind ${mind_slug} \
  --fragments ${fragments_file} \
  --source ${source_file} \
  --title "${source_title}" \
  --type ${source_type}
```

**Expected behavior:**
- Get or create mind entry in `minds` table
- Create source entry in `sources` table
- Save all MIUs to `fragments` table
- Verify save completed successfully

**Progress logging:**
```
💾 Step 4: Saving fragments to MMOS database...

   🔍 Step 4.1: Get/Create Mind 'alan_nicolas'...
      ✅ Mind: Alan Nicolas (id=25)

   📄 Step 4.2: Create Source Entry...
      ✅ Created source alan_nicolas_self_analysis_20251016 (id=42)

   💾 Step 4.3: Save Fragments...
      📊 Found 103 fragments
      💾 Saved 10/103 fragments...
      💾 Saved 20/103 fragments...
      ...
      ✅ Saved all 103 fragments

   🔍 Step 4.4: Verify Save...
      ✅ Verification passed: 103/103 fragments saved

======================================================================
✅ DATABASE SAVE SUCCESSFUL
======================================================================
   • Mind: Alan Nicolas (id=25)
   • Source: Estilo Escrita Provocativa (id=42)
   • Fragments: 103 MIUs saved
   • Database: /docs/mmos/mmos.db
```

**Exit conditions:**
- ✅ SUCCESS → All fragments saved, proceed to Step 5 (if run_analysis=true)
- ❌ FAIL → Database error (locked, schema issue) → STOP WORKFLOW

---

### Step 5: Analyze Personality (@psychologist) [OPTIONAL]

**Skip if `run_analysis=false`**

**Activate agent:**
```bash
@psychologist
```

**Execute Big Five analysis task:**
```bash
*task analyze-bigfive \
  --fragments ${fragments_file} \
  --subject-id ${mind_slug} \
  --output ${analysis_file} \
  --confidence-threshold 0.70
```

**Expected behavior:**
- @psychologist loads validated MIUs
- Applies Big Five trait detection rules
- Calculates 5 main traits + 30 facets
- Generates personality profile JSON

**Progress logging:**
```
🧠 Step 5: Analyzing Big Five personality with @psychologist...
   📂 Input: alan_nicolas_fragments.json (103 MIUs)
   🎯 Framework: Big Five (OCEAN)
   ⚙️  Confidence threshold: 0.70

   [Agent @psychologist working...]

   ✅ Analysis complete!
      📊 Traits detected: 5/5 (100%)
      📊 Facets detected: 28/30 (93%)
      📊 Avg confidence: 0.84
      📊 Fragments used: 89/103 (86%)
      📄 Output: alan_nicolas_bigfive.json
```

**Analysis output saved to database:**
```python
# Save trait scores to database
for trait in ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']:
    cursor.execute("""
        INSERT INTO trait_scores (mind_id, trait_id, score, confidence, created_at)
        VALUES (?, ?, ?, ?, ?)
    """, (mind_id, trait_id, score, confidence, timestamp))
```

**Exit conditions:**
- ✅ SUCCESS → Profile complete, proceed to Step 6
- ❌ FAIL → Analysis error → Log warning, continue to Step 6 (partial success)

---

### Step 6: Generate Summary Report

**Compile workflow results:**

```python
summary = {
    "workflow": "extract-analyze-save",
    "version": "1.0.0",
    "timestamp": datetime.now().isoformat(),
    "subject": {
        "mind_slug": mind_slug,
        "mind_id": mind_id,
        "display_name": display_name
    },
    "source": {
        "file": source_file,
        "title": source_title,
        "type": source_type,
        "word_count": source_word_count,
        "language": detected_language,
        "source_id": source_id
    },
    "extraction": {
        "agent": "@fragment-extractor",
        "method": "claude_sonnet_4_llm",
        "mius_extracted": len(fragments),
        "avg_miu_word_count": avg_word_count,
        "cost_usd": extraction_cost
    },
    "validation": {
        "agent": "@quality-assurance",
        "checklist": "miu-quality.md",
        "status": validation_status,
        "quality_score": quality_score,
        "warnings": warnings
    },
    "database": {
        "fragments_saved": fragments_saved_count,
        "database_path": str(DB_PATH),
        "save_verified": save_verified
    },
    "analysis": {
        "agent": "@psychologist",
        "framework": "big_five",
        "traits_detected": traits_detected,
        "facets_detected": facets_detected,
        "avg_confidence": avg_confidence
    },
    "outputs": {
        "fragments_json": str(fragments_file),
        "analysis_json": str(analysis_file)
    }
}
```

**Terminal output:**
```
======================================================================
✅ WORKFLOW COMPLETED SUCCESSFULLY
======================================================================

📊 Summary:

🧑 Subject:
   • Mind: Alan Nicolas (id=25)
   • Language: Portuguese (pt-BR)

📄 Source:
   • Title: Estilo Escrita Provocativa
   • Type: self_analysis
   • Words: 1,426
   • Source ID: 42

🔍 Extraction (@fragment-extractor):
   • MIUs extracted: 103
   • Avg words/MIU: 13.8
   • Method: Claude Sonnet 4 (LLM)
   • Cost: $0.15

🔍 Validation (@quality-assurance):
   • Status: VALIDATED_PROVISIONAL
   • Quality score: 0.85/1.0
   • Warnings: 2 (non-critical)

💾 Database Save:
   • Fragments: 103/103 saved ✅
   • Database: /docs/mmos/mmos.db
   • Verified: ✅

🧠 Personality Analysis (@psychologist):
   • Framework: Big Five (OCEAN)
   • Traits: 5/5 detected (100%)
   • Facets: 28/30 detected (93%)
   • Avg confidence: 0.84

📂 Outputs:
   • Fragments: testing/validation/profiles/alan_nicolas_fragments.json
   • Analysis: testing/validation/profiles/alan_nicolas_bigfive.json

✅ Alan Nicolas personality profile complete and saved to MMOS!

======================================================================
```

---

## Error Handling

### Extraction Failures (Step 2)

| Error | Cause | Resolution |
|-------|-------|------------|
| API key missing | No Claude API key configured | Set `ANTHROPIC_API_KEY` env var |
| API timeout | Large text (>10k words) | Split into chunks or increase timeout |
| Rate limit exceeded | Too many requests | Wait and retry with backoff |
| Source file not found | Invalid path | Verify file path exists |

**Action:** STOP workflow, log error, exit with code 1

---

### Validation Failures (Step 3)

| Error | Cause | Resolution |
|-------|-------|------------|
| Zero-inference violated | Trait labels in MIU structure | Fix @fragment-extractor prompt |
| Grammatical incompleteness | Verbs missing from fragments | Review fragmentation rules |
| Causal links broken | MIU split mid-causal-chain | Improve clause boundary detection |
| Metadata quality checks false | Incomplete extraction output | Verify extractor output schema |

**Action:** STOP workflow (quality gate BLOCKED), require re-extraction

---

### Database Failures (Step 4)

| Error | Cause | Resolution |
|-------|-------|------------|
| Database locked | Concurrent writes | Retry with exponential backoff |
| Schema mismatch | Database version mismatch | Run schema migration |
| Disk full | No space for database | Free disk space |
| Permission denied | Database file read-only | Fix file permissions |

**Action:** STOP workflow, rollback transaction, exit with code 2

---

### Analysis Failures (Step 5)

| Error | Cause | Resolution |
|-------|-------|------------|
| Insufficient fragments | <20 MIUs extracted | Extract more text or lower threshold |
| Low confidence | Ambiguous personality signals | Accept lower confidence or get more data |
| Framework error | Big Five rules misconfigured | Verify `config/bigfive-framework.yaml` |

**Action:** Log warning, skip analysis step, continue with partial success

---

## Success Criteria

**Complete Success (all steps pass):**
- [x] Step 2: MIUs extracted (100+ fragments ideal)
- [x] Step 3: Validation PASSED (VALIDATED_HIGH or PROVISIONAL)
- [x] Step 4: All fragments saved to database
- [x] Step 5: Big Five analysis complete (28+ facets detected)
- [x] Step 6: Summary report generated

**Partial Success (analysis failed):**
- [x] Steps 2-4 complete
- [ ] Step 5 failed (but fragments still saved)

**Failure (quality gate blocked):**
- [x] Step 2 complete
- [ ] Step 3 FAILED validation
- [ ] Steps 4-5 skipped (database save prevented)

---

## Usage Examples

### Example 1: Full Pipeline (Alan Nicolas)

```bash
@aios-master
*workflow extract-analyze-save \
  --mind alan_nicolas \
  --source testing/validation/text_samples/alan_nicolas.txt \
  --title "Estilo Escrita Provocativa" \
  --type self_analysis \
  --run-analysis true \
  --strict-validation false
```

**Expected result:**
- 103 MIUs extracted and validated
- Saved to MMOS database
- Big Five profile generated
- Complete personality profile available

---

### Example 2: Extract & Save Only (No Analysis)

```bash
@aios-master
*workflow extract-analyze-save \
  --mind sam_altman \
  --source testing/data/sam_altman_sample.txt \
  --title "Three Observations" \
  --type article \
  --run-analysis false
```

**Expected result:**
- MIUs extracted and validated
- Saved to database
- Analysis skipped (can run later)

---

### Example 3: Strict Validation (Production Quality)

```bash
@aios-master
*workflow extract-analyze-save \
  --mind naval_ravikant \
  --source testing/data/naval_sample.txt \
  --title "A Calm Mind, A Fit Body, A House Full of Love" \
  --type podcast_transcript \
  --strict-validation true  # Fail on ANY warnings
```

**Expected result:**
- Strict quality enforcement (no warnings tolerated)
- Only VALIDATED_HIGH status allowed
- VALIDATED_PROVISIONAL would FAIL in strict mode

---

### Example 4: Custom Output Directory

```bash
@aios-master
*workflow extract-analyze-save \
  --mind yuval_harari \
  --source outputs/minds/yuval_harari/sources/sapiens_excerpt.txt \
  --title "Sapiens - Excerpt on Human Cooperation" \
  --type book_excerpt \
  --output-dir testing/validation/production/
```

**Expected result:**
- Fragments saved to custom directory
- All other behavior same

---

## Performance

**Benchmarks (N=1,426 words, 103 MIUs):**

| Step | Agent | Time | Cost |
|------|-------|------|------|
| 1. Initialize | - | <1s | $0.00 |
| 2. Extract MIUs | @fragment-extractor | 8-12s | $0.10-$0.20 |
| 3. Validate MIUs | @quality-assurance | <1s | $0.00 |
| 4. Save to DB | - | 1-2s | $0.00 |
| 5. Analyze Big Five | @psychologist | 5-8s | $0.05-$0.10 |
| 6. Summary | - | <1s | $0.00 |
| **TOTAL** | - | **15-25s** | **$0.15-$0.30** |

**Scalability:**
- 10,000 words: ~60s, ~$1.50
- 100,000 words: ~10min, ~$15.00 (batch recommended)

---

## Integration Points

### Upstream (provides input):
- User provides: raw text file, mind slug, metadata
- `testing/validation/subjects.yaml` - Subject configurations

### Downstream (consumes output):
- `testing/scripts/validate_from_yaml.py` - Uses saved data for validation study
- MMOS Mind Mapper - Uses fragments for AI cloning
- Other personality frameworks (HEXACO, MBTI) - Reuses MIUs

### Lateral (parallel workflows):
- `workflows/bulk-extract.md` - Extract multiple minds in parallel
- `workflows/comparative-analysis.md` - Compare 2+ minds

---

## Quality Guarantees

**This workflow enforces:**

1. **LLM-Based Extraction** - No regex/heuristics, only Claude Sonnet 4
2. **Quality Gate** - Validation is BLOCKING, not optional
3. **Zero-Inference** - MIUs contain ONLY observables
4. **Framework Agnostic** - MIUs reusable across all personality frameworks
5. **Database Integrity** - Only validated data reaches MMOS
6. **Audit Trail** - Complete metadata tracked (cost, confidence, timestamps)
7. **Reproducibility** - Same input = same output (deterministic)

**User's Principle #9: Prove Before Scale**
- This workflow validates EACH mind individually
- No bulk processing without validation
- Quality > speed

**User's Principle #10: Professional Craftsmanship**
- Complete error handling
- Clear success/failure outcomes
- Detailed logging and reporting

---

## Related Resources

- **Agents:**
  - `agents/fragment-extractor.md` - MIU extraction (Step 2)
  - `agents/quality-assurance.md` - Validation (Step 3)
  - `agents/psychologist.md` - Big Five analysis (Step 5)

- **Tasks:**
  - `tasks/extract-fragments.md` - Called by Step 2
  - `tasks/validate-mius.md` - Called by Step 3
  - `tasks/save-fragments-to-mmos.md` - Called by Step 4
  - `tasks/analyze-bigfive.md` - Called by Step 5

- **Checklists:**
  - `checklists/miu-quality.md` - Used by Step 3
  - `checklists/bigfive-quality.md` - Used by Step 5

- **Documentation:**
  - `docs/MIU-FRAGMENT-ARCHITECTURE.md` - Architecture principles
  - `testing/EPIC-0-VALIDATION-PLAN.md` - Scientific validation methodology

---

## Notes

- **Cost Management:** Avg cost $0.20-$0.30 per subject (1,000-2,000 words). For validation study (N=10), total cost ~$3.00.
- **Quality Gate is CRITICAL:** User explicitly requested "Precisamos garantir que a IA vai seguir o workflow" - validation MUST be enforced, not optional.
- **Reusability:** This workflow is GENERIC - works for ANY mind (alan_nicolas, sam_altman, naval_ravikant, etc).
- **AIOS Compliance:** Follows complete AIOS pattern (agents → tasks → checklists → workflows).
- **Database-First:** Fragments saved to MMOS for cross-framework reuse (today: Big Five, tomorrow: HEXACO, MBTI, etc).

---

**Workflow Status:** ✅ Specification Complete
**Last Updated:** 2025-10-16
**Version:** 1.0.0
**Owner:** InnerLens Development Team
