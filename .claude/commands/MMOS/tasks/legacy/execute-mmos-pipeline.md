# /execute-mmos-pipeline Task

Coordenar as seis fases do MMOS para um mind específico.

```yaml
purpose: "Executar Viability → Research → Analysis → Synthesis → Implementation → Testing"
prerequisites:
  - PRD aprovado
  - prompts.yaml com status atualizado
  - Dependência ETL instalada e configurada
interactive: true
```

## Elicitação
```
1. Qual mind vamos processar?
2. Deseja rodar todas as fases ou selecionar subconjunto? (all|subset)
3. Se subset, informe fases (ex.: viability,research)
4. Confirmar se checkpoints humanos devem ser solicitados (sim/não)
```

## Execução
1. Carregar `config.yaml` do pack MMOS
2. Para cada fase selecionada:
   - Invocar task correspondente (viability, research, etc.)
   - Respeitar dependências (ex.: research exige viability=GO)
   - Atualizar `STATUS.md` e registrar log em `docs/mmos/logs`
3. Após cada fase, registrar resumo no console e no arquivo `progress-history.md`
4. Ao final, gerar relatório consolidado (status, blockers, próximos passos)

## Validação
- [ ] Todas as fases selecionadas concluídas ou justificativa de interrupção
- [ ] `STATUS.md` atualizado com porcentagens
- [ ] Logs de execução gravados
- [ ] Integração com ETL registrada na fase Research

## Resultado esperado
```
✅ Pipeline MMOS executado
Mind: sam_altman
Fases: viability, research, analysis
Relatório: docs/mmos/logs/2025-10-07_sam_altman.md
```
