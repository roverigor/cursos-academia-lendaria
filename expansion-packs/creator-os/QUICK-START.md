# CreatorOS - Quick Start Guide

**Status:** Epic 3 Complete - Intelligent Workflow System
**Last Updated:** 2025-10-18

---

## 🚀 Criar um Curso em 3 Comandos

### Workflow Completo (Greenfield - Do Zero)

```bash
# 1. Inicializar curso
cd expansion-packs/creator-os
python scripts/init_course.py

# Responda interativamente:
#   - Course slug: meu-curso
#   - Mode: 1 (Greenfield)
#   - MMOS persona: yes/no

# 2. Preencher COURSE-BRIEF.md
vim outputs/courses/meu-curso/COURSE-BRIEF.md

# 3. Gerar curriculum.yaml
python scripts/generate_curriculum.py meu-curso

# 4. Revisar curriculum.yaml (opcional - editar se necessário)
vim outputs/courses/meu-curso/curriculum.yaml

# 5. Gerar curso completo
python scripts/generate_course.py meu-curso
```

**Tempo total:** ~30-60 minutos (dependendo do tamanho do curso)

---

## 📁 Workflow Brownfield (Migrar Curso Existente)

```bash
# 1. Criar pasta e adicionar materiais existentes
mkdir -p outputs/courses/meu-curso-antigo
cp -r /caminho/materiais-antigos/* outputs/courses/meu-curso-antigo/

# 2. Inicializar e organizar
python scripts/init_course.py

# Responda interativamente:
#   - Course slug: meu-curso-antigo
#   - Mode: 2 (Brownfield)
#   - Confirmar organização de arquivos: yes
#   - O script verifica /sources/videos, converte para MP3 e gera
#     transcrições lesson1/lesson2 automaticamente (requer ffmpeg +
#     variável ASSEMBLYAI_API_KEY configurada)

# 3. Auto-extrair conteúdo (ICP, voz, objetivos)
python lib/icp_extractor.py meu-curso-antigo
python lib/voice_extractor.py meu-curso-antigo
python lib/objectives_inferencer.py meu-curso-antigo

# 4. Preencher lacunas no COURSE-BRIEF.md
vim outputs/courses/meu-curso-antigo/COURSE-BRIEF.md

# 5. Gerar curriculum.yaml
python scripts/generate_curriculum.py meu-curso-antigo

# 6. Revisar e ajustar curriculum.yaml se necessário
vim outputs/courses/meu-curso-antigo/curriculum.yaml

# 7. Gerar curso completo
python scripts/generate_course.py meu-curso-antigo
```

---

## 🛠️ Comandos Úteis

### Gerar Curriculum

```bash
# Criar curriculum.yaml do zero
python scripts/generate_curriculum.py <course-slug>

# Sobrescrever curriculum.yaml existente
python scripts/generate_curriculum.py <course-slug> --force
```

### Validar Curso

```bash
python lib/course_validator.py <course-slug>
```

### Gerar Apenas Assessments

```bash
python lib/assessment_generator.py <course-slug>
```

### Resumir Geração Interrompida

```bash
# Se você pressionou CTRL+C durante a geração
python scripts/generate_course.py <course-slug> --resume
```

**✅ Novo:** Resume agora funciona completamente! Retoma de onde parou.

### Recomeçar do Zero (Ignorar Checkpoints)

```bash
python scripts/generate_course.py <course-slug> --force
```

---

## 📊 Estrutura de Pastas Gerada

```
outputs/courses/meu-curso/
├── COURSE-BRIEF.md          # Brief preenchido (8 seções)
├── curriculum.yaml          # Curriculum aprovado
├── course-outline.md        # Outline gerado
├── lessons/                 # Aulas GPS + Didática Lendária
│   ├── 1.1-intro.md
│   ├── 1.2-conceitos.md
│   └── ...
├── assessments/             # Avaliações
│   ├── quiz-module-1.yaml   # (⚠️ Scaffold - edição manual necessária)
│   ├── quiz-module-2.yaml
│   └── final-project.md     # (✅ Pronto para uso)
└── .state/                  # Checkpoints (auto-removidos ao completar)
```

---

## 🎯 Pedagogical Frameworks Aplicados

Toda aula gerada segue:

1. **GPS Framework** (Goal → Position → Steps)
   - G: Promessa clara (30-60s)
   - P: Empatia e validação (60-90s)
   - S: Conteúdo técnico estruturado

2. **Didática Lendária** (7 Elementos)
   - Hook Emocional
   - Conceitos Primordiais
   - Link de Transição
   - Pergunta Reflexiva
   - Analogias/Diagramas
   - Revisão Estruturada
   - Ação Rápida (2 min)

3. **Validação Automática**
   - GPS: 30 pontos (10 por seção) - MUST PASS
   - DL: 100 pontos (70+ threshold) - MUST PASS
   - Voice Fidelity: 85-95% (se MMOS ativado)

**Retry Logic:** Aulas que falham validação são regeneradas até 3x com feedback específico.

---

## ⚠️ Limitações Conhecidas (MVP)

### Assessment Generation (Story 3.14)

**Status:** MVP - Scaffolds only

Quizzes gerados contêm **placeholders `[EDIT ME]`** que precisam ser preenchidos manualmente.

**O que funciona:**
- ✅ Estrutura YAML correta
- ✅ Perguntas vinculadas a objetivos de aprendizado
- ✅ Template de projeto final (production-ready)

**O que NÃO funciona (ainda):**
- ❌ Geração automática de cenários realistas (requer IA)
- ❌ Criação de distratores baseados em misconceptions
- ❌ Alinhamento automático com taxonomia de Bloom

**Roadmap:** Epic 4 terá geração completa de assessments com IA.

---

## 🔧 Troubleshooting

### "Workflow is broken / não funciona"

**Problema:** Tasks (`.md` files) têm pseudocódigo Python que não executa.

**Solução:** Use os scripts Python reais:
- `scripts/init_course.py` - Inicializar
- `scripts/generate_course.py` - Gerar curso completo

### "API error / OpenAI failed"

**Problema:** Voice extraction ou lesson generation precisa de OpenAI API.

**Fallback automático:**
- Voice extraction usa **rule-based extraction** se API falhar
- Lesson generation usa **mock content** (para testes)

**Solução produção:** Configure `OPENAI_API_KEY` environment variable.

### "GPS validation failed"

**Problema:** Aula gerada não tem estrutura G-P-S completa.

**O que acontece:** Retry automático (até 3x) com feedback específico ao AI.

**Se persiste:** Bug no template ou AI model. Reporte issue.

### "File organization failed"

**Problema:** Brownfield não conseguiu organizar arquivos.

**Solução:** Organize manualmente:
```bash
mkdir -p outputs/courses/<slug>/sources/transcripts
mkdir -p outputs/courses/<slug>/sources/videos
# Move files to appropriate folders
```

---

## 📞 Support

**Issues:** https://github.com/anthropics/claude-code/issues
**Documentation:** `docs/` directory
**Story Reference:** `expansion-packs/creator-os/stories/STORY-3.*.md`

---

## 🎓 Next Steps After Course Generation

1. **Review Lessons**
   - Check GPS structure
   - Verify voice fidelity
   - Test with sample students

2. **Edit Assessments**
   - Replace all `[EDIT ME]` placeholders in quizzes
   - Customize final project rubric

3. **Quality Validation**
   ```bash
   python lib/course_validator.py <course-slug>
   ```

4. **Iterate**
   - Use feedback to improve
   - Re-generate specific lessons if needed
   - Update curriculum.yaml and regenerate

---

**Last Updated:** 2025-10-18
**Version:** Epic 3 Complete (13/13 stories)
