# Aula 3.2: Anatomia do Prompt Perfeito

## Tipo: Teoria | Duração: 15 minutos

---

## GPS

### Goal (30s)
Entender os princípios científicos por trás de prompts eficazes.

### Position (60s)
A fórmula CRISP funciona, mas por quê? Entender a teoria permite criar prompts para qualquer situação.

### Steps
1. Como LLMs processam prompts (4 min)
2. Técnicas avançadas (5 min)
3. Padrões por caso de uso (6 min)

---

## Como LLMs Processam Prompts

### O Modelo Mental

```
[Seu Prompt] → [Tokenização] → [Contexto] → [Predição] → [Resposta]
```

### O que Importa

| Fator | Impacto | Como Otimizar |
|-------|---------|---------------|
| **Clareza** | Alto | Instruções diretas, sem ambiguidade |
| **Contexto** | Alto | Informação relevante no início |
| **Exemplos** | Médio-Alto | Mostrar o que você quer |
| **Formato** | Médio | Especificar estrutura de saída |
| **Ordem** | Médio | Informação importante primeiro |

---

## Técnicas Avançadas

### 1. Zero-Shot vs Few-Shot

**Zero-Shot** (sem exemplos):
```
Classifique o sentimento deste texto como positivo, negativo ou neutro:
"O produto chegou rápido mas veio com defeito."
```

**Few-Shot** (com exemplos):
```
Classifique o sentimento:

Texto: "Amei o produto, recomendo!"
Sentimento: Positivo

Texto: "Péssimo atendimento, nunca mais compro."
Sentimento: Negativo

Texto: "O produto é ok, nada demais."
Sentimento: Neutro

Texto: "O produto chegou rápido mas veio com defeito."
Sentimento:
```

**Quando usar cada um:**
| Situação | Técnica |
|----------|---------|
| Tarefa simples e comum | Zero-shot |
| Formato específico necessário | Few-shot |
| Classificação com categorias próprias | Few-shot |
| Análise rápida | Zero-shot |

---

### 2. Chain-of-Thought (CoT)

**Sem CoT:**
```
Um produto custa R$80 com 15% de desconto. Qual o preço final?
```

**Com CoT:**
```
Um produto custa R$80 com 15% de desconto. Qual o preço final?

Pense passo a passo:
1. Primeiro calcule o valor do desconto
2. Depois subtraia do preço original
3. Mostre o resultado final
```

**Quando usar:** Problemas de lógica, análises complexas, decisões multi-critério.

---

### 3. Personas e Papéis

| Persona | Quando Usar | Exemplo |
|---------|-------------|---------|
| **Expert** | Análises técnicas | "Você é um CFO com 20 anos de experiência" |
| **Crítico** | Revisões | "Você é um editor exigente" |
| **Cliente** | Testes de UX | "Você é um cliente frustrado" |
| **Mentor** | Aprendizado | "Você é um professor paciente" |

---

## Padrões por Caso de Uso

### Análise de Dados

```
Analise os seguintes dados de vendas:
[dados]

Forneça:
1. Top 3 insights acionáveis
2. Tendência principal
3. Recomendação de ação imediata

Formato: Lista com bullet points
Tom: Executivo (direto ao ponto)
```

### Criação de Conteúdo

```
Crie [tipo de conteúdo] sobre [tema].

Contexto:
- Público: [descrição]
- Objetivo: [o que quer que o leitor faça]
- Tom: [formal/casual/técnico]

Estrutura:
- [seção 1]
- [seção 2]
- [seção 3]

Restrições:
- Tamanho: [X palavras]
- Evitar: [termos/abordagens]
```

### Tomada de Decisão

```
Preciso decidir entre [opção A] e [opção B].

Contexto:
- Situação: [descreva]
- Critérios importantes: [liste]
- Restrições: [orçamento, tempo, etc.]

Analise:
1. Prós e contras de cada opção
2. Riscos de cada decisão
3. Recomendação fundamentada

Formato: Tabela comparativa + conclusão
```

### Revisão e Feedback

```
Revise o seguinte [texto/código/plano]:
[conteúdo]

Avalie em:
1. Clareza (1-10)
2. Eficácia (1-10)
3. Pontos a melhorar

Forneça versão revisada se a nota for abaixo de 7.
```

---

## Erros Comuns

| Erro | Problema | Solução |
|------|----------|---------|
| Prompt vago | Resposta genérica | Seja específico |
| Sem contexto | IA não entende situação | Adicione background |
| Muitas instruções | IA confunde prioridades | Separe em etapas |
| Formato não especificado | Formato inconsistente | Defina estrutura |
| Sem exemplos | Resultado diferente do esperado | Use few-shot |

---

## Framework de Iteração

```
1. Escreva prompt inicial
2. Teste e avalie resultado
3. Identifique gap (o que faltou?)
4. Adicione/ajuste elemento
5. Teste novamente
6. Repita até satisfatório
```

---

## Checklist de Entendimento

- [ ] Entendo a diferença entre zero-shot e few-shot
- [ ] Sei quando usar Chain-of-Thought
- [ ] Consigo escolher a persona certa para cada tarefa
- [ ] Conheço os padrões para análise, criação e decisão
- [ ] Sei como iterar e melhorar prompts

---

## Próximo Passo

Agora vamos construir sua biblioteca pessoal de 10 prompts otimizados.
