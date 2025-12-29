# AULA 1.2: Agent Manager - Sua "Mission Control"

**Módulo:** 1 - Os Três Ambientes do Antigravity
**Duração:** 10 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Navegar pela interface do Agent Manager com confiança
- Dar sua primeira ordem pro agente e ver ele executar
- Entender onde fica cada coisa: Inbox, Workspaces, Playground

### ORIGEM (Position)
Você provavelmente:
- Já acessou antigravity.google na aula anterior
- Está ansioso pra ver a ferramenta funcionando de verdade
- Nunca deu uma "ordem" pra uma IA executar (só fez perguntas)
- Quer saber se isso realmente funciona pra quem não é técnico

### ROTA (Steps)
1. Entender a metáfora: Agent Manager como "sala de reunião com seu assistente"
2. Conhecer cada parte da tela
3. Dar sua primeira ordem pro agente
4. Ver ele criar algo do zero — sem você fazer nada técnico

---

## ROTEIRO COMPLETO

### [ABERTURA] - 30 segundos

**[LUCAS DIZ:]**

> E aí! Voltamos. Lucas Charao aqui.
>
> Na aula passada, eu te expliquei O QUE é o Antigravity. Agora, a gente vai colocar a mão na massa.
>
> Você vai abrir o Agent Manager e dar sua primeira ordem pro agente. E o mais legal: você vai ver ele FAZER algo de verdade. Vem comigo.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto uma coisa: você já teve um assistente — real ou imaginário — que você só precisava dizer O QUE precisava, sem explicar COMO fazer?
>
> Tipo assim: "Preciso de uma planilha organizada com todos os clientes do mês." E a pessoa entende, faz, e te entrega. Sem você precisar explicar fórmula de Excel, sem você precisar formatar célula por célula.
>
> (pausa)
>
> Sabe aquela sensação de ter alguém competente que você confia pra delegar?
>
> Pois é. O Agent Manager é exatamente isso. É a sua "sala de reunião" com esse assistente digital que é o agente.
>
> Você entra, explica o que precisa, e ele vai lá fazer.
>
> Vamos ver como funciona na prática.

---

### [METÁFORA VISUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> Pensa assim:
>
> O **Agent Manager** é tipo o escritório de um empresário. É VOCÊ, sentado na cadeira, delegando tarefas.
>
> Você tem:
>
> - **Inbox** = sua caixa de entrada. Todas as conversas anteriores que você teve com o agente ficam guardadas aqui. Tipo histórico do WhatsApp.
>
> - **Start Conversation** = o botão de "nova conversa". Quando você quer pedir algo novo, começa aqui.
>
> - **Workspaces** = pastas de projetos. Se você tá criando uma calculadora pro seu negócio e um site pro seu cliente, cada um fica numa pasta separada.
>
> - **Playground** = área de testes. Quer experimentar uma ideia maluca sem bagunçar seus projetos? Vai pro Playground.

**[MOSTRAR DIAGRAMA NO SLIDE:]**

```
┌─────────────────────────────────────────────────┐
│  AGENT MANAGER                                  │
│  ┌──────────────┐ ┌───────────────────────────┐ │
│  │ MENU LATERAL │ │                           │ │
│  │ ─────────    │ │   ÁREA DE CONVERSA        │ │
│  │ > Inbox      │ │                           │ │
│  │ > Start Conv │ │   Você escreve aqui       │ │
│  │ > Workspaces │ │   o que você quer         │ │
│  │ > Playground │ │                           │ │
│  │              │ │   Agente responde e FAZ   │ │
│  └──────────────┘ └───────────────────────────┘ │
└─────────────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> Tá visualizando? Menu na esquerda, conversa na direita.
>
> É bem mais simples do que parece.

---

### [FUNDAMENTO CONCEITUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> Agora, tem uma diferença MUITO importante entre o Agent Manager e o ChatGPT que você já conhece.
>
> No ChatGPT, você pergunta, ele responde. Ponto. É uma conversa.
>
> No Agent Manager, você pede uma TAREFA, e o agente:
> 1. Entende o que você quer
> 2. Planeja como vai fazer
> 3. CRIA os arquivos necessários
> 4. Monta a solução
> 5. Te mostra o resultado
>
> Ele não só FALA sobre fazer. Ele FAZ.
>
> É como a diferença entre pedir conselho pra um amigo... versus contratar alguém pra resolver o problema.
>
> Tá fazendo sentido?

---

### [NAVEGAÇÃO GUIADA] - 1.5 minutos

**[LUCAS DIZ:]**

> Vamos navegar juntos. Abre o Antigravity agora se ainda não abriu.
>
> (pausa de 3 segundos)
>
> Quando você abre, ele já vem no Agent Manager. É a primeira tela.
>
> Olha o menu do lado esquerdo. Você vai ver:
>
> **Inbox** — clica nele. Se você nunca usou, tá vazio. Normal. Depois que criar conversas, elas aparecem aqui.
>
> **Start Conversation** — esse é o botão importante. É onde tudo começa.
>
> **Workspaces** — clica. Aqui você conecta pastas do seu computador. Cada projeto fica numa pasta.
>
> **Playground** — área de experimentos. Sem consequências. Testa o que quiser.
>
> Achou os quatro? Se sim, ótimo. Se não, pausa o vídeo e dá uma olhada com calma.

---

### [APLICAÇÃO PRÁTICA - AÇÃO RÁPIDA] - 3 minutos

**[LUCAS DIZ:]**

> Agora a parte boa. Vamos fazer o agente trabalhar pra você.
>
> **Passo 1:** Clica em "Start Conversation".
>
> (pausa de 2 segundos)
>
> Vai aparecer uma caixa de texto. É ali que você vai escrever o que você quer.
>
> **Passo 2:** Digita EXATAMENTE isso — pode copiar se preferir:
>
> "Crie uma página simples com o título Meu Primeiro Projeto e um botão escrito Começar"
>
> (pausa enquanto digitam)
>
> **Passo 3:** Aperta Enter ou clica no botão de enviar.
>
> Agora... só observa.
>
> (pausa de 5 segundos)
>
> O agente vai:
> 1. Entender seu pedido
> 2. Criar um arquivo HTML (que é o arquivo de página web)
> 3. Colocar o título e o botão
> 4. Te mostrar o resultado
>
> Você vai ver aparecer uma mensagem mostrando o que ele criou. Talvez até uma prévia da página.
>
> **Critério de sucesso:** ele criou a página sem você precisar fazer nada técnico.
>
> Conseguiu?
>
> Se sim, PARABÉNS! Você acabou de criar sua primeira página usando só linguagem natural. Você não escreveu uma linha de código. Você DESCREVEU o que queria.
>
> Se deu algum erro, pode ser que você precise criar um Workspace primeiro. Vai em Workspaces, cria um novo apontando pra uma pasta no seu computador, e tenta de novo.

---

### [EXPANSÃO FILOSÓFICA] - 1 minuto

**[LUCAS DIZ:]**

> Sabe o que você acabou de fazer?
>
> Você criou uma página web. Sem saber HTML. Sem saber CSS. Sem saber nada técnico.
>
> "Ah, mas é só uma página simples..."
>
> Sim. Mas a lógica é a MESMA pra criar um sistema de agendamento, uma calculadora de orçamentos, um site completo pro seu cliente.
>
> Você descreve O QUE quer. O agente descobre COMO fazer.
>
> Essa habilidade — saber descrever claramente o que você precisa — vai ser seu maior diferencial daqui pra frente.
>
> Nas próximas aulas, vamos explorar o Editor View, onde você consegue ver e ajustar o que o agente criou. E depois o Browser integrado, onde o agente consegue TESTAR suas criações automaticamente.
>
> Te vejo na próxima. E bota esse agente pra trabalhar!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 1](glossario-modulo-01.md)** para definições completas dos termos:
- Agent Manager
- Inbox
- Start Conversation
- Workspace
- Playground
- HTML
- Delegar

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Sei onde fica Inbox, Start Conversation, Workspaces e Playground
- [ ] Entendi que Agent Manager é diferente de chat — aqui o agente FAZ coisas
- [ ] Criei minha primeira conversa e pedi algo simples
- [ ] Vi o agente criar uma página sem eu fazer nada técnico
- [ ] Entendi que quanto melhor eu descrever, melhor o resultado

---

## TROUBLESHOOTING (Se der problema)

**Problema:** O agente não criou nada, só respondeu com texto
**Solução:** Verifique se você tem um Workspace configurado. Sem pasta conectada, ele não consegue criar arquivos.

**Problema:** Aparece erro de login ou não carrega
**Solução:** Use conta Google pessoal (Gmail comum). Contas empresariais (Workspace) podem ter restrições.

**Problema:** A tela tá diferente do que eu mostrei
**Solução:** O Antigravity atualiza frequentemente. Os conceitos são os mesmos, só a posição pode mudar um pouco.

---

## RECURSOS

- Site oficial: https://antigravity.google
- Dica: Crie uma pasta chamada "meus-projetos-antigravity" na sua Área de Trabalho pra usar como Workspace

---

*Aula 1.2 - Agent Manager - Sua "Mission Control"*
*Duração: 10 minutos*
*Professor: Lucas Charao*
