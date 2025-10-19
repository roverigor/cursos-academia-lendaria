# Task: Initialize Greenfield Course

**Type:** Atomic Task
**Responsibility:** Create course folder structure and empty COURSE-BRIEF template
**Duration:** < 1 minute

## Purpose

Initialize a new course from scratch with no existing materials. Creates folder structure and COURSE-BRIEF.md template.

---

## Inputs

- `slug` (required) - Course identifier (kebab-case, 3-50 chars)
- `--mmos-persona {mind_name}` (optional) - MMOS persona to use

---

## Execution

```bash
python expansion-packs/creator-os/scripts/init_course.py \
  --mode greenfield \
  --slug "$slug" \
  ${mmos_persona:+--mmos-persona "$mmos_persona"}
```

---

## Output

```
outputs/courses/{slug}/
├── COURSE-BRIEF.md (8 empty sections)
├── .metadata.json
└── README.md
```

---

## Success Criteria

- ✅ Folder created at `outputs/courses/{slug}/`
- ✅ COURSE-BRIEF.md exists with 8 section headers
- ✅ .metadata.json contains slug, mode, created_at
- ✅ If MMOS enabled, persona config saved

---

**Status:** ✅ Ready
