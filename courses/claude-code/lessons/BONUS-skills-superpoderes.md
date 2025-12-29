# Aula BÔNUS - Skills: Os Superpoderes do Claude

**Módulo:** BÔNUS - Features Avançadas  
**Duração:** 30 minutos  
**Nível Bloom:** Create  
**Instrutor:** José Carlos Amorim

**⚠️ IMPORTANTE:** Esta é uma aula sobre Skills (lançada em Out/2024), a feature mais game-changing do Claude. Diferente de tudo que você viu até agora.

---

## 🎯 GOAL

Dominar **Skills** - o sistema que transforma Claude de assistente genérico em **especialista customizado** para SUAS necessidades específicas. 

**Resultado concreto:** 
- Entender arquitetura de Skills
- Criar sua primeira Skill customizada
- Usar Skills do repositório oficial (15+ prontas)
- Integrar Skills em automações empresariais

**Por que isso é REVOLUCIONÁRIO:**
Skills são como "contratar especialistas on-demand" para o Claude. Quer que ele seja expert em Excel? Carrega skill. Seguir brand guidelines da sua empresa? Carrega skill. Criar apresentações no seu formato? Carrega skill.

**Antes:** Claude genérico para tudo  
**Depois:** Claude especialista em CADA tarefa específica

---

## 📍 POSITION

**Sabe aquele momento** que você pede algo pro Claude e ele faz... mas não do JEITO que você precisa?

**Exemplos reais:**
- Gera Excel, mas sem as fórmulas que você sempre usa
- Cria apresentação, mas não segue template da empresa
- Processa dados, mas não do formato específico que seu sistema aceita
- Escreve código, mas não seguindo os padrões do seu time

**O problema não é Claude. É que ele não conhece SEU contexto.**

**Skills resolvem isso.**

Imagine poder ensinar Claude:
- "Sempre que eu pedir planilha, use ESTES templates"
- "Quando criar apresentação, siga ESTAS diretrizes visuais"
- "Ao processar dados, use ESTA estrutura JSON"
- "Para código, aplique ESTES padrões do time"

**Skills = Onboarding customizado para Claude.**

Você não precisa explicar toda vez. Carrega a Skill 1x, Claude vira especialista para sempre.

---

## 🔄 STEPS

### PASSO 1: O Que São Skills (Arquitetura) (5min)

#### DEFINIÇÃO TÉCNICA

**Skill = Pasta com instruções + scripts + recursos que Claude carrega quando relevante.**

**Anatomia de uma Skill:**
```
minha-skill/
├── SKILL.md              # Core: Instruções + metadata
├── examples/             # Exemplos de uso
├── templates/            # Templates reutilizáveis
├── scripts/              # Código executável (opcional)
└── resources/            # Assets (imagens, JSONs, etc)
```

**Arquivo SKILL.md (obrigatório):**
```markdown
---
name: excel-financeiro
description: Cria planilhas Excel para relatórios financeiros mensais com fórmulas, formatação e gráficos padrão CFO
---

# Excel Financeiro - Skill

## Objetivo
Gerar planilhas Excel para relatórios mensais de finanças seguindo template aprovado pelo CFO.

## Estrutura Padrão
- Aba 1: Dashboard (gráficos)
- Aba 2: Receita (detalhamento)
- Aba 3: Despesas (categorizado)
- Aba 4: Fluxo de Caixa

## Fórmulas Obrigatórias
- ROI: `=((Receita - Custo) / Custo) * 100`
- Margem: `=(Receita - Despesas) / Receita`
- Burn Rate: `=Despesas / 30`

## Formatação
- Monetário: R$ #.##0,00
- Percentual: 0.0%
- Cores: Verde (positivo), Vermelho (negativo)

## Validações
- Despesas > Receita → Alerta visual
- Fluxo negativo → Highlighting automático
```

**Como Claude usa:**
1. Você pede: *"Cria relatório financeiro de Janeiro"*
2. Claude escaneia Skills disponíveis
3. Encontra `excel-financeiro` (match por description)
4. Carrega SKILL.md + templates
5. Gera planilha seguindo EXATAMENTE as especificações
6. Resultado: Excel pronto, padrão CFO, zero ajustes manuais

---

#### CARACTERÍSTICAS FUNDAMENTAIS

**1. COMPOSABLE (Componível)**
```
Você: "Cria apresentação sobre resultados Q1 seguindo brand da empresa"

Claude:
1. Carrega Skill "pptx" (criar apresentação)
2. Carrega Skill "brand-guidelines" (cores/tipografia empresa)
3. Carrega Skill "financial-charts" (gráficos financeiros)
4. COMBINA as 3 automaticamente
→ Resultado: PowerPoint com dados + visual da marca + gráficos corretos
```

**Skills se empilham sozinhas. Você não precisa orquestrar.**

---

**2. PORTABLE (Portável)**

**Mesmo formato funciona em:**
- Claude.ai (web)
- Claude Code (desktop)
- Claude API (seus apps)

**Cria 1x, usa everywhere.**

```bash
# Criar skill localmente
~/my-skills/excel-financeiro/

# Usar no Claude Code
cp -r ~/my-skills/excel-financeiro ~/.claude/skills/

# Usar na API
POST /v1/skills
{
  "name": "excel-financeiro",
  "files": {...}
}

# Usar no Claude.ai
Upload via Settings → Skills
```

---

**3. EFFICIENT (Eficiente)**

**Claude não carrega tudo de uma vez.**

Skill tem 100 exemplos + 50 templates + 20 scripts?

Claude carrega APENAS o necessário:
- Você pede gráfico de pizza → Carrega só template de pizza
- Você pede tabela → Carrega só estrutura de tabela

**Resultado:** Skills gigantes não deixam Claude lento.

---

**4. POWERFUL (Poderosas)**

**Skills podem incluir código executável Python/JavaScript.**

**Por quê?**

Algumas tarefas são mais confiáveis com código determinístico do que geração de tokens LLM.

**Exemplo:**
```python
# Dentro da Skill "pdf-extractor"
# Script: extract_tables.py

import pdfplumber

def extract_tables_from_pdf(pdf_path):
    """
    Extrai tabelas de PDF com 100% precisão
    (LLM pode 'alucinar' células, código não)
    """
    with pdfplumber.open(pdf_path) as pdf:
        tables = []
        for page in pdf.pages:
            tables.extend(page.extract_tables())
    
    return tables
```

Claude chama esse script quando precisar extrair tabelas. **Precisão > Criatividade.**

---

### PASSO 2: Skills Nativas do Claude (Document Skills) (5min)

**Anthropic criou 4 Skills profissionais pré-instaladas:**

#### 1. XLSX SKILL (Excel)

**O que faz:**
- Cria planilhas do zero
- Edita planilhas existentes (preserva fórmulas)
- Adiciona gráficos (linha, barra, pizza, scatter)
- Formatação condicional
- Validação de dados
- Extração de dados (xlsx → JSON/CSV)

**Exemplo de uso:**
```
Você: "Abre planilha vendas.xlsx, adiciona coluna 'ROI' com fórmula 
=(Receita-Custo)/Custo, formata como %, adiciona gráfico de linha 
mostrando ROI mensal"

Claude (com xlsx skill):
1. Lê vendas.xlsx (preserva tudo)
2. Adiciona coluna ROI com fórmula correta
3. Aplica formatação percentual
4. Insere gráfico de linha configurado
5. Salva vendas_updated.xlsx

→ Tempo: 10 segundos (vs 10min manual)
```

**Features avançadas:**
- Fórmulas complexas (VLOOKUP, SUMIFS, Array formulas)
- Named ranges
- Tabelas dinâmicas (Pivot Tables)
- Proteção de células
- Macros (VBA) - leitura e preservação

---

#### 2. PPTX SKILL (PowerPoint)

**O que faz:**
- Cria apresentações com layouts profissionais
- Edita slides existentes (preserva templates)
- Adiciona charts, imagens, shapes
- Aplica transições e animações
- Extração de conteúdo (pptx → markdown)

**Exemplo de uso:**
```
Você: "Cria apresentação Q1 Results com:
- Slide 1: Título com logo
- Slide 2: Revenue chart (dados de vendas.xlsx)
- Slide 3: Key metrics (3 colunas)
- Slide 4: Next steps (bullet points)
Template: corporate-blue.pptx"

Claude (com pptx skill):
→ Gera apresentação seguindo template existente
→ Importa dados do Excel automaticamente
→ Aplica layout consistente
→ Resultado: PowerPoint production-ready

→ Tempo: 30 segundos (vs 1h manual)
```

**Cases reais:**
- **Canva:** Usa pptx skill para gerar apresentações com designs do Canva
- **Notion:** Transforma Notion docs em slides automaticamente

---

#### 3. DOCX SKILL (Word)

**O que faz:**
- Cria documentos Word do zero
- Edita documentos preservando formatação
- Tracked changes (revisão colaborativa)
- Comentários
- Estilos e templates
- Extração de texto estruturado

**Exemplo de uso:**
```
Você: "Lê contrato_template.docx, substitui [CLIENTE] por 'Empresa XYZ',
[VALOR] por 'R$ 50.000', [DATA] por '01/02/2025', ativa Track Changes
para revisão do jurídico"

Claude (com docx skill):
→ Abre template
→ Substitui placeholders mantendo formatação
→ Ativa modo de revisão
→ Salva contrato_XYZ_draft.docx

→ Tempo: 5 segundos (vs 15min manual + risco de erro)
```

**Features avançadas:**
- Headers/footers
- Table of contents automático
- Bibliografia e citações
- Mail merge (múltiplos docs de template único)

---

#### 4. PDF SKILL (PDF)

**O que faz:**
- Extrai texto e tabelas (100% precisão)
- Cria PDFs do zero
- Merge/split PDFs
- Extrai formulários (form fields)
- Adiciona marcas d'água
- OCR (texto de imagens/scans)

**Exemplo de uso:**
```
Você: "Extrai dados das 50 notas fiscais em /nfs/*.pdf,
consolida em planilha Excel com colunas: Fornecedor, Valor, Data, CNPJ"

Claude (com pdf skill):
1. Loop pelos 50 PDFs
2. Extrai campos (usando regex + OCR se necessário)
3. Valida CNPJ (formato)
4. Cria Excel consolidado

→ Tempo: 2min (vs 4h manual)
→ Erro: 0% (vs 5-10% manual)
```

**Cases reais:**
- **Rakuten:** Usa pdf skill para processar relatórios financeiros. De 1 dia → 1 hora.

---

#### 📊 COMPARAÇÃO: SEM vs COM SKILLS

| Tarefa | Sem Skills | Com Skills | Economia |
|--------|-----------|------------|----------|
| Criar Excel complexo | 30min (manual) | 20seg (skill) | 98% |
| Extrair dados de 100 PDFs | 8h (manual) | 3min (skill) | 99.4% |
| Gerar apresentação Q1 | 2h (manual) | 1min (skill) | 99.2% |
| Editar 50 contratos Word | 5h (manual) | 10min (skill) | 96.7% |

**Skills não são incremento. São TRANSFORMAÇÃO.**

---

### PASSO 3: Criando Sua Primeira Skill (8min)

#### CASO PRÁTICO: SKILL DE RELATÓRIOS SEMANAIS

**Contexto:**
Toda sexta você gera "Status Report" para time com estrutura padrão:
- Conquistas da semana
- Blockers
- Métricas (3 KPIs)
- Próximos passos

**Problema:** Toda sexta você explica pro Claude a estrutura. Repetitivo.

**Solução:** Criar Skill "weekly-status".

---

#### PASSO A PASSO

**1. Criar estrutura:**
```bash
mkdir ~/.claude/skills/weekly-status
cd ~/.claude/skills/weekly-status
```

**2. Criar SKILL.md:**
```markdown
---
name: weekly-status
description: Gera relatório semanal de status do projeto seguindo template padrão da empresa com seções: Achievements, Blockers, Metrics, Next Steps
---

# Weekly Status Report - Skill

## Objetivo
Criar relatório de status semanal consistente e profissional.

## Estrutura Obrigatória

### 1. Header
```
📊 Status Report - Week [número da semana]
Projeto: [nome do projeto]
Data: [data atual]
Autor: [seu nome]
```

### 2. Conquistas da Semana (🎯)
- Mínimo 3, máximo 7 items
- Formato: "✅ [Ação concreta] → [Resultado quantificável]"
- Ordenar por impacto (maior primeiro)

**Exemplo:**
✅ Implementou autenticação OAuth → Redução 40% tickets suporte
✅ Otimizou queries banco → Tempo resposta API de 800ms para 120ms

### 3. Blockers (🚧)
- Listar apenas blockers REAIS (impedem progresso)
- Formato: "❌ [Problema] - [Impacto] - [Precisa de: X]"
- Máximo 3 blockers (se mais, sinal de problema maior)

**Exemplo:**
❌ API terceiro instável (timeout 30%) - Impede feature Y - Precisa: Reunião com vendor

### 4. Métricas (📈)
Sempre mostrar 3 KPIs em formato tabela:

| Métrica | Semana Atual | Semana Anterior | Δ |
|---------|--------------|-----------------|---|
| [KPI 1] | [valor] | [valor] | [+/-X%] |
| [KPI 2] | [valor] | [valor] | [+/-X%] |
| [KPI 3] | [valor] | [valor] | [+/-X%] |

### 5. Próximos Passos (⏭️)
- 3-5 ações para próxima semana
- Formato: "[Ação] - [Responsável] - [Prazo]"
- Ordenar por prioridade

### 6. Footer
```
---
Status geral: 🟢 No track | 🟡 At risk | 🔴 Delayed
Próxima review: [data próxima sexta]
```

## Validações
- Se zero Achievements → Flag "⚠️ Nenhuma conquista reportada"
- Se >3 Blockers → Flag "🚨 Excesso de blockers - revisar estratégia"
- Se métricas negativas → Adicionar seção "Action Plan"

## Exemplos
Ver: examples/status-report-jan-w1.md
```

**3. Adicionar exemplo (examples/status-report-jan-w1.md):**
```markdown
📊 Status Report - Week 1
Projeto: CRM Automation
Data: 2025-01-08
Autor: José Amorim

## 🎯 Conquistas da Semana
✅ Implementou módulo de Lead Scoring → 85% precisão na classificação HOT/WARM/COLD
✅ Integrou Clearbit API → Enriquecimento automático 300 leads/dia
✅ Deploy scheduler cron → Coleta roda 24/7 sem intervenção manual

## 🚧 Blockers
❌ Rate limit Clearbit (500/dia) - Impede escalar para 1000 leads/dia - Precisa: Upgrade plano Pro

## 📈 Métricas

| Métrica | Semana Atual | Semana Anterior | Δ |
|---------|--------------|-----------------|---|
| Leads coletados | 387 | 142 | +172% |
| Taxa enriquecimento | 78% | 45% | +73% |
| Tempo médio processo | 2.3min | 18min | -87% |

## ⏭️ Próximos Passos
1. Implementar módulo de Ação Automática (email + Slack) - José - 15/01
2. Criar dashboard métricas (Chart.js) - José - 18/01
3. Documentar runbook operacional - José - 19/01

---
Status geral: 🟢 No track
Próxima review: 2025-01-15
```

**4. Testar no Claude Code:**
```bash
# Claude Code detecta skill automaticamente
# Agora só pede:

"Gera weekly status da semana passada usando dados:
- Implementei 3 features (auth, dashboard, API)
- Blocker: servidor staging offline desde terça
- Métricas: 500 requests/dia, 99.2% uptime, 8 bugs resolvidos"

→ Claude carrega skill "weekly-status"
→ Gera relatório EXATAMENTE no formato padrão
→ Inclui validações (ex: flag se >3 blockers)
```

---

#### SKILLS NO CLAUDE.AI (WEB)

**Ativar Skills:**
1. Settings → Skills → Enable Skills
2. Browse Skills → Instalar skills oficiais
3. Upload custom skill (pasta .zip)

**Usar skill:**
```
Você: "Usa skill weekly-status para gerar relatório dessa semana"

Claude:
→ Detecta que existe skill "weekly-status"
→ Carrega instruções
→ Pergunta dados necessários
→ Gera relatório formatado
```

**Pro tip:** Claude mostra chain-of-thought com skills ativas:
```
🧠 Pensamento de Claude:
"Detectei skill 'weekly-status'. Vou usá-la para estruturar o relatório
seguindo template padrão: Header → Achievements → Blockers → Metrics → Next Steps"
```

---

#### SKILLS NA API

**Upload via API:**
```python
import anthropic

client = anthropic.Client(api_key="sk-...")

# Upload skill
skill = client.skills.create(
    name="weekly-status",
    description="Gera relatório semanal padrão",
    files={
        "SKILL.md": open("SKILL.md").read(),
        "examples/example1.md": open("examples/example1.md").read()
    }
)

# Usar skill em request
message = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    skills=[skill.id],  # ← Skill ativa nesta conversa
    messages=[{
        "role": "user",
        "content": "Gera weekly status report com dados: ..."
    }]
)
```

**Versionamento:**
```python
# Atualizar skill (v2)
skill_v2 = client.skills.update(
    skill_id=skill.id,
    version="2.0",
    files={...}  # Novos arquivos
)

# Rollback se v2 quebrar
client.skills.activate_version(skill.id, version="1.0")
```

---

### PASSO 4: Skills do Repositório Oficial (6min)

**GitHub:** https://github.com/anthropics/skills

**15+ skills prontas para usar:**

#### CREATIVE & DESIGN

**1. algorithmic-art**
```yaml
O que faz: Cria arte generativa com p5.js
Features:
  - Flow fields (campos de fluxo)
  - Particle systems
  - Seeded randomness (reproduzível)
  - Export PNG/SVG

Caso de uso:
"Cria arte generativa estilo flow field, seed 42, cores azul/roxo,
export em 1920x1080"
→ Resultado: Arte única mas reproduzível (seed 42 sempre gera mesma arte)
```

**2. canvas-design**
```yaml
O que faz: Design visual profissional (PNG/PDF)
Features:
  - Filosofias de design (minimalista, moderno, retrô)
  - Paletas de cores harmônicas
  - Tipografia profissional
  - Composição equilibrada

Caso de uso:
"Cria capa de ebook sobre IA, estilo minimalista, paleta azul/cinza,
título 'Future of AI', export PDF print-ready"
→ Resultado: Capa profissional pronta para impressão
```

**3. slack-gif-creator**
```yaml
O que faz: GIFs animados para Slack
Features:
  - Otimização automática (limite 5MB Slack)
  - Frame rate ajustável
  - Loop infinito
  - Compressão inteligente

Caso de uso:
"Cria GIF animado de 'Deploy successful' com foguete decolando,
3 segundos, loop, otimizado para Slack"
→ Resultado: GIF <5MB pronto para upload
```

---

#### DEVELOPMENT & TECHNICAL

**4. artifacts-builder**
```yaml
O que faz: Constrói artifacts HTML complexos (Claude.ai)
Stack:
  - React (componentes)
  - Tailwind CSS (styling)
  - shadcn/ui (biblioteca componentes)
  - Lucide icons

Caso de uso:
"Cria dashboard interativo com:
- Sidebar com navegação
- Gráficos Chart.js (vendas, leads)
- Tabela sortable
- Dark mode toggle"
→ Resultado: Dashboard funcional em artifact (HTML único)
```

**5. mcp-builder**
```yaml
O que faz: Guia para criar MCP servers (Model Context Protocol)
Features:
  - Integração APIs externas
  - Autenticação OAuth
  - Rate limiting
  - Error handling

Caso de uso:
"Cria MCP server para API do Notion que:
- Lista databases
- Cria páginas
- Busca conteúdo
- Autentica via OAuth"
→ Resultado: MCP server completo + docs
```

**6. webapp-testing**
```yaml
O que faz: Testa webapps locais com Playwright
Features:
  - UI testing automatizado
  - Screenshot comparison
  - Debug de problemas
  - Relatórios de bugs

Caso de uso:
"Testa webapp em localhost:3000:
- Login funciona?
- Botão 'Submit' visível?
- Form validation correta?
Generate bug report se falhar"
→ Resultado: Testes rodados + relatório detalhado
```

---

#### ENTERPRISE & COMMUNICATION

**7. brand-guidelines**
```yaml
O que faz: Aplica brand guidelines Anthropic em artifacts
Specs:
  - Cores oficiais (#191919, #CC785C, etc)
  - Tipografia (ABC Diatype, GT America)
  - Spacing e grid system
  - Tone of voice

Caso de uso:
"Cria landing page seguindo Anthropic brand guidelines"
→ Resultado: Página com visual consistente da marca
```

**8. internal-comms**
```yaml
O que faz: Escreve comunicações internas empresariais
Tipos:
  - Status reports
  - Newsletters
  - FAQs
  - Announcements

Caso de uso:
"Escreve newsletter Q1 para equipe com:
- Conquistas do trimestre
- Novos hires
- Eventos upcoming
Tom: professional mas friendly"
→ Resultado: Newsletter pronta para envio
```

**9. theme-factory**
```yaml
O que faz: Aplica temas visuais em artifacts
Temas prontos: 10 (Corporate, Startup, Creative, etc)
Features:
  - Generate custom themes on-the-fly
  - Dark/light mode
  - Accessible (WCAG compliant)

Caso de uso:
"Aplica tema 'Startup' no dashboard (cores vibrantes, tipografia moderna)"
→ Resultado: Artifact com visual de startup tech
```

---

#### META SKILLS

**10. skill-creator**
```yaml
O que faz: Cria skills interativamente (meta!)
Features:
  - Wizard interativo (perguntas guiadas)
  - Gera SKILL.md automaticamente
  - Sugere estrutura de pastas
  - Valida formato

Caso de uso:
"Quero criar skill para gerar contratos jurídicos padronizados"

Claude (usando skill-creator):
1. Pergunta: Qual tipo de contrato? (prestação serviço, venda, etc)
2. Pergunta: Quais cláusulas obrigatórias?
3. Pergunta: Formato output? (DOCX, PDF)
4. Gera SKILL.md completo + templates
→ Resultado: Nova skill pronta para usar
```

**11. template-skill**
```yaml
O que faz: Template básico para criar nova skill
Estrutura:
  - SKILL.md (boilerplate)
  - examples/ (pasta)
  - resources/ (pasta)
  - README.md

Caso de uso:
"Clone template e customize para minha necessidade"
```

---

### PASSO 5: Cases Empresariais Reais (4min)

#### CASE 1: BOX (Gestão Documentos)

**Desafio:**
Usuários Box têm milhares de arquivos (PDFs, imagens, CSVs) mas precisam transformar em formatos editáveis (PowerPoint, Excel, Word) seguindo padrões da organização.

**Manual:** 
- Baixar arquivo
- Abrir em ferramenta
- Converter formato
- Aplicar template corporativo
- Re-upload
**Tempo:** 15-20min por arquivo

**Solução com Skills:**
```
Usuário Box: "Converte proposal.pdf em PowerPoint seguindo template corporativo"

Claude (com Box skill + pptx skill):
1. Acessa arquivo no Box
2. Extrai conteúdo (pdf skill)
3. Cria PowerPoint (pptx skill)
4. Aplica template corporativo (brand-guidelines skill)
5. Salva de volta no Box

→ Tempo: 30 segundos
→ Economia: 97% (20min → 30seg)
```

**Quote oficial:**
> "Skills teaches Claude how to work with Box content. Users can transform stored files into PowerPoint presentations, Excel spreadsheets, and Word documents that follow their organization's standards—saving hours of effort."  
> — Yashodha Bhavnani, Head of AI, Box

---

#### CASE 2: NOTION (Colaboração)

**Desafio:**
Usuários Notion querem transformar páginas/databases em formatos específicos (relatórios, dashboards, apresentações) mas processo é manual e inconsistente.

**Solução com Skills:**
```
Usuário Notion: "Cria relatório Q1 a partir do database 'OKRs 2025'"

Claude (com Notion skill):
1. Conecta no Notion via API
2. Busca database "OKRs 2025"
3. Extrai dados estruturados
4. Gera relatório formatado (docx skill)
5. Adiciona gráficos de progresso
6. Cria link de compartilhamento

→ De "perguntas" para "ação" em segundos
```

**Quote oficial:**
> "With Skills, Claude works seamlessly with Notion - taking users from questions to action faster. Less prompt wrangling on complex tasks, more predictable results."  
> — MJ Felix, Product Manager, Notion

---

#### CASE 3: CANVA (Design)

**Desafio:**
Usuários Canva querem integrar designs em workflows automatizados (agents) mas processo não é padronizado.

**Solução com Skills:**
```
Agent workflow:
1. Coletar dados campanha (Google Analytics)
2. Gerar insights (Claude)
3. Criar designs visuais (Canva skill)
4. Publicar em redes sociais

Skills permitem Canva "plugar" em qualquer workflow agent
```

**Quote oficial:**
> "Canva plans to leverage Skills to customize agents and expand what they can do. This unlocks new ways to bring Canva deeper into agentic workflows—helping teams capture their unique context and create stunning, high-quality designs effortlessly."  
> — Anwar Haneef, GM & Head of Ecosystem, Canva

---

#### CASE 4: RAKUTEN (Finanças)

**Desafio:**
Processar múltiplas planilhas de contabilidade, detectar anomalias, gerar relatórios seguindo procedimentos internos.

**Manual:** 1 dia completo  
**Com Skills:** 1 hora

**Solução:**
```yaml
Rakuten Finance Skill:
- Carrega procedimentos contábeis (150 páginas de manuais)
- Valida planilhas contra regras (automated checks)
- Detecta anomalias críticas (ex: valor fora do range esperado)
- Gera relatório executivo

Claude processa tudo automaticamente seguindo skill
```

**Quote oficial:**
> "Skills streamline our management accounting and finance workflows. Claude processes multiple spreadsheets, catches critical anomalies, and generates reports using our procedures. What once took a day, we can now accomplish in an hour."  
> — Yusuke Kaji, General Manager AI, Rakuten

**Impacto:** 87% redução de tempo (8h → 1h)

---

### PASSO 6: Skills Avançadas e Comunidade (2min)

#### SKILLS DA COMUNIDADE

**1. Notion Skills (oficial Notion)**
Repositório: https://github.com/notion/skills

Features:
- Criar páginas Notion
- Buscar databases
- Atualizar properties
- Sincronizar com outros sistemas

---

**2. Code Review Skill**
```yaml
O que faz: Revisa código seguindo padrões do time
Checks:
  - Linting (ESLint, Pylint)
  - Security (detecta vulnerabilidades)
  - Performance (identifica bottlenecks)
  - Best practices (SOLID, DRY)

Output: Code review detalhado + sugestões
```

---

**3. Legal Contract Skill**
```yaml
O que faz: Gera contratos jurídicos padronizados
Tipos:
  - NDA
  - Prestação de serviços
  - Termos de uso
  - Contratos de trabalho

Valida: Cláusulas obrigatórias por jurisdição
```

---

**4. Marketing Copy Skill**
```yaml
O que faz: Escreve copy seguindo brand voice
Aplica:
  - Tom específico (casual, formal, técnico)
  - Frameworks (AIDA, PAS)
  - SEO optimization
  - A/B test variations

Caso: "Escreve email campaign para lançamento produto, tom casual, framework AIDA"
```

---

#### ONDE ENCONTRAR MAIS SKILLS

**Marketplaces:**
- GitHub: `topic:claude-skills`
- Claude Code Plugin Marketplace (em-app)
- Anthropic Skills Gallery (futuro)

**Criar e compartilhar:**
```bash
# Publicar no GitHub
gh repo create my-awesome-skill --public
git push

# Tag para discovery
Topics: claude-skills, ai-automation, [seu-domínio]
```

---

## 🎓 SÍNTESE

**O que você dominou:**

### 1. Conceito de Skills
- Skills = Expertise packageada
- Composable, Portable, Efficient, Powerful
- Claude carrega automaticamente quando relevante

### 2. Skills Nativas
- **xlsx:** Excel profissional (fórmulas, gráficos)
- **pptx:** PowerPoint production-ready
- **docx:** Word com tracked changes
- **pdf:** Extração precisa + merge/split

### 3. Criar Skills Customizadas
- Estrutura: SKILL.md + examples + resources
- YAML frontmatter (name, description)
- Instruções markdown
- Testar em Claude Code/API

### 4. Skills do Repositório
- 15+ skills prontas (art, design, dev, enterprise)
- skill-creator (meta skill)
- template-skill (boilerplate)

### 5. Cases Empresariais
- **Box:** 97% redução tempo conversão arquivos
- **Notion:** Perguntas → Ação (segundos)
- **Canva:** Workflows agent + design
- **Rakuten:** 1 dia → 1 hora (finanças)

### 6. Ecossistema
- Comunidade criando skills
- Marketplaces emergindo
- Padrões consolidando

---

## 🚀 COMPARAÇÃO: ANTES vs DEPOIS

| Aspecto | Sem Skills | Com Skills |
|---------|-----------|------------|
| **Setup task** | Explicar contexto toda vez | Explicar 1x (skill), usar sempre |
| **Consistência** | Varia (cada resposta diferente) | 100% consistente (segue skill) |
| **Expertise** | Claude genérico | Claude especialista |
| **Tempo setup** | 5-10min explicando | 0min (skill carregada) |
| **Qualidade output** | 70-80% (precisa ajustes) | 95-99% (production-ready) |
| **Escalabilidade** | Não escala (repetir contexto) | Escala infinito (skill reutilizável) |
| **Compartilhamento** | Difícil (prompts longos) | Fácil (arquivo/repo) |

**Skills não são feature incremental. São PARADIGM SHIFT.**

---

## 💡 QUANDO USAR SKILLS

### ✅ USE SKILLS QUANDO:

1. **Tarefa repetitiva com formato específico**
   - Ex: Relatórios semanais sempre mesma estrutura
   - Ex: Contratos sempre mesmas cláusulas

2. **Necessita seguir padrões/guidelines**
   - Ex: Brand guidelines empresa
   - Ex: Code style guide time

3. **Requer expertise específica**
   - Ex: Planilhas financeiras complexas
   - Ex: Legal contracts com jurisdição específica

4. **Compartilhar expertise com time**
   - Ex: Onboarding novo membro = dar acesso às skills do time
   - Ex: Padronizar outputs entre departamentos

5. **Integração com sistemas/ferramentas**
   - Ex: Skill Notion + Skill Slack = workflow integrado
   - Ex: Skill Box + Skill Excel = conversão automatizada

### ❌ NÃO USE SKILLS QUANDO:

1. **Tarefa única/exploratória**
   - Claude genérico é melhor para brainstorming

2. **Contexto muda constantemente**
   - Skill fica desatualizada rápido

3. **Tarefa simples demais**
   - Overhead de criar skill não vale

---

## 🎯 PRÓXIMOS PASSOS

### Desafio Imediato

**Crie sua primeira skill esta semana:**

**Opções:**
1. **Status Report Skill** (se faz reports periódicos)
2. **Email Template Skill** (se envia emails similares frequentemente)
3. **Brand Guidelines Skill** (visual assets da sua empresa)
4. **Code Review Skill** (padrões do seu time)

**Processo:**
1. Identifica 1 tarefa repetitiva
2. Documenta estrutura/padrões
3. Cria SKILL.md seguindo template
4. Testa com Claude
5. Itera baseado em resultados

---

### Exploração Avançada

**1. Clone repositório oficial:**
```bash
git clone https://github.com/anthropics/skills.git
cd skills
```

**2. Estude skills existentes:**
- Veja como são estruturadas
- Entenda padrões comuns
- Adapte para seu contexto

**3. Contribua:**
- Crie skill útil
- Compartilhe no GitHub
- Ajude comunidade crescer

---

### Integração Empresarial

**Para times/empresas:**

**Fase 1:** Inventário
- Liste top 10 tarefas repetitivas do time
- Identifique quais se beneficiam de skills

**Fase 2:** MVPs
- Crie 2-3 skills prioritárias
- Teste com grupo pequeno
- Itera baseado em feedback

**Fase 3:** Escala
- Roll out para time inteiro
- Cria skill library compartilhada
- Documenta best practices

**Fase 4:** Otimização
- Mensura ROI (tempo economizado)
- Refina skills baseado em uso real
- Adiciona skills conforme necessário

---

## 💭 REFLEXÃO FINAL

**Porque no fundo...**

Skills representam o futuro de como interagimos com IA.

**Passado:** Prompts genéricos → Outputs genéricos

**Presente:** Skills especializadas → Outputs production-ready

**Futuro:** Ecosistema de skills → IA customizada para CADA contexto

**Analogia:**

Sem Skills = Contratar generalista para tudo  
Com Skills = Ter especialistas on-demand para cada tarefa

**Transformação real:**

Você acabou de aprender a transformar Claude de:
- Assistente genérico → Especialista customizado
- 70% útil → 95% production-ready
- Contexto repetido → Expertise packageada

**E o melhor:**

Skills que você criar hoje funcionarão em:
- Claude Code (desktop)
- Claude.ai (web)
- Claude API (seus apps)
- Futuros produtos Anthropic

**Cria 1x, usa everywhere, para sempre.**

**Esse é o poder de Skills.** 🚀

---

## 📚 RECURSOS

### Documentação Oficial
- **Skills Overview:** https://www.anthropic.com/news/skills
- **API Docs:** https://docs.anthropic.com/en/docs/build-with-claude/agent-skills
- **User Guide:** https://support.anthropic.com/en/articles/9940014-using-skills-in-claude

### Repositórios
- **Official Skills:** https://github.com/anthropics/skills
- **Notion Skills:** https://github.com/notion/skills
- **Community Skills:** GitHub topic `claude-skills`

### Aprendizado
- **Anthropic Academy:** Curso completo sobre skills
- **Engineering Blog:** Arquitetura técnica detalhada
- **Case Studies:** Box, Notion, Canva, Rakuten

### Ferramentas
- **Claude Code:** Desktop app com skill management
- **Claude.ai:** Web interface com skill browser
- **Claude API:** Programmatic skill deployment

---

**Instrutor:** José Carlos Amorim  
**Duração:** 30 minutos  
**Framework:** GPS + Didática Lendária + ESPIRAL EXPANSIVA  
**Feature:** Claude Skills (Out/2024 - Game Changer)

---

## 🎉 BÔNUS: SKILL STARTER KIT

Quer começar AGORA? Aqui está template pronto:

```markdown
---
name: [seu-nome-skill]
description: [O que faz + quando usar em 1 frase completa]
---

# [Nome da Skill]

## Objetivo
[O que esta skill resolve]

## Quando Usar
- [Caso de uso 1]
- [Caso de uso 2]

## Estrutura/Formato
[Descreva estrutura do output esperado]

## Validações
- [Validação 1]
- [Validação 2]

## Exemplos
Ver: examples/example1.md
```

**Próximo passo:** Preencher template para SUA necessidade e testar! 💪

---

**Skills = Seu Claude, customizado para SEU mundo.** 🌍✨

