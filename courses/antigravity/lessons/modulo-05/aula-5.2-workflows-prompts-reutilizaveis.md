# AULA 5.2: Workflows - Prompts Reutilizáveis

**Módulo:** 5 - Rules e Workflows [PLUS]
**Duração:** 10 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Workflows e como diferem de Rules
- Criar seu primeiro Workflow
- Executar um Workflow com /comando

### ORIGEM (Position)
Você provavelmente:
- Já sabe criar Rules (aula anterior)
- Tem tarefas que faz repetidamente (gerar documentação, criar testes, etc.)
- Quer economizar tempo com prompts que usa sempre
- Quer criar "atalhos" pras suas tarefas frequentes

### ROTA (Steps)
1. Entender a diferença entre Rules e Workflows
2. Saber onde ficam os arquivos de Workflows
3. Criar um Workflow simples
4. Executar com /comando

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Lucas Charao de volta!
>
> Na aula passada você aprendeu Rules — instruções que o agente sempre segue. Agora vamos ver Workflows — prompts que você executa QUANDO QUISER.
>
> São coisas diferentes. Vem entender.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto: você tem tarefas que faz sempre igual?
>
> Tipo: "toda vez que termino algo, peço pro agente gerar uma documentação" ou "sempre que crio uma página, peço pra testar".
>
> (pausa)
>
> Toda vez você escreve o mesmo prompt, com as mesmas instruções...
>
> E se você pudesse salvar esse prompt e executar com um comando simples? Tipo /doc pra documentar, /test pra testar?
>
> Workflows são exatamente isso. Prompts salvos que você dispara quando precisa.

---

### [RULES VS WORKFLOWS] - 1 minuto

**[LUCAS DIZ:]**

> Vamos deixar clara a diferença:

**[MOSTRAR NO SLIDE:]**

```
RULES                          WORKFLOWS
─────────────────────────────────────────────────
• Sempre ativos               • Executados sob demanda
• Agente segue automaticamente • Você dispara com /comando
• São REGRAS constantes       • São AÇÕES pontuais

EXEMPLOS:
Rule: "Use português"         Workflow: /doc (gera documentação)
Rule: "Cor azul"              Workflow: /test (roda testes)
Rule: "Tom informal"          Workflow: /review (pede revisão)
```

**[LUCAS DIZ:]**

> Resumindo:
> - **Rules** = o agente SEMPRE segue (passivo)
> - **Workflows** = você DISPARA quando quer (ativo)

---

### [ONDE FICAM WORKFLOWS] - 1 minuto

**[LUCAS DIZ:]**

> Workflows também ficam em arquivos .md:

**[MOSTRAR NO SLIDE:]**

```
ONDE FICAM:
• Global (todos os projetos): ~/.gemini/workflows/
• Projeto específico: .agent/workflows/

COMO FUNCIONAM:
• Arquivo: doc.md
• Comando: /doc
• O nome do arquivo vira o comando

ESTRUTURA:
seu-projeto/
├── .agent/
│   ├── rules/        ← Regras constantes
│   └── workflows/    ← Prompts sob demanda
│       ├── doc.md
│       ├── test.md
│       └── review.md
```

---

### [EXEMPLOS DE WORKFLOWS] - 1.5 minutos

**[LUCAS DIZ:]**

> Alguns exemplos de Workflows úteis:

**[MOSTRAR NO SLIDE:]**

```markdown
# doc.md (executar com /doc)

Gere documentação para o arquivo atual.

Inclua:
- Descrição do que o arquivo faz
- Lista de funcionalidades
- Como usar
- Exemplos se aplicável
```

```markdown
# test.md (executar com /test)

Teste a página/funcionalidade atual.

Faça:
1. Abra no browser
2. Teste todos os botões e links
3. Preencha formulários com dados de teste
4. Tire screenshots do resultado
5. Relate qualquer problema encontrado
```

```markdown
# readme.md (executar com /readme)

Crie um README.md para este projeto.

Inclua:
- Nome do projeto
- Descrição breve
- Como instalar/usar
- Contato
```

**[LUCAS DIZ:]**

> Viu? Cada arquivo é um prompt completo. Quando você digita /doc, o agente executa todo aquele prompt.

---

### [CRIANDO SEU PRIMEIRO WORKFLOW] - 3 minutos

**[LUCAS DIZ:]**

> Vamos criar um Workflow juntos:
>
> **Passo 1:** Na pasta `.agent` do seu projeto, cria uma pasta `workflows`
>
> Estrutura: `.agent/workflows/`
>
> **Passo 2:** Cria um arquivo chamado `melhorar.md`
>
> **Passo 3:** Escreve o seguinte conteúdo:

**[MOSTRAR NO SLIDE:]**

```markdown
# Melhorar Página

Analise a página atual e sugira melhorias:

1. Visual
   - As cores estão harmoniosas?
   - O espaçamento está adequado?
   - É fácil de ler?

2. Usabilidade
   - Os botões são fáceis de encontrar?
   - O fluxo faz sentido?
   - Funciona bem em celular?

3. Conteúdo
   - Os textos estão claros?
   - Falta alguma informação importante?

Depois de analisar, faça as melhorias automaticamente.
```

**[LUCAS DIZ:]**

> **Passo 4:** Salva o arquivo.
>
> **Passo 5:** No Agent Panel, digita: `/melhorar`
>
> **Passo 6:** Observa. O agente vai executar todo aquele prompt e melhorar sua página.
>
> (pausa de 5 segundos)
>
> Funcionou? O agente analisou e melhorou a página?
>
> Se sim, você acabou de criar seu primeiro Workflow!

---

### [DICAS DE WORKFLOWS] - 1 minuto

**[LUCAS DIZ:]**

> Dicas pra criar bons Workflows:
>
> **1. Nomes curtos e claros**
> /doc, /test, /review — fáceis de lembrar e digitar
>
> **2. Instruções completas**
> O Workflow deve ter TODAS as instruções necessárias. Você não vai digitar mais nada.
>
> **3. Um propósito por Workflow**
> /doc só documenta. /test só testa. Não misture.
>
> **4. Comece com poucos**
> 3-5 Workflows bem feitos é melhor que 20 bagunçados.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Workflows são sobre AUTOMAÇÃO.
>
> Tarefas que você faz sempre podem virar um comando de uma palavra.
>
> Isso não só economiza tempo — também garante CONSISTÊNCIA. O Workflow é sempre executado igual, sem você esquecer nenhum passo.
>
> Na próxima aula, vamos ver como combinar Rules + Workflows pra criar um sistema personalizado pro seu projeto.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 5](glossario-modulo-05.md)** para definições completas dos termos:
- Workflow
- Comando (/)
- .agent/workflows/
- Prompt reutilizável

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi a diferença entre Rules (sempre ativos) e Workflows (sob demanda)
- [ ] Sei que Workflows ficam em .agent/workflows/
- [ ] Criei meu primeiro Workflow
- [ ] Executei com /comando e vi funcionar
- [ ] Entendi que o nome do arquivo vira o comando

---

## IDEIAS DE WORKFLOWS

| Comando | Função |
|---------|--------|
| /doc | Gera documentação |
| /test | Testa a página |
| /review | Pede revisão |
| /readme | Cria README |
| /melhorar | Analisa e melhora |
| /mobile | Testa em celular |
| /acessibilidade | Verifica acessibilidade |

---

## ESTRUTURA COMPLETA

```
seu-projeto/
├── .agent/
│   ├── rules/           ← Regras constantes
│   │   └── estilo.md
│   └── workflows/       ← Prompts sob demanda
│       ├── doc.md       → /doc
│       ├── test.md      → /test
│       └── melhorar.md  → /melhorar
└── ... (arquivos do projeto)
```

---

*Aula 5.2 - Workflows: Prompts Reutilizáveis*
*Duração: 10 minutos*
*Professor: Lucas Charao*
