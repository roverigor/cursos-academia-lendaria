# TODO - Clone Alan Nicolas

## =Ê Status Geral

- [x] **Etapa 1: Viability**  COMPLETA (Score: 7.1/10 - APROVADO)
- [ ] **Etapa 2: Research** = EM ANDAMENTO
- [ ] **Etapa 3: Analysis** ø AGUARDANDO
- [ ] **Etapa 4: Synthesis** ø AGUARDANDO
- [ ] **Etapa 5: Implementation** ø AGUARDANDO
- [ ] **Etapa 6: Testing** ø AGUARDANDO

---

## Etapa Atual: 2. RESEARCH =

**Objetivo:** Coletar mínimo 30h de fontes primárias diversas antes de prosseguir para Analysis

**Progresso atual:**
-  23 artigos podcast Vida Lendária coletados (~8-12h)
-  9 vídeos IA baixados (.srt) - **AGUARDANDO CONVERSÃO PARA .md**
-  Profile psicométrico completo (alan-nicolas-profile.json)
- ø Vídeos precisam ser convertidos de .srt para .md
- L Lives IA não transcritas ainda (PRIORIDADE MÁXIMA)
- L Triangulação externa (entrevistas)

---

## =Ë ETAPA 1: VIABILITY  COMPLETA

### Tarefas Concluídas
- [x] Executar SCORECARD APEX
- [x] Definir arquétipo: "LENDÁRIO VIVO + ESPECIALISTA DE NICHO"
- [x] Identificar super-habilidade: "Engenharia Reversa Cognitiva + Síntese Transdisciplinar"
- [x] Mapear 2 personas complementares (IA Expert + Vida Lendária)
- [x] Definir estratégia: Generalista + 2 Especialistas

### Outputs Gerados
-  `docs/logs/20251005-1131-viability_apex.yaml` (Score: 7.1/10)
-  Recomendação: PROSSEGUIR com prioridade ALTA
-  ROI esperado: 9/10
-  Investimento estimado: 40-60 horas

### Decisões-Chave
- Arquétipo: "LENDÁRIO VIVO + ESPECIALISTA DE NICHO"
- Personas: IA Expert (técnico) + Vida Lendária (filosófico)
- Estrutura: Generalista integrado + 2 especialistas temáticos
- Gap crítico identificado: Lives IA não coletadas (fonte primária da persona técnica)

** Checkpoint #1 APROVADO** - Prosseguir para Research

---

## =Ë ETAPA 2: RESEARCH = EM ANDAMENTO

### 2.1 Source Discovery (01_source_discovery.md)
- [x] Identificar fontes primárias disponíveis
- [x] Mapear lacunas críticas (lives IA)
- [x] Categorizar por tipo (articles, videos, profile)
- [ ] Completar inventário em `sources_master.yaml`

### 2.2 Source Collector (02_source_collector.md)

####  Já Coletado:
- [x] 23 artigos podcast Vida Lendária (sources/articles/)
- [x] Profile psicométrico completo (alan-nicolas-profile.json)
- [x] 9 vídeos IA principais baixados (.srt format)

#### = Prioridade MÁXIMA - Conversão e Transcrição:
- [ ] **URGENTE:** Converter 9 vídeos .srt para .md com metadata
  - [ ] 1_A INTELIGÊNCIA ARTIFICIAL ESTÁ EM TUDO - ALAN NICOLAS \ Plugado #170
  - [ ] 2_Como as IAs podem TRANSFORMAR a sua EMPRESA \ Com Alan Nicolas \ Podcast EAG #287
  - [ ] 3_Inteligência Artificial Está Se Tornando Mais Perigosa E Ameaçadora!-Alan Nicolas
  - [ ] 4_Ele É Especialista Em IA E Já Fez 150 Milhões No Digital \ Alan Nicolas - Segredos Da Escala #026
  - [ ] 5_Como Estudar Inteligência Artificial do Zero \ Feat. Pedro Sobral
  - [ ] 6_A Nova Era dos Negócios com IA Visão de um CEO \ Alan Nicolas (Backstage)
  - [ ] 7_Inteligência Artificial A Verdade Sobre O Fim Dos Empregos \ Alan Nicolas - Segredos da Escala #070
  - [ ] 8_Inteligência Artificial Se Não Fizer Isso Vai Ser Deixado Para Trás!-Alan Nicolas
  - [ ] 9_Inteligência Artificial Eles Estão Mentindo Para Você! - Alan Nicolas \ Lutz Podcast #241
- [ ] Usar script: `./mmos/scripts/universal/convert-srt-to-md.sh sources/videos/`

#### =6 Prioridade ALTA - Lives IA:
- [ ] Identificar 5-10 lives IA mais importantes (URLs)
- [ ] Transcrever usando Whisper/AssemblyAI
- [ ] Organizar em sources/videos/ com metadata
- [ ] Estimar ~10-15h de conteúdo adicional

#### =6 Prioridade ALTA - Podcast Completo:
- [ ] Verificar disponibilidade de episódios completos Vida Lendária
- [ ] Baixar áudios ou transcrições
- [ ] Organizar em sources/interviews/ ou sources/videos/

#### =7 Prioridade MÉDIA - Redes Sociais:
- [ ] Coletar posts Twitter/X (se existirem)
- [ ] Coletar posts LinkedIn (conteúdo profissional)
- [ ] Organizar em sources/social-media/

#### =7 Prioridade MÉDIA - Conteúdo Técnico:
- [ ] Compilar newsletters técnicas sobre IA
- [ ] Coletar emails/aulas da Academia Lendár[IA]
- [ ] Organizar em sources/articles/

#### =7 Prioridade MÉDIA - Triangulação Externa:
- [ ] Entrevistar Indi (perspectiva íntima/familiar)
- [ ] Entrevistar Cadu/Steven (parceria estratégica)
- [ ] Entrevistar 2-3 alunos sobre mentoria
- [ ] Organizar em sources/interviews/

### 2.3 Temporal Mapper (03_temporal_mapper.md)
- [ ] Mapear fases da carreira:
  - [ ] Fase inicial (antes IA)
  - [ ] Transição para IA
  - [ ] Academia Lendár[IA]
  - [ ] Desenvolvimento metodologias (DNA Mental", MMOS)
- [ ] Documentar evolução do pensamento
- [ ] Criar `metadata/temporal_context.yaml`

### 2.4 Priority Calculator (03_priority_calculator.md)
- [ ] Calcular ROI por fonte (relevância, profundidade, unicidade)
- [ ] Identificar fontes de maior impacto cognitivo
- [ ] Criar `metadata/priority_matrix.yaml`

### 2.5 Sources Master (04_sources_master.md)
- [ ] Consolidar inventário completo
- [ ] Adicionar metadata completo por fonte
- [ ] Calcular coverage total (% vida documentada)
- [ ] Finalizar `sources/sources_master.yaml`

### Outputs Esperados da Etapa 2
- [ ] `sources/` - Mínimo 30h de fontes primárias diversas
- [ ] `sources/sources_master.yaml` - Inventário completo
- [ ] `metadata/temporal_context.yaml` - Fases e evolução temporal
- [ ] `metadata/priority_matrix.yaml` - Priorização de fontes
- [ ] Coverage score: e 30% da vida/carreira documentada

** Checkpoint #2:** Validar suficiência (mínimo 30h fontes primárias) antes de prosseguir

---

## =Ë ETAPA 3: ANALYSIS ø AGUARDANDO

**Pré-requisito:** Etapa 2 completa com mínimo 30h de fontes

### Estrutura de Análise (6 Níveis - DNA Mental")

#### Nível 1 - Extração Base (3 prompts paralelos)
- [ ] 01_source_reading.md - Leitura profunda de todas as fontes
- [ ] 01_quote_extraction.md - Extrair citações relevantes
- [ ] 01_timeline_mapping.md - Mapear timeline detalhado

**Agente:** Analyst (3 chats em paralelo)

#### Nível 2 - Análise Primária (Camadas 1-2 DNA Mental")
- [ ] 02_recognition_patterns.md - Radares mentais (Camada 2)
- [ ] 02_linguistic_forensics.md - Análise linguística forense
- [ ] 02_behavioral_patterns.md - Padrões comportamentais
- [ ] 02_rotine.md - Análise de rotina e hábitos

**Agente:** Analyst (4 prompts paralelos)

#### Nível 3 - Análise Profunda (Camadas 3-5 DNA Mental")
- [ ] 03_mental_models.md - Frameworks mentais (Camada 3)
- [ ] 03_values_hierarchy.md - Hierarquia de valores
- [ ] 03_belief_system.md - Sistema de crenças
- [ ] 03_decision_architecture.md - Arquitetura de decisões
- [ ] 03_immune_system.md - Sistema imunológico cognitivo

**Agentes:** Analyst + Architect (5 prompts paralelos)

#### Nível 4 - Core e Obsessões (Camada 6 DNA Mental")
- [ ] 04_core_obsessions.md - Identificar 2-3 obsessões primárias
- [ ] Identificar drivers emocionais profundos

**Agente:** Analyst (sequencial, aguarda Nível 3)

#### Nível 5 - Singularidade Cognitiva (Camada 7 DNA Mental")
- [ ] 05_unique_algorithm.md - Algoritmo cognitivo único
- [ ] 05_contradictions_map.md - Mapa de contradições

**Agentes:** Architect + Analyst (2 prompts paralelos)

#### Nível 6 - Síntese Integrativa (Camada 8 DNA Mental")
- [ ] 06_cognitive_architecture.md - Arquitetura cognitiva completa (3000+ palavras)
- [ ] 06_psychometric_analysis.md - Análise psicométrica (5000+ palavras)
- [ ] 06_limitations_doc.md - Documentar limitações

**Agentes:** Architect + Analyst (sequencial)

### Outputs Esperados da Etapa 3
- [ ] `artifacts/cognitive_architecture.yaml` - Modelo mental completo
- [ ] `artifacts/personality_profile.json` - Perfil psicométrico detalhado
- [ ] `artifacts/values_hierarchy.yaml` - Valores priorizados
- [ ] `artifacts/recognition_patterns.yaml` - Radares mentais
- [ ] `artifacts/mental_models.md` - Frameworks identificados
- [ ] `artifacts/core_obsessions.yaml` - Obsessões primárias
- [ ] `artifacts/unique_algorithm.py` - Algoritmo cognitivo
- [ ] `artifacts/contradictions.yaml` - Mapa de contradições
- [ ] `artifacts/behavioral_patterns.md` - Padrões comportamentais
- [ ] `artifacts/writing_style.md` - Estilo comunicacional
- [ ] `docs/LIMITATIONS.md` - Limitações conhecidas

** Checkpoint #3:** Validar se essência cognitiva foi capturada

---

## =Ë ETAPA 4: SYNTHESIS ø AGUARDANDO

**Pré-requisito:** Etapa 3 completa com arquitetura cognitiva validada

### 4.1 Extração Paralela (Prompts 01_)
- [ ] 01_template_extractor.md - Templates de comunicação recorrentes
- [ ] 01_phrases_miner.md - Frases e expressões signature
- [ ] 01_frameworks_identifier.md - Frameworks mentais únicos
- [ ] 01_extract_core.md - Consolidar elementos core
- [ ] 01_contradictions.md - Sintetizar contradições produtivas

**Agentes:** Analyst + Architect (5 prompts paralelos)

### 4.2 Knowledge Base (Prompt 02_)
- [ ] 02_kb_chunker.md - Criar chunks otimizados para LLM (500-1000 palavras)
- [ ] Organizar em kb/ (FLAT, sem subpastas)
- [ ] Criar índice de chunks

**Agente:** Analyst/Dev

### 4.3 Especialistas (Prompt 03_)
- [ ] 03_specialist_recommender.md - Recomendar especialistas temáticos
- [ ] Confirmar: IA Expert + Vida Lendária
- [ ] Definir escopo de cada especialista

**Agente:** Architect

### Outputs Esperados da Etapa 4
- [ ] `artifacts/communication_templates.md` - Padrões de comunicação
- [ ] `artifacts/signature_phrases.md` - Frases características
- [ ] `artifacts/core_elements.yaml` - Elementos core sintetizados
- [ ] `artifacts/frameworks.yaml` - Frameworks únicos
- [ ] `kb/chunk_001.md` até `kb/chunk_NNN.md` - Knowledge base completa
- [ ] `docs/logs/YYYYMMDD-HHMM-specialist_recommendations.yaml`

** Checkpoint #4:** Aprovar templates e estrutura da KB

---

## =Ë ETAPA 5: IMPLEMENTATION ø AGUARDANDO

**Pré-requisito:** Etapa 4 completa com KB e templates aprovados

### 5.1 Preparação (Nível 01)
- [ ] 01_extract_patterns.md - Extrair padrões finais dos artifacts/
- [ ] 01_extract_core.md - Extrair elementos core consolidados

**Agente:** Analyst

### 5.2 Core Building (Nível 02)
- [ ] 02_identity_core.md - Criar identidade core do clone
- [ ] 02_meta_axioms.md - Definir meta-axiomas fundamentais
- [ ] 02_instructions_core.md - Instruções fundamentais de comportamento

**Agentes:** Architect + PM (3 prompts paralelos)

### 5.3 Compilação Generalista (Nível 03)
- [ ] 03_generalista_compiler.md - Compilar system prompt generalista
- [ ] Integrar: IA Expert + Vida Lendária (ambas personas)
- [ ] Usar: cognitive_architecture + templates + kb/

**Agente:** Architect/PM

### 5.4 Especialização (Nível 04)
- [ ] 04_specialist_creator.md - Criar 2 especialistas:
  - [ ] specialists/ia_expert/ - Foco técnico (IA, clones, frameworks)
  - [ ] specialists/vida_lendaria/ - Foco filosófico (desenvolvimento, propósito)
- [ ] Criar KB filtrada por especialista
- [ ] Configurar system prompts especializados

**Agente:** Architect

### 5.5 Documentação (Nível 05)
- [ ] 05_operational_manual.md - Manual de operação do clone
- [ ] 05_testing_protocol.md - Protocolo de testes e validação
- [ ] neural_flow_techniques.md - Técnicas Neural Flow aplicadas

**Agente:** PM

### Outputs Esperados da Etapa 5
- [ ] `system_prompts/YYYYMMDD-HHMM-v1.0-generalista-initial.md`
- [ ] `system_prompts/config.yaml`
- [ ] `specialists/ia_expert/system_prompts/YYYYMMDD-HHMM-v1.0-specialist.md`
- [ ] `specialists/ia_expert/kb/` - KB filtrada técnica
- [ ] `specialists/vida_lendaria/system_prompts/YYYYMMDD-HHMM-v1.0-specialist.md`
- [ ] `specialists/vida_lendaria/kb/` - KB filtrada filosófica
- [ ] `docs/operational_manual.md`
- [ ] `docs/testing_protocol.md`

** Checkpoint #5:** Aprovar prompts para testing

---

## =Ë ETAPA 6: TESTING ø AGUARDANDO

**Pré-requisito:** Etapa 5 completa com system prompts aprovados

### 6.1 Preparação de Testes
- [ ] 01_test_generator.md - Gerar casos de teste específicos
  - [ ] Testes de personalidade (consistência)
  - [ ] Testes de conhecimento (precisão)
  - [ ] Testes de edge cases (robustez)

**Agente:** QA

### 6.2 Validação (Prompts 02_ em paralelo)
- [ ] 02_personality_validator.md - Validar personalidade e tom
- [ ] 02_knowledge_tester.md - Testar conhecimento específico
- [ ] 02_edge_cases.md - Testar casos extremos e contradições

**Agente:** QA (3 prompts paralelos)

### 6.3 Análise e Refinamento
- [ ] 03_final_report.md - Relatório consolidado de testes
- [ ] Identificar gaps e inconsistências
- [ ] Priorizar ajustes necessários
- [ ] Iterar se necessário (voltar para Implementation)

**Agente:** QA/Analyst

### 6.4 Documentação Final
- [ ] 04_readme_generator.md - Gerar README.md completo do mind
- [ ] Documentar métricas finais
- [ ] Criar guia de uso para usuários

**Agente:** PM

### Outputs Esperados da Etapa 6
- [ ] `docs/logs/YYYYMMDD-HHMM-test_results.yaml`
- [ ] `docs/logs/YYYYMMDD-HHMM-validation_report.md`
- [ ] `docs/README.md` - Documentação completa do mind
- [ ] Score de autenticidade: e 80%
- [ ] Score de consistência: e 80%

### Critérios de Aprovação
- [ ] Autenticidade e 80%
- [ ] Consistência e 80% nos testes
- [ ] Edge cases tratados adequadamente
- [ ] Documentação completa
- [ ] Feedback de usuários positivo

** Checkpoint #6:** Aprovar clone como PRODUCTION-READY

---

## <¯ Critérios de Qualidade - Alan Nicolas

### Viabilidade ( APROVADO)
-  Score APEX: 7.1/10 (e 3.5 requerido)
-  Sem bloqueios legais/éticos (auto-clonagem)
-  Arquétipo definido: "LENDÁRIO VIVO + ESPECIALISTA DE NICHO"
-  ROI justificado: 9/10

### Meta Production (Objetivo)
- [ ] 30-50h de fontes primárias diversas
- [ ] Coverage de 40%+ da vida/carreira
- [ ] Múltiplas perspectivas trianguladas
- [ ] Padrões com 3+ evidências cada
- [ ] 2 especialistas implementados (ia_expert + vida_lendaria)
- [ ] 85%+ consistência nos testes
- [ ] Score de autenticidade e 85%

### Diferencial Único (Meta-clone)
- [ ] Dogfooding: criador usando próprio sistema
- [ ] Feedback direto para refinamento
- [ ] Caso de estudo para metodologia
- [ ] Acesso total ao sujeito (auto-clonagem)

---

## =¨ Riscos e Mitigações

### Riscos Identificados
1. **Densidade de fontes abaixo do ideal** (10-20h atual vs 50h+ recomendado)
   - Mitigação: Coletar lives IA (PRIORIDADE MÁXIMA)

2. **Viés de confirmação** (risco de clone idealizado vs real)
   - Mitigação: Triangulação externa (Indi, Cadu, alunos)

3. **Complexidade cognitiva excepcional** (Estrato VI’VII, ISTP 5w4, 0.5% raridade)
   - Mitigação: Focar em algoritmo mental vs conhecimento factual

4. **Duas personas distintas** (IA Expert vs Vida Lendária)
   - Mitigação: Generalista integrado + 2 especialistas separados

---

## =Ê Métricas de Progresso

### Fontes Coletadas (Atual)
-  23 artigos (~8-12h)
-  1 profile psicométrico completo
-  9 vídeos IA (.srt - **PENDENTE CONVERSÃO**)
- L Lives IA (0/5-10 estimadas)
- L Triangulação externa (0/3 entrevistas)

**Total estimado atual:** ~10-15h
**Meta Etapa 2:** 30h mínimo
**Gap:** ~15-20h de fontes adicionais necessárias

### Próximas Ações Imediatas
1. **=% URGENTE:** Converter 9 vídeos .srt para .md (usar script)
2. **=% URGENTE:** Identificar e transcrever 5-10 lives IA principais
3. **=6 ALTA:** Coletar episódios podcast Vida Lendária completos
4. **=7 MÉDIA:** Triangulação externa (Indi, Cadu, alunos)

---

## =Å Timeline Estimada

- **Etapa 1: Viability**  COMPLETA (2h)
- **Etapa 2: Research** = EM ANDAMENTO (estimado: 5-7 dias)
- **Etapa 3: Analysis** ø AGUARDANDO (estimado: 7-10 dias)
- **Etapa 4: Synthesis** ø AGUARDANDO (estimado: 3-5 dias)
- **Etapa 5: Implementation** ø AGUARDANDO (estimado: 4-6 dias)
- **Etapa 6: Testing** ø AGUARDANDO (estimado: 3-5 dias)

**Total estimado:** 25-35 dias (40-60 horas conforme SCORECARD)

---

## =Ý Log de Decisões

### 2025-10-05
-  SCORECARD APEX executado: 7.1/10 - APROVADO
-  Arquétipo definido: "LENDÁRIO VIVO + ESPECIALISTA DE NICHO"
-  Estratégia: Generalista + 2 Especialistas (ia_expert + vida_lendaria)
-  Gap crítico identificado: Lives IA não coletadas
-  Checkpoint #1 APROVADO - Prosseguir para Research
-  9 vídeos IA baixados (.srt) - PENDENTE conversão para .md
-  TODO.md criado com roadmap completo das 6 etapas

---

## <¯ Meta-Observação (Clone do Criador)

Este é um **meta-projeto singular**:
- Criador da metodologia MMOS clonando a si mesmo
- Dogfooding: validação empírica do próprio sistema
- Caso de estudo para refinamento da metodologia
- Acesso total ao sujeito + feedback direto

**Implicações:**
- Oportunidade de ajuste fino do pipeline
- Identificação de gaps na metodologia
- Possibilidade de auto-refinamento iterativo
- Referência para futuros clones de alta complexidade

---

_Última atualização: 2025-10-05 11:45_
_Executor: Claude Code (MMOS v3.0)_
_Framework: DNA Mental" (8 camadas)_
