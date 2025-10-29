# Story: CreatorOS Database Integration - Supabase Persistence

**Epic:** CreatorOS - Database Integration
**Status:** Draft
**Story Points:** 13
**Priority:** P0 (Critical)
**Created:** 2025-10-28
**Assigned:** @dev

---

## Description

As a **course creator using CreatorOS**, I want **all generated course outputs (lessons, briefs, research, curriculum) to be automatically persisted to Supabase PostgreSQL** so that:

1. ✅ **Team can collaborate** - Centralized database access instead of local files
2. ✅ **Content is traceable** - Every piece linked to generating mind/persona
3. ✅ **Analytics are possible** - Track quality scores, voice fidelity, performance
4. ✅ **System scales** - Database queries vs filesystem limitations
5. ✅ **Data is secure** - RLS policies, backups, multi-user access control

**Current State:** CreatorOS saves all outputs to `outputs/courses/{slug}/` (filesystem only). No database integration exists.

**Desired State:** CreatorOS persists ALL outputs to Supabase PostgreSQL in real-time while maintaining filesystem outputs for backward compatibility (dual-write pattern).

---

## Acceptance Criteria

### Database Schema

- [ ] **AC1**: Supabase migration created with 5 tables:
  - `content_pieces` (extended with CreatorOS columns)
  - `course_metadata` (new table for briefs/curriculum)
  - `course_lessons` (new table for all lessons 1:N)
  - `market_research` (new table for competitive analysis)
  - `content_performance` (new table for analytics - future)

- [ ] **AC2**: All foreign keys, indexes, and constraints are properly defined
- [ ] **AC3**: Migration executes successfully on Supabase without errors
- [ ] **AC4**: Schema documented in `supabase/migrations/README.md`

### Python Integration

- [ ] **AC5**: `lib/db_persister.py` module created with clean API for all database writes
- [ ] **AC6**: `lesson_generator.py` integrated to persist lessons after generation
- [ ] **AC7**: `brief_parser.py` integrated to persist course + metadata after parsing
- [ ] **AC8**: `market_researcher.py` integrated to persist research after generation
- [ ] **AC9**: `curriculum_approval.py` integrated to update curriculum in database
- [ ] **AC10**: `course_validator.py` integrated to update validation status/scores

### Data Consistency

- [ ] **AC11**: Dual-write pattern implemented (database + filesystem both updated)
- [ ] **AC12**: All database writes wrapped in transactions for consistency
- [ ] **AC13**: Error handling ensures filesystem write succeeds even if DB write fails

### Testing

- [ ] **AC14**: Unit tests for `db_persister.py` (all methods covered)
- [ ] **AC15**: Integration test: Generate complete course end-to-end, verify all data in database
- [ ] **AC16**: Integration test: Verify filesystem outputs match database content
- [ ] **AC17**: Performance test: Measure generation time impact (<10% overhead acceptable)

### Configuration

- [ ] **AC18**: Environment variables documented (SUPABASE_URL, SUPABASE_KEY)
- [ ] **AC19**: Feature flag `CREATOR_OS_DB_PERSIST` for gradual rollout
- [ ] **AC20**: Connection pooling configured for production use

---

## Tasks

### Task 1: Create Supabase Migration (2 points)

- [ ] **1.1**: Create migration file `supabase/migrations/20251028_creator_os_integration.sql`
- [ ] **1.2**: Define `content_pieces` extensions (add: piece_slug, persona_mind_id, keywords, status)
- [ ] **1.3**: Define `course_metadata` table (brief, curriculum, outline, ICP, objectives, stats)
- [ ] **1.4**: Define `course_lessons` table (module/lesson numbers, content, quality scores, validation)
- [ ] **1.5**: Define `market_research` table (4 reports, summary, competitors count)
- [ ] **1.6**: Define `content_performance` table (views, engagement, conversions - structure only)
- [ ] **1.7**: Add all foreign keys (ON DELETE CASCADE)
- [ ] **1.8**: Add all indexes (course queries, lesson lookups, persona filters, keyword search)
- [ ] **1.9**: Add check constraints (scores 0-1, status enums, validation rules)
- [ ] **1.10**: Test migration on local Supabase instance
- [ ] **1.11**: Execute migration on production Supabase
- [ ] **1.12**: Verify all tables created with `scripts/check_schema_simple.py`

### Task 2: Create Database Persister Module (3 points)

- [ ] **2.1**: Create `expansion-packs/creator-os/lib/db_persister.py`
- [ ] **2.2**: Implement `CoursePersister` class with Supabase client initialization
- [ ] **2.3**: Implement `persist_course()` method (insert into content_pieces)
- [ ] **2.4**: Implement `persist_metadata()` method (insert into course_metadata)
- [ ] **2.5**: Implement `persist_lesson()` method (insert single lesson)
- [ ] **2.6**: Implement `persist_lessons_batch()` method (batch insert 20+ lessons)
- [ ] **2.7**: Implement `persist_research()` method (insert market research)
- [ ] **2.8**: Implement `update_voice_fidelity()` method (update score after validation)
- [ ] **2.9**: Implement `update_lesson_validation()` method (update status + issues)
- [ ] **2.10**: Add comprehensive error handling with logging
- [ ] **2.11**: Add context manager for connection management
- [ ] **2.12**: Add feature flag check (`CREATOR_OS_DB_PERSIST`)
- [ ] **2.13**: Document all methods with docstrings (Google style)

### Task 3: Integrate lesson_generator.py (2 points)

- [ ] **3.1**: Import `db_persister.py` in `lesson_generator.py`
- [ ] **3.2**: Add `course_piece_id` attribute to `LessonGenerator` class
- [ ] **3.3**: After filesystem write in `generate_single_lesson()`, add database persist call
- [ ] **3.4**: Construct `lesson_data` dict with all required fields (title, slug, content, scores, etc.)
- [ ] **3.5**: Handle database write errors gracefully (log error, don't fail generation)
- [ ] **3.6**: Update `generate_all_lessons()` to use batch persist for performance
- [ ] **3.7**: Test: Generate single lesson, verify both filesystem + database
- [ ] **3.8**: Test: Generate 20 lessons, verify batch insert performance

### Task 4: Integrate brief_parser.py (1 point)

- [ ] **4.1**: Import `db_persister.py` in `brief_parser.py`
- [ ] **4.2**: After parsing brief in `parse()` method, add database persist calls
- [ ] **4.3**: Call `persist_course()` with course slug, title, persona_mind_id, keywords
- [ ] **4.4**: Call `persist_metadata()` with brief content, empty curriculum, ICP data, totals
- [ ] **4.5**: Store returned `course_piece_id` for use by other modules
- [ ] **4.6**: Handle errors gracefully
- [ ] **4.7**: Test: Parse brief, verify database entries created

### Task 5: Integrate market_researcher.py (1 point)

- [ ] **5.1**: Import `db_persister.py` in `market_researcher.py`
- [ ] **5.2**: After generating all 4 research reports, add `persist_research()` call
- [ ] **5.3**: Pass all report contents + competitors count
- [ ] **5.4**: Handle errors gracefully
- [ ] **5.5**: Test: Generate research, verify database entry

### Task 6: Integrate curriculum_approval.py (1 point)

- [ ] **6.1**: Import `db_persister.py` in `curriculum_approval.py`
- [ ] **6.2**: After curriculum approval, add database UPDATE call
- [ ] **6.3**: Update `course_metadata.curriculum` JSON field
- [ ] **6.4**: Update `total_modules` and `total_lessons` counts
- [ ] **6.5**: Handle errors gracefully
- [ ] **6.6**: Test: Approve curriculum, verify database updated

### Task 7: Integrate course_validator.py (1 point)

- [ ] **7.1**: Import `db_persister.py` in `course_validator.py`
- [ ] **7.2**: After validating each lesson, add database UPDATE call
- [ ] **7.3**: Update `course_lessons.validation_status` and `validation_issues`
- [ ] **7.4**: Update `gps_score` and `didatica_score` if calculated
- [ ] **7.5**: After validating full course, update `content_pieces.voice_fidelity_score`
- [ ] **7.6**: Handle errors gracefully
- [ ] **7.7**: Test: Validate course, verify all scores updated in database

### Task 8: Create Unit Tests (1 point)

- [ ] **8.1**: Create `expansion-packs/creator-os/tests/test_db_persister.py`
- [ ] **8.2**: Test `persist_course()` - verify row inserted
- [ ] **8.3**: Test `persist_metadata()` - verify metadata saved
- [ ] **8.4**: Test `persist_lesson()` - verify lesson saved with all fields
- [ ] **8.5**: Test `persist_lessons_batch()` - verify 20 lessons inserted in 1 transaction
- [ ] **8.6**: Test `persist_research()` - verify research saved
- [ ] **8.7**: Test error handling - database connection failure
- [ ] **8.8**: Test feature flag - persistence skipped when flag OFF
- [ ] **8.9**: Run all tests: `pytest expansion-packs/creator-os/tests/test_db_persister.py -v`

### Task 9: Create Integration Tests (1 point)

- [ ] **9.1**: Create `expansion-packs/creator-os/tests/test_course_generation_e2e.py`
- [ ] **9.2**: Test: Generate complete greenfield course, verify all database tables populated
- [ ] **9.3**: Test: Verify filesystem outputs exist and match database content
- [ ] **9.4**: Test: Query course by slug, verify all relationships (lessons, metadata, research)
- [ ] **9.5**: Test: Measure generation time with/without database (performance baseline)
- [ ] **9.6**: Test: Simulate database write failure, verify filesystem still works
- [ ] **9.7**: Run all integration tests: `pytest expansion-packs/creator-os/tests/test_course_generation_e2e.py -v`

### Task 10: Documentation & Configuration (1 point)

- [ ] **10.1**: Update `expansion-packs/creator-os/README.md` with database integration section
- [ ] **10.2**: Document environment variables in `.env.example`
- [ ] **10.3**: Document feature flag usage in `docs/architecture/creator-os-database-integration-brownfield.md`
- [ ] **10.4**: Create `supabase/migrations/README.md` with migration instructions
- [ ] **10.5**: Add connection pooling configuration example
- [ ] **10.6**: Add troubleshooting section for common database errors
- [ ] **10.7**: Update Winston's architecture doc with "Implementation Status: Complete ✅"

---

## Dev Notes

### Implementation Order

**CRITICAL:** Follow this exact order to avoid dependency issues:

1. **Migration first** (Task 1) - Database schema must exist before code integration
2. **Persister module** (Task 2) - Core API for all database writes
3. **Brief parser integration** (Task 4) - Creates course entry (needed by others)
4. **Other integrations** (Tasks 3, 5, 6, 7) - Order doesn't matter after brief parser
5. **Tests** (Tasks 8, 9) - After all integration complete
6. **Documentation** (Task 10) - Final step

### Dual-Write Pattern Details

```python
# In each module, follow this pattern:

# 1. Generate/process content (existing code)
lesson_content = generate_lesson(...)

# 2. Save to filesystem (existing code - keep as-is)
file_path = save_to_file(lesson_content, "outputs/courses/...")

# 3. Save to database (NEW code)
if ENABLE_DATABASE_PERSISTENCE:
    try:
        persister = CoursePersister()
        persister.persist_lesson(course_piece_id, lesson_data)
    except Exception as e:
        logger.error(f"Database write failed: {e}")
        # Don't fail - filesystem write succeeded
```

### Performance Considerations

- **Batch writes:** Use `persist_lessons_batch()` for 20+ lessons (1 transaction)
- **Connection pooling:** Configure Supabase client with connection pool
- **Async writes:** Consider async database writes in future (Phase 2)
- **Acceptable overhead:** <10% increase in total generation time

### Error Handling Strategy

- **Database write failure:** Log error, continue (filesystem is source of truth)
- **Connection timeout:** Retry once with exponential backoff
- **Schema mismatch:** Fail fast with clear error message
- **Transaction rollback:** Ensure partial writes don't corrupt database

### Feature Flag

```bash
# .env
CREATOR_OS_DB_PERSIST=true  # Enable database persistence (default: false)
```

**Rollout strategy:**
- Week 1: `false` (test mode only)
- Week 2: `true` (production for new courses)
- Week 3: Always on (remove flag)

---

## Testing

### Unit Test Coverage

Target: **95%+ coverage** for `db_persister.py`

```bash
pytest expansion-packs/creator-os/tests/test_db_persister.py --cov=lib.db_persister --cov-report=html
```

### Integration Test Scenarios

1. **Happy path:** Generate complete course, verify all data in database
2. **Error handling:** Simulate database failure, verify filesystem fallback
3. **Performance:** Measure overhead (<10% acceptable)
4. **Data consistency:** Compare filesystem vs database content (must match)
5. **Batch performance:** Generate 20 lessons, measure batch insert time

### Manual Testing Checklist

- [ ] Generate greenfield course with database persistence ON
- [ ] Verify course in `content_pieces` table
- [ ] Verify metadata in `course_metadata` table
- [ ] Verify 20+ lessons in `course_lessons` table
- [ ] Verify research in `market_research` table
- [ ] Query course by slug, verify all data correct
- [ ] Generate course with database persistence OFF, verify filesystem-only still works
- [ ] Simulate database connection failure, verify generation completes via filesystem

---

## Definition of Done

- [ ] All tasks marked complete with [x]
- [ ] All acceptance criteria verified ✅
- [ ] Unit tests pass with 95%+ coverage
- [ ] Integration tests pass (all scenarios)
- [ ] Manual testing checklist complete
- [ ] Documentation updated (README, architecture doc, migration guide)
- [ ] Code reviewed by peer
- [ ] Deployed to staging and tested
- [ ] Performance baseline established (<10% overhead)
- [ ] Ready for production rollout

---

## Dependencies

**Blockers:**
- None (greenfield implementation)

**Required:**
- Supabase account with project credentials
- Environment variables configured (SUPABASE_URL, SUPABASE_KEY)
- Python packages: `supabase-py` (install via `pip install supabase`)

**Downstream impact:**
- Future: Analytics dashboard can query `content_performance` table
- Future: Multi-user collaboration via RLS policies
- Future: Course versioning system

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Database write failures | Medium | Medium | Feature flag + dual-write pattern (filesystem fallback) |
| Performance degradation | Low | Medium | Batch writes + connection pooling + monitoring |
| Schema migration errors | Low | High | Test migration on staging first + rollback plan |
| Data inconsistency | Low | High | Transactions + validation tests + consistency checks |

---

## Estimated Effort

**Story Points:** 13 points

**Breakdown:**
- Task 1 (Migration): 2 points (4 hours)
- Task 2 (Persister): 3 points (6 hours)
- Task 3 (lesson_generator): 2 points (4 hours)
- Tasks 4-7 (Integrations): 4 points (8 hours)
- Tasks 8-9 (Tests): 2 points (4 hours)
- Task 10 (Docs): 1 point (2 hours)

**Total:** ~28 hours (3.5 days for 1 developer)

---

## Success Metrics

**Functional:**
- ✅ 100% of new courses persisted to Supabase
- ✅ 0 data loss incidents
- ✅ Filesystem outputs still generated (backward compat)

**Performance:**
- ✅ <10% overhead in total generation time
- ✅ Batch insert for 20 lessons <500ms
- ✅ Database write errors <1%

**Quality:**
- ✅ 95%+ test coverage for new code
- ✅ All integration tests pass
- ✅ No regressions in existing functionality

---

## File List

Files to be created/modified:

**Created:**
- `supabase/migrations/20251028_creator_os_integration.sql`
- `expansion-packs/creator-os/lib/db_persister.py`
- `expansion-packs/creator-os/tests/test_db_persister.py`
- `expansion-packs/creator-os/tests/test_course_generation_e2e.py`
- `supabase/migrations/README.md`
- `.env.example` (if doesn't exist)

**Modified:**
- `expansion-packs/creator-os/lib/lesson_generator.py`
- `expansion-packs/creator-os/lib/brief_parser.py`
- `expansion-packs/creator-os/lib/market_researcher.py`
- `expansion-packs/creator-os/lib/curriculum_approval.py`
- `expansion-packs/creator-os/lib/course_validator.py`
- `expansion-packs/creator-os/README.md`
- `docs/architecture/creator-os-database-integration-brownfield.md`
- `expansion-packs/creator-os/requirements.txt` (add supabase-py)

---

## Change Log

**2025-10-28:**
- Story created based on architecture doc + schema verification
- Confirmed: No database integration exists (0/5 tables found)
- Confirmed: All code currently filesystem-only
- Story points estimated: 13 points (28 hours)

---

## Agent Model Used

**Planning:** claude-sonnet-4-5 (Winston - Architect + James - Dev)

---

**Status:** Draft → Ready for Review

---

**Next Action:** Review story with stakeholder, approve, then assign to @dev for implementation.
