# OUTPUTS_GUIDE.md - Sistema Completo de Outputs por Etapa

## 📋 CONVENÇÃO DE NOMENCLATURA

Usamos **snake_case** (underscores) para todos os arquivos e pastas: `personality_profile.json`, `system_prompts/`.

---

## 📁 ESTRUTURA DE PASTAS V3.0

**MUDANÇA CRÍTICA:** A partir da V3.0, a estrutura de pastas foi reorganizada para maior clareza:

### Estrutura Completa de um Clone

```
nome_do_clone/
├── sources/              # Biblioteca semântica da mente (fontes primárias)
├── artifacts/            # FLAT: Todos os artefatos intermediários do processo
├── docs/
│   └── logs/            # Relatórios timestamped (YYYYMMDD-HHMM-nome.md)
├── kb/                  # Knowledge Base FLAT (arquivos para upload)
├── system_prompts/      # Prompts finais gerados
└── specialists/         # [OPCIONAL] Versões especializadas
```

### PASTA: sources/
**Propósito:** Biblioteca semântica da mente - corpus completo da expressão cognitiva autêntica
**Conteúdo:** Apenas fontes PRIMÁRIAS (da pessoa, não sobre ela)

### PASTA: artifacts/
**Propósito:** Centraliza TODOS os artefatos intermediários do processo (análises, frameworks, templates)
**Estrutura:** FLAT - sem subpastas
**Substitui:** As antigas pastas `analysis/`, `frameworks/`, `templates/`

**O que vai em artifacts/:**
- Todos os outputs de Analysis (personality_profile.json, writing_style.md, etc.)
- Todos os frameworks identificados (signature_frameworks.md, decision_patterns.md)
- Todos os templates extraídos (communication_templates.md, signature_phrases.md)

### PASTA: docs/logs/
**Propósito:** Relatórios e logs timestamped
**Formato:** `YYYYMMDD-HHMM-nome_do_relatorio.md`

### PASTA: kb/
**Propósito:** Knowledge Base pronta para upload
**Estrutura:** FLAT - sem subpastas (facilita upload para LLMs)

### PASTA: system_prompts/
**Propósito:** Prompts finais gerados
**Convenção:** snake_case com underscore (não hyphen)

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
nome_do_clone/
├── docs/
│   ├── PRD.md              # Product Requirements Document
│   ├── TODO.md             # Lista dinâmica de tarefas
│   └── logs/
│       ├── YYYYMMDD-HHMM-viability.yaml    # APEX Score (viabilidade técnica)
│       └── YYYYMMDD-HHMM-icp_match.yaml    # ICP Match (relevância estratégica)
└── metadata/
    └── dependencies.yaml   # Mapa de influências
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
nome_do_clone/
├── sources/                  # ⚠️ V3.0: BIBLIOTECA SEMÂNTICA (fontes primárias)
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
└── docs/
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
|`01_source_reading.md`|`key_insights.md`|`docs/logs/`|✅|
|`01_quote_extraction.md`|`quotes_database.yaml`|`artifacts/`|✅|
|`01_timeline_mapping.md`|`life_timeline.yaml`|`artifacts/`|✅|

#### Nível 02: Análise Primária

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`02_recognition_patterns.md`|`recognition_patterns.yaml`|`artifacts/`|✅|
|`02_linguistic_forensics.md`|`writing_style.md`|`artifacts/`|✅|
|`02_behavioral_patterns.md`|`behavioral_patterns.md`|`artifacts/`|✅|
|`01_rotine.md`|`routine_analysis.md`|`artifacts/`|✅|

#### Nível 03: Análise Profunda

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`03_mental_models.md`|`mental_models.md`|`artifacts/`|✅|
|`03_values_hierarchy.md`|`values_hierarchy.yaml`|`artifacts/`|✅|
|`03_belief_system.md`|`beliefs_core.yaml`|`artifacts/`|✅|
|`03_decision_architecture.md`|`decision_patterns.yaml`|`artifacts/`|✅|
|`03_immune_system.md`|`immune_system.md`|`artifacts/`|✅|

#### Nível 04: Core e Obsessões

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`04_core_obsessions.md`|`core_obsessions.yaml`|`artifacts/`|✅|

#### Nível 05: Singularidade Cognitiva

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`05_unique_algorithm.md`|`unique_algorithm.py`|`artifacts/`|✅|
|`05_contradictions_map.md`|`contradictions.yaml`|`artifacts/`|✅|

#### Nível 06: Síntese Integrativa

|Prompt|Output|Destino|Paralelo|
|---|---|---|---|
|`06_cognitive_architecture.md`|`cognitive_architecture.yaml`|`artifacts/`|✅|
|`06_psychometric_analysis.md`|`personality_profile.json`|`artifacts/`|✅|
|`06_limitations_doc.md`|`LIMITATIONS.md`|`docs/`|❌|

### Estrutura Expandida

```
nome_do_clone/
├── artifacts/              # ⚠️ V3.0: FLAT - Todos os artefatos de análise
│   ├── personality_profile.json
│   ├── writing_style.md
│   ├── behavioral_patterns.md
│   ├── cognitive_architecture.yaml
│   ├── values_hierarchy.yaml
│   ├── contradictions.yaml
│   ├── recognition_patterns.yaml
│   ├── mental_models.md
│   ├── core_obsessions.yaml
│   ├── unique_algorithm.py
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
|`01_template_extractor.md`|`communication_templates.md`|`artifacts/`|✅|
|`01_phrases_miner.md`|`signature_phrases.md`|`artifacts/`|✅|
|`01_extract_core.md`|`core_elements.yaml`|`artifacts/`|✅|

**Nota:** Todos os outputs seguem padrão `nome_do_arquivo.extensão` com underscores.

#### Nível 02: Knowledge Base

|Prompt|Output|Destino|
|---|---|---|
|`02_kb_chunker.md`|Chunks processados|`kb/`|

#### Nível 03: Especialização

|Prompt|Output|Destino|
|---|---|---|
|`03_specialist_recommender.md`|`specialist_recommendations.yaml`|`docs/logs/`|

### Estrutura Expandida

```
nome_do_clone/
├── artifacts/              # ⚠️ V3.0: Templates e frameworks aqui também
│   ├── communication_templates.md
│   ├── signature_phrases.md
│   └── core_elements.yaml
└── kb/                     # ⚠️ V3.0: FLAT - sem subpastas
    └── [chunks organizados]
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
|`03_generalista_compiler.md`|System prompt generalista|`system_prompts/`|

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
nome_do_clone/
├── system_prompts/          # ⚠️ V3.0: underscore (não hyphen)
│   └── YYYYMMDD-HHMM-v1.0-generalista-initial.md
├── specialists/
│   └── [especialidade]/
│       ├── kb/
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
|`01_test_generator.md`|`test_cases.yaml`|`docs/logs/`|
|`02_personality_validator.md`|Resultados personalidade|`docs/logs/`|
|`02_knowledge_tester.md`|Resultados conhecimento|`docs/logs/`|
|`02_edge_cases.md`|Resultados edge cases|`docs/logs/`|
|`03_final_report.md`|`validation_report.yaml`|`docs/logs/`|
|`04_readme_generator.md`|`README.md`|`docs/`|

### Estrutura Completa

```
nome_do_clone/
└── docs/
    ├── README.md           # Documentação final completa
    └── logs/
        ├── test_cases.yaml
        ├── YYYYMMDD-HHMM-personality_validation.md
        ├── YYYYMMDD-HHMM-knowledge_tests.md
        ├── YYYYMMDD-HHMM-edge_cases.md
        └── YYYYMMDD-HHMM-validation_report.yaml
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
    - sources/*             # Todo material coletado (biblioteca semântica)
    - temporal_context      # Períodos e fases

  analysis_to_synthesis:
    - artifacts/behavioral_patterns    # Para extrair templates
    - artifacts/writing_style          # Para extrair frases
    - artifacts/cognitive_architecture # Para identificar frameworks

  synthesis_to_implementation:
    - artifacts/communication_templates  # Elementos de comunicação
    - artifacts/signature_phrases        # Frases características
    - kb/*                               # Knowledge base

  analysis_to_implementation:
    - artifacts/cognitive_architecture → identity_core
    - artifacts/values_hierarchy → meta_axioms
    - artifacts/behavioral_patterns → instructions_core

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

_Última atualização: V3.0 com estrutura artifacts/ e docs/logs/_
_Data: 29/09/2025 - Migração completa de 18 clones_