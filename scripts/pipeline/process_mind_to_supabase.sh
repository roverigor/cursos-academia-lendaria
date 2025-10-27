#!/bin/bash
# ==============================================================================
# Process Mind → Supabase Pipeline
# ==============================================================================
# Complete pipeline: Sources → MIUs → Supabase → Embeddings
#
# Usage:
#   ./process_mind_to_supabase.sh alan_nicolas "Alan Nicolas" self_analysis
#
# ==============================================================================

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ==============================================================================
# CONFIGURATION
# ==============================================================================

MIND_SLUG="$1"
DISPLAY_NAME="$2"
SOURCE_TYPE="${3:-self_analysis}"

if [ -z "$MIND_SLUG" ]; then
    echo -e "${RED}❌ Error: Mind slug required${NC}"
    echo "Usage: $0 <mind_slug> <display_name> [source_type]"
    echo "Example: $0 alan_nicolas \"Alan Nicolas\" self_analysis"
    exit 1
fi

if [ -z "$DISPLAY_NAME" ]; then
    DISPLAY_NAME=$(echo "$MIND_SLUG" | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')
fi

# Paths
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MINDS_DIR="$PROJECT_ROOT/outputs/minds"
MIND_DIR="$MINDS_DIR/$MIND_SLUG"
SOURCES_DIR="$MIND_DIR/sources"
TEMP_DIR="$PROJECT_ROOT/temp"
INNERLENS_DIR="$PROJECT_ROOT/expansion-packs/innerlens"

# Output files
FRAGMENTS_JSON="$TEMP_DIR/${MIND_SLUG}_fragments.json"
SOURCE_TEXT="$TEMP_DIR/${MIND_SLUG}_source.txt"

# Create temp dir
mkdir -p "$TEMP_DIR"

echo -e "${BLUE}🚀 MMOS → Supabase Pipeline${NC}"
echo -e "${BLUE}================================${NC}\n"
echo "Mind: $DISPLAY_NAME ($MIND_SLUG)"
echo "Source Type: $SOURCE_TYPE"
echo "Mind Directory: $MIND_DIR"
echo ""

# ==============================================================================
# STEP 1: Prepare Source Text
# ==============================================================================

echo -e "${YELLOW}📄 Step 1/4: Preparing source text...${NC}"

if [ ! -d "$SOURCES_DIR" ]; then
    echo -e "${RED}❌ Error: Sources directory not found: $SOURCES_DIR${NC}"
    exit 1
fi

# Concatenate all text sources into one file
echo "Collecting text sources from $SOURCES_DIR..."

# Find .txt and .md files
find "$SOURCES_DIR" -type f \( -name "*.txt" -o -name "*.md" \) -print0 | \
    xargs -0 cat > "$SOURCE_TEXT" 2>/dev/null || true

if [ ! -s "$SOURCE_TEXT" ]; then
    echo -e "${RED}❌ Error: No source text found or file is empty${NC}"
    exit 1
fi

WORD_COUNT=$(wc -w < "$SOURCE_TEXT" | tr -d ' ')
echo -e "${GREEN}✅ Prepared source text: $WORD_COUNT words${NC}\n"

# ==============================================================================
# STEP 2: Extract MIUs with InnerLens
# ==============================================================================

echo -e "${YELLOW}🧠 Step 2/4: Extracting MIUs with InnerLens...${NC}"

cd "$INNERLENS_DIR"

# Check if Python script exists
if [ ! -f "scripts/extract_mius_llm.py" ]; then
    echo -e "${RED}❌ Error: InnerLens extraction script not found${NC}"
    exit 1
fi

# Run extraction
python3 scripts/extract_mius_llm.py \
    --input "$SOURCE_TEXT" \
    --output "$FRAGMENTS_JSON" \
    --subject-id "$MIND_SLUG" || {
    echo -e "${RED}❌ Error: MIU extraction failed${NC}"
    exit 1
}

# Verify output
if [ ! -f "$FRAGMENTS_JSON" ]; then
    echo -e "${RED}❌ Error: Fragments JSON not created${NC}"
    exit 1
fi

FRAGMENT_COUNT=$(jq '.fragments | length' "$FRAGMENTS_JSON")
echo -e "${GREEN}✅ Extracted $FRAGMENT_COUNT MIUs${NC}\n"

# ==============================================================================
# STEP 3: Save to Supabase
# ==============================================================================

echo -e "${YELLOW}💾 Step 3/4: Saving to Supabase...${NC}"

cd "$PROJECT_ROOT"

# Check environment
source .env
if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}❌ Error: SUPABASE_DB_URL not set in .env${NC}"
    exit 1
fi

# Run Supabase saver
python3 expansion-packs/innerlens/scripts/save_fragments_to_supabase.py \
    --mind "$MIND_SLUG" \
    --fragments "$FRAGMENTS_JSON" \
    --source "$SOURCE_TEXT" \
    --title "InnerLens Extraction $(date +%Y-%m-%d)" \
    --type "$SOURCE_TYPE" \
    --display-name "$DISPLAY_NAME" || {
    echo -e "${RED}❌ Error: Failed to save to Supabase${NC}"
    exit 1
}

echo -e "${GREEN}✅ Saved to Supabase${NC}\n"

# ==============================================================================
# STEP 4: Generate Embeddings
# ==============================================================================

echo -e "${YELLOW}🤖 Step 4/4: Generating embeddings...${NC}"

# Check OpenAI API key
if [ -z "$OPENAI_API_KEY" ]; then
    echo -e "${RED}❌ Error: OPENAI_API_KEY not set in .env${NC}"
    exit 1
fi

# Generate embeddings (only for this mind's new fragments)
node scripts/database/generate_embeddings.js || {
    echo -e "${YELLOW}⚠️  Warning: Embedding generation failed or incomplete${NC}"
    echo "You can run it manually later:"
    echo "  node scripts/database/generate_embeddings.js"
}

echo -e "${GREEN}✅ Embeddings generated${NC}\n"

# ==============================================================================
# SUMMARY
# ==============================================================================

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Pipeline Complete!${NC}"
echo -e "${GREEN}================================${NC}\n"

echo "📊 Summary:"
echo "  Mind: $DISPLAY_NAME"
echo "  Slug: $MIND_SLUG"
echo "  Source words: $WORD_COUNT"
echo "  Fragments extracted: $FRAGMENT_COUNT"
echo "  Saved to: Supabase fragments table"
echo ""

echo "💡 Next steps:"
echo "  1. Verify in Supabase:"
echo "     SELECT COUNT(*) FROM fragments WHERE mind_id = (SELECT id FROM minds WHERE slug = '$MIND_SLUG');"
echo ""
echo "  2. Test RAG search:"
echo "     node scripts/database/test_rag_search.js"
echo ""
echo "  3. Clean up temp files:"
echo "     rm -rf $TEMP_DIR"
echo ""

# ==============================================================================
# CLEANUP (optional)
# ==============================================================================

read -p "Remove temp files? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$TEMP_DIR"
    echo -e "${GREEN}✅ Temp files removed${NC}"
fi

echo -e "\n${BLUE}🎉 Done!${NC}\n"
