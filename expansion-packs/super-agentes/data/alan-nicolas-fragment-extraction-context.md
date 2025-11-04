# 🧩 Alan Nicolas - Fragment Extraction Context

**Session Date:** 2025-11-04
**Status:** Ready to extract fragments from `marketing.md`
**Decision Made:** Architecture refactor complete

---

## 📊 Architectural Decision (FINAL)

### Schema Change: `sources` → `contents` Flow

**OLD (Wrong):**
```
sources (Alan's original documents) → fragments
```

**NEW (Correct):**
```
contents (ai_generated: false) → content_minds (role: creator) → fragments (content_id)
```

**Reasoning:**
- `sources` is confusing (external sources vs Alan's content)
- `contents` is where ALL of Alan's content should live (ai_generated: false for human-created)
- `content_minds` provides the mind association (no need for mind_id in contents)
- Fragments reference `content_id`, not `source_id`

---

## 🎯 Current State

### Alan Nicolas (Mind)
- **UUID:** `2ad2fe23-4ebc-4399-be9f-81274af1acb6`
- **Status:** Ready to receive contents and fragments

### Marketing.md (Content to Extract)
- **File:** `outputs/minds/alan_nicolas/sources/articles/marketing.md`
- **Type:** Article/Manifesto
- **Language:** pt-BR
- **Status:** Ready to INSERT into contents
- **ai_generated:** FALSE (Alan created it)

### Database Tables (As of 2025-11-04)
- **minds:** 42 (alan_nicolas exists ✅)
- **contents:** 0 (ready for inserts)
- **content_minds:** N/M association table (ready ✅)
- **fragments:** 0 (ready for inserts, needs migration)
- **categories:** 5 (BIO, COG, VAL, PHI, PRO) - Use `4 (PHI)` for philosophy content

---

## 🔧 Pending Actions

### 1. Database Migration (REQUIRED)
Add `content_id` column to `fragments` table:
```sql
ALTER TABLE fragments
ADD COLUMN content_id UUID REFERENCES contents(id);

CREATE INDEX idx_frag_content_id ON fragments(content_id);
```

**Status:** Not yet executed

### 2. Insert Content (REQUIRED)
```sql
INSERT INTO contents (
  title,
  slug,
  content,  -- FULL FILE TEXT
  content_type,
  file_path,
  ai_generated,
  metadata,
  status
) VALUES (
  'Uma Abordagem Alinhada aos Seus Valores para Vender Sem Esforço e Sem Mentir',
  'marketing-autentico',
  '<full markdown content>',
  'article',
  'outputs/minds/alan_nicolas/sources/articles/marketing.md',
  false,
  '{"language": "pt-BR", "document_type": "manifesto"}'::jsonb,
  'published'
)
RETURNING id AS content_id;
```

### 3. Link to Mind (REQUIRED)
```sql
INSERT INTO content_minds (content_id, mind_id, role)
VALUES ('<content_id_from_above>', '2ad2fe23-4ebc-4399-be9f-81274af1acb6', 'creator');
```

### 4. Extract Fragments (Fragment Extractor)
Parameters needed:
- **mind_id:** `2ad2fe23-4ebc-4399-be9f-81274af1acb6`
- **content_id:** (from INSERT above)
- **category_id:** `4` (PHI - Philosophical)
- **language:** `pt-BR`
- **document_type:** `article`

---

## 📋 Next Session Tasks

1. ✅ Execute database migration (add `content_id` to fragments)
2. ✅ INSERT marketing.md into `contents`
3. ✅ INSERT association into `content_minds`
4. ✅ Activate Fragment Extractor with correct parameters
5. ✅ Extract and validate fragments

---

## 🗄️ DB Sage Rules (For Next Session)

- **Schema Load:** Query viva (toda ativação)
- **Before Alter:** Checklist defensivo obrigatório
- **Questions:** 5+ estruturadas antes de propor
- **File Saving:** ONLY `expansion-packs/`, NEVER `.claude/` or `.aios-core/`
- **Restrictions:** Read `CLAUDE_CODE_RESTRICTIONS.md`

---

## 🔗 Key Documents

- `expansion-packs/super-agentes/agents/db-sage-activation-protocol.md` - DB Sage behavior
- `expansion-packs/super-agentes/agents/CLAUDE_CODE_RESTRICTIONS.md` - File saving rules
- Database schema in `docs/database/evolution/0.8_README.md`

**Version:** 1.0 | **Ready to proceed**
