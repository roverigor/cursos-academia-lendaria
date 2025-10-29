# 9. Development Workflow

**Document:** MMOS Admin Dashboard - Development Workflow
**Version:** 1.0
**Last Updated:** 2025-10-28

---

## Local Development Setup

### Prerequisites

```bash
# Required software
- Node.js 18+ (via nvm)
- pnpm 8+
- Git
- Supabase CLI

# Install
brew install node
npm install -g pnpm
brew install supabase/tap/supabase
```

---

## Initial Setup

```bash
# 1. Clone repository
git clone https://github.com/org/mente_lendaria.git
cd mente_lendaria/apps/dashboard

# 2. Install dependencies
pnpm install

# 3. Set up environment variables
cp .env.example .env.local

# Edit .env.local with your Supabase credentials (see below for complete list)

# 4. Start Supabase locally (optional)
supabase start

# 5. Generate database types
pnpm db:types

# 6. Start development server
pnpm dev
```

Navigate to `http://localhost:3000`

---

## Environment Variables Configuration

### Frontend Environment (.env.local)

**Required for local development:**

```bash
# === SUPABASE CONNECTION (Public) ===
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# === APPLICATION URL ===
NEXT_PUBLIC_APP_URL=http://localhost:3000

# === OPTIONAL: FEATURE FLAGS ===
NEXT_PUBLIC_ENABLE_ANALYTICS=false
```

### Backend Environment (Vercel Secrets - Production)

**⚠️ NEVER commit these values to git!**

```bash
# === SUPABASE ADMIN (SECRET) ===
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# === DATABASE CONNECTIONS ===
# Transaction mode (for API routes)
SUPABASE_DB_URL=postgresql://postgres:password@db.project.pooler.supabase.com:6543/postgres

# Session mode (for migrations)
DATABASE_URL=postgresql://postgres:password@db.project.supabase.co:5432/postgres

# === WEBHOOK SECURITY ===
WEBHOOK_SECRET=your-webhook-secret-key-here

# === ERROR TRACKING (Production) ===
SENTRY_DSN=https://abc123@o123456.ingest.sentry.io/123456
SENTRY_AUTH_TOKEN=sntrys_your_auth_token
SENTRY_ORG=your-org
SENTRY_PROJECT=mmos-dashboard

# === EMAIL SERVICE (Optional) ===
RESEND_API_KEY=re_123456789

# === RATE LIMITING (Optional - Upstash Redis) ===
UPSTASH_REDIS_REST_URL=https://your-project.upstash.io
UPSTASH_REDIS_REST_TOKEN=your-upstash-token
```

### Getting the Values

**1. Supabase Keys:**
```bash
# Navigate to: Supabase Dashboard → Settings → API
# Copy:
# - Project URL → NEXT_PUBLIC_SUPABASE_URL
# - anon/public key → NEXT_PUBLIC_SUPABASE_ANON_KEY
# - service_role key → SUPABASE_SERVICE_ROLE_KEY (⚠️ SECRET!)
```

**2. Database URLs:**
```bash
# Navigate to: Supabase Dashboard → Settings → Database
# Copy:
# - Connection string (Transaction mode) → SUPABASE_DB_URL
# - Connection string (Session mode) → DATABASE_URL
```

**3. Webhook Secret:**
```bash
# Generate a random secret
openssl rand -hex 32
```

**4. Sentry DSN (when ready for production):**
```bash
# 1. Create account at sentry.io
# 2. Create Next.js project
# 3. Copy DSN from project settings
```

### .env.example Template

**Create this file for your team:**

```bash
# .env.example
# Copy to .env.local and fill with your values

# === REQUIRED FOR LOCAL DEVELOPMENT ===
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_APP_URL=http://localhost:3000

# === REQUIRED FOR BACKEND (Vercel Secrets in Production) ===
# DO NOT commit these values!
SUPABASE_SERVICE_ROLE_KEY=
DATABASE_URL=
SUPABASE_DB_URL=
WEBHOOK_SECRET=

# === OPTIONAL (Add when ready) ===
# SENTRY_DSN=
# RESEND_API_KEY=
# UPSTASH_REDIS_REST_URL=
# UPSTASH_REDIS_REST_TOKEN=
```

---

## Development Commands

```bash
# Development
pnpm dev              # Start dev server (localhost:3000)
pnpm dev:turbo        # Start with Turbopack (faster)

# Database
pnpm db:types         # Generate TypeScript types from Supabase
pnpm db:migrate       # Run database migrations
pnpm db:reset         # Reset local database

# Testing
pnpm test             # Run all tests
pnpm test:unit        # Unit tests only
pnpm test:integration # Integration tests
pnpm test:e2e         # E2E tests (requires dev server)
pnpm test:watch       # Watch mode

# Code Quality
pnpm lint             # ESLint check
pnpm lint:fix         # Auto-fix linting issues
pnpm typecheck        # TypeScript type checking
pnpm format           # Prettier formatting

# Build
pnpm build            # Production build
pnpm start            # Start production server

# UI Components
pnpx shadcn-ui add [component]  # Add shadcn component
```

---

## Project Structure

```
apps/dashboard/
├── app/                    # Next.js 14 App Router
│   ├── (auth)/            # Auth pages (no layout)
│   ├── (dashboard)/       # Main app (with layout)
│   ├── api/               # API routes
│   ├── globals.css        # Global styles
│   └── layout.tsx         # Root layout
│
├── components/            # React components
│   ├── ui/               # shadcn/ui components
│   ├── layout/           # Layout components
│   ├── minds/            # Feature components
│   └── forms/            # Form components
│
├── lib/                  # Utilities
│   ├── supabase.ts       # Supabase client
│   ├── queries.ts        # TanStack Query hooks
│   ├── services/         # Business logic
│   └── hooks/            # Custom React hooks
│
├── types/                # TypeScript types
│   └── supabase.ts       # Generated DB types
│
├── tests/                # Tests
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
└── public/               # Static assets
```

---

## Coding Standards

### File Naming

```
Components:      PascalCase     (MindCard.tsx)
Hooks:           camelCase      (useMind.ts)
Utils:           camelCase      (formatDate.ts)
API Routes:      kebab-case     (export-mind/route.ts)
Types:           PascalCase     (Mind.ts)
```

### Component Template

```typescript
// components/minds/mind-card.tsx
import { Card } from '@/components/ui/card';
import type { Mind } from '@/types/supabase';

interface MindCardProps {
  mind: Mind;
  onClick?: () => void;
}

export function MindCard({ mind, onClick }: MindCardProps) {
  return (
    <Card onClick={onClick}>
      <h3>{mind.name}</h3>
    </Card>
  );
}
```

### Import Order

```typescript
// 1. React
import { useState, useEffect } from 'react';

// 2. Next.js
import Image from 'next/image';
import Link from 'next/link';

// 3. External libraries
import { useQuery } from '@tanstack/react-query';

// 4. Internal components
import { Button } from '@/components/ui/button';

// 5. Utils/hooks
import { cn } from '@/lib/utils';
import { useMind } from '@/lib/hooks/use-mind';

// 6. Types
import type { Mind } from '@/types/supabase';

// 7. Styles (if any)
import styles from './component.module.css';
```

---

## Git Workflow

### Branch Naming

```
feat/mind-export       # New feature
fix/auth-redirect      # Bug fix
chore/update-deps      # Maintenance
docs/api-guide         # Documentation
refactor/services      # Code refactor
```

### Commit Convention

```bash
# Format: <type>: <description>

feat: add mind export functionality
fix: resolve authentication redirect loop
chore: update dependencies to latest
docs: add API documentation
refactor: extract mind service logic
test: add unit tests for minds service
```

### Pull Request Process

1. Create feature branch from `main`
2. Make changes and commit
3. Push branch and create PR
4. CI runs (tests, lint, build)
5. Request review from team
6. Address feedback
7. Merge to `main` (squash commits)
8. Delete feature branch

---

## Database Workflow

### Making Schema Changes

```bash
# 1. Create migration
supabase migration new add_mind_tags

# 2. Edit migration file
# supabase/migrations/20250128_add_mind_tags.sql
CREATE TABLE mind_tags (...);

# 3. Apply locally
supabase migration up

# 4. Regenerate types
pnpm db:types

# 5. Commit migration + types
git add supabase/migrations types/supabase.ts
git commit -m "feat: add mind tags table"

# 6. Apply to staging/prod via CI/CD
```

---

## Troubleshooting

### Common Issues

**Issue:** `pnpm install` fails
```bash
# Solution: Clear cache
pnpm store prune
rm -rf node_modules
pnpm install
```

**Issue:** Type errors after schema change
```bash
# Solution: Regenerate types
pnpm db:types
pnpm typecheck
```

**Issue:** Dev server won't start
```bash
# Solution: Kill existing process
lsof -ti:3000 | xargs kill -9
pnpm dev
```

---

## Code Review Checklist

- [ ] Code follows naming conventions
- [ ] All components are typed (no `any`)
- [ ] Tests added for new features
- [ ] No console.logs in production code
- [ ] Error handling implemented
- [ ] Accessibility considerations (ARIA, keyboard nav)
- [ ] Performance optimized (no unnecessary re-renders)
- [ ] Documentation updated (if needed)

---

**Previous:** [← 8. Testing & Monitoring](./8-testing-monitoring.md)
**Next:** [10. Stakeholder Review Guide →](./10-stakeholder-review-guide.md)
