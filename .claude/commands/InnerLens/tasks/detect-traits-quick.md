# Task: Detect Traits Quick (3-Agent Pipeline)

**Task ID**: detect-traits-quick
**Pipeline**: @fragment-extractor → @psychologist → @quality-assurance
**Version**: 1.0.0
**Estimated Time**: <2 minutes (30s + 90s + 30s)
**Cost**: ~$0.20 per analysis

---

## Purpose

Execute complete personality analysis pipeline from raw text to validated Big Five profile using 3 specialized agents in sequence.

**Pipeline Flow**:
```
Raw Text (500+ words)
  ↓
[STEP 1] @fragment-extractor
  - Extracts Minimal Interpretable Units (MIUs)
  - Zero inference, pure observables
  - Output: fragments.json (~30s)
  ↓
[STEP 2] @psychologist
  - Analyzes MIUs using Big Five framework
  - Detects traits with intensity + confidence scoring
  - Output: bigfive-raw.yaml (~90s)
  ↓
[STEP 3] @quality-assurance
  - Validates profile quality independently
  - Statistical checks, consistency validation
  - Output: bigfive-profile.yaml (FINAL) (~30s)
  ↓
Validated Big Five Profile
```

---

## Prerequisites

**Required**:
- [ ] Raw text file (minimum 500 words recommended, 1000+ ideal)
- [ ] UTF-8 encoding
- [ ] Subject consent for analysis
- [ ] Claude Sonnet 4 API access

**Optional**:
- [ ] Subject ID (for tracking multiple analyses)
- [ ] Multiple text sources (for diversity)

---

## Task Workflow

### Step 0: Input Validation

**Before starting pipeline**, validate input:

```typescript
function validateInput(text_file_path) {
  // Check file exists
  if (!fs.existsSync(text_file_path)) {
    throw new Error(`File not found: ${text_file_path}`)
  }

  // Read file
  const content = fs.readFileSync(text_file_path, 'utf-8')

  // Check encoding (UTF-8)
  if (!isValidUTF8(content)) {
    throw new Error('File must be UTF-8 encoded')
  }

  // Count words
  const word_count = content.split(/\s+/).filter(w => w.length > 0).length

  // Minimum word check
  if (word_count < 100) {
    throw new Error(`Insufficient text: ${word_count} words (minimum 100 required)`)
  }

  // Warn if low
  if (word_count < 500) {
    console.warn(`⚠️  WARNING: Only ${word_count} words provided. Recommend 1000+ words for reliable analysis.`)
    console.warn(`   - Confidence scores will be reduced`)
    console.warn(`   - Some traits may have insufficient evidence`)
  }

  // Language detection (optional)
  const language = detectLanguage(content)
  if (language !== 'en') {
    console.warn(`⚠️  WARNING: Non-English text detected (${language}). MVP supports English only.`)
  }

  return {
    word_count: word_count,
    language: language,
    status: 'validated'
  }
}
```

**Output**: Validated input OR error

---

### Step 1: Fragment Extraction (@fragment-extractor)

**Execute**: `@fragment-extractor *extract-fragments --input <text_file> --subject-id <id>`

**Agent actions**:
1. Read raw text
2. Apply MIU fragmentation rules (6 rules)
3. Extract linguistic structure (zero inference)
4. Identify document format (interview/monologue/dialogue/group)
5. Generate content statistics
6. Run quality checks (8-point validation)
7. Detect warnings (edge cases)
8. Output: fragments.json

**Expected output**: `fragments.json`

```json
{
  "metadata": {
    "subject_id": "user_123",
    "extraction_date": "2025-01-14T16:30:00Z",
    "extractor_version": "fragment-extractor_v1.1.0",
    "source_documents": [{ "document_id": "input_text", "word_count": 1500 }],
    "structural_format": {
      "format": "interview_format",
      "confidence": 0.95
    },
    "content_statistics": {
      "mius_extracted": 42,
      "extraction_rate_mius_per_1000w": 28.0
    },
    "quality_checks": {
      "validation_passed": true
    },
    "warnings": []
  },
  "fragments": [
    { "fragment_id": "f_user123_001", ... },
    // ... 41 more MIUs
  ]
}
```

**Performance target**: <30 seconds (for 1000-2000 words)

**Error handling**:
- If extraction fails:
  - Check input encoding (UTF-8?)
  - Check API access (Claude Sonnet 4 available?)
  - Retry with exponential backoff (3 attempts)
- If < 10 MIUs extracted:
  - ⚠️ WARN: "Very few MIUs extracted - text may be too short or lack behavioral content"
  - Continue pipeline but expect low quality

---

### Step 2: Personality Analysis (@psychologist)

**Execute**: `@psychologist *analyze --framework bigfive --input fragments.json`

**Agent actions**:
1. Load fragments.json
2. Load Big Five framework KB (data/frameworks/bigfive-framework.md)
3. Load task workflow (tasks/analyze-bigfive.md)
4. Filter MIUs (speaker:subject, language:en)
5. Batch processing (20-30 MIUs per batch)
6. Detection loop:
   - Detect trait signals (intensity + confidence)
   - Apply threshold (intensity >= 0.40, confidence >= 0.60)
   - Map to 30 facets
7. Aggregate detections across batches
8. Score 5 traits (0-100 scale)
9. Score 30 facets
10. Select top evidence (3-5 MIUs per trait)
11. Statistical validation (mean, std dev, outliers)
12. Quality checks (8-point validation)
13. Generate warnings (6 issue types)
14. Output: bigfive-raw.yaml

**Expected output**: `bigfive-raw.yaml`

```yaml
profile_version: "1.0"
framework: "Big Five (OCEAN)"
analyzed_date: "2025-01-14T16:31:30Z"
subject_id: "user_123"

traits:
  openness:
    score: 78
    level: "HIGH"
    confidence: 0.82
    facets:
      imagination: { score: 85, confidence: 0.80 }
      # ... 5 more facets
    evidence_quotes:
      - quote: "I love exploring abstract ideas..."
        source: "f_user123_015"
        intensity: 0.88
        confidence: 0.85
        reasoning: "Explicit interest in abstract thinking..."
      # ... 2-4 more quotes
    detection_statistics:
      detections_high: 9
      detections_low: 1
      total_evidence_mius: 10

  # ... 4 more traits

statistical_summary:
  mean_score: 62.4
  std_dev: 14.2
  outliers: []
  overall_confidence: 0.78

quality_checks:
  validation_passed: true

warnings:
  - "Agreeableness: Low confidence (0.64) - only 4 MIUs detected"

processing_metadata:
  processing_time_seconds: 85
  cost_usd: 0.115
```

**Performance target**: <90 seconds (for 20-50 MIUs)

**Error handling**:
- If analysis fails:
  - Check fragments.json exists and is valid
  - Check framework KB loaded (bigfive-framework.md)
  - Retry detection (may be API timeout)
- If overall_confidence < 0.50:
  - ⚠️ WARN: "Very low confidence - analysis may be unreliable"
  - Continue to validation (QA will likely reject)

---

### Step 3: Quality Validation (@quality-assurance)

**Execute**: `@quality-assurance *validate --profile bigfive-raw.yaml --framework bigfive`

**Agent actions**:
1. Load bigfive-raw.yaml
2. Load validation checklist (checklists/bigfive-quality.md)
3. Schema validation (all required fields present?)
4. Score range validation (0-100, 0.0-1.0)
5. Statistical validation:
   - Calculate mean, std dev, outliers (IQR method)
   - Check distribution quality
6. Facet-trait consistency check:
   - For each trait: |facet_avg - trait_score| <= 20?
7. Evidence sufficiency validation:
   - Each trait has >= 3 MIUs?
   - Confidence calibrated to evidence quantity?
8. Source diversity check (optional)
9. Contradiction detection
10. Assign validation outcome:
    - VALIDATED_HIGH (0 failures, confidence >= 0.80)
    - VALIDATED_MEDIUM (0 failures, confidence >= 0.65)
    - PROVISIONAL (<=1 failure, confidence >= 0.50)
    - REJECTED (2+ failures OR confidence < 0.50)
11. Generate remediation suggestions (if failures)
12. Output: bigfive-profile.yaml (FINAL)

**Expected output**: `bigfive-profile.yaml`

```yaml
# All original profile data PLUS validation section

validation:
  validation_outcome: "VALIDATED_MEDIUM"
  quality_score: "MEDIUM"
  validated_date: "2025-01-14T16:33:00Z"
  validator_version: "quality-assurance_v1.0.0"

  validation_results:
    schema_validation: "PASS"
    statistical_validation:
      std_dev: 14.2
      outliers: 0
      status: "PASS"
    facet_trait_consistency:
      openness: { deviation: 4.2, status: "PASS" }
      conscientiousness: { deviation: 7.8, status: "PASS" }
      # ... 3 more traits
    evidence_sufficiency:
      openness: { mius: 10, status: "PASS" }
      agreeableness: { mius: 4, status: "WARN" }
      # ... 3 more traits

  quality_flags:
    failures: []
    warnings:
      - "Agreeableness: Low confidence (0.64) - only 4 MIUs"
      - "Agreeableness: Minimal evidence - recommend collecting more data"

  remediation_suggestions:
    - issue: "Low evidence for Agreeableness"
      suggestion: "Provide text showing social interactions, helping behaviors, or conflict situations"
      priority: "MEDIUM"

  user_message: "This profile has been validated with minor limitations. Scores are reliable but Agreeableness has limited evidence (4 behavioral examples). See warnings section for details."

# Adjusted overall confidence
overall_confidence: 0.75  # (was 0.78, adjusted down due to evidence warnings)
```

**Performance target**: <30 seconds

**Error handling**:
- If validation fails (schema error):
  - Return error: "Invalid profile structure"
  - Do not generate final profile
- If validation outcome = REJECTED:
  - Still generate final profile (with REJECTED status)
  - User sees validation results + remediation guidance

---

### Step 4: Output Summary

**Display to user**:

```
✅ Big Five Personality Analysis Complete!

📊 PROFILE SUMMARY:
   Subject ID: user_123
   Framework: Big Five (OCEAN)
   Quality: MEDIUM (validated with minor limitations)
   Overall Confidence: 75%

🧬 TRAIT SCORES:
   Openness:          78/100 (HIGH)        Confidence: 82%  ✅
   Conscientiousness: 65/100 (HIGH)        Confidence: 78%  ✅
   Extraversion:      52/100 (AVERAGE)     Confidence: 71%  ✅
   Agreeableness:     58/100 (AVERAGE)     Confidence: 64%  ⚠️
   Neuroticism:       45/100 (AVERAGE)     Confidence: 73%  ✅

⚠️  QUALITY WARNINGS (2):
   1. Agreeableness: Low confidence (0.64) - only 4 MIUs detected
   2. Agreeableness: Minimal evidence - recommend collecting more data

💡 RECOMMENDATIONS:
   - Agreeableness score may be unreliable (limited evidence)
   - To improve: Provide text showing social interactions, helping behaviors
   - Overall: Profile is usable but could be improved with more data

📁 OUTPUT FILES:
   - fragments.json (42 MIUs extracted)
   - bigfive-raw.yaml (analysis results)
   - bigfive-profile.yaml (FINAL validated profile) ✅

⏱️  PERFORMANCE:
   - Fragment extraction: 28s
   - Personality analysis: 85s
   - Quality validation: 22s
   - Total time: 2m 15s

💰 COST:
   - Fragment extraction: $0.042
   - Personality analysis: $0.115
   - Quality validation: $0.018
   - Total cost: $0.175

✨ Next steps:
   1. Review profile: cat bigfive-profile.yaml
   2. Compare to self-assessment: https://ipip.ori.org/
   3. Integrate with MMOS Mind Mapper (optional)
```

---

## Success Criteria

**Pipeline succeeds if**:
- [ ] All 3 agents execute without errors
- [ ] Output file `bigfive-profile.yaml` generated
- [ ] Validation outcome in {VALIDATED_HIGH, VALIDATED_MEDIUM, PROVISIONAL}
  - Note: REJECTED is also valid output (tells user profile is unreliable)
- [ ] Total time <3 minutes (allow buffer beyond 2min target)
- [ ] Total cost <$0.30

---

## Error Handling

### Error: Input file not found
```
ERROR: File not found: input.txt

SOLUTION:
- Verify file path is correct
- Ensure file exists in current directory
- Use absolute path if needed: /full/path/to/file.txt
```

---

### Error: Insufficient text
```
ERROR: Insufficient text: 87 words (minimum 100 required)

SOLUTION:
- Provide more text (recommend 1000-2000 words)
- Combine multiple sources:
  - Interview transcript
  - Personal essay
  - Email conversations
  - WhatsApp messages
```

---

### Error: Fragment extraction failed
```
ERROR: @fragment-extractor failed after 3 retries

POSSIBLE CAUSES:
- Claude API timeout or rate limit
- Invalid input encoding (not UTF-8)
- API key expired or invalid

SOLUTION:
- Check API status: https://status.anthropic.com/
- Verify API key is valid
- Wait 60s and retry
- If persistent: Convert file to UTF-8 encoding
```

---

### Error: Analysis low confidence
```
WARNING: Overall confidence 0.42 (below minimum 0.50)

CAUSES:
- Very few MIUs extracted (<15)
- Text too short (<500 words)
- Text lacks behavioral content (only facts, no personality signals)

SOLUTION:
- Provide more text (target: 1000-2000 words)
- Ensure text includes:
  ✅ Personal opinions ("I think...", "I believe...")
  ✅ Behavioral descriptions ("I always...", "I never...")
  ✅ Emotional expressions ("I love...", "I hate...")
  ✅ Decision-making ("When I face X, I...")
  ❌ Avoid: Pure facts ("My job is...", "I was born in...")
```

---

### Warning: Profile rejected
```
⚠️  VALIDATION OUTCOME: REJECTED

QUALITY SCORE: REJECTED

REASON:
- 3 traits with < 3 MIUs (insufficient evidence)
- Overall confidence 0.38 (below minimum 0.50)

REMEDIATION:
1. Collect more text data (currently: 450 words, recommend: 1000-2000 words)
2. Diversify sources (currently: single interview, recommend: interview + essay + conversation)
3. Ensure behavioral content (avoid pure biographical facts)
4. Re-run pipeline: detect-traits-quick --input <new_file>

NOTE: Rejected profiles are NOT saved. You must collect more data and re-analyze.
```

---

## Performance Optimization

### If pipeline is slow (>3 minutes):

**Possible causes**:
- Large input (5000+ words) → More MIUs → Longer analysis
- API latency → Network issues
- Complex text → More detection time

**Solutions**:
- Use streaming if available (future feature)
- Split very large texts into chunks (<2000 words per run)
- Run during off-peak hours (lower API latency)

---

### If cost is high (>$0.30):

**Possible causes**:
- Very large input (3000+ words)
- Many MIUs extracted (60+)
- Multiple retries (API failures)

**Solutions**:
- Keep input 1000-2000 words (sweet spot)
- Use prompt caching (future optimization)
- Batch multiple analyses (amortize fixed costs)

---

## Testing Checklist

Before deploying pipeline, test with:

- [ ] **Minimal input** (100 words)
  - Expect: Warnings about low confidence, but completes

- [ ] **Small input** (500 words)
  - Expect: PROVISIONAL or VALIDATED_MEDIUM outcome

- [ ] **Ideal input** (1500 words)
  - Expect: VALIDATED_HIGH or VALIDATED_MEDIUM outcome

- [ ] **Large input** (3000 words)
  - Expect: VALIDATED_HIGH, but slower (<3 min total)

- [ ] **Invalid input** (non-UTF-8, binary file)
  - Expect: Error at Step 0 (input validation)

- [ ] **No behavioral content** (pure facts)
  - Expect: Few MIUs extracted, low confidence, PROVISIONAL or REJECTED

- [ ] **API failure simulation**
  - Expect: Retry logic triggers, eventual success or clear error

---

## Integration with MMOS (Optional)

**Future feature**: Automatically integrate validated profile with MMOS Mind Mapper

```bash
# After detect-traits-quick completes:
@mmos *enhance-mind --mind <mind_name> --profile bigfive-profile.yaml

# MMOS actions:
# 1. Read bigfive-profile.yaml
# 2. Extract trait scores + evidence quotes
# 3. Add to mind's system prompt:
#    - "You exhibit high Openness (78/100) - embrace novel ideas"
#    - "You show average Agreeableness (58/100) - balanced cooperation"
# 4. Enhance response patterns based on traits
# 5. Save enhanced mind
```

---

**Task Status**: ✅ Ready for execution
**Last Updated**: 2025-01-14
**Owner**: InnerLens Lite Pipeline
**Version**: 1.0.0
**Performance**: <2 minutes (target), <3 minutes (with buffer)
**Cost**: ~$0.20 per analysis
