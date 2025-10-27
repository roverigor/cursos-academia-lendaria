# Database User Impersonation Task

This task enables RLS testing by simulating authenticated users in PostgreSQL/Supabase sessions without requiring a full authentication stack.

## Purpose

Test Row Level Security (RLS) policies by impersonating users with different roles and permissions. Critical for validating multi-tenant data isolation before production.

## Prerequisites

- PostgreSQL/Supabase database accessible
- `SUPABASE_DB_URL` environment variable set
- User UUIDs to impersonate (from `auth.users` or test data)
- Tables with RLS enabled

## Instructions

### 1. Validate Environment

Check database connectivity:

```bash
psql "$SUPABASE_DB_URL" -c "SELECT current_database(), current_user;"
```

If this fails, run `*env-check` first.

### 2. Gather Context

Ask the user:
- **User UUID to impersonate** (or use test UUID: `00000000-0000-0000-0000-000000000000`)
- **Email** (optional, for readability)
- **Target tables** to test (or use all RLS-enabled tables)
- **Operations to test**: SELECT, INSERT, UPDATE, DELETE

### 3. Generate Impersonation SQL

Create session setup script:

```sql
-- Impersonate authenticated user
SET role authenticated;

-- Set JWT claims (Supabase pattern)
SET request.jwt.claims = '{
  "sub": "<user-uuid>",
  "email": "<user-email>",
  "role": "authenticated",
  "aud": "authenticated",
  "exp": 9999999999
}';

-- Verify impersonation
SELECT
  current_setting('request.jwt.claims', true) as jwt_claims,
  auth.uid() as user_id,
  auth.email() as user_email;
```

**Key points:**
- `SET role authenticated` switches to authenticated role
- `request.jwt.claims` is the GUC (Grand Unified Configuration) variable Supabase uses
- `auth.uid()` reads `sub` from claims
- `auth.email()` reads `email` from claims

### 4. Execute Test Queries

Run representative queries for each operation:

```sql
-- Test SELECT (should only see user's data)
SELECT count(*) FROM minds WHERE creator_mind_id = auth.uid();

-- Test INSERT (should enforce ownership)
INSERT INTO sources (mind_id, content, creator_mind_id)
VALUES ('<mind-uuid>', 'test', auth.uid());

-- Test UPDATE (should only affect user's rows)
UPDATE fragments SET content = 'updated' WHERE id = '<fragment-uuid>';

-- Test DELETE (should only delete user's rows)
DELETE FROM sources WHERE id = '<source-uuid>';
```

### 5. Test Negative Cases

Verify policies BLOCK unauthorized access:

```sql
-- Try accessing another user's data (should return 0 rows)
SELECT count(*) FROM minds WHERE creator_mind_id != auth.uid();

-- Try modifying another user's data (should fail or return 0)
UPDATE sources SET content = 'hack' WHERE creator_mind_id != auth.uid();
```

### 6. Reset Session

```sql
-- Reset to service role
RESET role;
RESET request.jwt.claims;

-- Verify reset
SELECT current_user, auth.uid(); -- auth.uid() should be NULL
```

## Output Format

Present results as:

```
🧪 RLS Impersonation Test Results

User: <email> (<uuid>)

✅ SELECT minds: 3 rows (expected: own data only)
✅ INSERT sources: BLOCKED (not owner of mind)
⚠️  UPDATE fragments: 1 row affected (verify: should be user's fragment)
❌ DELETE sources: FAILED with permission denied (expected: should succeed for own data)

Negative Tests:
✅ Access other user's minds: 0 rows (correct)
✅ Modify other user's data: 0 rows affected (correct)

Session Reset: ✅

Recommendations:
- Review DELETE policy on sources table (may be too restrictive)
```

## Interactive Mode

If user doesn't provide UUID:

1. List recent users: `SELECT id, email FROM auth.users LIMIT 10;`
2. Or suggest test UUID: `00000000-0000-0000-0000-000000000000`
3. Confirm tables to test
4. Run suite and present findings

## YOLO Mode

Run full suite against all RLS tables with 2-3 test users, report aggregate findings.

## Common Issues

**auth.uid() returns NULL:**
- Ensure `SET role authenticated` was executed
- Verify `request.jwt.claims` contains valid JSON with `sub` field
- Check Supabase is configured (not vanilla Postgres)

**Policies not enforced:**
- Verify RLS is enabled: `SELECT tablename FROM pg_tables WHERE rowsecurity = true;`
- Check policies exist: `SELECT * FROM pg_policies WHERE tablename = '<table>';`
- Service role bypasses RLS (use authenticated role)

**Syntax error on SET request.jwt.claims:**
- Use single quotes for JSON: `'{...}'` not `"{...}"`
- Ensure valid JSON (no trailing commas)

## Best Practices

- **Test with 3 personas**: owner, viewer, stranger
- **Automate**: Save test script to `supabase/tests/rls-impersonate-<table>.sql`
- **Index helpers**: Ensure `auth.uid()` columns are indexed
- **Positive + Negative**: Test both allowed and blocked operations
- **Reset always**: Never leave session impersonated

## Integration with Other Commands

- Before: `*rls-audit` to identify tables needing tests
- After: `*smoke-test` to validate full migration
- Pair with: `*policy-apply` to fix failing policies

## References

- Supabase JWT Claims: https://supabase.com/docs/guides/auth/row-level-security#helper-functions
- RLS Testing: https://supabase.com/docs/guides/database/postgres/row-level-security#testing-policies
- auth.uid() implementation: Uses `request.jwt.claims->>'sub'::uuid`
