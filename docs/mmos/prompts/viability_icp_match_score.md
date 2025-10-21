# ICP MATCH SCORE

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: @{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-viability.yaml (output do APEX), perfil ICP da Comunidade Lendária
- Output: @{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-icp_match.yaml
- Dependências: 01_scorecard_apex.md (DEVE ser executado primeiro)
- Execução: APENAS se scorecard_apex.score_final >= 6.0 (APROVADO ou superior)

## OBJETIVO PRINCIPAL
Sistema complementar ao SCORECARD APEX que avalia especificamente o quanto um clone mental resolve as dores e atende as necessidades psicológicas profundas do ICP (Ideal Customer Profile) da Comunidade Lendária. Quantifica o valor estratégico do clone para o público-alvo.

## INPUT NECESSÁRIO

**⚠️ PRÉ-REQUISITO OBRIGATÓRIO:**
Este prompt SÓ deve ser executado APÓS `01_scorecard_apex.md` ter sido concluído com sucesso e `score_final >= 6.0`.

```yaml
input_requerido:
  # Arquivo gerado pelo prompt anterior (obrigatório)
  viability_file: "@{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-viability.yaml"

  # Campos extraídos do viability.yaml
  nome_clone: "[Extrair de viability.yaml]"
  scorecard_apex_score: "[Extrair score_final]"
  classificacao_apex: "[PREMIUM/APROVADO/CONDICIONAL]"
  arquetipo_clone: "[Extrair archetype_type]"
  super_habilidade: "[Extrair super_skill_category]"
  contexto_uso: "[Extrair intended_use]"

  # Perfil ICP (fixo para Comunidade Lendária)
  icp_profile: "Homens 35-55 anos, profissionais travados buscando transformação"
```

**VALIDAÇÃO DE INPUT:**
```yaml
if scorecard_apex_score < 6.0:
  return:
    status: "SKIP_ICP_ANALYSIS"
    reason: "Clone não atingiu viabilidade mínima no APEX (< 6.0)"
    recommendation: "Revisar scorecard APEX ou escolher outro candidato"
```

## METODOLOGIA

### EQUAÇÃO DE CÁLCULO

```
ICP Match Score = (Dor Score × 0.35) + (Arquétipo Score × 0.25) +
                  (Transformação Score × 0.20) + (Execução Score × 0.20)
```

### PARTE A: ALINHAMENTO COM DORES CENTRAIS (35%)

#### A.1 Resolução da Dor Superficial (10%)
**"Quero automatizar com IA e ganhar mais"**

|Clone Oferece|Pontuação|Exemplo|
|---|---|---|
|Métodos diretos de monetização com IA|10 pts|Sam Altman, Naval Ravikant|
|Frameworks de automação e escala|8 pts|Tim Ferriss, Peter Thiel|
|Estratégias de negócios digitais|6 pts|Gary Vaynerchuk, Seth Godin|
|Princípios gerais de sucesso|4 pts|Ray Dalio, Warren Buffett|
|Filosofia sem aplicação prática|2 pts|Sêneca, Marcus Aurelius|

#### A.2 Resolução da Dor Real (15%)
**"Quero provar que ainda tenho valor e não desperdicei meu potencial"**

|Clone Oferece|Pontuação|Exemplo|
|---|---|---|
|Casos de transformação tardia/reinvenção|10 pts|Colonel Sanders, Ray Kroc|
|Validação de experiência acumulada|8 pts|Charlie Munger, Peter Drucker|
|Frameworks de autoavaliação de valor|6 pts|Jim Collins, Simon Sinek|
|Motivação e mindset geral|4 pts|Tony Robbins, Brendon Burchard|
|Teoria sem conexão emocional|2 pts|Economistas acadêmicos|

#### A.3 Resolução da Dor Profunda (10%)
**"Preciso construir algo próprio antes que seja tarde demais"**

|Clone Oferece|Pontuação|Exemplo|
|---|---|---|
|Blueprint de construção de negócio/legado|10 pts|Steve Jobs, Elon Musk|
|Sistemas de criação e produtização|8 pts|James Clear, Tiago Forte|
|Metodologias de execução rápida|6 pts|Eric Ries, Jake Knapp|
|Inspiração sem método claro|4 pts|Oprah, Paulo Coelho|
|Filosofia contemplativa apenas|2 pts|Alan Watts, Eckhart Tolle|

### PARTE B: FIT COM ARQUÉTIPOS DO ICP (25%)

#### B.1 Match Primário (15%)
**Com qual arquétipo o clone tem maior sinergia?**

|Arquétipo|% do ICP|Multiplicador|
|---|---|---|
|Empreendedor Digital Travado|30%|×1.3|
|Executivo Exausto|25%|×1.25|
|Técnico Visionário|20%|×1.2|
|Veterano Desprezado|15%|×1.15|
|Multipotencial Ansioso|10%|×1.1|

#### B.2 Versatilidade Cross-Arquétipo (10%)
**Quantos arquétipos o clone beneficia significativamente?**

|Cobertura|Pontuação|
|---|---|
|Beneficia todos os 5 arquétipos|10 pts|
|Beneficia 4 arquétipos|8 pts|
|Beneficia 3 arquétipos|6 pts|
|Beneficia 2 arquétipos|4 pts|
|Beneficia apenas 1 arquétipo|2 pts|

### PARTE C: POTENCIAL DE TRANSFORMAÇÃO (20%)

#### C.1 Velocidade de Impacto (10%)
**Em quanto tempo o clone gera resultado tangível?**

|Timeframe|Pontuação|Característica do Clone|
|---|---|---|
|30 dias|10 pts|Táticas imediatas e práticas|
|60 dias|8 pts|Sistemas rápidos de implementação|
|90 dias|6 pts|Estratégias de médio prazo|
|180 dias|4 pts|Transformação gradual|
|365+ dias|2 pts|Mudança de longo prazo|

#### C.2 Profundidade da Transformação (10%)
**Qual nível de mudança o clone promove?**

|Nível|Pontuação|Tipo de Mudança|
|---|---|---|
|Identitária|10 pts|Muda quem a pessoa É|
|Comportamental|8 pts|Muda o que a pessoa FAZ|
|Estratégica|6 pts|Muda COMO a pessoa faz|
|Tática|4 pts|Muda ferramentas/técnicas|
|Superficial|2 pts|Muda apenas conhecimento|

### PARTE D: CAPACITAÇÃO PARA EXECUÇÃO (20%)

#### D.1 Clareza de Sistema (10%)
**O clone oferece sistema claro e replicável?**

|Característica|Pontuação|Exemplo|
|---|---|---|
|Framework passo-a-passo documentado|10 pts|Getting Things Done (David Allen)|
|Metodologia clara mas flexível|8 pts|Lean Startup (Eric Ries)|
|Princípios com exemplos práticos|6 pts|Good to Great (Jim Collins)|
|Diretrizes gerais adaptáveis|4 pts|7 Habits (Covey)|
|Filosofia sem estrutura|2 pts|Conceitos abstratos|

#### D.2 Combate à Paralisia (10%)
**O clone ajuda a superar os padrões de autossabotagem do ICP?**

Avalie se o clone oferece antídotos para:
- [ ] Perfeccionismo procrastinador (+2 pts)
- [ ] Shiny object syndrome (+2 pts)
- [ ] Comparação paralisante (+2 pts)
- [ ] Overthinking estratégico (+2 pts)
- [ ] Isolamento protetor (+2 pts)

## OUTPUT ESTRUTURADO

**Arquivo:** `@{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-icp_match.yaml`

```yaml
icp_match_report:
  # Metadados e referências
  analysis_date: "YYYY-MM-DD HH:MM"
  viability_file_reference: "@{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-viability.yaml"

  clone: "[Nome do Clone]"
  icp_match_score: [X.X]/10

  breakdown:
    dor_score: [X]/10
      superficial: [X]/10
      real: [X]/10
      profunda: [X]/10

    arquetipo_score: [X]/10
      match_primario: "[Arquétipo]"
      multiplicador: [X.X]
      versatilidade: [X]/5 arquétipos

    transformacao_score: [X]/10
      velocidade: "[Timeframe]"
      profundidade: "[Nível]"

    execucao_score: [X]/10
      clareza_sistema: [X]/10
      combate_paralisia: [X]/5 padrões

  analise_por_arquetipo:
    empreendedor_travado:
      relevancia: [1-10]
      dor_resolvida: "[Específica]"
      aplicacao: "[Como usar]"

    executivo_exausto:
      relevancia: [1-10]
      dor_resolvida: "[Específica]"
      aplicacao: "[Como usar]"

    tecnico_visionario:
      relevancia: [1-10]
      dor_resolvida: "[Específica]"
      aplicacao: "[Como usar]"

    veterano_desprezado:
      relevancia: [1-10]
      dor_resolvida: "[Específica]"
      aplicacao: "[Como usar]"

    multipotencial_ansioso:
      relevancia: [1-10]
      dor_resolvida: "[Específica]"
      aplicacao: "[Como usar]"

  necessidades_psicologicas_atendidas:
    nivel_1_seguranca: [true/false]
    nivel_2_validacao: [true/false]
    nivel_3_pertencimento: [true/false]
    nivel_4_autonomia: [true/false]
    nivel_5_proposito: [true/false]

  super_poder_para_icp: "[Principal benefício único]"
  contra_indicacoes: "[Quando NÃO usar este clone]"

  classificacao_final: "[MATCH PERFEITO/PREMIUM/BOM/MODERADO/BAIXO]"
  recomendacao: "[CLONAR URGENTE/CLONAR/CONSIDERAR/POSTERGAR/DESCARTAR]"
```

### MATRIZ DE DECISÃO ICP

|ICP Match Score|Classificação|Recomendação|
|---|---|---|
|≥ 9.0|**MATCH PERFEITO**|Clone essencial para a comunidade|
|8.0-8.9|**MATCH PREMIUM**|Alta prioridade de clonagem|
|7.0-7.9|**MATCH BOM**|Recomendado para biblioteca|
|6.0-6.9|**MATCH MODERADO**|Útil para nichos específicos|
|< 6.0|**MATCH BAIXO**|Reconsiderar ou buscar alternativa|

### INTEGRAÇÃO COM SCORECARD APEX

**Matriz de Decisão Combinada APEX × ICP:**

```yaml
decision_matrix:
  # APEX PREMIUM (9.0-10.0) - Viabilidade Excepcional
  premium_apex:
    icp_match_perfeito_8_0_plus:
      decision: "CLONE PRIORITÁRIO ABSOLUTO"
      priority: "P0 - Executar imediatamente"
      expected_impact: "Alto ROI + Alta Relevância"

    icp_match_bom_7_0_8_0:
      decision: "CLONE PREMIUM"
      priority: "P1 - Executar em seguida"
      expected_impact: "Alto ROI + Boa Relevância"

    icp_match_moderado_6_0_7_0:
      decision: "CLONE ESTRATÉGICO"
      priority: "P2 - Considerar nichos específicos"
      expected_impact: "Alto ROI + Relevância Moderada"

    icp_match_baixo_less_6_0:
      decision: "CLONAR MAS REAVALIAR USO"
      priority: "P3 - Clone técnico bom, repensar posicionamento"
      expected_impact: "Alto ROI técnico, baixo fit atual ICP"

  # APEX APROVADO (6.0-8.9) - Viabilidade Boa
  aprovado_apex:
    icp_match_perfeito_8_0_plus:
      decision: "CLONE RECOMENDADO FORTE"
      priority: "P1 - Alta relevância compensa viabilidade normal"
      expected_impact: "ROI Bom + Alta Relevância = Priorizar"

    icp_match_bom_7_0_8_0:
      decision: "CLONE RECOMENDADO"
      priority: "P2 - Equilíbrio saudável"
      expected_impact: "ROI Bom + Relevância Boa"

    icp_match_moderado_6_0_7_0:
      decision: "CLONE CONDICIONAL"
      priority: "P3 - Avaliar ROI específico"
      expected_impact: "ROI Médio + Relevância Média"

    icp_match_baixo_less_6_0:
      decision: "BUSCAR ALTERNATIVA"
      priority: "P4 - Não priorizar"
      expected_impact: "Baixo fit geral"

  # APEX CONDICIONAL (5.0-5.9) - Viabilidade Limítrofe
  condicional_apex:
    icp_match_perfeito_9_0_plus:
      decision: "CONSIDERAR EXCEÇÃO"
      priority: "P2 - Relevância excepcional pode justificar"
      expected_impact: "ROI técnico baixo, mas demanda ICP altíssima"
      caveat: "Validar com audiência antes de investir"

    icp_match_any_less_9_0:
      decision: "NÃO CLONAR"
      priority: "N/A"
      expected_impact: "Risco > Retorno"

  # APEX BLOQUEADO (<5.0) - Inviável
  bloqueado_apex:
    any_icp_score:
      decision: "NÃO CLONAR"
      priority: "N/A"
      reason: "Bloqueios técnicos/legais impedem clonagem"
```

**Fórmula de Prioridade Final:**

```python
def calcular_prioridade_final(apex_score, icp_score):
    """
    Calcula prioridade combinando APEX (viabilidade) e ICP (relevância)
    """
    if apex_score < 5.0:
        return "BLOQUEADO - Não clonar"

    if apex_score < 6.0:  # CONDICIONAL
        if icp_score >= 9.0:
            return "P2 - EXCEÇÃO (validar com ICP antes)"
        else:
            return "NÃO CLONAR - Viabilidade insuficiente"

    # APEX >= 6.0 (APROVADO ou PREMIUM)
    combined_score = (apex_score * 0.4) + (icp_score * 0.6)
    # Peso maior para ICP pois clone viável mas irrelevante é desperdício

    if combined_score >= 9.0:
        return "P0 - PRIORITÁRIO ABSOLUTO"
    elif combined_score >= 8.0:
        return "P1 - ALTA PRIORIDADE"
    elif combined_score >= 7.0:
        return "P2 - PRIORIDADE MÉDIA"
    elif combined_score >= 6.5:
        return "P3 - PRIORIDADE BAIXA"
    else:
        return "P4 - BUSCAR ALTERNATIVA MELHOR"
```

## EXEMPLOS DE APLICAÇÃO

### Exemplo: Naval Ravikant

```yaml
icp_match_score: 9.2/10

breakdown:
  dor_score: 9.5/10
    - Superficial: 10/10 (monetização direta com IA)
    - Real: 9/10 (validação de valor único)
    - Profunda: 9/10 (construir wealth e liberdade)

  arquetipo_score: 9.3/10
    - Match primário: Empreendedor Digital (10 × 1.3)
    - Versatilidade: Beneficia 4/5 arquétipos

  transformacao_score: 8.5/10
    - Velocidade: 60 dias (sistemas rápidos)
    - Profundidade: Comportamental/Estratégica

  execucao_score: 9.0/10
    - Sistema: Princípios claros e aplicáveis
    - Anti-paralisia: Combate 4/5 padrões

super_poder: "Síntese perfeita entre filosofia e capitalismo
             prático para o empreendedor digital consciente"
```

### CATEGORIAS DE ALTO MATCH (>8.0)

**Empreendedores Digitais Modernos:**
- Naval Ravikant (filosofia + negócios + IA)
- Sam Altman (IA + startups + execução)
- Pieter Levels (indie hacking + automação)
- Jack Butcher (visualização + productização)

**Sistemas de Execução:**
- David Allen (GTD - organização total)
- Tiago Forte (Second Brain - gestão conhecimento)
- Cal Newport (Deep Work - foco profundo)
- James Clear (Atomic Habits - mudança incremental)

**Transformação de Carreira:**
- Tim Ferriss (lifestyle design + automação)
- Seth Godin (marketing + posicionamento único)
- Paul Graham (startups + pensamento claro)
- Derek Sivers (empreendedorismo minimalista)

### CATEGORIAS DE BAIXO MATCH (<6.0)

**Muito Teórico/Acadêmico:**
- Economistas puros sem aplicação prática
- Filósofos sem ponte para execução
- Teóricos sem casos de implementação

**Contexto Incompatível:**
- Especialistas em indústrias não-digitais
- Figuras históricas sem paralelo moderno
- Gurus de modelos ultrapassados

**Complexidade Excessiva:**
- Requer anos de estudo para aplicar
- Dependente de recursos não acessíveis
- Voltado para corporações, não indivíduos

## CHECKLIST DE QUALIDADE

### Green Flags (Alta Probabilidade de Match)
- [ ] Fala sobre monetização/escala digital
- [ ] Tem histórico de transformação pessoal
- [ ] Oferece sistema, não só inspiração
- [ ] Combate perfeccionismo/procrastinação
- [ ] Resultados em menos de 90 dias
- [ ] Aplicável para solopreneurs
- [ ] Integra tecnologia moderna
- [ ] Validado por casos reais similares ao ICP

### Red Flags (Baixa Probabilidade de Match)
- [ ] Foco em grandes corporações
- [ ] Requer equipe/capital significativo
- [ ] Teoria sem casos práticos
- [ ] Contexto pré-digital
- [ ] Complexidade que gera paralisia
- [ ] Resultados apenas no longo prazo (>1 ano)
- [ ] Dependente de talentos raros
- [ ] Conflito com valores do ICP

## ALERTAS CRÍTICOS

1. **SEQUENCIALIDADE OBRIGATÓRIA**: Este prompt NUNCA deve ser executado antes do APEX. Sempre validar existência do arquivo `viability.yaml`

2. **ALINHAMENTO NEM SEMPRE ÓBVIO**: Score alto no APEX não garante relevância para o ICP. Ex: Warren Buffett tem APEX 10/10 mas ICP Match ~6.0 (contexto corporativo tradicional vs digital)

3. **CONTEXTO TEMPORAL**: Considerar momento de vida e urgências do público. Clone perfeito em 2015 pode ser irrelevante em 2025

4. **COMBINAÇÕES SINÉRGICAS**: Alguns clones funcionam melhor em conjunto. Ex: Naval (filosofia) + Alex Hormozi (execução) = combo poderoso

5. **EVOLUÇÃO DO ICP**: ICP muda com tempo - reavaliar periodicamente. Homens 35-55 hoje terão necessidades diferentes em 2027

6. **EXCEÇÕES VALIOSAS**: Score baixo pode ter nicho específico valioso. Documentar se houver demanda minoritária mas intensa

---

## INSTRUÇÕES DE USO SEQUENCIAL

### Fluxo Completo de Viabilidade

```bash
# PASSO 1: Executar APEX Score (obrigatório)
Input: "Gary Vee"
Prompt: 01_scorecard_apex.md
Output: @{mind}/docs/@{mind}/docs/logs/20250929-2145-viability.yaml

# PASSO 2: Validar resultado APEX
if viability.yaml.score_final >= 6.0:
    proceed_to_step_3 = True
else:
    decision = "NÃO CLONAR - Falhou viabilidade técnica"
    exit()

# PASSO 3: Executar ICP Match Score (condicional)
Input: @{mind}/docs/@{mind}/docs/logs/20250929-2145-viability.yaml
Prompt: 02_icp_match_score.md
Output: @{mind}/docs/@{mind}/docs/logs/20250929-2147-icp_match.yaml

# PASSO 4: Decisão Final Combinada
apex_score = viability.yaml.score_final
icp_score = icp_match.yaml.icp_match_score
priority = calcular_prioridade_final(apex_score, icp_score)

print(f"DECISÃO FINAL: {priority}")
```

### Exemplo Prático: Naval Ravikant

**Passo 1 - APEX Score:**
```yaml
# @{mind}/docs/@{mind}/docs/logs/20250929-2145-viability.yaml
clone: "Naval Ravikant"
score_final: 9.2/10
classification: "PREMIUM"
archetype_type: "Lendário Vivo"
super_skill_category: "Filosofia Prática + Startups + Wealth Creation"
```

**Passo 2 - Validação:**
```
9.2 >= 6.0 ✅ → Prosseguir para ICP Match
```

**Passo 3 - ICP Match Score:**
```yaml
# @{mind}/docs/@{mind}/docs/logs/20250929-2147-icp_match.yaml
clone: "Naval Ravikant"
icp_match_score: 9.5/10
classification: "MATCH PERFEITO"

breakdown:
  dor_score: 9.7/10
  arquetipo_score: 9.8/10 (Empreendedor Digital Travado)
  transformacao_score: 9.0/10
  execucao_score: 9.5/10
```

**Passo 4 - Decisão Final:**
```yaml
apex_score: 9.2
icp_score: 9.5
combined_score: (9.2 × 0.4) + (9.5 × 0.6) = 9.38

DECISÃO: "P0 - PRIORITÁRIO ABSOLUTO"
RECOMENDAÇÃO: "Clonar imediatamente - Alto ROI técnico + Alta relevância ICP"
```

---

## CHECKLIST DE EXECUÇÃO

Antes de executar este prompt, confirmar:

- [ ] `01_scorecard_apex.md` foi executado
- [ ] Arquivo `@{mind}/docs/@{mind}/docs/logs/YYYYMMDD-HHMM-viability.yaml` existe
- [ ] `viability.yaml` contém `score_final >= 6.0`
- [ ] Campos obrigatórios presentes no viability.yaml:
  - [ ] `clone` (nome)
  - [ ] `score_final`
  - [ ] `classification`
  - [ ] `archetype_type`
  - [ ] `super_skill_category`

Se qualquer checklist falhar → NÃO executar este prompt