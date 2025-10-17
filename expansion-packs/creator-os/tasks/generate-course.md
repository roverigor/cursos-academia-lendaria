# Task: Generate Course

**Task ID:** generate-course
**Version:** 2.0
**Purpose:** Initialize course structure and unified brief document for human completion
**Owner:** Course Architect Agent
**Estimated Time:** 30-60 seconds (initialization only)
**Elicit:** true

---

## Overview

**WORKFLOW v2.0 - Unified Brief Document Approach**

This task initializes a new course by creating the folder structure and copying the unified course brief template. The user then fills out the comprehensive brief document (45-90 min) before content generation begins with the `continue-course` task.

**What This Task Does:**
1. Prompts for course slug (short identifier)
2. Creates `/docs/courses/{course-slug}/` directory structure
3. Copies `course-brief.md` template to `COURSE-BRIEF.md`
4. **HALTS and notifies user to fill the brief**

**What This Task Does NOT Do:**
- Does NOT generate course content (that's `continue-course` task)
- Does NOT ask 15-20 interactive questions (v1.0 deprecated)
- Does NOT elicit requirements incrementally

**Success Criteria:**
- Folder structure created successfully
- `COURSE-BRIEF.md` copied and ready for editing
- User notified with clear next steps

---

## Input Parameters

### Required Parameters

1. **course_slug** (string, required)
   - Description: Short identifier for the course (used in folder/file names)
   - Example: "clone-ia-express", "python-data-science", "team-onboarding"
   - Validation:
     - Lowercase letters, numbers, hyphens only
     - 3-50 characters
     - Must not already exist in `/docs/courses/`
   - Format: kebab-case (e.g., "my-course-name")

### Elicitation

```yaml
elicitation:
  step: "Gather course slug for initialization"

  questions:
    1_course_slug:
      prompt: |
        What is the course identifier (slug)?

        This will be used for:
        - Folder name: /docs/courses/{slug}/
        - Brief file: /docs/courses/{slug}/COURSE-BRIEF.md

        Format: lowercase, hyphens only (e.g., "my-course-name")

        Course slug:

      validation:
        - Must be 3-50 characters
        - Must be lowercase letters, numbers, hyphens only
        - Must not already exist in /docs/courses/

      examples:
        - "clone-ia-express"
        - "python-data-science"
        - "team-onboarding-v2"
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

    2_uniqueness:
      - Check if /docs/courses/{slug}/ already exists
      - If exists: ERROR - "Course '{slug}' already exists. Choose different slug or use *continue-course to resume."

  sanitization:
    - Convert to lowercase
    - Replace spaces with hyphens
    - Remove special characters
    - Trim to 50 chars if needed

  output:
    validated_slug: "{sanitized-course-slug}"
```

**1.2. Create Folder Structure**

```yaml
folder_creation:
  step: "Create course directory structure"

  base_path: "docs/courses/{course-slug}/"

  directories_to_create:
    - docs/courses/{course-slug}/
    - docs/courses/{course-slug}/lessons/
    - docs/courses/{course-slug}/assessments/
    - docs/courses/{course-slug}/resources/

  error_handling:
    if_exists: ERROR - "Course already exists"
    if_permission_denied: ERROR - "Cannot create directory - check permissions"

  output:
    created_paths: [list of created directories]
```

**1.3. Copy Brief Template**

```yaml
template_copy:
  step: "Copy unified brief template to course folder"

  source:
    template_path: "expansion-packs/creator-os/templates/course-brief.md"

  destination:
    brief_path: "docs/courses/{course-slug}/COURSE-BRIEF.md"

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
        - status: "🟡 Aguardando Preenchimento"

  output:
    brief_file_path: "docs/courses/{course-slug}/COURSE-BRIEF.md"
```

**1.4. Create README Placeholder**

```yaml
readme_creation:
  step: "Create placeholder README with next steps"

  file: "docs/courses/{course-slug}/README.md"

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

**1.5. User Notification & HALT**

```yaml
notification:
  step: "Notify user and HALT workflow"

  message_to_user: |
    ✓ Course structure initialized successfully!

    📁 Created:
    - Folder: /docs/courses/{course-slug}/
    - Brief: /docs/courses/{course-slug}/COURSE-BRIEF.md
    - README: /docs/courses/{course-slug}/README.md

    ---

    📋 **NEXT STEP - Fill the Course Brief:**

    1. Open: `docs/courses/{course-slug}/COURSE-BRIEF.md`
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

  - error: "Course already exists"
    trigger: "Directory /docs/courses/{slug}/ already exists"
    recovery:
      1: "Check if COURSE-BRIEF.md is filled"
      2: "Offer to resume with *continue-course"
      3: "Offer to choose different slug"
    example_message: |
      ❌ Course '{slug}' already exists at /docs/courses/{slug}/

      Options:
      A. Resume: *continue-course {slug} (if brief is filled)
      B. Choose different slug
      C. Delete existing and start over (manual deletion required)

      What would you like to do?

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
      ❌ Permission denied: Cannot create /docs/courses/{slug}/

      Please check:
      1. Write permissions for /docs/courses/ directory
      2. Disk space available
      3. Path is accessible

      Manual fix: mkdir -p docs/courses/{slug}
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

### Example 1: Initialize Expert-Led Course

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> clone-ia-express

# Output:
✓ Course structure initialized successfully!

📁 Created:
- Folder: /docs/courses/clone-ia-express/
- Brief: /docs/courses/clone-ia-express/COURSE-BRIEF.md
- README: /docs/courses/clone-ia-express/README.md

---

📋 **NEXT STEP - Fill the Course Brief:**

1. Open: `docs/courses/clone-ia-express/COURSE-BRIEF.md`
2. Complete ALL 8 sections (estimated time: 45-90 minutes)
3. Save the file

**When ready, run:**
```
*continue-course clone-ia-express
```
```

### Example 2: Initialize Technical Course

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> python-data-science

# Output:
✓ Course structure initialized successfully!

📁 Created:
- Folder: /docs/courses/python-data-science/
- Brief: /docs/courses/python-data-science/COURSE-BRIEF.md
- README: /docs/courses/python-data-science/README.md

---

📋 **NEXT STEP - Fill the Course Brief:**

1. Open: `docs/courses/python-data-science/COURSE-BRIEF.md`
2. Complete ALL 8 sections (estimated time: 45-90 minutes)
3. Save the file

**When ready, run:**
```
*continue-course python-data-science
```
```

### Example 3: Error - Course Already Exists

```bash
*generate-course

# Prompt: What is the course identifier (slug)?
> clone-ia-express

# Output:
❌ Course 'clone-ia-express' already exists at /docs/courses/clone-ia-express/

Options:
A. Resume: *continue-course clone-ia-express (if brief is filled)
B. Choose different slug
C. Delete existing and start over (manual deletion required)

What would you like to do?
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

**Task Version:** 2.0
**Last Updated:** 2025-10-17
**Maintainer:** CreatorOS Team (Sarah - PO)
**Changelog:**
- v2.0 (2025-10-17): Refactored to unified brief document workflow. Split into generate-course (init) + continue-course (generation).
- v1.0 (2025-10-15): Initial interactive elicitation workflow (deprecated).
