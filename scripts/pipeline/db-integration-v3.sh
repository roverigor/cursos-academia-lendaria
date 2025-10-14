#!/bin/bash
# MMOS Pipeline → Database v3.0.0 Integration
# Collects data and populates database in real-time

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/../.."
DB_PATH="$PROJECT_ROOT/docs/mmos/mmos.db"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Parse arguments
MIND_SLUG=""
MODE="full" # full, sources-only, analysis-only
REPROCESS_MODE="skip" # skip, update, fresh

while [[ $# -gt 0 ]]; do
    case $1 in
        --mind)
            MIND_SLUG="$2"
            shift 2
            ;;
        --mode)
            MODE="$2"
            shift 2
            ;;
        --reprocess)
            REPROCESS_MODE="$2"
            shift 2
            ;;
        *)
            log_error "Unknown option: $1"
            echo "Usage: $0 --mind <slug> [--mode full|sources-only|analysis-only] [--reprocess skip|update|fresh]"
            exit 1
            ;;
    esac
done

if [ -z "$MIND_SLUG" ]; then
    log_error "Missing required argument: --mind"
    echo "Usage: $0 --mind <slug> [--mode full|sources-only|analysis-only]"
    exit 1
fi

MIND_DIR="$PROJECT_ROOT/docs/minds/$MIND_SLUG"

if [ ! -d "$MIND_DIR" ]; then
    log_error "Mind directory not found: $MIND_DIR"
    exit 1
fi

log_info "Starting database integration for: $MIND_SLUG"
log_info "Mode: $MODE"
log_info "Reprocess mode: $REPROCESS_MODE"
echo ""

# Get mind_id from database
MIND_ID=$(sqlite3 "$DB_PATH" "SELECT id FROM minds WHERE slug = '$MIND_SLUG';")

if [ -z "$MIND_ID" ]; then
    log_error "Mind not found in database: $MIND_SLUG"
    exit 1
fi

log_success "Found mind in database (ID: $MIND_ID)"
echo ""

# ═══════════════════════════════════════════════════════════
# PHASE 1: Sources Population
# ═══════════════════════════════════════════════════════════

if [ "$MODE" = "full" ] || [ "$MODE" = "sources-only" ]; then
    log_info "Phase 1: Populating sources..."

    SOURCES_MASTER="$MIND_DIR/sources/sources_master.yaml"

    if [ -f "$SOURCES_MASTER" ]; then
        # Call Node.js script to parse YAML and insert sources
        node "$SCRIPT_DIR/populate-sources.js" \
            --mind "$MIND_SLUG" \
            --file "$SOURCES_MASTER" \
            --db "$DB_PATH" \
            --mode "$REPROCESS_MODE"

        log_success "Sources populated successfully"
    else
        log_warning "sources_master.yaml not found, skipping sources"
    fi

    echo ""
fi

# ═══════════════════════════════════════════════════════════
# PHASE 2: Analysis Import
# ═══════════════════════════════════════════════════════════

if [ "$MODE" = "full" ] || [ "$MODE" = "analysis-only" ]; then
    log_info "Phase 2: Importing DNA Mental™ analysis..."

    COGNITIVE_SPEC="$MIND_DIR/analysis/cognitive-spec.yaml"

    if [ -f "$COGNITIVE_SPEC" ]; then
        # Import full cognitive spec as analysis
        node "$SCRIPT_DIR/import-analysis.js" \
            --mind "$MIND_SLUG" \
            --file "$COGNITIVE_SPEC" \
            --db "$DB_PATH" \
            --mode "$REPROCESS_MODE"

        log_success "Analysis imported successfully"
    else
        log_warning "cognitive-spec.yaml not found, skipping analysis import"
    fi

    echo ""
fi

# ═══════════════════════════════════════════════════════════
# PHASE 3: Fragments Extraction (BLOCKED - Needs InnerLens)
# ═══════════════════════════════════════════════════════════

if [ "$MODE" = "full" ] || [ "$MODE" = "analysis-only" ]; then
    log_info "Phase 3: Extracting fragments..."
    log_warning "Fragment extraction requires InnerLens expansion pack (Epic TBD)"
    log_warning "Skipping fragments extraction for now"
    echo ""
fi

# ═══════════════════════════════════════════════════════════
# PHASE 4: Proficiency Scoring (FUTURE)
# ═══════════════════════════════════════════════════════════

# TODO: Implement score-proficiencies.js module
# if [ "$MODE" = "full" ] || [ "$MODE" = "analysis-only" ]; then
#     log_info "Phase 4: Scoring proficiencies..."
#     node "$SCRIPT_DIR/score-proficiencies.js" \
#         --mind "$MIND_SLUG" \
#         --cognitive-spec "$COGNITIVE_SPEC" \
#         --db "$DB_PATH"
# fi

# ═══════════════════════════════════════════════════════════
# PHASE 5: Fragment Tags Generation (FUTURE)
# ═══════════════════════════════════════════════════════════

# TODO: Implement generate-tags.js module
# if [ "$MODE" = "full" ] || [ "$MODE" = "analysis-only" ]; then
#     log_info "Phase 5: Generating fragment tags..."
#     node "$SCRIPT_DIR/generate-tags.js" \
#         --mind "$MIND_SLUG" \
#         --db "$DB_PATH"
# fi

# ═══════════════════════════════════════════════════════════
# VALIDATION
# ═══════════════════════════════════════════════════════════

log_info "Validating integration..."
echo ""

# Run validation module
node "$SCRIPT_DIR/validate-integration.js" \
    --mind "$MIND_SLUG" \
    --db "$DB_PATH"

VALIDATION_EXIT_CODE=$?

if [ $VALIDATION_EXIT_CODE -eq 0 ]; then
    log_success "Database integration complete for: $MIND_SLUG"
    exit 0
else
    log_error "Validation failed for: $MIND_SLUG"
    exit 1
fi
