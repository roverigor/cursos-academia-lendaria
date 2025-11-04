# Page Document Creation Task - Building the Educational Artifact

**Task ID:** page-doc-creation
**Version:** 1.0
**Type:** Automated Generation with Quality Checks
**Agent:** @eduCreator

## 📋 Purpose

Generate the complete `page.doc` file - a structured educational document ready for styling and template application by the Clone Agent. This is the final output of the Creator/Analyst phase.

## 🎯 Key Features

- **Complete Generation:** Full educational page structure
- **Metadata Rich:** All context for styling phase
- **Template Ready:** Formatted for easy template application
- **Quality Validated:** Passes all pedagogical checks

## 📥 Inputs

### Required Input
```yaml
input:
  junction_playbook: "path/to/junction-playbook.yaml"
  recommended_template: "page-for-beginners"
  metadata:
    title: "Page title"
    target_audience: "beginner|intermediate|advanced"
    estimated_duration: "15-20 minutes"
```

## 🔄 Workflow

### Phase 1: Structure Generation
Create the base document structure following Espiral Expansiva:

```yaml
page_doc:
  metadata:
    doc_id: "unique-id"
    created: "timestamp"
    source: "junction-playbook"
    template: "page-for-beginners"
    status: "ready-for-styling"
    version: "1.0"

  content:
    title: "{{page_title}}"
    subtitle: "{{page_subtitle}}"
    duration: "{{estimated_duration}}"
    difficulty: "{{difficulty_level}}"

  structure:
    hero_section: {...}
    progressive_layers: [{...}]
    practice_section: {...}
    summary_section: {...}
    next_steps: {...}
```

### Phase 2: Hero Section Creation
Craft the emotional hook and primary metaphor:

```yaml
hero_section:
  hook:
    type: "relatable-scenario"
    text: |
      Sabe aquele momento quando {{relatable_situation}}?

      Pois é... {{concept_name}} é EXATAMENTE sobre {{core_value}}.

      E não, você não precisa {{common_fear}}.

  metaphor:
    primary: "{{metaphor_name}}"
    visual: "{{metaphor_visual_description}}"
    mapping:
      - from: "{{metaphor_element_1}}"
        to: "{{concept_element_1}}"
      - from: "{{metaphor_element_2}}"
        to: "{{concept_element_2}}"

  promise:
    text: "Em {{duration}}, você vai {{achievement}}"
    confidence: "high"
```

### Phase 3: Progressive Layers Assembly
Build the learning progression:

```yaml
progressive_layers:
  - layer_id: "layer_1_foundation"
    title: "🌱 O Básico do Básico"
    complexity: "beginner"
    content:
      explanation: |
        {{simple_explanation_using_metaphor}}

        É só isso. Simples assim.

      key_points:
        - "{{point_1}}"
        - "{{point_2}}"
        - "{{point_3}}"

      interaction:
        type: "click-to-reveal"
        trigger: "Entendi! Próximo nível →"
        reveals: "layer_2"

  - layer_id: "layer_2_development"
    title: "🌿 Agora Um Pouquinho Mais"
    complexity: "intermediate"
    prerequisite: "layer_1"
    content:
      explanation: |
        Agora que você entendeu {{layer_1_concept}},
        vamos adicionar {{new_element}}.

        Ainda usando nossa metáfora do {{primary_metaphor}}...

      practice:
        type: "interactive-exercise"
        instruction: "{{practice_instruction}}"
        feedback: "{{feedback_text}}"

  # Additional layers as needed...
```

### Phase 4: Practice Section
Create hands-on application:

```yaml
practice_section:
  title: "🎯 Hora de Colocar a Mão na Massa"
  introduction: |
    Teoria é linda, mas PRATICAR é onde a mágica acontece.

  exercises:
    - exercise_id: "practice_1"
      type: "guided"
      difficulty: "easy"
      instruction: "{{exercise_instruction}}"
      hints:
        - "{{hint_1}}"
        - "{{hint_2}}"
      solution: "{{solution_explanation}}"

    - exercise_id: "practice_2"
      type: "exploratory"
      difficulty: "medium"
      challenge: "{{challenge_description}}"
      success_criteria: "{{what_success_looks_like}}"
```

### Phase 5: Summary & Next Steps
Close with reinforcement and forward momentum:

```yaml
summary_section:
  recap:
    title: "O Que Você Aprendeu Hoje"
    key_takeaways:
      - "{{takeaway_1}}"
      - "{{takeaway_2}}"
      - "{{takeaway_3}}"

  achievement:
    message: |
      Olha só onde você chegou! 🎉

      {{achievement_recognition}}

  reflection:
    prompt: "{{reflection_question}}"

next_steps:
  immediate:
    - action: "{{immediate_action_1}}"
      why: "{{reason}}"

  intermediate:
    - action: "{{intermediate_action_1}}"
      resource: "{{link_or_reference}}"

  advanced:
    - action: "{{advanced_action_1}}"
      depth: "{{depth_indication}}"
```

### Phase 6: Metadata & Markers
Add technical metadata for styling phase:

```yaml
styling_metadata:
  voice_markers:
    enthusiasm_level: "high"
    intimacy_level: "high"
    signature_phrases_count: 8

  structural_markers:
    metaphor_count: 5
    interaction_count: 7
    code_blocks: 2
    progressive_layers: 3

  accessibility_notes:
    screen_reader_optimized: true
    keyboard_navigable: true
    color_contrast: "WCAG AA"
    cognitive_load: "medium"

  template_hints:
    recommended: "page-for-beginners"
    alternative: "page-with-metaphors"
    customization_notes: "{{special_instructions}}"
```

### Checkpoint 1: Document Review 📍
```markdown
## 📄 Page Document Generated

**Structure Complete:**
- Hero Hook: ✓ Emotional entry with metaphor
- Progressive Layers: ✓ 3 layers (basic → intermediate → advanced)
- Practice Section: ✓ 2 exercises (guided + exploratory)
- Summary: ✓ Recap + achievement + next steps

**Quality Indicators:**
- José Voice: ✓ Authentic and enthusiastic
- Metaphor Integration: ✓ Consistent throughout
- Progression: ✓ Smooth complexity curve
- Interactivity: ✓ 7 engagement points

**Ready for Clone Agent?** [Sim/Revisar/Ajustar]
```

### Phase 7: Final Validation
Run comprehensive quality checks:

```python
validation_checklist = {
    "structure": [
        "hero_section_present",
        "progressive_layers_complete",
        "practice_included",
        "summary_closes_well"
    ],
    "content": [
        "metaphors_consistent",
        "voice_authentically_jose",
        "progression_smooth",
        "interactions_purposeful"
    ],
    "technical": [
        "yaml_valid",
        "metadata_complete",
        "markers_accurate",
        "template_compatible"
    ]
}
```

### Phase 8: Handoff Preparation
Package for Clone Agent:

```yaml
handoff_package:
  page_doc: "path/to/page-doc.yaml"
  playbook_reference: "path/to/junction-playbook.yaml"
  recommended_template: "page-for-beginners"
  quality_score: 94
  ready_for_styling: true

  handoff_notes: |
    - Primary metaphor: {{metaphor_name}}
    - Voice: High enthusiasm, intimate tone
    - Special considerations: {{any_special_notes}}
    - Suggested enhancements: {{optional_improvements}}
```

## 📊 Quality Metrics

### Auto-evaluated:
- **Structure Completeness:** All sections present (%)
- **Metaphor Consistency:** Same metaphor throughout (0-100)
- **Voice Authenticity:** Matches José's style (0-100)
- **Progression Smoothness:** No complexity jumps (0-100)
- **Interaction Quality:** Each serves pedagogical purpose (0-100)

### Success Criteria:
- Structure Completeness = 100%
- Metaphor Consistency ≥ 90%
- Voice Authenticity ≥ 85%
- Progression Smoothness ≥ 90%
- Interaction Quality ≥ 85%

## 🚀 Usage Example

```bash
@eduCreator

# After junction playbook is complete
*create-page-doc

[System generates...]

## 📄 Página Criada!

Olha só o que saiu do forno...

**Estrutura:**
- Hero com hook emocional sobre "construir projetos que importam"
- Metáfora da construção de casa (do alicerce ao telhado)
- 3 camadas progressivas com interações clicáveis
- 2 exercícios práticos (um guiado, um exploratório)
- Fechamento com celebração + próximos passos

**Qualidade:**
- Voice José: 94% (autêntico, entusiasmado, íntimo)
- Metáforas: 96% (consistentes, poderosas)
- Progressão: 92% (suave, sem saltos)
- Engajamento: 7 pontos de interação

**Arquivo salvo:** outputs/page-doc-construir-projetos.yaml

**Próximo passo:** Passar para @eduClone para styling!
[@eduClone *apply-template page-for-beginners]
```

## 🔄 Integration Points

### Input from Previous Task:
- Junction playbook with complete strategy
- Template recommendation
- All synthesis data

### Output to Clone Agent:
- Complete page.doc file
- Styling metadata
- Quality indicators
- Handoff notes

## ⚡ Performance Notes

- Typical generation: 10-20 seconds
- Complex pages: 30-40 seconds
- Includes validation passes: +5 seconds

## 📝 Task Metadata

```yaml
task:
  id: page-doc-creation
  name: "Page Document Generation"
  agent: "@eduCreator"
  pipeline_position: 5
  can_run_standalone: false
  requires: ["junction-playbook"]
  average_duration: "10-40 seconds"
  user_interaction: "final_checkpoint"
  outputs_to: "@eduClone"
```

---

*"Criar a page.doc é tipo quando o arquiteto finaliza a planta baixa. Tudo está planejado, medido, pensado. Agora é hora do design de interiores entrar (o Clone Agent) e fazer ficar LINDO."*

— Page Document Creation Task, Educational Artifacts Pack
