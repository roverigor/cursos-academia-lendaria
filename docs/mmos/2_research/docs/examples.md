# 📚 Exemplos Práticos - Research

Exemplos completos de research usando ferramentas nativas.

---

## 🎯 Exemplo Completo: Naval Ravikant

### Fase 1: Source Discovery

**Prompt usado:**
```
"Vou criar um clone de Naval Ravikant.

Use WebSearch para descobrir:
1. Livros escritos POR Naval Ravikant
2. Entrevistas longas (>30 min)
3. Podcasts principais
4. Blog pessoal ou artigos autorais"
```

**Output obtido:**
```markdown
# Fontes Descobertas - Naval Ravikant

## Livros
- The Almanack of Naval Ravikant (2020)

## Entrevistas/Podcasts
- Joe Rogan Experience #1309 (2019) - 2h30min
- Tim Ferriss Show #97 (2015) - 1h45min
- Tim Ferriss Show #136 (2016) - 1h30min
- Tim Ferriss Show #473 (2018) - 2h
- The Knowledge Project
- Farnam Street podcast

## Artigos/Blog
- nav.al (blog pessoal) - 50+ posts
- Twitter threads compilados

Total: 47 fontes primárias identificadas
```

---

### Fase 2: Source Collection

#### 2.1 Estrutura Criada

```bash
mkdir -p sources/{books,interviews,articles,social-media}
```

#### 2.2 Coletar Entrevista (Joe Rogan)

```bash
# Download de legendas
yt-dlp --write-auto-sub --skip-download https://youtube.com/watch?v=3qHkcs3kG44

# Organizar
mkdir sources/interviews/2019-06_joe_rogan_1309
mv *.vtt sources/interviews/2019-06_joe_rogan_1309/transcript.vtt
```

**Metadata criada** (`sources/interviews/2019-06_joe_rogan_1309/metadata.yaml`):
```yaml
titulo: "Joe Rogan Experience #1309 - Naval Ravikant"
tipo: interview
data: 2019-06-04
url: "https://youtube.com/watch?v=3qHkcs3kG44"
duracao_min: 150
idioma: en
transcricao: transcript.vtt
qualidade: 9/10
prioridade: CRITICA
topicos:
  - Filosofia e felicidade
  - Investimento em startups
  - Meditação e espiritualidade
```

#### 2.3 Coletar Blog (nav.al)

**Prompt:**
```
"Use WebFetch para extrair todos os posts de https://nav.al
Para cada post, salve em sources/articles/[ano]_[titulo]/content.md"
```

**Estrutura resultante:**
```
sources/articles/
├── 2018_how_to_get_rich/
│   ├── content.md
│   └── metadata.yaml
├── 2019_the_almanack/
│   ├── content.md
│   └── metadata.yaml
└── [outros 48 posts]
```

---

### Fase 3a: Temporal Mapping

**Output - Timeline:**
```yaml
# Timeline Naval Ravikant

periodos:
  early_career:
    anos: "1999-2006"
    fontes: 3
    eventos:
      - Fundação Epinions (1999)
      - Exit Epinions (2003)

  peak_investing:
    anos: "2007-2015"
    fontes: 18
    eventos:
      - AngelList fundado (2010)
      - Investimentos Uber, Twitter

  philosophical_maturity:
    anos: "2016-presente"
    fontes: 26
    eventos:
      - Podcasts principais
      - The Almanack (2020)
      - Foco em sabedoria/felicidade

gaps:
  - "1999-2005: Pouco documentado (startup phase)"
  - "Vida pessoal limitada (por design)"
```

---

### Fase 3b: Priority Calculation

**Output - Priorização:**
```yaml
# Priority Order - Naval Ravikant

CRITICA:
  - sources/books/2020_almanack_naval/
    autenticidade: 10
    relevancia: 10
    qualidade: 9.5
    score: 9.8

  - sources/interviews/2015-08_tim_ferriss_097/
    autenticidade: 10
    relevancia: 9.5
    qualidade: 9.5
    score: 9.7

  - sources/interviews/2019-06_joe_rogan_1309/
    autenticidade: 10
    relevancia: 9.5
    qualidade: 9
    score: 9.5

ALTA:
  - sources/articles/nav_al_blog/ (50 posts)
    score_medio: 8.5

MEDIA:
  - Outras entrevistas (12)
  - Talks e apresentações
```

---

### Fase 4: Sources Master

**Output** (`sources/sources_master.yaml`):
```yaml
# Sources Master - Naval Ravikant

clone_info:
  nome: "Naval Ravikant"
  periodo_coberto: "1999-2024"
  total_fontes: 47

estatisticas:
  fontes_primarias: 42 (89%)
  fontes_secundarias: 5 (11%)

  por_tipo:
    livros: 1
    interviews: 15
    articles: 50
    talks: 7

  por_periodo:
    early_career: 3 (6%)
    peak_investing: 18 (38%)
    philosophical_maturity: 26 (55%)

qualidade:
  autenticidade_media: 9.2/10
  relevancia_media: 8.8/10
  qualidade_tecnica: 8.5/10

gaps:
  - "Período 1999-2005 pouco documentado"
  - "Vida pessoal limitada (intencional)"
  - "Detalhes de investimentos (confidenciais)"

status: PRONTO_PARA_ANALISE
```

---

### Fase 5: ETL & Q&A

**Processamento executado:**
```
Para cada fonte em sources/:
✅ Ler arquivo original
✅ Limpar formatação (remover HTML, VTT timestamps)
✅ Extrair texto puro
✅ Salvar como *_clean.txt

Resultado:
✅ 1/1 livros processados
✅ 15/15 interviews processados
✅ 50/50 articles processados
✅ 8/8 podcasts processados

Total: 47/47 fontes (100%)
```

---

## 📊 Estrutura Final (Naval Example)

```
sources/
├── books/
│   └── 2020_almanack_naval/
│       ├── almanack.pdf
│       ├── almanack_clean.txt
│       └── metadata.yaml
│
├── interviews/
│   ├── 2015-08_tim_ferriss_097/
│   │   ├── transcript.vtt
│   │   ├── transcript_clean.txt
│   │   └── metadata.yaml
│   ├── 2019-06_joe_rogan_1309/
│   │   ├── transcript.vtt
│   │   ├── transcript_clean.txt
│   │   └── metadata.yaml
│   └── [13 outras]
│
├── articles/
│   ├── 2018_how_to_get_rich/
│   │   ├── content.md
│   │   ├── content_clean.txt
│   │   └── metadata.yaml
│   └── [49 outros]
│
└── sources_master.yaml
```

---

## ⏱️ Tempo Investido (Exemplo Real)

| Fase | Fontes | Tempo Real |
|------|--------|------------|
| Source Discovery | 47 | 1.5h |
| Source Collection | 47 | 6h |
| Temporal Mapping | - | 1h |
| Priority Calc | - | 30min |
| Sources Master | - | 45min |
| ETL & Q&A | 47 | 2h |
| **TOTAL** | **47** | **~12h** |

---

## ✅ Checklist Final (Naval)

- [x] 47 fontes primárias coletadas (>>5 mínimo)
- [x] 1 livro + 15 entrevistas longas
- [x] Timeline completa (1999-2024)
- [x] sources_master.yaml criado
- [x] 100% das fontes com metadata.yaml
- [x] 100% das fontes processadas (_clean.txt)
- [x] Gaps documentados

**Status**: ✅ PRONTO PARA ETAPA 3 (ANALYSIS)

---

*Examples - Naval Ravikant - v1.0*
