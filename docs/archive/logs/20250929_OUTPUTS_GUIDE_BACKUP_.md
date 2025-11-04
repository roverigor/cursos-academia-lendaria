# OUTPUTS_GUIDE.md - Sistema Completo de Outputs por Etapa

## 📋 CONVENÇÃO DE NOMENCLATURA OFICIAL

**PADRÃO OBRIGATÓRIO: UNDERSCORES (`_`)**

Todos os arquivos e pastas do sistema ACS V3.0 usam **underscores** para separação:

✅ **CORRETO:**
- `personality_profile.json`
- `writing_style.md`
- `communication_templates.md`
- `system_prompts/`
- `operational_manual.md`

❌ **INCORRETO:**
- `personality-profile.json` (hyphens)
- `writingStyle.md` (camelCase)
- `PersonalityProfile.json` (PascalCase)
- `system-prompts/` (hyphens)

**Exceções:**
- Timestamps: `YYYYMMDD-HHMM` (mantém hyphens por convenção)
- Versões: `v1.0`, `v2.5` (mantém ponto)

**Rationale:**
- Consistência com Python/YAML conventions
- Maior legibilidade que hyphens
- Todo sistema já utiliza underscores
- Evita confusão com operador de subtração

---

## Visão Geral do Pipeline

```
Viability → Research → Analysis → Synthesis → Implementation → Testing
```

---

## ETAPA 1: VIABILITY

### Prompts e Outputs

|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`01_scorecard_apex.md`|`viability_assessment.yaml`|`logs/YYYYMMDD-HHMM-viability.yaml`|1º (obrigatório)|
|`02_icp_match_score.md`|`icp_match.yaml`|`logs/YYYYMMDD-HHMM-icp_match.yaml`|2º (se APEX ≥6.0)|
|`02_prd_generator.md`|`PRD.md`|`docs/PRD.md`|3º (se aprovado)|
|`02_dependencies_mapper.md`|`dependencies.yaml`|`metadata/dependencies.yaml`|Paralelo com PRD|
|`03_todo_initializer.md`|`TODO.md`|`docs/TODO.md`|Último|

**⚠️ FLUXO SEQUENCIAL CRÍTICO:**

```
01_scorecard_apex.md → score_final?
    ├─ < 6.0 → REJEITAR clone (fim do fluxo)
    └─ ≥ 6.0 → 02_icp_match_score.md → icp_score?
            ├─ < 6.0 → BUSCAR ALTERNATIVA
            ├─ 6.0-7.9 → CLONE CONDICIONAL
            ├─ 8.0-8.9 → CLONE RECOMENDADO
            └─ ≥ 9.0 → CLONE PRIORITÁRIO
                    ↓
            Se aprovado → Prosseguir para PRD + TODO
```

### Estrutura Criada

```
nome-do-clone/
├── docs/
│   ├── PRD.md              # Product Requirements Document
│   └── TODO.md             # Lista dinâmica de tarefas
├── metadata/
│   └── dependencies.yaml   # Mapa de influências
└── logs/
    ├── YYYYMMDD-HHMM-viability.yaml    # APEX Score (viabilidade técnica)
    └── YYYYMMDD-HHMM-icp_match.yaml    # ICP Match (relevância estratégica)
```

### ⚠️ HUMAN CHECKPOINT 1

**Decisão**: Prosseguir com o clone?

**Critérios de Aprovação:**
- ✅ Score APEX ≥ 6.0 (viabilidade técnica)
- ✅ ICP Match ≥ 7.0 (relevância estratégica)
- ✅ Prioridade combinada: P0-P2
- ✅ PRD aprovado
- ✅ Investimento autorizado

**Decisões Automáticas:**
- APEX < 6.0 → **REJEITAR** automaticamente
- APEX ≥ 6.0 + ICP < 6.0 → **BUSCAR ALTERNATIVA**
- APEX ≥ 6.0 + ICP ≥ 7.0 → **APROVAR** (checkpoint humano para confirmar investimento)
- APEX ≥ 9.0 + ICP ≥ 9.0 → **PRIORIZAR** (P0 - executar imediatamente)

---

## ETAPA 2: RESEARCH

### Prompts e Outputs

|Prompt|Output|Destino|
|---|---|---|
|`01_source_discovery.md`|Lista de fontes|Memória|
|`02_source_collector.md`|Arquivos baixados|`sources/[tipo]/`|
|`03_temporal_mapper.md`|`temporal_context.yaml`|`metadata/`|
|`03_priority_calculator.md`|`priority_matrix.yaml`|`sources/`|
|`04_sources_master.md`|`sources_master.yaml`|`sources/`|

### Estrutura Expandida

```
nome-do-clone/
├── sources/
│   ├── books/              # PDFs, EPUBs
│   ├── interviews/         # Transcrições
│   ├── speeches/           # Palestras
│   ├── articles/           # Posts, artigos
│   ├── social-media/       # Tweets, posts
│   ├── videos/             # Transcrições YouTube
│   ├── sources_master.yaml
│   └── priority_matrix.yaml
├── metadata/
│   └── temporal_context.yaml
└── logs/
    └── YYYYMMDD-HHMM-research-report.md
```

### ⚠️ HUMAN CHECKPOINT 2

**Decisão**: Fontes suficientes?

- < 10h conteúdo → Estratégia fallback
- 10-50h → Escopo limitado
- > 50h → Pipeline completo
    

---

## ETAPA 3: ANALYSIS

### Prompts e Outputs - Sequência Crítica

#### Nível 01: Extração Base

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`01_source_reading.md`|`key_insights.md`|`logs/`|✅|
|`01_quote_extraction.md`|`quotes_database.yaml`|`analysis/`|✅|
|`01_timeline_mapping.md`|`life_timeline.yaml`|`analysis/`|✅|

#### Nível 02: Análise Primária

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`02_linguistic_forensics.md`|`writing_style.md`|`analysis/`|✅|
|`02_behavioral_patterns.md`|`behavioral_patterns.md`|`analysis/`|✅|
|`02_decision_analysis.md`|`decision_patterns.yaml`|`analysis/`|✅|

#### Nível 03: Análise Profunda

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`03_values_hierarchy.md`|`values_hierarchy.yaml`|`analysis/`|✅|
|`03_contradictions_map.md`|`contradictions.yaml`|`analysis/`|✅|
|`03_belief_system.md`|`beliefs_core.yaml`|`analysis/`|✅|

#### Nível 04: Síntese Integrativa

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`04_cognitive_architecture.md`|`cognitive_architecture.yaml`|`analysis/`|✅|
|`04_psychometric_analysis.md`|`personality_profile.json`|`analysis/`|✅|

#### Nível 05: Documentação

|Prompt|Output|Destino|
|---|---|---|
|`05_limitations_doc.md`|`LIMITATIONS.md`|`docs/`|

### Estrutura Expandida

```
nome-do-clone/
├── analysis/
│   ├── personality_profile.json
│   ├── writing_style.md
│   ├── behavioral_patterns.md
│   ├── cognitive_architecture.yaml
│   ├── values_hierarchy.yaml
│   ├── contradictions.yaml
│   └── quotes_database.yaml
└── docs/
    └── LIMITATIONS.md
```

### ⚠️ HUMAN CHECKPOINT 3

**Decisão**: Análise capturou a essência?

- Arquitetura cognitiva coerente
- Valores e paradoxos mapeados
- Especialistas identificados

---

## ETAPA 4: SYNTHESIS

### Prompts e Outputs

#### Nível 01: Extração Paralela

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`01_template_extractor.md`|`communication_templates.md`|`templates/`|✅|
|`01_phrases_miner.md`|`signature_phrases.md`|`templates/`|✅|
|`01_frameworks_identifier.md`|`signature_frameworks.md`|`frameworks/`|✅|
|`01_patterns_synthesizer.md`|`decision_patterns.md`|`frameworks/`|✅|

**Nota:** Todos os outputs seguem padrão `nome_do_arquivo.extensão` com underscores.

#### Nível 02: Knowledge Base

|Prompt|Output|Destino|
|---|---|---|
|`02_kb_chunker.md`|Chunks processados|`kb/`|

#### Nível 03: Especialização

|Prompt|Output|Destino|
|---|---|---|
|`03_specialist_recommender.md`|`specialist_recommendations.yaml`|`logs/`|

### Estrutura Expandida

```
nome-do-clone/
├── templates/
│   ├── communication_templates.md
│   └── signature_phrases.md
├── frameworks/
│   ├── signature_frameworks.md
│   └── decision_patterns.md
├── kb/
│   └── [chunks organizados]
└── kb.md
```

### ⚠️ HUMAN CHECKPOINT 4

**Decisão**: Templates e KB adequados?

- Templates capturam voz
- Frameworks são funcionais
- KB tem coverage suficiente

---

## ETAPA 5: IMPLEMENTATION

### Prompts e Outputs

#### Nível 01: Preparação

|Prompt|Output|Uso|Paralelo|
|---|---|---|---|
|`01_extract_patterns.md`|Padrões consolidados|Memória|✅|
|`01_extract_core.md`|Elementos core|Memória|✅|

#### Nível 02: Core Building

|Prompt|Input Principal|Output|Paralelo|
|---|---|---|---|
|`02_identity_core.md`|`cognitive_architecture.yaml`|Core identity|✅|
|`02_meta_axioms.md`|`values_hierarchy.yaml`|Axiomas base|✅|
|`02_instructions_core.md`|`behavioral_patterns.md`|Instruções|✅|

#### Nível 03: Compilação

|Prompt|Output|Destino|
|---|---|---|
|`03_generalista_compiler.md`|System prompt generalista|`system-prompts/`|

#### Nível 04: Especialização (se aprovado)

|Prompt|Output|Destino|
|---|---|---|
|`04_specialist_creator.md`|System prompt especialista|`specialists/[tipo]/`|

#### Nível 05: Documentação

|Prompt|Output|Destino|
|---|---|---|
|`05_operational_manual.md`|`operational_manual.md`|`docs/`|
|`05_testing_protocol.md`|`testing_protocol.md`|`docs/`|

### Estrutura Final

```
nome-do-clone/
├── system_prompts/
│   └── YYYYMMDD-HHMM-v1.0-generalista-initial.md
├── specialists/
│   └── [especialidade]/
│       ├── kb/
│       ├── kb.md
│       └── system_prompts/
│           └── YYYYMMDD-HHMM-v1.0-[tipo]-initial.md
└── docs/
    ├── operational_manual.md
    └── testing_protocol.md
```

### ⚠️ HUMAN CHECKPOINT 5

**Decisão**: Prompts prontos para teste?

- Identity core coerente
- Instruções claras
- Voz autêntica

---

## ETAPA 6: TESTING

### Prompts e Outputs

|Prompt|Output|Destino|
|---|---|---|
|`01_test_generator.md`|`test_cases.yaml`|`logs/`|
|`02_personality_validator.md`|Resultados personalidade|`logs/`|
|`02_knowledge_tester.md`|Resultados conhecimento|`logs/`|
|`02_edge_cases.md`|Resultados edge cases|`logs/`|
|`03_final_report.md`|`validation_report.yaml`|`logs/`|
|`04_readme_generator.md`|`README.md`|`docs/`|

### Estrutura Completa

```
nome-do-clone/
└── docs/
    └── README.md           # Documentação final completa
```

### ⚠️ HUMAN CHECKPOINT 6 (FINAL)

**Decisão**: Aprovar para produção?

- Testes passando > 80%
- Personalidade alinhada
- Conhecimento validado

---

## Fluxo de Dados Críticos Entre Etapas

```yaml
data_flow:
  viability_to_research:
    - archetype_type        # Define estratégia de pesquisa
    - priority_focus        # Define onde focar
    
  research_to_analysis:
    - sources/*             # Todo material coletado
    - temporal_context      # Períodos e fases
    
  analysis_to_synthesis:
    - behavioral_patterns   # Para extrair templates
    - linguistic_analysis   # Para extrair frases
    - cognitive_architecture # Para identificar frameworks
    
  synthesis_to_implementation:
    - templates/*           # Elementos de comunicação
    - frameworks/*          # Sistemas de decisão
    - kb/*                  # Knowledge base
    
  analysis_to_implementation:
    - cognitive_architecture → identity_core
    - values_hierarchy → meta_axioms
    - behavioral_patterns → instructions_core
    
  implementation_to_testing:
    - system_prompts/*      # O que testar
    - testing_protocol      # Como testar
```

## Métricas de Completude e Qualidade

### Critérios Objetivos de Viabilidade

#### Densidade de Fontes

- **Insuficiente**: < 5 fontes primárias distintas
- **Mínimo**: 5-10 fontes primárias
- **Adequado**: 10-20 fontes primárias
- **Robusto**: 20+ fontes primárias

#### Coverage Temporal

- **Insuficiente**: < 30% da vida/carreira documentada
- **Mínimo**: 30-50% com pelo menos período principal
- **Adequado**: 50-70% com múltiplas fases
- **Completo**: 70%+ com evolução clara

#### Triangulação de Dados

- **Insuficiente**: Apenas 1 perspectiva (ex: só autobiografia)
- **Mínimo**: 2 perspectivas (própria + terceiros)
- **Adequado**: 3+ perspectivas independentes
- **Robusto**: Múltiplas perspectivas contraditórias reconciliadas

### Critérios de Qualidade do Clone

#### Teste de Consistência

- **Falha**: Respostas contraditórias sobre mesmos tópicos
- **Básico**: 60% consistência em tópicos core
- **Adequado**: 80% consistência
- **Excelente**: 95%+ consistência com paradoxos explicados

#### Teste de Autenticidade

- **Falha**: Não captura voz/estilo distintivo
- **Básico**: Captura elementos superficiais
- **Adequado**: Captura padrões profundos
- **Excelente**: Indistinguível em blind test

#### Teste de Conhecimento

- **Falha**: Não demonstra expertise documentada
- **Básico**: Conhecimento genérico da área
- **Adequado**: Conhecimento específico verificável
- **Excelente**: Nuances e insights únicos preservados

## Decisões Baseadas em Evidências

|Evidências Disponíveis|Tipo de Clone Possível|
|---|---|
|Apenas biografia + 2-3 entrevistas|Clone não viável - sugerir alternativas|
|5-10 fontes primárias diversas|Clone básico - escopo limitado|
|10-20 fontes com múltiplas perspectivas|Clone completo generalista|
|20+ fontes com contradições resolvidas|Clone completo + especialistas|

## Checkpoints com Critérios Objetivos

### CHECKPOINT 1 - Viability

- [ ] Mínimo 5 fontes primárias identificadas
- [ ] Sem bloqueios legais
- [ ] Arquétipo claramente definido

### CHECKPOINT 2 - Research

- [ ] Fontes coletadas representam 30%+ do conhecimento público
- [ ] Múltiplas perspectivas obtidas
- [ ] Gaps críticos identificados e documentados

### CHECKPOINT 3 - Analysis

- [ ] Padrões comportamentais com 3+ evidências cada
- [ ] Contradições mapeadas e contextualizadas
- [ ] Arquitetura cognitiva coerente extraída

### CHECKPOINT 4 - Synthesis

- [ ] Mínimo 5 templates únicos extraídos
- [ ] 2+ frameworks identificados e testados
- [ ] KB cobre domínios principais de expertise

### CHECKPOINT 5 - Implementation

- [ ] System prompt passa teste de coerência interna
- [ ] Instruções não conflitantes
- [ ] Voz distintiva preservada

### CHECKPOINT 6 - Testing

- [ ] 80%+ consistência em respostas
- [ ] 0 alucinações em fatos verificáveis
- [ ] Feedback positivo em blind test

---

_Última atualização: Sistema v3 com fluxo completo de dependências_