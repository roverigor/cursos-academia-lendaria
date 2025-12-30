# Aula 3.1: Dashboard é Retrovisor, Alerta é Farol

## Metadados da Aula

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.1 |
| **Tipo** | Conceitual |
| **Duração** | 30 minutos |
| **Formato** | Vídeo + Slides |

---

## Objetivos da Aula

Ao final desta aula, o aluno será capaz de:
1. Entender a diferença entre dashboard (reativo) e alerta (proativo)
2. Identificar os 5 tipos de alertas que todo negócio precisa
3. Escolher os triggers certos para cada alerta
4. Conhecer as opções de ferramentas para automação

---

## Roteiro de Fala

### ABERTURA (2 min)

**[SLIDE: Título da aula]**

> "Você criou um dashboard no Módulo 2. Parabéns."
>
> "Mas deixa eu te contar um segredo: dashboard não é suficiente."
>
> "Dashboard é retrovisor. Mostra o que JÁ aconteceu."
>
> "O que você precisa é de farol. Algo que ilumine o que ESTÁ acontecendo — antes de virar problema."
>
> "Esse farol se chama ALERTA."

---

### PARTE 1: O PROBLEMA (8 min)

**[SLIDE: "A História do Problema Invisível"]**

> "Deixa eu te contar uma história real."
>
> "Um empresário — vamos chamar de Marcos — tinha um dashboard lindo. 15 métricas. Gráficos bonitos. Power BI conectado em tudo."
>
> "Problema: Marcos abria o dashboard toda segunda-feira."
>
> "Na segunda-feira passada, ele abriu e viu: churn estava em 8%. Normal era 3%."
>
> "O churn tinha explodido na quarta-feira anterior. Marcos só descobriu 5 dias depois."
>
> "Nesses 5 dias, perdeu 12 clientes. R$ 24 mil em MRR. Dinheiro que nunca mais volta."

**[SLIDE: "O Problema do Dashboard"]**

> "O problema do dashboard é simples: ele é PASSIVO."
>
> "Você precisa IR até ele. Abrir. Olhar. Analisar."
>
> "E se você não for? O dashboard não te avisa."
>
> "Ele não liga, não manda mensagem, não grita 'HEY, TEM ALGO ERRADO AQUI!'"
>
> "Ele fica lá, quieto, esperando você lembrar de abrir."

**[SLIDE: "Dashboard vs Alerta"]**

> "Por isso a diferença:"
>
> "DASHBOARD = Você vai até a informação"
> "ALERTA = A informação vem até você"
>
> "Dashboard = Retrovisor (mostra o que passou)"
> "Alerta = Farol (ilumina o que está acontecendo)"
>
> "Você precisa dos dois. Mas o alerta é o que SALVA você."

---

### PARTE 2: O CUSTO (5 min)

**[SLIDE: "Quanto custa descobrir tarde?"]**

> "Vamos fazer uma conta."
>
> "Um problema de negócio geralmente tem 3 fases:"

**[SLIDE: "As 3 Fases do Problema"]**

> "Fase 1: SINAL FRACO"
> "O problema começa. Ainda é pequeno. Fácil de resolver."
> "Custo: R$ 1.000"
>
> "Fase 2: PROBLEMA VISÍVEL"
> "O problema cresceu. Agora é óbvio. Mais difícil de resolver."
> "Custo: R$ 10.000"
>
> "Fase 3: CRISE"
> "O problema explodiu. Agora é emergência. Muito caro resolver."
> "Custo: R$ 100.000"

**[SLIDE: "A Matemática do Alerta"]**

> "O alerta te pega na Fase 1."
>
> "Em vez de pagar R$ 100.000 pra apagar incêndio, você paga R$ 1.000 pra resolver quando ainda é pequeno."
>
> "É a diferença entre trocar o óleo do carro e trocar o motor fundido."
>
> "Prevenção é SEMPRE mais barata que correção."

---

### PARTE 3: A SOLUÇÃO (10 min)

**[SLIDE: "Os 5 Tipos de Alertas"]**

> "Existem 5 tipos de alertas que todo negócio precisa."
>
> "Não precisa ter os 5 de cara. Mas precisa saber quais são."

**[SLIDE: Tipo 1 - Limite Crítico]**

> "Tipo 1: LIMITE CRÍTICO"
>
> "Quando uma métrica cruza uma linha vermelha."
>
> "Exemplo: 'Se faturamento do dia for menor que R$ 3.000, me avisa'"
>
> "Trigger: Valor < X ou Valor > X"
>
> "Esse é o alerta de 'o prédio está pegando fogo'."

**[SLIDE: Tipo 2 - Tendência]**

> "Tipo 2: TENDÊNCIA NEGATIVA"
>
> "Quando algo está caindo por vários dias seguidos."
>
> "Exemplo: 'Se leads caírem por 3 dias consecutivos, me avisa'"
>
> "Trigger: X dias seguidos de queda"
>
> "Esse é o alerta de 'a água está esquentando, o sapo precisa pular'."

**[SLIDE: Tipo 3 - Anomalia]**

> "Tipo 3: ANOMALIA"
>
> "Quando algo está muito diferente do normal."
>
> "Exemplo: 'Se taxa de churn for 50% acima da média, me avisa'"
>
> "Trigger: Valor > X% acima/abaixo do normal"
>
> "Esse é o alerta de 'isso nunca aconteceu antes, melhor olhar'."

**[SLIDE: Tipo 4 - Oportunidade]**

> "Tipo 4: OPORTUNIDADE"
>
> "Nem todo alerta é de problema. Alguns são de oportunidade."
>
> "Exemplo: 'Se um lead com score alto ficar sem contato por 48h, me avisa'"
>
> "Trigger: Condição positiva por mais de X tempo"
>
> "Esse é o alerta de 'tem dinheiro na mesa, pega antes que esfrie'."

**[SLIDE: Tipo 5 - Prazo/Meta]**

> "Tipo 5: META EM RISCO"
>
> "Quando você está no caminho errado pra bater a meta."
>
> "Exemplo: 'Se dia 15 do mês e menos de 40% da meta, me avisa'"
>
> "Trigger: Data X + % da meta < Y"
>
> "Esse é o alerta de 'ainda dá tempo de reverter, mas precisa agir AGORA'."

---

### PARTE 4: AS FERRAMENTAS (5 min)

**[SLIDE: "Como automatizar alertas?"]**

> "Agora a parte técnica: como fazer esses alertas funcionarem?"
>
> "Você tem 3 opções principais:"

**[SLIDE: Opção 1 - n8n + Evolution API]**

> "Opção 1: n8n + Evolution API"
>
> "Custo: Grátis (se hospedar no Render/Railway)"
> "Vantagem: Controle total, sem mensalidade"
> "Desvantagem: Precisa configurar, mais técnico"
>
> "É o que eu recomendo pra quem quer economizar e tem paciência pra aprender."

**[SLIDE: Opção 2 - n8n + Z-API]**

> "Opção 2: n8n + Z-API"
>
> "Custo: R$ 50-100/mês (Z-API)"
> "Vantagem: Mais fácil de configurar WhatsApp"
> "Desvantagem: Custo mensal"
>
> "Bom pra quem quer simplicidade e não quer mexer com Evolution API."

**[SLIDE: Opção 3 - Make]**

> "Opção 3: Make (ex-Integromat)"
>
> "Custo: R$ 50-200/mês"
> "Vantagem: Interface visual, sem hospedar nada"
> "Desvantagem: Custo maior, menos controle"
>
> "Bom pra quem quer zero código e não liga de pagar."

**[SLIDE: "Minha Recomendação"]**

> "Neste curso, vamos usar n8n + Evolution API."
>
> "Por quê?"
>
> "1. É grátis"
> "2. Você tem controle total"
> "3. Funciona com WhatsApp (que é onde você VAI ver a mensagem)"
>
> "MAS — se você prefere Z-API ou Make, a lógica é a mesma. Muda só a ferramenta."

---

### FECHAMENTO (0 min - transição)

**[SLIDE: "O que você vai configurar"]**

> "Na próxima aula, você vai configurar seus primeiros alertas."
>
> "Não vamos fazer os 5 tipos. Vamos começar com 3 que são mais urgentes pro seu negócio."
>
> "Quando terminar, você vai poder fechar o notebook às 18h sabendo que se algo der errado, seu celular vai vibrar."
>
> "Esse é o poder do alerta: você descansa enquanto o sistema vigia."
>
> "Te vejo na próxima aula."

---

## Recursos Visuais

### Slides Necessários

1. Título da aula
2. "A História do Problema Invisível" (narrativa)
3. "O Problema do Dashboard" (passivo vs ativo)
4. "Dashboard vs Alerta" (comparativo visual)
5. "Quanto custa descobrir tarde?" (gancho)
6. "As 3 Fases do Problema" (escala de custo)
7. "A Matemática do Alerta" (prevenção vs correção)
8. "Os 5 Tipos de Alertas" (visão geral)
9. Tipo 1: Limite Crítico (com exemplo)
10. Tipo 2: Tendência (com exemplo)
11. Tipo 3: Anomalia (com exemplo)
12. Tipo 4: Oportunidade (com exemplo)
13. Tipo 5: Meta em Risco (com exemplo)
14. Tabela de ferramentas (3 opções)
15. Cada opção em detalhe (3 slides)
16. "Minha Recomendação"
17. "O que você vai configurar" (preview)

### Elementos Gráficos

- Metáfora visual: Retrovisor vs Farol
- Gráfico de custo escalando (1x → 10x → 100x)
- Ícones para cada tipo de alerta
- Comparativo de ferramentas em tabela

---

## Notas de Produção

### Tom de Voz
- Urgente mas não alarmista
- "Isso te salva dinheiro" como motivação
- Exemplos com números reais

### Storytelling
- História do Marcos = elemento emocional
- "Já aconteceu comigo também"
- Conexão antes de solução

### Ritmo
- Rápido nos 5 tipos de alerta
- Mais lento nas ferramentas (decisão importante)
- Fechamento motivacional

---

## Checklist de Gravação

- [ ] História do Marcos com detalhes específicos
- [ ] Metáfora retrovisor/farol clara
- [ ] 5 tipos de alertas com exemplos reais
- [ ] Tabela de ferramentas atualizada
- [ ] Justificativa clara para recomendação
- [ ] Preview da próxima aula

---

*Roteiro Aula 3.1 - Trilha 3*
*Academia Lendária*
