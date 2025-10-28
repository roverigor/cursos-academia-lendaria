/**
 * AIOS Design System Tokens - Tailwind Configuration
 * Version: 1.0.0
 * Generated from: tokens.yaml
 * Date: 2025-10-28
 *
 * Usage: Import in tailwind.config.js
 * const tokens = require('./tokens.tailwind.js');
 *
 * module.exports = {
 *   theme: {
 *     extend: tokens.theme.extend
 *   }
 * }
 */

module.exports = {
  theme: {
    extend: {
      // ============================================
      // COLORS
      // ============================================
      colors: {
        // Background colors
        bg: {
          primary: '#191919',
          secondary: '#262625',
          tertiary: '#2d2d2b',
          elevated: '#40403E',
        },

        // Accent colors
        accent: {
          primary: '#CC785C',
          secondary: '#BF4D43',
          tertiary: '#D4A27F',
          light: '#EBD8BC',
        },

        // Text colors
        text: {
          primary: '#F0F0E8',
          secondary: '#919180',
          inverted: '#FFFFFF',
        },

        // Status colors
        status: {
          success: '#48bb78',
          warning: '#ecc94b',
          error: '#f56565',
          info: '#3498db',
        },
      },

      // ============================================
      // SPACING
      // ============================================
      spacing: {
        'xs': '0.25rem',   // 4px
        'sm': '0.5rem',    // 8px
        'md': '0.75rem',   // 12px
        'lg': '1rem',      // 16px
        'xl': '1.5rem',    // 24px
        '2xl': '2rem',     // 32px
        '3xl': '3rem',     // 48px
      },

      // ============================================
      // BORDER RADIUS
      // ============================================
      borderRadius: {
        'sm': '0.5rem',    // 8px
        'md': '0.75rem',   // 12px
        'lg': '1rem',      // 16px
        'xl': '1.5rem',    // 24px
        'full': '9999px',  // Fully rounded
      },

      // ============================================
      // TYPOGRAPHY
      // ============================================
      fontFamily: {
        sans: [
          '-apple-system',
          'BlinkMacSystemFont',
          'Segoe UI',
          'Roboto',
          'Helvetica Neue',
          'Arial',
          'sans-serif',
        ],
        serif: ['Georgia', 'serif'],
        mono: [
          'SF Mono',
          'Monaco',
          'Cascadia Code',
          'Courier New',
          'monospace',
        ],
      },

      fontSize: {
        'xs': ['0.75rem', { lineHeight: '1.5' }],     // 12px
        'sm': ['0.875rem', { lineHeight: '1.5' }],    // 14px
        'base': ['1rem', { lineHeight: '1.625' }],    // 16px
        'lg': ['1.25rem', { lineHeight: '1.5' }],     // 20px
        'xl': ['1.5rem', { lineHeight: '1.5' }],      // 24px
        '2xl': ['2rem', { lineHeight: '1.25' }],      // 32px
        '3xl': ['3rem', { lineHeight: '1.25' }],      // 48px
      },

      lineHeight: {
        'tight': '1.25',
        'normal': '1.5',
        'relaxed': '1.625',
        'loose': '1.75',
      },

      fontWeight: {
        'normal': '400',
        'medium': '500',
        'semibold': '600',
        'bold': '700',
      },

      // ============================================
      // BREAKPOINTS (SCREENS)
      // ============================================
      screens: {
        'sm': '640px',
        'md': '768px',
        'lg': '1024px',
        'xl': '1280px',
        '2xl': '1536px',
      },

      // ============================================
      // SHADOWS
      // ============================================
      boxShadow: {
        'sm': '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
        'md': '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
        'lg': '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
        'xl': '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
      },

      // ============================================
      // TRANSITIONS
      // ============================================
      transitionDuration: {
        'fast': '150ms',
        'base': '300ms',
        'slow': '500ms',
      },

      transitionTimingFunction: {
        'default': 'cubic-bezier(0.4, 0, 0.2, 1)',
        'in': 'cubic-bezier(0.4, 0, 1, 1)',
        'out': 'cubic-bezier(0, 0, 0.2, 1)',
      },
    },
  },
};

/**
 * USAGE EXAMPLES
 *
 * Color:
 * <div className="bg-bg-primary text-text-primary">
 * <button className="bg-accent-primary text-text-inverted">
 *
 * Spacing:
 * <div className="p-xl m-2xl gap-md">
 *
 * Border Radius:
 * <div className="rounded-lg">
 *
 * Typography:
 * <h1 className="text-3xl font-bold font-serif">
 * <p className="text-base leading-relaxed font-normal">
 *
 * Responsive:
 * <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
 *
 * Shadows:
 * <div className="shadow-md hover:shadow-lg">
 *
 * Transitions:
 * <button className="transition-base duration-base ease-default">
 */
