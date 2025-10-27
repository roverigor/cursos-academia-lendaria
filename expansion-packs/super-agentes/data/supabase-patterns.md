# Supabase Patterns

## RLS Performance
- Wrap auth.uid() in SELECT
- Index ALL policy columns
- Use security definer for complex checks
- Avoid LIMIT/OFFSET with RLS

## Multi-Tenant
```sql
team_id IN (SELECT team_id FROM members WHERE user_id = auth.uid())
```

## Time-Based Access
```sql
published_at <= now() AND (expires_at IS NULL OR expires_at > now())
```

## Hierarchical
```sql
EXISTS (SELECT 1 FROM parent WHERE parent.id = table.parent_id AND parent.user_id = auth.uid())
```

## Role-Based
```sql
(auth.jwt() -> 'app_metadata' ->> 'role') IN ('admin', 'moderator')
```

**References:**
- https://supabase.com/docs/guides/troubleshooting/rls-performance-and-best-practices
- https://supabase.com/docs/guides/database/postgres/row-level-security
