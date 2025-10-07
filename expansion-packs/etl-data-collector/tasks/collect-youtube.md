# collect-youtube

**Task ID:** collect-youtube
**Agent:** youtube-specialist
**Elicit:** false
**Purpose:** Download YouTube videos, extract audio, and generate transcripts

---

## Overview

Downloads YouTube videos/audio and generates high-quality transcripts using YouTube Transcript API (preferred) or Whisper fallback.

**Inputs:**
- Sources list filtered for `type: youtube` or `type: video`
- Output directory path

**Outputs:**
- `{output_dir}/youtube/{source_id}/video.mp4` (optional)
- `{output_dir}/youtube/{source_id}/audio.mp3`
- `{output_dir}/youtube/{source_id}/transcript.txt`
- `{output_dir}/youtube/{source_id}/transcript_timestamped.srt`
- `{output_dir}/youtube/{source_id}/metadata.json`

---

## Workflow

```javascript
async function collectYouTube(sources, outputDir) {
  for (const source of sources) {
    try {
      // 1. Download video/audio
      const videoId = extractVideoId(source.url);
      const audioPath = await downloadAudio(source.url, outputDir);

      // 2. Get transcript (YouTube API first, Whisper fallback)
      let transcript;
      try {
        transcript = await fetchYouTubeTranscript(videoId);
      } catch {
        transcript = await transcribeWithWhisper(audioPath);
      }

      // 3. Extract metadata
      const metadata = await getVideoMetadata(videoId);

      // 4. Save all artifacts
      await saveArtifacts(source.id, { audio: audioPath, transcript, metadata });

      // 5. Validate quality
      const quality = assessTranscriptQuality(transcript);
      if (quality.score < 85) {
        console.warn(`Low quality transcript for ${source.id}: ${quality.score}%`);
      }

    } catch (error) {
      logError(source.id, error);
    }
  }
}
```

---

## Tools Used

- **ytdl-core** (Node.js) - Video/audio download
- **youtube-transcript** (Node.js) - Fetch official captions
- **ffmpeg** - Audio extraction/conversion
- **whisper** (Python fallback) - AI transcription when captions unavailable

---

## Quality Validation

Transcript quality score based on:
- Word count (>100 words)
- Punctuation ratio
- Capitalization correctness
- Timestamp accuracy (for SRT)
- No excessive [Music] or [Applause] tags

**Acceptable:** Score ≥ 85%

---

*collect-youtube task v1.0.0*
