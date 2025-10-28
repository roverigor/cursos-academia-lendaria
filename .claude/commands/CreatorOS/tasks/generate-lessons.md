# Task: Generate Lessons

**Type:** Atomic Task
**Responsibility:** Generate all lesson files with GPS + Didática Lendária frameworks
**Duration:** 5-20 minutes (depends on course size)

## Purpose

Core lesson generation loop. Creates all lesson markdown files from curriculum with GPS structure and Didática Lendária pedagogical elements.

---

## Inputs

- `slug` (required) - Course identifier
- `--resume` (optional) - Resume interrupted generation
- `--force` (optional) - Regenerate all lessons

---

## Execution

```bash
python expansion-packs/creator-os/scripts/generate_course.py "$slug" ${resume:+--resume} ${force:+--force}
```

---

## Process

### 1. Validate Prerequisites
- Check COURSE-BRIEF.md exists and is complete
- Check curriculum.yaml exists
- Verify curriculum approved (if checkpoint exists)

### 2. Load Course Data
- Parse COURSE-BRIEF (65 fields via BriefParser)
- Load curriculum.yaml
- Load MMOS persona (if enabled)

### 3. Generate Lessons Loop

**For each lesson in curriculum:**

a) **Build lesson spec**
   - lesson_id, title, objectives
   - Bloom's level, duration
   - Module context

b) **Generate content with AI**
   - Use GPS template (Goal → Position → Steps)
   - Apply Didática Lendária (7 elements)
   - Inject MMOS voice (if enabled)
   - Generate 800-2,000 words

c) **Validate GPS structure**
   - Score GPS elements (30 points max)
   - Must score ≥30 to pass
   - Retry up to 3x if fails

d) **Validate Didática Lendária**
   - Score 7 DL elements (100 points max)
   - Must score ≥70 to pass
   - Retry up to 3x if fails

e) **Save lesson**
   - Write to `lessons/{lesson_id}.md`
   - Update checkpoint (for resume)
   - Log progress

### 4. Generate Assessments
- Create quiz scaffolds per module (YAML)
- Create final project template (markdown)

### 5. Display Summary
```
✅ Lesson generation complete!

📊 Stats:
  - Lessons generated: 24
  - GPS avg score: 28.5/30 (95%)
  - DL avg score: 82/100 (82%)
  - Total time: 8m 32s
  - Estimated cost: $4.50 USD

📂 Output: outputs/courses/{slug}/lessons/
```

---

## Resume Support

**If interrupted (CTRL+C):**

Progress saved to: `.state/lesson-generation.json`

Resume with:
```bash
python expansion-packs/creator-os/scripts/generate_course.py {slug} --resume
```

**Resume behavior:**
- Skips already-generated lessons
- Continues from last checkpoint
- Validates context unchanged (curriculum.yaml hash)

---

## Output Structure

```
outputs/courses/{slug}/
├── lessons/
│   ├── 1.1-introducao-obsidian.md (GPS + DL validated)
│   ├── 1.2-criando-notas.md
│   ├── 2.1-links-bidirecionais.md
│   └── ...
├── assessments/
│   ├── module-1-quiz.yaml (scaffold with [EDIT ME])
│   ├── module-2-quiz.yaml
│   └── final-project.md (production-ready template)
└── .state/
    └── lesson-generation.json (checkpoints)
```

---

## GPS Validation

**Goal → Position → Steps structure (30 points):**
- Goal (10 pts): Clear learning objective stated
- Position (10 pts): Current state → desired state explained
- Steps (10 pts): Actionable steps to achieve goal

**Pass threshold:** ≥30 points

---

## Didática Lendária Validation

**7 pedagogical elements (100 points):**
1. Hook/Introduction (15 pts)
2. Context/Background (10 pts)
3. Core Concept Explanation (20 pts)
4. Concrete Examples (15 pts)
5. Practice Exercise (15 pts)
6. Common Pitfalls (10 pts)
7. Summary/Recap (15 pts)

**Pass threshold:** ≥70 points

---

## Error Handling

### Curriculum Not Found
```
❌ Error: curriculum.yaml not found

Generate curriculum first:
  @course-architect *generate-curriculum {slug}
```

### Validation Failures
```
⚠️  Lesson 2.3 failed validation (attempt 1/3)
   GPS score: 25/30 (threshold: 30)
   DL score: 68/100 (threshold: 70)

Retrying with adjusted prompt...
```

### Context Changed (Resume)
```
❌ Error: Curriculum changed since last checkpoint

Options:
  - Use --force to regenerate all lessons
  - Restore previous curriculum.yaml
  - Manually resolve conflicts
```

---

## Success Criteria

- ✅ All lessons generated (100% completion)
- ✅ GPS validation: ≥95% lessons pass (≥30 points)
- ✅ DL validation: ≥90% lessons pass (≥70 points)
- ✅ Voice fidelity: ≥85% (if MMOS enabled)
- ✅ All assessments scaffolds created
- ✅ Final project template created

---

**Status:** ✅ Ready
