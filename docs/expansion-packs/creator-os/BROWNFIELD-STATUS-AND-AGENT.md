# Brownfield Workflow: Agent e Status de Implementação

**Created:** 2025-10-18
**Question:** "Qual agente devo chamar para essa função? Por que o workflow dele ainda não está ativo de forma padrão?"

---

## 🎯 Resposta Direta

### Qual agente chamar?

**Agent:** `course-architect`

**Ativação:**
```bash
@course-architect
*continue-course didatica-lendaria
```

**Nota:** Você já ativou com `/CreatorOS:agents:course-architect`, então pode chamar diretamente `*continue-course`

---

## 🚧 Por Que o Workflow Brownfield NÃO Está Ativo por Padrão?

### Implementação Incremental (Story-Driven Development)

O brownfield workflow foi implementado em **fases** seguindo AIOS-FULLSTACK methodology:

```yaml
Epic 3: Intelligent Workflow System
├── Story 3.1 ✅ COMPLETE (Detection + Validation)
│   ├── Greenfield/Brownfield mode selection
│   ├── Folder existence validation
│   ├── Metadata persistence
│   └── Workflow branching
│
├── Story 3.2 ⏳ PLANNED (File Organization)
│   ├── Scan existing materials
│   ├── Categorize files (lessons, resources, etc.)
│   └── Organize into canonical structure
│
├── Story 3.3 ⏳ PLANNED (ICP Extraction)
│   ├── Extract target audience from content
│   ├── Identify archetypes and pain points
│   └── Auto-populate Section 2 in COURSE-BRIEF
│
└── Story 3.4 ⏳ PLANNED (Voice Pattern Extraction)
    ├── Analyze instructor voice from transcripts
    ├── Extract style markers and vocabulary
    └── Auto-populate Section 4 in COURSE-BRIEF
```

### Status Atual: Phase 1 Only

**O que funciona (Story 3.1 ✅):**
1. ✅ Sistema pergunta: "Greenfield ou Brownfield?"
2. ✅ Valida se folder existe
3. ✅ Salva metadata (`creation_mode: brownfield`)
4. ✅ Notifica usuário com próximos passos

**O que NÃO funciona (Stories 3.2-3.4 ⏳):**
1. ❌ Extração automática de materiais existentes
2. ❌ Auto-population do COURSE-BRIEF
3. ❌ File organization automática
4. ❌ ICP extraction de conteúdo existente
5. ❌ Voice pattern extraction de transcripts

### Por Que Essa Abordagem?

**Princípio: Ship Early, Iterate**

```markdown
Phase 1 (Shipped ✅):
- Detection básica funcional
- Usuário pode trabalhar manualmente (workaround)
- Valida se há demanda antes de construir extração complexa

Phase 2 (Backlog ⏳):
- Extração automática (complexa, 20-40h de dev)
- Só vale a pena se Phase 1 for usada frequentemente
- Evita over-engineering de features não-usadas
```

---

## 🔍 Análise Técnica: O Que Está Faltando?

### 1. Código Não Implementado

```bash
# Esperado (não existe):
expansion-packs/creator-os/lib/file_organizer.py     ❌
expansion-packs/creator-os/lib/icp_extractor.py      ❌
expansion-packs/creator-os/lib/voice_extractor.py    ❌

# Existente (parcial):
expansion-packs/creator-os/tasks/generate-course.md  ✅ (detection only)
expansion-packs/creator-os/agents/course-architect.md ✅ (orchestration only)
```

### 2. Workflow Atual (Workaround Manual)

```yaml
generate-course.md - Step 1.7 (Brownfield notification):

Message:
  "✓ Brownfield mode activated!

   📋 NEXT STEPS - Brownfield Workflow:

   **Phase 2: Material Extraction (Future Implementation)**

   For now (Phase 1 - Manual Path):
   1. Create COURSE-BRIEF.md manually   ← VOCÊ JÁ FEZ!
   2. Fill all sections                  ← VOCÊ JÁ FEZ!
   3. Run: *continue-course {slug}       ← PRÓXIMO PASSO
```

**Tradução:** Sistema detecta brownfield, mas você ainda preenche COURSE-BRIEF manualmente.

### 3. Por Que Não Ativar Automático?

**Razões técnicas e de produto:**

1. **Extração é Complexa (20-40h dev)**
   - NLP para identificar ICP em texto livre
   - Voice pattern analysis de transcrições
   - File categorization com ML/heurísticas
   - Validação de qualidade da extração

2. **Validação de Demanda Primeiro**
   - Se poucos cursos usam brownfield → não vale esforço
   - Phase 1 permite validar se feature é útil
   - Feedback real antes de investir 40h

3. **Workaround Manual Funciona**
   - Você já tem COURSE-BRIEF pronto (v3.0)
   - Extração automática seria legal, mas não blocker
   - Pode prosseguir com `*continue-course`

4. **Story-Driven Development Discipline**
   - Cada story é deployável isoladamente
   - Não criar features especulativas
   - Iterar baseado em uso real

---

## 📋 Para o Seu Caso: Didática Lendária

### Status Atual

```yaml
Folder: outputs/courses/didatica-lendaria/
Files:
  ✅ COURSE-BRIEF.md (completo, v3.0)
  ✅ resources/ (8 files)
     - checklist-aula-perfeita.md
     - template-estrutura-aula.md
     - template-gps.md
     - banco-reframes.md
     - exercicios-chatgpt.md
     - guia-arquetipos.md
     - mapa-mental.md
     - matriz-antidotos.md

Metadata: creation_mode = brownfield ✅ (adicionado)
```

### Você NÃO Precisa de Brownfield Extraction

**Por quê?**
- COURSE-BRIEF já está completo (v3.0) ✅
- Resources já estão organizados ✅
- ICP já está definido no brief ✅
- Voice já está definido (Adriano via MMOS) ✅

**O que a extração automática faria:**
- Ler arquivos existentes → Criar COURSE-BRIEF
- **Você já tem isso feito manualmente!**

### Próximo Passo: Pular para `continue-course`

```bash
@course-architect
*continue-course didatica-lendaria
```

**Isso vai:**
1. Ler COURSE-BRIEF.md (seu v3.0)
2. Gerar curriculum.yaml baseado nos 7 módulos
3. Gerar 36 aulas usando Checklist da Aula Perfeita
4. Aplicar voice do Adriano (MMOS clone mode)
5. Validar qualidade contra checklist
6. Salvar tudo em `lessons/modulo-{N}/`

---

## 🎯 Resumo Executivo

### Qual agente?
**`@course-architect`** com comando **`*continue-course didatica-lendaria`**

### Por que brownfield não está ativo?
**Implementação em fases:**
- Phase 1 ✅: Detection + Validation (pronto)
- Phase 2 ⏳: Extraction (planejado, não implementado)

**Razão de produto:**
- Validar demanda antes de construir extração complexa
- Workaround manual funciona (você já usou!)
- Ship early, iterate based on usage

### Você precisa esperar Phase 2?
**NÃO!** Seu COURSE-BRIEF já está pronto.

**Ação imediata:**
```bash
*continue-course didatica-lendaria
```

---

## 🔧 Se Quiser Implementar Brownfield Extraction

**Se houver demanda real, aqui está o roadmap:**

### Story 3.2: File Organization (8 pts, ~16h)
```python
# expansion-packs/creator-os/lib/file_organizer.py

class FileOrganizer:
    def scan(self, course_slug: str) -> FileInventory:
        """Scan existing materials"""

    def categorize(self, files: List[File]) -> Dict[Category, List[File]]:
        """Categorize by type (lesson, resource, asset)"""

    def organize(self, dry_run: bool = False) -> OrganizationPlan:
        """Move files to canonical structure"""
```

### Story 3.3: ICP Extraction (13 pts, ~26h)
```python
# expansion-packs/creator-os/lib/icp_extractor.py

class ICPExtractor:
    def extract_from_content(self, files: List[File]) -> ICP:
        """NLP to identify target audience"""

    def identify_archetypes(self, icp: ICP) -> List[Archetype]:
        """Pattern matching for archetypes"""

    def populate_brief_section_2(self, icp: ICP) -> str:
        """Generate Section 2 markdown"""
```

### Story 3.4: Voice Extraction (13 pts, ~26h)
```python
# expansion-packs/creator-os/lib/voice_extractor.py

class VoiceExtractor:
    def analyze_transcripts(self, files: List[Transcript]) -> VoiceProfile:
        """Extract style markers, vocabulary, patterns"""

    def calculate_fidelity(self, sample: str, profile: VoiceProfile) -> float:
        """Validate extracted voice accuracy"""

    def populate_brief_section_4(self, profile: VoiceProfile) -> str:
        """Generate Section 4 markdown"""
```

**Total Estimado:** 34 story points (~68 horas de desenvolvimento)

**Decisão de Produto:** Implementar só se houver 5+ casos de brownfield real

---

## 📚 Arquivos Relacionados

- [BROWNFIELD-WORKFLOW-GUIDE.md](./BROWNFIELD-WORKFLOW-GUIDE.md) - Guia completo
- [WORKFLOW-PRINCIPLES.md](./WORKFLOW-PRINCIPLES.md) - Princípios de workflow linear
- [Story 3.1](../stories/STORY-3.1-greenfield-brownfield-detection.md) - Implementação atual
- [Epic 3](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md) - Roadmap completo
- [generate-course.md](../tasks/generate-course.md) - Task definition
- [course-architect.md](../agents/course-architect.md) - Agent definition

---

**Conclusão:**
- **Agent:** course-architect
- **Command:** `*continue-course didatica-lendaria`
- **Brownfield extraction:** Planejado, não implementado (você não precisa!)
- **Razão:** Ship early, iterate. Phase 1 validou conceito, Phase 2 só vale se houver demanda real.
- **Seu status:** Pronto para prosseguir! 🚀

---

**Last Updated:** 2025-10-18
**Author:** Course Architect Agent
**Related:** Story 3.1, Epic 3
