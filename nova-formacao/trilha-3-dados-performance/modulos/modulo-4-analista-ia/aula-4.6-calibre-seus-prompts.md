# Aula 4.6: Seu Turno - Calibre Seus Prompts

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Analista de Dados com IA |
| **Aula** | 4.6 |
| **Tipo** | Exercício |
| **Duração** | 20 minutos |
| **Conceitos** | 2 (Calibração de prompts + Iteração) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter seus 4 prompts testados e calibrados — funcionando com SEUS dados reais.**
>
> Não é teoria. É seu sistema de análise funcionando.

---

## 🗺️ P - POSITION (Origem)

> "E se o prompt não funcionar bem?"
>
> Normal. Primeiro teste raramente é perfeito.
>
> Por isso existe calibração.
>
> Você testa, vê o que falta, ajusta, testa de novo.
>
> 2-3 rodadas e fica bom.

---

## 🛤️ S - STEPS (Rota)

### Antes de Começar

**Checklist de preparação:**

| Item | ✅ / ❌ |
|------|--------|
| Contexto do negócio escrito (aula 4.4) | |
| 4 prompts salvos (aula 4.5) | |
| Claude ou ChatGPT aberto | |
| Dados reais do seu negócio prontos | |

**Se não tem todos:** Volte nas aulas 4.4 e 4.5.

---

### Exercício 1: Teste o Prompt de Performance (5 min)

**Passo a passo:**

1. **Abra Claude ou ChatGPT**
   - Se usa Projetos/Custom Instructions, contexto já está lá
   - Se não, cole o contexto primeiro

2. **Cole seus dados reais**
   - Exporte do dashboard ou planilha
   - Dados do mês atual: faturamento, conversão, etc.

3. **Cole o prompt de Performance**
   - Ajuste a meta pro seu valor real

4. **Execute e avalie**
   - A resposta faz sentido?
   - Faltou alguma informação?
   - Sobrou algo desnecessário?

5. **Itere**
   - Se a resposta foi vaga: adicione mais contexto
   - Se ignorou algo importante: peça explicitamente
   - Se foi longa demais: especifique "responda em X bullets"

**Template de iteração:**
```
A análise ficou boa, mas:
- Adicione [X]
- Remova [Y]
- Seja mais específico sobre [Z]

Refaça a análise.
```

---

### Exercício 2: Teste o Prompt Investigativo (5 min)

**Escolha um problema real:**
- Métrica que caiu recentemente
- Resultado abaixo do esperado
- Mudança que você não entendeu

**Execute o prompt e avalie:**

| Critério | ✅ / ❌ |
|----------|--------|
| Hipóteses fazem sentido | |
| Usou os dados que forneci | |
| Evidências são concretas, não genéricas | |
| Próximos passos são acionáveis | |

**Se falhar em algum:**
```
Refine sua análise:
- As hipóteses estão genéricas. Use os dados que forneci.
- Quero evidências numéricas, não suposições.
- Os próximos passos devem ser ações que eu consigo fazer amanhã.
```

---

### Exercício 3: Teste o Prompt Preditivo (5 min)

**Use dados dos últimos 3 meses + mês atual:**

1. Cole dados históricos (mês a mês)
2. Cole dados do mês atual até agora
3. Execute o prompt de Projeção

**Avalie a resposta:**

| Critério | ✅ / ❌ |
|----------|--------|
| Projeção é numérica e específica | |
| Cenários (otimista/realista/pessimista) fazem sentido | |
| Identifica claramente a alavanca principal | |
| Confiança tem justificativa | |

**Ajuste se necessário:**
```
A projeção está vaga. Quero:
- Número exato projetado (não range)
- % de probabilidade de bater meta
- Exatamente quanto preciso melhorar em [métrica] pra chegar na meta
```

---

### Exercício 4: Teste o Prompt Comparativo (5 min)

**Compare 2 períodos:**
- Mês atual vs mês anterior
- Semana atual vs semana passada
- Este trimestre vs mesmo período ano passado

**Cole dados dos 2 períodos e execute.**

**Avalie:**

| Critério | ✅ / ❌ |
|----------|--------|
| Tabela comparativa clara | |
| Variações % calculadas corretamente | |
| Identifica tendência geral | |
| Explica as maiores mudanças | |

---

### Checklist de Calibração

| Prompt | Testado | Funciona | Ajustado |
|--------|---------|----------|----------|
| Performance | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| Investigativo | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| Preditivo | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| Comparativo | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |

**Resultado:**
- 4/4 funcionando → **COMPLETO**
- 2-3/4 funcionando → **QUASE** - Refine os que faltam
- <2/4 funcionando → **EM PROGRESSO** - Volte no contexto

---

### 🤔 Pergunta Reflexiva

> "Qual prompt teve a melhor resposta de primeira?"
>
> "Qual precisou de mais ajustes?"
>
> Os que precisaram de ajustes provavelmente tinham contexto insuficiente.

---

### Dicas de Troubleshooting

| Problema | Solução |
|----------|---------|
| Respostas muito genéricas | Adicione mais números no contexto |
| Ignora dados importantes | Destaque: "Preste atenção especial em [X]" |
| Respostas muito longas | Especifique: "Máximo 5 bullets" |
| Não usa formato pedido | Reforce: "Use EXATAMENTE o formato descrito" |
| Inventa dados | Diga: "Use APENAS os dados que forneci" |

---

## 💡 Revisão

**Os 2 Insights:**

1. **Calibração é normal** — Nenhum prompt funciona perfeitamente de primeira. Iterar é parte do processo.

2. **Contexto resolve 80% dos problemas** — Se a resposta é ruim, provavelmente falta contexto.

**A Transformação:**
- **Antes:** "Não sei se meus prompts funcionam"
- **Depois:** "Tenho 4 prompts testados e calibrados"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Salve a versão final dos 4 prompts
2. Nomeie claramente: "Prompt Performance v1", etc.
3. Guarde num lugar de fácil acesso

**Funcionou se:** Você tem 4 prompts salvos que funcionam com seus dados.

---

## 🎬 HOOK - Próxima Aula

> Seus prompts funcionam.
>
> Agora precisa ORGANIZAR.
>
> Na próxima aula, vamos criar sua Biblioteca de Análises — um lugar central pra todos os seus prompts e contextos.
>
> E vou te preparar pro módulo final: transformar tudo isso em ROTINA.
>
> **Próxima aula: 4.7 - Salvando Biblioteca e Próximos Passos**

---

*Aula 4.6 - Trilha 3 - Academia Lendária*
