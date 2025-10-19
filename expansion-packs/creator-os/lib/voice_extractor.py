#!/usr/bin/env python3
"""
Voice Extractor for CreatorOS Brownfield Workflow

This module implements intelligent voice pattern extraction from video/audio transcripts.
Part of Story 3.4: Voice & Persona Extraction (EPIC-3: Intelligent Workflow)

Key Features:
- Multi-format transcript discovery (.txt, .md, .srt, .vtt)
- Smart sampling strategy (3-5 representative transcripts)
- AI-powered voice pattern analysis (greeting, tone, phrases, teaching approach)
- Multi-transcript aggregation with consistency scoring
- COURSE-BRIEF Section 4 auto-population
- Caching mechanism to avoid re-analysis
- Graceful error handling with fallback templates

Detection Strategies:
1. Filename patterns: transcript*.txt, aula*.txt, lesson*.txt, etc.
2. Content validation: Must contain conversational markers (not just any .txt file)
3. Format support: Plain text, Markdown, SRT, VTT

Voice Analysis:
- Signature greeting (first 3 sentences)
- Tone & style (formal/casual, warm/authoritative, etc.)
- Recurring phrases (top 10 most frequent)
- Teaching approach (theory-first vs practice-first, uses analogies, etc.)
- Interaction patterns (direct address, inclusive language, checks understanding)
- Personality traits (builds confidence, addresses objections, uses humor, etc.)

Usage:
    from lib.voice_extractor import VoiceExtractor

    extractor = VoiceExtractor("dominando-obsidian", ai_client)
    transcripts = extractor.find_transcripts()
    voice_profile = extractor.analyze_voice()
    extractor.prefill_course_brief(voice_profile)
"""

import os
import re
import yaml
import random
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass, asdict
from collections import defaultdict


@dataclass
class TranscriptFile:
    """Metadata for a transcript file."""
    path: str  # Absolute path
    relative_path: str  # Path relative to course folder
    file_format: str  # "txt", "md", "srt", "vtt"
    file_size: int  # Size in bytes
    confidence_score: int  # 0-100 (content validation)
    detected_at: str  # ISO timestamp


@dataclass
class VoiceAnalysis:
    """Voice pattern analysis from a single transcript."""
    transcript_path: str
    signature_greeting: str
    tone: str
    style: str
    recurring_phrases: List[Dict]  # [{"phrase": str, "count": int, "context": str}]
    teaching_approach: Dict
    interaction_patterns: Dict
    personality_traits: List[Dict]  # [{"trait": str, "evidence": str}]
    analysis_timestamp: str


@dataclass
class VoiceProfile:
    """Aggregated voice profile from multiple transcripts."""
    source: str  # "transcripts"
    transcripts_analyzed: int
    analysis_timestamp: str
    confidence_score: int  # 0-100 (based on consistency)

    instructor_name: Optional[str]
    signature_greeting: str
    tone: str
    style: str
    recurring_phrases: List[Dict]  # Top 10 aggregated
    teaching_approach: Dict
    interaction_patterns: Dict
    personality_traits: List[Dict]


class VoiceExtractor:
    """
    Intelligent voice pattern extractor for brownfield course materials.

    Discovers transcript files, analyzes voice patterns with AI, and auto-fills
    COURSE-BRIEF Section 4 (Voice & Personality).
    """

    # Filename patterns (case-insensitive)
    FILENAME_PATTERNS = [
        r'.*transcript.*\.(txt|md)$',
        r'.*transcrição.*\.(txt|md)$',
        r'.*transcricao.*\.(txt|md)$',
        r'.*aula.*\.(txt|md)$',
        r'.*lesson.*\.(txt|md)$',
        r'.*lecture.*\.(txt|md)$',
        r'.*video.*\.(txt|md)$',
        r'.*audio.*\.(txt|md)$',
    ]

    # Conversational markers (Portuguese and English)
    CONVERSATIONAL_MARKERS_PT = [
        "olá", "oi", "fala", "bom dia", "boa tarde", "boa noite",
        "tudo bem", "vamos lá", "então", "né", "tá", "beleza",
        "entendeu", "percebe", "viu", "certo", "ok"
    ]

    CONVERSATIONAL_MARKERS_EN = [
        "hello", "hi", "hey", "welcome", "let's", "okay", "ok",
        "right", "you know", "got it", "understand", "see", "alright"
    ]

    def __init__(self, course_slug: str, ai_client=None):
        """
        Initialize VoiceExtractor for a specific course.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
            ai_client: OpenAI client for AI analysis (optional, will initialize if None)
        """
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug
        self.cache_path = self.base_path / "sources" / ".voice-analysis-cache.yaml"

        if not self.base_path.exists():
            raise FileNotFoundError(f"Course folder not found: {self.base_path}")

        # Initialize AI client if not provided
        if ai_client is None:
            try:
                from openai import OpenAI
                self.ai_client = OpenAI()  # Uses OPENAI_API_KEY env var
            except ImportError:
                print("⚠️  OpenAI library not installed. Install with: pip install openai")
                self.ai_client = None
        else:
            self.ai_client = ai_client

    def find_transcripts(self) -> List[TranscriptFile]:
        """
        Search for transcript files using multiple strategies.

        Searches in (priority order):
        1. /sources/transcripts/ (primary)
        2. /sources/ (secondary)
        3. /transcripts/ (fallback)
        4. Course root (last resort)

        Returns:
            List of TranscriptFile objects sorted by confidence score
        """
        print(f"🔍 Searching for transcript files in: {self.base_path}")
        candidates = []

        # Search paths (priority order)
        search_paths = [
            self.base_path / "sources" / "transcripts",
            self.base_path / "sources",
            self.base_path / "transcripts",
            self.base_path,
        ]

        for search_path in search_paths:
            if not search_path.exists():
                continue

            # Scan files recursively
            files = [f for f in search_path.rglob("*") if f.is_file()]

            for file_path in files:
                # Check filename patterns
                filename_lower = file_path.name.lower()
                if not self._matches_filename_pattern(filename_lower):
                    continue

                # Validate content (not just any .txt file)
                confidence = self._validate_transcript_content(file_path)
                if confidence == 0:
                    continue  # Not a conversational transcript

                # Determine format
                file_format = self._detect_format(file_path)

                # Add to candidates
                relative_path = file_path.relative_to(self.base_path)
                candidates.append(TranscriptFile(
                    path=str(file_path),
                    relative_path=str(relative_path),
                    file_format=file_format,
                    file_size=file_path.stat().st_size,
                    confidence_score=confidence,
                    detected_at=datetime.utcnow().isoformat() + "Z"
                ))

        # Sort by confidence score (highest first)
        candidates.sort(key=lambda x: x.confidence_score, reverse=True)

        print(f"✓ Found {len(candidates)} transcript file(s)")
        for i, candidate in enumerate(candidates[:5], 1):  # Show top 5
            print(f"  {i}. {candidate.relative_path} ({candidate.file_format}, confidence: {candidate.confidence_score}%)")

        return candidates

    def _matches_filename_pattern(self, filename: str) -> bool:
        """Check if filename matches transcript patterns."""
        for pattern in self.FILENAME_PATTERNS:
            if re.match(pattern, filename, re.IGNORECASE):
                return True
        return False

    def _validate_transcript_content(self, file_path: Path) -> int:
        """
        Validate that file content is actually a transcript (not just any .txt).

        Returns:
            Confidence score (0-100), 0 if not a transcript
        """
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read(2048).lower()  # First 2KB

            # Check for conversational markers
            pt_matches = sum(1 for marker in self.CONVERSATIONAL_MARKERS_PT if marker in content)
            en_matches = sum(1 for marker in self.CONVERSATIONAL_MARKERS_EN if marker in content)

            total_matches = pt_matches + en_matches

            if total_matches >= 5:
                return 95  # Very high confidence
            elif total_matches >= 3:
                return 75  # High confidence
            elif total_matches >= 2:
                return 50  # Medium confidence
            elif total_matches == 1:
                return 30  # Low confidence
            else:
                return 0  # Not a transcript

        except Exception as e:
            print(f"⚠️  Error reading {file_path}: {e}")
            return 0

    def _detect_format(self, file_path: Path) -> str:
        """Detect transcript format (txt, md, srt, vtt)."""
        suffix = file_path.suffix.lower()

        if suffix in ['.srt']:
            return 'srt'
        elif suffix in ['.vtt']:
            return 'vtt'
        elif suffix in ['.md', '.markdown']:
            return 'md'
        else:
            return 'txt'

    def sample_transcripts(self, transcript_files: List[TranscriptFile]) -> List[TranscriptFile]:
        """
        Select representative sample to balance accuracy vs. cost.

        Sampling strategy:
        - ≤5 files: Analyze all
        - 6-20 files: First, middle, last + 2 random (5 total)
        - >20 files: First, last + 3 from middle third (5 total)

        Args:
            transcript_files: List of all transcript files

        Returns:
            List of 0-5 sampled transcripts
        """
        total_count = len(transcript_files)

        if total_count == 0:
            print("⚠️  No transcripts to sample")
            return []

        if total_count <= 5:
            # Small course: Analyze all
            print(f"📊 Small course ({total_count} transcripts): Analyzing all")
            return transcript_files

        elif 6 <= total_count <= 20:
            # Medium course: First, middle, last + 2 random
            first = transcript_files[0]
            last = transcript_files[-1]
            middle = transcript_files[total_count // 2]

            # 2 random from remaining
            remaining = [f for f in transcript_files if f not in [first, middle, last]]
            random.seed(hash(self.course_slug))  # Deterministic sampling
            random_samples = random.sample(remaining, min(2, len(remaining)))

            sampled = [first, middle, last] + random_samples
            print(f"📊 Medium course ({total_count} transcripts): Sampled 5 (first, middle, last, 2 random)")
            return sampled

        else:  # total_count > 20
            # Large course: First, last + 3 from middle third
            first = transcript_files[0]
            last = transcript_files[-1]

            # Middle third (avoid intro/outro biases)
            middle_third_start = total_count // 3
            middle_third_end = 2 * total_count // 3
            middle_third = transcript_files[middle_third_start:middle_third_end]

            random.seed(hash(self.course_slug))  # Deterministic sampling
            random_samples = random.sample(middle_third, min(3, len(middle_third)))

            sampled = [first, last] + random_samples
            print(f"📊 Large course ({total_count} transcripts): Sampled 5 (first, last, 3 from middle third)")
            return sampled

    def analyze_transcript(self, transcript_file: TranscriptFile) -> Optional[VoiceAnalysis]:
        """
        Use AI to extract voice patterns from a single transcript.

        QA Fix: Added fallback to rule-based extraction if AI fails

        Args:
            transcript_file: TranscriptFile object

        Returns:
            VoiceAnalysis object (AI-powered or fallback)
        """
        # Read transcript content
        content = self._read_transcript_content(transcript_file)

        if not content or len(content) < 100:
            print(f"⚠️  Transcript too short (<100 chars): {transcript_file.relative_path}")
            return None

        # Try AI analysis first (if client available)
        if self.ai_client is not None:
            print(f"🤖 Analyzing voice patterns (AI): {transcript_file.relative_path}")

            # Build AI prompt
            prompt = self._build_voice_analysis_prompt(content)

            # Call AI (with retry logic)
            try:
                response = self._call_ai_with_retry(prompt)

                # Parse YAML response
                voice_analysis = self._parse_voice_analysis_response(response, transcript_file.path)

                print(f"✅ AI analysis successful")
                return voice_analysis

            except Exception as e:
                print(f"⚠️  AI analysis failed for {transcript_file.relative_path}: {e}")
                print(f"⚠️  Falling back to rule-based extraction...")
                # Fall through to rule-based fallback

        else:
            print(f"⚠️  AI client not initialized, using rule-based extraction")

        # Fallback: Rule-based voice extraction
        return self._extract_voice_rules_based(content, transcript_file.path)

    def _read_transcript_content(self, transcript_file: TranscriptFile) -> str:
        """
        Read transcript content and extract text based on format.

        Handles:
        - Plain text (.txt, .md)
        - SRT format (ignores timestamps)
        - VTT format (ignores timestamps)
        """
        try:
            with open(transcript_file.path, 'r', encoding='utf-8', errors='ignore') as f:
                raw_content = f.read()

            # Format-specific parsing
            if transcript_file.file_format == 'srt':
                return self._parse_srt_content(raw_content)
            elif transcript_file.file_format == 'vtt':
                return self._parse_vtt_content(raw_content)
            else:
                return raw_content  # Plain text or Markdown

        except Exception as e:
            print(f"⚠️  Error reading transcript {transcript_file.path}: {e}")
            return ""

    def _parse_srt_content(self, raw_content: str) -> str:
        """Extract text from SRT format (ignore timestamps)."""
        lines = raw_content.split('\n')
        text_lines = []

        for line in lines:
            line = line.strip()
            # Skip sequence numbers and timestamps
            if line.isdigit() or '-->' in line or not line:
                continue
            text_lines.append(line)

        return ' '.join(text_lines)

    def _parse_vtt_content(self, raw_content: str) -> str:
        """Extract text from VTT format (ignore timestamps)."""
        lines = raw_content.split('\n')
        text_lines = []

        for line in lines:
            line = line.strip()
            # Skip WEBVTT header, timestamps, and metadata
            if line.startswith('WEBVTT') or '-->' in line or not line or line.startswith('NOTE'):
                continue
            text_lines.append(line)

        return ' '.join(text_lines)

    def _build_voice_analysis_prompt(self, transcript_content: str) -> str:
        """Build AI prompt for voice pattern analysis."""
        # Truncate if too long (keep first 8000 chars for speed/cost)
        if len(transcript_content) > 8000:
            transcript_content = transcript_content[:8000] + "\n\n[... transcript truncated for analysis ...]"

        return f"""You are analyzing instructor voice patterns from a lesson transcript.

**Task:** Extract teaching voice profile from the following transcript.

**Transcript:**
{transcript_content}

**Extract:**

1. **Signature Greeting** (First 3 sentences of transcript)
   - Exact quote, not paraphrased
   - Maximum 150 characters

2. **Tone & Style**
   - Formal or Casual?
   - Warm/Friendly or Professional/Authoritative?
   - Peer-to-peer or Expert-to-learner?
   - Provide 1-2 sentence description

3. **Recurring Phrases** (Top 10 most frequent)
   - Exact phrases that appear 3+ times
   - Include frequency count and brief context
   - Format: [{{"phrase": "...", "count": N, "context": "..."}}]

4. **Teaching Approach**
   - Theory-first or Practice-first?
   - Uses analogies/metaphors? (yes/no + example if yes)
   - Anticipates student concerns? (yes/no + example if yes)
   - Asks rhetorical questions? (yes/no + example if yes)
   - Explains WHY before HOW? (yes/no)

5. **Interaction Patterns**
   - Addresses audience directly? (yes/no + pronouns used)
   - Uses inclusive language? (yes/no + examples like "vamos", "let's")
   - Checks understanding? (yes/no + phrases like "entendeu?", "makes sense?")
   - Encourages action? (yes/no + examples)

6. **Personality Markers**
   - Humor (yes/no + example if yes)
   - Empathy (acknowledges struggles? yes/no + example)
   - Authority (confident assertions? yes/no + example)
   - Humility (admits mistakes/uncertainty? yes/no + example)

**Format:** Return ONLY valid YAML in the following structure (no markdown code blocks):

signature_greeting: "..."
tone: "..."
style: "..."
recurring_phrases:
  - phrase: "..."
    count: N
    context: "..."
teaching_approach:
  theory_vs_practice: "..."
  uses_analogies: yes/no
  analogies_example: "..."
  anticipates_concerns: yes/no
  concerns_example: "..."
  asks_rhetorical_questions: yes/no
  rhetorical_example: "..."
  explains_why_before_how: yes/no
interaction_patterns:
  direct_address: yes/no
  pronouns_used: "..."
  inclusive_language: yes/no
  inclusive_examples: "..."
  checks_understanding: yes/no
  understanding_phrases: "..."
  encourages_action: yes/no
  action_examples: "..."
personality_traits:
  - trait: "..."
    evidence: "..."
"""

    def _call_ai_with_retry(self, prompt: str, max_retries: int = 3) -> str:
        """
        Call OpenAI API with retry logic.

        Args:
            prompt: Analysis prompt
            max_retries: Maximum retry attempts

        Returns:
            AI response text
        """
        for attempt in range(1, max_retries + 1):
            try:
                response = self.ai_client.chat.completions.create(
                    model="gpt-4o-mini",  # Fast, cheap, good for pattern extraction
                    temperature=0.3,  # Low variance (consistent extractions)
                    messages=[
                        {"role": "system", "content": "You are an expert at analyzing teaching voice patterns from transcripts. Return responses in valid YAML format only."},
                        {"role": "user", "content": prompt}
                    ]
                )

                return response.choices[0].message.content

            except Exception as e:
                print(f"⚠️  API call failed (attempt {attempt}/{max_retries}): {e}")

                if attempt < max_retries:
                    import time
                    wait_time = 5 * attempt  # Exponential backoff
                    print(f"⏳ Retrying in {wait_time} seconds...")
                    time.sleep(wait_time)
                else:
                    raise  # Re-raise on final attempt

    def _parse_voice_analysis_response(self, response: str, transcript_path: str) -> VoiceAnalysis:
        """
        Parse AI response YAML into VoiceAnalysis object.

        Args:
            response: AI response text (YAML)
            transcript_path: Path to analyzed transcript

        Returns:
            VoiceAnalysis object
        """
        # Clean response (remove markdown code blocks if present)
        response = response.strip()
        if response.startswith('```yaml'):
            response = response[7:]
        if response.startswith('```'):
            response = response[3:]
        if response.endswith('```'):
            response = response[:-3]
        response = response.strip()

        # Parse YAML
        try:
            data = yaml.safe_load(response)
        except yaml.YAMLError as e:
            print(f"⚠️  YAML parsing error: {e}")
            print(f"Response was: {response[:200]}...")
            # Return minimal structure
            data = {}

        # Extract fields with fallbacks
        return VoiceAnalysis(
            transcript_path=transcript_path,
            signature_greeting=data.get('signature_greeting', ''),
            tone=data.get('tone', ''),
            style=data.get('style', ''),
            recurring_phrases=data.get('recurring_phrases', []),
            teaching_approach=data.get('teaching_approach', {}),
            interaction_patterns=data.get('interaction_patterns', {}),
            personality_traits=data.get('personality_traits', []),
            analysis_timestamp=datetime.utcnow().isoformat() + "Z"
        )

    def _extract_voice_rules_based(self, content: str, transcript_path: str) -> VoiceAnalysis:
        """
        Fallback: Extract voice patterns using rule-based methods (no AI).

        QA Fix: Provides fallback when AI fails or is unavailable.

        Extraction Strategy:
        - Greeting: First 3 sentences
        - Tone: Detect from linguistic markers
        - Recurring phrases: Frequency analysis
        - Teaching approach: Pattern matching

        Args:
            content: Transcript text
            transcript_path: Path to transcript

        Returns:
            VoiceAnalysis with rule-based extraction
        """
        print(f"📝 Using rule-based voice extraction (no AI)")

        # Extract signature greeting (first 3 sentences)
        sentences = re.split(r'[.!?]+', content[:500])
        greeting_sentences = [s.strip() for s in sentences if s.strip()][:3]
        signature_greeting = '. '.join(greeting_sentences) + '.' if greeting_sentences else ''

        # Detect tone from markers
        tone = self._detect_tone_rules_based(content)

        # Detect style
        style = self._detect_style_rules_based(content)

        # Extract recurring phrases (simple frequency analysis)
        recurring_phrases = self._extract_frequent_phrases(content)

        # Detect teaching approach patterns
        teaching_approach = self._detect_teaching_approach(content)

        # Detect interaction patterns
        interaction_patterns = self._detect_interaction_patterns(content)

        # Detect personality traits
        personality_traits = self._detect_personality_traits(content)

        return VoiceAnalysis(
            transcript_path=transcript_path,
            signature_greeting=signature_greeting,
            tone=tone,
            style=style,
            recurring_phrases=recurring_phrases[:10],  # Top 10
            teaching_approach=teaching_approach,
            interaction_patterns=interaction_patterns,
            personality_traits=personality_traits,
            analysis_timestamp=datetime.utcnow().isoformat() + "Z"
        )

    def _detect_tone_rules_based(self, content: str) -> str:
        """Detect tone using linguistic markers."""
        content_lower = content.lower()

        # Markers for different tones
        formal_markers = ['deve-se', 'é necessário', 'conforme', 'portanto', 'todavia']
        casual_markers = ['né', 'tá', 'vamos lá', 'beleza', 'tipo assim', 'sabe']
        warm_markers = ['querido', 'amigo', 'pessoal', 'galera', 'meu amigo']
        authoritative_markers = ['precisa', 'deve', 'tem que', 'sempre', 'nunca']

        formal_count = sum(1 for m in formal_markers if m in content_lower)
        casual_count = sum(1 for m in casual_markers if m in content_lower)
        warm_count = sum(1 for m in warm_markers if m in content_lower)
        auth_count = sum(1 for m in authoritative_markers if m in content_lower)

        scores = {
            'Formal e profissional': formal_count,
            'Casual e próximo': casual_count,
            'Caloroso e acolhedor': warm_count,
            'Autoritário e firme': auth_count
        }

        # Return tone with highest score (or default)
        max_tone = max(scores, key=scores.get)
        return max_tone if scores[max_tone] > 0 else 'Profissional e equilibrado'

    def _detect_style_rules_based(self, content: str) -> str:
        """Detect teaching style."""
        content_lower = content.lower()

        # Style markers
        structured = sum(1 for marker in ['primeiro', 'segundo', 'terceiro', 'passo', 'etapa'] if marker in content_lower)
        practical = sum(1 for marker in ['exemplo', 'na prática', 'vamos fazer', 'experimente'] if marker in content_lower)
        theoretical = sum(1 for marker in ['teoria', 'conceito', 'princípio', 'fundamento'] if marker in content_lower)

        if practical > structured and practical > theoretical:
            return 'Prático, orientado a exemplos'
        elif structured > theoretical:
            return 'Estruturado, passo-a-passo'
        elif theoretical > 0:
            return 'Teórico primeiro, depois prático'
        else:
            return 'Equilibrado'

    def _extract_frequent_phrases(self, content: str) -> List[Dict]:
        """Extract frequently recurring phrases (3-5 words)."""
        # Simple n-gram frequency analysis
        words = re.findall(r'\b\w+\b', content.lower())

        # Extract 3-grams
        three_grams = defaultdict(int)
        for i in range(len(words) - 2):
            phrase = ' '.join(words[i:i+3])
            if len(phrase) > 10:  # Filter out very short phrases
                three_grams[phrase] += 1

        # Return top phrases with count > 2
        top_phrases = sorted(three_grams.items(), key=lambda x: x[1], reverse=True)
        top_phrases = [(phrase, count) for phrase, count in top_phrases if count > 2][:10]

        return [
            {"phrase": phrase, "count": count, "context": "recurring"}
            for phrase, count in top_phrases
        ]

    def _detect_teaching_approach(self, content: str) -> Dict:
        """Detect teaching approach patterns."""
        content_lower = content.lower()

        return {
            "uses_analogies": any(marker in content_lower for marker in ['é como', 'imagine que', 'assim como', 'pense em']),
            "theory_first": 'primeiro vamos entender' in content_lower or 'antes de' in content_lower,
            "practice_first": 'vamos fazer' in content_lower or 'mão na massa' in content_lower,
            "incremental": any(marker in content_lower for marker in ['passo a passo', 'aos poucos', 'gradualmente'])
        }

    def _detect_interaction_patterns(self, content: str) -> Dict:
        """Detect interaction patterns."""
        content_lower = content.lower()

        return {
            "direct_address": any(marker in content_lower for marker in ['você vai', 'você pode', 'vamos juntos']),
            "inclusive_language": any(marker in content_lower for marker in ['vamos', 'nós', 'juntos', 'nossa']),
            "checks_understanding": any(marker in content_lower for marker in ['entendeu', 'ficou claro', 'faz sentido', 'conseguiu acompanhar'])
        }

    def _detect_personality_traits(self, content: str) -> List[Dict]:
        """Detect personality traits."""
        content_lower = content.lower()

        traits = []

        if any(marker in content_lower for marker in ['você consegue', 'você vai conseguir', 'é fácil']):
            traits.append({"trait": "Builds confidence", "evidence": "Uses encouraging language"})

        if any(marker in content_lower for marker in ['pode parecer', 'eu sei que', 'talvez você']):
            traits.append({"trait": "Addresses objections", "evidence": "Anticipates concerns"})

        if any(marker in content_lower for marker in ['haha', 'rs', 'brincadeira']):
            traits.append({"trait": "Uses humor", "evidence": "Includes jokes or informal humor"})

        if not traits:
            traits.append({"trait": "Professional", "evidence": "Maintains professional tone"})

        return traits

    def aggregate_voice_profiles(self, individual_analyses: List[VoiceAnalysis]) -> VoiceProfile:
        """
        Merge insights from multiple transcript analyses.

        Strategy:
        - Signature greeting: Most common (majority vote)
        - Tone/style: Majority vote
        - Recurring phrases: Merge and rank by total count
        - Teaching approach: Merge patterns
        - Personality traits: Merge unique traits

        Args:
            individual_analyses: List of VoiceAnalysis objects

        Returns:
            VoiceProfile object
        """
        print(f"\n📊 Aggregating voice profiles from {len(individual_analyses)} transcript(s)")

        if not individual_analyses:
            # Return minimal profile
            return self._create_empty_voice_profile()

        # Aggregate data
        aggregated = VoiceProfile(
            source="transcripts",
            transcripts_analyzed=len(individual_analyses),
            analysis_timestamp=datetime.utcnow().isoformat() + "Z",
            confidence_score=0,  # Will calculate below
            instructor_name=self._detect_instructor_name(individual_analyses),
            signature_greeting=self._select_most_common_greeting(individual_analyses),
            tone=self._majority_vote(individual_analyses, 'tone'),
            style=self._majority_vote(individual_analyses, 'style'),
            recurring_phrases=self._merge_and_rank_phrases(individual_analyses),
            teaching_approach=self._merge_teaching_patterns(individual_analyses),
            interaction_patterns=self._merge_interaction_patterns(individual_analyses),
            personality_traits=self._merge_personality_markers(individual_analyses)
        )

        # Calculate confidence score
        aggregated.confidence_score = self._calculate_confidence_score(individual_analyses, aggregated)

        print(f"✓ Aggregation complete (confidence: {aggregated.confidence_score}%)")

        return aggregated

    def _create_empty_voice_profile(self) -> VoiceProfile:
        """Create minimal voice profile when no analyses available."""
        return VoiceProfile(
            source="transcripts",
            transcripts_analyzed=0,
            analysis_timestamp=datetime.utcnow().isoformat() + "Z",
            confidence_score=0,
            instructor_name=None,
            signature_greeting="",
            tone="",
            style="",
            recurring_phrases=[],
            teaching_approach={},
            interaction_patterns={},
            personality_traits=[]
        )

    def _detect_instructor_name(self, analyses: List[VoiceAnalysis]) -> Optional[str]:
        """
        Detect instructor name from transcript content.

        Looks for patterns like:
        - "My name is [Name]"
        - "I'm [Name]"
        - "This is [Name]"

        Returns:
            Instructor name or None
        """
        # TODO: Implement name detection from greetings
        # For now, return None (can be enhanced later)
        return None

    def _select_most_common_greeting(self, analyses: List[VoiceAnalysis]) -> str:
        """Select the most common signature greeting."""
        greetings = [a.signature_greeting for a in analyses if a.signature_greeting]

        if not greetings:
            return ""

        # Count occurrences
        greeting_counts = defaultdict(int)
        for greeting in greetings:
            greeting_counts[greeting] += 1

        # Return most common
        return max(greeting_counts.items(), key=lambda x: x[1])[0]

    def _majority_vote(self, analyses: List[VoiceAnalysis], field: str) -> str:
        """
        Select majority value for a field (tone or style).

        Args:
            analyses: List of VoiceAnalysis objects
            field: Field name ('tone' or 'style')

        Returns:
            Most common value
        """
        values = [getattr(a, field) for a in analyses if getattr(a, field)]

        if not values:
            return ""

        # Count occurrences
        value_counts = defaultdict(int)
        for value in values:
            value_counts[value] += 1

        # Return most common
        return max(value_counts.items(), key=lambda x: x[1])[0]

    def _merge_and_rank_phrases(self, analyses: List[VoiceAnalysis]) -> List[Dict]:
        """
        Combine phrase counts from all transcripts, return top 10.

        Args:
            analyses: List of VoiceAnalysis objects

        Returns:
            List of top 10 phrases with counts
        """
        phrase_counts = defaultdict(int)
        phrase_contexts = {}

        for analysis in analyses:
            for phrase_data in analysis.recurring_phrases:
                if isinstance(phrase_data, dict):
                    phrase = phrase_data.get("phrase", "")
                    count = phrase_data.get("count", 1)
                    context = phrase_data.get("context", "")

                    if phrase:
                        phrase_counts[phrase] += count
                        if phrase not in phrase_contexts and context:
                            phrase_contexts[phrase] = context

        # Sort by frequency, return top 10
        top_phrases = sorted(
            phrase_counts.items(),
            key=lambda x: x[1],
            reverse=True
        )[:10]

        return [
            {
                "phrase": phrase,
                "count": count,
                "context": phrase_contexts.get(phrase, "")
            }
            for phrase, count in top_phrases
        ]

    def _merge_teaching_patterns(self, analyses: List[VoiceAnalysis]) -> Dict:
        """Merge teaching approach patterns from multiple analyses."""
        merged = {}

        # Aggregate boolean fields (majority vote)
        bool_fields = [
            'uses_analogies',
            'anticipates_concerns',
            'asks_rhetorical_questions',
            'explains_why_before_how'
        ]

        for field in bool_fields:
            values = []
            for analysis in analyses:
                if analysis.teaching_approach and field in analysis.teaching_approach:
                    val = analysis.teaching_approach[field]
                    # Convert to boolean
                    if isinstance(val, str):
                        val = val.lower() in ['yes', 'true', '1']
                    values.append(val)

            if values:
                merged[field] = sum(values) > len(values) / 2  # Majority vote

        # Theory vs practice (majority vote)
        theory_practice_values = []
        for analysis in analyses:
            if analysis.teaching_approach and 'theory_vs_practice' in analysis.teaching_approach:
                theory_practice_values.append(analysis.teaching_approach['theory_vs_practice'])

        if theory_practice_values:
            merged['theory_vs_practice'] = max(
                set(theory_practice_values),
                key=theory_practice_values.count
            )

        return merged

    def _merge_interaction_patterns(self, analyses: List[VoiceAnalysis]) -> Dict:
        """Merge interaction patterns from multiple analyses."""
        merged = {}

        # Boolean fields (majority vote)
        bool_fields = [
            'direct_address',
            'inclusive_language',
            'checks_understanding',
            'encourages_action'
        ]

        for field in bool_fields:
            values = []
            for analysis in analyses:
                if analysis.interaction_patterns and field in analysis.interaction_patterns:
                    val = analysis.interaction_patterns[field]
                    # Convert to boolean
                    if isinstance(val, str):
                        val = val.lower() in ['yes', 'true', '1']
                    values.append(val)

            if values:
                merged[field] = sum(values) > len(values) / 2  # Majority vote

        # String fields (concatenate unique values)
        string_fields = [
            'pronouns_used',
            'inclusive_examples',
            'understanding_phrases',
            'action_examples'
        ]

        for field in string_fields:
            values = []
            for analysis in analyses:
                if analysis.interaction_patterns and field in analysis.interaction_patterns:
                    val = analysis.interaction_patterns[field]
                    if val and isinstance(val, str):
                        values.append(val)

            if values:
                # Take first non-empty value (could be enhanced to merge)
                merged[field] = values[0]

        return merged

    def _merge_personality_markers(self, analyses: List[VoiceAnalysis]) -> List[Dict]:
        """Merge personality traits from multiple analyses."""
        traits_dict = {}

        for analysis in analyses:
            for trait_data in analysis.personality_traits:
                if isinstance(trait_data, dict):
                    trait = trait_data.get("trait", "")
                    evidence = trait_data.get("evidence", "")

                    if trait:
                        if trait not in traits_dict:
                            traits_dict[trait] = evidence

        # Convert to list
        return [
            {"trait": trait, "evidence": evidence}
            for trait, evidence in traits_dict.items()
        ]

    def _calculate_confidence_score(self, analyses: List[VoiceAnalysis], profile: VoiceProfile) -> int:
        """
        Calculate confidence score based on consistency across samples.

        Factors:
        - Number of transcripts analyzed (more = higher confidence)
        - Consistency of tone/style across transcripts
        - Number of recurring phrases found
        - Completeness of extracted data

        Returns:
            Confidence score (0-100)
        """
        if not analyses:
            return 0

        base_score = 50

        # Factor 1: Number of transcripts (up to +20)
        transcript_bonus = min(20, len(analyses) * 4)  # 4 points per transcript, max 20

        # Factor 2: Tone consistency (up to +15)
        tones = [a.tone for a in analyses if a.tone]
        tone_consistency = 15 if tones and len(set(tones)) <= 2 else 0

        # Factor 3: Recurring phrases (up to +10)
        phrase_bonus = min(10, len(profile.recurring_phrases))

        # Factor 4: Completeness (up to +5)
        completeness_bonus = 0
        if profile.signature_greeting:
            completeness_bonus += 1
        if profile.tone:
            completeness_bonus += 1
        if profile.teaching_approach:
            completeness_bonus += 1
        if profile.interaction_patterns:
            completeness_bonus += 1
        if profile.personality_traits:
            completeness_bonus += 1

        total_score = base_score + transcript_bonus + tone_consistency + phrase_bonus + completeness_bonus

        return min(100, total_score)  # Cap at 100

    def analyze_voice(self, use_cache: bool = True) -> Optional[VoiceProfile]:
        """
        Full voice analysis workflow with caching.

        Steps:
        1. Check cache (if enabled)
        2. Find transcripts
        3. Sample transcripts
        4. Analyze each sample with AI
        5. Aggregate results
        6. Cache results

        Args:
            use_cache: Whether to use cached results (default: True)

        Returns:
            VoiceProfile object or None on failure
        """
        print("\n" + "=" * 60)
        print("🎤 Starting Voice Analysis")
        print("=" * 60)

        # Step 1: Check cache
        if use_cache:
            cached_profile = self.load_cache()
            if cached_profile:
                print("✓ Using cached voice analysis")
                return cached_profile

        # Step 2: Find transcripts
        print("\n" + "=" * 60)
        transcript_files = self.find_transcripts()
        print("=" * 60)

        if not transcript_files:
            print("\n⚠️  No transcript files found")
            return None

        # Step 3: Sample transcripts
        print("\n" + "=" * 60)
        sampled = self.sample_transcripts(transcript_files)
        print("=" * 60)

        if not sampled:
            print("\n⚠️  No transcripts selected for analysis")
            return None

        # Step 4: Analyze each sample
        print("\n" + "=" * 60)
        print(f"🤖 Analyzing {len(sampled)} transcript(s) with AI")
        print("=" * 60)

        analyses = []
        for i, transcript in enumerate(sampled, 1):
            print(f"\n[{i}/{len(sampled)}] ", end="")
            analysis = self.analyze_transcript(transcript)
            if analysis:
                analyses.append(analysis)

        if not analyses:
            print("\n❌ All analyses failed")
            return None

        # Step 5: Aggregate results
        print("\n" + "=" * 60)
        voice_profile = self.aggregate_voice_profiles(analyses)
        print("=" * 60)

        # Step 6: Cache results
        self.cache_result(voice_profile, [f.path for f in sampled])

        return voice_profile

    def cache_result(self, voice_profile: VoiceProfile, analyzed_files: List[str]):
        """
        Save analysis results to cache.

        Args:
            voice_profile: VoiceProfile object
            analyzed_files: List of file paths that were analyzed
        """
        cache_data = {
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "analyzed_files": analyzed_files,
            "voice_profile": asdict(voice_profile)
        }

        # Ensure sources folder exists
        sources_path = self.base_path / "sources"
        sources_path.mkdir(exist_ok=True)

        # Write cache
        with open(self.cache_path, 'w', encoding='utf-8') as f:
            yaml.dump(cache_data, f, default_flow_style=False, allow_unicode=True, sort_keys=False)

        print(f"💾 Cached voice analysis to: {self.cache_path}")

    def load_cache(self) -> Optional[VoiceProfile]:
        """
        Load cached analysis if valid.

        Cache is valid if:
        - Cache file exists
        - Analyzed files haven't changed

        Returns:
            VoiceProfile object or None if cache invalid
        """
        if not self.cache_path.exists():
            return None

        try:
            with open(self.cache_path, 'r', encoding='utf-8') as f:
                cache_data = yaml.safe_load(f)

            # Validate cache structure
            if not cache_data or "voice_profile" not in cache_data:
                return None

            # Check if transcript files have changed
            cached_files = set(cache_data.get("analyzed_files", []))
            current_files = set([f.path for f in self.find_transcripts()])

            # If files changed significantly, invalidate cache
            # (Allow for small changes, but not complete replacement)
            if len(cached_files & current_files) < len(cached_files) * 0.5:
                print("⚠️  Cache invalidated (transcript files changed)")
                return None

            # Reconstruct VoiceProfile from dict
            profile_dict = cache_data["voice_profile"]
            voice_profile = VoiceProfile(**profile_dict)

            print(f"✓ Loaded cached voice analysis from {cache_data['timestamp']}")

            return voice_profile

        except Exception as e:
            print(f"⚠️  Error loading cache: {e}")
            return None

    def prefill_course_brief(self, voice_profile: Optional[VoiceProfile]) -> bool:
        """
        Pre-fill COURSE-BRIEF.md Section 4 with voice profile.

        Args:
            voice_profile: VoiceProfile object (None if no transcripts)

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

        # Find Section 4 (Voice & Personality)
        section_4_pattern = r'(## 4️⃣ VOZ & PERSONALIDADE.*?)(?=## \d️⃣|\Z)'

        match = re.search(section_4_pattern, content, re.DOTALL)

        if not match:
            print("⚠️  Section 4 (Voice & Personality) not found in COURSE-BRIEF.md")
            return False

        # Generate replacement content
        if voice_profile is None:
            # No transcripts found - insert empty template with red status
            replacement = self._generate_empty_voice_section()
        else:
            # Voice profile found - insert extracted data
            replacement = self._generate_filled_voice_section(voice_profile)

        # Replace Section 4
        new_content = content[:match.start()] + replacement + content[match.end():]

        # Write updated brief
        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(new_content)

        print(f"✓ Updated COURSE-BRIEF.md Section 4")

        return True

    def _generate_empty_voice_section(self) -> str:
        """Generate empty voice section template (red status)."""
        return """## 4️⃣ VOZ & PERSONALIDADE (MMOS INTEGRATION)

🔴 **Status:** No transcripts found. Please fill manually.

**Recommendation:**
- Add transcript files to `/sources/transcripts/`
- Or define voice profile manually below
- Or use MMOS mind if available

### 4.1. Instrutor / Persona

**Usar clone MMOS como instrutor?**
```
[ ] SIM - Usar mind do MMOS: _________________ (slug do mind)
[ ] SIM - Mas apenas tom/voz (não expertise técnica)
[ ] NÃO - Voz neutra/profissional padrão
[ ] NÃO - Voz customizada (descreva abaixo)
```

**Se NÃO usar MMOS, descreva a voz desejada:**
```
Tom geral:
[ ] Formal [ ] Casual [ ] Inspirador [ ] Técnico [ ] Provocador [ ] Didático

Personalidade em 3-5 traços:


Frases/bordões característicos (3-5 exemplos):


```

---

"""

    def _generate_filled_voice_section(self, voice_profile: VoiceProfile) -> str:
        """Generate filled voice section from extracted data."""

        # Determine status indicator
        confidence = voice_profile.confidence_score
        count = voice_profile.transcripts_analyzed

        if confidence >= 80 and count >= 3:
            status = "🟢"
            status_text = f"Extracted from {count} transcripts ({confidence}% confidence)"
        elif confidence >= 60 and count >= 1:
            status = "🟡"
            status_text = f"Extracted from {count} transcript(s) ({confidence}% confidence - review recommended)"
        else:
            status = "🔴"
            status_text = f"Low confidence extraction from {count} transcript(s) ({confidence}% confidence)"

        # Build recurring phrases section (top 5 for display)
        phrases_md = ""
        for phrase_data in voice_profile.recurring_phrases[:5]:
            phrase = phrase_data.get("phrase", "")
            count = phrase_data.get("count", 0)
            context = phrase_data.get("context", "")
            phrases_md += f'- "{phrase}" ({count}x - {context})\n'

        if not phrases_md:
            phrases_md = "_[No recurring phrases detected]_\n"

        # Build teaching approach section
        approach_md = ""
        if voice_profile.teaching_approach:
            if 'theory_vs_practice' in voice_profile.teaching_approach:
                approach_md += f"- **Approach:** {voice_profile.teaching_approach['theory_vs_practice']}\n"
            if voice_profile.teaching_approach.get('uses_analogies'):
                approach_md += "- ✅ Uses analogies and metaphors frequently\n"
            if voice_profile.teaching_approach.get('anticipates_concerns'):
                approach_md += "- ✅ Anticipates student objections/concerns proactively\n"
            if voice_profile.teaching_approach.get('asks_rhetorical_questions'):
                approach_md += "- ✅ Checks understanding with rhetorical questions\n"
            if voice_profile.teaching_approach.get('explains_why_before_how'):
                approach_md += "- ✅ Explains WHY before HOW (purpose first)\n"

        if not approach_md:
            approach_md = "_[Teaching approach not detected]_\n"

        # Build personality traits section
        traits_md = ""
        for trait_data in voice_profile.personality_traits[:4]:  # Top 4
            trait = trait_data.get("trait", "")
            evidence = trait_data.get("evidence", "")
            traits_md += f"- **{trait}:** {evidence}\n"

        if not traits_md:
            traits_md = "_[Personality traits not detected]_\n"

        # Build instructor name section
        instructor_md = ""
        if voice_profile.instructor_name:
            instructor_md = f"**Nome:** {voice_profile.instructor_name}\n\n"

        # Build full section
        return f"""## 4️⃣ VOZ & PERSONALIDADE (MMOS INTEGRATION)

{status} **Status:** {status_text}

### Instrutor

{instructor_md}**Saudação Assinatura:**
> "{voice_profile.signature_greeting}"

### Tom e Estilo

- **Tom:** {voice_profile.tone}
- **Estilo:** {voice_profile.style}

### Frases Recorrentes

As lições devem incorporar estas frases naturalmente:
{phrases_md}

### Padrões de Ensino

{approach_md}

### Traços de Personalidade

{traits_md}

---

📝 **Instruções:** Voice profile will be injected into lesson generation prompts automatically.
Review for accuracy and edit if needed, then change status to ✅.

---

"""


def main():
    """CLI interface for testing voice extractor."""
    import sys

    if len(sys.argv) < 2 or "--help" in sys.argv or "-h" in sys.argv:
        print("Usage: python voice_extractor.py <course-slug> [--no-cache]")
        print("")
        print("Arguments:")
        print("  course-slug     Course identifier (e.g., 'dominando-obsidian')")
        print("  --no-cache      Skip cache and re-analyze transcripts")
        print("")
        print("Example:")
        print("  python voice_extractor.py dominando-obsidian")
        print("  python voice_extractor.py dominando-obsidian --no-cache")
        sys.exit(0 if "--help" in sys.argv or "-h" in sys.argv else 1)

    course_slug = sys.argv[1]
    use_cache = "--no-cache" not in sys.argv

    try:
        extractor = VoiceExtractor(course_slug)

        # Run full voice analysis
        voice_profile = extractor.analyze_voice(use_cache=use_cache)

        if voice_profile:
            # Preview results
            print("\n" + "=" * 60)
            print("📊 Voice Profile Summary")
            print("=" * 60)
            print(f"\nTranscripts analyzed: {voice_profile.transcripts_analyzed}")
            print(f"Confidence score: {voice_profile.confidence_score}%")
            print(f"\nSignature greeting: \"{voice_profile.signature_greeting}\"")
            print(f"Tone: {voice_profile.tone}")
            print(f"Style: {voice_profile.style}")
            print(f"\nRecurring phrases (top 5):")
            for i, phrase_data in enumerate(voice_profile.recurring_phrases[:5], 1):
                print(f"  {i}. \"{phrase_data.get('phrase', '')}\" ({phrase_data.get('count', 0)}x)")

            # Prefill COURSE-BRIEF
            print("\n" + "=" * 60)
            extractor.prefill_course_brief(voice_profile)
            print("=" * 60)

            print("\n✅ Voice extraction completed successfully!")
        else:
            print("\n⚠️  No transcripts found. Generating empty template...")
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
