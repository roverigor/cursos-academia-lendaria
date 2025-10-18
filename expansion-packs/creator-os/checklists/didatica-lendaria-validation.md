# Didática Lendária - Validation Checklist

**Checklist Version:** 1.0-DL
**Created:** 2025-10-17
**Purpose:** Validate lessons against Didática Lendária principles (depth beyond GPS structure)
**Used By:** Story 3.13 (Didactic Quality Engine)

---

## 🎯 Overview

This checklist ensures lessons go **beyond structure (GPS)** to achieve **emotional connection and transformational learning**. It validates the "soul" of the lesson, not just the "skeleton".

**GPS = Structure** (Goal-Position-Steps)
**Didática Lendária = Depth** (Emotional essence, mental movies, transformational hooks)

**Validation Levels:**
- 🌟 **EXCEPTIONAL:** All principles applied masterfully (≥95% compliance)
- ✅ **GOOD:** Most principles present (80-94% compliance)
- 🟡 **ACCEPTABLE:** Basic principles met (60-79% compliance) - needs polish
- 🔴 **INSUFFICIENT:** Missing core principles (<60% compliance) - regenerate required

---

## 📋 Core Principles Validation

### Principle 1: 5 Porquês (Método Socrático) - CRITICAL

**Purpose:** Descend 5 levels from technical concept to emotional essence

| Level | Question | Example (API REST) |
|-------|----------|-------------------|
| 1. Technical | Why learn this? | To connect frontend with backend |
| 2. Productivity | Why connect? | To create complete applications |
| 3. Personal | Why complete apps? | To become fullstack developer |
| 4. Purpose | Why fullstack? | To have autonomy and market value |
| 5. Essence | Why autonomy? | **Financial security + freedom to choose projects** |

**Validation Criteria:**
- [ ] Hook connects to Level 5 (essence), not Level 1 (technical)
- [ ] Opening explicitly states emotional benefit
- [ ] Example:
  ```
  ✅ GOOD: "Você já imaginou poder ESCOLHER os projetos que aceita?"
  ❌ BAD: "Hoje vamos aprender API REST para conectar frontend com backend."
  ```
- [ ] Essence is emotional/aspirational (security, freedom, respect, impact)
- [ ] Not just productivity ("save time") but WHY saving time matters to THEM

**Score:** Pass if connects to Level 4-5, Fail if stops at Level 1-2

---

### Principle 2: Semiótica - Criar "Filme Mental" - CRITICAL

**Purpose:** Student remembers what they SAW/FELT, not what they HEARD

**Required Elements:**

#### 2a. Analogia do Dia a Dia (Daily Life Analogy)
- [ ] Concept explained via **universal Brazilian experience**
- [ ] Examples:
  - ✅ "useEffect é como mordomo Alfred do Batman"
  - ✅ "API REST é como garçom de restaurante: você faz pedido (request), ele traz comida (response)"
  - ❌ "useEffect é como Merkle tree em blockchain" (not universal)
- [ ] Analogy is **visual** (can picture it)
- [ ] Analogy is **culturally relevant** (Brazil/global, not niche)

#### 2b. História/Exemplo Narrativo (Story)
- [ ] At least ONE mini-story per lesson
- [ ] Story has characters (even if metaphorical)
- [ ] Story has problem → solution arc
- [ ] Example:
  ```
  "Imagine que seu componente React é sua casa.
  O JSX é a decoração (o que as pessoas veem).
  O useState é a memória (onde guarda as coisas).
  O useEffect? É o mordomo Alfred.

  Quando Batman está lutando (renderizando),
  Alfred está preparando gadgets (fetch de dados),
  monitorando câmeras (event listeners),
  limpando a Batcaverna (cleanup).

  Alfred trabalha nos bastidores, sem atrapalhar."
  ```

#### 2c. Diagrama Visual Sugerido
- [ ] At least ONE diagram placeholder/description
- [ ] Diagram clarifies spatial/process concept
- [ ] Examples: before/after, flowchart, mental map
- [ ] Not just decorative, but **illuminating**

**Score:**
- Pass: 2+ of 3 elements present (analogy + story OR analogy + diagram)
- Fail: Only technical explanation, no visual anchors

---

### Principle 3: Regra de Ouro - Máximo 2-3 Conceitos - CRITICAL

**Purpose:** Prevent cognitive overload

**Validation:**
- [ ] Lesson teaches ≤3 main concepts
- [ ] Each concept has clear header/section
- [ ] If >3 concepts detected: 🔴 FAIL (split into 2 lessons)

**How to Count:**
- Concept = New abstraction student must understand
- Example: `useState` + `useEffect` = 2 concepts (good)
- Example: `useState` + `useEffect` + `useContext` + `useReducer` = 4 concepts (TOO MANY)

**Edge Cases:**
- Sub-concepts under same umbrella = count as 1
  - Example: `useState(0)` syntax + `setState` function = 1 concept (useState)
- Related but distinct = count separately
  - Example: `props` vs `state` = 2 concepts (different mental models)

**Score:**
- 🌟 Exceptional: 2 concepts, deep coverage
- ✅ Good: 3 concepts, balanced coverage
- 🟡 Acceptable: 3 concepts, feels rushed (consider splitting)
- 🔴 Fail: 4+ concepts (cognitive overload)

---

### Principle 4: 5 Erros Fatais - Avoid These - CRITICAL

Validate lesson does NOT commit these errors:

#### Erro 1: Inibição (Lack of Clarity)
- [ ] **Check:** Jargon explained on first use?
- [ ] **Check:** No assumptions about prior knowledge (or stated upfront)?
- [ ] **Example Violation:** "Use destructuring to extract state" (assumes they know destructuring)
- [ ] **Fix:** "Destructuring (quebrar em partes) lets you extract state like this: `const [count, setCount] = ...`"

#### Erro 2: Desconexão (Broken Flow)
- [ ] **Check:** Each section logically follows previous?
- [ ] **Check:** Transitions explicit ("Agora que você entendeu X, vamos para Y")?
- [ ] **Check:** ⭐ NEW - Link de Transição presente entre conceitos?
- [ ] **Check:** ⭐ NEW - Perguntas de transição criam necessidade do próximo conceito?
- [ ] **Example Violation:** Jump from useState to API calls without connecting dots
- [ ] **Fix:** "useState guarda dados locais. Mas e quando dados vêm do servidor? Aí entra useEffect + fetch."
- [ ] **Fix (Better):** "🔗 CONECTANDO - Agora que você domina useState (dados locais), surge a questão: E quando dados vêm do servidor? É aí que entra useEffect + fetch..."

#### Erro 3: Prolixidade (Wordiness)
- [ ] **Check:** No paragraphs >150 words?
- [ ] **Check:** Uses bullets/visuals instead of walls of text?
- [ ] **Example Violation:** 5-paragraph essay explaining one concept
- [ ] **Fix:** Break into: Concept (1 line) → Analogy (visual) → Code (example) → Practice

#### Erro 4: Monotonia (Monotony)
- [ ] **Check:** Varies between: text → code → diagram → question → exercise?
- [ ] **Check:** Not all theory or all code (80/20 practice-first preferred)?
- [ ] **Example Violation:** 20 minutes of slides, no hands-on
- [ ] **Fix:** Theory (5 min) → Code example (2 min) → Your turn (3 min) → Debrief (2 min)

#### Erro 5: Falta de Imagem (No Mental Image)
- [ ] **Check:** Addressed in Principle 2 (Semiótica)
- [ ] **Check:** Every abstract concept has concrete anchor?
- [ ] **Example Violation:** "useEffect manages side effects in functional components" (abstract)
- [ ] **Fix:** "useEffect é o mordomo: faz tarefas extras enquanto componente trabalha" (concrete image)

**Score:**
- Pass: 0-1 errors detected
- Warning: 2 errors (fixable)
- Fail: 3+ errors (major rewrite needed)

---

### Principle 5: Hooks Estilo Novela - REQUIRED

**Purpose:** Create anticipation for next lesson (retention strategy)

**3 Hook Types:**

#### Tipo 1: Curiosidade Ardente (Burning Curiosity)
```
"Funciona perfeitamente... mas tem um vazamento de memória
que só aparece depois de 1000 renderizações.

99% dos devs React não sabem que existe.
Você vai ser o 1% que sabe.

Próxima aula: O cleanup que salva sua aplicação."
```

#### Tipo 2: Problema Não Resolvido (Unresolved Problem)
```
"Seu useEffect funciona. O fetch busca os dados.
Mas... e quando o usuário clica 10x seguidas no botão?

10 requests paralelas. 10x o custo da AWS. Sua conta explode.

Próxima aula: Debounce e Throttle - Salvando milhares de reais por mês."
```

#### Tipo 3: Promessa com FOMO (Promise with FOMO)
```
"Se você achou useState e useEffect poderosos, ainda não viu NADA.

Existe um Hook que o Dan Abramov chama de
'o segredo mais bem guardado do React'.

90% dos seniors não conhecem. Mas você vai conhecer.

Próxima aula: useReducer - O Hook que separa juniors de seniors."
```

**Validation Criteria:**
- [ ] Final section titled "Próxima Aula" or "Cliffhanger" or similar
- [ ] Uses ONE of the 3 hook types
- [ ] Creates tension/curiosity (doesn't just announce topic)
- [ ] Connects current lesson pain → next lesson solution
- [ ] FOMO element present ("90% não sabem", "poucos fazem")

**Examples:**
- ✅ "Você aprendeu X, mas tem um problema: [pain]. Próxima aula: [solution with benefit]"
- ❌ "Próxima aula vamos ver Y." (boring, no hook)

**Score:**
- 🌟 Exceptional: Hook genuinely creates anticipation (you WANT to click "next")
- ✅ Good: Hook present and functional
- 🟡 Acceptable: Weak hook (announces topic but no tension)
- 🔴 Fail: No hook or just "Próxima aula: Topic X"

---

### Principle 6: Estrutura de 7 Elementos - REQUIRED ⭐ NEW

**Purpose:** Ensure complete lesson structure for maximum learning effectiveness

**7 Required Elements:**

| Element | Check | Required? |
|---------|-------|-----------|
| 1. GPS (Goal-Position-Steps) | Section present | ✅ CRITICAL |
| 2. Conceito #1 (Essence-Semiotic-Practice) | Complete structure | ✅ CRITICAL |
| 3. Link de Transição | Between concepts (if >1 concept) | ✅ HIGH |
| 4. Conceito #2/3 (if applicable) | Same structure as #1 | ✅ CRITICAL (if multiple) |
| 5. Revisão Estruturada | Insights + Transformação before/after | ✅ CRITICAL |
| 6. Hook Estilo Novela | Next lesson anticipation | ✅ CRITICAL |
| 7. Ação Rápida (2min) | Immediate micro-action | ✅ HIGH |

**Validation Criteria:**

#### Element 3: Link de Transição
- [ ] If lesson has 2+ concepts: Transition link present?
- [ ] Transition uses question format ("Agora surge a pergunta...")?
- [ ] Creates logical necessity for next concept?
- [ ] Example:
  ```
  ✅ GOOD: "🔗 Agora que você domina links, surge a questão:
           'Como organizar 500 notas?' É aí que entram as Tags..."
  ❌ BAD: "Agora vamos falar de Tags." (no connection, just announcement)
  ```

#### Element 5: Revisão Estruturada
- [ ] Has "Os 2-3 Insights Principais" section?
- [ ] Each insight includes benefit/application (not just fact)?
- [ ] Has "Transformação" (before → after) section?
- [ ] Transformation connects to emotional change, not just knowledge?
- [ ] Example:
  ```
  ✅ GOOD: "Você entrou achando que links eram 'organização'.
           Agora sabe que são o SISTEMA NERVOSO do seu segundo cérebro."
  ❌ BAD: "Você aprendeu sobre links internos." (no transformation shown)
  ```

#### Element 7: Ação Rápida (2min)
- [ ] Has "⚡ FAÇA AGORA" section?
- [ ] Action is ultra-specific (numbered steps)?
- [ ] Time-boxed (2 minutes max)?
- [ ] Has validation criteria ("Funcionou se você viu X")?
- [ ] Produces immediate visible result?
- [ ] Optional: Community sharing mechanism?
- [ ] Example:
  ```
  ✅ GOOD: "1. Abra nota X
           2. Escreva [[link]]
           3. Veja backlink aparecer
           ✓ Funcionou se você viu link bidirecional"
  ❌ BAD: "Pratique criando links." (vague, no validation)
  ```

**Score:**
- 🌟 Exceptional: All 7 elements present and well-executed
- ✅ Good: 6/7 elements (missing only Ação Rápida acceptable)
- 🟡 Acceptable: 5/7 elements (missing Link+Ação)
- 🔴 Fail: <5/7 elements (regenerate required)

---

### Principle 7: Adaptação por Arquétipo - REQUIRED (if multi-archetype course)

**Purpose:** Same content, different framing per student archetype

**Validation:**
- [ ] Lesson includes "Para Seu Perfil" section OR
- [ ] Exercises adapted to primary archetype

**Arquétipos CreatorOS:**
1. **Empreendedor Travado** (infinite loop, needs focus)
2. **Executivo Exausto** (needs ROI, shortcuts)
3. **Técnico Ávido** (wants depth, best practices)
4. **Criador Bloqueado** (needs unblocking, inspiration)
5. **Veterano Desprezado** (bridge to new, respect experience)

**Example - Adapted Exercise:**

```markdown
## 🎯 PARA SEU PERFIL

### Se Você é Empreendedor Travado:
**Foco aqui:** Um conceito por vez. Não crie 10 contadores diferentes.
**Não se distraia com:** WebSockets, Redux ainda.

**Seu Exercício (5 min MAX):**
[Simplified, focused version]

### Se Você é Executivo Exausto:
**ROI imediato:** Este padrão resolve 80% dos casos.
**Tempo para resultado:** 5 minutos.
**Done > Perfect:** Funciona? Ship it.

**Seu Exercício (Copie e Adapte):**
[Template-based, ready to use]

### Se Você é Técnico Ávido:
**Desafio adicional:** Refatore para usar custom hook.
**Por que importa:** Separação de concerns, reutilização.

**Seu Exercício (Explore):**
[Advanced, open-ended]
```

**Validation:**
- [ ] If course targets 1 archetype: Tone/examples match that archetype
- [ ] If course targets multiple: Explicit sections for each OR primary archetype clearly served
- [ ] Archetype needs addressed (focus for Travado, ROI for Exausto, depth for Técnico, etc.)

**Score:**
- If single archetype: Pass if tone/examples align
- If multi-archetype: Pass if ≥2 archetypes have adapted content

---

## 🔬 Validation Workflow

### Automated Checks (Script)
```python
def validate_didatica_lendaria(lesson: str) -> DLReport:
    score = 0
    issues = []

    # Principle 1: 5 Porquês
    if not connects_to_emotional_essence(lesson):
        issues.append("Hook doesn't reach emotional essence (Level 5)")
    else:
        score += 20

    # Principle 2: Semiótica
    analogy_count = count_analogies(lesson)
    story_present = has_narrative_story(lesson)
    diagram_present = has_diagram_placeholder(lesson)

    semiotic_score = (analogy_count >= 1) + story_present + diagram_present
    if semiotic_score >= 2:
        score += 20
    else:
        issues.append(f"Semiótica weak: only {semiotic_score}/3 elements")

    # Principle 3: Regra de Ouro
    concept_count = count_main_concepts(lesson)
    if concept_count <= 3:
        score += 15
    else:
        issues.append(f"Too many concepts: {concept_count} (max 3)")
        score = 0  # CRITICAL FAIL

    # Principle 4: 5 Erros Fatais
    errors = check_fatal_errors(lesson)
    if len(errors) == 0:
        score += 20
    else:
        issues.append(f"Fatal errors: {errors}")
        score -= len(errors) * 5

    # Principle 5: Hook Estilo Novela
    hook_quality = evaluate_hook(lesson)
    if hook_quality >= 3:  # 1-5 scale
        score += 15
    else:
        issues.append(f"Weak hook (quality: {hook_quality}/5)")

    # Principle 6: Arquétipo
    archetype_adapted = has_archetype_adaptation(lesson)
    if archetype_adapted:
        score += 10

    # Determine level
    if score >= 95:
        level = "EXCEPTIONAL"
    elif score >= 80:
        level = "GOOD"
    elif score >= 60:
        level = "ACCEPTABLE"
    else:
        level = "INSUFFICIENT"

    return DLReport(level, score, issues)
```

### Manual Review (Critical for Emotional Essence)
**Reviewer must answer:**
1. After reading, can you PICTURE the concept? (Semiótica test)
2. Does the hook make you WANT the next lesson? (Hook test)
3. Could you explain this to a 10-year-old? (Clarity test)
4. Does it connect to WHY you care, not just WHAT it is? (5 Porquês test)

If NO to any: Lesson needs revision

---

## 📊 Didática Lendária Score Calculation

```
Total Score = (P1 + P2 + P3 + P4 + P5 + P6 + P7) / 100

Where:
- P1 (5 Porquês): 15 points
- P2 (Semiótica): 15 points
- P3 (Regra Ouro): 15 points (but CRITICAL - fails whole if >3 concepts)
- P4 (5 Erros): 20 points (loses 4 per error)
- P5 (Hook): 10 points
- P6 (7 Elementos): 15 points ⭐ NEW
- P7 (Arquétipo): 10 points
```

**Grading:**
- 95-100: 🌟 EXCEPTIONAL (publish as exemplar)
- 80-94: ✅ GOOD (publish as-is)
- 60-79: 🟡 ACCEPTABLE (publish with minor edits)
- <60: 🔴 INSUFFICIENT (regenerate with feedback)

---

## 🎯 Integration with GPS Checklist

**Combined Workflow:**
1. **GPS Validation** (Structure) → Ensures G-P-S present
2. **Didática Lendária Validation** (Depth) → Ensures emotional connection

**Lesson must pass BOTH to be approved.**

**Example:**
- GPS Score: 95% (🟢 PASS) - Structure perfect
- DL Score: 55% (🔴 FAIL) - No analogies, weak hook, stops at technical level

**Result:** Regenerate with DL feedback, keep GPS structure

---

## 📚 Expected Metrics

### Before DL Integration
- Student completion: 30-40%
- NPS: 30-50
- "Transformational" feedback: 15%

### After DL Integration (Target)
- Student completion: 70%+
- NPS: 70+
- "Transformational" feedback: 60%+

**Why?**
- Students REMEMBER (semiótica)
- Students CARE (5 porquês reach essence)
- Students CONTINUE (hooks create anticipation)
- Students APPLY (adapted to archetype)

---

## 🛠️ Tools Required

### Scripts
1. **`validate-didatica.py`** - Run DL checks
2. **`count-concepts.py`** - Parse lesson, count main concepts
3. **`extract-analogies.py`** - Detect analogy patterns
4. **`evaluate-hook.py`** - Score hook quality (1-5)

### Human Review Required For
- Emotional essence (AI can't fully judge)
- Cultural appropriateness of analogies
- Hook effectiveness (subjective anticipation)
- Archetype alignment (requires understanding persona)

---

**Checklist Maintained By:** CreatorOS Pedagogical Quality Team
**Last Updated:** 2025-10-17
**Version:** 1.0-DL (Didática Lendária)
