# AULA 1.3: Editor View - O Familiar com Superpoderes

**Módulo:** 1 - Os Três Ambientes do Antigravity
**Duração:** 10 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender pra que serve o Editor View
- Saber visualizar o que o agente criou
- Aprender a pedir ajustes pontuais usando o Agent Panel

### ORIGEM (Position)
Você provavelmente:
- Já usou o Agent Manager pra criar algo na aula anterior
- Quer saber onde foram parar os arquivos que o agente criou
- Nunca usou um "editor de código" na vida (e tá tudo bem!)
- Quer entender como pedir ajustes sem precisar entender código

### ROTA (Steps)
1. Entender a metáfora: Editor View como "bastidores" do seu projeto
2. Aprender a navegar pelos arquivos criados
3. Usar o Agent Panel pra pedir ajustes específicos
4. Prática: fazer uma modificação simples pelo Agent Panel

---

## ROTEIRO COMPLETO

### [ABERTURA] - 30 segundos

**[LUCAS DIZ:]**

> E aí! Lucas Charao de volta.
>
> Na aula passada, você deu sua primeira ordem pro agente e viu ele criar algo. Mas... onde foi parar o que ele criou? Como você vê os arquivos? E se você quiser mudar alguma coisa?
>
> É exatamente isso que a gente vai ver agora. Vem comigo pro Editor View.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto uma coisa: você já pediu pra alguém fazer um trabalho — um design, um texto, uma planilha — e quando a pessoa entregou, você precisou de uns ajustes?
>
> "Ficou ótimo, mas muda a cor desse botão." "Perfeito, só aumenta a fonte aqui."
>
> (pausa)
>
> No Antigravity é igual. O agente cria, mas às vezes você quer ajustar uma coisinha. Não precisa pedir tudo de novo. Você vai direto no ponto e pede o ajuste.
>
> O Editor View é onde você FAZ isso. É onde você vê o que foi criado e pede mudanças pontuais.
>
> Vamos explorar.

---

### [METÁFORA VISUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> Pensa assim:
>
> O **Agent Manager** é a sala de reunião. Você senta com o agente e diz: "Quero um site de agendamento."
>
> O **Editor View** é o canteiro de obras. É onde você vai VER o que tá sendo construído. Os tijolos, as paredes, a pintura.
>
> Você não precisa saber usar as ferramentas de construção. Mas você pode OLHAR e dizer: "Essa parede ficou torta, ajusta aí."
>
> E o agente ajusta.

**[MOSTRAR DIAGRAMA NO SLIDE:]**

```
┌─────────────────────────────────────────────────────┐
│  EDITOR VIEW                                        │
│  ┌──────────┐ ┌───────────────────┐ ┌────────────┐ │
│  │ ARQUIVOS │ │                   │ │   AGENT    │ │
│  │          │ │   ÁREA CENTRAL    │ │   PANEL    │ │
│  │ 📁 pasta │ │                   │ │            │ │
│  │ 📄 index │ │   Aqui você VÊ    │ │  Aqui você │ │
│  │ 📄 style │ │   o conteúdo      │ │  PEDE      │ │
│  │          │ │   dos arquivos    │ │  ajustes   │ │
│  └──────────┘ └───────────────────┘ └────────────┘ │
│  ┌─────────────────────────────────────────────┐   │
│  │ TERMINAL (ignore por enquanto)              │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> Três partes principais:
> - **Esquerda:** lista de arquivos que o agente criou
> - **Centro:** conteúdo do arquivo selecionado
> - **Direita:** Agent Panel, onde você conversa sobre o arquivo

---

### [FUNDAMENTO CONCEITUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> Uma coisa importante pra você entender:
>
> Tudo que o agente cria vira ARQUIVO. Quando ele faz uma página, ele cria um arquivo. Quando ele faz um botão, esse botão tá dentro de um arquivo.
>
> No Editor View, você consegue ver esses arquivos.
>
> "Mas Lucas, eu não sei ler código!"
>
> Tudo bem. Você não PRECISA ler. Você só precisa saber que:
> 1. Os arquivos existem
> 2. Você pode clicar neles pra ver
> 3. Você pode pedir pro agente modificar
>
> O Agent Panel — aquela barra da direita — é seu aliado. Você abre ele, escreve em português o que quer mudar, e o agente faz.
>
> Exemplo: "Muda a cor do botão pra azul." Ele entende e muda.
>
> Simples assim.

---

### [NAVEGAÇÃO GUIADA] - 2 minutos

**[LUCAS DIZ:]**

> Vamos navegar juntos. Abre o Antigravity.
>
> Se você tá no Agent Manager, aperta **Cmd + E** (ou Ctrl + E no Windows) pra ir pro Editor View.
>
> (pausa de 3 segundos)
>
> Agora olha a tela:
>
> **Lado esquerdo** — lista de arquivos. Se você fez o exercício da aula anterior, deve ter um arquivo aqui. Clica nele.
>
> **Centro** — o conteúdo do arquivo aparece. Pode parecer confuso se você não conhece código, mas não precisa entender. Só precisa saber que TÁ AÍ.
>
> **Lado direito** — se não tiver aparecendo o Agent Panel, aperta **Cmd + L** (ou Ctrl + L). Vai abrir uma barra onde você pode conversar com o agente.
>
> Achou tudo? Lista de arquivos, área central, Agent Panel?
>
> Se sim, ótimo. Vamos pro exercício.

---

### [APLICAÇÃO PRÁTICA - AÇÃO RÁPIDA] - 3 minutos

**[LUCAS DIZ:]**

> Agora a parte boa. Vamos fazer um ajuste usando o Agent Panel.
>
> **Passo 1:** Garante que você tá no Editor View (Cmd + E se precisar).
>
> **Passo 2:** Na lista de arquivos da esquerda, clica no arquivo que o agente criou na aula anterior. Se você não fez, volta lá e cria algo simples primeiro.
>
> **Passo 3:** Abre o Agent Panel (Cmd + L).
>
> **Passo 4:** Digita:
>
> "Adiciona um texto embaixo do botão dizendo: Feito com Antigravity"
>
> **Passo 5:** Aperta Enter e observa.
>
> (pausa de 5 segundos)
>
> O agente vai:
> 1. Entender seu pedido
> 2. Modificar o arquivo
> 3. Adicionar o texto onde você pediu
>
> Se funcionou, você vai ver o arquivo mudar na área central.
>
> **Critério de sucesso:** o texto "Feito com Antigravity" apareceu.
>
> Conseguiu?
>
> Se sim, PARABÉNS! Você acabou de fazer uma modificação sem tocar em código. Você só DESCREVEU o que queria.
>
> Essa é a mágica do Agent Panel. Ajustes pontuais, em português, sem complicação.

---

### [EXPANSÃO FILOSÓFICA] - 1 minuto

**[LUCAS DIZ:]**

> Sabe o que é poderoso aqui?
>
> Você não precisou aprender HTML, CSS, JavaScript... nada disso.
>
> Você só precisou saber DESCREVER o que queria. "Adiciona um texto aqui." "Muda a cor pra azul." "Aumenta o tamanho do botão."
>
> O Editor View te dá VISIBILIDADE sobre o que foi criado. E o Agent Panel te dá CONTROLE pra ajustar.
>
> Juntos, eles te transformam num diretor que consegue refinar o trabalho do agente até ficar exatamente como você quer.
>
> Na próxima aula, vamos ver algo ainda mais impressionante: o Browser integrado, onde o agente consegue TESTAR suas criações automaticamente.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 1](glossario-modulo-01.md)** para definições completas dos termos:
- Editor View
- Agent Panel
- Arquivo
- HTML
- Terminal

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Sei alternar entre Agent Manager e Editor View (Cmd + E)
- [ ] Entendi que o Editor View mostra os arquivos que o agente criou
- [ ] Sei abrir o Agent Panel (Cmd + L)
- [ ] Consegui fazer um ajuste usando o Agent Panel
- [ ] Entendi que não preciso saber código — só descrever o que quero

---

## TROUBLESHOOTING (Se der problema)

**Problema:** Não tem nenhum arquivo na lista da esquerda
**Solução:** Você precisa criar algo primeiro. Volta pro Agent Manager (Cmd + E) e pede algo simples como "Cria uma página com um botão".

**Problema:** O Agent Panel não abre
**Solução:** Tenta Cmd + L (Mac) ou Ctrl + L (Windows). Se ainda não funcionar, procura no menu superior.

**Problema:** O agente não entendeu meu pedido
**Solução:** Seja mais específico. Em vez de "muda isso", diga "muda a cor do botão de cinza para azul".

---

## RECURSOS

- Atalho Agent Manager ↔ Editor: **Cmd + E** (Mac) / **Ctrl + E** (Windows)
- Atalho Agent Panel: **Cmd + L** (Mac) / **Ctrl + L** (Windows)

---

*Aula 1.3 - Editor View - O Familiar com Superpoderes*
*Duração: 10 minutos*
*Professor: Lucas Charao*
