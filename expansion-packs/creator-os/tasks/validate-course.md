# Task: Validate Course Quality

**Type:** Atomic Task
**Responsibility:** Comprehensive quality validation of generated course
**Duration:** 1-2 minutes

## Purpose

Validate complete course against quality criteria: GPS structure, Didática Lendária, voice fidelity, Bloom's progression, and duration accuracy.

---

## Inputs

- `slug` (required) - Course identifier
- `--verbose` (optional) - Show detailed per-lesson scores

---

## Execution

```bash
python expansion-packs/creator-os/scripts/validate_course.py "$slug" ${verbose:+--verbose}
```

---

## Validation Checks

### 1. GPS Structure Validation
**Target:** ≥95% lessons pass (≥30 points each)

Validates each lesson for:
- Goal clearly stated (10 pts)
- Position explained (10 pts)
- Steps actionable (10 pts)

### 2. Didática Lendária Validation
**Target:** ≥90% lessons pass (≥70 points each)

Validates 7 pedagogical elements:
- Hook/Introduction (15 pts)
- Context (10 pts)
- Core Concept (20 pts)
- Examples (15 pts)
- Practice (15 pts)
- Pitfalls (10 pts)
- Summary (15 pts)

### 3. Voice Fidelity Check
**Target:** ≥85% (custom) or ≥90% (MMOS)

Compares generated lessons against:
- MMOS persona profile (if enabled)
- COURSE-BRIEF voice section (if manual)

Dimensions:
- Vocabulary consistency
- Tone alignment
- Syntax patterns
- Teaching style

### 4. Bloom's Taxonomy Progression
**Target:** Valid progression

Checks:
- Early lessons use lower Bloom's (Remember, Understand)
- Later lessons use higher Bloom's (Apply, Analyze, Evaluate, Create)
- No sudden jumps (max 2 levels per module)

### 5. Duration Accuracy
**Target:** ±25% tolerance

Validates:
- Word count → reading time calculation
- Practice exercise time estimates
- Total course duration vs. COURSE-BRIEF target

### 6. Completeness Check
**Target:** 100%

Verifies:
- All lessons from curriculum exist
- All assessments created
- No missing files
- No broken internal links

---

## Output Report

```
📊 COURSE VALIDATION REPORT
Course: dominando-obsidian (24 lessons)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ GPS STRUCTURE VALIDATION
   Pass rate: 95.8% (23/24 lessons)
   Average score: 28.5/30
   Failed: lesson 2.3 (score: 28/30 - marginal)

✅ DIDÁTICA LENDÁRIA VALIDATION
   Pass rate: 91.7% (22/24 lessons)
   Average score: 82.3/100
   Failed:
     - lesson 1.1 (score: 68/100 - missing practice)
     - lesson 3.5 (score: 69/100 - weak examples)

⚠️  VOICE FIDELITY CHECK
   Score: 88% (target: ≥90% for MMOS)
   Status: MARGINAL PASS
   Issues:
     - 3 lessons use overly formal tone
     - Missing signature phrases in 5 lessons

✅ BLOOM'S TAXONOMY PROGRESSION
   Status: VALID
   Progression: Remember → Understand → Apply → Analyze
   No issues detected

✅ DURATION ACCURACY
   Target: 12 hours
   Actual: 13.2 hours (+10%)
   Status: PASS (within ±25% tolerance)

✅ COMPLETENESS CHECK
   Status: 100% COMPLETE
   All files present, no broken links

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ✅ PASS (with recommendations)

📋 RECOMMENDATIONS:
  1. Regenerate lesson 1.1 (add practice exercise)
  2. Regenerate lesson 3.5 (improve examples)
  3. Review voice consistency in lessons: 2.1, 2.4, 3.3

📊 QUALITY SCORE: 87/100

✅ Course is production-ready with minor improvements recommended.
```

Saved to: `outputs/courses/{slug}/validation-report.md`

---

## Validation Levels

### ✅ PASS
- GPS: ≥95% pass rate
- DL: ≥90% pass rate
- Voice: ≥85% (custom) or ≥90% (MMOS)
- Bloom's: Valid progression
- Duration: ±25%
- Completeness: 100%

### ⚠️ MARGINAL PASS
- GPS: 85-95% pass rate
- DL: 80-90% pass rate
- Voice: 80-85% (custom) or 85-90% (MMOS)
- Issues present but course is usable

### ❌ FAIL
- GPS: <85% pass rate
- DL: <80% pass rate
- Voice: <80%
- Critical issues present
- Regeneration required

---

## Error Handling

### Course Not Found
```
❌ Error: Course 'meu-curso' not found

Available courses:
  - dominando-obsidian
  - marketing-digital
```

### Incomplete Generation
```
❌ Error: Course generation incomplete

Missing:
  - 8 lessons not generated
  - Assessments missing

Complete generation first:
  @course-architect *generate-lessons {slug}
```

---

## Success Criteria

- ✅ All 6 validation checks completed
- ✅ Detailed report generated
- ✅ Issues clearly identified
- ✅ Recommendations actionable
- ✅ Overall pass/fail status clear

---

**Status:** ✅ Ready
