# DB Sage Agent - Complete Implementation Guide

**Version**: 1.0.0
**Date**: 2025-10-26
**Status**: Implementation Roadmap
**Target**: 100% AIOS Integration with Supabase MCP & CLI

---

## 🎯 Implementation Objectives

### Core Requirements
- ✅ **Multi-IDE Support**: Synchronized across `.aios-core/`, `.claude/`, `.cursor/`
- ✅ **MCP Integration**: Native Supabase MCP server integration from day 1
- ✅ **CLI Integration**: Supabase CLI workflows built-in
- ✅ **AIOS Compliance**: 100% aligned with AIOS framework patterns
- ✅ **Cross-Agent Integration**: Seamless handoffs with @architect, @dev, @qa, @devops
- ✅ **Production-Ready**: Enterprise-grade safety, security, observability

### Success Criteria
1. Agent activates consistently across all 3 IDEs
2. All 20+ tasks execute without errors
3. MCP Supabase commands work out of the box
4. Supabase CLI commands integrate seamlessly
5. Templates generate valid, production-ready artifacts
6. Checklists catch common mistakes before deployment
7. Cross-agent workflows execute end-to-end

---

## 📁 Complete File Structure

### Directory Layout
```
.aios-core/
├── agents/
│   └── db-sage.md                          # Main agent definition
├── tasks/
│   ├── db-env-check.md                     # Environment validation
│   ├── db-bootstrap.md                     # Project scaffolding
│   ├── db-apply-migration.md               # Migration execution
│   ├── db-dry-run.md                       # Safe migration testing
│   ├── db-snapshot.md                      # Schema snapshots
│   ├── db-rollback.md                      # Rollback operations
│   ├── db-smoke-test.md                    # Validation testing
│   ├── db-seed.md                          # Seed data loading
│   ├── db-rls-audit.md                     # RLS coverage audit
│   ├── db-policy-apply.md                  # RLS policy installation
│   ├── db-explain.md                       # Query plan analysis
│   ├── db-analyze-hotpaths.md              # Query performance analysis
│   ├── db-load-csv.md                      # CSV data import
│   ├── db-run-sql.md                       # SQL execution
│   ├── db-monitor-queries.md               # Query monitoring
│   ├── db-check-locks.md                   # Lock analysis
│   ├── db-vacuum-status.md                 # Vacuum monitoring
│   ├── db-backup.md                        # Backup operations
│   ├── db-restore.md                       # Restore operations
│   ├── db-compare-schemas.md               # Schema drift detection
│   ├── domain-modeling.md                  # Domain modeling session
│   ├── query-optimization.md               # Query optimization
│   ├── schema-audit.md                     # Schema quality audit
│   ├── supabase-setup.md                   # Supabase project setup
│   └── db-test-suite.md                    # Database testing framework
├── templates/
│   ├── schema-design-tmpl.yaml             # ✅ Created
│   ├── rls-policies-tmpl.yaml              # ✅ Created
│   ├── migration-plan-tmpl.yaml            # ⚠️ Partial - needs completion
│   ├── index-strategy-tmpl.yaml            # 📋 To create
│   ├── db-runbook-tmpl.yaml                # 📋 To create
│   ├── smoke-test-suite-tmpl.yaml          # 📋 To create
│   ├── rls-kiss-policy-tmpl.sql            # 📋 To create
│   ├── rls-granular-policy-tmpl.sql        # 📋 To create
│   └── migration-script-tmpl.sql           # 📋 To create
├── checklists/
│   ├── dba-predeploy-checklist.md          # 📋 To create
│   ├── dba-rollback-checklist.md           # 📋 To create
│   ├── database-design-checklist.md        # 📋 To create
│   ├── dba-team-workflow-checklist.md      # 📋 To create
│   ├── security-audit-checklist.md         # 📋 To create
│   └── compliance-checklist.md             # 📋 To create
├── data/
│   ├── database-best-practices.md          # 📋 To create
│   ├── supabase-patterns.md                # 📋 To create
│   ├── postgres-tuning-guide.md            # 📋 To create
│   ├── rls-security-patterns.md            # 📋 To create
│   ├── migration-safety-guide.md           # 📋 To create
│   ├── postgres-common-mistakes.md         # 📋 To create
│   ├── supabase-vs-postgres.md             # 📋 To create
│   ├── schema-evolution-strategies.md      # 📋 To create
│   ├── postgres-function-cookbook.md       # 📋 To create
│   └── mcp-supabase-integration.md         # 📋 To create
└── scripts/
    ├── sync-db-sage.sh                     # Sync to .claude & .cursor
    └── validate-db-sage.sh                 # Validate installation

.claude/
└── commands/
    └── db-sage.md                          # Symlink to .aios-core/agents/db-sage.md

.cursor/
└── agents/
    └── db-sage.md                          # Symlink to .aios-core/agents/db-sage.md
```

---

## 🔧 Integration Architecture

### 1. MCP Supabase Integration

#### MCP Server Configuration
```json
// ~/.config/claude/mcp.json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-supabase",
        "postgresql://postgres.project-ref:password@aws-0-region.pooler.supabase.com:6543/postgres"
      ]
    }
  }
}
```

#### Available MCP Commands
DB Sage will use these MCP commands:
- `mcp__supabase__query` - Execute SQL queries
- `mcp__supabase__get_schema` - Get table schemas
- `mcp__supabase__list_tables` - List all tables
- `mcp__supabase__get_policies` - Get RLS policies
- `mcp__supabase__explain` - Get query execution plans

#### Task Integration Pattern
Every DB task that needs database access should:
```markdown
## Execution

### Step 1: Environment Check
Use MCP to verify connection:
- Call `mcp__supabase__list_tables`
- Validate connection successful

### Step 2: Execute Operation
Use MCP for database operations:
- Call `mcp__supabase__query` with SQL
- Capture results

### Step 3: Validate
- Check for errors
- Verify expected outcome
```

### 2. Supabase CLI Integration

#### CLI Commands Used
```bash
# Project Management
supabase init                    # Initialize project
supabase login                   # Authenticate
supabase link --project-ref XXX  # Link to cloud project

# Database Operations
supabase db reset                # Reset local database
supabase db push                 # Push schema changes
supabase db pull                 # Pull remote schema
supabase db diff                 # Show schema diff
supabase migration new NAME      # Create new migration
supabase migration list          # List migrations
supabase migration repair        # Repair migration history

# Local Development
supabase start                   # Start local stack
supabase stop                    # Stop local stack
supabase status                  # Check status

# Schema Inspection
supabase db dump -f dump.sql     # Export schema
supabase db reset --db-url URL   # Reset remote
```

#### Task Integration Pattern
Tasks should use CLI where appropriate:
```markdown
## Prerequisites
- Supabase CLI installed: `brew install supabase/tap/supabase`
- Authenticated: `supabase login`
- Project linked: `supabase link --project-ref XXX`

## Execution
1. Check CLI status: `supabase status`
2. Execute operation: `supabase db push`
3. Validate: `supabase migration list`
```

### 3. AIOS Framework Integration

#### Agent Activation Pattern
```yaml
# .aios-core/agents/db-sage.md
activation-instructions:
  - STEP 1: Read THIS ENTIRE FILE
  - STEP 2: Adopt persona (DBA + Architect)
  - STEP 3: Verify MCP Supabase server available
  - STEP 4: Check Supabase CLI installed
  - STEP 5: Greet user with agent name/role
  - STEP 6: Mention `*help` command
  - CRITICAL: Do NOT execute tasks until user requests
  - STAY IN CHARACTER until `*exit`
```

#### Cross-Agent Integration Points

##### Integration with @architect
```yaml
handoff-from-architect:
  trigger: Architect completes schema-design-tmpl.yaml
  db-sage-action:
    - Read schema design document
    - Create migration from design: `*create-migration-from-design`
    - Generate RLS policies: `*create-rls-policies`
    - Output implementation plan
  artifact-flow:
    input: docs/architecture/schema-design.yaml
    output: supabase/migrations/YYYYMMDDHHMMSS_schema.sql
```

##### Integration with @dev
```yaml
handoff-from-dev:
  trigger: Developer requests schema change
  db-sage-action:
    - Create snapshot: `*snapshot before-dev-change`
    - Generate migration: `*create-migration "dev change description"`
    - Dry run: `*dry-run migration.sql`
    - Apply if safe: `*apply-migration migration.sql`
  artifact-flow:
    input: Developer verbal request
    output: Applied migration + smoke test results
```

##### Integration with @qa
```yaml
handoff-to-qa:
  trigger: DB Sage completes migration
  db-sage-action:
    - Run smoke tests: `*smoke-test v1.2`
    - Generate test data: `*seed test-data.sql`
    - Output QA report
  artifact-flow:
    output: Test results + seed data location
```

##### Integration with @devops
```yaml
handoff-to-devops:
  trigger: Pre-deployment phase
  db-sage-action:
    - Run predeploy checklist: `*execute-checklist dba-predeploy`
    - Create deployment runbook: `*create-runbook production-deploy`
    - Output deployment artifacts
  artifact-flow:
    output:
      - Predeploy checklist (completed)
      - Deployment runbook
      - Rollback plan
```

### 4. Environment Variable Management

#### Required Environment Variables
```bash
# Primary Connection (Pooler - recommended for production)
SUPABASE_DB_URL="postgresql://postgres.project-ref:password@aws-0-region.pooler.supabase.com:6543/postgres"

# Direct Connection (for migrations)
SUPABASE_DB_URL_DIRECT="postgresql://postgres.project-ref:password@aws-0-region.compute.amazonaws.com:5432/postgres"

# Service Role (dangerous - use sparingly)
SUPABASE_SERVICE_ROLE_KEY="eyJ..."

# Anon Key (for client-side)
SUPABASE_ANON_KEY="eyJ..."

# Project Reference
SUPABASE_PROJECT_REF="abcdefghij"

# Local Development
SUPABASE_LOCAL_DB_URL="postgresql://postgres:postgres@localhost:54322/postgres"
```

#### Environment Detection Pattern
All tasks should start with:
```markdown
## Step 1: Detect Environment

Elicit from user:
- [ ] What environment? (local/dev/staging/prod)
- [ ] Use pooler or direct connection?
- [ ] Confirm connection string (redacted)

Based on environment, use:
- Local: SUPABASE_LOCAL_DB_URL
- Remote: SUPABASE_DB_URL (pooler) or SUPABASE_DB_URL_DIRECT
```

---

## 📝 Implementation Phases

### Phase 0: Foundation (Day 1)
**Goal**: Set up infrastructure for agent development

#### Tasks
1. **Create sync script** (`sync-db-sage.sh`)
   ```bash
   #!/bin/bash
   # Sync DB Sage from .aios-core to .claude and .cursor

   AIOS_AGENT=".aios-core/agents/db-sage.md"
   CLAUDE_CMD=".claude/commands/db-sage.md"
   CURSOR_AGENT=".cursor/agents/db-sage.md"

   # Create symlinks
   ln -sf "../../${AIOS_AGENT}" "${CLAUDE_CMD}"
   ln -sf "../../${AIOS_AGENT}" "${CURSOR_AGENT}"

   echo "✅ DB Sage synced across .aios-core, .claude, .cursor"
   ```

2. **Create validation script** (`validate-db-sage.sh`)
   ```bash
   #!/bin/bash
   # Validate DB Sage installation

   echo "🔍 Validating DB Sage Agent..."

   # Check files exist
   [ -f ".aios-core/agents/db-sage.md" ] && echo "✅ Agent file exists" || echo "❌ Agent file missing"

   # Check MCP Supabase
   if grep -q "supabase" ~/.config/claude/mcp.json 2>/dev/null; then
     echo "✅ MCP Supabase configured"
   else
     echo "⚠️ MCP Supabase not configured"
   fi

   # Check Supabase CLI
   if command -v supabase &> /dev/null; then
     echo "✅ Supabase CLI installed: $(supabase --version)"
   else
     echo "❌ Supabase CLI not installed"
   fi

   # Check tasks
   TASK_COUNT=$(ls -1 .aios-core/tasks/db-*.md 2>/dev/null | wc -l)
   echo "📋 Tasks found: ${TASK_COUNT}/25"

   # Check templates
   TEMPLATE_COUNT=$(ls -1 .aios-core/templates/*sql* *tmpl.yaml 2>/dev/null | wc -l)
   echo "📄 Templates found: ${TEMPLATE_COUNT}/9"
   ```

3. **Update agent definition with MCP/CLI checks**
   - Add MCP verification to activation
   - Add CLI verification to activation
   - Add environment detection

#### Deliverables
- ✅ Sync script functional
- ✅ Validation script functional
- ✅ Agent definition updated with integrations

---

### Phase 1: Core Operations (Week 1)
**Goal**: Implement critical DBA workflows

#### Priority 1 Tasks (Day 1-2)

##### 1.1 `db-env-check.md`
```markdown
# Task: Environment Validation

## Purpose
Validate database connection and environment configuration.

## Activation
`*env-check` or `*check-env`

## Prerequisites
- MCP Supabase server configured
- OR: Environment variables set (SUPABASE_DB_URL)

## Execution

### Step 1: Detect Configuration Method
- Check if MCP Supabase available
- Check if SUPABASE_DB_URL set
- Check if Supabase CLI authenticated

### Step 2: Test Connection
Using MCP:
- Call `mcp__supabase__list_tables`
- Verify successful response

OR using environment:
- Parse SUPABASE_DB_URL
- Validate format
- Test with `psql` or Bash tool

### Step 3: Report Results
Output:
- ✅/❌ Connection successful
- Database: [name]
- Host: [host] (redacted password)
- Port: [port]
- SSL: [enabled/disabled]
- Method: [MCP/ENV/CLI]

## Error Handling
- If MCP fails → Suggest environment variables
- If ENV fails → Suggest MCP setup
- If both fail → Show troubleshooting guide

## Output
Connection status report
```

##### 1.2 `db-bootstrap.md`
```markdown
# Task: Bootstrap Database Project

## Purpose
Create supabase/ project structure for migration management.

## Activation
`*bootstrap`

## Prerequisites
- Supabase CLI installed
- OR: Manual mode (create folders)

## Elicitation
- [ ] Use Supabase CLI? (yes/no)
- [ ] Project already has supabase/? (yes/no)
- [ ] Create example migration? (yes/no)

## Execution

### Option A: Supabase CLI
```bash
supabase init
supabase login
supabase link --project-ref ${PROJECT_REF}
```

### Option B: Manual
```bash
mkdir -p supabase/migrations
mkdir -p supabase/seed
mkdir -p supabase/tests
mkdir -p supabase/snapshots
echo "# Snapshots - git ignored" > supabase/snapshots/.gitignore
```

### Step 2: Create README
```markdown
# Database Management

## Structure
- `migrations/` - Schema migrations (versioned)
- `seed/` - Seed data scripts (versioned)
- `tests/` - Database tests (versioned)
- `snapshots/` - Schema snapshots (NOT versioned)

## Workflow
1. Create snapshot: `*snapshot baseline`
2. Create migration: `supabase migration new description`
3. Dry run: `*dry-run migrations/YYYYMMDDHHMMSS_description.sql`
4. Apply: `*apply-migration migrations/YYYYMMDDHHMMSS_description.sql`
5. Test: `*smoke-test v1.0`
```

### Step 3: Create .gitignore
```
supabase/snapshots/
.env
*.dump
```

## Output
- ✅ Project structure created
- 📁 supabase/migrations/
- 📁 supabase/seed/
- 📁 supabase/tests/
- 📁 supabase/snapshots/ (git ignored)
```

##### 1.3 `db-snapshot.md`
```markdown
# Task: Create Schema Snapshot

## Purpose
Create point-in-time schema snapshot for rollback capability.

## Activation
`*snapshot [name]` or `*create-snapshot [name]`

## Prerequisites
- Environment validated (`*env-check`)
- supabase/snapshots/ directory exists

## Elicitation
- [ ] Snapshot name: _____ (default: timestamp)
- [ ] Include data? (schema-only/with-data)

## Execution

### Step 1: Generate Snapshot Name
If not provided: `snapshot_$(date +%Y%m%d_%H%M%S)`

### Step 2: Create Snapshot
Using Supabase CLI:
```bash
supabase db dump \
  --db-url "${SUPABASE_DB_URL}" \
  --schema public \
  -f "supabase/snapshots/${SNAPSHOT_NAME}.sql"
```

OR using MCP:
- Call `mcp__supabase__query` with schema introspection queries
- Build CREATE statements
- Write to file

### Step 3: Create Metadata
```json
{
  "name": "baseline",
  "created_at": "2025-10-26T12:00:00Z",
  "type": "schema-only",
  "db_url": "postgresql://postgres.project@host:6543/postgres",
  "tables": ["users", "posts", "comments"],
  "size_mb": 2.4
}
```

## Output
- ✅ Snapshot created: supabase/snapshots/${NAME}.sql
- 📄 Metadata: supabase/snapshots/${NAME}.json
- 🔒 Git ignored (not versioned)

## Error Handling
- If directory missing → Run `*bootstrap`
- If connection fails → Run `*env-check`
```

##### 1.4 `db-apply-migration.md`
```markdown
# Task: Apply Database Migration

## Purpose
Execute migration with safety checks and automatic rollback on failure.

## Activation
`*apply-migration [file]` or `*apply [file]`

## Prerequisites
- Migration file exists
- Snapshot exists (if not, create one)
- Environment validated

## Elicitation
- [ ] Migration file: _____ (required)
- [ ] Create snapshot first? (yes/no - default yes)
- [ ] Environment: (local/dev/staging/prod)
- [ ] Confirm production? (if prod - requires explicit yes)

## Execution

### Step 1: Pre-Flight Checks
- Validate migration file syntax (parse SQL)
- Check for dangerous operations (DROP, TRUNCATE)
- Verify snapshot exists or create one

### Step 2: Create Pre-Migration Snapshot
```bash
*snapshot "before_$(basename ${MIGRATION_FILE} .sql)"
```

### Step 3: Apply Migration
Using MCP:
```
mcp__supabase__query(sql=file_contents, transaction=true)
```

OR using Supabase CLI:
```bash
supabase db push --db-url "${SUPABASE_DB_URL}"
```

OR using direct psql:
```bash
psql "${SUPABASE_DB_URL}" -f "${MIGRATION_FILE}"
```

### Step 4: Validate Success
- Check for SQL errors
- Query `public.schema_migrations` if exists
- Run basic smoke test (SELECT 1)

### Step 5: Record Migration
Create log entry:
```json
{
  "migration": "20251026120000_add_users.sql",
  "applied_at": "2025-10-26T12:05:00Z",
  "status": "success",
  "snapshot": "before_20251026120000_add_users",
  "rollback_available": true
}
```

## Error Handling
If migration fails:
1. ❌ Migration failed
2. 🔄 Rollback to snapshot: ${SNAPSHOT_NAME}?
3. If yes → `*rollback ${SNAPSHOT_NAME}`
4. If no → Leave in failed state (manual intervention)

## Output
- ✅ Migration applied successfully
- 📸 Pre-migration snapshot: ${SNAPSHOT_NAME}
- 📝 Migration log updated
- ⏭️ Suggested next step: `*smoke-test v1.1`
```

##### 1.5 `db-rollback.md`
```markdown
# Task: Rollback to Snapshot

## Purpose
Restore database to previous snapshot state.

## Activation
`*rollback [snapshot]` or `*restore [snapshot]`

## Prerequisites
- Snapshot exists in supabase/snapshots/
- Environment validated

## Elicitation
- [ ] Snapshot name: _____ (required)
- [ ] Environment: (local/dev/staging/prod)
- [ ] ⚠️ DESTRUCTIVE OPERATION - Type "ROLLBACK" to confirm: _____

## Execution

### Step 1: Validate Snapshot
- Check file exists: `supabase/snapshots/${SNAPSHOT_NAME}.sql`
- Read metadata: `supabase/snapshots/${SNAPSHOT_NAME}.json`
- Show snapshot details

### Step 2: Create Safety Snapshot
Before rollback, create snapshot of current state:
```bash
*snapshot "before_rollback_to_${SNAPSHOT_NAME}"
```

### Step 3: Execute Rollback
⚠️ DESTRUCTIVE - drops all objects and recreates from snapshot

Using psql:
```bash
# Drop schema
psql "${SUPABASE_DB_URL}" -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

# Restore snapshot
psql "${SUPABASE_DB_URL}" -f "supabase/snapshots/${SNAPSHOT_NAME}.sql"
```

### Step 4: Validate Restoration
- Check table count matches snapshot metadata
- Run smoke test
- Verify critical tables exist

### Step 5: Update Migration History
- Record rollback in log
- Mark migrations as rolled back

## Error Handling
- If rollback fails → Attempt restore from safety snapshot
- If safety snapshot fails → MANUAL INTERVENTION REQUIRED

## Output
- ✅ Rolled back to: ${SNAPSHOT_NAME}
- 📸 Safety snapshot created: before_rollback_to_${SNAPSHOT_NAME}
- 📝 Migration history updated
- ⚠️ Reminder: Review what went wrong before re-applying migrations
```

##### 1.6 `db-smoke-test.md`
```markdown
# Task: Database Smoke Tests

## Purpose
Run automated validation tests after schema changes.

## Activation
`*smoke-test [version]` or `*test [version]`

## Prerequisites
- Database accessible
- Schema deployed

## Elicitation
- [ ] Version tag: _____ (e.g., v1.0, baseline)
- [ ] Test suite: (basic/standard/comprehensive)

## Execution

### Test Suite: Basic
```sql
-- Connection test
SELECT 1 AS connection_test;

-- Schema exists
SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'public';

-- Tables exist (list expected tables)
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```

### Test Suite: Standard
Basic + :
```sql
-- RLS enabled on all tables
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND rowsecurity = false;
-- Should return 0 rows

-- All tables have primary keys
SELECT table_name
FROM information_schema.tables t
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
  AND NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints tc
    WHERE tc.table_name = t.table_name
      AND tc.constraint_type = 'PRIMARY KEY'
  );
-- Should return 0 rows

-- Foreign key integrity
SELECT * FROM (
  -- Run FK checks on all tables
  SELECT conname, conrelid::regclass
  FROM pg_constraint
  WHERE contype = 'f'
) fks;
```

### Test Suite: Comprehensive
Standard + :
```sql
-- Trigger existence
-- Function existence
-- Index usage validation
-- Partition health (if applicable)
-- Replication lag (if applicable)
```

### Step: Execute Tests
Run tests using MCP:
```
mcp__supabase__query(sql=test_suite)
```

### Step: Generate Report
```markdown
# Smoke Test Report - ${VERSION}

**Date**: 2025-10-26 12:00:00
**Environment**: production
**Test Suite**: standard
**Status**: ✅ PASSED

## Results
- ✅ Connection successful
- ✅ Schema 'public' exists
- ✅ 12/12 expected tables exist
- ✅ RLS enabled on all tables
- ✅ All tables have primary keys
- ✅ Foreign key integrity validated

## Performance
- Total test time: 1.2s
- Queries executed: 15

## Next Steps
- Deploy to production ✅
- Monitor for 24h
```

## Output
- 📊 Test report generated
- ✅/❌ Overall status
- 📝 Saved to: supabase/tests/smoke-test-${VERSION}.md
```

#### Priority 2 Tasks (Day 3-5)

##### 1.7 `db-seed.md`
```markdown
# Task: Load Seed Data

## Purpose
Load test/demo data into database safely.

## Activation
`*seed [file]` or `*load-seed [file]`

## Prerequisites
- Seed file exists in supabase/seed/
- Schema deployed

## Elicitation
- [ ] Seed file: _____ (required)
- [ ] Environment: (local/dev/staging/prod)
- [ ] Destructive mode? (truncate-first/append-only)
- [ ] ⚠️ If truncate: Type "TRUNCATE" to confirm: _____

## Execution

### Step 1: Validate Seed File
- Check file syntax
- Identify tables affected

### Step 2: Create Snapshot
```bash
*snapshot "before_seed_$(basename ${SEED_FILE} .sql)"
```

### Step 3: Apply Seed
If truncate mode:
```sql
BEGIN;
TRUNCATE ${TABLES} CASCADE;
\i supabase/seed/${SEED_FILE}
COMMIT;
```

If append mode:
```sql
\i supabase/seed/${SEED_FILE}
```

### Step 4: Validate
- Check row counts
- Run basic queries
- Verify data integrity

## Output
- ✅ Seed data loaded
- 📸 Pre-seed snapshot: ${SNAPSHOT_NAME}
- 📊 Rows inserted: 1,234
```

##### 1.8 `db-dry-run.md`
```markdown
# Task: Dry Run Migration

## Purpose
Test migration safety without applying changes.

## Activation
`*dry-run [file]` or `*test-migration [file]`

## Prerequisites
- Migration file exists
- Environment validated

## Execution

### Step 1: Parse Migration
- Extract SQL statements
- Identify DDL operations (CREATE, ALTER, DROP)
- Identify DML operations (INSERT, UPDATE, DELETE)
- Flag dangerous operations

### Step 2: Create Temporary Database
Using Supabase CLI (local):
```bash
supabase start
supabase db reset
```

OR using snapshot:
```bash
*snapshot "dryrun_source"
# Create temp connection to test database
```

### Step 3: Apply to Test Environment
```bash
psql "${TEST_DB_URL}" -f "${MIGRATION_FILE}"
```

### Step 4: Run Validation
- Check for SQL errors
- Run smoke tests
- Compare schema before/after

### Step 5: Generate Report
```markdown
# Dry Run Report - ${MIGRATION_FILE}

## Analysis
- ✅ Syntax valid
- ⚠️ 1 dangerous operation detected:
  - DROP TABLE old_users (line 12)
- ✅ All foreign keys maintained
- ✅ No index drops

## Test Results
- ✅ Applied successfully to test DB
- ✅ Smoke tests passed
- ⏱️ Execution time: 0.8s

## Recommendation
- ⚠️ Review DROP operation before production
- ✅ Safe to apply with caution
```

## Output
- 📊 Dry run report
- ✅/❌/⚠️ Safety assessment
- 🔄 If safe: Suggest `*apply-migration ${FILE}`
```

#### Deliverables Phase 1
- ✅ 8 critical tasks implemented
- ✅ Complete migration lifecycle functional
- ✅ MCP integration working
- ✅ CLI integration working
- ✅ Safety mechanisms in place

---

### Phase 2: Security & Quality (Week 2)
**Goal**: Implement security auditing and quality checks

#### Tasks to Create
1. `db-rls-audit.md` - RLS coverage analysis
2. `db-policy-apply.md` - RLS policy installation
3. `schema-audit.md` - Schema quality audit
4. `dba-predeploy-checklist.md` - Pre-deployment validation

#### Templates to Create
1. `rls-kiss-policy-tmpl.sql` - Simple RLS template
2. `rls-granular-policy-tmpl.sql` - Complex RLS template
3. `smoke-test-suite-tmpl.yaml` - Test suite configuration

#### Checklists to Create
1. `dba-predeploy-checklist.md`
2. `security-audit-checklist.md`
3. `database-design-checklist.md`

---

### Phase 3: Design Tools (Week 3)
**Goal**: Implement architecture and design capabilities

#### Tasks to Create
1. `domain-modeling.md` - Interactive domain modeling
2. `query-optimization.md` - Query performance optimization
3. `supabase-setup.md` - Supabase project setup

#### Templates to Complete
1. Complete `migration-plan-tmpl.yaml`
2. Create `index-strategy-tmpl.yaml`
3. Create `db-runbook-tmpl.yaml`

#### Data Files to Create
1. `database-best-practices.md`
2. `supabase-patterns.md`
3. `rls-security-patterns.md`

---

### Phase 4: Advanced Operations (Week 4)
**Goal**: Enterprise-grade observability and operations

#### Tasks to Create
1. `db-monitor-queries.md` - Query monitoring
2. `db-check-locks.md` - Lock analysis
3. `db-vacuum-status.md` - Vacuum monitoring
4. `db-backup.md` - Backup operations
5. `db-restore.md` - Restore operations
6. `db-compare-schemas.md` - Schema drift detection
7. `db-analyze-hotpaths.md` - Performance analysis
8. `db-test-suite.md` - Testing framework

#### Data Files to Create
1. `postgres-tuning-guide.md`
2. `migration-safety-guide.md`
3. `schema-evolution-strategies.md`
4. `mcp-supabase-integration.md`

---

## 🔄 Synchronization Strategy

### Automated Sync
```bash
# .aios-core/scripts/sync-db-sage.sh

#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

cd "${PROJECT_ROOT}"

echo "🔄 Syncing DB Sage Agent..."

# Sync agent file
cp .aios-core/agents/db-sage.md .claude/commands/db-sage.md
cp .aios-core/agents/db-sage.md .cursor/agents/db-sage.md

# Sync tasks (if needed in other locations)
# rsync -av .aios-core/tasks/db-*.md .claude/tasks/
# rsync -av .aios-core/tasks/db-*.md .cursor/tasks/

echo "✅ DB Sage synced to .claude and .cursor"
echo "📝 Files synced:"
echo "   - .aios-core/agents/db-sage.md → .claude/commands/db-sage.md"
echo "   - .aios-core/agents/db-sage.md → .cursor/agents/db-sage.md"
```

### Git Hook Integration
```bash
# .git/hooks/pre-commit

#!/bin/bash
# Auto-sync DB Sage on commit

if git diff --cached --name-only | grep -q "^.aios-core/agents/db-sage.md"; then
  echo "🔄 DB Sage changed, syncing..."
  .aios-core/scripts/sync-db-sage.sh
  git add .claude/commands/db-sage.md .cursor/agents/db-sage.md
fi
```

---

## ✅ Quality Assurance

### Testing Checklist
- [ ] Agent activates in all 3 IDEs (.aios-core, .claude, .cursor)
- [ ] MCP Supabase commands work
- [ ] Supabase CLI commands work
- [ ] Environment detection works (local/dev/staging/prod)
- [ ] All 25 tasks execute without errors
- [ ] Templates generate valid outputs
- [ ] Checklists catch common mistakes
- [ ] Cross-agent handoffs work (@architect, @dev, @qa, @devops)
- [ ] Error handling is graceful
- [ ] Documentation is complete

### Validation Script
Run after each phase:
```bash
.aios-core/scripts/validate-db-sage.sh
```

---

## 📚 Documentation Structure

### Agent Documentation
```markdown
# DB Sage Agent

## Overview
[Purpose, capabilities, when to use]

## Quick Start
1. Activate: `/db-sage`
2. Check environment: `*env-check`
3. Bootstrap project: `*bootstrap`
4. Create baseline: `*snapshot baseline`

## Commands
[Full command reference]

## Workflows
[Common workflows with examples]

## Integration
[MCP, CLI, cross-agent integration]

## Troubleshooting
[Common issues and solutions]
```

### Task Documentation Template
```markdown
# Task: [Task Name]

## Purpose
[One-line description]

## Activation
`*command` or `*alternate-command`

## Prerequisites
- [Prerequisite 1]
- [Prerequisite 2]

## Elicitation
- [ ] [User input 1]: _____ (required/optional)
- [ ] [User input 2]: _____ (default: value)

## Execution
### Step 1: [Step name]
[Detailed instructions]

### Step 2: [Step name]
[Detailed instructions]

## Error Handling
- If [error] → [solution]

## Output
- [Output 1]
- [Output 2]

## Next Steps
- Suggested: `*next-command`
```

---

## 🎯 Success Metrics

### Phase 1 Success
- [ ] Can create project structure
- [ ] Can apply migrations
- [ ] Can rollback safely
- [ ] Can run smoke tests
- [ ] All operations logged

### Phase 2 Success
- [ ] Can audit RLS coverage
- [ ] Can apply security policies
- [ ] Can check schema quality
- [ ] Pre-deploy checklist works

### Phase 3 Success
- [ ] Can model domains
- [ ] Can design schemas
- [ ] Can plan migrations
- [ ] Can optimize queries

### Phase 4 Success
- [ ] Can monitor performance
- [ ] Can detect issues
- [ ] Can analyze trends
- [ ] Can automate operations

---

## 🚀 Next Actions

### Immediate (Today)
1. Review this implementation guide
2. Approve approach and priorities
3. Start Phase 0: Create sync/validation scripts
4. Update db-sage.md agent definition with MCP/CLI integration

### This Week
1. Implement Phase 1: Core Operations (8 tasks)
2. Test each task as created
3. Validate MCP integration
4. Validate CLI integration

### Next Steps
1. Answer the 5 questions from architectural analysis
2. Decide on immediate priorities
3. Begin implementation

---

## ❓ Decision Points

Please clarify:

1. **Immediate Priority**: Start with Phase 0 foundation scripts?

2. **MCP Configuration**: Is Supabase MCP already configured in your system?

3. **CLI Preference**: Should tasks prefer CLI over MCP, or vice versa?

4. **Atlas Migration**: Merge Atlas agent into DB Sage, or keep separate?

5. **Testing Strategy**: Create test database for dry-runs, or use local Supabase?

---

**Ready to begin implementation?** Let's start with Phase 0 and build the foundation!
