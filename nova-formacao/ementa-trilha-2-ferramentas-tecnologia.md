# EMENTA - Trilha 2: Ferramentas e Tecnologia

## Reducao de Custo | Academia Lendaria

---

> **Categoria:** Reducao de Custo
> **Duracao Total:** 6-8 horas (5 modulos)
> **Formato:** Hibrido (assincrono + sincrono)
> **Versao:** 1.0 | Dezembro 2025

---

# PARTE 1: FRAMEWORK GPS

## DESTINO (Para Onde o Aluno Vai)

### Promessa de Transformacao

> **"Montar sua infraestrutura de IA e automacao do zero, usando ferramentas de nivel enterprise a custo de PME, sem depender de desenvolvedor ou agencia, e com total controle dos seus dados e processos."**

### Resultado Tangivel ao Final da Trilha

O aluno tera implementado:
- **1 Ambiente n8n Funcional** - Plataforma de automacao self-hosted rodando
- **1 Banco de Dados Supabase** - PostgreSQL com autenticacao e storage
- **1 VPS Configurada** - Servidor cloud com suas ferramentas instaladas
- **3+ Integracoes LLM** - ChatGPT/Claude/Gemini configurados e funcionando
- **1 Stack Completo** - n8n + Supabase + LLMs integrados em fluxo real

### Impacto no DRE

| Linha do DRE | Impacto Esperado |
|--------------|------------------|
| **Custo de Software** | Reducao de 60-80% vs ferramentas SaaS (Zapier, Airtable) |
| **Custo de Desenvolvimento** | Reducao de 80-90% em implementacoes simples |
| **Custo de Agencia** | Eliminacao de dependencia para automacoes |
| **Tempo** | Economia de 15-30h/mes em tarefas manuais |

### Destino Emocional (5 Por Ques)

```
"Quero aprender n8n e Supabase"
  → Por que? "Porque nao quero pagar R$ 2.000/mes em Zapier"
    → Por que importa? "Porque a margem ja e apertada"
      → Por que isso incomoda? "Porque quero escalar sem custo proporcional"
        → Por que isso doi? "Porque quero um negocio lucrativo E escalavel"
          → DESTINO REAL: "Quero ter infraestrutura de GRANDE sem custo de GRANDE"
```

---

## ORIGEM (De Onde o Aluno Parte)

### Perfil do Aluno (ICP)

| Atributo | Valor |
|----------|-------|
| **Quem** | Empresario / Dono de negocio |
| **Faturamento** | R$ 50K - R$ 250K/mes |
| **Equipe** | 5-30 funcionarios |
| **Nivel tecnico** | Iniciante (usa ChatGPT basico, nunca programou) |
| **Tempo disponivel** | Escasso |

### Dores de Entrada

| Dor | Sintoma | Custo Oculto |
|-----|---------|--------------|
| "Zapier ta muito caro" | Pagando R$ 500-2.000/mes por automacao | Custo SaaS crescente |
| "Nao entendo nada de codigo" | Depende de dev/agencia para tudo | Tempo + custo de terceiro |
| "Meus dados estao em 10 ferramentas" | Planilha aqui, CRM ali, WhatsApp la | Retrabalho, dados perdidos |
| "Nao sei qual LLM usar" | ChatGPT, Claude, Gemini... | Paga varios sem estrategia |
| "Nao tenho controle dos meus dados" | Dados em SaaS terceiros | Risco + lock-in |

### Pre-requisitos Obrigatorios

Antes de iniciar, o aluno DEVE ter:

- [ ] **Cartao de credito internacional** - Para criar contas (trial gratuito)
- [ ] **Email profissional** - Para cadastros nas plataformas
- [ ] **1 processo atual identificado** - Algo manual para automatizar
- [ ] **ChatGPT ou Claude funcionando** - Conta ativa basica
- [ ] **Disposicao para aprender** - 90min/dia por 1 semana
- [ ] **Objetivo claro** - "Quero automatizar X para economizar Y"

---

## ROTA (Caminho da Origem ao Destino)

### Visao Geral dos 5 Modulos

```
MODULO 1          MODULO 2          MODULO 3          MODULO 4          MODULO 5
Stack         →   VPS e          →   Supabase      →   n8n           →   LLMs e
Lendario          Infraestrutura     Database          Automacao         Integracao

[Visao]           [Servidor]        [Dados]           [Fluxos]          [IA]
```

### Timeline de Implementacao

| Modulo | Duracao | Entregavel | Prazo de Implementacao |
|--------|---------|------------|------------------------|
| 1 | 90 min | Mapa de Stack + Contas Criadas | 48h |
| 2 | 90 min | VPS Rodando + n8n Instalado | 48h |
| 3 | 90 min | Supabase Configurado + 1 Tabela | 48h |
| 4 | 90 min | 3 Automacoes n8n Funcionando | 48h |
| 5 | 90 min | LLMs Integrados em Fluxo Real | 48h |

---

# PARTE 2: DETALHAMENTO DOS MODULOS

---

## MODULO 1: Stack Lendario — As Ferramentas Que Vao Escalar Seu Negocio

### Ficha Tecnica

| Atributo | Valor |
|----------|-------|
| **Duracao** | 90 minutos |
| **Bloom** | Nivel 2 - Compreender |
| **Formato** | Video (40min) + Setup Sprint (50min) |

### Objetivo

Entender **por que essas ferramentas** e **criar todas as contas** necessarias.

### Conceito Central

> **"Voce nao precisa de 47 ferramentas. Precisa de 4 que conversam entre si: n8n (automacao), Supabase (dados), VPS (infraestrutura), LLMs (inteligencia)."**

### Conteudo (Estrutura de Aula)

| Etapa | Duracao | Conteudo |
|-------|---------|----------|
| **1. Contexto de Negocio** | 5 min | "Quanto voce gasta/mes em SaaS que nao usa direito?" |
| **2. O Problema do SaaS** | 10 min | Custo cresce com uso, sem controle, dados espalhados |
| **3. Stack Lendario** | 15 min | n8n + Supabase + VPS + LLMs - Por que cada um |
| **4. Comparativo de Custos** | 10 min | Zapier vs n8n, Airtable vs Supabase, custos reais |
| **5. Setup Sprint** | 45 min | Criar contas em todas as plataformas |
| **6. Proxima acao 48h** | 5 min | Validar acesso + escolher 1 processo para automatizar |

### Stack Lendario Explicado

| Ferramenta | Funcao | Alternativa Cara | Economia |
|------------|--------|------------------|----------|
| **n8n** | Automacao e integracao | Zapier ($19-89/mes) | 80-100% |
| **Supabase** | Banco de dados + auth | Firebase + Airtable | 60-90% |
| **VPS** | Infraestrutura cloud | Heroku, Vercel | 70-80% |
| **LLMs** | Inteligencia artificial | Agencia, dev interno | 80-95% |

### Comparativo de Custos Real (PME)

| Cenario | Stack Tradicional | Stack Lendario | Economia/Ano |
|---------|-------------------|----------------|--------------|
| Automacao basica | Zapier Pro $49/mes | n8n self-host $0 | R$ 3.500 |
| Banco + auth | Firebase $25 + Airtable $20 | Supabase Free-$25 | R$ 2.000 |
| Hospedagem | Heroku $25-50/mes | VPS $5-20/mes | R$ 1.200 |
| **TOTAL** | ~R$ 800/mes | ~R$ 100/mes | **R$ 8.400/ano** |

### Entregavel Obrigatorio

**Mapa de Stack + Contas Criadas**, contendo:

| Plataforma | Conta Criada | Tier | Custo |
|------------|--------------|------|-------|
| n8n Cloud | [ ] | Starter (trial) | $0 |
| Supabase | [ ] | Free | $0 |
| Hostinger/Contabo | [ ] | VPS basica | ~$5/mes |
| OpenAI | [ ] | API | Pay-as-you-go |
| Anthropic | [ ] | API | Pay-as-you-go |

### Checklist de Validacao

- [ ] Conta n8n criada e acessivel
- [ ] Conta Supabase criada e acessivel
- [ ] VPS contratada (ou selecionada para contratar)
- [ ] Pelo menos 1 API de LLM com creditos
- [ ] 1 processo identificado para automatizar

### Prompt IA (Selecao de Processo)

```
Sou dono de uma empresa de [segmento] com [X] funcionarios.
Meus principais processos manuais sao:
[lista de processos]

Para cada processo, analise:
1. Complexidade de automatizar (1-5)
2. Impacto no negocio (1-5)
3. Ferramentas necessarias (n8n, Supabase, LLM)
4. Tempo estimado de implementacao
5. ROI estimado em 30 dias

Recomende qual automatizar primeiro e por que.
```

---

## MODULO 2: VPS e Infraestrutura — Seu Servidor na Nuvem

### Ficha Tecnica

| Atributo | Valor |
|----------|-------|
| **Duracao** | 90 minutos |
| **Bloom** | Nivel 3 - Aplicar |
| **Formato** | Video (30min) + Build Sprint (60min) |

### Objetivo

Ter um **servidor VPS rodando** com n8n instalado e acessivel.

### Por Que VPS e Nao Cloud Tradicional

| Aspecto | Cloud (Heroku/Vercel) | VPS |
|---------|----------------------|-----|
| **Custo** | Cresce com uso | Fixo e previsivel |
| **Controle** | Limitado | Total |
| **Dados** | Terceiro controla | Voce controla |
| **Escala** | Automatica (caro) | Manual (barato) |
| **Aprendizado** | Pouco | Muito (valioso) |

### Provedores Recomendados

| Provedor | Config Minima | Preco/Mes | Ideal Para |
|----------|--------------|-----------|------------|
| **Hostinger VPS** | 1vCPU, 4GB RAM | $4.99 | Iniciantes (painel facil) |
| **Contabo** | 4vCPU, 8GB RAM | €4.99 | Custo-beneficio |
| **Hetzner** | 2vCPU, 4GB RAM | €4.15 | Performance EU |
| **DigitalOcean** | 1vCPU, 2GB RAM | $12 | Documentacao excelente |

### Conteudo (Estrutura de Aula)

| Etapa | Duracao | Conteudo |
|-------|---------|----------|
| **1. Contexto** | 5 min | "Seu Zapier ta na mao do Zapier. E se eles aumentarem o preco?" |
| **2. VPS vs Cloud** | 10 min | Por que VPS e melhor para PME |
| **3. Escolhendo provedor** | 5 min | Hostinger, Contabo, Hetzner - qual escolher |
| **4. Demo: Criando VPS** | 10 min | Passo a passo na tela |
| **5. Build Sprint** | 50 min | Criar VPS + Instalar n8n + Configurar dominio |
| **6. Proxima acao 48h** | 5 min | Testar acesso de outro dispositivo |

### Entregavel Obrigatorio

**VPS Configurada com n8n**, contendo:

| Item | Status | Evidencia |
|------|--------|-----------|
| VPS criada | [ ] | Screenshot do painel |
| SSH funcionando | [ ] | Comando executado |
| n8n instalado | [ ] | URL acessivel |
| Dominio/Subdominio | [ ] | n8n.seudominio.com |
| HTTPS configurado | [ ] | Cadeado verde |

### Script de Instalacao (Ubuntu/Debian)

```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# Instalar n8n com Docker
docker run -d --restart unless-stopped \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  --name n8n \
  n8nio/n8n

# Verificar se esta rodando
docker ps
```

### Checklist de Validacao

- [ ] VPS acessivel via SSH
- [ ] Docker instalado e rodando
- [ ] n8n acessivel via browser (IP:5678)
- [ ] Dominio/subdominio apontando para VPS
- [ ] HTTPS configurado (Let's Encrypt)

### Prompt IA (Troubleshooting)

```
Estou tentando instalar n8n na minha VPS e encontrei este erro:
[colar erro]

Meu sistema operacional e: [Ubuntu/Debian/etc]
Comandos que executei: [listar comandos]

Me ajude a:
1. Entender o que causou o erro
2. Resolver passo a passo
3. Verificar se a instalacao foi bem sucedida
```

### Erros Comuns a Evitar

| Erro | Causa | Solucao |
|------|-------|---------|
| Porta 5678 nao acessivel | Firewall bloqueando | Liberar porta no painel da VPS |
| n8n nao inicia | Pouca memoria | Upgrade para 4GB RAM |
| Conexao recusada | Docker nao rodando | `sudo systemctl start docker` |

---

## MODULO 3: Supabase — Seu Banco de Dados Inteligente

### Ficha Tecnica

| Atributo | Valor |
|----------|-------|
| **Duracao** | 90 minutos |
| **Bloom** | Nivel 3 - Aplicar |
| **Formato** | Video (30min) + Build Sprint (60min) |

### Objetivo

Ter um **banco de dados Supabase funcional** com tabela, autenticacao e API pronta.

### Por Que Supabase

| Aspecto | Airtable/Notion | Supabase |
|---------|-----------------|----------|
| **Tipo** | Spreadsheet glorificada | PostgreSQL real |
| **Escala** | Limitada (rows) | Ilimitada |
| **API** | Basica | Completa (REST + Realtime) |
| **Auth** | Nao tem | Integrado |
| **Storage** | Limitado | Incluido |
| **Preco** | $20+/mes | Free ate 500MB |

### Conteudo (Estrutura de Aula)

| Etapa | Duracao | Conteudo |
|-------|---------|----------|
| **1. Contexto** | 5 min | "Seus dados estao em planilha, CRM, WhatsApp... Caos?" |
| **2. Por que banco de dados** | 10 min | Planilha vs Database - quando usar cada |
| **3. Supabase 101** | 10 min | Projetos, tabelas, API, auth, storage |
| **4. Demo: Criando projeto** | 5 min | Setup inicial na interface |
| **5. Build Sprint** | 50 min | Criar projeto + tabela + testar API |
| **6. Proxima acao 48h** | 5 min | Migrar 1 planilha para Supabase |

### Estrutura Basica Recomendada

```sql
-- Tabela de Leads (exemplo)
CREATE TABLE leads (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMP DEFAULT now(),
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  source TEXT,
  status TEXT DEFAULT 'novo',
  score INTEGER DEFAULT 0,
  notes TEXT,
  assigned_to UUID REFERENCES auth.users(id)
);

-- Habilitar RLS (Row Level Security)
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
```

### Entregavel Obrigatorio

**Supabase Configurado**, contendo:

| Item | Status | Evidencia |
|------|--------|-----------|
| Projeto criado | [ ] | URL do projeto |
| 1 Tabela criada | [ ] | Screenshot da tabela |
| API Key copiada | [ ] | Guardada em local seguro |
| 1 Insert via API | [ ] | Row inserida |
| 1 Select via API | [ ] | Dados retornados |

### Template de Tabelas Comuns

| Negocio | Tabelas Sugeridas |
|---------|-------------------|
| **Servicos** | leads, clients, projects, tasks |
| **E-commerce** | products, orders, customers, inventory |
| **SaaS** | users, subscriptions, usage, tickets |
| **Agencia** | clients, campaigns, reports, invoices |

### Checklist de Validacao

- [ ] Projeto Supabase criado
- [ ] Pelo menos 1 tabela com schema definido
- [ ] API Key salva em local seguro
- [ ] Consegue inserir dados via interface
- [ ] Consegue consultar dados via API

### Prompt IA (Modelagem de Dados)

```
Meu negocio e [descrever negocio].
Principais processos: [listar processos]
Dados que preciso armazenar: [listar dados]

Crie um schema de banco de dados com:
1. Tabelas necessarias (nome + descricao)
2. Campos de cada tabela (nome, tipo, obrigatorio)
3. Relacionamentos entre tabelas
4. SQL para criar no Supabase

Formato: SQL compativel com PostgreSQL/Supabase
```

---

## MODULO 4: n8n na Pratica — Automacoes Que Funcionam

### Ficha Tecnica

| Atributo | Valor |
|----------|-------|
| **Duracao** | 90 minutos |
| **Bloom** | Nivel 6 - Criar |
| **Formato** | Video (30min) + Build Sprint (60min) |

### Objetivo

Criar **3 automacoes funcionais** que resolvem problemas reais do negocio.

### n8n vs Zapier/Make

| Aspecto | Zapier | Make | n8n |
|---------|--------|------|-----|
| **Preco** | $19-89/mes | $9-29/mes | $0 (self-host) |
| **Execucoes** | Limitadas | Limitadas | Ilimitadas |
| **Nodes IA** | Basicos | Medios | 70+ LangChain |
| **Self-host** | Nao | Nao | Sim |
| **Complexidade** | Baixa | Media | Media-Alta |
| **Ideal para** | Iniciantes | Intermediarios | PME consciente |

### 3 Automacoes para Construir

| # | Automacao | Trigger | Acoes | Impacto |
|---|-----------|---------|-------|---------|
| 1 | **Lead no WhatsApp → Supabase** | Webhook | Salvar + Classificar + Notificar | Nao perde lead |
| 2 | **Form → Email + CRM** | Webhook | Processar + Enviar + Registrar | Resposta instantanea |
| 3 | **Relatorio Diario** | Schedule | Consultar + Formatar + Enviar | Visibilidade |

### Conteudo (Estrutura de Aula)

| Etapa | Duracao | Conteudo |
|-------|---------|----------|
| **1. Contexto** | 5 min | "Quantas tarefas voce faz todo dia que sao iguais?" |
| **2. Anatomia de automacao** | 10 min | Trigger → Nodes → Output |
| **3. n8n Interface** | 10 min | Navegacao, nodes, execucoes, debug |
| **4. Demo: Automacao 1** | 5 min | Lead WhatsApp → Supabase |
| **5. Build Sprint** | 50 min | Construir as 3 automacoes |
| **6. Proxima acao 48h** | 5 min | Rodar em producao por 48h |

### Automacao 1: Lead WhatsApp → Supabase

```
TRIGGER: Webhook (recebe msg do WhatsApp)
    ↓
NODE 1: Set (extrair nome, telefone, mensagem)
    ↓
NODE 2: Supabase (INSERT na tabela leads)
    ↓
NODE 3: IF (lead quente?)
    ↓
NODE 4a: Slack/Telegram (notificar vendedor)
NODE 4b: Email (resposta automatica)
```

### Automacao 2: Form → Email + CRM

```
TRIGGER: Webhook (form submetido)
    ↓
NODE 1: Set (formatar dados)
    ↓
NODE 2: Supabase (salvar lead)
    ↓
NODE 3: OpenAI (gerar resposta personalizada)
    ↓
NODE 4: Email (enviar resposta)
    ↓
NODE 5: Slack (notificar time)
```

### Automacao 3: Relatorio Diario

```
TRIGGER: Schedule (todo dia 8h)
    ↓
NODE 1: Supabase (buscar metricas do dia anterior)
    ↓
NODE 2: OpenAI (gerar insights dos dados)
    ↓
NODE 3: HTML (formatar email bonito)
    ↓
NODE 4: Email (enviar para gestores)
```

### Entregavel Obrigatorio

**3 Automacoes Funcionando**, com:

| Automacao | Status | Evidencia |
|-----------|--------|-----------|
| Lead WhatsApp → Supabase | [ ] | Print execucao + row no banco |
| Form → Email + CRM | [ ] | Email recebido + lead salvo |
| Relatorio Diario | [ ] | Email de relatorio recebido |

### Checklist de Validacao

- [ ] 3 workflows criados no n8n
- [ ] Todos executam sem erro
- [ ] Dados chegam no Supabase
- [ ] Notificacoes/emails sao enviados
- [ ] Logs de execucao salvos

### Prompt IA (Desenhar Automacao)

```
Quero automatizar este processo:
[descrever processo atual manual]

Ferramentas disponiveis: n8n, Supabase, OpenAI, Email, Slack/Telegram

Desenhe a automacao com:
1. Trigger (o que dispara)
2. Nodes necessarios (em ordem)
3. Dados que passam entre nodes
4. Tratamento de erros
5. Estimativa de economia de tempo

Formato: Fluxo visual em texto (→ para conexoes)
```

---

## MODULO 5: LLMs na Pratica — IA Integrada ao Seu Stack

### Ficha Tecnica

| Atributo | Valor |
|----------|-------|
| **Duracao** | 90 minutos |
| **Bloom** | Nivel 6 - Criar |
| **Formato** | Video (30min) + Build Sprint (60min) |

### Objetivo

Integrar **LLMs ao seu stack** para automacoes inteligentes.

### Comparativo de LLMs para Negocios

| LLM | Melhor Para | Custo Aproximado | API |
|-----|-------------|------------------|-----|
| **GPT-4o** | Uso geral, conversacao | $2.50/1M tokens | Sim |
| **GPT-4o-mini** | Tarefas simples, alto volume | $0.15/1M tokens | Sim |
| **Claude 3.5** | Analise de documentos, codigo | $3/1M tokens | Sim |
| **Gemini Pro** | Integracao Google, multimodal | $0.50/1M tokens | Sim |
| **Llama 3** | Self-host, privacidade | $0 (self-host) | Local |

### Quando Usar Cada LLM

| Caso de Uso | LLM Recomendado | Por Que |
|-------------|-----------------|---------|
| Atendimento ao cliente | GPT-4o-mini | Rapido, barato, bom |
| Analise de contratos | Claude 3.5 | Contexto longo, preciso |
| Geracao de conteudo | GPT-4o | Criativo, natural |
| Classificacao de leads | GPT-4o-mini | Simples, barato |
| Integracao Google | Gemini | Nativo Google Workspace |

### Conteudo (Estrutura de Aula)

| Etapa | Duracao | Conteudo |
|-------|---------|----------|
| **1. Contexto** | 5 min | "IA nao e magica. E ferramenta. Saber usar = vantagem." |
| **2. Panorama LLMs** | 10 min | GPT vs Claude vs Gemini - quando usar cada |
| **3. APIs na pratica** | 10 min | Chaves, custos, rate limits |
| **4. n8n + LLMs** | 5 min | Nodes disponiveis, LangChain |
| **5. Build Sprint** | 50 min | Integrar LLM em 2 automacoes |
| **6. Proxima acao 48h** | 5 min | Rodar em producao e medir custos |

### Integracoes para Construir

| # | Integracao | Automacao Base | Adicao LLM |
|---|------------|----------------|------------|
| 1 | **Classificacao de Lead** | Lead → Supabase | + Score automatico via GPT |
| 2 | **Resposta Inteligente** | Form → Email | + Resposta personalizada via Claude |

### Integracao 1: Classificacao Inteligente de Lead

```
TRIGGER: Novo lead no Supabase
    ↓
NODE 1: Supabase (buscar dados do lead)
    ↓
NODE 2: OpenAI (classificar lead 1-10 + justificativa)
    ↓
NODE 3: Supabase (UPDATE score + notes)
    ↓
NODE 4: IF (score >= 7)
    ↓
NODE 5: Slack (notificar: "Lead quente!")
```

### Prompt de Classificacao (para usar no n8n)

```
Voce e um especialista em qualificacao de leads B2B.

Dados do lead:
- Nome: {{nome}}
- Empresa: {{empresa}}
- Cargo: {{cargo}}
- Mensagem: {{mensagem}}
- Origem: {{origem}}

Classifique de 1-10 onde:
- 1-3: Lead frio (curioso, sem budget)
- 4-6: Lead morno (interesse, mas objecoes)
- 7-10: Lead quente (pronto para comprar)

Responda APENAS em JSON:
{
  "score": [1-10],
  "justificativa": "[1 frase]",
  "proximo_passo": "[acao recomendada]"
}
```

### Integracao 2: Resposta Inteligente

```
TRIGGER: Form de contato submetido
    ↓
NODE 1: Set (formatar dados)
    ↓
NODE 2: Claude (gerar resposta personalizada)
    ↓
NODE 3: Email (enviar resposta)
    ↓
NODE 4: Supabase (salvar lead + resposta)
```

### Prompt de Resposta (para usar no n8n)

```
Voce e o assistente de atendimento da [EMPRESA].
Tom: Profissional, acolhedor, direto.

Dados do contato:
- Nome: {{nome}}
- Assunto: {{assunto}}
- Mensagem: {{mensagem}}

Gere uma resposta de email que:
1. Agradeca o contato usando o nome
2. Responda a duvida/pedido de forma util
3. Indique proximo passo claro
4. Tenha max 150 palavras

Nao use: "Prezado", "Atenciosamente", linguagem corporativa fria.
```

### Entregavel Obrigatorio

**LLMs Integrados no Stack**, contendo:

| Item | Status | Evidencia |
|------|--------|-----------|
| API Key OpenAI | [ ] | Configurada no n8n |
| API Key Anthropic | [ ] | Configurada no n8n |
| Classificacao funcionando | [ ] | Lead com score no Supabase |
| Resposta automatica | [ ] | Email enviado via LLM |
| Custo monitorado | [ ] | Print do usage |

### Gestao de Custos LLM

| Acao | Economia |
|------|----------|
| Usar GPT-4o-mini para tarefas simples | 90% vs GPT-4o |
| Cache de respostas similares | 50-80% |
| Limitar tokens de resposta | 30-50% |
| Batch processing | 20-30% |

### Checklist de Validacao

- [ ] Pelo menos 2 APIs de LLM configuradas
- [ ] Integracao de classificacao funcionando
- [ ] Integracao de resposta funcionando
- [ ] Custos sendo monitorados
- [ ] Prompts otimizados para o negocio

### Prompt IA (Otimizar Custos)

```
Meu uso atual de LLM:
- Modelo: [GPT-4o/Claude/etc]
- Chamadas/dia: [numero]
- Tokens medios/chamada: [numero]
- Custo atual: [valor]

Analise e sugira:
1. Se estou usando o modelo certo para cada caso
2. Como reduzir tokens sem perder qualidade
3. O que cachear para economizar
4. Alternativas mais baratas que funcionam
5. Estimativa de economia com otimizacoes
```

---

# PARTE 3: PROJETO FINAL

## Stack Lendario Completo

### Descricao

Ao final da trilha, o aluno tera um **stack completo funcionando**:

```
[INPUTS]                    [PROCESSAMENTO]              [OUTPUTS]
WhatsApp    →               n8n                    →     Supabase (dados)
Forms       →    Webhook →  (automacao)   → LLM →       Email (respostas)
Agendamentos →              VPS (infra)            →     Slack/Telegram (alertas)
```

### Entregaveis do Projeto Final

| Entregavel | Origem | Criterio de Aprovacao |
|------------|--------|----------------------|
| VPS funcionando | Modulo 2 | n8n acessivel via HTTPS |
| Supabase configurado | Modulo 3 | >= 2 tabelas com dados reais |
| 3 Automacoes n8n | Modulo 4 | Executando sem erros |
| 2 Integracoes LLM | Modulo 5 | Classificacao + Resposta funcionando |
| **Documentacao do Stack** | Integracao | Diagrama + credenciais + processos |

### Rubrica de Avaliacao

| Criterio | Peso | Aprovado | Parcial | Reprovado |
|----------|------|----------|---------|-----------|
| Infraestrutura | 25% | VPS + n8n + Supabase | 2 de 3 | < 2 |
| Automacoes | 25% | 3 funcionando | 2 funcionando | < 2 |
| Integracoes LLM | 25% | 2 funcionando | 1 funcionando | 0 |
| Documentacao | 15% | Completa e clara | Parcial | Ausente |
| Economia comprovada | 10% | Comparativo antes/depois | Estimativa | Sem dados |

---

# PARTE 4: RECURSOS E SUPORTE

## Kits de Aceleracao

| Modulo | Template | Prompt | Video |
|--------|----------|--------|-------|
| 1 | Checklist de Contas.md | Prompt de Selecao | Setup (10min) |
| 2 | Script Instalacao VPS.sh | Prompt de Debug | Troubleshooting (5min) |
| 3 | Schema Supabase.sql | Prompt de Modelagem | Setup Tabelas (5min) |
| 4 | Workflows n8n.json | Prompt de Automacao | Import/Export (5min) |
| 5 | Prompts LLM.md | Prompt de Otimizacao | Integracao (5min) |

## Niveis de Uso

| Nivel | Tempo | O que faz |
|-------|-------|-----------|
| **1 - Empresario Apressado** | 30 min | Importa workflows prontos, ajusta variaveis |
| **2 - Funcionario Aprendendo** | 2h | Constroi do zero seguindo aulas |
| **3 - Expert Customizando** | 4h | Adapta stack para necessidades especificas |

---

# PARTE 5: METRICAS DE SUCESSO

## KPIs da Trilha

| Metrica | Meta | Como Medir |
|---------|------|------------|
| Taxa de conclusao | >70% | Modulos concluidos / Iniciados |
| Stack funcional | 100% | VPS + n8n + Supabase rodando |
| Automacoes ativas | >= 3 | Workflows em producao |
| Economia comprovada | Mensuravel | Comparativo SaaS antes/depois |

## Timeline de Resultados

| Marco | Prazo | Evidencia |
|-------|-------|-----------|
| Contas criadas | 24h | Acesso a todas plataformas |
| VPS rodando | 48h | n8n acessivel via URL |
| 1 Automacao funcional | 72h | Workflow executando |
| Stack completo | 7 dias | Tudo integrado |
| ROI positivo | 30 dias | Economia > investimento |

---

# PARTE 6: ALINHAMENTO COM ICP

## Checklist de Validacao GPS

### DESTINO
- [x] Deixa claro PARA ONDE o aluno vai? → Stack de IA independente
- [x] Explica O QUE vai conseguir fazer? → Automatizar sem depender de terceiros
- [x] Conecta com motivacao profunda? → "Infraestrutura de grande sem custo de grande"

### ORIGEM
- [x] Considera o nivel de conhecimento previo? → Iniciante (nunca programou)
- [x] Nao assume conhecimentos que o aluno nao tem? → Passo a passo detalhado
- [x] Considera limitacoes (tempo, atencao)? → 90min/modulo, scripts prontos

### ROTA
- [x] Sequencia segue progressao logica? → Visao → Infra → Dados → Automacao → IA
- [x] Evita saltos de complexidade? → Cada modulo usa o anterior
- [x] E conciso (sem prolixidade)? → Foco em fazer, nao explicar
- [x] Conecta cada conceito ao objetivo final? → Sempre volta ao custo/economia

---

**Documento elaborado por:** Course Architect Agent
**Base:** ICP Nova Formacao + Pesquisa de Ferramentas PME 2025
**Versao:** 1.0
**Data:** Dezembro 2025
