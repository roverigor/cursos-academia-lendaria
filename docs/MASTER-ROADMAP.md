# Mente Lendária – Master Roadmap

**Last Updated:** 2025-10-29 _(update when the plan changes)_

This document consolidates every active initiative, partially delivered idea, and future roadmap item into a single source of truth. Each section links back to the originating specification so owners can drill into details without hunting across the repository.

---

## Snapshot

| Initiative | Scope | Status | Next Milestone | Blockers / Notes | Source |
|------------|-------|--------|----------------|------------------|--------|
| MMOS Epics | Core platform orchestration, database, taxonomy, automation | 🚧 Epic 2 75% · Epic 1 25% · Epic 3 8% | Story 2.4 (Pipeline Integration) | Story 3.1.1 and Epic 4 wait on Story 2.4 completion | docs/mmos/epics/ROADMAP.md:1 |
| MMOS Next Steps | Product-level execution phases | 🟠 Fase 1 partially delivered | Finalize Stories 1.2–1.4 deliverables & documentation refresh | Requires telemetry board + brownfield assistant | docs/prd/5-next-steps.md:1 |
| Supabase Platform | Production Supabase schema + ingestion pipeline | ✅ v0.8.2 baseline live; Story 2.4 scripts ready | Ship fragments automation + advanced validation on new schema | Fragment automation waits for InnerLens upgrade; monitoring tooling pending | supabase/README.md:1 |
| CreatorOS | Multi-format creator operating system | ✅ Phase 0 · ⏳ Phases 1-4 | Ship Phase 1 agents & tasks (blog MVP) | Needs MMOS persona integration & fidelity validation | expansion-packs/creator-os/README.md:516 |
| InnerLens Lite | Psychometric quick-scan pack | ✅ v1.0 live · ⏳ v1.1–v2.0 | Deliver HEXACO & multimodal upgrades (v1.1) | Enables MMOS fragment automation and future triangulation | expansion-packs/innerlens/README 2.md:461 |
| SuperAgentes | Meta-orchestrator for DB & Design System | ✅ v2.0.0 deployed | Plan v2.1 cross-agent workflows | Dependent on design-to-db contract definitions | expansion-packs/super-agentes/README.md:456 |
| ETL Data Collector | Content acquisition toolkit | 🟢 MVP ready | Execute Phase 1 monitoring & feedback loop | Telegram automation pending policy approval | expansion-packs/etl/STATUS.md:1 |
| Fragments Pack | Evidence extraction & formatting | 🚧 Research phase | Define implementation roadmap & publish missing assets | Awaiting InnerLens v2.0 fragments + credential policy | expansion-packs/fragments/README.md:1 |

---

## 1. MMOS Core Platform

### 1.1 Epic Overview

- **Epic 1 – AIOS-first Orchestration:** 25% complete. Story 1.2 (orchestration board & telemetry) is the immediate focus, followed by 1.3 (brownfield assistant) and 1.4 (auto-execution engine) to unlock full automation [docs/mmos/epics/ROADMAP.md:41].
- **Epic 2 – Database & Backend Foundation:** 75% complete. Schema, taxonomy population, and mind imports are done; Story 2.4 (pipeline integration) must ship to close the epic [docs/mmos/epics/ROADMAP.md:69].
- **Epic 3 – Taxonomy Normalization & Migration:** 8% complete. Pilot (Story 3.1) is finished; full rollout (Story 3.1.1) is queued behind Story 2.4. Downstream stories (3.2–3.13) remain pending until migration stabilises [docs/mmos/epics/ROADMAP.md:112].
- **Epic 4 – Pipeline Automation:** Not started. Scope will be defined after Epics 2 and 3 clear critical blockers; expected to cover real-time sync, scoring, and analytics [docs/mmos/epics/ROADMAP.md:154].

**Critical Path:** Story 2.4 → Story 3.1.1 → Epic 4 scoping. Any delay in 2.4 cascades across taxonomy, scoring, and automation [docs/mmos/epics/ROADMAP.md:182].

### 1.2 Product Next Steps (PRD Alignment)

**Fase 1 – AIOS-first Orchestration (immediate):**
1. Finalise launcher documentation for Story 1.1.
2. Stand up telemetry board (Story 1.2) with human checkpoints.
3. Pilot the brownfield assistant on an existing mind (Story 1.3).
4. Deliver the handoff engine and multi-agent collaboration test (Story 1.4).
5. Refresh AIOS workflow documentation and templates.
6. Capture baseline metrics for time reduction and visibility gains [docs/prd/5-next-steps.md:3].

**Fase 2 – Automação Seletiva e Integrações (posterior):**
1. Design FastAPI/PostgreSQL backend for persistent telemetry.
2. Build automation workers for mechanical tasks while keeping manual review.
3. Integrate ClickUp and external dashboards for live monitoring.
4. Model Supabase gallery data for public minds.
5. Support gradual migration of legacy minds into the new tooling [docs/prd/5-next-steps.md:11].

---

## 2. Supabase Platform & Ingestion Pipeline

- **Current State:** Supabase baseline v0.8.2 is deployed with migrations, RLS policies, rollback scripts, and automated snapshots [supabase/README.md:1]. Story 2.4 ingestion scripts now target this Supabase backend instead of the legacy SQLite file.
- **Recent Deliverables:** CreatorOS database persistence, RLS tests, and deployment scripts were delivered via the October rollout package [docs/stories/DELIVERABLES-SUMMARY.md:12].
- **Upcoming Work:** Complete fragments automation, advanced validation, proficiency scoring, and tag generation to fully leverage the Supabase schema [scripts/pipeline/README.md:574].
- **Dependencies:** InnerLens roadmaps must land fragment support to unlock Story 2.4 follow-ups; MMOS Epic 3 depends on validated Supabase ingestion before scaling migrations.

---

## 3. Expansion Packs

### 3.1 CreatorOS

- **Phase 0 (Foundation):** Complete – structure, configuration, database integration, and documentation are live [expansion-packs/creator-os/README.md:516].
- **Phase 1 (Blog MVP):** Requires three agents, one task, MMOS persona integration, and fidelity validation to reach production. This is the top priority for the pack [expansion-packs/creator-os/README.md:525].
- **Phase 2 (Multi-Format Generator):** Adds social, video, newsletter, and course outputs plus higher fidelity targets [expansion-packs/creator-os/README.md:534].
- **Phase 3 (Marketing Intelligence):** Introduces funnel, A/B testing, SEO, and growth analytics roles [expansion-packs/creator-os/README.md:542].
- **Phase 4 (Advanced Features):** Plans for multi-persona collaboration, repurposing engine, InnerLens-driven adaptation, and API access [expansion-packs/creator-os/README.md:550].

### 3.2 InnerLens Lite

- **v1.0 (MVP):** Live with Big Five detection, evidence quotes, MMOS hook, and privacy controls [expansion-packs/innerlens/README 2.md:461].
- **v1.1 (Weeks 3-4):** Targets HEXACO support, multimodal analysis, and improved confidence metrics [expansion-packs/innerlens/README 2.md:470].
- **v1.2 (Weeks 5-8):** Adds Schwartz Values, VIA strengths, and cross-framework triangulation [expansion-packs/innerlens/README 2.md:476].
- **v2.0 (Future):** Plans for Reiss 16 desires, near real-time streaming, and multilingual coverage [expansion-packs/innerlens/README 2.md:482].

### 3.3 SuperAgentes

- **Current (v2.0.0):** Meta-orchestrator, DB Sage, Design System, prefix routing, agent transformation, unified help, and YAML workflows are all operational [expansion-packs/super-agentes/README.md:456].
- **Future (v2.1.0+):** Focused on cross-agent workflows, design-to-database automation, component library versioning, visual regression testing, and Figma token importers [expansion-packs/super-agentes/README.md:468].

### 3.4 ETL Data Collector

- **Status:** MVP is ready for testing with full extractor/orchestrator coverage [expansion-packs/etl/STATUS.md:1].
- **Phase 1 Priorities:** Maintain tests, monitor AssemblyAI costs, gather feedback, extend podcast support, build automated tests, improve PDF fallbacks, plan Telegram automation [expansion-packs/etl/STATUS.md:60].
- **Phase 2 Roadmap:** Expand validators, add benchmarking scripts, and integrate external dashboards [expansion-packs/etl/STATUS.md:71].

### 3.5 Fragments Expansion Pack

- **Status:** Research phase; documentation and implementation guides remain placeholders [expansion-packs/fragments/README.md:1].
- **Future Hooks:** Designed to plug into InnerLens v2.0 for multi-source synthesis, optional direct ingestion, and language-specific tuning once credential policies are resolved [expansion-packs/fragments/agents/fragment-extractor.md:273].

---

## 4. Cross-Pack Dependencies & Risks

- **Supabase ↔ InnerLens:** Story 2.4’s fragment automation and the Supabase pipeline roadmap depend on InnerLens upgrades delivering fragment extraction and scoring [scripts/pipeline/README.md:574].
- **Taxonomy Migration:** Epic 3 Story 3.1.1 cannot proceed until Story 2.4 validates the database integration path; Epic 4 remains on hold until both clear [docs/mmos/epics/ROADMAP.md:149].
- **CreatorOS Fidelity:** Phase 1 requires MMOS persona ingestion before fidelity targets can be measured, linking CreatorOS delivery to MMOS orchestration progress [expansion-packs/creator-os/README.md:531].
- **Fragments Pack:** Implementation hinges on InnerLens v2.0 fragments infrastructure and credential policy approval for direct ingestion [expansion-packs/fragments/agents/fragment-extractor.md:275].
- **Telemetry & Integrations:** PRD Fase 2 work (ClickUp dashboards, Supabase gallery) is contingent on the database foundation and AIOS-first orchestration stabilising [docs/prd/5-next-steps.md:11].

---

## 5. Usage Guidelines

- Update this master roadmap whenever status changes or new initiatives are approved.
- Keep the snapshot table aligned with the detailed sections; add new rows for future packs/epics as they emerge.
- Reference the source documents for execution details—this file is a navigational map, not a replacement for specs.
