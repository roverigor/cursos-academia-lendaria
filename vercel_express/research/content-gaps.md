# Content Gaps: O Que Está Faltando no Mercado

**Data:** 2026-01-03
**Curso:** Vercel Express (2-4h)
**ICP:** Dev Iniciante (HTML/CSS/JS → deploy moderno)

---

## 1. Gaps Críticos Identificados

### Gap #1: Tutorial "Do Zero ao Deploy" em PT-BR

**Problema:** Todos os recursos assumem que você já sabe Git, CLI, e conceitos de deploy.

**O que falta:**
- Explicação visual de como Vercel funciona por baixo
- Passo a passo da conta → primeiro deploy
- Erros comuns do primeiro deploy e como resolver

**Impacto:** Alto - É a primeira barreira de entrada

---

### Gap #2: Environment Variables para Iniciantes

**Problema:** A documentação explica O QUE são env vars, não COMO usá-las na prática.

**O que falta:**
- Diferença clara entre `NEXT_PUBLIC_` e variáveis server-side
- Por que precisa fazer redeploy após mudar
- Como debugar quando não funciona
- Exemplos práticos com APIs reais (Stripe, Firebase, etc.)

**Impacto:** Alto - É a dúvida #1 nos fóruns

---

### Gap #3: Configuração de Domínio Customizado

**Problema:** DNS é confuso para quem nunca configurou.

**O que falta:**
- Explicação visual de como DNS funciona
- Passo a passo para registradores populares (Registro.br, GoDaddy, Namecheap)
- Troubleshooting de erros comuns (Invalid Configuration, SSL pending)
- Quanto tempo demora propagação e como verificar

**Impacto:** Médio-Alto - Segunda maior frustração

---

### Gap #4: Entendendo os Limites e Custos

**Problema:** Usuários descobrem limites apenas quando estouram.

**O que falta:**
- Explicação clara do free tier (o que está incluído, o que não está)
- Como monitorar uso antes de estourar
- Proteção contra bots e DDoS (causa de bills surpresa)
- Quando faz sentido ir para Pro vs continuar no Hobby

**Impacto:** Médio - Causa abandono e frustração

---

### Gap #5: Debugging de Erros de Build

**Problema:** Logs do Vercel não são amigáveis para iniciantes.

**O que falta:**
- Como ler logs de build
- Erros mais comuns e soluções
- Diferença entre erro de build vs runtime
- Como testar localmente antes de deploy (`vercel dev`)

**Impacto:** Médio-Alto - Causa "50 erros seguidos"

---

### Gap #6: SSR vs SSG vs ISR Simplificado

**Problema:** Documentação Next.js/Vercel assume conhecimento prévio.

**O que falta:**
- Explicação visual/analogia simples
- Quando usar cada um
- Implicações de custo (serverless vs static)
- Exemplos práticos de cada cenário

**Impacto:** Médio - Confusão conceitual

---

### Gap #7: Preview Deployments na Prática

**Problema:** Feature poderosa mas pouco explicada para iniciantes.

**O que falta:**
- O que são preview deployments
- Como usar para testar antes de produção
- Como compartilhar com clientes/stakeholders
- Proteção de preview deployments (senha, etc.)

**Impacto:** Baixo-Médio - Feature subutilizada

---

### Gap #8: Integração com GitHub Actions

**Problema:** Usuários não sabem que podem customizar CI/CD.

**O que falta:**
- Quando usar GitHub Actions vs Vercel nativo
- Setup básico de workflow
- Testes automáticos antes de deploy
- Casos de uso práticos

**Impacto:** Baixo - Mais avançado, mas relevante

---

## 2. Gaps por Categoria

### Fundamentos (Mais Críticos)

| Gap | Prioridade | Cursos Existentes Cobrem? |
|-----|------------|---------------------------|
| Como Vercel funciona | P0 | Não (assumem conhecimento) |
| Primeiro deploy | P0 | Superficialmente |
| Env vars na prática | P0 | Não adequadamente |
| Domínio customizado | P1 | Não (tutorial separado) |
| Debugging erros | P1 | Não |

### Intermediário (Importantes)

| Gap | Prioridade | Cursos Existentes Cobrem? |
|-----|------------|---------------------------|
| Limites e custos | P1 | Não |
| SSR/SSG/ISR | P1 | Parcialmente |
| Preview deployments | P2 | Não |
| Vercel CLI | P2 | Não |

### Avançado (Para Curso Futuro)

| Gap | Prioridade | Cursos Existentes Cobrem? |
|-----|------------|---------------------------|
| GitHub Actions + Vercel | P3 | Não |
| Edge Functions | P3 | Cursos específicos existem |
| Monorepos | P3 | Documentação cobre |
| AI SDK | P3 | Cursos específicos existem |

---

## 3. Mapeamento Gap → Módulo do Curso

### Estrutura Proposta (2-4h)

```
Módulo 1: Fundamentos (45 min)
├── O que é Vercel e por que usar
├── Como funciona: CDN, Serverless, Edge
├── Vercel vs alternativas (quando usar cada)
└── Criando conta e explorando dashboard

Módulo 2: Primeiro Deploy (45 min)
├── Conectando repositório GitHub
├── Framework detection e configuração
├── Entendendo logs de build
├── Troubleshooting: Erros comuns do primeiro deploy
└── Celebrando: Seu projeto está online!

Módulo 3: Configuração Essencial (45 min)
├── Environment variables (client vs server)
├── Domínio customizado passo a passo
├── DNS para iniciantes (com exemplos visuais)
├── SSL e HTTPS automático
└── Troubleshooting: DNS não funciona

Módulo 4: Indo Além (45 min)
├── Preview deployments na prática
├── Entendendo limites e custos
├── Proteção contra bots/DDoS
├── Monitoramento: Speed Insights e Analytics
└── Quando fazer upgrade para Pro?
```

---

## 4. Conteúdo Diferencial Proposto

### O que NENHUM curso atual oferece:

1. **Seção "Erros Comuns"** em cada módulo
   - Lista dos 5 erros mais frequentes
   - Mensagem de erro → Solução
   - Screenshots reais

2. **Analogias Visuais**
   - CDN como "cópias do seu site pelo mundo"
   - Serverless como "código que só liga quando precisa"
   - DNS como "lista telefônica da internet"

3. **Projeto Prático Real**
   - Não um TODO app genérico
   - Portfolio pessoal com domínio customizado
   - Integração com API real (clima, quotes, etc.)

4. **Checklist de Deploy**
   - PDF/Notion template
   - "Antes de fazer deploy, verifique..."
   - Evita 80% dos erros comuns

5. **Comparativo de Custos**
   - Calculadora simples: "Meu projeto cabe no free tier?"
   - Cenários reais com números

---

## 5. Priorização Final

### Must Have (Crítico para o curso)

- [ ] Fundamentos visuais de como Vercel funciona
- [ ] Passo a passo do primeiro deploy
- [ ] Environment variables explicadas corretamente
- [ ] Domínio customizado com DNS simplificado
- [ ] Seção de troubleshooting por módulo

### Should Have (Diferencial competitivo)

- [ ] Preview deployments
- [ ] Limites e custos explicados
- [ ] Projeto prático (portfolio)
- [ ] Checklist de deploy

### Nice to Have (Se sobrar tempo)

- [ ] GitHub Actions básico
- [ ] Vercel CLI
- [ ] Speed Insights setup

---

*Relatório gerado pelo Course Architect Agent*
*CreatorOS v2.3*
