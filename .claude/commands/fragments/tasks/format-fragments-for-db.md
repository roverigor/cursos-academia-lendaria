# Format Fragments for Database

**Task ID:** `format-fragments-for-db`
**Purpose:** Transform validated fragments into Supabase insertion payloads
**Workflow Mode:** Deterministic transformation
**Elicitation:** None

## Overview

This task converts `fragments_validated.json` into a structure ready for Supabase ingestion. It maps taxonomy metadata to numeric `category_id`, ensures all required fields are present, flattens metadata into JSONB, and produces SQL and JSON artifacts for `fragments` table insertion.

## Prerequisites

Before executing this task, ensure you have:

- Completed `prepare-run`, `extract-fragments`, and `validate-fragment-batch`
- Access to `run_context.json`, `fragments_validated.json`, and category lookup JSON
- Supabase CLI or database connection details (if executing insertion
)

## Workflow

### Section 1: Load Inputs

**Instruction:** Load `run_context.json` and `fragments_validated.json`.

```
Checks:
  - Validate that `validation_status` for each fragment is `valid` or `warning`
  - If `invalid` fragments exist, warn and skip them
Output:
  fragments_ready: [ ... ]
```

### Section 2: Construct Supabase Rows

**Instruction:** For each fragment, produce a row matching the `fragments` table schema.

```
Fields:
  - mind_id (uuid)
  - source_id (uuid)
  - category_id (int)
  - ingestion_batch_id (uuid|null)
  - generation_execution_id (uuid|null)
  - location (text)
  - type (text)
  - relevance (smallint)
  - content (text)
  - context (text)
  - insight (text)
  - metadata (jsonb)
Rules:
  - Use metadata.taxonomy to populate `category_id` by slug lookup
  - Ensure metadata includes processing method, timestamps, warnings, structural stats
  - Remove transient fields not needed for DB (fragment_id, validation_status)
```

### Section 3: Generate JSON Payload

**Instruction:** Emit `fragments_supabase.json` containing array of rows.

```
Structure:
  {
    "run": { ... from run_context ... },
    "fragments": [ {db_row}, ... ]
  }
```

### Section 4: Generate SQL Script (Optional)

**Instruction:** Create `insert_fragments.sql` with parameterized INSERT statements for manual execution.

```
Example snippet:
INSERT INTO fragments (
  mind_id, source_id, category_id, ingestion_batch_id,
  generation_execution_id, location, type, relevance,
  content, context, insight, metadata
) VALUES
  (...)
ON CONFLICT (source_id, location) DO UPDATE
SET content = EXCLUDED.content,
    context = EXCLUDED.context,
    insight = EXCLUDED.insight,
    relevance = EXCLUDED.relevance,
    metadata = EXCLUDED.metadata,
    updated_at = now();
```

### Section 5: Summary Report

**Instruction:** Output `format_summary.md` summarizing the batch.

```
Include:
  - Total rows generated
  - Rows skipped (invalid)
  - Category distribution
  - Relevance histogram
  - Warnings (e.g., missing metadata fields auto-filled)
```

## Validation

Validate task completion by checking:

- `fragments_supabase.json` exists and contains all required fields
- `insert_fragments.sql` generated if SQL mode enabled
- `format_summary.md` documents row counts and warnings
- No fragments with missing category_id or required fields

## Output

- `fragments_supabase.json`
- `insert_fragments.sql` (optional)
- `format_summary.md`

## Error Handling

- Missing category lookup entry → halt and report slug
- JSON serialization error → log fragment index and halt
- Attempted insert without validated fragments → abort with message to rerun validation

## Integration

This task integrates with:

- Supabase ingestion pipeline (`supabase db remote commit` or custom ETL)
- QA checks (review `format_summary.md` before execution)

## Examples

- Batch of 110 fragments → JSON payload ~350 KB, SQL script with 110 rows ready for Supabase

## Notes

- Keep SQL script idempotent using `ON CONFLICT (source_id, location)` upsert pattern.
- Store hashed digest of `fragments_supabase.json` for audit.

---

_Task Version: 1.0.0_
_Last Updated: 2025-10-27_
