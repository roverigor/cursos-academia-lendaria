# Aula 2.1: Por que seu Dashboard Não Funciona

## Metadados da Aula

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.1 |
| **Tipo** | Conceitual |
| **Duração** | 30 minutos |
| **Formato** | Vídeo + Slides |

---

## Objetivos da Aula

Ao final desta aula, o aluno será capaz de:
1. Identificar os 5 erros que matam dashboards
2. Entender a diferença entre "olhar números" e "tomar decisão"
3. Escolher as métricas certas (e eliminar as erradas)
4. Conhecer as opções de ferramentas e quando usar cada uma

---

## Roteiro de Fala

### ABERTURA (2 min)

**[SLIDE: Título da aula]**

> "Você já criou um dashboard?"
>
> "Se a resposta é sim, deixa eu adivinhar: você fez, ficou bonito, usou por 2 semanas... e nunca mais abriu."
>
> [Pausa]
>
> "Não é culpa sua. 90% dos dashboards morrem assim."
>
> "Nesta aula vou te mostrar POR QUE isso acontece. E mais importante: como fazer diferente."

---

### PARTE 1: O PROBLEMA (8 min)

**[SLIDE: "O Cemitério de Dashboards"]**

> "Eu tenho uma teoria: existe um cemitério de dashboards em algum lugar da internet."
>
> "Milhões de Power BI abandonados. Planilhas de 'KPIs' que ninguém abre. Looker Studios lindos que viraram decoração."
>
> "E sabe qual é a ironia? Todo mundo SABE que precisa de um dashboard. Todo mundo TENTA fazer. Mas quase ninguém USA."

**[SLIDE: "Os 5 Motivos"]**

> "Existem 5 motivos pelos quais dashboards falham. Vou passar por cada um."

**[SLIDE: Motivo 1]**

> "Motivo 1: Você colocou métricas demais."
>
> "Aquela ideia de 'vou colocar tudo que eu puder'. 30 gráficos, 50 números, 12 abas."
>
> "Resultado? Você abre, olha, não entende nada, fecha."
>
> "Um bom dashboard tem 5 a 7 métricas. MÁXIMO. Se você não consegue decidir quais 7 métricas são mais importantes, você não entendeu seu negócio."

**[SLIDE: Motivo 2]**

> "Motivo 2: Os dados não atualizam sozinhos."
>
> "Você criou o dashboard, conectou na planilha. Mas alguém precisa ATUALIZAR a planilha."
>
> "Passa uma semana, ninguém atualiza, o dado fica velho, você para de confiar."
>
> "Dashboard sem automação é jardim sem água. Morre."

**[SLIDE: Motivo 3]**

> "Motivo 3: Você criou pra impressionar, não pra decidir."
>
> "Gráficos 3D. Cores neon. Animações."
>
> "Bonito pra apresentar pro investidor. Inútil pra tomar decisão às 7h da manhã."
>
> "Um bom dashboard é CHATO. Número grande no centro. Verde, amarelo ou vermelho. Pronto."

**[SLIDE: Motivo 4]**

> "Motivo 4: Você não sabe o que fazer com o número."
>
> "Você abre o dashboard. Vê que a taxa de conversão é 3,2%."
>
> "E aí?"
>
> "3,2% é bom ou ruim? Preciso fazer alguma coisa? O que eu faço?"
>
> "Se você não sabe responder essas perguntas, o dashboard é inútil."

**[SLIDE: Motivo 5]**

> "Motivo 5: Você não tem rotina de olhar."
>
> "O melhor dashboard do mundo não adianta nada se você não abre."
>
> "Não é sobre TER um dashboard. É sobre USAR um dashboard."
>
> "Mas calma, isso a gente resolve no Módulo 5. Hoje vamos focar em criar um que VALE a pena usar."

---

### PARTE 2: O CUSTO (5 min)

**[SLIDE: "O Custo de Não Ver"]**

> "Qual é o custo de não ter um dashboard que funciona?"
>
> "Não é o custo da ferramenta. Power BI é R$ 60/mês. Looker Studio é grátis."
>
> "O custo é INVISIBILIDADE."

**[SLIDE: Exemplo Real]**

> "Um cliente meu ficou 3 meses sem olhar churn de perto."
>
> "Quando olhou, descobriu que tinha perdido 15% da base em 90 dias."
>
> "Se tivesse um dashboard com alerta, teria visto no mês 1. Poderia ter agido. Poderia ter salvo R$ 40 mil em receita recorrente."
>
> "Mas ele não viu. Porque não tinha onde ver."

**[SLIDE: "Decisão no Escuro"]**

> "Toda decisão que você toma sem dados é uma decisão no escuro."
>
> "Às vezes dá certo. Muitas vezes não."
>
> "E o pior: você nunca sabe se deu errado porque não tem o dado pra comparar."

---

### PARTE 3: A SOLUÇÃO (10 min)

**[SLIDE: "Dashboard que Funciona"]**

> "Um dashboard que funciona tem 4 características:"

**[SLIDE: Característica 1]**

> "1. Poucas métricas, bem escolhidas."
>
> "5 a 7 métricas. Uma por área: financeiro, comercial, cliente, operacional."
>
> "A regra é: se você não pode agir no número, não coloca no dashboard."

**[SLIDE: Característica 2]**

> "2. Atualização automática."
>
> "O dado entra sozinho. Você não precisa fazer nada."
>
> "Isso significa: conectar na fonte de dados via API, ou usar planilha com entrada automática."

**[SLIDE: Característica 3]**

> "3. Cores que significam algo."
>
> "Verde = está bom, não mexe"
> "Amarelo = atenção, pode virar problema"
> "Vermelho = problema, age agora"
>
> "Você abre o dashboard e em 5 segundos sabe: tá tudo bem ou preciso agir?"

**[SLIDE: Característica 4]**

> "4. Comparação com meta ou histórico."
>
> "Número sozinho não significa nada."
>
> "Taxa de conversão de 3% é boa se sua meta é 2%. É ruim se sua meta é 5%."
>
> "Todo número precisa de CONTEXTO: meta, mês passado, ou média histórica."

---

### PARTE 4: AS FERRAMENTAS (5 min)

**[SLIDE: "Qual ferramenta usar?"]**

> "Agora a pergunta que todo mundo faz: qual ferramenta eu uso?"
>
> "A resposta honesta: depende do que você já tem."

**[SLIDE: Tabela de Ferramentas]**

> "Looker Studio: grátis, conecta com Google Sheets, bom pra quem já usa Google."
>
> "Power BI: R$ 60/mês, mais poderoso, bom pra quem já usa Microsoft."
>
> "Metabase: grátis se você hospedar, open source, bom pra quem quer controle total."
>
> "Notion: grátis, mais simples, bom pra quem quer velocidade sem sofisticação."

**[SLIDE: "Minha Recomendação"]**

> "Neste curso, vamos usar Looker Studio."
>
> "Por quê?"
>
> "1. É grátis"
> "2. Conecta direto com Google Sheets (que você provavelmente já usa)"
> "3. É simples de aprender"
> "4. Funciona no celular"
>
> "MAS — se você já usa Power BI, continua com Power BI. Se prefere Metabase, usa Metabase."
>
> "A lógica é a mesma. A ferramenta é só um meio."

---

### FECHAMENTO (0 min - transição)

**[SLIDE: "O que você vai criar"]**

> "Na próxima aula, você vai criar seu dashboard."
>
> "Não vai ser o dashboard mais bonito do mundo. Mas vai ser um dashboard que você VAI USAR."
>
> "5 a 7 métricas. Automático. Com cores. Com metas."
>
> "E o mais importante: vai te dar a resposta pra pergunta 'como tá meu negócio hoje?' em menos de 10 segundos."
>
> "Te vejo na próxima aula."

---

## Recursos Visuais

### Slides Necessários

1. Título da aula
2. "O Cemitério de Dashboards" (metáfora visual)
3. "Os 5 Motivos" (lista)
4. Motivo 1: Métricas demais (exemplo visual)
5. Motivo 2: Sem automação (fluxo quebrado)
6. Motivo 3: Bonito mas inútil (comparativo)
7. Motivo 4: Número sem ação (interrogação)
8. Motivo 5: Sem rotina (calendário vazio)
9. "O Custo de Não Ver" (números)
10. Exemplo real de churn não detectado
11. "Decisão no Escuro" (metáfora)
12. "Dashboard que Funciona" (4 características)
13. Cada característica (4 slides)
14. Tabela de ferramentas comparativa
15. "Minha Recomendação" (Looker Studio)
16. "O que você vai criar" (preview)

### Elementos Gráficos

- Dashboard "cemitério" (abandonado, cheio de gráficos)
- Dashboard ideal (limpo, 5-7 números)
- Comparativo lado a lado
- Ícones para cada ferramenta

---

## Notas de Produção

### Tom de Voz
- Provocativo mas não agressivo
- "Deixa eu adivinhar..." cria conexão
- Usar humor para humanizar

### Exemplos
- Usar números reais (não genéricos)
- Exemplo do churn deve parecer verdadeiro
- Mostrar que você também já errou

### Transições
- Cada "motivo" é um mini-segmento
- Manter ritmo rápido nos motivos
- Desacelerar na solução

---

## Checklist de Gravação

- [ ] Slides com dashboards reais (bons e ruins)
- [ ] Tabela de ferramentas atualizada
- [ ] Exemplos com números específicos
- [ ] Tom provocativo mas empático
- [ ] Preview do que vem na próxima aula

---

*Roteiro Aula 2.1 - Trilha 3*
*Academia Lendária*
