# Projeto Final: Claude Code Expert

**Objetivo:** Construir 1 sistema completo end-to-end aplicando todo conhecimento do curso

**Prazo sugerido:** 7-14 dias

**Entrega:** Repositório GitHub + vídeo demo (5-10min)

---

## 🎯 OPÇÕES DE PROJETO

Escolha 1 das 3 opções abaixo (ou propor customizado):

### OPÇÃO A: CRM Automatizado (Recomendado)

**Descrição:** Pipeline completo de gestão de leads

**Módulos obrigatórios:**
1. **Coleta multi-fonte:**
   - Scraping LinkedIn (busca por ICP)
   - Webhook Typeform/Google Forms
   - Parser de emails (inbox)

2. **Enriquecimento:**
   - API Clearbit OU Hunter.io
   - Scraping complementar LinkedIn profiles
   - Parsing com Claude (extrair cargo/empresa de texto)

3. **Lead Scoring:**
   - Algoritmo ponderado (cargo, empresa, fonte, etc)
   - Classificação HOT/WARM/COLD

4. **Ação automática:**
   - HOT: Notificação Slack + email personalizado
   - WARM: Sequência nurturing 3-5 emails
   - COLD: Newsletter semanal

**Diferenciais (bônus):**
- Dashboard ao vivo (Chart.js)
- Scheduler (cron ou Python schedule)
- Métricas (taxa conversão, ROI)

---

### OPÇÃO B: Monitor de Concorrentes

**Descrição:** Sistema de inteligência competitiva 24/7

**Módulos obrigatórios:**
1. **Monitor de Preços:**
   - Scraping páginas pricing de 3+ concorrentes
   - Detectar mudanças (diff algorithm)
   - Alertas Slack se preço mudar

2. **Monitor de Conteúdo:**
   - Scraping blog (RSS/Atom feeds)
   - Extrair temas/keywords frequentes
   - Análise de frequência posting

3. **Monitor de Vagas:**
   - Scraping LinkedIn Jobs
   - Categorizar por área (Eng, Sales, Marketing)
   - Alertar se expansão significativa (+200%)

4. **Dashboard consolidado:**
   - Visualizar todos monitores
   - Histórico de mudanças
   - Alertas centralizados

**Diferenciais (bônus):**
- Monitor de reviews (G2, Capterra)
- Sentiment analysis (positivo/negativo)
- Relatório semanal executivo automático

---

### OPÇÃO C: Proposta Customizada

**Requisitos mínimos:**
1. Usar 4+ skills do curso:
   - Scraping OU API calls
   - Batch processing OU scheduler
   - Dashboard OU email automation
   - Error handling robusto

2. Resolver problema REAL seu:
   - Economizar mínimo 5h/semana
   - ROI calculável
   - Não ser tutorial genérico

**Exemplos válidos:**
- Sistema de backup automatizado multi-cloud
- Agregador de métricas de múltiplas fontes
- Automação de relatórios financeiros (PDFs → Excel consolidado)
- Monitor de uptime + análise de logs

**Enviar proposta para aprovação ANTES de começar:**
- Título e descrição (1 parágrafo)
- Problema que resolve
- Skills do curso que usa
- ROI estimado

---

## 📝 CRITÉRIOS DE AVALIAÇÃO

### 1. Funcionalidade (40 pontos)

- [ ] Sistema funciona end-to-end (10pts)
- [ ] Trata erros gracefully (não trava) (10pts)
- [ ] Usa 4+ skills do curso (10pts)
- [ ] Tem scheduler OU API OU dashboard (10pts)

### 2. Qualidade de Código (30 pontos)

- [ ] Error handling robusto (try/except) (10pts)
- [ ] Logging estruturado (não print()) (5pts)
- [ ] Secrets em .env (não hardcoded) (5pts)
- [ ] Código comentado/docstrings (5pts)
- [ ] .gitignore correto (5pts)

### 3. Documentação (20 pontos)

- [ ] README completo (uso template do curso) (10pts)
- [ ] Instruções de setup claras (5pts)
- [ ] Seção troubleshooting (3pts)
- [ ] Screenshots/demo (2pts)

### 4. Deploy/Produção (10 pontos)

- [ ] Script agendado (cron OU scheduler) (5pts)
- [ ] Métricas/logs de execução (3pts)
- [ ] Runbook operacional (2pts)

**Total: 100 pontos**

**Aprovação:** ≥ 70 pontos

---

## 📦 ESTRUTURA DE ENTREGA

### Repositório GitHub

```
seu-projeto/
├── README.md                    # OBRIGATÓRIO
├── .env.example                 # OBRIGATÓRIO
├── .gitignore                   # OBRIGATÓRIO
├── requirements.txt             # OBRIGATÓRIO (Python)
├── main.py ou index.js          # Script principal
├── config.py                    # Configurações
│
├── src/                         # Código fonte
│   ├── coleta.py
│   ├── processamento.py
│   └── notificacao.py
│
├── data/                        # Inputs (gitignored se sensível)
├── output/                      # Resultados (gitignored)
├── logs/                        # Logs (gitignored)
│
├── tests/                       # Testes (opcional mas recomendado)
│   └── test_main.py
│
└── docs/                        # Documentação adicional
    ├── RUNBOOK.md
    └── ARCHITECTURE.md
```

---

### Vídeo Demo (5-10min)

**Estrutura:**

1. **Intro (1min):**
   - Seu nome
   - Qual projeto escolheu
   - Problema que resolve

2. **Demo ao vivo (5min):**
   - Rodar script
   - Mostrar outputs
   - Mostrar dashboard/alertas (se tiver)

3. **Código destacado (2min):**
   - Mostrar 2-3 trechos de código interessantes
   - Explicar decisões técnicas

4. **ROI e próximos passos (1min):**
   - ROI calculado (tempo economizado)
   - O que faria diferente
   - Expansões futuras

**Upload:** YouTube (unlisted) ou Loom

---

## 🚀 CHECKLIST ANTES DE ENTREGAR

### Funcionalidade
- [ ] Script executa sem erros
- [ ] Testei com inputs válidos
- [ ] Testei com inputs inválidos (erro tratado)
- [ ] Testei com API offline (erro tratado)

### Código
- [ ] Todos secrets em .env
- [ ] .env está no .gitignore
- [ ] Logging implementado
- [ ] Docstrings nas funções principais
- [ ] Código comentado onde necessário

### Documentação
- [ ] README completo (uso template)
- [ ] .env.example criado
- [ ] requirements.txt atualizado
- [ ] Screenshots/prints adicionados

### Produção
- [ ] Script agendado (cron/scheduler)
- [ ] Testei que scheduler funciona
- [ ] Logs sendo salvos corretamente
- [ ] Runbook documentado

### Vídeo
- [ ] Gravei demo (5-10min)
- [ ] Upload YouTube/Loom
- [ ] Link adicionado no README

### Entrega
- [ ] Repositório GitHub público/privado
- [ ] README tem link do vídeo
- [ ] Enviei link via plataforma do curso

---

## 💡 DICAS PRO

### 1. Comece Pequeno

**MVP First:**
- Semana 1: 1 módulo funcionando (ex: coleta)
- Semana 2: + 1 módulo (ex: processamento)
- Semana 3: + alertas/dashboard
- Semana 4: Polish e documentação

**Não tente fazer tudo de uma vez!**

---

### 2. Use Templates do Curso

- `resources/template-script-automacao.md`
- `resources/template-api-basica.md`
- `resources/template-readme-projeto.md`

**Copiar estrutura não é trapacear. É ser eficiente.**

---

### 3. Reuse Código das Aulas

**Todo código do curso pode ser reutilizado:**
- Scraping (aula 2.1)
- Batch processing (aula 2.2)
- API (aula 2.3)
- Dashboard (aula 2.4)
- Scheduler (aula 2.5)

**Combine e adapte para seu caso!**

---

### 4. Documente Enquanto Faz

**Não deixe README para o final:**
- Após cada feature, atualiza README
- Anota problemas encontrados (vira seção troubleshooting)
- Tira screenshots conforme avança

---

### 5. Peça Feedback Intermediário

**Não espere terminar 100% para mostrar:**
- Post MVP na comunidade (após semana 1-2)
- Receba feedback cedo
- Ajusta rota se necessário

---

## 🎓 PÓS-ENTREGA

### Aprovado (≥70pts)

**Você recebe:**
- ✅ Certificado Claude Code Expert
- 💬 Acesso comunidade exclusiva vitalício
- 🎯 1h consultoria estratégica (José Amorim)
- 🏆 Destaque no Hall of Fame (se permitir)

**Próximos passos:**
- Escalar projeto (adicionar features)
- Implementar 2ª automação
- Mentorear outros alunos

---

### Não aprovado (<70pts)

**Feedback detalhado:**
- Onde perdeu pontos
- O que melhorar
- Exemplos de correção

**1 retry permitido:**
- Corrige baseado em feedback
- Re-submete em 7-14 dias
- Nova avaliação

---

## 📞 SUPORTE DURANTE PROJETO

### Canais

- **Comunidade Discord/Telegram:** Dúvidas técnicas
- **Office Hours:** Sessões ao vivo quinzenais
- **Email suporte:** Casos específicos complexos

### Perguntas Permitidas

✅ **BOM:**
- "Erro X ao fazer Y, já tentei Z, o que mais posso tentar?"
- "Quero fazer A, melhor usar biblioteca B ou C? Por quê?"
- "MVP pronto, feedback antes de continuar?"

❌ **EVITAR:**
- "Como fazer o projeto inteiro?"
- "Pode fazer por mim?"
- "Não sei por onde começar" (sem ter tentado nada)

---

## 🎯 RESUMO

**Prazo:** 7-14 dias

**Escolha:** 1 opção (CRM, Monitor, ou Customizado)

**Entrega:**
1. Repositório GitHub
2. Vídeo demo (5-10min)
3. Link via plataforma

**Aprovação:** ≥70 pontos

**Dica final:** **Feito é melhor que perfeito.** MVP funcional > sistema complexo incompleto.

---

## 🚀 MÃOS À OBRA!

**Você tem todas as ferramentas.**

**Você tem todo o conhecimento.**

**Agora é EXECUTAR.**

**Boa sorte, futuro Claude Code Expert!** 💪🚀

---

**Dúvidas?** Poste na comunidade com tag #projeto-final

**Inspiração?** Veja Hall of Fame (projetos aprovados anteriores)

**Motivação?** Lembre do ROI: 1 projeto = 20-30h/semana economizadas para sempre 🎯

