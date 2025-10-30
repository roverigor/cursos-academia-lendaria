# Task: Extract ICP (Ideal Customer Profile)

**Type:** Atomic Task
**Responsibility:** Extract target audience data from legacy materials using AI
**Duration:** 1-3 minutes

## Purpose

Analyze legacy content to automatically extract demographics, psychographics, pain points, and learner goals.

---

## Inputs

- `slug` (required) - Course identifier

---

## Execution

```bash
python expansion-packs/creator-os/scripts/extract_icp.py "$slug"
```

---

## Process

1. Load all lesson files from `sources/organized/lessons/`
2. Analyze content with AI:
   - Who is the target audience?
   - What are their pain points?
   - What are their goals?
   - Demographics (age, profession, experience level)
3. Generate ICP profile (YAML)
4. Update COURSE-BRIEF Section 2 (ICP)

---

## Output

```
outputs/courses/{slug}/extractions/icp-extracted.yaml
```

Updates `COURSE-BRIEF.md` Section 2 with extracted data.

---

## Success Criteria

- ✅ ICP extracted with ≥60% completeness
- ✅ Demographics identified
- ✅ At least 3 pain points extracted
- ✅ Learning goals identified

---

**Status:** ✅ Ready
