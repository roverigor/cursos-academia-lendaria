# 🔀 Plano de Migração

## Fase 1: Extrair Documentação de docs/mmos/docs/ → docs/

### 1.1 Mover PRDs

```bash
# Criar diretório prd/
mkdir -p docs/prd/

# Mover PRD do MMOS
mv docs/prd/mmos-prd.md docs/prd/mmos-prd.md

# Atualizar referências
grep -r "docs/prd/mmos-prd.md" . --include="*.md" | cut -d: -f1 | \
  xargs sed -i '' 's|docs/prd/mmos-prd.md|docs/prd/mmos-prd.md|g'
```

### 1.2 Mover Metodologias

```bash
# Criar diretório methodology/
mkdir -p docs/methodology/

# Mover documentos de metodologia
mv docs/methodology/dna-mental.md docs/methodology/dna-mental.md
mv docs/methodology/prompt-engineering.md docs/methodology/prompt-engineering.md
mv docs/methodology/tools-guide.md docs/methodology/tools-guide.md

# Atualizar referências
find . -name "*.md" -exec sed -i '' 's|docs/methodology/dna-mental.md|docs/methodology/dna-mental.md|g' {} \;
find . -name "*.md" -exec sed -i '' 's|docs/methodology/prompt-engineering.md|docs/methodology/prompt-engineering.md|g' {} \;
```

### 1.3 Mover Workflows

```bash
# Criar diretório workflows dentro de mmos/
mkdir -p docs/mmos/workflows/

# Mover workflows de docs/mmos/docs/ para docs/mmos/workflows/
mv docs/mmos/workflows/aios-workflow.md docs/mmos/workflows/aios-workflow.md
mv docs/mmos/workflows/brownfield-workflow.md docs/mmos/workflows/brownfield-workflow.md
mv docs/mmos/workflows/brownfield-migration-workflow.md docs/mmos/workflows/brownfield-migration.md
mv docs/mmos/workflows/parallel-collection-guide.md docs/mmos/workflows/parallel-collection.md
mv docs/mmos/workflows/private-individual-workflow-proposal.md docs/mmos/workflows/private-individual.md
mv docs/mmos/workflows/private-individual-simplified.md docs/mmos/workflows/private-individual-simplified.md
mv docs/mmos/workflows/workflow-matrix-decision.md docs/mmos/workflows/workflow-matrix-decision.md

# Atualizar referências
find . -name "*.md" -exec sed -i '' 's|docs/mmos/workflows/aios-workflow.md|docs/mmos/workflows/aios-workflow.md|g' {} \;
# ... (repetir para outros)
```

### 1.4 Mover Guides Gerais

```bash
# Criar diretório guides/
mkdir -p docs/guides/

# Mover guias
mv docs/guides/outputs-guide.md docs/guides/outputs-guide.md
mv docs/guides/folder-structure.md docs/guides/folder-structure.md

# Se houver integration guides específicos:
mv docs/guides/integration-etl-mmos.md docs/mmos/integration-etl.md
```

### 1.5 Mover Arquivo Raiz

```bash
# Mover brownfield para architecture/
mkdir -p docs/architecture/
mv docs/brownfield-architecture.md docs/architecture/brownfield-analysis.md
```

### 1.6 Remover docs/mmos/docs/ Vazio

```bash
# Verificar se vazio
ls -la docs/mmos/docs/

# Se vazio, remover
rmdir docs/mmos/docs/

# Ou se restarem apenas stage-guides, research, etc:
# Mover para docs/mmos/ diretamente
mv docs/mmos/docs/stage-guides docs/mmos/
mv docs/mmos/docs/research docs/mmos/
```

---

## Fase 2: Mover Database e Logs para outputs/

### 2.1 Mover Database

```bash
# Criar diretório database em outputs/
mkdir -p outputs/database/

# Mover database
mv SQLite legado (migrado para Supabase em 2025-10) SQLite legado (migrado para Supabase em 2025-10)

# Atualizar referências em scripts
find scripts/ -name "*.js" -o -name "*.sh" | \
  xargs sed -i '' 's|SQLite legado (migrado para Supabase em 2025-10)|SQLite legado (migrado para Supabase em 2025-10)|g'

# Atualizar em expansion packs
find expansion-packs/ -name "*.md" -o -name "*.js" | \
  xargs sed -i '' 's|SQLite legado (migrado para Supabase em 2025-10)|SQLite legado (migrado para Supabase em 2025-10)|g'
```

### 2.2 Mover Logs

```bash
# Criar diretório logs em outputs/
mkdir -p outputs/logs/mmos/

# Mover logs
mv docs/mmos/logs/* outputs/logs/mmos/

# Remover diretório vazio
rmdir docs/mmos/logs/

# Atualizar .gitignore
echo "outputs/logs/*" >> .gitignore
echo "outputs/database/*.db" >> .gitignore
echo "!outputs/logs/.gitkeep" >> .gitignore
echo "!outputs/database/.gitkeep" >> .gitignore

# Criar .gitkeep
touch outputs/logs/.gitkeep
touch outputs/database/.gitkeep
```

---

## Fase 3: Criar Índices de Navegação

### 3.1 docs/README.md

```bash
cat > docs/README.md <<'EOF'
# 📚 Documentação - Mente Lendária

**Índice Master de toda a documentação do projeto**

---

# 🏗️ Arquitetura

- [System Overview](architecture/system-overview.md)
- [Expansion Packs](architecture/expansion-packs.md)
- [Data Flow](architecture/data-flow.md)
- [Brownfield Analysis](architecture/brownfield-analysis.md)

# 📚 Guias

- [Getting Started](guides/getting-started.md)
- [Developer Guide](guides/developer-guide.md)
- [Contributor Guide](guides/contributor-guide.md)
- [Outputs Guide](guides/outputs-guide.md)
- [Folder Structure](guides/folder-structure.md)

# 📋 PRDs (Product Requirements)

- [MMOS Mind Mapper](prd/mmos-prd.md)
- [CreatorOS](prd/creator-os-prd.md)
- [InnerLens](prd/innerlens-prd.md)

# 🧠 Metodologias

- [DNA Mental](methodology/dna-mental.md)
- [Prompt Engineering](methodology/prompt-engineering.md)
- [Cognitive Mapping](methodology/cognitive-mapping.md)
- [Tools Guide](methodology/tools-guide.md)

# 📖 Development Stories

Ver: [docs/stories/](stories/)

# 🧬 MMOS System Docs

Ver: [docs/mmos/README.md](mmos/README.md)

---

**Estrutura:**
- `architecture/` - Documentação de arquitetura do sistema
- `guides/` - User e developer guides
- `prd/` - Product requirement documents
- `methodology/` - Metodologias e frameworks
- `stories/` - Development stories (AIOS-wide)
- `mmos/` - MMOS-specific system documentation
EOF
```

### 3.2 docs/mmos/README.md

```bash
cat > docs/mmos/README.md <<'EOF'
# 🧬 MMOS - Mind Mapper OS

**Sistema de mapeamento cognitivo e criação de clones de IA**

---

# 📁 Estrutura

- `architecture/` - System architecture docs
- `database/` - Database schema & migrations
- `design/` - Design decisions & RFCs
- `epics/` - MMOS-specific epics
- `reports/` - Executive reports & analytics
- `taxonomy/` - Classification systems
- `validations/` - Validation checklists
- `qa/` - Quality benchmarks
- `workflows/` - MMOS operational workflows

# 🔗 Links Rápidos

## Documentação Core
- [PRD](../prd/mmos-prd.md)
- [DNA Mental Methodology](../methodology/dna-mental.md)
- [Prompt Engineering Guide](../methodology/prompt-engineering.md)

## Workflows
- [AIOS Workflow](workflows/aios-workflow.md)
- [Brownfield Workflow](workflows/brownfield-workflow.md)
- [Parallel Collection](workflows/parallel-collection.md)
- [Private Individual Workflow](workflows/private-individual.md)

## Architecture
- [Clone Authenticity Tiers](CLONE_AUTHENTICITY_TIERS.md)
- [APEX Algorithm](APEX_ALGORITHM_V2_CORRECTION.md)
- [Architecture Rules](ARCHITECTURE_RULES.md)

# 🗄️ Database

Ver: `SQLite legado (migrado para Supabase em 2025-10)` (gerado)

# 📊 Logs

Ver: `outputs/logs/mmos/` (gerados)

---

**Nota:** Este diretório contém documentação do **sistema MMOS**. Para artefatos gerados (minds processados), ver `outputs/minds/`.
EOF
```

---

## Fase 4: Atualizar Referências

```bash
# Script de atualização em massa
#!/bin/bash
# update-doc-refs.sh

echo "Atualizando referências de documentação..."

# Atualizar referências em README.md raiz
sed -i '' 's|docs/prd/mmos-prd.md|docs/prd/mmos-prd.md|g' README.md
sed -i '' 's|docs/methodology/dna-mental.md|docs/methodology/dna-mental.md|g' README.md

# Atualizar em expansion packs
find expansion-packs/ -name "*.md" -exec sed -i '' \
  's|docs/mmos/docs/|docs/methodology/|g' {} \;

# Atualizar em .aios-core
find .aios-core/ -name "*.md" -exec sed -i '' \
  's|docs/mmos/docs/|docs/methodology/|g' {} \;

# Atualizar em .claude/CLAUDE.md
sed -i '' 's|docs/mmos/docs/|docs/methodology/|g' .claude/CLAUDE.md

echo "✅ Referências atualizadas!"
```

---
