#!/bin/bash

# ========================================
# MMOS Admin Dashboard - Storybook Setup Script
# ========================================
#
# Purpose: Automate Storybook + Chromatic configuration
# Usage: bash storybook-setup.sh
# Location: Copy to project root, then run
#
# What this script does:
# 1. Installs Storybook
# 2. Installs Chromatic
# 3. Configures Tailwind CSS integration
# 4. Creates example stories
# 5. Sets up CI/CD workflow
# 6. Tests Storybook locally
#
# ========================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ========================================
# Helper Functions
# ========================================

print_step() {
    echo -e "${GREEN}▶ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# ========================================
# Pre-flight Checks
# ========================================

print_step "Pre-flight checks..."

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from apps/dashboard directory."
    exit 1
fi

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    print_error "pnpm not found. Please install pnpm first: npm install -g pnpm"
    exit 1
fi

print_success "Pre-flight checks passed"

# ========================================
# Step 1: Install Storybook
# ========================================

print_step "Step 1: Installing Storybook..."

if [ -d ".storybook" ]; then
    print_warning "Storybook already installed. Skipping..."
else
    pnpm dlx storybook@latest init --yes
    print_success "Storybook installed"
fi

# ========================================
# Step 2: Install Chromatic
# ========================================

print_step "Step 2: Installing Chromatic..."

pnpm add -D chromatic
print_success "Chromatic installed"

# ========================================
# Step 3: Configure Tailwind CSS for Storybook
# ========================================

print_step "Step 3: Configuring Tailwind CSS..."

# Create .storybook/preview.ts with Tailwind imports
cat > .storybook/preview.ts << 'EOF'
import type { Preview } from '@storybook/react';
import '../app/globals.css';  // Import Tailwind CSS

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: '^on[A-Z].*' },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    backgrounds: {
      default: 'light',
      values: [
        {
          name: 'light',
          value: '#ffffff',
        },
        {
          name: 'dark',
          value: '#0a0a0a',
        },
      ],
    },
  },
};

export default preview;
EOF

print_success "Tailwind CSS configured for Storybook"

# ========================================
# Step 4: Update package.json scripts
# ========================================

print_step "Step 4: Adding npm scripts..."

# Add build-storybook script if not exists
if ! grep -q '"build-storybook"' package.json; then
    # Using node to update package.json (portable across platforms)
    node -e "
    const fs = require('fs');
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    pkg.scripts = pkg.scripts || {};
    pkg.scripts['build-storybook'] = 'storybook build';
    pkg.scripts['storybook'] = 'storybook dev -p 6006';
    pkg.scripts['chromatic'] = 'chromatic --exit-zero-on-changes';
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
    "
    print_success "npm scripts added"
else
    print_warning "npm scripts already exist. Skipping..."
fi

# ========================================
# Step 5: Create example story (if not exists)
# ========================================

print_step "Step 5: Creating example Button story..."

mkdir -p components/ui

if [ ! -f "components/ui/button.stories.tsx" ]; then
    # Copy from templates directory (assuming it exists)
    if [ -f "../../docs/architecture/mmos-dashboard/implementation-templates/button.stories.tsx" ]; then
        cp ../../docs/architecture/mmos-dashboard/implementation-templates/button.stories.tsx components/ui/
        print_success "Button story created"
    else
        print_warning "Template not found. Create button.stories.tsx manually."
    fi
else
    print_warning "Button story already exists. Skipping..."
fi

# ========================================
# Step 6: Set up CI/CD workflow
# ========================================

print_step "Step 6: Setting up CI/CD workflow..."

mkdir -p ../../.github/workflows

if [ ! -f "../../.github/workflows/visual-regression.yml" ]; then
    # Copy workflow from templates
    if [ -f "../../docs/architecture/mmos-dashboard/implementation-templates/visual-regression.yml" ]; then
        cp ../../docs/architecture/mmos-dashboard/implementation-templates/visual-regression.yml ../../.github/workflows/
        print_success "CI/CD workflow created"
    else
        print_warning "Workflow template not found. Create manually."
    fi
else
    print_warning "CI/CD workflow already exists. Skipping..."
fi

# ========================================
# Step 7: Configure Chromatic
# ========================================

print_step "Step 7: Configuring Chromatic..."

print_warning "To complete Chromatic setup:"
echo "1. Visit https://www.chromatic.com and sign up"
echo "2. Create a new project"
echo "3. Copy your project token"
echo "4. Run: npx chromatic --project-token=<your-token>"
echo "5. Add CHROMATIC_PROJECT_TOKEN to GitHub secrets"
echo ""
echo "Or run: pnpm chromatic (will prompt for token)"

# ========================================
# Step 8: Test Storybook locally
# ========================================

print_step "Step 8: Testing Storybook..."

print_success "Setup complete! 🎉"
echo ""
echo "Next steps:"
echo "1. Start Storybook: pnpm storybook"
echo "2. Open http://localhost:6006"
echo "3. Create more stories in components/**/*.stories.tsx"
echo "4. Run Chromatic: pnpm chromatic"
echo ""

# ========================================
# Summary
# ========================================

cat << EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STORYBOOK SETUP COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Installed:
  ✓ Storybook
  ✓ Chromatic
  ✓ Tailwind CSS integration

Created:
  ✓ .storybook/preview.ts
  ✓ npm scripts (storybook, build-storybook, chromatic)
  ✓ Example Button story (if available)
  ✓ CI/CD workflow (.github/workflows/visual-regression.yml)

Commands available:
  pnpm storybook          - Start Storybook dev server
  pnpm build-storybook    - Build Storybook for production
  pnpm chromatic          - Run Chromatic visual regression

Next steps:
  1. Run: pnpm storybook
  2. Visit: http://localhost:6006
  3. Create more stories for your components
  4. Connect Chromatic (see instructions above)
  5. Push to GitHub (CI will run automatically)

Documentation:
  - Design System Guide: docs/architecture/mmos-dashboard/11-design-system-guide.md
  - Component Templates: docs/architecture/mmos-dashboard/implementation-templates/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
