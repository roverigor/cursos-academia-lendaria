# Workflow de Distribuição: Transcrições para Equipe

**Como enviar resumos e tarefas para os canais certos.**

---

## 📊 Visão Geral do Workflow

```
REUNIÃO TERMINA
      ↓
FATHOM GERA TRANSCRIÇÃO (2-5 min)
      ↓
VOCÊ COPIA TRANSCRIÇÃO
      ↓
PROCESSA COM LLM (ChatGPT/Claude)
      ↓
┌─────────────────────────────────────────────┐
│           DISTRIBUIÇÃO                       │
├─────────────────────────────────────────────┤
│                                             │
│  📧 EMAIL        → Resumo formal            │
│  💬 WHATSAPP     → Tarefas urgentes         │
│  🔔 SLACK        → Notificação do time      │
│  📝 OBSIDIAN     → Base de conhecimento     │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 📧 1. Email para Participantes

### Quando Usar
- Reuniões com clientes externos
- Reuniões formais que precisam de registro
- Quando precisa de confirmação por escrito

### Prompt para Gerar Email

```
Crie um email de follow-up para os participantes desta reunião.

Estrutura:
- Assunto: claro e específico
- Saudação breve
- Resumo em 3-5 bullets
- Tabela de tarefas com responsáveis
- Próximos passos
- Despedida profissional

Tom: [profissional/informal] (escolha um)

TRANSCRIÇÃO:
[COLE AQUI]
```

### Template de Email Pronto

```
Assunto: Resumo Reunião [TEMA] - [DATA]

Olá a todos,

Segue o resumo da nossa reunião de hoje:

**Principais Pontos:**
• [Ponto 1]
• [Ponto 2]
• [Ponto 3]

**Tarefas Definidas:**
| Tarefa | Responsável | Prazo |
|--------|-------------|-------|
| [X]    | @Nome       | DD/MM |

**Próximos Passos:**
- [Ação]

Qualquer dúvida, estou à disposição.

Abraços,
[Seu nome]
```

### Como Enviar
1. Gere o resumo com o prompt
2. Copie o resultado
3. Cole no seu cliente de email
4. Adicione os participantes (CC para todos)
5. Revise e envie

---

## 💬 2. WhatsApp - Tarefas Urgentes

### Quando Usar
- Tarefas que precisam de ação imediata
- Lembretes rápidos para o time
- Confirmação de compromissos urgentes

### Prompt para WhatsApp

```
Extraia as tarefas URGENTES desta reunião e formate para WhatsApp.

Formato:
- Use emojis para facilitar leitura
- Seja direto (máximo 5 linhas por tarefa)
- Mencione @responsável
- Destaque prazos

Exemplo de formato:
🔴 URGENTE: [tarefa]
👤 Responsável: [nome]
📅 Prazo: [data]

TRANSCRIÇÃO:
[COLE AQUI]
```

### Template WhatsApp - Tarefas

```
📋 *TAREFAS DA REUNIÃO*
📅 [Data]

🔴 *URGENTE*
• [Tarefa 1] → @Nome (até [prazo])

🟡 *IMPORTANTE*
• [Tarefa 2] → @Nome (até [prazo])
• [Tarefa 3] → @Nome (até [prazo])

🟢 *QUANDO POSSÍVEL*
• [Tarefa 4] → @Nome

⏰ Próxima reunião: [data/hora]

Dúvidas? Responde aqui! 👇
```

### Template WhatsApp - Resumo Rápido

```
📝 *RESUMO REUNIÃO*
🗓 [Data] | ⏱ [Duração]

✅ *Decisões:*
1. [Decisão 1]
2. [Decisão 2]

📌 *Pendências:*
• [Pendência 1]
• [Pendência 2]

👉 *Próximo passo:* [ação principal]
```

### Como Enviar
1. Gere as tarefas com o prompt
2. Copie o resultado formatado
3. Cole no grupo do WhatsApp
4. Fixe a mensagem se for importante

---

## 🔔 3. Slack - Notificação do Time

### Quando Usar
- Times que usam Slack como hub principal
- Notificar canais específicos
- Manter histórico pesquisável

### Prompt para Slack

```
Formate o resumo desta reunião para postar no Slack.

Use formatação Slack:
- *negrito* para títulos
- • para bullets
- `código` para nomes técnicos
- :emoji: para visual

Estrutura:
1. Header com contexto
2. Principais pontos (máx 5)
3. Action items com @mentions
4. Link para documento completo (placeholder)

TRANSCRIÇÃO:
[COLE AQUI]
```

### Template Slack - Canal de Projeto

```
:memo: *Resumo: Reunião [Tema]*
:calendar: [Data] | :busts_in_silhouette: Participantes: [nomes]

---

:dart: *Decisões*
• [Decisão 1]
• [Decisão 2]

:white_check_mark: *Action Items*
• [Tarefa 1] → @usuario (prazo: [data])
• [Tarefa 2] → @usuario (prazo: [data])

:warning: *Pontos de Atenção*
• [Risco ou pendência]

:link: Transcrição completa: [link Fathom ou doc]

---
:speech_balloon: Thread para dúvidas :point_down:
```

### Template Slack - Update Rápido

```
:zap: *Update Rápido* - Reunião [Tema]

TL;DR: [Uma frase resumindo]

:point_right: Próximo passo: [ação] (responsável: @usuario)
```

### Como Enviar
1. Gere o resumo formatado
2. Copie para o Slack
3. Poste no canal apropriado
4. Adicione reações para feedback
5. Use thread para discussão

---

## 📝 4. Obsidian - Base de Conhecimento

### Quando Usar
- TODA reunião relevante (crie o hábito)
- Construir memória institucional
- Referência futura pesquisável

### Estrutura de Pastas no Obsidian

```
📁 Reuniões/
├── 📁 2025/
│   ├── 📁 01-Janeiro/
│   │   ├── 2025-01-15-kickoff-projeto-x.md
│   │   ├── 2025-01-18-1on1-joao.md
│   │   └── 2025-01-22-review-sprint.md
│   └── 📁 02-Fevereiro/
├── 📁 Por-Projeto/
│   ├── 📁 Projeto-X/
│   └── 📁 Projeto-Y/
└── 📁 Por-Pessoa/
    ├── 📁 Cliente-ABC/
    └── 📁 1on1-Time/
```

### Prompt para Obsidian

```
Transforme esta transcrição em uma nota de Obsidian.

Formato:
1. YAML frontmatter com metadata
2. Resumo executivo
3. Pontos principais com headers
4. Tarefas como checkboxes
5. Links relacionados (placeholders [[]])
6. Tags relevantes

Use formatação Markdown completa.

TRANSCRIÇÃO:
[COLE AQUI]
```

### Template Obsidian Completo

```markdown
---
tipo: reunião
data: 2025-01-15
participantes:
  - Nome 1
  - Nome 2
projeto: "[[Projeto X]]"
tags:
  - reunião
  - projeto-x
  - decisões
status: processado
---

# Reunião: [Tema]

## Metadata
- **Data:** 2025-01-15
- **Duração:** 45 min
- **Participantes:** [[Nome 1]], [[Nome 2]]
- **Projeto:** [[Projeto X]]

---

## TL;DR
> [Uma frase resumindo a reunião]

---

## Decisões Tomadas
1. **[Decisão 1]**
   - Contexto: [por que foi decidido]
   - Impacto: [o que muda]

2. **[Decisão 2]**
   - Contexto: [...]

---

## Action Items
- [ ] [Tarefa 1] #responsavel/nome #prazo/2025-01-20
- [ ] [Tarefa 2] #responsavel/nome #prazo/2025-01-22
- [ ] [Tarefa 3] #responsavel/eu #prazo/2025-01-18

---

## Pontos Discutidos

### [Tópico 1]
- Ponto A
- Ponto B
- Conclusão: [...]

### [Tópico 2]
- [...]

---

## Pendências / Pontos em Aberto
- [ ] [Questão não resolvida 1]
- [ ] [Questão não resolvida 2]

---

## Quotes Importantes
> "[Citação relevante dita na reunião]"
> — Nome da Pessoa

---

## Links Relacionados
- [[Reunião Anterior - 2025-01-08]]
- [[Projeto X - Documentação]]
- [[Nome 1 - Contato]]

---

## Próximos Passos
1. [Próxima ação]
2. [Próxima reunião agendada para DATA]

---

## Transcrição Original
<details>
<summary>Clique para expandir</summary>

[Cole a transcrição completa aqui se quiser manter o original]

</details>
```

### Convenções de Nomenclatura

```
YYYY-MM-DD-tipo-descricao.md

Exemplos:
2025-01-15-kickoff-projeto-alpha.md
2025-01-18-1on1-maria-silva.md
2025-01-22-discovery-cliente-xyz.md
2025-01-25-retrospectiva-sprint-3.md
```

### Tags Sugeridas

```
#reunião
#reunião/cliente
#reunião/interna
#reunião/1on1
#reunião/planejamento
#reunião/review

#projeto/nome-do-projeto
#cliente/nome-do-cliente
#time/nome-do-time

#decisão
#action-item
#pendência
#risco
```

### Como Salvar no Obsidian
1. Gere a nota com o prompt
2. Crie novo arquivo no Obsidian (Ctrl+N)
3. Nomeie seguindo a convenção
4. Cole o conteúdo
5. Ajuste links [[]] para notas existentes
6. Adicione tags relevantes
7. Revise e salve

---

## ⚡ Workflow Completo (5 minutos)

### Passo a Passo Após Reunião

```
1. COLETAR (30 seg)
   └── Fathom > Recordings > Copiar transcrição

2. PROCESSAR (2 min)
   └── ChatGPT/Claude > Prompt combinado:

   "Analise esta transcrição e gere:
   1. Nota para Obsidian (formato completo com YAML)
   2. Resumo para email (formal, 150 palavras)
   3. Tarefas para WhatsApp (formato com emojis)
   4. Update para Slack (formato com formatação Slack)

   TRANSCRIÇÃO: [cole]"

3. DISTRIBUIR (2 min)
   └── Copie cada output para o destino:
       • Obsidian: Ctrl+N > Cole > Salve
       • Email: Compose > Cole > Envie
       • WhatsApp: Grupo > Cole > Envie
       • Slack: Canal > Cole > Envie

4. VERIFICAR (30 seg)
   └── Confirme que tudo foi enviado
```

---

## 🔄 Automação Futura (Nível 3)

Para automatizar esse workflow com n8n:

```
Trigger: Nova gravação no Fathom (webhook)
    ↓
Extrair transcrição (API Fathom)
    ↓
Processar com Claude API
    ↓
Distribuir automaticamente:
    ├── Gmail API → Email participantes
    ├── Slack API → Postar no canal
    ├── WhatsApp Business API → Grupo
    └── Obsidian (via pasta sync) → Criar nota
```

*Isso será coberto no Nível 3: Expert Customizando*

---

**Arquivo:** `resources/workflow-distribuicao.md`
