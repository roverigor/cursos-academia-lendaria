#!/bin/bash
# ============================================================================
# AIOS IDE Sync Script
# ============================================================================
# Automatically syncs agents, tasks, checklists, and workflows from expansion
# packs to IDE-specific directories (.claude, .cursor, .windsurf, etc.)
#
# Usage:
#   ./sync-to-ides.sh [--dry-run] [--verbose] [--ide=claude]
#
# Version: 1.0.0
# ============================================================================

set -uo pipefail
# Note: Not using -e to avoid silent failures on non-critical errors

# ============================================================================
# CONFIGURATION
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CONFIG_FILE="$PROJECT_ROOT/.aios-sync.yaml"
LOG_FILE="$PROJECT_ROOT/.aios-sync.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Flags
DRY_RUN=false
VERBOSE=false
SPECIFIC_IDE=""
SYNC_COUNT=0
ERROR_COUNT=0
SKIP_COUNT=0

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"

    case $level in
        INFO)
            echo -e "${BLUE}ℹ${NC}  $message"
            ;;
        SUCCESS)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        WARN)
            echo -e "${YELLOW}⚠${NC}  $message"
            ;;
        ERROR)
            echo -e "${RED}✗${NC} $message"
            ;;
        DEBUG)
            if [ "$VERBOSE" = true ]; then
                echo -e "${CYAN}→${NC} $message"
            fi
            ;;
    esac
}

check_dependencies() {
    log DEBUG "Checking dependencies..."

    if ! command -v yq &> /dev/null; then
        log ERROR "yq is required but not installed"
        log ERROR "Install with: brew install yq (macOS)"
        exit 1
    fi

    if [ ! -f "$CONFIG_FILE" ]; then
        log ERROR "Config file not found: $CONFIG_FILE"
        exit 1
    fi

    log DEBUG "Dependencies OK"
}

get_active_ides() {
    yq eval '.active_ides[]' "$CONFIG_FILE"
}

get_pack_alias() {
    local pack_dir_name=$1
    local alias=$(yq eval ".pack_aliases.\"$pack_dir_name\"" "$CONFIG_FILE")

    # If no alias found, use directory name as-is
    if [ "$alias" = "null" ] || [ -z "$alias" ]; then
        echo "$pack_dir_name"
    else
        echo "$alias"
    fi
}

is_ide_active() {
    local ide=$1
    local active_ides=$(get_active_ides)

    echo "$active_ides" | grep -q "^$ide$"
}

should_sync_ide() {
    local ide=$1

    # If specific IDE requested, only sync that one
    if [ -n "$SPECIFIC_IDE" ]; then
        [ "$ide" = "$SPECIFIC_IDE" ] && return 0 || return 1
    fi

    # Otherwise check if IDE is active
    is_ide_active "$ide"
}

extract_description() {
    local file=$1
    local description=""

    # Try to extract from agent YAML block
    if grep -q "^agent:" "$file"; then
        description=$(yq eval '.agent.title // .agent.name // ""' "$file" 2>/dev/null || echo "")
    fi

    # Fallback to filename
    if [ -z "$description" ]; then
        description=$(basename "$file" .md | tr '-' ' ' | sed 's/\b\(.\)/\u\1/g')
    fi

    echo "$description"
}

apply_wrapper() {
    local content=$1
    local wrapper_type=$2
    local filename=$3
    local description=$4

    case $wrapper_type in
        slash-command)
            cat <<EOF
# /${filename%.md} Command

When this command is used, adopt the following agent persona:

$content
EOF
            ;;
        cursor-rule)
            cat <<EOF
---
description: $description
globs: []
alwaysApply: false
---

$content
EOF
            ;;
        none|*)
            echo "$content"
            ;;
    esac
}

sync_file() {
    local source_file=$1
    local dest_file=$2
    local wrapper_type=$3
    local dest_format=$4

    log DEBUG "Syncing: $source_file → $dest_file"

    # Create destination directory
    local dest_dir=$(dirname "$dest_file")
    if [ ! -d "$dest_dir" ]; then
        if [ "$DRY_RUN" = false ]; then
            mkdir -p "$dest_dir"
            log DEBUG "Created directory: $dest_dir"
        else
            log DEBUG "[DRY-RUN] Would create: $dest_dir"
        fi
    fi

    # Read source content
    local content=$(cat "$source_file")
    local filename=$(basename "$source_file")
    local description=$(extract_description "$source_file")

    # Apply wrapper
    local wrapped_content=$(apply_wrapper "$content" "$wrapper_type" "$filename" "$description")

    # Change extension if needed
    if [ "$dest_format" = "mdc" ]; then
        dest_file="${dest_file%.md}.mdc"
    fi

    # Backup if file exists
    if [ -f "$dest_file" ] && [ "$DRY_RUN" = false ]; then
        cp "$dest_file" "$dest_file.bak"
        log DEBUG "Created backup: $dest_file.bak"
    fi

    # Write file
    if [ "$DRY_RUN" = false ]; then
        echo "$wrapped_content" > "$dest_file"
        log SUCCESS "Synced: $(basename "$dest_file")"
        ((SYNC_COUNT++))
    else
        log INFO "[DRY-RUN] Would sync: $(basename "$dest_file")"
    fi
}

sync_mapping() {
    local mapping_name=$1

    log INFO "Processing: $mapping_name"

    # Get source path pattern (relative to project root)
    local source_pattern=$(yq eval ".sync_mappings.$mapping_name.source" "$CONFIG_FILE")

    # Check if source is a glob pattern
    if [[ "$source_pattern" == *"*"* ]]; then
        # Glob pattern - expand it natively with bash (handles spaces correctly)
        local source_dirs_array=()
        shopt -s nullglob  # Make glob return empty if no match
        # CRITICAL: Construct glob with quoted PROJECT_ROOT to handle spaces
        for dir in "$PROJECT_ROOT"/$source_pattern; do
            if [ -d "$dir" ]; then
                source_dirs_array+=("$dir")
            fi
        done
        shopt -u nullglob

        if [ ${#source_dirs_array[@]} -eq 0 ]; then
            log WARN "No directories match pattern: $PROJECT_ROOT/$source_pattern"
            ((SKIP_COUNT++))
            return
        fi

        log DEBUG "Found ${#source_dirs_array[@]} directories matching pattern"
    else
        # Single directory
        local source_path="$PROJECT_ROOT/$source_pattern"
        if [ ! -d "$source_path" ]; then
            log WARN "Source not found: $source_path"
            ((SKIP_COUNT++))
            return
        fi
        local source_dirs_array=("$source_path")
    fi

    # Get destination configurations for each IDE
    for ide in $(get_active_ides); do
        if ! should_sync_ide "$ide"; then
            log DEBUG "Skipping IDE: $ide (not active for this sync)"
            continue
        fi

        log DEBUG "Processing IDE: $ide"

        # Check if mapping exists for this IDE
        local dest_count=$(yq eval ".sync_mappings.$mapping_name.destinations.$ide | length" "$CONFIG_FILE")
        if [ "$dest_count" = "0" ] || [ "$dest_count" = "null" ]; then
            log DEBUG "No destination configured for $ide in $mapping_name"
            continue
        fi

        # Process each destination
        local dest_index=0
        while [ $dest_index -lt $dest_count ]; do
            local dest_path=$(yq eval ".sync_mappings.$mapping_name.destinations.$ide[$dest_index].path" "$CONFIG_FILE")
            local dest_format=$(yq eval ".sync_mappings.$mapping_name.destinations.$ide[$dest_index].format" "$CONFIG_FILE")
            local wrapper_type=$(yq eval ".sync_mappings.$mapping_name.destinations.$ide[$dest_index].wrapper" "$CONFIG_FILE")

            dest_path="$PROJECT_ROOT/$dest_path"

            log DEBUG "Destination template: $dest_path (format: $dest_format, wrapper: $wrapper_type)"

            # Sync all files from source to destination
            for source_dir in "${source_dirs_array[@]}"; do
                if [ ! -d "$source_dir" ]; then
                    log DEBUG "Source directory not found: $source_dir"
                    continue
                fi

                # Extract pack directory name from source path (e.g., expansion-packs/super-agentes/agents/ -> super-agentes)
                local pack_dir_name=$(echo "$source_dir" | sed -E 's|.*/expansion-packs/([^/]+)/.*|\1|')
                log DEBUG "Pack directory name: $pack_dir_name"

                # Get pack alias (e.g., super-agentes -> SA)
                local pack_alias=$(get_pack_alias "$pack_dir_name")
                log DEBUG "Pack alias: $pack_alias"

                # Replace {pack} placeholder in destination path with alias
                local actual_dest_path="${dest_path//\{pack\}/$pack_alias}"

                log DEBUG "Scanning directory: $source_dir"
                log DEBUG "Destination: $actual_dest_path"

                # Find all .md files in source (using simpler approach)
                for source_file in "$source_dir"/*.md; do
                    # Skip if no files match
                    if [ ! -f "$source_file" ]; then
                        log DEBUG "No .md files in: $source_dir"
                        continue
                    fi

                    local filename=$(basename "$source_file")

                    # Skip excluded files
                    if [[ "$filename" == "README.md" ]] || [[ "$filename" == *".test.md" ]]; then
                        log DEBUG "Skipping excluded file: $filename"
                        continue
                    fi

                    local dest_file="$actual_dest_path/$filename"

                    sync_file "$source_file" "$dest_file" "$wrapper_type" "$dest_format"
                done
            done

            ((dest_index++))
        done
    done
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    # Parse arguments
    for arg in "$@"; do
        case $arg in
            --dry-run)
                DRY_RUN=true
                ;;
            --verbose|-v)
                VERBOSE=true
                ;;
            --ide=*)
                SPECIFIC_IDE="${arg#*=}"
                ;;
            --help|-h)
                cat <<EOF
AIOS IDE Sync Script

Usage: $0 [OPTIONS]

Options:
  --dry-run         Show what would be synced without making changes
  --verbose, -v     Show detailed debug information
  --ide=NAME        Sync only to specific IDE (claude, cursor, windsurf, etc.)
  --help, -h        Show this help message

Examples:
  $0                          # Sync to all active IDEs
  $0 --dry-run                # Preview sync operations
  $0 --ide=claude             # Sync only to Claude Code
  $0 --verbose --dry-run      # Verbose preview

EOF
                exit 0
                ;;
            *)
                log ERROR "Unknown option: $arg"
                log INFO "Use --help for usage information"
                exit 1
                ;;
        esac
    done

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  AIOS IDE Sync"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ "$DRY_RUN" = true ]; then
        log WARN "DRY-RUN MODE: No files will be modified"
    fi

    if [ -n "$SPECIFIC_IDE" ]; then
        log INFO "Syncing only to: $SPECIFIC_IDE"
    fi

    # Check dependencies
    check_dependencies

    # Initialize log
    if [ "$DRY_RUN" = false ]; then
        echo "# AIOS Sync Log - $(date)" >> "$LOG_FILE"
    fi

    # Get all mapping names
    local mappings=$(yq eval '.sync_mappings | keys | .[]' "$CONFIG_FILE")

    # Sync each mapping
    for mapping in $mappings; do
        sync_mapping "$mapping"
    done

    # Summary
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log SUCCESS "Sync complete!"
    log INFO "Files synced: $SYNC_COUNT"
    if [ $ERROR_COUNT -gt 0 ]; then
        log WARN "Errors: $ERROR_COUNT"
    fi
    if [ $SKIP_COUNT -gt 0 ]; then
        log INFO "Skipped: $SKIP_COUNT"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ "$DRY_RUN" = false ]; then
        log INFO "Log file: $LOG_FILE"
    fi
}

# Run main function
main "$@"
