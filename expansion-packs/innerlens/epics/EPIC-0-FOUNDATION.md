# Epic 0: Foundation - Core Infrastructure & Big Five MVP

**Epic ID:** EPIC-0
**Status:** 📋 Planning
**Priority:** P0 (MUST HAVE)
**Timeline:** Weeks 1-2
**Story Points:** 21
**Owner:** Dev Lead

---

## Epic Overview

**Goal:** Establish core InnerLens Lite expansion pack infrastructure with Big Five framework detection working end-to-end.

**Why This Matters:** Foundation for all future work. Big Five is the most validated framework (50+ years research), fastest to implement, and sufficient for initial value proposition (quick screening + MMOS enhancement).

**Success Criteria:**
- ✅ User can run `*detect-traits-quick`
- ✅ 3-agent pipeline executes: @fragment-extractor → @psychologist → @quality-assurance
- ✅ Big Five scores (0-100) generated with 75%+ confidence
- ✅ Minimum 3 behavioral fragments with evidence quotes per trait
- ✅ Complete analysis in <2 minutes (30s + 90s + 30s)
- ✅ Integration with MMOS Mind Mapper working

---

## Stories (6 stories, 21 points)

### Story 0.1: Expansion Pack Structure & Configuration (3 points)

**As a** developer
**I want** the expansion pack properly structured following AIOS standards
**So that** it integrates seamlessly with AIOS-FULLSTACK framework

**Acceptance Criteria:**
- [x] `config.yaml` created with all metadata
  - name, version, description, author
  - 3 agents defined (fragment-extractor, psychologist, quality-assurance)
  - 4 tasks listed (extract-fragments, analyze-bigfive, validate-quality, integrate-with-mmos)
  - Dependencies (ETL, MMOS) declared as optional
  - Installation message in English, aligned with Lite positioning
- [x] `README.md` with quick start, architecture, use cases (in English)
- [x] `DESIGN_DECISIONS.md` with all trade-offs documented (in English)
- [x] `PRD.md` with complete product requirements (in English)
- [x] Directory structure: `agents/`, `tasks/`, `templates/`, `checklists/`, `data/`, `epics/`
- [ ] `package.json` if Node.js utilities needed
- [ ] `.gitignore` for local configs

**Definition of Done:**
- Expansion pack loads in AIOS without errors
- All 3 agents activate successfully (@fragment-extractor, @psychologist, @quality-assurance)
- All required directories exist
- All documentation in English

**Technical Notes:**
- Follow structure from `/aios-fullstack/expansion-packs/expansion-creator/`
- Reference `mmos-mind-mapper/config.yaml` for dependency syntax
- Ensure `slashPrefix: innerlens` is unique
- Positioning as "InnerLens Lite" clear throughout

---

### Story 0.2: Fragment Extractor Agent (5 points)

**As a** user
**I want** an agent that extracts universal behavioral fragments from text
**So that** evidence is captured once and reused across all personality frameworks

**Acceptance Criteria:**
- [ ] `agents/fragment-extractor.md` created (400+ lines)
- [ ] Persona defined: meticulous analyst, evidence-focused, framework-agnostic
- [ ] Commands implemented:
  - [ ] `*extract-fragments` - Extract universal behavioral fragments
  - [ ] `*show-fragments` - Display extracted fragments
  - [ ] `*export-fragments` - Export to JSON
- [ ] Fragment schema defined:
  ```json
  {
    "fragment_id": 42,
    "text": "Direct quote from source",
    "source": "file.txt:L42",
    "behavioral_category": "openness_exploration",
    "potential_frameworks": ["big_five_openness", "mbti_intuition", "enneagram_type5"],
    "confidence": 0.85,
    "context": "Surrounding text for clarity"
  }
  ```
- [ ] Extraction targets: 127 universal fragments per analysis
- [ ] Performance: <30 seconds for 500-2000 words
- [ ] Output: `fragments.json`

**Definition of Done:**
- Agent activates: `@fragment-extractor`
- Extracts 100+ fragments from test text
- Each fragment tagged with `potential_frameworks`
- Performance test: <30sec on 1000 words
- All text in English

**Technical Notes:**
- Fragment extraction is framework-agnostic (not Big Five specific)
- Tag fragments with ALL frameworks they could inform
- Store in reusable JSON format
- Use Claude Sonnet 4 for extraction (~$0.05 per run)

---

### Story 0.3: Psychologist Agent - Universal Analyst (5 points)

**As a** user
**I want** a universal psychologist agent that can analyze personality using multiple frameworks
**So that** one expert can apply different methodologies (just like a real psychologist)

**Acceptance Criteria:**
- [ ] `agents/psychologist.md` created (500+ lines)
- [ ] Persona: PhD-level psychologist, multi-framework expert, evidence-based practitioner
- [ ] Task-driven design: Agent uses different framework tasks
  - [ ] `tasks/analyze-bigfive.md` (MVP)
  - [ ] `tasks/analyze-hexaco.md` (future)
  - [ ] `tasks/analyze-mbti.md` (future)
- [ ] Knowledge base integration:
  - [ ] Loads `data/frameworks/bigfive-framework.md`
  - [ ] References Costa & McCrae (1992) NEO-PI-R
  - [ ] 6 facets per trait (30 subscales total)
- [ ] Commands:
  - [ ] `*analyze` - Run framework analysis (delegates to task)
  - [ ] `*explain-trait <trait>` - Explain what a trait means
  - [ ] `*show-evidence <trait>` - Show evidence for a score
  - [ ] `*compare-profiles` - Compare 2 profiles
- [ ] Fragment analysis workflow:
  - Reads `fragments.json` from @fragment-extractor
  - Filters fragments by `potential_frameworks` field
  - Maps fragments to traits/facets
  - Generates scores + confidence + evidence
- [ ] Output: `bigfive-raw.yaml`
- [ ] Performance: <90 seconds

**Definition of Done:**
- Agent activates: `@psychologist`
- Can execute `tasks/analyze-bigfive.md` workflow
- Uses fragments from @fragment-extractor (no duplicate extraction)
- Generates valid Big Five profile with 75%+ confidence
- Performance test: <90sec analysis time
- All content in English

**Technical Notes:**
- One psychologist, multiple frameworks (via tasks)
- Frameworks = knowledge bases (data/frameworks/)
- Tasks = workflow definitions (tasks/)
- This mirrors real-world: one psychologist, many methodologies
- Cost: ~$0.12 per analysis

---

### Story 0.4: Quality Assurance Agent + 3-Agent Pipeline (5 points)

**As a** user
**I want** independent quality validation and a complete 3-agent pipeline
**So that** results are validated before delivery

**Acceptance Criteria:**

**Part A: Quality Assurance Agent**
- [ ] `agents/quality-assurance.md` created (400+ lines)
- [ ] Persona: Independent validator, cross-framework consistency expert
- [ ] Commands:
  - [ ] `*validate` - Run quality checks on profile
  - [ ] `*cross-check` - Check consistency across frameworks (future)
- [ ] Validation workflow:
  - [ ] Loads `checklists/bigfive-quality.md`
  - [ ] Checks internal consistency (facet scores ↔ trait scores)
  - [ ] Verifies evidence quality (min 3 quotes per trait)
  - [ ] Validates confidence calibration
  - [ ] Assigns final quality score (HIGH/MEDIUM/LOW)
- [ ] Output: `bigfive-profile.yaml` (final validated version)
- [ ] Performance: <30 seconds

**Part B: 3-Agent Pipeline Integration**
- [ ] `tasks/detect-traits-quick.md` workflow orchestrates 3 agents:
  ```markdown
  Step 1: @fragment-extractor
    - Extract universal fragments
    - Output: fragments.json (~30s)

  Step 2: @psychologist
    - Load task: tasks/analyze-bigfive.md
    - Analyze fragments using Big Five
    - Output: bigfive-raw.yaml (~90s)

  Step 3: @quality-assurance
    - Load checklist: checklists/bigfive-quality.md
    - Validate profile
    - Output: bigfive-profile.yaml (~30s)
  ```
- [ ] Input validation:
  - Minimum 500 words of text (warn if less)
  - UTF-8 encoding check
  - Language detection (support pt-BR, en-US, es-ES)
- [ ] Error handling:
  - Insufficient data → warn + suggest collecting more
  - API failures → retry with exponential backoff
  - Agent failures → clear error message with recovery steps
- [ ] Total pipeline time: <2 minutes (30s + 90s + 30s = 150s)

**Definition of Done:**
- @quality-assurance agent activates successfully
- `*detect-traits-quick` orchestrates all 3 agents
- Generates final `bigfive-profile.yaml` with quality validation
- Accuracy test: 75%+ correlation with self-reported scores (N=10)
- Performance test: <2min total pipeline time
- All text in English

**Technical Notes:**
- QA agent is independent (not part of analysis)
- Uses checklists for validation (data-driven)
- Can cross-validate multiple frameworks (future)
- Cost: ~$0.03 for QA validation
- Total cost: $0.05 + $0.12 + $0.03 = $0.20 per profile

---

### Story 0.5: Big Five Profile Template (2 points)

**As a** developer
**I want** a structured YAML template for Big Five outputs
**So that** results are consistent and machine-readable

**Acceptance Criteria:**
- [ ] `templates/bigfive-profile.yaml` created
- [ ] Schema includes:
  ```yaml
  profile_version: "1.0"
  analyzed_date: "YYYYMMDD-HHMM"
  framework: "Big Five (OCEAN)"
  source_text_length: 0  # words

  traits:
    openness:
      score: 0-100
      level: "VERY_LOW | LOW | AVERAGE | HIGH | VERY_HIGH"
      confidence: 0.0-1.0
      facets:
        imagination: {score: 0-100, evidence: []}
        artistic_interest: {score: 0-100, evidence: []}
        emotionality: {score: 0-100, evidence: []}
        adventurousness: {score: 0-100, evidence: []}
        intellect: {score: 0-100, evidence: []}
        liberalism: {score: 0-100, evidence: []}
      evidence_quotes:
        - quote: "Exact text from source"
          source: "file.txt:L42"
          relevance: "Why this shows the trait"

  overall_confidence: 0.0-1.0
  quality_score: "HIGH | MEDIUM | LOW"
  limitations: []
  ```
- [ ] Validation rules (Zod schema if using TypeScript)
- [ ] Documentation: field descriptions, valid ranges, examples
- [ ] Example filled template (Naval Ravikant sample)

**Definition of Done:**
- Template renders without errors
- Can be parsed by standard YAML libraries (js-yaml, PyYAML)
- Example filled template provided
- Compatible with MMOS integration format

**Technical Notes:**
- Keep similar structure to `psychometric-profile.yaml` from MMOS
- Allow optional fields (facets) for future expansion
- Include metadata for version control
- Use snake_case for keys (YAML convention)

---

### Story 0.6: Framework Knowledge Base + Quality Checklist (1 point)

**As a** @psychologist and @quality-assurance agent
**I want** access to Big Five methodology and validation criteria
**So that** analysis is scientifically grounded and quality-controlled

**Acceptance Criteria:**

**Part A: Big Five Framework Knowledge Base**
- [ ] `data/frameworks/bigfive-framework.md` created (400+ lines)
- [ ] Content includes:
  - History: Costa & McCrae (1992), NEO-PI-R
  - Trait definitions: OCEAN explained
  - Facets: 6 per trait (30 total)
  - Fragment mapping: Which fragments indicate which traits
  - Scoring guidelines: How to interpret evidence
  - Cross-cultural validity: 50+ countries validated
  - Stability: 80%+ consistency over lifetime
  - Predictive power: Job performance, relationships, health
  - Limitations: Not diagnostic, context-dependent
- [ ] References to scientific literature (APA format)
- [ ] Examples: High vs Low on each trait (behavioral descriptions)
- [ ] Disclaimers: "For informational purposes only, not clinical diagnosis"

**Part B: Big Five Quality Checklist**
- [ ] `checklists/bigfive-quality.md` created (200+ lines)
- [ ] Checklist items:
  - [ ] Internal consistency checks (facet ↔ trait alignment)
  - [ ] Evidence sufficiency (min 3 fragments per trait)
  - [ ] Confidence calibration (realistic confidence scores)
  - [ ] No contradictory evidence flagged
  - [ ] Source attribution correct
  - [ ] Score ranges valid (0-100)
  - [ ] Quality score assignment criteria
- [ ] Pass/fail criteria for each check
- [ ] Remediation guidance for failures

**Definition of Done:**
- Framework KB file exists in `data/frameworks/`
- Quality checklist file exists in `checklists/`
- @psychologist can load framework KB
- @quality-assurance can load quality checklist
- All content in English

**Technical Notes:**
- Frameworks stored separately from agents (reusability)
- Checklists are data-driven (not hardcoded in agents)
- Markdown format for easy editing
- Link to external resources (IPIP, NEO-PI-R manual)
- Provide both research citations and practical examples

---

## Dependencies

### External Dependencies
- **AIOS-FULLSTACK 4.0+** - Core framework
- **Anthropic Claude Sonnet 4 API** - LLM analysis
- **ETL Data Collector** (optional) - Multimodal data ingestion
- **MMOS Mind Mapper** (optional) - AI cloning integration

### Internal Dependencies
- None (this is the foundation epic)

### Blockers
- [ ] API keys for Claude Sonnet 4
- [ ] Test dataset (10 known personalities with ground truth Big Five scores)

---

## Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| **Low accuracy (<75%)** | Medium | High | Start with well-validated framework (Big Five), use prompt caching, test on diverse samples |
| **Performance (>2 min)** | Low | Medium | Use streaming responses, optimize prompts, cache system instructions |
| **Insufficient test data** | High | Medium | Recruit 10 beta testers, ask for self-reported Big Five scores |
| **Portuguese in code/docs** | Low | Low | All code and documentation in English (per user requirement) |

---

## Testing Strategy

### Unit Tests
- [ ] YAML template parsing (valid/invalid inputs)
- [ ] Regex pattern matching (linguistic markers)
- [ ] Confidence scoring logic (edge cases: 0%, 50%, 100%)
- [ ] Input validation (minimum words, encoding, language)

### Integration Tests
- [ ] End-to-end: Text input → Big Five output
- [ ] Agent activation and command execution
- [ ] Template generation from analysis results
- [ ] MMOS integration (read input, write output)

### Validation Tests
- [ ] Ground truth comparison (N=10)
  - Collect self-reported Big Five scores (IPIP-NEO or similar)
  - Run `*detect-traits-quick` on their writings (500-2000 words)
  - Compute Pearson correlation (target: r > 0.75 per trait)
- [ ] Cross-rater reliability (optional)
  - 2 independent human raters score same text
  - Compare to InnerLens output
  - Cohen's kappa > 0.60

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Accuracy** | 75%+ correlation | Pearson r with self-reports (N=10) |
| **Performance** | <2 minutes | Time from input to output (1000 words) |
| **Confidence** | 75%+ average | Confidence scores across traits |
| **Usability** | 8+ NPS | Beta tester feedback (N=5) |
| **Completion Rate** | 100% | All 6 stories done |

---

## Rollout Plan

### Week 1: Infrastructure (Stories 0.1, 0.2, 0.5, 0.6)
- **Day 1-2:** Expansion pack structure + config.yaml
- **Day 3-4:** Orchestrator agent (English version)
- **Day 5:** Templates + Knowledge Base

### Week 2: Core Functionality (Stories 0.3, 0.4)
- **Day 1-2:** Traits Analyst agent
- **Day 3-4:** Detect Traits Quick task (pipeline implementation)
- **Day 5:** Testing and validation (10 test subjects)

### Week 2 End: Demo
- Record 5-min video walkthrough
- Share with AIOS community (Discord)
- Recruit 5 beta testers

---

## Definition of Done (Epic Level)

- [ ] All 6 stories completed and tested
- [ ] All 3 agents activate without errors (@fragment-extractor, @psychologist, @quality-assurance)
- [ ] `*detect-traits-quick` orchestrates 3-agent pipeline successfully
- [ ] Pipeline generates valid Big Five profile (bigfive-profile.yaml)
- [ ] Accuracy validation: 75%+ correlation (N=10)
- [ ] Performance test: <2min total pipeline time (30s + 90s + 30s)
- [ ] Fragment reuse validated (fragments.json used by multiple agents)
- [ ] Quality validation working (checklists applied)
- [ ] 5 beta testers complete walkthrough
- [ ] NPS 8+ from beta testers
- [ ] Demo video published showing 3-agent pipeline
- [ ] README updated with architecture diagram and examples
- [ ] All documentation in English

---

## Next Epic

**Epic 1: Enhanced Analysis (Weeks 3-6)**
- Add HEXACO (Honesty-Humility dimension)
- Improved linguistic markers database (100+ patterns)
- Multimodal analysis (WhatsApp, email, code patterns)
- Confidence scoring improvements
- Cultural adaptation (pt-BR, es-ES)

---

**Epic Status:** 📋 Ready to Start
**Last Updated:** 2025-01-14
**Owner:** Dev Lead

