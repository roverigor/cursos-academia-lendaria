#!/bin/bash
#
# Orchestration script for Story 3.1 - Backward Compatible Additions
# Runs all migration scripts in sequence for a single mind or all minds.
#
# Usage:
#   bash migrate_story_3.1.sh <mind_directory>       # Single mind
#   bash migrate_story_3.1.sh --all                  # All minds
#   bash migrate_story_3.1.sh --dry-run sam_altman   # Dry run mode
#

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging
log_section() {
    echo ""
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}=========================================${NC}"
    echo ""
}

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MINDS_DIR="docs/minds"
DRY_RUN=false
LOG_FILE="docs/mmos/logs/migration_story_3.1_$(date +%Y%m%d_%H%M%S).log"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    log_error "python3 is required but not installed"
    exit 1
fi

# Help message
show_help() {
    echo "Usage: bash migrate_story_3.1.sh [OPTIONS] <mind_directory>"
    echo ""
    echo "Options:"
    echo "  --all          Migrate all minds in $MINDS_DIR"
    echo "  --dry-run      Show what would be done without executing"
    echo "  --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  bash migrate_story_3.1.sh outputs/minds/sam_altman"
    echo "  bash migrate_story_3.1.sh --all"
    echo "  bash migrate_story_3.1.sh --dry-run sam_altman"
    exit 0
}

# Parse arguments
MIGRATE_ALL=false
MIND_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            MIGRATE_ALL=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            if [ -z "$MIND_DIR" ]; then
                MIND_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [ "$MIGRATE_ALL" = false ] && [ -z "$MIND_DIR" ]; then
    log_error "No mind directory specified"
    echo "Use --all to migrate all minds, or specify a mind directory"
    echo "Run with --help for usage information"
    exit 1
fi

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

# Migration function for single mind
migrate_mind() {
    local mind_path="$1"
    local mind_name=$(basename "$mind_path")

    log_section "Migrating: $mind_name"

    echo "Mind directory: $mind_path" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    if [ ! -d "$mind_path" ]; then
        log_error "Directory not found: $mind_path"
        return 1
    fi

    local start_time=$(date +%s)

    # Step 1: Extract metadata
    echo "Step 1/5: Extracting metadata..." | tee -a "$LOG_FILE"
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] Would run: python3 extract_metadata.py $mind_path"
    else
        python3 "$SCRIPT_DIR/extract_metadata.py" "$mind_path" 2>&1 | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"

    # Step 2: Catalog sources
    echo "Step 2/5: Cataloging sources..." | tee -a "$LOG_FILE"
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] Would run: python3 catalog_sources.py $mind_path"
    else
        python3 "$SCRIPT_DIR/catalog_sources.py" "$mind_path" 2>&1 | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"

    # Step 3: Infer pipeline progress
    echo "Step 3/5: Inferring pipeline progress..." | tee -a "$LOG_FILE"
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] Would run: python3 infer_progress.py $mind_path"
    else
        python3 "$SCRIPT_DIR/infer_progress.py" "$mind_path" 2>&1 | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"

    # Step 4: Initialize ETL questions
    echo "Step 4/5: Initializing ETL questions..." | tee -a "$LOG_FILE"
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] Would run: python3 init_etl_questions.py $mind_path"
    else
        python3 "$SCRIPT_DIR/init_etl_questions.py" "$mind_path" 2>&1 | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"

    # Step 5: Version system prompts
    echo "Step 5/5: Versioning system prompts..." | tee -a "$LOG_FILE"
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] Would run: bash version_prompts.sh $mind_path"
    else
        bash "$SCRIPT_DIR/version_prompts.sh" "$mind_path" 2>&1 | tee -a "$LOG_FILE"
    fi
    echo "" | tee -a "$LOG_FILE"

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    if [ "$DRY_RUN" = false ]; then
        log_info "Completed $mind_name in ${duration}s"
    else
        log_info "[DRY RUN] Would complete $mind_name"
    fi

    return 0
}

# Main execution
log_section "Story 3.1 Migration - Backward Compatible Additions"

if [ "$DRY_RUN" = true ]; then
    log_warning "DRY RUN MODE - No changes will be made"
    echo ""
fi

echo "Started: $(date)" | tee "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

TOTAL_MINDS=0
SUCCESS_COUNT=0
FAILED_COUNT=0

if [ "$MIGRATE_ALL" = true ]; then
    echo "Migrating all minds in $MINDS_DIR" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    # Count minds
    MIND_DIRS=$(find "$MINDS_DIR" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort)
    TOTAL_MINDS=$(echo "$MIND_DIRS" | wc -l | tr -d ' ')

    echo "Found $TOTAL_MINDS minds to migrate" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"

    # Migrate each mind
    while IFS= read -r mind_path; do
        if [ -z "$mind_path" ]; then
            continue
        fi

        if migrate_mind "$mind_path"; then
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        else
            FAILED_COUNT=$((FAILED_COUNT + 1))
            log_error "Failed to migrate $(basename "$mind_path")"
        fi

        echo "" | tee -a "$LOG_FILE"
    done <<< "$MIND_DIRS"

else
    # Single mind migration
    TOTAL_MINDS=1

    if migrate_mind "$MIND_DIR"; then
        SUCCESS_COUNT=1
    else
        FAILED_COUNT=1
    fi
fi

# Final summary
log_section "Migration Summary"

echo "Total minds: $TOTAL_MINDS" | tee -a "$LOG_FILE"
echo "Success: $SUCCESS_COUNT" | tee -a "$LOG_FILE"
echo "Failed: $FAILED_COUNT" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Completed: $(date)" | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

if [ $FAILED_COUNT -eq 0 ]; then
    if [ "$DRY_RUN" = false ]; then
        log_info "✅ All migrations completed successfully!"
        echo ""
        echo "Generated files per mind:"
        echo "  - metadata.yaml"
        echo "  - sources/sources_master.yaml"
        echo "  - docs/pipeline_progress.yaml"
        echo "  - kb/etl_questions.yaml"
        echo "  - system_prompts/generalista/v1.0.0.md (if prompts exist)"
        echo ""
        echo "Next steps:"
        echo "  1. Review flagged fields (apex_score, icp_match)"
        echo "  2. Review source priorities and layer_relevance"
        echo "  3. Run validation: npm run validate:minds && npm run validate:sources"
        echo "  4. Commit changes: git add . && git commit -m 'feat: Story 3.1 migration complete'"
    else
        log_info "✅ Dry run completed - no changes made"
    fi
    exit 0
else
    log_error "❌ $FAILED_COUNT migration(s) failed"
    log_warning "Check log file for details: $LOG_FILE"
    exit 1
fi
