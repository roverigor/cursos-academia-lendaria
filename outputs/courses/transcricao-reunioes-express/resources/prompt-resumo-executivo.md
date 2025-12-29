# Template: Prompt de Resumo Executivo

**Uso:** Cole no ChatGPT ou Claude após copiar a transcrição do Fathom
**Tempo:** ~10 segundos para processar

---

## Prompt (copie tudo abaixo)

```
Analise esta transcrição de reunião e forneça:

## TL;DR (1 frase)
O que foi essa reunião em uma frase.

## Decisões Tomadas
- Liste cada decisão que foi finalizada na reunião
- Use bullets claros e objetivos

## Action Items
| Tarefa | Responsável | Prazo |
|--------|-------------|-------|
| [Descreva a tarefa] | [Nome se mencionado] | [Data se mencionada] |

## Pontos em Aberto
- Questões que foram levantadas mas não resolvidas
- Tópicos que precisam de follow-up

## Próximos Passos
- O que deve acontecer após esta reunião?

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

---

## Variações

### Para reunião com cliente
Adicione ao final do prompt:
```
Foco especial em:
- Preocupações do cliente
- Compromissos assumidos pela nossa equipe
- Próximos passos acordados
```

### Para reunião de projeto
Adicione ao final do prompt:
```
Foco especial em:
- Riscos identificados
- Dependências mencionadas
- Bloqueios a resolver
```

### Para 1:1 com colaborador
Adicione ao final do prompt:
```
Foco especial em:
- Feedback dado/recebido
- Metas discutidas
- Desenvolvimento profissional
```
