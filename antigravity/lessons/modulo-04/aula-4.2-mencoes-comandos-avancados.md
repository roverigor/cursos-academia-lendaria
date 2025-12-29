# AULA 4.2: Menções e Comandos Avançados

**Módulo:** 4 - Atalhos e Produtividade
**Duração:** 7 minutos
**Tipo:** Referência
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Saber usar @menções pra dar contexto preciso
- Conhecer os comandos com / (workflows)
- Ter uma referência rápida pra consultar

### ORIGEM (Position)
Você provavelmente:
- Já sabe os atalhos básicos (aula anterior)
- Quer dar instruções mais precisas pro agente
- Às vezes o agente não entende exatamente o que você quer
- Quer descobrir recursos "escondidos" da ferramenta

### ROTA (Steps)
1. Aprender a usar @ pra mencionar arquivos e contextos
2. Conhecer os comandos com / (barra)
3. Ver exemplos práticos de uso
4. Ter um cartão de referência pra guardar

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Última aula do Módulo 4! Lucas Charao aqui.
>
> Você já sabe os atalhos de navegação. Agora vamos aprender a dar CONTEXTO pro agente de forma precisa.
>
> Isso muda completamente a qualidade das respostas.

---

### [GANCHO EMOCIONAL] - 45 segundos

**[LUCAS DIZ:]**

> Te pergunto: você já tentou explicar algo pra alguém e a pessoa não entendeu porque faltou contexto?
>
> Tipo: "Arruma aquele negócio lá." E a pessoa: "Que negócio? Onde?"
>
> (pausa)
>
> Com o agente acontece igual. Se você diz "corrige o erro", ele pode não saber QUAL erro, em QUAL arquivo.
>
> Mas se você diz "corrige o erro em @arquivo.html que aparece em @terminal"... aí ele sabe EXATAMENTE do que você tá falando.
>
> As @menções são a forma de dar esse contexto preciso.

---

### [MENÇÕES COM @] - 2 minutos

**[LUCAS DIZ:]**

> No Agent Panel ou Agent Manager, você pode usar @ pra mencionar coisas específicas:

**[MOSTRAR NO SLIDE:]**

```
MENÇÕES COM @

@arquivo.html     → Inclui o arquivo específico no contexto
@pasta/           → Inclui todos os arquivos da pasta
@terminal         → Inclui a saída do terminal (erros, logs)
@problems         → Inclui os erros que o editor detectou
```

**[LUCAS DIZ:]**

> Exemplos práticos de como usar:

**[MOSTRAR NO SLIDE:]**

```
EXEMPLOS:

"Corrige os erros em @index.html"
→ Agente sabe exatamente qual arquivo

"Analisa todos os arquivos em @src/"
→ Agente vê a pasta inteira

"O erro que aparece em @terminal, corrige"
→ Agente vê o erro exato

"Resolve os problemas de @problems"
→ Agente vê os erros do editor
```

**[LUCAS DIZ:]**

> A mágica é que o agente RECEBE o conteúdo desses arquivos. Ele não precisa ir procurar. Você entrega de bandeja.
>
> Resultado: respostas mais precisas, menos mal-entendidos.

---

### [COMANDOS COM /] - 1.5 minutos

**[LUCAS DIZ:]**

> Além das @menções, existem os comandos com / (barra).
>
> Esses são atalhos pra ações comuns que você pode configurar (vamos ver mais no Módulo 5).

**[MOSTRAR NO SLIDE:]**

```
COMANDOS COM /

/nome-do-workflow  → Executa um workflow que você criou

Exemplos comuns:
/test             → Roda os testes
/doc              → Gera documentação
/review           → Pede revisão do código
```

**[LUCAS DIZ:]**

> Por enquanto, só saiba que eles existem. No Módulo 5 você vai aprender a criar seus próprios workflows e disparar com /.
>
> É tipo criar atalhos personalizados pra tarefas que você faz sempre.

---

### [COMBINANDO TUDO] - 1 minuto

**[LUCAS DIZ:]**

> O poder real aparece quando você combina atalhos + menções:

**[MOSTRAR NO SLIDE:]**

```
FLUXO PRODUTIVO:

1. Cmd + E → vai pro Editor
2. Clica no arquivo que quer ajustar
3. Cmd + L → abre Agent Panel
4. Escreve: "Adiciona validação de email em @formulario.html
   seguindo o padrão de @utils.js"
5. Agente entende EXATAMENTE o contexto

Resultado: resposta precisa, sem adivinhação
```

**[LUCAS DIZ:]**

> Percebe? Atalho pra navegar + menção pra dar contexto = produtividade máxima.

---

### [CARTÃO DE REFERÊNCIA COMPLETO] - 1 minuto

**[LUCAS DIZ:]**

> Vou te dar um cartão de referência completo. Salva isso:

**[MOSTRAR NO SLIDE:]**

```
┌─────────────────────────────────────────┐
│  REFERÊNCIA RÁPIDA - ANTIGRAVITY        │
├─────────────────────────────────────────┤
│  NAVEGAÇÃO                              │
│  Cmd + E     Editor ↔ Agent Manager     │
│  Cmd + L     Toggle Agent Panel         │
│  Ctrl + `    Toggle Terminal            │
├─────────────────────────────────────────┤
│  EDIÇÃO                                 │
│  Tab         Aceitar sugestão           │
│  Cmd + I     Comando inline             │
├─────────────────────────────────────────┤
│  CONTEXTO                               │
│  @arquivo    Menciona arquivo           │
│  @pasta/     Menciona pasta             │
│  @terminal   Menciona output            │
│  @problems   Menciona erros             │
├─────────────────────────────────────────┤
│  WORKFLOWS                              │
│  /comando    Executa workflow salvo     │
└─────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> Imprime isso. Cola do lado do monitor. Em uma semana você decora.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Você completou o Módulo 4!
>
> Com atalhos e menções, você vai:
> - Navegar mais rápido
> - Dar contexto mais preciso
> - Ter respostas melhores do agente
> - Parecer um profissional experiente
>
> Nos próximos módulos, vamos personalizar o agente com Rules e Workflows, e depois garantir segurança.
>
> Te vejo no Módulo 5!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 4](glossario-modulo-04.md)** para definições completas dos termos:
- Menção (@)
- Contexto
- Workflow
- Comando (/)

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Sei usar @arquivo pra mencionar arquivos específicos
- [ ] Sei usar @terminal pra mostrar erros pro agente
- [ ] Entendi que / executa workflows
- [ ] Salvei o cartão de referência
- [ ] Pratiquei combinar atalhos + menções

---

## RESUMO DO MÓDULO 4

### Atalhos de Navegação
| Atalho | Função |
|--------|--------|
| Cmd + E | Alternar ambientes |
| Cmd + L | Agent Panel |
| Cmd + I | Comando inline |
| Tab | Aceitar sugestão |
| Ctrl + ` | Terminal |

### Menções de Contexto
| Menção | O que inclui |
|--------|--------------|
| @arquivo | Arquivo específico |
| @pasta/ | Pasta inteira |
| @terminal | Saída do terminal |
| @problems | Erros do editor |

---

## PRÓXIMOS PASSOS

**Módulo 5:** Rules e Workflows [PLUS]
- Rules: instruções que o agente sempre segue
- Workflows: prompts reutilizáveis com /comando
- Personalização avançada

---

*Aula 4.2 - Menções e Comandos Avançados*
*Duração: 7 minutos*
*Professor: Lucas Charao*

---

## 🎉 PARABÉNS!

Você completou o **Módulo 4: Atalhos e Produtividade**.

Agora você sabe:
- Os 5 atalhos essenciais
- Como usar @menções pra contexto preciso
- Como comandos / funcionam
- Como combinar tudo pra máxima produtividade

**Próximo passo:** Módulo 5 - Rules e Workflows [PLUS]
