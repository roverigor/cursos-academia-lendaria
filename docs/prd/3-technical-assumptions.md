# 3. Technical Assumptions

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