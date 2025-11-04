# Validation & Template Application Task - Final Quality Gate

**Task ID:** validation-template
**Version:** 1.0
**Type:** Interactive Validation + Automated Application
**Agent:** @eduClone

## 📋 Purpose

Validate page.doc against José Amorim's quality standards and apply the selected template to generate the final production-ready educational artifact. This is the Clone Agent's primary workflow.

## 🎯 Key Features

- **Multi-Dimensional Validation:** Style, pedagogy, accessibility, technical
- **Template Application:** Transform page.doc into polished artifact
- **Quality Gates:** Must pass all checks before publishing
- **Enhancement Suggestions:** Proactive improvement recommendations

## 📥 Inputs

### Required Input
```yaml
input:
  page_doc: "path/to/page-doc.yaml"
  template_preference: "page-for-beginners|page-for-technicals|page-with-interactions|page-with-metaphors"
  validation_level: "standard|strict|comprehensive"
```

## 🔄 Workflow

### Phase 1: Style Validation (`*validate-style`)
Check compliance with José Amorim's method:

```yaml
style_validation:
  voice_check:
    enthusiasm: "present|absent"
    intimacy: "você vs usuário"
    signature_phrases: "count >= 3"
    parentheses_thoughts: "present"
    sentence_rhythm: "varied (short/long)"

  metaphor_check:
    primary_metaphor: "clearly_defined"
    consistency: "used_throughout"
    effectiveness: "makes_abstract_concrete"
    cultural_appropriateness: "validated"

  structure_check:
    espiral_expansiva: "followed"
    progressive_disclosure: "implemented"
    hook_effectiveness: "engaging"
    closure_strength: "reinforcing"

  results:
    score: 0-100
    passed: true|false
    issues: [{severity, description, location}]
    suggestions: [{improvement, rationale}]
```

**Validation Report Example:**
```markdown
## 🎨 Style Validation Results

**Score: 92/100** ✅ PASSOU

**Pontos Fortes:**
✓ Voice autêntica José (entusiasmo genuíno)
✓ Metáfora consistente (construção de casa)
✓ Espiral Expansiva bem aplicada
✓ 7 signature phrases encontradas

**Atenção:**
⚠️ Layer 2 tem salto de complexidade (linha 145)
⚠️ Fechamento poderia ter mais celebração

**Sugestões de Melhoria:**
1. Adicionar transição suave entre layers 1-2
2. Expandir achievement message no final
```

### Phase 2: Pedagogical Validation (`*validate-pedagogy`)
Assess learning effectiveness:

```yaml
pedagogy_validation:
  learning_objectives:
    clarity: "clear|unclear"
    achievability: "realistic|ambitious"
    measurability: "testable"

  knowledge_scaffolding:
    progression: "smooth|has_jumps"
    prerequisites: "identified"
    reinforcement: "sufficient"

  engagement_design:
    dopaminergic_hooks: "count >= 3"
    interactive_moments: "purposeful"
    curiosity_loops: "present"

  practice_quality:
    relevance: "directly_applicable"
    difficulty_curve: "appropriate"
    feedback: "constructive"

  results:
    score: 0-100
    passed: true|false
    issues: []
    recommendations: []
```

### Phase 3: Accessibility Validation (`*validate-accessibility`)
Ensure universal access:

```yaml
accessibility_validation:
  wcag_compliance:
    level: "A|AA|AAA"
    color_contrast: "ratio >= 4.5:1"
    text_size: "readable"
    alt_text: "present_for_images"

  navigation:
    keyboard: "fully_navigable"
    screen_reader: "optimized"
    focus_indicators: "visible"

  cognitive:
    cognitive_load: "low|medium|high"
    language_clarity: "plain_language"
    visual_hierarchy: "clear"

  responsive:
    mobile: "optimized"
    tablet: "optimized"
    desktop: "optimized"

  results:
    score: 0-100
    passed: true|false
    wcag_level: "AA"
    issues: []
```

### Checkpoint 1: Validation Summary 📍
```markdown
## ✅ Validação Completa

**Style:** 92/100 ✅ PASSOU
**Pedagogia:** 96/100 ✅ PASSOU
**Acessibilidade:** 94/100 (WCAG AA) ✅ PASSOU

**Status Geral:** APROVADO para template application

**Issues Encontradas:** 2 menores (não-bloqueantes)
**Melhorias Sugeridas:** 3 opcionais

**Aplicar template agora?** [Sim/Ver Detalhes/Ajustar Antes]
```

### Phase 4: Template Selection
If user didn't specify, recommend best template:

```python
def select_template(page_doc, metrics):
    audience = page_doc.metadata.target_audience
    metaphor_count = metrics.metaphor_count
    code_count = metrics.code_blocks
    interaction_count = metrics.interaction_count

    if audience == "beginner" and metaphor_count >= 5:
        return "page-for-beginners"
    elif code_count >= 3 and technical_depth == "high":
        return "page-for-technicals"
    elif interaction_count >= 7:
        return "page-with-interactions"
    elif metaphor_count >= 8:
        return "page-with-metaphors"
    else:
        return "page-for-beginners"  # safe default
```

### Phase 5: Template Application (`*apply-template`)
Transform page.doc using selected template:

```yaml
template_application:
  template: "page-for-beginners"
  input: "page-doc.yaml"

  processing:
    - load_template_structure
    - map_content_to_sections
    - apply_styling_rules
    - inject_interactions
    - generate_html_css_js
    - optimize_assets
    - validate_output

  output:
    format: "html|react|vue"
    files:
      - "index.html"
      - "styles.css"
      - "interactions.js"
      - "assets/"
```

### Phase 6: Enhancement Application (`*enhance`)
Apply suggested improvements:

```yaml
enhancements:
  automatic:
    - fix_minor_issues
    - optimize_performance
    - improve_accessibility
    - polish_voice

  suggested:
    - strengthen_metaphors: "optional"
    - add_interactions: "optional"
    - expand_examples: "optional"
    - enhance_visuals: "optional"
```

### Checkpoint 2: Final Preview 📍
```markdown
## 🎨 Artifact Final Gerado!

**Template Aplicado:** page-for-beginners
**Formato:** Interactive HTML

**Métricas Finais:**
- Performance: 98/100 (otimizado)
- Acessibilidade: WCAG AA compliant
- José Voice: 94/100 (autêntico)
- Engagement: 7 pontos interativos

**Arquivos Gerados:**
- ✓ index.html (12KB minified)
- ✓ styles.css (8KB minified)
- ✓ interactions.js (6KB minified)
- ✓ assets/ (imagens otimizadas)

**Visualizar agora?** [Sim/Salvar/Fazer Ajustes]
```

### Phase 7: Final Output
Generate production-ready artifact:

```yaml
final_output:
  artifact:
    path: "outputs/educational-artifacts/{{title-slug}}/"
    files:
      - index.html
      - styles.css
      - interactions.js
      - assets/
      - README.md

  metadata:
    created: "timestamp"
    template: "page-for-beginners"
    validation_scores:
      style: 92
      pedagogy: 96
      accessibility: 94

  deployment_ready: true

  documentation:
    usage: "How to deploy and customize"
    credits: "José Amorim methodology"
    license: "As specified"
```

## 📊 Quality Metrics

### Validation Scores:
- **Style:** Voice, metaphors, structure (0-100)
- **Pedagogy:** Learning effectiveness (0-100)
- **Accessibility:** WCAG compliance (0-100)
- **Technical:** Performance, compatibility (0-100)

### Success Criteria:
- All validation categories ≥ 80%
- No critical issues
- WCAG AA minimum
- Performance score ≥ 85%

## 🚀 Usage Example

```bash
@eduClone

# Receive page.doc from @eduCreator
*validate-style

[Validation runs...]

## 🎨 Validação Completa - APROVADO!

Seu conteúdo tá LINDO! 94/100

Encontrei 2 pequenos ajustes opcionais, mas nada bloqueante.
Pode aplicar o template tranquilamente.

*apply-template page-for-beginners

[Template application...]

## 🎨 Artifact Pronto!

Gerado página interativa com:
✓ Hero hook emocional
✓ 3 layers progressivos com reveals
✓ 2 exercícios práticos
✓ Celebração de conquista

**Preview:** [Opens in browser]

É EXATAMENTE isso! 🎉
```

## 🔄 Integration Points

### Input from Creator/Analyst:
- Complete page.doc file
- Styling metadata
- Template recommendation

### Output:
- Production-ready educational artifact
- Deployment package
- Usage documentation

## 📝 Task Metadata

```yaml
task:
  id: validation-template
  name: "Validation & Template Application"
  agent: "@eduClone"
  pipeline_position: 6
  can_run_standalone: false
  requires: ["page-doc"]
  average_duration: "20-60 seconds"
  user_interaction: "checkpoints"
  final_output: true
```

---

*"Validação não é sobre POLICIAR. É sobre GARANTIR que cada artefato seja digno do José. É sobre EXCELÊNCIA, não perfeição. É sobre fazer o aprendiz sentir que foi feito COM ALMA para ele."*

— Validation & Template Application Task, Educational Artifacts Pack
