# Epic 0 Testing Plan - Real-World Validation

**Version:** 1.0
**Created:** 2025-01-15
**Status:** 🔬 Active Testing
**Target Completion:** 2025-01-22 (1 week)

---

## 🎯 Testing Objectives

### Primary Goals

1. **Accuracy Validation**: Achieve 75%+ correlation with self-reported Big Five scores
2. **Performance Validation**: Confirm <2 min total pipeline time (1000-2000 word samples)
3. **Quality Validation**: Demonstrate validation outcomes work as designed
4. **Usability Validation**: NPS 8+ from beta testers (N=5)

### Success Criteria

| Metric | Target | Minimum Acceptable |
|--------|--------|-------------------|
| **Accuracy (Pearson r)** | 0.75+ per trait | 0.70 per trait |
| **Overall Accuracy** | 0.75+ (mean across 5 traits) | 0.70 |
| **Performance** | <2 min (90th percentile) | <3 min (95th percentile) |
| **Validation Outcomes** | 80%+ VALIDATED_HIGH or VALIDATED_MEDIUM | 70%+ |
| **Cost** | <$0.25 per analysis | <$0.30 |
| **NPS Score** | 8+ | 7+ |

---

## 👥 Test Subject Recruitment

### Sample Size

- **Accuracy Testing**: N=10 test subjects (minimum)
  - Ideal: N=15-20 for statistical power
- **Beta Testing**: N=5 beta testers (usability feedback)
- **Total**: 10-20 participants

### Inclusion Criteria

✅ **Must have:**
- Age 18+ (consent capability)
- Fluent in English (text samples must be in English for MVP)
- Access to 500-2000 words of written content (essays, interviews, emails, blog posts)
- Willing to complete IPIP-NEO self-assessment (120 items, ~15 minutes)
- Consent to personality analysis (informed consent)

✅ **Ideal (bonus):**
- Diverse demographics (age, gender, profession, culture)
- Previous Big Five familiarity (for feedback quality)
- WhatsApp export available (for Epic 1 multimodal testing)
- Email archive available (for Epic 1 multimodal testing)

❌ **Exclusion Criteria:**
- Under 18 years old
- Non-English text samples (MVP limitation)
- Unwilling to share writing samples
- Clinical mental health conditions (not a diagnostic tool)

### Recruitment Channels

1. **Personal Network**
   - Friends, family, colleagues
   - Academia connections
   - Social media (LinkedIn, Twitter/X)

2. **Online Communities**
   - AIOS Discord community
   - Reddit: r/machinelearning, r/psychology, r/mbti
   - HackerNews "Show HN" post

3. **Academic Partnerships**
   - Psychology departments (undergraduate participants)
   - Personality research labs

4. **Incentives**
   - Free Big Five personality report (detailed, with evidence quotes)
   - Early access to InnerLens Lite (before public release)
   - Acknowledgment in documentation (with permission)
   - Small compensation ($10-20 Amazon gift card for 20+ participants)

---

## 📋 Testing Protocol

### Phase 1: Recruitment & Data Collection (Days 1-2)

#### Step 1.1: Send Recruitment Message

**Template:** See `testing/templates/recruitment-message.md`

**Key points:**
- Explain InnerLens Lite (AI-powered Big Five analysis)
- Time commitment: 30-45 minutes total
- What they'll receive: Detailed personality report
- Privacy: Data anonymized, used only for validation
- Consent: Must agree to informed consent form

#### Step 1.2: Send Informed Consent Form

**Template:** See `testing/templates/informed-consent-form.md`

**Required sections:**
- Purpose of research (validate InnerLens Lite accuracy)
- What data is collected (text samples, self-assessment scores)
- How data is used (accuracy testing, anonymized results)
- Privacy protections (data encryption, anonymization)
- Right to withdraw (anytime, no penalty)
- Contact information (for questions)

#### Step 1.3: Collect Self-Assessment Scores

**Instrument:** IPIP-NEO (120-item Big Five)
- **Link:** https://ipip.ori.org/New_IPIP-50-item-scale.htm (short version)
- **Link:** https://ipip.ori.org/NEO-PI-RItemKey.htm (full 300-item version)
- **Recommended:** 50-item version (10 items per trait, ~10 minutes)

**Alternative:** Big Five Inventory (BFI-44)
- **Link:** https://www.ocf.berkeley.edu/~johnlab/bfi.htm
- **Pros:** Shorter (44 items, ~5 minutes)
- **Cons:** Less reliable than IPIP-NEO

**Instructions to participants:**
1. Take the IPIP-NEO-50 questionnaire (10 minutes)
2. Download or screenshot your results
3. Send results via secure channel (email with encryption or private message)
4. Format: CSV, JSON, or screenshot (we'll manually enter if needed)

**Expected output format:**
```csv
trait,score
Openness,78
Conscientiousness,65
Extraversion,42
Agreeableness,58
Neuroticism,35
```

#### Step 1.4: Collect Text Samples

**Guidelines:** See `testing/templates/data-collection-guidelines.md`

**Requirements:**
- **Minimum:** 500 words
- **Ideal:** 1000-2000 words
- **Format:** Plain text (.txt) or PDF (we'll convert)
- **Language:** English
- **Content types (choose 1-3):**
  - Personal essay or blog post
  - Interview transcript
  - Email conversations (personal, not professional spam)
  - Journal entries
  - Social media posts (Twitter threads, LinkedIn articles)
  - Code commit messages with explanations (for developers)

**Privacy instructions:**
- Remove names, email addresses, phone numbers (PII)
- Remove company names if sensitive
- Keep personality-relevant content (opinions, decisions, behaviors)
- It's OK to include: "I think...", "I always...", "I hate when..."

**File naming convention:**
```
subject_<ID>_<source_type>.txt

Examples:
subject_001_essay.txt
subject_001_interview.txt
subject_002_blog_posts.txt
```

---

### Phase 2: Analysis Execution (Days 3-4)

#### Step 2.1: Input Validation

For each test subject:

```bash
# Validate input file
cat subject_001_essay.txt | wc -w
# Expected: 500-2000 words

# Check encoding
file -I subject_001_essay.txt
# Expected: charset=utf-8

# Check language (manual inspection)
head -n 5 subject_001_essay.txt
```

**Log validation results:**
```yaml
subject_id: "001"
input_validation:
  file_exists: true
  word_count: 1247
  encoding: "utf-8"
  language: "en"
  status: "VALID"
```

#### Step 2.2: Run Pipeline

```bash
# Execute complete pipeline
*detect-traits-quick \
  --input subject_001_essay.txt \
  --subject-id subject_001

# Log start time
START_TIME=$(date +%s)

# Wait for completion...

# Log end time
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo "Duration: ${DURATION} seconds"
```

**Capture outputs:**
- `fragments.json` → Save as `results/subject_001_fragments.json`
- `bigfive-raw.yaml` → Save as `results/subject_001_bigfive_raw.yaml`
- `bigfive-profile.yaml` → Save as `results/subject_001_bigfive_profile.yaml`

#### Step 2.3: Extract Results

```bash
# Extract scores from validated profile
cat results/subject_001_bigfive_profile.yaml | grep "score:" | head -n 5

# Expected output:
# Openness: score: 82
# Conscientiousness: score: 68
# Extraversion: score: 45
# Agreeableness: score: 55
# Neuroticism: score: 38

# Extract validation outcome
cat results/subject_001_bigfive_profile.yaml | grep "validation_outcome:"

# Expected: VALIDATED_HIGH, VALIDATED_MEDIUM, PROVISIONAL, or REJECTED
```

**Create results summary:**
```yaml
subject_id: "001"
analysis_results:
  openness: 82
  conscientiousness: 68
  extraversion: 45
  agreeableness: 55
  neuroticism: 38
  overall_confidence: 0.78
  validation_outcome: "VALIDATED_MEDIUM"
  processing_time_seconds: 127
  cost_usd: 0.182
```

---

### Phase 3: Accuracy Validation (Days 5-6)

#### Step 3.1: Compile Results Matrix

Create `testing/results/accuracy-validation-matrix.csv`:

```csv
subject_id,source,openness_self,openness_innerlens,conscientiousness_self,conscientiousness_innerlens,extraversion_self,extraversion_innerlens,agreeableness_self,agreeableness_innerlens,neuroticism_self,neuroticism_innerlens,validation_outcome
001,essay,78,82,65,68,42,45,58,55,35,38,VALIDATED_MEDIUM
002,interview,85,88,72,70,55,52,48,50,28,25,VALIDATED_HIGH
003,blog,92,90,68,72,38,35,52,48,22,20,VALIDATED_HIGH
...
```

#### Step 3.2: Calculate Pearson Correlations

**Method 1: Python script**

```python
import pandas as pd
from scipy.stats import pearsonr

# Load data
df = pd.read_csv('testing/results/accuracy-validation-matrix.csv')

# Calculate correlation per trait
traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

results = {}
for trait in traits:
    self_col = f'{trait}_self'
    innerlens_col = f'{trait}_innerlens'

    r, p_value = pearsonr(df[self_col], df[innerlens_col])
    results[trait] = {
        'correlation': r,
        'p_value': p_value,
        'significant': p_value < 0.05
    }

# Overall correlation (mean across traits)
overall_r = sum([results[t]['correlation'] for t in traits]) / len(traits)

print(f"Overall correlation: {overall_r:.3f}")
for trait, stats in results.items():
    print(f"{trait.capitalize()}: r={stats['correlation']:.3f}, p={stats['p_value']:.4f}")
```

**Expected output:**
```
Overall correlation: 0.782
Openness: r=0.815, p=0.0023
Conscientiousness: r=0.768, p=0.0089
Extraversion: r=0.742, p=0.0145
Agreeableness: r=0.795, p=0.0051
Neuroticism: r=0.792, p=0.0061
```

✅ **Success:** Overall r ≥ 0.75 AND all traits r ≥ 0.70
⚠️ **Marginal:** Overall r ≥ 0.70 AND most traits r ≥ 0.65
❌ **Failure:** Overall r < 0.70 OR 2+ traits r < 0.65

#### Step 3.3: Error Analysis

For each subject, calculate **absolute error per trait**:

```
absolute_error = |innerlens_score - self_report_score|
```

**Acceptable error ranges:**
- **Excellent:** ≤10 points (very close)
- **Good:** 11-15 points (close)
- **Acceptable:** 16-20 points (moderate)
- **Poor:** 21-30 points (large gap)
- **Very Poor:** >30 points (failed)

**Target:** 80%+ of scores within ≤15 points (excellent or good)

**Create error distribution:**
```csv
subject_id,trait,self_score,innerlens_score,absolute_error,error_category
001,openness,78,82,4,excellent
001,conscientiousness,65,68,3,excellent
001,extraversion,42,45,3,excellent
001,agreeableness,58,55,3,excellent
001,neuroticism,35,38,3,excellent
002,openness,85,88,3,excellent
...
```

#### Step 3.4: Identify Systematic Biases

Check for systematic over/underestimation:

```python
# Calculate mean bias per trait
for trait in traits:
    bias = (df[f'{trait}_innerlens'] - df[f'{trait}_self']).mean()
    print(f"{trait.capitalize()}: Mean bias = {bias:.2f}")

# Expected output:
# Openness: Mean bias = +2.3 (slightly overestimated)
# Conscientiousness: Mean bias = -1.5 (slightly underestimated)
# Extraversion: Mean bias = -0.8 (minimal bias)
# Agreeableness: Mean bias = +1.2 (minimal bias)
# Neuroticism: Mean bias = -2.1 (slightly underestimated)
```

**Acceptable bias:** Mean bias ≤ ±5 points (no systematic error)
**Action if bias > 5:** Adjust scoring algorithm or marker weights

---

### Phase 4: Performance Validation (Day 6)

#### Step 4.1: Measure Processing Time

For each analysis, capture:
- **Fragment extraction time** (Step 1: @fragment-extractor)
- **Analysis time** (Step 2: @psychologist)
- **Validation time** (Step 3: @quality-assurance)
- **Total pipeline time** (end-to-end)

**Data collection:**
```yaml
subject_id: "001"
performance:
  word_count: 1247
  fragment_extraction_seconds: 29
  analysis_seconds: 87
  validation_seconds: 23
  total_seconds: 139
  cost_usd: 0.182
```

#### Step 4.2: Calculate Performance Statistics

```python
df_perf = pd.read_csv('testing/results/performance-metrics.csv')

# Overall statistics
print(f"Mean total time: {df_perf['total_seconds'].mean():.1f}s")
print(f"Median total time: {df_perf['total_seconds'].median():.1f}s")
print(f"90th percentile: {df_perf['total_seconds'].quantile(0.90):.1f}s")
print(f"95th percentile: {df_perf['total_seconds'].quantile(0.95):.1f}s")
print(f"Max time: {df_perf['total_seconds'].max():.1f}s")

# Expected output:
# Mean total time: 132.5s
# Median total time: 128.0s
# 90th percentile: 145.0s
# 95th percentile: 157.0s
# Max time: 168.0s
```

✅ **Success:** 90th percentile ≤ 120s (2 minutes)
⚠️ **Marginal:** 90th percentile ≤ 150s (2.5 minutes)
❌ **Failure:** 90th percentile > 180s (3 minutes)

#### Step 4.3: Cost Analysis

```python
# Cost statistics
print(f"Mean cost: ${df_perf['cost_usd'].mean():.3f}")
print(f"Max cost: ${df_perf['cost_usd'].max():.3f}")

# Expected output:
# Mean cost: $0.187
# Max cost: $0.225
```

✅ **Success:** Mean cost ≤ $0.20
⚠️ **Marginal:** Mean cost ≤ $0.25
❌ **Failure:** Mean cost > $0.30

---

### Phase 5: Quality Validation (Day 7)

#### Step 5.1: Validation Outcome Distribution

Count validation outcomes:

```python
df_quality = pd.read_csv('testing/results/accuracy-validation-matrix.csv')

outcome_counts = df_quality['validation_outcome'].value_counts()
print(outcome_counts)

# Expected output:
# VALIDATED_HIGH       6
# VALIDATED_MEDIUM     3
# PROVISIONAL          1
# REJECTED             0
```

✅ **Success:** 80%+ VALIDATED_HIGH or VALIDATED_MEDIUM
⚠️ **Marginal:** 70%+ VALIDATED_HIGH or VALIDATED_MEDIUM
❌ **Failure:** <70% VALIDATED_HIGH or VALIDATED_MEDIUM

#### Step 5.2: Confidence Calibration Analysis

Check if confidence scores match actual accuracy:

```python
# For each subject, calculate:
# - Mean confidence across 5 traits
# - Mean absolute error across 5 traits

df_calib = pd.DataFrame({
    'mean_confidence': [...],
    'mean_absolute_error': [...]
})

# Expected: Higher confidence → Lower error
r, p = pearsonr(df_calib['mean_confidence'], df_calib['mean_absolute_error'])
print(f"Confidence-Error correlation: r={r:.3f}, p={p:.4f}")

# Target: r < -0.40 (moderate negative correlation)
# Meaning: High confidence predicts low error
```

✅ **Well-calibrated:** r ≤ -0.40 (confidence inversely correlates with error)
⚠️ **Moderately calibrated:** -0.40 < r ≤ -0.20
❌ **Poorly calibrated:** r > -0.20 (confidence doesn't predict accuracy)

---

### Phase 6: Usability Testing (Beta Testers - Days 6-7)

#### Step 6.1: Beta Tester Recruitment

**Criteria:**
- Different from accuracy test subjects (fresh perspective)
- N=5 testers
- Willing to provide detailed feedback (30-min interview)

**Instructions:**
1. Install InnerLens Lite following QUICKSTART.md
2. Run analysis on your own text (500-2000 words)
3. Review output (bigfive-profile.yaml)
4. Complete feedback survey
5. Optional: 30-min interview for detailed feedback

#### Step 6.2: Feedback Survey

**Template:** See `testing/templates/beta-tester-survey.md`

**Key questions:**
1. **Installation difficulty** (1-10 scale)
2. **Clarity of instructions** (1-10 scale)
3. **Output understandability** (1-10 scale)
4. **Trust in results** (1-10 scale)
5. **Would you recommend?** (NPS: 0-10 scale)
6. **Most confusing part?** (open-ended)
7. **Most impressive part?** (open-ended)
8. **Suggestions for improvement?** (open-ended)

#### Step 6.3: Calculate NPS

**NPS (Net Promoter Score):**
- **Promoters** (9-10): Enthusiastic supporters
- **Passives** (7-8): Satisfied but unenthusiastic
- **Detractors** (0-6): Unhappy users

```
NPS = % Promoters - % Detractors

Example:
5 testers: 9, 8, 10, 7, 9
Promoters: 3 (60%)
Passives: 2 (40%)
Detractors: 0 (0%)
NPS = 60% - 0% = 60
```

✅ **Success:** NPS ≥ 50 (world-class)
⚠️ **Marginal:** NPS ≥ 30 (good)
❌ **Failure:** NPS < 30 (needs improvement)

**Alternative metric (simpler):**
Average recommendation score (0-10):
- ✅ **Success:** ≥ 8.0
- ⚠️ **Marginal:** ≥ 7.0
- ❌ **Failure:** < 7.0

---

## 📊 Results Documentation

### Final Report Structure

Create `testing/results/EPIC-0-VALIDATION-REPORT.md`:

```markdown
# Epic 0 Validation Report

**Test Period:** 2025-01-15 to 2025-01-22
**Participants:** N=10 (accuracy), N=5 (beta testing)
**Version Tested:** InnerLens Lite v1.0.0-alpha

## Executive Summary

[2-3 paragraph summary of results]

## Accuracy Results

### Overall Correlation: 0.782 ✅

| Trait | Correlation (r) | P-value | Status |
|-------|----------------|---------|--------|
| Openness | 0.815 | 0.0023 | ✅ Pass |
| Conscientiousness | 0.768 | 0.0089 | ✅ Pass |
| Extraversion | 0.742 | 0.0145 | ✅ Pass |
| Agreeableness | 0.795 | 0.0051 | ✅ Pass |
| Neuroticism | 0.792 | 0.0061 | ✅ Pass |

**Conclusion:** ✅ Exceeds target (0.75+)

### Error Analysis

- **Excellent (≤10 pts):** 65% of predictions
- **Good (11-15 pts):** 22% of predictions
- **Acceptable (16-20 pts):** 10% of predictions
- **Poor (21+ pts):** 3% of predictions

**Conclusion:** ✅ 87% within ≤15 points (target: 80%+)

## Performance Results

- **Mean time:** 132.5s (2m 13s)
- **90th percentile:** 145.0s (2m 25s)
- **95th percentile:** 157.0s (2m 37s)

**Conclusion:** ⚠️ Marginal (target: <2min for 90th percentile)

## Cost Results

- **Mean cost:** $0.187
- **Max cost:** $0.225

**Conclusion:** ✅ Under target ($0.20 mean)

## Quality Results

- **VALIDATED_HIGH:** 60% (6/10)
- **VALIDATED_MEDIUM:** 30% (3/10)
- **PROVISIONAL:** 10% (1/10)
- **REJECTED:** 0% (0/10)

**Conclusion:** ✅ 90% validated (target: 80%+)

## Usability Results (Beta Testers)

- **NPS Score:** 60 (3 promoters, 2 passives, 0 detractors)
- **Average recommendation:** 8.6/10

**Conclusion:** ✅ Exceeds target (NPS ≥ 50)

## Issues Identified

1. **Performance:** 90th percentile at 2m 25s (target: 2m)
   - **Root cause:** Large input files (1500+ words)
   - **Mitigation:** Optimize batch processing in v1.1

2. **Agreeableness detection:** Lowest confidence (mean: 0.68)
   - **Root cause:** Limited social interaction text in essays
   - **Mitigation:** Update data collection guidelines to include more social content

## Recommendations

1. ✅ **Launch Epic 0 as v1.0** - All critical metrics passed
2. ⚠️ **Performance optimization** - Target for v1.1 (Epic 1)
3. ✅ **Data collection guidelines** - Update with more social content prompts
4. ✅ **Proceed to Epic 1** - Foundation validated

## Appendices

- Appendix A: Raw data (accuracy-validation-matrix.csv)
- Appendix B: Performance metrics (performance-metrics.csv)
- Appendix C: Beta tester feedback (beta-feedback.csv)
```

---

## 🚀 Execution Checklist

### Pre-Testing
- [ ] Create testing directory structure
- [ ] Prepare recruitment materials
- [ ] Create informed consent form
- [ ] Set up data collection templates
- [ ] Install InnerLens Lite on testing machine
- [ ] Verify API access (Claude Sonnet 4)

### Recruitment (Days 1-2)
- [ ] Send recruitment messages (target: 15-20 responses)
- [ ] Send informed consent forms
- [ ] Collect self-assessment scores (IPIP-NEO-50)
- [ ] Collect text samples (500-2000 words each)
- [ ] Anonymize and organize data

### Analysis (Days 3-4)
- [ ] Validate all inputs (word count, encoding, language)
- [ ] Run pipeline for all test subjects
- [ ] Log performance metrics (time, cost)
- [ ] Save all outputs (fragments, raw, validated profiles)
- [ ] Extract scores into CSV matrix

### Validation (Days 5-6)
- [ ] Calculate Pearson correlations (per trait + overall)
- [ ] Perform error analysis (absolute error distribution)
- [ ] Check for systematic biases
- [ ] Analyze performance statistics (90th percentile time)
- [ ] Analyze cost statistics (mean cost)
- [ ] Validate quality outcomes distribution
- [ ] Test confidence calibration

### Beta Testing (Days 6-7)
- [ ] Recruit 5 beta testers
- [ ] Send QUICKSTART.md and installation instructions
- [ ] Collect feedback surveys
- [ ] Calculate NPS score
- [ ] Conduct follow-up interviews (optional)

### Reporting (Day 7)
- [ ] Compile final validation report
- [ ] Document issues and recommendations
- [ ] Update Epic 0 status (COMPLETE or needs iteration)
- [ ] Present results to stakeholders
- [ ] Publish results (anonymized) to community

---

## 📁 Directory Structure

```
testing/
├── TESTING-PLAN-EPIC-0.md (this document)
├── templates/
│   ├── recruitment-message.md
│   ├── informed-consent-form.md
│   ├── data-collection-guidelines.md
│   └── beta-tester-survey.md
├── data/
│   ├── subject_001_essay.txt
│   ├── subject_001_selfassessment.csv
│   ├── subject_002_interview.txt
│   ├── subject_002_selfassessment.csv
│   └── ... (10-20 subjects)
├── results/
│   ├── subject_001_fragments.json
│   ├── subject_001_bigfive_profile.yaml
│   ├── subject_002_fragments.json
│   ├── subject_002_bigfive_profile.yaml
│   ├── ... (10-20 results)
│   ├── accuracy-validation-matrix.csv
│   ├── performance-metrics.csv
│   ├── beta-feedback.csv
│   └── EPIC-0-VALIDATION-REPORT.md (final report)
└── scripts/
    ├── calculate_accuracy.py
    ├── analyze_performance.py
    └── generate_report.py
```

---

## 🆘 Contingency Plans

### Issue: Cannot recruit 10 test subjects

**Mitigation:**
- Minimum acceptable: N=5 (lower statistical power but still informative)
- Extend recruitment period (+3-5 days)
- Offer higher incentives ($20 gift card)
- Leverage personal network more aggressively

### Issue: Accuracy <75% overall

**Root cause analysis:**
1. Poor linguistic markers? → Expand markers (Epic 1, Story 1.2)
2. Insufficient text data? → Update data collection guidelines (1500+ words)
3. Wrong framework fit? → Consider domain-specific frameworks

**Decision tree:**
- If 70-74%: ⚠️ **Marginal** → Launch with warning, improve in v1.1
- If 65-69%: ❌ **Needs work** → Delay launch, iterate on markers
- If <65%: ❌ **Major issue** → Reassess approach, consider pivot

### Issue: Performance >3 minutes (95th percentile)

**Mitigation:**
- Implement streaming responses (Epic 1)
- Optimize batch processing
- Use prompt caching (reduces API latency)
- Set hard limit: 2000 words max input

### Issue: High REJECTED rate (>20%)

**Root cause:**
- Text samples lack behavioral content (too factual)

**Mitigation:**
- Update data collection guidelines
- Provide better examples of "good" text
- Ask behavioral interview questions

---

## 📞 Support During Testing

**Questions or issues during testing?**
- **Email:** alan@academialendaria.ai
- **Discord:** AIOS Community
- **GitHub Issues:** Tag with `testing` label

---

**Testing Plan Status:** ✅ Ready to Execute
**Next Step:** Create recruitment materials and start recruiting test subjects

---

© 2025 Academia Lendar[IA] - InnerLens Lite Testing Documentation
