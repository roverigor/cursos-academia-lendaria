# ✅ Checklist de Execução

## Preparação

- [ ] Fazer backup do repositório completo
- [ ] Criar branch de refactoring: `git checkout -b refactor/docs-reorganization`
- [ ] Documentar estrutura atual: `tree -L 3 docs/ > docs-structure-before.txt`

## Fase 1: Extrair de docs/mmos/docs/

- [ ] Criar diretórios: `docs/{prd,methodology,guides,architecture}/`
- [ ] Mover PRDs para `docs/prd/`
- [ ] Mover metodologias para `docs/methodology/`
- [ ] Mover workflows para `docs/mmos/workflows/`
- [ ] Mover guides para `docs/guides/`
- [ ] Mover brownfield para `docs/architecture/`
- [ ] Remover diretório vazio `docs/mmos/docs/`
- [ ] Verificar se não restaram arquivos órfãos

## Fase 2: Mover Database e Logs

- [ ] Criar `outputs/database/` e `outputs/logs/mmos/`
- [ ] Mover `SQLite legado (migrado para Supabase em 2025-10)` → `SQLite legado (migrado para Supabase em 2025-10)`
- [ ] Mover `docs/mmos/logs/*` → `outputs/logs/mmos/`
- [ ] Atualizar `.gitignore` para ignorar `outputs/database/*.db` e `outputs/logs/*`
- [ ] Criar `.gitkeep` em `outputs/database/` e `outputs/logs/`

## Fase 3: Criar Índices

- [ ] Criar `docs/README.md` (índice master)
- [ ] Criar `docs/mmos/README.md` (índice MMOS)
- [ ] Atualizar `outputs/README.md` (adicionar database e logs)
- [ ] Verificar links em todos os READMEs

## Fase 4: Atualizar Referências

- [ ] Executar script `update-doc-refs.sh`
- [ ] Atualizar `README.md` raiz
- [ ] Atualizar `.claude/CLAUDE.md`
- [ ] Atualizar todos os expansion packs
- [ ] Atualizar `.aios-core/` workflows
- [ ] Verificar scripts em `scripts/`

## Fase 5: Validação

- [ ] Verificar links quebrados: `grep -r "docs/mmos/docs/" . --include="*.md"`
- [ ] Verificar paths de database: `grep -r "SQLite legado (migrado para Supabase em 2025-10)" . --include="*.{js,sh}"`
- [ ] Testar comandos principais: `*generate-course`, `*execute-mmos-pipeline`
- [ ] Documentar estrutura final: `tree -L 3 docs/ > docs-structure-after.txt`
- [ ] Comparar before/after: `diff docs-structure-{before,after}.txt`

## Fase 6: Commit

- [ ] Revisar todas as mudanças: `git status`
- [ ] Commit: `git commit -m "refactor: reorganize docs/ structure - extract mmos/docs/ to root categories"`
- [ ] Testar em ambiente limpo (clone fresh do repo)
- [ ] Merge para main: `git checkout main && git merge refactor/docs-reorganization`

---
