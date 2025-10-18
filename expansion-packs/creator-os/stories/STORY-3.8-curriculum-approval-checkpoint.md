# Story 3.8: Curriculum Approval Checkpoint

**Story ID:** STORY-3.8
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P0 (Critical)
**Complexity:** S (Small)
**Story Points:** 5
**Status:** 📋 Planning
**Owner:** Course Architect Agent
**Sprint:** Phase 3 - Quality

---

## User Story

**As a** course creator
**I want** to review and approve the curriculum before lessons are generated
**So that** I don't waste time/cost generating content I'll have to redo

---

## Business Value

### Problem
Current workflow generates all lessons immediately after curriculum:
- No chance to review lesson structure before generation
- Expensive to regenerate if curriculum is wrong (time + API cost)
- User discovers issues AFTER 22 lessons generated (wasted $15-25)
- No way to edit curriculum without restarting entire workflow

**Example Scenario:**
1. System generates curriculum with 25 lessons
2. Immediately starts generating lesson content
3. User realizes Module 3 should have 5 lessons, not 3
4. Too late → Must delete all lessons and regenerate ($$$)

### Solution Value
**Mandatory Approval Gate:**
- HALT after curriculum.yaml generation
- Present clear curriculum summary
- Offer 4 options: Approve, Edit, Regenerate, Cancel
- Only proceed to lesson generation after explicit approval

**Impact:**
- **Cost Savings:** Avoid $15-25 regeneration if curriculum needs changes
- **Time Savings:** 30-45 min saved by catching issues early
- **Quality:** Curriculum validated before expensive operation
- **User Control:** Explicit decision point (not auto-execution)

### Success Metrics
- ✅ 100% of course generations HALT at curriculum checkpoint
- ✅ Zero accidental lesson generations (always require approval)
- ✅ 30%+ of users edit curriculum before approval (proves value)
- ✅ User feedback: "Checkpoint saved me from costly mistake"

---

## Acceptance Criteria

### AC 1: Curriculum Summary Display

**Present Clear Summary:**
```
════════════════════════════════════════════════════════════
📋 CURRICULUM GENERATED
════════════════════════════════════════════════════════════

Course: Dominando Obsidian
Total: 22 lessons across 6 modules
Estimated Duration: 12-15 hours
Estimated Generation Cost: $15-25
Estimated Generation Time: 30-45 minutes

════════════════════════════════════════════════════════════

📚 MODULE BREAKDOWN:

Module 1: Fundamentos (4 lessons, ~75 min)
  1.1 - Por Que Segundo Cérebro (20 min)
  1.2 - Por Que Obsidian (15 min)
  1.3 - Instalação Multi-Plataforma (25 min)
  1.4 - Configurações Essenciais (15 min)

Module 2: Escrita e Formatação (3 lessons, ~65 min)
  2.1 - Markdown Essencial (30 min)
  2.2 - Tipos de Notas (20 min)
  2.3 - Arquivos e Anexos (15 min)

Module 3: Organização (3 lessons, ~55 min)
  3.1 - Pastas Minimalistas (20 min)
  3.2 - Tags e Hierarquias (20 min)
  3.3 - Properties (15 min)

Module 4: Links e Conexões (3 lessons, ~60 min)
  4.1 - Links Internos (25 min)
  4.2 - Backlinks (20 min)
  4.3 - Graph View (15 min)

Module 5: Plugins Essenciais (5 lessons, ~95 min)
  5.1 - Core Plugins (20 min)
  5.2 - Daily Notes (15 min)
  5.3 - Templates (20 min)
  5.4 - Quick Switcher (15 min)
  5.5 - Search (25 min)

Module 6: IA e Produtividade (4 lessons, ~80 min)
  6.1 - ChatGPT + Obsidian (25 min)
  6.2 - AI Summarization (20 min)
  6.3 - Smart Connections (20 min)
  6.4 - Fluxo Completo (15 min)

════════════════════════════════════════════════════════════

📄 FULL CURRICULUM:
   File: outputs/courses/dominando-obsidian/curriculum.yaml
   (Open to see complete YAML structure)

════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Displays course title and total lesson count
- [ ] Shows module breakdown with lesson counts and durations
- [ ] Lists all lessons with module.lesson numbering
- [ ] Calculates total estimated duration
- [ ] Estimates generation cost and time
- [ ] Provides path to full curriculum.yaml file

---

### AC 2: Approval Options

**4 Clear Options:**
```
⏸️  CHECKPOINT: Approve curriculum?

────────────────────────────────────────────────────────────

Options:

[1] ✅ APPROVE
    → Generate all 22 lessons now
    → Estimated cost: $15-25 | Time: 30-45 min
    → Cannot undo (lessons will be generated)

[2] ✏️  EDIT CURRICULUM
    → Modify curriculum.yaml manually in your editor
    → Add/remove lessons, adjust titles/durations
    → Return here when done to validate changes

[3] 🔄 REGENERATE CURRICULUM
    → Go back to COURSE-BRIEF.md and adjust
    → Re-run outline and curriculum generation
    → Use if structure needs major changes

[4] ❌ CANCEL WORKFLOW
    → Stop here without generating lessons
    → Progress saved (COURSE-BRIEF, curriculum preserved)
    → Resume later with: *continue-course dominando-obsidian

────────────────────────────────────────────────────────────

💡 TIP: Most users choose [2] to tweak lesson titles before approval.

────────────────────────────────────────────────────────────

Your choice (1-4): _
```

**Validation:**
- [ ] Presents exactly 4 options (no more, no less)
- [ ] Each option has clear description of what happens
- [ ] Shows cost/time estimates for Option 1
- [ ] Explains how to resume for Option 4
- [ ] Provides helpful tip about common choice
- [ ] Validates user input (1-4 only)

---

### AC 3: Option 1 - Approve & Generate

**Workflow:**
```python
def handle_approval_option_approve(course_slug):
    """
    User selected: Approve - generate all lessons
    """
    logger.info(f"User approved curriculum for {course_slug}")

    # Confirmation prompt (safety check)
    confirm = get_user_input(
        "\n⚠️  This will generate all lessons and incur costs ($15-25).\n"
        "   Are you sure? (yes/no): "
    )

    if confirm.lower() != "yes":
        logger.info("User canceled approval")
        print("\n❌ Approval canceled. Returning to options...\n")
        return show_approval_checkpoint(course_slug)

    # Proceed to lesson generation (Story 3.9)
    print("\n✅ Curriculum approved! Starting lesson generation...\n")
    return "proceed_to_generation"
```

**Validation:**
- [ ] Asks for explicit confirmation ("yes" required)
- [ ] Logs approval decision for audit
- [ ] Returns signal to proceed to Story 3.9 (lesson generation)
- [ ] If user types "no", returns to options menu

---

### AC 4: Option 2 - Edit Curriculum

**Workflow:**
```python
def handle_approval_option_edit(course_slug):
    """
    User selected: Edit curriculum manually
    """
    curriculum_path = f"outputs/courses/{course_slug}/curriculum.yaml"

    print(f"""
    ✏️  EDIT MODE

    1. Open curriculum file:
       {curriculum_path}

    2. Make your changes:
       - Add/remove lessons
       - Adjust titles, durations, or learning objectives
       - Reorder modules

    3. Save the file

    4. Return here and press ENTER to validate changes

    ────────────────────────────────────────────────────────────

    💡 TIPS:
       - Keep numbering sequential (1.1, 1.2, 2.1, ...)
       - Lesson duration: 10-45 minutes typical
       - Use YAML syntax (indentation matters!)

    ────────────────────────────────────────────────────────────

    When done editing, press ENTER to continue: _
    """)

    wait_for_user_input()

    # Re-validate curriculum
    print("\n🔍 Validating edited curriculum...\n")
    validation_result = validate_curriculum_yaml(curriculum_path)

    if not validation_result["valid"]:
        # Show errors
        print("❌ CURRICULUM VALIDATION FAILED\n")
        for error in validation_result["errors"]:
            print(f"   - {error}")

        print("\n→ Please fix errors and return to checkpoint:\n")
        print(f"   *continue-course {course_slug} --validate-curriculum\n")
        raise CurriculumValidationError(validation_result["errors"])

    # Valid: Re-display summary with changes
    print("✅ Curriculum validation passed!\n")
    display_curriculum_summary(curriculum_path)

    # Re-prompt approval
    return show_approval_checkpoint(course_slug)
```

**Validation:**
- [ ] Displays curriculum file path clearly
- [ ] Provides editing tips (numbering, duration, YAML syntax)
- [ ] Waits for user confirmation (ENTER)
- [ ] Re-validates curriculum.yaml after edits
- [ ] Shows validation errors if any
- [ ] Re-displays summary with updated data
- [ ] Returns to approval checkpoint

---

### AC 5: Option 3 - Regenerate Curriculum

**Workflow:**
```python
def handle_approval_option_regenerate(course_slug):
    """
    User selected: Go back and regenerate curriculum
    """
    print("""
    🔄 REGENERATE CURRICULUM

    This will:
    1. Return to COURSE-BRIEF.md for editing
    2. Re-run outline generation
    3. Re-run curriculum generation
    4. Return to this checkpoint

    Current curriculum.yaml will be backed up as curriculum-backup-{timestamp}.yaml

    ────────────────────────────────────────────────────────────

    → Proceed with regeneration? (yes/no): _
    """)

    confirm = get_user_input()

    if confirm.lower() != "yes":
        print("\n❌ Regeneration canceled. Returning to options...\n")
        return show_approval_checkpoint(course_slug)

    # Backup current curriculum
    backup_curriculum(course_slug)

    # Return to brief editing
    print("""
    📝 EDIT COURSE-BRIEF.md

    1. Open: outputs/courses/{course_slug}/COURSE-BRIEF.md
    2. Make changes (objectives, structure, etc.)
    3. Save the file
    4. Run: *continue-course {course_slug} --regenerate-curriculum

    Workflow will regenerate outline + curriculum based on updated brief.

    ────────────────────────────────────────────────────────────
    """.format(course_slug=course_slug))

    return "halt_for_brief_edit"
```

**Validation:**
- [ ] Explains regeneration workflow clearly
- [ ] Asks for confirmation before proceeding
- [ ] Backs up current curriculum.yaml with timestamp
- [ ] Provides instructions for editing brief
- [ ] Shows command to resume with regeneration
- [ ] HALTs workflow (waits for user action)

---

### AC 6: Option 4 - Cancel Workflow

**Workflow:**
```python
def handle_approval_option_cancel(course_slug):
    """
    User selected: Cancel workflow (don't generate lessons)
    """
    print(f"""
    ❌ WORKFLOW CANCELED

    Progress has been saved:
    ✓ COURSE-BRIEF.md
    ✓ course-outline.md
    ✓ curriculum.yaml

    No lessons were generated (no cost incurred).

    ────────────────────────────────────────────────────────────

    To resume later:

    Option A: Generate lessons with current curriculum
      → *continue-course {course_slug}

    Option B: Edit curriculum first, then generate
      → Edit: outputs/courses/{course_slug}/curriculum.yaml
      → Run: *continue-course {course_slug} --validate-curriculum

    Option C: Start over (regenerate curriculum)
      → *continue-course {course_slug} --regenerate-curriculum

    ────────────────────────────────────────────────────────────
    """)

    logger.info(f"User canceled workflow at curriculum checkpoint: {course_slug}")
    return "halt_canceled"
```

**Validation:**
- [ ] Confirms progress saved (brief, outline, curriculum)
- [ ] Confirms no lessons generated (no cost)
- [ ] Provides 3 resume options with commands
- [ ] Logs cancellation decision
- [ ] HALTs workflow gracefully

---

### AC 7: Curriculum Validation

**Validation Rules:**
```python
def validate_curriculum_yaml(curriculum_path):
    """
    Validate curriculum.yaml structure and content
    """
    try:
        curriculum = load_yaml(curriculum_path)
    except yaml.YAMLError as e:
        return {
            "valid": False,
            "errors": [f"Invalid YAML syntax: {e}"]
        }

    errors = []

    # Rule 1: Has modules list
    if "modules" not in curriculum or not curriculum["modules"]:
        errors.append("No modules found in curriculum")

    # Rule 2: Each module has lessons
    for i, module in enumerate(curriculum.get("modules", []), start=1):
        if "lessons" not in module or not module["lessons"]:
            errors.append(f"Module {i} has no lessons")

        # Rule 3: Lesson numbering sequential
        expected_module_num = i
        for j, lesson in enumerate(module.get("lessons", []), start=1):
            lesson_id = lesson.get("id", "")
            expected_id = f"{expected_module_num}.{j}"

            if lesson_id != expected_id:
                errors.append(
                    f"Lesson numbering error: Expected {expected_id}, got {lesson_id}"
                )

    # Rule 4: No duplicate lesson IDs
    all_lesson_ids = [
        lesson["id"]
        for module in curriculum.get("modules", [])
        for lesson in module.get("lessons", [])
    ]
    duplicates = [id for id in all_lesson_ids if all_lesson_ids.count(id) > 1]
    if duplicates:
        errors.append(f"Duplicate lesson IDs found: {set(duplicates)}")

    # Rule 5: Total duration reasonable
    total_duration = sum(
        lesson.get("duration_minutes", 0)
        for module in curriculum.get("modules", [])
        for lesson in module.get("lessons", [])
    )

    if total_duration < 60:  # < 1 hour
        errors.append(f"Total duration too short: {total_duration} minutes")
    elif total_duration > 3000:  # > 50 hours
        errors.append(f"Total duration suspiciously long: {total_duration} minutes")

    return {
        "valid": len(errors) == 0,
        "errors": errors
    }
```

**Validation:**
- [ ] Checks YAML syntax is valid
- [ ] Checks modules list exists and not empty
- [ ] Checks each module has lessons
- [ ] Validates lesson numbering is sequential (1.1, 1.2, 2.1, ...)
- [ ] Checks for duplicate lesson IDs
- [ ] Validates total duration is reasonable (1-50 hours)
- [ ] Returns list of errors (not just true/false)

---

### AC 8: Never Auto-Approve

**Critical Rule:**
```python
# NEVER auto-approve curriculum, even if:
# - User has "auto_approve_curriculum: true" in config (ignore it)
# - Curriculum looks perfect (still require human review)
# - User is in batch mode (still HALT)

# Always:
# - Display checkpoint
# - Wait for explicit user choice (1-4)
# - Log approval decision

# Rationale: This is a "spend money" gate - must be explicit
```

**Validation:**
- [ ] No config option to bypass checkpoint
- [ ] No silent auto-approval logic
- [ ] Always displays checkpoint interface
- [ ] Always requires user input (no default)
- [ ] Logs every approval decision for audit

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/curriculum_approval.py`
   ```python
   class CurriculumApprovalCheckpoint:
       def __init__(self, course_slug, curriculum_path):
           self.course_slug = course_slug
           self.curriculum_path = curriculum_path

       def display_curriculum_summary(self):
           """Show module breakdown and estimates"""
           pass

       def show_approval_options(self) -> str:
           """Present 4 options and get user choice"""
           pass

       def handle_option_approve(self) -> str:
           """Option 1: Approve and proceed"""
           pass

       def handle_option_edit(self) -> str:
           """Option 2: Edit curriculum.yaml"""
           pass

       def handle_option_regenerate(self) -> str:
           """Option 3: Go back to brief"""
           pass

       def handle_option_cancel(self) -> str:
           """Option 4: Cancel workflow"""
           pass

       def validate_curriculum(self) -> Dict:
           """Validate curriculum.yaml structure"""
           pass

       def estimate_generation_cost(self, lesson_count: int) -> tuple:
           """Estimate cost and time for lesson generation"""
           pass
   ```

2. **Modified Task:** `expansion-packs/creator-os/tasks/continue-course.md`
   - Add Step 4 (after curriculum generation, before lesson generation):
     ```markdown
     ### Step 4: Curriculum Approval Checkpoint (MANDATORY HALT)

     1. Display curriculum summary
     2. Show approval options (1-4)
     3. Wait for user input
     4. Handle chosen option:
        - [1] Approve: Proceed to Step 5 (lesson generation)
        - [2] Edit: Wait for edits, re-validate, re-prompt
        - [3] Regenerate: HALT with instructions
        - [4] Cancel: HALT gracefully
     5. Log approval decision
     6. Never bypass this checkpoint
     ```

---

## Definition of Done

- [ ] All 8 Acceptance Criteria met
- [ ] Curriculum Approval Checkpoint module implemented
- [ ] Summary display shows all required data
- [ ] 4 approval options functional
- [ ] Curriculum validation logic complete
- [ ] Integration with `continue-course` task complete
- [ ] Unit tests: Validation logic (5 test cases)
- [ ] Unit tests: Each approval option (4 test cases)
- [ ] Integration test: End-to-end approval flow
- [ ] Integration test: Edit curriculum and re-validate
- [ ] UX test: 5 users interact with checkpoint (clear?)
- [ ] Documentation updated (how checkpoint works)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.6: Gap Analysis (brief must be complete before curriculum generation)

**Downstream:**
- Story 3.9: Lesson Generation (only runs after approval)

---

## Testing Strategy

### Unit Tests

**Test 1: Curriculum Validation - Valid**
```python
def test_validate_curriculum_valid():
    curriculum = create_valid_curriculum_yaml()

    result = validate_curriculum_yaml(curriculum)

    assert result["valid"] is True
    assert len(result["errors"]) == 0
```

**Test 2: Curriculum Validation - Invalid YAML**
```python
def test_validate_curriculum_invalid_yaml():
    curriculum_path = create_file_with_invalid_yaml()

    result = validate_curriculum_yaml(curriculum_path)

    assert result["valid"] is False
    assert "Invalid YAML syntax" in result["errors"][0]
```

**Test 3: Curriculum Validation - Duplicate IDs**
```python
def test_validate_curriculum_duplicate_ids():
    curriculum = create_curriculum_with_duplicate_lesson_id()

    result = validate_curriculum_yaml(curriculum)

    assert result["valid"] is False
    assert any("Duplicate lesson IDs" in err for err in result["errors"])
```

**Test 4: Curriculum Validation - Non-Sequential Numbering**
```python
def test_validate_curriculum_non_sequential():
    curriculum = create_curriculum_with_gaps()  # 1.1, 1.2, 1.4 (skip 1.3)

    result = validate_curriculum_yaml(curriculum)

    assert result["valid"] is False
    assert any("numbering error" in err for err in result["errors"])
```

**Test 5: Option 1 - Approve**
```python
def test_approval_option_approve():
    checkpoint = CurriculumApprovalCheckpoint("test-course", "curriculum.yaml")

    # Simulate user input: [1] Approve, then "yes" confirmation
    with mock_user_input(["1", "yes"]):
        result = checkpoint.show_approval_options()

    assert result == "proceed_to_generation"
```

**Test 6: Option 2 - Edit and Re-validate**
```python
def test_approval_option_edit():
    checkpoint = CurriculumApprovalCheckpoint("test-course", "curriculum.yaml")

    # Simulate user input: [2] Edit, then ENTER after editing
    with mock_user_input(["2", ""]):
        # Mock file edit (curriculum.yaml updated)
        mock_file_edit("curriculum.yaml", add_lesson="3.4")

        result = checkpoint.show_approval_options()

    # Should re-prompt options after successful validation
    assert result in ["proceed_to_generation", "halt_for_brief_edit", "halt_canceled"]
```

**Test 7: Option 4 - Cancel**
```python
def test_approval_option_cancel():
    checkpoint = CurriculumApprovalCheckpoint("test-course", "curriculum.yaml")

    with mock_user_input(["4"]):
        result = checkpoint.show_approval_options()

    assert result == "halt_canceled"
```

### Integration Tests

**Test 8: End-to-End Approval Flow**
```python
def test_e2e_curriculum_approval_flow():
    course_slug = "test-course-approval"

    # Generate curriculum
    curriculum_path = generate_curriculum(course_slug)

    # Checkpoint triggered
    checkpoint = CurriculumApprovalCheckpoint(course_slug, curriculum_path)

    # Display summary (should not crash)
    checkpoint.display_curriculum_summary()

    # User approves
    with mock_user_input(["1", "yes"]):
        result = checkpoint.show_approval_options()

    assert result == "proceed_to_generation"

    # Approval decision logged
    assert log_contains(f"User approved curriculum for {course_slug}")
```

**Test 9: Edit Flow with Validation Failure**
```python
def test_edit_flow_validation_fails():
    checkpoint = CurriculumApprovalCheckpoint("test-course", "curriculum.yaml")

    # User edits and introduces error (duplicate ID)
    with mock_user_input(["2", ""]):
        mock_file_edit("curriculum.yaml", introduce_duplicate_id=True)

        with pytest.raises(CurriculumValidationError):
            checkpoint.show_approval_options()
```

---

## Open Questions

1. **Q:** Show cost estimate breakdown (per lesson, per module)?
   **A:** v1 shows total only. v2 could add detailed breakdown.

2. **Q:** Allow partial approval (approve some modules, edit others)?
   **A:** Out of scope for v1. All-or-nothing approval simplifies workflow.

3. **Q:** Auto-save checkpoint state (resume if interrupted)?
   **A:** Handled by Story 3.11 (Error Recovery). Checkpoint itself is stateless.

---

## Future Enhancements

- **Cost Breakdown:** Show per-module and per-lesson cost estimates
- **Partial Approval:** Approve specific modules, regenerate others
- **Inline Editing:** Edit curriculum in CLI (no manual file edit)
- **Preview Mode:** Show sample lesson outline before full generation
- **Batch Approval:** Approve multiple courses at once (for automation)

---

**Story Breakdown:**
- Investigation: 0.5 hour (design approval UX)
- Implementation: 3 hours (display, options, validation, integration)
- Testing: 1 hour (9 unit + integration tests)
- Documentation: 0.5 hour
**Total Estimate:** 5 hours (5 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.6: Gap Analysis & Smart Elicitation](./STORY-3.6-gap-analysis-smart-elicitation.md)
- [Story 3.9: Lesson Generation with GPS + DL](./STORY-3.9-lesson-generation-gps.md)
- [Story 3.11: Error Recovery & Resume System](./STORY-3.11-error-recovery-resume.md)
