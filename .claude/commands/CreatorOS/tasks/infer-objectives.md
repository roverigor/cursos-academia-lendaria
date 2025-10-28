# Task: Infer Learning Objectives

**Type:** Atomic Task
**Responsibility:** Infer learning objectives from legacy content using Bloom's Taxonomy
**Duration:** 1-3 minutes

## Purpose

Analyze lesson content to automatically infer learning objectives aligned with Bloom's Taxonomy.

---

## Inputs

- `slug` (required) - Course identifier

---

## Execution

```bash
python expansion-packs/creator-os/scripts/infer_objectives.py "$slug"
```

---

## Process

1. Load lessons from `sources/organized/lessons/`
2. Analyze each lesson with AI:
   - What skills/knowledge does it teach?
   - What can learners DO after completing it?
   - Map to Bloom's level (Remember → Create)
3. Generate objectives list (YAML)
4. Update COURSE-BRIEF Section 3 (Content & Pedagogy)

---

## Output

```
outputs/courses/{slug}/extractions/objectives-inferred.yaml
```

Updates `COURSE-BRIEF.md` Section 3 with inferred objectives.

---

## Success Criteria

- ✅ Objectives extracted (≥60% of lessons covered)
- ✅ Each objective uses Bloom's action verb
- ✅ Bloom's levels identified (Remember/Understand/Apply/etc.)
- ✅ Objectives mapped to lesson topics

---

**Status:** ✅ Ready
