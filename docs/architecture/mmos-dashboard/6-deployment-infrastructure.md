# 6. Deployment & Infrastructure

**Document:** MMOS Admin Dashboard - Deployment & Infrastructure
**Version:** 1.0
**Last Updated:** 2025-10-28

---

## Hosting Strategy

### Vercel (Frontend)
- Global CDN (50+ cities)
- Automatic HTTPS
- Preview deployments per PR
- Zero-config Next.js optimization

### Supabase (Backend)
- Managed PostgreSQL
- Global distribution
- Automatic backups
- Connection pooling

---

## Environments

| Environment | Frontend URL | Backend | Purpose |
|-------------|-------------|---------|---------|
| Development | `localhost:3000` | Local Supabase | Local dev |
| Staging | `staging.lendario.ai` | Supabase Staging | QA testing |
| Production | `admin.lendario.ai` | Supabase Production | Live system |

---

## CI/CD Pipeline

```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - run: pnpm install
      - run: pnpm test
      - run: pnpm build
      - uses: vercel/action@latest
```

---

## Environment Variables

```bash
# Frontend (.env.local)
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxx

# Backend (Vercel Environment)
SUPABASE_SERVICE_ROLE_KEY=eyJxxx (secret)
WEBHOOK_SECRET=xxx (secret)
```

---

## Scaling Strategy

**Current:** 13MB database, <100 req/day
**Year 1:** 500MB database, 10K req/day
**Platform Limits:** Handles 500K req/day

**Mitigation:**
- Connection pooling (automatic)
- Read replicas (if needed >100K req/day)
- CDN caching (Vercel)

---

**Previous:** [← 5. Backend Architecture](./5-backend-architecture.md)
**Next:** [7. Security & Performance →](./7-security-performance.md)
