# 4. Epic Details

## Epic 1: MMOS AIOS-first Orchestration
**📄 Epic File**: [epic-1-aios-orchestration.md](../epics/epic-1-aios-orchestration.md)
**Status**: 🟡 In Progress (3/4 stories complete)

* **Epic Goal:** Transformar o pipeline MMOS em uma experiência nativa AIOS-first, eliminando execução manual dispersa e habilitando visibilidade, paralelização e manutenção incremental.
* **Integration Requirements:**
    * Reutilizar estrutura ACS v3.0 existente (`sources/`, `artifacts/`, `kb/`, `docs/`, `system_prompts/`, `specialists/`).
    * Consumir templates/documentos (`PRD.md`, `OUTPUTS_GUIDE.md`, `AIOS_WORKFLOW.md`) mantendo convenções snake_case e timestamps.
    * Operar sobre minds legados sem reprocessamento completo; brownfield assistant precisa preservar histórico/logs e oferecer rollback.
    * Integrar-se aos agentes AIOS já disponíveis (PM, Analyst, Architect, Dev, QA, PO, UX) e registrar interações em `docs/mmos/logs/`.

### Story 1.1: AIOS Launcher v1
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

### Story 1.2: Orchestration Board & Telemetria
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

### Story 1.3: Brownfield Incremental Assistant
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

### Story 1.4: Auto-Execution Engine (Full Automation with Parallel + Quality)
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