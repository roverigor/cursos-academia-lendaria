# 🚀 CreatorOS Database Migration Guide

> **Guia completo para aplicar o schema CreatorOS ao banco de dados Supabase v0.7.0**

---

## 📋 Overview

Esta migration:
- ✅ Faz backup automático das tabelas existentes (`*_v0_7_0`)
- ✅ Cria nova tabela universal `contents` (18 campos)
- ✅ Migra dados de `content_pieces` → `contents`
- ✅ Cria junction table `content_minds` (multi-mind support)
- ✅ Aplica seeds (8 frameworks, 3 audiences, 3 projects)
- ✅ Cria 9 views úteis para analytics

**Duração estimada:** 5-10 minutos
**Downtime:** Nenhum (tabelas novas não afetam existentes)
**Reversível:** Sim (via snapshot + rollback)

---

## ⚠️ Pré-requisitos

### 1. Ambiente

- [ ] Banco de dados Supabase (PostgreSQL 16+)
- [ ] Schema MMOS v0.7.0 instalado (tabelas: `minds`, `job_executions`, `tags`)
- [ ] Acesso `psql` ou Supabase Dashboard SQL Editor
- [ ] Variável `SUPABASE_DB_URL` configurada

### 2. Validar Conexão

```bash
# Teste de conexão
psql "$SUPABASE_DB_URL" -c "SELECT version();"

# Expected output: PostgreSQL 16.x ou superior
```

### 3. Verificar Tabelas MMOS

```sql
-- Run no SQL Editor
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('minds', 'job_executions', 'tags')
ORDER BY tablename;

-- Expected: 3 rows (minds, job_executions, tags)
```

---

## 🛡️ Backup (CRÍTICO)

**NUNCA pule o backup em produção!**

### Opção A: Snapshot via DB Sage (Recomendado)

```bash
# No Claude Code
/db-sage
*snapshot v0_7_0_pre_creator_os
```

### Opção B: Snapshot Manual via psql

```bash
# Schema-only backup
pg_dump "$SUPABASE_DB_URL" \
  --schema-only \
  --no-owner \
  --no-privileges \
  > "backups/v0_7_0_$(date +%Y%m%d_%H%M%S)_before_creator_os.sql"

# Full backup (schema + data)
pg_dump "$SUPABASE_DB_URL" \
  --no-owner \
  --no-privileges \
  > "backups/v0_7_0_$(date +%Y%m%d_%H%M%S)_full_backup.sql"
```

### Opção C: Supabase Dashboard

1. Acesse Supabase Dashboard
2. Database → Backups
3. Create new backup → Salvar

---

## 🚀 Execução da Migration

### Método 1: psql (Recomendado)

```bash
# Navegar para o diretório do projeto
cd /path/to/mente_lendaria

# Executar migration completa
psql "$SUPABASE_DB_URL" \
  -f expansion-packs/creator-os/database/migrations/002_creator_os_full_migration.sql

# A migration vai:
# 1. Fazer pre-flight checks
# 2. Backup de tabelas existentes
# 3. Criar novo schema
# 4. Migrar dados
# 5. Aplicar seeds
# 6. Criar views
# 7. Validar instalação
```

**Output esperado:**
```
NOTICE:  ═══════════════════════════════════════════════════════════
NOTICE:  CreatorOS Full Migration - Starting Pre-flight Checks
NOTICE:  ═══════════════════════════════════════════════════════════
NOTICE:  ✅ All required MMOS tables exist
NOTICE:  ✅ Pre-flight checks passed
...
NOTICE:  ✅ CreatorOS Migration Complete!
```

### Método 2: Supabase Dashboard SQL Editor

1. Acesse Supabase Dashboard → SQL Editor
2. New query
3. Copiar todo conteúdo de `002_creator_os_full_migration.sql`
4. **IMPORTANTE:** Substituir os `\i` imports:

```sql
-- Trocar estas linhas:
\i /Users/alan/.../schema.sql
\i /Users/alan/.../seeds.sql
\i /Users/alan/.../views.sql

-- Por: copiar/colar o conteúdo completo de cada arquivo
-- (schema.sql content aqui)
-- (seeds.sql content aqui)
-- (views.sql content aqui)
```

5. Run query

---

## 🧪 Validação Pós-Migration

### 1. Verificar Tabelas Criadas

```sql
-- Novas tabelas criadas
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename LIKE 'content%'
  AND tablename NOT LIKE '%_v0_7_0'
ORDER BY tablename;

-- Expected:
-- content_frameworks
-- content_minds
-- content_projects
-- content_tags
-- contents
-- audience_profiles
```

### 2. Verificar Seeds

```sql
-- Frameworks (expected: 8)
SELECT slug, name, framework_type
FROM content_frameworks
ORDER BY framework_type, slug;

-- Audiences (expected: 3)
SELECT slug, name, technical_level
FROM audience_profiles;

-- Projects (expected: 3)
SELECT slug, name, project_type
FROM content_projects;
```

### 3. Verificar Migração de Dados

```sql
-- Comparar contagens
SELECT
  (SELECT COUNT(*) FROM content_pieces_v0_7_0) as old_count,
  (SELECT COUNT(*) FROM contents WHERE ai_generated = true) as new_count;

-- Should be equal: old_count = new_count

-- Verificar content_minds
SELECT COUNT(*) as creator_relationships
FROM content_minds
WHERE role = 'creator';
-- Should match content_pieces count
```

### 4. Testar Views

```sql
-- View: Generated contents com metadata
SELECT slug, title, project_name, creators, fidelity_score
FROM v_generated_contents
LIMIT 5;

-- View: Custos de geração
SELECT llm_model, contents_generated, total_cost_usd
FROM v_generation_costs;

-- View: Hierarquia de conteúdo
SELECT slug, title, depth_level, path
FROM v_content_hierarchy
WHERE root_slug = 'academia-lendaria'
LIMIT 10;
```

### 5. Smoke Test Completo

```sql
-- Insert test content (multi-mind)
BEGIN;
  -- Create test content
  INSERT INTO contents (
    slug, title, content_type, ai_generated,
    content, status
  )
  VALUES (
    'test-interview-migration',
    'Test Interview: Multi-Mind',
    'interview',
    false,
    'Test content for validation',
    'draft'
  ) RETURNING id;
  -- Save this ID: e.g., '123e4567-e89b-12d3-a456-426614174000'

  -- Add minds (replace with real UUIDs from your minds table)
  -- INSERT INTO content_minds (content_id, mind_id, role) VALUES
  --   ('123e4567-e89b-12d3-a456-426614174000', '<mind_1_uuid>', 'host'),
  --   ('123e4567-e89b-12d3-a456-426614174000', '<mind_2_uuid>', 'guest');

  -- Verify
  SELECT * FROM v_multi_mind_contents
  WHERE slug = 'test-interview-migration';

ROLLBACK; -- or COMMIT to keep test data
```

---

## 🔧 Troubleshooting

### Erro: "Required table does not exist"

**Causa:** Schema MMOS v0.7.0 não instalado

**Solução:**
```bash
# Instalar MMOS schema primeiro
psql "$SUPABASE_DB_URL" -f supabase/migrations/v0_7_0_unified.sql
```

---

### Erro: "relation already exists"

**Causa:** Tabelas já existem (migration rodou parcialmente)

**Solução:**
```sql
-- Verificar tabelas existentes
SELECT tablename FROM pg_tables
WHERE schemaname = 'public' AND tablename LIKE 'content%';

-- Se migration falhou no meio:
-- Opção 1: Drop manual e re-run
DROP TABLE IF EXISTS contents CASCADE;
DROP TABLE IF EXISTS content_minds CASCADE;
-- ... (drop outras tabelas criadas)

-- Opção 2: Rollback via snapshot
-- (use backup criado no início)
```

---

### Erro: "column depth_level does not exist"

**Causa:** Usando versão antiga de `schema.sql` (não corrigida)

**Solução:**
```bash
# Verificar que schema.sql foi corrigido
grep "depth_level" expansion-packs/creator-os/database/schema.sql

# Linha 247 deve ser:
# ON contents(parent_content_id, sequence_order)  -- SEM depth_level!
```

---

### Warning: "Expected 8 frameworks, found X"

**Causa:** Seeds não aplicados ou conflito

**Solução:**
```sql
-- Re-aplicar seeds manualmente
\i expansion-packs/creator-os/database/seeds.sql

-- Ou via psql:
psql "$SUPABASE_DB_URL" \
  -f expansion-packs/creator-os/database/seeds.sql
```

---

## 🔄 Rollback (se necessário)

### Opção A: Restaurar do Snapshot

```bash
# Via DB Sage
/db-sage
*rollback v0_7_0_pre_creator_os

# Ou via psql
psql "$SUPABASE_DB_URL" < backups/v0_7_0_YYYYMMDD_HHMMSS_before_creator_os.sql
```

### Opção B: Rollback Manual

```sql
BEGIN;
  -- Drop novas tabelas
  DROP TABLE IF EXISTS content_minds CASCADE;
  DROP TABLE IF EXISTS content_tags CASCADE;
  DROP TABLE IF EXISTS contents CASCADE;
  DROP TABLE IF EXISTS content_projects CASCADE;
  DROP TABLE IF EXISTS content_frameworks CASCADE;
  DROP TABLE IF EXISTS audience_profiles CASCADE;

  -- Drop views
  DROP VIEW IF EXISTS v_generated_contents CASCADE;
  DROP VIEW IF EXISTS v_collected_contents CASCADE;
  DROP VIEW IF EXISTS v_multi_mind_contents CASCADE;
  DROP VIEW IF EXISTS v_generation_costs CASCADE;
  DROP VIEW IF EXISTS v_content_hierarchy CASCADE;
  DROP VIEW IF EXISTS v_project_performance CASCADE;
  DROP VIEW IF EXISTS v_mind_content_stats CASCADE;
  DROP VIEW IF EXISTS v_content_with_frameworks CASCADE;
  DROP VIEW IF EXISTS v_recent_contents CASCADE;

  -- Restore old tables
  ALTER TABLE content_pieces_v0_7_0 RENAME TO content_pieces;
  ALTER TABLE content_projects_v0_7_0 RENAME TO content_projects;
  ALTER TABLE content_frameworks_v0_7_0 RENAME TO content_frameworks;
  ALTER TABLE audience_profiles_v0_7_0 RENAME TO audience_profiles;
  -- ... (outras tabelas)

COMMIT;
```

---

## 📊 Métricas de Sucesso

Após migration completa:

| Métrica | Esperado | Como Validar |
|---------|----------|--------------|
| Tabelas criadas | 6+ | `SELECT COUNT(*) FROM pg_tables WHERE tablename LIKE 'content%'` |
| Frameworks | 8 | `SELECT COUNT(*) FROM content_frameworks` |
| Audiences | 3 | `SELECT COUNT(*) FROM audience_profiles` |
| Projects | 3 | `SELECT COUNT(*) FROM content_projects` |
| Views | 9 | `SELECT COUNT(*) FROM pg_views WHERE viewname LIKE 'v_%content%'` |
| Data migrada | 100% | Compare `content_pieces_v0_7_0` count com `contents` count |

---

## 🧹 Limpeza (após validação)

**⚠️ AGUARDE 7-30 DIAS antes de dropar tabelas legacy!**

Quando estiver 100% confiante:

```sql
-- Drop tabelas backup (IRREVERSÍVEL)
BEGIN;
  DROP TABLE IF EXISTS content_pieces_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS content_projects_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS content_frameworks_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS audience_profiles_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS content_campaigns_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS content_campaign_pieces_v0_7_0 CASCADE;
  DROP TABLE IF EXISTS content_performance_v0_7_0 CASCADE;
COMMIT;

-- Vacuum para recuperar espaço
VACUUM ANALYZE;
```

---

## 📚 Próximos Passos

Após migration bem-sucedida:

1. **Update Application Code**
   - Substituir referências `content_pieces` → `contents`
   - Adicionar suporte a `content_minds` para multi-mind
   - Usar views para queries complexas

2. **Ativar RLS (Row Level Security)**
   ```sql
   -- Ver: expansion-packs/creator-os/database/schema.sql (linhas 398-428)
   -- Descomentar policies e ativar RLS
   ```

3. **Monitorar Performance**
   - Verificar query plans: `EXPLAIN ANALYZE SELECT * FROM v_generated_contents;`
   - Adicionar índices adicionais se necessário

4. **Documentar Mudanças**
   - Atualizar docs de API
   - Notificar equipe sobre novo schema
   - Criar changelog

---

## 🆘 Suporte

**Encontrou problemas?**

1. **Checar logs:** Todas as migrations mostram NOTICE detalhados
2. **DB Sage:** `/db-sage` no Claude Code para diagnóstico interativo
3. **GitHub Issues:** Reportar em `mente_lendaria/issues`
4. **Documentação:** `expansion-packs/creator-os/database/README.md`

---

## ✅ Checklist Final

Antes de considerar concluído:

- [ ] Backup criado e testado
- [ ] Migration executada sem erros
- [ ] Todas validações passaram
- [ ] Smoke tests rodados
- [ ] Application code atualizado
- [ ] Testes E2E passando
- [ ] Monitoramento configurado
- [ ] Documentação atualizada
- [ ] Equipe notificada

---

**Versão:** 002
**Última Atualização:** 2025-10-28
**Autor:** DB Sage
**Status:** ✅ Production Ready
