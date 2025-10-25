# 2. Requirements

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
