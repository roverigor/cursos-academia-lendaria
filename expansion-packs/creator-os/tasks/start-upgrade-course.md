# Task: Start Upgrade Course

**Type:** Workflow Orchestrator
**Command:** `*upgrade {slug}`
**Duration:** Automated (20-90 min total with user input)

## Purpose

One-command upgrade of existing course materials. This task orchestrates the entire brownfield workflow automatically.

---

## Inputs

### Required
- `slug` (string, 3-50 chars, kebab-case) - Course identifier

### Optional
- `--source-folder {path}` - Path to legacy materials (defaults to prompt)
- `--mmos-persona {mind_name}` - Use MMOS persona for voice
- `--skip-validation` - Skip final validation step

---

## Workflow Execution

This task executes the **brownfield-course.yaml** workflow end-to-end:

```yaml
1. Create course structure (outputs/courses/{slug}/)
2. Organize legacy files into standard structure
3. Run 3 parallel extractors (ICP, Voice, Objectives)
4. Analyze gaps in COURSE-BRIEF
5. HALT → User fills gaps manually
6. Generate curriculum.yaml
7. HALT → User approves curriculum
8. Generate lessons (upgrading existing content)
9. Generate assessments
10. Run validation
```

---

## Steps

### Step 1: Validate Input

```bash
# Validate slug
if ! [[ "$slug" =~ ^[a-z0-9-]{3,50}$ ]]; then
  echo "❌ Invalid slug format"
  exit 1
fi

# Check if course exists (brownfield can create OR upgrade)
if [ -d "outputs/courses/$slug" ]; then
  echo "⚠️  Course exists - will upgrade existing materials"
fi
```

### Step 2: Organize Legacy Files

Execute: `python expansion-packs/creator-os/scripts/organize_files.py "$slug"`

**Prompts user for:**
- Source folder path
- File organization preferences

**Output:**
```
outputs/courses/{slug}/
├── sources/
│   ├── raw/ (original files)
│   └── organized/ (categorized)
└── .metadata.json
```

### Step 3: Parallel Auto-Extraction (3 extractors)

Run in parallel:
```bash
python expansion-packs/creator-os/scripts/extract_icp.py "$slug" &
python expansion-packs/creator-os/scripts/extract_voice.py "$slug" &
python expansion-packs/creator-os/scripts/infer_objectives.py "$slug" &
wait
```

**Output:**
```
outputs/courses/{slug}/
├── extractions/
│   ├── icp-extracted.yaml
│   ├── voice-profile.yaml
│   └── objectives-inferred.yaml
└── COURSE-BRIEF.md (partially filled)
```

### Step 4: Analyze Gaps

Execute: `python expansion-packs/creator-os/scripts/analyze_gaps.py "$slug"`

Display gap analysis:
```
📊 COURSE-BRIEF Gap Analysis:

✅ Auto-filled sections (50%):
  - Section 2: ICP (80% complete)
  - Section 4: Voice Profile (70% complete)
  - Section 3: Learning Objectives (60% complete)

⚠️  Sections requiring manual input (50%):
  - Section 1: Basic Info (title, subtitle)
  - Section 5: Format & Delivery
  - Section 6: Commercial Info
  - Section 7: Success Metrics
  - Section 8: Constraints
```

### Step 5: User Fills Gaps ⏸️

**WORKFLOW HALT - Manual Step Required**

```
📝 Next Step: Complete COURSE-BRIEF.md

Location: outputs/courses/{slug}/COURSE-BRIEF.md

✅ Already filled (from extraction):
  - ICP demographics and psychographics
  - Voice profile and tone
  - Initial learning objectives

⚠️  Fill these sections manually:
  - Basic Info (title, subtitle, prerequisites)
  - Format & Delivery preferences
  - Commercial info (pricing, revenue)
  - Success metrics (KPIs)
  - Constraints

⏱️  Estimated time: 20-45 minutes

When done, continue with curriculum generation.
```

**STOP EXECUTION HERE**

### Steps 6-8: Same as Greenfield

From here, workflow is identical to `*new`:
- Generate curriculum
- Approve curriculum
- Generate lessons
- Validate
- Display summary

---

## Examples

### Basic Upgrade
```bash
@course-architect *upgrade curso-antigo
```

### With Source Folder
```bash
@course-architect *upgrade marketing-2024 --source-folder ~/Desktop/materiais-curso
```

### With MMOS Persona
```bash
@course-architect *upgrade obsidian-curso --mmos-persona adriano_de_marqui
```

---

## Dependencies

### Python Scripts
- `expansion-packs/creator-os/scripts/organize_files.py`
- `expansion-packs/creator-os/scripts/extract_icp.py`
- `expansion-packs/creator-os/scripts/extract_voice.py`
- `expansion-packs/creator-os/scripts/infer_objectives.py`
- `expansion-packs/creator-os/scripts/analyze_gaps.py`
- `expansion-packs/creator-os/scripts/generate_curriculum.py`
- `expansion-packs/creator-os/scripts/generate_course.py`

### Workflows
- `expansion-packs/creator-os/workflows/brownfield-course.yaml`

---

## Success Criteria

- ✅ All legacy files organized
- ✅ ICP extracted (≥60% completeness)
- ✅ Voice profile extracted (≥60% completeness)
- ✅ Objectives inferred (≥60% completeness)
- ✅ COURSE-BRIEF completed
- ✅ Curriculum generated and approved
- ✅ Lessons upgraded with GPS + DL frameworks
- ✅ Validation passed

---

**Status:** ✅ Production-Ready
**Last Updated:** 2025-10-18
**Agent:** Course Architect
