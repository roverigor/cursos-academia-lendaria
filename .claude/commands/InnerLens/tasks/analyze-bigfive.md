# /analyze-bigfive Task

Big Five (OCEAN) personality analysis from MIU fragments.

**Task ID:** analyze-bigfive
**Agent:** @psychologist
**Version:** 1.0.0

---

## Purpose

Analyze extracted MIU fragments to detect Big Five personality traits with evidence-based reasoning.

**Frameworks:** Big Five (OCEAN) - Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism

---

## Inputs

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fragments` | path | Yes | Path to fragments.json from @fragment-extractor |
| `output` | path | Yes | Where to save bigfive-raw.yaml |

---

## Workflow Steps

1. **Load Fragments** - Read and validate MIU fragments
2. **Load Framework** - Load Big Five knowledge base
3. **Batch Processing** - Analyze fragments in batches
4. **Trait Detection** - Detect 5 traits + 30 facets with evidence
5. **Confidence Scoring** - Calculate statistical confidence
6. **Generate Profile** - Output bigfive-raw.yaml with evidence + reasoning

---

## Success Criteria

- [ ] All 5 traits analyzed (O, C, E, A, N)
- [ ] All 30 facets scored (6 per trait)
- [ ] 3-5 evidence fragments per trait
- [ ] Confidence scores calculated
- [ ] Output follows YAML schema
- [ ] Ready for @quality-assurance validation

---

**Full Task Specification:** `expansion-packs/innerlens/tasks/analyze-bigfive.md`
