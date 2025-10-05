# 📋 Research Workflow Detalhado

Workflow passo a passo da Etapa 2 (Research) usando ferramentas nativas.

---

## 🎯 Visão Geral dos 6 Prompts

| Prompt | Input | Output | Ferramentas |
|--------|-------|--------|-------------|
| **01** source_discovery | PRD.md | Lista de fontes (memória) | WebSearch |
| **02** source_collector | Lista de fontes | sources/ organizadas | WebFetch, Bash, yt-dlp |
| **03a** temporal_mapper | sources/ | Timeline cronológica | WebFetch |
| **03b** priority_calculator | sources/ + timeline | Lista priorizada | Manual |
| **04** sources_master | sources/ | sources_master.yaml | Bash |
| **05** etl_q&a | sources/ | sources/ processadas | Bash |

---

## Fase 1: Source Discovery (Prompt 01)

**Objetivo**: Descobrir TODAS as fontes disponíveis

### Comandos:
```
"Vou criar um clone de [NOME].

Use WebSearch para descobrir:
1. Livros escritos POR [NOME] (não sobre)
2. Entrevistas longas (>30 min)
3. Podcasts principais
4. Blog pessoal ou site oficial
5. Artigos e essays autorais

Para cada fonte encontrada, liste:
- Título/Nome
- Data/Ano
- URL (se disponível)
- Tipo (livro, interview, article, etc.)
- Duração/Tamanho"
```

### Output esperado:
- Lista estruturada em memória
- Mínimo 5 fontes primárias
- URLs verificados
- Gaps identificados

---

## Fase 2: Source Collection (Prompt 02)

**Objetivo**: Coletar e organizar todas as fontes

### 2.1 Criar Estrutura

```bash
# Via Bash
mkdir -p sources/{books,interviews,articles,speeches,videos,social-media}
```

Ou via prompt:
```
"Crie a estrutura de pastas sources/ com subpastas:
books, interviews, articles, speeches, videos, social-media"
```

### 2.2 Coletar Fontes Web

```
"Para cada artigo/blog na lista:
1. Use WebFetch para extrair conteúdo de [URL]
2. Salve em sources/articles/[ano]_[titulo]/content.md
3. Crie metadata.yaml com: titulo, url, data, autor"
```

### 2.3 Coletar YouTube

```bash
# Para cada vídeo
yt-dlp --write-auto-sub --skip-download [VIDEO_URL]

# Organizar
mv *.vtt sources/interviews/[ano-mm]_[titulo]/
```

### 2.4 Criar Metadata

Para cada fonte, criar `metadata.yaml`:
```yaml
titulo: "Joe Rogan #1309 - Naval Ravikant"
tipo: interview
data: 2019-06-04
url: "https://youtube.com/watch?v=..."
duracao_min: 150
idioma: en
qualidade: 9/10
prioridade: CRITICA
```

---

## Fase 3a: Temporal Mapping (Prompt 03a)

**Objetivo**: Criar linha do tempo

```
"Analise todas as fontes em sources/ e crie timeline cronológica:

1. Liste fontes por ano/período
2. Identifique fases da vida/carreira
3. Mapeie evolução de pensamento
4. Identifique gaps temporais

Output: YAML com timeline estruturada"
```

---

## Fase 3b: Priority Calculation (Prompt 03b)

**Objetivo**: Priorizar fontes para análise

```
"Para cada fonte em sources/, calcule score baseado em:

1. Autenticidade (1-10): É do próprio clone?
2. Relevância (1-10): Essencial para entender o clone?
3. Qualidade (1-10): Audio/texto está bom?

Liste fontes ordenadas por score total (soma/3).
Indique ordem de análise recomendada."
```

---

## Fase 4: Sources Master (Prompt 04)

**Objetivo**: Criar inventário consolidado

```
"Crie sources_master.yaml agregando todas as fontes:

Incluir:
- Total de fontes por tipo
- Total de horas de áudio/vídeo
- Total de páginas/palavras
- Período coberto (ano inicial → final)
- Gaps identificados
- Estatísticas de qualidade

Salvar em: sources/sources_master.yaml"
```

---

## Fase 5: ETL & Q&A (Prompt 05)

**Objetivo**: Processar fontes para análise

```
"Para cada fonte em sources/:

1. Ler arquivo original
2. Limpar formatação (remover HTML, timestamps, etc)
3. Extrair texto puro
4. Salvar como [nome]_clean.txt
5. Validar processamento

Verificar que TODAS as fontes têm versão _clean.txt"
```

---

## ✅ Checklist de Qualidade Final

Antes de prosseguir para Etapa 3:

- [ ] Mínimo 5 fontes primárias coletadas
- [ ] Pelo menos 1 livro ou entrevista longa (>1h)
- [ ] Timeline cronológica criada
- [ ] sources_master.yaml completo
- [ ] 90%+ das fontes têm metadata.yaml
- [ ] Todas as fontes têm versão _clean.txt
- [ ] Gaps documentados em docs/LIMITATIONS.md

---

## 🎯 Output Final Esperado

```
sources/
├── books/
│   └── 2020_almanack_naval/
│       ├── content.pdf
│       ├── content_clean.txt
│       └── metadata.yaml
├── interviews/
│   └── 2019-06_joe_rogan/
│       ├── transcript.vtt
│       ├── transcript_clean.txt
│       └── metadata.yaml
├── articles/
│   └── 2018_blog_post/
│       ├── original.html
│       ├── content_clean.txt
│       └── metadata.yaml
└── sources_master.yaml
```

---

*Workflow Detalhado - v1.0*
