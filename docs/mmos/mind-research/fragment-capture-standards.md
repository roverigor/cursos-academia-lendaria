# Fragment Capture Standards v1.0

## Contexto
- Conversa consolidada em 2025-10-26 sobre simplificação da captura de fragmentos para o expansion-pack InnerLens.
- Objetivo: garantir consistência na ingestão de evidências para clones cognitivos, mantendo compatibilidade com o pipeline MMOS v5.0.

## Resumo das Decisões
- **Template único** em JSON/YAML com campos obrigatórios mínimos e espaço para metadados do corpus.
- **Prompt avançado** (“Fragment Hunter”) para uso em projetos Claude/LLM com workflow, critérios de qualidade e formato de saída.
- **Taxonomia padronizada em inglês**, cobrindo módulos, categorias, tags, tipos e scoring.
- **Categoria** permanece recomendada (não obrigatória) desde que siga lista controlada.
- **Tags** devem usar snake_case combinando tema e módulo (ex.: `family_origin_m1`).

## Template Canonical

```json
{
  "target_individual": {
    "name": "",
    "current_role": "",
    "domains": [],
    "primary_context": "",
    "geographic_origin": ""
  },
  "corpus_metadata": {
    "total_sources": 0,
    "source_breakdown": {
      "interviews": 0,
      "talks": 0,
      "articles": 0,
      "books": 0,
      "others": 0
    },
    "total_content_volume": {
      "text_words": 0,
      "audio_minutes": 0
    },
    "interviewer": "",
    "collection_window": "",
    "coverage_topics": []
  },
  "sources": [
    {
      "id": "SRC_001",
      "type": "interview",
      "title": "",
      "url_or_path": "",
      "date": "",
      "language": "",
      "notes": ""
    }
  ],
  "fragments": [
    {
      "id": "FRAG_001",
      "module": "M1",
      "category": "",
      "source_id": "SRC_001",
      "location": "",
      "type": "direct_quote",
      "relevance": 10,
      "confidence": 0.95,
      "content": "",
      "context": "",
      "insight": "",
      "tags": [],
      "researcher_notes": ""
    }
  ]
}
```

> Versão YAML equivalente é permitida; valores devem respeitar a taxonomia abaixo.

## Prompt "Fragment Hunter" (síntese)
- Persona investigativa, orientada a evidências.
- Workflow em quatro fases: planejamento → coleta → controle de qualidade → output.
- Uso obrigatório dos módulos e categorias controladas.
- Produz fragmentos em blocos, com status periódico e indicação de gaps.
- Aceita comandos naturais (ex.: "continue", "status", "deep research").
- Só gera artefatos completos quando solicitado explicitamente.

## Taxonomia Padronizada

### Modules
- `M1 Life Story`
- `M2 Thinking Systems`
- `M3 Domain & Expertise`
- `M4 Communication & Style`
- `M5 Values & Principles`

### Categories por Módulo
- **M1**: `family_origin`, `geographic_trajectory`, `education_path`, `early_work`, `support_network`, `socioeconomic_context`, `formative_events`
- **M2**: `core_philosophy`, `decision_process`, `heuristics`, `problem_solving`, `learning_evolution`, `mental_models`
- **M3**: `expertise_definition`, `working_methodology`, `key_contributions`, `field_controversies`, `failures_lessons`, `knowledge_boundaries`
- **M4**: `communication_style`, `vocabulary_signature`, `teaching_mode`, `argumentation_structure`, `humor_persona`, `signature_analogies`
- **M5**: `core_values`, `ethical_framework`, `purpose_mission`, `legacy_vision`, `tradeoffs`, `societal_view`

### Tags
- Formato: `tema_modulo` usando snake_case (ex.: `family_origin_m1`).
- Especificidade adicional via sufixos permitida (`decision_process_m2_subconscious`).
- Manter glossário sincronizado com futuras revisões neste documento.

### Fragment Types
- `direct_quote`
- `paraphrase`
- `example`
- `pattern`
- `description`

### Scoring
- `relevance` (1–10): 10 = crítico para caracterização da persona.
- `confidence` (0.0–1.0): ≥0.85 alta, 0.70–0.84 média, <0.70 baixa; explicar incertezas em `researcher_notes`.

## Guidelines Complementares
- **Categoria opcional**: recomendada para facilitar filtros; caso ausente, garantir tags suficientes.
- **Contexto vs. Insight**: `context` descreve situação factual; `insight` explica relevância para o clone.
- **Validação**: registrar contradições e lacunas em `researcher_notes` com prefixo `TODO:` quando exigirem follow-up.
- **Extensões**: novas categorias/tags/tipos só podem ser adicionados via revisão formal registrada aqui.

## Próximos Passos
- Integrar este padrão no prompt "Fragment Hunter" atual.
- Criar checklist ou validador para garantir conformidade antes da ingestão no MMOS.
- Registrar revisões futuras neste arquivo (seção changelog).

---
_Documento preparado por Winston (Architect persona) em 2025-10-26._

