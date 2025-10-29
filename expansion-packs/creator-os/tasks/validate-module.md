---
task-id: validate-module
name: Validate Module Quality
type: atomic
responsibility: Validate completed module BEFORE generating next module
duration: 20-30 seconds
agent: course-architect

token-estimation:
  input: 3000              # Read module lessons
  processing: 2000         # Validation checks
  output: 1000             # Report
  total_min: 5000
  total_max: 8000
  factors:
    - "Number of lessons in module (3-8 typical)"
    - "GPS/DL validation per lesson"
    - "Bloom's progression analysis"
    - "Duration accuracy check"
  alternatives:
    subagent_savings: "N/A (atomic task)"

user-confirmation-required: false
---

# Task: Validate Module Quality

**Type:** Atomic Task
**Responsibility:** Validate completed module quality BEFORE proceeding to next module
**Duration:** 20-30 seconds per module

---

## Purpose

**INCREMENTAL QA:** Catch quality issues at module level, not course level.

**Prevents:**
- Generating 5 modules before discovering Module 1 had issues
- Waiting until end to find systemic problems (bad pedagogy, weak voice, wrong complexity)
- Regenerating entire course (300K tokens) vs. regenerating 1 module (60K tokens)

**Economics:**
- ✅ Validates module: ~5K tokens (~$0.05)
- ❌ Skip validation, bad module: Regenerate 3 more modules + initial bad one = 240K tokens wasted (~$2.40)
- **ROI:** 4,800% cost savings per bad module caught

---

## When to Execute

**MANDATORY checkpoint:**
1. **After generate-lessons completes a module:** BEFORE starting next module
2. **Manual request:** User runs `*validate-module {slug} {module_id}`

**DO NOT execute:**
- Before module is complete (lessons still generating)
- On incomplete modules (missing lessons)

---

## Inputs

- `slug` (required) - Course identifier
- `module_id` (required) - Module number (1, 2, 3, etc.)
- `--verbose` (optional) - Show per-lesson breakdown

---

## Validation Checks

### 1. Lesson Completeness
**Target:** 100% of expected lessons exist

**Validates:**
- ✅ All lessons defined in curriculum.yaml exist in `/lessons/`
- ✅ No missing lesson files
- ✅ All lessons have content (not empty files)

**Example:**
```yaml
curriculum.yaml says:
  Module 1:
    - 1.1-introduction.md
    - 1.2-setup.md
    - 1.3-first-steps.md

Checks:
  ✅ outputs/courses/{slug}/lessons/1.1-introduction.md exists
  ✅ outputs/courses/{slug}/lessons/1.2-setup.md exists
  ✅ outputs/courses/{slug}/lessons/1.3-first-steps.md exists
```

**Scoring:**
- All present: ✅ COMPLETE (100%)
- 1-2 missing: ⚠️ INCOMPLETE
- 3+ missing: ❌ CRITICAL MISS

---

### 2. GPS Structure Quality
**Target:** ≥90% of lessons pass (≥30 pts each)

**Validates per lesson:**
- **Goal** (10 pts): Learning objective clear and specific
- **Position** (10 pts): Why this matters explained (context, relevance)
- **Steps** (10 pts): Actionable steps to achieve goal

**Scoring:**
```
gps_score = (lessons_passing / total_lessons) * 100
```

**Thresholds:**
- ✅ PASS: ≥90% pass (e.g., 3/3 or 7/8 lessons)
- ⚠️ MARGINAL: 80-89%
- ❌ FAIL: <80%

**Output per lesson:**
```
Lesson 1.1: ✅ GPS 32/30
Lesson 1.2: ✅ GPS 28/30
Lesson 1.3: ❌ GPS 22/30 (weak Steps section)
```

---

### 3. Didática Lendária Quality
**Target:** ≥85% of lessons pass (≥70 pts each)

**Validates 7 pedagogical elements per lesson:**
1. **Hook/Introduction** (15 pts) - Engaging opening
2. **Context** (10 pts) - Sets the stage
3. **Core Concept** (20 pts) - Main teaching content
4. **Examples** (15 pts) - Concrete illustrations
5. **Practice** (15 pts) - Hands-on exercise
6. **Pitfalls** (10 pts) - Common mistakes to avoid
7. **Summary** (15 pts) - Recap and next steps

**Scoring:**
```
dl_score = (lessons_passing / total_lessons) * 100
```

**Thresholds:**
- ✅ PASS: ≥85%
- ⚠️ MARGINAL: 75-84%
- ❌ FAIL: <75%

---

### 4. Bloom's Taxonomy Progression
**Target:** Logical progression (no jumps >2 levels)

**Validates:**
- ✅ Early lessons use lower Bloom's (Remember, Understand, Apply)
- ✅ Later lessons can use higher Bloom's (Analyze, Evaluate, Create)
- ❌ No sudden jumps (e.g., Lesson 1 = Remember, Lesson 2 = Create)

**Bloom's Levels:**
1. Remember (recall facts)
2. Understand (explain concepts)
3. Apply (use in new situations)
4. Analyze (break down, examine)
5. Evaluate (judge, critique)
6. Create (build, design)

**Example GOOD Progression:**
```
Module 1: Foundations
  1.1 - Remember: "What is AI?"
  1.2 - Understand: "How clones work"
  1.3 - Apply: "Create your first clone"
```

**Example BAD Progression:**
```
Module 1:
  1.1 - Remember: "What is AI?"
  1.2 - Create: "Build advanced multi-agent system" ← JUMP!
```

**Scoring:**
- Valid progression: ✅ LOGICAL
- 1 jump detected: ⚠️ MINOR ISSUE
- 2+ jumps: ❌ ILLOGICAL

---

### 5. Duration Accuracy
**Target:** ±20% tolerance vs. curriculum estimate

**Validates:**
- Calculate actual duration from word count + exercises
- Compare to curriculum.yaml estimate
- Flag if mismatch >20%

**Formula:**
```
reading_time = word_count / 200 words_per_minute
exercise_time = num_exercises * 5 minutes_avg
actual_duration = reading_time + exercise_time

variance = abs(actual_duration - estimated_duration) / estimated_duration
```

**Thresholds:**
- ✅ PASS: ≤20% variance
- ⚠️ WARNING: 20-35% variance
- ❌ FAIL: >35% variance

**Example:**
```
Curriculum says: Module 1 = 45 min
Calculated: Module 1 = 52 min
Variance: 15.5% ✅ PASS
```

---

### 6. Voice Consistency (if MMOS enabled)
**Target:** ≥85% fidelity across all lessons in module

**Validates:**
- All lessons use consistent voice/tone
- Signature phrases present
- Teaching style matches MMOS persona or custom profile

**Scoring:**
```
voice_consistency = avg(fidelity_scores_per_lesson)
```

**Thresholds:**
- ✅ EXCELLENT: ≥90%
- ✅ GOOD: 85-89%
- ⚠️ MARGINAL: 80-84%
- ❌ POOR: <80%

**Example:**
```
Lesson 1.1: Fidelity 91%
Lesson 1.2: Fidelity 88%
Lesson 1.3: Fidelity 92%
Average: 90.3% ✅ EXCELLENT
```

---

### 7. Module Cohesion
**Target:** Lessons build on each other logically

**Validates:**
- ✅ Each lesson references or builds on previous
- ✅ Dependencies respected (Lesson 1.3 can assume 1.1-1.2 knowledge)
- ✅ Module has clear narrative arc (beginning → middle → end)
- ❌ Lessons feel disconnected or random order

**Scoring:**
- Strong cohesion: ✅ COHESIVE
- Minor gaps: ⚠️ ACCEPTABLE
- Disconnected: ❌ FRAGMENTED

---

## Output Report

### Example Output (PASS):

```
📊 MODULE VALIDATION REPORT
Course: clone-ia-express
Module: 1 - Fundamentos (3 lessons)
Validated: 2025-10-28 15:30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ LESSON COMPLETENESS
   Status: ✅ COMPLETE (3/3 lessons present)
   Missing: None

✅ GPS STRUCTURE QUALITY
   Pass rate: 100% (3/3 lessons ≥30 pts)
   Average score: 29.3/30
   Per-lesson:
     1.1: 30/30 ✅
     1.2: 28/30 ✅
     1.3: 30/30 ✅

✅ DIDÁTICA LENDÁRIA QUALITY
   Pass rate: 100% (3/3 lessons ≥70 pts)
   Average score: 84.7/100
   Per-lesson:
     1.1: 88/100 ✅
     1.2: 78/100 ✅
     1.3: 88/100 ✅

✅ BLOOM'S TAXONOMY PROGRESSION
   Status: ✅ LOGICAL
   Progression: Remember → Understand → Apply
   No jumps detected

✅ DURATION ACCURACY
   Estimated (curriculum): 45 min
   Calculated (actual): 48 min
   Variance: 6.7% ✅ PASS (within ±20%)

✅ VOICE CONSISTENCY
   Average fidelity: 90.3% ✅ EXCELLENT
   Per-lesson:
     1.1: 91% ✅
     1.2: 88% ✅
     1.3: 92% ✅

✅ MODULE COHESION
   Status: ✅ COHESIVE
   Each lesson builds on previous
   Clear narrative arc detected

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ✅ PASS

📊 MODULE QUALITY SCORE: 94/100 (EXCELLENT)

✅ SAFE TO PROCEED to Module 2

💾 Report saved: outputs/courses/clone-ia-express/validation-module-1-report.md
```

---

### Example Output (FAIL):

```
📊 MODULE VALIDATION REPORT
Course: marketing-digital
Module: 2 - Estratégias Avançadas (5 lessons)
Validated: 2025-10-28 15:45

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ LESSON COMPLETENESS
   Status: ⚠️ INCOMPLETE (4/5 lessons present)
   Missing:
     - 2.3-instagram-reels-strategy.md ← MISSING FILE

❌ GPS STRUCTURE QUALITY
   Pass rate: 60% (3/5 lessons ≥30 pts)
   Average score: 26.8/30
   Per-lesson:
     2.1: 30/30 ✅
     2.2: 28/30 ✅
     2.3: MISSING ❌
     2.4: 22/30 ❌ (weak Goal section)
     2.5: 24/30 ❌ (Steps not actionable)

❌ DIDÁTICA LENDÁRIA QUALITY
   Pass rate: 40% (2/5 lessons ≥70 pts)
   Average score: 64.2/100
   Per-lesson:
     2.1: 82/100 ✅
     2.2: 76/100 ✅
     2.3: MISSING ❌
     2.4: 58/100 ❌ (missing Practice section)
     2.5: 65/100 ❌ (weak Examples)

⚠️  BLOOM'S TAXONOMY PROGRESSION
   Status: ⚠️ MINOR ISSUE
   Jump detected: Lesson 2.1 (Understand) → 2.4 (Evaluate)
   Recommendation: Add intermediate lesson at Apply level

⚠️  DURATION ACCURACY
   Estimated (curriculum): 60 min
   Calculated (actual): 42 min
   Variance: 30% ⚠️ WARNING (lessons too short)

⚠️  VOICE CONSISTENCY
   Average fidelity: 78% ⚠️ MARGINAL
   Per-lesson:
     2.1: 85% ✅
     2.2: 82% ✅
     2.3: MISSING
     2.4: 72% ❌ (too formal, missing personality)
     2.5: 71% ❌ (generic corporate tone)

❌ MODULE COHESION
   Status: ❌ FRAGMENTED
   Issues:
     - Lesson 2.4 doesn't reference 2.1-2.3
     - No clear narrative arc
     - Lessons feel like standalone articles

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ❌ FAIL

📊 MODULE QUALITY SCORE: 58/100 (POOR)

🚨 CANNOT PROCEED to Module 3 - Critical issues must be resolved.

📋 CRITICAL ACTIONS REQUIRED:
  1. ✅ Generate missing lesson: 2.3-instagram-reels-strategy.md
  2. ✅ Regenerate lesson 2.4 (fix GPS Goal, add Practice)
  3. ✅ Regenerate lesson 2.5 (improve Examples, fix voice)
  4. ✅ Review cohesion: Add cross-references between lessons
  5. ✅ Increase content depth (duration 30% below target)

💡 RECOMMENDATIONS:
  - Before regenerating, review COURSE-BRIEF voice section
  - Ensure MMOS persona is loaded correctly
  - Consider adding intermediate lesson between 2.1 and 2.4

⏱️  ESTIMATED FIX TIME: 30-60 minutes (regenerate 3 lessons)

When fixed, re-run: @course-architect *validate-module marketing-digital 2
```

---

## Validation Levels

### ✅ PASS (Quality Score ≥ 80)
**Criteria:**
- Lesson Completeness: 100%
- GPS Pass Rate: ≥90%
- DL Pass Rate: ≥85%
- Bloom's Progression: Logical (≤1 minor jump)
- Duration Variance: ≤20%
- Voice Consistency: ≥85% (if MMOS)
- Module Cohesion: Cohesive

**Action:** ✅ Proceed to next module

---

### ⚠️ MARGINAL PASS (Quality Score 70-79)
**Criteria:**
- GPS Pass Rate: 80-89%
- DL Pass Rate: 75-84%
- Minor issues present but module usable

**Action:**
- ⚠️ Can proceed but recommend fixing
- User decides: fix now or continue (accept lower quality)

---

### ❌ FAIL (Quality Score < 70)
**Criteria:**
- Lesson Completeness: <100%
- GPS Pass Rate: <80%
- DL Pass Rate: <75%
- Critical issues present (missing lessons, illogical progression, poor voice)

**Action:**
- 🚨 BLOCK workflow progression
- Must regenerate failed lessons
- Re-validate after fixes
- DO NOT proceed to next module

---

## Execution

### Script Location
```bash
expansion-packs/creator-os/scripts/validate_module.py
```

### Command
```bash
python expansion-packs/creator-os/scripts/validate_module.py "$slug" "$module_id" ${verbose:+--verbose}
```

### Exit Codes
- `0` - PASS (quality ≥80)
- `1` - FAIL (quality <70)
- `2` - MARGINAL PASS (quality 70-79)
- `3` - Error (module not found, missing files)

---

## Integration with Workflow

### Current Workflow (No Module Validation):
```
Generate Module 1 (60K tokens)
  ↓
Generate Module 2 (60K tokens)
  ↓
Generate Module 3 (60K tokens)
  ↓
❌ Discover Module 1 had issues
  ↓
💸 Regenerate all 3 modules = 180K tokens wasted
```

### With Module Validation:
```
Generate Module 1 (60K tokens)
  ↓
🔍 validate-module 1 (5K tokens)
  ❌ FAIL - GPS weak in 2/3 lessons
  ↓
Regenerate 2 lessons (20K tokens)
  ↓
🔍 validate-module 1 (5K tokens)
  ✅ PASS
  ↓
Generate Module 2 (60K tokens)
  ↓
🔍 validate-module 2 (5K tokens)
  ✅ PASS
  ↓
Continue...
  ↓
💰 SAVINGS: 150K tokens (~$1.50) by catching issues early
```

---

## Error Handling

### Module Not Found
```
❌ Error: Module 2 not found in course 'my-course'

Curriculum has 3 modules:
  - Module 1: ✅ Complete (3 lessons)
  - Module 2: ❌ Not generated yet
  - Module 3: ❌ Not generated yet

Generate module first: @course-architect *generate-lessons my-course
```

### Lessons Missing
```
❌ Error: Module 2 incomplete

Expected (from curriculum.yaml):
  - 2.1-introduction.md
  - 2.2-core-concepts.md
  - 2.3-practice.md

Found:
  - 2.1-introduction.md ✅
  - 2.2-core-concepts.md ✅
  - 2.3-practice.md ❌ MISSING

Complete lesson generation before validation.
```

---

## Success Criteria

- ✅ Validation completes in <30 seconds per module
- ✅ Per-lesson quality scores calculated
- ✅ Module-level aggregate scores provided
- ✅ Clear pass/fail with actionable fixes
- ✅ Detailed report saved to course folder
- ✅ Early issue detection (before generating more modules)

---

## Notes

**Why this matters:**
- Catches module issues incrementally (not at end)
- Prevents cascading failures (bad Module 1 pattern repeated in 2-5)
- Reduces regeneration cost (1 module vs. entire course)
- **Economics:** 5K validation saves up to 180K regeneration = 3,600% ROI

**When to skip:**
- Never! This is MANDATORY per-module check
- Exception: Single-module courses (use validate-course instead)

---

**Status:** ✅ Ready (needs script implementation)
**Created:** 2025-10-28
**Version:** 1.0
