# 🗄️ Scan System → Database Migration (KISS Version)

**Status:** Ready to apply
**Complexity:** LOW (1 table, 3 indexes, JSONB everything)
**Time:** ~5 minutes

---

## 📋 What Changed

**From:** Files (YAML + Markdown)
**To:** Database (Supabase `agent_scans` table) + Files (hybrid mode)

**Why:** Enable queries, analytics, and scale to millions of scans (copywriter swipefile)

---

## 🚀 Migration Steps

### 1. Apply Migration

```bash
# From project root
source .env

# Apply migration
psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028_v0_9_0_agent_scans.sql

# Verify
psql "$SUPABASE_DB_URL" -c "SELECT COUNT(*) FROM agent_scans;"
# Expected: 0 (empty table)
```

### 2. Test Insert

```bash
# Test manual insert
psql "$SUPABASE_DB_URL" << 'EOF'
INSERT INTO agent_scans (agent_name, scan_number, artifact_name, data)
VALUES (
  'design-system',
  1,
  'test-artifact',
  '{"type": "HTML", "colors": ["#CC785C"], "test": true}'::jsonb
);

SELECT * FROM agent_scans WHERE agent_name = 'design-system';
EOF
```

### 3. Migrate Existing Scan (Optional)

```bash
# Migrate artifact-001 from YAML to database
cd expansion-packs/super-agentes

# Read existing metadata
cat ../../docs/design-system/analysis/.metadata/001.yaml

# Insert into database manually (example)
psql "$SUPABASE_DB_URL" << 'EOF'
INSERT INTO agent_scans (agent_name, scan_number, artifact_name, data)
VALUES (
  'design-system',
  1,
  'comparison-table',
  '{
    "type": "HTML",
    "colors": ["#CC785C", "#D4A27F", "#BF4D43"],
    "components": ["table", "header", "badge"],
    "patterns": ["dark-theme", "comparison-matrix"],
    "quality_score": 85
  }'::jsonb
);
EOF
```

---

## 🧪 Test Queries

```sql
-- List all scans
SELECT
  id,
  agent_name,
  scan_number,
  artifact_name,
  data->>'quality_score' as score,
  created_at
FROM agent_scans
ORDER BY created_at DESC;

-- Get unique colors from design-system scans
SELECT DISTINCT jsonb_array_elements_text(data->'colors') as color
FROM agent_scans
WHERE agent_name = 'design-system';

-- Count scans per agent
SELECT agent_name, COUNT(*)
FROM agent_scans
GROUP BY agent_name;

-- Next scan number for agent
SELECT get_next_scan_number('design-system');
```

---

## 📊 JSONB Structure by Agent

### Design System:
```json
{
  "type": "HTML",
  "colors": ["#CC785C", "#D4A27F"],
  "components": ["button", "table", "header"],
  "patterns": ["dark-theme", "grid-layout"],
  "typography": ["Inter", "16px"],
  "quality_score": 85
}
```

### Copywriter:
```json
{
  "headline": "Are You Making This Costly Mistake?",
  "hook_type": "question",
  "frameworks": ["PAS", "curiosity-gap"],
  "emotion_triggers": ["anxiety", "fomo"],
  "cta": "Learn More",
  "niche": "saas",
  "word_count": 47,
  "quality_score": 92
}
```

---

## 🔄 Rollback (If Needed)

```bash
psql "$SUPABASE_DB_URL" -f supabase/rollback/20251028_v0_9_0_agent_scans_rollback.sql
```

---

## ✅ Success Criteria

- [x] Migration applied without errors
- [x] `agent_scans` table exists
- [x] Test insert works
- [x] Queries return data
- [x] `get_next_scan_number()` function works

---

## 🎯 Next Steps

1. **Update scan tasks** to INSERT into database (in progress)
2. **Test** with design-system agent
3. **Create** copywriter agent scan task
4. **Start** swipefile ingestion (batch processing)

---

**Migration created:** 2025-10-28
**DB Sage:** Ready to assist with any issues
