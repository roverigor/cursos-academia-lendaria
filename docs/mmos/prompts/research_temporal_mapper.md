# TEMPORAL MAPPER

## METADADOS
- VersÃ£o: 3.0 ACS Neural Flow
- Input: @{mind}/sources/ organizadas, @{mind}/docs/logs/collection_report.yaml
- Output: @{mind}/metadata/temporal_context.yaml
- DependÃªncias: 01_source_discovery.md, 02_source_collector.md

## OBJETIVO PRINCIPAL

Mapear contexto temporal das fontes disponÃ­veis, identificando perÃ­odos de vida documentados, gaps de cobertura e densidade de informaÃ§Ã£o por fase, gerando YAML estruturado para orientar anÃ¡lises subsequentes.

## INPUT NECESSÃRIO

Nome completo da pessoa alvo e acesso Ã s fontes coletadas:
```
clone_target: "[NOME COMPLETO]"
sources_path: "@{mind}/sources/"
```

# # METODOLOGIA

# ## FASE 1: COLETA CRONOLÃGICA
1. Revisar todas as fontes coletadas
2. Extrair eventos com datas especÃ­ficas
3. Organizar cronologicamente
4. Identificar gaps temporais

# ## FASE 2: ESTRUTURAÃÃO TEMPORAL
Para cada evento, documente usando este formato exato:

# # OUTPUT ESTRUTURADO

# TIMELINE COMPLETA: [NOME]

# # Era da FormaÃ§Ã£o ([Nascimento] - [Idade ~25])

# ## [ANO] - Idade: [X] anos
# ### Evento: [TÃ­tulo Descritivo do Evento]

**Contexto Mundial/Industrial:**
- [O que estava acontecendo no mundo]
- [Estado da indÃºstria/campo relevante]
- [Contexto econÃ´mico/social]

**A DecisÃ£o:**
- O que foi decidido: [DescriÃ§Ã£o especÃ­fica]
- Alternativas consideradas: [Outras opÃ§Ãµes que tinha]
- Recursos disponÃ­veis: [O que tinha para trabalhar]
- PressÃµes externas: [Quem/o que influenciou]

**Justificativa Original:**
> "[Quote exato se disponÃ­vel, ou parÃ¡frase da Ã©poca]"
- Fonte: [De onde vem essa informaÃ§Ã£o]
- Contexto da fala: [Quando/onde disse isso]

**Justificativa Retrospectiva:**
> "[Como explicou anos depois]"
- Fonte: [Entrevista/livro/artigo]
- Anos depois: [Quanto tempo apÃ³s o evento]
- MudanÃ§a de narrativa: [Se mudou a histÃ³ria]

**Impacto Imediato:**
- Pessoal: [Como afetou a pessoa]
- Profissional: [MudanÃ§as na carreira]
- Relacionamentos: [Como afetou outros]
- Financeiro: [ConsequÃªncias monetÃ¡rias]

**Impacto de Longo Prazo:**
- PadrÃ£o estabelecido: [Comportamento que emergiu]
- LiÃ§Ãµes internalizadas: [O que aprendeu]
- Narrativa criada: [HistÃ³ria que passou a contar]
- DecisÃµes futuras influenciadas: [Como afetou escolhas posteriores]

**CLASSIFICAÃÃO DO EVENTO:**
[Escolha UM e delete os outros]
 **RUPTURA** - MudanÃ§a fundamental de direÃ§Ã£o/identidade
 **VALIDAÃÃO** - Sucesso que reforÃ§ou padrÃ£o existente
ðµ **COLAPSO** - Fracasso que gerou mecanismo de defesa
 **INSIGHT** - Momento de realizaÃ§Ã£o/compreensÃ£o
â« **TRAUMA** - Evento que criou ferida psicolÃ³gica
âª **NEUTRO** - Importante mas sem carga emocional forte

**AnÃ¡lise PsicolÃ³gica:**
- Estado mental antes: [Como estava]
- Estado mental depois: [Como ficou]
- Defesas criadas: [Mecanismos desenvolvidos]
- Vulnerabilidades expostas: [O que revelou]

---

# ## [PRÃXIMO ANO] - Idade: [X] anos
[Continue o mesmo formato...]

# # Era da ConstruÃ§Ã£o ([Idade ~25] - [Idade ~40])
[Continue com eventos desta fase...]

# # Era da ConsolidaÃ§Ã£o ([Idade ~40] - [Idade ~55])
[Continue com eventos desta fase...]

# # Era do Legado ([Idade ~55] - [Presente/Morte])
[Continue com eventos desta fase...]

# PADRÃES TEMPORAIS IDENTIFICADOS

# # Ciclos Recorrentes
- Ciclo de [X] anos: [PadrÃ£o que se repete]
- Trigger do ciclo: [O que reinicia o padrÃ£o]
- Como termina: [Como o ciclo se quebra]

# # PerÃ­odos de Crise
1. [Anos]: [Natureza da crise]
   - DuraÃ§Ã£o: [Quanto tempo durou]
   - ResoluÃ§Ã£o: [Como saiu]
   - MudanÃ§as permanentes: [O que nunca mais foi igual]

# # PerÃ­odos de Crescimento Acelerado
1. [Anos]: [O que estava acontecendo]
   - Catalisadores: [O que acelerou]
   - Resultados: [O que foi alcanÃ§ado]
   - Custo: [O que foi sacrificado]

# # Pontos de InflexÃ£o
1. [Ano/Evento]: Antes vs. Depois
2. [Ano/Evento]: Antes vs. Depois
3. [Ano/Evento]: Antes vs. Depois

# ANÃLISE LONGITUDINAL

# # EvoluÃ§Ã£o de Valores
- [Idade 20-30]: Valores dominantes
- [Idade 30-40]: Valores dominantes
- [Idade 40-50]: Valores dominantes
- [Idade 50+]: Valores dominantes

# # EvoluÃ§Ã£o de Relacionamentos
- PadrÃ£o na juventude: [Como se relacionava]
- PadrÃ£o na maturidade: [Como mudou]
- PadrÃ£o final: [Como terminou]

# # EvoluÃ§Ã£o de Narrativas
- HistÃ³ria contada aos 30: [VersÃ£o]
- HistÃ³ria contada aos 50: [Como mudou]
- HistÃ³ria final: [VersÃ£o definitiva]

# SINCRONICIDADES E CONEXÃES
[Eventos aparentemente nÃ£o relacionados que se conectam]

# COUNTERFACTUALS
[Momentos onde pequenas mudanÃ§as teriam alterado tudo]
```

# # INSTRUÃÃES DE USO

# ## Antes de executar:
1. Tenha o arquivo sources_list.md completo
2. Organize fontes cronologicamente
3. Prepare para deep dive biogrÃ¡fico

# ## Durante a execuÃ§Ã£o:
1. Seja cronologicamente preciso - Datas exatas quando possÃ­vel
2. Contextualize sempre - O que estava acontecendo no mundo
3. Documente mudanÃ§as de narrativa - Como a pessoa conta a histÃ³ria mudou
4. Identifique padrÃµes - Ciclos que se repetem
5. Marque pontos de inflexÃ£o - Momentos que mudaram tudo

# ## Tags de ClassificaÃ§Ã£o:
- RUPTURA: MudanÃ§a fundamental de direÃ§Ã£o
- VALIDAÃÃO: Sucesso que criou/reforÃ§ou padrÃ£o
- COLAPSO: Fracasso significativo
- INSIGHT: Momento de compreensÃ£o profunda
- TRAUMA: Evento com impacto psicolÃ³gico profundo
- NEUTRO: Importante mas sem carga emocional

# ## DivisÃ£o por Eras:
- FormaÃ§Ã£o (0-25): Desenvolvimento de identidade
- ConstruÃ§Ã£o (25-40): Estabelecimento no mundo
- ConsolidaÃ§Ã£o (40-55): Refinamento e domÃ­nio
- Legado (55+): Foco em impacto duradouro

# # CHECKLIST DE QUALIDADE

- [ ] Todos os anos da vida cobertos
- [ ] Eventos classificados com tags apropriadas
- [ ] Contexto mundial/industrial incluÃ­do
- [ ] Justificativas originais vs. retrospectivas documentadas
- [ ] Impactos de curto e longo prazo identificados
- [ ] PadrÃµes temporais analisados
- [ ] EvoluÃ§Ã£o de valores mapeada
- [ ] Pontos de inflexÃ£o marcados
- [ ] AnÃ¡lise psicolÃ³gica incluÃ­da

# # ALERTAS CRÃTICOS
- NÃ£o pule perÃ­odos - Mesmo anos "vazios" sÃ£o informativos
- NÃ£o aceite narrativas oficiais - Compare versÃµes
- NÃ£o ignore contexto - DecisÃµes fazem sentido na Ã©poca
- Preserve mÃºltiplas versÃµes - Como a pessoa conta mudou
- Identifique traumas - Mesmo que nÃ£o admitidos
- Arquivo timeline.md deve estar em @{mind}/artifacts/ conforme OUTPUTS_GUIDE.md
- A timeline Ã© o esqueleto sobre o qual toda a personalidade Ã© construÃ­da