# ⚡ SuperAgentes Expansion Pack

**Version:** 2.0.0
**Command:** `/SA`
**Type:** Meta-Orchestrator

SuperAgentes is a unified orchestrator expansion pack that provides seamless access to specialized database and design system capabilities through intelligent command routing and agent transformation.

## 🎯 Overview

SuperAgentes consolidates **3 powerful agents** into a single, cohesive interface:

1. **SuperAgentes** (⚡) - Meta-orchestrator
2. **DB Sage** (🗄️) - Database Architect & Operations Engineer
3. **Design System** (🎨) - Brad Frost methodology for complete design system workflow

Instead of switching between different agents manually, SuperAgentes provides:
- **Prefix Routing**: Execute commands directly with `*db:comando` or `*ds:comando`
- **Agent Transformation**: Transform into a specialist agent for extended work
- **Complete Workflows**: Design System agent handles brownfield audit through component building
- **Smart Help**: Unified help system that shows all available capabilities
- **Context Preservation**: Maintains conversation state across agent contexts

## 🚀 Quick Start

### Activate SuperAgentes

**Claude Code / .claude:**
```bash
/SA                  # Activates SuperAgentes Orchestrator
```

**Cursor / .cursor:**
```bash
@SA                  # Activates SuperAgentes Orchestrator
```

You'll see:
```
⚡ SuperAgentes Orchestrator activated!

I coordinate DB Sage (database operations) and Design System (design patterns).

Quick access:
- *help .......... Show all commands
- *db:help ....... Database commands
- *ds:help ....... Design system commands
- *agent db-sage . Transform to DB Sage

All commands start with * (asterisk)
```

### IDE-Specific Access

| IDE | Primary Agent | DB Sage | Design System |
|-----|---------------|---------|---------------|
| **Claude Code** | `/SA` | `/SA *db:comando` | `/SA *ds:comando` |
| **Cursor** | `@SA` | `@db-sage` | `@design-system` |
| **Direct** | Via expansion pack | Via agent file | Via agent file |

### Quick Commands

```bash
# Show all available commands
*help

# Database operations (prefix routing)
*db:help                     # Show all DB commands
*db:create-schema            # Design database schema
*db:apply-migration path.sql # Run migration safely
*db:rls-audit                # Audit RLS policies
*db:snapshot baseline        # Create rollback point

# Design system operations (prefix routing)
*ds:audit ./src              # Audit UI pattern redundancy
*ds:consolidate              # Reduce patterns via clustering
*ds:tokenize                 # Generate design tokens
*ds:build button             # Generate Button component
*ds:shock-report             # Generate visual HTML report

# Agent transformation
*agent db-sage               # Transform into DB Sage for extended work
*agent design-system         # Transform into Design System (Brad Frost)
*exit                        # Return to SuperAgentes
```

## 📦 What's Included

### DB Sage (Production Ready)

**Status:** ✅ Complete (v1.1.0)
**Resources:** 23 tasks, 12 templates, 3 checklists, 5 data files, examples

#### Architecture & Design
- Schema design and domain modeling
- RLS policy creation
- Migration planning
- Index strategy design

#### Operations & DBA
- Environment validation (`*db:env-check`)
- Project bootstrapping (`*db:bootstrap`)
- Safe migrations with snapshots (`*db:apply-migration`)
- Seed data management (`*db:seed`)
- Rollback capabilities (`*db:rollback`)
- Comprehensive smoke testing (`*db:smoke-test`)

#### Security & Performance
- RLS audit and policy application (`*db:rls-audit`)
- User impersonation for testing (`*db:impersonate`)
- DDL ordering validation (`*db:verify-order`)
- Query performance analysis (`*db:explain`)
- Schema quality audits (`*db:audit-schema`)

#### Data Operations
- Safe CSV import (`*db:load-csv`)
- SQL execution (`*db:run-sql`)
- Supabase setup (`*db:setup-supabase`)

### Design System (Production Ready)

**Status:** ✅ Complete (v2.0.0)
**Resources:** 12 tasks, 7 templates, 4 checklists, 6 data files, 3 workflows
**Persona:** Brad Frost methodology - "Show the horror, then fix it"

Complete design system workflow with 12 unified commands:

#### Brownfield Workflow (70% of use cases)
**audit → consolidate → tokenize → migrate → build → compose → document**

**Audit & Consolidation:**
- Brownfield codebase audit (`*audit ./src`)
- Pattern redundancy detection (buttons, colors, spacing, typography)
- Intelligent consolidation via HSL clustering (>80% reduction target)
- Design token extraction and generation
- Multi-format token export (JSON, CSS, Tailwind, SCSS)

**Analysis & Planning:**
- ROI calculation with cost savings analysis (pattern-weighted costs)
- Shock report generation (visual HTML report with side-by-side comparisons)
- 4-phase migration strategy planning (foundation → high-impact → long-tail → enforcement)

**Component Building:**
- Setup design system structure (`*setup`)
- Build production components (`*build button`)
- Compose molecules from atoms (`*compose form-field`)
- Extend existing patterns (`*extend button`)
- Generate documentation (`*document`)
- Integrate with expansion packs (`*integrate mmos`)

#### Greenfield Workflow (20% of use cases)
**setup → build → compose → document**

Start fresh with token-based design system, generate production-ready components from scratch.

#### Audit-Only Workflow (10% of use cases)
**audit → shock-report → calculate-roi**

Generate visual shock reports and ROI analysis for executive stakeholders without building components.

#### Component Generation Standards
- React TypeScript components (strict mode)
- Token-based styling (zero hardcoded values)
- WCAG AA accessibility minimum (AAA target)
- Unit tests with >80% coverage (Jest, React Testing Library)
- Storybook stories included
- Atomic Design structure (atoms → molecules → organisms)

#### Integration Ready
- MMOS: Personality-based token variations for cognitive clones
- CreatorOS: Educational tokens for course platforms
- InnerLens: Minimal distraction tokens for assessments

## 💡 Usage Patterns

### Pattern 1: Prefix Routing (Quick Operations)

Use for single commands or quick operations:

```bash
/SA
*db:snapshot baseline        # Take snapshot
*db:apply-migration v1.sql   # Apply migration
*db:smoke-test v1            # Run tests
```

### Pattern 2: Agent Transformation (Extended Work)

Use for extended work in one domain:

```bash
/SA
*agent db-sage
*create-schema         # Now in DB Sage context
*design-indexes
*create-migration-plan
*exit                  # Back to SuperAgentes
```

### Pattern 3: Mixed Workflow

Combine both approaches:

```bash
/SA
*db:snapshot baseline        # Quick snapshot
*agent db-sage              # Transform for design work
*model-domain               # Extended domain modeling
*create-schema
*exit                       # Back to SuperAgentes
*db:apply-migration v1.sql  # Quick migration apply
```

### Pattern 4: Design System - Brownfield Complete

Complete audit through component building workflow:

```bash
/SA
*agent design-system        # Brad activates

*audit ./src                # Scan for pattern redundancy
# Output: 47 buttons, 89 colors, 176 total patterns

*consolidate                # Reduce via clustering
# Output: 47 → 3 buttons (93.6% reduction)

*tokenize                   # Generate design tokens
# Output: tokens.yaml + JSON/CSS/Tailwind exports

*migrate                    # Generate migration strategy
# Output: 4-phase plan with component priorities

*build button               # Generate Button component
*build input                # Generate Input component
*compose form-field         # Compose molecule from atoms
*document                   # Generate pattern library

*exit                       # Back to SuperAgentes
```

### Pattern 5: Design System - Audit Only

Generate shock report and ROI for stakeholders:

```bash
/SA
*agent design-system        # Brad activates

*audit ./src                # Scan codebase
*consolidate                # Reduce patterns
*shock-report               # Visual HTML report
*calculate-roi              # Cost analysis
# Output: ROI 34.6x, breakeven 10 days, $374k/year savings

*exit                       # Done - no build phase needed
```

### Pattern 6: Design System - Greenfield

Start fresh with token-based components:

```bash
/SA
*agent design-system        # Brad activates

*setup                      # Initialize structure
# Provide tokens.yaml or create starter tokens

*build button               # Generate components
*build input
*compose form-field
*document

*exit
```

## 🗂️ Project Structure

```
expansion-packs/super-agentes/
├── agents/
│   ├── super-agentes.md     # Meta-orchestrator (⚡)
│   ├── db-sage.md           # Database specialist (🗄️)
│   └── design-system.md     # Design System - Brad Frost (🎨)
├── tasks/                   # 35 tasks total
│   ├── (20 database)        # DB Sage tasks
│   ├── (12 design system)   # Design System unified (6 brownfield + 6 greenfield)
│   └── (3 shared)           # AIOS core tasks
├── templates/               # 20 templates total
│   ├── (12 database)        # Schema, migration, RLS templates
│   ├── (7 design system)    # Tokens, components, state, reports, exports
│   └── (1 shared)           # AIOS core template
├── checklists/              # 7 quality checklists
│   ├── (3 database)         # DB design, migration safety
│   └── (4 design system)    # Pattern audit, component quality, WCAG, migration
├── data/                    # 11 knowledge base files
│   ├── (5 database)         # DB best practices, RLS patterns
│   └── (6 design system)    # Atomic design, tokens, consolidation, ROI, integration, WCAG
├── workflows/               # 3 YAML workflow orchestrations
│   ├── brownfield-complete.yaml   # 70% use case: audit → build
│   ├── greenfield-new.yaml        # 20% use case: setup → build
│   └── audit-only.yaml            # 10% use case: shock reports + ROI
├── examples/                # Usage examples
├── config.yaml              # Expansion pack config (v2.0.0)
└── README.md                # This file
```

## 🎭 How It Works

SuperAgentes follows the **AIOS Orchestrator Pattern**:

1. **Meta-Agent Layer**: SuperAgentes orchestrator coordinates 3 specialist agents
2. **Specialist Agents**: DB Sage (database), Design System (Brad Frost methodology)
3. **Shared Resources**: All agents use the same tasks, templates, and checklists
4. **Smart Routing**: Commands with prefixes route automatically to the right context
5. **Transformation**: Use `*agent` command for full agent immersion
6. **Complete Workflows**: Design System handles brownfield audit through component building

### Command Flow

```
User: /SA db:create-schema
  ↓
SuperAgentes detects "db:" prefix
  ↓
Routes to DB Sage context
  ↓
Executes create-schema in DB Sage context
  ↓
Returns to SuperAgentes orchestrator
```

```
User: /SA *agent db-sage
  ↓
SuperAgentes transforms into DB Sage
  ↓
User is now fully in DB Sage context
  ↓
All commands execute as DB Sage
  ↓
User: *exit → Back to SuperAgentes
```

## 🔧 Configuration

### Slash Prefix

The slash prefix is configured in `config.yaml`:

```yaml
slashPrefix: SA
```

Use `/SA` to activate SuperAgentes.

### Agent Routing

Prefix patterns are defined in each agent's YAML config:

```yaml
routing:
  patterns:
    db_sage:
      prefixes: ['db:', 'database:', 'sql:', 'supabase:', 'pg:', 'postgres:']
      keywords: ['schema', 'migration', 'rls', 'policy', 'query', 'database']
    design_system:
      prefixes: ['ds:', 'design:', 'component:', 'ui:', 'build:', 'audit:', 'token:']
      keywords: ['audit', 'pattern', 'redundancy', 'consolidate', 'token', 'roi', 'component', 'design', 'build', 'setup', 'document']
```

## 📚 Documentation

### DB Sage Documentation

Complete DB Sage documentation is preserved in its original location:
- Architecture: `docs/architecture/db-sage/`
- Implementation Guide: `docs/architecture/db-sage/DB-SAGE-IMPLEMENTATION-GUIDE.md`
- Schema Comparison: `docs/architecture/db-sage/SCHEMA-COMPARISON-SQLITE-SUPABASE.md`

### SuperAgentes Documentation

- This README: Quick start and usage patterns
- `config.yaml`: Configuration and metadata
- Agent files: Complete agent definitions with all commands

## 🛠️ Integration with AIOS

SuperAgentes integrates seamlessly with AIOS-FULLSTACK:

1. **Slash Commands**: Use `/SA` in any AIOS context
2. **Agent Discovery**: Listed in `*agent` command from AIOS Orchestrator
3. **Shared Resources**: Uses AIOS task/template/checklist patterns
4. **Security**: Inherits AIOS security rules and practices

## 💻 IDE Integration

SuperAgentes is available in multiple development environments:

### Claude Code (.claude/)

Located in `.claude/commands/SA/`:
- **Activation**: `/SA`
- **Agents**: `super-agentes.md`, `db-sage.md`, `design-system.md`
- **Tasks**: 23 task files (all db-sage operations)
- **Discovery**: Automatically discovered by Claude Code
- **Usage**: `/SA` → `*help` → `*db:comando`

### Cursor (.cursor/)

Located in `.cursor/rules/`:
- **Activation**: `@SA`, `@db-sage`, or `@design-system`
- **Files**: `super-agentes.mdc`, `db-sage.mdc`, `design-system.mdc`
- **Format**: Cursor MDC format with frontmatter
- **Discovery**: Automatically discovered by Cursor
- **Usage**: `@SA` → `*help` → `*db:comando`

### Direct Access (expansion-packs/)

Located in `expansion-packs/super-agentes/`:
- **Structure**: Full expansion pack with all resources
- **Agents**: In `agents/` directory
- **Tasks**: In `tasks/` directory (23 tasks)
- **Templates**: In `templates/` directory (12 templates)
- **Docs**: Complete documentation and guides
- **Usage**: Import or reference directly in custom tooling

### File Synchronization

The expansion pack follows a **copy-to-IDE** pattern:
- **Source of Truth**: `expansion-packs/super-agentes/`
- **Claude Code**: Copies to `.claude/commands/SA/`
- **Cursor**: Copies to `.cursor/rules/` (with `.mdc` extension)
- **Updates**: Modify source, then re-copy to IDEs

## 🔐 Security

SuperAgentes inherits security from its specialist agents:

- Never exposes database credentials
- Redacts sensitive information automatically
- Validates all inputs before execution
- Uses transactions for multi-statement operations
- Requires explicit confirmation for destructive operations
- Rate limits command execution

## 🎓 Learning Path

1. **Start Here**: `/SA` then `*help`
2. **Explore DB Sage**: `*db:help` to see all database commands
3. **Try Quick Command**: `*db:env-check` to validate environment
4. **Learn Transformation**: `*agent db-sage` for full immersion
5. **Real Workflow**: Follow DB-SAGE-IMPLEMENTATION-GUIDE.md for complete workflow

## 📈 Roadmap

### Current (v2.0.0)
- ✅ Meta-orchestrator implementation
- ✅ DB Sage integration (v1.1.0 - complete)
- ✅ Design System integration (v2.0.0 - complete)
- ✅ Prefix routing system (db:, ds:)
- ✅ Agent transformation
- ✅ Unified help system
- ✅ 3 YAML workflow orchestrations (brownfield, greenfield, audit-only)

### Future (v2.1.0+)
- 🔄 Cross-agent workflows (Design System + DB Sage)
- 🔄 Design-to-database workflows (UI components with database backing)
- 🔄 Component library versioning and publishing
- 🔄 Automated visual regression testing
- 🔄 Figma token import integration

## 🤝 Contributing

To extend SuperAgentes:

1. Add new tasks to `tasks/`
2. Add new templates to `templates/`
3. Update agent definitions in `agents/`
4. Update this README
5. Update `config.yaml` version

## 📄 License

Part of AIOS-FULLSTACK framework.

## 🙏 Acknowledgments

- DB Sage: Built on battle-tested database engineering practices
- AIOS Orchestrator: Inspired the meta-agent architecture
- AIOS Community: Framework and patterns

---

**Need help?** Run `*help` after activating with `/SA`
**Report issues:** AIOS-FULLSTACK issue tracker
**Status:** v2.0.0 - Production ready (DB Sage + Design System complete)
