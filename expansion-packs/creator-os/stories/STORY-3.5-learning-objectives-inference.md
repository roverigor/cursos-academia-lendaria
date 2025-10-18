# Story 3.5: Learning Objectives Inference Engine

**Story ID:** STORY-3.5
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P1 (High)
**Complexity:** M (Medium)
**Story Points:** 8
**Status:** ✅ Complete
**Owner:** Course Architect Agent
**Sprint:** Phase 2 - Intelligence
**Completed:** 2025-10-18

---

## User Story

**As a** course creator with legacy lesson materials
**I want** the system to infer learning objectives from existing content
**So that** I have a pedagogically-sound starting point instead of blank fields

---

## Business Value

### Problem
Course creators have existing lessons but no formal learning objectives:
- Legacy lessons with titles like "Aula 5 - Tags no Obsidian"
- Video lessons with descriptive names but no stated outcomes
- Workshop materials focused on "what" not "learning goals"

**Current Pain:**
- Must write learning objectives from scratch (~20-40 minutes)
- Easy to write vague objectives ("understand X")
- Risk of misalignment (objectives don't match actual content)
- Requires pedagogical expertise (Bloom's Taxonomy knowledge)

**Result:** Objectives written poorly or skipped entirely

### Solution Value
**Intelligent Objective Inference:**
- Analyzes legacy lesson titles and content structure
- Maps to Bloom's Taxonomy action verbs automatically
- Generates draft objectives aligned with actual lesson content
- Provides pedagogically-sound starting point for review

**Impact:**
- **Time Saved:** 20-40 min per course (80% reduction in objective creation time)
- **Quality:** Objectives follow Bloom's Taxonomy (pedagogically valid)
- **Alignment:** Inferred from actual content (not generic guesses)
- **Education:** System teaches creators about good learning objectives

### Success Metrics
- ✅ 70%+ of inferred objectives approved without edits
- ✅ 100% of objectives use Bloom's Taxonomy action verbs
- ✅ 90%+ alignment between objectives and lesson content
- ✅ Creator time savings ≥80% vs. writing from scratch

---

## Acceptance Criteria

### AC 1: Legacy Lesson Analysis

**File Discovery:**
```python
def find_legacy_lessons(course_folder):
    """
    Detect existing lesson files to infer content structure
    """
    search_paths = [
        f"{course_folder}/legado/",
        f"{course_folder}/lessons/",
        f"{course_folder}/"
    ]

    # Patterns for lesson files
    patterns = [
        "*.md",  # Markdown lessons
        "*aula*.md",  # Portuguese naming
        "*lesson*.md",  # English naming
        "*modulo*.md"  # Module files
    ]

    # Content validation: Must have lesson-like structure
    lesson_markers = [
        "##",  # Has headers (structured content)
        "objetivo", "goal", "learning",  # Explicit objectives
        "exercício", "prática", "exercise"  # Practice sections
    ]

    return validated_lessons
```

**Title/Filename Pattern Extraction:**
```python
def extract_lesson_intent(filename, content_sample=None):
    """
    Extract pedagogical intent from filename and content
    """
    # Clean filename
    title = clean_lesson_title(filename)
    # Examples:
    #   "aula-5-tags-obsidian.md" → "Tags Obsidian"
    #   "1.3-instalacao-multi-plataforma.md" → "Instalação Multi Plataforma"
    #   "workshop-links-internos.md" → "Workshop Links Internos"

    # Detect content type from title keywords
    content_type = classify_content_type(title)
    # Types: installation, concept, workshop, why-use, troubleshooting

    return {
        "title": title,
        "content_type": content_type,
        "filename": filename
    }
```

**Validation:**
- [ ] Searches `/legado/`, `/lessons/`, root folder
- [ ] Detects Markdown lesson files
- [ ] Extracts clean titles from filenames
- [ ] Classifies content type (installation, concept, workshop, etc.)
- [ ] Handles Portuguese and English naming conventions

---

### AC 2: Pattern Matching to Learning Objectives

**Pedagogical Pattern Library:**
```yaml
# expansion-packs/creator-os/templates/pedagogical-patterns.yaml

patterns:
  installation:
    keywords: ["instalação", "install", "setup", "configuração", "config"]
    bloom_level: "Apply"
    objective_template: "Install and configure {tool} successfully on {platform}"
    variations:
      - "Set up {tool} from scratch"
      - "Configure {tool} for {use_case}"

  concept_explanation:
    keywords: ["conceitos", "concepts", "introdução", "intro", "o que é", "what is"]
    bloom_level: "Understand"
    objective_template: "Explain the core concepts of {topic}"
    variations:
      - "Understand the fundamentals of {topic}"
      - "Describe how {topic} works"
      - "Interpret {topic} in context"

  hands_on_practice:
    keywords: ["workshop", "prática", "practice", "hands-on", "exercício", "lab"]
    bloom_level: "Apply"
    objective_template: "Apply {skill} to a real-world scenario"
    variations:
      - "Use {tool} to solve {problem}"
      - "Implement {technique} in practice"
      - "Execute {workflow} successfully"

  why_use:
    keywords: ["por que", "why use", "benefícios", "benefits", "vantagens"]
    bloom_level: "Evaluate"
    objective_template: "Evaluate the benefits and trade-offs of {tool}"
    variations:
      - "Compare {option_a} vs {option_b}"
      - "Justify when to use {approach}"
      - "Assess the value of {technique}"

  troubleshooting:
    keywords: ["troubleshooting", "debug", "resolver", "fix", "problemas", "errors"]
    bloom_level: "Analyze"
    objective_template: "Troubleshoot common issues with {tool}"
    variations:
      - "Diagnose {type_of_problem}"
      - "Debug {error_category}"
      - "Resolve {specific_issue}"

  advanced_technique:
    keywords: ["avançado", "advanced", "pro", "expert", "otimização", "optimization"]
    bloom_level: "Create"
    objective_template: "Develop advanced {technique} workflows"
    variations:
      - "Design optimized {process}"
      - "Build custom {solution}"
      - "Create {deliverable} from scratch"
```

**Matching Algorithm:**
```python
def infer_objective_from_lesson(lesson_data, patterns_library):
    """
    Match lesson to pedagogical pattern and generate objective
    """
    title = lesson_data["title"]
    content_type = lesson_data["content_type"]

    # Find matching pattern
    pattern = patterns_library.get(content_type, patterns_library["concept_explanation"])

    # Extract entities from title (tool, topic, platform, etc.)
    entities = extract_entities(title)
    # Example: "Instalação Multi-Plataforma Obsidian"
    #   → {tool: "Obsidian", platform: "Multi-Plataforma"}

    # Fill template
    objective_text = pattern["objective_template"].format(**entities)

    return {
        "objective": objective_text,
        "bloom_level": pattern["bloom_level"],
        "source_lesson": lesson_data["filename"],
        "confidence": calculate_match_confidence(title, pattern)
    }
```

**Validation:**
- [ ] Pattern library covers 6 common lesson types
- [ ] Matches lesson title to pattern using keyword detection
- [ ] Extracts entities (tool names, topics, platforms) from title
- [ ] Fills objective template with extracted entities
- [ ] Returns Bloom's Taxonomy level for each objective
- [ ] Calculates confidence score (0-100%)

---

### AC 3: Bloom's Taxonomy Mapping

**Taxonomy Levels & Action Verbs:**
```yaml
blooms_taxonomy:
  remember:
    level: 1
    description: "Recall facts and basic concepts"
    action_verbs:
      - Identify
      - Recall
      - List
      - Recognize
      - Name
      - Define

  understand:
    level: 2
    description: "Explain ideas or concepts"
    action_verbs:
      - Explain
      - Summarize
      - Describe
      - Interpret
      - Classify
      - Compare

  apply:
    level: 3
    description: "Use information in new situations"
    action_verbs:
      - Use
      - Implement
      - Execute
      - Apply
      - Solve
      - Demonstrate

  analyze:
    level: 4
    description: "Draw connections among ideas"
    action_verbs:
      - Analyze
      - Compare
      - Contrast
      - Examine
      - Troubleshoot
      - Evaluate

  evaluate:
    level: 5
    description: "Justify a decision or course of action"
    action_verbs:
      - Evaluate
      - Justify
      - Assess
      - Critique
      - Defend
      - Judge

  create:
    level: 6
    description: "Produce new or original work"
    action_verbs:
      - Create
      - Design
      - Develop
      - Build
      - Construct
      - Formulate
```

**Objective Validation:**
```python
def validate_objective_bloom(objective_text):
    """
    Ensure objective starts with Bloom's action verb
    """
    first_word = objective_text.split()[0].lower()

    # Check if starts with valid action verb
    all_action_verbs = get_all_bloom_verbs()

    if first_word not in all_action_verbs:
        # Fix: Suggest closest verb or default to "Understand"
        suggested_verb = suggest_bloom_verb(objective_text)
        objective_text = f"{suggested_verb} {objective_text}"

    return objective_text
```

**Validation:**
- [ ] All objectives start with Bloom's action verbs
- [ ] Objectives mapped to correct Bloom's level
- [ ] Validation function corrects non-compliant objectives
- [ ] Provides taxonomy level explanation (educational value)

---

### AC 4: Multi-Lesson Aggregation

**Course-Level Objective Synthesis:**
```python
def synthesize_course_objectives(lesson_objectives):
    """
    Aggregate 10-50 lesson objectives into 3-5 course-level objectives
    """
    # Group by Bloom's level
    by_bloom_level = group_by_bloom_level(lesson_objectives)

    # Select highest-level objectives (prefer Apply, Analyze, Evaluate, Create)
    high_level = filter_high_bloom(by_bloom_level)

    # Cluster semantically similar objectives
    clusters = semantic_clustering(high_level)
    # Example clusters:
    #   - "Obsidian Installation & Setup" (3 lessons → 1 objective)
    #   - "Knowledge Organization Systems" (8 lessons → 1 objective)
    #   - "AI Integration for Productivity" (4 lessons → 1 objective)

    # Generate course-level objective per cluster
    course_objectives = []
    for cluster in clusters:
        synthesized = synthesize_cluster(cluster)
        course_objectives.append(synthesized)

    # Sort by Bloom's level (progression from Understand → Create)
    course_objectives.sort(key=lambda obj: obj["bloom_level"])

    return course_objectives[:5]  # Max 5 course objectives
```

**Example Output:**
```yaml
inferred_objectives:
  - level: "Apply"
    objective: "Build a functional second brain in Obsidian for knowledge management"
    source_lessons:
      - "1.3-instalacao-multi-plataforma.md"
      - "1.4-configuracoes-essenciais.md"
      - "2.1-markdown-essencial.md"
    confidence: 85

  - level: "Understand"
    objective: "Organize knowledge using sustainable note-taking systems"
    source_lessons:
      - "3.1-pastas-minimalistas.md"
      - "3.2-tags-hierarquias.md"
      - "3.3-properties.md"
    confidence: 78

  - level: "Apply"
    objective: "Connect ideas using bi-directional links and graph visualization"
    source_lessons:
      - "4.1-links-internos.md"
      - "4.2-backlinks.md"
      - "4.3-graph-view.md"
    confidence: 92

  - level: "Create"
    objective: "Integrate AI tools to supercharge productivity workflows"
    source_lessons:
      - "6.1-chatgpt-obsidian.md"
      - "6.2-ai-summarization.md"
      - "6.3-smart-connections.md"
    confidence: 71
```

**Validation:**
- [ ] Aggregates lesson-level insights to course-level objectives
- [ ] Generates 3-5 course objectives (not 1, not 20)
- [ ] Clusters semantically similar lessons
- [ ] Prioritizes higher Bloom's levels (Apply, Create > Remember)
- [ ] Includes source lessons for traceability
- [ ] Confidence score per objective

---

### AC 5: COURSE-BRIEF Integration

**Pre-fill Section 3.2:**
```markdown
## 3. Conteúdo e Estrutura

### 3.2 Objetivos de Aprendizagem

🟡 **Status:** Inferred from 38 legacy lessons (82% avg confidence)

**Objetivos do Curso:**

1. **Build a functional second brain in Obsidian for knowledge management**
   - Bloom's Level: Apply
   - Source: Lessons 1.3, 1.4, 2.1 (Installation & Setup)
   - Confidence: 85%

2. **Organize knowledge using sustainable note-taking systems**
   - Bloom's Level: Understand
   - Source: Lessons 3.1, 3.2, 3.3 (Organization)
   - Confidence: 78%

3. **Connect ideas using bi-directional links and graph visualization**
   - Bloom's Level: Apply
   - Source: Lessons 4.1, 4.2, 4.3 (Linking)
   - Confidence: 92%

4. **Integrate AI tools to supercharge productivity workflows**
   - Bloom's Level: Create
   - Source: Lessons 6.1, 6.2, 6.3 (AI Integration)
   - Confidence: 71%

---
📝 **Instruções:**
- These objectives were inferred from your existing lessons.
- Review for accuracy and alignment with your vision.
- Edit to refine wording or add/remove objectives.
- Ensure objectives match what students will ACTUALLY achieve.
- When satisfied, change status to ✅.

📚 **Bloom's Taxonomy Reference:**
- **Understand:** Explain, describe, summarize
- **Apply:** Use, implement, execute (hands-on)
- **Analyze:** Compare, troubleshoot, examine
- **Evaluate:** Assess, justify, critique
- **Create:** Design, build, develop (original work)
```

**Status Indicator:**
```python
def calculate_objectives_section_status(inferred_objectives):
    avg_confidence = mean([obj["confidence"] for obj in inferred_objectives])
    lesson_count = len(set(flatten([obj["source_lessons"] for obj in inferred_objectives])))

    if avg_confidence >= 80 and lesson_count >= 10:
        return "🟢"  # High confidence, good coverage
    elif avg_confidence >= 60 and lesson_count >= 5:
        return "🟡"  # Medium confidence, needs review
    else:
        return "🔴"  # Low confidence or insufficient data
```

**Validation:**
- [ ] Section 3.2 auto-populated with course objectives
- [ ] Status indicator reflects inference quality (🟡 always, since always needs review)
- [ ] Includes Bloom's level per objective
- [ ] Shows source lessons for transparency
- [ ] Confidence score per objective
- [ ] Educational instructions about Bloom's Taxonomy

---

### AC 6: Educational Annotations

**Bloom's Taxonomy Explainer:**
```markdown
## 📚 About Learning Objectives (Bloom's Taxonomy)

Good learning objectives are:
- **Measurable:** Use action verbs (Build, Explain, Create)
- **Student-focused:** What THEY will achieve (not what you'll teach)
- **Specific:** Clear outcome (not vague "understand productivity")

**Bloom's Taxonomy Levels (Lower → Higher):**

| Level | Description | When to Use |
|-------|-------------|-------------|
| **Remember** | Recall facts | Basic courses, prerequisite knowledge |
| **Understand** | Explain concepts | Conceptual lessons, theory |
| **Apply** | Use in practice | Hands-on lessons, most courses |
| **Analyze** | Troubleshoot, compare | Advanced courses, debugging |
| **Evaluate** | Justify decisions | Strategic thinking, decision-making |
| **Create** | Build original work | Capstone projects, creative courses |

**Target Distribution for Practical Courses:**
- 20% Understand
- 50% Apply (most objectives here!)
- 20% Analyze
- 10% Create

**Examples:**

❌ Bad: "Understand Obsidian" (vague, not measurable)
✅ Good: "Build a second brain system in Obsidian" (specific, measurable)

❌ Bad: "Learn about links" (passive)
✅ Good: "Connect notes using bi-directional links" (active, clear outcome)
```

**Validation:**
- [ ] Educational explainer included in COURSE-BRIEF
- [ ] Explains Bloom's Taxonomy levels
- [ ] Provides good vs. bad examples
- [ ] Suggests target distribution for practical courses
- [ ] Teaches creator pedagogical best practices

---

### AC 7: Error Handling & Edge Cases

**Edge Cases:**

1. **No legacy lessons found:**
   ```markdown
   ## 3.2 Objetivos de Aprendizagem

   🔴 **Status:** No legacy lessons found to infer objectives.

   **Instruções:**
   Define 3-5 learning objectives for your course:

   1. {Action verb} {specific outcome}
   2. {Action verb} {specific outcome}
   ...

   Refer to Bloom's Taxonomy guide above.
   ```

2. **Too few lessons (< 3):**
   ```markdown
   🟡 **Status:** Only 2 lessons found - objectives may be incomplete.

   Inferred Objectives:
   - {Objective 1}
   - {Objective 2}

   **Recommendation:** Add at least 1-2 more objectives manually to cover full course scope.
   ```

3. **Low confidence (< 50% avg):**
   ```markdown
   🔴 **Status:** Inferred from 8 lessons (38% avg confidence - LOW)

   **Warning:** Lesson titles are unclear or generic.
   Objectives below are best guesses - review carefully.

   Inferred Objectives:
   - {Objective 1} (Confidence: 45%)
   - {Objective 2} (Confidence: 31%)

   **Recommendation:** Refine these objectives based on actual course content.
   ```

4. **All lessons same type (e.g., all "concept" lessons):**
   ```markdown
   🟡 **Status:** All lessons detected as "concept explanation" type.

   **Notice:** Course appears theory-heavy (no hands-on practice detected).

   Inferred Objectives (all "Understand" level):
   - Explain {topic_1}
   - Describe {topic_2}
   ...

   **Recommendation:** Consider adding Apply/Create objectives with hands-on projects.
   ```

**Validation:**
- [ ] Gracefully handles zero lessons (template with instructions)
- [ ] Warns if too few lessons (< 3)
- [ ] Flags low confidence and explains why
- [ ] Detects imbalanced Bloom's distribution (all Understand, no Apply)
- [ ] All warnings logged to `extraction-log.md`

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/objectives_inferencer.py`
   ```python
   class ObjectivesInferencer:
       def __init__(self, course_folder):
           self.course_folder = course_folder
           self.patterns_library = load_yaml("templates/pedagogical-patterns.yaml")
           self.blooms_taxonomy = load_yaml("templates/blooms-taxonomy.yaml")

       def find_legacy_lessons(self) -> List[LessonFile]:
           """Detect existing lesson files"""
           pass

       def extract_lesson_intent(self, lesson_file: LessonFile) -> LessonIntent:
           """Extract pedagogical intent from filename/content"""
           pass

       def infer_lesson_objective(self, lesson_intent: LessonIntent) -> Objective:
           """Match to pattern and generate objective"""
           pass

       def synthesize_course_objectives(self, lesson_objectives: List[Objective]) -> List[Objective]:
           """Aggregate to 3-5 course-level objectives"""
           pass

       def validate_bloom_compliance(self, objective: Objective) -> Objective:
           """Ensure objective uses Bloom's action verb"""
           pass

       def calculate_confidence(self, objective: Objective, lesson_intent: LessonIntent) -> int:
           """Calculate inference confidence (0-100)"""
           pass

       def prefill_course_brief(self, objectives: List[Objective], brief_path: str):
           """Insert objectives into COURSE-BRIEF Section 3.2"""
           pass
   ```

2. **New Data File:** `expansion-packs/creator-os/templates/pedagogical-patterns.yaml`
   - Pattern library for lesson type → objective mapping

3. **New Data File:** `expansion-packs/creator-os/templates/blooms-taxonomy.yaml`
   - Bloom's Taxonomy levels and action verbs

4. **Modified Task:** `expansion-packs/creator-os/tasks/continue-course.md`
   - Add Step 2.7 (after voice extraction):
     ```markdown
     ### Step 2.7: Infer Learning Objectives (If Brownfield)

     If `creation_mode: brownfield`:
       1. Run Objectives Inferencer: `inferencer.find_legacy_lessons()`
       2. Extract intent from each lesson title/content
       3. Infer lesson-level objectives
       4. Synthesize to 3-5 course-level objectives
       5. Prefill COURSE-BRIEF Section 3.2
       6. Log inference results
     ```

---

## Definition of Done

- [x] All 7 Acceptance Criteria met
- [x] Objectives Inferencer module implemented (`lib/objectives_inferencer.py`)
- [x] Pedagogical patterns library created (6 patterns: `templates/pedagogical-patterns.yaml`)
- [x] Bloom's Taxonomy reference data created (`templates/blooms-taxonomy.yaml`)
- [x] Integration with `generate-course` task complete (Step 2.7 added)
- [x] Pattern matching implemented (6 patterns with keyword detection)
- [x] Bloom's validation implemented (action verb enforcement)
- [x] Aggregation logic implemented (semantic clustering by pattern)
- [x] End-to-end inference tested (dominando-obsidian course with 22 lessons)
- [x] Error handling implemented (no lessons, low confidence, imbalanced distribution)
- [x] Educational annotations included (Bloom's Taxonomy guide, examples)
- [x] Documentation complete (module docstrings, CLI interface, story updated)
- [ ] Merged to main branch (pending commit)

---

## Dependencies

**Upstream:**
- Story 3.2: File Inventory & Organization (lessons must be organized first)

**Downstream:**
- Story 3.6: Gap Analysis & Smart Elicitation (uses objectives to skip Section 3.2 questions)

---

## Testing Strategy

### Unit Tests

**Test 1: Pattern Matching - Installation**
```python
def test_pattern_match_installation():
    lesson_data = {
        "title": "Instalação Multi-Plataforma Obsidian",
        "content_type": "installation",
        "filename": "1.3-instalacao-multi-plataforma.md"
    }

    objective = infer_objective_from_lesson(lesson_data, patterns_library)

    assert objective["bloom_level"] == "Apply"
    assert "Install" in objective["objective"] or "Configure" in objective["objective"]
    assert "Obsidian" in objective["objective"]
```

**Test 2: Pattern Matching - Concept Explanation**
```python
def test_pattern_match_concept():
    lesson_data = {
        "title": "O Que São Links Internos",
        "content_type": "concept_explanation",
        "filename": "4.1-o-que-sao-links-internos.md"
    }

    objective = infer_objective_from_lesson(lesson_data, patterns_library)

    assert objective["bloom_level"] == "Understand"
    assert objective["objective"].startswith(("Explain", "Understand", "Describe"))
```

**Test 3: Pattern Matching - Workshop**
```python
def test_pattern_match_workshop():
    lesson_data = {
        "title": "Workshop: Graph View na Prática",
        "content_type": "hands_on_practice",
        "filename": "workshop-graph-view.md"
    }

    objective = infer_objective_from_lesson(lesson_data, patterns_library)

    assert objective["bloom_level"] == "Apply"
    assert "Graph View" in objective["objective"]
```

**Test 4: Bloom's Validation - Non-Compliant Objective**
```python
def test_bloom_validation_fix():
    # Objective doesn't start with action verb
    objective_text = "knowledge of Obsidian basics"

    validated = validate_objective_bloom(objective_text)

    # Should be fixed to start with Bloom's verb
    assert validated.startswith(("Understand", "Explain", "Identify"))
```

**Test 5: Aggregation - Semantic Clustering**
```python
def test_aggregation_clustering():
    lesson_objectives = [
        {"objective": "Install Obsidian on Mac", "bloom_level": "Apply"},
        {"objective": "Install Obsidian on Windows", "bloom_level": "Apply"},
        {"objective": "Configure Obsidian settings", "bloom_level": "Apply"},
        {"objective": "Explain note-taking principles", "bloom_level": "Understand"},
    ]

    course_objectives = synthesize_course_objectives(lesson_objectives)

    # Should cluster installation lessons into 1 course objective
    assert len(course_objectives) <= 2
    assert any("Install" in obj["objective"] for obj in course_objectives)
```

**Test 6: Aggregation - Max 5 Objectives**
```python
def test_aggregation_max_limit():
    # 20 diverse lesson objectives
    lesson_objectives = create_diverse_objectives(count=20)

    course_objectives = synthesize_course_objectives(lesson_objectives)

    assert len(course_objectives) <= 5
```

**Test 7: Confidence Calculation**
```python
def test_confidence_calculation():
    # High confidence: Clear pattern match
    lesson_intent = {"title": "Instalação do Obsidian", "content_type": "installation"}
    pattern = patterns_library["installation"]

    confidence = calculate_match_confidence(lesson_intent, pattern)

    assert confidence >= 80

    # Low confidence: Ambiguous title
    lesson_intent_vague = {"title": "Aula 5", "content_type": "unknown"}

    confidence_low = calculate_match_confidence(lesson_intent_vague, pattern)

    assert confidence_low < 50
```

### Integration Tests

**Test 8: End-to-End Inference**
```python
def test_e2e_objectives_inference():
    # Setup: Real course folder with 15 legacy lessons
    course_folder = "test-data/dominando-obsidian"
    create_legacy_lessons(course_folder, [
        "1.3-instalacao-obsidian.md",
        "2.1-markdown-essencial.md",
        "4.1-links-internos.md",
        # ... 12 more
    ])

    # Execute
    inferencer = ObjectivesInferencer(course_folder)
    lessons = inferencer.find_legacy_lessons()
    lesson_objectives = [inferencer.infer_lesson_objective(l) for l in lessons]
    course_objectives = inferencer.synthesize_course_objectives(lesson_objectives)

    # Generate COURSE-BRIEF
    brief_path = f"{course_folder}/COURSE-BRIEF.md"
    inferencer.prefill_course_brief(course_objectives, brief_path)

    # Assert
    brief_content = read_file(brief_path)
    assert "## 3. Conteúdo e Estrutura" in brief_content
    assert "### 3.2 Objetivos de Aprendizagem" in brief_content
    assert len(course_objectives) >= 3
    assert len(course_objectives) <= 5
    assert all(obj["bloom_level"] in ["Understand", "Apply", "Analyze", "Evaluate", "Create"]
               for obj in course_objectives)
```

**Test 9: No Lessons Graceful Fallback**
```python
def test_no_lessons_fallback():
    course_folder = create_test_course("test-no-lessons")
    # No lesson files

    inferencer = ObjectivesInferencer(course_folder)
    lessons = inferencer.find_legacy_lessons()
    assert len(lessons) == 0

    # Generate brief with template
    brief_path = f"{course_folder}/COURSE-BRIEF.md"
    inferencer.prefill_course_brief([], brief_path)

    brief_content = read_file(brief_path)
    assert "🔴 **Status:** No legacy lessons found" in brief_content
```

**Test 10: Imbalanced Bloom's Distribution Warning**
```python
def test_imbalanced_blooms_warning():
    # All lessons are "Understand" level
    lesson_objectives = [
        {"objective": "Explain X", "bloom_level": "Understand"},
        {"objective": "Describe Y", "bloom_level": "Understand"},
        {"objective": "Summarize Z", "bloom_level": "Understand"},
    ]

    # Should detect imbalance and warn
    with assert_logs_warning("theory-heavy"):
        course_objectives = synthesize_course_objectives(lesson_objectives)
```

---

## Open Questions

1. **Q:** Use AI (GPT) to generate objectives instead of pattern matching?
   **A:** v1 uses patterns (fast, cheap, predictable). v2 could add AI fallback for complex titles.

2. **Q:** Analyze lesson content (not just title) for more accurate inference?
   **A:** Out of scope for v1 (requires full content parsing). Title-based is 70-80% accurate.

3. **Q:** Support languages beyond Portuguese and English?
   **A:** v1 supports PT/EN. v2 could extend patterns to Spanish, French, etc.

4. **Q:** Validate objectives against actual lesson content automatically?
   **A:** Out of scope for v1. v2 could use AI to check alignment.

---

## Future Enhancements

- **AI-Powered Inference:** Use GPT to analyze full lesson content for objectives
- **Alignment Validation:** Automatically check if objectives match lesson content
- **Multi-Language Support:** Extend patterns to Spanish, French, German
- **Custom Patterns:** Allow creator to define custom pedagogical patterns
- **Bloom's Level Recommendation:** Suggest ideal Bloom's distribution for course type
- **Prerequisite Detection:** Infer prerequisite knowledge from lesson sequence

---

**Story Breakdown:**
- Investigation: 1 hour (research Bloom's Taxonomy, pedagogical patterns)
- Implementation: 5 hours (pattern matching, aggregation, Bloom's validation)
- Testing: 1.5 hours (10 unit + integration tests)
- Documentation: 0.5 hour
**Total Estimate:** 8 hours (8 story points)

---

## Files Created/Modified

### New Files Created

1. **`expansion-packs/creator-os/lib/objectives_inferencer.py`** (850 lines)
   - Core ObjectivesInferencer class
   - Lesson file discovery with filename pattern matching
   - Content type classification (6 patterns)
   - Pedagogical intent extraction from titles
   - Entity extraction (tool, topic, platform, use_case)
   - Bloom's Taxonomy classification and validation
   - Multi-lesson aggregation to 3-5 course objectives
   - Semantic clustering by lesson pattern
   - Confidence scoring (0-100%)
   - COURSE-BRIEF Section 3.2 auto-population
   - Educational annotations generator
   - CLI interface for testing
   - Comprehensive error handling

2. **`expansion-packs/creator-os/templates/pedagogical-patterns.yaml`** (220 lines)
   - 6 lesson type patterns:
     - installation (Apply level)
     - concept_explanation (Understand level)
     - hands_on_practice (Apply level)
     - why_use (Evaluate level)
     - troubleshooting (Analyze level)
     - advanced_technique (Create level)
   - Keywords for detection
   - Objective templates with placeholders
   - Template variations for diversity
   - Example titles per pattern
   - Default fallback pattern

3. **`expansion-packs/creator-os/templates/blooms-taxonomy.yaml`** (180 lines)
   - 6 Bloom's Taxonomy levels (Remember → Create)
   - Action verbs per level (10+ verbs each)
   - Level descriptions and usage guidance
   - Examples per level
   - Recommended distributions for 3 course types
   - Anti-patterns (common mistakes to avoid)
   - Good vs. bad objective examples

### Files Modified

4. **`expansion-packs/creator-os/tasks/generate-course.md`**
   - Version updated: 2.4 → 2.5
   - Added Step 2.7: Learning Objectives Inference (brownfield only)
   - Integrated after Step 2.6 (Voice Extraction)
   - Added 5 sub-actions:
     - 2.7.1: Find legacy lessons
     - 2.7.2: Infer lesson objectives
     - 2.7.3: Synthesize course objectives
     - 2.7.4: Prefill COURSE-BRIEF
     - 2.7.5: User review checkpoint
   - Added error handling scenarios (no lessons, too few, low confidence, imbalanced)
   - Updated changelog with v2.5 entry

5. **`expansion-packs/creator-os/stories/STORY-3.5-learning-objectives-inference.md`**
   - Status updated: Planning → Complete
   - Added completion date: 2025-10-18
   - Definition of Done updated (all items checked except merge)
   - Added File List section (this section)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.2: File Inventory & Organization](./STORY-3.2-file-inventory-organization.md)
- [Story 3.6: Gap Analysis & Smart Elicitation](./STORY-3.6-gap-analysis-smart-elicitation.md)
