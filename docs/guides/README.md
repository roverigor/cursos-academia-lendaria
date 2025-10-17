# User & Developer Guides

**Purpose:** Practical guides for using and developing with AIOS

---

## 📁 Contents

### System Guides
- **[folder-structure.md](./folder-structure.md)** - Complete directory structure guide
  - Project organization
  - File naming conventions
  - Where to put new files

- **[outputs-guide.md](./outputs-guide.md)** - Outputs specification
  - What goes in `outputs/` vs `docs/`
  - Generated content structure
  - Output standards by stage

- **[integration-etl-mmos.md](./integration-etl-mmos.md)** - ETL/MMOS Integration
  - Data pipeline integration
  - Collection workflows
  - Processing stages

### MMOS-Specific Guides
- **[mmos-stage-guides/](./mmos-stage-guides/)** - Stage-by-stage MMOS guides
  - Collection stage
  - Analysis stage
  - Synthesis stage
  - Implementation stage
  - Validation stage

---

## 📚 Guide Categories

### 🎓 User Guides
Guides for **end users** of AIOS tools:
- How to activate clones
- How to generate courses
- How to use workflows
- How to interpret outputs

### 👨‍💻 Developer Guides
Guides for **developers** building with AIOS:
- System architecture
- Integration patterns
- Adding new features
- Testing and validation

### 🔧 Operations Guides
Guides for **maintaining** the system:
- Database management
- Deployment procedures
- Monitoring and logs
- Troubleshooting

---

## 📚 Related Documentation

- **Workflows:** `docs/mmos/workflows/` - Detailed workflow steps
- **Methodology:** `docs/methodology/` - Process frameworks
- **Architecture:** `docs/architecture/` - System design
- **Stories:** `docs/stories/` - Development tasks

---

## 🎯 How to Use

### Finding the Right Guide

**"Where do I put this file?"**
→ Read `folder-structure.md`

**"How do outputs work?"**
→ Read `outputs-guide.md`

**"How do I integrate ETL with MMOS?"**
→ Read `integration-etl-mmos.md`

**"How does Stage 3 Analysis work?"**
→ Check `mmos-stage-guides/`

---

## ✍️ Writing Guides

When adding new guides:
1. **Start with the user's question** - What problem does this solve?
2. **Provide step-by-step instructions** - Make it actionable
3. **Include examples** - Show, don't just tell
4. **Add troubleshooting** - Address common issues
5. **Link related docs** - Connect to workflows and architecture

### Template Structure
```markdown
# Guide Title

## Overview
- What this guide covers
- Who should read it
- Prerequisites

## Step-by-Step Instructions
1. First step
2. Second step
3. Third step

## Examples
Concrete examples of usage

## Troubleshooting
Common issues and solutions

## Related Documentation
Links to related guides/docs
```

---

**Created:** 2025-10-17
**Reorganized from:** `docs/mmos/docs/`
