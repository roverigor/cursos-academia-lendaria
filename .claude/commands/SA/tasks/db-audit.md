# /SA:db-audit - Database vs Expansion Pack Integration Audit

**Quick alias for:** `/SA:db-sage *expansion-pack-check`

---

# Database Integration Audit Task

Analyzes an expansion pack's data requirements and designs database integration strategy. Evaluates if database persistence is actually needed (KISS Gate) and generates complete integration plan.

## What This Does

1. **Audits expansion pack data flows** - Inputs, outputs, state requirements
2. **Analyzes current database schema** - What already exists
3. **Applies KISS Gate validation** - Is database really needed?
4. **Designs integration schema** - If needed, proposes tables/relationships
5. **Generates migration plan** - With rollback strategy
6. **Creates documentation** - Integration guides and usage examples
7. **Produces audit report** - Clear recommendation with rationale

## Usage

```bash
/SA:db-audit

# Will prompt for:
# - Which expansion pack to audit
# - Path to expansion pack directory
```

## Output Files

```yaml
expansion-packs/{pack-name}/
├── database-integration-report.yaml  # Main audit report
├── data-flow-audit.yaml              # Data flow findings
└── schema-design.yaml                # Proposed schema (if applicable)

docs/{pack-name}/
├── database-integration.md           # Usage guide
├── database-schema.yaml              # Schema definition
└── migration-plan.yaml               # Migration strategy

supabase/migrations/
└── 2025MMDD_NNN_{pack}_*.sql        # Ready-to-apply migrations
```

## KISS Gate Validation

Before recommending database integration:
- ✅ Is database actually needed?
- ✅ What specific problem does it solve?
- ✅ Can existing tables be reused?
- ✅ What's the minimum viable schema?

## Example Report

```yaml
integration_analysis:
  expansion_pack: mmos
  recommendation: "Integrate with database"
  rationale: |
    - Multi-user access required
    - Version tracking needed
    - Vector search needed for RAG
  tables_added: 3
  migration_risk: low
  estimated_effort: 4 hours
```

## Related Commands

- `/SA:db-sage *validate-kiss` - Run KISS validation first
- `/SA:db-sage *create-schema` - Design full schema
- `/SA:db-sage *migrate` - Execute migrations

---

**Source:** `expansion-packs/super-agentes/tasks/db-expansion-pack-integration.md`