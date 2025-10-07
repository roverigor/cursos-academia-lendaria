/**
 * AssemblyAI MCP Wrapper
 * Complete integration with AssemblyAI API for transcription with speaker diarization
 * Includes audio upload, progress tracking, and cost management
 */

import axios from 'axios';
import fs from 'fs/promises';
import { createReadStream, statSync } from 'fs';
import { EventEmitter } from 'events';

export class AssemblyAIMCP extends EventEmitter {
  constructor(apiKey, config = {}) {
    super();

    this.apiKey = apiKey || process.env.ASSEMBLYAI_API_KEY;

    if (!this.apiKey) {
      throw new Error('AssemblyAI API key required. Set ASSEMBLYAI_API_KEY environment variable.');
    }

    this.baseURL = 'https://api.assemblyai.com/v2';
    this.uploadURL = 'https://api.assemblyai.com/v2/upload';

    this.config = {
      language_code: 'en',
      speaker_labels: true,
      speakers_expected: 2,
      punctuate: true,
      format_text: true,
      ...config
    };

    this.client = axios.create({
      baseURL: this.baseURL,
      headers: {
        'authorization': this.apiKey,
        'content-type': 'application/json'
      }
    });

    // Cost tracking
    this.totalCost = 0;
    this.transcriptionCount = 0;
  }

  /**
   * Upload local audio file to AssemblyAI
   * @param {string} filePath - Path to local audio file
   * @returns {Promise<string>} Upload URL
   */
  async uploadAudio(filePath) {
    this.emit('upload_start', { file: filePath });

    try {
      const stats = statSync(filePath);
      const fileSizeBytes = stats.size;
      const fileSizeMB = (fileSizeBytes / 1024 / 1024).toFixed(2);

      this.emit('upload_info', {
        file: filePath,
        size_mb: fileSizeMB
      });

      // Create read stream
      const audioData = createReadStream(filePath);

      // Upload to AssemblyAI
      const response = await axios.post(this.uploadURL, audioData, {
        headers: {
          'authorization': this.apiKey,
          'content-type': 'application/octet-stream',
          'transfer-encoding': 'chunked'
        },
        maxContentLength: Infinity,
        maxBodyLength: Infinity
      });

      const uploadURL = response.data.upload_url;

      this.emit('upload_complete', {
        file: filePath,
        url: uploadURL
      });

      return uploadURL;

    } catch (error) {
      this.emit('upload_error', {
        file: filePath,
        error: error.message
      });
      throw new Error(`Audio upload failed: ${error.message}`);
    }
  }

  /**
   * Transcribe audio with speaker diarization
   * @param {string} audioPathOrURL - Local file path or public URL
   * @param {object} options - Transcription options
   * @returns {Promise<object>} Transcript data
   */
  async transcribe(audioPathOrURL, options = {}) {
    let audioURL = audioPathOrURL;

    // If it's a local file, upload it first
    if (!audioPathOrURL.startsWith('http')) {
      audioURL = await this.uploadAudio(audioPathOrURL);
    }

    // Estimate cost before transcription
    if (options.duration_seconds) {
      const estimatedCost = this.estimateCost(options.duration_seconds);
      this.emit('cost_estimate', {
        duration_seconds: options.duration_seconds,
        estimated_cost: estimatedCost
      });

      // Warn if cost exceeds threshold
      if (parseFloat(estimatedCost) > 10.0) {
        this.emit('cost_warning', {
          cost: estimatedCost,
          message: 'Transcription cost exceeds $10'
        });
      }
    }

    const transcriptConfig = {
      audio_url: audioURL,
      language_code: options.language_code || this.config.language_code,

      // Speaker diarization
      speaker_labels: options.speaker_labels !== false,
      speakers_expected: options.speakers_expected || this.config.speakers_expected,

      // Additional features
      auto_chapters: options.auto_chapters || false,
      entity_detection: options.entity_detection || false,
      sentiment_analysis: options.sentiment_analysis || false,
      auto_highlights: options.auto_highlights || false,

      // Formatting
      punctuate: this.config.punctuate,
      format_text: this.config.format_text,

      // Language detection (optional)
      language_detection: options.language_detection || false
    };

    this.emit('transcription_start', {
      audio_url: audioURL,
      config: transcriptConfig
    });

    // Submit transcription job
    const response = await this.client.post('/transcript', transcriptConfig);
    const transcriptId = response.data.id;

    this.emit('transcription_submitted', {
      transcript_id: transcriptId
    });

    // Poll for completion with progress updates
    const transcript = await this._pollTranscript(transcriptId, options.onProgress);

    // Track cost
    if (transcript.audio_duration) {
      const actualCost = this.estimateCost(transcript.audio_duration);
      this.totalCost += parseFloat(actualCost);
      this.transcriptionCount++;

      this.emit('transcription_complete', {
        transcript_id: transcriptId,
        duration: transcript.audio_duration,
        cost: actualCost,
        total_cost: this.totalCost.toFixed(2)
      });
    }

    return transcript;
  }

  /**
   * Poll for transcription completion with progress updates
   * @param {string} transcriptId - Transcript ID
   * @param {function} onProgress - Progress callback
   * @param {number} maxAttempts - Max polling attempts (default: 300 = 10 min)
   * @returns {Promise<object>} Completed transcript
   */
  async _pollTranscript(transcriptId, onProgress = null, maxAttempts = 300) {
    let attempts = 0;
    let lastStatus = null;

    while (attempts < maxAttempts) {
      const response = await this.client.get(`/transcript/${transcriptId}`);
      const data = response.data;
      const status = data.status;

      // Emit progress if status changed
      if (status !== lastStatus) {
        this.emit('transcription_status', {
          transcript_id: transcriptId,
          status,
          attempt: attempts
        });

        if (onProgress) {
          onProgress(status, attempts);
        }

        lastStatus = status;
      }

      if (status === 'completed') {
        return data;
      }

      if (status === 'error') {
        const errorMessage = data.error || 'Unknown transcription error';
        this.emit('transcription_error', {
          transcript_id: transcriptId,
          error: errorMessage
        });
        throw new Error(`Transcription failed: ${errorMessage}`);
      }

      // Status can be: queued, processing, completed, error
      // Wait 2 seconds before next poll
      await new Promise(resolve => setTimeout(resolve, 2000));
      attempts++;
    }

    this.emit('transcription_timeout', {
      transcript_id: transcriptId,
      attempts
    });

    throw new Error(`Transcription timeout after ${maxAttempts} attempts (~${(maxAttempts * 2 / 60).toFixed(0)} minutes)`);
  }

  /**
   * Get transcript by ID
   * @param {string} transcriptId - Transcript ID
   * @returns {Promise<object>} Transcript data
   */
  async getTranscript(transcriptId) {
    const response = await this.client.get(`/transcript/${transcriptId}`);
    return response.data;
  }

  /**
   * Delete transcript
   * @param {string} transcriptId - Transcript ID
   * @returns {Promise<object>} Delete response
   */
  async deleteTranscript(transcriptId) {
    const response = await this.client.delete(`/transcript/${transcriptId}`);
    return response.data;
  }

  /**
   * List recent transcripts
   * @param {number} limit - Max results (default: 10)
   * @returns {Promise<array>} List of transcripts
   */
  async listTranscripts(limit = 10) {
    const response = await this.client.get('/transcript', {
      params: { limit }
    });
    return response.data.transcripts || [];
  }

  /**
   * Estimate transcription cost
   * @param {number} durationSeconds - Audio duration in seconds
   * @returns {string} Estimated cost in USD
   */
  estimateCost(durationSeconds) {
    const hours = durationSeconds / 3600;
    const cost = hours * 0.65; // $0.65 per hour (AssemblyAI pricing)
    return cost.toFixed(2);
  }

  /**
   * Get cost statistics
   * @returns {object} Cost stats
   */
  getCostStats() {
    return {
      total_cost: this.totalCost.toFixed(2),
      transcription_count: this.transcriptionCount,
      avg_cost_per_transcription: this.transcriptionCount > 0
        ? (this.totalCost / this.transcriptionCount).toFixed(2)
        : '0.00'
    };
  }

  /**
   * Check if API key is valid
   * @returns {Promise<boolean>} True if valid
   */
  async validateAPIKey() {
    try {
      // Try to list transcripts (requires valid API key)
      await this.listTranscripts(1);
      return true;
    } catch (error) {
      if (error.response?.status === 401) {
        return false;
      }
      throw error;
    }
  }

  /**
   * Get supported languages
   * @returns {array} Supported language codes
   */
  getSupportedLanguages() {
    return [
      'en', // English
      'es', // Spanish
      'fr', // French
      'de', // German
      'it', // Italian
      'pt', // Portuguese
      'nl', // Dutch
      'hi', // Hindi
      'ja', // Japanese
      'zh', // Chinese
      'fi', // Finnish
      'ko', // Korean
      'pl', // Polish
      'ru', // Russian
      'tr', // Turkish
      'uk', // Ukrainian
      'vi'  // Vietnamese
    ];
  }
}

export default AssemblyAIMCP;
