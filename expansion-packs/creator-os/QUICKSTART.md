# CreatorOS - Quick Start

## Comandos Ultra-Simples para Criação de Cursos

### Criar Curso do Zero

```bash
@course-architect *new meu-curso
```

Isso é tudo! O sistema vai:
1. ✅ Criar estrutura de pastas
2. ✅ Gerar template COURSE-BRIEF.md
3. ⏸️ **PARAR** para você preencher o brief (15-60 min)
4. ✅ Gerar curriculum.yaml automaticamente
5. ⏸️ **PARAR** para você aprovar o currículo
6. ✅ Gerar TODAS as aulas (GPS + Didática Lendária)
7. ✅ Gerar quizzes e projeto final
8. ✅ Validar qualidade
9. ✅ Mostrar relatório completo

**Tempo total:** 20-60 min (incluindo seus inputs manuais)
**Custo estimado:** $1-25 USD (depende do tamanho do curso)

---

### Fazer Upgrade de Curso Existente

```bash
@course-architect *upgrade curso-antigo
```

O sistema vai:
1. ✅ Criar estrutura para materiais sourcess
2. ✅ Organizar seus arquivos antigos
3. ✅ Extrair ICP automaticamente (AI)
4. ✅ Extrair perfil de voz (AI)
5. ✅ Inferir objetivos de aprendizagem (AI)
6. ⏸️ **PARAR** para você preencher lacunas no brief
7. ✅ Gerar curriculum.yaml
8. ✅ Continua igual ao fluxo "criar do zero"

**Tempo total:** 30-90 min
**Automação:** ~60% preenchido automaticamente via AI

---

## Opções Avançadas

### Com Persona MMOS (voz autêntica)
```bash
@course-architect *new marketing-digital --mmos-persona adriano_de_marqui
```

### Pular Validação (modo rápido)
```bash
@course-architect *new curso-rapido --skip-validation
```

### Especificar Pasta de Origem (upgrade)
```bash
@course-architect *upgrade obsidian-curso --source-folder ~/Desktop/materiais-curso
```

---

## O Que Você Precisa Fazer

### Fluxo Greenfield (*new)

**Passo Manual 1: Preencher COURSE-BRIEF.md**
- Local: `outputs/courses/{slug}/COURSE-BRIEF.md`
- Tempo: 15-60 minutos
- Seções: 8 no total
  1. Basic Info (título, subtítulo, duração)
  2. ICP (público-alvo, dores, objetivos)
  3. Content & Pedagogy (objetivos de aprendizagem)
  4. Voice & Personality (tom, estilo)
  5. Format & Delivery (formato das aulas)
  6. Commercial (preço, receita)
  7. Success Metrics (KPIs)
  8. Constraints (limitações)

**Passo Manual 2: Aprovar Currículo**
- Local: `outputs/courses/{slug}/curriculum.yaml`
- Tempo: 5-15 minutos
- Decisão: Aprovar / Editar / Cancelar

**Passo Manual 3 (Opcional): Revisar e Finalizar**
- Revisar aulas geradas
- Completar scaffolds de quizzes (substituir [EDIT ME])
- Testar com estudantes beta

---

### Fluxo Brownfield (*upgrade)

**Passo Manual 1: Preencher Lacunas no COURSE-BRIEF**
- AI preenche ~60% automaticamente
- Você completa os 40% restantes
- Tempo: 20-45 minutos

**Passos 2-3:** Idênticos ao fluxo greenfield

---

## Estrutura de Saída

```
outputs/courses/{slug}/
├── COURSE-BRIEF.md          # 8 seções preenchidas
├── curriculum.yaml          # Estrutura do curso (módulos + aulas)
├── lessons/                 # Todas as aulas (markdown)
│   ├── 1.1-introducao.md   # GPS + Didática Lendária
│   ├── 1.2-conceitos.md
│   └── ...
├── assessments/             # Avaliações
│   ├── module-1-quiz.yaml  # Scaffolds (editar [EDIT ME])
│   ├── module-2-quiz.yaml
│   └── final-project.md    # Template pronto
└── validation-report.md     # Relatório de qualidade (opcional)
```

---

## Frameworks Pedagógicos Aplicados

### GPS Framework (Goal → Position → Steps)
- **Goal:** Objetivo de aprendizagem claro
- **Position:** Estado atual → estado desejado
- **Steps:** Passos acionáveis para alcançar o objetivo

### Didática Lendária (7 Elementos)
1. Hook/Introdução (gancho inicial)
2. Contexto (background necessário)
3. Conceito Central (explicação teórica)
4. Exemplos Concretos (casos práticos)
5. Exercício Prático (hands-on)
6. Armadilhas Comuns (pitfalls a evitar)
7. Resumo/Recap (consolidação)

### Bloom's Taxonomy
Progressão cognitiva:
- Módulos iniciais: Remember → Understand → Apply
- Módulos intermediários: Analyze
- Módulos finais: Evaluate → Create

---

## Validação de Qualidade

O sistema valida automaticamente:

✅ **GPS Structure:** ≥95% das aulas passam (≥30 pontos)
✅ **Didática Lendária:** ≥90% das aulas passam (≥70 pontos)
✅ **Voice Fidelity:** ≥85% (custom) ou ≥90% (MMOS)
✅ **Bloom's Progression:** Progressão válida
✅ **Duration Accuracy:** ±25% do target
✅ **Completeness:** 100% de arquivos gerados

---

## Resumo

**Para criar curso:**
```bash
@course-architect *new meu-curso
```

**Para fazer upgrade:**
```bash
@course-architect *upgrade curso-antigo
```

**Só isso!** 🚀

---

## Comandos Legados (DEPRECATED)

❌ ~~`*greenfield`~~ → Use `*new`
❌ ~~`*brownfield`~~ → Use `*upgrade`
❌ ~~`*generate-course`~~ → Use `*new` ou `*upgrade`

---

## Próximos Passos

1. Ative o agente: `@course-architect`
2. Digite: `*new nome-do-seu-curso`
3. Siga os prompts
4. Revise e publique!

**Documentação completa:** `expansion-packs/creator-os/docs/WORKFLOW-USAGE-GUIDE.md`
