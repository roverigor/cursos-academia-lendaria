# 11. Design System Guide

**Document:** MMOS Admin Dashboard - Design System Standards
**Version:** 1.0
**Last Updated:** 2025-10-28
**Owner:** Design System Senior (Brad)

---

## 📋 Table of Contents

1. [Design System Overview](#design-system-overview)
2. [Design Token Documentation](#design-token-documentation)
3. [Component Quality Standards](#component-quality-standards)
4. [Component Creation Process](#component-creation-process)
5. [Governance Model](#governance-model)
6. [Visual Regression Testing](#visual-regression-testing)
7. [Common Patterns](#common-patterns)
8. [Troubleshooting](#troubleshooting)

---

## Design System Overview

### Philosophy

**ZERO HARDCODED VALUES**
- All colors from tokens
- All spacing from scale
- All typography from system

**COMPONENT REUSABILITY**
- Build once, use everywhere
- Composition over duplication
- Props for variants, not new components

**ACCESSIBILITY BY DEFAULT**
- WCAG AA minimum
- Keyboard navigation built-in
- Screen reader support tested

---

### Architecture

```
Design System Stack:
├── Tokens (Source of Truth)
│   ├── Primitive tokens (--blue-500, --spacing-4)
│   ├── Semantic tokens (--primary, --spacing-md)
│   └── Component tokens (--button-bg, --input-border)
│
├── Base Components (shadcn/ui)
│   ├── 30+ components (button, card, dialog, etc.)
│   ├── Built on Radix UI (accessible)
│   └── Copy-paste ownership (customizable)
│
├── Custom Components
│   ├── Built from base components
│   ├── Mind-specific (MindCard, FragmentViewer)
│   └── Domain-specific (DataTable, MetricCard)
│
└── Patterns & Layouts
    ├── Page templates
    ├── Common flows (loading, empty, error)
    └── Responsive grids
```

---

## Design Token Documentation

### Token Hierarchy

**3-Level System:**
1. **Primitive Tokens** - Raw values (--blue-500, --spacing-4)
2. **Semantic Tokens** - Purpose-based (--primary, --spacing-md)
3. **Component Tokens** - Component-specific (--button-bg, --card-padding)

**Usage Rule:** Always use semantic > primitive, component > semantic

---

### Color Tokens

#### Primitive Colors (DO NOT USE DIRECTLY)

```css
/* Base colors (HSL values) */
:root {
  --blue-500: 221.2 83.2% 53.3%;
  --gray-100: 210 40% 96.1%;
  --gray-500: 220 8.9% 46.1%;
  --gray-900: 222.2 84% 4.9%;
  --red-500: 0 84.2% 60.2%;
  --green-500: 142.1 76.2% 36.3%;
  --yellow-500: 47.9 95.8% 53.1%;
}

/* DO NOT USE: bg-blue-500 ❌ */
```

#### Semantic Colors (USE THESE)

```css
:root {
  /* Layout */
  --background: 0 0% 100%;           /* Page background */
  --foreground: 222.2 84% 4.9%;      /* Text color */

  /* Brand */
  --primary: 221.2 83.2% 53.3%;      /* Primary actions */
  --primary-foreground: 210 40% 98%; /* Text on primary */

  --secondary: 210 40% 96.1%;        /* Secondary actions */
  --secondary-foreground: 222.2 47.4% 11.2%;

  /* UI Elements */
  --muted: 210 40% 96.1%;            /* Subtle backgrounds */
  --muted-foreground: 215.4 16.3% 46.9%;

  --accent: 210 40% 96.1%;           /* Hover states */
  --accent-foreground: 222.2 47.4% 11.2%;

  /* Borders & Inputs */
  --border: 214.3 31.8% 91.4%;       /* Default borders */
  --input: 214.3 31.8% 91.4%;        /* Input borders */
  --ring: 221.2 83.2% 53.3%;         /* Focus rings */

  /* Status Colors */
  --success: 142.1 76.2% 36.3%;      /* Success states */
  --success-foreground: 355.7 100% 97.3%;

  --warning: 47.9 95.8% 53.1%;       /* Warning states */
  --warning-foreground: 26 83.3% 14.1%;

  --error: 0 84.2% 60.2%;            /* Error states */
  --error-foreground: 210 40% 98%;

  --info: 199.5 89.1% 48.4%;         /* Info states */
  --info-foreground: 210 40% 98%;
}

/* Dark mode */
.dark {
  --background: 222.2 84% 4.9%;
  --foreground: 210 40% 98%;
  /* ... all tokens redefined for dark mode */
}
```

**Usage:**
```tsx
// ✅ Correct (semantic tokens)
<div className="bg-background text-foreground">
  <Button className="bg-primary text-primary-foreground">Click</Button>
  <Alert className="bg-error text-error-foreground">Error!</Alert>
</div>

// ❌ Wrong (primitive tokens)
<div className="bg-gray-100 text-gray-900">
  <Button className="bg-blue-500 text-white">Click</Button>
</div>
```

---

#### Component Color Tokens (FUTURE)

```css
/* When component-specific tokens needed */
:root {
  --button-bg: var(--primary);
  --button-hover: var(--primary-hover);
  --card-bg: var(--background);
  --card-border: var(--border);
  --input-bg: var(--background);
  --input-border: var(--input);
}
```

---

### Spacing Tokens

#### Primitive Spacing (CAN USE - 4px grid)

```typescript
// tailwind.config.ts
spacing: {
  0: '0',
  1: '0.25rem',  // 4px
  2: '0.5rem',   // 8px
  3: '0.75rem',  // 12px
  4: '1rem',     // 16px
  5: '1.25rem',  // 20px
  6: '1.5rem',   // 24px
  8: '2rem',     // 32px
  10: '2.5rem',  // 40px
  12: '3rem',    // 48px
  16: '4rem',    // 64px
  20: '5rem',    // 80px
  24: '6rem',    // 96px
}
```

**Usage:**
```tsx
// ✅ Correct (scale values)
<div className="p-4 gap-6 mb-8">
  <Card className="p-6" />
</div>

// ❌ Wrong (arbitrary values)
<div className="p-[17px] gap-[23px]">
  <Card className="p-[25px]" />
</div>
```

#### Semantic Spacing (RECOMMENDED)

**Add to tailwind.config.ts:**
```typescript
spacing: {
  // Semantic spacing
  'spacing-xs': '0.5rem',   // 8px  - Tight spacing (icons, badges)
  'spacing-sm': '1rem',      // 16px - Default spacing (buttons, inputs)
  'spacing-md': '1.5rem',    // 24px - Section spacing (cards, groups)
  'spacing-lg': '2rem',      // 32px - Layout spacing (between sections)
  'spacing-xl': '3rem',      // 48px - Page spacing (major sections)
  'spacing-2xl': '4rem',     // 64px - Hero spacing (landing pages)
}
```

**Usage:**
```tsx
// ✅ Best (semantic spacing)
<div className="p-spacing-md gap-spacing-sm">
  <Card className="p-spacing-lg mb-spacing-xl" />
</div>
```

---

### Typography Tokens

#### Type Scale (CAN USE)

```typescript
fontSize: {
  xs: ['0.75rem', { lineHeight: '1rem' }],     // 12px
  sm: ['0.875rem', { lineHeight: '1.25rem' }], // 14px
  base: ['1rem', { lineHeight: '1.5rem' }],    // 16px
  lg: ['1.125rem', { lineHeight: '1.75rem' }], // 18px
  xl: ['1.25rem', { lineHeight: '1.75rem' }],  // 20px
  '2xl': ['1.5rem', { lineHeight: '2rem' }],   // 24px
  '3xl': ['1.875rem', { lineHeight: '2.25rem' }], // 30px
  '4xl': ['2.25rem', { lineHeight: '2.5rem' }],   // 36px
}
```

#### Semantic Typography (RECOMMENDED)

**Add to tailwind.config.ts:**
```typescript
fontSize: {
  // Semantic typography
  'text-display': ['2.25rem', { lineHeight: '2.5rem', fontWeight: '700' }], // h1
  'text-title': ['1.875rem', { lineHeight: '2.25rem', fontWeight: '600' }], // h2
  'text-heading': ['1.5rem', { lineHeight: '2rem', fontWeight: '600' }],    // h3
  'text-subheading': ['1.25rem', { lineHeight: '1.75rem', fontWeight: '500' }], // h4
  'text-body': ['1rem', { lineHeight: '1.5rem', fontWeight: '400' }],       // body
  'text-label': ['0.875rem', { lineHeight: '1.25rem', fontWeight: '500' }], // labels
  'text-caption': ['0.75rem', { lineHeight: '1rem', fontWeight: '400' }],   // helper text
}
```

**Usage Guide:**
```tsx
// ✅ Correct (semantic typography)
<h1 className="text-display">Page Title</h1>
<h2 className="text-title">Section Title</h2>
<h3 className="text-heading">Card Title</h3>
<p className="text-body">Body text content</p>
<label className="text-label">Form Label</label>
<span className="text-caption">Helper text</span>

// ⚠️ OK (using scale)
<h1 className="text-4xl font-bold">Title</h1>
<p className="text-base">Body</p>

// ❌ Wrong (arbitrary values)
<h1 className="text-[32px] leading-[40px]">Title</h1>
```

---

### Responsive Breakpoints

```typescript
screens: {
  sm: '640px',   // Mobile landscape
  md: '768px',   // Tablet portrait
  lg: '1024px',  // Desktop
  xl: '1280px',  // Large desktop
  '2xl': '1536px', // Ultra-wide
}
```

**Usage:**
```tsx
<div className="
  grid
  grid-cols-1       /* Mobile: 1 column */
  md:grid-cols-2    /* Tablet: 2 columns */
  lg:grid-cols-3    /* Desktop: 3 columns */
  gap-spacing-md
">
  {minds.map(mind => <MindCard key={mind.id} mind={mind} />)}
</div>
```

---

## Component Quality Standards

### Mandatory Checklist (EVERY Component)

**Before creating PR, verify:**

#### 1. Zero Hardcoded Values ✅
```tsx
// ❌ FAILS - Hardcoded colors/spacing
export function BadButton() {
  return (
    <button className="bg-blue-500 text-white px-[16px] py-[8px] rounded-[6px]">
      Click me
    </button>
  );
}

// ✅ PASSES - Token-based
export function GoodButton() {
  return (
    <button className="bg-primary text-primary-foreground px-spacing-sm py-spacing-xs rounded-md">
      Click me
    </button>
  );
}
```

#### 2. Responsive Design ✅
```tsx
// ❌ FAILS - Fixed width
<div className="w-[800px]">Content</div>

// ✅ PASSES - Responsive
<div className="w-full lg:w-3/4 xl:w-2/3">Content</div>
```

#### 3. Dark Mode Support ✅
```tsx
// ✅ Automatic (using semantic tokens)
<div className="bg-background text-foreground">
  {/* Switches automatically with theme */}
</div>

// Test both modes:
// - Open Storybook
// - Toggle theme switcher
// - Verify all states (default, hover, active, disabled)
```

#### 4. Accessibility (WCAG AA) ✅

**Color Contrast:**
```bash
# Run in CI
pnpm add -D @axe-core/cli
axe http://localhost:6006 --wcag=aa --tags wcag2aa
```

**Keyboard Navigation:**
```tsx
// ✅ All interactive elements keyboard accessible
<button>Click</button>  // Tab + Enter works
<a href="...">Link</a>  // Tab + Enter works

// Custom interactive elements:
<div
  role="button"
  tabIndex={0}
  onKeyDown={(e) => e.key === 'Enter' && onClick()}
  onClick={onClick}
>
  Custom Button
</div>
```

**ARIA Labels:**
```tsx
// ✅ Provide context for screen readers
<button aria-label="Close dialog">
  <X className="h-4 w-4" />
</button>

<input
  type="text"
  aria-label="Search minds"
  placeholder="Search..."
/>
```

#### 5. TypeScript Strict Mode ✅
```tsx
// ❌ FAILS
export function BadComponent({ data }: any) { // 'any' forbidden
  return <div>{data.name}</div>;
}

// ✅ PASSES
interface MindCardProps {
  mind: Mind;
  onClick?: (mind: Mind) => void;
}

export function MindCard({ mind, onClick }: MindCardProps) {
  return <div onClick={() => onClick?.(mind)}>{mind.name}</div>;
}
```

#### 6. Component Documentation ✅
```tsx
/**
 * MindCard - Displays a mind preview with status and fidelity score
 *
 * @example
 * ```tsx
 * <MindCard
 *   mind={mind}
 *   onClick={(m) => router.push(`/minds/${m.slug}`)}
 * />
 * ```
 */
export function MindCard({ mind, onClick }: MindCardProps) {
  // ...
}
```

#### 7. Test Coverage (Complex Components) ✅
```tsx
// tests/components/mind-card.test.tsx
import { render, screen } from '@testing-library/react';
import { MindCard } from '@/components/minds/mind-card';

describe('MindCard', () => {
  it('renders mind name', () => {
    render(<MindCard mind={mockMind} />);
    expect(screen.getByText('Steve Jobs')).toBeInTheDocument();
  });

  it('shows fidelity score', () => {
    render(<MindCard mind={mockMind} />);
    expect(screen.getByText('98%')).toBeInTheDocument();
  });

  it('calls onClick when clicked', () => {
    const onClick = jest.fn();
    render(<MindCard mind={mockMind} onClick={onClick} />);
    screen.getByRole('button').click();
    expect(onClick).toHaveBeenCalledWith(mockMind);
  });
});
```

**Coverage Target:** >80% for components with business logic

---

### Component Size Limits

```typescript
// Component bundle size limits (gzip)
const BUNDLE_LIMITS = {
  'ui/button': '2KB',        // Base components: tiny
  'ui/dialog': '5KB',        // Complex components: small
  'minds/mind-card': '3KB',  // Feature components: small
  'charts/analytics': '15KB', // Chart components: medium (vendor deps)
};

// Enforce in package.json
{
  "size-limit": [
    { "path": "components/ui/button.tsx", "limit": "2KB" },
    { "path": "components/charts/*.tsx", "limit": "15KB" }
  ]
}
```

---

## Component Creation Process

### 1. Proposal Phase

**Before writing code:**

1. Check if component already exists (search codebase)
2. Check if shadcn/ui provides it (`npx shadcn-ui@latest add <name>`)
3. If new component needed, post in `#design-system` Slack:

```
📋 Component Proposal: MindStatusBadge

**Purpose:** Display mind status with color-coded badge
**Variants:** active, draft, paused, archived
**Props:**
- status: MindStatus
- size: 'sm' | 'md' | 'lg'

**Similar to:** Badge component, but with status-specific colors

**Approval needed:** @design-system-senior
```

---

### 2. Design Phase

**Create spec:**

```markdown
## MindStatusBadge Spec

### Variants
- `active`: Green background, "Active" text
- `draft`: Gray background, "Draft" text
- `paused`: Yellow background, "Paused" text
- `archived`: Red background, "Archived" text

### Sizes
- `sm`: 12px text, 4px padding
- `md`: 14px text, 6px padding
- `lg`: 16px text, 8px padding

### States
- Default
- Hover (10% darker)
- Disabled (50% opacity)

### Accessibility
- Color + icon (not color alone)
- aria-label with full status text

### Design Tokens Used
- Colors: status colors (--success, --warning, --error, --muted)
- Spacing: spacing-xs, spacing-sm
- Typography: text-xs, text-sm, text-base
```

---

### 3. Implementation Phase

**File Structure:**
```
components/minds/mind-status-badge.tsx    # Component
components/minds/mind-status-badge.test.tsx  # Tests
components/minds/mind-status-badge.stories.tsx  # Storybook
```

**Component Template:**
```tsx
// components/minds/mind-status-badge.tsx
import { cva, type VariantProps } from 'class-variance-authority';
import { cn } from '@/lib/utils';
import type { MindStatus } from '@/types/supabase';

const badgeVariants = cva(
  // Base styles (always applied)
  'inline-flex items-center rounded-full font-medium transition-colors',
  {
    // Variants
    variants: {
      status: {
        active: 'bg-success text-success-foreground',
        draft: 'bg-muted text-muted-foreground',
        paused: 'bg-warning text-warning-foreground',
        archived: 'bg-error text-error-foreground',
      },
      size: {
        sm: 'text-xs px-spacing-xs py-1',
        md: 'text-sm px-spacing-sm py-1.5',
        lg: 'text-base px-spacing-md py-2',
      },
    },
    // Default variants
    defaultVariants: {
      size: 'md',
    },
  }
);

export interface MindStatusBadgeProps extends VariantProps<typeof badgeVariants> {
  status: MindStatus;
  className?: string;
}

/**
 * MindStatusBadge - Displays mind status with color-coded badge
 *
 * @example
 * ```tsx
 * <MindStatusBadge status="active" size="sm" />
 * ```
 */
export function MindStatusBadge({ status, size, className }: MindStatusBadgeProps) {
  const labels = {
    active: 'Active',
    draft: 'Draft',
    paused: 'Paused',
    archived: 'Archived',
  };

  return (
    <span
      className={cn(badgeVariants({ status, size }), className)}
      aria-label={`Mind status: ${labels[status]}`}
    >
      {labels[status]}
    </span>
  );
}
```

**Tests:**
```tsx
// components/minds/mind-status-badge.test.tsx
import { render, screen } from '@testing-library/react';
import { MindStatusBadge } from './mind-status-badge';

describe('MindStatusBadge', () => {
  it('renders active status', () => {
    render(<MindStatusBadge status="active" />);
    expect(screen.getByText('Active')).toBeInTheDocument();
    expect(screen.getByLabelText('Mind status: Active')).toBeInTheDocument();
  });

  it('applies size variant', () => {
    const { container } = render(<MindStatusBadge status="draft" size="sm" />);
    expect(container.firstChild).toHaveClass('text-xs');
  });

  it('applies custom className', () => {
    const { container } = render(<MindStatusBadge status="active" className="custom-class" />);
    expect(container.firstChild).toHaveClass('custom-class');
  });
});
```

**Storybook:**
```tsx
// components/minds/mind-status-badge.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import { MindStatusBadge } from './mind-status-badge';

const meta: Meta<typeof MindStatusBadge> = {
  title: 'Components/Minds/MindStatusBadge',
  component: MindStatusBadge,
  tags: ['autodocs'],
};

export default meta;
type Story = StoryObj<typeof MindStatusBadge>;

export const Active: Story = {
  args: { status: 'active' },
};

export const Draft: Story = {
  args: { status: 'draft' },
};

export const AllSizes: Story = {
  render: () => (
    <div className="flex gap-4">
      <MindStatusBadge status="active" size="sm" />
      <MindStatusBadge status="active" size="md" />
      <MindStatusBadge status="active" size="lg" />
    </div>
  ),
};

export const AllStatuses: Story = {
  render: () => (
    <div className="flex gap-4">
      <MindStatusBadge status="active" />
      <MindStatusBadge status="draft" />
      <MindStatusBadge status="paused" />
      <MindStatusBadge status="archived" />
    </div>
  ),
};
```

---

### 4. Review Phase

**PR Checklist:**
- [ ] Zero hardcoded values (colors, spacing, typography)
- [ ] Responsive (tested on mobile, tablet, desktop)
- [ ] Dark mode support (tested both themes)
- [ ] Accessibility (keyboard nav, ARIA, color contrast)
- [ ] TypeScript strict (no `any`, all props typed)
- [ ] Tests (>80% coverage for complex components)
- [ ] Storybook story exists
- [ ] Documentation (JSDoc comment with example)

**Reviewers:**
- 1 developer (code quality)
- 1 design system senior (standards compliance)

---

### 5. Documentation Phase

**Update component registry:**
```markdown
# components/README.md

## Minds Components

### MindStatusBadge
**File:** `components/minds/mind-status-badge.tsx`
**Purpose:** Display mind status with color-coded badge
**Variants:** active, draft, paused, archived
**Sizes:** sm, md, lg
**Added:** 2025-10-28
**Owner:** @john-doe
```

---

## Governance Model

### Roles & Responsibilities

**Design System Senior (Owner)**
- Final approval on all components
- Maintain token system
- Define standards and quality gates
- Review breaking changes
- Publish component updates

**Frontend Developers (Contributors)**
- Propose new components
- Implement components following standards
- Write tests and documentation
- Submit PRs for review

**UX Senior (Consultant)**
- Validate interaction patterns
- Review accessibility compliance
- Approve user-facing changes

---

### Decision-Making Process

**Component Addition:**
1. Proposal → `#design-system` Slack channel
2. Discussion → Design System Senior + team (async)
3. Approval → Design System Senior signs off
4. Implementation → Developer creates PR
5. Review → 2 approvals (1 must be Design System Senior)
6. Merge → Component available

**Breaking Changes:**
1. Proposal with migration guide
2. Team discussion (sync meeting if major)
3. Approval from Design System Senior + Tech Lead
4. Announce 1 week before merge
5. Add deprecation warnings in code
6. Document in CHANGELOG
7. Version bump (major)

**Token Changes:**
1. Proposal with use cases
2. Visual examples (before/after)
3. Impact analysis (how many components affected)
4. Approval from Design System Senior + UX Senior
5. Update all affected components
6. Merge as atomic change

---

### Communication Channels

**Slack:**
- `#design-system` - Proposals, discussions, announcements
- `#frontend` - General frontend questions

**GitHub:**
- Issues: Bug reports, feature requests
- PRs: Component implementations
- Discussions: RFC for major changes

**Meetings:**
- Weekly: Design system sync (30 min)
- Monthly: Component review (1 hour)
- Quarterly: Design system roadmap (2 hours)

---

## Visual Regression Testing

### Setup (Storybook + Chromatic)

**1. Install Storybook:**
```bash
pnpm dlx storybook@latest init
```

**2. Install Chromatic:**
```bash
pnpm add -D chromatic
```

**3. Configure Chromatic:**
```bash
# Get token from https://www.chromatic.com/
npx chromatic --project-token=<token>
```

**4. Add to CI:**
```yaml
# .github/workflows/visual-regression.yml
name: Visual Regression

on: [push]

jobs:
  chromatic:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Required for Chromatic

      - uses: pnpm/action-setup@v2

      - name: Install dependencies
        run: pnpm install

      - name: Run Chromatic
        uses: chromaui/action@v1
        with:
          projectToken: ${{ secrets.CHROMATIC_PROJECT_TOKEN }}
          buildScriptName: 'build-storybook'
```

---

### Story Structure

**Every component needs:**

1. **Default story** - Standard use case
2. **Variant stories** - All prop combinations
3. **State stories** - Hover, focus, disabled, error
4. **Dark mode story** - Verify theme switching
5. **Responsive story** - Mobile, tablet, desktop

**Example:**
```tsx
// All states
export const States: Story = {
  render: () => (
    <div className="space-y-4">
      <Button>Default</Button>
      <Button disabled>Disabled</Button>
      <Button className="hover:bg-primary-hover">Hover</Button>
      <Button className="focus:ring-2">Focused</Button>
    </div>
  ),
};

// Dark mode
export const DarkMode: Story = {
  parameters: {
    themes: {
      themeOverride: 'dark',
    },
  },
  render: () => <Button>Dark Mode Button</Button>,
};
```

---

### Visual Review Process

**When PR created:**
1. Chromatic runs automatically
2. Detects visual changes
3. Posts comment in PR with screenshots
4. Reviewer approves/rejects changes in Chromatic dashboard
5. Once approved, PR can merge

**Types of changes:**
- ✅ Intentional (new feature, bug fix) → Approve
- ❌ Regression (accidental change) → Reject, fix component
- ⚠️ Browser-specific (rendering difference) → Investigate

---

## Common Patterns

### Loading States

```tsx
// Skeleton loader (use shadcn Skeleton component)
import { Skeleton } from '@/components/ui/skeleton';

function MindsPageSkeleton() {
  return (
    <div className="space-y-spacing-md">
      <Skeleton className="h-12 w-full" />
      <Skeleton className="h-64 w-full" />
      <Skeleton className="h-64 w-full" />
    </div>
  );
}

// Usage
function MindsPage() {
  const { data, isLoading } = useMinds();

  if (isLoading) return <MindsPageSkeleton />;
  return <MindsTable data={data} />;
}
```

---

### Empty States

```tsx
import { EmptyState } from '@/components/ui/empty-state';

{minds.length === 0 && (
  <EmptyState
    title="No minds yet"
    description="Get started by creating your first mind."
    action={
      <Button onClick={openCreateDialog}>
        <Plus className="h-4 w-4 mr-2" />
        Create Mind
      </Button>
    }
  />
)}
```

---

### Error States

```tsx
import { Alert, AlertTitle, AlertDescription } from '@/components/ui/alert';
import { AlertCircle } from 'lucide-react';

{error && (
  <Alert variant="destructive">
    <AlertCircle className="h-4 w-4" />
    <AlertTitle>Error</AlertTitle>
    <AlertDescription>
      {error.message}
      <Button variant="outline" size="sm" onClick={retry} className="mt-2">
        Try Again
      </Button>
    </AlertDescription>
  </Alert>
)}
```

---

### Form Patterns

```tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';

const formSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  slug: z.string().regex(/^[a-z0-9-]+$/, 'Invalid slug format'),
});

function MindForm() {
  const form = useForm({
    resolver: zodResolver(formSchema),
    defaultValues: { name: '', slug: '' },
  });

  async function onSubmit(data: z.infer<typeof formSchema>) {
    await createMind(data);
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-spacing-md">
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input placeholder="Steve Jobs" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">Create Mind</Button>
      </form>
    </Form>
  );
}
```

---

## Troubleshooting

### Issue: Component styles not applying

**Symptom:** Tailwind classes not rendering

**Causes:**
1. Class not in Tailwind config
2. Dynamic class names (not detected by JIT)
3. CSS purge removing classes

**Solutions:**
```tsx
// ❌ Dynamic classes (won't work)
<div className={`bg-${color}-500`}>  // Purged by Tailwind

// ✅ Static classes (works)
<div className={color === 'blue' ? 'bg-blue-500' : 'bg-red-500'}>

// ✅ Use safelist for dynamic (tailwind.config.ts)
safelist: [
  'bg-blue-500',
  'bg-red-500',
  'bg-green-500',
]
```

---

### Issue: Dark mode not switching

**Symptom:** Component stays light mode when theme toggled

**Cause:** Using primitive colors instead of semantic tokens

**Solution:**
```tsx
// ❌ Hardcoded (won't switch)
<div className="bg-white text-black">

// ✅ Semantic tokens (switches automatically)
<div className="bg-background text-foreground">
```

---

### Issue: Component not keyboard accessible

**Symptom:** Tab key doesn't focus element, Enter doesn't activate

**Cause:** Missing `tabIndex` or `onKeyDown` for custom interactive elements

**Solution:**
```tsx
// ❌ Div button (not keyboard accessible)
<div onClick={onClick}>Click me</div>

// ✅ Proper button
<button onClick={onClick}>Click me</button>

// ✅ Custom interactive element
<div
  role="button"
  tabIndex={0}
  onKeyDown={(e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      onClick();
    }
  }}
  onClick={onClick}
>
  Click me
</div>
```

---

### Issue: Color contrast failing WCAG AA

**Symptom:** Axe reports contrast ratio < 4.5:1

**Cause:** Foreground/background color combination too similar

**Solution:**
1. Check contrast: https://webaim.org/resources/contrastchecker/
2. Adjust token values in `globals.css`
3. Ensure contrast ratio ≥ 4.5:1 (normal text) or ≥ 3:1 (large text)

```css
/* ❌ Fails (3.2:1) */
--foreground: 210 40% 60%;
--background: 210 40% 90%;

/* ✅ Passes (4.6:1) */
--foreground: 222.2 84% 4.9%;
--background: 0 0% 100%;
```

---

### Issue: Bundle size too large

**Symptom:** Component exceeds size limit in CI

**Causes:**
1. Importing entire library (lodash, date-fns)
2. Including unused code
3. Not tree-shaking

**Solutions:**
```typescript
// ❌ Imports entire library (100KB)
import _ from 'lodash';
_.debounce(fn, 300);

// ✅ Import specific function (5KB)
import debounce from 'lodash/debounce';
debounce(fn, 300);

// ❌ Imports all icons (500KB)
import * as Icons from 'lucide-react';
<Icons.User />

// ✅ Import specific icon (2KB)
import { User } from 'lucide-react';
<User />
```

---

## Resources

**Documentation:**
- Tailwind CSS: https://tailwindcss.com/docs
- shadcn/ui: https://ui.shadcn.com
- Radix UI: https://www.radix-ui.com
- WCAG Guidelines: https://www.w3.org/WAI/WCAG21/quickref/

**Tools:**
- Color Contrast Checker: https://webaim.org/resources/contrastchecker/
- Axe DevTools: https://www.deque.com/axe/devtools/
- Storybook: https://storybook.js.org
- Chromatic: https://www.chromatic.com

**Community:**
- shadcn Discord: https://discord.gg/shadcn
- Tailwind Discord: https://discord.gg/tailwindcss

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-10-28 | 1.0 | Initial design system guide | Brad (Design System Senior) |

---

**Previous:** [← 10. Stakeholder Review Guide](./10-stakeholder-review-guide.md)
**Back to Index:** [📋 README](./README.md)
