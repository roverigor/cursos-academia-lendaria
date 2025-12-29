# AULA 3.2: Dando Feedback em Artifacts

**Módulo:** 3 - Sistema de Artifacts
**Duração:** 8 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Saber como dar feedback diretamente nos Artifacts
- Conseguir corrigir o rumo do agente antes dele terminar
- Dominar a técnica de comentários efetivos

### ORIGEM (Position)
Você provavelmente:
- Já sabe o que são Artifacts (aula anterior)
- Viu Artifacts aparecendo mas não interagiu com eles
- Quer aprender a GUIAR o agente pro resultado certo
- Já teve situações onde o agente fez algo diferente do que você queria

### ROTA (Steps)
1. Entender como funciona o sistema de feedback
2. Aprender a dar feedback efetivo (exemplos bons e ruins)
3. Praticar comentando em um Artifact
4. Ver o agente ajustar baseado no seu feedback

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Lucas Charao aqui!
>
> Você já sabe o que são Artifacts. Agora vem a parte poderosa: você pode INTERAGIR com eles. Dar feedback. Pedir mudanças. Guiar o agente.
>
> É tipo revisar um documento no Google Docs e deixar comentários. Vem ver.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto: você já trabalhou com alguém que te mostrou um rascunho e perguntou "o que você acha?"
>
> E você olhou e pensou: "Tá bom, mas eu mudaria isso aqui... e aquilo ali..."
>
> (pausa)
>
> No Google Docs ou Word, você seleciona o trecho e deixa um comentário. A pessoa vê e ajusta.
>
> No Antigravity funciona IGUAL.
>
> O agente te mostra o plano (Task List). Você olha e pensa: "Hmm, eu preferia que fosse diferente." Você comenta direto no Artifact. O agente lê e ajusta.
>
> Sem precisar explicar tudo de novo. Sem precisar começar do zero.

---

### [COMO FUNCIONA] - 1.5 minutos

**[LUCAS DIZ:]**

> O processo é simples:

**[MOSTRAR NO SLIDE:]**

```
PASSO A PASSO:

1. ARTIFACT APARECE
   O agente mostra Task List, Code Diff, etc.

2. VOCÊ CLICA PRA EXPANDIR
   Abre o Artifact pra ver os detalhes

3. VOCÊ SELECIONA UM TRECHO
   Igual selecionar texto no Google Docs

4. VOCÊ ESCREVE SEU COMENTÁRIO
   "Prefiro assim..." / "Muda isso pra..."

5. AGENTE LÊ E AJUSTA
   Ele incorpora o feedback e continua
```

**[LUCAS DIZ:]**

> O legal é que o agente NÃO PARA de trabalhar. Ele lê seu comentário e ajusta enquanto continua.
>
> É feedback em tempo real.

---

### [FEEDBACK BOM VS RUIM] - 2 minutos

**[LUCAS DIZ:]**

> Agora, nem todo feedback é útil. Deixa eu te mostrar a diferença:

**[MOSTRAR NO SLIDE:]**

```
❌ FEEDBACK RUIM (vago, não ajuda):

"Não gostei"
"Tá errado"
"Refaz"
"Muda isso"

→ O agente não sabe O QUE mudar nem PRA QUE mudar
```

```
✅ FEEDBACK BOM (específico, direciona):

"Use azul ao invés de verde no botão"
"Prefiro o campo de telefone antes do email"
"Adiciona validação pra não aceitar email inválido"
"Remove o campo de endereço, não precisa"

→ O agente sabe EXATAMENTE o que fazer
```

**[LUCAS DIZ:]**

> A regra é simples: seja ESPECÍFICO.
>
> Em vez de dizer "tá errado", diga O QUE está errado e COMO você quer.
>
> Quanto mais claro você for, melhor o resultado.

---

### [EXEMPLOS PRÁTICOS] - 1 minuto

**[LUCAS DIZ:]**

> Alguns exemplos de feedback que funcionam bem:

**[MOSTRAR NO SLIDE:]**

```
SOBRE TASK LIST:
"Adiciona uma etapa de validação antes de salvar"
"Remove a parte de login, não precisa por enquanto"
"Faz o formulário primeiro, CSS depois"

SOBRE CODE DIFF:
"Muda a cor de #333 pra #000"
"O botão precisa ser maior"
"Adiciona um texto de ajuda embaixo do campo"

SOBRE WALKTHROUGH:
"Faltou mencionar como funciona o envio"
"Preciso que o resumo inclua os campos do formulário"
```

**[LUCAS DIZ:]**

> Percebe? Tudo específico. Tudo acionável. O agente lê e sabe exatamente o que fazer.

---

### [APLICAÇÃO PRÁTICA] - 2 minutos

**[LUCAS DIZ:]**

> Vamos praticar. Exercício passo a passo:
>
> **Passo 1:** Vai no Agent Manager e pede:
>
> "Use planning mode e crie uma página de cadastro com nome, email e senha"
>
> **Passo 2:** Quando a Task List aparecer, CLICA nela pra expandir.
>
> **Passo 3:** Lê o plano. Provavelmente ele vai listar algo como:
> - Criar arquivo HTML
> - Adicionar campos
> - Estilizar com CSS
>
> **Passo 4:** Agora COMENTA. Seleciona uma parte e escreve:
>
> "Adiciona também um campo de confirmação de senha"
>
> **Passo 5:** Observa. O agente vai ajustar o plano pra incluir o campo que você pediu.
>
> (pausa de 5 segundos)
>
> Funcionou? Você viu o plano mudar depois do seu comentário?
>
> Se sim, PARABÉNS! Você acabou de guiar o agente pro resultado que VOCÊ queria.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Isso é COLABORAÇÃO.
>
> Você não é passivo esperando o agente terminar. Você é ativo, guiando, ajustando, direcionando.
>
> É como ter um assistente que te mostra o rascunho e pergunta: "Tá bom assim?" E você pode dizer: "Quase, só ajusta isso."
>
> Na próxima aula, vamos mergulhar em dois Artifacts específicos: Code Diff e Walkthrough — pra você entender o que o agente REALMENTE fez.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 3](glossario-modulo-03.md)** para definições completas dos termos:
- Feedback
- Comentário
- Task List
- Code Diff

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Sei que posso comentar diretamente nos Artifacts
- [ ] Entendi a diferença entre feedback vago e específico
- [ ] Consegui expandir um Artifact e ver os detalhes
- [ ] Deixei um comentário e vi o agente ajustar o plano
- [ ] Entendi que feedback específico = melhor resultado

---

## GUIA DE FEEDBACK EFETIVO

### Fórmula Simples
```
[O QUE] + [COMO VOCÊ QUER]

Exemplo:
"O botão" + "precisa ser azul ao invés de verde"
"O campo de telefone" + "deve vir antes do email"
"A validação" + "precisa verificar se o email tem @"
```

### Palavras Úteis
- "Prefiro..." → indica preferência
- "Muda X pra Y" → mudança específica
- "Adiciona..." → inclusão
- "Remove..." → exclusão
- "Antes de..." / "Depois de..." → ordem

---

*Aula 3.2 - Dando Feedback em Artifacts*
*Duração: 8 minutos*
*Professor: Lucas Charao*
