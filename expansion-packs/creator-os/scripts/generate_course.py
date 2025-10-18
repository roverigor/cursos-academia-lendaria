#!/usr/bin/env python3
"""
Course Generation Orchestration Script
Implements the complete workflow from COURSE-BRIEF to finished course

This script orchestrates all the Epic 3 modules to create a complete course.

Usage:
    python scripts/generate_course.py <course_slug> [--resume] [--force]

Workflow:
    1. Load and validate COURSE-BRIEF.md
    2. Generate course outline
    3. Generate curriculum.yaml
    4. Curriculum approval checkpoint (MANDATORY HALT)
    5. Generate all lessons (GPS + Didática Lendária)
    6. Validate course quality
    7. Generate assessments
    8. Final summary and next steps

Story: Epic 3 - Intelligent Workflow System
"""

import sys
import os
import argparse
from pathlib import Path
import yaml
import logging

# Add lib directory to path
sys.path.insert(0, str(Path(__file__).parent.parent / "lib"))

from state_manager import StateManager
from curriculum_approval import run_curriculum_approval_checkpoint
from lesson_generator import LessonGenerator
from course_validator import CourseValidator
from assessment_generator import AssessmentGenerator

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(message)s'
)
logger = logging.getLogger(__name__)


class CourseGenerationWorkflow:
    """
    Main workflow orchestrator for course generation.

    Coordinates all Epic 3 modules to transform COURSE-BRIEF into complete course.
    """

    def __init__(self, course_slug: str, resume: bool = False, force: bool = False):
        """
        Initialize course generation workflow.

        Args:
            course_slug: Course identifier
            resume: Resume from checkpoint if True
            force: Start fresh, ignore checkpoints if True
        """
        self.course_slug = course_slug
        self.resume = resume
        self.force = force

        self.base_path = Path(f"outputs/courses/{course_slug}")
        self.brief_path = self.base_path / "COURSE-BRIEF.md"
        self.curriculum_path = self.base_path / "curriculum.yaml"

        # Initialize state manager
        self.state_manager = StateManager(course_slug)

    def run(self):
        """
        Execute complete course generation workflow.

        Returns:
            0 on success, 1 on failure
        """
        try:
            # Step 0: Check for resume
            if self.resume and not self.force:
                return self._resume_from_checkpoint()

            # Step 1: Validate course exists
            if not self._validate_course_exists():
                return 1

            # Step 2: Load course brief
            course_brief = self._load_course_brief()
            if not course_brief:
                return 1

            # Step 3: Generate curriculum (if not exists)
            if not self.curriculum_path.exists():
                logger.info("\n⚠️  curriculum.yaml not found.")
                logger.info("Please run curriculum generation first.")
                logger.info(f"Expected path: {self.curriculum_path}\n")
                return 1

            # Load curriculum
            with open(self.curriculum_path, 'r', encoding='utf-8') as f:
                curriculum = yaml.safe_load(f)

            # Step 4: Curriculum Approval Checkpoint (MANDATORY HALT)
            logger.info("\n" + "="*64)
            logger.info("STEP 4: CURRICULUM APPROVAL CHECKPOINT")
            logger.info("="*64 + "\n")

            approval_result = run_curriculum_approval_checkpoint(self.course_slug)

            if approval_result == "halt_canceled":
                logger.info("\n✋ Workflow halted by user. No lessons generated.")
                return 0

            elif approval_result == "halt_for_brief_edit":
                logger.info("\n✋ Workflow halted for COURSE-BRIEF editing.")
                logger.info("Regenerate curriculum after editing.")
                return 0

            elif approval_result != "proceed_to_generation":
                logger.error(f"\n❌ Unexpected approval result: {approval_result}")
                return 1

            # Save checkpoint: curriculum approved
            self.state_manager.save_checkpoint({
                "checkpoint": "curriculum-approved",
                "progress": {
                    "phase": "ready_for_generation"
                },
                "context": {
                    "curriculum_path": str(self.curriculum_path),
                    "brief_path": str(self.brief_path)
                },
                "next_step": "generate_lessons"
            })

            # Step 5: Generate All Lessons
            logger.info("\n" + "="*64)
            logger.info("STEP 5: LESSON GENERATION (GPS + DIDÁTICA LENDÁRIA)")
            logger.info("="*64 + "\n")

            generation_result = self._generate_all_lessons(curriculum, course_brief)

            if not generation_result:
                logger.error("\n❌ Lesson generation failed")
                return 1

            # Step 6: Validate Course Quality
            logger.info("\n" + "="*64)
            logger.info("STEP 6: COURSE QUALITY VALIDATION")
            logger.info("="*64 + "\n")

            validation_result = self._validate_course()

            # Step 7: Generate Assessments
            logger.info("\n" + "="*64)
            logger.info("STEP 7: ASSESSMENT GENERATION")
            logger.info("="*64 + "\n")

            assessment_result = self._generate_assessments(curriculum)

            # Step 8: Cleanup and final summary
            logger.info("\n" + "="*64)
            logger.info("✅ COURSE GENERATION COMPLETE!")
            logger.info("="*64 + "\n")

            self._display_final_summary(generation_result, validation_result)

            # Cleanup state files
            self.state_manager.cleanup_states()

            return 0

        except KeyboardInterrupt:
            logger.info("\n\n⚠️  Generation interrupted by user (CTRL+C)")
            logger.info(f"\nProgress saved. Resume with:")
            logger.info(f"  python scripts/generate_course.py {self.course_slug} --resume\n")
            return 1

        except Exception as e:
            logger.exception(f"\n❌ Unexpected error: {e}")
            return 1

    def _validate_course_exists(self) -> bool:
        """Validate course folder and brief exist."""
        if not self.base_path.exists():
            logger.error(f"\n❌ Course not found: {self.base_path}")
            logger.error("Run *generate-course first to initialize.\n")
            return False

        if not self.brief_path.exists():
            logger.error(f"\n❌ COURSE-BRIEF.md not found: {self.brief_path}")
            logger.error("Course brief is required.\n")
            return False

        return True

    def _load_course_brief(self) -> dict:
        """Load and parse COURSE-BRIEF.md."""
        logger.info("\n📖 Loading COURSE-BRIEF.md...")

        try:
            with open(self.brief_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Parse frontmatter
            import re
            frontmatter_match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)

            if frontmatter_match:
                frontmatter_yaml = frontmatter_match.group(1)
                metadata = yaml.safe_load(frontmatter_yaml)
            else:
                metadata = {}

            # For now, return minimal structure
            # TODO: Parse full 8 sections from markdown
            course_brief = {
                "title": metadata.get("title", "Untitled Course"),
                "mmos_persona": metadata.get("mmos_persona", {}),
                "icp": {},
                "learning_objectives": [],
                "voice_profile": {}
            }

            logger.info(f"✅ Loaded: {course_brief['title']}\n")
            return course_brief

        except Exception as e:
            logger.error(f"❌ Failed to load course brief: {e}\n")
            return None

    def _generate_all_lessons(
        self,
        curriculum: dict,
        course_brief: dict,
        resume_state: Optional[dict] = None
    ) -> dict:
        """
        Generate all lessons using LessonGenerator.

        Args:
            curriculum: Course curriculum structure
            course_brief: Parsed COURSE-BRIEF.md
            resume_state: Optional checkpoint state for resume

        Returns:
            Generation result dict or None on failure
        """
        try:
            generator = LessonGenerator(
                course_slug=self.course_slug,
                curriculum=curriculum,
                course_brief=course_brief
            )

            # If resuming, pass completed lessons to skip
            if resume_state:
                progress = resume_state.get("progress", {})
                completed_lessons = progress.get("completed_list", [])

                logger.info(f"📊 Resume Progress:")
                logger.info(f"   Completed: {len(completed_lessons)} lessons")
                logger.info(f"   Skipping: {', '.join(completed_lessons[:5])}")
                if len(completed_lessons) > 5:
                    logger.info(f"   ... and {len(completed_lessons) - 5} more")
                logger.info("")

                # Generate only pending lessons
                result = generator.generate_all_lessons(skip_completed=completed_lessons)
            else:
                # Normal generation (all lessons)
                result = generator.generate_all_lessons()

            return result

        except Exception as e:
            logger.exception(f"Lesson generation failed: {e}")
            return None

    def _validate_course(self) -> dict:
        """Run course validation."""
        try:
            validator = CourseValidator(self.course_slug)
            results = validator.validate_all()

            return results

        except Exception as e:
            logger.exception(f"Course validation failed: {e}")
            return {"overall": {"passed": False}}

    def _generate_assessments(self, curriculum: dict) -> bool:
        """Generate assessments."""
        try:
            generator = AssessmentGenerator(self.course_slug)
            files = generator.generate_assessments(curriculum)

            logger.info(f"\n✅ Generated {len(files)} assessment files")
            return True

        except Exception as e:
            logger.exception(f"Assessment generation failed: {e}")
            return False

    def _display_final_summary(self, generation_result: dict, validation_result: dict):
        """Display final summary and next steps."""
        logger.info(f"Course: {self.course_slug}")
        logger.info(f"Location: {self.base_path}")
        logger.info("")

        if generation_result:
            logger.info(f"Lessons: {len(generation_result.completed)}/{generation_result.total_lessons}")
            logger.info(f"Time: {generation_result.total_time_seconds / 60:.1f} minutes")
            logger.info(f"Cost: ${generation_result.total_cost_usd:.2f}")
            logger.info("")

        if validation_result and validation_result.get("overall", {}).get("passed"):
            logger.info("✅ Quality validation: PASSED")
        else:
            logger.info("⚠️  Quality validation: Review recommended")

        logger.info("")
        logger.info("📂 OUTPUT FILES:")
        logger.info(f"   {self.base_path}/")
        logger.info(f"   ├── COURSE-BRIEF.md")
        logger.info(f"   ├── curriculum.yaml")
        logger.info(f"   ├── lessons/ ({len(generation_result.completed) if generation_result else 0} files)")
        logger.info(f"   └── assessments/")
        logger.info("")

        logger.info("🎯 NEXT STEPS:")
        logger.info("   1. Review generated lessons")
        logger.info("   2. Edit assessment scaffolds (quizzes need manual questions)")
        logger.info("   3. Test with sample students")
        logger.info(f"   4. Run validation: python lib/course_validator.py {self.course_slug}")
        logger.info("")

    def _resume_from_checkpoint(self) -> int:
        """Resume generation from last checkpoint."""
        logger.info("\n🔄 Resuming from last checkpoint...\n")

        latest_state = self.state_manager.get_latest_state()

        if not latest_state:
            logger.error("❌ No checkpoint found.")
            logger.error("Cannot resume. Run without --resume to start fresh.\n")
            return 1

        if not self.state_manager.validate_state(latest_state):
            logger.error("❌ Checkpoint is corrupted or invalid.")
            logger.error("Run with --force to start fresh.\n")
            return 1

        # Validate context files still exist
        if not self.state_manager.validate_context(latest_state):
            logger.error("❌ Context files have changed since checkpoint.")
            logger.error("curriculum.yaml or COURSE-BRIEF.md may have been modified.")
            logger.error("Run with --force to start fresh.\n")
            return 1

        # Display resume summary
        logger.info(self.state_manager.format_progress_summary(latest_state))

        next_step = latest_state.get("next_step")

        try:
            if next_step == "generate_lessons":
                logger.info("→ Resuming from Step 5: Lesson Generation\n")

                # Load context from state
                context = latest_state.get("context", {})
                curriculum_path = context.get("curriculum_path")
                brief_path = context.get("brief_path")

                if not curriculum_path or not brief_path:
                    logger.error("❌ Missing context paths in checkpoint.")
                    return 1

                # Load curriculum and brief
                with open(curriculum_path, 'r', encoding='utf-8') as f:
                    curriculum = yaml.safe_load(f)

                course_brief = self._load_course_brief()
                if not course_brief:
                    return 1

                # Generate remaining lessons (state manager tracks completed)
                generation_result = self._generate_all_lessons(
                    curriculum,
                    course_brief,
                    resume_state=latest_state
                )

                if not generation_result:
                    logger.error("\n❌ Lesson generation failed")
                    return 1

                # Continue with validation (Step 6)
                logger.info("\n" + "="*64)
                logger.info("STEP 6: COURSE QUALITY VALIDATION")
                logger.info("="*64 + "\n")

                validation_result = self._validate_course()

                # Generate assessments (Step 7)
                logger.info("\n" + "="*64)
                logger.info("STEP 7: ASSESSMENT GENERATION")
                logger.info("="*64 + "\n")

                assessment_result = self._generate_assessments(curriculum)

                # Final summary
                logger.info("\n" + "="*64)
                logger.info("✅ COURSE GENERATION COMPLETE!")
                logger.info("="*64 + "\n")

                self._display_final_summary(generation_result, validation_result)

                # Cleanup state files
                self.state_manager.cleanup_states()

                return 0

            elif next_step == "continue_lessons":
                # Legacy checkpoint name - same as generate_lessons
                logger.info("→ Resuming lesson generation (legacy checkpoint)\n")
                return self._resume_from_checkpoint()  # Recursive with updated state

            else:
                logger.error(f"⚠️  Unknown next_step: {next_step}")
                logger.error("Run without --resume to start fresh.\n")
                return 1

        except Exception as e:
            logger.exception(f"\n❌ Resume failed: {e}")
            logger.error("Run without --resume to start fresh.\n")
            return 1


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Generate complete course from COURSE-BRIEF.md",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Generate course (normal workflow)
  python scripts/generate_course.py dominando-obsidian

  # Resume after interruption
  python scripts/generate_course.py dominando-obsidian --resume

  # Start fresh (ignore checkpoints)
  python scripts/generate_course.py dominando-obsidian --force

Prerequisites:
  1. Course initialized: *generate-course {slug}
  2. COURSE-BRIEF.md filled completely
  3. curriculum.yaml generated (or will be generated in this script)

Workflow:
  Step 1: Validate course exists
  Step 2: Load COURSE-BRIEF.md
  Step 3: Load/validate curriculum.yaml
  Step 4: Curriculum approval checkpoint (MANDATORY HALT)
  Step 5: Generate all lessons (GPS + DL)
  Step 6: Validate course quality
  Step 7: Generate assessments
  Step 8: Final summary
        """
    )

    parser.add_argument(
        "course_slug",
        help="Course identifier (e.g., dominando-obsidian)"
    )

    parser.add_argument(
        "--resume",
        action="store_true",
        help="Resume from last checkpoint"
    )

    parser.add_argument(
        "--force",
        action="store_true",
        help="Start fresh, ignore checkpoints"
    )

    args = parser.parse_args()

    # Validate course_slug format
    if not re.match(r'^[a-z0-9-]{3,50}$', args.course_slug):
        logger.error("❌ Invalid course_slug format")
        logger.error("Must be 3-50 characters: lowercase letters, numbers, hyphens only\n")
        sys.exit(1)

    # Run workflow
    workflow = CourseGenerationWorkflow(
        course_slug=args.course_slug,
        resume=args.resume,
        force=args.force
    )

    exit_code = workflow.run()
    sys.exit(exit_code)


if __name__ == "__main__":
    import re  # Import here for __name__ == "__main__" scope
    main()
