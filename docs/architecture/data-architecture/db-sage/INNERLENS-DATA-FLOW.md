# 🔄 InnerLens → Supabase: Fluxo de Dados Completo

**Pergunta:** "Onde o InnerLens vai processar os dados e gerar fragmentos?"

---

## 📍 Mapeamento de Dados: De Onde Vem, Para Onde Vai

### 🗂️ Estrutura Atual

```
outputs/minds/
├── alan_nicolas/
│   ├── sources/              ← 📥 INPUT: Aqui estão os textos
│   │   ├── modelo-do-eu.md
│   │   ├── Q&A.md
│   │   ├── profile.json
│   │   └── ... (outros arquivos .txt, .md)
│   │
│   ├── analysis/             ← (não usado pelo InnerLens)
│   ├── synthesis/            ← (não usado pelo InnerLens)
│   └── kb/                   ← (KB manual - vamos SUBSTITUIR)
│
├── adriano_de_marqui/
│   └── sources/              ← 📥 INPUT
│
└── ... (37 minds no total)
```

---

## 🔄 Fluxo Completo de Dados

### Etapa por Etapa

```
┌─────────────────────────────────────────────────────────────┐
│ 1️⃣ ENTRADA: Sources (Filesystem)                             │
└─────────────────────────────────────────────────────────────┘
   📁 outputs/minds/{mind}/sources/*.txt
   📁 outputs/minds/{mind}/sources/*.md
   📁 outputs/minds/{mind}/sources/*.json

          ↓ [Script lê e concatena]

┌─────────────────────────────────────────────────────────────┐
│ 2️⃣ TEMP: Source Text Unificado                              │
└─────────────────────────────────────────────────────────────┘
   📄 temp/{mind}_source.txt (arquivo temporário)
   Exemplo: "Eu valorizo clareza acima de tudo. Sempre busco..."
   Tamanho: 1000-20000 palavras

          ↓ [InnerLens extrai via LLM]

┌─────────────────────────────────────────────────────────────┐
│ 3️⃣ PROCESSAMENTO: InnerLens Extraction (Claude Sonnet 4)    │
└─────────────────────────────────────────────────────────────┘
   🤖 Claude Sonnet 4 API
   📍 Roda em: Anthropic Cloud (via API)

   Prompt para Claude:
   "Extract MIUs from this text following 6 fragmentation rules..."

   Input: temp/{mind}_source.txt
   Output: temp/{mind}_fragments.json

          ↓ [MIUs extraídos]

┌─────────────────────────────────────────────────────────────┐
│ 4️⃣ TEMP: Fragments JSON                                     │
└─────────────────────────────────────────────────────────────┘
   📄 temp/{mind}_fragments.json

   Estrutura:
   {
     "metadata": {
       "subject_id": "alan_nicolas",
       "mius_extracted": 187,
       "source_word_count": 15420
     },
     "fragments": [
       {
         "fragment_id": "f_alan_001",
         "content": {
           "verbatim": "Eu valorizo clareza acima de tudo."
         },
         "structure": { "pronouns": ["eu"], ... }
       },
       ...
     ]
   }

          ↓ [Script Python salva]

┌─────────────────────────────────────────────────────────────┐
│ 5️⃣ DATABASE: Supabase PostgreSQL                            │
└─────────────────────────────────────────────────────────────┘
   ☁️ Supabase Cloud Database
   📍 URL: uvoikabnkjfvcccjeypi.supabase.co

   Tables:
   - minds (UUID, slug, display_name)
   - sources (UUID, mind_id, title, url, type)
   - fragments (UUID, mind_id, source_id, content, metadata)

          ↓ [OpenAI gera embeddings]

┌─────────────────────────────────────────────────────────────┐
│ 6️⃣ EMBEDDINGS: OpenAI API                                   │
└─────────────────────────────────────────────────────────────┘
   🤖 OpenAI text-embedding-3-small
   📍 Roda em: OpenAI Cloud (via API)

   Input: fragment.content (texto)
   Output: vector(1536) [0.123, 0.456, ...]

   Atualiza: fragments.embedding

          ↓ [RAG ready!]

┌─────────────────────────────────────────────────────────────┐
│ 7️⃣ FINAL: Fragments RAG-Ready                               │
└─────────────────────────────────────────────────────────────┘
   ✅ Supabase: fragments table
   ✅ Content: texto verbatim
   ✅ Embedding: vector 1536d
   ✅ Metadata: InnerLens structure em JSONB

   Pronto para RAG search!
```

---

## 📍 Onde Cada Componente Roda

| Componente | Onde Roda | O Que Precisa |
|------------|-----------|---------------|
| **1. Source Collection** | 🖥️ Local (script bash) | Filesystem access |
| **2. InnerLens Extraction** | ☁️ Anthropic Cloud | `ANTHROPIC_API_KEY` |
| **3. Fragment Saving** | ☁️ Supabase Cloud | `SUPABASE_DB_URL` |
| **4. Embedding Generation** | ☁️ OpenAI Cloud | `OPENAI_API_KEY` |
| **5. RAG Search** | ☁️ Supabase Cloud | Query com embeddings |

---

## 🔍 Detalhamento: Onde InnerLens Processa

### InnerLens NÃO roda localmente (processamento pesado)

**O que acontece:**
1. **Script local** lê arquivos de `outputs/minds/{mind}/sources/`
2. **Envia texto** para Claude Sonnet 4 API (Anthropic Cloud)
3. **Claude processa** (extração de MIUs via LLM)
4. **Retorna JSON** com fragments
5. **Script salva** no Supabase

**Analogia:**
```
Local Machine          Anthropic Cloud        Supabase Cloud
     |                       |                      |
     |--- Envia texto ------>|                      |
     |                       |                      |
     |                [Claude processa]             |
     |                       |                      |
     |<-- Retorna MIUs ------|                      |
     |                       |                      |
     |----------- Salva fragments ---------------->|
     |                       |                      |
```

---

## 📦 O Que Precisa Estar Configurado

### 1. Variáveis de Ambiente (.env)

```bash
# Supabase (PostgreSQL)
SUPABASE_DB_URL=postgresql://postgres.xxx:password@aws-1-us-east-2.pooler.supabase.com:5432/postgres?sslmode=require

# Anthropic (Claude para extração de MIUs)
ANTHROPIC_API_KEY=sk-ant-api03-xxx

# OpenAI (Embeddings)
OPENAI_API_KEY=sk-xxx
```

### 2. Estrutura de Dados de Entrada

```
outputs/minds/{mind_slug}/sources/
├── *.txt   ← Textos em português
├── *.md    ← Markdown files
└── *.json  ← JSON profiles (opcional)
```

**Requisitos:**
- ✅ Pelo menos 1 arquivo com texto
- ✅ Mínimo 500 palavras (idealmente 1000-2000)
- ✅ Português ou inglês
- ✅ Primeira pessoa ("eu", "I")

### 3. Dependências Python

```bash
# InnerLens dependencies
pip install anthropic psycopg2-binary python-dotenv
```

### 4. Dependências Node.js

```bash
# Para embeddings
npm install pg openai dotenv
```

---

## 🎯 Exemplo Prático: Alan Nicolas

### INPUT (O que existe)

```
outputs/minds/alan_nicolas/sources/
├── modelo-do-eu.md          (51KB, 389 linhas)
├── Q&A.md                   (173KB, 4000+ linhas)
├── alan-nicolas-profile.json (513 linhas)
└── clones-ia.md             (71KB)

Total: ~300KB de texto (~50,000 palavras)
```

### PROCESSING (O que acontece)

```bash
# 1. Script concatena sources
cat outputs/minds/alan_nicolas/sources/*.txt *.md > temp/alan_source.txt

# 2. InnerLens envia para Claude
curl https://api.anthropic.com/v1/messages \
  -d '{
    "model": "claude-sonnet-4-20250514",
    "messages": [{
      "role": "user",
      "content": "Extract MIUs from this text: ..."
    }]
  }'

# 3. Claude retorna MIUs (JSON)
{
  "fragments": [
    { "fragment_id": "f_alan_001", ... },
    { "fragment_id": "f_alan_002", ... },
    ...
  ]
}

# 4. Script salva no Supabase
INSERT INTO fragments (mind_id, content, metadata, ...)
VALUES (...), (...), ...

# 5. OpenAI gera embeddings
curl https://api.openai.com/v1/embeddings \
  -d '{ "model": "text-embedding-3-small", "input": "..." }'

# 6. Atualiza fragments com embeddings
UPDATE fragments SET embedding = [...] WHERE id = ...
```

### OUTPUT (O que fica no Supabase)

```sql
-- Mind entry
INSERT INTO minds (slug, display_name)
VALUES ('alan_nicolas', 'Alan Nicolas');

-- Source entry
INSERT INTO sources (mind_id, title, type)
VALUES (
  uuid_alan,
  'InnerLens Extraction 2025-10-27',
  'self_analysis'
);

-- Fragments (exemplo: 187 fragments)
INSERT INTO fragments (mind_id, source_id, content, metadata, embedding)
VALUES
  (uuid_alan, uuid_source, 'Eu valorizo clareza...', {...}, [0.123, ...]),
  (uuid_alan, uuid_source, 'Sempre busco eficiência...', {...}, [0.456, ...]),
  ...
```

---

## 🔐 Segurança & Privacy

### Dados que Saem da Máquina Local

| O Que | Para Onde | Por Quê |
|-------|-----------|---------|
| **Texto source** | Anthropic Cloud | Extração de MIUs |
| **Fragments JSON** | Supabase Cloud | Storage |
| **Fragment text** | OpenAI Cloud | Embeddings |

### Dados que FICAM Locais

| O Que | Onde |
|-------|------|
| **Source files originais** | `outputs/minds/{mind}/sources/` |
| **Temp files** | `temp/` (deletados após) |
| **.env secrets** | Local (não commitado) |

### Compliance

- ✅ **GDPR:** Dados processados com consentimento
- ✅ **LGPD:** Storage em cloud compliance
- ✅ **Encryption:** TLS em trânsito, AES at rest
- ✅ **Data retention:** Configurável (pode deletar)

---

## 📊 Métricas: Quanto Processa?

### Por Mind (média)

| Métrica | Valor |
|---------|-------|
| **Source words** | 1,000-20,000 |
| **Processing time** | 30-120 segundos |
| **MIUs extracted** | 50-300 |
| **Fragments in DB** | 50-300 rows |
| **Storage used** | ~50KB per mind |
| **API calls** | 1 Claude + N OpenAI (N=fragments) |
| **Cost** | ~$0.15 per mind |

### Para Todas as 37 Minds

| Métrica | Total |
|---------|-------|
| **Total fragments** | ~2,000-5,000 |
| **Storage** | ~2-5 MB |
| **Processing time** | ~1-2 horas (sequencial) |
| **Total cost** | ~$5.55 |

---

## 🚨 O Que Pode Dar Errado

### 1. Sources Vazias

```
❌ Error: No source text found
```

**Causa:** `outputs/minds/{mind}/sources/` vazio ou sem .txt/.md

**Solução:** Adicionar arquivos de texto nessa pasta

### 2. API Keys Inválidas

```
❌ Error: Anthropic API error: invalid_api_key
```

**Solução:**
```bash
# Verificar .env
cat .env | grep ANTHROPIC_API_KEY

# Testar key
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{"model": "claude-3-5-sonnet-20241022", "max_tokens": 10, "messages": [{"role": "user", "content": "Hi"}]}'
```

### 3. Supabase Connection Failed

```
❌ Error: psycopg2.OperationalError: could not connect
```

**Solução:**
```bash
# Testar conexão
psql "$SUPABASE_DB_URL" -c "SELECT 1;"

# Verificar formato
echo $SUPABASE_DB_URL
# Deve ser: postgresql://postgres.xxx:password@...
```

### 4. Rate Limits

```
❌ Error: Rate limit exceeded (429)
```

**Solução:** Script já tem delays, mas pode aumentar:
```python
# No script Python
import time
time.sleep(2)  # Delay entre requests
```

---

## 🎯 Checklist: O Que InnerLens Precisa Saber

### ✅ Pré-requisitos

- [ ] **Sources location:** `outputs/minds/{mind}/sources/`
- [ ] **Supabase URL:** `.env` → `SUPABASE_DB_URL`
- [ ] **Anthropic key:** `.env` → `ANTHROPIC_API_KEY`
- [ ] **OpenAI key:** `.env` → `OPENAI_API_KEY`
- [ ] **Schema aplicado:** Migration v0.8.1
- [ ] **Python deps:** `anthropic`, `psycopg2`, `dotenv`
- [ ] **Node deps:** `pg`, `openai`, `dotenv`

### ✅ Durante Processamento

- [ ] **Read sources** de `outputs/minds/{mind}/sources/*.{txt,md}`
- [ ] **Concatenate** em temp file
- [ ] **Send to Claude** para extração
- [ ] **Receive MIUs** em JSON
- [ ] **Save to Supabase** (minds, sources, fragments tables)
- [ ] **Generate embeddings** com OpenAI
- [ ] **Update fragments** com embeddings
- [ ] **Cleanup** temp files

### ✅ Pós-processamento

- [ ] **Validate counts:** Fragments no Supabase = MIUs extraídos
- [ ] **Check embeddings:** Todos fragments têm embedding
- [ ] **Test RAG:** Search funciona
- [ ] **Monitor costs:** API usage dentro do esperado

---

## 💡 Resumo Visual

```
📁 FILESYSTEM (Local)          ☁️ CLOUD SERVICES              💾 DATABASE
─────────────────────         ────────────────────          ────────────────

outputs/minds/
├─ alan/sources/
│  ├─ text1.txt ─────────┐
│  ├─ text2.md ──────────┤
│  └─ text3.txt ─────────┤
                          ↓
                    [Concatenate]
                          ↓
                    temp/alan_source.txt
                          ↓
                    [Send to API] ────────→  Anthropic Claude
                                                    ↓
                                              [Extract MIUs]
                                                    ↓
                    temp/alan_fragments.json ←──────┘
                          ↓
                    [Parse & Save] ────────→  Supabase
                                               ├─ minds
                                               ├─ sources
                                               └─ fragments
                          ↓
                    [For each fragment]
                          ↓
                    [Generate embedding] ───→  OpenAI
                                                    ↓
                                            [vector(1536)]
                                                    ↓
                    [Update fragments] ─────→  Supabase
                                               └─ fragments.embedding

                                              ✅ RAG Ready!
```

---

## 🗄️ DB Sage Final Answer

**Pergunta:** "Onde vai processar os dados e gerar fragmentos?"

**Resposta:**
1. **Entrada:** `outputs/minds/{mind}/sources/` (local filesystem)
2. **Processamento:** Anthropic Cloud (Claude extrai MIUs via API)
3. **Storage:** Supabase Cloud (PostgreSQL)
4. **Embeddings:** OpenAI Cloud (via API)
5. **Output:** Supabase `fragments` table (RAG-ready)

**Tudo orquestrado por:** `process_mind_to_supabase.sh`

---

**🗄️ DB Sage - "Data flows from filesystem → Claude → Supabase → OpenAI → RAG."**

**Última atualização:** 2025-10-27
