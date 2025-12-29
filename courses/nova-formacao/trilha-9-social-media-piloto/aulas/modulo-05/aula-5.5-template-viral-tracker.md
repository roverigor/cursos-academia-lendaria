# Aula 5.5: Template - Viral Tracker Dashboard

## Trilha 9 - Social Media em Piloto | Modulo 5

---

> **Duracao:** 7 minutos
> **Tipo:** Template
> **Entregavel:** Viral Tracker configurado

---

## GANCHO DE ABERTURA

**"Este dashboard vai te avisar ANTES de um post viralizar. Voce vai saber exatamente quando agir e como."**

---

## ESTRUTURA DO VIRAL TRACKER

### Visao Geral

```
VIRAL TRACKER DASHBOARD
├── 1. Posts em Monitoramento
├── 2. Metricas de Viralizacao
├── 3. Alertas e Gatilhos
├── 4. Historico de Virais
├── 5. Padroes Identificados
└── 6. Playbook de Acao
```

---

## 1. POSTS EM MONITORAMENTO

### Template de Monitoramento Ativo

| Post | Data | Hora Pub | Velocity 1h | Share Rate | Save Rate | Status | Acao |
|------|------|----------|-------------|------------|-----------|--------|------|
| [Titulo] | 15/01 | 11h | 12% | 2.5% | 4% | Aquecendo | Responder |
| [Titulo] | 14/01 | 19h | 5% | 1% | 2% | Normal | Observar |
| [Titulo] | 13/01 | 11h | 8% | 1.5% | 3% | Bom | Variar |

### Regra de Monitoramento

```
Primeiras 24h: Verificar a cada 1-2h
24-48h: Verificar 2x ao dia
48h+: Verificar 1x ao dia
```

---

## 2. METRICAS DE VIRALIZACAO

### Dashboard Visual

```
POST: [Nome do Post]
DATA: [Data de publicacao]

┌─────────────────────────────────────────────┐
│           METRICAS EM TEMPO REAL            │
├─────────────────────────────────────────────┤
│ VELOCITY (1h)                               │
│ ████████████████░░░░  12%  🔥 AQUECENDO     │
├─────────────────────────────────────────────┤
│ SHARE RATE                                  │
│ ███████░░░░░░░░░░░░░  2.5% ✓ BOM            │
├─────────────────────────────────────────────┤
│ SAVE RATE                                   │
│ ████████████░░░░░░░░  4%   ✓ BOM            │
├─────────────────────────────────────────────┤
│ COMMENT DEPTH                               │
│ ██████████░░░░░░░░░░  MEDIO                 │
└─────────────────────────────────────────────┘

STATUS GERAL: 🔥 AQUECENDO - Preparar capitalizacao
```

### Template Numerico

| Metrica | Valor | Benchmark | Status |
|---------|-------|-----------|--------|
| Velocity 1h | __% | >10% = viral | Normal/Aquecendo/Viral |
| Share Rate | __% | >3% = viral | Normal/Bom/Viral |
| Save Rate | __% | >5% = evergreen | Normal/Bom/Excelente |
| Comentarios | __ | Qualitativo | Raso/Medio/Profundo |

---

## 3. ALERTAS E GATILHOS

### Configuracao de Alertas

| Gatilho | Threshold | Acao | Urgencia |
|---------|-----------|------|----------|
| Velocity > 10% em 1h | ALERTA | Verificar e preparar | ALTA |
| Share Rate > 3% | CAPITALIZAR | Ativar playbook | ALTA |
| Save Rate > 5% | REPLICAR | Criar variacao/produto | MEDIA |
| 50+ comentarios | ENGAJAR | Responder todos | MEDIA |
| Mencao de influenciador | OPORTUNIDADE | Contato direto | ALTA |

### Notificacoes Sugeridas

- [ ] Alarme celular para verificar velocity (1h apos post)
- [ ] Email diario com resumo de metricas
- [ ] Notificacao push para alertas de viral

---

## 4. HISTORICO DE VIRAIS

### Registro de Posts que Viralizaram

| Post | Data | Alcance Final | Seguidores+ | Leads | Vendas | O Que Funcionou |
|------|------|---------------|-------------|-------|--------|-----------------|
| [Titulo] | | | | | | |
| [Titulo] | | | | | | |

### Template de Analise Pos-Viral

```
POST: [Nome]
DATA: [Data]

METRICAS FINAIS:
- Alcance: ___
- Engajamento: ___
- Seguidores ganhos: ___
- Leads capturados: ___
- Vendas: ___

O QUE FUNCIONOU:
- Gancho: ___
- Formato: ___
- Horario: ___
- Tema: ___

LICOES PARA REPLICAR:
1. ___
2. ___
3. ___
```

---

## 5. PADROES IDENTIFICADOS

### Analise de Padroes

| Categoria | Padrao Identificado | Frequencia |
|-----------|---------------------|------------|
| Tema | [Qual tema viraliza mais] | X de Y virais |
| Formato | [Carrossel? Reels?] | X de Y virais |
| Horario | [Melhor horario] | X de Y virais |
| Gancho | [Tipo de gancho] | X de Y virais |
| Emocao | [Qual emocao] | X de Y virais |

### Prompt IA: Identificar Padroes

```
Analise meu historico de virais e identifique padroes.

POSTS QUE VIRALIZARAM:
1. [Descreva post 1 - tema, formato, horario, metricas]
2. [Descreva post 2]
3. [Descreva post 3]

IDENTIFIQUE:
1. Padroes de tema
2. Padroes de formato
3. Padroes de horario
4. Padroes de gancho
5. Emocoes predominantes

SUGIRA:
- Formula para replicar
- Proximo post com maior probabilidade de viralizar
```

---

## 6. PLAYBOOK DE ACAO

### Decisoes Pre-Configuradas

| Status | Acao Automatica | Quem/Quando |
|--------|-----------------|-------------|
| Normal | Observar, nao agir | Verificar 1x/dia |
| Aquecendo | Responder comentarios, preparar Story | Proximas 2h |
| Viral | Ativar playbook completo | AGORA |

### Checklist Viral (Imprimir e Ter a Mao)

```
□ FASE 1 (0-24h)
  □ Nao editar o post
  □ Responder todos comentarios
  □ Postar Story amplificando
  □ Verificar link na bio

□ FASE 2 (24-72h)
  □ Post follow-up
  □ DMs para top engajadores
  □ Lead Magnet relacionado
  □ CTA para oferta

□ FASE 3 (72h+)
  □ Analisar metricas
  □ Documentar aprendizados
  □ Criar variacao
  □ Atualizar padroes
```

---

## TEMPLATE COMPLETO

Acesse o template pronto em:
- `/templates/viral-tracker.md`

---

## PROMPT IA: CONFIGURAR TRACKER

```
Configure meu Viral Tracker personalizado.

MINHA FREQUENCIA DE POSTS: [X/semana]
MEUS CANAIS: [lista]
MEU TEMPO DISPONIVEL: [horas/semana para monitorar]
MINHA OFERTA: [produto/servico]

CRIE:
1. Dashboard de monitoramento adequado ao meu volume
2. Alertas e thresholds personalizados
3. Playbook de acao simplificado
4. Rotina de verificacao realista

FORMATO: Template pronto para implementar
```

---

## CONEXAO COM PROXIMA AULA

Agora vamos ver esse tracker funcionando na pratica com um caso real de post que viralizou.

**Proxima Aula:** 5.6 - Demo: Tracker + Decisoes em Tempo Real

---

**Tempo real:** 7 minutos
**Entregavel:** Viral Tracker Dashboard
