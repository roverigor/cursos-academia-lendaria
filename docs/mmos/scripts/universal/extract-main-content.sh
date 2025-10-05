#!/bin/bash
# Extract Main Content - Smart content extraction from HTML
# Tries multiple strategies to find the main article content
# Usage: ./extract-main-content.sh input.html output.txt

if [ $# -lt 2 ]; then
    echo "Usage: $0 input.html output.txt"
    exit 1
fi

input="$1"
output="$2"

if [ ! -f "$input" ]; then
    echo "❌ Error: Input file not found: $input"
    exit 1
fi

# Strategy 1: Try <article> tag
extract_article() {
    sed -n '/<article/,/<\/article>/p' "$1" | \
    sed '1d;$d'  # Remove opening/closing article tags
}

# Strategy 2: Try <main> tag
extract_main() {
    sed -n '/<main/,/<\/main>/p' "$1" | \
    sed '1d;$d'
}

# Strategy 3: Try common content class names
extract_by_class() {
    # Look for entry-content, post-content, article-body, etc
    sed -n '/<[^>]*class="[^"]*entry-content/,/<\/div>/p' "$1" | \
    head -n -1 | tail -n +2
}

# Strategy 4: Extract all paragraphs (fallback)
extract_paragraphs() {
    grep -o '<p[^>]*>.*</p>' "$1" | \
    sed 's/<p[^>]*>//g' | \
    sed 's/<\/p>//g'
}

# Try strategies in order
content=$(extract_article "$input")

if [ -z "$content" ] || [ $(echo "$content" | wc -c) -lt 500 ]; then
    content=$(extract_main "$input")
fi

if [ -z "$content" ] || [ $(echo "$content" | wc -c) -lt 500 ]; then
    content=$(extract_by_class "$input")
fi

if [ -z "$content" ] || [ $(echo "$content" | wc -c) -lt 500 ]; then
    content=$(extract_paragraphs "$input")
fi

# Remove scripts, styles, comments
content=$(echo "$content" | \
    sed '/<script/,/<\/script>/d' | \
    sed '/<style/,/<\/style>/d' | \
    sed '/<!--/,/-->/d' | \
    sed '/var gform/d' | \
    sed '/var dataLayer/d' | \
    sed '/var gtm/d' | \
    sed '/var _vwo/d' | \
    sed '/@context.*schema/d'
)

# Output
echo "$content" > "$output"

size=$(wc -c < "$output")
if [ $size -lt 100 ]; then
    echo "⚠️  Extraction failed - content too small ($size bytes)"
    exit 1
else
    echo "✅ Extracted: $(basename "$output") ($size bytes)"
fi
