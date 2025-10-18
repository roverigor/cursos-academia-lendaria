# Task: Generate Course

**Task ID:** generate-course
**Version:** 2.1
**Purpose:** Initialize course structure with greenfield/brownfield detection and unified brief document
**Owner:** Course Architect Agent
**Estimated Time:** 30-60 seconds (initialization only)
**Elicit:** true

---

## Overview

**WORKFLOW v2.1 - Greenfield/Brownfield Detection + Unified Brief**

This task initializes a course by detecting whether you're creating from scratch (greenfield) or upgrading existing materials (brownfield), validating the mode against folder state, and setting up the appropriate workflow.

**What This Task Does:**
1. Prompts for course slug (short identifier)
2. **NEW: Asks greenfield vs brownfield mode**
3. **NEW: Validates mode against folder existence (4 scenarios)**
4. **NEW: Branches to appropriate workflow**
5. Creates `/outputs/courses/{course-slug}/` directory structure (greenfield only)
6. Copies `course-brief.md` template to `COURSE-BRIEF.md` (greenfield only)
7. **HALTS and notifies user with mode-specific next steps**

**What This Task Does NOT Do:**
- Does NOT generate course content (that's `continue-course` task)
- Does NOT ask 15-20 interactive questions (v1.0 deprecated)
- Does NOT elicit requirements incrementally
- Does NOT extract brownfield materials yet (Phase 2: Stories 3.2-3.4)

**Success Criteria:**
- Mode selection validated against folder state (100% accuracy)
- Appropriate workflow executed (greenfield or brownfield)
- creation_mode metadata persisted to COURSE-BRIEF.md
- User notified with clear, context-aware next steps
- Error recovery options provided for conflicts

---

## Input Parameters

### Required Parameters

1. **course_slug** (string, required)
   - Description: Short identifier for the course (used in folder/file names)
   - Example: "clone-ia-express", "python-data-science", "team-onboarding"
   - Validation:
     - Lowercase letters, numbers, hyphens only
     - 3-50 characters
     - Must not already exist in `/outputs/courses/`
   - Format: kebab-case (e.g., "my-course-name")

### Elicitation

```yaml
elicitation:
  step: "Gather course slug and creation mode"

  questions:
    1_course_slug:
      prompt: |
        What is the course identifier (slug)?

        This will be used for:
        - Folder name: /outputs/courses/{slug}/
        - Brief file: /outputs/courses/{slug}/COURSE-BRIEF.md

        Format: lowercase, hyphens only (e.g., "my-course-name")

        Course slug:

      validation:
        - Must be 3-50 characters
        - Must be lowercase letters, numbers, hyphens only

      examples:
        - "clone-ia-express"
        - "python-data-science"
        - "team-onboarding-v2"

    2_creation_mode:
      prompt: |
        Is this course:

        1. Greenfield - Creating from scratch (no existing materials)
           → Start with blank slate, fill COURSE-BRIEF manually
           → Folder should NOT exist yet

        2. Brownfield - Upgrading/migrating existing course materials
           → Extract content from existing files
           → Folder should already exist with materials

        Your choice (1 or 2):

      validation:
        - Must be 1 or 2
        - Will be validated against folder existence

      default_suggestion: |
        (Checking folder existence to suggest default...)
```

---

## Processing Pipeline

### Step 1: Brief Initialization

**1.1. Validate Course Slug**

```yaml
slug_validation:
  step: "Validate and sanitize course slug"

  checks:
    1_format:
      - Must be lowercase letters, numbers, hyphens only
      - Must be 3-50 characters
      - Regex: ^[a-z0-9-]{3,50}$

  sanitization:
    - Convert to lowercase
    - Replace spaces with hyphens
    - Remove special characters
    - Trim to 50 chars if needed

  output:
    validated_slug: "{sanitized-course-slug}"
```

**1.2. Validate Creation Mode vs Folder State**

```yaml
mode_validation:
  step: "Validate creation mode matches folder existence"

  inputs:
    - validated_slug (from step 1.1)
    - creation_mode (1=greenfield, 2=brownfield from elicitation)

  checks:
    folder_path: "outputs/courses/{slug}/"
    folder_exists: "Check if path exists"
    file_count: "Count files recursively (if exists)"

  validation_scenarios:

    scenario_1_greenfield_pass:
      condition: "mode=greenfield AND folder does NOT exist"
      result: SUCCESS
      message: |
        ✓ Greenfield mode validated
        ✓ Folder does not exist (will be created)

        Proceeding to create course structure...

    scenario_2_greenfield_conflict:
      condition: "mode=greenfield AND folder EXISTS"
      result: ERROR
      message: |
        ❌ CONFLICT: Greenfield mode selected but folder already exists!

        Found: outputs/courses/{slug}/
        Contains: {file_count} files

        This suggests you meant "Brownfield" (upgrade existing course).

        Recovery options:
        1. Change to Brownfield mode (recommended)
        2. Delete existing folder and continue as Greenfield (⚠️ DESTRUCTIVE)
        3. Choose different slug

        What would you like to do? (1/2/3):

      recovery_actions:
        option_1_switch_to_brownfield:
          action: "Set creation_mode = brownfield"
          next: "Re-run validation (should pass scenario_3)"

        option_2_delete_folder:
          action: "Delete outputs/courses/{slug}/ recursively"
          confirmation: "Are you SURE? This will delete {file_count} files. Type 'DELETE' to confirm:"
          if_confirmed: "Delete folder and proceed to step 1.3"
          if_not_confirmed: "Abort and re-prompt options"

        option_3_change_slug:
          action: "Re-prompt for slug (back to elicitation step 1)"

    scenario_3_brownfield_pass:
      condition: "mode=brownfield AND folder EXISTS"
      result: SUCCESS
      message: |
        ✓ Brownfield mode validated
        ✓ Folder exists: outputs/courses/{slug}/
        ✓ Found {file_count} files

        Next: Analyzing existing materials...

    scenario_4_brownfield_conflict:
      condition: "mode=brownfield AND folder does NOT exist"
      result: ERROR
      message: |
        ❌ CONFLICT: Brownfield mode selected but no folder found!

        Expected: outputs/courses/{slug}/

        Brownfield mode requires existing materials to upgrade.

        Recovery options:
        1. Change to Greenfield mode (create new course)
        2. Create folder manually and add materials, then retry
        3. Check slug spelling (typo?)

        What would you like to do? (1/2/3):

      recovery_actions:
        option_1_switch_to_greenfield:
          action: "Set creation_mode = greenfield"
          next: "Re-run validation (should pass scenario_1)"

        option_2_manual_setup:
          action: "Halt workflow"
          instructions: |
            Please create the folder and add your materials:

            1. Create folder: mkdir -p outputs/courses/{slug}/
            2. Add your existing course materials to this folder
            3. Run this command again: *generate-course

        option_3_check_slug:
          action: "Re-prompt for slug (back to elicitation step 1)"

  output:
    creation_mode: "greenfield | brownfield"
    folder_state:
      exists: "true | false"
      file_count: "{number}"
      validated_at: "{timestamp}"
```

**1.3. Create Folder Structure (Greenfield Only)**

```yaml
folder_creation:
  step: "Create course directory structure"

  applies_to: "Only runs in GREENFIELD mode"

  skip_if: "creation_mode = brownfield (folder already exists)"

  base_path: "outputs/courses/{course-slug}/"

  directories_to_create:
    - outputs/courses/{course-slug}/
    - outputs/courses/{course-slug}/lessons/
    - outputs/courses/{course-slug}/assessments/
    - outputs/courses/{course-slug}/resources/

  error_handling:
    if_permission_denied: ERROR - "Cannot create directory - check permissions"

  output:
    created_paths: [list of created directories]
```

**1.4. Copy Brief Template (Greenfield Only)**

```yaml
template_copy:
  step: "Copy unified brief template to course folder"

  applies_to: "Only runs in GREENFIELD mode"

  skip_if: "creation_mode = brownfield (brief will be extracted from existing materials)"

  source:
    template_path: "expansion-packs/creator-os/templates/course-brief.md"

  destination:
    brief_path: "outputs/courses/{course-slug}/COURSE-BRIEF.md"

  actions:
    1_check_template:
      - Verify template exists at source path
      - If not found: ERROR - "Template not found. Check CreatorOS installation."

    2_copy_template:
      - Copy template to destination
      - Preserve all content exactly
      - Set file permissions: 644 (rw-r--r--)

    3_update_metadata:
      - Replace placeholders in brief frontmatter:
        - course_slug: {course-slug}
        - created_date: {current_timestamp}
        - creation_mode: "greenfield"
        - folder_state_at_start:
            exists: false
            file_count: 0
            has_legacy_materials: false
        - status: "🟡 Aguardando Preenchimento"

  output:
    brief_file_path: "outputs/courses/{course-slug}/COURSE-BRIEF.md"
```

**1.5. Create README Placeholder**

```yaml
readme_creation:
  step: "Create placeholder README with next steps"

  file: "outputs/courses/{course-slug}/README.md"

  content: |
    # Course: {course-slug}

    **Status:** 🟡 Awaiting Brief Completion

    ---

    ## Next Steps

    1. **Fill the Course Brief:**
       - Open: `COURSE-BRIEF.md`
       - Complete ALL 8 sections (estimated time: 45-90 minutes)
       - Save the file

    2. **Continue Course Generation:**
       - Run: `*continue-course {course-slug}`
       - The system will read your brief and generate the full course

    ---

    **Created:** {timestamp}
    **Framework:** AIOS Course Creation Workflow v2.0
```

**1.6. Workflow Branching**

```yaml
workflow_branching:
  step: "Route to appropriate workflow based on creation mode"

  greenfield_workflow:
    condition: "creation_mode = greenfield"
    next_step: "Step 1.7 - User Notification & HALT (Greenfield)"
    description: "User must fill COURSE-BRIEF.md manually before generation"

  brownfield_workflow:
    condition: "creation_mode = brownfield"
    next_step: "Step 1.7 - User Notification & HALT (Brownfield)"
    description: "User should prepare materials before running extraction workflow (Phase 2)"
```

**1.7. User Notification & HALT**

**For Greenfield Mode:**

```yaml
notification_greenfield:
  step: "Notify user and HALT workflow"

  applies_to: "creation_mode = greenfield"

  message_to_user: |
    ✓ Course structure initialized successfully!

    📁 Created:
    - Folder: /outputs/courses/{course-slug}/
    - Brief: /outputs/courses/{course-slug}/COURSE-BRIEF.md
    - README: /outputs/courses/{course-slug}/README.md

    ---

    📋 **NEXT STEP - Fill the Course Brief:**

    1. Open: `outputs/courses/{course-slug}/COURSE-BRIEF.md`
    2. Complete ALL 8 sections (estimated time: 45-90 minutes):
       - Section 1: Basic Information (5-10 min)
       - Section 2: ICP & Target Audience (15-25 min)
       - Section 3: Content & Pedagogy (20-30 min)
       - Section 4: Voice & Personality (10-15 min)
       - Section 5: Format & Delivery (5-10 min)
       - Section 6: Commercial & Launch (10-15 min)
       - Section 7: Additional Context (5-10 min)
       - Section 8: Final Checklist (2 min)
    3. Save the file

    ---

    **When ready, run:**
    ```
    *continue-course {course-slug}
    ```

    This will read your brief and generate the complete course.

  workflow_state: "HALTED"
  next_task: "continue-course"
```

**For Brownfield Mode:**

```yaml
notification_brownfield:
  step: "Notify user and HALT workflow"

  applies_to: "creation_mode = brownfield"

  message_to_user: |
    ✓ Brownfield mode activated!

    📁 Detected:
    - Folder: /outputs/courses/{course-slug}/
    - Files found: {file_count}

    ---

    📋 **NEXT STEPS - Brownfield Workflow:**

    **Phase 2: Material Extraction (Future Implementation)**

    The system will extract content from your existing materials to:
    1. Generate COURSE-BRIEF.md automatically (from existing content)
    2. Identify ICP from audience descriptions
    3. Extract instructor voice patterns
    4. Map existing structure to course outline

    **For now (Phase 1 - Manual Path):**

    1. Create COURSE-BRIEF.md manually in: outputs/courses/{course-slug}/
    2. Fill all sections based on your existing materials
    3. Run: *continue-course {course-slug}

    ---

    **Status:** Brownfield workflow is planned for Story 3.2-3.4 (Phase 2)
    **Current workaround:** Use greenfield flow with manual COURSE-BRIEF.md

  workflow_state: "HALTED"
  next_task: "continue-course (after manual COURSE-BRIEF.md creation)"
  note: "Automated brownfield extraction coming in Phase 2 (Stories 3.2-3.4)"
```

---

### Step 2: WORKFLOW HALTED

**This task STOPS here.** The user must now:

1. Fill `COURSE-BRIEF.md` manually (45-90 minutes)
2. Run `*continue-course {course-slug}` to generate content

**Note:** Steps 2-5 (Pedagogical Design, Curriculum Generation, Validation, Output) are now part of the `continue-course` task.

---

## Error Handling

```yaml
error_scenarios:

  - error: "Course slug invalid format"
    trigger: "Slug contains invalid characters or wrong length"
    recovery:
      1: "Show validation rules"
      2: "Suggest sanitized version"
      3: "Ask user to provide new slug"
    example_message: |
      ❌ Invalid course slug: "{input_slug}"

      Rules:
      - Lowercase letters, numbers, hyphens only
      - 3-50 characters
      - Example: "my-course-name"

      Suggested: "{sanitized_slug}"

      Please provide a valid slug:

  - error: "Invalid creation mode selection"
    trigger: "User provides value other than 1 or 2 for mode selection"
    recovery:
      1: "Re-prompt with clear options"
      2: "Show folder existence status to help decide"
    example_message: |
      ❌ Invalid selection: "{input_value}"

      Please choose:
      1. Greenfield (creating new course from scratch)
      2. Brownfield (upgrading existing course materials)

      Note: Checking outputs/courses/{slug}/... {exists|does not exist}
      Suggestion: Choose {recommended_mode} based on folder state

      Your choice (1 or 2):

  - error: "Greenfield conflict - folder exists"
    trigger: "User selected greenfield but folder already exists"
    recovery:
      1: "Switch to brownfield mode (recommended)"
      2: "Delete folder and continue (destructive)"
      3: "Choose different slug"
    example_message: |
      ❌ CONFLICT: Greenfield mode selected but folder already exists!

      Found: outputs/courses/{slug}/
      Contains: {file_count} files

      This suggests you meant "Brownfield" (upgrade existing course).

      Recovery options:
      1. Change to Brownfield mode (recommended)
      2. Delete existing folder and continue as Greenfield (⚠️ DESTRUCTIVE)
      3. Choose different slug

      What would you like to do? (1/2/3):

  - error: "Brownfield conflict - folder missing"
    trigger: "User selected brownfield but folder doesn't exist"
    recovery:
      1: "Switch to greenfield mode"
      2: "Create folder manually and retry"
      3: "Check slug spelling"
    example_message: |
      ❌ CONFLICT: Brownfield mode selected but no folder found!

      Expected: outputs/courses/{slug}/

      Brownfield mode requires existing materials to upgrade.

      Recovery options:
      1. Change to Greenfield mode (create new course)
      2. Create folder manually and add materials, then retry
      3. Check slug spelling (typo?)

      What would you like to do? (1/2/3):

  - error: "Folder deletion cancelled"
    trigger: "User chose to delete folder but didn't confirm with 'DELETE'"
    recovery:
      1: "Return to mode conflict recovery options"
    example_message: |
      ⚠️ Deletion cancelled (confirmation not received)

      Returning to recovery options...

      What would you like to do?
      1. Change to Brownfield mode (recommended)
      2. Try delete again (type 'DELETE' to confirm)
      3. Choose different slug

  - error: "Template not found"
    trigger: "expansion-packs/creator-os/templates/course-brief.md not found"
    recovery:
      1: "Check if CreatorOS expansion pack installed"
      2: "Verify file path"
      3: "Provide manual template link"
    example_message: |
      ❌ Course brief template not found at:
      expansion-packs/creator-os/templates/course-brief.md

      Please verify:
      1. CreatorOS expansion pack is installed
      2. Template file exists at expected location

      Installation guide: expansion-packs/creator-os/README.md

  - error: "Permission denied"
    trigger: "Cannot create directory or write files"
    recovery:
      1: "Check file system permissions"
      2: "Suggest manual directory creation"
    example_message: |
      ❌ Permission denied: Cannot create /outputs/courses/{slug}/

      Please check:
      1. Write permissions for /outputs/courses/ directory
      2. Disk space available
      3. Path is accessible

      Manual fix: mkdir -p outputs/courses/{slug}
```

---

## Performance Targets

```yaml
performance:
  target_time: "< 60 seconds"
  target_cost: "$0 (no AI generation, just file operations)"

  breakdown:
    validation: "< 1 second"
    folder_creation: "< 1 second"
    template_copy: "< 1 second"
    readme_creation: "< 1 second"
    notification: "< 1 second"
```

---

## Success Metrics

```yaml
success_criteria:
  initialization:
    - Folder structure created: 100%
    - Template copied correctly: 100%
    - README generated: 100%
    - User notified with next steps: 100%

  user_experience:
    - Clear instructions provided
    - Next steps obvious (*continue-course command)
    - Error messages helpful and actionable
```

---

## Example Usage

### Example 1: Greenfield - New Course from Scratch

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> clone-ia-express

# Prompt: Is this course:
# 1. Greenfield - Creating from scratch (no existing materials)
# 2. Brownfield - Upgrading/migrating existing course materials
# Your choice (1 or 2):
> 1

# System validates: folder doesn't exist ✓

# Output:
✓ Greenfield mode validated
✓ Folder does not exist (will be created)

Proceeding to create course structure...

✓ Course structure initialized successfully!

📁 Created:
- Folder: /outputs/courses/clone-ia-express/
- Brief: /outputs/courses/clone-ia-express/COURSE-BRIEF.md
- README: /outputs/courses/clone-ia-express/README.md

---

📋 **NEXT STEP - Fill the Course Brief:**

1. Open: `outputs/courses/clone-ia-express/COURSE-BRIEF.md`
2. Complete ALL 8 sections (estimated time: 45-90 minutes)
3. Save the file

**When ready, run:**
```
*continue-course clone-ia-express
```
```

### Example 2: Brownfield - Upgrade Existing Course

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> dominando-obsidian

# Prompt: Is this course:
# 1. Greenfield - Creating from scratch (no existing materials)
# 2. Brownfield - Upgrading/migrating existing course materials
# Your choice (1 or 2):
> 2

# System validates: folder exists with 42 files ✓

# Output:
✓ Brownfield mode validated
✓ Folder exists: outputs/courses/dominando-obsidian/
✓ Found 42 files

Next: Analyzing existing materials...

---

✓ Brownfield mode activated!

📁 Detected:
- Folder: /outputs/courses/dominando-obsidian/
- Files found: 42

---

📋 **NEXT STEPS - Brownfield Workflow:**

**Phase 2: Material Extraction (Future Implementation)**

The system will extract content from your existing materials to:
1. Generate COURSE-BRIEF.md automatically (from existing content)
2. Identify ICP from audience descriptions
3. Extract instructor voice patterns
4. Map existing structure to course outline

**For now (Phase 1 - Manual Path):**

1. Create COURSE-BRIEF.md manually in: outputs/courses/dominando-obsidian/
2. Fill all sections based on your existing materials
3. Run: *continue-course dominando-obsidian

---

**Status:** Brownfield workflow is planned for Story 3.2-3.4 (Phase 2)
**Current workaround:** Use greenfield flow with manual COURSE-BRIEF.md
```

### Example 3: Error - Greenfield Conflict (Folder Exists)

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> clone-ia-express

# Prompt: Is this course:
# 1. Greenfield - Creating from scratch (no existing materials)
# 2. Brownfield - Upgrading/migrating existing course materials
# Your choice (1 or 2):
> 1

# System checks: folder DOES exist!

# Output:
❌ CONFLICT: Greenfield mode selected but folder already exists!

Found: outputs/courses/clone-ia-express/
Contains: 15 files

This suggests you meant "Brownfield" (upgrade existing course).

Recovery options:
1. Change to Brownfield mode (recommended)
2. Delete existing folder and continue as Greenfield (⚠️ DESTRUCTIVE)
3. Choose different slug

What would you like to do? (1/2/3):
> 1

# User chooses option 1 - system switches to brownfield
✓ Switched to Brownfield mode
✓ Folder exists: outputs/courses/clone-ia-express/
✓ Found 15 files

[... continues with brownfield workflow ...]
```

### Example 4: Error - Brownfield Conflict (Folder Missing)

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> new-course

# Prompt: Is this course:
# 1. Greenfield - Creating from scratch (no existing materials)
# 2. Brownfield - Upgrading/migrating existing course materials
# Your choice (1 or 2):
> 2

# System checks: folder does NOT exist!

# Output:
❌ CONFLICT: Brownfield mode selected but no folder found!

Expected: outputs/courses/new-course/

Brownfield mode requires existing materials to upgrade.

Recovery options:
1. Change to Greenfield mode (create new course)
2. Create folder manually and add materials, then retry
3. Check slug spelling (typo?)

What would you like to do? (1/2/3):
> 1

# User chooses option 1 - system switches to greenfield
✓ Switched to Greenfield mode
✓ Folder does not exist (will be created)

[... continues with greenfield workflow ...]
```

---

## Related Tasks

- **`continue-course`** - Reads filled COURSE-BRIEF.md and generates full course content (Steps 2-5 from v1.0)
- **`update-course`** - Modifies existing course based on feedback (future)
- **`export-course`** - Exports course to platform format (future)

---

## Migration Notes (v1.0 → v2.0)

**Breaking Changes:**
- ❌ **REMOVED:** Interactive elicitation (15-20 questions)
- ❌ **REMOVED:** Mode selection (generic/expert/legacy)
- ❌ **REMOVED:** Immediate content generation
- ✅ **ADDED:** Unified brief document approach
- ✅ **ADDED:** Two-step workflow (generate-course → continue-course)

**Why Changed:**
1. **Context Loss:** v1.0 required maintaining context across 15-20 Q&A rounds
2. **Interruptions:** User had to stay present for entire generation (15-45 min)
3. **No Iteration:** Couldn't revise requirements without regenerating
4. **Better UX:** v2.0 allows users to thoughtfully fill brief offline, review, iterate

**Migration Path:**
- If using v1.0 workflow: Switch to v2.0 by using `*generate-course` + `*continue-course`
- Old v1.0 task backed up at: `expansion-packs/creator-os/tasks/generate-course-v1-backup.md`

---

**Task Version:** 2.1
**Last Updated:** 2025-10-18
**Maintainer:** CreatorOS Team (Sarah - PO)
**Changelog:**
- v2.1 (2025-10-18): **Story 3.1 Implementation - Greenfield/Brownfield Detection**
  - Added creation mode elicitation (greenfield vs brownfield)
  - Added folder existence validation with 4 scenarios
  - Added creation_mode metadata to COURSE-BRIEF.md frontmatter
  - Added workflow branching (greenfield → manual brief, brownfield → future extraction)
  - Added comprehensive error recovery for mode/folder conflicts
  - Updated examples to show all validation scenarios
  - Brownfield extraction workflow (Stories 3.2-3.4) planned for Phase 2
- v2.0 (2025-10-17): Refactored to unified brief document workflow. Split into generate-course (init) + continue-course (generation).
- v1.0 (2025-10-15): Initial interactive elicitation workflow (deprecated).
