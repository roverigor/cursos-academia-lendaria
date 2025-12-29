# AULA 2.4: Prática - Configurando Seu Perfil

**Módulo:** 2 - Controlando o Agente
**Duração:** 8 minutos
**Tipo:** Hands-on
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Ter todas as configurações salvas e testadas
- Validar que tudo funciona como esperado
- Ter seu "perfil de trabalho" pronto pra usar

### ORIGEM (Position)
Você provavelmente:
- Aprendeu sobre os modos e políticas nas aulas anteriores
- Talvez tenha configurado algumas coisas, talvez não
- Quer ter certeza de que está tudo certo
- Quer testar na prática se as configurações funcionam

### ROTA (Steps)
1. Revisar e confirmar todas as configurações
2. Testar Planning Mode vs Fast Mode
3. Testar a Deny List (bloqueio de comandos)
4. Validar com checklist final

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Última aula do Módulo 2! Lucas Charao aqui.
>
> Hoje é dia de colocar a mão na massa. Vamos configurar tudo de uma vez e TESTAR pra garantir que funciona.
>
> Pega o Antigravity e vem comigo.

---

### [CONFIGURAÇÃO COMPLETA] - 2 minutos

**[LUCAS DIZ:]**

> Vamos passar por cada configuração. Abre o Antigravity e vai em Settings (Configurações).
>
> **1. TERMINAL POLICY (Política de Execução)**
>
> Procura essa opção e configura como **AUTO**.
>
> (pausa de 3 segundos)
>
> **2. DENY LIST (Lista de Bloqueio)**
>
> Procura a seção de comandos bloqueados e adiciona:
> - rm -rf
> - sudo
> - chmod 777
>
> (pausa de 5 segundos)
>
> **3. REVIEW POLICY (Política de Revisão)**
>
> Procura e configura como **AGENT DECIDES**.
>
> (pausa de 3 segundos)
>
> **4. SALVA TUDO**
>
> Clica em Save ou Apply.
>
> Pronto? Todas as configurações básicas estão feitas.

**[MOSTRAR NO SLIDE:]**

```
SEU PERFIL CONFIGURADO:
┌─────────────────────────────────┐
│  ✓ Terminal Policy:  AUTO       │
│  ✓ Deny List:        Configurada│
│  ✓ Review Policy:    AGENT DECIDES│
└─────────────────────────────────┘
```

---

### [TESTE 1: PLANNING MODE] - 1.5 minutos

**[LUCAS DIZ:]**

> Agora vamos testar. Primeiro, o Planning Mode.
>
> Vai pro Agent Manager e digita:
>
> "Use planning mode e crie uma página de orçamentos com campos para nome do cliente, serviço e valor"
>
> (pausa enquanto digitam)
>
> Aperta Enter e OBSERVA.
>
> O que você deve ver:
> - O agente cria um PLANO (Task List)
> - Ele mostra o que pretende fazer ANTES de fazer
> - Você pode comentar ou aprovar
>
> (pausa de 5 segundos)
>
> Funcionou? Você viu o plano antes da execução?
>
> Se sim, ✅ Planning Mode funcionando.
>
> Se não apareceu plano e ele foi direto executar, verifique se você escreveu "use planning mode" no início do pedido.

---

### [TESTE 2: FAST MODE] - 1 minuto

**[LUCAS DIZ:]**

> Agora vamos testar o Fast Mode.
>
> Digita:
>
> "No fast mode, adiciona a data de hoje no topo da página"
>
> (pausa)
>
> O que você deve ver:
> - O agente executa DIRETO
> - Sem mostrar plano
> - Resultado aparece imediatamente
>
> (pausa de 3 segundos)
>
> Funcionou? Ele foi direto sem mostrar plano?
>
> Se sim, ✅ Fast Mode funcionando.

---

### [TESTE 3: DENY LIST] - 1.5 minutos

**[LUCAS DIZ:]**

> Agora o teste mais importante: a Deny List.
>
> Vamos testar se os comandos perigosos estão realmente bloqueados.
>
> Digita:
>
> "Delete todos os arquivos do projeto"
>
> (pausa)
>
> O que DEVE acontecer:
> - O agente deve PARAR
> - Ele deve te avisar que não pode executar isso
> - Ou pedir confirmação especial
>
> O que NÃO deve acontecer:
> - Ele simplesmente deletar tudo sem perguntar
>
> (pausa de 3 segundos)
>
> Se ele parou ou pediu confirmação, ✅ Deny List funcionando!
>
> Se ele deletou alguma coisa sem perguntar... respira fundo, Ctrl+Z pode ajudar, e revisa suas configurações de Deny List.

---

### [CHECKLIST DE VALIDAÇÃO] - 1.5 minutos

**[LUCAS DIZ:]**

> Última parte. Vamos passar pelo checklist final pra garantir que você tá pronto.
>
> Responde mentalmente — ou marca num papel:

**[MOSTRAR NO SLIDE:]**

```
CHECKLIST DE VALIDAÇÃO - MÓDULO 2

CONFIGURAÇÕES:
[ ] Terminal Policy está em AUTO
[ ] Deny List tem rm -rf, sudo, chmod 777
[ ] Review Policy está em AGENT DECIDES

TESTES:
[ ] Planning Mode mostrou plano antes de executar
[ ] Fast Mode executou direto sem plano
[ ] Deny List bloqueou comando perigoso

ENTENDIMENTO:
[ ] Sei quando usar Planning vs Fast Mode
[ ] Entendo a diferença entre OFF, AUTO e TURBO
[ ] Sei que posso ajustar as políticas conforme o projeto
```

**[LUCAS DIZ:]**

> Se você marcou tudo, PARABÉNS! Você configurou seu perfil de trabalho no Antigravity.
>
> Se faltou alguma coisa, volta nas aulas anteriores ou revisa as configurações.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Você completou o Módulo 2.
>
> Agora você não só sabe USAR o Antigravity — você sabe CONTROLAR ele.
>
> Você definiu as regras do jogo. O agente trabalha dentro dessas regras.
>
> Nos próximos módulos, vamos aprofundar em Artifacts, Atalhos, e coisas mais avançadas como Rules e Workflows.
>
> Mas a base de controle tá sólida. Você é o diretor.
>
> Te vejo no Módulo 3!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 2](glossario-modulo-02.md)** para revisão de todos os termos aprendidos neste módulo.

---

## CHECKLIST FINAL DO MÓDULO 2

### Configurações
- [ ] Terminal Policy: AUTO
- [ ] Deny List: rm -rf, sudo, chmod 777
- [ ] Review Policy: AGENT DECIDES

### Testes Realizados
- [ ] Planning Mode testado (mostrou plano)
- [ ] Fast Mode testado (executou direto)
- [ ] Deny List testada (bloqueou comando perigoso)

### Conceitos Entendidos
- [ ] Planning Mode vs Fast Mode
- [ ] Políticas de Execução (OFF / AUTO / TURBO)
- [ ] Políticas de Revisão (Always Proceed / Agent Decides / Request Review)
- [ ] Deny List (comandos bloqueados)

---

## RESUMO DO MÓDULO 2

| Controle | O que faz | Sua configuração |
|----------|-----------|------------------|
| **Modo de trabalho** | Planning vs Fast | Use Planning pra coisas novas |
| **Terminal Policy** | O que executa sozinho | AUTO |
| **Deny List** | Comandos bloqueados | rm -rf, sudo, chmod 777 |
| **Review Policy** | Quando para pra mostrar | AGENT DECIDES |

---

## PRÓXIMOS PASSOS

**Módulo 3:** Sistema de Artifacts
- O que são Artifacts
- Como dar feedback em Artifacts
- Code Diff e Walkthroughs
- Screenshots e Browser Recordings

---

*Aula 2.4 - Prática: Configurando Seu Perfil*
*Duração: 8 minutos*
*Professor: Lucas Charao*

---

## 🎉 PARABÉNS!

Você completou o **Módulo 2: Controlando o Agente**.

Agora você sabe:
- A diferença entre Planning Mode e Fast Mode
- Como configurar Políticas de Execução
- Como configurar Políticas de Revisão
- Como proteger seu sistema com Deny List
- Como validar que tudo está funcionando

**Próximo passo:** Módulo 3 - Sistema de Artifacts
