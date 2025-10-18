# Story 3.12: Comprehensive Validation & Quality Checks

**Story ID:** STORY-3.12
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P1 (High)
**Complexity:** M (Medium)
**Story Points:** 8
**Status:** 📋 Planning
**Owner:** Course Architect Agent
**Sprint:** Phase 4 - Quality

---

## User Story

**As a** course creator
**I want** the system to validate generated content for quality and completeness
**So that** I catch issues early before publishing

---

## Business Value

### Problem
Generated courses may have quality issues:
- **Structural:** Missing lessons, incorrect numbering, broken links
- **Content:** Too short, missing objectives, incomplete GPS structure
- **Pedagogical:** No analogies, missing reflective questions, poor DL score
- **Voice:** Doesn't match instructor persona (generic AI voice)

**Current Pain:**
- Manual review takes 2-4 hours per course
- Easy to miss structural issues (gaps in numbering)
- No objective quality metric (subjective "looks good?")
- Issues discovered during student pilot (too late!)

### Solution Value
**Automated Quality Validation:**
- Structural checks (files, numbering, required sections)
- Content completeness checks (minimum length, all sections present)
- Pedagogical validation (GPS structure, DL scoring)
- Voice fidelity checks (MMOS benchmark comparison)

**Impact:**
- **Time Saved:** 1-2 hours manual review (50% reduction)
- **Quality:** Objective scoring (70/100 threshold)
- **Confidence:** "System validated it, ready to publish"
- **Prevention:** Catch issues before students see them

### Success Metrics
- ✅ 95%+ of generated courses pass structural validation
- ✅ 80%+ of lessons score ≥70/100 on DL rubric
- ✅ Voice fidelity ≥85% (when MMOS used)
- ✅ Validation runs in <30s (fast feedback)

---

## Acceptance Criteria

### AC 1: Validation Command

**Task:** `*validate-course {slug}`

```bash
*validate-course dominando-obsidian
```

**Runs 4 Validation Categories:**
1. Structural Validation
2. Content Completeness
3. Pedagogical Quality (GPS + DL)
4. Voice Fidelity (optional, if MMOS)

**Validation:**
- [ ] Command takes course slug as argument
- [ ] Validates all 4 categories
- [ ] Returns pass/fail per category
- [ ] Generates detailed validation report

---

### AC 2: Structural Validation

**Checks:**
```python
def validate_structure(course_slug):
    """
    Validate course folder structure and file integrity
    """
    course_dir = f"outputs/courses/{course_slug}/"
    issues = []

    # Check 1: Required files exist
    required_files = [
        f"{course_dir}/COURSE-BRIEF.md",
        f"{course_dir}/curriculum.yaml",
        f"{course_dir}/course-outline.md"
    ]

    for file_path in required_files:
        if not os.path.exists(file_path):
            issues.append(f"Missing required file: {file_path}")

    # Check 2: Lessons directory exists
    lessons_dir = f"{course_dir}/lessons/"
    if not os.path.exists(lessons_dir):
        issues.append(f"Lessons directory not found: {lessons_dir}")
        return {"valid": False, "issues": issues}

    # Check 3: All curriculum lessons exist as files
    curriculum = load_yaml(f"{course_dir}/curriculum.yaml")
    expected_lessons = flatten_curriculum_to_lesson_ids(curriculum)

    for lesson_id in expected_lessons:
        lesson_files = glob(f"{lessons_dir}/{lesson_id}-*.md")

        if not lesson_files:
            issues.append(f"Missing lesson file: {lesson_id}")

    # Check 4: No gaps in lesson numbering
    numbering_issues = validate_lesson_numbering(expected_lessons)
    issues.extend(numbering_issues)

    # Check 5: File naming convention correct
    for lesson_file in glob(f"{lessons_dir}/*.md"):
        if not is_valid_lesson_filename(lesson_file):
            issues.append(f"Invalid filename format: {lesson_file}")

    # Check 6: No legacy folder structure (modulo-1/)
    if glob(f"{lessons_dir}/modulo-*/"):
        issues.append("Found legacy folder structure (modulo-*/). Use flat M.L-slug.md format.")

    return {
        "valid": len(issues) == 0,
        "issues": issues,
        "total_lessons": len(expected_lessons)
    }

def validate_lesson_numbering(lesson_ids):
    """
    Check for gaps or duplicates in numbering
    """
    issues = []
    parsed_ids = [parse_lesson_id(id) for id in lesson_ids]  # [(1, 1), (1, 2), (2, 1), ...]

    # Group by module
    by_module = defaultdict(list)
    for module, lesson in parsed_ids:
        by_module[module].append(lesson)

    # Check each module for sequential numbering
    for module, lessons in by_module.items():
        lessons.sort()

        for i, lesson_num in enumerate(lessons, start=1):
            if lesson_num != i:
                issues.append(f"Numbering gap in Module {module}: Expected {i}, found {lesson_num}")

    return issues
```

**Validation Report:**
```
════════════════════════════════════════════════════════════
1. STRUCTURAL VALIDATION
════════════════════════════════════════════════════════════

✅ Required files present
   ✓ COURSE-BRIEF.md
   ✓ curriculum.yaml
   ✓ course-outline.md

✅ Lesson files complete (22/22)
   ✓ All curriculum lessons have corresponding files

✅ Lesson numbering sequential
   ✓ No gaps or duplicates

✅ File naming convention correct
   ✓ All files use M.L-slug.md format

✅ No legacy folder structure
   ✓ Flat lessons/ directory structure

────────────────────────────────────────────────────────────
STRUCTURAL VALIDATION: PASSED ✅
════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Checks required files exist (brief, curriculum, outline)
- [ ] Checks all curriculum lessons have files
- [ ] Validates lesson numbering (no gaps, duplicates)
- [ ] Validates file naming (M.L-slug.md format)
- [ ] Rejects legacy folder structure (modulo-1/)

---

### AC 3: Content Completeness Validation

**Checks:**
```python
def validate_content_completeness(course_slug):
    """
    Validate each lesson has required content sections
    """
    lessons_dir = f"outputs/courses/{course_slug}/lessons/"
    issues = []
    lesson_stats = []

    for lesson_file in glob(f"{lessons_dir}/*.md"):
        lesson_content = read_file(lesson_file)
        lesson_id = extract_lesson_id_from_filename(lesson_file)

        # Check 1: Minimum length (500 words for standard lessons)
        word_count = count_words(lesson_content)

        if word_count < 500:
            issues.append(f"{lesson_id}: Too short ({word_count} words, minimum 500)")

        # Check 2: Has learning objectives section
        has_objectives = bool(re.search(r"##.*objetivos.*aprendizagem", lesson_content, re.IGNORECASE))

        if not has_objectives:
            issues.append(f"{lesson_id}: Missing learning objectives section")

        # Check 3: Has introduction/hook
        has_intro = bool(re.search(r"##.*(introdução|intro|hook|goal)", lesson_content, re.IGNORECASE))

        if not has_intro:
            issues.append(f"{lesson_id}: Missing introduction/hook section")

        # Check 4: Has main content (multiple headers)
        header_count = len(re.findall(r"^#+\s", lesson_content, re.MULTILINE))

        if header_count < 3:
            issues.append(f"{lesson_id}: Insufficient structure ({header_count} headers, minimum 3)")

        # Check 5: Has conclusion/summary
        has_conclusion = bool(re.search(r"##.*(conclusão|summary|revisão)", lesson_content, re.IGNORECASE))

        if not has_conclusion:
            issues.append(f"{lesson_id}: Missing conclusion/summary section")

        # Check 6: Has practice exercise or reflection
        has_practice = bool(re.search(r"(exercício|exercise|prática|practice|reflexão|reflection)", lesson_content, re.IGNORECASE))

        if not has_practice:
            issues.append(f"{lesson_id}: Missing practice exercise or reflection prompt")

        # Collect stats
        lesson_stats.append({
            "id": lesson_id,
            "word_count": word_count,
            "header_count": header_count,
            "has_objectives": has_objectives,
            "has_conclusion": has_conclusion,
            "has_practice": has_practice
        })

    return {
        "valid": len(issues) == 0,
        "issues": issues,
        "stats": lesson_stats,
        "avg_word_count": mean([s["word_count"] for s in lesson_stats])
    }
```

**Validation Report:**
```
════════════════════════════════════════════════════════════
2. CONTENT COMPLETENESS VALIDATION
════════════════════════════════════════════════════════════

✅ Lesson length adequate
   Avg: 1,847 words (minimum 500)

✅ All lessons have learning objectives (22/22)

✅ All lessons have introduction/hook (22/22)

✅ Lesson structure adequate
   Avg: 7 headers per lesson (minimum 3)

⚠️  2 lessons missing practice exercises:
   - 5.2-daily-notes.md
   - 6.3-smart-connections.md

────────────────────────────────────────────────────────────
CONTENT COMPLETENESS: PASSED WITH WARNINGS ⚠️
Recommendation: Add practice exercises to flagged lessons.
════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Checks minimum word count (500 words)
- [ ] Checks for learning objectives section
- [ ] Checks for introduction/hook
- [ ] Checks for sufficient structure (≥3 headers)
- [ ] Checks for conclusion/summary
- [ ] Checks for practice exercise or reflection
- [ ] Reports average word count and header count

---

### AC 4: Pedagogical Quality Validation (GPS + DL)

**Integrates Story 3.9 Validation Logic:**
```python
def validate_pedagogical_quality(course_slug):
    """
    Validate lessons follow GPS + Didática Lendária principles
    """
    lessons_dir = f"outputs/courses/{course_slug}/lessons/"
    validator = GPSDLValidator("checklists/didatica-lendaria-validation.md")

    lesson_scores = []
    issues = []

    for lesson_file in glob(f"{lessons_dir}/*.md"):
        lesson_content = read_file(lesson_file)
        lesson_id = extract_lesson_id_from_filename(lesson_file)

        # Run GPS + DL validation
        validation_report = validator.validate_lesson(lesson_content)

        lesson_scores.append({
            "id": lesson_id,
            "overall_score": validation_report["overall_score"],
            "gps_score": validation_report["gps_structure"]["score"],
            "seven_elements_score": validation_report["seven_elements"]["score"],
            "semiotic_score": validation_report["semiotic_elements"]["score"],
            "passed": validation_report["passed"]
        })

        # Flag low-scoring lessons
        if not validation_report["passed"]:
            issues.append(f"{lesson_id}: Score {validation_report['overall_score']}/100 (threshold: 70)")

    avg_score = mean([s["overall_score"] for s in lesson_scores])
    pass_count = sum(1 for s in lesson_scores if s["passed"])

    return {
        "valid": len(issues) == 0,
        "issues": issues,
        "avg_score": avg_score,
        "pass_count": pass_count,
        "total_count": len(lesson_scores),
        "lesson_scores": lesson_scores
    }
```

**Validation Report:**
```
════════════════════════════════════════════════════════════
3. PEDAGOGICAL QUALITY VALIDATION (GPS + DL)
════════════════════════════════════════════════════════════

✅ GPS Structure Compliance: 100% (22/22 lessons)
   Avg GPS Score: 28/30

✅ 7 Elements Present: 95% (21/22 lessons)
   1 lesson missing "Link de Transição"

✅ Semiotic Elements: 91% (20/22 lessons)
   - Analogies: 22/22 ✓
   - Diagrams: 19/22 (3 missing)
   - Reflective Questions: 22/22 ✓

────────────────────────────────────────────────────────────
Overall DL Score: 82/100 ✅ (threshold: 70)
Pass Rate: 100% (22/22 lessons ≥70 points)

Recommendations:
- Add "Link de Transição" to: 6.4-fluxo-completo.md
- Add diagram descriptions to: 2.2, 5.3, 6.1
────────────────────────────────────────────────────────────
PEDAGOGICAL QUALITY: PASSED ✅
════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Runs GPS + DL validation on all lessons
- [ ] Calculates overall DL score (0-100)
- [ ] Reports pass rate (lessons ≥70/100)
- [ ] Flags low-scoring lessons with specific issues
- [ ] Provides actionable recommendations

---

### AC 5: Voice Fidelity Validation (Optional - MMOS Only)

**If MMOS Persona Used:**
```python
def validate_voice_fidelity(course_slug, course_brief):
    """
    Validate voice fidelity against MMOS benchmarks (if MMOS used)
    """
    mmos_config = course_brief.get("mmos_persona", {})

    if not mmos_config.get("enabled"):
        return {
            "applicable": False,
            "message": "Voice fidelity validation skipped (no MMOS persona used)"
        }

    mind_slug = mmos_config["mind_slug"]
    benchmark_path = f"outputs/minds/{mind_slug}/docs/benchmarks/"

    if not os.path.exists(benchmark_path):
        return {
            "applicable": False,
            "message": f"No benchmarks found for MMOS mind '{mind_slug}'"
        }

    # Sample 3-5 lessons for fidelity check
    lessons_dir = f"outputs/courses/{course_slug}/lessons/"
    sampled_lessons = random.sample(glob(f"{lessons_dir}/*.md"), min(5, len(glob(f"{lessons_dir}/*.md"))))

    fidelity_scores = []

    for lesson_file in sampled_lessons:
        lesson_content = read_file(lesson_file)
        lesson_id = extract_lesson_id_from_filename(lesson_file)

        # Run MMOS benchmark comparison
        fidelity_score = calculate_voice_fidelity(lesson_content, mind_slug)

        fidelity_scores.append({
            "id": lesson_id,
            "score": fidelity_score
        })

    avg_fidelity = mean([s["score"] for s in fidelity_scores])

    return {
        "applicable": True,
        "avg_fidelity": avg_fidelity,
        "passed": avg_fidelity >= 85,  # Threshold: 85%
        "samples_tested": len(sampled_lessons),
        "lesson_scores": fidelity_scores
    }
```

**Validation Report:**
```
════════════════════════════════════════════════════════════
4. VOICE FIDELITY VALIDATION (MMOS)
════════════════════════════════════════════════════════════

MMOS Mind: joao_lozano
Samples Tested: 5 lessons

Voice Fidelity Scores:
  1.1 - Por Que Segundo Cérebro: 92%
  2.3 - Arquivos e Anexos: 89%
  4.1 - Links Internos: 94%
  5.2 - Daily Notes: 87%
  6.3 - Smart Connections: 91%

────────────────────────────────────────────────────────────
Average Voice Fidelity: 91% ✅ (threshold: 85%)

Voice characteristics matched:
✓ Tone and style alignment
✓ Recurring phrases present
✓ Teaching philosophy consistent
✓ Language patterns match

────────────────────────────────────────────────────────────
VOICE FIDELITY: PASSED ✅
════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Runs only if MMOS persona was used
- [ ] Samples 3-5 lessons for efficiency
- [ ] Compares against MMOS benchmarks
- [ ] Calculates average fidelity score
- [ ] Pass threshold: ≥85%

---

### AC 6: Validation Report Summary

**Final Report:**
```
════════════════════════════════════════════════════════════
📋 COURSE VALIDATION REPORT
════════════════════════════════════════════════════════════

Course: Dominando Obsidian
Generated: 2025-10-18
Total Lessons: 22

════════════════════════════════════════════════════════════

VALIDATION RESULTS:

1. Structural Validation:        ✅ PASSED
   - Required files present
   - All lessons exist (22/22)
   - Numbering sequential
   - File naming correct

2. Content Completeness:          ⚠️  PASSED WITH WARNINGS
   - Avg word count: 1,847 words
   - 2 lessons missing practice exercises

3. Pedagogical Quality (GPS + DL): ✅ PASSED
   - Overall DL Score: 82/100
   - Pass Rate: 100% (22/22 ≥70 points)

4. Voice Fidelity (MMOS):         ✅ PASSED
   - Avg Fidelity: 91% (threshold: 85%)
   - MMOS Mind: joao_lozano

════════════════════════════════════════════════════════════

OVERALL STATUS: PASSED ✅

Minor Issues (2):
  - 5.2-daily-notes.md: Missing practice exercise
  - 6.3-smart-connections.md: Missing practice exercise

Recommendations:
  1. Add practice exercises to flagged lessons
  2. All other quality metrics met or exceeded

────────────────────────────────────────────────────────────

Next Steps:
  1. Address minor issues above (optional)
  2. Run final review: *review-course dominando-obsidian
  3. Export for LMS: *export-course dominando-obsidian
  4. Generate assessments: *generate-assessments dominando-obsidian

════════════════════════════════════════════════════════════

Report saved to:
  outputs/courses/dominando-obsidian/validation-report-20251018.md

════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Shows overall status (PASSED / FAILED / WARNINGS)
- [ ] Summarizes all 4 validation categories
- [ ] Lists all issues (if any)
- [ ] Provides actionable recommendations
- [ ] Shows next steps
- [ ] Saves detailed report to file

---

### AC 7: Fail-Fast Mode

**Option:** `*validate-course {slug} --fail-fast`

```python
def validate_course_fail_fast(course_slug):
    """
    Stop at first critical failure (don't continue validating)
    """
    # Run structural validation
    structural_result = validate_structure(course_slug)

    if not structural_result["valid"]:
        print(f"❌ STRUCTURAL VALIDATION FAILED")
        print(f"   Issues: {structural_result['issues']}")
        print(f"\n   Fix structural issues before continuing.")
        return {"status": "failed", "category": "structural"}

    # Run content validation
    content_result = validate_content_completeness(course_slug)

    if not content_result["valid"]:
        print(f"❌ CONTENT COMPLETENESS FAILED")
        # ... (same pattern)
        return {"status": "failed", "category": "content"}

    # Continue with pedagogical + voice...
```

**Validation:**
- [ ] `--fail-fast` flag stops at first failure
- [ ] Reports which category failed
- [ ] Skips remaining validations (faster feedback)
- [ ] Default mode runs all validations regardless

---

## Technical Implementation

### Files Created/Modified

1. **New Task:** `expansion-packs/creator-os/tasks/validate-course.md`
   - Main validation command
   - Runs all 4 validation categories
   - Generates report

2. **New Module:** `expansion-packs/creator-os/lib/course_validator.py`
   ```python
   class CourseValidator:
       def __init__(self, course_slug):
           self.course_slug = course_slug
           self.course_dir = f"outputs/courses/{course_slug}/"

       def validate_all(self) -> ValidationReport:
           """Run all 4 validation categories"""
           pass

       def validate_structure(self) -> dict:
           """Structural validation"""
           pass

       def validate_content_completeness(self) -> dict:
           """Content completeness validation"""
           pass

       def validate_pedagogical_quality(self) -> dict:
           """GPS + DL validation"""
           pass

       def validate_voice_fidelity(self, course_brief: dict) -> dict:
           """MMOS voice fidelity (optional)"""
           pass

       def generate_report(self, results: dict) -> str:
           """Generate formatted validation report"""
           pass

       def save_report(self, report: str):
           """Save report to file"""
           pass
   ```

3. **Integration with Story 3.9:** Uses GPSDLValidator from Story 3.9

---

## Definition of Done

- [ ] All 7 Acceptance Criteria met
- [ ] Validation task created
- [ ] CourseValidator module implemented
- [ ] All 4 validation categories functional
- [ ] Validation report generation working
- [ ] Fail-fast mode implemented
- [ ] Unit tests: Structural validation (5 test cases)
- [ ] Unit tests: Content validation (5 test cases)
- [ ] Unit tests: Pedagogical validation (3 test cases)
- [ ] Integration test: Full validation on sample course
- [ ] Integration test: Fail-fast mode
- [ ] Performance: Validation completes in <30s
- [ ] Documentation updated (how to validate courses)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.9: Lesson Generation (uses GPSDLValidator)

**Downstream:**
- None (final quality gate)

---

## Testing Strategy

### Unit Tests

**Test 1: Structural Validation - All Files Present**
```python
def test_structural_validation_complete():
    course_slug = create_complete_test_course()

    result = validate_structure(course_slug)

    assert result["valid"] is True
    assert len(result["issues"]) == 0
```

**Test 2: Structural Validation - Missing Lesson**
```python
def test_structural_validation_missing_lesson():
    course_slug = create_test_course_missing_lesson("2.3")

    result = validate_structure(course_slug)

    assert result["valid"] is False
    assert any("2.3" in issue for issue in result["issues"])
```

**Test 3: Content Validation - Too Short**
```python
def test_content_validation_too_short():
    lesson_content = "# Short Lesson\n\nOnly 100 words here."  # < 500

    word_count = count_words(lesson_content)

    assert word_count < 500
```

**Test 4: Pedagogical Validation - Low Score**
```python
def test_pedagogical_validation_low_score():
    # Lesson with minimal structure (no GPS, no analogies)
    lesson_content = """
    # Title
    Some content.
    """

    validator = GPSDLValidator("checklists/didatica-lendaria-validation.md")
    validation_report = validator.validate_lesson(lesson_content)

    assert validation_report["overall_score"] < 70  # Fails threshold
    assert validation_report["passed"] is False
```

### Integration Tests

**Test 5: End-to-End Full Validation**
```python
def test_e2e_full_validation():
    # Generate complete course
    course_slug = "test-course-validation"
    generate_course(course_slug)  # Uses all stories (3.1-3.9)

    # Run validation
    validator = CourseValidator(course_slug)
    report = validator.validate_all()

    # Should pass all categories
    assert report["structural"]["valid"] is True
    assert report["content"]["valid"] is True
    assert report["pedagogical"]["valid"] is True
    assert report["overall_status"] == "passed"
```

**Test 6: Fail-Fast Mode**
```python
def test_fail_fast_mode():
    # Course with structural issue (missing lesson)
    course_slug = create_test_course_missing_lesson("3.2")

    # Run with fail-fast
    result = validate_course_fail_fast(course_slug)

    # Should stop at structural validation
    assert result["status"] == "failed"
    assert result["category"] == "structural"
    # Pedagogical validation NOT run (fail-fast)
```

---

## Open Questions

1. **Q:** Validate every lesson or sample?
   **A:** v1 validates all for structural/content, samples for voice fidelity (performance).

2. **Q:** Auto-fix issues (e.g., add missing practice exercises)?
   **A:** Out of scope for v1. v2 could add auto-fix suggestions.

3. **Q:** Run validation automatically after generation?
   **A:** Not forced in v1 (user runs manually). v2 could add auto-validation option.

---

## Future Enhancements

- **Auto-Fix Suggestions:** AI-generated fixes for common issues
- **Continuous Validation:** Run validation on every lesson as generated
- **Custom Validation Rules:** Let creator define custom quality criteria
- **Comparison Reports:** Compare validation scores across course versions
- **Export Validation Badge:** Generate quality badge for course marketing

---

**Story Breakdown:**
- Investigation: 1 hour (design validation categories, test validation logic)
- Implementation: 5 hours (validator, 4 categories, report generation)
- Testing: 1.5 hours (6 unit + integration tests)
- Documentation: 0.5 hour
**Total Estimate:** 8 hours (8 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.9: Lesson Generation with GPS + DL](./STORY-3.9-lesson-generation-gps.md)
- [Didática Lendária Checklist](../checklists/didatica-lendaria-validation.md)
- [GPS Lesson Validation Checklist](../checklists/gps-lesson-validation.md)
