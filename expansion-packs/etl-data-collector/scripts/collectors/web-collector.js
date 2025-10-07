/**
 * Web Collector
 * Orchestrates platform-specific extractors for blog/article collection
 */

import axios from 'axios';
import { WordPressExtractor } from '../extractors/wordpress-extractor.js';
import { MediumExtractor } from '../extractors/medium-extractor.js';
import { GenericExtractor } from '../extractors/generic-extractor.js';
import * as cheerio from 'cheerio';

export class WebCollector {
  constructor(downloadRules = {}) {
    this.downloadRules = downloadRules;
    
    this.extractors = {
      wordpress: new WordPressExtractor(),
      medium: new MediumExtractor(),
      generic: new GenericExtractor()
    };

    this.headers = {
      'User-Agent': downloadRules.global?.user_agent || 'AIOS-ETL-Collector/1.0',
      'Accept': 'text/html,application/xhtml+xml',
      'Accept-Language': 'en-US,en;q=0.9'
    };
  }

  async collect(source, outputDir) {
    const url = source.url;

    // Fetch HTML
    const html = await this._fetchHTML(url);

    // Detect platform
    const platform = this._detectPlatform(url, html);

    // Select extractor
    const extractor = this.extractors[platform] || this.extractors.generic;

    // Extract content
    const extracted = await extractor.extract(url, html);

    // Convert to markdown
    const markdown = extractor.toMarkdown(extracted);

    // Save
    const outputPath = `${outputDir}/blogs/${source.id}.md`;
    await fs.writeFile(outputPath, markdown);

    return {
      source_id: source.id,
      platform,
      markdown,
      metadata: extracted.metadata,
      output_path: outputPath
    };
  }

  async _fetchHTML(url) {
    const response = await axios.get(url, {
      headers: this.headers,
      timeout: 30000
    });

    return response.data;
  }

  _detectPlatform(url, html) {
    const $ = cheerio.load(html);

    if (WordPressExtractor.detectWordPress($)) {
      return 'wordpress';
    } else if (MediumExtractor.detectMedium($)) {
      return 'medium';
    }

    return 'generic';
  }
}

export default WebCollector;
