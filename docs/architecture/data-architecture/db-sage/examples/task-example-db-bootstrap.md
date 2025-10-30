# DB Bootstrap Task

**Agent**: db-sage  
**Command**: `*bootstrap`  
**Purpose**: Scaffold complete Supabase project structure with migrations, seeds, tests, and documentation

---

## Overview

This task creates a standardized Supabase project structure following best practices for:
- Migration management
- Seed data
- Testing infrastructure
- Rollback capabilities
- Documentation

---

## Prerequisites

- Project directory exists
- Git initialized (optional but recommended)
- Supabase CLI installed (optional, but enables `supabase` commands)

---

## Execution Process

### Step 1: Confirm Project Details

Ask user for:

**1. Project name**: (e.g., "mmos-platform")  
**2. Database target**: 
   - Local Supabase (default)
   - Remote Supabase (needs project ref)
   - Self-hosted PostgreSQL

**3. Include starter templates?**
   - Baseline schema (users, profiles, audit tables)
   - Standard RLS policies
   - Smoke test template
   - Seed data template

**4. Git integration?**
   - Add `.gitignore` for Supabase secrets
   - Initialize migrations tracking

### Step 2: Create Directory Structure

Create the following structure:

```
supabase/
├── migrations/
│   ├── README.md                    # Migration guidelines
│   └── .gitkeep
├── seeds/
│   ├── README.md                    # Seed data guidelines
│   └── .gitkeep
├── tests/
│   ├── README.md                    # Testing guidelines
│   ├── smoke/
│   │   └── .gitkeep
│   └── integration/
│       └── .gitkeep
├── rollback/
│   ├── README.md                    # Rollback procedures
│   └── .gitkeep
├── snapshots/
│   ├── README.md                    # Snapshot documentation
│   └── .gitkeep
├── docs/
│   ├── schema-design.md             # Schema documentation
│   ├── rls-policies.md              # RLS documentation
│   ├── migration-log.md             # Migration history
│   └── README.md
├── functions/                        # Edge Functions (if needed)
│   └── .gitkeep
├── config.toml                       # Supabase config
└── .gitignore                        # Git ignore patterns
```

### Step 3: Generate Core Files

#### `supabase/config.toml`

```toml
# Supabase Project Configuration

[api]
enabled = true
port = 54321
schemas = ["public", "storage", "graphql_public"]
extra_search_path = ["public", "extensions"]
max_rows = 1000

[db]
port = 54322
shadow_port = 54320
major_version = 15

[db.pooler]
enabled = true
port = 54329
pool_mode = "transaction"
default_pool_size = 20
max_client_conn = 100

[realtime]
enabled = true
ip_version = "ipv4"

[studio]
enabled = true
port = 54323
api_url = "http://localhost"

[inbucket]
enabled = true
port = 54324
smtp_port = 54325
pop3_port = 54326

[storage]
enabled = true
file_size_limit = "50MiB"

[auth]
enabled = true
site_url = "http://localhost:3000"
additional_redirect_urls = ["https://localhost:3000"]
jwt_expiry = 3600
enable_refresh_token_rotation = true
refresh_token_reuse_interval = 10
enable_signup = true

[auth.email]
enable_signup = true
double_confirm_changes = true
enable_confirmations = false

# Migrations
[migrations]
# Directory where migration files are stored
directory = "migrations"
```

#### `supabase/migrations/README.md`

```markdown
# Database Migrations

## Naming Convention

Migrations follow the format: `YYYYMMDDHHMMSS_description.sql`

Example: `20251026120000_initial_schema.sql`

## Order of Operations

Migrations should follow this order within each file:

1. **Extensions** - Enable required extensions
2. **Tables** - Create tables and columns
3. **Indexes** - Add indexes for performance
4. **Functions** - Create helper functions
5. **Triggers** - Set up automated behaviors
6. **RLS** - Enable and configure Row Level Security
7. **Policies** - Define access control policies
8. **Views** - Create database views
9. **Grants** - Set permissions

## Best Practices

1. **Always idempotent** - Use `IF NOT EXISTS` / `IF EXISTS`
2. **Test locally first** - Run `supabase db reset` to test
3. **Include rollback** - Document how to undo changes
4. **Small migrations** - One logical change per migration
5. **Document changes** - Add comments explaining why
6. **Snapshot before** - Create snapshot before applying

## Running Migrations

```bash
# Local testing
supabase db reset

# Apply specific migration
psql $DATABASE_URL -f migrations/20251026120000_initial_schema.sql

# Via db-sage agent
*apply-migration migrations/20251026120000_initial_schema.sql
```

## Rollback

Each migration should have a corresponding rollback plan documented in `/rollback/`.
```

#### `supabase/seeds/README.md`

```markdown
# Seed Data

Seed files populate the database with initial or test data.

## Naming Convention

`YYYYMMDDHHMMSS_description_seed.sql`

Example: `20251026120000_initial_users_seed.sql`

## Types of Seeds

1. **Required Seeds** - Data the application needs to function
   - Default roles
   - System configuration
   - Initial admin accounts

2. **Test Seeds** - Data for development/testing
   - Sample users
   - Demo content
   - Edge cases for testing

3. **Reference Seeds** - Lookup data
   - Country codes
   - Category lists
   - Status enums

## Best Practices

1. **Idempotent** - Safe to run multiple times
2. **Conditional inserts** - Check before inserting
3. **Use transactions** - Rollback on error
4. **Document purpose** - Why this data exists
5. **Version seeds** - Match with schema versions

## Running Seeds

```bash
# Via psql
psql $DATABASE_URL -f seeds/20251026120000_initial_users_seed.sql

# Via db-sage agent
*seed seeds/20251026120000_initial_users_seed.sql
```
```

#### `supabase/tests/README.md`

```markdown
# Database Tests

## Test Types

### Smoke Tests
Quick validation that basic functionality works:
- Tables exist
- RLS is enabled where needed
- Policies are installed
- Functions are callable
- Triggers fire correctly

### Integration Tests
Test interactions between components:
- Foreign key cascades
- Trigger chains
- Complex RLS scenarios
- Multi-table transactions

## Running Tests

```bash
# Via db-sage agent
*smoke-test v1.0

# Direct SQL execution
psql $DATABASE_URL -f tests/smoke/v1_0_smoke_test.sql
```

## Test Guidelines

1. **Test positive and negative cases**
2. **Use test transactions** - Rollback after tests
3. **Document expected behavior**
4. **Automate where possible**
5. **Run before deployments**
```

#### `supabase/rollback/README.md`

```markdown
# Rollback Procedures

## Snapshots

Before any migration, create a snapshot:

```bash
*snapshot pre_migration_v1_2
```

## Rollback Strategies

### 1. Snapshot Restore
Restore to a previous snapshot:

```bash
*rollback snapshots/pre_migration_v1_2.sql
```

### 2. Reverse Migration
Run explicit rollback script:

```bash
*rollback rollback/20251026120000_rollback.sql
```

### 3. Manual Rollback
Follow documented procedures in migration file.

## When to Rollback

- Migration fails midway
- Data corruption detected
- Performance degradation
- User-facing bugs introduced
- Testing reveals issues

## Rollback Checklist

- [ ] Verify backup/snapshot exists
- [ ] Understand what will be lost
- [ ] Notify stakeholders
- [ ] Run rollback in transaction first
- [ ] Verify application compatibility
- [ ] Monitor after rollback
- [ ] Document root cause
```

#### `supabase/.gitignore`

```gitignore
# Supabase
.env
.env.local
.env.*.local

# Local development
.branches
.temp

# OS
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Logs
*.log
npm-debug.log*

# Snapshots (optional - may want to commit some)
# snapshots/*.sql

# Secrets
**/secrets/
**/.secret
```

### Step 4: Generate Starter Templates (if requested)

If user wants starter templates, create:

#### `supabase/migrations/20251026120000_baseline_schema.sql`

```sql
-- Migration: Baseline Schema
-- Created: 2025-10-26
-- Description: Initial database schema with users, profiles, and audit tables

BEGIN;

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- TABLES
-- =====================================================

-- User profiles (extends auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username TEXT UNIQUE,
    full_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Audit log table
CREATE TABLE IF NOT EXISTS public.audit_log (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    table_name TEXT NOT NULL,
    record_id UUID,
    old_data JSONB,
    new_data JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_profiles_username ON public.profiles(username);
CREATE INDEX IF NOT EXISTS idx_audit_log_user_id ON public.audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_created_at ON public.audit_log(created_at DESC);

-- =====================================================
-- FUNCTIONS
-- =====================================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- TRIGGERS
-- =====================================================

CREATE TRIGGER set_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- RLS (Row Level Security)
-- =====================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- RLS POLICIES
-- =====================================================

-- Profiles: Users can read their own profile
CREATE POLICY "Users can view own profile"
    ON public.profiles
    FOR SELECT
    TO authenticated
    USING (auth.uid() = id);

-- Profiles: Users can update their own profile
CREATE POLICY "Users can update own profile"
    ON public.profiles
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- Profiles: Users can insert their own profile
CREATE POLICY "Users can insert own profile"
    ON public.profiles
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = id);

-- Audit log: Only viewable by admins (adjust as needed)
CREATE POLICY "Admins can view audit log"
    ON public.audit_log
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.profiles
            WHERE id = auth.uid()
            AND role = 'admin'  -- Adjust based on your role system
        )
    );

-- =====================================================
-- GRANTS
-- =====================================================

GRANT USAGE ON SCHEMA public TO authenticated, anon;
GRANT SELECT, INSERT, UPDATE ON public.profiles TO authenticated;
GRANT SELECT ON public.audit_log TO authenticated;

COMMIT;

-- =====================================================
-- ROLLBACK INSTRUCTIONS
-- =====================================================
-- To rollback this migration:
-- DROP TRIGGER IF EXISTS set_updated_at ON public.profiles;
-- DROP FUNCTION IF EXISTS public.handle_updated_at();
-- DROP TABLE IF EXISTS public.audit_log;
-- DROP TABLE IF EXISTS public.profiles;
```

### Step 5: Create Migration Log

Initialize `supabase/docs/migration-log.md`:

```markdown
# Migration Log

## Version 0.1.0 - Baseline (2025-10-26)

### Migration: `20251026120000_baseline_schema.sql`

**Applied**: YYYY-MM-DD HH:MM:SS  
**Applied By**: [Name]  
**Status**: ✅ Success

**Changes**:
- Created `profiles` table
- Created `audit_log` table
- Enabled RLS on both tables
- Created standard policies
- Added updated_at trigger

**Rollback**: See migration file comments

**Notes**: Initial schema establishment

---

## Version Template

```markdown
## Version X.Y.Z - [Title] (YYYY-MM-DD)

### Migration: `YYYYMMDDHHMMSS_description.sql`

**Applied**: YYYY-MM-DD HH:MM:SS  
**Applied By**: [Name]  
**Status**: ⏳ Pending / ✅ Success / ❌ Failed / ⏪ Rolled Back

**Changes**:
- List of changes

**Rollback**: Rollback strategy

**Notes**: Additional context
```
```

### Step 6: Output Summary

Show user:

```
✅ Supabase project structure created!

📁 Created directories:
   - supabase/migrations/
   - supabase/seeds/
   - supabase/tests/
   - supabase/rollback/
   - supabase/snapshots/
   - supabase/docs/

📄 Generated files:
   - config.toml
   - README files for all directories
   - .gitignore
   [if starter templates]
   - 20251026120000_baseline_schema.sql
   - migration-log.md

🚀 Next steps:
   1. Review config.toml and adjust for your project
   2. Run: *apply-migration migrations/20251026120000_baseline_schema.sql
   3. Create your first seed: *seed seeds/your_seed.sql
   4. Test with: *smoke-test v0.1.0

📚 Documentation:
   - Migration guide: supabase/migrations/README.md
   - Rollback procedures: supabase/rollback/README.md
   - Testing guide: supabase/tests/README.md

⚠️ Important:
   - Never commit secrets (.env files)
   - Always snapshot before migrations
   - Test migrations locally first
   - Document all changes in migration-log.md
```

---

## Options

**User can select**:
1. **Minimal** - Just directory structure
2. **Standard** - Directories + READMEs + config
3. **Full** - Everything + starter templates
4. **Custom** - Ask for each component

---

## Error Handling

If directory exists:
- Ask to merge or abort
- Warn about overwriting files
- Offer to backup existing structure

If Supabase CLI not installed:
- Still create structure
- Note which commands require CLI
- Provide installation instructions

---

## Post-Bootstrap Recommendations

1. **Initialize Git** (if not already)
   ```bash
   git init
   git add supabase/
   git commit -m "feat: initialize supabase structure"
   ```

2. **Configure Environment**
   ```bash
   cp .env.example .env
   # Add your DATABASE_URL
   ```

3. **Test Connection**
   ```bash
   *env-check
   ```

4. **Create First Migration**
   ```bash
   *create-schema
   ```

---

## Notes

- This task is idempotent - safe to run multiple times
- Existing files are not overwritten unless confirmed
- All generated files follow best practices
- Structure is compatible with Supabase CLI
- Can be used with or without Supabase platform
