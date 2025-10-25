# MMOS Documentation Migration Status — 2025-10-25 12:04

## Context
- Objective: consolidar documentação MMOS no expansion-pack (`expansion-packs/mmos`) sem quebrar fluxos existentes que ainda usam `docs/mmos/**`.
- Fonte de planejamento: `docs/architecture/docs-reorganization-2025-10-17.md` descreve o estado "ANTES" e a estrutura "DEPOIS" desejada.
- Metodologia desta checagem: inspecionei diretórios atuais via CLI (`ls`, `find`, `sed`) e comparei com o plano para classificar cada frente como Concluída, Parcial ou Pendente.

## Observed State (2025-10-25)
- `docs/` agora contém pastas gerais (`architecture/`, `guides/`, `logs/`, `methodology/`, `prd/`, `stories/`) e não está mais vazio.
- `docs/prd/mmos-prd.md` é a versão 1.5 atualizada do PRD (05/10/2025), já fora do antigo `docs/mmos/docs`.
- Continuação de legado: `docs/mmos/**` mantém 129 arquivos (arquitetura, epics, reports, stories, prompts etc.), enquanto o pack possui 82 arquivos (`expansion-packs/mmos/**`).
- Configurações AIOS continuam apontando para `docs/mmos` (`.aios-core/mmos-config.yaml`), portanto agentes ainda dependem do legado.
- Stories duplicados: `docs/stories/mmos-legacy/` e `docs/mmos/stories/` coexistem com novas stories do pack em `expansion-packs/mmos/stories/`.

## Workstream Status vs Plan
| Item | Plano/Expectativa | Evidência Atual | Status |
| --- | --- | --- | --- |
| Outputs segregados | Mover cursos/minds/logs gerados para `outputs/` | `outputs/{courses,database,debates,minds,swipe}` presentes (`ls outputs`) | ✅ Concluído |
| Recuperar estrutura base de `docs/` | Ter `architecture/`, `guides/`, `prd/`, `stories/` etc no topo | `ls docs` mostra pastas criadas; `docs/architecture/coding-standards.md` ativo | 🟢 Em uso (manter) |
| PRD centralizado fora do nesting | `mmos-prd.md` em `docs/prd/` com versão atual | arquivo existente em `docs/prd/mmos-prd.md` (v1.5) | ✅ Concluído |
| Eliminar `docs/mmos/docs/` | Remover o duplo "docs" e redistribuir conteúdos | `find docs/mmos -maxdepth 2 -name docs` → sem resultados | 🟢 Concluído (monitorar) |
| Consolidar MMOS no expansion-pack | Referências e arquivos principais residem em `expansion-packs/mmos/**` apenas | Legado ainda com 129 arquivos críticos (`docs/mmos`), pack com 82; ambos ativos | 🟠 Parcial (duplicação) |
| Atualizar `mmos-config.yaml` | Apontar `prd/`, `architecture/`, `stories/` para paths do pack | Arquivo ainda referencia `docs/mmos/...` (`.aios-core/mmos-config.yaml:9-34`) | 🔴 Pendente |
| Deduplicar histórias MMOS | Apenas uma fonte para stories (pack ou docs) | Stories em `docs/mmos/stories/`, `docs/stories/mmos-legacy/` e `expansion-packs/mmos/stories/` | 🔴 Pendente |
| Documentar status da migração | Registrar progresso/pendências para evitar regressões | Este log `docs/logs/20251025-1204-mmos-doc-migration-status.md` | ✅ Concluído |

## Next Recommended Checks
1. **Inventário controlado**: mapear quais arquivos em `docs/mmos/**` ainda são referenciados por agentes/configs antes de mover para o pack.
2. **Config espelhado**: preparar um `mmos-pack-config.yaml` apontando para `expansion-packs/mmos/...` e testá-lo em sandbox enquanto o legado permanece.
3. **Stories**: decidir fonte única (p.ex. pack) e converter stories legados em arquivos de histórico (`docs/stories/mmos-legacy/README.md` já existe) ou migrá-los definitivamente.
4. **Comunicação**: atualizar `CONFIG-USAGE.md` e READMEs assim que o pack for a fonte oficial, evitando que colaboradores modifiquem `docs/mmos` por engano.

— Registro automático criado por Winston (AIOS Architect) via CLI.
