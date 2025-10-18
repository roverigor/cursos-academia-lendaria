#!/usr/bin/env python3
"""
Unit tests for curriculum_approval.py

Tests all 8 acceptance criteria from Story 3.8:
- AC 1: Curriculum Summary Display
- AC 2: Approval Options
- AC 3: Option 1 - Approve & Generate
- AC 4: Option 2 - Edit Curriculum
- AC 5: Option 3 - Regenerate
- AC 6: Option 4 - Cancel
- AC 7: Curriculum Validation
- AC 8: Never Auto-Approve
"""

import pytest
import yaml
import tempfile
import shutil
from pathlib import Path
from unittest.mock import patch, MagicMock
from io import StringIO

import sys
sys.path.insert(0, str(Path(__file__).parent.parent / "lib"))

from curriculum_approval import (
    CurriculumApprovalCheckpoint,
    CurriculumValidationError,
    CurriculumValidationResult,
    CurriculumSummary
)


@pytest.fixture
def temp_course_dir():
    """Create temporary course directory with curriculum.yaml"""
    temp_dir = tempfile.mkdtemp()
    course_slug = "test-course"
    course_path = Path(temp_dir) / "outputs" / "courses" / course_slug

    course_path.mkdir(parents=True, exist_ok=True)

    # Create valid curriculum.yaml
    curriculum = {
        "title": "Test Course",
        "slug": course_slug,
        "modules": [
            {
                "module_id": 1,
                "module_title": "Module 1",
                "lessons": [
                    {
                        "lesson_id": "1.1",
                        "lesson_title": "Lesson 1.1",
                        "duration_minutes": 30
                    },
                    {
                        "lesson_id": "1.2",
                        "lesson_title": "Lesson 1.2",
                        "duration_minutes": 25
                    }
                ]
            },
            {
                "module_id": 2,
                "module_title": "Module 2",
                "lessons": [
                    {
                        "lesson_id": "2.1",
                        "lesson_title": "Lesson 2.1",
                        "duration_minutes": 40
                    }
                ]
            }
        ]
    }

    curriculum_path = course_path / "curriculum.yaml"
    with open(curriculum_path, 'w') as f:
        yaml.dump(curriculum, f)

    yield {
        "temp_dir": temp_dir,
        "course_slug": course_slug,
        "course_path": course_path,
        "curriculum_path": curriculum_path
    }

    # Cleanup
    shutil.rmtree(temp_dir)


# AC 7: Curriculum Validation Tests

def test_validate_curriculum_valid(temp_course_dir):
    """Test AC 7: Validation passes for valid curriculum"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is True
    assert len(result.errors) == 0


def test_validate_curriculum_invalid_yaml(temp_course_dir):
    """Test AC 7: Validation fails for invalid YAML syntax"""
    # Write invalid YAML
    with open(temp_course_dir["curriculum_path"], 'w') as f:
        f.write("invalid: yaml: syntax:\n  - broken")

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is False
    assert len(result.errors) > 0
    assert "YAML" in result.errors[0] or "yaml" in result.errors[0]


def test_validate_curriculum_duplicate_ids(temp_course_dir):
    """Test AC 7: Validation fails for duplicate lesson IDs"""
    curriculum = {
        "title": "Test Course",
        "modules": [
            {
                "module_id": 1,
                "module_title": "Module 1",
                "lessons": [
                    {"lesson_id": "1.1", "lesson_title": "Lesson 1.1", "duration_minutes": 30},
                    {"lesson_id": "1.1", "lesson_title": "Duplicate", "duration_minutes": 25}  # Duplicate!
                ]
            }
        ]
    }

    with open(temp_course_dir["curriculum_path"], 'w') as f:
        yaml.dump(curriculum, f)

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is False
    assert any("Duplicate" in err for err in result.errors)


def test_validate_curriculum_non_sequential(temp_course_dir):
    """Test AC 7: Validation fails for non-sequential numbering"""
    curriculum = {
        "title": "Test Course",
        "modules": [
            {
                "module_id": 1,
                "module_title": "Module 1",
                "lessons": [
                    {"lesson_id": "1.1", "lesson_title": "Lesson 1.1", "duration_minutes": 30},
                    {"lesson_id": "1.3", "lesson_title": "Skipped 1.2", "duration_minutes": 25}  # Skip 1.2!
                ]
            }
        ]
    }

    with open(temp_course_dir["curriculum_path"], 'w') as f:
        yaml.dump(curriculum, f)

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is False
    assert any("numbering" in err.lower() for err in result.errors)


def test_validate_curriculum_no_modules(temp_course_dir):
    """Test AC 7: Validation fails when no modules exist"""
    curriculum = {
        "title": "Test Course",
        "modules": []  # Empty!
    }

    with open(temp_course_dir["curriculum_path"], 'w') as f:
        yaml.dump(curriculum, f)

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is False
    assert any("modules" in err.lower() for err in result.errors)


def test_validate_curriculum_module_no_lessons(temp_course_dir):
    """Test AC 7: Validation fails when module has no lessons"""
    curriculum = {
        "title": "Test Course",
        "modules": [
            {
                "module_id": 1,
                "module_title": "Module 1",
                "lessons": []  # Empty!
            }
        ]
    }

    with open(temp_course_dir["curriculum_path"], 'w') as f:
        yaml.dump(curriculum, f)

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    assert result.valid is False
    assert any("no lessons" in err.lower() for err in result.errors)


def test_validate_curriculum_duration_warnings(temp_course_dir):
    """Test AC 7: Warnings for unreasonable durations"""
    # Test very short duration
    curriculum = {
        "title": "Test Course",
        "modules": [
            {
                "module_id": 1,
                "module_title": "Module 1",
                "lessons": [
                    {"lesson_id": "1.1", "lesson_title": "Short", "duration_minutes": 5}
                ]
            }
        ]
    }

    with open(temp_course_dir["curriculum_path"], 'w') as f:
        yaml.dump(curriculum, f)

    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.validate_curriculum()

    # Should be valid but have warnings
    assert result.valid is True
    assert len(result.warnings) > 0


# AC 1: Curriculum Summary Display Tests

def test_display_curriculum_summary(temp_course_dir, capsys):
    """Test AC 1: Curriculum summary displays correctly"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    checkpoint.display_curriculum_summary()

    captured = capsys.readouterr()
    output = captured.out

    # Check all required elements
    assert "📋 CURRICULUM GENERATED" in output
    assert "Test Course" in output
    assert "3 lessons across 2 modules" in output
    assert "Estimated Duration:" in output
    assert "Estimated Generation Cost:" in output
    assert "Estimated Generation Time:" in output
    assert "📚 MODULE BREAKDOWN:" in output
    assert "Module 1:" in output
    assert "Module 2:" in output
    assert "1.1 - Lesson 1.1" in output
    assert "2.1 - Lesson 2.1" in output
    assert "curriculum.yaml" in output


def test_estimate_generation_cost(temp_course_dir):
    """Test AC 1: Cost estimation is reasonable"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    min_cost, max_cost = checkpoint.estimate_generation_cost(10)

    # 10 lessons * $0.70-$1.10 = $7-$11
    assert 6.5 <= min_cost <= 7.5
    assert 10.5 <= max_cost <= 11.5
    assert max_cost > min_cost


def test_estimate_generation_time(temp_course_dir):
    """Test AC 1: Time estimation is reasonable"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    min_time, max_time = checkpoint.estimate_generation_time(10)

    # 10 lessons * 2-3 min = 20-30 min
    assert min_time == 20
    assert max_time == 30
    assert max_time > min_time


# AC 2: Approval Options Tests

@patch('builtins.input', return_value='1')
def test_show_approval_options_display(mock_input, temp_course_dir, capsys):
    """Test AC 2: All 4 options are displayed"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    with patch.object(checkpoint, 'handle_option_approve', return_value='proceed_to_generation'):
        checkpoint.show_approval_options()

    captured = capsys.readouterr()
    output = captured.out

    # Check all 4 options
    assert "[1] ✅ APPROVE" in output
    assert "[2] ✏️  EDIT CURRICULUM" in output
    assert "[3] 🔄 REGENERATE CURRICULUM" in output
    assert "[4] ❌ CANCEL WORKFLOW" in output
    assert "Your choice (1-4):" in output
    assert "💡 TIP:" in output


# AC 3: Option 1 - Approve Tests

@patch('builtins.input', return_value='yes')
def test_option_approve_with_confirmation(mock_input, temp_course_dir):
    """Test AC 3: Option 1 requires explicit 'yes' confirmation"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )
    checkpoint._extract_summary()

    result = checkpoint.handle_option_approve()

    assert result == "proceed_to_generation"


@patch('builtins.input', return_value='no')
def test_option_approve_cancel_confirmation(mock_input, temp_course_dir):
    """Test AC 3: Option 1 returns to options if user says 'no'"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )
    checkpoint._extract_summary()

    with patch.object(checkpoint, 'show_approval_options', return_value='halt_canceled'):
        result = checkpoint.handle_option_approve()

    # Should return to options menu
    assert result == 'halt_canceled'


# AC 4: Option 2 - Edit Tests

@patch('builtins.input', return_value='')  # User presses ENTER
def test_option_edit_workflow(mock_input, temp_course_dir):
    """Test AC 4: Option 2 waits for edit, then re-validates"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    with patch.object(checkpoint, 'show_approval_options', return_value='proceed_to_generation'):
        result = checkpoint.handle_option_edit()

    # Should re-validate and return to options
    assert result == 'proceed_to_generation'


@patch('builtins.input', return_value='')
def test_option_edit_validation_failure(mock_input, temp_course_dir):
    """Test AC 4: Option 2 shows errors if validation fails"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    # Corrupt the curriculum file
    with open(temp_course_dir["curriculum_path"], 'w') as f:
        f.write("invalid: yaml: broken")

    with pytest.raises(CurriculumValidationError):
        checkpoint.handle_option_edit()


# AC 5: Option 3 - Regenerate Tests

@patch('builtins.input', return_value='yes')
def test_option_regenerate_with_confirmation(mock_input, temp_course_dir):
    """Test AC 5: Option 3 backs up curriculum and halts"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.handle_option_regenerate()

    assert result == "halt_for_brief_edit"

    # Check backup was created
    backup_files = list(temp_course_dir["course_path"].glob("curriculum-backup-*.yaml"))
    assert len(backup_files) > 0


@patch('builtins.input', return_value='no')
def test_option_regenerate_cancel(mock_input, temp_course_dir):
    """Test AC 5: Option 3 returns to options if user cancels"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    with patch.object(checkpoint, 'show_approval_options', return_value='halt_canceled'):
        result = checkpoint.handle_option_regenerate()

    # Should return to options menu
    assert result == 'halt_canceled'


# AC 6: Option 4 - Cancel Tests

def test_option_cancel(temp_course_dir, capsys):
    """Test AC 6: Option 4 halts gracefully with resume instructions"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.handle_option_cancel()

    assert result == "halt_canceled"

    captured = capsys.readouterr()
    output = captured.out

    # Check all required elements
    assert "❌ WORKFLOW CANCELED" in output
    assert "Progress has been saved:" in output
    assert "No lessons were generated" in output
    assert "To resume later:" in output
    assert f"*continue-course {temp_course_dir['course_slug']}" in output


# AC 8: Never Auto-Approve Tests

@patch('builtins.input', side_effect=['invalid', '5', 'abc', '4'])  # Invalid inputs, then valid
def test_never_auto_approve_requires_input(mock_input, temp_course_dir):
    """Test AC 8: Always requires explicit user input (no auto-approval)"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    result = checkpoint.show_approval_options()

    # Should eventually get valid choice (4 = cancel)
    assert result == "halt_canceled"
    # Should have been called multiple times (rejected invalid inputs)
    assert mock_input.call_count > 1


def test_no_config_bypass(temp_course_dir):
    """Test AC 8: No config option can bypass checkpoint"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    # Even if we try to inject auto_approve config, checkpoint should ignore it
    # (This tests the principle - actual config integration would be tested separately)
    with patch('builtins.input', return_value='4'):
        result = checkpoint.show_approval_options()

    # Must still prompt user
    assert result == "halt_canceled"


# Integration Tests

@patch('builtins.input', side_effect=['1', 'yes'])  # Select approve, confirm yes
def test_e2e_approval_flow(mock_input, temp_course_dir, capsys):
    """End-to-end test: Display summary → Approve → Confirm"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    checkpoint.display_curriculum_summary()
    result = checkpoint.show_approval_options()

    assert result == "proceed_to_generation"

    captured = capsys.readouterr()
    output = captured.out

    # Check flow
    assert "📋 CURRICULUM GENERATED" in output
    assert "[1] ✅ APPROVE" in output
    assert "Are you sure?" in output


@patch('builtins.input', side_effect=['2', '', '1', 'yes'])  # Edit → ENTER → Approve → Confirm
def test_e2e_edit_flow(mock_input, temp_course_dir):
    """End-to-end test: Edit → Re-validate → Approve"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    # First call: User selects option 2 (edit)
    with patch.object(checkpoint, 'show_approval_options') as mock_show:
        mock_show.side_effect = [
            checkpoint.handle_option_edit(),  # Will re-call show_approval_options
            "proceed_to_generation"  # Final result after re-prompt
        ]

        # Manually trigger edit flow
        result = checkpoint.handle_option_edit()

    # Should have re-validated and re-prompted
    assert result == "proceed_to_generation"


def test_file_not_found_error():
    """Test error handling when curriculum.yaml doesn't exist"""
    with pytest.raises(FileNotFoundError):
        checkpoint = CurriculumApprovalCheckpoint("nonexistent-course")


def test_backup_curriculum(temp_course_dir):
    """Test curriculum backup functionality"""
    checkpoint = CurriculumApprovalCheckpoint(
        temp_course_dir["course_slug"],
        curriculum_path=temp_course_dir["curriculum_path"]
    )

    backup_path = checkpoint.backup_curriculum()

    assert backup_path.exists()
    assert "curriculum-backup-" in backup_path.name
    assert backup_path.suffix == ".yaml"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
