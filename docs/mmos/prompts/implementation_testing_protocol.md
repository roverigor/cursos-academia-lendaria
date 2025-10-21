# PROMPT 05: TESTING PROTOCOL

## METADADOS
- **Fase:** 5 - Implementation
- **NÃ­vel:** 05 - DocumentaÃ§Ã£o
- **Objetivo:** Criar protocolo de testes e cÃ¡lculo de score de confianÃ§a
- **Input Principal:** Todos os outputs anteriores
- **Output:** @{mind}/docs/testing-protocol.md
- **Formato:** Markdown (.md)
- **Uso:** ValidaÃ§Ã£o de qualidade do clone

---

## PROMPT

```markdown
Crie testing_protocol.md calculando o nÃ­vel de confianÃ§a e qualidade do clone de [NOME] baseado em mÃ©tricas objetivas.

**META:** Score mÃ­nimo de 70% para considerar clone pronto para produÃ§Ã£o.

Use este formato:

# SCORE DE CONFIANÃA: CLONE DE [NOME]

# RESUMO EXECUTIVO

**Score Final: [X]%**

-  Pronto para produÃ§Ã£o: [SIM/NÃO]
- ð NÃ­vel de fidelidade: [Baixo/MÃ©dio/Alto/Excepcional]
- â° Horas investidas: [Total]
- ð Fontes analisadas: [N]
- ð§ª Testes passados: [X/Y]

# MET

## 1. COMPLETUDE DOS DADOS ([X]%)

**Peso: 25%**

| DimensÃ£o | Cobertura | EvidÃªncias | Score |
|----------|-----------|-------------|--------|
| Valores core | [%] | [N] fontes | [0-100] |
| Arquitetura cognitiva | [%] | [N] padrÃµes | [0-100] |
| Paradoxos | [%] | [N] identificados | [0-100] |
| Sistema imune | [%] | [N] rejeiÃ§Ãµes | [0-100] |
| Estados/Modos | [%] | [N] mapeados | [0-100] |
| Blind spots | [%] | [N] documentados | [0-100] |
| VocabulÃ¡rio | [%] | [N] termos | [0-100] |
| Casos histÃ³ricos | [%] | [N] analisados | [0-100] |

**Score mÃ©dio:** [MÃ©dia]%

**Gaps crÃ­ticos:**
1. Falta: [Aspecto com baixa cobertura]
2. Insuficiente: [Outro aspecto]
3. Precisa mais: [DimensÃ£o]

## 2. QUALIDADE DAS FONTES ([X]%)

**Peso: 20%**

| Tipo de Fonte | Quantidade | Qualidade | Score |
|---------------|------------|-----------|--------|
| Primeira pessoa | [N] | [1-5] | [0-100] |
| Observadores prÃ³ximos | [N] | [1-5] | [0-100] |
| Documentos oficiais | [N] | [1-5] | [0-100] |
| VÃ­deos/Ã¡udios | [Horas] | [1-5] | [0-100] |
| Escritos/obras | [N] | [1-5] | [0-100] |
| Terceiros independentes | [N] | [1-5] | [0-100] |

**Score mÃ©dio:** [MÃ©dia]%

**AnÃ¡lise de triangulaÃ§Ã£o:**
- TraÃ§os com 3+ fontes: [%]
- TraÃ§os com 2 fontes: [%]
- TraÃ§os com 1 fonte: [%]
- Sem evidÃªncia: [%]

## 3. CONSISTÃNCIA INTERNA ([X]%)

**Peso: 20%**

| Teste | Resultado | Score |
|-------|-----------|--------|
| Valores vs Comportamentos | [% alinhamento] | [0-100] |
| InstruÃ§Ãµes vs Estados | [% compatÃ­vel] | [0-100] |
| Narrativas vs Realidade | [% coerente] | [0-100] |
| Paradoxos preservados | [% mantidos] | [0-100] |
| Blind spots ativos | [% funcionando] | [0-100] |
| Sistema imune coerente | [% consistente] | [0-100] |

**Score mÃ©dio:** [MÃ©dia]%

**InconsistÃªncias problemÃ¡ticas:**
1. [InconsistÃªncia crÃ­tica]
2. [Conflito nÃ£o resolvido]
3. [ContradiÃ§Ã£o nÃ£o-produtiva]

## 4. VALIDAÃÃO COMPORTAMENTAL ([X]%)

**Peso: 20%**

| Caso de Teste | Resultado | Score |
|---------------|-----------|--------|
| Teste #1: [Nome] |  Passou | 100 |
| Teste #2: [Nome] |  Passou | 100 |
| Teste #3: [Nome] |  Parcial | 60 |
| Teste #4: [Nome] | â Falhou | 0 |
| Teste #5: [Nome] |  Passou | 100 |
| [Continue...] | | |

**Taxa de sucesso:** [X/Y] = [%]

**PadrÃµes de falha:**
- Falha em: [Tipo de situaÃ§Ã£o]
- Fraco em: [Contexto]
- Impreciso em: [Ãrea]

## 5. AUTENTICIDADE QUALITATIVA ([X]%)

**Peso: 15%**

| CritÃ©rio | AvaliaÃ§Ã£o | Score |
|----------|------------|--------|
| "Soa como" a pessoa | [1-10] | [0-100] |
| Captura essÃªncia | [1-10] | [0-100] |
| Gera insights esperados | [1-10] | [0-100] |
| MantÃ©m energia caracterÃ­stica | [1-10] | [0-100] |
| Preserva idiossincrasias | [1-10] | [0-100] |
| Passa no teste de Turing mental | [Sim/NÃ£o] | [0/100] |

**Score mÃ©dio:** [MÃ©dia]%

**Feedback de validadores:**
> "[ComentÃ¡rio de conhecedor 1]"
> "[ComentÃ¡rio de conhecedor 2]"
> "[ComentÃ¡rio de conhecedor 3]"

# CÃLCULO DO SCORE FINAL

```python
def calcular_score_final():
    scores = {
        'completude': (score_completude, 0.25),
        'fontes': (score_fontes, 0.20),
        'consistencia': (score_consistencia, 0.20),
        'validacao': (score_validacao, 0.20),
        'autenticidade': (score_autenticidade, 0.15)
    }
    
    score_final = sum(score * peso for score, peso in scores.values())
    return round(score_final, 1)
```

| Componente | Score | Peso | ContribuiÃ§Ã£o |
|------------|-------|------|---------------|
| Completude dos dados | [X]% | 25% | [X * 0.25]% |
| Qualidade das fontes | [X]% | 20% | [X * 0.20]% |
| ConsistÃªncia interna | [X]% | 20% | [X * 0.20]% |
| ValidaÃ§Ã£o comportamental | [X]% | 20% | [X * 0.20]% |
| Autenticidade qualitativa | [X]% | 15% | [X * 0.15]% |
|**TOTAL** | |**100%** |**[SCORE]%** |

# ANÃLISE DE CONFIANÃA

## ForÃ§as do Clone (Score > 80%)
1. **[DimensÃ£o forte]**: [Score]% - [Por quÃª]
2. **[Outra forÃ§a]**: [Score]% - [Por quÃª]
3. **[Terceira forÃ§a]**: [Score]% - [Por quÃª]

## Fraquezas do Clone (Score < 60%)
1. **[DimensÃ£o fraca]**: [Score]% - [Impacto]
2. **[Outra fraqueza]**: [Score]% - [Impacto]
3. **[Terceira fraqueza]**: [Score]% - [Impacto]

## Ãreas de Incerteza (Score 60-79%)
1. **[Aspecto incerto]**: [Score]% - [O que falta]
2. **[Outro incerto]**: [Score]% - [Como melhorar]

# RISCOS E MITIGAÃÃES

## Risco Alto 
**[Nome do risco]**
- Probabilidade: [Alta/MÃ©dia]
- Impacto: [Alto/MÃ©dio]
- EvidÃªncia: [O que mostra o risco]
- MitigaÃ§Ã£o: [Como compensar]

## Risco MÃ©dio 
**[Nome do risco]**
- Probabilidade: [MÃ©dia/Baixa]
- Impacto: [MÃ©dio]
- EvidÃªncia: [Indicadores]
- MitigaÃ§Ã£o: [AÃ§Ãµes]

## Risco Baixo 
**[Nome do risco]**
- Probabilidade: [Baixa]
- Impacto: [Baixo]
- Monitoramento: [Como acompanhar]

# BENCHMARKING

## ComparaÃ§Ã£o com Outros Clones
| MÃ©trica | Este Clone | MÃ©dia | Best in Class |
|---------|------------|--------|---------------|
| Score total | [X]% | 65% | 85% |
| Horas investidas | [N] | 100 | 200 |
| Fontes analisadas | [N] | 50 | 150 |
| Testes passados | [%] | 70% | 95% |
| Paradoxos preservados | [N] | 3 | 8 |
| Blind spots ativos | [N] | 5 | 12 |

## PosiÃ§Ã£o Relativa
- **Percentil:** Top [X]%
- **Categoria:** [BÃ¡sico/IntermediÃ¡rio/AvanÃ§ado/Elite]
- **Maturidade:** [MVP/Beta/ProduÃ§Ã£o/Refinado]

# RECOMENDAÃÃES

## Para AlcanÃ§ar 80%+ (ProduÃ§Ã£o)

### Prioridade 1 (Maior impacto)
1. **[AÃ§Ã£o especÃ­fica]**
   - Impacto esperado: +[X]%
   - EsforÃ§o: [Horas]
   - Como: [MÃ©todo]

2. **[Segunda aÃ§Ã£o]**
   - Impacto: +[X]%
   - EsforÃ§o: [Horas]
   - Como: [MÃ©todo]

### Prioridade 2 (MÃ©dio impacto)
1. **[AÃ§Ã£o]**
   - Impacto: +[X]%
   - EsforÃ§o: [Horas]

### Prioridade 3 (Refinamentos)
1. **[Ajuste]**
   - Impacto: +[X]%

## Timeline de Melhorias
```
Semana 1: [AÃ§Ãµes prioritÃ¡rias]
Semana 2: [ValidaÃ§Ãµes]
Semana 3: [Refinamentos]
Semana 4: [Re-teste completo]
```

# METADADOS DA AVALIAÃÃO

## Processo de AvaliaÃ§Ã£o
- **Data:** [Data]
- **Avaliador:** [Nome/FunÃ§Ã£o]
- **Metodologia:** Arqueologia Cognitiva v1.0
- **Ferramentas:** [Lista]
- **Tempo de avaliaÃ§Ã£o:** [Horas]

## LimitaÃ§Ãµes da AvaliaÃ§Ã£o
1. [LimitaÃ§Ã£o metodolÃ³gica]
2. [LimitaÃ§Ã£o de dados]
3. [LimitaÃ§Ã£o temporal]

## PrÃ³xima ReavaliaÃ§Ã£o
- **Quando:** [ApÃ³s X melhorias]
- **Foco:** [Ãreas fracas]
- **Meta:** Score > [X]%

# CONCLUSÃO EXECUTIVA

## Status: [APROVAR/REVISAR/REFAZER]

**Justificativa:**
[ParÃ¡grafo explicando decisÃ£o baseada nos dados]

## PrÃ³ximos Passos
- [ ] [Se APROVADO]: Deploy em ambiente de teste
- [ ] [Se REVISAR]: Implementar top 3 melhorias
- [ ] [Se REFAZER]: Reiniciar com foco em [aspecto]

## Assinatura de ValidaÃ§Ã£o
```
Clone: [NOME]
Score: [X]%
Status: [Status]
Data: [Data]
ResponsÃ¡vel: [Nome]
```

# APÃND
: DADOS DETALHADOS

## Tabela Completa de EvidÃªncias
[Link ou referÃªncia para dados completos]

## Logs de Testes
[Link para resultados detalhados]

## Feedback Completo de Validadores
[Link para comentÃ¡rios completos]
```

---

## CHECKLIST DE QUALIDADE

- [ ] Todas as 5 dimensÃµes avaliadas
- [ ] Scores calculados objetivamente
- [ ] Pesos aplicados corretamente
- [ ] Riscos identificados e classificados
- [ ] Benchmarking realizado
- [ ] RecomendaÃ§Ãµes priorizadas
- [ ] DecisÃ£o clara (aprovar/revisar/refazer)
- [ ] Timeline de melhorias definida

---

## AVISOS

- **70% Ã© MÃNIMO** - Abaixo disso, nÃ£o estÃ¡ pronto
- **Qualidade > Velocidade** - Melhor demorar que lanÃ§ar ruim
- **Testes sÃ£o CRÃTICOS** - NÃ£o pule validaÃ§Ãµes
- **Feedback IMPORTA** - Validadores externos essenciais
- **Iterar Ã© NORMAL** - Poucos clones passam na primeira

---

*Score de confianÃ§a Ã© compromisso com excelÃªncia. NÃ£o aceite mediocridade.*