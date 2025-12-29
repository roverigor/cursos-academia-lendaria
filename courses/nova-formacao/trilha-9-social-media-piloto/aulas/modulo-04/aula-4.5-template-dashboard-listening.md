# Aula 4.5: Template - Dashboard de Social Listening

## Trilha 9 - Social Media em Piloto | Modulo 4

---

> **Duracao:** 7 minutos
> **Tipo:** Template
> **Entregavel:** Dashboard de Social Listening configurado

---

## GANCHO DE ABERTURA

**"Este dashboard vai centralizar tudo que falam sobre voce. Um lugar so para escutar, analisar e agir."**

---

## ESTRUTURA DO DASHBOARD

### Visao Geral

```
DASHBOARD DE SOCIAL LISTENING
├── 1. Palavras-Chave Monitoradas
├── 2. Mencoes da Semana
├── 3. Metricas de Sentimento
├── 4. Insights do Periodo
├── 5. Acoes Tomadas
└── 6. Alertas e Gatilhos
```

---

## 1. PALAVRAS-CHAVE MONITORADAS

### Template

| Camada | Termo | Fonte | Frequencia | Status |
|--------|-------|-------|------------|--------|
| Marca | "Nome Empresa" | Google Alerts | Diario | Ativo |
| Marca | @perfil | Manual | 3x/semana | Ativo |
| Concorrente | "Concorrente A" | Google Alerts | Semanal | Ativo |
| Mercado | "dor do ICP" | TweetDeck | Continuo | Ativo |

### Prompt IA: Configurar Lista

```
Configure minha lista de monitoramento.

MINHA MARCA: [nome]
MEUS CONCORRENTES: [lista]
MEU NICHO: [nicho]
MINHA CAPACIDADE: [iniciante/intermediario]

RETORNE:
1. Top 10 termos prioritarios
2. Fonte recomendada para cada
3. Frequencia ideal de verificacao
4. Como configurar cada alerta (passo a passo)
```

---

## 2. MENCOES DA SEMANA

### Template de Registro

| Data | Fonte | Autor | Mencao (resumo) | Sentimento | Urgencia | Acao | Status |
|------|-------|-------|-----------------|------------|----------|------|--------|
| 15/01 | Instagram | @user1 | "Adorei o curso" | Positivo | Baixa | Agradecer | Feito |
| 16/01 | Twitter | @user2 | "Problema com X" | Negativo | Alta | Resolver | Pendente |
| 17/01 | LinkedIn | User3 | "Indicam consultoria?" | Neutro | Media | Responder | Feito |

### Prompt IA: Preencher Automaticamente

```
Preencha meu registro de mencoes com os dados abaixo.

MENCOES BRUTAS:
[Cole todas as mencoes coletadas]

PARA CADA MENCAO, EXTRAIA:
- Data (se disponivel)
- Fonte/Plataforma
- Autor
- Resumo em 1 frase
- Sentimento
- Urgencia
- Acao recomendada

FORMATO: Tabela pronta para colar no dashboard
```

---

## 3. METRICAS DE SENTIMENTO

### Dashboard Visual

```
SENTIMENTO GERAL ESTA SEMANA
━━━━━━━━━━━━━━━━━━━━━━━━━━━

Positivo ████████████░░░░ 65%
Neutro   ████░░░░░░░░░░░░ 25%
Negativo ██░░░░░░░░░░░░░░ 10%

Total: 20 mencoes
Meta: >70% positivo ✓
```

### Template de Acompanhamento

| Semana | Total | Positivo | Neutro | Negativo | Score |
|--------|-------|----------|--------|----------|-------|
| Sem 1 | 15 | 10 (67%) | 3 (20%) | 2 (13%) | +54 |
| Sem 2 | 18 | 14 (78%) | 2 (11%) | 2 (11%) | +67 |
| Sem 3 | 20 | 13 (65%) | 5 (25%) | 2 (10%) | +55 |

**Score = % Positivo - % Negativo**

---

## 4. INSIGHTS DO PERIODO

### Template

| Periodo | Insight | Categoria | Acao Derivada |
|---------|---------|-----------|---------------|
| Sem 1 | Muita pergunta sobre pricing | Vendas | Criar post sobre precos |
| Sem 2 | Elogios ao atendimento | Reputacao | Pedir mais testimonials |
| Sem 3 | Reclamacao sobre demora | Processo | Revisar SLA |

### Prompt IA: Extrair Insights

```
Analise estas mencoes e extraia insights estrategicos.

MENCOES DO PERIODO:
[Cole todas as mencoes]

IDENTIFIQUE:
1. Top 3 temas recorrentes
2. Oportunidades de conteudo
3. Gaps no produto/servico
4. Tendencias emergentes
5. Alertas de reputacao

PARA CADA INSIGHT:
- Descricao em 1 frase
- Categoria (Vendas/Conteudo/Produto/Reputacao)
- Acao recomendada
- Prioridade (Alta/Media/Baixa)
```

---

## 5. ACOES TOMADAS

### Registro de Respostas

| Data | Mencao | Tipo | Resposta | Resultado |
|------|--------|------|----------|-----------|
| 15/01 | Elogio ao curso | Agradecer | "Obrigado! Fico feliz..." | Virou seguidor |
| 16/01 | Reclamacao entrega | Resolver | "Me chama no DM..." | Resolvido, removeu critica |
| 17/01 | Pergunta sobre servico | Informar | "Sim, oferecemos..." | Agendou call |

### Metricas de Acao

| Metrica | Meta | Real | Status |
|---------|------|------|--------|
| Taxa resposta positivos | 80% | 90% | ✓ |
| Taxa resposta negativos | 100% | 100% | ✓ |
| Tempo medio resposta | <24h | 8h | ✓ |
| Taxa resolucao | 80% | 85% | ✓ |

---

## 6. ALERTAS E GATILHOS

### Configuracao de Alertas

| Gatilho | Acao | Quem Avisa |
|---------|------|------------|
| Mencao negativa | Notificar imediatamente | Email + WhatsApp |
| Mencao de influenciador | Revisar para oportunidade | Email |
| Pico de mencoes | Verificar se e crise ou viral | Email |
| Concorrente atacado | Avaliar oportunidade | Email semanal |

### Prompt IA: Configurar Alertas

```
Me ajude a configurar alertas de social listening.

MEU NEGOCIO: [tipo]
MINHA CAPACIDADE DE RESPOSTA: [horas disponiveis]
CANAIS PRIORITARIOS: [lista]

SUGIRA:
1. Quais alertas sao essenciais
2. Quais posso ignorar no inicio
3. Ferramentas gratuitas para cada alerta
4. Fluxo de notificacao ideal
```

---

## TEMPLATE COMPLETO

Acesse o template pronto para copiar em:
- `/templates/dashboard-social-listening.md`

---

## ROTINA DE USO DO DASHBOARD

### Diario (5 min)
- Verificar alertas de urgencia
- Responder negativos pendentes

### Semanal (30 min)
- Revisar todas as mencoes
- Atualizar metricas
- Extrair insights
- Planejar acoes

### Mensal (1h)
- Analisar tendencias
- Ajustar palavras-chave
- Reportar resultados
- Otimizar processo

---

## CONEXAO COM PROXIMA AULA

Agora vamos ver esse dashboard funcionando na pratica. Na proxima aula, demonstro um sistema completo com alertas.

**Proxima Aula:** 4.6 - Demo: Sistema Completo com Alertas

---

**Tempo real:** 7 minutos
**Entregavel:** Dashboard de Social Listening
