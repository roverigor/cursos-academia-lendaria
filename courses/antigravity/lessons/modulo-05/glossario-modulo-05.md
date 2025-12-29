# 📖 Glossário do Módulo 5: Rules e Workflows

**Curso:** Google Antigravity Essencial
**Professor:** Lucas Charao
**Uso:** Referência rápida durante e depois das aulas

---

## 📌 Como Usar Este Glossário

- **Durante a aula:** Consulte quando o professor mencionar um termo novo
- **Depois da aula:** Use como referência ao criar Rules e Workflows
- **Nos estudos:** Use os templates fornecidos como ponto de partida

**Organização:** Alfabética (A-Z)

---

## A

### .agent/
Pasta especial dentro do seu projeto onde ficam Rules e Workflows específicos daquele projeto.

**Estrutura:**
```
.agent/
├── rules/      ← Rules do projeto
└── workflows/  ← Workflows do projeto
```

**Ver também:** Rules, Workflows

---

## C

### Comando (/)
Forma de executar um Workflow. Você digita / seguido do nome do workflow.

**Como funciona:**
- Arquivo: `doc.md`
- Comando: `/doc`
- O nome do arquivo (sem .md) vira o comando

**Exemplo:** /test, /doc, /melhorar

**Ver também:** Workflow

---

## G

### Global (Rules/Workflows)
Rules e Workflows que se aplicam a TODOS os seus projetos, não só um específico.

**Onde ficam:**
- Rules globais: `~/.gemini/rules/`
- Workflows globais: `~/.gemini/workflows/`

**Quando usar:** Preferências pessoais que você quer em todo projeto.

**Ver também:** Projeto (Rules/Workflows)

---

## I

### Instruções Persistentes
Outro nome para Rules. São instruções que persistem (continuam valendo) em todas as interações.

**Ver também:** Rule

---

## K

### Kit Inicial
Conjunto básico de Rules e Workflows pra começar um projeto novo.

**Kit sugerido:**
```
.agent/
├── rules/
│   ├── estilo.md
│   ├── qualidade.md
│   └── meu-negocio.md
└── workflows/
    ├── doc.md
    ├── test.md
    └── melhorar.md
```

---

## M

### Markdown (.md)
Formato de arquivo usado para Rules e Workflows. É texto simples com algumas formatações básicas.

**Exemplo:**
```markdown
# Título

- Item 1
- Item 2

**Texto em negrito**
```

**Por que usar:** Fácil de escrever, fácil pro agente ler.

---

## P

### Projeto (Rules/Workflows)
Rules e Workflows que se aplicam apenas a um projeto específico.

**Onde ficam:** `.agent/rules/` e `.agent/workflows/` dentro do projeto.

**Quando usar:** Configurações específicas daquele projeto (cores da marca, nome da empresa, etc.)

**Ver também:** Global (Rules/Workflows)

---

### Prompt Reutilizável
Outro nome para Workflow. É um prompt (instrução) que você salva pra reutilizar depois.

**Ver também:** Workflow

---

## R

### Rule (Regra)
Instrução que o agente segue SEMPRE, automaticamente, sem você precisar pedir.

**Características:**
- Sempre ativa
- Lida automaticamente pelo agente
- Define padrões e preferências constantes

**Onde fica:** `.agent/rules/` (projeto) ou `~/.gemini/rules/` (global)

**Exemplos:**
- "Use português do Brasil"
- "Cor principal: #3B82F6"
- "Tom informal e amigável"

**Diferença de Workflow:** Rule é passiva (sempre vale). Workflow é ativo (você dispara).

**Ver também:** Workflow, .agent/

---

## S

### Sistema (Rules + Workflows)
Combinação de Rules e Workflows que trabalham juntos pra personalizar o agente pro seu contexto.

**Como funciona:**
- Rules definem o "sempre" (identidade, padrões)
- Workflows definem o "quando pedir" (ações, tarefas)

---

## T

### Template
Modelo pronto pra você copiar e adaptar.

**Templates de Rules:**
```markdown
# estilo.md
- Cor principal: [COR]
- Textos em português
- Tom [formal/informal]
```

**Templates de Workflows:**
```markdown
# test.md
Teste a página atual.
Clique em todos os botões.
Tire screenshots.
Liste problemas.
```

---

## W

### Workflow
Prompt salvo que você executa quando quiser, usando /comando.

**Características:**
- Executado sob demanda
- Você dispara com /nome
- Define ações e tarefas específicas

**Onde fica:** `.agent/workflows/` (projeto) ou `~/.gemini/workflows/` (global)

**Exemplos:**
- `/doc` → Gera documentação
- `/test` → Testa a página
- `/melhorar` → Analisa e melhora

**Diferença de Rule:** Workflow é ativo (você dispara). Rule é passiva (sempre vale).

**Ver também:** Rule, Comando (/)

---

## 📊 Comparativo Rules vs Workflows

| Aspecto | Rules | Workflows |
|---------|-------|-----------|
| **Quando funciona** | Sempre | Quando você pedir |
| **Como ativar** | Automático | Com /comando |
| **Pra que usar** | Padrões constantes | Tarefas pontuais |
| **Exemplos** | Cores, tom, idioma | /doc, /test, /review |
| **Pasta** | .agent/rules/ | .agent/workflows/ |

---

## 📁 Estrutura Completa de Pastas

```
seu-projeto/
├── .agent/
│   ├── rules/              ← Regras do projeto
│   │   ├── estilo.md
│   │   ├── qualidade.md
│   │   └── meu-negocio.md
│   │
│   └── workflows/          ← Workflows do projeto
│       ├── doc.md          → /doc
│       ├── test.md         → /test
│       └── melhorar.md     → /melhorar
│
└── ... (outros arquivos)


~/.gemini/                   ← Pasta global (home)
├── rules/                   ← Rules pra todos os projetos
└── workflows/               ← Workflows pra todos os projetos
```

---

## 💡 Dicas de Uso

1. **Comece simples:** 2-3 Rules e 2-3 Workflows são suficientes pra começar.

2. **Seja específico nas Rules:** "Azul #3B82F6" é melhor que "azul".

3. **Um propósito por Workflow:** /doc só documenta, /test só testa.

4. **Nomes curtos:** /doc, /test são mais fáceis que /gerar-documentacao.

5. **Atualize conforme necessário:** Suas preferências mudam, atualize os arquivos.

---

## 📚 Glossários Relacionados

- **Módulo 1:** Termos básicos (Agent Manager, Editor View)
- **Módulo 2:** Termos de controle (Planning Mode, Políticas)
- **Módulo 3:** Termos sobre Artifacts
- **Módulo 4:** Termos sobre Atalhos
- **Módulo 6:** Termos sobre Segurança

---

**Última atualização:** 2025-12-16
**Criado por:** Course Architect Agent

---

**Use os templates como ponto de partida pra seus próprios Rules e Workflows! 📖**
