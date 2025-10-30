# 📁 Análise da Estrutura Atual

## Estrutura BEFORE (Problemática)

```
mente_lendaria/
├── docs/                          ← QUASE VAZIO (1 arquivo)
│   ├── brownfield-architecture.md   ← Único arquivo raiz
│   ├── stories/                     ← Development stories (OK)
│   └── mmos/                        ← TUDO DO MMOS AQUI
│       ├── SQLite legado (migrado para Supabase em 2025-10)                    🚨 Database commitado
│       ├── logs/                      🚨 Logs commitados (868KB)
│       ├── docs/                      🚨 Aninhamento confuso!!!
│       │   ├── PRD.md
│       │   ├── DNA_MENTAL_METHODOLOGY.md
│       │   ├── OUTPUTS_GUIDE.md
│       │   ├── TOOLS_GUIDE.md
│       │   └── ... (14+ documentos)
│       ├── architecture/
│       ├── database/
│       ├── design/
│       ├── epics/
│       ├── reports/
│       ├── taxonomy/
│       ├── validations/
│       ├── stories/                    🚨 Duplicado com docs/stories?
│       └── *.md (7 arquivos soltos)
│
└── outputs/                       ← OUTPUTS GERADOS (OK)
    ├── courses/  (4 cursos)
    └── minds/    (38 minds)
```

## Problemas Identificados

### 🚨 Problema 1: Aninhamento Confuso `docs/mmos/docs/`

**Issue:** Caminho `docs/prd/mmos-prd.md` é semanticamente confuso.

**Por quê?**
- "docs" aparece 2x no path
- Usuário não sabe se está em "documentação" ou "documentação da documentação"
- Viola princípio DRY (Don't Repeat Yourself) semântico

**Impacto:**
- Dificulta onboarding
- Links quebrados em refactorings
- Navegação não intuitiva

---

### 🚨 Problema 2: docs/ Raiz Quase Vazio

**Issue:** `docs/` raiz tem apenas 1 arquivo (`brownfield-architecture.md`).

**Esperado:**
```
docs/
├── architecture/      ← Docs de arquitetura geral
├── guides/            ← User guides
├── prd/               ← Product requirements
└── README.md          ← Índice de documentação
```

**Atual:**
```
docs/
├── brownfield-architecture.md  ← Único arquivo
├── stories/                     ← Development stories
└── mmos/                        ← TODO do MMOS aqui
```

**Impacto:**
- Documentação geral do projeto não tem casa
- MMOS domina toda a estrutura docs/
- Difícil achar documentação não-MMOS

---

### 🚨 Problema 3: Database e Logs Commitados

**Issue:**
- `SQLite legado (migrado para Supabase em 2025-10)` (872KB) commitado no repo
- `docs/mmos/logs/` (868KB) commitado no repo

**Por quê está errado?**
- Databases são **artefatos gerados** (devem estar em `outputs/` ou `.gitignore`)
- Logs são **temporários** (devem estar em `.gitignore` ou `outputs/logs/`)
- Aumenta tamanho do repo desnecessariamente

**Decisão Necessária:**
- Mover `SQLite legado (migrado para Supabase em 2025-10)` para `SQLite legado (migrado para Supabase em 2025-10)`?
- Ou adicionar ao `.gitignore` e manter local?

---

### 🚨 Problema 4: Stories Duplicados?

**Issue:** Existem dois diretórios de stories:
- `docs/stories/` (development stories gerais)
- `docs/mmos/stories/` (MMOS-specific stories)

**Está correto?**
- ✅ Se são **propósitos diferentes** (geral vs MMOS)
- ❌ Se são **mesma coisa** (duplicação)

**Requer Verificação:**
```bash
ls docs/stories/
ls docs/mmos/stories/
# Comparar conteúdo
```

---
