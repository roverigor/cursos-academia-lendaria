# Template: Prompt de Action Items

**Uso:** Extração focada APENAS em tarefas e compromissos
**Tempo:** ~10 segundos para processar

---

## Prompt (copie tudo abaixo)

```
Extraia TODOS os action items desta transcrição de reunião.

Para cada item, identifique:
1. O que precisa ser feito (tarefa específica e acionável)
2. Quem é responsável (se mencionado na transcrição)
3. Prazo (se mencionado)
4. Prioridade (Alta/Média/Baixa baseado no contexto e urgência)

## Formato de Saída

### Action Items Identificados

- [ ] **[TAREFA]**
  - Responsável: @nome (ou "não especificado")
  - Prazo: data (ou "não especificado")
  - Prioridade: Alta/Média/Baixa
  - Contexto: [uma frase explicando por que essa tarefa surgiu]

### Resumo
- Total de action items: X
- Com responsável definido: X
- Com prazo definido: X
- Alta prioridade: X

---
TRANSCRIÇÃO:
[COLE A TRANSCRIÇÃO AQUI]
```

---

## Como Usar

1. Abra o Fathom → aba "Transcript" → clique "Copy"
2. Abra ChatGPT ou Claude
3. Cole o prompt acima
4. Substitua `[COLE A TRANSCRIÇÃO AQUI]` pela transcrição copiada
5. Envie e aguarde ~10 segundos
6. Copie os action items para seu sistema de tarefas (Notion, Asana, etc.)

---

## Formato Alternativo (para Notion/Todoist)

Se você usa Notion ou Todoist, peça este formato:

```
Liste os action items no formato:
- [ ] Tarefa | @responsável | #prazo | !prioridade

Exemplo:
- [ ] Enviar proposta revisada | @João | #2025-01-15 | !alta
```

---

## Formato para Slack

```
Liste os action items no formato de mensagem Slack:

📋 *Action Items da Reunião [DATA]*

*Alta Prioridade:*
• Tarefa 1 - @responsável - prazo

*Média Prioridade:*
• Tarefa 2 - @responsável - prazo

*Baixa Prioridade:*
• Tarefa 3 - @responsável - prazo
```
