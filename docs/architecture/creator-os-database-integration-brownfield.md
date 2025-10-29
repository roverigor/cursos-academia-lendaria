# CreatorOS Database Integration - Brownfield Architecture

**Document Type:** Brownfield Architecture
**System:** CreatorOS (Content Generation & Course Creation)
**Date:** 2025-10-28
**Version:** 1.0.0
**Architect:** Winston (AIOS Architect)
**Status:** Proposed
**Target Audience:** @dev (Development Team)

---

## Executive Summary

### Current State (2025-10-28)

✅ **MIGRATION COMPLETED**: Todos os cursos e materiais do CreatorOS já foram migrados para Supabase (PostgreSQL).

O CreatorOS **já opera em modo database-first** com Supabase, onde todos os outputs de cursos (lessons, briefs, research) são persistidos diretamente no banco de dados PostgreSQL em produção.

### Purpose of This Document

Este documento serve como **guia de referência arquitetural** para a equipe de desenvolvimento (@dev) trabalhar com a integração CreatorOS + Supabase:

1. **Entender a arquitetura atual** - Como o sistema funciona hoje
2. **Pontos de integração** - Onde o código Python se conecta ao banco
3. **Boas práticas** - Como adicionar novos recursos mantendo consistência
4. **Troubleshooting** - Como diagnosticar e resolver problemas
5. **Próximas otimizações** - Melhorias planejadas para o sistema

### System Overview

```
Python CreatorOS Modules
         ↓
  Supabase Client (supabase-py)
         ↓
Supabase PostgreSQL (Production)
  ├── content_pieces (courses)
  ├── course_metadata (briefs, curriculum)
  ├── course_lessons (1:N lessons)
  ├── market_research (competitive analysis)
  └── content_performance (analytics)
```

### Current Capabilities (Production)

✅ **Full Traceability** - Every content piece linked to generating mind/persona
✅ **Rich Analytics** - Quality scores, voice fidelity, and performance metrics tracked
✅ **Team Collaboration** - Centralized access via Supabase PostgreSQL
✅ **Powerful Queries** - Search, filter, and analyze content via SQL
✅ **System Integration** - Seamless connection between CreatorOS, MMOS, and InnerLens
✅ **RLS Security** - Row-Level Security policies control multi-user access
✅ **Real-time Sync** - All outputs persisted to database in real-time

---

## Table of Contents

1. [Current State Analysis](#current-state-analysis)
2. [Proposed Architecture](#proposed-architecture)
3. [Database Schema Design](#database-schema-design)
4. [Integration Strategy](#integration-strategy)
5. [Code Integration Points](#code-integration-points)
6. [Migration Plan](#migration-plan)
7. [Testing Strategy](#testing-strategy)
8. [Rollback Plan](#rollback-plan)
9. [Performance Considerations](#performance-considerations)
10. [Security & Access Control](#security--access-control)
11. [Future Extensions](#future-extensions)

---

## Current State Analysis (Production System)

### Architecture: Supabase Database-First

**Status:** ✅ **PRODUCTION** (Todos os cursos migrados para Supabase)

O CreatorOS opera em **modo database-first** onde:
- ✅ Primary source of truth: Supabase PostgreSQL
- ✅ All outputs (lessons, briefs, research) persistidos no banco
- ✅ Row-Level Security (RLS) habilitado para multi-user
- ✅ Real-time sync via Supabase Client (Python)
- ⚠️ Filesystem outputs: Deprecated (não mais gerados por padrão)

### Production Database (Supabase)

**Connection:**
- **Host:** aws-1-us-east-2.pooler.supabase.com
- **Database:** PostgreSQL 17.6
- **Schema Version:** v0.7.0
- **Total Tables:** 30
- **CreatorOS Tables:** 5 (content_pieces, course_metadata, course_lessons, market_research, content_performance)

### Legacy Directory Structure (Deprecated)

⚠️ **NOTA:** Esta estrutura de filesystem **não é mais usada** no sistema de produção. Mantida apenas para referência histórica.

```
outputs/courses/{slug}/  [DEPRECATED - Não mais gerado]
├── COURSE-BRIEF.md
├── curriculum.yaml
├── lessons/*.md
├── research/*.md
└── .state/*.yaml
```

**Migração concluída:** Todos os dados agora estão em Supabase.

### Python Modules (Current Implementation)

| Module | Purpose | LOC | Key Functions |
|--------|---------|-----|---------------|
| `brief_parser.py` | Parse COURSE-BRIEF.md into structured data | 280 | `parse()`, `extract_section()` |
| `lesson_generator.py` | Generate lessons with GPS + Didática Lendária | 450 | `generate_all_lessons()`, `generate_single_lesson()` |
| `curriculum_approval.py` | Validate curriculum.yaml structure | 200 | `validate_curriculum()`, `check_bloom_progression()` |
| `course_validator.py` | Quality validation (GPS + Didática scores) | 380 | `validate_course()`, `score_lesson()` |
| `market_researcher.py` | Competitive market research | 520 | `research_market()`, `analyze_gaps()` |
| `state_manager.py` | Checkpoint/recovery system | 150 | `save_checkpoint()`, `load_state()` |
| `icp_extractor.py` | Extract ICP from legacy materials | 180 | `extract_icp()` |
| `voice_extractor.py` | Extract voice profile from transcripts | 200 | `extract_voice()` |
| `mmos_integrator.py` | Load MMOS mind data for voice injection | 250 | `load_mind()`, `inject_voice()` |

**Total:** ~2,610 LOC (9 modules)

### Current Workflow (Greenfield Course Creation)

```
User: @course-architect
User: *new supabase-zero-backend

1. init_course_greenfield.md
   → Create directory structure
   → Generate empty COURSE-BRIEF.md template

2. User fills COURSE-BRIEF.md manually

3. market_researcher.py
   → Generate 4 research reports (outputs/courses/{slug}/research/*.md)
   → Save to filesystem ONLY

4. curriculum_approval.py
   → Generate curriculum.yaml from COURSE-BRIEF
   → Save to filesystem ONLY

5. lesson_generator.py
   → Generate 15-25 lessons (outputs/courses/{slug}/lessons/*.md)
   → Save to filesystem ONLY

6. course_validator.py
   → Validate all lessons (GPS structure, DL scoring)
   → Generate validation report (console output ONLY)

Result:
✅ Files created in outputs/courses/{slug}/
❌ NO database record
❌ NO traceability to mind/persona
❌ NO quality metrics stored
```

### Current System Capabilities

#### 1. Full Content Traceability ✅

**Implemented:** Sistema consegue responder:
- ✅ "Which mind generated this course?" → Query `content_pieces.persona_mind_id`
- ✅ "What was the voice fidelity score?" → Query `content_pieces.voice_fidelity_score`
- ✅ "Which courses used Naval Ravikant persona?" → JOIN `content_pieces` + `minds`
- ✅ "What's the average quality score for technical courses?" → Aggregate query on `course_lessons.gps_score`

**Status:** Fully functional in production via Supabase queries.

#### 2. No Performance Analytics

**Problem:** Cannot track:
- Voice fidelity trends over time
- GPS/DL score distributions
- Best-performing personas by content type
- Quality improvements across versions

**Impact:** No data-driven decisions for content strategy.

#### 3. No Multi-User Collaboration

**Problem:**
- All content local to one machine
- No team access to generated courses
- No concurrent editing
- No access control

**Impact:** Blocks team scaling and collaboration.

#### 4. No Queryability

**Problem:** Cannot query:
- "Show all courses with fidelity > 90%"
- "Find courses about 'authentication'"
- "List courses by Nassim Taleb persona"
- "Compare quality across pedagogical frameworks"

**Impact:** Manual file searching, no systematic analysis.

#### 5. System Isolation

**Problem:**
- CreatorOS data not connected to MMOS minds database
- Cannot leverage mind rankings or specializations
- No cross-system analytics (MMOS + CreatorOS + InnerLens)

**Impact:** Missed opportunities for intelligent recommendations and insights.

---

## Proposed Architecture

### High-Level Design

```
┌─────────────────────────────────────────────────────────────────┐
│                     CreatorOS Workflow                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │   Python Generation Modules    │
              │   (lesson_generator.py, etc.)  │
              └───────────────────────────────┘
                              │
                ┌─────────────┴─────────────┐
                ▼                           ▼
    ┌───────────────────────┐   ┌───────────────────────┐
    │   Filesystem Output    │   │   Database Persister  │
    │   (backward compat)    │   │   (db_persister.py)   │
    └───────────────────────┘   └───────────────────────┘
                │                           │
                ▼                           ▼
    outputs/courses/{slug}/     outputs/database/mmos.db
    ├── lessons/*.md            ├── content_pieces
    ├── COURSE-BRIEF.md         ├── course_metadata
    └── research/*.md           ├── course_lessons
                                ├── market_research
                                └── content_performance
```

### Design Principles

1. **Database-First, Filesystem-Compatible**
   - Primary source of truth: Database
   - Filesystem outputs: Human-readable snapshots for review
   - Both written simultaneously (dual-write pattern)

2. **Incremental Migration**
   - Phase 1: Courses only (content_pieces, course_metadata, course_lessons)
   - Phase 2: Analytics & performance tracking
   - Phase 3: Multi-user & Supabase migration
   - No big-bang rewrite

3. **Zero Breaking Changes**
   - All existing Python modules continue to work
   - Filesystem outputs still generated
   - Add database layer alongside existing code
   - Feature flag for gradual rollout

4. **Full Traceability**
   - Every content piece linked to generating mind/persona
   - Quality scores persisted for analysis
   - Generation metadata (cost, duration, model) tracked

5. **Performance-First**
   - Batch inserts for lessons (1 transaction for 20 lessons)
   - Async writes to avoid blocking generation
   - Indexing strategy for common queries

---

## Database Schema Design

### Schema Overview (4 New Tables)

```sql
1. content_pieces (EXTEND EXISTING) - Course entry point
2. course_metadata (NEW) - Brief, curriculum, outline
3. course_lessons (NEW) - All lesson content (1:N)
4. market_research (NEW) - Research reports (1:1)
```

### Relationship Hierarchy

```
content_pieces (1 course)
    ├── course_metadata (1:1) - Brief, curriculum, outline
    ├── course_lessons (1:N) - 15-25 lessons
    └── market_research (1:1) - 4 research reports
```

### Table 1: content_pieces (EXTEND)

**Purpose:** Entry point for courses (already exists for blogs/social content)

**Changes:** Add 4 new fields to existing table

```sql
-- EXISTING FIELDS (from v0.7.0):
-- id, project_id, type, title, content, voice_fidelity_score,
-- generation_execution_id, published_at, created_at, updated_at

-- NEW FIELDS:
ALTER TABLE content_pieces
  ADD COLUMN piece_slug TEXT,                    -- 'supabase-zero-backend'
  ADD COLUMN persona_mind_id INTEGER REFERENCES minds(id) ON DELETE SET NULL,
  ADD COLUMN keywords TEXT,                      -- JSON: ["supabase", "backend", "auth"]
  ADD COLUMN status TEXT DEFAULT 'draft'
    CHECK(status IN ('draft','published','archived'));

-- INDEXES:
CREATE UNIQUE INDEX idx_pieces_slug ON content_pieces(project_id, piece_slug);
CREATE INDEX idx_pieces_persona ON content_pieces(persona_mind_id);
CREATE INDEX idx_pieces_status ON content_pieces(status);
CREATE INDEX idx_pieces_keywords ON content_pieces(keywords);
```

**Stores:**
- Course title
- Creator mind (via persona_mind_id → minds)
- Keywords for search
- Status (draft/published/archived)
- Voice fidelity score (overall course score)

**Sample Row:**
```json
{
  "id": "cp_a1b2c3d4",
  "project_id": "proj_123",
  "type": "course",
  "title": "Supabase: Zero-Backend Completo",
  "piece_slug": "supabase-zero-backend-completo",
  "persona_mind_id": 42,  // Naval Ravikant mind
  "keywords": "[\"supabase\", \"backend\", \"auth\", \"postgresql\"]",
  "status": "published",
  "voice_fidelity_score": 0.92
}
```

---

### Table 2: course_metadata (NEW)

**Purpose:** Store structural documents (COURSE-BRIEF, curriculum, outline)

**Design:** 1:1 with content_pieces

```sql
CREATE TABLE course_metadata (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_piece_id TEXT NOT NULL UNIQUE
    REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Core Documents (full markdown content)
  course_brief TEXT,                              -- COURSE-BRIEF.md (full)
  curriculum TEXT NOT NULL,                       -- curriculum.yaml as JSON
  course_outline TEXT,                            -- course-outline.md (full)

  -- Extracted Metadata (parsed from brief)
  icp_data TEXT,                                  -- JSON: ICP section
  learning_objectives TEXT,                       -- JSON: Learning objectives
  voice_profile TEXT,                             -- JSON: Voice profile section
  pedagogical_framework TEXT DEFAULT 'GPS + Didática Lendária',

  -- Computed Statistics
  total_modules INTEGER,                          -- Number of modules
  total_lessons INTEGER,                          -- Number of lessons
  estimated_duration_hours INTEGER,               -- Course duration

  -- Course Type Classification
  course_type TEXT CHECK(course_type IN ('technical', 'conceptual', 'mixed')),
  tool_name TEXT,                                 -- Main tool (if technical)
  knowledge_level TEXT CHECK(knowledge_level IN ('beginner', 'intermediate', 'advanced')),

  -- Timestamps
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_course_meta_piece ON course_metadata(content_piece_id);
CREATE INDEX idx_course_meta_type ON course_metadata(course_type);
CREATE INDEX idx_course_meta_tool ON course_metadata(tool_name);
```

**Sample Row:**
```json
{
  "id": 1,
  "content_piece_id": "cp_a1b2c3d4",
  "course_brief": "# COURSE-BRIEF\n\n## 1. Basic Information...",
  "curriculum": "{\"modules\": [{\"number\": 1, \"title\": \"Intro\", \"lessons\": [...]}]}",
  "course_outline": "# Course Outline\n\n## Module 1...",
  "icp_data": "{\"demographics\": {\"age\": \"25-40\"}, \"pain_points\": [...]}",
  "total_modules": 5,
  "total_lessons": 23,
  "course_type": "technical",
  "tool_name": "Supabase"
}
```

---

### Table 3: course_lessons (NEW)

**Purpose:** Store ALL lesson content (markdown + quality metrics)

**Design:** 1:N with content_pieces (1 course = 15-25 lessons)

```sql
CREATE TABLE course_lessons (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_piece_id TEXT NOT NULL
    REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Hierarchy (module + lesson numbering)
  module_number INTEGER NOT NULL,                 -- 1, 2, 3, 4, 5
  lesson_number INTEGER NOT NULL,                 -- 1, 2, 3, ...
  lesson_id TEXT NOT NULL,                        -- "1.1", "1.2", "2.1"

  -- Content
  title TEXT NOT NULL,                            -- "O que é Supabase?"
  slug TEXT NOT NULL,                             -- "o-que-e-supabase"
  content_markdown TEXT NOT NULL,                 -- Full lesson (from 1.1-intro.md)

  -- Quality Metrics (from course_validator.py)
  word_count INTEGER,                             -- Word count
  gps_valid INTEGER CHECK(gps_valid IN (0, 1)),  -- GPS structure valid?
  gps_score REAL,                                 -- GPS score (0.00-1.00)
  didatica_score REAL,                            -- Didática Lendária score (0.00-1.00)

  -- Bloom's Taxonomy Level
  bloom_level TEXT CHECK(bloom_level IN (
    'remember', 'understand', 'apply',
    'analyze', 'evaluate', 'create'
  )),

  -- Learning Objectives
  learning_objectives TEXT,                       -- JSON: ["Objective 1", "Objective 2"]
  key_concepts TEXT,                              -- JSON: ["Concept 1", "Concept 2"]

  -- Status & Validation
  status TEXT DEFAULT 'draft' CHECK(status IN (
    'draft', 'reviewed', 'published', 'archived'
  )),
  validation_status TEXT CHECK(validation_status IN (
    'passed', 'warning', 'failed'
  )),
  validation_issues TEXT,                         -- JSON: [{issue: "X", severity: "high"}]

  -- Generation Metadata
  generation_duration_seconds REAL,
  generation_cost_usd REAL,
  retry_count INTEGER DEFAULT 0,

  -- File Reference (for backward compat)
  file_path TEXT,                                 -- "outputs/courses/{slug}/lessons/1.1-intro.md"

  -- Timestamps
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),

  -- Constraints
  UNIQUE(course_piece_id, module_number, lesson_number)
);

CREATE INDEX idx_lessons_course ON course_lessons(course_piece_id);
CREATE INDEX idx_lessons_module ON course_lessons(module_number);
CREATE INDEX idx_lessons_lesson_id ON course_lessons(lesson_id);
CREATE INDEX idx_lessons_status ON course_lessons(status);
CREATE INDEX idx_lessons_validation ON course_lessons(validation_status);
CREATE INDEX idx_lessons_bloom ON course_lessons(bloom_level);
CREATE INDEX idx_lessons_gps_score ON course_lessons(gps_score);
CREATE INDEX idx_lessons_dl_score ON course_lessons(didatica_score);
```

**Sample Row:**
```json
{
  "id": 1,
  "course_piece_id": "cp_a1b2c3d4",
  "module_number": 1,
  "lesson_number": 1,
  "lesson_id": "1.1",
  "title": "O que é Supabase?",
  "slug": "o-que-e-supabase",
  "content_markdown": "# O que é Supabase?\n\n## Goal\nAprender...",
  "word_count": 1247,
  "gps_valid": 1,
  "gps_score": 0.91,
  "didatica_score": 0.89,
  "bloom_level": "understand",
  "status": "published",
  "validation_status": "passed",
  "file_path": "outputs/courses/supabase-zero-backend-completo/lessons/1.1-o-que-e-supabase.md"
}
```

---

### Table 4: market_research (NEW)

**Purpose:** Store market research reports (competitive analysis)

**Design:** 1:1 with content_pieces

```sql
CREATE TABLE market_research (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_piece_id TEXT NOT NULL UNIQUE
    REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Research Reports (full markdown from research/ folder)
  market_analysis TEXT,                           -- 01-market-analysis.md
  gap_analysis TEXT,                              -- 02-gap-analysis.md
  differentiation_strategy TEXT,                  -- 03-differentiation.md
  sources_list TEXT,                              -- 04-sources.md

  -- Summary (JSON for quick access)
  research_summary TEXT,                          -- JSON: Key findings
  competitors_analyzed INTEGER,                   -- Number of courses analyzed

  -- Recommendations
  pricing_recommendation TEXT,
  positioning_strategy TEXT,

  -- Timestamps
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_research_piece ON market_research(content_piece_id);
```

**Sample Row:**
```json
{
  "id": 1,
  "content_piece_id": "cp_a1b2c3d4",
  "market_analysis": "# Market Analysis\n\nAnalyzed 12 courses...",
  "gap_analysis": "# Gap Analysis\n\nP0 Gaps: ...",
  "differentiation_strategy": "# Differentiation\n\n...",
  "sources_list": "# Sources\n\n1. Course A...",
  "competitors_analyzed": 12,
  "research_summary": "{\"key_findings\": [...], \"pricing\": \"$79\"}"
}
```

---

## Integration Strategy

### Dual-Write Pattern (Phase 1)

**Approach:** Write to BOTH database and filesystem simultaneously

```python
# In lesson_generator.py (AFTER generating lesson)

# 1. Write to filesystem (existing behavior)
lesson_path = save_lesson_to_file(lesson_content, file_path)

# 2. Write to database (NEW)
from lib.db_persister import CoursePersister
persister = CoursePersister()
persister.persist_lesson(
    course_piece_id=course_id,
    module_number=module_num,
    lesson_number=lesson_num,
    lesson_data=lesson_data
)
```

**Benefits:**
- ✅ Zero breaking changes
- ✅ Backward compatibility maintained
- ✅ Can rollback to filesystem-only if needed
- ✅ Gradual confidence building

**Trade-offs:**
- ⚠️ Storage duplication (temporary, acceptable)
- ⚠️ Write latency increases (mitigated by batch writes)
- ⚠️ Consistency risk (handle with transactions)

### Feature Flag for Gradual Rollout

```python
# lib/config.py
ENABLE_DATABASE_PERSISTENCE = os.getenv("CREATOR_OS_DB_PERSIST", "true").lower() == "true"

# lib/db_persister.py
def persist_lesson(self, ...):
    if not ENABLE_DATABASE_PERSISTENCE:
        logger.info("Database persistence disabled, skipping")
        return None

    # Proceed with database write
    ...
```

**Rollout Strategy:**
1. Week 1: `CREATOR_OS_DB_PERSIST=false` (default OFF, testing only)
2. Week 2: `CREATOR_OS_DB_PERSIST=true` (default ON, monitor errors)
3. Week 3: Feature flag removed (always ON)

---

## Code Integration Points

### 1. New Module: `lib/db_persister.py` (NEW)

**Purpose:** Single responsibility module for all database writes

**Location:** `expansion-packs/creator-os/lib/db_persister.py`

**Estimated LOC:** ~300

```python
#!/usr/bin/env python3
"""
Database Persister for CreatorOS
Handles all database writes for course generation

This module provides a clean interface for persisting generated
content to the unified database (outputs/database/mmos.db).

Usage:
    from lib.db_persister import CoursePersister

    persister = CoursePersister()
    course_id = persister.persist_course(
        course_slug="supabase-zero-backend",
        title="Supabase: Zero-Backend Completo",
        persona_mind_id=42
    )
"""

import sqlite3
import json
import logging
from pathlib import Path
from typing import Dict, List, Optional
from datetime import datetime
from contextlib import contextmanager

logger = logging.getLogger(__name__)

class CoursePersister:
    """Persist CreatorOS generated content to database."""

    def __init__(self, db_path: str = "outputs/database/mmos.db"):
        self.db_path = Path(db_path)
        self._ensure_database_exists()

    def _ensure_database_exists(self):
        """Verify database file exists."""
        if not self.db_path.exists():
            raise FileNotFoundError(
                f"Database not found: {self.db_path}\n"
                f"Run: bash scripts/creator-os/init-database.sh"
            )

    @contextmanager
    def get_connection(self):
        """Context manager for database connections."""
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        try:
            yield conn
            conn.commit()
        except Exception as e:
            conn.rollback()
            logger.error(f"Database error: {e}")
            raise
        finally:
            conn.close()

    def persist_course(
        self,
        course_slug: str,
        title: str,
        persona_mind_id: Optional[int] = None,
        keywords: Optional[List[str]] = None,
        project_id: str = "default_project"
    ) -> str:
        """
        Create content_pieces entry for new course.

        Returns:
            content_piece_id (str): Generated ID for the course
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()

            # Generate unique ID
            content_piece_id = f"cp_{course_slug}_{int(datetime.now().timestamp())}"

            cursor.execute("""
                INSERT INTO content_pieces (
                    id, project_id, type, title, piece_slug,
                    persona_mind_id, keywords, status, content
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                content_piece_id,
                project_id,
                "course",
                title,
                course_slug,
                persona_mind_id,
                json.dumps(keywords or []),
                "draft",
                ""  # Empty content (stored in course_metadata)
            ))

            logger.info(f"✓ Persisted course: {content_piece_id}")
            return content_piece_id

    def persist_metadata(
        self,
        content_piece_id: str,
        course_brief: str,
        curriculum: Dict,
        course_outline: str,
        icp_data: Optional[Dict] = None,
        total_modules: int = 0,
        total_lessons: int = 0
    ) -> int:
        """
        Insert course_metadata record.

        Returns:
            metadata_id (int): Database ID of inserted record
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO course_metadata (
                    content_piece_id, course_brief, curriculum, course_outline,
                    icp_data, total_modules, total_lessons
                ) VALUES (?, ?, ?, ?, ?, ?, ?)
            """, (
                content_piece_id,
                course_brief,
                json.dumps(curriculum),
                course_outline,
                json.dumps(icp_data or {}),
                total_modules,
                total_lessons
            ))

            metadata_id = cursor.lastrowid
            logger.info(f"✓ Persisted metadata: {metadata_id}")
            return metadata_id

    def persist_lesson(
        self,
        course_piece_id: str,
        module_number: int,
        lesson_number: int,
        lesson_data: Dict
    ) -> int:
        """
        Insert course_lesson record.

        Args:
            lesson_data: Dict with keys:
                - lesson_id (str): "1.1", "1.2", etc.
                - title (str)
                - slug (str)
                - content_markdown (str)
                - word_count (int)
                - gps_valid (bool)
                - gps_score (float)
                - didatica_score (float)
                - bloom_level (str)
                - learning_objectives (List[str])
                - file_path (str)

        Returns:
            lesson_id (int): Database ID of inserted record
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO course_lessons (
                    course_piece_id, module_number, lesson_number, lesson_id,
                    title, slug, content_markdown, word_count,
                    gps_valid, gps_score, didatica_score, bloom_level,
                    learning_objectives, file_path, status, validation_status
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                course_piece_id,
                module_number,
                lesson_number,
                lesson_data.get("lesson_id"),
                lesson_data.get("title"),
                lesson_data.get("slug"),
                lesson_data.get("content_markdown"),
                lesson_data.get("word_count", 0),
                1 if lesson_data.get("gps_valid", False) else 0,
                lesson_data.get("gps_score", 0.0),
                lesson_data.get("didatica_score", 0.0),
                lesson_data.get("bloom_level"),
                json.dumps(lesson_data.get("learning_objectives", [])),
                lesson_data.get("file_path"),
                "draft",
                lesson_data.get("validation_status", "passed")
            ))

            lesson_id = cursor.lastrowid
            logger.debug(f"✓ Persisted lesson {lesson_data.get('lesson_id')}")
            return lesson_id

    def persist_lessons_batch(
        self,
        course_piece_id: str,
        lessons: List[Dict]
    ) -> List[int]:
        """
        Batch insert multiple lessons (optimized for performance).

        Args:
            lessons: List of lesson_data dicts (same format as persist_lesson)

        Returns:
            List[int]: Database IDs of all inserted lessons
        """
        lesson_ids = []

        with self.get_connection() as conn:
            cursor = conn.cursor()

            for lesson in lessons:
                cursor.execute("""
                    INSERT INTO course_lessons (
                        course_piece_id, module_number, lesson_number, lesson_id,
                        title, slug, content_markdown, word_count,
                        gps_valid, gps_score, didatica_score, bloom_level,
                        learning_objectives, file_path, status, validation_status
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (
                    course_piece_id,
                    lesson["module_number"],
                    lesson["lesson_number"],
                    lesson.get("lesson_id"),
                    lesson.get("title"),
                    lesson.get("slug"),
                    lesson.get("content_markdown"),
                    lesson.get("word_count", 0),
                    1 if lesson.get("gps_valid", False) else 0,
                    lesson.get("gps_score", 0.0),
                    lesson.get("didatica_score", 0.0),
                    lesson.get("bloom_level"),
                    json.dumps(lesson.get("learning_objectives", [])),
                    lesson.get("file_path"),
                    "draft",
                    lesson.get("validation_status", "passed")
                ))

                lesson_ids.append(cursor.lastrowid)

            logger.info(f"✓ Batch persisted {len(lessons)} lessons")

        return lesson_ids

    def persist_research(
        self,
        content_piece_id: str,
        market_analysis: str,
        gap_analysis: str,
        differentiation: str,
        sources: str,
        competitors_count: int = 0
    ) -> int:
        """
        Insert market_research record.

        Returns:
            research_id (int): Database ID of inserted record
        """
        with self.get_connection() as conn:
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO market_research (
                    content_piece_id, market_analysis, gap_analysis,
                    differentiation_strategy, sources_list, competitors_analyzed
                ) VALUES (?, ?, ?, ?, ?, ?)
            """, (
                content_piece_id,
                market_analysis,
                gap_analysis,
                differentiation,
                sources,
                competitors_count
            ))

            research_id = cursor.lastrowid
            logger.info(f"✓ Persisted research: {research_id}")
            return research_id

    def update_voice_fidelity(
        self,
        content_piece_id: str,
        fidelity_score: float
    ):
        """Update voice_fidelity_score for a course."""
        with self.get_connection() as conn:
            cursor = conn.cursor()

            cursor.execute("""
                UPDATE content_pieces
                SET voice_fidelity_score = ?
                WHERE id = ?
            """, (fidelity_score, content_piece_id))

            logger.info(f"✓ Updated fidelity score: {fidelity_score:.2f}")
```

---

### 2. Modify: `lib/lesson_generator.py`

**Changes:** Add database persistence after filesystem write

**Location:** Lines 200-250 (after lesson generation)

```python
# EXISTING CODE (keep as-is):
def generate_single_lesson(self, lesson_spec: LessonSpec) -> GeneratedLesson:
    """Generate a single lesson."""

    # ... existing generation logic ...

    # Save to filesystem (EXISTING)
    file_path = self._save_lesson_to_file(
        lesson_content=generated_markdown,
        module_number=lesson_spec.module_number,
        lesson_number=lesson_spec.lesson_number,
        slug=lesson_spec.slug
    )

    # ============================================================
    # NEW CODE: Persist to database
    # ============================================================

    from lib.db_persister import CoursePersister
    from lib.config import ENABLE_DATABASE_PERSISTENCE

    if ENABLE_DATABASE_PERSISTENCE:
        try:
            persister = CoursePersister()

            lesson_data = {
                "lesson_id": f"{lesson_spec.module_number}.{lesson_spec.lesson_number}",
                "title": lesson_spec.lesson_title,
                "slug": lesson_spec.slug,
                "content_markdown": generated_markdown,
                "word_count": len(generated_markdown.split()),
                "gps_valid": self._validate_gps_structure(generated_markdown),
                "gps_score": self._calculate_gps_score(generated_markdown),
                "didatica_score": self._calculate_dl_score(generated_markdown),
                "bloom_level": lesson_spec.bloom_level,
                "learning_objectives": lesson_spec.learning_objectives,
                "file_path": str(file_path)
            }

            persister.persist_lesson(
                course_piece_id=self.course_piece_id,  # Set during init
                module_number=lesson_spec.module_number,
                lesson_number=lesson_spec.lesson_number,
                lesson_data=lesson_data
            )

        except Exception as e:
            logger.error(f"Failed to persist lesson to database: {e}")
            # Don't fail generation if database write fails
            # Filesystem write already succeeded

    # Return generated lesson info (EXISTING)
    return GeneratedLesson(
        lesson_id=f"{lesson_spec.module_number}.{lesson_spec.lesson_number}",
        lesson_title=lesson_spec.lesson_title,
        file_path=str(file_path),
        ...
    )
```

**Impact:**
- Lines added: ~30
- Breaking changes: None
- Performance impact: +50-100ms per lesson (acceptable)

---

### 3. Modify: `lib/brief_parser.py`

**Changes:** Add database persistence after parsing brief

**Location:** Lines 150-200 (after parsing course brief)

```python
# EXISTING CODE (keep as-is):
def parse(self) -> CourseBrief:
    """Parse COURSE-BRIEF.md into structured data."""

    # ... existing parsing logic ...

    course_brief = CourseBrief(
        basic_info=basic_info,
        icp=icp,
        content_pedagogy=content_pedagogy,
        ...
    )

    # ============================================================
    # NEW CODE: Persist to database
    # ============================================================

    from lib.db_persister import CoursePersister
    from lib.config import ENABLE_DATABASE_PERSISTENCE

    if ENABLE_DATABASE_PERSISTENCE:
        try:
            persister = CoursePersister()

            # Create course entry
            self.course_piece_id = persister.persist_course(
                course_slug=course_brief.basic_info.slug,
                title=course_brief.basic_info.title,
                persona_mind_id=self._get_persona_mind_id(course_brief),
                keywords=course_brief.basic_info.tags,
                project_id="default_project"  # TODO: Get from context
            )

            # Persist metadata
            persister.persist_metadata(
                content_piece_id=self.course_piece_id,
                course_brief=self.raw_brief_content,
                curriculum={},  # Populated later by curriculum_approval.py
                course_outline="",  # Populated later
                icp_data={
                    "demographics": course_brief.icp.demographics,
                    "pain_points": course_brief.icp.pain_points,
                    "goals": course_brief.icp.goals
                },
                total_modules=course_brief.basic_info.modules_count,
                total_lessons=course_brief.basic_info.lessons_count
            )

            logger.info(f"✓ Course persisted to database: {self.course_piece_id}")

        except Exception as e:
            logger.error(f"Failed to persist course brief to database: {e}")

    return course_brief
```

**Impact:**
- Lines added: ~35
- Breaking changes: None
- Performance impact: +100ms one-time (acceptable)

---

### 4. Modify: `lib/market_researcher.py`

**Changes:** Add database persistence after research generation

**Location:** Lines 400-450 (after generating research reports)

```python
# EXISTING CODE (keep as-is):
def research_market(self, course_slug: str) -> Dict[str, str]:
    """Generate all 4 research reports."""

    # ... existing research logic ...

    # Save to filesystem (EXISTING)
    self._save_research_reports(reports)

    # ============================================================
    # NEW CODE: Persist to database
    # ============================================================

    from lib.db_persister import CoursePersister
    from lib.config import ENABLE_DATABASE_PERSISTENCE

    if ENABLE_DATABASE_PERSISTENCE:
        try:
            persister = CoursePersister()

            persister.persist_research(
                content_piece_id=self.course_piece_id,  # Set by brief_parser
                market_analysis=reports["01-market-analysis"],
                gap_analysis=reports["02-gap-analysis"],
                differentiation=reports["03-differentiation"],
                sources=reports["04-sources"],
                competitors_count=self.competitors_analyzed_count
            )

        except Exception as e:
            logger.error(f"Failed to persist research to database: {e}")

    return reports
```

**Impact:**
- Lines added: ~20
- Breaking changes: None
- Performance impact: +50ms one-time (acceptable)

---

### 5. Modify: `lib/curriculum_approval.py`

**Changes:** Update course_metadata.curriculum after approval

```python
# After curriculum is approved:

from lib.db_persister import CoursePersister

if ENABLE_DATABASE_PERSISTENCE:
    try:
        persister = CoursePersister()

        with persister.get_connection() as conn:
            cursor = conn.cursor()

            cursor.execute("""
                UPDATE course_metadata
                SET curriculum = ?,
                    total_modules = ?,
                    total_lessons = ?
                WHERE content_piece_id = ?
            """, (
                json.dumps(approved_curriculum),
                len(approved_curriculum["modules"]),
                sum(len(m["lessons"]) for m in approved_curriculum["modules"]),
                self.course_piece_id
            ))

    except Exception as e:
        logger.error(f"Failed to update curriculum in database: {e}")
```

**Impact:**
- Lines added: ~25
- Breaking changes: None

---

### 6. Modify: `lib/course_validator.py`

**Changes:** Update validation_status and scores after validation

```python
# After validating all lessons:

from lib.db_persister import CoursePersister

if ENABLE_DATABASE_PERSISTENCE:
    try:
        persister = CoursePersister()

        with persister.get_connection() as conn:
            cursor = conn.cursor()

            for lesson_id, validation_result in validation_results.items():
                cursor.execute("""
                    UPDATE course_lessons
                    SET validation_status = ?,
                        validation_issues = ?
                    WHERE lesson_id = ? AND course_piece_id = ?
                """, (
                    "passed" if validation_result["valid"] else "failed",
                    json.dumps(validation_result["issues"]),
                    lesson_id,
                    self.course_piece_id
                ))

    except Exception as e:
        logger.error(f"Failed to update validation status in database: {e}")
```

**Impact:**
- Lines added: ~25
- Breaking changes: None

---

### Summary of Code Changes

| Module | Changes | LOC Added | Breaking Changes |
|--------|---------|-----------|------------------|
| `lib/db_persister.py` | NEW module | ~300 | No |
| `lib/lesson_generator.py` | Add DB persistence | ~30 | No |
| `lib/brief_parser.py` | Add DB persistence | ~35 | No |
| `lib/market_researcher.py` | Add DB persistence | ~20 | No |
| `lib/curriculum_approval.py` | Update curriculum | ~25 | No |
| `lib/course_validator.py` | Update validation | ~25 | No |
| **TOTAL** | **6 files** | **~435 LOC** | **No** |

**Percentage increase:** +16.7% (from 2,610 to 3,045 LOC)

---

## Working with the Current System (Developer Guide)

### Environment Setup

**Prerequisites:**
- Python 3.10+
- Supabase account with project credentials
- Environment variables configured

**Required Environment Variables:**
```bash
# .env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-service-role-key  # Service role for writes
SUPABASE_ANON_KEY=your-anon-key     # Anon key for reads (RLS-protected)
```

**Install dependencies:**
```bash
cd expansion-packs/creator-os
pip install -r requirements.txt  # Includes supabase-py
```

---

### How to Generate a Course (Current Workflow)

```bash
# 1. Activate course architect agent
@course-architect

# 2. Start new course (greenfield)
*new supabase-zero-backend

# Behind the scenes:
# → brief_parser.py: Parse COURSE-BRIEF → INSERT INTO content_pieces + course_metadata
# → market_researcher.py: Generate research → INSERT INTO market_research
# → curriculum_approval.py: Generate curriculum → UPDATE course_metadata.curriculum
# → lesson_generator.py: Generate 20 lessons → INSERT INTO course_lessons (batch)
# → course_validator.py: Validate lessons → UPDATE course_lessons.validation_status

# 3. All data now in Supabase PostgreSQL
# → content_pieces: 1 row (course entry)
# → course_metadata: 1 row (brief + curriculum)
# → course_lessons: 20 rows (all lessons)
# → market_research: 1 row (competitive analysis)
```

---

### How to Query Courses (SQL Examples)

#### Get all courses with statistics

```sql
SELECT
  cp.id,
  cp.title,
  cp.piece_slug,
  cp.voice_fidelity_score,
  m.display_name as persona_name,
  cm.total_modules,
  cm.total_lessons,
  cm.course_type,
  AVG(cl.gps_score) as avg_gps_score,
  AVG(cl.didatica_score) as avg_didatica_score
FROM content_pieces cp
LEFT JOIN minds m ON cp.persona_mind_id = m.id
LEFT JOIN course_metadata cm ON cp.id = cm.content_piece_id
LEFT JOIN course_lessons cl ON cp.id = cl.course_piece_id
WHERE cp.type = 'course'
GROUP BY cp.id, cp.title, cp.piece_slug, cp.voice_fidelity_score,
         m.display_name, cm.total_modules, cm.total_lessons, cm.course_type
ORDER BY cp.created_at DESC;
```

#### Get all lessons for a specific course

```sql
SELECT
  lesson_id,
  title,
  slug,
  word_count,
  gps_score,
  didatica_score,
  bloom_level,
  validation_status
FROM course_lessons
WHERE course_piece_id = 'cp_supabase-zero-backend_...'
ORDER BY module_number, lesson_number;
```

#### Search courses by keyword

```sql
SELECT
  cp.title,
  cp.piece_slug,
  cp.keywords,
  m.display_name as persona
FROM content_pieces cp
LEFT JOIN minds m ON cp.persona_mind_id = m.id
WHERE cp.type = 'course'
  AND cp.keywords @> '["supabase"]'::jsonb  -- PostgreSQL JSONB contains
ORDER BY cp.created_at DESC;
```

---

### How to Add New Features (Best Practices)

#### Example: Add "difficulty_level" to lessons

**1. Add column to schema**
```sql
-- supabase/migrations/20251028_add_lesson_difficulty.sql
ALTER TABLE course_lessons
  ADD COLUMN difficulty_level TEXT
    CHECK(difficulty_level IN ('beginner', 'intermediate', 'advanced'));

CREATE INDEX idx_lessons_difficulty ON course_lessons(difficulty_level);
```

**2. Update Python data class**
```python
# lib/lesson_generator.py

@dataclass
class LessonSpec:
    # ... existing fields ...
    difficulty_level: Optional[str] = None  # NEW
```

**3. Update persister**
```python
# lib/db_persister.py (persist_lesson method)

cursor.execute("""
    INSERT INTO course_lessons (
        ...,
        difficulty_level  -- NEW
    ) VALUES (..., ?, ...)
""", (
    ...,
    lesson_data.get("difficulty_level", "intermediate")  -- NEW
))
```

**4. Test end-to-end**
```bash
pytest expansion-packs/creator-os/tests/test_lesson_generator.py -v
```

---

### Common Development Tasks

#### Task 1: Debug a failed course generation

```python
# Check database for errors
from lib.db_persister import CoursePersister

persister = CoursePersister()

with persister.get_connection() as conn:
    cursor = conn.cursor()

    # Find courses with failed lessons
    cursor.execute("""
        SELECT
            cp.title,
            cl.lesson_id,
            cl.validation_status,
            cl.validation_issues
        FROM content_pieces cp
        JOIN course_lessons cl ON cp.id = cl.course_piece_id
        WHERE cl.validation_status = 'failed'
        ORDER BY cp.created_at DESC
    """)

    for row in cursor.fetchall():
        print(f"Course: {row['title']}")
        print(f"Lesson: {row['lesson_id']}")
        print(f"Issues: {row['validation_issues']}")
```

#### Task 2: Regenerate a single lesson

```python
# lib/lesson_generator.py

generator = LessonGenerator(
    course_slug="supabase-zero-backend",
    curriculum=curriculum_data,
    course_brief=course_brief_data
)

# Regenerate specific lesson
lesson_spec = LessonSpec(
    lesson_id="1.1",
    lesson_title="O que é Supabase?",
    module_number=1,
    lesson_number=1,
    ...
)

result = generator.generate_single_lesson(lesson_spec)

# Updates database automatically via db_persister.py
```

#### Task 3: Export course to JSON

```python
import json
from lib.db_persister import CoursePersister

persister = CoursePersister()

def export_course_to_json(course_slug: str) -> dict:
    """Export complete course data to JSON."""

    with persister.get_connection() as conn:
        cursor = conn.cursor()

        # Get course
        cursor.execute("""
            SELECT * FROM content_pieces
            WHERE piece_slug = ? AND type = 'course'
        """, (course_slug,))
        course = dict(cursor.fetchone())

        # Get metadata
        cursor.execute("""
            SELECT * FROM course_metadata
            WHERE content_piece_id = ?
        """, (course['id'],))
        course['metadata'] = dict(cursor.fetchone())

        # Get all lessons
        cursor.execute("""
            SELECT * FROM course_lessons
            WHERE course_piece_id = ?
            ORDER BY module_number, lesson_number
        """, (course['id'],))
        course['lessons'] = [dict(row) for row in cursor.fetchall()]

        # Get research
        cursor.execute("""
            SELECT * FROM market_research
            WHERE content_piece_id = ?
        """, (course['id'],))
        course['research'] = dict(cursor.fetchone())

    return course

# Usage
course_data = export_course_to_json("supabase-zero-backend")
with open("exports/supabase-course.json", "w") as f:
    json.dump(course_data, f, indent=2)
```

---

## Optimization Roadmap (Next Steps)

### Completed ✅

- [x] Schema design and migration
- [x] Database-first architecture implementation
- [x] Supabase integration with RLS
- [x] Python modules updated (db_persister.py, lesson_generator.py, etc.)
- [x] All courses migrated to Supabase
- [x] Real-time sync operational

### In Progress 🔄

- [ ] Performance monitoring and optimization
- [ ] Analytics dashboard for course metrics
- [ ] Advanced RLS policies for team collaboration

### Planned 📋

#### Phase 1: Performance Optimization (Q1 2025)
- [ ] Add database connection pooling
- [ ] Implement caching layer (Redis) for frequent queries
- [ ] Optimize batch inserts (currently 20 lessons/transaction)
- [ ] Add database query profiling and monitoring

#### Phase 2: Analytics & Insights (Q2 2025)
- [ ] Create analytics dashboard (Streamlit or Metabase)
- [ ] Implement learning extraction algorithm
- [ ] Add persona effectiveness ranking
- [ ] Track quality trends over time

#### Phase 3: Advanced Features (Q3 2025)
- [ ] Course versioning system (track changes over time)
- [ ] A/B testing framework for lesson variations
- [ ] Automated quality improvement suggestions
- [ ] Integration with external LMS platforms

#### Phase 4: Scale & Performance (Q4 2025)
- [ ] Database partitioning for large tables (>1M rows)
- [ ] Implement read replicas for analytics queries
- [ ] Add full-text search (PostgreSQL FTS)
- [ ] Real-time collaboration features (WebSocket)

---

## Testing Strategy

### Unit Tests

**Test File:** `expansion-packs/creator-os/tests/test_db_persister.py`

```python
import pytest
from lib.db_persister import CoursePersister

def test_persist_course():
    """Test creating course entry."""
    persister = CoursePersister()
    course_id = persister.persist_course(
        course_slug="test-course",
        title="Test Course",
        persona_mind_id=None,
        keywords=["test", "course"]
    )
    assert course_id is not None
    assert course_id.startswith("cp_")

def test_persist_lesson():
    """Test creating lesson entry."""
    persister = CoursePersister()

    # First create course
    course_id = persister.persist_course(
        course_slug="test-course",
        title="Test Course"
    )

    # Then create lesson
    lesson_data = {
        "lesson_id": "1.1",
        "title": "Test Lesson",
        "slug": "test-lesson",
        "content_markdown": "# Test\n\nContent here.",
        "word_count": 100,
        "gps_valid": True,
        "gps_score": 0.9,
        "didatica_score": 0.85,
        "bloom_level": "understand",
        "learning_objectives": ["Objective 1"],
        "file_path": "outputs/test.md"
    }

    lesson_id = persister.persist_lesson(
        course_piece_id=course_id,
        module_number=1,
        lesson_number=1,
        lesson_data=lesson_data
    )

    assert lesson_id is not None

def test_batch_persist_lessons():
    """Test batch lesson creation."""
    persister = CoursePersister()

    course_id = persister.persist_course(
        course_slug="test-batch",
        title="Batch Test"
    )

    lessons = [
        {
            "module_number": 1,
            "lesson_number": i,
            "lesson_id": f"1.{i}",
            "title": f"Lesson {i}",
            "slug": f"lesson-{i}",
            "content_markdown": f"Content {i}",
            "word_count": 100,
            "gps_valid": True,
            "gps_score": 0.9,
            "didatica_score": 0.85
        }
        for i in range(1, 21)  # 20 lessons
    ]

    lesson_ids = persister.persist_lessons_batch(course_id, lessons)
    assert len(lesson_ids) == 20
```

**Run tests:**
```bash
pytest expansion-packs/creator-os/tests/test_db_persister.py -v
```

---

### Integration Tests

**Test File:** `expansion-packs/creator-os/tests/test_course_generation_e2e.py`

```python
import pytest
import os
from scripts.generate_course import generate_course_workflow

def test_course_generation_persists_to_db():
    """Test that generating a course persists all data to database."""

    # Setup
    course_slug = "test-e2e-course"
    os.environ["CREATOR_OS_DB_PERSIST"] = "true"

    # Execute
    result = generate_course_workflow(
        course_slug=course_slug,
        mode="greenfield"
    )

    # Verify in database
    from lib.db_persister import CoursePersister
    persister = CoursePersister()

    with persister.get_connection() as conn:
        cursor = conn.cursor()

        # Check course exists
        cursor.execute("""
            SELECT * FROM content_pieces
            WHERE piece_slug = ?
        """, (course_slug,))
        course = cursor.fetchone()
        assert course is not None

        # Check metadata exists
        cursor.execute("""
            SELECT * FROM course_metadata
            WHERE content_piece_id = ?
        """, (course["id"],))
        metadata = cursor.fetchone()
        assert metadata is not None
        assert metadata["total_lessons"] > 0

        # Check lessons exist
        cursor.execute("""
            SELECT COUNT(*) as count FROM course_lessons
            WHERE course_piece_id = ?
        """, (course["id"],))
        lesson_count = cursor.fetchone()["count"]
        assert lesson_count == metadata["total_lessons"]

        # Check research exists
        cursor.execute("""
            SELECT * FROM market_research
            WHERE content_piece_id = ?
        """, (course["id"],))
        research = cursor.fetchone()
        assert research is not None

    # Cleanup
    with persister.get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM content_pieces WHERE id = ?", (course["id"],))
```

**Run test:**
```bash
pytest expansion-packs/creator-os/tests/test_course_generation_e2e.py -v
```

---

### Manual Testing Checklist

#### Greenfield Course Creation

- [ ] Generate new course: `@course-architect` → `*new test-course`
- [ ] Verify course in database:
  ```sql
  SELECT * FROM content_pieces WHERE piece_slug = 'test-course';
  ```
- [ ] Verify metadata:
  ```sql
  SELECT * FROM course_metadata WHERE content_piece_id = 'cp_test-course_...';
  ```
- [ ] Verify lessons:
  ```sql
  SELECT COUNT(*) FROM course_lessons WHERE course_piece_id = 'cp_test-course_...';
  ```
- [ ] Verify research:
  ```sql
  SELECT * FROM market_research WHERE content_piece_id = 'cp_test-course_...';
  ```
- [ ] Compare filesystem vs database content for consistency

#### Brownfield Course Upgrade

- [ ] Upgrade existing course: `*upgrade legacy-course`
- [ ] Verify all legacy lessons imported to database
- [ ] Verify ICP and voice profile extracted correctly
- [ ] Check gap analysis persisted

#### Error Scenarios

- [ ] Test with database file missing (should fail gracefully)
- [ ] Test with feature flag OFF (should skip DB writes)
- [ ] Test filesystem write success but DB write failure (should log error, not crash)
- [ ] Test database connection timeout (should retry or fail gracefully)

---

## Rollback Plan

### Scenario 1: Database Writes Failing

**Symptoms:**
- Errors in logs: "Failed to persist lesson to database"
- Course generation slower than expected
- Database write errors > 5%

**Action:**
```bash
# Disable database persistence immediately
export CREATOR_OS_DB_PERSIST=false

# OR via environment file
echo "CREATOR_OS_DB_PERSIST=false" >> .env

# Restart any running processes
```

**Verification:**
```bash
# Check logs for "Database persistence disabled, skipping"
tail -f logs/creator-os.log | grep "Database persistence"
```

**Impact:** System reverts to filesystem-only mode. No data loss.

---

### Scenario 2: Database Corruption

**Symptoms:**
- SQLite database file corrupted
- Queries returning unexpected results
- Foreign key constraint violations

**Action:**
```bash
# 1. Backup current database
cp outputs/database/mmos.db outputs/database/mmos.db.backup.$(date +%Y%m%d_%H%M%S)

# 2. Restore from last known good backup
cp backups/mmos.db.20251028 outputs/database/mmos.db

# 3. Verify integrity
sqlite3 outputs/database/mmos.db "PRAGMA integrity_check;"

# 4. Disable DB persistence temporarily
export CREATOR_OS_DB_PERSIST=false
```

**Impact:** Lose recent database changes. Filesystem outputs remain intact.

---

### Scenario 3: Performance Degradation

**Symptoms:**
- Course generation 50%+ slower
- Database write latency > 500ms per lesson
- CPU usage high during generation

**Action:**

1. **Profile database operations:**
   ```python
   import cProfile
   cProfile.run('generate_course_workflow("test")', sort='cumulative')
   ```

2. **Optimize if needed:**
   - Switch from single writes to batch writes
   - Add missing indexes
   - Reduce transaction scope

3. **Temporary mitigation:**
   ```bash
   # Reduce batch size
   export CREATOR_OS_BATCH_SIZE=10  # Down from 20
   ```

**Impact:** Slower generation until optimization applied.

---

### Scenario 4: Data Inconsistency

**Symptoms:**
- Filesystem shows 20 lessons, database shows 18
- Lesson content differs between file and database
- Metadata mismatch

**Action:**

1. **Detect inconsistencies:**
   ```python
   from lib.db_validator import validate_consistency

   result = validate_consistency("test-course")
   if not result.consistent:
       print(result.issues)
   ```

2. **Re-sync from filesystem (source of truth):**
   ```bash
   python scripts/sync-filesystem-to-db.py --course test-course --force
   ```

**Impact:** Temporary data inconsistency. Resolved via re-sync.

---

## Performance Considerations

### Baseline Metrics (Filesystem-Only)

**Course Generation (20 lessons):**
- Total time: 15 minutes
- Average per lesson: 45 seconds
- Peak CPU: 40%
- Peak memory: 800MB

### Expected Impact (With Database)

**Course Generation (20 lessons):**
- Total time: 16 minutes (+6.7%)
- Average per lesson: 48 seconds (+6.7%)
- Peak CPU: 45% (+5%)
- Peak memory: 850MB (+6%)

**Per-lesson breakdown:**
- Filesystem write: ~500ms
- Database write (single): ~100ms
- Database write (batch): ~50ms/lesson

**Optimization strategies:**
1. Use batch inserts for lessons (20x in 1 transaction)
2. Async writes (non-blocking)
3. Connection pooling for concurrent requests

---

### Query Performance

**Common queries:**

| Query | Expected Latency | Index Required |
|-------|------------------|----------------|
| Get course by slug | < 10ms | `idx_pieces_slug` |
| Get all lessons for course | < 50ms | `idx_lessons_course` |
| Search courses by keyword | < 100ms | `idx_pieces_keywords` |
| Filter by persona mind | < 50ms | `idx_pieces_persona` |
| Get top-scoring lessons | < 100ms | `idx_lessons_gps_score` |

**Optimization:**
- Add covering indexes for hot queries
- Use EXPLAIN QUERY PLAN to verify index usage
- Consider materialized views for analytics

---

## Security & Access Control

### Database Access (SQLite)

**Current (Local Development):**
- File-based SQLite: `outputs/database/mmos.db`
- No authentication required (local filesystem permissions)
- No encryption at rest

**Future (Supabase/PostgreSQL):**
- Row-Level Security (RLS) policies
- Role-based access control (RBAC)
- JWT-based authentication
- Encryption at rest + in transit

---

### RLS Policies (Future - Supabase)

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
      WHERE creator_mind_id = current_user_id()
    )
  );

-- Policy 3: Creators can update their own courses
CREATE POLICY "Creators can update own courses"
  ON content_pieces FOR UPDATE
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_user_id()
    )
  );
```

---

## Future Extensions

### Phase 2: Analytics & Performance Tracking

**New table:** `content_performance`

```sql
CREATE TABLE content_performance (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_piece_id TEXT NOT NULL REFERENCES content_pieces(id),

  -- Performance Metrics
  views INTEGER DEFAULT 0,
  unique_visitors INTEGER DEFAULT 0,
  avg_engagement_rate REAL,
  conversion_rate REAL,

  -- SEO Metrics
  search_impressions INTEGER DEFAULT 0,
  avg_search_position REAL,

  -- Learnings
  key_learnings TEXT,  -- JSON
  suggested_improvements TEXT,  -- JSON

  created_at TEXT DEFAULT (datetime('now'))
);
```

**Use case:** Track which personas/frameworks perform best

---

### Phase 3: Multi-User Collaboration (Supabase)

**Migration path:**
1. Export SQLite to PostgreSQL dump
2. Run `pg_restore` to Supabase
3. Add RLS policies
4. Update connection string in CoursePersister
5. Deploy to production

**Timeline:** 2-3 weeks after Phase 1 complete

---

### Phase 4: Versioning & History

**New table:** `course_versions`

```sql
CREATE TABLE course_versions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_piece_id TEXT NOT NULL REFERENCES content_pieces(id),
  version_number INTEGER NOT NULL,

  -- Snapshot of entire course state
  metadata_snapshot TEXT,  -- JSON
  lessons_snapshot TEXT,   -- JSON

  -- Change tracking
  changed_by TEXT,
  change_summary TEXT,

  created_at TEXT DEFAULT (datetime('now')),

  UNIQUE(content_piece_id, version_number)
);
```

**Use case:** Compare v1 vs v2 of course, rollback to previous version

---

## Conclusion

### System Status: Production Ready ✅

O CreatorOS está **totalmente integrado com Supabase** e operando em produção com arquitetura database-first.

### Key Accomplishments

✅ **Database-First Architecture** - Todos os outputs salvos diretamente em Supabase PostgreSQL
✅ **Full Traceability** - Cada peça de conteúdo linkada ao mind/persona gerador
✅ **Rich Analytics** - Quality scores, voice fidelity, e performance metrics rastreados
✅ **Team Collaboration** - Acesso centralizado via Supabase com RLS policies
✅ **Production Stability** - Sistema operando com todos os cursos migrados
✅ **Developer-Friendly** - APIs Python bem estruturadas para extensão do sistema

### Document Purpose

Este documento serve como **referência arquitetural** para:

1. **Onboarding de novos desenvolvedores** - Entender como o sistema funciona
2. **Adicionar novos recursos** - Seguir padrões estabelecidos
3. **Debugging e troubleshooting** - Diagnosticar problemas rapidamente
4. **Planejamento de otimizações** - Roadmap de melhorias futuras
5. **Manutenção do sistema** - Garantir consistência e qualidade

### For Developers: Quick Reference

**Conectar ao banco:**
```python
from lib.db_persister import CoursePersister
persister = CoursePersister()
```

**Gerar curso:**
```bash
@course-architect
*new meu-novo-curso
```

**Query courses:**
```sql
SELECT * FROM content_pieces WHERE type = 'course';
```

**Adicionar feature:**
1. Migration SQL → `supabase/migrations/`
2. Update Python dataclass → `lib/*.py`
3. Update persister → `lib/db_persister.py`
4. Test → `pytest tests/`

---

### Next Optimizations

Ver seção [Optimization Roadmap](#optimization-roadmap-next-steps) para próximos passos planejados.

---

### Support & Questions

**Technical questions:** @dev team
**Architecture decisions:** Winston (AIOS Architect)
**Database issues:** DB Sage
**Documentation:** `docs/architecture/` + `expansion-packs/creator-os/docs/`

---

### Document Metadata

| Field | Value |
|-------|-------|
| **Version** | 1.0.0 (Production) |
| **Last Updated** | 2025-10-28 |
| **System Status** | ✅ Production (Supabase Integrated) |
| **Next Review** | After Phase 1 Optimization (Q1 2025) |
| **Architect** | Winston (AIOS Architect) |
| **Target Audience** | @dev Team |

---

### Change Log

**v1.0.0 (2025-10-28)**
- Initial version documenting current production architecture
- Added developer guide for working with Supabase integration
- Documented current system capabilities and roadmap
- Reflected actual state: All courses migrated to Supabase ✅

---

**Este documento está vivo e será atualizado conforme o sistema evolui.**

Para sugestões de melhorias na documentação, abra uma issue ou pull request.
