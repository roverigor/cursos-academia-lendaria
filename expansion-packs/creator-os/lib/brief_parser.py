#!/usr/bin/env python3
"""
COURSE-BRIEF Parser for CreatorOS
Parses all 8 sections of COURSE-BRIEF.md into structured data

This module extracts content from the unified COURSE-BRIEF.md document
and provides structured access to all sections for downstream generators.

Usage:
    from lib.brief_parser import BriefParser

    parser = BriefParser("outputs/courses/my-course/COURSE-BRIEF.md")
    brief = parser.parse()

    # Access structured data
    print(brief.title)
    print(brief.icp.demographics)
    print(brief.learning_objectives)
    print(brief.voice_profile.tone)
"""

import re
import yaml
import logging
from pathlib import Path
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any

# Database persistence integration
from lib.db_persister import CoursePersister

logger = logging.getLogger(__name__)


@dataclass
class BasicInfo:
    """Section 1: Basic course information."""
    title: str = ""
    subtitle: str = ""
    slug: str = ""
    category: str = ""
    tags: List[str] = field(default_factory=list)
    course_type: str = ""  # "technical", "conceptual", "mixed"
    tool_name: str = ""  # Main tool/framework (if technical)
    total_duration_hours: int = 0
    modules_count: int = 0
    lessons_count: int = 0
    knowledge_level: str = ""
    prerequisites: List[str] = field(default_factory=list)


@dataclass
class ICP:
    """Section 2: Ideal Customer Profile."""
    demographics: Dict[str, str] = field(default_factory=dict)
    psychographics: Dict[str, str] = field(default_factory=dict)
    pain_points: List[str] = field(default_factory=list)
    goals: List[str] = field(default_factory=list)
    current_state: str = ""
    desired_state: str = ""
    archetypes: List[str] = field(default_factory=list)


@dataclass
class ContentPedagogy:
    """Section 3: Content & Pedagogy."""
    learning_objectives: List[str] = field(default_factory=list)
    preliminary_outline: str = ""
    pedagogical_framework: str = "GPS + Didática Lendária"
    content_depth: str = ""
    practical_vs_theory_ratio: str = ""
    key_concepts: List[str] = field(default_factory=list)


@dataclass
class VoiceProfile:
    """Section 4: Voice & Personality."""
    mode: str = "generic"  # generic, mmos, custom
    instructor_name: Optional[str] = None
    mmos_persona_slug: Optional[str] = None
    tone: str = ""
    style: str = ""
    personality_traits: List[str] = field(default_factory=list)
    signature_phrases: List[str] = field(default_factory=list)
    teaching_approach: str = ""


@dataclass
class FormatDelivery:
    """Section 5: Format & Delivery."""
    teaching_style: str = ""
    course_structure: str = ""
    content_formats: List[str] = field(default_factory=list)
    engagement_tactics: List[str] = field(default_factory=list)
    assessment_types: List[str] = field(default_factory=list)


@dataclass
class Commercial:
    """Section 6: Commercial & Launch."""
    pricing_model: str = ""
    target_price: str = ""
    target_revenue: str = ""
    launch_strategy: str = ""
    marketing_channels: List[str] = field(default_factory=list)
    unique_selling_points: List[str] = field(default_factory=list)


@dataclass
class AdditionalContext:
    """Section 7: Additional Context."""
    inspiration_sources: List[str] = field(default_factory=list)
    competitive_analysis: str = ""
    constraints: List[str] = field(default_factory=list)
    success_metrics: List[str] = field(default_factory=list)
    timeline: str = ""


@dataclass
class CourseBrief:
    """Complete parsed COURSE-BRIEF data structure."""
    # Metadata (from frontmatter)
    creation_mode: str = "greenfield"
    status: str = ""
    course_slug: str = ""
    created_date: str = ""
    instructor: str = ""
    mmos_persona: Dict[str, Any] = field(default_factory=dict)

    # Sections (from markdown)
    basic_info: BasicInfo = field(default_factory=BasicInfo)
    icp: ICP = field(default_factory=ICP)
    content: ContentPedagogy = field(default_factory=ContentPedagogy)
    voice: VoiceProfile = field(default_factory=VoiceProfile)
    format: FormatDelivery = field(default_factory=FormatDelivery)
    commercial: Commercial = field(default_factory=Commercial)
    context: AdditionalContext = field(default_factory=AdditionalContext)

    # Convenience properties
    @property
    def title(self) -> str:
        return self.basic_info.title

    @property
    def learning_objectives(self) -> List[str]:
        return self.content.learning_objectives

    @property
    def voice_profile(self) -> VoiceProfile:
        return self.voice


class BriefParser:
    """
    Parser for COURSE-BRIEF.md files.

    Extracts all 8 sections into structured data objects.
    """

    def __init__(self, brief_path: str, creator_mind_id: Optional[str] = None, persona_mind_id: Optional[str] = None):
        """
        Initialize parser.

        Args:
            brief_path: Path to COURSE-BRIEF.md file
            creator_mind_id: UUID of mind creating the course (for database persistence)
            persona_mind_id: UUID of persona mind (voice to emulate)
        """
        self.brief_path = Path(brief_path)
        self.creator_mind_id = creator_mind_id
        self.persona_mind_id = persona_mind_id
        self.project_id = None  # Will be set after database persistence

        # Initialize database persister
        self.persister = CoursePersister()

        if not self.brief_path.exists():
            raise FileNotFoundError(f"COURSE-BRIEF.md not found: {brief_path}")

    def parse(self) -> CourseBrief:
        """
        Parse complete COURSE-BRIEF.md file.

        Returns:
            CourseBrief object with all sections populated
        """
        with open(self.brief_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Parse frontmatter
        frontmatter_match = re.match(r'^---\n(.*?)\n---\n(.*)', content, re.DOTALL)

        if not frontmatter_match:
            raise ValueError("Invalid COURSE-BRIEF format: missing frontmatter")

        frontmatter_yaml = frontmatter_match.group(1)
        markdown_content = frontmatter_match.group(2)

        metadata = yaml.safe_load(frontmatter_yaml)

        # Initialize CourseBrief with metadata
        brief = CourseBrief(
            creation_mode=metadata.get("creation_mode", "greenfield"),
            status=metadata.get("status", ""),
            course_slug=metadata.get("course_slug", ""),
            created_date=metadata.get("created_date", ""),
            instructor=metadata.get("instructor", ""),
            mmos_persona=metadata.get("mmos_persona", {})
        )

        # Parse markdown sections
        sections = self._extract_sections(markdown_content)

        # Populate each section
        brief.basic_info = self._parse_section_1(sections.get(1, ""))
        brief.icp = self._parse_section_2(sections.get(2, ""))
        brief.content = self._parse_section_3(sections.get(3, ""))
        brief.voice = self._parse_section_4(sections.get(4, ""), metadata.get("mmos_persona", {}))
        brief.format = self._parse_section_5(sections.get(5, ""))
        brief.commercial = self._parse_section_6(sections.get(6, ""))
        brief.context = self._parse_section_7(sections.get(7, ""))

        # Database persistence (after filesystem write succeeds)
        self._persist_to_database(brief)

        return brief

    def _extract_sections(self, content: str) -> Dict[int, str]:
        """Extract content by section number."""
        sections = {}

        # Match sections: ## 1️⃣ ... through ## 8️⃣
        section_pattern = r'##\s+([0-9]).*?\n(.*?)(?=##\s+[0-9]|$)'
        matches = re.findall(section_pattern, content, re.DOTALL)

        for num_str, body in matches:
            num = int(num_str)
            sections[num] = body.strip()

        return sections

    def _parse_section_1(self, content: str) -> BasicInfo:
        """Parse Section 1: Basic Info."""
        info = BasicInfo()

        # Extract title (between ``` markers or direct text)
        title_match = re.search(r'\*\*Título do Curso:\*\*\s*```\s*(.+?)\s*```', content, re.DOTALL)
        if title_match:
            info.title = title_match.group(1).strip()

        # Extract subtitle
        subtitle_match = re.search(r'\*\*Subtítulo.*?\*\*\s*```\s*(.+?)\s*```', content, re.DOTALL)
        if subtitle_match:
            info.subtitle = subtitle_match.group(1).strip()

        # Extract slug
        slug_match = re.search(r'\*\*Slug.*?\*\*\s*```\s*(.+?)\s*```', content, re.DOTALL)
        if slug_match:
            info.slug = slug_match.group(1).strip()

        # Extract tags (numbered list)
        tags = re.findall(r'^\d+\.\s*(.+)$', content, re.MULTILINE)
        info.tags = [tag.strip() for tag in tags if tag.strip() and not tag.strip().startswith('[')]

        # Extract course type (technical, conceptual, mixed)
        if re.search(r'\[x\].*?TÉCNICO', content, re.IGNORECASE):
            info.course_type = "technical"
        elif re.search(r'\[x\].*?CONCEITUAL', content, re.IGNORECASE):
            info.course_type = "conceptual"
        elif re.search(r'\[x\].*?MISTO', content, re.IGNORECASE):
            info.course_type = "mixed"

        # Extract tool name (if technical)
        tool_match = re.search(r'Ferramenta:\s*(.+)', content, re.IGNORECASE)
        if tool_match:
            tool = tool_match.group(1).strip()
            if tool and tool != '_______________':  # Ignore placeholder
                info.tool_name = tool

        # Extract duration
        duration_match = re.search(r'(\d+)\s*horas?\s*totais?', content, re.IGNORECASE)
        if duration_match:
            info.total_duration_hours = int(duration_match.group(1))

        return info

    def _parse_section_2(self, content: str) -> ICP:
        """Parse Section 2: ICP."""
        icp = ICP()

        # Extract demographics (look for bullet points under demographics heading)
        demographics_section = re.search(r'demográfic[ao]s?.*?\n(.*?)(?=###|\Z)', content, re.IGNORECASE | re.DOTALL)
        if demographics_section:
            bullets = re.findall(r'[-*]\s*\*\*(.+?):\*\*\s*(.+)', demographics_section.group(1))
            icp.demographics = {key.strip(): value.strip() for key, value in bullets}

        # Extract pain points
        pain_points = re.findall(r'[-*]\s*(?:Dor|Pain).*?:\s*(.+)', content, re.IGNORECASE)
        icp.pain_points = [p.strip() for p in pain_points]

        # Extract goals
        goals = re.findall(r'[-*]\s*(?:Meta|Goal|Objetivo).*?:\s*(.+)', content, re.IGNORECASE)
        icp.goals = [g.strip() for g in goals]

        return icp

    def _parse_section_3(self, content: str) -> ContentPedagogy:
        """Parse Section 3: Content & Pedagogy."""
        pedagogy = ContentPedagogy()

        # Extract learning objectives (numbered or bulleted list)
        objectives = re.findall(r'(?:^|\n)[-*\d.]+\s*(.+?)(?=\n|$)', content)
        pedagogy.learning_objectives = [obj.strip() for obj in objectives if len(obj.strip()) > 10]

        # Extract preliminary outline (section between markers)
        outline_match = re.search(r'esboço.*?\n```\s*(.+?)\s*```', content, re.IGNORECASE | re.DOTALL)
        if outline_match:
            pedagogy.preliminary_outline = outline_match.group(1).strip()

        return pedagogy

    def _parse_section_4(self, content: str, mmos_metadata: Dict) -> VoiceProfile:
        """Parse Section 4: Voice & Personality."""
        voice = VoiceProfile()

        # Check if MMOS is enabled from metadata
        if mmos_metadata.get("enabled"):
            voice.mode = "mmos"
            voice.mmos_persona_slug = mmos_metadata.get("persona_slug")
            voice.instructor_name = mmos_metadata.get("mind_name")
        else:
            voice.mode = "generic"

        # Extract tone
        tone_match = re.search(r'tom.*?:\s*(.+)', content, re.IGNORECASE)
        if tone_match:
            voice.tone = tone_match.group(1).strip()

        # Extract style
        style_match = re.search(r'estilo.*?:\s*(.+)', content, re.IGNORECASE)
        if style_match:
            voice.style = style_match.group(1).strip()

        return voice

    def _parse_section_5(self, content: str) -> FormatDelivery:
        """Parse Section 5: Format & Delivery."""
        format_delivery = FormatDelivery()

        # Extract teaching style
        style_match = re.search(r'estilo.*?ensino.*?:\s*(.+)', content, re.IGNORECASE)
        if style_match:
            format_delivery.teaching_style = style_match.group(1).strip()

        # Extract content formats (checkboxes or bullets)
        formats = re.findall(r'\[x\]\s*(.+)', content, re.IGNORECASE)
        format_delivery.content_formats = [f.strip() for f in formats]

        return format_delivery

    def _parse_section_6(self, content: str) -> Commercial:
        """Parse Section 6: Commercial."""
        commercial = Commercial()

        # Extract pricing
        price_match = re.search(r'preço.*?:\s*(.+)', content, re.IGNORECASE)
        if price_match:
            commercial.target_price = price_match.group(1).strip()

        return commercial

    def _parse_section_7(self, content: str) -> AdditionalContext:
        """Parse Section 7: Additional Context."""
        context = AdditionalContext()

        # Extract constraints (bulleted list)
        constraints = re.findall(r'[-*]\s*(?:Constraint|Restrição).*?:\s*(.+)', content, re.IGNORECASE)
        context.constraints = [c.strip() for c in constraints]

        # Extract success metrics
        metrics = re.findall(r'[-*]\s*(?:Métrica|KPI).*?:\s*(.+)', content, re.IGNORECASE)
        context.success_metrics = [m.strip() for m in metrics]

        return context

    def _persist_to_database(self, brief: CourseBrief) -> None:
        """
        Persist course project to database.

        This is called AFTER filesystem write succeeds. If database write fails,
        it's logged but doesn't prevent course generation from continuing.

        Args:
            brief: Parsed CourseBrief object with all course data
        """
        # Prepare ICP metadata
        icp_metadata = {
            'demographics': brief.icp.demographics,
            'psychographics': brief.icp.psychographics,
            'pain_points': brief.icp.pain_points,
            'goals': brief.icp.goals,
            'current_state': brief.icp.current_state,
            'desired_state': brief.icp.desired_state,
            'archetypes': brief.icp.archetypes
        }

        # Prepare curriculum metadata
        curriculum_metadata = {
            'learning_objectives': brief.content.learning_objectives,
            'pedagogical_framework': brief.content.pedagogical_framework,
            'content_depth': brief.content.content_depth,
            'practical_vs_theory_ratio': brief.content.practical_vs_theory_ratio,
            'key_concepts': brief.content.key_concepts,
            'total_modules': brief.basic_info.modules_count,
            'total_lessons': brief.basic_info.lessons_count,
            'total_duration_hours': brief.basic_info.total_duration_hours
        }

        # Prepare complete metadata
        project_metadata = {
            'icp': icp_metadata,
            'curriculum': curriculum_metadata,
            'voice': {
                'mode': brief.voice.mode,
                'instructor_name': brief.voice.instructor_name,
                'mmos_persona_slug': brief.voice.mmos_persona_slug,
                'tone': brief.voice.tone,
                'style': brief.voice.style,
                'personality_traits': brief.voice.personality_traits,
                'teaching_approach': brief.voice.teaching_approach
            },
            'format': {
                'teaching_style': brief.format.teaching_style,
                'course_structure': brief.format.course_structure,
                'content_formats': brief.format.content_formats,
                'engagement_tactics': brief.format.engagement_tactics,
                'assessment_types': brief.format.assessment_types
            },
            'commercial': {
                'pricing_model': brief.commercial.pricing_model,
                'target_price': brief.commercial.target_price,
                'target_revenue': brief.commercial.target_revenue,
                'launch_strategy': brief.commercial.launch_strategy,
                'marketing_channels': brief.commercial.marketing_channels,
                'unique_selling_points': brief.commercial.unique_selling_points
            },
            'tags': brief.basic_info.tags,
            'category': brief.basic_info.category,
            'course_type': brief.basic_info.course_type,
            'knowledge_level': brief.basic_info.knowledge_level,
            'prerequisites': brief.basic_info.prerequisites
        }

        # Persist to database
        self.project_id = self.persister.persist_project(
            slug=brief.course_slug or brief.basic_info.slug,
            name=brief.title,
            creator_mind_id=self.creator_mind_id,
            persona_mind_id=self.persona_mind_id or brief.mmos_persona.get('slug'),
            project_type='course',
            description=brief.basic_info.subtitle,
            metadata=project_metadata
        )

        if self.project_id:
            logger.info(f"✓ Course project persisted to database: {self.project_id}")
        else:
            logger.info("Database persistence skipped (feature flag off or error)")


# Utility functions

def load_brief(course_slug: str) -> CourseBrief:
    """
    Load and parse COURSE-BRIEF.md for a course.

    Args:
        course_slug: Course identifier

    Returns:
        Parsed CourseBrief object
    """
    brief_path = Path(f"outputs/courses/{course_slug}/COURSE-BRIEF.md")
    parser = BriefParser(str(brief_path))
    return parser.parse()


def validate_brief_completeness(brief: CourseBrief) -> Dict[str, Any]:
    """
    Validate that COURSE-BRIEF has required content filled.

    Args:
        brief: Parsed CourseBrief object

    Returns:
        Validation result dict with 'valid', 'errors', 'warnings'
    """
    errors = []
    warnings = []

    # Check required fields
    if not brief.title or len(brief.title) < 5:
        errors.append("Section 1: Title is missing or too short")

    if not brief.learning_objectives or len(brief.learning_objectives) == 0:
        errors.append("Section 3: No learning objectives defined")

    if brief.basic_info.total_duration_hours == 0:
        warnings.append("Section 1: Total duration not specified")

    if len(brief.icp.pain_points) == 0:
        warnings.append("Section 2: No pain points defined for ICP")

    return {
        "valid": len(errors) == 0,
        "errors": errors,
        "warnings": warnings
    }


# Example usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python brief_parser.py <course_slug>")
        sys.exit(1)

    course_slug = sys.argv[1]

    try:
        brief = load_brief(course_slug)

        print(f"\n✅ Parsed COURSE-BRIEF for: {brief.title}")
        print(f"   Slug: {brief.course_slug}")
        print(f"   Mode: {brief.creation_mode}")
        print(f"   Duration: {brief.basic_info.total_duration_hours} hours")
        print(f"   Objectives: {len(brief.learning_objectives)}")
        print(f"   Voice Mode: {brief.voice.mode}")
        print("")

        validation = validate_brief_completeness(brief)

        if validation["valid"]:
            print("✅ COURSE-BRIEF is complete and valid")
        else:
            print("❌ COURSE-BRIEF has errors:")
            for error in validation["errors"]:
                print(f"   - {error}")

        if validation["warnings"]:
            print("\n⚠️  Warnings:")
            for warning in validation["warnings"]:
                print(f"   - {warning}")

    except Exception as e:
        print(f"❌ Error parsing COURSE-BRIEF: {e}")
        sys.exit(1)
