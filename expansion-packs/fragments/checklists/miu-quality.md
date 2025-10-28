# MIU Quality Checklist

Use this checklist after `extract-fragments` and before `format-fragments-for-db` to ensure each fragment honors MIU standards and MMOS v5.0 rules.

## Core Integrity
- [ ] Fragment includes subject + verb (grammatical completeness)
- [ ] Attribution clear (speaker identified or narrator context)
- [ ] References resolved (no dangling “he”, “there”, “that incident”)
- [ ] Zero-inference respected (no trait/emotion/behavior labels)

## Structural Rules
- [ ] Causal links preserved (cause + effect together)
- [ ] Temporal sequences preserved (trigger + response intact)
- [ ] Contrasts split (e.g., “but”, “however” split into separate MIUs)
- [ ] Multiple speakers split into separate fragments
- [ ] Length within bounds (5 ≤ words ≤ 200; warnings if outside)

## Context & Metadata
- [ ] Location token set (timestamp, paragraph, or index)
- [ ] Context captured (before/after sentences or responding_to when applicable)
- [ ] Structural metadata populated (word_count, clause_count, pronouns, verbs)
- [ ] Taxonomy fields populated (module, primary_category, subcategory, content_type)

## Scoring & Confidence
- [ ] Relevance scored (0–10) per Fragment Capture Standards
- [ ] Confidence rationale present and matches source quality
- [ ] Warnings recorded for edge cases (long causal chain, modal verbs, missing context)

## Output Sanity
- [ ] Fragment text matches source (quotes exact when type = direct_quote)
- [ ] Insight adds interpretive value without inference
- [ ] Metadata JSON valid and includes processing info (method, timestamp)
- [ ] No duplicate `(source_id, location)` collisions
