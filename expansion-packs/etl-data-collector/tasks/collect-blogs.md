# collect-blogs

**Task ID:** collect-blogs
**Agent:** web-specialist
**Elicit:** false
**Purpose:** Scrape blog posts and articles, convert to clean markdown

---

## Overview

Extracts main content from web pages using Readability algorithm, converts to markdown, and validates quality.

**Inputs:** Sources list filtered for `type: blog` or `type: article`

**Outputs:**
- `{output_dir}/blogs/{source_id}/article.md`
- `{output_dir}/blogs/{source_id}/metadata.json`

---

## Workflow

```javascript
async function collectBlogs(sources, outputDir) {
  const limit = pLimit(5); // Max 5 concurrent requests

  await Promise.allSettled(
    sources.map(source => limit(async () => {
      // 1. Check robots.txt
      if (!await checkRobotsTxt(source.url)) {
        throw new Error('Scraping not allowed by robots.txt');
      }

      // 2. Fetch HTML
      const html = await fetch(source.url, { headers: getHeaders() });

      // 3. Extract article content
      const $ = cheerio.load(html);
      const reader = new Readability($);
      const article = reader.parse();

      // 4. Convert to markdown
      const markdown = turndownService.turndown(article.content);

      // 5. Extract metadata
      const metadata = extractMetadata($, source);

      // 6. Save
      await saveArticle(source.id, markdown, metadata);

      // 7. Validate
      return validateExtraction({ markdown, metadata });
    }))
  );
}
```

---

## Ethical Scraping

- **Respects robots.txt**
- **Rate limiting:** 1 request/second per domain
- **User-Agent rotation**
- **No aggressive scraping**

---

*collect-blogs task v1.0.0*
