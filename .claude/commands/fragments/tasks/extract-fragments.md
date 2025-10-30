# Extract Fragments (LLM MIU Pipeline)

**Task ID:** `extract-fragments`
**Purpose:** Segment source text into database-ready Minimal Interpretable Units (MIUs)
**Workflow Mode:** Guided automation
**Elicitation:** Basic (confirm prompts & options)

## Overview

This task activates `@fragment-extractor` to transform raw behavioral evidence into MIUs that comply with MMOS v5.0 standards and the Supabase `fragments` schema. It reads `run_context.json` produced by `prepare-run`, executes LLM-based fragmentation, enriches metadata, and outputs a provisional fragment batch (`fragments_raw.json`) for validation.

## Prerequisites

Before executing this task, ensure you have:

- Completed `prepare-run` with a fresh `run_context.json`
- Claude Sonnet 4 credentials configured (`ANTHROPIC_API_KEY`)
- Access to taxonomy resources referenced in run context
- A writable output directory (`outputs/fragments/<mind>/<source>/`)
- Source document path recorded in the run context

## Workflow

### Section 1: Load Run Context

**Instruction:** Read `run_context.json` and confirm required fields.

```
Steps:
  - Load JSON from run_context_path
  - Validate presence of mind_id, source_id, document.path, taxonomy.lookup_entries ≥ 1
  - Abort if any requirement missing
Output:
  runtime:
    mind_id: <uuid>
    source_id: <uuid>
    ingestion_batch_id: <uuid|null>
    generation_execution_id: <uuid|null>
    document:
      path: <string>
      document_type: <string>
      language: <string>
```

### Section 2: Inspect Source Document

**Instruction:** Read the raw document to gather statistics and detect structural format.

```
Steps:
  - Read file in UTF-8
  - Count characters, words, line breaks
  - Auto-detect language when run_context language is `auto`
  - Detect structural format (interview/monologue/dialogue/group) via heuristic or LLM probe
Output:
  source_stats:
    word_count: <int>
    char_count: <int>
    line_count: <int>
    detected_language: <string>
    structural_format:
      format: <enum>
      confidence: <float 0-1>
      notes: <string>
```

### Section 3: Build Extraction Prompt

**Instruction:** Assemble the LLM prompt by embedding fragmentation rules, zero-inference principles, and database requirements.

```
Components:
  - MIU definition + six segmentation rules
  - Zero-inference checklist
  - Required metadata fields (taxonomy, structure, context, insight)
  - Instructions to produce JSON aligning with Supabase schema fields
Action:
  - Store prompt string for auditing (save to `prompt_extract.txt`)
Output:
  prompt_ready: true
```

### Section 4: Run LLM Extraction

**Instruction:** Invoke Claude Sonnet 4 with deterministic settings and capture usage statistics.

```
Parameters:
  - model: claude-sonnet-4
  - temperature: 0.0
  - max_tokens: 16000
  - system prompt: @fragment-extractor persona summary
Inputs:
  - Entire prompt generated in Section 3
Outputs:
  - raw LLM response (string)
  - token usage (prompt/completion)
  - elapsed time
  - estimated USD cost
Store:
  - Save raw response to `fragments_raw_response.txt`
  - Parse JSON payload; fail if invalid JSON
```

### Section 5: Normalize Fragment Payload

**Instruction:** Convert LLM output into canonical structure for downstream validation.

```
Steps:
  - Ensure metadata includes extraction statistics (word counts, speeds)
  - Inject run context (mind_id, source_id, ingestion_batch_id, generation_execution_id)
  - Append structural format detection results
  - For each fragment:
      * Add mind_id, source_id
      * Generate stable fragment reference `f_{mind_slug}_{sequence:000}`
      * Copy verbatim text into `content`
      * Map `type` to Supabase `type`
      * Attach `relevance` (0-10) and `insight`
      * Include `location` token derived from source markers or auto-index
  - Mark fragments missing metadata for later validation warnings
Output file:
  `fragments_raw.json`
```

### Section 6: Quality Snapshot

**Instruction:** Provide a quick report for human review.

```
Generate:
  - Count of fragments extracted
  - Average word count / clause count
  - Relevance distribution (histogram 0-10)
  - Top warnings emitted by LLM (if any)
  - Save summary to `fragments_raw_summary.md`
```

## Validation

Validate task completion by confirming:

- `run_context.json` successfully loaded and merged
- LLM output parsed without JSON errors
- Every fragment object includes `content`, `context`, `insight`, `type`, `relevance`
- `fragments_raw.json` saved alongside `prompt_extract.txt` and summary report
- Extraction metadata records token usage and cost

## Output

**Primary artifacts:**

- `fragments_raw.json` — provisional fragments with full metadata
- `fragments_raw_summary.md` — human-readable extraction recap
- `prompt_extract.txt` — prompt used for reproducibility
- `fragments_raw_response.txt` — raw LLM response for auditing

All files saved under `outputs/fragments/<mind_id>/<source_id>/`.

## Error Handling

- Missing run context → abort with message to execute `prepare-run`
- Invalid JSON from LLM → retry once; if still invalid, raise error and attach raw response
- Rate limit or API error → surface provider message, suggest manual retry
- Structural format detection failure → set format to `unknown` with warning

## Integration

This task integrates with:

- `validate-fragment-batch` (consumes `fragments_raw.json`)
- `format-fragments-for-db` (uses normalized data post-validation)
- `@fragment-extractor` agent spec (for rules and security posture)

## Examples

- **Interview**: 6,200-word transcript → 118 fragments, average 72 words, relevance clustered 6-9
- **Blog article**: 2,100 words → 42 fragments, majority relevance 4-7, structural format `monologue`

## Notes

- Keep temperature at 0.0 to ensure deterministic clause boundaries.
- Update prompt fragments when taxonomy version changes.
- Record cost metadata even for dry runs to support budgeting analytics.

---

_Task Version: 2.0.0_
_Last Updated: 2025-10-27_
