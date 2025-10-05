#!/bin/bash
# HTML to Markdown Converter
# Usage: ./html-to-md.sh input.html output.md

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

# Convert HTML to Markdown
sed 's/<p><strong>\([^<]*\): <\/strong>/\n**\1:** /g' "$input" | \
  sed 's/<\/p>/\n/g' | \
  sed 's/<p>//g' | \
  sed 's/<strong>/\*\*/g' | \
  sed 's/<\/strong>/\*\*/g' | \
  sed 's/<em>/\*/g' | \
  sed 's/<\/em>/\*/g' | \
  sed 's/<h1[^>]*>/\n# /g' | \
  sed 's/<\/h1>//g' | \
  sed 's/<h2[^>]*>/\n## /g' | \
  sed 's/<\/h2>//g' | \
  sed 's/<h3[^>]*>/\n### /g' | \
  sed 's/<\/h3>//g' | \
  sed 's/<h4[^>]*>/\n#### /g' | \
  sed 's/<\/h4>//g' | \
  sed 's/<li>/- /g' | \
  sed 's/<\/li>//g' | \
  sed 's/<ul[^>]*>/\n/g' | \
  sed 's/<\/ul>/\n/g' | \
  sed 's/<ol[^>]*>/\n/g' | \
  sed 's/<\/ol>/\n/g' | \
  sed 's/<br[^>]*>/\n/g' | \
  sed 's/<a[^>]*>//g' | \
  sed 's/<\/a>//g' | \
  sed 's/<[^>]*>//g' | \
  sed 's/&nbsp;/ /g' | \
  sed 's/&quot;/"/g' | \
  sed 's/&apos;/'\''/g' | \
  sed 's/&lt;/</g' | \
  sed 's/&gt;/>/g' | \
  sed 's/&amp;/\&/g' | \
  sed 's/&#8217;/'\''/g' | \
  sed 's/&#8220;/"/g' | \
  sed 's/&#8221;/"/g' | \
  sed '/^[[:space:]]*$/d' | \
  sed 's/^[[:space:]]*//' > "$output"

echo "✅ Converted $(basename "$input") → $(basename "$output") ($(wc -l < "$output") lines)"
