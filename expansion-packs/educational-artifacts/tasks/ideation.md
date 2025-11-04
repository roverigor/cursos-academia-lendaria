# Ideation Task - Pedagogical Design Creation

**Task ID:** ideation
**Version:** 1.0
**Type:** Semi-Automatic with Creative Enhancement
**Agent:** @eduCreator

## 📋 Purpose

Transform normalized content into a complete pedagogical design following José Amorim's method. This is where raw information becomes a learning EXPERIENCE - com metáforas, ganchos emocionais, e aquela progressão que faz o cérebro pedir "mais!"

## 🎯 Key Features

- **Espiral Expansiva Design:** 5-layer learning structure
- **Metaphor Generation:** Visual-spatial connections
- **Dopaminergic Hooks:** Curiosity-driven engagement
- **2D Progression Mapping:** Spatial learning design
- **MAVE Framework Integration:** Full pedagogical architecture

## 📥 Inputs

### Primary Input
```yaml
normalized_content:
  source: "normalization_task_output.yaml"
  required_fields:
    - content_structure
    - complexity_mapping
    - concept_hierarchy
    - learning_objectives

context_parameters:
  audience: "beginners|intermediate|advanced|mixed"
  duration: "5min|15min|30min|full-course"
  style: "casual|balanced|technical"
  interactivity: "low|medium|high"
```

### Optional Enhancements
- Previous successful patterns
- Domain-specific requirements
- Cultural/regional adaptations
- Accessibility requirements

## 🔄 Workflow

### Phase 1: Learning Journey Mapping
```python
def create_learning_journey(content):
    journey = {
        "hook": generate_emotional_hook(content.main_concept),
        "stages": [
            {
                "name": "Descoberta",
                "complexity": "basic",
                "duration": "2-3 min",
                "metaphor": select_metaphor(concept)
            },
            {
                "name": "Exploração",
                "complexity": "intermediate",
                "duration": "5-7 min",
                "interactions": design_interactions()
            },
            {
                "name": "Domínio",
                "complexity": "advanced",
                "duration": "5-10 min",
                "practice": create_exercises()
            }
        ],
        "expansion": philosophical_connection()
    }
    return journey
```

### Phase 2: Metaphor Architecture
José's Metaphor System:
```yaml
metaphor_map:
  abstract_concept: "API REST"

  primary_metaphor:
    image: "Restaurante"
    mapping:
      - "Cliente → Aplicação"
      - "Garçom → API"
      - "Cozinha → Backend"
      - "Menu → Endpoints"
      - "Pedido → Request"
      - "Prato → Response"

  progressive_reveal:
    layer_1: "Cliente faz pedido"
    layer_2: "Garçom anota e leva para cozinha"
    layer_3: "Cozinha prepara segundo receita"
    layer_4: "Garçom traz prato pronto"
    layer_5: "Cliente satisfeito = Request bem-sucedida"

  transition_to_technical:
    bridge: "Agora que você entendeu o restaurante..."
    technical: "GET /pedidos → SELECT * FROM orders"
```

### Checkpoint 2: Design Review 📍
```markdown
## 🎨 Design Pedagógico Criado

**Jornada de Aprendizagem:**
[Visual representation of journey]

**Metáfora Principal:** [Selected metaphor]
**Ganchos Dopaminérgicos:** [List of hooks]
**Pontos de Interação:** [Interactive moments]

**Progressão Espacial:**
```
Fácil          →          Difícil
┌─────────┬─────────┬─────────┐
│ Gancho  │ Metáfora│ Conceito│ ↓
├─────────┼─────────┼─────────┤
│ Prática │ Desafio │ Projeto │ ↓
└─────────┴─────────┴─────────┘
        Complexidade
```

**Aprovar design?** [Sim/Ajustar/Redesenhar]
```

### Phase 3: Espiral Expansiva Implementation

```yaml
espiral_structure:
  1_gancho_emocional:
    opening: "Você já se sentiu perdido tentando entender [conceito]?"
    connection: "Não é sua culpa. É que ninguém te mostrou ASSIM..."
    promise: "Em 15 minutos, você vai dominar isso."

  2_metafora_visual:
    setup: "Imagine que [conceito] é como [metáfora]..."
    development: "[Detailed metaphor exploration]"
    anchoring: "Cada vez que você ver [conceito], lembre do [metáfora]"

  3_fundamento_conceitual:
    transition: "Agora que a imagem tá clara na sua cabeça..."
    science: "[Technical explanation with rigor]"
    validation: "É exatamente assim que [experts] fazem"

  4_aplicacao_pratica:
    challenge: "Vamos colocar a mão na massa?"
    steps: "[Actionable tutorial]"
    success_marker: "Se você chegou aqui, você ENTENDEU"

  5_expansao_filosofica:
    zoom_out: "Mas isso é só o começo..."
    connection: "[Link to bigger picture]"
    inspiration: "Imagine o que você pode construir agora..."
```

### Phase 4: Interaction Design
```python
interaction_patterns = {
    "click_to_reveal": {
        "use_when": "Progressive complexity",
        "example": "Click to see what happens next..."
    },
    "toggle_complexity": {
        "use_when": "Mixed audience",
        "example": "🔄 Modo Técnico | Modo Iniciante"
    },
    "live_experiment": {
        "use_when": "Concept needs experience",
        "example": "Mude os valores e veja o resultado"
    },
    "quiz_checkpoint": {
        "use_when": "Validate understanding",
        "example": "Antes de continuar: o que acontece se...?"
    }
}
```

### Phase 5: Scaffolding Architecture
```yaml
knowledge_scaffolding:
  prerequisites:
    assumed: ["basic computer usage"]
    taught_inline: ["technical terms"]
    referenced: ["advanced concepts"]

  complexity_ramp:
    minute_0_5: "Comfort zone - familiar territory"
    minute_5_10: "Stretch zone - guided challenge"
    minute_10_15: "Growth zone - supported autonomy"
    minute_15_plus: "Mastery zone - independent exploration"

  support_structures:
    - visual_aids: "Diagrams at complexity jumps"
    - checkpoints: "Understanding validation"
    - escape_hatches: "Skip to summary options"
    - help_bubbles: "Just-in-time explanations"
```

## 🔧 Adaptive Design Intelligence

### Audience Adaptation
```python
def adapt_to_audience(design, audience_profile):
    if audience_profile == "beginners":
        design.metaphor_density *= 1.5
        design.technical_depth *= 0.7
        design.repetition += 2
    elif audience_profile == "technical":
        design.code_examples *= 2
        design.metaphor_density *= 0.8
        design.depth_layers += 2

    return design
```

### Error Recovery
If ideation gets stuck:
```markdown
## 🤔 Ajuda Necessária

Não consegui criar uma metáfora efetiva para [conceito].

**Opções:**
A) Sugerir sua própria metáfora
B) Usar explicação direta (sem metáfora)
C) Deixar eu tentar outra abordagem
D) Buscar referências do José

[User choice] → [Adaptive continuation]
```

## 📊 Quality Metrics

### Design Quality Indicators
- **Metaphor Effectiveness:** How well it maps (0-100)
- **Engagement Potential:** Dopaminergic hooks density
- **Progression Clarity:** Learning path coherence
- **Interaction Value:** Learning-by-doing quotient
- **José Alignment:** Method fidelity score

### Success Criteria
- Every concept has a metaphor (100%)
- At least 1 hook per 5 minutes
- Clear 2D progression mapped
- 3+ interaction points
- Espiral Expansiva complete

## 🚀 Usage Examples

### Example 1: Technical Concept
```bash
@eduCreator
*ideate --audience beginners --style casual

[Loads normalized content about Docker...]

## 🎨 Design Pedagógico Criado

**Metáfora Principal:** 🚢 Porto de Containers
- Docker = Porto
- Containers = Containers de navio mesmo!
- Images = Blueprints do container
- Docker Hub = Catálogo de blueprints

**Jornada:**
1. "Você já mudou de casa?" (gancho)
2. Container maritime explanation (metáfora)
3. Technical mapping (fundamento)
4. Build your first container (prática)
5. "Você acabou de entender DevOps" (expansão)

**Aprovar design?** [Sim]

✅ Design pedagógico pronto!
Próximo: *references para enriquecer
```

### Example 2: Soft Skill Content
```bash
*ideate --audience mixed --interactivity high

[Processing leadership content...]

## 🎨 Design Criado

**Abordagem:** Experiencial-Reflexiva

**Ganchos Interativos:**
1. Quiz: "Que tipo de líder você é?"
2. Simulação: "Decisão difícil em 60 segundos"
3. Reflexão: "Seu momento de liderança"

**Metáfora:** Maestro de Orquestra
(Cada músico = membro do time...)

[Continues...]
```

## 🔄 Integration Points

### Output Format
```yaml
ideation_output:
  design_document: "ideation-output.yaml"

  structure:
    learning_journey: {}
    metaphor_architecture: {}
    espiral_expansiva: {}
    interaction_points: []
    scaffolding_plan: {}

  metadata:
    estimated_duration: "15-20 min"
    interaction_count: 5
    complexity_levels: 3
    josé_alignment: 94

  handoff:
    ready_for_references: true
    suggested_enhancements: []
```

### Pipeline Integration
- Receives from: `normalization` task
- Sends to: `internal-references` task
- Can iterate with: `enhancement` loops

## ⚡ Creative Algorithms

### Metaphor Generator
```python
def generate_metaphor(concept):
    # José's preferred domains
    domains = [
        "cotidiano_domestico",  # Kitchen, house
        "tecnologia_familiar",  # Phones, computers
        "transporte",          # Cars, ships, planes
        "natureza",           # Trees, rivers
        "jogos"               # Games, sports
    ]

    # Find structural similarity
    similarity = analyze_structure(concept)

    # Generate 3-5 options
    return metaphor_options
```

## 📝 Task Metadata

```yaml
task:
  id: ideation
  name: "Pedagogical Design Creation"
  agent: "@eduCreator"
  pipeline_position: 2
  can_run_standalone: true
  requires: ["normalized_content"]
  average_duration: "30-60 seconds"
  user_interaction: "creative_checkpoints"
  error_handling: "adaptive_creative"
```

---

*"Sabe qual a diferença entre informação e transformação? A informação entra por um ouvido e sai pelo outro. A transformação... ela REESTRUTURA seus neurônios. E é isso que a gente tá fazendo aqui."*

— Ideation Task, Educational Artifacts Pack