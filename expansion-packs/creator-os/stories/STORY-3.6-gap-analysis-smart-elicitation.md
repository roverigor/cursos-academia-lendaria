# Story 3.6: Gap Analysis & Smart Elicitation

**Story ID:** STORY-3.6
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P0 (Critical)
**Complexity:** L (Large)
**Story Points:** 13
**Status:** ✅ Completed
**Owner:** Course Architect Agent
**Sprint:** Phase 2 - Intelligence
**Completed:** 2025-10-18

---

## User Story

**As a** course creator
**I want** the system to ask ONLY what's truly missing from my brief
**So that** I don't waste time answering questions about data already extracted

---

## Business Value

### Problem
Current workflow asks ALL questions regardless of extracted data:
- Brownfield course with ICP.md → System still asks for demographics
- Transcripts analyzed → System still asks for voice/tone
- 38 lessons exist → System still asks "what will students learn?"

**Result:**
- Creator answers 15-20 questions
- 60-80% of answers are "it's already in the files!"
- Frustration: "Why didn't the system use what I gave it?"
- Time wasted: 20-30 minutes of redundant data entry

### Solution Value
**Intelligent Gap Analysis:**
- Analyzes COURSE-BRIEF completeness after all extractions
- Identifies 🟢 Complete, 🟡 Needs Review, 🔴 Missing sections
- Asks ONLY targeted questions for gaps
- Presents extracted data for validation (not re-entry)

**Impact:**
- **Time Saved:** 15-25 min per brownfield course (60-80% reduction in questions)
- **UX Delight:** "Wow, it already knows my audience!" moment
- **Accuracy:** Validation questions catch extraction errors
- **Adoption:** Brownfield users become power users (positive surprise)

### Success Metrics
- ✅ Brownfield courses: ≤8 questions asked (vs. 15-20 baseline)
- ✅ Question reduction: 60-80% for good brownfield scenarios
- ✅ User satisfaction: 90%+ say "smart elicitation saved time"
- ✅ Zero false positives (never skip truly missing data)

---

## Acceptance Criteria

### AC 1: Completeness Analysis

**Section Status Calculation:**
```python
def analyze_brief_completeness(course_brief_path):
    """
    Scan COURSE-BRIEF.md and determine what's complete, partial, missing
    """
    brief_content = read_file(course_brief_path)

    completeness_map = {
        "section_1_basic_info": analyze_section_1(brief_content),
        "section_2_icp": analyze_section_2(brief_content),
        "section_3_content": analyze_section_3(brief_content),
        "section_4_voice": analyze_section_4(brief_content),
        "section_5_format": analyze_section_5(brief_content),
        "section_6_commercial": analyze_section_6(brief_content),
        "section_7_context": analyze_section_7(brief_content),
        "section_8_checklist": analyze_section_8(brief_content)
    }

    return completeness_map

def analyze_section_2(brief_content):
    """
    Example: ICP section completeness
    """
    section_text = extract_section(brief_content, "## 2. Público-Alvo")

    # Check subsections
    has_demographics = bool(re.search(r"### Demografia\s+\n.*\w", section_text))
    has_psychographics = bool(re.search(r"### Psicografia\s+\n.*\w", section_text))
    has_pain_points = bool(re.search(r"### Dores\s+\n.*\w", section_text))
    has_goals = bool(re.search(r"### Objetivos\s+\n.*\w", section_text))

    # Check for placeholder text (indicates empty)
    has_placeholders = "_[" in section_text or "{" in section_text

    filled_count = sum([has_demographics, has_psychographics, has_pain_points, has_goals])

    if filled_count == 4 and not has_placeholders:
        return {
            "status": "🟢",
            "completeness": 100,
            "subsections": {
                "demographics": "🟢",
                "psychographics": "🟢",
                "pain_points": "🟢",
                "goals": "🟢"
            }
        }
    elif filled_count >= 2 and not has_placeholders:
        return {
            "status": "🟡",
            "completeness": 50,
            "subsections": {...}  # Mark which are filled
        }
    else:
        return {
            "status": "🔴",
            "completeness": 0,
            "subsections": {...}  # All empty
        }
```

**Output Format:**
```yaml
brief_completeness:
  overall_score: 72  # Percentage (0-100)

  section_1_basic_info:
    status: "🟡"
    completeness: 75
    fields:
      title: "🟡"  # Inferred, needs confirmation
      slug: "🟢"  # User provided
      category: "🔴"  # Unknown
      duration: "🟡"  # Inferred from lesson count

  section_2_icp:
    status: "🟢"
    completeness: 100
    subsections:
      demographics: "🟢"  # Extracted from ICP.md
      psychographics: "🟢"
      pain_points: "🟢"
      goals: "🟢"

  section_3_content:
    status: "🟡"
    completeness: 60
    fields:
      objectives: "🟡"  # Inferred from lessons
      framework: "🔴"  # Unknown
      prerequisites: "🟢"  # Auto-detected

  section_4_voice:
    status: "🟢"
    completeness: 95
    fields:
      tone: "🟢"  # Extracted from transcripts
      style: "🟢"
      phrases: "🟢"
      greeting: "🟢"

  section_5_format:
    status: "🟡"
    completeness: 40
    fields:
      lesson_duration: "🟡"  # Inferred (avg 20 min)
      lesson_format: "🔴"  # Unknown
      assessment_types: "🔴"  # Unknown

  section_6_commercial:
    status: "🔴"
    completeness: 0
    fields:
      pricing: "🔴"  # Unknown
      launch_date: "🔴"  # Unknown
      upsells: "🔴"  # Unknown

  section_7_context:
    status: "🟢"
    completeness: 100
    fields:
      references: "🟢"  # Auto-generated links to /sources/

  section_8_checklist:
    status: "🟡"
    completeness: 50
    fields:
      didatica_lendaria: "🟡"  # Auto-populated, needs confirmation
```

**Validation:**
- [ ] Analyzes all 8 COURSE-BRIEF sections
- [ ] Detects filled vs. placeholder text
- [ ] Calculates subsection-level completeness
- [ ] Returns status (🟢/🟡/🔴) per field
- [ ] Overall completeness score (0-100%)

---

### AC 2: Question Generation Strategy

**Elicitation Rules:**
```python
def generate_elicitation_questions(completeness_map):
    """
    Generate targeted questions based on completeness analysis
    """
    questions = []

    for section_id, section_data in completeness_map.items():
        status = section_data["status"]

        if status == "🟢":
            # Complete: Skip entirely (no questions)
            continue

        elif status == "🟡":
            # Partial: Generate confirmation questions
            question = generate_confirmation_question(section_id, section_data)
            questions.append(question)

        elif status == "🔴":
            # Missing: Generate full elicitation questions
            question = generate_full_elicitation(section_id, section_data)
            questions.append(question)

    return questions

def generate_confirmation_question(section_id, section_data):
    """
    For 🟡 sections: Show extracted data, ask for confirmation/edits
    """
    if section_id == "section_2_icp":
        return {
            "type": "confirmation",
            "section": "ICP (Section 2)",
            "prompt": """
                I analyzed your existing materials and extracted this ICP data:

                **Demographics:**
                - Age: 35-45 anos
                - Location: Brasil (urbano)
                - Occupation: Empreendedor Digital, Executivo

                **Pain Points:**
                - Sobrecarga cognitiva (infinite consumption loop)
                - Ferramentas que prometem produtividade mas geram ansiedade

                **Goals:**
                - Executar com foco (menos ruído mental)
                - Sistema sustentável (não depende de willpower)

                ✓ Does this accurately represent your target audience?
            """,
            "options": ["Yes, looks good", "No, needs editing", "Show me the source"],
            "on_no": "mark_for_manual_edit",
            "on_yes": "mark_complete"
        }

def generate_full_elicitation(section_id, section_data):
    """
    For 🔴 sections: Ask complete question
    """
    if section_id == "section_5_format" and section_data["fields"]["assessment_types"] == "🔴":
        return {
            "type": "elicitation",
            "section": "Assessment Types (Section 5)",
            "prompt": "What types of assessments fit this course?",
            "input_type": "multiple_choice",
            "options": [
                {"value": "quiz", "label": "Quiz (knowledge checks)", "description": "Multiple choice, scenario-based questions"},
                {"value": "project", "label": "Project (hands-on deliverable)", "description": "Students build something tangible"},
                {"value": "workshop", "label": "Workshop (guided practice)", "description": "Step-by-step exercises"},
                {"value": "case_study", "label": "Case Study (scenario analysis)", "description": "Analyze real-world situations"},
                {"value": "mix", "label": "Mix (combination)", "description": "Use multiple assessment types"}
            ],
            "allow_multiple": True
        }
```

**Validation:**
- [ ] 🟢 sections generate ZERO questions
- [ ] 🟡 sections generate confirmation questions
- [ ] 🔴 sections generate full elicitation questions
- [ ] Questions show extracted data (not re-ask)
- [ ] Questions are contextual (tailored to section)

---

### AC 3: Adaptive Question Flow

**Question Count by Scenario:**
```python
def calculate_expected_questions(creation_mode, completeness_map):
    """
    Estimate question count based on scenario
    """
    overall_completeness = completeness_map["overall_score"]

    if creation_mode == "greenfield":
        # No extraction: Ask everything
        base_questions = 15
        reduction = 0
    elif creation_mode == "brownfield":
        # Extraction ran: Reduce based on completeness
        base_questions = 15
        reduction = (overall_completeness / 100) * base_questions
    else:  # hybrid, mmos, etc.
        base_questions = 12
        reduction = (overall_completeness / 100) * base_questions

    final_count = max(3, base_questions - reduction)  # Min 3 questions
    return int(final_count)

# Examples:
# Greenfield (0% completeness): 15 questions
# Brownfield (80% completeness): 15 - (0.8 * 15) = 3 questions
# Brownfield (50% completeness): 15 - (0.5 * 15) = 7-8 questions
# Hybrid (60% completeness): 12 - (0.6 * 12) = 5 questions
```

**Validation:**
- [ ] Greenfield: 15-20 questions (full brief)
- [ ] Brownfield (good extraction ≥70%): 3-8 questions
- [ ] Brownfield (partial extraction 40-70%): 8-12 questions
- [ ] Brownfield (poor extraction <40%): 12-15 questions
- [ ] Minimum 3 questions (always ask critical fields)

---

### AC 4: Interactive Validation Flow

**User Interface (CLI/Interactive):**
```
📊 BRIEF ANALYSIS COMPLETE

I analyzed your existing materials and auto-filled these sections:

════════════════════════════════════════════════════════════

✅ COMPLETE (No action needed):

🟢 ICP (Section 2)
   ✓ Demographics extracted from `sources/ICP-Cliente-Ideal.md`
   ✓ Psychographics extracted
   ✓ Pain points extracted (3 items)
   ✓ Goals extracted (3 items)

🟢 Voice & Personality (Section 4)
   ✓ Analyzed 5 transcripts
   ✓ Signature greeting: "Fala, lendário!"
   ✓ Tone: Warm, conversational
   ✓ Recurring phrases: 10 identified

🟢 Context & References (Section 7)
   ✓ Auto-generated links to 38 legacy lessons
   ✓ Auto-generated links to 5 transcripts

════════════════════════════════════════════════════════════

🔄 NEEDS CONFIRMATION (Please review):

🟡 Learning Objectives (Section 3.2)
   Inferred from 38 legacy lessons:
   1. Build a functional second brain in Obsidian
   2. Organize knowledge with sustainable systems
   3. Connect ideas using bi-directional links
   4. Integrate AI for productivity

   → Do these objectives accurately reflect your course goals?
      [1] Yes, looks good
      [2] No, I'll edit them manually
      [3] Show me the source lessons

   Your choice (1-3): _

════════════════════════════════════════════════════════════

❓ MISSING (Need your input):

🔴 Course Category (Section 1)
   → What category does this course belong to?
      [1] Productivity
      [2] Technology
      [3] Business
      [4] Personal Development
      [5] Other (specify)

   Your choice (1-5): _

🔴 Assessment Types (Section 5)
   → What assessment types fit this course? (Select all that apply)
      [1] Quiz (knowledge checks)
      [2] Project (hands-on deliverable)
      [3] Workshop (guided practice)
      [4] Case Study (scenario analysis)
      [5] Mix (combination)

   Your choices (comma-separated, e.g., 1,2,5): _

🔴 Pricing (Section 6)
   → What's the pricing model for this course?
      [1] Free
      [2] Paid (one-time)
      [3] Subscription
      [4] Freemium
      [5] Not decided yet

   Your choice (1-5): _

════════════════════════════════════════════════════════════

📋 SUMMARY:
   Complete sections: 3/8 (38%)
   Needs confirmation: 1
   Missing data: 3 questions

   Total questions: 4 (saved you 11 questions with smart extraction!)

   Estimated time: 3-5 minutes

════════════════════════════════════════════════════════════

Let's fill in the gaps...
```

**Validation:**
- [ ] Shows 3 categories: Complete, Needs Confirmation, Missing
- [ ] Complete sections listed with ✓ indicators
- [ ] Confirmation sections show extracted data
- [ ] Missing sections show targeted questions only
- [ ] Summary shows question count and time estimate
- [ ] Mentions how many questions were saved

---

### AC 5: Answer Persistence

**Update COURSE-BRIEF.md:**
```python
def persist_answers_to_brief(brief_path, answers, completeness_map):
    """
    Update COURSE-BRIEF.md with user answers
    """
    brief_content = read_file(brief_path)

    for question_id, answer in answers.items():
        section_id = get_section_from_question(question_id)

        if answer["type"] == "confirmation":
            if answer["value"] == "Yes, looks good":
                # Mark section as 🟢 (confirmed)
                brief_content = update_section_status(
                    brief_content,
                    section_id,
                    status="🟢",
                    note="Confirmed by user"
                )
            elif answer["value"] == "No, needs editing":
                # Mark section as 🟡 (manual edit required)
                brief_content = update_section_status(
                    brief_content,
                    section_id,
                    status="🟡",
                    note="Review and edit manually"
                )

        elif answer["type"] == "elicitation":
            # Fill missing section with answer
            brief_content = fill_section(
                brief_content,
                section_id,
                answer["value"]
            )
            # Mark as 🟢 (now complete)
            brief_content = update_section_status(
                brief_content,
                section_id,
                status="🟢",
                note="Filled by user"
            )

    # Write back to file
    write_file(brief_path, brief_content)

    # Validate all sections now 🟢
    final_completeness = analyze_brief_completeness(brief_path)
    return final_completeness
```

**Validation:**
- [ ] Answers written to correct COURSE-BRIEF sections
- [ ] Status indicators updated (🟡 → 🟢, 🔴 → 🟢)
- [ ] Confirmation="Yes" marks section 🟢
- [ ] Confirmation="No" marks section 🟡 (user to edit)
- [ ] Elicitation answers fill missing fields and mark 🟢

---

### AC 6: Final Validation Gate

**Pre-Halt Validation:**
```python
def validate_brief_before_halt(brief_path):
    """
    Final check: All sections must be 🟢 before continuing
    """
    completeness = analyze_brief_completeness(brief_path)

    incomplete_sections = []
    for section_id, section_data in completeness.items():
        if section_data["status"] != "🟢":
            incomplete_sections.append(section_id)

    if incomplete_sections:
        # Error: Can't proceed
        error_message = f"""
        ❌ BRIEF INCOMPLETE

        The following sections are not complete:
        {format_incomplete_sections(incomplete_sections)}

        Please review COURSE-BRIEF.md and fill these sections manually.

        When done, run: *continue-course {slug} --validate-brief

        Or to edit interactively: *edit-brief {slug}
        """
        raise BriefIncompleteError(error_message)

    # All 🟢: Ready to proceed
    logger.info("✅ COURSE-BRIEF validation passed (all sections complete)")
    return True
```

**Validation:**
- [ ] Checks all 8 sections are 🟢 before HALT
- [ ] If any 🟡 or 🔴: Shows error with instructions
- [ ] Provides recovery commands (*validate-brief, *edit-brief)
- [ ] Only HALTs if 100% complete

---

### AC 7: Question Skipping Logic

**Scenario-Specific Rules:**
```python
# Rule 1: ICP Section
if completeness["section_2_icp"]["status"] == "🟢":
    # Skip ALL ICP questions (demographics, psychographics, pain, goals)
    skip_questions(["icp_demographics", "icp_psychographics", "icp_pain", "icp_goals"])

# Rule 2: Voice Section
if completeness["section_4_voice"]["status"] == "🟢":
    # Skip voice/tone questions
    skip_questions(["voice_tone", "voice_style", "voice_phrases"])

# Rule 3: Learning Objectives
if completeness["section_3_content"]["fields"]["objectives"] == "🟢":
    # Skip objectives question
    skip_questions(["learning_objectives"])
elif completeness["section_3_content"]["fields"]["objectives"] == "🟡":
    # Ask confirmation only
    ask_confirmation(["learning_objectives"])

# Rule 4: Commercial Section (always ask in v1)
# Even if pricing found in legacy docs, always confirm (business-critical data)
ask_full_elicitation(["pricing", "launch_date"])

# Rule 5: MMOS Mode (special case)
if creation_mode == "mmos" and mmos_mind_loaded:
    # Voice comes from MMOS, skip voice section entirely
    skip_questions(["voice_*"])
    mark_section_complete("section_4_voice", source="mmos")
```

**Validation:**
- [ ] 🟢 sections: All related questions skipped
- [ ] 🟡 sections: Only confirmation question asked
- [ ] 🔴 sections: Full question asked
- [ ] Commercial section always asks (even if 🟢) - business-critical
- [ ] MMOS mode skips voice questions

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/gap_analyzer.py`
   ```python
   class GapAnalyzer:
       def __init__(self, brief_path):
           self.brief_path = brief_path
           self.completeness_map = None

       def analyze_completeness(self) -> CompletenessMap:
           """Scan COURSE-BRIEF and determine section statuses"""
           pass

       def generate_questions(self, completeness_map: CompletenessMap) -> List[Question]:
           """Generate targeted questions for gaps"""
           pass

       def generate_confirmation_question(self, section_id: str, section_data: dict) -> Question:
           """For 🟡 sections"""
           pass

       def generate_full_elicitation(self, section_id: str, section_data: dict) -> Question:
           """For 🔴 sections"""
           pass

       def calculate_expected_question_count(self, creation_mode: str, completeness_map: CompletenessMap) -> int:
           """Estimate questions based on scenario"""
           pass

       def persist_answers(self, answers: Dict[str, Answer]) -> CompletenessMap:
           """Write answers back to COURSE-BRIEF"""
           pass

       def validate_brief_complete(self) -> bool:
           """Final gate: All sections 🟢?"""
           pass
   ```

2. **New Module:** `expansion-packs/creator-os/lib/elicitation_engine.py`
   ```python
   class ElicitationEngine:
       def __init__(self, questions: List[Question]):
           self.questions = questions

       def run_interactive_flow(self) -> Dict[str, Answer]:
           """Present questions to user interactively (CLI)"""
           pass

       def display_summary(self, completeness_map: CompletenessMap):
           """Show complete/confirmation/missing sections"""
           pass

       def ask_question(self, question: Question) -> Answer:
           """Single question interaction"""
           pass

       def validate_answer(self, question: Question, raw_answer: str) -> Answer:
           """Validate and parse user input"""
           pass
   ```

3. **Modified Task:** `expansion-packs/creator-os/tasks/continue-course.md`
   - Add Step 3 (after all extractions):
     ```markdown
     ### Step 3: Gap Analysis & Smart Elicitation

     1. Run Gap Analyzer: `analyzer.analyze_completeness()`
     2. Generate targeted questions: `analyzer.generate_questions()`
     3. Display summary (Complete/Confirmation/Missing)
     4. Run interactive elicitation: `engine.run_interactive_flow()`
     5. Persist answers: `analyzer.persist_answers()`
     6. Validate all sections 🟢: `analyzer.validate_brief_complete()`
     7. If validation fails: HALT with error
     8. If validation passes: Mark COURSE-BRIEF as complete, HALT
     ```

4. **New Template:** `expansion-packs/creator-os/templates/elicitation-questions.yaml`
   - Question bank for all 8 COURSE-BRIEF sections
   - Multiple choice options, validation rules

---

## Definition of Done

- [ ] All 7 Acceptance Criteria met
- [ ] Gap Analyzer module implemented
- [ ] Elicitation Engine module implemented
- [ ] Question bank template created
- [ ] Integration with `continue-course` task complete
- [ ] Unit tests: Completeness analysis (8 test cases, one per section)
- [ ] Unit tests: Question generation (6 test cases for different scenarios)
- [ ] Unit tests: Answer persistence (5 test cases)
- [ ] Integration test: End-to-end greenfield flow (15-20 questions)
- [ ] Integration test: End-to-end brownfield flow (3-8 questions)
- [ ] Integration test: Validation gate (blocks if incomplete)
- [ ] UX test: Interactive flow with real user (5 testers)
- [ ] Performance: <2s for completeness analysis
- [ ] Documentation updated (how gap analysis works)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.3: ICP Extraction (provides Section 2 data)
- Story 3.4: Voice Extraction (provides Section 4 data)
- Story 3.5: Objectives Inference (provides Section 3.2 data)

**Downstream:**
- Story 3.8: Curriculum Approval Checkpoint (brief must be complete first)

---

## Testing Strategy

### Unit Tests

**Test 1: Completeness Analysis - All Complete**
```python
def test_completeness_all_complete():
    brief_content = create_complete_brief()  # All sections filled

    completeness = analyze_brief_completeness(brief_content)

    assert completeness["overall_score"] == 100
    assert all(section["status"] == "🟢" for section in completeness.values())
```

**Test 2: Completeness Analysis - Partial (ICP Missing)**
```python
def test_completeness_partial_icp_missing():
    brief_content = create_brief_template()  # Empty template

    completeness = analyze_brief_completeness(brief_content)

    assert completeness["section_2_icp"]["status"] == "🔴"
    assert completeness["section_2_icp"]["completeness"] == 0
```

**Test 3: Question Generation - Greenfield**
```python
def test_question_generation_greenfield():
    completeness = create_empty_completeness_map()  # All 🔴

    questions = generate_elicitation_questions(completeness)

    assert len(questions) >= 15  # Full question set
    assert all(q["type"] == "elicitation" for q in questions)
```

**Test 4: Question Generation - Brownfield (Good Extraction)**
```python
def test_question_generation_brownfield_good():
    completeness = {
        "section_2_icp": {"status": "🟢"},  # Extracted
        "section_4_voice": {"status": "🟢"},  # Extracted
        "section_3_content": {"status": "🟡"},  # Partial
        "section_6_commercial": {"status": "🔴"}  # Missing
    }

    questions = generate_elicitation_questions(completeness)

    # Only 1 confirmation (Section 3) + 1 full (Section 6) = 2-3 questions
    assert len(questions) <= 5
    assert any(q["type"] == "confirmation" for q in questions)
```

**Test 5: Answer Persistence - Confirmation Yes**
```python
def test_persist_answer_confirmation_yes():
    brief_path = create_test_brief_with_inferred_objectives()
    answer = {"type": "confirmation", "value": "Yes, looks good"}

    persist_answers_to_brief(brief_path, {"objectives": answer}, completeness_map)

    # Section should be marked 🟢
    brief_content = read_file(brief_path)
    assert "🟢" in extract_section(brief_content, "### 3.2 Objetivos")
```

**Test 6: Answer Persistence - Elicitation Fill**
```python
def test_persist_answer_elicitation():
    brief_path = create_test_brief_empty_category()
    answer = {"type": "elicitation", "value": "Productivity"}

    persist_answers_to_brief(brief_path, {"category": answer}, completeness_map)

    # Category should be filled
    brief_content = read_file(brief_path)
    assert "Productivity" in extract_section(brief_content, "## 1. Informações Básicas")
```

**Test 7: Final Validation - Incomplete Brief**
```python
def test_validation_gate_incomplete():
    brief_path = create_test_brief_with_missing_sections()

    with pytest.raises(BriefIncompleteError):
        validate_brief_before_halt(brief_path)
```

**Test 8: Final Validation - Complete Brief**
```python
def test_validation_gate_complete():
    brief_path = create_complete_brief()

    # Should pass without error
    result = validate_brief_before_halt(brief_path)
    assert result is True
```

### Integration Tests

**Test 9: End-to-End Greenfield Flow**
```python
def test_e2e_greenfield_flow():
    # Setup: Empty course folder
    course_folder = create_test_course("test-greenfield")

    # No extractions (all sections 🔴)
    completeness = analyze_brief_completeness(f"{course_folder}/COURSE-BRIEF.md")
    assert completeness["overall_score"] == 0

    # Generate questions
    questions = generate_elicitation_questions(completeness)
    assert len(questions) >= 15  # Full question set

    # Simulate user answers
    answers = simulate_user_answers(questions)

    # Persist
    persist_answers_to_brief(f"{course_folder}/COURSE-BRIEF.md", answers, completeness)

    # Validate now complete
    final_validation = validate_brief_before_halt(f"{course_folder}/COURSE-BRIEF.md")
    assert final_validation is True
```

**Test 10: End-to-End Brownfield Flow (Good Extraction)**
```python
def test_e2e_brownfield_good_extraction():
    # Setup: Course with ICP.md, transcripts, lessons
    course_folder = "test-data/dominando-obsidian"
    create_file(f"{course_folder}/sources/ICP.md", REALISTIC_ICP)
    create_transcripts(f"{course_folder}/sources/transcripts/", count=5)
    create_legacy_lessons(course_folder, count=20)

    # Run extractions (Stories 3.3, 3.4, 3.5)
    run_icp_extraction(course_folder)
    run_voice_extraction(course_folder)
    run_objectives_inference(course_folder)

    # Analyze completeness (should be ~70-80%)
    completeness = analyze_brief_completeness(f"{course_folder}/COURSE-BRIEF.md")
    assert completeness["overall_score"] >= 70

    # Generate questions (should be reduced)
    questions = generate_elicitation_questions(completeness)
    assert len(questions) <= 8  # Reduced from 15

    # Most questions should be confirmation, not full elicitation
    confirmation_count = sum(1 for q in questions if q["type"] == "confirmation")
    assert confirmation_count >= len(questions) // 2
```

**Test 11: Question Count Scenarios**
```python
@pytest.mark.parametrize("scenario,expected_questions", [
    ("greenfield", (15, 20)),  # 15-20 questions
    ("brownfield_good", (3, 8)),  # 3-8 questions
    ("brownfield_partial", (8, 12)),  # 8-12 questions
    ("mmos", (5, 10)),  # 5-10 questions (voice from MMOS)
])
def test_question_count_by_scenario(scenario, expected_questions):
    course_folder, completeness = setup_scenario(scenario)

    questions = generate_elicitation_questions(completeness)

    min_q, max_q = expected_questions
    assert min_q <= len(questions) <= max_q
```

---

## Open Questions

1. **Q:** Allow editing COURSE-BRIEF interactively (in CLI) or require manual file edit?
   **A:** v1 requires manual edit (simpler). v2 could add inline editing.

2. **Q:** Support batch answer import (answer all questions via YAML file)?
   **A:** Out of scope for v1 (interactive only). v2 could add batch mode for automation.

3. **Q:** How to handle user clicking "edit manually" but not actually editing?
   **A:** Validation gate will catch it (brief still incomplete). Re-prompt or block.

4. **Q:** Confidence threshold for auto-complete (mark 🟢 without confirmation)?
   **A:** v1 always asks confirmation for 🟡 (safe). v2 could add auto-accept at ≥95% confidence.

---

## Future Enhancements

- **Inline Editing:** Edit COURSE-BRIEF sections directly in CLI (no manual file edit)
- **Batch Answer Import:** Provide answers via YAML file (automation-friendly)
- **Smart Defaults:** Pre-select most likely answer (user just confirms)
- **Skip Confirmations:** Auto-accept 🟡 sections with ≥95% confidence
- **Question Ordering:** Adaptive order (start with most important questions)
- **Progress Persistence:** Save partial answers (resume if interrupted)

---

## File List

### Created Files

1. **`expansion-packs/creator-os/lib/gap_analyzer.py`**
   - Core gap analysis engine
   - Analyzes COURSE-BRIEF.md completeness (8 sections)
   - Detects status indicators (🟢/🟡/🔴) for each section/subsection
   - Placeholder detection (empty vs auto-filled fields)
   - Smart question generation (skip complete, confirm partial, elicit missing)
   - Answer persistence back to COURSE-BRIEF.md
   - Final validation gate (all sections must be 🟢)
   - Question count estimation (3-15 based on completeness)

2. **`expansion-packs/creator-os/lib/elicitation_engine.py`**
   - Interactive question flow engine
   - Three-tier summary display (Complete/Confirmation/Missing)
   - Multiple question types (confirmation, multiple_choice, multiple_select, text)
   - Input validation and error handling
   - Progress tracking during elicitation
   - Before/after completeness comparison
   - User-friendly CLI interface

3. **`expansion-packs/creator-os/templates/elicitation-questions.yaml`**
   - Complete question bank for all 8 COURSE-BRIEF sections
   - 23 questions total (baseline for greenfield)
   - Question metadata (type, options, validation rules)
   - Confirmation questions for auto-filled sections
   - Elicitation questions for missing sections
   - Multiple choice/select options with descriptions

### Modified Files

1. **`expansion-packs/creator-os/tasks/generate-course.md`**
   - **Version:** 2.5 → 2.6
   - Added Step 3: Gap Analysis & Smart Elicitation (brownfield only)
   - Integrated gap_analyzer.py for completeness analysis
   - Integrated elicitation_engine.py for interactive flow
   - Added final validation gate before HALT
   - Updated changelog with Story 3.6 details

---

**Story Breakdown:**
- Investigation: 1.5 hours (research elicitation UX patterns, question design)
- Implementation: 8 hours (completeness analysis, question generation, interactive flow, persistence)
- Testing: 2.5 hours (11 unit + integration tests)
- Documentation: 1 hour
**Total Estimate:** 13 hours (13 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.3: ICP Extraction Engine](./STORY-3.3-icp-extraction-engine.md)
- [Story 3.4: Voice Extraction from Transcripts](./STORY-3.4-voice-extraction-transcripts.md)
- [Story 3.5: Learning Objectives Inference](./STORY-3.5-learning-objectives-inference.md)
- [Story 3.8: Curriculum Approval Checkpoint](./STORY-3.8-curriculum-approval-checkpoint.md)
