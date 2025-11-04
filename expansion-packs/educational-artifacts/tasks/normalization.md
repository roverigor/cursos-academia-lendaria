# Normalization Task - ETL for Educational Content

**Task ID:** normalization
**Version:** 1.0
**Type:** Semi-Automatic with Strategic Checkpoints
**Agent:** @eduCreator

## 📋 Purpose

Transform raw educational content from multiple sources into a structured, normalized format ready for pedagogical processing. This is the ETL (Extract, Transform, Load) phase that José does "automatically without even realizing."

## 🎯 Key Features

- **Multi-formato Input:** Text, files, URLs, transcripts
- **Semi-Automatic Processing:** Flows smoothly with strategic pauses
- **Adaptive Error Handling:** Intelligent fallbacks with transparency
- **Pipeline Flexible:** Can run standalone or as part of flow

## 📥 Inputs

### Accepted Formats
```yaml
direct_text:
  - Plain text input
  - Markdown formatted text
  - Code snippets with explanations

files:
  - .txt (plain text)
  - .md (markdown)
  - .docx (Word documents)
  - .json (structured data)

urls:
  - Web pages (auto-converted to markdown)
  - YouTube videos (transcript extraction)
  - GitHub repos (README extraction)
  - Documentation sites

transcripts:
  - Meeting recordings (via transcription)
  - Video lessons (Portuguese/English)
  - Audio notes (mp3/wav/m4a)
```

### Input Parameters
- `source`: The content source (required)
- `format`: Auto-detected or manual override
- `language`: pt-BR, en-US (default: auto-detect)
- `context`: Additional context about the content (optional)

## 🔄 Workflow

### Phase 1: Content Extraction
```python
# Pseudo-flow
if input_type == "text":
    content = process_direct_text(input)
elif input_type == "file":
    content = extract_from_file(input)
elif input_type == "url":
    content = fetch_and_convert(input)
elif input_type == "transcript":
    content = process_transcript(input)

# Adaptive handling
if extraction_failed:
    alternatives = suggest_alternatives()
    user_choice = present_options(alternatives)
    content = retry_with_choice(user_choice)
```

### Phase 2: Structure Analysis
Automatically identifies:
- Main topics and subtopics
- Concept hierarchy
- Technical depth level
- Target audience indicators
- Learning objectives (implicit or explicit)
- Code examples and their purpose

### Phase 3: Content Normalization
```yaml
normalized_structure:
  metadata:
    source_type: "transcript"
    original_format: "video"
    detected_language: "pt-BR"
    complexity_level: "intermediate"
    estimated_duration: "15-20 min"

  content:
    title: "Extracted or generated title"
    summary: "2-3 sentence overview"

    concepts:
      - name: "Core concept 1"
        complexity: "basic"
        prerequisites: []
        metaphor_opportunity: true

    learning_path:
      - intro: "Hook opportunity here"
      - foundation: "Basic concepts"
      - development: "Main content"
      - practice: "Application examples"
      - expansion: "Advanced connections"

    code_blocks: []
    interaction_points: []
    key_terms: {}
```

### Checkpoint 1: Structure Review 📍
```markdown
## 📊 Estrutura Detectada

Identificamos a seguinte estrutura no conteúdo:

**Conceitos Principais:**
- [List detected concepts]

**Complexidade:** [Level]
**Público-alvo provável:** [Audience]

**Oportunidades detectadas:**
- ✨ 5 pontos para metáforas visuais
- 🔄 3 momentos para interação
- 📝 2 blocos de código para hands-on

**Parece correto?** [Sim/Ajustar/Refazer]
```

### Phase 4: Pedagogical Enhancement
Based on José's method:
- Mark natural breakpoints for progressive disclosure
- Identify complexity progression opportunities
- Flag abstract concepts needing metaphors
- Suggest interaction injection points
- Map to Espiral Expansiva structure

### Phase 5: Output Generation
Creates `normalized-content.yaml` with:
- Complete structured content
- Metadata for next phases
- Processing notes and adaptations
- Quality indicators

## 🔧 Adaptive Error Handling

### Smart Fallbacks
```python
error_strategies = {
    "encoding_error": [
        "try_utf8",
        "try_latin1",
        "extract_readable_parts",
        "ask_user_for_correction"
    ],
    "structure_unclear": [
        "apply_heuristics",
        "use_ai_analysis",
        "request_user_guidance"
    ],
    "language_mixed": [
        "separate_by_language",
        "translate_minority",
        "keep_code_universal"
    ]
}
```

### Transparency Protocol
When adaptations occur:
```markdown
## 🔄 Adaptações Realizadas

Durante a normalização, fizemos os seguintes ajustes:

1. **Codificação:** Detectado ISO-8859-1, convertido para UTF-8
2. **Estrutura:** Criada hierarquia baseada em headers implícitos
3. **Idioma:** Mantido code-switching PT/EN natural do José

Estas adaptações não afetam a qualidade do conteúdo final.
```

## 📊 Quality Metrics

### Auto-evaluated metrics:
- **Completeness:** % of content successfully extracted
- **Structure Quality:** Clarity of hierarchy (0-100)
- **Complexity Mapping:** Accuracy of level detection
- **Metaphor Opportunities:** Number identified
- **Processing Confidence:** Overall reliability score

### Success Criteria:
- Completeness ≥ 95%
- Structure Quality ≥ 80%
- At least 3 metaphor opportunities found
- Clear learning path identified

## 🚀 Usage Examples

### Example 1: YouTube Transcript
```bash
@eduCreator
*normalize https://youtube.com/watch?v=xyz

[System processes...]

## 📊 Estrutura Detectada
Vídeo: "APIs para Iniciantes - José Amorim"
Duração: 18:34
Conceitos: 5 principais, 12 secundários

**Parece correto?** [Sim]

[Continues processing...]

✅ Normalização completa!
Output salvo em: normalized-content-apis.yaml
Próximo: *ideate para design pedagógico
```

### Example 2: Mixed Content
```bash
*normalize "clipboard"

[System detects mixed format]

## 🤔 Conteúdo Misto Detectado

Encontramos:
- Texto explicativo (70%)
- Código Python (25%)
- Referências externas (5%)

Como prefere processar?
A) Integrar tudo como material único
B) Separar código em anexos
C) Expandir referências automaticamente

[User selects A]

[Continues with integrated processing...]
```

## 🔄 Integration Points

### Output to Ideation Task
```yaml
handoff_to_ideation:
  normalized_content: "path/to/normalized.yaml"
  processing_notes: "path/to/notes.md"
  confidence_score: 92
  ready_for_ideation: true

  suggested_focus:
    - "Strong metaphor potential in section 3"
    - "Consider interactive demo for API concept"
    - "Code examples need simplification"
```

### Standalone Mode
Can be used independently for:
- Content analysis
- Structure extraction
- Complexity assessment
- Transcript cleaning

## ⚡ Performance Notes

- Typical processing: 2-5 seconds for text
- File processing: Depends on size (usually < 10s)
- URL fetching: Network dependent (5-15s)
- Transcripts: May take longer (30-60s for audio)

## 🔒 Privacy & Security

- Local processing when possible
- No content stored without permission
- URL fetching respects robots.txt
- Sensitive content markers respected

## 📝 Task Metadata

```yaml
task:
  id: normalization
  name: "Content Normalization ETL"
  agent: "@eduCreator"
  pipeline_position: 1
  can_run_standalone: true
  average_duration: "10-30 seconds"
  user_interaction: "strategic_checkpoints"
  error_handling: "adaptive"
```

---

*"Olha só... normalização parece chato, né? Mas é tipo arrumar a cozinha antes de cozinhar. Se a mise en place tá bagunçada, o prato sai torto. Se o conteúdo não tá estruturado... o aprendizado empaca."*

— Normalization Task, Educational Artifacts Pack