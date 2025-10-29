# CreatorOS Database Architecture Proposal

**Date:** 2025-10-27
**Version:** 1.0.0
**Status:** Pending Decision
**Author:** DB Sage (KISS Gate Validated)

---

## Executive Summary

**Problem:** CreatorOS operates single-user only (filesystem-based). Team cannot collaborate on course creation/editing. System doesn't scale beyond one person on one machine.

**Validated Pain Points:**
1. Team blocked - cannot view/edit courses
2. No multi-user support
3. No centralized access (machine-dependent)
4. No SQL queries for course management

**Proposed Solution:** Database-first architecture with 4 modular tables storing all course content (lessons, metadata, research) in Supabase with RLS for multi-user collaboration.

**Scope:** Migrate all content from `outputs/courses/{slug}/` to database.

**Effort:** 6-8 hours (migration + Python integration + RLS + testing)

**Impact:** Enables team collaboration, SQL queries, scalability beyond single machine.

---

## Table of Contents

1. [Current State (Filesystem)](#current-state-filesystem)
2. [Proposed State (Database-First)](#proposed-state-database-first)
3. [Schema Design (Modular)](#schema-design-modular)
4. [Entity-Relationship Diagram](#entity-relationship-diagram)
5. [Migration Strategy](#migration-strategy)
6. [Python Integration Impact](#python-integration-impact)
7. [RLS Policies (Multi-User)](#rls-policies-multi-user)
8. [Example Queries](#example-queries)
9. [Testing Strategy](#testing-strategy)
10. [Rollback Plan](#rollback-plan)
11. [Trade-Offs Analysis](#trade-offs-analysis)
12. [Decision Matrix](#decision-matrix)

---

## Current State (Filesystem)

### Directory Structure

```
outputs/courses/{slug}/
├── COURSE-BRIEF.md           # 8 sections (ICP, objectives, structure)
├── curriculum.yaml           # Modules + lessons hierarchy
├── course-outline.md         # Summary outline
├── lessons/
│   ├── modulo-1-aula-1.md   # Full lesson content (23 files)
│   ├── modulo-1-aula-2.md
│   └── ...
├── research/
│   ├── 01-market-analysis.md
│   ├── 02-gap-analysis.md
│   ├── 03-differentiation.md
│   └── 04-sources.md
└── .state/
    └── state-*.yaml          # Recovery checkpoints
```

### Current Python Modules (18 files, 11.6K LOC)

- `brief_parser.py` - Parses COURSE-BRIEF.md
- `curriculum_approval.py` - Validates curriculum.yaml
- `lesson_generator.py` - Generates lessons/*.md
- `course_validator.py` - Quality validation (GPS + Didática)
- `market_researcher.py` - Generates research/*.md
- `state_manager.py` - Manages .state/*.yaml
- `icp_extractor.py`, `voice_extractor.py`, `objectives_inferencer.py`
- `gps_validator.py`, `didatica_scorer.py`, `assessment_generator.py`
- `gap_analyzer.py`, `file_organizer.py`, `video_transcriber.py`
- `mmos_integrator.py`, `version_validator.py`

### Limitations

**Single-User:**
- All files local to one machine
- No team access
- No collaboration

**No Queries:**
- Cannot search courses by keyword
- Cannot filter by persona/status
- Cannot aggregate metrics

**No Scalability:**
- Dependent on one person
- No concurrent editing
- No access control

---

## Proposed State (Database-First)

### Architecture Philosophy

**Modular Design:**
- 4 tables, each with single responsibility
- Clear separation of concerns
- Extensible for future needs

**Data Location:**
- ALL course content in database
- Markdown stored as TEXT
- Structured data as JSONB
- No file_path references (not hybrid)

**Multi-User:**
- RLS policies for access control
- Team collaboration enabled
- Concurrent editing support

---

## Schema Design (Modular)

### Overview: 4 Tables

1. **content_pieces** (EXTEND) - Course entry point
2. **course_metadata** (NEW) - Brief, curriculum, outline
3. **course_lessons** (NEW) - All lesson content
4. **market_research** (NEW) - Research reports

### Relationship Hierarchy

```
content_pieces (1 course)
    ├── course_metadata (1:1) - Brief, curriculum, outline
    ├── course_lessons (1:N) - 23 lessons
    └── market_research (1:1) - 4 research reports
```

---

### Table 1: content_pieces (EXTEND EXISTING)

**Purpose:** Entry point for courses (metadata, status, ownership)

**Changes:** Add 4 fields to existing table

```sql
-- EXISTING FIELDS (from v0.7.0):
-- id UUID PRIMARY KEY
-- project_id UUID NOT NULL REFERENCES content_projects(id)
-- type TEXT NOT NULL -- 'blog', 'social', 'video_script', 'newsletter', 'course'
-- title TEXT NOT NULL
-- content TEXT NOT NULL
-- voice_fidelity_score NUMERIC(3,2)
-- generation_execution_id UUID REFERENCES job_executions(id)
-- published_at TIMESTAMPTZ
-- created_at TIMESTAMPTZ NOT NULL DEFAULT now()
-- updated_at TIMESTAMPTZ NOT NULL DEFAULT now()

-- NEW FIELDS (add these):
ALTER TABLE content_pieces
  ADD COLUMN piece_slug TEXT,                    -- 'meu-curso-supabase'
  ADD COLUMN persona_mind_id UUID REFERENCES minds(id) ON DELETE SET NULL,
  ADD COLUMN keywords JSONB,                     -- ['supabase', 'postgresql', 'rls']
  ADD COLUMN status TEXT DEFAULT 'draft' CHECK(status IN ('draft','published','archived'));

-- INDEXES:
CREATE UNIQUE INDEX idx_pieces_slug ON content_pieces(project_id, piece_slug);
CREATE INDEX idx_pieces_persona ON content_pieces(persona_mind_id);
CREATE INDEX idx_pieces_status ON content_pieces(status);
CREATE INDEX idx_pieces_type_status ON content_pieces(type, status);
```

**Stores:**
- Course title
- Creator (via project_id → content_projects → creator_mind_id)
- Persona used (persona_mind_id → minds)
- Keywords for search
- Status (draft/published/archived)

**Sample Row:**
```json
{
  "id": "a1b2c3d4-...",
  "project_id": "proj-123",
  "type": "course",
  "title": "Curso Completo de Supabase",
  "piece_slug": "curso-supabase",
  "persona_mind_id": "naval-ravikant-id",
  "keywords": ["supabase", "postgresql", "auth", "rls"],
  "status": "published",
  "voice_fidelity_score": 0.92
}
```

---

### Table 2: course_metadata (NEW)

**Purpose:** Store structural documents (COURSE-BRIEF, curriculum, outline)

**Design:** 1:1 with content_pieces (1 course = 1 metadata record)

```sql
CREATE TABLE course_metadata (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL UNIQUE REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Core Documents (full text content)
  course_brief TEXT,                              -- COURSE-BRIEF.md (full markdown)
  curriculum JSONB NOT NULL,                      -- curriculum.yaml as JSON
  course_outline TEXT,                            -- course-outline.md (full markdown)

  -- Extracted Metadata (parsed from brief)
  icp JSONB,                                      -- Ideal Customer Profile
  learning_objectives JSONB,                      -- Bloom's taxonomy levels

  -- Computed Statistics
  total_modules INT,                              -- Number of modules
  total_lessons INT,                              -- Number of lessons
  estimated_duration_hours INT,                   -- Course duration

  -- Timestamps
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- INDEXES:
CREATE INDEX idx_course_meta_piece ON course_metadata(content_piece_id);

-- TRIGGER (auto-update updated_at):
CREATE TRIGGER trg_course_meta_updated
BEFORE UPDATE ON course_metadata
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
```

**JSONB Structures:**

**curriculum (from curriculum.yaml):**
```json
{
  "modules": [
    {
      "number": 1,
      "title": "Introdução ao Supabase",
      "lessons": [
        {"number": 1, "title": "O que é Supabase?"},
        {"number": 2, "title": "Setup Inicial"}
      ]
    },
    {
      "number": 2,
      "title": "Autenticação",
      "lessons": [
        {"number": 1, "title": "Auth Providers"},
        {"number": 2, "title": "Row Level Security"}
      ]
    }
  ]
}
```

**icp (extracted from COURSE-BRIEF):**
```json
{
  "persona": "Frontend Developer transitioning to fullstack",
  "experience_level": "Intermediate",
  "pain_points": ["Backend complexity", "Auth implementation"],
  "goals": ["Build fullstack apps", "Master PostgreSQL"]
}
```

**learning_objectives (Bloom's levels):**
```json
{
  "remember": ["Recall Supabase core concepts"],
  "understand": ["Explain RLS policies"],
  "apply": ["Implement auth in React app"],
  "analyze": ["Compare Supabase vs Firebase"],
  "evaluate": ["Assess RLS policy effectiveness"],
  "create": ["Build production-ready fullstack app"]
}
```

**Sample Row:**
```json
{
  "id": "meta-123",
  "content_piece_id": "a1b2c3d4-...",
  "course_brief": "# COURSE-BRIEF\n\n## 1. ICP\n...",
  "curriculum": {"modules": [...]},
  "course_outline": "# Outline\n\n## Module 1\n...",
  "total_modules": 5,
  "total_lessons": 23,
  "estimated_duration_hours": 12
}
```

---

### Table 3: course_lessons (NEW)

**Purpose:** Store ALL lesson content (markdown)

**Design:** 1:N with content_pieces (1 course = 23 lessons)

```sql
CREATE TABLE course_lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Hierarchy (module + lesson numbering)
  module_number INT NOT NULL,                     -- 1, 2, 3, 4, 5
  lesson_number INT NOT NULL,                     -- 1, 2, 3, ...

  -- Content
  title TEXT NOT NULL,                            -- "O que é Supabase?"
  content_markdown TEXT NOT NULL,                 -- Full lesson (from modulo-1-aula-1.md)

  -- Quality Metrics (from course_validator.py)
  word_count INT,                                 -- Word count
  gps_score NUMERIC(3,2),                         -- GPS Framework score (0.00-1.00)
  didatica_score NUMERIC(3,2),                    -- Didática Lendária score (0.00-1.00)

  -- Status & Validation
  status TEXT DEFAULT 'draft' CHECK(status IN ('draft','reviewed','published','archived')),
  validation_status TEXT CHECK(validation_status IN ('passed','warning','failed')),
  validation_issues JSONB,                        -- [{issue: "X", severity: "high"}]

  -- Timestamps
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- Constraints
  UNIQUE(course_piece_id, module_number, lesson_number)
);

-- INDEXES:
CREATE INDEX idx_lessons_course ON course_lessons(course_piece_id);
CREATE INDEX idx_lessons_module ON course_lessons(module_number);
CREATE INDEX idx_lessons_status ON course_lessons(status);
CREATE INDEX idx_lessons_validation ON course_lessons(validation_status);

-- TRIGGER:
CREATE TRIGGER trg_lessons_updated
BEFORE UPDATE ON course_lessons
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
```

**validation_issues structure:**
```json
[
  {
    "issue": "Lesson too short (350 words, minimum 500)",
    "severity": "warning",
    "category": "content_length"
  },
  {
    "issue": "Missing GPS 'Position' section",
    "severity": "high",
    "category": "pedagogical"
  }
]
```

**Sample Row:**
```json
{
  "id": "lesson-001",
  "course_piece_id": "a1b2c3d4-...",
  "module_number": 1,
  "lesson_number": 1,
  "title": "O que é Supabase?",
  "content_markdown": "# O que é Supabase?\n\n## Goal\nAprender...",
  "word_count": 1247,
  "gps_score": 0.91,
  "didatica_score": 0.89,
  "status": "published",
  "validation_status": "passed"
}
```

---

### Table 4: market_research (NEW)

**Purpose:** Store market research reports

**Design:** 1:1 with content_pieces (1 course = 1 research record)

```sql
CREATE TABLE market_research (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL UNIQUE REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Research Reports (full markdown from research/ folder)
  market_analysis TEXT,                           -- 01-market-analysis.md
  gap_analysis TEXT,                              -- 02-gap-analysis.md
  differentiation_strategy TEXT,                  -- 03-differentiation.md
  sources_list TEXT,                              -- 04-sources.md

  -- Summary (JSONB for quick access)
  research_summary JSONB,                         -- Key findings
  competitors_analyzed INT,                       -- Number of courses analyzed

  -- Timestamps
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- Constraint
  UNIQUE(content_piece_id)
);

-- INDEXES:
CREATE INDEX idx_research_piece ON market_research(content_piece_id);

-- TRIGGER:
CREATE TRIGGER trg_research_updated
BEFORE UPDATE ON market_research
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
```

**research_summary structure:**
```json
{
  "key_findings": [
    "Gap: No course for frontend → fullstack transition",
    "Opportunity: Production deployment underserved (2/12 courses)",
    "Differentiation: ICP-specific examples vs generic tutorials"
  ],
  "pricing_recommendation": "$79 (mid-tier quality positioning)",
  "top_competitors": [
    {"name": "Supabase Crash Course", "price": "$49", "rating": 4.5},
    {"name": "Fullstack Supabase", "price": "$99", "rating": 4.7}
  ]
}
```

**Sample Row:**
```json
{
  "id": "research-123",
  "content_piece_id": "a1b2c3d4-...",
  "market_analysis": "# Market Analysis\n\nAnalyzed 12 courses...",
  "gap_analysis": "# Gap Analysis\n\nP0 Gaps: ...",
  "differentiation_strategy": "# Differentiation\n\nUnique positioning: ...",
  "sources_list": "# Sources\n\n1. Course A...",
  "competitors_analyzed": 12,
  "research_summary": {"key_findings": [...]}
}
```

---

## Entity-Relationship Diagram

### Text Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                       EXISTING TABLES                        │
└─────────────────────────────────────────────────────────────┘

minds                       content_projects            content_frameworks
├── id (PK)                ├── id (PK)                 ├── id (PK)
├── slug                   ├── creator_mind_id (FK)    ├── code
├── display_name           ├── persona_mind_id (FK)    ├── name
└── ...                    ├── name                    ├── type
                           └── goals                   └── description

┌─────────────────────────────────────────────────────────────┐
│                    COURSES ARCHITECTURE                      │
└─────────────────────────────────────────────────────────────┘

content_pieces (EXTENDED)
├── id (PK)
├── project_id (FK → content_projects)
├── type = 'course'
├── title
├── piece_slug (NEW)
├── persona_mind_id (FK → minds) (NEW)
├── keywords (JSONB) (NEW)
├── status (NEW)
├── voice_fidelity_score
└── ...
    │
    ├──[1:1]──> course_metadata (NEW)
    │           ├── id (PK)
    │           ├── content_piece_id (FK) UNIQUE
    │           ├── course_brief (TEXT)
    │           ├── curriculum (JSONB)
    │           ├── course_outline (TEXT)
    │           ├── icp (JSONB)
    │           ├── learning_objectives (JSONB)
    │           ├── total_modules
    │           └── total_lessons
    │
    ├──[1:N]──> course_lessons (NEW)
    │           ├── id (PK)
    │           ├── course_piece_id (FK)
    │           ├── module_number
    │           ├── lesson_number
    │           ├── title
    │           ├── content_markdown (TEXT)
    │           ├── word_count
    │           ├── gps_score
    │           ├── didatica_score
    │           ├── status
    │           ├── validation_status
    │           └── validation_issues (JSONB)
    │
    └──[1:1]──> market_research (NEW)
                ├── id (PK)
                ├── content_piece_id (FK) UNIQUE
                ├── market_analysis (TEXT)
                ├── gap_analysis (TEXT)
                ├── differentiation_strategy (TEXT)
                ├── sources_list (TEXT)
                ├── research_summary (JSONB)
                └── competitors_analyzed

┌─────────────────────────────────────────────────────────────┐
│                     RELATIONSHIPS                            │
└─────────────────────────────────────────────────────────────┘

1 content_pieces ──[1:1]── 1 course_metadata
1 content_pieces ──[1:N]── N course_lessons (23 lessons)
1 content_pieces ──[1:1]── 1 market_research

content_pieces.project_id ──[N:1]── content_projects.id
content_pieces.persona_mind_id ──[N:1]── minds.id
content_projects.creator_mind_id ──[N:1]── minds.id
content_projects.persona_mind_id ──[N:1]── minds.id
```

### Mermaid Diagram

```mermaid
erDiagram
    minds ||--o{ content_projects : "creator"
    minds ||--o{ content_projects : "persona"
    minds ||--o{ content_pieces : "persona"
    content_projects ||--o{ content_pieces : "contains"
    content_pieces ||--|| course_metadata : "has"
    content_pieces ||--o{ course_lessons : "has"
    content_pieces ||--|| market_research : "has"

    minds {
        uuid id PK
        text slug UK
        text display_name
        text primary_language
    }

    content_projects {
        uuid id PK
        uuid creator_mind_id FK
        uuid persona_mind_id FK
        text name
        text[] goals
        text status
    }

    content_pieces {
        uuid id PK
        uuid project_id FK
        text type
        text title
        text piece_slug
        uuid persona_mind_id FK
        jsonb keywords
        text status
        numeric voice_fidelity_score
    }

    course_metadata {
        uuid id PK
        uuid content_piece_id FK_UK
        text course_brief
        jsonb curriculum
        text course_outline
        jsonb icp
        jsonb learning_objectives
        int total_modules
        int total_lessons
    }

    course_lessons {
        uuid id PK
        uuid course_piece_id FK
        int module_number
        int lesson_number
        text title
        text content_markdown
        int word_count
        numeric gps_score
        numeric didatica_score
        text status
        text validation_status
        jsonb validation_issues
    }

    market_research {
        uuid id PK
        uuid content_piece_id FK_UK
        text market_analysis
        text gap_analysis
        text differentiation_strategy
        text sources_list
        jsonb research_summary
        int competitors_analyzed
    }
```

---

## Migration Strategy

### Phase 1: Schema Creation (1 hour)

**Step 1.1:** Create migration file
```bash
supabase/migrations/20251027_creator_os_database_first.sql
```

**Step 1.2:** Execute migration
```bash
./scripts/db-migrate.sh supabase/migrations/20251027_creator_os_database_first.sql
```

**Step 1.3:** Verify tables created
```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('course_metadata', 'course_lessons', 'market_research');
```

---

### Phase 2: Python Integration (3-4 hours)

**Modules to Modify:**

**1. Create db_persister.py (NEW - 200 LOC)**
```python
# expansion-packs/creator-os/lib/db_persister.py
"""
Database persistence layer for CreatorOS.
Handles all Supabase inserts/updates for courses.
"""
import os
from supabase import create_client, Client

class CoursePersister:
    def __init__(self):
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")
        self.db: Client = create_client(url, key)

    def persist_course(self, course_slug: str, project_id: str):
        """Insert course entry in content_pieces"""
        pass

    def persist_metadata(self, content_piece_id: str, brief: str, curriculum: dict):
        """Insert course_metadata"""
        pass

    def persist_lesson(self, content_piece_id: str, module: int, lesson: int, content: str):
        """Insert course_lesson"""
        pass

    def persist_research(self, content_piece_id: str, reports: dict):
        """Insert market_research"""
        pass
```

**2. Modify lesson_generator.py**
```python
# After generating lesson markdown:
from lib.db_persister import CoursePersister

persister = CoursePersister()
persister.persist_lesson(
    content_piece_id=course_id,
    module=module_num,
    lesson=lesson_num,
    content=lesson_markdown
)
```

**3. Modify brief_parser.py**
```python
# After parsing COURSE-BRIEF:
persister.persist_metadata(
    content_piece_id=course_id,
    brief=brief_content,
    curriculum=curriculum_dict
)
```

**4. Modify market_researcher.py**
```python
# After generating research reports:
persister.persist_research(
    content_piece_id=course_id,
    reports={
        "market_analysis": report1,
        "gap_analysis": report2,
        "differentiation_strategy": report3,
        "sources_list": report4
    }
)
```

**5. Modify course_validator.py**
```python
# After validation:
self.db.table("course_lessons").update({
    "validation_status": "passed",
    "gps_score": 0.91,
    "didatica_score": 0.89
}).eq("id", lesson_id).execute()
```

**Files Modified:**
- `lib/db_persister.py` (NEW - 200 LOC)
- `lib/lesson_generator.py` (+ 20 LOC)
- `lib/brief_parser.py` (+ 15 LOC)
- `lib/market_researcher.py` (+ 20 LOC)
- `lib/course_validator.py` (+ 15 LOC)
- `scripts/generate_course.py` (+ 10 LOC)

**Total:** ~280 LOC added

---

### Phase 3: RLS Policies (1 hour)

**See section:** [RLS Policies (Multi-User)](#rls-policies-multi-user)

---

### Phase 4: Testing (1-2 hours)

**See section:** [Testing Strategy](#testing-strategy)

---

## Python Integration Impact

### Dependencies to Add

```bash
# requirements.txt
supabase>=1.0.0
```

### Environment Variables

```bash
# .env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-key
```

### Code Changes Summary

| File | LOC Before | LOC After | Change |
|------|-----------|-----------|--------|
| `lib/db_persister.py` | 0 | 200 | NEW |
| `lib/lesson_generator.py` | 450 | 470 | +20 |
| `lib/brief_parser.py` | 280 | 295 | +15 |
| `lib/market_researcher.py` | 520 | 540 | +20 |
| `lib/course_validator.py` | 380 | 395 | +15 |
| `scripts/generate_course.py` | 150 | 160 | +10 |
| **TOTAL** | **1,780** | **2,060** | **+280** |

**Percentage increase:** 15.7% (manageable)

---

## RLS Policies (Multi-User)

### Policy Design Philosophy

**Levels:**
1. **Read:** Team can view all courses
2. **Write:** Only creator can edit their courses
3. **Delete:** Only creator can delete

### Policies for content_pieces

```sql
-- Enable RLS
ALTER TABLE content_pieces ENABLE ROW LEVEL SECURITY;

-- Policy 1: Anyone can view courses
CREATE POLICY "Anyone can view courses"
  ON content_pieces FOR SELECT
  USING (type = 'course');

-- Policy 2: Creators can insert courses in their projects
CREATE POLICY "Creators can insert courses"
  ON content_pieces FOR INSERT
  WITH CHECK (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );

-- Policy 3: Creators can update their own courses
CREATE POLICY "Creators can update own courses"
  ON content_pieces FOR UPDATE
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );

-- Policy 4: Creators can delete their own courses
CREATE POLICY "Creators can delete own courses"
  ON content_pieces FOR DELETE
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );
```

### Policies for course_metadata

```sql
ALTER TABLE course_metadata ENABLE ROW LEVEL SECURITY;

-- Read: Anyone can view
CREATE POLICY "Anyone can view course metadata"
  ON course_metadata FOR SELECT
  USING (true);

-- Write: Only via creator of parent course
CREATE POLICY "Creators can update course metadata"
  ON course_metadata FOR UPDATE
  USING (
    content_piece_id IN (
      SELECT cp.id FROM content_pieces cp
      JOIN content_projects proj ON cp.project_id = proj.id
      WHERE proj.creator_mind_id = current_mind_id()
    )
  );
```

### Policies for course_lessons

```sql
ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;

-- Read: Anyone can view
CREATE POLICY "Anyone can view lessons"
  ON course_lessons FOR SELECT
  USING (true);

-- Write: Only creator
CREATE POLICY "Creators can update lessons"
  ON course_lessons FOR UPDATE
  USING (
    course_piece_id IN (
      SELECT cp.id FROM content_pieces cp
      JOIN content_projects proj ON cp.project_id = proj.id
      WHERE proj.creator_mind_id = current_mind_id()
    )
  );
```

### Policies for market_research

```sql
ALTER TABLE market_research ENABLE ROW LEVEL SECURITY;

-- Read: Anyone can view
CREATE POLICY "Anyone can view research"
  ON market_research FOR SELECT
  USING (true);

-- Write: Only creator
CREATE POLICY "Creators can update research"
  ON market_research FOR UPDATE
  USING (
    content_piece_id IN (
      SELECT cp.id FROM content_pieces cp
      JOIN content_projects proj ON cp.project_id = proj.id
      WHERE proj.creator_mind_id = current_mind_id()
    )
  );
```

### Testing RLS Policies

```sql
-- Test as user (impersonate)
SET request.jwt.claims TO '{"sub": "user-123"}';

-- Should see all courses
SELECT * FROM content_pieces WHERE type = 'course';

-- Should only update own courses
UPDATE content_pieces SET title = 'New Title'
WHERE id = 'course-abc' AND project_id IN (
  SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()
);
```

---

## Example Queries

### Query 1: Get all courses by creator

```sql
SELECT
  cp.id,
  cp.title,
  cp.piece_slug,
  cp.status,
  m.display_name as creator_name,
  cm.total_modules,
  cm.total_lessons,
  cm.estimated_duration_hours,
  cp.created_at
FROM content_pieces cp
JOIN content_projects proj ON cp.project_id = proj.id
JOIN minds m ON proj.creator_mind_id = m.id
LEFT JOIN course_metadata cm ON cp.id = cm.content_piece_id
WHERE cp.type = 'course'
  AND proj.creator_mind_id = 'alan-mind-id'
ORDER BY cp.created_at DESC;
```

**Result:**
```
| id       | title                | slug           | status    | creator | modules | lessons | hours | created_at |
|----------|----------------------|----------------|-----------|---------|---------|---------|-------|------------|
| abc-123  | Curso de Supabase    | curso-supabase | published | Alan    | 5       | 23      | 12    | 2025-10-27 |
| def-456  | Curso de PostgreSQL  | curso-postgres | draft     | Alan    | 4       | 18      | 10    | 2025-10-26 |
```

---

### Query 2: Get all lessons for a course

```sql
SELECT
  cl.module_number,
  cl.lesson_number,
  cl.title,
  cl.word_count,
  cl.gps_score,
  cl.didatica_score,
  cl.status,
  cl.validation_status
FROM course_lessons cl
WHERE cl.course_piece_id = 'abc-123'
ORDER BY cl.module_number, cl.lesson_number;
```

**Result:**
```
| module | lesson | title                | words | gps   | dl    | status    | validation |
|--------|--------|----------------------|-------|-------|-------|-----------|------------|
| 1      | 1      | O que é Supabase?    | 1247  | 0.91  | 0.89  | published | passed     |
| 1      | 2      | Setup Inicial        | 1050  | 0.88  | 0.92  | published | passed     |
| 2      | 1      | Auth Providers       | 1320  | 0.93  | 0.87  | published | passed     |
```

---

### Query 3: Search courses by keyword

```sql
SELECT
  cp.id,
  cp.title,
  cp.keywords,
  cp.status,
  m.display_name as persona_name
FROM content_pieces cp
LEFT JOIN minds m ON cp.persona_mind_id = m.id
WHERE cp.type = 'course'
  AND cp.keywords ? 'supabase'  -- JSONB contains key
ORDER BY cp.created_at DESC;
```

---

### Query 4: Course quality dashboard

```sql
SELECT
  cp.title,
  cm.total_lessons,
  AVG(cl.gps_score) as avg_gps_score,
  AVG(cl.didatica_score) as avg_didatica_score,
  AVG(cl.word_count) as avg_word_count,
  COUNT(CASE WHEN cl.validation_status = 'passed' THEN 1 END) as passed_lessons,
  COUNT(CASE WHEN cl.validation_status = 'failed' THEN 1 END) as failed_lessons
FROM content_pieces cp
JOIN course_metadata cm ON cp.id = cm.content_piece_id
JOIN course_lessons cl ON cp.id = cl.course_piece_id
WHERE cp.type = 'course'
GROUP BY cp.id, cp.title, cm.total_lessons;
```

**Result:**
```
| title             | total | avg_gps | avg_dl | avg_words | passed | failed |
|-------------------|-------|---------|--------|-----------|--------|--------|
| Curso de Supabase | 23    | 0.91    | 0.89   | 1185      | 22     | 1      |
```

---

### Query 5: Get course with full curriculum

```sql
SELECT
  cp.title,
  cm.curriculum
FROM content_pieces cp
JOIN course_metadata cm ON cp.id = cm.content_piece_id
WHERE cp.piece_slug = 'curso-supabase';
```

**Result (JSONB):**
```json
{
  "title": "Curso Completo de Supabase",
  "curriculum": {
    "modules": [
      {
        "number": 1,
        "title": "Introdução",
        "lessons": [
          {"number": 1, "title": "O que é Supabase?"},
          {"number": 2, "title": "Setup Inicial"}
        ]
      }
    ]
  }
}
```

---

### Query 6: Find courses by persona

```sql
SELECT
  cp.title,
  m.display_name as persona,
  cp.voice_fidelity_score
FROM content_pieces cp
JOIN minds m ON cp.persona_mind_id = m.id
WHERE m.slug = 'naval-ravikant'
  AND cp.type = 'course'
ORDER BY cp.voice_fidelity_score DESC;
```

---

## Testing Strategy

### Unit Tests (Python)

**Test File:** `expansion-packs/creator-os/tests/test_db_persister.py`

```python
import pytest
from lib.db_persister import CoursePersister

def test_persist_course():
    persister = CoursePersister()
    course_id = persister.persist_course(
        course_slug="test-course",
        project_id="proj-123"
    )
    assert course_id is not None

def test_persist_lesson():
    persister = CoursePersister()
    lesson_id = persister.persist_lesson(
        content_piece_id="course-abc",
        module=1,
        lesson=1,
        content="# Test Lesson\n\nContent here."
    )
    assert lesson_id is not None

def test_persist_metadata():
    persister = CoursePersister()
    meta_id = persister.persist_metadata(
        content_piece_id="course-abc",
        brief="# COURSE-BRIEF\n...",
        curriculum={"modules": []}
    )
    assert meta_id is not None
```

**Run tests:**
```bash
pytest expansion-packs/creator-os/tests/test_db_persister.py -v
```

---

### Integration Tests (End-to-End)

**Test File:** `expansion-packs/creator-os/tests/test_course_generation_e2e.py`

```python
import pytest
import os
from scripts.generate_course import generate_course_workflow

def test_generate_course_persists_to_db():
    """Test that generating a course persists all data to database"""

    # Setup
    course_slug = "test-e2e-course"

    # Execute
    result = generate_course_workflow(
        course_slug=course_slug,
        mode="greenfield"
    )

    # Verify in database
    from lib.db_persister import CoursePersister
    persister = CoursePersister()

    # Check course exists
    course = persister.db.table("content_pieces").select("*").eq("piece_slug", course_slug).single().execute()
    assert course.data is not None

    # Check metadata exists
    metadata = persister.db.table("course_metadata").select("*").eq("content_piece_id", course.data["id"]).single().execute()
    assert metadata.data is not None
    assert metadata.data["total_lessons"] > 0

    # Check lessons exist
    lessons = persister.db.table("course_lessons").select("*").eq("course_piece_id", course.data["id"]).execute()
    assert len(lessons.data) == metadata.data["total_lessons"]

    # Check research exists
    research = persister.db.table("market_research").select("*").eq("content_piece_id", course.data["id"]).single().execute()
    assert research.data is not None

    # Cleanup
    persister.db.table("content_pieces").delete().eq("id", course.data["id"]).execute()
```

**Run test:**
```bash
pytest expansion-packs/creator-os/tests/test_course_generation_e2e.py -v
```

---

### Smoke Tests (Database)

**Test File:** `supabase/tests/smoke_test_creator_os.sql`

```sql
-- Smoke test: Verify tables exist
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('content_pieces', 'course_metadata', 'course_lessons', 'market_research');
-- Expected: 4 rows

-- Smoke test: Verify foreign keys
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'public'
  AND table_name IN ('course_metadata', 'course_lessons', 'market_research')
  AND constraint_type = 'FOREIGN KEY';
-- Expected: 3 rows

-- Smoke test: Verify indexes
SELECT tablename, indexname
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN ('course_metadata', 'course_lessons', 'market_research');
-- Expected: 6+ rows

-- Smoke test: Verify RLS enabled
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('content_pieces', 'course_metadata', 'course_lessons', 'market_research');
-- Expected: All rowsecurity = true

-- Smoke test: Insert and query test course
BEGIN;
  INSERT INTO content_pieces (project_id, type, title, piece_slug)
  VALUES ('test-proj', 'course', 'Test Course', 'test-smoke');

  INSERT INTO course_metadata (content_piece_id, curriculum)
  SELECT id, '{"modules":[]}'::jsonb FROM content_pieces WHERE piece_slug = 'test-smoke';

  SELECT * FROM content_pieces WHERE piece_slug = 'test-smoke';
  -- Expected: 1 row

  SELECT * FROM course_metadata cm
  JOIN content_pieces cp ON cm.content_piece_id = cp.id
  WHERE cp.piece_slug = 'test-smoke';
  -- Expected: 1 row
ROLLBACK;
```

**Run smoke test:**
```bash
psql "$SUPABASE_DB_URL" -f supabase/tests/smoke_test_creator_os.sql
```

---

### Manual Testing Checklist

- [ ] Generate new course (greenfield)
- [ ] Verify course appears in content_pieces
- [ ] Verify metadata in course_metadata
- [ ] Verify 23 lessons in course_lessons
- [ ] Verify research in market_research
- [ ] Query course by keyword
- [ ] Query lessons by module
- [ ] Test RLS: user A cannot edit user B's course
- [ ] Test RLS: user A can view user B's course
- [ ] Update lesson content
- [ ] Delete course (verify CASCADE deletes metadata, lessons, research)

---

## Rollback Plan

### Scenario 1: Migration Fails

**Action:** Rollback migration

```bash
./scripts/db-rollback.sh supabase/migrations/20251027_creator_os_database_first.sql
```

**Rollback Script:** `supabase/rollback/20251027_creator_os_database_first_rollback.sql`

```sql
-- Drop new tables
DROP TABLE IF EXISTS market_research CASCADE;
DROP TABLE IF EXISTS course_lessons CASCADE;
DROP TABLE IF EXISTS course_metadata CASCADE;

-- Remove new columns from content_pieces
ALTER TABLE content_pieces
  DROP COLUMN IF EXISTS piece_slug,
  DROP COLUMN IF EXISTS persona_mind_id,
  DROP COLUMN IF EXISTS keywords,
  DROP COLUMN IF EXISTS status;

-- Drop indexes
DROP INDEX IF EXISTS idx_pieces_slug;
DROP INDEX IF EXISTS idx_pieces_persona;
DROP INDEX IF EXISTS idx_pieces_status;
DROP INDEX IF EXISTS idx_pieces_type_status;
```

**Verification:**
```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('course_metadata', 'course_lessons', 'market_research');
-- Expected: 0 rows
```

---

### Scenario 2: Python Integration Breaks

**Action:** Git revert + redeploy

```bash
git revert HEAD
git push origin main
```

**Fallback:** Keep schema, disable Python persistence temporarily

```python
# In lib/db_persister.py
PERSIST_TO_DB = os.getenv("CREATOR_OS_PERSIST_DB", "false") == "true"

def persist_lesson(...):
    if not PERSIST_TO_DB:
        return  # No-op, keep filesystem only
    # ... persist to DB
```

---

### Scenario 3: RLS Blocks Team Access

**Action:** Temporarily disable RLS, fix policies

```sql
-- Disable RLS (temporary)
ALTER TABLE course_lessons DISABLE ROW LEVEL SECURITY;

-- Fix policy
DROP POLICY "Creators can update lessons" ON course_lessons;
CREATE POLICY "Creators can update lessons" ON course_lessons FOR UPDATE
USING (true);  -- Allow all (fix later)

-- Re-enable RLS
ALTER TABLE course_lessons ENABLE ROW LEVEL SECURITY;
```

---

## Trade-Offs Analysis

### Filesystem (Current)

**Pros:**
- Simple (no DB complexity)
- Git-friendly (text files)
- Zero migration effort
- Works today (proven)

**Cons:**
- Single-user ONLY (blocking issue)
- Team cannot access (blocking issue)
- No collaboration
- No SQL queries
- Machine-dependent

**Verdict:** REJECTED - Does not solve validated pain (multi-user requirement)

---

### Hybrid (Metadata in DB, Content in Filesystem)

**Pros:**
- Lighter migration
- Files stay on disk
- Some queryability

**Cons:**
- Still machine-dependent (filesystem)
- Team cannot edit lessons (files local)
- Partial solution (not fully multi-user)
- Complexity without full benefit

**Verdict:** REJECTED - Does not fully solve multi-user requirement

---

### Database-First (Proposed)

**Pros:**
- MULTI-USER ENABLED (solves core pain)
- Team collaboration (solves core pain)
- SQL queries (full queryability)
- Centralized state (scalable)
- RLS for access control
- Extensible (analytics, versioning later)

**Cons:**
- Migration required (6-8 hours)
- RLS complexity (medium)
- Python code changes (280 LOC)
- Testing overhead (2 hours)

**Verdict:** RECOMMENDED - Only approach that solves validated multi-user pain

---

## Decision Matrix

| Factor | Weight | Filesystem | Hybrid | Database-First |
|--------|--------|-----------|---------|----------------|
| **Solves Multi-User Pain** | 40% | 0/10 | 3/10 | 10/10 |
| **Team Collaboration** | 30% | 0/10 | 4/10 | 10/10 |
| **Implementation Effort** | 15% | 10/10 | 7/10 | 4/10 |
| **Scalability** | 10% | 2/10 | 5/10 | 10/10 |
| **Simplicity** | 5% | 10/10 | 6/10 | 5/10 |
| **TOTAL SCORE** | 100% | **2.5/10** | **4.5/10** | **9.0/10** |

**Winner:** Database-First (9.0/10)

---

## Implementation Timeline

### Day 1 (6-8 hours)

**Morning (3-4 hours):**
- [ ] Create migration script (1h)
- [ ] Execute migration + verify (30min)
- [ ] Create db_persister.py (1.5-2h)

**Afternoon (3-4 hours):**
- [ ] Modify lesson_generator.py (30min)
- [ ] Modify brief_parser.py (30min)
- [ ] Modify market_researcher.py (30min)
- [ ] Modify course_validator.py (30min)
- [ ] Create RLS policies (1h)
- [ ] Smoke test (30min)

---

### Day 2 (2-3 hours - Optional)

**Testing & Polish:**
- [ ] Write unit tests (1h)
- [ ] Write integration test (1h)
- [ ] Manual testing checklist (30min)
- [ ] Documentation updates (30min)

---

## Recommendation

**Approve Database-First Architecture**

**Reasoning:**
1. Only approach that solves validated multi-user pain
2. Enables team collaboration (core requirement)
3. Scalable beyond single machine
4. Modular design (4 tables, clear separation)
5. Extensible for future needs
6. Effort is reasonable (6-8 hours)

**Not over-engineering because:**
- Only adding what's needed for multi-user
- 4 tables (not 15)
- No premature analytics/tracking
- Focused on current pain

**KISS Gate Status:** PASS (validated pain, minimal design, clear benefit)

---

## Next Steps (If Approved)

1. Approve this document
2. Create migration script
3. Execute migration on dev environment
4. Test with 1 course
5. Integrate Python modules
6. Test with 2 users
7. Deploy to production

**Estimated Total Time:** 6-8 hours

---

## Questions for Alan

Before proceeding, please answer:

1. **Approve schema design?** (4 tables: content_pieces, course_metadata, course_lessons, market_research)
2. **Approve RLS policy design?** (read: all, write: creator only)
3. **Any additional fields needed?** (e.g., assessments, feedback, versioning)
4. **Timeline acceptable?** (6-8 hours)
5. **Ready to proceed?** (yes/no)

---

**Document Status:** Ready for Decision
**Created:** 2025-10-27
**DB Sage:** KISS Gate Validated ✓
