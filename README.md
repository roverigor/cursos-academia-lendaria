# Mente Lendária - Mind Mapper OS (MMOS)

> **AI-orchestrated cognitive cloning platform**

Create production-ready AI personality clones with authentic cognitive patterns, communication styles, and decision-making frameworks.

**Command:** `*map {name}` → 6-phase pipeline → cognitive clone

---

## What It Does

**MMOS (Mind Mapper OS)** creates AI clones of individuals by:

1. **Mapping Cognitive Architecture** - Extract thinking patterns, communication style, decision frameworks
2. **Generating System Prompts** - Create production-ready prompts that replicate personality
3. **Achieving 94% Fidelity** - Validated through debate-engine testing
4. **Auto-Detection** - Greenfield/Brownfield + Public/No-Public workflows

**Current Status:**
- Check minds: `ls outputs/minds/ | wc -l`
- Check courses: `ls outputs/courses/ | wc -l`
- Database version: `psql "$SUPABASE_DB_URL" -c "SELECT version FROM migrations ORDER BY applied_at DESC LIMIT 1"`

---

## Quick Start

### Prerequisites

- **Python 3.8+** and pip
- **Node.js 18+** and npm
- **PostgreSQL client** (psql)
- Git repository access
- API keys configured (see `.env.example`)

### Installation

```bash
# 1. Clone repository
git clone https://github.com/oalanicolas/mmos.git
cd mente_lendaria

# 2. Install dependencies
npm install                 # Node.js dependencies
pip install -r requirements.txt  # Python dependencies (if needed)

# 3. Configure environment
cp .env.example .env
# Edit .env with your API keys:
#   ANTHROPIC_API_KEY
#   GOOGLE_API_KEY
#   SUPABASE_DB_URL
#   etc.

# 4. Verify setup
npm test                    # Run test suite
```

---

## Core Commands

### Mind Mapping (MMOS)

```bash
# Auto-detect workflow and create cognitive clone
*map {name}                 # Full 6-phase pipeline

# Examples:
*map daniel_kahneman        # Public figure (web scraping)
*map pedro_valerio          # Private person (materials-based)

# Entry point: expansion-packs/mmos/lib/map_mind.py
```

### Database Operations

```bash
# Set environment
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export SUPABASE_DB_URL="postgresql://..."

# Run migration
./scripts/db-migrate.sh supabase/migrations/{file}.sql

# Rollback
./scripts/db-rollback.sh supabase/migrations/{file}.sql

# Test database
./scripts/db-test.sh
```

### Testing & Validation

```bash
npm test                    # Jest test suite
npm run test:watch         # Watch mode
npm run test:coverage      # Coverage report
npm run validate:minds     # Validate minds
npm run validate:sources   # Validate sources
npm run validate:all       # All validations
```

### Data Pipeline

```bash
node scripts/pipeline/import-analysis.js
node scripts/pipeline/validate-integration.js
node scripts/pipeline/populate-sources.js
```

---

## Project Structure

```
mente_lendaria/
├── .aios-core/             # AI orchestration framework
│   ├── agents/             # Agent definitions
│   ├── tasks/              # Executable tasks
│   ├── templates/          # Document templates
│   ├── checklists/         # Quality gates
│   └── workflows/          # Multi-step automation
│
├── expansion-packs/        # Modular extensions
│   ├── mmos/               # Mind Mapper OS (cognitive cloning)
│   ├── creator-os/         # Course generation
│   ├── etl-data-collector/ # Data collection
│   ├── innerlens/          # Psychometric profiling
│   ├── super-agentes/      # Advanced orchestration
│   └── fragments/          # Knowledge extraction
│
├── docs/                   # Documentation (versioned)
│   ├── README.md           # Documentation hub
│   ├── prd/                # Product requirements
│   ├── methodology/        # Frameworks (DNA Mental™)
│   ├── guides/             # User/developer guides
│   ├── architecture/       # System architecture
│   ├── stories/            # Development stories
│   ├── logs/               # Execution logs
│   └── mmos/               # MMOS-specific docs
│
├── outputs/                # Generated artifacts (NOT versioned)
│   ├── minds/              # Cognitive clones (51+)
│   ├── courses/            # Generated courses (17+)
│   ├── database/           # SQLite database
│   ├── debates/            # Debate outputs
│   └── swipe/              # Swipe files
│
├── supabase/               # Database infrastructure
│   ├── migrations/         # Database migrations
│   ├── schemas/            # Schema snapshots
│   ├── rollback/           # Rollback scripts
│   └── tests/              # Migration tests
│
├── scripts/                # Automation utilities
│   ├── db-migrate.sh       # Migration runner
│   ├── db-rollback.sh      # Rollback executor
│   ├── db-test.sh          # Testing runner
│   ├── database/           # Database utilities
│   ├── pipeline/           # Data processing
│   └── migration/          # Data migration
│
├── package.json            # Node.js config (v3.0.0)
├── .env                    # API keys (NOT versioned)
└── README.md               # This file
```

**Full structure:** See `docs/guides/folder-structure.md`

---

## MMOS Pipeline (6 Phases)

```
Phase 1: Viability Assessment
         ↓ APEX + ICP scoring (GO/NO-GO)
Phase 2: Research Collection
         ↓ Parallel ETL (web scraping + materials)
Phase 3: Cognitive Analysis
         ↓ DNA Mental™ 8-layer analysis
Phase 4: Synthesis
         ↓ Framework extraction + personality modeling
Phase 5: Implementation
         ↓ System prompt generation (generalista + specialists)
Phase 6: Testing
         ↓ Debate-engine validation (94% fidelity target)
```

**Output:** `outputs/minds/{mind_slug}/`

**Workflow variants:**
- Greenfield (new clone) vs Brownfield (update)
- Public (web-scraped) vs No-Public (user-provided)
- Auto-detection via workflow detector

---

## Documentation

### Essential Guides

- **[Documentation Hub](docs/README.md)** - Master navigation
- **[MMOS PRD](docs/prd/mmos-prd.md)** - Product vision
- **[DNA Mental™](docs/methodology/dna-mental.md)** - Cognitive framework
- **[Folder Structure](docs/guides/folder-structure.md)** - Organization guide
- **[Outputs Guide](docs/guides/outputs-guide.md)** - Generated artifacts specs

### MMOS Workflows

- **[Brownfield Workflow](docs/mmos/workflows/brownfield-workflow.md)** - Update existing clones
- **[Auto-Detection System](docs/mmos/workflows/auto-detection-system.md)** - Workflow routing
- **[Workflow Matrix](docs/mmos/workflows/workflow-matrix-decision.md)** - Decision guide

### For Developers

- **[Architecture](docs/architecture/)** - System design
- **[Tech Stack](docs/architecture/tech-stack.md)** - Technologies used
- **[Coding Standards](docs/architecture/coding-standards.md)** - Code conventions
- **[.claude/CLAUDE.md](.claude/CLAUDE.md)** - Claude Code configuration

---

## Technology Stack

### Languages
- **Python 3** - MMOS pipeline, CreatorOS, utilities
- **JavaScript/Node.js** - ETL collector, database scripts
- **Bash** - Database automation, migrations
- **YAML** - Workflows, templates, configs
- **SQL** - Database schemas, migrations

### Core Technologies

| Component | Technology |
|-----------|-----------|
| **Database** | SQLite + Supabase PostgreSQL |
| **LLM APIs** | Anthropic Claude, Google Gemini |
| **Search** | Brave Search, Exa AI |
| **Web Scraping** | RSS Parser, Domino, HTMLParser2 |
| **Testing** | Jest, Python unittest |
| **Orchestration** | AIOS Framework |

### Key Dependencies

```json
{
  "dependencies": {
    "better-sqlite3": "^11.7.0",
    "js-yaml": "^4.1.0",
    "uuid": "^11.0.3"
  },
  "devDependencies": {
    "jest": "^29.7.0"
  }
}
```

---

## Development

### Story-Driven Development

1. Work from stories in `docs/stories/`
2. Mark checkboxes: `[ ]` → `[x]`
3. Maintain File List section
4. Follow acceptance criteria exactly

### Git Conventions

```bash
# Conventional commits
feat: add feature [Story X.Y]
fix: correct bug
docs: update documentation
chore: maintenance
```

### Testing

```bash
npm test                   # Run all tests
npm run test:watch        # Watch mode
npm run validate:all      # Validate minds + sources
./scripts/db-test.sh      # Database tests
```

---

## Expansion Packs

| Pack | Purpose | Entry Point |
|------|---------|-------------|
| **mmos** | Cognitive cloning | `expansion-packs/mmos/lib/map_mind.py` |
| **creator-os** | Course generation | `expansion-packs/creator-os/lib/brief_parser.py` |
| **etl-data-collector** | Data collection | `expansion-packs/etl-data-collector/run-collection.js` |
| **innerlens** | Psychometric profiling | `expansion-packs/innerlens/` |
| **super-agentes** | Advanced orchestration | `expansion-packs/super-agentes/` |
| **fragments** | Knowledge extraction | `expansion-packs/fragments/` |

Each pack has its own `config.yaml` and documentation.

---

## File Organization Rules

### CRITICAL: outputs/ vs docs/

**Decision Tree:**

1. **"Is this about a SPECIFIC mind (name in content)?"**
   - **YES** → `outputs/minds/{mind_slug}/docs/`
   - **NO** → Continue...

2. **"Is it a script/template for MMOS?"**
   - **YES** → `expansion-packs/mmos/`
   - **NO** → Continue...

3. **"Is it about MMOS system/process?"**
   - **YES** → `docs/mmos/`
   - **NO** → Continue...

4. **"Is it a methodology/framework?"**
   - **YES** → `docs/methodology/`
   - **NO** → See `docs/guides/folder-structure.md`

**Examples:**
- ✅ `outputs/minds/joao_lozano/docs/validation.md` (mind-specific)
- ✅ `docs/mmos/workflows/brownfield.md` (system workflow)
- ✅ `docs/methodology/dna-mental.md` (framework)
- ❌ `docs/mmos/joao-lozano/` (mind dirs belong in outputs/)

---

## Ethics & Transparency

### Our Commitments

- **Clear Identification** - AI minds always identified as AI
- **Amplification, not Replacement** - Augment human capabilities
- **Total Transparency** - Methodology and processes documented
- **Privacy** - Rigorous respect for data and privacy
- **Open Source** - Framework and methodology publicly available

### What We DON'T Do

- **Deceptive Impersonation** - Never pass AI as real person
- **Deepfakes or Manipulation** - No deceptive or manipulative content
- **Harmful Content** - Block malicious or harmful use
- **Privacy Violation** - Absolute respect for individual rights
- **Unauthorized Commercialization** - Ethical and legal use only

---

## Support

### Resources

- **GitHub Issues:** [Report bugs or request features](https://github.com/oalanicolas/mmos/issues)
- **Documentation:** [docs/README.md](docs/README.md)
- **AIOS Community:** [Discord](https://discord.gg/gk8jAdXWmj)

### Contact

- **Website:** lendario.ai
- **Email:** alan@academialendaria.ai

---

## Contributing

1. Fork the project
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'feat: add amazing feature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### Areas for Contribution

- 🧠 New cognitive clones
- 📝 Improved prompts
- 🛠️ Scripts and automation
- 📚 Documentation
- 🐛 Bug fixes

---

## License

© 2025 Academia Lendária - All rights reserved

---

## Team

**Developed by Academia Lendária**

- **Alan Nicolas** - Founder & Chief Architect

---

## Acknowledgments

- **AIOS-FULLSTACK Team** - Orchestration framework
- **Open Source Community** - Contributions and feedback
- **Mapped Personalities** - Inspiration and shared knowledge

---

<div align="center">

**Developed with 🧠 and AI by Academia Lendária**

*"Democratizing access to humanity's most brilliant minds"*

</div>
