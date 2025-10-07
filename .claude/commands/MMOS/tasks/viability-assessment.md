# /viability-assessment Task

Avaliar se um novo mind deve avançar para Research.

```yaml
purpose: "Executar scoring APEX + ICP e emitir GO/NO-GO"
prerequisites:
  - PRD inicial preenchido
  - prompts.yaml disponível
interactive: true
```

## Elicitação
```
1. Mind alvo
2. Pontuações APEX (autoridade, prova, expertise, x-factor)
3. Pontuações ICP (match com avatar, monetização, acesso a fontes)
4. Observações adicionais
```

## Passos
1. Calcular média ponderada (APEX 60%, ICP 40%)
2. Comparar com thresholds (≥8 → GO, 6-7.9 → PROCEED_WITH_CAUTION, <6 → NO-GO)
3. Atualizar `docs/mmos/logs/viability/{mind}.md`
4. Se GO/CAUTION, preparar briefing para Research Specialist
```
