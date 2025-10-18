# CreatorOS Workflow Principles

**Created:** 2025-10-18
**Status:** Active Guidelines

---

## ❌ ANTI-PATTERN: File Hunting

**NEVER search for files during course generation.**

### Why This is Wrong:
- Wastes time searching instead of executing
- Indicates missing workflow structure
- Creates confusion and context switching
- Breaks the flow of course creation

---

## ✅ CORRECT PATTERN: Linear Workflow with Clear Steps

Course generation must follow a **logical, sequential order** where:
1. Every file needed is **known in advance**
2. Every step has **clear inputs and outputs**
3. No searching, no guessing, no hunting

---

## 🎯 CreatorOS Workflow Structure

### Phase 1: Setup (INPUTS DEFINED)
```bash
Inputs Required:
- Course Brief (user provides OR we create via discovery)
- ICP definition
- Professor persona (MMOS clone if applicable)
- Checklist framework (already exists)

Output:
- /outputs/courses/{slug}/COURSE-BRIEF.md
- /outputs/courses/{slug}/resources/ (populated)
```

### Phase 2: Curriculum Generation
```bash
Inputs:
- COURSE-BRIEF.md (from Phase 1)
- Checklist da Aula Perfeita (always at: expansion-packs/creator-os/checklists/)
- MMOS persona (if clone mode: outputs/minds/{professor_slug}/)

Output:
- curriculum.yaml
```

### Phase 3: Lesson Generation
```bash
Inputs:
- curriculum.yaml (from Phase 2)
- MMOS system prompt (if clone mode)
- Checklist da Aula Perfeita

Output:
- /lessons/modulo-{N}/aula-{N}.md (one at a time)
```

### Phase 4: Quality Validation
```bash
Inputs:
- All generated lessons
- Checklist da Aula Perfeita

Output:
- ANALISE-QUALIDADE-CHECKLIST.md
- AJUSTES-PRIORIDADE-{N}.md
```

---

## 📂 File Location Standards (NO SEARCHING)

### Always Know Where Files Are:

```yaml
Checklists:
  location: "outputs/courses/didatica-lendaria/resources/"
  primary_file: "checklist-aula-perfeita.md"

  validation_checklists: "expansion-packs/creator-os/checklists/"
  files:
    - didatica-lendaria-validation.md
    - gps-lesson-validation.md

Templates:
  location: "expansion-packs/creator-os/templates/"
  files:
    - lesson-template.md
    - curriculum-template.yaml
    - course-brief-template.md

MMOS Personas:
  location: "outputs/minds/{professor_slug}/"
  files:
    - system_prompts/system-prompt-generalista.md
    - analysis/identity-core.yaml
    - synthesis/communication-style.md

Course Outputs:
  location: "outputs/courses/{course_slug}/"
  structure:
    - COURSE-BRIEF.md
    - curriculum.yaml
    - lessons/
    - resources/
    - ANALISE-QUALIDADE-CHECKLIST.md
```

---

## 🚨 Workflow Enforcement Rules

### Rule 1: No Glob/Grep for Known Files
❌ **WRONG:**
```bash
# Searching for checklist
Glob: **/*checklist*.md
```

✅ **CORRECT:**
```bash
# Direct path - we KNOW where it is
Read: expansion-packs/creator-os/checklists/checklist-aula-perfeita.md
```

### Rule 2: Every Task Has Defined Inputs
❌ **WRONG:**
```
Task: Generate curriculum
(no inputs specified - will need to search)
```

✅ **CORRECT:**
```
Task: Generate curriculum
Inputs:
  - outputs/courses/{slug}/COURSE-BRIEF.md
  - expansion-packs/creator-os/templates/curriculum-template.yaml
  - outputs/minds/{professor}/analysis/identity-core.yaml (if clone mode)
```

### Rule 3: User Provides What Doesn't Exist
❌ **WRONG:**
```
"Let me search for your transcripts..."
```

✅ **CORRECT:**
```
"To proceed with clone mode, please provide:
- 5 transcripts at: outputs/courses/{slug}/sources/transcripts/
- Or disable clone mode in the brief"
```

---

## 📋 Pre-Flight Checklist (Before Starting ANY Course)

```markdown
[ ] COURSE-BRIEF.md exists or will be created in discovery
[ ] Professor persona located (if clone mode) at outputs/minds/{slug}/
[ ] Checklist framework confirmed at expansion-packs/creator-os/checklists/
[ ] Templates available at expansion-packs/creator-os/templates/
[ ] Output directory created: outputs/courses/{slug}/
[ ] If brownfield: existing materials listed in brief
```

**If ANY checkbox is unchecked and cannot be resolved → STOP and ask user.**

---

## 🎯 Agent Behavior

### When to STOP and ASK:
- Required input file doesn't exist at expected path
- User mentioned source material not provided
- Clone mode enabled but no persona found
- Brief references materials that don't exist

### When to PROCEED:
- All inputs are at known locations
- Can use templates for missing optional items
- Workflow can continue linearly

---

## 💡 Key Insight

**"If you're searching, the workflow is broken."**

The workflow should be a **straight line**, not a **treasure hunt**.

Every file location should be:
1. **Documented** in this file
2. **Known** before the task starts
3. **Verified** in pre-flight checklist

---

## 🔧 How to Fix Broken Workflows

When you catch yourself searching:

1. **STOP immediately**
2. **Identify** what file you're looking for
3. **Document** where it SHOULD be in this file
4. **Update** the workflow/template to include it as required input
5. **Ask user** if it doesn't exist at expected location

---

## 📚 Related Documentation

- `/expansion-packs/creator-os/README.md` - CreatorOS overview
- `/expansion-packs/creator-os/workflows/` - Step-by-step workflows
- `/.aios-core/checklists/` - System checklists

---

**Last Updated:** 2025-10-18
**Principle:** Linear execution > File hunting
**Author:** Based on user feedback (Alan Nicolas)
