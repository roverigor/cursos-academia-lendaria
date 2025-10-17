# Architecture Documentation

**Purpose:** System architecture, technical design, and architectural decision records

---

## 📁 Contents

### Architecture Analysis
- **[docs-reorganization-2025-10-17.md](./docs-reorganization-2025-10-17.md)** - Documentation reorganization analysis
  - Current state assessment
  - Problems identified
  - Migration plan and execution
  - Post-migration structure

### Brownfield Analysis
- Analysis of existing system and technical debt
- Migration strategies
- Refactoring plans

### System Design
- Overall system architecture
- Component relationships
- Data flow diagrams
- Integration patterns

---

## 📚 Architecture Categories

### 1. **System Architecture**
High-level system design:
- Overall architecture
- Component architecture
- Module boundaries
- Integration points

### 2. **Data Architecture**
Data design and management:
- Database schema
- Data models
- Data flow
- Storage strategies

### 3. **Technical Debt**
Brownfield analysis and refactoring:
- Technical debt inventory
- Refactoring priorities
- Migration strategies
- Cleanup plans

### 4. **Decision Records**
Architectural decisions:
- Technology choices
- Design patterns
- Trade-offs considered
- Rationale documentation

---

## 📚 Related Documentation

- **PRDs:** `docs/prd/` - Product requirements
- **Guides:** `docs/guides/` - Implementation guides
- **MMOS Architecture:** `docs/mmos/architecture/` - MMOS-specific design
- **Logs:** `docs/logs/` - Architecture session logs

---

## 🎯 How to Use

### For Architects
1. **Start with system overview** - Understand overall design
2. **Review component architecture** - Deep dive into modules
3. **Check decision records** - Understand why decisions were made
4. **Assess technical debt** - Know what needs improvement

### For Developers
1. **Read system architecture** - Understand the big picture
2. **Study relevant components** - Deep dive into your area
3. **Follow design patterns** - Maintain consistency
4. **Reference guides** - Implementation details

### For Product Managers
1. **Understand system capabilities** - What can the system do?
2. **Review constraints** - What are the limitations?
3. **Check decision records** - Why certain choices were made
4. **Assess technical debt** - What needs refactoring?

---

## ✍️ Documentation Standards

### Architecture Document Template

```markdown
# [Component/System Name] Architecture

**Version:** X.Y
**Date:** YYYY-MM-DD
**Author:** Name
**Status:** [Draft/Review/Approved]

---

## Overview
Brief description of the component/system

## Context
Why does this exist? What problem does it solve?

## Architecture Diagram
[Diagram or ASCII art]

## Components
Detailed description of components

## Data Flow
How data moves through the system

## Design Decisions
Key decisions and rationale

## Trade-offs
What was considered, what was chosen, why

## Future Considerations
What might change in the future

---

**Related Docs:** Links to related architecture docs
```

### Architecture Decision Record (ADR) Template

```markdown
# ADR-NNN: [Decision Title]

**Date:** YYYY-MM-DD
**Status:** [Proposed/Accepted/Deprecated/Superseded]
**Deciders:** Names
**Technical Story:** [Link to story/issue]

---

## Context
What is the issue we're facing?

## Decision
What have we decided?

## Rationale
Why did we decide this?

## Consequences
What are the implications (positive and negative)?

## Alternatives Considered
What other options did we evaluate?

---

**Supersedes:** [Link to superseded ADR, if applicable]
**Superseded by:** [Link to superseding ADR, if applicable]
```

---

## 📊 Architecture Views

### 1. **Logical View** (What)
- Components and their responsibilities
- Interfaces and contracts
- Dependencies

### 2. **Process View** (How)
- Runtime behavior
- Concurrency and synchronization
- Performance and scalability

### 3. **Development View** (Who)
- Code organization
- Module structure
- Build and deployment

### 4. **Physical View** (Where)
- Infrastructure
- Deployment topology
- Hardware/cloud resources

---

## 🔍 Finding Architecture Docs

### By System
```bash
# Find all architecture docs for MMOS
ls docs/mmos/architecture/

# Find all general architecture docs
ls docs/architecture/
```

### By Topic
```bash
# Find database architecture docs
grep -r "database" docs/architecture/ docs/mmos/architecture/

# Find API architecture docs
grep -r "API" docs/architecture/ docs/mmos/architecture/
```

---

## 🎯 Best Practices

### Keep Architecture Docs Current
- ✅ Update when major changes happen
- ✅ Review quarterly for accuracy
- ✅ Deprecate outdated docs
- ❌ Don't let docs go stale

### Make Diagrams Clear
- ✅ Use standard notation (UML, C4, etc.)
- ✅ Include legends and keys
- ✅ Keep diagrams focused (one concept per diagram)
- ❌ Don't create overly complex diagrams

### Document Decisions
- ✅ Explain the "why", not just the "what"
- ✅ Include alternatives considered
- ✅ Note trade-offs
- ❌ Don't just describe implementation

---

**Created:** 2025-10-17
**Location:** `docs/architecture/`
**Versioned:** Yes (committed to git)
