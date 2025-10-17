# InnerLens Epic 0 Validation - Data Collection

This directory contains all data and results for the Epic 0 scientific validation study.

---

## Directory Structure

```
testing/validation/
├── subjects.yaml              # Master data file (all subjects)
├── text_samples/              # Text samples from subjects
│   ├── subject_01.txt
│   ├── subject_02.txt
│   └── ...
├── profiles/                  # InnerLens analysis results
│   ├── subject_01_profile.yaml
│   ├── subject_02_profile.yaml
│   └── ...
└── results/                   # Final validation results
    ├── validation_report.md
    ├── trait_correlations.png
    ├── confidence_calibration.png
    └── ...
```

---

## Workflow

### Step 1: Recruit Subjects (N=10)

Use recruitment templates:
- `testing/templates/recruitment-message.md`

**Inclusion criteria:**
- Age 18+
- Fluent in English
- 500-2000 words of writing available
- Willing to complete IPIP-NEO-120

**Diversity requirements:**
- Gender: Mix (40-60% each)
- Age: 20-60 years
- Education: Mix (high school, college, graduate)
- Culture: At least 3 countries

---

### Step 2: Collect Self-Report Scores

**Instrument:** IPIP-NEO-120
**URL:** https://ipip.ori.org/new_ipip-neo-120-item-inventory.htm

**Instructions for subjects:**
1. Complete 120-item questionnaire (~15 minutes)
2. Record Big Five scores (0-100 per trait)
3. Send scores to researcher

**Add to `subjects.yaml`:**
```yaml
- id: "subject_01"
  demographics:
    age: 28
    gender: "female"
    education: "graduate"
    country: "USA"

  self_report:
    instrument: "IPIP-NEO-120"
    completed_date: "2025-10-20"
    scores:
      openness: 78
      conscientiousness: 65
      extraversion: 52
      agreeableness: 71
      neuroticism: 42
```

---

### Step 3: Collect Text Samples

**Requirements:**
- Minimum: 500 words
- Optimal: 1000-2000 words
- Language: English
- Format: Plain text (.txt) or Markdown (.md)

**Accepted sources:**
- Personal blog posts
- Email exchanges (PII removed)
- Chat transcripts (WhatsApp, Telegram)
- Interview transcripts
- Diary entries
- Social media posts (aggregated)

**Save to:** `testing/validation/text_samples/subject_XX.txt`

**Add to `subjects.yaml`:**
```yaml
  text_sample:
    file: "testing/validation/text_samples/subject_01.txt"
    word_count: 1247
    source_type: "blog"
    language: "en"
```

---

### Step 4: Run InnerLens Analysis

**For each subject:**

```bash
cd /Users/oalanicolas/Documents/Code/mente_lendaria/expansion-packs/innerlens

# Run analysis
# (This would normally be done through AIOS CLI with @psychologist)
# For now, manually track: time, cost, output

# Save results to:
# testing/validation/profiles/subject_XX_profile.yaml
```

**Add to `subjects.yaml`:**
```yaml
  innerlens_results:
    file: "testing/validation/profiles/subject_01_profile.yaml"
    processed_date: "2025-10-20"
    scores:
      openness: 82
      conscientiousness: 68
      extraversion: 48
      agreeableness: 75
      neuroticism: 38
    confidence:
      openness: 0.85
      conscientiousness: 0.78
      extraversion: 0.62
      agreeableness: 0.80
      neuroticism: 0.75
    performance:
      processing_time_seconds: 87
      cost_usd: 0.18
      fragments_extracted: 16
      validation_outcome: "VALIDATED_HIGH"
```

---

### Step 5: Calculate Accuracy

**Once all 10 subjects are complete:**

```bash
cd /Users/oalanicolas/Documents/Code/mente_lendaria/expansion-packs/innerlens

# Run validation script
python testing/scripts/validate_from_yaml.py \
  --subjects testing/validation/subjects.yaml \
  --output-dir testing/validation/results
```

**Output:**
- `results/validation_report.md` - Full markdown report
- `results/trait_correlations.png` - Scatter plots per trait
- `results/confidence_calibration.png` - Confidence vs error plot

**Interpretation:**
- r > 0.75 → ✅ VALIDATED (proceed to Epic 1)
- 0.60 < r < 0.75 → 🟡 PROVISIONAL (improvements recommended)
- r < 0.60 → ❌ FAILED (major improvements needed)

---

## Privacy & Ethics

**Anonymization:**
- Assign subject IDs (subject_01, subject_02, etc.)
- Remove all PII from text samples (names, locations, phone numbers, emails)
- Store demographic info separately (age, gender, education only)

**Consent:**
- All subjects must review and sign informed consent form
- See: `testing/future-production/informed-consent-form.md` (adapted for research)

**Data retention:**
- Raw data stored securely during validation
- After publication: anonymized data may be shared for reproducibility
- Subjects can request data deletion at any time

---

## Current Status

**Subjects enrolled:** 0/10
**Subjects completed:** 0/10
**Validation status:** Not started

**Next steps:**
1. Send recruitment messages (Discord, Reddit, LinkedIn)
2. Screen applicants for inclusion criteria
3. Send consent forms + IPIP-NEO-120 links
4. Collect text samples
5. Run InnerLens analyses
6. Calculate accuracy metrics

---

## Example Subject Entry (Complete)

```yaml
subjects:
  - id: "subject_01"
    demographics:
      age: 28
      gender: "female"
      education: "graduate"
      country: "USA"

    self_report:
      instrument: "IPIP-NEO-120"
      completed_date: "2025-10-20"
      scores:
        openness: 78
        conscientiousness: 65
        extraversion: 52
        agreeableness: 71
        neuroticism: 42

    text_sample:
      file: "testing/validation/text_samples/subject_01.txt"
      word_count: 1247
      source_type: "blog"
      language: "en"

    innerlens_results:
      file: "testing/validation/profiles/subject_01_profile.yaml"
      processed_date: "2025-10-20"
      scores:
        openness: 82
        conscientiousness: 68
        extraversion: 48
        agreeableness: 75
        neuroticism: 38
      confidence:
        openness: 0.85
        conscientiousness: 0.78
        extraversion: 0.62
        agreeableness: 0.80
        neuroticism: 0.75
      performance:
        processing_time_seconds: 87
        cost_usd: 0.18
        fragments_extracted: 16
        validation_outcome: "VALIDATED_HIGH"
```

---

**Last Updated:** 2025-10-16
**Owner:** Dev Lead
**Target Completion:** 2-3 weeks
