# Aula 3.7: Exercicio - Seu Fluxo de Triagem

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 30 minutos
> **Tipo:** Pratica (Build Sprint)
> **Entregavel:** Fluxo de Triagem Personalizado
> **Linha do DRE:** Sistema de Triagem Pronto

---

## ROTEIRO DE FALA

### ABERTURA (1 minuto)

```
[OLHAR PARA CAMERA - ENERGIA ALTA]

"30 minutos pra construir seu fluxo de triagem.

Voce vai sair com:
- Prompt classificador personalizado
- Regras de roteamento definidas
- Criterios de auto-resposta
- Lista de palavras de alerta
- Testado com 20 tickets

Vamos la. Passo a passo."
```

---

### PASSO 1: PERSONALIZAR CATEGORIAS (5 minutos)

```
[COMPARTILHAR TELA - TEMPLATE]

"Primeiro: suas categorias.

Pega as categorias do seu Funil de Suporte (Modulo 1).
Adiciona definicao clara pra cada uma.

[MOSTRAR TEMPLATE]

CATEGORIAS:
- [categoria1]: [definicao clara]
- [categoria2]: [definicao clara]
- [categoria3]: [definicao clara]
...

[MOSTRAR EXEMPLO]

Se voce e e-commerce:

CATEGORIAS:
- duvida_produto: pergunta sobre caracteristicas, tamanho, cor
- status_pedido: rastreio, previsao entrega, onde esta
- troca_devolucao: quer trocar ou devolver produto
- problema_entrega: nao chegou, chegou errado, danificado
- pagamento: cobranca, boleto, parcelamento
- reclamacao: insatisfeito, critica, ameaca

[MOSTRAR DICA]

Dica: 6-10 categorias.
Menos = muito generico.
Mais = confunde a IA.

PAUSE E ESCREVA SUAS CATEGORIAS.
5 minutos."
```

---

### PASSO 2: DEFINIR CRITERIOS DE RISCO (5 minutos)

```
[MOSTRAR TEMPLATE RISCO]

"Segundo: criterios de risco.

Quais palavras indicam perigo no SEU negocio?

[MOSTRAR ESTRUTURA]

RISCO NORMAL:
- Conversa tranquila
- Sem palavras de alerta

RISCO ATENCAO:
- [suas palavras de frustração]
- [suas palavras de cancelamento]

RISCO CRITICO:
- [suas palavras de risco juridico]
- [suas palavras de risco reputacional]

[MOSTRAR EXEMPLO E-COMMERCE]

RISCO ATENCAO:
- decepcionado, frustrado, arrependido
- cancelar, devolver, trocar de loja
- demora, atrasado, nao chegou

RISCO CRITICO:
- procon, advogado, processo
- reclame aqui, redes sociais
- absurdo, vergonha, nunca mais
- terceira vez, ninguem resolve

[MOSTRAR DICA]

Dica: pensa nos tickets que te deram DOR DE CABECA.
Que palavras tinham?
Essas sao suas palavras de alerta.

PAUSE E DEFINA SEUS CRITERIOS DE RISCO.
5 minutos."
```

---

### PASSO 3: CONFIGURAR ROTEAMENTO (5 minutos)

```
[MOSTRAR TEMPLATE ROTEAMENTO]

"Terceiro: regras de roteamento.

Quem resolve o que na sua estrutura?

[MOSTRAR TEMPLATE]

AUTO (IA sozinha):
- [categorias que IA pode responder]
- Criterios: risco normal, confianca >= 90, resposta na KB

L1 (Atendente padrao):
- [categorias que L1 resolve]

L2 (Especialista):
- [categorias que precisam de especialista]

GESTOR (Lider):
- [casos que so gestor resolve]
- Qualquer risco critico

[MOSTRAR EXEMPLO]

Se voce tem 2 atendentes + 1 gestor:

AUTO:
- duvida_produto (se na FAQ)
- status_pedido (automatico)

L1:
- duvida_produto (nao ta na FAQ)
- pagamento simples

L2:
- troca_devolucao
- problema_entrega
- reclamacao leve

GESTOR:
- risco critico
- excecao de politica
- cliente VIP insatisfeito

PAUSE E DEFINA SEU ROTEAMENTO.
5 minutos."
```

---

### PASSO 4: MONTAR PROMPT COMPLETO (5 minutos)

```
[MOSTRAR TEMPLATE PROMPT]

"Quarto: juntar tudo no prompt.

[MOSTRAR ESTRUTURA]

---
Voce e um triador automatico de tickets para [SUA EMPRESA].

CATEGORIAS:
[suas categorias]

CRITERIOS DE URGENCIA:
- baixa: [seu criterio]
- media: [seu criterio]
- alta: [seu criterio]

CRITERIOS DE RISCO:
- normal: [seu criterio]
- atencao: [seu criterio]
- critico: [seu criterio]

PALAVRAS DE ALERTA:
[sua lista]

ROTEAMENTO:
- AUTO: [suas regras]
- L1: [suas regras]
- L2: [suas regras]
- GESTOR: [suas regras]

TICKET:
[ticket]

RETORNE:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
DESTINO:
ELEGIVEL_AUTO:
JUSTIFICATIVA:
---

PAUSE E MONTE SEU PROMPT.
5 minutos."
```

---

### PASSO 5: TESTAR COM 20 TICKETS (8 minutos)

```
[MOSTRAR PROCESSO DE TESTE]

"Ultimo passo: testar.

Pega 20 tickets reais do seu atendimento.
Roda cada um no prompt.
Anota os resultados.

[MOSTRAR TABELA]

| # | Ticket (resumo) | Destino IA | Correto? |
|---|-----------------|------------|----------|
| 1 | | | SIM/NAO |
| 2 | | | SIM/NAO |
...
| 20 | | | SIM/NAO |

[MOSTRAR META]

Meta: 18/20 corretos (90%)

Se menos de 90%:
- Revisa categorias (muito ambiguas?)
- Revisa regras de roteamento
- Adiciona palavras de alerta

[MOSTRAR TIPOS DE ERRO]

Erros comuns:
- Categoria errada → melhorar definicao
- Risco subestimado → adicionar palavras de alerta
- Destino errado → ajustar regras

TESTE AGORA COM 20 TICKETS.
8 minutos."
```

---

### FECHAMENTO (1 minuto)

```
[OLHAR DIRETO PARA CAMERA]

"Se voce seguiu os passos, agora tem:

- Prompt classificador personalizado
- Categorias do SEU negocio
- Palavras de alerta identificadas
- Roteamento configurado
- Testado com 20 tickets

Na proxima aula, vamos validar seu fluxo
e definir sua acao de 48 horas.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Checklist de Construcao

```
PASSO 1: CATEGORIAS (5 min)
- [ ] 6-10 categorias definidas
- [ ] Cada uma com definicao clara
- [ ] Sem sobreposicao

PASSO 2: RISCO (5 min)
- [ ] Criterios de risco normal
- [ ] Criterios de risco atencao
- [ ] Criterios de risco critico
- [ ] Lista de palavras de alerta

PASSO 3: ROTEAMENTO (5 min)
- [ ] Regras para AUTO
- [ ] Regras para L1
- [ ] Regras para L2
- [ ] Regras para GESTOR

PASSO 4: PROMPT (5 min)
- [ ] Prompt completo montado
- [ ] Todas as secoes preenchidas

PASSO 5: TESTE (8 min)
- [ ] 20 tickets testados
- [ ] Taxa >= 90% corretos
- [ ] Ajustes feitos se necessario
```

### Template: Prompt Classificador Personalizado

```
Voce e um triador automatico de tickets para [EMPRESA].

CATEGORIAS:
- [cat1]: [definicao]
- [cat2]: [definicao]
- [cat3]: [definicao]
- [cat4]: [definicao]
- [cat5]: [definicao]
- [cat6]: [definicao]

CRITERIOS DE URGENCIA:
- baixa: [criterio]
- media: [criterio]
- alta: [criterio]

CRITERIOS DE RISCO:
- normal: [criterio]
- atencao: [criterio]
- critico: [criterio]

PALAVRAS DE ALERTA CRITICO:
[lista separada por virgula]

ROTEAMENTO:
- AUTO: [categorias] + risco normal + confianca >= 90 + nao envolve dinheiro
- L1: [categorias e condicoes]
- L2: [categorias e condicoes]
- GESTOR: risco critico + [outras condicoes]

TICKET:
[cole aqui]

RETORNE:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
DESTINO:
ELEGIVEL_AUTO:
JUSTIFICATIVA:
```

### Tabela de Teste

| # | Ticket | Categoria | Urgencia | Risco | Destino | Correto? |
|---|--------|-----------|----------|-------|---------|----------|
| 1 | | | | | | |
| 2 | | | | | | |
| 3 | | | | | | |
| 4 | | | | | | |
| 5 | | | | | | |
| 6 | | | | | | |
| 7 | | | | | | |
| 8 | | | | | | |
| 9 | | | | | | |
| 10 | | | | | | |
| 11 | | | | | | |
| 12 | | | | | | |
| 13 | | | | | | |
| 14 | | | | | | |
| 15 | | | | | | |
| 16 | | | | | | |
| 17 | | | | | | |
| 18 | | | | | | |
| 19 | | | | | | |
| 20 | | | | | | |

**TOTAL CORRETOS:** ___ / 20 ( ___ %)

---

## CHECKPOINT

- [ ] Categorias personalizadas definidas
- [ ] Criterios de risco configurados
- [ ] Palavras de alerta listadas
- [ ] Roteamento configurado
- [ ] Prompt completo montado
- [ ] 20 tickets testados
- [ ] Taxa >= 90% de acerto

---

## CONEXAO COM PROXIMA AULA

> Fluxo construido e testado. Agora validacao final e acao de 48h.

**Proxima:** Aula 3.8 - Teste e Validacao

---

**Tempo real:** 30 minutos
**Impacto DRE:** Sistema de triagem personalizado pronto
