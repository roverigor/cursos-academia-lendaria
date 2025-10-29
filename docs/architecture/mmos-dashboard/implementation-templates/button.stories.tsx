/**
 * MMOS Admin Dashboard - Button Component Stories
 *
 * Visual Regression Testing: Storybook + Chromatic
 * - All variants documented
 * - All states tested (default, hover, focus, disabled)
 * - Dark mode coverage
 *
 * Location: apps/dashboard/components/ui/button.stories.tsx
 */

import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './button';

/**
 * Button component from shadcn/ui
 *
 * Primary UI component for user interaction.
 * Uses semantic design tokens (bg-primary, text-primary-foreground).
 */
const meta: Meta<typeof Button> = {
  title: 'UI/Button',
  component: Button,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: 'select',
      options: ['default', 'destructive', 'outline', 'secondary', 'ghost', 'link'],
      description: 'Visual style variant',
    },
    size: {
      control: 'select',
      options: ['default', 'sm', 'lg', 'icon'],
      description: 'Size variant',
    },
    asChild: {
      control: 'boolean',
      description: 'Render as child component (Slot pattern)',
    },
    disabled: {
      control: 'boolean',
      description: 'Disabled state',
    },
  },
};

export default meta;
type Story = StoryObj<typeof Button>;

/**
 * Default button (primary variant)
 */
export const Default: Story = {
  args: {
    children: 'Button',
  },
};

/**
 * All variants side-by-side
 */
export const Variants: Story = {
  render: () => (
    <div className="flex flex-wrap gap-spacing-md">
      <Button variant="default">Default</Button>
      <Button variant="destructive">Destructive</Button>
      <Button variant="outline">Outline</Button>
      <Button variant="secondary">Secondary</Button>
      <Button variant="ghost">Ghost</Button>
      <Button variant="link">Link</Button>
    </div>
  ),
};

/**
 * All sizes side-by-side
 */
export const Sizes: Story = {
  render: () => (
    <div className="flex items-center gap-spacing-md">
      <Button size="sm">Small</Button>
      <Button size="default">Default</Button>
      <Button size="lg">Large</Button>
      <Button size="icon">📧</Button>
    </div>
  ),
};

/**
 * Disabled state (all variants)
 */
export const Disabled: Story = {
  render: () => (
    <div className="flex flex-wrap gap-spacing-md">
      <Button variant="default" disabled>Default</Button>
      <Button variant="destructive" disabled>Destructive</Button>
      <Button variant="outline" disabled>Outline</Button>
      <Button variant="secondary" disabled>Secondary</Button>
      <Button variant="ghost" disabled>Ghost</Button>
      <Button variant="link" disabled>Link</Button>
    </div>
  ),
};

/**
 * Loading state (with spinner icon)
 */
export const Loading: Story = {
  render: () => (
    <div className="flex gap-spacing-md">
      <Button disabled>
        <svg
          className="mr-2 h-4 w-4 animate-spin"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            className="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            strokeWidth="4"
          />
          <path
            className="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          />
        </svg>
        Loading...
      </Button>
      <Button variant="outline" disabled>
        <svg
          className="mr-2 h-4 w-4 animate-spin"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            className="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            strokeWidth="4"
          />
          <path
            className="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          />
        </svg>
        Loading...
      </Button>
    </div>
  ),
};

/**
 * With icons (Lucide React)
 */
export const WithIcons: Story = {
  render: () => (
    <div className="flex flex-wrap gap-spacing-md">
      <Button>
        <span className="mr-2">📧</span>
        Email
      </Button>
      <Button variant="outline">
        <span className="mr-2">📥</span>
        Download
      </Button>
      <Button variant="secondary">
        <span className="mr-2">⚙️</span>
        Settings
      </Button>
      <Button variant="destructive">
        <span className="mr-2">🗑️</span>
        Delete
      </Button>
    </div>
  ),
};

/**
 * Responsive sizing (mobile to desktop)
 */
export const Responsive: Story = {
  render: () => (
    <Button className="w-full sm:w-auto">
      Responsive Button
    </Button>
  ),
  parameters: {
    viewport: {
      defaultViewport: 'mobile1',
    },
  },
};

/**
 * Dark mode (all variants)
 *
 * Chromatic captures this automatically when dark mode enabled
 */
export const DarkMode: Story = {
  parameters: {
    backgrounds: {
      default: 'dark',
    },
  },
  render: () => (
    <div className="dark">
      <div className="flex flex-wrap gap-spacing-md bg-background p-spacing-lg rounded-md">
        <Button variant="default">Default</Button>
        <Button variant="destructive">Destructive</Button>
        <Button variant="outline">Outline</Button>
        <Button variant="secondary">Secondary</Button>
        <Button variant="ghost">Ghost</Button>
        <Button variant="link">Link</Button>
      </div>
    </div>
  ),
};

/**
 * Accessibility test (keyboard navigation)
 *
 * Test:
 * 1. Tab to focus
 * 2. Enter/Space to activate
 * 3. Verify focus ring visible
 */
export const Accessibility: Story = {
  render: () => (
    <div className="flex flex-col gap-spacing-md">
      <p className="text-caption text-muted-foreground">
        Press Tab to focus, Enter/Space to activate
      </p>
      <div className="flex gap-spacing-md">
        <Button>First Button</Button>
        <Button variant="outline">Second Button</Button>
        <Button variant="secondary">Third Button</Button>
      </div>
    </div>
  ),
};

/**
 * All states grid (comprehensive visual regression)
 */
export const AllStates: Story = {
  render: () => (
    <div className="space-y-spacing-lg">
      <div>
        <h3 className="text-heading mb-spacing-md">Default Variant</h3>
        <div className="flex gap-spacing-sm">
          <Button>Default</Button>
          <Button disabled>Disabled</Button>
        </div>
      </div>
      <div>
        <h3 className="text-heading mb-spacing-md">Destructive Variant</h3>
        <div className="flex gap-spacing-sm">
          <Button variant="destructive">Default</Button>
          <Button variant="destructive" disabled>Disabled</Button>
        </div>
      </div>
      <div>
        <h3 className="text-heading mb-spacing-md">Outline Variant</h3>
        <div className="flex gap-spacing-sm">
          <Button variant="outline">Default</Button>
          <Button variant="outline" disabled>Disabled</Button>
        </div>
      </div>
      <div>
        <h3 className="text-heading mb-spacing-md">Sizes</h3>
        <div className="flex items-center gap-spacing-sm">
          <Button size="sm">Small</Button>
          <Button size="default">Default</Button>
          <Button size="lg">Large</Button>
          <Button size="icon">📧</Button>
        </div>
      </div>
    </div>
  ),
};
