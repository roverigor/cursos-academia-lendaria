# MMOS Workflows

**Purpose:** Step-by-step workflow documentation for MMOS processes

---

## 📁 Contents

### Core Workflows

#### AIOS Integration
- **[aios-workflow.md](./aios-workflow.md)** - AIOS-first workflow
  - Agent-based interaction model
  - Conversational methodology
  - Human-in-the-loop checkpoints

#### Brownfield Migration
- **[brownfield-workflow.md](./brownfield-workflow.md)** - Standard brownfield process
  - For existing documented minds
  - Legacy content integration
  - Quality validation

- **[brownfield-migration-workflow.md](./brownfield-migration-workflow.md)** - Detailed migration workflow
  - Step-by-step migration guide
  - Data transformation
  - Validation and testing

#### Workflow Decision Support
- **[workflow-matrix-decision.md](./workflow-matrix-decision.md)** - Workflow selection guide
  - When to use each workflow
  - Decision criteria
  - Workflow comparison

### Private Individual Workflows
- **[private-individual-workflow-proposal.md](./private-individual-workflow-proposal.md)** - Original proposal
  - Full workflow specification
  - Detailed process steps
  - Requirements and constraints

- **[private-individual-simplified.md](./private-individual-simplified.md)** - Simplified version
  - Streamlined process
  - Essential steps only
  - Quick reference

### Parallel Processing
- **[parallel-collection-guide.md](./parallel-collection-guide.md)** - Parallel data collection
  - Multi-source collection
  - Concurrent processing
  - Efficiency patterns

---

## 🎯 Workflow Types

### 1. **Greenfield Workflows**
For creating **new minds from scratch**:
- Interview-based collection
- Real-time synthesis
- Iterative validation

### 2. **Brownfield Workflows**
For migrating **existing documented minds**:
- Legacy content ingestion
- Structure transformation
- Quality preservation

### 3. **Hybrid Workflows**
For **partially documented minds**:
- Combine existing materials with interviews
- Fill gaps in documentation
- Enhance with new insights

---

## 📚 Related Documentation

- **Methodology:** `docs/methodology/` - Core frameworks
- **Guides:** `docs/guides/` - Practical guides
- **Architecture:** `docs/architecture/` - System design
- **PRD:** `docs/prd/mmos-prd.md` - Product vision

---

## 🎯 How to Choose a Workflow

### Decision Tree

**Is this a new mind (no existing materials)?**
→ YES: Use **Greenfield workflow** (Private Individual)
→ NO: Continue...

**Do you have comprehensive existing materials?**
→ YES: Use **Brownfield workflow**
→ NO: Continue...

**Do you have partial materials + can do interviews?**
→ YES: Use **Hybrid workflow**
→ NO: Read `workflow-matrix-decision.md` for guidance

---

## 🔄 Workflow Execution

### Standard Process
1. **Select workflow** - Use decision tree above
2. **Read workflow doc** - Understand all steps
3. **Gather prerequisites** - Materials, access, etc.
4. **Execute workflow** - Follow step-by-step
5. **Validate output** - Check quality standards
6. **Document learnings** - Update workflow if needed

### Using AIOS Agents
- Use `@mmos-mapper` for MMOS workflows
- Follow conversational methodology
- Provide context at checkpoints
- Validate outputs before proceeding

---

## ✍️ Workflow Documentation Standards

When documenting workflows:
1. **Clear prerequisites** - What's needed to start
2. **Sequential steps** - Numbered, actionable steps
3. **Decision points** - When to branch or adjust
4. **Validation criteria** - How to check success
5. **Example outputs** - Show expected results
6. **Troubleshooting** - Common issues and fixes

### Template Structure
```markdown
# Workflow Name

## Overview
- Purpose
- When to use
- Expected duration

## Prerequisites
- Required materials
- Tools needed
- Access requirements

## Steps
1. Step 1
2. Step 2
3. Step 3

## Validation
How to verify success

## Examples
Real-world usage

## Troubleshooting
Common issues
```

---

**Created:** 2025-10-17
**Reorganized from:** `docs/mmos/docs/`
