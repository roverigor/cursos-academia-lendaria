# Expansion Packs - Cross-Pack Workflows

**Orchestrated workflows that span multiple expansion packs**

---

## Purpose

Cross-pack workflows demonstrate:
- ✅ **End-to-end value** - Complete user journeys across packs
- ✅ **Integration patterns** - How packs work together
- ✅ **Data flow** - Where outputs from one pack become inputs to another
- ✅ **Optimization opportunities** - Where workflows can be streamlined

---

## Workflow Catalog

### 1. Complete Mind Creation with Course Generation

**Use Case:** Create high-fidelity cognitive clone and generate course in their voice

**Packs Involved:** ETL Data Collector → InnerLens → MMOS → CreatorOS

**Duration:** 3-5 days (for public figure) | 15-20 hours (for private individual)

**Cost:** ~$2-3 total (ETL free, InnerLens $0.20, MMOS $2-3, CreatorOS $0.50)

```yaml
workflow:
  name: "Mind → Course Pipeline"
  id: "WF-001"
  complexity: "high"
  automation_level: "semi-automatic"

  steps:
    - step: 1
      name: "Data Collection"
      pack: ETL Data Collector
      agent: "@data-collector"
      command: "*collect-all-sources"

      input:
        - type: "file"
          path: "sources.yaml"
          content: |
            sources:
              - id: lex-naval-1
                type: youtube
                url: https://youtube.com/watch?v=...
              - id: naval-blog
                type: blog
                url: https://nav.al/

      output:
        - type: "directory"
          path: "outputs/minds/naval/sources/downloads/"
          contents:
            - "youtube/lex-naval-1/transcript.md"
            - "blogs/naval-blog-1.md"
            - "pdf/naval-almanack/text.md"

      duration: "4-8 hours"
      manual_steps:
        - "Create sources.yaml"
        - "Review downloaded content quality"

    - step: 2
      name: "Personality Analysis (Optional)"
      pack: InnerLens
      agent: "@innerlens-orchestrator"
      command: "*detect-traits-quick"

      input:
        - type: "directory"
          path: "outputs/minds/naval/sources/downloads/"
          format: "text files (markdown)"

      output:
        - type: "file"
          path: "outputs/minds/naval/analysis/psychometric-profile.yaml"
        - type: "database"
          table: "sources, fragments, big_five_profiles"

      duration: "2 minutes"
      cost: "$0.20"
      optional: true
      benefit: "Adds personality layer to mind (2-3% fidelity improvement)"

    - step: 3
      name: "Mind Creation"
      pack: MMOS
      agent: "@mind-mapper"
      command: "*map naval"

      input:
        - type: "directory"
          path: "outputs/minds/naval/sources/"
        - type: "file"
          path: "outputs/minds/naval/analysis/psychometric-profile.yaml"
          optional: true

      output:
        - type: "file"
          path: "outputs/minds/naval/system_prompts/generalista.md"
        - type: "database"
          table: "minds, cognitive_specs, mind_fragments"

      duration: "15-20 hours (private) | 3-5 days (public)"
      cost: "$1-2M tokens"

      uses:
        - "ETL sources for analysis"
        - "InnerLens profile for personality enrichment"

      result:
        fidelity: "94% (base) + 2-3% (InnerLens) = 96-97%"

    - step: 4
      name: "Course Generation"
      pack: CreatorOS
      agent: "@course-architect"
      command: "*new startup-fundamentals"

      input:
        - type: "file"
          path: "outputs/courses/startup-fundamentals/COURSE-BRIEF.md"
          manual: true
        - type: "file"
          path: "outputs/minds/naval/system_prompts/generalista.md"
          optional: true

      output:
        - type: "directory"
          path: "outputs/courses/startup-fundamentals/"
          contents:
            - "curriculum.yaml"
            - "lessons/lesson-001.md (with Naval's voice)"
            - "market-research/"
        - type: "database"
          table: "courses, lessons, content_pieces"

      duration: "45-75 minutes"
      cost: "$0.50"

      uses:
        - "Naval system prompt for 90%+ voice fidelity"

      result:
        fidelity: "90%+ (sounds like Naval wrote it)"

  total_effort:
    time: "3-5 days (active work: ~20-25 hours)"
    cost: "$2.50-$3.70"
    manual_steps: 3
    automation_level: "75%"

  value_delivered:
    - "High-fidelity cognitive clone (96%+ fidelity)"
    - "Complete course with authentic voice"
    - "Personality-enriched content"
    - "Reusable mind for future courses"
```

---

### 2. Standalone Personality Analysis

**Use Case:** Quick Big Five analysis without full mind creation

**Packs Involved:** InnerLens only (ETL optional)

**Duration:** 2 minutes

**Cost:** $0.20

```yaml
workflow:
  name: "Quick Personality Profiling"
  id: "WF-002"
  complexity: "low"
  automation_level: "fully-automatic"

  steps:
    - step: 1
      name: "Personality Analysis"
      pack: InnerLens
      agent: "@innerlens-orchestrator"
      command: "*detect-traits-quick"

      input:
        - type: "file"
          path: "interview-transcript.txt"
          source: "user-provided OR etl"

      output:
        - type: "file"
          path: "bigfive-profile.yaml"
        - type: "database"
          table: "sources, fragments, big_five_profiles"

      duration: "2 minutes"
      cost: "$0.20"

  use_cases:
    - "Job candidate assessment (screening only, not decision)"
    - "Self-analysis"
    - "Research study"
    - "Content personalization"

  limitations:
    - "Not a diagnostic tool"
    - "Requires 500-2000 words of text"
    - "Confidence scores indicate reliability"
```

---

### 3. Course Generation (No MMOS Voice)

**Use Case:** Generate course quickly without voice cloning

**Packs Involved:** CreatorOS only

**Duration:** 45-75 minutes

**Cost:** $0.50

```yaml
workflow:
  name: "Fast Course Generation"
  id: "WF-003"
  complexity: "medium"
  automation_level: "semi-automatic"

  steps:
    - step: 1
      name: "Course Generation"
      pack: CreatorOS
      agent: "@course-architect"
      command: "*new course-slug"

      input:
        - type: "file"
          path: "outputs/courses/course-slug/COURSE-BRIEF.md"
          manual: true

      output:
        - type: "directory"
          path: "outputs/courses/course-slug/"
          contents:
            - "curriculum.yaml"
            - "lessons/"
            - "market-research/"
        - type: "database"
          table: "courses, lessons"

      duration: "45-75 minutes"
      cost: "$0.50"

      voice_fidelity: "Rule-based extraction (70-80% vs 90%+ with MMOS)"

  when_to_use:
    - "Quick course creation"
    - "No specific instructor voice needed"
    - "Budget-constrained"
    - "Testing course concept"
```

---

### 4. Brownfield Course Upgrade

**Use Case:** Modernize existing course with market intelligence

**Packs Involved:** CreatorOS (with ETL pre-processing)

**Duration:** 30-60 minutes

**Cost:** $0.60

```yaml
workflow:
  name: "Legacy Course Modernization"
  id: "WF-004"
  complexity: "medium"
  automation_level: "highly-automatic"

  prerequisites:
    - "Legacy course materials (videos, transcripts, PDFs)"
    - "Place in outputs/courses/{slug}/sources/"

  steps:
    - step: 1
      name: "File Organization & Extraction"
      pack: CreatorOS
      agent: "@course-architect"
      command: "*upgrade course-slug"

      action: "Auto-organize files, extract ICP, voice, objectives"

      input:
        - type: "directory"
          path: "outputs/courses/course-slug/sources/"
          contents:
            - "videos/*.mp4"
            - "transcripts/*.txt"
            - "pdfs/*.pdf"

      output:
        - type: "file"
          path: "outputs/courses/course-slug/COURSE-BRIEF.md"
          status: "80% complete (auto-extracted)"

      duration: "10-15 minutes"

    - step: 2
      name: "Market Research & Reformulation"
      pack: CreatorOS
      action: "Analyze competitors, reformulate brief"

      duration: "10-15 minutes"

    - step: 3
      name: "Curriculum Generation"
      pack: CreatorOS
      action: "Generate modernized curriculum + lessons"

      duration: "10-30 minutes"

      result:
        - "Modernized course structure"
        - "Preserved instructor voice"
        - "Competitive intelligence integrated"

  benefits:
    - "60-80% of COURSE-BRIEF auto-extracted"
    - "Voice preserved from transcripts"
    - "Market-aware curriculum"
    - "Faster than greenfield (30-60 min vs 45-75 min)"
```

---

### 5. Database Design & Setup

**Use Case:** Design and implement database schema

**Packs Involved:** SuperAgentes (DB Sage)

**Duration:** 2-4 hours

```yaml
workflow:
  name: "Database Schema Design & Implementation"
  id: "WF-005"
  complexity: "high"
  automation_level: "semi-automatic"

  steps:
    - step: 1
      name: "Environment Validation"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*env-check"
      duration: "1 minute"

    - step: 2
      name: "Schema Design"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*create-schema"
      duration: "30-60 minutes"
      manual: true

    - step: 3
      name: "Migration Creation"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*create-migration-plan"
      duration: "15-30 minutes"

    - step: 4
      name: "Snapshot (Rollback Point)"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*snapshot baseline"
      duration: "1 minute"

    - step: 5
      name: "Migration Application"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*apply-migration v1.sql"
      duration: "5-10 minutes"

    - step: 6
      name: "Smoke Testing"
      pack: SuperAgentes
      agent: "@db-sage"
      command: "*smoke-test v1"
      duration: "10-20 minutes"
      validates:
        - "All tables created"
        - "RLS policies applied"
        - "Indexes created"
        - "Permissions correct"

  total_effort: "2-4 hours"

  safety_features:
    - "Automatic snapshots before migrations"
    - "Rollback capability"
    - "Comprehensive smoke tests"
    - "RLS audit"
```

---

### 6. Design System Brownfield Audit

**Use Case:** Audit existing codebase and consolidate UI patterns

**Packs Involved:** SuperAgentes (Design System)

**Duration:** 2-4 hours

```yaml
workflow:
  name: "UI Pattern Consolidation"
  id: "WF-006"
  complexity: "high"
  automation_level: "highly-automatic"

  steps:
    - step: 1
      name: "Pattern Audit"
      pack: SuperAgentes
      agent: "@design-system"
      command: "*audit ./src"

      output:
        - "Pattern inventory (buttons, colors, spacing, typography)"
        - "Redundancy report (e.g., 47 button variations)"

      duration: "10-20 minutes"

    - step: 2
      name: "Consolidation via Clustering"
      pack: SuperAgentes
      agent: "@design-system"
      command: "*consolidate"

      action: "HSL clustering to reduce 47 buttons → 3 variants"

      output:
        - "Consolidated patterns (>80% reduction)"

      duration: "15-30 minutes"

    - step: 3
      name: "Token Generation"
      pack: SuperAgentes
      agent: "@design-system"
      command: "*tokenize"

      output:
        - "tokens.yaml"
        - "Multi-format exports (JSON, CSS, Tailwind)"

      duration: "5-10 minutes"

    - step: 4
      name: "Shock Report & ROI"
      pack: SuperAgentes
      agent: "@design-system"
      command: "*shock-report"

      output:
        - "Visual HTML report (before/after comparisons)"
        - "ROI analysis (cost savings, breakeven time)"

      duration: "10-15 minutes"

    - step: 5
      name: "Component Generation"
      pack: SuperAgentes
      agent: "@design-system"
      command: "*build button"

      output:
        - "Production React components"
        - "Token-based styling"
        - "WCAG AA accessibility"
        - "Unit tests + Storybook"

      duration: "30-60 minutes per component"

  total_effort: "2-4 hours (audit + 3-5 components)"

  deliverables:
    - "Pattern audit report"
    - "Design tokens"
    - "Shock report (for stakeholders)"
    - "ROI analysis"
    - "Production components"
```

---

## Workflow Optimization Opportunities

### Current Pain Points

1. **MMOS Pipeline Duration**
   - ⏱️ Current: 15-20 hours (private) | 3-5 days (public)
   - 💡 Opportunity: Parallelize phases, use faster models for initial passes

2. **Manual COURSE-BRIEF Creation**
   - ⏱️ Current: 20-30 minutes manual work
   - 💡 Opportunity: Auto-generate from source analysis (like brownfield)

3. **ETL → MMOS Handoff**
   - ⏱️ Current: Manual file organization
   - 💡 Opportunity: Standardized file structure, auto-detection

4. **InnerLens Integration**
   - ⏱️ Current: Separate step, manual trigger
   - 💡 Opportunity: Auto-trigger during MMOS pipeline if text available

### Future Workflow Enhancements

**WF-001-v2: Fully Automatic Mind + Course**
```yaml
enhancements:
  - "Auto-trigger InnerLens during MMOS phase 1"
  - "Auto-generate COURSE-BRIEF from mind synthesis"
  - "Single command: *create-mind-and-course naval startup-fundamentals"
  - "Duration: Same, but fully hands-off"
```

**WF-007: Multi-Mind Collaboration**
```yaml
workflow:
  name: "Multi-Mind Course Generation"
  concept: "Generate course with multiple instructor voices"

  example:
    - "Intro: Naval (contrarian, philosophical)"
    - "Technical: Y Combinator founder (practical)"
    - "Case Studies: Successful founder (narrative)"

  packs: MMOS (3 minds) → CreatorOS
  duration: "90-120 minutes"

  status: "Concept - not yet implemented"
```

**WF-008: Design System + MMOS Integration**
```yaml
workflow:
  name: "Personality-Based UI Tokens"
  concept: "Generate UI tokens adapted to mind personality"

  example:
    - "High Openness mind → More colorful, expressive UI"
    - "High Conscientiousness mind → Structured, organized layout"

  packs: MMOS → InnerLens → SuperAgentes (Design System)

  status: "Concept - requires integration development"
```

---

## Workflow Templates

### Template: Cross-Pack Workflow

```yaml
workflow:
  name: "[Workflow Name]"
  id: "WF-XXX"
  complexity: "low | medium | high"
  automation_level: "fully-automatic | semi-automatic | manual"

  packs_involved:
    - pack_name_1
    - pack_name_2

  prerequisites:
    - "[What must exist before starting]"

  steps:
    - step: N
      name: "[Step Name]"
      pack: "[Pack Name]"
      agent: "@agent-name"
      command: "*command-name"

      input:
        - type: "file | directory | database"
          path: "path/to/input"
          optional: true/false

      output:
        - type: "file | directory | database"
          path: "path/to/output"

      duration: "[Time estimate]"
      cost: "[$X.XX]"
      manual_steps:
        - "[Manual action required]"

  total_effort:
    time: "[Total time]"
    cost: "[$X.XX]"
    manual_steps: N
    automation_level: "X%"

  value_delivered:
    - "[Benefit 1]"
    - "[Benefit 2]"
```

---

## Workflow Execution Guide

### How to Execute Workflow WF-001

**Step-by-step execution:**

1. **Prepare sources.yaml**
```bash
cd outputs/minds/naval/
vim sources.yaml
# Add YouTube, blog, PDF sources
```

2. **Run ETL collection**
```bash
@data-collector
*collect-all-sources --sources sources.yaml --output sources/downloads/
# Wait 4-8 hours
```

3. **Run InnerLens analysis (optional)**
```bash
@innerlens-orchestrator
*detect-traits-quick --input sources/downloads/ --subject-id naval
# Wait 2 minutes
```

4. **Create mind with MMOS**
```bash
@mind-mapper
*map naval
# Wait 15-20 hours (private) or 3-5 days (public)
```

5. **Generate course with CreatorOS**
```bash
@course-architect
*new startup-fundamentals
# Fill COURSE-BRIEF.md or use pre-created brief
# System detects Naval mind, uses for voice
# Wait 45-75 minutes
```

**Result:** Complete course in Naval's voice (90%+ fidelity)

---

## Integration Testing

### How to Test Workflows

**WF-001 Integration Test:**
```javascript
// tests/integration/wf-001-mind-course.test.js
describe('Workflow WF-001: Mind → Course', () => {
  it('should create mind and course with 90%+ voice fidelity', async () => {
    // 1. Mock ETL data collection
    await ETL.collectSources('test-mind', testSources);

    // 2. Run InnerLens
    const profile = await InnerLens.analyze('test-mind');
    expect(profile).toBeDefined();

    // 3. Create mind with MMOS
    const mind = await MMOS.createMind('test-mind');
    expect(mind.fidelity).toBeGreaterThan(0.94);

    // 4. Generate course with CreatorOS
    const course = await CreatorOS.generateCourse({
      slug: 'test-course',
      mind: mind,
      brief: testBrief
    });

    // 5. Validate voice fidelity
    const fidelity = await CreatorOS.validateFidelity(course);
    expect(fidelity).toBeGreaterThanOrEqual(0.90);
  });
});
```

---

**Last Updated:** 2025-10-27
**Status:** Living document - add new workflows as they emerge
