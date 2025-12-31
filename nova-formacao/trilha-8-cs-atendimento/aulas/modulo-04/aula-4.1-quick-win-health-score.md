# Aula 4.1: Quick Win - Health Score Express

## Trilha 8 - CS e Atendimento | Modulo 4

---

> **Duracao:** 5 minutos
> **Tipo:** Quick Win (Exercicio Guiado)
> **Entregavel:** Health Score de 1 Cliente
> **Linha do DRE:** Retencao / Churn

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - ENERGIA ALTA]

"Qual cliente seu vai cancelar no proximo mes?

Voce sabe?
A maioria dos empresarios nao sabe.
Descobre quando ja e tarde demais.

Nos proximos 5 minutos, voce vai calcular
o Health Score de 1 cliente.
E descobrir se ele ta saudavel ou em risco.

Pega um cliente na cabeca. Vamos la."
```

---

### PASSO 1: ESCOLHER UM CLIENTE (30 segundos)

```
[MOSTRAR CRITERIOS]

"Primeiro: escolhe um cliente pra analisar.

Pode ser:
- Seu maior cliente
- Um cliente que te preocupa
- Alguem que comprou recentemente

Pensa no nome agora.
Vamos calcular a saude dele."
```

---

### PASSO 2: OS 5 INDICADORES (2 minutos)

```
[MOSTRAR TABELA NA TELA]

"Vou te dar 5 perguntas simples.
Responde SIM ou NAO pra cada uma.

[MOSTRAR PERGUNTAS]

1. ENGAJAMENTO
   Esse cliente usou seu produto/servico nos ultimos 7 dias?
   SIM = +20 pontos | NAO = 0 pontos

2. SATISFACAO
   Ultimo feedback dele foi positivo (NPS >= 7)?
   SIM = +20 pontos | NAO/NENHUM = 0 pontos

3. PAGAMENTO
   Esta em dia com pagamentos?
   SIM = +20 pontos | NAO = 0 pontos

4. SUPORTE
   Abriu reclamacao nos ultimos 30 dias?
   NAO = +20 pontos | SIM = 0 pontos

5. RELACIONAMENTO
   Respondeu sua ultima comunicacao?
   SIM = +20 pontos | NAO = 0 pontos

Soma os pontos."
```

---

### PASSO 3: INTERPRETAR O SCORE (1 minuto)

```
[MOSTRAR FAIXAS]

"Qual foi a soma?

[MOSTRAR INTERPRETACAO]

80-100 pontos: SAUDAVEL
→ Cliente engajado, satisfeito, pagando
→ Acao: manter relacionamento, oferecer upgrade

40-79 pontos: ATENCAO
→ Algum sinal de alerta
→ Acao: intervencao proativa em 7 dias

0-39 pontos: RISCO
→ Multiplos sinais negativos
→ Acao: intervencao URGENTE, ligar hoje

[MOSTRAR EXEMPLO]

Meu cliente exemplo:
- Usou nos ultimos 7 dias? SIM (+20)
- NPS positivo? NAO (0)
- Pagamento em dia? SIM (+20)
- Reclamacao recente? SIM (0)
- Respondeu comunicacao? NAO (0)

Total: 40 pontos = ATENCAO

Esse cliente precisa de acao em 7 dias."
```

---

### PASSO 4: SUA ACAO IMEDIATA (30 segundos)

```
[ENERGIA ALTA]

"Qual foi o score do seu cliente?

Se RISCO (< 40):
→ Liga HOJE. Antes que cancele.

Se ATENCAO (40-79):
→ Agenda contato essa semana.

Se SAUDAVEL (80+):
→ Otimo! Agora faz pra mais 5 clientes.

Anota o score e a acao."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Em 5 minutos voce fez algo que 90% nao faz:
mediu a saude de um cliente.

Agora imagina isso pra TODOS os clientes.
Automaticamente.
Todo dia.

Na proxima aula, vou te mostrar
quanto custa o churn SILENCIOSO.
E por que prevencao vale mais que reacao.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Formula Health Score Express

| Indicador | Pergunta | SIM | NAO |
|-----------|----------|-----|-----|
| Engajamento | Usou ultimos 7 dias? | +20 | 0 |
| Satisfacao | NPS >= 7? | +20 | 0 |
| Pagamento | Em dia? | +20 | 0 |
| Suporte | SEM reclamacao 30 dias? | +20 | 0 |
| Relacionamento | Respondeu comunicacao? | +20 | 0 |
| **TOTAL** | | **/100** | |

### Faixas de Saude

| Score | Faixa | Cor | Acao |
|-------|-------|-----|------|
| 80-100 | Saudavel | Verde | Manter + upsell |
| 40-79 | Atencao | Amarelo | Intervencao 7 dias |
| 0-39 | Risco | Vermelho | Acao urgente HOJE |

### Acoes por Faixa

| Faixa | Acao Imediata |
|-------|---------------|
| RISCO | Ligar hoje, oferecer ajuda, entender problema |
| ATENCAO | Email/mensagem em 7 dias, oferecer call |
| SAUDAVEL | Mantem relacionamento, oferece novidades |

---

## PROMPT DE IA PARA CALCULAR

```
Calcule o Health Score deste cliente:

CLIENTE: [nome]

INDICADORES:
1. Usou produto/servico nos ultimos 7 dias? [SIM/NAO]
2. Ultimo NPS/feedback foi >= 7? [SIM/NAO/NENHUM]
3. Pagamento em dia? [SIM/NAO]
4. Abriu reclamacao ultimos 30 dias? [SIM/NAO]
5. Respondeu ultima comunicacao? [SIM/NAO]

Calcule:
- Score total (0-100)
- Faixa (saudavel/atencao/risco)
- Acao recomendada
- Urgencia
```

---

## CHECKPOINT

- [ ] Escolhi um cliente
- [ ] Respondi os 5 indicadores
- [ ] Calculei o Health Score
- [ ] Sei a faixa (saudavel/atencao/risco)
- [ ] Defini acao imediata

---

## CONEXAO COM PROXIMA AULA

> Calculou o score de 1 cliente. Agora vamos entender o CUSTO de nao fazer isso pra todos.

**Proxima:** Aula 4.2 - O Custo do Churn Silencioso

---

**Tempo real:** 5 minutos
**Impacto DRE:** Primeira medicao de saude de cliente
