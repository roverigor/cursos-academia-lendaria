#!/usr/bin/env python3
"""
Gap Analyzer for CreatorOS Smart Elicitation Workflow

This module implements intelligent gap analysis for COURSE-BRIEF completeness detection.
Part of Story 3.6: Gap Analysis & Smart Elicitation (EPIC-3: Intelligent Workflow)

Key Features:
- Section-level completeness analysis (8 sections)
- Subsection-level granularity for fine-grained detection
- Status indicators (🟢/🟡/🔴) for each section
- Confidence scoring (0-100%)
- Placeholder detection (empty fields vs. auto-filled data)
- Smart question generation (skip complete sections)
- Answer persistence back to COURSE-BRIEF.md

Gap Analysis Dimensions:
1. Section 1 (Basic Info): Title, slug, category, duration
2. Section 2 (ICP): Demographics, psychographics, pain points, goals
3. Section 3 (Content): Objectives, framework, prerequisites
4. Section 4 (Voice): Tone, style, phrases, greeting
5. Section 5 (Format): Lesson duration, format, assessments
6. Section 6 (Commercial): Pricing, launch date, upsells
7. Section 7 (Context): References to legacy materials
8. Section 8 (Checklist): Final validation items

Usage:
    from lib.gap_analyzer import GapAnalyzer

    analyzer = GapAnalyzer("dominando-obsidian")
    completeness = analyzer.analyze_completeness()
    questions = analyzer.generate_questions(completeness)
    analyzer.persist_answers(answers)
"""

import os
import re
import yaml
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional
from dataclasses import dataclass, asdict, field


@dataclass
class SectionStatus:
    """Status of a COURSE-BRIEF section."""
    section_id: str  # e.g., "section_2_icp"
    section_name: str  # e.g., "ICP & Target Audience"
    status: str  # 🟢 (complete), 🟡 (partial), 🔴 (missing)
    completeness: int  # 0-100 percentage
    subsections: Dict[str, str]  # Subsection name → status (🟢/🟡/🔴)
    fields: Dict[str, str]  # Field name → status (🟢/🟡/🔴)


@dataclass
class CompletenessMap:
    """Complete analysis of COURSE-BRIEF status."""
    overall_score: int  # 0-100 percentage
    sections: Dict[str, SectionStatus]  # section_id → SectionStatus
    analyzed_at: str  # ISO timestamp
    brief_path: str  # Path to COURSE-BRIEF.md


@dataclass
class Question:
    """A question for elicitation."""
    question_id: str  # Unique identifier
    section_id: str  # Which section this fills
    question_type: str  # "elicitation" or "confirmation"
    prompt: str  # Question text
    input_type: str  # "text", "multiple_choice", "multiple_select", "confirmation"
    options: List[Dict[str, str]]  # For multiple choice/select
    default_value: Optional[str] = None  # Pre-filled data for confirmation
    on_yes: Optional[str] = None  # Action if confirmed
    on_no: Optional[str] = None  # Action if rejected


@dataclass
class Answer:
    """User's answer to a question."""
    question_id: str
    answer_type: str  # "elicitation" or "confirmation"
    value: str  # Answer value
    timestamp: str  # ISO timestamp


class GapAnalyzer:
    """
    Intelligent gap analyzer for COURSE-BRIEF completeness detection.

    Analyzes which sections are complete, partial, or missing, and generates
    targeted questions to fill only the gaps.

    MMOS Integration:
    - If MMOS persona enabled, Section 4 (Voice) is automatically marked as 🟢
    - No voice-related questions will be generated
    - Gap analysis summary will show "Loaded from MMOS mind"
    """

    def __init__(self, course_slug: str, mmos_config: Optional[Dict] = None):
        """
        Initialize GapAnalyzer for a specific course.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
            mmos_config: MMOS persona configuration (if MMOS enabled)
        """
        self.course_slug = course_slug
        self.mmos_config = mmos_config or {}
        self.base_path = Path("outputs/courses") / course_slug
        self.brief_path = self.base_path / "COURSE-BRIEF.md"

        if not self.brief_path.exists():
            raise FileNotFoundError(f"COURSE-BRIEF.md not found at: {self.brief_path}")

        self.brief_content = self._read_brief()
        self.completeness_map: Optional[CompletenessMap] = None

    def _read_brief(self) -> str:
        """Read COURSE-BRIEF.md content."""
        with open(self.brief_path, 'r', encoding='utf-8') as f:
            return f.read()

    def _extract_section(self, section_heading: str) -> str:
        """
        Extract a section from COURSE-BRIEF.md by heading.

        Args:
            section_heading: Section heading (e.g., "## 2️⃣ PÚBLICO-ALVO")

        Returns:
            Section content (text between this heading and next section)
        """
        # Escape special regex characters in heading
        escaped_heading = re.escape(section_heading)

        # Match section from heading to next heading or end of file
        pattern = rf'{escaped_heading}(.*?)(?=\n## |\Z)'
        match = re.search(pattern, self.brief_content, re.DOTALL)

        if match:
            return match.group(1).strip()
        return ""

    def _has_placeholder_text(self, text: str) -> bool:
        """
        Check if text contains placeholder patterns (indicates empty fields).

        Placeholder patterns:
        - _[text] or [text]
        - {text}
        - AUTO-PREENCHIDO
        - [ ] (empty checkbox)
        - _____
        - Exemplo: (followed by empty line)
        """
        placeholder_patterns = [
            r'\[_.*?\]',  # [_text_]
            r'_\[.*?\]',  # _[text]
            r'\{.*?\}',  # {text}
            r'AUTO-PREENCHIDO',
            r'\[\s*\]',  # Empty checkbox
            r'_{3,}',  # Multiple underscores
            r'Exemplo:.*?\n\s*\n',  # Example followed by blank line
        ]

        for pattern in placeholder_patterns:
            if re.search(pattern, text):
                return True
        return False

    def _has_meaningful_content(self, text: str, min_words: int = 10) -> bool:
        """
        Check if text has meaningful content (not just structure/labels).

        Args:
            text: Text to analyze
            min_words: Minimum word count for meaningful content

        Returns:
            True if text has substantial content
        """
        # Remove markdown formatting
        clean_text = re.sub(r'[#*`\[\]_-]', '', text)
        # Remove empty lines
        clean_text = re.sub(r'\n\s*\n', '\n', clean_text)
        # Count words
        words = clean_text.split()

        return len(words) >= min_words and not self._has_placeholder_text(text)

    def analyze_section_1(self) -> SectionStatus:
        """Analyze Section 1: Basic Information."""
        section_text = self._extract_section("## 1️⃣ INFORMAÇÕES BÁSICAS DO CURSO")

        # Check subsections
        title_text = self._extract_section("### 1.1. Identificação")
        duration_text = self._extract_section("### 1.2. Duração e Estrutura")

        # Check fields
        has_title = bool(re.search(r'\*\*Título do Curso:\*\*.*?\n```\n(.+?)\n```', section_text, re.DOTALL))
        has_slug = bool(re.search(r'\*\*Slug.*?\n```\n(.+?)\n```', section_text, re.DOTALL))
        has_category = bool(re.search(r'\[x\]', section_text))  # Any checkbox marked
        has_duration = bool(re.search(r'\[x\].*?(horas|aulas)', duration_text, re.IGNORECASE))

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        fields = {
            "title": "🟢" if has_title and not has_placeholders else "🔴",
            "slug": "🟢" if has_slug else "🟡",
            "category": "🟢" if has_category else "🔴",
            "duration": "🟢" if has_duration else "🟡"
        }

        filled_count = sum(1 for status in fields.values() if status == "🟢")
        completeness = int((filled_count / len(fields)) * 100)

        if completeness == 100:
            status = "🟢"
        elif completeness >= 50:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_1_basic_info",
            section_name="Basic Information",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_2(self) -> SectionStatus:
        """Analyze Section 2: ICP & Target Audience."""
        section_text = self._extract_section("## 2️⃣ PÚBLICO-ALVO & ICP")

        # Check subsections
        demographics_text = self._extract_section("### 2.1. Quem é o aluno ideal?")
        pain_text = self._extract_section("### 2.2. Dores & Problemas")
        goals_text = self._extract_section("### 2.3. Desejo & Transformação")

        # Check each subsection for content
        has_demographics = self._has_meaningful_content(demographics_text, min_words=20)
        has_psychographics = bool(re.search(r'Contexto psicográfico.*?\n```\n(.+?)\n```', demographics_text, re.DOTALL))
        has_pain_points = self._has_meaningful_content(pain_text, min_words=15)
        has_goals = self._has_meaningful_content(goals_text, min_words=15)

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        subsections = {
            "demographics": "🟢" if has_demographics and not has_placeholders else ("🟡" if has_demographics else "🔴"),
            "psychographics": "🟢" if has_psychographics and not has_placeholders else ("🟡" if has_psychographics else "🔴"),
            "pain_points": "🟢" if has_pain_points and not has_placeholders else "🔴",
            "goals": "🟢" if has_goals and not has_placeholders else "🔴"
        }

        filled_count = sum(1 for status in subsections.values() if status == "🟢")
        completeness = int((filled_count / len(subsections)) * 100)

        if completeness == 100:
            status = "🟢"
        elif completeness >= 50:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_2_icp",
            section_name="ICP & Target Audience",
            status=status,
            completeness=completeness,
            subsections=subsections,
            fields={}
        )

    def analyze_section_3(self) -> SectionStatus:
        """Analyze Section 3: Content & Pedagogy."""
        section_text = self._extract_section("## 3️⃣ CONTEÚDO & PEDAGOGIA")

        # Check fields
        objectives_text = self._extract_section("### 3.2. Objetivos de Aprendizagem")
        framework_text = re.search(r'Framework pedagógico.*?\n```(.*?)```', section_text, re.DOTALL)
        prerequisites_text = re.search(r'pré-requisitos.*?\n```(.*?)```', section_text, re.DOTALL | re.IGNORECASE)

        has_objectives = self._has_meaningful_content(objectives_text, min_words=20)
        has_framework = bool(framework_text) and self._has_meaningful_content(framework_text.group(1), min_words=10)
        has_prerequisites = bool(prerequisites_text)

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        fields = {
            "objectives": "🟢" if has_objectives and not has_placeholders else ("🟡" if has_objectives else "🔴"),
            "framework": "🟢" if has_framework and not has_placeholders else "🔴",
            "prerequisites": "🟢" if has_prerequisites else "🟡"
        }

        filled_count = sum(1 for status in fields.values() if status == "🟢")
        completeness = int((filled_count / len(fields)) * 100)

        if completeness == 100:
            status = "🟢"
        elif completeness >= 50:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_3_content",
            section_name="Content & Pedagogy",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_4(self) -> SectionStatus:
        """Analyze Section 4: Voice & Personality."""
        section_text = self._extract_section("## 4️⃣ VOZ & PERSONALIDADE")

        # Check fields
        has_greeting = bool(re.search(r'Saudação.*?\n>.*?\w', section_text, re.DOTALL))
        has_tone = bool(re.search(r'Tom:.*?\w{3,}', section_text))
        has_style = bool(re.search(r'Estilo:.*?\w{3,}', section_text))
        has_phrases = bool(re.search(r'Frases Recorrentes.*?\n.*?-.*?\w', section_text, re.DOTALL))

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        fields = {
            "greeting": "🟢" if has_greeting and not has_placeholders else "🔴",
            "tone": "🟢" if has_tone and not has_placeholders else "🔴",
            "style": "🟢" if has_style and not has_placeholders else "🔴",
            "phrases": "🟢" if has_phrases and not has_placeholders else "🔴"
        }

        filled_count = sum(1 for status in fields.values() if status == "🟢")
        completeness = int((filled_count / len(fields)) * 100)

        if completeness == 100:
            status = "🟢"
        elif completeness >= 50:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_4_voice",
            section_name="Voice & Personality",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_5(self) -> SectionStatus:
        """Analyze Section 5: Format & Delivery."""
        section_text = self._extract_section("## 5️⃣ FORMATO & ENTREGA")

        # Check fields
        has_lesson_duration = bool(re.search(r'\[x\].*?(min|minutos)', section_text, re.IGNORECASE))
        has_lesson_format = bool(re.search(r'formato.*?\[x\]', section_text, re.IGNORECASE))
        has_assessments = bool(re.search(r'avaliação.*?\[x\]', section_text, re.IGNORECASE))

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        fields = {
            "lesson_duration": "🟢" if has_lesson_duration else "🟡",
            "lesson_format": "🟢" if has_lesson_format else "🔴",
            "assessment_types": "🟢" if has_assessments else "🔴"
        }

        filled_count = sum(1 for status in fields.values() if status == "🟢")
        completeness = int((filled_count / len(fields)) * 100)

        if completeness >= 75:
            status = "🟢"
        elif completeness >= 40:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_5_format",
            section_name="Format & Delivery",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_6(self) -> SectionStatus:
        """Analyze Section 6: Commercial & Launch."""
        section_text = self._extract_section("## 6️⃣ MODELO COMERCIAL & LANÇAMENTO")

        # Check fields
        has_pricing = bool(re.search(r'preço.*?\[x\]', section_text, re.IGNORECASE))
        has_launch = bool(re.search(r'lançamento.*?\d', section_text, re.IGNORECASE))
        has_upsells = bool(re.search(r'upsell', section_text, re.IGNORECASE))

        # Check for placeholders
        has_placeholders = self._has_placeholder_text(section_text)

        # Calculate completeness
        fields = {
            "pricing": "🟢" if has_pricing and not has_placeholders else "🔴",
            "launch_date": "🟢" if has_launch else "🔴",
            "upsells": "🟢" if has_upsells else "🔴"
        }

        filled_count = sum(1 for status in fields.values() if status == "🟢")
        completeness = int((filled_count / len(fields)) * 100)

        if completeness == 100:
            status = "🟢"
        elif completeness > 0:
            status = "🟡"
        else:
            status = "🔴"

        return SectionStatus(
            section_id="section_6_commercial",
            section_name="Commercial & Launch",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_7(self) -> SectionStatus:
        """Analyze Section 7: Context & References."""
        section_text = self._extract_section("## 7️⃣ CONTEXTO ADICIONAL")

        # Check for references to source materials
        has_references = bool(re.search(r'\[.*?\]\(.*?sources.*?\)', section_text)) or \
                        bool(re.search(r'sources/', section_text))

        # Check for any meaningful context
        has_context = self._has_meaningful_content(section_text, min_words=15)

        # Calculate completeness
        fields = {
            "references": "🟢" if has_references else ("🟡" if has_context else "🔴")
        }

        completeness = 100 if has_references else (50 if has_context else 0)
        status = "🟢" if completeness == 100 else ("🟡" if completeness >= 50 else "🔴")

        return SectionStatus(
            section_id="section_7_context",
            section_name="Context & References",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_section_8(self) -> SectionStatus:
        """Analyze Section 8: Final Checklist."""
        section_text = self._extract_section("## 8️⃣ CHECKLIST FINAL")

        # Check for checked items
        checked_count = len(re.findall(r'\[x\]', section_text, re.IGNORECASE))
        total_items = len(re.findall(r'\[[ x]\]', section_text, re.IGNORECASE))

        if total_items == 0:
            completeness = 0
            status = "🔴"
        else:
            completeness = int((checked_count / total_items) * 100)
            if completeness >= 80:
                status = "🟢"
            elif completeness >= 50:
                status = "🟡"
            else:
                status = "🔴"

        fields = {
            "didatica_lendaria": "🟡"  # Auto-populated, needs confirmation
        }

        return SectionStatus(
            section_id="section_8_checklist",
            section_name="Final Checklist",
            status=status,
            completeness=completeness,
            subsections={},
            fields=fields
        )

    def analyze_completeness(self) -> CompletenessMap:
        """
        Analyze completeness of all 8 COURSE-BRIEF sections.

        Returns:
            CompletenessMap with overall score and section-level details
        """
        sections = {
            "section_1_basic_info": self.analyze_section_1(),
            "section_2_icp": self.analyze_section_2(),
            "section_3_content": self.analyze_section_3(),
            "section_4_voice": self.analyze_section_4(),
            "section_5_format": self.analyze_section_5(),
            "section_6_commercial": self.analyze_section_6(),
            "section_7_context": self.analyze_section_7(),
            "section_8_checklist": self.analyze_section_8()
        }

        # MMOS Integration: Override Section 4 (Voice) if MMOS enabled
        if self.mmos_config.get('enabled'):
            # Mark Section 4 as complete (MMOS voice loaded)
            sections["section_4_voice"].status = "🟢"
            sections["section_4_voice"].completeness = 100
            # Add note to subsections
            for subsection in sections["section_4_voice"].subsections:
                sections["section_4_voice"].subsections[subsection] = "🟢"
            for field in sections["section_4_voice"].fields:
                sections["section_4_voice"].fields[field] = "🟢"

        # Calculate overall score (weighted average)
        total_completeness = sum(s.completeness for s in sections.values())
        overall_score = int(total_completeness / len(sections))

        completeness_map = CompletenessMap(
            overall_score=overall_score,
            sections=sections,
            analyzed_at=datetime.now().isoformat(),
            brief_path=str(self.brief_path)
        )

        self.completeness_map = completeness_map
        return completeness_map

    def generate_questions(self, completeness_map: CompletenessMap) -> List[Question]:
        """
        Generate targeted questions based on completeness analysis.

        Rules:
        - 🟢 sections: Skip entirely (no questions)
        - 🟡 sections: Generate confirmation questions
        - 🔴 sections: Generate full elicitation questions

        Args:
            completeness_map: Result from analyze_completeness()

        Returns:
            List of Question objects (only for incomplete sections)
        """
        questions = []

        for section_id, section_data in completeness_map.sections.items():
            status = section_data.status

            if status == "🟢":
                # Complete: Skip
                continue

            elif status == "🟡":
                # Partial: Generate confirmation question
                question = self._generate_confirmation_question(section_id, section_data)
                if question:
                    questions.append(question)

            elif status == "🔴":
                # Missing: Generate full elicitation questions
                section_questions = self._generate_elicitation_questions(section_id, section_data)
                questions.extend(section_questions)

        return questions

    def _generate_confirmation_question(self, section_id: str, section_data: SectionStatus) -> Optional[Question]:
        """Generate confirmation question for 🟡 sections."""
        if section_id == "section_2_icp":
            # Extract current ICP data for confirmation
            section_text = self._extract_section("## 2️⃣ PÚBLICO-ALVO & ICP")

            return Question(
                question_id="confirm_icp",
                section_id=section_id,
                question_type="confirmation",
                prompt=f"""
I analyzed your existing materials and extracted ICP data.

Current data in COURSE-BRIEF.md Section 2:
{section_text[:500]}...

✓ Does this accurately represent your target audience?
                """,
                input_type="confirmation",
                options=[
                    {"value": "yes", "label": "Yes, looks good"},
                    {"value": "no", "label": "No, needs editing"},
                    {"value": "show_source", "label": "Show me the source"}
                ],
                on_yes="mark_complete",
                on_no="mark_for_manual_edit"
            )

        elif section_id == "section_3_content":
            # Confirmation for learning objectives
            objectives_text = self._extract_section("### 3.2. Objetivos de Aprendizagem")

            return Question(
                question_id="confirm_objectives",
                section_id=section_id,
                question_type="confirmation",
                prompt=f"""
I inferred learning objectives from your existing lessons:

{objectives_text[:400]}...

✓ Do these objectives accurately reflect your course goals?
                """,
                input_type="confirmation",
                options=[
                    {"value": "yes", "label": "Yes, looks good"},
                    {"value": "no", "label": "No, I'll edit them manually"},
                    {"value": "show_source", "label": "Show me the source lessons"}
                ],
                on_yes="mark_complete",
                on_no="mark_for_manual_edit"
            )

        elif section_id == "section_4_voice":
            # Confirmation for voice profile
            voice_text = self._extract_section("## 4️⃣ VOZ & PERSONALIDADE")

            return Question(
                question_id="confirm_voice",
                section_id=section_id,
                question_type="confirmation",
                prompt=f"""
I extracted voice patterns from your transcripts:

{voice_text[:400]}...

✓ Does this accurately capture your teaching voice?
                """,
                input_type="confirmation",
                options=[
                    {"value": "yes", "label": "Yes, looks good"},
                    {"value": "no", "label": "No, needs adjustment"},
                    {"value": "show_source", "label": "Show me the source transcripts"}
                ],
                on_yes="mark_complete",
                on_no="mark_for_manual_edit"
            )

        return None

    def _generate_elicitation_questions(self, section_id: str, section_data: SectionStatus) -> List[Question]:
        """Generate full elicitation questions for 🔴 sections."""
        questions = []

        if section_id == "section_1_basic_info":
            # Check which fields are missing
            if section_data.fields.get("category") == "🔴":
                questions.append(Question(
                    question_id="category",
                    section_id=section_id,
                    question_type="elicitation",
                    prompt="What category does this course belong to?",
                    input_type="multiple_choice",
                    options=[
                        {"value": "tech", "label": "Technology/Programming"},
                        {"value": "marketing", "label": "Marketing Digital"},
                        {"value": "business", "label": "Business/Entrepreneurship"},
                        {"value": "productivity", "label": "Productivity/Tools"},
                        {"value": "design", "label": "Design/Creativity"},
                        {"value": "personal", "label": "Personal Development"},
                        {"value": "other", "label": "Other"}
                    ]
                ))

        elif section_id == "section_5_format":
            # Assessment types
            if section_data.fields.get("assessment_types") == "🔴":
                questions.append(Question(
                    question_id="assessment_types",
                    section_id=section_id,
                    question_type="elicitation",
                    prompt="What types of assessments fit this course? (Select all that apply)",
                    input_type="multiple_select",
                    options=[
                        {"value": "quiz", "label": "Quiz (knowledge checks)", "description": "Multiple choice, scenario-based questions"},
                        {"value": "project", "label": "Project (hands-on deliverable)", "description": "Students build something tangible"},
                        {"value": "workshop", "label": "Workshop (guided practice)", "description": "Step-by-step exercises"},
                        {"value": "case_study", "label": "Case Study (scenario analysis)", "description": "Analyze real-world situations"},
                        {"value": "mix", "label": "Mix (combination)", "description": "Use multiple assessment types"}
                    ]
                ))

        elif section_id == "section_6_commercial":
            # Pricing model
            if section_data.fields.get("pricing") == "🔴":
                questions.append(Question(
                    question_id="pricing",
                    section_id=section_id,
                    question_type="elicitation",
                    prompt="What's the pricing model for this course?",
                    input_type="multiple_choice",
                    options=[
                        {"value": "free", "label": "Free"},
                        {"value": "paid_once", "label": "Paid (one-time)"},
                        {"value": "subscription", "label": "Subscription"},
                        {"value": "freemium", "label": "Freemium"},
                        {"value": "undecided", "label": "Not decided yet"}
                    ]
                ))

        return questions

    def calculate_expected_question_count(self, creation_mode: str) -> int:
        """
        Estimate question count based on completeness and creation mode.

        Args:
            creation_mode: "greenfield" or "brownfield"

        Returns:
            Expected number of questions (3-20)
        """
        if not self.completeness_map:
            raise ValueError("Must run analyze_completeness() first")

        overall_completeness = self.completeness_map.overall_score

        if creation_mode == "greenfield":
            # No extraction: Ask everything
            base_questions = 15
            reduction = 0
        elif creation_mode == "brownfield":
            # Extraction ran: Reduce based on completeness
            base_questions = 15
            reduction = (overall_completeness / 100) * base_questions
        else:  # hybrid, mmos, etc.
            base_questions = 12
            reduction = (overall_completeness / 100) * base_questions

        final_count = max(3, base_questions - reduction)  # Min 3 questions
        return int(final_count)

    def persist_answers(self, answers: Dict[str, Answer]) -> CompletenessMap:
        """
        Write user answers back to COURSE-BRIEF.md and update status.

        Args:
            answers: Dict of question_id → Answer objects

        Returns:
            Updated CompletenessMap after persisting answers
        """
        brief_content = self.brief_content

        for question_id, answer in answers.items():
            section_id = answer.question_id.split('_')[0]  # Extract section from question_id

            if answer.answer_type == "confirmation":
                if answer.value == "yes":
                    # Mark section as 🟢 (confirmed)
                    brief_content = self._update_section_status(
                        brief_content,
                        section_id,
                        status="🟢",
                        note="Confirmed by user"
                    )
                elif answer.value == "no":
                    # Mark section as 🟡 (manual edit required)
                    brief_content = self._update_section_status(
                        brief_content,
                        section_id,
                        status="🟡",
                        note="Review and edit manually"
                    )

            elif answer.answer_type == "elicitation":
                # Fill missing section with answer
                brief_content = self._fill_section_field(
                    brief_content,
                    question_id,
                    answer.value
                )
                # Mark as 🟢 (now complete)
                brief_content = self._update_section_status(
                    brief_content,
                    section_id,
                    status="🟢",
                    note="Filled by user"
                )

        # Write back to file
        with open(self.brief_path, 'w', encoding='utf-8') as f:
            f.write(brief_content)

        # Re-analyze completeness
        self.brief_content = brief_content
        return self.analyze_completeness()

    def _update_section_status(self, content: str, section_id: str, status: str, note: str) -> str:
        """Update status indicator in a section header."""
        # Map section_id to actual section heading
        section_headings = {
            "section_1": "## 1️⃣ INFORMAÇÕES BÁSICAS DO CURSO",
            "section_2": "## 2️⃣ PÚBLICO-ALVO & ICP",
            "section_3": "## 3️⃣ CONTEÚDO & PEDAGOGIA",
            "section_4": "## 4️⃣ VOZ & PERSONALIDADE",
            "section_5": "## 5️⃣ FORMATO & ENTREGA",
            "section_6": "## 6️⃣ MODELO COMERCIAL & LANÇAMENTO",
            "section_7": "## 7️⃣ CONTEXTO ADICIONAL",
            "section_8": "## 8️⃣ CHECKLIST FINAL"
        }

        # Find section heading
        heading = section_headings.get(section_id)
        if not heading:
            return content

        # Add status line after heading if not present
        status_line = f"\n\n{status} **Status:** {note}\n"

        # Replace or add status line
        pattern = rf'({re.escape(heading)})(.*?)(\n## |\Z)'

        def replacer(match):
            section_text = match.group(2)
            next_section = match.group(3)

            # Remove old status if present
            section_text = re.sub(r'\n\n[🟢🟡🔴] \*\*Status:\*\*.*?\n', '', section_text)

            # Add new status
            return f"{heading}{status_line}{section_text}{next_section}"

        return re.sub(pattern, replacer, content, flags=re.DOTALL)

    def _fill_section_field(self, content: str, question_id: str, value: str) -> str:
        """Fill a specific field in COURSE-BRIEF with answer value."""
        # This is a simplified implementation - in production would need more sophisticated field mapping
        # For now, just append answer to relevant section

        if question_id == "category":
            # Update category checkbox
            content = re.sub(
                r'\[ \] (Tecnologia|Marketing|Business|Produtividade|Design|Desenvolvimento|Outro)',
                lambda m: f'[x] {m.group(1)}' if value in m.group(1).lower() else m.group(0),
                content,
                count=1
            )

        elif question_id == "assessment_types":
            # Mark selected assessment types
            for assessment_type in value.split(','):
                content = re.sub(
                    rf'\[ \] ({assessment_type.strip()})',
                    rf'[x] \1',
                    content,
                    flags=re.IGNORECASE
                )

        elif question_id == "pricing":
            # Mark pricing model
            content = re.sub(
                r'\[ \] (Free|Paid|Subscription|Freemium)',
                lambda m: f'[x] {m.group(1)}' if value in m.group(1).lower() else m.group(0),
                content,
                count=1
            )

        return content

    def validate_brief_complete(self) -> bool:
        """
        Final validation gate: All sections must be 🟢 before proceeding.

        Returns:
            True if all sections complete, raises exception otherwise
        """
        if not self.completeness_map:
            self.analyze_completeness()

        incomplete_sections = []
        for section_id, section_data in self.completeness_map.sections.items():
            if section_data.status != "🟢":
                incomplete_sections.append(section_data.section_name)

        if incomplete_sections:
            error_message = f"""
❌ BRIEF INCOMPLETE

The following sections are not complete:
{chr(10).join(f'  - {name}' for name in incomplete_sections)}

Please review COURSE-BRIEF.md and fill these sections manually.

When done, run: *continue-course {self.course_slug} --validate-brief

Or to edit interactively: *edit-brief {self.course_slug}
            """
            raise ValueError(error_message.strip())

        # All 🟢: Ready to proceed
        print(f"✅ COURSE-BRIEF validation passed (all sections complete)")
        return True


class BriefIncompleteError(Exception):
    """Raised when COURSE-BRIEF validation fails."""
    pass
