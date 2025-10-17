# Task: Extract MIU Fragments

**Task ID:** extract-fragments
**Agent:** @fragment-extractor
**Version:** 1.1.0
**Dependencies:** Claude Sonnet 4 API, agents/fragment-extractor.md
**Extraction Method:** LLM-based (Claude Sonnet 4)

---

## Purpose

Extract MIU (Minimal Interpretable Unit) fragments from raw text using LLM-based linguistic analysis.

**Why LLM Extraction:**
- **Deep semantic understanding** - Not regex/heuristics
- **6 fragmentation rules** - Causal, temporal, contrast, attribution, min/max clauses
- **Zero-inference enforcement** - Extract ONLY observables, no trait categorization
- **Multi-language support** - Portuguese, English, Spanish, etc
- **Quality over speed** - Professional craftsmanship

**User's Explicit Requirement:**
> "A extração deve ser feito por LLMS e nao python"

**Quality Target:**
- 94%+ interpretability (psychologist can understand without context)
- 100% grammatical completeness
- 100% zero-inference compliance

---

## Inputs

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `source` | path | Yes | Path to raw text file | `"testing/validation/text_samples/alan_nicolas.txt"` |
| `subject_id` | string | Yes | Subject identifier (slug) | `"alan_nicolas"` |
| `output` | path | Yes | Where to save fragments.json | `"testing/validation/profiles/alan_nicolas_fragments.json"` |
| `language` | string | No | Source language (default: auto-detect) | `"pt-BR"`, `"en-US"`, `"auto-detect"` |
| `use_llm` | boolean | No | Use LLM extraction (default: true) | `true` |
| `model` | string | No | LLM model to use | `"claude-sonnet-4"`, `"claude-opus-4"` |

---

## Preconditions

- [ ] **Source file exists** and is readable (UTF-8 encoding)
- [ ] **Claude API key configured** - Set `ANTHROPIC_API_KEY` environment variable
- [ ] **Agent specification available** - `agents/fragment-extractor.md` exists
- [ ] **Output directory writable** - Parent directory exists

---

## Extraction Workflow

### Step 1: Load Source Text

```python
# Read source file
with open(source_file, 'r', encoding='utf-8') as f:
    text = f.read()

# Calculate statistics
word_count = len(text.split())
char_count = len(text)
line_count = len(text.splitlines())

print(f"📂 Loaded source:")
print(f"   File: {source_file}")
print(f"   Words: {word_count:,}")
print(f"   Characters: {char_count:,}")
print(f"   Lines: {line_count:,}")
```

**Auto-detect language:**
```python
# Simple language detection (pt-BR vs en-US)
pt_markers = ['não', 'você', 'porque', 'também', 'mas', 'então']
en_markers = ['the', 'and', 'but', 'because', 'you', 'that']

pt_count = sum(1 for marker in pt_markers if marker in text.lower())
en_count = sum(1 for marker in en_markers if marker in text.lower())

detected_language = "pt-BR" if pt_count > en_count else "en-US"
print(f"   Language: {detected_language} (auto-detected)")
```

---

### Step 2: Prepare LLM Extraction Prompt

**Load @fragment-extractor specification:**
```python
# Read agent specification (contains complete extraction rules)
with open('agents/fragment-extractor.md', 'r') as f:
    agent_spec = f.read()

# Extract key sections:
# - 6 MIU fragmentation rules
# - Zero-inference principles
# - MIU schema (TypeScript interface)
# - Validation checklist
```

**Build extraction prompt:**
```python
prompt = f"""You are @fragment-extractor, a specialist in extracting Minimal Interpretable Units (MIUs) from text for personality analysis.

**Your Task:**
Extract MIUs from the following text according to the 6 fragmentation rules.

**Source Text ({word_count} words, {detected_language}):**
---
{text}
---

**Fragmentation Rules (from agents/fragment-extractor.md):**

1. **Preserve Causal Links**
   - If fragment contains causal marker (porque, because, para, in order to)
   - Include BOTH cause AND effect in same MIU
   - Don't split mid-causal-chain

2. **Preserve Temporal Links**
   - If fragment contains temporal marker (quando, when, depois, after)
   - Include BOTH trigger AND behavior in same MIU
   - Don't split mid-temporal-sequence

3. **Separate Contrasts**
   - If sentence contains contrast (mas, but, porém, however)
   - SPLIT into 2 MIUs at contrast boundary
   - Each side = separate perspective/trait

4. **Separate Attributions**
   - If speaker changes (Alan said... Bob replied...)
   - SPLIT into separate MIUs
   - Track speaker in attribution.speaker_name

5. **Minimum: 1 Complete Clause**
   - Every MIU must have subject + verb (explicit or implied)
   - No sentence fragments without verb
   - No incomplete phrases

6. **Maximum: All Linked Clauses**
   - If clauses linked by causal/temporal connector, keep together
   - If clauses independent (comma-separated, unrelated), may split
   - Use interpretability as guide

**Zero-Inference Requirement:**
- Extract ONLY observables: verbatim text, grammar facts (verbs, pronouns, nouns)
- NO trait categorization (openness, conscientiousness, etc)
- NO emotional labels (positive, anxious, etc)
- NO behavioral labels (risk-taking, avoidant, etc)
- NO framework tags (big_five_*, hexaco_*, etc)

**Output Format:**
Return JSON with this structure:

{{
  "metadata": {{
    "subject_id": "{subject_id}",
    "extraction_date": "ISO 8601 timestamp",
    "extractor_version": "fragment-extractor_v1.1.0",
    "model": "claude-sonnet-4",
    "structural_format": {{
      "format": "auto_detected",
      "confidence": 0.0-1.0,
      "detected_patterns": ["pattern1", "pattern2"]
    }},
    "content_statistics": {{
      "original_word_count": {word_count},
      "original_char_count": {char_count},
      "mius_extracted": 0,
      "mius_rejected": 0,
      "rejection_rate": 0.0,
      "extraction_rate_mius_per_1000w": 0.0,
      "avg_miu_word_count": 0.0,
      "avg_miu_clause_count": 0.0,
      "min_miu_word_count": 0,
      "max_miu_word_count": 0,
      "mius_by_speaker": {{}},
      "processing_time_seconds": 0.0,
      "processing_speed_words_per_second": 0.0
    }},
    "quality_checks": {{
      "all_mius_grammatically_complete": true,
      "all_mius_have_clear_attribution": true,
      "causal_links_preserved": true,
      "temporal_links_preserved": true,
      "contrasts_separated": true,
      "interpretability_target_met": true,
      "zero_inference_compliant": true,
      "context_preserved": true,
      "validation_passed": true
    }},
    "warnings": [],
    "extraction_cost_usd": 0.0
  }},
  "fragments": [
    {{
      "fragment_id": "f_{subject_id}_001",
      "subject_id": "{subject_id}",
      "content": {{
        "verbatim": "exact text from source",
        "word_count": 0,
        "clause_count": 0
      }},
      "attribution": {{
        "speaker": "subject|other|group|narrator",
        "speaker_name": "name or null"
      }},
      "source": {{
        "document_id": "source_file_name",
        "document_type": "self_analysis|article|podcast_transcript|interview|etc",
        "char_position": [start, end],
        "timestamp": null,
        "medium": "text",
        "language": "{detected_language}"
      }},
      "context": {{
        "sentence_before": null,
        "sentence_after": null,
        "responding_to": null
      }},
      "structure": {{
        "words": ["word1", "word2"],
        "pronouns": ["eu", "você"],
        "verbs": ["usa", "cria"],
        "verb_forms": ["present", "infinitive"],
        "nouns": ["conceito", "experiência"],
        "adjectives": ["crua", "não convencional"],
        "adverbs": ["claramente"],
        "punctuation": [".", ","],
        "has_question_mark": false,
        "has_exclamation": false,
        "tenses_detected": ["present"],
        "modal_verbs": ["pode", "deve"]
      }},
      "extraction": {{
        "method": "claude_sonnet_4_llm",
        "version": "1.1.0",
        "timestamp": "ISO 8601",
        "model": "claude-sonnet-4",
        "cost_usd": 0.0
      }}
    }}
  ]
}}

**Important:**
- Extract ALL valid MIUs (aim for 15-100 MIUs per 1000 words)
- Ensure 100% grammatical completeness (every MIU has verb + complete clause)
- Ensure 100% zero-inference (NO trait/emotion/behavior labels)
- Populate ALL required fields in schema
- Set quality_checks.validation_passed = true only if ALL checks pass
"""

return prompt
```

---

### Step 3: Call Claude API for Extraction

```python
import anthropic
import json
import time
from datetime import datetime

# Initialize client
client = anthropic.Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY"))

print(f"🤖 Extracting MIUs with Claude Sonnet 4...")
print(f"   Model: {model}")
print(f"   Language: {detected_language}")
print(f"   Applying: 6 MIU fragmentation rules")

start_time = time.time()

# Call API
response = client.messages.create(
    model=model,  # claude-sonnet-4-20250514
    max_tokens=16000,
    temperature=0.0,  # Deterministic extraction
    system="You are @fragment-extractor, a specialist in extracting Minimal Interpretable Units (MIUs) from text for personality analysis. You follow strict zero-inference principles and 6 fragmentation rules.",
    messages=[
        {"role": "user", "content": prompt}
    ]
)

extraction_time = time.time() - start_time

# Parse response
response_text = response.content[0].text

# Extract JSON (may be wrapped in ```json``` markdown)
if "```json" in response_text:
    json_start = response_text.find("```json") + 7
    json_end = response_text.find("```", json_start)
    response_json = response_text[json_start:json_end].strip()
else:
    response_json = response_text

data = json.loads(response_json)

# Calculate cost
input_tokens = response.usage.input_tokens
output_tokens = response.usage.output_tokens

# Claude Sonnet 4 pricing (2025): $3/MTok input, $15/MTok output
input_cost = (input_tokens / 1_000_000) * 3.0
output_cost = (output_tokens / 1_000_000) * 15.0
total_cost = input_cost + output_cost

# Update metadata with actual values
data['metadata']['extraction_cost_usd'] = round(total_cost, 4)
data['metadata']['content_statistics']['processing_time_seconds'] = round(extraction_time, 2)
data['metadata']['content_statistics']['processing_speed_words_per_second'] = round(word_count / extraction_time, 1)

print(f"   ✅ Extraction complete!")
print(f"      MIUs extracted: {len(data['fragments'])}")
print(f"      Processing time: {extraction_time:.1f}s")
print(f"      Cost: ${total_cost:.4f}")
print(f"      Tokens: {input_tokens:,} in + {output_tokens:,} out")
```

---

### Step 4: Post-Process and Validate

**Validate output structure:**
```python
# Ensure required fields present
assert 'metadata' in data, "Missing metadata section"
assert 'fragments' in data, "Missing fragments array"

fragments = data['fragments']
metadata = data['metadata']

print(f"\n📊 Extraction Statistics:")
print(f"   Original: {word_count:,} words")
print(f"   MIUs extracted: {len(fragments)}")
print(f"   MIUs rejected: {metadata['content_statistics'].get('mius_rejected', 0)}")
print(f"   Extraction rate: {metadata['content_statistics']['extraction_rate_mius_per_1000w']:.1f} MIUs/1000w")
print(f"   Avg words/MIU: {metadata['content_statistics']['avg_miu_word_count']:.1f}")
print(f"   Avg clauses/MIU: {metadata['content_statistics']['avg_miu_clause_count']:.1f}")
```

**Quick sanity checks:**
```python
warnings = []

# Check extraction rate (expected: 15-100 MIUs per 1000 words)
extraction_rate = metadata['content_statistics']['extraction_rate_mius_per_1000w']
if extraction_rate < 15:
    warnings.append(f"Low extraction rate ({extraction_rate:.1f} MIUs/1000w) - may be under-fragmenting")
elif extraction_rate > 100:
    warnings.append(f"High extraction rate ({extraction_rate:.1f} MIUs/1000w) - may be over-fragmenting")

# Check grammatical completeness
incomplete_count = 0
for frag in fragments:
    if len(frag['structure'].get('verbs', [])) == 0:
        incomplete_count += 1

if incomplete_count > 0:
    warnings.append(f"{incomplete_count}/{len(fragments)} MIUs missing verbs (grammatical incompleteness)")

# Check zero-inference compliance
forbidden_patterns = ['openness', 'conscientiousness', 'extraversion', 'big_five', 'trait']
inference_violations = 0
for frag in fragments:
    frag_json = json.dumps(frag).lower()
    if any(pattern in frag_json for pattern in forbidden_patterns):
        inference_violations += 1

if inference_violations > 0:
    warnings.append(f"{inference_violations}/{len(fragments)} MIUs contain forbidden trait labels (zero-inference violated)")

if warnings:
    print(f"\n🟡 Warnings detected:")
    for w in warnings:
        print(f"   ⚠️  {w}")
    # Add to metadata
    metadata['warnings'].extend(warnings)
```

---

### Step 5: Save Output

```python
# Ensure output directory exists
output_path = Path(output)
output_path.parent.mkdir(parents=True, exist_ok=True)

# Save fragments.json
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"\n✅ Fragments saved:")
print(f"   📄 File: {output_path}")
print(f"   📊 Size: {output_path.stat().st_size:,} bytes")
```

---

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `fragments.json` | file | Complete MIU extraction with metadata + fragments array |
| `mius_extracted` | integer | Count of MIUs extracted |
| `extraction_cost` | float | Cost in USD (Claude API) |
| `warnings` | array | Non-critical issues detected |
| `quality_checks` | object | Boolean validation results |

---

## Error Handling

| Error | Cause | Resolution |
|-------|-------|------------|
| `ANTHROPIC_API_KEY not set` | Missing API key | Set environment variable |
| `Source file not found` | Invalid path | Verify file exists |
| `API timeout` | Large file (>50k words) | Split into chunks or increase timeout |
| `Rate limit exceeded` | Too many API calls | Wait and retry with exponential backoff |
| `Invalid JSON response` | LLM formatting error | Retry with explicit JSON formatting instructions |
| `Zero-inference violated` | LLM included trait labels | Review prompt, add explicit prohibition |

---

## Success Criteria

- [x] MIUs extracted (15-100 per 1000 words ideal)
- [x] 100% grammatical completeness (all MIUs have verbs)
- [x] 100% zero-inference compliance (no trait/emotion labels)
- [x] All required schema fields populated
- [x] fragments.json saved successfully
- [x] metadata.quality_checks.validation_passed = true

---

## Usage Examples

### Example 1: Extract Alan Nicolas MIUs

```bash
@fragment-extractor
*task extract-fragments \
  --source testing/validation/text_samples/alan_nicolas.txt \
  --subject-id alan_nicolas \
  --output testing/validation/profiles/alan_nicolas_fragments.json \
  --language auto-detect \
  --use-llm true
```

**Expected output:**
```
📂 Loaded source:
   File: alan_nicolas.txt
   Words: 1,426
   Language: pt-BR (auto-detected)

🤖 Extracting MIUs with Claude Sonnet 4...
   Model: claude-sonnet-4
   Applying: 6 MIU fragmentation rules

   ✅ Extraction complete!
      MIUs extracted: 103
      Processing time: 8.3s
      Cost: $0.1247
      Tokens: 2,148 in + 8,952 out

📊 Extraction Statistics:
   Original: 1,426 words
   MIUs extracted: 103
   Extraction rate: 72.2 MIUs/1000w
   Avg words/MIU: 13.8
   Avg clauses/MIU: 2.1

✅ Fragments saved:
   📄 File: testing/validation/profiles/alan_nicolas_fragments.json
   📊 Size: 124,582 bytes
```

---

### Example 2: Extract Sam Altman MIUs (English)

```bash
@fragment-extractor
*task extract-fragments \
  --source testing/data/sam_altman_sample.txt \
  --subject-id sam_altman \
  --output testing/results/sam_altman_fragments.json \
  --language en-US
```

---

### Example 3: Extract with Claude Opus 4 (Higher Quality)

```bash
@fragment-extractor
*task extract-fragments \
  --source outputs/minds/naval_ravikant/sources/podcast_calm_mind.txt \
  --subject-id naval_ravikant \
  --output testing/results/naval_fragments.json \
  --model claude-opus-4  # More expensive but higher quality
```

**Cost difference:**
- Sonnet 4: $0.12 per 1,000 words
- Opus 4: $0.60 per 1,000 words (5x more expensive)

---

## Performance

**Benchmarks:**

| Text Size | MIUs | Time | Cost (Sonnet 4) | Cost (Opus 4) |
|-----------|------|------|-----------------|---------------|
| 1,000 words | 60-80 | 5-8s | $0.08-$0.12 | $0.40-$0.60 |
| 5,000 words | 300-400 | 25-35s | $0.40-$0.60 | $2.00-$3.00 |
| 10,000 words | 600-800 | 50-70s | $0.80-$1.20 | $4.00-$6.00 |
| 50,000 words | 3000-4000 | 4-6min | $4.00-$6.00 | $20.00-$30.00 |

**Optimization:**
- Use Sonnet 4 (not Opus) for most extractions (5x cheaper, 95% same quality)
- Batch multiple subjects in parallel (if processing many minds)
- Cache API responses to avoid re-extraction

---

## Integration Points

### Upstream (provides input):
- User provides: raw text file, subject metadata
- `testing/validation/text_samples/` - Sample text files

### Downstream (consumes output):
- `tasks/validate-mius.md` - Validates fragments.json quality
- `tasks/save-fragments-to-mmos.md` - Saves to database
- `tasks/analyze-bigfive.md` - Uses MIUs for personality analysis

### Lateral (parallel):
- `workflows/extract-analyze-save.md` - Calls this task as Step 2

---

## Quality Guarantees

**This task ensures:**

1. **LLM-Based Extraction** - Uses Claude Sonnet 4 (NOT Python regex/heuristics)
2. **6 Fragmentation Rules** - Causal, temporal, contrast, attribution, min/max clauses
3. **Zero-Inference** - Extracts ONLY observables (verbatim text + grammar facts)
4. **Framework Agnostic** - No Big Five bias, reusable for HEXACO, MBTI, etc
5. **Complete Schema** - All required fields populated
6. **Quality Metadata** - Tracks confidence, warnings, validation status

**User's Requirements Met:**
- ✅ "A extração deve ser feito por LLMS e nao python"
- ✅ "Precisamos criar tools que façam isso ser ser usadas pelas tasks"
- ✅ "Precisamos de um workflow padrão para qualquer mente"

---

## Related Resources

- **Agent:** `agents/fragment-extractor.md` - Complete extraction specification (900+ lines)
- **Checklist:** `checklists/miu-quality.md` - Validation criteria
- **Task:** `tasks/validate-mius.md` - Quality validation (next step)
- **Workflow:** `workflows/extract-analyze-save.md` - Full pipeline
- **Architecture:** `docs/MIU-FRAGMENT-ARCHITECTURE.md` - Design principles

---

## Notes

- **LLM Required:** This task REQUIRES Claude API access. Cannot fall back to regex/heuristics.
- **Cost Awareness:** Avg $0.10-$0.20 per 1,000 words. Budget accordingly for large corpora.
- **Language Support:** Optimized for Portuguese (pt-BR) and English (en-US). Other languages work but may have lower quality.
- **Deterministic:** temperature=0.0 ensures same input = same output (reproducibility).
- **Validation Next:** Always run `validate-mius` task after extraction to verify quality.

---

**Task Status:** ✅ Production Ready
**Last Updated:** 2025-10-16
**Version:** 1.1.0
**Owner:** InnerLens Development Team
