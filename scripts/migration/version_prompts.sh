#!/bin/bash
#
# Version system prompts with proper directory structure.
# Part of Story 3.1 - Backward Compatible Additions.
#
# Usage:
#   bash version_prompts.sh <mind_directory>
#   bash version_prompts.sh outputs/minds/sam_altman
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: bash version_prompts.sh <mind_directory>"
    echo "Example: bash version_prompts.sh outputs/minds/sam_altman"
    exit 1
fi

MIND_DIR="$1"
PROMPTS_DIR="$MIND_DIR/system_prompts"

echo ""
echo "============================================================"
echo "  Versioning System Prompts - $(basename "$MIND_DIR")"
echo "============================================================"
echo ""

# Check if mind directory exists
if [ ! -d "$MIND_DIR" ]; then
    log_error "Mind directory not found: $MIND_DIR"
    exit 1
fi

# Check if system_prompts directory exists
if [ ! -d "$PROMPTS_DIR" ]; then
    log_warning "No system_prompts/ directory found in $MIND_DIR"
    log_info "Creating empty structure..."
    mkdir -p "$PROMPTS_DIR/generalista"
    echo "# System Prompts" > "$PROMPTS_DIR/README.md"
    echo "" >> "$PROMPTS_DIR/README.md"
    echo "This directory contains versioned system prompts." >> "$PROMPTS_DIR/README.md"
    log_info "Created system_prompts/generalista/ directory"
    exit 0
fi

echo "Scanning system_prompts directory: $PROMPTS_DIR"

# Find all markdown files in system_prompts/ (non-recursive, root level only)
PROMPT_FILES=$(find "$PROMPTS_DIR" -maxdepth 1 -type f -name "*.md" ! -name "README.md" ! -name "DEPRECATED.md" 2>/dev/null || true)

if [ -z "$PROMPT_FILES" ]; then
    log_warning "No prompt files found in $PROMPTS_DIR (root level)"
    log_info "Directory already organized or empty"
    exit 0
fi

FILE_COUNT=$(echo "$PROMPT_FILES" | wc -l | tr -d ' ')
echo "Found $FILE_COUNT prompt file(s) to version"
echo ""

# Create new structure
mkdir -p "$PROMPTS_DIR/generalista"
mkdir -p "$PROMPTS_DIR/specialists"

VERSIONED_COUNT=0
SKIPPED_COUNT=0

# Process each prompt file
while IFS= read -r file; do
    if [ -z "$file" ]; then
        continue
    fi

    filename=$(basename "$file")
    echo "Processing: $filename"

    # Determine if it's a specialist prompt
    is_specialist=false
    specialist_name=""

    # Check for specialist indicators in filename
    if echo "$filename" | grep -qiE "specialist|coach|consultant|advisor|mentor"; then
        is_specialist=true
        # Extract specialist name from filename
        specialist_name=$(echo "$filename" | sed 's/[_-]/ /g' | sed 's/.md$//' | sed 's/specialist//gi' | sed 's/system prompt//gi' | tr -s ' ' | xargs)
        specialist_name=$(echo "$specialist_name" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

        if [ -z "$specialist_name" ]; then
            specialist_name="unknown_specialist"
        fi
    fi

    # Determine target directory
    if [ "$is_specialist" = true ]; then
        TARGET_DIR="$PROMPTS_DIR/specialists/$specialist_name"
        mkdir -p "$TARGET_DIR"
        log_info "  Detected specialist: $specialist_name"
    else
        TARGET_DIR="$PROMPTS_DIR/generalista"
        log_info "  Detected generalista prompt"
    fi

    # Target filename (v1.0.0.md)
    TARGET_FILE="$TARGET_DIR/v1.0.0.md"

    # Check if target already exists
    if [ -f "$TARGET_FILE" ]; then
        log_warning "  Target already exists: $TARGET_FILE (skipping)"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        continue
    fi

    # Copy file to new location (don't move, preserve original)
    cp "$file" "$TARGET_FILE"

    # Create symlink to latest
    cd "$TARGET_DIR"
    ln -sf "v1.0.0.md" "latest.md"
    cd - > /dev/null

    log_info "  Created: $TARGET_FILE"
    log_info "  Created symlink: $TARGET_DIR/latest.md -> v1.0.0.md"

    VERSIONED_COUNT=$((VERSIONED_COUNT + 1))

done <<< "$PROMPT_FILES"

echo ""

# Create DEPRECATED.md in root if files were versioned
if [ $VERSIONED_COUNT -gt 0 ]; then
    DEPRECATED_FILE="$PROMPTS_DIR/DEPRECATED.md"

    cat > "$DEPRECATED_FILE" << 'EOF'
# DEPRECATED: Old System Prompts Structure

**⚠️ This directory structure is deprecated.**

## New Structure

System prompts have been reorganized with versioning:

```
system_prompts/
├── generalista/
│   ├── v1.0.0.md
│   └── latest.md -> v1.0.0.md
└── specialists/
    └── {specialist_name}/
        ├── v1.0.0.md
        └── latest.md -> v1.0.0.md
```

## Migration

Files in the root of `system_prompts/` have been copied to the new structure above.

- **Generalista prompts**: `generalista/v1.0.0.md`
- **Specialist prompts**: `specialists/{name}/v1.0.0.md`

## Usage

**Always use the versioned files:**
- For current version: Use `latest.md` symlink
- For specific version: Use `v1.0.0.md`, `v1.1.0.md`, etc.

## Old Files

Old files remain in this directory for backward compatibility but should not be used for new development.

---
*Created during Epic 3 Story 3.1 migration*
EOF

    log_info "Created DEPRECATED.md in system_prompts/"
fi

# Summary
echo ""
echo "============================================================"
echo "  Summary"
echo "============================================================"
echo "  Versioned: $VERSIONED_COUNT"
echo "  Skipped: $SKIPPED_COUNT"
echo "  Total processed: $((VERSIONED_COUNT + SKIPPED_COUNT))"
echo "============================================================"
echo ""

if [ $VERSIONED_COUNT -gt 0 ]; then
    log_info "System prompts versioned successfully"
    echo ""
    echo "New structure:"
    tree -L 2 "$PROMPTS_DIR" 2>/dev/null || find "$PROMPTS_DIR" -type d | head -10
else
    log_info "No changes needed - prompts already versioned"
fi

exit 0
