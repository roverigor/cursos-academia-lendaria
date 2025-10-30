# Big Five Profile Quality Checklist

**Framework**: Big Five (OCEAN)
**Version**: 1.0.0
**Agent**: @quality-assurance
**Purpose**: Independent validation criteria for Big Five personality profiles

---

## Validation Dimensions

### 1. Schema Validation

**Purpose**: Ensure profile structure is complete and parseable

**Checks**:

- [ ] **Profile metadata present**
  - `profile_version` field exists
  - `framework` = "Big Five (OCEAN)"
  - `analyzed_date` in ISO 8601 format
  - `analyzer_version` specified
  - `subject_id` present

- [ ] **All 5 traits present**
  - `openness` trait exists
  - `conscientiousness` trait exists
  - `extraversion` trait exists
  - `agreeableness` trait exists
  - `neuroticism` trait exists

- [ ] **Each trait has required fields**
  - `score` (0-100)
  - `level` (VERY_LOW/LOW/AVERAGE/HIGH/VERY_HIGH)
  - `confidence` (0.0-1.0)
  - `facets` object with 6 facets
  - `evidence_quotes` array (minimum 3)
  - `detection_statistics` object

- [ ] **Each facet has required fields**
  - `score` (0-100)
  - `confidence` (0.0-1.0)

- [ ] **Statistical summary present**
  - `mean_score`, `std_dev`, `range`, `median`
  - `outliers` array
  - `overall_confidence`
  - `distribution_quality`

- [ ] **Quality checks section present**
  - All 8 quality checks listed
  - `validation_passed` boolean

- [ ] **Processing metadata present**
  - `total_batches`, `processing_time_seconds`, `cost_usd`

**Pass Criteria**: ALL schema checks pass

**Fail Action**: Do not proceed with validation (invalid profile structure)

---

### 2. Score Range Validation

**Purpose**: Ensure all scores are mathematically valid

**Checks**:

- [ ] **Trait scores in valid range**
  - All trait scores >= 0 AND <= 100
  - No null/undefined values

- [ ] **Facet scores in valid range**
  - All 30 facet scores >= 0 AND <= 100
  - No null/undefined values

- [ ] **Confidence scores in valid range**
  - All trait confidences >= 0.0 AND <= 1.0
  - All facet confidences >= 0.0 AND <= 1.0
  - Overall confidence >= 0.0 AND <= 1.0

**Pass Criteria**: ALL scores in valid ranges

**Fail Action**:
- **Severity**: CRITICAL
- **Outcome**: REJECTED
- **Remediation**: "Invalid scores detected - regenerate profile with @psychologist"

---

### 3. Statistical Distribution Validation

**Purpose**: Ensure trait scores show realistic distribution (not all similar, not all extreme)

**Checks**:

- [ ] **Standard deviation in acceptable range**
  - Calculate: std_dev across 5 trait scores
  - ❌ FAIL if std_dev < 5 (too flat - suspicious)
  - ⚠️ WARN if std_dev < 10 (low variance - questionable)
  - ✅ PASS if 10 <= std_dev <= 35 (healthy variance)
  - ⚠️ WARN if std_dev > 35 (high variance - verify)
  - ❌ FAIL if std_dev > 45 (too polarized - suspicious)

- [ ] **Outlier detection (IQR method)**
  - Calculate Q1 (25th percentile), Q3 (75th percentile)
  - IQR = Q3 - Q1
  - Lower bound = Q1 - (1.5 × IQR)
  - Upper bound = Q3 + (1.5 × IQR)
  - Outliers = scores < lower_bound OR > upper_bound
  - ✅ PASS if 0 outliers (normal distribution)
  - ⚠️ WARN if 1 outlier (acceptable)
  - ❌ FAIL if 2+ outliers (distribution problem)

- [ ] **Mean score reasonable**
  - Population mean for Big Five typically 45-55 (neutral)
  - ⚠️ WARN if mean < 30 or mean > 70 (skewed low/high)

**Pass Criteria**: std_dev in range [5, 45] AND outliers <= 1

**Fail Action**:
- **Severity**: HIGH
- **Outcome**: PROVISIONAL or REJECTED (depends on other checks)
- **Remediation**: "Unusual score distribution - provide more diverse text samples"

---

### 4. Facet-Trait Consistency Validation

**Purpose**: Ensure facet scores align with trait scores (facets should average to ≈ trait)

**Checks**:

For each of 5 traits:

- [ ] **Calculate facet average**
  - Avg = sum(6 facet scores) / 6

- [ ] **Compare to trait score**
  - Deviation = |facet_avg - trait_score|
  - ✅ PASS if deviation <= 10 (excellent consistency)
  - ⚠️ WARN if 10 < deviation <= 20 (moderate inconsistency)
  - ❌ FAIL if deviation > 20 (high inconsistency)

**Example**:
```
Openness trait score: 85
Openness facets:
  - Imagination: 90
  - Artistic Interest: 75
  - Emotionality: 88
  - Adventurousness: 92
  - Intellect: 95
  - Liberalism: 80

Facet average: (90+75+88+92+95+80)/6 = 86.7
Deviation: |86.7 - 85| = 1.7
Result: PASS (excellent consistency)
```

**Pass Criteria**: All 5 traits have deviation <= 20

**Fail Action**:
- **Severity**: MEDIUM
- **Outcome**: PROVISIONAL (if only 1-2 traits affected), REJECTED (if 3+ traits)
- **Remediation**: "Facet-trait inconsistency detected - review evidence for {trait_name}"

---

### 5. Evidence Sufficiency Validation

**Purpose**: Ensure adequate evidence backs each trait score

**Checks**:

For each of 5 traits:

- [ ] **Minimum MIUs requirement**
  - Check: `detection_statistics.total_evidence_mius`
  - ❌ FAIL if < 3 MIUs (insufficient)
  - ⚠️ WARN if 3-4 MIUs (minimal)
  - ✅ PASS if >= 5 MIUs (adequate)

- [ ] **Evidence quotes present**
  - Check: `evidence_quotes.length`
  - ❌ FAIL if < 3 quotes
  - ✅ PASS if >= 3 quotes

- [ ] **Evidence diversity (optional check)**
  - Count unique fragment_ids in evidence_quotes
  - ⚠️ WARN if same MIU used for 3+ traits (fragment reuse)

**Pass Criteria**: All traits have >= 3 MIUs AND >= 3 evidence quotes

**Fail Action**:
- **Severity**: HIGH
- **Outcome**: PROVISIONAL or REJECTED
- **Remediation**: "Insufficient evidence for {trait_name} - provide more text (recommend 1000+ words)"

---

### 6. Confidence Calibration Validation

**Purpose**: Detect overconfidence (high confidence with low evidence)

**Checks**:

For each of 5 traits:

- [ ] **Confidence matches evidence quantity**
  - If total_evidence_mius < 3:
    - ❌ FAIL if confidence > 0.70 (severe overconfidence)
    - ⚠️ WARN if confidence > 0.50 (moderate overconfidence)
  - If total_evidence_mius = 3-4:
    - ⚠️ WARN if confidence > 0.80 (possible overconfidence)
  - If total_evidence_mius >= 5:
    - ✅ PASS (adequate evidence for stated confidence)

- [ ] **Overall confidence reasonable**
  - Check: `overall_confidence`
  - ❌ FAIL if overall_confidence > 0.90 (unrealistic with text-based analysis)
  - ⚠️ WARN if overall_confidence > 0.85
  - ✅ PASS if overall_confidence <= 0.85

**Pass Criteria**: No overconfidence detected (all checks pass)

**Fail Action**:
- **Severity**: MEDIUM
- **Outcome**: PROVISIONAL
- **Remediation**: "Confidence levels too high for evidence quantity - scores adjusted downward"

---

### 7. Contradiction Detection

**Purpose**: Flag logically contradictory or rare trait combinations

**Checks**:

- [ ] **Internal contradictions**
  - For each trait, check:
    - `detection_statistics.detections_high` vs `detections_low`
    - If BOTH high (>3) and low (>3) signals present:
      - Compare `avg_intensity_high` vs `avg_intensity_low`
      - ⚠️ WARN if difference < 0.15 (equal opposing signals = contradiction)

- [ ] **Rare combinations (heuristic)**
  - Check for psychologically rare patterns:
    - High Neuroticism (>80) + High Conscientiousness (>80) = "anxious perfectionism" (rare, warn)
    - Very Low Openness (<20) + Very High Extraversion (>80) = uncommon (warn)
    - Very High Agreeableness (>90) + Very Low Neuroticism (<20) = "saint pattern" (very rare, verify)

**Pass Criteria**: No contradictions OR contradictions explained in warnings

**Fail Action**:
- **Severity**: LOW
- **Outcome**: WARN (does not fail validation)
- **User message**: "Profile shows contradictory signals for {trait} - may reflect context-dependent behavior"

---

### 8. Source Attribution Validation

**Purpose**: Ensure all evidence quotes properly attributed

**Checks**:

- [ ] **All evidence quotes have source**
  - Check: Each `evidence_quotes[].source` field present
  - Format: "f_{subject_id}_{number}" (e.g., "f_nassim_001")

- [ ] **Fragment IDs valid**
  - Each source references real fragment from fragments.json
  - (Optional check if fragments.json available)

- [ ] **Evidence quotes have reasoning**
  - Check: Each `evidence_quotes[].reasoning` field present
  - Length: 50-150 words

**Pass Criteria**: All evidence properly attributed with reasoning

**Fail Action**:
- **Severity**: LOW
- **Outcome**: WARN (does not fail validation)
- **Remediation**: "Missing source attribution - regenerate profile"

---

### 9. Processing Metadata Validation

**Purpose**: Ensure analysis metadata is present and reasonable

**Checks**:

- [ ] **Processing time reasonable**
  - Check: `processing_metadata.processing_time_seconds`
  - ⚠️ WARN if < 20 seconds (too fast - suspicious)
  - ⚠️ WARN if > 180 seconds (too slow - performance issue)
  - ✅ PASS if 20-180 seconds

- [ ] **Cost reasonable**
  - Check: `processing_metadata.cost_usd`
  - ⚠️ WARN if > $0.50 (expensive - optimization needed)

- [ ] **Model specified**
  - Check: `processing_metadata.model` present

**Pass Criteria**: Metadata present (warnings acceptable)

**Fail Action**: None (warnings only, does not fail validation)

---

## Validation Outcome Matrix

**Decision logic** based on validation results:

### VALIDATED_HIGH
**Criteria**:
- ✅ All schema checks pass
- ✅ All score ranges valid
- ✅ Statistical distribution: std_dev 10-35, outliers <= 1
- ✅ Facet-trait consistency: all deviations <= 15
- ✅ Evidence sufficiency: all traits >= 5 MIUs
- ✅ Confidence calibration: no overconfidence
- ✅ Overall confidence >= 0.75
- ⚠️ Warnings: 0-1 acceptable

**Quality Score**: HIGH

**User Message**: "This profile has been independently validated and meets high quality standards. All traits backed by adequate evidence (5+ behavioral examples each). Confidence scores calibrated to evidence quantity."

---

### VALIDATED_MEDIUM
**Criteria**:
- ✅ All schema checks pass
- ✅ All score ranges valid
- ✅ Statistical distribution: std_dev 5-45, outliers <= 1
- ✅ OR ⚠️ Facet-trait consistency: 1-2 traits with deviation 15-20
- ✅ Evidence sufficiency: all traits >= 3 MIUs
- ✅ OR ⚠️ Confidence calibration: minor overconfidence on 1-2 traits
- ✅ Overall confidence >= 0.60
- ⚠️ Warnings: 2-3 acceptable

**Quality Score**: MEDIUM

**User Message**: "This profile has been validated with minor limitations. Scores are reliable but some traits have limited evidence (3-4 behavioral examples). See warnings section for details."

---

### PROVISIONAL
**Criteria**:
- ✅ All schema checks pass
- ✅ All score ranges valid
- ⚠️ Statistical distribution: std_dev < 10 or > 35, OR outliers = 2
- ⚠️ Facet-trait consistency: 1-2 traits with deviation > 20
- ⚠️ Evidence sufficiency: 1-2 traits with < 3 MIUs
- ⚠️ Confidence calibration: overconfidence on multiple traits
- ⚠️ Overall confidence 0.50-0.59
- ⚠️ Warnings: 4-6

**Quality Score**: LOW

**User Message**: "This profile has quality limitations. Use with caution. Several traits have insufficient evidence (<3 behavioral examples). Recommend collecting more text data (1000+ words) and re-analyzing."

---

### REJECTED
**Criteria**:
- ❌ Schema checks fail
- ❌ OR Score ranges invalid
- ❌ OR Statistical distribution: std_dev < 5 or > 45, OR outliers >= 3
- ❌ OR Facet-trait consistency: 3+ traits with deviation > 20
- ❌ OR Evidence sufficiency: 3+ traits with < 3 MIUs
- ❌ OR Severe overconfidence (confidence > 0.70 with < 3 MIUs)
- ❌ OR Overall confidence < 0.50
- ❌ Failures: 2+

**Quality Score**: REJECTED

**User Message**: "This profile does not meet minimum quality standards and should not be used. Insufficient evidence detected (most traits have <3 behavioral examples). Please provide more text data (recommend 1000-2000 words from diverse sources: interviews, essays, conversations) and re-analyze."

---

## Remediation Guidance

### For Evidence Insufficiency
**Symptoms**:
- Traits with < 3 MIUs
- Overall confidence < 0.60
- Many warnings about "insufficient evidence"

**Remediation**:
1. Collect more text data (target: 1000-2000 words)
2. Diversify sources:
   - ✅ Mix: interview + essay + conversation
   - ❌ Avoid: Single 30-min interview only
3. Ensure behavioral content:
   - ✅ "I love trying new things" (behavior)
   - ❌ "My job is software engineering" (fact only)
4. Re-run pipeline: @fragment-extractor → @psychologist → @quality-assurance

---

### For Facet-Trait Inconsistency
**Symptoms**:
- Facet average ≠ trait score (deviation > 20 points)
- Example: Facets average 80, trait 50

**Remediation**:
1. Review evidence quotes for affected trait
2. Check for detection errors:
   - MIUs incorrectly mapped to facets?
   - Scoring algorithm bug?
3. Manual verification:
   - Read top 5 evidence quotes
   - Do they support the trait score?
4. If inconsistency persists:
   - Flag trait as "low confidence"
   - Adjust confidence downward

---

### For Overconfidence
**Symptoms**:
- Confidence > 0.70 with < 3 MIUs
- Overall confidence > 0.85

**Remediation**:
1. Automatic adjustment:
   - If MIUs < 3: confidence *= 0.50
   - If MIUs = 3-4: confidence *= 0.80
2. Lower quality score to PROVISIONAL
3. Add warning: "Confidence adjusted downward due to limited evidence"

---

### For Statistical Anomalies
**Symptoms**:
- Std_dev < 5 (all traits similar)
- Std_dev > 45 (all traits extreme)
- 2+ outliers

**Remediation**:
1. If std_dev < 5:
   - Issue: Insufficient evidence differentiation
   - Solution: Provide more diverse text (different contexts)
2. If std_dev > 45:
   - Issue: Polarized profile or data quality
   - Solution: Verify evidence quotes, check for extreme outliers
3. If 2+ outliers:
   - Issue: Unusual personality or detection errors
   - Solution: Manual review of outlier traits

---

## Testing Checklist

Before deploying validation, test with:

- [ ] **High-quality profile** (expect: VALIDATED_HIGH)
  - 50+ MIUs, 5+ per trait, confidence 0.80
  - Should pass all checks

- [ ] **Medium-quality profile** (expect: VALIDATED_MEDIUM)
  - 20-30 MIUs, 3-4 per trait, confidence 0.70, 2 warnings
  - Should pass with minor warnings

- [ ] **Low-quality profile** (expect: PROVISIONAL)
  - 15 MIUs, 2-3 per trait, confidence 0.55, 5 warnings
  - Should flag multiple issues

- [ ] **Invalid profile** (expect: REJECTED)
  - <10 MIUs, <3 per trait, confidence 0.40
  - Should reject

- [ ] **Schema errors** (expect: ERROR)
  - Missing required fields
  - Should fail schema validation

---

**Checklist Status**: ✅ Production Ready
**Last Updated**: 2025-01-14
**Version**: 1.0.0
**Framework**: Big Five (OCEAN)
**Agent**: @quality-assurance
