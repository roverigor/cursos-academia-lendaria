# Component PR: [Component Name]

**Type:** `ui` | `feature` | `layout` | `form` | `chart`
**Component:** `components/[path]/[name].tsx`
**Owner:** @your-username

---

## Description

Brief description of what this component does and why it's needed.

**Example Usage:**
```tsx
<ComponentName prop="value" />
```

---

## Component Quality Checklist

**CRITICAL: All items MUST be checked before requesting review**

### 🎨 Design Token Compliance

- [ ] **Zero hardcoded colors** - Uses semantic tokens (bg-primary, text-foreground)
- [ ] **Zero hardcoded spacing** - Uses scale (p-4, gap-spacing-md) or semantic tokens
- [ ] **Zero hardcoded typography** - Uses scale (text-base) or semantic tokens (text-heading)
- [ ] **Zero arbitrary values** - No `text-[17px]`, `w-[234px]`, `bg-[#3b82f6]`

**Test:**
```bash
# Run this to find violations:
grep -r "text-\[" components/your-component/
grep -r "w-\[" components/your-component/
grep -r "bg-\[" components/your-component/
```

---

### 📱 Responsive Design

- [ ] **Mobile-first approach** - Base styles for mobile, breakpoints for larger screens
- [ ] **Tested on all breakpoints** - Verified on sm (640px), md (768px), lg (1024px), xl (1280px)
- [ ] **No fixed widths** - Uses relative units (%, rem, viewport units) or responsive classes
- [ ] **Touch-friendly** - Interactive elements ≥ 44x44px on mobile

**Test:**
```bash
# Open Storybook, toggle device toolbar
# Verify component works on iPhone SE, iPad, Desktop
```

---

### 🌓 Dark Mode Support

- [ ] **Uses semantic tokens** - bg-background, text-foreground (auto-switches)
- [ ] **Tested in both themes** - Verified light mode + dark mode
- [ ] **All states work** - Default, hover, active, disabled, error in both themes
- [ ] **No hardcoded dark: classes** - Unless absolutely necessary

**Test:**
```tsx
// In Storybook
export const DarkMode: Story = {
  parameters: { backgrounds: { default: 'dark' } },
  render: () => <YourComponent />,
};
```

---

### ♿ Accessibility (WCAG AA)

- [ ] **Keyboard navigation** - Tab focuses, Enter/Space activates
- [ ] **ARIA labels** - Interactive elements have aria-label or aria-labelledby
- [ ] **Color contrast** - Minimum 4.5:1 for text, 3:1 for UI components
- [ ] **Screen reader tested** - Component announces correctly (VoiceOver/NVDA)
- [ ] **Focus indicators** - Visible focus ring on keyboard navigation

**Test:**
```bash
# Run axe-core
pnpm add -D @axe-core/cli
axe http://localhost:6006/iframe.html?id=your-component --wcag=aa

# Manual keyboard test
# 1. Tab to component
# 2. Press Enter/Space
# 3. Verify action occurs
```

---

### 🔧 TypeScript Compliance

- [ ] **Strict mode** - No `any`, no `@ts-ignore` (unless documented why)
- [ ] **All props typed** - Interface/type for component props
- [ ] **Exported types** - Props interface exported for consumers
- [ ] **Generic types** - Used where appropriate (DataTable<T>)

**Test:**
```bash
pnpm typecheck
# Should pass with zero errors
```

---

### ✅ Testing

- [ ] **Unit tests exist** - `[component].test.tsx` file created
- [ ] **Coverage >80%** - Complex components have high coverage
- [ ] **All variants tested** - Each prop combination has test
- [ ] **Accessibility tested** - jest-axe checks included
- [ ] **Tests pass** - `pnpm test` succeeds

**Example Test:**
```tsx
import { render, screen } from '@testing-library/react';
import { axe } from 'jest-axe';
import { YourComponent } from './your-component';

describe('YourComponent', () => {
  it('renders correctly', () => {
    render(<YourComponent />);
    expect(screen.getByText('Expected text')).toBeInTheDocument();
  });

  it('is accessible', async () => {
    const { container } = render(<YourComponent />);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

---

### 📚 Documentation

- [ ] **JSDoc comment** - Component has description and @example
- [ ] **Storybook story exists** - `[component].stories.tsx` file created
- [ ] **All variants documented** - Each prop combination shown in Storybook
- [ ] **README updated** - Component added to components/README.md

**Example JSDoc:**
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

---

### 📦 Bundle Size

- [ ] **Size checked** - Component bundle size measured
- [ ] **Within limits** - Base UI <5KB, feature components <10KB, charts <20KB
- [ ] **No bloat** - No unnecessary dependencies imported
- [ ] **Tree-shaking** - Imports specific functions, not entire libraries

**Test:**
```bash
# Check bundle impact
pnpm build
# Review build output for component size
```

---

### 🎭 Visual Regression

- [ ] **Storybook story created** - All variants + states visible
- [ ] **Chromatic passing** - Visual diff approved in Chromatic dashboard
- [ ] **Screenshot tests** - Light + dark mode captured

---

## Breaking Changes

**Does this PR introduce breaking changes?** Yes / No

If yes, describe:
- What breaks
- Migration guide
- Deprecation warnings added

---

## Design System Review

**Component Category:**
- [ ] Base UI (shadcn/ui component)
- [ ] Custom UI (built on shadcn)
- [ ] Feature component (domain-specific)
- [ ] Layout component
- [ ] Form component
- [ ] Chart/visualization

**Approval Required:**
- [ ] Design System Senior (for new components)
- [ ] UX Senior (for user-facing changes)

---

## Screenshots

**Light Mode:**
![Light mode screenshot]

**Dark Mode:**
![Dark mode screenshot]

**Mobile:**
![Mobile screenshot]

---

## Checklist Summary

**CRITICAL - All must be checked:**
- [ ] Zero hardcoded values (colors, spacing, typography)
- [ ] Responsive (mobile, tablet, desktop tested)
- [ ] Dark mode support (both themes tested)
- [ ] Accessibility (WCAG AA, keyboard nav, ARIA)
- [ ] TypeScript strict (no `any`, all props typed)
- [ ] Tests (>80% coverage, all variants)
- [ ] Documentation (JSDoc, Storybook, README)
- [ ] Bundle size within limits
- [ ] Visual regression (Chromatic approved)

---

## Reviewers

**Code Review:** @developer-name
**Design System Review:** @design-system-senior
**UX Review:** @ux-senior (if user-facing)

---

## Related

- Issue: #123
- Design: [Figma link]
- Spec: [Link to component spec]

---

## Notes

Any additional context, edge cases, or decisions made during implementation.
