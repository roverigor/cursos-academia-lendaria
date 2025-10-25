# CreatorOS Workflow Usage Guide

**Version:** 3.0
**Last Updated:** 2025-10-18
**Status:** Production Ready

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Workflow Types](#workflow-types)
3. [Greenfield Workflow](#greenfield-workflow)
4. [Brownfield Workflow](#brownfield-workflow)
5. [Command Reference](#command-reference)
6. [Troubleshooting](#troubleshooting)

---

## Overview

CreatorOS provides **2 workflow orchestrators** for course creation:

| Workflow | Purpose | When to Use |
|----------|---------|-------------|
| **greenfield-course.yaml** | Create from scratch | No existing materials |
| **brownfield-course.yaml** | Upgrade existing course | Legacy materials to modernize |

Both workflows implement:
- ✅ GPS Framework (Goal → Position → Steps)
- ✅ Didática Lendária (7 Elements)
- ✅ MMOS Voice Integration (optional)
- ✅ Quality Validation (automated)
- ✅ Resume Support (checkpoint-based)

---

## Workflow Types

### **Greenfield Workflow**

**Location:** `expansion-packs/creator-os/workflows/greenfield-course.yaml`

**Purpose:** Create online courses from scratch with no existing materials.

**Phases:**
1. **Initialize** - Create course structure, select MMOS persona
2. **Fill COURSE-BRIEF** - User fills 8 sections manually
3. **Generate Curriculum** - AI generates module/lesson structure
4. **Approve Curriculum** - User reviews and approves
5. **Generate Lessons** - AI generates GPS + DL compliant lessons
6. **Validate & Finalize** - Quality validation + assessment generation

**Estimated Time:**
- Mini-course (3-5 lessons): 15-30 minutes
- Standard course (8-15 lessons): 30-60 minutes
- Extended course (20-40 lessons): 60-90 minutes

---

### **Brownfield Workflow**

**Location:** `expansion-packs/creator-os/workflows/brownfield-course.yaml`

**Purpose:** Upgrade existing course materials to CreatorOS structure.

**Phases:**
1. **Initialize** - Validate existing materials, select MMOS persona
2. **Organize Files** - Auto-organize into canonical structure
3. **Extract Content** - Parallel extraction (ICP, Voice, Objectives)
4. **Analyze Gaps** - Identify missing/incomplete sections
5. **Fill Gaps** - User reviews auto-extraction + fills gaps
6. **Generate Curriculum** - AI generates modernized structure
7. **Approve Curriculum** - User reviews and approves
8. **Generate Lessons** - AI modernizes lessons (GPS + DL)
9. **Validate & Finalize** - Quality validation + assessment generation

> 🎧 **New:** After the organization step the workflow looks at
> `sources/videos/`, converts every video to `lesson{n}.mp3`, and generates a
> matching transcript (`lesson{n}.transcript.md`) automatically. Install
> `ffmpeg` and set `ASSEMBLYAI_API_KEY` once to enable this automation.

**Estimated Time:**
- Small course (3-5 lessons): 20-40 minutes
- Medium course (8-15 lessons): 40-90 minutes
- Large course (20-40 lessons): 90-180 minutes

**Auto-extraction Time:** 2-5 minutes (parallel)

---

## Greenfield Workflow

### **Step-by-Step Guide**

#### **Step 1: Activate Course Architect Agent**

```bash
# In Claude Code
/CreatorOS:agents:course-architect
```

**Agent greets:**
```
🎓 I am your Course Architect - Pedagogical Design Expert.
I specialize in creating high-quality online courses with rigorous
instructional frameworks, authentic voice preservation (via MMOS
integration), and ICP-driven design.

Type `*help` to see what I can do.
```

---

#### **Step 2: Start Greenfield Workflow**

```bash
# User types:
*greenfield
```

**Agent executes workflow:**

**2.1. Initialize Course Structure**

```
What is the course identifier (slug)?
Format: lowercase, hyphens only (e.g., "my-course-name")
Examples: dominando-obsidian, python-basics, team-onboarding

Course slug: ___
```

**User input:** `dominando-obsidian`

**2.2. MMOS Persona Selection (Optional)**

```
🧠 MMOS PERSONA INTEGRATION (Optional)

Load instructor voice from MMOS cognitive clone?

Benefits:
  ✅ 90%+ voice fidelity (authentic instructor personality)
  ✅ Auto-populated voice section in COURSE-BRIEF
  ✅ No need for manual voice definition

Use MMOS persona?
  1. Yes - Scan for available minds
  2. No - I'll define voice manually

Your choice (1 or 2): ___
```

**User input:** `1` (Yes)

**2.3. Select MMOS Mind**

```
📋 Available MMOS Personas:
  1. joao_lozano
  2. pedro_valerio
  3. adriano_de_marqui

Select persona (number or slug): ___
```

**User input:** `1`

**2.4. Course Structure Created**

```
✅ GREENFIELD COURSE INITIALIZED!

📂 Course: dominando-obsidian
📄 Brief: outputs/courses/dominando-obsidian/COURSE-BRIEF.md
🧠 MMOS: joao_lozano

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 NEXT STEPS:

1. Fill COURSE-BRIEF.md (all 8 sections):
   → Open: outputs/courses/dominando-obsidian/COURSE-BRIEF.md

   Sections to fill:
     ✓ Section 1: Basic Info (title, subtitle, duration)
     ✓ Section 2: ICP (demographics, pain points, goals)
     ✓ Section 3: Content & Pedagogy (objectives, outline)
     ✓ Section 4: Voice & Personality (tone, style)
     ✓ Section 5: Format & Delivery (teaching style)
     ✓ Section 6: Commercial (pricing, revenue targets)
     ✓ Section 7: Success Metrics (KPIs, completion targets)
     ✓ Section 8: Constraints (limitations, requirements)

2. When COURSE-BRIEF is complete, continue with:
   → *generate-curriculum dominando-obsidian

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

#### **Step 3: Fill COURSE-BRIEF.md (Manual)**

**Duration:** 15-60 minutes

**Action:** Open `outputs/courses/dominando-obsidian/COURSE-BRIEF.md` and fill all 8 sections.

**Tips:**
- Section 1: Be specific about duration and prerequisites
- Section 2: Use ICP archetypes (Beginner, Intermediate, Expert)
- Section 3: Use Bloom's Taxonomy verbs for objectives
- Section 4: If MMOS enabled, review auto-populated voice
- Sections 5-8: Be realistic about constraints and metrics

---

#### **Step 4: Generate Curriculum**

**User types:**
```bash
*generate-curriculum dominando-obsidian
```

**Agent executes:**

```
📖 Loading COURSE-BRIEF.md...
✅ Loaded: Dominando Obsidian
   Mode: greenfield
   Duration: 10 hours
   Objectives: 8
   Voice: mmos (joao_lozano)

🤖 Generating curriculum structure...
(This may take 30-60 seconds)

✅ MVP curriculum structure generated
   Modules: 3
   Total lessons: 10

💾 Saving curriculum to: outputs/courses/dominando-obsidian/curriculum.yaml

📊 CURRICULUM SUMMARY:
   Course: Dominando Obsidian
   Modules: 3
   Lessons: 10
   Duration: 10 hours

   Module 1: Introduction & Fundamentals
      Lessons: 4

   Module 2: Application & Practice
      Lessons: 4

   Module 3: Mastery & Advanced Topics
      Lessons: 2

✅ CURRICULUM GENERATION COMPLETE!

📝 NEXT STEPS:
   1. Review curriculum: cat outputs/courses/dominando-obsidian/curriculum.yaml
   2. Generate course: *generate-lessons dominando-obsidian
```

---

#### **Step 5: Review & Approve Curriculum**

**Duration:** 5-15 minutes

**Action:** Review `curriculum.yaml` structure.

**Options:**
1. ✅ **Approve** → Continue to lesson generation
2. ✏️ **Edit curriculum.yaml** → Customize modules/lessons, then re-run with `--force`
3. ✏️ **Edit COURSE-BRIEF.md** → Adjust objectives, then regenerate curriculum

**To approve, user types:**
```bash
*generate-lessons dominando-obsidian
```

---

#### **Step 6: Generate All Lessons**

**Agent executes 8-step workflow:**

```
STEP 1: Validate course exists ✅
STEP 2: Load COURSE-BRIEF.md ✅
STEP 3: Load curriculum.yaml ✅
STEP 4: Curriculum approval checkpoint ✅ (already approved)

STEP 5: LESSON GENERATION (GPS + DIDÁTICA LENDÁRIA)

Generating lesson 1.1: Course Overview...
  ✅ GPS Validation: 30/30 (100%)
  ✅ DL Validation: 85/100 (85%)
  ✅ Saved: outputs/courses/dominando-obsidian/lessons/1.1-course-overview.md

Generating lesson 1.2: Core Concepts...
  ✅ GPS Validation: 30/30 (100%)
  ✅ DL Validation: 90/100 (90%)
  ✅ Saved: outputs/courses/dominando-obsidian/lessons/1.2-core-concepts.md

[... 8 more lessons]

STEP 6: COURSE QUALITY VALIDATION

  ✅ GPS Validation: 10/10 lessons passed (100%)
  ✅ DL Validation: 10/10 lessons passed (100%)
  ⚠️ Voice Fidelity: Not validated (MVP stub)
  ✅ Bloom's Progression: Valid
  ✅ Duration Accuracy: 10.2h (±2% from target)

STEP 7: ASSESSMENT GENERATION

  ✅ Generated quiz-module-1.yaml
  ✅ Generated quiz-module-2.yaml
  ✅ Generated quiz-module-3.yaml
  ✅ Generated final-project.md

STEP 8: CLEANUP & SUMMARY

✅ COURSE GENERATION COMPLETE!

Course: dominando-obsidian
Location: outputs/courses/dominando-obsidian/

Lessons: 10/10 generated
Time: 8.5 minutes
Cost: $4.20 USD

Quality validation: PASSED
  - GPS: 100%
  - DL: 95%
  - Voice: 90% (MMOS fidelity)

📂 OUTPUT FILES:
   outputs/courses/dominando-obsidian/
   ├── COURSE-BRIEF.md
   ├── curriculum.yaml
   ├── lessons/ (10 files)
   └── assessments/ (4 files)

🎯 NEXT STEPS:
   1. Review generated lessons
   2. Edit assessment scaffolds (replace [EDIT ME] placeholders)
   3. Test with sample students
   4. Run validation: *validate-course dominando-obsidian
```

---

#### **Step 7: Review & Finalize (Manual)**

**Action:** Review generated content and finalize.

**Tasks:**
1. **Review Lessons:**
   - Check GPS structure (Goal → Position → Steps)
   - Verify voice consistency
   - Validate technical accuracy

2. **Edit Assessments:**
   - ⚠️ **IMPORTANT:** Quiz YAML files have `[EDIT ME]` placeholders
   - Replace with real questions and scenarios
   - Design effective distractors

3. **Optional Validation:**
   ```bash
   *validate-course dominando-obsidian
   ```

4. **Iterate:**
   - Regenerate specific lessons if needed
   - Update curriculum.yaml and regenerate

5. **Publish:**
   - Export to LMS
   - Deploy to course platform
   - Launch to students

---

## Brownfield Workflow

### **Step-by-Step Guide**

#### **Prerequisites**

**Before starting:**
1. Create course folder: `mkdir -p outputs/courses/{slug}/`
2. Add existing materials to folder:
   - Transcripts (.txt, .srt, .docx)
   - Videos (.mp4, .mov)
   - Documents (.pdf, .docx)
   - Images (.jpg, .png)

---

#### **Step 1: Activate Course Architect Agent**

```bash
/CreatorOS:agents:course-architect
```

---

#### **Step 2: Start Brownfield Workflow**

```bash
*brownfield
```

**Agent executes workflow:**

**2.1. Initialize Brownfield Course**

```
What is the course identifier (slug)?
Course slug: ___
```

**User input:** `meu-curso-antigo`

**Agent validates:**
```
✅ Folder exists: outputs/courses/meu-curso-antigo/
✅ Files detected: 47 files (transcripts, videos, docs)

Proceeding with brownfield workflow...
```

**2.2. MMOS Persona Selection**

```
Use MMOS persona?
  1. Yes - Auto voice (skip extraction)
  2. No - Extract voice from transcripts

Your choice (1 or 2): ___
```

**User input:** `2` (No, extract from transcripts)

---

#### **Step 3: Organize Files**

**Agent executes file organization:**

```
📁 ORGANIZING EXISTING FILES...

Scanning course folder...

📊 File Organization Preview (Dry Run):

Found 47 files:
  - 12 transcripts → /sources/transcripts/
  - 8 videos → /sources/videos/
  - 3 ICP documents → /sources/
  - 1 instructor profile → /sources/
  - 15 resources → /resources/
  - 5 images → /resources/
  - 2 structured data → root (preserved)
  - 1 unknown files → /sources/other/

Duration: 0.8 seconds

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Review the organization plan above.

This will organize your 47 files into the canonical structure.
No files will be deleted (only moved). A full audit log will be generated.

Options:
1. Approve and execute organization
2. Skip organization (I'll organize manually)
3. Cancel and exit

Your choice (1/2/3): ___
```

**User input:** `1` (Approve)

**Agent executes:**
```
✅ Organized 47 files
   Audit log: outputs/courses/meu-curso-antigo/.state/file-organization-audit.log
```

---

#### **Step 4: Auto-Extraction (Parallel)**

**Agent runs 3 extractors in parallel:**

```
🤖 RUNNING AUTO-EXTRACTION (2-5 minutes)

Running in parallel:
  - Extracting ICP...
  - Extracting Voice...
  - Inferring Objectives...

[Progress bar: ████████████████████████ 100%]

✅ AUTO-EXTRACTION COMPLETE!

📊 Results:
  - ICP: 85% confidence
    * Demographics: 90%
    * Pain Points: 85%
    * Goals: 80%

  - Voice: 75% confidence
    * Tone: Casual, enthusiastic (80%)
    * Signature Phrases: 15 detected (70%)
    * Teaching Approach: Storytelling (75%)

  - Objectives: 12 inferred
    * Bloom's levels: Remember (2), Understand (4), Apply (4), Analyze (2)
    * ICP alignment: 85%

Duration: 3.2 minutes
```

---

#### **Step 5: Analyze Gaps**

**Agent analyzes COURSE-BRIEF completeness:**

```
📋 GAP ANALYSIS REPORT

Overall Completeness: 68%

Section 1: Basic Info
  ✅ Title: Present (from folder name)
  ❌ Subtitle: Missing
  ⚠️ Duration: Low confidence (inferred: 8h from transcript length)

Section 2: ICP
  ✅ Demographics: 85% confidence
  ✅ Pain Points: 90% confidence
  ⚠️ Goals: 60% confidence (manual review suggested)

Section 3: Content & Pedagogy
  ✅ Objectives: 12 inferred (85% confidence)
  ❌ Preliminary Outline: Missing
  ✅ Pedagogical Framework: GPS + DL (default)

Section 4: Voice & Personality
  ✅ Tone: 75% confidence (extracted from transcripts)
  ⚠️ Signature Phrases: 15 detected (review top 5)
  ✅ Teaching Approach: Storytelling (75%)

Section 5: Format & Delivery
  ❌ Teaching Style: Not detected
  ❌ Content Formats: Not detected

Section 6: Commercial
  ❌ Pricing: Not detected
  ❌ Revenue Targets: Not detected

Section 7: Success Metrics
  ❌ KPIs: Not defined

Section 8: Constraints
  ❌ Limitations: Not defined

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✋ WORKFLOW HALTED

Please review auto-extracted content and fill remaining gaps:
  outputs/courses/meu-curso-antigo/COURSE-BRIEF.md

Sections needing manual review:
  - Section 1: Add subtitle, confirm duration
  - Section 2: Review ICP goals (60% confidence)
  - Section 3: Add preliminary outline
  - Section 4: Review signature phrases
  - Sections 5-8: Fill all fields

Optional: Re-run extractors if needed:
  - *extract-icp meu-curso-antigo --force
  - *extract-voice meu-curso-antigo --force
  - *infer-objectives meu-curso-antigo --force

When ready, continue with:
  *generate-curriculum meu-curso-antigo
```

---

#### **Step 6: Fill Gaps (Manual)**

**Duration:** 10-30 minutes

**Action:** Review `COURSE-BRIEF.md` and fill gaps.

**Tips:**
- Review auto-extracted ICP (validate accuracy)
- Check voice patterns (top 5 signature phrases)
- Validate inferred objectives (completeness)
- Fill missing sections (5-8)

---

#### **Steps 7-9: Same as Greenfield**

- Generate curriculum
- Approve curriculum
- Generate lessons
- Validate & finalize

---

## Command Reference

### **Course Architect Commands**

| Command | Description | Example |
|---------|-------------|---------|
| `*greenfield` | Start greenfield workflow | Creates course from scratch |
| `*brownfield` | Start brownfield workflow | Upgrades existing materials |
| `*validate-course` | Run quality validation | Validates GPS, DL, voice |
| `*help` | Show all commands | Lists available commands |
| `*exit` | Exit agent mode | Returns to base Claude |

### **Deprecated Commands**

| Command | Status | Replacement |
|---------|--------|-------------|
| `*generate-course` | DEPRECATED | Use `*greenfield` or `*brownfield` |

---

## Troubleshooting

### **Greenfield Issues**

**Problem: "Course already exists"**
```
❌ Course '{slug}' already exists
```

**Solution:**
```bash
# Option 1: Use different slug
# Option 2: Use brownfield mode
*brownfield {slug}

# Option 3: Delete existing course
rm -rf outputs/courses/{slug}
```

---

**Problem: "COURSE-BRIEF validation failed"**
```
❌ COURSE-BRIEF validation failed:
   - Section 1: Title is missing or too short
   - Section 3: No learning objectives defined
```

**Solution:** Fill missing sections in `COURSE-BRIEF.md` and retry.

---

### **Brownfield Issues**

**Problem: "Folder does not exist"**
```
❌ Course '{slug}' not found (use greenfield mode)
```

**Solution:**
```bash
# Create folder and add materials
mkdir -p outputs/courses/{slug}/
cp /path/to/materials/* outputs/courses/{slug}/
```

---

**Problem: "Low confidence extractions"**
```
⚠️ Voice: 45% confidence (minimum 5,000 words required)
```

**Solution:**
- Add more transcripts (5,000+ words minimum)
- OR use MMOS persona (skip extraction)
- OR define voice manually

---

**Problem: "File organization failed"**
```
⚠️ File organization failed: Permission denied
```

**Solution:**
```bash
# Check permissions
chmod -R u+w outputs/courses/{slug}/

# Or organize manually:
mkdir -p outputs/courses/{slug}/sources/{transcripts,videos}
mkdir -p outputs/courses/{slug}/resources
```

---

## Performance Benchmarks

### **Greenfield Course**

| Course Size | Lessons | Duration | Cost (USD) |
|-------------|---------|----------|------------|
| Mini | 3-5 | 15-30 min | $1-2 |
| Standard | 8-15 | 30-60 min | $3-8 |
| Extended | 20-40 | 60-90 min | $10-25 |

### **Brownfield Course**

| Course Size | Lessons | Duration | Cost (USD) |
|-------------|---------|----------|------------|
| Small | 3-5 | 20-40 min | $1-3 |
| Medium | 8-15 | 40-90 min | $4-10 |
| Large | 20-40 | 90-180 min | $12-30 |

**Note:** Brownfield adds 2-5 min for auto-extraction (parallel execution).

---

## Next Steps

- **For Developers:** See [REFACTORING-PLAN.md](./REFACTORING-PLAN.md) for task atomization roadmap
- **For Users:** See [QUICK-START.md](../QUICK-START.md) for simplified usage guide
- **For Architects:** See workflow YAML files for detailed orchestration logic

---

**Last Updated:** 2025-10-18
**Version:** 3.0
**Workflows:** greenfield-course.yaml, brownfield-course.yaml
