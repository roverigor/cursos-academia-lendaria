#!/bin/bash
# Clean HTML Content - Universal content extraction and cleaning
# Usage: ./clean-html-content.sh input.html output.md

if [ $# -lt 2 ]; then
    echo "Usage: $0 input.html output.md"
    exit 1
fi

input="$1"
output="$2"

if [ ! -f "$input" ]; then
    echo "❌ Error: Input file not found: $input"
    exit 1
fi

# Step 1: Extract main content (remove scripts, styles, navigation)
extract_main_content() {
    # Process from stdin, not as argument (fixes "File name too long")
    sed '/<script/,/<\/script>/d' | \
    sed '/<style/,/<\/style>/d' | \
    sed '/<nav/,/<\/nav>/d' | \
    sed '/<header/,/<\/header>/d' | \
    sed '/<footer/,/<\/footer>/d' | \
    sed '/<aside/,/<\/aside>/d' | \
    sed '/var gform/d' | \
    sed '/var dataLayer/d' | \
    sed '/var gtm4wp/d' | \
    sed '/var _vwo/d' | \
    sed '/@context.*schema\.org/d' | \
    sed '/{"@type":/d' | \
    sed '/window\./d' | \
    sed '/function(/d'
}

# Step 2: Convert HTML to Markdown
html_to_markdown() {
    # Process from stdin
    # Headers
    sed 's/<h1[^>]*>/\n# /g' | \
    sed 's/<\/h1>//g' | \
    sed 's/<h2[^>]*>/\n## /g' | \
    sed 's/<\/h2>//g' | \
    sed 's/<h3[^>]*>/\n### /g' | \
    sed 's/<\/h3>//g' | \
    sed 's/<h4[^>]*>/\n#### /g' | \
    sed 's/<\/h4>//g' | \
    # Bold/Italic
    sed 's/<strong>/\*\*/g' | \
    sed 's/<\/strong>/\*\*/g' | \
    sed 's/<b>/\*\*/g' | \
    sed 's/<\/b>/\*\*/g' | \
    sed 's/<em>/\*/g' | \
    sed 's/<\/em>/\*\*/g' | \
    sed 's/<i>/\*/g' | \
    sed 's/<\/i>/\*/g' | \
    # Paragraphs and breaks
    sed 's/<p[^>]*>/\n/g' | \
    sed 's/<\/p>/\n/g' | \
    sed 's/<br[^>]*>/\n/g' | \
    # Lists
    sed 's/<li>/- /g' | \
    sed 's/<\/li>//g' | \
    sed 's/<ul[^>]*>/\n/g' | \
    sed 's/<\/ul>/\n/g' | \
    sed 's/<ol[^>]*>/\n/g' | \
    sed 's/<\/ol>/\n/g' | \
    # Remove all other HTML tags
    sed 's/<[^>]*>//g'
}

# Step 3: Clean HTML entities
clean_entities() {
    # Process from stdin
    # Common entities
    sed "s/&nbsp;/ /g" | \
    sed 's/&quot;/"/g' | \
    sed "s/&apos;/'/g" | \
    sed 's/&lt;/</g' | \
    sed 's/&gt;/>/g' | \
    sed 's/&amp;/\&/g' | \
    # Numeric entities (common ones)
    sed "s/&#8217;/'/g" | \
    sed "s/&#8216;/'/g" | \
    sed 's/&#8220;/"/g' | \
    sed 's/&#8221;/"/g' | \
    sed 's/&#8211;/—/g' | \
    sed 's/&#8212;/—/g' | \
    sed 's/&#8230;/.../g' | \
    sed 's/&#[0-9]*;//g'  # Remove any remaining numeric entities
}

# Step 4: Clean whitespace and formatting
clean_formatting() {
    # Process from stdin
    # Remove multiple empty lines (keep max 2)
    sed '/^$/N;/^\n$/N;//D' | \
    # Remove leading/trailing whitespace from lines
    sed 's/^[[:space:]]*//' | \
    sed 's/[[:space:]]*$//' | \
    # Remove lines with only whitespace
    sed '/^[[:space:]]*$/d'
}

# Main processing pipeline
echo "🔧 Processing: $(basename "$input")"

# Process via pipe to avoid "File name too long" errors
cat "$input" | \
    extract_main_content | \
    html_to_markdown | \
    clean_entities | \
    clean_formatting > "$output"

# Verify output
size=$(wc -c < "$output")
lines=$(wc -l < "$output")

if [ $size -lt 100 ]; then
    echo "⚠️  WARNING: Output very small ($size bytes) - extraction may have failed"
    exit 1
elif grep -q '<script\|<style\|var gform' "$output"; then
    echo "⚠️  WARNING: Output still contains HTML/JS - cleaning incomplete"
    exit 1
else
    echo "✅ Clean: $(basename "$output") ($size bytes, $lines lines)"
fi
