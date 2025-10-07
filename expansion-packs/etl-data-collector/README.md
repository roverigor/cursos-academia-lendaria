# ETL Data Collector

**Version:** 1.0.0  
**Author:** Academia Lendar[IA] (Alan Nicolas)  
**Type:** Standalone Expansion Pack

Industrial-grade ETL system for collecting data from diverse sources with AI-powered processing.

## 🎯 Purpose

Collect, transform, and load data from YouTube, podcasts, blogs, PDFs, and social media with:
- **Speaker diarization** to identify interviewee vs interviewer
- **Platform-specific extractors** for clean content (WordPress, Medium, etc)
- **Minimal output** (markdown only, no images/videos)
- **Parallel processing** for fast collection
- **Quality validation** built-in

## 🚀 Quick Start

```bash
# 1. Install dependencies
npm run setup

# 2. Configure API keys
export ASSEMBLYAI_API_KEY="your-key"

# 3. Create sources list
cat > sources.yaml << 'YAML'
sources:
  - id: interview-1
    type: youtube
    url: https://youtube.com/watch?v=...
    title: "Interview with Expert"
    tier: 1
    diarization:
      expected_speakers: 2
      filter_interviewer: true
YAML

# 4. Run collection
node scripts/orchestrator/parallel-collector.js \
  --sources sources.yaml \
  --output ./downloads
```

## 📦 What's Included

### Agents (5)
- `data-collector` - Master orchestrator
- `youtube-specialist` - Video/audio + transcription
- `web-specialist` - Blog/article scraping
- `document-specialist` - PDF/eBook processing
- `social-specialist` - Social media collection

### Tasks (8)
- `collect-all-sources` - Master workflow
- `collect-youtube` - YouTube videos
- `collect-podcasts` - Podcast episodes
- `collect-blogs` - Blog articles
- `collect-books` - PDFs/eBooks
- `collect-social` - Social media
- `validate-collection` - Quality checks
- `chunk-and-index` - Post-processing

### Source Types Supported
- ✅ YouTube videos
- ✅ Podcasts (RSS feeds)
- ✅ Blogs (WordPress, Medium, Substack, generic)
- ✅ PDFs & eBooks
- ✅ Twitter threads
- ✅ Reddit AMAs
- ✅ LinkedIn posts (limited)

## 🔑 Key Features

### Speaker Diarization
Automatically identifies speakers in interviews/podcasts and filters to focus on the target personality (interviewee, not interviewer).

```yaml
# sources.yaml
- id: lex-fridman-sama
  type: youtube
  url: https://youtube.com/watch?v=...
  diarization:
    target_speaker: auto  # or "Speaker B"
    filter_interviewer: true
```

### Platform Detection
Auto-detects blog platforms and uses optimized extractors:

- **WordPress:** Removes nav, footer, widgets, ads
- **Medium:** Handles paywall notices
- **Generic:** Falls back to Readability algorithm

### Minimal Content
Output is clean markdown only:
- ❌ No images (replaced with `[Image: alt text]`)
- ❌ No videos
- ❌ No CSS/JS
- ✅ Code blocks preserved
- ✅ Tables preserved
- ✅ Links preserved

## 📊 Output Structure

```
downloads/
├── youtube/
│   └── source-id/
│       ├── transcript.md          # Speaker-filtered transcript
│       └── metadata.json
├── blogs/
│   └── source-id.md               # Clean markdown article
├── pdf/
│   └── source-id/
│       └── text.md
└── COLLECTION_SUMMARY.yaml
```

## 🔧 Configuration

### Download Rules
Edit `config/download-rules.yaml`:

```yaml
youtube:
  download_strategy: audio_only    # Don't download video
  audio:
    delete_after_transcription: true  # Save space

blogs:
  images: remove_all                # No images
  preserve:
    links: true
    code_blocks: true
```

### MCPs
Edit `config/mcp-config.yaml`:

```yaml
mcps:
  assemblyai:
    enabled: true
    priority: required
    config:
      language_code: en
      speakers_expected: 2
```

## 🎓 Usage with MMOS

This pack is standalone but integrates with MMOS Mind Mapper:

```javascript
// MMOS can use ETL pack
import { ParallelCollector } from '@aios/etl-data-collector';

const collector = new ParallelCollector();
await collector.collectAll(
  'docs/minds/sam_altman/sources/sources_master.yaml',
  'docs/minds/sam_altman/sources/downloads/'
);
```

## 📝 License

MIT

## 🤝 Contributing

Issues and PRs welcome at: https://github.com/anthropics/claude-code/issues

---

<div align="center">

**Desenvolvido com 🧠 e IA pela Academia Lendar[IA]**

*Criado por Alan Nicolas*

---

**© 2025 Academia Lendar[IA] - Todos os direitos reservados**

**Note:** Some files are marked with `TODO: EXPAND` comments and need full implementation.

</div>
