#!/usr/bin/env python3
"""
Curriculum Approval Checkpoint for CreatorOS

This module implements the mandatory human-in-the-loop approval gate that HALTS
the course generation workflow after curriculum.yaml generation to prevent costly
mistakes and wasted lesson generation.

Story: STORY-3.8 - Curriculum Approval Checkpoint (Epic 3: Intelligent Workflow)

Key Features:
- Displays clear curriculum summary with module breakdown
- Presents 4 approval options: Approve, Edit, Regenerate, Cancel
- Validates curriculum.yaml structure (YAML syntax, numbering, durations)
- Estimates generation cost and time (prevents "spend money" accidents)
- Mandatory checkpoint: NEVER auto-approves
- Logs all approval decisions for audit trail
- Handles edit flow with re-validation
- Provides resume instructions for canceled workflows

Critical Rule: This is a "spend money" gate - user MUST explicitly approve.

Usage:
    from lib.curriculum_approval import CurriculumApprovalCheckpoint

    checkpoint = CurriculumApprovalCheckpoint("dominando-obsidian")
    checkpoint.display_curriculum_summary()
    result = checkpoint.show_approval_options()

    if result == "proceed_to_generation":
        # User approved - continue to lesson generation (Story 3.9)
        pass
"""

import os
import re
import yaml
import shutil
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass, field
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class CurriculumValidationResult:
    """Result of curriculum.yaml validation."""
    valid: bool
    errors: List[str] = field(default_factory=list)
    warnings: List[str] = field(default_factory=list)


@dataclass
class CurriculumSummary:
    """Summary data from curriculum.yaml."""
    course_title: str
    total_lessons: int
    total_modules: int
    total_duration_minutes: int
    modules: List[Dict]
    curriculum_path: str


class CurriculumValidationError(Exception):
    """Raised when curriculum.yaml validation fails."""
    pass


class CurriculumApprovalCheckpoint:
    """
    Mandatory approval checkpoint after curriculum generation.

    This checkpoint HALTS the workflow and requires explicit user approval
    before proceeding to expensive lesson generation.

    Workflow:
    1. Load curriculum.yaml
    2. Display clear summary
    3. Show 4 options (Approve, Edit, Regenerate, Cancel)
    4. Validate user choice
    5. Handle chosen option
    6. Log decision
    7. NEVER auto-approve
    """

    def __init__(self, course_slug: str, curriculum_path: Optional[str] = None):
        """
        Initialize curriculum approval checkpoint.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
            curriculum_path: Optional custom path to curriculum.yaml
        """
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug

        if curriculum_path:
            self.curriculum_path = Path(curriculum_path)
        else:
            self.curriculum_path = self.base_path / "curriculum.yaml"

        if not self.curriculum_path.exists():
            raise FileNotFoundError(
                f"Curriculum not found: {self.curriculum_path}\n"
                f"Generate curriculum first with: *continue-course {course_slug}"
            )

        self.curriculum_data: Optional[Dict] = None
        self.summary: Optional[CurriculumSummary] = None

    def _load_curriculum(self) -> Dict:
        """Load and parse curriculum.yaml."""
        try:
            with open(self.curriculum_path, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)

            self.curriculum_data = data
            return data

        except yaml.YAMLError as e:
            raise CurriculumValidationError(
                f"Invalid YAML syntax in curriculum.yaml:\n{e}"
            )
        except Exception as e:
            raise CurriculumValidationError(
                f"Failed to load curriculum.yaml: {e}"
            )

    def _extract_summary(self) -> CurriculumSummary:
        """Extract summary data from curriculum for display."""
        if not self.curriculum_data:
            self._load_curriculum()

        data = self.curriculum_data

        # Extract basic info
        course_title = data.get('title', 'Untitled Course')
        modules = data.get('modules', [])

        # Calculate totals
        total_modules = len(modules)
        total_lessons = sum(len(module.get('lessons', [])) for module in modules)
        total_duration = sum(
            lesson.get('duration_minutes', 0)
            for module in modules
            for lesson in module.get('lessons', [])
        )

        summary = CurriculumSummary(
            course_title=course_title,
            total_lessons=total_lessons,
            total_modules=total_modules,
            total_duration_minutes=total_duration,
            modules=modules,
            curriculum_path=str(self.curriculum_path)
        )

        self.summary = summary
        return summary

    def display_curriculum_summary(self) -> None:
        """
        Display clear curriculum summary with module breakdown.

        AC 1: Curriculum Summary Display
        """
        summary = self._extract_summary()

        # Calculate estimates
        cost_min, cost_max = self.estimate_generation_cost(summary.total_lessons)
        time_min, time_max = self.estimate_generation_time(summary.total_lessons)
        duration_hours = summary.total_duration_minutes / 60

        print("=" * 64)
        print("📋 CURRICULUM GENERATED")
        print("=" * 64)
        print()
        print(f"Course: {summary.course_title}")
        print(f"Total: {summary.total_lessons} lessons across {summary.total_modules} modules")
        print(f"Estimated Duration: {duration_hours:.1f} hours ({summary.total_duration_minutes} minutes)")
        print(f"Estimated Generation Cost: ${cost_min:.2f}-${cost_max:.2f}")
        print(f"Estimated Generation Time: {time_min}-{time_max} minutes")
        print()
        print("=" * 64)
        print()
        print("📚 MODULE BREAKDOWN:")
        print()

        # Display each module with lessons
        for module in summary.modules:
            module_id = module.get('module_id', '?')
            module_title = module.get('module_title', 'Untitled Module')
            lessons = module.get('lessons', [])
            module_duration = sum(lesson.get('duration_minutes', 0) for lesson in lessons)

            print(f"Module {module_id}: {module_title} ({len(lessons)} lessons, ~{module_duration} min)")

            for lesson in lessons:
                lesson_id = lesson.get('lesson_id', '?')
                lesson_title = lesson.get('lesson_title', 'Untitled Lesson')
                lesson_duration = lesson.get('duration_minutes', 0)
                print(f"  {lesson_id} - {lesson_title} ({lesson_duration} min)")

            print()

        print("=" * 64)
        print()
        print("📄 FULL CURRICULUM:")
        print(f"   File: {summary.curriculum_path}")
        print("   (Open to see complete YAML structure)")
        print()
        print("=" * 64)
        print()

    def estimate_generation_cost(self, lesson_count: int) -> Tuple[float, float]:
        """
        Estimate cost for generating all lessons.

        Based on GPT-4 pricing and typical lesson length (1500-2000 words).

        Args:
            lesson_count: Number of lessons to generate

        Returns:
            Tuple of (min_cost, max_cost) in USD
        """
        # Cost per lesson: $0.70-$1.10 (GPT-4 based on typical lesson length)
        cost_per_lesson_min = 0.70
        cost_per_lesson_max = 1.10

        min_cost = lesson_count * cost_per_lesson_min
        max_cost = lesson_count * cost_per_lesson_max

        return (min_cost, max_cost)

    def estimate_generation_time(self, lesson_count: int) -> Tuple[int, int]:
        """
        Estimate time for generating all lessons.

        Args:
            lesson_count: Number of lessons to generate

        Returns:
            Tuple of (min_time, max_time) in minutes
        """
        # Time per lesson: 2-3 minutes
        time_per_lesson_min = 2
        time_per_lesson_max = 3

        min_time = lesson_count * time_per_lesson_min
        max_time = lesson_count * time_per_lesson_max

        return (min_time, max_time)

    def show_approval_options(self) -> str:
        """
        Present 4 approval options and get user choice.

        AC 2: Approval Options
        AC 3: Option 1 - Approve & Generate
        AC 4: Option 2 - Edit Curriculum
        AC 5: Option 3 - Regenerate
        AC 6: Option 4 - Cancel Workflow
        AC 8: Never Auto-Approve

        Returns:
            Result code: "proceed_to_generation", "halt_for_brief_edit", "halt_canceled"
        """
        if not self.summary:
            self._extract_summary()

        cost_min, cost_max = self.estimate_generation_cost(self.summary.total_lessons)
        time_min, time_max = self.estimate_generation_time(self.summary.total_lessons)

        print("⏸️  CHECKPOINT: Approve curriculum?")
        print()
        print("-" * 60)
        print()
        print("Options:")
        print()
        print("[1] ✅ APPROVE")
        print(f"    → Generate all {self.summary.total_lessons} lessons now")
        print(f"    → Estimated cost: ${cost_min:.2f}-${cost_max:.2f} | Time: {time_min}-{time_max} min")
        print("    → Cannot undo (lessons will be generated)")
        print()
        print("[2] ✏️  EDIT CURRICULUM")
        print("    → Modify curriculum.yaml manually in your editor")
        print("    → Add/remove lessons, adjust titles/durations")
        print("    → Return here when done to validate changes")
        print()
        print("[3] 🔄 REGENERATE CURRICULUM")
        print("    → Go back to COURSE-BRIEF.md and adjust")
        print("    → Re-run outline and curriculum generation")
        print("    → Use if structure needs major changes")
        print()
        print("[4] ❌ CANCEL WORKFLOW")
        print("    → Stop here without generating lessons")
        print(f"    → Progress saved (COURSE-BRIEF, curriculum preserved)")
        print(f"    → Resume later with: *continue-course {self.course_slug}")
        print()
        print("-" * 60)
        print()
        print("💡 TIP: Most users choose [2] to tweak lesson titles before approval.")
        print()
        print("-" * 60)
        print()

        # Get user choice (NEVER auto-approve)
        while True:
            try:
                choice = input("Your choice (1-4): ").strip()

                if choice == "1":
                    return self.handle_option_approve()
                elif choice == "2":
                    return self.handle_option_edit()
                elif choice == "3":
                    return self.handle_option_regenerate()
                elif choice == "4":
                    return self.handle_option_cancel()
                else:
                    print("❌ Invalid choice. Please enter 1, 2, 3, or 4.")
                    print()

            except (KeyboardInterrupt, EOFError):
                print("\n\n⚠️  Workflow interrupted. Progress saved.")
                print(f"Resume with: *continue-course {self.course_slug}")
                logger.info(f"User interrupted workflow at curriculum checkpoint: {self.course_slug}")
                return "halt_canceled"

    def handle_option_approve(self) -> str:
        """
        Handle Option 1: Approve and generate all lessons.

        AC 3: Option 1 - Approve & Generate
        """
        logger.info(f"User selected Option 1: Approve curriculum for {self.course_slug}")

        # Confirmation prompt (safety check)
        print()
        cost_min, cost_max = self.estimate_generation_cost(self.summary.total_lessons)
        print(f"⚠️  This will generate all {self.summary.total_lessons} lessons and incur costs (${cost_min:.2f}-${cost_max:.2f}).")

        try:
            confirm = input("   Are you sure? (yes/no): ").strip().lower()
        except (KeyboardInterrupt, EOFError):
            print("\n\n❌ Approval canceled.")
            logger.info(f"User canceled approval (interrupted): {self.course_slug}")
            return self.show_approval_options()

        if confirm != "yes":
            logger.info(f"User canceled approval (declined confirmation): {self.course_slug}")
            print("\n❌ Approval canceled. Returning to options...\n")
            return self.show_approval_options()

        # Approved!
        logger.info(f"✅ User approved curriculum for {self.course_slug}")
        print("\n✅ Curriculum approved! Starting lesson generation...\n")

        return "proceed_to_generation"

    def handle_option_edit(self) -> str:
        """
        Handle Option 2: Edit curriculum manually.

        AC 4: Option 2 - Edit Curriculum
        """
        logger.info(f"User selected Option 2: Edit curriculum for {self.course_slug}")

        print()
        print("✏️  EDIT MODE")
        print()
        print("1. Open curriculum file:")
        print(f"   {self.curriculum_path}")
        print()
        print("2. Make your changes:")
        print("   - Add/remove lessons")
        print("   - Adjust titles, durations, or learning objectives")
        print("   - Reorder modules")
        print()
        print("3. Save the file")
        print()
        print("4. Return here and press ENTER to validate changes")
        print()
        print("-" * 60)
        print()
        print("💡 TIPS:")
        print("   - Keep numbering sequential (1.1, 1.2, 2.1, ...)")
        print("   - Lesson duration: 10-45 minutes typical")
        print("   - Use YAML syntax (indentation matters!)")
        print()
        print("-" * 60)
        print()

        try:
            input("When done editing, press ENTER to continue: ")
        except (KeyboardInterrupt, EOFError):
            print("\n\n❌ Edit canceled. Returning to options...\n")
            return self.show_approval_options()

        # Re-validate curriculum
        print("\n🔍 Validating edited curriculum...\n")

        try:
            validation_result = self.validate_curriculum()

            if not validation_result.valid:
                # Show errors
                print("❌ CURRICULUM VALIDATION FAILED\n")
                for error in validation_result.errors:
                    print(f"   - {error}")

                print(f"\n→ Please fix errors and return to checkpoint:\n")
                print(f"   *continue-course {self.course_slug} --validate-curriculum\n")

                raise CurriculumValidationError(validation_result.errors)

            # Show warnings (non-blocking)
            if validation_result.warnings:
                print("⚠️  WARNINGS (non-blocking):\n")
                for warning in validation_result.warnings:
                    print(f"   - {warning}")
                print()

            # Valid: Re-display summary with changes
            print("✅ Curriculum validation passed!\n")

            # Reload curriculum data
            self.curriculum_data = None
            self.summary = None

            self.display_curriculum_summary()

            # Re-prompt approval
            logger.info(f"User edited curriculum successfully for {self.course_slug}")
            return self.show_approval_options()

        except CurriculumValidationError as e:
            logger.error(f"Curriculum validation failed for {self.course_slug}: {e}")
            raise

    def handle_option_regenerate(self) -> str:
        """
        Handle Option 3: Go back and regenerate curriculum.

        AC 5: Option 3 - Regenerate Curriculum
        """
        logger.info(f"User selected Option 3: Regenerate curriculum for {self.course_slug}")

        print()
        print("🔄 REGENERATE CURRICULUM")
        print()
        print("This will:")
        print("1. Return to COURSE-BRIEF.md for editing")
        print("2. Re-run outline generation")
        print("3. Re-run curriculum generation")
        print("4. Return to this checkpoint")
        print()
        print("Current curriculum.yaml will be backed up as curriculum-backup-{timestamp}.yaml")
        print()
        print("-" * 60)
        print()

        try:
            confirm = input("→ Proceed with regeneration? (yes/no): ").strip().lower()
        except (KeyboardInterrupt, EOFError):
            print("\n\n❌ Regeneration canceled. Returning to options...\n")
            return self.show_approval_options()

        if confirm != "yes":
            print("\n❌ Regeneration canceled. Returning to options...\n")
            logger.info(f"User canceled regeneration: {self.course_slug}")
            return self.show_approval_options()

        # Backup current curriculum
        backup_path = self.backup_curriculum()
        print(f"\n✅ Curriculum backed up to: {backup_path}\n")

        # Return to brief editing
        print("📝 EDIT COURSE-BRIEF.md")
        print()
        print(f"1. Open: {self.base_path / 'COURSE-BRIEF.md'}")
        print("2. Make changes (objectives, structure, etc.)")
        print("3. Save the file")
        print(f"4. Run: *continue-course {self.course_slug} --regenerate-curriculum")
        print()
        print("Workflow will regenerate outline + curriculum based on updated brief.")
        print()
        print("-" * 60)
        print()

        logger.info(f"User initiated regeneration workflow for {self.course_slug}")
        return "halt_for_brief_edit"

    def handle_option_cancel(self) -> str:
        """
        Handle Option 4: Cancel workflow.

        AC 6: Option 4 - Cancel Workflow
        """
        logger.info(f"User selected Option 4: Cancel workflow for {self.course_slug}")

        print()
        print("❌ WORKFLOW CANCELED")
        print()
        print("Progress has been saved:")
        print("✓ COURSE-BRIEF.md")
        print("✓ course-outline.md")
        print("✓ curriculum.yaml")
        print()
        print("No lessons were generated (no cost incurred).")
        print()
        print("-" * 60)
        print()
        print("To resume later:")
        print()
        print("Option A: Generate lessons with current curriculum")
        print(f"  → *continue-course {self.course_slug}")
        print()
        print("Option B: Edit curriculum first, then generate")
        print(f"  → Edit: {self.curriculum_path}")
        print(f"  → Run: *continue-course {self.course_slug} --validate-curriculum")
        print()
        print("Option C: Start over (regenerate curriculum)")
        print(f"  → *continue-course {self.course_slug} --regenerate-curriculum")
        print()
        print("-" * 60)
        print()

        logger.info(f"User canceled workflow at curriculum checkpoint: {self.course_slug}")
        return "halt_canceled"

    def validate_curriculum(self) -> CurriculumValidationResult:
        """
        Validate curriculum.yaml structure and content.

        AC 7: Curriculum Validation

        Validation rules:
        1. YAML syntax is valid
        2. Has modules list (not empty)
        3. Each module has lessons
        4. Lesson numbering is sequential (1.1, 1.2, 2.1, ...)
        5. No duplicate lesson IDs
        6. Total duration is reasonable (60 min - 3000 min)

        Returns:
            CurriculumValidationResult with errors/warnings
        """
        errors = []
        warnings = []

        # Load curriculum (will raise exception if YAML invalid)
        try:
            curriculum = self._load_curriculum()
        except CurriculumValidationError as e:
            return CurriculumValidationResult(
                valid=False,
                errors=[str(e)]
            )

        # Rule 1: Has modules list
        if "modules" not in curriculum or not curriculum["modules"]:
            errors.append("No modules found in curriculum")
            return CurriculumValidationResult(valid=False, errors=errors)

        modules = curriculum["modules"]

        # Rule 2: Each module has lessons
        for i, module in enumerate(modules, start=1):
            if "lessons" not in module or not module["lessons"]:
                errors.append(f"Module {i} has no lessons")

        # Rule 3: Lesson numbering sequential
        all_lesson_ids = []
        for i, module in enumerate(modules, start=1):
            expected_module_num = i
            lessons = module.get("lessons", [])

            for j, lesson in enumerate(lessons, start=1):
                lesson_id = lesson.get("lesson_id", "")
                expected_id = f"{expected_module_num}.{j}"

                if lesson_id != expected_id:
                    errors.append(
                        f"Lesson numbering error: Expected {expected_id}, got {lesson_id}"
                    )

                all_lesson_ids.append(lesson_id)

        # Rule 4: No duplicate lesson IDs
        duplicates = [id for id in all_lesson_ids if all_lesson_ids.count(id) > 1]
        if duplicates:
            errors.append(f"Duplicate lesson IDs found: {set(duplicates)}")

        # Rule 5: Total duration reasonable
        total_duration = sum(
            lesson.get("duration_minutes", 0)
            for module in modules
            for lesson in module.get("lessons", [])
        )

        if total_duration < 60:  # < 1 hour
            warnings.append(
                f"Total duration seems short: {total_duration} minutes (< 1 hour)"
            )
        elif total_duration > 3000:  # > 50 hours
            warnings.append(
                f"Total duration seems very long: {total_duration} minutes (> 50 hours)"
            )

        # Additional checks (warnings)
        for module in modules:
            if not module.get("module_title"):
                warnings.append(f"Module {module.get('module_id', '?')} missing title")

            for lesson in module.get("lessons", []):
                if not lesson.get("lesson_title"):
                    warnings.append(f"Lesson {lesson.get('lesson_id', '?')} missing title")

                duration = lesson.get("duration_minutes", 0)
                if duration < 5:
                    warnings.append(
                        f"Lesson {lesson.get('lesson_id', '?')} has very short duration: {duration} min"
                    )
                elif duration > 120:
                    warnings.append(
                        f"Lesson {lesson.get('lesson_id', '?')} has very long duration: {duration} min"
                    )

        # Return result
        valid = len(errors) == 0

        return CurriculumValidationResult(
            valid=valid,
            errors=errors,
            warnings=warnings
        )

    def backup_curriculum(self) -> Path:
        """
        Backup current curriculum.yaml with timestamp.

        Returns:
            Path to backup file
        """
        timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
        backup_filename = f"curriculum-backup-{timestamp}.yaml"
        backup_path = self.curriculum_path.parent / backup_filename

        shutil.copy2(self.curriculum_path, backup_path)
        logger.info(f"Backed up curriculum to: {backup_path}")

        return backup_path


def run_curriculum_approval_checkpoint(course_slug: str) -> str:
    """
    Convenience function to run the complete approval checkpoint workflow.

    Args:
        course_slug: Course identifier

    Returns:
        Result code: "proceed_to_generation", "halt_for_brief_edit", "halt_canceled"
    """
    try:
        checkpoint = CurriculumApprovalCheckpoint(course_slug)
        checkpoint.display_curriculum_summary()
        result = checkpoint.show_approval_options()
        return result

    except FileNotFoundError as e:
        print(f"\n❌ Error: {e}\n")
        logger.error(f"Curriculum checkpoint failed for {course_slug}: {e}")
        return "halt_canceled"

    except CurriculumValidationError as e:
        print(f"\n❌ Validation Error: {e}\n")
        logger.error(f"Curriculum validation failed for {course_slug}: {e}")
        return "halt_canceled"

    except Exception as e:
        print(f"\n❌ Unexpected error: {e}\n")
        logger.exception(f"Unexpected error in curriculum checkpoint for {course_slug}")
        return "halt_canceled"


# Example usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python curriculum_approval.py <course_slug>")
        sys.exit(1)

    course_slug = sys.argv[1]
    result = run_curriculum_approval_checkpoint(course_slug)

    print(f"\nResult: {result}")
    sys.exit(0 if result == "proceed_to_generation" else 1)
