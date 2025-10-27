# 🏗️ Architecture Documentation

Central repository for all system architecture documentation.

## 📂 Structure

### General Architecture
- System-wide architecture and design decisions
- Cross-cutting concerns and patterns

### DB-Sage Architecture
Database-focused agent architecture and implementation:
- [`db-sage/`](db-sage/) - DB-Sage agent documentation
  - [`README.md`](db-sage/README.md) - DB-Sage overview and capabilities
  - [`DB-SAGE-IMPLEMENTATION-GUIDE.md`](db-sage/DB-SAGE-IMPLEMENTATION-GUIDE.md) - Implementation guide
  - [`SCHEMA-COMPARISON-SQLITE-SUPABASE.md`](db-sage/SCHEMA-COMPARISON-SQLITE-SUPABASE.md) - SQLite vs Supabase comparison

### MMOS Architecture (Prefix: `mmos-*`)
All MMOS-specific architecture documents:

**Core Systems:**
- [`mmos-aios-conversion.md`](mmos-aios-conversion.md) - AIOS conversion blueprint
- [`mmos-pipeline-v3.5.md`](mmos-pipeline-v3.5.md) - Pipeline architecture
- [`mmos-cognitive-profiling.md`](mmos-cognitive-profiling.md) - Cognitive profiling system
- [`mmos-launcher-spec.md`](mmos-launcher-spec.md) - Launcher specification

**Data Models:**
- [`mmos-clone-arena-schema.sql`](mmos-clone-arena-schema.sql) - Clone Arena database schema
- [`mmos-launcher-history-schema.yaml`](mmos-launcher-history-schema.yaml) - Launcher history data model
- [`mmos-prompts-mapping-schema.yaml`](mmos-prompts-mapping-schema.yaml) - Prompts mapping schema

**Taxonomies:**
- [`mmos-taxonomy-system.md`](mmos-taxonomy-system.md) - Taxonomy system overview
- [`mmos-specialization-taxonomy.md`](mmos-specialization-taxonomy.md) - Complete specialization taxonomy
- [`mmos-taxonomy-rationale.md`](mmos-taxonomy-rationale.md) - Design rationale

**Matrices & Mappings:**
- [`mmos-prompt-task-matrix.md`](mmos-prompt-task-matrix.md) - Prompt/Task/Artifact matrix

**Stories Technical Designs:**
- [`mmos-story-1.2-technical-design.md`](mmos-story-1.2-technical-design.md) - Orchestration Board (not implemented)
- [`mmos-story-1.3-technical-design.md`](mmos-story-1.3-technical-design.md) - Brownfield Assistant (not implemented)

## 🔗 Related Documentation

- [MMOS System Docs](../mmos/) - MMOS-specific workflows, epics, etc.
- [Logs](../logs/) - Historical documentation and execution logs
- [Stories](../stories/) - Development stories

## 📝 Notes

All MMOS architecture documents use the `mmos-` prefix for easy identification when browsing the consolidated architecture directory.
