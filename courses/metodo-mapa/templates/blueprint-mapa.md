# BLUEPRINT M.A.P.A.™ - Template v2.0

**Projeto:** [NOME DO SEU PROJETO]
**Versão:** 1.0
**Data:** [DATA]
**Responsável:** [SEU NOME]

---

## 1. VISÃO GERAL

### O QUÊ
[Descreva em 1 parágrafo claro e objetivo o que é o sistema/projeto. Seja específico sobre funcionalidades principais.]

*Exemplo: Sistema de gestão de leads para agências digitais que automatiza captura, qualificação, nurturing e handoff para vendas, integrando com principais ferramentas do mercado brasileiro.*

### PARA QUEM
[Descreva o usuário final específico e a dor que resolve. Seja preciso sobre o perfil.]

*Exemplo: Agências digitais com 5-20 funcionários que perdem 40% dos leads por falta de follow-up sistemático e não têm budget para contratar SDR dedicado.*

### POR QUÊ
[Explique o problema core e o impacto mensurável da solução.]

*Exemplo: Agências pequenas recebem 50-200 leads/mês mas convertem apenas 3% por falta de processo. Este sistema automatiza trabalho de 2 SDRs por R$ 200/mês, aumentando conversão para 8-12%.*

---

## 2. REQUISITOS FUNCIONAIS

### RF01 - [Nome do Requisito Principal]
**Prioridade:** Alta | Média | Baixa
**Descrição:** [O que faz especificamente]

**Detalhamento:**
- [ ] Detalhe específico 1
- [ ] Detalhe específico 2
- [ ] Detalhe específico 3
- [ ] Critério de aceite

*Exemplo:*
### RF01 - Captura Automática de Leads
**Prioridade:** Alta
**Descrição:** Capturar leads de múltiplas fontes e centralizar

**Detalhamento:**
- [ ] Formulário embedável via iframe
- [ ] Webhook receptor para RD Station, Leadlovers, ActiveCampaign
- [ ] API REST para integrações customizadas
- [ ] Validação de email e telefone em tempo real
- [ ] Honeypot e reCAPTCHA para anti-spam
- [ ] Critério: Processar 100 leads/min sem perda

### RF02 - [Segundo Requisito]
**Prioridade:** Alta | Média | Baixa
**Descrição:** [...]

### RF03 - [Terceiro Requisito]
**Prioridade:** Alta | Média | Baixa
**Descrição:** [...]

[Continue até cobrir os 5-10 requisitos ESSENCIAIS do MVP. Não liste wishlist.]

---

## 3. TECH STACK

### BACKEND
- **Runtime:** [Node.js 20 | Python 3.11 | Go 1.21]
- **Framework:** [Express | FastAPI | Gin]
- **ORM/Database:** [Prisma | SQLAlchemy | GORM]
- **Autenticação:** [JWT | Auth0 | Supabase Auth]
- **Queue/Jobs:** [BullMQ | Celery | ?]

### FRONTEND
- **Framework:** [Next.js 14 | React 18 | Vue 3]
- **Styling:** [Tailwind CSS | styled-components | CSS Modules]
- **Components:** [shadcn/ui | MUI | Ant Design]
- **Estado:** [Zustand | Redux Toolkit | Pinia]
- **Forms:** [React Hook Form | Formik | ?]

### BANCO DE DADOS
- **Principal:** [PostgreSQL | MySQL | MongoDB]
- **Cache:** [Redis | Memcached | In-memory]
- **File Storage:** [S3 | Supabase Storage | Local]

### INFRAESTRUTURA
- **Deploy Backend:** [Railway | Render | Fly.io]
- **Deploy Frontend:** [Vercel | Netlify | Cloudflare Pages]
- **Monitoring:** [Sentry | LogRocket | ?]
- **Analytics:** [Plausible | PostHog | ?]

---

## 4. RESTRIÇÕES

### TÉCNICAS
- [ ] Máximo de [X] usuários simultâneos
- [ ] Response time < [X]ms (p95)
- [ ] Uptime mínimo: [99.9%]
- [ ] Compatibilidade: [Browsers, dispositivos]

### TEMPO
- **MVP Funcional:** [X] dias
- **Beta Privado:** [X] dias
- **Produção:** [X] dias

### CUSTO
- **Desenvolvimento:** R$ [valor ou "0 - você + IA"]
- **Infraestrutura mensal:** < R$ [valor]
- **Ferramentas/APIs:** R$ [valor]

### NÃO FAZER (IMPORTANTE!)
- [ ] [Feature que não é prioridade agora]
- [ ] [Overengineering a evitar]
- [ ] [Integrações complexas para fase 2]
- [ ] [Requisitos nice-to-have]

*Exemplo:*
- [ ] Não implementar ML/AI própria (usar APIs prontas)
- [ ] Não criar mobile app (só PWA responsiva)
- [ ] Não integrar com ERPs (fase 2)
- [ ] Não fazer multi-idioma (só PT-BR por ora)

---

## 5. CRITÉRIOS DE SUCESSO

### FUNCIONAIS
- [ ] [Critério objetivo e mensurável]
- [ ] [Critério objetivo e mensurável]
- [ ] [Critério objetivo e mensurável]

*Exemplo:*
- [ ] Processar 100 leads de teste sem erro
- [ ] Webhooks funcionando com 3 plataformas
- [ ] Export de relatório com 1000+ registros

### PERFORMANCE
- [ ] [Métrica específica com número]
- [ ] [Métrica específica com número]

*Exemplo:*
- [ ] Dashboard carrega em < 2 segundos
- [ ] API responde em < 200ms (p95)
- [ ] Suporta 100 requisições/segundo

### QUALIDADE
- [ ] [Padrão objetivo]
- [ ] [Padrão objetivo]

*Exemplo:*
- [ ] 0 erros críticos em produção por 7 dias
- [ ] Test coverage > 70%
- [ ] Lighthouse score > 85

### NEGÓCIO (mais importante!)
- [ ] [Impacto mensurável no negócio]
- [ ] [Impacto mensurável no negócio]

*Exemplo:*
- [ ] Reduzir tempo de qualificação de 2h para 5min
- [ ] Aumentar conversão de 3% para 8%+
- [ ] Economizar R$ 5k/mês vs. contratar SDR

---

## 6. REFERÊNCIAS

### PRODUTOS SIMILARES (inspiração)
- **[Produto 1]:** [O que especificamente copiar]
- **[Produto 2]:** [O que especificamente copiar]
- **[Produto 3]:** [O que especificamente copiar]

*Exemplo:*
- **Pipedrive:** Visual do pipeline kanban
- **HubSpot:** Simplicidade do onboarding
- **RD Station:** Integrações nacionais

### DESIGN/UX
- **[Referência]:** [Link]
- **[Referência]:** [Link]

*Exemplo:*
- **Dashboard:** https://app.useplausible.com
- **Tabelas:** https://airtable.com
- **Forms:** https://typeform.com

### NÃO COPIAR (importante!)
- **[Produto]:** [O que evitar]
- **[Produto]:** [O que evitar]

*Exemplo:*
- **Salesforce:** Complexidade excessiva
- **SAP:** Interface enterprise datada
- **Excel:** UX dos anos 90

### DOCUMENTAÇÃO TÉCNICA
- [Link para especificações de API]
- [Link para mockups/wireframes]
- [Link para fluxogramas]

---

## 7. INFORMAÇÕES ADICIONAIS

### RISCOS IDENTIFICADOS
1. [Risco]: [Mitigação]
2. [Risco]: [Mitigação]

### PONTOS DE ATENÇÃO
- [Consideração importante]
- [Consideração importante]

### FASE 2 (FUTURO)
- [Feature planejada mas não para MVP]
- [Feature planejada mas não para MVP]

---

## CHECKLIST DE VALIDAÇÃO

Antes de considerar este Blueprint pronto:

- [ ] Li todo o documento e está claro
- [ ] Qualquer dev entenderia sem perguntas
- [ ] Requisitos são específicos (não genéricos)
- [ ] Tech stack está 100% definida
- [ ] Critérios de sucesso são mensuráveis
- [ ] Restrições estão claras (principalmente o NÃO FAZER)
- [ ] Referências incluem links/exemplos
- [ ] Documento cabe em 3 páginas impressas

---

## APROVAÇÃO

**Status:** [ ] Em elaboração [ ] Revisão [ ] Aprovado

**Aprovado por:** _________________
**Data aprovação:** _________________

---

*Template M.A.P.A.™ v2.0 - Método de Orquestração de IAs Autônomas*
*"Clareza no início economiza 100h de retrabalho no fim."*