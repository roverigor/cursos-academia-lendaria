/**
 * Medium Extractor
 * Specialized extractor for Medium.com articles
 */

import { ArticleExtractor } from './article-extractor.js';

export class MediumExtractor extends ArticleExtractor {
  constructor() {
    super('medium');

    this.contentSelectors = [
      'article',
      '.postArticle-content',
      'section[data-field="body"]',
      '.section-content'
    ];

    this.removeSelectors = [
      ...this.removeSelectors,
      '.metabar',
      '.footer',
      'aside',
      '.followState',
      '.readNext'
    ];
  }

  static detectMedium($) {
    const url = $('link[rel="canonical"]').attr('href') || '';
    return url.includes('medium.com') ||
           $('meta[property="al:android:app_name"]').attr('content') === 'Medium';
  }
}

export default MediumExtractor;
