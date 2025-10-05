# OUTPUTS_GUIDE.md - Sistema Completo de Outputs por Etapa

## Visão Geral
Fluxo completo orientado por metadados (`prompts.yaml`), estruturado nas fases: Viability → Research → Analysis → Synthesis → Implementation → Testing.

## Estrutura de Destino
- `sources/` — Biblioteca semântica (fontes primárias)
- `artifacts/` — Artefatos intermediários (FLAT)
- `docs/` — Documentação e logs (`docs/logs/`)
- `kb/` — Knowledge base final (FLAT)
- `system_prompts/` — System prompts versionados
- `specialists/` — Especialistas opcionais

## Viability

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`viability_scorecard_apex.md`|`{timestamp}-viability.yaml`|minds/{mind}/docs/logs/{timestamp}-viability.yaml|#1|
|`viability_icp_match_score.md`|`{timestamp}-icp_match.yaml`|minds/{mind}/docs/logs/{timestamp}-icp_match.yaml|#2|
|`viability_prd_generator.md`|`PRD.md`|minds/{mind}/docs/PRD.md|#3|
|`viability_dependencies_mapper.md`|`dependencies.yaml`|minds/{mind}/metadata/dependencies.yaml|#3|
|`viability_todo_initializer.md`|`TODO.md`|minds/{mind}/docs/TODO.md|#4|

## Research

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`research_source_discovery.md`|`sources`|minds/{mind}/sources/|#1|
|`research_source_collector.md`|`sources`|minds/{mind}/sources/|#2|
|`research_temporal_mapper.md`|`temporal_context.yaml`|minds/{mind}/metadata/temporal_context.yaml|#3|
|`research_priority_calculator.md`|`priority_matrix.yaml`|minds/{mind}/sources/priority_matrix.yaml|#3|
|`research_sources_master.md`|`sources_master.yaml`|minds/{mind}/sources/sources_master.yaml|#4|
|`research_etl_q_a.md`|`qa_dataset_{topic}.jsonl`|minds/{mind}/kb/qa_dataset_{topic}.jsonl|#5|

## Analysis

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`analysis_source_reading.md`|`{timestamp}-key_insights.md`|minds/{mind}/docs/logs/{timestamp}-key_insights.md|#1|
|`analysis_quote_extraction.md`|`quotes_database.yaml`|minds/{mind}/artifacts/quotes_database.yaml|#1|
|`analysis_timeline_mapping.md`|`life_timeline.yaml`|minds/{mind}/artifacts/life_timeline.yaml|#1|
|`analysis_rotine.md`|`routine_analysis.md`|minds/{mind}/artifacts/routine_analysis.md|#2|
|`analysis_recognition_patterns.md`|`recognition_patterns.yaml`|minds/{mind}/artifacts/recognition_patterns.yaml|#2|
|`analysis_linguistic_forensics.md`|`writing_style.md`|minds/{mind}/artifacts/writing_style.md|#2|
|`analysis_behavioral_patterns.md`|`behavioral_patterns.md`|minds/{mind}/artifacts/behavioral_patterns.md|#2|
|`analysis_mental_models.md`|`mental_models.md`|minds/{mind}/artifacts/mental_models.md|#3|
|`analysis_values_hierarchy.md`|`values_hierarchy.yaml`|minds/{mind}/artifacts/values_hierarchy.yaml|#3|
|`analysis_belief_system.md`|`beliefs_core.yaml`|minds/{mind}/artifacts/beliefs_core.yaml|#3|
|`analysis_decision_architecture.md`|`decision_patterns.yaml`|minds/{mind}/artifacts/decision_patterns.yaml|#3|
|`analysis_immune_system.md`|`immune_system.md`|minds/{mind}/artifacts/immune_system.md|#3|
|`analysis_core_obsessions.md`|`core_obsessions.yaml`|minds/{mind}/artifacts/core_obsessions.yaml|#4|
|`analysis_unique_algorithm.md`|`unique_algorithm.yaml`|minds/{mind}/artifacts/unique_algorithm.yaml|#5|
|`analysis_contradictions_map.md`|`contradictions.yaml`|minds/{mind}/artifacts/contradictions.yaml|#5|
|`analysis_cognitive_architecture.md`|`cognitive_architecture.yaml`|minds/{mind}/artifacts/cognitive_architecture.yaml|#6|
|`analysis_psychometric_analysis.md`|`personality_profile.json`|minds/{mind}/artifacts/personality_profile.json|#6|
|`analysis_limitations_doc.md`|`LIMITATIONS.md`|minds/{mind}/docs/LIMITATIONS.md|#6|

## Synthesis

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`synthesis_template_extractor.md`|`communication_templates.md`|minds/{mind}/artifacts/communication_templates.md|#1|
|`synthesis_phrases_miner.md`|`signature_phrases.md`|minds/{mind}/artifacts/signature_phrases.md|#1|
|`synthesis_frameworks_identifier.md`|`frameworks_synthesized.md`|minds/{mind}/artifacts/frameworks_synthesized.md|#1|
|`synthesis_extract_core.md`|`core_elements.yaml`|minds/{mind}/artifacts/core_elements.yaml|#1|
|`synthesis_contradictions.md`|`contradictions_synthesized.md`|minds/{mind}/artifacts/contradictions_synthesized.md|#1|
|`synthesis_kb_chunker.md`|`chunk_{index}.md`|minds/{mind}/kb/chunk_{index}.md|#2|
|`synthesis_specialist_recommender.md`|`{timestamp}-specialist_recommendations.yaml`|minds/{mind}/docs/logs/{timestamp}-specialist_recommendations.yaml|#3|

## Implementation

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`implementation_extract_patterns.md`|`patterns_synthesized.md`|minds/{mind}/artifacts/patterns_synthesized.md|#1|
|`implementation_extract_core.md`|`identity_core.yaml`|minds/{mind}/artifacts/identity_core.yaml|#1|
|`implementation_identity_core.md`|`identity_core.yaml`|minds/{mind}/artifacts/identity_core.yaml|#2|
|`implementation_meta_axioms.md`|`meta_axioms.yaml`|minds/{mind}/artifacts/meta_axioms.yaml|#2|
|`implementation_instructions_core.md`|`instructions_core.yaml`|minds/{mind}/artifacts/instructions_core.yaml|#2|
|`implementation_generalista_compiler.md`|`{timestamp}-v{version}-generalista.md`|minds/{mind}/system_prompts/{timestamp}-v{version}-generalista.md|#3|
|`implementation_specialist_creator.md`|`{timestamp}-v{version}.md`|minds/{mind}/specialists/{specialist}/system_prompts/{timestamp}-v{version}.md|#4|
|`implementation_operational_manual.md`|`operational_manual.md`|minds/{mind}/docs/operational_manual.md|#5|
|`implementation_testing_protocol.md`|`testing_protocol.md`|minds/{mind}/docs/testing_protocol.md|#5|
|`implementation_neural_flow_techniques.md`|`neural_flow_techniques.md`|minds/{mind}/artifacts/neural_flow_techniques.md|#5|

## Testing

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`testing_personality_validator.md`|`{timestamp}-personality_validation.md`|minds/{mind}/docs/logs/{timestamp}-personality_validation.md||
|`testing_test_generator.md`|`{timestamp}-test_cases.yaml`|minds/{mind}/docs/logs/{timestamp}-test_cases.yaml|#1|
