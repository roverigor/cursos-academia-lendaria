/**
 * AssemblyAI MCP Wrapper
 * Integrates AssemblyAI API for transcription with speaker diarization
 */

import axios from 'axios';
import fs from 'fs/promises';

export class AssemblyAIMCP {
  constructor(apiKey, config = {}) {
    this.apiKey = apiKey || process.env.ASSEMBLYAI_API_KEY;
    
    if (!this.apiKey) {
      throw new Error('AssemblyAI API key required');
    }

    this.baseURL = 'https://api.assemblyai.com/v2';
    this.config = {
      language_code: 'en',
      speaker_labels: true,
      speakers_expected: 2,
      ...config
    };

    this.client = axios.create({
      baseURL: this.baseURL,
      headers: {
        'authorization': this.apiKey,
        'content-type': 'application/json'
      }
    });
  }

  async transcribe(audioURL, options = {}) {
    const transcriptConfig = {
      audio_url: audioURL,
      language_code: options.language_code || this.config.language_code,
      speaker_labels: options.speaker_labels !== false,
      speakers_expected: options.speakers_expected || this.config.speakers_expected,
      auto_chapters: options.auto_chapters || false,
      entity_detection: options.entity_detection || false,
      format_text: true
    };

    // Submit transcription job
    const response = await this.client.post('/transcript', transcriptConfig);
    const transcriptId = response.data.id;

    // Poll for completion
    const transcript = await this._pollTranscript(transcriptId);

    return transcript;
  }

  async _pollTranscript(transcriptId, maxAttempts = 180) {
    let attempts = 0;

    while (attempts < maxAttempts) {
      const response = await this.client.get(`/transcript/${transcriptId}`);
      const status = response.data.status;

      if (status === 'completed') {
        return response.data;
      } else if (status === 'error') {
        throw new Error(`Transcription failed: ${response.data.error}`);
      }

      // Wait 2 seconds before next poll
      await new Promise(resolve => setTimeout(resolve, 2000));
      attempts++;
    }

    throw new Error('Transcription timeout');
  }

  estimateCost(durationSeconds) {
    const hours = durationSeconds / 3600;
    const cost = hours * 0.65; // $0.65 per hour
    return cost.toFixed(2);
  }
}

export default AssemblyAIMCP;
