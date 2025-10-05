# DECISION ANALYSIS

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/, analysis/life_timeline.yaml, analysis/quotes_database.yaml
- Output: analysis/decision_patterns.yaml
- Dependências: 01_timeline_mapping.md, 01_quote_extraction.md

## OBJETIVO PRINCIPAL

Mapear a arquitetura decisória de [NOME_SUJEITO] através de análise sistemática de decisões documentadas, identificando frameworks mentais, heurísticas, valores operacionais, vieses característicos e padrões de trade-off que governam escolhas em diferentes contextos.

## INPUT NECESSÁRIO

```yaml
required_inputs:
  - sources/ (todos os materiais coletados)
  - analysis/life_timeline.yaml (decisões contextualizadas temporalmente)
  - analysis/quotes_database.yaml (citações sobre decisões e raciocínio)
```

## METODOLOGIA

### FASE 1: CATALOGAÇÃO DE DECISÕES
Identificar e catalogar todas as decisões significativas documentadas, com contexto, raciocínio declarado e resultado observado.

### FASE 2: ANÁLISE DE FRAMEWORKS
Extrair frameworks mentais e princípios decisórios que emergem consistentemente.

### FASE 3: MAPEAMENTO DE HEURÍSTICAS
Identificar atalhos mentais, regras práticas e heurísticas utilizadas.

### FASE 4: ANÁLISE DE TRADE-OFFS
Mapear como diferentes valores/objetivos são balanceados quando em conflito.

### FASE 5: IDENTIFICAÇÃO DE VIESES
Documentar vieses cognitivos característicos observáveis nas decisões.

## OUTPUT ESTRUTURADO

```yaml
decision_analysis_metadata:
  subject: "[NOME COMPLETO]"
  analysis_date: "YYYY-MM-DD"
  decisions_analyzed: "[N decisões catalogadas]"
  temporal_range: "[YYYY-YYYY]"
  domains_covered: ["[Domínio 1]", "[Domínio 2]"]
  confidence_level: "[0.0-1.0]"

decision_catalog:
  high_stakes_decisions:
    - decision_id: "DEC_001"
      date: "[YYYY-MM-DD]"
      decision_description: "[Descrição específica da decisão]"
      decision_type: "[Carreira/Financeira/Relacionamento/Estratégica/Ética]"
      stakes_level: "[1-10]"

      context:
        situation: "[Situação específica]"
        constraints: ["[Constraint 1]", "[Constraint 2]"]
        time_pressure: "[Baixa/Média/Alta]"
        information_available: "[Completa/Parcial/Incompleta]"
        external_pressure: ["[Pressão 1]", "[Pressão 2]"]
        phase_of_life: "[Fase conforme timeline]"

      options_considered:
        - option: "[Opção 1]"
          pros_stated: ["[Pro 1]", "[Pro 2]"]
          cons_stated: ["[Con 1]", "[Con 2]"]
          probability_success: "[Estimativa se documentada]"
        - option: "[Opção 2]"
          pros_stated: ["[Pro 1]", "[Pro 2]"]
          cons_stated: ["[Con 1]", "[Con 2]"]
          probability_success: "[Estimativa]"

      decision_made: "[Decisão tomada]"

      reasoning_declared:
        primary_reason: "[Razão principal declarada]"
        supporting_reasons: ["[Razão 2]", "[Razão 3]"]
        values_invoked: ["[Valor 1]", "[Valor 2]"]
        frameworks_used: ["[Framework se identificável]"]
        quotes_relevant: ["[ID quote do database]"]

      reasoning_inferred:
        hidden_motivations: "[Motivações não declaradas mas inferíveis]"
        emotional_factors: "[Fatores emocionais observáveis]"
        social_influences: "[Influências sociais]"
        financial_calculations: "[Cálculos financeiros implícitos]"
        risk_tolerance_revealed: "[Tolerância a risco demonstrada]"

      execution:
        implementation_speed: "[Rápida/Gradual/Lenta]"
        commitment_level: "[Baixo/Médio/Alto/Total]"
        reversibility: "[Reversível/Parcialmente/Irreversível]"
        resources_committed: "[Recursos alocados]"

      outcome:
        immediate_result: "[Resultado imediato]"
        long_term_result: "[Resultado de longo prazo]"
        success_level: "[0-10]"
        unexpected_consequences: ["[Consequência 1]", "[Consequência 2]"]
        learning_documented: "[Aprendizado documentado]"

      meta_analysis:
        decision_quality_score: "[0-10]"
        process_quality: "[Qualidade do processo decisório]"
        outcome_quality: "[Qualidade do resultado]"
        luck_factor: "[Papel da sorte/acaso 0.0-1.0]"
        would_repeat: "[Repetiria? Sim/Não/Condicional]"

      sources: ["[Fonte 1]", "[Fonte 2]"]

  routine_decisions:
    - decision_pattern: "[Padrão de decisão rotineira]"
      frequency: "[Frequência]"
      typical_context: "[Contexto típico]"
      heuristic_used: "[Heurística utilizada]"
      success_rate: "[Taxa de sucesso]"
      examples:
        - date: "[Data]"
          situation: "[Situação]"
          decision: "[Decisão]"
          outcome: "[Resultado]"

decision_frameworks:
  primary_frameworks:
    - framework_id: "FW_001"
      framework_name: "[Nome do framework mental]"
      framework_description: "[Descrição específica]"

      structure:
        key_questions: ["[Pergunta 1]", "[Pergunta 2]", "[Pergunta 3]"]
        evaluation_criteria: ["[Critério 1]", "[Critério 2]"]
        decision_algorithm: "[Descrição do algoritmo decisório]"
        threshold_logic: "[Lógica de threshold se aplicável]"

      application_contexts:
        - context: "[Contexto de aplicação]"
          frequency: "[Frequência de uso]"
          effectiveness: "[Efetividade 0.0-1.0]"
          example_decision_id: "DEC_XXX"

      origin:
        source_type: "[Aprendizado/Mentoria/Experiência/Leitura]"
        development_period: "[Quando desenvolveu]"
        refinement_history: "[Como refinou ao longo do tempo]"

      strengths:
        - "[Força 1 do framework]"
        - "[Força 2 do framework]"

      limitations:
        - "[Limitação 1]"
        - "[Limitação 2]"

      evidence_strength: "[0.0-1.0]"

  principles_operational:
    - principle: "[Princípio decisório]"
      statement: "[Statement específico do princípio]"
      priority_level: "[Alto/Médio/Baixo]"
      contexts_applied: ["[Contexto 1]", "[Contexto 2]"]
      examples_application:
        - decision_id: "DEC_XXX"
          how_applied: "[Como o princípio guiou decisão]"
      conflicts_with: ["[Outros princípios que conflita]"]
      override_conditions: "[Quando é sobreposto]"

heuristics_catalog:
  mental_shortcuts:
    - heuristic_name: "[Nome da heurística]"
      heuristic_description: "[Descrição do atalho mental]"
      trigger_conditions: ["[Condição 1]", "[Condição 2]"]
      typical_application: "[Como tipicamente aplica]"
      accuracy_rate: "[Taxa de acerto]"
      failure_modes: ["[Modo de falha 1]", "[Modo de falha 2]"]
      examples:
        - decision_id: "DEC_XXX"
          application_details: "[Detalhes da aplicação]"

  rules_of_thumb:
    - rule: "[Regra prática]"
      domain: "[Domínio de aplicação]"
      origin: "[Origem da regra]"
      reliability: "[Confiabilidade 0.0-1.0]"
      exceptions_known: ["[Exceção 1]", "[Exceção 2]"]
      usage_frequency: "[Alta/Média/Baixa]"

trade_off_patterns:
  value_conflicts:
    - conflict_id: "TRD_001"
      value_a: "[Valor A]"
      value_b: "[Valor B conflitante]"

      typical_resolution:
        prioritizes: "[Qual valor geralmente prioriza]"
        context_dependency: "[Como contexto afeta priorização]"
        resolution_pattern: "[Padrão de resolução]"

      examples:
        - decision_id: "DEC_XXX"
          value_a_weight: "[Peso dado ao valor A]"
          value_b_weight: "[Peso dado ao valor B]"
          resolution: "[Como resolveu]"
          satisfaction_level: "[Satisfação com resolução]"

  resource_allocation:
    - resource_type: "[Tempo/Dinheiro/Energia/Atenção]"
      allocation_philosophy: "[Filosofia de alocação]"
      typical_distribution:
        - category: "[Categoria 1]"
          percentage: "[%]"
          rationale: "[Raciocínio]"
      reallocation_triggers: ["[Gatilho 1]", "[Gatilho 2]"]
      examples_major_allocations:
        - decision_id: "DEC_XXX"
          allocation_details: "[Detalhes]"

  time_horizon_preferences:
    short_term_bias: "[0.0-1.0]"
    long_term_bias: "[0.0-1.0]"
    balancing_mechanism: "[Como balancea curto vs longo prazo]"
    context_shifts: "[Contextos que mudam preferência temporal]"

cognitive_biases:
  identified_biases:
    - bias_name: "[Nome do viés cognitivo]"
      bias_description: "[Descrição específica]"
      frequency_manifestation: "[Frequência observada]"
      domains_affected: ["[Domínio 1]", "[Domínio 2]"]

      manifestation_examples:
        - decision_id: "DEC_XXX"
          how_manifested: "[Como o viés se manifestou]"
          impact: "[Impacto na decisão]"
          awareness_level: "[Consciente/Inconsciente]"

      mitigation_attempts:
        aware: "[Sim/Não]"
        strategies_used: ["[Estratégia 1]", "[Estratégia 2]"]
        effectiveness: "[0.0-1.0]"

      authenticity_marker: "[Por que preservar no clone]"

  blind_spots_decisional:
    - blind_spot: "[Ponto cego específico]"
      description: "[Descrição do que não vê/considera]"
      evidence: "[Evidências do blind spot]"
      frequency: "[Frequência]"
      consequences: ["[Consequência 1]", "[Consequência 2]"]
      compensating_mechanisms: "[Mecanismos compensatórios desenvolvidos]"

decision_styles:
  by_context:
    professional_decisions:
      style: "[Analítico/Intuitivo/Consultivo/Autoritário]"
      speed: "[Rápido/Moderado/Lento]"
      information_seeking: "[Baixo/Médio/Alto]"
      risk_tolerance: "[0-10]"
      reversibility_preference: "[Prefere reversível/irrelevante]"
      typical_process: "[Descrição do processo típico]"

    personal_decisions:
      style: "[Estilo]"
      speed: "[Velocidade]"
      information_seeking: "[Nível]"
      risk_tolerance: "[0-10]"
      reversibility_preference: "[Preferência]"
      typical_process: "[Processo]"

    strategic_decisions:
      style: "[Estilo]"
      speed: "[Velocidade]"
      information_seeking: "[Nível]"
      risk_tolerance: "[0-10]"
      reversibility_preference: "[Preferência]"
      typical_process: "[Processo]"

  under_pressure:
    stress_response: "[Como decide sob stress]"
    quality_degradation: "[Como qualidade se degrada]"
    fallback_patterns: ["[Padrão 1]", "[Padrão 2]"]
    recovery_mechanisms: "[Como recupera qualidade decisória]"

risk_profile:
  risk_tolerance_overall: "[0-10]"

  risk_tolerance_by_domain:
    - domain: "[Domínio]"
      tolerance_level: "[0-10]"
      rationale: "[Raciocínio]"
      evidence_decisions: ["DEC_XXX", "DEC_YYY"]

  risk_assessment_patterns:
    upside_focus: "[0.0-1.0]"
    downside_focus: "[0.0-1.0]"
    probability_calibration: "[Bem/Mal calibrado]"
    asymmetry_preferences: "[Assimetrias que busca]"

  loss_aversion_level: "[0.0-1.0]"

decision_evolution:
  maturation_patterns:
    - period: "[Período]"
      decision_quality_trend: "[Melhorando/Estável/Degradando]"
      sophistication_increase: "[Descrição]"
      learning_integration: "[Como aprendizados foram integrados]"

  framework_adoption_timeline:
    - framework: "[Framework]"
      adoption_date: "[Data]"
      trigger: "[O que desencadeou adoção]"
      evolution: "[Como evoluiu desde adoção]"

meta_decision_insights:
  decision_about_decisions:
    - meta_principle: "[Princípio meta sobre decisões]"
      description: "[Descrição]"
      examples: ["[Exemplo 1]", "[Exemplo 2]"]

  self_awareness_level: "[0.0-1.0]"
  process_consciousness: "[Quão consciente é do próprio processo]"
  improvement_efforts: ["[Esforço 1]", "[Esforço 2]"]

operational_instructions_for_clone:
  decision_simulation_algorithm: |
    [Algoritmo para simular decisões do sujeito:
    1. Identificar tipo de decisão
    2. Aplicar framework relevante
    3. Considerar valores em jogo
    4. Aplicar heurísticas características
    5. Integrar vieses autênticos
    6. Gerar decisão no estilo característico]

  context_detection_logic: |
    [Lógica para detectar contexto e ajustar estilo decisório]

  consistency_maintenance: |
    [Como manter consistência com padrões históricos]
```

## CHECKLIST DE QUALIDADE

- [ ] Mínimo 20 decisões significativas catalogadas
- [ ] Mínimo 3 frameworks decisórios identificados
- [ ] Mínimo 10 heurísticas mapeadas
- [ ] Trade-offs documentados com exemplos específicos
- [ ] Mínimo 5 vieses cognitivos identificados
- [ ] Evolução decisória ao longo do tempo mapeada
- [ ] Risk profile quantificado por domínio
- [ ] Decision styles por contexto documentados
- [ ] Instruções operacionais para clone incluídas
- [ ] Todas as decisões com sources verificadas

## ALERTAS CRÍTICOS

1. **DECISÕES vs NARRATIVA**: Separar decisão real de narrativa post-hoc. Procurar evidências contemporâneas sempre que possível.

2. **VIESES SÃO FEATURES**: Não corrija vieses cognitivos - eles são parte da autenticidade. Documente-os para replicação.

3. **CONTEXTO É CRÍTICO**: Mesma pessoa decide diferente em contextos diferentes. Mapear dependências contextuais rigorosamente.

4. **SORTE vs SKILL**: Distinguir decisões boas que deram errado por azar de decisões ruins que deram certo por sorte.

5. **EVOLUÇÃO TEMPORAL**: Pessoas mudam frameworks decisórios ao longo do tempo. Não generalize padrões recentes para toda vida.

---

**ENTREGUE**: analysis/decision_patterns.yaml com análise completa de arquitetura decisória seguindo exatamente este formato.