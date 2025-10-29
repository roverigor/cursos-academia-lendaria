# Expansion Packs - System Architecture

**Technical architecture for modular, integrated expansion pack system**

---

## Architecture Principles

### 1. Loose Coupling, High Integration

**Principle:** Expansion packs are **independently deployable** but **highly integrated**.

✅ **Loose Coupling:**
- Each pack can evolve independently
- No direct code dependencies between packs
- Contract-based communication

✅ **High Integration:**
- Packs share unified database
- Well-defined integration points
- Rich data flows between packs

### 2. Single Database, Multiple Writers

**Principle:** All structured data goes to a single Supabase (PostgreSQL) database.

**Why?**
- ✅ **Single source of truth** - No data duplication
- ✅ **Traceability** - Track data lineage across packs
- ✅ **Referential integrity** - Foreign keys work across packs
- ✅ **Unified queries** - Cross-pack analytics

**Table Ownership:**
- Each pack "owns" a bounded context inside the Supabase schema.
- Packs can read any table (subject to RLS), but only write to their domain tables.
- SuperAgentes (DB Sage) is the sole maintainer of migrations, RLS policies, seeds and snapshots.

| Pack / Domain | Primary Tables (schema: `public`) | Notes |
|---------------|------------------------------------|-------|
| **MMOS Core** | `minds`, `mind_profiles`, `sources`, `fragments`, `fragment_tags`, `fragment_metadata` | Mind-centric source→fragment lineage, persisted via DB Sage migrations. |
| **InnerLens** | Shares `fragments` + `fragment_metadata`; adds `big_five_profiles`, `fragment_quality_audits` | Writes through Supabase clients with service-role credentials and RLS bypass (server-side). |
| **CreatorOS** | `content_projects`, `content_pieces`, `content_lessons`, `content_metadata`, `content_minds`, `audience_profiles`, `content_performance` | All writes go through `CoursePersister` (supabase-py). |
| **SuperAgentes** | `schema_versions`, `migration_log`, `db_audit_events` | Operational tables (no RLS) used for governance + automation. |
| **Shared / Ops** | `ingestion_batches`, `job_executions`, `task_metrics` | Cross-pack telemetry captured by orchestrators. |

#### Supabase Schema Overview

The production cluster runs on **Supabase Postgres 17** with timestamped migrations in `supabase/migrations/`. The current baseline is **v0.8.2 – Fragments Cleanup** (see `docs/database/README.md`). Schema design follows a mind-centric model:

- **Knowledge Core** (`minds → sources → fragments`): provenance, metadata and embeddings feeding MMOS + InnerLens.
- **CreatorOS Content Graph** (`content_projects → content_pieces → content_lessons`): dual-write pattern with filesystem snapshots for review.
- **Audience & Analytics** (`audience_profiles`, `content_performance`, `campaign_insights`): KPI tracking for generated assets.
- **Psychometrics** (`big_five_profiles`, `fragment_quality_audits`): InnerLens outputs and validation signals.
- **Operations** (`schema_versions`, `migration_log`, `ingestion_batches`, `job_executions`): governance, automation, telemetry.

Row Level Security is enforced by default using the `current_mind_id()` helper. Service-role operations (e.g., CreatorOS persister, InnerLens ingestion) execute on the backend with elevated credentials and explicit policies managed by DB Sage.

### 3. File-Based Contracts

**Principle:** Integration points use **files** as contracts, not APIs.

**Why?**
- ✅ **Simplicity** - No HTTP servers, no network issues
- ✅ **Versioning** - Files can be versioned in git
- ✅ **Debugging** - Easy to inspect intermediate outputs
- ✅ **Resumability** - Workflows can resume after failure

**Pattern:**
```
Pack A writes: outputs/pack-a/{slug}/output.yaml
Pack B reads: outputs/pack-a/{slug}/output.yaml
```

### 4. Optional Dependencies

**Principle:** Packs should work **standalone**, integrations **enhance** but don't block.

**Example:**
- CreatorOS works without MMOS (70-80% voice fidelity)
- CreatorOS + MMOS = 90%+ voice fidelity
- Graceful degradation if integration unavailable

### 5. AIOS Compliance

**Principle:** All packs follow **agents → tasks → checklists → workflows** pattern.

**Benefits:**
- ✅ Consistent UX across packs
- ✅ Reusable AIOS infrastructure
- ✅ Standardized quality enforcement
- ✅ Cross-pack agent orchestration

---

## System Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│                  (User-Facing Commands)                      │
│  @agent-name *command-name                                  │
└─────────────────────┬───────────────────────────────────────┘
                      │
┌─────────────────────┴───────────────────────────────────────┐
│                  Application Layer                           │
│              (Expansion Pack Logic)                          │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │ CreatorOS    │  │ MMOS         │  │ InnerLens    │    │
│  │ (Courses)    │  │ (Minds)      │  │ (Psychology) │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                  │                  │             │
└─────────┼──────────────────┼──────────────────┼─────────────┘
          │                  │                  │
┌─────────┼──────────────────┼──────────────────┼─────────────┐
│         │      Integration Layer               │             │
│         │    (Contract-Based Communication)    │             │
│         │                  │                  │             │
│  ┌──────▼──────────────────▼──────────────────▼───────┐    │
│  │         File System Contracts                      │    │
│  │  outputs/minds/    outputs/courses/               │    │
│  │  YAML contracts    Markdown documents             │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────┬───────────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────────┐
│                  Data Collection Layer                       │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │ ETL Data     │  │ etl variant  │  │ Fragments    │    │
│  │ Collector    │  │ (?)          │  │ (dev)        │    │
│  └──────┬───────┘  └──────────────┘  └──────────────┘    │
│         │                                                   │
└─────────┼───────────────────────────────────────────────────┘
          │
┌─────────┴───────────────────────────────────────────────────┐
│                  Persistence Layer                           │
│                                                              │
│  ┌───────────────────────────────────────────────────┐     │
│  │            Unified Database                        │     │
│  │            Supabase (PostgreSQL)                   │     │
│  │                                                    │     │
│  │  Tables by Pack:                                  │     │
│  │  - MMOS: minds, mind_profiles, sources, fragments │     │
│  │  - InnerLens: fragments, fragment_metadata, big_five_profiles││
│  │  - CreatorOS: content_projects, content_pieces, content_lessons, content_minds, content_metadata││
│  │  - Shared Ops: schema_versions, migration_log, ingestion_batches, job_executions││
│  └───────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Flow Architecture

### Pattern: Pipeline Architecture

**Expansion packs form a data pipeline:**

```
Raw Data → Collection → Enrichment → Application → Persistence

ETL Data → InnerLens → MMOS → CreatorOS → Database
Collector   (optional)  (core)  (optional)
```

**Key Characteristics:**
- **Uni-directional flow** - Data moves forward, no circular dependencies
- **Stage outputs** - Each stage produces artifacts for next stage
- **Optional stages** - Pipeline works with or without optional stages
- **Resumability** - Restart from any stage using intermediate artifacts

---

## Integration Patterns

### Pattern 1: File-Based Contract

**Used by:** ETL → MMOS, InnerLens → MMOS, MMOS → CreatorOS

**How it works:**

1. **Provider Pack** writes to standard location:
```bash
# MMOS writes system prompt
outputs/minds/naval/system_prompts/generalista.md
```

2. **Consumer Pack** reads from that location:
```javascript
// CreatorOS reads system prompt
const systemPrompt = await readFile('outputs/minds/naval/system_prompts/generalista.md');
```

3. **Contract defines:**
- File format (YAML, Markdown, JSON)
- Required sections
- Optional sections
- Encoding (UTF-8)
- Version

**Benefits:**
- ✅ Simple to implement
- ✅ Easy to debug (just open file)
- ✅ Version control friendly
- ✅ No server infrastructure needed

**Example Contract:**
```yaml
# docs/expansion-packs/contracts/mmos-creator-os-v1.0.0.yaml
interface:
  format: "Markdown"
  location: "outputs/minds/{slug}/system_prompts/generalista.md"
  required_sections:
    - "Cognitive Patterns"
    - "Communication Style"
  optional_sections:
    - "Big Five Profile"
```

---

### Pattern 2: Database-Mediated Integration

**Used by:** All packs → Database, Database → All packs

**How it works:**

1. **Pack A** writes to the database through the Supabase client:
```python
from supabase import create_client

supabase = create_client(SUPABASE_URL, SUPABASE_SERVICE_KEY)

# InnerLens persists validated fragments
supabase.table('fragments').insert({
    'mind_id': mind_id,
    'source_id': source_id,
    'fragment_id': 'f_001',
    'content': verbatim_text,
    'metadata': fragment_metadata
}).execute()
```

2. **Pack B** reads via the same interface (respecting RLS):
```python
mind = supabase.table('minds') \
    .select('id, slug, display_name, mind_profiles(*)') \
    .eq('slug', 'naval_ravikant') \
    .single() \
    .execute()
```

3. **Schema defines:**
- Table structure
- Foreign keys
- Indexes
- Constraints

**Benefits:**
- ✅ Referential integrity
- ✅ Efficient queries
- ✅ Transactions
- ✅ Concurrent access

**Database Governance:**
- Schema owned by Database Owner
- Migrations managed by SuperAgentes (DB Sage)
- All changes go through migration process

---

### Pattern 3: Optional Enhancement

**Used by:** InnerLens → MMOS, MMOS → CreatorOS

**How it works:**

1. **Base functionality** works standalone:
```javascript
// MMOS creates mind without InnerLens
const mind = await MMOS.createMind('naval', {
  sources: 'outputs/minds/naval/sources/'
});
// Fidelity: 94% (base)
```

2. **Enhancement available** if optional dependency present:
```javascript
// MMOS checks for InnerLens profile
if (exists('outputs/minds/naval/analysis/psychometric-profile.yaml')) {
  const profile = await readProfile('psychometric-profile.yaml');
  mind.enrichWithPersonality(profile);
}
// Fidelity: 96-97% (enhanced)
```

**Benefits:**
- ✅ Doesn't block if optional pack unavailable
- ✅ Graceful degradation
- ✅ Progressive enhancement

**Pattern:**
```javascript
async function createMind(slug) {
  // Step 1: Base creation (required)
  const mind = await baseCreation(slug);

  // Step 2: Optional enhancements
  if (await hasInnerLensProfile(slug)) {
    mind.enrichWithPersonality(await loadProfile(slug));
  }

  if (await hasSuperAgentesTokens(slug)) {
    mind.applyUITokens(await loadTokens(slug));
  }

  return mind;
}
```

---

## Directory Structure

### outputs/ Structure

```
outputs/
├── database/
│   └── Supabase (PostgreSQL cluster)                    # Unified database (all packs)
│
├── minds/                         # MMOS output
│   └── {slug}/
│       ├── sources/               # ETL writes here
│       │   ├── downloads/
│       │   └── metadata.yaml
│       ├── analysis/              # InnerLens writes here
│       │   └── psychometric-profile.yaml
│       ├── synthesis/             # MMOS Phase 4 output
│       │   └── frameworks.md
│       ├── system_prompts/        # MMOS Phase 5 output
│       │   └── generalista.md    # CreatorOS reads this
│       ├── kb/                    # Knowledge base chunks
│       ├── docs/                  # Mind-specific docs
│       └── logs/                  # Mind-specific logs
│
└── courses/                       # CreatorOS output
    └── {slug}/
        ├── COURSE-BRIEF.md        # User creates (greenfield) or auto-extracted (brownfield)
        ├── curriculum.yaml        # CreatorOS generates
        ├── lessons/               # CreatorOS generates
        │   ├── lesson-001.md
        │   └── ...
        ├── market-research/       # CreatorOS research phase
        │   ├── market-analysis.md
        │   └── ...
        └── sources/               # Brownfield: legacy materials
```

### Integration Directories

**Cross-pack data flows:**

| Producer | Consumer | Location | Format |
|----------|----------|----------|--------|
| ETL | MMOS | `outputs/minds/{slug}/sources/` | Markdown |
| InnerLens | MMOS | `outputs/minds/{slug}/analysis/` | YAML |
| MMOS | CreatorOS | `outputs/minds/{slug}/system_prompts/` | Markdown |
| All | All | Supabase (PostgreSQL) | Managed Postgres |

---

## Database Schema Architecture

### Table Ownership Model

**Principle:** Each pack owns certain tables, but all packs can read all tables.

| Pack | Tables Owned | Write Access | Read Access |
|------|-------------|--------------|-------------|
| **MMOS** | `minds`, `cognitive_specs`, `mind_fragments` | Own tables | All tables |
| **InnerLens** | `sources`, `fragments`, `big_five_profiles` | Own tables | All tables |
| **CreatorOS** | `courses`, `lessons`, `content_pieces`, `content_projects`, `audience_profiles` | Own tables | All tables |
| **SuperAgentes** | *(none)* | All tables (DBA) | All tables |
| **Shared** | `metadata`, `migrations` | All packs | All packs |

### Schema Versioning

**Migration files:** `db/migrations/YYYYMMDD-HHMMSS-description.sql`

**Managed by:** SuperAgentes (DB Sage)

**Process:**
1. Pack proposes schema change
2. Database Owner reviews
3. Migration created
4. Applied via `*apply-migration`
5. All packs notified

**Example Migration:**
```sql
-- db/migrations/20251027-150000-add-big-five-to-minds.sql
BEGIN TRANSACTION;

ALTER TABLE minds ADD COLUMN openness INTEGER;
ALTER TABLE minds ADD COLUMN conscientiousness INTEGER;
ALTER TABLE minds ADD COLUMN extraversion INTEGER;
ALTER TABLE minds ADD COLUMN agreeableness INTEGER;
ALTER TABLE minds ADD COLUMN neuroticism INTEGER;

INSERT INTO migrations (version, description, applied_at)
VALUES ('20251027-150000', 'Add Big Five to minds table', datetime('now'));

COMMIT;
```

---

## Contract Specifications

### Contract Structure

**File:** `docs/expansion-packs/contracts/{provider}-{consumer}-v{version}.yaml`

```yaml
contract:
  name: "Provider → Consumer Integration"
  version: "1.0.0"
  status: "stable | experimental | deprecated"
  provider: "Pack Name"
  consumer: "Pack Name"

  interface:
    type: "file | database | directory"
    format: "YAML | Markdown | JSON | SQL"
    location: "path/to/interface"
    encoding: "UTF-8"

    required_fields:
      - field_name: "description"
      - field_name2: "description"

    optional_fields:
      - field_name: "description"

  schema:
    # For YAML/JSON contracts
    example: |
      field1: value
      field2: value

  backward_compatibility:
    guarantees:
      - "What won't change"
    deprecation_policy: "How long before breaking changes"

  versioning:
    current: "1.0.0"
    breaking_changes_history:
      - version: "1.0.0"
        date: "2025-10-27"
        change: "Initial contract"
```

### Contract Registry

All active contracts:

| Contract | Version | Status | Provider | Consumer |
|----------|---------|--------|----------|----------|
| [ETL → MMOS](./contracts/etl-mmos-v1.0.0.yaml) | 1.0.0 | ✅ Stable | ETL | MMOS |
| [InnerLens → MMOS](./contracts/innerlens-mmos-v1.0.0.yaml) | 1.0.0 | ✅ Stable | InnerLens | MMOS |
| [MMOS → CreatorOS](./contracts/mmos-creator-os-v1.0.0.yaml) | 1.0.0 | ✅ Stable | MMOS | CreatorOS |
| [InnerLens → Database](./contracts/innerlens-db-v1.0.0.yaml) | 1.0.0 | ✅ Stable | InnerLens | Database |
| [MMOS → Database](./contracts/mmos-db-v1.0.0.yaml) | 1.0.0 | ✅ Stable | MMOS | Database |
| [CreatorOS → Database](./contracts/creator-os-db-v1.0.0.yaml) | 1.0.0 | ✅ Stable | CreatorOS | Database |

---

## Security Architecture

### Principle: Defense in Depth

**Layer 1: File System Permissions**
- outputs/ directory: 0755 (world-readable)
- Database: 0644 (owner write, world read)
- Sensitive data: Never stored in outputs/

**Layer 2: Database Security**
- RLS policies enforced by SuperAgentes
- Row-level security based on mind ownership
- User impersonation for testing

**Layer 3: Data Privacy**
- PII never in file names
- Sensitive traits marked in database
- Privacy classification (PUBLIC, PRIVATE, SENSITIVE, CLINICAL)

**Layer 4: API Key Management**
- Never commit API keys
- Use environment variables
- Rotate keys regularly

---

## Performance Architecture

### Optimization Strategies

**1. Lazy Loading**
- Don't load integration data unless needed
- Check file existence before reading

**2. Caching**
- Cache frequently-read contracts
- Cache database schema
- Cache system prompts during generation

**3. Parallel Processing**
- ETL parallel downloads
- MMOS parallel analysis
- CreatorOS parallel lesson generation

**4. Incremental Updates**
- MMOS brownfield: only reprocess changed sources
- CreatorOS: resume generation from checkpoint
- Database: incremental migrations

---

## Error Handling Architecture

### Principle: Fail Gracefully

**Pattern 1: Optional Enhancement Failure**
```javascript
try {
  const profile = await loadInnerLensProfile(slug);
  mind.enrichWithPersonality(profile);
} catch (error) {
  logger.warn('InnerLens profile unavailable, proceeding with base mind');
  // Continue without enhancement
}
```

**Pattern 2: Validation Errors**
```javascript
const validationResult = await validateContract(data, contract);
if (!validationResult.valid) {
  throw new ContractViolationError(
    `Contract ${contract.name} v${contract.version} violated`,
    validationResult.errors
  );
}
```

**Pattern 3: Rollback on Failure**
```javascript
const snapshot = await db.snapshot();
try {
  await applyMigration(migration);
  await runSmokeTests();
} catch (error) {
  logger.error('Migration failed, rolling back');
  await db.rollback(snapshot);
  throw error;
}
```

---

## Testing Architecture

### Test Pyramid

```
        ┌──────────────┐
        │ End-to-End   │  <- Cross-pack workflows
        │ Integration  │
        └──────────────┘
       ┌────────────────┐
       │  Integration   │   <- Pack-to-pack integration
       │     Tests      │
       └────────────────┘
      ┌──────────────────┐
      │  Contract Tests  │    <- Contract validation
      └──────────────────┘
     ┌────────────────────┐
     │    Unit Tests      │     <- Pack-internal logic
     └────────────────────┘
```

**Test Types:**

1. **Unit Tests** - Pack-internal logic (pack's responsibility)
2. **Contract Tests** - Validate contract compliance
3. **Integration Tests** - Pack-to-pack integration
4. **E2E Tests** - Full workflow validation

**Test Locations:**
- Unit: `expansion-packs/{pack}/tests/`
- Integration: `tests/integration/packs/`
- E2E: `tests/e2e/workflows/`
- Contract: `tests/contracts/`

---

## Deployment Architecture

### Deployment Model: Monorepo

**Structure:**
```
mente-lendaria/
├── expansion-packs/     # All packs in one repo
│   ├── mmos/
│   ├── creator-os/
│   └── ...
├── outputs/             # Shared output directory
├── docs/                # Shared documentation
└── tests/               # Shared integration tests
```

**Benefits:**
- ✅ Atomic commits across packs
- ✅ Shared CI/CD
- ✅ Easier dependency management
- ✅ Single version number for entire system

**Versioning:** System version (e.g., Mente Lendária v2.0.0) independent of pack versions

---

## Future Architecture Considerations

### Consideration 1: API Layer

**Current:** File-based contracts
**Future:** REST API layer for remote access

**Use case:** Cloud deployment, multi-user access

### Consideration 2: Event-Driven Architecture

**Current:** Synchronous pipeline
**Future:** Event bus for async integration

**Use case:** Real-time updates, webhooks

### Consideration 3: Microservices

**Current:** Monolithic packs
**Future:** Each pack as containerized service

**Use case:** Independent scaling, cloud-native deployment

---

**Last Updated:** 2025-10-27
**Status:** Living document - evolves with system architecture
