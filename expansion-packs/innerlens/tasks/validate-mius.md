# Task: Validate MIUs

**Task ID:** validate-mius
**Agent:** @quality-assurance
**Version:** 1.0.0
**Dependencies:** MIU fragments.json file, checklists/miu-quality.md
**Quality Gate:** BLOCKING (must pass before database save)

---

## Purpose

Validate extracted MIU fragments against InnerLens quality standards before allowing database persistence.

**Why This Matters:**
- **Quality Gate:** Prevents low-quality data from polluting MMOS database
- **Zero-Inference Enforcement:** Ensures no trait categorization leaked into MIUs
- **Framework Agnosticism:** Validates MIUs are reusable across Big Five, HEXACO, etc
- **100-Year Reusability:** Quality now = reliable data for decades

**Blocking Behavior:**
- ✅ PASS → Allow database save, proceed with analysis
- ❌ FAIL → Block database save, require re-extraction
- 🟡 WARN → Allow save but flag for manual review

---

## Inputs

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `fragments_file` | path | Yes | Path to fragments.json | `"testing/validation/profiles/alan_nicolas_fragments.json"` |
| `subject_id` | string | Yes | Subject identifier (for logging) | `"alan_nicolas"` |
| `strict_mode` | boolean | No | Fail on warnings (default: false) | `true` |

---

## Preconditions

- [ ] **Fragments file exists** and is readable
- [ ] **Valid JSON format** (parseable)
- [ ] **MIU schema present** (metadata + fragments array)
- [ ] **Checklist accessible** at `checklists/miu-quality.md`

---

## Validation Workflow

### Step 1: Load and Parse

```python
# Load fragments.json
with open(fragments_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

# Validate top-level structure
assert 'metadata' in data, "Missing metadata section"
assert 'fragments' in data, "Missing fragments array"

fragments = data['fragments']
metadata = data['metadata']

print(f"📂 Loaded {len(fragments)} fragments from {fragments_file}")
```

**Exit if:**
- File not found
- Invalid JSON
- Missing required sections

---

### Step 2: Schema Validation

**Run Check #1 from miu-quality.md checklist**

**Metadata fields (required):**
```python
required_metadata = [
    'subject_id',
    'extraction_date',
    'extractor_version',
    'structural_format',
    'content_statistics',
    'quality_checks',
    'warnings',
    'extraction_cost_usd'
]

for field in required_metadata:
    assert field in metadata, f"Missing metadata field: {field}"
```

**Fragment fields (required for each MIU):**
```python
required_fragment_fields = [
    'fragment_id',
    'subject_id',
    'content.verbatim',
    'content.word_count',
    'content.clause_count',
    'attribution.speaker',
    'attribution.speaker_name',
    'source.document_id',
    'source.document_type',
    'source.char_position',
    'source.language',
    'structure.words',
    'structure.pronouns',
    'structure.verbs',
    'extraction.method',
    'extraction.version',
    'extraction.timestamp'
]

for idx, frag in enumerate(fragments):
    for field in required_fragment_fields:
        assert get_nested(frag, field) is not None, \
            f"Fragment {idx}: Missing field {field}"
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 3: Grammatical Completeness

**Run Check #2 from miu-quality.md checklist**

```python
incomplete_fragments = []

for frag in fragments:
    # Check verb presence
    verbs = frag['structure'].get('verbs', [])
    clause_count = frag['content'].get('clause_count', 0)

    if len(verbs) == 0 or clause_count < 1:
        incomplete_fragments.append({
            'fragment_id': frag['fragment_id'],
            'verbatim': frag['content']['verbatim'],
            'issue': 'No verb or incomplete clause'
        })

if incomplete_fragments:
    print(f"❌ Grammatical completeness FAILED")
    print(f"   {len(incomplete_fragments)}/{len(fragments)} fragments incomplete")
    for issue in incomplete_fragments[:5]:  # Show first 5
        print(f"   - {issue['fragment_id']}: \"{issue['verbatim']}\"")
    return VALIDATION_FAILED
else:
    print(f"✅ Grammatical completeness: 100% ({len(fragments)}/{len(fragments)})")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 4: Clear Attribution

**Run Check #3 from miu-quality.md checklist**

```python
invalid_attribution = []
valid_speakers = ['subject', 'other', 'group', 'narrator']

for frag in fragments:
    speaker = frag['attribution'].get('speaker')
    speaker_name = frag['attribution'].get('speaker_name')

    if speaker not in valid_speakers:
        invalid_attribution.append({
            'fragment_id': frag['fragment_id'],
            'speaker': speaker,
            'issue': f'Invalid speaker enum: {speaker}'
        })

    # If speaker != subject, speaker_name should be present
    if speaker != 'subject' and not speaker_name:
        invalid_attribution.append({
            'fragment_id': frag['fragment_id'],
            'issue': 'Missing speaker_name for non-subject speaker'
        })

if invalid_attribution:
    print(f"❌ Attribution check FAILED")
    print(f"   {len(invalid_attribution)} attribution issues found")
    return VALIDATION_FAILED
else:
    print(f"✅ Clear attribution: 100%")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 5: Causal Links Preserved

**Run Check #4 from miu-quality.md checklist**

**Causal markers:**
```python
causal_markers_pt = [
    'porque', 'pois', 'já que', 'visto que', 'uma vez que',
    'portanto', 'então', 'logo', 'por isso', 'assim',
    'para', 'a fim de', 'com o objetivo de'
]

causal_markers_en = [
    'because', 'since', 'as', 'given that',
    'therefore', 'so', 'thus', 'hence',
    'in order to', 'so that'
]

broken_causal = []

for frag in fragments:
    verbatim = frag['content']['verbatim'].lower()
    clause_count = frag['content']['clause_count']

    # Check if causal marker present
    has_causal = any(marker in verbatim for marker in causal_markers_pt + causal_markers_en)

    if has_causal and clause_count < 2:
        broken_causal.append({
            'fragment_id': frag['fragment_id'],
            'verbatim': frag['content']['verbatim'],
            'clause_count': clause_count,
            'issue': 'Causal marker present but missing cause or effect'
        })

if broken_causal:
    print(f"❌ Causal links BROKEN")
    print(f"   {len(broken_causal)} incomplete causal relationships")
    return VALIDATION_FAILED
else:
    print(f"✅ Causal links preserved: PASS")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 6: Temporal Links Preserved

**Run Check #5 from miu-quality.md checklist**

**Temporal markers:**
```python
temporal_markers_pt = [
    'quando', 'enquanto', 'depois', 'antes', 'após',
    'sempre que', 'toda vez que', 'até que'
]

temporal_markers_en = [
    'when', 'while', 'after', 'before', 'during',
    'whenever', 'until', 'as soon as', 'once'
]

broken_temporal = []

for frag in fragments:
    verbatim = frag['content']['verbatim'].lower()
    clause_count = frag['content']['clause_count']

    has_temporal = any(marker in verbatim for marker in temporal_markers_pt + temporal_markers_en)

    if has_temporal and clause_count < 2:
        broken_temporal.append({
            'fragment_id': frag['fragment_id'],
            'verbatim': frag['content']['verbatim'],
            'issue': 'Temporal marker present but missing trigger or behavior'
        })

if broken_temporal:
    print(f"❌ Temporal links BROKEN")
    print(f"   {len(broken_temporal)} incomplete temporal relationships")
    return VALIDATION_FAILED
else:
    print(f"✅ Temporal links preserved: PASS")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 7: Contrasts Separated

**Run Check #6 from miu-quality.md checklist**

**Contrastive markers:**
```python
contrastive_markers_pt = [
    'mas', 'porém', 'contudo', 'todavia', 'entretanto',
    'no entanto', 'por outro lado', 'embora', 'apesar de'
]

contrastive_markers_en = [
    'but', 'however', 'although', 'though', 'yet',
    'nevertheless', 'on the other hand', 'despite', 'whereas'
]

unseparated_contrasts = []

for frag in fragments:
    verbatim = frag['content']['verbatim'].lower()

    # Check if contrast marker in middle of verbatim (not at start)
    for marker in contrastive_markers_pt + contrastive_markers_en:
        # Find marker position (not at start = bad)
        marker_pos = verbatim.find(marker)
        if marker_pos > 5:  # Not at start (allowing for short prefix)
            unseparated_contrasts.append({
                'fragment_id': frag['fragment_id'],
                'verbatim': frag['content']['verbatim'],
                'marker': marker,
                'issue': f'Contrast marker "{marker}" in middle - should be split'
            })
            break

if unseparated_contrasts:
    print(f"❌ Contrasts NOT separated")
    print(f"   {len(unseparated_contrasts)} MIUs contain mid-sentence contrasts")
    return VALIDATION_FAILED
else:
    print(f"✅ Contrasts separated: PASS")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 8: Zero-Inference Compliance

**Run Check #7 from miu-quality.md checklist**

**FORBIDDEN elements:**
```python
forbidden_patterns = [
    # Trait labels
    'openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism',
    'big_five', 'hexaco', 'mbti', 'trait',

    # Emotional categorization
    'positive emotion', 'negative emotion', 'anxious', 'depressed',

    # Behavioral labels
    'risk-taking', 'avoidant', 'pattern',

    # Significance scoring
    'important', 'key_evidence', 'significance',

    # Domain labels
    'emotional_domain', 'cognitive_type', 'personality_signal'
]

inference_violations = []

for frag in fragments:
    # Check all fields for forbidden patterns
    frag_json = json.dumps(frag).lower()

    for pattern in forbidden_patterns:
        if pattern in frag_json:
            inference_violations.append({
                'fragment_id': frag['fragment_id'],
                'pattern': pattern,
                'issue': f'FORBIDDEN: Contains interpretation/categorization "{pattern}"'
            })
            break

if inference_violations:
    print(f"❌ Zero-inference VIOLATED")
    print(f"   {len(inference_violations)} fragments contain interpretation")
    for v in inference_violations[:5]:
        print(f"   - {v['fragment_id']}: {v['pattern']}")
    return VALIDATION_FAILED
else:
    print(f"✅ Zero-inference compliance: 100%")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 9: Context Preservation

**Run Check #8 from miu-quality.md checklist**

```python
missing_context = []

for frag in fragments:
    verbatim = frag['content']['verbatim']
    word_count = frag['content']['word_count']
    context = frag.get('context', {})

    # Check for elliptical fragments (very short responses)
    if word_count <= 3 and verbatim.lower() in ['sim', 'não', 'yes', 'no', 'absolutamente']:
        if not context.get('responding_to'):
            missing_context.append({
                'fragment_id': frag['fragment_id'],
                'verbatim': verbatim,
                'issue': 'Elliptical fragment missing context.responding_to'
            })

if missing_context:
    print(f"🟡 Context preservation: WARN")
    print(f"   {len(missing_context)} elliptical fragments missing context")
    if strict_mode:
        return VALIDATION_FAILED
else:
    print(f"✅ Context preservation: PASS")
```

**Outcome:** ✅ PASS | 🟡 WARN | ❌ FAIL (if strict_mode)

---

### Step 10: Metadata Quality Checks

**Run Check #9 from miu-quality.md checklist**

```python
quality_checks = metadata.get('quality_checks', {})

required_checks = [
    'all_mius_grammatically_complete',
    'all_mius_have_clear_attribution',
    'causal_links_preserved',
    'temporal_links_preserved',
    'contrasts_separated',
    'interpretability_target_met',
    'zero_inference_compliant',
    'context_preserved',
    'validation_passed'
]

failed_checks = []

for check in required_checks:
    value = quality_checks.get(check)
    if value is not True:
        failed_checks.append({
            'check': check,
            'value': value,
            'expected': True
        })

if failed_checks:
    print(f"❌ Metadata quality checks FAILED")
    print(f"   {len(failed_checks)}/{len(required_checks)} checks not TRUE")
    for fail in failed_checks:
        print(f"   - {fail['check']}: {fail['value']} (expected: True)")
    return VALIDATION_FAILED
else:
    print(f"✅ Metadata quality checks: all TRUE ({len(required_checks)}/{len(required_checks)})")
```

**Outcome:** ✅ PASS | ❌ FAIL

---

### Step 11: Statistical Sanity Checks

**Run Check #10 from miu-quality.md checklist**

```python
stats = metadata.get('content_statistics', {})

warnings = []

# Extraction rate (MIUs per 1000 words)
extraction_rate = stats.get('extraction_rate_mius_per_1000w', 0)
if not (15 <= extraction_rate <= 100):
    warnings.append(f"Extraction rate {extraction_rate:.1f} outside expected range [15-100]")

# Average MIU word count
avg_word_count = stats.get('avg_miu_word_count', 0)
if not (5 <= avg_word_count <= 250):
    warnings.append(f"Avg MIU word count {avg_word_count:.1f} outside expected range [5-250]")

# Rejection rate
rejection_rate = stats.get('rejection_rate', 0)
if rejection_rate > 0.30:
    warnings.append(f"Rejection rate {rejection_rate:.2%} > 30% (high rejection)")

# Processing speed
processing_speed = stats.get('processing_speed_words_per_second', 0)
if processing_speed <= 0:
    warnings.append(f"Invalid processing speed: {processing_speed}")

if warnings:
    print(f"🟡 Statistical sanity: WARN")
    for w in warnings:
        print(f"   ⚠️  {w}")
    if strict_mode:
        return VALIDATION_FAILED
else:
    print(f"✅ Statistical sanity: PASS")
```

**Outcome:** ✅ PASS | 🟡 WARN | ❌ FAIL (if strict_mode)

---

### Step 12: Primary Source Validation (CRITICAL - NEW v1.1)

**Run Check #11 from miu-quality.md checklist**

**CRITICAL CHECK:** Validates that MIUs are LITERAL fragments from subject's words, NOT meta-analysis about them

```python
primary_source_types = [
    'self_analysis', 'article', 'essay', 'book',
    'social_media', 'email', 'speech',
    'podcast_transcript', 'video_transcript'
]

meta_analysis_violations = []

for frag in fragments:
    document_type = frag['source'].get('document_type')
    speaker = frag['attribution'].get('speaker')
    verbatim = frag['content']['verbatim']

    # RULE 1: Primary source documents MUST have speaker='subject'
    if document_type in primary_source_types and speaker != 'subject':
        meta_analysis_violations.append({
            'fragment_id': frag['fragment_id'],
            'verbatim': verbatim,
            'document_type': document_type,
            'speaker': speaker,
            'issue': f'PRIMARY SOURCE ({document_type}) with speaker={speaker} - this is META-ANALYSIS, not actual quote'
        })

    # RULE 2: speaker='other' only valid in interviews/conversations
    if speaker == 'other' and document_type not in ['interview', 'conversation']:
        meta_analysis_violations.append({
            'fragment_id': frag['fragment_id'],
            'verbatim': verbatim,
            'document_type': document_type,
            'speaker': speaker,
            'issue': f'speaker=other in {document_type} - likely third-party observation, not primary source'
        })

if meta_analysis_violations:
    print(f"❌ Primary source validation FAILED")
    print(f"   {len(meta_analysis_violations)}/{len(fragments)} MIUs are META-ANALYSIS (not actual quotes)")
    print(f"   This means the source material is ABOUT the subject, not BY the subject")
    print(f"")
    print(f"   Examples:")
    for v in meta_analysis_violations[:5]:
        print(f"   - {v['fragment_id']}: \"{v['verbatim'][:60]}...\"")
        print(f"     Issue: {v['issue']}")
    print(f"")
    print(f"   ⚠️  CRITICAL: MIUs MUST be literal fragments of what someone said/wrote")
    print(f"   ⚠️  These are observations ABOUT {subject_id}, not {subject_id}'s words")
    print(f"")
    print(f"   Action required:")
    print(f"   1. Verify source material is PRIMARY (written/spoken BY subject)")
    print(f"   2. If source is analysis/meta-content, REJECT all fragments")
    print(f"   3. Collect actual posts/articles/transcripts/interviews BY subject")
    print(f"   4. Re-extract from primary sources only")
    return VALIDATION_FAILED
else:
    print(f"✅ Primary source validation: 100% ({len(fragments)}/{len(fragments)} are actual quotes)")
```

**Outcome:** ✅ PASS | ❌ FAIL

**Why This Is Critical:**
- MIUs MUST be what someone actually said/wrote (primary source)
- MIUs are NOT observations, analyses, or descriptions about someone (secondary source)
- Example FAIL: "Alan uses provocative language" (analysis about Alan)
- Example PASS: "Eu uso linguagem provocativa porque..." (Alan's actual words)

**Common Failure Case:**
```
Source file: "analysis_of_alan_nicolas.txt" (meta-analysis about Alan)
Content: "Alan Nicolas uses language as a tool..." (observer describing Alan)
Result: FAIL - This is NOT Alan's words, it's someone analyzing Alan's style
```

**Correct Approach:**
```
Source file: "alan_nicolas_article.txt" (written BY Alan)
Content: "Eu uso linguagem como ferramenta..." (Alan describing his own approach)
Result: PASS - This is Alan's actual words
```

---

## Validation Outcomes

### ✅ VALIDATED_HIGH

**All of the following:**
- Schema validation: PASS
- Grammatical completeness: 100%
- Clear attribution: 100%
- Causal links preserved: PASS
- Temporal links preserved: PASS
- Contrasts separated: PASS
- Zero-inference compliance: 100%
- Context preservation: PASS
- Metadata quality checks: all TRUE
- Statistical sanity: PASS
- **Primary source validation: 100%** (NEW v1.1 - CRITICAL)

**Action:**
```python
return {
    'status': 'VALIDATED_HIGH',
    'message': '✅ MIUs VALIDATED - Ready for personality analysis',
    'fragments_count': len(fragments),
    'quality_score': 1.0,
    'allow_database_save': True
}
```

---

### 🟡 VALIDATED_PROVISIONAL

**All critical checks PASS, but warnings present:**
- Core validation: PASS
- Non-critical issues: WARN (context missing, stats outside range)

**Action:**
```python
return {
    'status': 'VALIDATED_PROVISIONAL',
    'message': '🟡 MIUs PROVISIONAL - Usable but review recommended',
    'warnings': warnings,
    'fragments_count': len(fragments),
    'quality_score': 0.85,
    'allow_database_save': True  # Allow, but flag
}
```

---

### ❌ VALIDATION_FAILED

**Any critical check FAILED:**
- Schema missing fields
- Grammatical incompleteness
- Attribution invalid
- Causal/temporal links broken
- Contrasts not separated
- Zero-inference violated
- **Primary source violated (meta-analysis detected)** (NEW v1.1 - CRITICAL)
- Metadata quality_checks.validation_passed = false

**Action:**
```python
return {
    'status': 'VALIDATION_FAILED',
    'message': '❌ MIUs REJECTED - Re-extract required',
    'failed_checks': failed_checks,
    'fragments_count': len(fragments),
    'quality_score': 0.0,
    'allow_database_save': False,  # BLOCK database save
    'action_required': 'Fix @fragment-extractor logic and re-run extraction'
}
```

---

## Error Handling

| Error | Cause | Resolution |
|-------|-------|------------|
| `File not found` | Invalid fragments_file path | Verify path, check if extraction completed |
| `Invalid JSON` | Malformed fragments.json | Re-run extraction with valid LLM |
| `Missing metadata` | Incomplete extraction output | Verify @fragment-extractor output schema |
| `Zero-inference violated` | Trait labels in MIU structure | Fix extraction prompt, re-extract |
| `Causal links broken` | MIU split mid-causal-chain | Review fragmentation rules, re-extract |
| `Primary source violated` | Meta-analysis instead of actual quotes | Use PRIMARY sources (BY subject), not secondary (ABOUT subject) |

---

## Success Criteria

- [x] All 11 validation checks executed (v1.1 added Check #11)
- [x] Clear PASS/FAIL/WARN outcome
- [x] Detailed failure reasons logged
- [x] Database save blocked if validation failed
- [x] Quality score calculated
- [x] Primary source validation enforced (v1.1 - CRITICAL)

---

## Usage Examples

### Example 1: Standalone Validation

```bash
# Via @quality-assurance agent
@quality-assurance
*validate --checklist miu-quality --input testing/validation/profiles/alan_nicolas_fragments.json
```

### Example 2: Via AIOS Task

```bash
# Via @aios-master
@aios-master
*task validate-mius \
  --fragments testing/validation/profiles/alan_nicolas_fragments.json \
  --subject alan_nicolas \
  --strict-mode false
```

### Example 3: In Workflow (Automatic)

```bash
# Via extract-analyze-save workflow
@aios-master
*workflow extract-analyze-save \
  --mind alan_nicolas \
  --source testing/validation/text_samples/alan_nicolas.txt

# Workflow will automatically:
# 1. Extract MIUs (@fragment-extractor)
# 2. Validate MIUs (@quality-assurance) ← THIS TASK
# 3. If VALIDATED → Save to database
# 4. If FAILED → Block save, require re-extract
```

### Example 4: Strict Mode (Fail on Warnings)

```bash
@aios-master
*task validate-mius \
  --fragments testing/results/sam_altman_fragments.json \
  --subject sam_altman \
  --strict-mode true  # Fail on any warnings
```

---

## Output Format

### Terminal Output

```
======================================================================
MIU Quality Validation (@quality-assurance)
======================================================================

📂 Input: testing/validation/profiles/alan_nicolas_fragments.json
👤 Subject: alan_nicolas
⚙️  Strict Mode: false

📊 Loaded 103 fragments

🔍 Running 10 validation checks...

✅ Check 1: Schema validation - PASS
✅ Check 2: Grammatical completeness - 100% (103/103)
✅ Check 3: Clear attribution - 100% (103/103)
✅ Check 4: Causal links preserved - PASS
✅ Check 5: Temporal links preserved - PASS
✅ Check 6: Contrasts separated - PASS
✅ Check 7: Zero-inference compliance - 100% (103/103)
🟡 Check 8: Context preservation - WARN (3 elliptical fragments missing context)
✅ Check 9: Metadata quality checks - all TRUE (9/9)
🟡 Check 10: Statistical sanity - WARN (extraction rate 72.3 slightly high)

======================================================================
🟡 VALIDATION OUTCOME: PROVISIONAL
======================================================================

✅ Core quality: PASS (all critical checks passed)
🟡 Warnings: 2 non-critical issues detected
📊 Quality Score: 0.85/1.0
✅ Database Save: ALLOWED (but flagged for review)

Warnings:
  ⚠️  3 elliptical fragments missing context.responding_to
  ⚠️  Extraction rate 72.3 MIUs/1000w (expected: 15-100, slightly high)

Recommendation: Review warnings or proceed with caution
```

### JSON Output (for programmatic use)

```json
{
  "status": "VALIDATED_PROVISIONAL",
  "message": "🟡 MIUs PROVISIONAL - Usable but review recommended",
  "subject_id": "alan_nicolas",
  "fragments_count": 103,
  "quality_score": 0.85,
  "allow_database_save": true,
  "checks": {
    "schema_validation": "PASS",
    "grammatical_completeness": "PASS",
    "clear_attribution": "PASS",
    "causal_links_preserved": "PASS",
    "temporal_links_preserved": "PASS",
    "contrasts_separated": "PASS",
    "zero_inference_compliance": "PASS",
    "context_preservation": "WARN",
    "metadata_quality_checks": "PASS",
    "statistical_sanity": "WARN"
  },
  "warnings": [
    "3 elliptical fragments missing context.responding_to",
    "Extraction rate 72.3 MIUs/1000w (expected: 15-100, slightly high)"
  ],
  "timestamp": "2025-10-16T14:32:00Z"
}
```

---

## Performance

**Benchmarks (N=103 fragments):**
- JSON loading: ~20ms
- Schema validation: ~50ms
- 10 validation checks: ~200ms
- Total time: <500ms

**Optimization:**
- Validate in parallel where possible
- Cache compiled regex patterns
- Use efficient string matching

---

## Integration Points

### Upstream (provides input):
- `tasks/extract-fragments.md` → Generates fragments.json
- `agents/fragment-extractor.md` → Creates MIUs

### Downstream (consumes output):
- `tasks/save-fragments-to-mmos.md` → Only saves if VALIDATED
- `workflows/extract-analyze-save.md` → Decision point (proceed or re-extract)
- `tasks/analyze-bigfive.md` → Only analyzes if VALIDATED

### Lateral (parallel):
- `checklists/miu-quality.md` → Validation specification
- `agents/quality-assurance.md` → Executor of this task

---

## Related Resources

- **Checklist:** `checklists/miu-quality.md` (defines 10 validation checks)
- **Agent:** `agents/quality-assurance.md` (executes validation)
- **Architecture:** `docs/MIU-FRAGMENT-ARCHITECTURE.md` (zero-inference principles)
- **Workflow:** `workflows/extract-analyze-save.md` (uses this task as gate)
- **Database Task:** `tasks/save-fragments-to-mmos.md` (blocked if validation fails)

---

## Notes

- **Quality Gate Behavior:** This task acts as a BLOCKING quality gate. If validation fails, downstream tasks (database save, analysis) are prevented from executing.
- **Strict Mode:** Use `--strict-mode true` to fail on ANY warnings (context missing, stats outliers). Use for production/publication data.
- **Framework Agnostic:** Validation checks are personality-framework-agnostic (no Big Five bias).
- **LLM-Extracted MIUs:** Designed for LLM-extracted fragments. Rule-based extractions may fail zero-inference check.
- **100% Compliance Required:** For VALIDATED_HIGH status, ALL checks must be ✅. Even 1 failed check = VALIDATION_FAILED.

---

**Task Status:** ✅ Specification Complete
**Last Updated:** 2025-10-16
**Version:** 1.1.0 (added Check #11: Primary Source Validation)
**Owner:** InnerLens Quality Team

---

## Changelog

### v1.1.0 (2025-10-16)
- **CRITICAL FIX:** Added Step 12: Primary Source Validation
- **Why:** Original 10 checks validated structure/grammar but NOT whether MIUs were actual quotes vs meta-analysis
- **Impact:** Now blocks extraction from secondary sources (analysis ABOUT someone) vs primary sources (BY someone)
- **Example blocked:** "Alan uses provocative language" (analyst describing Alan)
- **Example allowed:** "Eu uso linguagem provocativa" (Alan describing himself)
