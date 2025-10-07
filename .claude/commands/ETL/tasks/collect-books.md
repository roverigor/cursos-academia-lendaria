# /collect-books Task

```
purpose: "Processar livros/ebooks em PDF/EPUB"
prerequisites:
  - Caminho para PDF/EPUB
  - OCR disponível se necessário
```

## Passos
1. Detectar tipo (PDF digital/scanned, EPUB)
2. Extrair texto com pdf-parse ou OCR
3. Gerar markdown + chapters + metadata
```
