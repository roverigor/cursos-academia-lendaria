# AULA 5.3: Combinando Rules + Workflows

**Módulo:** 5 - Rules e Workflows [PLUS]
**Duração:** 10 minutos
**Tipo:** Estratégia
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Saber quando usar Rule vs Workflow
- Criar um sistema personalizado pro seu projeto
- Ter templates prontos pra começar

### ORIGEM (Position)
Você provavelmente:
- Já sabe criar Rules e Workflows separadamente
- Quer entender como combinar os dois
- Busca montar um "kit" pra seus projetos
- Quer exemplos práticos de combinação

### ROTA (Steps)
1. Revisar quando usar Rule vs Workflow
2. Ver um exemplo de sistema completo
3. Montar seu próprio kit inicial
4. Ter templates pra copiar e usar

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Última aula do Módulo 5! Lucas Charao aqui.
>
> Você já sabe criar Rules e Workflows. Agora vamos COMBINAR os dois num sistema que faz sentido pro seu trabalho.
>
> Essa é a aula que junta tudo.

---

### [GANCHO EMOCIONAL] - 45 segundos

**[LUCAS DIZ:]**

> Imagina que você tá montando uma equipe.
>
> As **Rules** são as regras da empresa — todo mundo segue sempre. "Chegue no horário", "Use uniforme", "Fale com respeito".
>
> Os **Workflows** são os procedimentos — você executa quando precisa. "Procedimento de atendimento ao cliente", "Checklist de fechamento de caixa".
>
> Um não substitui o outro. Eles se COMPLEMENTAM.
>
> Vamos montar esse sistema pro seu agente.

---

### [QUANDO USAR CADA UM] - 1.5 minutos

**[LUCAS DIZ:]**

> Regra simples pra decidir:

**[MOSTRAR NO SLIDE:]**

```
USE RULE QUANDO:
✓ É algo que deve acontecer SEMPRE
✓ Não precisa de gatilho específico
✓ É uma preferência ou padrão constante

Exemplos:
• "Sempre use português"
• "Cor principal é azul"
• "Tom informal"
• "Validar formulários"


USE WORKFLOW QUANDO:
✓ É uma tarefa que você FAZ em momentos específicos
✓ Precisa de um gatilho (você decide quando executar)
✓ É uma sequência de ações

Exemplos:
• Gerar documentação → /doc
• Testar página → /test
• Criar README → /readme
• Pedir revisão → /review
```

**[LUCAS DIZ:]**

> Se for "sempre faça X" → Rule
> Se for "quando eu pedir, faça Y" → Workflow
>
> Simples assim.

---

### [EXEMPLO DE SISTEMA COMPLETO] - 2 minutos

**[LUCAS DIZ:]**

> Deixa eu te mostrar um sistema completo pra um projeto de um empreendedor:

**[MOSTRAR NO SLIDE:]**

```
PROJETO: Site do Meu Negócio

.agent/
├── rules/
│   ├── marca.md           ← Identidade visual sempre
│   ├── linguagem.md       ← Tom de comunicação sempre
│   └── qualidade.md       ← Padrões de qualidade sempre
│
└── workflows/
    ├── doc.md             ← /doc quando precisar
    ├── test.md            ← /test quando terminar algo
    ├── publicar.md        ← /publicar quando for ao ar
    └── melhorar.md        ← /melhorar pra otimizar
```

**[LUCAS DIZ:]**

> **Rules (sempre ativas):**

```markdown
# marca.md
- Nome da empresa: Minha Loja
- Cor principal: #3B82F6 (azul)
- Logo no canto superior esquerdo
- WhatsApp: (11) 99999-9999
```

```markdown
# linguagem.md
- Português do Brasil
- Tom amigável e informal
- Falar "você", não "senhor/senhora"
- Evitar jargões técnicos
```

```markdown
# qualidade.md
- Sempre validar formulários
- Mensagens de erro amigáveis
- Funcionar bem em celular
- Carregar rápido
```

**[LUCAS DIZ:]**

> **Workflows (sob demanda):**
>
> O agente sempre segue as Rules. E quando você digita /test, ele testa. Quando digita /doc, ele documenta.
>
> Tudo integrado.

---

### [MONTANDO SEU KIT INICIAL] - 2.5 minutos

**[LUCAS DIZ:]**

> Agora é sua vez. Vamos montar um kit inicial pro seu projeto.
>
> **Passo 1:** Cria a estrutura de pastas:

```
seu-projeto/
└── .agent/
    ├── rules/
    └── workflows/
```

> **Passo 2:** Cria essas 3 Rules básicas:

**[MOSTRAR NO SLIDE:]**

```markdown
# rules/estilo.md

- Cor principal: [SUA COR PREFERIDA]
- Textos em português do Brasil
- Tom [formal/informal/amigável]
- Fonte preferida: [SUA FONTE]
```

```markdown
# rules/qualidade.md

- Sempre validar campos obrigatórios
- Mensagens de erro em português
- Testar antes de considerar pronto
- Funcionar em celular
```

```markdown
# rules/meu-negocio.md

- Nome: [NOME DO SEU NEGÓCIO]
- Contato: [SEU TELEFONE/EMAIL]
- [OUTRAS INFO RELEVANTES]
```

> **Passo 3:** Cria esses 3 Workflows básicos:

**[MOSTRAR NO SLIDE:]**

```markdown
# workflows/doc.md

Gere documentação simples para este projeto.
Explique o que cada parte faz.
Use linguagem simples.
```

```markdown
# workflows/test.md

Teste a página atual:
1. Abra no browser
2. Clique em todos os botões
3. Preencha todos os formulários
4. Tire screenshot do resultado
5. Liste problemas encontrados
```

```markdown
# workflows/melhorar.md

Analise e melhore a página atual:
- Visual mais atraente
- Textos mais claros
- Usabilidade melhor
Faça as melhorias automaticamente.
```

> **Passo 4:** Testa! Pede algo pro agente e vê se ele segue as Rules. Depois digita /test e vê se o Workflow executa.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Você completou o Módulo 5!
>
> Com Rules + Workflows, você transformou o agente num assistente PERSONALIZADO:
> - Ele sabe suas preferências (Rules)
> - Ele tem procedimentos prontos (Workflows)
> - Você só precisa dar a direção geral
>
> No último módulo, vamos falar de Segurança — garantir que você está protegido enquanto usa todo esse poder.
>
> Te vejo no Módulo 6!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 5](glossario-modulo-05.md)** para definições completas dos termos.

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Sei quando usar Rule vs Workflow
- [ ] Criei pelo menos 2 Rules pro meu projeto
- [ ] Criei pelo menos 2 Workflows pro meu projeto
- [ ] Testei se o agente está seguindo as Rules
- [ ] Testei se os Workflows executam com /comando

---

## KIT INICIAL COMPLETO

### Estrutura
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

### Resumo
| Tipo | Função | Exemplos |
|------|--------|----------|
| **Rules** | Sempre seguir | Cores, tom, padrões |
| **Workflows** | Executar quando pedir | /doc, /test, /melhorar |

---

## PRÓXIMOS PASSOS

**Módulo 6:** Segurança Básica [PLUS]
- Allow/Deny Lists
- Browser Security
- Checklist de proteção

---

*Aula 5.3 - Combinando Rules + Workflows*
*Duração: 10 minutos*
*Professor: Lucas Charao*

---

## 🎉 PARABÉNS!

Você completou o **Módulo 5: Rules e Workflows [PLUS]**.

Agora você sabe:
- Criar Rules (instruções que o agente sempre segue)
- Criar Workflows (prompts que você executa com /comando)
- Combinar os dois num sistema personalizado
- Montar um kit inicial pro seu projeto

**Próximo passo:** Módulo 6 - Segurança Básica [PLUS]
