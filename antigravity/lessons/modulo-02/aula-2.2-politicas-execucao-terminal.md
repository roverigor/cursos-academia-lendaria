# AULA 2.2: Políticas de Execução do Terminal

**Módulo:** 2 - Controlando o Agente
**Duração:** 8 minutos
**Tipo:** Configuração
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Políticas de Execução
- Conhecer as 3 opções: Off, Auto e Turbo
- Saber configurar de forma segura pro seu perfil

### ORIGEM (Position)
Você provavelmente:
- Não sabia que podia controlar o que o agente executa automaticamente
- Tem um pouco de receio de dar "liberdade demais" pro agente
- Quer entender como se proteger de ações indesejadas
- Nunca ouviu falar em "terminal" (e tá tudo bem!)

### ROTA (Steps)
1. Entender o que é o Terminal (sem complicação)
2. Conhecer as 3 políticas de execução
3. Entender quando usar cada uma
4. Configurar a política recomendada

---

## ROTEIRO COMPLETO

### [ABERTURA] - 30 segundos

**[LUCAS DIZ:]**

> Lucas Charao aqui!
>
> Você aprendeu sobre Planning Mode e Fast Mode — como controlar QUANDO o agente planeja. Agora vamos falar sobre controlar O QUE ele pode fazer automaticamente.
>
> Isso é importante pra sua segurança. Vem entender.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto: se você contratasse um assistente pra trabalhar na sua empresa, você daria acesso total a TUDO no primeiro dia?
>
> (pausa)
>
> Provavelmente não. Você iria aos poucos. "Pode mexer nisso, mas naquilo me pergunta antes."
>
> Com o agente é igual. Ele é muito capaz, mas você precisa definir os LIMITES. O que ele pode fazer sozinho e o que ele precisa te perguntar.
>
> É disso que essa aula trata.

---

### [CONTEXTO SIMPLES] - 1 minuto

**[LUCAS DIZ:]**

> Primeiro, deixa eu explicar uma coisa rapidinho:
>
> O "Terminal" é aquela área preta que às vezes aparece na parte de baixo da tela. É onde comandos técnicos são executados.
>
> Você NÃO precisa entender de terminal. Mas precisa saber que:
>
> Quando o agente cria coisas, às vezes ele precisa rodar comandos no terminal. Tipo "instala essa biblioteca", "inicia o servidor", "cria essa pasta".
>
> A Política de Execução controla: o agente pode rodar esses comandos SOZINHO ou precisa te PERGUNTAR antes?
>
> É uma questão de segurança e controle.

---

### [AS TRÊS POLÍTICAS] - 2 minutos

**[LUCAS DIZ:]**

> Existem 3 opções. Vou explicar cada uma:

**[MOSTRAR TABELA NO SLIDE:]**

```
┌─────────────────────────────────────────────────────────┐
│  POLÍTICA     │  O QUE ACONTECE                         │
├─────────────────────────────────────────────────────────┤
│  OFF          │  Nada executa automaticamente.          │
│  (Desligado)  │  O agente SEMPRE te pergunta.           │
│               │  → Máximo controle, mínima velocidade   │
├─────────────────────────────────────────────────────────┤
│  AUTO         │  O agente DECIDE.                       │
│  (Automático) │  Coisas seguras: executa sozinho.       │
│               │  Coisas arriscadas: te pergunta.        │
│               │  → Equilíbrio (RECOMENDADO)             │
├─────────────────────────────────────────────────────────┤
│  TURBO        │  Executa TUDO automaticamente.          │
│               │  Só para se você configurar bloqueios.  │
│               │  → Máxima velocidade, mínimo controle   │
└─────────────────────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> **OFF** = Paranoico. Tudo precisa de aprovação. Use se você tiver dados muito sensíveis ou não confiar ainda no agente.
>
> **AUTO** = Equilibrado. O agente usa bom senso. A maioria das pessoas deve usar esse.
>
> **TURBO** = Liberdade total. Use só em projetos de teste que você pode perder sem problema.
>
> Minha recomendação? **AUTO**. É o melhor dos dois mundos.

---

### [DENY LIST - LISTA DE BLOQUEIO] - 1.5 minutos

**[LUCAS DIZ:]**

> Independente da política que você escolher, você pode criar uma "Lista de Bloqueio" — comandos que o agente NUNCA pode executar.
>
> Mesmo no modo Turbo, se um comando tiver na lista de bloqueio, ele para e te pergunta.
>
> Comandos que você DEVE bloquear:

**[MOSTRAR NO SLIDE:]**

```
COMANDOS PERIGOSOS - SEMPRE BLOQUEIE:

rm -rf       → Apaga tudo sem perguntar
sudo         → Executa como administrador
chmod 777    → Muda permissões (risco de segurança)
curl | bash  → Baixa e executa código da internet
```

**[LUCAS DIZ:]**

> Você não precisa entender o que esses comandos fazem. Só precisa saber que são perigosos e devem estar bloqueados.
>
> É como ter uma lista de "nunca faça isso" pro seu assistente.

---

### [APLICAÇÃO PRÁTICA] - 1.5 minutos

**[LUCAS DIZ:]**

> Vamos configurar juntos. Exercício prático.
>
> **Passo 1:** No Antigravity, vai em Settings (Configurações). Procura por "Terminal" ou "Execution Policy".
>
> **Passo 2:** Configura pra **AUTO**.
>
> **Passo 3:** Procura a seção "Deny List" ou "Blocked Commands".
>
> **Passo 4:** Adiciona esses comandos na lista de bloqueio:
> - rm -rf
> - sudo
> - chmod 777
>
> **Passo 5:** Salva.
>
> (pausa de 5 segundos)
>
> Pronto? Se você configurou AUTO e adicionou os comandos perigosos no bloqueio, você tá protegido mas ainda com boa velocidade.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> O ponto aqui é CONFIANÇA com LIMITES.
>
> Você confia no agente pra trabalhar, mas define claramente o que ele pode e não pode fazer sozinho.
>
> É como qualquer relação profissional. Confiança se constrói aos poucos. E limites claros protegem todo mundo.
>
> Na próxima aula, vamos falar sobre Políticas de Revisão — quando o agente deve parar e te mostrar o que fez antes de continuar.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 2](glossario-modulo-02.md)** para definições completas dos termos:
- Terminal
- Política de Execução
- Deny List (Lista de Bloqueio)
- Off / Auto / Turbo

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Política de Execução controla o que o agente pode fazer automaticamente
- [ ] Conheço as 3 opções: Off, Auto, Turbo
- [ ] Sei que AUTO é recomendado pra maioria
- [ ] Configurei a Deny List com comandos perigosos
- [ ] Entendi que não preciso saber o que os comandos fazem, só bloqueá-los

---

## TROUBLESHOOTING (Se der problema)

**Problema:** Não encontro as configurações de Terminal
**Solução:** Procure em Settings/Configurações. Pode estar em "Security" ou "Execution". A interface pode variar.

**Problema:** O agente executou algo que eu não queria
**Solução:** Adicione esse comando na Deny List pra próxima vez. Revise se você está em AUTO ou TURBO.

---

## CONFIGURAÇÃO RECOMENDADA

```
Terminal Policy: AUTO
Deny List:
  - rm -rf
  - rm -r /
  - sudo
  - chmod 777
  - curl | bash
  - wget | bash
```

---

*Aula 2.2 - Políticas de Execução do Terminal*
*Duração: 8 minutos*
*Professor: Lucas Charao*
