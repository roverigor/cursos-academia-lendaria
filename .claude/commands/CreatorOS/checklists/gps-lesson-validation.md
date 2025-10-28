# GPS Lesson Validation Checklist

**Checklist Version:** 1.0-GPS
**Created:** 2025-10-17
**Purpose:** Validate that generated lessons follow GPS Pedagogical Framework
**Used By:** Story 3.12 (Validation & Quality Checks)

---

## 🎯 Overview

This checklist ensures every generated lesson follows the **GPS Framework** (Goal-Position-Steps) and includes required **Semiotic Elements** (analogies, diagrams, reflective questions) for maximum learning effectiveness.

**Validation Levels:**
- 🟢 **PASS:** All critical criteria met (≥90% compliance)
- 🟡 **WARNING:** Some criteria missing (70-89% compliance) - acceptable but needs review
- 🔴 **FAIL:** Critical criteria missing (<70% compliance) - lesson needs regeneration

---

## 📋 Validation Criteria

### Section 1: G - GOAL (Destino) - CRITICAL

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 1.1 | **Clear promise in opening** | Promise stated in first 60 seconds (≤150 words) | CRITICAL |
| 1.2 | **Specific, tangible outcomes** | Uses "you will be able to..." with action verbs | CRITICAL |
| 1.3 | **Minimum 2 learning objectives** | At least 2 specific outcomes listed | HIGH |
| 1.4 | **Objectives use Bloom's Taxonomy** | Verbs: create, design, analyze, apply, understand, remember | MEDIUM |
| 1.5 | **Motivation stated (why)** | Explains why lesson matters / value to student | HIGH |
| 1.6 | **Concrete example given** | Shows what they'll achieve (not abstract) | MEDIUM |

**Scoring:**
- CRITICAL missing: 🔴 FAIL
- HIGH missing: 🟡 WARNING
- MEDIUM missing: Note only

---

### Section 2: P - POSITION (Origem) - CRITICAL

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 2.1 | **Acknowledges different starting points** | Mentions beginner AND experienced paths | CRITICAL |
| 2.2 | **Validates student struggles** | Addresses at least 1 common pain point/concern | HIGH |
| 2.3 | **Shows empathy** | Uses phrases like "I know that...", "If you're feeling..." | MEDIUM |
| 2.4 | **Offers multiple learning paths** | Presents 2-3 ways to approach the content | HIGH |
| 2.5 | **Appears early** | Position section within first 150 words | CRITICAL |
| 2.6 | **Instructor voice consistent** | If persona defined, matches tone/style | HIGH |

**Scoring:**
- CRITICAL missing: 🔴 FAIL
- HIGH missing: 🟡 WARNING

---

### Section 3: S - STEPS (Rota) - CRITICAL

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 3.1 | **Starts with "why" before "what"** | Context/importance before technical steps | HIGH |
| 3.2 | **Clear, sequential steps** | Numbered or clearly ordered instructions | CRITICAL |
| 3.3 | **Step-by-step instructions** | Each step actionable (student knows what to DO) | CRITICAL |
| 3.4 | **Logical flow** | Each step builds on previous (no gaps) | HIGH |
| 3.5 | **Immediate practice exercise** | Hands-on task within 5 min of content | HIGH |
| 3.6 | **Exercise is specific** | Not vague ("try this"), but concrete ("create 3 notes about X") | MEDIUM |

**Scoring:**
- CRITICAL missing: 🔴 FAIL
- HIGH missing: 🟡 WARNING

---

### Section 4: Semiotic Elements - REQUIRED

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 4.1 | **Minimum 1 analogy** | Concept explained via familiar comparison | CRITICAL |
| 4.2 | **Analogy quality** | Uses universal experience (not niche reference) | HIGH |
| 4.3 | **Maximum 3 analogies** | Not overloaded (too many = confusion) | MEDIUM |
| 4.4 | **Minimum 1 diagram/visual** | Described or included (flowchart, screenshot, etc.) | CRITICAL |
| 4.5 | **Visual is relevant** | Diagram clarifies concept (not decorative) | HIGH |
| 4.6 | **2-4 reflective questions** | Questions that make student pause and think | CRITICAL |
| 4.7 | **Questions are reflective** | Not quiz questions, but "how does this apply to YOU?" | HIGH |
| 4.8 | **Visual summary** | Bullet-point recap (not paragraph) | MEDIUM |

**Scoring:**
- CRITICAL missing: 🔴 FAIL (regenerate with semiotic elements)
- HIGH missing: 🟡 WARNING

---

### Section 5: Voice Fidelity (If Instructor Persona Defined)

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 5.1 | **Signature greeting** | Uses instructor's opening (e.g., "Fala, lendário!") | HIGH |
| 5.2 | **Recurring phrases** | Includes 2-3 instructor catchphrases | MEDIUM |
| 5.3 | **Tone consistency** | Matches warm/formal, casual/professional style | HIGH |
| 5.4 | **Teaching style** | Matches theory-first vs practice-first approach | MEDIUM |
| 5.5 | **Fidelity score** | If calculated: ≥85% for transcripts, ≥90% for MMOS | HIGH |

**Scoring:**
- If NO persona defined: SKIP this section
- If persona defined and HIGH missing: 🟡 WARNING
- If fidelity <75%: 🔴 FAIL (voice doesn't match instructor)

---

### Section 6: Content Quality (General)

| # | Criterion | Pass Condition | Weight |
|---|-----------|----------------|--------|
| 6.1 | **Length appropriate** | 500-2500 words (depends on duration target) | MEDIUM |
| 6.2 | **No jargon without explanation** | Technical terms defined on first use | HIGH |
| 6.3 | **Accessible language** | Readable by target audience level | MEDIUM |
| 6.4 | **Markdown valid** | No syntax errors, proper formatting | MEDIUM |
| 6.5 | **Links functional** | Internal/external links resolve | LOW |
| 6.6 | **Conclusion present** | Clear next steps or summary at end | MEDIUM |

**Scoring:**
- HIGH missing: 🟡 WARNING

---

## 🔍 Validation Workflow

### Automated Validation (Script)
```python
def validate_gps_lesson(lesson_path: str) -> ValidationReport:
    lesson = load_markdown(lesson_path)

    # Section 1: Goal
    goal_score = check_goal_section(lesson)
    # - Has promise in first 150 words? (regex search)
    # - Has "you will be able to" or similar?
    # - Has Bloom's verbs? (search against verb list)

    # Section 2: Position
    position_score = check_position_section(lesson)
    # - Has empathy phrases? ("I know", "if you're", etc.)
    # - Mentions different levels? ("beginner", "experienced")

    # Section 3: Steps
    steps_score = check_steps_section(lesson)
    # - Has numbered/ordered steps?
    # - Has practice exercise keywords? ("try this", "now it's your turn")

    # Section 4: Semiotics
    semiotic_score = check_semiotic_elements(lesson)
    # - Count analogies: regex for "like", "similar to", "é como"
    # - Count visuals: search for [DIAGRAM], ![image], etc.
    # - Count reflective questions: search for "?" + reflection keywords

    # Section 5: Voice (if persona loaded)
    if instructor_persona:
        voice_score = check_voice_fidelity(lesson, persona)
        # - Search for signature phrases
        # - Tone analysis (AI call)

    # Calculate overall score
    total_score = weighted_average([
        (goal_score, 0.25),
        (position_score, 0.25),
        (steps_score, 0.20),
        (semiotic_score, 0.20),
        (voice_score, 0.10)
    ])

    if total_score >= 0.90:
        status = "PASS"
    elif total_score >= 0.70:
        status = "WARNING"
    else:
        status = "FAIL"

    return ValidationReport(
        status=status,
        total_score=total_score,
        goal=goal_score,
        position=position_score,
        steps=steps_score,
        semiotics=semiotic_score,
        voice=voice_score,
        issues=[list of specific failures],
        recommendations=[list of improvements]
    )
```

### Manual Review (If Automated = WARNING or FAIL)
1. Read first 2 paragraphs: Is Goal clear?
2. Check for empathy language: Is Position present?
3. Scan for numbered steps: Are Steps actionable?
4. Find analogies: Count them (need ≥1)
5. Look for diagrams: Count placeholders/images (need ≥1)
6. Search for "?": Count reflective questions (need 2-4)
7. If instructor persona: Does it "sound like" them?

---

## 📊 Validation Report Template

```markdown
# GPS Validation Report

**Lesson:** {lesson_id} - {lesson_title}
**Validated:** {timestamp}
**Validator:** Automated Script v1.0 + Manual Review

---

## Overall Status: {🟢 PASS | 🟡 WARNING | 🔴 FAIL}

**Total Score:** {score}/100

---

## Section Scores

### 1. Goal (Destino): {score}/100 {🟢/🟡/🔴}
- ✅ Clear promise in opening
- ✅ Specific outcomes (2+)
- ⚠️ Motivation could be stronger (vague "important" instead of concrete benefit)

### 2. Position (Origem): {score}/100 {🟢/🟡/🔴}
- ✅ Acknowledges different levels
- ✅ Shows empathy with student struggles
- ✅ Offers multiple paths

### 3. Steps (Rota): {score}/100 {🟢/🟡/🔴}
- ✅ Sequential steps present
- ✅ Practice exercise included
- ❌ MISSING: "Why before what" (starts with technical steps immediately)

### 4. Semiotic Elements: {score}/100 {🟢/🟡/🔴}
- ✅ 2 analogies found
- ✅ 1 diagram placeholder
- ❌ MISSING: Reflective questions (found 0, need 2+)

### 5. Voice Fidelity: {score}/100 {🟢/🟡/🔴}
- ✅ Signature greeting present ("Fala, lendário!")
- ✅ Tone matches (warm, conversational)
- ⚠️ Only 1 recurring phrase (need 2-3)

### 6. Content Quality: {score}/100 {🟢/🟡/🔴}
- ✅ Length: 1247 words (appropriate for 20-min lesson)
- ✅ Markdown valid
- ✅ Accessible language

---

## Issues Found (3)

1. **CRITICAL:** Missing reflective questions (Section 4.6)
   - **Impact:** Students won't pause to internalize concepts
   - **Fix:** Add 2-3 questions like "Where in your work could you apply this?"

2. **HIGH:** Starts with "what" before "why" (Section 3.1)
   - **Impact:** Less motivation, feels like dry instruction
   - **Fix:** Add context paragraph before Step 1

3. **MEDIUM:** Voice fidelity could be higher (Section 5.2)
   - **Impact:** Doesn't fully sound like Adriano
   - **Fix:** Add phrases "Olha só..." and "Tá?" in 2-3 places

---

## Recommendations

1. **Immediate (for PASS):**
   - Add 2 reflective questions (one after Step 2, one at end)
   - Add "why this matters" paragraph before steps

2. **Nice to Have:**
   - Strengthen motivation in Goal section (quantify benefit)
   - Add 1 more voice phrase for higher fidelity

---

## Regeneration Needed? {YES | NO}

{If FAIL: YES - Critical GPS elements missing}
{If WARNING: NO - Acceptable with minor manual edits}
{If PASS: NO - Ready to publish}

---

**Report Generated:** Automated + Manual Review
**Next Action:** {Regenerate | Manual edit | Approve}
```

---

## 🎯 Usage in Story 3.12

### Integration Points

1. **After lesson generation (Story 3.9):**
   - Run automated GPS validation script
   - Generate report for each lesson
   - Flag lessons with WARNING or FAIL

2. **Manual review queue:**
   - Show flagged lessons to human reviewer
   - Provide checklist for quick manual validation
   - Allow approve/reject/regenerate decision

3. **Batch validation:**
   - Run `*validate-course {slug}` after all lessons generated
   - Aggregate report showing GPS compliance across course
   - Identify patterns (e.g., "All Module 3 lessons missing analogies")

4. **CI/CD integration:**
   - Block course publish if >20% lessons are FAIL
   - Warn if >40% lessons are WARNING
   - Auto-approve if 100% PASS

---

## 📚 GPS Compliance Targets

**By Course Quality Tier:**

| Tier | GPS PASS Rate | GPS WARNING Rate | GPS FAIL Rate |
|------|---------------|------------------|---------------|
| **Premium** (paid courses) | ≥95% | ≤5% | 0% |
| **Standard** (free courses) | ≥85% | ≤15% | 0% |
| **Beta/Draft** | ≥70% | ≤25% | ≤5% |

**Voice Fidelity Targets:**
- MMOS-based: ≥90% (high bar, persona is detailed)
- Transcript-based: ≥85% (good, but transcripts vary)
- Custom persona: ≥80% (acceptable, less training data)
- Generic (no persona): N/A (skip voice validation)

---

## 🔧 Tooling

### Scripts Required
1. **`validate-gps-lesson.py`** - Single lesson validation
2. **`validate-gps-course.py`** - Batch validation for full course
3. **`gps-report-generator.py`** - Format validation results

### Dependencies
- Python 3.9+
- Markdown parser (python-markdown)
- Regex for pattern matching
- Optional: AI model for voice tone analysis (expensive, manual review is fine)

---

**Checklist Maintained By:** CreatorOS Quality Assurance
**Last Updated:** 2025-10-17
**Version:** 1.0-GPS
