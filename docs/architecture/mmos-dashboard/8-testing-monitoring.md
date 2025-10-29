# 8. Testing & Monitoring

**Document:** MMOS Admin Dashboard - Testing & Monitoring
**Version:** 1.0
**Last Updated:** 2025-10-28

---

## Testing Strategy

### Testing Pyramid

```
           E2E Tests (10%)
          Playwright
         /             \
    Integration (30%)
   Vitest + Supabase
      /              \
 Unit Tests (60%)
Vitest + RTL
```

---

## Unit Tests (Vitest)

**Coverage Target:** 80% for business logic

```typescript
// tests/services/minds.test.ts
import { describe, it, expect, vi } from 'vitest';
import { MindsService } from '@/lib/services/minds.service';

describe('MindsService', () => {
  it('calculates quality score correctly', async () => {
    const service = new MindsService(mockSupabase);
    const score = await service.calculateQualityScore('mind-123');
    expect(score).toBeGreaterThan(0);
  });

  it('creates mind with profile transaction', async () => {
    const service = new MindsService(mockSupabase);
    const mind = await service.createMind({ name: 'Test', slug: 'test' });
    expect(mind).toHaveProperty('id');
    expect(mockSupabase.from).toHaveBeenCalledWith('mind_profiles');
  });
});
```

---

## Integration Tests

**Coverage:** All API routes

```typescript
// tests/api/export-mind.test.ts
import { POST } from '@/app/api/export/mind/route';
import { createMocks } from 'node-mocks-http';

describe('POST /api/export/mind', () => {
  it('exports mind as ZIP', async () => {
    const { req } = createMocks({
      method: 'POST',
      body: { mindId: 'test-id' },
    });

    const response = await POST(req);
    const data = await response.arrayBuffer();

    expect(response.status).toBe(200);
    expect(response.headers.get('content-type')).toBe('application/zip');
    expect(data.byteLength).toBeGreaterThan(0);
  });

  it('returns 401 for unauthenticated users', async () => {
    // Test auth failure
  });
});
```

---

## E2E Tests (Playwright)

**Coverage:** Critical user flows

```typescript
// tests/e2e/minds.spec.ts
import { test, expect } from '@playwright/test';

test('user can create and view a mind', async ({ page }) => {
  // Login
  await page.goto('/login');
  await page.fill('input[type="email"]', 'test@example.com');
  await page.fill('input[type="password"]', 'password');
  await page.click('button:text("Login")');

  // Navigate to minds
  await page.click('text=Minds');
  await expect(page).toHaveURL('/minds');

  // Create new mind
  await page.click('text=New Mind');
  await page.fill('input[name="name"]', 'E2E Test Mind');
  await page.fill('input[name="slug"]', 'e2e-test');
  await page.click('button:text("Create")');

  // Verify creation
  await expect(page.locator('text=E2E Test Mind')).toBeVisible();
});
```

---

## Monitoring & Observability

### Application Monitoring

**Vercel Analytics:**
- Real User Monitoring (RUM)
- Core Web Vitals
- Page performance

**Supabase Dashboard:**
- Database performance
- Query execution times
- Connection pool status

**Sentry (Production):**
- Error tracking
- Release tracking
- Performance monitoring
- User feedback

---

### Key Metrics

**Frontend:**
- Page load time (p50, p95, p99)
- Time to Interactive (TTI)
- JavaScript errors
- API call success rate

**Backend:**
- API response time (p50, p95, p99)
- Database query time
- Error rate
- Active connections

---

### Alerting

**Critical Alerts (PagerDuty/Slack):**
- Error rate >5% (5min window)
- API response time p95 >2s
- Database connections >80% of pool
- Any 500 errors in production

**Warning Alerts (Email):**
- Error rate >1% (15min window)
- Slow queries >100ms
- Storage usage >80%

---

## CI/CD Quality Gates

```yaml
# .github/workflows/ci.yml
- name: Run Tests
  run: |
    pnpm test:unit        # Must pass (80% coverage)
    pnpm test:integration # Must pass
    pnpm test:e2e         # Must pass

- name: Lint & Type Check
  run: |
    pnpm lint             # Must pass (zero errors)
    pnpm typecheck        # Must pass (strict mode)

- name: Build Check
  run: pnpm build         # Must succeed
```

---

**Previous:** [← 7. Security & Performance](./7-security-performance.md)
**Next:** [9. Development Workflow →](./9-development-workflow.md)
