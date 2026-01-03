# Knowledge Base Técnica
## Curso: Agente de Atendimento, Suporte e Tráfego
### Extraído das transcrições do Professor Denilson

**Data de extração:** 2026-01-02
**Fonte:** 12 transcrições consolidadas

---

## ÍNDICE

1. [Prompts Extraídos](#1-prompts-extraídos)
2. [Configurações de Ferramentas](#2-configurações-de-ferramentas)
3. [Templates e Códigos](#3-templates-e-códigos)
4. [Passo a Passos Técnicos](#4-passo-a-passos-técnicos)
5. [Troubleshooting Guide](#5-troubleshooting-guide)
6. [Custos e Recursos](#6-custos-e-recursos)
7. [URLs e Links Importantes](#7-urls-e-links-importantes)

---

## 1. PROMPTS EXTRAÍDOS

### 1.1 Prompt do Agente de Suporte

**Contexto:** Para atender clientes no pós-venda, resolver problemas, tirar dúvidas.

```
[PROMPT BASE MENCIONADO - EXPANDIR COM MATERIAL COMPLEMENTAR]

Você é a [NOME DO AGENTE] da [EMPRESA].

Seu objetivo é:
- Resolver problemas dos clientes
- Tirar dúvidas sobre produtos/serviços
- Garantir o sucesso do cliente
- Reter e satisfazer o cliente para que ele compre mais vezes

Comportamento:
- Seja prestativo e paciente
- Responda de forma clara e objetiva
- Se não souber responder, encaminhe para humano
```

**Primeira mensagem sugerida:**
```
"Olá! Sou a [Nome] da [Empresa]. Está enfrentando algum problema?
Quer saber sobre nosso curso, mentoria, ou alguma outra coisa?
Estou aqui para ajudar!"
```

---

### 1.2 Prompt do Agente de Atendimento

**Contexto:** Para converter leads em clientes, qualificar, apresentar produtos.

```
[PROMPT BASE MENCIONADO - EXPANDIR COM MATERIAL COMPLEMENTAR]

Você é a [NOME DO AGENTE] da [EMPRESA].

Seu objetivo é:
- Potencializar vendas para leads e clientes
- Qualificar potenciais clientes
- Apresentar produtos e serviços
- Converter leads em clientes

Comportamento:
- Seja proativo mas não agressivo
- Faça perguntas para entender a necessidade
- Apresente soluções relevantes
- Se o lead quiser falar com humano, transfira imediatamente
```

---

### 1.3 Prompt do Agente de Análise de Campanhas (Groq)

**Contexto:** Para analisar métricas de tráfego pago e gerar diagnósticos.

```
Você é um especialista em tráfego pago.

Analise os dados da campanha fornecida e avalie:
- Se a campanha está performando bem ou mal
- Quais métricas estão fora do padrão
- Recomendações de otimização

Seja objetivo e direto no diagnóstico.
```

---

### 1.4 Prompt do Agente de Voz (ElevenLabs)

**Exemplo extraído da demonstração:**
```
"Sou agente de suporte da Academia, como eu posso ajudar?"
```

**Comportamento mencionado:**
- Pode detectar idioma automaticamente
- Pode transferir para agente humano
- Pode encerrar chamada automaticamente se sem resposta (economiza tokens)

---

## 2. CONFIGURAÇÕES DE FERRAMENTAS

### 2.1 Groq (LLM Gratuita)

**O que é:** LLM gratuita que pode ser usada no N8N em vez de OpenAI

**Configuração:**
```yaml
URL Console: console.groq.com
Custo: Gratuito (com limites)
Recomendação do instrutor: "Prefiro o Nano por ter valor mais em conta e resultado bom"
```

**Passo a passo para criar API:**
1. Acessar console.groq.com
2. Criar conta gratuita
3. Ir em "API"
4. Criar nova API key (ex: "aula agente de suporte e atendimento")
5. Copiar o código gerado
6. Colar no N8N no bloco Groq

---

### 2.2 Chatwoot (Central de Atendimento)

**O que é:** Central de atendimento open source que conecta IA + humanos

**Características:**
```yaml
Tipo: Open source
Custo: R$ 50-60/mês (servidor - pode rodar junto com N8N)
Instalação: Via Easy Panel ou Docker
Funcionalidades:
  - Histórico de conversa
  - Múltiplos agentes
  - Múltiplos canais (site, WhatsApp)
  - Transferência IA → Humano
```

**Configuração crítica - Domínio:**
```
⚠️ IMPORTANTE: Sempre colocar domínio SEM o "http://"
Exemplo correto: adminops.lendario.ai
Exemplo errado: http://adminops.lendario.ai
```

---

### 2.3 N8N (Automação)

**O que é:** Ferramenta de automação no-code

**Recursos utilizados no curso:**
```yaml
Chat nativo: Sim (make chat public + embed mode)
Webhook: Para integração com Chatwoot
Agendamento: Para relatórios automáticos (ex: 17h todos os dias)
JavaScript: Para formatação de dados do Meta Ads
```

**Dica de economia de tokens:**
```
Após executar busca de dados, clicar em "Pin" (fixar)
no canto superior direito para não executar novamente
```

---

### 2.4 ElevenLabs (Agente de Voz)

**O que é:** Plataforma para criar agentes de voz com IA

**Configuração:**
```yaml
Custo: Gratuito para testar (10.000 créditos com conta Gmail)
Idioma: Pode configurar português Brasil
Widget: Código embedável para site
```

**Opções de configuração mencionadas:**
- Temperatura (criatividade da IA)
- Escolha de LLM (Gemini recomendado por custo)
- Vozes (várias disponíveis, pode clonar)
- Estabilidade, velocidade, latência, similaridade
- Transferência para humano
- Encerramento automático de chamada
- Modo Alpha (funcionalidades em teste)

---

### 2.5 Evolution API (WhatsApp)

**O que é:** API para conectar WhatsApp ao N8N

**Dados necessários:**
```yaml
Instância: Nome da sua instância
Domínio: URL do seu Evolution
Token: Token de autenticação
Number: Número para enviar (pessoal ou ID do grupo)
```

**Para enviar para grupo:**
1. Executar bloco que lista grupos
2. Pegar o ID do grupo desejado
3. Usar esse ID no campo "number"

---

### 2.6 Meta Ads API (Tráfego Pago)

**O que é:** API para buscar dados de campanhas do Meta

**Dados necessários:**
```yaml
Token: Token de acesso do Meta (ver aula de geração)
Act ID: ID da conta de anúncios
```

**Como encontrar Act ID:**
1. Acessar Ad Manager (facebook.com/adsmanager)
2. Escolher o portfólio/conta
3. O número que aparece na URL é o Act ID

---

## 3. TEMPLATES E CÓDIGOS

### 3.1 Template N8N - Chat de IA no Site

**Funcionalidade:** Chat básico de IA embedável no site

**Estrutura do fluxo:**
```
[Chat Message] → [Agent de IA] → [Groq/OpenAI] → [Memory]
```

**Configuração do Chat Message:**
```yaml
Make chat public: Ativado
Mode: Embed
Chat URL: Copiar para usar na aplicação visual
```

---

### 3.2 Template N8N - Chatwoot + IA

**Funcionalidade:** Integrar N8N com Chatwoot via webhook

**Estrutura do fluxo:**
```
[Webhook] → [Processar mensagem] → [Agent IA] → [Responder Chatwoot]
```

**Configuração da automação no Chatwoot:**
```yaml
Evento: Sempre que atualizar uma mensagem
Condição: For da caixa de entrada X
Ação: Enviar Webhook para URL do N8N
```

---

### 3.3 Template N8N - Relatórios Meta Ads

**Funcionalidade:** Gerar e enviar relatórios diários de tráfego pago

**Estrutura do fluxo:**
```
[Schedule] → [Busca dados Meta] → [Formata JavaScript] → [Envia WhatsApp resumo]
                                                       → [Loop campanhas] → [Análise IA] → [Envia WhatsApp individual]
```

**Métricas extraídas:**
- Quantidade de campanhas rodadas
- Leads gerados
- Investimento total
- Compras
- CPA
- Alcance

**Formato do relatório:**
```
📊 RELATÓRIO DIÁRIO
Empresa: [NOME]
Gerado por: [SISTEMA]

📈 Métricas Gerais:
- Campanhas ativas: X
- Investimento total: R$ X
- Leads gerados: X
- Compras: X
- CPA: R$ X

🎯 Campanhas Analisadas:
[Lista com diagnóstico individual de cada campanha]
```

---

### 3.4 Código para Embedar Chat no Site

**Widget N8N (padrão):**
```html
<!-- Código gerado pela aplicação visual da Academia -->
<!-- Copiar da ferramenta e colar no WordPress/site -->
```

**Widget Chatwoot:**
```html
<!-- Gerado em: Configurações > Caixa de entrada > Copiar código -->
<!-- Domínio DEVE ser configurado corretamente (sem http://) -->
```

**Widget ElevenLabs:**
```html
<!-- Gerado em: Agente > Widget > Copiar link/código -->
<!-- Personalizável: cores, textos, avatar -->
```

---

## 4. PASSO A PASSOS TÉCNICOS

### 4.1 Instalar Chatwoot via Easy Panel

```
1. Já ter Easy Panel instalado
2. Procurar "Chatwoot" nos aplicativos
3. Criar novo projeto (ex: "Chatwoot 2")
4. Selecionar "Chatwoot PT-BR" para versão em português
5. Seguir wizard de configuração
6. Aguardar instalação (alguns minutos)
7. Acessar URL gerada e configurar conta admin
```

---

### 4.2 Criar Caixa de Entrada no Chatwoot

```
1. Acessar Chatwoot > Configurações > Caixa de entrada
2. Clicar "Adicionar caixa de entrada"
3. Escolher "Website"
4. Preencher:
   - Nome: ex. "Teste Aula"
   - Domínio: ex. "academialendaria.com" (SEM http://)
5. Criar caixa de entrada
6. Escolher agentes que terão acesso
7. Copiar código do widget para o site
```

---

### 4.3 Configurar Automação Chatwoot → N8N

```
1. No N8N: Criar fluxo com Webhook de entrada
2. Copiar URL do Webhook
3. No Chatwoot: Configurações > Automação
4. Adicionar regra de automação:
   - Nome: ex. "Enviar para IA"
   - Evento: "Mensagem criada"
   - Condição: Caixa de entrada = [sua caixa]
   - Ação: "Enviar Webhook" + colar URL
5. Salvar automação
6. Testar enviando mensagem pelo widget
```

---

### 4.4 Configurar ElevenLabs Básico

```
1. Criar conta em elevenlabs.io (usar Google)
2. Aceitar termos (10k créditos gratuitos)
3. Criar novo agente:
   - Tipo: Negócios
   - Serviço: Atendimento
   - Website: seu domínio
4. Configurar:
   - Idioma: Português Brasil
   - Primeira mensagem: personalizar
   - Prompt: colar seu prompt
   - Voz: escolher ou clonar
   - LLM: Gemini (custo menor)
5. Em Widget: personalizar avatar e cores
6. Traduzir textos: "Need Help" → "Dúvidas", etc.
7. Copiar código para embedar
```

---

### 4.5 Configurar Relatório Meta Ads no N8N

```
1. Importar template (Ctrl+A, Ctrl+C no JSON, colar no N8N)
2. Configurar bloco "Busca de dados":
   - Token: colar token do Meta
   - Act ID: ID da conta de anúncios
3. Executar teste e "Fixar" (pin) o resultado
4. Configurar bloco Evolution API:
   - Domínio: URL da sua Evolution
   - Instância: nome da sua instância
   - Token: token da Evolution
   - Number: número/grupo para envio
5. Configurar bloco Groq:
   - Criar API key no console.groq.com
   - Colar no N8N
6. Personalizar nome da empresa no JavaScript
7. Salvar e Ativar fluxo
8. Configurar agendamento (ex: 17h diariamente)
```

---

## 5. TROUBLESHOOTING GUIDE

### Problema: Widget não aparece no site
```
Causa: Domínio configurado incorretamente
Solução: Verificar se colocou SEM o "http://" e SEM "/" no final
```

### Problema: IA não responde no Chatwoot
```
Causa: Automação não configurada ou Webhook errado
Solução:
1. Verificar se automação está ativa
2. Verificar se Webhook URL está correta
3. Verificar se fluxo N8N está ativado (seta verde)
4. Testar Webhook manualmente
```

### Problema: Token do Meta inválido
```
Causa: Token expirado ou permissões incorretas
Solução: Gerar novo token seguindo a aula de configuração
```

### Problema: Relatório não envia para WhatsApp
```
Causa: Configuração Evolution incorreta
Solução:
1. Verificar instância, domínio e token
2. Se for grupo, usar o ID do grupo (não o número)
3. Verificar se número tem WhatsApp ativo
```

### Problema: Gastando muitos tokens no N8N
```
Solução: Usar "Pin" (fixar) no bloco de busca de dados
após primeira execução bem-sucedida
```

### Problema: Textos em inglês no ElevenLabs
```
Solução: Ir em Widget e traduzir manualmente:
- "Need Help" → "Dúvidas"
- "Start call" → "Iniciar ligação"
- "End call" → "Finalizar ligação"
```

---

## 6. CUSTOS E RECURSOS

### Tabela de Custos Mensais

| Ferramenta | Plano Gratuito | Plano Pago |
|------------|----------------|------------|
| N8N Cloud | Sim (limitado) | ~$20/mês |
| N8N Self-hosted | Sim (ilimitado) | ~R$50-60/mês servidor |
| Chatwoot | Open source | ~R$50-60/mês servidor |
| Groq | Sim (10k tokens?) | Pay-as-you-go |
| ElevenLabs | 10k créditos | Vários planos |
| Evolution API | Depende hosting | Varia |
| Meta Ads API | Gratuita | Gratuita |

### Investimento Mínimo Recomendado
```
R$ 50-200/mês (servidor compartilhado para N8N + Chatwoot)
```

---

## 7. URLs E LINKS IMPORTANTES

### Ferramentas Principais
```
N8N:          https://n8n.io
Chatwoot:     https://chatwoot.com
Groq:         https://console.groq.com
ElevenLabs:   https://elevenlabs.io
Easy Panel:   https://easypanel.io
```

### Meta/Facebook
```
Ad Manager:   https://facebook.com/adsmanager
Developers:   https://developers.facebook.com
```

### Aplicação da Academia (mencionada)
```
Editor Visual N8N Chat: [Link no material da aula]
Teste iframe: [Link no material da aula]
```

---

## 8. GLOSSÁRIO TÉCNICO

| Termo | Significado |
|-------|-------------|
| LLM | Large Language Model (modelo de IA) |
| Token | Unidade de processamento de texto na IA |
| Webhook | URL que recebe dados de outro sistema |
| Embed | Incorporar/adicionar código em outro site |
| Widget | Componente visual incorporável |
| Act ID | ID da conta de anúncios do Meta |
| Instância | Conexão específica do WhatsApp na Evolution |
| CPA | Custo Por Aquisição |
| Lead | Potencial cliente que demonstrou interesse |
| Handoff | Transferência de IA para humano |

---

**Knowledge Base preservada em:** 2026-01-02
**Extraída de:** 12 transcrições originais (~78 minutos)
**Observação:** Alguns prompts/templates são mencionados como "material complementar da aula" - verificar se existem arquivos adicionais na pasta do curso.
