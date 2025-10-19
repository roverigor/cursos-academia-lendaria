# Task: Organize Legacy Files

**Type:** Atomic Task
**Responsibility:** Categorize and organize legacy course materials
**Duration:** 2-5 minutes

## Purpose

Automatically categorize legacy files by type (lessons, assessments, resources) to prepare for extraction.

---

## Inputs

- `slug` (required) - Course identifier

---

## Execution

```bash
python expansion-packs/creator-os/scripts/organize_files.py "$slug"
```

---

## Process

1. Scan `sources/raw/` for all files
2. Categorize by extension and content:
   - `.md`, `.docx`, `.pdf` → lessons/
   - Quiz/test files → assessments/
   - Images, videos → resources/
3. Move to `sources/organized/{category}/`
4. Generate file inventory

---

## Output

```
outputs/courses/{slug}/sources/organized/
├── lessons/
├── assessments/
├── resources/
└── file-inventory.json
```

---

## Success Criteria

- ✅ All files categorized
- ✅ file-inventory.json created
- ✅ No files left in raw/ (or only unrecognized types)

---

**Status:** ✅ Ready
