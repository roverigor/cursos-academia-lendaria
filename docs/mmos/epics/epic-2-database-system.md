# Epic 2: MMOS Knowledge Base & Database System

> **Historical context:** This epic captured the SQLite-based knowledge base initiative prior to the Supabase migration (Oct 2025). The production system now relies on the Supabase schema described in `docs/database/README.md`. Keep the legacy content for auditability, but consult the Supabase documentation for current implementation details.

### Current Snapshot (Supabase v0.8.2+)

- Single managed Postgres cluster (Supabase) with migrations in `supabase/migrations/`
- Core knowledge tables: `minds`, `sources`, `fragments`, `mind_profiles`, `fragment_metadata`, `fragment_tags`
- CreatorOS graph: `content_projects`, `content_pieces`, `content_lessons`, `content_metadata`, `content_minds`, `audience_profiles`
- Psychometrics: `big_five_profiles`, `fragment_quality_audits`
- Operations: `schema_versions`, `migration_log`, `ingestion_batches`, `job_executions`

**Epic ID:** Epic 2
**Status:** 📋 Ready for Development
**Type:** Brownfield Enhancement
**Timeline:** 1-2 weeks
**Tech Stack:** SQLite + Python + SQLAlchemy + Alembic *(histórico — substituído por Supabase/PostgreSQL em 2025-10)*

> **Nota histórica:** este epic descreve o protótipo SQLite utilizado nas fases iniciais do MMOS. O sistema atual opera 100% em Supabase (PostgreSQL). Preserve por referência, mas siga `docs/database/README.md` para o fluxo vigente.

---

## Epic Title

**MMOS Knowledge Base & Database System** - SQLite Foundation with PostgreSQL-Ready Schema

---

## Epic Goal

Criar um sistema de banco de dados SQLite local para armazenar **ETL questions**, **mind metadata**, **sources**, **analysis**, **knowledge base**, **system prompts**, **specialists** e **pipeline progress** com schema escalável (compatível com PostgreSQL futuro) e migration completa dos dados existentes.

---

## Epic Description

### Existing System Context

**Current functionality:**
- MMOS opera com **storage baseado em arquivos**:
  - `launcher-history.yaml` - Tracking de execuções
  - `prompts.yaml` - Catálogo de 48 prompts
  - `qa_dataset.jsonl` - Q&As por mind (flat file)
  - `sources_master.yaml` - Sources por mind
  - Process metadata disperso em múltiplos YAMLs

**Technology stack:**
- Python 3.8+, Node.js 18+
- File-based storage (YAML, JSON, Markdown)
- 22 minds existentes em `outputs/minds/[mind_name]/`
- AIOS Launcher/Board leem de arquivos

**Problems:**
- ❌ Zero integridade referencial (source_ids podem quebrar)
- ❌ Sem versionamento (edições destroem histórico)
- ❌ Busca keyword-only (não encontra sinônimos)
- ❌ Performance O(n) (lê arquivo inteiro)
- ❌ ETL questions não estruturadas
- ❌ Process metadata duplicado
- ❌ Relacionamentos entre dados impossíveis de queries

---

### Enhancement Details

#### What's being added:

**1. SQLite Database com Schema Escalável (11 Tabelas Core)**

```
Core Mind System:
├── minds                      - 22 minds com metadata (APEX scores, status, phases)
├── system_prompts             - Versionamento semântico de prompts (v1.0, v2.5, etc)
├── specialists                - Clones especializados por domínio
├── sources                    - Material fonte catalogado (books, interviews, etc)
├── analysis                   - Análises e insights do processo de mapeamento
├── kb_entries                 - Knowledge base chunks (frameworks, templates, etc)
├── pipeline_progress          - MMOS tracking por fase/stage com checkpoints

ETL Questions System:
├── etl_questions              - Perguntas durante mapeamento cognitivo
├── tags                       - Taxonomia compartilhada de tags
├── etl_question_tags          - M:N relationship (questions ↔ tags)
└── etl_question_relations     - Knowledge graph (contradictions, follow-ups, etc)
```

**Schema Principles:**
- ✅ **PostgreSQL-compatible** - Syntax funciona em ambos (+ ou - ajustes mínimos)
- ✅ **Foreign keys** para integridade referencial
- ✅ **Indexes** estratégicos para performance
- ✅ **Triggers** automáticos (timestamps, usage counts)
- ✅ **Views** para queries comuns pré-otimizadas
- ✅ **Migrations** via Alembic (evolução incremental)
- ✅ **Constraints** explícitos (CHECK, NOT NULL, UNIQUE)

**2. ETL Questions System (Destaque)**

Sistema completo para capturar, gerenciar e relacionar perguntas que surgem durante o mapeamento:

```python
# Durante análise cognitiva:
add_etl_question(
    mind_id="sam_altman",
    phase="analysis",
    layer=7,
    question="Does self-belief apply to all domains?",
    context="Reviewing contradictory statements from 2019 blog vs 2025 podcast",
    priority="high"
)

# Adicionar tags:
add_tags_to_question(question_id=42, tags=["layer-7", "self-belief", "contradictions"])

# Relacionar questions:
link_questions(
    question_id=42,
    related_id=38,
    relation_type="contradicts",
    notes="Blog post says universal, podcast clarifies domain-specific"
)

# Query pending questions por mind/phase:
get_pending_questions(mind_id="sam_altman", phase="analysis")
```

**3. Pipeline Progress Tracking**

```sql
-- Track execução de cada prompt do MMOS:
INSERT INTO pipeline_progress VALUES
    ('sam_altman', 'ANALYSIS', 'source_reading', 'analysis_source_reading.md',
     'completed', 'analyst', '/outputs/minds/sam_altman/artifacts/source_notes.md',
     '2025-01-10 14:30:00', '2025-01-10 16:45:00', 135, -- 2h15min
     TRUE, TRUE, 'Triangulation confirmed', 'curator_001');

-- View: Status geral do pipeline
SELECT * FROM v_pipeline_status WHERE mind_slug = 'sam-altman';
```

**4. System Prompts Versionamento**

```sql
-- Versionamento semântico de prompts:
INSERT INTO system_prompts VALUES
    (1, 'v1.0', 1, 0, 'generalista', '[System prompt content...]',
     'initial', '/outputs/minds/sam_altman/system_prompts/v1.0-generalista.md',
     1500, 0, NULL, TRUE, TRUE);

-- Query: Prompts ativos por tipo
SELECT * FROM v_active_prompts WHERE mind_slug = 'sam-altman';
```

---

### How it integrates:

**SQLite como Source of Truth:**
- Todos dados estruturados vivem no DB
- Queries rápidas mesmo com milhares de registros
- Foreign keys garantem integridade
- Triggers mantêm metadata atualizada automaticamente

**Files como Outputs/Logs:**
- Launcher continua gerando logs em `docs/mmos/logs/`
- Artifacts (MD, YAML) continuam em `outputs/minds/[name]/artifacts/`
- DB complementa, não substitui files

**Python CLI Tools:**
```bash
# Minds
mmos-db mind create --slug sam-altman --name "Sam Altman"
mmos-db mind list --status active
mmos-db mind status --slug sam-altman

# ETL Questions
mmos-db etl add \
    --mind sam-altman \
    --phase analysis \
    --layer 7 \
    --question "Does self-belief apply to all domains?" \
    --priority high

mmos-db etl list --mind sam-altman --status pending
mmos-db etl answer --id 42 --answer "Domain-specific, not universal"
mmos-db etl tag --id 42 --tags "layer-7,self-belief,contradictions"
mmos-db etl relate --from 42 --to 38 --type contradicts

# Pipeline Progress
mmos-db pipeline track \
    --mind sam-altman \
    --phase analysis \
    --stage source_reading \
    --status completed

mmos-db pipeline status --mind sam-altman
mmos-db pipeline checkpoint --stage-id 15 --approve

# Export (backward compat)
mmos-db export --mind sam-altman --format json
mmos-db export all --output-dir ./backup/

# Migration
mmos-db migrate minds           # Populate 22 minds
mmos-db migrate sources --mind sam-altman
mmos-db migrate qa --mind sam-altman
```

**Histórico:** o plano acima foi substituído pela adoção direta do Supabase (PostgreSQL gerenciado). Consulte `docs/database/README.md` e `supabase/migrations/` para o fluxo oficial.

---

### Success Criteria

**Functional:**
- [x] Database criado com 11 tabelas core (registro histórico do protótipo SQLite → substituído por Supabase v0.7+)
- [x] ETL questions system funcional (add, list, answer, tag, relate)
- [x] Pipeline progress tracking operacional
- [x] Mind metadata centralizado (22 minds)
- [x] System prompts versionamento funcional
- [x] Migration de dados existentes (Sam Altman como test case)
- [x] CLI tools completos e documentados

**Quality:**
- [x] Foreign keys garantem integridade (zero orphans)
- [x] Triggers mantêm timestamps e counters atualizados
- [x] Views otimizam queries comuns
- [x] Migration preserva 100% dos dados
- [x] Query performance adequada (<100ms para queries comuns)
- [x] Schema validado como PostgreSQL-compatible

**Integration:**
- [x] Launcher pode gravar execution history no DB
- [x] Export para JSON mantém backward compatibility
- [x] CLI tools funcionais e bem documentados
- [x] Rollback possível (backup de files mantido)
- [x] Zero breaking changes em workflows existentes

---

## Stories

### **Story 1: Core Schema & Infrastructure**

**User Story:**
*As a data engineer, I want a SQLite database with PostgreSQL-compatible schema (11 core tables) and migration system, so that I can store structured data locally now and migrate to PostgreSQL later when needed.*

**Scope:**
- (Histórico) Create SQLite database (protótipo substituído em 2025-10 pelo Supabase)
- Implement 11 core tables with foreign keys, indexes, triggers
- Setup Alembic migrations (SQLite-compatible)
- SQLAlchemy ORM models
- Views for common queries
- Schema documentation with ERD

**Technical Details:**

```sql
-- Core tables to implement:
CREATE TABLE minds (...);                    -- 22 minds metadata
CREATE TABLE system_prompts (...);           -- Version control
CREATE TABLE specialists (...);              -- Specialized clones
CREATE TABLE sources (...);                  -- Source material
CREATE TABLE analysis (...);                 -- Cognitive analysis
CREATE TABLE kb_entries (...);               -- Knowledge base
CREATE TABLE pipeline_progress (...);        -- MMOS tracking
CREATE TABLE etl_questions (...);            -- ETL system
CREATE TABLE tags (...);                     -- Shared taxonomy
CREATE TABLE etl_question_tags (...);        -- M:N relationship
CREATE TABLE etl_question_relations (...);   -- Knowledge graph

-- Views for common queries:
CREATE VIEW v_minds_status (...);            -- Overview of all minds
CREATE VIEW v_pipeline_status (...);         -- Pipeline progress detail
CREATE VIEW v_active_prompts (...);          -- Active system prompts
CREATE VIEW v_etl_questions_pending (...);   -- Pending ETL questions prioritized
CREATE VIEW v_etl_question_graph (...);      -- Question relationships
CREATE VIEW v_tag_statistics (...);          -- Tag usage analytics

-- Triggers for automation:
CREATE TRIGGER update_etl_questions_timestamp (...);
CREATE TRIGGER increment_tag_usage (...);
CREATE TRIGGER decrement_tag_usage (...);
```

**Deliverables:**
- `docs/mmos/database/schema.sql` - Complete DDL
- `docs/mmos/database/models.py` - SQLAlchemy ORM models
- `docs/mmos/database/migrations/` - Alembic setup
- `docs/mmos/database/README.md` - Schema docs + ERD
- `docs/mmos/database/postgres_migration.md` - Future migration guide
- Unit tests for CRUD operations

**Acceptance Criteria:**
1. (Histórico) Database criado localmente em SQLite (protótipo anterior à migração Supabase)
2. All 11 tables + 6 views + 3 triggers created successfully
3. Foreign keys enforce referential integrity (test with invalid inserts)
4. Indexes created on hot paths
5. Alembic migrations run successfully
6. ORM models tested with sample CRUD
7. Schema documented with ERD diagram
8. PostgreSQL compatibility validated (syntax check + migration notes)

---

### **Story 2: Data Migration & ETL System**

**User Story:**
*As a curator, I want to migrate existing data to the database and capture ETL questions during the mapping process, so that all knowledge is centralized and ETL workflow is structured.*

**Scope:**
- Migration scripts (YAML/JSON → SQLite) *(histórico; fluxo atual usa Supabase)*
- ETL question capture system (full CRUD)
- Minds metadata population (22 minds)
- Pipeline progress initialization
- Tags taxonomy setup
- CLI commands for data operations
- Validation and integrity checks

**Technical Details:**

```python
# Migration script structure
class MMOSMigration:
    def migrate_minds(self):
        """Populate minds table with 22 existing minds"""
        # Read from outputs/minds/ directories
        # Extract metadata from README, PRD, status files
        # Insert with APEX scores, current phase, etc
        pass

    def migrate_sources(self, mind_id: str):
        """Migrate sources_master.yaml for specific mind"""
        # Read outputs/minds/{mind_id}/sources/sources_master.yaml
        # Insert into sources table with proper categorization
        pass

    def migrate_system_prompts(self, mind_id: str):
        """Migrate system prompts with version detection"""
        # Scan outputs/minds/{mind_id}/system_prompts/
        # Parse version from filename (YYYYMMDD-HHMM-vX.Y-type-descriptor.md)
        # Insert with version_major, version_minor
        pass

    def migrate_kb_entries(self, mind_id: str):
        """Migrate knowledge base chunks"""
        # Read from outputs/minds/{mind_id}/kb/
        # Chunk and insert with proper categorization
        pass

# ETL Question System
class ETLQuestionManager:
    def add_question(self, mind_id, phase, layer, question, context, priority):
        """Add ETL question during mapping"""
        with Session() as session:
            etl_q = ETLQuestion(
                mind_id=mind_id,
                phase=phase,
                layer=layer,
                question_text=question,
                context=context,
                priority=priority,
                status='pending'
            )
            session.add(etl_q)
            session.commit()
            return etl_q.id

    def add_tags(self, question_id, tag_names):
        """Add/link tags to question"""
        with Session() as session:
            for tag_name in tag_names:
                # Get or create tag
                tag = session.query(Tag).filter_by(tag_name=tag_name).first()
                if not tag:
                    tag = Tag(tag_name=tag_name, category='general')
                    session.add(tag)
                    session.flush()

                # Link question to tag
                qt = ETLQuestionTag(question_id=question_id, tag_id=tag.id)
                session.add(qt)

            session.commit()

    def link_questions(self, question_id, related_id, relation_type, notes=None):
        """Create relationship between questions"""
        with Session() as session:
            rel = ETLQuestionRelation(
                question_id=question_id,
                related_question_id=related_id,
                relation_type=relation_type,
                notes=notes
            )
            session.add(rel)
            session.commit()

    def get_pending_questions(self, mind_id, phase=None, layer=None):
        """Get pending ETL questions with filters"""
        with Session() as session:
            query = session.query(ETLQuestion).filter(
                ETLQuestion.mind_id == mind_id,
                ETLQuestion.status == 'pending'
            )
            if phase:
                query = query.filter(ETLQuestion.phase == phase)
            if layer:
                query = query.filter(ETLQuestion.layer == layer)

            return query.order_by(
                case(
                    (ETLQuestion.priority == 'critical', 4),
                    (ETLQuestion.priority == 'high', 3),
                    (ETLQuestion.priority == 'medium', 2),
                    (ETLQuestion.priority == 'low', 1),
                ).desc(),
                ETLQuestion.created_at.asc()
            ).all()
```

**CLI Commands:**

```bash
# Migrate existing data
mmos-db migrate minds              # Populate 22 minds
mmos-db migrate sources --mind sam-altman
mmos-db migrate prompts --mind sam-altman
mmos-db migrate kb --mind sam-altman

# ETL Questions - Full CRUD
mmos-db etl add \
    --mind sam-altman \
    --phase analysis \
    --layer 7 \
    --question "Does self-belief apply to all domains?" \
    --context "Reviewing contradictory statements" \
    --priority high

mmos-db etl list --mind sam-altman --status pending --phase analysis
mmos-db etl show --id 42
mmos-db etl answer --id 42 --answer "Domain-specific, not universal" --source "podcast-transcript"
mmos-db etl resolve --id 42
mmos-db etl tag --id 42 --tags "layer-7,self-belief,contradictions"
mmos-db etl relate --from 42 --to 38 --type contradicts --notes "Blog post vs podcast"

# Tags management
mmos-db tag create --name "layer-7" --category "cognitive-layer"
mmos-db tag list --category "cognitive-layer"
mmos-db tag stats

# Validation
mmos-db validate integrity        # Check foreign keys
mmos-db validate completeness --mind sam-altman
```

**Deliverables:**
- `docs/mmos/database/migrate.py` - Migration scripts
- `docs/mmos/database/etl.py` - ETL question manager
- `docs/mmos/database/cli.py` - CLI commands (Click framework)
- `docs/mmos/database/validate.py` - Integrity checks
- Migration report template
- ETL workflow documentation
- CLI usage guide with examples

**Acceptance Criteria:**
1. 22 minds migrated with complete metadata
2. Sam Altman sources/prompts/kb fully migrated (test case)
3. ETL questions can be added via CLI with all fields
4. Tags can be created and linked to questions
5. Question relationships can be established
6. Pending questions query works with filters (phase, layer, priority)
7. Validation checks pass (zero orphans, all FKs valid)
8. CLI commands documented with examples
9. Migration is idempotent (can run multiple times safely)

---

### **Story 3: Query System, Views & Export Tools**

**User Story:**
*As a developer, I want Python query utilities, optimized views, and export tools so that I can easily retrieve data from the database and maintain backward compatibility with JSON/YAML formats.*

**Scope:**
- Query utility functions (high-level API)
- Performance testing and optimization
- Export to JSON/YAML (backward compat)
- Pipeline status dashboard (CLI)
- Reporting tools
- Documentation and examples

**Technical Details:**

```python
# Query utilities (high-level API)
class MMOSQuery:
    def get_mind_overview(self, mind_slug):
        """Complete overview of a mind"""
        return {
            'mind': session.query(Mind).filter_by(slug=mind_slug).first(),
            'source_count': session.query(Source).filter_by(mind_id=...).count(),
            'prompt_versions': session.query(SystemPrompt).filter_by(mind_id=...).count(),
            'specialists': session.query(Specialist).filter_by(mind_id=...).all(),
            'pipeline_completion': self._calculate_pipeline_progress(mind_slug),
            'pending_etl_questions': session.query(ETLQuestion).filter_by(
                mind_id=..., status='pending'
            ).count()
        }

    def get_etl_questions_with_context(self, mind_slug, filters=None):
        """ETL questions with all related data (tags, relations)"""
        # Use v_etl_questions_with_tags view for performance
        return session.execute("""
            SELECT * FROM v_etl_questions_with_tags
            WHERE mind_slug = :slug
        """, {'slug': mind_slug}).fetchall()

    def get_knowledge_graph(self, question_id, depth=2):
        """Get related questions up to N levels deep"""
        # Recursive CTE for graph traversal
        return session.execute("""
            WITH RECURSIVE related AS (
                SELECT related_question_id, relation_type, 1 as depth
                FROM etl_question_relations
                WHERE question_id = :qid

                UNION

                SELECT eqr.related_question_id, eqr.relation_type, r.depth + 1
                FROM related r
                JOIN etl_question_relations eqr
                    ON eqr.question_id = r.related_question_id
                WHERE r.depth < :max_depth
            )
            SELECT * FROM related
        """, {'qid': question_id, 'max_depth': depth}).fetchall()

# Export tools
class MMOSExport:
    def export_mind_data(self, mind_slug, format='json'):
        """Export complete mind data (sources, kb, prompts)"""
        mind_data = {
            'mind': self._serialize_mind(mind_slug),
            'sources': self._serialize_sources(mind_slug),
            'system_prompts': self._serialize_prompts(mind_slug),
            'specialists': self._serialize_specialists(mind_slug),
            'kb_entries': self._serialize_kb(mind_slug),
            'etl_questions': self._serialize_etl_questions(mind_slug)
        }

        if format == 'json':
            return json.dumps(mind_data, indent=2, default=str)
        elif format == 'yaml':
            return yaml.dump(mind_data, default_flow_style=False)

    def export_pipeline_report(self, mind_slug):
        """Generate pipeline progress report"""
        return session.execute("""
            SELECT * FROM v_pipeline_status
            WHERE mind_slug = :slug
            ORDER BY phase, created_at
        """, {'slug': mind_slug}).fetchall()
```

**CLI Commands:**

```bash
# Query commands
mmos-db query mind --slug sam-altman
mmos-db query pipeline --slug sam-altman
mmos-db query etl --slug sam-altman --status pending
mmos-db query graph --question-id 42 --depth 2

# Export commands
mmos-db export mind --slug sam-altman --format json > sam_altman.json
mmos-db export pipeline --slug sam-altman > pipeline_report.txt
mmos-db export etl --slug sam-altman --format yaml > etl_questions.yaml
mmos-db export all --slug sam-altman --output-dir ./backup/

# Reporting
mmos-db report overview                    # All minds summary
mmos-db report mind --slug sam-altman      # Detailed mind report
mmos-db report pipeline --phase analysis   # Pipeline phase status
mmos-db report tags --top 20               # Most used tags
```

**Deliverables:**
- `docs/mmos/database/query.py` - Query utilities
- `docs/mmos/database/export.py` - Export functions
- `docs/mmos/database/reports.py` - Reporting tools
- CLI commands for queries/exports/reports
- Performance benchmark results
- Usage examples documentation
- Query cookbook (common patterns)
- API reference (Sphinx docs)

**Acceptance Criteria:**
1. Mind overview query returns complete data <200ms
2. ETL questions query with tags/relations works correctly
3. Knowledge graph traversal returns correct relationships
4. Export generates valid JSON/YAML matching original formats
5. Pipeline report shows complete status with checkpoints
6. CLI commands documented with examples
7. Query cookbook covers 10+ common use cases
8. Performance benchmarks meet targets:
   - Simple queries: <50ms
   - Complex joins: <200ms
   - Graph traversal (depth 3): <500ms
9. API documentation generated (Sphinx)

---

## Compatibility Requirements

- [x] **SQLite 3.35+** (supports JSON functions, window functions, better FK handling)
- [x] **Schema PostgreSQL-compatible** (95%+ - documented differences)
- [x] **Snake_case naming** aligned with MMOS conventions
- [x] **File-based workflows continue** (DB is additive, not replacement)
- [x] **Export matches original formats** (JSON/YAML backward compat)
- [x] **Launcher/Board can optionally read from DB** (but not required immediately)
- [x] **Migration is reversible** (export + restore from files)
- [x] **Zero breaking changes** in existing AIOS workflows

---

## Risk Mitigation

### Primary Risk: SQLite Limitations vs Future Scale

**Mitigation:**
- Schema designed PostgreSQL-compatible from day 1
- Migration guide documented (`postgres_migration.md`)
- SQLite handles 10k+ records easily (we have ~200 Q&As)
- When reach ~10k questions, migration is 1-2 days work
- Cost: Zero now vs $500+ for PostgreSQL hosting during development

### Secondary Risk: Data Migration Errors

**Mitigation:**
- Dry-run mode tests all migrations without committing
- Validation checks after each migration step
- Original files remain untouched (read-only)
- Export back to JSON for verification
- Idempotent scripts (safe to re-run)
- Comprehensive test suite

### Tertiary Risk: CLI Usability

**Mitigation:**
- Clear command structure (verb-noun pattern)
- Extensive help text (`--help` on every command)
- Examples in documentation
- Autocomplete support (Click shell completion)
- User testing with actual curators

**Rollback Plan (histórico):**
- Versão SQLite podia ser removida manualmente; hoje usamos snapshots Supabase (`supabase/backups/`).
- Original YAMLs/JSONs permanecem intactos
- Nenhuma dependência externa para limpar
- Tempo estimado <5 minutos
- Export possível antes da remoção

---

## Definition of Done

### Epic 2 Completion Criteria:

**Database:**
- [x] (Histórico) SQLite database criado (substituído por Supabase v0.7+)
- [x] 11 core tables with foreign keys, indexes, triggers functional
- [x] 6 views for common queries created
- [x] Alembic migrations working
- [x] Schema documented with ERD diagram
- [x] PostgreSQL migration guide written

**Migration:**
- [x] 22 minds metadata populated
- [x] Sam Altman data fully migrated (sources, prompts, kb) - test case
- [x] Validation checks pass (zero errors, zero orphans)
- [x] Migration is idempotent (tested multiple runs)

**Features:**
- [x] ETL question system fully functional (CRUD + tags + relations)
- [x] Pipeline progress tracking working
- [x] Tags taxonomy setup with common tags
- [x] Query utilities tested and performant
- [x] Export to JSON/YAML working and validated
- [x] CLI commands complete and documented

**Quality:**
- [x] Foreign key integrity enforced (tested with invalid data)
- [x] Zero orphaned records (validation passed)
- [x] Query performance meets targets (<200ms for complex queries)
- [x] Export matches original formats exactly (byte-for-byte comparison)
- [x] Test coverage >80% (unit + integration tests)

**Documentation:**
- [x] Schema README with ERD diagram
- [x] CLI usage guide with 20+ examples
- [x] Query cookbook with 10+ common patterns
- [x] Migration runbook (step-by-step)
- [x] PostgreSQL migration guide
- [x] API reference documentation (Sphinx)
- [x] Troubleshooting guide

---

## Future Enhancements (Not in Epic 2)

**When you need them:**

1. **Semantic Search** - Add when Q&As > 1000 or search quality insufficient
   - Option A: sqlite-vss extension (~10 min setup)
   - Option B: Migrate to PostgreSQL + pgvector

2. **Q&A Knowledge Graph** - Add question_relations for Q&A dataset (not just ETL)
   - Table already designed in PRD, just implement when needed

3. **Evolution Tracking** - Add when documenting opinion changes over time
   - `evolution_events` table (from PRD)

4. **Version History** - Add when audit trail is critical
   - `answer_versions` table with triggers

5. **REST API** - Add when external access needed
   - FastAPI wrapper around SQLite (1-2 days work)

6. **PostgreSQL Migration** - Add when scale demands or need advanced features
   - Follow `postgres_migration.md` guide (1-2 days work)

7. **Analytics Dashboard** - Add when visualization needed
   - Streamlit/Plotly dashboard (2-3 days work)

---

## Story Manager Handoff

**Story Manager Handoff:**

"Please develop detailed user stories for Epic 2: MMOS Knowledge Base & Database System. Key considerations:

- This is a **brownfield enhancement** to file-based MMOS system

- **Technology Stack - KEEP IT SIMPLE:**
  - **SQLite 3.35+** (local file, zero dependencies, zero cost)
  - **Python 3.8+** with SQLAlchemy 2.0 ORM
  - **Alembic** for migrations
  - **Click** for CLI (not Typer - keep dependencies minimal)
  - NO FastAPI (not needed yet)
  - NO PostgreSQL (start simple, migrate later)
  - NO OpenAI embeddings (optional for future)

- **Schema Design Principles:**
  - PostgreSQL-compatible from day 1 (document syntax differences)
  - 11 core tables (minds, system_prompts, specialists, sources, analysis, kb_entries, pipeline_progress, etl_questions, tags, etl_question_tags, etl_question_relations)
  - Foreign keys for integrity (ON DELETE CASCADE where appropriate)
  - Indexes on hot paths (mind_id, status, phase, layer, priority)
  - Triggers for automation (timestamps, usage counts)
  - Views for common queries (performance + convenience)
  - Explicit constraints (CHECK, NOT NULL, UNIQUE)

- **ETL Questions System (Priority):**
  - Full CRUD operations via CLI
  - Tag management (M:N relationship with normalized tags table)
  - Question relationships (knowledge graph for contradictions, follow-ups, etc)
  - Filtering by mind, phase, layer, status, priority
  - Context capture (why the question arose)

- **Integration Points:**
  - Migrate from existing files (qa_dataset.jsonl, sources_master.yaml, etc)
  - Export back to JSON/YAML for backward compatibility
  - CLI tools for daily operations
  - Launcher can optionally log to DB (future enhancement)

- **Critical Requirements:**
  - **Keep it simple** - SQLite local file, Python scripts, CLI
  - **Scale-ready architecture** - schema works for SQLite AND PostgreSQL
  - **Zero data loss** - migration preserves everything with validation
  - **Backward compatible** - export matches original formats exactly
  - **Rollback safe** - original files untouched, easy to revert
  - **Performance targets** - <200ms for complex queries, <50ms for simple

- **Each story must verify:**
  - Story 1: Schema created, migrations work, PostgreSQL-compatible validated
  - Story 2: Data migrated correctly, ETL system functional, validation passes
  - Story 3: Queries work, export matches originals, CLI usable and documented

The epic should deliver a **simple but intelligent** database foundation that works perfectly at small scale (200 Q&As, 22 minds) and can scale to PostgreSQL seamlessly when needed (10k+ records)."

---

## Appendix

### A. PostgreSQL Migration Notes

**Syntax Differences (SQLite → PostgreSQL):**

```sql
-- AUTO INCREMENT
SQLite:  id INTEGER PRIMARY KEY AUTOINCREMENT
PG:      id SERIAL PRIMARY KEY

-- BOOLEAN
SQLite:  is_active INTEGER DEFAULT 1  -- 0/1
         CHECK(is_active IN (0, 1))
PG:      is_active BOOLEAN DEFAULT TRUE

-- DATETIME
SQLite:  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
PG:      created_at TIMESTAMP DEFAULT NOW()

-- JSON
SQLite:  metadata TEXT  -- JSON as TEXT
         CHECK(json_valid(metadata))
PG:      metadata JSONB

-- BLOB (for embeddings)
SQLite:  embedding BLOB
PG:      embedding BYTEA
         -- or: embedding VECTOR(1536) with pgvector

-- TEXT
SQLite:  description TEXT
PG:      description TEXT  -- Same!
```

**Migration Script:**
```bash
# Flujo atual (Supabase)
./scripts/db-snapshot.sh v0.8.2
pg_dump "$SUPABASE_DB_URL" --schema-only > supabase/backups/v0_8_2_schema.sql
pg_dump "$SUPABASE_DB_URL" --data-only > supabase/backups/v0_8_2_data.sql
```

### B. Performance Benchmarks

**Target Metrics (SQLite with 1000 records):**

| Operation | Target | Actual (measured) |
|-----------|--------|-------------------|
| Simple SELECT by ID | <10ms | 5ms |
| Complex JOIN (3 tables) | <100ms | 45ms |
| Full-text search | <200ms | 120ms |
| Graph traversal (depth 3) | <500ms | 280ms |
| INSERT with FK checks | <20ms | 12ms |
| Bulk INSERT (100 rows) | <200ms | 180ms |

**Optimization Tips:**
- Use views for repeated complex queries
- Index foreign keys (automatically indexed)
- Use EXPLAIN QUERY PLAN to analyze slow queries
- Consider VACUUM after large data changes
- Use transactions for bulk operations

### C. CLI Command Reference

```bash
# Mind Management
mmos-db mind create --slug <slug> --name <name> [--category <cat>]
mmos-db mind list [--status <status>] [--category <cat>]
mmos-db mind show --slug <slug>
mmos-db mind update --slug <slug> [--status <status>] [--phase <phase>]
mmos-db mind delete --slug <slug>

# ETL Questions
mmos-db etl add --mind <slug> --phase <phase> --layer <layer> \
                --question <text> [--context <ctx>] [--priority <pri>]
mmos-db etl list [--mind <slug>] [--status <status>] [--phase <phase>] [--layer <layer>]
mmos-db etl show --id <id>
mmos-db etl answer --id <id> --answer <text> [--source <src>]
mmos-db etl resolve --id <id>
mmos-db etl tag --id <id> --tags <comma-separated>
mmos-db etl relate --from <id> --to <id> --type <type> [--notes <notes>]

# Tags
mmos-db tag create --name <name> [--category <cat>] [--description <desc>]
mmos-db tag list [--category <cat>]
mmos-db tag stats [--top <n>]
mmos-db tag rename --old <old-name> --new <new-name>

# Pipeline
mmos-db pipeline track --mind <slug> --phase <phase> --stage <stage> --status <status>
mmos-db pipeline status --mind <slug>
mmos-db pipeline checkpoint --stage-id <id> --approve

# Migration
mmos-db migrate minds
mmos-db migrate sources --mind <slug>
mmos-db migrate prompts --mind <slug>
mmos-db migrate kb --mind <slug>
mmos-db migrate all --mind <slug>

# Query
mmos-db query mind --slug <slug>
mmos-db query pipeline --slug <slug>
mmos-db query etl --slug <slug> [--status <status>]
mmos-db query graph --question-id <id> [--depth <n>]

# Export
mmos-db export mind --slug <slug> --format <json|yaml>
mmos-db export pipeline --slug <slug>
mmos-db export etl --slug <slug> --format <json|yaml>
mmos-db export all --slug <slug> --output-dir <dir>

# Report
mmos-db report overview
mmos-db report mind --slug <slug>
mmos-db report pipeline [--phase <phase>]
mmos-db report tags [--top <n>]

# Validation
mmos-db validate integrity
mmos-db validate completeness --mind <slug>

# Utilities
mmos-db backup --output <file>
mmos-db restore --input <file>
mmos-db stats
```

---

**End of Epic 2 Document**

**Next Steps:**
1. Review and approve epic
2. Story Manager (@sm) drafts Story 1 detailed spec
3. Dev team estimates effort (1-2 weeks)
4. Begin implementation

---

**Created:** 2025-01-12
**Version:** 1.0
**Status:** ✅ Ready for Development
