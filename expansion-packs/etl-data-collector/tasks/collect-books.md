# collect-books

**Task ID:** collect-books
**Agent:** document-specialist
**Elicit:** false
**Purpose:** Extract structure-preserving text from manually provided PDFs/eBooks and (future) Z-Library downloads

---

## Overview

Runs the document extraction pipeline on either (a) manually provided files (`local_path`) or (b) Z-Library downloads (future integration). Organizes chapters and metadata for downstream processing.

**Inputs:** Sources list filtered for `type: book`. For manual mode provide `local_path` pointing to the PDF/eBook placed under `inputs/books/`.

**Outputs:**
- `{output_dir}/books/{source_id}/raw.{ext}`
- `{output_dir}/books/{source_id}/metadata.json`
- `{output_dir}/pdf/{source_id}/text.txt`
- `{output_dir}/pdf/{source_id}/text_structured.md`
- `{output_dir}/pdf/{source_id}/chapters/` (if detected)
- `{output_dir}/pdf/{source_id}/metadata.json`

---

## Workflow

```javascript
async function collectBooks(sources, outputDir, collectors) {
  for (const source of sources) {
    // Prefer manual path when provided
    if (source.local_path) {
      const extraction = await collectors.pdf.extract(source.local_path, outputDir, {
        sourceId: source.id,
        metadataPath: source.metadata_path
      });
      await persistArtifacts(source.id, extraction);
      continue;
    }

    // Placeholder: future automation (Z-Library / Telegram bot)
    reportFailure(source.id, 'No local_path provided. Manual download required.');
  }
}
```

---

## OCR Support

For scanned PDFs:
- **Tool:** Tesseract (via Python)
- **Performance:** 2-5 pages/minute
- **Quality threshold:** 80%+

---

*collect-books task v1.0.0*
