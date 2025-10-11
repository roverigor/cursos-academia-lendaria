# Blog Discovery - Smart Post Collection

Sistema inteligente para descobrir e selecionar posts de blogs usando regras automáticas.

## 🎯 Regras Inteligentes

O sistema aplica automaticamente as seguintes regras (em ordem de prioridade):

### Rule 1: Posts em Destaque (TOP/Featured)
Se o blog tiver posts marcados como destaque/featured/sticky, captura apenas eles.

**Detecta:**
- Posts com flag `featured: true` no RSS
- Posts com flag `sticky: true` no RSS
- Posts em categorias: "featured", "top", "best", "highlight"
- Classes CSS: `.featured`, `.sticky`, `.pinned` (HTML scraping)

### Rule 2: Últimos 3 Anos
Se não houver posts em destaque, captura todos os posts dos últimos 3 anos.

**Filtro:**
- Data de publicação >= (hoje - 3 anos)
- Útil para blogs com conteúdo recente e relevante

### Rule 3: Captura Total (< 50 posts)
Se o blog tiver menos de 50 posts no total, captura 100%.

**Rationale:**
- Blogs pequenos: melhor capturar tudo
- Overhead de filtrar não compensa
- Garante completude do dataset

## 🚀 Uso

### CLI Standalone

```bash
cd expansion-packs/etl-data-collector

# Descobrir posts de um blog
node discover-blog-posts.js <blog-url> [output-file]

# Exemplo: Sam Altman
node discover-blog-posts.js https://blog.samaltman.com sam-blog-sources.yaml
```

### Output

Gera arquivo YAML com:

```yaml
sources:
  - id: blog-samaltman-com-1
    title: "How to Be Successful"
    type: blog
    url: https://blog.samaltman.com/how-to-be-successful
    slug: how-to-be-successful        # ← Usado como filename
    published: '2019-01-24T21:01:07.000Z'
    featured: false
    categories: []

metadata:
  total_discovered: 30
  discovery_date: '2025-10-11T22:52:12.450Z'
  rules_applied:
    - 'Rule 3: Capture 100% (total < 50)'
```

### Integração com Collection

Após discovery, usar o arquivo gerado para coletar os posts:

```bash
node run-collection.js \
  sam-blog-sources.yaml \
  ../../docs/minds/sam_altman/sources/downloads \
  ./config/download-rules.yaml
```

Posts serão salvos como `slug.md` (ex: `how-to-be-successful.md`).

## 📊 Métodos de Descoberta

### Método 1: RSS/Atom Feed (Preferido)

**Vantagens:**
- Metadados completos (título, data, categorias)
- Detecção de posts featured/sticky
- Mais confiável

**Detecta feeds via:**
1. HTML `<link rel="alternate" type="application/rss+xml">`
2. URLs comuns: `/feed`, `/rss`, `/atom.xml`, `/feed.xml`

### Método 2: HTML Scraping (Fallback)

**Quando usar:**
- Blog sem RSS feed
- Feed inacessível

**Selectors utilizados:**
```javascript
'article a[href*="/blog/"]'
'article a[href*="/post/"]'
'.post a[href]'
'.entry a[href]'
'h2 a[href]'
'.blog-post a[href]'
```

**Limitações:**
- Sem data de publicação
- Sem categorias
- Detecção de featured apenas via CSS classes

## 🔧 Configuração Avançada

### Customizar Regras

```javascript
import { BlogDiscovery } from './scripts/utils/blog-discovery.js';

const discovery = new BlogDiscovery({
  minPostsForFilter: 50,     // Rule 3: threshold para captura total
  yearsToCapture: 3,          // Rule 2: quantos anos capturar
  maxRetries: 2,              // Retries em caso de falha
  timeout: 30000,             // Timeout HTTP (ms)
  userAgent: 'MyBot/1.0'      // User-Agent customizado
});

const posts = await discovery.discoverPosts('https://blog.example.com');
```

### Filtros de URL

Sistema ignora automaticamente:
- Tags: `/tag/`, `/category/`
- Autores: `/author/`
- Navegação: `/page/`, `/archive`
- Assets: `.jpg`, `.png`, `.pdf`

## 📋 Exemplos

### Exemplo 1: Blog Grande (> 50 posts) com Featured

```bash
node discover-blog-posts.js https://techcrunch.com/blog techcrunch.yaml
```

**Output:**
```
📊 Total posts: 150
⭐ Rule 1: Found 12 featured/sticky posts
✅ Selected 12 posts
```

### Exemplo 2: Blog Médio (> 50 posts) sem Featured

```bash
node discover-blog-posts.js https://stripe.com/blog stripe.yaml
```

**Output:**
```
📊 Total posts: 85
📅 Rule 2: Found 42 posts from last 3 years
✅ Selected 42 posts
```

### Exemplo 3: Blog Pequeno (< 50 posts)

```bash
node discover-blog-posts.js https://blog.samaltman.com sam.yaml
```

**Output:**
```
📊 Total posts: 30
📋 Rule 3: Total posts (30) < 50, capturing 100%
✅ Selected 30 posts
```

## 🧪 Testes

### Testar com Blog Real

```bash
# Descobrir posts
node discover-blog-posts.js https://blog.example.com test.yaml

# Verificar output
cat test.yaml

# Coletar primeiro post (teste)
node run-collection.js test.yaml ./test-output
```

### Validar Slugs

Todos os posts devem ter slugs válidos:

```bash
# Verificar se slugs estão corretos
grep "slug:" test.yaml
```

Expected format: `slug: how-to-be-successful` (lowercase, hyphens, no special chars)

## ⚡ Performance

### Métricas Esperadas

| Blog Size | Method | Discovery Time | Posts Selected |
|-----------|--------|----------------|----------------|
| Small (< 50) | RSS | 2-5s | 100% |
| Medium (50-200) | RSS | 3-8s | Last 3 years |
| Large (> 200) | RSS | 5-15s | Featured only |

### Otimizações

- Cache de feeds RSS (evitar re-fetch)
- Parallel discovery para múltiplos blogs
- Rate limiting automático

## 🔍 Troubleshooting

### Problema: "No RSS feed found"

**Solução:**
1. Verificar manualmente se blog tem feed
2. Adicionar URL do feed explicitamente
3. Usar HTML scraping como fallback

### Problema: "No posts found"

**Causas:**
- Blog usa JavaScript para carregar posts
- Selectors CSS não cobrem estrutura do blog
- Blog requer autenticação

**Solução:**
1. Inspecionar HTML do blog
2. Adicionar selectors customizados
3. Usar API do blog se disponível

### Problema: "Slugs incorretos"

**Causas:**
- URLs não seguem padrão `/slug`
- URLs tem query params

**Solução:**
- Fornecer slugs manualmente no sources YAML
- Customizar `_extractSlugFromUrl()` method

## 📚 API Reference

### `BlogDiscovery`

#### Constructor

```javascript
new BlogDiscovery(options)
```

**Options:**
- `minPostsForFilter` (default: 50) - Rule 3 threshold
- `yearsToCapture` (default: 3) - Rule 2 years
- `maxRetries` (default: 2) - HTTP retries
- `timeout` (default: 30000) - HTTP timeout ms
- `userAgent` (default: AIOS-ETL-BlogDiscovery/1.0)

#### Methods

##### `discoverPosts(blogUrl, options)`

Descobre posts do blog usando smart rules.

**Params:**
- `blogUrl` (string) - URL raiz do blog
- `options` (object) - Opções de discovery

**Returns:** `Promise<Array<Post>>`

**Post Object:**
```javascript
{
  url: string,
  title: string,
  published: Date,
  isFeatured: boolean,
  isSticky: boolean,
  categories: string[],
  slug: string
}
```

##### `generateSourcesYAML(posts, options)`

Gera YAML de sources para ETL collection.

**Params:**
- `posts` (Array) - Posts descobertos
- `options.idPrefix` (string) - Prefix para IDs

**Returns:** `{ sources, metadata }`

## 🎓 Casos de Uso

### 1. Mind Mapping (MMOS)

Descobrir todos os posts de um autor para análise cognitiva:

```bash
# Descobrir posts
node discover-blog-posts.js https://blog.samaltman.com sam-posts.yaml

# Coletar
node run-collection.js sam-posts.yaml ./downloads

# Posts salvos como slug.md para Phase 3 (Cognitive Analysis)
```

### 2. Content Aggregation

Agregar conteúdo de múltiplos blogs:

```bash
for blog in blog1.com blog2.com blog3.com; do
  node discover-blog-posts.js https://$blog ${blog}-posts.yaml
done
```

### 3. Archive Backup

Backup completo de blogs pequenos:

```bash
# Rule 3 garante captura 100% se < 50 posts
node discover-blog-posts.js https://personal-blog.com backup.yaml
node run-collection.js backup.yaml ./archive
```

## 🔗 Integração MMOS

Para usar no pipeline MMOS Mind Mapper:

```yaml
# research-collection task
- step: discover_blog_posts
  tool: blog-discovery
  input: "{mindName} blog URL"
  output: "{mindDir}/sources/blog-posts-discovered.yaml"

- step: collect_blog_posts
  tool: etl-collector
  input: "{mindDir}/sources/blog-posts-discovered.yaml"
  output: "{mindDir}/sources/downloads/blogs"
```

Todos os posts serão salvos como `{slug}.md` no diretório blogs.

---

**Versão:** 1.0
**Última atualização:** 2025-10-11
**Autor:** AIOS ETL Data Collector Team
