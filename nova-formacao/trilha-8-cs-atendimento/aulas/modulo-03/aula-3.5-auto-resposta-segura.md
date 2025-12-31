# Aula 3.5: Auto-Resposta Segura

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 7 minutos
> **Tipo:** Template (Framework)
> **Entregavel:** Criterios de Auto-Resposta
> **Linha do DRE:** Automacao Maxima com Seguranca

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM CAUTELOSO]

"Auto-resposta e o santo graal.

IA responde sozinha.
Humano nem ve.
Custo zero.

Mas tambem e o maior RISCO.

Se IA responder errado em caso sensivel,
voce tem problema.

Hoje vou te ensinar QUANDO e seguro
deixar IA responder sozinha.
E quando SEMPRE precisa de humano."
```

---

### O ESPECTRO DE AUTOMACAO (2 minutos)

```
[MOSTRAR ESPECTRO]

"Existem 4 niveis de automacao:

[MOSTRAR DIAGRAMA]

1. AUTO TOTAL
   - IA responde e envia
   - Humano nem ve
   - Ex: FAQ simples, status

2. AUTO COM SUPERVISAO
   - IA gera resposta
   - Humano revisa antes de enviar
   - Ex: duvidas mais complexas

3. SUGESTAO
   - IA sugere resposta
   - Humano edita e envia
   - Ex: problemas tecnicos

4. MANUAL
   - IA so classifica
   - Humano escreve do zero
   - Ex: reclamacao grave, juridico

[MOSTRAR DISTRIBUICAO IDEAL]

Distribuicao ideal:
- Auto Total: 30-40% dos tickets
- Auto com Supervisao: 20-30%
- Sugestao: 20-30%
- Manual: 10-20%

Quanto mais pra esquerda, mais eficiente.
Mas SEGURANCA vem primeiro."
```

---

### CRITERIOS PARA AUTO TOTAL (2 minutos)

```
[MOSTRAR CRITERIOS]

"Quando IA pode responder SOZINHA?

[MOSTRAR CHECKLIST]

TODOS esses criterios precisam ser TRUE:

✓ Categoria = duvida, onboarding ou status
✓ Risco = normal
✓ Confianca >= 90%
✓ Resposta existe na KB
✓ Nao envolve dinheiro
✓ Nao envolve decisao de excecao
✓ Nao e cliente VIP/alto valor

[MOSTRAR EXEMPLOS]

Exemplos de AUTO TOTAL seguro:

'Qual o horario de funcionamento?'
→ FAQ, risco normal, resposta na KB ✓

'Como resetar minha senha?'
→ How-to, risco normal, passo a passo ✓

'Meu pedido ja foi enviado?'
→ Status, automatico por definicao ✓

[MOSTRAR CONTRA-EXEMPLOS]

NAO e seguro para AUTO TOTAL:

'Quero cancelar minha assinatura'
→ Envolve decisao financeira ✗

'Estou decepcionado com o servico'
→ Risco atencao, precisa empatia humana ✗

'Podem fazer uma excecao no meu caso?'
→ Decisao de excecao, humano decide ✗"
```

---

### REGRAS DE SEGURANCA (1.5 minutos)

```
[MOSTRAR REGRAS]

"Regras que NUNCA quebra:

[MOSTRAR LISTA]

NUNCA auto-responde:
- Qualquer coisa que envolve DINHEIRO
- Reclamacao (qualquer nivel)
- Pedido de excecao
- Cliente VIP (identificado por tag)
- Risco != normal
- Confianca < 90%
- Resposta nao esta na KB

SEMPRE marca '[VERIFICAR]' se:
- Resposta pode estar desatualizada
- Caso e ligeiramente atipico
- Multiplas interpretacoes possiveis

[MOSTRAR CONSEQUENCIA]

Se quebrar essas regras:
- IA promete algo que nao pode
- Cliente fica mais irritado
- Voce tem que desfazer o prometido
- Pior do que nao ter automatizado"
```

---

### CONFIGURANDO NO FLUXO (1 minuto)

```
[MOSTRAR FLUXO COMPLETO]

"Como fica no fluxo completo:

[MOSTRAR DIAGRAMA]

TICKET CHEGA
    ↓
IA CLASSIFICA
(categoria, urgencia, risco, confianca)
    ↓
VERIFICA CRITERIOS AUTO
    ↓
┌─── TODOS OK? ───┐
│                 │
SIM              NAO
 ↓                ↓
AUTO TOTAL    ROTEAR PARA
(envia)       L1/L2/GESTOR

[MOSTRAR NO PROMPT]

No prompt, adiciona:

'ELEGIVEL_AUTO: [TRUE | FALSE]
Criterios:
- Categoria = duvida/onboarding/status
- Risco = normal
- Confianca >= 90
- Resposta na KB
- Nao envolve dinheiro'

Se ELEGIVEL_AUTO = TRUE e DESTINO = AUTO:
→ Gerar resposta e enviar

Se ELEGIVEL_AUTO = FALSE:
→ Rotear para humano"
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Auto-resposta e poderoso.
Mas so funciona com criterios rigidos.

Quando e seguro, deixa IA voar.
Quando tem risco, humano assume.

Esse equilibrio e o que faz o sistema funcionar.

Na proxima aula, vou mostrar TUDO funcionando junto.
Classificacao, roteamento, auto-resposta.
Demo completa.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Espectro de Automacao

| Nivel | IA faz | Humano faz | Quando usar |
|-------|--------|------------|-------------|
| Auto Total | Responde + Envia | Nada | FAQ, status |
| Auto + Supervisao | Gera resposta | Revisa + Envia | Duvidas complexas |
| Sugestao | Sugere resposta | Edita + Envia | Problemas tecnicos |
| Manual | So classifica | Escreve tudo | Reclamacao, juridico |

### Checklist: Elegivel para Auto Total?

```
□ Categoria = duvida, onboarding OU status
□ Risco = normal
□ Confianca >= 90%
□ Resposta existe na KB
□ NAO envolve dinheiro
□ NAO e pedido de excecao
□ NAO e cliente VIP

TODOS marcados? → AUTO TOTAL
Algum desmarcado? → HUMANO
```

### Lista NUNCA Auto-Responde

- Reembolso / cancelamento
- Cobranca / pagamento
- Reclamacao (qualquer nivel)
- Pedido de excecao
- Mencao a Procon / advogado
- Cliente VIP / alto valor
- Risco != normal
- Confianca < 90%
- Resposta nao esta na KB

### Adicao ao Prompt

```
Apos classificacao, avalie:

ELEGIVEL_AUTO: [TRUE | FALSE]

Criterios para TRUE:
1. Categoria IN (duvida, onboarding, status)
2. Risco = normal
3. Confianca >= 90
4. Nao menciona dinheiro/reembolso/cancelamento
5. Nao pede excecao

Se FALSE, explique qual criterio falhou.
```

---

## CHECKPOINT

- [ ] Entendi os 4 niveis de automacao
- [ ] Sei os criterios para auto-resposta segura
- [ ] Conheço a lista "NUNCA auto-responde"
- [ ] Sei configurar elegibilidade no prompt
- [ ] Pronto pra ver demo completa

---

## CONEXAO COM PROXIMA AULA

> Temos classificacao, roteamento, auto-resposta. Hora de ver tudo funcionando junto.

**Proxima:** Aula 3.6 - Demo: Fluxo de Triagem Completo

---

**Tempo real:** 7 minutos
**Impacto DRE:** Maximizar automacao com seguranca
