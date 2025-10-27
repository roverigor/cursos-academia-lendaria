# 🚀 Plano de Execução: Fragments Unificados + RAG

**Data:** 2025-10-27
**Decisão:** Usar UMA tabela `fragments` (não kb_chunks separado)
**Objetivo:** Fragments RAG-ready para alimentar LLMs

---

## 📋 Resumo Executivo

### ✅ O Que Foi Decidido

- **1 tabela:** `fragments` (não 2 sistemas separados)
- **Tamanho flexível:** 50-1000 palavras (pequenos ou grandes)
- **RAG-ready:** Vector embeddings (OpenAI text-embedding-3-small)
- **Fonte:** KB files em `outputs/minds/*/kb/` (51 arquivos)

### 📊 Resultado Esperado

| Métrica | Valor |
|---------|-------|
| **Fragments** | ~51 (de KB files) |
| **Embeddings** | 1536 dimensões |
| **Custo estimado** | ~$0.0002 (desprezível) |
| **Tempo total** | ~30 minutos |
| **RAG functions** | 3 (match, hybrid, chain) |

---

## 🎯 Arquivos Criados

### 1. Migration SQL ✅
**Arquivo:** `supabase/migrations/20251027020000_v0_8_1_unify_fragments.sql`

**O que faz:**
- Adiciona campos à tabela `fragments`:
  - `title` (TEXT)
  - `tags` (TEXT[])
  - `related_fragments` (TEXT[])
  - `word_count` (INT)
  - `embedding` (vector(1536))
  - `metadata` (JSONB)
- Cria 3 funções RAG:
  - `match_fragments()` - Vector similarity search
  - `hybrid_search_fragments()` - Vector + Full-text
  - `get_fragment_chain()` - Chain retrieval
- Cria views úteis:
  - `fragments_with_minds`
  - `large_chunks_summary`

---

### 2. Population Script ✅
**Arquivo:** `scripts/database/populate_fragments_from_kb.js`

**O que faz:**
- Lê KB files de `outputs/minds/*/kb/`
- Suporta 2 formatos:
  - Markdown com YAML frontmatter (`.md`)
  - Pure YAML files (`.yaml`)
- Extrai metadata:
  - title, tags, confidence, layer
  - related_fragments (chain retrieval)
- Insere na tabela `fragments`

**Uso:**
```bash
node scripts/database/populate_fragments_from_kb.js
```

---

### 3. Embeddings Generator ✅
**Arquivo:** `scripts/database/generate_embeddings.js`

**O que faz:**
- Gera embeddings com OpenAI (text-embedding-3-small)
- Processa em batches (50 por vez)
- Mostra progresso + estimativa de custo
- Atualiza coluna `embedding`

**Uso:**
```bash
# Dry run (só estimativa)
node scripts/database/generate_embeddings.js --dry-run

# Executar
node scripts/database/generate_embeddings.js
```

---

## 🚀 Passo a Passo de Execução

### ✅ Pré-requisitos

```bash
# 1. Verificar conexão Supabase
source .env
echo $SUPABASE_DB_URL  # Deve ter valor

# 2. Verificar OpenAI API key
echo $OPENAI_API_KEY   # Deve ter valor

# 3. Instalar dependências (se necessário)
npm install pg openai js-yaml
```

---

### Passo 1: Aplicar Migration (5 min)

```bash
# Conectar e aplicar migration
psql "$SUPABASE_DB_URL" < supabase/migrations/20251027020000_v0_8_1_unify_fragments.sql
```

**Resultado esperado:**
```
CREATE EXTENSION
ALTER TABLE
CREATE INDEX
...
NOTICE: ✅ Unified fragments schema ready for RAG!
NOTICE:    - Vector embeddings: 1536 dimensions
NOTICE:    - Flexible size: 50-1000+ words
NOTICE:    - RAG functions: match_fragments, hybrid_search_fragments, get_fragment_chain
```

**⚠️ Possível erro:**
```
ERROR: extension "vector" not available
```

**Solução:** Ativar pgvector no Supabase:
```sql
-- Via Supabase Dashboard → SQL Editor
CREATE EXTENSION IF NOT EXISTS vector;
```

---

### Passo 2: Popular Fragments (10 min)

```bash
# Popular de outputs/minds/*/kb/
node scripts/database/populate_fragments_from_kb.js
```

**Output esperado:**
```
🚀 Populating fragments from outputs/minds/*/kb/

📂 Scanning KB directories...

📖 Processing: adriano_de_marqui/kb/
  Found 3 KB files
  ✅ Extracted 3 fragments

📖 Processing: alan_nicolas/kb/
  Found 20 KB files
  ✅ Extracted 20 fragments

...

📊 Summary:
   Total fragments found: 51
   Minds with KB: 10
   Average per mind: 5.1
   Total words: 35,420
   Avg words/fragment: 695

🔌 Connecting to Supabase...
✅ Connected

💾 Inserting fragments...
  Inserted 51/51...

✅ Population complete!

📊 Database Stats:
   Total fragments: 51
   Unique minds: 10
   Avg words/fragment: 695
   Range: 48-1240 words
   Total words: 35,420

✅ Summary:
   • New fragments inserted: 51
   • Skipped (duplicates/errors): 0

🎉 Done! Fragments ready for embedding generation.
```

---

### Passo 3: Gerar Embeddings (10-15 min)

```bash
# 1. Dry run (ver estimativa de custo)
node scripts/database/generate_embeddings.js --dry-run
```

**Output esperado:**
```
🚀 Generating embeddings for fragments

🔌 Connecting to Supabase...
✅ Connected

🔍 Checking fragments...
   Found 51 fragments without embeddings

💰 Cost Estimate:
   Model: text-embedding-3-small
   Fragments: 51
   Est. tokens: 10,200
   Est. cost: $0.0002

🏃 Dry run mode - exiting without generating embeddings
```

**Custo:** ~$0.0002 (desprezível!)

```bash
# 2. Executar geração
node scripts/database/generate_embeddings.js
```

**Output esperado:**
```
🤖 Generating embeddings...

  Progress: 51/51 (100.0%) | Elapsed: 2.3m | Rate: 0.4/s

✅ Embedding generation complete!

📊 Stats:
   Total processed: 51
   Succeeded: 51
   Failed: 0
   Time: 2.3 minutes
   Rate: 0.4 fragments/sec

🔍 Validating embeddings...
   Total fragments: 51
   With embeddings: 51
   Missing embeddings: 0

✅ All fragments have embeddings!

🎉 Done! Fragments are RAG-ready.
```

---

### Passo 4: Validação (2 min)

```bash
# Testar funções RAG via psql
psql "$SUPABASE_DB_URL"
```

**Queries de validação:**

```sql
-- 1. Count fragments
SELECT COUNT(*) as total, COUNT(embedding) as with_embeddings
FROM fragments;
-- Expect: total=51, with_embeddings=51

-- 2. View by mind
SELECT
  m.slug,
  COUNT(*) as fragment_count,
  AVG(f.word_count) as avg_words
FROM fragments f
INNER JOIN minds m ON m.id = f.mind_id
GROUP BY m.slug
ORDER BY fragment_count DESC;

-- 3. Test vector search (need to generate embedding first)
-- This will be done via application code

-- 4. View large chunks
SELECT * FROM large_chunks_summary;
```

---

## 🧪 Testar RAG (Opcional)

Criar script de teste rápido:

```javascript
// scripts/database/test_rag_simple.js
const { Client } = require('pg');
const OpenAI = require('openai');
require('dotenv').config();

const client = new Client({
  connectionString: process.env.SUPABASE_DB_URL.replace(/\?sslmode=require/, ''),
  ssl: { rejectUnauthorized: false }
});

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

async function testRAG() {
  await client.connect();

  // 1. Generate query embedding
  const query = "Como Alan toma decisões estratégicas?";
  const embedding = await openai.embeddings.create({
    model: 'text-embedding-3-small',
    input: query
  });

  // 2. Search fragments
  const results = await client.query(`
    SELECT * FROM match_fragments(
      $1::vector,
      'alan_nicolas',
      0.75,
      5
    )
  `, [`[${embedding.data[0].embedding.join(',')}]`]);

  // 3. Display results
  console.log(`\nQuery: "${query}"\n`);
  console.log(`Found ${results.rows.length} results:\n`);

  for (const row of results.rows) {
    console.log(`📄 ${row.title || row.type}`);
    console.log(`   Similarity: ${(row.similarity * 100).toFixed(1)}%`);
    console.log(`   Words: ${row.word_count}`);
    console.log(`   Preview: ${row.content.substring(0, 100)}...\n`);
  }

  await client.end();
}

testRAG();
```

---

## 📊 Checklist de Execução

### Pré-requisitos
- [ ] ✅ `.env` configurado (SUPABASE_DB_URL, OPENAI_API_KEY)
- [ ] ✅ Conexão Supabase testada
- [ ] ✅ Node.js dependencies instaladas

### Migration
- [ ] ⏳ Aplicar migration v0.8.1
- [ ] ⏳ Verificar pgvector extension ativa
- [ ] ⏳ Validar funções RAG criadas

### População
- [ ] ⏳ Executar populate_fragments_from_kb.js
- [ ] ⏳ Validar 51 fragments inseridos
- [ ] ⏳ Verificar word_count correto

### Embeddings
- [ ] ⏳ Dry run (verificar custo)
- [ ] ⏳ Gerar embeddings
- [ ] ⏳ Validar 51/51 com embeddings

### Validação Final
- [ ] ⏳ Count queries OK
- [ ] ⏳ Testar match_fragments()
- [ ] ⏳ (Opcional) Test RAG script

---

## 🎯 Resultado Final

Após completar todos os passos:

```sql
SELECT
  'fragments' as table_name,
  COUNT(*) as total,
  COUNT(embedding) as with_embeddings,
  AVG(word_count) as avg_words,
  SUM(word_count) as total_words
FROM fragments;
```

**Esperado:**
```
table_name | total | with_embeddings | avg_words | total_words
-----------+-------+-----------------+-----------+-------------
fragments  |    51 |              51 |       695 |      35420
```

**Status:** 🟢 **RAG-READY!**

---

## 🚀 Próximos Passos

Após fragments RAG-ready:

### Imediato
1. ✅ Integrar em system prompts dos clones
2. ✅ Criar função de retrieval em aplicação
3. ✅ Testar qualidade de respostas

### Curto Prazo
4. Adicionar mais KB files (outros minds)
5. Refinar chunking strategy
6. Implementar re-ranking (opcional)

### Médio Prazo
7. Monitorar qualidade RAG
8. A/B test diferentes retrieval strategies
9. Expandir para SQLite fragments (se necessário)

---

## 💰 Custo Total Estimado

| Item | Quantidade | Custo Unitário | Total |
|------|-----------|----------------|-------|
| **Embeddings** | 51 fragments | $0.02 / 1M tokens | $0.0002 |
| **Storage** | 51 rows + vectors | Incluído Supabase | $0 |
| **Queries** | Ilimitado | Incluído Supabase | $0 |
| **TOTAL** | - | - | **~$0.0002** |

**Custo desprezível!** 🎉

---

## ⚠️ Troubleshooting

### Erro: pgvector extension not found

```sql
-- Solução: Ativar no Supabase Dashboard
CREATE EXTENSION IF NOT EXISTS vector;
```

### Erro: OpenAI rate limit

```
Error: Rate limit exceeded
```

**Solução:** Script já tem delays, mas pode aumentar:
```javascript
const RATE_LIMIT_DELAY = 2000; // Aumentar de 1s para 2s
```

### Erro: Mind not found

```
Error: Mind not found: adriano_de_marqui
```

**Solução:** Popular minds primeiro:
```bash
node scripts/database/populate_supabase_minds.js
```

---

## 📚 Documentação de Referência

1. **Decisão de unificação:** `FRAGMENTS-VS-CHUNKS-UNIFICATION.md`
2. **Análise de compatibilidade:** `FRAGMENTS-COMPATIBILITY-ANALYSIS.md`
3. **Migration status:** `MIGRATION-STATUS-REPORT.md`
4. **Schema comparison:** `SCHEMA-COMPARISON-SQLITE-SUPABASE.md`

---

## 🗄️ DB Sage Notes

**Filosofia aplicada:**
- ✅ Simplicidade (1 sistema, não 2)
- ✅ Flexibilidade (tamanho variável)
- ✅ Idempotência (safe to re-run)
- ✅ Validação built-in
- ✅ Custo otimizado

**Próxima sessão:** Aplicar taxonomias + popular sources

---

**🗄️ DB Sage - "Simple, flexible, and RAG-ready."**

**Última atualização:** 2025-10-27
