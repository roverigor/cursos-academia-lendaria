# Database Integration Analysis for Expansion Pack

> Task ID: db-expansion-pack-integration
> Agent: DB Sage (Database Architect)
> Version: 1.0.0

## Description

Analyze an expansion pack's data requirements and design database integration strategy. Maps pack inputs/outputs/state to database schema, proposes tables/relationships, and generates migration plan.

## Prerequisites

- Expansion pack installed and accessible
- Database connection configured (*env-check passed)
- Current schema documented or accessible

## Workflow

### Step 1: Identify Target Expansion Pack

**Elicit from user:**
- Which expansion pack? (mmos, creator-os, innerlens, etc.)
- Path to expansion pack directory

**Actions:**
- Verify pack exists and has config.yaml
- Load pack metadata (name, version, description)

---

### Step 2: Audit Expansion Pack Data Flows

**Scan pack structure for data touchpoints:**

```bash
# Look for data indicators
- Config files (*.yaml, *.json, .env.example)
- Input directories (sources/, inputs/, uploads/)
- Output directories (outputs/, generated/, artifacts/)
- State files (state.json, .cache/, db/)
- Scripts that read/write data
- API endpoints that handle data
```

**Document findings:**

```yaml
expansion_pack_audit:
  name: mmos
  version: 2.0.0

  data_inputs:
    - type: user_interview_transcript
      format: markdown
      location: sources/interviews/
      volume: ~50 files per mind

    - type: configuration
      format: yaml
      location: config/mind-config.yaml
      fields: [name, personality_type, communication_style]

  data_outputs:
    - type: cognitive_model
      format: yaml
      location: outputs/minds/{slug}/analysis/
      persistence_need: high (reusable artifact)

    - type: system_prompt
      format: markdown
      location: outputs/minds/{slug}/system_prompts/
      persistence_need: high (versioned, queryable)

    - type: knowledge_chunks
      format: json
      location: outputs/minds/{slug}/kb/
      persistence_need: high (searchable, referenceable)

  state_requirements:
    - processing_status: [pending, in_progress, completed, failed]
    - last_run_timestamp
    - version_tracking
    - validation_scores

  relationships:
    - One mind → many system_prompts (versioned)
    - One mind → many knowledge_chunks
    - One user → many minds
```

---

### Step 3: Analyze Current Database Schema

**Connect to database and inspect:**

```sql
-- List all tables
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'public';

-- Check for related tables
SELECT * FROM pg_tables WHERE schemaname = 'public';

-- Look for existing patterns
-- Users, projects, assets, metadata tables?
```

**Document current schema:**

```yaml
current_schema:
  tables:
    - name: users
      has_auth: true
      fields: [id, email, created_at]

    - name: projects
      fields: [id, user_id, name, type, created_at]
      foreign_keys: [user_id → users.id]

  patterns_found:
    - Multi-tenancy via user_id
    - UUID primary keys
    - created_at/updated_at timestamps
    - RLS enabled on most tables
```

---

### Step 4: Design Integration Schema

**Map pack data to database tables:**

```yaml
proposed_schema:
  new_tables:

    # MMOS example
    - name: minds
      purpose: Store cognitive clone definitions
      fields:
        - id: uuid PRIMARY KEY
        - user_id: uuid REFERENCES users(id)
        - slug: text UNIQUE NOT NULL
        - name: text NOT NULL
        - personality_type: text
        - status: mind_status_enum
        - version: integer DEFAULT 1
        - created_at: timestamptz
        - updated_at: timestamptz
      indexes:
        - (user_id, slug) UNIQUE
        - (status) WHERE status = 'active'
      rls: "Users can only access their own minds"

    - name: mind_system_prompts
      purpose: Version-controlled system prompts
      fields:
        - id: uuid PRIMARY KEY
        - mind_id: uuid REFERENCES minds(id) ON DELETE CASCADE
        - version: integer NOT NULL
        - prompt_type: text (generalista, specialist, etc.)
        - content: text NOT NULL
        - metadata: jsonb
        - created_at: timestamptz
      indexes:
        - (mind_id, version, prompt_type) UNIQUE
      rls: "Inherit from minds table via mind_id"

    - name: mind_knowledge_chunks
      purpose: RAG-ready knowledge base
      fields:
        - id: uuid PRIMARY KEY
        - mind_id: uuid REFERENCES minds(id) ON DELETE CASCADE
        - chunk_text: text NOT NULL
        - embedding: vector(1536)  # OpenAI embeddings
        - metadata: jsonb (source_file, chunk_index, etc.)
        - created_at: timestamptz
      indexes:
        - (mind_id)
        - GiST (embedding vector_cosine_ops) # For similarity search
      rls: "Inherit from minds table"

  modified_tables: []

  enums:
    - name: mind_status_enum
      values: [pending, processing, completed, failed, archived]

  functions:
    - name: search_mind_knowledge(mind_id uuid, query_embedding vector)
      purpose: Vector similarity search for RAG
      returns: TABLE(chunk_id uuid, chunk_text text, similarity float)
```

---

### Step 5: Validate Integration Design

**Run checks:**

- [ ] All pack outputs have storage strategy
- [ ] All pack inputs can be referenced (user uploads → table?)
- [ ] State requirements mapped to fields
- [ ] Foreign keys enforce relationships
- [ ] RLS policies defined for all tables
- [ ] Indexes support expected queries (list minds, search KB, version lookup)
- [ ] No orphaned data (CASCADE on deletes)
- [ ] Follows existing schema patterns (user_id, timestamps, etc.)

**KISS Gate check:**

- Is database even needed? (If pack works fine with filesystem, stop here)
- What problem does this solve? (searchability? multi-user? versioning?)
- Can existing tables be extended instead? (e.g., generic `projects` table?)
- Minimum viable schema? (Start with 1 table, expand later if needed)

---

### Step 6: Generate Migration Plan

**Create migration strategy:**

```yaml
migration_plan:
  phase_1_foundation:
    - Create enums (mind_status_enum)
    - Create base table (minds)
    - Add RLS policies to minds
    - Create seed data (test mind)

  phase_2_extensions:
    - Create related tables (mind_system_prompts, mind_knowledge_chunks)
    - Add foreign keys
    - Add indexes
    - Enable RLS on related tables

  phase_3_functions:
    - Create vector search function
    - Create helper views (active_minds, latest_prompts)

  rollback_strategy:
    - Snapshot before each phase
    - Rollback scripts generated
    - Test on staging first

  risk_assessment:
    - Low risk: New tables, no existing data affected
    - Medium risk: If modifying existing tables
    - High risk: If changing core auth/users tables
```

**Generate actual migration files:**

```bash
# Use template to generate
*create-migration-plan

# Then scaffold files
supabase/migrations/20251027_001_create_minds_table.sql
supabase/migrations/20251027_002_create_mind_prompts_table.sql
supabase/migrations/20251027_003_create_mind_kb_table.sql
supabase/migrations/20251027_004_add_vector_search.sql
```

---

### Step 7: Generate Integration Documentation

**Create docs/mmos/database-integration.md:**

```markdown
# MMOS Database Integration

## Overview
MMOS cognitive clones are now persisted in Supabase with full RLS, versioning, and vector search.

## Schema

### minds table
- Stores core mind definition
- One per cognitive clone
- User-scoped via RLS

### mind_system_prompts table
- Version-controlled prompts
- Many per mind
- Allows A/B testing and rollback

### mind_knowledge_chunks table
- RAG-ready knowledge base
- Vector embeddings for similarity search
- Efficient retrieval during clone interaction

## Usage

### Creating a mind
```sql
INSERT INTO minds (user_id, slug, name, personality_type)
VALUES (auth.uid(), 'joao-lozano', 'João Lozano', 'ENTJ');
```

### Storing system prompt
```sql
INSERT INTO mind_system_prompts (mind_id, version, prompt_type, content)
VALUES (:mind_id, 1, 'generalista', :prompt_content);
```

### Searching knowledge base
```sql
SELECT * FROM search_mind_knowledge(
  :mind_id,
  :query_embedding::vector(1536)
)
LIMIT 10;
```

## Migration Path

1. Run migrations in order (see supabase/migrations/)
2. Backfill existing minds from outputs/ directory
3. Update MMOS scripts to read/write database
4. Keep filesystem outputs as backup during transition
```

---

### Step 8: Output Integration Report

**Generate expansion-packs/{pack-name}/database-integration-report.yaml:**

```yaml
integration_analysis:
  expansion_pack: mmos
  database: supabase_production
  analysis_date: 2025-10-27
  analyst: DB Sage

summary:
  recommendation: "Integrate with database"
  rationale: |
    - Multi-user access required (MMOS will be SaaS)
    - Version tracking needed (system prompt evolution)
    - Vector search needed (RAG for clone responses)
    - Filesystem alone cannot support these requirements

  tables_added: 3
  tables_modified: 0
  migration_risk: low
  estimated_effort: 4 hours (design + migrate + test)

schema_design:
  file: docs/mmos/database-schema.yaml
  erd: docs/mmos/database-erd.png (generate with *create-schema)

migration_plan:
  file: docs/mmos/migration-plan.yaml
  migrations_directory: supabase/migrations/
  rollback_scripts: supabase/rollback/

next_steps:
  - [ ] Review schema design with team
  - [ ] Approve migration plan
  - [ ] Run *snapshot baseline
  - [ ] Execute migrations (*migrate)
  - [ ] Test integration (*smoke-test)
  - [ ] Update MMOS scripts to use database
  - [ ] Deploy to staging
  - [ ] Monitor for 48h
  - [ ] Deploy to production
```

---

## Success Criteria

- [ ] Expansion pack data flows fully documented
- [ ] Current schema analyzed
- [ ] Integration schema designed (follows patterns, has RLS)
- [ ] KISS Gate validation passed (database is actually needed)
- [ ] Migration plan generated with rollback strategy
- [ ] Integration documentation created
- [ ] Report generated with clear next steps

---

## Output Files

```
expansion-packs/{pack-name}/
├── database-integration-report.yaml  ← Main output
├── data-flow-audit.yaml              ← Step 2 findings
└── schema-design.yaml                ← Step 4 design

docs/{pack-name}/
├── database-integration.md           ← Usage guide
├── database-schema.yaml              ← Schema definition
└── migration-plan.yaml               ← Migration strategy

supabase/migrations/
└── 2025MMDD_NNN_{pack}_*.sql        ← Ready to apply
```

---

## Examples

### CreatorOS Integration

```yaml
# CreatorOS generates courses → needs to store:
# - Course metadata (title, description, status)
# - Curriculum structure (modules, lessons)
# - Generated content (video scripts, quizzes)
# - User progress (if multi-user platform)

proposed_schema:
  - courses table (id, user_id, slug, title, status)
  - course_modules table (id, course_id, order, title)
  - course_lessons table (id, module_id, order, title, content_type)
  - course_content table (id, lesson_id, content, generated_at)
```

### InnerLens Integration

```yaml
# InnerLens does psychometric assessments → needs to store:
# - Assessment definitions (Big5, MBTI, etc.)
# - User responses (answers, timestamps)
# - Computed results (personality profiles)

proposed_schema:
  - assessments table (id, name, type, questions_jsonb)
  - user_assessments table (id, user_id, assessment_id, completed_at)
  - assessment_responses table (id, user_assessment_id, question_id, response)
  - assessment_results table (id, user_assessment_id, results_jsonb)
```

---

## Notes

- **Always run KISS Gate validation** - database might not be needed
- **Follow existing patterns** - don't reinvent (user_id, timestamps, RLS)
- **Start minimal** - can always add tables later
- **Think about queries** - indexes should match access patterns
- **Plan for scale** - vector search, partitioning if needed
- **RLS from day 1** - security cannot be retrofitted easily
- **Document everything** - future maintainers will thank you

---

## Related Tasks

- `*validate-kiss` - Run before this task (MANDATORY)
- `*create-schema` - Generate full schema documentation with ERD
- `*create-migration-plan` - Generate detailed migration strategy
- `*migrate` - Execute the actual migrations
- `*smoke-test` - Validate integration after migration
