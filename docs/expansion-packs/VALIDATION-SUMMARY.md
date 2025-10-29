# Expansion Packs - Validation Summary

**Date:** 2025-10-27
**Status:** Ready for Review
**Next:** Create contracts after validation approved

---

## ✅ What's Crystal Clear

### 1. Expansion Pack Inventory

**Confirmed Active Packs:**
1. **MMOS** (v3.0) - Cognitive clone creation
2. **CreatorOS** (v2.0.0) - Course generation with voice preservation
3. **InnerLens** (v1.1.0) - Psychometric analysis + fragment extraction
4. **ETL Data Collector** (v1.0.0) - Multi-source data collection
5. **SuperAgentes** (v2.0.0) - DB Sage + Design System

**Action Items:**
- ✅ `etl-data-collector` already deleted
- ✅ `Fragments` will be unified with `InnerLens` (Priority 2)

---

### 2. Architecture Vision

**Database Strategy:**
- ✅ Supabase (PostgreSQL) is the active database
- ✅ SQLite (`SQLite legado (migrado para Supabase em 2025-10)`) is **DEPRECATED**
- ✅ Planning for **high scale**, especially InnerLens
- ✅ Migrations ONLY in `supabase/migrations/`
- ✅ **DB Sage has total control** - no pack can modify database directly

**Deployment Strategy:**
- ✅ **Phase 1:** 100% local functionality first
- ✅ **Phase 2:** 100% online with parallel processing
- ✅ **Future:** SaaS product with web UI + REST API

**Integration Patterns:**
- ✅ Currently: File-based contracts (YAML files)
- ✅ Future: Database-driven integration (read from DB, not YAML)
- ✅ All packs follow AIOS compliance (agents → tasks → workflows)

---

### 3. Key Relationships

**InnerLens ↔ MMOS:**
- ✅ InnerLens is **"essential motor for MMOS"**
- ✅ InnerLens is a **CLIENT** of MMOS (not optional enhancement)
- ✅ InnerLens provides: fragments + psychometric profiles
- ✅ Not limited to Big Five (expandable psychometrics)

**MMOS ↔ CreatorOS:**
- ✅ CreatorOS should create **specific "professor" prompt** (not generic)
- ✅ Voice fidelity target: 90%+
- ✅ Multi-mind courses: **interesting feature** (future consideration)

**SuperAgentes:**
- ✅ DB Sage: Total database control
- ✅ Design System: Frontend for ANY UX creation
- ✅ Marketing: Stays within CreatorOS

---

### 4. Workflow Automation Vision

**Desired User Experience:**
```bash
*create-mind-and-course naval startup-fundamentals
```

**Auto-orchestration:**
1. Prompt for `sources.yaml`
2. Run ETL collection (4-8 hours)
3. Auto-run InnerLens analysis
4. Auto-run MMOS mapping (15-20 hours)
5. Prompt for `COURSE-BRIEF.md`
6. Auto-run CreatorOS generation (45-75 min)
7. Return complete course in Naval's voice

**Key Requirements:**
- ✅ **Multiple checkpoints** for long-running operations
- ✅ **Resume from checkpoint** on failure
- ✅ **Continue with partial sources** if some fail
- ✅ **AIOS master agent** coordinates orchestration

---

### 5. Priorities (Your Ranking)

**Sprint 1 Priorities:**
1. **[Priority 1]** Create 3 contract files
   - `etl-mmos-v1.0.0.yaml`
   - `innerlens-mmos-v1.0.0.yaml`
   - `mmos-creator-os-v1.0.0.yaml`

2. **[Priority 2]** Unify Fragments → InnerLens
   - Save KISS optimizations from Fragments
   - Clean up old InnerLens files
   - Consider architectural separation: extraction engine vs psychometric analysis

3. **[Priority 3]** Document individual packs
   - `docs/expansion-packs/packs/mmos.md`
   - `docs/expansion-packs/packs/creator-os.md`
   - `docs/expansion-packs/packs/innerlens.md`
   - `docs/expansion-packs/packs/etl.md`
   - `docs/expansion-packs/packs/super-agentes.md`

4. **[Priority 4]** Create first system-level epic
   - #1: Workflow Automation
   - #2: Voice Fidelity Boost

5. **[Priority 5]** Setup integration tests
   - All three in parallel: ETL→MMOS, MMOS→CreatorOS, InnerLens→MMOS

---

## 🤔 What Needs Clarification

### A. Fragments ↔ InnerLens Architecture

**Your Idea:**
> "Eu tinha pensado em deixar InnerLens para correlações de traços de personalidade e analise profunda psycometrica e fragmentos com motor de extração de fragmentos apenas. Será que é uma boa?"

**My Understanding:**
You're proposing **architectural separation within InnerLens pack**:

```
expansion-packs/innerlens/
├── fragments-engine/     # MIU extraction, fragment taxonomy
│   ├── extract_fragments.py
│   └── fragment_taxonomy.yaml
└── psychometric-analysis/ # Big Five, personality correlations
    ├── analyze_personality.py
    └── psychometric_models/
```

**Questions:**

**Q-A1:** Should this be:
- **Option 1:** Two separate modules within InnerLens pack (single expansion pack, two engines)
- **Option 2:** Two separate expansion packs (Fragments, InnerLens)
- **Option 3:** Single unified codebase with clear internal separation

**Q-A2:** If separated, how do they interact?
- Fragments extracts MIUs → InnerLens reads MIUs → produces psychometric profile?
- Or they both read from same source texts independently?

**Q-A3:** Which parts from current `expansion-packs/fragments/` should move where?

| File/Folder | Destination | Reason |
|-------------|-------------|--------|
| `fragment_segmentation_rules_mmos_v5_0.md` | ? | Fragment extraction rules |
| `fragment_taxonomy_mmos_v5.0_english.md` | ? | Fragment taxonomy |
| `source_taxonomy_mmos_v5.0_english.md` | ? | Source classification |
| `validate_fragments.py` | ? | Validation script |
| `exemplo de extração manual com Claude App/` | ? | Research examples |

---

### B. ETL → MMOS Integration Details

**You said:**
> "Não sei responder, leia o código para entender."

**I need to understand for contract creation:**

**Q-B1:** File format requirements:
- What file types does MMOS accept from ETL? (`.md`, `.txt`, `.pdf`, etc.?)
- Are there encoding requirements? (UTF-8 only?)
- Any file size limits?

**Q-B2:** Directory structure:
ETL outputs to: `outputs/minds/{slug}/sources/downloads/`

Does MMOS also read from:
- `outputs/minds/{slug}/sources/` (manual files)?
- Or ONLY `sources/downloads/` (ETL output)?

**Q-B3:** Trigger mechanism:
- Does user run `*map {slug}` manually after ETL completes?
- Or is there automatic detection?

**Can I read the ETL and MMOS code to answer these?**
- [ ] Yes, read code and infer contract
- [ ] No, you tell me the contract spec

---

### C. Contract Evolution Strategy

**You said:**
> "Ta muito fraco, precisamos desenhar melhor."

When I proposed:
```
MMOS v1.0.0:
- Cognitive Patterns (required)
- Communication Style (required)

MMOS v1.1.0 adds:
- Big Five Profile (optional)
```

**Q-C1:** What's "fraco" (weak) about this approach?
- Should all sections be required (no optional)?
- Should we version the entire system prompt format more strictly?
- Should we have richer metadata about each section?

**Q-C2:** For contracts, should we specify:
- Field-level schemas (JSON Schema, YAML Schema)?
- Validation rules (regex, enums, ranges)?
- Semantic versioning at field level?

**Example of "stronger" contract:**

```yaml
contract:
  name: mmos-creator-os
  version: 1.0.0
  provider: MMOS
  consumer: CreatorOS

  outputs:
    - name: system_prompt
      path: outputs/minds/{slug}/system_prompts/professor.md
      format: markdown
      schema:
        sections:
          - name: cognitive_patterns
            required: true
            format: bullet_list
            min_items: 5
            max_items: 20
          - name: communication_style
            required: true
            format: prose
            min_words: 100
          - name: big_five_profile
            required: false  # Optional if InnerLens not run
            format: yaml_frontmatter
            schema:
              openness: {type: number, range: [0, 100]}
              conscientiousness: {type: number, range: [0, 100]}
              extraversion: {type: number, range: [0, 100]}
              agreeableness: {type: number, range: [0, 100]}
              neuroticism: {type: number, range: [0, 100]}
```

**Is this the level of detail you want?**

---

### D. InnerLens Old Files Cleanup

**You said:**
> "innerlens, tem muito arquivo antigo, precisaria analisar bem, criar um log"

**Q-D1:** Should I:
- **Option 1:** Create an audit log of all InnerLens files (what each file does, keep/delete/migrate)
- **Option 2:** You manually review and tell me what to keep/delete
- **Option 3:** Archive all current InnerLens to `innerlens-v1.1.0-archive/`, start fresh

**Q-D2:** Timeline for cleanup:
- Before unifying Fragments?
- After unifying Fragments?
- Separate task?

---

### E. Database vs File Integration

**You said:**
> "hoje le de YAML, mas queremos que seja lendo do banco de dados."

**Q-E1:** For the **initial contracts** (Priority 1), should I:
- **Option 1:** Specify YAML-based contracts (current state)
- **Option 2:** Specify DB-based contracts (future state)
- **Option 3:** Specify BOTH (with migration plan)

**Example:**

```yaml
# Contract: innerlens-mmos-v1.0.0.yaml

# Current (Phase 1 - Local)
outputs_file_based:
  - path: outputs/minds/{slug}/analysis/psychometric-profile.yaml
    format: yaml
    schema: {...}

# Future (Phase 2 - Online)
outputs_database:
  table: big_five_profiles
  columns:
    - mind_id (FK to minds.id)
    - openness (decimal)
    - conscientiousness (decimal)
    - extraversion (decimal)
    - agreeableness (decimal)
    - neuroticism (decimal)
    - created_at (timestamp)
```

**Which approach for initial contracts?**

---

### F. CreatorOS "Professor" Prompt

**You said:**
> "Deveriamos criar um promtp específico como professor."

**Q-F1:** Where should this live?
- `outputs/minds/{slug}/system_prompts/professor.md` (alongside generalista.md)?
- Replace `generalista.md` with `professor.md`?
- Different location?

**Q-F2:** What's different between "professor" and "generalista" prompts?
- Pedagogical framing (explain concepts clearly)?
- More structured (lesson format)?
- Different personality aspects emphasized?

**Q-F3:** Who creates `professor.md`?
- MMOS creates both `generalista.md` and `professor.md`?
- CreatorOS transforms `generalista.md` → `professor.md`?

---

### G. SuperAgentes Database Control

**You said:**
> "NADA, nem ninguem pode fazer nada sobre database, apenas db-sage."

**Q-G1:** In practice, how does this work?

**Scenario 1:** MMOS needs a new column in `minds` table.

**Process:**
1. MMOS maintainer creates issue/request?
2. DB Sage reviews and creates migration?
3. DB Sage applies migration to Supabase?
4. MMOS can now use new column?

**Is this correct?**

**Q-G2:** Can packs READ from database freely, or also restricted?
- Reads: Unrestricted (any pack can query)
- Writes: Only through DB Sage
- Both: Only through DB Sage

**Q-G3:** How are schema changes communicated?
- DB Sage updates `supabase/migrations/`?
- DB Sage also updates pack contracts?
- DB Sage notifies affected packs?

---

### H. Scaling & Performance

**You said:**
> "Vamos preparar tudo para muita escala, principalmente innerlens."

**Q-H1:** What scale are we planning for InnerLens?
- 100s of analyses per day?
- 1,000s per day?
- 10,000s+ per day?

**This affects:**
- Database schema (indexing strategy)
- Caching (should we cache fragments?)
- Rate limiting (API usage)
- Parallelization (how many concurrent analyses?)

**Q-H2:** For "muita escala", should contracts specify:
- Performance SLAs (InnerLens completes in <5 min)?
- Batch processing capabilities?
- Async/queue-based integration?

---

### I. Testing Strategy

**You asked:**
> "Qual a melhor forma?" (for integration test execution)

**My Recommendation:**

```yaml
Testing Tiers:
  1. Unit Tests:
     - Run: On every commit (fast, <1 min)
     - Coverage: Individual functions, pure logic
     - CI/CD: GitHub Actions on push

  2. Integration Tests (Light):
     - Run: On every PR (medium, ~5 min)
     - Coverage: Contract validation, mock data
     - CI/CD: GitHub Actions on PR

  3. Integration Tests (Full):
     - Run: Nightly (slow, ~1 hour)
     - Coverage: Real data, full pipeline
     - CI/CD: Scheduled GitHub Actions

  4. End-to-End Tests:
     - Run: Manual / Pre-release
     - Coverage: Complete workflows (ETL → MMOS → CreatorOS)
     - Duration: Several hours
```

**Does this make sense for your workflow?**

---

### J. Debug Mode

**You asked:**
> "Me explica mais isso."

**Explanation of Debug Modes:**

**Option 1: Environment Variable**
```bash
# Enables verbose logging across all packs
AIOS_DEBUG=true *map naval

# Output:
[DEBUG] Loading sources from outputs/minds/naval/sources/
[DEBUG] Found 47 source files
[DEBUG] Processing fragment 1/234: "Wealth is not about money..."
[DEBUG] Anthropic API call: 1,234 tokens used
...
```

**Pros:** Simple, universal
**Cons:** Very verbose, hard to filter

---

**Option 2: Config File**
```yaml
# .aios/config.yaml
debug:
  enabled: true
  packs:
    - mmos
    - innerlens
  log_level: DEBUG
  log_file: logs/debug.log
```

**Pros:** Persistent, configurable
**Cons:** Need to edit file, restart

---

**Option 3: Separate Debug Commands**
```bash
# Normal command
*map naval

# Debug command (verbose, saves full logs)
*debug-map naval

# Produces:
# - logs/debug-map-naval-20251027-143022.log (full trace)
# - Same output artifacts as normal *map
```

**Pros:** Explicit, clean logs per operation
**Cons:** Duplicate commands for every operation

---

**My Recommendation:**

**Hybrid Approach:**
```bash
# Quick debug flag (any command)
*map naval --debug

# Debug config for complex scenarios
AIOS_DEBUG=mmos,innerlens *map naval
```

**Q-J1:** Which debug approach do you prefer?

---

### K. Traceability & Monitoring

**You said:**
> "nao sei." (about how to implement traceability)

**Let me explain options:**

**Option 1: Database Foreign Keys (Full Traceability)**
```sql
-- Every operation tracked
CREATE TABLE operations (
  id UUID PRIMARY KEY,
  operation_type TEXT, -- 'etl_collect', 'mmos_map', 'creator_generate'
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  status TEXT -- 'success', 'failed', 'partial'
);

CREATE TABLE minds (
  id UUID PRIMARY KEY,
  slug TEXT,
  created_by_operation UUID REFERENCES operations(id)
);

CREATE TABLE mind_fragments (
  id UUID PRIMARY KEY,
  mind_id UUID REFERENCES minds(id),
  source_id UUID REFERENCES sources(id),
  extracted_by_operation UUID REFERENCES operations(id)
);
```

**Traceability Query:**
```sql
-- "Which sources were used to create Naval's mind?"
SELECT s.*
FROM sources s
JOIN mind_fragments mf ON mf.source_id = s.id
JOIN minds m ON m.id = mf.mind_id
WHERE m.slug = 'naval';
```

**Pros:** Perfect traceability, queryable
**Cons:** Complex schema, many foreign keys

---

**Option 2: Execution ID in Logs**
```
# Every operation gets unique ID
EXEC_ID: 550e8400-e29b-41d4-a716-446655440000

# All logs tagged
[550e8400] [MMOS] Starting mind mapping for 'naval'
[550e8400] [MMOS] Found 47 sources
[550e8400] [MMOS] Processing fragment 1/234
...

# Artifacts tagged
outputs/minds/naval/logs/execution-550e8400.log
```

**Pros:** Simple, good for debugging
**Cons:** Requires log parsing, not queryable

---

**Option 3: Metadata Files**
```yaml
# outputs/minds/naval/metadata.yaml
created_at: 2025-10-27T14:30:00Z
created_by: mmos-v3.0
execution_id: 550e8400-e29b-41d4-a716-446655440000

sources_used:
  - id: src_001
    path: sources/downloads/naval_podcast_001.md
    collected_by: etl-v1.0.0
    collected_at: 2025-10-27T10:00:00Z

enrichments:
  - type: innerlens_psychometric
    applied_at: 2025-10-27T12:00:00Z
    profile_version: 1.0.0

system_prompts:
  generalista:
    generated_at: 2025-10-27T14:00:00Z
    fidelity_score: 94.5
```

**Pros:** Self-documenting, versioned with artifacts
**Cons:** Can get out of sync with database

---

**My Recommendation:**

**Hybrid: Database + Metadata Files**
- **Database:** Track operations, metrics, relationships (for queries/analytics)
- **Metadata files:** Snapshot full context with artifacts (for reproducibility)

**Q-K1:** Does this make sense?

**Q-K2:** Priority for traceability:
- High (implement in initial contracts)?
- Medium (add in v2)?
- Low (add later if needed)?

---

### L. Data Consistency (Database ↔ File Sync)

**You asked:**
> "Me explique mais." (about database vs file conflicts)

**Scenario:**

**State 1 (Initial):**
```
Database:
  mind "naval" → fidelity: 94.5%, updated_at: 2025-10-20

File System:
  outputs/minds/naval/system_prompts/generalista.md
  (Last modified: 2025-10-20)
```

**State 2 (User re-runs MMOS):**
```bash
*map naval --force
```

**New system prompt generated:**
```
Database:
  mind "naval" → fidelity: 95.2%, updated_at: 2025-10-27

File System:
  outputs/minds/naval/system_prompts/generalista.md
  (Last modified: 2025-10-27)
```

**State 3 (User manually edits file):**
```bash
# User edits file directly
vim outputs/minds/naval/system_prompts/generalista.md
# Changes communication style section
```

**Now:**
```
Database:
  mind "naval" → fidelity: 95.2%, updated_at: 2025-10-27

File System:
  outputs/minds/naval/system_prompts/generalista.md
  (Last modified: 2025-10-27 15:00:00) ← NEWER than DB update!
```

**Conflict! Database says 95.2% fidelity, but file is manually edited.**

---

**Q-L1:** When CreatorOS runs and reads system prompt:

**Option 1: Trust file, warn about manual edit**
```
⚠️  WARNING: System prompt was manually edited (2025-10-27 15:00:00)
⚠️  Database fidelity score (95.2%) may not reflect current prompt
⚠️  Continue? (y/n)
```

**Option 2: Trust database, reject manual edits**
```
❌ ERROR: System prompt manually modified
❌ Database integrity violation
❌ Re-run *map naval to regenerate, or use --trust-manual-edit flag
```

**Option 3: Detect conflict, prompt user**
```
⚠️  CONFLICT DETECTED:
    - Database: updated 2025-10-27 14:00:00
    - File: modified 2025-10-27 15:00:00 (manual edit)

    Which version should I use?
    1. Database version (fidelity: 95.2%, generated by MMOS)
    2. File version (manually edited)
    3. Abort (fix conflict manually)
```

**Which approach aligns with your philosophy?**

---

**Q-L2:** For Phase 2 (database-driven), will this issue go away?
- All data in database → files are just "cached views"?
- Or files remain source of truth, database is index/metadata?

---

## 📋 Summary of Clarifications Needed

### Must Answer Before Creating Contracts (Priority 1)

1. **[Q-B1, Q-B2, Q-B3]** ETL → MMOS integration details
   - Can I read code to infer contract?
   - Or do you specify contract requirements?

2. **[Q-C1, Q-C2]** Contract strength/detail level
   - Field-level schemas?
   - Validation rules?

3. **[Q-E1]** Initial contracts: File-based or database-based?
   - Specify current state (YAML)?
   - Specify future state (DB)?
   - Specify both with migration plan?

4. **[Q-F1, Q-F2, Q-F3]** CreatorOS "professor" prompt
   - Where does it live?
   - How is it different from "generalista"?
   - Who creates it?

### Should Answer Before Fragments Unification (Priority 2)

5. **[Q-A1, Q-A2, Q-A3]** Fragments ↔ InnerLens architecture
   - One pack (two modules) or two packs?
   - How do they interact?
   - What files move where?

6. **[Q-D1, Q-D2]** InnerLens cleanup approach
   - Audit log or manual review?
   - Before or after unification?

### Nice to Have (Can Answer Later)

7. **[Q-G1, Q-G2, Q-G3]** SuperAgentes DB control workflow
8. **[Q-H1, Q-H2]** Scaling requirements
9. **[Q-I]** Testing strategy (I provided recommendation)
10. **[Q-J1]** Debug mode preference
11. **[Q-K1, Q-K2]** Traceability approach
12. **[Q-L1, Q-L2]** Database ↔ file consistency strategy

---

## 🎯 Proposed Next Steps

**After you answer the "Must Answer" questions above:**

### Step 1: Create Contracts (Priority 1)
```
docs/expansion-packs/contracts/
├── etl-mmos-v1.0.0.yaml
├── innerlens-mmos-v1.0.0.yaml
└── mmos-creator-os-v1.0.0.yaml
```

Each contract will specify:
- Provider pack & consumer pack
- Output format (file paths or database tables)
- Schema (fields, types, validation rules)
- Semantic versioning rules
- Example usage

### Step 2: Unify Fragments → InnerLens (Priority 2)
1. Create audit log of current InnerLens files
2. Migrate Fragments optimizations to InnerLens
3. Decide architecture: one pack (two modules) or two packs?
4. Update InnerLens README and documentation
5. Archive old/obsolete files

### Step 3: Document Individual Packs (Priority 3)
Create detailed pack documentation in `docs/expansion-packs/packs/`:
- mmos.md
- creator-os.md
- innerlens.md (after unification)
- etl.md
- super-agentes.md

### Step 4: Create First Epic (Priority 4)
Based on your ranking:
1. **Epic 1:** Workflow Automation (end-to-end orchestration)
2. **Epic 2:** Voice Fidelity Boost (InnerLens + MMOS + CreatorOS integration)

---

## ❓ Final Questions for You

**Q-FINAL-1:** Do you want me to:
- **A)** Wait for you to answer all clarifications, then proceed
- **B)** Start with what's clear (read code for ETL→MMOS, infer contracts), ask questions as I go
- **C)** Make reasonable assumptions, document them, you correct later

**Q-FINAL-2:** For reading code to understand integrations:
- **Yes, read code and infer** - Faster, may miss nuances
- **No, I'll specify contracts** - Slower, more accurate

**Q-FINAL-3:** Timeline:
- How urgently do you need the 3 contracts?
- Can we iterate (draft v0.1 → review → v1.0)?
- Or need complete v1.0 upfront?

---

**Pronto para suas respostas e começar a implementação! 🚀**

Winston (Architect Agent)
