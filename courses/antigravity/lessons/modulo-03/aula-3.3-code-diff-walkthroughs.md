# AULA 3.3: Code Diff e Walkthroughs

**Módulo:** 3 - Sistema de Artifacts
**Duração:** 8 minutos
**Tipo:** Demo
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que é um Code Diff e como interpretar
- Saber ler um Walkthrough pra entender o que foi feito
- Usar esses Artifacts pra verificar o trabalho do agente

### ORIGEM (Position)
Você provavelmente:
- Já viu Code Diffs aparecerem mas não entendeu direito
- Quer saber o que significam as linhas verdes e vermelhas
- Busca uma forma de verificar se o agente fez certo
- Não quer precisar entender código pra saber se tá bom

### ROTA (Steps)
1. Entender o que é Code Diff (sem precisar saber código)
2. Aprender a interpretar cores e símbolos
3. Conhecer o Walkthrough e sua utilidade
4. Ver exemplos práticos de ambos

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Lucas Charao de volta!
>
> Hoje vamos falar de dois Artifacts super importantes: Code Diff e Walkthrough. São eles que mostram O QUE o agente realmente fez.
>
> E a boa notícia: você não precisa entender código pra usar. Vem ver.

---

### [GANCHO EMOCIONAL] - 45 segundos

**[LUCAS DIZ:]**

> Imagina que você pediu pra alguém reformar um documento de texto.
>
> Quando a pessoa te devolve, você quer saber: "O que mudou?"
>
> No Word, existe o "Controle de Alterações" — mostra em vermelho o que foi removido e em verde (ou azul) o que foi adicionado.
>
> O Code Diff é EXATAMENTE isso, só que pra arquivos do seu projeto.
>
> E o Walkthrough é tipo um "resumo executivo" — em vez de mostrar cada mudança técnica, ele explica em português o que foi feito.

---

### [CODE DIFF EXPLICADO] - 2 minutos

**[LUCAS DIZ:]**

> Vamos entender o Code Diff:

**[MOSTRAR NO SLIDE:]**

```
CODE DIFF = O que MUDOU nos arquivos

CORES:
🟢 VERDE (+)  = Linha ADICIONADA (nova)
🔴 VERMELHO (-) = Linha REMOVIDA (apagada)
⚪ BRANCO     = Linha que NÃO mudou (contexto)
```

**[LUCAS DIZ:]**

> Exemplo simples:

**[MOSTRAR NO SLIDE:]**

```diff
  Minha página de contato

- Título antigo
+ Título novo e melhor

  Formulário de contato:
+ <campo de nome>
+ <campo de email>
+ <botão enviar>
```

**[LUCAS DIZ:]**

> Viu? Fácil de entender:
> - O título foi TROCADO (removeu o antigo, adicionou o novo)
> - Três elementos foram ADICIONADOS (campos e botão)
>
> Você não precisa entender o código técnico. Só precisa entender que:
> - Verde = algo novo apareceu
> - Vermelho = algo foi removido
> - Se só tem verde = só adicionou coisas novas

---

### [PRA QUE SERVE O CODE DIFF] - 1 minuto

**[LUCAS DIZ:]**

> O Code Diff te ajuda a verificar:
>
> **1. O agente fez o que eu pedi?**
> Se você pediu um botão e no diff aparece um botão sendo adicionado → ✅
>
> **2. Ele mexeu em algo que não devia?**
> Se aparece vermelho em partes que você não pediu pra mudar → ⚠️ Investigar
>
> **3. Quanto trabalho foi feito?**
> Muito verde = muita coisa nova criada
> Pouco verde = mudança pequena
>
> É sua forma de AUDITAR o trabalho do agente.

---

### [WALKTHROUGH EXPLICADO] - 1.5 minutos

**[LUCAS DIZ:]**

> Agora o Walkthrough. Esse é mais fácil ainda.

**[MOSTRAR NO SLIDE:]**

```
WALKTHROUGH = Resumo em português do que foi feito

Exemplo:

"Nesta sessão, eu:
1. Criei o arquivo contato.html
2. Adicionei um formulário com campos nome, email e mensagem
3. Estilizei com cores azul e branco
4. Adicionei validação pra não aceitar campos vazios
5. Testei e tudo funcionou"
```

**[LUCAS DIZ:]**

> Viu? É um RESUMO. Sem código, sem termos técnicos. Só o que foi feito.
>
> Pra quem não é técnico, o Walkthrough é OURO. Você lê e entende exatamente o que aconteceu.
>
> Minha dica: sempre leia o Walkthrough primeiro. Se precisar de mais detalhes, aí você olha o Code Diff.

---

### [COMBINANDO OS DOIS] - 1 minuto

**[LUCAS DIZ:]**

> Na prática, você vai usar os dois juntos:

**[MOSTRAR NO SLIDE:]**

```
FLUXO RECOMENDADO:

1. WALKTHROUGH primeiro
   "Ah, ele criou 3 arquivos e adicionou um formulário"
   → Entendimento geral ✅

2. CODE DIFF se precisar detalhes
   "Deixa eu ver exatamente o que ele adicionou..."
   → Verificação específica ✅

3. FEEDBACK se algo estiver errado
   "Hmm, não queria esse campo. Vou comentar."
   → Correção ✅
```

**[LUCAS DIZ:]**

> Walkthrough = visão geral
> Code Diff = detalhes
> Feedback = correção
>
> Simples assim.

---

### [APLICAÇÃO PRÁTICA] - 1 minuto

**[LUCAS DIZ:]**

> Exercício rápido:
>
> **Passo 1:** Pede algo pro agente que envolva criar ou modificar arquivo:
>
> "Cria uma página simples com um título Bem-vindo e um parágrafo de introdução"
>
> **Passo 2:** Quando ele terminar, procura o Code Diff e o Walkthrough.
>
> **Passo 3:** Lê o Walkthrough primeiro — entende o que foi feito.
>
> **Passo 4:** Olha o Code Diff — vê as linhas verdes (o que foi adicionado).
>
> Conseguiu encontrar os dois? Conseguiu entender o que cada um mostra?

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> O que você aprendeu hoje é VERIFICAÇÃO.
>
> Você não precisa confiar cegamente no agente. Você pode checar:
> - Walkthrough te diz O QUE foi feito
> - Code Diff te mostra EXATAMENTE o que mudou
>
> É como ter um relatório de auditoria do trabalho.
>
> Na próxima aula, vamos ver os Artifacts visuais: Screenshots e Browser Recordings — a PROVA de que sua criação funciona.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 3](glossario-modulo-03.md)** para definições completas dos termos:
- Code Diff
- Walkthrough
- Linha adicionada (+)
- Linha removida (-)

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Code Diff mostra o que mudou nos arquivos
- [ ] Sei que verde = adicionado, vermelho = removido
- [ ] Entendi que Walkthrough é o resumo em português
- [ ] Sei a ordem: Walkthrough primeiro, Code Diff depois
- [ ] Encontrei ambos os Artifacts após um pedido ao agente

---

## GUIA RÁPIDO DE INTERPRETAÇÃO

### Code Diff
```
+ linha verde = algo NOVO foi criado
- linha vermelha = algo foi REMOVIDO
  linha branca = não mudou (só contexto)
```

### Walkthrough
```
Resumo em português do que foi feito
Leia PRIMEIRO pra ter visão geral
Ideal pra quem não é técnico
```

### Quando usar cada um
```
Quer saber O QUE foi feito? → Walkthrough
Quer ver EXATAMENTE o que mudou? → Code Diff
Algo parece errado? → Code Diff + Feedback
```

---

*Aula 3.3 - Code Diff e Walkthroughs*
*Duração: 8 minutos*
*Professor: Lucas Charao*
