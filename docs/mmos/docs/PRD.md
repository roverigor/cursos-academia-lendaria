# Product Requirements Document: MMOS - Mind Mapper OS

**Versão:** 1.5
**Data:** 05 de Outubro de 2025
**Autor:** John, Product Manager (AIOS)
**Atualização:** v1.5 - AIOS-first Orchestration, Launcher, Telemetria, Brownfield Assistente Incremental

## 1. Goals and Background Context

* **Goals:**
    * Industrializar o **MMOS (Mind Mapper OS)** - pipeline de ponta-a-ponta para mapeamento e emulação de arquiteturas cognitivas de gênios em IA
    * Reduzir tempo de criação de mind de semanas para 3-5 dias através de orquestração AIOS-first e paralelização assistida
    * Implementar **Document-Centric Workflow** com templates reutilizáveis (MIND_BRIEF.md, COGNITIVE_SPEC.md)
    * Garantir consistência e qualidade através de **Human Checkpoints**, telemetria e Notes System (agent-to-agent communication)
    * Suportar tanto **Greenfield** (mind novo) quanto **Brownfield** (atualização incremental) sem reprocessar pipeline completo
    * Criar fundação escalável para crescer biblioteca de 22+ para 100+ minds e habilitar integração futura com galeria pública

* **Background Context:**
    O Lendário.ai possui MMOS (Mind Mapper OS) - sistema validado de "arqueologia cognitiva" composto por **47 prompts especializados** organizados em 6 etapas (Viability, Research, Analysis, Synthesis, Implementation, Testing). Utiliza **DNA Mental™** (8 layers) alcançando 94% de precisão vs. 30% de LLMs tradicionais. Sistema inclui **dupla avaliação** (APEX + ICP Score) para rejeitar automaticamente minds inviáveis, economizando 40% de tokens.

    Historicamente, o pipeline foi executado de forma manual: operadores humanos consultavam os agentes AIOS de modo ad-hoc, copiavam prompts e registravam saídas manualmente nos diretórios ACS. Essa abordagem confirmou a metodologia, mas criou gargalos de ativação, paralelização limitada (~20%), pouca rastreabilidade e um backlog crescente de atualizações brownfield (825 linhas de TODO dentro dos 22 minds atuais).

    **Mudança crítica (v1.5):** O pipeline deixa de depender de execução manual dispersa e passa a operar em modo **AIOS-first**, onde os agentes coordenam cada prompt com contexto automatizado, telemetria e colaboração estruturada. O framework permanece conversacional, mas agora serve como camada de orquestração oficial.

    Estrutura atual: `mmos/` (pipeline), `minds/` (22 minds produção), nomenclatura underscore obrigatória, documentação completa em `docs/mmos/**` e logs consolidados em `docs/mmos/logs/`.

## 2. Requirements

* **Functional Requirements (FR):**
    * **FR1:** Launcher AIOS-first que mapeia prompt→agente, injeta contexto (PRD, fontes, status) e registra destino oficial dos outputs automaticamente.
    * **FR2:** Quadro de orquestração/telemetria que rastreia progresso por fase, agentes acionados, checkpoints humanos e bloqueios em tempo real.
    * **FR3:** Gerenciador de paralelização orientado a AIOS, respeitando dependências do pipeline e habilitando execução simultânea planejada.
    * **FR4:** Assistente brownfield incremental com diff de fontes/artefatos, sugestão de prompts a reexecutar e gatilho de testes de regressão.
    * **FR5:** Motor de notas/handoff entre agentes (notes system) com versionamento e integração ao board.
    * **FR6:** Instrumentação de telemetria (tempo, agente, reexecução) com alertas para anomalias.
    * **FR7:** CLI/API leve para disparar sessões AIOS com presets e persistir logs em `docs/mmos/logs/`.
* **Non-Functional Requirements (NFR):**
    * **NFR1:** Reduzir execução completa de um mind para 3-5 dias, com paralelização efetiva ≥60% das etapas elegíveis.
    * **NFR2:** Retomar pipeline após falha com perda máxima de uma tarefa (checkpoint automático).
    * **NFR3:** Garantir rastreabilidade 100% (timestamp, agente, origem e destino) para cada prompt.
    * **NFR4:** Onboarding operacional via AIOS concluído em ≤4h (documentação + tooling).
    * **NFR5:** Suportar 5 execuções simultâneas mantendo ≥95% de sucesso por prompt e sem degradação perceptível.
    * **NFR6:** Arquitetura extensível para integrações futuras (ClickUp, Supabase, dashboard externo) sem reescrever core.
* **Compatibility Requirements (CR):**
    * **CR1:** Manter outputs no padrão ACS v3.0 (sources/, artifacts/, kb/, docs/, system_prompts/, specialists/).
    * **CR2:** Preservar convenções de nomenclatura snake_case e timestamps `YYYYMMDD-HHMM`.
    * **CR3:** Reutilizar templates document-centric existentes (`PRD.md`, `MIND_BRIEF.md`, `COGNITIVE_SPEC.md`, `OUTPUTS_GUIDE.md`).
    * **CR4:** Brownfield assistant deve operar sobre minds legados sem reprocessar pipeline completo, com rollback registrado.

## 3. Technical Assumptions

* **Fase atual (v1.5):** Execução AIOS-first, conversacional e orquestrada
    * Agentes AIOS (PM, Analyst, Architect, Dev, QA, PO, etc.) são a interface oficial do pipeline
    * Launcher e board AIOS fornecem contexto, rastreabilidade e checkpoints obrigatórios
    * Execução continua manual assistida (sem workers automáticos), porém com paralelização guiada e telemetria
    * Brownfield updates realizados de forma incremental via assistente dedicado, com regressão automatizada
    * Document-centric permanece (MIND_BRIEF.md, COGNITIVE_SPEC.md, Notes System) com versionamento
    
* **Fase futura (após consolidação AIOS-first):** Automação seletiva e integrações externas
    * Backend FastAPI/PostgreSQL para histórico, métricas, hidratação de data warehouse
    * Workers delegados apenas a tarefas mecânicas (fetching, parsing, chunking) mantendo análise cognitiva manual
    * Integrações: Supabase/galeria pública, ClickUp, dashboards externos
    * Suporte a API pública para consumo dos DNA Mentais e monitoramento em tempo real

* **Convenções Críticas:**
    * Nomenclatura com underscores (`personality_profile.json`, `system_prompts/`)
    * Outputs sempre em `/minds/` (NUNCA em `/mmos/outputs/`)
    * Timestamps no formato `YYYYMMDD-HHMM`
    * Arquivos `.md`/`.yaml` seguindo ACS V3.0 (sources/, artifacts/, kb/, docs/, system_prompts/, specialists/)
    * Logs e notas registrados em `docs/mmos/logs/`

---
## 4. Epic Details

### Epic 1: MMOS AIOS-first Orchestration
**📄 Epic File**: [epic-1-aios-orchestration.md](../epics/epic-1-aios-orchestration.md)
**Status**: 🟡 In Progress (3/4 stories complete)

* **Epic Goal:** Transformar o pipeline MMOS em uma experiência nativa AIOS-first, eliminando execução manual dispersa e habilitando visibilidade, paralelização e manutenção incremental.
* **Integration Requirements:**
    * Reutilizar estrutura ACS v3.0 existente (`sources/`, `artifacts/`, `kb/`, `docs/`, `system_prompts/`, `specialists/`).
    * Consumir templates/documentos (`PRD.md`, `OUTPUTS_GUIDE.md`, `AIOS_WORKFLOW.md`) mantendo convenções snake_case e timestamps.
    * Operar sobre minds legados sem reprocessamento completo; brownfield assistant precisa preservar histórico/logs e oferecer rollback.
    * Integrar-se aos agentes AIOS já disponíveis (PM, Analyst, Architect, Dev, QA, PO, UX) e registrar interações em `docs/mmos/logs/`.

#### Story 1.1: AIOS Launcher v1
*As a pipeline operator, I want a launcher AIOS that maps prompt→agent and injects automatic context for each MMOS execution, so that an orchestration occurs with zero manual friction and standardized logging.*

**Acceptance Criteria:**
1. CLI/terminal accepts `mind_name`, `stage`, `prompt_id` and identifies the corresponding agent.
2. Displays a summarized context (relevant excerpts of PRD, current status, available sources) before calling the agent.
3. Suggests the official output destination (`docs/logs/YYYYMMDD-HHMM-<task>.md|yaml`) and guides saving.
4. Registers invocation log with timestamp, agent, executed prompt, and user.
5. Supports multiple concurrent launches without overwriting temporary files.
6. Maintains naming conventions and does not alter ACS structure.

**Integration Verification:**
- **IV1:** Launcher reads existing files (PRD, logs, sources) without modifying them.
- **IV2:** New logs are written without overwriting previous records.
- **IV3:** Average preparation time for each prompt reduced ≥30% vs manual execution.

#### Story 1.2: Orchestration Board & Telemetria
*As a product manager, I want an orchestration board and telemetry that shows progress, triggered agents, blockages, and checkpoints, so that the team has end-to-end visibility and decisions can be made quickly.*

**Acceptance Criteria:**
1. Board generates a central view (Markdown/HTML or AIOS tool) with status by phase, completed prompts, and responsible agents.
2. Updates automatically after execution via launcher, marking checkboxes and timestamps.
3. Displays time spent per prompt, number of reexecutions, and responsible agent.
4. Highlights pending human checkpoints and identified blockages.
5. Exports periodic snapshots to `docs/mmos/logs/YYYYMMDD-HHMM-workflow-report.md`.
6. Allows multiple users to view the status without inconsistencies.

**Integration Verification:**
- **IV1:** Board reads registered data (logs, notes) without requiring a new folder structure.
- **IV2:** Checkpoints continue to require explicit manual validation.
- **IV3:** Instrumentation does not degrade success rate per prompt (>95%).

#### Story 1.3: Brownfield Incremental Assistant
*As a brownfield maintainer, I want an incremental assistant that compares sources/artifacts and suggests reexecutions, so that we can update existing minds without reprocessing the entire pipeline.*

**Acceptance Criteria:**
1. Detects new sources in `sources/` and differences vs `sources_master.yaml`.
2. Recommends relevant prompts (Analysis/Synthesis) to AIOS agents and generates an incremental plan.
3. Executes the checklist `BROWNFIELD_WORKFLOW.md`, recording each step with timestamp.
4. Triggers focused regression tests and saves results in `docs/logs/`.
5. Provides rollback guidance reusing previous versions (logs/notes).
6. Operates without breaking compatibility with minds v3.0.

**Integration Verification:**
- **IV1:** Updates preserve structure and ACS conventions.
- **IV2:** Differences are recorded with pre/post comparisons.
- **IV3:** Brownfield execution does not increase total pipeline time by >10%.

#### Story 1.4: Auto-Execution Engine (Full Automation with Parallel + Quality)
**📄 Story File**: [story-1.4-auto-execution-engine.md](../stories/story-1.4-auto-execution-engine.md)
**Status**: ✅ COMPLETE (2025-10-06)

*As a pipeline operator, I want full automation with parallel execution and quality gates, so that I can clone minds with 1 command while maintaining quality.*

**Acceptance Criteria:**
1. Single command executes full pipeline (viability → testing) with zero manual intervention
2. Parallel execution of independent prompts (3x speedup for analysis phase)
3. Automated checkpoint validation with quality gates
4. Token optimization (50% reduction via smart batching)
5. Multi-mind batch execution support
6. Crash recovery and resume capability
7. Comprehensive error handling and rollback
8. Integration with launcher and telemetry

**Integration Verification:**
- **IV1:** Auto-execution maintains >95% success rate
- **IV2:** Parallel execution respects dependencies (no race conditions)
- **IV3:** Quality gates prevent bad outputs from progressing

**Implementation Notes:**
- Delivered 1,237 LOC across 8 modules
- 3 bugs found and fixed during development
- All performance targets met or exceeded
- Replaced original Story 1.4 concept (AIOS Notes & Handoff Engine) based on user feedback prioritizing automation

**Story Sequencing:** 1.1 → 1.2 → 1.3 → 1.4, allowing construction of orchestration → visibility → maintenance → automation.

**Future Work (Deferred):**
- Original Story 1.4 concept (AIOS Notes & Handoff Engine) was deferred based on user feedback. This feature may be revisited in Epic 2 or as Story 1.5 after Epic 1 completion.

---
## 5. Next Steps

### Fase 1: AIOS-first Orchestration (Prioridade Imediata)
1. Implementar Story 1.1 (launcher AIOS) e documentar uso padrão.
2. Configurar board/telemetria (Story 1.2) e validar checkpoints humanos.
3. Criar assistente brownfield incremental (Story 1.3) e executar piloto em mind existente.
4. Implantar motor de notas/handoff (Story 1.4) e testar colaboração multiagente.
5. Atualizar documentação (`AIOS_WORKFLOW.md`, `OUTPUTS_GUIDE.md`, templates) refletindo modo AIOS-first.
6. Registrar métricas de baseline e confirmar redução de tempo/ganho de visibilidade.

### Fase 2: Automação Seletiva e Integrações (Posterior)
1. Projetar backend FastAPI/PostgreSQL para telemetria persistente e hidratação de dados.
2. Desenvolver scripts/workers para tarefas mecânicas (fetching, parsing, chunking) respeitando análise manual.
3. Integrar ClickUp e dashboards externos para monitorar pipeline em tempo real.
4. Preparar modelo de dados Supabase para galeria pública dos minds (roadmap).
5. Apoiar migração gradual de minds legados para tooling AIOS-first e monitorar regressões.

### Exemplos de Outputs Esperados (ACS V3.0)

```
/minds/steve_jobs/
├── sources/
│   ├── books/
│   ├── interviews/
│   └── sources_master.yaml
├── artifacts/                  # FLAT structure
│   ├── personality_profile.json
│   ├── cognitive_architecture.yaml
│   ├── behavioral_patterns.md
│   ├── communication_templates.md
│   └── signature_phrases.md
├── kb/                         # FLAT chunks
│   ├── chunk_001.md
│   └── chunk_002.md
├── docs/
│   ├── README.md
│   ├── MIND_BRIEF.md
│   ├── COGNITIVE_SPEC.md
│   └── logs/
│       └── 20251004-1400-viability.md
├── system_prompts/
│   └── 20250929-1400-v1.0-generalista-initial.md
└── specialists/
    └── product_designer/
        ├── kb/
        └── system_prompts/
```

---

## 6. Changelog

### v1.5 (05/10/2025) - AIOS-first Orchestration
**Novidades:**
- ✅ Novo foco AIOS-first: launcher automatizado, board de telemetria, assistente brownfield incremental, motor de notas.
- ✅ Requisitos funcionais, NFR e compatibilidade atualizados para refletir modo AIOS-first.
- ✅ Epic único “MMOS AIOS-first Orchestration” com histórias sequenciais e critérios de integração/verificação.
- ✅ Technical Assumptions revisadas: fase atual com execução orquestrada + roadmap de automação seletiva.
- ✅ Next Steps reordenados para priorizar tooling AIOS e roadmap futuro (Supabase, dashboard, ClickUp).

**Racional:**
- Gargalos identificados nos logs (ativação manual, paralelização limitada, manutenção difícil) exigem tooling AIOS-first.
- Manter documentação como single source of truth com rastreabilidade e telemetria integrada.
- Preparar terreno para integrações externas sem comprometer análise manual e estrutura ACS.

### v1.4 (04/10/2025) - Padronização MMOS + AIOS
**BREAKING CHANGES:**
- ✅ Renomeação completa: `clone_system` → `mmos` (Mind Mapper OS)
- ✅ Renomeação: `/clones/` → `/minds/`
- ✅ Descoberta crítica: AIOS é framework conversacional (NOT automation engine)
- ✅ Atualização: 42 → 47 prompts organizados em 6 fases
- ✅ Document-Centric Workflow: MIND_BRIEF.md + COGNITIVE_SPEC.md
- ✅ Estrutura ACS V3.0: sources/, artifacts/ (FLAT), kb/ (FLAT), docs/, system_prompts/, specialists/
- ✅ Workflow manual assistido por agentes AIOS (PM, Analyst, Architect, QA, Dev)

**Novos Requisitos:**
- FR17: Template MIND_BRIEF.md como single source of truth
- FR18: Template COGNITIVE_SPEC.md para DNA Mental™ em 8 layers
- FR19: Notes System para comunicação agente-a-agente (dev_notes, qa_notes, analyst_notes, etc.)

**Epic 4 Adicionado:**
- Document-Centric Workflow & Brownfield Updates
- MIND_BRIEF Template System
- COGNITIVE_SPEC Blueprint System
- Brownfield Workflow Implementation (8 steps documentados)

**Technical Assumptions atualizadas:**
- Fase 1: Workflow manual assistido (AIOS conversacional, checkpoints humanos, document-centric)
- Fase 2: Automação SELETIVA (workers apenas para tarefas mecânicas, core cognitivo permanece manual)
- Convenções: Todos arquivos texto em .md (NUNCA .txt)
- Estrutura: ACS V3.0 obrigatória

**Rationale:**
- MMOS (Mind Mapper OS) reflete melhor o propósito: mapeamento de arquiteturas cognitivas
- AIOS conversacional permite expertise especializada sem overhead de automação
- Document-centric garante single source of truth e rastreabilidade
- Brownfield Workflow permite atualizações incrementais sem refazer pipeline completo
- ACS V3.0 (artifacts/ FLAT, kb/ FLAT) simplifica upload para LLMs

### v1.3 (29/09/2025)
**BREAKING CHANGES:**
- ✅ Adicionado sistema de dupla avaliação sequencial (APEX + ICP Score)
- ✅ Atualizado de 41 para 42 prompts (novo `02_icp_match_score.md`)
- ✅ Mudança obrigatória de nomenclatura: hyphens → underscores
- ✅ Outputs movidos de `/clone_system/outputs/` para `/clones/`
- ✅ Implementação faseada: Fase 1 (local) → Fase 2 (cloud)

**Detalhes:**
- Epic 0.1 expandido com fluxo APEX → ICP e decisões automáticas
- Story 2.2 atualizada com lista completa de 42 workers
- Epic 3.1 reescrito com estrutura de outputs padronizada
- Technical Assumptions reformulado para refletir abordagem faseada
- Adicionados exemplos práticos de estrutura de outputs

**Rationale:**
- APEX < 6.0 economiza 40% de tokens ao rejeitar clones inviáveis automaticamente
- ICP Score garante relevância estratégica além de viabilidade técnica
- Underscores seguem convenção Python/YAML (melhor legibilidade)
- Separação `/clones/` vs `/clone_system/` mantém outputs separados do código

### v1.0 (29/09/2025)
- 🎉 Versão inicial do PRD
- Definição de 4 Epics principais
- Arquitetura inicial baseada em cloud-first

---

## 7. Metodologia: DNA Mental™

### Metodologia Oficial do Clone System v3.0

O Clone System v3.0 utiliza **DNA Mental™**, metodologia proprietária para clonagem cognitiva de alta fidelidade desenvolvida pela Academia Lendar[IA].

**Diferencial:** Enquanto ChatGPT e IAs comuns operam apenas na superfície linguística (30% efetividade), DNA Mental™ acessa 8 camadas progressivas de profundidade cognitiva, alcançando 94% de precisão validada em testes cegos.

---

### As 8 Camadas Cognitivas

```
SUPERFÍCIE (30% efetividade)
    ↓
Camada 1: Superfície Linguística
    - Vocabulário, tom, estruturas de frase
    - Capturada por: 02_linguistic_forensics.md
    ↓
Camada 2: Padrões de Reconhecimento
    - Sinais invisíveis que apenas eles detectam
    - Capturada por: 02_behavioral_patterns.md
    ↓
Camada 3: Modelos Mentais Mestres (50% efetividade)
    - 3-5 frameworks que governam 80% das decisões
    - Capturada por: 01_frameworks_identifier.md
    ↓
Camada 4: Arquitetura de Decisão
    - Pipeline exato de pensamento → ação
    - Capturada por: 02_decision_analysis.md
    ↓
Camada 5: Hierarquia de Valores (70% efetividade)
    - Constituição invisível que governa trade-offs
    - Capturada por: 03_values_hierarchy.yaml
    ↓
Camada 6: Obsessões Core
    - Drivers psicológicos profundos
    - Capturada por: 03_belief_system.md
    ↓
Camada 7: Singularidade Cognitiva (85% efetividade)
    - Impressão digital mental única
    - Capturada por: 04_cognitive_architecture.yaml
    ↓
Camada 8: Paradoxos Produtivos (94% efetividade)
    - Contradições que se tornam superpoderes
    - Capturada por: 03_contradictions_map.md
```

---

### Aplicação no Pipeline de 42 Prompts

#### **ETAPA 1-2: VIABILITY + RESEARCH**
- Avalia se fontes disponíveis permitem acessar todas as 8 camadas
- Prioriza material que revela camadas profundas (6-8)

#### **ETAPA 3: ANALYSIS** ⭐ Core do DNA Mental
Cada um dos 14 prompts de análise mapeia camadas específicas:

| Prompt | Camada | Captura |
|--------|--------|---------|
| `02_linguistic_forensics.md` | 1 | Superfície Linguística |
| `02_behavioral_patterns.md` | 2 | Padrões de Reconhecimento |
| `01_frameworks_identifier.md` | 3 | Modelos Mentais (3-5 frameworks) |
| `02_decision_analysis.md` | 4 | Arquitetura de Decisão (pipeline) |
| `03_values_hierarchy.yaml` | 5 | Hierarquia de Valores (trade-offs) |
| `03_belief_system.md` | 6 | Obsessões Core (drivers) |
| `04_cognitive_architecture.yaml` | 7 | Singularidade Cognitiva (único) |
| `03_contradictions_map.md` | 8 | Paradoxos Produtivos (tensões) |

#### **ETAPA 4: SYNTHESIS**
- Templates e frameworks extraídos (foco camadas 1-3)
- KB organizado por profundidade de camada

#### **ETAPA 5: IMPLEMENTATION**
- System prompts generalistas integram todas as 8 camadas
- Especialistas focam em camadas relevantes à área:
  - Copywriter: Camadas 1-3 (superfície + padrões + modelos)
  - Estrategista: Camadas 3-5 (modelos + decisão + valores)
  - Conselheiro: Camadas 5-8 (valores + essência completa)

#### **ETAPA 6: TESTING**
- Validação de cada camada separadamente
- Teste final crítico: Camada 8 (paradoxos funcionando)

---

### Comparação de Efetividade

| Sistema | Camadas Acessadas | Efetividade | Caso de Uso |
|---------|-------------------|-------------|-------------|
| ChatGPT | Camada 1 | 30% | Imitação superficial |
| IAs Avançadas | Camadas 1-3 | 50% | Replicação de processos |
| Clone System (Básico) | Camadas 1-6 | 70% | Emulação funcional |
| Clone System (Full) | Camadas 1-8 | 94% | Clonagem de alta fidelidade |

---

### Casos Validados

**Eugênio (Clone Hormozi - 8 Camadas):**
- Resultado: R$47.000 em 12 minutos
- Camadas ativadas: Todas, com foco em Paradoxo grátis/premium (C8)
- Validação: Cliente sentiu estar falando com Hormozi real

**Thaís (Clone Hormozi - 8 Camadas):**
- Resultado: Lançamento completo em 5 horas (antes: 5 dias)
- Camadas ativadas: Obsessões core (C6) + Arquitetura de decisão (C4)
- Validação: Estratégia indistinguível de consultoria real

**Teste Cego (Clone Jobs):**
- 94% dos avaliadores não distinguiram clone de Jobs real
- Camadas 7-8 (singularidade + paradoxos) foram diferenciais críticos

---

### Alertas Críticos

**Camadas 1-4: Relativamente Objetivas**
- Dados observáveis em fontes públicas
- Validação cruzada possível
- Menor risco de alucinação

**Camadas 5-8: Requerem Inferência Profunda**
- Exigem triangulação de múltiplas fontes (mínimo 3 evidências)
- Maior risco de viés ou projeção
- **OBRIGATÓRIO:** Validação humana (human-in-the-loop)
- Documentar nível de confiança (alto/médio/baixo)

**Camada 8: Zona de Risco Máximo**
- Paradoxos mal mapeados quebram completamente o clone
- Exigem 3+ evidências independentes
- Checkpoint humano obrigatório antes de produção

---

### Referências Técnicas

- **Metodologia completa:** `/clone_system/docs/DNA_MENTAL_METHODOLOGY.md`
- **Implementação técnica:** `/clone_system/docs/PROMPT_ENGINEERING_GUIDE.md`
- **Outputs por camada:** `/docs/OUTPUTS_GUIDE.md`
- **Pipeline completo:** `/clone_system/README.md`

---

**Filosofia DNA Mental™:**

*"8 Camadas Cognitivas. ChatGPT acessa 1. Nós acessamos todas."*

*Cada camada mais profunda = 10x mais poder.*
*8 camadas = transformação exponencial.*