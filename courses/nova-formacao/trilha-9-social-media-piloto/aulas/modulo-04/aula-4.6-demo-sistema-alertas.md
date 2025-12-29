# Aula 4.6: Demo - Sistema Completo com Alertas

## Trilha 9 - Social Media em Piloto | Modulo 4

---

> **Duracao:** 12 minutos
> **Tipo:** Demonstracao
> **Caso:** Sistema de Social Listening funcional

---

## GANCHO DE ABERTURA

**"Vou mostrar exatamente como configuro meu sistema de escuta social. Funciona no piloto automatico e me avisa quando preciso agir."**

---

## O SISTEMA COMPLETO

### Stack Usado (100% Gratis)

| Componente | Ferramenta | Funcao |
|------------|------------|--------|
| Alertas web | Google Alerts | Monitora mencoes online |
| Twitter/X | TweetDeck | Monitora em tempo real |
| Centralizador | Google Sheets | Consolida tudo |
| Analise | ChatGPT/Claude | Classifica sentimento |
| Notificacoes | Email + IFTTT | Avisa urgencias |

---

## ARQUITETURA DO FLUXO

```
┌──────────────────────────────────────────────────────────┐
│                    FONTES DE DADOS                       │
├──────────────┬──────────────┬──────────────┬────────────┤
│ Google       │ TweetDeck    │ Busca        │ DMs/       │
│ Alerts       │              │ Manual       │ Comentarios│
└──────┬───────┴──────┬───────┴──────┬───────┴──────┬─────┘
       │              │              │              │
       └──────────────┴──────────────┴──────────────┘
                           │
                           ▼
            ┌──────────────────────────┐
            │     GOOGLE SHEETS        │
            │   (Dashboard Central)    │
            └────────────┬─────────────┘
                         │
                         ▼
            ┌──────────────────────────┐
            │      CHATGPT/CLAUDE      │
            │   (Analise Sentimento)   │
            └────────────┬─────────────┘
                         │
           ┌─────────────┼─────────────┐
           ▼             ▼             ▼
      ┌─────────┐  ┌─────────┐  ┌─────────┐
      │POSITIVO │  │ NEUTRO  │  │NEGATIVO │
      │Agradecer│  │ Engajar │  │ URGENTE │
      └─────────┘  └─────────┘  └────┬────┘
                                     │
                                     ▼
                              ┌──────────────┐
                              │   ALERTA!    │
                              │ Email+IFTTT  │
                              └──────────────┘
```

---

## DEMONSTRACAO PASSO A PASSO

### Minuto 0-3: Google Alerts

**Configuracao mostrada:**

1. Acesso: google.com/alerts
2. Criar alerta "Nome Empresa"
3. Configurar:
   - Frequencia: "Conforme acontece"
   - Fontes: "Automatico"
   - Idioma: Portugues
   - Regiao: Brasil
   - Quantidade: "Todos os resultados"
   - Entregar: "Email"

4. Repetir para +4 termos

**Resultado:** 5 alertas ativos, emails automaticos

---

### Minuto 3-6: TweetDeck/X

**Configuracao mostrada:**

1. Acesso: tweetdeck.twitter.com
2. Criar coluna "Busca"
3. Adicionar termos:
   - "Nome Empresa"
   - "@perfil"
   - "nicho + dor"

4. Configurar notificacoes

**Resultado:** Monitoramento Twitter em tempo real

---

### Minuto 6-9: Google Sheets + IA

**Processo mostrado:**

1. Abrir planilha "Social Listening"
2. Colar mencoes do email
3. Copiar tudo para ChatGPT
4. Usar prompt de analise
5. Colar resultado de volta

**Prompt usado:**

```
Analise estas mencoes e classifique:

[MENCOES COLADAS]

Retorne em formato de tabela:
| Mencao | Sentimento | Urgencia | Acao |

No final, liste:
- Acoes prioritarias (urgencia alta)
- Insights identificados
```

**Resultado:** Mencoes classificadas + prioridades claras

---

### Minuto 9-12: Sistema de Alertas

**Configuracao IFTTT mostrada:**

1. Acesso: ifttt.com
2. Criar Applet:
   - IF: Email com assunto contendo "reclamacao" OU "problema"
   - THEN: Enviar notificacao push

3. Alternativa com Gmail:
   - Filtro para emails do Google Alerts
   - Se contem "negativo" → Marcar importante

**Resultado:** Alertas automaticos para urgencias

---

## FLUXO SEMANAL REAL

### Minha Rotina (15 min/semana)

| Dia | Tarefa | Tempo |
|-----|--------|-------|
| Segunda | Revisar emails de alertas | 5 min |
| Quarta | Consolidar mencoes na planilha | 5 min |
| Sexta | Analisar com IA + Tomar acoes | 5 min |

### Fluxo Visual

```
SEG: Email alertas → Ler rapidamente
        ↓
QUA: Planilha → Colar mencoes
        ↓
SEX: ChatGPT → Analise + Acoes
        ↓
     Responder prioritarias
        ↓
     Atualizar dashboard
```

---

## AUTOMACAO AVANCADA (Opcional)

### Para quem quer ir alem

**Opcao 1: n8n/Zapier**
- Trigger: Novo email do Google Alerts
- Action: Adicionar linha na planilha
- Action: Enviar para ChatGPT API
- Action: Classificar automaticamente

**Opcao 2: API do Twitter**
- Monitorar mencoes via API
- Classificar com OpenAI
- Notificar se negativo

**Custo:** $0-30/mes dependendo do volume

---

## PROMPT IA: SETUP PERSONALIZADO

```
Crie um sistema de social listening para meu perfil.

MEU NEGOCIO: [tipo]
MEUS CANAIS: [lista]
MEU TEMPO DISPONIVEL: [horas/semana]
NIVEL TECNICO: [iniciante/intermediario/avancado]
ORCAMENTO: [gratis/ate X/mes]

RETORNE:
1. Stack recomendado
2. Termos para monitorar
3. Ferramentas especificas
4. Passo a passo de setup
5. Rotina semanal ideal
6. Alertas a configurar
```

---

## RESULTADO ESPERADO

### Apos Implementar

| Metrica | Antes | Depois |
|---------|-------|--------|
| Mencoes detectadas | 10% | 80%+ |
| Tempo de resposta | 72h | <24h |
| Oportunidades perdidas | Muitas | Poucas |
| Crises viram virais | Sim | Nao |

---

## INSIGHT PRINCIPAL

> **"O sistema perfeito e o que voce USA. Comece com Google Alerts + planilha. Sofistique depois."**

---

## CONEXAO COM PROXIMA AULA

Agora e sua vez. Na proxima aula, voce vai criar SEU sistema de escuta social.

**Proxima Aula:** 4.7 - Exercicio: Seu Sistema de Escuta

---

**Tempo real:** 12 minutos
**Demo:** Sistema completo funcionando
