# Junction Playbook Task - Connecting the Pedagogical Dots

**Task ID:** junction-playbook
**Version:** 1.0
**Type:** Semi-Automatic Synthesis
**Agent:** @eduCreator

## 📋 Purpose

Create the "junction" document that synthesizes all previous phases (normalization, ideation, references) into a unified playbook for page creation. This is where disparate pieces come together into a cohesive pedagogical strategy.

## 🎯 Key Features

- **Synthesis Master:** Combines insights from all previous phases
- **Strategic Planning:** Maps complete learning journey
- **Template Selector:** Recommends best template for content
- **Quality Checkpoint:** Final validation before page creation

## 📥 Inputs

### Required Inputs
```yaml
inputs:
  normalized_content: "path/to/normalized-content.yaml"
  ideation_output: "path/to/ideation-design.yaml"
  internal_references: "path/to/references.yaml"
  user_preferences:
    target_audience: "beginner|intermediate|advanced"
    style_preference: "casual|technical|hybrid"
    interaction_level: "high|medium|low"
```

## 🔄 Workflow

### Phase 1: Content Synthesis
Analyze and integrate all previous outputs:
- Learning objectives from normalization
- Pedagogical design from ideation
- Pattern matches from internal references
- Identify any gaps or contradictions

### Phase 2: Learning Journey Mapping
```yaml
learning_journey:
  entry_point:
    hook: "Emotional/relatable entry"
    metaphor: "Core visual metaphor"
    promise: "What learner will achieve"

  progression:
    layer_1:
      complexity: "basic"
      concepts: []
      interactions: []
      validation: "knowledge check"

    layer_2:
      complexity: "intermediate"
      concepts: []
      interactions: []
      validation: "practice exercise"

    layer_3:
      complexity: "advanced"
      concepts: []
      interactions: []
      validation: "real-world application"

  closure:
    summary: "Key takeaways"
    next_steps: "Where to go from here"
    celebration: "Achievement recognition"
```

### Phase 3: Metaphor Integration Plan
Document how metaphors will be used:
- **Primary Metaphor:** The main visual/conceptual anchor
- **Supporting Metaphors:** For complex sub-concepts
- **Metaphor Transitions:** How to move between metaphors
- **Validation:** Ensure metaphors are culturally appropriate

### Phase 4: Interaction Design
Plan all interactive elements:
```yaml
interactions:
  - type: "click-to-reveal"
    location: "layer_1_concept_2"
    purpose: "Progressive disclosure"
    content: "Hidden depth explanation"

  - type: "drag-drop"
    location: "layer_2_practice"
    purpose: "Active learning"
    content: "Match concepts to examples"

  - type: "code-playground"
    location: "layer_3_application"
    purpose: "Hands-on practice"
    content: "Live code editor with examples"
```

### Checkpoint 1: Synthesis Review 📍
```markdown
## 🔗 Junction Synthesis Complete

**Learning Journey:**
- Entry: [Hook description]
- Progression: [3-5 layers mapped]
- Closure: [Exit strategy defined]

**Key Elements:**
- Primary Metaphor: [Name and description]
- Interactive Moments: [Count and types]
- Complexity Arc: [Smooth/needs adjustment]

**Recommended Template:** [page-for-beginners|page-for-technicals|etc]

**Ready to proceed?** [Sim/Ajustar/Refazer]
```

### Phase 5: Template Recommendation
Based on synthesis, recommend best template:

**Decision Matrix:**
```python
if audience == "beginner" and metaphors >= 5:
    recommend = "page-for-beginners"
elif technical_depth == "high" and code_blocks >= 3:
    recommend = "page-for-technicals"
elif interactions >= 7:
    recommend = "page-with-interactions"
elif metaphors >= 8 and visual_elements == "primary":
    recommend = "page-with-metaphors"
else:
    recommend = "page-for-beginners"  # safe default
```

### Phase 6: Playbook Assembly
Create complete playbook document:

```yaml
playbook:
  metadata:
    created: "timestamp"
    source_phases: ["normalization", "ideation", "references"]
    confidence_score: 95
    template_recommendation: "page-for-beginners"

  strategic_plan:
    learning_journey: {...}
    metaphor_plan: {...}
    interaction_plan: {...}
    accessibility_notes: {...}

  content_blocks:
    hero_hook:
      text: "Prepared hook text"
      metaphor: "Primary metaphor introduction"

    progressive_layers:
      - layer_1: {...}
      - layer_2: {...}
      - layer_3: {...}

    closure:
      summary: "Key points recap"
      celebration: "Achievement message"

  quality_indicators:
    metaphor_coverage: "excellent"
    progression_smoothness: "good"
    engagement_potential: "high"
    accessibility_score: "WCAG AA"
```

### Phase 7: Quality Validation
Run through checklist:
- [ ] All concepts have metaphors
- [ ] Progression is smooth (no jumps)
- [ ] Interactive elements are purposeful
- [ ] Voice matches José's style
- [ ] Accessibility considered
- [ ] Template selection justified

## 📊 Quality Metrics

### Auto-evaluated:
- **Synthesis Completeness:** All phases integrated (%)
- **Journey Coherence:** Logical flow score (0-100)
- **Metaphor Integration:** Effectiveness rating
- **Interaction Purposefulness:** Each interaction has pedagogical goal
- **Template Match:** Confidence in recommendation (%)

### Success Criteria:
- Synthesis Completeness ≥ 90%
- Journey Coherence ≥ 85%
- All interactions have clear purpose
- Template recommendation confidence ≥ 80%

## 🚀 Usage Example

```bash
@eduCreator

# After completing normalization, ideation, and references
*junction-playbook

[System synthesizes...]

## 🔗 Junction Synthesis

Integrei o conteúdo das 3 fases anteriores.

**Descobri algo LINDO:**
Seu conteúdo tem uma progressão NATURAL do "porquê" para o "como".
Perfeito para Espiral Expansiva!

**Planejamento:**
1. Hook: "Sabe quando você precisa X mas não sabe por onde começar?"
2. Metáfora Principal: Construir casa (fundação → estrutura → acabamento)
3. 5 Layers progressivos com interações
4. Fechamento: Aplicação real + próximos passos

**Template Recomendado:** page-for-beginners
(Alto potencial de metaphora + público iniciante)

**Confiança:** 92%

**Pronto para criar a página?** [*create-page-doc]
```

## 🔄 Integration Points

### Input from Previous Tasks:
- Normalized content structure
- Ideation design patterns
- Internal reference matches

### Output to Next Task:
```yaml
handoff_to_page_creation:
  playbook: "path/to/junction-playbook.yaml"
  template: "page-for-beginners"
  confidence: 92
  ready_for_generation: true
```

## 📝 Task Metadata

```yaml
task:
  id: junction-playbook
  name: "Junction Playbook Synthesis"
  agent: "@eduCreator"
  pipeline_position: 4
  can_run_standalone: false
  requires: ["normalization", "ideation", "internal-references"]
  average_duration: "15-30 seconds"
  user_interaction: "strategic_checkpoint"
  outputs_to: "page-doc-creation"
```

---

*"O playbook é tipo aquele momento antes de começar a cozinhar quando você olha todos os ingredientes preparados, lê a receita completa, e SABE que vai dar certo. É sobre CONFIANÇA antes de executar."*

— Junction Playbook Task, Educational Artifacts Pack
