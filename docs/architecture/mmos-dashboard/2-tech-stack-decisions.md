# 2. Tech Stack Decisions

**Document:** MMOS Admin Dashboard - Technology Stack
**Version:** 1.0
**Last Updated:** 2025-10-28

---

## 📋 Table of Contents

1. [Technology Stack Table](#technology-stack-table)
2. [Category-by-Category Analysis](#category-by-category-analysis)
3. [Version Lock Strategy](#version-lock-strategy)
4. [Dependency Management](#dependency-management)
5. [Upgrade Path](#upgrade-path)

---

## Technology Stack Table

**⚠️ CRITICAL:** This table is the **single source of truth** for all technology decisions. All development must use these exact versions.

| Category | Technology | Version | Purpose | Rationale |
|----------|------------|---------|---------|-----------|
| **Frontend Language** | TypeScript | 5.3.x | Type-safe JavaScript | Industry standard, catches 80% of bugs at compile time, excellent IDE support |
| **Frontend Framework** | Next.js | 14.2.x | React meta-framework | Server Components, App Router, Vercel optimization, best-in-class DX |
| **UI Library** | React | 18.3.x | Component-based UI | Largest ecosystem, Server Components support, proven at scale |
| **UI Component Library** | shadcn/ui | Latest | Accessible components | Copy-paste components (no npm bloat), built on Radix UI, full customization |
| **Styling** | Tailwind CSS | 3.4.x | Utility-first CSS | Fast development, <10KB in production, excellent with Next.js |
| **State Management** | TanStack Query | 5.x | Server state | Best async state solution, caching, optimistic updates, works great with Supabase |
| **Global State** | Zustand | 4.x | Client state | Lightweight (1KB), simple API, no boilerplate vs Redux |
| **Form Management** | React Hook Form | 7.x | Form handling | Best performance (uncontrolled), Zod integration, <5KB |
| **Validation** | Zod | 3.x | Schema validation | Type-safe validation, integrates with React Hook Form, shared with backend |
| **Data Tables** | TanStack Table | 8.x | Complex tables | Headless table library, sorting/filtering/pagination, 14KB |
| **Charts** | Recharts | 2.x | Data visualization | React-native, composable, supports all chart types we need |
| **Icons** | Lucide React | Latest | Icon library | Modern, tree-shakeable, 1K+ icons, consistent style |
| **Date/Time** | date-fns | 3.x | Date manipulation | Modular (import only what you need), immutable, <20KB for our use cases |
| **Backend Language** | TypeScript | 5.3.x | Type-safe Node.js | Same as frontend, shared types, unified codebase |
| **Backend Framework** | Supabase | 2.x | BaaS platform | PostgreSQL + Auth + Storage + Realtime in one, 80% less backend code |
| **Database** | PostgreSQL | 17.6 | Relational database | Proven ACID compliance, excellent JSON support (JSONB), RLS for security |
| **Database ORM** | Supabase Client | 2.x | Database queries | Type-safe queries, auto-generated types, real-time subscriptions |
| **Authentication** | Supabase Auth | 2.x | User authentication | JWT tokens, social login ready, integrates with RLS |
| **File Storage** | Supabase Storage | 2.x | File uploads | S3-compatible, RLS policies, CDN integration |
| **API Style** | REST (Supabase) | - | Data access | Supabase auto-generates REST API, no custom routes needed for 90% of cases |
| **API Routes** | Next.js API Routes | 14.2.x | Custom endpoints | For webhooks, exports, complex logic that can't be done in Supabase |
| **Real-time** | Supabase Realtime | 2.x | Live updates | WebSocket subscriptions, PostgreSQL change detection |
| **Email** | Supabase Auth + Resend | Latest | Transactional email | Auth emails via Supabase, marketing via Resend (future) |
| **Frontend Testing** | Vitest | 1.x | Unit tests | Vite-powered, 10x faster than Jest, ESM support |
| **Component Testing** | React Testing Library | 14.x | Component tests | Best practices (test behavior not implementation), accessible queries |
| **Backend Testing** | Vitest | 1.x | API/function tests | Same test runner for frontend/backend, simpler CI |
| **E2E Testing** | Playwright | 1.x | End-to-end tests | Cross-browser, auto-wait, debugging tools, 3x faster than Cypress |
| **Type Checking** | TypeScript Compiler | 5.3.x | Static analysis | Strict mode enabled, catches errors before runtime |
| **Linting** | ESLint | 8.x | Code quality | Next.js config + strict rules, enforces conventions |
| **Formatting** | Prettier | 3.x | Code formatting | Consistent style, integrates with ESLint |
| **Build Tool** | Next.js | 14.2.x | Bundling | Built-in webpack/turbopack, optimized for production |
| **Package Manager** | pnpm | 8.x | Dependency management | Faster than npm (3x), disk efficient, strict by default |
| **Monorepo Tool** | Turborepo | 1.x | Build orchestration | Caching, parallel execution, Vercel-native (future when we need monorepo) |
| **Version Control** | Git + GitHub | - | Source control | Industry standard, GitHub Actions integration |
| **CI/CD** | GitHub Actions | - | Automation | Free for public/private repos, Vercel integration |
| **Hosting (Frontend)** | Vercel | - | Frontend deployment | Zero-config Next.js, global CDN, preview deployments |
| **Hosting (Backend)** | Supabase | - | Backend services | Managed PostgreSQL, auto-scaling, global distribution |
| **Monitoring (Frontend)** | Vercel Analytics | - | Web vitals | Built-in, zero config, privacy-friendly |
| **Monitoring (Backend)** | Supabase Dashboard | - | Database metrics | Query performance, connection pooling, storage usage |
| **Error Tracking** | Sentry | Latest | Error monitoring | Source maps, breadcrumbs, release tracking (add when in production) |
| **Logging** | Console + Supabase Logs | - | Application logs | Development: console, Production: Supabase logs viewer |

---

## Category-by-Category Analysis

### Frontend Stack

#### Why Next.js 14 + App Router?

**The Decision:**
Next.js 14 with App Router over Pages Router, Remix, or vanilla React + Vite.

**Deep Dive:**

**Server Components (Game Changer):**
```tsx
// app/minds/page.tsx - Server Component (default)
async function MindsPage() {
  // Runs on server, no client JS shipped
  const { data } = await supabase.from('minds').select('*');

  return (
    <div>
      {/* Rendered on server, SEO-friendly, instant FCP */}
      <MindsList minds={data} />
    </div>
  );
}

// Reduces bundle size by ~30-40% (no React Query needed for server data)
// Improves FCP by ~200ms (server-rendered, no loading spinner)
```

**App Router Benefits:**
- Co-location of routes and components
- Layouts with automatic nesting
- Loading and error boundaries
- Streaming SSR for partial page loads

**Trade-offs:**
- ⚠️ Learning curve (new mental model vs Pages Router)
- ⚠️ Some libraries not optimized for Server Components yet
- ✅ **Mitigation:** Use "use client" directive for client-only components

**Why Not Remix?**
- Smaller ecosystem than Next.js
- Less mature than Next.js (launched 2020 vs 2016)
- Vercel optimization is Next.js-first

**Why Not Vite + React?**
- No SSR/SSG out of the box
- Have to configure routing, data fetching, etc.
- More boilerplate for same result

---

#### Why shadcn/ui over MUI or Ant Design?

**The Decision:**
shadcn/ui (copy-paste components) over traditional component libraries.

**Deep Dive:**

**The Problem with Traditional Libraries:**
```json
// MUI approach - 300KB+ npm package
{
  "dependencies": {
    "@mui/material": "^5.0.0",     // 150KB
    "@mui/icons-material": "^5.0.0", // 150KB
    "@emotion/react": "^11.0.0"     // Peer dep
  }
}
// Total: ~400KB before tree-shaking
// Styling tied to MUI's emotion/styled-components
```

**shadcn/ui Approach:**
```bash
# Only copy components you actually use
npx shadcn-ui add button
npx shadcn-ui add data-table

# Result: Components copied to your codebase
# You own the code, modify as needed
# Bundle size: only what you use (~10-20KB total)
```

**Why This Matters:**
- ✅ No npm bloat (400KB → 20KB)
- ✅ Full customization (owns the code)
- ✅ Built on Radix UI (accessible by default)
- ✅ Tailwind-native (consistent styling)

**Trade-offs:**
- ⚠️ Update components manually (no npm update)
- ✅ **Mitigation:** Components are stable, rarely need updates

---

#### Why TanStack Query + Zustand over Redux?

**The Decision:**
Split state management: TanStack Query (server) + Zustand (client).

**Deep Dive:**

**The Problem with Redux:**
```typescript
// Redux for server state - massive boilerplate
const mindsSlice = createSlice({
  name: 'minds',
  initialState: { data: [], loading: false, error: null },
  reducers: {
    fetchMindsStart: (state) => { state.loading = true },
    fetchMindsSuccess: (state, action) => { /* ... */ },
    fetchMindsError: (state, action) => { /* ... */ }
  }
});

// Need thunks for async:
export const fetchMinds = createAsyncThunk('minds/fetch', async () => {
  const response = await supabase.from('minds').select('*');
  return response.data;
});

// Usage in component:
const dispatch = useDispatch();
const minds = useSelector(state => state.minds.data);
useEffect(() => { dispatch(fetchMinds()) }, []);

// 50+ lines for simple data fetching
```

**TanStack Query Approach:**
```typescript
// server state/queries.ts
export function useMinds() {
  return useQuery({
    queryKey: ['minds'],
    queryFn: async () => {
      const { data } = await supabase.from('minds').select('*');
      return data;
    }
  });
}

// Usage in component:
const { data: minds, isLoading, error } = useMinds();

// 10 lines, includes loading/error states, caching, refetching
```

**Zustand for Client State:**
```typescript
// stores/ui.ts - Simple global state
const useUIStore = create((set) => ({
  sidebarOpen: true,
  toggleSidebar: () => set((state) => ({ sidebarOpen: !state.sidebarOpen }))
}));

// Usage:
const { sidebarOpen, toggleSidebar } = useUIStore();

// 5 lines vs 50 lines of Redux boilerplate
```

**Why This Wins:**
- ✅ TanStack Query: Best async state (caching, optimistic updates, refetching)
- ✅ Zustand: Best client state (simple, 1KB, no context hell)
- ✅ Combined: 95% less boilerplate than Redux
- ✅ Type-safe with TypeScript

---

### Backend Stack

#### Why Supabase over Custom Node.js API?

**The Decision:**
Supabase-first, custom API routes only when absolutely needed.

**Deep Dive:**

**What Supabase Gives Us:**
```typescript
// ❌ Without Supabase - Custom Express API
app.get('/api/minds', authenticate, async (req, res) => {
  try {
    const user = req.user;

    // Manual authorization
    const minds = await db.query(
      'SELECT * FROM minds WHERE creator_user_id = $1',
      [user.id]
    );

    res.json(minds.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Need to write:
// - Express setup (100 lines)
// - Auth middleware (50 lines)
// - Error handling (50 lines)
// - Input validation (30 lines)
// - Database connection pooling (30 lines)
// Total: ~300 lines of boilerplate PER resource
```

**With Supabase:**
```typescript
// ✅ With Supabase - Zero backend code
const { data, error } = await supabase
  .from('minds')
  .select('*');

// Authorization happens automatically via RLS:
CREATE POLICY "minds_user_access" ON minds
  FOR SELECT TO authenticated
  USING (creator_user_id = auth.uid());

// Result:
// - 0 lines of backend code
// - Auth handled by Supabase
// - Authorization via RLS (database layer)
// - Type-safe queries (generated types)
```

**When We Need Custom API Routes:**
```typescript
// app/api/export-mind/route.ts
// Use case: Complex logic that can't be done in SQL
export async function POST(request: Request) {
  const { mindId } = await request.json();

  // Multi-step operation
  const mind = await getMind(mindId);
  const fragments = await getFragments(mindId);
  const knowledge = await buildKnowledgeBase(fragments);

  // Generate ZIP file
  const zip = await createZipArchive(mind, knowledge);

  return new Response(zip, {
    headers: { 'Content-Type': 'application/zip' }
  });
}

// This CAN'T be done via Supabase queries - need custom route
```

**What We Get:**
- ✅ Auto-generated REST API (no code)
- ✅ Type-safe queries (generated from schema)
- ✅ Real-time subscriptions (WebSockets)
- ✅ Row Level Security (database-enforced auth)
- ✅ Connection pooling (automatic)
- ✅ 80% reduction in backend code

**Trade-offs:**
- ⚠️ Vendor lock-in to Supabase
- ⚠️ Complex queries might need custom functions
- ✅ **Mitigation:** PostgreSQL is open-source, can migrate

---

#### Why PostgreSQL 17.6 over MongoDB/Firebase?

**The Decision:**
PostgreSQL (relational) over NoSQL alternatives.

**Deep Dive:**

**Our Data is Relational:**
```
Minds → Mind Profiles → Trait Scores → Traits (taxonomy)
                     ↓
                  Fragments → Fragment Tags → Tags
                           → Fragment Relationships
```

**PostgreSQL Advantages:**
```sql
-- Complex query that's trivial in SQL, nightmare in NoSQL:
SELECT
  m.name,
  mp.fidelity_score,
  COUNT(f.id) as fragment_count,
  AVG(ts.score_10) as avg_trait_score
FROM minds m
LEFT JOIN mind_profiles mp ON mp.mind_id = m.id
LEFT JOIN fragments f ON f.mind_id = m.id
LEFT JOIN trait_scores ts ON ts.mind_id = m.id
WHERE m.status = 'active'
GROUP BY m.id, m.name, mp.fidelity_score
ORDER BY mp.fidelity_score DESC;

-- In MongoDB: 4+ separate queries + client-side joining
-- In Firestore: Impossible (no JOINs)
```

**PostgreSQL 17.6 Features We Use:**
- JSONB columns (flexibility where needed)
- Full-text search (for knowledge base search)
- Row Level Security (multi-tenant isolation)
- Partial indexes (performance optimization)
- Generated columns (computed values)

**Why Not MongoDB:**
- ❌ Weak relationship modeling (manual references)
- ❌ No JOIN support (app-level aggregation)
- ❌ Limited transaction support
- ❌ Schema flexibility is a bug, not feature (for our use case)

**Why Not Firestore:**
- ❌ No SQL support (limited queries)
- ❌ No JOINs whatsoever
- ❌ Expensive at scale (per-read pricing)
- ❌ Document size limits (1MB)

---

### Testing Stack

#### Why Vitest over Jest?

**The Decision:**
Vitest for both frontend and backend unit tests.

**Deep Dive:**

**Performance Comparison:**
```bash
# Jest (traditional)
npm test
# First run: 15-20s
# Watch mode: 3-5s per change
# ESM support: Requires babel config

# Vitest (Vite-powered)
npm test
# First run: 2-3s (5-10x faster)
# Watch mode: 0.5-1s per change (3-5x faster)
# ESM support: Native (no config)
```

**Why It's Faster:**
- Vite's HMR infrastructure (reuses dev server)
- ESM-native (no Babel transformation)
- Smart file watching (only re-run affected tests)

**API Compatibility:**
```typescript
// Vitest is Jest-compatible API
import { describe, it, expect, vi } from 'vitest';

describe('Mind Service', () => {
  it('fetches minds from database', async () => {
    const minds = await getMinds();
    expect(minds).toHaveLength(22);
  });

  it('mocks Supabase client', () => {
    const mock = vi.fn();
    // Same API as jest.fn()
  });
});

// 95% of Jest tests work in Vitest without changes
```

**Why Not Keep Jest:**
- ❌ Slower (especially for large test suites)
- ❌ ESM support requires complex config
- ❌ Not optimized for Vite/Next.js
- ✅ Vitest: Drop-in replacement, better DX

---

#### Why Playwright over Cypress?

**The Decision:**
Playwright for E2E tests.

**Deep Dive:**

**Playwright Advantages:**
```typescript
// playwright/e2e/minds.spec.ts
import { test, expect } from '@playwright/test';

test('user can create a new mind', async ({ page }) => {
  await page.goto('/minds');
  await page.click('text=New Mind');

  // Auto-wait (no cy.wait() hacks)
  await page.fill('input[name="name"]', 'Steve Jobs');
  await page.click('button:text("Create")');

  // Assertion
  await expect(page.locator('text=Steve Jobs')).toBeVisible();

  // Built-in screenshots/video on failure
  // Multi-browser testing (Chromium, Firefox, WebKit)
});

// Cypress equivalent requires more setup, no Firefox/WebKit
```

**Speed Comparison:**
```bash
# Cypress
npm run test:e2e
# Run 10 tests: 45-60s
# Browser overhead: High (Electron)
# Parallel execution: Paid feature

# Playwright
npm run test:e2e
# Run 10 tests: 15-20s (3x faster)
# Browser overhead: Low (native browsers)
# Parallel execution: Free (built-in)
```

**Why Playwright Wins:**
- ✅ 3x faster execution
- ✅ True multi-browser (Chrome, Firefox, Safari)
- ✅ Better debugging (trace viewer, inspector)
- ✅ Parallel execution (free)
- ✅ Better CI integration (docker images)

---

## Version Lock Strategy

### Locked Dependencies (Exact Versions)

**These use exact versions (no ^ or ~) to prevent unexpected breakage:**

```json
{
  "dependencies": {
    "next": "14.2.3",              // Lock Next.js (breaking changes common)
    "react": "18.3.1",              // Lock React (stable API)
    "@supabase/supabase-js": "2.39.7", // Lock Supabase client
    "zod": "3.22.4"                 // Lock Zod (validation schema changes break)
  }
}
```

**Rationale:**
- Next.js: Minor versions can have breaking changes in App Router
- Supabase: Client changes can affect query API
- Zod: Schema validation is critical, lock to prevent surprises

---

### Flexible Dependencies (^ Range)

**These use ^ for minor/patch updates:**

```json
{
  "dependencies": {
    "lucide-react": "^0.344.0",    // Icons rarely break
    "date-fns": "^3.3.1",          // Stable API
    "tailwindcss": "^3.4.1"        // Backward compatible
  }
}
```

---

### Update Cadence

**Monthly:** Review and update all dependencies
**Weekly:** Security patches only
**Never:** Automatic updates (Dependabot PRs require manual review)

---

## Dependency Management

### pnpm over npm/yarn

**Why pnpm:**

```bash
# Disk usage comparison (1000 packages)
npm/yarn: ~1.5 GB (node_modules)
pnpm:     ~500 MB (3x smaller via hard links)

# Install speed
npm:  45s
yarn: 35s
pnpm: 15s (3x faster)

# Strictness
npm:  Loose (phantom dependencies)
yarn: Medium
pnpm: Strict (no phantom deps, enforces correctness)
```

**Phantom Dependency Problem:**
```json
// package.json
{
  "dependencies": {
    "next": "14.2.3" // Depends on react
  }
}

// npm/yarn: This works (bad!)
import React from 'react'; // Not in package.json, but works

// pnpm: This fails (good!)
// Error: Cannot find module 'react'
// Solution: Add to package.json explicitly
```

**Configuration:**
```yaml
# .npmrc
shamefully-hoist=false  # Prevent phantom deps
strict-peer-dependencies=true
auto-install-peers=false
```

---

## Upgrade Path

### Major Version Upgrades

**Next.js 14 → 15 (Future):**
1. Read migration guide
2. Create feature branch
3. Run codemod: `npx @next/codemod@latest upgrade`
4. Test all features
5. Update docs
6. Merge after QA approval

**React 18 → 19 (Future):**
1. Wait for Next.js official support
2. Review breaking changes
3. Update dependencies in lockstep
4. Full regression testing

---

### Dependency Audit Process

**Monthly Audit Checklist:**
- [ ] Run `pnpm audit` (security vulnerabilities)
- [ ] Run `pnpm outdated` (available updates)
- [ ] Review major version updates (breaking changes?)
- [ ] Test updates in development environment
- [ ] Update docs if API changes
- [ ] Deploy to staging for QA
- [ ] Merge to production

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-10-28 | 1.0 | Initial technology stack | Winston (Architect) |

---

**Previous:** [← 1. Introduction & Overview](./1-introduction-overview.md)
**Next:** [3. Data Architecture →](./3-data-architecture.md)
