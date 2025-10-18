# Story 3.14: Transformational Assessment Generation

**Story ID:** STORY-3.14
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P1 (High)
**Complexity:** M (Medium)
**Story Points:** 8
**Status:** 📋 Planning
**Owner:** Course Architect Agent
**Sprint:** Phase 4 - Quality

---

## User Story

**As a** course creator
**I want** assessments that validate transformation (not just memorization)
**So that** students prove they can APPLY knowledge in real scenarios, creating portfolio-worthy work

---

## Business Value

### Problem
Traditional course assessments test memorization:
- "What is the definition of X?"
- Multiple choice with obvious wrong answers
- No connection to real-world application
- Students forget immediately after quiz

**Result:** 80% pass rate but 20% can actually apply the knowledge

### Solution Value
**Transformational Assessments:**
- Test application in real scenarios
- Generate portfolio pieces
- Use professional rubrics (Junior/Pleno/Senior levels)
- Create immediate market value

**Impact:**
- Higher completion (assessments feel valuable, not academic)
- Better outcomes (students can show proof of skill)
- Stronger course reputation (results > certificates)

### Success Metrics
- ✅ 90%+ assessments test application (not definition recall)
- ✅ 60%+ projects are portfolio-worthy
- ✅ Rubrics align with market standards (validated by industry)
- ✅ Students report "learned more from project than lessons" (30%+)

---

## Acceptance Criteria

### AC 1: Quiz Generation - Application-Focused

**Types of Questions:**

| Type | Description | When to Use |
|------|-------------|-------------|
| **Scenario-Based** | "You face X situation. What do you do?" | Testing decision-making |
| **Debugging** | "This code/process fails. Why? How fix?" | Testing troubleshooting |
| **Optimization** | "This works but is slow/expensive. Improve it." | Testing efficiency thinking |
| **Trade-offs** | "Option A vs B. Which when?" | Testing strategic judgment |

**NOT Allowed:**
- ❌ "What is the definition of X?"
- ❌ "Which year was X invented?"
- ❌ Multiple choice with 3 obviously wrong answers

**Template:**
```yaml
quiz:
  module: "{module_id}"
  type: "application" # not "knowledge_recall"
  difficulty: "real_world" # not "academic"

questions:
  - id: "q1"
    scenario: |
      {Real situation they'll face}
      Problem: {Specific issue}
      Constraints: {Time/budget/resources}

    question: "What's your approach?"

    options:
      a:
        answer: "{Specific action}"
        feedback: "Sim! {Why this works in this scenario}"
        correct: true
      b:
        answer: "{Specific action}"
        feedback: "Funcionaria, mas... {Why suboptimal}"
        correct: false
      c:
        answer: "{Common mistake}"
        feedback: "Cuidado! {Why this fails + how to avoid}"
        correct: false
      d:
        answer: "{Another approach}"
        feedback: "{Why not ideal for THIS scenario}"
        correct: false

    explanation: |
      A resposta certa é A porque {detailed reasoning}.

      Na prática, você vai usar isso quando {real_world_application}.

      Dica pro: {Advanced insight}
```

**Validation:**
- [ ] Every question has scenario context
- [ ] Correct answer requires applying concept, not recalling definition
- [ ] Wrong answers are plausible (test understanding, not guessing)
- [ ] Feedback explains WHY, not just "wrong"
- [ ] Explanation connects to real-world application

---

### AC 2: Project Generation - Portfolio-Worthy

**Project Structure:**
```markdown
# PROJETO: {Intriguing_Title_That_Sells_Value}

## 🎯 O Desafio Real

**Cenário de Mercado:**
"Você foi contratado como {role} para {company_context}.
O cliente precisa de {specific_need}.
Prazo: {realistic_deadline}.
Budget: {constraint}."

**Briefing:**
{Detailed requirements as if from real client}

---

## 🏆 O Que Você Vai Criar

Não é exercício acadêmico. É **trabalho real**:

**Entregável Final:**
{Specific deliverable - e.g., "Landing page funcional", "Dashboard analytics", "API documentation"}

**Valor de Mercado:**
- Freelancer cobra: R$ {X} por isso
- Você está criando: Portfolio piece que vale R$ {X}
- Tempo estimado: {hours} horas
- ROI de aprendizado: {benefit}

**Publicável em:**
- [ ] GitHub (código aberto)
- [ ] LinkedIn (case study)
- [ ] Behance/Dribbble (se design)
- [ ] Seu portfólio pessoal

---

## 📊 Rubrica Profissional

Avalie-se com critérios de mercado (não acadêmicos):

| Critério | Junior (60%) | Pleno (80%) | Senior (100%) |
|----------|--------------|-------------|---------------|
| **{Criterion_1}** | {Basic_level} | {Intermediate_level} | {Advanced_level} |
| **{Criterion_2}** | {Basic_level} | {Intermediate_level} | {Advanced_level} |
| **{Criterion_3}** | {Basic_level} | {Intermediate_level} | {Advanced_level} |
| **{Criterion_4}** | {Basic_level} | {Intermediate_level} | {Advanced_level} |

**Exemplo: Projeto Web App**

| Critério | Junior (60%) | Pleno (80%) | Senior (100%) |
|----------|--------------|-------------|---------------|
| **Responsividade** | Mobile quebra em alguns pontos | Mobile funciona bem | Mobile-first, testa em 5+ devices |
| **Performance** | Carrega em <5s | Carrega em <3s | <1s, lazy loading, otimizado |
| **Código** | Funciona mas duplicado | DRY, componentizado | Padrões avançados, testes |
| **UX** | Usável mas genérico | Boa usabilidade | Micro-interações, acessível |

**Sua Meta:** Alcançar **nível Pleno (80%)** ao final

Se alcançar Senior (100%): Parabéns, você está pronto para cobrar premium!

---

## 🛠️ Recursos de Apoio

**Templates Fornecidos:**
- [ ] {Template_1} - {What it provides}
- [ ] {Template_2} - {What it provides}

**Referências Profissionais:**
- [ ] {Industry_example_1}
- [ ] {Industry_example_2}

**Checklist de Entrega:**
- [ ] {Deliverable_component_1}
- [ ] {Deliverable_component_2}
- [ ] README.md profissional
- [ ] Instruções de uso/instalação
- [ ] Screenshot/demo funcionando

---

## 💡 Dicas de Quem Trabalha com Isso

**Do's:**
- ✅ {Professional_tip_1}
- ✅ {Professional_tip_2}

**Don'ts:**
- ❌ {Common_mistake_1 and why to avoid}
- ❌ {Common_mistake_2 and why to avoid}

**Atalhos que Economizam Horas:**
- 🚀 {Time_saver_1}
- 🚀 {Time_saver_2}

---

## 🎯 Entrega e Feedback

**Como Enviar:**
{Submission instructions - GitHub link, video demo, etc.}

**O Que Será Avaliado:**
1. **Funcionalidade** (40%): Funciona conforme especificado?
2. **Qualidade** (30%): Código/design profissional?
3. **Apresentação** (20%): Bem documentado e apresentado?
4. **Criatividade** (10%): Foi além do mínimo?

**Feedback Format:**
- Rubrica preenchida (Junior/Pleno/Senior por critério)
- Top 3 pontos fortes
- Top 3 melhorias sugeridas
- Próximos passos para evoluir

---

## 🚀 Versão Avançada (Opcional)

Para quem quer se destacar ainda mais:

**Desafio Extra:**
{Advanced requirement that separates good from excellent}

**Recompensa:**
{Badge, feature in course showcase, LinkedIn recommendation, etc.}

---

*Tempo estimado: {X-Y} horas | Nível: {Beginner/Intermediate/Advanced}*
*Baseado em projetos reais de {company/industry}*
```

**Validation:**
- [ ] Project simulates real client scenario (not "build X for fun")
- [ ] Deliverable is portfolio-worthy (students will actually showcase)
- [ ] Rubric uses industry terms (Junior/Pleno/Senior, not A/B/C grades)
- [ ] Includes professional tips from practitioners
- [ ] Has submission + feedback mechanism

---

### AC 3: Assessment Types by Module

**Recommendation Algorithm:**
```python
def suggest_assessment_type(module_content, module_position, course_duration):
    if module_position == 1:  # First module
        return "knowledge_check_quiz"  # Light, build confidence

    elif module_position == final_module:  # Last module
        return "capstone_project"  # Integrate everything

    elif module_content_type == "hands_on":
        return "mini_project"  # Immediate application

    elif module_content_type == "conceptual":
        return "scenario_quiz"  # Test understanding through scenarios

    elif module_duration > 3_hours:
        return "milestone_project"  # Checkpoint validation

    else:
        return "application_quiz"  # Default: test real-world application
```

**Assessment Mix (Recommended):**
- 40% Scenario-based quizzes (quick validation)
- 40% Mini-projects (module milestones)
- 20% Capstone project (final integration)

**NOT:**
- ❌ 100% quizzes (no hands-on proof)
- ❌ Only 1 final project (no checkpoints)
- ❌ No assessments (can't validate learning)

---

### AC 4: Automated Rubric Generation

**For Each Project, Generate Rubric Based On:**

1. **Core Competency** (from learning objectives)
2. **Market Standards** (industry benchmarks)
3. **Measurable Criteria** (not subjective "good")

**Template:**
```yaml
rubric:
  project_id: "{id}"
  criteria_count: 4  # Recommended: 3-5 criteria

  criterion_1:
    name: "{Competency_being_measured}"
    description: "{What this criterion evaluates}"

    levels:
      junior_60:
        description: "{Minimum acceptable}"
        indicators:
          - "{Observable_behavior_1}"
          - "{Observable_behavior_2}"

      pleno_80:
        description: "{Solid professional level}"
        indicators:
          - "{Observable_behavior_1}"
          - "{Observable_behavior_2}"

      senior_100:
        description: "{Excellent/exemplary}"
        indicators:
          - "{Observable_behavior_1}"
          - "{Observable_behavior_2}"
```

**Validation:**
- [ ] Criteria align with module learning objectives
- [ ] Levels are measurable (not "good/better/best")
- [ ] Junior level is achievable by course students
- [ ] Senior level requires extra effort (stretch goal)
- [ ] Total rubric can be scored (weighted sum)

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/assessment_generator.py`
   ```python
   class AssessmentGenerator:
       def generate_quiz(module, objectives) -> Quiz:
           """Generate scenario-based quiz"""
           pass

       def generate_project(module, archetype) -> Project:
           """Generate portfolio-worthy project"""
           pass

       def generate_rubric(project, objectives) -> Rubric:
           """Generate professional rubric"""
           pass
   ```

2. **New Template:** `expansion-packs/creator-os/templates/project-portfolio.md`
3. **New Template:** `expansion-packs/creator-os/templates/quiz-application.yaml`
4. **New Template:** `expansion-packs/creator-os/templates/rubric-professional.yaml`

---

## Definition of Done

- [ ] All 4 Acceptance Criteria met
- [ ] Quiz template generates application-focused questions
- [ ] Project template creates portfolio-worthy deliverables
- [ ] Rubric uses Junior/Pleno/Senior levels
- [ ] Integration test: Generate full assessment suite for sample course
- [ ] Manual validation: Industry professional reviews rubric (accurate?)
- [ ] Documentation updated (how to create transformational assessments)
- [ ] Merged to main branch

---

## Dependencies

**Upstream:**
- Story 3.9: Lesson Generation (assessments align with lessons)

**Downstream:**
- Enables higher completion rates (valuable assessments)
- Enables student portfolio building (job-ready outcomes)

---

## Testing Strategy

### Validation Test
```python
def test_quiz_is_application_focused():
    quiz = generate_quiz(module="react-hooks")

    for question in quiz.questions:
        # Must have scenario context
        assert question.scenario is not None
        assert len(question.scenario) > 50  # Not trivial

        # Must test application, not recall
        assert "what is" not in question.text.lower()
        assert "define" not in question.text.lower()

        # Must have real-world connection
        assert any(keyword in question.scenario.lower()
                   for keyword in ["client", "project", "production", "user"])

def test_project_is_portfolio_worthy():
    project = generate_project(module="web-development")

    # Must have market context
    assert "freelancer cobra" in project.content or "valor de mercado" in project.content

    # Must have professional rubric
    assert project.rubric.has_level("junior")
    assert project.rubric.has_level("pleno")
    assert project.rubric.has_level("senior")

    # Must be publishable
    assert any(platform in project.content.lower()
               for platform in ["github", "linkedin", "portfolio"])
```

---

## Open Questions

1. **Q:** Auto-grading for projects?
   **A:** Out of scope for v1 (peer/instructor review). v2 could add AI-assisted grading.

2. **Q:** Quiz difficulty adaptation?
   **A:** Start all at "pleno" level. If pattern of failures, suggest review. No auto-easy mode.

3. **Q:** Industry validation of rubrics?
   **A:** YES - critical. Partner with 2-3 industry professionals to validate rubric accuracy.

---

## Future Enhancements

- AI-powered quiz generation from lesson content
- Peer review system for projects
- Auto-grading using rubric + AI
- Project showcase gallery (best student work)
- LinkedIn skill endorsement integration

---

**Story Breakdown:**
- Investigation: 1 hour (research transformational assessment patterns)
- Implementation: 5 hours (quiz + project + rubric generators)
- Testing: 1.5 hours (validation with sample content)
- Documentation: 0.5 hour
**Total Estimate:** 8 hours (8 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Didática Lendária Checklist](../checklists/didatica-lendaria-validation.md)
- [Story 3.9: Lesson Generation](./STORY-3.9-lesson-generation-gps.md)
