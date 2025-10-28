# Task: Start New Course

**Type:** Workflow Orchestrator
**Command:** `*new {slug}`
**Duration:** Automated (15-60 min total with user input)

## Purpose

One-command course creation from scratch. This task orchestrates the entire greenfield workflow automatically.

---

## Inputs

### Required
- `slug` (string, 3-50 chars, kebab-case) - Course identifier

### Optional
- `--mmos-persona {mind_name}` - Use MMOS persona for voice (e.g., `--mmos-persona adriano_de_marqui`)
- `--skip-validation` - Skip final validation step (not recommended)

---

## Workflow Execution

This task executes the **greenfield-course.yaml** workflow end-to-end:

```yaml
1. Create course structure (outputs/courses/{slug}/)
2. Generate COURSE-BRIEF.md template
3. HALT → User fills COURSE-BRIEF.md (manual step)
4. Generate curriculum.yaml from brief
5. HALT → User approves curriculum (manual step)
6. Generate all lessons (GPS + Didática Lendária)
7. Generate assessments (quizzes + final project)
8. Run validation (optional)
9. Display summary
```

---

## Steps

### Step 1: Validate Input

```bash
# Validate slug format
if ! [[ "$slug" =~ ^[a-z0-9-]{3,50}$ ]]; then
  echo "❌ Invalid slug format. Use kebab-case (e.g., 'meu-curso-incrivel')"
  exit 1
fi

# Check if course already exists
if [ -d "outputs/courses/$slug" ]; then
  echo "❌ Course '$slug' already exists. Use *upgrade to modify existing courses."
  exit 1
fi
```

### Step 2: Initialize Course Structure

Execute: `python expansion-packs/creator-os/scripts/init_course.py --mode greenfield --slug "$slug"`

**Output:**
```
outputs/courses/{slug}/
├── COURSE-BRIEF.md (template with 8 empty sections)
└── .metadata.json
```

### Step 3: User Fills COURSE-BRIEF ⏸️

**WORKFLOW HALT - Manual Step Required**

Display to user:
```
✅ Course structure created!

📄 Next Step: Fill the COURSE-BRIEF.md file
   Location: outputs/courses/{slug}/COURSE-BRIEF.md

Required sections (8 total):
  1️⃣ Basic Info - Title, subtitle, duration, prerequisites
  2️⃣ ICP - Target audience demographics and psychographics
  3️⃣ Content & Pedagogy - Learning objectives, outline
  4️⃣ Voice & Personality - Instructor tone and style
  5️⃣ Format & Delivery - Teaching methods
  6️⃣ Commercial - Pricing and revenue targets
  7️⃣ Success Metrics - KPIs and completion goals
  8️⃣ Constraints - Limitations and requirements

⏱️  Estimated time: 15-60 minutes

When done, continue with:
  @course-architect *generate-curriculum {slug}

OR run full automated workflow:
  python expansion-packs/creator-os/scripts/run_workflow.py greenfield {slug}
```

**STOP EXECUTION HERE** - Wait for user to complete COURSE-BRIEF.md

### Step 4: Generate Curriculum

Execute: `python expansion-packs/creator-os/scripts/generate_curriculum.py "$slug"`

**Output:**
```
outputs/courses/{slug}/curriculum.yaml
```

### Step 5: Curriculum Approval Checkpoint ⏸️

**WORKFLOW HALT - Approval Required**

Display curriculum summary:
```
✅ Curriculum generated!

📊 Course Structure:
   - Total modules: X
   - Total lessons: Y
   - Estimated duration: Z hours

📄 Review: outputs/courses/{slug}/curriculum.yaml

Options:
  1️⃣ Approve → Generate lessons automatically
  2️⃣ Edit curriculum.yaml → Re-run generation
  3️⃣ Edit COURSE-BRIEF.md → Regenerate curriculum
  4️⃣ Cancel workflow

Type: approve | edit | cancel
```

Wait for user input.

### Step 6: Generate All Lessons (Automated)

If approved, execute: `python expansion-packs/creator-os/scripts/generate_course.py "$slug"`

**8-Step Automated Process:**
1. Load COURSE-BRIEF.md (65 fields)
2. Load curriculum.yaml
3. Generate lessons (GPS + DL validation)
4. Validate course quality
5. Generate assessments
6. Create final project template
7. Run validation checks
8. Display summary

**Output:**
```
outputs/courses/{slug}/
├── COURSE-BRIEF.md
├── curriculum.yaml
├── lessons/
│   ├── 1.1-introducao.md
│   ├── 1.2-conceitos-basicos.md
│   └── ...
├── assessments/
│   ├── module-1-quiz.yaml
│   └── final-project.md
└── .state/ (checkpoints for resume)
```

### Step 7: Validation (Optional)

If `--skip-validation` not set:

Execute: `python expansion-packs/creator-os/scripts/validate_course.py "$slug"`

Display validation results:
```
📊 Validation Results:
   ✅ GPS Structure: 95% (28/30 lessons passed)
   ✅ Didática Lendária: 92% (27/30 lessons passed)
   ⚠️  Voice Fidelity: 88% (target: ≥85%) [if MMOS enabled]
   ✅ Bloom's Progression: Valid
   ✅ Duration Accuracy: ±18% (within ±25% tolerance)

Overall: ✅ PASS
```

### Step 8: Display Completion Summary

```
🎉 Course '{slug}' created successfully!

📂 Location: outputs/courses/{slug}/

Generated Files:
  ✅ COURSE-BRIEF.md (8 sections filled)
  ✅ curriculum.yaml (X modules, Y lessons)
  ✅ lessons/ (Y lesson files - GPS + DL validated)
  ✅ assessments/ (quizzes + final project)

📊 Quality Metrics:
  - GPS Validation: 95%
  - DL Validation: 92%
  - Voice Fidelity: 88% (if MMOS enabled)

⏱️  Generation Time: Xm Ys
💰 Estimated Cost: $X.XX USD

🎯 Next Steps:
  1. Review generated lessons
  2. Complete assessment scaffolds ([EDIT ME] → real content)
  3. Test with beta students (optional)
  4. Iterate based on feedback
  5. Publish to production!

📖 Documentation: expansion-packs/creator-os/README.md
```

---

## Error Handling

### Course Already Exists
```
❌ Error: Course 'meu-curso' already exists.

Options:
  - Use *upgrade meu-curso to modify existing course
  - Choose different slug
  - Delete existing course: rm -rf outputs/courses/meu-curso
```

### Invalid Slug Format
```
❌ Error: Invalid slug 'Meu Curso!'

Valid format:
  - Lowercase letters, numbers, hyphens only
  - 3-50 characters
  - Examples: 'meu-curso', 'obsidian-101', 'marketing-digital-2024'
```

### COURSE-BRIEF Incomplete
```
❌ Error: COURSE-BRIEF.md is incomplete

Missing sections:
  - Section 2: ICP (Ideal Customer Profile)
  - Section 3: Content & Pedagogy

Please fill all 8 sections before continuing.
```

### Generation Interrupted (CTRL+C)
```
⚠️  Generation interrupted!

Progress saved to: outputs/courses/{slug}/.state/lesson-generation.json

Resume with:
  python expansion-packs/creator-os/scripts/generate_course.py {slug} --resume

Or restart from scratch:
  python expansion-packs/creator-os/scripts/generate_course.py {slug} --force
```

---

## Examples

### Basic Usage
```bash
@course-architect *new dominando-obsidian
```

### With MMOS Persona
```bash
@course-architect *new marketing-digital --mmos-persona adriano_de_marqui
```

### Skip Validation (Fast Mode)
```bash
@course-architect *new curso-rapido --skip-validation
```

---

## Dependencies

### Python Scripts
- `expansion-packs/creator-os/scripts/init_course.py`
- `expansion-packs/creator-os/scripts/generate_curriculum.py`
- `expansion-packs/creator-os/scripts/generate_course.py`
- `expansion-packs/creator-os/scripts/validate_course.py`

### Workflows
- `expansion-packs/creator-os/workflows/greenfield-course.yaml`

### Templates
- `expansion-packs/creator-os/templates/COURSE-BRIEF.md`
- `expansion-packs/creator-os/templates/curriculum.yaml`
- `expansion-packs/creator-os/templates/lesson.md`

---

## Notes

- **Execution Time:** 15-60 min total (includes 2 manual halts)
- **Automated Time:** 5-20 min (lesson generation only)
- **Cost Estimate:** $1-25 USD depending on course size
- **Resume Support:** Yes (if interrupted during lesson generation)
- **MMOS Integration:** Optional (for voice preservation)

---

## Success Criteria

- ✅ Course folder created with all required files
- ✅ All lessons pass GPS validation (≥30 points)
- ✅ All lessons pass DL validation (≥70 points)
- ✅ Voice fidelity ≥85% (if MMOS enabled)
- ✅ Bloom's taxonomy progression valid
- ✅ Duration estimates realistic (±25%)
- ✅ User requires <20% manual editing

---

**Status:** ✅ Production-Ready
**Last Updated:** 2025-10-18
**Agent:** Course Architect
