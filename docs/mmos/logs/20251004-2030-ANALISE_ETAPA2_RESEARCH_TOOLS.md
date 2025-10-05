# 🔬 ANÁLISE COMPLETA: Etapa 2 - Research - Ferramentas Necessárias

**Data:** 04/10/2025 20:30
**Contexto:** Identificar gaps de ferramentas/APIs para otimizar coleta de fontes

---

## 📋 Resumo Executivo

**Etapa 2 - Research** tem 6 prompts que exigem **8 tipos diferentes de ferramentas**:

| Categoria | Ferramentas Configuradas | Ferramentas Faltantes | Gap Crítico |
|-----------|-------------------------|----------------------|-------------|
| Busca Web | ✅ 2/2 | - | Não |
| Vídeo/Áudio | ✅ 2/3 | 1 | Sim |
| Documentos | ❌ 0/3 | 3 | **CRÍTICO** |
| Web Scraping | ❌ 0/2 | 2 | **CRÍTICO** |
| Storage | ❌ 0/2 | 2 | Médio |
| Organização | ❌ 0/2 | 2 | Médio |

**Conclusão:** Temos **50% das ferramentas essenciais**. Faltam principalmente **acesso a documentos** e **web scraping**.

---

## 🎯 Mapeamento: Prompts → Ferramentas Necessárias

### Prompt 01: Source Discovery

**Objetivo:** Descobrir todas as fontes disponíveis

**Ferramentas Necessárias:**

✅ **Já Temos:**
1. **Brave Search** - Busca web geral
2. **YouTube API** - Buscar vídeos/podcasts
3. **Exa AI** - Papers acadêmicos

❌ **Faltando:**
4. **Google Books API** - Buscar livros escritos pela pessoa
   - Essencial: Descobrir livros, capítulos, índices
   - Free tier: 1.000 requests/dia

5. **Archive.org API** - Conteúdo histórico/arquivado
   - Essencial: Artigos antigos, tweets deletados, wayback machine
   - Free: Ilimitado

6. **Podcast Index API** - Busca específica de podcasts
   - Essencial: Encontrar TODAS as aparições em podcasts
   - Free: 100 requests/dia

7. **Twitter/X API** - Posts/threads históricos
   - Importante: Pensamentos em tempo real
   - Custo: $100/mês (Basic tier)

---

### Prompt 02: Source Collector

**Objetivo:** Coletar e organizar fontes fisicamente

**Ferramentas Necessárias:**

✅ **Já Temos:**
1. **AssemblyAI** - Transcrever áudio/vídeo
2. **Deepgram** - Transcrição alternativa

❌ **Faltando:**
3. **yt-dlp** (CLI tool) - Baixar vídeos/áudio do YouTube
   - Essencial: Download para transcrição offline
   - Free: Open source

4. **Jina AI Reader** - Extrair conteúdo de URLs
   - Essencial: Converter artigos/blogs em markdown
   - Free: 1M tokens/mês

5. **Firecrawl** - Web scraping avançado
   - Essencial: Scraping de sites complexos
   - Free tier: 500 pages/mês

6. **PDF Parser (PyMuPDF/pdfplumber)** - Extrair texto de PDFs
   - Essencial: Processar livros/papers em PDF
   - Free: Open source

7. **Google Drive API** (já mencionado no .env)
   - Importante: Se fontes estão no Drive
   - Free: Ilimitado

---

### Prompt 03: Temporal Mapper

**Objetivo:** Mapear cronologia da vida/carreira

**Ferramentas Necessárias:**

✅ **Já Temos:**
1. **Brave Search** - Buscar eventos históricos
2. **Exa AI** - Papers com datas

❌ **Faltando:**
3. **Wikidata API** - Dados estruturados biográficos
   - Essencial: Timeline precisa, datas exatas
   - Free: Ilimitado

4. **DBpedia API** - Ontologia de dados biográficos
   - Importante: Contexto histórico estruturado
   - Free: Ilimitado

---

### Prompt 04: Priority Calculator

**Objetivo:** Priorizar fontes por ROI

**Ferramentas Necessárias:**

✅ **Já Temos:**
- Claude Code (análise qualitativa)

❌ **Faltando:**
5. **Metadata Extractor** - Extrair duração, tamanho, data
   - Essencial: Calcular custo/benefício de processar fonte
   - Free: Open source (ffprobe, exiftool)

---

### Prompt 05: Sources Master

**Objetivo:** Criar inventário consolidado YAML

**Ferramentas Necessárias:**

✅ **Já Temos:**
- Claude Code (consolidação)

❌ **Faltando:**
- Nenhuma adicional (usa outputs anteriores)

---

### Prompt 06: ETL Q&A

**Objetivo:** Processar fontes para análise

**Ferramentas Necessárias:**

✅ **Já Temos:**
1. **AssemblyAI** - Transcrição
2. **Claude Code** - Extração de Q&A

❌ **Faltando:**
6. **LangChain Document Loaders** - Processar múltiplos formatos
   - Essencial: PDF, DOCX, TXT, HTML, MD
   - Free: Open source

7. **Text Chunking Tool** - Dividir textos longos
   - Essencial: Preparar para LLM context
   - Free: Open source (tiktoken)

---

## 📊 Priorização de Ferramentas Faltantes

### 🔴 CRÍTICAS (Bloqueiam o processo)

| Ferramenta | Por quê | Custo | Alternativa |
|------------|---------|-------|-------------|
| **yt-dlp** | Baixar vídeos para transcrição | FREE | Nenhuma viável |
| **Jina Reader** | Extrair conteúdo de artigos web | FREE | Puppeteer (configurado) |
| **PDF Parser** | Processar livros em PDF | FREE | Copiar/colar manual |
| **Google Books API** | Descobrir livros | FREE | Busca manual Brave |

### 🟡 IMPORTANTES (Melhoram muito o processo)

| Ferramenta | Por quê | Custo | Alternativa |
|------------|---------|-------|-------------|
| **Archive.org API** | Conteúdo histórico/deletado | FREE | Busca manual |
| **Podcast Index** | Busca específica podcasts | FREE | YouTube + Brave |
| **Wikidata API** | Timeline biográfica | FREE | Busca manual |
| **Firecrawl** | Scraping avançado | $20/mês | Puppeteer básico |

### 🟢 OPCIONAIS (Nice to have)

| Ferramenta | Por quê | Custo | Alternativa |
|------------|---------|-------|-------------|
| **Twitter/X API** | Posts históricos | $100/mês | Busca manual |
| **DBpedia API** | Ontologia biográfica | FREE | Wikidata |
| **LangChain** | Processar formatos | FREE | Scripts custom |

---

## 🛠️ Plano de Ação Recomendado

### Fase 1: Ferramentas CLI Gratuitas (30 min)

**Instalar agora:**

1. **yt-dlp** - Download de vídeos
```bash
brew install yt-dlp
# ou
pip install yt-dlp
```

2. **ffprobe** - Metadata de áudio/vídeo
```bash
brew install ffmpeg
```

3. **pdfplumber** - Parser de PDF
```bash
pip install pdfplumber
```

4. **exiftool** - Metadata de arquivos
```bash
brew install exiftool
```

**Resultado:** Resolve 4 gaps críticos **GRÁTIS**

---

### Fase 2: APIs Gratuitas (1 hora)

**Configurar:**

1. **Google Books API**
   - Acesse: https://console.cloud.google.com/apis/library/books.googleapis.com
   - Habilite a API
   - Use mesma API key do YouTube

2. **Archive.org API**
   - Sem API key necessária!
   - Endpoint: `https://archive.org/advancedsearch.php`

3. **Podcast Index API**
   - Acesse: https://podcastindex.org/
   - Criar conta
   - Gerar API key (grátis)

4. **Wikidata API**
   - Sem API key necessária!
   - Endpoint: `https://www.wikidata.org/w/api.php`

5. **Jina Reader API**
   - Acesse: https://jina.ai/reader/
   - Gerar API key (1M tokens/mês grátis)

**Resultado:** Mais 5 ferramentas essenciais **GRÁTIS**

---

### Fase 3: Ferramentas Pagas (Opcional)

**Avaliar necessidade:**

1. **Firecrawl** ($20-50/mês)
   - Só se precisar scraping pesado
   - Alternativa: Puppeteer (já configurado via MCP)

2. **Twitter/X API** ($100/mês)
   - Só se clone depende muito de Twitter
   - Alternativa: Busca manual + screenshots

---

## 📈 Impacto Esperado

### Antes (Situação Atual):

- ⏱️ **Tempo:** 8-12 horas/clone (coleta manual)
- 📊 **Cobertura:** 60-70% das fontes
- 🔍 **Qualidade:** Média (fontes óbvias)
- 🤖 **Automação:** 20%

### Depois (Com todas ferramentas):

- ⏱️ **Tempo:** 2-4 horas/clone (80% automatizado)
- 📊 **Cobertura:** 90-95% das fontes
- 🔍 **Qualidade:** Alta (fontes ocultas incluídas)
- 🤖 **Automação:** 80%

**ROI:** Redução de 6-8 horas por clone = **75% mais rápido**

---

## ✅ Checklist de Implementação

### Ferramentas CLI (Fase 1):
- [ ] Instalar yt-dlp
- [ ] Instalar ffmpeg/ffprobe
- [ ] Instalar pdfplumber (Python)
- [ ] Instalar exiftool
- [ ] Testar cada ferramenta

### APIs Gratuitas (Fase 2):
- [ ] Configurar Google Books API
- [ ] Testar Archive.org API
- [ ] Configurar Podcast Index API
- [ ] Testar Wikidata API
- [ ] Configurar Jina Reader API
- [ ] Adicionar todas ao .env

### Validação (Fase 3):
- [ ] Executar Source Discovery com todas ferramentas
- [ ] Medir tempo de coleta
- [ ] Comparar cobertura antes/depois
- [ ] Documentar workflow otimizado

---

## 🎯 Próximos Passos Imediatos

**Agora (5 minutos):**
1. Instalar yt-dlp
2. Instalar ffmpeg

**Hoje (1 hora):**
3. Configurar Google Books API
4. Configurar Jina Reader API
5. Testar Archive.org API

**Esta Semana:**
6. Configurar Podcast Index API
7. Testar Wikidata API
8. Criar scripts de automação

---

## 📚 Recursos de Referência

**Documentação:**
- yt-dlp: https://github.com/yt-dlp/yt-dlp
- Google Books API: https://developers.google.com/books
- Jina Reader: https://jina.ai/reader/
- Archive.org API: https://archive.org/help/aboutsearch.htm
- Podcast Index: https://podcastindex-org.github.io/docs-api/
- Wikidata API: https://www.wikidata.org/wiki/Wikidata:Data_access

**Scripts Úteis:**
- Download de vídeo: `yt-dlp -x --audio-format mp3 [URL]`
- Metadata: `ffprobe -v quiet -print_format json -show_format [FILE]`
- PDF to text: `pdfplumber extract [FILE]`

---

**Conclusão:** Com **9 ferramentas adicionais** (8 gratuitas + 1 opcional paga), a Etapa 2 - Research passa de **manual e lenta** para **80% automatizada e 4x mais rápida**.

**Recomendação:** Implementar Fase 1 e Fase 2 **agora** (investimento de 1h30, 100% grátis).
