# AULA 5.1: Rules - Instruções Persistentes

**Módulo:** 5 - Rules e Workflows [PLUS]
**Duração:** 10 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Rules e pra que servem
- Criar sua primeira Rule
- Ver o agente seguindo suas instruções automaticamente

### ORIGEM (Position)
Você provavelmente:
- Já pediu a mesma coisa várias vezes pro agente
- Quer que o agente siga certas regras SEMPRE, sem precisar repetir
- Busca padronizar o trabalho do agente
- Quer economizar tempo com instruções repetitivas

### ROTA (Steps)
1. Entender o conceito de Rules (instruções persistentes)
2. Saber onde ficam os arquivos de Rules
3. Criar uma Rule simples
4. Testar se o agente está seguindo

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Bem-vindo ao Módulo 5! Lucas Charao aqui.
>
> Esse módulo é [PLUS] — são recursos mais avançados que vão te diferenciar.
>
> Vamos começar com Rules: instruções que o agente segue SEMPRE, sem você precisar repetir.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto: você já teve que repetir a mesma instrução várias vezes pra mesma pessoa?
>
> "Lembra de salvar o arquivo." "Lembra de usar esse formato." "Lembra de fazer desse jeito."
>
> (pausa)
>
> É cansativo, né? Você queria que a pessoa simplesmente SOUBESSE e fizesse sempre certo.
>
> Com o agente é igual. Toda vez que você pede algo, precisa lembrar: "Ah, e usa português nos textos. Ah, e segue esse padrão. Ah, e faz assim..."
>
> Rules resolvem isso. Você escreve UMA VEZ as instruções, e o agente segue SEMPRE. Automaticamente.
>
> É como dar um manual pro funcionário no primeiro dia. Depois disso, ele sabe as regras.

---

### [O QUE SÃO RULES] - 1.5 minutos

**[LUCAS DIZ:]**

> Rules são arquivos de texto com instruções que o agente lê TODA VEZ que trabalha no seu projeto.

**[MOSTRAR NO SLIDE:]**

```
RULES = Instruções que o agente sempre segue

ONDE FICAM:
• Global (todos os projetos): ~/.gemini/rules/
• Projeto específico: .agent/rules/

FORMATO:
• Arquivos .md (markdown)
• Texto simples com suas regras

O QUE COLOCAR:
• Padrões de estilo
• Preferências de linguagem
• Regras de nomenclatura
• Qualquer instrução que você quer que seja seguida sempre
```

**[LUCAS DIZ:]**

> Pensa assim: é um "manual do funcionário" que o agente lê antes de começar a trabalhar.
>
> Você escreve uma vez, ele segue sempre.

---

### [EXEMPLOS DE RULES] - 1.5 minutos

**[LUCAS DIZ:]**

> Deixa eu te mostrar alguns exemplos práticos de Rules:

**[MOSTRAR NO SLIDE:]**

```markdown
# Exemplo 1: estilo.md

- Todos os textos devem ser em português do Brasil
- Use linguagem informal e amigável
- Botões devem ter cores vibrantes
- Formulários devem ter validação de campos obrigatórios
```

```markdown
# Exemplo 2: padrao-visual.md

- Use a cor #3B82F6 (azul) como cor principal
- Fonte padrão: Inter ou Arial
- Espaçamento entre elementos: 16px mínimo
- Bordas arredondadas: 8px
```

```markdown
# Exemplo 3: meu-negocio.md

- O nome da empresa é "Minha Loja"
- Logo deve aparecer no canto superior esquerdo
- Informações de contato: (11) 99999-9999
- Sempre incluir link para WhatsApp
```

**[LUCAS DIZ:]**

> Viu? São instruções simples, em português, que o agente vai seguir automaticamente.
>
> Você personaliza pro seu contexto.

---

### [CRIANDO SUA PRIMEIRA RULE] - 3 minutos

**[LUCAS DIZ:]**

> Vamos criar uma Rule juntos. Passo a passo:
>
> **Passo 1:** No seu projeto, cria uma pasta chamada `.agent`
>
> Dentro dela, cria outra pasta chamada `rules`
>
> Estrutura: `.agent/rules/`
>
> **Passo 2:** Dentro de `rules`, cria um arquivo chamado `meu-estilo.md`
>
> **Passo 3:** Abre o arquivo e escreve suas regras. Por exemplo:

**[MOSTRAR NO SLIDE:]**

```markdown
# Minhas Regras de Estilo

- Todos os textos em português do Brasil
- Use linguagem simples e direta
- Cores preferidas: azul (#3B82F6) e branco
- Botões devem ser grandes e fáceis de clicar
- Sempre adicione mensagens de erro amigáveis
```

**[LUCAS DIZ:]**

> **Passo 4:** Salva o arquivo.
>
> **Passo 5:** Agora pede algo pro agente:
>
> "Cria uma página com um formulário de contato"
>
> **Passo 6:** Observa. O agente deve seguir suas regras automaticamente — textos em português, cores certas, etc.
>
> (pausa de 5 segundos)
>
> Funcionou? O agente usou português e seguiu suas preferências?
>
> Se sim, sua Rule está funcionando!

---

### [DICAS IMPORTANTES] - 1 minuto

**[LUCAS DIZ:]**

> Algumas dicas importantes sobre Rules:
>
> **1. Seja específico**
> "Use azul" é vago. "Use #3B82F6 como cor principal" é específico.
>
> **2. Uma regra por linha**
> Facilita a leitura pro agente.
>
> **3. Não exagere**
> Muitas regras confundem. Comece com 5-10 regras essenciais.
>
> **4. Atualize conforme necessário**
> Suas preferências mudam? Atualiza o arquivo.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Rules são sobre CONSISTÊNCIA.
>
> Em vez de ficar repetindo instruções, você define uma vez e esquece. O agente sempre vai seguir.
>
> Isso é especialmente útil se você trabalha com vários projetos ou clientes. Cada um pode ter suas próprias Rules.
>
> Na próxima aula, vamos ver Workflows — prompts reutilizáveis que você dispara com /comando.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 5](glossario-modulo-05.md)** para definições completas dos termos:
- Rule
- Instruções persistentes
- .agent/rules/
- Markdown

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Rules são instruções que o agente sempre segue
- [ ] Sei que ficam em .agent/rules/
- [ ] Criei minha primeira Rule
- [ ] Testei e vi o agente seguindo a regra
- [ ] Entendi que devo ser específico nas instruções

---

## ESTRUTURA DE PASTAS

```
seu-projeto/
├── .agent/
│   └── rules/
│       ├── estilo.md
│       ├── linguagem.md
│       └── meu-negocio.md
└── ... (outros arquivos do projeto)
```

---

## MODELO DE RULE INICIAL

```markdown
# Minhas Preferências

## Linguagem
- Textos em português do Brasil
- Tom informal e amigável

## Visual
- Cor principal: [sua cor]
- Fonte: [sua fonte preferida]

## Comportamento
- Sempre validar formulários
- Mensagens de erro amigáveis
- [outras regras do seu contexto]
```

---

*Aula 5.1 - Rules: Instruções Persistentes*
*Duração: 10 minutos*
*Professor: Lucas Charao*
