# 🧠 InnerLens → Supabase Integration

**Data:** 2025-10-27
**Status:** ✅ Ready for Testing
**Decisão:** Motor automatizado para processar sources → fragments

---

## 📋 Executive Summary

Criamos **motor automatizado** que processa sources e gera fragments diretamente no Supabase usando InnerLens, ao invés de migração manual de KB files.

### ✅ O Que Foi Criado

| Componente | Arquivo | Propósito |
|------------|---------|-----------|
| **Supabase Adapter** | `expansion-packs/innerlens/scripts/save_fragments_to_supabase.py` | Substitui SQLite por Supabase |
| **Pipeline End-to-End** | `scripts/pipeline/process_mind_to_supabase.sh` | Orquestra processo completo |
| **Schema Unificado** | `supabase/migrations/20251027020000_v0_8_1_unify_fragments.sql` | Fragments com RAG |

---

## 🎯 Workflow Completo

```
Sources (texto)
    ↓
[1. InnerLens: Extract MIUs]
    ↓
MIU Fragments (JSON)
    ↓
[2. Supabase Adapter: Save]
    ↓
Fragments Table (Supabase)
    ↓
[3. OpenAI: Generate Embeddings]
    ↓
RAG-Ready Fragments
```

---

## 🚀 Como Usar

### Opção 1: Pipeline Automatizado (Recomendado)

```bash
# Processar uma mind completa
./scripts/pipeline/process_mind_to_supabase.sh alan_nicolas "Alan Nicolas" self_analysis
```

**O que faz:**
1. Coleta todos os sources de `outputs/minds/alan_nicolas/sources/`
2. Extrai MIUs com InnerLens (LLM-based)
3. Salva no Supabase `fragments` table
4. Gera embeddings com OpenAI
5. Valida e mostra resumo

**Output esperado:**
```
🚀 MMOS → Supabase Pipeline
================================

Mind: Alan Nicolas (alan_nicolas)
Source Type: self_analysis

📄 Step 1/4: Preparing source text...
✅ Prepared source text: 15,420 words

🧠 Step 2/4: Extracting MIUs with InnerLens...
✅ Extracted 187 MIUs

💾 Step 3/4: Saving to Supabase...
✅ Saved to Supabase

🤖 Step 4/4: Generating embeddings...
✅ Embeddings generated

================================
✅ Pipeline Complete!
================================

📊 Summary:
  Mind: Alan Nicolas
  Slug: alan_nicolas
  Source words: 15,420
  Fragments extracted: 187
  Saved to: Supabase fragments table
```

---

### Opção 2: Step-by-Step Manual

```bash
# 1. Preparar source text
cat outputs/minds/alan_nicolas/sources/*.txt > temp/alan_source.txt

# 2. Extrair MIUs com InnerLens
cd expansion-packs/innerlens
python3 scripts/extract_mius_llm.py \
  --input ../../temp/alan_source.txt \
  --output ../../temp/alan_fragments.json \
  --subject-id alan_nicolas

# 3. Salvar no Supabase
cd ../..
python3 expansion-packs/innerlens/scripts/save_fragments_to_supabase.py \
  --mind alan_nicolas \
  --fragments temp/alan_fragments.json \
  --source temp/alan_source.txt \
  --title "Self Analysis" \
  --type self_analysis

# 4. Gerar embeddings
node scripts/database/generate_embeddings.js
```

---

## 📦 Componentes Detalhados

### 1. InnerLens Extractor (Existente)

**Arquivo:** `expansion-packs/innerlens/scripts/extract_mius_llm.py`

**O que faz:**
- Extrai MIUs (Minimal Interpretable Units) usando LLM
- Análise linguística profunda (Portuguese)
- Preserva estrutura gramatical
- Zero-inference (só observáveis)

**MIU Example:**
```json
{
  "fragment_id": "f_alan_001",
  "content": {
    "verbatim": "Eu valorizo clareza acima de tudo.",
    "word_count": 6
  },
  "structure": {
    "pronouns": ["eu"],
    "verbs": ["valorizo"],
    "tenses_detected": ["present"]
  },
  "attribution": {
    "speaker": "subject",
    "speaker_name": "Alan Nicolas"
  }
}
```

**Já está pronto!** ✅ (InnerLens v1.0 completo)

---

### 2. Supabase Adapter (NOVO)

**Arquivo:** `expansion-packs/innerlens/scripts/save_fragments_to_supabase.py`

**O que faz:**
- Substitui `save_fragments_to_mmos.py` (SQLite)
- Conecta no Supabase via PostgreSQL
- Cria/atualiza minds, sources, fragments
- Preserva TODA metadata InnerLens em JSONB

**Mapping:**

| InnerLens Field | Supabase Column | Notes |
|----------------|-----------------|-------|
| `fragment_id` | `metadata->>'fragment_id'` | Preservado em JSONB |
| `content.verbatim` | `content` | Plain text |
| `structure.*` | `metadata->'structure'` | Full structure in JSONB |
| `attribution.*` | `metadata->'attribution'` | Speaker info |
| `quality_flags.*` | `metadata->'quality_flags'` | Validation data |

**Benefício:** Zero perda de dados. Tudo é preservado!

---

### 3. Pipeline Orchestrator (NOVO)

**Arquivo:** `scripts/pipeline/process_mind_to_supabase.sh`

**O que faz:**
- Orquestra 4 passos automaticamente
- Error handling em cada etapa
- Progress display colorido
- Validação de pré-requisitos (.env vars)
- Cleanup automático

**Segurança:**
- `set -e` → Para no primeiro erro
- Validação de paths
- Confirmação antes de deletar temp files

---

## 🗄️ Schema: Fragments Unificado

### Estrutura da Tabela

```sql
CREATE TABLE fragments (
  id UUID PRIMARY KEY,
  mind_id UUID REFERENCES minds(id),
  source_id UUID REFERENCES sources(id),

  -- Content
  type TEXT NOT NULL,              -- 'miu', 'identity_core', etc.
  title TEXT,
  content TEXT NOT NULL,           -- Verbatim text
  word_count INT,

  -- RAG
  embedding vector(1536),          -- OpenAI embeddings
  tsv tsvector,                    -- Full-text search

  -- Metadata (preserva TUDO do InnerLens)
  tags TEXT[],
  related_fragments TEXT[],
  metadata JSONB,                  -- InnerLens structure, etc.

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

**JSONB metadata para InnerLens MIUs:**
```json
{
  "fragment_id": "f_alan_001",
  "innerlens_version": "1.0",
  "extraction_method": "innerlens_llm",
  "structure": {
    "pronouns": ["eu"],
    "verbs": ["valorizo"],
    "tenses_detected": ["present"]
  },
  "attribution": {
    "speaker": "subject",
    "speaker_name": "Alan Nicolas"
  },
  "quality_flags": {
    "has_verb": true,
    "complete_clause": true,
    "has_attribution": true
  }
}
```

---

## 💰 Custo Estimado

### Por Mind (1000-2000 palavras)

| Etapa | Ferramenta | Custo |
|-------|-----------|-------|
| **Extração MIUs** | Claude Sonnet 4 | $0.15 |
| **Embeddings** | OpenAI text-embedding-3-small | $0.0002 |
| **Storage** | Supabase | Incluído |
| **TOTAL** | - | **~$0.15** |

**Para 37 minds:** ~$5.55 (uma vez)

---

## ✅ Checklist de Execução

### Pré-requisitos
- [ ] `.env` configurado (SUPABASE_DB_URL, OPENAI_API_KEY, ANTHROPIC_API_KEY)
- [ ] Migration v0.8.1 aplicada (unified fragments schema)
- [ ] InnerLens instalado (Python deps)
- [ ] Node.js dependencies instaladas

### Primeira Execução (Teste)
- [ ] Testar com 1 mind primeiro (ex: alan_nicolas)
- [ ] Verificar fragments no Supabase
- [ ] Verificar embeddings gerados
- [ ] Testar RAG search

### Produção (Todas as Minds)
- [ ] Loop através de todas minds em `outputs/minds/`
- [ ] Processar em paralelo (se necessário)
- [ ] Validar counts finais
- [ ] Backup antes de começar

---

## 🧪 Testando

### 1. Testar Extração InnerLens

```bash
cd expansion-packs/innerlens
python3 scripts/extract_mius_llm.py \
  --input testing/validation/text_samples/alan_nicolas.txt \
  --output testing/output/test_fragments.json \
  --subject-id test_subject
```

### 2. Testar Supabase Adapter

```bash
python3 expansion-packs/innerlens/scripts/save_fragments_to_supabase.py \
  --mind test_subject \
  --fragments testing/output/test_fragments.json \
  --source testing/validation/text_samples/alan_nicolas.txt \
  --title "Test Analysis" \
  --type test
```

### 3. Validar no Supabase

```sql
-- Count fragments for test mind
SELECT COUNT(*) FROM fragments
WHERE mind_id = (SELECT id FROM minds WHERE slug = 'test_subject');

-- View sample fragments
SELECT id, type, title, word_count, metadata->>'fragment_id'
FROM fragments
WHERE mind_id = (SELECT id FROM minds WHERE slug = 'test_subject')
LIMIT 5;

-- Check embeddings
SELECT COUNT(*) FROM fragments
WHERE embedding IS NOT NULL
AND mind_id = (SELECT id FROM minds WHERE slug = 'test_subject');
```

### 4. Testar RAG

```javascript
// Test RAG search
const { Client } = require('pg');
const OpenAI = require('openai');

const client = new Client({ connectionString: process.env.SUPABASE_DB_URL });
const openai = new OpenAI();

await client.connect();

// Generate query embedding
const query = "O que o subject valoriza?";
const embedding = await openai.embeddings.create({
  model: 'text-embedding-3-small',
  input: query
});

// Search
const results = await client.query(`
  SELECT * FROM match_fragments(
    $1::vector,
    'test_subject',
    0.75,
    5
  )
`, [`[${embedding.data[0].embedding.join(',')}]`]);

console.log(`Found ${results.rows.length} results`);
```

---

## 🎯 Próximos Passos

### Imediato (Esta Semana)
1. ✅ Testar pipeline com 1 mind
2. ⏳ Validar qualidade dos fragments
3. ⏳ Testar RAG search
4. ⏳ Processar 3-5 minds prioritárias

### Curto Prazo (Próxima Semana)
5. Processar todas as 37 minds
6. Benchmarking de qualidade RAG
7. Refinar prompts de extração (se necessário)
8. Documentar best practices

### Médio Prazo (Próximo Mês)
9. Integrar em system prompts dos clones
10. A/B testing de retrieval strategies
11. Monitorar custos e performance
12. Expandir para novos minds

---

## 🚨 Troubleshooting

### Erro: InnerLens extraction failed

```
❌ Error: MIU extraction failed
```

**Possíveis causas:**
1. ANTHROPIC_API_KEY não configurada
2. Source text vazio ou inválido
3. Limite de rate da API

**Solução:**
```bash
# Verificar API key
echo $ANTHROPIC_API_KEY

# Verificar source text
cat temp/source.txt | wc -w  # Deve ter >500 palavras

# Tentar novamente com delay
sleep 5 && python3 scripts/extract_mius_llm.py ...
```

### Erro: Failed to save to Supabase

```
❌ Error: Failed to save to Supabase
psycopg2.errors.ForeignKeyViolation: mind not found
```

**Causa:** Mind não existe no Supabase

**Solução:**
```bash
# Popular minds primeiro
node scripts/database/populate_supabase_minds.js

# Ou adicionar --display-name ao script
python3 save_fragments_to_supabase.py \
  --mind new_mind \
  --display-name "New Mind Name" \
  ...
```

### Erro: Embedding generation failed

```
Error: Insufficient quota
```

**Causa:** Limite de cota OpenAI

**Solução:**
```bash
# Verificar cota
curl https://api.openai.com/v1/usage \
  -H "Authorization: Bearer $OPENAI_API_KEY"

# Ou rodar só alguns fragments
# (script já faz batch processing)
```

---

## 📚 Documentação de Referência

1. **InnerLens README:** `expansion-packs/innerlens/README.md`
2. **Unified Fragments:** `FRAGMENTS-VS-CHUNKS-UNIFICATION.md`
3. **Migration Plan:** `FRAGMENTS-UNIFIED-EXECUTION-PLAN.md`
4. **Schema Comparison:** `SCHEMA-COMPARISON-SQLITE-SUPABASE.md`

---

## 🗄️ DB Sage Notes

**Filosofia aplicada:**
- ✅ Automatização > Migração manual
- ✅ Preservação de dados (zero loss via JSONB)
- ✅ Idempotência (safe to re-run)
- ✅ Validação em cada etapa
- ✅ Error handling robusto

**Vantagens desta abordagem:**
1. **Escalável:** Adicionar nova mind = rodar script
2. **Consistente:** Mesmo processo para todas
3. **Rastreável:** Metadata preservada
4. **RAG-ready:** Embeddings automáticos
5. **Flexível:** Fácil ajustar extraction logic

---

## 💡 Exemplo Completo: Alan Nicolas

```bash
# 1. Executar pipeline
./scripts/pipeline/process_mind_to_supabase.sh alan_nicolas "Alan Nicolas"

# Output:
# ✅ Prepared source text: 18,500 words
# ✅ Extracted 210 MIUs
# ✅ Saved to Supabase
# ✅ Embeddings generated

# 2. Validar no Supabase
psql "$SUPABASE_DB_URL" << EOF
SELECT
  m.slug,
  COUNT(f.id) as fragment_count,
  COUNT(f.embedding) as with_embeddings,
  AVG(f.word_count) as avg_words
FROM fragments f
INNER JOIN minds m ON m.id = f.mind_id
WHERE m.slug = 'alan_nicolas'
GROUP BY m.slug;
EOF

# Resultado esperado:
# slug          | fragment_count | with_embeddings | avg_words
# --------------|----------------|-----------------|----------
# alan_nicolas  |            210 |             210 |        12

# 3. Testar RAG
node scripts/database/test_rag_simple.js
# Query: "Como Alan toma decisões?"
# Found 5 results:
# 📄 MIU: f_alan_042 (Similarity: 89.2%)
# 📄 MIU: f_alan_018 (Similarity: 86.5%)
# ...
```

---

**🗄️ DB Sage - "Automate extraction, preserve metadata, enable RAG."**

**Status:** ✅ Ready for Testing
**Última atualização:** 2025-10-27
