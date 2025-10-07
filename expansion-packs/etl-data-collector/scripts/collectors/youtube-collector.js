/**
 * YouTube Collector
 * Downloads audio and generates transcripts with speaker diarization
 */

import ytdl from 'ytdl-core';
import fs from 'fs/promises';
import path from 'path';
import { AssemblyAIMCP } from '../mcps/assemblyai-mcp.js';
import { createTranscriptDocument } from '../utils/speaker-filter.js';

export class YouTubeCollector {
  constructor(downloadRules, mcpClient) {
    this.downloadRules = downloadRules;
    this.mcpClient = mcpClient;
    this.assemblyAI = null;
  }

  async collect(source, outputDir) {
    const videoId = this._extractVideoId(source.url);
    const sourceDir = path.join(outputDir, 'youtube', source.id);
    await fs.mkdir(sourceDir, { recursive: true });

    // Download audio
    const audioPath = await this._downloadAudio(source.url, sourceDir);

    // Transcribe with diarization
    const transcript = await this._transcribe(audioPath, source);

    // Create markdown document
    const markdown = createTranscriptDocument(transcript, {
      title: source.title,
      url: source.url,
      source_type: 'youtube'
    });

    // Save
    const markdownPath = path.join(sourceDir, 'transcript.md');
    await fs.writeFile(markdownPath, markdown);

    // Delete audio if configured
    if (this.downloadRules.youtube?.audio?.delete_after_transcription) {
      await fs.unlink(audioPath);
    }

    return {
      source_id: source.id,
      transcript,
      markdown_path: markdownPath
    };
  }

  async _downloadAudio(url, outputDir) {
    const audioPath = path.join(outputDir, 'audio.mp3');
    
    return new Promise((resolve, reject) => {
      ytdl(url, { filter: 'audioonly', quality: 'highestaudio' })
        .pipe(fs.createWriteStream(audioPath))
        .on('finish', () => resolve(audioPath))
        .on('error', reject);
    });
  }

  async _transcribe(audioPath, source) {
    // Use AssemblyAI
    if (!this.assemblyAI) {
      this.assemblyAI = new AssemblyAIMCP(process.env.ASSEMBLYAI_API_KEY);
    }

    // Upload audio first
    const audioURL = await this._uploadAudio(audioPath);

    // Transcribe
    const transcript = await this.assemblyAI.transcribe(audioURL, {
      speakers_expected: source.diarization?.expected_speakers || 2
    });

    return transcript;
  }

  async _uploadAudio(audioPath) {
    // AssemblyAI requires a publicly accessible URL
    // For now, return local path (in production, upload to S3 or similar)
    return audioPath;
  }

  _extractVideoId(url) {
    const match = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/)([^&]+)/);
    return match ? match[1] : null;
  }
}

export default YouTubeCollector;
