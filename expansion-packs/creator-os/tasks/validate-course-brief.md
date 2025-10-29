---
task-id: validate-course-brief
name: Validate Course Brief Quality
type: atomic
responsibility: Pre-generation validation of COURSE-BRIEF.md
duration: 30-60 seconds
agent: course-architect

token-estimation:
  input: 5000              # Read COURSE-BRIEF.md
  processing: 3000         # Validation logic
  output: 2000             # Validation report
  total_min: 8000
  total_max: 12000
  factors:
    - "Brief completeness analysis"
    - "ICP quality scoring"
    - "Learning objectives validation"
    - "Contradiction detection"
  alternatives:
    subagent_savings: "N/A (atomic task)"

user-confirmation-required: false
---

# Task: Validate Course Brief Quality

**Type:** Atomic Task
**Responsibility:** Validate COURSE-BRIEF.md BEFORE market research or curriculum generation
**Duration:** 30-60 seconds

---

## Purpose

**CRITICAL PRE-FLIGHT CHECK:** Validate course brief quality BEFORE spending 50K-500K tokens on research/generation. Prevents wasting resources on poorly-defined courses.

**Economics:**
- ✅ Validates brief: ~10K tokens (~$0.10)
- ❌ Skip validation, bad brief: Waste 450K tokens (~$4.50)
- **ROI:** 4,500% cost savings per caught error

---

## When to Execute

**MANDATORY checkpoints:**
1. **Greenfield Pure:** After user fills COURSE-BRIEF.md, BEFORE market-research
2. **Pre-Created Brief:** After hybrid mode detection, BEFORE auto-continue
3. **Manual request:** User runs `*validate-brief {slug}`

**DO NOT execute:**
- During brownfield (different validation logic)
- After curriculum generation (too late!)

---

## Inputs

- `slug` (required) - Course identifier
- `--strict` (optional) - Fail on warnings (not just critical issues)
- `--verbose` (optional) - Show detailed field-by-field analysis

---

## Validation Checks

### 1. Completeness Check
**Target:** 100% of critical fields filled

**Validates:**
- ✅ Section 1: Basic Info (title, duration, category)
- ✅ Section 2: ICP complete (demographics + psychographics + pains + transformation)
- ✅ Section 3: Learning objectives (≥5 objectives defined)
- ✅ Section 3: Preliminary outline (≥3 modules with lessons)
- ✅ Section 4: Voice/personality defined (MMOS or custom)
- ✅ Section 6: Commercial model specified

**Scoring:**
```
completeness_score = (filled_fields / required_fields) * 100
```

**Thresholds:**
- ✅ PASS: ≥95% (1-2 optional fields missing)
- ⚠️ WARNING: 85-95% (some required fields incomplete)
- ❌ FAIL: <85% (critical gaps present)

---

### 2. ICP Quality Score
**Target:** ≥80/100

**Validates:**

**Demographics (15 pts):**
- Age range specified (5 pts)
- Professional context defined (5 pts)
- Experience level clear (5 pts)

**Psychographics (25 pts):**
- Current moment described (10 pts) - "Where they are in life right now"
- Emotional state identified (10 pts) - "How they feel"
- Top values selected (5 pts) - "What they prioritize"

**Pain Points (30 pts):**
- Superficial pain defined (5 pts) - "What they say"
- Real pain identified (10 pts) - "What they actually want"
- Deep pain articulated (10 pts) - "What's beneath it all"
- Top 5 specific frustrations (5 pts) - "Concrete problems"

**Transformation (30 pts):**
- Current state described (10 pts) - "Before" snapshot
- Desired state defined (10 pts) - "After" vision
- Measurable KPIs specified (10 pts) - "How we measure success"

**Scoring:**
```
icp_score = demographics + psychographics + pains + transformation
```

**Thresholds:**
- ✅ EXCELLENT: ≥90/100
- ✅ GOOD: 80-89/100
- ⚠️ MARGINAL: 70-79/100 (usable but weak)
- ❌ POOR: <70/100 (regeneration needed)

---

### 3. Learning Objectives Quality
**Target:** ≥80/100

**Validates SMART criteria:**

**Specific (20 pts):**
- Objectives use concrete verbs (not "understand", "know")
- Each objective focuses on ONE outcome
- Clear scope (not too broad)

**Measurable (25 pts):**
- Observable outcomes ("create X", "implement Y")
- Success criteria implicit or explicit
- Bloom's Taxonomy verbs used (create, analyze, apply, evaluate)

**Achievable (15 pts):**
- Realistic within course duration
- Prerequisites support objectives
- Complexity matches ICP level

**Relevant (20 pts):**
- Align with ICP transformation goals
- Address stated pain points
- Support commercial positioning

**Time-bound (20 pts):**
- Course duration realistic for objectives
- Progression logical (simple → complex)
- Minimum 5 objectives defined

**Example:**
```
❌ BAD: "Understand AI" (vague, not measurable)
✅ GOOD: "Create a functional AI clone that responds to questions in Portuguese with 85%+ voice fidelity"
```

**Scoring:**
```
objectives_score = (smart_criteria_met / total_criteria) * 100
```

**Thresholds:**
- ✅ EXCELLENT: ≥90/100
- ✅ GOOD: 80-89/100
- ⚠️ MARGINAL: 70-79/100
- ❌ POOR: <70/100

---

### 4. Framework Coherence Check
**Target:** No major misalignments

**Validates:**

**ICP ↔ Duration:**
- ❌ ICP says "busy professionals" but course is 40h
- ❌ ICP says "deep dive mastery" but course is 2h
- ✅ "Busy founders" + "3h microlearning" = coherent

**ICP ↔ Framework:**
- ❌ "Complete beginners" + "Mastery Learning" = mismatch
- ❌ "Executives" + "Gamification heavy" = questionable
- ✅ "Busy professionals" + "Microlearning" = aligned

**Prerequisites ↔ Objectives:**
- ❌ No prerequisites but objectives require advanced knowledge
- ❌ Advanced prerequisites but teaching basics
- ✅ Prerequisites enable objectives

**Theory/Practice ↔ ICP:**
- ❌ "Hands-on practitioners" + "70% theory" = mismatch
- ❌ "Academic researchers" + "90% practice" = questionable
- ✅ "Developers" + "80% practice" = aligned

**Issues detected:**
```yaml
critical_issues:
  - type: duration_mismatch
    severity: critical
    description: "ICP values 'speed' but course is 20h (too long)"
    recommendation: "Reduce to 8-12h or change ICP"

warnings:
  - type: framework_mismatch
    severity: warning
    description: "Microlearning selected but lessons are 30-45 min"
    recommendation: "Reduce to 5-10 min per lesson"
```

---

### 5. Voice Clarity Check
**Target:** Clear voice definition (MMOS or custom)

**Validates:**

**If MMOS enabled:**
- ✅ Mind slug specified
- ✅ Mind exists in outputs/minds/{slug}/
- ✅ System prompt available
- ❌ Mind not found → CRITICAL ERROR

**If Custom voice:**
- ✅ Tone defined (3+ characteristics)
- ✅ Personality traits listed (3-5)
- ✅ Signature phrases provided (3-5)
- ✅ "Never does/says" boundaries set (2-3)
- ⚠️ Generic descriptions ("friendly, professional") → WARNING

**If Generic/Neutral:**
- ⚠️ No voice customization → Lower fidelity expected

**Scoring:**
```
If MMOS: voice_clarity = mind_found ? 100 : 0
If Custom: voice_clarity = (traits + phrases + boundaries) / 3 * 100
If Generic: voice_clarity = 50 (acceptable but basic)
```

---

### 6. Outline Quality Check
**Target:** Logical structure with clear progression

**Validates:**

**Modular Structure (20 pts):**
- ✅ 3-5 modules defined (sweet spot)
- ⚠️ 1-2 modules (too shallow)
- ⚠️ 8+ modules (too fragmented)

**Lesson Count (20 pts):**
- ✅ 8-25 lessons total (standard course)
- ⚠️ <5 lessons (too short)
- ⚠️ >40 lessons (overwhelming)

**Progression (30 pts):**
- ✅ Module 1: Foundations/Setup
- ✅ Module 2-N: Building blocks (logical dependencies)
- ✅ Module N: Advanced/Integration
- ❌ Modules out of order (teaches advanced before basics)

**Duration Consistency (30 pts):**
- ✅ Total duration = sum of lesson durations (±10%)
- ⚠️ Total duration ≠ sum (math doesn't add up)
- ✅ Lesson durations consistent (not 5 min + 60 min randomly)

**Objectives per Lesson:**
- ✅ Each lesson has 1-3 learning objectives
- ⚠️ Lessons missing objectives
- ⚠️ Objectives too vague

---

### 7. Contradiction Detection
**Target:** Zero critical contradictions

**Detects:**

**ICP Contradictions:**
- ❌ "Busy professionals" + "40h course" = MISMATCH
- ❌ "Values speed" + "Mastery Learning framework" = MISMATCH
- ❌ "Beginners" + "Prerequisites: Advanced Python" = MISMATCH

**Promise vs. Reality:**
- ❌ Title promises "in 3 hours" but course is 12h
- ❌ "No coding required" but lessons teach programming
- ❌ "Complete beginners" but first lesson assumes knowledge

**Commercial Contradictions:**
- ❌ "Lead magnet (free)" + "Price: R$997" = CONFUSING
- ❌ "High-ticket R$2,997" + "3h mini-course" = VALUE MISMATCH

**Technical Contradictions:**
- ❌ "No prerequisites" + "Requires React knowledge"
- ❌ "100% hands-on" + "70% theory" = CONTRADICTION

**Output:**
```yaml
contradictions:
  critical:
    - field_1: "ICP: Busy professionals (values speed)"
      field_2: "Duration: 40 hours"
      conflict: "Duration too long for busy ICP"
      severity: critical
      fix: "Reduce to 8-12h or re-define ICP"

  warnings:
    - field_1: "Framework: Microlearning"
      field_2: "Lesson duration: 30-45 min"
      conflict: "Microlearning typically 5-10 min"
      severity: warning
      fix: "Reduce lesson duration or change framework"
```

---

## Output Report

### Example Output (PASS):

```
📊 COURSE BRIEF VALIDATION REPORT
Course: clone-ia-express
Validated: 2025-10-28 14:32

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ COMPLETENESS CHECK
   Score: 98% (64/65 fields filled)
   Status: PASS
   Missing: Section 7.3 - Constraints (optional)

✅ ICP QUALITY SCORE
   Score: 92/100 (EXCELLENT)
   Demographics: 15/15 ✅
   Psychographics: 23/25 ✅
   Pain Points: 28/30 ✅
   Transformation: 26/30 ✅

✅ LEARNING OBJECTIVES QUALITY
   Score: 88/100 (GOOD)
   Objectives defined: 8
   SMART compliance: 88%
   Bloom's verbs used: 7/8 ✅
   Issues:
     - Objective 3: Could be more measurable

✅ FRAMEWORK COHERENCE
   Status: ALIGNED
   ICP ↔ Duration: ✅ "Busy professionals" + "3h" = coherent
   ICP ↔ Framework: ✅ "Microlearning" matches ICP needs
   Prerequisites ↔ Objectives: ✅ Aligned

✅ VOICE CLARITY
   Score: 95/100
   Mode: MMOS (alan_nicolas_v2)
   Mind found: ✅
   System prompt: ✅ Available
   Fidelity target: 90%

✅ OUTLINE QUALITY
   Score: 85/100 (GOOD)
   Modules: 3 ✅
   Lessons: 9 ✅
   Progression: Logical ✅
   Duration math: 3.2h (target: 3h) ✅ Within 10%

✅ CONTRADICTION DETECTION
   Critical issues: 0 ✅
   Warnings: 1
     ⚠️ Section 3.4: "20% theory" but Section 5 says "content-heavy"
        Fix: Clarify content format expectations

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ✅ PASS

📊 QUALITY SCORE: 91/100 (EXCELLENT)

✅ SAFE TO PROCEED with market research and curriculum generation.

📋 RECOMMENDATIONS:
  1. Clarify Objective 3 to be more measurable
  2. Resolve content format expectation (theory vs. heavy)

💾 Report saved: outputs/courses/clone-ia-express/validation-brief-report.md
```

---

### Example Output (FAIL):

```
📊 COURSE BRIEF VALIDATION REPORT
Course: marketing-digital-basico
Validated: 2025-10-28 14:35

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ COMPLETENESS CHECK
   Score: 62% (40/65 fields filled)
   Status: FAIL
   Missing critical fields:
     - Section 2.2: Pain points (superficial, real, deep) - EMPTY
     - Section 2.3: Transformation (current state, desired state) - EMPTY
     - Section 3.2: Learning objectives - ONLY 2 defined (need ≥5)
     - Section 3.3: Preliminary outline - NO MODULES DEFINED

❌ ICP QUALITY SCORE
   Score: 45/100 (POOR)
   Demographics: 12/15 ⚠️
   Psychographics: 5/25 ❌ (missing moment, emotional state)
   Pain Points: 8/30 ❌ (only superficial pain defined)
   Transformation: 20/30 ⚠️ (KPIs missing)

❌ LEARNING OBJECTIVES QUALITY
   Score: 30/100 (POOR)
   Objectives defined: 2 (need ≥5)
   SMART compliance: 40%
   Issues:
     - Objective 1: "Understand marketing" (too vague, not measurable)
     - Objective 2: "Learn social media" (not specific, no verb)

⚠️  FRAMEWORK COHERENCE
   Status: MISALIGNED
   Issues:
     ❌ ICP says "busy entrepreneurs" but duration is 25h (TOO LONG)
     ❌ Prerequisites say "none" but objectives require "advanced analytics"
     ⚠️ Framework "Mastery Learning" doesn't match "speed-focused" ICP

❌ VOICE CLARITY
   Score: 30/100
   Mode: Custom
   Issues:
     - Tone: Generic ("professional, friendly") - not distinctive
     - Personality traits: Only 1 defined (need 3-5)
     - Signature phrases: NONE provided
     - Boundaries: NONE defined

⚠️  OUTLINE QUALITY
   Score: 0/100 (NO OUTLINE PROVIDED)
   Status: CRITICAL - Cannot generate curriculum without outline

❌ CONTRADICTION DETECTION
   Critical issues: 3
     🚨 ICP "busy entrepreneurs" + Duration "25h" = SEVERE MISMATCH
        Fix: Reduce to 8-12h or re-define ICP

     🚨 Prerequisites "None" + Objective "Implement advanced analytics" = CONTRADICTION
        Fix: Add prerequisites or simplify objectives

     🚨 Title "Marketing Digital Básico" + Objectives "Advanced strategies" = MISMATCH
        Fix: Align complexity throughout

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ❌ FAIL

📊 QUALITY SCORE: 42/100 (POOR)

🚨 CANNOT PROCEED - Critical issues must be resolved before generation.

📋 CRITICAL ACTIONS REQUIRED:
  1. ✅ Complete Section 2.2 (Pain Points) - ALL 3 LEVELS
  2. ✅ Complete Section 2.3 (Transformation) with KPIs
  3. ✅ Define at least 5 SMART learning objectives (Section 3.2)
  4. ✅ Create preliminary outline with modules and lessons (Section 3.3)
  5. ✅ Resolve ICP ↔ Duration contradiction (reduce to 8-12h)
  6. ✅ Resolve Prerequisites ↔ Objectives mismatch
  7. ✅ Define custom voice characteristics (Section 4)

💡 RECOMMENDATIONS:
  - Review COURSE-BRIEF.md template comments for guidance
  - Reference example courses in expansion-packs/creator-os/examples/
  - Consider using MMOS persona instead of custom voice
  - Reduce scope to 8-12h for "busy entrepreneurs" ICP

⏱️  ESTIMATED TIME TO FIX: 45-90 minutes

When fixed, re-run: @course-architect *validate-brief marketing-digital-basico
```

---

## Validation Levels

### ✅ PASS (Quality Score ≥ 80)
**Criteria:**
- Completeness: ≥95%
- ICP Quality: ≥80/100
- Objectives Quality: ≥80/100
- Framework: Coherent (no critical issues)
- Voice: Clearly defined
- Outline: Logical structure
- Contradictions: 0 critical issues

**Action:** ✅ Proceed to market-research

---

### ⚠️ MARGINAL PASS (Quality Score 70-79)
**Criteria:**
- Completeness: 85-95%
- ICP Quality: 70-79/100
- Objectives Quality: 70-79/100
- Framework: Minor misalignments
- Contradictions: 1-2 warnings (no critical)

**Action:**
- ⚠️ Can proceed but quality may suffer
- Recommend fixing warnings first
- User decides: fix now or accept lower quality

---

### ❌ FAIL (Quality Score < 70)
**Criteria:**
- Completeness: <85%
- ICP Quality: <70/100
- Objectives Quality: <70/100
- Critical contradictions present
- Missing critical sections

**Action:**
- 🚨 BLOCK workflow progression
- Provide actionable fix list
- Estimate time to fix
- Re-validate after fixes

---

## Execution

### Script Location
```bash
expansion-packs/creator-os/scripts/validate_course_brief.py
```

### Command
```bash
python expansion-packs/creator-os/scripts/validate_course_brief.py "$slug" ${strict:+--strict} ${verbose:+--verbose}
```

### Exit Codes
- `0` - PASS (quality ≥80)
- `1` - FAIL (quality <70)
- `2` - MARGINAL PASS (quality 70-79, only if not --strict)
- `3` - Error (file not found, parsing error)

---

## Integration with Workflow

### Greenfield Workflow Integration

**BEFORE (current):**
```
User fills COURSE-BRIEF.md
  ↓
market-research (50K tokens)
  ↓
❌ Realizes brief was bad (450K tokens wasted)
```

**AFTER (proposed):**
```
User fills COURSE-BRIEF.md
  ↓
🔍 validate-course-brief (10K tokens)
  ↓
❌ FAIL - Shows issues + recommendations
  ↓
User fixes (5-30 min)
  ↓
🔍 validate-course-brief (10K tokens)
  ↓
✅ PASS - Proceed to market-research
```

**Savings:** 430K tokens per bad brief caught = **$4.30**

---

## Error Handling

### Course Not Found
```
❌ Error: Course 'meu-curso' not found

Expected location: outputs/courses/meu-curso/COURSE-BRIEF.md

Available courses:
  - clone-ia-express
  - marketing-digital

Create course first: @course-architect *new meu-curso
```

### Brief Empty/Template
```
❌ Error: COURSE-BRIEF.md appears to be the empty template

Completeness: 5% (only auto-filled fields present)

Action required:
1. Open: outputs/courses/meu-curso/COURSE-BRIEF.md
2. Fill all 8 sections (estimated time: 45-90 minutes)
3. Re-run validation

See template instructions in COURSE-BRIEF.md for guidance.
```

### Parsing Error
```
❌ Error: Cannot parse COURSE-BRIEF.md

Line 127: Invalid YAML frontmatter
  Expected: mmos_persona:
  Found: mmos_persona

Fix:
1. Check YAML syntax in frontmatter (lines 1-21)
2. Validate with: yamllint outputs/courses/meu-curso/COURSE-BRIEF.md
3. Re-run validation
```

---

## Success Criteria

- ✅ Validation completes in <60 seconds
- ✅ Detailed report generated with actionable items
- ✅ Quality score calculated (0-100)
- ✅ Critical issues blocked (cannot proceed)
- ✅ Warnings surfaced but optional
- ✅ Contradictions detected automatically
- ✅ Clear pass/fail decision
- ✅ Recommendations specific and actionable
- ✅ Report saved to course folder

---

## Notes

**Why this matters:**
- Prevents 50K-500K token waste on bad briefs
- Catches issues in 10K tokens vs. 450K tokens
- **4,500% ROI** on validation investment
- Improves course quality by catching design flaws early
- Reduces iteration cycles (fix once, not 3x)

**When to skip:**
- Never! This is MANDATORY pre-flight check
- Exception: Brownfield mode (uses different validation)

---

**Status:** ✅ Ready (needs script implementation)
**Created:** 2025-10-28
**Version:** 1.0
