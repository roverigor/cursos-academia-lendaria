# /cognitive-analysis Task

Realizar análise das 8 camadas DNA Mental™ a partir das fontes coletadas.

```yaml
purpose: "Preencher analysis docs e camada por camada"
prerequisites:
  - sources_master.yaml com status COLLECTED >= requisitos
  - discovery_report e priority_matrix atualizados
interactive: true
```

## Elicitação
```
1. Mind alvo
2. Camadas a priorizar (ex.: 5-8)
3. Evidências principais identificadas (opcional)
```

## Passos
1. Carregar notas de discovery e outputs do ETL
2. Para cada camada selecionada, preencher seções em `analysis/layers/{layer}.md`
3. Registrar lacunas e evidências adicionais necessárias
4. Atualizar `STATUS.md` com progresso da análise
```
