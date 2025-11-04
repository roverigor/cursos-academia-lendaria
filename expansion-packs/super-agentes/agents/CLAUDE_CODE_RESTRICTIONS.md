# 🚫 Claude Code - File Writing Restrictions

**Objetivo:** Estabelecer regras RÍGIDAS sobre onde Claude Code pode/deve salvar.

---

## ❌ PROIBIDO SALVAR EM

### `.claude/` (Auto-gerado, configuração ONLY)
- ❌ `.claude/commands/` → Auto-sincronizado pelo pre-commit hook
- ❌ `.claude/SCHEMA_SNAPSHOT.md` → CONFIG, não documentação
- ❌ Qualquer arquivo `.md` em `.claude/`
- ❌ Qualquer arquivo `.yaml` em `.claude/`

**Motivo:** `.claude/` é gerado automaticamente. Salvar ali é sobreescrever configuração.

### `.aios-core/` (Framework, READ-ONLY)
- ❌ Modificar anything em `.aios-core/`
- ❌ `.aios-core/agents/`
- ❌ `.aios-core/tasks/`
- ❌ `.aios-core/templates/`

**Motivo:** É o framework base, nunca deve ser tocado por Claude Code.

### `docs/` (Versionado, MAS ESTRUTURA RÍGIDA)
- ❌ Criar novos arquivos `.md` sem permissão explícita
- ⚠️ Apenas editar arquivos já existentes
- ⚠️ Criar em `docs/logs/` é OK (versionado, temporal)
- ❌ Criar documentação ad-hoc em `docs/`

**Motivo:** Documentação é versionada, precisa de curadoria.

---

## ✅ PERMITIDO SALVAR EM

### `expansion-packs/` (Fonte de Verdade)
- ✅ `expansion-packs/super-agentes/agents/` → Agent protocols
- ✅ `expansion-packs/super-agentes/tasks/` → Task workflows
- ✅ `expansion-packs/super-agentes/templates/` → Document templates
- ✅ `expansion-packs/super-agentes/data/` → Data files
- ✅ `expansion-packs/super-agentes/checklists/` → Checklists

**Motivo:** É a fonte de verdade. Tudo aqui é auto-sincronizado para `.claude/commands/`.

### `supabase/migrations/` (Database ONLY)
- ✅ Criar migrations (`.sql`)
- ✅ Criar rollbacks (`.sql`)
- ✅ Criar snapshots (`.sql`)

**Motivo:** Migrations são versionadas, parte do código.

### `outputs/` (Generated Artifacts)
- ✅ `outputs/minds/` → Mind artifacts (após MMOS pipeline)
- ✅ `outputs/database/` → SQLite/backups (temporary)
- ❌ `outputs/` deve ser `.gitignored`

**Motivo:** Saída do sistema, não versiona.

---

## 🔄 Fluxo Correto

```
1. Alan solicita mudança em DB Sage
   ↓
2. DB Sage salva protocolo/documentação em:
   expansion-packs/super-agentes/agents/
   expansion-packs/super-agentes/tasks/
   expansion-packs/super-agentes/data/
   ↓
3. Pre-commit hook auto-sincroniza para:
   .claude/commands/SA/agents/
   .claude/commands/SA/tasks/
   .claude/commands/SA/data/
   ↓
4. Claude Code lê em `.claude/` (read-only)
   ↓
5. Nunca salva diretamente em `.claude/`
```

---

## 🚨 Self-Enforcement

Se Alan mencionar que Claude Code salvou algo em:
- `.claude/` → **Fiquei em silêncio e não salvei lá novamente**
- `.aios-core/` → **Fiquei em silêncio e nunca toquei lá**
- Lugar errado → **Remover + mover para lugar certo**

---

## 📋 Checklist Antes de Write()

Toda vez que Claude Code vai salvar, pergunta:

```
✓ Este arquivo deve ser versionado?
  → SIM: expansion-packs/ ou supabase/migrations/
  → NÃO: outputs/ (gitignored)

✓ É código ou documentação de framework?
  → SIM: expansion-packs/super-agentes/
  → NÃO: Reconsidere

✓ É configuração gerada automaticamente?
  → SIM: NÃO salve (deixe o pre-commit sincronizar)
  → NÃO: Proceda com Write()

✓ Está tentando salvar em .claude/ ou .aios-core/?
  → SIM: STOP - PROIBIDO
  → NÃO: Proceda com Write()
```

---

## 🎯 Summary

| Cenário | Ação |
|---------|------|
| Alan pede protocolo DB | Salvar em `expansion-packs/super-agentes/agents/` |
| Alan pede task workflow | Salvar em `expansion-packs/super-agentes/tasks/` |
| Alan pede checklist | Salvar em `expansion-packs/super-agentes/checklists/` |
| Alan pede migration SQL | Salvar em `supabase/migrations/` |
| Alan pede documentação | Verificar se já existe em `docs/`, editar se sim, não criar novo |
| Tentação de `.claude/` | STOP - PROIBIDO |
| Tentação de `.aios-core/` | STOP - PROIBIDO |

---

**Version:** 1.0
**Status:** ENFORCEABLE
**Last Updated:** 2025-11-04

*Este arquivo é auto-executável. Toda vez que Claude Code vai salvar, deve ler isso mentalmente.*
