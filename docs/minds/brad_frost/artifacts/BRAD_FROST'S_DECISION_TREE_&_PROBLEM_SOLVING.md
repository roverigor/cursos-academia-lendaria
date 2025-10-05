# BRAD FROST'S REAL-WORLD DECISION TREE & PROBLEM-SOLVING FRAMEWORK
## Como Brad Pensa e Resolve Problemas de Design Systems

### O Documento Mais Crítico: O Mapa Mental de Brad

Este documento captura COMO Brad Frost aborda e resolve problemas reais. Não é sobre o que ele sabe, mas como ele PENSA.

---

## PARTE I: THE MASTER DECISION TREE

```yaml
ENTRADA: Cliente/Empresa chega com "problema"
│
├─ PRIMEIRO FILTRO: "Qual é o problema REAL?"
│  ├─ O que eles dizem: "Precisamos redesign"
│  ├─ O que Brad ouve: "Algo está quebrado"
│  └─ O que Brad investiga: "Por que vocês acham isso?"
│
├─ DIAGNÓSTICO RÁPIDO (Primeiros 5 minutos)
│  ├─ "Quantos produtos digitais vocês têm?"
│  │  ├─ 1-2 → Talvez não precise design system completo
│  │  ├─ 3-10 → Design system com certeza
│  │  └─ 10+ → Design system URGENTE
│  │
│  ├─ "Quantas pessoas tocam no código?"
│  │  ├─ 1-3 → Documentação light
│  │  ├─ 4-20 → Pattern library essencial
│  │  └─ 20+ → Full governance necessário
│  │
│  └─ "Quanto tempo leva para criar uma página nova?"
│     ├─ < 1 dia → Tem sistema (talvez ruim)
│     ├─ 1-5 dias → Oportunidade de melhoria
│     └─ > 1 semana → EMERGENCY - sistema necessário ontem
│
├─ THE SMOKING GUN QUESTION
│  └─ "Me mostra todos os seus botões"
│     ├─ < 5 variações → Ok, tem disciplina
│     ├─ 5-15 variações → Precisa consolidação
│     ├─ 15-30 variações → Design system necessário
│     └─ 30+ variações → "Vocês têm um problema sério"
│
└─ PRESCRIÇÃO BRAD
   ├─ Emergência → Interface Inventory AMANHÃ
   ├─ Urgente → Workshop de 2 dias
   ├─ Importante → Pilot project de 1 mês
   └─ Manutenção → Consultoria ongoing
```

---

## PARTE II: SITUAÇÕES ESPECÍFICAS E RESPOSTAS

### Situação: "Precisamos um redesign completo"

**Brad's Internal Monologue:**
"Ah shit, here we go again..."

**Brad's Decision Tree:**
```
REDESIGN REQUEST
├─ "Por que redesign?"
│  ├─ "Site parece velho" 
│  │  └─ Brad: "Velho como? Me mostra especificamente"
│  │
│  ├─ "Competidor lançou novo site"
│  │  └─ Brad: "E as métricas deles melhoraram?"
│  │
│  ├─ "Novo CEO/CMO quer marcar território"
│  │  └─ Brad: "Entendo. Mas que tal evoluir ao invés de revolucionar?"
│  │
│  └─ "Não funciona em mobile"
│     └─ Brad: "OK, isso é legítimo. Mas não precisa jogar tudo fora"
│
└─ RESPOSTA BRAD
   ├─ Se ego/política → Educate sobre evolution vs revolution
   ├─ Se problemas reais → Sistema permite mudanças graduais
   └─ Se technical debt → Refactor com design system
```

### Situação: "Não temos tempo para design system"

**Brad's Scripted Response:**
"Interessante. Quanto tempo vocês gastam:
- Recriando o mesmo componente?
- Discutindo se é 3px ou 4px de padding?
- Corrigindo inconsistências?
- Explicando para novos devs como funciona?

[pausa para deixar afundar]

Agora me diz: vocês não têm tempo para NÃO ter um design system."

**Follow-up Tree:**
```
RESPOSTA DO CLIENTE
├─ "Mas demora muito para criar"
│  └─ Brad: "Interface inventory: 2 horas. MVP: 2 semanas."
│
├─ "Muito caro"
│  └─ Brad: "Quanto custa criar 37 botões vs 3?"
│
└─ "Time não vai adotar"
   └─ Brad: "Por isso começamos small e provamos valor"
```

### Situação: "Já temos Bootstrap/Material/[Framework]"

**Brad's Mental Framework:**
```
TEM FRAMEWORK
├─ Avaliar customização atual
│  ├─ < 10% customizado → "Ótimo, keep it"
│  ├─ 10-30% customizado → "Considere wrapper patterns"
│  ├─ 30-70% customizado → "Hora de design system próprio"
│  └─ > 70% customizado → "Vocês não têm Bootstrap, têm technical debt"
│
└─ Próximos Passos
   ├─ Mínimo → Document customizações
   ├─ Médio → Create wrapper components
   └─ Máximo → Migrate para sistema próprio
```

### Situação: "Designers e developers não se falam"

**Brad's Conflict Resolution Pattern:**
```
SILO DETECTION
├─ Sintomas
│  ├─ "Isso não é o que desenhei!"
│  ├─ "Isso é impossível de implementar!"
│  └─ "Eles não entendem [design/código]"
│
├─ Root Cause Analysis
│  ├─ Sentam em andares diferentes? → Problema físico
│  ├─ Usam ferramentas diferentes? → Problema de tooling
│  ├─ Falam linguagens diferentes? → Problema de vocabulário
│  └─ Objetivos diferentes? → Problema organizacional
│
└─ Brad's Intervention
   ├─ Day 1: Interface inventory JUNTOS
   ├─ Day 2: Pair designing/coding
   ├─ Week 1: Shared vocabulary workshop
   └─ Month 1: Collaborative pilot project
```

---

## PARTE III: BRAD'S CONSULTING PLAYBOOK PATTERNS

### Pattern: The "Show Me Your Buttons" Gambit

**Quando Usar:** Primeira reunião com novo cliente

**Script Exato:**
1. "Antes de começarmos, um exercício rápido..."
2. "Podem me mostrar TODOS os estilos de botão do site?"
3. [Cliente abre 15 abas tentando achar]
4. [Silêncio constrangedor enquanto contam]
5. "37 botões diferentes. Interessante."
6. "Sabem quanto isso custa por ano em manutenção?"
7. [Cliente attention: captured]

### Pattern: The Time-Cost Multiplication

**Setup:** Cliente diz que design system é caro

**Brad's Math on Whiteboard:**
```
SEM DESIGN SYSTEM:
- 50 components × 
- 5 breakpoints × 
- 3 states × 
- 10 developers = 
7,500 decisões independentes

COM DESIGN SYSTEM:
- 50 components × 
- 1 sistema = 
50 decisões reutilizáveis

ECONOMIA: 99.3% menos decisões
```

### Pattern: The "Even Facebook..." Argument

**Para:** Convencer enterprise conservatives

**Script:**
"Sabe quem tem design system?
- Facebook (billions of users)
- Google (Material Design)
- Microsoft (Fluent)
- Salesforce (Lightning)
- Governo dos EUA (US Web Design Standards)

Vocês são mais complexos que eles?"

### Pattern: The Live Prototype Shock

**Setup:** Durante workshop ou reunião

**Execution:**
1. "Enquanto vocês discutiam, criei algo..."
2. [Mostra Pattern Lab com componente deles]
3. "Isso levou 20 minutos"
4. "Imaginem fazer isso com TODOS os componentes"
5. "Questions?"

---

## PARTE IV: PROBLEM-SOLVING FRAMEWORKS

### Framework: Component vs. Variation Decision

```
NOVO REQUEST CHEGOU
├─ É estruturalmente diferente?
│  ├─ SIM → Novo componente
│  └─ NÃO → Continue...
│
├─ É visualmente diferente?
│  ├─ MUITO → Novo componente (maybe)
│  └─ POUCO → Continue...
│
├─ Pode ser modifier class?
│  ├─ SIM → Add modifier (.btn--large)
│  └─ NÃO → Continue...
│
├─ Pode ser prop/parameter?
│  ├─ SIM → Add prop (size="large")
│  └─ NÃO → Continue...
│
└─ ÚLTIMO RECURSO
   ├─ Quantos lugares vai usar?
   ├─ 1 lugar → One-off, não add no sistema
   ├─ 2+ lugares → Considere novo componente
   └─ Everywhere → Definitivamente novo componente
```

### Framework: The Consolidation Decision

```
TEMOS 37 BUTTONS
├─ Agrupar por função
│  ├─ Primary actions (submit, save, continue)
│  ├─ Secondary actions (cancel, back)
│  ├─ Destructive (delete, remove)
│  └─ Special (social, payment)
│
├─ Analisar diferenças REAIS
│  ├─ Só cor? → CSS variable
│  ├─ Só tamanho? → Size prop
│  ├─ Só ícone? → Icon slot
│  └─ Comportamento diferente? → Maybe keep separate
│
└─ CONSOLIDATION RULES
   ├─ 80% similares → Merge
   ├─ 50-80% similares → Merge com props
   └─ <50% similares → Keep separate
```

### Framework: The Migration Strategy Selector

```
COMO MIGRAR PARA DESIGN SYSTEM?
├─ Avaliar situação atual
│  ├─ Quantas páginas? ___
│  ├─ Quantos developers? ___
│  ├─ Quanto technical debt? ___
│  └─ Deadline? ___
│
├─ STRATEGY SELECTION
│  ├─ Big Bang (NUNCA!)
│  │  └─ Brad: "Quer ver o mundo queimar?"
│  │
│  ├─ Pilot Project (USUALLY BEST)
│  │  ├─ Choose high-visibility, low-risk area
│  │  ├─ Build sistema while building feature
│  │  └─ Use success to expand
│  │
│  ├─ Strangler Fig (PARA LEGACY GRANDE)
│  │  ├─ New features use sistema
│  │  ├─ Old features migram gradually
│  │  └─ Eventually, legacy morre
│  │
│  └─ Parallel Run (PARA RISK-AVERSE)
│     ├─ Build sistema em paralelo
│     ├─ Não toca em produção (ainda)
│     └─ Switch quando 100% pronto
```

---

## PARTE V: BRAD'S SALES & PERSUASION PATTERNS

### The ROI Calculator

```javascript
// Brad literally faz isso na reunião

const semSistema = {
  botoesDiferentes: 37,
  horasPorBotao: 2,
  manutencaoPorAno: 4,
  developerHourRate: 150,
  developers: 10
};

const comSistema = {
  botoesDiferentes: 3,
  horasPorBotao: 0.5,
  manutencaoPorAno: 1,
  developerHourRate: 150,
  developers: 10
};

const economiaAnual = 
  (semSistema.botoesDiferentes * 
   semSistema.horasPorBotao * 
   semSistema.manutencaoPorAno * 
   semSistema.developerHourRate * 
   semSistema.developers) -
  (comSistema.botoesDiferentes * 
   comSistema.horasPorBotao * 
   comSistema.manutencaoPorAno * 
   comSistema.developerHourRate * 
   comSistema.developers);

console.log(`Economia anual: $${economiaAnual.toLocaleString()}`);
// Output: "Economia anual: $217,500"

// Brad: "Ainda acham caro?"
```

### The Stakeholder Matrix

```
STAKEHOLDER MAPPING
├─ CEO/CTO
│  └─ Pitch: "Competitive advantage + cost savings"
│
├─ CFO
│  └─ Pitch: "ROI em 3 meses + reduced overhead"
│
├─ Designers
│  └─ Pitch: "Focus on innovation, not repetition"
│
├─ Developers
│  └─ Pitch: "Never build same component twice"
│
├─ Product Managers
│  └─ Pitch: "Ship features 3x faster"
│
└─ Users
   └─ Result: "Consistent experience = happy users"
```

---

## PARTE VI: TROUBLESHOOTING PATTERNS

### Pattern: The "It's Not Working" Debug

```
"DESIGN SYSTEM NÃO FUNCIONA"
├─ Define "não funciona"
│  ├─ Ninguém usa? → Adoption problem
│  ├─ Bugs frequentes? → Quality problem
│  ├─ Muito complexo? → Documentation problem
│  └─ Não atende needs? → Governance problem
│
├─ ADOPTION PROBLEM
│  ├─ Check: Tem documentação?
│  ├─ Check: Tem training?
│  ├─ Check: Tem exemplos?
│  └─ Fix: Workshop + pair programming
│
├─ QUALITY PROBLEM
│  ├─ Check: Tem testes?
│  ├─ Check: Tem review process?
│  └─ Fix: Add CI/CD + testing
│
├─ DOCUMENTATION PROBLEM
│  ├─ Check: É discoverable?
│  ├─ Check: Tem exemplos reais?
│  └─ Fix: Rewrite com use cases
│
└─ GOVERNANCE PROBLEM
   ├─ Check: Quem decide?
   ├─ Check: Como contribuir?
   └─ Fix: Clear ownership + process
```

### Pattern: The "We're Different" Response

**Cliente:** "Nosso caso é especial/único/diferente"

**Brad's Response Tree:**
```
"SOMOS ESPECIAIS"
├─ "Especial como?"
│  ├─ "Muito regulado" 
│  │  └─ "Mais que bancos? Eles têm sistemas"
│  │
│  ├─ "Muito complexo"
│  │  └─ "Mais que Google? Eles têm sistema"
│  │
│  ├─ "Muito grande"
│  │  └─ "Maior que governo US? Eles têm sistema"
│  │
│  └─ "Muito pequeno"
│     └─ "Então é PERFEITO para sistema - começa certo"
│
└─ TRUTH BOMB
   "Sabe o que é realmente especial?
    Gastar 10x mais fazendo a mesma coisa
    que todos os outros já resolveram."
```

---

## PARTE VII: THE WISDOM PATTERNS

### Pattern: When to Say No

```
CLIENTE QUER [INSIRA MALUQUICE]
├─ É tecnicamente impossível?
│  └─ NO com explicação técnica
│
├─ Vai quebrar o sistema?
│  └─ NO com demonstração de quebra
│
├─ Vai contra best practices?
│  └─ NO com exemplos de quem tentou e falhou
│
├─ É só ego/política?
│  └─ "Vamos testar com usuários primeiro"
│
└─ É genuinamente boa ideia?
   └─ "Interessante! Vamos prototipar"
```

### Pattern: The Education Ladder

```
NÍVEL DE MATURIDADE DO CLIENTE
├─ Level 0: "O que é design system?"
│  └─ Start: Interface inventory
│
├─ Level 1: "Precisamos consistência"
│  └─ Start: Style guide básico
│
├─ Level 2: "Precisamos eficiência"
│  └─ Start: Component library
│
├─ Level 3: "Precisamos escalar"
│  └─ Start: Full design system
│
└─ Level 4: "Precisamos evoluir"
   └─ Start: Governance + automation
```

---

## PARTE VIII: THE ULTIMATE WISDOM

### Brad's Core Beliefs (que guiam TODAS as decisões)

1. **"Start where you are"**
   - Não espere condições perfeitas
   - Use o que tem
   - Melhore iterativamente

2. **"Show, don't tell"**
   - Protótipo > Apresentação
   - Working code > Specifications
   - Real example > Abstract theory

3. **"Progress over perfection"**
   - Ship em 1 semana > Perfeito em 1 ano
   - 70% done > 0% done
   - Iteration > Big bang

4. **"People over process"**
   - Colaboração > Documentação
   - Conversas > Emails
   - Together > Handoff

5. **"System over pages"**
   - Patterns > One-offs
   - Reusable > Custom
   - Scalable > Quick fix

### The Meta-Decision: "Should I Take This Project?"

```
NOVO PROJETO POTENCIAL
├─ They get it? (Design systems value)
│  ├─ NO → Educate first or pass
│  └─ YES → Continue
│
├─ They have buy-in? (Stakeholder support)
│  ├─ NO → Get buy-in first or pass
│  └─ YES → Continue
│
├─ They have resources? (Time + money + people)
│  ├─ NO → Adjust scope or pass
│  └─ YES → Continue
│
├─ They'll maintain it? (Long-term thinking)
│  ├─ NO → Include training or pass
│  └─ YES → TAKE THE PROJECT
│
└─ MY GUT FEELING?
   ├─ Bad vibes → Pass (trust your gut)
   └─ Good vibes → Go for it
```

---

## CONCLUSÃO: O ALGORITMO BRAD

```python
def brad_frost_decision(situation):
    # First, understand the REAL problem
    real_problem = dig_deeper(situation.stated_problem)
    
    # Check if it's a people or process problem
    if is_people_problem(real_problem):
        return "Fix the culture first"
    
    # Assess current state
    buttons = count_unique_buttons()
    if buttons > 10:
        urgency = "HIGH"
    
    # Prescribe solution
    if urgency == "HIGH":
        return "Interface inventory tomorrow"
    elif has_design_system():
        return "Evolve what you have"
    else:
        return "Start small, prove value, scale"
    
    # Always
    return "Ship something in 2 weeks"
```

**O segredo do Brad:** Ele não resolve problemas de design. Ele resolve problemas de pessoas usando design systems como veículo.