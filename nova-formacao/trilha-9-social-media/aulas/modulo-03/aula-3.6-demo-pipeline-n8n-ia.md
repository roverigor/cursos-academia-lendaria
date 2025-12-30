# Aula 3.6: Demo - Pipeline Completo com n8n + IA

## Trilha 9 - Social Media em Piloto | Modulo 3

---

> **Duracao:** 12 minutos
> **Tipo:** Demonstracao Avancada
> **Entregavel:** Compreensao do pipeline automatizado
> **Linha do DRE:** Custo operacional / Escalabilidade
> **IA Aplicada:** Core - Automacao completa com IA

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA]

"Essa aula e pra quem quer ir ALEM.

Vou mostrar um pipeline onde:
- A IA gera os posts
- O sistema agenda automaticamente
- Voce so adiciona ideias

E nao e obrigatorio.
O sistema basico ja funciona.

Mas se voce quer escalar,
isso muda o jogo.

Vamos ver."
```

---

### BLOCO 1: OS NIVEIS DE AUTOMACAO (1,5 minuto)

```
[MOSTRAR TABELA NA TELA]

"Antes de mostrar, contexto.

Existem 3 niveis de automacao.

[MOSTRAR]

NIVEL 1 - BASICO:
Voce cria os posts.
Voce agenda.
Sistema publica.
Tempo: 2h/semana.

NIVEL 2 - INTERMEDIARIO:
Voce da as ideias.
IA cria os posts.
Voce aprova.
Sistema agenda e publica.
Tempo: 1h/semana.

NIVEL 3 - AVANCADO:
Voce so aprova.
IA sugere ideias.
IA cria posts.
Sistema agenda e publica.
Tempo: 30 min/semana.

[OLHAR PARA CAMERA]

O que eu vou mostrar agora
e o nivel 2 para nivel 3.

Pra quem ja domina o basico
e quer escalar."
```

---

### BLOCO 2: A ARQUITETURA DO PIPELINE (2 minutos)

```
[MOSTRAR DIAGRAMA NA TELA]

"O pipeline completo funciona assim:

[MOSTRAR FLUXO]

1. GOOGLE SHEETS (Banco de Ideias)
Voce adiciona uma ideia aqui.
Exemplo: '5 ferramentas de IA para vendas'

↓

2. N8N (Orquestrador)
Detecta nova linha.
Dispara o processo.

↓

3. CHATGPT API (Criador)
Recebe a ideia.
Gera o post completo.
Retorna gancho, corpo, CTA, hashtags.

↓

4. BUFFER/META (Agendador)
Recebe o post pronto.
Agenda no horario definido.

↓

5. PUBLICADO
Sem voce fazer nada.

[OLHAR PARA CAMERA]

Voce adiciona uma linha na planilha.
20 minutos depois, ta agendado.

Isso e automacao de verdade."
```

---

### BLOCO 3: DEMONSTRACAO AO VIVO (4 minutos)

```
[COMPARTILHAR TELA]

"Vou fazer ao vivo.

[ABRIR GOOGLE SHEETS]

Minha planilha de ideias.
Colunas: Ideia | Etapa | Formato | Status

[ADICIONAR LINHA]

Nova ideia:
'5 formas de usar ChatGPT pra vendas'
Etapa: Topo
Formato: Carrossel
Status: Aguardando

[OLHAR PARA CAMERA]

Pronto. Adicionei.
Agora o n8n vai detectar.

[MOSTRAR N8N]

Olha o workflow.

1. Trigger: Nova linha no Sheets
2. Filtro: Status = Aguardando
3. HTTP: Envia pra ChatGPT
4. Parse: Formata resposta
5. HTTP: Envia pro Buffer
6. Update: Marca como Agendado

[AGUARDAR]

[MOSTRAR RESULTADO]

Olha.
Post gerado.
Ja ta no Buffer.
Agendado pra amanha.

[VOLTAR PRO SHEETS]

Status: Agendado.

[OLHAR PARA CAMERA]

3 minutos.
Da ideia ao agendado.
Sem tocar em mais nada."
```

---

### BLOCO 4: PRA QUEM E ISSO (2 minutos)

```
[OLHAR PARA CAMERA]

"Antes de voce querer fazer isso,
entenda pra quem e.

[MOSTRAR]

IDEAL PARA:
- Quem ja domina o basico
- Volume alto (10+ posts/semana)
- Multiplos canais
- Quer escalar sem contratar

NAO IDEAL PARA:
- Iniciantes (comece manual primeiro)
- Baixo volume (1-3 posts/semana)
- Quem nao quer aprender ferramentas

[MOSTRAR CUSTOS]

CUSTO DO SETUP:
- Google Sheets: Gratis
- n8n self-hosted: Gratis
- n8n cloud: $20/mes
- ChatGPT API: ~$5/mes (uso moderado)
- Buffer: Gratis-$15/mes
- TOTAL: $5-40/mes

[OLHAR PARA CAMERA]

Se voce ainda ta no comeco,
nao precisa disso agora.

Use o sistema manual.
Domina.
Quando saturar, volta aqui."
```

---

### BLOCO 5: COMO IMPLEMENTAR (1,5 minuto)

```
[OLHAR PARA CAMERA]

"Se voce quer implementar,
o caminho e esse:

[MOSTRAR PASSOS]

PASSO 1: Crie a planilha
Mesma estrutura que mostrei.
Ideia | Etapa | Formato | Status

PASSO 2: Configure o n8n
Crie conta no n8n.io
Importe o template (ta no material)

PASSO 3: Conecte ChatGPT
Pegue sua API key
Configure no n8n

PASSO 4: Conecte Buffer/Meta
Autorize o n8n a postar

PASSO 5: Teste
Adiciona uma ideia
Verifica se funcionou

[OLHAR PARA CAMERA]

Tempo de setup: 2-3 horas.
Uma vez configurado, roda sozinho.

Tem tutorial detalhado no material."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR PARA CAMERA]

"Resumindo:

Pipeline avancado:
Planilha → n8n → ChatGPT → Buffer → Publicado

Pra quem: Ja domina o basico e quer escalar.
Custo: $5-40/mes.
Setup: 2-3 horas.

Nao e obrigatorio.
O sistema manual funciona.

Mas se voce quer ir alem,
agora voce sabe como.

Na proxima aula, voce vai configurar
seu proprio pipeline de 30 dias.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Arquitetura do Pipeline

```
┌─────────────────┐
│  Google Sheets  │ ← Voce adiciona ideias
│  (Banco Ideias) │
└────────┬────────┘
         │ Trigger: Nova linha
         ▼
┌─────────────────┐
│      n8n        │ ← Orquestra o fluxo
│  (Automacao)    │
└────────┬────────┘
         │ Envia prompt
         ▼
┌─────────────────┐
│    ChatGPT      │ ← Gera o post
│    (API)        │
└────────┬────────┘
         │ Post pronto
         ▼
┌─────────────────┐
│  Buffer/Meta    │ ← Agenda
│  (Agendamento)  │
└────────┬────────┘
         │ Data/hora
         ▼
┌─────────────────┐
│   PUBLICADO     │
└─────────────────┘
```

### Niveis de Automacao

| Nivel | Voce Faz | Sistema Faz | Tempo/Sem |
|-------|----------|-------------|-----------|
| Basico | Cria + Agenda | Publica | 2h |
| Intermediario | Ideias + Aprova | Cria + Agenda | 1h |
| Avancado | Aprova | Tudo | 30 min |

### Custos do Setup

| Componente | Custo |
|------------|-------|
| Google Sheets | Gratis |
| n8n (self-hosted) | Gratis |
| n8n (cloud) | $20/mes |
| ChatGPT API | ~$5/mes |
| Buffer | Gratis-$15/mes |
| **TOTAL** | **$5-40/mes** |

### Prompt Usado no Pipeline

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

---

## CHECKPOINT

- [ ] Entendi os 3 niveis de automacao
- [ ] Sei a arquitetura do pipeline
- [ ] Entendi pra quem e indicado
- [ ] Decidi se vou implementar

---

## CONEXAO COM PROXIMA AULA

> Voce viu o avancado. Na proxima aula, voce vai configurar SEU pipeline - seja basico ou avancado - para os proximos 30 dias.

**Proxima:** Aula 3.7 - Exercicio: Seu Pipeline de 30 Dias

---

**Tempo real:** 12 minutos
**Demo:** Pipeline automatizado com n8n + IA
**IA:** Core - Demonstracao de automacao completa
