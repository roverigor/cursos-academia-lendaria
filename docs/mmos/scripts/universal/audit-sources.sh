#!/bin/bash
# Audit Sources - Validate all markdown files in a mind's sources
# Usage: ./audit-sources.sh mind_name

if [ $# -lt 1 ]; then
    echo "Usage: $0 mind_name"
    exit 1
fi

MIND="$1"
BASE_DIR="minds/$MIND/sources"

if [ ! -d "$BASE_DIR" ]; then
    echo "❌ Error: Mind not found: $MIND"
    exit 1
fi

echo "🔍 Auditing sources for: $MIND"
echo "================================"
echo ""

# Counters
total=0
clean=0
with_js=0
with_html_entities=0
with_html_tags=0
too_small=0

# Lists
js_files=()
entity_files=()
tag_files=()
small_files=()

# Find all markdown files
while IFS= read -r file; do
    total=$((total + 1))
    size=$(wc -c < "$file")
    basename_file=$(basename "$file")

    has_issues=0

    # Check for JavaScript/CSS
    if grep -q '<script\|var gform\|<style\|function(' "$file" 2>/dev/null; then
        with_js=$((with_js + 1))
        js_files+=("$file")
        has_issues=1
    fi

    # Check for HTML entities
    if grep -q '&#[0-9]*;\|&nbsp;\|&quot;\|&apos;' "$file" 2>/dev/null; then
        with_html_entities=$((with_html_entities + 1))
        entity_files+=("$file")
        has_issues=1
    fi

    # Check for HTML tags (excluding markdown-safe ones)
    if grep -q '<p>\|<div>\|<span>\|<strong>\|<em>' "$file" 2>/dev/null; then
        with_html_tags=$((with_html_tags + 1))
        tag_files+=("$file")
        has_issues=1
    fi

    # Check for very small files
    if [ $size -lt 1000 ]; then
        too_small=$((too_small + 1))
        small_files+=("$file ($size bytes)")
        has_issues=1
    fi

    if [ $has_issues -eq 0 ]; then
        clean=$((clean + 1))
    fi

done < <(find "$BASE_DIR" -type f -name "*.md")

# Calculate percentages
if [ $total -gt 0 ]; then
    clean_pct=$((clean * 100 / total))
    problems=$((total - clean))
    problems_pct=$((problems * 100 / total))
else
    clean_pct=0
    problems=0
    problems_pct=0
fi

# Report
echo "📊 SUMMARY"
echo "----------"
echo "Total files: $total"
echo "Clean files: $clean ($clean_pct%)"
echo "Files with problems: $problems ($problems_pct%)"
echo ""

if [ $with_js -gt 0 ]; then
    echo "❌ JavaScript/CSS inline: $with_js files"
    for f in "${js_files[@]}"; do
        echo "   - $(realpath --relative-to="$BASE_DIR" "$f")"
    done
    echo ""
fi

if [ $with_html_entities -gt 0 ]; then
    echo "⚠️  HTML entities: $with_html_entities files"
    for f in "${entity_files[@]}"; do
        echo "   - $(realpath --relative-to="$BASE_DIR" "$f")"
    done
    echo ""
fi

if [ $with_html_tags -gt 0 ]; then
    echo "⚠️  HTML tags: $with_html_tags files"
    for f in "${tag_files[@]}"; do
        echo "   - $(realpath --relative-to="$BASE_DIR" "$f")"
    done
    echo ""
fi

if [ $too_small -gt 0 ]; then
    echo "⚠️  Very small files (<1KB): $too_small files"
    for f in "${small_files[@]}"; do
        echo "   - $f"
    done
    echo ""
fi

# Final verdict
echo "================================"
if [ $problems -eq 0 ]; then
    echo "✅ All files are CLEAN!"
    exit 0
else
    echo "❌ Found $problems files with issues"
    echo ""
    echo "Run cleaning scripts to fix:"
    echo "  - JS/CSS: Use fetch-and-clean.sh to reprocess"
    echo "  - Entities: Use sed to replace HTML entities"
    echo "  - Tags: Use clean-html-content.sh"
    echo "  - Small files: Check if content exists at source"
    exit 1
fi
