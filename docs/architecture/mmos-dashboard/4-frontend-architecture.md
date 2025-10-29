# 4. Frontend Architecture

**Document:** MMOS Admin Dashboard - Frontend Architecture
**Version:** 1.0
**Last Updated:** 2025-10-28
**Primary Reviewers:** 🎨 UX Senior + 🎭 Design System Senior

---

## 📋 Table of Contents

1. [Application Structure](#application-structure)
2. [Page Architecture](#page-architecture)
3. [Component Organization](#component-organization)
4. [Design System Integration](#design-system-integration)
5. [State Management Strategy](#state-management-strategy)
6. [Routing & Navigation](#routing--navigation)
7. [User Experience Patterns](#user-experience-patterns)
8. [Accessibility](#accessibility)
9. [Performance Optimization](#performance-optimization)
10. [Review Checklists](#review-checklists)

---

## Application Structure

### Next.js 14 App Router Layout

```
apps/dashboard/
├── app/
│   ├── (auth)/                    # Auth group (no dashboard layout)
│   │   ├── login/
│   │   │   └── page.tsx           # Login page
│   │   └── signup/
│   │       └── page.tsx           # Signup page
│   │
│   ├── (dashboard)/               # Dashboard group (shared layout)
│   │   ├── layout.tsx             # Dashboard shell (sidebar + header)
│   │   ├── page.tsx               # Overview page (/)
│   │   │
│   │   ├── minds/                 # Minds management
│   │   │   ├── page.tsx           # Minds list
│   │   │   ├── [slug]/
│   │   │   │   ├── page.tsx       # Mind detail
│   │   │   │   ├── profile/       # Mind profile tab
│   │   │   │   ├── knowledge/     # Knowledge base tab
│   │   │   │   ├── prompts/       # System prompts tab
│   │   │   │   └── analytics/     # Mind analytics tab
│   │   │   └── new/
│   │   │       └── page.tsx       # Create new mind
│   │   │
│   │   ├── pipeline/              # Pipeline monitoring
│   │   │   ├── page.tsx           # Active jobs list
│   │   │   ├── [id]/
│   │   │   │   └── page.tsx       # Job detail (realtime)
│   │   │   └── history/
│   │   │       └── page.tsx       # Execution history
│   │   │
│   │   ├── content/               # CreatorOS content
│   │   │   ├── projects/
│   │   │   │   ├── page.tsx       # Projects list
│   │   │   │   └── [id]/
│   │   │   │       └── page.tsx   # Project detail
│   │   │   └── courses/
│   │   │       └── page.tsx       # Generated courses
│   │   │
│   │   ├── analytics/             # Analytics dashboards
│   │   │   ├── page.tsx           # Overview dashboard
│   │   │   ├── quality/           # Quality metrics
│   │   │   └── usage/             # Usage statistics
│   │   │
│   │   └── settings/              # Settings & admin
│   │       ├── page.tsx           # General settings
│   │       ├── users/             # User management
│   │       ├── taxonomy/          # Categories, tags, traits
│   │       └── system/            # System configuration
│   │
│   ├── api/                       # API routes
│   │   ├── webhooks/
│   │   │   └── pipeline/
│   │   │       └── route.ts       # Pipeline webhook
│   │   └── export/
│   │       └── mind/
│   │           └── route.ts       # Export mind data
│   │
│   ├── globals.css                # Global styles + Tailwind
│   └── layout.tsx                 # Root layout (providers)
│
├── components/
│   ├── ui/                        # shadcn/ui components
│   │   ├── button.tsx
│   │   ├── card.tsx
│   │   ├── data-table.tsx
│   │   ├── dialog.tsx
│   │   └── ... (30+ components)
│   │
│   ├── layout/                    # Layout components
│   │   ├── dashboard-shell.tsx    # Main layout wrapper
│   │   ├── sidebar.tsx            # Navigation sidebar
│   │   ├── header.tsx             # Top header bar
│   │   └── breadcrumbs.tsx        # Breadcrumb navigation
│   │
│   ├── minds/                     # Mind-specific components
│   │   ├── mind-card.tsx          # Mind preview card
│   │   ├── mind-list.tsx          # Minds data table
│   │   ├── mind-header.tsx        # Mind detail header
│   │   ├── profile-editor.tsx     # Profile form
│   │   └── fragment-viewer.tsx    # Knowledge fragments
│   │
│   ├── pipeline/                  # Pipeline components
│   │   ├── job-status.tsx         # Status badge
│   │   ├── job-progress.tsx       # Progress bar (realtime)
│   │   ├── phase-stepper.tsx      # Pipeline phase indicator
│   │   └── logs-viewer.tsx        # Execution logs
│   │
│   ├── charts/                    # Data visualization
│   │   ├── fidelity-chart.tsx     # Fidelity score trends
│   │   ├── trait-radar.tsx        # Trait distribution (radar)
│   │   └── timeline-chart.tsx     # Execution timeline
│   │
│   └── forms/                     # Reusable form components
│       ├── mind-form.tsx          # Create/edit mind
│       ├── project-form.tsx       # Create/edit project
│       └── user-form.tsx          # Create/edit user
│
├── lib/
│   ├── supabase.ts                # Supabase client factory
│   ├── queries.ts                 # TanStack Query hooks
│   ├── utils.ts                   # Helper functions
│   └── hooks/
│       ├── use-minds.ts           # Minds queries/mutations
│       ├── use-pipeline.ts        # Pipeline queries
│       └── use-realtime.ts        # Realtime subscriptions
│
└── types/
    └── supabase.ts                # Generated DB types
```

---

## Page Architecture

### Dashboard Shell Layout

**File:** `app/(dashboard)/layout.tsx`

```tsx
import { Sidebar } from '@/components/layout/sidebar';
import { Header } from '@/components/layout/header';

export default function DashboardLayout({ children }: Props) {
  return (
    <div className="flex h-screen overflow-hidden">
      {/* Sidebar - Fixed left */}
      <Sidebar className="w-64 border-r" />

      {/* Main content area */}
      <div className="flex flex-1 flex-col overflow-hidden">
        {/* Header - Fixed top */}
        <Header className="border-b" />

        {/* Scrollable content */}
        <main className="flex-1 overflow-y-auto p-6">
          {children}
        </main>
      </div>
    </div>
  );
}
```

**Layout Structure:**
```
┌─────────────────────────────────────────────────────┐
│ Header                                   [@avatar]  │ Fixed
├──────────┬──────────────────────────────────────────┤
│          │                                          │
│ Sidebar  │ Main Content (Scrollable)                │
│          │                                          │
│          │                                          │
│          │                                          │ Fills viewport
│          │                                          │
│          │                                          │
│ [Nav]    │ [Page Content]                           │
│          │                                          │
└──────────┴──────────────────────────────────────────┘
```

---

### Page: Overview Dashboard

**Route:** `/` (dashboard root)
**File:** `app/(dashboard)/page.tsx`

**Layout:**
```
┌─────────────────────────────────────────────────────┐
│ Dashboard Overview                          [Export]│
├─────────────────────────────────────────────────────┤
│                                                     │
│ ┌───────────┐ ┌───────────┐ ┌───────────┐         │
│ │ 22 Minds  │ │ 45 Jobs   │ │ 1.2K KB   │         │ Metric Cards
│ │ Active    │ │ Running   │ │ Fragments │         │
│ └───────────┘ └───────────┘ └───────────┘         │
│                                                     │
│ Pipeline Activity (Last 7 Days)                    │
│ ┌─────────────────────────────────────────────┐   │
│ │ [Line Chart: Jobs over time]                │   │ Chart Section
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Recent Jobs                     [View All →]       │
│ ┌─────────────────────────────────────────────┐   │
│ │ ✅ steve_jobs      Completed    2h ago       │   │
│ │ 🔄 maria_silva     Running      30m          │   │ Data Table
│ │ ⏸️  pedro_valerio   Paused       1d ago       │   │
│ └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

**Key Components:**
- `MetricCard` - Stats with trend indicator
- `ActivityChart` - Recharts line graph
- `RecentJobsTable` - TanStack Table with status badges

---

### Page: Minds List

**Route:** `/minds`
**File:** `app/(dashboard)/minds/page.tsx`

**Layout:**
```
┌─────────────────────────────────────────────────────┐
│ Minds                      [+ New Mind] [Filter ▾]  │
├─────────────────────────────────────────────────────┤
│ Search: [_________________]  Status: [All ▾]       │ Filters
│                                                     │
│ Name          Status    Fidelity  Fragments  Last  │
│ ──────────────────────────────────────────────────  │
│ João Lozano   ✅ Active  98%      523        2h    │ Data Table
│ Maria Silva   🔄 Draft   45%      89         30m   │ (sortable,
│ Steve Jobs    ✅ Active  96%      1203       1d    │  filterable,
│ Pedro Vale... ⏸️  Paused  92%      445        3d    │  paginated)
│                                                     │
│ Showing 1-20 of 156            [< 1 2 3 ... 8 >]  │ Pagination
└─────────────────────────────────────────────────────┘
```

**Key Features:**
- **Search:** Real-time filter across name/slug
- **Filters:** Status, date range, fidelity score
- **Sorting:** Click column headers
- **Bulk Actions:** Select multiple, export, delete
- **Row Actions:** View, Edit, Clone, Delete

---

### Page: Mind Detail

**Route:** `/minds/[slug]`
**File:** `app/(dashboard)/minds/[slug]/page.tsx`

**Layout:**
```
┌─────────────────────────────────────────────────────┐
│ ← Back to Minds                                     │
├─────────────────────────────────────────────────────┤
│ 👤 João Lozano                            [⋮ Menu] │
│ steve_jobs • Active • Fidelity: 98%                │ Header
│                                                     │
│ [Profile] [Knowledge] [Prompts] [Analytics]        │ Tabs
│ ──────────────────────────────────────────────────  │
│                                                     │
│ Profile Tab Content:                               │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Persona Description                         │   │
│ │ ─────────────────────────────────────────   │   │
│ │ [Editable text area]                        │   │ Content Area
│ │                                             │   │
│ │ Core Values                                 │   │
│ │ ─────────────────────────────────────────   │   │
│ │ • Excelência técnica (10/10)               │   │
│ │ • Inovação disruptiva (9/10)               │   │
│ └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

**Tabs:**
- **Profile:** Fidelity score, persona, values, psychometrics
- **Knowledge:** Fragment explorer with search/filter
- **Prompts:** System prompt versions, specialist prompts
- **Analytics:** Trait distribution, quality metrics, usage stats

---

## Component Organization

### Component Hierarchy

```
App
├── RootLayout (providers)
│   ├── ThemeProvider (dark mode)
│   ├── QueryClientProvider (TanStack Query)
│   └── Toaster (notifications)
│
└── DashboardLayout
    ├── Sidebar
    │   ├── Logo
    │   ├── NavLinks
    │   └── UserMenu
    │
    ├── Header
    │   ├── Breadcrumbs
    │   ├── SearchBar
    │   └── UserAvatar
    │
    └── Page Content
        ├── PageHeader
        │   ├── Title
        │   ├── Description
        │   └── Actions
        │
        └── PageBody
            ├── Filters (optional)
            ├── DataTable / Cards / Charts
            └── Pagination (optional)
```

---

### Component Template (shadcn/ui Pattern)

**File:** `components/minds/mind-card.tsx`

```tsx
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import type { Mind } from '@/types/supabase';

interface MindCardProps {
  mind: Mind;
  onView?: (mind: Mind) => void;
  onEdit?: (mind: Mind) => void;
}

export function MindCard({ mind, onView, onEdit }: MindCardProps) {
  return (
    <Card className="hover:shadow-lg transition-shadow">
      <CardHeader>
        <div className="flex items-start justify-between">
          <CardTitle>{mind.name}</CardTitle>
          <Badge variant={mind.status === 'active' ? 'success' : 'secondary'}>
            {mind.status}
          </Badge>
        </div>
        <CardDescription>@{mind.slug}</CardDescription>
      </CardHeader>

      <CardContent>
        <div className="space-y-4">
          {/* Fidelity Score */}
          <div>
            <div className="text-sm text-muted-foreground">Fidelity</div>
            <div className="text-2xl font-bold">{mind.fidelity_score}%</div>
          </div>

          {/* Actions */}
          <div className="flex gap-2">
            <Button variant="outline" onClick={() => onView?.(mind)}>
              View
            </Button>
            <Button variant="ghost" onClick={() => onEdit?.(mind)}>
              Edit
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
```

**Pattern Benefits:**
- Composition via props
- Type-safe with TypeScript
- Accessible by default (Radix UI)
- Tailwind for styling
- Callbacks for interactions

---

## Design System Integration

### shadcn/ui Components Used

**Base Components (30+):**
```
✅ Installed via CLI:
- accordion, alert, avatar, badge, button
- card, checkbox, dialog, dropdown-menu
- form, input, label, popover, progress
- radio-group, select, separator, sheet
- skeleton, switch, table, tabs, textarea
- toast, tooltip
```

**Custom Components Built:**
```
🎨 Built on top of shadcn/ui:
- DataTable (TanStack Table + shadcn table)
- MetricCard (Card + custom metrics)
- StatusBadge (Badge with status colors)
- EmptyState (Custom illustration + text)
- LoadingState (Skeleton + spinner)
```

---

### Design Tokens

**File:** `tailwind.config.ts`

```typescript
export default {
  theme: {
    extend: {
      colors: {
        // Base colors
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",

        // Status colors
        success: "hsl(var(--success))",
        warning: "hsl(var(--warning))",
        error: "hsl(var(--error))",
        info: "hsl(var(--info))",

        // Semantic colors
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        // ... (50+ color tokens)
      },
      fontSize: {
        // Type scale
        xs: ['0.75rem', { lineHeight: '1rem' }],
        sm: ['0.875rem', { lineHeight: '1.25rem' }],
        base: ['1rem', { lineHeight: '1.5rem' }],
        lg: ['1.125rem', { lineHeight: '1.75rem' }],
        xl: ['1.25rem', { lineHeight: '1.75rem' }],
        '2xl': ['1.5rem', { lineHeight: '2rem' }],
        // ... (12 sizes)
      },
      spacing: {
        // Spacing scale (follows 4px grid)
        0: '0',
        1: '0.25rem',  // 4px
        2: '0.5rem',   // 8px
        3: '0.75rem',  // 12px
        4: '1rem',     // 16px
        6: '1.5rem',   // 24px
        8: '2rem',     // 32px
        // ... (consistent 4px grid)
      },
    },
  },
};
```

**CSS Variables (Dark Mode Support):**

```css
/* app/globals.css */
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 221.2 83.2% 53.3%;
    --success: 142.1 76.2% 36.3%;
    /* ... */
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --primary: 217.2 91.2% 59.8%;
    --success: 142.1 70.6% 45.3%;
    /* ... */
  }
}
```

---

### Responsive Breakpoints

```typescript
// Tailwind breakpoints
screens: {
  sm: '640px',   // Mobile landscape
  md: '768px',   // Tablet
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
  gap-4
">
  {minds.map(mind => <MindCard key={mind.id} mind={mind} />)}
</div>
```

---

## State Management Strategy

### Server State (TanStack Query)

**File:** `lib/queries.ts`

```typescript
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';

// Query: Fetch all minds
export function useMinds() {
  return useQuery({
    queryKey: ['minds'],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('minds')
        .select('*, mind_profiles(*)')
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data;
    },
    // Refetch every 30s
    refetchInterval: 30000,
  });
}

// Query: Fetch single mind
export function useMind(slug: string) {
  return useQuery({
    queryKey: ['minds', slug],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('minds')
        .select('*, mind_profiles(*), trait_scores(*)')
        .eq('slug', slug)
        .single();

      if (error) throw error;
      return data;
    },
    enabled: !!slug, // Only run if slug exists
  });
}

// Mutation: Create mind
export function useCreateMind() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (data: MindInsert) => {
      const { data: mind, error } = await supabase
        .from('minds')
        .insert(data)
        .select()
        .single();

      if (error) throw error;
      return mind;
    },
    onSuccess: () => {
      // Invalidate minds list to refetch
      queryClient.invalidateQueries({ queryKey: ['minds'] });
    },
  });
}
```

**Usage in Component:**
```tsx
function MindsPage() {
  const { data: minds, isLoading, error } = useMinds();
  const createMind = useCreateMind();

  if (isLoading) return <LoadingState />;
  if (error) return <ErrorState error={error} />;

  return (
    <div>
      <Button onClick={() => createMind.mutate({ name: 'New Mind', ... })}>
        Create Mind
      </Button>
      <MindsList minds={minds} />
    </div>
  );
}
```

---

### Client State (Zustand)

**File:** `lib/stores/ui.ts`

```typescript
import { create } from 'zustand';

interface UIStore {
  sidebarOpen: boolean;
  toggleSidebar: () => void;

  activeTab: string;
  setActiveTab: (tab: string) => void;

  selectedMinds: string[];
  selectMind: (id: string) => void;
  deselectMind: (id: string) => void;
  clearSelection: () => void;
}

export const useUIStore = create<UIStore>((set) => ({
  // Sidebar state
  sidebarOpen: true,
  toggleSidebar: () => set((state) => ({ sidebarOpen: !state.sidebarOpen })),

  // Tab state
  activeTab: 'profile',
  setActiveTab: (tab) => set({ activeTab: tab }),

  // Selection state
  selectedMinds: [],
  selectMind: (id) => set((state) => ({
    selectedMinds: [...state.selectedMinds, id]
  })),
  deselectMind: (id) => set((state) => ({
    selectedMinds: state.selectedMinds.filter((mid) => mid !== id)
  })),
  clearSelection: () => set({ selectedMinds: [] }),
}));
```

**Usage:**
```tsx
function Sidebar() {
  const { sidebarOpen, toggleSidebar } = useUIStore();

  return (
    <aside className={sidebarOpen ? 'w-64' : 'w-0'}>
      <Button onClick={toggleSidebar}>Toggle</Button>
    </aside>
  );
}
```

---

## Routing & Navigation

### Route Structure

```typescript
// Navigation links (Sidebar)
const navigation = [
  {
    name: 'Overview',
    href: '/',
    icon: HomeIcon,
  },
  {
    name: 'Minds',
    href: '/minds',
    icon: BrainIcon,
    badge: '22', // Dynamic count
  },
  {
    name: 'Pipeline',
    href: '/pipeline',
    icon: ActivityIcon,
  },
  {
    name: 'Content',
    href: '/content',
    icon: FileTextIcon,
    children: [ // Submenu
      { name: 'Projects', href: '/content/projects' },
      { name: 'Courses', href: '/content/courses' },
    ],
  },
  {
    name: 'Analytics',
    href: '/analytics',
    icon: BarChartIcon,
  },
  {
    name: 'Settings',
    href: '/settings',
    icon: SettingsIcon,
  },
];
```

### Navigation Component

```tsx
import { NavLink } from '@/components/ui/nav-link';

function Sidebar() {
  return (
    <nav className="space-y-1">
      {navigation.map((item) => (
        <NavLink
          key={item.href}
          href={item.href}
          icon={item.icon}
          badge={item.badge}
        >
          {item.name}
        </NavLink>
      ))}
    </nav>
  );
}
```

---

## User Experience Patterns

### Loading States

**Skeleton Loaders:**
```tsx
function MindsPageSkeleton() {
  return (
    <div className="space-y-4">
      <Skeleton className="h-12 w-full" /> {/* Search bar */}
      <Skeleton className="h-64 w-full" /> {/* Table */}
      <Skeleton className="h-64 w-full" />
      <Skeleton className="h-64 w-full" />
    </div>
  );
}

// Usage:
function MindsPage() {
  const { data, isLoading } = useMinds();

  if (isLoading) return <MindsPageSkeleton />;
  return <MindsTable data={data} />;
}
```

---

### Empty States

```tsx
function EmptyState({ title, description, action }: Props) {
  return (
    <div className="flex flex-col items-center justify-center py-12">
      <EmptyIllustration className="w-64 h-64 opacity-50" />
      <h3 className="mt-4 text-lg font-semibold">{title}</h3>
      <p className="mt-2 text-sm text-muted-foreground">{description}</p>
      {action && <div className="mt-6">{action}</div>}
    </div>
  );
}

// Usage:
{minds.length === 0 && (
  <EmptyState
    title="No minds yet"
    description="Get started by creating your first mind."
    action={<Button onClick={openCreateDialog}>Create Mind</Button>}
  />
)}
```

---

### Error States

```tsx
function ErrorState({ error, retry }: Props) {
  return (
    <Alert variant="destructive">
      <AlertCircle className="h-4 w-4" />
      <AlertTitle>Error</AlertTitle>
      <AlertDescription>
        {error.message}
        {retry && (
          <Button variant="outline" size="sm" onClick={retry} className="mt-2">
            Try Again
          </Button>
        )}
      </AlertDescription>
    </Alert>
  );
}
```

---

### Real-time Updates

```tsx
function PipelineJobStatus({ jobId }: Props) {
  const [status, setStatus] = useState('pending');

  useEffect(() => {
    // Subscribe to job updates
    const channel = supabase
      .channel('job-updates')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'job_executions',
          filter: `id=eq.${jobId}`,
        },
        (payload) => {
          setStatus(payload.new.status);
          toast.success(`Job ${payload.new.status}`);
        }
      )
      .subscribe();

    return () => { channel.unsubscribe(); };
  }, [jobId]);

  return <StatusBadge status={status} />;
}
```

---

## Accessibility

### WCAG 2.1 Level AA Compliance

**Requirements:**
- ✅ Keyboard navigation (all interactive elements)
- ✅ Screen reader support (ARIA labels, roles)
- ✅ Color contrast (4.5:1 minimum for text)
- ✅ Focus indicators (visible focus rings)
- ✅ Semantic HTML (headings, landmarks, lists)

**Implementation:**
```tsx
// shadcn/ui components have built-in accessibility
<Button>          {/* role="button", keyboard support */}
<Dialog>          {/* aria-modal, focus trap */}
<Popover>         {/* aria-expanded, aria-controls */}
<Table>           {/* role="table", proper ARIA */}
```

### Keyboard Shortcuts

```typescript
// Global shortcuts
const shortcuts = {
  'cmd+k': 'Open search',
  'cmd+b': 'Toggle sidebar',
  'cmd+n': 'New mind',
  '/': 'Focus search',
  'esc': 'Close modal/dropdown',
};

// Implement with react-hotkeys-hook
useHotkeys('cmd+k', () => openSearch());
```

---

## Performance Optimization

### Code Splitting

```tsx
// Lazy load heavy components
const AnalyticsChart = dynamic(() => import('@/components/charts/analytics'), {
  loading: () => <Skeleton className="h-64" />,
  ssr: false, // Only render client-side
});
```

### Image Optimization

```tsx
import Image from 'next/image';

<Image
  src="/mind-avatar.png"
  alt="Mind avatar"
  width={64}
  height={64}
  loading="lazy"
  placeholder="blur"
/>
```

### Bundle Size Budget

```json
{
  "budgets": [
    {
      "type": "initial",
      "maximumWarning": "500kb",
      "maximumError": "1mb"
    },
    {
      "type": "anyComponentStyle",
      "maximumWarning": "10kb"
    }
  ]
}
```

---

## Review Checklists

### For UX Senior 🎨

- [ ] **User Flows:** Are all primary user journeys intuitive?
- [ ] **Navigation:** Is the information architecture clear?
- [ ] **Feedback:** Do all interactions provide clear feedback?
- [ ] **Error Handling:** Are error messages helpful and actionable?
- [ ] **Empty States:** Are they encouraging and provide next steps?
- [ ] **Loading States:** Do they reduce perceived wait time?
- [ ] **Accessibility:** Can users navigate without a mouse?
- [ ] **Mobile:** Does the responsive design work on small screens?

### For Design System Senior 🎭

- [ ] **Component Library:** Is shadcn/ui the right choice?
- [ ] **Design Tokens:** Are color/spacing/typography scales consistent?
- [ ] **Dark Mode:** Do all components support dark mode?
- [ ] **Theming:** Can the design be customized easily?
- [ ] **Reusability:** Are components composable and reusable?
- [ ] **Documentation:** Are components documented for other developers?
- [ ] **Performance:** Is the component bundle size acceptable?
- [ ] **Accessibility:** Do components meet WCAG 2.1 AA standards?

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-10-28 | 1.0 | Initial frontend architecture | Winston (Architect) |

---

**Previous:** [← 3. Data Architecture](./3-data-architecture.md)
**Next:** [5. Backend Architecture →](./5-backend-architecture.md)
