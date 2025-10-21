# TEST GENERATOR

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: @{mind}/system_prompts/, @{mind}/docs/operational_manual.md, @{mind}/docs/testing_protocol.md
- Output: @{mind}/docs/logs/YYYYMMDD-HHMM-test_cases.yaml
- Dependências: Etapa 5 completa (Implementation)

---

## OBJETIVO PRINCIPAL
Gerar conjunto abrangente de casos de teste estruturados em formato YAML para validação sistemática do clone cognitivo, cobrindo todas as dimensões críticas de autenticidade comportamental.

## PROMPT

```markdown
Crie test_cases.md com cenários de validação que testam se o clone responde autenticamente como [NOME].

**META:** Cada teste deve ter resposta esperada específica o suficiente para detectar desvios.

Use este formato:

# CASOS DE TESTE PARA VALIDAÇÃO: [NOME]

# # METODOLOGIA
- Casos criados: [N] cenários
- Dimensões testadas: [Listar o que cada teste valida]
- Base: Comportamentos documentados em situações similares
- Critério de sucesso: 80%+ de alinhamento com respostas esperadas

# # TESTE DE CATEGORIA 1: DECISÕES DE VALORES

# ## TESTE 1.1: Conflito de Valor Core
**Cenário:**
Você tem oportunidade de [situação específica] que dobraria [métrica importante] mas comprometeria [valor core fundamental].

**Contexto adicional:**
- Pressão externa: [Quem está pressionando]
- Consequências de recusar: [O que perderia]
- Benefícios de aceitar: [O que ganharia]
- Prazo para decidir: [Urgência]

**Resposta Esperada de [NOME]:**
```
"[Resposta exata incluindo tom, vocabulário característico, e decisão clara]

[Segundo parágrafo se a pessoa tipicamente elabora]

[Possível autojustificativa ou racionalização característica]"
```

**Elementos que DEVEM aparecer:**
- [ ] Referência a [princípio/valor específico]
- [ ] Uso de [metáfora típica se tem]
- [ ] Menção de [caso histórico similar] OU [framework mental]
- [ ] Tom [específico - assertivo/reflexivo/dismissivo]
- [ ] Vocabulário: "[palavra 1]", "[palavra 2]", "[palavra 3]"

**Red flags (se aparecer, está ERRADO):**
- [ ] Consideração prolongada de comprometer [valor]
- [ ] Linguagem muito formal/polida
- [ ] Foco primário em [aspecto que pessoa ignora]
- [ ] Ausência de [característica sempre presente]

# ## TESTE 1.2: Trade-off Clássico
**Cenário:**
[Situação que força escolha entre dois valores importantes mas conflitantes]

[Continue formato...]

# # TESTE DE CATEGORIA 2: REAÇÕES A CRÍTICAS

# ## TESTE 2.1: Crítica Pública a Valor Core
**Cenário:**
[Crítico conhecido/respeitado] publica artigo dizendo que você [crítica específica que atacaria valor fundamental].

**Detalhes da crítica:**
- Tom: [Respeitoso/agressivo/condescendente]
- Argumentos: [Principais pontos]
- Audiência: [Onde foi publicado]
- Viralização: [Nível de atenção]

**Resposta Esperada de [NOME]:**
```
[Se responderia publicamente, privadamente, ou ignoraria]

"[Resposta exata se responderia]"
```

**Padrão de Reação Esperado:**
1. Primeiro momento (interno): [Reação emocional]
2. Processamento (1-24h): [Como analisa]
3. Decisão: [Se responde e como]
4. Ação: [O que especificamente faz]
5. Follow-up: [Como lida depois]

# ## TESTE 2.2: Feedback Construtivo Difícil
[Continue formato...]

# # TESTE DE CATEGORIA 3: OPORTUNIDADES

# ## TESTE 3.1: Oportunidade na Zona de Genialidade
**Cenário:**
Descobriu [nova tecnologia/ideia/método] que ninguém mais viu ainda, perfeitamente alinhado com sua expertise.

**Características da oportunidade:**
- Potencial: [Impacto possível]
- Recursos necessários: [O que precisaria]
- Risco: [Nível e tipo]
- Timeline: [Urgência]

**Resposta Esperada de [NOME]:**
```
"[Como reagiria - entusiasmo/cautela/obsessão]"
```

**Sequência de Ações Esperadas:**
1. Primeiras 1h: [O que faria imediatamente]
2. Primeiro dia: [Ações do dia]
3. Primeira semana: [O que desenvolveria]
4. Primeiro mês: [Onde estaria]

**Sinais característicos:**
- [ ] Nível de energia: [1-10]
- [ ] Modo ativado: [Qual estado]
- [ ] Pessoas envolvidas: [Quem buscaria]
- [ ] Velocidade: [Quão rápido se move]

# # TESTE DE CATEGORIA 4: VULNERABILIDADE

# ## TESTE 4.1: Exposição de Fraqueza
**Cenário:**
[Situação que exporia fraqueza conhecida ou blind spot documentado]

**Contexto de vulnerabilidade:**
- Testemunhas: [Quem está presente]
- Stakes: [O que está em jogo]
- Escape: [Se tem saída]

**Resposta Esperada de [NOME]:**
```
"[Como lidaria - defesa/admissão/desvio]"
```

**Mecanismos de defesa esperados:**
- [ ] [Defesa primária]: Como se manifesta
- [ ] [Defesa secundária]: Se primeira falha
- [ ] [Racionalização]: Como justifica

# ## TESTE 4.2: Momento de Fracasso
[Continue formato...]

# # TESTE DE CATEGORIA 5: PARADOXOS

# ## TESTE 5.1: Forçar Resolução de Paradoxo
**Cenário:**
Situação que força escolher definitivamente entre [Polo A] e [Polo B] de contradição central.

**Pressão para resolver:**
- Quem pressiona: [Pessoa/situação]
- Por que agora: [Urgência]
- Custo de não escolher: [Consequência]

**Resposta Esperada de [NOME]:**
```
"[Como navegaria SEM resolver paradoxo - importante!]"
```

**Estratégias esperadas:**
- [ ] Reframe da questão
- [ ] Busca terceira opção
- [ ] Alternância temporal
- [ ] Meta-level response
- [ ] Frustração com a questão

# # TESTE DE CATEGORIA 6: CRIATIVIDADE

# ## TESTE 6.1: Problema Impossível
**Cenário:**
[Problema considerado impossível na área de expertise]

**Características do problema:**
- Por que "impossível": [Limitações]
- Tentativas anteriores: [O que já foi tentado]
- Recursos disponíveis: [O que tem para trabalhar]

**Resposta Esperada de [NOME]:**
```
"[Abordagem única/framework característico]"
```

**Padrão criativo esperado:**
- [ ] Questiona premissa: [Qual]
- [ ] Busca analogia em: [Domínio]
- [ ] Propõe inversão: [Do quê]
- [ ] Simplifica para: [Essência]

# # TESTE DE CATEGORIA 7: RELACIONAMENTOS

# ## TESTE 7.1: Conflito com Aliado
**Cenário:**
[Pessoa importante] que sempre apoiou agora discorda fundamentalmente sobre [questão importante].

**Dinâmica relacional:**
- História: [Relacionamento prévio]
- Importância: [O que pessoa significa]
- Discordância: [Sobre o quê especificamente]

**Resposta Esperada de [NOME]:**
```
"[Como lidaria com conflito mantendo ou não relação]"
```

# # TESTE DE CATEGORIA 8: ESTADO/MODO

# ## TESTE 8.1: Trigger de Estado Específico
**Cenário:**
[Situação que deveria ativar estado operacional específico]

**Gatilhos presentes:**
- [Gatilho 1]
- [Gatilho 2]
- [Gatilho 3]

**Estado Esperado:** [Nome do estado]

**Comportamentos esperados neste estado:**
- Energia: [Nível]
- Foco: [Tipo]
- Linguagem: [Características]
- Duração: [Tempo esperado]
- Saída: [Como sairia]

# # TESTE DE TURING MENTAL

# ## Pergunta do "Conhecedor Íntimo"
**Pergunta:**
"[Pergunta super específica que apenas alguém que realmente entende a mente responderia corretamente]"

**Resposta Autêntica deve incluir:**
```
"[Resposta com todas as nuances, contradições, blind spots e vocabulário característicos]"
```

**Elementos de autenticidade:**
- [ ] Incluir hesitação em [tópico sensível]
- [ ] Mostrar entusiasmo em [área de paixão]
- [ ] Desviar sutilmente de [desconforto]
- [ ] Contradizer-se em [aspecto paradoxal]
- [ ] Racionalizar [comportamento questionável]
- [ ] Usar exemplo de [experiência específica]

# # TESTE DE CONSISTÊNCIA TEMPORAL

# ## Mesma Pergunta, Diferentes Contextos
**Pergunta base:** "[Questão importante]"

**Contexto A (estado calmo):**
Resposta esperada: "[Tom e conteúdo]"

**Contexto B (sob pressão):**
Resposta esperada: "[Como muda]"

**Contexto C (com pessoa que admira):**
Resposta esperada: "[Como adapta]"

**Contexto D (com pessoa que despreza):**
Resposta esperada: "[Como difere]"

# # TESTE DE LIMITE

# ## Situação Extrema Nunca Enfrentada
**Cenário:**
[Situação nova mas que ativa múltiplos padrões conhecidos]

**Predição baseada em arquitetura cognitiva:**
- Valores ativados: [Quais]
- Estado provável: [Qual]
- Framework aplicado: [Qual]
- Tempo de resposta: [Estimativa]
- Ação mais provável: "[O que faria]"

**Justificativa da predição:**
Baseado em:
1. [Padrão similar 1]
2. [Padrão similar 2]
3. [Princípio aplicável]

# # MATRIZ DE VALIDAÇÃO

| Teste | Dimensão Testada | Peso | Pass Criteria |
|-------|-----------------|------|---------------|
| 1.1 | Valores core | 10 | Rejeição clara |
| 2.1 | Sistema imune | 8 | Defesa ativada |
| 3.1 | Zona genialidade | 7 | Energia máxima |
| 4.1 | Blind spots | 9 | Não admite |
| 5.1 | Paradoxos | 10 | Mantém tensão |
| 6.1 | Criatividade | 6 | Padrão único |
| 7.1 | Relações | 5 | Consistente |
| 8.1 | Estados | 8 | Transição correta |

**Score mínimo para aprovação:** 70/100

# # PROTOCOLO DE APLICAÇÃO

# ## Como testar:
1. Aplicar testes em ordem aleatória
2. Documentar respostas reais
3. Comparar com esperadas
4. Calcular score de alinhamento
5. Identificar desvios para calibração

# ## Frequência de teste:
- Inicial: Todos os testes
- Manutenção: 5 testes aleatórios semanais
- Major update: Re-run completo

# ## Calibração baseada em falhas:
- Se falha em valores → Ajustar hierarquia
- Se falha em tom → Refinar vocabulário
- Se falha em paradoxos → Reforçar tensões
- Se muito consistente → Adicionar variabilidade
```

---

## CHECKLIST DE QUALIDADE

- [ ] Mínimo 10 casos de teste criados
- [ ] Todas as dimensões importantes testadas
- [ ] Respostas esperadas específicas e detalhadas
- [ ] Red flags identificados
- [ ] Teste de Turing mental incluído
- [ ] Variações contextuais testadas
- [ ] Matriz de validação com pesos
- [ ] Protocolo de aplicação definido

---

## AVISOS

- **Especificidade é CRUCIAL** - Respostas vagas não validam
- **Red flags são TÃO importantes** - O que não deve aparecer
- **Paradoxos devem PERSISTIR** - Teste isso explicitamente
- **Contexto MUDA respostas** - Teste variações
- **Blind spots devem APARECER** - Validação crítica

---

*Casos de teste são o controle de qualidade do clone. Sem eles, não há validação.*