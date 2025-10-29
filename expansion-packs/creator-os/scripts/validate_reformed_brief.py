#!/usr/bin/env python3
"""
Reformed Course Brief Validation Script (MVP)
Validates COURSE-BRIEF.md AFTER market research reformulation

Usage:
    python scripts/validate_reformed_brief.py <course_slug> [--compare] [--verbose]

Exit Codes:
    0 - PASS (integration ≥80)
    1 - FAIL (integration <70)
    2 - MARGINAL PASS (integration 70-79)
    3 - Error

Task: expansion-packs/creator-os/tasks/validate-reformed-brief.md
"""

import sys
import argparse
from pathlib import Path
from datetime import datetime

def validate_reformed_brief(slug: str, compare: bool = False, verbose: bool = False) -> int:
    """
    MVP Implementation: Basic validation of reformed brief

    TODO: Expand with full validation from task specification
    """
    course_path = Path(f"outputs/courses/{slug}")
    brief_path = course_path / "COURSE-BRIEF.md"
    original_path = course_path / "COURSE-BRIEF-ORIGINAL.md"
    research_path = course_path / "research"

    # Check files exist
    if not brief_path.exists():
        print(f"❌ Error: COURSE-BRIEF.md not found at {brief_path}")
        return 3

    if not original_path.exists():
        print(f"❌ Error: COURSE-BRIEF-ORIGINAL.md not found")
        print(f"Expected at: {original_path}")
        print(f"\nThis file should be created by reformulate-course-brief task.")
        return 3

    if not research_path.exists():
        print(f"❌ Error: Research files not found at {research_path}")
        print(f"\nRun market research first: @course-architect *market-research {slug}")
        return 3

    # Load files
    brief_content = brief_path.read_text(encoding='utf-8')
    original_content = original_path.read_text(encoding='utf-8')

    # Check for Section 9 (Market Research Summary)
    has_section_9 = '## 9. Market Research Summary' in brief_content or '## 9️⃣' in brief_content

    # Check for gap topics in outline (Section 3.3)
    gaps_file = research_path / "content-gaps.md"
    if gaps_file.exists():
        gaps_content = gaps_file.read_text(encoding='utf-8')
        # Basic check: Look for P0/P1 markers
        has_gaps = 'P0' in gaps_content or 'P1' in gaps_content
    else:
        has_gaps = False

    # Check if outline changed (simple heuristic)
    original_outline_section = original_content[original_content.find('## 3'):original_content.find('## 4')] if '## 3' in original_content else ""
    reformed_outline_section = brief_content[brief_content.find('## 3'):brief_content.find('## 4')] if '## 3' in brief_content else ""
    outline_changed = len(reformed_outline_section) > len(original_outline_section) * 1.1  # 10% longer

    # Check for differentiation mention
    has_differentiation = 'diferenciação' in brief_content.lower() or 'differentiation' in brief_content.lower()

    # Calculate basic score
    score = 0
    if has_section_9:
        score += 25
    if outline_changed:
        score += 30
    if has_differentiation:
        score += 25
    if has_gaps:
        score += 20

    # Generate report
    print("📊 REFORMED BRIEF VALIDATION REPORT")
    print(f"Course: {slug}")
    print(f"Reformed: {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    print()
    print("━" * 60)
    print()

    status = "✅" if has_section_9 else "❌"
    print(f"{status} Section 9 Added: {has_section_9}")

    status = "✅" if outline_changed else "❌"
    print(f"{status} Outline Modified: {outline_changed}")

    status = "✅" if has_differentiation else "⚠️"
    print(f"{status} Differentiation Present: {has_differentiation}")

    status = "✅" if has_gaps else "⚠️"
    print(f"{status} Gap Topics Found: {has_gaps}")

    print()
    print("━" * 60)
    print()
    print(f"📊 INTEGRATION SCORE: {score}/100")
    print()

    if score >= 80:
        print("🎯 OVERALL RESULT: ✅ PASS")
        print()
        print("✅ SAFE TO PROCEED with curriculum generation")
        exit_code = 0
    elif score >= 70:
        print("🎯 OVERALL RESULT: ⚠️ MARGINAL PASS")
        print()
        print("⚠️ Can proceed but integration may be weak")
        exit_code = 2
    else:
        print("🎯 OVERALL RESULT: ❌ FAIL")
        print()
        print("🚨 CANNOT PROCEED - Research not properly integrated")
        print()
        print("📋 CRITICAL ACTIONS:")
        if not has_section_9:
            print("  1. ✅ Add Section 9: Market Research Summary")
        if not outline_changed:
            print("  2. ✅ Integrate gap topics into Section 3.3 outline")
        if not has_differentiation:
            print("  3. ✅ Add differentiation strategy to brief")
        exit_code = 1

    print()

    # Save report
    report_path = course_path / "validation-reformed-brief-report.md"
    report_path.write_text(f"""# Reformed Brief Validation Report

**Course:** {slug}
**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M')}
**Score:** {score}/100

## Results

- Section 9 Added: {has_section_9}
- Outline Modified: {outline_changed}
- Differentiation Present: {has_differentiation}
- Gap Topics Found: {has_gaps}

## Status

{'PASS' if score >= 80 else 'MARGINAL' if score >= 70 else 'FAIL'}

---
*Note: This is an MVP validation. Full validation coming soon.*
""", encoding='utf-8')

    print(f"💾 Report saved: {report_path}")

    return exit_code


def main():
    parser = argparse.ArgumentParser(description="Validate reformed COURSE-BRIEF quality")
    parser.add_argument('slug', help='Course slug')
    parser.add_argument('--compare', action='store_true', help='Show diff between original and reformed')
    parser.add_argument('--verbose', action='store_true', help='Show detailed analysis')

    args = parser.parse_args()

    return validate_reformed_brief(args.slug, args.compare, args.verbose)


if __name__ == '__main__':
    sys.exit(main())
