# COURSE-BRIEF: Vercel Express

**Versão:** 1.0
**Data:** 2026-01-04
**Status:** Aprovado para Produção

---

## 1. IDENTIFICAÇÃO

| Campo | Valor |
|-------|-------|
| **Nome do Curso** | Vercel Express |
| **Slug** | vercel-express |
| **Tagline** | Seu projeto Next.js no ar em 2 horas |
| **Duração Total** | 2-3 horas |
| **Número de Módulos** | 6 |
| **Número de Aulas** | 24 |
| **Nível** | Iniciante |
| **Idioma** | Português BR |
| **Formato** | Vídeo-aulas + materiais complementares |

---

## 2. ICP (IDEAL CUSTOMER PROFILE)

### 2.1 Perfil Demográfico

| Atributo | Descrição |
|----------|-----------|
| **Idade** | 18-35 anos |
| **Ocupação** | Estudante de programação, dev júnior, autodidata |
| **Renda** | R$2.000-8.000/mês |
| **Localização** | Brasil (foco em capitais e regiões tech) |

### 2.2 Perfil Técnico

| Atributo | Nível |
|----------|-------|
| **HTML/CSS** | Intermediário |
| **JavaScript** | Básico a Intermediário |
| **React/Next.js** | Básico (fez pelo menos um projeto) |
| **Git/GitHub** | Básico (sabe commit, push, pull) |
| **Deploy** | Nenhum ou muito básico |
| **CLI/Terminal** | Básico |

### 2.3 Perfil Psicográfico

**Dores:**
- Projeto funciona local, falha no deploy
- Frustração com erros sem mensagens claras
- Medo de custos surpresa
- Copia configurações sem entender
- Vergonha de pedir ajuda para "coisas básicas"

**Desejos:**
- Ter portfolio online para mostrar
- Conseguir primeiro emprego/freela
- Parecer profissional com domínio próprio
- Entender o que está fazendo (não só copiar)

**Objeções:**
- "Será que vou conseguir?" (síndrome do impostor)
- "E se der erro?" (medo de quebrar algo)
- "Vai custar caro?" (preocupação com bills)

### 2.4 Momento de Compra

O aluno está pronto para comprar quando:
- Acabou curso de React/Next.js e quer colocar projeto no ar
- Tentou fazer deploy sozinho e falhou
- Precisa de portfolio para processo seletivo
- Quer lançar projeto pessoal/side project

---

## 3. PROMESSA E TRANSFORMAÇÃO

### 3.1 Promessa Central

> **"Em 2 horas você vai ter seu projeto Next.js online, com domínio customizado, sem erros e sem drama."**

### 3.2 Transformação

| ANTES | DEPOIS |
|-------|--------|
| Projeto só funciona no localhost | Projeto online acessível por qualquer pessoa |
| Copia config do Stack Overflow | Entende o que cada configuração faz |
| Medo de fazer deploy | Confiança para deployar qualquer projeto |
| Não sabe resolver erros | Sabe diagnosticar e resolver erros comuns |
| URL genérica (.vercel.app) | Domínio profissional customizado |
| Medo de custos | Entende o free tier e como se proteger |

### 3.3 Entregável Tangível

Ao final do curso, o aluno terá:
- Portfolio pessoal funcionando online
- Domínio customizado configurado (ex: seunome.com.br)
- SSL/HTTPS automático
- Conhecimento para deployar qualquer projeto Next.js

---

## 4. ESTRUTURA DETALHADA

### MÓDULO 1: ENTENDENDO VERCEL (20 min)

**Objetivo:** Dar contexto mínimo necessário antes do primeiro deploy.

#### Aula 1.1: O Que é Vercel (e por que usar)
- **Duração:** 8 min
- **Tipo:** Conceitual com analogias
- **Conteúdo:**
  - O que é Vercel em 1 frase
  - Analogia: "Garagem que estaciona seu carro automaticamente"
  - Por que Vercel para Next.js (criadores do framework)
  - O que Vercel NÃO é (não é hospedagem tradicional)
- **Recursos visuais:** Diagrama simplificado CDN → Edge → Serverless

#### Aula 1.2: Criando Conta e Conectando GitHub
- **Duração:** 7 min
- **Tipo:** Screencast passo a passo
- **Conteúdo:**
  - Criar conta (Hobby plan)
  - Conectar GitHub
  - Permissões necessárias (explicar cada uma)
  - Tour rápido pela interface
- **Recursos visuais:** Screenshots anotados

#### Aula 1.3: Tour pelo Dashboard
- **Duração:** 5 min
- **Tipo:** Screencast
- **Conteúdo:**
  - Overview: onde ver seus projetos
  - Deployments: histórico de deploys
  - Settings: configurações importantes
  - Analytics: onde ver métricas (preview)
- **Recursos visuais:** Mapa do dashboard

**Entregável do módulo:** Conta criada + GitHub conectado

---

### MÓDULO 2: PRIMEIRO DEPLOY (30 min)

**Objetivo:** Colocar o primeiro projeto no ar com sucesso.

#### Aula 2.1: Importando Projeto do GitHub
- **Duração:** 8 min
- **Tipo:** Screencast + explicação
- **Conteúdo:**
  - Botão "Add New" → "Project"
  - Selecionar repositório
  - Framework detection automático (mostrar mágica)
  - Configurações de build (quando mexer, quando não mexer)
- **Recursos visuais:** Fluxo visual do import

#### Aula 2.2: Entendendo o Build
- **Duração:** 10 min
- **Tipo:** Conceitual + screencast
- **Conteúdo:**
  - O que é "build" (analogia: receita sendo preparada)
  - Logs de build: como ler
  - Build command vs Output directory
  - Quanto tempo demora (e por quê)
- **Recursos visuais:** Anatomia de um log de build

#### Aula 2.3: Seu Primeiro Deploy
- **Duração:** 7 min
- **Tipo:** Screencast celebratório
- **Conteúdo:**
  - Clicar em Deploy
  - Acompanhar o processo
  - URL gerada (.vercel.app)
  - Testar no navegador
  - **Momento de celebração:** "Seu projeto está online!"
- **Recursos visuais:** Confetti virtual (edição)

#### Aula 2.4: Troubleshooting - Erros do Primeiro Deploy
- **Duração:** 5 min
- **Tipo:** Troubleshooting guide
- **Conteúdo:**
  - Erro: "Build failed" → Verificar package.json
  - Erro: "Framework not detected" → Configurar manualmente
  - Erro: "Module not found" → Verificar imports
  - Dica: sempre ler a ÚLTIMA linha do erro
- **Recursos visuais:** Tabela erro → solução

**Entregável do módulo:** Projeto deployado com URL Vercel

---

### MÓDULO 3: ENVIRONMENT VARIABLES (25 min)

**Objetivo:** Resolver o erro #1 dos iniciantes de uma vez por todas.

#### Aula 3.1: O Que São Env Vars (e por que existem)
- **Duração:** 5 min
- **Tipo:** Conceitual
- **Conteúdo:**
  - Analogia: "Cofre de senhas do seu projeto"
  - Por que não colocar senhas no código
  - Diferença entre .env local e Vercel env vars
  - Quando você precisa de env vars
- **Recursos visuais:** Diagrama cofre

#### Aula 3.2: Client vs Server - A Diferença Crucial
- **Duração:** 8 min
- **Tipo:** Conceitual + demo
- **Conteúdo:**
  - O que roda no servidor vs navegador
  - NEXT_PUBLIC_ = visível para todos
  - Sem prefixo = só servidor
  - Exemplo prático: API key que não aparece no browser
  - **ALERTA:** Nunca colocar secrets em NEXT_PUBLIC_
- **Recursos visuais:** Diagrama client/server com env vars

#### Aula 3.3: Configurando no Vercel Dashboard
- **Duração:** 7 min
- **Tipo:** Screencast
- **Conteúdo:**
  - Settings → Environment Variables
  - Adicionar variável
  - Ambientes: Production, Preview, Development
  - **CRÍTICO:** Precisa fazer redeploy após adicionar
  - Verificar se funcionou
- **Recursos visuais:** Screenshots passo a passo

#### Aula 3.4: Troubleshooting - Env Var Não Funciona
- **Duração:** 5 min
- **Tipo:** Troubleshooting guide
- **Conteúdo:**
  - Checklist de debugging:
    1. Nome está correto? (case sensitive)
    2. Fez redeploy após adicionar?
    3. Está usando NEXT_PUBLIC_ se precisa no client?
    4. Está no ambiente certo? (Production vs Preview)
  - Erro comum: "undefined" no console
- **Recursos visuais:** Checklist visual

**Entregável do módulo:** Projeto com API key funcionando

---

### MÓDULO 4: DOMÍNIO CUSTOMIZADO (30 min)

**Objetivo:** Sair do .vercel.app para domínio profissional.

#### Aula 4.1: DNS Para Humanos
- **Duração:** 8 min
- **Tipo:** Conceitual com analogias
- **Conteúdo:**
  - Analogia: "Lista telefônica da internet"
  - O que é um domínio (nome) vs IP (endereço)
  - Tipos de registro: A, CNAME (só esses dois)
  - O que é propagação (e por que demora)
- **Recursos visuais:** Diagrama DNS simplificado

#### Aula 4.2: Comprando Domínio (Registro.br)
- **Duração:** 5 min
- **Tipo:** Screencast
- **Conteúdo:**
  - Por que Registro.br para .com.br
  - Buscar disponibilidade
  - Processo de compra
  - Alternativas: GoDaddy, Namecheap para .com
- **Recursos visuais:** Screenshots Registro.br

#### Aula 4.3: Configurando DNS no Vercel
- **Duração:** 10 min
- **Tipo:** Screencast detalhado
- **Conteúdo:**
  - Vercel Dashboard → Domains → Add
  - Opção 1: Nameservers Vercel (mais fácil)
  - Opção 2: Registros A/CNAME (mais controle)
  - Passo a passo para Registro.br
  - Verificar configuração
  - Tempo de propagação (até 48h, geralmente minutos)
- **Recursos visuais:** Fluxo visual das duas opções

#### Aula 4.4: Troubleshooting - DNS Não Funciona
- **Duração:** 7 min
- **Tipo:** Troubleshooting guide
- **Conteúdo:**
  - Erro: "Invalid Configuration"
    - Verificar se registros estão corretos
    - Usar whatsmydns.net para checar propagação
  - Erro: "SSL Certificate Pending"
    - Aguardar (geralmente resolve sozinho)
    - Verificar se DNS propagou
  - Erro: "Domain already in use"
    - Remover de outro projeto primeiro
  - Ferramenta: dnschecker.org
- **Recursos visuais:** Tabela erro → solução + ferramentas

**Entregável do módulo:** Projeto com domínio customizado + SSL

---

### MÓDULO 5: EVITANDO PROBLEMAS (20 min)

**Objetivo:** Conhecer os limites e se proteger de surpresas.

#### Aula 5.1: Entendendo o Free Tier
- **Duração:** 8 min
- **Tipo:** Explicação com exemplos
- **Conteúdo:**
  - O que está incluído no Hobby (gratuito):
    - 100GB bandwidth/mês
    - 100 horas de function execution
    - Builds ilimitados
    - 1 membro
  - O que NÃO está incluído:
    - Times (collaboration)
    - Analytics avançado
    - Support prioritário
  - "Meu projeto cabe no free tier?" - exemplos práticos
- **Recursos visuais:** Tabela de limites + calculadora mental

#### Aula 5.2: Proteção Contra Custos Surpresa
- **Duração:** 7 min
- **Tipo:** Screencast + explicação
- **Conteúdo:**
  - O que causa bills inesperadas:
    - Bots/crawlers acessando muito
    - DDoS acidental
    - Function loops
  - Como se proteger:
    - Spend Management (definir limite)
    - Bot protection (ativar)
    - Monitorar Usage no dashboard
- **Recursos visuais:** Screenshots de configuração

#### Aula 5.3: Quando Fazer Upgrade?
- **Duração:** 5 min
- **Tipo:** Guia de decisão
- **Conteúdo:**
  - Sinais de que você precisa do Pro:
    - Bandwidth estourando
    - Precisa de mais de 1 membro no time
    - Precisa de analytics
    - Projeto comercial com SLA
  - Pro vs Enterprise (overview rápido)
  - Dica: Hobby é suficiente para 90% dos portfolios
- **Recursos visuais:** Fluxograma de decisão

**Entregável do módulo:** Spend limit configurado

---

### MÓDULO 6: PROJETO FINAL (30 min)

**Objetivo:** Consolidar todo o aprendizado em um projeto real.

#### Aula 6.1: Estrutura do Portfolio
- **Duração:** 10 min
- **Tipo:** Screencast + código
- **Conteúdo:**
  - Template fornecido: Next.js + Tailwind
  - Estrutura de páginas:
    - Home (sobre mim)
    - Projetos (lista)
    - Contato (formulário simples)
  - Personalização básica (nome, bio, foto)
  - Onde colocar projetos
- **Recursos visuais:** Preview do template

#### Aula 6.2: Deploy Completo
- **Duração:** 10 min
- **Tipo:** Screencast
- **Conteúdo:**
  - Fork do template
  - Personalizar conteúdo
  - Adicionar env var (se tiver API)
  - Deploy
  - Configurar domínio
  - Testar tudo
- **Recursos visuais:** Checklist visual

#### Aula 6.3: Checklist Final
- **Duração:** 5 min
- **Tipo:** Validação
- **Conteúdo:**
  - [ ] Site abre sem erros
  - [ ] Todas as páginas funcionam
  - [ ] Domínio customizado funciona
  - [ ] HTTPS está ativo (cadeado verde)
  - [ ] Env vars funcionando (se aplicável)
  - [ ] Spend limit configurado
- **Recursos visuais:** Checklist interativo

#### Aula 6.4: Próximos Passos
- **Duração:** 5 min
- **Tipo:** Encerramento + upsell
- **Conteúdo:**
  - Parabéns! Recapitular o que aprendeu
  - O que você pode fazer agora:
    - Adicionar mais projetos
    - Conectar com LinkedIn
    - Compartilhar nas redes
  - Preview do Vercel Masterclass
  - Cupom de desconto exclusivo
- **Recursos visuais:** Certificado de conclusão

**Entregável do módulo:** Portfolio funcionando com domínio customizado

---

## 5. MATERIAIS COMPLEMENTARES

### 5.1 Checklists (PDF)

#### Checklist Pré-Deploy
```markdown
## Antes de Fazer Deploy

### No seu código
- [ ] Projeto roda local sem erros (`npm run dev`)
- [ ] Build funciona local (`npm run build`)
- [ ] Não tem secrets hardcoded no código
- [ ] package.json tem scripts "dev" e "build"
- [ ] .gitignore inclui node_modules e .env

### No GitHub
- [ ] Código está atualizado (push feito)
- [ ] Não tem arquivos sensíveis (.env, chaves)

### No Vercel
- [ ] Conta criada
- [ ] GitHub conectado
- [ ] Environment variables adicionadas (se necessário)
```

#### Checklist de Env Vars
```markdown
## Environment Variables - Debug

- [ ] Nome está EXATAMENTE igual no código e no Vercel?
- [ ] Se precisa no cliente, tem NEXT_PUBLIC_ no início?
- [ ] Fez REDEPLOY após adicionar a variável?
- [ ] Está no ambiente certo? (Production/Preview/Development)
- [ ] Não tem espaços extras no valor?
- [ ] Valor não está entre aspas no Vercel? (não precisa)
```

#### Checklist de DNS
```markdown
## Domínio Customizado - Debug

- [ ] Registros DNS configurados corretamente?
- [ ] Propagação completa? (verificar em whatsmydns.net)
- [ ] Domínio adicionado no Vercel Dashboard?
- [ ] SSL/HTTPS está ativo? (aguardar até 24h)
- [ ] Domínio não está em uso em outro projeto?
```

### 5.2 Templates

- **Portfolio Template:** Repositório GitHub com Next.js + Tailwind pré-configurado
- **vercel.json básico:** Configurações comuns comentadas

### 5.3 Referência Rápida

#### Tabela de Erros Comuns

| Erro | Causa Provável | Solução |
|------|----------------|---------|
| Build failed | Erro no código | Verificar logs, rodar build local |
| Module not found | Import incorreto | Verificar caminhos e case |
| Framework not detected | Projeto não reconhecido | Configurar manualmente |
| Env var undefined | Não configurada ou sem redeploy | Adicionar + redeploy |
| Invalid DNS configuration | Registros incorretos | Verificar A/CNAME |
| SSL pending | DNS ainda propagando | Aguardar até 24h |

#### Glossário (10 termos)

| Termo | Definição Simples |
|-------|-------------------|
| **Deploy** | Colocar seu projeto no ar |
| **Build** | Processo de preparar seu código para produção |
| **CDN** | Rede de servidores que entrega seu site rápido |
| **Environment Variable** | Configuração secreta do seu projeto |
| **DNS** | Sistema que traduz nomes (google.com) em endereços IP |
| **SSL/HTTPS** | Criptografia que deixa seu site seguro (cadeado) |
| **Serverless** | Servidor que só liga quando alguém acessa |
| **Preview** | Versão de teste antes de ir para produção |
| **Production** | Versão final, pública, do seu site |
| **Rollback** | Voltar para uma versão anterior |

---

## 6. ESPECIFICAÇÕES TÉCNICAS

### 6.1 Requisitos do Aluno

- Computador com acesso à internet
- Conta no GitHub
- Navegador moderno (Chrome, Firefox, Edge)
- Node.js instalado (para rodar projeto local)
- Editor de código (VS Code recomendado)

### 6.2 Projeto de Exemplo

- **Framework:** Next.js 14+ (App Router)
- **Styling:** Tailwind CSS
- **Repositório:** github.com/academia-lendaria/vercel-express-portfolio

### 6.3 Ferramentas Mencionadas

| Ferramenta | Uso |
|------------|-----|
| Vercel Dashboard | Deploy e configuração |
| GitHub | Versionamento e integração |
| Registro.br | Compra de domínio .com.br |
| whatsmydns.net | Verificar propagação DNS |
| dnschecker.org | Diagnóstico de DNS |

---

## 7. DIRETRIZES DE PRODUÇÃO

### 7.1 Tom e Linguagem

- **Tom:** Amigável, encorajador, sem jargão desnecessário
- **Linguagem:** Português BR coloquial profissional
- **Evitar:** Termos técnicos sem explicação, condescendência
- **Incluir:** Analogias do dia a dia, celebrações de progresso

### 7.2 Formato das Aulas

- **Introdução:** 15-30 segundos contextualizando
- **Conteúdo:** Direto ao ponto, sem enrolação
- **Conclusão:** Recapitular + antecipar próxima aula
- **Duração média:** 5-10 minutos por aula

### 7.3 Recursos Visuais

- Screenshots anotados com setas e destaques
- Diagramas simples (máximo 5 elementos)
- Código com syntax highlighting
- Animações sutis para transições

### 7.4 Acessibilidade

- Legendas em todas as aulas
- Alto contraste em elementos importantes
- Narração clara e pausada
- Materiais em texto para quem prefere ler

---

## 8. MÉTRICAS DE SUCESSO

| Métrica | Meta | Como Medir |
|---------|------|------------|
| Taxa de conclusão | > 80% | Plataforma de curso |
| Tempo médio | < 3h | Analytics |
| Deploy realizado | 100% | Pesquisa pós-curso |
| Domínio configurado | > 70% | Pesquisa pós-curso |
| NPS | > 60 | Pesquisa |
| Conversão para Masterclass | > 15% | Vendas |

---

## 9. CRONOGRAMA DE PRODUÇÃO

| Fase | Duração | Entregáveis |
|------|---------|-------------|
| Pré-produção | 3 dias | Scripts de todas as aulas |
| Gravação | 5 dias | Vídeos brutos |
| Edição | 5 dias | Vídeos finalizados |
| Materiais | 2 dias | PDFs, templates, checklists |
| QA | 2 dias | Revisão completa |
| **Total** | **~17 dias** | Curso pronto para lançamento |

---

## 10. APROVAÇÕES

| Item | Status |
|------|--------|
| Estrutura do curso | Aprovado |
| ICP e transformação | Aprovado |
| Materiais complementares | Aprovado |
| Cronograma | Pendente confirmação |

---

*COURSE-BRIEF gerado pelo Course Architect Agent*
*CreatorOS v2.3*
