# Mente Lendária - Documentation

**Welcome to the Mente Lendária documentation hub.**

This directory contains all project documentation organized by category for easy navigation.

---

## 📁 Documentation Structure

### 🏗️ Architecture & System Design
- **[architecture/](./architecture/)** - System architecture and technical design
  - Brownfield architecture analysis
  - System design documents
  - Technical specifications

### 📋 Product Requirements
- **[prd/](./prd/)** - Product requirement documents
  - [MMOS PRD](./prd/mmos-prd.md) - Mind Mapper OS product vision
  - CreatorOS PRD (planned)
  - InnerLens PRD (planned)

### 🧠 Methodologies & Frameworks
- **[methodology/](./methodology/)** - Process frameworks and best practices
  - [DNA Mental](./methodology/dna-mental.md) - Cognitive profiling framework
  - [Prompt Engineering](./methodology/prompt-engineering.md) - AI prompt best practices
  - [Tools Guide](./methodology/tools-guide.md) - Development tools overview
  - [MMOS Templates](./methodology/mmos-templates/) - Document templates

### 📚 Guides
- **[guides/](./guides/)** - User and developer guides
  - [Folder Structure](./guides/folder-structure.md) - Project organization guide
  - [Outputs Guide](./guides/outputs-guide.md) - Generated content specifications
  - [ETL/MMOS Integration](./guides/integration-etl-mmos.md) - Data pipeline integration
  - [MMOS Stage Guides](./guides/mmos-stage-guides/) - Stage-by-stage process guides

### 📖 Development Stories
- **[stories/](./stories/)** - Development stories and tasks
  - Current active stories
  - [MMOS Legacy Stories](./stories/mmos-legacy/) - Historical MMOS stories

### 📝 Execution Logs
- **[logs/](./logs/)** - Process execution logs (versioned)
  - Refactoring session logs
  - Architecture decision records
  - Migration documentation
  - QA session reports

---

## 🧬 MMOS-Specific Documentation

The MMOS (Mind Mapper OS) system has its own dedicated documentation:

**[docs/mmos/](./mmos/)** - MMOS system documentation
- **[workflows/](./mmos/workflows/)** - Step-by-step workflow documentation
  - [AIOS Workflow](./mmos/workflows/aios-workflow.md) - Agent-based workflow
  - [Brownfield Workflow](./mmos/workflows/brownfield-workflow.md) - Legacy content migration
  - [Private Individual Workflow](./mmos/workflows/private-individual-simplified.md) - Greenfield process
  - [Workflow Decision Matrix](./mmos/workflows/workflow-matrix-decision.md) - Choosing the right workflow

- **[reports/](./mmos/reports/)** - Executive reports and analyses
- **[epics/](./mmos/epics/)** - MMOS development epics and roadmap
- **[stories/](./mmos/stories/)** - MMOS-specific development stories
- **[qa/](./mmos/qa/)** - Quality assurance and benchmarks
- **[taxonomy/](./mmos/taxonomy/)** - Trait and personality taxonomies
- **[validations/](./mmos/validations/)** - Validation checklists and reports

---

## 🎯 Quick Navigation

### For Product Managers
1. Start with **[PRDs](./prd/)** - Understand product vision
2. Review **[Architecture](./architecture/)** - System design
3. Check **[Stories](./stories/)** - Current development priorities

### For Developers
1. Read **[Guides](./guides/)** - Development guidelines
2. Study **[Methodology](./methodology/)** - Process frameworks
3. Follow **[Workflows](./mmos/workflows/)** - Step-by-step processes
4. Reference **[Architecture](./architecture/)** - Technical specs

### For Users
1. Check **[Guides](./guides/)** - User documentation
2. Review **[Workflows](./mmos/workflows/)** - How to use the system
3. Read **[PRDs](./prd/)** - Feature documentation

---

## 🔍 Finding What You Need

### "How do I...?"

**"How do I activate a clone?"**
→ See [MMOS Workflows](./mmos/workflows/)

**"How do I generate a course?"**
→ See [CreatorOS Documentation](../expansion-packs/creator-os/)

**"How does the MMOS pipeline work?"**
→ Read [AIOS Workflow](./mmos/workflows/aios-workflow.md)

**"Where do I put new files?"**
→ Check [Folder Structure Guide](./guides/folder-structure.md)

### "What is...?"

**"What is MMOS?"**
→ Read [MMOS PRD](./prd/mmos-prd.md)

**"What is DNA Mental methodology?"**
→ See [DNA Mental Guide](./methodology/dna-mental.md)

**"What's the difference between outputs/ and docs/?"**
→ Check [Outputs Guide](./guides/outputs-guide.md)

---

## 📊 Documentation by Type

### Process Documentation
- **Workflows:** [mmos/workflows/](./mmos/workflows/)
- **Methodologies:** [methodology/](./methodology/)
- **Guides:** [guides/](./guides/)

### Product Documentation
- **Requirements:** [prd/](./prd/)
- **Architecture:** [architecture/](./architecture/)
- **Epics:** [mmos/epics/](./mmos/epics/)

### Historical Documentation
- **Logs:** [logs/](./logs/)
- **Legacy Stories:** [stories/mmos-legacy/](./stories/mmos-legacy/)
- **Reports:** [mmos/reports/](./mmos/reports/)

---

## 🔧 Generated Artifacts

**Note:** Generated outputs are in `outputs/`, not `docs/`:

- **Generated courses:** [`../outputs/courses/`](../outputs/courses/)
- **Processed minds:** [`../outputs/minds/`](../outputs/minds/)
- **Database:** [`../outputs/database/`](../outputs/database/)

See [`outputs/README.md`](../outputs/README.md) for details.

---

## 📚 External Documentation

### Expansion Packs
- **[CreatorOS](../expansion-packs/creator-os/)** - Course generation system
- **[MMOS Mind Mapper](../expansion-packs/mmos/)** - Cognitive clone creation
- **[InnerLens](../expansion-packs/innerlens/)** - Psychometric profiling
- **[ETL Data Collector](../expansion-packs/etl-data-collector/)** - Data collection tools

### Framework Documentation
- **[AIOS Core](../.aios-core/)** - AI orchestration framework
- **[Claude Code Config](../.claude/CLAUDE.md)** - Development rules

---

## ✍️ Contributing to Documentation

### Adding New Documentation

1. **Choose the right category:**
   - Product vision → `prd/`
   - Process/methodology → `methodology/`
   - User/dev guide → `guides/`
   - Architecture → `architecture/`
   - Workflow → `mmos/workflows/`

2. **Follow naming conventions:**
   - Use kebab-case: `my-document.md`
   - Be descriptive: `brownfield-migration-workflow.md`
   - Avoid abbreviations: `product-requirements.md` not `pr.md`

3. **Update navigation:**
   - Add link to category README
   - Update this master README if major addition

### Documentation Standards

- **Start with overview** - What, why, when
- **Use clear headings** - H2 for sections, H3 for subsections
- **Include examples** - Show, don't just tell
- **Link related docs** - Cross-reference relevant documents
- **Keep it current** - Update as system evolves

---

## 📈 Recent Changes

See [logs/](./logs/) for detailed session logs:

- **2025-10-17:** docs/ reorganization - extracted mmos/docs/ to root categories
- **2025-10-17:** outputs/ migration - separated generated content from docs
- **2025-10-16:** Brownfield architecture analysis

---

## 🆘 Getting Help

- **Technical questions:** Check [guides/](./guides/)
- **Process questions:** See [methodology/](./methodology/)
- **Product questions:** Read [prd/](./prd/)
- **Can't find it:** Search logs in [logs/](./logs/)

---

**Last Updated:** 2025-10-17
**Structure Version:** 2.0 (Post-reorganization)
**Maintainer:** Mente Lendária Team
