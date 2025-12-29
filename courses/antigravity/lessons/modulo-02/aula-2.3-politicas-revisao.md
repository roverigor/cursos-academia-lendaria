# AULA 2.3: Políticas de Revisão

**Módulo:** 2 - Controlando o Agente
**Duração:** 6 minutos
**Tipo:** Configuração
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Políticas de Revisão
- Conhecer as 3 opções: Always Proceed, Agent Decides, Request Review
- Saber configurar o nível certo de "paradas pra aprovação"

### ORIGEM (Position)
Você provavelmente:
- Já configurou a Política de Execução (aula anterior)
- Quer entender quando o agente deve PARAR e te mostrar o progresso
- Às vezes quer mais checkpoints, às vezes quer que ele vá direto
- Busca o equilíbrio entre controle e produtividade

### ROTA (Steps)
1. Entender o que é Política de Revisão
2. Conhecer as 3 opções disponíveis
3. Saber quando usar cada uma
4. Configurar a política recomendada

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Lucas Charao de volta!
>
> A gente já viu Planning Mode vs Fast Mode, e Políticas de Execução. Agora o último controle importante: Políticas de Revisão.
>
> Isso define QUANDO o agente para pra te mostrar o que tá fazendo.

---

### [GANCHO EMOCIONAL] - 45 segundos

**[LUCAS DIZ:]**

> Imagina que você pediu pra alguém montar uma apresentação de 20 slides.
>
> Opção A: a pessoa faz TUDO e te mostra só no final. Rápido, mas se tiver errado, refaz tudo.
>
> Opção B: a pessoa faz 5 slides, te mostra, você aprova, ela faz mais 5, te mostra... Mais demorado, mas você corrige no caminho.
>
> Opção C: a pessoa DECIDE quando te mostrar. "Isso aqui é rotina, vou direto. Isso aqui é importante, vou te perguntar."
>
> Qual é melhor? Depende da situação.
>
> A Política de Revisão é exatamente isso.

---

### [AS TRÊS POLÍTICAS] - 1.5 minutos

**[LUCAS DIZ:]**

> Existem 3 configurações:

**[MOSTRAR TABELA NO SLIDE:]**

```
┌─────────────────────────────────────────────────────────┐
│  POLÍTICA          │  O QUE ACONTECE                    │
├─────────────────────────────────────────────────────────┤
│  ALWAYS PROCEED    │  Nunca para pra pedir revisão.     │
│  (Sempre Continua) │  Faz tudo de uma vez.              │
│                    │  → Máxima velocidade               │
│                    │  → Use em protótipos rápidos       │
├─────────────────────────────────────────────────────────┤
│  AGENT DECIDES     │  O agente DECIDE quando parar.     │
│  (Agente Decide)   │  Coisas simples: continua.         │
│                    │  Coisas importantes: para.         │
│                    │  → Equilíbrio (RECOMENDADO)        │
├─────────────────────────────────────────────────────────┤
│  REQUEST REVIEW    │  Sempre para e pede aprovação.     │
│  (Pedir Revisão)   │  A cada etapa importante.          │
│                    │  → Máximo controle                 │
│                    │  → Use em projetos críticos        │
└─────────────────────────────────────────────────────────┘
```

**[LUCAS DIZ:]**

> **ALWAYS PROCEED** = "Vai fazendo, me mostra quando terminar." Use quando você tá experimentando e não se importa se der errado.
>
> **AGENT DECIDES** = "Usa seu bom senso de quando me mostrar." É o melhor pra maioria das situações.
>
> **REQUEST REVIEW** = "Para sempre que tiver algo importante pra eu ver." Use em projetos que você vai entregar pra clientes ou projetos críticos do seu negócio.

---

### [COMBINAÇÃO RECOMENDADA] - 1 minuto

**[LUCAS DIZ:]**

> Agora, vamos juntar tudo que você aprendeu no módulo.
>
> A combinação que eu recomendo pra maioria das pessoas:

**[MOSTRAR NO SLIDE:]**

```
CONFIGURAÇÃO RECOMENDADA:
┌─────────────────────────────────┐
│  Terminal Policy:  AUTO         │
│  Review Policy:    AGENT DECIDES│
│  Deny List:        Configurada  │
│  Modo padrão:      PLANNING     │
└─────────────────────────────────┘
```

**[LUCAS DIZ:]**

> Com essa configuração:
> - O agente executa comandos seguros sozinho
> - Comandos arriscados ele te pergunta
> - Ele decide quando parar pra revisão
> - Você usa Planning Mode pra coisas novas
>
> É o equilíbrio perfeito entre controle e produtividade.

---

### [APLICAÇÃO PRÁTICA] - 1.5 minutos

**[LUCAS DIZ:]**

> Vamos configurar. Exercício rápido.
>
> **Passo 1:** Vai em Settings (Configurações).
>
> **Passo 2:** Procura "Review Policy" ou "Política de Revisão".
>
> **Passo 3:** Seleciona **Agent Decides**.
>
> **Passo 4:** Salva.
>
> (pausa de 3 segundos)
>
> Pronto! Agora o agente vai usar bom senso pra decidir quando te mostrar o progresso.
>
> Se você quiser testar, pede algo um pouco mais complexo — tipo "Cria uma página com header, formulário e footer" — e observa se ele para em algum momento pra te mostrar o plano antes de continuar.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> O que você configurou nessas últimas aulas é essencial.
>
> Você definiu:
> - COMO o agente trabalha (Planning vs Fast Mode)
> - O QUE ele pode fazer sozinho (Política de Execução)
> - QUANDO ele para pra te mostrar (Política de Revisão)
>
> Isso é CONTROLE. Você é o diretor. O agente é o time que trabalha dentro das regras que VOCÊ definiu.
>
> Na próxima aula, vamos consolidar tudo num exercício prático.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 2](glossario-modulo-02.md)** para definições completas dos termos:
- Política de Revisão
- Always Proceed
- Agent Decides
- Request Review

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Política de Revisão controla quando o agente para pra mostrar progresso
- [ ] Conheço as 3 opções: Always Proceed, Agent Decides, Request Review
- [ ] Sei que Agent Decides é recomendado pra maioria
- [ ] Configurei a Política de Revisão como Agent Decides
- [ ] Entendi a combinação recomendada (AUTO + AGENT DECIDES)

---

## RESUMO DAS CONFIGURAÇÕES

| Configuração | Recomendado | Quando mudar |
|--------------|-------------|--------------|
| Terminal Policy | AUTO | OFF se dados muito sensíveis |
| Review Policy | AGENT DECIDES | REQUEST REVIEW se projeto crítico |
| Deny List | Configurada | Sempre manter |
| Modo padrão | PLANNING | FAST para ajustes rápidos |

---

*Aula 2.3 - Políticas de Revisão*
*Duração: 6 minutos*
*Professor: Lucas Charao*
