# /system-prompt-creation Task

Gerar system prompts generalista e especialistas.

```yaml
purpose: "Compilar DNA Mental em prompts prontos para produção"
prerequisites:
  - Fase synthesis concluída
interactive: true
```

## Elicitação
```
1. Mind alvo
2. Perfis especialistas necessários
3. Restrições de tokens/formatos
```

## Passos
1. Preencher templates `system-prompt-generalista.md` e `system-prompt-specialist.md`
2. Validar contra checklist `system-prompt-validation`
3. Atualizar `STATUS.md` e `system-prompts/CHANGELOG.md`
```
