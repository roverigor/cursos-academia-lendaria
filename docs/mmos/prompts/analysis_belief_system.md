# BELIEF SYSTEM

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: @{mind}/sources/, @{mind}/artifacts/quotes_database.yaml, @{mind}/artifacts/values_hierarchy.yaml, @{mind}/artifacts/life_timeline.yaml
- Output: @{mind}/artifacts/beliefs_core.yaml
- Dependências: 01_quote_extraction.md, 03_values_hierarchy.md, 01_timeline_mapping.md

## OBJETIVO PRINCIPAL

Mapear o sistema completo de crenças de [NOME_SUJEITO] - desde convicções fundamentais sobre realidade, natureza humana e significado, até crenças operacionais sobre trabalho, sucesso e relacionamentos - identificando estrutura hierárquica, interdependências, contradições e evolução temporal.

## INPUT NECESSÁRIO

```yaml
required_inputs:
  - @{mind}/sources/ (todos os materiais coletados)
  - @{mind}/artifacts/quotes_database.yaml (citações sobre crenças e visões de mundo)
  - @{mind}/artifacts/values_hierarchy.yaml (valores para contextualização)
  - @{mind}/artifacts/life_timeline.yaml (evolução temporal de crenças)
```

## METODOLOGIA

### FASE 1: EXTRAÇÃO DE CRENÇAS
Identificar todas as crenças declaradas ou demonstradas através de comportamento e decisões.

### FASE 2: HIERARQUIZAÇÃO
Organizar crenças em níveis (meta-crenças  crenças core  crenças operacionais  crenças situacionais).

### FASE 3: MAPEAMENTO DE INTERDEPENDÊNCIAS
Identificar como crenças se sustentam, reforçam ou contradizem mutuamente.

### FASE 4: ANÁLISE EVOLUTIVA
Rastrear como crenças emergiram, evoluíram ou foram abandonadas.

### FASE 5: TESTE DE CONSISTÊNCIA
Identificar contradições, dissonâncias e mecanismos de reconciliação.

## OUTPUT ESTRUTURADO

```yaml
belief_system_metadata:
  subject: "[NOME COMPLETO]"
  analysis_date: "YYYY-MM-DD"
  beliefs_cataloged: "[N crenças identificadas]"
  temporal_range: "[YYYY-YYYY]"
  confidence_level: "[0.0-1.0]"
  worldview_classification: "[Classificação geral da visão de mundo]"

meta_beliefs:
  epistemological:
    - belief_id: "META_EPI_001"
      belief_statement: "[Crença sobre conhecimento/verdade]"
      category: "Epistemológica"

      manifestation:
        explicit_statements: ["[Statement 1]", "[Statement 2]"]
        implicit_behaviors: ["[Comportamento 1]", "[Comportamento 2]"]
        decision_impacts: ["[Como afeta decisões]"]

      evidence:
        quotes: ["[ID quote do database]"]
        actions_consistent: ["[Ação que demonstra]"]
        sources: ["[Fonte 1]", "[Fonte 2]"]

      stability: "[Muito estável/Estável/Moderada/Variável]"
      centrality: "[0.0-1.0 - quão central é para identity]"
      confidence_level: "[0.0-1.0]"

  ontological:
    - belief_id: "META_ONT_001"
      belief_statement: "[Crença sobre natureza da realidade]"
      category: "Ontológica"
      # [Mesma estrutura acima]

  axiological:
    - belief_id: "META_AXI_001"
      belief_statement: "[Crença sobre natureza do valor/bem/mal]"
      category: "Axiológica"
      # [Mesma estrutura acima]

core_beliefs:
  human_nature:
    - belief_id: "CORE_HN_001"
      belief_statement: "[Crença sobre natureza humana]"

      elaboration:
        core_assumption: "[Assunção fundamental]"
        implications: ["[Implicação 1]", "[Implicação 2]"]
        boundaries: "[Limites/exceções reconhecidos]"

      formation:
        origin_period: "[Quando formou]"
        formative_experiences: ["[Experiência 1]", "[Experiência 2]"]
        influences: ["[Influência 1]", "[Influência 2]"]

      manifestation:
        behavioral_evidence: ["[Comportamento 1]", "[Comportamento 2]"]
        linguistic_markers: ["[Expressão recorrente]"]
        decision_influence: ["[Como influencia decisões]"]

      challenges:
        contradictory_evidence_faced: ["[Evidência contrária]"]
        response_to_challenge: "[Como respondeu]"
        belief_modification: "[Se/como modificou]"

      strength: "[0.0-1.0]"
      flexibility: "[Rígida/Moderada/Flexível]"

      sources: ["[Fonte 1]", "[Fonte 2]"]

  life_purpose:
    - belief_id: "CORE_LP_001"
      belief_statement: "[Crença sobre propósito/significado]"
      # [Mesma estrutura acima]

  causation_agency:
    - belief_id: "CORE_CA_001"
      belief_statement: "[Crença sobre agência/controle/destino]"
      elaboration:
        locus_of_control: "[Interno/Externo/Misto]"
        free_will_position: "[Posição sobre livre arbítrio]"
        determinism_level: "[Nível de determinismo aceito]"
      # [Mesma estrutura acima]

  change_possibility:
    - belief_id: "CORE_CP_001"
      belief_statement: "[Crença sobre mudança/crescimento/fixidez]"
      elaboration:
        growth_mindset_level: "[0.0-1.0]"
        domains_changeable: ["[Domínio 1]", "[Domínio 2]"]
        domains_fixed: ["[Domínio 1]", "[Domínio 2]"]
      # [Mesma estrutura acima]

operational_beliefs:
  work_success:
    - belief_id: "OP_WS_001"
      belief_statement: "[Crença sobre trabalho/sucesso]"
      domain: "Trabalho e Sucesso"

      practical_implications:
        strategies_derived: ["[Estratégia 1]", "[Estratégia 2]"]
        behaviors_driven: ["[Comportamento 1]", "[Comportamento 2]"]
        decisions_influenced: ["[Tipo de decisão]"]

      testing_history:
        tested_when: "[Quando testou esta crença]"
        outcome: "[Resultado do teste]"
        belief_adjustment: "[Se/como ajustou]"

      transmission:
        communicates_to_others: "[Sim/Não/Às vezes]"
        teaching_frequency: "[Frequência]"
        conviction_level: "[0.0-1.0]"

      evidence_strength: "[0.0-1.0]"
      sources: ["[Fonte 1]", "[Fonte 2]"]

  relationships:
    - belief_id: "OP_REL_001"
      belief_statement: "[Crença sobre relacionamentos]"
      domain: "Relacionamentos"
      # [Mesma estrutura acima]

  learning_growth:
    - belief_id: "OP_LG_001"
      belief_statement: "[Crença sobre aprendizado/crescimento]"
      domain: "Aprendizado e Crescimento"
      # [Mesma estrutura acima]

  money_resources:
    - belief_id: "OP_MR_001"
      belief_statement: "[Crença sobre dinheiro/recursos]"
      domain: "Dinheiro e Recursos"
      # [Mesma estrutura acima]

  power_authority:
    - belief_id: "OP_PA_001"
      belief_statement: "[Crença sobre poder/autoridade]"
      domain: "Poder e Autoridade"
      # [Mesma estrutura acima]

  competition_cooperation:
    - belief_id: "OP_CC_001"
      belief_statement: "[Crença sobre competição/cooperação]"
      domain: "Competição e Cooperação"
      # [Mesma estrutura acima]

contextual_beliefs:
  domain_specific:
    - domain: "[Domínio específico]"
      beliefs:
        - belief_id: "CTX_001"
          belief_statement: "[Crença específica do domínio]"
          applicability: "[Onde se aplica]"
          context_dependency: "[Dependências contextuais]"
          sources: ["[Fonte]"]

  situational:
    - situation_type: "[Tipo de situação]"
      beliefs:
        - belief_id: "SIT_001"
          belief_statement: "[Crença situacional]"
          activation_triggers: ["[Gatilho 1]", "[Gatilho 2]"]
          duration: "[Temporária/Duradoura]"
          sources: ["[Fonte]"]

belief_structures:
  hierarchical_dependencies:
    - meta_belief_id: "META_XXX"
      supports_core_beliefs: ["CORE_YYY", "CORE_ZZZ"]
      explanation: "[Como meta-crença suporta core beliefs]"

    - core_belief_id: "CORE_YYY"
      supports_operational_beliefs: ["OP_AAA", "OP_BBB"]
      explanation: "[Como core belief suporta operational beliefs]"

  reinforcing_clusters:
    - cluster_id: "CLUSTER_001"
      cluster_description: "[Descrição do cluster de crenças mutuamente reforçadoras]"
      beliefs_in_cluster: ["BELIEF_ID_1", "BELIEF_ID_2", "BELIEF_ID_3"]
      synergy_effect: "[Como se reforçam mutuamente]"
      resilience: "[Quão resistente a mudança 0.0-1.0]"

  contradictory_pairs:
    - contradiction_id: "CONTRA_001"
      belief_a: "BELIEF_ID_X"
      belief_b: "BELIEF_ID_Y"

      contradiction_description: "[Descrição específica da contradição]"
      awareness_level: "[Consciente/Parcialmente/Inconsciente]"

      reconciliation_mechanisms:
        - mechanism_type: "[Compartimentalização/Racionalização/Negação/Aceitação]"
          description: "[Como reconcilia]"
          effectiveness: "[0.0-1.0]"

      context_switching:
        belief_a_contexts: ["[Contexto onde A predomina]"]
        belief_b_contexts: ["[Contexto onde B predomina]"]
        transition_triggers: ["[O que causa transição]"]

      authenticity_preservation: "[Por que manter no clone]"

belief_evolution:
  formation_timeline:
    - period: "[Período]"
      beliefs_formed: ["BELIEF_ID_1", "BELIEF_ID_2"]
      formation_context: "[Contexto de formação]"
      catalyzing_events: ["[Evento 1]", "[Evento 2]"]

  transformation_moments:
    - transformation_id: "TRANS_001"
      date: "[Data/período]"
      belief_before: "[Crença anterior]"
      belief_after: "[Nova crença]"

      transformation_trigger:
        event_type: "[Crise/Insight/Evidência/Mentoria]"
        description: "[Descrição específica]"
        impact_level: "[0-10]"

      transformation_process:
        duration: "[Duração da transformação]"
        resistance_level: "[Resistência enfrentada]"
        support_factors: ["[Fator 1]", "[Fator 2]"]
        integration_challenges: ["[Desafio 1]", "[Desafio 2]"]

      aftermath:
        behavioral_changes: ["[Mudança 1]", "[Mudança 2]"]
        relationship_impacts: ["[Impacto 1]", "[Impacto 2]"]
        cascading_belief_changes: ["BELIEF_ID_X", "BELIEF_ID_Y"]

      sources: ["[Fonte 1]", "[Fonte 2]"]

  stability_analysis:
    - belief_id: "BELIEF_XXX"
      lifespan: "[Duração que mantém]"
      challenge_history:
        - challenge_date: "[Data]"
          challenge_type: "[Tipo de desafio]"
          response: "[Como respondeu]"
          outcome: "[Manteve/Modificou/Abandonou]"
      current_status: "[Ativa/Modificada/Abandonada/Latente]"

dissonance_management:
  cognitive_dissonance_instances:
    - dissonance_id: "DISS_001"
      belief_system: "[Crença sistemática]"
      behavior_observed: "[Comportamento contraditório]"

      dissonance_level: "[0-10]"
      awareness: "[Consciente/Inconsciente]"

      coping_mechanisms:
        - mechanism: "[Mecanismo específico]"
          frequency: "[Frequência de uso]"
          effectiveness: "[0.0-1.0]"
          examples: ["[Exemplo 1]", "[Exemplo 2]"]

      cost_of_dissonance:
        psychological: "[Custo psicológico]"
        behavioral: "[Custo comportamental]"
        relational: "[Custo relacional]"

      preservation_for_clone: "[Por que preservar esta dissonância]"

belief_testing_patterns:
  empirical_approach:
    tests_beliefs: "[Sim/Não/Seletivamente]"
    testing_methodology: "[Como testa]"
    openness_to_revision: "[0.0-1.0]"
    revision_threshold: "[O que necessário para revisar]"

  confirmation_bias_level: "[0.0-1.0]"
  belief_perseverance_strength: "[0.0-1.0]"

  belief_revision_history:
    - belief_id: "BELIEF_XXX"
      revision_count: "[N vezes revisada]"
      revisions:
        - revision_date: "[Data]"
          from_belief: "[Crença anterior]"
          to_belief: "[Crença revisada]"
          evidence_triggered: "[Evidência que desencadeou]"
          sources: ["[Fonte]"]

influence_mapping:
  sources_of_beliefs:
    - influence_source: "[Fonte de influência]"
      influence_type: "[Mentor/Livro/Experiência/Cultura]"
      beliefs_influenced: ["BELIEF_ID_1", "BELIEF_ID_2"]
      influence_period: "[Período]"
      influence_strength: "[0.0-1.0]"
      current_status: "[Ativa/Superada/Integrada]"

  transmission_to_others:
    evangelizes_beliefs: ["BELIEF_ID_1", "BELIEF_ID_2"]
    teaching_approach: "[Como ensina suas crenças]"
    conviction_in_teaching: "[0.0-1.0]"
    adaptability_to_audience: "[0.0-1.0]"

worldview_synthesis:
  coherence_level: "[0.0-1.0]"
  integration_quality: "[Como crenças se integram]"

  worldview_archetype: "[Classificação geral]"

  distinctive_elements:
    - element: "[Elemento único da visão de mundo]"
      uniqueness_score: "[0.0-1.0]"
      centrality: "[0.0-1.0]"
      explanation: "[Por que distintivo]"

  philosophical_influences:
    - philosophy_tradition: "[Tradição filosófica]"
      alignment_level: "[0.0-1.0]"
      conscious_adoption: "[Sim/Não]"
      manifestation: "[Como se manifesta]"

operational_instructions_for_clone:
  belief_activation_logic: |
    [Algoritmo para ativar crenças corretas conforme contexto:
    1. Identificar contexto/domínio da situação
    2. Ativar crenças relevantes na hierarquia
    3. Aplicar mecanismos de reconciliação se contraditórias
    4. Manter dissonâncias características
    5. Expressar crenças com nível de convicção característico]

  dissonance_preservation: |
    [Como manter dissonâncias cognitivas autênticas]

  evolution_simulation: |
    [Como simular capacidade de evolução de crenças]
```

## CHECKLIST DE QUALIDADE

- [ ] Mínimo 30 crenças catalogadas em todos os níveis
- [ ] Meta-crenças (epistemológicas/ontológicas/axiológicas) identificadas
- [ ] Core beliefs sobre natureza humana, propósito, agência mapeadas
- [ ] Operational beliefs em mínimo 6 domínios documentadas
- [ ] Hierarchical dependencies mapeadas
- [ ] Mínimo 5 contradictory pairs identificadas e analisadas
- [ ] Belief evolution timeline documentada
- [ ] Dissonance management mechanisms catalogados
- [ ] Influence sources rastreadas
- [ ] Operational instructions para clone incluídas
- [ ] Todas as crenças com evidence e sources

## ALERTAS CRÍTICOS

1. **DECLARADO vs DEMONSTRADO**: Pessoas declaram crenças socialmente desejáveis. Crenças reais são demonstradas por decisões e comportamentos consistentes.

2. **DISSONÂNCIAS SÃO AUTENTICIDADE**: Não resolva contradições entre crenças - elas são parte essencial da pessoa. Documente mecanismos de reconciliação.

3. **CONTEXTO ATIVA CRENÇAS**: Mesma pessoa expressa crenças diferentes em contextos diferentes. Mapear context-dependency rigorosamente.

4. **EVOLUÇÃO É ESSENCIAL**: Crenças mudam ao longo da vida. Documentar trajectory, não apenas snapshot atual.

5. **HIERARQUIA IMPORTA**: Meta-crenças governam core beliefs que governam operational beliefs. Mudanças top-down causam cascatas.

---

**ENTREGUE**: @{mind}/artifacts/beliefs_core.yaml com sistema completo de crenças seguindo exatamente este formato.