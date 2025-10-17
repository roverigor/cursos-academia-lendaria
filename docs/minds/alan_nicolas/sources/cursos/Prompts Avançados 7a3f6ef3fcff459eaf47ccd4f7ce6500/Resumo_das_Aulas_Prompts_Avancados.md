### O que é um Prompt Avançado
#### Prompt Super Básico:

**Ação → Saída**

![[Prompt Super Básico.png]]

Importante: Prompts SEMPRE tem uma Ação.

Todos os prompts usam um verbo.

#### Prompt Básico:

**Entrada → Ação → Saída**

Entrada = Dados de Entrada

![[Prompt básico.png]]

#### Prompt Avançado

Um Prompt Avançado tem mais informações, para explicar com mais precisão o que _exatamente_ você quer que a IA gere como resposta.

**4 objetivos principais de um Prompt Avançado:**

1. Te forçar a ter clareza sobre o que você está pedindo.

2. Melhorar o entendimento da IA e a qualidade da resposta.

3. Saber ”onde” do Prompt colocar cada informação.

4. Facilitar a edição e customização do prompt.

**Prompt Avançado**

Dados + Contexto → Ação + Passos → Formato + Exemplo (da Saída)

![[Prompt avançado.png]]

---
### Criando um Prompt para usar no ChatGPT
#### Passos para Escrever o Prompt

1. Identificar o Problema
2. Escrever a Ação
3. Explicar o Contexto
    1. Visão Geral (Contexto) 
    2. Persona
4. Fornecer os Dados
5. Detalhar os Passos
6. Descrever o Formato da Saída
    1. Estrutura    
    2. Estilo    
7. Dar um Exemplo

**Exemplo Escolhido:**

Gerar um resumo detalhado sobre um conjunto de 3 artigos sobre IA, aprofundando nas relações entre eles.

Essa ação se chama Leitura Sintópica, que é uma leitura onde você conecta diferentes textos e busca um entendimento geral sobre o tema abordado entre eles.

#### Exemplo do Prompt Básico:

**Ação:** Por favor, crie um resumo detalhado desses 3 artigos. Ao final, eu quero que você faça uma análise detalhada de como os 3 artigos estão relacionados entre si, incluindo diferenças e semelhanças entre os artigos, e conexões contra-intuitivas.

**Dados:** 

**Artigos:**

https://studio.ribbonfarm.com/p/a-camera-not-an-engine?publication_id=9973

https://www.gatesnotes.com/The-Age-of-AI-Has-Begun

https://every.to/chain-of-thought/chatgpt-and-the-future-of-the-human-mind

#### Exemplo Prompt Avançado:

```
**1. Identificar o Problema**

Problema: Entender o conteúdo de um conjunto de artigos sobre IA, e a relações entre eles.

**2. Escrever a Ação**

<ação> Ação: Escrever um resumo detalhado de cada artigo. Ao final, eu quero que você faça uma análise detalhada de como os 3 artigos estão relacionados entre si, incluindo diferenças e semelhanças entre os artigos, e conexões contra-intuitivas.

**3. Explicar o Contexto**

<persona> Persona: Você é um assistente de pesquisa, extremamente sábio no campo de Inteligência Artificial e Desenvolvimento da Humanidade. Você sempre gera respostas MUITO completas, com um pensamento ramificado e demonstrando com cuidado o caminho do seu raciocínio.

<contexto> Contexto: Os 3 artigos são sobre o tema de Inteligência Artificial, cada um de um autor respeitado nesse campo.

**4. Fornecer os Dados**

<dados>Dados:

Aqui estão os 3 Artigos:

  https://studio.ribbonfarm.com/p/a-camera-not-an-engine?publication_id=9973

  https://www.gatesnotes.com/The-Age-of-AI-Has-Begun

  https://every.to/chain-of-thought/chatgpt-and-the-future-of-the-human-mind

**5. Detalhar os Passos**

<passos> Passos:

1. Apenas gere output nos passos 3 e 5.

2. Leia cada artigo com atenção.

3. Crie um report detalhado para cada artigo, incluindo um resumo, uma explicação longa e detalhada dos assuntos principais de cada artigo e um overview. Siga o formato descrito em <formato>

4. Faça uma nova leitura. Dessa vez, faça uma leitura sintópica dos artigos, buscando entender como eles se relacionam entre si.

5. Crie um report sobre as relações entre os artigos. Inclua uma explicação das diferenças e semelhanças entre os artigos, e conexões contra-intuitivas. Siga o formato descrito em <formato>

**6. Descrever o Formato**

<formato> Formato:

Use o formato Markdown e escreva o resumo em português brasileiro.

Separe o Resumo Individual dos artigos dentro de um header principal e a Análise Sintópica em outro header principal.

Formato do Resumo Individual: Cada report deve incluir 1. um Resumo, 2. explicação longa e detalhada dos Assuntos Principais presentes no artigo e 3. uma Conclusão final.

Formato da Análise Sintópica: A Análise Sintópica deve incluir uma Visão Geral, e uma descrição longa e detalhada das Semelhanças, das Diferenças e das Conexões Contra-Intuitivas.

Lembre-se de dar detalhes e explicações longas e completas .

**7. Dar um Exemplo**

**<exemplo> Exemplo de Saída:**

**# Resumo dos Artigos:**

**## Artigo 1**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**## Artigo 2**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**## Artigo 3**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**# Análise Sintópica:**

**## Visão Geral**

 Listar visão geral

**## Semelhanças**

 Semelhança 1: Paragrafo explicando a semelhança. Use mais de uma frase.

 Semelhança 2: Paragrafo explicando a semelhança. Use mais de uma frase.

 Semelhança 3: Paragrafo explicando a semelhança. Use mais de uma frase.

**## Diferenças**

 Diferença 1: Paragrafo explicando a diferença. Use mais de uma frase.

 Diferença 2: Paragrafo explicando a diferença. Use mais de uma frase.

 Diferença 3: Paragrafo explicando a diferença. Use mais de uma frase.

**## Conexões Contra-Intuitivas**

 Conexão 1: Paragrafo explicando a conexão. Use mais de uma frase.

 Conexão 2: Paragrafo explicando a conexão. Use mais de uma frase.

 Conexão 3: Paragrafo explicando a conexão. Use mais de uma frase.

### **Juntando Tudo:**

**IMPORTANTE: Inicialização do Prompt:**

Abaixo eu vou informar uma <ação> para você executar, a <persona> que você representa, e vou explicar os <passos> que você deve seguir para executar a ação. Vou te enviar um conjunto de <dados>, e explicar o <contexto> da situação. Ao final, vou explicar o <formato> da saída, e mostrar um <exemplo> para você seguir.

**Prompt Avançado Completo:**

Abaixo eu vou informar uma <ação> para você executar, a <persona> que você representa, e vou explicar os <passos> que você deve seguir para executar a ação. Vou te enviar um conjunto de <dados>, e explicar o <contexto> da situação. Ao final, vou explicar o <formato> da saída, e mostrar um <exemplo> para você seguir.

  
<ação> Ação: Escrever um resumo detalhado de cada artigo. Ao final, eu quero que você faça uma análise detalhada de como os 3 artigos estão relacionados entre si, incluindo diferenças e semelhanças entre os artigos, e conexões contra-intuitivas.

<persona> Persona: Você é um assistente de pesquisa, extremamente sábio no campo de Inteligência Artificial e Desenvolvimento da Humanidade. Você sempre gera respostas MUITO completas, com um pensamento ramificado e demonstrando com cuidado o caminho do seu raciocínio.

<contexto> Contexto: Os 3 artigos são sobre o tema de Inteligência Artificial, cada um de um autor respeitado nesse campo.

**<dados> Dados:**

**Aqui estão os 3 Artigos:**

https://studio.ribbonfarm.com/p/a-camera-not-an-engine?publication_id=9973

https://www.gatesnotes.com/The-Age-of-AI-Has-Begun

https://every.to/chain-of-thought/chatgpt-and-the-future-of-the-human-mind

**<passos> Passos:**

1. Apenas gere output nos passos 3 e 5.

2. Leia cada artigo com atenção.

3. Crie um report detalhado para cada artigo, incluindo um resumo, uma explicação longa e detalhada dos assuntos principais de cada artigo e um overview. Siga o formato descrito em <formato>

4. Faça uma nova leitura. Dessa vez, faça uma leitura sintópica dos artigos, buscando entender como eles se relacionam entre si.

5. Crie um report sobre as relações entre os artigos. Inclua uma explicação das diferenças e semelhanças entre os artigos, e conexões contra-intuitivas. Siga o formato descrito em <formato>

**<formato> Formato:**

Use o formato Markdown e escreva o resumo em português brasileiro.

Separe o Resumo Individual dos artigos dentro de um header principal e a Análise Sintópica em outro header principal.

Formato do Resumo Individual: Cada report deve incluir 1. um Resumo, 2. explicação longa e detalhada dos Assuntos Principais presentes no artigo e 3. uma Conclusão final.

Formato da Análise Sintópica: A Análise Sintópica deve incluir uma Visão Geral, e uma descrição longa e detalhada das Semelhanças, das Diferenças e das Conexões Contra-Intuitivas.

Lembre-se de dar detalhes e explicações longas e completas .

**<exemplo> Exemplo de Saída:**

**# Resumo dos Artigos:**

**## Artigo 1**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**## Artigo 2**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**## Artigo 3**

**Resumo**

 Insira aqui o resumo original que você iria gerar. Um parágrafo longo explicando o conteúdo do artigo.

**Assuntos Principais:**

 Assunto 1: Descrição longa e detalhada do assunto. Use mais de uma frase.

 Assunto 2: Descrição longa e detalhada dos assunto. Use mais de uma frase.

 Assunto 3: Descrição longa e detalhada dos assunto. Use mais de uma frase.

Conclusão

**# Análise Sintópica:**

**## Visão Geral**

 Listar visão geral

**## Semelhanças**

 Semelhança 1: Paragrafo explicando a semelhança. Use mais de uma frase.

 Semelhança 2: Paragrafo explicando a semelhança. Use mais de uma frase.

 Semelhança 3: Paragrafo explicando a semelhança. Use mais de uma frase.

**## Diferenças**

 Diferença 1: Paragrafo explicando a diferença. Use mais de uma frase.

 Diferença 2: Paragrafo explicando a diferença. Use mais de uma frase.

 Diferença 3: Paragrafo explicando a diferença. Use mais de uma frase.

**## Conexões Contra-Intuitivas**

 Conexão 1: Paragrafo explicando a conexão. Use mais de uma frase.

 Conexão 2: Paragrafo explicando a conexão. Use mais de uma frase.

 Conexão 3: Paragrafo explicando a conexão. Use mais de uma frase.

Lembrando, por favor me responda em português, e leia o prompt inteiro antes de gerar uma resposta.
```

---
