"""
QualityChecker - Automated quality validation for prompt outputs

Validates:
- Structure (valid YAML/Markdown?)
- Completeness (word count, sections present?)
- Format compliance

Scores:
- excellent (90-100%)
- good (70-89%)
- acceptable (50-69%)
- poor (<50%)
"""

import yaml
from pathlib import Path
from typing import Dict, Optional, List
from dataclasses import dataclass

@dataclass
class QualityMetrics:
    """Quality metrics for an output"""
    structure_valid: bool
    word_count: int
    expected_sections_found: str  # e.g., "8/8"
    completeness_pct: int
    quality_issues: List[str]

@dataclass
class QualityScore:
    """Quality score for an output"""
    score: str  # excellent, good, acceptable, poor
    metrics: QualityMetrics

class QualityChecker:
    """
    Checks quality of prompt outputs

    Provides automated validation to reduce human review time
    """

    # Thresholds for quality scores
    EXCELLENT_THRESHOLD = 90
    GOOD_THRESHOLD = 70
    ACCEPTABLE_THRESHOLD = 50

    # Minimum word counts by output type
    MIN_WORD_COUNTS = {
        'yaml': 300,
        'md': 500,
        'default': 200
    }

    def __init__(self, expected_format: str = 'yaml'):
        """
        Initialize quality checker

        Args:
            expected_format: Expected output format ('yaml' or 'md')
        """
        self.expected_format = expected_format

    def _validate_structure(self, output_path: Path) -> bool:
        """Check if file is valid YAML/Markdown"""
        try:
            with open(output_path, 'r', encoding='utf-8') as f:
                content = f.read()

            if self.expected_format == 'yaml':
                yaml.safe_load(content)  # Will raise if invalid
                return True
            elif self.expected_format == 'md':
                # Basic markdown check (has headers?)
                return '# ' in content or '## ' in content
            else:
                return True

        except Exception:
            return False

    def _count_words(self, output_path: Path) -> int:
        """Count words in output file"""
        try:
            with open(output_path, 'r', encoding='utf-8') as f:
                content = f.read()
            return len(content.split())
        except Exception:
            return 0

    def _check_sections(self, output_path: Path, expected_sections: Optional[List[str]] = None) -> tuple[int, int]:
        """
        Check for expected sections in output

        Returns:
            (found_count, expected_count)
        """
        if not expected_sections:
            return (0, 0)

        try:
            with open(output_path, 'r', encoding='utf-8') as f:
                content = f.read()

            if self.expected_format == 'yaml':
                data = yaml.safe_load(content)
                found = sum(1 for section in expected_sections if section in data)
            else:
                # For markdown, check for headers
                found = sum(1 for section in expected_sections if f"## {section}" in content or f"# {section}" in content)

            return (found, len(expected_sections))

        except Exception:
            return (0, len(expected_sections))

    def check_output(self, output_path: Path, expected_sections: Optional[List[str]] = None) -> QualityScore:
        """
        Check quality of an output file

        Args:
            output_path: Path to output file
            expected_sections: Optional list of expected sections/keys

        Returns:
            QualityScore with score and metrics
        """
        # 1. Structure validation
        structure_valid = self._validate_structure(output_path)

        # 2. Word count
        word_count = self._count_words(output_path)
        min_words = self.MIN_WORD_COUNTS.get(self.expected_format, self.MIN_WORD_COUNTS['default'])

        # 3. Section check
        sections_found, sections_expected = self._check_sections(output_path, expected_sections)

        # Calculate completeness percentage
        issues = []

        # Structure (30% weight)
        structure_score = 30 if structure_valid else 0
        if not structure_valid:
            issues.append(f"Invalid {self.expected_format.upper()} structure")

        # Word count (40% weight)
        word_score = min(40, (word_count / min_words) * 40) if min_words > 0 else 40
        if word_count < min_words:
            issues.append(f"Word count below threshold ({word_count} < {min_words})")

        # Sections (30% weight)
        section_score = (sections_found / sections_expected * 30) if sections_expected > 0 else 30
        if sections_expected > 0 and sections_found < sections_expected:
            missing = sections_expected - sections_found
            issues.append(f"Missing {missing} expected sections")

        completeness_pct = int(structure_score + word_score + section_score)

        # Determine quality score
        if completeness_pct >= self.EXCELLENT_THRESHOLD:
            score = 'excellent'
        elif completeness_pct >= self.GOOD_THRESHOLD:
            score = 'good'
        elif completeness_pct >= self.ACCEPTABLE_THRESHOLD:
            score = 'acceptable'
        else:
            score = 'poor'

        metrics = QualityMetrics(
            structure_valid=structure_valid,
            word_count=word_count,
            expected_sections_found=f"{sections_found}/{sections_expected}" if sections_expected > 0 else "N/A",
            completeness_pct=completeness_pct,
            quality_issues=issues
        )

        return QualityScore(score=score, metrics=metrics)


# CLI-friendly function
def check_output_quality(output_path: Path, expected_format: str = 'yaml', expected_sections: Optional[List[str]] = None) -> QualityScore:
    """
    Check quality of a single output file

    Args:
        output_path: Path to output file
        expected_format: Expected format ('yaml' or 'md')
        expected_sections: Optional list of expected sections/keys

    Returns:
        QualityScore

    Example:
        >>> score = check_output_quality(
        ...     Path('docs/minds/test/artifacts/viability.yaml'),
        ...     expected_format='yaml',
        ...     expected_sections=['icp_match', 'temporal_coverage', 'decision']
        ... )
        >>> print(f"Quality: {score.score} ({score.metrics.completeness_pct}%)")
    """
    checker = QualityChecker(expected_format)
    return checker.check_output(output_path, expected_sections)
