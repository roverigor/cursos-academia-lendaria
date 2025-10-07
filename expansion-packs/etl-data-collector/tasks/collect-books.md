# collect-books

**Task ID:** collect-books
**Agent:** document-specialist
**Elicit:** false
**Purpose:** Extract text from PDFs and eBooks with structure preservation

---

## Overview

Processes PDF/eBook files, detects if scanned (OCR needed), extracts text with structure, and splits into chapters.

**Inputs:** Sources list filtered for `type: pdf`, `type: book`, `type: ebook`

**Outputs:**
- `{output_dir}/pdf/{source_id}/text.txt`
- `{output_dir}/pdf/{source_id}/text_structured.md`
- `{output_dir}/pdf/{source_id}/chapters/` (if detected)
- `{output_dir}/pdf/{source_id}/metadata.json`

---

## Workflow

```javascript
async function collectBooks(sources, outputDir) {
  for (const source of sources) {
    // 1. Download PDF if URL provided
    const filePath = source.local_path || await downloadFile(source.url);

    // 2. Detect if scanned
    const isScanned = await detectScannedPDF(filePath);

    // 3. Extract text
    let text;
    if (isScanned) {
      text = await ocrPDF(filePath); // Python Tesseract
    } else {
      const pdf = await pdfParse(fs.readFileSync(filePath));
      text = pdf.text;
    }

    // 4. Analyze structure (chapters)
    const structure = analyzeStructure(text);

    // 5. Save
    await saveDocument(source.id, {
      text,
      structure,
      metadata: { isScanned, pageCount: structure.pageCount }
    });
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
