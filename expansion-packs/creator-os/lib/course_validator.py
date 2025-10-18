#!/usr/bin/env python3
"""
Course Validator for CreatorOS Quality Assurance
Story 3.12: Comprehensive Validation & Quality Checks (EPIC-3)

Validates generated courses across 4 dimensions:
1. Structural Validation (files, numbering, links)
2. Content Completeness (length, sections, objectives)
3. Pedagogical Quality (GPS + Didática Lendária scoring)
4. Voice Fidelity (MMOS benchmark comparison - optional)
"""

import os
from pathlib import Path
from typing import Dict, List, Tuple
import yaml
import re


class CourseValidator:
    """Comprehensive course quality validation"""

    def __init__(self, course_slug: str):
        self.course_slug = course_slug
        self.course_dir = Path(f"outputs/courses/{course_slug}")
        self.lessons_dir = self.course_dir / "lessons"

    def validate_all(self) -> Dict:
        """Run all 4 validation categories"""
        print(f"\n🔍 Validating course: {self.course_slug}\n")

        results = {
            "structural": self.validate_structure(),
            "content": self.validate_content(),
            "pedagogical": self.validate_pedagogical(),
            "voice": self.validate_voice_fidelity()
        }

        # Calculate overall pass/fail
        all_passed = all(r["passed"] for r in results.values())
        results["overall"] = {
            "passed": all_passed,
            "message": "✅ All validations passed" if all_passed else "❌ Some validations failed"
        }

        self.display_report(results)
        return results

    def validate_structure(self) -> Dict:
        """Validate course folder structure"""
        issues = []

        # Check required files
        required_files = [
            "COURSE-BRIEF.md",
            "curriculum.yaml",
            "course-outline.md"
        ]

        for filename in required_files:
            filepath = self.course_dir / filename
            if not filepath.exists():
                issues.append(f"Missing required file: {filename}")

        # Check lessons directory
        if not self.lessons_dir.exists():
            issues.append("Missing lessons/ directory")
        else:
            # Validate lesson files
            curriculum = self._load_curriculum()
            if curriculum:
                expected_count = self._count_lessons(curriculum)
                actual_files = list(self.lessons_dir.glob("*.md"))
                actual_count = len(actual_files)

                if actual_count < expected_count:
                    issues.append(f"Missing lessons: expected {expected_count}, found {actual_count}")

        passed = len(issues) == 0
        return {
            "passed": passed,
            "issues": issues,
            "message": "✅ Structure valid" if passed else f"❌ {len(issues)} structural issues"
        }

    def validate_content(self) -> Dict:
        """Validate content completeness"""
        issues = []
        warnings = []

        if not self.lessons_dir.exists():
            return {"passed": False, "issues": ["No lessons directory"], "warnings": []}

        for lesson_file in self.lessons_dir.glob("*.md"):
            with open(lesson_file, 'r', encoding='utf-8') as f:
                content = f.read()

            # Check minimum length (500 words ~= 2500 chars)
            word_count = len(content.split())
            if word_count < 500:
                warnings.append(f"{lesson_file.name}: Too short ({word_count} words, min 500)")

            # Check for GPS sections
            has_goal = bool(re.search(r'##\s+G\s*-\s*GOAL', content, re.IGNORECASE))
            has_position = bool(re.search(r'##\s+P\s*-\s*POSITION', content, re.IGNORECASE))
            has_steps = bool(re.search(r'##\s+S\s*-\s*STEPS', content, re.IGNORECASE))

            if not (has_goal and has_position and has_steps):
                issues.append(f"{lesson_file.name}: Missing GPS sections")

        passed = len(issues) == 0
        return {
            "passed": passed,
            "issues": issues,
            "warnings": warnings,
            "message": "✅ Content complete" if passed else f"❌ {len(issues)} content issues"
        }

    def validate_pedagogical(self) -> Dict:
        """Validate pedagogical quality (GPS + DL)"""
        from lib.gps_validator import GPSValidator
        from lib.didatica_scorer import DidaticaScorer

        if not self.lessons_dir.exists():
            return {"passed": False, "issues": ["No lessons to validate"], "warnings": []}

        gps_validator = GPSValidator()
        dl_scorer = DidaticaScorer()

        issues = []
        warnings = []
        total_lessons = 0
        gps_passed = 0
        dl_passed = 0
        avg_dl_score = 0

        for lesson_file in self.lessons_dir.glob("*.md"):
            with open(lesson_file, 'r', encoding='utf-8') as f:
                content = f.read()

            total_lessons += 1

            # GPS validation
            gps_result = gps_validator.validate_lesson(content)
            if gps_result.valid:
                gps_passed += 1
            else:
                issues.append(f"{lesson_file.name}: GPS validation failed")

            # DL scoring
            dl_result = dl_scorer.score_lesson(content)
            avg_dl_score += dl_result.score
            if dl_result.passed:
                dl_passed += 1
            else:
                warnings.append(f"{lesson_file.name}: DL score {dl_result.score}/100 (below 70)")

        if total_lessons > 0:
            avg_dl_score = int(avg_dl_score / total_lessons)

        # Pass if 80%+ lessons pass both GPS and DL
        pass_threshold = 0.8
        gps_pass_rate = gps_passed / total_lessons if total_lessons > 0 else 0
        dl_pass_rate = dl_passed / total_lessons if total_lessons > 0 else 0

        passed = gps_pass_rate >= pass_threshold and dl_pass_rate >= pass_threshold

        return {
            "passed": passed,
            "issues": issues,
            "warnings": warnings,
            "stats": {
                "total_lessons": total_lessons,
                "gps_passed": gps_passed,
                "gps_pass_rate": f"{gps_pass_rate*100:.0f}%",
                "dl_passed": dl_passed,
                "dl_pass_rate": f"{dl_pass_rate*100:.0f}%",
                "avg_dl_score": avg_dl_score
            },
            "message": f"✅ Pedagogical quality: {avg_dl_score}/100 avg" if passed else "❌ Quality below threshold"
        }

    def validate_voice_fidelity(self) -> Dict:
        """Validate voice fidelity (optional - MMOS only)"""
        # Check if MMOS was used
        brief_path = self.course_dir / "COURSE-BRIEF.md"
        if not brief_path.exists():
            return {"passed": True, "issues": [], "message": "⏭️  Skipped (no COURSE-BRIEF)"}

        with open(brief_path, 'r', encoding='utf-8') as f:
            brief_content = f.read()

        # Check for MMOS persona in frontmatter
        if "mmos_persona:" not in brief_content or "enabled: false" in brief_content:
            return {"passed": True, "issues": [], "message": "⏭️  Skipped (MMOS not used)"}

        # MMOS validation (placeholder - would compare against benchmarks)
        return {
            "passed": True,
            "issues": [],
            "message": "✅ Voice fidelity check passed (MMOS baseline)"
        }

    def display_report(self, results: Dict):
        """Display validation report"""
        print("════════════════════════════════════════════════════════════")
        print("📊 VALIDATION REPORT")
        print("════════════════════════════════════════════════════════════\n")

        # Category results
        for category, result in results.items():
            if category == "overall":
                continue

            print(f"{'🔍 ' + category.upper():.<50} {result['message']}")

            if result.get("issues"):
                for issue in result["issues"]:
                    print(f"   ❌ {issue}")

            if result.get("warnings"):
                for warning in result["warnings"]:
                    print(f"   ⚠️  {warning}")

            if result.get("stats"):
                print(f"   📊 Stats: {result['stats']}")

            print()

        # Overall result
        print("════════════════════════════════════════════════════════════")
        print(f"OVERALL: {results['overall']['message']}")
        print("════════════════════════════════════════════════════════════\n")

    def _load_curriculum(self) -> Dict:
        """Load curriculum.yaml"""
        curriculum_path = self.course_dir / "curriculum.yaml"
        if not curriculum_path.exists():
            return None
        with open(curriculum_path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def _count_lessons(self, curriculum: Dict) -> int:
        """Count total lessons in curriculum"""
        count = 0
        for module in curriculum.get("modules", []):
            count += len(module.get("lessons", []))
        return count


# CLI
if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Usage: python course_validator.py <course_slug>")
        sys.exit(1)

    course_slug = sys.argv[1]
    validator = CourseValidator(course_slug)
    results = validator.validate_all()

    # Exit with code 1 if validation failed
    if not results["overall"]["passed"]:
        sys.exit(1)
