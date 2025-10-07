# TODO - MMOS Project Tasks

**Last Updated:** 2025-10-06
**Current Focus:** ETL Data Collector Expansion Pack Development

---

## 🎯 Current Sprint: ETL Pack Completion

### ✅ Completed (70%)

- [x] Foundation layer (config, utils, MCPs base)
- [x] Article extractors (WordPress, Medium, Generic) - FULL
- [x] Web collector with robots.txt + rate limiting - FULL
- [x] AssemblyAI MCP with upload + cost tracking - FULL
- [x] Speaker filter utility with heuristics
- [x] Markdown converter
- [x] Basic orchestration (task-manager, progress-tracker, parallel-collector)
- [x] Basic tools (validators, transformers)
- [x] Documentation (README, STATUS)

### 🚧 In Progress: File Expansion (30%)

**Priority 1: Critical Collectors (4 files)**

- [ ] **youtube-collector.js** - EXPAND NEXT
  - Current: 94 lines, basic flow
  - Target: ~350 lines
  - Add:
    - Full ytdl-core integration with error handling
    - Video metadata extraction (title, channel, duration, views, description)
    - Download progress tracking with EventEmitter
    - Integration with AssemblyAI MCP (upload + progress callbacks)
    - Speaker filtering to extract target speaker (interviewee)
    - Auto-chapters support
    - Error handling (video unavailable, region blocked, age restricted)
    - Markdown generation with frontmatter
    - Stats tracking (duration, cost)
  - Reference: assemblyai-mcp.js (342 lines) for patterns

- [ ] **podcast-collector.js** - EXPAND AFTER YOUTUBE
  - Current: Basic RSS parsing placeholder
  - Target: ~300 lines
  - Add:
    - Complete RSS feed parsing (podcast-index-api or rss-parser)
    - Episode metadata extraction (show notes, guest info)
    - Audio download with progress tracking
    - AssemblyAI transcription with speaker diarization
    - Show notes integration in markdown output
    - Multi-episode batch processing
    - Error handling (feed unavailable, malformed RSS)
  - Reference: youtube-collector.js for audio download patterns

- [ ] **pdf-collector.js** - EXPAND THIRD
  - Current: Basic pdf-parse
  - Target: ~280 lines
  - Add:
    - OCR support for scanned PDFs (Tesseract.js)
    - Text vs scanned PDF detection
    - Chapter/section detection using headings
    - Table of contents extraction
    - Metadata extraction (author, title, creation date)
    - Image extraction skip (per download rules)
    - Multi-page text chunking
    - Quality validation (text density check)
  - Reference: web-collector.js for validation patterns

- [ ] **social-collector.js** - EXPAND FOURTH
  - Current: Placeholder structure
  - Target: ~320 lines
  - Add:
    - Twitter/X API integration (thread extraction)
    - Reddit API integration (comment threads)
    - LinkedIn post extraction (if public API available)
    - Rate limiting per platform
    - Thread reconstruction (parent-child relationships)
    - Author filtering (extract only target author's tweets/posts)
    - Markdown formatting with quoted replies
    - Fallback to web scraping if API unavailable
  - Note: May require additional MCPs or API keys

**Priority 2: Orchestration Enhancement (3 files)**

- [ ] **task-manager.js**
  - Current: 73 lines, basic queue + retry
  - Target: ~150 lines
  - Add:
    - Checkpoint/resume functionality (save state to JSON)
    - Better error aggregation and reporting
    - Task dependencies (task A must complete before task B)
    - Cancellation support
    - Timeout handling per task
    - Detailed task logs

- [ ] **progress-tracker.js**
  - Current: 59 lines, basic ETA calculation
  - Target: ~120 lines
  - Add:
    - More accurate ETA using weighted average
    - Per-source-type progress tracking
    - Visual progress bar with colors (chalk)
    - Detailed statistics (avg time per source type)
    - Export progress report to JSON
    - Real-time console updates

- [ ] **parallel-collector.js**
  - Current: 89 lines, basic parallel execution
  - Target: ~180 lines
  - Add:
    - Checkpoint/resume functionality
    - Better error recovery (continue on partial failure)
    - Resource management (limit concurrent downloads)
    - Detailed collection report with errors
    - Cost aggregation across all collectors
    - Export final report to JSON/Markdown

**Priority 3: Knowledge Base Documentation (1 file)**

- [ ] **etl-kb.md**
  - Current: Empty/placeholder
  - Target: Complete knowledge base documentation
  - Add:
    - ETL pipeline architecture overview
    - Source type decision tree (when to use which collector)
    - Speaker diarization guide (how to configure)
    - Cost optimization strategies
    - Troubleshooting guide (common errors + fixes)
    - Performance tuning guide
    - Integration examples with MMOS Mind Mapper
    - API reference for all collectors + MCPs

---

## 📦 Expansion File Summary

| File | Status | Lines | Priority | Dependencies |
|------|--------|-------|----------|--------------|
| medium-extractor.js | ✅ DONE | 260 | - | - |
| web-collector.js | ✅ DONE | 308 | - | - |
| assemblyai-mcp.js | ✅ DONE | 342 | - | - |
| youtube-collector.js | 🚧 TODO | 94→350 | P1 | assemblyai-mcp |
| podcast-collector.js | 🚧 TODO | ~60→300 | P1 | assemblyai-mcp |
| pdf-collector.js | 🚧 TODO | ~50→280 | P1 | - |
| social-collector.js | 🚧 TODO | ~40→320 | P1 | - |
| task-manager.js | 🚧 TODO | 73→150 | P2 | - |
| progress-tracker.js | 🚧 TODO | 59→120 | P2 | - |
| parallel-collector.js | 🚧 TODO | 89→180 | P2 | task-manager |
| etl-kb.md | 🚧 TODO | 0→800+ | P3 | All collectors |

**Tools (Basic implementations OK for MVP):**
- check-completeness.js - Can wait
- verify-quality.js - Can wait
- validate-transcript.js - Can wait
- filter-speaker.js - Can wait
- clean-transcript.js - Can wait
- chunk-text.js - Can wait

---

## 🔄 Development Workflow

### When Expanding a File:

1. **Read existing file** - Understand current implementation
2. **Check dependencies** - Read referenced files (e.g., AssemblyAI MCP)
3. **Expand in place** - Use Edit tool to replace entire file content
4. **Add patterns from completed files:**
   - EventEmitter for progress tracking
   - Try-catch with detailed error messages
   - Stats tracking (attempted, successful, failed)
   - Event emission for key lifecycle events
   - Validation and quality checks
   - Markdown frontmatter generation
   - Cost tracking where applicable
5. **Commit after each file** - Keep commits atomic
6. **Update STATUS.md** - Mark file as expanded

### Commit Message Pattern:

```
feat: expand [filename] with complete implementation

- Add [feature 1]
- Add [feature 2]
- Improve error handling
- Add progress tracking
```

---

## 🎬 Next Immediate Actions

1. **Expand youtube-collector.js** (highest priority)
   - This is the most commonly used collector
   - Template for other audio collectors (podcast)
   - Integrates with AssemblyAI MCP (already complete)

2. **Test youtube-collector.js** with real YouTube URL
   - Create test script if needed
   - Verify AssemblyAI integration works
   - Check speaker filtering accuracy

3. **Expand podcast-collector.js**
   - Similar to YouTube but with RSS feed parsing
   - Reuse audio download + transcription patterns

4. **Expand pdf-collector.js**
   - Different domain (text extraction vs audio)
   - Important for blog articles saved as PDFs

5. **Expand social-collector.js**
   - Most complex (multiple platforms)
   - May require API research for Twitter/Reddit

6. **Enhance orchestration files**
   - Add checkpoint/resume to prevent re-downloading
   - Better progress tracking for long-running jobs

7. **Write etl-kb.md**
   - Complete documentation
   - Usage examples
   - Troubleshooting guide

---

## 📝 Notes and Decisions

### Key Technical Decisions:

1. **AssemblyAI over Whisper** - Better speaker diarization, cloud-based, no local GPU needed
2. **Node.js for orchestration** - Better AIOS integration, ecosystem for web scraping
3. **Python MCPs for heavy processing** - Fallback for OCR, audio processing if needed
4. **Minimal content strategy** - Markdown only, no images/videos (per download rules)
5. **Speaker filtering heuristic** - Multi-factor scoring to identify target speaker
6. **robots.txt compliance** - Ethical scraping with rate limiting

### Important Files to Reference:

- `expansion-packs/etl-data-collector/STATUS.md` - Current status
- `expansion-packs/etl-data-collector/config/download-rules.yaml` - What to download
- `expansion-packs/etl-data-collector/config/mcp-config.yaml` - MCP configurations
- `docs/minds/jesus_cristo/sources/downloads/README.md` - Example of successful download process

### User Preferences:

- Small files don't need token limit concerns
- Continue expansion without unnecessary pauses
- Commit after each significant file expansion
- Include creator attribution in READMEs: "Criado por Alan Nicolas"

---

## 🚀 Post-Expansion Tasks

### After all 11 files are expanded:

- [ ] Create integration tests
- [ ] Test full pipeline end-to-end
- [ ] Performance benchmarking
- [ ] Cost analysis (AssemblyAI usage)
- [ ] Write tutorial documentation
- [ ] Create example sources.yaml
- [ ] Test with real sources (YouTube, Medium, PDFs)
- [ ] Integration with MMOS Mind Mapper
- [ ] GitHub release (v1.0.0)

### Future Enhancements (Backlog):

- [ ] Add Substack extractor (currently uses generic)
- [ ] Add Ghost.io extractor (currently uses generic)
- [ ] Add Notion export parser
- [ ] Add Google Docs export parser
- [ ] Add video transcript editing UI
- [ ] Add audio file collector (direct MP3/WAV upload)
- [ ] Add livestream recorder (YouTube Live, Twitch)
- [ ] Add email newsletter archive parser (Mailchimp export)
- [ ] Multi-language support for non-English content
- [ ] GPT-4 integration for content summarization
- [ ] Duplicate detection across sources

---

## 📊 Progress Tracking

**Overall Completion:** 70% → Target: 100%

**Breakdown:**
- Foundation: 100% ✅
- Extractors: 100% ✅
- Collectors: 25% (1/4 expanded) 🚧
- Orchestration: 0% (basic MVP only) 🚧
- Tools: 50% (basic implementations) ✅
- Documentation: 60% (README done, KB pending) 🚧

**Estimated Time Remaining:** 4-6 hours of focused development

---

## 🔗 Related Documentation

- [ETL Pack README](/Users/alan/Code/mmos/expansion-packs/etl-data-collector/README.md)
- [ETL Pack STATUS](/Users/alan/Code/mmos/expansion-packs/etl-data-collector/STATUS.md)
- [AIOS Framework README](/Users/alan/Code/mmos/README.md)
- [MMOS Mind Mapper Pack](/Users/alan/Code/mmos/expansion-packs/mmos-mind-mapper/README.md)

---

**Created by:** @analyst (Claude Code AIOS)
**For:** Alan Nicolas
**Project:** MMOS - Mind Mapper Orchestration System
**Pack:** ETL Data Collector v1.0.0-beta
