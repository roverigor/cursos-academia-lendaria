#!/bin/bash
#
# migrate-minds-structure.sh
# Migra minds da estrutura antiga para a estrutura v3.0 (artifacts FLAT)
#
# Estrutura antiga:
#   - analysis/, synthesis/, implementation/
#   - README.md, PRD.md, TODO.md, DEPENDENCIES.md na raiz
#
# Estrutura nova (v3.0):
#   - artifacts/ (FLAT - todas as fases)
#   - docs/ (README, PRD, TODO, DEPENDENCIES, logs/, validation/)
#
# Uso:
#   ./scripts/migrate-minds-structure.sh [mind_slug]       # Migra um mind específico
#   ./scripts/migrate-minds-structure.sh --all             # Migra todos os minds pendentes
#   ./scripts/migrate-minds-structure.sh --dry-run [mind]  # Simula migração (não executa)
#

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base directory
BASE_DIR="/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"
MINDS_DIR="$BASE_DIR/outputs/minds"

# Dry-run flag
DRY_RUN=false

# Parse arguments
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    shift
fi

# Function: Print colored messages
print_info() { echo -e "${BLUE}ℹ ${NC}$1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Function: Check if mind needs migration
needs_migration() {
    local mind_path="$1"

    # Check if has old structure folders
    if [[ -d "$mind_path/analysis" ]] || \
       [[ -d "$mind_path/synthesis" ]] || \
       [[ -d "$mind_path/implementation" ]]; then
        return 0  # Needs migration
    fi

    # Check if has root-level docs
    if [[ -f "$mind_path/README.md" ]] || \
       [[ -f "$mind_path/PRD.md" ]] || \
       [[ -f "$mind_path/TODO.md" ]] || \
       [[ -f "$mind_path/DEPENDENCIES.md" ]]; then
        return 0  # Needs migration
    fi

    return 1  # Already migrated
}

# Function: Migrate a single mind
migrate_mind() {
    local mind_slug="$1"
    local mind_path="$MINDS_DIR/$mind_slug"

    # Validate mind exists
    if [[ ! -d "$mind_path" ]]; then
        print_error "Mind not found: $mind_slug"
        return 1
    fi

    # Check if needs migration
    if ! needs_migration "$mind_path"; then
        print_warning "$mind_slug already in v3.0 structure (skipping)"
        return 0
    fi

    print_info "Migrating: $mind_slug"

    # Backup (only if not dry-run)
    local backup_date=$(date +%Y%m%d-%H%M%S)
    local backup_path="${mind_path}_BACKUP_${backup_date}"

    if [[ "$DRY_RUN" == false ]]; then
        cp -r "$mind_path" "$backup_path"
        print_success "Backup created: ${mind_slug}_BACKUP_${backup_date}"
    else
        print_info "[DRY-RUN] Would create backup: ${mind_slug}_BACKUP_${backup_date}"
    fi

    # Create artifacts/ if doesn't exist
    if [[ "$DRY_RUN" == false ]]; then
        mkdir -p "$mind_path/artifacts"
    else
        print_info "[DRY-RUN] Would create: artifacts/"
    fi

    # Migrate analysis/ → artifacts/
    if [[ -d "$mind_path/analysis" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mv "$mind_path/analysis"/* "$mind_path/artifacts/" 2>/dev/null || true
            rmdir "$mind_path/analysis" 2>/dev/null || true
            print_success "Migrated: analysis/ → artifacts/"
        else
            print_info "[DRY-RUN] Would migrate: analysis/ → artifacts/"
        fi
    fi

    # Migrate synthesis/ → artifacts/
    if [[ -d "$mind_path/synthesis" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mv "$mind_path/synthesis"/* "$mind_path/artifacts/" 2>/dev/null || true
            rmdir "$mind_path/synthesis" 2>/dev/null || true
            print_success "Migrated: synthesis/ → artifacts/"
        else
            print_info "[DRY-RUN] Would migrate: synthesis/ → artifacts/"
        fi
    fi

    # Migrate implementation/ → artifacts/
    if [[ -d "$mind_path/implementation" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mv "$mind_path/implementation"/* "$mind_path/artifacts/" 2>/dev/null || true
            rmdir "$mind_path/implementation" 2>/dev/null || true
            print_success "Migrated: implementation/ → artifacts/"
        else
            print_info "[DRY-RUN] Would migrate: implementation/ → artifacts/"
        fi
    fi

    # Create docs/ if doesn't exist (preserve existing docs/)
    if [[ ! -d "$mind_path/docs" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mkdir -p "$mind_path/docs/logs"
            print_success "Created: docs/ and docs/logs/"
        else
            print_info "[DRY-RUN] Would create: docs/ and docs/logs/"
        fi
    fi

    # Migrate root-level docs to docs/
    for doc_file in README.md PRD.md TODO.md DEPENDENCIES.md; do
        if [[ -f "$mind_path/$doc_file" ]]; then
            if [[ "$DRY_RUN" == false ]]; then
                mv "$mind_path/$doc_file" "$mind_path/docs/"
                print_success "Migrated: $doc_file → docs/"
            else
                print_info "[DRY-RUN] Would migrate: $doc_file → docs/"
            fi
        fi
    done

    # Move validation/ to docs/validation/ if exists
    if [[ -d "$mind_path/validation" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mv "$mind_path/validation" "$mind_path/docs/"
            print_success "Migrated: validation/ → docs/validation/"
        else
            print_info "[DRY-RUN] Would migrate: validation/ → docs/validation/"
        fi
    fi

    # Validate final structure
    if [[ "$DRY_RUN" == false ]]; then
        print_info "Final structure:"
        ls -1 "$mind_path" | sed 's/^/  /'
        print_success "Migration complete: $mind_slug"
    else
        print_info "[DRY-RUN] Migration simulation complete: $mind_slug"
    fi

    echo ""
}

# Function: Get list of minds needing migration
get_pending_minds() {
    local pending=()

    for mind_path in "$MINDS_DIR"/*/; do
        if [[ -d "$mind_path" ]]; then
            local mind_slug=$(basename "$mind_path")

            # Skip backups
            if [[ "$mind_slug" == *"_BACKUP_"* ]]; then
                continue
            fi

            if needs_migration "$mind_path"; then
                pending+=("$mind_slug")
            fi
        fi
    done

    echo "${pending[@]}"
}

# Main logic
main() {
    cd "$BASE_DIR"

    print_info "=== MMOS Mind Structure Migration v3.0 ==="
    echo ""

    if [[ "$DRY_RUN" == true ]]; then
        print_warning "DRY-RUN MODE (no changes will be made)"
        echo ""
    fi

    # Handle --all flag
    if [[ "$1" == "--all" ]]; then
        pending_minds=($(get_pending_minds))

        if [[ ${#pending_minds[@]} -eq 0 ]]; then
            print_success "All minds already in v3.0 structure!"
            exit 0
        fi

        print_info "Found ${#pending_minds[@]} minds needing migration:"
        for mind in "${pending_minds[@]}"; do
            echo "  - $mind"
        done
        echo ""

        if [[ "$DRY_RUN" == false ]]; then
            read -p "Proceed with migration? (y/N) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_warning "Migration cancelled"
                exit 0
            fi
        fi

        # Migrate all
        for mind in "${pending_minds[@]}"; do
            migrate_mind "$mind"
        done

        print_success "All migrations complete!"

    # Handle single mind
    elif [[ -n "$1" ]]; then
        migrate_mind "$1"

    # No arguments - show help
    else
        echo "Usage:"
        echo "  $0 [mind_slug]               # Migrate specific mind"
        echo "  $0 --all                     # Migrate all pending minds"
        echo "  $0 --dry-run [mind_slug]     # Simulate migration"
        echo "  $0 --dry-run --all           # Simulate all migrations"
        echo ""
        echo "Minds needing migration:"
        pending_minds=($(get_pending_minds))
        if [[ ${#pending_minds[@]} -eq 0 ]]; then
            print_success "  None! All minds are in v3.0 structure"
        else
            for mind in "${pending_minds[@]}"; do
                echo "  - $mind"
            done
        fi
    fi
}

# Run
main "$@"
