# Task: Analyze Big Five Personality

**Task ID**: analyze-bigfive
**Agent**: @psychologist
**Version**: 1.0.0
**Estimated Time**: 60-90 seconds
**Cost**: ~$0.10-0.15 per analysis

---

## Purpose

Execute Big Five (OCEAN) personality detection from Minimal Interpretable Units (MIUs) with scientific rigor, transparent reasoning, and statistical validation.

---

## Prerequisites

**Required**:
- [ ] `fragments.json` from @fragment-extractor (minimum 15 MIUs recommended)
- [ ] `data/frameworks/bigfive-framework.md` (Big Five knowledge base)
- [ ] Claude Sonnet 4 API access

**Recommended**:
- [ ] 500-2000 words of source text (yields 15-50 MIUs)
- [ ] Multiple source types (interviews, essays, conversations) for diversity

---

## Task Workflow

### Step 1: Load Input Data

**Action**: Read MIU fragments

```bash
# Load fragments from @fragment-extractor output
INPUT_FILE="fragments.json"

# Validate file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "ERROR: fragments.json not found"
  echo "Run: @fragment-extractor *extract-fragments --input <text_file>"
  exit 1
fi
```

**Validation**:
- [ ] File exists and is valid JSON
- [ ] Contains `metadata` and `fragments` sections
- [ ] Minimum 10 MIUs present (warn if <15)
- [ ] All MIUs have required fields (fragment_id, content.verbatim, attribution, structure)

**Output**: Loaded MIU array

---

### Step 2: Load Framework Knowledge Base

**Action**: Read Big Five framework definitions

```bash
# Load Big Five KB
KB_FILE="data/frameworks/bigfive-framework.md"

if [ ! -f "$KB_FILE" ]; then
  echo "ERROR: Big Five framework knowledge base not found"
  exit 1
fi
```

**Parse KB sections**:
- Trait definitions (5 traits: OCEAN)
- Facet definitions (6 per trait = 30 facets)
- Behavioral indicators (linguistic markers for each facet)
- Scoring guidelines
- Detection thresholds

**Validation**:
- [ ] KB file exists
- [ ] All 5 traits defined (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism)
- [ ] All 30 facets defined
- [ ] Detection patterns present

**Output**: Framework knowledge loaded into context

---

### Step 3: Filter & Batch MIUs

**Action**: Prepare MIUs for analysis

**Filter**:
```typescript
// Keep only subject's own statements (not interviewer, not third-party)
filtered_mius = mius.filter(m =>
  m.attribution.speaker === 'subject'
)

// Optional: Filter by language
filtered_mius = filtered_mius.filter(m =>
  m.source.language === 'en'
)
```

**Batch**:
```typescript
// Split into batches of 20-30 MIUs (optimal for LLM context)
const BATCH_SIZE = 25
const batches = []

for (let i = 0; i < filtered_mius.length; i += BATCH_SIZE) {
  batches.push(filtered_mius.slice(i, i + BATCH_SIZE))
}
```

**Output**: Batched MIU arrays

---

### Step 4: Batch Detection (Loop)

**For each batch**: Process 20-30 MIUs at once

#### 4a. Detect Trait Signals

**Prompt structure** (sent to Claude Sonnet 4):
```markdown
You are a PhD-level personality psychologist analyzing behavioral evidence.

FRAMEWORK: Big Five (OCEAN)
KNOWLEDGE BASE: [Insert bigfive-framework.md content]

TASK: Detect personality trait signals in the following MIUs.

MIUs (Minimal Interpretable Units):
[Insert batch of 20-30 MIUs with verbatim text, fragment_id, structure]

FOR EACH MIU:
1. Scan for trait signals (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism)
2. If trait detected:
   - Intensity: 0.00-1.00 (how strongly MIU indicates trait)
   - Confidence: 0.00-1.00 (how certain you are)
   - Direction: HIGH or LOW trait expression
   - Facet: Which of 6 facets does this map to?
   - Reasoning: 50-150 words explaining detection

DETECTION THRESHOLD: Only report if intensity >= 0.40 AND confidence >= 0.60

OUTPUT FORMAT (JSON):
{
  "detections": [
    {
      "fragment_id": "f_subject_001",
      "trait": "openness",
      "facet": "intellect",
      "intensity": 0.92,
      "confidence": 0.90,
      "direction": "high",
      "reasoning": "Subject demonstrates sophisticated abstract reasoning..."
    }
  ]
}
```

**Conservative detection principles**:
- Better to miss a weak signal than over-detect
- Require EXPLICIT behavioral evidence (not inference)
- Watch for context (sarcasm, hypotheticals, questions)
- Distinguish self-report from third-party observation
- Facet precision matters (don't just detect "Openness", specify which facet)

#### 4b. Extract Evidence

For each detection:
```typescript
{
  fragment_id: string;
  verbatim: string;               // Copy from MIU
  trait: string;
  facet: string;
  intensity: number;
  confidence: number;
  direction: 'high' | 'low';
  reasoning: string;              // 50-150 words
  fragment_position: [number, number];  // From MIU source
}
```

**Output per batch**: Detection array (20-80 detections per batch)

---

### Step 5: Aggregate Across Batches

**Combine results** from all batches:

```typescript
// Merge detections by trait
const aggregated = {
  openness: { detections: [], high: [], low: [] },
  conscientiousness: { detections: [], high: [], low: [] },
  extraversion: { detections: [], high: [], low: [] },
  agreeableness: { detections: [], high: [], low: [] },
  neuroticism: { detections: [], high: [], low: [] }
}

// Sort detections into high/low buckets
for (const detection of all_detections) {
  const trait = detection.trait
  aggregated[trait].detections.push(detection)

  if (detection.direction === 'high') {
    aggregated[trait].high.push(detection)
  } else {
    aggregated[trait].low.push(detection)
  }
}
```

**Remove duplicates**:
- Same fragment_id detected multiple times → Keep highest intensity * confidence

**Calculate statistics per trait**:
```typescript
{
  detections_high: number;
  detections_low: number;
  avg_intensity_high: number;
  avg_intensity_low: number;
  avg_confidence: number;
  total_evidence_mius: number;
}
```

**Output**: Aggregated detections by trait

---

### Step 6: Trait Scoring

**For each of 5 traits**: Calculate score (0-100)

#### Algorithm

```typescript
function calculateTraitScore(trait_detections) {
  const high = trait_detections.high
  const low = trait_detections.low

  // Weighted sum of evidence
  const high_weight = high.reduce((sum, d) =>
    sum + (d.intensity * d.confidence), 0
  )

  const low_weight = low.reduce((sum, d) =>
    sum + (d.intensity * d.confidence), 0
  )

  const total_weight = high_weight + low_weight

  // Score calculation
  if (total_weight === 0) {
    return {
      score: 50,  // Neutral (no evidence)
      confidence: 0.0,
      level: "AVERAGE"
    }
  }

  const score = Math.round((high_weight / total_weight) * 100)

  // Evidence sufficiency penalty
  const total_mius = high.length + low.length
  let confidence = trait_detections.avg_confidence

  if (total_mius < 3) {
    confidence *= 0.5  // Severe penalty for low evidence
  } else if (total_mius < 5) {
    confidence *= 0.8  // Moderate penalty
  }

  // Cap at minimum evidence sufficiency
  confidence = Math.min(confidence, total_mius / 5.0)

  // Level classification
  let level
  if (score <= 20) level = "VERY_LOW"
  else if (score <= 40) level = "LOW"
  else if (score <= 60) level = "AVERAGE"
  else if (score <= 80) level = "HIGH"
  else level = "VERY_HIGH"

  return { score, confidence, level }
}
```

**Output**: 5 trait scores with confidence and level

---

### Step 7: Facet Scoring

**For each of 30 facets** (6 per trait):

```typescript
function calculateFacetScore(facet_detections) {
  // Same algorithm as trait scoring, but:
  // - No evidence sufficiency penalty (only at trait level)
  // - Confidence = detection confidence only

  const high_weight = facet_detections.high.reduce(
    (sum, d) => sum + (d.intensity * d.confidence), 0
  )
  const low_weight = facet_detections.low.reduce(
    (sum, d) => sum + (d.intensity * d.confidence), 0
  )

  const total = high_weight + low_weight
  if (total === 0) return { score: 50, confidence: 0.0 }

  const score = Math.round((high_weight / total) * 100)
  const confidence = facet_detections.avg_confidence

  return { score, confidence }
}
```

**Validation**: Check facet-trait consistency

```typescript
// Average of 6 facet scores should ≈ trait score (± 15 points)
const facet_avg = facets.reduce((s, f) => s + f.score, 0) / 6
const diff = Math.abs(facet_avg - trait_score)

if (diff > 15) {
  warnings.push(`${trait}: Facet-trait inconsistency (±${diff} points)`)
}
```

**Output**: 30 facet scores

---

### Step 8: Evidence Selection

**Select top evidence** for each trait (output quality):

```typescript
function selectTopEvidence(detections, count = 5) {
  // Sort by weighted score
  const sorted = detections.sort((a, b) =>
    (b.intensity * b.confidence) - (a.intensity * a.confidence)
  )

  // Take top N, ensuring diversity
  const selected = []
  const facets_seen = new Set()

  for (const detection of sorted) {
    // Prioritize unseen facets
    if (!facets_seen.has(detection.facet) || selected.length < 3) {
      selected.push(detection)
      facets_seen.add(detection.facet)
    }

    if (selected.length >= count) break
  }

  // If we have both high and low signals, include at least 1 of each
  const has_high = selected.some(d => d.direction === 'high')
  const has_low = selected.some(d => d.direction === 'low')

  if (!has_low && detections.some(d => d.direction === 'low')) {
    const best_low = sorted.find(d => d.direction === 'low')
    selected.push(best_low)
  }

  return selected.slice(0, count)
}
```

**Output**: Top 3-5 evidence MIUs per trait

---

### Step 9: Statistical Validation

**Calculate summary statistics**:

```typescript
const scores = [
  traits.openness.score,
  traits.conscientiousness.score,
  traits.extraversion.score,
  traits.agreeableness.score,
  traits.neuroticism.score
]

const mean = scores.reduce((s, v) => s + v, 0) / 5
const variance = scores.reduce((s, v) => s + Math.pow(v - mean, 2), 0) / 5
const std_dev = Math.sqrt(variance)
const median = scores.sort()[2]
const range = [Math.min(...scores), Math.max(...scores)]

// Outlier detection (> 2 SD from mean)
const outliers = []
for (const [trait, data] of Object.entries(traits)) {
  const z_score = Math.abs((data.score - mean) / std_dev)
  if (z_score > 2.0) {
    outliers.push(trait)
  }
}

// Overall confidence (average across traits)
const overall_confidence = Object.values(traits)
  .reduce((s, t) => s + t.confidence, 0) / 5

// Distribution quality
let distribution_quality
if (std_dev < 10) {
  distribution_quality = "flat"  // All traits similar (suspicious)
} else if (std_dev > 30) {
  distribution_quality = "polarized"  // Extreme differences
} else {
  distribution_quality = "balanced"  // Healthy variance
}
```

**Output**: Statistical summary

---

### Step 10: Quality Checks

**Run validation**:

```typescript
const quality_checks = {
  all_trait_scores_valid: scores.every(s => s >= 0 && s <= 100),

  all_facet_scores_valid: Object.values(facets).every(f =>
    f.score >= 0 && f.score <= 100
  ),

  evidence_sufficiency_met: Object.values(traits).every(t =>
    t.detection_statistics.total_evidence_mius >= 3
  ),

  facet_trait_consistency: warnings.filter(w =>
    w.includes('Facet-trait inconsistency')
  ).length === 0,

  confidence_calibration_valid: Object.values(traits).every(t =>
    !(t.confidence > 0.70 && t.detection_statistics.total_evidence_mius < 3)
  ),

  no_statistical_anomalies: outliers.length <= 1,  // Max 1 outlier acceptable

  overall_confidence_adequate: overall_confidence >= 0.60,

  validation_passed: true  // Will be set to false if any check fails
}

// Set validation_passed
quality_checks.validation_passed = Object.entries(quality_checks)
  .filter(([k, v]) => k !== 'validation_passed')
  .every(([k, v]) => v === true)
```

**CRITICAL**: If `validation_passed: false`, add warnings and proceed (do not block output)

---

### Step 11: Warnings Generation

**Detect issues**:

```typescript
const warnings = []

// Check each trait
for (const [trait_name, trait_data] of Object.entries(traits)) {
  const stats = trait_data.detection_statistics

  // Insufficient evidence
  if (stats.total_evidence_mius < 3) {
    warnings.push(
      `${trait_name}: Only ${stats.total_evidence_mius} MIUs detected, ` +
      `score may be unreliable (recommend 5+ MIUs)`
    )
  }

  // Low confidence
  if (trait_data.confidence < 0.65) {
    warnings.push(
      `${trait_name}: Low confidence (${trait_data.confidence.toFixed(2)})`
    )
  }

  // Contradictory signals
  if (stats.detections_high > 2 && stats.detections_low > 2) {
    const high_avg = stats.avg_intensity_high
    const low_avg = stats.avg_intensity_low

    if (Math.abs(high_avg - low_avg) < 0.15) {
      warnings.push(
        `${trait_name}: Contradictory signals (both HIGH and LOW with similar intensity)`
      )
    }
  }

  // Facet-trait mismatch (already checked in Step 7)

  // Outlier
  if (outliers.includes(trait_name)) {
    const z = Math.abs((trait_data.score - mean) / std_dev).toFixed(1)
    warnings.push(
      `${trait_name}: Statistical outlier (${z} SD from mean)`
    )
  }
}

// Global warnings
if (overall_confidence < 0.60) {
  warnings.push(
    "Overall confidence below recommended threshold (0.60) - " +
    "consider collecting more data"
  )
}

if (distribution_quality === 'flat') {
  warnings.push(
    "Flat distribution (all traits similar) - may indicate insufficient evidence differentiation"
  )
}

if (distribution_quality === 'polarized') {
  warnings.push(
    "Polarized distribution (extreme differences) - verify evidence quality"
  )
}
```

---

### Step 12: Generate Output YAML

**Write**: `bigfive-raw.yaml`

```typescript
const output = {
  profile_version: "1.0",
  framework: "Big Five (OCEAN)",
  analyzed_date: new Date().toISOString(),
  analyzer_version: "psychologist_v1.0.0",

  subject_id: metadata.subject_id,

  input_data: {
    fragments_file: "fragments.json",
    total_mius_available: metadata.total_fragments,
    mius_analyzed: filtered_mius.length,
    mius_filtered_out: metadata.total_fragments - filtered_mius.length,
    filter_criteria: "speaker:subject"
  },

  traits: { /* ... 5 traits with scores, facets, evidence */ },

  statistical_summary: { /* ... mean, std_dev, outliers, etc. */ },

  quality_checks: { /* ... 8 validation checks */ },

  warnings: warnings,

  processing_metadata: {
    total_batches: batches.length,
    mius_per_batch: BATCH_SIZE,
    processing_time_seconds: elapsed_time,
    cost_usd: estimated_cost,
    model: "claude-sonnet-4"
  },

  limitations: [
    "Analysis based on written text only (may not capture behavioral extraversion)",
    "Scores reflect current psychological state, not lifetime stability",
    "For informational purposes only, not clinical diagnosis",
    "Confidence scores calibrated to text quantity - more data improves accuracy"
  ]
}

// Write YAML
fs.writeFileSync('bigfive-raw.yaml', yaml.dump(output))
```

**Output file**: `bigfive-raw.yaml` (ready for @quality-assurance validation)

---

## Success Criteria

**Task succeeds if**:
- [ ] Output file `bigfive-raw.yaml` generated
- [ ] All 5 traits scored (0-100 range)
- [ ] All 30 facets scored
- [ ] Minimum 3 MIUs evidence per trait
- [ ] Overall confidence ≥ 0.60
- [ ] `validation_passed: true` OR warnings explain failures
- [ ] Processing time <90 seconds
- [ ] Cost <$0.20

---

## Error Handling

**Error**: fragments.json not found
- **Action**: Exit with error message + suggestion to run @fragment-extractor

**Error**: bigfive-framework.md not found
- **Action**: Exit with error message (missing KB)

**Error**: Claude API failure
- **Action**: Retry with exponential backoff (3 attempts), save partial results on final failure

**Warning**: <15 MIUs available
- **Action**: Proceed but add warning, reduce confidence by 0.20

**Warning**: Overall confidence <0.60
- **Action**: Proceed but add warning "LOW_CONFIDENCE_ANALYSIS"

---

## Testing Checklist

**Before deployment**:
- [ ] Test with 15 MIUs (minimum viable)
- [ ] Test with 50+ MIUs (rich evidence)
- [ ] Test with contradictory signals (e.g., "I love routine but hate schedules")
- [ ] Test with low evidence for one trait (ensure warnings fire)
- [ ] Test with outlier trait (e.g., Openness 95, others 40-60)
- [ ] Validate output YAML schema (parseable, all required fields)
- [ ] Check performance (<90s target)
- [ ] Check cost (<$0.15 target)
- [ ] Verify correlation with self-reported Big Five (N=10, r > 0.75)

---

**Task Status**: ✅ Ready for execution
**Last Updated**: 2025-01-14
**Owner**: @psychologist
**Framework**: Big Five (OCEAN)
**Version**: 1.0.0
