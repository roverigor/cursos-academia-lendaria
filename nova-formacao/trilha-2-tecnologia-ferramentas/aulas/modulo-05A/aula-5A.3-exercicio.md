# Aula 5A.3: Criando Briefings que Funcionam

## Tipo: Exercício | Duração: 20 minutos

---

## GPS

### Goal (30s)
Criar um briefing técnico completo que qualquer desenvolvedor entenda.

### Position (60s)
Briefing ruim gera projeto ruim. Briefing bom economiza tempo, dinheiro e stress.

### Steps
1. Escolher projeto (2 min)
2. Preencher template (12 min)
3. Validar com IA (4 min)
4. Ajustar (2 min)

---

## Passo 1: Escolha um Projeto

### Opções

| Projeto | Complexidade | Tempo Dev |
|---------|--------------|-----------|
| Landing page com form | Baixa | 1-2 semanas |
| Dashboard de métricas | Média | 2-4 semanas |
| Sistema de agendamento | Média | 3-6 semanas |
| E-commerce básico | Alta | 2-3 meses |
| App mobile | Alta | 2-4 meses |

### Meu Projeto Escolhido

**Nome:** _______________

**Por que esse?**
- [ ] Já preciso disso
- [ ] Vai acontecer em breve
- [ ] Quero praticar com caso realista

---

## Passo 2: Preencher o Briefing

### Seção 1: Visão Geral

```markdown
# BRIEFING: [Nome do Projeto]

## Resumo Executivo
[2-3 frases explicando o que é e para quem]

## Objetivo de Negócio
O principal problema que resolve: [descrição]

O resultado esperado: [métrica ou resultado concreto]

## Prazo Desejado
- Início: [data]
- Primeira entrega: [data]
- Entrega final: [data]

## Orçamento Estimado
- Mínimo: R$ ___
- Máximo: R$ ___
- Flexibilidade: [sim/não para proposta diferente]
```

### Seção 2: Funcionalidades

```markdown
## Funcionalidades Obrigatórias (MVP)

### 1. [Nome da Feature]
**O que faz:** [descrição]
**Comportamento:**
- Quando [trigger], então [ação]
- Se [condição], mostrar [resultado]
**Prioridade:** Alta

### 2. [Nome da Feature]
**O que faz:** [descrição]
**Comportamento:**
- [comportamento 1]
- [comportamento 2]
**Prioridade:** Alta

### 3. [Nome da Feature]
**O que faz:** [descrição]
**Comportamento:**
- [comportamento 1]
**Prioridade:** Alta

## Funcionalidades Desejáveis (Fase 2)

### 4. [Nome da Feature]
**O que faz:** [descrição]
**Prioridade:** Média

### 5. [Nome da Feature]
**O que faz:** [descrição]
**Prioridade:** Baixa
```

### Seção 3: Usuários e Fluxos

```markdown
## Perfis de Usuário

### Usuário 1: [Nome do perfil]
- **Quem é:** [descrição]
- **O que precisa fazer:** [principais ações]
- **Nível técnico:** [baixo/médio/alto]

### Usuário 2: [Nome do perfil]
- **Quem é:** [descrição]
- **O que precisa fazer:** [principais ações]
- **Nível técnico:** [baixo/médio/alto]

## Fluxo Principal

1. Usuário acessa [onde]
2. Visualiza [o que]
3. Clica em [ação]
4. Preenche [dados]
5. Sistema [processa]
6. Usuário recebe [resultado]
```

### Seção 4: Integrações e Restrições

```markdown
## Integrações Necessárias

| Sistema | O que integra | Obrigatório? |
|---------|---------------|--------------|
| [Sistema 1] | [função] | Sim/Não |
| [Sistema 2] | [função] | Sim/Não |

## Regras de Negócio

1. [Regra 1 - ex: "Não permitir cadastro com email duplicado"]
2. [Regra 2 - ex: "Máximo 3 tentativas de login"]
3. [Regra 3]

## Restrições Técnicas

- [ ] Precisa funcionar offline? [sim/não]
- [ ] Volume esperado de usuários: [número]
- [ ] Dados sensíveis? [sim/não - quais]
- [ ] Compliance específico? [LGPD/PCI/outro]
```

### Seção 5: Visual e Referências

```markdown
## Requisitos Visuais

**Estilo desejado:** [minimalista/moderno/corporativo/outro]

**Cores:**
- Principal: [cor ou hex]
- Secundária: [cor ou hex]
- Tem brand guide? [sim/não - anexar]

**Responsivo:**
- [ ] Desktop
- [ ] Tablet
- [ ] Mobile

## Referências Visuais

1. [URL] - gosto de [elemento específico]
2. [URL] - gosto de [elemento específico]
3. [URL] - NÃO gosto de [elemento específico]
```

### Seção 6: Entregáveis e Critérios

```markdown
## O que deve ser entregue

- [ ] Código fonte no GitHub (repositório meu)
- [ ] Ambiente de produção funcionando
- [ ] Ambiente de teste/homologação
- [ ] Documentação técnica (README)
- [ ] Manual do usuário
- [ ] Credenciais e acessos documentados
- [ ] Backup configurado

## Critérios de Aceitação

O projeto será aceito quando:
1. Todas as funcionalidades MVP funcionarem
2. Testes passarem em [cenários]
3. Performance < [X segundos] para carregar
4. Funcionar em Chrome, Safari, Firefox
5. Funcionar em iOS e Android (se mobile)

## Garantia e Suporte

- Período de garantia desejado: [X dias/meses]
- Suporte pós-entrega: [o que espera]
- Manutenção: [como pretende resolver]
```

---

## Passo 3: Validar com IA

### Prompt de Validação

Cole seu briefing e peça:

```
Você é um desenvolvedor sênior avaliando este briefing.

[COLE SEU BRIEFING AQUI]

Avalie:
1. Clareza (1-10) - Entendi o que precisa ser feito?
2. Completude (1-10) - Falta alguma informação crítica?
3. Realismo (1-10) - O prazo/orçamento faz sentido?
4. Ambiguidades - Liste pontos que podem gerar confusão
5. Sugestões - O que melhoraria este briefing?

Seja crítico e direto.
```

### Resultado da Validação

| Critério | Nota | Feedback |
|----------|------|----------|
| Clareza | /10 | |
| Completude | /10 | |
| Realismo | /10 | |

**Ambiguidades encontradas:**
1.
2.
3.

---

## Passo 4: Ajustar

### Pontos a Corrigir

| Problema | Correção | Feito? |
|----------|----------|--------|
| 1. | | [ ] |
| 2. | | [ ] |
| 3. | | [ ] |

---

## Seu Briefing Final

Salve em um documento e use para:
- Solicitar propostas
- Comparar fornecedores
- Acompanhar desenvolvimento
- Validar entrega

---

## Checklist de Qualidade

- [ ] Objetivo de negócio está claro
- [ ] Funcionalidades estão detalhadas com comportamento
- [ ] Usuários e fluxos definidos
- [ ] Integrações listadas
- [ ] Regras de negócio especificadas
- [ ] Visual descrito ou referenciado
- [ ] Entregáveis claros
- [ ] Critérios de aceitação definidos
- [ ] Prazo e orçamento realistas
- [ ] Validado com IA

---

## Próximo Passo

Vamos criar critérios de avaliação de propostas e definir o compromisso de 48h.
