# Template: Playbook SDR com Scoring

## Trilha 7 - Vendas com IA | Modulo 2

---

## Instrucoes de Uso

1. Defina as 7 perguntas de qualificacao
2. Configure o sistema de scoring
3. Treine a IA para qualificar
4. Aplique em todos os leads
5. Ajuste com base em resultados

---

## 1. FRAMEWORK BANT+

### O Que Qualificar

| Letra | Significado | Pergunta Central |
|-------|-------------|------------------|
| **B** | Budget | Tem orcamento para investir? |
| **A** | Authority | E o decisor ou influenciador? |
| **N** | Need | Tem uma dor real que resolvo? |
| **T** | Timeline | Precisa resolver em quanto tempo? |
| **+** | Fit | E meu cliente ideal? |

---

## 2. AS 7 PERGUNTAS DE QUALIFICACAO

### Pergunta 1: DOR/NECESSIDADE

**Pergunta:** ___

**O que buscar:**
- [ ] Dor real identificada
- [ ] Impacto da dor no negocio
- [ ] Tentativas anteriores de resolver

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Dor clara e urgente | 20 |
| Dor existe mas nao urgente | 10 |
| Sem dor clara | 0 |

---

### Pergunta 2: SITUACAO ATUAL

**Pergunta:** ___

**O que buscar:**
- [ ] Como resolve hoje
- [ ] O que nao esta funcionando
- [ ] Custo da situacao atual

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Solucao atual ineficiente | 15 |
| Tem solucao parcial | 8 |
| Ja tem solucao boa | 0 |

---

### Pergunta 3: DECISOR/AUTORIDADE

**Pergunta:** ___

**O que buscar:**
- [ ] Quem decide
- [ ] Quem influencia
- [ ] Processo de decisao

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| E o decisor | 20 |
| Influenciador forte | 12 |
| Nao tem poder de decisao | 0 |

---

### Pergunta 4: ORCAMENTO

**Pergunta:** ___

**O que buscar:**
- [ ] Tem budget definido
- [ ] Faixa de investimento
- [ ] Como decide preco

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Budget aprovado | 20 |
| Budget possivel | 10 |
| Sem budget | 0 |

---

### Pergunta 5: TIMELINE

**Pergunta:** ___

**O que buscar:**
- [ ] Quando precisa resolver
- [ ] O que acontece se atrasar
- [ ] Eventos/deadlines

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Urgente (< 30 dias) | 15 |
| Proximo trimestre | 8 |
| Sem prazo definido | 0 |

---

### Pergunta 6: FIT/PERFIL

**Pergunta:** ___

**O que buscar:**
- [ ] Tamanho da empresa
- [ ] Setor compativel
- [ ] Caracteristicas do ICP

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Match perfeito com ICP | 10 |
| Match parcial | 5 |
| Fora do ICP | 0 |

---

### Pergunta 7: PROXIMO PASSO

**Pergunta:** ___

**O que buscar:**
- [ ] Disponibilidade para call
- [ ] Interesse em proposta
- [ ] Compromisso de acao

**Scoring:**
| Resposta | Pontos |
|----------|--------|
| Agenda call agora | 10 (bonus) |
| Interesse em continuar | 5 |
| Nao quer continuar | -10 |

---

## 3. SISTEMA DE SCORING

### Tabela de Pontuacao

| Pergunta | Pontuacao Maxima |
|----------|------------------|
| 1. Dor/Necessidade | 20 |
| 2. Situacao Atual | 15 |
| 3. Decisor | 20 |
| 4. Orcamento | 20 |
| 5. Timeline | 15 |
| 6. Fit | 10 |
| 7. Proximo passo | 10 (bonus) |
| **TOTAL MAXIMO** | **100 (+10)** |

### Classificacao

| Score | Classificacao | Acao |
|-------|---------------|------|
| 80-100 | 🟢 Hot Lead | Prioridade maxima, call imediata |
| 60-79 | 🟡 Warm Lead | Follow-up ativo, nutrir |
| 40-59 | 🟠 Cold Lead | Nurturing automatizado |
| 0-39 | 🔴 Descartado | Nao investir tempo |

---

## 4. TEMPLATE DE QUALIFICACAO

### Ficha do Lead

| Campo | Valor |
|-------|-------|
| **Nome** | |
| **Empresa** | |
| **Cargo** | |
| **Telefone** | |
| **Email** | |
| **Origem** | |
| **Data** | |

### Respostas

| # | Pergunta | Resposta | Pontos |
|---|----------|----------|--------|
| 1 | Dor | | /20 |
| 2 | Situacao | | /15 |
| 3 | Decisor | | /20 |
| 4 | Orcamento | | /20 |
| 5 | Timeline | | /15 |
| 6 | Fit | | /10 |
| 7 | Proximo passo | | /10 |
| **TOTAL** | | | **/100** |

### Classificacao: 🟢 🟡 🟠 🔴

### Proxima Acao: ___

---

## 5. SCRIPTS POR CANAL

### WhatsApp (Qualificacao Rapida)

```
Oi [NOME]! Aqui e [SEU NOME] da [EMPRESA].

Vi que voce demonstrou interesse em [PRODUTO/OFERTA].

Pra eu entender melhor como posso te ajudar, me conta:

1. Qual seu maior desafio com [AREA] hoje?
2. Voce ja tentou resolver isso antes?

Assim consigo te direcionar pro melhor caminho! 🙂
```

### Telefone (Script Completo)

```
ABERTURA (30s):
"Oi [NOME], aqui e [SEU NOME] da [EMPRESA].
Vi que voce [ORIGEM DO LEAD].
Posso te fazer algumas perguntas rapidas pra entender
se faz sentido a gente conversar?"

QUALIFICACAO (5 min):
[Fazer as 7 perguntas]

FECHAMENTO (30s):
SE QUALIFICADO:
"Pelo que voce me contou, acho que faz muito sentido
a gente conversar com mais calma. Que tal agendarmos
uma call de 30 min? Tenho [DATA/HORA], funciona?"

SE NAO QUALIFICADO:
"Obrigado por compartilhar! Pelo que entendi, talvez
nao seja o melhor momento. Posso te adicionar na nossa
lista pra enviar conteudos uteis?"
```

---

## 6. PROMPT DE IA PARA QUALIFICAR

```
Qualifique este lead usando BANT+:

INFORMACOES DO LEAD:
Nome: ___
Empresa: ___
Cargo: ___
Origem: ___

RESPOSTAS COLETADAS:
[Cole as respostas das 7 perguntas]

MEU PRODUTO:
- O que vendo: ___
- Preco: R$ ___
- ICP ideal: ___

Analise e responda:
1. Score de cada pergunta (justificado)
2. Score total (/100)
3. Classificacao (Hot/Warm/Cold/Descartado)
4. Pontos fortes do lead
5. Pontos de atencao
6. Proxima acao recomendada
7. Perguntas adicionais se necessario
```

---

## 7. DASHBOARD SDR

### Metricas Diarias

| Metrica | Meta | Realizado | % |
|---------|------|-----------|---|
| Leads qualificados | | | % |
| Calls realizadas | | | % |
| Hot leads gerados | | | % |
| Agendamentos | | | % |

### Distribuicao de Scores

| Classificacao | Quantidade | % |
|---------------|------------|---|
| 🟢 Hot | | % |
| 🟡 Warm | | % |
| 🟠 Cold | | % |
| 🔴 Descartado | | % |

---

## 8. CHECKLIST DE VALIDACAO

- [ ] 7 perguntas definidas
- [ ] Scoring configurado
- [ ] Scripts por canal criados
- [ ] Prompt de IA testado
- [ ] Time treinado
- [ ] Dashboard configurado

---

## 9. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Criar playbook com 7 perguntas
- [ ] Qualificar 10 leads com o novo sistema
- [ ] Ajustar scoring se necessario

**Leads para qualificar:** ___

---

**Template versao:** 1.0
**Trilha:** Vendas com IA
**Modulo:** 2 - SDR com IA
