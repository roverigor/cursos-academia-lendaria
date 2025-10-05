# TIMELINE MAPPING

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/, analysis/quotes_database.yaml
- Output: analysis/life_timeline.yaml
- Dependências: 01_quote_extraction.md, 01_source_reading.md

## OBJETIVO PRINCIPAL

Mapear a trajetória completa de vida e carreira de [NOME_SUJEITO] em timeline estruturada, identificando fases distintas, eventos transformadores, e evolução temporal de padrões comportamentais, valores e competências.

## INPUT NECESSÁRIO

```yaml
required_inputs:
  - sources/ (todos os materiais coletados)
  - analysis/quotes_database.yaml (citações com timestamps)
  - logs/YYYYMMDD-HHMM-key_insights.md (insights de leitura)
```

## METODOLOGIA

### FASE 1: COLETA TEMPORAL
Extrair todos os eventos, decisões, mudanças e marcos documentados nas fontes com datas/períodos específicos.

### FASE 2: PERIODIZAÇÃO
Identificar fases naturais baseadas em mudanças significativas de contexto, valores, comportamento ou foco.

### FASE 3: ANÁLISE EVOLUTIVA
Mapear como padrões específicos emergiram, evoluíram ou desapareceram ao longo do tempo.

### FASE 4: IDENTIFICAÇÃO DE GATILHOS
Documentar eventos/contextos que desencadearam mudanças significativas.

## OUTPUT ESTRUTURADO

```yaml
timeline_metadata:
  subject: "[NOME COMPLETO]"
  analysis_date: "YYYY-MM-DD"
  temporal_coverage: "[YYYY-YYYY]"
  documentation_density: "[% da vida documentada]"
  source_count: "[N fontes com info temporal]"
  confidence_level: "[0.0-1.0]"

life_phases:
  phase_01_formacao:
    period: "[YYYY-YYYY]"
    age_range: "[X-Y anos]"
    phase_name: "[Nome descritivo da fase]"

    defining_characteristics:
      - characteristic: "[Característica definidora 1]"
        evidence: "[Evidência específica com fonte]"
        manifestation: "[Como se manifestava]"
      - characteristic: "[Característica definidora 2]"
        evidence: "[Evidência específica]"
        manifestation: "[Como se manifestava]"

    key_events:
      - event_id: "EVT_001"
        date: "[YYYY-MM-DD ou período]"
        event_description: "[Descrição específica do evento]"
        event_type: "[Decisão/Conquista/Crise/Aprendizado/Mudança]"
        impact_level: "[1-10]"
        immediate_consequences: "[Consequências imediatas]"
        long_term_impact: "[Impacto de longo prazo]"
        sources: ["[Fonte 1]", "[Fonte 2]"]
        quotes_related: ["[ID da quote do quotes_database.yaml]"]

      - event_id: "EVT_002"
        date: "[Data/período]"
        event_description: "[Descrição]"
        event_type: "[Tipo]"
        impact_level: "[1-10]"
        immediate_consequences: "[Consequências]"
        long_term_impact: "[Impacto]"
        sources: ["[Fonte]"]
        quotes_related: ["[IDs]"]

    dominant_values:
      - value: "[Valor dominante nesta fase]"
        manifestation: "[Como se manifestava comportamentalmente]"
        evidence: "[Evidências específicas]"
        evolution_from_previous: "[Como evoluiu da fase anterior]"

    skills_developed:
      - skill: "[Competência desenvolvida]"
        development_context: "[Contexto de desenvolvimento]"
        mastery_level: "[Nível alcançado na fase]"
        evidence: "[Evidências de desenvolvimento]"

    relationships_formative:
      - person: "[Nome da pessoa]"
        relationship_type: "[Mentor/Parceiro/Adversário/Inspiração]"
        influence_description: "[Como influenciou]"
        duration: "[Período]"
        impact_score: "[1-10]"

    environment_context:
      geographic_location: "[Onde estava]"
      socioeconomic_context: "[Contexto socioeconômico]"
      cultural_influences: "[Influências culturais específicas]"
      technological_context: "[Contexto tecnológico da época]"
      industry_context: "[Contexto da indústria/área]"

    internal_state:
      confidence_level: "[Baixo/Médio/Alto/Variável]"
      primary_motivation: "[Motivação primária na fase]"
      fears_doubts: "[Medos ou dúvidas documentados]"
      self_perception: "[Como se via]"

    transition_to_next:
      transition_event: "[Evento que marcou fim/início de nova fase]"
      transition_date: "[Data/período]"
      transition_type: "[Gradual/Abrupta/Crise/Oportunidade]"
      readiness_level: "[Quão preparado estava]"

  phase_02_ascensao:
    period: "[YYYY-YYYY]"
    age_range: "[X-Y anos]"
    phase_name: "[Nome descritivo]"
    # [Repetir estrutura completa acima]

  phase_03_consolidacao:
    period: "[YYYY-YYYY]"
    age_range: "[X-Y anos]"
    phase_name: "[Nome descritivo]"
    # [Repetir estrutura completa]

  phase_04_transformacao:
    period: "[YYYY-YYYY]"
    age_range: "[X-Y anos]"
    phase_name: "[Nome descritivo]"
    # [Repetir estrutura completa]

  phase_05_atual:
    period: "[YYYY-presente]"
    age_range: "[X+ anos]"
    phase_name: "[Nome descritivo]"
    # [Repetir estrutura completa]

transformative_moments:
  crisis_points:
    - crisis_id: "CRISIS_001"
      date: "[Data]"
      crisis_description: "[Descrição específica da crise]"
      crisis_type: "[Financeira/Saúde/Relacionamento/Profissional/Existencial]"
      severity: "[1-10]"
      response_strategy: "[Como respondeu]"
      outcome: "[Resultado]"
      learning_extracted: "[Aprendizado documentado]"
      lasting_impact: "[Impacto duradouro]"
      sources: ["[Fontes]"]

  breakthrough_moments:
    - breakthrough_id: "BREAK_001"
      date: "[Data]"
      breakthrough_description: "[Descrição do breakthrough]"
      context: "[Contexto]"
      enablers: "[O que possibilitou]"
      immediate_impact: "[Impacto imediato]"
      cascading_effects: "[Efeitos em cascata]"
      sources: ["[Fontes]"]

  pivots_major:
    - pivot_id: "PIVOT_001"
      date: "[Data]"
      from_state: "[Estado/caminho anterior]"
      to_state: "[Novo estado/caminho]"
      trigger: "[O que desencadeou]"
      decision_process: "[Como decidiu]"
      resistance_faced: "[Resistência enfrentada]"
      validation_received: "[Quando se validou]"
      sources: ["[Fontes]"]

pattern_evolution:
  behavioral_patterns:
    - pattern_name: "[Nome do padrão comportamental]"
      emergence_phase: "[Quando emergiu]"
      evolution_timeline:
        - phase: "[Fase 1]"
          manifestation: "[Como se manifestava]"
          frequency: "[Frequência]"
          context: "[Contextos]"
        - phase: "[Fase 2]"
          manifestation: "[Como evoluiu]"
          frequency: "[Frequência]"
          context: "[Contextos]"
      current_state: "[Estado atual do padrão]"
      stability_score: "[Quão estável/consistente 0.0-1.0]"

  values_evolution:
    - value: "[Nome do valor]"
      phase_emergence: "[Quando emergiu]"
      trajectory:
        - phase: "[Fase]"
          priority_rank: "[Ranking]"
          manifestation: "[Como se manifestava]"
          evidence: "[Evidências]"
      evolution_pattern: "[Crescente/Decrescente/Estável/Cíclico]"
      current_centrality: "[Quão central é hoje 0.0-1.0]"

  skill_mastery_curves:
    - skill: "[Competência específica]"
      discovery_date: "[Quando descobriu/iniciou]"
      mastery_timeline:
        - period: "[Período]"
          level: "[Nível de maestria 0-100]"
          evidence: "[Evidências do nível]"
          practice_intensity: "[Intensidade de prática]"
      peak_performance_period: "[Quando atingiu pico]"
      current_level: "[Nível atual]"

recurring_patterns:
  decision_patterns:
    - pattern_description: "[Descrição do padrão decisório]"
      frequency_count: "[N vezes observado]"
      contexts: ["[Contexto 1]", "[Contexto 2]"]
      success_rate: "[Taxa de sucesso]"
      examples:
        - date: "[Data]"
          situation: "[Situação]"
          decision: "[Decisão]"
          outcome: "[Resultado]"

  response_patterns:
    - trigger_type: "[Tipo de gatilho]"
      typical_response: "[Resposta típica]"
      frequency: "[Frequência]"
      effectiveness: "[Efetividade 0.0-1.0]"
      examples:
        - date: "[Data]"
          trigger: "[Gatilho específico]"
          response: "[Resposta]"
          outcome: "[Resultado]"

temporal_gaps:
  - gap_period: "[YYYY-YYYY]"
    gap_duration: "[N anos/meses]"
    documentation_level: "[Baixo/Inexistente]"
    known_facts: ["[Fato 1]", "[Fato 2]"]
    inference_possible: "[Sim/Não]"
    impact_on_analysis: "[Como afeta análise]"

meta_timeline_analysis:
  documentation_quality:
    high_coverage_periods: ["[Período 1]", "[Período 2]"]
    low_coverage_periods: ["[Período 1]", "[Período 2]"]
    bias_sources: "[Possíveis vieses nas fontes]"
    contradictions_found: "[Contradições entre fontes]"

  narrative_consistency:
    self_narrative_evolution: "[Como narrativa pessoal evoluiu]"
    external_perception_shifts: "[Como percepção externa mudou]"
    alignment_score: "[Alinhamento self vs external 0.0-1.0]"

  confidence_by_period:
    - period: "[Período]"
      confidence_level: "[0.0-1.0]"
      reasoning: "[Por que este nível de confiança]"
```

## CHECKLIST DE QUALIDADE

- [ ] Mínimo 5 fases de vida identificadas e documentadas
- [ ] Cada fase tem mínimo 3 key_events documentados
- [ ] Eventos transformadores (crises/breakthroughs/pivots) mapeados
- [ ] Evolução de mínimo 5 padrões comportamentais rastreada
- [ ] Evolução de mínimo 3 valores core rastreada
- [ ] Gaps temporais identificados e documentados
- [ ] Todas as datas verificadas contra múltiplas fontes
- [ ] Contradições temporais resolvidas ou documentadas
- [ ] Confidence scores atribuídos por período
- [ ] Mínimo 3 fontes para eventos críticos

## ALERTAS CRÍTICOS

1. **VERIFICAÇÃO DE DATAS**: Todas as datas devem ser verificadas contra múltiplas fontes. Conflitos devem ser documentados em notas.

2. **CAUSALIDADE vs CORRELAÇÃO**: Cuidado ao afirmar que "evento X causou mudança Y". Documentar correlação temporal mas ser cauteloso com causalidade.

3. **REVISIONISM BIAS**: Pessoas reescrevem suas histórias. Triangular narrativa pessoal com evidências externas e documentos da época.

4. **TEMPORAL GAPS**: Documentar explicitamente períodos com baixa documentação. Não preencher gaps com especulação.

5. **PHASE GRANULARITY**: Fases devem ser significativas (mínimo 1-2 anos). Evitar fragmentação excessiva que dificulta análise de padrões.

---

**ENTREGUE**: analysis/life_timeline.yaml com timeline completa estruturada seguindo exatamente este formato.