# collect-podcasts

**Task ID:** collect-podcasts
**Agent:** youtube-specialist (handles audio transcription)
**Elicit:** false
**Purpose:** Download podcast episodes from RSS feeds and transcribe with speaker diarization

---

## Overview

Downloads podcast episodes from RSS feeds, transcribes with AssemblyAI speaker diarization to identify host vs guest, and filters to focus on guest (target personality).

**Inputs:**
- Sources list filtered for `type: podcast`
- RSS feed URL or direct episode audio URL

**Outputs:**
- `downloads/podcasts/{source_id}/audio.mp3` (temporary)
- `downloads/podcasts/{source_id}/transcript.md` (with speaker diarization)
- `downloads/podcasts/{source_id}/metadata.json`

---

## Workflow

```javascript
async function collectPodcast(source, outputDir) {
  // 1. Parse RSS feed (if feed URL provided)
  if (source.rss_feed) {
    const episodes = await parseRSSFeed(source.rss_feed);
    source.url = episodes[0].enclosure.url; // Latest episode
  }

  // 2. Download audio
  const audioPath = await downloadAudio(source.url, outputDir);

  // 3. Transcribe with diarization
  const transcript = await transcribeWithAssemblyAI(audioPath, {
    speaker_labels: true,
    speakers_expected: 2  // Host + Guest
  });

  // 4. Identify guest (target speaker)
  const targetSpeaker = identifyGuest(transcript.utterances);

  // 5. Filter to guest utterances
  const guestUtterances = filterByTargetSpeaker(transcript.utterances, targetSpeaker);

  // 6. Format as markdown
  const markdown = createTranscriptDocument(transcript, {
    title: source.title,
    url: source.url,
    source_type: 'podcast',
    target_speaker: targetSpeaker
  });

  // 7. Save
  await saveTranscript(outputDir, markdown);

  // 8. Delete audio (save space)
  await fs.unlink(audioPath);
}
```

---

## Heuristics: Identifying Guest

Guest is usually:
- **Speaks more:** Higher total speech time
- **Longer responses:** Higher avg utterance duration
- **Speaks second:** Host introduces guest first

---

*collect-podcasts task v1.0.0*
