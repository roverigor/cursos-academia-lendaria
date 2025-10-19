#!/bin/bash
#
# Undo Organization Script
# Rollback file organization for CreatorOS brownfield workflow
#
# Usage:
#   ./undo-organization.sh <course-slug> <timestamp>
#
# Example:
#   ./undo-organization.sh dominando-obsidian 20251018-142345
#
# Description:
#   Reads the audit log from organization and reverses all file movements.
#   This allows safe rollback if organization was incorrect or user wants
#   to start fresh.
#
# Story: STORY-3.2 (File Inventory & Organization)
# Epic: EPIC-3 (Intelligent Workflow System)

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
if [ $# -ne 2 ]; then
    echo -e "${RED}❌ Error: Invalid arguments${NC}"
    echo ""
    echo "Usage: $0 <course-slug> <timestamp>"
    echo ""
    echo "Example:"
    echo "  $0 dominando-obsidian 20251018-142345"
    echo ""
    echo "The timestamp is found in the audit log filename:"
    echo "  organization-log-YYYYMMDD-HHMMSS.md"
    exit 1
fi

COURSE_SLUG="$1"
TIMESTAMP="$2"

# Paths
COURSE_DIR="outputs/courses/${COURSE_SLUG}"
AUDIT_LOG="${COURSE_DIR}/organization-log-${TIMESTAMP}.md"
ROLLBACK_LOG="${COURSE_DIR}/rollback-log-${TIMESTAMP}.md"

# Validation
if [ ! -d "$COURSE_DIR" ]; then
    echo -e "${RED}❌ Error: Course folder not found: ${COURSE_DIR}${NC}"
    exit 1
fi

if [ ! -f "$AUDIT_LOG" ]; then
    echo -e "${RED}❌ Error: Audit log not found: ${AUDIT_LOG}${NC}"
    echo ""
    echo "Available logs:"
    ls -1 "${COURSE_DIR}"/organization-log-*.md 2>/dev/null || echo "  (none found)"
    exit 1
fi

# Confirmation
echo -e "${YELLOW}⚠️  Rollback Organization${NC}"
echo ""
echo "This will UNDO the file organization performed on ${TIMESTAMP}."
echo ""
echo "Course: ${COURSE_SLUG}"
echo "Audit Log: ${AUDIT_LOG}"
echo ""
echo "Files will be moved back to their original locations."
echo ""
read -p "Are you sure? Type 'ROLLBACK' to confirm: " confirmation

if [ "$confirmation" != "ROLLBACK" ]; then
    echo -e "${YELLOW}⚠️  Rollback cancelled.${NC}"
    exit 0
fi

# Parse audit log and extract movements
echo ""
echo -e "${GREEN}📋 Reading audit log...${NC}"

# Extract movement tables from Markdown
# Format: | `source_path` | `target_path` | size | action |

files_to_rollback=0
rollback_errors=0

# Create rollback log
echo "# Rollback Log" > "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"
echo "**Course:** ${COURSE_SLUG}" >> "$ROLLBACK_LOG"
echo "**Original Organization:** ${TIMESTAMP}" >> "$ROLLBACK_LOG"
echo "**Rollback At:** $(date '+%Y-%m-%d %H:%M:%S') UTC" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"
echo "---" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"
echo "## Rollback Movements" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"

# Parse the audit log for file movements
# Extract lines that look like: | `path` | `path` | size | MOVED |

echo -e "${GREEN}📦 Rolling back file movements...${NC}"

# Use grep to find movement entries (lines with MOVED status)
# Then parse the source and target paths

grep -E '^\| `[^`]+` \| `[^`]+` \| [0-9.]+ KB \| MOVED \|' "$AUDIT_LOG" | while IFS='|' read -r _ source_col target_col _; do
    # Extract paths from backticks
    source_path=$(echo "$source_col" | sed -E 's/.*`([^`]+)`.*/\1/')
    target_path=$(echo "$target_col" | sed -E 's/.*`([^`]+)`.*/\1/')

    # Construct full paths
    target_full="${COURSE_DIR}/${target_path}"
    source_full="${COURSE_DIR}/${source_path}"

    # Check if target file exists (the file we moved TO)
    if [ ! -f "$target_full" ]; then
        echo -e "${YELLOW}⚠️  Skipping: ${target_path} (file not found)${NC}"
        echo "- ⚠️ SKIP: ${target_path} → ${source_path} (file not found)" >> "$ROLLBACK_LOG"
        continue
    fi

    # Check if source directory needs to be created
    source_dir=$(dirname "$source_full")
    if [ ! -d "$source_dir" ]; then
        mkdir -p "$source_dir"
    fi

    # Move file back to original location
    if mv "$target_full" "$source_full"; then
        echo -e "${GREEN}✓${NC} ${target_path} → ${source_path}"
        echo "- ✅ MOVED: ${target_path} → ${source_path}" >> "$ROLLBACK_LOG"
        ((files_to_rollback++)) || true
    else
        echo -e "${RED}❌${NC} Failed to move: ${target_path}"
        echo "- ❌ FAILED: ${target_path} → ${source_path}" >> "$ROLLBACK_LOG"
        ((rollback_errors++)) || true
    fi
done

# Remove empty directories created during organization
echo ""
echo -e "${GREEN}🗑️  Cleaning up empty folders...${NC}"

# Remove empty folders in canonical structure (if they're empty)
empty_dirs=(
    "${COURSE_DIR}/sources/other"
    "${COURSE_DIR}/sources/videos"
    "${COURSE_DIR}/sources/transcripts"
    "${COURSE_DIR}/sources"
    "${COURSE_DIR}/resources"
    "${COURSE_DIR}/assessments"
)

for dir in "${empty_dirs[@]}"; do
    if [ -d "$dir" ] && [ -z "$(ls -A "$dir")" ]; then
        rmdir "$dir"
        echo -e "${GREEN}✓${NC} Removed empty: $(basename "$dir")"
        echo "- 🗑️ Removed empty folder: $(basename "$dir")" >> "$ROLLBACK_LOG"
    fi
done

# Summary
echo "" >> "$ROLLBACK_LOG"
echo "---" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"
echo "## Summary" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"
echo "- Files rolled back: ${files_to_rollback}" >> "$ROLLBACK_LOG"
echo "- Errors: ${rollback_errors}" >> "$ROLLBACK_LOG"
echo "" >> "$ROLLBACK_LOG"

# Print summary
echo ""
echo -e "${GREEN}✓ Rollback complete!${NC}"
echo ""
echo "📊 Summary:"
echo "  - Files rolled back: ${files_to_rollback}"
echo "  - Errors: ${rollback_errors}"
echo ""

if [ $rollback_errors -eq 0 ]; then
    echo -e "${GREEN}✅ All files successfully rolled back to original locations.${NC}"
else
    echo -e "${YELLOW}⚠️  Some files could not be rolled back (see details above).${NC}"
fi

echo ""
echo "📋 Rollback log saved: ${ROLLBACK_LOG}"
echo ""

# Archive the original audit log (rename with .rolled-back suffix)
mv "$AUDIT_LOG" "${AUDIT_LOG}.rolled-back"
echo -e "${GREEN}✓${NC} Original audit log archived: ${AUDIT_LOG}.rolled-back"

echo ""
echo -e "${GREEN}Done!${NC}"
