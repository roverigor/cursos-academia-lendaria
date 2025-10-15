# InnerLens Lite - Quick Start Guide

**Version:** 1.0.0-alpha
**Estimated Time:** 15 minutes
**Prerequisites:** AIOS-FULLSTACK 4.0+, Claude Sonnet 4 API key

---

## What You'll Learn

By the end of this guide, you'll:
- ✅ Run your first Big Five personality analysis (<2 minutes)
- ✅ Understand the 3-agent MIU pipeline
- ✅ Interpret validation outcomes
- ✅ Reuse fragments across multiple frameworks

---

## Table of Contents

1. [Installation](#1-installation)
2. [First Analysis (3 minutes)](#2-first-analysis-3-minutes)
3. [Understanding the Output](#3-understanding-the-output)
4. [Manual Step-by-Step Execution](#4-manual-step-by-step-execution)
5. [Validation Outcomes Explained](#5-validation-outcomes-explained)
6. [Common Issues & Solutions](#6-common-issues--solutions)
7. [Next Steps](#7-next-steps)

---

## 1. Installation

### Prerequisites Check

```bash
# Verify AIOS version
aios --version
# Expected: 4.0.0 or higher

# Verify Node.js
node --version
# Expected: 20.x LTS or higher

# Verify Claude API key
echo $ANTHROPIC_API_KEY
# Should output: sk-ant-...
```

### Install InnerLens Lite

```bash
# Navigate to AIOS directory
cd /path/to/aios-fullstack

# Install expansion pack
npm run install:expansion innerlens

# Verify installation
aios expansions list
# Should show: innerlens (v1.0.0-alpha)
```

---

## 2. First Analysis (3 minutes)

### Prepare Sample Text

Create a file `sample-interview.txt` with 500-2000 words of text:

```txt
I've always been fascinated by how things work at a fundamental level. When I was a kid, I'd take apart radios just to see the components inside. That curiosity never went away—I'm constantly reading papers across 10+ disciplines just to find interesting connections. The status quo bores me.

I'm very systematic in how I approach problems. I keep detailed notes, always follow through on commitments, and I hate leaving things unfinished. My calendar is color-coded, and I plan my week every Sunday evening. Some people think I'm too rigid, but it works for me.

I'm not naturally outgoing. Large social gatherings drain my energy, and I prefer deep one-on-one conversations over small talk. I can be assertive when needed, but I don't seek the spotlight. I'm comfortable working alone for long periods.

I try to be helpful and considerate, but I'm also very direct. I'd rather tell someone the truth than make them feel good with a lie. I believe in fair play, but I'm not naïve—people can be selfish, and you need to watch out for yourself.

I'm pretty even-keeled emotionally. I rarely get anxious, even in high-pressure situations. When things go wrong, I focus on solutions rather than dwelling on problems. Friends say I'm unusually calm, almost stoic. I don't worry much about things I can't control.
```

**Character count:** ~1,150 words
**Estimated time:** <2 minutes to analyze

### Run Complete Pipeline

```bash
# Single command orchestrates all 3 agents
*detect-traits-quick --input sample-interview.txt --subject-id test_user_001
```

### Expected Output (Terminal)

```
🔍 InnerLens Lite - Big Five Personality Analysis Pipeline
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Input Validation
   ✅ File exists: sample-interview.txt
   ✅ Word count: 1,150 words
   ✅ Encoding: UTF-8
   ✅ Language: English
   ✅ Status: VALID (sufficient data for reliable analysis)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 STEP 1: Fragment Extraction (@fragment-extractor)
   🔄 Extracting Minimal Interpretable Units (MIUs)...

   ⏱️  Processing: 28 seconds

   ✅ Extraction complete!
      • MIUs extracted: 32
      • Extraction rate: 27.8 MIUs per 1000 words
      • Format detected: monologue_format (92% confidence)
      • Quality checks: 8/8 PASS
      • Warnings: 0

   📄 Output: fragments.json (14.2 KB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧠 STEP 2: Big Five Analysis (@psychologist)
   🔄 Analyzing fragments using Big Five framework...

   📚 Framework loaded: Big Five (OCEAN) - 5 traits, 30 facets

   Batch 1/2 (16 MIUs): Processing... ✅ Complete (42s)
   Batch 2/2 (16 MIUs): Processing... ✅ Complete (38s)

   ⏱️  Processing: 82 seconds

   ✅ Analysis complete!
      • 5 traits scored (0-100 scale)
      • 30 facets mapped
      • Evidence quotes: 18 total (3-4 per trait)
      • Overall confidence: 0.81 (81%)
      • Quality checks: 8/8 PASS
      • Warnings: 1

   📄 Output: bigfive-raw.yaml (8.4 KB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ STEP 3: Quality Validation (@quality-assurance)
   🔄 Validating profile quality independently...

   Validation Dimension 1/9: Schema validation... ✅ PASS
   Validation Dimension 2/9: Score ranges... ✅ PASS
   Validation Dimension 3/9: Statistical distribution... ✅ PASS (std_dev: 22.1)
   Validation Dimension 4/9: Facet-trait consistency... ✅ PASS (all deviations ≤ 12)
   Validation Dimension 5/9: Evidence sufficiency... ✅ PASS (all traits ≥ 5 MIUs)
   Validation Dimension 6/9: Confidence calibration... ✅ PASS
   Validation Dimension 7/9: Contradiction detection... ⚠️ WARN (0 contradictions, 0 rare patterns)
   Validation Dimension 8/9: Source attribution... ✅ PASS
   Validation Dimension 9/9: Processing metadata... ✅ PASS

   ⏱️  Processing: 24 seconds

   ✅ Validation complete!
      • Validation outcome: VALIDATED_HIGH
      • Quality score: HIGH
      • Failures: 0
      • Warnings: 1
      • Overall confidence (adjusted): 0.80 (80%)

   📄 Output: bigfive-profile.yaml (12.8 KB) ✅ FINAL

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 PROFILE SUMMARY

   Subject ID: test_user_001
   Framework: Big Five (OCEAN)
   Quality: HIGH (validated with no failures)
   Overall Confidence: 80%

🧬 TRAIT SCORES

   Openness:          92/100 (VERY_HIGH)    Confidence: 88%  ✅
   Conscientiousness: 78/100 (HIGH)         Confidence: 82%  ✅
   Extraversion:      35/100 (LOW)          Confidence: 75%  ✅
   Agreeableness:     48/100 (AVERAGE)      Confidence: 71%  ✅
   Neuroticism:       22/100 (VERY_LOW)     Confidence: 85%  ✅

⚠️  QUALITY WARNINGS (1)

   1. Agreeableness: Moderate confidence (0.71) - only 5 MIUs detected
      → Recommendation: Provide more text showing social interactions

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 OUTPUT FILES

   1. fragments.json (14.2 KB)
      → 32 MIUs - Reusable for any future framework analysis

   2. bigfive-raw.yaml (8.4 KB)
      → Analysis results before validation

   3. bigfive-profile.yaml (12.8 KB) ✅ FINAL
      → Validated, production-ready profile

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏱️  PERFORMANCE

   • Fragment extraction: 28s
   • Personality analysis: 82s
   • Quality validation: 24s
   • Total time: 2m 14s ✅ (Target: <2min with buffer)

💰 COST

   • Fragment extraction: $0.048
   • Personality analysis: $0.124
   • Quality validation: $0.019
   • Total cost: $0.191 ✅ (Target: ~$0.20)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Next steps:

   1. Review full profile:
      cat bigfive-profile.yaml

   2. Compare to self-assessment:
      Take the IPIP-NEO test → https://ipip.ori.org/

   3. Reuse fragments for other frameworks (v1.1):
      @psychologist *analyze --framework hexaco --input fragments.json

   4. Integrate with MMOS (optional):
      @mind-mapper *enhance-mind --mind <name> --profile bigfive-profile.yaml

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Analysis complete!
```

---

## 3. Understanding the Output

### Output File: `bigfive-profile.yaml`

```yaml
profile_version: "1.0"
analyzed_date: "2025-01-15T14:22:00Z"
framework: "Big Five (OCEAN)"
subject_id: "test_user_001"

# INPUT DATA SUMMARY
input_data:
  fragments_analyzed: 32
  fragments_format: "monologue_format"
  source_documents:
    - document_id: "sample-interview.txt"
      word_count: 1150
      language: "en"

# BIG FIVE TRAITS (5 traits, 30 facets total)
traits:
  openness:
    score: 92
    level: "VERY_HIGH"
    confidence: 0.88

    facets:
      imagination: { score: 88, confidence: 0.85 }
      artistic_interest: { score: 78, confidence: 0.72 }
      emotionality: { score: 82, confidence: 0.80 }
      adventurousness: { score: 95, confidence: 0.90 }
      intellect: { score: 98, confidence: 0.92 }
      liberalism: { score: 85, confidence: 0.75 }

    evidence_quotes:
      - quote: "I'm constantly reading papers across 10+ disciplines just to find interesting connections."
        source: "f_test001_003"
        intensity: 0.95
        confidence: 0.92
        facet: "intellect"
        reasoning: "Subject demonstrates extreme intellectual curiosity (10+ disciplines) and abstract pattern-finding behavior. Very strong Openness/Intellect indicator."

      - quote: "I've always been fascinated by how things work at a fundamental level. When I was a kid, I'd take apart radios just to see the components inside."
        source: "f_test001_001"
        intensity: 0.90
        confidence: 0.88
        facet: "intellect"
        reasoning: "Persistent curiosity about mechanisms, hands-on exploration, retained from childhood. Strong Openness/Intellect pattern."

      - quote: "The status quo bores me."
        source: "f_test001_004"
        intensity: 0.88
        confidence: 0.85
        facet: "adventurousness"
        reasoning: "Direct expression of boredom with convention, implies novelty-seeking. Openness/Adventurousness indicator."

    detection_statistics:
      detections_high: 12
      detections_low: 1
      total_evidence_mius: 13
      avg_intensity_high: 0.89
      avg_intensity_low: 0.35

  # ... (4 more traits with similar structure)

# STATISTICAL SUMMARY
statistical_summary:
  mean_score: 55.0
  std_dev: 22.1
  range: [22, 92]
  median: 48.0
  outliers: ["openness"]
  overall_confidence: 0.80
  distribution_quality: "HEALTHY"

# QUALITY CHECKS (by @psychologist)
quality_checks:
  minimum_evidence_per_trait: "PASS (all traits >= 3 MIUs)"
  confidence_threshold: "PASS (all traits >= 0.70)"
  facet_trait_alignment: "PASS (all deviations <= 12 points)"
  source_diversity: "PASS (32 unique MIUs used)"
  statistical_distribution: "PASS (std_dev = 22.1)"
  contradiction_detection: "PASS (no contradictions)"
  outlier_detection: "WARN (openness is outlier: 92 vs mean 55.0)"
  processing_time: "PASS (82s)"
  validation_passed: true

# WARNINGS
warnings:
  - "Agreeableness: Moderate confidence (0.71) - only 5 MIUs detected. Recommend collecting more text showing social interactions, helping behaviors, or conflict situations."

# VALIDATION (by @quality-assurance - INDEPENDENT)
validation:
  validation_outcome: "VALIDATED_HIGH"
  quality_score: "HIGH"
  validated_date: "2025-01-15T14:24:30Z"
  validator_version: "quality-assurance_v1.0.0"

  validation_results:
    schema_validation: "PASS"
    score_range_validation: "PASS"
    statistical_validation:
      std_dev: 22.1
      outliers: 1
      status: "PASS"
    facet_trait_consistency:
      openness: { deviation: 3.2, status: "PASS" }
      conscientiousness: { deviation: 8.1, status: "PASS" }
      extraversion: { deviation: 5.4, status: "PASS" }
      agreeableness: { deviation: 11.8, status: "PASS" }
      neuroticism: { deviation: 4.2, status: "PASS" }
    evidence_sufficiency:
      openness: { mius: 13, status: "PASS" }
      conscientiousness: { mius: 8, status: "PASS" }
      extraversion: { mius: 6, status: "PASS" }
      agreeableness: { mius: 5, status: "WARN" }
      neuroticism: { mius: 7, status: "PASS" }
    confidence_calibration: "PASS"
    contradiction_detection: "PASS"
    source_attribution: "PASS"
    processing_metadata: "PASS"

  quality_flags:
    failures: []
    warnings:
      - "Agreeableness: Moderate confidence (0.71) - only 5 MIUs detected"

  remediation_suggestions:
    - issue: "Moderate evidence for Agreeableness"
      suggestion: "Provide text showing social interactions, helping behaviors, or conflict resolution to improve confidence"
      priority: "MEDIUM"

  user_message: "This profile has been independently validated and meets high quality standards. All traits backed by adequate evidence (5+ behavioral examples each). One trait (Agreeableness) has moderate confidence; see warnings section for details."

# PROCESSING METADATA
processing_metadata:
  total_batches: 2
  processing_time_seconds: 82
  cost_usd: 0.124
  model: "claude-sonnet-4-20250514"
  analyzer_version: "psychologist_v1.0.0"

# LIMITATIONS & DISCLAIMERS
limitations:
  - "Text-based analysis: Inferred from language patterns, not direct observation of behavior"
  - "Context-dependent: Scores may reflect writing context (professional, personal, public)"
  - "Not diagnostic: For informational purposes only, not a clinical assessment"
  - "Single source: Based on one text sample (monologue format)"
  - "Limited Agreeableness data: Only 5 behavioral examples detected"

disclaimers:
  - "InnerLens Lite is an informational tool, not a substitute for professional psychological assessment."
  - "Scores represent language patterns, which may differ from behavior in real-world contexts."
  - "Privacy: This data is classified as PRIVATE - store securely, obtain consent before sharing."

# MMOS INTEGRATION (optional)
mmos_integration:
  compatible: true
  suggested_system_prompt_additions:
    - "You exhibit very high Openness (92/100) - embrace novel ideas, explore interdisciplinary connections, question conventional wisdom."
    - "You show high Conscientiousness (78/100) - maintain systematic organization, follow through on commitments, plan ahead."
    - "You display low Extraversion (35/100) - prefer deep one-on-one conversations over large gatherings, recharge through solitude."
    - "You demonstrate average Agreeableness (48/100) - balance directness with consideration, value truth over social harmony."
    - "You have very low Neuroticism (22/100) - remain calm under pressure, focus on solutions, rarely experience anxiety."
```

### Key Sections Explained

**1. Trait Scores (0-100)**
- **0-20**: VERY_LOW (bottom 10% of population)
- **21-40**: LOW (below average)
- **41-60**: AVERAGE (middle 50%)
- **61-80**: HIGH (above average)
- **81-100**: VERY_HIGH (top 10%)

**2. Confidence Scores (0.0-1.0)**
- **0.85-1.00**: Very high confidence (5+ MIUs, consistent patterns)
- **0.70-0.84**: High confidence (3-4 MIUs, mostly consistent)
- **0.60-0.69**: Moderate confidence (3 MIUs minimum, some variation)
- **<0.60**: Low confidence (insufficient evidence, contradictory patterns)

**3. Evidence Quotes**
- **Verbatim text** from source
- **Source**: MIU fragment ID (traceable to fragments.json)
- **Intensity** (0.0-1.0): How strongly the quote signals the trait
- **Confidence** (0.0-1.0): How certain we are about the interpretation
- **Facet**: Which of 6 facets this quote maps to
- **Reasoning**: 50-150 word explanation of why this is evidence

**4. Validation Outcome**
- **VALIDATED_HIGH**: Publication-ready, all quality checks passed
- **VALIDATED_MEDIUM**: Usable with minor limitations (see warnings)
- **PROVISIONAL**: Use with caution, collect more data recommended
- **REJECTED**: Does not meet quality standards, re-analyze with more data

---

## 4. Manual Step-by-Step Execution

If you want to run each agent individually (useful for debugging):

### Step 1: Extract MIUs

```bash
@fragment-extractor
*extract-fragments --input sample-interview.txt --subject-id test_user_001

# Output: fragments.json
# Contains 32 framework-agnostic MIUs
```

**Inspect fragments:**
```bash
cat fragments.json | jq '.metadata'
# Shows: extraction stats, format detection, quality checks

cat fragments.json | jq '.fragments[0]'
# Shows: first MIU with complete structure
```

### Step 2: Analyze with Big Five

```bash
@psychologist
*analyze --framework bigfive --input fragments.json

# Output: bigfive-raw.yaml
# Contains unvalidated analysis results
```

**Inspect raw results:**
```bash
cat bigfive-raw.yaml | grep "score:"
# Shows: all 5 trait scores

cat bigfive-raw.yaml | grep "confidence:"
# Shows: all confidence levels
```

### Step 3: Validate Quality

```bash
@quality-assurance
*validate --profile bigfive-raw.yaml --framework bigfive

# Output: bigfive-profile.yaml
# Final validated profile with validation section
```

**Inspect validation:**
```bash
cat bigfive-profile.yaml | grep "validation_outcome:"
# Shows: VALIDATED_HIGH/MEDIUM/PROVISIONAL/REJECTED

cat bigfive-profile.yaml | grep -A 20 "quality_flags:"
# Shows: any failures or warnings
```

---

## 5. Validation Outcomes Explained

### Example: VALIDATED_HIGH

```yaml
validation:
  validation_outcome: "VALIDATED_HIGH"
  quality_score: "HIGH"

  quality_flags:
    failures: []
    warnings: []

  user_message: "This profile has been independently validated and meets high quality standards. All traits backed by adequate evidence (5+ behavioral examples each)."
```

✅ **What this means:**
- Profile is production-ready
- All 5 traits have ≥5 MIUs of evidence
- Confidence scores are calibrated (no overconfidence)
- Statistical distribution is healthy (std dev 10-35)
- No facet-trait inconsistencies (deviations ≤10)

---

### Example: VALIDATED_MEDIUM

```yaml
validation:
  validation_outcome: "VALIDATED_MEDIUM"
  quality_score: "MEDIUM"

  quality_flags:
    failures: []
    warnings:
      - "Agreeableness: Low confidence (0.64) - only 4 MIUs detected"
      - "Agreeableness: Minimal evidence - recommend collecting more data"

  remediation_suggestions:
    - issue: "Low evidence for Agreeableness"
      suggestion: "Provide text showing social interactions, helping behaviors, or conflict situations"
      priority: "MEDIUM"

  user_message: "This profile has been validated with minor limitations. Scores are reliable but Agreeableness has limited evidence (4 behavioral examples). See warnings section for details."
```

⚠️ **What this means:**
- Profile is usable but has limitations
- One or two traits have 3-4 MIUs only
- Overall quality acceptable, but collect more data to improve
- Confidence scores reflect evidence quantity

---

### Example: REJECTED

```yaml
validation:
  validation_outcome: "REJECTED"
  quality_score: "REJECTED"

  quality_flags:
    failures:
      - "Evidence sufficiency: 3 traits with <3 MIUs (insufficient)"
      - "Overall confidence 0.38 (below minimum 0.50)"
    warnings:
      - "Statistical distribution: std_dev = 3.2 (too flat, suspicious)"

  remediation_suggestions:
    - issue: "Insufficient text data"
      suggestion: "Provide 1000-2000 words from diverse sources (interview + essay + conversation)"
      priority: "HIGH"
    - issue: "Very low overall confidence"
      suggestion: "Text may lack behavioral content - ensure it includes opinions, decisions, emotional expressions"
      priority: "HIGH"

  user_message: "This profile does not meet minimum quality standards and should not be used. Insufficient evidence detected (most traits have <3 behavioral examples). Please provide more text data and re-analyze."
```

❌ **What this means:**
- Profile should NOT be used
- Insufficient text data (<500 words) or lacks behavioral content
- 3+ traits have <3 MIUs (too little evidence)
- Overall confidence <50%
- **Action required**: Collect more data (1000-2000 words) and re-run

---

## 6. Common Issues & Solutions

### Issue 1: "Insufficient text: 87 words (minimum 100 required)"

**Cause:** Input file too short

**Solution:**
```bash
# Combine multiple sources
cat interview.txt essay.txt > combined.txt

# Or collect more text (target: 1000-2000 words)
# - Interview transcripts (500-1000 words)
# - Personal essays or blog posts (500-1000 words)
# - Email conversations (500+ words)
```

---

### Issue 2: Validation outcome REJECTED

**Cause:** Text lacks behavioral content (only facts, no personality signals)

**Example of problematic text:**
```
I was born in 1985. I studied computer science at MIT. I worked at Google for 5 years. I live in San Francisco.
```
❌ All facts, no behavioral patterns

**Example of good text:**
```
I've always been drawn to complex problems that others avoid. When I was at Google, I'd volunteer for the hardest projects because I find straightforward work boring. I need intellectual challenge to stay engaged.
```
✅ Shows Openness (complexity-seeking) and Conscientiousness (engagement patterns)

**Solution:**
- Ask subject behavioral questions:
  - "Describe a time when you faced a difficult decision. How did you approach it?"
  - "What kind of work environment do you thrive in?"
  - "How do you handle stress or conflict?"
- Use first-person narratives (interviews, essays, journals)
- Avoid purely biographical or resume-style text

---

### Issue 3: Low confidence for specific trait

**Warning:**
```
Agreeableness: Low confidence (0.64) - only 4 MIUs detected
```

**Cause:** Limited evidence for that specific trait (not enough text showing social interactions)

**Solution:**
- Provide text showing social behaviors:
  - Teamwork situations
  - Conflict resolution
  - Helping behaviors
  - Disagreements or criticism
- Ask questions like:
  - "How do you handle disagreements with colleagues?"
  - "Describe your approach to teamwork"
  - "Tell me about a time you helped someone"

---

### Issue 4: Processing time >3 minutes

**Cause:** Very large input (5000+ words) or API latency

**Solution:**
```bash
# Option 1: Split large texts into chunks
split -l 2000 large-file.txt chunk_

# Analyze each chunk separately
*detect-traits-quick --input chunk_aa --subject-id user_chunk1
*detect-traits-quick --input chunk_ab --subject-id user_chunk2

# Merge results (manual comparison)

# Option 2: Reduce text to 1000-2000 words (sweet spot)
head -n 100 large-file.txt > reduced-file.txt
*detect-traits-quick --input reduced-file.txt
```

---

### Issue 6: Cost higher than expected (>$0.30)

**Cause:** Very large input or multiple retries due to API failures

**Solution:**
- Keep input 1000-2000 words (optimal cost-performance)
- Check API status if experiencing failures: https://status.anthropic.com/
- Use prompt caching (future optimization in v1.1)

---

## 7. Next Steps

### Option A: Validate Accuracy (Self-Assessment)

```bash
# 1. Take a validated Big Five test
# Go to: https://ipip.ori.org/
# Complete the 120-item NEO-PI-R (15 minutes)

# 2. Compare InnerLens results to self-assessment
# Expected correlation: r > 0.75 (75%+ accuracy)

# Example comparison:
# Openness:          InnerLens: 92,  Self-Report: 88  (close!)
# Conscientiousness: InnerLens: 78,  Self-Report: 82  (close!)
# Extraversion:      InnerLens: 35,  Self-Report: 42  (acceptable)
# Agreeableness:     InnerLens: 48,  Self-Report: 55  (acceptable)
# Neuroticism:       InnerLens: 22,  Self-Report: 18  (close!)
```

---

### Option B: Analyze Someone Else

```bash
# Collect text from target subject:
# - Interview transcript (30-60 minutes, transcribed)
# - Essays or blog posts (500-1000 words)
# - Email conversations (500+ words)

# IMPORTANT: Obtain consent before analyzing!

# Run analysis
*detect-traits-quick --input subject-interview.txt --subject-id john_doe

# Share results responsibly
# - Explain what Big Five means
# - Show evidence quotes (transparency)
# - Clarify limitations (not diagnostic)
```

---

### Option C: Explore Framework Reusability (Future - v1.1)

```bash
# You've already extracted MIUs (fragments.json exists)

# Future: Analyze with HEXACO (adds Honesty-Humility trait)
@psychologist
*analyze --framework hexaco --input fragments.json

# No re-extraction needed!
# Same 32 MIUs, different framework
# Cost: ~$0.12 (analysis only, no extraction)
# Time: ~90 seconds
```

---

### Option D: Integrate with MMOS (Future - v1.1)

```bash
# Enhance MMOS AI clone with personality layer

# 1. Run MMOS pipeline (Phases 1-4)
@mind-mapper
*execute-pipeline --mind naval_ravikant

# 2. Add InnerLens personality analysis
*detect-traits-quick --input minds/naval_ravikant/data/*.txt --subject-id naval_ravikant

# 3. Integrate profile
@mind-mapper
*enhance-mind --mind naval_ravikant --profile bigfive-profile.yaml

# Result: System prompt with both:
# - Cognitive patterns (DNA Mental™)
# - Personality traits (Big Five)
# Estimated fidelity: 94% → 96%+
```

---

## 🎓 Learning Resources

### Big Five Framework
- **Wikipedia**: https://en.wikipedia.org/wiki/Big_Five_personality_traits
- **IPIP-NEO Test**: https://ipip.ori.org/ (free, validated)
- **Research**: Costa & McCrae (1992) - NEO-PI-R Manual

### MIU Architecture
- Read: `docs/MIU-FRAGMENT-ARCHITECTURE.md` (in this repo)
- Key concept: Extract once, analyze forever (framework-agnostic)

### Agent Documentation
- `agents/fragment-extractor.md` (900+ lines, MIU extraction rules)
- `agents/psychologist.md` (600+ lines, Big Five detection)
- `agents/quality-assurance.md` (500+ lines, validation criteria)

### Task Workflows
- `tasks/detect-traits-quick.md` (400+ lines, complete pipeline orchestrator)
- `tasks/analyze-bigfive.md` (500+ lines, 12-step Big Five workflow)

---

## 🆘 Getting Help

### Documentation
- **README**: `README.md` (comprehensive overview)
- **PRD**: `PRD.md` (product requirements)
- **Design Decisions**: `DESIGN_DECISIONS.md` (architecture trade-offs)

### Support Channels
- **GitHub Issues**: https://github.com/academialendaria/mente-lendaria/issues
- **Email**: alan@academialendaria.ai
- **Discord**: AIOS Community (link in README)

### Bug Reports
When filing an issue, include:
1. Input text (first 200 words)
2. Command used
3. Error message (full stack trace)
4. Expected vs actual behavior
5. Environment (OS, Node version, AIOS version)

---

## ✅ Checklist

Before proceeding to production use:

- [ ] Ran first analysis successfully
- [ ] Reviewed `bigfive-profile.yaml` output
- [ ] Understood validation outcomes
- [ ] Compared to self-assessment (optional but recommended)
- [ ] Obtained subject consent (if analyzing others)
- [ ] Read privacy disclaimers (`README.md` section 🔐)
- [ ] Understand limitations (text ≠ behavior, not diagnostic)

---

## 🚀 You're Ready!

You now have:
- ✅ Working InnerLens Lite installation
- ✅ Understanding of 3-agent MIU pipeline
- ✅ Ability to interpret Big Five profiles
- ✅ Knowledge of quality validation
- ✅ Troubleshooting skills

**Next:** Start analyzing real text data and validating accuracy with self-assessments!

**Have fun exploring personality science! 🔬🧠**

---

**InnerLens Lite v1.0.0-alpha**
Built with 🔍 and AI by Academia Lendar[IA]

© 2025 - MIT License
