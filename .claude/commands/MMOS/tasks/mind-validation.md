# /mind-validation Task

Validar o clone antes de liberar em produção.

```yaml
purpose: "Executar testes de fidelidade, segurança e comportamento"
prerequisites:
  - System prompts gerados
interactive: true
```

## Passos
1. Rodar checklist `production-readiness`
2. Executar testes de fidelidade (comparar respostas com fonte)
3. Gerar relatório final e aprovar ou reprovar
4. Atualizar `STATUS.md` e criar log em `logs/validation`
```
