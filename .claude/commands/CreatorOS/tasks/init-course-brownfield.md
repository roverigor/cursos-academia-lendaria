# Task: Initialize Brownfield Course

**Type:** Atomic Task
**Responsibility:** Create course folder structure for legacy material upgrade
**Duration:** < 1 minute

## Purpose

Initialize course structure for upgrading existing materials. Creates folders for source organization and extraction.

---

## Inputs

- `slug` (required) - Course identifier
- `--source-folder {path}` (optional) - Path to legacy materials

---

## Execution

```bash
python expansion-packs/creator-os/scripts/init_course.py \
  --mode brownfield \
  --slug "$slug" \
  ${source_folder:+--source-folder "$source_folder"}
```

---

## Output

```
outputs/courses/{slug}/
├── sources/
│   ├── raw/ (original files copied here)
│   └── organized/ (categorized files)
├── extractions/ (AI-extracted data)
├── COURSE-BRIEF.md (empty, to be filled)
├── .metadata.json
└── README.md
```

---

## Success Criteria

- ✅ Folder structure created
- ✅ Legacy files copied to sources/raw/ (if provided)
- ✅ .metadata.json contains mode=brownfield
- ✅ COURSE-BRIEF.md template exists

---

**Status:** ✅ Ready
