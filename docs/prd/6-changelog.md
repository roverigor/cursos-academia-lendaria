# 6. Changelog

## v1.5 (05/10/2025) - AIOS-first Orchestration
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

## v1.4 (04/10/2025) - Padronização MMOS + AIOS
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

## v1.3 (29/09/2025)
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

## v1.0 (29/09/2025)
- 🎉 Versão inicial do PRD
- Definição de 4 Epics principais
- Arquitetura inicial baseada em cloud-first

---
