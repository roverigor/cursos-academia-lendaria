# Story 3.9: Lesson Generation with GPS + Didática Lendária

**Story ID:** STORY-3.9
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P0 (Critical)
**Complexity:** L (Large)
**Story Points:** 13
**Status:** 📋 Planning
**Owner:** Course Architect Agent
**Sprint:** Phase 3 - Quality

---

## User Story

**As a** course creator
**I want** lessons generated using GPS Framework + Didática Lendária principles
**So that** students experience transformational learning (not just information delivery)

---

## Business Value

### Problem
Current lesson generation produces generic, informational content:
- **Missing GPS Structure:** No clear Goal → Position → Steps flow
- **Missing Semiotic Elements:** Text-heavy, no analogies/diagrams/stories
- **Missing Transformation:** Teaches WHAT but not WHY or HOW to apply
- **Missing Engagement:** No hooks, no emotional connection, forgettable

**Example Bad Lesson:**
```markdown
# Links Internos no Obsidian

Links internos conectam notas. Use [[nota]] para criar link.

Exercício: Crie 3 links.
```

**Result:** Student completes exercise but doesn't understand WHY links matter or WHEN to use them.

### Solution Value
**GPS + Didática Lendária Integration:**
- **G (Goal):** Start with promise (what you'll achieve)
- **P (Position):** Empathy (where you are now, validate concerns)
- **S (Steps):** Technical content with analogies, diagrams, reflective questions
- **7 Elements:** Link de Transição, Revisão Estruturada, Ação Rápida
- **Dual Validation:** GPS Structure + DL Depth scoring

**Example Transformed Lesson:**
```markdown
# 4.1 - Links Internos: O Sistema Nervoso do Seu Cérebro

## G - GOAL
Ao final desta aula, você vai:
✅ Criar links internos que conectam ideias como neurônios
✅ Usar backlinks para descobrir conexões invisíveis
✅ Ter um segundo cérebro que PENSA, não apenas armazena

## P - POSITION
Eu sei... Talvez você esteja pensando: "Mais uma ferramenta de organização
que vou abandonar em 2 semanas?"

Se você já tentou Evernote, Notion, Bear... e sempre volta pro caos,
eu entendo perfeitamente. A diferença aqui é que links não são "organização" -
eles são PENSAMENTO EXTERNALIZADO.

## S - STEPS

### Por Que Links Importam (Antes do Como)

Links internos são como os neurônios do seu cérebro...
[Analogy, diagram, reflective question]

### Conceito #1: [[Sintaxe]]
[Clear instructions + visual]

🤔 Pause e pense: Qual nota você criou esta semana que conecta com algo
que você aprendeu 6 meses atrás?

### 🔗 LINK DE TRANSIÇÃO
Agora que você sabe criar links, surge a pergunta:
"Como eu descubro conexões que eu NÃO vi conscientemente?"

É aí que entram os Backlinks...

### Conceito #2: Backlinks
[Instructions + practice]

## 💡 REVISÃO ESTRUTURADA
Você entrou achando que links eram "organização".
Agora você sabe que eles são PENSAMENTO - cada link é uma sinapse digital.

## ⚡ AÇÃO RÁPIDA (2 minutos)
1. Abra uma nota qualquer
2. Escreva [[segunda nota]]
3. Clique no link (cria nota)
4. Volte - veja o backlink aparecer
✓ Funcionou? Parabéns - primeira sinapse digital criada!
```

**Impact:**
- **Completion:** +30% (students feel transformation, not boredom)
- **Retention:** +50% (semiotic elements = memorable)
- **Application:** +70% (students apply immediately, not "someday")

### Success Metrics
- ✅ 100% of lessons follow GPS structure (validated by checklist)
- ✅ 90%+ lessons score ≥70/100 on Didática Lendária rubric
- ✅ Voice fidelity ≥85% (matches instructor/MMOS persona)
- ✅ 80%+ lessons include: 1+ analogy, 1+ diagram, 2+ reflective questions

---

## Acceptance Criteria

### AC 1: Template-Based Generation

**Load GPS + 7 Elements Template:**
```python
def generate_lesson_content(lesson_spec, course_brief):
    """
    Generate lesson using GPS framework + Didática Lendária
    """
    # Load pedagogical template
    template = load_template("lesson-gps-framework.md")

    # Extract context
    course_title = course_brief["title"]
    icp = course_brief["icp"]
    voice_profile = course_brief["voice_profile"]
    learning_objectives = course_brief["learning_objectives"]

    # Build generation prompt
    generation_prompt = f"""
    You are generating a lesson for the course "{course_title}".

    **TARGET AUDIENCE (ICP):**
    {format_icp(icp)}

    **VOICE & STYLE:**
    {format_voice_profile(voice_profile)}

    **LESSON SPECIFICATION:**
    - ID: {lesson_spec['id']}
    - Title: {lesson_spec['title']}
    - Module: {lesson_spec['module']}
    - Duration: {lesson_spec['duration_minutes']} minutes
    - Learning Objectives: {lesson_spec['learning_objectives']}

    **PEDAGOGICAL FRAMEWORK:**
    {template}

    **CRITICAL REQUIREMENTS:**
    1. Follow GPS structure exactly (Goal → Position → Steps)
    2. Include all 7 Elements (Hook, Conceitos, Link Transição, Revisão, Ação Rápida, etc.)
    3. Use voice profile naturally (tone, recurring phrases, teaching style)
    4. Include minimum: 1 analogy, 1 diagram description, 2 reflective questions
    5. Maintain instructor authenticity (not generic AI voice)

    Generate the complete lesson content in Markdown format.
    """

    # Generate with AI
    lesson_content = ai_client.generate(generation_prompt, temperature=0.7)

    return lesson_content
```

**Validation:**
- [ ] Loads `lesson-gps-framework.md` template
- [ ] Injects ICP, voice profile, learning objectives
- [ ] Includes lesson spec (title, duration, objectives)
- [ ] Prompt explicitly requires GPS + 7 Elements
- [ ] Prompt specifies minimum semiotic elements
- [ ] Uses appropriate temperature (0.7 for creativity + structure)

---

### AC 2: Voice Profile Injection

**3 Voice Sources (Priority Order):**
```python
def load_voice_profile_for_generation(course_brief):
    """
    Load voice profile with priority:
    1. MMOS persona (if enabled)
    2. Transcript extraction (if available)
    3. Manual definition (from COURSE-BRIEF)
    """
    mmos_config = course_brief.get("mmos_persona", {})

    if mmos_config.get("enabled"):
        # Priority 1: Load full MMOS system prompt
        system_prompt_path = mmos_config["system_prompt_path"]
        mmos_prompt = read_file(system_prompt_path)

        return {
            "source": "mmos",
            "prompt_injection": mmos_prompt,
            "voice_data": course_brief["voice_profile"]
        }

    elif course_brief["voice_profile"].get("source") == "transcripts":
        # Priority 2: Use transcript-extracted voice
        voice_data = course_brief["voice_profile"]

        voice_injection = f"""
        INSTRUCTOR VOICE PROFILE (from transcript analysis):

        Name: {voice_data['instructor_name']}
        Greeting: "{voice_data['signature_greeting']}"
        Tone: {voice_data['tone']}
        Style: {voice_data['style']}

        Recurring Phrases (use naturally):
        {format_phrases(voice_data['recurring_phrases'])}

        Teaching Approach:
        {format_teaching_approach(voice_data['teaching_approach'])}
        """

        return {
            "source": "transcripts",
            "prompt_injection": voice_injection,
            "voice_data": voice_data
        }

    else:
        # Priority 3: Manual voice definition
        voice_data = course_brief["voice_profile"]

        voice_injection = f"""
        INSTRUCTOR VOICE PROFILE (manually defined):

        Tone: {voice_data.get('tone', 'Professional, clear')}
        Style: {voice_data.get('style', 'Structured, practical')}
        """

        return {
            "source": "manual",
            "prompt_injection": voice_injection,
            "voice_data": voice_data
        }
```

**Validation:**
- [ ] MMOS persona loads full system prompt (if enabled)
- [ ] Transcript voice uses extracted patterns (if available)
- [ ] Manual voice uses COURSE-BRIEF data (fallback)
- [ ] Voice injection formatted clearly for AI model
- [ ] Recurring phrases presented for natural incorporation

---

### AC 3: Progress Tracking

**Real-Time Progress Display:**
```
🎬 GENERATING COURSE: Dominando Obsidian

Progress: ████████░░░░░░░░░░░░░░ 8/22 lessons (36%)

══════════════════════════════════════════════════════════

✅ 1.1 - Por Que Segundo Cérebro (completed in 47s)
✅ 1.2 - Por Que Obsidian (completed in 52s)
✅ 1.3 - Instalação Multi-Plataforma (completed in 1m 15s)
✅ 1.4 - Configurações Essenciais (completed in 43s)
✅ 2.1 - Markdown Essencial (completed in 1m 8s)
✅ 2.2 - Tipos de Notas (completed in 56s)
✅ 2.3 - Arquivos e Anexos (completed in 49s)
🔄 3.1 - Pastas Minimalistas (generating... 23s elapsed)
⏳ 3.2 - Tags e Hierarquias (queued)
⏳ 3.3 - Properties (queued)
⏳ 4.1 - Links Internos (queued)
⏳ 4.2 - Backlinks (queued)
...

══════════════════════════════════════════════════════════

📊 STATISTICS:
   Avg time per lesson: 54s
   Estimated completion: 18 minutes
   Estimated total cost: $12.50

══════════════════════════════════════════════════════════
```

**Implementation:**
```python
def generate_all_lessons_with_progress(course_slug, curriculum, course_brief):
    """
    Generate all lessons sequentially with live progress updates
    """
    all_lessons = flatten_curriculum_to_lesson_list(curriculum)
    total_count = len(all_lessons)

    completed = []
    failed = []
    start_time = time.time()

    for i, lesson_spec in enumerate(all_lessons, start=1):
        # Update progress display
        update_progress_display(
            current=i,
            total=total_count,
            completed=completed,
            current_lesson=lesson_spec,
            elapsed_time=time.time() - start_time
        )

        # Generate lesson
        try:
            lesson_start = time.time()

            lesson_content = generate_lesson_content(lesson_spec, course_brief)

            # Write to file
            lesson_path = f"outputs/courses/{course_slug}/lessons/{lesson_spec['id']}-{lesson_spec['slug']}.md"
            write_file(lesson_path, lesson_content)

            lesson_duration = time.time() - lesson_start

            completed.append({
                "id": lesson_spec["id"],
                "title": lesson_spec["title"],
                "duration": lesson_duration,
                "path": lesson_path
            })

            logger.info(f"✅ Generated {lesson_spec['id']} in {lesson_duration:.1f}s")

        except Exception as e:
            logger.error(f"❌ Failed to generate {lesson_spec['id']}: {e}")

            failed.append({
                "id": lesson_spec["id"],
                "title": lesson_spec["title"],
                "error": str(e)
            })

            # Don't stop - continue to next lesson
            continue

    # Final summary
    display_generation_summary(completed, failed, start_time)

    return {
        "completed": completed,
        "failed": failed,
        "total_time": time.time() - start_time
    }
```

**Validation:**
- [ ] Progress bar updates in real-time
- [ ] Shows completed lessons with ✅ and duration
- [ ] Shows current lesson with 🔄 and elapsed time
- [ ] Shows queued lessons with ⏳
- [ ] Calculates and displays estimates (time, cost)
- [ ] Continues to next lesson on failure (doesn't abort)

---

### AC 4: File Naming Convention

**Canonical Structure:**
```
outputs/courses/{course_slug}/lessons/
├── 1.1-por-que-segundo-cerebro.md
├── 1.2-por-que-obsidian.md
├── 1.3-instalacao-multi-plataforma.md
├── 1.4-configuracoes-essenciais.md
├── 2.1-markdown-essencial.md
├── 2.2-tipos-de-notas.md
└── ...

NOT:
❌ modulo-1/aula-1.md (folder-based)
❌ 01-01-por-que-segundo-cerebro.md (zero-padded)
❌ M1L1-por-que-segundo-cerebro.md (wrong format)
```

**Naming Function:**
```python
def generate_lesson_filename(lesson_spec):
    """
    Generate canonical filename: {module}.{lesson}-{slug}.md
    """
    module_num = lesson_spec["module_number"]
    lesson_num = lesson_spec["lesson_number"]
    slug = lesson_spec["slug"]

    # Format: M.L-slug.md (e.g., 1.1-intro.md, 2.3-advanced.md)
    filename = f"{module_num}.{lesson_num}-{slug}.md"

    return filename

# Validation rules:
# - NO zero-padding (1.1, not 01.01)
# - Dot separator between module and lesson
# - Dash separator before slug
# - Slug is kebab-case (lowercase, hyphens)
# - .md extension
```

**Validation:**
- [ ] Filenames use `M.L-slug.md` format
- [ ] No zero-padding (1.1 not 01.01)
- [ ] No folder structure (flat lessons/ directory)
- [ ] Slug is kebab-case (lowercase, hyphens only)
- [ ] Validation rejects incorrect formats

---

### AC 5: Error Handling & Retry Logic

**Retry Strategy:**
```python
def generate_lesson_with_retry(lesson_spec, course_brief, max_retries=2):
    """
    Generate lesson with automatic retry on failure
    """
    for attempt in range(max_retries + 1):
        try:
            logger.info(f"Generating {lesson_spec['id']} (attempt {attempt + 1}/{max_retries + 1})")

            lesson_content = generate_lesson_content(lesson_spec, course_brief)

            # Validation: Not empty, has minimum structure
            if not validate_lesson_content(lesson_content):
                raise LessonValidationError("Generated content is incomplete")

            return lesson_content

        except (APIError, TimeoutError, LessonValidationError) as e:
            if attempt < max_retries:
                logger.warning(f"Retry {attempt + 1}/{max_retries}: {e}")
                time.sleep(2 ** attempt)  # Exponential backoff: 1s, 2s
                continue
            else:
                logger.error(f"Failed after {max_retries + 1} attempts: {e}")
                raise

def validate_lesson_content(content):
    """
    Quick validation: Ensure generated content is not empty or malformed
    """
    if not content or len(content) < 500:
        return False  # Too short

    # Check for minimum sections (GPS structure)
    has_goal = "## G" in content or "## 🎯" in content
    has_position = "## P" in content or "## 🗺️" in content
    has_steps = "## S" in content or "###" in content

    return has_goal or has_position or has_steps  # At least one section
```

**Validation:**
- [ ] Retries up to 2 times on failure
- [ ] Exponential backoff between retries (1s, 2s)
- [ ] Validates generated content is not empty
- [ ] Logs retry attempts
- [ ] After max retries, marks lesson as failed (continues to next)

---

### AC 6: Completion Summary

**Final Report:**
```
════════════════════════════════════════════════════════════
✅ COURSE GENERATION COMPLETE!
════════════════════════════════════════════════════════════

Course: Dominando Obsidian
Generated: 22/22 lessons (100%)
Total time: 24 minutes 18 seconds
Total cost: $13.75

════════════════════════════════════════════════════════════

📂 OUTPUT FILES:

Course Brief:
  outputs/courses/dominando-obsidian/COURSE-BRIEF.md

Curriculum:
  outputs/courses/dominando-obsidian/curriculum.yaml

Lessons (22 files):
  outputs/courses/dominando-obsidian/lessons/
  ├── 1.1-por-que-segundo-cerebro.md
  ├── 1.2-por-que-obsidian.md
  ...
  └── 6.4-fluxo-completo.md

════════════════════════════════════════════════════════════

📊 QUALITY METRICS:

Voice Fidelity: 92% ✅ (target: 85%+)
GPS Compliance: 100% ✅ (all lessons follow structure)
Avg Lesson Length: 1,847 words

════════════════════════════════════════════════════════════

🎯 NEXT STEPS:

1. Review generated lessons for quality:
   → Open: outputs/courses/dominando-obsidian/lessons/

2. Run validation checks:
   → *validate-course dominando-obsidian

3. Generate assessments (quizzes + projects):
   → *generate-assessments dominando-obsidian

4. Export to LMS (if needed):
   → *export-course dominando-obsidian --format scorm

════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Shows completion status (X/Y lessons)
- [ ] Shows total time and cost
- [ ] Lists output files and paths
- [ ] Shows quality metrics (voice fidelity, GPS compliance)
- [ ] Provides next steps with commands
- [ ] Handles partial completion (if some lessons failed)

---

### AC 7: Partial Completion Handling

**Scenario: 20/22 Lessons Succeeded, 2 Failed:**
```
⚠️  COURSE GENERATION PARTIALLY COMPLETE

Generated: 20/22 lessons (91%)
Failed: 2 lessons

════════════════════════════════════════════════════════════

❌ FAILED LESSONS:

1. 4.3 - Graph View
   Error: API timeout after 3 retries
   Action: Retry with: *generate-lesson dominando-obsidian 4.3

2. 6.2 - AI Summarization
   Error: Content validation failed (too short)
   Action: Retry with: *generate-lesson dominando-obsidian 6.2

════════════════════════════════════════════════════════════

✅ SUCCESSFULLY GENERATED (20 lessons):
   [List of completed lessons]

════════════════════════════════════════════════════════════

→ To retry failed lessons:
  *retry-failed-lessons dominando-obsidian

→ To continue without them (mark course as incomplete):
  *mark-course-incomplete dominando-obsidian

════════════════════════════════════════════════════════════
```

**Validation:**
- [ ] Distinguishes completed vs. failed lessons
- [ ] Lists failed lessons with specific errors
- [ ] Provides retry command for each failed lesson
- [ ] Offers bulk retry option
- [ ] Doesn't mark course as "complete" if failures exist

---

### AC 8: GPS + DL Validation (Post-Generation)

**Automated Validation:**
```python
def validate_lesson_gps_dl_compliance(lesson_content):
    """
    Validate lesson follows GPS + Didática Lendária principles
    """
    validation_report = {
        "gps_structure": validate_gps_structure(lesson_content),
        "seven_elements": validate_seven_elements(lesson_content),
        "semiotic_elements": validate_semiotic_elements(lesson_content),
        "voice_fidelity": None,  # Requires MMOS benchmark (optional)
        "overall_score": 0
    }

    # GPS Structure Check (30 points)
    gps_score = validation_report["gps_structure"]["score"]

    # 7 Elements Check (40 points)
    seven_elements_score = validation_report["seven_elements"]["score"]

    # Semiotic Elements Check (30 points)
    semiotic_score = validation_report["semiotic_elements"]["score"]

    # Overall score (out of 100)
    validation_report["overall_score"] = gps_score + seven_elements_score + semiotic_score

    # Pass threshold: 70/100
    validation_report["passed"] = validation_report["overall_score"] >= 70

    return validation_report

def validate_gps_structure(content):
    """
    Check for G-P-S sections
    """
    has_goal = bool(re.search(r"##\s*(G|GOAL|🎯)", content, re.IGNORECASE))
    has_position = bool(re.search(r"##\s*(P|POSITION|🗺️)", content, re.IGNORECASE))
    has_steps = bool(re.search(r"##\s*(S|STEPS|🛤️)", content, re.IGNORECASE))

    score = 0
    if has_goal: score += 10
    if has_position: score += 10
    if has_steps: score += 10

    return {
        "has_goal": has_goal,
        "has_position": has_position,
        "has_steps": has_steps,
        "score": score,
        "max_score": 30
    }
```

**Validation:**
- [ ] Checks GPS structure (G, P, S sections)
- [ ] Checks 7 Elements (Link Transição, Revisão, Ação Rápida)
- [ ] Checks semiotic elements (analogies, diagrams, questions)
- [ ] Calculates overall score (0-100)
- [ ] Pass threshold: 70/100
- [ ] Logs validation results for audit

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/lesson_generator.py`
   ```python
   class LessonGenerator:
       def __init__(self, course_slug, curriculum, course_brief):
           self.course_slug = course_slug
           self.curriculum = curriculum
           self.course_brief = course_brief
           self.template = load_template("lesson-gps-framework.md")

       def generate_all_lessons(self) -> GenerationResult:
           """Generate all lessons with progress tracking"""
           pass

       def generate_single_lesson(self, lesson_spec) -> str:
           """Generate one lesson with retry logic"""
           pass

       def build_generation_prompt(self, lesson_spec) -> str:
           """Construct AI prompt with context"""
           pass

       def load_voice_profile(self) -> VoiceProfile:
           """Load voice (MMOS > Transcripts > Manual)"""
           pass

       def validate_lesson_content(self, content: str) -> bool:
           """Quick validation of generated content"""
           pass

       def display_progress(self, completed, total, current_lesson):
           """Real-time progress display"""
           pass

       def display_completion_summary(self, results: GenerationResult):
           """Final report"""
           pass
   ```

2. **New Module:** `expansion-packs/creator-os/lib/gps_dl_validator.py`
   ```python
   class GPSDLValidator:
       def __init__(self, validation_checklist_path):
           self.checklist = load_yaml(validation_checklist_path)

       def validate_lesson(self, lesson_content: str) -> ValidationReport:
           """Run full GPS + DL validation"""
           pass

       def validate_gps_structure(self, content: str) -> dict:
           """Check G-P-S sections"""
           pass

       def validate_seven_elements(self, content: str) -> dict:
           """Check 7 Elements presence"""
           pass

       def validate_semiotic_elements(self, content: str) -> dict:
           """Check analogies, diagrams, questions"""
           pass

       def calculate_overall_score(self, validation_data: dict) -> int:
           """Aggregate score (0-100)"""
           pass
   ```

3. **Modified Task:** `expansion-packs/creator-os/tasks/continue-course.md`
   - Add Step 5 (after curriculum approval):
     ```markdown
     ### Step 5: Lesson Generation

     1. Load curriculum and course brief
     2. Initialize LessonGenerator
     3. Generate all lessons sequentially:
        - Load voice profile (MMOS > Transcripts > Manual)
        - For each lesson:
          - Build generation prompt (template + context)
          - Generate with AI (retry up to 2 times)
          - Validate content (not empty, has structure)
          - Write to lessons/{M.L-slug}.md
          - Update progress display
     4. Display completion summary
     5. If failures: Show failed lessons + retry commands
     6. Run GPS + DL validation on sample lessons (optional)
     ```

---

## Definition of Done

- [ ] All 8 Acceptance Criteria met
- [ ] Lesson Generator module implemented
- [ ] GPS + DL Validator module implemented
- [ ] Template loading and injection working
- [ ] Voice profile priority (MMOS > Transcripts > Manual) working
- [ ] Progress tracking displays correctly
- [ ] File naming convention enforced
- [ ] Retry logic functional
- [ ] Completion summary generated
- [ ] Partial completion handling tested
- [ ] GPS + DL validation scoring implemented
- [ ] Integration with `continue-course` task complete
- [ ] Unit tests: Generation prompt building (3 test cases)
- [ ] Unit tests: Voice profile loading (3 test cases for each source)
- [ ] Unit tests: File naming (5 test cases)
- [ ] Unit tests: Retry logic (3 test cases)
- [ ] Integration test: End-to-end lesson generation (full course)
- [ ] Integration test: GPS + DL validation on generated lessons
- [ ] Performance: <90s per lesson on average
- [ ] Documentation updated (how lesson generation works)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.6: Gap Analysis (brief must be complete)
- Story 3.7: MMOS Persona Integration (if MMOS voice used)
- Story 3.8: Curriculum Approval (must be approved first)

**Downstream:**
- Story 3.12: Validation & Quality Checks (validates generated lessons)

---

## Testing Strategy

### Unit Tests

**Test 1: Voice Profile Loading - MMOS Priority**
```python
def test_load_voice_mmos_priority():
    course_brief = {
        "mmos_persona": {"enabled": True, "system_prompt_path": "outputs/minds/test/system_prompts/generalista.md"},
        "voice_profile": {"source": "transcripts", "tone": "Casual"}  # Should be ignored
    }

    voice = load_voice_profile_for_generation(course_brief)

    assert voice["source"] == "mmos"
    assert "generalista" in voice["prompt_injection"]
```

**Test 2: Voice Profile Loading - Transcript Fallback**
```python
def test_load_voice_transcript_fallback():
    course_brief = {
        "mmos_persona": {"enabled": False},
        "voice_profile": {"source": "transcripts", "tone": "Warm", "recurring_phrases": ["Tá?"]}
    }

    voice = load_voice_profile_for_generation(course_brief)

    assert voice["source"] == "transcripts"
    assert "Tá?" in voice["prompt_injection"]
```

**Test 3: File Naming Convention**
```python
def test_generate_lesson_filename():
    lesson_spec = {"module_number": 2, "lesson_number": 3, "slug": "tags-hierarquias"}

    filename = generate_lesson_filename(lesson_spec)

    assert filename == "2.3-tags-hierarquias.md"
```

**Test 4: Retry Logic - Success on Second Attempt**
```python
def test_retry_logic_success_second_attempt():
    # Mock: Fail first, succeed second
    mock_ai = MockAIClient(fail_count=1)

    lesson_content = generate_lesson_with_retry(lesson_spec, course_brief, max_retries=2)

    assert lesson_content is not None
    assert mock_ai.call_count == 2  # Failed once, succeeded second
```

**Test 5: GPS Validation - Pass**
```python
def test_gps_validation_pass():
    lesson_content = """
    ## G - GOAL
    You will learn X...

    ## P - POSITION
    I know you might be thinking...

    ## S - STEPS
    Step 1: Do this...
    """

    validation = validate_gps_structure(lesson_content)

    assert validation["has_goal"] is True
    assert validation["has_position"] is True
    assert validation["has_steps"] is True
    assert validation["score"] == 30  # Full score
```

**Test 6: GPS Validation - Fail (Missing Position)**
```python
def test_gps_validation_fail_missing_position():
    lesson_content = """
    ## G - GOAL
    You will learn X...

    ## S - STEPS
    Step 1: Do this...
    """

    validation = validate_gps_structure(lesson_content)

    assert validation["has_goal"] is True
    assert validation["has_position"] is False  # Missing
    assert validation["score"] == 20  # Partial score
```

### Integration Tests

**Test 7: End-to-End Lesson Generation**
```python
def test_e2e_lesson_generation():
    # Setup: Complete course (brief, curriculum)
    course_slug = "test-course-generation"
    curriculum = load_yaml("test-data/curriculum-sample.yaml")
    course_brief = load_yaml("test-data/course-brief-sample.yaml")

    # Generate all lessons
    generator = LessonGenerator(course_slug, curriculum, course_brief)
    results = generator.generate_all_lessons()

    # Assert
    assert len(results["completed"]) == curriculum["total_lessons"]
    assert len(results["failed"]) == 0

    # Check files exist
    for lesson in results["completed"]:
        lesson_path = f"outputs/courses/{course_slug}/lessons/{lesson['id']}-{lesson['slug']}.md"
        assert os.path.exists(lesson_path)

        # Validate content
        content = read_file(lesson_path)
        assert len(content) >= 500  # Not empty
```

**Test 8: GPS + DL Validation on Generated Lessons**
```python
def test_gps_dl_validation_generated_lessons():
    # Generate sample lesson
    lesson_spec = {"id": "1.1", "title": "Test Lesson", "duration_minutes": 20}
    lesson_content = generate_lesson_content(lesson_spec, course_brief)

    # Validate
    validator = GPSDLValidator("checklists/gps-lesson-validation.md")
    validation_report = validator.validate_lesson(lesson_content)

    # Should pass threshold (70/100)
    assert validation_report["overall_score"] >= 70
    assert validation_report["passed"] is True
```

**Test 9: Partial Completion Handling**
```python
def test_partial_completion_with_failures():
    # Mock: 18 lessons succeed, 2 fail
    mock_ai = MockAIClient(fail_on_lessons=["3.2", "5.4"])

    generator = LessonGenerator(course_slug, curriculum, course_brief)
    results = generator.generate_all_lessons()

    assert len(results["completed"]) == 18
    assert len(results["failed"]) == 2
    assert results["failed"][0]["id"] == "3.2"
    assert results["failed"][1]["id"] == "5.4"

    # Summary should indicate partial completion
    summary = generator.display_completion_summary(results)
    assert "PARTIALLY COMPLETE" in summary
```

---

## Open Questions

1. **Q:** Run GPS + DL validation on ALL lessons or sample only?
   **A:** v1 validates sample (3-5 lessons) for speed. v2 can add full validation option.

2. **Q:** Allow user to edit lessons during generation (pause & edit)?
   **A:** Out of scope for v1. Generate all, then edit. v2 could add interactive mode.

3. **Q:** Parallelize lesson generation (multiple AI calls simultaneously)?
   **A:** Out of scope for v1 (sequential is simpler). v2 could add parallel generation.

---

## Future Enhancements

- **Parallel Generation:** Generate multiple lessons simultaneously (10x faster)
- **Interactive Editing:** Pause generation, edit lesson, resume
- **Full GPS + DL Validation:** Validate ALL lessons, not just samples
- **Adaptive Templates:** Adjust template based on lesson type (concept vs. hands-on)
- **A/B Testing:** Generate 2 versions per lesson, let creator choose
- **Voice Fidelity Tuning:** Real-time adjustment of voice parameters

---

**Story Breakdown:**
- Investigation: 1.5 hours (test GPS template with AI, tune prompts)
- Implementation: 8 hours (generator, voice loading, progress tracking, validation, retry logic)
- Testing: 2.5 hours (9 unit + integration tests)
- Documentation: 1 hour
**Total Estimate:** 13 hours (13 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [GPS Framework Template](../templates/lesson-gps-framework.md)
- [Didática Lendária Checklist](../checklists/didatica-lendaria-validation.md)
- [Story 3.6: Gap Analysis & Smart Elicitation](./STORY-3.6-gap-analysis-smart-elicitation.md)
- [Story 3.7: MMOS Persona Integration](./STORY-3.7-mmos-persona-integration.md)
- [Story 3.8: Curriculum Approval Checkpoint](./STORY-3.8-curriculum-approval-checkpoint.md)
- [Story 3.12: Validation & Quality Checks](./STORY-3.12-validation-quality-checks.md)
