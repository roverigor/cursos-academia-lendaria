# Epic 0 Testing - Quick Reference Guide

**Purpose:** Fast reference for executing InnerLens Lite validation tests
**Audience:** Developers running Epic 0 validation
**Estimated Time:** 7 days (2 recruitment + 2 analysis + 2 validation + 1 reporting)

---

## 📋 Quick Checklist

### Pre-Testing
- [ ] Review [TESTING-PLAN-EPIC-0.md](TESTING-PLAN-EPIC-0.md) - Full methodology
- [ ] Create testing directory structure (see below)
- [ ] Verify API access (Claude Sonnet 4)
- [ ] Install dependencies: `pip install pandas numpy scipy matplotlib seaborn`

### Phase 1: Recruitment (Days 1-2)
- [ ] Send recruitment messages using [templates/recruitment-message.md](templates/recruitment-message.md)
- [ ] Send consent forms using [templates/informed-consent-form.md](templates/informed-consent-form.md)
- [ ] Collect self-assessments (IPIP-NEO-50: https://ipip.ori.org/)
- [ ] Collect text samples using [templates/data-collection-guidelines.md](templates/data-collection-guidelines.md)
- [ ] Target: 10-15 subjects

### Phase 2: Analysis (Days 3-4)
- [ ] Validate inputs (word count, encoding, language)
- [ ] Run pipeline for all subjects
- [ ] Save all outputs (fragments.json, bigfive-raw.yaml, bigfive-profile.yaml)
- [ ] Log performance metrics (time, cost)

### Phase 3: Validation (Days 5-6)
- [ ] Create accuracy matrix CSV
- [ ] Run `calculate_accuracy.py` - Generate accuracy report
- [ ] Run `analyze_performance.py` - Generate performance report
- [ ] Recruit 5 beta testers
- [ ] Collect usability feedback

### Phase 4: Reporting (Day 7)
- [ ] Fill out [EPIC-0-VALIDATION-REPORT-TEMPLATE.md](templates/EPIC-0-VALIDATION-REPORT-TEMPLATE.md)
- [ ] Review results with team
- [ ] Make launch decision (LAUNCH / ITERATE / DELAY)
- [ ] Update Epic 0 status in [epics/EPIC-0-FOUNDATION.md](../epics/EPIC-0-FOUNDATION.md)

---

## 📁 Directory Structure

```bash
# Create testing directories
mkdir -p testing/data
mkdir -p testing/results
mkdir -p testing/results/visualizations
mkdir -p testing/scripts

# Verify structure
tree testing/
```

Expected structure:
```
testing/
├── TESTING-PLAN-EPIC-0.md (strategy doc)
├── QUICK-REFERENCE.md (this file)
├── templates/
│   ├── recruitment-message.md
│   ├── informed-consent-form.md
│   ├── data-collection-guidelines.md
│   └── EPIC-0-VALIDATION-REPORT-TEMPLATE.md
├── data/
│   ├── subject_001_essay.txt
│   ├── subject_001_selfassessment.csv
│   └── ... (10-20 subjects)
├── results/
│   ├── subject_001_fragments.json
│   ├── subject_001_bigfive_profile.yaml
│   ├── accuracy-validation-matrix.csv
│   ├── performance-metrics.csv
│   ├── accuracy-report.md (generated)
│   ├── performance-report.md (generated)
│   ├── EPIC-0-VALIDATION-REPORT.md (final)
│   └── visualizations/
│       ├── correlation_scatterplots.png
│       ├── error_distribution.png
│       └── ... (generated charts)
└── scripts/
    ├── calculate_accuracy.py
    └── analyze_performance.py
```

---

## 🚀 Quick Start Commands

### 1. Recruit Test Subjects

```bash
# Send recruitment email (adapt templates/recruitment-message.md)
# Target: 10-15 responses

# Track in spreadsheet:
# - subject_id, name, email, consent_signed, selfassessment_completed, text_submitted
```

### 2. Collect Data

```bash
# Receive via email:
# - Signed consent forms (PDF or digital signature)
# - Self-assessment scores (CSV or screenshot)
# - Text samples (TXT, PDF, DOCX)

# Organize:
mv downloaded_files/john_essay.txt testing/data/subject_001_essay.txt
mv downloaded_files/john_scores.csv testing/data/subject_001_selfassessment.csv

# Verify word count:
wc -w testing/data/subject_001_essay.txt
# Expected: 500-2000 words
```

### 3. Run Analysis Pipeline

```bash
# For each subject:
cd /path/to/innerlens

# Run complete pipeline
*detect-traits-quick \
  --input testing/data/subject_001_essay.txt \
  --subject-id subject_001

# Log performance (capture output):
START_TIME=$(date +%s)
*detect-traits-quick --input testing/data/subject_001_essay.txt --subject-id subject_001 > testing/results/subject_001_log.txt 2>&1
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
echo "subject_001,1247,$DURATION,0.182" >> testing/results/performance-log.csv

# Save outputs:
cp fragments.json testing/results/subject_001_fragments.json
cp bigfive-raw.yaml testing/results/subject_001_bigfive_raw.yaml
cp bigfive-profile.yaml testing/results/subject_001_bigfive_profile.yaml
```

### 4. Create Accuracy Matrix

```bash
# Create CSV with self-report vs InnerLens scores
# File: testing/results/accuracy-validation-matrix.csv

# Format:
cat > testing/results/accuracy-validation-matrix.csv << 'EOF'
subject_id,source,openness_self,openness_innerlens,conscientiousness_self,conscientiousness_innerlens,extraversion_self,extraversion_innerlens,agreeableness_self,agreeableness_innerlens,neuroticism_self,neuroticism_innerlens,validation_outcome
001,essay,78,82,65,68,42,45,58,55,35,38,VALIDATED_MEDIUM
002,interview,85,88,72,70,55,52,48,50,28,25,VALIDATED_HIGH
...
EOF

# Extract InnerLens scores:
for id in 001 002 003 004 005 006 007 008 009 010; do
    grep "score:" testing/results/subject_${id}_bigfive_profile.yaml | head -n 5
done

# Match with self-report scores from subject_XXX_selfassessment.csv
```

### 5. Create Performance Matrix

```bash
# File: testing/results/performance-metrics.csv

# Format:
cat > testing/results/performance-metrics.csv << 'EOF'
subject_id,word_count,fragment_extraction_seconds,analysis_seconds,validation_seconds,total_seconds,cost_usd
001,1247,29,87,23,139,0.182
002,890,22,68,19,109,0.145
...
EOF

# Extract from pipeline logs (if captured)
# Or manually log during execution
```

### 6. Run Validation Scripts

```bash
cd testing/

# Accuracy validation
python scripts/calculate_accuracy.py \
  --input results/accuracy-validation-matrix.csv \
  --output results/accuracy-report.md \
  --visualize \
  --viz-dir results/visualizations

# Performance analysis
python scripts/analyze_performance.py \
  --input results/performance-metrics.csv \
  --output results/performance-report.md \
  --visualize \
  --viz-dir results/visualizations

# Check exit codes:
echo $?  # 0=pass, 1=marginal, 2=fail, 3=error
```

### 7. Review Results

```bash
# Open reports
cat results/accuracy-report.md
cat results/performance-report.md

# View visualizations
open results/visualizations/correlation_scatterplots.png
open results/visualizations/error_distribution.png
```

### 8. Generate Final Report

```bash
# Copy template
cp templates/EPIC-0-VALIDATION-REPORT-TEMPLATE.md results/EPIC-0-VALIDATION-REPORT.md

# Fill in placeholders:
# - [OVERALL_CORRELATION] → from accuracy-report.md
# - [P90_TIME] → from performance-report.md
# - [MEAN_COST] → from performance-report.md
# - [NPS_SCORE] → from beta tester survey
# - etc.

# Open in editor
code results/EPIC-0-VALIDATION-REPORT.md  # VS Code
# or
vim results/EPIC-0-VALIDATION-REPORT.md
```

---

## 📊 Success Criteria Quick Check

| Metric | Target | Measure | Status |
|--------|--------|---------|--------|
| **Accuracy** | r ≥ 0.75 | Pearson correlation | `grep "Overall (mean)" results/accuracy-report.md` |
| **Performance** | ≤120s (90th percentile) | Processing time | `grep "90th percentile" results/performance-report.md` |
| **Cost** | ≤$0.20 | Mean cost | `grep "Mean cost" results/performance-report.md` |
| **Quality** | ≥80% validated | VALIDATED_HIGH+MEDIUM | Count from results/*.yaml |
| **Usability** | NPS ≥ 50 | Net Promoter Score | Calculate from beta survey |

**Decision Matrix:**

| Condition | Recommendation |
|-----------|---------------|
| All ✅ Pass | **LAUNCH** - Epic 0 validated, proceed to production |
| 3-4 ✅ Pass | **LAUNCH WITH CAUTIONS** - Document limitations |
| 2-3 ✅ Pass | **ITERATE** - Address failures in Epic 1 |
| 0-1 ✅ Pass | **DELAY** - Major improvements needed |

---

## 🆘 Troubleshooting

### Issue: Can't recruit 10 subjects

**Solution:**
- Minimum acceptable: N=5 (reduce statistical power but still informative)
- Extend recruitment (+3-5 days)
- Offer higher incentives ($20 gift card)
- Post to more communities (Reddit, Discord, LinkedIn)

### Issue: Accuracy <75%

**Debug steps:**
1. Check error distribution: Which traits failing?
2. Review failed predictions: Is there a pattern?
3. Examine text samples: Do they lack behavioral content?
4. Check linguistic markers: Are they too narrow?

**Decision:**
- 70-74%: ⚠️ Launch with caution, improve in v1.1
- 65-69%: ❌ Delay, fix markers/algorithm
- <65%: ❌ Major reassessment needed

### Issue: Performance >3 min (95th percentile)

**Debug steps:**
1. Check word count correlation: Is it too high?
2. Identify slow phase: Extraction? Analysis? Validation?
3. Check API latency: Network issues?

**Mitigation:**
- Set hard limit: 2000 words max
- Optimize slow phase (Epic 1)
- Use prompt caching (future)

### Issue: Many REJECTED profiles (>20%)

**Root cause:** Text lacks behavioral content

**Solution:**
- Update data collection guidelines (more examples)
- Ask behavioral questions (vs biographical)
- Request diverse sources (essay + interview + emails)

---

## 📞 Support Contacts

- **Technical Issues:** alan@academialendaria.ai
- **GitHub Issues:** Tag with `testing` label
- **Discord:** AIOS Community

---

## 🔗 Related Documents

**Planning:**
- [TESTING-PLAN-EPIC-0.md](TESTING-PLAN-EPIC-0.md) - Full testing methodology (60+ pages)
- [../epics/EPIC-0-FOUNDATION.md](../epics/EPIC-0-FOUNDATION.md) - Epic 0 specification

**Templates:**
- [templates/recruitment-message.md](templates/recruitment-message.md) - Email/social media recruitment
- [templates/informed-consent-form.md](templates/informed-consent-form.md) - IRB-style consent
- [templates/data-collection-guidelines.md](templates/data-collection-guidelines.md) - Text sample instructions
- [templates/EPIC-0-VALIDATION-REPORT-TEMPLATE.md](templates/EPIC-0-VALIDATION-REPORT-TEMPLATE.md) - Final report template

**Scripts:**
- [scripts/calculate_accuracy.py](scripts/calculate_accuracy.py) - Accuracy validation
- [scripts/analyze_performance.py](scripts/analyze_performance.py) - Performance analysis

**Project Docs:**
- [../README.md](../README.md) - InnerLens Lite overview
- [../QUICKSTART.md](../QUICKSTART.md) - User quick start guide

---

## ⏱️ Time Estimates

| Phase | Task | Time |
|-------|------|------|
| **Day 1-2** | Recruitment | 2 days (parallel to other work) |
| **Day 3** | Run analyses (10 subjects × 2min) | ~30 min |
| **Day 3** | Organize data, create matrices | 2-3 hours |
| **Day 4** | Run validation scripts | 30 min |
| **Day 4-5** | Beta tester recruitment + surveys | 1-2 days |
| **Day 6** | Review results, create visualizations | 2-3 hours |
| **Day 7** | Write final report | 3-4 hours |
| **Total** | **7 days** (16-20 hours active work) |

**Can be parallelized:** Recruitment (Days 1-2) can happen while doing other development work.

---

**Quick Reference Version:** 1.0
**Last Updated:** 2025-01-15
**Status:** ✅ Ready to Use

© 2025 Academia Lendar[IA] - InnerLens Lite Testing Materials
