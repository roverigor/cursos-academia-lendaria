# DB Sage - Database Architect & Operations Engineer

**Versão**: 1.0.0 (Em Revisão)
**Status**: 🔄 Staging - Aguardando Auditoria
**Tipo**: Agente AIOS CORE

---

## 🎯 O Que É DB Sage?

**DB Sage** é um agente AIOS que combina expertise em **arquitetura de banco de dados** com capacidades **operacionais de DBA**, focado em **PostgreSQL** e **Supabase**.

### Capacidades Principais

#### 🏗️ Arquitetura
- Schema design e modelagem de domínio
- RLS (Row Level Security) policies
- Estratégia de indexação
- Planejamento de migrations

#### ⚙️ Operações DBA
- Migrations seguras (snapshot → dry-run → apply → rollback)
- Smoke tests e validação
- Backup e disaster recovery
- Monitoramento e performance

#### 🔒 Segurança
- RLS audit e coverage
- Policy generation (KISS e granular)
- SQL injection prevention
- Security checklist

---

## 📁 Estrutura de Arquivos

```
docs/architecture/db-sage/           [STAGING - REVISÃO]
│
├── README.md                         ← Você está aqui
├── IMPLEMENTATION-GUIDE.md           ← Guia completo de implementação
├── GAP-ANALYSIS.md                   ← Análise de gaps e best practices
│
├── agents/
│   └── db-sage.md                    ← Definição do agente (AIOS)
│
├── tasks/                            ← 11 tasks executáveis
│   ├── db-env-check.md
│   ├── db-bootstrap.md
│   ├── db-snapshot.md
│   ├── db-apply-migration.md
│   ├── db-rollback.md
│   ├── db-dry-run.md
│   ├── db-smoke-test.md
│   ├── db-rls-audit.md
│   ├── db-explain.md
│   ├── db-impersonate.md
│   └── db-verify-order.md
│
├── templates/                        ← 6 templates de documentação
│   ├── schema-design-tmpl.yaml
│   ├── rls-policies-tmpl.yaml
│   ├── migration-plan-tmpl.yaml
│   ├── index-strategy-tmpl.yaml
│   ├── tmpl-rls-kiss-policy.sql
│   └── tmpl-smoke-test.sql
│
└── examples/
    └── task-example-db-bootstrap.md
```

**Status**: Todos os arquivos aguardando revisão/auditoria antes de mover para `.aios-core/`

---

## 🚀 Quick Start

### 1. Ativação do Agente
```bash
/db-sage                 # Ativa o agente
*help                    # Lista comandos disponíveis
```

### 2. Setup Inicial
```bash
*env-check               # Valida conexão com banco
*bootstrap               # Cria estrutura supabase/
```

### 3. Workflow de Migration Segura
```bash
*snapshot baseline       # Cria snapshot para rollback
*dry-run migration.sql   # Testa migration
*apply-migration migration.sql  # Aplica
*smoke-test v1.0         # Valida deployment
```

### 4. Rollback (se necessário)
```bash
*rollback baseline       # Volta ao snapshot
```

---

## 📋 Comandos Disponíveis

### Operações Core
| Comando | Descrição |
|---------|-----------|
| `*env-check` | Validar ambiente e conexão |
| `*bootstrap` | Criar estrutura supabase/ |
| `*snapshot {name}` | Criar snapshot de schema |
| `*apply-migration {file}` | Aplicar migration com safety |
| `*rollback {snapshot}` | Restaurar snapshot |
| `*dry-run {file}` | Testar migration sem aplicar |
| `*smoke-test {version}` | Executar testes de validação |

### Segurança
| Comando | Descrição |
|---------|-----------|
| `*rls-audit` | Auditar cobertura RLS |
| `*impersonate {user}` | Testar RLS como usuário |

### Performance
| Comando | Descrição |
|---------|-----------|
| `*explain {query}` | Analisar query plan |

### Documentação
| Comando | Descrição |
|---------|-----------|
| `*create-schema` | Gerar schema design doc |
| `*create-rls-policies` | Gerar RLS documentation |
| `*create-migration-plan` | Planejar migrations |
| `*design-indexes` | Desenhar estratégia de indexes |

---

## 🔧 Integrações

### MCP Supabase
- Preferência por MCP quando disponível
- Fallback para Supabase CLI
- Fallback para env vars + psql

### Supabase CLI
```bash
# Verificar instalação
supabase --version

# Login
supabase login

# Link project
supabase link --project-ref {ref}
```

### Cross-Agent AIOS

#### Com @architect
```
@architect cria schema-design.yaml
  ↓
/db-sage
*create-migration-from-design
```

#### Com @dev
```
@dev solicita mudança no schema
  ↓
/db-sage
*snapshot before-change
*create-migration "dev change"
*dry-run → *apply-migration
```

#### Com @qa
```
/db-sage completa migration
  ↓
*smoke-test v1.1
*seed test-data.sql
  ↓
@qa valida
```

---

## 📊 Estatísticas

| Categoria | Quantidade | Status |
|-----------|------------|--------|
| **Agente** | 1 | 🔍 Aguardando revisão |
| **Tasks** | 11 | 🔍 Aguardando auditoria |
| **Templates YAML** | 4 | 🔍 Aguardando auditoria |
| **Templates SQL** | 2 | 🔍 Aguardando auditoria |

---

## ⚠️ Status do Projeto

### Fase Atual: FASE 0 - Auditoria

**O que estamos fazendo:**
1. ✅ Organizar arquivos em estrutura staging
2. ✅ Consolidar documentação
3. 🔄 Auditar templates contra best practices
4. 🔄 Auditar tasks contra best practices
5. ⏸️ Documentar gaps identificados
6. ⏸️ Criar roadmap de correções

**Após auditoria completa:**
- Mover para `.aios-core/` (agente + tasks + templates)
- Disponibilizar para uso em projetos

### Gaps Conhecidos (Preliminares)

**CRÍTICOS** (bloqueiam produção):
1. ❌ Schema version tracking (checksums, rollback scripts)
2. ❌ Zero-downtime migrations (expand/contract pattern)
3. ❌ Backup/restore completo (PITR, verification)
4. ❌ Monitoring integration (pg_stat_statements, alerting)

**ALTO** (risk mitigation):
5. ⚠️ RLS patterns incompletos (multi-tenancy, time-based, hierarchical)
6. ⚠️ Connection pooling strategy não detalhada
7. ⚠️ Realtime configuration superficial
8. ⚠️ Storage objects integration ausente

Ver **GAP-ANALYSIS.md** para análise completa.

---

## 📚 Documentação Adicional

- **[IMPLEMENTATION-GUIDE.md](./IMPLEMENTATION-GUIDE.md)** - Guia completo de implementação, arquitetura detalhada, plano de fases
- **[GAP-ANALYSIS.md](./GAP-ANALYSIS.md)** - Análise detalhada de gaps, best practices, scorecard
- **[agents/db-sage.md](./agents/db-sage.md)** - Definição YAML completa do agente
- **[examples/](./examples/)** - Exemplos de uso e execução

---

## 🎯 Princípios Core

1. **Correctness Before Speed** - Priorizar correção sobre velocidade
2. **Everything Versioned & Reversible** - Snapshots, rollbacks, git
3. **Security by Default** - RLS everywhere, defense in depth
4. **Idempotency Everywhere** - Operações seguras para retry
5. **Observability Built-In** - Logs, metrics, EXPLAIN plans
6. **Domain-Driven Design** - Entender negócio antes de modelar
7. **Access Pattern First** - Design baseado em queries
8. **Defense in Depth** - RLS + constraints + triggers

---

## 🔗 Links Úteis

### Documentação Externa
- [Supabase Documentation](https://supabase.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [RLS Best Practices](https://supabase.com/docs/guides/auth/row-level-security)

### Repositório
- Issue Tracker: (adicionar link)
- Discussions: (adicionar link)

---

## 🤝 Como Contribuir

1. **Revisar arquivos** em staging (agents, tasks, templates)
2. **Reportar gaps** encontrados
3. **Propor correções** com exemplos
4. **Testar workflows** em projetos reais
5. **Documentar casos de uso**

---

## 📝 Changelog

### v1.0.0-staging (2025-10-26)
- ✅ Estrutura inicial de 11 tasks
- ✅ 6 templates (4 YAML + 2 SQL)
- ✅ Agente AIOS definido
- 🔄 Em auditoria antes de produção

---

**Mantido por**: Winston (Architect Agent)
**Última Atualização**: 2025-10-27
**Próximo Passo**: Auditoria de templates e tasks
