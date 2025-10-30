# Task: Analyze COURSE-BRIEF Gaps

**Type:** Atomic Task
**Responsibility:** Identify missing fields in COURSE-BRIEF after extraction
**Duration:** < 1 minute

## Purpose

Compare COURSE-BRIEF required fields (65 total) against extracted data to identify what user must fill manually.

---

## Inputs

- `slug` (required) - Course identifier

---

## Execution

```bash
python expansion-packs/creator-os/scripts/analyze_gaps.py "$slug"
```

---

## Process

1. Load COURSE-BRIEF.md
2. Load all extraction files (icp, voice, objectives)
3. Compare against 65 required fields
4. Generate gap report:
   - % Completeness per section
   - Missing critical fields
   - Optional fields
5. Display actionable report to user

---

## Output

```
📊 COURSE-BRIEF Gap Analysis

✅ Auto-filled (50%):
  - Section 2: ICP (80% complete)
  - Section 4: Voice (70% complete)
  - Section 3: Objectives (60% complete)

⚠️  Requires manual input (50%):
  - Section 1: Basic Info (0% - CRITICAL)
  - Section 5: Format & Delivery (0%)
  - Section 6: Commercial (0%)
  - Section 7: Success Metrics (0%)
  - Section 8: Constraints (0%)

🎯 Priority Actions:
  1. Fill Section 1 (title, subtitle, prerequisites)
  2. Define format preferences (Section 5)
  3. Set pricing/revenue goals (Section 6)
```

Saves to: `outputs/courses/{slug}/gap-analysis.json`

---

## Success Criteria

- ✅ All 8 sections analyzed
- ✅ % completeness calculated
- ✅ Missing fields listed
- ✅ Priority actions identified

---

**Status:** ✅ Ready
