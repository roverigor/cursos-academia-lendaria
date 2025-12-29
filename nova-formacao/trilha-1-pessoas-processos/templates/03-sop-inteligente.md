# Template: SOP Inteligente

## Trilha 1 - Modulo 3 | Pessoas & Processos

---

## Instrucoes de Uso

1. Escolha 1 processo critico (idealmente ligado a um risco ALTO do Modulo 1)
2. Preencha cada secao do template
3. Crie o prompt de validacao com IA
4. Teste com uma pessoa que NAO conhece o processo
5. Ajuste ate funcionar sem voce

---

## Por Que SOPs Tradicionais Falham

| SOP Tradicional | SOP Inteligente |
|-----------------|-----------------|
| Documento estatico em pasta | Sistema vivo com IA acoplada |
| "Faca isso, depois aquilo" | "Faca isso + valide com este prompt" |
| Ninguem le, ninguem segue | IA executa ou valida cada passo |
| Desatualiza em 3 meses | Prompt atualiza em 5 minutos |
| Depende de supervisao | Auto-validacao com criterios |

---

## Template Principal

### Cabecalho

| Campo | Valor |
|-------|-------|
| **Nome do Processo** | |
| **Codigo** | SOP- |
| **Versao** | 1.0 |
| **Data de Criacao** | |
| **Ultima Atualizacao** | |
| **Responsavel** | |
| **Departamento** | |

---

### 1. OBJETIVO

> **Em 1-2 frases:** O que este processo entrega? Para quem? Em quanto tempo?

```
Este processo tem como objetivo [ENTREGAR O QUE]
para [QUEM/CLIENTE] em [TEMPO ESPERADO].
```

**Preencha:**

---

### 2. QUANDO USAR

| Gatilho | Descricao |
|---------|-----------|
| **Iniciar quando** | |
| **Nao usar quando** | |
| **Frequencia esperada** | vezes por dia/semana/mes |

---

### 3. PRE-REQUISITOS

Antes de iniciar, certifique-se de ter:

- [ ]
- [ ]
- [ ]
- [ ]

---

### 4. PASSO A PASSO

| Passo | Acao | Responsavel | Tempo | Output |
|-------|------|-------------|-------|--------|
| 1 | | | min | |
| 2 | | | min | |
| 3 | | | min | |
| 4 | | | min | |
| 5 | | | min | |
| 6 | | | min | |
| 7 | | | min | |
| 8 | | | min | |

**Tempo Total Estimado:** ___ minutos

---

### 5. CRITERIOS DE QUALIDADE

Como saber se o resultado esta correto?

| # | Criterio | Como Verificar | Obrigatorio? |
|---|----------|----------------|--------------|
| 1 | | | Sim / Nao |
| 2 | | | Sim / Nao |
| 3 | | | Sim / Nao |
| 4 | | | Sim / Nao |
| 5 | | | Sim / Nao |

---

### 6. ERROS COMUNS

| Erro | Por Que Acontece | Como Evitar |
|------|------------------|-------------|
| | | |
| | | |
| | | |

---

### 7. PROMPT DE VALIDACAO (IA)

Use este prompt para a IA validar o resultado ANTES de entregar:

```
Voce e um validador de qualidade. Revise o seguinte [TIPO DE ENTREGA]:

---
[COLAR AQUI O RESULTADO DO PROCESSO]
---

Verifique os seguintes criterios:

1. [CRITERIO 1 - copiar da secao 5]
2. [CRITERIO 2]
3. [CRITERIO 3]
4. [CRITERIO 4]
5. [CRITERIO 5]

Para cada criterio, responda:
- OK: Se atende completamente
- PARCIAL: Se atende mas pode melhorar
- FALHA: Se nao atende

Ao final:
- Se TODOS forem OK: Responda "APROVADO - Pode entregar"
- Se algum for PARCIAL: Liste sugestoes de melhoria
- Se algum for FALHA: Liste o que precisa ser refeito ANTES de entregar

Seja objetivo e especifico.
```

---

### 8. PROMPT DE EXECUCAO (IA)

Use este prompt para a IA EXECUTAR parte do processo:

```
Voce e um assistente especializado em [AREA].

Preciso que voce execute o seguinte:
[DESCREVER A TAREFA ESPECIFICA]

Contexto:
[INFORMACOES RELEVANTES]

Restricoes:
- [O QUE NAO PODE FAZER]
- [LIMITES]

Formato de entrega:
[COMO QUER O OUTPUT]

Exemplo de resultado esperado:
[MOSTRAR EXEMPLO]
```

---

### 9. CHECKLIST FINAL

Antes de considerar o processo concluido:

- [ ] Todos os passos foram executados
- [ ] Criterios de qualidade verificados
- [ ] Prompt de validacao retornou "APROVADO"
- [ ] Resultado registrado em [LOCAL]
- [ ] Proximo responsavel notificado (se aplicavel)

---

### 10. HISTORICO DE VERSOES

| Versao | Data | Alteracao | Autor |
|--------|------|-----------|-------|
| 1.0 | | Versao inicial | |
| | | | |

---

## Exemplo: SOP de Qualificacao de Lead

### Cabecalho

| Campo | Valor |
|-------|-------|
| **Nome do Processo** | Qualificacao de Lead Inbound |
| **Codigo** | SOP-VENDAS-001 |
| **Versao** | 1.0 |
| **Responsavel** | Equipe SDR |
| **Departamento** | Vendas |

### 1. OBJETIVO

> Este processo tem como objetivo QUALIFICAR leads inbound para VENDAS em ate 2 HORAS apos entrada.

### 4. PASSO A PASSO

| Passo | Acao | Resp | Tempo | Output |
|-------|------|------|-------|--------|
| 1 | Verificar dados do lead no CRM | SDR | 2min | Dados completos |
| 2 | Enviar mensagem de boas-vindas | SDR | 1min | Msg enviada |
| 3 | Fazer 3 perguntas de qualificacao | IA | 5min | Respostas |
| 4 | Calcular score (0-100) | IA | 1min | Score |
| 5 | Classificar (Quente/Morno/Frio) | IA | 1min | Classificacao |
| 6 | Se Quente: agendar call | SDR | 5min | Call agendada |
| 7 | Se Morno: adicionar a sequencia | Auto | 1min | Sequencia ativa |
| 8 | Registrar no CRM | SDR | 2min | CRM atualizado |

### 7. PROMPT DE VALIDACAO

```
Revise esta qualificacao de lead:

---
Nome: [X]
Empresa: [Y]
Respostas: [Z]
Score: [N]
Classificacao: [Quente/Morno/Frio]
---

Verifique:
1. Todas as 3 perguntas foram respondidas?
2. Score esta entre 0-100?
3. Classificacao segue a regra (>70=Quente, 40-70=Morno, <40=Frio)?
4. Proxima acao foi definida?

Se OK: "APROVADO"
Se FALHA: Liste o que corrigir.
```

---

## Checklist de Validacao do Template

- [ ] Objetivo claro em 1-2 frases
- [ ] Passo a passo com max 10 passos
- [ ] Cada passo tem tempo estimado
- [ ] Criterios de qualidade mensuraveis (3-5)
- [ ] Erros comuns documentados
- [ ] Prompt de validacao criado e testado
- [ ] Testado com pessoa que nao conhece o processo

---

## Proximos Passos

Apos criar o SOP:

1. **Teste com 1 pessoa nova** - Ela consegue executar sem perguntar?
2. **Rode o prompt de validacao** - Funciona?
3. **Ajuste o que falhou**
4. **Avance para o Modulo 4** (Delegacao Assistida)

---

**Template versao:** 1.0
**Trilha:** Pessoas & Processos
**Modulo:** 3 - SOP Inteligente
