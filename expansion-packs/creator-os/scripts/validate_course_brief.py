#!/usr/bin/env python3
"""
Course Brief Validation Script
Validates COURSE-BRIEF.md quality BEFORE market research or curriculum generation

Usage:
    python scripts/validate_course_brief.py <course_slug> [--strict] [--verbose]

Arguments:
    course_slug         Course identifier (e.g., clone-ia-express)
    --strict            Fail on warnings (not just critical issues)
    --verbose           Show detailed field-by-field analysis

Exit Codes:
    0 - PASS (quality ≥80)
    1 - FAIL (quality <70)
    2 - MARGINAL PASS (quality 70-79, only if not --strict)
    3 - Error (file not found, parsing error)

Economics:
    - Validates brief: ~10K tokens (~$0.10)
    - Skip validation, bad brief: Waste 450K tokens (~$4.50)
    - ROI: 4,500% cost savings per caught error

Task: expansion-packs/creator-os/tasks/validate-course-brief.md
"""

import sys
import re
import argparse
from pathlib import Path
from dataclasses import dataclass, field
from typing import Dict, List, Tuple, Optional, Any
from datetime import datetime
from enum import Enum

try:
    import yaml  # type: ignore
except ImportError:
    print("❌ Error: PyYAML not installed")
    print("Install: pip install pyyaml")
    sys.exit(3)


# ============================================================================
# DATA STRUCTURES
# ============================================================================

class ValidationLevel(Enum):
    """Validation result levels"""
    PASS = "✅ PASS"
    MARGINAL = "⚠️  MARGINAL PASS"
    FAIL = "❌ FAIL"


class IssueSeverity(Enum):
    """Issue severity levels"""
    CRITICAL = "critical"
    WARNING = "warning"
    INFO = "info"


@dataclass
class ValidationIssue:
    """Represents a validation issue"""
    severity: IssueSeverity
    category: str
    field: str
    description: str
    recommendation: str


@dataclass
class ValidationResult:
    """Validation check result"""
    name: str
    score: float
    max_score: float
    status: str
    issues: List[ValidationIssue] = field(default_factory=list)
    details: Dict[str, Any] = field(default_factory=dict)

    @property
    def percentage(self) -> float:
        """Get score as percentage"""
        if self.max_score == 0:
            return 0.0
        return (self.score / self.max_score) * 100


@dataclass
class BriefData:
    """Parsed course brief data"""
    frontmatter: Dict[str, Any]
    content: str
    sections: Dict[str, str]


# ============================================================================
# PARSING FUNCTIONS
# ============================================================================

def parse_course_brief(brief_path: Path) -> BriefData:
    """
    Parse COURSE-BRIEF.md into structured data.

    Returns:
        BriefData with frontmatter, content, and sections
    """
    if not brief_path.exists():
        raise FileNotFoundError(f"COURSE-BRIEF.md not found at {brief_path}")

    content = brief_path.read_text(encoding='utf-8')

    # Extract YAML frontmatter
    frontmatter = {}
    body_content = content

    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            try:
                frontmatter = yaml.safe_load(parts[1]) or {}
                body_content = parts[2]
            except yaml.YAMLError as e:
                raise ValueError(f"Invalid YAML frontmatter: {e}")

    # Extract sections by headers
    sections = {}
    current_section = None
    current_content = []

    for line in body_content.split('\n'):
        # Match section headers like "## 1️⃣ BASIC INFO"
        if line.startswith('##'):
            # Save previous section
            if current_section:
                sections[current_section] = '\n'.join(current_content).strip()

            # Start new section
            current_section = line.strip('#').strip()
            current_content = []
        else:
            current_content.append(line)

    # Save last section
    if current_section:
        sections[current_section] = '\n'.join(current_content).strip()

    return BriefData(
        frontmatter=frontmatter,
        content=body_content,
        sections=sections
    )


def extract_field_value(section_text: str, field_pattern: str) -> Optional[str]:
    """Extract field value from section text using pattern."""
    match = re.search(field_pattern, section_text, re.MULTILINE | re.DOTALL)
    if match:
        value = match.group(1).strip()
        # Check if it's a placeholder
        if value and not value.startswith('[') and value != '':
            return value
    return None


def count_filled_fields(section_text: str, patterns: List[str]) -> Tuple[int, int]:
    """Count filled vs total fields in a section."""
    filled = 0
    total = len(patterns)

    for pattern in patterns:
        if extract_field_value(section_text, pattern):
            filled += 1

    return filled, total


# ============================================================================
# VALIDATION CHECKS
# ============================================================================

def validate_completeness(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 1: Completeness - Are critical fields filled?
    Target: ≥95% of required fields
    """
    issues = []
    details = {}

    # Define required fields per section
    required_fields = {
        'Section 1: Basic Info': [
            r'\*\*Título do Curso:\*\*\s*```\s*(.+?)```',
            r'\*\*Duração total estimada do curso:\*\*',
            r'\*\*Categoria Principal:\*\*',
        ],
        'Section 2: ICP': [
            r'Idade principal:\s*(.+)',
            r'Ocupação atual',
            r'Momento atual do avatar:\s*(.+)',
            r'Estado mental/emocional predominante:\s*(.+)',
            r'\*\*Dor superficial',
            r'\*\*Dor real',
            r'\*\*Dor profunda',
            r'\*\*Estado atual \(ANTES do curso\):\*\*\s*```\s*(.+?)```',
            r'\*\*Estado desejado \(DEPOIS do curso\):\*\*\s*```\s*(.+?)```',
        ],
        'Section 3: Learning Objectives': [
            r'1\.\s*(.+)',
            r'2\.\s*(.+)',
            r'3\.\s*(.+)',
            r'4\.\s*(.+)',
            r'5\.\s*(.+)',
        ],
        'Section 3: Outline': [
            r'MÓDULO 1:',
            r'MÓDULO 2:',
            r'MÓDULO 3:',
        ],
        'Section 4: Voice': [
            r'\*\*Usar clone MMOS como instrutor\?\*\*',
        ],
        'Section 6: Commercial': [
            r'\*\*Estratégia de monetização:\*\*',
            r'\*\*Preço sugerido',
        ],
    }

    total_filled = 0
    total_required = 0

    for section_name, patterns in required_fields.items():
        # Find corresponding section in brief
        section_key = None
        for key in brief.sections:
            if section_name.split(':')[1].strip().lower() in key.lower():
                section_key = key
                break

        if not section_key:
            issues.append(ValidationIssue(
                severity=IssueSeverity.CRITICAL,
                category="completeness",
                field=section_name,
                description=f"Section not found: {section_name}",
                recommendation=f"Ensure COURSE-BRIEF.md has section '{section_name}'"
            ))
            total_required += len(patterns)
            continue

        section_text = brief.sections[section_key]
        filled, total = count_filled_fields(section_text, patterns)
        total_filled += filled
        total_required += total

        details[section_name] = {
            'filled': filled,
            'total': total,
            'percentage': (filled / total * 100) if total > 0 else 0
        }

        # Flag critical gaps
        if filled < total * 0.7:  # < 70% filled
            missing = total - filled
            issues.append(ValidationIssue(
                severity=IssueSeverity.CRITICAL,
                category="completeness",
                field=section_name,
                description=f"{missing}/{total} required fields missing",
                recommendation=f"Complete all fields in {section_name}"
            ))

    # Calculate overall score
    percentage = (total_filled / total_required * 100) if total_required > 0 else 0

    # Determine status
    if percentage >= 95:
        status = "✅ PASS"
    elif percentage >= 85:
        status = "⚠️  WARNING"
    else:
        status = "❌ FAIL"

    details['total_filled'] = total_filled
    details['total_required'] = total_required

    return ValidationResult(
        name="Completeness Check",
        score=total_filled,
        max_score=total_required,
        status=status,
        issues=issues,
        details=details
    )


def validate_icp_quality(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 2: ICP Quality Score
    Target: ≥80/100
    """
    issues = []
    details = {}
    score = 0.0
    max_score = 100.0

    # Find ICP section
    icp_section = None
    for key in brief.sections:
        if 'público-alvo' in key.lower() or 'icp' in key.lower():
            icp_section = brief.sections[key]
            break

    if not icp_section:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="icp",
            field="Section 2",
            description="ICP section not found",
            recommendation="Add Section 2: PÚBLICO-ALVO & ICP"
        ))
        return ValidationResult(
            name="ICP Quality Score",
            score=0,
            max_score=max_score,
            status="❌ FAIL",
            issues=issues,
            details={'error': 'ICP section not found'}
        )

    # Demographics (15 pts)
    demographics_score = 0
    if extract_field_value(icp_section, r'Idade principal:\s*(.+)'):
        demographics_score += 5
    if 'ocupação atual' in icp_section.lower() and '[ ]' not in icp_section[:icp_section.find('Ocupação atual') + 200]:
        demographics_score += 5
    if 'tempo de experiência' in icp_section.lower():
        demographics_score += 5

    score += demographics_score
    details['demographics'] = {'score': demographics_score, 'max': 15}

    # Psychographics (25 pts)
    psycho_score = 0
    momento = extract_field_value(icp_section, r'Momento atual do avatar:\s*\[.*?\]\s*(.+?)(?:\n\n|\Z)')
    if momento and len(momento) > 50:  # Substantial description
        psycho_score += 10
    else:
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="icp",
            field="Psychographics - Momento atual",
            description="Missing or too brief",
            recommendation="Describe avatar's current life moment in 2-3 sentences"
        ))

    estado = extract_field_value(icp_section, r'Estado mental/emocional predominante:\s*\[.*?\]\s*(.+?)(?:\n\n|\Z)')
    if estado and len(estado) > 30:
        psycho_score += 10
    else:
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="icp",
            field="Psychographics - Estado emocional",
            description="Missing or too brief",
            recommendation="Describe avatar's emotional state"
        ))

    if 'o que mais valoriza' in icp_section.lower():
        psycho_score += 5

    score += psycho_score
    details['psychographics'] = {'score': psycho_score, 'max': 25}

    # Pain Points (30 pts)
    pain_score = 0
    if 'dor superficial' in icp_section.lower():
        pain_score += 5
    if 'dor real' in icp_section.lower():
        pain_score += 10
    if 'dor profunda' in icp_section.lower():
        pain_score += 10

    # Count top 5 frustrations
    frustration_pattern = r'^\s*\d+\.\s*(.+)$'
    frustrations = re.findall(frustration_pattern, icp_section, re.MULTILINE)
    if len(frustrations) >= 3:
        pain_score += 5

    if pain_score < 20:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="icp",
            field="Pain Points",
            description="Incomplete pain analysis (3 levels required)",
            recommendation="Define superficial, real, and deep pain + top 5 frustrations"
        ))

    score += pain_score
    details['pain_points'] = {'score': pain_score, 'max': 30}

    # Transformation (30 pts)
    transform_score = 0

    antes = extract_field_value(icp_section, r'\*\*Estado atual \(ANTES do curso\):\*\*\s*```\s*(.+?)```')
    if antes and len(antes) > 50:
        transform_score += 10

    depois = extract_field_value(icp_section, r'\*\*Estado desejado \(DEPOIS do curso\):\*\*\s*```\s*(.+?)```')
    if depois and len(depois) > 50:
        transform_score += 10

    if 'métrica primária' in icp_section.lower() or 'kpi' in icp_section.lower():
        transform_score += 10

    score += transform_score
    details['transformation'] = {'score': transform_score, 'max': 30}

    # Determine status
    if score >= 90:
        status = "✅ EXCELLENT"
    elif score >= 80:
        status = "✅ GOOD"
    elif score >= 70:
        status = "⚠️  MARGINAL"
    else:
        status = "❌ POOR"

    return ValidationResult(
        name="ICP Quality Score",
        score=score,
        max_score=max_score,
        status=status,
        issues=issues,
        details=details
    )


def validate_learning_objectives(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 3: Learning Objectives Quality
    Target: ≥80/100 (SMART criteria)
    """
    issues = []
    details = {}
    score = 0.0
    max_score = 100.0

    # Find objectives section
    obj_section = None
    for key in brief.sections:
        if 'objetivos de aprendizagem' in key.lower():
            obj_section = brief.sections[key]
            break

    if not obj_section:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="objectives",
            field="Section 3.2",
            description="Learning objectives section not found",
            recommendation="Add Section 3.2: Objetivos de Aprendizagem"
        ))
        return ValidationResult(
            name="Learning Objectives Quality",
            score=0,
            max_score=max_score,
            status="❌ FAIL",
            issues=issues,
            details={'error': 'Objectives section not found'}
        )

    # Extract objectives (numbered list)
    objective_pattern = r'^\s*(\d+)\.\s*(.+)$'
    objectives = re.findall(objective_pattern, obj_section, re.MULTILINE)

    # Filter out empty/placeholder objectives
    valid_objectives = [
        obj for num, obj in objectives
        if obj and not obj.startswith('[') and len(obj) > 10
    ]

    num_objectives = len(valid_objectives)
    details['objectives_defined'] = num_objectives

    if num_objectives < 5:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="objectives",
            field="Section 3.2",
            description=f"Only {num_objectives} objectives defined (need ≥5)",
            recommendation="Define at least 5 specific, measurable learning objectives"
        ))

    # SMART validation
    bloom_verbs = [
        'criar', 'implementar', 'construir', 'desenvolver', 'projetar',
        'analisar', 'avaliar', 'diagnosticar', 'comparar', 'diferenciar',
        'aplicar', 'usar', 'executar', 'resolver', 'demonstrar',
        'sintetizar', 'planejar', 'produzir', 'gerar', 'otimizar'
    ]

    vague_verbs = ['entender', 'saber', 'conhecer', 'aprender', 'compreender']

    smart_compliant = 0

    for num, obj_text in valid_objectives:
        obj_lower = obj_text.lower()

        # Check for Bloom's verbs (Measurable)
        has_bloom_verb = any(verb in obj_lower for verb in bloom_verbs)
        has_vague_verb = any(verb in obj_lower for verb in vague_verbs)

        if has_bloom_verb and not has_vague_verb:
            smart_compliant += 1
        else:
            issues.append(ValidationIssue(
                severity=IssueSeverity.WARNING,
                category="objectives",
                field=f"Objective {num}",
                description=f"Not measurable: \"{obj_text[:60]}...\"",
                recommendation="Use action verbs: criar, implementar, analisar, etc."
            ))

    # Calculate score
    if num_objectives > 0:
        # Time-bound (20 pts): Has minimum objectives
        time_score = 20 if num_objectives >= 5 else (num_objectives / 5 * 20)
        score += time_score

        # Specific (20 pts): Objectives are concrete
        specific_score = (smart_compliant / num_objectives * 20) if num_objectives > 0 else 0
        score += specific_score

        # Measurable (25 pts): Uses Bloom's verbs
        measurable_score = (smart_compliant / num_objectives * 25) if num_objectives > 0 else 0
        score += measurable_score

        # Achievable (15 pts): Not too ambitious (heuristic: <80 chars)
        achievable_count = sum(1 for _, obj in valid_objectives if len(obj) < 150)
        achievable_score = (achievable_count / num_objectives * 15) if num_objectives > 0 else 0
        score += achievable_score

        # Relevant (20 pts): Detailed enough (>30 chars)
        relevant_count = sum(1 for _, obj in valid_objectives if len(obj) > 30)
        relevant_score = (relevant_count / num_objectives * 20) if num_objectives > 0 else 0
        score += relevant_score

        details['smart_compliance'] = f"{smart_compliant}/{num_objectives}"
        details['bloom_verbs_used'] = f"{smart_compliant}/{num_objectives}"

    # Determine status
    if score >= 90:
        status = "✅ EXCELLENT"
    elif score >= 80:
        status = "✅ GOOD"
    elif score >= 70:
        status = "⚠️  MARGINAL"
    else:
        status = "❌ POOR"

    return ValidationResult(
        name="Learning Objectives Quality",
        score=score,
        max_score=max_score,
        status=status,
        issues=issues,
        details=details
    )


def validate_framework_coherence(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 4: Framework Coherence
    Target: No major misalignments between ICP, duration, framework, prerequisites
    """
    issues = []
    details = {}

    # Extract key data points
    icp_section = brief.sections.get([k for k in brief.sections if 'icp' in k.lower()][0] if any('icp' in k.lower() for k in brief.sections) else '', '')
    basic_section = brief.sections.get([k for k in brief.sections if 'informações básicas' in k.lower()][0] if any('informações básicas' in k.lower() for k in brief.sections) else '', '')
    pedagogy_section = brief.sections.get([k for k in brief.sections if 'pedagogia' in k.lower() or 'framework pedagógico' in k.lower()][0] if any('pedagogia' in k.lower() or 'framework pedagógico' in k.lower() for k in brief.sections) else '', '')

    # Check ICP ↔ Duration
    is_busy = any(word in icp_section.lower() for word in ['ocupado', 'busy', 'tempo limitado', 'rápido'])

    duration_match = re.search(r'(\d+)[+-]?\s*horas?', basic_section)
    duration_hours = int(duration_match.group(1)) if duration_match else None

    if is_busy and duration_hours and duration_hours > 15:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="coherence",
            field="ICP ↔ Duration",
            description=f"ICP says 'busy/ocupado' but course is {duration_hours}h (too long)",
            recommendation=f"Reduce to 8-12h or re-define ICP as having more time"
        ))

    # Check ICP ↔ Framework
    if is_busy and 'mastery learning' in pedagogy_section.lower():
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="coherence",
            field="ICP ↔ Framework",
            description="Busy ICP but 'Mastery Learning' requires time commitment",
            recommendation="Consider Microlearning or Flipped Classroom instead"
        ))

    # Check Prerequisites ↔ Objectives
    prereq_section = None
    for key in brief.sections:
        if 'pré-requisitos' in key.lower():
            prereq_section = brief.sections[key]
            break

    has_no_prereq = prereq_section and 'nenhum' in prereq_section.lower()

    obj_section = None
    for key in brief.sections:
        if 'objetivos de aprendizagem' in key.lower():
            obj_section = brief.sections[key]
            break

    if has_no_prereq and obj_section:
        advanced_terms = ['avançado', 'advanced', 'implementar api', 'configurar servidor', 'otimizar performance']
        if any(term in obj_section.lower() for term in advanced_terms):
            issues.append(ValidationIssue(
                severity=IssueSeverity.CRITICAL,
                category="coherence",
                field="Prerequisites ↔ Objectives",
                description="No prerequisites but objectives require advanced knowledge",
                recommendation="Add prerequisites or simplify objectives"
            ))

    # Determine status
    critical_count = sum(1 for issue in issues if issue.severity == IssueSeverity.CRITICAL)

    if critical_count == 0:
        status = "✅ ALIGNED"
    elif critical_count <= 1:
        status = "⚠️  MINOR ISSUES"
    else:
        status = "❌ MISALIGNED"

    details['critical_issues'] = critical_count
    details['total_issues'] = len(issues)

    return ValidationResult(
        name="Framework Coherence",
        score=0,  # Binary check, not scored
        max_score=0,
        status=status,
        issues=issues,
        details=details
    )


def validate_voice_clarity(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 5: Voice Clarity
    Target: Clear voice definition (MMOS or custom)
    """
    issues = []
    details = {}
    score = 0.0
    max_score = 100.0

    # Check MMOS configuration
    mmos_enabled = brief.frontmatter.get('mmos_persona', {}).get('enabled', False)

    if mmos_enabled:
        mind_slug = brief.frontmatter.get('mmos_persona', {}).get('mind_slug')

        if mind_slug:
            # Check if mind exists
            mind_path = Path(f"outputs/minds/{mind_slug}")
            if mind_path.exists():
                score = 100
                status = "✅ MMOS CONFIGURED"
                details['mode'] = 'MMOS'
                details['mind_slug'] = mind_slug
                details['mind_found'] = True
            else:
                issues.append(ValidationIssue(
                    severity=IssueSeverity.CRITICAL,
                    category="voice",
                    field="MMOS Mind",
                    description=f"Mind '{mind_slug}' not found at {mind_path}",
                    recommendation=f"Create mind first or change mind_slug"
                ))
                status = "❌ MIND NOT FOUND"
                details['mode'] = 'MMOS'
                details['mind_slug'] = mind_slug
                details['mind_found'] = False
        else:
            issues.append(ValidationIssue(
                severity=IssueSeverity.CRITICAL,
                category="voice",
                field="MMOS Configuration",
                description="MMOS enabled but mind_slug not specified",
                recommendation="Set mmos_persona.mind_slug in frontmatter"
            ))
            status = "❌ INCOMPLETE MMOS"
    else:
        # Check custom voice definition
        voice_section = None
        for key in brief.sections:
            if 'voz & personalidade' in key.lower():
                voice_section = brief.sections[key]
                break

        if not voice_section:
            score = 50  # Generic/neutral voice acceptable
            status = "⚠️  GENERIC VOICE"
            details['mode'] = 'Generic'
        else:
            # Count custom voice elements
            has_tone = 'tom geral:' in voice_section.lower()
            has_traits = re.search(r'personalidade em 3-5 traços:', voice_section, re.IGNORECASE)
            has_phrases = re.search(r'frases/bordões característicos', voice_section, re.IGNORECASE)
            has_boundaries = re.search(r'coisas que o instrutor nunca', voice_section, re.IGNORECASE)

            # Count defined elements
            elements_score = 0
            if has_tone:
                elements_score += 25
            if has_traits:
                elements_score += 25
            if has_phrases:
                elements_score += 25
            if has_boundaries:
                elements_score += 25

            score = elements_score

            if score >= 75:
                status = "✅ CUSTOM VOICE DEFINED"
            elif score >= 50:
                status = "⚠️  PARTIAL CUSTOM"
            else:
                status = "⚠️  WEAK CUSTOM"

            details['mode'] = 'Custom'
            details['elements_defined'] = {
                'tone': has_tone,
                'traits': bool(has_traits),
                'phrases': bool(has_phrases),
                'boundaries': bool(has_boundaries)
            }

            if score < 75:
                issues.append(ValidationIssue(
                    severity=IssueSeverity.WARNING,
                    category="voice",
                    field="Custom Voice",
                    description="Incomplete custom voice definition",
                    recommendation="Define all 4 elements: tone, traits, phrases, boundaries"
                ))

    return ValidationResult(
        name="Voice Clarity",
        score=score,
        max_score=max_score,
        status=status,
        issues=issues,
        details=details
    )


def validate_outline_quality(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 6: Outline Quality
    Target: Logical structure with clear progression
    """
    issues = []
    details = {}
    score = 0.0
    max_score = 100.0

    # Find outline section
    outline_section = None
    for key in brief.sections:
        if 'estrutura de conteúdo' in key.lower() or 'outline preliminar' in key.lower():
            outline_section = brief.sections[key]
            break

    if not outline_section:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="outline",
            field="Section 3.3",
            description="No outline provided",
            recommendation="Add preliminary course outline in Section 3.3"
        ))
        return ValidationResult(
            name="Outline Quality",
            score=0,
            max_score=max_score,
            status="❌ NO OUTLINE",
            issues=issues,
            details={'error': 'Outline section not found'}
        )

    # Count modules
    modules = re.findall(r'MÓDULO (\d+):', outline_section)
    num_modules = len(modules)

    # Count lessons
    lessons = re.findall(r'^\s*(\d+\.\d+)\s*-\s*(.+?)\s*\(', outline_section, re.MULTILINE)
    num_lessons = len(lessons)

    details['modules'] = num_modules
    details['lessons'] = num_lessons

    # Modular Structure (20 pts)
    if 3 <= num_modules <= 5:
        score += 20
    elif num_modules == 2 or num_modules == 6:
        score += 15
        issues.append(ValidationIssue(
            severity=IssueSeverity.INFO,
            category="outline",
            field="Module Count",
            description=f"{num_modules} modules (recommend 3-5)",
            recommendation="Consider 3-5 modules for optimal structure"
        ))
    elif num_modules >= 8:
        score += 10
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="outline",
            field="Module Count",
            description=f"{num_modules} modules (too fragmented)",
            recommendation="Consolidate into 3-5 modules"
        ))
    else:
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="outline",
            field="Module Count",
            description=f"Only {num_modules} module(s) defined",
            recommendation="Add at least 3 modules"
        ))

    # Lesson Count (20 pts)
    if 8 <= num_lessons <= 25:
        score += 20
    elif num_lessons < 5:
        score += 5
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="outline",
            field="Lesson Count",
            description=f"Only {num_lessons} lessons (too short)",
            recommendation="Add more lessons (target: 8-25)"
        ))
    elif num_lessons > 40:
        score += 10
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="outline",
            field="Lesson Count",
            description=f"{num_lessons} lessons (overwhelming)",
            recommendation="Reduce to 8-25 lessons"
        ))
    else:
        score += 15

    # Progression (30 pts) - Check if Module 1 is foundational
    if num_modules > 0:
        first_module = re.search(r'MÓDULO 1:\s*(.+?)(?:\n|$)', outline_section)
        if first_module:
            module_name = first_module.group(1).lower()
            is_foundational = any(word in module_name for word in ['fundamento', 'introdução', 'básico', 'início', 'setup', 'preparação'])
            if is_foundational:
                score += 30
            else:
                score += 20
                issues.append(ValidationIssue(
                    severity=IssueSeverity.INFO,
                    category="outline",
                    field="Progression",
                    description="Module 1 may not be foundational",
                    recommendation="Consider starting with foundations/setup"
                ))

    # Duration Consistency (30 pts) - Check if durations are specified
    lesson_durations = re.findall(r'\((\d+)\s*min\)', outline_section)
    if len(lesson_durations) >= num_lessons * 0.8:  # 80% have durations
        score += 30
    else:
        score += 15
        issues.append(ValidationIssue(
            severity=IssueSeverity.WARNING,
            category="outline",
            field="Duration",
            description="Missing lesson durations",
            recommendation="Specify duration for each lesson (e.g., 15 min)"
        ))

    # Determine status
    if score >= 85:
        status = "✅ GOOD"
    elif score >= 70:
        status = "⚠️  ACCEPTABLE"
    else:
        status = "❌ POOR"

    return ValidationResult(
        name="Outline Quality",
        score=score,
        max_score=max_score,
        status=status,
        issues=issues,
        details=details
    )


def detect_contradictions(brief: BriefData, verbose: bool = False) -> ValidationResult:
    """
    Check 7: Contradiction Detection
    Target: Zero critical contradictions
    """
    issues = []
    details = {}

    # Get sections
    icp_section = brief.sections.get([k for k in brief.sections if 'icp' in k.lower()][0] if any('icp' in k.lower() for k in brief.sections) else '', '')
    basic_section = brief.sections.get([k for k in brief.sections if 'informações básicas' in k.lower()][0] if any('informações básicas' in k.lower() for k in brief.sections) else '', '')
    commercial_section = brief.sections.get([k for k in brief.sections if 'comercial' in k.lower()][0] if any('comercial' in k.lower() for k in brief.sections) else '', '')

    # Check: Busy ICP + Long Course
    is_busy = any(word in icp_section.lower() for word in ['ocupado', 'busy', 'tempo limitado'])
    duration_match = re.search(r'(\d+)[+-]?\s*horas?', basic_section)
    duration_hours = int(duration_match.group(1)) if duration_match else None

    if is_busy and duration_hours and duration_hours > 20:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="contradiction",
            field="ICP ↔ Duration",
            description=f"'Busy/ocupado' ICP but {duration_hours}h course (severe mismatch)",
            recommendation=f"Reduce to 8-12h or change ICP"
        ))

    # Check: Free course + High price
    is_free = 'lead magnet' in commercial_section.lower() or 'grátis' in commercial_section.lower() or 'free' in commercial_section.lower()
    price_match = re.search(r'R\$\s*(\d+)', commercial_section)
    price = int(price_match.group(1)) if price_match else None

    if is_free and price and price > 100:
        issues.append(ValidationIssue(
            severity=IssueSeverity.CRITICAL,
            category="contradiction",
            field="Commercial Model",
            description=f"Marked as 'lead magnet/grátis' but price is R${price}",
            recommendation="Clarify if free or paid"
        ))

    # Check: Title promises quick but long duration
    title = extract_field_value(basic_section, r'\*\*Título do Curso:\*\*\s*```\s*(.+?)```')
    if title:
        quick_match = re.search(r'(\d+)\s*hora', title.lower())
        if quick_match and duration_hours:
            promised_hours = int(quick_match.group(1))
            if duration_hours > promised_hours * 1.5:
                issues.append(ValidationIssue(
                    severity=IssueSeverity.CRITICAL,
                    category="contradiction",
                    field="Title ↔ Duration",
                    description=f"Title promises {promised_hours}h but course is {duration_hours}h",
                    recommendation=f"Update title or reduce course to {promised_hours}h"
                ))

    # Count issues
    critical_count = sum(1 for issue in issues if issue.severity == IssueSeverity.CRITICAL)
    warning_count = sum(1 for issue in issues if issue.severity == IssueSeverity.WARNING)

    details['critical_issues'] = critical_count
    details['warnings'] = warning_count

    # Determine status
    if critical_count == 0 and warning_count == 0:
        status = "✅ NO CONTRADICTIONS"
    elif critical_count == 0:
        status = "⚠️  MINOR WARNINGS"
    else:
        status = "❌ CRITICAL CONTRADICTIONS"

    return ValidationResult(
        name="Contradiction Detection",
        score=0,  # Binary check
        max_score=0,
        status=status,
        issues=issues,
        details=details
    )


# ============================================================================
# REPORT GENERATION
# ============================================================================

def calculate_overall_score(results: List[ValidationResult]) -> float:
    """Calculate weighted overall quality score (0-100)."""
    weights = {
        'Completeness Check': 0.25,
        'ICP Quality Score': 0.20,
        'Learning Objectives Quality': 0.20,
        'Framework Coherence': 0.10,
        'Voice Clarity': 0.10,
        'Outline Quality': 0.15,
        'Contradiction Detection': 0.00  # Binary, affects pass/fail but not score
    }

    total_score = 0.0
    total_weight = 0.0

    for result in results:
        weight = weights.get(result.name, 0.0)
        if result.max_score > 0:  # Only scored checks
            normalized_score = (result.score / result.max_score) * 100
            total_score += normalized_score * weight
            total_weight += weight

    if total_weight == 0:
        return 0.0

    return total_score / total_weight


def generate_report(
    course_slug: str,
    brief: BriefData,
    results: List[ValidationResult],
    overall_score: float,
    verbose: bool = False
) -> str:
    """Generate formatted validation report."""

    # Determine overall status
    critical_issues = sum(
        len([i for i in r.issues if i.severity == IssueSeverity.CRITICAL])
        for r in results
    )

    if overall_score >= 80 and critical_issues == 0:
        overall_status = ValidationLevel.PASS
        can_proceed = True
    elif overall_score >= 70 and critical_issues == 0:
        overall_status = ValidationLevel.MARGINAL
        can_proceed = True
    else:
        overall_status = ValidationLevel.FAIL
        can_proceed = False

    # Build report
    lines = []
    lines.append("📊 COURSE BRIEF VALIDATION REPORT")
    lines.append(f"Course: {course_slug}")
    lines.append(f"Validated: {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    lines.append("")
    lines.append("━" * 60)
    lines.append("")

    # Individual checks
    for result in results:
        lines.append(f"{result.status} {result.name.upper()}")

        if result.max_score > 0:
            lines.append(f"   Score: {result.score:.0f}/{result.max_score:.0f} ({result.percentage:.0f}%)")

        if verbose and result.details:
            for key, value in result.details.items():
                if isinstance(value, dict):
                    lines.append(f"   {key}: {value}")
                else:
                    lines.append(f"   {key}: {value}")

        # Show critical issues
        critical = [i for i in result.issues if i.severity == IssueSeverity.CRITICAL]
        if critical:
            lines.append("   Critical issues:")
            for issue in critical[:3]:  # Show max 3
                lines.append(f"     ❌ {issue.description}")
                lines.append(f"        Fix: {issue.recommendation}")

        # Show warnings in verbose mode
        if verbose:
            warnings = [i for i in result.issues if i.severity == IssueSeverity.WARNING]
            if warnings:
                lines.append("   Warnings:")
                for issue in warnings[:2]:  # Show max 2
                    lines.append(f"     ⚠️  {issue.description}")

        lines.append("")

    lines.append("━" * 60)
    lines.append("")
    lines.append(f"🎯 OVERALL RESULT: {overall_status.value}")
    lines.append("")
    lines.append(f"📊 QUALITY SCORE: {overall_score:.0f}/100")
    lines.append("")

    if can_proceed:
        lines.append("✅ SAFE TO PROCEED with market research and curriculum generation.")
    else:
        lines.append("🚨 CANNOT PROCEED - Critical issues must be resolved before generation.")

    # Recommendations
    all_critical = []
    for result in results:
        all_critical.extend([i for i in result.issues if i.severity == IssueSeverity.CRITICAL])

    if all_critical:
        lines.append("")
        lines.append("📋 CRITICAL ACTIONS REQUIRED:")
        for i, issue in enumerate(all_critical, 1):
            lines.append(f"  {i}. ✅ {issue.recommendation}")

    lines.append("")
    lines.append(f"💾 Report saved: outputs/courses/{course_slug}/validation-brief-report.md")

    return '\n'.join(lines)


def save_report(course_slug: str, report: str) -> None:
    """Save validation report to course folder."""
    course_path = Path(f"outputs/courses/{course_slug}")
    course_path.mkdir(parents=True, exist_ok=True)

    report_path = course_path / "validation-brief-report.md"
    report_path.write_text(report, encoding='utf-8')


# ============================================================================
# MAIN EXECUTION
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="Validate COURSE-BRIEF.md quality before generation",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python validate_course_brief.py clone-ia-express
  python validate_course_brief.py my-course --strict
  python validate_course_brief.py my-course --verbose

Exit Codes:
  0 - PASS (quality ≥80)
  1 - FAIL (quality <70)
  2 - MARGINAL PASS (quality 70-79)
  3 - Error (file not found, parsing error)
        """
    )

    parser.add_argument('slug', help='Course slug (e.g., clone-ia-express)')
    parser.add_argument('--strict', action='store_true',
                        help='Fail on warnings (not just critical issues)')
    parser.add_argument('--verbose', action='store_true',
                        help='Show detailed field-by-field analysis')

    args = parser.parse_args()

    # Find COURSE-BRIEF.md
    brief_path = Path(f"outputs/courses/{args.slug}/COURSE-BRIEF.md")

    if not brief_path.exists():
        print(f"❌ Error: Course '{args.slug}' not found")
        print(f"\nExpected location: {brief_path}")
        print(f"\nCreate course first: @course-architect *new {args.slug}")
        return 3

    try:
        # Parse brief
        brief = parse_course_brief(brief_path)

        # Run all validations
        results = [
            validate_completeness(brief, args.verbose),
            validate_icp_quality(brief, args.verbose),
            validate_learning_objectives(brief, args.verbose),
            validate_framework_coherence(brief, args.verbose),
            validate_voice_clarity(brief, args.verbose),
            validate_outline_quality(brief, args.verbose),
            detect_contradictions(brief, args.verbose),
        ]

        # Calculate overall score
        overall_score = calculate_overall_score(results)

        # Generate report
        report = generate_report(args.slug, brief, results, overall_score, args.verbose)

        # Print report
        print(report)

        # Save report
        save_report(args.slug, report)

        # Determine exit code
        critical_count = sum(
            len([i for i in r.issues if i.severity == IssueSeverity.CRITICAL])
            for r in results
        )

        if overall_score >= 80 and critical_count == 0:
            return 0  # PASS
        elif overall_score >= 70 and critical_count == 0:
            if args.strict:
                return 1  # FAIL (strict mode)
            else:
                return 2  # MARGINAL PASS
        else:
            return 1  # FAIL

    except FileNotFoundError as e:
        print(f"❌ Error: {e}")
        return 3
    except ValueError as e:
        print(f"❌ Parsing Error: {e}")
        return 3
    except Exception as e:
        print(f"❌ Unexpected Error: {e}")
        import traceback
        traceback.print_exc()
        return 3


if __name__ == '__main__':
    sys.exit(main())
