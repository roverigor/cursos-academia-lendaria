# Aula 2.3: Crie Seu Playbook SDR com IA

> **Tipo:** Exercício
> **Duração:** 20 minutos
> **Entregável:** Playbook SDR completo

---

## Objetivo

Criar seu **Playbook SDR com IA** - documento que define como qualificar, pontuar e agir com cada tipo de lead.

---

## Build Sprint (20 min)

### Passo 1: Defina Suas Perguntas (5 min)

Adapte as 7 perguntas para seu negócio:

| # | Pergunta Original | Sua Versão |
|---|-------------------|------------|
| 1 | Qual seu cargo? | _________________________ |
| 2 | Qual o faturamento? | _________________________ |
| 3 | Qual o problema? | _________________________ |
| 4 | Urgência (0-10)? | _________________________ |
| 5 | É o decisor? | _________________________ |
| 6 | Tem orçamento? | _________________________ |
| 7 | Prazo ideal? | _________________________ |

### Passo 2: Defina Pesos (5 min)

Distribua 100 pontos entre as perguntas:

| Pergunta | Resposta Ideal | Pontos | Resposta Ruim | Pontos |
|----------|----------------|--------|---------------|--------|
| 1. Cargo | _______ | ___ | _______ | ___ |
| 2. Faturamento | _______ | ___ | _______ | ___ |
| 3. Problema | _______ | ___ | _______ | ___ |
| 4. Urgência | _______ | ___ | _______ | ___ |
| 5. Decisor | _______ | ___ | _______ | ___ |
| 6. Orçamento | _______ | ___ | _______ | ___ |
| 7. Prazo | _______ | ___ | _______ | ___ |

**Total deve ser = 100**

### Passo 3: Defina Ações por Faixa (5 min)

| Score | Classificação | Ação | Mensagem Padrão |
|-------|---------------|------|-----------------|
| 80-100 | Quente | _______ | _______ |
| 50-79 | Morno | _______ | _______ |
| 0-49 | Frio | _______ | _______ |

### Passo 4: Crie Mensagens Padrão (5 min)

**Para Lead Quente (80-100):**
```
Oi [nome]! Vi que você [contexto].
Seu perfil é exatamente o que a gente ajuda.
Posso te ligar em 10 minutos para entender melhor?
```

**Para Lead Morno (50-79):**
```
Oi [nome], tudo bem?
Recebi seu interesse em [oferta].
Queria te enviar um material que pode ajudar.
Posso mandar?
```

**Para Lead Frio (0-49):**
```
Oi [nome]!
Preparamos um conteúdo sobre [tema] que pode te ajudar.
[link para material educativo]
Qualquer dúvida, estou aqui!
```

---

## Template Completo do Playbook

```markdown
# PLAYBOOK SDR - [Sua Empresa]

## 1. Perguntas de Qualificação
1. [pergunta 1]
2. [pergunta 2]
3. [pergunta 3]
4. [pergunta 4]
5. [pergunta 5]
6. [pergunta 6]
7. [pergunta 7]

## 2. Modelo de Scoring
| Critério | Quente | Pts | Frio | Pts |
|----------|--------|-----|------|-----|
| [crit 1] | [resp] | ___ | [resp] | ___ |
| [crit 2] | [resp] | ___ | [resp] | ___ |
...

## 3. Ações por Faixa
- 80-100: [ação]
- 50-79: [ação]
- 0-49: [ação]

## 4. Mensagens Padrão
### Quente
[mensagem]

### Morno
[mensagem]

### Frio
[mensagem]
```

---

## Prompt IA para Ajudar

```
Crie um modelo de qualificação para SDR do meu negócio.

Negócio: [descrever]
Ticket médio: [valor]
Ciclo de venda: [dias]
ICP: [descrever cliente ideal]

Use estas perguntas como base:
[colar suas 7 perguntas]

Defina:
1. Peso de cada pergunta (total = 100)
2. Critérios quente/morno/frio
3. Ação automática por faixa
4. Mensagem padrão para cada faixa
5. Quando chamar humano vs automatizar
```

---

## Checkpoint

Antes de ir para próxima aula:

- [x] 7 perguntas adaptadas ao seu negócio
- [x] Scoring com pesos definidos (total = 100)
- [x] 3 faixas com ações claras
- [x] Mensagens padrão prontas

---

**Próxima aula:** [2.4 Validação: Teste com 10 Leads](aula-2.4-validacao.md)
