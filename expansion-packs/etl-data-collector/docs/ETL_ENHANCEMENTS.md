# ETL Data Collector Enhancement Specification

**Created:** 2025-10-11
**Context:** Sam Altman research collection failures
**Status:** Technical Debt / Brownfield Improvement

---

## Problem Statement

All automated YouTube collection methods failed for Sam Altman Tier 1 sources:
- 0/6 videos collected successfully
- Multiple failure modes encountered
- No viable automated path forward

### Failure Modes Documented

| Method | Result | Root Cause |
|--------|--------|------------|
| ytdl-core | ❌ Video unavailable | Library outdated, YouTube API changes |
| yt-dlp CLI | ❌ HTTP 403 Forbidden | Anti-bot detection, IP blocking |
| YouTube Transcript API | ❌ Transcripts disabled | Content owner choice (not automation issue) |

---

## Proposed Enhancements

### 1. Cascade Fallback Strategy

Implement waterfall approach with multiple strategies:

```javascript
async collectYouTube(source) {
  const strategies = [
    { name: 'youtube-transcript-api', method: this._tryTranscriptAPI },
    { name: 'yt-dlp-cli', method: this._tryYtDlp },
    { name: 'ytdl-core', method: this._tryYtdlCore },
    { name: 'manual-import', method: this._promptManualImport }
  ];

  for (const strategy of strategies) {
    try {
      const result = await strategy.method(source);
      if (result.success) {
        return { ...result, strategy: strategy.name };
      }
    } catch (error) {
      this.emit('strategy_failed', { strategy: strategy.name, error });
      continue; // Try next strategy
    }
  }

  throw new Error('All collection strategies exhausted');
}
```

### 2. Manual Import Pathway

When automation fails, provide structured manual import:

```javascript
_promptManualImport(source) {
  return {
    success: false,
    requiresManual: true,
    instructions: {
      message: `Automated collection failed for: ${source.title}`,
      steps: [
        '1. Download transcript manually from YouTube',
        '2. Or use external service (Rev.com, Descript)',
        '3. Save as: docs/minds/{mind}/sources/manual/{source.id}.txt',
        '4. Run: etl import-manual --source {source.id}'
      ],
      alternativeSources: this._suggestAlternatives(source)
    }
  };
}
```

### 3. Retry Logic with Exponential Backoff

Add intelligent retry for transient failures:

```javascript
async _retryWithBackoff(fn, maxRetries = 3) {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      if (!this._isRetriable(error) || attempt === maxRetries - 1) {
        throw error;
      }

      const delay = Math.pow(2, attempt) * 1000; // 1s, 2s, 4s
      await this._sleep(delay);
    }
  }
}

_isRetriable(error) {
  const retriableCodes = [429, 500, 502, 503, 504];
  return retriableCodes.includes(error.statusCode);
}
```

### 4. Alternative Source Suggestions

When primary fails, suggest alternatives:

```javascript
_suggestAlternatives(source) {
  const alternatives = [];

  // Check if podcast version exists
  if (source.type === 'youtube') {
    alternatives.push({
      type: 'podcast',
      platform: 'Apple Podcasts / Spotify',
      searchQuery: `${source.title} podcast`
    });
  }

  // Suggest transcript services
  alternatives.push({
    type: 'transcript_service',
    options: [
      { name: 'Rev.com', cost: '$1.50/min', turnaround: '12h' },
      { name: 'Descript', cost: '$12/h', turnaround: 'instant' }
    ]
  });

  // Suggest summary sites
  alternatives.push({
    type: 'summary',
    sites: ['Podcast Notes', 'Huberman Lab summaries']
  });

  return alternatives;
}
```

### 5. Enhanced Error Reporting

Structured error logs for debugging:

```javascript
_logStructuredError(source, strategy, error) {
  const errorLog = {
    timestamp: new Date().toISOString(),
    source_id: source.id,
    source_url: source.url,
    strategy,
    error_type: error.name,
    error_message: error.message,
    error_code: error.statusCode || error.code,
    retryable: this._isRetriable(error),
    next_action: this._determineNextAction(error)
  };

  // Save to mind logs directory (per user feedback)
  const logPath = path.join(
    this.mindDir,
    'docs/logs',
    `${Date.now()}-collection-error.yaml`
  );

  fs.writeFileSync(logPath, yaml.dump(errorLog));
}
```

### 6. Collection Status Tracking

Track attempts across sessions:

```yaml
# docs/minds/{mind}/sources/collection-state.yaml
sources:
  s001:
    status: FAILED_ALL_STRATEGIES
    attempts:
      - strategy: youtube-transcript-api
        timestamp: 2025-10-11T20:54:26Z
        result: TRANSCRIPT_DISABLED
      - strategy: yt-dlp
        timestamp: 2025-10-11T20:52:38Z
        result: HTTP_403_FORBIDDEN
    next_retry: 2025-10-12T00:00:00Z  # 3 hour cooldown
    manual_import_path: null
    requires_manual: true
```

---

## Implementation Priority

### Phase 1: Immediate (Brownfield)
- [ ] Add manual import command: `etl import-manual`
- [ ] Create `collection-state.yaml` tracker
- [ ] Fix log location to `{mind}/docs/logs/` (per user feedback)

### Phase 2: Near-term (Next Sprint)
- [ ] Implement cascade fallback in YouTubeCollector
- [ ] Add retry logic with exponential backoff
- [ ] Enhanced error logging

### Phase 3: Long-term (Future)
- [ ] Integrate paid transcription services (Rev.com API)
- [ ] Add proxy rotation for anti-bot mitigation
- [ ] Browser automation (Playwright) for transcript scraping

---

## Known Blockers & Workarounds

### Blocker 1: YouTube Transcripts Disabled
**Scope:** Videos where owner disabled captions
**Workaround:** Manual transcription or paid services
**Detection:** Error message contains "Transcript is disabled"

### Blocker 2: YouTube 403 Forbidden
**Scope:** Anti-bot detection on downloads
**Workaround:**
1. Use VPN/proxy rotation
2. Browser automation with user-agent spoofing
3. Manual download via browser extensions
**Detection:** HTTP status 403 from yt-dlp

### Blocker 3: ytdl-core Outdated
**Scope:** Library incompatible with current YouTube
**Workaround:** Use yt-dlp CLI instead
**Detection:** Errors like "Could not extract functions"

---

## Testing Strategy

### Unit Tests
```javascript
describe('YouTubeCollector Cascade Fallback', () => {
  it('should try all strategies before failing', async () => {
    // Mock all strategies to fail except last
    const result = await collector.collect(mockSource);
    expect(result.strategy).toBe('manual-import');
  });

  it('should return on first successful strategy', async () => {
    // Mock transcript API to succeed
    const result = await collector.collect(mockSource);
    expect(result.strategy).toBe('youtube-transcript-api');
  });
});
```

### Integration Tests
```bash
# Test with known-blocked video
npm run test:etl -- --video=L_Guz73e6fw --expect=MANUAL_REQUIRED

# Test with public transcript
npm run test:etl -- --video=dQw4w9WgXcQ --expect=SUCCESS
```

---

## Acceptance Criteria

ETL enhancements are complete when:
- [ ] Manual import pathway exists and is documented
- [ ] Collection state persists across sessions
- [ ] All logs save to `{mind}/docs/logs/`
- [ ] Cascade fallback tries ≥3 strategies before manual prompt
- [ ] Error logs are structured and queryable
- [ ] Alternative sources suggested when all strategies fail

---

## Related Issues

- Sam Altman collection: 0/6 success rate
- Layer 8 evidence gap: Manual collection required
- Log location: Fixed to `{mind}/docs/logs/` per user feedback

---

**Next Actions:**
1. Create ticket: "Implement ETL manual import command"
2. Update YouTubeCollector.js with cascade fallback
3. Add integration tests for failure scenarios
