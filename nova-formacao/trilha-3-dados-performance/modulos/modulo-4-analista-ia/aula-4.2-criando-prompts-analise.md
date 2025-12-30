# Aula 4.2: Criando seus Prompts de Análise

## Metadados da Aula

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Analista de Dados com IA |
| **Aula** | 4.2 |
| **Tipo** | Prática (hands-on) |
| **Duração** | 60 minutos |
| **Formato** | Screencast + Demonstração |
| **Entregável** | 4 prompts calibrados para análise |

---

## Objetivos da Aula

Ao final desta aula, o aluno terá:
1. Contexto base do negócio configurado
2. 4 prompts de análise personalizados
3. Cada prompt testado com dados reais
4. Biblioteca de prompts salva para uso recorrente

---

## Materiais Necessários

- [ ] Template: modulo-4-prompts-ia.md
- [ ] Conta em Claude ou ChatGPT (versão paga recomendada)
- [ ] Dados do dashboard (Módulo 2)
- [ ] Mapa de Dados (Módulo 1)

---

## Roteiro de Fala

### ABERTURA (3 min)

**[TELA: Claude aberto]**

> "Hora de criar seu analista de dados pessoal."
>
> "Nesta aula, você vai criar 4 prompts de análise. Não são prompts genéricos — são prompts CALIBRADOS pro seu negócio."
>
> "Quando terminar, você vai ter uma biblioteca de prompts que vai usar toda semana."
>
> "Abre o template do Módulo 4 e vamos começar."

---

### PARTE 1: CONFIGURANDO O CONTEXTO (10 min)

**[TELA: Template - Contexto Base]**

> "Antes de criar qualquer prompt, você precisa de uma coisa: CONTEXTO."
>
> "A IA não conhece seu negócio. Você precisa CONTAR pra ela."
>
> "No template, tem uma seção chamada 'Contexto do Negócio'. Vamos preencher."

**[TELA: Preenchendo contexto]**

> "Vou preencher o meu como exemplo:"
>
> [Demonstração preenchendo]
>
> "CONTEXTO DO MEU NEGÓCIO:"
> "Empresa: Agência de marketing digital"
> "Tipo de negócio: Serviços B2B"
> "Faturamento médio mensal: R$ 150.000"
> "Número de funcionários: 12"
> "Modelo de receita: Recorrente (mensalidades)"
> "Principais serviços: Tráfego pago, conteúdo, automação"
> "Público-alvo: PMEs com faturamento acima de R$ 500K/ano"
> "Maior desafio atual: Reduzir churn"
>
> "Isso parece simples, mas é CRUCIAL."
>
> "Sem isso, a IA te dá respostas genéricas."
> "Com isso, ela te dá respostas pro SEU contexto."

**[PAUSA PARA ALUNO]**

> "Pausa o vídeo e preenche o seu contexto."
> "2 minutos são suficientes."
>
> [PAUSA: 2 minutos]

---

### PARTE 2: PROMPT 1 - ANÁLISE DE PERFORMANCE (12 min)

**[TELA: Template - Prompt 1]**

> "Primeiro prompt: Análise de Performance Geral."
>
> "Esse é o prompt que você vai usar todo início de semana. Pergunta: 'Como foi minha semana?'"

**[TELA: Estrutura do prompt]**

> "A estrutura é sempre a mesma:"
>
> "1. CONTEXTO — quem você é"
> "2. DADOS — os números da semana"
> "3. PERGUNTA — o que você quer saber"
> "4. FORMATO — como você quer a resposta"
>
> "Vou mostrar ao vivo."

**[TELA: Claude com prompt]**

> "Vou colar meu contexto primeiro, depois os dados da semana:"
>
> [Demonstração ao vivo - colando contexto + dados]
>
> "Agora a pergunta:"
>
> "ANÁLISE SOLICITADA:"
> "1. Qual a saúde geral do negócio esta semana?"
> "2. Alguma métrica precisa de atenção urgente?"
> "3. Existe alguma oportunidade que posso explorar?"
> "4. Qual a ÚNICA coisa mais importante pra fazer esta semana?"
>
> "E o formato:"
>
> "Seja direto e prático. Não quero teoria, quero ação."

**[TELA: Resposta do Claude]**

> "Olha a resposta:"
>
> [Mostra resposta e analisa]
>
> "Viu? Ela não só me deu diagnóstico, me deu AÇÃO."
>
> "Esse prompt vai pro seu arsenal."

**[PAUSA PARA ALUNO]**

> "Agora você: monta seu Prompt 1 com seus dados reais."
> "Testa no Claude ou ChatGPT."
>
> [PAUSA: 5 minutos]

---

### PARTE 3: PROMPT 2 - INVESTIGAÇÃO DE PROBLEMA (12 min)

**[TELA: Template - Prompt 2]**

> "Segundo prompt: Investigação de Problema."
>
> "Esse você usa quando algo deu errado e você precisa entender POR QUÊ."

**[TELA: Estrutura diferente]**

> "A estrutura muda um pouco:"
>
> "1. CONTEXTO — mesmo de sempre"
> "2. PROBLEMA DETECTADO — o que está errado"
> "3. DADOS RELACIONADOS — números que podem explicar"
> "4. PERGUNTA — hipóteses e ações"

**[TELA: Claude com prompt de investigação]**

> "Vou simular um problema:"
>
> "PROBLEMA DETECTADO:"
> "- Métrica afetada: Taxa de Churn"
> "- Valor atual: 6%"
> "- Valor esperado: 3%"
> "- Variação: +100% (dobrou)"
> "- Desde quando: últimas 3 semanas"
>
> [Demonstração ao vivo]
>
> "Pergunta:"
>
> "1. Quais as 3 causas mais prováveis deste problema?"
> "2. Que dados eu precisaria ver pra confirmar cada hipótese?"
> "3. O que posso fazer nas próximas 24h pra investigar melhor?"

**[TELA: Resposta]**

> [Mostra resposta]
>
> "Ela me deu 3 hipóteses ordenadas por probabilidade."
> "E me disse o que verificar pra cada uma."
>
> "Isso economiza HORAS de análise."

**[PAUSA PARA ALUNO]**

> "Monta seu Prompt 2. Pode ser um problema real ou simulado."
>
> [PAUSA: 5 minutos]

---

### PARTE 4: PROMPT 3 - PREVISÃO E TENDÊNCIA (10 min)

**[TELA: Template - Prompt 3]**

> "Terceiro prompt: Previsão e Tendência."
>
> "Esse você usa no meio do mês. Pergunta: 'Vou bater a meta?'"

**[TELA: Prompt de previsão]**

> "Estrutura:"
>
> "DADOS DO MÊS ATUAL:"
> "- Dia do mês: 15 de 30"
> "- Faturamento realizado: R$ 65.000"
> "- Meta mensal: R$ 100.000"
> "- % atingido: 65%"
>
> "HISTÓRICO (últimos 3 meses):"
> "- Mês 1: R$ 95.000 (95% da meta)"
> "- Mês 2: R$ 102.000 (102% da meta)"
> "- Mês 3: R$ 98.000 (98% da meta)"

**[TELA: Claude respondendo]**

> [Demonstração]
>
> "Pergunta:"
>
> "1. Se mantivermos o ritmo atual, onde fechamos o mês?"
> "2. Qual a probabilidade de bater a meta?"
> "3. O que precisa acontecer pra reverter?"
>
> "Resposta:"
>
> [Mostra resposta com cenários]
>
> "Ela me deu cenário pessimista, realista e otimista."
> "E me disse quanto preciso faturar por dia pra bater a meta."

**[PAUSA PARA ALUNO]**

> "Monta seu Prompt 3 com seus números do mês."
>
> [PAUSA: 4 minutos]

---

### PARTE 5: PROMPT 4 - COMPARATIVO (8 min)

**[TELA: Template - Prompt 4]**

> "Quarto prompt: Comparativo de Períodos."
>
> "Esse você usa no início do mês. Pergunta: 'O que mudou vs mês passado?'"

**[TELA: Prompt comparativo]**

> "Estrutura:"
>
> "COMPARATIVO: Dezembro vs Novembro"
>
> "| Métrica | Nov | Dez | Variação |"
> "| Faturamento | R$ 98K | R$ 85K | -13% |"
> "| Leads | 150 | 180 | +20% |"
> "| Conversão | 8% | 5% | -3pp |"
>
> "Pergunta:"
>
> "1. Estamos melhorando ou piorando?"
> "2. O que explica as variações?"
> "3. Qual deve ser o foco do próximo mês?"

**[TELA: Resposta]**

> [Demonstração rápida]
>
> "Ela conectou os pontos: 'Leads subiram mas conversão caiu — problema está na qualificação ou no comercial, não no marketing.'"
>
> "Isso é INSIGHT. Isso é o que você paga pra um analista fazer."

---

### PARTE 6: CALIBRAÇÃO (5 min)

**[TELA: "Calibrando seus Prompts"]**

> "Seus 4 prompts estão prontos. Mas provavelmente não estão PERFEITOS."
>
> "A calibração é o processo de melhorar o prompt até a resposta ser útil."

**[SLIDE: Problemas e Soluções]**

> "Se a resposta é muito genérica:"
> "→ Adicione mais contexto do seu negócio"
>
> "Se ela 'inventa' números:"
> "→ Forneça TODOS os dados relevantes"
>
> "Se as recomendações não fazem sentido:"
> "→ Revise a descrição do seu negócio"
>
> "Se a resposta é muito longa:"
> "→ Adicione: 'Seja direto. Máximo 5 linhas por pergunta.'"

**[TELA: Salvando prompts]**

> "Depois de calibrar, SALVA os prompts."
>
> "Pode ser em um documento, no Notion, no próprio template."
>
> "Você vai usar esses mesmos prompts toda semana. Não precisa reescrever."

---

### FECHAMENTO (0 min - transição)

**[TELA: Biblioteca de Prompts]**

> "Se você chegou até aqui, agora você tem:"
>
> "✅ Contexto base do negócio"
> "✅ 4 prompts de análise calibrados"
> "✅ Cada um testado com dados reais"
>
> "Você tem um analista de dados no bolso."

**[SLIDE: "Mas e a rotina?"]**

> "Mas quando você vai usar isso?"
>
> "Se você não tiver uma ROTINA, esses prompts vão ficar parados."
>
> "No Módulo 5 — o último — vamos criar sua rotina de decisão."
>
> "15 minutos por dia. Dashboard, alertas, IA. Tudo conectado."
>
> "Te vejo lá."

---

## Timestamps para Edição

| Tempo | Conteúdo |
|-------|----------|
| 0:00-3:00 | Abertura |
| 3:00-13:00 | Configurando contexto |
| 13:00-25:00 | Prompt 1 - Performance |
| 25:00-37:00 | Prompt 2 - Investigação |
| 37:00-47:00 | Prompt 3 - Previsão |
| 47:00-55:00 | Prompt 4 - Comparativo |
| 55:00-60:00 | Calibração + fechamento |

---

## Notas de Produção

### Formato
- Tela dividida: template + IA lado a lado
- Mostrar digitação em tempo real
- Pausas para aluno acompanhar

### Demonstrações
- Usar dados que parecem reais
- Mostrar respostas completas da IA
- Analisar a resposta em voz alta

### Erros e Correções
- Mostrar um prompt ruim → resposta ruim
- Melhorar o prompt → resposta boa
- "Viu a diferença?"

---

## Entregável do Módulo

**O que o aluno deve ter ao final:**

1. Contexto base do negócio configurado
2. 4 prompts personalizados e testados
3. Biblioteca salva para uso recorrente
4. Pelo menos 1 insight real obtido

**Critério de conclusão:**
- Básico: 1 prompt testado
- Completo: 4 prompts calibrados + salvos

---

## Alternativas por IA

### Se usar ChatGPT

- Mesma lógica, mesmo formato
- Pode salvar prompts como "Custom Instructions"
- GPT-4 funciona melhor que GPT-3.5

### Se usar Gemini

- Funciona bem, especialmente com dados de Google Sheets
- Pode fazer upload de arquivos direto

### Se usar Copilot

- Integra com Excel
- Bom pra análise diretamente na planilha

---

*Roteiro Aula 4.2 - Trilha 3*
*Academia Lendária*
