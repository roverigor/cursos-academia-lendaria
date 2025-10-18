# Story 3.4: Voice & Persona Extraction from Transcripts

**Story ID:** STORY-3.4
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P0 (Critical)
**Complexity:** L (Large)
**Story Points:** 13
**Status:** 📋 Planning
**Owner:** Course Architect Agent
**Sprint:** Phase 2 - Intelligence

---

## User Story

**As a** course creator upgrading a legacy course with video/audio transcripts
**I want** the system to analyze instructor voice patterns automatically
**So that** the regenerated course maintains authentic voice fidelity without manual voice documentation

---

## Business Value

### Problem
Course creators have hours of recorded content:
- Video lesson transcripts
- Podcast episode transcripts
- Workshop recordings
- Live session transcripts

**Current Pain:**
- Must manually document voice/tone ("I sound warm and casual...")
- Risk of generic AI voice (loses instructor authenticity)
- Time-consuming to define teaching style (~30-60 minutes)
- Hard to capture subtle patterns (recurring phrases, interaction style)

**Result:** Generated lessons feel robotic, not like the original instructor

### Solution Value
**AI-Powered Voice Extraction:**
- Automatically analyzes transcript samples
- Detects greeting signatures, tone, recurring phrases
- Identifies teaching style patterns
- Generates structured voice profile for lesson generation

**Impact:**
- **Time Saved:** 30-60 min per course (voice documentation eliminated)
- **Quality:** Voice fidelity score 85-95% (vs. 60% generic AI)
- **Authenticity:** Students say "sounds exactly like the instructor"
- **UX:** Creator sees "system gets my voice" immediately

### Success Metrics
- ✅ Voice fidelity score ≥85% (validated by instructor)
- ✅ 90%+ of recurring phrases captured (top 10 most frequent)
- ✅ <10% false positives (incorrectly identified patterns)
- ✅ Instructor approval rate ≥80% ("this sounds like me")

---

## Acceptance Criteria

### AC 1: Transcript File Detection

**File Discovery Algorithm:**
```python
def find_transcript_files(course_folder):
    """
    Detect transcript files in course folder
    """
    search_paths = [
        f"{course_folder}/legado/transcripts/",
        f"{course_folder}/legado/",
        f"{course_folder}/transcripts/",
        f"{course_folder}/"
    ]

    # Filename patterns (case-insensitive)
    patterns = [
        "*transcript*.txt",
        "*transcript*.md",
        "*transcrição*.txt",
        "*transcrição*.md",
        "*aula*.txt",  # Common in Portuguese courses
        "*lesson*.txt"
    ]

    # Content validation: Must have conversational markers
    # (para evitar falsos positivos com outros arquivos .txt)
    conversational_markers = [
        # Portuguese
        "Olá", "Fala", "Bom dia", "Tudo bem", "Vamos lá",
        "Então", "Tá?", "Né?", "Entendeu?",
        # English
        "Hello", "Hi", "Welcome", "Let's", "Okay", "Right?", "You know"
    ]

    return validated_transcripts  # Only files with conversational patterns
```

**Validation:**
- [ ] Searches `/legado/transcripts/`, `/legado/`, `/transcripts/`, root
- [ ] Supports `.txt` and `.md` formats
- [ ] Validates content (not just filename) to avoid false positives
- [ ] Case-insensitive matching
- [ ] Portuguese and English support
- [ ] Logs all files found with confidence scores

---

### AC 2: Smart Sampling Strategy

**Sampling Algorithm:**
```python
def sample_transcripts(transcript_files):
    """
    Select representative sample to balance accuracy vs. cost
    """
    total_count = len(transcript_files)

    if total_count == 0:
        return []  # Graceful fallback

    elif total_count <= 5:
        # Small course: Analyze all transcripts
        return transcript_files

    elif 6 <= total_count <= 20:
        # Medium course: First, middle, last + 2 random
        first = transcript_files[0]
        last = transcript_files[-1]
        middle = transcript_files[total_count // 2]

        # 2 random from remaining
        remaining = [f for f in transcript_files if f not in [first, middle, last]]
        random_samples = random.sample(remaining, min(2, len(remaining)))

        return [first, middle, last] + random_samples

    else:  # total_count > 20
        # Large course: First, last + 3 random from middle third
        first = transcript_files[0]
        last = transcript_files[-1]

        # Middle third (avoid intro/outro biases)
        middle_third_start = total_count // 3
        middle_third_end = 2 * total_count // 3
        middle_third = transcript_files[middle_third_start:middle_third_end]

        random_samples = random.sample(middle_third, min(3, len(middle_third)))

        return [first, last] + random_samples

    # Total samples: 3-5 transcripts (optimal balance)
```

**Rationale:**
- **First lesson:** Captures introduction style, course setup
- **Last lesson:** Captures conclusion style, matured teaching approach
- **Middle lessons:** Captures core teaching patterns
- **Random samples:** Reduces bias from chronological ordering

**Validation:**
- [ ] Returns 0 samples gracefully if no transcripts
- [ ] Returns all if ≤5 transcripts (small courses)
- [ ] Returns 5 samples if medium course (6-20)
- [ ] Returns 5 samples if large course (>20)
- [ ] Sampling is deterministic (same files for same course)
- [ ] Logs sampling decision for transparency

---

### AC 3: AI-Powered Voice Pattern Extraction

**Analysis Prompt (sent to AI model):**
```markdown
You are analyzing instructor voice patterns from lesson transcripts.

**Task:** Extract teaching voice profile from the following transcript.

**Transcript:**
{transcript_content}

**Extract:**

1. **Signature Greeting** (First 3 sentences of transcript)
   - Exact quote, not paraphrased

2. **Tone & Style**
   - Formal or Casual?
   - Warm/Friendly or Professional/Authoritative?
   - Peer-to-peer or Expert-to-learner?

3. **Recurring Phrases** (Top 10 most frequent)
   - Exact phrases that appear 3+ times
   - Include frequency count

4. **Teaching Approach**
   - Theory-first or Practice-first?
   - Uses analogies/metaphors?
   - Anticipates student concerns?
   - Asks rhetorical questions?

5. **Interaction Patterns**
   - Addresses audience directly ("você", "you")?
   - Uses inclusive language ("vamos", "let's")?
   - Checks understanding ("entendeu?", "makes sense?")?

6. **Personality Markers**
   - Humor (yes/no + example if yes)
   - Empathy (acknowledges struggles?)
   - Authority (confident assertions?)
   - Humility (admits mistakes/uncertainty?)

**Format:** Return structured YAML.
```

**AI Model Configuration:**
```python
def analyze_voice_pattern(transcript_content):
    """
    Use AI to extract voice patterns
    """
    model = "gpt-4-mini"  # Fast, cheap, good for pattern extraction
    temperature = 0.3  # Low variance (consistent extractions)

    response = ai_client.chat.completions.create(
        model=model,
        temperature=temperature,
        messages=[
            {"role": "system", "content": VOICE_ANALYSIS_SYSTEM_PROMPT},
            {"role": "user", "content": f"Transcript:\n\n{transcript_content}"}
        ]
    )

    return parse_yaml(response.choices[0].message.content)
```

**Validation:**
- [ ] Uses AI model for semantic analysis (GPT-4 mini or equivalent)
- [ ] Analyzes each sampled transcript independently
- [ ] Extracts 6 voice dimensions (greeting, tone, phrases, approach, interaction, personality)
- [ ] Returns structured YAML output
- [ ] Handles API errors gracefully (retry logic, fallback)

---

### AC 4: Multi-Transcript Aggregation

**Aggregation Logic:**
```python
def aggregate_voice_profiles(individual_analyses):
    """
    Merge insights from multiple transcript analyses
    """
    aggregated = {
        "instructor_name": detect_instructor_name(individual_analyses),
        "signature_greeting": select_most_common_greeting(individual_analyses),
        "tone": majority_vote(individual_analyses, "tone"),
        "style": majority_vote(individual_analyses, "style"),
        "recurring_phrases": merge_and_rank_phrases(individual_analyses),
        "teaching_approach": merge_teaching_patterns(individual_analyses),
        "personality_traits": merge_personality_markers(individual_analyses)
    }

    return aggregated

def merge_and_rank_phrases(analyses):
    """
    Combine phrase counts from all transcripts, return top 10
    """
    phrase_counts = defaultdict(int)

    for analysis in analyses:
        for phrase_data in analysis["recurring_phrases"]:
            phrase = phrase_data["phrase"]
            count = phrase_data["count"]
            phrase_counts[phrase] += count

    # Sort by frequency, return top 10
    top_phrases = sorted(
        phrase_counts.items(),
        key=lambda x: x[1],
        reverse=True
    )[:10]

    return [
        {"phrase": phrase, "count": count}
        for phrase, count in top_phrases
    ]
```

**Validation:**
- [ ] Aggregates data from 3-5 individual analyses
- [ ] Uses majority vote for categorical data (tone, style)
- [ ] Sums frequency counts for recurring phrases
- [ ] Detects instructor name from content (if mentioned)
- [ ] Returns consolidated voice profile

---

### AC 5: Structured Voice Profile Output

**Output Format:**
```yaml
voice_profile:
  source: "transcripts"
  transcripts_analyzed: 5
  analysis_timestamp: "2025-10-18T11:45:00Z"
  confidence_score: 92  # Based on consistency across samples

  instructor_name: "Adriano de Marqui"  # Detected from content
  signature_greeting: "Fala, lendário! Tudo certo com você?"

  tone: "Warm, conversational, peer-to-peer mentor"
  style: "Casual yet professional, builds confidence"

  recurring_phrases:
    - phrase: "Tá?"
      count: 52
      context: "Checking understanding"
    - phrase: "Olha só..."
      count: 38
      context: "Introducing new concept"
    - phrase: "Então vamos lá..."
      count: 27
      context: "Transitioning to practice"
    - phrase: "Mão na massa"
      count: 19
      context: "Call to action"
    - phrase: "Eu sei que..."
      count: 16
      context: "Acknowledging concerns"
    - phrase: "Funciona assim"
      count: 14
      context: "Explaining mechanism"
    - phrase: "Agora sim"
      count: 12
      context: "Affirming success"
    - phrase: "Beleza?"
      count: 11
      context: "Seeking confirmation"
    - phrase: "Vou te mostrar"
      count: 9
      context: "Demonstrating"
    - phrase: "Percebe?"
      count: 8
      context: "Highlighting insight"

  teaching_approach:
    theory_vs_practice: "Practice-first (80/20 rule - doing over explaining)"
    uses_analogies: true
    anticipates_concerns: true
    asks_rhetorical_questions: true
    explains_why_before_how: true

  interaction_patterns:
    direct_address: "você (informal)"
    inclusive_language: true  # "vamos", "a gente"
    checks_understanding: true  # "tá?", "beleza?", "faz sentido?"
    encourages_action: true  # "mão na massa", "agora é sua vez"

  personality_traits:
    - trait: "Builds confidence"
      evidence: "Uses phrases like 'você consegue', 'está indo bem'"
    - trait: "Addresses objections proactively"
      evidence: "Frequently says 'eu sei que você pode estar pensando...'"
    - trait: "Uses real-world examples"
      evidence: "References client projects, market scenarios"
    - trait: "Patient and empathetic"
      evidence: "Acknowledges learning curves, normalizes struggles"
```

**Validation:**
- [ ] Generates valid YAML structure
- [ ] Includes metadata (source, timestamp, confidence)
- [ ] Captures all 6 voice dimensions
- [ ] Provides evidence/context for personality traits
- [ ] Confidence score calculated from consistency across samples

---

### AC 6: COURSE-BRIEF Integration

**Pre-fill Section 4:**
```markdown
## 4. Voz e Personalidade do Instrutor

🟢 **Status:** Extracted from 5 transcripts (92% confidence)

### Instrutor
**Nome:** Adriano de Marqui

**Saudação Assinatura:**
> "Fala, lendário! Tudo certo com você?"

### Tom e Estilo
- **Tom:** Warm, conversational, peer-to-peer mentor
- **Estilo:** Casual yet professional, builds confidence
- **Abordagem:** Practice-first (80/20 rule - doing over explaining)

### Frases Recorrentes
As lições devem incorporar estas frases naturalmente:
- "Tá?" (52x - checking understanding)
- "Olha só..." (38x - introducing new concept)
- "Então vamos lá..." (27x - transitioning to practice)
- "Mão na massa" (19x - call to action)
- "Eu sei que..." (16x - acknowledging concerns)

### Padrões de Ensino
- ✅ WHY before HOW (explain purpose first)
- ✅ Uses analogies and metaphors frequently
- ✅ Anticipates student objections/concerns proactively
- ✅ Checks understanding with rhetorical questions
- ✅ Encourages immediate action ("mão na massa")

### Traços de Personalidade
- **Builds confidence:** "você consegue", "está indo bem"
- **Addresses objections:** "eu sei que você pode estar pensando..."
- **Real-world focus:** References client projects, market scenarios
- **Patient & empathetic:** Normalizes struggles, acknowledges learning curves

---
📝 **Instruções:** Voice profile will be injected into lesson generation prompts automatically.
Review for accuracy and edit if needed, then change status to ✅.
```

**Status Calculation:**
```python
def calculate_voice_section_status(voice_profile):
    transcripts_analyzed = voice_profile["transcripts_analyzed"]
    confidence_score = voice_profile["confidence_score"]

    if transcripts_analyzed >= 3 and confidence_score >= 80:
        return "🟢"  # High confidence
    elif transcripts_analyzed >= 1 and confidence_score >= 60:
        return "🟡"  # Medium confidence, review recommended
    else:
        return "🔴"  # Low confidence or no data
```

**Validation:**
- [ ] Section 4 auto-populated with voice profile
- [ ] Status indicator reflects analysis quality (🟢/🟡/🔴)
- [ ] Includes sample count and confidence score
- [ ] Top 5 recurring phrases prominently displayed
- [ ] Instructions explain voice will be used in generation

---

### AC 7: Caching & Performance

**Cache Strategy:**
```python
def analyze_voice_with_cache(course_folder, transcript_files):
    """
    Cache analysis results to avoid re-analyzing on every run
    """
    cache_path = f"{course_folder}/legado/.voice-analysis-cache.yaml"

    # Check if cache exists and is valid
    if os.path.exists(cache_path):
        cache = load_yaml(cache_path)

        # Cache valid if same transcript files
        cached_files = cache.get("analyzed_files", [])
        current_files = [f.path for f in transcript_files]

        if set(cached_files) == set(current_files):
            logger.info(f"Using cached voice analysis from {cache['timestamp']}")
            return cache["voice_profile"]

    # No cache or invalid cache: Run analysis
    voice_profile = analyze_transcripts(transcript_files)

    # Save to cache
    save_yaml(cache_path, {
        "timestamp": datetime.now().isoformat(),
        "analyzed_files": [f.path for f in transcript_files],
        "voice_profile": voice_profile
    })

    return voice_profile
```

**Validation:**
- [ ] Caches analysis results in `/legado/.voice-analysis-cache.yaml`
- [ ] Cache invalidated if transcript files change
- [ ] Cache includes timestamp for audit
- [ ] Logs cache hit/miss for transparency
- [ ] Reduces cost on re-runs (no re-analysis)

---

### AC 8: Error Handling & Edge Cases

**Edge Cases:**

1. **No transcripts found:**
   ```markdown
   ## 4. Voz e Personalidade do Instrutor

   🔴 **Status:** No transcripts found.

   Recomendação:
   - Se você tem transcrições de aulas, adicione-as em `/legado/transcripts/`
   - Ou defina o perfil de voz manualmente abaixo

   ### Tom e Estilo
   _[Descreva o tom: formal, casual, warm, authoritative...]_
   ```

2. **Corrupted transcript (parsing fails):**
   ```
   ⚠️  Warning: Failed to analyze transcript `aula-12-corrupted.txt`

   Reason: Encoding error (invalid UTF-8)
   Action: Skipping this file, analyzing remaining transcripts
   ```

3. **Empty transcript (< 100 words):**
   ```
   ⚠️  Warning: Transcript `intro.txt` too short (23 words)

   Action: Skipping (not representative of teaching style)
   ```

4. **Low confidence (inconsistent patterns across samples):**
   ```markdown
   🟡 **Status:** Analyzed 4 transcripts (47% confidence - LOW)

   Warning: Voice patterns inconsistent across samples.
   Possible reasons:
   - Multiple instructors in course
   - Different content types (lecture vs. workshop)
   - Transcription quality issues

   Recommendation: Review extracted patterns carefully or define manually.
   ```

5. **API failure (OpenAI rate limit, outage):**
   ```
   ❌ Error: Voice analysis failed (API error: rate_limit_exceeded)

   Action: Retrying in 60 seconds (attempt 2/3)...

   If retries fail: Section 4 will be marked 🔴 for manual filling.
   Cached partial results (if any) will be preserved.
   ```

**Validation:**
- [ ] Gracefully handles zero transcripts (template with placeholders)
- [ ] Skips corrupted/empty files with warnings (doesn't crash)
- [ ] Detects low confidence and warns user
- [ ] Retries API failures up to 3 times
- [ ] Preserves partial results on failure
- [ ] All errors logged to `extraction-log.md`

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/voice_extractor.py`
   ```python
   class VoiceExtractor:
       def __init__(self, course_folder, ai_client):
           self.course_folder = course_folder
           self.ai_client = ai_client
           self.cache_path = f"{course_folder}/legado/.voice-analysis-cache.yaml"

       def find_transcripts(self) -> List[TranscriptFile]:
           """Detect transcript files"""
           pass

       def sample_transcripts(self, files: List[TranscriptFile]) -> List[TranscriptFile]:
           """Select representative sample (3-5 files)"""
           pass

       def analyze_transcript(self, file_path: str) -> VoiceAnalysis:
           """Use AI to extract voice patterns from single transcript"""
           pass

       def aggregate_analyses(self, analyses: List[VoiceAnalysis]) -> VoiceProfile:
           """Merge patterns from multiple analyses"""
           pass

       def calculate_confidence(self, analyses: List[VoiceAnalysis]) -> int:
           """Calculate confidence based on consistency"""
           pass

       def cache_result(self, voice_profile: VoiceProfile):
           """Save to cache for future runs"""
           pass

       def load_cache(self) -> Optional[VoiceProfile]:
           """Load cached analysis if valid"""
           pass

       def prefill_course_brief(self, voice_profile: VoiceProfile, brief_path: str):
           """Insert voice profile into COURSE-BRIEF Section 4"""
           pass
   ```

2. **New Prompt Template:** `expansion-packs/creator-os/templates/voice-analysis-prompt.md`
   - System prompt for AI voice analysis
   - Structured output format specification

3. **Modified Task:** `expansion-packs/creator-os/tasks/continue-course.md`
   - Add Step 2.6 (after ICP extraction):
     ```markdown
     ### Step 2.6: Extract Voice Profile (If Brownfield with Transcripts)

     If `creation_mode: brownfield`:
       1. Run Voice Extractor: `voice_extractor.find_transcripts()`
       2. Sample 3-5 representative transcripts
       3. Analyze with AI (parallel execution for speed)
       4. Aggregate patterns into voice profile
       5. Prefill COURSE-BRIEF Section 4
       6. Log extraction results
     ```

4. **New Schema:** `expansion-packs/creator-os/schemas/voice-profile.yaml`
   - Canonical voice profile structure
   - Used for validation and type checking

---

## Definition of Done

- [ ] All 8 Acceptance Criteria met
- [ ] Voice Extractor module implemented and tested
- [ ] AI analysis prompt template created and validated
- [ ] Caching mechanism implemented
- [ ] Integration with `continue-course` task complete
- [ ] Unit tests: Transcript detection (4 test cases)
- [ ] Unit tests: Sampling strategy (5 test cases)
- [ ] Integration tests: End-to-end extraction (3 real course samples)
- [ ] AI analysis tested with 10 diverse transcript samples
- [ ] Error handling tested (corrupted files, API failures, no transcripts)
- [ ] Performance: <60s total for 5 transcript analysis (parallel execution)
- [ ] Cost: <$0.50 per course analysis (acceptable budget)
- [ ] Documentation updated (how voice extraction works)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.2: File Inventory & Organization (transcripts must be in `/legado/transcripts/`)

**Downstream:**
- Story 3.6: Gap Analysis & Smart Elicitation (uses voice profile to skip Section 4 questions)
- Story 3.9: Lesson Generation (voice profile injected into generation prompts)

---

## Testing Strategy

### Unit Tests

**Test 1: Transcript Detection - Standard Patterns**
```python
def test_find_transcripts_standard():
    course_folder = create_test_course("test-voice-standard")
    create_file(f"{course_folder}/legado/transcripts/aula-1-transcript.txt", SAMPLE_TRANSCRIPT)
    create_file(f"{course_folder}/legado/transcripts/aula-2-transcript.txt", SAMPLE_TRANSCRIPT)

    extractor = VoiceExtractor(course_folder, mock_ai_client)
    files = extractor.find_transcripts()

    assert len(files) == 2
    assert all("aula" in f.path for f in files)
```

**Test 2: Sampling - Small Course**
```python
def test_sampling_small_course():
    transcripts = create_transcript_files(count=4)  # ≤5 files

    sampled = sample_transcripts(transcripts)

    assert len(sampled) == 4  # All files analyzed
```

**Test 3: Sampling - Large Course**
```python
def test_sampling_large_course():
    transcripts = create_transcript_files(count=30)  # >20 files

    sampled = sample_transcripts(transcripts)

    assert len(sampled) == 5  # First, last, + 3 from middle third
    assert transcripts[0] in sampled  # First
    assert transcripts[-1] in sampled  # Last
```

**Test 4: AI Analysis - Greeting Extraction**
```python
def test_ai_extracts_greeting():
    transcript_content = """
    Fala, lendário! Tudo certo com você? Bom te ver aqui de novo.

    Hoje vamos falar sobre links internos no Obsidian...
    """

    analysis = analyze_transcript(transcript_content, mock_ai_client)

    assert "Fala, lendário" in analysis["signature_greeting"]
    assert len(analysis["signature_greeting"]) <= 150  # First ~3 sentences
```

**Test 5: AI Analysis - Recurring Phrases**
```python
def test_ai_extracts_recurring_phrases():
    transcript_content = """
    Tá? Então vamos lá. Tá? Isso funciona assim. Tá?
    Olha só como é simples. Olha só esse exemplo. Tá?
    """

    analysis = analyze_transcript(transcript_content, mock_ai_client)

    phrases = [p["phrase"] for p in analysis["recurring_phrases"]]
    assert "Tá?" in phrases
    assert analysis["recurring_phrases"][0]["count"] >= 4  # Appears 4 times
```

**Test 6: Aggregation - Majority Vote**
```python
def test_aggregation_majority_vote_tone():
    analyses = [
        {"tone": "casual"},
        {"tone": "casual"},
        {"tone": "formal"},  # Outlier
    ]

    aggregated = aggregate_voice_profiles(analyses)

    assert aggregated["tone"] == "casual"  # Majority wins
```

**Test 7: Aggregation - Phrase Merging**
```python
def test_aggregation_phrase_counts():
    analyses = [
        {"recurring_phrases": [{"phrase": "Tá?", "count": 5}]},
        {"recurring_phrases": [{"phrase": "Tá?", "count": 3}]},
        {"recurring_phrases": [{"phrase": "Olha só", "count": 2}]}
    ]

    aggregated = aggregate_voice_profiles(analyses)

    ta_phrase = next(p for p in aggregated["recurring_phrases"] if p["phrase"] == "Tá?")
    assert ta_phrase["count"] == 8  # 5 + 3 = 8
```

**Test 8: Caching - Valid Cache Hit**
```python
def test_cache_hit():
    course_folder = create_test_course("test-cache")
    transcript_files = [create_transcript("aula-1.txt")]

    # First run: Analyze and cache
    extractor = VoiceExtractor(course_folder, mock_ai_client)
    profile1 = extractor.analyze_voice_with_cache(transcript_files)
    assert mock_ai_client.call_count == 1  # AI called

    # Second run: Load from cache
    extractor2 = VoiceExtractor(course_folder, mock_ai_client)
    profile2 = extractor2.analyze_voice_with_cache(transcript_files)
    assert mock_ai_client.call_count == 1  # AI NOT called again (cache hit)
    assert profile1 == profile2
```

**Test 9: Caching - Invalidation on File Change**
```python
def test_cache_invalidation():
    course_folder = create_test_course("test-cache-invalidate")
    files_v1 = [create_transcript("aula-1.txt")]

    # First run
    extractor = VoiceExtractor(course_folder, mock_ai_client)
    extractor.analyze_voice_with_cache(files_v1)
    assert mock_ai_client.call_count == 1

    # Add new transcript (files changed)
    files_v2 = files_v1 + [create_transcript("aula-2.txt")]

    # Second run: Cache invalidated
    extractor2 = VoiceExtractor(course_folder, mock_ai_client)
    extractor2.analyze_voice_with_cache(files_v2)
    assert mock_ai_client.call_count == 2  # Re-analyzed
```

### Integration Tests

**Test 10: End-to-End Voice Extraction**
```python
def test_e2e_voice_extraction():
    # Setup: Real course folder with 5 transcripts
    course_folder = "test-data/dominando-obsidian"
    create_transcripts(course_folder, count=5, content=REALISTIC_TRANSCRIPT)

    # Execute full workflow
    extractor = VoiceExtractor(course_folder, real_ai_client)
    transcripts = extractor.find_transcripts()
    sampled = extractor.sample_transcripts(transcripts)
    analyses = [extractor.analyze_transcript(t.path) for t in sampled]
    voice_profile = extractor.aggregate_analyses(analyses)

    # Generate COURSE-BRIEF
    brief_path = f"{course_folder}/COURSE-BRIEF.md"
    extractor.prefill_course_brief(voice_profile, brief_path)

    # Assert COURSE-BRIEF Section 4 populated
    brief_content = read_file(brief_path)
    assert "## 4. Voz e Personalidade do Instrutor" in brief_content
    assert "🟢" in brief_content or "🟡" in brief_content
    assert voice_profile["signature_greeting"] in brief_content
    assert len(voice_profile["recurring_phrases"]) >= 5
```

**Test 11: No Transcripts Graceful Fallback**
```python
def test_no_transcripts_fallback():
    course_folder = create_test_course("test-no-transcripts")
    # No transcript files created

    extractor = VoiceExtractor(course_folder, mock_ai_client)
    transcripts = extractor.find_transcripts()
    assert len(transcripts) == 0

    # Generate brief with empty Section 4
    brief_path = f"{course_folder}/COURSE-BRIEF.md"
    extractor.prefill_course_brief(None, brief_path)

    brief_content = read_file(brief_path)
    assert "🔴 **Status:** No transcripts found" in brief_content
```

**Test 12: API Failure Retry Logic**
```python
def test_api_failure_retry():
    mock_ai_client = MockAIClient(fail_count=2)  # Fail twice, succeed third

    extractor = VoiceExtractor(course_folder, mock_ai_client)
    analysis = extractor.analyze_transcript("test.txt")

    assert mock_ai_client.call_count == 3  # 2 failures + 1 success
    assert analysis is not None  # Eventually succeeded
```

---

## Open Questions

1. **Q:** Support video files directly (extract transcripts automatically)?
   **A:** Out of scope for v1. Recommend using external tools (Whisper, Rev.com). v2 could integrate Whisper API.

2. **Q:** Detect multiple instructors (guest speakers)?
   **A:** Out of scope for v1. If detected (inconsistent patterns), warn user. v2 could segment by speaker.

3. **Q:** Extract visual teaching style (from video, not transcript)?
   **A:** Out of scope (requires video analysis). Transcripts capture verbal patterns only.

4. **Q:** What if instructor has evolved their style over time (early vs. recent lessons different)?
   **A:** Sampling strategy mitigates this (samples from early, middle, late). If inconsistent, confidence score drops → user reviews.

---

## Future Enhancements

- **Video Transcription:** Integrate Whisper API for automatic transcript generation
- **Speaker Diarization:** Detect multiple speakers, extract primary instructor voice only
- **Visual Style Extraction:** Analyze video for body language, slide design patterns
- **Voice Fidelity Benchmarking:** Automated scoring of generated lessons vs. original transcripts
- **Multi-Language Support:** Extend beyond Portuguese/English
- **Custom Phrase Library:** Let user manually add signature phrases to extracted list

---

**Story Breakdown:**
- Investigation: 1.5 hours (research transcript formats, test AI analysis prompts)
- Implementation: 8 hours (file detection, sampling, AI integration, aggregation, caching)
- Testing: 2.5 hours (12 unit + integration tests)
- Documentation: 1 hour
**Total Estimate:** 13 hours (13 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.2: File Inventory & Organization](./STORY-3.2-file-inventory-organization.md)
- [Story 3.6: Gap Analysis & Smart Elicitation](./STORY-3.6-gap-analysis-smart-elicitation.md)
- [Story 3.9: Lesson Generation with GPS + DL](./STORY-3.9-lesson-generation-gps.md)
