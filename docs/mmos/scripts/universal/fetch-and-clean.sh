#!/bin/bash
# Fetch and Clean - Complete pipeline for downloading and cleaning web content
# Usage: ./fetch-and-clean.sh URL output.md "Title"

if [ $# -lt 2 ]; then
    echo "Usage: $0 URL output.md [title]"
    echo "Example: ./fetch-and-clean.sh https://tim.blog/transcript/ transcript.md 'Tim Ferriss Transcript'"
    exit 1
fi

URL="$1"
OUTPUT="$2"
TITLE="${3:-Content}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="/tmp/fetch_clean_$$"
mkdir -p "$TMP_DIR"

echo "🌐 Fetching: $URL"

# Step 1: Download with curl
curl -s -L "$URL" > "$TMP_DIR/raw.html"

if [ ! -s "$TMP_DIR/raw.html" ]; then
    echo "❌ Download failed or empty"
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "✅ Downloaded: $(wc -c < "$TMP_DIR/raw.html") bytes"

# Step 2: Extract main content
"$SCRIPT_DIR/extract-main-content.sh" "$TMP_DIR/raw.html" "$TMP_DIR/content.html"

if [ $? -ne 0 ]; then
    echo "⚠️  Using raw HTML (extraction failed)"
    cp "$TMP_DIR/raw.html" "$TMP_DIR/content.html"
fi

# Step 3: Clean and convert to Markdown
"$SCRIPT_DIR/clean-html-content.sh" "$TMP_DIR/content.html" "$TMP_DIR/clean.md"

if [ $? -ne 0 ]; then
    echo "❌ Cleaning failed"
    rm -rf "$TMP_DIR"
    exit 1
fi

# Step 4: Add metadata header
cat > "$OUTPUT" << HEADER
# $TITLE

**Source:** $URL
**Downloaded:** $(date +"%Y-%m-%d %H:%M")
**Format:** Markdown (cleaned)

---

HEADER

# Append cleaned content
cat "$TMP_DIR/clean.md" >> "$OUTPUT"

# Add footer
cat >> "$OUTPUT" << FOOTER

---

*Extracted and cleaned from web source*
*Date: $(date +"%Y-%m-%d")*
FOOTER

# Cleanup
rm -rf "$TMP_DIR"

# Final report
final_size=$(wc -c < "$OUTPUT")
final_lines=$(wc -l < "$OUTPUT")

echo ""
echo "✅ COMPLETE: $OUTPUT"
echo "   Size: $final_size bytes"
echo "   Lines: $final_lines"

# Verification
if grep -q '<script\|var gform\|dataLayer' "$OUTPUT"; then
    echo "   ⚠️  WARNING: Still contains JS/HTML - manual review needed"
elif [ $final_size -lt 1000 ]; then
    echo "   ⚠️  WARNING: Very small file - may need manual review"
else
    echo "   ✅ Quality check passed"
fi
