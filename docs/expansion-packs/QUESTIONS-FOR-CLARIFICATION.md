# Expansion Packs - Questions for Clarification

**Purpose:** Comprehensive questionnaire to clarify expansion pack system details

**Instructions:** Answer each question with as much detail as needed. Skip questions that are not relevant.

**Date:** 2025-10-27

---

## 📦 Section 1: Expansion Pack Clarifications

### 1.1 Fragments → InnerLens Unification

**Context:** You mentioned Fragments started as InnerLens but became complex, and now should be unified back.

**Q1.1.1:** What parts of Fragments should be merged into InnerLens?
- [ ] All of it - Fragments directory should disappear entirely
- [ ] Specific components only (list which ones):
- [ ] Keep separate but better define relationship

A pasta Fragments é onde eu mais otimizei com método KISS o formato de captação de fragmentos, nada dele deve ser perdido e sim salvo em InnerLens para revisarmos e melhorarmos. Eu tinha pensado em deixar InnerLens para correlações de traços de personalidade e analise profunda psycometrica e fragmentos com motor de extração de fragmentos apenas. Será que é uma boa?

**Q1.1.2:** What made InnerLens complex and necessitated Fragments split initially?
- What was the complexity? (technical debt, feature bloat, architectural issue?)
- Should we address that complexity before/during unification?

O processo de fragmento começou a ficar confuso, innerlens, tem muito arquivo antigo, precisaria analisar bem, criar um log, a falta de clareza e simplfiicação fez eu criar fragments.

**Q1.1.3:** Current Fragments directory contains:
```
expansion-packs/fragments/
├── docs/research/
│   ├── exemplo de extração manual com Claude App/
│   │   ├── EXTRACTION_REPORT.md
│   │   ├── mmos-fragments/ (Kapil Gupta fragments)
│   │   └── validate_fragments.py
│   ├── fragment_segmentation_rules_mmos_v5_0.md
│   ├── fragment_taxonomy_mmos_v5.0_english.md
│   └── source_taxonomy_mmos_v5.0_english.md
└── expansion.yaml
```

**Which of these should:**
- Move to InnerLens? (list paths)
- Move to MMOS? (if MMOS-specific)
- Be deleted? (if obsolete)
- Stay in separate "research" area?

**Q1.1.4:** InnerLens currently has MIU extraction. Fragments has fragment taxonomy. Are these:
- [ ] Same thing, different names → Unify under one name
- [X] Different concepts → Need clear distinction
- [X] Fragments is more advanced version → Upgrade InnerLens

**Q1.1.5:** After unification, InnerLens should be:
- [ ] Simple: Big Five only (current v1.1.0)
- [ ] Enhanced: Big Five + advanced fragment taxonomy
- [X] Modular: Core (Big Five) + optional advanced modules

**Q1.1.6:** Timeline for unification:
- [X] Immediate (do it now)
- [ ] Next sprint
- [ ] After current InnerLens v1.1.0 stabilizes
- [ ] Low priority, revisit later

---

### 1.2 ETL Clarification

**Context:** You deleted "etl" variant, only ETL Data Collector exists.

**Q1.2.1:** Confirmed expansion packs are now:
1. MMOS (v3.0)
2. CreatorOS (v2.0.0)
3. InnerLens (v1.1.0) - will absorb Fragments
4. ETL Data Collector (v1.0.0)
5. SuperAgentes (v2.0.0)

Is this correct? Any others I missed?

**Q1.2.2:** I see `expansion-packs/etl/` directory exists. Should this be:
- [ ] Deleted entirely (obsolete)
- [ ] Renamed to `etl-data-collector` for consistency
- [ ] Kept as-is (different from expansion pack, maybe internal tools?)
Já deletei etl-data-collector
---

## 🔗 Section 2: Integration Details

### 2.1 ETL → MMOS Integration

Não sei responder, leia o código para entender.
A real é que quero preparar tudo isso pra acontecer 100% online com banco de dados e processos paralelos.
Mas antes quero fazer funcionar 100% local.

**Q2.1.1:** ETL writes to `outputs/minds/{slug}/sources/downloads/`. Does MMOS:
- [ ] Auto-detect new files and start processing?
- [ ] Require manual `*map {slug}` command after ETL completes?
- [ ] Have a watch mode that triggers on new files?

**Q2.1.2:** When user runs `*map {slug}`, does MMOS:
- [ ] Only process files in `sources/downloads/` (ETL output)?
- [ ] Also look in `sources/` root for manually-added files?
- [ ] Merge both (ETL + manual files)?

**Q2.1.3:** File format requirements:
- What encodings does MMOS accept? (UTF-8 only, or others?)
- What file types? (`.md`, `.txt`, `.pdf` - which are supported?)
- Any file size limits?
- Any naming conventions required?

**Q2.1.4:** ETL creates `COLLECTION_SUMMARY.yaml`. Does MMOS:
- [ ] Read this file for metadata?
- [ ] Ignore it (just processes files directly)?
- [ ] Use it for optimization (skip already-processed sources)?

---

### 2.2 InnerLens → MMOS Integration

**Q2.2.1:** InnerLens writes `psychometric-profile.yaml`. When does MMOS read it?
- [ ] Automatically during Phase 4 (Synthesis) if file exists
- [ ] Only if user passes `--use-innerlens` flag
- [ ] Manually via separate command `*enrich-with-psychology`

Assim que InnerLens estiver funcionando, ela vai ser um motor essencial para MMOS, pois vai fornecer os fragmentos que serão analisados e relatórios com base neles. InnerLens é cliente de MMOS.

**Q2.2.2:** If InnerLens profile is missing, does MMOS:
- [ ] Proceed without personality layer (fidelity: 94%)
- [ ] Warn user but continue
- [X] Offer to run InnerLens automatically
- [ ] Fail and require InnerLens

**Q2.2.3:** InnerLens Big Five scores integration:
- Where in the system prompt does Big Five appear? (specific section name?) ele nao é mostado no system_prompt de forma direta e sim indireta assim como todas outras analises comportamentais.
- How does MMOS use the scores? (just display, or actively shapes generation?)  shapes generation, mas no catalago de clones ele mostra tb.
- Does CreatorOS read Big Five from system prompt or from `psychometric-profile.yaml`? Yes

Não devemos ser limitados ao Big Five.

**Q2.2.4:** InnerLens also writes to database (`sources`, `fragments`, `big_five_profiles` tables).
- Does MMOS read from database or from YAML file? hoje le de YAML, mas queremos que seja lendo do banco de dados.
- Should we prioritize one source over the other? assim que tivermos tudo em db, apenas db

---

### 2.3 MMOS → CreatorOS Integration

**Q2.3.1:** CreatorOS reads system prompt from `outputs/minds/{slug}/system_prompts/generalista.md`.

When generating course, does CreatorOS:
- [ ] Load entire system prompt into generation context?
- [ ] Extract specific sections only (which ones?)
- [ ] Parse and apply different sections differently?

Deveriamos criar um promtp específico como professor.

**Q2.3.2:** Voice fidelity is 90%+ with MMOS mind. How is this validated?
- Automatic scoring algorithm? Via LLM tentar fazer a validação.
- Manual review? O professor revisa.
- Specific metrics? (vocabulary match, syntax similarity, etc.) Todas possíveis.

**Q2.3.3:** If system prompt missing (no MMOS mind), CreatorOS falls back to:
- [X] Rule-based voice extraction from source transcripts
- [ ] Generic instructor voice
- [X] Asks user to provide voice guidelines (se nao tiver transcrpts ou os dados forem insuficientes)

Where does it look for source transcripts in fallback mode?

**Q2.3.4:** Can CreatorOS use multiple minds in one course?
- Example: Intro by Naval, Technical by YC founder, Case studies by entrepreneur
- [X] Not supported yet | mas é uma feature bem interessante, seria bom isso.
- [ ] Supported, how? (per lesson? per module?)

---

### 2.4 SuperAgentes Integration

**Q2.4.1:** SuperAgentes (DB Sage) manages database schema.

When another pack needs schema change:
- [ ] They create SQL migration file themselves, DB Sage reviews
- [X] They request from DB Sage, DB Sage creates migration
- [ ] They can modify their own tables, DB Sage only for shared tables

NADA, nem ninguem pode fazer nada sobre database, apenas db-sage.

**Q2.4.2:** SuperAgentes (Design System) generates UI tokens.

Current integration with other packs:
- [ ] Not integrated yet (standalone)
- [ ] MMOS uses tokens for UI? (what UI does MMOS have?)
- [ ] CreatorOS uses tokens for course platform UI?
- [ ] Future integration planned (describe vision)

Qualquer criação de UX precisa passar pelo design-system, ele é nosso front-end.

**Q2.4.3:** DB Sage has rollback capability via snapshots.

Who can trigger rollback?
- [ ] Any pack can call `*rollback {snapshot}`
- [X] Only DB Sage operator
- [ ] Automated on migration failure

---

## 🔄 Section 3: Workflow Clarifications

### 3.1 Complete Mind Creation Workflow (WF-001)

**Q3.1.1:** You want a fully automated `create-mind-and-course` workflow.

Desired user experience:
```bash
*create-mind-and-course naval startup-fundamentals
```

What should happen automatically:
- [X] Prompt for sources.yaml (list YouTube, blogs, PDFs)
- [X] Run ETL collection (4-8 hours)
- [X] Auto-run InnerLens analysis
- [X] Auto-run MMOS mapping (15-20 hours)
- [X] Prompt for COURSE-BRIEF.md
- [X] Auto-run CreatorOS generation (45-75 min)
- [X] Return complete course in Naval's voice

Is this the vision? Any modifications?

Contudo, com vários pontos de checkpoints.

**Q3.1.2:** For this workflow, where should orchestration live?
- [ ] New "workflow orchestrator" pack
- [X] AIOS master agent coordinates
- [ ] Simple bash script in `scripts/workflows/`
- [ ] CreatorOS has workflow mode

**Q3.1.3:** Error handling in long workflow:

If ETL fails at 3 hours:
- [ ] Abort entire workflow
- [ ] Retry ETL automatically
- [ ] Prompt user for manual intervention
- [X] Continue with partial sources

If MMOS fails after 10 hours:
- [ ] Abort (lose 10 hours of work)
- [X] Resume from checkpoint
- [X] Save partial mind, allow manual continuation

**Q3.1.4:** Workflow state persistence:

Should we store workflow state in database?
- [X] Yes - track progress, allow resume
- [ ] No - workflows are single-shot
- [ ] Optional - only for long workflows (>1 hour)

---

### 3.2 Brownfield Course Upgrade (WF-004)

**Q3.2.1:** User places legacy course materials in `outputs/courses/{slug}/sources/`.

CreatorOS auto-detects:
- Videos (`.mp4`, `.avi`, etc.) → needs ffmpeg + AssemblyAI
- Transcripts (`.txt`, `.srt`) → direct processing
- PDFs → text extraction

If user has videos but no AssemblyAI key:
- [ ] Fail with error "Add ASSEMBLYAI_API_KEY"
- [ ] Skip videos, use only transcripts/PDFs
- [X] Offer manual transcription instructions

Avisa que não tem assembly, mas deveria usar expansion pack ETL, se não ETL  fica inútil.

**Q3.2.2:** Voice extraction from legacy transcripts.

If transcripts have multiple speakers:
- [ ] Extract all speakers (mixed voice)
- [X] Attempt to identify instructor (how?)
- [X] Prompt user to mark instructor in transcript
- [X] Use speaker diarization (like ETL)

**Q3.2.3:** CreatorOS extracts 60-80% of COURSE-BRIEF automatically.

Which sections are hardest to extract?
- ICP (target audience)? 
- Learning objectives? 
- Prerequisites? +++
- Pricing/marketing info? não é sempre necessário

Should we prompt for missing sections or generate best-guess?

---

### 3.3 Standalone Personality Analysis (WF-002)

**Q3.3.1:** InnerLens can run standalone (without MMOS).

Primary use cases:
- [ ] Job candidate screening (non-decision, just insight)
- [ ] Self-analysis
- [ ] Research studies
- [ ] Content personalization (adapt to reader personality)
- [ ] Other: __________

Sim, pode, mas ela precisa de qualquer forma usar a tabela minds.

**Q3.3.2:** Privacy implications:

For job candidate screening:
- Should we block this use case? (ethical concerns)
- Add strong disclaimers?
- Require explicit consent flow?
- Log usage for audit?

Na fase de MVP, vamos ignorar essa parte.

**Q3.3.3:** InnerLens output format:

Who consumes `bigfive-profile.yaml` besides MMOS?
- [ ] CreatorOS (adapt content to learner personality)
- [ ] External applications via API
- [ ] Human review only
- [ ] Research/analytics pipelines

---

## 🏗️ Section 4: Architecture Decisions

### 4.1 Database Architecture

**Q4.1.1:** Current: Single database (`outputs/database/mmos.db`).

Future scaling considerations:
- What's the expected database size? (MB, GB, TB?)
- How many minds? (10s, 100s, 1000s?)
- How many courses? (10s, 100s, 1000s?)

Should we plan for:
- [ ] SQLite is sufficient (< 1GB)
- [ ] Migrate to PostgreSQL eventually (> 10GB)
- [ ] Sharding strategy (separate DB per mind?)

Já estamos com supabase funcionando. Vamos preparar tudo para muita escala, principalmente innerlens.

**Q4.1.2:** Database location: `outputs/database/mmos.db`

Should we rename to `mente-lendaria.db` (more generic)?
- Pros: Not MMOS-specific, all packs use it
- Cons: Historical reasons, MMOS created it

Esse banco está sendo descontinuado, isso não é relevante.

**Q4.1.3:** Table ownership model:

Currently:
- MMOS owns: `minds`, `cognitive_specs`, `mind_fragments`
- InnerLens owns: `sources`, `fragments`, `big_five_profiles`
- CreatorOS owns: `courses`, `lessons`, `content_pieces`, etc.

Is this correct? Any changes needed?

Sim

**Q4.1.4:** Database migrations:

Who can create migrations?
- [X] Only DB Sage (SuperAgentes)
- [ ] Any pack for their own tables
- [ ] Any pack, but DB Sage reviews before applying

Where should migration files live?
- [X] `db/migrations/` ou `supabase/migrations` (central)
- [ ] `expansion-packs/{pack}/migrations/` (distributed)
- [ ] Both (pack creates, then copies to central)

---

### 4.2 File System Architecture

**Q4.2.1:** Current output structure:

```
outputs/
├── database/mmos.db
├── minds/{slug}/
└── courses/{slug}/
```

Should we add:
- [ ] `outputs/analyses/{slug}/` for standalone InnerLens profiles?
- [ ] `outputs/collections/{slug}/` for standalone ETL results?
- [X] Keep everything under minds/ or courses/

**Q4.2.2:** Naming conventions:

Mind slugs: `naval_ravikant` (snake_case)
Course slugs: `startup-fundamentals` (kebab-case)

Should we standardize?
- [ ] All snake_case
- [ ] All kebab-case
- [X] Keep mixed (minds: snake, courses: kebab)

Para slug de pessoas sempre _ igual nas redes sociais.

**Q4.2.3:** File permissions:

Who can write to `outputs/minds/{slug}/`?
- [ ] Only MMOS
- [ ] MMOS + InnerLens (for analysis/)
- [X] Any pack that extends the mind

Isso é temporário, não importa tanto pq estamos migrando.
---

### 4.3 Contract Architecture

**Q4.3.1:** Contract versioning strategy:

When MMOS upgrades system prompt format (v1.0.0 → v1.1.0):
- [ ] Update contract, CreatorOS must update
- [ ] Support both v1.0.0 and v1.1.0 simultaneously
- [ ] Deprecate v1.0.0 with 3-month sunset

Quando tiver muitos dados novos.

**Q4.3.2:** Contract validation:

Should we build automatic contract validators?
- [X] Yes - validate on every write
- [ ] Yes - but only in tests
- [ ] No - manual review sufficient
- [ ] Optional - packs can enable if desired

Não tenho certeza, mas acredito que sim.

**Q4.3.3:** Contract evolution example:

MMOS v1.0.0 system prompt has:
- Cognitive Patterns (required)
- Communication Style (required)

MMOS v1.1.0 adds:
- Big Five Profile (optional)

CreatorOS v1.0.0 expects only required sections.

Is this the right pattern?

Ta muito fraco, precisamos desenhar melhor.

---

## 🎯 Section 5: Priorities & Roadmap

### 5.1 Next Sprint Priorities

**Q5.1.1:** What should we prioritize FIRST?

Rank these 1-5 (1 = highest priority):
- [ 1] Create 3 contract files (etl-mmos, innerlens-mmos, mmos-creator-os)
- [ 2] Unify Fragments into InnerLens
- [ 3] Document individual packs in `docs/expansion-packs/packs/`
- [ 4] Create first system-level epic (propose specific epic)
- [ 5] Setup integration tests

**Q5.1.2:** First system-level epic:

What cross-pack feature should we build first?
- [ 2] Voice Fidelity Boost (MMOS + InnerLens + CreatorOS)
- [ 1] Workflow Automation (orchestrate full pipeline)
- [ ] Multi-Mind Collaboration (CreatorOS with multiple voices)
- [ ] Real-Time Analysis (InnerLens streaming mode)
- [ ] Other: __________

**Q5.1.3:** Integration test priority:

Which integration should we test first?
- [ ] ETL → MMOS (most foundational)
- [ ] MMOS → CreatorOS (highest value)
- [ ] InnerLens → MMOS (optional, can wait)
- [X] All three in parallel

---

### 5.2 Long-Term Vision

**Q5.2.1:** Mente Lendária as a platform:

In 6-12 months, do you envision:
- [ ] Internal tool (just for your use)
- [ ] Open source project (community contributors)
- [X] SaaS product (paid users)
- [ ] Mix: Open core + premium features

**Q5.2.2:** API layer:

Should we add REST API in the future?
- [X] Yes - external apps can use expansion packs
- [ ] No - file-based integration sufficient
- [ ] Maybe - only for specific packs (which?)

**Q5.2.3:** UI layer:

Currently CLI-only (`@agent *command`). Future:
- [X] Add web UI (dashboard for managing minds/courses)
- [ ] Keep CLI, add API (let others build UIs)
- [ ] CLI is sufficient

**Q5.2.4:** New expansion packs planned:

Are there other packs you're planning?
- Marketing automation?
- Distribution/publishing?
- Analytics/insights?
- Community management?
- Other: __________

Marketing dentro de CreatorOS, só isso por enquanto.

---

## 🧩 Section 6: Edge Cases & Complex Scenarios

### 6.1 Multi-Version Support

**Q6.1.1:** User has mind created with MMOS v2.0 (old format).

When running CreatorOS v2.0 (expects v3.0 format):
- [ ] Auto-upgrade mind to v3.0
- [ ] Fail with "Please re-run MMOS v3.0"
- [ ] Support both formats (backward compatible)

Não entendi.

**Q6.1.2:** User has courses generated with CreatorOS v1.0.

When upgrading to v2.0 (new format):
- [X] Migrate all existing courses
- [ ] Keep v1.0 courses as-is, new ones in v2.0
- [ ] Provide migration tool (*migrate-course)

---

### 6.2 Concurrent Operations

**Q6.2.1:** User runs two MMOS mappings simultaneously:
```bash
# Terminal 1
*map naval

# Terminal 2
*map daniel_kahneman
```

Database handling:
- [ ] SQLite locks, second waits for first
- [ ] Both run in parallel (SQLite allows multiple readers)
- [ ] Explicitly prevent concurrent writes

Esquece SQLite, ele já é decraptado.

**Q6.2.2:** User edits sources while MMOS is running:

User adds new transcript to `outputs/minds/naval/sources/` while `*map naval` running.

MMOS should:
- [ ] Detect change, restart processing
- [ ] Ignore, finish with original sources
- [X] Detect, queue for next run

---

### 6.3 Partial Failures

**Q6.3.1:** ETL collects 10 sources, 8 succeed, 2 fail (network error).

Should ETL:
- [X] Return 8 successful sources, log 2 failures
- [ ] Fail entire collection (all-or-nothing)
- [ ] Retry failed sources (how many times?)

**Q6.3.2:** MMOS processes 50 fragments, analysis fails on fragment #37.

Should MMOS:
- [ ] Save analysis for fragments 1-36, report error on 37
- [X] Discard all, require re-run
- [ ] Skip fragment 37, continue with 38-50

**Q6.3.3:** CreatorOS generates 30 lessons, lesson #15 fails validation.

Should CreatorOS:
- [X] Regenerate only lesson #15
- [ ] Regenerate from #15 onwards
- [ ] Fail entire course generation

---

### 6.4 Data Consistency

**Q6.4.1:** User manually edits system prompt file:

User changes `outputs/minds/naval/system_prompts/generalista.md` directly.

CreatorOS should:
- [ ] Trust manual edit, use modified prompt
- [ ] Detect change, warn about manual edit
- [X] Reject manual edits (re-run MMOS to update)

**Q6.4.2:** Database and file system out of sync:

Database says mind "naval" has 94% fidelity, but system prompt file is from older v2.0 run.

System should:
- [ ] Trust database, warn about file mismatch
- [ ] Trust file, update database
- [X] Detect conflict, prompt user

Me explique mais.
---

## 🔐 Section 7: Security & Privacy

### 7.1 Data Privacy

**Q7.1.1:** PII (Personally Identifiable Information) handling:

InnerLens processes personal text (interviews, emails, etc.).

Should we:
- [X] Add PII detection/redaction before storage
- [ ] Trust users to not include sensitive PII
- [X] Add consent/warning in UI
- [ ] Store analysis, delete source text after processing


**Q7.1.2:** Sensitive personality data:

Big Five profiles can reveal sensitive traits (neuroticism, etc.).

Database classification:
- [ ] All profiles marked PRIVATE (never share)
- [ ] User chooses: PUBLIC, PRIVATE, SENSITIVE
- [ ] Different traits have different privacy levels

Queremos colocar esses dados publicos das pessoas públicas.

**Q7.1.3:** GDPR/LGPD compliance:

Right to deletion:
- [ ] Implement `*delete-mind {slug}` (cascade delete)
- [ ] Soft delete (mark as deleted, keep data)
- [X] Not applicable (internal tool only)

---

### 7.2 API Key Management

**Q7.2.1:** API keys in use:

- Anthropic Claude API (MMOS, InnerLens, CreatorOS)
- AssemblyAI (ETL transcription)
- OpenAI (fallback)
- Others?

Storage strategy:
- [X] Environment variables (`.env` file)
- [ ] Encrypted keychain
- [ ] Cloud secrets manager (AWS Secrets, GCP Secret Manager)

**Q7.2.2:** API key rotation:

Should we support automatic key rotation?
- [X] Yes - check for new keys periodically
- [ ] No - manual rotation only
- [X] Alert when key approaching limit

---

## 🎨 Section 8: User Experience

### 8.1 Command Discoverability

**Q8.1.1:** New user starts with Mente Lendária.

Onboarding flow:
- [X] `*help` shows all expansion packs + commands
- [ ] Guided tutorial (`*tutorial`)
- [ ] Interactive wizard (`*wizard create-mind`)
- [ ] Just documentation (read docs)

**Q8.1.2:** Command naming consistency:

Current:
- MMOS: `*map {slug}`
- CreatorOS: `*new {slug}` (greenfield), `*upgrade {slug}` (brownfield)
- InnerLens: `*detect-traits-quick`

Should we standardize?
- [X] All packs use `*create`, `*update`, `*analyze`
- [ ] Keep pack-specific terminology (more intuitive)

---

### 8.2 Progress Feedback

**Q8.2.1:** Long-running operations:

MMOS takes 15-20 hours. User wants to know:
- [X] Real-time progress (Phase 2: 45% complete)
- [X] Milestone updates (Phase 2 started, Phase 2 complete)
- [X] Time estimates (ETA: 3 hours remaining)
- [ ] Just spinner (no progress info)

How to show progress:
- [X] Terminal output (print to stdout)
- [X] Log file (tail -f logs/mmos-naval.log)
- [X] Database table (progress_tracking)
- [X] Web dashboard

**Q8.2.2:** Background operations:

User starts MMOS mapping (15 hours), closes terminal.

Should operation:
- [ ] Stop (requires terminal open)
- [X] Continue in background (daemonize)
- [ ] Transfer to background service (systemd, PM2)

Em breve em um servidor externo, para não depender do local e do terminal.
---

### 8.3 Error Messages

**Q8.3.1:** Error message quality:

When MMOS fails, should error message include:
- [ ] Just error text ("Analysis failed")
- [ ] Error + context ("Analysis failed on fragment 37/50")
- [2] Error + suggestion ("Analysis failed. Try: *retry-fragment 37")
- [1] Error + automatic recovery ("Analysis failed, retrying...")

Tentar fazer nessa ordem.

**Q8.3.2:** Error reporting:

Should errors be:
- [ ] Logged to file only
- [X] Displayed in terminal + logged
- [ ] Sent to monitoring service (Sentry, etc.)
- [ ] Stored in database (errors table)

---

## 🧪 Section 9: Testing Strategy

### 9.1 Integration Testing

**Q9.1.1:** Integration test execution:

How should integration tests run?
- [ ] Manually (`npm run test:integration`)
- [ ] On every commit (CI/CD)
- [ ] Nightly (too slow for every commit)
- [ ] On-demand only

Qual a melhor forma?

**Q9.1.2:** Test data:

Integration tests need test minds/courses.

Should we:
- [X] Use real data (Naval, etc.) - slower but realistic
- [ ] Mock data - faster but less realistic
- [ ] Mix: Unit tests (mocks), Integration tests (real data)

**Q9.1.3:** Test isolation:

Integration test creates test mind in `outputs/minds/test-naval/`.

After test:
- [X] Delete test artifacts
- [ ] Keep for debugging
- [X] Store in separate `outputs/test/` directory

---

### 9.2 Contract Testing

**Q9.2.1:** Contract validation:

When should contracts be validated?
- [ ] On every data write (runtime validation)
- [ ] In tests only
- [ ] CI/CD only
- [ ] Manual validation command (*validate-contract)


Não sei.

**Q9.2.2:** Contract breaking changes:

If MMOS accidentally breaks contract (writes invalid data):

Should system:
- [X] Detect and reject write
- [ ] Log warning but allow
- [X] Alert developer immediately

---

## 📊 Section 10: Monitoring & Observability

### 10.1 System Health

**Q10.1.1:** Health checks:

Should we implement:
- [ ] `*health` command (check all packs)
- [X] Per-pack health (`*health mmos`)
- [ ] Not needed (manual inspection)

What to check:
- [X] Database accessible
- [ ] API keys valid
- [ ] Disk space sufficient
- [X] Dependencies installed

**Q10.1.2:** Performance monitoring:

Should we track:
- [X] Operation durations (MMOS mapping: 18.5 hours)
- [X] Token usage (cost tracking)
- [X] Success/failure rates
- [ ] Resource usage (CPU, memory, disk)

Where to store metrics:
- [X] Database (metrics table)
- [X] Monitoring service (Prometheus, Grafana)
- [ ] Log files only

---

### 10.2 Debugging

**Q10.2.1:** Debug mode:

Should we support:
- [ ] `AIOS_DEBUG=true *map naval` (verbose output)
- [ ] Debug mode in config
- [X] Separate debug commands (*debug-map naval)

Me explica mais isso.

**Q10.2.2:** Traceability:

When investigating issue, should we be able to trace:
- [ ] Mind → sources used → fragments extracted → analysis results
- [ ] Course → mind used → lessons generated → validations
- [X] All operations → execution ID → logs → artifacts

How to implement:
- [ ] Database foreign keys (full traceability)
- [ ] Execution ID in logs
- [ ] Metadata files in output directories

nao sei.

---

## ✅ Section 11: Immediate Action Items

Based on your answers, what should I do FIRST?

**Q11.1:** Top 3 priorities for next session:

1. Validarmos todas informações respondidas aqui, me explicar o que precisa e perguntar o que faltou.
2. Iniciar integração entre expansions com plano bem feito.
3. Focar na integração InnerLens com MMOS.

**Q11.2:** Blockers:

Any blockers preventing progress?
- Missing information: __________
- Technical constraints: __________
- Need decision on: __________

**Q11.3:** Quick wins:

What can be done quickly (<1 hour) that adds value?
- Create specific contract files?
- Update specific documentation?
- Clarify specific integration?

---

## 📝 Additional Notes & Open Questions

**Your thoughts, concerns, or additional questions:**

[Space for free-form notes]

---

**Thank you for taking the time to answer these questions!**

This will ensure we have maximum clarity and can build a robust, well-integrated expansion pack system.

**Instructions for responding:**
- Answer directly inline (edit this file)
- Use checkboxes [x] where provided
- Add detail where needed
- Skip irrelevant questions
- Add new questions if something is unclear

**Next steps after you answer:**
1. I'll review all responses
2. Create contracts based on answers
3. Update architecture docs
4. Begin implementation of prioritized items
