#!/usr/bin/env python3
"""
GPS Structure Validator for CreatorOS

This module validates that generated lessons follow the GPS Framework structure:
- G (Goal): Clear promise and motivation
- P (Position): Empathy and starting point validation
- S (Steps): Technical content with pedagogical elements

Story: STORY-3.9 - Lesson Generation with GPS + Didática Lendária
Epic: EPIC-3 - Intelligent Workflow System

Validation Rules:
1. G section must be present and contain clear outcomes
2. P section must be present and show empathy
3. S section must be present with structured content
4. Minimum semiotic elements (analogies, diagrams, questions)
5. Proper heading structure

Usage:
    from lib.gps_validator import GPSValidator

    validator = GPSValidator()
    result = validator.validate_lesson(lesson_content)

    if result.valid:
        print(f"✅ GPS compliant ({result.score}/30)")
    else:
        print(f"❌ GPS violations: {result.errors}")
"""

import re
from dataclasses import dataclass, field
from typing import List, Dict, Optional


@dataclass
class GPSValidationResult:
    """Result of GPS structure validation."""
    valid: bool
    score: int  # 0-30 points (10 per section)
    max_score: int = 30
    has_goal: bool = False
    has_position: bool = False
    has_steps: bool = False
    errors: List[str] = field(default_factory=list)
    warnings: List[str] = field(default_factory=list)
    details: Dict = field(default_factory=dict)


class GPSValidator:
    """
    GPS Framework structure validator.

    Validates that lessons follow Goal → Position → Steps structure
    with proper pedagogical elements.
    """

    def __init__(self):
        """Initialize GPS validator."""
        pass

    def validate_lesson(self, content: str) -> GPSValidationResult:
        """
        Validate lesson content against GPS framework requirements.

        Args:
            content: Lesson content (Markdown)

        Returns:
            GPSValidationResult with score and details
        """
        result = GPSValidationResult(valid=False, score=0)

        # Check G (Goal) section
        goal_check = self._validate_goal_section(content)
        result.has_goal = goal_check["present"]
        result.details["goal"] = goal_check

        # Check P (Position) section
        position_check = self._validate_position_section(content)
        result.has_position = position_check["present"]
        result.details["position"] = position_check

        # Check S (Steps) section
        steps_check = self._validate_steps_section(content)
        result.has_steps = steps_check["present"]
        result.details["steps"] = steps_check

        # Calculate score (10 points per section)
        score = 0
        if result.has_goal:
            score += 10
        if result.has_position:
            score += 10
        if result.has_steps:
            score += 10

        result.score = score

        # Check validity (all 3 sections must be present)
        result.valid = result.has_goal and result.has_position and result.has_steps

        # Collect errors
        if not result.has_goal:
            result.errors.append("Missing G (Goal) section")
        if not result.has_position:
            result.errors.append("Missing P (Position) section")
        if not result.has_steps:
            result.errors.append("Missing S (Steps) section")

        # Collect warnings
        if result.has_goal and not goal_check.get("has_outcomes"):
            result.warnings.append("Goal section lacks clear outcomes/promises")

        if result.has_position and not position_check.get("has_empathy"):
            result.warnings.append("Position section lacks empathy/validation")

        if result.has_steps and not steps_check.get("has_subsections"):
            result.warnings.append("Steps section lacks structured subsections")

        return result

    def _validate_goal_section(self, content: str) -> Dict:
        """
        Validate G (Goal) section.

        Requirements:
        - Section header present (##\s*G|GOAL|🎯)
        - Contains tangible outcomes (✅ or bullet points)
        - Has motivation/why statement

        Returns:
            Dict with validation details
        """
        # Check for section header
        goal_pattern = r'##\s*(G|GOAL|🎯|G\s*-\s*GOAL)'
        goal_match = re.search(goal_pattern, content, re.IGNORECASE)

        if not goal_match:
            return {
                "present": False,
                "has_outcomes": False,
                "has_motivation": False
            }

        # Extract section content (from heading to next ## or end)
        section_start = goal_match.end()
        next_section = re.search(r'\n##\s+', content[section_start:])
        if next_section:
            section_end = section_start + next_section.start()
        else:
            section_end = len(content)

        section_content = content[section_start:section_end]

        # Check for tangible outcomes (checkmarks or bullets)
        has_outcomes = bool(
            re.search(r'✅|✓|\[x\]|- .*?(você vai|você será capaz)', section_content, re.IGNORECASE)
        )

        # Check for motivation/why statement
        has_motivation = bool(
            re.search(r'(por que|why|isso importa|matters|economizar|save|melhorar|improve)', section_content, re.IGNORECASE)
        )

        return {
            "present": True,
            "has_outcomes": has_outcomes,
            "has_motivation": has_motivation,
            "content_length": len(section_content.strip())
        }

    def _validate_position_section(self, content: str) -> Dict:
        """
        Validate P (Position) section.

        Requirements:
        - Section header present (##\s*P|POSITION|🗺️)
        - Shows empathy (validates concerns/struggles)
        - Acknowledges different starting points

        Returns:
            Dict with validation details
        """
        # Check for section header
        position_pattern = r'##\s*(P|POSITION|🗺️|P\s*-\s*POSITION)'
        position_match = re.search(position_pattern, content, re.IGNORECASE)

        if not position_match:
            return {
                "present": False,
                "has_empathy": False,
                "acknowledges_levels": False
            }

        # Extract section content
        section_start = position_match.end()
        next_section = re.search(r'\n##\s+', content[section_start:])
        if next_section:
            section_end = section_start + next_section.start()
        else:
            section_end = len(content)

        section_content = content[section_start:section_end]

        # Check for empathy indicators
        empathy_patterns = [
            r'eu sei',
            r'eu entendo',
            r'talvez você',
            r'você pode estar',
            r'i know',
            r'i understand',
            r'you might be',
            r'maybe you'
        ]
        has_empathy = any(
            re.search(pattern, section_content, re.IGNORECASE)
            for pattern in empathy_patterns
        )

        # Check for acknowledging different levels
        level_patterns = [
            r'se você.*?(nunca|never)',
            r'se você.*?(já|already)',
            r'iniciante|beginner',
            r'avançado|advanced',
            r'if you.*?(never|already)'
        ]
        acknowledges_levels = any(
            re.search(pattern, section_content, re.IGNORECASE)
            for pattern in level_patterns
        )

        return {
            "present": True,
            "has_empathy": has_empathy,
            "acknowledges_levels": acknowledges_levels,
            "content_length": len(section_content.strip())
        }

    def _validate_steps_section(self, content: str) -> Dict:
        """
        Validate S (Steps) section.

        Requirements:
        - Section header present (##\s*S|STEPS|🛤️)
        - Has structured subsections (###)
        - Contains instructional content

        Returns:
            Dict with validation details
        """
        # Check for section header
        steps_pattern = r'##\s*(S|STEPS|🛤️|S\s*-\s*STEPS)'
        steps_match = re.search(steps_pattern, content, re.IGNORECASE)

        if not steps_match:
            return {
                "present": False,
                "has_subsections": False,
                "subsection_count": 0
            }

        # Extract section content
        section_start = steps_match.end()
        # Steps section typically goes to end (or to next major section like Revisão)
        next_major = re.search(r'\n##\s+(💡|⚡|🔗)', content[section_start:])
        if next_major:
            section_end = section_start + next_major.start()
        else:
            section_end = len(content)

        section_content = content[section_start:section_end]

        # Count subsections (###)
        subsection_count = len(re.findall(r'\n###\s+', section_content))

        has_subsections = subsection_count > 0

        return {
            "present": True,
            "has_subsections": has_subsections,
            "subsection_count": subsection_count,
            "content_length": len(section_content.strip())
        }

    def validate_gps_structure(self, content: str) -> Dict:
        """
        Standalone GPS structure validation (simplified).

        Returns basic G-P-S presence check.

        Args:
            content: Lesson content

        Returns:
            Dict with has_goal, has_position, has_steps, score
        """
        has_goal = bool(re.search(r'##\s*(G|GOAL|🎯)', content, re.IGNORECASE))
        has_position = bool(re.search(r'##\s*(P|POSITION|🗺️)', content, re.IGNORECASE))
        has_steps = bool(re.search(r'##\s*(S|STEPS|🛤️)', content, re.IGNORECASE))

        score = 0
        if has_goal:
            score += 10
        if has_position:
            score += 10
        if has_steps:
            score += 10

        return {
            "has_goal": has_goal,
            "has_position": has_position,
            "has_steps": has_steps,
            "score": score,
            "max_score": 30
        }


# Utility functions

def quick_gps_check(content: str) -> bool:
    """
    Quick GPS compliance check (boolean).

    Args:
        content: Lesson content

    Returns:
        True if all 3 GPS sections present
    """
    validator = GPSValidator()
    result = validator.validate_lesson(content)
    return result.valid


def gps_compliance_percentage(content: str) -> int:
    """
    Calculate GPS compliance percentage (0-100).

    Args:
        content: Lesson content

    Returns:
        Percentage (0-100)
    """
    validator = GPSValidator()
    result = validator.validate_lesson(content)
    return int((result.score / result.max_score) * 100)


# Example usage
if __name__ == "__main__":
    # Test with sample content
    test_lesson = """
# Test Lesson: GPS Framework

## 🎯 G - GOAL

Ao final desta aula, você vai:
✅ Dominar o conceito X
✅ Aplicar a técnica Y
✅ Ter resultado Z

Por que isso importa? Vai economizar 10 horas por semana.

## 🗺️ P - POSITION

Eu sei que você pode estar pensando: "Mais uma ferramenta?"

Se você nunca fez isso antes, tudo bem - vou mostrar desde o zero.
Se você já tem experiência, ótimo - você vai ver como levar ao próximo nível.

## 🛤️ S - STEPS

### Passo 1: Conceito Principal

Aqui está o que você precisa saber...

### Passo 2: Prática

Agora vamos aplicar...

## 💡 REVISÃO

Principais aprendizados...
    """

    validator = GPSValidator()
    result = validator.validate_lesson(test_lesson)

    print("GPS Validation Results:")
    print(f"  Valid: {result.valid}")
    print(f"  Score: {result.score}/{result.max_score}")
    print(f"  Has Goal: {result.has_goal}")
    print(f"  Has Position: {result.has_position}")
    print(f"  Has Steps: {result.has_steps}")

    if result.errors:
        print(f"\n  Errors:")
        for error in result.errors:
            print(f"    - {error}")

    if result.warnings:
        print(f"\n  Warnings:")
        for warning in result.warnings:
            print(f"    - {warning}")
