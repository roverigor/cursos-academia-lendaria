# Task: Generate Curriculum

**Type:** Atomic Task
**Responsibility:** Generate curriculum.yaml from completed COURSE-BRIEF
**Duration:** 1-2 minutes

## Purpose

Transform COURSE-BRIEF.md into structured curriculum (modules, lessons, objectives, Bloom's levels).

---

## Inputs

- `slug` (required) - Course identifier
- `--force` (optional) - Regenerate even if curriculum exists

---

## Execution

```bash
python expansion-packs/creator-os/scripts/generate_curriculum.py "$slug" ${force:+--force}
```

---

## Process

1. **Validate COURSE-BRIEF completeness**
   - Check all 8 sections filled
   - Verify required fields present (65 fields)
   - Exit with error if incomplete

2. **Load COURSE-BRIEF data**
   - Parse with BriefParser (lib/brief_parser.py)
   - Extract learning objectives
   - Extract course outline (if present)

3. **Generate curriculum structure**
   - AI generates modules based on objectives
   - Break into lessons (5-15 per module)
   - Assign Bloom's levels to each lesson
   - Calculate duration estimates

4. **Validate curriculum structure**
   - Verify required YAML fields
   - Check Bloom's progression
   - Validate lesson count (8-40 lessons)

5. **Save curriculum.yaml**

---

## Output

```yaml
# curriculum.yaml
course_title: "Dominando Obsidian"
course_subtitle: "Master Knowledge Management"
total_duration_hours: 12
difficulty_level: "intermediate"

modules:
  - module_id: 1
    module_title: "Fundamentos do Obsidian"
    module_description: "..."
    lessons:
      - lesson_id: "1.1"
        lesson_title: "Introdução ao Obsidian"
        learning_objectives:
          - "Explain core Obsidian concepts"
          - "Navigate Obsidian interface"
        bloom_level: "Understand"
        duration_minutes: 25

      - lesson_id: "1.2"
        lesson_title: "Criando sua primeira nota"
        learning_objectives:
          - "Create notes using markdown"
        bloom_level: "Apply"
        duration_minutes: 30
```

Saved to: `outputs/courses/{slug}/curriculum.yaml`

---

## Error Handling

### COURSE-BRIEF Incomplete
```
❌ Error: COURSE-BRIEF incomplete (45/65 fields filled)

Missing critical fields:
  - Section 1: course_title
  - Section 3: learning_objectives (0 objectives)

Please complete COURSE-BRIEF.md before generating curriculum.
```

### Curriculum Already Exists
```
⚠️  Warning: curriculum.yaml already exists

Options:
  - Use --force to regenerate
  - Edit curriculum.yaml manually
  - Continue with existing curriculum
```

---

## Success Criteria

- ✅ curriculum.yaml created
- ✅ All required YAML fields present
- ✅ Bloom's progression valid (starts low, ends high)
- ✅ Lesson count reasonable (8-40 lessons)
- ✅ Duration estimates realistic

---

**Status:** ✅ Ready
