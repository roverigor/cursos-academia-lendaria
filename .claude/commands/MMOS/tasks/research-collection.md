# /research-collection Task

Conduzir discovery, priorização e coleta de fontes.

```yaml
purpose: "Gerar discovery_report, priority_matrix e acionar ETL para coleta"
prerequisites:
  - Viability = GO/CAUTION
  - Estrutura `docs/minds/{mind}` criada
interactive: true
```

## Elicitação
```
1. Mind alvo
2. Nível de profundidade (mínimo, completo)
3. Deseja usar template padrão de discovery ou customizado?
4. Confirmar se deve acionar ETL automaticamente após discovery (sim/não)
```

## Passos
1. Preencher matriz de tipos de fonte e gerar discovery_report.yaml
2. Atualizar priority_matrix.yaml com batches tier 1/2/3
3. Se opção = sim, gerar `_etl_sources.yaml` e chamar task `/collect-all-sources`
4. Registrar resumo em `sources_master.yaml` e `STATUS.md`
```
