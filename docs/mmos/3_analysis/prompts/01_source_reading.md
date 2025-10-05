# SOURCE READING

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/ organizadas, analysis/sources_master.yaml, analysis/priority_matrix.yaml
- Output: logs/YYYYMMDD-HHMM-key_insights.md
- Dependências: 04_sources_master.md, 03_priority_calculator.md

## OBJETIVO PRINCIPAL
Realizar uma arqueologia mental completa do clone alvo, extraindo TODOS os fatos brutos disponíveis nas fontes com granularidade forense, criando um mapeamento detalhado da formação e evolução da personalidade.

Você é um arqueólogo cognitivo especializado em extração de dados biográficos com expertise em análise forense de timelines e mapeamento de eventos formativos.

## INPUT NECESSÁRIO

Nome completo da pessoa alvo e acesso aos materiais organizados:
```
clone_target: "[NOME COMPLETO]"
sources_path: "sources/"
sources_master: "analysis/sources_master.yaml"
priority_matrix: "analysis/priority_matrix.yaml"
```

## METODOLOGIA

### FASE 1: EXTRAÇÃO FORENSE
1. Processar fontes por ordem de prioridade ROI
2. Extrair eventos com granularidade temporal precisa
3. Documentar circunstâncias e contextos completos
4. Mapear impactos imediatos e de longo prazo

### FASE 2: ESTRUTURAÇÃO ARQUEOLÓGICA
Criar arquivo key_insights.md estruturado EXATAMENTE como abaixo:

## OUTPUT ESTRUTURADO

# ARQUEOLOGIA MENTAL DE [NOME]

# # PARTE 1: TIMELINE GRANULAR FORENSE

# ## 1.1 PERÍODO FORMATIVO (0-18 anos)

```yaml
timeline_formativo:
  - when: "YYYY-MM-DD"
    event: "[Evento específico detalhado com contexto completo]"
    location: "[Cidade, Estado/Província, País]"
    age_exact: "[X anos, Y meses]"

    people_involved:
      primary: "[Pessoa principal envolvida]"
      secondary: ["[Lista de outras pessoas]"]
      influencers: ["[Quem influenciou indiretamente]"]

    circumstances:
      trigger: "[O que causou/iniciou]"
      context: "[Situação maior acontecendo]"
      preparation: "[Se foi planejado ou espontâneo]"
      duration: "[Quanto tempo durou]"

    immediate_impact:
      emotional: "[Reação emocional imediata]"
      behavioral: "[Mudança comportamental imediata]"
      social: "[Como afetou relacionamentos]"
      academic: "[Impacto em estudos se aplicável]"

    long_term_consequences:
      personality: "[Como moldou personalidade]"
      worldview: "[Mudança em visão de mundo]"
      patterns: "[Padrões que estabeleceu]"
      trauma_or_gift: "[Se criou trauma ou talento]"

    evidence_quality:
      source_primary: "[Fonte primária se disponível]"
      source_secondary: "[Fontes secundárias]"
      corroboration: "[Outras fontes que confirmam]"
      confidence: "[Alto/Médio/Baixo]"
      certainty_level: "[Fato confirmado/Provável/Possível/Especulação]"

    quotes_available:
      - quote: "[Citação exata se disponível]"
        source: "[Onde foi dito/escrito]"
        context: "[Situação da citação]"

    connections:
      previous_events: "[Como conecta com eventos anteriores]"
      future_impact: "[Como influenciou eventos posteriores]"
      pattern_part: "[Faz parte de que padrão maior]"
```

**EVENTOS OBRIGATÓRIOS A MAPEAR (mínimo 25 eventos):**

**📅 MARCOS VITAIS:**
- Data, hora e circunstâncias exatas do nascimento
- Primeiros dias/semanas - adaptação inicial
- Primeiros meses - vínculos formativos estabelecidos

**👨‍👩‍👧‍👦 DINÂMICA FAMILIAR:**
- Composição familiar completa (incluindo pets significativos)
- Ordem de nascimento e gap entre irmãos
- Presença/ausência de avós e família estendida
- Mudanças na estrutura familiar (nascimentos, mortes, divórcios)
- Rituais familiares e tradições específicas
- Regras familiares explícitas e implícitas
- Conflitos familiares presenciados ou vividos

**🏠 AMBIENTE E MUDANÇAS:**
- Todas as residências e motivos de mudanças
- Características do bairro/comunidade
- Condição socioeconômica e flutuações
- Exposição a culturas/idiomas diferentes

**🎓 FORMAÇÃO EDUCACIONAL:**
- Primeira escola e processo de adaptação
- Professores marcantes (positivo e negativo)
- Colegas próximos e inimizades
- Matérias preferidas e odiadas
- Eventos escolares significativos
- Bullying sofrido ou praticado
- Reconhecimentos e punições

** DESPERTAR VOCACIONAL:**
- Primeiros interesses/obsessões identificados
- Talentos naturais observados
- Atividades que faziam perder noção do tempo
- Modelos/ídolos da infância
- Primeiros "experimentos" criativos

**😢 TRAUMAS E DESAFIOS:**
- Acidentes ou doenças significativas
- Perdas (pessoas, pets, objetos importantes)
- Medos desenvolvidos e como foram tratados
- Primeiras desilusões documentadas
- Momentos de rejeição social

** SUCESSOS E CONQUISTAS:**
- Primeiras vitórias em competições
- Reconhecimentos públicos recebidos
- Momentos de orgulho dos pais
- Liderança exercida em grupos
- Problemas resolvidos independentemente

# ## 1.2 PERÍODO DE FORMAÇÃO IDENTITÁRIA (18-25 anos)

```yaml
timeline_formacao:
  - when: "YYYY-MM-DD"
    decision_type: "[Escolha de carreira/Relacionamento/Mudança geográfica/etc]"

    decision_context:
      situation_before: "[Estado anterior detalhado]"
      pressures_external: "[Pressões de família/sociedade/economia]"
      pressures_internal: "[Desejos/medos/ambições pessoais]"
      deadline_imposed: "[Se havia prazo para decidir]"
      stakes_involved: "[O que estava em jogo]"

    alternatives_matrix:
      option_1:
        description: "[Opção considerada]"
        probability_success: "[Estimativa na época]"
        pros_listed: ["[Vantagens percebidas]"]
        cons_listed: ["[Desvantagens percebidas]"]
        influencers_pro: ["[Quem apoiava esta opção]"]
        influencers_against: ["[Quem desencorajava]"]
      option_2:
        description: "[Segunda opção]"
        # [Mesmo formato]
      option_chosen:
        description: "[Opção final escolhida]"
        rationale_declared: "[Razão dada publicamente]"
        rationale_private: "[Razão real se diferente]"
        rationale_inferred: "[Razão inferida por terceiros]"

    execution_phase:
      timeline: "[Quanto tempo levou para implementar]"
      first_steps: "[Primeiras ações tomadas]"
      obstacles_encountered: "[Problemas que surgiram]"
      adaptations_made: "[Como ajustaram o curso]"
      support_received: "[Quem ajudou e como]"
      resistance_faced: "[Quem/o que resistiu]"

    outcomes_measurement:
      immediate_results: "[Resultados em 3-6 meses]"
        metrics: "[Números específicos se disponíveis]"
        satisfaction_level: "[Alto/Médio/Baixo na época]"
        unexpected_consequences: "[Efeitos não antecipados]"

      medium_term_results: "[Resultados em 1-3 anos]"
        career_impact: "[Como afetou carreira]"
        relationship_impact: "[Como afetou relacionamentos]"
        identity_impact: "[Como mudou auto-percepção]"
        skill_development: "[Habilidades desenvolvidas]"

      long_term_legacy: "[Resultados em 5+ anos]"
        trajectory_change: "[Como mudou trajetória de vida]"
        lessons_learned: "[Lições extraídas explicitamente]"
        patterns_established: "[Padrões que criou]"
        regrets_expressed: "[Arrependimentos declarados]"

    counterfactual_analysis:
      what_if_scenario: "[O que teria acontecido se...]"
      missed_opportunities: "[Oportunidades perdidas por esta escolha]"
      alternate_timeline: "[Como vida seria diferente]"
      retrospective_evaluation: "[Como veem a decisão hoje]"

    evidence_documentation:
      source_decision_moment: "[Fonte que documenta a decisão]"
      source_execution: "[Fonte que documenta execução]"
      source_outcomes: "[Fonte que documenta resultados]"
      third_party_accounts: "[Relatos de terceiros]"
      confidence_level: "[Alto/Médio/Baixo]"
      gaps_identified: "[Informações que faltam]"
```

**DECISÕES CRÍTICAS OBRIGATÓRIAS (mínimo 15 decisões):**

**🎓 FORMAÇÃO E CARREIRA:**
- Escolha de universidade/curso (ou decisão de não ir)
- Mudanças de curso ou transferências
- Decisão de abandonar estudos
- Primeiro emprego significativo
- Primeiras demissões ou saídas
- Especializações ou cursos adicionais

**💼 EMPREENDEDORISMO E PROJETOS:**
- Primeiro projeto empreendedor
- Parcerias formadas e desfeitas
- Investimentos feitos ou recusados
- Mudanças radicais de direção profissional

** RELACIONAMENTOS FORMATIVOS:**
- Relacionamentos românticos sérios
- Amizades profundas formadas ou perdidas
- Mentores escolhidos e abandonados
- Redes profissionais cultivadas

**🏠 MUDANÇAS GEOGRÁFICAS:**
- Mudanças de cidade ou país
- Decisões de morar sozinho ou acompanhado
- Escolhas de bairro/estilo de vida

# ## 1.3 PERÍODO PROFISSIONAL E CONSOLIDAÇÃO (25+ anos)

```yaml
timeline_profissional:
  - when: "YYYY-MM-DD"
    milestone_type: "[Lançamento/Aquisição/IPO/Contratação/Demissão/Prêmio/Falência/etc]"

    pre_conditions:
      market_context: "[Estado do mercado/indústria]"
      personal_context: "[Situação pessoal na época]"
      resources_available:
        financial: "[Capital disponível]"
        human: "[Equipe/Network]"
        intellectual: "[Conhecimento/Patents]"
        social: "[Influência/Reputação]"
      competition_landscape: "[Quem eram os competidores]"

    preparation_phase:
      duration_planning: "[Quanto tempo planejando]"
      research_conducted: "[Pesquisa feita]"
      advisors_consulted: "[Quem consultaram]"
      tests_pilots: "[Testes ou pilots realizados]"
      funding_secured: "[Como financiaram]"
      team_assembled: "[Equipe montada]"

    execution_details:
      launch_strategy: "[Como executaram]"
      timeline_actual: "[Cronograma real vs planejado]"
      budget_actual: "[Orçamento real vs planejado]"
      pivots_made: "[Mudanças de rumo durante]"
      crises_managed: "[Crises enfrentadas]"
      lucky_breaks: "[Sorte que tiveram]"

    performance_metrics:
      quantitative_results:
        revenue: "[Receita gerada]"
        users_customers: "[Usuários/clientes alcançados]"
        market_share: "[Participação de mercado]"
        growth_rate: "[Taxa de crescimento]"
        roi_investors: "[Retorno para investidores]"

      qualitative_impact:
        industry_recognition: "[Prêmios/Reconhecimentos]"
        media_coverage: "[Cobertura de mídia]"
        competitor_reaction: "[Como competidores reagiram]"
        customer_feedback: "[Feedback dos clientes]"
        team_satisfaction: "[Satisfação da equipe]"

    post_mortem_analysis:
      factors_success:
        skill_based: "[Sucessos atribuídos à habilidade]"
        luck_based: "[Sucessos atribuídos à sorte]"
        timing_based: "[Sucessos atribuídos ao timing]"
        network_based: "[Sucessos atribuídos ao network]"

      factors_failure:
        skill_gaps: "[Falhas por falta de habilidade]"
        bad_luck: "[Falhas por azar]"
        poor_timing: "[Falhas por timing ruim]"
        execution_issues: "[Falhas na execução]"

      lessons_integration:
        declared_publicly: "[Lições que compartilharam]"
        applied_later: "[Lições aplicadas em projetos posteriores]"
        never_learned: "[Lições que nunca aprenderam]"

    ripple_effects:
      career_trajectory: "[Como afetou carreira posterior]"
      industry_influence: "[Como influenciou a indústria]"
      personal_brand: "[Como afetou reputação pessoal]"
      network_expansion: "[Como expandiu network]"
      wealth_creation: "[Impacto na situação financeira]"

    evidence_base:
      internal_documents: "[Documentos internos se disponíveis]"
      media_reports: "[Reportagens da época]"
      financial_filings: "[Documentos financeiros]"
      employee_accounts: "[Relatos de funcionários]"
      competitor_analysis: "[Análises de competidores]"
      academic_studies: "[Estudos acadêmicos sobre o caso]"
      confidence_score: "[1-10]"
```

# # PARTE 2: CASOS DETALHADOS DE SUCESSO E FRACASSO

# ## 2.1 SUCESSOS EXTRAORDINÁRIOS (mínimo 5 casos)

```yaml
sucesso_extraordinario:
  - titulo: "[Nome específico do projeto/conquista]"
    periodo_completo: "[YYYY-MM-DD início até YYYY-MM-DD fim]"

    contexto_pre_execucao:
      situacao_anterior:
        posicao_mercado: "[Onde estavam no mercado]"
        situacao_financeira: "[Estado financeiro]"
        reputacao_status: "[Como eram vistos]"
        equipe_recursos: "[Recursos humanos disponíveis]"

      ambiente_competitivo:
        principais_competidores: ["[Lista de competidores principais]"]
        barreiras_entrada: "[Dificuldades para entrar no mercado]"
        sabedoria_convencional: "[O que todos acreditavam ser verdade]"
        oportunidade_identificada: "[Lacuna que identificaram]"

    processo_decisorio:
      insight_inicial:
        momento_eureka: "[Quando/onde tiveram a ideia]"
        fonte_inspiracao: "[De onde veio a inspiração]"
        validacao_inicial: "[Como testaram a ideia]"

      analise_realizada:
        pesquisa_mercado: "[Pesquisa feita]"
        consultores_ouvidos: "[Especialistas consultados]"
        consultores_ignorados: "[Especialistas que ignoraram]"
        dados_coletados: "[Informações levantadas]"

      tomada_decisao:
        fatores_favor: "[Argumentos pró]"
        fatores_contra: "[Argumentos contra]"
        momento_decisao: "[Quando decidiram ir em frente]"
        tempo_deliberacao: "[Quanto tempo deliberaram]"

    execucao_masterclass:
      estrategia_adotada:
        approach_principal: "[Estratégia central]"
        diferenciais_criados: "[Como se diferenciaram]"
        recursos_mobilizados: "[Recursos alocados]"

      taticas_especificas:
        marketing_vendas: "[Como promoveram]"
        produto_desenvolvimento: "[Como desenvolveram]"
        operacoes: "[Como operaram]"
        financiamento: "[Como financiaram]"

      momentos_criticos:
        quase_falencias: "[Momentos que quase faliram]"
        breakthroughs: "[Momentos de breakthrough]"
        decisoes_corajosas: "[Decisões arriscadas que tomaram]"
        adaptacoes_inteligentes: "[Pivots bem-sucedidos]"

    resultados_mensurados:
      metricas_primarias:
        financeiro: "[Resultado financeiro específico]"
        mercado: "[Market share conquistado]"
        crescimento: "[Taxa de crescimento]"

      metricas_secundarias:
        usuarios_clientes: "[Base de usuários/clientes]"
        funcionarios: "[Equipe construída]"
        presenca_geografica: "[Expansão geográfica]"

      reconhecimento_externo:
        premios_industria: "[Prêmios recebidos]"
        cobertura_midia: "[Cobertura de mídia relevante]"
        cases_estudados: "[Virou case study onde]"
        imitacao_competidores: "[Competidores que imitaram]"

    impacto_transformacional:
      industria_mudou:
        novos_padroes: "[Padrões que estabeleceram]"
        competitors_reacao: "[Como competidores reagiram]"
        regulacao_mudou: "[Mudanças regulatórias causadas]"

      carreira_impacto:
        reputacao_nova: "[Como mudou reputação]"
        oportunidades_abertas: "[Novas oportunidades criadas]"
        network_expandido: "[Network que construíram]"

      legado_duravel:
        ainda_relevante: "[Se ainda é relevante hoje]"
        licoes_extraidas: "[Lições que viraram princípios]"
        influencia_posterior: "[Como influenciou trabalhos posteriores]"

    analise_pos_mortem:
      fatores_sucesso_honesta:
        habilidade_percentual: "[% atribuído à habilidade]"
        sorte_percentual: "[% atribuído à sorte]"
        timing_percentual: "[% atribuído ao timing]"
        network_percentual: "[% atribuído ao network]"

      declaracoes_vs_realidade:
        narrativa_publica: "[História que contam publicamente]"
        narrativa_privada: "[O que admitem privadamente]"
        narrativa_terceiros: "[O que terceiros dizem]"

      replicabilidade:
        podem_repetir: "[Acreditam que conseguiriam repetir?]"
        tentativas_repetir: "[Tentaram aplicar lições depois?]"
        sucessos_posteriores: "[Sucessos posteriores similares]"

    evidencias_robustas:
      fontes_primarias: "[Documentos/declarações da época]"
      fontes_secundarias: "[Análises e reportagens]"
      fontes_independentes: "[Verificação por terceiros]"
      lacunas_informacao: "[O que ainda não se sabe]"
      confidence_final: "[Alto/Médio/Baixo]"
```

# ## 2.2 FRACASSOS DOCUMENTADOS (mínimo 3 casos)

```yaml
fracasso_documentado:
  - titulo: "[Nome específico do projeto/decisão que falhou]"
    periodo_completo: "[YYYY-MM-DD início até YYYY-MM-DD término]"

    setup_para_falha:
      condicoes_iniciais:
        recursos_inadequados: "[Recursos insuficientes desde início]"
        conhecimento_gaps: "[Conhecimento que faltava]"
        timing_problematico: "[Problemas de timing]"
        equipe_inadequada: "[Problemas de equipe]"

      sinais_ignorados:
        alertas_recebidos: "[Avisos que receberam]"
        quem_alertou: "[Pessoas que alertaram]"
        por_que_ignoraram: "[Razão para ignorar alertas]"

      vieses_operando:
        confirmation_bias: "[Como confirmaram o que queriam acreditar]"
        sunk_cost: "[Investimento que não queriam perder]"
        overconfidence: "[Excesso de confiança onde]"

    descida_ao_fracasso:
      primeiros_problemas:
        quando_apareceram: "[Primeiros sinais de problema]"
        como_reagiram: "[Reação inicial]"
        escalacao_problemas: "[Como problemas se agravaram]"

      ponto_sem_volta:
        momento_exato: "[Quando ficou irreversível]"
        ultima_chance: "[Última oportunidade perdida]"
        decisao_fatal: "[Decisão que selou o destino]"

      tentativas_salvamento:
        estrategias_tentadas: "[O que tentaram para salvar]"
        recursos_adicionais: "[Recursos extras investidos]"
        pessoas_chamadas: "[Quem trouxeram para ajudar]"
        por_que_falharam: "[Por que tentativas não funcionaram]"

    impacto_destruicao:
      perdas_quantificadas:
        perda_financeira: "[Valor perdido específico]"
        tempo_desperdicado: "[Tempo investido perdido]"
        oportunidades_perdidas: "[Outras oportunidades que perderam]"

      danos_relacionais:
        equipe_perdida: "[Funcionários que saíram]"
        investidores_queimados: "[Investidores que perderam confiança]"
        parceiros_rompidos: "[Parcerias que terminaram]"

      danos_reputacionais:
        cobertura_negativa: "[Cobertura de mídia negativa]"
        industria_percepcao: "[Como indústria passou a ver]"
        credibilidade_perdida: "[Credibilidade específica perdida]"

    gestao_crise_narrativa:
      reacao_inicial:
        primeira_declaracao: "[Primeira declaração pública]"
        tom_adotado: "[Tom da comunicação]"
        estrategia_comunicacao: "[Estratégia de crisis comm]"

      evolucao_narrativa:
        culpados_apontados: "[Quem culparam inicialmente]"
        responsabilidade_assumida: "[O que assumiram como culpa]"
        fatores_externos: "[Fatores externos que culparam]"

      narrativa_final:
        historia_oficial: "[Versão final oficial]"
        admissoes_privadas: "[O que admitiram privadamente]"
        terceiros_contraditam: "[O que terceiros dizem realmente]"

    aprendizado_integracao:
      licoes_declaradas:
        publicamente_compartilhadas: "[Lições que compartilharam]"
        aplicacao_posterior: "[Como aplicaram depois]"
        mudancas_implementadas: "[Mudanças feitas em processos]"

      licoes_nao_aprendidas:
        erros_repetidos: "[Erros similares posteriores]"
        padroes_mantidos: "[Padrões destrutivos que mantiveram]"
        blind_spots_persistentes: "[Pontos cegos que continuaram]"

      trauma_resultante:
        areas_evitadas: "[Áreas que passaram a evitar]"
        decisoes_conservadoras: "[Decisões mais conservadoras depois]"
        relacionamentos_afetados: "[Como afetou relacionamentos]"

    evidencias_verificadas:
      documentacao_interna: "[Documentos internos se disponíveis]"
      reportagens_epoca: "[Reportagens da época do fracasso]"
      analises_independentes: "[Análises independentes]"
      relatos_funcionarios: "[Relatos de ex-funcionários]"
      dados_financeiros: "[Dados financeiros se públicos]"
      confidence_level: "[Alto/Médio/Baixo]"
```

# # PARTE 3: PONTOS DE INFLEXÃO E TRANSFORMAÇÃO

# ## 3.1 MOMENTOS DE INFLEXÃO DOCUMENTADOS

```yaml
pontos_inflexao:
  - momento_exato: "YYYY-MM-DD HH:MM (se conhecido)"
    tipo_evento: "[Encontro/Conversa/Leitura/Experiência/Crise/Oportunidade]"

    estado_anterior:
      trajetoria_vida: "[Para onde a vida estava indo]"
      identidade_dominante: "[Como se viam]"
      prioridades_estabelecidas: "[O que priorizavam]"
      relacionamentos_chave: "[Relacionamentos principais]"
      objetivos_declarados: "[Objetivos que tinham]"

    catalisador_mudanca:
      evento_trigger:
        descricao_completa: "[O que aconteceu exatamente]"
        participantes: "[Quem estava envolvido]"
        localizacao: "[Onde aconteceu]"
        duracao: "[Quanto tempo durou]"

      insight_gerado:
        realizacao_principal: "[Principal insight ou realização]"
        questoes_levantadas: "[Perguntas que surgiram]"
        contradicoes_expostas: "[Contradições que ficaram claras]"

    processo_transformacao:
      resistencia_inicial:
        negacao_evidencia: "[Como tentaram negar]"
        manutencao_status_quo: "[Tentativas de manter como estava]"
        medo_mudanca: "[Medos específicos sobre mudar]"

      aceitacao_gradual:
        primeiros_passos: "[Primeiras pequenas mudanças]"
        experimentos_feitos: "[Experimentos para testar nova direção]"
        feedback_recebido: "[Reações de outros às mudanças]"

      compromisso_total:
        momento_decisao: "[Quando se comprometeram totalmente]"
        acao_simbolica: "[Ação que simbolizou o compromisso]"
        pontes_queimadas: "[O que abandonaram definitivamente]"

    estado_posterior:
      nova_identidade: "[Como passaram a se ver]"
      novas_prioridades: "[O que passou a ser importante]"
      novos_relacionamentos: "[Novos relacionamentos formados]"
      novos_objetivos: "[Novos objetivos estabelecidos]"
      nova_trajetoria: "[Nova direção de vida]"

    validacao_mudanca:
      resultados_3_meses: "[Resultados em 3 meses]"
      resultados_1_ano: "[Resultados em 1 ano]"
      resultados_5_anos: "[Resultados em 5+ anos]"
      arrependimentos: "[Se expressaram arrependimento]"
      recomendacao_outros: "[Se recomendaram mudança similar para outros]"

    evidencia_suporte:
      relatos_primeira_pessoa: "[Relatos da própria pessoa]"
      observadores_proximos: "[Relatos de pessoas próximas]"
      mudancas_observaveis: "[Mudanças que terceiros notaram]"
      documentacao_epoca: "[Documentos da época da mudança]"
      confidence_assessment: "[Alto/Médio/Baixo]"
```

# # CHECKLIST DE QUALIDADE

# ## DENSIDADE FACTUAL MÍNIMA:
- [ ] Timeline Formativo: 25+ eventos específicos com datas
- [ ] Timeline Formação: 15+ decisões críticas documentadas
- [ ] Timeline Profissional: Todos os marcos principais da carreira
- [ ] Sucessos: 5+ casos com análise completa
- [ ] Fracassos: 3+ casos com análise post-mortem
- [ ] Inflexões: 5+ momentos transformacionais

# ## QUALIDADE DE EVIDÊNCIAS:
- [ ] Fontes Primárias: Citações diretas sempre que possível
- [ ] Triangulação: Mínimo 2 fontes independentes por fato crítico
- [ ] Confidence Scores: Atribuído para cada item
- [ ] Gaps Documentados: Admissão clara de informações faltantes

# ## ESPECIFICIDADE OPERACIONAL:
- [ ] Datas Exatas: Ano-mês-dia quando disponível
- [ ] Nomes Específicos: Pessoas, lugares, organizações
- [ ] Números Concretos: Valores, percentuais, quantidades
- [ ] Citações Literais: Palavras exatas quando possível

# ## ESTRUTURA YAML VÁLIDA:
- [ ] Sintaxe Perfeita: YAML parseable sem erros
- [ ] Hierarquia Consistente: Níveis de aninhamento corretos
- [ ] Campos Obrigatórios: Todos os campos principais preenchidos
- [ ] Formato Padronizado: Seguir exatamente os templates fornecidos

# # ALERTAS CRÍTICOS
- Arquivo mental_archaeology.md deve estar em analysis/ conforme OUTPUTS_GUIDE.md
- Tamanho: 4.000-6.000 palavras
- Estrutura: YAML + narrativa explicativa
- Validação: Verificar sintaxe YAML antes de entregar
- Todos os campos obrigatórios devem ser preenchidos
- Completude: Todos os campos obrigatórios preenchidos
- Precisão: Datas e fatos verificados em múltiplas fontes
- Consistência: Cronologia coerente sem contradições
- Profundidade: Análise vai além de fatos superficiais
- Evidências: Cada afirmação tem fonte e confidence level