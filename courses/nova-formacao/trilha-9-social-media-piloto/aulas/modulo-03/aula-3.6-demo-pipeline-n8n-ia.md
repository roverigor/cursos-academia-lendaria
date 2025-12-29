# Aula 3.6: Demo - Pipeline Completo com n8n + IA

## Trilha 9 - Social Media em Piloto | Modulo 3

---

> **Duracao:** 12 minutos
> **Tipo:** Demonstracao
> **Caso:** Automacao avancada com n8n e ChatGPT

---

## GANCHO DE ABERTURA

**"Vou mostrar como automatizar ainda mais: IA gerando posts + agendamento 100% automatico. Voce so adiciona ideias."**

---

## NIVEL DE AUTOMACAO

| Nivel | Voce Faz | Sistema Faz | Tempo/Semana |
|-------|----------|-------------|--------------|
| Basico | Cria + Agenda | Publica | 2h |
| Intermediario | Ideias + Aprova | Cria + Agenda + Publica | 1h |
| Avancado | Aprova | Ideia + Cria + Agenda + Publica | 30 min |

**Esta demo:** Nivel Intermediario/Avancado

---

## O PIPELINE COMPLETO

### Arquitetura

```
┌─────────────────┐
│  Google Sheets  │ ← Voce adiciona ideias aqui
│  (Banco Ideias) │
└────────┬────────┘
         │ Trigger: Nova linha
         ▼
┌─────────────────┐
│      n8n        │ ← Orquestra todo o fluxo
│  (Automacao)    │
└────────┬────────┘
         │ Envia prompt
         ▼
┌─────────────────┐
│    ChatGPT      │ ← Desenvolve o post
│    (API)        │
└────────┬────────┘
         │ Post pronto
         ▼
┌─────────────────┐
│  Buffer/Meta    │ ← Agenda automaticamente
│  (Agendamento)  │
└────────┬────────┘
         │ Data/hora programada
         ▼
┌─────────────────┐
│   PUBLICADO     │ ← Sem voce fazer nada
└─────────────────┘
```

---

## COMPONENTES

### 1. Google Sheets - Banco de Ideias

| Coluna A | Coluna B | Coluna C | Coluna D | Coluna E |
|----------|----------|----------|----------|----------|
| Ideia | Etapa | Formato | Data Desejada | Status |
| "5 ferramentas IA" | Topo | Carrossel | 15/01 | Aguardando |
| "Case cliente X" | Meio | Reels | 16/01 | Aguardando |

### 2. n8n - Workflow de Automacao

Nodes do workflow:
1. **Trigger:** Google Sheets (nova linha)
2. **Filter:** Status = "Aguardando"
3. **HTTP Request:** ChatGPT API
4. **Set:** Formatar resposta
5. **HTTP Request:** Buffer API
6. **Google Sheets:** Atualizar status

### 3. Prompt Enviado ao ChatGPT

```
Desenvolva um post para Instagram.

IDEIA: {{ideia}}
ETAPA: {{etapa}}
FORMATO: {{formato}}

ESTRUTURA:
- Gancho (10 palavras max)
- Corpo (150 palavras max)
- CTA claro
- 5 hashtags relevantes

TOM: Profissional mas acessivel
PUBLICO: Empresarios PME

Retorne em JSON:
{
  "gancho": "",
  "corpo": "",
  "cta": "",
  "hashtags": []
}
```

### 4. Buffer/Meta - Agendamento

API recebe:
- Texto do post
- Data/hora
- Plataforma

---

## DEMONSTRACAO PASSO A PASSO

### Minuto 0-2: Setup
- Mostrar planilha com 3 ideias
- Explicar colunas

### Minuto 2-5: Workflow n8n
- Trigger disparado
- ChatGPT processa
- Buffer recebe

### Minuto 5-8: Resultado
- Post gerado automaticamente
- Agendado sem intervencao
- Status atualizado

### Minuto 8-12: Variacoes
- Como customizar prompts
- Como ajustar frequencia
- Como escalar para multiplos canais

---

## PROMPT IA: CONFIGURAR SEU WORKFLOW

```
Crie um workflow de automacao para meu conteudo.

MEU STACK:
- Planilha: [Google Sheets/Notion/Airtable]
- Automacao: [n8n/Zapier/Make]
- IA: [ChatGPT/Claude]
- Agendamento: [Buffer/Meta/Later]

MEU PROCESSO:
1. Eu adiciono ideias em: ___
2. Quero que a IA: ___
3. Publicar em: ___
4. Frequencia: ___

DESCREVA:
1. Passo a passo do workflow
2. Prompts necessarios
3. Configuracoes importantes
4. Tempo estimado de setup
```

---

## PARA QUEM E ESTA AUTOMACAO

**Ideal para:**
- Quem ja domina o basico
- Volume alto de conteudo (10+ posts/semana)
- Multiplos canais
- Quer escalar sem contratar

**Nao ideal para:**
- Iniciantes (comece manual primeiro)
- Baixo volume (1-3 posts/semana)
- Quem nao quer aprender ferramentas

---

## CUSTO DO SETUP

| Componente | Custo |
|------------|-------|
| Google Sheets | Gratis |
| n8n (self-hosted) | Gratis |
| n8n (cloud) | $20/mes |
| ChatGPT API | ~$5/mes (uso moderado) |
| Buffer | Gratis-$15/mes |
| **TOTAL** | $5-40/mes |

---

## INSIGHT PRINCIPAL

> **"Automacao nao substitui estrategia. Ela libera seu tempo para pensar estrategia. Voce continua no comando, mas trabalha menos."**

---

## CONEXAO COM PROXIMA AULA

Agora e sua vez. Na proxima aula, voce vai configurar SEU pipeline para os proximos 30 dias.

**Proxima Aula:** 3.7 - Exercicio: Seu Pipeline de 30 Dias

---

**Tempo real:** 12 minutos
**Demo:** Automacao completa com IA
