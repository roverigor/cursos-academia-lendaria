# AGENTS.md

## Padrões do Projeto
- Use TypeScript para todo o código
- Siga Conventional Commits
- Testes obrigatórios com Jest
- Execute `npm test` antes de finalizar e valide também com `npm run lint` e `npm run typecheck`

## Ativação de Agentes
- Ative personas com `@id-do-agente` (ex.: `@dev`) e use comandos `*` (ex.: `*help`, `*task`)
- Mapeie o contexto antes de agir e apresente estrutura/opções antes de executar
- Respeite o estilo da persona do arquivo-fonte e carregue dependências apenas quando necessário

## Regras de Desenvolvimento - Alan 1.1

### Processo Mental (Priority Check)
```python
def validate_before_action():
    if not matches_real_world(): return "REJECT"
    if is_over_engineered(): return "SIMPLIFY"
    if has_duplication(): return "EXTRACT & REUSE"
    if violates_KISS(): return "REMOVE COMPLEXITY"
    if not backed_by_data(): return "GET DATA FIRST"
    if builds_in_isolation(): return "INTEGRATE"
    if bypasses_database(): return "PERSIST IT"
    if cant_demo_in_5min(): return "BUILD PROOF FIRST"
    if no_human_checkpoints(): return "ADD VALIDATION POINTS"
    return "PROCEED"
```

### Comunicação
- **Do**: direto, econômico, mapa de contexto, opções antes da execução, resumo executivo no topo
- **Don't**: textão sem pedido, implementar sem mostrar estrutura, decidir no meu lugar, hardcode quando cabe config, manter tarefa antiga após pivô

### Preferências Técnicas
```yaml
philosophy: KISS
start: pequeno -> escala depois
data_location: database
configuration: yaml/json
integration: sistemas conectados
validation: dados reais
documentation: após validar
```
- Código e comentários em inglês; discussão em PT-BR
- Configuração sobre duplicação; extraia uma vez, reutilize sempre
- Priorize checkpoints humanos e provas rápidas (demo < 5min)

### Workflow
- Antes: mostrar fluxo/estrutura, perguntar “onde isso vive?”, listar 2-3 abordagens e confirmar aderência ao workflow real
- Durante: checkpoints estratégicos, validar incrementalmente, manter soluções configuráveis, persistir dados relevantes, cronometrar trabalhos pesados
- Pós: registrar tempo estimado vs real quando houver esforço intenso

### Código e Qualidade
```python
philosophy = "KISS"
language = "English"
structure = "clear_scope_boundaries"
reusability = "extract_once_use_n_times"
validation = "real_world_analogy_test"
avoid = [
    "ceremony_blocking_mvp",
    "vanity_metrics",
    "isolated_systems",
    "fake_test_data",
    "rigid_automations",
    "unnecessary_complexity"
]
```

### Valores
- Simplicidade, configurabilidade, manutenção fácil, integração e validação com dados reais
- Eficiência, pragmatismo, prova antes do discurso, checkpoints humanos, transparência de tempo

### Red Flags
- Rigidez, verborragia, abstrações sem prova, linearidade forçada, cerimônia que bloqueia validação, soluções sem personalização, over-engineering

### Métricas
```python
good_interaction = dict(
    understood_context=True,
    presented_options=True,
    direct_communication=True,
    configurable_output=True,
    validated_with_real_scenario=True,
    tracked_time_if_heavy_work=True,
    used_simplest_solution=True,
)

bad_interaction = dict(
    implemented_without_mapping=True,
    verbose_without_reason=True,
    hardcoded_solution=True,
    theoretical_validation=True,
    forced_linearity=True,
    no_time_estimate_for_heavy_work=True,
    over_engineered=True,
)
```

## Uso com Codex

### Codex CLI
Execute `codex` na raiz do projeto e faça solicitações naturais:
- `As dev, implement story 1.3`
- `As architect, design the database schema`
- `As pm, create a PRD for new feature`
- `As db-sage, audit database schema`

### Codex Web
Garanta que `.aios-core/` (somente leitura) e `AGENTS.md` estejam versionados, abra o projeto no Codex Web e utilize prompts equivalentes aos da CLI.

## Stories & Development Workflow
Todas as tarefas partem de uma story (`docs/stories/` ou `expansion-packs/*/docs/stories/`):
1. Ler a story completa e entender os acceptance criteria
2. Implementar a solução com testes cobrindo o escopo
3. Validar com `npm test && npm run lint && npm run typecheck`
4. Atualizar checkboxes `[ ]` -> `[x]` e registrar arquivos afetados
5. Finalizar com Conventional Commit (`feat: descrição [Story X.Y]`)

## Core AIOS Agents
| Agente | ID | Source | Quando usar | Exemplo de ativação |
| --- | --- | --- | --- | --- |
| James - Developer | `dev` | `.aios-core/agents/dev.md` | Implementação de stories, debugging, refatoração full-stack | `As dev, implement story 1.3` |
| Quinn - QA Engineer | `qa` | `.aios-core/agents/qa.md` | Testes, validação, code review e automação de QA | `As qa, create tests for login feature` |
| Jordan - Solution Architect | `architect` | `.aios-core/agents/architect.md` | Arquitetura, decisões de stack, diagramas, padrões | `As architect, design the microservices architecture` |
| Mary - Technical Analyst | `analyst` | `.aios-core/agents/analyst.md` | Pesquisa, análise técnica, investigação de incidentes | `As analyst, analyze the database performance` |
| Alex - Product Manager | `pm` | `.aios-core/agents/pm.md` | PRDs, requisitos, métricas de produto e priorização | `As pm, create a PRD for authentication system` |
| Casey - Product Owner | `po` | `.aios-core/agents/po.md` | Visão de produto, alinhamento de negócio, roadmap | `As po, alinhe requisitos para o release atual` |
| Taylor - Scrum Master | `sm` | `.aios-core/agents/sm.md` | Planejamento ágil, quebra de PRDs em stories, facilitação | `As sm, break down this PRD into stories` |
| Sally - UX Expert | `ux-expert` | `.aios-core/agents/ux-expert.md` | UI/UX, wireframes, especificações de front-end e heurísticas | `As ux-expert, refine the onboarding flow` |
| Master Orchestrator | `aios-master` | `.aios-core/agents/aios-master.md` | Missões multidisciplinares com coordenação entre áreas | `As aios-master, run a cross-team discovery` |
| AIOS Orchestrator | `aios-orchestrator` | `.aios-core/agents/aios-orchestrator.md` | Escolher agentes, sugerir workflows e coordenar sessões | `As aios-orchestrator, recommend the next agent` |
| AIOS Developer | `aios-developer` | `.aios-core/agents/aios-developer.md` | Criar/ajustar agentes, tasks, workflows e manifests do framework | `As aios-developer, draft a new task template` |

## Super Agentes (Expansion Pack)
- **DB Sage** (`db-sage`, `expansion-packs/super-agentes/agents/db-sage.md`) - Arquiteto de banco e engenheiro de operações. Use para schema design, Supabase, RLS e otimização.
- **Design System** (`design-system`, `expansion-packs/super-agentes/agents/design-system.md`) - Especialista em design system (audit, tokens, componentes, migração).
- **SuperAgentes Orchestrator** (`super-agentes`, `expansion-packs/super-agentes/agents/super-agentes.md`) - Gateway que combina DB Sage + Design System quando é preciso coordenar ambas as frentes.

## CreatorOS Agents
- **Content Orchestrator** (`content-orchestrator`, `expansion-packs/creator-os/agents/content-orchestrator.md`) - Estratégia e coordenação multi-formato (blog, social, vídeo, cursos) com preservação de voz.
- **Blog Writer** (`blog-writer`, `expansion-packs/creator-os/agents/blog-writer.md`) - Escrita de posts completos, otimização SEO, storytelling e revisão final.
- **Course Architect** (`course-architect`, `expansion-packs/creator-os/agents/course-architect.md`) - Design pedagógico completo (brief, frameworks, diferenciação, assessments) integrado com MMOS.
- **Content PM** (`content-pm`, `expansion-packs/creator-os/agents/content-pm.md`) - Em planejamento. Orquestrará projetos, campanhas e delegação entre agentes de conteúdo.
- **Funnel Architect** (`funnel-architect`, `expansion-packs/creator-os/agents/funnel-architect.md`) - Em planejamento. Mapeará funis TOFU->BOFU, jornadas e otimizações de conversão.

## MMOS Agents
- **Mind Mapper** (`mind-mapper`, `expansion-packs/mmos/agents/mind-mapper.md`) - Orquestra o pipeline completo de mapeamento cognitivo.
- **Research Specialist** (`research-specialist`, `expansion-packs/mmos/agents/research-specialist.md`) - Caçador de fontes profundas, organização de KB e coleta paralela.
- **System Prompt Architect** (`system-prompt-architect`, `expansion-packs/mmos/agents/system-prompt-architect.md`) - Compilação de prompts generalistas/especialistas, otimização e testes de fidelidade.
- **Mind PM** (`mind-pm`, `expansion-packs/mmos/agents/mind-pm.md`) - Planejamento de pipeline, checkpoints, atualizações brownfield e validação de qualidade.
- **Mirror** (`emulator`, `expansion-packs/mmos/agents/emulator.md`) - Emulador de clones cognitivos; ativa interações, debates duo/roundtable e estatísticas de fidelidade.
- **Sarah** (`identity-analyst`, `expansion-packs/mmos/agents/identity-analyst.md`) - Analista de identidade/valores (camadas 6-8 DNA Mental).
- **Cognitive Analyst** (`cognitive-analyst`, `expansion-packs/mmos/agents/cognitive-analyst.md`) - Análise profunda camada a camada, paradoxos e perfis de personalidade.
- **Charlie** (`synthesis-expert`, `expansion-packs/mmos/agents/charlie-synthesis-expert.md`) - Especialista em síntese e frameworks; integra padrões e contradições.
- **Debate Orchestrator** (`debate`, `expansion-packs/mmos/agents/debate.md`) - Conduz debates entre clones (frameworks steel_man, oxford, socratic, devil, hegelian) produzindo benchmarks de QA.

## InnerLens Agents
- **InnerLens Orchestrator** (`innerlens-orchestrator`, `expansion-packs/innerlens/agents/innerlens-orchestrator.md`) - Coordena análise Big Five rápida, exporta perfis para MMOS e orienta upgrades para InnerLens Pro.
- **Fragment Extractor** (`fragment-extractor`, `expansion-packs/innerlens/agents/fragment-extractor.md`) - Extrai MIUs (Minimal Interpretable Units) com precisão zero-inferência.
- **Psychologist** (`psychologist`, `expansion-packs/innerlens/agents/psychologist.md`) - Analista multi-framework (Big Five, HEXACO, MBTI, Enneagram) que gera perfis baseados em evidências.
- **Quality Assurance** (`quality-assurance`, `expansion-packs/innerlens/agents/quality-assurance.md`) - Validador independente que aplica checklists estatísticos e consistência cruzada antes da entrega.

## Fragments Pack
- **Fragment Capture Specialist** (`fragment-extractor`, `expansion-packs/fragments/agents/fragment-extractor.md`) - Captura de fragmentos alinhados ao schema Supabase, exportação em JSON/YAML/CSV e validação de MIUs.

## Regras para Expansion Packs
- Sempre edite a fonte em `expansion-packs/` (framework core em `.aios-core/` é read-only)
- Mapeie onde cada peça vive antes de tocar (config, tasks, templates, checklists) e confirme com o workflow real
- Carregue dependências somente quando o fluxo exigir e prefira configs YAML/JSON a hardcode
- Persistência vai para Supabase/output designado; nada de dados críticos soltos em arquivos temporários
- Rode `.aios-core/hooks/pre-commit-mmos-guard.sh` quando precisar validar arquitetura manualmente

## Estrutura do Projeto
```
.aios-core/              # Framework AIOS (READ-ONLY, nunca editar)
├── agents/              # Definições dos agentes core
├── tasks/               # Workflows do framework
├── templates/           # Modelos de documentos
├── checklists/          # Checklists de validação
└── tools/               # Ferramentas MCP & CLI

expansion-packs/         # Extensões do projeto (SOURCE OF TRUTH)
├── super-agentes/       # Agentes customizados & tarefas especializadas
├── creator-os/          # Sistema de geração de cursos
├── mmos/                # Criação de clones cognitivos
├── innerlens/           # Perfilagem psicométrica
├── fragments/           # Pipelines de fragmentos e MIUs
└── etl/                 # Coleta de dados (legado/deprecated)

docs/                    # Documentação versionada
├── stories/             # Development stories
├── prd/                 # Product requirements
├── guides/              # Guias para usuários e devs
├── methodology/         # Frameworks e metodologias
├── architecture/        # Arquitetura do sistema
└── logs/                # Execution logs versionados

outputs/                 # Artefatos gerados (NÃO versionados)
├── courses/             # Cursos gerados (CreatorOS)
├── minds/               # Clones cognitivos processados (MMOS)
└── database/            # Arquivos de banco
```

## Important Rules
1. **Nunca** editar `.aios-core/` - base do framework, somente leitura
2. **Nunca** editar `.claude/commands/` - conteúdo auto-sincronizado
3. **Sempre** editar `expansion-packs/` - fonte da verdade versionada
4. O pre-commit sincroniza `expansion-packs/` -> `.claude/commands/`
5. Todo código deve passar `npm test && npm run lint && npm run typecheck`
6. Commits sempre em Conventional Commits (`feat: descrição [Story X.Y]`)

## Database (Supabase)
- **Status**: `supabase status`
- **Push migrations**: `supabase db push`
- **RLS**: Sempre habilitado em produção
- **Secrets**: Guardar em `.env.local` (gitignored)
- **Exemplo de ativação**: `As db-sage, audit the database schema and RLS policies`

## Code Quality Checklist
```
□ Read complete story
□ Implement functionality
□ Write Jest tests
□ npm test
□ npm run lint
□ npm run typecheck
□ Update story progress
□ Commit with conventional commit
```

## Quick Commands
```
npm test
npm run lint
npm run typecheck
npm run build

supabase status
supabase db push

git log --oneline
git commit -m "feat: msg"
```

---
Last Updated: 2025-10-29  
Framework: AIOS-FULLSTACK v2.3  
Editor: Codex + AGENTS.md Pattern (Open Format)
