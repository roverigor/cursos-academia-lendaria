# Template: Estrutura da Base de Conhecimento

## Trilha 8 - CS e Atendimento | Modulo 2

---

## 1. ESTRUTURA DE CATEGORIAS

### Hierarquia da KB

```
BASE DE CONHECIMENTO
|
+-- CATEGORIA 1: _______________
|   +-- Topico 1.1: ___
|   +-- Topico 1.2: ___
|   +-- Topico 1.3: ___
|
+-- CATEGORIA 2: _______________
|   +-- Topico 2.1: ___
|   +-- Topico 2.2: ___
|   +-- Topico 2.3: ___
|
+-- CATEGORIA 3: _______________
|   +-- Topico 3.1: ___
|   +-- Topico 3.2: ___
|
+-- CATEGORIA 4: _______________
|   +-- Topico 4.1: ___
|   +-- Topico 4.2: ___
|
+-- CATEGORIA 5: _______________
|   +-- Topico 5.1: ___
|   +-- Topico 5.2: ___
```

---

## 2. INVENTARIO DE ARTIGOS

### Artigos Existentes

| # | Titulo | Categoria | Tipo | Status | Ultima Atualizacao |
|---|--------|-----------|------|--------|-------------------|
| 1 | | | FAQ/How-to/etc | Ativo/Desatualizado | |
| 2 | | | | | |
| 3 | | | | | |
| 4 | | | | | |
| 5 | | | | | |
| 6 | | | | | |
| 7 | | | | | |
| 8 | | | | | |
| 9 | | | | | |
| 10 | | | | | |

### Tipos de Artigo

| Tipo | Quantidade | % do Total |
|------|------------|------------|
| FAQ simples | | |
| How-to passo a passo | | |
| Troubleshooting | | |
| Referencia tecnica | | |
| Politica/Regra | | |
| Video/Tutorial | | |
| **TOTAL** | | **100%** |

---

## 3. TOP 20 PERGUNTAS FREQUENTES

### Mapeamento de FAQ

| # | Pergunta | Frequencia/Mes | Tem Artigo? | Tempo Resposta |
|---|----------|----------------|-------------|----------------|
| 1 | | | Sim/Nao | |
| 2 | | | Sim/Nao | |
| 3 | | | Sim/Nao | |
| 4 | | | Sim/Nao | |
| 5 | | | Sim/Nao | |
| 6 | | | Sim/Nao | |
| 7 | | | Sim/Nao | |
| 8 | | | Sim/Nao | |
| 9 | | | Sim/Nao | |
| 10 | | | Sim/Nao | |
| 11 | | | Sim/Nao | |
| 12 | | | Sim/Nao | |
| 13 | | | Sim/Nao | |
| 14 | | | Sim/Nao | |
| 15 | | | Sim/Nao | |
| 16 | | | Sim/Nao | |
| 17 | | | Sim/Nao | |
| 18 | | | Sim/Nao | |
| 19 | | | Sim/Nao | |
| 20 | | | Sim/Nao | |

**Cobertura atual:** ___/20 perguntas tem artigo (___%)

---

## 4. TEMPLATE DE ARTIGO FAQ

### Estrutura Padrao

```markdown
# [TITULO DA PERGUNTA]

## Pergunta
[Pergunta completa como o cliente faria]

## Resposta Curta
[1-2 frases diretas]

## Resposta Detalhada
[Explicacao completa se necessario]

## Passos (se aplicavel)
1. ___
2. ___
3. ___

## Observacoes
- ___
- ___

## Relacionados
- [Link artigo 1]
- [Link artigo 2]

---
Ultima atualizacao: ___/___/___
Autor: ___
```

---

## 5. TEMPLATE DE ARTIGO HOW-TO

### Estrutura Padrao

```markdown
# Como [ACAO]

## Objetivo
[O que o usuario vai conseguir fazer]

## Pre-requisitos
- [ ] ___
- [ ] ___

## Passo a Passo

### Passo 1: [Titulo]
[Instrucao detalhada]
[Screenshot se aplicavel]

### Passo 2: [Titulo]
[Instrucao detalhada]

### Passo 3: [Titulo]
[Instrucao detalhada]

## Resultado Esperado
[O que deve acontecer ao final]

## Problemas Comuns
| Problema | Solucao |
|----------|---------|
| | |
| | |

## Proximo Passo
[O que fazer depois]

---
Ultima atualizacao: ___/___/___
```

---

## 6. TEMPLATE DE TROUBLESHOOTING

### Estrutura Padrao

```markdown
# Erro: [NOME DO ERRO]

## Sintoma
[O que o usuario ve/experimenta]

## Causas Possiveis
1. ___
2. ___
3. ___

## Solucao por Causa

### Se a causa for 1:
1. ___
2. ___
3. ___

### Se a causa for 2:
1. ___
2. ___

### Se a causa for 3:
1. ___
2. ___

## Se Nenhuma Solucao Funcionar
[Instrucoes para escalar/contato]

---
Ultima atualizacao: ___/___/___
```

---

## 7. GAPS DA KB

### Artigos que Faltam

| # | Tema | Tipo | Prioridade | Responsavel | Prazo |
|---|------|------|------------|-------------|-------|
| 1 | | | Alta/Media/Baixa | | |
| 2 | | | | | |
| 3 | | | | | |
| 4 | | | | | |
| 5 | | | | | |

---

## 8. PLANO DE MANUTENCAO

### Rotina de Atualizacao

| Frequencia | Acao | Responsavel |
|------------|------|-------------|
| Semanal | Revisar artigos mais acessados | |
| Mensal | Atualizar artigos desatualizados | |
| Trimestral | Audit completa da KB | |

### Criterios de Revisao

- [ ] Artigo acessado > 100x/mes → revisar mensalmente
- [ ] Artigo com feedback negativo → revisar imediatamente
- [ ] Produto mudou → atualizar artigos relacionados
- [ ] Artigo > 6 meses sem revisao → revisar

---

## 9. PROMPT DE IA PARA CRIAR ARTIGOS

```
Crie um artigo de KB sobre este tema:

TEMA: [descreva o tema]
TIPO: [FAQ / How-to / Troubleshooting / Politica]
PUBLICO: [clientes / atendentes / ambos]

CONTEXTO DO NEGOCIO:
[descreva seu produto/servico]

INFORMACOES A INCLUIR:
[liste os pontos principais]

Crie o artigo seguindo esta estrutura:
1. Titulo claro
2. Resposta curta (1-2 frases)
3. Explicacao detalhada
4. Passos (se aplicavel)
5. Observacoes importantes
6. Links relacionados
```

---

## 10. CHECKLIST DE VALIDACAO

- [ ] Estrutura de categorias definida
- [ ] Inventario de artigos existentes
- [ ] Top 20 perguntas mapeadas
- [ ] Templates de artigo criados
- [ ] Gaps identificados
- [ ] Plano de manutencao definido
- [ ] Pelo menos 10 artigos prontos

---

**Data da estruturacao:** ___/___/___
**Proxima revisao:** ___/___/___
