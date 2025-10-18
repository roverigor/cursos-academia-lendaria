# Vibecoding - Course Outline Completo

**Instrutor:** José Carlos Amorim
**Duração Total:** 2 horas
**Formato:** Imersão hands-on (80% prática, 20% teoria)
**Nível:** Iniciante absoluto → Criador de MicroSaaS

---

## 📋 Sumário Executivo

Este curso transforma pessoas SEM conhecimento de código em criadores de aplicações web funcionais usando IA generativa (Claude, Bolt.new) como ferramenta principal. Em 2 horas, o aluno cria 3 apps funcionais + 1 MicroSaaS comercializável.

---

## 🎯 Objetivos de Aprendizagem (Bloom's Taxonomy)

**Nível 1 - Lembrar/Compreender:**
- Definir HTML, CSS, JavaScript, API/Backend usando metáforas visuais
- Explicar diferença entre Artifacts (protótipo) e Bolt (produção)

**Nível 2 - Aplicar:**
- Criar formulários interativos com Claude Artifacts
- Publicar landing pages na internet com Bolt.new
- Integrar banco de dados Supabase em apps

**Nível 3 - Criar:**
- Construir MicroSaaS funcional (Hub de GPTs) com autenticação e pagamento
- Desenvolver landing page de vendas otimizada para conversão

---

## 📚 Estrutura Detalhada

### **MÓDULO 1: DO ZERO AO PRIMEIRO APP** (30 min)

**Objetivo do Módulo:** Quebrar barreira mental e conseguir primeira vitória rápida

#### **Lesson 1.1: A Máquina que Você Não Sabia Operar** (10 min)
**Formato:** Teórico + Demo ao vivo

**Conteúdo:**
- Metáfora da Casa FullStack (HTML=tijolos, CSS=pintura, JS=elétrica, API=conexão externa)
- Por que você não precisa saber código (IA como tradutor)
- Demo: Claude gerando código em tempo real

**Entregas:**
- Referência mental clara de frontend vs. backend
- Perda do medo de "não sei programar"

**Recursos:**
- Diagrama visual da Casa FullStack
- Glossário de termos (HTML, CSS, JS, API, Backend)

---

#### **Lesson 1.2: Mapa da Clareza - Seu Primeiro App Funcional** (20 min)
**Formato:** Hands-on total (100% prática)

**Conteúdo:**
- Problema: Formulário chato → Experiência interativa
- Criar formulário no Claude Artifacts
- Integrar API do Claude (Anthropic) para processar texto
- IA separa em categorias + identifica emoções + prioriza urgências

**Entregas:**
- App funcional "Mapa da Clareza"
- Experiência de integrar IA em frontend

**Recursos:**
- Prompt template para Mapa da Clareza
- Guia: Como pegar API key da Anthropic
- Troubleshooting: Erros comuns de API

**Assessment:**
- [ ] Formulário criado e estilizado
- [ ] API key configurada
- [ ] App processa texto e exibe resultado categorizado

---

### **MÓDULO 2: ARSENAL NO-CODE** (60 min)

**Objetivo do Módulo:** Dominar Bolt.new + Supabase + criar 3 apps

#### **Lesson 2.1: Bolt.new - De Protótipo a Produção** (15 min)
**Formato:** Hands-on (prompt → deploy)

**Conteúdo:**
- Diferença Artifacts vs. Bolt (protótipo vs. produção)
- Criar conta Bolt + GitHub
- Prompt completo para landing page
- Iteração de design (cores, textos, seções)
- Deploy na internet (URL real)

**Entregas:**
- Landing page publicada online
- URL compartilhável

**Recursos:**
- Template de prompt completo para Bolt
- Checklist pré-deploy
- Guia de customização de domínio (opcional)

**Assessment:**
- [ ] Landing page criada com Header, Hero, Benefícios, Footer
- [ ] Personalizada com cores/textos customizados
- [ ] Publicada online com URL acessível

---

#### **Lesson 2.2: Supabase - O Armário que Lembra Tudo** (20 min)
**Formato:** Hands-on (Bolt + Supabase)

**Conteúdo:**
- O que é banco de dados (metáfora do armário organizado)
- Criar conta Supabase
- Criar tabela via SQL editor (gerado pelo Bolt)
- Integrar Supabase no Bolt (env variables)
- App salva e busca dados (CRUD básico)

**Entregas:**
- App com persistência de dados
- Dados salvos no Supabase visíveis em tempo real

**Recursos:**
- SQL schema template gerado pelo Bolt
- Guia: Políticas de segurança (RLS) no Supabase
- Troubleshooting: Erros de conexão

**Assessment:**
- [ ] Tabela criada no Supabase
- [ ] API keys configuradas no Bolt
- [ ] App salva dados e exibe lista atualizada

---

#### **Lesson 2.3: Auth - O Porteiro do Seu App** (25 min)
**Formato:** Hands-on (Bolt + Supabase Auth)

**Conteúdo:**
- Por que precisa de login (segurança, personalização, monetização)
- Supabase Auth (porteiro do app)
- Bolt integra autenticação (e-mail/senha)
- Proteger rotas (só usuários logados veem conteúdo)

**Entregas:**
- App com sistema de login funcional
- Tela de cadastro + login + área protegida

**Recursos:**
- Prompt para Bolt adicionar Supabase Auth
- Guia: OAuth (Google, GitHub) - opcional
- Troubleshooting: Erros de autenticação

**Assessment:**
- [ ] Tela de cadastro criada
- [ ] Tela de login funcional
- [ ] Área protegida acessível só após login

---

### **MÓDULO 3: VIRANDO DINHEIRO** (30 min)

**Objetivo do Módulo:** Criar MicroSaaS comercializável

#### **Lesson 3.1: Hub de GPTs - Seu Primeiro MicroSaaS** (20 min)
**Formato:** Hands-on (projeto final)

**Conteúdo:**
- Conceito MicroSaaS (problema pequeno, solução paga)
- Hub de GPTs: conecta assistentes da OpenAI via IDs
- Integrar OpenAI Assistants API
- Adicionar Stripe para pagamento
- Fluxo completo: Cadastro → Escolhe plano → Paga → Acessa GPTs

**Entregas:**
- MicroSaaS funcional pronto para vender
- Sistema de pagamento integrado

**Recursos:**
- Prompt completo: Hub de GPTs com Stripe
- Guia: Criar Assistant na OpenAI
- Guia: Configurar Stripe (modo teste)
- Canvas de MicroSaaS (validação de ideia)

**Assessment:**
- [ ] Hub conecta com assistentes da OpenAI
- [ ] Stripe em modo teste funcional
- [ ] Fluxo completo testado (cadastro → pagamento → acesso)

---

#### **Lesson 3.2: Landing que Vende no Automático** (10 min)
**Formato:** Hands-on (landing otimizada)

**Conteúdo:**
- Estrutura: Isca (lead magnet) → Captura (e-mail) → Análise (pitch)
- Criar landing page no Bolt para o MicroSaaS
- Integrar formulário de captura (salva no Supabase)
- Automação: E-mail de boas-vindas (via n8n ou Zapier - opcional)

**Entregas:**
- Landing page de vendas funcional
- Funil de captura ativo

**Recursos:**
- Template de landing page de alta conversão
- Copywriting: Headlines que vendem
- Biblioteca de prompts para landing pages

**Assessment:**
- [ ] Landing page criada com estrutura Isca → Captura → Pitch
- [ ] Formulário salva leads no Supabase
- [ ] CTA claro para o MicroSaaS

---

## 📊 Progressão de Complexidade

| Lesson | Ferramenta | Nível de Complexidade | O Que Constrói |
|--------|------------|----------------------|----------------|
| 1.1 | Claude Artifacts | ★☆☆☆☆ | Conceitos (metáfora) |
| 1.2 | Claude + API | ★★☆☆☆ | App com IA |
| 2.1 | Bolt | ★★★☆☆ | Site publicado |
| 2.2 | Bolt + Supabase | ★★★★☆ | App com banco de dados |
| 2.3 | Bolt + Supabase Auth | ★★★★☆ | App com login |
| 3.1 | Bolt + Supabase + Stripe + OpenAI | ★★★★★ | MicroSaaS vendável |
| 3.2 | Bolt (landing otimizada) | ★★★☆☆ | Funil de vendas |

---

## 🎯 Resultados Concretos Garantidos

Ao final do curso, o aluno terá:

### **Apps Criados:**
1. ✅ Mapa da Clareza (Artifacts + IA)
2. ✅ Landing page publicada (Bolt)
3. ✅ App com banco de dados (Bolt + Supabase)
4. ✅ App com login (Bolt + Supabase Auth)
5. ✅ MicroSaaS Hub de GPTs (Bolt + Supabase + Stripe + OpenAI)
6. ✅ Landing page de vendas (Bolt)

### **Habilidades Adquiridas:**
- Criar interfaces visuais com prompts
- Integrar APIs (Anthropic, OpenAI, Stripe)
- Configurar bancos de dados (Supabase)
- Publicar apps online com URL real
- Iterar com IAs para melhorar código

### **Potencial de Monetização:**
- **Freelancer:** R$ 1.000 - R$ 3.500 por projeto
- **MicroSaaS:** R$ 97 - R$ 497/mês por cliente recorrente
- **Produtos Digitais:** Vender templates/cursos sobre o que aprendeu

---

## 🛠️ Stack Tecnológico

**Ferramentas Principais:**
- **Claude.ai** (Artifacts + API) - Prototipagem + IA
- **Bolt.new** - Criação de apps completos
- **Supabase** - Banco de dados + Auth
- **GitHub** - Versionamento (necessário pro Bolt)

**APIs Integradas:**
- Anthropic (Claude)
- OpenAI (GPT-4 + Assistants)
- Stripe (Pagamentos)

**Frameworks (gerados automaticamente pelo Bolt):**
- Next.js (React framework)
- TypeScript
- Tailwind CSS

---

## 📁 Recursos Complementares

### **Templates Prontos:**
- `resources/biblioteca-prompts.md` - 50+ prompts testados
- `resources/template-microsaas-canvas.md` - Canvas de validação de ideia
- `resources/checklist-setup-ferramentas.md` - Setup passo a passo

### **Troubleshooting:**
- `resources/troubleshooting-comum.md` - Soluções para 20+ erros comuns

### **Assessments:**
- `assessments/quiz-modulo-1.yaml` - Verificação de aprendizado Módulo 1
- `assessments/quiz-modulo-2.yaml` - Verificação de aprendizado Módulo 2
- `assessments/projeto-final-microsaas.md` - Checklist de entrega final

---

## 🎓 Certificação

**Critérios para Certificado:**
- ✅ Completar 6 lessons (100%)
- ✅ Criar e submeter 3 apps obrigatórios:
  1. Mapa da Clareza (Artifacts + IA)
  2. App com Auth (Bolt + Supabase)
  3. MicroSaaS Hub de GPTs (projeto final)

**Formato de Submissão:**
- URL do app publicado
- Print da tela funcional
- Breve descrição (50-100 palavras) do que construiu

---

## 🚀 Próximos Passos Após o Curso

**Nível Iniciante → Intermediário:**
- Adicionar analytics (Google Analytics, Plausible)
- Integrar e-mail marketing (n8n, Zapier)
- Criar dashboard de admin

**Nível Intermediário → Avançado:**
- Deploy customizado (Vercel, Netlify)
- Otimização SEO
- Testes A/B de landing pages

**Monetização:**
- Criar portfólio com os 3 apps
- Oferecer serviço de criação de apps no-code
- Lançar próprio MicroSaaS

---

*Course Outline v1.0 | Vibecoding | José Carlos Amorim*
