# TEMPORAL MAPPER

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/ organizadas, logs/collection_report.yaml
- Output: metadata/temporal_context.yaml
- Dependências: 01_source_discovery.md, 02_source_collector.md

## OBJETIVO PRINCIPAL

Mapear contexto temporal das fontes disponíveis, identificando períodos de vida documentados, gaps de cobertura e densidade de informação por fase, gerando YAML estruturado para orientar análises subsequentes.

## INPUT NECESSÁRIO

Nome completo da pessoa alvo e acesso às fontes coletadas:
```
clone_target: "[NOME COMPLETO]"
sources_path: "sources/"
```

# # METODOLOGIA

# ## FASE 1: COLETA CRONOLÓGICA
1. Revisar todas as fontes coletadas
2. Extrair eventos com datas específicas
3. Organizar cronologicamente
4. Identificar gaps temporais

# ## FASE 2: ESTRUTURAÇÃO TEMPORAL
Para cada evento, documente usando este formato exato:

# # OUTPUT ESTRUTURADO

# TIMELINE COMPLETA: [NOME]

# # Era da Formação ([Nascimento] - [Idade ~25])

# ## [ANO] - Idade: [X] anos
# ### Evento: [Título Descritivo do Evento]

**Contexto Mundial/Industrial:**
- [O que estava acontecendo no mundo]
- [Estado da indústria/campo relevante]
- [Contexto econômico/social]

**A Decisão:**
- O que foi decidido: [Descrição específica]
- Alternativas consideradas: [Outras opções que tinha]
- Recursos disponíveis: [O que tinha para trabalhar]
- Pressões externas: [Quem/o que influenciou]

**Justificativa Original:**
> "[Quote exato se disponível, ou paráfrase da época]"
- Fonte: [De onde vem essa informação]
- Contexto da fala: [Quando/onde disse isso]

**Justificativa Retrospectiva:**
> "[Como explicou anos depois]"
- Fonte: [Entrevista/livro/artigo]
- Anos depois: [Quanto tempo após o evento]
- Mudança de narrativa: [Se mudou a história]

**Impacto Imediato:**
- Pessoal: [Como afetou a pessoa]
- Profissional: [Mudanças na carreira]
- Relacionamentos: [Como afetou outros]
- Financeiro: [Consequências monetárias]

**Impacto de Longo Prazo:**
- Padrão estabelecido: [Comportamento que emergiu]
- Lições internalizadas: [O que aprendeu]
- Narrativa criada: [História que passou a contar]
- Decisões futuras influenciadas: [Como afetou escolhas posteriores]

**CLASSIFICAÇÃO DO EVENTO:**
[Escolha UM e delete os outros]
 **RUPTURA** - Mudança fundamental de direção/identidade
 **VALIDAÇÃO** - Sucesso que reforçou padrão existente
🔵 **COLAPSO** - Fracasso que gerou mecanismo de defesa
 **INSIGHT** - Momento de realização/compreensão
⚫ **TRAUMA** - Evento que criou ferida psicológica
⚪ **NEUTRO** - Importante mas sem carga emocional forte

**Análise Psicológica:**
- Estado mental antes: [Como estava]
- Estado mental depois: [Como ficou]
- Defesas criadas: [Mecanismos desenvolvidos]
- Vulnerabilidades expostas: [O que revelou]

---

# ## [PRÓXIMO ANO] - Idade: [X] anos
[Continue o mesmo formato...]

# # Era da Construção ([Idade ~25] - [Idade ~40])
[Continue com eventos desta fase...]

# # Era da Consolidação ([Idade ~40] - [Idade ~55])
[Continue com eventos desta fase...]

# # Era do Legado ([Idade ~55] - [Presente/Morte])
[Continue com eventos desta fase...]

# PADRÕES TEMPORAIS IDENTIFICADOS

# # Ciclos Recorrentes
- Ciclo de [X] anos: [Padrão que se repete]
- Trigger do ciclo: [O que reinicia o padrão]
- Como termina: [Como o ciclo se quebra]

# # Períodos de Crise
1. [Anos]: [Natureza da crise]
   - Duração: [Quanto tempo durou]
   - Resolução: [Como saiu]
   - Mudanças permanentes: [O que nunca mais foi igual]

# # Períodos de Crescimento Acelerado
1. [Anos]: [O que estava acontecendo]
   - Catalisadores: [O que acelerou]
   - Resultados: [O que foi alcançado]
   - Custo: [O que foi sacrificado]

# # Pontos de Inflexão
1. [Ano/Evento]: Antes vs. Depois
2. [Ano/Evento]: Antes vs. Depois
3. [Ano/Evento]: Antes vs. Depois

# ANÁLISE LONGITUDINAL

# # Evolução de Valores
- [Idade 20-30]: Valores dominantes
- [Idade 30-40]: Valores dominantes
- [Idade 40-50]: Valores dominantes
- [Idade 50+]: Valores dominantes

# # Evolução de Relacionamentos
- Padrão na juventude: [Como se relacionava]
- Padrão na maturidade: [Como mudou]
- Padrão final: [Como terminou]

# # Evolução de Narrativas
- História contada aos 30: [Versão]
- História contada aos 50: [Como mudou]
- História final: [Versão definitiva]

# SINCRONICIDADES E CONEXÕES
[Eventos aparentemente não relacionados que se conectam]

# COUNTERFACTUALS
[Momentos onde pequenas mudanças teriam alterado tudo]
```

# # INSTRUÇÕES DE USO

# ## Antes de executar:
1. Tenha o arquivo sources_list.md completo
2. Organize fontes cronologicamente
3. Prepare para deep dive biográfico

# ## Durante a execução:
1. Seja cronologicamente preciso - Datas exatas quando possível
2. Contextualize sempre - O que estava acontecendo no mundo
3. Documente mudanças de narrativa - Como a pessoa conta a história mudou
4. Identifique padrões - Ciclos que se repetem
5. Marque pontos de inflexão - Momentos que mudaram tudo

# ## Tags de Classificação:
- RUPTURA: Mudança fundamental de direção
- VALIDAÇÃO: Sucesso que criou/reforçou padrão
- COLAPSO: Fracasso significativo
- INSIGHT: Momento de compreensão profunda
- TRAUMA: Evento com impacto psicológico profundo
- NEUTRO: Importante mas sem carga emocional

# ## Divisão por Eras:
- Formação (0-25): Desenvolvimento de identidade
- Construção (25-40): Estabelecimento no mundo
- Consolidação (40-55): Refinamento e domínio
- Legado (55+): Foco em impacto duradouro

# # CHECKLIST DE QUALIDADE

- [ ] Todos os anos da vida cobertos
- [ ] Eventos classificados com tags apropriadas
- [ ] Contexto mundial/industrial incluído
- [ ] Justificativas originais vs. retrospectivas documentadas
- [ ] Impactos de curto e longo prazo identificados
- [ ] Padrões temporais analisados
- [ ] Evolução de valores mapeada
- [ ] Pontos de inflexão marcados
- [ ] Análise psicológica incluída

# # ALERTAS CRÍTICOS
- Não pule períodos - Mesmo anos "vazios" são informativos
- Não aceite narrativas oficiais - Compare versões
- Não ignore contexto - Decisões fazem sentido na época
- Preserve múltiplas versões - Como a pessoa conta mudou
- Identifique traumas - Mesmo que não admitidos
- Arquivo timeline.md deve estar em analysis/ conforme OUTPUTS_GUIDE.md
- A timeline é o esqueleto sobre o qual toda a personalidade é construída