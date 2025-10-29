# FRAGMENT VALIDATION CHECKLIST
# Checklist Rápido de Validação de Qualidade

version: "1.0"
last_updated: "2025-01-26"

# =============================================================================
# COMO USAR ESTE CHECKLIST
# =============================================================================

# 1. Use ANTES de salvar cada fragmento
# 2. Marque [X] para itens aprovados
# 3. Se < 80% aprovado, revisar fragmento
# 4. Campos marcados com ⚠️ são CRÍTICOS
# 5. Campos marcados com ⭐ melhoram muito a qualidade

# =============================================================================
# CHECKLIST PRINCIPAL - USE PARA CADA FRAGMENTO
# =============================================================================

validation_checklist:
  
  section_1_identification:
    title: "1. IDENTIFICAÇÃO"
    items:
      - id: ID_001
        check: "Fragment ID único e sequencial?"
        critical: true
        marker: "⚠️"
        example: "FRAG_BIO_001 (não FRAG_001 ou BIO_001)"
      
      - id: ID_002
        check: "Data/hora de criação no formato ISO 8601?"
        critical: true
        marker: "⚠️"
        example: "2025-01-26T14:23:00Z"
      
      - id: ID_003
        check: "Researcher ID registrado?"
        critical: false
        marker: "⭐"
  
  section_2_classification:
    title: "2. CLASSIFICAÇÃO"
    items:
      - id: CLS_001
        check: "Categoria principal escolhida e justificada?"
        critical: true
        marker: "⚠️"
        validation: "BIO|COG|COM|BEH|VAL|SOC|META|VAL_SRC"
      
      - id: CLS_002
        check: "Subcategoria apropriada para a categoria?"
        critical: true
        marker: "⚠️"
        example: "Para BIO: origem_familia, infancia_adolescencia, etc"
      
      - id: CLS_003
        check: "Tipo de conteúdo correto?"
        critical: true
        marker: "⚠️"
        validation: "QUOTE|PARA|DESC|EXAMPLE|PATTERN|ANECDOTE|ANALYSIS|SYNTHESIS"
        rule: "Se tem aspas = QUOTE. Se múltiplas fontes = SYNTHESIS"
      
      - id: CLS_004
        check: "Depth level faz sentido para o conteúdo?"
        critical: true
        marker: "⚠️"
        rule: "Fatos básicos = SURFACE. Filosofia = DEEP/CORE"
      
      - id: CLS_005
        check: "Specificity avaliada honestamente?"
        critical: false
        marker: "⭐"
        question: "Só essa pessoa fala assim? = SIGNATURE/UNIQUE"
  
  section_3_protocol_mapping:
    title: "3. VINCULAÇÃO COM PROTOCOLO"
    items:
      - id: PRT_001
        check: "Module ID correto para a categoria?"
        critical: true
        marker: "⚠️"
        mapping:
          BIO: M1
          COG: M2
          COM: M3
          BEH: M4
          VAL: M5
          SOC: M6
          META: M7
          VAL_SRC: M8
      
      - id: PRT_002
        check: "Question ID especificado?"
        critical: true
        marker: "⚠️"
        example: "M2.Q3"
      
      - id: PRT_003
        check: "Question code incluído?"
        critical: true
        marker: "⚠️"
        example: "2.3_tomada_decisao"
      
      - id: PRT_004
        check: "Required elements mapeados?"
        critical: false
        marker: "⭐"
        benefit: "Ajuda a rastrear cobertura"
  
  section_4_source:
    title: "4. FONTE"
    items:
      - id: SRC_001
        check: "Source ID único e registrado?"
        critical: true
        marker: "⚠️"
        format: "SRC_### (3 dígitos)"
      
      - id: SRC_002
        check: "Source type apropriado?"
        critical: true
        marker: "⚠️"
        options: "interview|podcast|video|book|article|social_media|lecture|conversation"
      
      - id: SRC_003
        check: "Título da fonte informado?"
        critical: true
        marker: "⚠️"
      
      - id: SRC_004
        check: "URL incluída (se disponível)?"
        critical: false
        marker: "⭐"
      
      - id: SRC_005
        check: "Data da fonte (se conhecida)?"
        critical: false
        marker: "⭐"
        benefit: "Permite análise temporal"
      
      - id: SRC_006
        check: "Medium especificado?"
        critical: true
        marker: "⚠️"
        options: "text|audio|video|image"
      
      - id: SRC_007
        check: "Language code correto?"
        critical: true
        marker: "⚠️"
        format: "ISO 639-1 (pt, en, es, fr)"
      
      - id: SRC_008
        check: "Source quality avaliada?"
        critical: true
        marker: "⚠️"
        options: "PRIMARY|SECONDARY|TERTIARY"
        rule: "Pessoa falando/escrevendo = PRIMARY"
  
  section_5_location:
    title: "5. LOCALIZAÇÃO NO MATERIAL"
    items:
      - id: LOC_001
        check: "Tipo de localização especificado?"
        critical: true
        marker: "⚠️"
        options: "page|timestamp|paragraph|section|chapter|line"
      
      - id: LOC_002
        check: "Valor de localização preciso?"
        critical: true
        marker: "⚠️"
        examples:
          page: "p. 145"
          timestamp: "01:15:32-01:17:45"
          paragraph: "Section 3, paragraph 2"
      
      - id: LOC_003
        check: "Direct link fornecido (se possível)?"
        critical: false
        marker: "⭐"
        benefit: "Verificação rápida"
  
  section_6_content:
    title: "6. CONTEÚDO"
    items:
      - id: CNT_001
        check: "Content type corresponde ao classification.content_type?"
        critical: true
        marker: "⚠️"
        rule: "Devem ser idênticos"
      
      - id: CNT_002
        check: "Text preenchido e não-vazio?"
        critical: true
        marker: "⚠️"
        min_length: "10 palavras"
      
      - id: CNT_003
        check: "Language code especificado?"
        critical: true
        marker: "⚠️"
      
      - id: CNT_004
        check: "Se QUOTE: tem aspas e é exato?"
        critical: true
        marker: "⚠️"
        rule: "QUOTE = palavra por palavra"
      
      - id: CNT_005
        check: "Se traduzido: original_text preservado?"
        critical: false
        marker: "⭐"
      
      - id: CNT_006
        check: "Word count calculado?"
        critical: false
        marker: "⭐"
  
  section_7_context:
    title: "7. CONTEXTO"
    items:
      - id: CTX_001
        check: "Before/during/after preenchidos?"
        critical: false
        marker: "⭐"
        benefit: "Contexto aumenta valor do fragmento"
      
      - id: CTX_002
        check: "Situation descrita?"
        critical: false
        marker: "⭐"
        examples: "entrevista|palestra|casual|debate"
      
      - id: CTX_003
        check: "Audience identificada?"
        critical: false
        marker: "⭐"
      
      - id: CTX_004
        check: "Tone caracterizado?"
        critical: false
        marker: "⭐"
      
      - id: CTX_005
        check: "Trigger capturado (se relevante)?"
        critical: false
        marker: "⭐"
  
  section_8_insights:
    title: "8. INSIGHTS"
    items:
      - id: INS_001
        check: "Pelo menos 1 insight extraído?"
        critical: true
        marker: "⚠️"
        min: 1
        recommended: 3
      
      - id: INS_002
        check: "Insights são INSIGHTS (não resumos)?"
        critical: true
        marker: "⚠️"
        rule: "Insight = interpretação/implicação, não reafirmação"
        bad_example: "Pedro nasceu em Maricá"
        good_example: "Mudanças frequentes na infância podem ter criado adaptabilidade"
      
      - id: INS_003
        check: "Insights são acionáveis para o clone?"
        critical: false
        marker: "⭐"
        question: "O clone pode usar isso para responder melhor?"
  
  section_9_quality_metrics:
    title: "9. MÉTRICAS DE QUALIDADE"
    items:
      - id: QMT_001
        check: "Relevance avaliada (1-10)?"
        critical: true
        marker: "⚠️"
        question: "Quão importante para entender a pessoa?"
      
      - id: QMT_002
        check: "Specificity avaliada (1-10)?"
        critical: true
        marker: "⚠️"
        question: "Quão específico/único desta pessoa?"
      
      - id: QMT_003
        check: "Authenticity avaliada (1-10)?"
        critical: true
        marker: "⚠️"
        question: "Quão autêntica é a fonte?"
      
      - id: QMT_004
        check: "Verifiability avaliada (1-10)?"
        critical: true
        marker: "⚠️"
        question: "Quão fácil de verificar?"
      
      - id: QMT_005
        check: "Overall calculado como média?"
        critical: true
        marker: "⚠️"
        formula: "mean([relevance, specificity, authenticity, verifiability])"
      
      - id: QMT_006
        check: "Overall >= 6.0?"
        critical: true
        marker: "⚠️"
        threshold: 6.0
        action_if_no: "Revisar ou descartar fragmento"
  
  section_10_confidence:
    title: "10. CONFIANÇA"
    items:
      - id: CNF_001
        check: "Confidence calculada (0.0-1.0)?"
        critical: true
        marker: "⚠️"
      
      - id: CNF_002
        check: "Confidence >= 0.40?"
        critical: true
        marker: "⚠️"
        threshold: 0.40
        action_if_no: "Marcar para validação"
      
      - id: CNF_003
        check: "Confidence corresponde à source quality?"
        critical: false
        marker: "⭐"
        rule:
          PRIMARY: ">= 0.70"
          SECONDARY: ">= 0.60"
          TERTIARY: ">= 0.50"
  
  section_11_verification:
    title: "11. VERIFICAÇÃO"
    items:
      - id: VRF_001
        check: "Cross-referenced marcado?"
        critical: false
        marker: "⭐"
        benefit: "Indica se foi verificado contra outras fontes"
      
      - id: VRF_002
        check: "Se cross_referenced=true: alternative_sources listadas?"
        critical: false
        marker: "⭐"
      
      - id: VRF_003
        check: "Contradictions documentadas (se houver)?"
        critical: true
        marker: "⚠️"
        rule: "Se detectou contradição, DEVE documentar"
  
  section_12_keywords_tags:
    title: "12. KEYWORDS E TAGS"
    items:
      - id: KWT_001
        check: "Pelo menos 2 keywords?"
        critical: true
        marker: "⚠️"
        min: 2
        max: 15
      
      - id: KWT_002
        check: "Keywords são substantivos/conceitos?"
        critical: false
        marker: "⭐"
        bad: "fazer|ser|ter"
        good: "decisão|liderança|filosofia"
      
      - id: KWT_003
        check: "Pelo menos 1 tag?"
        critical: true
        marker: "⚠️"
        min: 1
        max: 20
      
      - id: KWT_004
        check: "Tags seguem taxonomia?"
        critical: false
        marker: "⭐"
        reference: "Ver tag_taxonomy em fragment_taxonomy.yaml"
  
  section_13_flags:
    title: "13. FLAGS (se aplicável)"
    items:
      - id: FLG_001
        check: "Se baixa qualidade/confiança: needs_followup=true?"
        critical: false
        marker: "⭐"
      
      - id: FLG_002
        check: "Se contradiz outras fontes: flag marcada?"
        critical: true
        marker: "⚠️"
      
      - id: FLG_003
        check: "Se é conteúdo excepcional: exceptional_quality=true?"
        critical: false
        marker: "⭐"
      
      - id: FLG_004
        check: "Se é conteúdo assinatura: signature_content=true?"
        critical: false
        marker: "⭐"
        benefit: "Facilita identificar fragmentos mais importantes"

# =============================================================================
# QUICK CHECK - VERSÃO RÁPIDA (30 segundos)
# =============================================================================

quick_check:
  title: "QUICK VALIDATION (30s)"
  description: "Use quando tem muitos fragmentos para validar rapidamente"
  
  critical_only:
    - "[ ] Fragment ID único e correto formato"
    - "[ ] Data/hora ISO 8601"
    - "[ ] Categoria + subcategoria preenchidas"
    - "[ ] Content type correto"
    - "[ ] Source ID e quality"
    - "[ ] Content.text não-vazio (>10 palavras)"
    - "[ ] Pelo menos 1 insight"
    - "[ ] Quality metrics calculadas"
    - "[ ] Overall >= 6.0"
    - "[ ] Confidence >= 0.40"
    - "[ ] Pelo menos 2 keywords"
    - "[ ] Pelo menos 1 tag"
  
  pass_threshold: "10/12 (83%)"

# =============================================================================
# QUALITY GATES - PORTÕES DE QUALIDADE
# =============================================================================

quality_gates:
  
  gate_1_minimum_viable:
    name: "Minimum Viable Fragment"
    description: "Mínimo aceitável para salvar"
    requirements:
      - "Todos os campos críticos (⚠️) preenchidos"
      - "Overall >= 6.0"
      - "Confidence >= 0.40"
      - "Pelo menos 1 insight"
    pass_rate_required: "100%"
  
  gate_2_good_quality:
    name: "Good Quality Fragment"
    description: "Fragmento de boa qualidade"
    requirements:
      - "Passa gate_1"
      - "Overall >= 7.0"
      - "Confidence >= 0.70"
      - "Contexto preenchido (3+ campos)"
      - "Cross-referenced ou verifiable"
      - "Pelo menos 2 insights"
    pass_rate_required: "100%"
  
  gate_3_exceptional:
    name: "Exceptional Fragment"
    description: "Fragmento excepcional"
    requirements:
      - "Passa gate_2"
      - "Overall >= 8.5"
      - "Confidence >= 0.85"
      - "Specificity >= SIGNATURE"
      - "Cross-referenced com 2+ sources"
      - "3+ insights de alta qualidade"
      - "Contexto completo (5+ campos)"
    pass_rate_required: "100%"

# =============================================================================
# COMMON MISTAKES - ERROS COMUNS
# =============================================================================

common_mistakes:
  
  mistake_1:
    error: "Confundir categoria"
    example: "Colocar 'como pensa' em BEH em vez de COG"
    fix: "Use árvore de decisão do practical_guide.md"
  
  mistake_2:
    error: "QUOTE sem aspas ou não-literal"
    example: "content_type=QUOTE mas texto parafraseado"
    fix: "Se não é palavra-por-palavra, use PARA"
  
  mistake_3:
    error: "Insights são resumos, não insights"
    example: "Pedro nasceu em Maricá" como insight"
    fix: "Insight = implicação/interpretação: 'Múltiplas mudanças criaram adaptabilidade'"
  
  mistake_4:
    error: "Overall não é média"
    example: "Overall=8 mas métricas são 5,6,7,9"
    fix: "Overall deve ser exatamente mean([metrics])"
  
  mistake_5:
    error: "Confidence muito alta para fonte fraca"
    example: "TERTIARY source com confidence=0.95"
    fix: "Terciária raramente passa de 0.70"
  
  mistake_6:
    error: "Keywords são verbos ou genéricos"
    example: "fazer|ser|coisa|importante"
    fix: "Use substantivos específicos: decisão|startup|filosofia"
  
  mistake_7:
    error: "Faltar localização precisa"
    example: "location.value = 'no meio do vídeo'"
    fix: "Seja preciso: '01:15:30-01:17:45'"
  
  mistake_8:
    error: "Source ID inconsistente"
    example: "Usar SRC_1, SRC_01, SRC_001 alternadamente"
    fix: "Sempre 3 dígitos: SRC_001"
  
  mistake_9:
    error: "Não documentar contradições"
    example: "Vê contradição mas não preenche campo"
    fix: "SEMPRE documente em contradictions array"
  
  mistake_10:
    error: "Overall < 6.0 mas salva mesmo assim"
    example: "Overall=5.2 mas 'vou melhorar depois'"
    fix: "Ou melhora AGORA ou descarta"

# =============================================================================
# AUTOMATED VALIDATION RULES
# =============================================================================

automated_rules:
  title: "Regras que podem ser verificadas programaticamente"
  
  rules:
    - rule_id: "AUTO_001"
      check: "fragment_id matches pattern 'FRAG_[A-Z]+_[0-9]{3}'"
      severity: "error"
    
    - rule_id: "AUTO_002"
      check: "created_at is valid ISO 8601 datetime"
      severity: "error"
    
    - rule_id: "AUTO_003"
      check: "classification.primary_category in allowed_values"
      severity: "error"
    
    - rule_id: "AUTO_004"
      check: "classification.content_type == content.type"
      severity: "error"
    
    - rule_id: "AUTO_005"
      check: "source.quality in ['PRIMARY', 'SECONDARY', 'TERTIARY']"
      severity: "error"
    
    - rule_id: "AUTO_006"
      check: "quality_metrics.overall == mean(metrics)"
      tolerance: 0.1
      severity: "error"
    
    - rule_id: "AUTO_007"
      check: "quality_metrics.overall >= 6.0"
      severity: "warning"
    
    - rule_id: "AUTO_008"
      check: "confidence >= 0.40"
      severity: "warning"
    
    - rule_id: "AUTO_009"
      check: "len(keywords) >= 2"
      severity: "error"
    
    - rule_id: "AUTO_010"
      check: "len(tags) >= 1"
      severity: "error"
    
    - rule_id: "AUTO_011"
      check: "len(insights) >= 1"
      severity: "error"
    
    - rule_id: "AUTO_012"
      check: "word_count(content.text) >= 10"
      severity: "warning"

# =============================================================================
# SCORING SYSTEM
# =============================================================================

scoring_system:
  
  calculation:
    critical_items: 32
    recommended_items: 18
    total_items: 50
    
    score_formula: |
      critical_score = (critical_passed / 32) * 100
      recommended_score = (recommended_passed / 18) * 100
      
      if critical_score < 100:
        final_score = critical_score * 0.5  # Penalidade severa
      else:
        final_score = critical_score * 0.7 + recommended_score * 0.3
  
  grades:
    A_plus:
      range: "95-100"
      label: "Exceptional"
      action: "Salvar e marcar como signature"
    
    A:
      range: "85-94"
      label: "Excellent"
      action: "Salvar com confiança"
    
    B:
      range: "75-84"
      label: "Good"
      action: "Salvar"
    
    C:
      range: "65-74"
      label: "Acceptable"
      action: "Salvar mas revisar depois"
    
    D:
      range: "50-64"
      label: "Poor"
      action: "Melhorar antes de salvar"
    
    F:
      range: "0-49"
      label: "Fail"
      action: "Não salvar - descartar ou refazer"

# =============================================================================
# BATCH VALIDATION WORKFLOW
# =============================================================================

batch_validation:
  title: "Validando múltiplos fragmentos de uma vez"
  
  workflow:
    step_1:
      action: "Rodar automated_rules em todos"
      tool: "Script de validação"
      output: "Lista de erros críticos"
    
    step_2:
      action: "Revisar erros críticos"
      focus: "Corrigir todos os AUTO errors"
    
    step_3:
      action: "Quick check em cada fragmento"
      time: "30s por fragmento"
      focus: "Critical items (⚠️)"
    
    step_4:
      action: "Spot check detalhado"
      sample: "10-20% dos fragmentos"
      focus: "Full checklist completo"
    
    step_5:
      action: "Calcular métricas gerais"
      metrics:
        - "Average overall quality"
        - "Average confidence"
        - "% passing each gate"
        - "Common issues"

# =============================================================================
# FINAL TIPS
# =============================================================================

final_tips:
  - "Valide ENQUANTO cria, não depois de 100 fragmentos"
  - "Use templates - reduz erros em 70%"
  - "Automatize o que puder (scripts, checklists digitais)"
  - "Foque em QUALIDADE, não quantidade"
  - "Um fragmento EXCEPTIONAL vale 10 medianos"
  - "Se em dúvida sobre incluir: inclua e marque needs_followup"
  - "Revise seus primeiros 20 fragmentos depois de 1 semana"
  - "Peça review de outro pesquisador periodicamente"
  - "Crie métricas do SEU processo (tempo por fragmento, taxa de erro, etc)"
  - "Itere e melhore seu processo continuamente"

# =============================================================================
# FIM DO CHECKLIST
# =============================================================================
