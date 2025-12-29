# 📖 Glossário do Módulo 2: Controlando o Agente

**Curso:** Google Antigravity Essencial
**Professor:** Lucas Charao
**Uso:** Referência rápida durante e depois das aulas

---

## 📌 Como Usar Este Glossário

- **Durante a aula:** Consulte quando o professor mencionar um termo novo
- **Depois da aula:** Use como referência ao configurar o Antigravity
- **Nos estudos:** Imprima ou salve para consulta rápida

**Organização:** Alfabética (A-Z)

---

## A

### Agent Decides (Agente Decide)
Política de Revisão onde o agente usa "bom senso" pra decidir quando parar e te mostrar o progresso.

**Comportamento:** Coisas simples ele continua sozinho. Coisas importantes ele para e te mostra.

**Quando usar:** Recomendado pra maioria das situações. Equilíbrio entre controle e velocidade.

**Ver também:** Política de Revisão, Always Proceed, Request Review

---

### Allow List (Lista de Permissão)
Lista de comandos que o agente PODE executar mesmo quando a política está em OFF.

**Oposto de:** Deny List

**Exemplo:** Se Terminal Policy está em OFF mas você quer que "npm install" funcione, adiciona na Allow List.

**Ver também:** Deny List, Terminal

---

### Always Proceed (Sempre Continuar)
Política de Revisão onde o agente NUNCA para pra pedir aprovação. Ele faz tudo de uma vez.

**Comportamento:** Máxima velocidade, mínimo controle. Você só vê o resultado final.

**Quando usar:** Protótipos rápidos, experimentos, projetos que você pode descartar se der errado.

**Cuidado:** Se der errado, você só descobre no final.

**Ver também:** Política de Revisão, Agent Decides, Request Review

---

### AUTO (Automático)
Política de Execução do Terminal onde o agente DECIDE o que pode executar sozinho.

**Comportamento:** Comandos seguros ele executa. Comandos arriscados ele te pergunta.

**Quando usar:** Recomendado pra maioria das pessoas. Equilíbrio entre segurança e praticidade.

**Ver também:** Política de Execução, OFF, TURBO

---

## C

### Checkpoint (Ponto de Verificação)
Momento em que o agente para e te mostra o que está fazendo antes de continuar.

**Quem controla:** A Política de Revisão define quantos checkpoints acontecem.

**Analogia:** Igual mostrar o rascunho de uma apresentação antes de terminar tudo.

**Ver também:** Política de Revisão

---

### Comando
Instrução técnica que o agente executa no Terminal.

**Exemplos:**
- "npm install" = instala bibliotecas
- "mkdir pasta" = cria uma pasta
- "rm arquivo" = remove um arquivo

**Você precisa entender?** Não. Só precisa saber que alguns são perigosos e devem estar na Deny List.

**Ver também:** Terminal, Deny List

---

## D

### Deny List (Lista de Bloqueio)
Lista de comandos que o agente NUNCA pode executar, mesmo em modo TURBO.

**Comandos que devem estar aqui:**
- rm -rf (apaga tudo)
- sudo (acesso de administrador)
- chmod 777 (muda permissões)
- curl | bash (baixa e executa código)

**Por que importa:** Protege você de ações destrutivas acidentais.

**Analogia:** Lista de "nunca faça isso" pro seu assistente.

**Ver também:** Terminal, Política de Execução

---

## F

### Fast Mode (Modo Rápido)
Modo de trabalho onde o agente executa DIRETO, sem mostrar plano antes.

**Comportamento:** Você pede, ele faz. Sem etapa de planejamento.

**Quando usar:** Ajustes pequenos, correções rápidas, coisas que são fáceis de desfazer se der errado.

**Exemplo:** "Muda a cor do botão pra verde" → Fast Mode

**Ver também:** Planning Mode, Task List

---

## O

### OFF (Desligado)
Política de Execução do Terminal onde NADA executa automaticamente.

**Comportamento:** O agente SEMPRE te pergunta antes de executar qualquer comando.

**Quando usar:** Projetos com dados muito sensíveis, quando você não confia ainda no agente.

**Desvantagem:** Muito lento, muitas interrupções.

**Ver também:** Política de Execução, AUTO, TURBO

---

## P

### Planning Mode (Modo Planejamento)
Modo de trabalho onde o agente cria um PLANO antes de executar qualquer coisa.

**Comportamento:**
1. Você pede algo
2. Agente cria Task List (plano)
3. Você revisa e aprova
4. Aí ele executa

**Quando usar:** Projetos novos, tarefas complexas, coisas que dão trabalho se der errado.

**Exemplo:** "Cria um sistema de agendamento" → Planning Mode

**Ver também:** Fast Mode, Task List

---

### Política de Execução (Terminal Policy)
Configuração que define O QUE o agente pode executar automaticamente no Terminal.

**Opções:**
- **OFF:** Nada automático
- **AUTO:** Agente decide (recomendado)
- **TURBO:** Tudo automático

**Onde configurar:** Settings → Terminal Policy

**Ver também:** OFF, AUTO, TURBO, Deny List

---

### Política de Revisão (Review Policy)
Configuração que define QUANDO o agente para pra te mostrar o progresso.

**Opções:**
- **Always Proceed:** Nunca para
- **Agent Decides:** Agente escolhe (recomendado)
- **Request Review:** Sempre para

**Onde configurar:** Settings → Review Policy

**Ver também:** Always Proceed, Agent Decides, Request Review

---

## R

### Request Review (Pedir Revisão)
Política de Revisão onde o agente SEMPRE para pra te mostrar o progresso antes de continuar.

**Comportamento:** Máximo controle, mínima velocidade. Muitos checkpoints.

**Quando usar:** Projetos críticos, entregas pra clientes importantes, quando erro é inaceitável.

**Ver também:** Política de Revisão, Always Proceed, Agent Decides

---

## S

### Settings (Configurações)
Área do Antigravity onde você ajusta todas as políticas e preferências.

**O que você configura aqui:**
- Terminal Policy
- Review Policy
- Deny List / Allow List
- Outras preferências

**Como acessar:** Procure ícone de engrenagem ou menu "Settings"

---

## T

### Task List (Lista de Tarefas)
Plano que o agente cria no Planning Mode mostrando o que ele pretende fazer.

**Exemplo de Task List:**
```
1. Criar arquivo index.html
2. Adicionar formulário com campos nome e email
3. Estilizar com CSS básico
4. Testar no browser
```

**O que você pode fazer:** Revisar, comentar, pedir mudanças antes de aprovar.

**Ver também:** Planning Mode, Artifacts

---

### Terminal
Área do Antigravity onde comandos técnicos são executados. Geralmente aparece na parte de baixo da tela.

**Você precisa usar?** Na maioria dos casos, não. O agente usa automaticamente.

**Por que importa:** A Política de Execução controla o que pode rodar aqui.

**Analogia:** É como os "bastidores técnicos" — você não precisa entrar lá, mas precisa controlar quem entra.

**Ver também:** Política de Execução, Comando, Deny List

---

### Toggle
Botão que alterna entre duas opções. Clica uma vez: liga. Clica de novo: desliga.

**Onde você usa:** Alternar entre Planning Mode e Fast Mode, ligar/desligar configurações.

**Exemplo visual:** [ OFF ◯ ] → clica → [ ● ON ]

---

### TURBO
Política de Execução do Terminal onde o agente executa TUDO automaticamente.

**Comportamento:** Máxima velocidade, mínimo controle. Só para se o comando estiver na Deny List.

**Quando usar:** Projetos de teste que você pode perder, experimentos rápidos.

**Cuidado:** Configure bem a Deny List antes de usar!

**Ver também:** Política de Execução, OFF, AUTO, Deny List

---

## 📊 Tabela de Configurações (Resumo)

### Políticas de Execução do Terminal

| Política | Comportamento | Quando usar |
|----------|---------------|-------------|
| **OFF** | Sempre pergunta | Dados muito sensíveis |
| **AUTO** | Agente decide | Maioria das situações ✓ |
| **TURBO** | Executa tudo | Projetos descartáveis |

### Políticas de Revisão

| Política | Comportamento | Quando usar |
|----------|---------------|-------------|
| **Always Proceed** | Nunca para | Protótipos rápidos |
| **Agent Decides** | Agente escolhe | Maioria das situações ✓ |
| **Request Review** | Sempre para | Projetos críticos |

### Modos de Trabalho

| Modo | Comportamento | Quando usar |
|------|---------------|-------------|
| **Planning Mode** | Mostra plano antes | Projetos novos, complexos |
| **Fast Mode** | Executa direto | Ajustes rápidos |

---

## 💡 Dicas de Uso

1. **Comece conservador:** Use AUTO + AGENT DECIDES no início. Ajuste conforme ganha confiança.

2. **Deny List é sagrada:** Nunca remova comandos perigosos da lista de bloqueio.

3. **Planning Mode pra coisas novas:** Sempre que criar algo do zero, use Planning Mode pra ver o plano antes.

4. **Fast Mode pra ajustes:** Correções pequenas e ajustes pontuais não precisam de plano.

5. **Projetos críticos = mais controle:** Se for entregar pra cliente, use Request Review.

---

## 📚 Glossários Relacionados

- **Módulo 1:** Termos básicos (Agent Manager, Editor View, Browser)
- **Módulo 3:** Termos sobre Artifacts
- **Módulo 4:** Termos sobre Atalhos

---

**Última atualização:** 2025-12-16
**Criado por:** Course Architect Agent

---

**Imprima ou salve este glossário para referência rápida! 📖**
