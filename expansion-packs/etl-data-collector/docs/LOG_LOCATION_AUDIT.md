# ETL System - Log Location Audit Report

**Date:** 2025-10-11
**Auditor:** James (@dev)
**Context:** User-requested system-wide enforcement of log location standard

---

## Standard Enforcement Rule

**RULE:** Only `sources_master.yaml` should exist in `{mind}/sources/` directory. ALL logs, reports, configs, and temporary files MUST go to `{mind}/docs/logs/`.

```
✅ CORRECT:
{mind}/sources/sources_master.yaml
{mind}/sources/blogs/{id}.md (actual content)
{mind}/sources/downloads/{type}/{id}/ (actual content)
{mind}/sources/manual/ (templates only)

{mind}/docs/logs/{timestamp}-collection-report.yaml
{mind}/docs/logs/{timestamp}-import-log.yaml
{mind}/docs/logs/VERIFIED_TRANSCRIPT_SOURCES.md
{mind}/docs/logs/QUICK_LINKS.md

❌ WRONG:
{mind}/sources/tier1_batch.yaml → should be in docs/logs/
{mind}/sources/COLLECTION_REPORT.json → should be in docs/logs/
{mind}/downloads/COLLECTION_REPORT.json → should be in docs/logs/
```

---

## Issues Found

### 🔴 CRITICAL: run-collection.js (lines 18, 63-64)

**Problem 1:** Hardcoded path to `tier1_batch.yaml` in sources/ instead of docs/logs/
```javascript
// Line 18 - WRONG
const sourcesPath = path.join(__dirname, '../../docs/minds/sam_altman/sources/tier1_batch.yaml');
```

**Problem 2:** Report saved to downloads/ instead of docs/logs/
```javascript
// Lines 63-64 - WRONG
const reportPath = path.join(outputDir, 'COLLECTION_REPORT.json');
await fs.writeFile(reportPath, JSON.stringify(report, null, 2));
```

**Fix Required:**
- Accept batch config from docs/logs/ or use sources_master.yaml
- Save all reports to docs/logs/ with timestamp

---

### 🟡 MEDIUM: parallel-collector.js (line 25)

**Problem:** State file written to CWD instead of docs/logs/
```javascript
// Line 25 - WRONG
statePath: options.statePath || path.join(process.cwd(), '.etl-task-state.json'),
```

**Fix Required:**
- Accept mindDir parameter
- Default state to `{mind}/docs/logs/.etl-task-state.json`

---

### 🟢 GOOD: Scripts Already Compliant

These scripts correctly use docs/logs/:

✅ **collect-transcripts-simple.js** (line 153)
```javascript
const reportPath = path.join(logsDir, `${timestamp}-transcript-collection.yaml`);
```

✅ **import-manual.js** (line 31, 143)
```javascript
await fs.mkdir(this.logsDir, { recursive: true });
const logPath = path.join(this.logsDir, `${timestamp}-manual-import-${sourceId}.yaml`);
```

✅ **download-transcripts.js** (line 301)
```javascript
const reportPath = path.join(logsDir, `${timestamp}-web-download-report.yaml`);
```

---

### 🔵 INFO: Collectors (Content vs Logs)

**All collectors correctly save content to appropriate locations:**
- youtube-collector.js → saves transcripts to `downloads/youtube/{id}/`
- web-collector.js → saves blogs to `downloads/blogs/{id}.md`
- pdf-collector.js → saves PDFs to `downloads/pdf/{id}/`
- podcast-collector.js → saves to `downloads/podcast/{id}/`
- social-collector.js → saves to `downloads/social/{id}/`

**No issues found** - these are content, not logs.

---

## Recommended Fixes

### 1. Create Helper Utility

**File:** `scripts/utils/path-helpers.js`

```javascript
import path from 'path';

/**
 * Get the logs directory for a mind
 * @param {string} mindDir - Absolute path to mind directory (e.g., docs/minds/sam_altman)
 * @returns {string} Absolute path to logs directory
 */
export function getLogsDir(mindDir) {
  return path.join(mindDir, 'docs/logs');
}

/**
 * Get timestamped log filename
 * @param {string} baseName - Base name without extension (e.g., 'collection-report')
 * @param {string} extension - File extension (e.g., 'yaml', 'json')
 * @returns {string} Timestamped filename
 */
export function getTimestampedLogName(baseName, extension = 'yaml') {
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
  return `${timestamp}-${baseName}.${extension}`;
}

/**
 * Get full path for timestamped log file
 * @param {string} mindDir - Absolute path to mind directory
 * @param {string} baseName - Base name without extension
 * @param {string} extension - File extension
 * @returns {string} Full path to log file
 */
export function getLogPath(mindDir, baseName, extension = 'yaml') {
  const logsDir = getLogsDir(mindDir);
  const filename = getTimestampedLogName(baseName, extension);
  return path.join(logsDir, filename);
}
```

### 2. Update run-collection.js

**Changes needed:**
```javascript
// BEFORE (lines 18, 63-64)
const sourcesPath = path.join(__dirname, '../../docs/minds/sam_altman/sources/tier1_batch.yaml');
const reportPath = path.join(outputDir, 'COLLECTION_REPORT.json');

// AFTER
import { getLogPath, getLogsDir } from './scripts/utils/path-helpers.js';

// Use sources_master.yaml OR accept batch config from CLI
const mindDir = path.join(__dirname, '../../docs/minds/sam_altman');
const sourcesPath = path.join(mindDir, 'sources/sources_master.yaml');

// Save report to docs/logs/ with timestamp
const reportPath = getLogPath(mindDir, 'collection-report', 'json');
```

### 3. Update parallel-collector.js

**Changes needed:**
```javascript
// BEFORE (line 25)
statePath: options.statePath || path.join(process.cwd(), '.etl-task-state.json'),

// AFTER
import { getLogsDir } from '../utils/path-helpers.js';

// In constructor, accept mindDir
constructor(configPath, options = {}) {
  this.mindDir = options.mindDir; // NEW
  // ...
  statePath: options.statePath || path.join(
    this.mindDir ? getLogsDir(this.mindDir) : process.cwd(),
    '.etl-task-state.json'
  ),
}
```

### 4. Update MMOS Tasks Documentation

**File:** `expansion-packs/mmos-mind-mapper/tasks/research-collection.md`

Add section:
```markdown
## File Organization Standard

### Logs Directory
ALL collection reports, import logs, search guides, and configuration files MUST be saved to:
```
{mind}/docs/logs/{timestamp}-{description}.{ext}
```

### Sources Directory
ONLY the following files belong in `{mind}/sources/`:
- `sources_master.yaml` - Master source inventory
- `blogs/{id}.md` - Collected blog content
- `downloads/{type}/{id}/` - Collected transcripts/media
- `manual/` - Templates for manual collection

### Examples
✅ Correct:
- `docs/logs/2025-10-11T21-10-48-collection-report.yaml`
- `docs/logs/2025-10-11T18-17-00-import-log.yaml`
- `docs/logs/VERIFIED_TRANSCRIPT_SOURCES.md`

❌ Wrong:
- `sources/tier1_batch.yaml`
- `sources/COLLECTION_REPORT.json`
- `downloads/COLLECTION_REPORT.json`
```

---

## Validation Checklist

- [ ] Helper utility created (`scripts/utils/path-helpers.js`)
- [ ] `run-collection.js` updated to use docs/logs/
- [ ] `parallel-collector.js` accepts mindDir parameter
- [ ] All existing logs moved to correct location (already done for sam_altman)
- [ ] MMOS tasks documentation updated
- [ ] Test collection run validates log location
- [ ] Git commit with changes

---

## Testing Plan

1. **Create test mind structure:**
```bash
mkdir -p /tmp/test-mind/{sources,docs/logs}
```

2. **Run collection with updated code:**
```bash
node run-collection.js --mind test-mind
```

3. **Verify:**
```bash
# Should be empty except sources_master.yaml and content
ls /tmp/test-mind/sources/

# Should contain all logs
ls /tmp/test-mind/docs/logs/
```

---

## Implementation Priority

1. **HIGH:** Create path-helpers.js utility (enables everything else)
2. **HIGH:** Fix run-collection.js (most commonly used script)
3. **MEDIUM:** Update parallel-collector.js (used by run-collection)
4. **LOW:** Update MMOS documentation (prevents future issues)
5. **LOW:** Create validation script (catches violations)

---

**Status:** Audit Complete ✅
**Next Step:** Implement fixes starting with path-helpers.js
