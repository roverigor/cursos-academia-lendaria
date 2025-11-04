# Component Quality Checklist

**Purpose:** Validate component before marking complete
**Agent:** Atlas (Design System Builder)
**Standard:** Production-ready React/TypeScript components

---

## CODE QUALITY

- [ ] TypeScript (strict) compiles with zero errors
- [ ] No `any` types used (prefer discriminated unions / utility types)
- [ ] Props fully typed (VariantProps + component-specific interface)
- [ ] ForwardRef + displayName implemented when required
- [ ] TSDoc comments describe props, defaults, accessibility
- [ ] Component exported as named export (tree-shakeable)

---

## STYLING

- [ ] Tailwind utilities reference semantic tokens (zero hardcoded values)
- [ ] `cva` variant catalogue defined with defaults + compound variants
- [ ] `cn` (tailwind-merge) handles conditional classes (no conflicts)
- [ ] Responsive/density variants implemented where required
- [ ] Dark mode parity confirmed (`data-theme="dark"`)

---

## ACCESSIBILITY (WCAG AA MINIMUM)

- [ ] Semantic HTML elements used
- [ ] ARIA attributes present where needed (expanded, busy, live, etc.)
- [ ] Color contrast ≥4.5:1 (WCAG 2.2) and APCA targets met
- [ ] Keyboard navigation works (Tab/Shift+Tab/Enter/Space/Escape)
- [ ] focus-visible styling present (≥3:1 contrast)
- [ ] Loading/disabled states handled correctly (aria-busy/aria-disabled)
- [ ] Screen reader tested (or documented)

---

## TESTING

- [ ] Unit tests written (React Testing Library)
- [ ] Variants/sizes/compound states tested
- [ ] Loading + disabled behaviour covered
- [ ] Event handlers tested
- [ ] jest-axe (or equivalent) accessibility audit passes
- [ ] Test coverage ≥85%
- [ ] All tests pass

---

## DOCUMENTATION

- [ ] Component.md (or MDX) created
- [ ] Props + variant tables documented
- [ ] Usage examples (light/dark + loading states)
- [ ] Accessibility notes included
- [ ] Migration/design rationale captured when relevant

---

## STORYBOOK (if enabled)

- [ ] Stories file created (Storybook 8 CSF)
- [ ] Story per variant/size + loading/disabled states
- [ ] Controls/args configured (Docs tab updated)
- [ ] Visual regression baselines captured (if enabled)

---

**Reviewer:** ________ **Date:** ________
**Quality Gate:** [ ] PASS [ ] FAIL
