# Epic 0 Validation Plan - Big Five Accuracy Test

**Test ID:** EPIC-0-VAL-001
**Date Created:** 2025-10-16
**Status:** 🟡 Ready to Execute
**Owner:** Dev Lead
**Duration:** 2-3 weeks

---

## Objective

Validate InnerLens Big Five analysis accuracy against self-reported personality scores from validated psychometric instruments.

**Success Criteria:**
- ✅ Recruit 10 test subjects (diverse demographics)
- ✅ Pearson correlation r > 0.75 per trait (InnerLens vs self-report)
- ✅ Average confidence calibration: subjects with high confidence have lower error
- ✅ Performance: <2 minutes per analysis (1000 words)
- ✅ Cost: <$0.25 per analysis

---

## Scientific Method

### 1. Hypothesis

**H1:** InnerLens Big Five scores correlate r > 0.75 with self-reported scores from validated instruments (IPIP-NEO-120)

**H0 (Null):** InnerLens scores do not correlate significantly (r < 0.50) with self-reports

### 2. Variables

**Independent Variables:**
- Text input (500-2000 words per subject)
- Source type (blog, email, chat, interview)
- Subject demographics (age, gender, education, culture)

**Dependent Variables:**
- Big Five scores (0-100 per trait)
- Confidence scores (0.0-1.0 per trait)
- Accuracy: |InnerLens - SelfReport| per trait

**Control Variables:**
- Same psychometric instrument (IPIP-NEO-120)
- Same InnerLens version (v1.1.0)
- Same Claude model (Sonnet 4)
- English language only (first phase)

### 3. Sample Design

**Target Sample Size:** N=10 (minimum for pilot validation)

**Inclusion Criteria:**
- ✅ Age 18+ years
- ✅ Fluent in English (written)
- ✅ Willing to complete IPIP-NEO-120 (120 questions, ~15 min)
- ✅ Can provide 500-2000 words of natural writing
- ✅ Consents to anonymous data use for research

**Exclusion Criteria:**
- ❌ Non-English primary language (for Phase 1)
- ❌ Professional writers (may not reflect natural personality expression)
- ❌ AI-generated text samples

**Diversity Requirements:**
- Gender: 40-60% each (M/F/Non-binary)
- Age: 20-60 years (at least 2 subjects in each decade)
- Education: Mix of high school, college, graduate
- Culture: At least 3 different countries (English-speaking)

---

## Methodology

### Phase 1: Recruitment (Week 1)

**Recruitment Channels:**
1. AIOS community (Discord, GitHub)
2. Personal network (LinkedIn, Twitter)
3. Reddit (r/psychology, r/personalityinventory)
4. University research boards (IRB-exempt, informational use)

**Recruitment Message:** (see `testing/templates/recruitment-message.md`)

**Screening Process:**
1. Review demographic fit
2. Confirm writing sample availability (500-2000 words)
3. Send consent form (see `testing/future-production/informed-consent-form.md` - adapted for research)
4. Send IPIP-NEO-120 link

### Phase 2: Data Collection (Week 2)

**Per Subject (2-3 days):**

**Step 1: Self-Report Personality**
- Instrument: IPIP-NEO-120 (https://ipip.ori.org/new_ipip-neo-120-item-inventory.htm)
- Format: 120 items, 5-point Likert scale
- Time: ~15 minutes
- Output: Big Five scores (0-100 per trait)

**Step 2: Text Sample Submission**
- Minimum: 500 words
- Optimal: 1000-2000 words
- Sources accepted:
  - Personal blog posts
  - Email exchanges (with PII removed)
  - Chat transcripts (WhatsApp, Telegram)
  - Interview transcripts
  - Diary entries
  - Social media posts (aggregated)
- Format: Plain text (.txt) or Markdown (.md)
- Anonymization: Remove names, locations, specific dates

**Step 3: InnerLens Analysis**
- Run: `*detect-traits-quick --input subject_XX.txt`
- Capture: `bigfive-profile.yaml` output
- Record: Processing time, cost, confidence scores

### Phase 3: Analysis (Week 3)

**Statistical Analysis:**

1. **Pearson Correlation** (per trait):
   ```
   r_openness = corr(InnerLens_O, SelfReport_O)
   r_conscientiousness = corr(InnerLens_C, SelfReport_C)
   r_extraversion = corr(InnerLens_E, SelfReport_E)
   r_agreeableness = corr(InnerLens_A, SelfReport_A)
   r_neuroticism = corr(InnerLens_N, SelfReport_N)
   ```
   **Target:** r > 0.75 per trait (strong correlation)
   **Acceptable:** r > 0.60 per trait (moderate correlation)

2. **Mean Absolute Error** (per trait):
   ```
   MAE_trait = mean(|InnerLens - SelfReport|)
   ```
   **Target:** MAE < 15 points (out of 100)

3. **Confidence Calibration**:
   ```
   Plot: Confidence (0.0-1.0) vs Absolute Error (0-100)
   Target: Negative correlation (r < -0.40)
   Interpretation: Higher confidence → Lower error
   ```

4. **Performance Metrics**:
   - Median processing time
   - Median cost per analysis
   - Success rate (no failures)

**Script:** `testing/scripts/calculate_accuracy.py` (see below)

---

## Data Structure

### Subject Data File: `testing/validation/subjects.yaml`

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
      file: "testing/validation/subject_01.txt"
      word_count: 1247
      source_type: "blog"
      language: "en"

    innerlens_results:
      file: "testing/validation/subject_01_profile.yaml"
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

  # ... 9 more subjects
```

---

## Analysis Scripts

### Script 1: `testing/scripts/calculate_accuracy.py`

```python
#!/usr/bin/env python3
"""
Calculate accuracy metrics for InnerLens Big Five validation.

Usage:
    python calculate_accuracy.py --subjects testing/validation/subjects.yaml
"""

import yaml
import numpy as np
from scipy.stats import pearsonr
import matplotlib.pyplot as plt
from pathlib import Path

def load_subjects(filepath):
    """Load subject data from YAML file."""
    with open(filepath, 'r') as f:
        data = yaml.safe_load(f)
    return data['subjects']

def calculate_correlations(subjects):
    """Calculate Pearson r for each Big Five trait."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    results = {}

    for trait in traits:
        self_report = [s['self_report']['scores'][trait] for s in subjects]
        innerlens = [s['innerlens_results']['scores'][trait] for s in subjects]

        r, p = pearsonr(self_report, innerlens)
        mae = np.mean(np.abs(np.array(self_report) - np.array(innerlens)))

        results[trait] = {
            'correlation': r,
            'p_value': p,
            'mae': mae,
            'self_report': self_report,
            'innerlens': innerlens
        }

    return results

def calculate_confidence_calibration(subjects):
    """Calculate confidence vs error correlation."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    all_confidences = []
    all_errors = []

    for subject in subjects:
        for trait in traits:
            confidence = subject['innerlens_results']['confidence'][trait]
            error = abs(
                subject['self_report']['scores'][trait] -
                subject['innerlens_results']['scores'][trait]
            )
            all_confidences.append(confidence)
            all_errors.append(error)

    r, p = pearsonr(all_confidences, all_errors)

    return {
        'correlation': r,
        'p_value': p,
        'confidences': all_confidences,
        'errors': all_errors
    }

def plot_results(correlation_results, calibration_results, output_dir):
    """Generate visualization plots."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    # Plot 1: Scatter plots per trait
    fig, axes = plt.subplots(2, 3, figsize=(15, 10))
    fig.suptitle('InnerLens vs Self-Report Big Five Scores', fontsize=16)

    for idx, trait in enumerate(traits):
        ax = axes[idx // 3, idx % 3]
        data = correlation_results[trait]

        ax.scatter(data['self_report'], data['innerlens'], alpha=0.7)
        ax.plot([0, 100], [0, 100], 'r--', label='Perfect correlation')
        ax.set_xlabel('Self-Report Score')
        ax.set_ylabel('InnerLens Score')
        ax.set_title(f'{trait.capitalize()}\nr={data["correlation"]:.2f}, MAE={data["mae"]:.1f}')
        ax.legend()
        ax.grid(True, alpha=0.3)

    # Remove extra subplot
    fig.delaxes(axes[1, 2])

    plt.tight_layout()
    plt.savefig(output_dir / 'trait_correlations.png', dpi=300)
    print(f"✅ Saved: {output_dir / 'trait_correlations.png'}")

    # Plot 2: Confidence calibration
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.scatter(calibration_results['confidences'], calibration_results['errors'], alpha=0.6)
    ax.set_xlabel('Confidence Score (0.0-1.0)')
    ax.set_ylabel('Absolute Error (points)')
    ax.set_title(f'Confidence Calibration\nr={calibration_results["correlation"]:.2f}')
    ax.grid(True, alpha=0.3)

    # Add trend line
    z = np.polyfit(calibration_results['confidences'], calibration_results['errors'], 1)
    p = np.poly1d(z)
    ax.plot(sorted(calibration_results['confidences']),
            p(sorted(calibration_results['confidences'])),
            "r--", alpha=0.8, label='Trend')
    ax.legend()

    plt.tight_layout()
    plt.savefig(output_dir / 'confidence_calibration.png', dpi=300)
    print(f"✅ Saved: {output_dir / 'confidence_calibration.png'}")

def generate_report(correlation_results, calibration_results, performance_stats, output_file):
    """Generate markdown validation report."""

    report = f"""# InnerLens Epic 0 Validation Report

**Test ID:** EPIC-0-VAL-001
**Date:** {datetime.now().strftime('%Y-%m-%d')}
**Sample Size:** N={len(subjects)}
**Instrument:** IPIP-NEO-120
**InnerLens Version:** v1.1.0

---

## Executive Summary

"""

    # Add correlation results
    report += "### Accuracy Results (Pearson Correlation)\n\n"
    report += "| Trait | Correlation (r) | p-value | MAE | Status |\n"
    report += "|-------|----------------|---------|-----|--------|\n"

    for trait, data in correlation_results.items():
        status = "✅ PASS" if data['correlation'] > 0.75 else "🟡 ACCEPTABLE" if data['correlation'] > 0.60 else "❌ FAIL"
        report += f"| {trait.capitalize()} | {data['correlation']:.3f} | {data['p_value']:.4f} | {data['mae']:.1f} | {status} |\n"

    # Add overall stats
    mean_r = np.mean([data['correlation'] for data in correlation_results.values()])
    report += f"\n**Overall Mean Correlation:** r = {mean_r:.3f}\n\n"

    # Add confidence calibration
    report += "### Confidence Calibration\n\n"
    report += f"**Correlation (Confidence ↔ Error):** r = {calibration_results['correlation']:.3f}\n"
    report += f"**p-value:** {calibration_results['p_value']:.4f}\n\n"

    if calibration_results['correlation'] < -0.40:
        report += "✅ **Well-calibrated:** Higher confidence predicts lower error\n\n"
    else:
        report += "⚠️ **Needs improvement:** Confidence not well-calibrated\n\n"

    # Add performance stats
    report += "### Performance Metrics\n\n"
    report += f"- **Median Processing Time:** {performance_stats['median_time']:.1f}s\n"
    report += f"- **Median Cost:** ${performance_stats['median_cost']:.3f}\n"
    report += f"- **Success Rate:** {performance_stats['success_rate']:.1%}\n\n"

    # Add conclusion
    report += "## Conclusion\n\n"

    if mean_r > 0.75:
        report += "✅ **VALIDATED:** InnerLens Big Five analysis meets target accuracy (r > 0.75)\n\n"
    elif mean_r > 0.60:
        report += "🟡 **PROVISIONAL:** InnerLens shows moderate accuracy (r > 0.60), improvements recommended\n\n"
    else:
        report += "❌ **FAILED:** InnerLens does not meet minimum accuracy threshold (r < 0.60)\n\n"

    # Save report
    with open(output_file, 'w') as f:
        f.write(report)

    print(f"✅ Saved: {output_file}")

def main():
    import argparse
    from datetime import datetime

    parser = argparse.ArgumentParser(description='Calculate InnerLens accuracy')
    parser.add_argument('--subjects', required=True, help='Path to subjects.yaml')
    parser.add_argument('--output-dir', default='testing/validation/results', help='Output directory')
    args = parser.parse_args()

    # Load data
    subjects = load_subjects(args.subjects)
    print(f"Loaded {len(subjects)} subjects")

    # Calculate metrics
    correlation_results = calculate_correlations(subjects)
    calibration_results = calculate_confidence_calibration(subjects)

    # Calculate performance stats
    times = [s['innerlens_results']['performance']['processing_time_seconds'] for s in subjects]
    costs = [s['innerlens_results']['performance']['cost_usd'] for s in subjects]
    success_rate = len([s for s in subjects if s['innerlens_results']['performance']['validation_outcome'] in ['VALIDATED_HIGH', 'VALIDATED_MEDIUM']]) / len(subjects)

    performance_stats = {
        'median_time': np.median(times),
        'median_cost': np.median(costs),
        'success_rate': success_rate
    }

    # Create output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    # Generate plots
    plot_results(correlation_results, calibration_results, output_dir)

    # Generate report
    generate_report(correlation_results, calibration_results, performance_stats, output_dir / 'validation_report.md')

    print("\n✅ Validation analysis complete!")

if __name__ == '__main__':
    main()
```

---

## Timeline

### Week 1: Recruitment & Setup
- **Day 1:** Finalize recruitment materials
- **Day 2-3:** Post recruitment messages (Discord, Reddit, LinkedIn)
- **Day 4-5:** Screen applicants, send consent forms
- **Day 6-7:** Collect IPIP-NEO-120 self-reports

### Week 2: Data Collection
- **Day 1-7:** Collect text samples from subjects (rolling)
- **Day 1-7:** Run InnerLens analysis as samples arrive
- **Day 7:** All 10 subjects complete

### Week 3: Analysis & Reporting
- **Day 1:** Run `calculate_accuracy.py` script
- **Day 2:** Generate visualizations
- **Day 3:** Write validation report
- **Day 4:** Present findings, decide on threshold adjustments
- **Day 5:** Update Epic 0 status

---

## Success Criteria (Detailed)

| Metric | Target | Acceptable | Fail |
|--------|--------|------------|------|
| **Openness** | r > 0.75 | r > 0.60 | r < 0.60 |
| **Conscientiousness** | r > 0.75 | r > 0.60 | r < 0.60 |
| **Extraversion** | r > 0.75 | r > 0.60 | r < 0.60 |
| **Agreeableness** | r > 0.75 | r > 0.60 | r < 0.60 |
| **Neuroticism** | r > 0.75 | r > 0.60 | r < 0.60 |
| **Overall Mean** | r > 0.75 | r > 0.65 | r < 0.65 |
| **Confidence Calibration** | r < -0.40 | r < -0.20 | r > 0.00 |
| **Processing Time** | < 120s | < 180s | > 180s |
| **Cost** | < $0.20 | < $0.30 | > $0.30 |

---

## Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| **Low recruitment (<10 subjects)** | Medium | High | Start early, offer incentive ($10 gift card?), use multiple channels |
| **Text samples too short (<500 words)** | Medium | Medium | Clear guidance in recruitment, offer to accept multiple sources |
| **Low accuracy (r < 0.60)** | Low | High | If happens: adjust thresholds, improve markers, more training data |
| **Poor confidence calibration** | Medium | Medium | Implement Story 1.5 (confidence improvements) |
| **Language barrier** | Low | Low | English-only for Phase 1 |

---

## Next Steps After Validation

**If VALIDATED (r > 0.75):**
- ✅ Mark Epic 0 as COMPLETE
- ✅ Proceed to Epic 1 (HEXACO, multimodal)
- ✅ Publish results (blog post, GitHub README)

**If ACCEPTABLE (0.60 < r < 0.75):**
- 🟡 Implement Story 1.2 (expanded linguistic markers)
- 🟡 Re-test with N=20 subjects
- 🟡 Consider adjusting detection thresholds

**If FAILED (r < 0.60):**
- ❌ Re-evaluate MIU extraction quality
- ❌ Improve Big Five marker database
- ❌ Consider switching to supervised learning approach
- ❌ Recruit psychology domain expert for review

---

**Plan Status:** 🟡 Ready to Execute
**Owner:** Dev Lead
**Created:** 2025-10-16
**Next Review:** After Week 1 (recruitment check-in)
