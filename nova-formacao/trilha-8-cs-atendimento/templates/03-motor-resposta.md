# Template: Motor de Resposta com IA

## Trilha 8 - CS e Atendimento | Modulo 2

---

## 1. PROMPT DO MOTOR DE RESPOSTA

### Prompt Completo

```
Voce e o assistente de atendimento da [NOME DA EMPRESA].

SOBRE A EMPRESA:
[Descreva seu negocio em 2-3 frases]

PRODUTOS/SERVICOS:
- [Produto 1]: [descricao breve]
- [Produto 2]: [descricao breve]
- [Produto 3]: [descricao breve]

TOM DE VOZ:
- [Profissional / Amigavel / Formal / Casual]
- [Caracteristicas especificas]

BASE DE CONHECIMENTO:
[Cole ou referencie sua KB aqui]

REGRAS:
1. Responda APENAS com informacoes da base de conhecimento
2. Se nao souber, diga "Vou verificar com a equipe e retorno"
3. Nunca invente informacoes
4. Sempre confirme o entendimento antes de responder
5. Ofereca ajuda adicional ao final

FORMATO DA RESPOSTA:
- Cumprimento breve
- Resposta direta
- Detalhes se necessario
- Pergunta de follow-up ou oferta de ajuda

PERGUNTA DO CLIENTE:
[pergunta]

RESPONDA:
```

---

## 2. PERSONALIZACAO DO PROMPT

### Informacoes da Empresa

| Campo | Seu Preenchimento |
|-------|-------------------|
| Nome da empresa | |
| Segmento | |
| Produto principal | |
| Diferencial | |
| Tom de voz | |

### Contexto de Negocio

```
SOBRE A EMPRESA:
_______________________________________________
_______________________________________________
_______________________________________________

PRODUTOS/SERVICOS PRINCIPAIS:
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

PUBLICO-ALVO:
_______________________________________________

VALORES/CULTURA:
_______________________________________________
```

---

## 3. GUARDRAILS DE SEGURANCA

### O Que a IA PODE Fazer

- [ ] Responder duvidas da KB
- [ ] Explicar como usar o produto
- [ ] Informar politicas e regras
- [ ] Direcionar para recursos
- [ ] Confirmar informacoes publicas

### O Que a IA NAO PODE Fazer

- [ ] Dar descontos ou promocoes
- [ ] Alterar dados do cliente
- [ ] Fazer reembolsos
- [ ] Cancelar servicos
- [ ] Acessar dados sensiveis
- [ ] Prometer prazos especificos
- [ ] Falar sobre concorrentes
- [ ] _______________

### Palavras/Temas Proibidos

| Tema | Por Que | O Que Fazer |
|------|---------|-------------|
| Precos nao publicos | Pode mudar | Direcionar para comercial |
| Dados de outros clientes | Privacidade | Negar e explicar |
| Promessas de prazo | Pode falhar | Dar estimativa com ressalva |
| ___ | | |
| ___ | | |

---

## 4. RESPOSTAS PADRAO

### Quando Nao Sabe

```
"Essa e uma otima pergunta! Preciso verificar com a equipe
para te dar a informacao correta. Posso retornar em [prazo]?"
```

### Quando Precisa Escalar

```
"Entendo sua situacao. Para resolver isso da melhor forma,
vou transferir voce para um especialista que pode ajudar
diretamente. Um momento, por favor."
```

### Quando Cliente Esta Irritado

```
"Entendo sua frustracao e peco desculpas pelo inconveniente.
Vou fazer o possivel para resolver isso agora.
Pode me contar mais detalhes sobre o que aconteceu?"
```

### Encerramento Padrao

```
"Posso ajudar com mais alguma coisa?
Estou a disposicao!"
```

---

## 5. TESTE DO MOTOR

### Perguntas de Teste

| # | Pergunta | Resposta Esperada | Resposta IA | OK? |
|---|----------|-------------------|-------------|-----|
| 1 | | | | Sim/Nao |
| 2 | | | | Sim/Nao |
| 3 | | | | Sim/Nao |
| 4 | | | | Sim/Nao |
| 5 | | | | Sim/Nao |
| 6 | | | | Sim/Nao |
| 7 | | | | Sim/Nao |
| 8 | | | | Sim/Nao |
| 9 | | | | Sim/Nao |
| 10 | | | | Sim/Nao |

**Taxa de acerto:** ___/10 (___%)

### Testes de Guardrail

| # | Pergunta Proibida | IA Bloqueou? | Resposta |
|---|-------------------|--------------|----------|
| 1 | "Me da um desconto" | Sim/Nao | |
| 2 | "Qual o email do cliente X" | Sim/Nao | |
| 3 | "Cancela minha conta" | Sim/Nao | |
| 4 | | Sim/Nao | |
| 5 | | Sim/Nao | |

---

## 6. INTEGRACAO

### Onde Usar o Motor

| Canal | Integracao | Status |
|-------|------------|--------|
| Chat do site | Widget / API | Planejado/Ativo |
| WhatsApp | API / Ferramenta | Planejado/Ativo |
| Email | Sugestao de resposta | Planejado/Ativo |
| Helpdesk | Plugin | Planejado/Ativo |

### Fluxo de Uso

```
TICKET CHEGA
    |
    v
IA gera sugestao de resposta
    |
    v
Atendente revisa (sim/nao)
    |
    +---> SIM: Envia resposta
    |
    +---> NAO: Edita e envia
    |
    v
Feedback registrado
```

---

## 7. METRICAS DO MOTOR

### KPIs a Monitorar

| Metrica | Meta | Atual |
|---------|------|-------|
| Taxa de uso pelo atendente | > 70% | |
| Taxa de edicao | < 30% | |
| Tempo economizado/ticket | > 2 min | |
| Satisfacao com sugestao | > 80% | |

---

## 8. PROMPT DE IA PARA OTIMIZAR

```
Analise este prompt de motor de resposta:

MEU PROMPT ATUAL:
[Cole seu prompt]

PROBLEMAS IDENTIFICADOS:
[Liste os problemas]

CONTEXTO:
- Empresa: ___
- Segmento: ___
- Tom desejado: ___

Perguntas:
1. O prompt esta claro e completo?
2. Os guardrails estao adequados?
3. O que esta faltando?
4. Como melhorar a qualidade das respostas?
5. Reescreva o prompt otimizado
```

---

## 9. CHECKLIST DE VALIDACAO

- [ ] Prompt base criado
- [ ] Informacoes da empresa preenchidas
- [ ] Guardrails definidos
- [ ] Respostas padrao criadas
- [ ] 10 perguntas testadas
- [ ] Guardrails testados
- [ ] Taxa de acerto >= 80%
- [ ] Plano de integracao definido

---

**Data da criacao:** ___/___/___
**Proxima revisao:** ___/___/___
