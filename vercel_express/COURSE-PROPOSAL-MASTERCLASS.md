# Proposta de Curso: Vercel Masterclass

**Versão:** 3.0 (Reposicionado)
**Data:** 2026-01-04
**Duração:** 8-10 horas
**ICP:** Dev Intermediário (já faz deploy, quer dominar)

---

## 1. VISÃO DO CURSO

### 1.1 Promessa

> **"Domine Vercel do fundamento à produção: entenda a filosofia, a arquitetura e os recursos avançados que fazem da Vercel a plataforma preferida de milhões de desenvolvedores."**

### 1.2 Posicionamento

| Aspecto | Vercel Masterclass |
|---------|-------------------|
| **Objetivo** | Domínio completo |
| **Tempo** | 8-10 horas |
| **Foco** | Filosofia + Arquitetura + Avançado |
| **Pré-requisito** | Vercel Express ou experiência equivalente |
| **Entregável** | Portfolio avançado + App com AI |

### 1.3 Para Quem É Este Curso

**IDEAL PARA:**
- Dev que já faz deploy mas não entende o "porquê"
- Dev que quer otimizar performance e custos
- Dev que quer usar recursos avançados (ISR, Edge, AI)
- Dev que quer entender arquitetura de frontend cloud

**NÃO É PARA:**
- Quem nunca fez deploy (fazer Vercel Express primeiro)
- Quem só quer "colocar site no ar" (Express resolve)

### 1.4 Transformação do Aluno

**ANTES:**
- "Vercel é só pra fazer deploy"
- Não sabe quando usar SSR vs SSG vs ISR
- Não aproveita Edge Functions
- Não entende a filosofia por trás das decisões

**DEPOIS:**
- Entende a arquitetura e filosofia
- Toma decisões técnicas informadas
- Otimiza performance e custos
- Usa recursos avançados com confiança
- Sabe quando Vercel é a escolha certa (e quando não é)

---

## 2. ESTRUTURA DO CURSO (8-10h)

### MÓDULO 0: A HISTÓRIA QUE VOCÊ PRECISA CONHECER (45 min)

> "Para usar bem uma ferramenta, você precisa entender por que ela foi criada."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 0.1 | O Garoto de Buenos Aires | 10 min | Guillermo Rauch: de Lanús a San Francisco |
| 0.2 | De LearnBoost a Vercel | 10 min | Socket.io → LearnBoost → ZEIT → Vercel |
| 0.3 | Por Que Next.js Existe | 10 min | O problema do React SPA e a solução SSR |
| 0.4 | A Filosofia do Frontend Cloud | 15 min | DX, Zero Config, Edge-First, Preview-Driven |

**Entregável:** Quiz de compreensão

---

### MÓDULO 1: ARQUITETURA PROFUNDA (1h)

> "O que acontece entre o git push e seu site no ar."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 1.1 | Anatomia de um Deploy | 15 min | Build → Deploy → CDN → Edge |
| 1.2 | CDN Global da Vercel | 15 min | POPs, cache, invalidação |
| 1.3 | Serverless de Verdade | 15 min | Cold starts, containers, billing |
| 1.4 | Edge vs Serverless: Decisão Técnica | 15 min | Quando usar cada um (com exemplos) |

**Entregável:** Diagrama de arquitetura anotado

---

### MÓDULO 2: RENDERIZAÇÃO AVANÇADA (1h 15min)

> "SSR, SSG, ISR, CSR - de uma vez por todas."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 2.1 | O Problema do React SPA | 15 min | CSR e suas limitações reais |
| 2.2 | SSG: Estático no Build | 15 min | getStaticProps, casos de uso |
| 2.3 | SSR: Dinâmico por Request | 15 min | getServerSideProps, trade-offs |
| 2.4 | ISR: O Híbrido Inteligente | 20 min | Stale-while-revalidate, on-demand |
| 2.5 | Matriz de Decisão | 10 min | Fluxograma: qual usar em cada cenário |

**Entregável:** App com SSG + ISR implementado

---

### MÓDULO 3: EDGE FUNCTIONS E MIDDLEWARE (1h)

> "Código que roda na borda da rede."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 3.1 | O Que é Edge Computing | 15 min | Latência, distribuição global |
| 3.2 | Seu Primeiro Edge Function | 15 min | Hello World no Edge |
| 3.3 | Middleware na Prática | 20 min | Auth, redirects, A/B testing |
| 3.4 | Limitações do Edge Runtime | 10 min | O que não funciona e por quê |

**Entregável:** Middleware de geolocalização + A/B test

---

### MÓDULO 4: PERFORMANCE E OTIMIZAÇÃO (1h)

> "Faça seu app voar."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 4.1 | Image Optimization Deep Dive | 15 min | next/image, formatos, lazy loading |
| 4.2 | Caching Strategies | 15 min | Cache-Control, stale-while-revalidate |
| 4.3 | Core Web Vitals na Prática | 15 min | LCP, CLS, INP - como melhorar cada um |
| 4.4 | Speed Insights + Analytics | 15 min | Configuração e interpretação |

**Entregável:** Relatório de performance otimizado

---

### MÓDULO 5: CUSTOS E ESCALA (45 min)

> "Entenda o pricing antes de escalar."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 5.1 | Anatomia do Billing | 15 min | Function invocations, bandwidth, builds |
| 5.2 | Fluid Compute Explicado | 15 min | CPU-time billing, concorrência |
| 5.3 | Otimização de Custos | 15 min | Estratégias práticas para reduzir gastos |

**Entregável:** Planilha de estimativa de custos

---

### MÓDULO 6: VERCEL + AI (1h)

> "O futuro do desenvolvimento."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 6.1 | v0 by Vercel | 20 min | Geração de UI com IA na prática |
| 6.2 | AI SDK Fundamentals | 25 min | Streaming, tool calling, providers |
| 6.3 | AI Gateway Overview | 15 min | Multi-provider, routing, observability |

**Entregável:** Chat com AI SDK funcionando

---

### MÓDULO 7: WORKFLOWS PROFISSIONAIS (45 min)

> "Como times de verdade usam Vercel."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 7.1 | Preview Deployments Avançado | 15 min | Comentários, proteção, integração Slack |
| 7.2 | GitHub Actions + Vercel | 15 min | CI/CD customizado |
| 7.3 | Monorepos e Turborepo | 15 min | Configuração e otimização |

**Entregável:** Workflow de PR profissional configurado

---

### MÓDULO 8: VERCEL VS ALTERNATIVAS (30 min)

> "Saber quando NÃO usar Vercel também é importante."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 8.1 | Comparativo Técnico | 15 min | Netlify, Cloudflare, AWS Amplify, Railway |
| 8.2 | Quando Usar Cada Um | 15 min | Cenários práticos de decisão |

**Entregável:** Framework de decisão para escolha de plataforma

---

### MÓDULO 9: PROJETO FINAL (1h)

> "Tudo junto: aplicação completa de produção."

| # | Aula | Dur. | Conteúdo |
|---|------|------|----------|
| 9.1 | Arquitetura do Projeto | 15 min | Next.js + Tailwind + shadcn/ui + AI |
| 9.2 | Implementação com ISR + Edge | 25 min | Features avançadas |
| 9.3 | Deploy e Otimização Final | 15 min | Performance tuning |
| 9.4 | Retrospectiva | 5 min | O que você aprendeu |

**Entregável:** Aplicação completa com todas as features avançadas

---

## 3. MATERIAIS COMPLEMENTARES

### Checklists
- [ ] Checklist de Performance (Core Web Vitals)
- [ ] Checklist de Segurança
- [ ] Checklist de Otimização de Custos
- [ ] Checklist de SEO

### Templates
- Template de vercel.json avançado
- Template de middleware
- Template de AI chat

### Referências
- Matriz SSR vs SSG vs ISR (decisão)
- Comparativo de Plataformas (tabela)
- Glossário Avançado (50 termos)

---

## 4. MÉTRICAS DE SUCESSO

| Métrica | Meta |
|---------|------|
| Taxa de conclusão | > 65% |
| NPS | > 50 |
| Projetos avançados deployados | > 80% |
| Implementação de ISR | > 70% |
| Uso de Edge Functions | > 60% |

---

## 5. RESUMO

| Aspecto | Valor |
|---------|-------|
| **Duração total** | 8-10 horas |
| **Módulos** | 10 (0-9) |
| **Aulas** | ~40 aulas |
| **Projetos práticos** | 2 (intermediário + final) |
| **Idioma** | Português BR |
| **Nível** | Intermediário → Avançado |
| **Pré-requisitos** | Vercel Express ou deploy básico |
| **Preço sugerido** | Premium (R$297-497) |

---

## 6. JORNADA DO ALUNO

```
[Iniciante]
     │
     ▼
┌─────────────────┐
│ VERCEL EXPRESS  │  2-3h • R$97-197
│ Deploy rápido   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ VERCEL          │  8-10h • R$297-497
│ MASTERCLASS     │
└─────────────────┘
     │
     ▼
[Domínio Completo]
```

---

*Proposta gerada pelo Course Architect Agent*
*CreatorOS v2.3*
