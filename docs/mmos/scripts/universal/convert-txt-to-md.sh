#!/bin/bash
# Script: Convert TXT to Markdown with proper formatting
# Usage: ./convert-txt-to-md.sh [file.txt] OR ./convert-txt-to-md.sh [directory]
# Auto-converts all .txt files in sources/ if no argument provided

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

convert_file() {
    local txt_file="$1"
    local md_file="${txt_file%.txt}.md"

    # Skip if already .md
    if [[ "$txt_file" == *.md ]]; then
        echo "⏭️  Skipping (already .md): $txt_file"
        return
    fi

    # Skip if .md already exists
    if [[ -f "$md_file" ]]; then
        echo "⚠️  MD exists, skipping: $md_file"
        return
    fi

    echo "🔄 Converting: $(basename "$txt_file") → $(basename "$md_file")"

    # Extract filename for title (without extension)
    local title=$(basename "$txt_file" .txt | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1')

    # Create MD with header
    cat > "$md_file" << HEADER
# $title

**Source:** $(basename "$txt_file")
**Converted:** $(date +"%Y-%m-%d %H:%M")
**Format:** Markdown
**Original:** TXT

---

HEADER

    # Append original content
    cat "$txt_file" >> "$md_file"

    # Add footer
    cat >> "$md_file" << FOOTER

---

*Converted from TXT to Markdown*
*Original: $(basename "$txt_file")*
*Date: $(date +"%Y-%m-%d")*
FOOTER

    echo "✅ Created: $(basename "$md_file")"

    # Remove original .txt
    rm "$txt_file"
    echo "🗑️  Removed: $(basename "$txt_file")"
}

# Main execution
if [ $# -eq 0 ]; then
    # No arguments - convert all .txt in minds/*/sources/
    echo "🔍 Searching for .txt files in all minds/*/sources/..."
    find "$PROJECT_ROOT/minds" -path "*/sources/*" -type f -name "*.txt" | while read file; do
        convert_file "$file"
    done
elif [ -d "$1" ]; then
    # Directory provided
    echo "🔍 Searching for .txt files in: $1"
    find "$1" -type f -name "*.txt" | while read file; do
        convert_file "$file"
    done
elif [ -f "$1" ]; then
    # Single file provided
    convert_file "$1"
else
    echo "❌ Error: '$1' not found"
    exit 1
fi

# Summary
echo ""
echo "=== CONVERSION SUMMARY ==="
TXT_COUNT=$(find "$PROJECT_ROOT/minds" -path "*/sources/*" -type f -name "*.txt" 2>/dev/null | wc -l | tr -d ' ')
MD_COUNT=$(find "$PROJECT_ROOT/minds" -path "*/sources/*" -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "Remaining TXT files: $TXT_COUNT"
echo "Total MD files: $MD_COUNT"
echo "✅ Conversion complete"
