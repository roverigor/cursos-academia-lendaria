# Validate Fragment Batch

**Task ID:** `validate-fragment-batch`
**Purpose:** Ensure extracted fragments meet MIU and database quality standards
**Workflow Mode:** Automated checks with human-readable report
**Elicitation:** None (operates on generated data)

## Overview

This task audits `fragments_raw.json` produced by `extract-fragments`. It verifies MIU structural rules, taxonomy coverage, Supabase schema alignment, and zero-inference compliance. Outputs include a validation report (`fragment_validation_report.md`) and a sanitized fragment file (`fragments_validated.json`) ready for database formatting.

## Prerequisites

Before executing this task, ensure you have:

- Completed `prepare-run` and `extract-fragments`
- Access to `run_context.json` and `fragments_raw.json`
- Taxonomy lookup (`category_lookup.json`) to resolve `category_id`
- Fragment validation checklist (`docs/research/ fragment taxonomy/validation_checklist.md`)

## Workflow

### Section 1: Load Inputs

**Instruction:** Load `run_context.json` and `fragments_raw.json`. Validate presence of required keys.

```
Checks:
  - `fragments` array exists and non-empty
  - Metadata includes extraction statistics
  - Run context fields (mind_id, source_id) match fragments file
Failure:
  - Halt with descriptive error and file paths
Output:
  validation_session:
    mind_id: <uuid>
    source_id: <uuid>
    fragment_count: <int>
```

### Section 2: Schema Validation

**Instruction:** Validate each fragment against required Supabase columns.

```
For each fragment:
  - Ensure `content`, `context`, `insight`, `type`, `relevance` present
  - Enforce relevance integer between 0 and 10
  - Confirm `location` exists (generate fallback as sequential index if missing)
  - Check metadata JSON present; if absent, create `{}` with warning
Record issues in `errors` / `warnings` arrays.
```

### Section 3: MIU Quality Checks

**Instruction:** Apply MIU checklist rules from `validation_checklist.md`.

```
Tests:
  - Grammatical completeness (subject + verb)
  - Clear attribution (speaker or narrator)
  - Causal/temporal preservation (look for connectors and verify paired clauses)
  - Contrast separation (flag fragments containing " but ", " however ", etc.)
  - Length bounds: warn if <5 words or >200 words
  - Zero-inference scan (ban trait/emotion keywords)
Output:
  quality_metrics:
    miu_pass_rate: <float>
    zero_inference_passed: <bool>
    warnings: [ ... ]
```

### Section 4: Taxonomy & Category Mapping

**Instruction:** Map taxonomy selections to Supabase `category_id`.

```
Steps:
  - Derive slug from taxonomy metadata (primary_category + subcategory)
  - Lookup category_id in JSON; if missing, add error and mark fragment invalid
  - Attach `category_id` to fragment metadata for downstream formatting
Output:
  taxonomy_summary:
    mapped: <int>
    missing: [slug...]
```

### Section 5: Duplicate Detection

**Instruction:** Detect conflicting `(source_id, location)` pairs and duplicate content.

```
Actions:
  - Build hash map of location tokens; if duplicate, append suffix `#2`, `#3` and warn
  - Compute content hash to detect verbatim duplicates across fragments
  - Report duplicates for manual review
```

### Section 6: Generate Validation Report

**Instruction:** Produce human-readable report summarizing validation results.

```
Report contents:
  - Header (mind_id, source_id, timestamp)
  - Summary table (total fragments, passed, warnings, failures)
  - Quality metrics (avg word count, clause count, relevance distribution)
  - Warning list grouped by category (MIU, taxonomy, schema)
  - Action items for fragments needing manual fixes
File: `fragment_validation_report.md`
```

### Section 7: Emit Validated Fragment File

**Instruction:** Save sanitized output for database formatting.

```
Steps:
  - Drop fragments marked as invalid (unless `--allow-invalid` flag present)
  - Attach `validation_status` to each fragment (valid|warning|invalid)
  - Save to `fragments_validated.json`
```

## Validation

Validate task completion by checking:

- `fragment_validation_report.md` created with non-empty content
- `fragments_validated.json` exists and contains only valid fragments (unless overrides)
- Any missing categories or schema violations listed in report
- Overall MIU pass rate ≥ 90%; if lower, highlight for manual follow-up

## Output

- `fragment_validation_report.md`
- `fragments_validated.json`
- `validation_stats.json` (optional machine-readable summary)

Location: `outputs/fragments/<mind>/<source>/`

## Error Handling

- Missing inputs → abort and reference prerequisite task
- Category lookup miss → mark fragment invalid and document slug
- Zero-inference violation → attempt automated redaction, else flag invalid
- Low pass rate (<70%) → stop pipeline and require human intervention

## Integration

This task integrates with:

- `extract-fragments` (input provider)
- `format-fragments-for-db` (consumes validated output)
- Supabase ingestion scripts (rely on sanitized data)

## Examples

- **High quality batch**: 95 fragments, 3 warnings (long causal chain), 0 invalid -> ready for insertion
- **Problematic batch**: 60 fragments, 12 invalid due to missing taxonomy mapping -> manual fix required

## Notes

- Consider archiving invalid fragments in `fragments_invalid.json` for audit trails.
- Expand zero-inference keyword list as new trait detectors emerge.
- Add optional CLI flag to export CSV summary for spreadsheets.

---

_Task Version: 1.0.0_
_Last Updated: 2025-10-27_
