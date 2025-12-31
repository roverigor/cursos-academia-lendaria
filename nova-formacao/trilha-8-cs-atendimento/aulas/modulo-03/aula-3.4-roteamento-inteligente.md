# Aula 3.4: Roteamento Inteligente - L1, L2, Especialista

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 8 minutos
> **Tipo:** Teoria (Framework)
> **Entregavel:** Matriz de Roteamento
> **Linha do DRE:** Eficiencia de Atendimento

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM DIRETO]

"IA classificou o ticket.
Categoria: financeiro.
Urgencia: alta.
Risco: atencao.

E agora? Pra quem vai?

Isso e ROTEAMENTO.
Decidir automaticamente quem resolve cada ticket.

Sem roteamento, ticket classificado
ainda precisa de humano pra distribuir.

Com roteamento, ticket ja chega na pessoa certa.
Zero intervencao manual."
```

---

### OS NIVEIS DE ATENDIMENTO (2 minutos)

```
[MOSTRAR PIRAMIDE]

"Primeiro: os niveis.

[MOSTRAR DIAGRAMA]

L1 - LINHA DE FRENTE
- Resolve: duvidas simples, FAQ, status
- Perfil: atendente padrao
- Tempo: resposta rapida
- Custo: mais baixo

L2 - ESPECIALISTA
- Resolve: problemas tecnicos, casos complexos
- Perfil: tecnico, senior
- Tempo: pode demorar mais
- Custo: medio

L3/GESTOR
- Resolve: reclamacoes graves, decisoes de excecao
- Perfil: lider, gestor, dono
- Tempo: prioridade maxima
- Custo: mais alto

AUTO
- Resolve: FAQ automatica, status, confirmacoes
- Perfil: IA sozinha
- Tempo: instantaneo
- Custo: quase zero

[MOSTRAR LOGICA]

A logica e simples:
- Comeca no nivel mais BARATO que resolve
- So escala se precisar
- Gestor e ultimo recurso, nao primeiro"
```

---

### REGRAS DE ROTEAMENTO (2.5 minutos)

```
[MOSTRAR TABELA DE REGRAS]

"Agora as regras.

[MOSTRAR NA TELA]

| Categoria | Urgencia | Risco | Destino |
|-----------|----------|-------|---------|
| duvida | baixa | normal | AUTO |
| duvida | media | normal | L1 |
| duvida | alta | normal | L1 |
| problema_tecnico | qualquer | normal | L2 |
| financeiro | baixa | normal | L1 |
| financeiro | media+ | atencao | L2 |
| financeiro | qualquer | critico | GESTOR |
| onboarding | qualquer | normal | AUTO |
| status | qualquer | normal | AUTO |
| reclamacao | qualquer | normal | L2 |
| reclamacao | qualquer | critico | GESTOR |
| qualquer | qualquer | critico | GESTOR |

[EXPLICAR]

Veja o padrao:

- Duvida simples? AUTO ou L1
- Problema tecnico? Sempre L2
- Financeiro? Depende do risco
- Reclamacao? No minimo L2
- Risco critico? Sempre GESTOR

[MOSTRAR REGRA DE OURO]

Regra de ouro:
RISCO CRITICO sempre vai pro GESTOR.
Nao importa a categoria."
```

---

### FILAS E CAPACIDADE (2 minutos)

```
[MOSTRAR DIAGRAMA DE FILAS]

"Roteamento tambem considera CAPACIDADE.

[MOSTRAR PROBLEMA]

Problema comum:
- L2 tem 2 pessoas
- Chega 20 tickets tecnicos
- Fila explode
- SLA estoura

[MOSTRAR SOLUCAO]

Solucao: regras de overflow.

Se L2 tem mais de X tickets na fila:
- Tickets de urgencia baixa vao pra L1 com script
- Ou entram em fila de espera com aviso pro cliente
- Ou notifica gestor pra reforcar

[MOSTRAR EXEMPLO]

Exemplo de regra:

'SE fila_L2 > 10 E urgencia = baixa
 ENTAO rotear para L1 com script_basico

 SE fila_L2 > 20
 ENTAO notificar gestor'

[MOSTRAR MONITORAMENTO]

Monitorar:
- Tamanho de cada fila
- Tempo medio na fila
- Taxa de overflow"
```

---

### CONFIGURANDO NO PROMPT (1 minuto)

```
[MOSTRAR PROMPT ATUALIZADO]

"Como adicionar roteamento no prompt classificador?

[MOSTRAR ADICAO]

Adiciona isso no final do prompt:

'REGRAS DE ROTEAMENTO:
- duvida + normal + confianca > 90 → AUTO
- duvida + qualquer outro caso → L1
- problema_tecnico → L2
- financeiro + risco normal → L1
- financeiro + risco atencao+ → L2
- reclamacao → L2
- RISCO CRITICO (qualquer) → GESTOR

DESTINO FINAL: [AUTO | L1 | L2 | GESTOR]'

[MOSTRAR RESULTADO]

Agora o prompt retorna tambem o DESTINO.
Nao so classifica, mas ROTEIA."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Roteamento inteligente:
- Ticket ja chega na pessoa certa
- Zero distribuicao manual
- Gestor so ve o que PRECISA ver
- L1 nao perde tempo com tecnico
- L2 nao perde tempo com FAQ

Na proxima aula, vamos ver a AUTO-RESPOSTA.
Quando IA pode responder SOZINHA?
Quais casos sao seguros?

Te vejo la."
```

---

## MATERIAL DE APOIO

### Os Niveis de Atendimento

| Nivel | Quem | Resolve | Custo |
|-------|------|---------|-------|
| AUTO | IA | FAQ, status, confirmacao | Quase zero |
| L1 | Atendente padrao | Duvidas, onboarding | Baixo |
| L2 | Especialista | Tecnico, financeiro, reclamacao | Medio |
| GESTOR | Lider/Dono | Critico, excecao, decisao | Alto |

### Matriz de Roteamento Completa

| Categoria | Urgencia | Risco | Confianca | Destino |
|-----------|----------|-------|-----------|---------|
| duvida | baixa | normal | >90% | AUTO |
| duvida | baixa | normal | <90% | L1 |
| duvida | media+ | normal | - | L1 |
| problema_tecnico | - | normal | - | L2 |
| problema_tecnico | - | critico | - | GESTOR |
| financeiro | baixa | normal | - | L1 |
| financeiro | media+ | atencao | - | L2 |
| financeiro | - | critico | - | GESTOR |
| onboarding | - | normal | >90% | AUTO |
| onboarding | - | - | <90% | L1 |
| status | - | - | - | AUTO |
| reclamacao | - | normal | - | L2 |
| reclamacao | - | critico | - | GESTOR |
| - | - | critico | - | GESTOR |

### Regras de Overflow

```
SE fila_L1 > 15 E urgencia = baixa
  → Resposta automatica: "Recebemos, responderemos em X horas"

SE fila_L2 > 10 E urgencia = baixa
  → Rotear para L1 com script basico

SE fila_L2 > 10 E urgencia = alta
  → Notificar gestor

SE qualquer_fila > 20
  → Alerta vermelho: precisa reforco
```

---

## PROMPT COM ROTEAMENTO

```
[Adicionar ao prompt classificador]

REGRAS DE ROTEAMENTO:
- duvida + risco normal + confianca >= 90 → AUTO
- duvida + qualquer outro caso → L1
- problema_tecnico + risco normal → L2
- problema_tecnico + risco critico → GESTOR
- financeiro + risco normal → L1
- financeiro + risco atencao → L2
- financeiro + risco critico → GESTOR
- onboarding + confianca >= 90 → AUTO
- onboarding + confianca < 90 → L1
- status → AUTO
- reclamacao + risco normal → L2
- reclamacao + risco atencao/critico → GESTOR
- QUALQUER + risco critico → GESTOR

Retorne tambem:
DESTINO: [AUTO | L1 | L2 | GESTOR]
```

---

## CHECKPOINT

- [ ] Entendi os niveis L1, L2, GESTOR, AUTO
- [ ] Sei quando usar cada nivel
- [ ] Tenho matriz de roteamento definida
- [ ] Sei configurar regras de overflow
- [ ] Prompt atualizado com roteamento

---

## CONEXAO COM PROXIMA AULA

> Classificou, roteou. Agora: quando IA pode responder SOZINHA? Auto-resposta segura.

**Proxima:** Aula 3.5 - Auto-Resposta Segura

---

**Tempo real:** 8 minutos
**Impacto DRE:** Distribuicao automatica de tickets
