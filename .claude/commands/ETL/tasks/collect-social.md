# /collect-social Task

```
purpose: "Coletar threads/postagens de Twitter, Reddit, LinkedIn"
prerequisites:
  - download-rules.allow_scrape configurado se scraping
  - API keys quando disponíveis
```

## Passos
1. Identificar plataforma a partir da URL
2. Preferir API → fallback scraping controlado
3. Normalizar conteúdo (markdown + metadata)
4. Tratar rate limits (backoff exponencial)
```
