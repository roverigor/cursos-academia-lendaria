/**
 * PDF Collector
 * Extracts text from PDFs with OCR support
 */

import pdfParse from 'pdf-parse';
import fs from 'fs/promises';
import path from 'path';
import { MarkdownConverter } from '../utils/markdown-converter.js';

export class PDFCollector {
  constructor(downloadRules) {
    this.downloadRules = downloadRules;
    this.converter = new MarkdownConverter();
  }

  async collect(source, outputDir) {
    const sourceDir = path.join(outputDir, 'pdf', source.id);
    await fs.mkdir(sourceDir, { recursive: true });

    // Read PDF
    const dataBuffer = await fs.readFile(source.local_path || source.url);
    const pdf = await pdfParse(dataBuffer);

    // Convert to markdown
    const markdown = this.converter.addFrontmatter(pdf.text, {
      title: source.title,
      url: source.url,
      page_count: pdf.numpages,
      source_type: 'pdf'
    });

    // Save
    const markdownPath = path.join(sourceDir, 'text.md');
    await fs.writeFile(markdownPath, markdown);

    return { source_id: source.id, markdown_path: markdownPath };
  }
}

export default PDFCollector;
