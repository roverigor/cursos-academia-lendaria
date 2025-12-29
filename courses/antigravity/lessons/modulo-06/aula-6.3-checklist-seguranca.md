# AULA 6.3: Checklist de Segurança

**Módulo:** 6 - Segurança Básica [PLUS]
**Duração:** 10 minutos
**Tipo:** Validação
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Ter um checklist completo de segurança
- Saber validar se seu ambiente está seguro
- Ter confiança pra usar o Antigravity no dia a dia

### ORIGEM (Position)
Você provavelmente:
- Já configurou Deny List e URL Allowlist
- Quer ter certeza que não esqueceu nada
- Busca uma forma de validar tudo rapidamente
- Quer um "selo de aprovação" no seu setup

### ROTA (Steps)
1. Revisar todas as camadas de segurança
2. Passar pelo checklist item por item
3. Validar que tudo está configurado
4. Ter um ritual de verificação

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Última aula do curso! Lucas Charao aqui.
>
> Você aprendeu várias configurações de segurança ao longo dos módulos. Agora vamos juntar TUDO num checklist que você pode usar pra validar qualquer projeto.
>
> Essa é a aula que fecha o ciclo.

---

### [GANCHO EMOCIONAL] - 45 segundos

**[LUCAS DIZ:]**

> Sabe aquela sensação de "será que eu esqueci de trancar a porta?"
>
> (pausa)
>
> Com segurança digital é igual. Você configura várias coisas, mas fica com aquela dúvida: "Será que tá tudo certo?"
>
> Checklists existem exatamente pra isso. Pilotos usam antes de decolar. Médicos usam antes de cirurgias. Não porque são incompetentes — porque são profissionais.
>
> Vamos criar seu checklist de segurança pro Antigravity.

---

### [AS TRÊS CAMADAS DE SEGURANÇA] - 1.5 minutos

**[LUCAS DIZ:]**

> Primeiro, vamos revisar as três camadas que você aprendeu:

**[MOSTRAR NO SLIDE:]**

```
CAMADA 1: CONTROLE DE EXECUÇÃO
(Módulo 2)
─────────────────────────────────
• Terminal Policy configurada
• Deny List de comandos
• Review Policy definida

CAMADA 2: PROTEÇÃO DE ARQUIVOS
(Módulo 6 - Aula 6.1)
─────────────────────────────────
• Deny List de arquivos
• Credenciais bloqueadas
• Dados sensíveis protegidos

CAMADA 3: CONTROLE DE NAVEGAÇÃO
(Módulo 6 - Aula 6.2)
─────────────────────────────────
• URL Allowlist configurada
• Só sites necessários liberados
• Navegação controlada
```

**[LUCAS DIZ:]**

> Cada camada protege uma área diferente. Juntas, elas formam um sistema de segurança completo.
>
> Agora vamos ao checklist.

---

### [CHECKLIST COMPLETO] - 4 minutos

**[LUCAS DIZ:]**

> Esse é o checklist completo. Vou passar item por item:

**[MOSTRAR NO SLIDE:]**

```
╔═══════════════════════════════════════════════════════╗
║           CHECKLIST DE SEGURANÇA - ANTIGRAVITY        ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║  ANTES DE COMEÇAR UM PROJETO NOVO:                    ║
║                                                       ║
║  □ 1. TERMINAL POLICY                                 ║
║     └─ Configurei: AUTO ou TURBO conforme meu nível   ║
║                                                       ║
║  □ 2. DENY LIST DE COMANDOS                           ║
║     └─ Bloqueei: rm -rf, format, drop database        ║
║                                                       ║
║  □ 3. REVIEW POLICY                                   ║
║     └─ Configurei: Agent Decides ou Request Review    ║
║                                                       ║
║  □ 4. DENY LIST DE ARQUIVOS                           ║
║     └─ Bloqueei: .env, secrets/, dados-clientes/      ║
║                                                       ║
║  □ 5. URL ALLOWLIST                                   ║
║     └─ Liberei: localhost + meu domínio               ║
║                                                       ║
║  □ 6. BACKUP                                          ║
║     └─ Tenho backup do projeto (Git ou cópia)         ║
║                                                       ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║  ANTES DE PEDIR ALGO IMPORTANTE:                      ║
║                                                       ║
║  □ 7. PLANNING MODE                                   ║
║     └─ Ativei pra tarefas complexas/arriscadas        ║
║                                                       ║
║  □ 8. REVISÃO DE PLANO                                ║
║     └─ Li o plano antes de aprovar                    ║
║                                                       ║
║  □ 9. CODE DIFF                                       ║
║     └─ Vou revisar as mudanças antes de aceitar       ║
║                                                       ║
╠═══════════════════════════════════════════════════════╣
║                                                       ║
║  PERIODICAMENTE:                                      ║
║                                                       ║
║  □ 10. REVISAR DENY LISTS                             ║
║      └─ Ainda faz sentido? Precisa adicionar algo?    ║
║                                                       ║
║  □ 11. ATUALIZAR ANTIGRAVITY                          ║
║      └─ Estou na versão mais recente?                 ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝
```

**[LUCAS DIZ:]**

> Vamos revisar os mais importantes:
>
> **Items 1-5:** São configurações que você faz UMA VEZ e elas continuam valendo.
>
> **Item 6 - Backup:** Esse é CRÍTICO. Sempre tenha uma forma de voltar atrás. Git é perfeito pra isso.
>
> **Items 7-9:** São práticas pra CADA tarefa importante. Não precisa fazer pra coisas pequenas, mas pra mudanças grandes, sempre.
>
> **Items 10-11:** Revisão periódica. Uma vez por mês tá bom.

---

### [RITUAL DE 30 SEGUNDOS] - 1 minuto

**[LUCAS DIZ:]**

> Não precisa passar pelo checklist completo todo dia. Faz assim:
>
> **Projeto novo?** Checklist completo (items 1-6)
>
> **Dia normal?** Só os items 7-9 quando for fazer algo importante
>
> **Uma vez por mês?** Items 10-11

**[MOSTRAR NO SLIDE:]**

```
RITUAL RÁPIDO (30 segundos):

Antes de uma tarefa importante:
1. "Isso é complexo?" → Se sim, Planning Mode
2. "Vou ler o plano antes de aprovar"
3. "Vou olhar o Code Diff antes de aceitar"

Pronto. 30 segundos de ritual = muito menos dor de cabeça.
```

**[LUCAS DIZ:]**

> Esse ritual de 30 segundos vai te salvar de 99% dos problemas.

---

### [EXPANSÃO FILOSÓFICA] - 1 minuto

**[LUCAS DIZ:]**

> Você completou o curso Google Antigravity Essencial!
>
> (pausa)
>
> Vamos recapitular a jornada:
>
> **Módulo 1:** Você conheceu os três ambientes — a base de tudo
>
> **Módulo 2:** Você aprendeu a controlar o agente — dar liberdade com limites
>
> **Módulo 3:** Você dominou os Artifacts — entender o que o agente fez
>
> **Módulo 4:** Você ficou rápido — atalhos e menções
>
> **Módulo 5:** Você personalizou — Rules e Workflows pro seu contexto
>
> **Módulo 6:** Você se protegeu — segurança em camadas
>
> Agora você tem TUDO que precisa pra usar o Antigravity com confiança.
>
> O agente é seu assistente. Você é o profissional que dirige.
>
> Vai lá e cria coisas incríveis!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 6](glossario-modulo-06.md)** para definições completas dos termos:
- Checklist
- Camadas de segurança
- Backup
- Ritual de verificação

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi as três camadas de segurança
- [ ] Passei pelo checklist completo pelo menos uma vez
- [ ] Sei quando usar o checklist completo vs ritual rápido
- [ ] Tenho backup do meu projeto
- [ ] Me sinto confiante pra usar o Antigravity

---

## CHECKLIST IMPRIMÍVEL

```
╔═══════════════════════════════════════════════╗
║     MEU CHECKLIST DE SEGURANÇA - ANTIGRAVITY  ║
╠═══════════════════════════════════════════════╣
║                                               ║
║  PROJETO NOVO:                                ║
║  □ Terminal Policy                            ║
║  □ Deny List de comandos                      ║
║  □ Review Policy                              ║
║  □ Deny List de arquivos                      ║
║  □ URL Allowlist                              ║
║  □ Backup configurado                         ║
║                                               ║
║  TAREFA IMPORTANTE:                           ║
║  □ Planning Mode (se complexo)                ║
║  □ Ler plano antes de aprovar                 ║
║  □ Ver Code Diff antes de aceitar             ║
║                                               ║
║  MENSAL:                                      ║
║  □ Revisar Deny Lists                         ║
║  □ Atualizar Antigravity                      ║
║                                               ║
╚═══════════════════════════════════════════════╝
```

---

## 🎉 PARABÉNS!

Você completou o **Curso Google Antigravity Essencial**.

Agora você sabe:
- Navegar pelos três ambientes
- Controlar o agente com políticas
- Entender e dar feedback em Artifacts
- Usar atalhos pra ser mais produtivo
- Personalizar com Rules e Workflows
- Se proteger com configurações de segurança

**Próximo passo:** Vai lá e cria algo incrível!

---

*Aula 6.3 - Checklist de Segurança*
*Duração: 10 minutos*
*Professor: Lucas Charao*

---

## RECAPITULAÇÃO DO CURSO

| Módulo | Tema | O que você aprendeu |
|--------|------|---------------------|
| 1 | Os Três Ambientes | Agent Manager, Editor, Browser |
| 2 | Controlando o Agente | Modos, Políticas, Configurações |
| 3 | Sistema de Artifacts | 6 tipos, feedback, interpretação |
| 4 | Atalhos e Produtividade | Teclado, @menções, /comandos |
| 5 | Rules e Workflows | Personalização persistente |
| 6 | Segurança Básica | Deny List, Allowlist, Checklist |

**Total:** 21 aulas, aproximadamente 3 horas de conteúdo

---

*Fim do Curso Google Antigravity Essencial*
*Professor: Lucas Charao*
*Criado por: Course Architect Agent*
