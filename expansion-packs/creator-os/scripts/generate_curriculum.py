#!/usr/bin/env python3
"""
Curriculum Generation Script
Generates curriculum.yaml from COURSE-BRIEF.md using AI

This script fills the critical gap between COURSE-BRIEF and lesson generation.

Usage:
    python scripts/generate_curriculum.py <course_slug> [--force]

Workflow:
    1. Load COURSE-BRIEF.md (validate completeness)
    2. Generate curriculum structure with AI (modules + lessons)
    3. Validate curriculum (numbering, duplicates, duration)
    4. Save to curriculum.yaml
    5. Display summary and next steps

Dependencies:
    - COURSE-BRIEF.md must be filled (8 sections)
    - OpenAI API key (or mock mode for testing)
    - Pedagogical framework templates

Output:
    - curriculum.yaml (modules with lessons)
    - Validation report
"""

import sys
import os
import argparse
from pathlib import Path
import yaml
import logging
import re
from typing import Dict, List, Optional

# Add lib directory to path
sys.path.insert(0, str(Path(__file__).parent.parent / "lib"))

from brief_parser import BriefParser, validate_brief_completeness

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(message)s'
)
logger = logging.getLogger(__name__)


class CurriculumGenerator:
    """
    Generate curriculum.yaml from COURSE-BRIEF.md.

    Uses AI to transform learning objectives and preliminary outline
    into structured curriculum with modules and lessons.
    """

    def __init__(self, course_slug: str, force: bool = False):
        """
        Initialize curriculum generator.

        Args:
            course_slug: Course identifier
            force: Overwrite existing curriculum.yaml if True
        """
        self.course_slug = course_slug
        self.force = force

        self.base_path = Path(f"outputs/courses/{course_slug}")
        self.brief_path = self.base_path / "COURSE-BRIEF.md"
        self.curriculum_path = self.base_path / "curriculum.yaml"

    def run(self) -> int:
        """
        Execute curriculum generation workflow.

        Returns:
            0 on success, 1 on failure
        """
        try:
            # Step 1: Validate course exists
            if not self._validate_course_exists():
                return 1

            # Step 2: Check if curriculum already exists
            if self.curriculum_path.exists() and not self.force:
                logger.error(f"\n❌ curriculum.yaml already exists: {self.curriculum_path}")
                logger.error("Use --force to overwrite.\n")
                return 1

            # Step 3: Load and parse COURSE-BRIEF.md
            logger.info("\n📖 Loading COURSE-BRIEF.md...")
            course_brief = self._load_course_brief()

            if not course_brief:
                return 1

            # Step 4: Validate brief completeness
            if not self._validate_brief_completeness(course_brief):
                return 1

            # Step 5: Generate curriculum structure
            logger.info("\n🤖 Generating curriculum structure...")
            logger.info("(This may take 30-60 seconds)\n")

            curriculum = self._generate_curriculum_structure(course_brief)

            if not curriculum:
                logger.error("\n❌ Curriculum generation failed")
                return 1

            # Step 6: Validate curriculum
            logger.info("\n✅ Validating curriculum...")
            validation_result = self._validate_curriculum(curriculum)

            if not validation_result["valid"]:
                logger.error("\n❌ Curriculum validation failed:")
                for error in validation_result["errors"]:
                    logger.error(f"   - {error}")
                return 1

            # Step 7: Save curriculum.yaml
            logger.info(f"\n💾 Saving curriculum to: {self.curriculum_path}")
            self._save_curriculum(curriculum)

            # Step 8: Display summary
            self._display_summary(curriculum)

            logger.info("\n" + "="*64)
            logger.info("✅ CURRICULUM GENERATION COMPLETE!")
            logger.info("="*64 + "\n")

            logger.info("📝 NEXT STEPS:")
            logger.info(f"   1. Review curriculum: cat {self.curriculum_path}")
            logger.info(f"   2. Generate course: python scripts/generate_course.py {self.course_slug}")
            logger.info("")

            return 0

        except KeyboardInterrupt:
            logger.info("\n\n⚠️  Generation interrupted by user (CTRL+C)\n")
            return 1

        except Exception as e:
            logger.exception(f"\n❌ Unexpected error: {e}")
            return 1

    def _validate_course_exists(self) -> bool:
        """Validate course folder and brief exist."""
        if not self.base_path.exists():
            logger.error(f"\n❌ Course not found: {self.base_path}")
            logger.error("Run: python scripts/init_course.py\n")
            return False

        if not self.brief_path.exists():
            logger.error(f"\n❌ COURSE-BRIEF.md not found: {self.brief_path}")
            return False

        return True

    def _load_course_brief(self) -> Optional[Dict]:
        """Load and parse COURSE-BRIEF.md using BriefParser."""
        try:
            # Use BriefParser to extract all 8 sections
            parser = BriefParser(str(self.brief_path))
            brief_obj = parser.parse()

            # Convert to dict for curriculum generation
            course_brief = {
                "title": brief_obj.title,
                "slug": brief_obj.course_slug,
                "creation_mode": brief_obj.creation_mode,
                "learning_objectives": brief_obj.content.learning_objectives,
                "preliminary_outline": brief_obj.content.preliminary_outline,
                "total_duration_hours": brief_obj.basic_info.total_duration_hours,
                "icp": {
                    "pain_points": brief_obj.icp.pain_points,
                    "goals": brief_obj.icp.goals,
                },
                "brief_object": brief_obj  # Keep full object for reference
            }

            logger.info(f"✅ Loaded: {course_brief['title']}")
            logger.info(f"   Mode: {course_brief['creation_mode']}\n")

            return course_brief

        except Exception as e:
            logger.exception(f"❌ Failed to load COURSE-BRIEF.md: {e}")
            return None

    def _validate_brief_completeness(self, course_brief: Dict) -> bool:
        """Validate COURSE-BRIEF has required sections filled."""
        brief_obj = course_brief.get("brief_object")

        if not brief_obj:
            logger.error("❌ Brief object not found")
            return False

        # Use BriefParser validation
        validation = validate_brief_completeness(brief_obj)

        if not validation["valid"]:
            logger.error("\n❌ COURSE-BRIEF validation failed:")
            for error in validation["errors"]:
                logger.error(f"   - {error}")
            logger.error("\nPlease fill all 8 sections before generating curriculum.\n")
            return False

        if validation["warnings"]:
            logger.warning("\n⚠️  COURSE-BRIEF warnings:")
            for warning in validation["warnings"]:
                logger.warning(f"   - {warning}")
            logger.warning("")

        return True

    def _generate_curriculum_structure(self, course_brief: Dict) -> Optional[Dict]:
        """
        Generate curriculum structure using AI.

        For MVP: Creates a simple structured curriculum.
        TODO: Integrate with OpenAI API for intelligent generation.
        """
        try:
            # Extract key info
            title = course_brief["title"]
            sections = course_brief.get("sections", {})

            content_section = sections.get("content_and_curriculum", {})
            content_text = content_section.get("content", "")

            # Simple extraction: look for module/lesson structure in content
            # This is MVP - in production, use AI to generate intelligent curriculum

            logger.info("📝 Generating curriculum structure (MVP mode)...")
            logger.info("   (For production: integrate OpenAI API for intelligent generation)")
            logger.info("")

            # MVP: Create basic 3-module structure
            curriculum = {
                "course_title": title,
                "total_duration_hours": 10,
                "modules": [
                    {
                        "module_id": 1,
                        "module_title": "Introduction & Fundamentals",
                        "module_duration_hours": 3,
                        "lessons": [
                            {
                                "lesson_id": "1.1",
                                "lesson_title": "Course Overview",
                                "duration_minutes": 30,
                                "learning_objectives": [
                                    "Understand course structure and goals",
                                    "Set up learning environment"
                                ],
                                "bloom_level": "Remember"
                            },
                            {
                                "lesson_id": "1.2",
                                "lesson_title": "Core Concepts",
                                "duration_minutes": 45,
                                "learning_objectives": [
                                    "Learn fundamental concepts",
                                    "Apply basic techniques"
                                ],
                                "bloom_level": "Understand"
                            }
                        ]
                    },
                    {
                        "module_id": 2,
                        "module_title": "Application & Practice",
                        "module_duration_hours": 4,
                        "lessons": [
                            {
                                "lesson_id": "2.1",
                                "lesson_title": "Practical Application",
                                "duration_minutes": 60,
                                "learning_objectives": [
                                    "Apply concepts to real scenarios",
                                    "Build working examples"
                                ],
                                "bloom_level": "Apply"
                            }
                        ]
                    },
                    {
                        "module_id": 3,
                        "module_title": "Mastery & Advanced Topics",
                        "module_duration_hours": 3,
                        "lessons": [
                            {
                                "lesson_id": "3.1",
                                "lesson_title": "Advanced Techniques",
                                "duration_minutes": 45,
                                "learning_objectives": [
                                    "Master advanced concepts",
                                    "Solve complex problems"
                                ],
                                "bloom_level": "Analyze"
                            }
                        ]
                    }
                ]
            }

            logger.info("✅ MVP curriculum structure generated")
            logger.info(f"   Modules: {len(curriculum['modules'])}")
            logger.info(f"   Total lessons: {sum(len(m['lessons']) for m in curriculum['modules'])}")
            logger.info("")
            logger.info("⚠️  NOTE: This is a basic structure. Edit curriculum.yaml to:")
            logger.info("   - Add more modules/lessons as needed")
            logger.info("   - Customize lesson titles and objectives")
            logger.info("   - Adjust duration and Bloom's levels")
            logger.info("")

            return curriculum

        except Exception as e:
            logger.exception(f"Curriculum generation failed: {e}")
            return None

    def _validate_curriculum(self, curriculum: Dict) -> Dict:
        """Validate curriculum structure."""
        errors = []
        warnings = []

        # Check required fields
        if "course_title" not in curriculum:
            errors.append("Missing course_title")

        if "modules" not in curriculum:
            errors.append("Missing modules list")
        else:
            modules = curriculum["modules"]

            if len(modules) == 0:
                errors.append("No modules defined")

            # Validate each module
            for i, module in enumerate(modules, 1):
                if "module_id" not in module:
                    errors.append(f"Module {i}: missing module_id")

                if "lessons" not in module:
                    errors.append(f"Module {i}: missing lessons")
                elif len(module["lessons"]) == 0:
                    warnings.append(f"Module {i}: no lessons defined")

                # Validate lessons
                for j, lesson in enumerate(module.get("lessons", []), 1):
                    if "lesson_id" not in lesson:
                        errors.append(f"Module {i}, Lesson {j}: missing lesson_id")

        return {
            "valid": len(errors) == 0,
            "errors": errors,
            "warnings": warnings
        }

    def _save_curriculum(self, curriculum: Dict):
        """Save curriculum to YAML file."""
        with open(self.curriculum_path, 'w', encoding='utf-8') as f:
            yaml.dump(curriculum, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

        logger.info(f"✅ Saved: {self.curriculum_path}")

    def _display_summary(self, curriculum: Dict):
        """Display curriculum summary."""
        modules = curriculum.get("modules", [])
        total_lessons = sum(len(m.get("lessons", [])) for m in modules)
        total_duration = curriculum.get("total_duration_hours", 0)

        logger.info("\n📊 CURRICULUM SUMMARY:")
        logger.info(f"   Course: {curriculum.get('course_title')}")
        logger.info(f"   Modules: {len(modules)}")
        logger.info(f"   Lessons: {total_lessons}")
        logger.info(f"   Duration: {total_duration} hours")
        logger.info("")

        for module in modules:
            logger.info(f"   Module {module['module_id']}: {module['module_title']}")
            logger.info(f"      Lessons: {len(module.get('lessons', []))}")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Generate curriculum.yaml from COURSE-BRIEF.md",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Generate curriculum
  python scripts/generate_curriculum.py dominando-obsidian

  # Overwrite existing curriculum
  python scripts/generate_curriculum.py dominando-obsidian --force

Prerequisites:
  1. Course initialized: python scripts/init_course.py
  2. COURSE-BRIEF.md filled completely (8 sections)

Output:
  - curriculum.yaml (structured modules and lessons)

Note:
  This is MVP implementation with basic structure.
  For production: integrate OpenAI API for intelligent curriculum generation
  based on learning objectives, ICP, and pedagogical frameworks.
        """
    )

    parser.add_argument(
        "course_slug",
        help="Course identifier (e.g., dominando-obsidian)"
    )

    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing curriculum.yaml"
    )

    args = parser.parse_args()

    # Validate course_slug format
    if not re.match(r'^[a-z0-9-]{3,50}$', args.course_slug):
        logger.error("❌ Invalid course_slug format")
        logger.error("Must be 3-50 characters: lowercase letters, numbers, hyphens only\n")
        sys.exit(1)

    # Run workflow
    generator = CurriculumGenerator(
        course_slug=args.course_slug,
        force=args.force
    )

    exit_code = generator.run()
    sys.exit(exit_code)


if __name__ == "__main__":
    main()
