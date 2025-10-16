# /generate-course Task

Generate complete online course with pedagogical frameworks, voice preservation, and ICP-driven design.

```yaml
purpose: "Create high-quality courses with 85-90%+ instructor voice fidelity and rigorous instructional design"
prerequisites:
  - Valid instructor persona (MMOS mind, custom profile, or generic mode)
  - Target audience (ICP with archetypes, demographics, psychographics)
  - Learning objectives (clear transformation goals)
interactive: true
estimated_time: "15-60 minutes (depending on course size)"
```

## Elicitação
```
1. Course Mode - Generic (neutral) / Expert-Led (instructor voice) / Legacy Upgrade (transform existing)
2. Instructor Persona - MMOS mind name, custom profile JSON, or skip (generic)
3. Target Audience (ICP) - Who are the learners? (archetypes, demographics, psychographics, knowledge level)
4. Learning Objectives - What should learners achieve by the end? (use Bloom's Taxonomy verbs)
5. Course Duration - How long? (3h mini, 8h standard, 20h+ extended)
6. Pedagogical Framework - Which approach? (Bloom's, ADDIE, Microlearning, Kolb, Backward Design, or auto)
7. Existing Materials - Any legacy content to transform? (optional)
```

## Passos
1. **Discovery & Requirements**
   - Analyze ICP to select appropriate pedagogical framework
   - Map learning objectives to Bloom's Taxonomy levels
   - Determine course structure requirements (modules, lessons, assessments)
   - Validate prerequisites (persona exists, materials accessible)

2. **Curriculum Design**
   - Generate course outline (modules, lessons, learning progression)
   - Design assessment strategy (quizzes, projects, case studies aligned with objectives)
   - Calculate duration estimates (reading time + practice + assessments)
   - **CHECKPOINT:** Get user approval on outline before content generation

3. **Load Instructor Persona** (if Expert-Led mode)
   - If MMOS: Load from `docs/minds/{mind_name}/synthesis/`
   - If custom: Load profile JSON and validate
   - Extract voice parameters and teaching style
   - Set fidelity target (85%+ custom, 90%+ MMOS)

4. **Content Generation**
   - Generate lessons following pedagogical structure
   - Maintain instructor voice consistency (if Expert-Led)
   - Create varied assessment types (quiz, project, case study)
   - Develop supplementary resources (templates, checklists)

5. **Validation**
   - **Alignment Check:** Objectives ↔ Content ↔ Assessments (target: 90%+)
   - **Completeness Check:** All required components present (target: 100%)
   - **Fidelity Check:** Voice consistency (target: 85-90%+ if Expert-Led)
   - **Cognitive Load Check:** No overload (concepts, terms, pacing)
   - **Duration Check:** Time estimates realistic (±25% tolerance)
   - **CHECKPOINT:** Present validation report, offer regeneration if below targets

6. **Output Generation**
   - Create file structure in `docs/courses/{course-slug}/`
   - Generate README, course-outline, curriculum.yaml
   - Save lessons to `lessons/`, assessments to `assessments/`, resources to `resources/`
   - Log to database (`courses`, `lessons`, `assessments` tables)
   - Provide usage instructions and next steps

## Pedagogical Frameworks

**Bloom's Taxonomy** - Cognitive progression (Remember → Create)
- Best for: Skills-based courses, professional development

**ADDIE** - Systematic development (Analysis → Evaluation)
- Best for: Comprehensive course design, corporate training

**Microlearning** - Bite-sized lessons (5-10 min)
- Best for: Busy professionals, just-in-time learning

**Kolb's Learning Cycle** - Experiential learning (Experience → Experiment)
- Best for: Transformational courses, leadership development

**Backward Design** - Start with end goal, work backwards
- Best for: Skill-based courses, certification programs

## Course Modes

**Generic** - Neutral professional voice
- Use case: Corporate training, certification programs
- Fidelity: N/A (no persona)

**Expert-Led** - Specific instructor's voice (MMOS or custom)
- Use case: Thought leader courses, personal brand
- Fidelity target: 85%+ (custom) or 90%+ (MMOS)

**Legacy Upgrade** - Transform existing materials
- Use case: Modernizing old courses, repurposing content
- Fidelity target: Match original voice (85%+)

## Validation Criteria

✅ **Alignment:** 90%+ (objectives ↔ content ↔ assessments)
✅ **Completeness:** 100% (all required components)
✅ **Fidelity:** 85%+ (custom) or 90%+ (MMOS) for Expert-Led
✅ **Cognitive Load:** Balanced (no overload flags)
✅ **Duration:** Realistic (±25% tolerance)
✅ **User Satisfaction:** <20% manual editing required

## Performance Targets
- **Mini-course (3-5 lessons):** < 15 min
- **Standard course (8-15 lessons):** < 30 min
- **Extended course (20-40 lessons):** < 60 min

## Integration
**MMOS:** Load instructor personas from `docs/minds/{mind}/synthesis/`
**InnerLens:** (Optional) Adapt content to audience psychometric profiles (Big Five)
**ETL Data Collector:** (Optional) Transform legacy materials into structured format
**Database:** Track in `courses`, `lessons`, `assessments` tables

## Output Structure
```
docs/courses/{course-slug}/
  ├── README.md                  # Course overview
  ├── course-outline.md          # Complete structure
  ├── curriculum.yaml            # Structured metadata
  ├── lessons/
  │   ├── 1.1-lesson-name.md
  │   ├── 1.2-lesson-name.md
  │   └── 2.1-lesson-name.md
  ├── assessments/
  │   ├── quiz-module-1.yaml
  │   └── final-project.md
  └── resources/
      ├── checklist-setup.md
      └── template-config.yaml
```

---

**Full Task Specification:** `expansion-packs/creator-os/tasks/generate-course.md`
