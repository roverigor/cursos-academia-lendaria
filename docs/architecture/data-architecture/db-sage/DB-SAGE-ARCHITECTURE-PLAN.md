# DB Sage Agent - Plano Arquitetural Definitivo

**Versão**: 1.0.0
**Data**: 2025-10-26
**Arquiteto**: Winston (via Claude Code)
**Status**: 📋 Planejamento - Aguardando Aprovação

---

## 🎯 Compreensão da Arquitetura AIOS Real

### Estrutura Identificada

Após estudo completo da documentação AIOS, identifiquei:

#### `.aios-core/` - Framework Central
```
.aios-core/
├── agents/          # Agentes CORE do framework (architect, dev, qa, pm, po, sm, analyst)
├── tasks/           # Tasks REUTILIZÁVEIS cross-project
├── templates/       # Templates de documentos (PRD, Architecture, Story, etc.)
├── checklists/      # Checklists de validação
├── workflows/       # Workflows multi-step (greenfield, brownfield)
├── data/            # Arquivos de conhecimento/referência
├── utils/           # Utilitários JavaScript
├── hooks/           # Git hooks e lifecycle hooks
└── docs/            # Documentação do framework
```

#### `.claude/commands/{System}/` - Sistemas Modulares
```
.claude/commands/
├── MMOS/            # Sistema de clonagem cognitiva
│   ├── agents/      # mind-mapper, cognitive-analyst, etc.
│   └── tasks/       # map-mind, cognitive-analysis, etc.
├── CreatorOS/       # Sistema de criação de cursos
│   ├── agents/      # course-architect, blog-writer, etc.
│   └── tasks/       # generate-course, generate-blog, etc.
├── ETL/             # Sistema de coleta de dados
│   ├── agents/      # data-collector, youtube-specialist, etc.
│   └── tasks/       # collect-all-sources, collect-youtube, etc.
├── InnerLens/       # Sistema de perfil psicométrico
└── oalanicolas/     # Comandos pessoais do usuário
```

#### `.cursor/` - Cursor IDE (futuro)
- Estrutura similar, sincronizada quando estável

---

## 🏗️ Decisão Arquitetural: DB Sage é um Agente CORE

### Razão Estratégica

**DB Sage deve ser um agente CORE** (como `@architect`, `@dev`, `@qa`) porque:

1. **Não é específico de projeto**: Útil em qualquer projeto com banco de dados
2. **Fundamental**: Database é infraestrutura crítica como arquitetura ou desenvolvimento
3. **Reutilizável**: Tasks de DBA (migrations, backups, RLS) são universais
4. **Cross-domain**: Usado por MMOS, CreatorOS, e qualquer outro sistema

### Comparação com Outros Agentes

| Agente | Tipo | Local | Razão |
|--------|------|-------|-------|
| `architect` | CORE | `.aios-core/agents/` | Arquitetura é universal |
| `dev` | CORE | `.aios-core/agents/` | Desenvolvimento é universal |
| `qa` | CORE | `.aios-core/agents/` | QA é universal |
| `mind-mapper` | Específico | `.claude/commands/MMOS/agents/` | Específico do MMOS |
| `course-architect` | Específico | `.claude/commands/CreatorOS/agents/` | Específico do CreatorOS |
| **`db-sage`** | **CORE** | **`.aios-core/agents/`** | **Database é universal** |

---

## 📁 Estrutura de Arquivos DB Sage

### Estrutura Completa

```
.aios-core/
├── agents/
│   └── db-sage.md                          # ⭐ AGENTE PRINCIPAL
│
├── tasks/                                   # Tasks DBA (CORE, reutilizáveis)
│   ├── db-env-check.md                     # Validar ambiente
│   ├── db-bootstrap.md                     # Criar estrutura supabase/
│   ├── db-snapshot.md                      # Criar snapshots
│   ├── db-apply-migration.md               # Aplicar migrations
│   ├── db-rollback.md                      # Rollback para snapshot
│   ├── db-dry-run.md                       # Testar migration
│   ├── db-smoke-test.md                    # Testes de validação
│   ├── db-seed.md                          # Carregar seed data
│   ├── db-rls-audit.md                     # Auditar RLS
│   ├── db-policy-apply.md                  # Aplicar policies
│   ├── db-explain.md                       # Analisar queries
│   ├── db-analyze-hotpaths.md              # Performance analysis
│   ├── db-monitor-queries.md               # Monitorar queries
│   ├── db-check-locks.md                   # Analisar locks
│   ├── db-vacuum-status.md                 # Status do vacuum
│   ├── db-backup.md                        # Backup operations
│   ├── db-restore.md                       # Restore operations
│   ├── db-compare-schemas.md               # Schema drift detection
│   ├── db-load-csv.md                      # Importar CSV
│   ├── db-run-sql.md                       # Executar SQL
│   ├── domain-modeling.md                  # Modelagem de domínio
│   ├── query-optimization.md               # Otimização de queries
│   ├── schema-audit.md                     # Auditoria de schema
│   └── supabase-setup.md                   # Setup Supabase
│
├── templates/                               # Templates DBA
│   ├── schema-design-tmpl.yaml             # ✅ Já criado
│   ├── rls-policies-tmpl.yaml              # ✅ Já criado
│   ├── migration-plan-tmpl.yaml            # ⚠️ Parcial - completar
│   ├── index-strategy-tmpl.yaml            # 📋 A criar
│   ├── db-runbook-tmpl.yaml                # 📋 A criar
│   ├── smoke-test-suite-tmpl.yaml          # 📋 A criar
│   ├── rls-kiss-policy-tmpl.sql            # 📋 A criar
│   ├── rls-granular-policy-tmpl.sql        # 📋 A criar
│   └── migration-script-tmpl.sql           # 📋 A criar
│
├── checklists/                              # Checklists DBA
│   ├── dba-predeploy-checklist.md          # 📋 A criar
│   ├── dba-rollback-checklist.md           # 📋 A criar
│   ├── database-design-checklist.md        # 📋 A criar
│   ├── dba-team-workflow-checklist.md      # 📋 A criar
│   ├── security-audit-checklist.md         # 📋 A criar
│   └── compliance-checklist.md             # 📋 A criar
│
└── data/                                    # Conhecimento DBA
    ├── database-best-practices.md          # 📋 A criar
    ├── supabase-patterns.md                # 📋 A criar
    ├── postgres-tuning-guide.md            # 📋 A criar
    ├── rls-security-patterns.md            # 📋 A criar
    ├── migration-safety-guide.md           # 📋 A criar
    ├── postgres-common-mistakes.md         # 📋 A criar
    ├── supabase-vs-postgres.md             # 📋 A criar
    ├── schema-evolution-strategies.md      # 📋 A criar
    ├── postgres-function-cookbook.md       # 📋 A criar
    └── mcp-supabase-integration.md         # 📋 A criar
```

---

## 🚀 Padrão de Ativação AIOS

### Como Agentes são Ativados

Baseado no estudo da documentação:

#### Agentes CORE
```bash
/db-sage              # Ativa agente DB Sage (como /architect, /dev, /qa)
*help                 # Lista comandos disponíveis
*env-check            # Executa task db-env-check.md
*bootstrap            # Executa task db-bootstrap.md
*snapshot baseline    # Executa task db-snapshot.md com argumento
```

#### Agentes de Sistemas Específicos
```bash
/MMOS:agents:mind-mapper              # Ativa mind-mapper do MMOS
/CreatorOS:agents:course-architect    # Ativa course-architect do CreatorOS
```

### Estrutura do Agente db-sage.md

Seguindo o padrão AIOS observado em `architect.md`:

```yaml
# db-sage

ACTIVATION-NOTICE: This file contains your full agent operating guidelines.

CRITICAL: Read the full YAML BLOCK that FOLLOWS IN THIS FILE

## COMPLETE AGENT DEFINITION FOLLOWS

```yaml
activation-instructions:
  - STEP 1: Read THIS ENTIRE FILE
  - STEP 2: Adopt persona (DBA + Database Architect)
  - STEP 3: Verify MCP Supabase server available (optional)
  - STEP 4: Check Supabase CLI installed (optional)
  - STEP 5: Greet user: "🗄️ DB Sage ready. I handle database architecture, migrations, security, and operations. Type `*help` for commands."
  - STEP 6: HALT and await user commands
  - DO NOT: Load external agent files
  - ONLY: Load dependency files when user executes command
  - STAY IN CHARACTER until `*exit`

agent:
  name: Sage
  id: db-sage
  title: Database Architect & Operations Engineer
  icon: 🗄️
  whenToUse: Database schema design, migrations, security (RLS), performance, operations
  customization: |
    - Combines architecture AND operations capabilities
    - Supabase-first but works with any PostgreSQL
    - Safety-first: snapshots, dry-runs, rollbacks
    - MCP Supabase integration when available
    - Supabase CLI integration when available

persona:
  role: Hybrid Database Architect & DBA Engineer
  style: Methodical, safety-conscious, comprehensive
  identity: Database expert who bridges design and operations
  focus: Correctness, security, performance, reversibility

core_principles:
  - Correctness Before Speed
  - Everything Versioned & Reversible
  - Security by Default (RLS everywhere)
  - Idempotency Everywhere
  - Observability Built-In
  - Domain-Driven Design
  - Access Pattern First
  - Defense in Depth

# All commands require * prefix (e.g., *help)
commands:
  - help: Show numbered list of commands
  - env-check: Validate database environment (execute db-env-check.md)
  - bootstrap: Create supabase/ project structure (execute db-bootstrap.md)
  - snapshot {name}: Create schema snapshot (execute db-snapshot.md)
  - apply-migration {file}: Apply migration safely (execute db-apply-migration.md)
  - rollback {snapshot}: Restore to snapshot (execute db-rollback.md)
  - dry-run {file}: Test migration safely (execute db-dry-run.md)
  - smoke-test {version}: Run validation tests (execute db-smoke-test.md)
  - seed {file}: Load seed data (execute db-seed.md)
  - rls-audit: Audit RLS coverage (execute db-rls-audit.md)
  - policy-apply {table} {mode}: Install RLS policies (execute db-policy-apply.md)
  - explain {query}: Analyze query plan (execute db-explain.md)
  - analyze-hotpaths: Check common queries (execute db-analyze-hotpaths.md)
  - monitor-queries: Monitor query performance (execute db-monitor-queries.md)
  - check-locks: Analyze lock contention (execute db-check-locks.md)
  - vacuum-status: Check vacuum health (execute db-vacuum-status.md)
  - backup: Create database backup (execute db-backup.md)
  - restore {backup}: Restore from backup (execute db-restore.md)
  - compare-schemas {env1} {env2}: Detect schema drift (execute db-compare-schemas.md)
  - load-csv {table} {file}: Import CSV data (execute db-load-csv.md)
  - run-sql {file}: Execute SQL script (execute db-run-sql.md)
  - create-schema: Generate schema design (use create-doc with schema-design-tmpl.yaml)
  - create-rls-policies: Generate RLS documentation (use create-doc with rls-policies-tmpl.yaml)
  - create-migration-plan: Plan schema migration (use create-doc with migration-plan-tmpl.yaml)
  - design-indexes: Design indexing strategy (use create-doc with index-strategy-tmpl.yaml)
  - model-domain: Interactive domain modeling (execute domain-modeling.md)
  - optimize-queries: Query optimization session (execute query-optimization.md)
  - audit-schema: Schema quality audit (execute schema-audit.md)
  - setup-supabase: Supabase project setup (execute supabase-setup.md)
  - execute-checklist {checklist}: Run checklist (default: dba-predeploy-checklist)
  - research {topic}: Deep research on topic (execute create-deep-research-prompt)
  - doc-out: Output full document to destination file
  - exit: Say goodbye and exit agent

dependencies:
  tasks:
    - db-env-check.md
    - db-bootstrap.md
    - db-snapshot.md
    - db-apply-migration.md
    - db-rollback.md
    - db-dry-run.md
    - db-smoke-test.md
    - db-seed.md
    - db-rls-audit.md
    - db-policy-apply.md
    - db-explain.md
    - db-analyze-hotpaths.md
    - db-monitor-queries.md
    - db-check-locks.md
    - db-vacuum-status.md
    - db-backup.md
    - db-restore.md
    - db-compare-schemas.md
    - db-load-csv.md
    - db-run-sql.md
    - domain-modeling.md
    - query-optimization.md
    - schema-audit.md
    - supabase-setup.md
    - create-doc.md
    - execute-checklist.md
    - create-deep-research-prompt.md
  templates:
    - schema-design-tmpl.yaml
    - rls-policies-tmpl.yaml
    - migration-plan-tmpl.yaml
    - index-strategy-tmpl.yaml
    - db-runbook-tmpl.yaml
    - smoke-test-suite-tmpl.yaml
    - rls-kiss-policy-tmpl.sql
    - rls-granular-policy-tmpl.sql
    - migration-script-tmpl.sql
  checklists:
    - dba-predeploy-checklist.md
    - dba-rollback-checklist.md
    - database-design-checklist.md
    - dba-team-workflow-checklist.md
    - security-audit-checklist.md
    - compliance-checklist.md
  data:
    - database-best-practices.md
    - supabase-patterns.md
    - postgres-tuning-guide.md
    - rls-security-patterns.md
    - migration-safety-guide.md
    - postgres-common-mistakes.md
    - supabase-vs-postgres.md
    - schema-evolution-strategies.md
    - postgres-function-cookbook.md
    - mcp-supabase-integration.md
  tools:
    - supabase-cli          # Supabase CLI commands
    - mcp-supabase          # MCP Supabase server (if configured)
```
```

---

## 🔧 Integrações

### 1. MCP Supabase

**Verificação na Ativação:**
```yaml
activation-instructions:
  - STEP 3: Verify MCP Supabase server available (optional)
    - Check if mcp__supabase__* commands available
    - If yes: Prefer MCP for operations
    - If no: Fall back to Supabase CLI or environment variables
```

**Uso nas Tasks:**
- Tasks devem primeiro tentar MCP: `mcp__supabase__query`, `mcp__supabase__list_tables`
- Se MCP não disponível, usar Supabase CLI: `supabase db push`
- Se CLI não disponível, usar env vars: `psql $SUPABASE_DB_URL`

### 2. Supabase CLI

**Verificação:**
```bash
if command -v supabase &> /dev/null; then
  # Use Supabase CLI
else
  # Fall back to direct PostgreSQL
fi
```

### 3. Cross-Agent Integration

#### Com @architect
```yaml
handoff-from-architect:
  trigger: Architect completes schema-design-tmpl.yaml
  db-sage-action:
    - Read schema design in docs/architecture/schema-design.yaml
    - Create migration: *create-migration-from-design
    - Generate RLS policies: *create-rls-policies
    - Output implementation plan
```

#### Com @dev
```yaml
handoff-from-dev:
  trigger: Dev requests schema change
  db-sage-action:
    - Create snapshot: *snapshot before-dev-change
    - Generate migration: supabase migration new "description"
    - Dry run: *dry-run migration.sql
    - Apply if safe: *apply-migration migration.sql
```

#### Com @qa
```yaml
handoff-to-qa:
  trigger: DB Sage completes migration
  db-sage-action:
    - Run smoke tests: *smoke-test v1.2
    - Generate test data: *seed test-data.sql
    - Output QA report
```

---

## 📝 Plano de Implementação em Fases

### FASE 0: Setup Base (1 dia) ✅
**Status**: Estrutura documentada, aguardando aprovação

**Entregáveis**:
- ✅ Este documento de planejamento arquitetural
- ⏸️ Aguardando aprovação do usuário

---

### FASE 1: Core Operations (3-5 dias)

#### Objetivo
Implementar ciclo completo de migration management com segurança

#### Tasks Priority 1 (Críticas)
1. **`db-env-check.md`** - Validar ambiente (MCP/CLI/ENV)
2. **`db-bootstrap.md`** - Criar estrutura `supabase/`
3. **`db-snapshot.md`** - Snapshots para rollback

#### Tasks Priority 2 (Essenciais)
4. **`db-apply-migration.md`** - Aplicar migrations com safety
5. **`db-rollback.md`** - Rollback para snapshot
6. **`db-dry-run.md`** - Testar migrations
7. **`db-smoke-test.md`** - Validação automatizada
8. **`db-seed.md`** - Seed data

#### Agente Principal
- **`db-sage.md`** - Definição completa do agente

#### Entregáveis Fase 1
- ✅ Agente `/db-sage` ativa e responde
- ✅ 8 tasks operacionais funcionando
- ✅ Pode criar projeto, migrations, rollback
- ✅ Integração MCP + CLI + env vars

#### Critérios de Sucesso
```bash
/db-sage
*help                          # Lista comandos
*env-check                     # Valida conexão
*bootstrap                     # Cria supabase/
*snapshot baseline             # Cria snapshot
*apply-migration 001_init.sql  # Aplica migration
*smoke-test v1.0               # Valida deployment
```

---

### FASE 2: Security & Quality (2-3 dias)

#### Objetivo
RLS policies, auditorias, checklists

#### Tasks
1. **`db-rls-audit.md`** - Auditar cobertura RLS
2. **`db-policy-apply.md`** - Aplicar policies (KISS/granular)
3. **`schema-audit.md`** - Auditoria de qualidade

#### Templates
1. **`rls-kiss-policy-tmpl.sql`** - Policy simples
2. **`rls-granular-policy-tmpl.sql`** - Policy complexa
3. **`smoke-test-suite-tmpl.yaml`** - Suíte de testes

#### Checklists
1. **`dba-predeploy-checklist.md`** - Pré-deploy
2. **`security-audit-checklist.md`** - Auditoria segurança
3. **`database-design-checklist.md`** - Qualidade de design

#### Data Files
1. **`rls-security-patterns.md`** - Padrões de RLS
2. **`migration-safety-guide.md`** - Práticas seguras

#### Entregáveis Fase 2
- ✅ RLS audit completo
- ✅ Policies KISS aplicáveis
- ✅ Checklists pré-deploy funcionando

---

### FASE 3: Design Tools (2-3 dias)

#### Objetivo
Ferramentas de arquitetura e design

#### Tasks
1. **`domain-modeling.md`** - Modelagem interativa
2. **`query-optimization.md`** - Otimização de queries
3. **`supabase-setup.md`** - Setup completo Supabase

#### Templates (completar)
1. **`migration-plan-tmpl.yaml`** - Finalizar
2. **`index-strategy-tmpl.yaml`** - Criar
3. **`db-runbook-tmpl.yaml`** - Criar

#### Data Files
1. **`database-best-practices.md`**
2. **`supabase-patterns.md`**
3. **`schema-evolution-strategies.md`**

#### Entregáveis Fase 3
- ✅ Pode modelar domínios interativamente
- ✅ Pode desenhar schemas completos
- ✅ Pode planejar migrations complexas

---

### FASE 4: Advanced Operations (3-4 dias)

#### Objetivo
Monitoramento, performance, disaster recovery

#### Tasks
1. **`db-monitor-queries.md`** - Monitorar queries
2. **`db-check-locks.md`** - Analisar locks
3. **`db-vacuum-status.md`** - Status vacuum
4. **`db-backup.md`** - Backups
5. **`db-restore.md`** - Restore
6. **`db-compare-schemas.md`** - Schema drift
7. **`db-analyze-hotpaths.md`** - Performance
8. **`db-explain.md`** - Query plans
9. **`db-load-csv.md`** - Import CSV
10. **`db-run-sql.md`** - Execute SQL

#### Data Files
1. **`postgres-tuning-guide.md`**
2. **`postgres-common-mistakes.md`**
3. **`postgres-function-cookbook.md`**
4. **`mcp-supabase-integration.md`**
5. **`supabase-vs-postgres.md`**

#### Checklists
1. **`dba-rollback-checklist.md`**
2. **`dba-team-workflow-checklist.md`**
3. **`compliance-checklist.md`**

#### Entregáveis Fase 4
- ✅ Monitoring completo
- ✅ Backup/restore funcional
- ✅ Performance analysis
- ✅ Disaster recovery ready

---

### FASE 5: Sincronização Cross-IDE (1 dia)

#### Objetivo
Copiar estrutura estável para `.cursor/`

#### Ações
1. Validar que tudo funciona em `.aios-core/`
2. Copiar estrutura para `.cursor/` (se necessário)
3. Documentar processo de sync
4. Criar script de validação

#### Entregáveis Fase 5
- ✅ DB Sage funciona em múltiplos IDEs
- ✅ Documentação de sync
- ✅ Script de validação

---

## 🎯 Resumo Executivo

### O Que é DB Sage?

**Agente CORE** do AIOS que combina:
- **Arquitetura de Banco de Dados** (design, modeling, planning)
- **Operações DBA** (migrations, backups, monitoring)
- **Segurança** (RLS policies, audits)
- **Performance** (optimization, analysis)

### Por Que CORE?

- **Universal**: Todo projeto com BD precisa
- **Fundamental**: BD é infraestrutura crítica
- **Reutilizável**: Tasks DBA são genéricas
- **Cross-domain**: Usado por MMOS, CreatorOS, etc.

### Arquitetura

```
.aios-core/agents/db-sage.md  ← Agente principal
       ↓
.aios-core/tasks/db-*.md      ← 25 tasks DBA
       ↓
.aios-core/templates/         ← 9 templates
.aios-core/checklists/        ← 6 checklists
.aios-core/data/              ← 10 knowledge files
```

### Ativação

```bash
/db-sage              # Ativa agente
*help                 # Lista comandos
*env-check            # Valida ambiente
*bootstrap            # Cria projeto
*snapshot baseline    # Cria snapshot
*apply-migration X    # Aplica migration
*smoke-test v1.0      # Valida
```

### Timeline

- **Fase 1**: 3-5 dias - Core Operations ⚡ MVP
- **Fase 2**: 2-3 dias - Security & Quality
- **Fase 3**: 2-3 dias - Design Tools
- **Fase 4**: 3-4 dias - Advanced Operations
- **Fase 5**: 1 dia - Cross-IDE Sync

**Total**: 11-16 dias para completar 100%

---

## ❓ Decisões Necessárias do Usuário

### 1. MCP Supabase Status
**Pergunta**: O MCP Supabase já está configurado no seu sistema?
- Verificar em: `~/.config/claude/mcp.json`
- Se sim: Tasks vão preferir MCP
- Se não: Vamos usar Supabase CLI + env vars

### 2. Prioridade de Implementação
**Pergunta**: Qual abordagem prefere?
- **A) MVP Rápido**: Apenas Fase 1 (3-5 dias) - core operations
- **B) Completo**: Todas as 4 fases (11-16 dias) - full-featured
- **C) Incremental**: Fase 1 → validar → decidir próximas

### 3. Testing Strategy
**Pergunta**: Como testar durante desenvolvimento?
- **A) Database Real**: Usar seu Supabase project atual
- **B) Local**: Setup Supabase local com `supabase start`
- **C) Test Project**: Criar projeto Supabase só para testes

### 4. Atlas Migration
**Pergunta**: O que fazer com o agente Atlas existente?
- **A) Manter Separado**: DB Sage novo, Atlas legado
- **B) Deprecar**: Focar só em DB Sage
- **C) Migrar**: Portar funcionalidades do Atlas para DB Sage

### 5. Documentação
**Pergunta**: Onde documentar DB Sage?
- **A) Inline**: Documentação dentro do próprio `.aios-core/agents/db-sage.md`
- **B) Separada**: Criar `docs/architecture/db-sage/` com docs extensivos
- **C) Ambos**: Inline + documentação externa detalhada

---

## 🚦 Próximos Passos (Após Aprovação)

### Imediato (Hoje)
1. ✅ **Você aprovar este plano**
2. ✅ **Responder as 5 perguntas acima**
3. ✅ **Decidir: MVP (Fase 1) ou Completo (Fases 1-4)?**

### Fase 1 - Dia 1 (Amanhã)
1. Criar `.aios-core/agents/db-sage.md`
2. Criar `db-env-check.md`
3. Criar `db-bootstrap.md`
4. Criar `db-snapshot.md`
5. Testar ativação: `/db-sage` → `*help` → `*env-check`

### Fase 1 - Dia 2-3
1. Criar `db-apply-migration.md`
2. Criar `db-rollback.md`
3. Criar `db-dry-run.md`
4. Criar `db-smoke-test.md`
5. Criar `db-seed.md`
6. Testar ciclo completo

### Validação MVP (Dia 4-5)
1. Rodar ciclo completo em projeto real
2. Testar integração MCP/CLI
3. Validar cross-agent handoffs
4. Documentar issues/melhorias
5. **Decidir**: Continuar para Fases 2-4?

---

## 📚 Referências

### Documentos Consultados
- ✅ `.aios-core/user-guide.md` - Entendimento do workflow AIOS
- ✅ `.aios-core/working-in-the-brownfield.md` - Padrões brownfield
- ✅ `.aios-core/install-manifest.yaml` - Estrutura de arquivos
- ✅ `.aios-core/CONFIG-USAGE.md` - Configs e prefixos
- ✅ `.aios-core/agents/architect.md` - Padrão de agente CORE
- ✅ `.claude/commands/MMOS/agents/mind-mapper.md` - Padrão de agente específico
- ✅ `.claude/CLAUDE.md` - Regras do Claude Code
- ✅ `docs/architecture/new AIOS agent/DB-SAGE-OVERVIEW.md` - Visão original

### Arquivos Existentes
- ✅ `docs/architecture/new AIOS agent/schema-design-tmpl.yaml`
- ✅ `docs/architecture/new AIOS agent/rls-policies-tmpl.yaml`
- ⚠️ `docs/architecture/new AIOS agent/migration-plan-tmpl.yaml` (parcial)

---

## ✅ Checklist de Validação

Antes de aprovar, verificar:

- [ ] Entendi que DB Sage é agente CORE (não específico de sistema)
- [ ] Concordo com localização em `.aios-core/`
- [ ] Entendi o padrão de ativação `/db-sage`
- [ ] Revisei a lista de 25 tasks propostas
- [ ] Revisei a lista de 9 templates
- [ ] Revisei a lista de 6 checklists
- [ ] Revisei a lista de 10 data files
- [ ] Concordo com timeline proposto (11-16 dias full ou 3-5 dias MVP)
- [ ] Respondi as 5 perguntas de decisão
- [ ] Pronto para começar implementação

---

**Winston - Holistic System Architect**
*Aguardando sua aprovação para iniciar Fase 1* 🏗️
