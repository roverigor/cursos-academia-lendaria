# Story 4.1: Emulator Agent - Database Integration (Path-Free Clone Loading)

**Epic:** 4 - Database-First Architecture
**Status:** 📋 PLANNED
**Priority:** Medium (eliminates path security risks)
**Estimated Effort:** 4-6 days

---

## User Story

**As a** Mind Clone Emulator operator,
**I want** to load cognitive clones directly from the database instead of file paths,
**so that** I eliminate path traversal security risks and gain access to advanced features like versioning, caching, and cross-mind analytics.

---

## Context

### Current State (Path-Based Loading)
The **emulator agent** (created in expansion pack creation workflow) currently:
- ✅ Loads system-prompts from `outputs/minds/<mind-name>/system-prompt.md`
- ✅ Loads KB from `outputs/minds/<mind-name>/kb/` directory
- ✅ Validates paths against traversal attacks (`.`, `..`, `~`)
- ✅ Enforces 20k token limit on KB
- ❌ **Security Risk**: Still vulnerable to sophisticated path manipulations
- ❌ **No Versioning**: Can't load specific system-prompt versions
- ❌ **No Caching**: Re-reads files on every activation (slow)
- ❌ **No Analytics**: Can't track which clones are most used

### Desired State (Database-First)
- ✅ Query minds from `mmos.db` via mind_id (no paths exposed)
- ✅ Load system-prompts via version_id (explicit versioning)
- ✅ Load KB fragments via fragment_id (structured, cacheable)
- ✅ Cache loaded clones in memory (sub-50ms activation)
- ✅ Track activation analytics (most used clones, avg session duration)
- ✅ **Zero path security risks** (all queries via database)
- ✅ **Backward compatible** (fallback to path-based if DB unavailable)

---

## Business Value

**Security**:
- Eliminate all path traversal attack vectors
- Centralized access control via database
- Audit trail of all clone activations

**Performance**:
- Sub-50ms clone activation (vs ~500ms file I/O)
- Memory caching reduces repeated DB queries
- Parallel loading of KB fragments

**Features**:
- Explicit version loading: `*activate nassim_taleb --version 2.3`
- Clone comparison: `*compare nassim_taleb naval_ravikant`
- Usage analytics: `*stats --all-minds`
- Rollback to previous versions on bugs

---

## Acceptance Criteria

### AC1: Database-First Mind Loading
**Given** a mind exists in `mmos.db` with system-prompt and KB
**When** user activates clone: `@emulator *activate <mind-name>`
**Then** the system:
1. Queries `minds` table for mind_id by name
2. Queries `system_prompts` table for latest active_version
3. Queries `fragments` table for KB fragments (type='kb', status='active')
4. Assembles KB content (if total_tokens < 20k)
5. Caches loaded clone in memory
6. Displays metadata (version, tokens, fidelity, DB source indicator)
7. **Never exposes file paths** to user

**Validation**:
```bash
@emulator *activate nassim_taleb

🪞 Mirror → Nassim Taleb (v2.3) loaded

 Source: Database (mmos.db)
📊 System Prompt: v2.3 (active) - 12,450 tokens
📚 KB Fragments: 47 loaded - 18,230 tokens (91% of limit)
🎯 Fidelity: 94% (validated 2025-10-10)
⚡ Load Time: 45ms (cached)

Now embodying Nassim Nicholas Taleb. Type *help for commands.
```

---

### AC2: Explicit Version Loading
**Given** a mind has multiple system-prompt versions in DB
**When** user requests specific version: `*activate <mind-name> --version <v>`
**Then** the system:
1. Queries `system_prompts` WHERE mind_id AND version_number = v
2. Loads that specific version (even if not active)
3. Displays version metadata (created date, author, changelog)
4. Warns if loading non-active version

**Validation**:
```bash
@emulator *activate nassim_taleb --version 2.1

⚠️  Loading historical version 2.1 (active: 2.3)

🪞 Mirror → Nassim Taleb (v2.1) loaded

📊 System Prompt: v2.1 (2025-09-15) - 11,200 tokens
   Changelog: "Initial version with 8-layer DNA Mental™"
📚 KB Fragments: 42 loaded (matched to v2.1 snapshot)
🎯 Fidelity: 91% (validated 2025-09-20)

Type *upgrade to load latest v2.3
```

---

### AC3: KB Token Budget Validation (DB-Based)
**Given** KB fragments in DB exceed 20k token limit
**When** user activates clone
**Then** the system:
1. Queries SUM(token_count) for all active KB fragments
2. If > 20k: displays warning with options
3. Options: (a) Load top-priority fragments only, (b) Load all (override), (c) Cancel
4. Logs decision to activation_history table

**Validation**:
```bash
@emulator *activate ray_dalio

⚠️  KB Fragments exceed 20k token limit

📊 Total KB: 47 fragments - 28,450 tokens (142% of limit)
🎯 Top-priority KB: 30 fragments - 18,900 tokens (94% of limit)

Options:
1. Load top-priority only (30 fragments, 18.9k tokens)
2. Load all fragments (override limit)
3. Cancel activation

Choice [1/2/3]: 1

✅ Loading top-priority KB fragments...
🪞 Mirror → Ray Dalio (v1.8) loaded with partial KB
```

---

### AC4: Multi-Clone Loading (Duo/Roundtable from DB)
**Given** user requests multi-clone mode
**When** `*duo <mind1> <mind2>` or `*roundtable <mind1> <mind2> <mind3> [mind4]`
**Then** the system:
1. Loads all clones in parallel via async DB queries
2. Enforces combined token budget (20k per clone)
3. Caches each clone independently
4. Tracks multi-clone session in activation_history
5. Displays combined metadata

**Validation**:
```bash
@emulator *duo nassim_taleb naval_ravikant

⚡ Loading 2 clones in parallel...

✅ Nassim Taleb (v2.3) - 12.4k + 18.2k KB = 30.6k total
✅ Naval Ravikant (v1.5) - 10.1k + 16.8k KB = 26.9k total

📊 Combined: 57.5k tokens (budget: 40k per clone = 80k total ✅)
⚡ Load Time: 68ms (parallel DB queries)

Starting dual interaction mode...
```

---

### AC5: Activation Analytics & Tracking
**Given** clone activations happen via database
**When** user activates any clone
**Then** the system:
1. Logs activation to `activation_history` table:
   - mind_id, version_id, mode (single/duo/roundtable), timestamp
   - kb_fragments_loaded, total_tokens, load_time_ms
2. Tracks session duration (activation → *exit)
3. Provides analytics via `*stats` command

**Validation**:
```sql
-- activation_history table
CREATE TABLE activation_history (
  id INTEGER PRIMARY KEY,
  mind_id INTEGER NOT NULL,
  version_id INTEGER NOT NULL,
  mode TEXT CHECK(mode IN ('single', 'duo', 'roundtable')),
  kb_fragments_loaded INTEGER,
  total_tokens INTEGER,
  load_time_ms INTEGER,
  session_duration_seconds INTEGER,
  activated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (mind_id) REFERENCES minds(id),
  FOREIGN KEY (version_id) REFERENCES system_prompts(id)
);
```

**Analytics Display**:
```bash
@emulator *stats

📊 Emulator Usage Analytics (Last 30 Days)

Top 5 Most Activated Clones:
1. Nassim Taleb - 47 activations (avg 18.3min session)
2. Naval Ravikant - 32 activations (avg 12.1min session)
3. Ray Dalio - 28 activations (avg 22.5min session)
4. Sam Altman - 19 activations (avg 9.8min session)
5. Steve Jobs - 15 activations (avg 14.7min session)

Mode Distribution:
- Single: 87% (127 sessions)
- Duo: 11% (16 sessions)
- Roundtable: 2% (3 sessions)

Performance:
- Avg load time: 52ms (DB) vs 480ms (path-based)
- Cache hit rate: 73%
```

---

### AC6: Backward Compatibility (Fallback to Path-Based)
**Given** database is unavailable or mind not found in DB
**When** user activates clone
**Then** the system:
1. Detects DB unavailability (connection error)
2. Logs fallback event
3. Falls back to path-based loading (current implementation)
4. Displays warning about limited features

**Validation**:
```bash
@emulator *activate nassim_taleb

⚠️  Database unavailable - falling back to path-based loading

🪞 Mirror → Nassim Taleb loaded (path-based)

📂 System Prompt: outputs/minds/nassim_taleb/system-prompt.md
📂 KB: outputs/minds/nassim_taleb/kb/ (47 files)
⚠️  Limited features: No versioning, analytics, or caching

Type *help for available commands (some may be disabled)
```

---

## Integration Verifications

### IV1: Database Schema Compatibility
**Verification:**
- ✅ Uses existing mmos.db schema (minds, system_prompts, fragments tables)
- ✅ No schema changes required (uses existing v3.0.0)
- ✅ Adds new activation_history table for analytics

**Test:**
```bash
# Verify schema compatibility
sqlite3 outputs/database/mmos.db "SELECT name FROM sqlite_master WHERE type='table';"

# Expected tables: minds, system_prompts, fragments, activation_history
```

---

### IV2: Memory Caching Performance
**Verification:**
- ✅ First activation: <100ms (DB query + assembly)
- ✅ Subsequent activations: <50ms (memory cache hit)
- ✅ Cache invalidation on version update
- ✅ Cache size limit: 5 clones max (LRU eviction)

**Test:**
```python
# Performance test
import time

# First activation (cold)
start = time.time()
emulator.activate("nassim_taleb")
cold_time = (time.time() - start) * 1000
assert cold_time < 100, f"Cold activation too slow: {cold_time}ms"

# Second activation (cached)
start = time.time()
emulator.activate("nassim_taleb")
cached_time = (time.time() - start) * 1000
assert cached_time < 50, f"Cached activation too slow: {cached_time}ms"
```

---

### IV3: Security Validation (Zero Path Exposure)
**Verification:**
- ✅ No file paths in user-facing messages
- ✅ No path inputs accepted (only mind_id or name)
- ✅ All queries parameterized (SQL injection safe)
- ✅ Access control via DB (not filesystem permissions)

**Test:**
```python
# Attempt path injection
result = emulator.activate("../../etc/passwd")
assert result.error == "Mind not found in database"
assert "path" not in result.message.lower()

# Verify SQL parameterization
result = emulator.activate("nassim_taleb'; DROP TABLE minds--")
assert result.error == "Mind not found in database"
assert minds_table_still_exists()
```

---

## Tasks / Subtasks

- [ ] **Task 1: Create Database Client Module** (AC1, AC2)
  - [ ] Create `expansion-packs/mmos-mind-mapper/agents/db_client.py`
  - [ ] Implement `load_mind_by_name(name: str) → Mind`
  - [ ] Implement `load_mind_by_id(id: int) → Mind`
  - [ ] Implement `load_system_prompt(mind_id, version=None) → SystemPrompt`
  - [ ] Implement `load_kb_fragments(mind_id, token_limit=20000) → List[Fragment]`
  - [ ] Add connection pooling for concurrent queries
  - [ ] Add error handling for DB unavailability

- [ ] **Task 2: Implement Memory Cache Layer** (IV2)
  - [ ] Create `expansion-packs/mmos-mind-mapper/agents/cache_manager.py`
  - [ ] Implement LRU cache (max 5 clones)
  - [ ] Implement cache_get(), cache_put(), cache_invalidate()
  - [ ] Add cache hit/miss tracking
  - [ ] Add cache statistics for *stats command

- [ ] **Task 3: Update Emulator Agent** (AC1, AC2, AC3, AC4)
  - [ ] Modify `expansion-packs/mmos-mind-mapper/agents/emulator.md`
  - [ ] Update `*activate` to use db_client instead of file paths
  - [ ] Add `--version` flag for explicit version loading
  - [ ] Update KB token validation to query DB
  - [ ] Update `*duo` and `*roundtable` for parallel DB loading
  - [ ] Add DB source indicator to activation greeting

- [ ] **Task 4: Create Activation History Tracker** (AC5)
  - [ ] Create `expansion-packs/mmos-mind-mapper/agents/activation_tracker.py`
  - [ ] Create `activation_history` table schema
  - [ ] Implement log_activation(), log_session_end()
  - [ ] Implement `*stats` command (query activation_history)
  - [ ] Add analytics views (top clones, mode distribution, performance)

- [ ] **Task 5: Implement Fallback Mechanism** (AC6)
  - [ ] Add DB availability check in `db_client.py`
  - [ ] Implement fallback_to_path_based() in emulator
  - [ ] Add feature degradation warnings
  - [ ] Test fallback with disconnected DB

- [ ] **Task 6: Update Emulator Dependencies** (Integration)
  - [ ] Update `activate-clone.md` task to use DB
  - [ ] Update `reload-clone.md` to cache_invalidate + DB reload
  - [ ] Update `clone-activation-report.yaml` template (add DB fields)

- [ ] **Task 7: Integration Testing** (All IVs)
  - [ ] Test single clone activation from DB
  - [ ] Test version-specific loading
  - [ ] Test KB token limit handling
  - [ ] Test multi-clone parallel loading
  - [ ] Test caching performance (cold vs warm)
  - [ ] Test fallback to path-based
  - [ ] Test security (path injection attempts)
  - [ ] Test activation analytics

- [ ] **Task 8: Documentation**
  - [ ] Update emulator agent README with DB features
  - [ ] Document cache configuration
  - [ ] Document activation_history schema
  - [ ] Create migration guide (path-based → DB)

---

## Dev Notes

### Database Schema (Existing v3.0.0)
```sql
-- minds table (existing)
CREATE TABLE minds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  display_name TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- system_prompts table (existing)
CREATE TABLE system_prompts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL,
  version_number TEXT NOT NULL,
  content TEXT NOT NULL,
  token_count INTEGER,
  is_active BOOLEAN DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mind_id) REFERENCES minds(id),
  UNIQUE(mind_id, version_number)
);

-- fragments table (existing - for KB)
CREATE TABLE fragments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL,
  type TEXT CHECK(type IN ('source', 'kb', 'artifact')) NOT NULL,
  content TEXT NOT NULL,
  token_count INTEGER,
  priority INTEGER DEFAULT 5,
  status TEXT CHECK(status IN ('active', 'archived')) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mind_id) REFERENCES minds(id)
);

-- activation_history table (NEW for Story 4.1)
CREATE TABLE activation_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL,
  version_id INTEGER NOT NULL,
  mode TEXT CHECK(mode IN ('single', 'duo', 'roundtable')) NOT NULL,
  kb_fragments_loaded INTEGER,
  total_tokens INTEGER,
  load_time_ms INTEGER,
  session_duration_seconds INTEGER,
  activated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (mind_id) REFERENCES minds(id),
  FOREIGN KEY (version_id) REFERENCES system_prompts(id)
);
```

### Cache Configuration
```yaml
# expansion-packs/mmos-mind-mapper/config.yaml
cache:
  enabled: true
  max_clones: 5  # LRU eviction
  ttl_minutes: 60  # Time-to-live for cached clones
  invalidate_on_version_change: true
```

### Performance Targets
| Metric | Target | Current (Path-Based) |
|--------|--------|---------------------|
| Cold activation | <100ms | ~500ms |
| Cached activation | <50ms | N/A |
| KB query | <30ms | ~200ms (file I/O) |
| Multi-clone parallel load (3 clones) | <150ms | ~1500ms (sequential) |

---

## Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Database corruption breaks all activations | Low | Critical | Implement fallback to path-based; regular DB backups |
| Cache invalidation bugs cause stale clones | Medium | High | Version-based cache keys; explicit invalidation on updates |
| Parallel DB queries cause lock contention | Low | Medium | Use WAL mode; connection pooling; read-only queries |
| Migration breaks existing path-based workflows | Medium | High | Keep path-based as fallback; gradual migration; testing |

---

## Success Metrics

### Security
- ✅ Zero path traversal vulnerabilities (verified by security audit)
- ✅ All queries parameterized (SQL injection safe)
- ✅ No file paths exposed to end users

### Performance
- ✅ 90%+ activations under 100ms (cold)
- ✅ 95%+ activations under 50ms (cached)
- ✅ Cache hit rate >70%

### Features
- ✅ Version-specific loading works for all minds
- ✅ Analytics tracking for all activations
- ✅ Fallback works when DB unavailable

### Business
- ✅ Enables versioned clone rollback (safety)
- ✅ Usage analytics inform mind development priorities
- ✅ Faster activations improve UX

---

## Dependencies

### Blocking
- ✅ **mmos.db v3.0.0** - Database schema must exist (COMPLETE)
- ✅ **Emulator Agent** - Must be created first (COMPLETE - created in this session)

### Non-Blocking
- **Story 1.x (Launcher/Pipeline)** - Independent workflow
- **Story 2.x (InnerLens)** - Independent expansion pack

### Enables
- Advanced clone comparison features
- Multi-version A/B testing
- Usage-driven mind prioritization
- Cross-mind behavioral analytics

---

## Future Enhancements (Post-4.1)

**Advanced Analytics**:
- Clone interaction heatmaps (which minds work well together in duo/roundtable)
- User preference learning (auto-suggest minds based on usage patterns)
- Fidelity tracking over time (version quality trends)

**Version Control**:
- Diff system-prompts between versions
- Automated regression testing on new versions
- Rollback to last known good version

**Performance**:
- Pre-warming cache on startup (load top 3 most-used clones)
- Predictive caching (preload likely next activations)
- KB fragment lazy loading (load on-demand during conversation)

---

**Story 4.1 Status**: 📋 PLANNED (Created 2025-10-14)
**Next Step**: Create Task 1 (Database Client Module)
**Estimated Delivery**: 4-6 days after Story 3.1.1 complete

---

## Related Stories

- **Story 1.4 (Auto-Execution)**: Uses database for pipeline execution
- **Story 2.4 (Pipeline v3 Integration)**: Populates system_prompts and fragments tables
- **Story 3.1 (Backward Compatible DB)**: Created mmos.db schema v3.0.0

---

## Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-10-14 | 1.0 | Initial story creation for emulator DB integration | Expansion Creator Agent |
