# AULA 3.4: Screenshots e Browser Recordings

**Módulo:** 3 - Sistema de Artifacts
**Duração:** 8 minutos
**Tipo:** Demo
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Saber usar Screenshots pra ver o resultado visual
- Entender como Browser Recordings mostram testes em ação
- Usar evidências visuais pra validar suas criações

### ORIGEM (Position)
Você provavelmente:
- Já viu screenshots aparecerem mas não explorou muito
- Quer ver VISUALMENTE se o que foi criado está certo
- Prefere imagens e vídeos a textos técnicos
- Quer ter certeza de que sua criação funciona antes de entregar

### ROTA (Steps)
1. Entender quando Screenshots aparecem
2. Conhecer Browser Recordings e sua utilidade
3. Aprender a usar evidências visuais pra debugging
4. Praticar pedindo um teste visual

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Última aula do Módulo 3! Lucas Charao aqui.
>
> A gente viu Task List, Walkthrough, Code Diff... Agora vamos pros Artifacts mais satisfatórios: os VISUAIS.
>
> Screenshot e Browser Recording. Ver pra crer!

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto: quando alguém te diz "ficou pronto", o que você prefere?
>
> Opção A: A pessoa diz "Tá pronto, confie em mim."
>
> Opção B: A pessoa te mostra uma FOTO do resultado.
>
> Opção C: A pessoa te mostra um VÍDEO usando o que foi criado.
>
> (pausa)
>
> Acho que todo mundo prefere B ou C, né?
>
> Screenshots e Recordings são exatamente isso. O agente não só diz que fez — ele te MOSTRA. Foto e vídeo.
>
> Você VÊ o resultado. Você VÊ funcionando.

---

### [SCREENSHOTS EXPLICADO] - 1.5 minutos

**[LUCAS DIZ:]**

> Screenshot é simples: uma FOTO da tela.

**[MOSTRAR NO SLIDE:]**

```
SCREENSHOT = Foto do resultado

QUANDO APARECE:
• Quando o agente testa algo no browser
• Quando você pede "tira um screenshot"
• Quando ele quer te mostrar como ficou visualmente

PRA QUE SERVE:
• Ver se o design ficou certo
• Verificar se os elementos estão no lugar
• Ter prova visual do resultado
```

**[LUCAS DIZ:]**

> Exemplo prático:
>
> Você pede: "Cria uma página de login com logo, campos de email e senha, e botão entrar."
>
> O agente cria e tira um screenshot.
>
> Você olha a foto e vê: "Hmm, o logo tá muito pequeno. O botão tá da cor errada."
>
> Aí você dá feedback: "Aumenta o logo e muda o botão pra azul."
>
> Simples. Visual. Direto.

---

### [BROWSER RECORDINGS EXPLICADO] - 2 minutos

**[LUCAS DIZ:]**

> Browser Recording vai além: é um VÍDEO do agente testando sua criação.

**[MOSTRAR NO SLIDE:]**

```
BROWSER RECORDING = Vídeo do teste

O QUE VOCÊ VÊ:
• O agente abrindo sua página
• Clicando em botões
• Preenchendo formulários
• Navegando entre telas
• O resultado de cada ação

PRA QUE SERVE:
• Ver se o fluxo funciona
• Identificar bugs visuais
• Ter prova de que funciona
• Debugar problemas
```

**[LUCAS DIZ:]**

> Imagina: você criou um formulário de contato.
>
> O agente grava um vídeo onde ele:
> 1. Abre a página
> 2. Preenche o nome
> 3. Preenche o email
> 4. Escreve uma mensagem
> 5. Clica em Enviar
> 6. Mostra a mensagem de sucesso
>
> Você assiste e vê: "Opa, quando clica em Enviar, dá erro." ou "Perfeito, funcionou!"
>
> É PROVA em vídeo de que funciona (ou não).

---

### [QUANDO USAR CADA UM] - 1 minuto

**[LUCAS DIZ:]**

> Regra simples:

**[MOSTRAR NO SLIDE:]**

```
USE SCREENSHOT QUANDO:
• Quer ver como FICOU visualmente
• Quer verificar design/layout
• Quer uma foto rápida do estado atual

USE RECORDING QUANDO:
• Quer ver se FUNCIONA
• Tem interação (cliques, formulários)
• Quer testar um fluxo completo
• Quer prova de funcionamento
```

**[LUCAS DIZ:]**

> Screenshot = como PARECE
> Recording = como FUNCIONA
>
> Os dois juntos te dão confiança total de que sua criação está certa.

---

### [APLICAÇÃO PRÁTICA] - 2 minutos

**[LUCAS DIZ:]**

> Vamos praticar. Exercício completo:
>
> **Passo 1:** Vai no Agent Manager e pede:
>
> "Cria uma página com um botão que diz Clique Aqui. Quando clicar, deve aparecer uma mensagem Você clicou! Depois testa e me mostra um screenshot e um vídeo do teste."
>
> **Passo 2:** Deixa o agente trabalhar.
>
> **Passo 3:** Quando terminar, procura os Artifacts:
> - Screenshot mostrando a página
> - Recording mostrando o clique e a mensagem
>
> **Passo 4:** Assiste o vídeo. Vê se funcionou.
>
> (pausa de 5 segundos)
>
> Conseguiu? Viu o screenshot? Assistiu o recording?
>
> Se sim, você tem PROVA VISUAL de que sua criação funciona. Isso é poderoso.

---

### [USANDO PRA DEBUGGING] - 30 segundos

**[LUCAS DIZ:]**

> Dica importante: Screenshots e Recordings são ótimos pra encontrar problemas.
>
> Se algo não tá funcionando:
>
> 1. Pede pro agente: "Testa isso e grava o vídeo"
> 2. Assiste o vídeo
> 3. Identifica onde deu errado
> 4. Dá feedback específico: "No segundo 15 do vídeo, quando clica no botão, dá erro. Corrige isso."
>
> É debugging visual. Sem precisar entender código.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Você completou o Módulo 3!
>
> Agora você domina os Artifacts:
> - Task List e Implementation Plan = O que ele VAI fazer
> - Code Diff e Walkthrough = O que ele FEZ
> - Screenshot e Recording = PROVA de que funciona
>
> Você tem visibilidade total do trabalho do agente. Você pode verificar, comentar, ajustar.
>
> Nos próximos módulos, vamos acelerar sua produtividade com Atalhos e depois personalizar o agente com Rules e Workflows.
>
> Te vejo no Módulo 4!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 3](glossario-modulo-03.md)** para definições completas dos termos:
- Screenshot
- Browser Recording
- Debugging
- Evidência visual

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Screenshot é foto do resultado
- [ ] Entendi que Recording é vídeo do teste
- [ ] Sei quando usar cada um (visual vs funcional)
- [ ] Consegui pedir um teste com screenshot e recording
- [ ] Entendi como usar visuais pra encontrar problemas

---

## RESUMO DO MÓDULO 3

| Artifact | O que mostra | Quando usar |
|----------|--------------|-------------|
| **Task List** | Plano do agente | Antes de executar |
| **Implementation Plan** | Detalhes técnicos | Antes de executar |
| **Code Diff** | O que mudou | Depois de executar |
| **Walkthrough** | Resumo em português | Depois de executar |
| **Screenshot** | Foto do resultado | Verificar visual |
| **Recording** | Vídeo do teste | Verificar funcionamento |

---

## PRÓXIMOS PASSOS

**Módulo 4:** Atalhos e Produtividade
- Os 5 atalhos essenciais
- Menções com @
- Navegação 3x mais rápida

---

*Aula 3.4 - Screenshots e Browser Recordings*
*Duração: 8 minutos*
*Professor: Lucas Charao*

---

## 🎉 PARABÉNS!

Você completou o **Módulo 3: Sistema de Artifacts**.

Agora você sabe:
- O que são Artifacts e os 6 tipos principais
- Como dar feedback direto nos Artifacts
- Como interpretar Code Diff e Walkthrough
- Como usar Screenshots e Recordings pra verificar

**Próximo passo:** Módulo 4 - Atalhos e Produtividade
