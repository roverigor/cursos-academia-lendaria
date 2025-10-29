# Brownfield Workflow Guide - CreatorOS

**Created:** 2025-10-18
**Version:** 1.0
**Status:** Phase 1 Implementation (Detection Only)

---

## 📋 Quick Answer

### Q: Qual agente/task é responsável por brownfield no generate-course?

**A: Task `generate-course.md` (v2.1+) com Course Architect Agent**

**Responsabilidade Atual (Phase 1 - Story 3.1):**
- ✅ **Detecção** greenfield vs brownfield
- ✅ **Validação** de modo contra estado do folder
- ✅ **Branching** para workflow apropriado
- ❌ **Extração automática** brownfield (Phase 2 - Stories 3.2-3.4)

---

## 🎯 Componentes Responsáveis

### 1. **Agent: Course Architect** (`course-architect.md`)
- **Role:** Orquestrador do workflow de geração
- **Version:** 2.2+
- **Changelog v2.1:** "Added greenfield/brownfield detection (Story 3.1)"

### 2. **Task: generate-course** (`generate-course.md`)
- **Version:** 2.1+ (current: 2.7)
- **Purpose:** "Initialize course structure with greenfield/brownfield detection"
- **Implementation:** Story 3.1 ✅ Complete

### 3. **Story: STORY-3.1** (`STORY-3.1-greenfield-brownfield-detection.md`)
- **Epic:** EPIC-3: Intelligent Workflow System
- **Status:** ✅ Completed (2025-10-18)
- **Scope:** Detection + Validation (NOT extraction)

---

## 🔄 Current Brownfield Workflow (Phase 1)

### Step 1: Mode Detection
```yaml
Task: generate-course.md
Step: Elicitation Question 2

Prompt:
  "Is this course:
   1. Greenfield - Creating from scratch
   2. Brownfield - Upgrading existing materials"

User selects: 2 (Brownfield)
```

### Step 2: Validation
```yaml
Task: generate-course.md
Step 1.2: mode_validation

Scenario 3 (Brownfield Pass):
  condition: "mode=brownfield AND folder EXISTS"
  result: SUCCESS
  message: |
    ✓ Brownfield mode validated
    ✓ Folder: outputs/courses/{slug}/ (found {N} files)

Scenario 4 (Brownfield Conflict):
  condition: "mode=brownfield AND folder does NOT exist"
  result: ERROR
  recovery_options:
    - Switch to greenfield
    - Create folder manually
    - Check slug spelling
```

### Step 3: Metadata Persistence
```yaml
Task: generate-course.md
Step 1.5: save_metadata

Output: COURSE-BRIEF.md frontmatter
---
creation_mode: brownfield
detected_at: 2025-10-18T14:23:45Z
folder_state_at_start:
  exists: true
  file_count: 42
  has_legacy_materials: true
---
```

### Step 4: HALT & Notify User
```yaml
Task: generate-course.md
Step 1.7: notification_brownfield

Message:
  ✓ Brownfield mode activated!

  📁 Detected:
  - Folder: outputs/courses/{slug}/
  - Files found: 42

  📋 NEXT STEPS - Brownfield Workflow:

  **Phase 2: Material Extraction (Future Implementation)**

  For now (Phase 1 - Manual Path):
  1. Create COURSE-BRIEF.md manually
  2. Fill all sections based on existing materials
  3. Run: *continue-course {slug}

  Status: Brownfield extraction planned for Story 3.2-3.4

workflow_state: HALTED
```

---

## 🚧 Phase 2: Brownfield Extraction (PLANNED)

### Stories 3.2-3.4 (Not Yet Implemented)

**Story 3.2: File Inventory Organization**
- Scan existing materials
- Categorize files (lessons, resources, assets)
- Organize into canonical structure

**Story 3.3: ICP Extraction**
- Extract target audience from existing content
- Identify archetypes and pain points
- Auto-populate Section 2 in COURSE-BRIEF

**Story 3.4: Voice Pattern Extraction**
- Analyze instructor voice from transcripts/lessons
- Extract style markers and vocabulary
- Auto-populate Section 4 in COURSE-BRIEF

**Module:** `expansion-packs/creator-os/lib/file_organizer.py`
- FileOrganizer class
- scan() method
- organize(dry_run=True) preview

---

## 📂 File Locations (Following Workflow Principles)

### Current Implementation (Phase 1):
```yaml
Task Definition:
  location: expansion-packs/creator-os/tasks/generate-course.md
  version: 2.1+

Agent Definition:
  location: expansion-packs/creator-os/agents/course-architect.md
  version: 2.2+

Story Documentation:
  location: expansion-packs/creator-os/stories/STORY-3.1-greenfield-brownfield-detection.md
  status: ✅ Completed

Course Output:
  location: outputs/courses/{slug}/
  metadata: COURSE-BRIEF.md (frontmatter: creation_mode)
```

### Planned Implementation (Phase 2):
```yaml
File Organizer Module:
  location: expansion-packs/creator-os/lib/file_organizer.py
  status: ❌ Not implemented yet

Brownfield Extraction Stories:
  location: expansion-packs/creator-os/stories/
  files:
    - STORY-3.2-file-inventory-organization.md
    - STORY-3.3-icp-extraction.md
    - STORY-3.4-voice-extraction.md
```

---

## 🎬 Usage Examples

### Example 1: Brownfield Detection (Success)

```bash
User: @course-architect
User: *generate-course

Agent: What is the course slug?
User: didatica-lendaria

Agent: Is this course:
       1. Greenfield
       2. Brownfield
User: 2

Agent: ✓ Brownfield mode validated
       ✓ Folder: outputs/courses/didatica-lendaria/ (found 8 files)

       📋 NEXT STEPS - Brownfield Workflow:

       For now (Phase 1):
       1. Create COURSE-BRIEF.md manually in outputs/courses/didatica-lendaria/
       2. Fill all sections
       3. Run: *continue-course didatica-lendaria

       Status: Automated extraction coming in Phase 2
```

### Example 2: Brownfield Conflict (Error Recovery)

```bash
User: *generate-course

Agent: Course slug?
User: new-course

Agent: Mode?
User: 2 (Brownfield)

Agent: ❌ CONFLICT: Brownfield mode selected but no folder found!

       Expected: outputs/courses/new-course/
       Brownfield requires existing materials.

       Options:
       1. Change to Greenfield mode
       2. Create folder manually and add materials
       3. Check slug spelling

       What would you like to do? (1/2/3)

User: 1

Agent: ✓ Switched to Greenfield mode
       Proceeding to create course structure...
```

---

## 🔑 Key Takeaways

### What Works Now (Phase 1):
1. ✅ **Detection:** System asks greenfield vs brownfield
2. ✅ **Validation:** Checks folder existence matches mode
3. ✅ **Error Recovery:** 4 scenarios handled with recovery options
4. ✅ **Metadata:** creation_mode persisted to COURSE-BRIEF.md
5. ✅ **Branching:** Workflow splits based on mode

### What's Coming (Phase 2):
1. ⏳ **File Organization:** Auto-categorize existing materials
2. ⏳ **ICP Extraction:** Auto-populate audience section from content
3. ⏳ **Voice Extraction:** Auto-populate instructor voice from transcripts
4. ⏳ **Auto-Brief Generation:** Complete COURSE-BRIEF from existing materials

### Current Workaround:
- Select "Brownfield" mode → System validates folder exists
- **But:** User still fills COURSE-BRIEF.md manually
- **Then:** Run `*continue-course {slug}` to generate lessons

---

## 📊 Implementation Status

```
Story 3.1: Greenfield/Brownfield Detection  ✅ Complete (2025-10-18)
Story 3.2: File Inventory Organization      ⏳ Planned (Phase 2)
Story 3.3: ICP Extraction Engine            ⏳ Planned (Phase 2)
Story 3.4: Voice Pattern Extraction         ⏳ Planned (Phase 2)

Epic 3: Intelligent Workflow System         🚧 In Progress (25% done)
```

---

## 🎯 For Your Case: Didática Lendária

### Current State:
```bash
Folder: outputs/courses/didatica-lendaria/
Files:
  - COURSE-BRIEF.md (exists, v3.0 provided by user)
  - resources/ (8 files - checklist, templates, etc.)

Mode: Brownfield (folder exists with materials)
```

### Recommended Path:
1. ✅ **Mode Detection:** Already done (brownfield detected)
2. ✅ **COURSE-BRIEF:** Already provided (v3.0 complete)
3. ➡️ **Next Step:** Run `*continue-course didatica-lendaria`

**You're ready to proceed!** The COURSE-BRIEF is complete, so you can skip Phase 2 extraction and go straight to lesson generation.

---

## 📚 Related Documentation

- [WORKFLOW-PRINCIPLES.md](./WORKFLOW-PRINCIPLES.md) - Linear workflow (no file hunting)
- [STORY-3.1](../stories/STORY-3.1-greenfield-brownfield-detection.md) - Detection implementation
- [EPIC-3](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md) - Intelligent workflow epic
- [generate-course.md](../tasks/generate-course.md) - Task definition (v2.1+)
- [course-architect.md](../agents/course-architect.md) - Agent definition (v2.2+)

---

**Summary:**
- **Agent:** Course Architect
- **Task:** generate-course.md (v2.1+)
- **Current:** Detection + Validation only (Phase 1)
- **Future:** Auto-extraction (Phase 2, Stories 3.2-3.4)
- **Your Status:** Ready to proceed with `*continue-course`

---

**Last Updated:** 2025-10-18
**Author:** Course Architect Agent
**Related Story:** STORY-3.1
