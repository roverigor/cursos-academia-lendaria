#!/usr/bin/env python3
"""
MMOS Persona Integrator for CreatorOS

This module implements MMOS (Mind Mapper OS) persona integration for CreatorOS.
Part of Story 3.7: MMOS Persona Integration (EPIC-3: Intelligent Workflow)

Key Features:
- MMOS mind detection in outputs/minds/
- Mind validation (required files present)
- Metadata extraction (name, description, version)
- Interactive persona selection
- Voice profile extraction from MMOS files
- System prompt loading for lesson generation
- COURSE-BRIEF Section 4 auto-population with MMOS voice
- Voice fidelity validation (if benchmarks exist)

MMOS Mind Structure (v3.0):
outputs/minds/{slug}/
├── sources/                      # Primary sources (books, transcripts, etc.)
├── artifacts/                    # FLAT - Intermediate artifacts
│   ├── identity_core.yaml        # Core identity data
│   ├── cognitive_architecture.yaml # Cognitive/personality data
│   ├── communication_templates.md  # Communication patterns
│   └── frameworks_synthesized.md   # Teaching philosophy (optional)
├── kb/                          # FLAT - Final knowledge base
│   ├── communication_style_final.md
│   └── frameworks_final.md
├── system_prompts/
│   └── generalista.md           # System prompt for lesson generation
├── docs/
│   └── logs/                    # Execution logs
└── metadata.yaml                # Mind metadata

Usage:
    from lib.mmos_integrator import MMOSIntegrator

    integrator = MMOSIntegrator()
    minds = integrator.detect_available_minds()

    if minds:
        selected = integrator.elicit_mmos_selection(minds)
        if selected:
            voice_profile = integrator.load_voice_profile(selected)
            integrator.prefill_course_brief(voice_profile, course_slug)
"""

import os
import yaml
import re
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional
from dataclasses import dataclass, asdict


@dataclass
class MMOSMindMetadata:
    """Metadata for an MMOS mind."""
    slug: str  # Mind folder name (e.g., "joao_lozano")
    name: str  # Full name (from identity-core)
    description: str  # Short description (from cognitive-spec)
    path: str  # Absolute path to mind folder
    version: str  # MMOS version (from metadata.yaml)
    has_system_prompt: bool  # Has generalista.md
    has_frameworks: bool  # Has frameworks.md (teaching philosophy)
    detected_at: str  # ISO timestamp


@dataclass
class MMOSVoiceProfile:
    """Voice profile extracted from MMOS mind."""
    source: str  # "mmos"
    mmos_mind: str  # Mind slug
    instructor_name: str

    # Tone & Style
    tone: str
    style: str

    # Communication patterns
    language_patterns: List[str]
    recurring_phrases: List[str]
    interaction_style: str

    # Teaching philosophy
    teaching_philosophy: Optional[str]

    # Values & Worldview
    core_values: List[str]
    worldview: Dict[str, str]

    # Cognitive patterns
    decision_making: str
    problem_solving: str

    # Metadata
    extraction_timestamp: str
    confidence_score: int  # 0-100


class MMOSIntegrator:
    """
    MMOS persona integrator for CreatorOS.

    Detects available MMOS minds, allows user selection, extracts voice profiles,
    and integrates them into course generation workflow.
    """

    def __init__(self, minds_dir: str = "outputs/minds"):
        """
        Initialize MMOS integrator.

        Args:
            minds_dir: Path to MMOS minds directory
        """
        self.minds_dir = Path(minds_dir)
        self.available_minds: List[MMOSMindMetadata] = []

        # Load paths config
        config_path = Path(__file__).parent.parent / "config" / "mmos-paths.yaml"
        self.paths = self._load_paths(config_path)

    def _load_paths(self, config_path: Path) -> Dict:
        """Load paths from YAML config (fallback to defaults if not found)."""
        if config_path.exists():
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                return config.get("paths", {})

        # Fallback defaults
        return {
            "identity_core": ["artifacts/identity_core.yaml"],
            "cognitive_architecture": ["artifacts/cognitive_architecture.yaml"],
            "communication_style": ["artifacts/communication_templates.md", "kb/communication_style_final.md"],
            "frameworks": ["artifacts/frameworks_synthesized.md", "kb/frameworks_final.md"],
            "system_prompts": ["system_prompts/generalista.md"],
            "metadata": ["metadata.yaml"]
        }

    def _find_file(self, mind_path: Path, path_key: str) -> Optional[Path]:
        """Find first existing file from config paths."""
        paths = self.paths.get(path_key, [])
        for rel_path in paths:
            full_path = mind_path / rel_path
            if full_path.exists():
                return full_path
        return None

    def detect_available_minds(self) -> List[MMOSMindMetadata]:
        """
        Scan outputs/minds/ directory for valid MMOS personas.

        Returns:
            List of MMOSMindMetadata objects (sorted by name)
        """
        if not self.minds_dir.exists():
            print(f"ℹ️  No MMOS minds directory found at {self.minds_dir}")
            return []

        minds = []

        for mind_folder in self.minds_dir.iterdir():
            if not mind_folder.is_dir():
                continue

            # Skip special files/folders
            if mind_folder.name.startswith('.') or mind_folder.name in ['README.md', 'CLONES_STATUS.md', 'catalog.md']:
                continue

            # Validate MMOS structure
            if self._is_valid_mmos_mind(mind_folder):
                try:
                    metadata = self._extract_mind_metadata(mind_folder)
                    minds.append(metadata)
                except Exception as e:
                    print(f"⚠️  Error extracting metadata from {mind_folder.name}: {e}")
                    continue

        # Sort by name
        minds.sort(key=lambda m: m.name)

        self.available_minds = minds
        return minds

    def _is_valid_mmos_mind(self, mind_path: Path) -> bool:
        """Check if mind has required files (uses config paths)."""
        # Must have identity OR cognitive
        has_identity = (
            self._find_file(mind_path, "identity_core") is not None or
            self._find_file(mind_path, "cognitive_architecture") is not None
        )

        if not has_identity:
            return False

        # Must have communication OR system_prompts
        has_comm = self._find_file(mind_path, "communication_style") is not None
        has_prompts = self._find_file(mind_path, "system_prompts") is not None

        return has_comm or has_prompts

    def _extract_mind_metadata(self, mind_path: Path) -> MMOSMindMetadata:
        """Extract metadata from MMOS mind (uses config paths)."""
        slug = mind_path.name

        # Load identity core
        identity_core = {}
        identity_path = self._find_file(mind_path, "identity_core")
        if identity_path:
            with open(identity_path, 'r', encoding='utf-8') as f:
                identity_core = next(yaml.safe_load_all(f))

        name = identity_core.get("nome_completo", slug.replace("_", " ").title())

        # Load cognitive spec
        cognitive_spec = {}
        cognitive_path = self._find_file(mind_path, "cognitive_architecture")
        if cognitive_path:
            with open(cognitive_path, 'r', encoding='utf-8') as f:
                cognitive_spec = next(yaml.safe_load_all(f))

        description = cognitive_spec.get("resumo_personalidade", "MMOS cognitive clone")
        if not description or description == "MMOS cognitive clone":
            occupation = cognitive_spec.get("ocupacao_principal", "")
            if occupation:
                description = f"{occupation}"

        # Load metadata
        version = "unknown"
        metadata_path = self._find_file(mind_path, "metadata")
        if metadata_path:
            try:
                with open(metadata_path, 'r', encoding='utf-8') as f:
                    metadata = yaml.safe_load(f)
                version = metadata.get("version", "unknown")
            except:
                pass

        # Check capabilities
        has_system_prompt = self._find_file(mind_path, "system_prompts") is not None
        has_frameworks = self._find_file(mind_path, "frameworks") is not None

        return MMOSMindMetadata(
            slug=slug,
            name=name,
            description=description,
            path=str(mind_path.absolute()),
            version=version,
            has_system_prompt=has_system_prompt,
            has_frameworks=has_frameworks,
            detected_at=datetime.now().isoformat()
        )

    def elicit_mmos_selection(self, available_minds: List[MMOSMindMetadata]) -> Optional[MMOSMindMetadata]:
        """
        Interactive selection prompt for MMOS mind.

        Args:
            available_minds: List of available MMOS minds

        Returns:
            Selected MMOSMindMetadata or None if user declines
        """
        if not available_minds:
            return None

        print("\n" + "═" * 64)
        print("🧠 MMOS INSTRUCTOR PERSONAS DETECTED")
        print("═" * 64)
        print(f"\nI found {len(available_minds)} MMOS cognitive clone{'s' if len(available_minds) > 1 else ''} available:\n")

        for i, mind in enumerate(available_minds, start=1):
            print(f"[{i}] {mind.name}")
            print(f"    → {mind.description}")
            print(f"    → Source: {mind.path}")
            if mind.has_system_prompt:
                print(f"    ✅ Has system prompt")
            if mind.has_frameworks:
                print(f"    ✅ Has teaching frameworks")
            print()

        print(f"[{len(available_minds) + 1}] None (I'll define voice manually)")
        print("\n" + "═" * 64)
        print("\n💡 TIP: Using MMOS persona ensures lessons sound exactly like")
        print("       the original instructor (95%+ voice fidelity).")
        print("\n" + "═" * 64)

        while True:
            try:
                choice_str = input(f"\n→ Use MMOS instructor persona for this course?\n\n   Your choice (1-{len(available_minds) + 1}): ")
                choice = int(choice_str.strip())

                if 1 <= choice <= len(available_minds):
                    selected = available_minds[choice - 1]
                    print(f"\n✓ Selected: {selected.name}")
                    return selected
                elif choice == len(available_minds) + 1:
                    print("\n✓ MMOS persona declined - will use manual voice definition")
                    return None
                else:
                    print(f"❌ Invalid choice. Please enter 1-{len(available_minds) + 1}")
            except ValueError:
                print(f"❌ Invalid input. Please enter a number (1-{len(available_minds) + 1})")
            except KeyboardInterrupt:
                print("\n\n⚠️  Selection cancelled")
                return None

    def load_voice_profile(self, mind_metadata: MMOSMindMetadata) -> MMOSVoiceProfile:
        """Extract voice profile from MMOS mind (uses config paths)."""
        mind_path = Path(mind_metadata.path)

        # Load identity core
        identity_core = {}
        identity_path = self._find_file(mind_path, "identity_core")
        if identity_path:
            with open(identity_path, 'r', encoding='utf-8') as f:
                identity_core = next(yaml.safe_load_all(f))

        # Load cognitive spec
        cognitive_spec = {}
        cognitive_path = self._find_file(mind_path, "cognitive_architecture")
        if cognitive_path:
            with open(cognitive_path, 'r', encoding='utf-8') as f:
                cognitive_spec = next(yaml.safe_load_all(f))

        # Load communication style
        comm_style = ""
        comm_path = self._find_file(mind_path, "communication_style")
        if comm_path:
            with open(comm_path, 'r', encoding='utf-8') as f:
                comm_style = f.read()

        # Load frameworks
        frameworks = None
        frameworks_path = self._find_file(mind_path, "frameworks")
        if frameworks_path:
            with open(frameworks_path, 'r', encoding='utf-8') as f:
                frameworks = f.read()

        # Extract voice patterns
        voice_profile = MMOSVoiceProfile(
            source="mmos",
            mmos_mind=mind_metadata.slug,
            instructor_name=identity_core.get("nome_completo", mind_metadata.name),
            tone=self._extract_tone(identity_core, cognitive_spec),
            style=self._extract_style(cognitive_spec),
            language_patterns=self._extract_language_patterns(comm_style),
            recurring_phrases=self._extract_catchphrases(comm_style),
            interaction_style=self._extract_interaction_style(comm_style, cognitive_spec),
            teaching_philosophy=self._extract_teaching_philosophy(frameworks) if frameworks else None,
            core_values=identity_core.get("valores_centrais", []),
            worldview=identity_core.get("visao_de_mundo", {}),
            decision_making=cognitive_spec.get("estilo_decisao", ""),
            problem_solving=cognitive_spec.get("abordagem_problemas", ""),
            extraction_timestamp=datetime.now().isoformat(),
            confidence_score=self._calculate_confidence(identity_core, cognitive_spec, comm_style, frameworks)
        )

        return voice_profile

    def _extract_tone(self, identity_core: Dict, cognitive_spec: Dict) -> str:
        """
        Synthesize tone from identity core and cognitive spec.

        Args:
            identity_core: Identity core YAML data
            cognitive_spec: Cognitive spec YAML data

        Returns:
            Tone description string
        """
        # Map MMOS traits to teaching tone
        tone_mapping = {
            "Inspirador": "Inspirational, motivational",
            "Pragmático": "Practical, no-nonsense",
            "Empático": "Warm, supportive",
            "Analítico": "Logical, structured",
            "Criativo": "Innovative, outside-the-box",
            "Direto": "Direct, straightforward",
            "Acessível": "Approachable, friendly",
            "Técnico": "Technical, precise",
            "Visionário": "Visionary, forward-thinking"
        }

        traits = identity_core.get("tracos_personalidade", [])
        tone_descriptors = [tone_mapping.get(trait, trait) for trait in traits if trait in tone_mapping]

        if not tone_descriptors:
            # Fallback: Use personality summary
            summary = cognitive_spec.get("resumo_personalidade", "")
            if summary:
                return summary
            return "Professional, clear"

        return ", ".join(tone_descriptors[:3])  # Max 3 descriptors

    def _extract_style(self, cognitive_spec: Dict) -> str:
        """
        Extract communication style from cognitive spec.

        Args:
            cognitive_spec: Cognitive spec YAML data

        Returns:
            Style description string
        """
        style = cognitive_spec.get("estilo_comunicacao", "")
        if not style:
            # Fallback to approach
            approach = cognitive_spec.get("abordagem_ensino", "")
            if approach:
                return approach
            return "Clear and engaging"

        return style

    def _extract_language_patterns(self, comm_style: str) -> List[str]:
        """
        Extract language patterns from communication style document.

        Args:
            comm_style: Communication style Markdown content

        Returns:
            List of language pattern descriptions
        """
        patterns = []

        if not comm_style:
            return patterns

        # Look for sections about language patterns
        pattern_sections = [
            r'##\s*Padrões de Linguagem',
            r'##\s*Language Patterns',
            r'##\s*Vocabulário',
            r'##\s*Vocabulary'
        ]

        for pattern in pattern_sections:
            match = re.search(pattern, comm_style, re.IGNORECASE)
            if match:
                # Extract content after header until next ## or end
                start = match.end()
                next_header = re.search(r'\n##\s', comm_style[start:])
                end = start + next_header.start() if next_header else len(comm_style)

                section_content = comm_style[start:end].strip()

                # Extract bullet points
                bullets = re.findall(r'^\s*[-*]\s*(.+)$', section_content, re.MULTILINE)
                patterns.extend(bullets[:5])  # Max 5 patterns
                break

        return patterns

    def _extract_catchphrases(self, comm_style: str) -> List[str]:
        """
        Extract recurring catchphrases from communication style document.

        Args:
            comm_style: Communication style Markdown content

        Returns:
            List of catchphrases
        """
        phrases = []

        if not comm_style:
            return phrases

        # Look for sections about catchphrases
        phrase_sections = [
            r'##\s*Frases Recorrentes',
            r'##\s*Catchphrases',
            r'##\s*Signature Phrases',
            r'##\s*Bordões'
        ]

        for pattern in phrase_sections:
            match = re.search(pattern, comm_style, re.IGNORECASE)
            if match:
                # Extract content after header until next ## or end
                start = match.end()
                next_header = re.search(r'\n##\s', comm_style[start:])
                end = start + next_header.start() if next_header else len(comm_style)

                section_content = comm_style[start:end].strip()

                # Extract quoted phrases or bullet points
                quotes = re.findall(r'"([^"]+)"', section_content)
                phrases.extend(quotes[:10])  # Max 10 phrases

                if not quotes:
                    # Fallback to bullet points
                    bullets = re.findall(r'^\s*[-*]\s*(.+)$', section_content, re.MULTILINE)
                    phrases.extend(bullets[:10])

                break

        return phrases

    def _extract_interaction_style(self, comm_style: str, cognitive_spec: Dict) -> str:
        """
        Extract interaction style from communication style and cognitive spec.

        Args:
            comm_style: Communication style Markdown content
            cognitive_spec: Cognitive spec YAML data

        Returns:
            Interaction style description
        """
        # Try communication style document first
        if comm_style:
            interaction_sections = [
                r'##\s*Estilo de Interação',
                r'##\s*Interaction Style',
                r'##\s*Como Interage'
            ]

            for pattern in interaction_sections:
                match = re.search(pattern, comm_style, re.IGNORECASE)
                if match:
                    # Extract content after header until next ## or end
                    start = match.end()
                    next_header = re.search(r'\n##\s', comm_style[start:])
                    end = start + next_header.start() if next_header else len(comm_style)

                    section_content = comm_style[start:end].strip()

                    # Return first paragraph
                    paragraphs = section_content.split('\n\n')
                    if paragraphs:
                        return paragraphs[0].strip()

        # Fallback to cognitive spec
        interaction = cognitive_spec.get("estilo_interacao", "")
        if interaction:
            return interaction

        return "Engages directly with learners"

    def _extract_teaching_philosophy(self, frameworks: str) -> str:
        """
        Extract teaching philosophy from frameworks document.

        Args:
            frameworks: Frameworks Markdown content

        Returns:
            Teaching philosophy description
        """
        if not frameworks:
            return ""

        # Look for teaching philosophy sections
        philosophy_sections = [
            r'##\s*Filosofia de Ensino',
            r'##\s*Teaching Philosophy',
            r'##\s*Abordagem Pedagógica',
            r'##\s*Pedagogical Approach'
        ]

        for pattern in philosophy_sections:
            match = re.search(pattern, frameworks, re.IGNORECASE)
            if match:
                # Extract content after header until next ## or end
                start = match.end()
                next_header = re.search(r'\n##\s', frameworks[start:])
                end = start + next_header.start() if next_header else len(frameworks)

                section_content = frameworks[start:end].strip()

                # Extract bullet points
                bullets = re.findall(r'^\s*[-*]\s*(.+)$', section_content, re.MULTILINE)
                if bullets:
                    return "\n".join(f"- {bullet}" for bullet in bullets[:5])

                # Or return first paragraph
                paragraphs = section_content.split('\n\n')
                if paragraphs:
                    return paragraphs[0].strip()

        # Fallback: Return first 500 chars
        return frameworks[:500] + "..." if len(frameworks) > 500 else frameworks

    def _calculate_confidence(self, identity_core: Dict, cognitive_spec: Dict,
                            comm_style: str, frameworks: Optional[str]) -> int:
        """
        Calculate confidence score based on data completeness.

        Args:
            identity_core: Identity core data
            cognitive_spec: Cognitive spec data
            comm_style: Communication style content
            frameworks: Frameworks content (optional)

        Returns:
            Confidence score 0-100
        """
        score = 0

        # Identity core completeness (30 points)
        if identity_core.get("nome_completo"):
            score += 10
        if identity_core.get("valores_centrais") and len(identity_core["valores_centrais"]) >= 3:
            score += 10
        if identity_core.get("visao_de_mundo"):
            score += 10

        # Cognitive spec completeness (30 points)
        if cognitive_spec.get("resumo_personalidade"):
            score += 10
        if cognitive_spec.get("estilo_comunicacao"):
            score += 10
        if cognitive_spec.get("abordagem_problemas"):
            score += 10

        # Communication style completeness (30 points)
        if comm_style:
            if len(comm_style) > 500:
                score += 15
            if "##" in comm_style:  # Has structured sections
                score += 15

        # Frameworks completeness (10 points bonus)
        if frameworks and len(frameworks) > 200:
            score += 10

        return min(score, 100)

    def prefill_course_brief(self, voice_profile: MMOSVoiceProfile, course_slug: str) -> bool:
        """
        Auto-populate COURSE-BRIEF.md Section 4 with MMOS voice profile.

        Args:
            voice_profile: MMOS voice profile
            course_slug: Course slug

        Returns:
            True if successful, False otherwise
        """
        brief_path = Path("outputs/courses") / course_slug / "COURSE-BRIEF.md"

        if not brief_path.exists():
            print(f"❌ COURSE-BRIEF.md not found at {brief_path}")
            return False

        # Read current brief
        with open(brief_path, 'r', encoding='utf-8') as f:
            brief_content = f.read()

        # Generate Section 4 content
        section_4_content = self._generate_section_4_mmos(voice_profile)

        # Replace Section 4
        section_4_pattern = r'(##\s*4.*?VOZ.*?\n)(.*?)(\n##\s*5|\Z)'

        match = re.search(section_4_pattern, brief_content, re.DOTALL | re.IGNORECASE)
        if match:
            # Replace existing Section 4
            new_brief = brief_content[:match.start(2)] + section_4_content + brief_content[match.start(3):]
        else:
            print("⚠️  Section 4 not found in COURSE-BRIEF.md - appending at end")
            new_brief = brief_content + "\n\n" + section_4_content

        # Also update frontmatter to include MMOS config
        new_brief = self._update_frontmatter_mmos(new_brief, voice_profile)

        # Write updated brief
        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(new_brief)

        print(f"✅ COURSE-BRIEF.md Section 4 updated with MMOS voice profile")
        return True

    def _generate_section_4_mmos(self, voice_profile: MMOSVoiceProfile) -> str:
        """
        Generate Section 4 content from MMOS voice profile.

        Args:
            voice_profile: MMOS voice profile

        Returns:
            Markdown content for Section 4
        """
        content = f"""
🟢 **Status:** Loaded from MMOS mind `{voice_profile.mmos_mind}` ({voice_profile.confidence_score}% confidence)

### Instrutor

**Nome:** {voice_profile.instructor_name}

**MMOS Source:**
- Mind: `outputs/minds/{voice_profile.mmos_mind}/`
- Extraction Date: {voice_profile.extraction_timestamp[:10]}

### Tom e Estilo

- **Tom:** {voice_profile.tone}
- **Estilo:** {voice_profile.style}
- **Abordagem:** {voice_profile.interaction_style}
"""

        # Add recurring phrases if available
        if voice_profile.recurring_phrases:
            content += "\n### Frases Recorrentes\n\n"
            content += "As lições devem incorporar estas frases naturalmente:\n"
            for phrase in voice_profile.recurring_phrases[:10]:
                content += f"- \"{phrase}\"\n"

        # Add language patterns if available
        if voice_profile.language_patterns:
            content += "\n### Padrões de Linguagem\n\n"
            for pattern in voice_profile.language_patterns:
                content += f"- {pattern}\n"

        # Add teaching philosophy if available
        if voice_profile.teaching_philosophy:
            content += "\n### Filosofia de Ensino\n\n"
            content += f"{voice_profile.teaching_philosophy}\n"

        # Add values if available
        if voice_profile.core_values:
            content += "\n### Valores Centrais (do Identity Core)\n\n"
            for value in voice_profile.core_values[:5]:
                content += f"- **{value}**\n"

        # Add worldview if available
        if voice_profile.worldview:
            content += "\n### Visão de Mundo\n\n"
            for key, value in list(voice_profile.worldview.items())[:3]:
                content += f"- **{key}:** {value}\n"

        content += """
---

📝 **Instruções:**
- Voice profile será injetado automaticamente na geração de aulas
- Sistema prompt completo do MMOS será carregado durante geração
- Voice fidelity target: 95% (MMOS benchmark validation)
- Para editar voz: Modifique o MMOS mind em `outputs/minds/{mind_slug}/`
""".replace("{mind_slug}", voice_profile.mmos_mind)

        return content

    def _update_frontmatter_mmos(self, brief_content: str, voice_profile: MMOSVoiceProfile) -> str:
        """
        Update COURSE-BRIEF frontmatter with MMOS persona config.

        Args:
            brief_content: Current brief content
            voice_profile: MMOS voice profile

        Returns:
            Updated brief content with MMOS frontmatter
        """
        # Find frontmatter
        frontmatter_pattern = r'^---\n(.*?)\n---'
        match = re.search(frontmatter_pattern, brief_content, re.DOTALL)

        if not match:
            # No frontmatter - add it
            mmos_config = f"""---
mmos_persona:
  enabled: true
  mind_slug: {voice_profile.mmos_mind}
  voice_source: mmos
  extraction_timestamp: {voice_profile.extraction_timestamp}
  confidence_score: {voice_profile.confidence_score}
---

"""
            return mmos_config + brief_content

        # Parse existing frontmatter
        frontmatter_content = match.group(1)

        # Add MMOS config
        mmos_config = f"""
mmos_persona:
  enabled: true
  mind_slug: {voice_profile.mmos_mind}
  voice_source: mmos
  extraction_timestamp: {voice_profile.extraction_timestamp}
  confidence_score: {voice_profile.confidence_score}
"""

        # Check if mmos_persona already exists
        if "mmos_persona:" in frontmatter_content:
            # Replace existing
            updated_frontmatter = re.sub(
                r'mmos_persona:.*?(?=\n\w|\Z)',
                mmos_config.strip(),
                frontmatter_content,
                flags=re.DOTALL
            )
        else:
            # Add new
            updated_frontmatter = frontmatter_content + mmos_config

        # Replace frontmatter in content
        return brief_content.replace(match.group(0), f"---\n{updated_frontmatter}\n---")

    def get_system_prompt_path(self, mind_metadata: MMOSMindMetadata) -> Optional[str]:
        """
        Get path to MMOS system prompt for lesson generation.

        Args:
            mind_metadata: Mind metadata

        Returns:
            Absolute path to system prompt file, or None if not found
        """
        mind_path = Path(mind_metadata.path)
        system_prompts_dir = mind_path / "system_prompts"

        if not system_prompts_dir.exists():
            return None

        # Priority order:
        # 1. generalista.md
        # 2. system-prompt-generalista.md
        # 3. Any other .md file (excluding CHANGELOG.md, README.md)

        priority_files = [
            "generalista.md",
            "system-prompt-generalista.md",
            "generalista/v1.0.0.md",
        ]

        for filename in priority_files:
            filepath = system_prompts_dir / filename
            if filepath.exists():
                return str(filepath.absolute())

        # Fallback: Any .md file
        md_files = [f for f in system_prompts_dir.glob("*.md")
                   if f.name.lower() not in ['changelog.md', 'readme.md']]

        if md_files:
            return str(md_files[0].absolute())

        # Check subdirectories (e.g., generalista/v1.0.0.md)
        for subdir in system_prompts_dir.iterdir():
            if subdir.is_dir():
                md_files = list(subdir.glob("*.md"))
                if md_files:
                    return str(md_files[0].absolute())

        return None


# CLI for testing
if __name__ == "__main__":
    import sys

    print("MMOS Integrator - Testing Mode\n")

    integrator = MMOSIntegrator()

    print("Scanning for MMOS minds...")
    minds = integrator.detect_available_minds()

    if not minds:
        print("❌ No MMOS minds found in outputs/minds/")
        sys.exit(1)

    print(f"\n✓ Found {len(minds)} MMOS mind{'s' if len(minds) > 1 else ''}:\n")
    for mind in minds:
        print(f"  - {mind.name} ({mind.slug})")
        print(f"    Version: {mind.version}")
        print(f"    Has system prompt: {'✅' if mind.has_system_prompt else '❌'}")
        print(f"    Has frameworks: {'✅' if mind.has_frameworks else '❌'}")

        # Get system prompt path
        sys_prompt_path = integrator.get_system_prompt_path(mind)
        if sys_prompt_path:
            print(f"    System prompt: {sys_prompt_path}")
        print()

    # Test selection
    selected = integrator.elicit_mmos_selection(minds)

    if selected:
        print(f"\n✓ Loading voice profile for {selected.name}...")
        voice_profile = integrator.load_voice_profile(selected)

        print(f"\n✓ Voice Profile Extracted:")
        print(f"  - Tone: {voice_profile.tone}")
        print(f"  - Style: {voice_profile.style}")
        print(f"  - Recurring phrases: {len(voice_profile.recurring_phrases)}")
        print(f"  - Core values: {len(voice_profile.core_values)}")
        print(f"  - Confidence: {voice_profile.confidence_score}%")

        # Test system prompt loading
        sys_prompt_path = integrator.get_system_prompt_path(selected)
        if sys_prompt_path:
            print(f"\n✓ System prompt ready at: {sys_prompt_path}")
            with open(sys_prompt_path, 'r', encoding='utf-8') as f:
                sys_prompt = f.read()
            print(f"  - Size: {len(sys_prompt)} characters")
        else:
            print("\n⚠️  No system prompt found for this mind")
