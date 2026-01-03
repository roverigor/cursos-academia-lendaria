# Análise de Mercado: Cursos de Vercel

**Data:** 2026-01-03
**Curso:** Vercel Express (2-4h)
**ICP:** Dev Iniciante (HTML/CSS/JS → deploy moderno)
**Idioma:** Português BR

---

## 1. Panorama Competitivo

### 1.1 Cursos Existentes na Udemy

| Curso | Foco | Preço | Idioma | Limitações |
|-------|------|-------|--------|------------|
| Next.JS + Sanity CMS + Vercel | Blog serverless | ~$50 | EN | Focado em CMS, não em Vercel |
| Vercel AI SDK + NextJS | IA frontend | ~$30 | PT-BR | Nicho muito específico (IA) |
| Vibe Coding with v0 | No-code MVP | ~$40 | EN | Não ensina deploy real |
| React + Tailwind (inclui Vercel) | React intro | Grátis | PT-BR | Deploy é só 1 módulo |
| Full-Stack AI SaaS (AWS + Vercel) | SaaS completo | ~$60 | EN | Muito avançado |

### 1.2 Conteúdo no YouTube (PT-BR)

- **Rocketseat**: Vídeos sobre Next.js mencionam Vercel brevemente
- **Filipe Deschamps**: Tutoriais de deploy rápido, superficiais
- **DevSuperior**: Foco em Spring Boot, pouco frontend
- **Código Fonte TV**: Explicações conceituais, pouco hands-on

**Problema:** Não existe curso dedicado a Vercel em PT-BR. O que existe são menções superficiais em cursos de Next.js ou React.

### 1.3 Documentação Oficial

A documentação da Vercel é **excelente e completa**, cobrindo:
- 15+ categorias principais
- Guias para 20+ frameworks
- Tutoriais de integração com IA, CMS, e-commerce

**Problema para iniciantes:** A documentação assume conhecimento prévio de CLI, Git, e conceitos de deploy.

---

## 2. Dúvidas Mais Recorrentes (Fóruns/Comunidades)

### 2.1 Top 10 Dúvidas de Iniciantes

| # | Dúvida | Frequência | Fonte |
|---|--------|------------|-------|
| 1 | Environment variables não funcionando | Alta | Stack Overflow, Vercel Community |
| 2 | Erro de build sem logs claros | Alta | Reddit, Vercel Community |
| 3 | Deploy funciona local mas falha no Vercel | Alta | GitHub Issues |
| 4 | Configurar domínio customizado | Média-Alta | Vercel Community |
| 5 | Diferença entre SSR, SSG, ISR | Média | Reddit r/nextjs |
| 6 | Custos inesperados / limites do free tier | Média | Reddit, Medium |
| 7 | CORS errors em API routes | Média | Stack Overflow |
| 8 | GitHub integration parou de funcionar | Média | Vercel Community |
| 9 | Serverless function timeout | Média | Stack Overflow |
| 10 | DNS propagation / SSL não funciona | Baixa-Média | Vercel Community |

### 2.2 Frustrações Específicas de Iniciantes

**"Banging my head against the wall"** - Usuário relatando primeira experiência

**Problemas principais:**
1. **Framework detection falha** - Vercel não detecta o framework correto
2. **50 erros seguidos** - Tentando deploy + domínio customizado
3. **Logs não ajudam** - "Deployment failed" sem detalhes
4. **NEXT_PUBLIC_ não explicado** - Variáveis client-side vs server-side
5. **Redeploy obrigatório após mudar env vars** - Não documentado de forma clara

---

## 3. Comparativo: Vercel vs Concorrentes

| Critério | Vercel | Netlify | Railway |
|----------|--------|---------|---------|
| Melhor para | Next.js/React | Static/JAMstack | Full-stack + DB |
| Free tier | Generoso, sem overages | Generoso, sem overages | Usage-based |
| DX (Developer Experience) | Excelente | Muito bom | Bom |
| Integração Git | Automática | Automática | Automática |
| Databases | Não nativo | Não nativo | PostgreSQL, MySQL |
| Edge Functions | Sim | Sim | Não |
| Preço Pro | $20/user/mês | $19/user/mês | ~$5-20/mês (uso) |

**Por que Vercel para iniciantes?**
- Zero config para Next.js
- Preview deployments automáticos
- Interface mais intuitiva
- Maior comunidade/recursos

---

## 4. Segmento de Mercado

### 4.1 Perfil do Aluno Típico

- **Idade:** 20-35 anos
- **Background:** Conhece HTML/CSS/JS básico, talvez React
- **Motivação:** Quer colocar projetos no ar rapidamente
- **Pain points:**
  - "Funciona na minha máquina" mas não em produção
  - Configurar servidor é intimidador
  - Não entende CI/CD
  - Medo de custos surpresa

### 4.2 Jornada do Iniciante

```
1. Faz curso de React/Next.js
2. Tem projeto local funcionando
3. Quer mostrar para o mundo
4. Pesquisa "como fazer deploy Next.js"
5. Encontra Vercel
6. Faz primeiro deploy (sucesso!)
7. Tenta configurar domínio → PROBLEMA
8. Tenta usar env vars → PROBLEMA
9. Desiste ou busca ajuda
```

**Gap de mercado:** Falta um curso que guie do passo 5 ao 10 com clareza.

---

## 5. Tendências 2024-2025

### 5.1 Vercel está investindo em:

1. **AI-first development** - v0, AI SDK, MCP
2. **Edge computing** - Edge Functions, Edge Config
3. **Observability** - Speed Insights, Web Analytics
4. **Enterprise features** - RBAC, SSO, Firewall

### 5.2 O que iniciantes precisam aprender:

1. **Fundamentos** - Como Vercel funciona (CDN, serverless, edge)
2. **Deploy básico** - Git → Vercel → Produção
3. **Configuração** - Env vars, domínios, DNS
4. **Debugging** - Logs, erros comuns, troubleshooting
5. **Otimização** - Custos, performance, limites

---

## 6. Conclusões

### 6.1 Oportunidade de Mercado

**Score: 9/10** - Existe demanda clara sem oferta adequada.

- **Não existe curso dedicado a Vercel em PT-BR**
- Cursos existentes são muito avançados ou superficiais
- Documentação oficial é boa mas não didática para iniciantes
- Comunidade BR está crescendo rapidamente

### 6.2 Posicionamento Recomendado

> "O único curso em português que ensina Vercel do zero, focando nos problemas reais que iniciantes enfrentam."

### 6.3 Diferenciais Competitivos

1. **Idioma nativo** - Português BR, não legendas
2. **Foco em problemas reais** - Baseado em dúvidas de fóruns
3. **Prático e rápido** - 2-4h, não curso de 20h
4. **Troubleshooting incluído** - Seção dedicada a erros comuns
5. **Atualizado 2025** - Cobre AI SDK, v0, Edge Functions

---

*Relatório gerado pelo Course Architect Agent*
*CreatorOS v2.3*
