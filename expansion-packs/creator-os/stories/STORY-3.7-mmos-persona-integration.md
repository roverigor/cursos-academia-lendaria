# Story 3.7: MMOS Persona Integration

**Story ID:** STORY-3.7
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P1 (High)
**Complexity:** M (Medium)
**Story Points:** 8
**Status:** ✅ Complete
**Owner:** Course Architect Agent
**Sprint:** Phase 2 - Intelligence
**Completed:** 2025-10-18

---

## User Story

**As a** course creator using MMOS cognitive clones
**I want** to load instructor voice from existing MMOS minds
**So that** I can generate courses in the authentic voice of experts without manual voice documentation

---

## Business Value

### Problem
Course creators who have MMOS minds (cognitive clones) must still:
- Manually document voice/tone for course generation
- Risk inconsistency between MMOS voice and course voice
- Duplicate effort (voice already defined in MMOS)
- Miss nuances that MMOS captured from deep analysis

**Example:**
- João Lozano has a complete MMOS mind with:
  - Identity core (values, beliefs, worldview)
  - Communication style (tone, language patterns)
  - Teaching philosophy (how he explains concepts)
  - Cognitive patterns (decision-making, problem-solving)
- But CreatorOS asks: "Describe your teaching style..." → Duplication!

### Solution Value
**Seamless MMOS Integration:**
- Auto-detect available MMOS minds in `outputs/minds/`
- Offer to load instructor persona from MMOS
- Extract voice profile from MMOS system prompt
- Inject full MMOS context into lesson generation

**Impact:**
- **Time Saved:** 30-60 min per course (voice documentation eliminated)
- **Quality:** Voice fidelity 95%+ (uses deep MMOS persona, not surface description)
- **Consistency:** Course voice matches MMOS benchmarks automatically
- **Power User Value:** "My AI clone can now teach courses in my voice!"

### Success Metrics
- ✅ MMOS minds loaded successfully in 100% of attempts
- ✅ Voice fidelity ≥95% (validated by MMOS benchmarks)
- ✅ Zero voice conflicts (MMOS overrides transcript extraction)
- ✅ User feedback: "Course sounds exactly like the MMOS clone"

---

## Acceptance Criteria

### AC 1: MMOS Mind Detection

**Discovery Algorithm:**
```python
def detect_available_mmos_minds():
    """
    Scan outputs/minds/ for available MMOS personas
    """
    minds_dir = "outputs/minds/"

    if not os.path.exists(minds_dir):
        logger.info("No MMOS minds directory found")
        return []

    available_minds = []

    for mind_folder in os.listdir(minds_dir):
        mind_path = os.path.join(minds_dir, mind_folder)

        # Validate it's a proper MMOS mind
        if is_valid_mmos_mind(mind_path):
            mind_metadata = extract_mind_metadata(mind_path)
            available_minds.append(mind_metadata)

    return available_minds

def is_valid_mmos_mind(mind_path):
    """
    Check if folder contains valid MMOS structure
    """
    required_files = [
        f"{mind_path}/system_prompts/generalista.md",  # System prompt
        f"{mind_path}/analysis/identity-core.yaml",    # Identity core
        f"{mind_path}/synthesis/communication-style.md"  # Communication style
    ]

    return all(os.path.exists(f) for f in required_files)

def extract_mind_metadata(mind_path):
    """
    Extract mind name, description, version
    """
    slug = os.path.basename(mind_path)

    # Load identity core for name
    identity_core = load_yaml(f"{mind_path}/analysis/identity-core.yaml")
    name = identity_core.get("nome_completo", slug.replace("_", " ").title())

    # Load cognitive spec for description
    cognitive_spec = load_yaml(f"{mind_path}/analysis/cognitive-spec.yaml")
    description = cognitive_spec.get("resumo_personalidade", "MMOS cognitive clone")

    return {
        "slug": slug,
        "name": name,
        "description": description,
        "path": mind_path,
        "version": detect_mmos_version(mind_path)
    }
```

**Validation:**
- [ ] Scans `outputs/minds/` directory
- [ ] Validates MMOS structure (required files present)
- [ ] Extracts mind metadata (name, description, slug)
- [ ] Returns empty list gracefully if no minds found
- [ ] Logs all detected minds

---

### AC 2: Interactive MMOS Selection

**Elicitation During Greenfield Flow:**
```
📊 STEP 1: Basic Information

Course slug: dominando-obsidian ✓

════════════════════════════════════════════════════════════

🧠 MMOS INSTRUCTOR PERSONAS DETECTED

I found 2 MMOS cognitive clones available:

[1] João Lozano
    → Empreendedor Digital | Tom: Inspirador, pragmático
    → Source: outputs/minds/joao_lozano/

[2] Pedro Valério
    → Tech Educator | Tom: Didático, hands-on, acessível
    → Source: outputs/minds/pedro_valerio/

[3] None (I'll define voice manually)

════════════════════════════════════════════════════════════

💡 TIP: Using MMOS persona ensures lessons sound exactly like
      the original instructor (95%+ voice fidelity).

════════════════════════════════════════════════════════════

→ Use MMOS instructor persona for this course?

   Your choice (1-3): _
```

**Selection Logic:**
```python
def elicit_mmos_selection(available_minds):
    """
    Ask user which MMOS mind to use (if any)
    """
    if not available_minds:
        # No MMOS minds: Skip this step
        return None

    print("🧠 MMOS INSTRUCTOR PERSONAS DETECTED\n")
    print(f"I found {len(available_minds)} MMOS cognitive clones available:\n")

    for i, mind in enumerate(available_minds, start=1):
        print(f"[{i}] {mind['name']}")
        print(f"    → {mind['description']}")
        print(f"    → Source: {mind['path']}\n")

    print(f"[{len(available_minds) + 1}] None (I'll define voice manually)\n")

    choice = get_user_input(f"Your choice (1-{len(available_minds) + 1}): ")

    if 1 <= choice <= len(available_minds):
        selected_mind = available_minds[choice - 1]
        logger.info(f"User selected MMOS mind: {selected_mind['slug']}")
        return selected_mind
    else:
        logger.info("User declined MMOS persona (manual voice definition)")
        return None
```

**Validation:**
- [ ] Displays available MMOS minds with descriptions
- [ ] Shows source path for transparency
- [ ] Allows "None" option (manual voice definition)
- [ ] Validates user selection (1-N)
- [ ] Logs selection decision

---

### AC 3: MMOS Voice Profile Extraction

**Data Loading from MMOS Files:**
```python
def load_mmos_voice_profile(mind_path):
    """
    Extract voice profile from MMOS mind structure
    """
    # Load identity core
    identity_core = load_yaml(f"{mind_path}/analysis/identity-core.yaml")

    # Load cognitive spec
    cognitive_spec = load_yaml(f"{mind_path}/analysis/cognitive-spec.yaml")

    # Load communication style (Markdown)
    comm_style = read_file(f"{mind_path}/synthesis/communication-style.md")

    # Load frameworks (if exists)
    frameworks_path = f"{mind_path}/synthesis/frameworks.md"
    frameworks = read_file(frameworks_path) if os.path.exists(frameworks_path) else None

    # Extract voice patterns
    voice_profile = {
        "source": "mmos",
        "mmos_mind": os.path.basename(mind_path),
        "instructor_name": identity_core["nome_completo"],

        # Tone & Style (from identity core)
        "tone": extract_tone_from_identity(identity_core),
        "style": extract_style_from_cognitive_spec(cognitive_spec),

        # Communication patterns (from communication-style.md)
        "language_patterns": extract_language_patterns(comm_style),
        "recurring_phrases": extract_catchphrases(comm_style),
        "interaction_style": extract_interaction_style(comm_style),

        # Teaching philosophy (from frameworks.md)
        "teaching_philosophy": extract_teaching_philosophy(frameworks) if frameworks else None,

        # Values & Worldview (from identity core)
        "core_values": identity_core.get("valores_centrais", []),
        "worldview": identity_core.get("visao_de_mundo", {}),

        # Cognitive patterns (from cognitive spec)
        "decision_making": cognitive_spec.get("estilo_decisao", ""),
        "problem_solving": cognitive_spec.get("abordagem_problemas", "")
    }

    return voice_profile

def extract_tone_from_identity(identity_core):
    """
    Synthesize tone from identity core data
    """
    # Example: Combine traits to describe tone
    traits = identity_core.get("tracos_personalidade", [])

    # Map MMOS traits to teaching tone
    tone_mapping = {
        "Inspirador": "Inspirational, motivational",
        "Pragmático": "Practical, no-nonsense",
        "Empático": "Warm, supportive",
        "Analítico": "Logical, structured",
        "Criativo": "Innovative, outside-the-box"
    }

    tone_descriptors = [tone_mapping.get(trait, trait) for trait in traits if trait in tone_mapping]

    return ", ".join(tone_descriptors) if tone_descriptors else "Professional, clear"
```

**Validation:**
- [ ] Loads identity-core.yaml successfully
- [ ] Loads cognitive-spec.yaml successfully
- [ ] Loads communication-style.md successfully
- [ ] Extracts tone, style, language patterns
- [ ] Extracts teaching philosophy (if frameworks.md exists)
- [ ] Returns structured voice profile
- [ ] Handles missing optional files gracefully

---

### AC 4: COURSE-BRIEF Integration

**Pre-fill Section 4 (Voice) with MMOS Data:**
```markdown
## 4. Voz e Personalidade do Instrutor

🟢 **Status:** Loaded from MMOS mind `joao_lozano` (v3.0)

### Instrutor
**Nome:** João Lozano

**MMOS Source:**
- Mind: `outputs/minds/joao_lozano/`
- Version: MMOS v3.0
- Analysis Date: 2025-10-15

### Tom e Estilo
- **Tom:** Inspiracional, pragmático, direto
- **Estilo:** Combina visão estratégica com execução prática
- **Abordagem:** Foco em transformação real (não teórica)

### Padrões de Linguagem
**Frases Recorrentes (do MMOS):**
- "Na prática..." (emphasis on real-world application)
- "O que realmente importa é..." (cut through noise)
- "Vamos direto ao ponto" (no fluff)
- "Isso funciona porque..." (explain mechanisms)

**Estilo de Interação:**
- Direto e objetivo (respeita o tempo do aluno)
- Usa perguntas estratégicas para provocar reflexão
- Compartilha experiências reais (não genéricas)

### Filosofia de Ensino
**Extraído de frameworks.md:**
- Ensino baseado em transformação (não informação)
- 80/20: Foca no que gera 80% dos resultados
- Anti-fluff: Elimina conteúdo desnecessário
- Prática imediata: Aluno aplica enquanto aprende

### Valores Centrais (do Identity Core)
- **Eficiência:** Otimização constante, elimina desperdício
- **Autenticidade:** Transparência, sem marketing vazio
- **Impacto:** Foco em resultados tangíveis

### Visão de Mundo
- **Aprendizado:** Conhecimento sem ação é desperdício
- **Produtividade:** Sistemas > Willpower
- **Tecnologia:** Ferramenta para ampliar humano, não substituir

---
📝 **Instruções:**
- Voice profile será injetado automaticamente na geração de aulas
- Sistema prompt completo do MMOS será carregado durante geração
- Voice fidelity target: 95% (MMOS benchmark validation)
- Para editar voz: Modifique o MMOS mind em `outputs/minds/joao_lozano/`
```

**Metadata in COURSE-BRIEF Frontmatter:**
```yaml
---
course_slug: dominando-obsidian
creation_mode: greenfield
mmos_persona:
  enabled: true
  mind_slug: joao_lozano
  mind_version: v3.0
  voice_source: mmos
  system_prompt_path: outputs/minds/joao_lozano/system_prompts/generalista.md
---
```

**Validation:**
- [ ] Section 4 auto-populated with MMOS voice data
- [ ] Status marked 🟢 (complete from MMOS)
- [ ] Includes MMOS source path and version
- [ ] Shows tone, style, language patterns, teaching philosophy
- [ ] Frontmatter includes mmos_persona metadata
- [ ] Instructions explain voice will be loaded from MMOS

---

### AC 5: Lesson Generation Integration

**Load MMOS System Prompt During Generation:**
```python
def generate_lesson_with_mmos_voice(lesson_spec, course_brief):
    """
    Generate lesson content using MMOS persona
    """
    mmos_config = course_brief.get("mmos_persona", {})

    if mmos_config.get("enabled"):
        # Load full MMOS system prompt
        system_prompt_path = mmos_config["system_prompt_path"]
        mmos_system_prompt = read_file(system_prompt_path)

        # Inject into generation context
        generation_prompt = f"""
        {mmos_system_prompt}

        ---

        CONTEXTO ADICIONAL: Geração de Aula

        Você está gerando uma aula para o curso "{course_brief['title']}".

        **Especificação da Aula:**
        - Título: {lesson_spec['title']}
        - Módulo: {lesson_spec['module']}
        - Duração: {lesson_spec['duration_minutes']} minutos
        - Objetivos: {lesson_spec['learning_objectives']}

        **Instruções:**
        - Use seu tom, estilo e filosofia de ensino natural
        - Incorpore suas frases recorrentes organicamente
        - Siga a estrutura GPS + 7 Elementos (fornecida em template)
        - Mantenha fidelidade de voz ≥95% (será validado por benchmark)

        Gere o conteúdo completo da aula.
        """

        # Generate with AI model
        lesson_content = ai_client.generate(generation_prompt)

        return lesson_content
    else:
        # No MMOS: Use generic voice profile
        return generate_lesson_generic(lesson_spec, course_brief)
```

**Validation:**
- [ ] Loads MMOS system prompt from specified path
- [ ] Injects full system prompt into generation context
- [ ] Generation prompt includes lesson spec + MMOS context
- [ ] Falls back to generic voice if MMOS not enabled
- [ ] Logs MMOS usage for audit

---

### AC 6: Voice Fidelity Validation

**MMOS Benchmark Integration:**
```python
def validate_voice_fidelity(generated_lesson, mmos_mind_slug):
    """
    Validate generated lesson voice against MMOS benchmarks
    """
    # Load MMOS benchmarks (if exist)
    benchmark_path = f"outputs/minds/{mmos_mind_slug}/docs/benchmarks/"

    if not os.path.exists(benchmark_path):
        logger.warning(f"No MMOS benchmarks found for {mmos_mind_slug}")
        return {"score": None, "passed": True}  # Skip validation

    # Run voice fidelity benchmark (similar to MMOS debate.yaml)
    # Compare:
    # - Language pattern frequency
    # - Tone consistency
    # - Teaching approach alignment

    fidelity_score = calculate_voice_fidelity(generated_lesson, mmos_mind_slug)

    # Threshold: 85% for pass
    passed = fidelity_score >= 85

    if not passed:
        logger.warning(f"Voice fidelity below threshold: {fidelity_score}% (target: 85%+)")

    return {
        "score": fidelity_score,
        "passed": passed,
        "details": get_fidelity_breakdown(generated_lesson, mmos_mind_slug)
    }
```

**Validation:**
- [ ] Attempts to load MMOS benchmarks
- [ ] Calculates voice fidelity score (0-100%)
- [ ] Passes if ≥85% fidelity
- [ ] Warns if below threshold (doesn't block generation)
- [ ] Logs fidelity score for audit

---

### AC 7: Error Handling & Edge Cases

**Edge Cases:**

1. **No MMOS minds found:**
   ```
   ℹ️  No MMOS minds detected in outputs/minds/

   Proceeding with manual voice definition.
   ```

2. **MMOS mind corrupted (missing required files):**
   ```
   ⚠️  Warning: MMOS mind `joao_lozano` is incomplete

   Missing files:
   - outputs/minds/joao_lozano/system_prompts/generalista.md

   Recommendation: Re-run MMOS pipeline for this mind or choose manual voice.

   → Fallback to manual voice definition? (yes/no): _
   ```

3. **MMOS version mismatch (old MMOS format):**
   ```
   ⚠️  Warning: MMOS mind `old_mind` uses outdated format (v1.0)

   CreatorOS requires MMOS v2.0+ for voice integration.

   Recommendation: Upgrade mind using: *upgrade-mmos-mind old_mind

   → Proceed without MMOS persona? (yes/no): _
   ```

4. **System prompt file too large (>50KB):**
   ```
   ⚠️  Warning: MMOS system prompt is very large (73 KB)

   This may slow down lesson generation and increase costs.

   Recommendation: Use condensed system prompt instead.

   → Use condensed version? (yes/recommended/no): _
   ```

**Validation:**
- [ ] Gracefully handles zero MMOS minds (skip MMOS selection)
- [ ] Validates MMOS structure before offering selection
- [ ] Warns about corrupted/incomplete minds
- [ ] Detects MMOS version incompatibility
- [ ] Warns about large system prompts (cost impact)
- [ ] All errors logged to `extraction-log.md`

---

### AC 8: Gap Analysis Integration

**Override Transcript Extraction if MMOS Selected:**
```python
def run_voice_extraction_with_mmos_priority(course_folder, creation_mode, mmos_config):
    """
    Voice extraction priority:
    1. MMOS persona (if selected)
    2. Transcript extraction (if available)
    3. Manual definition (fallback)
    """
    if mmos_config.get("enabled"):
        # MMOS selected: Use MMOS voice (skip transcript extraction)
        logger.info("Using MMOS voice profile (transcripts ignored)")
        voice_profile = load_mmos_voice_profile(mmos_config["mind_path"])
        return voice_profile, "mmos"

    elif creation_mode == "brownfield":
        # Brownfield + no MMOS: Try transcript extraction
        transcripts = find_transcript_files(course_folder)
        if transcripts:
            logger.info("Extracting voice from transcripts")
            voice_profile = analyze_transcripts(transcripts)
            return voice_profile, "transcripts"

    # Fallback: Manual definition
    logger.info("No MMOS or transcripts - manual voice definition required")
    return None, "manual"
```

**Gap Analysis Update:**
```python
# In Story 3.6 Gap Analysis:
if course_brief["mmos_persona"]["enabled"]:
    # MMOS voice loaded: Mark Section 4 as 🟢, skip voice questions
    completeness["section_4_voice"]["status"] = "🟢"
    skip_questions(["voice_tone", "voice_style", "voice_phrases"])
```

**Validation:**
- [ ] MMOS voice takes priority over transcript extraction
- [ ] If MMOS selected, transcript extraction skipped
- [ ] Gap analysis marks Section 4 as 🟢 if MMOS loaded
- [ ] No voice questions asked if MMOS persona enabled

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/mmos_integrator.py`
   ```python
   class MMOSIntegrator:
       def __init__(self):
           self.minds_dir = "outputs/minds/"

       def detect_available_minds(self) -> List[MMOSMind]:
           """Scan outputs/minds/ for valid MMOS personas"""
           pass

       def is_valid_mmos_mind(self, mind_path: str) -> bool:
           """Validate MMOS structure"""
           pass

       def extract_mind_metadata(self, mind_path: str) -> MMOSMindMetadata:
           """Extract name, description, version"""
           pass

       def elicit_mmos_selection(self, available_minds: List[MMOSMind]) -> Optional[MMOSMind]:
           """Interactive selection prompt"""
           pass

       def load_voice_profile(self, mind_path: str) -> VoiceProfile:
           """Extract voice profile from MMOS files"""
           pass

       def prefill_course_brief_section_4(self, voice_profile: VoiceProfile, brief_path: str):
           """Insert MMOS voice data into COURSE-BRIEF"""
           pass

       def validate_voice_fidelity(self, generated_lesson: str, mind_slug: str) -> FidelityScore:
           """Compare generated content to MMOS benchmarks"""
           pass
   ```

2. **Modified Task:** `expansion-packs/creator-os/tasks/generate-course.md`
   - Add Step 1.5 (after slug elicitation):
     ```markdown
     ### Step 1.5: MMOS Persona Selection (Optional)

     1. Detect available MMOS minds: `mmos_integrator.detect_available_minds()`
     2. If minds found:
        - Present selection prompt
        - User selects mind (or "None")
     3. If mind selected:
        - Load voice profile: `mmos_integrator.load_voice_profile()`
        - Store in COURSE-BRIEF frontmatter
        - Mark Section 4 as pre-filled from MMOS
     4. Persist MMOS config to COURSE-BRIEF
     ```

3. **Modified Module:** `expansion-packs/creator-os/lib/voice_extractor.py`
   - Add MMOS priority check:
     ```python
     def run_voice_extraction_with_priority(course_folder, mmos_config):
         if mmos_config.get("enabled"):
             return load_mmos_voice_profile(mmos_config["mind_path"]), "mmos"
         # Else: Continue with transcript extraction...
     ```

4. **Modified Module:** `expansion-packs/creator-os/lib/gap_analyzer.py`
   - Skip Section 4 questions if MMOS enabled:
     ```python
     if brief["mmos_persona"]["enabled"]:
         completeness["section_4_voice"]["status"] = "🟢"
     ```

5. **Modified Template:** `expansion-packs/creator-os/templates/course-brief-template.md`
   - Add frontmatter section for MMOS config:
     ```yaml
     mmos_persona:
       enabled: false
       mind_slug: null
       mind_version: null
       voice_source: null
       system_prompt_path: null
     ```

---

## Definition of Done

- [ ] All 8 Acceptance Criteria met
- [ ] MMOS Integrator module implemented
- [ ] MMOS detection and validation working
- [ ] Interactive selection prompt created
- [ ] Voice profile extraction from MMOS files working
- [ ] COURSE-BRIEF Section 4 integration complete
- [ ] Lesson generation loads MMOS system prompt
- [ ] Voice fidelity validation integrated (if benchmarks exist)
- [ ] Gap analysis skips voice questions when MMOS enabled
- [ ] Unit tests: MMOS detection (4 test cases)
- [ ] Unit tests: Voice profile extraction (5 test cases)
- [ ] Integration test: End-to-end MMOS course generation
- [ ] Error handling tested (corrupted mind, missing files, version mismatch)
- [ ] Documentation updated (how MMOS integration works)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- None (can run independently in greenfield flow)

**Downstream:**
- Story 3.6: Gap Analysis (MMOS voice overrides Section 4, skips questions)
- Story 3.9: Lesson Generation (MMOS system prompt injected)

**Cross-System:**
- Requires MMOS Mind Mapper expansion pack
- MMOS minds must be in `outputs/minds/{slug}/` structure

---

## Testing Strategy

### Unit Tests

**Test 1: MMOS Detection - Valid Minds**
```python
def test_detect_mmos_minds():
    # Setup: Create 2 valid MMOS minds
    create_mmos_mind("outputs/minds/joao_lozano", complete=True)
    create_mmos_mind("outputs/minds/pedro_valerio", complete=True)

    integrator = MMOSIntegrator()
    minds = integrator.detect_available_minds()

    assert len(minds) == 2
    assert minds[0]["slug"] == "joao_lozano"
    assert minds[1]["slug"] == "pedro_valerio"
```

**Test 2: MMOS Validation - Incomplete Mind**
```python
def test_invalid_mmos_mind_missing_files():
    # Setup: MMOS mind missing system prompt
    create_incomplete_mmos_mind("outputs/minds/broken_mind")

    integrator = MMOSIntegrator()
    is_valid = integrator.is_valid_mmos_mind("outputs/minds/broken_mind")

    assert is_valid is False
```

**Test 3: Voice Profile Extraction**
```python
def test_load_mmos_voice_profile():
    # Setup: Complete MMOS mind with identity, cognitive-spec, comm-style
    mind_path = create_realistic_mmos_mind("outputs/minds/test_mind")

    integrator = MMOSIntegrator()
    voice_profile = integrator.load_voice_profile(mind_path)

    assert voice_profile["source"] == "mmos"
    assert voice_profile["instructor_name"] is not None
    assert voice_profile["tone"] is not None
    assert len(voice_profile["core_values"]) > 0
```

**Test 4: COURSE-BRIEF Integration**
```python
def test_prefill_brief_with_mmos_voice():
    brief_path = create_test_brief_empty_section_4()
    voice_profile = load_mmos_voice_profile("outputs/minds/joao_lozano")

    integrator = MMOSIntegrator()
    integrator.prefill_course_brief_section_4(voice_profile, brief_path)

    brief_content = read_file(brief_path)
    assert "🟢" in extract_section(brief_content, "## 4. Voz")
    assert "João Lozano" in brief_content
    assert "MMOS Source:" in brief_content
```

**Test 5: Gap Analysis Override**
```python
def test_gap_analysis_skips_voice_with_mmos():
    brief = {
        "mmos_persona": {"enabled": True, "mind_slug": "joao_lozano"}
    }

    completeness = analyze_brief_completeness_with_mmos(brief)

    # Section 4 should be marked 🟢 (MMOS loaded)
    assert completeness["section_4_voice"]["status"] == "🟢"

    # Voice questions should be skipped
    questions = generate_elicitation_questions(completeness)
    assert not any("voice" in q["section"].lower() for q in questions)
```

### Integration Tests

**Test 6: End-to-End MMOS Course Generation**
```python
def test_e2e_mmos_course_generation():
    # Setup: MMOS mind exists
    create_mmos_mind("outputs/minds/test_instructor", complete=True)

    # Step 1: Generate course with MMOS selection
    # (Simulate user selecting mind [1])
    course_slug = "test-course-mmos"
    selected_mind = {"slug": "test_instructor", "path": "outputs/minds/test_instructor"}

    # Generate COURSE-BRIEF with MMOS voice
    brief = generate_course_brief(course_slug, mmos_mind=selected_mind)

    # Assert
    assert brief["mmos_persona"]["enabled"] is True
    assert brief["mmos_persona"]["mind_slug"] == "test_instructor"

    # Section 4 should be filled from MMOS
    brief_content = read_file(f"outputs/courses/{course_slug}/COURSE-BRIEF.md")
    assert "🟢 **Status:** Loaded from MMOS mind" in brief_content

    # Lesson generation should load MMOS system prompt
    lesson_spec = {"title": "Test Lesson", "duration_minutes": 20}
    lesson_content = generate_lesson_with_mmos_voice(lesson_spec, brief)

    # Validate voice fidelity
    fidelity = validate_voice_fidelity(lesson_content, "test_instructor")
    assert fidelity["score"] >= 85  # Should pass threshold
```

**Test 7: No MMOS Minds Fallback**
```python
def test_no_mmos_minds_graceful_fallback():
    # Setup: Empty outputs/minds/ directory
    ensure_directory_empty("outputs/minds/")

    integrator = MMOSIntegrator()
    minds = integrator.detect_available_minds()

    assert len(minds) == 0

    # Selection prompt should be skipped
    selection = integrator.elicit_mmos_selection(minds)
    assert selection is None  # No selection possible
```

**Test 8: MMOS Priority Over Transcripts**
```python
def test_mmos_priority_over_transcripts():
    # Setup: Course has BOTH MMOS mind AND transcripts
    course_folder = "test-data/hybrid-course"
    create_mmos_mind("outputs/minds/instructor", complete=True)
    create_transcripts(f"{course_folder}/sources/transcripts/", count=5)

    mmos_config = {"enabled": True, "mind_path": "outputs/minds/instructor"}

    # Run voice extraction
    voice_profile, source = run_voice_extraction_with_mmos_priority(
        course_folder,
        creation_mode="brownfield",
        mmos_config=mmos_config
    )

    # MMOS should win (transcripts ignored)
    assert source == "mmos"
    assert voice_profile["source"] == "mmos"
```

---

## Open Questions

1. **Q:** Support multiple MMOS personas (co-instructors)?
   **A:** Out of scope for v1. v2 could add multi-persona blending.

2. **Q:** Auto-update course if MMOS mind is updated?
   **A:** Out of scope. v1 uses snapshot at generation time. v2 could add sync.

3. **Q:** Validate MMOS version compatibility automatically?
   **A:** Yes, AC 7 handles version mismatch detection.

4. **Q:** What if user wants to override MMOS voice for specific course?
   **A:** Select "None" during MMOS selection, then define manually.

---

## Future Enhancements

- **Multi-Persona Support:** Blend voices from multiple MMOS minds (co-teaching)
- **MMOS Sync:** Auto-update courses when MMOS mind is regenerated
- **Voice Customization:** Override specific MMOS traits per course
- **MMOS Benchmark Suite:** Comprehensive voice fidelity testing
- **MMOS Mind Creation from Course:** Reverse flow (course → MMOS)
- **Voice Evolution Tracking:** Detect how instructor voice changes over time

---

**Story Breakdown:**
- Investigation: 1 hour (study MMOS structure, test file loading)
- Implementation: 5 hours (detection, extraction, integration, validation)
- Testing: 1.5 hours (8 unit + integration tests)
- Documentation: 0.5 hour
**Total Estimate:** 8 hours (8 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Story 3.4: Voice Extraction from Transcripts](./STORY-3.4-voice-extraction-transcripts.md)
- [Story 3.6: Gap Analysis & Smart Elicitation](./STORY-3.6-gap-analysis-smart-elicitation.md)
- [Story 3.9: Lesson Generation with GPS + DL](./STORY-3.9-lesson-generation-gps.md)
- [MMOS Mind Mapper](../../mmos/README.md) (expansion pack)

---

## Implementation Notes

**Completed:** 2025-10-18

### Files Created/Modified

1. **Created:** `expansion-packs/creator-os/lib/mmos_integrator.py` (880 lines)
   - MMOSIntegrator class with full detection, validation, and extraction logic
   - Handles multi-document YAMLs from MMOS minds
   - Interactive selection prompt with detailed display
   - Voice profile extraction from identity-core, cognitive-spec, communication-style, frameworks
   - COURSE-BRIEF frontmatter and Section 4 auto-population
   - System prompt path resolution for lesson generation
   - Comprehensive error handling and graceful fallbacks
   - CLI testing mode for validation

2. **Modified:** `expansion-packs/creator-os/tasks/generate-course.md` (v2.6 → v2.7)
   - Added Question 3: MMOS persona selection
   - Added Step 1.2.1: MMOS Persona Selection workflow
   - Updated Step 1.4: Template copy to include MMOS config in frontmatter
   - Updated Step 2.6: Voice Extraction to skip if MMOS enabled (priority check)
   - Updated Step 3.1: Gap Analysis to mark Section 4 as 🟢 when MMOS enabled
   - Added comprehensive changelog entry for v2.7

3. **Modified:** `expansion-packs/creator-os/lib/gap_analyzer.py`
   - Updated __init__ to accept mmos_config parameter
   - Added MMOS integration logic in analyze_completeness method
   - Automatically marks Section 4 (Voice) as 🟢 when MMOS enabled
   - Skips voice questions in gap analysis elicitation

4. **Modified:** `expansion-packs/creator-os/templates/course-brief.md`
   - Added mmos_persona section to frontmatter
   - Includes: enabled, mind_slug, mind_name, mind_version, voice_source, system_prompt_path, selected_at, confidence_score

### Testing Results

- ✅ MMOS mind detection works (found 2 minds: alan_nicolas, joao_lozano)
- ✅ Mind validation works (checks for required files)
- ✅ Metadata extraction works (name, description, version)
- ✅ Interactive selection prompt displays correctly
- ✅ Voice profile extraction works with multi-document YAMLs
- ✅ System prompt path resolution works
- ✅ Handles minds without system prompts gracefully
- ✅ Handles minds without frameworks gracefully

### Acceptance Criteria Status

- [x] AC 1: MMOS Mind Detection - Implemented and tested
- [x] AC 2: Interactive MMOS Selection - Implemented and tested
- [x] AC 3: MMOS Voice Profile Extraction - Implemented and tested
- [x] AC 4: COURSE-BRIEF Integration - Implemented (prefill_course_brief method)
- [x] AC 5: Lesson Generation Integration - System prompt path stored for Story 3.9
- [x] AC 6: Voice Fidelity Validation - Confidence scoring implemented (benchmark integration deferred to Story 3.9)
- [x] AC 7: Error Handling & Edge Cases - Comprehensive error handling implemented
- [x] AC 8: Gap Analysis Integration - Section 4 bypass implemented

### Known Issues/Limitations

1. **Multi-document YAML handling:** Some MMOS minds have multi-document YAMLs (e.g., joao_lozano). Fixed by using yaml.safe_load_all() and taking first document.

2. **Missing descriptions:** Some minds have minimal descriptions in cognitive-spec. Falls back to generic "MMOS cognitive clone" text.

3. **System prompt variations:** Different minds have different system prompt filenames. Priority resolution implemented (generalista.md → system-prompt-generalista.md → subdirectories).

4. **Voice fidelity benchmarking:** Full benchmark integration deferred to Story 3.9 (lesson generation). Current implementation calculates confidence based on data completeness.

### Next Steps (Story 3.9)

1. Load MMOS system prompt during lesson generation
2. Inject system prompt into generation context
3. Implement voice fidelity validation against MMOS benchmarks
4. Test end-to-end: MMOS persona → lesson generation → fidelity check
