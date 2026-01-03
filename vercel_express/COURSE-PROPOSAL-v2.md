# Proposta de Curso: Vercel Masterclass

**Versão:** 2.0 (Aprofundada)
**Data:** 2026-01-03
**Duração:** 8-12 horas
**ICP:** Desenvolvedores iniciantes/intermediários

---

## 1. VISÃO DO CURSO

### 1.1 Promessa

> **"Domine Vercel do fundamento à produção: entenda a filosofia, os recursos e as práticas que fazem da Vercel a plataforma preferida de milhões de desenvolvedores."**

### 1.2 Por Que Este Curso é Diferente

| Cursos existentes | Este curso |
|-------------------|------------|
| "Clica aqui, clica ali" | Explica o PORQUÊ antes do COMO |
| Foco só em deploy | Cobre história, filosofia, arquitetura |
| Superficial | Aprofunda em cada recurso |
| Em inglês | Português BR nativo |
| Desatualizado | 2025 (v0, AI SDK, Fluid Compute) |

### 1.3 Transformação do Aluno

**ANTES:**
- "Vercel é só pra fazer deploy"
- Copia config do Stack Overflow sem entender
- Não sabe quando usar SSR vs SSG vs ISR
- Medo de custos
- Não aproveita Edge Functions

**DEPOIS:**
- Entende a filosofia e arquitetura
- Toma decisões técnicas informadas
- Otimiza performance e custos
- Usa recursos avançados (ISR, Edge, Preview)
- Sabe quando Vercel é a escolha certa (e quando não é)

---

## 2. ESTRUTURA DO CURSO

### MÓDULO 0: A HISTÓRIA QUE VOCÊ PRECISA CONHECER (45 min)

> "Para usar bem uma ferramenta, você precisa entender por que ela foi criada."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 0.1 | O Garoto de Buenos Aires | 10 min | Guillermo Rauch: de Lanús a San Francisco |
| 0.2 | De LearnBoost a Vercel | 10 min | Jornada: Socket.io → LearnBoost → ZEIT → Vercel |
| 0.3 | Por Que Next.js Existe | 10 min | O problema do React SPA e a solução SSR |
| 0.4 | A Filosofia do Frontend Cloud | 15 min | DX, Zero Config, Edge-First, Preview-Driven |

**Entregável:** Quiz de compreensão

---

### MÓDULO 1: FUNDAMENTOS - COMO VERCEL FUNCIONA (1h)

> "Antes de usar, entenda o que acontece por baixo dos panos."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 1.1 | Arquitetura Global | 15 min | CDN → Edge → Serverless (diagrama visual) |
| 1.2 | O Que é Serverless de Verdade | 15 min | Cold starts, containers, billing |
| 1.3 | Edge vs Serverless | 15 min | Quando usar cada um |
| 1.4 | Vercel vs Concorrentes | 15 min | Netlify, Cloudflare, AWS Amplify, Railway |

**Entregável:** Mapa mental de arquitetura

---

### MÓDULO 2: PRIMEIRO DEPLOY - DO ZERO À PRODUÇÃO (1h)

> "Seu primeiro projeto no ar em 15 minutos."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 2.1 | Criando Conta e Conectando GitHub | 10 min | Passo a passo visual |
| 2.2 | Primeiro Deploy (React/Next.js) | 15 min | Framework detection, build, deploy |
| 2.3 | Entendendo o Dashboard | 10 min | Deployments, logs, domains, settings |
| 2.4 | Vercel CLI | 15 min | `vercel`, `vercel dev`, `vercel env pull` |
| 2.5 | Troubleshooting: Erros Comuns | 10 min | Build failed, framework not detected |

**Entregável:** Projeto deployado + CLI configurado

---

### MÓDULO 3: CONFIGURAÇÃO ESSENCIAL (1h)

> "As configurações que todo desenvolvedor precisa dominar."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 3.1 | Environment Variables | 20 min | Client vs Server, NEXT_PUBLIC_, redeploy |
| 3.2 | Domínio Customizado | 15 min | DNS explicado, Registro.br, propagação |
| 3.3 | vercel.json Deep Dive | 15 min | Rewrites, redirects, headers, functions |
| 3.4 | Troubleshooting: DNS e SSL | 10 min | Invalid config, SSL pending, propagação |

**Entregável:** Projeto com domínio customizado + env vars

---

### MÓDULO 4: PREVIEW DEPLOYMENTS E COLABORAÇÃO (45 min)

> "O recurso favorito dos times de desenvolvimento."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 4.1 | Como Preview Deployments Funcionam | 15 min | Branch → Preview URL automática |
| 4.2 | Comentários e Colaboração | 15 min | Feedback visual, integração Slack |
| 4.3 | Proteção de Previews | 15 min | Senha, Vercel Auth, domínios privados |

**Entregável:** Workflow de PR com preview + comentários

---

### MÓDULO 5: RENDERIZAÇÃO - SSR, SSG, ISR (1h 15min)

> "Entenda de uma vez por todas quando usar cada tipo."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 5.1 | O Problema do React SPA | 15 min | CSR e suas limitações (SEO, performance) |
| 5.2 | SSG - Static Site Generation | 15 min | Build time, quando usar, getStaticProps |
| 5.3 | SSR - Server-Side Rendering | 15 min | Request time, quando usar, getServerSideProps |
| 5.4 | ISR - O Melhor dos Dois Mundos | 20 min | Stale-while-revalidate, revalidação |
| 5.5 | Matriz de Decisão | 10 min | Fluxograma: qual usar em cada cenário |

**Entregável:** App com SSG + ISR implementado

---

### MÓDULO 6: EDGE FUNCTIONS E MIDDLEWARE (1h)

> "Código que roda na borda da rede."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 6.1 | O Que é Edge Computing | 15 min | Latência, distribuição global |
| 6.2 | Edge Functions na Prática | 20 min | Primeiro edge function, casos de uso |
| 6.3 | Middleware | 15 min | Request interception, auth, redirects |
| 6.4 | Limitações do Edge Runtime | 10 min | Node.js APIs não suportadas, tamanho |

**Entregável:** Middleware de geolocalização funcionando

---

### MÓDULO 7: PERFORMANCE E OTIMIZAÇÃO (1h)

> "Faça seu app voar."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 7.1 | Image Optimization | 15 min | next/image, formatos, lazy loading |
| 7.2 | Caching e CDN | 15 min | Cache-Control, stale-while-revalidate |
| 7.3 | Speed Insights | 15 min | Core Web Vitals, LCP, CLS, INP |
| 7.4 | Web Analytics | 15 min | Métricas, eventos, privacy |

**Entregável:** Relatório de performance do projeto

---

### MÓDULO 8: CUSTOS E LIMITES (45 min)

> "Entenda o pricing antes de levar sustos."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 8.1 | Entendendo o Free Tier | 15 min | O que está incluído, limites |
| 8.2 | Fluid Compute e Billing | 15 min | CPU-time billing, como otimizar |
| 8.3 | Proteção Contra Custos Surpresa | 15 min | Spend limits, bot protection, DDoS |

**Entregável:** Checklist de otimização de custos

---

### MÓDULO 9: VERCEL + AI (45 min)

> "O futuro do desenvolvimento."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 9.1 | v0 by Vercel | 15 min | Geração de UI com IA |
| 9.2 | AI SDK | 20 min | Streaming, tool calling, providers |
| 9.3 | AI Gateway (Overview) | 10 min | Multi-provider, routing, observability |

**Entregável:** Componente gerado com v0 + chat com AI SDK

---

### MÓDULO 10: PROJETO FINAL (1h)

> "Tudo junto: portfolio profissional."

**Aulas:**

| # | Aula | Duração | Conteúdo |
|---|------|---------|----------|
| 10.1 | Estrutura do Projeto | 15 min | Next.js + Tailwind + shadcn/ui |
| 10.2 | Páginas e Componentes | 20 min | Home, Projetos, Sobre, Contato |
| 10.3 | Deploy e Domínio | 15 min | Configuração completa |
| 10.4 | Validação Final | 10 min | Checklist de qualidade |

**Entregável:** Portfolio funcionando com domínio customizado

---

## 3. MATERIAIS COMPLEMENTARES

### 3.1 Checklists

- [ ] Checklist Pré-Deploy
- [ ] Checklist de Segurança
- [ ] Checklist de Performance
- [ ] Checklist de SEO

### 3.2 Templates

- Template de vercel.json completo
- Template de middleware
- Template de portfolio

### 3.3 Referências Rápidas

- Matriz SSR vs SSG vs ISR
- Comparativo de Concorrentes
- Glossário de Termos

---

## 4. MÉTRICAS DE SUCESSO

| Métrica | Meta |
|---------|------|
| Taxa de conclusão | > 70% |
| NPS | > 50 |
| Projetos deployados | 100% dos alunos |
| Domínio customizado configurado | > 80% |

---

## 5. RESUMO

| Aspecto | Valor |
|---------|-------|
| **Duração total** | 8-12 horas |
| **Módulos** | 10 + bônus |
| **Aulas** | ~45 aulas |
| **Projetos práticos** | 5 mini + 1 final |
| **Idioma** | Português BR |
| **Nível** | Iniciante → Intermediário |
| **Pré-requisitos** | HTML/CSS/JS, Git básico, React básico |

---

## 6. PRÓXIMOS PASSOS

1. **Aprovar estrutura** - Esta proposta
2. **Criar COURSE-BRIEF** - Detalhamento completo
3. **Gerar curriculum.yaml** - Metadados estruturados
4. **Produzir aulas** - Módulo por módulo
5. **Validar** - QA pedagógico

---

**Aprovado?** Se sim, posso gerar o COURSE-BRIEF detalhado e começar a produção das aulas.

---

*Proposta gerada pelo Course Architect Agent*
*CreatorOS v2.3*
