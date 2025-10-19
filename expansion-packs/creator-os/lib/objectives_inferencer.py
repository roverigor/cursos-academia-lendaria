#!/usr/bin/env python3
"""
Learning Objectives Inferencer for CreatorOS Brownfield Workflow

This module implements intelligent learning objectives inference from existing course content.
Part of Story 3.5: Learning Objectives Inference Engine (EPIC-3: Intelligent Workflow)

Key Features:
- Content file discovery (curriculum, lesson files, course outlines)
- Pedagogical intent extraction from filenames and structure
- Bloom's Taxonomy classification
- Multi-lesson aggregation to course-level objectives
- COURSE-BRIEF Section 3.2 auto-population
- Educational annotations about writing good objectives

Detection Strategies:
1. Curriculum files: curriculum.yaml, syllabus.md, course-outline.md
2. Lesson files: 1.1-*.md, lesson-*.md, aula-*.md
3. Pattern matching: Installation → Apply, Concept → Understand, etc.

Objective Quality:
- Uses Bloom's action verbs
- Measurable and specific
- Student-outcome focused
- Appropriate cognitive level

Usage:
    from lib.objectives_inferencer import ObjectivesInferencer

    inferencer = ObjectivesInferencer("dominando-obsidian")
    lessons = inferencer.find_legacy_lessons()
    objectives = inferencer.synthesize_course_objectives()
    inferencer.prefill_course_brief(objectives)
"""

import os
import re
import yaml
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional
from dataclasses import dataclass, asdict
from collections import defaultdict


@dataclass
class LessonFile:
    """Metadata for a lesson file."""
    path: str  # Absolute path
    relative_path: str  # Path relative to course folder
    title: str  # Clean title extracted from filename
    content_type: str  # Lesson pattern type
    detected_at: str  # ISO timestamp


@dataclass
class LessonObjective:
    """Learning objective inferred from a lesson."""
    objective: str  # Objective text
    bloom_level: str  # Bloom's taxonomy level name
    bloom_level_number: int  # Bloom's taxonomy level (1-6)
    source_lesson: str  # Source lesson filename
    confidence: int  # Confidence score (0-100)
    pattern_used: str  # Pattern name used for inference


@dataclass
class CourseObjective:
    """Course-level learning objective (aggregated from lessons)."""
    objective: str  # Objective text
    bloom_level: str  # Bloom's taxonomy level name
    bloom_level_number: int  # Bloom's taxonomy level (1-6)
    source_lessons: List[str]  # List of source lesson filenames
    confidence: int  # Confidence score (0-100)
    cluster_name: str  # Semantic cluster name


class ObjectivesInferencer:
    """
    Intelligent learning objectives inferencer for brownfield course materials.

    Discovers lesson files, infers objectives using pedagogical patterns,
    aggregates to course-level objectives, and auto-fills COURSE-BRIEF Section 3.2.
    """

    def __init__(self, course_slug: str):
        """
        Initialize ObjectivesInferencer for a specific course.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
        """
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug

        if not self.base_path.exists():
            raise FileNotFoundError(f"Course folder not found: {self.base_path}")

        # Load pattern libraries
        templates_path = Path("expansion-packs/creator-os/templates")
        self.patterns_library = self._load_yaml(templates_path / "pedagogical-patterns.yaml")
        self.blooms_taxonomy = self._load_yaml(templates_path / "blooms-taxonomy.yaml")

    def _load_yaml(self, file_path: Path) -> Dict:
        """Load YAML file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return yaml.safe_load(f)
        except Exception as e:
            print(f"⚠️  Error loading {file_path}: {e}")
            return {}

    def find_legacy_lessons(self) -> List[LessonFile]:
        """
        Detect existing lesson files to infer content structure.

        Searches in (priority order):
        1. /lessons/ folder (primary)
        2. /sources/ folder (secondary)
        3. Course root (fallback)

        Returns:
            List of LessonFile objects
        """
        print(f"🔍 Searching for lesson files in: {self.base_path}")
        lessons = []

        # Search paths (order matters)
        search_paths = [
            self.base_path / "lessons",
            self.base_path / "sources",
            self.base_path,
        ]

        # Filename patterns for lessons
        patterns = [
            r'^\d+\.\d+.*\.md$',  # 1.1-lesson-name.md
            r'^aula.*\.md$',  # aula-1-nome.md
            r'^lesson.*\.md$',  # lesson-1-name.md
            r'^modulo.*\.md$',  # modulo-1.md
        ]

        for search_path in search_paths:
            if not search_path.exists():
                continue

            # Scan files
            if search_path == self.base_path:
                # Root: only direct children
                files = [f for f in search_path.iterdir() if f.is_file()]
            else:
                # Subdirectories: recursive scan
                files = [f for f in search_path.rglob("*.md") if f.is_file()]

            for file_path in files:
                filename = file_path.name

                # Check if matches lesson pattern
                if not any(re.match(p, filename, re.IGNORECASE) for p in patterns):
                    continue

                # Validate content (must have headers - structured content)
                if not self._validate_lesson_content(file_path):
                    continue

                # Extract lesson metadata
                title = self._clean_lesson_title(filename)
                content_type = self._classify_content_type(title)

                relative_path = file_path.relative_to(self.base_path)
                lessons.append(LessonFile(
                    path=str(file_path),
                    relative_path=str(relative_path),
                    title=title,
                    content_type=content_type,
                    detected_at=datetime.utcnow().isoformat() + "Z"
                ))

        print(f"✓ Found {len(lessons)} lesson file(s)")
        for i, lesson in enumerate(lessons[:5], 1):  # Show first 5
            print(f"  {i}. {lesson.relative_path} → {lesson.title} ({lesson.content_type})")

        if len(lessons) > 5:
            print(f"  ... and {len(lessons) - 5} more")

        return lessons

    def _validate_lesson_content(self, file_path: Path) -> bool:
        """
        Validate that file has lesson-like structure.

        Checks for:
        - Headers (##)
        - Sufficient length (>100 chars)

        Returns:
            True if valid lesson, False otherwise
        """
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read(1024)  # First 1KB

            # Must have headers
            if '##' not in content:
                return False

            # Must have some content
            if len(content) < 100:
                return False

            return True

        except Exception:
            return False

    def _clean_lesson_title(self, filename: str) -> str:
        """
        Extract clean title from filename.

        Examples:
        - "1.3-instalacao-multi-plataforma.md" → "Instalação Multi Plataforma"
        - "aula-5-tags-obsidian.md" → "Tags Obsidian"
        - "workshop-links-internos.md" → "Workshop Links Internos"

        Args:
            filename: Filename with extension

        Returns:
            Clean title string
        """
        # Remove extension
        title = filename.replace('.md', '').replace('.markdown', '')

        # Remove numbering (1.3-, aula-5-, etc.)
        title = re.sub(r'^\d+\.\d+[-_\s]*', '', title)  # 1.3-
        title = re.sub(r'^aula[-_\s]*\d+[-_\s]*', '', title, flags=re.IGNORECASE)  # aula-5-
        title = re.sub(r'^lesson[-_\s]*\d+[-_\s]*', '', title, flags=re.IGNORECASE)  # lesson-5-
        title = re.sub(r'^modulo[-_\s]*\d+[-_\s]*', '', title, flags=re.IGNORECASE)  # modulo-1-

        # Replace hyphens/underscores with spaces
        title = title.replace('-', ' ').replace('_', ' ')

        # Title case
        title = title.title()

        return title.strip()

    def _classify_content_type(self, title: str) -> str:
        """
        Detect content type from title keywords.

        Types: installation, concept_explanation, hands_on_practice,
               why_use, troubleshooting, advanced_technique

        Args:
            title: Clean lesson title

        Returns:
            Content type string
        """
        title_lower = title.lower()

        # Check each pattern's keywords
        patterns = self.patterns_library.get("patterns", {})

        for pattern_name, pattern_data in patterns.items():
            keywords = pattern_data.get("keywords", [])

            for keyword in keywords:
                if keyword in title_lower:
                    return pattern_name

        # Default
        return "concept_explanation"

    def infer_lesson_objective(self, lesson: LessonFile) -> LessonObjective:
        """
        Match lesson to pedagogical pattern and generate objective.

        Args:
            lesson: LessonFile object

        Returns:
            LessonObjective object
        """
        # Get pattern for this content type
        patterns = self.patterns_library.get("patterns", {})
        pattern = patterns.get(lesson.content_type)

        if not pattern:
            # Fallback to default
            pattern = self.patterns_library.get("default_pattern", {})
            pattern_name = "default"
        else:
            pattern_name = lesson.content_type

        # Extract entities from title (tool names, topics, etc.)
        entities = self._extract_entities(lesson.title)

        # Fill objective template
        template = pattern.get("objective_template", "Understand {topic}")
        objective_text = self._fill_template(template, entities)

        # Ensure starts with Bloom's action verb
        objective_text = self._ensure_bloom_verb(objective_text, pattern.get("bloom_level", "Understand"))

        # Calculate confidence
        confidence = self._calculate_match_confidence(lesson.title, pattern)

        return LessonObjective(
            objective=objective_text,
            bloom_level=pattern.get("bloom_level", "Understand"),
            bloom_level_number=pattern.get("bloom_level_number", 2),
            source_lesson=lesson.relative_path,
            confidence=confidence,
            pattern_used=pattern_name
        )

    def _extract_entities(self, title: str) -> Dict[str, str]:
        """
        Extract entities from title (tool, topic, platform, etc.).

        Args:
            title: Clean title

        Returns:
            Dictionary of entities
        """
        entities = {
            "topic": title,  # Default to full title
            "tool": "",
            "platform": "",
            "use_case": "",
        }

        # Common tools
        tools = ["obsidian", "notion", "chatgpt", "ai", "python", "docker", "git", "vscode"]
        for tool in tools:
            if tool in title.lower():
                entities["tool"] = tool.title()
                # Remove tool from topic
                entities["topic"] = title.replace(tool, "").replace(tool.title(), "").strip()

        # Common platforms
        platforms = ["windows", "mac", "linux", "android", "ios", "web", "multi-plataforma", "cross-platform"]
        for platform in platforms:
            if platform in title.lower():
                entities["platform"] = platform.title()

        return entities

    def _fill_template(self, template: str, entities: Dict[str, str]) -> str:
        """
        Fill objective template with extracted entities.

        Args:
            template: Template string with {placeholders}
            entities: Dictionary of entities

        Returns:
            Filled template
        """
        result = template

        for key, value in entities.items():
            placeholder = "{" + key + "}"
            if placeholder in result and value:
                result = result.replace(placeholder, value)

        # Clean up unfilled placeholders
        result = re.sub(r'\{[^\}]+\}', entities.get("topic", ""), result)

        # Clean up extra spaces
        result = re.sub(r'\s+', ' ', result).strip()

        return result

    def _ensure_bloom_verb(self, objective: str, bloom_level: str) -> str:
        """
        Ensure objective starts with Bloom's action verb.

        Args:
            objective: Objective text
            bloom_level: Bloom's taxonomy level name

        Returns:
            Objective starting with action verb
        """
        # Get action verbs for this level
        taxonomy = self.blooms_taxonomy.get("blooms_taxonomy", {})
        level_data = taxonomy.get(bloom_level.lower(), {})
        action_verbs = level_data.get("action_verbs", [])

        if not action_verbs:
            return objective

        # Check if starts with action verb
        first_word = objective.split()[0] if objective else ""

        for verb in action_verbs:
            if first_word.lower() == verb.lower():
                return objective  # Already starts with valid verb

        # Prepend suggested verb
        suggested_verb = action_verbs[0]  # Use first verb
        return f"{suggested_verb} {objective}"

    def _calculate_match_confidence(self, title: str, pattern: Dict) -> int:
        """
        Calculate confidence of pattern match.

        Factors:
        - Keyword matches in title
        - Title clarity (length, specificity)

        Args:
            title: Lesson title
            pattern: Pattern dictionary

        Returns:
            Confidence score (0-100)
        """
        title_lower = title.lower()
        keywords = pattern.get("keywords", [])

        # Count keyword matches
        matches = sum(1 for keyword in keywords if keyword in title_lower)

        if matches >= 2:
            base_confidence = 90
        elif matches == 1:
            base_confidence = 70
        else:
            base_confidence = 50

        # Adjust for title clarity
        word_count = len(title.split())
        if word_count >= 3:  # Specific title
            clarity_bonus = 10
        elif word_count >= 2:
            clarity_bonus = 5
        else:  # Very short, likely vague
            clarity_bonus = -10

        total_confidence = base_confidence + clarity_bonus

        return max(0, min(100, total_confidence))  # Clamp to 0-100

    def synthesize_course_objectives(self, lesson_objectives: List[LessonObjective]) -> List[CourseObjective]:
        """
        Aggregate lesson-level objectives into 3-5 course-level objectives.

        Strategy:
        1. Group by Bloom's level and semantic similarity
        2. Prioritize higher Bloom's levels (Apply, Analyze, Create > Understand)
        3. Create course-level objective per cluster
        4. Limit to max 5 objectives

        Args:
            lesson_objectives: List of LessonObjective objects

        Returns:
            List of 3-5 CourseObjective objects
        """
        print(f"\n📊 Synthesizing course objectives from {len(lesson_objectives)} lesson(s)")

        if not lesson_objectives:
            return []

        # Group by Bloom's level
        by_bloom_level = defaultdict(list)
        for obj in lesson_objectives:
            by_bloom_level[obj.bloom_level].append(obj)

        # Semantic clustering (simplified: by pattern used)
        clusters = []
        for bloom_level, objectives in by_bloom_level.items():
            # Cluster by pattern
            by_pattern = defaultdict(list)
            for obj in objectives:
                by_pattern[obj.pattern_used].append(obj)

            # Create course objective per pattern cluster
            for pattern_name, pattern_objectives in by_pattern.items():
                cluster_name = self._generate_cluster_name(pattern_name, pattern_objectives)
                merged_objective = self._merge_objectives(pattern_objectives, cluster_name)
                clusters.append(merged_objective)

        # Sort by Bloom's level (higher levels first for interest)
        clusters.sort(key=lambda obj: obj.bloom_level_number, reverse=True)

        # Limit to 5
        course_objectives = clusters[:5]

        print(f"✓ Synthesized {len(course_objectives)} course objective(s)")
        for i, obj in enumerate(course_objectives, 1):
            print(f"  {i}. [{obj.bloom_level}] {obj.objective}")
            print(f"     Sources: {len(obj.source_lessons)} lesson(s), Confidence: {obj.confidence}%")

        return course_objectives

    def _generate_cluster_name(self, pattern_name: str, objectives: List[LessonObjective]) -> str:
        """
        Generate semantic cluster name from pattern and objectives.

        Args:
            pattern_name: Pattern name
            objectives: List of objectives in cluster

        Returns:
            Cluster name string
        """
        # Use pattern name as base
        pattern_names = {
            "installation": "Installation & Setup",
            "concept_explanation": "Core Concepts",
            "hands_on_practice": "Hands-On Practice",
            "why_use": "Decision Making",
            "troubleshooting": "Problem Solving",
            "advanced_technique": "Advanced Techniques",
            "default": "General Topics",
        }

        return pattern_names.get(pattern_name, pattern_name.replace("_", " ").title())

    def _merge_objectives(self, objectives: List[LessonObjective], cluster_name: str) -> CourseObjective:
        """
        Merge multiple lesson objectives into one course objective.

        Args:
            objectives: List of LessonObjective objects
            cluster_name: Cluster semantic name

        Returns:
            CourseObjective object
        """
        # Use first objective as base (highest confidence)
        objectives.sort(key=lambda obj: obj.confidence, reverse=True)
        base_obj = objectives[0]

        # Calculate average confidence
        avg_confidence = int(sum(obj.confidence for obj in objectives) / len(objectives))

        # Collect source lessons
        source_lessons = [obj.source_lesson for obj in objectives]

        # Create generalized objective text
        # For clusters with 3+ lessons, make it more general
        if len(objectives) >= 3:
            objective_text = self._generalize_objective(base_obj.objective, cluster_name)
        else:
            objective_text = base_obj.objective

        return CourseObjective(
            objective=objective_text,
            bloom_level=base_obj.bloom_level,
            bloom_level_number=base_obj.bloom_level_number,
            source_lessons=source_lessons,
            confidence=avg_confidence,
            cluster_name=cluster_name
        )

    def _generalize_objective(self, specific_objective: str, cluster_name: str) -> str:
        """
        Generalize a specific objective to cover multiple lessons.

        Args:
            specific_objective: Specific lesson objective
            cluster_name: Cluster name

        Returns:
            Generalized objective
        """
        # Extract action verb (first word)
        words = specific_objective.split()
        if not words:
            return cluster_name

        action_verb = words[0]

        # Create general objective
        return f"{action_verb} {cluster_name.lower()} effectively"

    def prefill_course_brief(self, course_objectives: List[CourseObjective]) -> bool:
        """
        Pre-fill COURSE-BRIEF.md Section 3.2 with inferred objectives.

        Args:
            course_objectives: List of CourseObjective objects

        Returns:
            True if brief was modified, False otherwise
        """
        brief_path = self.base_path / "COURSE-BRIEF.md"

        if not brief_path.exists():
            print(f"⚠️  COURSE-BRIEF.md not found at: {brief_path}")
            return False

        # Read current brief
        with open(brief_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Find Section 3.2 (Learning Objectives)
        section_pattern = r'(### 3\.2\. Objetivos de Aprendizagem.*?)(?=###|\Z)'

        match = re.search(section_pattern, content, re.DOTALL)

        if not match:
            print("⚠️  Section 3.2 (Objetivos de Aprendizagem) not found in COURSE-BRIEF.md")
            return False

        # Generate replacement content
        if not course_objectives:
            # No lessons found - insert empty template with red status
            replacement = self._generate_empty_objectives_section()
        else:
            # Objectives inferred - insert extracted data
            replacement = self._generate_filled_objectives_section(course_objectives)

        # Replace Section 3.2
        new_content = content[:match.start()] + replacement + content[match.end():]

        # Write updated brief
        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(new_content)

        print(f"✓ Updated COURSE-BRIEF.md Section 3.2")

        return True

    def _generate_empty_objectives_section(self) -> str:
        """Generate empty objectives section template (red status)."""
        return """### 3.2. Objetivos de Aprendizagem

🔴 **Status:** No legacy lessons found to infer objectives.

**Instruções:**
Define 3-5 learning objectives for your course:

1. {Action verb} {specific outcome}
2. {Action verb} {specific outcome}
3. {Action verb} {specific outcome}

Refer to Bloom's Taxonomy guide below.

📚 **Bloom's Taxonomy Reference:**
- **Understand:** Explain, describe, summarize
- **Apply:** Use, implement, execute (hands-on)
- **Analyze:** Compare, troubleshoot, examine
- **Evaluate:** Assess, justify, critique
- **Create:** Design, build, develop (original work)

"""

    def _generate_filled_objectives_section(self, objectives: List[CourseObjective]) -> str:
        """Generate filled objectives section from inferred data."""

        # Calculate stats
        total_lessons = len(set([lesson for obj in objectives for lesson in obj.source_lessons]))
        avg_confidence = int(sum(obj.confidence for obj in objectives) / len(objectives)) if objectives else 0

        # Determine status indicator
        if avg_confidence >= 80 and total_lessons >= 10:
            status = "🟢"
            status_text = f"Inferred from {total_lessons} legacy lessons ({avg_confidence}% avg confidence)"
        elif avg_confidence >= 60 and total_lessons >= 5:
            status = "🟡"
            status_text = f"Inferred from {total_lessons} lessons ({avg_confidence}% avg confidence - review recommended)"
        else:
            status = "🟡"
            status_text = f"Inferred from {total_lessons} lesson(s) ({avg_confidence}% avg confidence)"

        # Build objectives list
        objectives_md = ""
        for i, obj in enumerate(objectives, 1):
            # Source lessons preview (max 3)
            source_preview = ', '.join([Path(s).name for s in obj.source_lessons[:3]])
            if len(obj.source_lessons) > 3:
                source_preview += f" + {len(obj.source_lessons) - 3} more"

            objectives_md += f"""
{i}. **{obj.objective}**
   - Bloom's Level: {obj.bloom_level}
   - Source: {source_preview}
   - Confidence: {obj.confidence}%
"""

        # Build full section
        return f"""### 3.2. Objetivos de Aprendizagem

{status} **Status:** {status_text}

**Objetivos do Curso:**
{objectives_md}

---
📝 **Instruções:**
- These objectives were inferred from your existing lessons.
- Review for accuracy and alignment with your vision.
- Edit to refine wording or add/remove objectives.
- Ensure objectives match what students will ACTUALLY achieve.
- When satisfied, change status to ✅.

📚 **Bloom's Taxonomy Reference:**
- **Understand:** Explain, describe, summarize
- **Apply:** Use, implement, execute (hands-on)
- **Analyze:** Compare, troubleshoot, examine
- **Evaluate:** Assess, justify, critique
- **Create:** Design, build, develop (original work)

**Target Distribution for Practical Courses:**
- 20% Understand
- 50% Apply (most objectives here!)
- 20% Analyze
- 10% Create

**Examples:**

❌ Bad: "Understand Obsidian" (vague, not measurable)
✅ Good: "Build a second brain system in Obsidian" (specific, measurable)

❌ Bad: "Learn about links" (passive)
✅ Good: "Connect notes using bi-directional links" (active, clear outcome)

"""


def main():
    """CLI interface for testing objectives inferencer."""
    import sys

    if len(sys.argv) < 2 or "--help" in sys.argv or "-h" in sys.argv:
        print("Usage: python objectives_inferencer.py <course-slug>")
        print("")
        print("Arguments:")
        print("  course-slug     Course identifier (e.g., 'dominando-obsidian')")
        print("")
        print("Example:")
        print("  python objectives_inferencer.py dominando-obsidian")
        sys.exit(0 if "--help" in sys.argv or "-h" in sys.argv else 1)

    course_slug = sys.argv[1]

    try:
        inferencer = ObjectivesInferencer(course_slug)

        # Step 1: Find lessons
        print("=" * 60)
        lessons = inferencer.find_legacy_lessons()
        print("=" * 60)

        if not lessons:
            print("\n⚠️  No legacy lessons found. Generating empty template...")
            print("=" * 60)
            inferencer.prefill_course_brief([])
            print("=" * 60)
            return

        # Step 2: Infer lesson objectives
        print("\n" + "=" * 60)
        print(f"🎯 Inferring objectives from {len(lessons)} lesson(s)")
        print("=" * 60)

        lesson_objectives = []
        for lesson in lessons:
            obj = inferencer.infer_lesson_objective(lesson)
            lesson_objectives.append(obj)

        # Step 3: Synthesize course objectives
        print("\n" + "=" * 60)
        course_objectives = inferencer.synthesize_course_objectives(lesson_objectives)
        print("=" * 60)

        # Step 4: Prefill COURSE-BRIEF
        print("\n" + "=" * 60)
        inferencer.prefill_course_brief(course_objectives)
        print("=" * 60)

        # Preview results
        print("\n" + "=" * 60)
        print("📊 Course Objectives Summary")
        print("=" * 60)
        for i, obj in enumerate(course_objectives, 1):
            print(f"\n{i}. {obj.objective}")
            print(f"   Level: {obj.bloom_level}")
            print(f"   Sources: {len(obj.source_lessons)} lesson(s)")
            print(f"   Confidence: {obj.confidence}%")

        print("\n✅ Objectives inference completed successfully!")

    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
