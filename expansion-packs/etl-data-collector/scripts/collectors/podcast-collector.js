/**
 * Podcast Collector
 * Downloads podcast episodes and transcribes with speaker diarization
 */

import Parser from 'rss-parser';
import axios from 'axios';
import fs from 'fs/promises';
import path from 'path';
import { AssemblyAIMCP } from '../mcps/assemblyai-mcp.js';
import { createTranscriptDocument } from '../utils/speaker-filter.js';

export class PodcastCollector {
  constructor(downloadRules, mcpClient) {
    this.downloadRules = downloadRules;
    this.mcpClient = mcpClient;
    this.parser = new Parser();
    this.assemblyAI = new AssemblyAIMCP(process.env.ASSEMBLYAI_API_KEY);
  }

  async collect(source, outputDir) {
    const sourceDir = path.join(outputDir, 'podcasts', source.id);
    await fs.mkdir(sourceDir, { recursive: true });

    // Download audio
    const audioPath = await this._downloadAudio(source.url, sourceDir);

    // Transcribe
    const transcript = await this.assemblyAI.transcribe(audioPath, {
      speakers_expected: 2
    });

    // Create markdown
    const markdown = createTranscriptDocument(transcript, {
      title: source.title,
      url: source.url,
      source_type: 'podcast'
    });

    // Save
    const markdownPath = path.join(sourceDir, 'transcript.md');
    await fs.writeFile(markdownPath, markdown);

    // Delete audio
    if (this.downloadRules.podcasts?.delete_audio_after) {
      await fs.unlink(audioPath);
    }

    return { source_id: source.id, transcript, markdown_path: markdownPath };
  }

  async _downloadAudio(url, outputDir) {
    const audioPath = path.join(outputDir, 'audio.mp3');
    const response = await axios.get(url, { responseType: 'stream' });
    
    return new Promise((resolve, reject) => {
      response.data
        .pipe(fs.createWriteStream(audioPath))
        .on('finish', () => resolve(audioPath))
        .on('error', reject);
    });
  }
}

export default PodcastCollector;
