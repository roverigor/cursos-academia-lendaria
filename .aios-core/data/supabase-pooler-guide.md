# Supabase Connection Pooler Guide

Comprehensive guide for using Supabase's connection pooler for production applications, serverless functions, and data ingestion scripts.

## Overview

Supabase provides a **PgBouncer-based connection pooler** to manage database connections efficiently. Critical for serverless environments, high-concurrency apps, and ETL scripts that would otherwise exhaust PostgreSQL's connection limit.

## Connection Modes

### 1. Transaction Mode (Port 6543)

**Use for:** Serverless functions, short-lived operations, stateless requests

**Behavior:**
- Connection assigned per **transaction** (BEGIN...COMMIT)
- Connection returned to pool after transaction ends
- Most efficient for high-concurrency, short operations
- **Limitation**: Cannot use session-level features (prepared statements, LISTEN/NOTIFY, advisory locks)

**Connection string format:**
```
postgresql://postgres.[project-ref]:[password]@[region].pooler.supabase.com:6543/postgres?sslmode=require
```

**Example:**
```javascript
// Node.js with transaction pooling
const { Pool } = require('pg');

const pool = new Pool({
  host: 'us-east-1.pooler.supabase.com',
  port: 6543,
  database: 'postgres',
  user: 'postgres.uvoikabnkjfvzzzzzzzz', // postgres.[project-ref]
  password: process.env.SUPABASE_DB_PASSWORD,
  ssl: { rejectUnauthorized: false },
  max: 5, // Low pool size - pooler handles scaling
  idleTimeoutMillis: 30000,
});

// Each query is a transaction
const result = await pool.query('SELECT * FROM minds WHERE id = $1', [mindId]);
```

**When to use:**
- AWS Lambda, Vercel Functions, Cloudflare Workers
- Next.js API routes (short-lived)
- High-traffic REST APIs
- Batch ETL scripts (small transactions)

### 2. Session Mode (Port 5432)

**Use for:** Long-lived connections, interactive sessions, prepared statements

**Behavior:**
- Connection assigned per **session** (until client disconnects)
- Supports all PostgreSQL features
- Higher connection overhead (use direct connection for very long sessions)

**Connection string format:**
```
postgresql://postgres.[project-ref]:[password]@db.[project-ref].supabase.co:5432/postgres?sslmode=require
```

**Example:**
```python
# Python with session pooling (long-lived app)
import psycopg2
from psycopg2 import pool

connection_pool = psycopg2.pool.SimpleConnectionPool(
    minconn=1,
    maxconn=10,
    host='db.uvoikabnkjfvzzzzzzzz.supabase.co',
    port=5432,
    database='postgres',
    user='postgres',
    password=os.environ['SUPABASE_DB_PASSWORD'],
    sslmode='require'
)

# Session persists across multiple queries
conn = connection_pool.getconn()
cursor = conn.cursor()
cursor.execute("PREPARE get_mind AS SELECT * FROM minds WHERE id = $1")
cursor.execute("EXECUTE get_mind (%s)", (mind_id,))
```

**When to use:**
- Traditional web servers (Django, Rails, Express)
- Background workers (long-running)
- Interactive CLI tools (psql sessions)
- Applications using prepared statements

### 3. Direct Connection (Port 6543, no pooler)

**Use for:** Database administration, migrations, maintenance

**Behavior:**
- Direct connection to PostgreSQL (bypasses PgBouncer)
- Counts against connection limit (typically 100 for free tier)
- Full PostgreSQL functionality

**Connection string format:**
```
postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres?sslmode=require
```

**When to use:**
- Running migrations (DDL operations)
- Database maintenance (VACUUM, ANALYZE)
- Administrative tasks (user management)
- Schema introspection

## Decision Matrix

| Use Case | Mode | Port | Pooler | Example |
|----------|------|------|--------|---------|
| Serverless function | Transaction | 6543 | Yes | Lambda reading user data |
| REST API endpoint | Transaction | 6543 | Yes | Next.js API route |
| ETL script (batches) | Transaction | 6543 | Yes | Nightly data import (chunked) |
| Background worker | Session | 5432 | Optional | Queue processor |
| CLI tool (interactive) | Session | 5432 | No | psql session |
| Database migration | Direct | 5432 | No | supabase db push |
| Long-running stream | Session | 5432 | No | LISTEN/NOTIFY consumer |

## Configuration for MMOS Project

### ETL Scripts (Data Ingestion)

**Scenario:** Importing mind sources from files

**Recommendation:** Transaction pooling

```javascript
// scripts/etl/import-sources.js
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.SUPABASE_DB_URL, // Use pooler URL
  max: 3, // ETL doesn't need many connections
  idleTimeoutMillis: 10000,
});

async function importSources(mindId, sources) {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    for (const source of sources) {
      await client.query(
        'INSERT INTO sources (mind_id, content, type, metadata) VALUES ($1, $2, $3, $4)',
        [mindId, source.content, source.type, source.metadata]
      );
    }

    await client.query('COMMIT');
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release(); // Return connection to pool
  }
}
```

### API Routes (Next.js/Express)

**Scenario:** REST API for querying minds

**Recommendation:** Transaction pooling with Supabase JS client (handles pooling)

```javascript
// app/api/minds/[id]/route.js
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

export async function GET(request, { params }) {
  const { data, error } = await supabase
    .from('minds')
    .select('*')
    .eq('id', params.id)
    .single();

  // Supabase client uses pooler internally
  return Response.json(data);
}
```

### Database Migrations

**Scenario:** Applying schema changes

**Recommendation:** Direct connection

```bash
# .env
SUPABASE_DB_URL=postgresql://postgres:pwd@db.project.supabase.co:5432/postgres

# scripts/db-migrate.sh
#!/bin/bash
psql "$SUPABASE_DB_URL" -f supabase/migrations/0001_baseline.sql
```

### Background Workers

**Scenario:** Processing mind analysis queue

**Recommendation:** Session pooling (if long-lived) or Transaction pooling (if stateless)

```python
# workers/mind-analyzer.py
import os
import psycopg2
from psycopg2 import pool

# Use session mode for long-lived worker
db_pool = psycopg2.pool.ThreadedConnectionPool(
    minconn=1,
    maxconn=5,
    host='db.project.supabase.co',
    port=5432,
    database='postgres',
    user='postgres',
    password=os.environ['SUPABASE_DB_PASSWORD'],
    sslmode='require'
)

def process_queue():
    conn = db_pool.getconn()
    try:
        while True:
            # Long-lived connection for queue processing
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM analysis_queue WHERE status = 'pending' LIMIT 1 FOR UPDATE SKIP LOCKED")
            # Process...
    finally:
        db_pool.putconn(conn)
```

## Environment Variables

Recommended setup:

```bash
# .env

# Transaction pooling (for scripts, APIs)
SUPABASE_DB_URL_POOLER=postgresql://postgres.project:pwd@region.pooler.supabase.com:6543/postgres?sslmode=require

# Direct connection (for migrations, admin)
SUPABASE_DB_URL=postgresql://postgres:pwd@db.project.supabase.co:5432/postgres?sslmode=require

# Supabase client (handles pooling automatically)
NEXT_PUBLIC_SUPABASE_URL=https://project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...
```

**Usage:**
```javascript
// ETL script
const pool = new Pool({ connectionString: process.env.SUPABASE_DB_URL_POOLER });

// Migration script
const { execSync } = require('child_process');
execSync(`psql ${process.env.SUPABASE_DB_URL} -f migration.sql`);
```

## Best Practices

### 1. Use Minimal Pool Size

Pooler scales automatically - your app doesn't need large pools:

```javascript
// ❌ Bad: Too many connections
const pool = new Pool({ max: 50 });

// ✅ Good: Let pooler handle scaling
const pool = new Pool({ max: 5 });
```

### 2. Always Use SSL

```javascript
// ✅ Good
const pool = new Pool({
  connectionString: '...',
  ssl: { rejectUnauthorized: false }, // Supabase uses self-signed certs
});
```

### 3. Handle Connection Errors

```javascript
pool.on('error', (err, client) => {
  console.error('Unexpected pool error:', err);
  // Don't exit - pool will recover
});
```

### 4. Release Connections

```javascript
// ❌ Bad: Leaks connection
const result = await pool.query('SELECT ...');

// ✅ Good: Explicit release for transactions
const client = await pool.connect();
try {
  await client.query('BEGIN');
  // ... work
  await client.query('COMMIT');
} finally {
  client.release(); // Critical!
}
```

### 5. Use Transactions for Multi-Query Operations

```javascript
// ❌ Bad: Race condition
await pool.query('INSERT INTO minds ...');
await pool.query('INSERT INTO sources ...'); // May use different connection

// ✅ Good: Atomic transaction
const client = await pool.connect();
try {
  await client.query('BEGIN');
  await client.query('INSERT INTO minds ...');
  await client.query('INSERT INTO sources ...');
  await client.query('COMMIT');
} finally {
  client.release();
}
```

## Common Issues

### "Too Many Connections"

**Cause:** Not using pooler, or leaking connections

**Fix:**
1. Switch to pooler URL (port 6543)
2. Ensure all connections are released
3. Reduce pool size (pooler handles scaling)

### "Prepared Statement Does Not Exist"

**Cause:** Using prepared statements with transaction pooler

**Fix:**
1. Switch to session mode (port 5432)
2. Or avoid prepared statements (use parameterized queries)

### "Connection Timeout"

**Cause:** Firewall, SSL issue, or wrong endpoint

**Fix:**
1. Verify URL format: `postgres.[project-ref]` for pooler
2. Ensure `sslmode=require`
3. Check region: `us-east-1.pooler.supabase.com`

### "SSL Error"

**Cause:** Strict SSL verification with self-signed cert

**Fix:**
```javascript
ssl: { rejectUnauthorized: false }
```

## Monitoring

### Check Pool Status

```javascript
console.log({
  total: pool.totalCount,
  idle: pool.idleCount,
  waiting: pool.waitingCount,
});
```

### Log Slow Queries

```javascript
pool.on('connect', (client) => {
  client.on('notice', (msg) => console.warn('Notice:', msg));
});

// Time queries
const start = Date.now();
const result = await pool.query('SELECT ...');
const duration = Date.now() - start;
if (duration > 1000) console.warn(`Slow query: ${duration}ms`);
```

### Supabase Dashboard

- **Database → Connection Pooling** - See active connections
- **Database → Logs** - Query logs and errors

## Testing Pooler Connection

```bash
# Test transaction pooler
psql "postgresql://postgres.project:pwd@region.pooler.supabase.com:6543/postgres?sslmode=require" -c "SELECT current_database(), version();"

# Test direct connection
psql "postgresql://postgres:pwd@db.project.supabase.co:5432/postgres?sslmode=require" -c "SELECT current_database(), version();"
```

## Performance Tips

1. **Batch operations** - Insert/update multiple rows per transaction
2. **Use indexes** - Pooler doesn't fix slow queries
3. **Monitor connection count** - Pooler usage via dashboard
4. **Right-size pool** - Start with `max: 5`, adjust based on metrics
5. **Connection reuse** - Keep pool alive for app lifetime

## Migration from Direct to Pooler

```diff
# Before (direct connection)
- SUPABASE_DB_URL=postgresql://postgres:pwd@db.project.supabase.co:5432/postgres

# After (pooler)
+ SUPABASE_DB_URL=postgresql://postgres.project:pwd@region.pooler.supabase.com:6543/postgres?sslmode=require

# Keep direct for migrations
+ SUPABASE_DB_URL_DIRECT=postgresql://postgres:pwd@db.project.supabase.co:5432/postgres
```

## References

- [Supabase Connection Pooling Docs](https://supabase.com/docs/guides/database/connecting-to-postgres#connection-pooler)
- [PgBouncer Documentation](https://www.pgbouncer.org/usage.html)
- [PostgreSQL Connection Management](https://www.postgresql.org/docs/current/runtime-config-connection.html)
- [Transaction vs Session Mode](https://supabase.com/docs/guides/database/connecting-to-postgres#connection-pool-modes)
