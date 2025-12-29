# AULA 6.2 | Fundamentos de Prompt Engineering para PMEs

## Modulo 6 - IA para Gestao Tributaria | Trilha 4

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 15 minutos |
| **Tipo** | Tecnico |
| **Formato** | Video |
| **Entregavel** | Saber criar prompts eficazes para questoes tributarias |

---

## OBJETIVO DA AULA

Aluno aprende:
- O que e um prompt e por que importa
- Estrutura de um prompt eficaz
- 5 elementos de um bom prompt tributario
- Erros comuns e como evitar

---

## ROTEIRO DE GRAVACAO

[TELA: "PROMPT ENGINEERING PARA PMEs"]

[O QUE E PROMPT - 2 min]
Locucao: "Prompt e a instrucao que voce da para a IA.
Quanto MELHOR o prompt, MELHOR a resposta.

Exemplo RUIM:
'Me ajuda com impostos'

Exemplo BOM:
'Atue como contador. Minha empresa fatura R$ 50K/mes no Simples.
Compare quanto pagaria no Presumido. Mostre calculos.'"

---

[TELA: Estrutura do prompt]

[5 ELEMENTOS - 6 min]
Locucao: "Todo bom prompt tem 5 elementos:

1. PAPEL (Quem a IA deve ser)
   'Atue como contador especialista em PMEs'
   'Atue como advogado tributarista'

2. CONTEXTO (Sua situacao)
   'Minha empresa fatura R$ X'
   'Estou no regime Y'
   'Tenho Z funcionarios'

3. TAREFA (O que voce quer)
   'Calcule...'
   'Compare...'
   'Explique...'
   'Gere...'

4. FORMATO (Como quer a resposta)
   'Em formato de tabela'
   'Em topicos'
   'Com calculos detalhados'

5. RESTRICOES (O que evitar)
   'Sem jargao tecnico'
   'Apenas opcoes legais'
   'Considere apenas Simples Nacional'"

---

[TELA: Template universal]

[TEMPLATE - 4 min]
Locucao: "Use este template:

---
Atue como [PAPEL].

CONTEXTO:
- Empresa: [tipo]
- Faturamento: R$ [valor]
- Regime: [atual]
- Situacao: [descrever]

TAREFA:
[O que voce quer que a IA faca]

FORMATO:
[Como quer a resposta]

RESTRICOES:
[O que evitar ou considerar]
---

Quanto mais especifico, melhor a resposta."

---

[TELA: Erros comuns]

[ERROS - 3 min]
Locucao: "Erros que destroem seus resultados:

1. VAGO DEMAIS
   Ruim: 'Me ajuda com impostos'
   Bom: 'Calcule quanto pago de IRPJ no Presumido com lucro de R$ 50K'

2. SEM CONTEXTO
   Ruim: 'Qual o melhor regime?'
   Bom: 'Qual o melhor regime para consultoria, R$ 80K/mes, 2 socios?'

3. PERGUNTAS MULTIPLAS
   Ruim: 'Qual regime, quanto pago, e como fazer a mudanca?'
   Bom: Uma pergunta por vez

4. DADOS SENSIVEIS
   Ruim: Colocar CPF, CNPJ real, senhas
   Bom: Usar dados anonimizados ou genericos"

---

## ESTRUTURA DO PROMPT EFICAZ

```
TEMPLATE UNIVERSAL

Atue como [PAPEL: especialista em que area].

CONTEXTO DA MINHA EMPRESA:
- Tipo de empresa: [descrever atividade]
- Faturamento mensal: R$ [valor]
- Regime tributario atual: [Simples/Presumido/Real]
- Numero de funcionarios: [quantidade]
- Estado: [UF]
- [Outras informacoes relevantes]

MINHA SITUACAO:
[Descrever o problema ou duvida especifica]

TAREFA:
[O que voce quer que a IA faca - verbo de acao]

FORMATO DA RESPOSTA:
[Como quer receber - tabela, topicos, passo a passo]

RESTRICOES:
[O que deve evitar ou considerar obrigatoriamente]
```

---

## 5 ELEMENTOS DO BOM PROMPT

| Elemento | O Que E | Exemplo |
|----------|---------|---------|
| Papel | Quem a IA deve ser | "Atue como contador de PMEs" |
| Contexto | Sua situacao | "Faturamento R$ 50K, Simples" |
| Tarefa | O que fazer | "Calcule economia possivel" |
| Formato | Como responder | "Em tabela comparativa" |
| Restricoes | O que evitar | "Apenas opcoes legais" |

---

## ARTEFATO DA AULA: Biblioteca de Prompts Base

### O Que Voce Vai Criar
Colecao de templates de prompts para diferentes situacoes tributarias, prontos para personalizar e usar.

### Por Que Isso Importa
Prompts bem estruturados:
- Economizam tempo
- Geram respostas melhores
- Reduzem erros
- Permitem reuso

**Linha do DRE:** Produtividade (menos tempo = menos custo)

### Quando Usar
- Sempre que for usar IA para tributacao
- Como ponto de partida para novas perguntas
- Para treinar equipe

### Como Criar
1. Copie os templates desta aula
2. Personalize para seu contexto
3. Salve os que funcionarem bem
4. Refine com o tempo

### Template

```
BIBLIOTECA DE PROMPTS - TRIBUTACAO

================================
PROMPT 1: COMPARADOR DE REGIMES
================================
Atue como contador tributarista.

CONTEXTO:
- Atividade: [descrever]
- Faturamento: R$ [valor]/mes
- Funcionarios: [quantidade]
- Pro-labore atual: R$ [valor]

TAREFA:
Compare os regimes Simples Nacional, Lucro Presumido e Lucro Real para minha empresa.

FORMATO:
Tabela comparativa com:
- Carga tributaria total
- Principais impostos
- Vantagens e desvantagens
- Recomendacao final

RESTRICOES:
- Use aliquotas atualizadas
- Considere apenas opcoes legais
- Inclua calculo do Fator R se aplicavel

================================
PROMPT 2: CALCULADOR DE ECONOMIA
================================
Atue como consultor tributario.

CONTEXTO:
[Preencher]

TAREFA:
Calcule a economia possivel com [estrategia especifica].

FORMATO:
- Situacao atual
- Situacao proposta
- Economia mensal e anual
- Riscos e consideracoes

================================
PROMPT 3: EXPLICADOR DE CONCEITO
================================
Atue como professor de tributacao.

CONTEXTO:
Sou dono de PME, nao sou contador.

TAREFA:
Explique [conceito] de forma simples.

FORMATO:
- Definicao em 1 frase
- Como funciona na pratica
- Exemplo com numeros
- O que isso significa para minha empresa

RESTRICOES:
- Sem jargao tecnico
- Linguagem simples
- Exemplos praticos
```

---

**Criar agora?** ✅ Sim, durante a aula (10 min)
**Tempo estimado:** 10 minutos
**Onde salvar:** Documento de referencia para uso continuo

---

## IA NA PRATICA

### Prompt Principal: Criador de Prompts Personalizados

```
Atue como especialista em prompt engineering. Me ajude a criar prompts eficazes para minha situacao tributaria:

MINHA EMPRESA:
- Atividade: [descrever]
- Faturamento: R$ [valor]/mes
- Regime: [Simples/Presumido/Real]
- Funcionarios: [quantidade]
- Principais duvidas: [listar]

CRIE PROMPTS PERSONALIZADOS PARA:

1. DIAGNOSTICO TRIBUTARIO
   Prompt completo: ___

2. COMPARACAO DE REGIMES
   Prompt completo: ___

3. OTIMIZACAO DE PRO-LABORE
   Prompt completo: ___

4. CHECKLIST DE COMPLIANCE
   Prompt completo: ___

PARA CADA PROMPT:
- [ ] Papel definido
- [ ] Contexto completo
- [ ] Tarefa clara
- [ ] Formato especificado
- [ ] Restricoes adequadas

DICAS DE USO:
- Quando usar cada prompt: ___
- Como personalizar: ___
- O que adicionar se precisar: ___
```

### Prompt Alternativo: Melhorador de Prompts

```
Melhore meu prompt para obter melhores resultados:

MEU PROMPT ATUAL:
[COLAR PROMPT QUE ESTA USANDO]

RESULTADO QUE OBTIVE:
[DESCREVER O QUE A IA RESPONDEU]

PROBLEMAS:
[ ] Resposta vaga
[ ] Faltou informacao
[ ] Muito tecnico
[ ] Nao respondeu o que pedi
[ ] Outro: ___

ANALISE E MELHORE:

PROBLEMAS IDENTIFICADOS NO PROMPT:
1. ___
2. ___
3. ___

PROMPT MELHORADO:
[Gerar prompt corrigido completo]

O QUE MUDOU:
- Papel: [antes] → [depois]
- Contexto: [antes] → [depois]
- Tarefa: [antes] → [depois]
- Formato: [antes] → [depois]
- Restricoes: [antes] → [depois]

RESULTADO ESPERADO COM PROMPT MELHORADO:
___
```

### Como Usar o Resultado

| Prompt Criado | Quando Usar |
|---------------|-------------|
| Diagnostico | No inicio, para entender situacao |
| Comparacao regimes | Ao avaliar mudanca de regime |
| Otimizacao | Ao buscar economia |
| Compliance | Ao revisar conformidade |

---

## ERROS COMUNS E CORRECOES

| Erro | Exemplo Ruim | Exemplo Bom |
|------|--------------|-------------|
| Vago | "Me ajuda com impostos" | "Calcule meu IRPJ no Presumido com lucro de R$ 50K" |
| Sem contexto | "Qual melhor regime?" | "Para consultoria, R$ 80K/mes, qual melhor regime?" |
| Multiplas perguntas | "Regime, quanto pago, como mudar?" | Uma pergunta por vez |
| Dados sensiveis | CNPJ real | "Empresa do setor X" |

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Template de prompt grande e claro
- Comparacao lado a lado (ruim vs bom)
- Checklist dos 5 elementos
- Exemplos animados

### Orientacoes
- Tom pratico e didatico
- Muitos exemplos
- Enfatizar pratica
- Mostrar antes/depois

---

**Proxima Aula:** 6.3 - Diagnostico Tributario com IA
