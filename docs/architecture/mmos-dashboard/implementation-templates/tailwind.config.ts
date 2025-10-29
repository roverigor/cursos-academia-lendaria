import type { Config } from 'tailwindcss';

/**
 * MMOS Admin Dashboard - Tailwind Configuration
 *
 * Design System: 3-Level Token Hierarchy
 * - Primitive tokens: Raw values (internal use)
 * - Semantic tokens: Purpose-based (RECOMMENDED)
 * - Component tokens: Component-specific (as needed)
 *
 * Location: apps/dashboard/tailwind.config.ts
 */
const config: Config = {
  darkMode: ['class'],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    container: {
      center: true,
      padding: '2rem',
      screens: {
        '2xl': '1400px',
      },
    },
    extend: {
      // ========================================
      // COLOR TOKENS
      // ========================================
      colors: {
        // Base colors (from CSS variables)
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',

        // Brand colors
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },

        // UI element colors
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },

        // ========================================
        // SEMANTIC STATUS COLORS (NEW)
        // ========================================
        success: {
          DEFAULT: 'hsl(var(--success))',
          foreground: 'hsl(var(--success-foreground))',
        },
        warning: {
          DEFAULT: 'hsl(var(--warning))',
          foreground: 'hsl(var(--warning-foreground))',
        },
        error: {
          DEFAULT: 'hsl(var(--error))',
          foreground: 'hsl(var(--error-foreground))',
        },
        info: {
          DEFAULT: 'hsl(var(--info))',
          foreground: 'hsl(var(--info-foreground))',
        },
      },

      // ========================================
      // SPACING TOKENS
      // ========================================
      spacing: {
        // Primitive spacing (4px grid) - OK to use
        // 0, 1, 2, 3, 4, 6, 8, 10, 12, 16, 20, 24 (Tailwind defaults)

        // ========================================
        // SEMANTIC SPACING (NEW - RECOMMENDED)
        // ========================================
        'spacing-xs': '0.5rem',    // 8px  - Tight spacing (icon gaps, badge padding)
        'spacing-sm': '1rem',      // 16px - Default spacing (button padding, input padding)
        'spacing-md': '1.5rem',    // 24px - Section spacing (card padding, form groups)
        'spacing-lg': '2rem',      // 32px - Layout spacing (between page sections)
        'spacing-xl': '3rem',      // 48px - Major spacing (page header, hero sections)
        'spacing-2xl': '4rem',     // 64px - Hero spacing (landing page sections)
        'spacing-3xl': '6rem',     // 96px - Extra large spacing (major page dividers)
      },

      // ========================================
      // TYPOGRAPHY TOKENS
      // ========================================
      fontSize: {
        // Primitive scale (Tailwind defaults) - OK to use
        // xs, sm, base, lg, xl, 2xl, 3xl, 4xl, 5xl, 6xl, 7xl, 8xl, 9xl

        // ========================================
        // SEMANTIC TYPOGRAPHY (NEW - RECOMMENDED)
        // ========================================
        'text-display': ['2.25rem', { lineHeight: '2.5rem', fontWeight: '700' }],     // 36px - h1 (page titles)
        'text-title': ['1.875rem', { lineHeight: '2.25rem', fontWeight: '600' }],     // 30px - h2 (section titles)
        'text-heading': ['1.5rem', { lineHeight: '2rem', fontWeight: '600' }],        // 24px - h3 (card titles)
        'text-subheading': ['1.25rem', { lineHeight: '1.75rem', fontWeight: '500' }], // 20px - h4 (subsection titles)
        'text-body': ['1rem', { lineHeight: '1.5rem', fontWeight: '400' }],           // 16px - Body text
        'text-body-sm': ['0.875rem', { lineHeight: '1.25rem', fontWeight: '400' }],   // 14px - Small body text
        'text-label': ['0.875rem', { lineHeight: '1.25rem', fontWeight: '500' }],     // 14px - Form labels, UI labels
        'text-caption': ['0.75rem', { lineHeight: '1rem', fontWeight: '400' }],       // 12px - Helper text, timestamps
      },

      // ========================================
      // RESPONSIVE BREAKPOINTS
      // ========================================
      screens: {
        'xs': '475px',   // Extra small devices
        'sm': '640px',   // Mobile landscape
        'md': '768px',   // Tablet portrait
        'lg': '1024px',  // Desktop
        'xl': '1280px',  // Large desktop
        '2xl': '1536px', // Ultra-wide
      },

      // ========================================
      // BORDER RADIUS
      // ========================================
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },

      // ========================================
      // ANIMATIONS
      // ========================================
      keyframes: {
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
      },
    },
  },
  plugins: [require('tailwindcss-animate')],
} satisfies Config;

export default config;
