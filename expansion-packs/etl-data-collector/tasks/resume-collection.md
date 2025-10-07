# resume-collection

**Task ID:** resume-collection
**Agent:** data-collector
**Elicit:** true
**Purpose:** Resume interrupted collection from checkpoint

---

## Overview

Allows recovery from interrupted collections by detecting what was already downloaded and continuing from where it left off.

**Use cases:**
- Collection was interrupted (crash, network failure)
- User manually stopped collection
- Partial collection needs completion

**Inputs:**
- Original `sources_master.yaml`
- Existing `downloads/` directory
- Optional: `COLLECTION_LOG.md` (if exists)

**Outputs:**
- Continues collection for missing sources
- Updates `COLLECTION_LOG.md`
- Generates final `COLLECTION_SUMMARY.yaml`

---

## Workflow

```javascript
async function resumeCollection(sourcesPath, outputDir) {
  // 1. Load sources list
  const sources = await loadSourcesList(sourcesPath);

  // 2. Scan existing downloads
  const downloaded = await scanDownloadedSources(outputDir);

  // 3. Identify missing sources
  const missing = sources.filter(s => !downloaded.includes(s.id));

  console.log(`Found ${downloaded.length} already downloaded`);
  console.log(`Resuming ${missing.length} remaining sources`);

  // 4. Confirm with user
  const proceed = await confirm(`Resume collection of ${missing.length} sources?`);

  if (!proceed) return;

  // 5. Continue collection
  await collectAllSources(missing, outputDir);
}
```

---

**Elicitation Point:**

```
🔄 Resume Collection

Detected partial collection:
  • Already downloaded: 35/47 sources (74%)
  • Remaining: 12 sources
  • Failed on previous run: 3 sources

Resume options:
1. Continue with remaining 12 sources
2. Retry the 3 failed sources only
3. Re-download everything (fresh start)

Enter choice (1-3):
```

---

*resume-collection task v1.0.0*
