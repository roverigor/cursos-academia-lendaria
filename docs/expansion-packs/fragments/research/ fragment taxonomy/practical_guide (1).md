# GUIA PRÁTICO DE USO DA TAXONOMIA
# Como Aplicar a Taxonomia de Fragmentos na Prática

version: "1.0"
audience: "Researchers, Analysts, Detective Agents"
last_updated: "2025-01-26"

# =============================================================================
# 1. QUICK START GUIDE
# =============================================================================

## Passo 1: Identificar o Tipo de Material

Quando receber um novo material (transcrição, artigo, vídeo), identifique:

```yaml
# CHECKLIST DE IDENTIFICAÇÃO
material_assessment:
  - [ ] Qual é a fonte? (SRC_ID)
  - [ ] É fonte primária, secundária ou terciária?
  - [ ] Qual o meio? (texto, áudio, vídeo)
  - [ ] Qual a data?
  - [ ] Qual o contexto? (entrevista, palestra, casual)
  - [ ] Qual o público-alvo?
  - [ ] Quanto de conteúdo? (palavras, duração)
```

## Passo 2: Ler/Assistir com Intenção

Use o **Protocolo de Interrogação** como guia:

```yaml
reading_strategy:
  pass_1_scan:
    objetivo: "Identificar áreas relevantes"
    método: "Skim rápido marcando seções"
    tempo: "10% do tempo total"
  
  pass_2_deep_read:
    objetivo: "Extrair fragmentos detalhados"
    método: "Leitura profunda + anotações"
    tempo: "60% do tempo total"
  
  pass_3_synthesis:
    objetivo: "Identificar padrões e gaps"
    método: "Revisão + conexões"
    tempo: "30% do tempo total"
```

## Passo 3: Criar Fragmentos

Para cada insight/informação relevante:

```yaml
fragment_creation_workflow:
  1_identify:
    - "Isso responde alguma pergunta do protocolo?"
    - "É específico o suficiente?"
    - "É verificável?"
  
  2_extract:
    - "Copiar texto exato (quote) ou parafrasear?"
    - "Qual o contexto antes/durante/depois?"
    - "Onde exatamente está? (localização)"
  
  3_classify:
    - "Categoria principal? (BIO, COG, COM, BEH, VAL, SOC, META)"
    - "Tipo de conteúdo? (QUOTE, PARA, PATTERN, etc)"
    - "Nível de profundidade? (SURFACE, DEEP, CORE)"
  
  4_enrich:
    - "Quais insights posso extrair?"
    - "Que padrões isso ilustra?"
    - "Relaciona com outros fragmentos?"
  
  5_validate:
    - "Qual minha confiança? (0.0-1.0)"
    - "Métricas de qualidade? (1-10)"
    - "Precisa validação cruzada?"
```

# =============================================================================
# 2. DECISION TREES - COMO CLASSIFICAR
# =============================================================================

## Árvore de Decisão: CATEGORIA PRINCIPAL

```
Pergunta: "Este fragmento é sobre...?"

├─ História de vida, background, formação?
│  └─ CATEGORIA: BIO (Biographical)
│
├─ Como a pessoa PENSA ou DECIDE?
│  └─ CATEGORIA: COG (Cognitive)
│
├─ Como a pessoa SE COMUNICA?
│  └─ CATEGORIA: COM (Communicative)
│
├─ Comportamentos, rotinas, ações observáveis?
│  └─ CATEGORIA: BEH (Behavioral)
│
├─ Valores, crenças, princípios, ética?
│  └─ CATEGORIA: VAL (Values & Beliefs)
│
├─ Relacionamentos, influências, dinâmicas sociais?
│  └─ CATEGORIA: SOC (Social)
│
├─ Contradições, evolução, padrões internos?
│  └─ CATEGORIA: META (Meta-cognitive)
│
└─ Validação de citações, obras, fatos conhecidos?
   └─ CATEGORIA: VAL_SRC (Source Validation)
```

## Árvore de Decisão: TIPO DE CONTEÚDO

```
Pergunta: "Como esse conteúdo foi obtido?"

├─ São as palavras EXATAS da pessoa?
│  └─ TIPO: QUOTE (Direct Quote)
│
├─ Mesma ideia mas com minhas palavras?
│  └─ TIPO: PARA (Paraphrase)
│
├─ Alguém DESCREVENDO a pessoa?
│  └─ TIPO: DESC (Description)
│
├─ Um CASO ou SITUAÇÃO específica?
│  └─ TIPO: EXAMPLE ou ANECDOTE
│
├─ Observei isso MÚLTIPLAS VEZES?
│  └─ TIPO: PATTERN
│
├─ Estou ANALISANDO o que observei?
│  └─ TIPO: ANALYSIS
│
└─ COMBINANDO várias fontes?
   └─ TIPO: SYNTHESIS
```

## Árvore de Decisão: CONFIANÇA

```
Calcular confiança (0.0 - 1.0):

1. FONTE (40%)
   ├─ Primária (pessoa falando/escrevendo) = 1.0
   ├─ Secundária (fonte confiável sobre) = 0.8
   └─ Terciária (compilação) = 0.6

2. VERIFICABILIDADE (30%)
   ├─ Diretamente verificável = 1.0
   ├─ Corroborado por múltiplas fontes = 0.9
   ├─ Inferido com boa base = 0.6
   └─ Apenas alegado = 0.4

3. CONSISTÊNCIA (20%)
   ├─ Consistente com todo corpus = 1.0
   ├─ Consistente com maioria = 0.8
   ├─ Algumas inconsistências = 0.6
   └─ Contraditório = 0.3

4. ESPECIFICIDADE (10%)
   ├─ Altamente específico = 1.0
   ├─ Característico = 0.8
   ├─ Genérico = 0.5

FÓRMULA:
confidence = (fonte*0.4) + (verif*0.3) + (consist*0.2) + (espec*0.1)
```

# =============================================================================
# 3. TEMPLATES PRÁTICOS POR TIPO
# =============================================================================

## Template 1: Fragmento Biográfico (QUOTE)

```yaml
# EXEMPLO: Origem familiar de Pedro Valério
fragment_id: FRAG_BIO_001
created_at: 2025-01-26T14:00:00Z

classification:
  primary_category: BIO
  subcategory: origem_familia
  content_type: QUOTE
  depth_level: SURFACE
  specificity: CHARACTERISTIC

protocol_mapping:
  module_id: M1
  question_id: M1.Q1
  question_code: 1.1_vida_completa
  required_elements_covered: 
    - "Infância e família de origem"

source:
  source_id: SRC_001
  source_type: interview
  title: "Entrevista com Nicolas Oalani"
  date: 2024-01-01
  medium: text
  language: pt
  quality: PRIMARY

location:
  type: paragraph
  value: "Início da conversa, primeiras respostas"

content:
  type: QUOTE
  text: |
    "Vamos lá, eu nasci em Maricá, mas eu passei pouco tempo lá, 
    só até os dois anos de idade. Lá eu morava com minha mãe, 
    meu pai, meu irmão mais velho."
  language: pt

context:
  before: "Pergunta sobre origem e história de vida"
  during: "Descrevendo origens familiares"
  after: "Continua narrando mudanças geográficas"
  situation: "Entrevista biográfica"
  tone: "Casual, narrativo"

insights:
  - "Nascimento em Maricá (RJ)"
  - "Família nuclear inicial: pai, mãe, irmão mais velho"
  - "Tempo curto na cidade natal (2 anos)"
  - "Múltiplas mudanças desde cedo"

quality_metrics:
  relevance: 9
  specificity: 8
  authenticity: 10
  verifiability: 8
  overall: 8.75

confidence: 0.95

keywords:
  - origem
  - maricá
  - família
  - infância

tags:
  - origem
  - família_nuclear
  - maricá
  - infância

flags:
  signature_content: false
  needs_followup: false
```

## Template 2: Padrão Cognitivo (PATTERN)

```yaml
# EXEMPLO: Padrão de decisão de Naval Ravikant
fragment_id: FRAG_COG_045
created_at: 2025-01-26T15:30:00Z

classification:
  primary_category: COG
  subcategory: tomada_decisao
  content_type: PATTERN
  depth_level: CORE
  specificity: SIGNATURE

protocol_mapping:
  module_id: M2
  question_id: M2.Q3
  question_code: 2.3_tomada_decisao
  required_elements_covered:
    - "Processo de decisão"
    - "Papel da intuição vs análise"

source:
  source_id: SRC_SYNTH_01
  source_type: synthesis
  title: "Síntese de 5 entrevistas sobre decisão"
  quality: PRIMARY
  language: en

content:
  type: PATTERN
  text: |
    PADRÃO IDENTIFICADO: Decisão como Reconhecimento
    
    Através de 5+ observações, Naval consistentemente descreve 
    decisões importantes não como eventos pontuais de escolha, 
    mas como processos de reconhecimento consciente de decisões 
    já tomadas subconscientemente através de acumulação gradual 
    de evidências ao longo do tempo.
    
    Variações observadas:
    - "I don't make decisions, I notice when I've already made them"
    - "By the time I decide, it's obvious"
    - "Good decisions don't feel like decisions"
    - "Decision is recognition, not creation"
  language: en

context:
  situation: "Padrão observado em múltiplos contextos"
  frequency: "Sempre que perguntado sobre decisão importante"

insights:
  - "Decisões como processos inconscientes contínuos"
  - "Consciência apenas reconhece, não cria decisão"
  - "Acumulação gradual é superior a análise pontual"
  - "Boas decisões se tornam óbvias naturalmente"
  - "Rejeição de modelo tradicional de 'tomada de decisão'"

patterns_identified:
  - pattern_id: COG_001
    pattern_name: "Subconscious Processing"
    confidence: 0.95
  - pattern_id: COG_003
    pattern_name: "Evidence Accumulation"
    confidence: 0.92

quality_metrics:
  relevance: 10
  specificity: 10
  authenticity: 9
  verifiability: 9
  clarity: 9
  uniqueness: 10
  overall: 9.5

confidence: 0.92

verification:
  cross_referenced: true
  alternative_sources:
    - source_id: SRC_012
      match_type: identical
    - source_id: SRC_015
      match_type: similar
    - source_id: SRC_022
      match_type: corroborates

keywords:
  - decision_making
  - subconscious
  - pattern
  - evidence
  - recognition

tags:
  - decision_making
  - cognitive_process
  - signature_pattern
  - core_philosophy

flags:
  exceptional_quality: true
  signature_content: true
```

## Template 3: Análise de Contradição (META)

```yaml
# EXEMPLO: Evolução de pensamento
fragment_id: FRAG_META_007
created_at: 2025-01-26T16:00:00Z

classification:
  primary_category: META
  subcategory: evolucoes_pensamento
  content_type: ANALYSIS
  depth_level: DEEP
  specificity: CHARACTERISTIC

protocol_mapping:
  module_id: M7
  question_id: M7.Q1
  question_code: 7.1_contradicoes
  required_elements_covered:
    - "Contradições aparentes"
    - "Evolução ao longo do tempo"

source:
  source_id: SRC_ANALYSIS_01
  source_type: analysis
  title: "Análise de evolução 2010-2024"
  quality: SECONDARY

content:
  type: ANALYSIS
  text: |
    ANÁLISE DE CONTRADIÇÃO APARENTE:
    
    Em 2010, a pessoa consistentemente defendia "work hard, hustle 24/7".
    Em 2024, mesma pessoa defende "work smart, rest is productive".
    
    Esta não é uma contradição, mas evolução documentável:
    
    2010-2015: Fase de construção, necessidade de volume
    2015-2018: Burnout e reflexão
    2018-2020: Experimentação com novos métodos
    2020-2024: Síntese madura
    
    A pessoa não contradiz o passado, mas integra aprendizado.
    O núcleo (resultado importa) permanece, método evoluiu.

insights:
  - "Aparente contradição é na verdade evolução"
  - "Núcleo filosófico permanece consistente"
  - "Métodos adaptam-se com experiência"
  - "Pessoa capaz de revisar posições com dados"

contradictions:
  - fragment_id: FRAG_BEH_023
    nature: "posição sobre trabalho"
    severity: moderate
    resolution: "evolução temporal, não contradição real"

quality_metrics:
  relevance: 9
  specificity: 8
  authenticity: 8
  verifiability: 9
  overall: 8.5

confidence: 0.82

tags:
  - evolução_pensamento
  - work_life_balance
  - growth_mindset
  - temporal_analysis

flags:
  needs_followup: false
  exceptional_quality: true
```

# =============================================================================
# 4. WORKFLOWS POR TIPO DE MATERIAL
# =============================================================================

## Workflow A: Processar Transcrição de Entrevista (2h)

```yaml
workflow: "interview_processing"
input: "2h interview transcript (6000+ words)"
estimated_time: "4-6 hours"

steps:
  
  step_1_preparation:
    duration: 30min
    actions:
      - "Criar registro de fonte (SRC_XXX)"
      - "Ler protocolo para esta pessoa"
      - "Identificar módulos prioritários"
      - "Preparar templates de fragmentos"
  
  step_2_first_pass:
    duration: 45min
    actions:
      - "Leitura completa da transcrição"
      - "Marcar seções relevantes"
      - "Identificar ~20-30 pontos de extração"
      - "Notar padrões gerais"
  
  step_3_extraction:
    duration: 2-3h
    actions:
      - "Extrair fragmentos detalhados"
      - "Para cada ponto marcado:"
      - "  - Copiar quote ou parafrasear"
      - "  - Classificar (categoria, tipo, etc)"
      - "  - Adicionar contexto"
      - "  - Extrair insights"
      - "  - Calcular métricas"
      - "Target: 15-25 fragmentos de qualidade"
  
  step_4_synthesis:
    duration: 1h
    actions:
      - "Identificar padrões entre fragmentos"
      - "Buscar contradições"
      - "Cross-referenciar com fragmentos existentes"
      - "Criar 2-3 synthesis fragments"
  
  step_5_validation:
    duration: 30min
    actions:
      - "Revisar cada fragmento"
      - "Verificar qualidade mínima (>6.0)"
      - "Confirmar confiança adequada (>0.6)"
      - "Salvar na biblioteca"

output:
  fragments_created: 15-25
  patterns_identified: 2-5
  gaps_identified: 3-10
  coverage_improvement: "+5-15%"
```

## Workflow B: Processar Livro (200 páginas)

```yaml
workflow: "book_processing"
input: "Book (200 pages, ~60k words)"
estimated_time: "20-30 hours"

strategy: "Parallel extraction by chapter"

steps:
  
  step_1_reconnaissance:
    duration: 2h
    actions:
      - "Ler índice e introdução"
      - "Identificar capítulos mais relevantes"
      - "Mapear para módulos do protocolo"
      - "Priorizar 10-15 capítulos principais"
  
  step_2_chapter_processing:
    duration: 1.5h per chapter
    repeat: 10-15 times
    actions:
      - "Ler capítulo completo"
      - "Extrair 3-8 fragmentos por capítulo"
      - "Identificar quotes principais"
      - "Mapear conceitos-chave"
  
  step_3_cross_chapter_synthesis:
    duration: 4h
    actions:
      - "Identificar temas recorrentes"
      - "Criar sínteses temáticas"
      - "Mapear evolução de ideias"
      - "Identificar núcleo filosófico"
  
  step_4_pattern_mining:
    duration: 2h
    actions:
      - "Identificar cognitive signatures"
      - "Documentar padrões de comunicação"
      - "Catalogar estruturas argumentativas"

output:
  fragments_created: 50-100
  patterns_identified: 10-20
  synthesis_fragments: 5-10
  coverage_improvement: "+20-40%"
```

## Workflow C: Validação com Detective Agent

```yaml
workflow: "detective_validation"
input: "Completed knowledge base"
estimated_time: "2-3 hours"

interrogation_protocol:
  
  phase_1_factual_check:
    duration: 30min
    questions: 15-20
    type: "Verificação de fatos básicos"
    example: "Quando você nasceu? Onde estudou?"
  
  phase_2_consistency_test:
    duration: 45min
    questions: 20-25
    type: "Cross-reference de informações"
    example: "Antes você disse X, mas isso não contradiz Y?"
  
  phase_3_depth_probe:
    duration: 60min
    questions: 15-20
    type: "Testar profundidade real"
    example: "Explique isso para um PhD no campo"
  
  phase_4_edge_cases:
    duration: 30min
    questions: 10-15
    type: "Situações incomuns"
    example: "Como você reagiria se...?"

scoring:
  accuracy: "% respostas corretas"
  consistency: "% respostas consistentes"
  depth: "qualidade das explicações"
  naturalness: "fluidez da conversa"
  
  target_scores:
    accuracy: "> 85%"
    consistency: "> 90%"
    depth: "> 75%"
    naturalness: "> 80%
```

# =============================================================================
# 5. TROUBLESHOOTING COMUM
# =============================================================================

## Problema 1: "Não sei qual categoria escolher"

```yaml
solution:
  - "Pergunte: 'Sobre o QUÊ é este fragmento?'"
  - "Se sobre história/background → BIO"
  - "Se sobre como pensa → COG"
  - "Se sobre como fala → COM"
  - "Se sobre o que faz → BEH"
  - "Se sobre o que acredita → VAL"
  - "Se sobre relações → SOC"
  - "Se sobre contradições/evolução → META"
  - "Quando em dúvida: vá com a primeira intuição"
  - "Pode usar tags para categorias secundárias"
```

## Problema 2: "A confiança está baixa demais"

```yaml
solution:
  checklist:
    - "[ ] É fonte primária? (maior peso)"
    - "[ ] Posso verificar diretamente?"
    - "[ ] Outras fontes confirmam?"
    - "[ ] É consistente com corpus?"
    - "[ ] É específico o suficiente?"
  
  if_all_checked:
    - "Confiança deveria ser > 0.7"
  
  if_not:
    - "Aceite confiança mais baixa"
    - "Documente limitações"
    - "Marque para validação futura"
```

## Problema 3: "Muitos fragmentos de baixa qualidade"

```yaml
solution:
  quality_focus:
    - "Menos é mais: 10 excelentes > 50 medianos"
    - "Use threshold: overall > 7.0 para inclusão"
    - "Revise e melhore em vez de criar novos"
    - "Foque em fragmentos 'signature'"
  
  improvement_checklist:
    - "[ ] Adicionar mais contexto"
    - "[ ] Melhorar insights"
    - "[ ] Cross-referenciar"
    - "[ ] Aumentar especificidade"
```

## Problema 4: "Gaps não diminuem"

```yaml
solution:
  strategic_sourcing:
    - "Identifique que TIPOS de material faltam"
    - "Se faltam decisões → busque entrevistas longas"
    - "Se falta comunicação → busque material didático"
    - "Se falta filosofia → busque material reflexivo"
  
  quality_over_quantity:
    - "1 entrevista profunda > 10 artigos curtos"
    - "Busque fontes 'ricas' nos gaps específicos"
```

# =============================================================================
# 6. BEST PRACTICES
# =============================================================================

## Consistência

```yaml
practices:
  naming:
    - "Use IDs sequenciais: FRAG_XXX_001, FRAG_XXX_002..."
    - "Mantenha padrão de nomenclatura"
    - "Use snake_case para campos"
  
  dates:
    - "Sempre ISO 8601: YYYY-MM-DDTHH:MM:SSZ"
    - "UTC por padrão"
  
  language:
    - "Use código ISO: pt, en, es, fr..."
    - "Mantenha texto original quando possível"
```

## Qualidade

```yaml
practices:
  always:
    - "Capture contexto completo"
    - "Extraia múltiplos insights"
    - "Cross-referencie quando possível"
    - "Use quotes exatas quando disponível"
  
  never:
    - "Inventar informação"
    - "Assumir sem base"
    - "Misturar opinião com fato"
    - "Ignorar contradições"
```

## Eficiência

```yaml
practices:
  batch_processing:
    - "Processe material similar junto"
    - "Use templates preparados"
    - "Automatize campos calculados"
  
  incremental_building:
    - "Não tente completar 100% de uma vez"
    - "Vá adicionando camadas de profundidade"
    - "Valide incrementalmente"
```

# =============================================================================
# 7. MÉTRICAS DE SUCESSO
# =============================================================================

## Por Fragmento

```yaml
individual_fragment:
  excellent:
    - overall_quality: "> 8.5"
    - confidence: "> 0.85"
    - specificity: "SIGNATURE ou UNIQUE"
    - cross_referenced: true
  
  good:
    - overall_quality: "> 7.0"
    - confidence: "> 0.70"
    - specificity: "CHARACTERISTIC"
  
  acceptable:
    - overall_quality: "> 6.0"
    - confidence: "> 0.60"
```

## Por Knowledge Base

```yaml
knowledge_base_metrics:
  coverage:
    minimum: "60/87 questions (70%)"
    good: "70/87 questions (80%)"
    excellent: "80/87 questions (92%)"
  
  quality:
    average_fragment_quality: "> 7.5"
    average_confidence: "> 0.75"
    signature_fragments: "> 20"
  
  patterns:
    identified: "> 15"
    high_confidence: "> 10"
  
  validation:
    detective_score: "> 80%"
```

# =============================================================================
# FIM DO GUIA
# =============================================================================

## Próximos Passos

1. **Estudar a taxonomia completa** (fragment_taxonomy.yaml)
2. **Praticar com 5-10 fragmentos** usando templates
3. **Processar primeiro material** seguindo workflows
4. **Validar com Detective Agent**
5. **Iterar e melhorar**

## Recursos Adicionais

- `fragment_taxonomy.yaml` - Especificação completa
- `interrogation_protocol.yaml` - 87 perguntas estruturadas
- `fragment_templates.yaml` - Templates prontos para uso
- `validation_checklist.md` - Checklist de validação
