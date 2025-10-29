#!/usr/bin/env python3
"""
Lesson Generator for CreatorOS - GPS Framework + Didática Lendária

This module implements the core lesson generation engine that combines:
- GPS Framework (Goal → Position → Steps)
- Didática Lendária 7 Elements (pedagogical depth)
- Voice Profile Injection (MMOS > Transcripts > Manual priority)
- Real-time progress tracking
- Error handling with retry logic
- Validation and scoring

Story: STORY-3.9 - Lesson Generation with GPS + Didática Lendária
Epic: EPIC-3 - Intelligent Workflow System

Key Features:
- Template-based generation with GPS + 7 Elements structure
- Voice injection priority: MMOS → Transcripts → Manual
- Real-time progress display with time/cost estimates
- Batch generation with retry logic (up to 2 retries)
- GPS validation and DL scoring for quality assurance
- File naming convention: M.L-slug.md (e.g., 1.1-intro.md)
- Comprehensive error handling and partial save recovery

Usage:
    from lib.lesson_generator import LessonGenerator

    generator = LessonGenerator(
        course_slug="dominando-obsidian",
        curriculum=curriculum_data,
        course_brief=course_brief_data
    )

    result = generator.generate_all_lessons()
    print(f"Generated: {len(result['completed'])}/{result['total']} lessons")
"""

import os
import re
import time
import yaml
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass, field
import logging

# Database persistence integration
from lib.db_persister import CoursePersister

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class LessonSpec:
    """Specification for a single lesson."""
    lesson_id: str  # e.g., "1.1"
    lesson_title: str
    module_id: int
    module_title: str
    module_number: int
    lesson_number: int
    slug: str  # kebab-case for filename
    duration_minutes: int
    learning_objectives: List[str]
    key_concepts: List[str] = field(default_factory=list)
    prerequisites: List[str] = field(default_factory=list)
    bloom_level: Optional[str] = None


@dataclass
class VoiceProfile:
    """Voice profile for lesson generation."""
    source: str  # "mmos", "transcripts", "manual"
    prompt_injection: str  # Full prompt text for AI
    voice_data: Dict  # Raw voice data
    fidelity_target: float  # 0.85-0.95


@dataclass
class GeneratedLesson:
    """Result of lesson generation."""
    lesson_id: str
    lesson_title: str
    file_path: str
    duration_seconds: float
    word_count: int
    gps_valid: bool
    dl_score: Optional[int] = None
    voice_fidelity: Optional[float] = None
    retry_count: int = 0


@dataclass
class GenerationResult:
    """Complete result of batch lesson generation."""
    completed: List[GeneratedLesson]
    failed: List[Dict]  # lesson_id → error info
    total_lessons: int
    total_time_seconds: float
    total_cost_usd: float
    avg_time_per_lesson: float
    avg_cost_per_lesson: float


class LessonGenerationError(Exception):
    """Raised when lesson generation fails."""
    pass


class LessonGenerator:
    """
    Core lesson generation engine with GPS + Didática Lendária.

    Generates transformational lessons using:
    1. GPS Framework template (Goal → Position → Steps)
    2. Didática Lendária 7 Elements
    3. Voice profile injection (MMOS priority)
    4. Real-time progress tracking
    5. Retry logic and error recovery
    """

    def __init__(
        self,
        course_slug: str,
        curriculum: Dict,
        course_brief: Dict,
        template_path: Optional[str] = None,
        project_id: Optional[str] = None
    ):
        """
        Initialize lesson generator.

        Args:
            course_slug: Course identifier
            curriculum: Curriculum data (from curriculum.yaml)
            course_brief: Course brief data (from COURSE-BRIEF.md)
            template_path: Optional custom template path
            project_id: Optional project ID from database (for persistence)
        """
        self.course_slug = course_slug
        self.curriculum = curriculum
        self.course_brief = course_brief
        self.project_id = project_id  # For database persistence

        # Paths
        self.base_path = Path("outputs/courses") / course_slug
        self.lessons_path = self.base_path / "lessons"
        self.lessons_path.mkdir(parents=True, exist_ok=True)

        # Database persister
        self.persister = CoursePersister()

        # Load GPS framework template
        if template_path:
            self.template_path = Path(template_path)
        else:
            self.template_path = Path("expansion-packs/creator-os/templates/lesson-gps-framework.md")

        self.template = self._load_template()

        # Load voice profile
        self.voice_profile = self._load_voice_profile()

        # Generation settings
        self.max_retries = 2
        self.model = "gpt-4"  # or "gpt-4-turbo" for speed
        self.temperature = 0.7
        self.max_tokens = 4000

        # Cost estimates (GPT-4 pricing)
        self.cost_per_1k_input = 0.03  # $0.03 per 1K input tokens
        self.cost_per_1k_output = 0.06  # $0.06 per 1K output tokens

        # Progress tracking
        self.start_time: Optional[float] = None
        self.completed_lessons: List[GeneratedLesson] = []
        self.failed_lessons: List[Dict] = []

    def _load_template(self) -> str:
        """Load GPS framework template."""
        if not self.template_path.exists():
            raise FileNotFoundError(
                f"GPS template not found: {self.template_path}\n"
                f"Create template at: expansion-packs/creator-os/templates/lesson-gps-framework.md"
            )

        with open(self.template_path, 'r', encoding='utf-8') as f:
            return f.read()

    def _load_voice_profile(self) -> VoiceProfile:
        """
        Load voice profile with priority: MMOS > Transcripts > Manual.

        AC 2: Voice Profile Injection

        Returns:
            VoiceProfile with prompt injection text
        """
        mmos_config = self.course_brief.get("mmos_persona", {})

        # Priority 1: MMOS persona
        if mmos_config.get("enabled"):
            return self._load_mmos_voice(mmos_config)

        # Priority 2: Transcript extraction
        voice_data = self.course_brief.get("voice_profile", {})
        if voice_data.get("source") == "transcripts":
            return self._load_transcript_voice(voice_data)

        # Priority 3: Manual definition
        return self._load_manual_voice(voice_data)

    def _load_mmos_voice(self, mmos_config: Dict) -> VoiceProfile:
        """Load MMOS persona voice (Priority 1)."""
        system_prompt_path = mmos_config.get("system_prompt_path")

        if not system_prompt_path or not Path(system_prompt_path).exists():
            logger.warning(f"MMOS system prompt not found: {system_prompt_path}")
            logger.warning("Falling back to manual voice profile")
            return self._load_manual_voice(self.course_brief.get("voice_profile", {}))

        # Load full MMOS system prompt
        with open(system_prompt_path, 'r', encoding='utf-8') as f:
            mmos_prompt = f.read()

        prompt_injection = f"""
INSTRUCTOR VOICE PROFILE (MMOS Cognitive Clone):

{mmos_prompt}

CRITICAL: You are generating a lesson AS THIS INSTRUCTOR. Maintain:
- Their exact tone, style, and teaching approach
- Their signature phrases and recurring patterns
- Their personality and intellectual depth
- Their way of explaining concepts (analogies, examples, stories)

Fidelity target: 90%+ (this is a cognitive clone, not generic content)
        """.strip()

        logger.info(f"✅ Loaded MMOS voice from: {system_prompt_path}")

        return VoiceProfile(
            source="mmos",
            prompt_injection=prompt_injection,
            voice_data=mmos_config,
            fidelity_target=0.90
        )

    def _load_transcript_voice(self, voice_data: Dict) -> VoiceProfile:
        """Load voice from transcript extraction (Priority 2)."""
        instructor_name = voice_data.get("instructor_name", "Unknown")
        signature_greeting = voice_data.get("signature_greeting", "")
        tone = voice_data.get("tone", "Professional")
        style = voice_data.get("style", "Clear, structured")
        recurring_phrases = voice_data.get("recurring_phrases", [])
        teaching_approach = voice_data.get("teaching_approach", {})

        # Format recurring phrases
        phrases_text = "\n".join(f'  - "{phrase}"' for phrase in recurring_phrases[:5])

        # Format teaching approach
        approach_items = []
        for key, value in teaching_approach.items():
            approach_items.append(f"  - {key}: {value}")
        approach_text = "\n".join(approach_items)

        prompt_injection = f"""
INSTRUCTOR VOICE PROFILE (from transcript analysis):

Instructor: {instructor_name}
Signature Greeting: "{signature_greeting}"

Tone: {tone}
Style: {style}

Recurring Phrases (use naturally in lessons):
{phrases_text}

Teaching Approach:
{approach_text}

CRITICAL: Write lessons in THIS instructor's voice. Students should "hear" their voice when reading.

Fidelity target: 85%+
        """.strip()

        logger.info(f"✅ Loaded transcript voice for: {instructor_name}")

        return VoiceProfile(
            source="transcripts",
            prompt_injection=prompt_injection,
            voice_data=voice_data,
            fidelity_target=0.85
        )

    def _load_manual_voice(self, voice_data: Dict) -> VoiceProfile:
        """Load manual voice definition (Priority 3 - fallback)."""
        tone = voice_data.get("tone", "Professional, clear, engaging")
        style = voice_data.get("style", "Structured, practical, example-driven")

        prompt_injection = f"""
INSTRUCTOR VOICE PROFILE (manually defined):

Tone: {tone}
Style: {style}

Use a {tone.lower()} tone and {style.lower()} approach.

Fidelity target: 85%
        """.strip()

        logger.info("✅ Loaded manual voice profile (generic)")

        return VoiceProfile(
            source="manual",
            prompt_injection=prompt_injection,
            voice_data=voice_data,
            fidelity_target=0.85
        )

    def generate_all_lessons(self) -> GenerationResult:
        """
        Generate all lessons sequentially with progress tracking.

        AC 7: Batch Generation
        AC 3: Progress Tracking
        AC 8: Error Handling

        Returns:
            GenerationResult with completed/failed lessons
        """
        self.start_time = time.time()

        # Extract all lessons from curriculum
        all_lessons = self._flatten_curriculum_to_lessons()
        total_count = len(all_lessons)

        logger.info(f"\n{'='*64}")
        logger.info(f"🎬 GENERATING COURSE: {self.course_brief.get('title', self.course_slug)}")
        logger.info(f"{'='*64}\n")

        # Generate each lesson
        for i, lesson_spec in enumerate(all_lessons, start=1):
            # Display progress
            self._display_progress(
                current=i,
                total=total_count,
                current_lesson=lesson_spec
            )

            # Generate lesson with retry logic
            try:
                generated_lesson = self._generate_single_lesson_with_retry(lesson_spec)
                self.completed_lessons.append(generated_lesson)

                logger.info(
                    f"✅ {lesson_spec.lesson_id} - {lesson_spec.lesson_title} "
                    f"(completed in {generated_lesson.duration_seconds:.1f}s)"
                )

            except Exception as e:
                logger.error(
                    f"❌ {lesson_spec.lesson_id} - {lesson_spec.lesson_title} "
                    f"(failed: {e})"
                )

                self.failed_lessons.append({
                    "lesson_id": lesson_spec.lesson_id,
                    "lesson_title": lesson_spec.lesson_title,
                    "error": str(e),
                    "timestamp": datetime.now().isoformat()
                })

                # Continue to next lesson (don't abort)
                continue

        # Calculate final statistics
        total_time = time.time() - self.start_time
        total_cost = sum(
            self._estimate_lesson_cost(lesson.word_count)
            for lesson in self.completed_lessons
        )

        avg_time = total_time / len(self.completed_lessons) if self.completed_lessons else 0
        avg_cost = total_cost / len(self.completed_lessons) if self.completed_lessons else 0

        result = GenerationResult(
            completed=self.completed_lessons,
            failed=self.failed_lessons,
            total_lessons=total_count,
            total_time_seconds=total_time,
            total_cost_usd=total_cost,
            avg_time_per_lesson=avg_time,
            avg_cost_per_lesson=avg_cost
        )

        # Display completion summary
        self._display_completion_summary(result)

        return result

    def _flatten_curriculum_to_lessons(self) -> List[LessonSpec]:
        """Extract all lessons from curriculum as flat list."""
        lessons = []

        modules = self.curriculum.get("modules", [])

        for module in modules:
            module_id = module.get("module_id")
            module_title = module.get("module_title", f"Module {module_id}")

            for lesson in module.get("lessons", []):
                lesson_id = lesson.get("lesson_id")
                lesson_title = lesson.get("lesson_title")

                # Parse lesson numbering
                match = re.match(r'(\d+)\.(\d+)', lesson_id)
                if match:
                    module_num = int(match.group(1))
                    lesson_num = int(match.group(2))
                else:
                    logger.warning(f"Invalid lesson_id format: {lesson_id}")
                    module_num = module_id
                    lesson_num = len(lessons) + 1

                # Generate slug from title
                slug = self._generate_slug(lesson_title)

                lesson_spec = LessonSpec(
                    lesson_id=lesson_id,
                    lesson_title=lesson_title,
                    module_id=module_id,
                    module_title=module_title,
                    module_number=module_num,
                    lesson_number=lesson_num,
                    slug=slug,
                    duration_minutes=lesson.get("duration_minutes", 20),
                    learning_objectives=lesson.get("learning_objectives", []),
                    key_concepts=lesson.get("key_concepts", []),
                    prerequisites=lesson.get("prerequisites", []),
                    bloom_level=lesson.get("bloom_level")
                )

                lessons.append(lesson_spec)

        return lessons

    def _generate_slug(self, title: str) -> str:
        """Generate kebab-case slug from lesson title."""
        # Remove special characters
        slug = re.sub(r'[^\w\s-]', '', title.lower())
        # Replace spaces with hyphens
        slug = re.sub(r'[\s_]+', '-', slug)
        # Remove leading/trailing hyphens
        slug = slug.strip('-')
        return slug

    def _generate_single_lesson_with_retry(
        self,
        lesson_spec: LessonSpec,
        max_retries: Optional[int] = None
    ) -> GeneratedLesson:
        """
        Generate a single lesson with retry logic and quality validation.

        AC 5: Error Handling & Retry Logic
        QA Fix: Add validation-driven retry loop (GPS + DL scoring)

        Args:
            lesson_spec: Lesson specification
            max_retries: Optional override for max retries

        Returns:
            GeneratedLesson object

        Raises:
            LessonGenerationError: If all retries fail
        """
        max_retries = max_retries or self.max_retries

        # Import validators
        from lib.gps_validator import GPSValidator
        from lib.didatica_scorer import DidaticaScorer

        gps_validator = GPSValidator()
        dl_scorer = DidaticaScorer()

        last_error = None
        feedback_for_retry = ""

        for attempt in range(max_retries + 1):
            try:
                logger.debug(
                    f"Generating {lesson_spec.lesson_id} "
                    f"(attempt {attempt + 1}/{max_retries + 1})"
                )

                lesson_start = time.time()

                # Build generation prompt (with feedback from previous attempt if retry)
                generation_prompt = self._build_generation_prompt(
                    lesson_spec,
                    retry_feedback=feedback_for_retry if attempt > 0 else None
                )

                # Generate with AI (mock for now - would use OpenAI API)
                lesson_content = self._generate_with_ai(
                    prompt=generation_prompt,
                    temperature=self.temperature,
                    max_tokens=self.max_tokens
                )

                # Basic validation
                if not self._validate_lesson_content(lesson_content):
                    raise LessonGenerationError("Generated content is incomplete or invalid")

                # GPS validation (CRITICAL - must pass)
                gps_result = gps_validator.validate_lesson(lesson_content)
                if not gps_result.valid:
                    # Build specific feedback for retry
                    missing_sections = []
                    if not gps_result.has_goal:
                        missing_sections.append("G (GOAL) section")
                    if not gps_result.has_position:
                        missing_sections.append("P (POSITION) section")
                    if not gps_result.has_steps:
                        missing_sections.append("S (STEPS) section")

                    feedback_for_retry = (
                        f"GPS VALIDATION FAILED - Missing: {', '.join(missing_sections)}. "
                        f"You MUST include ALL THREE GPS sections with proper headings: "
                        f"## G - GOAL, ## P - POSITION, ## S - STEPS"
                    )

                    raise LessonGenerationError(
                        f"GPS validation failed (score: {gps_result.score}/30) - {feedback_for_retry}"
                    )

                # DL scoring (CRITICAL - must score 70+)
                dl_result = dl_scorer.score_lesson(lesson_content)
                if not dl_result.passed:
                    # Build specific feedback for retry
                    weak_elements = [
                        name for name, score in dl_result.element_scores.items()
                        if score < (dl_result.max_score_per_element * 0.7)
                    ]

                    feedback_for_retry = (
                        f"DIDÁTICA LENDÁRIA SCORING FAILED (score: {dl_result.score}/100, threshold: 70). "
                        f"Weak elements: {', '.join(weak_elements)}. "
                        f"You MUST strengthen these pedagogical elements: "
                        f"add more analogies, deeper reflective questions, clearer transitions, "
                        f"stronger emotional hook, and structured review section."
                    )

                    raise LessonGenerationError(
                        f"DL scoring failed ({dl_result.score}/100 < 70) - {feedback_for_retry}"
                    )

                # BOTH validations passed - save and return
                file_path = self._save_lesson(lesson_spec, lesson_content)

                # Calculate metrics
                duration = time.time() - lesson_start
                word_count = len(lesson_content.split())

                logger.info(
                    f"✅ Quality validated: GPS={gps_result.score}/30, DL={dl_result.score}/100"
                )

                return GeneratedLesson(
                    lesson_id=lesson_spec.lesson_id,
                    lesson_title=lesson_spec.lesson_title,
                    file_path=str(file_path),
                    duration_seconds=duration,
                    word_count=word_count,
                    gps_valid=True,
                    dl_score=dl_result.score,
                    retry_count=attempt
                )

            except Exception as e:
                last_error = e

                if attempt < max_retries:
                    # Log retry reason
                    logger.warning(
                        f"⚠️  Attempt {attempt + 1}/{max_retries + 1} failed for {lesson_spec.lesson_id}: {e}"
                    )
                    logger.warning(f"Retrying with adjusted prompt...")

                    # Small delay before retry (not exponential - we want fast retries for quality issues)
                    time.sleep(1)
                    continue
                else:
                    # All retries exhausted
                    logger.error(
                        f"❌ Failed to generate {lesson_spec.lesson_id} after "
                        f"{max_retries + 1} attempts"
                    )
                    logger.error(f"Final error: {e}")
                    raise LessonGenerationError(
                        f"Failed after {max_retries + 1} attempts: {last_error}"
                    )

    def _build_generation_prompt(
        self,
        lesson_spec: LessonSpec,
        retry_feedback: Optional[str] = None
    ) -> str:
        """
        Build complete AI generation prompt with all context.

        AC 1: Template-Based Generation
        QA Fix: Added retry_feedback parameter for validation-driven retries

        Args:
            lesson_spec: Lesson specification
            retry_feedback: Optional feedback from failed validation (for retries)

        Returns:
            Complete prompt for AI generation
        """
        course_title = self.course_brief.get("title", "Untitled Course")
        icp = self.course_brief.get("icp", {})
        learning_objectives = self.course_brief.get("learning_objectives", [])

        # Format ICP
        icp_text = self._format_icp(icp)

        # Format learning objectives
        objectives_text = "\n".join(f"- {obj}" for obj in lesson_spec.learning_objectives)

        # Format key concepts
        concepts_text = "\n".join(f"- {concept}" for concept in lesson_spec.key_concepts)

        # Add retry feedback section if this is a retry
        retry_section = ""
        if retry_feedback:
            retry_section = f"""

⚠️ **CRITICAL VALIDATION FEEDBACK FROM PREVIOUS ATTEMPT:**

{retry_feedback}

YOU MUST FIX THESE ISSUES IN THIS GENERATION. Do not repeat the same mistakes.
"""

        # Build prompt
        prompt = f"""
You are generating a lesson for the course "{course_title}".

**TARGET AUDIENCE (ICP):**
{icp_text}

**VOICE & STYLE:**
{self.voice_profile.prompt_injection}

**LESSON SPECIFICATION:**
- ID: {lesson_spec.lesson_id}
- Title: {lesson_spec.lesson_title}
- Module: {lesson_spec.module_title}
- Duration: {lesson_spec.duration_minutes} minutes
- Bloom's Level: {lesson_spec.bloom_level or 'Apply/Analyze'}

**LEARNING OBJECTIVES:**
{objectives_text}

**KEY CONCEPTS:**
{concepts_text}

**PEDAGOGICAL FRAMEWORK - GPS + DIDÁTICA LENDÁRIA:**

{self.template}
{retry_section}

**CRITICAL REQUIREMENTS:**

1. **Follow GPS Structure Exactly:**
   - G (GOAL): Clear promise - what they'll achieve (30-60 seconds)
   - P (POSITION): Empathy - meet them where they are (60-90 seconds)
   - S (STEPS): Technical content with pedagogical elements

2. **Include ALL 7 Elements (Didática Lendária):**
   - Hook Emocional (in Goal section)
   - Conceitos Primordiais (core concepts explained clearly)
   - Link de Transição (between major concepts)
   - Pergunta Reflexiva (2-3 reflective questions)
   - Analogias/Diagramas (1+ analogy, 1+ diagram description)
   - Revisão Estruturada (Before → After transformation)
   - Ação Rápida (2-minute immediate action)

3. **Use Voice Profile Naturally:**
   - Maintain instructor's tone and style throughout
   - Incorporate signature phrases where appropriate
   - Match their teaching approach (not generic AI voice)

4. **Minimum Semiotic Elements:**
   - 1 analogy (familiar concept comparison)
   - 1 diagram (describe or suggest visual)
   - 2 reflective questions (make students pause and think)

5. **Word Count Target:** {lesson_spec.duration_minutes * 150} words (based on {lesson_spec.duration_minutes} min × 150 words/min reading speed)

6. **Make It TRANSFORMATIONAL, Not Informational:**
   - Students should FEEL the learning, not just read it
   - Focus on WHY before WHAT
   - Create "aha moments" through analogies and questions
   - End with immediate, achievable action (2 min)

Generate the complete lesson content in Markdown format, following the GPS template structure exactly.
        """.strip()

        return prompt

    def _format_icp(self, icp: Dict) -> str:
        """Format ICP data for prompt."""
        demographics = icp.get("demographics", "Not specified")
        psychographics = icp.get("psychographics", "Not specified")
        pain_points = icp.get("pain_points", [])
        goals = icp.get("goals", [])

        pain_text = "\n".join(f"  - {pain}" for pain in pain_points[:3])
        goals_text = "\n".join(f"  - {goal}" for goal in goals[:3])

        return f"""
Demographics: {demographics}
Psychographics: {psychographics}

Main Pain Points:
{pain_text}

Desired Outcomes:
{goals_text}
        """.strip()

    def _generate_with_ai(
        self,
        prompt: str,
        temperature: float,
        max_tokens: int
    ) -> str:
        """
        Generate lesson content with AI model.

        NOTE: This is a mock implementation for testing.
        In production, this would call OpenAI API (GPT-4 or GPT-4-Turbo).

        Args:
            prompt: Complete generation prompt
            temperature: Creativity parameter (0.0-1.0)
            max_tokens: Maximum tokens to generate

        Returns:
            Generated lesson content in Markdown
        """
        # MOCK IMPLEMENTATION - Replace with actual OpenAI API call
        # Example:
        # import openai
        # response = openai.ChatCompletion.create(
        #     model=self.model,
        #     messages=[
        #         {"role": "system", "content": "You are an expert course creator..."},
        #         {"role": "user", "content": prompt}
        #     ],
        #     temperature=temperature,
        #     max_tokens=max_tokens
        # )
        # return response.choices[0].message.content

        logger.warning("⚠️  Using MOCK AI generation (replace with OpenAI API in production)")

        # Return mock lesson content with GPS structure
        return f"""# Mock Lesson: GPS Framework Example

## 🎯 G - GOAL (Destino)

Ao final desta aula, você vai conseguir:
✅ Entender o conceito principal desta lição
✅ Aplicar a técnica no seu contexto real
✅ Ter um resultado tangível para mostrar

**Por que isso importa:** Esta habilidade vai economizar horas de trabalho e melhorar significativamente seus resultados.

## 🗺️ P - POSITION (Origem)

Eu sei que você pode estar pensando: "Mais uma ferramenta/técnica para aprender?"

Se você já tentou abordagens similares antes e não funcionou, eu entendo perfeitamente. A diferença aqui é que vamos focar no que REALMENTE funciona, sem fluff.

Se você nunca fez isso antes, tudo bem - vou mostrar desde o zero, passo a passo.

## 🛤️ S - STEPS (Rota)

### Por Que Isso Funciona (Antes do Como)

Imagine que [conceito] é como [analogia familiar]. Assim como [comparação], aqui também funciona da mesma forma.

### Passo 1: Conceito Principal

Aqui está o que você precisa saber...

[Conteúdo técnico com explicação clara]

🤔 **Pause aqui:** Onde no seu trabalho/vida você poderia aplicar isso?

### Passo 2: Aplicação Prática

Agora vamos colocar em prática...

[Exercício hands-on]

## 💡 REVISÃO ESTRUTURADA

**Você entrou achando que:** [Crença antiga]

**Agora você sabe que:** [Nova compreensão] - e isso muda tudo.

## ⚡ AÇÃO RÁPIDA (2 minutos)

Não feche esta aula sem fazer isto:

1. [Ação específica 1]
2. [Ação específica 2]
3. [Ação específica 3]

✓ Funcionou se você viu [resultado esperado]

---

**Próxima aula:** [Título da próxima lição]
"""

    def _validate_lesson_content(self, content: str) -> bool:
        """
        Quick validation: Ensure generated content is not empty or malformed.

        AC 5: Error Handling & Retry Logic

        Args:
            content: Generated lesson content

        Returns:
            True if content passes basic validation
        """
        if not content or len(content) < 500:
            return False  # Too short

        # Check for minimum GPS sections
        has_goal = bool(re.search(r'##\s*(G|GOAL|🎯)', content, re.IGNORECASE))
        has_position = bool(re.search(r'##\s*(P|POSITION|🗺️)', content, re.IGNORECASE))
        has_steps = bool(re.search(r'##\s*(S|STEPS|🛤️)', content, re.IGNORECASE))

        # At least one section must be present
        return has_goal or has_position or has_steps

    def _quick_gps_check(self, content: str) -> bool:
        """Quick check for GPS structure compliance."""
        has_goal = bool(re.search(r'##\s*(G|GOAL|🎯)', content, re.IGNORECASE))
        has_position = bool(re.search(r'##\s*(P|POSITION|🗺️)', content, re.IGNORECASE))
        has_steps = bool(re.search(r'##\s*(S|STEPS|🛤️)', content, re.IGNORECASE))

        return has_goal and has_position and has_steps

    def _save_lesson(self, lesson_spec: LessonSpec, content: str) -> Path:
        """
        Save lesson to file with canonical naming convention.

        AC 4: File Naming Convention

        Args:
            lesson_spec: Lesson specification
            content: Generated lesson content

        Returns:
            Path to saved lesson file
        """
        # Canonical filename: M.L-slug.md (e.g., 1.1-intro.md)
        filename = f"{lesson_spec.module_number}.{lesson_spec.lesson_number}-{lesson_spec.slug}.md"
        file_path = self.lessons_path / filename

        # Save to filesystem (PRIMARY - source of truth)
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)

        logger.debug(f"Saved lesson to: {file_path}")

        # Persist to database (SECONDARY - optional)
        if self.project_id:
            self._persist_lesson_to_database(lesson_spec, content)

        return file_path

    def _persist_lesson_to_database(self, lesson_spec: LessonSpec, content: str) -> None:
        """
        Persist lesson to database after filesystem write succeeds.

        Args:
            lesson_spec: Lesson specification
            content: Generated lesson content
        """
        # Extract fidelity score if available (from GeneratedLesson)
        fidelity_score = None
        for completed in self.completed_lessons:
            if completed.lesson_id == lesson_spec.lesson_id:
                fidelity_score = completed.fidelity_score
                break

        # Prepare metadata
        metadata = {
            'lesson_id': lesson_spec.lesson_id,
            'module_id': lesson_spec.module_id,
            'module_title': lesson_spec.module_title,
            'duration_minutes': lesson_spec.duration_minutes,
            'learning_objectives': lesson_spec.learning_objectives,
            'key_concepts': lesson_spec.key_concepts,
            'prerequisites': lesson_spec.prerequisites,
            'bloom_level': lesson_spec.bloom_level
        }

        # Persist to contents table
        # Note: parent_content_id should be the module's content_id
        # For now, we'll set it to None and can be updated later with a batch update
        content_id = self.persister.persist_content(
            project_id=self.project_id,
            slug=f"{lesson_spec.module_number}.{lesson_spec.lesson_number}-{lesson_spec.slug}",
            title=lesson_spec.lesson_title,
            content_type='course_lesson',
            content=content,
            parent_content_id=None,  # TODO: Link to module content_id
            sequence_order=lesson_spec.lesson_number,
            metadata=metadata,
            fidelity_score=fidelity_score
        )

        if content_id:
            logger.debug(f"✓ Lesson persisted to database: {content_id}")

    def _estimate_lesson_cost(self, word_count: int) -> float:
        """
        Estimate cost for a generated lesson.

        Args:
            word_count: Number of words in lesson

        Returns:
            Estimated cost in USD
        """
        # Rough token estimate: 1 word ≈ 1.3 tokens
        estimated_tokens = int(word_count * 1.3)

        # Assume 50% input (prompt), 50% output (lesson)
        input_tokens = estimated_tokens // 2
        output_tokens = estimated_tokens // 2

        input_cost = (input_tokens / 1000) * self.cost_per_1k_input
        output_cost = (output_tokens / 1000) * self.cost_per_1k_output

        return input_cost + output_cost

    def _display_progress(
        self,
        current: int,
        total: int,
        current_lesson: LessonSpec
    ) -> None:
        """
        Display real-time progress with ASCII progress bar.

        AC 3: Progress Tracking

        Args:
            current: Current lesson number
            total: Total lesson count
            current_lesson: Currently generating lesson
        """
        # Progress bar
        progress = int((current / total) * 20)
        bar = "█" * progress + "░" * (20 - progress)
        percentage = int((current / total) * 100)

        print(f"\nProgress: {bar} {current}/{total} lessons ({percentage}%)")
        print()
        print("=" * 64)
        print()

        # Show completed lessons (last 5)
        for lesson in self.completed_lessons[-5:]:
            print(
                f"✅ {lesson.lesson_id} - {lesson.lesson_title[:40]} "
                f"(completed in {lesson.duration_seconds:.0f}s)"
            )

        # Show current lesson
        print(f"🔄 {current_lesson.lesson_id} - {current_lesson.lesson_title[:40]} (generating...)")

        # Show queued lessons (next 3)
        all_lessons = self._flatten_curriculum_to_lessons()
        for lesson in all_lessons[current:current + 3]:
            print(f"⏳ {lesson.lesson_id} - {lesson.lesson_title[:40]} (queued)")

        print()
        print("=" * 64)
        print()

        # Statistics
        if self.completed_lessons:
            elapsed = time.time() - self.start_time
            avg_time = elapsed / len(self.completed_lessons)
            remaining_lessons = total - current
            estimated_time = avg_time * remaining_lessons

            print("📊 STATISTICS:")
            print(f"   Avg time per lesson: {avg_time:.0f}s")
            print(f"   Estimated completion: {estimated_time / 60:.0f} minutes")

            # Estimate cost
            total_words = sum(lesson.word_count for lesson in self.completed_lessons)
            avg_words = total_words / len(self.completed_lessons)
            estimated_total_cost = self._estimate_lesson_cost(avg_words) * total
            print(f"   Estimated total cost: ${estimated_total_cost:.2f}")
            print()
            print("=" * 64)
            print()

    def _display_completion_summary(self, result: GenerationResult) -> None:
        """
        Display final completion summary.

        AC 6: Completion Summary
        AC 7: Partial Completion Handling

        Args:
            result: Generation result
        """
        print("\n")
        print("=" * 64)

        if len(result.failed) == 0:
            print("✅ COURSE GENERATION COMPLETE!")
        else:
            print("⚠️  COURSE GENERATION PARTIALLY COMPLETE")

        print("=" * 64)
        print()
        print(f"Course: {self.course_brief.get('title', self.course_slug)}")
        print(
            f"Generated: {len(result.completed)}/{result.total_lessons} lessons "
            f"({int(len(result.completed) / result.total_lessons * 100)}%)"
        )
        print(f"Total time: {result.total_time_seconds / 60:.1f} minutes")
        print(f"Total cost: ${result.total_cost_usd:.2f}")
        print()
        print("=" * 64)
        print()

        if result.failed:
            print("❌ FAILED LESSONS:")
            print()
            for i, failure in enumerate(result.failed, start=1):
                print(f"{i}. {failure['lesson_id']} - {failure['lesson_title']}")
                print(f"   Error: {failure['error']}")
                print(f"   Action: Retry with: *generate-lesson {self.course_slug} {failure['lesson_id']}")
                print()
            print("=" * 64)
            print()
            print("→ To retry failed lessons:")
            print(f"  *retry-failed-lessons {self.course_slug}")
            print()
            print("=" * 64)
            print()

        print("📂 OUTPUT FILES:")
        print()
        print(f"Lessons ({len(result.completed)} files):")
        print(f"  {self.lessons_path}/")
        for lesson in result.completed[:5]:  # Show first 5
            filename = Path(lesson.file_path).name
            print(f"  ├── {filename}")
        if len(result.completed) > 5:
            print(f"  └── ... and {len(result.completed) - 5} more")
        print()
        print("=" * 64)
        print()

        if len(result.completed) > 0:
            print("📊 QUALITY METRICS:")
            print()
            gps_compliant = sum(1 for l in result.completed if l.gps_valid)
            gps_percentage = int((gps_compliant / len(result.completed)) * 100)
            print(f"GPS Compliance: {gps_percentage}% ({gps_compliant}/{len(result.completed)} lessons)")
            print(f"Avg Lesson Length: {sum(l.word_count for l in result.completed) // len(result.completed)} words")
            print()
            print("=" * 64)
            print()

        print("🎯 NEXT STEPS:")
        print()
        print("1. Review generated lessons:")
        print(f"   → Open: {self.lessons_path}/")
        print()
        print("2. Run validation checks:")
        print(f"   → *validate-course {self.course_slug}")
        print()
        print("3. Generate assessments (quizzes + projects):")
        print(f"   → *generate-assessments {self.course_slug}")
        print()
        print("=" * 64)
        print()


# Utility functions

def generate_lesson_filename(lesson_spec: LessonSpec) -> str:
    """
    Generate canonical filename: {module}.{lesson}-{slug}.md

    AC 4: File Naming Convention

    Args:
        lesson_spec: Lesson specification

    Returns:
        Filename string (e.g., "1.1-intro.md")
    """
    return f"{lesson_spec.module_number}.{lesson_spec.lesson_number}-{lesson_spec.slug}.md"


def validate_filename_format(filename: str) -> bool:
    """
    Validate filename follows canonical format.

    Args:
        filename: Filename to validate

    Returns:
        True if valid format
    """
    # Pattern: M.L-slug.md (e.g., 1.1-intro.md, 2.3-advanced-topic.md)
    pattern = r'^\d+\.\d+-[a-z0-9-]+\.md$'
    return bool(re.match(pattern, filename))


# Example usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python lesson_generator.py <course_slug>")
        sys.exit(1)

    course_slug = sys.argv[1]

    # Load curriculum and course brief
    base_path = Path("outputs/courses") / course_slug
    curriculum_path = base_path / "curriculum.yaml"
    brief_path = base_path / "COURSE-BRIEF.md"

    if not curriculum_path.exists():
        print(f"❌ Curriculum not found: {curriculum_path}")
        sys.exit(1)

    # Load curriculum
    with open(curriculum_path, 'r', encoding='utf-8') as f:
        curriculum = yaml.safe_load(f)

    # Mock course brief (in production, parse from COURSE-BRIEF.md)
    course_brief = {
        "title": curriculum.get("title", "Untitled Course"),
        "icp": {},
        "learning_objectives": [],
        "voice_profile": {},
        "mmos_persona": {}
    }

    # Generate lessons
    generator = LessonGenerator(course_slug, curriculum, course_brief)
    result = generator.generate_all_lessons()

    print(f"\n✅ Generation complete: {len(result.completed)}/{result.total_lessons} lessons")
    sys.exit(0 if len(result.failed) == 0 else 1)
