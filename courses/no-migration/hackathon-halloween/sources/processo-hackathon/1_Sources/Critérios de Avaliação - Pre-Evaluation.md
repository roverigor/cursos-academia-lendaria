# Critérios de Avaliação - Pre-Evaluation Agent v2.0

## Documento Executivo

**Data:** 17 de outubro de 2025  
**Versão:** 2.0  
**Autor:** Sistema de Avaliação de Portfólios para Clones Psicológicos

---

## 1. Visão Geral do Sistema

O Pre-Evaluation Agent foi desenvolvido para avaliar portfólios de fontes (entrevistas, artigos, podcasts, etc.) que serão usados para criar clones psicológicos de alta fidelidade. O sistema opera em duas dimensões críticas:

### 1.1 Dupla Lente de Avaliação

**LENTE 1: AUTENTICIDADE PSICOLÓGICA**
- Captura quem a pessoa É
- Profundidade de valores, crenças e identidade
- Vulnerabilidade e autenticidade do conteúdo
- Evolução temporal do pensamento

**LENTE 2: CREDIBILIDADE DE EXPERTISE**
- Captura o que a pessoa SABE
- Conhecimento prático e aplicado
- Frameworks e heurísticas reproduzíveis
- Casos reais e trade-offs específicos

**Princípio Core:** Um clone com apenas personalidade é performativo. Um clone com apenas fatos é inautêntico. Ambos são necessários.

---

## 2. Sistema de Pontuação (0-10)

### 2.1 Componentes e Pesos

O score final é calculado através de 6 componentes:

| Componente | Peso | O que Avalia |
|------------|------|--------------|
| Signature Understanding | 15% | Fases de carreira, estilo de comunicação, evolução |
| Psychological Depth | 25% | Camadas psicológicas, vulnerabilidade, autenticidade |
| Expertise Coverage | 25% | Maestria técnica, conhecimento prático, case studies |
| Source Quality | 15% | Proveniência, signal-to-noise, credibilidade |
| Portfolio Balance | 15% | Diversidade de tipos, temporal, contextual |
| Gap Awareness | 5% | Cobertura de domínios, identificação de lacunas |

**Fórmula:**
```
Score Final = (Signature × 0.15) + (Psych × 0.25) + (Expertise × 0.25) + 
              (Quality × 0.15) + (Balance × 0.15) + (Gaps × 0.05)
```

### 2.2 Interpretação de Grades

| Score | Grade | Significado |
|-------|-------|-------------|
| 9.0-10.0 | EXCELLENT | Pronto para extração |
| 8.0-8.9 | VERY GOOD | Melhorias menores recomendadas |
| 7.0-7.9 | GOOD | Fortalecer áreas específicas |
| 6.0-6.9 | ADEQUATE | Trabalho significativo necessário |
| 5.0-5.9 | NEEDS WORK | Gaps maiores presentes |
| 0.0-4.9 | INSUFFICIENT | Problemas fundamentais |

---

## 3. Critério 1: Signature Understanding (15%)

### 3.1 O que Avalia

Entendimento da "assinatura" da pessoa através de diferentes fases de vida e carreira:
- Identificação de fases (formativa, crescimento, maturidade, atual)
- Estilo de comunicação consistente
- Arcos de identidade visíveis
- Evolução temporal documentada

### 3.2 Sistema de Pontuação

**9-10 pontos:** Todas as fases cobertas, evolução clara e bem documentada  
**7-8 pontos:** 3 fases cobertas, alguma evolução visível  
**5-6 pontos:** 2 fases cobertas, evolução limitada  
**3-4 pontos:** Apenas uma fase (snapshot, não evolução)  
**0-2 pontos:** Span temporal menor que 2 anos (não utilizável)

### 3.3 Critérios Específicos

**Distribuição Temporal Ideal:**
- Últimos 2 anos (atual): 40-50% das fontes
- 3-4 anos atrás (recente): 20-30%
- 5-8 anos atrás (contexto): 15-20%
- 9+ anos atrás (formativo): 5-15%

**Red Flag:** Se 80%+ das fontes vêm de uma janela de 6 meses = tour promocional, não autêntico.

---

## 4. Critério 2: Psychological Depth (25%)

### 4.1 Sistema de 10 Camadas

O agente classifica conteúdo em 10 camadas psicológicas:

**CAMADAS ALTAS (6-10) - Alta Prioridade:**
- Layer 10: Identidade core existencial ("Eu sou fundamentalmente X")
- Layer 9: Identidade profunda ("Eu me vejo como X")
- Layer 8: Padrões de identidade ("Sou o tipo de pessoa que X")
- Layer 7: Valores core ("O que mais importa é X" + por quê + trade-offs)
- Layer 6: Crenças profundas ("Acredito em X porque Y")

**CAMADAS MÉDIAS (3-5):**
- Layer 5: Crenças operacionais ("X é verdade")
- Layer 4: Opiniões consideradas ("Acho que X")
- Layer 3: Opiniões superficiais ("X parece certo")

**CAMADAS BAIXAS (0-2):**
- Layer 2: Preferências ("Prefiro X a Y")
- Layer 1: Fatos sobre pessoa ("Trabalho em X, moro em Y")
- Layer 0: Fatos públicos ("Pessoa X nasceu em Y")

### 4.2 Cálculo de Depth Score

```
Depth Score = (% High Layer × 1.0) + (% Mid Layer × 0.5) + (% Low Layer × 0.1)
```

**Exemplo:**
- 60% camada alta = 0.60
- 30% camada média = 0.15
- 10% camada baixa = 0.01
- **Total = 0.76 = Score 7.6/10**

### 4.3 Sinais de Vulnerabilidade

O agente conta sinais específicos de autenticidade:

**TIER 1 (mais forte):**
- Admite falha específica com detalhes
- Questiona própria crença core
- Descreve conflito interno não resolvido
- Compartilha medo/ansiedade específica
- Auto-depreciação com reflexão genuína

**TIER 2 (moderado):**
- Admite incerteza ("não sei", "ainda descobrindo")
- Descreve erro passado
- Reconhece limitação
- Discute luta emocional
- Contradiz declaração própria anterior

**TIER 3 (fraco mas presente):**
- Pausas longas (transcript mostra "...")
- Auto-interrupções, revisões mid-sentence
- Vai off-topic quando apaixonado
- Usa hedging genuinamente ("talvez", "acho")

**Sistema de Pontuação por Sinais:**
- 20+ sinais Tier 1 = Excelente (9-10)
- 10-20 sinais Tier 1 = Muito bom (8-9)
- 5-10 sinais Tier 1 = Bom (7-8)
- 1-5 sinais Tier 1 = Adequado (6-7)
- 0 sinais Tier 1 = Pobre (0-5)

### 4.4 Performance Mode vs Autenticidade

O agente detecta quando a pessoa está em "modo marketing":

**Indicadores de Performance Mode (anti-sinais):**
- Toda resposta volta ao produto sendo promovido
- Zero admissão de incerteza
- Histórias perfeitas e ensaiadas
- Defensivo quando desafiado
- Platitudes genéricas
- Respostas curtas e media-trained

**Penalidades:**
- 10-25% marketing mode = -0.5 ponto
- 25-50% marketing mode = -1.5 pontos
- 50-75% marketing mode = -3.0 pontos
- 75-100% marketing mode = -5.0 pontos (inutilizável)

---

## 5. Critério 3: Expertise Coverage (25%)

### 5.1 Sistema de 5 Níveis

Para cada domínio de expertise necessário:

**NÍVEL 5 (MASTERY):**
- Pode inventar frameworks novos
- Debug trabalho de outros
- Evidência: pesquisa original, citações por peers, ensino avançado

**NÍVEL 4 (EXPERT):**
- Conhecimento profundo de domínio
- Explica trade-offs
- Evidência: múltiplos case studies, decisões com rationale, "por que X falha"

**NÍVEL 3 (PRACTITIONER):**
- Pode executar bem
- Conhece playbook padrão
- Evidência: descreve projetos próprios, referencia frameworks comuns

**NÍVEL 2 (INFORMED):**
- Entende conceitos
- Pode discutir inteligentemente
- Evidência: conhecimento de livros, explica ideias populares, sem aplicação pessoal

**NÍVEL 1 (NOVICE):**
- Conhecimento superficial
- Sem experiência prática
- Evidência: apenas referencia trabalho de outros, generalidades vagas

### 5.2 Sistema de Pontuação por Domínio

```
- Nível 5: 10 pontos
- Nível 4: 8 pontos
- Nível 3: 6 pontos
- Nível 2: 4 pontos
- Nível 1: 2 pontos

Score de Expertise = Média através dos domínios requeridos
```

### 5.3 Indicadores de Conhecimento Prático

**SINAIS FORTES:**
- War stories ("Quando tivemos problema X, tentamos Y, falhou, depois Z funcionou")
- Ferramentas específicas ("Usamos Postgres não MySQL por constraint X")
- Failure modes ("Abordagem X sempre falha quando Y acontece")
- Trade-off articulation ("X dá benefício A mas custa B")
- Edge cases ("Abordagem padrão funciona exceto quando...")

**SINAIS FRACOS:**
- Conselho genérico ("Construa produtos ótimos")
- Credential dropping ("Como PhD em X...")
- Name dropping ("Conheço pessoa Y que...")
- Referências vagas ("Nos meus projetos...")
- Teoria apenas (cita papers mas sem aplicação)

**Pontuação:**
- 10+ sinais fortes por domínio = Deep expertise (9-10)
- 5-10 sinais fortes = Sólida expertise (7-8)
- 2-5 sinais fortes = Básica expertise (5-6)
- 0-2 sinais fortes = Questionável (0-4)

### 5.4 Domínios Críticos por Role

O agente identifica 3-5 domínios CRÍTICOS para o role específico:

**Exemplo: AI Advisor for Startups**
- ML architectures (transformers, CNNs, etc.)
- Training at scale (distributed training, optimization)
- PMF for AI products (go-to-market, user adoption)
- Fundraising strategy (pitch, timing, valuation)
- Team building (hiring, culture, org structure)

**Red Flag:** Se qualquer domínio crítico está em Nível 2 ou abaixo = problema grave.

---

## 6. Critério 4: Source Quality (15%)

### 6.1 Proveniência: Primary vs Secondary vs Tertiary

**PRIMARY (maior valor):**
- Pessoa fala/escreve diretamente
- Account em primeira pessoa
- Criação original
- Exemplos: entrevista onde pessoa é convidada, essay por pessoa, podcast próprio

**SECONDARY (valor médio):**
- Alguém observa pessoa diretamente
- Account de observador de primeira mão
- Experiência reportada
- Exemplos: artigo de perfil com acesso direto, biografia com entrevistas, observações de colegas

**TERTIARY (baixo valor):**
- Reportando sobre reportagem
- Accounts de segunda mão
- Agregação sem acesso original
- Exemplos: artigo citando outros artigos, peças de resumo, compilação sem novas entrevistas

**Target Ideal:**
- 60-70% primary
- 20-30% secondary
- <10% tertiary

**Penalidade:** >30% tertiary = -2 pontos

### 6.2 Signal-to-Noise Ratio

**HIGH SIGNAL:**
- Longform (60min+ / 2000+ palavras)
- Reflexivo (pessoa pensando em voz alta, não scripted)
- Específico (nomes, datas, exemplos concretos)
- Vulnerável (admite falhas, incertezas)
- Denso (cada parágrafo tem insight)

**LOW SIGNAL:**
- Shortform (<15min / <500 palavras)
- Scripted (ensaiado, media-trained)
- Vago (conselho genérico, sem específicos)
- Performativo (marketing mode)
- Thin (mostly filler, poucos insights)

**Cálculo:**
- Classifica cada fonte: High (3) / Medium (2) / Low (1)
- Média = (soma dos scores) / (número de fontes)
- Target: Média 2.3+ (mostly high/medium signal)

### 6.3 Credibilidade de Observadores (fontes third-party)

Para cada fonte de observador, avaliar:

**RELACIONAMENTO:**
- Amigo próximo (10+ anos, interação frequente)
- Colega de longo prazo (5+ anos, interação diária)
- Peer profissional (2-5 anos, interação regular)
- Conhecimento breve (<2 anos, interação ocasional)
- Observador distante (sem relacionamento direto)

**CREDIBILIDADE:**
- Muito alta: Interação direta e sustentada por anos
- Alta: Interação regular, profundidade profissional
- Média: Alguma interação, conhecimento superficial
- Baixa: Interação limitada, mostly impressões
- Muito baixa: Sem interação direta, hearsay

**VIÉS:**
- Fortemente positivo (admirador, fã, mentee)
- Levemente positivo (amigável, suportivo)
- Neutro (distância profissional)
- Levemente negativo (crítico, cético)
- Fortemente negativo (oponente, antagonista)

**Red Flag:** Todos os observadores são admiradores fortemente positivos = echo chamber (-1 ponto)

---

## 7. Critério 5: Portfolio Balance (15%)

### 7.1 Distribuição por Tipo de Fonte

**CONVERSATIONAL (entrevistas, podcasts, painéis):**
- Ideal: 40-50% do portfólio
- Por quê: Mostra processo de pensamento, personalidade, conforto

**WRITTEN (essays, artigos, livros pela pessoa):**
- Ideal: 25-35% do portfólio
- Por quê: Pensamento refinado, tópicos escolhidos pela pessoa

**OBSERVATIONAL (perfis, biografias, third-party):**
- Ideal: 20-30% do portfólio
- Por quê: Validação, blind spots, evidência comportamental

**TECHNICAL (papers, documentação, código, case studies):**
- Ideal: Varia por role (0-30%)
- Por quê: Evidência de expertise, aplicação prática

**Pontuação:**
- Balanceado (todos os tipos em ratios saudáveis) = 9-10
- Levemente desbalanceado (um tipo 60-70%) = 7-8
- Desbalanceado (um tipo >70%) = 5-6
- Fortemente desbalanceado (um tipo >85%) = 0-4

### 7.2 Diversidade Contextual

**PROFESSIONAL (trabalho, eventos de indústria, negócios):**
- Target: 40-50%
- Mostra: Expertise, persona profissional, decision-making sob constraints

**PHILOSOPHICAL/INTELLECTUAL (ideias, significado, abstrato):**
- Target: 25-35%
- Mostra: Valores, worldview, pensamento big-picture

**PERSONAL (família, hobbies, histórias de vida):**
- Target: 15-25%
- Mostra: Self autêntico, experiências formativas, o que importa privadamente

**CASUAL (informal, desguardado, social):**
- Target: 5-15%
- Mostra: Personalidade não filtrada, humor, como pessoa relaxa

**Pontuação:**
- Todos os contextos representados = 9-10
- Faltando um contexto = 7-8
- Apenas 1-2 contextos = 0-5

**Por que importa:** Pessoa em modo trabalho ≠ pessoa em modo filosófico ≠ pessoa em modo casual. Precisa de todos três para clone autêntico e dimensional.

### 7.3 Balanço Self-Report vs Third-Party

**SELF-REPORT (pessoa se descrevendo):**
- Target: 70-80%
- Valor: Acesso direto ao mundo interno
- Risco: Viés potencial, blind spots

**THIRD-PARTY OBSERVATION (outros descrevendo pessoa):**
- Target: 20-30%
- Valor: Validação, perspectiva alternativa, evidência comportamental
- Risco: Viés de observador, acesso limitado ao mundo interno

**Pontuação:**
- 70-80% self-report, 20-30% third-party = 9-10
- 60-70% self-report, 30-40% third-party = 8-9
- 50-60% self-report, 40-50% third-party = 7-8
- >90% self-report, <10% third-party = 5-6 (precisa validação)
- >50% third-party, <50% self-report = 4-5 (precisa acesso interno)

---

## 8. Critério 6: Gap Awareness (5%)

### 8.1 Cobertura de 10 Domínios Psicológicos

Para cada domínio, avaliar cobertura (0-100%):

**1. MOTIVATION (o que dirige pessoa)**
- Motivadores intrínsecos e extrínsecos
- Target: 3-5 fontes fortes

**2. VALUES (o que mais importa)**
- Valores core explicitamente declarados
- Valores revelados através de trade-offs
- Target: 3-5 fontes fortes

**3. FEARS/ANXIETIES (o que pessoa evita/preocupa)**
- Medos explícitos discutidos
- Padrões de evitação visíveis
- Target: 2-4 fontes (mais difícil de encontrar)

**4. DECISION PROCESS (como pessoa faz escolhas)**
- Heurísticas de decisão
- Frameworks de trade-off
- Target: 3-5 fontes fortes

**5. FORMATIVE EXPERIENCES (histórias de origem, turning points)**
- Influências de infância
- Pivots de carreira
- Momentos definidores
- Target: 2-4 fontes

**6. RELATIONSHIP PATTERNS (como pessoa se relaciona com outros)**
- Estilo de liderança
- Abordagem de colaboração
- Handling de conflito
- Target: 3-4 fontes

**7. SELF-PERCEPTION (como pessoa se vê)**
- Declarações de identidade
- Auto-descrições
- Strengths/weaknesses reconhecidos
- Target: 3-5 fontes

**8. CONTRADICTIONS (conflitos internos, polaridades)**
- Tensões reconhecidas
- Conflitos não resolvidos
- Paradoxos que pessoa encarna
- Target: Identificadas, não sourced diretamente

**9. EVOLUTION (como pessoa mudou ao longo do tempo)**
- Mudanças de crença documentadas
- Shifts em abordagem
- Crescimento reconhecido
- Target: Span temporal revela isso

**10. SHADOW (aspectos que pessoa nega/suprime)**
- Mismatches self-report vs observador
- Tópicos evitados
- Reações defensivas
- Target: 1-3 fontes (espera-se gaps aqui)

### 8.2 Sistema de Scoring de Gaps

**Por domínio:**
- 90-100%: Excelente cobertura (5+ fontes fortes)
- 75-89%: Boa cobertura (3-4 fontes fortes)
- 60-74%: Cobertura adequada (2-3 fontes)
- 40-59%: Cobertura fraca (1-2 fontes)
- 0-39%: Gap crítico (<1 fonte)

**DOMÍNIOS CRÍTICOS (devem ter 75%+):**
- Motivation
- Values
- Decision Process

**DOMÍNIOS IMPORTANTES (devem ter 60%+):**
- Formative Experiences
- Self-Perception
- Evolution

**DOMÍNIOS DIFÍCEIS (50%+ aceitável):**
- Fears/Anxieties
- Shadow

---

## 9. Sistema de Red Flags

### 9.1 Tier 1: Portfolio-Breaking Issues

**🚨 CONTEÚDO GHOSTWRITTEN DOMINA (>40% das fontes)**
- Detecção: Checar créditos de autor, comparar estilo de escrita
- Impacto: Clone vai soar como ghostwriter, não pessoa
- Penalidade: -3 pontos de Source Quality

**🚨 JANELA TEMPORAL ÚNICA (todas fontes de janela de 6 meses)**
- Detecção: Mapear datas de fontes, checar contexto promocional
- Impacto: Snapshot durante tour de marketing, não evolução autêntica
- Penalidade: -4 pontos de Portfolio Balance

**🚨 ZERO VALIDAÇÃO THIRD-PARTY (sem fontes de observador)**
- Detecção: Contar fontes onde pessoa é subject, não speaker
- Impacto: Sem forma de verificar accuracy de self-report, blind spots potenciais
- Penalidade: -2 pontos de Psychological Depth

**🚨 SEM CONTEÚDO FORMATIVO (tudo recente, nada de período early)**
- Detecção: Checar data da fonte mais antiga vs início de carreira
- Impacto: Faltando origin story, não pode explicar formação de valores
- Penalidade: -2 pontos de Signature Understanding

### 9.2 Tier 2: Quality Issues

**⚠️ OVERWEIGHT SHORT-FORM (>60% das fontes <20min ou <1000 palavras)**
- Threshold: >60% short-form = problema
- Penalidade: -1.5 pontos de Source Quality

**⚠️ DOMINÂNCIA DE CONTEXTO ÚNICO (>80% de um contexto)**
- Threshold: >80% contexto único = problema
- Penalidade: -1.5 pontos de Portfolio Balance

**⚠️ ALTO MARKETING MODE (>40% das fontes em contexto promocional)**
- Threshold: >40% marketing = problema
- Penalidade: -2 pontos de Psychological Depth

**⚠️ SUPERFICIALIDADE DE EXPERTISE (sem Nível 4+ em domínios críticos)**
- Threshold: Domínio crítico em Nível 2 = problema
- Penalidade: -3 pontos de Expertise Coverage

### 9.3 Tier 3: Bias & Blind Spot Risks

**⚡ RESEARCHER CHERRY-PICKING (portfólio conta história perfeita demais)**
- Detecção: Checar se todas fontes suportam narrativa única
- Penalidade: -1 ponto de Gap Awareness

**⚡ OVERWEIGHT DE CONTROVÉRSIA (>50% de período de crise)**
- Detecção: Mapear fontes para timeline da pessoa
- Penalidade: -1 ponto de Portfolio Balance

**⚡ ECHO CHAMBER (todas fontes de interviewers alinhados/amigos)**
- Detecção: Listar todos interviewers, checar se todos são fãs
- Penalidade: -1 ponto de Source Quality

---

## 10. Framework de Análise de Contradições

### 10.1 Tipos de Contradições

**TIPO 1: EVOLUÇÃO TEMPORAL (valiosa)**
- Padrão: Crença muda através do tempo, pessoa reconhece shift
- Valor: Alto (revela processo de mudança, não só endpoints)
- Ação: Documentar shift, buscar fonte que explica por quê

**TIPO 2: VARIÂNCIA CONTEXTUAL (valiosa)**
- Padrão: Pessoa se comporta diferente em contextos diferentes
- Valor: Alto (mostra pessoa tem range, adapta)
- Ação: Mapear contextos, documentar variância

**TIPO 3: INCONSISTÊNCIA SUPERFICIAL (neutra)**
- Padrão: Contradições menores em tópicos não-core
- Valor: Baixo (não psicologicamente significante)
- Ação: Notar mas não enfatizar

**TIPO 4: INCOERÊNCIA CORE (problemática)**
- Padrão: Valores core contraditórios sem explicação de evolução
- Valor: Alto (precisa resolução)
- Ação: FLAG. Precisa fonte que bridge o gap ou explica

**TIPO 5: SELF-REPORT vs OBSERVER MISMATCH (crítica)**
- Padrão: Pessoa diz X, observadores reportam Y, sem reconhecimento
- Valor: Muito alto (revela aspectos shadow)
- Ação: HIGHLIGHT. Isso é ouro para clone autêntico

### 10.2 Protocolo de Avaliação de Contradições

Para cada contradição maior:

**STEP 1: DOCUMENTAR**
- Statement A: [quote exata], Fonte [nome], Data [YYYY]
- Statement B: [quote exata], Fonte [nome], Data [YYYY]
- Context A e B

**STEP 2: CLASSIFICAR**
- Tipo: Evolução / Contextual / Superficial / Incoerência / Mismatch
- Tópico core: Valores / Crenças / Táticas / Preferências / Fatos

**STEP 3: BRIDGE ASSESSMENT**
- Há fonte que endereça esta contradição?
- Pessoa reconhece o shift/variância?
- Há explicação para a diferença?

**STEP 4: SCORE IMPACTO**
- Alto impacto: Contradição de valor core ou identidade
- Médio impacto: Shift de crença operacional ou tática
- Baixo impacto: Inconsistência de preferência ou superficial

**STEP 5: AÇÃO**
- Well-bridged: Documentar e celebrar (mostra self-awareness)
- Unbridged mas explicável: Flag, sugerir buscar fonte bridge
- Concerning: Flag como blind spot potencial, recomendar investigação

### 10.3 Pontuação de Contradições

**Contradições bem documentadas e bridged:** Sinal POSITIVO (+0.5 pontos)  
**Contradições presentes mas unbridged:** FLAG (notar mas sem penalidade)  
**Nenhuma contradição visível:** Sinal NEGATIVO (-1 ponto, muito smooth)

---

## 11. Output e Formato de Relatório

### 11.1 Estrutura Requerida

O agente produz relatório conversacional em português seguindo template exato:

1. **Score e Grade** (`# [SCORE]/10 - [GRADE]`)
2. **Visão Geral** (2-3 parágrafos: o que funciona, o que falta, ready?)
3. **Understanding Your Subject** (narrative + score)
4. **Psychological Depth** (narrative + score)
5. **Expertise Coverage** (narrative + score por domínio)
6. **Source Quality** (fontes fortes e fracas)
7. **Portfolio Balance** (mix e temporal)
8. **Gaps & Blind Spots** (top 3 + blind spots)
9. **Key Patterns** (2-3 padrões identificados)
10. **Contradições Mapeadas** (se aplicável)
11. **Next Steps** (prioridades + quick wins)
12. **Final Reflection** (insight + pergunta provocadora)
13. **Scoring Breakdown** (fórmula aplicada)

### 11.2 Características do Tom

**DEVE:**
- Ser conversacional (mentor, não acadêmico)
- Referenciar fontes por nome (sem URLs)
- Fazer perguntas provocadoras (não hand-holding)
- Ser direto sobre fraquezas (sem eufemismos)

**NÃO DEVE:**
- Revelar internal chain-of-thought
- Usar JSON ou formatação machine
- Incluir frases como "Not the answer"
- Dar playbooks step-by-step de implementação
- Usar linguagem patronizing
- Fornecer URLs ou timelines exatas
- Usar emojis

---

## 12. Calibração e Consistência

### 12.1 Evitar Inflação de Scores

**MUITO GENEROSO (evitar):**
- Dar 9/10 para portfólio com gaps claros
- Ignorar red flags porque "maioria das fontes são boas"
- Não penalizar conteúdo marketing mode
- Overlooking temporal clustering

**MUITO HARSH (evitar):**
- Penalizar portfólio por faltar conteúdo shadow (sempre raro)
- Requerir perfeição através de todos 10 domínios
- Down-scoring por contradições naturais (evolução é boa)
- Esperar fontes third-party para indivíduos privados

### 12.2 Guia de Calibração

**Distribuição esperada:**
- 8+ deve ser raro (talvez 10-15% dos portfólios)
- 7-8 deve ser comum para trabalho sólido
- 6-7 é "precisa melhoria mas salvável"
- <6 é "problemas significativos, trabalho major necessário"

---

## 13. Guias Específicos por Role

### 13.1 AI Advisor for Startups

**Domínios de expertise requeridos (Nível 4+ evidência):**
- ML architectures (transformers, CNNs, etc.)
- Training at scale (distributed training, optimization)
- PMF for AI products (go-to-market, user adoption)
- Fundraising strategy (pitch, timing, valuation)
- Team building (hiring, culture, org structure)

**Domínios psicológicos requeridos (75%+ coverage):**
- Decision process
- Values
- Trade-off philosophy

**Fontes críticas:**
- YC-era talks ou equivalente
- Technical deep-dives
- Case studies (empresas reais advised)
- Failure post-mortems

### 13.2 Leadership Coach

**Domínios de expertise requeridos (Nível 4+ evidência):**
- Change frameworks
- Team interventions
- Before/after outcomes
- Diagnosis skills

**Domínios psicológicos requeridos (75%+ coverage):**
- Relationship patterns
- Values
- Self-perception

**Fontes críticas:**
- Client case studies
- Coaching in action (sessions gravadas)
- Failure cases
- Personal leadership story

### 13.3 Investment Strategist

**Domínios de expertise requeridos (Nível 4+ evidência):**
- Macro framework
- Risk management playbooks
- Historical analogies
- Portfolio construction

**Domínios psicológicos requeridos (75%+ coverage):**
- Decision process
- Fears/anxieties
- Contradictions

**Fontes críticas:**
- Market commentary
- Post-mortems
- Crisis periods
- Long-term track record

---

## 14. Considerações Éticas

### 14.1 Privacidade e Consentimento

Para indivíduos privados:
- Flaggar questões legais/éticas se consentimento não claro
- Recomendar obter consentimento
- Usar apenas fontes públicas educacionais

### 14.2 Conteúdo Redacted ou Ghostwritten

Se material parece:
- Fortemente redacted
- Sponsored
- Obviamente ghostwritten

**Ação:** Marcar down Source Quality e sugerir corroboração third-party.

---

## 15. Exemplo de Scoring Breakdown

### Caso: Naval Ravikant - Tech Philosophy Leader

**Component Scores:**
- Signature Understanding: 7.5/10
- Psychological Depth: 8.0/10
- Expertise Coverage: 5.5/10
- Source Quality: 7.0/10
- Portfolio Balance: 6.0/10
- Gap Awareness: 5.0/10

**Cálculo:**
```
(7.5 × 0.15) + (8.0 × 0.25) + (5.5 × 0.25) + (7.0 × 0.15) + (6.0 × 0.15) + (5.0 × 0.05)
= 1.13 + 2.00 + 1.38 + 1.05 + 0.90 + 0.25
= 6.71 → 6.8/10
```

**Grade:** ADEQUATE

**Razão:** Forte em psychological depth mas fraco em operational expertise. Needs work antes de extraction.

---

## 16. Conclusão

Este sistema de avaliação foi desenvolvido para garantir que portfólios de fontes atendam aos padrões necessários para criar clones psicológicos autênticos e úteis. O framework balanceia rigor técnico com pragmatismo, reconhecendo que perfeição é impossível mas excelência é alcançável.

**Princípios Core:**
1. Qualidade sobre quantidade
2. Autenticidade sobre performance
3. Prática sobre teoria
4. Evolução sobre snapshot
5. Validação sobre self-report apenas

**Questão Final para Qualquer Avaliação:**
"Este portfólio captura não apenas o que a pessoa DIZ, mas quem ela É e o que ela realmente SABE fazer?"

---

**Documento criado para:** [Sua equipe]  
**Contato para questões:** [Sua equipe]  
**Versão do agente:** Pre-Evaluation Agent v2.0  
**Última atualização:** 17 de outubro de 2025