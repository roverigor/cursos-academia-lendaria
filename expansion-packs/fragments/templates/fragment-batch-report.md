# Fragment Batch Report Template

## Run Metadata
- **Mind ID:** {{ mind_id }}
- **Source ID:** {{ source_id }}
- **Document Type:** {{ document_type }}
- **Language:** {{ language }}
- **Extraction Timestamp:** {{ extraction_timestamp }}
- **Model:** {{ model }}
- **Cost (USD):** {{ cost_usd }}

## Extraction Summary
- Total fragments extracted: {{ total_fragments }}
- Average words per fragment: {{ avg_words }}
- Average clauses per fragment: {{ avg_clauses }}
- Relevance distribution: {{ relevance_distribution }}
- Structural format: {{ structural_format }} (confidence {{ format_confidence }})

## Validation Outcomes
- Valid fragments: {{ valid_count }}
- Warnings: {{ warning_count }}
- Invalid fragments: {{ invalid_count }}
- Zero-inference pass: {{ zero_inference_pass }}
- Missing taxonomy mappings: {{ taxonomy_gaps }}

## Top Warnings
1. {{ warning_1 }}
2. {{ warning_2 }}
3. {{ warning_3 }}

## Action Items
- [ ] {{ action_item_1 }}
- [ ] {{ action_item_2 }}
- [ ] {{ action_item_3 }}

## Notes
{{ notes }}
