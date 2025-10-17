# /extract-fragments Task

Extract MIU (Minimal Interpretable Unit) fragments from raw text using LLM-based linguistic analysis.

**Task ID:** extract-fragments
**Agent:** @fragment-extractor
**Version:** 1.1.0

---

## Purpose

Extract behavioral evidence fragments from text with zero-inference (pure observables only).

**Quality Target:**
- 94%+ interpretability (psychologist can understand without context)
- 100% grammatical completeness
- 100% zero-inference compliance

---

## Inputs

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `source` | path | Yes | Path to raw text file |
| `subject_id` | string | Yes | Subject identifier (slug) |
| `output` | path | Yes | Where to save fragments.json |
| `language` | string | No | Source language (default: auto-detect) |

---

## Workflow Steps

1. **Load Source Text** - Read and validate input file
2. **LLM Extraction** - Use Claude Sonnet 4 to apply 6 fragmentation rules
3. **Linguistic Analysis** - Extract structure (pronouns, verbs, clauses, etc.)
4. **Format Identification** - Detect interview/monologue/dialogue format
5. **Quality Validation** - Run 8-point validation checklist
6. **Generate JSON** - Output fragments.json with metadata

---

## Success Criteria

- [ ] fragments.json created with valid schema
- [ ] 94%+ MIUs pass interpretability test
- [ ] 100% grammatical completeness
- [ ] Zero inference compliance (no trait labels)
- [ ] Format identification completed
- [ ] Quality checks all passed

---

**Full Task Specification:** `expansion-packs/innerlens/tasks/extract-fragments.md`
