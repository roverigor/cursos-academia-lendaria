# AULA 3.1: O que são Artifacts

**Módulo:** 3 - Sistema de Artifacts
**Duração:** 6 minutos
**Tipo:** Conceitual
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Artifacts e pra que servem
- Conhecer os 6 tipos principais de Artifacts
- Saber como eles te ajudam a verificar o trabalho do agente

### ORIGEM (Position)
Você provavelmente:
- Já viu algumas "caixas" aparecerem durante conversas com o agente
- Não tinha certeza do que eram ou pra que serviam
- Quer entender como acompanhar o que o agente está fazendo
- Busca formas de verificar se o trabalho está correto

### ROTA (Steps)
1. Entender a metáfora: Artifacts como "relatórios de progresso"
2. Conhecer os 6 tipos de Artifacts
3. Entender quando cada um aparece
4. Ver exemplos práticos de cada tipo

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Bem-vindo ao Módulo 3! Lucas Charao aqui.
>
> Você já sabe controlar o agente. Agora vamos aprender a VERIFICAR o trabalho dele. E pra isso, precisamos falar sobre Artifacts.
>
> Vem comigo.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto uma coisa: você já pediu pra alguém fazer um trabalho e a pessoa só disse "pronto, terminei" — sem te mostrar NADA do que fez?
>
> (pausa)
>
> Meio desconfortável, né? Você fica pensando: "Mas fez certo? Fez do jeito que eu pedi? Posso confiar?"
>
> Agora imagina se essa pessoa, além de fazer o trabalho, te entregasse:
> - Uma lista do que ela planejou fazer
> - Um resumo do que realmente fez
> - Fotos do resultado
> - Até um vídeo mostrando o processo
>
> Bem melhor, né? Dá pra VERIFICAR.
>
> É exatamente isso que os Artifacts fazem no Antigravity.

---

### [METÁFORA VISUAL] - 1 minuto

**[LUCAS DIZ:]**

> Pensa assim:
>
> **Artifacts = Relatórios de progresso do agente**
>
> O agente não só FAZ o trabalho. Ele te MOSTRA o que fez, de várias formas diferentes.
>
> É como ter um funcionário que:
> - Te manda o plano antes de começar
> - Te mostra cada mudança que fez
> - Tira foto do resultado
> - Escreve um resumo explicando tudo
>
> Você não precisa confiar cegamente. Você pode VERIFICAR.

---

### [OS 6 TIPOS DE ARTIFACTS] - 2 minutos

**[LUCAS DIZ:]**

> Existem 6 tipos principais de Artifacts. Vou explicar cada um:

**[MOSTRAR NO SLIDE:]**

```
┌─────────────────────────────────────────────────────────┐
│  ARTIFACT          │  O QUE É                           │
├─────────────────────────────────────────────────────────┤
│  📋 TASK LIST      │  Lista do que o agente PLANEJA     │
│                    │  fazer (aparece no Planning Mode)  │
├─────────────────────────────────────────────────────────┤
│  📝 IMPLEMENTATION │  Detalhes técnicos do plano        │
│     PLAN           │  (como ele vai fazer cada coisa)   │
├─────────────────────────────────────────────────────────┤
│  📊 CODE DIFF      │  Mostra O QUE foi criado ou        │
│                    │  modificado nos arquivos           │
├─────────────────────────────────────────────────────────┤
│  📄 WALKTHROUGH    │  Resumo em texto simples do que    │
│                    │  foi feito (fácil de entender)     │
├─────────────────────────────────────────────────────────┤
│  📸 SCREENSHOT     │  Foto da tela mostrando o          │
│                    │  resultado visual                  │
├─────────────────────────────────────────────────────────┤
│  🎬 BROWSER        │  Vídeo mostrando o agente          │
│     RECORDING      │  testando sua criação              │
└─────────────────────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> Vamos simplificar:
>
> **Task List e Implementation Plan** = O que ele VAI fazer (aparecem ANTES de executar)
>
> **Code Diff e Walkthrough** = O que ele FEZ (aparecem DEPOIS de executar)
>
> **Screenshot e Recording** = PROVA visual do resultado (aparecem quando ele testa)
>
> Cada um serve pra um momento diferente.

---

### [QUANDO CADA UM APARECE] - 1 minuto

**[LUCAS DIZ:]**

> Pra facilitar, olha quando cada Artifact aparece:

**[MOSTRAR NO SLIDE:]**

```
ANTES DE EXECUTAR (Planning Mode):
├── Task List         → "Vou fazer X, Y e Z"
└── Implementation Plan → "Vou fazer assim..."

DEPOIS DE EXECUTAR:
├── Code Diff         → "Criei/modifiquei isso"
└── Walkthrough       → "Resumo: fiz tal e tal coisa"

QUANDO TESTA NO BROWSER:
├── Screenshot        → "Olha como ficou"
└── Recording         → "Olha o vídeo do teste"
```

**[LUCAS DIZ:]**

> Você não precisa decorar isso. Na prática, os Artifacts vão aparecendo conforme o agente trabalha.
>
> O importante é saber que eles existem e que você pode — e DEVE — olhar pra verificar se tá tudo certo.

---

### [APLICAÇÃO PRÁTICA] - 30 segundos

**[LUCAS DIZ:]**

> Exercício simples pra você fazer agora:
>
> Vai no Agent Manager e pede algo usando Planning Mode:
>
> "Use planning mode e crie uma página de contato com nome, email e mensagem"
>
> Quando o agente responder, PROCURA os Artifacts. Deve aparecer uma Task List mostrando o plano.
>
> Clica nela. Expande. Lê o que ele planeja fazer.
>
> Esse é o primeiro passo pra usar Artifacts: saber que eles estão lá e olhar pra eles.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> O ponto aqui é TRANSPARÊNCIA.
>
> O agente não é uma caixa preta. Você não precisa confiar cegamente.
>
> Os Artifacts são a forma do agente te mostrar: "Olha, eu fiz isso, desse jeito, e o resultado foi esse."
>
> E nas próximas aulas, você vai aprender não só a VER os Artifacts, mas a INTERAGIR com eles — dar feedback, pedir mudanças, guiar o agente pro resultado que você quer.
>
> Te vejo na próxima!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 3](glossario-modulo-03.md)** para definições completas dos termos:
- Artifact
- Task List
- Implementation Plan
- Code Diff
- Walkthrough
- Screenshot
- Browser Recording

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Artifacts são "relatórios de progresso" do agente
- [ ] Conheço os 6 tipos: Task List, Implementation Plan, Code Diff, Walkthrough, Screenshot, Recording
- [ ] Sei que alguns aparecem ANTES (plano) e outros DEPOIS (resultado)
- [ ] Encontrei um Artifact durante uma conversa com o agente

---

## RESUMO VISUAL

```
ARTIFACTS = Formas do agente te MOSTRAR o trabalho

PLANEJAMENTO:
  📋 Task List → Lista de tarefas
  📝 Implementation Plan → Detalhes técnicos

EXECUÇÃO:
  📊 Code Diff → O que mudou nos arquivos
  📄 Walkthrough → Resumo do que foi feito

TESTES:
  📸 Screenshot → Foto do resultado
  🎬 Recording → Vídeo do teste
```

---

*Aula 3.1 - O que são Artifacts*
*Duração: 6 minutos*
*Professor: Lucas Charao*
