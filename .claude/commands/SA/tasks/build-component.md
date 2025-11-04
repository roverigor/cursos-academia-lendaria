# Build Production-Ready Component

> Task ID: atlas-build-component
> Agent: Atlas (Design System Builder)
> Version: 1.0.0

## Description

Generate production-ready React TypeScript component from design tokens. Output follows Shadcn-style Tailwind utility patterns with `cva` variants, optional Radix composition, tests, Storybook stories, and documentation. All styling uses tokens/variables (zero hardcoded values) and supports loading/accessibility states out of the box.

## Prerequisites

- Setup completed (*setup command run successfully)
- Tokens loaded and accessible
- React and TypeScript configured

## Workflow

### Interactive Elicitation

This task uses interactive elicitation to configure component.

1. **Select Component Type**
   - Atomic level (atom, molecule, organism)
   - Component name (Button, Input, Card, etc)
   - Confirm token availability for this component

2. **Configure Component Features**
   - Variants needed (primary, secondary, destructive, etc.)
   - Sizes needed (sm, md, lg, icon)
   - States needed (hover, disabled, loading, error)
   - Additional props (icon slots, density, alignment)

3. **Review Generation Plan**
   - Show files to be generated
   - Confirm test coverage requirements
   - Ask for Storybook stories (if enabled)

### Steps

1. **Validate Prerequisites**
   - Check tokens are loaded
   - Verify component doesn't already exist (or confirm overwrite)
   - Validate component name (PascalCase)
   - Validation: Ready to generate

2. **Load Token References**
   - Identify which tokens this component needs
   - Validate token availability
   - Generate token import statements
   - Validation: All required tokens exist

3. **Generate Component File**
   - Create React component using `React.forwardRef` + `Slot` (Radix pattern)
   - Import `cva` + `cn` helpers (`class-variance-authority`, `tailwind-merge`)
   - Implement variants, sizes, density, and loading states
   - Wire ARIA attributes, keyboard handling, dark mode parity
   - Validation: Valid TypeScript (strict), lint clean, no hardcoded CSS values

4. **Author Variant Catalogue**
   - Define `cva` config (base classes, variants, compound variants, defaults)
   - Map variant classes to tokens (Tailwind utilities referencing design tokens)
   - Generate story-friendly helper types (VariantProps)
   - Validation: Variants align with consolidated tokens and atomic level

5. **Generate Unit Tests**
   - Create test file ({Component}.test.tsx) with RTL + jest-axe
   - Snapshot default render, variant permutations, responsive classes
   - Test loading/disabled state interactions and event handlers
   - Aim for >85% coverage including accessibility assertions
   - Validation: Tests pass locally (npm test) with coverage gated

6. **Generate Storybook Stories (Optional)**
   - If Storybook enabled, create {Component}.stories.tsx (Storybook 8 syntax)
   - Provide CSF stories for each variant/size & loading state
   - Configure controls, play functions, a11y addon
   - Validation: `npm run storybook` renders without warnings

7. **Run Accessibility Checks**
   - Validate ARIA attributes + keyboard flows (Tab/Shift+Tab/Space/Enter/Escape)
   - Check WCAG 2.2 AA + APCA contrast, including dark mode tokens
   - Ensure focus-visible styles present and themable
   - Validation: jest-axe passes, manual keyboard traversal verified

8. **Generate Component Documentation**
   - Create {Component}.md in docs/ with overview + variant tables
   - Document props, TypeScript types, default variants, composition notes
   - Include usage for light/dark themes, loading state, accessibility guidance
   - Validation: Docs align with generated code and tokens

9. **Update Component Index**
   - Add to design-system/index.ts (or `components/ui/index.ts`)
   - Export component for easy import
   - Update barrel exports
   - Validation: Component importable

10. **Update State File**
    - Add component to patterns_built in .state.yaml
    - Record atomic level, variants, test coverage
    - Increment component count
    - Validation: State tracking updated

## Output

- **{Component}.tsx**: React TypeScript component (forwardRef + cva)
- **{Component}.test.tsx**: Unit + accessibility tests
- **{Component}.stories.tsx**: Storybook stories (optional)
- **{Component}.md**: Component reference documentation
- **ui/index.ts**: Barrel export updated
- **.state.yaml**: Updated with component metadata + variant catalog

### Output Format

```typescript
// button.tsx
import * as React from 'react';
import { Slot } from '@radix-ui/react-slot';
import { cva, type VariantProps } from 'class-variance-authority';
import { cn } from '@/lib/utils';
import { Spinner } from '@/components/ui/spinner';

export const buttonVariants = cva(
  'inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-70',
  {
    variants: {
      variant: {
        primary: 'bg-primary text-primary-foreground hover:bg-primary/90',
        secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/90',
        outline: 'border border-border bg-transparent hover:bg-muted'
      },
      size: {
        sm: 'h-9 px-3',
        md: 'h-10 px-4',
        lg: 'h-12 px-6 text-base',
        icon: 'h-10 w-10'
      }
    },
    defaultVariants: {
      variant: 'primary',
      size: 'md'
    }
  }
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
  isLoading?: boolean;
  loadingIcon?: React.ReactNode;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  (
    { className, variant, size, asChild = false, isLoading = false, loadingIcon, children, ...props },
    ref
  ) => {
    const Comp = asChild ? Slot : 'button';

    return (
      <Comp
        ref={ref}
        className={cn(buttonVariants({ variant, size }), className, isLoading && 'pointer-events-none')}
        data-state={isLoading ? 'loading' : props['data-state']}
        aria-busy={isLoading}
        {...props}
      >
        {isLoading && (loadingIcon ?? <Spinner className="mr-2 h-4 w-4 animate-spin" />)}
        <span className="inline-flex items-center gap-1">{children}</span>
      </Comp>
    );
  }
);
Button.displayName = 'Button';

export { Button };
```

## Success Criteria

- [ ] Component compiles without TypeScript errors (strict) and passes lint
- [ ] Variants implemented via `cva` with token-backed Tailwind utilities
- [ ] Props fully typed (VariantProps + custom props) with TSDoc
- [ ] Loading/disabled states, accessibility attributes, and dark mode supported
- [ ] Unit + jest-axe tests pass with ≥85% coverage
- [ ] Storybook stories render (if enabled) with controls + docs tab
- [ ] Component documentation published with variant/density tables
- [ ] .state.yaml updated with variant catalogue + QA status

## Error Handling

- **Token not found**: Report which token is missing, suggest alternatives
- **Component exists**: Ask to overwrite or use different name
- **TypeScript errors**: Display errors, suggest fixes
- **Test failures**: Show failing tests, don't complete until fixed
- **Accessibility violations**: Warn and suggest improvements

## Security Considerations

- Sanitize component name (prevent injection)
- Validate token references
- Escape user content in examples
- No eval() or dynamic code execution
