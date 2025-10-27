# Expansion Pack Documentation

**Individual documentation for each expansion pack**

---

## Purpose

This directory contains **high-level documentation** for each expansion pack:
- Purpose and capabilities
- Key features
- Integration points
- Usage examples
- Status and roadmap

**Note:** Detailed documentation lives in each pack's directory. This is for **cross-reference** and **system-level view**.

---

## Pack Index

### Production Ready

| Pack | Purpose | Primary Output | Doc |
|------|---------|----------------|-----|
| **MMOS** | Cognitive clone creation | `outputs/minds/` | [mmos.md](./mmos.md) |
| **CreatorOS** | Content generation with voice | `outputs/courses/` | [creator-os.md](./creator-os.md) |
| **InnerLens** | Personality analysis (Big Five) | YAML profiles | [innerlens.md](./innerlens.md) |
| **ETL Data Collector** | Multi-source data collection | `downloads/` | [etl.md](./etl.md) |
| **SuperAgentes** | DB + Design System orchestration | Database + UI | [super-agentes.md](./super-agentes.md) |

### In Development

| Pack | Purpose | Status | Doc |
|------|---------|--------|-----|
| **Fragments** | Fragment processing (TBD) | 🚧 Research | [fragments.md](./fragments.md) |
| **etl (variant)** | ETL tools variant? | ⚠️ Unclear | (needs clarification) |

---

## Pack Documentation Template

Each pack doc should follow this structure:

```markdown
# [Pack Name]

**Version:** vX.X.X
**Status:** Production | In Development | Deprecated
**Location:** `expansion-packs/{pack-name}/`

---

## Purpose

[What problem does this pack solve?]

## Key Features

- Feature 1
- Feature 2
- Feature 3

## Integration Points

### Consumes From

| Pack | Interface | Data |
|------|-----------|------|
| [Pack] | [Contract] | [What data] |

### Provides To

| Pack | Interface | Data |
|------|-----------|------|
| [Pack] | [Contract] | [What data] |

## Quick Start

```bash
# Basic usage example
@agent-name
*command-name
```

## Directory Structure

```
expansion-packs/[pack-name]/
├── agents/
├── tasks/
├── templates/
└── README.md
```

## Database Tables

| Table | Purpose | Schema |
|-------|---------|--------|
| [table] | [purpose] | [key columns] |

## Configuration

[Key config files and settings]

## Usage Examples

### Example 1: [Common Use Case]

[Step-by-step usage]

## Status & Roadmap

**Current Version:** vX.X.X

**Recent Changes:**
- [Change 1]

**Upcoming:**
- [Feature 1]

## Resources

- **Detailed README:** [expansion-packs/[pack]/README.md](../../expansion-packs/[pack]/README.md)
- **Source Code:** `expansion-packs/[pack]/`
- **Tests:** `expansion-packs/[pack]/tests/`
```

---

## Cross-Reference

For **detailed documentation**, see:
- **Individual pack READMEs:** `expansion-packs/{pack}/README.md`
- **Pack-specific docs:** `expansion-packs/{pack}/docs/`
- **Integration guides:** `docs/expansion-packs/guides/`

---

**See also:**
- [System Architecture](../architecture.md)
- [Dependency Graph](../dependency-graph.md)
- [Workflows](../workflows.md)
