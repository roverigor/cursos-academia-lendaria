#!/usr/bin/env python3
"""
Module Quality Validation Script (MVP)
Validates completed module BEFORE generating next module

Usage:
    python scripts/validate_module.py <course_slug> <module_id> [--verbose]

Arguments:
    course_slug    Course identifier
    module_id      Module number (1, 2, 3, etc.)

Exit Codes:
    0 - PASS (quality ≥80)
    1 - FAIL (quality <70)
    2 - MARGINAL PASS (quality 70-79)
    3 - Error

Task: expansion-packs/creator-os/tasks/validate-module.md
"""

import sys
import argparse
from pathlib import Path
from datetime import datetime
import re

try:
    import yaml  # type: ignore
except ImportError:
    print("❌ Error: PyYAML not installed")
    print("Install: pip install pyyaml")
    sys.exit(3)


def validate_module(slug: str, module_id: int, verbose: bool = False) -> int:
    """
    MVP Implementation: Basic module validation

    TODO: Expand with full GPS/DL validation from task specification
    """
    course_path = Path(f"outputs/courses/{slug}")
    curriculum_path = course_path / "curriculum.yaml"
    lessons_path = course_path / "lessons"

    # Check files exist
    if not course_path.exists():
        print(f"❌ Error: Course '{slug}' not found at {course_path}")
        return 3

    if not curriculum_path.exists():
        print(f"❌ Error: curriculum.yaml not found")
        print(f"\nGenerate curriculum first: @course-architect *generate-curriculum {slug}")
        return 3

    if not lessons_path.exists():
        print(f"❌ Error: Lessons folder not found")
        print(f"\nGenerate lessons first: @course-architect *generate-lessons {slug}")
        return 3

    # Load curriculum
    try:
        with open(curriculum_path, 'r', encoding='utf-8') as f:
            curriculum = yaml.safe_load(f)
    except Exception as e:
        print(f"❌ Error loading curriculum: {e}")
        return 3

    # Find module
    modules = curriculum.get('modules', [])
    target_module = None
    for mod in modules:
        if mod.get('module_id') == module_id:
            target_module = mod
            break

    if not target_module:
        print(f"❌ Error: Module {module_id} not found in curriculum")
        print(f"\nCurriculum has {len(modules)} modules:")
        for mod in modules:
            print(f"  - Module {mod.get('module_id')}: {mod.get('module_title')}")
        return 3

    module_title = target_module.get('module_title', f'Module {module_id}')
    expected_lessons = target_module.get('lessons', [])

    print("📊 MODULE VALIDATION REPORT")
    print(f"Course: {slug}")
    print(f"Module: {module_id} - {module_title} ({len(expected_lessons)} lessons)")
    print(f"Validated: {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    print()
    print("━" * 60)
    print()

    # Check lesson completeness
    missing_lessons = []
    present_lessons = []
    lesson_word_counts = {}

    for lesson in expected_lessons:
        lesson_id = lesson.get('lesson_id', '')
        # Try different filename patterns
        possible_files = [
            lessons_path / f"{lesson_id}.md",
            lessons_path / f"{lesson_id}-{lesson.get('lesson_title', '').lower().replace(' ', '-')}.md",
        ]

        found = False
        for lesson_file in possible_files:
            if lesson_file.exists():
                found = True
                present_lessons.append(lesson_id)
                # Count words
                content = lesson_file.read_text(encoding='utf-8')
                words = len(re.findall(r'\b\w+\b', content))
                lesson_word_counts[lesson_id] = words
                break

        if not found:
            missing_lessons.append(lesson_id)

    completeness = (len(present_lessons) / len(expected_lessons) * 100) if expected_lessons else 0

    # Check 1: Completeness
    if completeness == 100:
        print(f"✅ LESSON COMPLETENESS")
        print(f"   Status: ✅ COMPLETE ({len(present_lessons)}/{len(expected_lessons)} lessons)")
        completeness_score = 100
    else:
        print(f"❌ LESSON COMPLETENESS")
        print(f"   Status: ❌ INCOMPLETE ({len(present_lessons)}/{len(expected_lessons)} lessons)")
        print(f"   Missing:")
        for lesson_id in missing_lessons:
            print(f"     - {lesson_id}")
        completeness_score = completeness

    print()

    # Check 2: Basic content quality (word count heuristic)
    avg_words = sum(lesson_word_counts.values()) / len(lesson_word_counts) if lesson_word_counts else 0

    if avg_words >= 800:  # Decent lesson length
        print(f"✅ CONTENT DEPTH")
        print(f"   Average: {avg_words:.0f} words/lesson ✅")
        depth_score = 100
    elif avg_words >= 500:
        print(f"⚠️  CONTENT DEPTH")
        print(f"   Average: {avg_words:.0f} words/lesson ⚠️ (target: 800+)")
        depth_score = 70
    else:
        print(f"❌ CONTENT DEPTH")
        print(f"   Average: {avg_words:.0f} words/lesson ❌ (too shallow)")
        depth_score = 40

    print()

    # Check 3: Duration estimate
    estimated_duration = target_module.get('duration_minutes', 0)
    reading_time = (avg_words * len(present_lessons)) / 200  # 200 wpm
    actual_duration = reading_time  # Simplified

    variance = abs(actual_duration - estimated_duration) / estimated_duration * 100 if estimated_duration > 0 else 0

    if variance <= 20:
        print(f"✅ DURATION ACCURACY")
        print(f"   Estimated: {estimated_duration} min")
        print(f"   Calculated: {actual_duration:.0f} min")
        print(f"   Variance: {variance:.1f}% ✅")
        duration_score = 100
    elif variance <= 35:
        print(f"⚠️  DURATION ACCURACY")
        print(f"   Estimated: {estimated_duration} min")
        print(f"   Calculated: {actual_duration:.0f} min")
        print(f"   Variance: {variance:.1f}% ⚠️")
        duration_score = 70
    else:
        print(f"❌ DURATION ACCURACY")
        print(f"   Estimated: {estimated_duration} min")
        print(f"   Calculated: {actual_duration:.0f} min")
        print(f"   Variance: {variance:.1f}% ❌")
        duration_score = 40

    print()
    print("━" * 60)
    print()

    # Calculate overall score
    overall_score = (completeness_score + depth_score + duration_score) / 3

    print(f"📊 MODULE QUALITY SCORE: {overall_score:.0f}/100")
    print()

    if overall_score >= 80:
        print("🎯 OVERALL RESULT: ✅ PASS")
        print()
        print(f"✅ SAFE TO PROCEED to Module {module_id + 1}")
        exit_code = 0
    elif overall_score >= 70:
        print("🎯 OVERALL RESULT: ⚠️ MARGINAL PASS")
        print()
        print("⚠️ Can proceed but quality is marginal")
        exit_code = 2
    else:
        print("🎯 OVERALL RESULT: ❌ FAIL")
        print()
        print(f"🚨 CANNOT PROCEED to Module {module_id + 1}")
        print()
        print("📋 CRITICAL ACTIONS:")
        if missing_lessons:
            print(f"  1. ✅ Generate missing lessons: {', '.join(missing_lessons)}")
        if depth_score < 70:
            print(f"  2. ✅ Expand lesson content (target: 800+ words/lesson)")
        if duration_score < 70:
            print(f"  3. ✅ Adjust content to match duration estimate")
        exit_code = 1

    print()

    # Save report
    report_path = course_path / f"validation-module-{module_id}-report.md"
    report_path.write_text(f"""# Module {module_id} Validation Report

**Course:** {slug}
**Module:** {module_id} - {module_title}
**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M')}
**Score:** {overall_score:.0f}/100

## Results

- Completeness: {completeness:.0f}%
- Content Depth: {depth_score:.0f}/100 (avg {avg_words:.0f} words)
- Duration Accuracy: {duration_score:.0f}/100 (variance {variance:.1f}%)

## Lessons

Present: {len(present_lessons)}/{len(expected_lessons)}
{'Missing: ' + ', '.join(missing_lessons) if missing_lessons else ''}

## Status

{'PASS' if overall_score >= 80 else 'MARGINAL' if overall_score >= 70 else 'FAIL'}

---
*Note: This is an MVP validation. Full GPS/DL validation coming soon.*
""", encoding='utf-8')

    print(f"💾 Report saved: {report_path}")

    return exit_code


def main():
    parser = argparse.ArgumentParser(description="Validate module quality")
    parser.add_argument('slug', help='Course slug')
    parser.add_argument('module_id', type=int, help='Module number (1, 2, 3, etc.)')
    parser.add_argument('--verbose', action='store_true', help='Show per-lesson breakdown')

    args = parser.parse_args()

    return validate_module(args.slug, args.module_id, args.verbose)


if __name__ == '__main__':
    sys.exit(main())
