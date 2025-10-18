#!/usr/bin/env python3
"""
ICP Extractor for CreatorOS Brownfield Workflow

This module implements intelligent ICP (Ideal Customer Profile) extraction from existing
course materials. Part of Story 3.3: ICP Extraction Engine (EPIC-3: Intelligent Workflow)

Key Features:
- Multi-strategy file discovery (filename patterns + content keywords)
- Structured Markdown parsing (demographics, psychographics, pain points, goals)
- Multi-file merging with conflict detection
- YAML output with confidence scoring
- COURSE-BRIEF Section 2 auto-population
- Graceful error handling with fallback templates

Detection Strategies:
1. Filename patterns: ICP.md, avatar.md, persona.md, publico-alvo.md, etc.
2. Content keywords: "ideal customer", "target audience", "público-alvo", etc.
3. Ranking by confidence score (filename match > content match)

Data Extraction:
- Demographics (age, location, occupation, income)
- Psychographics (moment of life, mental state, values)
- Pain points / frustrations
- Goals / aspirations
- Archetypes (if mentioned)

Usage:
    from lib.icp_extractor import ICPExtractor

    extractor = ICPExtractor("dominando-obsidian")
    files = extractor.find_icp_files()
    icp_data = extractor.extract_icp()
    extractor.prefill_course_brief(icp_data)
"""

import os
import re
import yaml
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass, asdict


@dataclass
class ICPFile:
    """Metadata for an ICP candidate file."""
    path: str  # Absolute path
    relative_path: str  # Path relative to course folder
    confidence_score: int  # 0-100
    detection_method: str  # "filename_pattern" or "content_keywords"
    detected_at: str  # ISO timestamp


@dataclass
class ICPData:
    """Structured ICP data extracted from files."""
    source_file: str  # Primary source file
    extraction_timestamp: str  # ISO timestamp
    confidence_score: int  # 0-100

    demographics: Dict  # age_range, location, occupation, income
    psychographics: Dict  # moment_of_life, mental_state, values
    pain_points: List[str]
    goals: List[str]
    archetypes: List[str]

    completeness: Dict  # Boolean flags for each subsection


class ICPExtractor:
    """
    Intelligent ICP extractor for brownfield course materials.

    Discovers ICP-related files, parses structured data, and auto-fills
    COURSE-BRIEF Section 2.
    """

    # File discovery patterns (case-insensitive)
    FILENAME_PATTERNS = [
        r'.*icp.*\.md$',
        r'.*avatar.*\.md$',
        r'.*audience.*\.md$',
        r'.*persona.*\.md$',
        r'.*cliente-ideal.*\.md$',
        r'.*publico-alvo.*\.md$',
        r'.*público-alvo.*\.md$',
        r'.*target.*\.md$',
    ]

    # Content keywords for discovery
    CONTENT_KEYWORDS = [
        "ideal customer",
        "target audience",
        "buyer persona",
        "cliente ideal",
        "público-alvo",
        "publico-alvo",
        "avatar do cliente",
        "perfil do cliente",
    ]

    # Section mappings (flexible header names)
    SECTION_MAPPINGS = {
        "demographics": [
            "demografia", "demographics", "perfil demográfico",
            "demographic profile", "dados demográficos"
        ],
        "psychographics": [
            "psicografia", "psychographics", "perfil psicográfico",
            "psychographic profile", "momento de vida", "estado mental"
        ],
        "pain_points": [
            "dores", "frustrações", "frustracoes", "pain points",
            "challenges", "problemas", "dificuldades"
        ],
        "goals": [
            "objetivos", "aspirações", "aspiracoes", "goals",
            "desires", "sonhos", "desejos"
        ],
        "archetypes": [
            "arquétipo", "arquetipo", "archetype",
            "personalidade", "personality"
        ],
    }

    # Demographics subsections
    DEMOGRAPHICS_KEYS = {
        "age_range": ["idade", "age", "faixa etária", "faixa etaria"],
        "location": ["localização", "localizacao", "location", "região", "regiao"],
        "occupation": ["ocupação", "ocupacao", "occupation", "profissão", "profissao"],
        "income": ["renda", "income", "salário", "salario"],
    }

    # Psychographics subsections
    PSYCHOGRAPHICS_KEYS = {
        "moment_of_life": ["momento de vida", "moment of life", "fase", "phase"],
        "mental_state": ["estado mental", "mental state", "estado emocional", "emotional state"],
        "values": ["valores", "values", "princípios", "principios"],
    }

    def __init__(self, course_slug: str):
        """
        Initialize ICPExtractor for a specific course.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
        """
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug

        if not self.base_path.exists():
            raise FileNotFoundError(f"Course folder not found: {self.base_path}")

    def find_icp_files(self) -> List[ICPFile]:
        """
        Search for ICP-related files using multiple strategies.

        Searches in:
        - /legado/ folder (primary)
        - Course root folder (secondary)

        Returns:
            List of ICPFile objects ranked by confidence score (highest first)
        """
        print(f"🔍 Searching for ICP files in: {self.base_path}")
        candidates = []

        # Search paths (order matters: legado first, then root)
        search_paths = [
            self.base_path / "legado",
            self.base_path,
        ]

        for search_path in search_paths:
            if not search_path.exists():
                continue

            # Scan files in this path (non-recursive for root, recursive for legado)
            if search_path == self.base_path:
                # Root: only direct children
                files = [f for f in search_path.iterdir() if f.is_file()]
            else:
                # Legado: recursive scan
                files = [f for f in search_path.rglob("*") if f.is_file()]

            for file_path in files:
                # Skip non-Markdown files
                if file_path.suffix.lower() not in ['.md', '.txt']:
                    continue

                # Strategy 1: Filename pattern matching
                filename_lower = file_path.name.lower()
                filename_confidence = self._check_filename_patterns(filename_lower)

                if filename_confidence > 0:
                    relative_path = file_path.relative_to(self.base_path)
                    candidates.append(ICPFile(
                        path=str(file_path),
                        relative_path=str(relative_path),
                        confidence_score=filename_confidence,
                        detection_method="filename_pattern",
                        detected_at=datetime.utcnow().isoformat() + "Z"
                    ))
                    continue  # Skip content check if filename matched

                # Strategy 2: Content keyword matching (first 2KB)
                content_confidence = self._check_content_keywords(file_path)

                if content_confidence > 0:
                    relative_path = file_path.relative_to(self.base_path)
                    candidates.append(ICPFile(
                        path=str(file_path),
                        relative_path=str(relative_path),
                        confidence_score=content_confidence,
                        detection_method="content_keywords",
                        detected_at=datetime.utcnow().isoformat() + "Z"
                    ))

        # Sort by confidence score (highest first)
        candidates.sort(key=lambda x: x.confidence_score, reverse=True)

        print(f"✓ Found {len(candidates)} ICP candidate(s)")
        for i, candidate in enumerate(candidates[:3], 1):  # Show top 3
            print(f"  {i}. {candidate.relative_path} (confidence: {candidate.confidence_score}%)")

        return candidates

    def _check_filename_patterns(self, filename: str) -> int:
        """
        Check if filename matches ICP patterns.

        Args:
            filename: Lowercase filename

        Returns:
            Confidence score (0-100), 0 if no match
        """
        for pattern in self.FILENAME_PATTERNS:
            if re.match(pattern, filename, re.IGNORECASE):
                # Exact "ICP" match = highest confidence
                if 'icp' in filename:
                    return 95
                # Other patterns = high confidence
                return 85

        return 0

    def _check_content_keywords(self, file_path: Path) -> int:
        """
        Check if file content contains ICP keywords.

        Args:
            file_path: Path to file

        Returns:
            Confidence score (0-100), 0 if no match
        """
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read(2048).lower()  # First 2KB

                matches = sum(1 for keyword in self.CONTENT_KEYWORDS if keyword in content)

                if matches >= 3:
                    return 75  # High confidence
                elif matches >= 2:
                    return 60  # Medium confidence
                elif matches == 1:
                    return 40  # Low confidence

        except Exception as e:
            print(f"⚠️  Error reading {file_path}: {e}")

        return 0

    def extract_icp(self, icp_files: Optional[List[ICPFile]] = None) -> Optional[ICPData]:
        """
        Extract ICP data from files (auto-discovers if not provided).

        Args:
            icp_files: List of ICPFile objects (optional, will auto-discover if None)

        Returns:
            ICPData object or None if no files found
        """
        # Auto-discover if not provided
        if icp_files is None:
            icp_files = self.find_icp_files()

        if not icp_files:
            print("⚠️  No ICP files found")
            return None

        # Use highest confidence file as primary
        primary_file = icp_files[0]
        print(f"\n📄 Extracting ICP from: {primary_file.relative_path}")

        # Parse primary file
        icp_data = self._parse_icp_file(primary_file.path)

        # Merge additional files (if any)
        if len(icp_files) > 1:
            print(f"📚 Merging data from {len(icp_files) - 1} additional file(s)")
            for secondary_file in icp_files[1:]:
                secondary_data = self._parse_icp_file(secondary_file.path)
                icp_data = self._merge_icp_data(icp_data, secondary_data)

        # Calculate confidence score
        icp_data.source_file = primary_file.relative_path
        icp_data.confidence_score = self._calculate_confidence(icp_data)
        icp_data.extraction_timestamp = datetime.utcnow().isoformat() + "Z"

        print(f"✓ Extraction complete (confidence: {icp_data.confidence_score}%)")

        return icp_data

    def _parse_icp_file(self, file_path: str) -> ICPData:
        """
        Parse Markdown file to extract structured ICP data.

        Args:
            file_path: Path to ICP file

        Returns:
            ICPData object
        """
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Initialize empty data structure
        icp_data = ICPData(
            source_file="",
            extraction_timestamp="",
            confidence_score=0,
            demographics={},
            psychographics={},
            pain_points=[],
            goals=[],
            archetypes=[],
            completeness={}
        )

        # Extract demographics
        icp_data.demographics = self._extract_demographics(content)

        # Extract psychographics
        icp_data.psychographics = self._extract_psychographics(content)

        # Extract pain points
        icp_data.pain_points = self._extract_list_section(content, "pain_points")

        # Extract goals
        icp_data.goals = self._extract_list_section(content, "goals")

        # Extract archetypes (if mentioned)
        icp_data.archetypes = self._extract_list_section(content, "archetypes")

        # Calculate completeness
        icp_data.completeness = self._calculate_completeness(icp_data)

        return icp_data

    def _extract_demographics(self, content: str) -> Dict:
        """Extract demographics section from content."""
        section_content = self._find_section_content(content, "demographics")

        if not section_content:
            return {}

        demographics = {}

        # Extract each demographic key
        for key, keywords in self.DEMOGRAPHICS_KEYS.items():
            value = self._extract_key_value(section_content, keywords)
            if value:
                demographics[key] = value

        return demographics

    def _extract_psychographics(self, content: str) -> Dict:
        """Extract psychographics section from content."""
        section_content = self._find_section_content(content, "psychographics")

        if not section_content:
            return {}

        psychographics = {}

        # Extract each psychographic key
        for key, keywords in self.PSYCHOGRAPHICS_KEYS.items():
            value = self._extract_key_value(section_content, keywords)
            if value:
                psychographics[key] = value

        return psychographics

    def _extract_list_section(self, content: str, section_type: str) -> List[str]:
        """Extract list-based section (pain points, goals, archetypes)."""
        section_content = self._find_section_content(content, section_type)

        if not section_content:
            return []

        items = []

        # Extract bullet lists (- Item)
        bullet_pattern = r'^[\s]*[-•*]\s+(.+)$'
        for match in re.finditer(bullet_pattern, section_content, re.MULTILINE):
            item = match.group(1).strip()
            if item and len(item) > 5:  # Ignore very short items
                items.append(item)

        # If no bullets found, try numbered lists (1. Item)
        if not items:
            numbered_pattern = r'^[\s]*\d+\.\s+(.+)$'
            for match in re.finditer(numbered_pattern, section_content, re.MULTILINE):
                item = match.group(1).strip()
                if item and len(item) > 5:
                    items.append(item)

        return items

    def _find_section_content(self, content: str, section_type: str) -> str:
        """
        Find and extract content of a specific section.

        Args:
            content: Full Markdown content
            section_type: Section type key (e.g., "demographics")

        Returns:
            Section content as string (empty if not found)
        """
        section_names = self.SECTION_MAPPINGS.get(section_type, [])

        # Try to find section by header
        for section_name in section_names:
            # Pattern: ## Section Name or ### Section Name (flexible spaces)
            pattern = rf'^##\s+{re.escape(section_name)}'

            match = re.search(pattern, content, re.IGNORECASE | re.MULTILINE)

            if match:
                # Extract content from this header to next header of same level
                start = match.end()

                # Find next ## header (same level)
                next_header_pattern = r'^##\s+'

                next_match = re.search(next_header_pattern, content[start:], re.MULTILINE)

                if next_match:
                    end = start + next_match.start()
                    return content[start:end].strip()
                else:
                    return content[start:].strip()

        return ""

    def _extract_key_value(self, content: str, keywords: List[str]) -> str:
        """
        Extract value for a specific key from content.

        Looks for patterns:
        - **Key:** Value
        - Key: Value
        - - **Key:** Value

        Args:
            content: Section content
            keywords: List of possible key names

        Returns:
            Extracted value (empty string if not found)
        """
        for keyword in keywords:
            # Pattern: **Key:** Value or - **Key:** Value
            pattern = rf'[-•*]?\s*\*?\*?{re.escape(keyword)}\*?\*?:\s*(.+?)(?:\n|$)'

            match = re.search(pattern, content, re.IGNORECASE)

            if match:
                value = match.group(1).strip()
                # Clean up markdown formatting
                value = re.sub(r'\*\*', '', value)  # Remove bold
                value = re.sub(r'__', '', value)  # Remove bold
                value = re.sub(r'\[([^\]]+)\]\([^\)]+\)', r'\1', value)  # Remove links
                return value

        return ""

    def _merge_icp_data(self, primary: ICPData, secondary: ICPData) -> ICPData:
        """
        Merge data from secondary file into primary.

        Strategy:
        - Demographics/psychographics: Primary wins (no overwrite)
        - Pain points/goals: Merge unique items from both

        Args:
            primary: Primary ICP data
            secondary: Secondary ICP data

        Returns:
            Merged ICPData
        """
        # Merge pain points (unique only)
        for pain in secondary.pain_points:
            if pain not in primary.pain_points:
                primary.pain_points.append(pain)

        # Merge goals (unique only)
        for goal in secondary.goals:
            if goal not in primary.goals:
                primary.goals.append(goal)

        # Merge archetypes (unique only)
        for archetype in secondary.archetypes:
            if archetype not in primary.archetypes:
                primary.archetypes.append(archetype)

        # Recalculate completeness
        primary.completeness = self._calculate_completeness(primary)

        return primary

    def _calculate_completeness(self, icp_data: ICPData) -> Dict:
        """
        Calculate completeness flags for each subsection.

        Args:
            icp_data: ICPData object

        Returns:
            Dictionary with boolean flags
        """
        return {
            "demographics": len(icp_data.demographics) >= 3,  # At least 3 of 4 fields
            "psychographics": len(icp_data.psychographics) >= 2,  # At least 2 of 3 fields
            "pain_points": len(icp_data.pain_points) >= 2,  # At least 2 pain points
            "goals": len(icp_data.goals) >= 2,  # At least 2 goals
        }

    def _calculate_confidence(self, icp_data: ICPData) -> int:
        """
        Calculate overall confidence score based on completeness.

        Args:
            icp_data: ICPData object

        Returns:
            Confidence score (0-100)
        """
        completeness = icp_data.completeness

        # Count filled subsections
        filled_count = sum([
            completeness["demographics"],
            completeness["psychographics"],
            completeness["pain_points"],
            completeness["goals"],
        ])

        # Base score on completeness
        if filled_count == 4:
            return 95  # Complete
        elif filled_count == 3:
            return 75  # Mostly complete
        elif filled_count == 2:
            return 50  # Partial
        elif filled_count == 1:
            return 30  # Minimal
        else:
            return 10  # Very incomplete

    def export_to_yaml(self, icp_data: ICPData, output_path: Optional[str] = None) -> str:
        """
        Export ICPData to YAML format.

        Args:
            icp_data: ICPData object
            output_path: Optional path to save YAML (default: course_folder/icp-extracted.yaml)

        Returns:
            Path to saved YAML file
        """
        if output_path is None:
            output_path = str(self.base_path / "icp-extracted.yaml")

        # Convert to dict
        data_dict = {
            "icp_extracted": {
                "source_file": icp_data.source_file,
                "extraction_timestamp": icp_data.extraction_timestamp,
                "confidence_score": icp_data.confidence_score,
                "demographics": icp_data.demographics,
                "psychographics": icp_data.psychographics,
                "pain_points": icp_data.pain_points,
                "goals": icp_data.goals,
                "archetypes": icp_data.archetypes,
                "completeness": icp_data.completeness,
            }
        }

        # Write YAML
        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data_dict, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

        print(f"💾 Exported ICP data to: {output_path}")

        return output_path

    def prefill_course_brief(self, icp_data: Optional[ICPData]) -> bool:
        """
        Pre-fill COURSE-BRIEF.md Section 2 with extracted ICP data.

        Args:
            icp_data: ICPData object (None if no ICP files found)

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

        # Find Section 2 (ICP)
        section_2_pattern = r'(## 2️⃣ PÚBLICO-ALVO & ICP.*?)(?=## \d️⃣|\Z)'

        match = re.search(section_2_pattern, content, re.DOTALL)

        if not match:
            print("⚠️  Section 2 (ICP) not found in COURSE-BRIEF.md")
            return False

        # Generate replacement content
        if icp_data is None:
            # No ICP files found - insert empty template with red status
            replacement = self._generate_empty_icp_section()
        else:
            # ICP data found - insert extracted data
            replacement = self._generate_filled_icp_section(icp_data)

        # Replace Section 2
        new_content = content[:match.start()] + replacement + content[match.end():]

        # Write updated brief
        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(new_content)

        print(f"✓ Updated COURSE-BRIEF.md Section 2")

        return True

    def _generate_empty_icp_section(self) -> str:
        """Generate empty ICP section template (red status)."""
        return """## 2️⃣ PÚBLICO-ALVO & ICP (IDEAL CUSTOMER PROFILE)

🔴 **Status:** No ICP files found. Please fill manually.

### 2.1. Quem é o aluno ideal?

**Demografia básica:**
```
Idade principal: _____ - _____ anos
Localização: [ ] Brasil [ ] LATAM [ ] Global [ ] Específico: _____
Gênero: [ ] Todos [ ] Específico: _____
Nível educacional: [ ] Ensino médio [ ] Superior [ ] Pós-graduação [ ] Qualquer
```

**Perfil profissional:**
```
Ocupação atual (marque todos que se aplicam):
[ ] Empreendedor digital
[ ] Executivo corporativo
[ ] Freelancer/Consultor
[ ] Profissional técnico (dev, designer, etc.)
[ ] Estudante
[ ] Profissional liberal (médico, advogado, etc.)
[ ] Criador de conteúdo
[ ] Outro: __________________

Tempo de experiência na área:
[ ] Iniciante (0-2 anos)
[ ] Intermediário (2-5 anos)
[ ] Avançado (5-10 anos)
[ ] Veterano (10+ anos)
```

**Contexto psicográfico (crucial!):**
```
Momento atual do avatar:
[Descreva em 2-3 frases o MOMENTO DE VIDA que o avatar está vivendo]



Estado mental/emocional predominante:
[Como o avatar se SENTE hoje? Frustrado? Animado? Perdido? Impaciente?]



O que mais valoriza (top 3):
1. [ ] Autonomia [ ] Segurança [ ] Status [ ] Impacto [ ] Velocidade [ ] Profundidade
2. [ ] Autonomia [ ] Segurança [ ] Status [ ] Impacto [ ] Velocidade [ ] Profundidade
3. [ ] Autonomia [ ] Segurança [ ] Status [ ] Impacto [ ] Velocidade [ ] Profundidade
```

---

### 2.2. Dores & Problemas (CRITICAL!)

**Top 5 dores/frustrações específicas:**
```
1.


2.


3.


4.


5.

```

---

### 2.3. Desejo & Transformação

**O que o avatar DESEJA alcançar com este curso?**
```
Objetivo declarado (o que ele vai falar):


Objetivo real (o que ele verdadeiramente busca):

```

"""

    def _generate_filled_icp_section(self, icp_data: ICPData) -> str:
        """Generate filled ICP section from extracted data."""

        # Determine status indicator
        filled_count = sum(icp_data.completeness.values())
        if filled_count == 4:
            status = "🟢"
            status_text = f"Extracted from `{icp_data.source_file}` ({icp_data.confidence_score}% confidence)"
        elif filled_count >= 2:
            status = "🟡"
            status_text = f"Partial extraction from `{icp_data.source_file}` ({icp_data.confidence_score}% confidence)"
        else:
            status = "🔴"
            status_text = f"Incomplete extraction from `{icp_data.source_file}` ({icp_data.confidence_score}% confidence)"

        # Build demographics section
        demographics_md = ""
        if icp_data.demographics:
            if "age_range" in icp_data.demographics:
                demographics_md += f"- **Idade:** {icp_data.demographics['age_range']}\n"
            if "location" in icp_data.demographics:
                demographics_md += f"- **Localização:** {icp_data.demographics['location']}\n"
            if "occupation" in icp_data.demographics:
                occ = icp_data.demographics['occupation']
                if isinstance(occ, list):
                    demographics_md += f"- **Ocupação:** {', '.join(occ)}\n"
                else:
                    demographics_md += f"- **Ocupação:** {occ}\n"
            if "income" in icp_data.demographics:
                demographics_md += f"- **Renda:** {icp_data.demographics['income']}\n"

        if not demographics_md:
            demographics_md = "_[Dados demográficos não encontrados - preencha manualmente]_\n"

        # Build psychographics section
        psychographics_md = ""
        if icp_data.psychographics:
            if "moment_of_life" in icp_data.psychographics:
                psychographics_md += f"- **Momento de Vida:** {icp_data.psychographics['moment_of_life']}\n"
            if "mental_state" in icp_data.psychographics:
                psychographics_md += f"- **Estado Mental:** {icp_data.psychographics['mental_state']}\n"
            if "values" in icp_data.psychographics:
                vals = icp_data.psychographics['values']
                if isinstance(vals, list):
                    psychographics_md += f"- **Valores:** {', '.join(vals)}\n"
                else:
                    psychographics_md += f"- **Valores:** {vals}\n"

        if not psychographics_md:
            psychographics_md = "_[Dados psicográficos não encontrados - preencha manualmente]_\n"

        # Build pain points section
        pain_points_md = ""
        if icp_data.pain_points:
            for pain in icp_data.pain_points:
                pain_points_md += f"- {pain}\n"
        else:
            pain_points_md = "_[Dores não encontradas - preencha manualmente]_\n"

        # Build goals section
        goals_md = ""
        if icp_data.goals:
            for goal in icp_data.goals:
                goals_md += f"- {goal}\n"
        else:
            goals_md = "_[Objetivos não encontrados - preencha manualmente]_\n"

        # Completeness report
        completeness_md = "**Extracted:**\n"
        completeness_md += f"- Demographics {'✅' if icp_data.completeness['demographics'] else '❌'}\n"
        completeness_md += f"- Psychographics {'✅' if icp_data.completeness['psychographics'] else '❌'}\n"
        completeness_md += f"- Pain Points {'✅' if icp_data.completeness['pain_points'] else '❌'}\n"
        completeness_md += f"- Goals {'✅' if icp_data.completeness['goals'] else '❌'}\n"

        # Build full section
        return f"""## 2️⃣ PÚBLICO-ALVO & ICP (IDEAL CUSTOMER PROFILE)

{status} **Status:** {status_text}

{completeness_md}

---

### 2.1. Quem é o aluno ideal?

**Demografia básica:**

{demographics_md}

**Contexto psicográfico:**

{psychographics_md}

---

### 2.2. Dores & Problemas (CRITICAL!)

**Dores/frustrações específicas:**

{pain_points_md}

---

### 2.3. Desejo & Transformação

**O que o avatar DESEJA alcançar com este curso?**

**Objetivos:**

{goals_md}

---

📝 **Instruções:** Review extracted data for accuracy. Edit if needed, then change status to ✅.

"""


def main():
    """CLI interface for testing ICP extractor."""
    import sys

    if len(sys.argv) < 2 or "--help" in sys.argv or "-h" in sys.argv:
        print("Usage: python icp_extractor.py <course-slug> [--export-yaml]")
        print("")
        print("Arguments:")
        print("  course-slug     Course identifier (e.g., 'dominando-obsidian')")
        print("  --export-yaml   Export extracted data to YAML file")
        print("")
        print("Example:")
        print("  python icp_extractor.py dominando-obsidian")
        print("  python icp_extractor.py dominando-obsidian --export-yaml")
        sys.exit(0 if "--help" in sys.argv or "-h" in sys.argv else 1)

    course_slug = sys.argv[1]
    export_yaml = "--export-yaml" in sys.argv

    try:
        extractor = ICPExtractor(course_slug)

        # Find ICP files
        print("=" * 60)
        icp_files = extractor.find_icp_files()
        print("=" * 60)

        # Extract ICP data
        if icp_files:
            print("\n" + "=" * 60)
            icp_data = extractor.extract_icp(icp_files)
            print("=" * 60)

            # Preview extracted data
            print("\n📊 Extracted ICP Data:")
            print(f"\nDemographics:")
            for key, value in icp_data.demographics.items():
                print(f"  - {key}: {value}")

            print(f"\nPsychographics:")
            for key, value in icp_data.psychographics.items():
                print(f"  - {key}: {value}")

            print(f"\nPain Points ({len(icp_data.pain_points)}):")
            for i, pain in enumerate(icp_data.pain_points[:3], 1):
                print(f"  {i}. {pain}")
            if len(icp_data.pain_points) > 3:
                print(f"  ... and {len(icp_data.pain_points) - 3} more")

            print(f"\nGoals ({len(icp_data.goals)}):")
            for i, goal in enumerate(icp_data.goals[:3], 1):
                print(f"  {i}. {goal}")
            if len(icp_data.goals) > 3:
                print(f"  ... and {len(icp_data.goals) - 3} more")

            # Export to YAML if requested
            if export_yaml:
                print("\n" + "=" * 60)
                yaml_path = extractor.export_to_yaml(icp_data)
                print("=" * 60)

            # Prefill COURSE-BRIEF
            print("\n" + "=" * 60)
            extractor.prefill_course_brief(icp_data)
            print("=" * 60)

            print("\n✅ ICP extraction completed successfully!")
        else:
            print("\n⚠️  No ICP files found. Generating empty template...")
            print("=" * 60)
            extractor.prefill_course_brief(None)
            print("=" * 60)

    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
