# Prepare Fragment Extraction Run

**Task ID:** `prepare-run`
**Purpose:** Capture and validate run context before any fragment extraction
**Workflow Mode:** Interactive setup
**Elicitation:** Structured prompts

## Overview

This task gathers every piece of context required to execute fragment extraction safely. It validates Supabase identifiers, loads taxonomy resources, resolves category lookups, and prepares run metadata that downstream tasks reuse without repetition.

## Prerequisites

Before executing this task, ensure you have:

- Access to the subject (mind) and source records inside Supabase
- Category lookup table exported as JSON (`taxonomy/category_lookup.json`)
- Fragment taxonomy references (`fragment_taxonomy.yaml`, `fragment_capture_standards.md`)
- Knowledge of the ingestion batch and job execution IDs when applicable
- Workspace paths for the raw source file and desired output directories

## Workflow

### Section 1: Collect Core Identifiers

**Instruction:** Prompt the user (or calling agent) for required identifiers and verify UUID format.

```
Inputs:
  - mind_id (uuid, required)
  - source_id (uuid, required)
  - ingestion_batch_id (uuid, optional)
  - generation_execution_id (uuid, optional)
Validation:
  - Reject non-UUID strings
  - Ensure mind_id and source_id are not identical
Output:
  core_ids:
    mind_id: <uuid>
    source_id: <uuid>
    ingestion_batch_id: <uuid|null>
    generation_execution_id: <uuid|null>
```

### Section 2: Capture Source Metadata

**Instruction:** Gather contextual details about the document to support location references and metadata enrichment.

```
Inputs:
  - document_path (absolute path)
  - document_type (enum: interview|podcast|article|video|notes|other)
  - language (ISO 639-1, optional; auto-detect fallback)
  - structural_format_hint (interview_format|monologue_format|dialogue_format|group_discussion_format|unknown)
Validation:
  - Confirm file exists and is UTF-8 encoded
  - Document type must be from the controlled list
Output:
  source:
    path: <string>
    document_type: <string>
    language: <string>
    structural_format_hint: <string>
```

### Section 3: Load Taxonomy Resources

**Instruction:** Load taxonomy and standards files to memory for downstream reuse. Flag if files are missing.

```
Steps:
  - Load fragment_taxonomy.yaml
  - Load fragment_segmentation_rules_mmos_v5_0.md (summary only)
  - Load fragment_capture_standards.md
Validation:
  - Fail fast if any file missing
  - Record taxonomy version/date
Output:
  taxonomy_resources:
    taxonomy_version: <string>
    taxonomy_path: <string>
    segmentation_rules_path: <string>
    capture_standards_path: <string>
```

### Section 4: Resolve Category Lookup

**Instruction:** Ingest the category lookup JSON that maps taxonomy slugs to Supabase `category_id` values.

```
Inputs:
  - category_lookup_path (default: templates/data/taxonomy/category_lookup.json)
Steps:
  - Load JSON
  - Validate each entry contains slug + category_id (integer)
  - Ensure every primary_category/subcategory pair has mapping
Failure:
  - If any mapping missing, surface actionable error and block run
Output:
  category_lookup:
    path: <string>
    entries_loaded: <int>
    missing_mappings: []
```

### Section 5: Build Run Metadata Payload

**Instruction:** Combine collected data into a canonical run descriptor JSON.

```
Output:
  run_context:
    mind_id: <uuid>
    source_id: <uuid>
    ingestion_batch_id: <uuid|null>
    generation_execution_id: <uuid|null>
    document:
      path: <string>
      document_type: <string>
      language: <string>
      structural_format_hint: <string>
    taxonomy:
      version: <string>
      lookup_entries: <int>
    timestamps:
      prepared_at: <ISO8601>
```

## Validation

Validate task completion by checking:

- All required UUIDs are valid and non-empty
- Source file path exists and is readable
- Category lookup contains mappings for every taxonomy slug
- Run metadata JSON includes timestamps and version info

## Output

**Format:** JSON
**Filename:** `run_context.json`
**Location:** `outputs/fragments/<mind_id>/<source_id>/`

Structure mirrors the `run_context` object from Workflow Section 5.

## Error Handling

- Invalid UUID → prompt for correction; do not continue
- Missing taxonomy resource → block run and list missing files
- Category lookup gaps → present missing slugs and suggest taxonomy update
- Inaccessible source file → report OS error and halt

## Integration

This task integrates with:

- `extract-fragments` (consumes run_context)
- `validate-fragment-batch` (needs taxonomy + lookup paths)
- `format-fragments-for-db` (requires UUIDs and lookup mapping)

## Examples

### Example 1: Interview Transcript

- mind_id: `5b19c1c4-5a29-4f94-bb59-7c58ed1f2664`
- source_id: `6d0fb1f8-1f63-4da5-9f2d-1dd53d31d0a3`
- document_type: `interview`
- structural_format_hint: `interview_format`
- taxonomy lookup entries: 112

### Example 2: Blog Article

- mind_id: `0a7bd741-28be-4c56-92d9-68a5f5db6c3e`
- source_id: `f4ee33d3-9fa1-45b0-86a7-bb7317b5f704`
- language provided: `en`
- structural_format_hint: `monologue_format`

## Notes

- Store resolved paths inside run metadata for reproducibility.
- Downstream tasks assume the directory from `run_context` exists; create it here.

---

_Task Version: 1.0.0_
_Last Updated: 2025-10-27_
