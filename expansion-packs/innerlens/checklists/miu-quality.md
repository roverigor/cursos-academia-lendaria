# MIU Quality Validation Checklist

**Checklist ID:** miu-quality
**Version:** 1.0.0
**Purpose:** Validate extracted MIUs meet InnerLens quality standards
**Agent:** @quality-assurance
**Used by:** tasks/validate-mius.md, workflows/extract-analyze-save.md

---

## Overview

This checklist validates that extracted MIUs (Minimal Interpretable Units) comply with the zero-inference, framework-agnostic architecture defined in `/docs/MIU-FRAGMENT-ARCHITECTURE.md`.

**Pass Criteria:** ALL checks must be ✅ (100% compliance required)

**Failure Action:** If any check fails, fragments must be re-extracted

---

## Input Requirements

- `fragments.json` file (output from @fragment-extractor)
- Located at: `testing/validation/profiles/{subject}_fragments.json`

---

## Validation Checks

### 1. Schema Validation

**Check:** All required fields present in metadata and fragments

**Required metadata fields:**
- [ ] `subject_id` (string)
- [ ] `extraction_date` (ISO 8601 timestamp)
- [ ] `extractor_version` (semver)
- [ ] `structural_format` (object with format, confidence)
- [ ] `content_statistics` (object with extraction metrics)
- [ ] `quality_checks` (object with 8 boolean checks)
- [ ] `warnings` (array, may be empty)
- [ ] `extraction_cost_usd` (number)

**Required fragment fields (each MIU):**
- [ ] `fragment_id` (format: f_{subject}_{###})
- [ ] `subject_id` (matches metadata)
- [ ] `content.verbatim` (non-empty string)
- [ ] `content.word_count` (number > 0)
- [ ] `content.clause_count` (number > 0)
- [ ] `attribution.speaker` (enum: subject|other|group|narrator)
- [ ] `attribution.speaker_name` (string or null)
- [ ] `source.document_id` (string)
- [ ] `source.document_type` (string)
- [ ] `source.char_position` (array [start, end])
- [ ] `source.language` (ISO 639-1 code)
- [ ] `structure.words` (array, non-empty)
- [ ] `structure.pronouns` (array)
- [ ] `structure.verbs` (array)
- [ ] `extraction.method` (string)
- [ ] `extraction.version` (semver)
- [ ] `extraction.timestamp` (ISO 8601)

**Pass:** All required fields present in all MIUs
**Fail:** Any required field missing

---

### 2. Grammatical Completeness

**Check:** 100% of MIUs are grammatically complete (subject + verb present)

**Validation:**
```
For each MIU:
  - structure.verbs.length > 0 (has at least 1 verb)
  - content.clause_count >= 1 (complete clause)
  - content.verbatim contains subject (explicit or implied)
```

**Pass:** All MIUs have at least 1 verb + complete clause
**Fail:** Any MIU lacks verb or is incomplete sentence fragment

**Example PASS:**
```
"Alan não explica conceitos - ele cria experiências que revelam verdades"
verbs: ["explica", "cria", "revelam"]
clause_count: 2
```

**Example FAIL:**
```
"explorando ideias não convencionais"
verbs: []  # No verb!
clause_count: 0
```

---

### 3. Clear Attribution

**Check:** 100% of MIUs have clear speaker attribution

**Validation:**
```
For each MIU:
  - attribution.speaker is one of: subject, other, group, narrator
  - attribution.speaker_name is string (if speaker != subject)
```

**Pass:** All MIUs have valid speaker attribution
**Fail:** Any MIU has missing or invalid attribution

**Example PASS:**
```json
{
  "attribution": {
    "speaker": "other",
    "speaker_name": "analyst"
  }
}
```

**Example FAIL:**
```json
{
  "attribution": {
    "speaker": "unknown",  // Invalid enum value!
    "speaker_name": null
  }
}
```

---

### 4. Causal Links Preserved

**Check:** MIUs with causal markers include complete causal chain

**Causal markers (Portuguese):**
- porque, pois, já que, visto que, uma vez que
- portanto, então, logo, por isso, assim
- para, a fim de, com o objetivo de

**Causal markers (English):**
- because, since, as, given that
- therefore, so, thus, hence
- in order to, so that

**Validation:**
```
For each MIU containing causal marker:
  - clause_count >= 2 (cause + effect both present)
  - Both clauses included in verbatim text
```

**Pass:** All causal relationships preserved
**Fail:** Causal marker present but missing cause or effect

**Example PASS:**
```
"Alan usa linguagem crua como bisturi porque corta resistências que linguagem polida não alcança"
Marker: "porque"
Clauses: 2 (effect + cause both present)
```

**Example FAIL:**
```
"porque corta resistências"
Marker: "porque"
Clauses: 1 (cause missing - incomplete!)
```

---

### 5. Temporal Links Preserved

**Check:** MIUs with temporal markers include complete temporal relationship

**Temporal markers (Portuguese):**
- quando, enquanto, depois, antes, após
- sempre que, toda vez que, até que

**Temporal markers (English):**
- when, while, after, before, during
- whenever, until, as soon as, once

**Validation:**
```
For each MIU containing temporal marker:
  - clause_count >= 2 (trigger + behavior both present)
  - Both clauses included in verbatim text
```

**Pass:** All temporal relationships preserved
**Fail:** Temporal marker present but missing trigger or behavior

**Example PASS:**
```
"Quando você vê claramente, ação se torna inevitável"
Marker: "quando"
Clauses: 2 (trigger + result both present)
```

**Example FAIL:**
```
"quando você vê claramente"
Marker: "quando"
Clauses: 1 (result missing - incomplete!)
```

---

### 6. Contrasts Separated

**Check:** MIUs with contrastive markers are split into separate MIUs

**Contrastive markers (Portuguese):**
- mas, porém, contudo, todavia, entretanto
- no entanto, por outro lado, embora, apesar de

**Contrastive markers (English):**
- but, however, although, though, yet
- nevertheless, on the other hand, despite, whereas

**Validation:**
```
For each MIU:
  - Does NOT contain contrastive marker in middle of verbatim
  - If marker present, it's at start (continuation) not contrast split
```

**Pass:** No mid-MIU contrasts (all split correctly)
**Fail:** Contrast marker connects opposing ideas in single MIU

**Example PASS (correctly split):**
```
MIU 1: "Alan não explica conceitos"
MIU 2: "ele cria experiências que revelam verdades"
(Original had "mas" between - correctly split)
```

**Example FAIL (should be split):**
```
"Alan ama ideias não convencionais mas também valoriza métodos comprovados"
Marker: "mas" (opposing traits - should be 2 MIUs!)
```

---

### 7. Zero-Inference Compliance

**Check:** 100% of MIUs contain ONLY observables, NO interpretation

**FORBIDDEN elements:**
- Trait labels: "openness indicator", "conscientiousness signal"
- Emotional categorization: "positive emotion", "anxious feeling"
- Behavioral labels: "risk-taking", "avoidant pattern"
- Framework tags: "big_five_*", "hexaco_*", "mbti_*"
- Domain labels in structure: "emotional_domain", "cognitive_type"
- Significance scoring in fragment: "important", "key_evidence"

**ALLOWED elements:**
- Verbatim text (exact words)
- Word lists (tokenized)
- Grammar facts (pronouns, verbs, nouns - factual POS tags)
- Punctuation (observable symbols)
- Tenses (grammatical tense, not temporal interpretation)
- Clause count (syntactic structure count)

**Validation:**
```
For each MIU:
  - No fields contain trait/emotion/behavior labels
  - structure.* contains only grammar facts
  - No "significance" or "importance" scoring
  - No framework categorization
```

**Pass:** 100% zero-inference (only observables)
**Fail:** Any MIU contains interpretation/categorization

**Example PASS:**
```json
{
  "structure": {
    "verbs": ["usa", "corta"],
    "tenses_detected": ["present"],
    "pronouns": []
  }
}
```

**Example FAIL:**
```json
{
  "structure": {
    "verbs": ["usa", "corta"],
    "emotional_valence": "assertive",  // FORBIDDEN!
    "trait_signals": ["openness"]      // FORBIDDEN!
  }
}
```

---

### 8. Context Preservation

**Check:** Context fields populated when needed for interpretation

**Validation:**
```
For each MIU:
  - If ellipsis/short response: context.responding_to populated
  - If dialogue: context.sentence_before/after may be populated
  - Context helps interpretability without adding inference
```

**Pass:** Context included where needed
**Warn:** Missing context for elliptical fragments
**Fail:** Context includes interpretation (not just surrounding text)

**Example PASS:**
```json
{
  "content": {
    "verbatim": "Absolutamente"
  },
  "context": {
    "responding_to": "Você ama explorar novas ideias?"
  }
}
```

**Example WARN:**
```json
{
  "content": {
    "verbatim": "Sim"  // Ellipsis
  },
  "context": {
    "responding_to": null  // Missing! What was the question?
  }
}
```

---

### 9. Metadata Quality Checks

**Check:** Quality checks in metadata all show TRUE

**Required checks in metadata.quality_checks:**
- [ ] `all_mius_grammatically_complete: true`
- [ ] `all_mius_have_clear_attribution: true`
- [ ] `causal_links_preserved: true`
- [ ] `temporal_links_preserved: true`
- [ ] `contrasts_separated: true`
- [ ] `interpretability_target_met: true` (94%+ pass psychologist test)
- [ ] `zero_inference_compliant: true`
- [ ] `context_preserved: true`
- [ ] `validation_passed: true` (master switch - all above must be true)

**Pass:** All quality checks = true
**Fail:** Any quality check = false

---

### 10. Statistical Sanity Checks

**Check:** Extraction statistics are reasonable

**Validation:**
```
- extraction_rate_mius_per_1000w: 15-100 (reasonable range)
- avg_miu_word_count: 5-250 (reasonable range)
- rejection_rate: 0.0-0.30 (acceptable range)
- processing_speed_words_per_second: > 0
```

**Pass:** All statistics within reasonable ranges
**Warn:** Statistics outside expected ranges (may indicate issue)

---

## Validation Outcome

### PASS Criteria

**ALL of the following must be TRUE:**
- ✅ Schema validation: PASS
- ✅ Grammatical completeness: 100%
- ✅ Clear attribution: 100%
- ✅ Causal links preserved: PASS
- ✅ Temporal links preserved: PASS
- ✅ Contrasts separated: PASS
- ✅ Zero-inference compliance: 100%
- ✅ Context preservation: PASS
- ✅ Metadata quality checks: all TRUE
- ✅ Statistical sanity: PASS

**Result:** ✅ **MIUs VALIDATED** - Ready for personality analysis

---

### FAIL Criteria

**ANY of the following:**
- ❌ Any schema field missing
- ❌ Any MIU lacks grammatical completeness
- ❌ Any MIU lacks clear attribution
- ❌ Causal/temporal relationships broken
- ❌ Contrasts not separated
- ❌ Zero-inference violated (interpretation present)
- ❌ metadata.quality_checks.validation_passed = false

**Result:** ❌ **MIUs REJECTED** - Re-extract required

**Action:**
1. Review failed check(s)
2. Fix @fragment-extractor logic or prompt
3. Re-run extraction
4. Re-validate

---

### WARN Criteria

**Non-critical issues detected:**
- ⚠️ Context missing for elliptical fragments
- ⚠️ Statistics outside expected ranges
- ⚠️ Warnings array in metadata not empty

**Result:** 🟡 **MIUs PROVISIONAL** - Usable but review recommended

**Action:**
1. Review warnings
2. Decide if manual review needed
3. Proceed with caution or re-extract

---

## Usage

### Via @quality-assurance agent

```bash
@quality-assurance
*validate --checklist miu-quality --input fragments.json
```

### Via task execution

```bash
@aios-master
*task validate-mius
```

### Via workflow

```bash
@aios-master
*task extract-analyze-save
# (includes automatic MIU validation step)
```

---

## Related Resources

- **Agent:** `agents/quality-assurance.md`
- **Task:** `tasks/validate-mius.md`
- **Workflow:** `workflows/extract-analyze-save.md`
- **Architecture:** `docs/MIU-FRAGMENT-ARCHITECTURE.md`
- **Agent Spec:** `agents/fragment-extractor.md`

---

**Checklist Status:** ✅ Production Ready
**Version:** 1.0.0
**Last Updated:** 2025-10-16
**Owner:** InnerLens Quality Team
