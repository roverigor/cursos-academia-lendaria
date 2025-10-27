# Documentation Hub

**Mente Lendária project documentation organized by category.**

---

## Structure

### Product & Requirements
- **[prd/](./prd/)** - Product requirement documents
  - [MMOS PRD](./prd/mmos-prd.md) - Mind Mapper OS vision

### Methodologies & Frameworks
- **[methodology/](./methodology/)** - Process frameworks
  - [DNA Mental™](./methodology/dna-mental.md) - Cognitive profiling framework
  - [Prompt Engineering](./methodology/prompt-engineering.md) - AI prompts
  - [Tools Guide](./methodology/tools-guide.md) - Development tools

### Guides
- **[guides/](./guides/)** - User and developer guides
  - [Folder Structure](./guides/folder-structure.md) - Project organization
  - [Outputs Guide](./guides/outputs-guide.md) - Generated content specs
  - [ETL/MMOS Integration](./guides/integration-etl-mmos.md) - Data pipeline
  - [MMOS Stage Guides](./guides/mmos-stage-guides/) - Phase-by-phase

### Architecture
- **[architecture/](./architecture/)** - System architecture
  - Technical design documents
  - Architecture decisions
  - Tech stack specifications

### Development
- **[stories/](./stories/)** - Development stories
  - [MMOS Legacy](./stories/mmos-legacy/) - Historical stories
- **[logs/](./logs/)** - Execution logs (versioned documentation)
  - Session logs (YYYY-MM-DD-*.md)
  - Architecture decisions
  - Migration records

### Database
- **[database/](./database/)** - Database design docs

### Research
- **[research/](./research/)** - Research materials

---

## MMOS-Specific

**[mmos/](./mmos/)** - MMOS system documentation

### Key Directories
- **[workflows/](./mmos/workflows/)** - Step-by-step workflows
  - [Auto-Detection System](./mmos/workflows/auto-detection-system.md)
  - [Brownfield Workflow](./mmos/workflows/brownfield-workflow.md)
  - [Workflow Matrix](./mmos/workflows/workflow-matrix-decision.md)
- **[epics/](./mmos/epics/)** - MMOS development epics
- **[stories/](./mmos/stories/)** - MMOS-specific stories
- **[reports/](./mmos/reports/)** - Executive reports
- **[qa/](./mmos/qa/)** - Quality assurance
  - [benchmarks/](./mmos/qa/benchmarks/) - Cross-mind benchmarks
- **[taxonomy/](./mmos/taxonomy/)** - Trait taxonomies

### Important Notes

**Validation docs** belong in mind-specific locations:
- ✅ `outputs/minds/{slug}/docs/validation-checklist.md`
- ❌ NOT in `docs/mmos/validations/`

See [Folder Structure Guide](./guides/folder-structure.md) for full rules.

---

## Quick Navigation

### For Product Managers
1. [PRDs](./prd/) - Product vision
2. [Architecture](./architecture/) - System design
3. [Stories](./stories/) - Development priorities

### For Developers
1. [Guides](./guides/) - Development guidelines
2. [Methodology](./methodology/) - Process frameworks
3. [Architecture](./architecture/) - Technical specs
4. [.claude/CLAUDE.md](../.claude/CLAUDE.md) - Claude Code config

### For Users
1. [Guides](./guides/) - User documentation
2. [Workflows](./mmos/workflows/) - How to use
3. [PRDs](./prd/) - Feature documentation

---

## Common Questions

**"How do I map a mind?"**
→ `*map {name}` - See [MMOS Workflows](./mmos/workflows/)

**"Where do files go?"**
→ [Folder Structure Guide](./guides/folder-structure.md)

**"What's the difference between outputs/ and docs/?"**
→ [Outputs Guide](./guides/outputs-guide.md)

**"What is MMOS?"**
→ [MMOS PRD](./prd/mmos-prd.md)

**"What is DNA Mental™?"**
→ [DNA Mental Guide](./methodology/dna-mental.md)

---

## Generated Artifacts

**Note:** Generated outputs are in `outputs/`, not `docs/`:

- **Cognitive clones:** [`../outputs/minds/`](../outputs/minds/)
- **Courses:** [`../outputs/courses/`](../outputs/courses/)
- **Database:** [`../outputs/database/`](../outputs/database/)

See [`../outputs/README.md`](../outputs/README.md) for details.

---

## Expansion Packs

External documentation for modular extensions:

- **[MMOS](../expansion-packs/mmos/)** - Cognitive clone creation
- **[CreatorOS](../expansion-packs/creator-os/)** - Course generation
- **[InnerLens](../expansion-packs/innerlens/)** - Psychometric profiling
- **[ETL Collector](../expansion-packs/etl-data-collector/)** - Data collection
- **[Super Agentes](../expansion-packs/super-agentes/)** - Advanced orchestration
- **[Fragments](../expansion-packs/fragments/)** - Knowledge extraction

---

## Framework

- **[AIOS Core](../.aios-core/)** - AI orchestration framework
- **[Claude Code Config](../.claude/CLAUDE.md)** - Development rules

---

## Contributing to Docs

### 1. Choose Category

- Product vision → `prd/`
- Process/methodology → `methodology/`
- User/dev guide → `guides/`
- Architecture → `architecture/`
- Workflow → `mmos/workflows/`
- Execution log → `logs/`

### 2. Naming Conventions

- Use kebab-case: `my-document.md`
- Be descriptive: `brownfield-migration-workflow.md`
- Avoid abbreviations

### 3. Update Navigation

- Add link to category README
- Update this master README if major addition

---

## Documentation Standards

- **Start with overview** - What, why, when
- **Use clear headings** - H2 for sections, H3 for subsections
- **Include examples** - Show, don't just tell
- **Link related docs** - Cross-reference
- **Keep current** - Update as system evolves

---

## Recent Changes

See [logs/](./logs/) for detailed session logs.

**Major reorganizations:**
- **2025-10-27:** README.md simplified, removed outdated references
- **2025-10-17:** docs/ reorganization - extracted mmos/docs/
- **2025-10-17:** outputs/ migration - separated generated content

---

**Last Updated:** 2025-10-27
**Maintainer:** Mente Lendária Team
