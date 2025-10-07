---
task-id: synthesis-compilation
name: Framework & Knowledge Base Synthesis
agent: cognitive-analyst
version: 1.0.0
purpose: Transform cognitive analysis into implementation-ready frameworks, templates, and knowledge chunks

workflow-mode: interactive
elicit: true
elicitation-type: custom

prerequisites:
  - Cognitive analysis complete with all 8 layers validated
  - cognitive-spec.yaml exists and validated
  - mind-brief.md generated

inputs:
  - name: mind_name
    type: string
    required: true
  - name: mode
    type: enum
    required: true
    options: ["frameworks", "templates", "phrases", "contradictions", "kb_chunking", "specialist_recommender", "full"]
    default: "full"
  - name: cognitive_spec_path
    type: file_path
    required: true
    default: "docs/minds/{mind_name}/analysis/cognitive-spec.yaml"

outputs:
  - path: "docs/minds/{mind_name}/synthesis/frameworks/"
    description: Actionable decision frameworks extracted from cognitive architecture
  - path: "docs/minds/{mind_name}/synthesis/kb/"
    description: Chunked knowledge base optimized for RAG

dependencies:
  templates:
    - cognitive-spec.yaml
  checklists:
    - analysis-completeness-checklist.md

validation:
  success-criteria:
    - "Minimum 5 actionable frameworks extracted"
    - "KB chunked with proper metadata for RAG"
    - "Signature phrases catalog with 20+ examples"

estimated-duration: "3-4 hours for full synthesis"
---

# Synthesis Compilation Task

## Purpose

Transform cognitive analysis artifacts (8 layers) into implementation-ready synthesis outputs: actionable frameworks, communication templates, signature phrases, knowledge base chunks, and specialist recommendations. This task bridges analysis (Phase 3) and implementation (Phase 5), distilling cognitive architecture into structured formats optimized for system prompt compilation and RAG deployment.

## When to Use This Task

**Use this task when:**
- Phase 3 (Cognitive Analysis) complete with all 8 layers validated
- cognitive_architecture.yaml exists and validated
- Ready to begin Phase 4 (Synthesis) from execute-mmos-pipeline
- Need to prepare knowledge for system prompt integration

**Do NOT use this task when:**
- Cognitive analysis not complete (finish cognitive-analysis first)
- System prompts already generated (proceed to mind-validation)
- Only updating specific elements (use brownfield-update)

### Mode Descriptions

**`frameworks`** - Extract actionable frameworks and methodologies
**`templates`** - Build communication templates from Layer 2
**`phrases`** - Mine signature phrases for voice consistency
**`contradictions`** - Synthesize Layer 8 paradoxes for prompt integration
**`kb_chunking`** - Chunk knowledge base for RAG or fine-tuning
**`specialist_recommender`** - Recommend specialist variants
**`full`** - Execute complete synthesis pipeline

## Key Activities & Instructions

### Mode: Frameworks

#### Objective

Extract and structure actionable frameworks, methodologies, and mental models into reusable templates.

**Framework Types:**
```yaml
framework_categories:
  decision_frameworks:
    - "How they make choices"
    - "Criteria and trade-offs"
    - "Process steps"

  problem_solving_frameworks:
    - "How they approach problems"
    - "Diagnostic questions"
    - "Solution generation methods"

  communication_frameworks:
    - "How they structure arguments"
    - "Explanation patterns"
    - "Persuasion techniques"

  domain_specific_frameworks:
    - "Unique methods in their expertise"
    - "Proprietary approaches"
    - "Signature systems"

  meta_frameworks:
    - "How they think about frameworks"
    - "When to apply which framework"
```

**Extraction Process:**

1. **Mine Layer 5 (Mental Models)** for explicit frameworks
2. **Infer from Layer 1 (Behavioral Patterns)** - consistent problem-solving approaches
3. **Extract from sources** - explicitly named frameworks ("My 3-step process...")
4. **Template each framework**:

```yaml
framework_template:
  name: "{{framework_name}}"
  category: {{type}}
  description: "{{what_it_does}}"

  when_to_use:
    context: "{{when_applicable}}"
    trigger: "{{what_prompts_its_use}}"

  steps:
    - step: 1
      action: "{{what_to_do}}"
      questions: [{{diagnostic_questions}}]
      output: "{{what_this_produces}}"

    - step: 2
      [... repeat ...]

  example_application:
    scenario: "{{specific_example}}"
    execution: "{{how_they_applied_it}}"
    outcome: "{{result}}"

  source_evidence:
    - source: source_012
      quote: "{{quote}}"

  implementation_notes: "{{how_to_encode_in_prompt}}"
```

**Output:** `minds/{mind}/artifacts/frameworks_synthesized.md`

```markdown
# Frameworks - {{Mind Name}}

## Decision Framework: {{name}}

**When to Use:** {{context}}

**Process:**
1. {{step}}
2. {{step}}
3. {{step}}

**Example Application:**
{{scenario}} → {{execution}} → {{outcome}}

**Key Principle:** "{{their_quote}}"

**Implementation Guidance:** {{for_prompt}}

---

[... repeat for all frameworks ...]

## Framework Index
- Decision-Making: {{count}} frameworks
- Problem-Solving: {{count}} frameworks
- Communication: {{count}} frameworks
- Domain-Specific: {{count}} frameworks

## Cross-Framework Patterns
{{how_frameworks_interconnect}}
```

### Mode: Templates

#### Objective

Build reusable communication templates from Layer 2 (Communication Style).

**Template Types:**
```yaml
template_categories:
  explanation_templates:
    - "How they explain complex concepts"
    - "Analogies and metaphors structure"
    - "Simplification patterns"

  argumentation_templates:
    - "How they build arguments"
    - "Evidence presentation order"
    - "Persuasion structure"

  storytelling_templates:
    - "Narrative structures they use"
    - "Character/conflict/resolution patterns"
    - "Hook and payoff techniques"

  response_templates:
    - "How they answer different question types"
    - "Framework for advice-giving"
    - "Critique and feedback structure"
```

**Extraction Process:**

1. **Analyze communication samples** from Layer 2 artifacts
2. **Identify repeating structures** (opening patterns, transitions, closings)
3. **Extract templates** with variable placeholders
4. **Validate across sources** (must appear ≥3 times)

**Template Format:**
```yaml
template:
  name: "{{template_name}}"
  category: {{type}}
  usage_frequency: {{high/medium/low}}

  structure:
    opening: "{{pattern}}"
    body: "{{pattern}}"
    closing: "{{pattern}}"

  variables:
    - "{{variable_1}}"
    - "{{variable_2}}"

  example_instantiation:
    input: "{{question/situation}}"
    output: "{{templated_response}}"

  source_occurrences: {{count}}
```

**Output:** `minds/{mind}/artifacts/communication_templates.md`

### Mode: Phrases

#### Objective

Mine signature phrases, catchphrases, and linguistic markers that define their voice.

**Phrase Categories:**
```yaml
phrase_types:
  signature_phrases:
    - "Repeated verbatim across sources"
    - "Becomes associated with them"
    - "Example: 'No B.S.' (Dan Kennedy)"

  transitional_phrases:
    - "How they move between ideas"
    - "Look, here's the thing..."
    - "The reality is..."

  emphasis_phrases:
    - "What they say for emphasis"
    - "This is critical..."
    - "Pay attention to this..."

  qualification_phrases:
    - "How they add nuance"
    - "In most cases..."
    - "Generally speaking..."

  rhetorical_devices:
    - "Repeated questions"
    - "Characteristic metaphors"
    - "Signature analogies"
```

**Extraction Process:**

1. **Mine all sources** for repeated phrases (≥5 occurrences)
2. **Categorize phrases** by function
3. **Note context** (when each phrase appears)
4. **Frequency analysis** (high/medium/low usage)

**Output:** `minds/{mind}/artifacts/signature_phrases.md`

```markdown
# Signature Phrases - {{Mind Name}}

## High-Frequency Phrases (Used Consistently)

**"{{phrase_1}}"**
- Frequency: {{count}} occurrences across {{sources}} sources
- Context: {{when_used}}
- Function: {{purpose}}
- Example: "{{quote_in_context}}"

[... repeat for all high-frequency phrases ...]

## Medium-Frequency Phrases (Regular Usage)
[... same structure ...]

## Contextual Phrases (Specific Situations)
[... same structure ...]

## Phrase Application Guide
- **For explanations**: Use [{{list}}]
- **For emphasis**: Use [{{list}}]
- **For transitions**: Use [{{list}}]
- **For qualification**: Use [{{list}}]

## Voice Consistency Score
Target phrase density: {{percentage}}% of responses should include signature phrases
Critical phrases (must use): [{{top_5}}]
```

### Mode: Contradictions

#### Objective

Synthesize Layer 8 (Productive Paradoxes) into prompt-ready contradiction handling rules.

**Synthesis Structure:**
```yaml
paradox_synthesis:
  for_each_paradox:
    original_paradox: "{{from_Layer_8}}"

    prompt_encoding:
      rule: "{{how_to_express_as_instruction}}"
      context_detection: "{{when_to_apply_side_A_vs_side_B}}"
      resolution_pattern: "{{how_to_navigate}}"

    example_scenarios:
      scenario_a:
        input: "{{question}}"
        side_triggered: A
        response: "{{how_to_respond}}"

      scenario_b:
        input: "{{question}}"
        side_triggered: B
        response: "{{how_to_respond}}"

    authenticity_note: "{{why_this_makes_clone_feel_human}}"
```

**Output:** `minds/{mind}/artifacts/contradictions_synthesized.md`

```markdown
# Productive Paradoxes - System Prompt Integration

## Paradox 1: {{title}}

**Original Contradiction:** "{{belief_A}}" AND "{{belief_B}}"

**Prompt Instruction:**
```
When addressing {{topic}}, navigate the tension between {{A}} and {{B}} by:
- Apply {{A}} when context shows {{condition_A}}
- Apply {{B}} when context shows {{condition_B}}
- Acknowledge the paradox explicitly if user questions the apparent contradiction
```

**Context Detection Rules:**
- Trigger A: [{{conditions}}]
- Trigger B: [{{conditions}}]

**Example Responses:**

*User: "{{question_favoring_A}}"*
*Response: "{{answer_using_side_A}}"*

*User: "{{question_favoring_B}}"*
*Response: "{{answer_using_side_B}}"*

**Authenticity Value:** This paradox prevents robotic consistency and enables contextual wisdom.

---

[... repeat for all paradoxes ...]

## Paradox Navigation Meta-Rule
When paradoxes conflict with each other, priority order:
1. {{paradox_priority_1}}
2. {{paradox_priority_2}}
[... etc ...]
```

### Mode: KB Chunking

#### Objective

Chunk cognitive architecture and synthesis outputs into optimized knowledge base format for RAG or fine-tuning.

**Chunking Strategy:**
```yaml
chunk_optimization:
  chunk_size:
    rag_target: 1000-1500 tokens
    fine_tuning_target: 500-1000 tokens

  chunk_coherence:
    principle: "Each chunk = one complete concept"
    avoid: "Mid-concept cuts"

  chunk_types:
    behavioral_chunks: "Layer 1 patterns as examples"
    framework_chunks: "Complete frameworks"
    value_chunks: "Values with context"
    paradox_chunks: "Full paradox with resolution"
    example_chunks: "Case studies and applications"
```

**Chunking Process:**

1. **Aggregate all artifacts** (Layers 1-8, frameworks, templates, phrases)
2. **Identify chunk boundaries** (conceptual units)
3. **Optimize chunk size** for target deployment
4. **Add metadata** (layer, topic, keywords)
5. **Validate coherence** (each chunk standalone-understandable)

**Chunk Format:**
```markdown
---
chunk_id: chunk_001
layer: 5
topic: decision_framework
keywords: [decisions, framework, criteria]
confidence: high
---

# Decision Framework: {{name}}

{{complete_framework_description}}

**Source Evidence:** {{citations}}

**Application Example:** {{example}}
```

**Output:** `minds/{mind}/kb/chunk_*.md` (multiple files)

**Index File:** `minds/{mind}/kb/index.yaml`

```yaml
knowledge_base_index:
  total_chunks: {{count}}
  chunk_size_range: "{{min}}-{{max}} tokens"

  chunks_by_layer:
    layer_1: {{count}} chunks
    layer_2: {{count}} chunks
    [... etc ...]

  chunks_by_topic:
    decision_making: [{{chunk_ids}}]
    communication: [{{chunk_ids}}]
    [... etc ...]

  retrieval_optimization:
    high_importance: [{{critical_chunks}}]
    medium_importance: [{{standard_chunks}}]
    low_importance: [{{contextual_chunks}}]
```

### Mode: Specialist Recommender

#### Objective

Analyze cognitive architecture to recommend viable specialist variants with specific use cases.

**Analysis Framework:**
```yaml
specialist_recommendation:
  factors:
    domain_breadth:
      - "How many domains do they cover?"
      - "Which have depth for specialist focus?"

    use_case_patterns:
      - "What specific problems do they solve?"
      - "Which audiences benefit most?"

    framework_specialization:
      - "Which frameworks are domain-specific?"
      - "Can frameworks adapt to niche use cases?"

    market_demand:
      - "What specialist roles are high-value?"
      - "Where is specific expertise needed?"
```

**Recommendation Process:**

1. **Identify expertise domains** from Layer 5 and sources
2. **Map to use cases** (who needs this expertise?)
3. **Assess viability** (enough depth for specialist?)
4. **Estimate effort** (how much adaptation needed?)
5. **Prioritize** by value and feasibility

**Output:** `minds/{mind}/docs/logs/{timestamp}-specialist_recommendations.yaml`

```yaml
specialist_recommendations:
  mind_name: "{{name}}"
  generalista_baseline: "{{path_to_generalista}}"

  recommended_specialists:
    - specialist: "{{name}} as {{specialist_role}}"
      priority: high
      use_case: "{{specific_problem_solved}}"
      target_audience: "{{who_needs_this}}"

      differentiation:
        focus_domain: "{{narrow_expertise}}"
        frameworks_included: [{{which_frameworks}}]
        knowledge_scope: "{{narrower_than_generalista}}"

      adaptation_requirements:
        additional_sources: [{{if_any}}]
        specialized_frameworks: [{{if_any}}]
        context_tuning: "{{adjustments_needed}}"

      effort_estimate:
        time: "{{hours}}"
        complexity: {{low/medium/high}}

      value_proposition:
        differentiation: "{{why_valuable}}"
        market_fit: "{{demand_assessment}}"

      viability: {{high/medium/low}}

    [... repeat for all recommendations ...]

  not_recommended:
    - specialist: "{{name}}"
      reason: "{{why_not_viable}}"

  implementation_priority:
    1. {{specialist_name}} - {{rationale}}
    2. {{specialist_name}} - {{rationale}}
    [... etc ...]
```

### Mode: Full (Complete Synthesis)

**Execute complete synthesis pipeline:**

1. Extract frameworks
2. Build communication templates
3. Mine signature phrases
4. Synthesize contradictions for prompt integration
5. Chunk knowledge base
6. Generate specialist recommendations
7. Validate synthesis completeness
8. Present synthesis summary to user

**Synthesis Summary:**
```markdown
# SYNTHESIS PHASE COMPLETE

## Outputs Generated:

### Frameworks
- Total frameworks: {{count}}
- Categories: Decision ({{count}}), Problem-Solving ({{count}}), Communication ({{count}}), Domain-Specific ({{count}})
- File: minds/{mind}/artifacts/frameworks_synthesized.md

### Communication Templates
- Total templates: {{count}}
- Categories: Explanation ({{count}}), Argumentation ({{count}}), Storytelling ({{count}}), Response ({{count}})
- File: minds/{mind}/artifacts/communication_templates.md

### Signature Phrases
- High-frequency phrases: {{count}}
- Medium-frequency phrases: {{count}}
- Critical phrases for voice: [{{top_5}}]
- File: minds/{mind}/artifacts/signature_phrases.md

### Contradictions (Layer 8)
- Productive paradoxes synthesized: {{count}}
- Prompt-ready contradiction rules created
- File: minds/{mind}/artifacts/contradictions_synthesized.md

### Knowledge Base
- Total chunks: {{count}}
- Chunk size range: {{min}}-{{max}} tokens
- RAG-optimized: {{yes/no}}
- Files: minds/{mind}/kb/chunk_*.md

### Specialist Recommendations
- High-priority specialists: {{count}}
- Medium-priority specialists: {{count}}
- Total effort if all built: {{hours}} hours
- File: minds/{mind}/docs/logs/{timestamp}-specialist_recommendations.yaml

## Synthesis Quality Metrics:
- Framework completeness: {{percentage}}%
- Template coverage: {{percentage}}%
- Phrase density target: {{percentage}}%
- KB chunk coherence: {{percentage}}%

## Ready for Phase 5: Implementation (System Prompt Creation)

Proceed? (yes/no)
```

## Outputs

### Frameworks Mode Output
- `minds/{mind}/artifacts/frameworks_synthesized.md`

### Templates Mode Output
- `minds/{mind}/artifacts/communication_templates.md`

### Phrases Mode Output
- `minds/{mind}/artifacts/signature_phrases.md`

### Contradictions Mode Output
- `minds/{mind}/artifacts/contradictions_synthesized.md`

### KB Chunking Mode Outputs
- `minds/{mind}/kb/chunk_*.md` (multiple files)
- `minds/{mind}/kb/index.yaml`

### Specialist Recommender Output
- `minds/{mind}/docs/logs/{timestamp}-specialist_recommendations.yaml`

### Full Mode Outputs
All of the above outputs

## Validation Criteria

Synthesis compilation is successful when:

- [ ] **Frameworks extracted**: All reusable methodologies documented
- [ ] **Templates built**: Communication patterns structured
- [ ] **Phrases mined**: Signature voice elements cataloged (≥50 phrases)
- [ ] **Paradoxes synthesized**: Layer 8 contradictions prompt-ready
- [ ] **KB chunked**: Knowledge optimized for RAG (coherent chunks, proper metadata)
- [ ] **Specialists recommended**: Viable variants identified with effort estimates
- [ ] **Synthesis complete**: All artifacts ready for system prompt compilation
- [ ] **Quality validated**: Completeness and coherence checks passed

## Integration with AIOS

### Memory Layer
```typescript
memory.store({
  collection: 'mmos_synthesis',
  document: {
    mind_name: '{{mind}}',
    frameworks_count: {{count}},
    templates_count: {{count}},
    kb_chunks_count: {{count}},
    specialists_recommended: {{count}},
    synthesis_date: '{{timestamp}}'
  }
});
```

### Agent Coordination
- **@analyst**: Executes framework and phrase extraction
- **@dev**: Handles KB chunking optimization
- **@architect**: Synthesizes contradictions and templates

### Performance Estimates
- Frameworks: 1-1.5 hours, 100K tokens
- Templates: 0.5-1 hour, 50K tokens
- Phrases: 0.5-1 hour, 50K tokens
- Contradictions: 1 hour, 80K tokens
- KB Chunking: 1-2 hours, 100K tokens
- Specialist Recommender: 0.5-1 hour, 40K tokens
- **Total: 5-7 hours, 420K tokens**

## Notes

- **Synthesis bridges analysis and implementation**: Clean transformation of insights to actionable format
- **Chunk coherence critical for RAG**: Poor chunking = poor retrieval quality
- **Signature phrases are voice DNA**: Must be integrated consistently in prompts
- **Layer 8 synthesis is most important**: Paradox handling creates authenticity
- **Specialist recommendations save future work**: Identify now, build later if needed
- **Frameworks must be actionable**: Not just theory, but step-by-step application
- **Template variety matters**: Different situations need different communication patterns

---

**Task Version:** 3.0
**Last Updated:** 2025-10-06
