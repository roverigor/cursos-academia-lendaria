# ⚡ SuperAgentes Expansion Pack

**Version:** 1.0.0
**Command:** `/SA`
**Type:** Meta-Orchestrator

SuperAgentes is a unified orchestrator expansion pack that provides seamless access to specialized database and design system capabilities through intelligent command routing and agent transformation.

## 🎯 Overview

SuperAgentes consolidates two powerful specialized agents into a single, cohesive interface:

1. **DB Sage** (🗄️) - Database Architect & Operations Engineer
2. **Design System** (🎨) - Design System Architect & Pattern Engineer *(placeholder)*

Instead of switching between different agents manually, SuperAgentes provides:
- **Prefix Routing**: Execute commands directly with `*db:comando` or `*ds:comando`
- **Agent Transformation**: Transform into a specialist agent for extended work with `*agent db-sage`
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

# Design system (placeholder)
*ds:help                     # Show design system commands

# Agent transformation
*agent db-sage               # Transform into DB Sage for extended work
*agent design-system         # Transform into Design System
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

### Design System (Placeholder)

**Status:** 🚧 Planned
**Future Capabilities:**
- Design pattern scanning
- Component generation
- Design system documentation
- Design token management
- Style consistency validation

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

## 🗂️ Project Structure

```
expansion-packs/super-agentes/
├── agents/
│   ├── super-agentes.md    # Meta-orchestrator
│   ├── db-sage.md           # Database agent
│   └── design-system.md     # Design system agent (placeholder)
├── tasks/                   # 20+ database tasks
├── templates/               # 12+ database templates
├── checklists/              # Quality checklists
├── data/                    # Knowledge base
├── workflows/               # Future workflows
├── examples/                # Usage examples
├── config.yaml              # Expansion pack config
└── README.md                # This file
```

## 🎭 How It Works

SuperAgentes follows the **AIOS Orchestrator Pattern**:

1. **Meta-Agent Layer**: SuperAgentes orchestrator coordinates everything
2. **Specialist Agents**: DB Sage and Design System provide deep expertise
3. **Shared Resources**: All agents use the same tasks, templates, and checklists
4. **Smart Routing**: Commands with prefixes route automatically to the right context
5. **Transformation**: Use `*agent` command for full agent immersion

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
      prefixes: ['ds:', 'design:', 'component:', 'ui:', 'style:', 'theme:']
      keywords: ['component', 'design', 'pattern', 'style', 'theme']
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

### Current (v1.0.0)
- ✅ Meta-orchestrator implementation
- ✅ DB Sage integration (complete)
- ✅ Prefix routing system
- ✅ Agent transformation
- ✅ Unified help system

### Future (v1.1.0+)
- 🚧 Design System agent implementation
- 🚧 Cross-agent workflows
- 🚧 Design-to-database workflows
- 🚧 Component generation with database backing
- 🚧 Automated design system documentation

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
**Status:** Production ready for database operations, design system in development
