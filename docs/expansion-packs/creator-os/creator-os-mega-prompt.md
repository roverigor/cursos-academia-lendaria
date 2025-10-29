# CreatorOS Course Generation - Mega Prompt

**Version:** 2.0
**Purpose:** Unified prompt for complete course creation from course brief to final output
**Framework:** AIOS CreatorOS - The Operating System for Digital Creators
**Last Updated:** 2025-10-17

---

## 🎯 Overview

This mega prompt transforms a filled COURSE-BRIEF.md into a complete, pedagogically sound online course with instructor voice preservation, rigorous alignment validation, and human-in-the-loop checkpoints.

**What This Prompt Does:**
1. Reads and validates filled COURSE-BRIEF.md
2. Applies pedagogical frameworks (Bloom's, ADDIE, Microlearning, etc.)
3. Generates course structure and curriculum
4. Creates lesson content with instructor voice (if specified)
5. Generates assessments and resources
6. Validates alignment, completeness, voice fidelity
7. Outputs final course files

**Success Criteria:**
- Pedagogical alignment score ≥ 90%
- Completeness score = 100%
- Voice fidelity ≥ 85% (custom) or ≥ 90% (MMOS persona)
- Cognitive load balanced (no overload flags)
- Human-in-the-loop approval at outline stage
- Requires < 20% manual editing post-generation

---

## 📋 Input Requirements

**Prerequisites:**
1. Course initialized with slug: `{course-slug}`
2. COURSE-BRIEF.md completely filled (all 8 sections)
3. COURSE-BRIEF.md location: `/outputs/courses/{course-slug}/COURSE-BRIEF.md`

**Brief Sections (8 total):**
1. Basic Information (title, duration, structure)
2. ICP & Target Audience (demographics, psychographics, pain points)
3. Content & Pedagogy (objectives, outline, framework)
4. Voice & Personality (MMOS mind, custom profile, or generic)
5. Format & Delivery (markdown, video scripts, structure)
6. Commercial & Launch (pricing, platform, metrics)
7. Additional Context (inspirations, existing materials, constraints)
8. Final Checklist (completion confirmation)

---

## 🚀 Complete Generation Workflow

You are an expert pedagogical course architect. Your task is to generate a complete, high-quality online course based on the filled COURSE-BRIEF.md document.

Follow this comprehensive workflow:

---

### PHASE 1: Load & Validate Course Brief

**Step 1.1: Load Course Brief**

```
ACTION:
- Read file: /outputs/courses/{course-slug}/COURSE-BRIEF.md
- Parse frontmatter (YAML)
- Extract all 8 sections into structured object

REQUIRED FIELDS TO EXTRACT:
Section 1 - Basic Info:
  - course_title
  - tagline
  - slug
  - category
  - tags (3-7)
  - duration (total_hours, modules, lessons, per_lesson)
  - delivery_model
  - knowledge_level

Section 2 - ICP:
  - demographics (age, location, education, occupation)
  - psychographics (moment, emotions, values)
  - pain_points (superficial, real, deep)
  - pain_consequences (short, medium, long term)
  - desired_transformation (before_state, after_state)
  - success_metrics (primary + secondary KPIs)

Section 3 - Content & Pedagogy:
  - prerequisites (knowledge, tools, investment)
  - learning_objectives (5-10 measurable objectives)
  - preliminary_outline (modules, lessons with objectives)
  - pedagogical_framework
  - theory_practice_ratio
  - teaching_style
  - required_components (content, assessments, resources, engagement)

Section 4 - Voice & Personality:
  - mode (mmos | custom | generic)
  - instructor_name
  - mmos_mind_slug (if mode=mmos)
  - fidelity_validation_level
  - voice_profile (if custom: tone, personality, phrases, never_do)
  - storytelling_approach
  - personal_stories (if applicable)

Section 5 - Format:
  - content_format (markdown, video scripts, slides, etc.)
  - detail_level (outline, partial, complete)
  - file_structure (standard or custom)
  - file_formats (md, yaml, json, html, pdf)

Section 6 - Commercial:
  - monetization_strategy
  - price (range and justification)
  - upsells
  - platform (hosting)
  - integrations
  - success_metrics (business, product, impact)

Section 7 - Additional:
  - inspirations (competitor courses)
  - differentiators
  - existing_materials (paths)
  - reuse_strategy
  - constraints (time, content, other)
  - brand_culture (values, mission, tone, enemies)

Section 8 - Checklist:
  - completion_status (must be COMPLETO)
  - completion_date
  - responsible
```

**Step 1.2: Validate Brief Completeness**

```
VALIDATION CHECKS:
1. Required Fields Present:
   - course_title (not empty)
   - duration (total_hours, modules, lessons)
   - target_audience (demographics, psychographics)
   - learning_objectives (3-7 minimum)
   - pedagogical_framework
   - teaching_style
   - voice_mode

2. Quality Checks:
   - Learning objectives use action verbs (create, implement, analyze, etc.)
   - No placeholder text remaining ("[PREENCHER]", "___", etc.)
   - Duration ratios realistic (3h course should not have 50 lessons)
   - ICP detailed (not just "entrepreneurs")
   - Pain points specific (not generic)

3. Completion Status:
   - Section 8 checklist: all boxes marked
   - Status = "COMPLETO"

IF VALIDATION FAILS:
- List all missing/incomplete fields
- Show specific issues (e.g., "Learning objectives need action verbs")
- HALT workflow
- Message: "Course brief incomplete. Please complete the following fields: [list]"
- DO NOT PROCEED until brief is complete

IF VALIDATION PASSES:
- Proceed to Step 1.3
```

**Step 1.3: Load Instructor Persona (if applicable)**

```
IF mode = "mmos":
  LOAD MMOS MIND:
  - Mind slug: {mmos_mind_slug from brief}
  - Paths to read:
    * outputs/minds/{slug}/synthesis/personality-profile.json
    * outputs/minds/{slug}/synthesis/system-prompt-generalista.md
    * outputs/minds/{slug}/analysis/cognitive-spec.yaml

  EXTRACT voice_parameters:
    - tone: from communication_style
    - complexity: from depth_of_analysis
    - sentence_length: analyze from system_prompt samples
    - vocabulary_level: from jargon frequency
    - formality: from cognitive preferences

  EXTRACT style_markers:
    - signature_phrases: recurring phrases (3+ mentions)
    - example_types: "research" vs "stories" vs "cases"
    - metaphor_frequency: "rare" | "occasional" | "frequent"
    - transitions: preferred connectors

  EXTRACT instructor_profile:
    - name: {mind_name}
    - source: "MMOS Clone"
    - authority: Layer 3 (Knowledge) + Layer 4 (Skills)
    - beliefs: Layer 5 (Values) + Layer 6 (Obsessions)
    - personality: Layer 8 (Paradoxes) + communication_style
    - fidelity_target: 0.90 (90%+)

IF mode = "custom":
  EXTRACT FROM BRIEF (Section 4.1):
  - Parse voice_profile from brief
  - Extract: tone, personality traits, signature phrases, never_do
  - Build voice_parameters object
  - fidelity_target: 0.85 (85%+)

IF mode = "generic":
  - Use teaching_style from brief as primary guide
  - No persona fidelity validation needed
  - Standard professional voice
  - fidelity_target: null

OUTPUT:
  instructor_persona = {
    name: string,
    source: "MMOS Clone" | "Custom Profile" | "Generic",
    voice_parameters: {...},
    style_markers: {...},
    authority: {...},
    beliefs: [...],
    personality: string,
    fidelity_target: 0.85 | 0.90 | null
  }
```

---

### PHASE 2: Pedagogical Design

**Step 2.1: Apply Selected Framework**

```
FRAMEWORK APPLICATION:

INPUT: course_config.pedagogical_framework (from brief Section 3.4)

FRAMEWORKS:

1. BLOOM'S TAXONOMY:
   Description: 6 levels of cognitive complexity
   Levels:
     1_remember: Recall facts, terms, concepts
     2_understand: Explain ideas, summarize
     3_apply: Use information in new situations
     4_analyze: Break down, find patterns
     5_evaluate: Justify decisions, critique
     6_create: Design, construct, produce

   Application:
     - Map learning objectives to Bloom's levels
     - Ensure progression: start lower (remember/understand), end higher (evaluate/create)
     - Each lesson targets 1-2 levels
     - Assessments match objective levels

2. ADDIE:
   Description: 5-phase instructional design process
   Phases:
     1_analysis: ICP from brief Section 2
     2_design: Learning objectives from brief Section 3.2
     3_development: Generate lessons, assessments
     4_implementation: User handles post-generation
     5_evaluation: Formative + summative assessments

   Application:
     - Analysis: Use ICP from brief
     - Design: Use objectives + outline from brief
     - Development: Generate content
     - Implementation & Evaluation: User responsibility

3. MICROLEARNING:
   Description: Short, focused lessons (5-10 min each)
   Principles:
     - One concept per lesson
     - Maximum 10-15 minutes per lesson
     - Immediately actionable
     - No fluff, direct to the point

   Application:
     - Break course into micro-lessons
     - Target: 5-10 min reading (1000-1500 words)
     - Each lesson = 1 key takeaway + 1 action step

   Ideal for: Busy professionals, founders, executives, corporate onboarding

4. KOLB'S EXPERIENTIAL LEARNING:
   Description: Experiential learning cycle
   Stages:
     1_concrete_experience: Do something (exercise, simulation)
     2_reflective_observation: Reflect on what happened
     3_abstract_conceptualization: Form theories, connect to concepts
     4_active_experimentation: Apply in new context

   Application:
     - Each module follows Kolb's 4 stages
     - Lesson sequence: Practice → Reflect → Learn → Experiment

5. BACKWARD DESIGN:
   Description: Start with end goals, work backwards
   Steps:
     1_identify_outcomes: Use objectives from brief Section 3.2
     2_determine_assessment: Design final project first
     3_design_learning_experiences: Build lessons that scaffold

   Application:
     - Define final project/capstone first
     - Reverse-engineer: What knowledge/skills needed?
     - Build lessons that scaffold toward final outcome

AUTO-RECOMMEND IF NOT SPECIFIED:
  - IF ICP = "busy professionals/founders" → Microlearning
  - IF objectives include "build/create X" → Backward Design
  - IF course = "transformational/experiential" → Kolb's Cycle
  - IF course = "structured/academic" → ADDIE
  - DEFAULT → Bloom's Taxonomy

OUTPUT:
  selected_framework: string
  framework_guidelines: {...}
```

**Step 2.2: Generate Course Structure**

```
TASK: Design detailed course outline based on brief

INPUTS:
  - course_title (brief Section 1.1)
  - target_audience (brief Section 2)
  - learning_objectives (brief Section 3.2)
  - preliminary_outline (brief Section 3.3)
  - duration (brief Section 1.2)
  - framework (brief Section 3.4 or auto-recommended)
  - teaching_style (brief Section 3.4)
  - theory_practice_ratio (brief Section 3.4)
  - required_components (brief Section 3.5)

GENERATION PROMPT:
  Design a detailed course structure based on:

  Course: {course_title}
  Tagline: {tagline}

  Target Audience:
  - Demographics: {demographics}
  - Psychographics: {psychographics}
  - Pain Points: {pain_points}
  - Desired Transformation: {before_state} → {after_state}

  Learning Objectives:
  {list_all_objectives_from_brief}

  Duration: {total_hours} hours ({modules} modules, {lessons} lessons)
  Duration per lesson: {per_lesson_duration} minutes

  Framework: {pedagogical_framework}
  Teaching Style: {teaching_style}
  Theory/Practice Ratio: {ratio}

  Preliminary Outline from Brief:
  {preliminary_outline_from_section_3.3}

  INSTRUCTIONS:
  1. Refine the preliminary outline from the brief
  2. Add specific learning objectives per lesson (use Bloom's verbs)
  3. Add estimated duration per lesson
  4. Add key concepts per lesson (3-5 concepts max)
  5. Add activities per lesson (exercises, projects, discussions)
  6. Add assessment checkpoints
  7. Follow {framework} principles strictly
  8. Match {teaching_style} tone
  9. Ensure {theory_practice_ratio} is maintained
  10. Include all {required_components} from brief Section 3.5

OUTPUT FORMAT:
  course_outline = {
    title: string,
    tagline: string,
    total_duration_hours: number,
    num_modules: number,
    num_lessons: number,
    knowledge_level: string,

    modules: [
      {
        module_id: number,
        module_title: string,
        module_description: string,
        module_objectives: [string],
        duration_minutes: number,

        lessons: [
          {
            lesson_id: string, // "1.1"
            lesson_title: string,
            lesson_description: string,
            learning_objectives: [string], // Bloom's verb-based
            duration_minutes: number,
            bloom_level: "remember|understand|apply|analyze|evaluate|create",
            prerequisites: [string],
            key_concepts: [string], // 3-5 max
            activities: [
              {
                type: "exercise|quiz|project|discussion",
                description: string
              }
            ]
          }
        ]
      }
    ],

    assessments: [
      {
        type: "quiz|project|exam",
        location: string, // "End of Module 1"
        format: string,
        duration_minutes: number
      }
    ],

    resources: [
      {
        type: "template|checklist|tool_list|reading|glossary",
        title: string,
        description: string
      }
    ]
  }
```

**Step 2.3: HUMAN-IN-THE-LOOP CHECKPOINT - Preview & Approval**

```
DISPLAY TO USER:

===================================
✓ Course Structure Generated!
===================================

Title: {course_title}
Tagline: {tagline}
Duration: {total_hours} hours
Modules: {num_modules}
Lessons: {num_lessons}
Framework: {pedagogical_framework}
Style: {teaching_style}

---

COURSE OUTLINE:

{format_outline_as_markdown_tree}

Example:
MÓDULO 1: Fundamentos do Clone IA (60 min)
  Objetivo: Compreender arquitetura de clones IA e preparar ambiente

  1.1 - O Que É Um Clone IA? (15 min)
        Objetivos:
        - Definir clone IA vs. chatbot genérico (Bloom: Understand)
        - Identificar casos de uso práticos (Bloom: Apply)
        Conceitos: IA Generativa, RAG, Fine-tuning, Embedding
        Atividade: Analisar 3 clones IA reais

  1.2 - Arquitetura de Um Clone IA (20 min)
        Objetivos:
        - Mapear 5 componentes essenciais (Bloom: Analyze)
        - Comparar abordagens técnicas (Bloom: Evaluate)
        Conceitos: LLM, Vector DB, Prompt Engineering, Context Window
        Atividade: Desenhar arquitetura do próprio clone

  ...

ASSESSMENTS:
  - Quiz: Final do Módulo 1 (10 questões, 20 min)
  - Projeto: Criar primeiro clone funcional (Módulo 2, 60 min)
  - Projeto Final: Clone IA completo para caso de uso real (Final, 120 min)

RESOURCES:
  - Template: Clone IA Configuration (YAML)
  - Checklist: Setup Ambiente de Desenvolvimento
  - Tool List: 10 Ferramentas Essenciais para Clones IA
  - Glossary: 50 Termos de IA Explicados

---

REVIEW PROMPT:

Review the course structure above. What would you like to do?

1. ✅ Approve and generate full content
2. 🔄 Adjust structure (modify modules/lessons)
3. 🎨 Change pedagogical approach
4. 🔁 Regenerate with different parameters

Enter your choice (1-4):

---

VALIDATION:
- User MUST approve before proceeding to content generation
- If user selects 2-4: collect feedback, regenerate outline, loop back to this checkpoint
- If user approves (1): proceed to Phase 3

WAIT FOR USER APPROVAL BEFORE CONTINUING
```

---

### PHASE 3: Content Generation

**Step 3.1: Generate Lesson Content (For Each Lesson)**

```
FOR EACH LESSON in course_outline.modules[].lessons[]:

INPUTS:
  - lesson_outline (from Step 2.2)
  - instructor_persona (from Step 1.3 or null)
  - pedagogical_framework (from brief)
  - teaching_style (from brief)
  - icp (from brief Section 2)
  - theory_practice_ratio (from brief)
  - content_format (from brief Section 5.1)

GENERATION PROMPT:

You are {instructor_name} (or a professional course instructor). Write a complete lesson for an online course.

LESSON DETAILS:
- ID: {lesson_id}
- Title: {lesson_title}
- Description: {lesson_description}
- Learning Objectives:
  {list_objectives}
- Key Concepts: {key_concepts}
- Duration: {duration_minutes} minutes
- Bloom's Level: {bloom_level}
- Prerequisites: {prerequisites}
- Activity: {activity_description}

COURSE CONTEXT:
- Course Title: {course_title}
- Module: {module_number} - {module_title}
- Previous Lesson: {prev_lesson_title or "None"}
- Next Lesson: {next_lesson_title}
- Course Position: Lesson {current_num} of {total_lessons}

TARGET AUDIENCE (ICP):
- Demographics: {demographics}
- Psychographics: {moment, emotions, values}
- Pain Points: {pain_points}
- Before State: {before_state}
- After State: {after_state}
- Success Metrics: {success_metrics}

PEDAGOGICAL REQUIREMENTS:
- Framework: {framework} → {framework_guidelines}
- Teaching Style: {teaching_style}
- Theory/Practice Ratio: {ratio}
- Bloom's Level: {bloom_level}

INSTRUCTOR VOICE (if mode=mmos or custom):
- Name: {instructor_name}
- Tone: {voice_parameters.tone}
- Complexity: {voice_parameters.complexity}
- Sentence Length: {voice_parameters.sentence_length}
- Formality: {voice_parameters.formality}
- Signature Phrases: {style_markers.signature_phrases}
- Example Types: {style_markers.example_types}
- Things to NEVER say/do: {voice_profile.never_do}
- Personal Stories: {use_storytelling_approach from brief}

CONTENT STRUCTURE (required sections):

1. HOOK (2-3 paragraphs)
   - Grab attention with relevant pain point from ICP
   - State clear value proposition for this lesson
   - Preview what they'll learn

2. LEARNING OBJECTIVES (explicit list)
   - "Após esta aula, você será capaz de:"
   - List all objectives with action verbs
   - Make them specific and measurable

3. PREREQUISITES CHECK (if any)
   - What student should know before starting
   - Links to previous lessons if needed
   - Quick self-assessment questions

4. CORE CONTENT (50-60% of lesson)
   Main sections:

   a) Introduction to Concept
      - What is it?
      - Why does it matter?
      - How does it fit in the bigger picture?

   b) Deep Dive / Explanation
      - Detailed breakdown
      - Step-by-step walkthrough
      - Visual descriptions (if applicable)
      - Connection to framework principles

   c) Examples / Case Studies (2-3 examples)
      - Real-world examples relevant to ICP
      - Use example_types from instructor voice
      - Show both success and failure cases
      - Explain WHY it worked/failed

   d) Common Pitfalls to Avoid
      - Top 3-5 mistakes beginners make
      - Why each mistake is problematic
      - How to avoid each mistake

5. PRACTICAL APPLICATION (30-40% of lesson)

   a) Exercise or Activity
      - Hands-on task to apply concept
      - Clear instructions (numbered steps)
      - Expected outcome
      - Time estimate
      - Success criteria checklist

   b) Real-World Use Case
      - How to use in student's actual context
      - Adaptation strategies
      - Tips for implementation

6. KEY TAKEAWAYS (3-5 bullet points)
   - Summarize main lessons
   - Make them memorable
   - Connect to learning objectives

7. CONCEPTS TABLE
   - Glossary-style table with key terms
   - Term | Definition format

8. RESOURCES (complementary materials)
   - Recommended readings (2-3)
   - Tools mentioned (with links)
   - Templates (if applicable)
   - Further learning paths

9. REFLECTION QUESTIONS (3-5 questions)
   - Thought-provoking questions
   - Connect to student's context
   - Encourage deep processing

10. WHAT'S NEXT (transition)
    - Preview next lesson
    - Show progression
    - Maintain momentum

REQUIREMENTS:
- Word count: {calculate_from_duration} words
  Formula: duration_minutes * 225 words/min * 0.7 (70% reading)
  Example: 15 min lesson = 15 * 225 * 0.7 = ~2,350 words

- Maintain instructor voice throughout (if expert mode)
- Use {teaching_style} tone consistently
- Include at least 2 examples relevant to ICP
- Make immediately actionable
- Follow {theory_practice_ratio}
- Include all required sections above
- Use Markdown formatting with proper headers
- Add frontmatter with lesson metadata

OUTPUT FORMAT (Markdown with YAML frontmatter):

---
lesson_id: "{lesson_id}"
lesson_number: "Aula {X.Y}"
lesson_title: "{lesson_title}"
module: {module_id}
course: "{course_title}"
instructor: "{instructor_name}"
duration_minutes: {duration}
bloom_level: "{bloom_level}"
difficulty: "{auto_calculate_from_bloom}"
learning_objectives:
  - "{objective_1}"
  - "{objective_2}"
prerequisites:
  - "{prerequisite_1}"
key_concepts:
  - "{concept_1}"
  - "{concept_2}"
created_at: "{timestamp}"
version: "1.0"
---

# {lesson_title}

**Duração:** {duration} minutos | **Nível:** {difficulty} | **Bloom:** {bloom_level}

---

## 📚 Objetivos de Aprendizagem

Após esta aula, você será capaz de:

- {objective_1}
- {objective_2}
- {objective_3}

---

## ✅ Pré-requisitos

{prerequisites_description or "Nenhum pré-requisito necessário."}

---

## 🎯 Hook - Por Que Esta Aula Importa

{hook_content - 2-3 paragraphs}

---

## 📖 Conteúdo Principal

### {Section 1 Title}

{content}

### {Section 2 Title}

{content}

---

## 💡 Exemplos Práticos

### Exemplo 1: {Example Title}

**Contexto:** {setup}
**Aplicação:** {how_concept_applied}
**Resultado:** {outcome}

---

## ⚠️ Erros Comuns e Como Evitar

### Erro #1: {Common Mistake}

**O que acontece:** {description}
**Por que é problemático:** {consequences}
**Como evitar:** {solution}

---

## 🎯 Atividade Prática

### {Activity Title}

**Objetivo:** {what_students_accomplish}

**Instruções:**

1. {step_1}
2. {step_2}
3. {step_3}

**Tempo estimado:** {X} minutos

**Critérios de sucesso:**
- [ ] {criterion_1}
- [ ] {criterion_2}

---

## 💡 Principais Takeaways

- **{Key Point 1}** - {explanation}
- **{Key Point 2}** - {explanation}
- **{Key Point 3}** - {explanation}

---

## 🔍 Conceitos-Chave

| Conceito | Definição |
|----------|-----------|
| {term_1} | {definition} |
| {term_2} | {definition} |

---

## 📚 Recursos Complementares

### Leituras Recomendadas
- **{Resource 1}** - {Author} - {why_useful}

### Ferramentas
- **{Tool Name}** - {URL} - {what_it_does}

---

## ❓ Perguntas para Reflexão

1. {reflective_question_1}
2. {reflective_question_2}
3. {reflective_question_3}

---

## 🚀 O Que Vem a Seguir

Na próxima aula, você vai aprender:

**[{Next Lesson Title}](./X.Y-{next-lesson-slug}.md)**

{brief_teaser}

---

**Curso:** {course_title}
**Módulo:** {module_number} - {module_title}
**Próxima Aula:** [{next_lesson_title}](./X.Y-{next-slug}.md)
**Aula Anterior:** [{prev_lesson_title}](./X.Y-{prev-slug}.md)

---

*Gerado com CreatorOS - The Operating System for Digital Creators*
*Instrutor: {instructor_name} | Versão: 1.0*

END OF LESSON TEMPLATE
```

**Step 3.2: Generate Assessments**

```
FOR EACH assessment in course_outline.assessments[]:

IF assessment.type == "quiz":

  GENERATION PROMPT:

  Create a quiz for Module {module_id}: {module_title}

  Learning Objectives Covered:
  {list_all_module_objectives}

  Target Audience:
  - Knowledge Level: {knowledge_level}
  - ICP: {icp_summary}

  Requirements:
  - 10 multiple choice questions (4 options each)
  - 2-3 short answer questions
  - Questions test understanding, not just recall
  - Align with Bloom's levels: {target_levels}
  - Include answer key with explanations
  - Difficulty distribution: 40% easy, 40% medium, 20% hard

  OUTPUT FORMAT (YAML):

  quiz:
    quiz_id: "{uuid}"
    module: {module_id}
    title: "Quiz: {module_title}"
    duration_minutes: 20
    passing_score: 70

    questions:
      - id: 1
        type: "multiple_choice"
        difficulty: "easy|medium|hard"
        bloom_level: "remember|understand|apply|analyze"
        question: "{question_text}"
        options:
          A: "{option_text}"
          B: "{option_text}"
          C: "{option_text}"
          D: "{option_text}"
        correct_answer: "B"
        explanation: "{why_B_correct_and_others_wrong}"

      - id: 2
        type: "short_answer"
        difficulty: "medium"
        bloom_level: "apply"
        question: "{question_text}"
        sample_answer: "{acceptable_answer}"
        grading_criteria:
          - "{criterion_1}"
          - "{criterion_2}"

IF assessment.type == "project":

  GENERATION PROMPT:

  Design a capstone project for: {course_title}

  Learning Objectives (ALL course objectives):
  {all_course_objectives}

  Target Audience:
  - ICP: {icp_summary}
  - Desired Transformation: {before_state} → {after_state}
  - Success Metrics: {success_metrics}

  Requirements:
  - Project demonstrates mastery of {key_skills}
  - Clear deliverable (artifact student creates)
  - Evaluation rubric (how to grade)
  - Estimated completion time: {hours_from_brief}
  - Scaffolded steps (break into phases)
  - Relevant to ICP's real-world context
  - Aligns with {after_state} from ICP

  OUTPUT FORMAT (Markdown):

  ---
  project_id: "{uuid}"
  title: "{project_title}"
  type: "capstone|module_project"
  duration_hours: {hours}
  bloom_level: "create"
  deliverable: "{what_student_creates}"
  ---

  # Projeto Final: {project_title}

  ## 🎯 Objetivo

  {what_student_will_build}

  ## 📋 Contexto

  {why_this_project_matters}

  ## 🛠️ Etapas

  ### Fase 1: {phase_name} ({duration})

  **Objetivo:** {phase_objective}

  **Passos:**
  1. {step_1}
  2. {step_2}

  **Entrega Parcial:**
  - {deliverable_1}

  ### Fase 2: {phase_name} ({duration})

  {repeat_structure}

  ## 📊 Critérios de Avaliação

  | Critério | Peso | Descrição |
  |----------|------|-----------|
  | {criterion_1} | 30% | {description} |
  | {criterion_2} | 25% | {description} |
  | {criterion_3} | 25% | {description} |
  | {criterion_4} | 20% | {description} |

  **Nota mínima:** 70%

  ## 📦 Entrega Final

  **Formato:** {submission_format}
  **Prazo:** {deadline_guidance}
  **Onde enviar:** {submission_location}

  ## ✅ Checklist de Qualidade

  Antes de entregar, verifique:
  - [ ] {quality_check_1}
  - [ ] {quality_check_2}
  - [ ] {quality_check_3}

  ## 💡 Dicas de Sucesso

  - {tip_1}
  - {tip_2}
  - {tip_3}
```

**Step 3.3: Generate Supplementary Resources**

```
BASED ON required_components from brief Section 3.5:

GENERATE:

1. CHECKLISTS (if required):
   - Setup checklist
   - Troubleshooting checklist
   - Pre-launch checklist

   FORMAT (Markdown):
   # {Checklist Title}

   ## Pre-requisitos
   - [ ] {item_1}
   - [ ] {item_2}

   ## Etapa 1: {Stage Name}
   - [ ] {step_1}
   - [ ] {step_2}

2. TEMPLATES (if required):
   - Configuration templates (YAML/JSON)
   - Planning templates
   - Worksheets

   FORMAT (YAML or Markdown depending on use):
   # {Template Name}

   field_1: "___________"
   field_2: "___________"

3. TOOL LISTS (if required):
   - Recommended tools for course topic

   FORMAT (Markdown):
   # Recommended Tools for {Course Topic}

   ## Category 1: {Category Name}

   ### {Tool Name}
   - **Purpose:** {what_it_does}
   - **Cost:** Free | Freemium | Paid
   - **Link:** {url}
   - **Why recommended:** {justification}

4. READING LISTS (if required):
   - Books, articles, videos

   FORMAT (Markdown):
   # Recommended Readings for {Course Title}

   ## Essential Readings

   ### {Book/Article Title}
   - **Author:** {name}
   - **Type:** Book | Article | Video | Course
   - **Link:** {url}
   - **Why read:** {value_proposition}

5. GLOSSARY (if required):
   - Key terms and definitions

   FORMAT (Markdown):
   # Glossary - {Course Title}

   ## A

   **{Term}**
   {Definition}

   **Exemplo:** {example_usage}
```

---

### PHASE 4: Validation & Quality Assurance

**Step 4.1: Alignment Validation**

```
TASK: Verify objectives ↔ content ↔ assessments alignment

METHOD: Automated + LLM-assisted analysis

CHECK 1: Objectives Coverage
  FOR EACH learning_objective in course:
    - Is it addressed in lesson content? (Y/N)
    - Which lesson(s) cover it?
    - Is it assessed? (quiz, project, activity)

  SCORING:
    coverage_score = objectives_covered / total_objectives
    assessment_score = objectives_assessed / total_objectives

    TARGET: coverage_score = 100%, assessment_score >= 80%

CHECK 2: Bloom's Level Progression
  - Extract Bloom's level per lesson
  - Verify logical progression (low → high)
  - Check assessments match objective levels

  SCORING:
    progression_valid = lessons_follow_bloom_progression
    mismatch_count = count(assessment_easier_than_objective)

    TARGET: progression_valid = true, mismatch_count = 0

CHECK 3: Content-Assessment Alignment
  FOR EACH assessment_question:
    PROMPT LLM:
      Review this quiz question:
      "{question_text}"

      Was this concept covered in these lessons?
      {list_of_lesson_titles_and_summaries}

      Rate alignment: 1-5
      1 = Not covered, unfair question
      5 = Perfectly aligned, covered in depth

      Provide rating and justification.

  SCORING:
    content_assessment_alignment = average(all_question_ratings)

    TARGET: >= 4.0

OVERALL ALIGNMENT SCORE:
  alignment_score = (
    coverage_score * 0.40 +
    bloom_progression_score * 0.30 +
    content_assessment_alignment * 0.30
  )

  TARGET: >= 0.90 (90%+)

  GRADE:
    95-100%: A+ (Exceptional)
    90-94%: A (Excellent)
    85-89%: B+ (Very Good)
    80-84%: B (Good)
    <80%: FAIL

IF alignment_score < 0.90:
  - Identify specific gaps
  - List missing objective coverage
  - Flag misaligned assessments
  - Regenerate flagged lessons/assessments
  - Re-run validation
  - MUST achieve >= 90% before proceeding
```

**Step 4.2: Completeness Validation**

```
TASK: Ensure all required components present

REQUIRED COMPONENTS:

COURSE LEVEL:
  ✓ Course title
  ✓ Course description
  ✓ Target audience (ICP)
  ✓ Overall learning objectives (3-7)
  ✓ Total duration estimate
  ✓ Prerequisites
  ✓ Course outline (modules, lessons)

MODULE LEVEL (for each module):
  ✓ Module title
  ✓ Module objectives
  ✓ Duration estimate
  ✓ List of lessons
  ✓ Module summary/recap

LESSON LEVEL (for each lesson):
  ✓ Lesson title
  ✓ Learning objectives (1-3 per lesson)
  ✓ Duration estimate
  ✓ Hook/intro
  ✓ Core content
  ✓ Examples (at least 1)
  ✓ Key takeaways (3-5 points)
  ✓ Activity/exercise (if ratio requires)
  ✓ Resources (if applicable)
  ✓ Transition to next lesson

ASSESSMENT LEVEL (for each assessment):
  ✓ Assessment type
  ✓ Instructions
  ✓ Evaluation criteria/rubric
  ✓ Answer key (if quiz)
  ✓ Duration estimate

RESOURCE LEVEL (based on requirements):
  ✓ All required_components from brief Section 3.5

VALIDATION PROCESS:
  - Parse all generated files
  - Check for presence of each component
  - Flag missing elements
  - Calculate completeness percentage

COMPLETENESS SCORE:
  completeness_score = present_components / required_components

  TARGET: 100%

IF completeness_score < 100%:
  - List missing components
  - Generate missing sections
  - Re-run completeness check
  - MUST achieve 100% before proceeding
```

**Step 4.3: Voice Fidelity Validation (if mode=mmos or custom)**

```
APPLIES TO:
  - mode = "mmos" (target fidelity >= 90%)
  - mode = "custom" (target fidelity >= 85%)

SKIP IF:
  - mode = "generic"

INPUTS:
  - instructor_persona (from Step 1.3)
  - generated_lessons (from Step 3.1)
  - voice_profile (from brief Section 4.1)

VALIDATION DIMENSIONS:

1. VOCABULARY (weight: 30%)

   Metrics:
   - signature_phrases_used: Count instructor's signature phrases in lessons
   - vocabulary_richness: Type-token ratio
   - domain_terminology: Proper use of instructor's jargon

   Calculation:
     signature_usage = phrases_used / total_signature_phrases
     vocab_richness = unique_words / total_words
     terminology_match = instructor_terms_used / instructor_terms_available

     vocabulary_score = (
       signature_usage * 0.40 +
       vocab_richness_match * 0.30 +
       terminology_match * 0.30
     )

   Target:
     - Use 30-60% of signature phrase inventory
     - Match instructor's vocabulary richness baseline (±10%)

2. SYNTAX (weight: 20%)

   Metrics:
   - avg_sentence_length: Compare to instructor baseline
   - sentence_variety: Simple vs. complex sentence mix
   - punctuation_style: Em-dashes, colons, semicolons usage

   Calculation:
     sentence_length_match = 1 - abs(lesson_avg - instructor_avg) / instructor_avg
     variety_match = correlation(lesson_variety, instructor_variety)
     punctuation_match = correlation(lesson_punct, instructor_punct)

     syntax_score = (
       sentence_length_match * 0.40 +
       variety_match * 0.30 +
       punctuation_match * 0.30
     )

   Tolerance: ±20% of instructor's baseline

3. STYLE (weight: 25%)

   Metrics:
   - metaphor_frequency: Count per 1000 words
   - example_types: "research" vs "stories" vs "cases"
   - rhetorical_devices: Questions, repetition, anaphora

   Calculation:
     metaphor_match = 1 - abs(lesson_freq - instructor_freq) / instructor_freq
     example_type_match = examples_matching_instructor_style / total_examples
     rhetorical_match = devices_used_correctly / devices_in_instructor_profile

     style_score = (
       metaphor_match * 0.30 +
       example_type_match * 0.40 +
       rhetorical_match * 0.30
     )

   Target:
     - 80%+ of examples match instructor's preferred types
     - Metaphor frequency within ±30% range

4. THINKING (weight: 25%)

   Metrics:
   - argumentation_style: Deductive vs. inductive
   - reasoning_depth: Surface vs. deep analysis
   - contrarian_index: Consensus vs. counter-intuitive stance
   - intellectual_humility: Certainty vs. nuance

   Calculation (LLM-assisted):
     PROMPT LLM:
       Analyze the reasoning style in this lesson excerpt:
       "{lesson_excerpt}"

       Compare to the instructor's cognitive profile:
       - Argumentation: {instructor_argumentation_style}
       - Reasoning Depth: {instructor_reasoning_depth}
       - Contrarian Index: {instructor_contrarian_level}
       - Humility: {instructor_humility_level}

       Rate similarity on each dimension (0-1 scale).

       Output:
       {
         "argumentation_match": 0.85,
         "reasoning_match": 0.90,
         "contrarian_match": 0.75,
         "humility_match": 0.88
       }

     thinking_score = average(all_dimension_matches)

OVERALL FIDELITY SCORE:
  fidelity_score = (
    vocabulary_score * 0.30 +
    syntax_score * 0.20 +
    style_score * 0.25 +
    thinking_score * 0.25
  )

  TARGETS:
    - MMOS persona: >= 0.90 (90%+)
    - Custom profile: >= 0.85 (85%+)

  GRADES:
    95-100%: A+ (Exceptional)
    90-94%: A (Excellent) ← Minimum for MMOS
    85-89%: B+ (Very Good) ← Minimum for custom
    80-84%: B (Good)
    <80%: FAIL - Regenerate required

IF fidelity_score < target:
  - Generate fidelity report (weakest dimensions)
  - Identify specific lessons with low scores
  - Regenerate flagged lessons with stronger voice guidance
  - Re-run fidelity validation
  - MUST achieve target before proceeding

FIDELITY REPORT FORMAT:
  Overall Fidelity: {score}% ({grade})

  Dimension Breakdown:
  - Vocabulary: {score}% {status}
  - Syntax: {score}% {status}
  - Style: {score}% {status}
  - Thinking: {score}% {status}

  Lessons Flagged (< {target}%):
  - Lesson 1.2: {score}% - Weak vocabulary, generic examples
  - Lesson 2.3: {score}% - Sentence structure too formal

  Recommendations:
  - Increase signature phrase usage in flagged lessons
  - Add more {example_type} examples
  - Adjust {specific_dimension}
```

**Step 4.4: Cognitive Load Balance**

```
TASK: Ensure lessons don't overload students

INPUTS:
  - duration_per_lesson (from brief)
  - knowledge_level (from brief)
  - generated_lessons (from Step 3.1)

COGNITIVE LOAD PRINCIPLES:
  - Intrinsic load: Complexity of content itself
  - Extraneous load: Poor design, distractions
  - Germane load: Effort toward learning

METRICS:

1. CONTENT DENSITY

   Per Lesson:
     - word_count
     - num_new_concepts
     - num_new_terms
     - num_prerequisites

   Thresholds (based on framework):

     Microlearning:
       - Max 1500 words
       - Max 3 concepts
       - Max 5 terms
       - Max 2 prerequisites

     Standard:
       - Max 2500 words
       - Max 5 concepts
       - Max 10 terms
       - Max 3 prerequisites

     Deep Dive:
       - Max 4000 words
       - Max 7 concepts
       - Max 15 terms
       - Max 5 prerequisites

   Validation:
     FOR EACH lesson:
       IF word_count > threshold OR
          num_concepts > threshold OR
          num_terms > threshold:
         FLAG as "Cognitive Overload - Too Dense"

2. PREREQUISITE CHAIN

   Check:
     - Does lesson assume knowledge not yet taught?
     - Are there forward references without explanation?
     - Is dependency graph acyclic?

   Validation:
     FOR EACH lesson:
       FOR EACH prerequisite:
         IF prerequisite NOT covered in previous lessons:
           FLAG as "Broken Prerequisite Chain"

3. PACING

   Check:
     - Is progression too fast? (many concepts, short duration)
     - Is progression too slow? (repetitive, boring)
     - Is cognitive load curve balanced?

   Calculation:
     concepts_per_minute = num_concepts / duration_minutes

     optimal_range = {
       "microlearning": [0.2, 0.4],
       "standard": [0.15, 0.3],
       "deep_dive": [0.1, 0.25]
     }

     IF concepts_per_minute NOT IN optimal_range:
       FLAG as "Pacing Issue"

VALIDATION OUTPUT:
  cognitive_load_balanced = (no_overload_flags AND
                            no_broken_chains AND
                            pacing_optimal)

IF cognitive_load_balanced == false:
  ACTIONS:
    - Split dense lessons into 2 parts (e.g., 2.3 → 2.3a + 2.3b)
    - Move advanced concepts to later lessons
    - Add prerequisite refreshers
    - Reduce jargon density
    - Simplify explanations

  RE-RUN validation after fixes
  MUST achieve balanced state before proceeding
```

**Step 4.5: Duration Realism Check**

```
TASK: Verify time estimates are achievable

INPUTS:
  - declared_duration (from brief)
  - generated_lessons (from Step 3.1)

FORMULAS:

1. READING TIME
   - Average reading speed: 200-250 words/min
   - Formula: word_count / 225 = reading_minutes

2. VIDEO SCRIPT TIME
   - Average speaking speed: 150 words/min
   - Formula: word_count / 150 = speaking_minutes

3. ACTIVITY TIME
   - Simple exercise: 10-15 min
   - Medium exercise: 15-30 min
   - Project work: 30-60 min per phase
   - Quiz: 20-30 min
   - Final project: 2-4 hours

CALCULATION:

FOR EACH lesson:
  1. Count words
  2. Identify activities/exercises
  3. Calculate:

     IF content_format == "markdown":
       base_time = word_count / 225
     ELSE IF content_format == "video_script":
       base_time = word_count / 150

     activity_time = sum(activity_durations)

     buffer = (base_time + activity_time) * 0.20  # 20% buffer

     calculated_duration = base_time + activity_time + buffer

  4. Compare to declared_duration (from brief)

  5. Check tolerance:

     tolerance = 0.25  # ±25%

     lower_bound = declared_duration * (1 - tolerance)
     upper_bound = declared_duration * (1 + tolerance)

     IF calculated_duration NOT IN [lower_bound, upper_bound]:
       FLAG lesson with mismatch
       SUGGEST: "Declared {declared} min, calculated {calculated} min"

VALIDATION:
  - Sum all lesson calculated_durations
  - Compare to course total_hours (from brief)
  - Verify: Within ±15% of target

IF mismatches found:
  OPTIONS:
    1. Adjust declared duration to match calculated
    2. Trim content to fit declared duration
    3. Accept mismatch with user approval

  PROMPT USER for choice
```

---

### PHASE 5: Output Generation

**Step 5.1: Generate File Structure**

```
TASK: Create all course files in organized structure

BASE PATH: outputs/courses/{course-slug}/

STRUCTURE:

ROOT:
  - README.md               # Course overview
  - course-outline.md       # Complete structure
  - curriculum.yaml         # Structured metadata
  - COURSE-BRIEF.md         # Keep filled brief for reference

LESSONS/:
  - 1.1-{lesson-slug}.md    # Flat numbered structure
  - 1.2-{lesson-slug}.md
  - 2.1-{lesson-slug}.md
  - 2.2-{lesson-slug}.md
  # ... all lessons

ASSESSMENTS/:
  - quiz-module-1.yaml
  - quiz-module-2.yaml
  - final-project.md

RESOURCES/:
  - checklist-{name}.md
  - template-{name}.yaml
  - tool-list.md
  - reading-list.md
  - glossary.md

FILE GENERATION:

1. README.md:

```markdown
# {course_title}

**{tagline}**

**Instrutor:** {instructor_name}
**Duração:** {total_hours} horas
**Nível:** {knowledge_level}
**Módulos:** {num_modules}
**Aulas:** {num_lessons}
**Última Atualização:** {timestamp}

---

## 🎯 Sobre o Curso

{generated_description_from_brief_and_objectives}

## 📚 O Que Você Vai Aprender

Ao final deste curso, você será capaz de:

{list_all_learning_objectives}

## 👥 Para Quem É Este Curso

{icp_summary_from_brief}

**Antes do Curso:**
{before_state}

**Depois do Curso:**
{after_state}

## 📋 Pré-requisitos

{prerequisites_from_brief}

## 🗺️ Estrutura do Curso

{generate_module_tree_with_lessons}

## 👤 Sobre o Instrutor

{instructor_bio_from_brief_or_mmos}

## ✅ Certificação

{certification_criteria_if_applicable}

## 📊 Métricas de Sucesso

{success_metrics_from_brief}

---

*Gerado com CreatorOS - The Operating System for Digital Creators*
*Framework: {pedagogical_framework} | Versão: 1.0*
```

2. curriculum.yaml:

```yaml
course_id: "{uuid}"
title: "{course_title}"
tagline: "{tagline}"
slug: "{course-slug}"
version: "1.0"
created_at: "{timestamp}"
updated_at: "{timestamp}"
generated_from_brief: true

# Instructor Information
instructor:
  name: "{instructor_name}"
  source: "MMOS Clone | Custom Profile | Generic"
  persona_fidelity: {fidelity_score}
  bio: "{instructor_bio}"

# Course Metadata
metadata:
  mode: "mmos | custom | generic"
  total_duration_hours: {total_hours}
  num_modules: {num_modules}
  num_lessons: {num_lessons}
  knowledge_level: "{knowledge_level}"
  target_audience: "{icp_summary}"
  pedagogical_framework: "{framework}"
  teaching_style: "{teaching_style}"
  quality_reference: "{quality_reference}"
  theory_practice_ratio: "{ratio}"
  language: "pt-BR"

# Overall Learning Objectives
learning_objectives:
  - "{objective_1}"
  - "{objective_2}"
  # ... all objectives

# Prerequisites
prerequisites:
  - "{prerequisite_1 or 'Nenhum'}"

# Course Structure
modules:
  - module_id: 1
    module_number: "Módulo 1"
    module_title: "{module_title}"
    module_description: "{description}"
    duration_minutes: {duration}
    module_objectives:
      - "{objective_1}"

    lessons:
      - lesson_id: "1.1"
        lesson_number: "Aula 1.1"
        lesson_title: "{title}"
        lesson_description: "{description}"
        file_path: "lessons/1.1-{slug}.md"
        duration_minutes: {duration}
        learning_objectives:
          - "{objective_1}"
        bloom_level: "{level}"
        difficulty: "{easy|medium|hard}"
        prerequisites:
          - "{prerequisite or 'Nenhum'}"
        key_concepts:
          - "{concept_1}"
        activities:
          - type: "{exercise|quiz|project}"
            description: "{description}"

# Assessments
assessments:
  - assessment_id: "{uuid}"
    type: "quiz"
    title: "{title}"
    module: {module_id}
    file_path: "assessments/quiz-module-{id}.yaml"
    duration_minutes: 20
    num_questions: 10
    passing_score: 70

  - assessment_id: "{uuid}"
    type: "project"
    title: "{title}"
    module: "final"
    file_path: "assessments/final-project.md"
    duration_hours: {hours}
    deliverable: "{what_student_creates}"

# Resources
resources:
  templates:
    - title: "{template_name}"
      file_path: "resources/{file}.yaml"
      description: "{description}"

  checklists:
    - title: "{checklist_name}"
      file_path: "resources/{file}.md"
      description: "{description}"

  tools:
    - name: "{tool_name}"
      url: "{url}"
      description: "{description}"
      cost: "free | paid | freemium"

  readings:
    - title: "{title}"
      author: "{author}"
      url: "{url}"
      type: "book | article | video"

# Validation Scores
validation:
  alignment_score: {score}
  completeness_score: {score}
  fidelity_score: {score}
  cognitive_load_balanced: {true|false}
  duration_realistic: {true|false}

# Commercial Metadata
commercial:
  pricing_model: "{model}"
  price: {price}
  currency: "BRL"
  platform: "{platform}"
  status: "draft"

# Tracking
tracking:
  total_students: 0
  completion_rate: 0
  avg_rating: 0
  avg_completion_time_hours: 0

# Tags & Categories
tags:
  - "{tag_1}"
  # ... all tags

categories:
  - "{category_1}"

# Version History
version_history:
  - version: "1.0"
    date: "{timestamp}"
    changes: "Initial release - generated from course brief"
    author: "{responsible}"
```

3. course-outline.md:

```markdown
# Course Outline: {course_title}

{generate_detailed_outline_from_curriculum_yaml}
```

SAVE ALL FILES:
  - Write README.md to base_path
  - Write curriculum.yaml to base_path
  - Write course-outline.md to base_path
  - Write all lesson files to lessons/
  - Write all assessment files to assessments/
  - Write all resource files to resources/
  - Keep COURSE-BRIEF.md in base_path (reference)
```

**Step 5.2: Database Logging (Optional)**

```
IF database exists at SQLite legado (migrado para Supabase em 2025-10):

TABLE: courses

INSERT:
  course_id: UUID
  title: string
  slug: string
  mode: "mmos | custom | generic"
  instructor_name: string | null
  instructor_source: "MMOS | Custom | Generic" | null
  persona_fidelity: float | null
  target_audience: text (ICP summary)
  learning_objectives: JSON array
  total_duration_hours: float
  num_modules: int
  num_lessons: int
  knowledge_level: string
  pedagogical_framework: string
  teaching_style: string
  quality_reference: string
  alignment_score: float
  completeness_score: float
  file_path: string
  created_at: timestamp
  updated_at: timestamp
  status: "draft | published"
  generated_from_brief: boolean (true)

RELATED TABLES:
  - lessons (lesson details)
  - assessments (quiz/project details)
  - resources (supplementary materials)
```

**Step 5.3: Generation Summary Report**

```
DISPLAY TO USER:

===================================
✓ Course Generated Successfully!
===================================

📚 {course_title}
{tagline}

⏱️  {total_hours} hours | 📖 {num_lessons} lessons | 🎯 {num_modules} modules
👤 Instrutor: {instructor_name}

---

📊 QUALITY SCORES:

✓ Alignment: {alignment_score}% ({grade})
  - Objectives Coverage: {coverage_score}%
  - Bloom's Progression: {progression_valid}
  - Content-Assessment Alignment: {content_assessment_score}

✓ Completeness: {completeness_score}% ({grade})
  - All required components present

{IF mode != "generic"}
✓ Voice Fidelity: {fidelity_score}% ({grade})
  - Vocabulary: {vocab_score}%
  - Syntax: {syntax_score}%
  - Style: {style_score}%
  - Thinking: {thinking_score}%
{END IF}

✓ Cognitive Load: {balanced ? "Balanced ✓" : "Needs Review ⚠"}

✓ Duration: {realistic ? "Realistic ✓" : "Adjusted"}

---

📁 FILES CREATED:

Root Files:
  - README.md
  - course-outline.md
  - curriculum.yaml
  - COURSE-BRIEF.md (reference)

Lessons ({num_lessons} files):
  - lessons/1.1-{slug}.md
  - lessons/1.2-{slug}.md
  ... ({num_lessons} total)

Assessments ({num_assessments} files):
  - assessments/quiz-module-1.yaml
  - assessments/quiz-module-2.yaml
  - assessments/final-project.md

Resources ({num_resources} files):
  - resources/checklist-{name}.md
  - resources/template-{name}.yaml
  - resources/tool-list.md
  - resources/reading-list.md
  - resources/glossary.md

Location: outputs/courses/{course-slug}/

{IF database_logged}
Database:
  - Saved to: SQLite legado (migrado para Supabase em 2025-10) → courses table
  - Course ID: {uuid}
{END IF}

---

🎯 NEXT STEPS:

1. Review Generated Content
   - Read README.md for overview
   - Sample 2-3 lessons for quality
   - Review assessments

2. Test Course Flow
   - Follow lesson progression
   - Complete one activity
   - Take one quiz

3. Refine (if needed)
   - Adjust specific lessons
   - Add examples
   - Update assessments

4. Publish
   - Export to {platform} (if specified)
   - Launch course
   - Track metrics

---

What would you like to do next?

1. 📖 Preview course (show README + sample lesson)
2. 📊 Review validation report (detailed scores)
3. 🔄 Regenerate specific lesson
4. 📤 Export to platform (future feature)
5. ✅ Approve and close

Enter your choice (1-5):

===================================
```

---

## 🎯 Quality Standards

**Pedagogical Quality:**
- Alignment score: ≥ 90%
- Completeness score: 100%
- Cognitive load: Balanced (no overload flags)
- Bloom's progression: Logical (low → high)

**Voice Quality (if expert mode):**
- Fidelity score: ≥ 85% (custom) or ≥ 90% (MMOS)
- Signature phrases: 30-60% usage
- Example types: 80%+ match instructor style

**User Satisfaction:**
- Requires editing: < 20% of content
- Structure approval: User approves outline without major changes
- Time savings: 80% reduction vs. manual creation

**Technical:**
- Generation time:
  * Mini-course (3-5 lessons): < 15 minutes
  * Standard course (8-15 lessons): < 30 minutes
  * Extended course (20-40 lessons): < 60 minutes
- Error rate: < 5% (95% successful generations)

---

## ⚠️ Error Handling

**Common Errors & Recovery:**

1. **Brief Incomplete**
   - Trigger: Required fields missing
   - Action: List missing fields, HALT, ask user to complete
   - DO NOT proceed until brief is 100% complete

2. **MMOS Mind Not Found**
   - Trigger: Specified mind doesn't exist in outputs/minds/
   - Action: List available minds, offer custom profile option

3. **Low Alignment Score (< 90%)**
   - Trigger: Generated course doesn't meet pedagogical targets
   - Action: Show validation report, regenerate flagged lessons, re-validate

4. **Low Fidelity Score (< target)**
   - Trigger: Voice consistency below threshold
   - Action: Show fidelity report, regenerate with stronger voice guidance

5. **Cognitive Overload**
   - Trigger: Lesson exceeds density thresholds
   - Action: Split dense lessons, move concepts to later lessons

6. **Duration Mismatch**
   - Trigger: Calculated duration ±25% off declared
   - Action: Adjust duration or trim content, get user approval

7. **API Rate Limit**
   - Trigger: Claude API 429 error
   - Action: Exponential backoff retry (5s, 15s, 45s), save partial progress

8. **Generation Timeout**
   - Trigger: Course generation > 1 hour
   - Action: Save partial course, offer resume option

---

## 🔄 Workflow Summary

```
1. LOAD BRIEF
   ↓
2. VALIDATE COMPLETENESS
   ↓
3. LOAD PERSONA (if applicable)
   ↓
4. APPLY FRAMEWORK
   ↓
5. GENERATE STRUCTURE
   ↓
6. [HITL] USER APPROVES OUTLINE
   ↓
7. GENERATE LESSONS
   ↓
8. GENERATE ASSESSMENTS
   ↓
9. GENERATE RESOURCES
   ↓
10. VALIDATE ALIGNMENT
    ↓
11. VALIDATE COMPLETENESS
    ↓
12. VALIDATE FIDELITY (if expert)
    ↓
13. VALIDATE COGNITIVE LOAD
    ↓
14. VALIDATE DURATION
    ↓
15. GENERATE FILES
    ↓
16. LOG TO DATABASE (if available)
    ↓
17. PRESENT SUMMARY REPORT
    ↓
18. [HITL] USER REVIEWS & APPROVES
```

---

## 📚 Framework References

**Pedagogical Frameworks:**
- Bloom's Taxonomy (Anderson & Krathwohl, 2001)
- ADDIE Model (Branch, 2009)
- Microlearning (Giurgiu, 2017)
- Kolb's Experiential Learning Cycle (Kolb, 1984)
- Backward Design (Wiggins & McTighe, 2005)

**Cognitive Load Theory:**
- Sweller, J. (1988). Cognitive load during problem solving
- Mayer, R. E. (2009). Multimedia Learning

**Voice Fidelity:**
- MMOS Mind Mapper Framework (2025)
- Natural Language Generation Evaluation Metrics

---

## 🚀 Usage Example

**Input:** Filled COURSE-BRIEF.md for "Clone IA Express"

**Command:** `*continue-course clone-ia-express`

**Output:**
- 9 complete lessons (Markdown)
- 3 quizzes (YAML)
- 1 final project (Markdown)
- 5 resources (checklists, templates, tools)
- README, curriculum.yaml, course-outline.md
- Quality scores: Alignment 94%, Completeness 100%, Fidelity 91%

**Time:** ~25 minutes

**Quality:** Ready to publish with < 10% manual editing

---

**Version:** 2.0
**Created by:** James (Dev Agent) for AIOS CreatorOS
**Date:** 2025-10-17
**License:** MIT
**Framework:** AIOS-FULLSTACK - The Operating System for Digital Creators

---

*This mega prompt unifies the entire CreatorOS course generation workflow into a single, comprehensive document. Use it to transform any filled COURSE-BRIEF.md into a complete, pedagogically sound online course with instructor voice preservation and rigorous quality validation.*
