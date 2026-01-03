# Análise de Mercado: Curso Self-Hosting

## O que Existe no Mercado (Concorrência)

### Cursos Formais (Pagos)

| Curso | Foco | Público | Gap |
|-------|------|---------|-----|
| [School of Net](https://www.schoolofnet.com/cursos/infraestrutura/servidores/) | DevOps/Infra geral | Desenvolvedores | Técnico demais |
| [ConFLOSS](https://confloss.com.br/docker-e-kubernetes-curso-com-fabio-silva/) | Docker + Kubernetes (6h) | DevOps | Kubernetes desnecessário p/ empresário |
| [NobleProg Brasil](https://www.nobleprog.com.br/en/docker-training) | Docker corporativo | Empresas grandes | Caro, fora do ICP |

**Gap identificado:** Nenhum curso focado em **empresário não-técnico** que quer economizar dinheiro, não virar DevOps.

---

### Tutoriais Gratuitos (YouTube/Blogs)

| Fonte | Conteúdo | Gap |
|-------|----------|-----|
| [Nine Labs](https://ninelabs.blog/n8n-evolution-api-instalacao-local-rapida-e-facil/) | N8N + Evolution local | Só instalação local, não VPS |
| [Promovaweb](https://promovaweb.com/chatwoot/howto/instalacao-do-chatwoot-e-whatsapp-com-a-evolutuion-api) | Chatwoot + Evolution | Fragmentado, sem jornada completa |
| [Hora de Codar](https://horadecodar.com.br/redirecionar-chatwoot-whatsapp-evolution-api-n8n-midia/) | Integração específica | Avançado, assume conhecimento prévio |
| [Evolution API Docs](https://doc.evolution-api.com/v2/pt/integrations/chatwoot) | Documentação técnica | Muito técnico, sem didática |

**Gap identificado:** Conteúdo fragmentado. Aluno precisa juntar 10 tutoriais diferentes para ter resultado completo.

---

### Ferramentas de Instalação Simplificada

| Ferramenta | O que faz | Público | Gap |
|------------|-----------|---------|-----|
| [OrionDesign/SetupOrion](https://oriondesign.art.br/) | Instala ferramentas via script | Técnicos iniciantes | Ainda requer terminal, sem curso estruturado |
| [CasaOS](https://selfhostedworld.com/software/casaos/) | UI visual para Docker | Homelab enthusiasts | Descontinuado, promovendo ZimaOS (freemium) |
| [Coolify](https://coolify.io/) | PaaS self-hosted | Desenvolvedores | Foco em deploy de apps, não em ferramentas de negócio |
| [Portainer](https://www.portainer.io/) | UI gerenciamento Docker | Todos | Não ensina, só gerencia |

**Gap identificado:** Ferramentas existem, mas **ninguém ensina o empresário a usar** de forma estruturada focada em negócio.

---

## Análise de Gaps (Oportunidades)

### 🔴 Gap 1: Público-Alvo Errado

**O que existe:** Cursos para DevOps, desenvolvedores, técnicos
**O que falta:** Curso para **empresário que fatura R$ 50K-250K/mês** e quer economizar

> **Oportunidade:** Ser o único curso de self-hosting para **não-técnicos focado em ROI**

---

### 🔴 Gap 2: Motivação Errada

**O que existe:** "Aprenda Docker", "Domine containers", "Seja DevOps"
**O que falta:** "**Economize R$ 11.736/ano** trocando ferramentas pagas"

> **Oportunidade:** Vender economia e liberdade, não conhecimento técnico

---

### 🔴 Gap 3: Formato Inadequado

**O que existe:**
- Cursos de 6+ horas sobre Docker/Kubernetes
- Tutoriais de 1h no YouTube
- Documentação técnica extensa

**O que falta:**
- Microlearning 3-8 min
- Implementação em 48h
- Foco no DRE (custo/receita)

> **Oportunidade:** Formato da Nova Formação (GPS) aplicado a self-hosting

---

### 🔴 Gap 4: Jornada Fragmentada

**O que existe:**
- Tutorial de instalar Docker
- Tutorial de instalar N8N
- Tutorial de instalar Chatwoot
- Tutorial de conectar tudo
- (Aluno precisa juntar 5-10 fontes)

**O que falta:**
- Jornada completa do zero ao funcionando
- Única fonte de verdade
- Progressão lógica

> **Oportunidade:** Curso único que leva do "nunca vi terminal" até "Evolution API funcionando"

---

### 🔴 Gap 5: Sem Validação de Resultado

**O que existe:** "Faça isso, pronto"
**O que falta:** "Como saber se funcionou? O que fazer se der erro?"

> **Oportunidade:** Checkpoints claros + troubleshooting integrado

---

### 🔴 Gap 6: Sem Conexão com Negócio

**O que existe:** Foco técnico (container, port, network, volume...)
**O que falta:** Conexão com DRE (quanto economizo? qual o ROI?)

> **Oportunidade:** Cada aula responde "Qual linha do DRE isso mexe?"

---

## Posicionamento Proposto

### Antes (Mercado Atual)

```
"Curso de Docker e Self-Hosting"
- Para desenvolvedores e DevOps
- 6+ horas de conteúdo técnico
- Foco em aprender tecnologia
- Certificado na parede
```

### Depois (Nossa Proposta)

```
"Instalação de Ferramentas Open Source"
- Para empresários que faturam R$ 50K-250K/mês
- Microlearning 3-8 min por aula
- Foco em economizar R$ 11.736/ano
- Prova: ferramentas funcionando em 48h
```

---

## Matriz de Diferenciação

| Atributo | Mercado | Nossa Proposta |
|----------|---------|----------------|
| **Público** | DevOps/Técnicos | Empresários não-técnicos |
| **Motivação** | "Aprenda Docker" | "Economize R$ 11.736/ano" |
| **Formato** | Aulas de 1-2h | Microlearning 3-8 min |
| **Resultado** | Certificado | Ferramentas funcionando |
| **Prazo** | Semanas/meses | 48 horas |
| **Linguagem** | Jargões técnicos | Analogias simples |
| **Validação** | Nenhuma | Checkpoints + troubleshooting |
| **Conexão DRE** | Zero | Em cada aula |

---

## Recomendações Estratégicas

### 1. Posicionamento Único
> "O único curso de self-hosting para empresários que querem economizar, não virar DevOps"

### 2. Promessa Clara
> "Economize R$ 11.736/ano instalando suas próprias ferramentas em 48h"

### 3. Formato ICP-First
- Aulas de 3-8 min (TikTok brain)
- 70% prática, 30% teoria
- Saída implementável em 48h
- Prova de resultado obrigatória

### 4. Stack Focada
Não ensinar "Docker em geral". Ensinar **exatamente** as ferramentas que substituem SaaS:
- Evolution API (substitui Twilio/Z-API)
- Chatwoot (substitui Intercom/Zendesk)
- N8N (substitui Make/Zapier)
- Portainer (gerenciamento visual)

### 5. Ferramenta de Instalação
Usar [OrionDesign](https://oriondesign.art.br/) ou similar para simplificar instalações.
O curso não é sobre "aprender Docker", é sobre "ter ferramentas funcionando".

---

## Fontes da Pesquisa

- [School of Net - Cursos de Servidores](https://www.schoolofnet.com/cursos/infraestrutura/servidores/)
- [ConFLOSS - Docker e Kubernetes](https://confloss.com.br/docker-e-kubernetes-curso-com-fabio-silva/)
- [NobleProg Brasil](https://www.nobleprog.com.br/en/docker-training)
- [Nine Labs - N8N + Evolution API](https://ninelabs.blog/n8n-evolution-api-instalacao-local-rapida-e-facil/)
- [Promovaweb - Chatwoot + Evolution](https://promovaweb.com/chatwoot/howto/instalacao-do-chatwoot-e-whatsapp-com-a-evolutuion-api)
- [OrionDesign](https://oriondesign.art.br/)
- [Coolify](https://coolify.io/)
- [Evolution API Docs](https://doc.evolution-api.com/v2/pt/integrations/chatwoot)
- [Hostinger Docker Hosting](https://www.hostinger.com/docker-hosting)

---

*Análise realizada em: 2026-01-02*
