# Documentação Chat GPT

## Iniciar

### Introdução e Conceitos chave

### Text generation models (Modelos de geração de texto)

Os modelos de geração de texto da OpenAI (muitas vezes chamados de transformadores generativos pré-treinados ou modelos "GPT"), como GPT-4 e GPT-3.5, foram treinados para compreender a linguagem natural e formal. Modelos como o GPT-4 permitem saídas de texto em resposta às suas entradas. As entradas para esses modelos também são chamadas de “prompts”.

Projetar um prompt é essencialmente como você "programa" um modelo como o GPT-4, geralmente fornecendo instruções ou alguns exemplos de como concluir uma tarefa com êxito. Modelos como o GPT-4 podem ser usados em uma grande variedade de tarefas, incluindo geração de conteúdo ou código, resumo, conversação, redação criativa e muito mais. Leia mais em nosso guia introdutório de geração de texto e em nosso guia de engenharia imediata .

### Assistentes

Assistentes referem-se a entidades, que no caso da API OpenAI são alimentadas por grandes modelos de linguagem como GPT-4, que são capazes de realizar tarefas para os usuários. Esses assistentes operam com base nas instruções incorporadas na janela de contexto do modelo.

Eles também costumam ter acesso a ferramentas que permitem aos assistentes realizar tarefas mais complexas, como executar código ou recuperar informações de um arquivo. Leia mais sobre assistentes em nossa Visão geral da API de assistentes .

### Embeddings (Incorporações)

Uma incorporação é uma representação vetorial de um dado (por exemplo, algum texto) que visa preservar aspectos de seu conteúdo e/ou significado. Pedaços de dados semelhantes de alguma forma tenderão a ter incorporações mais próximas do que dados não relacionados.

OpenAI oferece modelos de incorporação de texto que recebem como entrada uma string de texto e produzem como saída um vetor de incorporação. Os embeddings são úteis para pesquisa, agrupamento, recomendações, detecção de anomalias, classificação e muito mais. Leia mais sobre embeddings em nosso guia de embeddings .

### Token (Fichas)

Os modelos de geração e incorporação de texto processam o texto em pedaços chamados tokens. Os tokens representam sequências de caracteres que ocorrem comumente. Por exemplo, a string "tokenization" é decomposta como "token" e "ization", enquanto uma palavra curta e comum como "the" é representada como um único token. Observe que em uma frase, o primeiro token de cada palavra normalmente começa com um caractere de espaço. Confira nossa ferramenta tokenizer para testar strings específicas e ver como elas são traduzidas em tokens. Como regra geral, 1 token tem aproximadamente 4 caracteres ou 0,75 palavras para texto em inglês.

Uma limitação a ter em mente é que, para um modelo de geração de texto, o prompt e a saída gerada combinados não devem exceder o comprimento máximo de contexto do modelo. Para modelos de incorporação (que não geram tokens), a entrada deve ser menor que o comprimento máximo de contexto do modelo. Os comprimentos máximos de contexto para cada modelo de geração de texto e incorporação podem ser encontrados no índice do modelo .

---

### Modelos

### Visão geral

A API OpenAI é alimentada por um conjunto diversificado de modelos com diferentes capacidades e preços. Você também pode personalizar nossos modelos para seu caso de uso específico com [ajuste fino](https://platform.openai.com/docs/guides/fine-tuning) .

| MODELO | DESCRIÇÃO |
| --- | --- |
| **GPT-4 e GPT-4 Turbo** | Um conjunto de modelos que melhoram o GPT-3.5 e podem compreender e gerar linguagem natural ou código |
| **Turbo GPT-3.5** | Um conjunto de modelos que melhoram o GPT-3.5 e podem compreender e gerar linguagem natural ou código |
| **DALL·E** | Um modelo que pode gerar e editar imagens a partir de uma solicitação de linguagem natural |
| **TTS** | Um conjunto de modelos que podem converter texto em áudio falado com som natural |
| **Whisper** | Um modelo que pode converter áudio em texto |
| **Embeddings** | Um conjunto de modelos que podem converter texto em formato numérico |
| **Moderation** | Um modelo ajustado que pode detectar se o texto pode ser sensível ou inseguro |
| **GPT base** | Um conjunto de modelos sem instrução que pode compreender e também gerar linguagem natural ou código |
| **Deprecated** | Uma lista completa de modelos que foram descontinuados junto com a substituição sugerida |

### Whisper

Whisper é um modelo de reconhecimento de fala de uso geral. Ele é treinado em um grande conjunto de dados de áudio diversificado e também é um modelo multitarefa que pode realizar reconhecimento de fala multilíngue, bem como tradução de fala e identificação de idioma. O modelo Whisper v2-large está atualmente disponível através de nossa API com o `whisper-1`nome do modelo.

Atualmente, não há diferença entre a [versão de código aberto do Whisper](https://github.com/openai/whisper) e a versão disponível através da nossa API. No entanto, [por meio de nossa API](https://platform.openai.com/docs/guides/speech-to-text) , oferecemos um processo de inferência otimizado que torna a execução do Whisper por meio de nossa API muito mais rápida do que por outros meios. Para mais detalhes técnicos sobre o Whisper, você pode [ler o artigo](https://arxiv.org/abs/2212.04356) .

### Embeddings

Embeddings são uma representação numérica de texto que pode ser usada para medir a relação entre duas partes de texto. As incorporações são úteis para tarefas de pesquisa, clustering, recomendações, detecção de anomalias e classificação. Você pode ler mais sobre nossos modelos de incorporação mais recentes na [postagem do blog de anúncios](https://openai.com/blog/new-embedding-models-and-api-updates) .

| MODELO | DESCRIÇÃO | DIMENSÃO DE SAÍDA |
| --- | --- | --- |
| text-embedding-3-large | **Incorporação V3 grande**  <br>Modelo de incorporação mais capaz para tarefas em inglês e não-inglês | 3.072 |
| text-embedding-3-small | **Incorporação do V3 pequeno**  <br>Maior desempenho em relação ao modelo de incorporação ADA de 2ª geração | 1.536 |
| text-embedding-ada-002 | Modelo de incorporação de 2ª geração mais capaz, substituindo 16 modelos de primeira geração | 1.536 |

### Moderação

[Os modelos de moderação são projetados para verificar se o conteúdo está em conformidade com as políticas de uso](https://openai.com/policies/usage-policies) da OpenAI . Os modelos fornecem recursos de classificação que procuram conteúdo nas seguintes categorias: ódio, ódio/ameaça, automutilação, sexual, sexual/menores, violência e violência/gráfica. Você pode descobrir mais em nosso [guia de moderação](https://platform.openai.com/docs/guides/moderation/overview) .

Os modelos de moderação recebem uma entrada de tamanho arbitrário que é automaticamente dividida em pedaços de 4.096 tokens. Nos casos em que a entrada é superior a 32.768 tokens, é usado o truncamento que, em raras condições, pode omitir um pequeno número de tokens da verificação de moderação.

Os resultados finais de cada solicitação ao endpoint de moderação mostram o valor máximo por categoria. Por exemplo, se um pedaço de tokens 4K tivesse uma pontuação de categoria de 0,9901 e o outro tivesse uma pontuação de 0,1901, os resultados mostrariam 0,9901 na resposta da API, uma vez que é mais alto.

| MODELO | DESCRIÇÃO | MÁXIMO DE TOKENS |
| --- | --- | --- |
| moderação de texto mais recente | Atualmente aponta para `text-moderation-007`. | 32.768 |
| moderação de texto estável | Atualmente aponta para `text-moderation-007`. | 32.768 |
| moderação de texto-007 | Modelo de moderação mais capaz em todas as categorias. | 32.768 |

## Capacidades

### Modelos de geração de texto

Os modelos de geração de texto da OpenAI (muitas vezes chamados de transformadores generativos pré-treinados ou modelos de linguagem grande) foram treinados para compreender linguagem natural, código e imagens. Os modelos fornecem saídas de texto em resposta às suas entradas. As entradas para esses modelos também são chamadas de “prompts”. Projetar um prompt é essencialmente como você “programa” um grande modelo de linguagem, geralmente fornecendo instruções ou alguns exemplos de como concluir uma tarefa com êxito.

Usando os modelos de geração de texto da OpenAI, você pode criar aplicativos para:

- Rascunhos de documentos
- Escreva código de computador
- Responda perguntas sobre uma base de conhecimento
- Analisar textos
- Dê ao software uma interface de linguagem natural
- Tutor em diversas disciplinas
- Traduzir idiomas
- Simule personagens para jogos

### Embeddings

Aprenda como transformar texto em números, desbloqueando casos de uso como pesquisa.

**O que são embeddings?**

Os embeddings de texto da OpenAI medem o relacionamento das strings de texto. Incorporações são comumente usadas para:

- **Pesquisa** (onde os resultados são classificados por relevância para uma string de consulta)
- **Clustering** (onde strings de texto são agrupadas por similaridade)
- **Recomendações** (onde são recomendados itens com sequências de texto relacionadas)
- **Detecção de anomalias** (onde são identificados valores discrepantes com pouca relação)
- **Medição de diversidade** (onde as distribuições de similaridade são analisadas)
- **Classificação** (onde as strings de texto são classificadas pelo rótulo mais semelhante)

Uma incorporação é um vetor (lista) de números de ponto flutuante. A [distância](https://platform.openai.com/docs/guides/embeddings/which-distance-function-should-i-use) entre dois vetores mede sua relação. Pequenas distâncias sugerem alto parentesco e grandes distâncias sugerem baixo parentesco.

Visite nossa [página de preços](https://openai.com/api/pricing/) para saber mais sobre os preços de Embeddings. As solicitações são cobradas com base no número de [tokens](https://platform.openai.com/tokenizer) na [entrada](https://platform.openai.com/docs/api-reference/embeddings/create#embeddings/create-input) .

### Fine-tuning

### Introdução

O ajuste fino permite que você aproveite melhor os modelos disponíveis por meio da API, fornecendo:

- Resultados de maior qualidade do que solicitar
- Capacidade de treinar com mais exemplos do que cabem em um prompt
- Economia de token devido a prompts mais curtos
- Solicitações de menor latência

Os modelos de geração de texto da OpenAI foram pré-treinados em uma grande quantidade de texto. Para usar os modelos de forma eficaz, incluímos instruções e, às vezes, vários exemplos em um prompt. Usar demonstrações para mostrar como executar uma tarefa costuma ser chamado de "aprendizagem rápida".

O ajuste fino melhora o aprendizado em poucas tentativas, treinando em muito mais exemplos do que cabem no prompt, permitindo que você obtenha melhores resultados em um amplo número de tarefas. **Depois que um modelo tiver sido ajustado, você não precisará fornecer tantos exemplos no prompt.** Isso economiza custos e permite solicitações de menor latência.

Em alto nível, o ajuste fino envolve as seguintes etapas:

1. Preparar e fazer upload de dados de treinamento
2. Treine um novo modelo ajustado
3. Avalie os resultados e volte ao passo 1, se necessário
4. Use seu modelo ajustado

Visite nossa [página de preços](https://openai.com/api/pricing) para saber mais sobre como o treinamento e o uso de modelos ajustados são cobrados.

### Quais modelos podem ser ajustados?

O ajuste fino está atualmente disponível para os seguintes modelos: `gpt-3.5-turbo-1106`(recomendado), `gpt-3.5-turbo-0613`, `babbage-002`, `davinci-002`e `gpt-4-0613`(experimental). O suporte para `gpt-3.5-turbo-0125`estará disponível em breve.

Você também pode ajustar um modelo ajustado que será útil se você adquirir dados adicionais e não quiser repetir as etapas de treinamento anteriores.

Esperamos `gpt-3.5-turbo`ser o modelo certo para a maioria dos usuários em termos de resultados e facilidade de uso.

### Quando usar o ajuste fino

O ajuste fino dos modelos de geração de texto OpenAI pode torná-los melhores para aplicações específicas, mas requer um investimento cuidadoso de tempo e esforço. Recomendamos primeiro tentar obter bons resultados com engenharia de prompt, encadeamento de prompt (dividindo tarefas complexas em vários prompts) e [chamada de função](https://platform.openai.com/docs/guides/function-calling) , sendo os principais motivos:

- Há muitas tarefas nas quais nossos modelos podem inicialmente não parecer ter um bom desempenho, mas os resultados podem ser melhorados com as instruções corretas - portanto, o ajuste fino pode não ser necessário
- A iteração sobre prompts e outras táticas tem um ciclo de feedback muito mais rápido do que a iteração com ajuste fino, que requer a criação de conjuntos de dados e a execução de jobs de treinamento
- Nos casos em que o ajuste fino ainda é necessário, o trabalho inicial de engenharia imediata não é desperdiçado - normalmente vemos melhores resultados ao usar um bom prompt nos dados de ajuste fino (ou combinar o encadeamento de prompts/uso de ferramenta com ajuste fino)

Nosso [rápido guia de engenharia](https://platform.openai.com/docs/guides/prompt-engineering) fornece informações básicas sobre algumas das estratégias e táticas mais eficazes para obter melhor desempenho sem ajustes finos. Você pode achar útil iterar rapidamente os prompts em nosso [playground](https://platform.openai.com/playground) .

### Casos de uso comuns

Alguns casos de uso comuns em que o ajuste fino pode melhorar os resultados:

- Definir o estilo, tom, formato ou outros aspectos qualitativos
- Melhorando a confiabilidade na produção do resultado desejado
- Corrigindo falhas para seguir instruções complexas
- Lidando com muitos casos extremos de maneiras específicas
- Executar uma nova habilidade ou tarefa que seja difícil de articular rapidamente

Uma maneira de pensar de alto nível sobre esses casos é quando é mais fácil “mostrar, não contar”. Nas próximas seções, exploraremos como configurar dados para ajuste fino e vários exemplos em que o ajuste fino melhora o desempenho em relação ao modelo de linha de base.

Outro cenário onde o ajuste fino é eficaz é na redução de custos e/ou latência, substituindo o GPT-4 ou utilizando prompts mais curtos, sem sacrificar a qualidade. Se você conseguir bons resultados com o GPT-4, muitas vezes poderá alcançar uma qualidade semelhante com um modelo ajustado, `gpt-3.5-turbo`ajustando as conclusões do GPT-4, possivelmente com um prompt de instrução abreviado.

### Preparando seu conjunto de dados

Depois de determinar que o ajuste fino é a solução certa (ou seja, você otimizou seu prompt o máximo possível e identificou os problemas que o modelo ainda apresenta), você precisará preparar os dados para treinar o modelo. Você deve criar um conjunto diversificado de conversas de demonstração que sejam semelhantes às conversas às quais você solicitará que o modelo responda no momento da inferência na produção.

Cada exemplo no conjunto de dados deve ser uma conversa no mesmo formato da nossa [Chat Completions API](https://platform.openai.com/docs/api-reference/chat/create) , especificamente uma lista de mensagens em que cada mensagem tem uma função, conteúdo e [nome opcional](https://platform.openai.com/docs/api-reference/chat/create#chat/create-chat/create-messages-name) . Pelo menos alguns dos exemplos de treinamento devem direcionar diretamente os casos em que o modelo solicitado não está se comportando conforme desejado, e as mensagens assistentes fornecidas nos dados devem ser as respostas ideais que você deseja que o modelo forneça.

### Solicitações de elaboração

Geralmente recomendamos seguir o conjunto de instruções e prompts que você achou que funcionaram melhor para o modelo antes do ajuste fino e incluí-los em todos os exemplos de treinamento. Isto deve permitir que você alcance os melhores e mais gerais resultados, especialmente se você tiver relativamente poucos (por exemplo, menos de cem) exemplos de treinamento.

Se você quiser encurtar as instruções ou prompts que são repetidos em todos os exemplos para economizar custos, tenha em mente que o modelo provavelmente se comportará como se essas instruções estivessem incluídas, e pode ser difícil fazer com que o modelo ignore essas instruções "preparadas". -in" instruções no momento da inferência.

Podem ser necessários mais exemplos de treinamento para chegar a bons resultados, pois o modelo precisa aprender inteiramente por meio de demonstração e sem instruções guiadas.

### Exemplos de recomendações de contagem

Para ajustar um modelo, é necessário fornecer pelo menos 10 exemplos. Normalmente vemos melhorias claras no ajuste fino de 50 a 100 exemplos de treinamento, `gpt-3.5-turbo`mas o número certo varia muito com base no caso de uso exato.

Recomendamos começar com 50 demonstrações bem elaboradas e ver se o modelo mostra sinais de melhoria após o ajuste fino. Em alguns casos, isso pode ser suficiente, mas mesmo que o modelo ainda não tenha qualidade de produção, melhorias claras são um bom sinal de que o fornecimento de mais dados continuará a melhorar o modelo. Nenhuma melhoria sugere que talvez seja necessário repensar como configurar a tarefa para o modelo ou reestruturar os dados antes de ir além de um conjunto limitado de exemplos.

### Treinar e testar divisões

Depois de coletar o conjunto de dados inicial, recomendamos dividi-lo em uma parte de treinamento e de teste. Ao enviar um trabalho de ajuste fino com arquivos de treinamento e de teste, forneceremos estatísticas de ambos durante o curso do treinamento. Essas estatísticas serão o sinal inicial de quanto o modelo está melhorando. Além disso, construir um conjunto de testes antecipadamente será útil para garantir que você seja capaz de avaliar o modelo após o treinamento, gerando amostras no conjunto de testes.

### Limites de token

Os limites de token dependem do modelo selecionado. Para `gpt-3.5-turbo-1106`, o comprimento máximo do contexto é 16.385, portanto cada exemplo de treinamento também é limitado a 16.385 tokens. Para `gpt-3.5-turbo-0613`cada exemplo de treinamento é limitado a 4.096 tokens. Exemplos maiores que o padrão serão truncados para o comprimento máximo do contexto que remove tokens do final do(s) exemplo(s) de treinamento. Para ter certeza de que todo o seu exemplo de treinamento se ajusta ao contexto, considere verificar se a contagem total de tokens no conteúdo da mensagem está abaixo do limite.

Você pode calcular contagens de tokens usando nosso [caderno de contagem de tokens](https://cookbook.openai.com/examples/How_to_count_tokens_with_tiktoken.ipynb) do livro de receitas OpenAI.

### Estimar custos

Consulte a [página de preços](https://openai.com/pricing) para obter detalhes sobre o custo por mil tokens de entrada e saída (fazemos isso para cobrar pelos tokens que fazem parte dos dados de validação). Para estimar os custos de um trabalho de ajuste específico, use a seguinte fórmula:

> custo base por 1k tokens * número de tokens no arquivo de entrada * número de épocas treinadas
> 

Para um arquivo de treinamento com 100.000 tokens treinados em 3 épocas, o custo esperado seria de aproximadamente US$ 2,40.

### Perguntas frequentes

### Quando devo usar ajuste fino versus geração aumentada de incorporação/recuperação?

Incorporações com recuperação são mais adequadas para casos em que você precisa ter um grande banco de dados de documentos com contexto e informações relevantes.

Por padrão, os modelos da OpenAI são treinados para serem assistentes generalistas úteis. O ajuste fino pode ser usado para criar um modelo com foco restrito e que exiba padrões de comportamento específicos e arraigados. Estratégias de recuperação podem ser usadas para disponibilizar novas informações para um modelo, fornecendo-lhe um contexto relevante antes de gerar sua resposta. As estratégias de recuperação não são uma alternativa ao ajuste fino e podem, na verdade, ser complementares a ele.

Você pode explorar mais as diferenças entre essas opções em nossa palestra do Developer Day:

### Posso ajustar o GPT-4 ou GPT-3.5-Turbo-16k?

O ajuste fino do GPT-4 está em acesso experimental e os desenvolvedores qualificados podem solicitar acesso por meio da [IU de ajuste fino](https://platform.openai.com/finetune) . Atualmente, `gpt-3.5-turbo-1106`suporta até 16 mil exemplos de contexto.

### Como posso saber se meu modelo ajustado é realmente melhor que o modelo básico?

Recomendamos gerar amostras do modelo base e do modelo ajustado em um conjunto de teste de conversas de chat e comparar as amostras lado a lado. Para avaliações mais abrangentes, considere usar a [estrutura de avaliação OpenAI](https://github.com/openai/evals) para criar uma avaliação específica para seu caso de uso.

### Posso continuar o ajuste fino de um modelo que já foi ajustado?

Sim, você pode passar o nome de um modelo ajustado para o `model`parâmetro ao criar um trabalho de ajuste fino. Isso iniciará um novo trabalho de ajuste fino usando o modelo ajustado como ponto de partida.

### Como posso estimar o custo do ajuste fino de um modelo?

Consulte a seção [de estimativa de custo](https://platform.openai.com/docs/guides/fine-tuning/estimate-costs) acima.

### O novo endpoint de ajuste fino ainda funciona com pesos e preconceitos para monitorar métricas?

Não, atualmente não apoiamos esta integração, mas estamos trabalhando para viabilizá-la num futuro próximo.

### Quantos trabalhos de ajuste fino posso executar ao mesmo tempo?

Consulte nosso [guia de limite de taxa](https://platform.openai.com/docs/guides/rate-limits/what-are-the-rate-limits-for-our-api) para obter as informações mais atualizadas sobre os limites.

### Como funcionam os limites de taxa em modelos ajustados?

Um modelo ajustado utiliza o mesmo limite de taxa compartilhada do modelo no qual se baseia. Por exemplo, se você usar metade do seu limite de taxa TPM em um determinado período de tempo com o `gpt-3.5-turbo`modelo padrão, qualquer modelo a partir do qual você fez o ajuste fino `gpt-3.5-turbo`teria apenas a metade restante do limite de taxa TPM acessível, uma vez que a capacidade é compartilhada entre todos modelos do mesmo tipo.

Dito de outra forma, ter modelos ajustados não oferece mais capacidade para usar nossos modelos de uma perspectiva de rendimento total.

---

### Moderação

### Visão geral

O endpoint de moderação é uma ferramenta que você pode usar para verificar se o conteúdo está em conformidade com as políticas de uso da OpenAI . Os desenvolvedores podem, assim, identificar o conteúdo que nossas políticas de uso proíbem e tomar medidas, por exemplo, filtrando-o.

Os modelos classificam as seguintes categorias:

| CATEGORIA | DESCRIÇÃO |
| --- | --- |
| `hate` | Conteúdo que expressa, incita ou promove o ódio com base em raça, gênero, etnia, religião, nacionalidade, orientação sexual, deficiência ou casta. Conteúdo de ódio dirigido a grupos não protegidos (por exemplo, jogadores de xadrez) é considerado assédio. |
| `hate/threatening` | Conteúdo de ódio que também inclua violência ou danos graves ao grupo-alvo com base em raça, sexo, etnia, religião, nacionalidade, orientação sexual, deficiência ou casta. |
| `harassment` | Conteúdo que expressa, incita ou promove linguagem de assédio contra qualquer alvo. |
| `harassment/threatening` | Conteúdo de assédio que também inclui violência ou danos graves a qualquer alvo. |
| `self-harm` | Conteúdo que promova, incentive ou retrate atos de automutilação, como suicídio, cortes e distúrbios alimentares. |
| `self-harm/intent` | Conteúdo em que o locutor expressa que está se envolvendo ou pretende se envolver em atos de automutilação, como suicídio, cortes e distúrbios alimentares. |
| `self-harm/instructions` | Conteúdo que incentiva a prática de atos de automutilação, como suicídio, cortes e distúrbios alimentares, ou que fornece instruções ou conselhos sobre como cometer tais atos. |
| `sexual` | Conteúdo destinado a despertar excitação sexual, como a descrição de atividade sexual, ou que promova serviços sexuais (excluindo educação sexual e bem-estar). |
| `sexual/minors` | Conteúdo sexual que inclui um indivíduo menor de 18 anos. |
| `violence` | Conteúdo que retrata morte, violência ou ferimentos físicos. |
| `violence/graphic` | Conteúdo que retrata morte, violência ou ferimentos físicos com detalhes gráficos. |

O endpoint de moderação é gratuito para monitorar as entradas e saídas das APIs OpenAI. Atualmente, não permitimos outros casos de uso. A precisão pode ser menor em trechos de texto mais longos. Para maior precisão, tente dividir longos trechos de texto em pedaços menores, cada um com menos de 2.000 caracteres.

---

## Assistentes

### API de assistentes

A API Assistants permite que você crie assistentes de IA em seus próprios aplicativos. Um Assistente possui instruções e pode aproveitar modelos, ferramentas e conhecimento para responder às dúvidas dos usuários. A API Assistants atualmente oferece suporte a três tipos de [ferramentas](https://platform.openai.com/docs/assistants/tools) : intérprete de código, recuperação e chamada de função. No futuro, planejamos lançar mais ferramentas criadas com OpenAI e permitir que você forneça suas próprias ferramentas em nossa plataforma.

Você pode explorar os recursos da API Assistants usando o [playground do Assistants](https://platform.openai.com/playground?mode=assistant) ou criando uma integração passo a passo descrita neste guia. Em alto nível, uma integração típica da API Assistants tem o seguinte fluxo:

1. Crie um [Assistente](https://platform.openai.com/docs/api-reference/assistants/createAssistant) na API definindo suas instruções personalizadas e escolhendo um modelo. Se for útil, habilite ferramentas como intérprete de código, recuperação e chamada de função.
2. Crie um [tópico](https://platform.openai.com/docs/api-reference/threads) quando um usuário iniciar uma conversa.
3. Adicione [mensagens](https://platform.openai.com/docs/api-reference/messages) ao tópico enquanto o usuário faz perguntas.
4. [Execute](https://platform.openai.com/docs/api-reference/runs) o Assistente no Thread para acionar respostas. Isso chama automaticamente as ferramentas relevantes.

## Guias

### Prompt engineering

### Seis estratégias para obter melhores resultados

### 1. Escreva instruções claras

Esses modelos não conseguem ler sua mente. Se os resultados forem muito longos, peça respostas breves. Se os resultados forem muito simples, peça uma redação de nível especializado. Se você não gosta do formato, demonstre o formato que gostaria de ver. Quanto menos o modelo tiver que adivinhar o que você deseja, maior será a probabilidade de você conseguir.

Táticas:

- [Inclua detalhes em sua consulta para obter respostas mais relevantes](https://platform.openai.com/docs/guides/prompt-engineering/tactic-include-details-in-your-query-to-get-more-relevant-answers)
- [Peça ao modelo para adotar uma persona](https://platform.openai.com/docs/guides/prompt-engineering/tactic-ask-the-model-to-adopt-a-persona)
- [Use delimitadores para indicar claramente partes distintas da entrada](https://platform.openai.com/docs/guides/prompt-engineering/tactic-use-delimiters-to-clearly-indicate-distinct-parts-of-the-input)
- [Especifique as etapas necessárias para concluir uma tarefa](https://platform.openai.com/docs/guides/prompt-engineering/tactic-specify-the-steps-required-to-complete-a-task)
- [Forneça exemplos](https://platform.openai.com/docs/guides/prompt-engineering/tactic-provide-examples)
- [Especifique o comprimento desejado da saída](https://platform.openai.com/docs/guides/prompt-engineering/tactic-specify-the-desired-length-of-the-output)

### 2. Forneça um texto de referência

Os modelos de linguagem podem inventar respostas falsas com segurança, especialmente quando questionados sobre tópicos esotéricos ou sobre citações e URLs. Da mesma forma que uma folha de anotações pode ajudar um aluno a se sair melhor em uma prova, fornecer um texto de referência para esses modelos pode ajudar a responder com menos invenções.

Táticas:

- [Instrua o modelo a responder usando um texto de referência](https://platform.openai.com/docs/guides/prompt-engineering/tactic-instruct-the-model-to-answer-using-a-reference-text)
- [Instrua o modelo a responder com citações de um texto de referência](https://platform.openai.com/docs/guides/prompt-engineering/tactic-instruct-the-model-to-answer-with-citations-from-a-reference-text)

### 3. Divida tarefas complexas em subtarefas mais simples

Assim como é uma boa prática na engenharia de software decompor um sistema complexo em um conjunto de componentes modulares, o mesmo se aplica às tarefas submetidas a um modelo de linguagem. Tarefas complexas tendem a ter taxas de erro mais altas do que tarefas mais simples. Além disso, tarefas complexas podem muitas vezes ser redefinidas como um fluxo de trabalho de tarefas mais simples em que os resultados de tarefas anteriores são usados para construir as entradas para tarefas posteriores.

Táticas:

- [Use a classificação de intenções para identificar as instruções mais relevantes para uma consulta do usuário](https://platform.openai.com/docs/guides/prompt-engineering/tactic-use-intent-classification-to-identify-the-most-relevant-instructions-for-a-user-query)
- [Para aplicações de diálogo que exigem conversas muito longas, resuma ou filtre os diálogos anteriores](https://platform.openai.com/docs/guides/prompt-engineering/tactic-for-dialogue-applications-that-require-very-long-conversations-summarize-or-filter-previous-dialogue)
- [Resuma documentos longos por partes e construa um resumo completo recursivamente](https://platform.openai.com/docs/guides/prompt-engineering/tactic-summarize-long-documents-piecewise-and-construct-a-full-summary-recursively)

### 4. Dê tempo ao modelo para "pensar"

Se solicitado a multiplicar 17 por 28, você pode não saber instantaneamente, mas ainda poderá resolver com o tempo. Da mesma forma, os modelos cometem mais erros de raciocínio quando tentam responder imediatamente, em vez de dedicarem tempo para elaborar uma resposta. Pedir uma “cadeia de pensamento” antes de uma resposta pode ajudar o modelo a raciocinar de forma mais confiável em direção a respostas corretas.

Táticas:

- [Instrua o modelo a elaborar sua própria solução antes de chegar a uma conclusão precipitada](https://platform.openai.com/docs/guides/prompt-engineering/tactic-instruct-the-model-to-work-out-its-own-solution-before-rushing-to-a-conclusion)
- [Use um monólogo interno ou uma sequência de perguntas para ocultar o processo de raciocínio do modelo](https://platform.openai.com/docs/guides/prompt-engineering/tactic-use-inner-monologue-or-a-sequence-of-queries-to-hide-the-model-s-reasoning-process)
- [Pergunte ao modelo se ele perdeu alguma coisa nas passagens anteriores](https://platform.openai.com/docs/guides/prompt-engineering/tactic-ask-the-model-if-it-missed-anything-on-previous-passes)

### 5. Utilize ferramentas externas

Compense as fraquezas do modelo alimentando-o com os resultados de outras ferramentas. Por exemplo, um sistema de recuperação de texto (às vezes chamado de RAG ou geração aumentada de recuperação) pode informar o modelo sobre documentos relevantes. Um mecanismo de execução de código como o Code Interpreter da OpenAI pode ajudar o modelo a fazer matemática e executar código. Se uma tarefa puder ser realizada de forma mais confiável ou eficiente por uma ferramenta do que por um modelo de linguagem, descarregue-a para obter o melhor de ambos.

Táticas:

- [Use pesquisa baseada em incorporações para implementar recuperação de conhecimento eficiente](https://platform.openai.com/docs/guides/prompt-engineering/tactic-use-embeddings-based-search-to-implement-efficient-knowledge-retrieval)
- [Use a execução de código para realizar cálculos mais precisos ou chamar APIs externas](https://platform.openai.com/docs/guides/prompt-engineering/tactic-use-code-execution-to-perform-more-accurate-calculations-or-call-external-apis)
- [Dê ao modelo acesso a funções específicas](https://platform.openai.com/docs/guides/prompt-engineering/tactic-give-the-model-access-to-specific-functions)

### 6. Teste as alterações sistematicamente

Melhorar o desempenho é mais fácil se você puder medi-lo. Em alguns casos, uma modificação em um prompt alcançará um melhor desempenho em alguns exemplos isolados, mas levará a um pior desempenho geral em um conjunto de exemplos mais representativo. Portanto, para ter certeza de que uma mudança é positiva para o desempenho, pode ser necessário definir um conjunto de testes abrangente (também conhecido como "avaliação").

Tática:

- [Avalie os resultados do modelo com referência às respostas padrão-ouro](https://platform.openai.com/docs/guides/prompt-engineering/tactic-evaluate-model-outputs-with-reference-to-gold-standard-answers)

---

### Melhores práticas de produção

Este guia fornece um conjunto abrangente de práticas recomendadas para ajudá-lo na transição do protótipo para a produção. Quer você seja um engenheiro experiente de aprendizado de máquina ou um entusiasta recente, este guia deve fornecer as ferramentas necessárias para colocar a plataforma em funcionamento com sucesso em um ambiente de produção: desde proteger o acesso à nossa API até projetar uma arquitetura robusta que possa lidar com altos volumes de tráfego. Use este guia para ajudar a desenvolver um plano para implantar seu aplicativo da maneira mais tranquila e eficaz possível.

Se você quiser explorar as práticas recomendadas para entrar em produção, confira nossa palestra do Developer Day:

[](https://youtu.be/XGJNo8TpuVA)

### Configurando sua organização

Depois de [fazer login](https://platform.openai.com/login) em sua conta OpenAI, você poderá encontrar o nome e o ID da sua organização nas [configurações da sua organização](https://platform.openai.com/account/organization) . O nome da organização é o rótulo da sua organização, mostrado nas interfaces do usuário. O ID da organização é o identificador exclusivo da sua organização que pode ser usado em solicitações de API.

Os usuários que pertencem a diversas organizações podem [passar um cabeçalho](https://platform.openai.com/docs/api-reference/requesting-organization) para especificar qual organização será usada para uma solicitação de API. O uso dessas solicitações de API será contabilizado na cota da organização especificada. Se nenhum cabeçalho for fornecido, a [organização padrão](https://platform.openai.com/account/api-keys) será cobrada. Você pode alterar sua organização padrão nas [configurações do usuário](https://platform.openai.com/account/api-keys) .

Você pode convidar novos membros para sua organização na [página Equipe](https://platform.openai.com/account/team) . Os membros podem ser **leitores** ou **proprietários** . Os leitores podem fazer solicitações de API e visualizar informações básicas da organização, enquanto os proprietários podem modificar as informações de cobrança e gerenciar membros dentro de uma organização.

### Gerenciando limites de faturamento

Para começar a usar a API OpenAI, insira suas [informações de faturamento](https://platform.openai.com/account/billing/overview) . Se nenhuma informação de faturamento for inserida, você ainda terá acesso de login, mas não poderá fazer solicitações de API.

Depois de inserir suas informações de faturamento, você terá um limite de uso aprovado de US$ 100 por mês, definido pela OpenAI. Seu limite de cota aumentará automaticamente à medida que o uso da sua plataforma aumentar e você passar de um [nível de uso](https://platform.openai.com/docs/guides/rate-limits/usage-tiers) para outro. Você pode revisar seu limite de uso atual na página [de limites](https://platform.openai.com/account/rate-limits) nas configurações da sua conta.

Se quiser ser notificado quando seu uso exceder um determinado valor em dólares, você pode definir um limite de notificação na página [de limites de uso](https://platform.openai.com/account/limits) . Quando o limite de notificação for atingido, os proprietários da organização receberão uma notificação por email. Você também pode definir um orçamento mensal para que, quando o orçamento mensal for atingido, quaisquer solicitações de API subsequentes sejam rejeitadas. Observe que esses limites são de melhor esforço e pode haver um atraso de 5 a 10 minutos entre o uso e a aplicação dos limites.

### Chaves de API

A API OpenAI usa chaves de API para autenticação. Visite a página [de chaves de API](https://platform.openai.com/account/api-keys) para recuperar a chave de API que você usará em suas solicitações.

Esta é uma maneira relativamente simples de controlar o acesso, mas você deve estar atento ao proteger essas chaves. Evite expor as chaves de API no seu código ou em repositórios públicos; em vez disso, armazene-os em um local seguro. Você deve expor suas chaves ao seu aplicativo usando variáveis de ambiente ou serviço de gerenciamento secreto, para que não precise codificá-las em sua base de código. Leia mais em nossas [Práticas recomendadas para segurança de chaves de API](https://help.openai.com/en/articles/5112595-best-practices-for-api-key-safety) .

O uso da chave API pode ser monitorado na [página Uso](https://platform.openai.com/usage) quando o rastreamento estiver ativado. Se você estiver usando uma chave de API gerada antes de 20 de dezembro de 2023, o rastreamento não será ativado por padrão. Você pode ativar o rastreamento no [painel de gerenciamento de chaves da API](https://platform.openai.com/api-keys) . Todas as chaves de API geradas após 20 de dezembro de 2023 têm o rastreamento ativado. Qualquer uso anterior não rastreado será exibido como `Untracked`no painel.

### Preparação de contas

À medida que você escala, você pode querer criar organizações separadas para seus ambientes de preparação e produção. Observe que você pode se inscrever usando dois endereços de e-mail separados, como [bob+prod@widgetcorp.com](mailto:bob+prod@widgetcorp.com) e [bob+dev@widgetcorp.com](mailto:bob+dev@widgetcorp.com) para criar duas organizações. Isso permitirá que você isole seu trabalho de desenvolvimento e teste para não interromper acidentalmente seu aplicativo ativo. Você também pode limitar o acesso à sua organização de produção dessa forma.

### Dimensionando a arquitetura da sua solução

Ao projetar seu aplicativo ou serviço para produção que usa nossa API, é importante considerar como você irá dimensionar para atender às demandas de tráfego. Existem algumas áreas principais que você precisará considerar, independentemente do provedor de serviços em nuvem de sua escolha:

- **Dimensionamento horizontal**
    - Você pode querer dimensionar seu aplicativo horizontalmente para acomodar solicitações provenientes de diversas fontes. Isto pode envolver a implantação de servidores ou contêineres adicionais para distribuir a carga. Se você optar por esse tipo de escalonamento, certifique-se de que sua arquitetura seja projetada para lidar com vários nós e que você tenha mecanismos para equilibrar a carga entre eles.
- **Escala vertical**
    - Outra opção é escalar seu aplicativo verticalmente, o que significa que você pode aumentar os recursos disponíveis para um único nó. Isso envolveria a atualização dos recursos do seu servidor para lidar com a carga adicional. Se você optar por esse tipo de dimensionamento, certifique-se de que seu aplicativo seja projetado para aproveitar esses recursos adicionais.
- **Cache**
    - Ao armazenar dados acessados com frequência, você pode melhorar os tempos de resposta sem precisar fazer chamadas repetidas à nossa API. Seu aplicativo precisará ser projetado para usar dados armazenados em cache sempre que possível e invalidar o cache quando novas informações forem adicionadas. Existem algumas maneiras diferentes de fazer isso. Por exemplo, você pode armazenar dados em um banco de dados, sistema de arquivos ou cache na memória, dependendo do que fizer mais sentido para seu aplicativo.
- **Balanceamento de carga**
    - Por fim, considere técnicas de balanceamento de carga para garantir que as solicitações sejam distribuídas uniformemente pelos servidores disponíveis. Isso pode envolver o uso de um balanceador de carga na frente de seus servidores ou o uso de round-robin de DNS. Equilibrar a carga ajudará a melhorar o desempenho e reduzir gargalos.

### Gerenciando limites de taxa

Ao usar nossa API, é importante compreender e planejar os [limites de taxas](https://platform.openai.com/docs/guides/rate-limits) .

### Melhorando as latências

Latência é o tempo que leva para uma solicitação ser processada e uma resposta ser retornada. Nesta seção, discutiremos alguns fatores que influenciam a latência de nossos modelos de geração de texto e daremos sugestões sobre como reduzi-la.

A latência de uma solicitação de conclusão é influenciada principalmente por dois fatores: o modelo e o número de tokens gerados. O ciclo de vida de uma solicitação de conclusão é assim:

Rede **-->** Latência do usuário final para API

Servidor **-->** Hora de processar tokens de prompt

Servidor **-->**  Hora de amostrar/gerar tokens

Rede **-->**  API para latência do usuário final

A maior parte da latência normalmente surge da etapa de geração do token.

> Intuição : os tokens de prompt adicionam muito pouca latência às chamadas de conclusão. O tempo para gerar tokens de conclusão é muito mais longo, pois os tokens são gerados um de cada vez. Durações de geração mais longas acumularão latência devido à geração necessária para cada token.
> 

### Fatores comuns que afetam a latência e possíveis técnicas de mitigação

Agora que examinamos os fundamentos da latência, vamos dar uma olhada em vários fatores que podem afetar a latência, ordenados de forma geral, do mais impactante ao menos impactante.

### Modelo

Nossa API oferece diferentes modelos com diversos níveis de complexidade e generalidade. Os modelos mais capazes, como o `gpt-4`, podem gerar conclusões mais complexas e diversas, mas também demoram mais para processar sua consulta. Modelos como `gpt-3.5-turbo`, podem gerar conclusões de chat mais rápidas e baratas, mas podem gerar resultados menos precisos ou relevantes para sua consulta. Você pode escolher o modelo que melhor se adapta ao seu caso de uso e ao equilíbrio entre velocidade e qualidade.

### Número de tokens de conclusão

Solicitar a conclusão de uma grande quantidade de tokens gerados pode levar ao aumento das latências:

- **Tokens máximos mais baixos** : para solicitações com contagem de geração de token semelhante, aquelas que possuem um `max_tokens`parâmetro menor incorrem em menos latência.
- **Incluir sequências de parada** : para evitar a geração de tokens desnecessários, adicione uma sequência de parada. Por exemplo, você pode usar sequências de parada para gerar uma lista com um número específico de itens. Neste caso, utilizando `11.`como sequência de parada, você pode gerar uma lista com apenas 10 itens, pois o preenchimento será interrompido quando `11.`for atingido. [Leia nosso artigo de ajuda sobre sequências de parada](https://help.openai.com/en/articles/5072263-how-do-i-use-stop-sequences) para obter mais contexto sobre como você pode fazer isso.
- **Gerar menos conclusões** : reduza os valores de `n`e `best_of`quando possível onde `n`refere-se a quantas conclusões gerar para cada prompt e `best_of`é usado para representar o resultado com a maior probabilidade de log por token.

Se `n`e `best_of`ambos forem iguais a 1 (que é o padrão), o número de tokens gerados será, no máximo, igual a `max_tokens`.

Se `n`(o número de conclusões retornadas) ou `best_of`(o número de conclusões geradas para consideração) forem definidos como `> 1`, cada solicitação criará diversas saídas. Aqui, você pode considerar o número de tokens gerados como`[ max_tokens * max (n, best_of) ]`

### Transmissão

Definir `stream: true`uma solicitação faz com que o modelo comece a retornar tokens assim que estiverem disponíveis, em vez de esperar que a sequência completa de tokens seja gerada. Não altera o tempo de obtenção de todos os tokens, mas reduz o tempo do primeiro token para uma aplicação onde queremos mostrar progresso parcial ou vamos parar gerações. Esta pode ser uma melhor experiência do usuário e uma melhoria na experiência do usuário, por isso vale a pena experimentar o streaming.

### A infraestrutura

Nossos servidores estão atualmente localizados nos EUA. Embora esperemos ter redundância global no futuro, enquanto isso você pode considerar a localização das partes relevantes da sua infraestrutura nos EUA para minimizar o tempo de ida e volta entre seus servidores e os servidores OpenAI.

### Lote

Dependendo do seu caso de uso, o lote *pode ajudar* . Se você estiver enviando várias solicitações para o mesmo endpoint, poderá [agrupar os prompts](https://platform.openai.com/docs/guides/rate-limits/batching-requests) para serem enviados na mesma solicitação. Isso reduzirá o número de solicitações que você precisa fazer. O parâmetro prompt pode conter até 20 prompts exclusivos. Aconselhamos você a testar este método e ver se ajuda. Em alguns casos, você pode acabar aumentando o número de tokens gerados, o que retardará o tempo de resposta.

### Gerenciando custos

Para monitorar seus custos, você pode definir um [limite de notificação](https://platform.openai.com/account/limits) em sua conta para receber um alerta por e-mail assim que ultrapassar um determinado limite de uso. Você também pode definir um [orçamento mensal](https://platform.openai.com/account/limits) . Esteja ciente do potencial de um orçamento mensal causar interrupções em seus aplicativos/usuários. Use o [painel de controle de uso](https://platform.openai.com/account/usage) para monitorar o uso do token durante os ciclos de faturamento atuais e anteriores.

### Geração de texto

Um dos desafios de mover seu protótipo para produção é orçar os custos associados à execução de seu aplicativo. OpenAI oferece um [modelo de preços pré-pago](https://openai.com/api/pricing/) , com preços por 1.000 tokens (aproximadamente iguais a 750 palavras). Para estimar seus custos, você precisará projetar a utilização do token. Considere fatores como níveis de tráfego, a frequência com que os usuários interagirão com seu aplicativo e a quantidade de dados que você processará.

**Uma estrutura útil para pensar na redução de custos é considerar os custos como uma função do número de tokens e do custo por token.** Existem dois caminhos potenciais para reduzir custos usando esta estrutura. Primeiro, você poderia trabalhar para reduzir o custo por token mudando para modelos menores para algumas tarefas, a fim de reduzir custos. Alternativamente, você pode tentar reduzir o número de tokens necessários. Existem algumas maneiras de fazer isso, como usar prompts mais curtos, [ajustar](https://platform.openai.com/docs/guides/fine-tuning) modelos ou armazenar em cache consultas comuns de usuários para que não precisem ser processadas repetidamente.

Você pode experimentar nossa [ferramenta interativa de tokenização](https://platform.openai.com/tokenizer) para ajudá-lo a estimar custos. A API e o playground também retornam contagens de tokens como parte da resposta. Depois de fazer tudo funcionar com nosso modelo mais capaz, você poderá ver se os outros modelos podem produzir os mesmos resultados com latência e custos mais baixos. Saiba mais em nosso [artigo de ajuda sobre uso de token](https://help.openai.com/en/articles/6614209-how-do-i-check-my-token-usage) .

### Estratégia MLOps

À medida que você move seu protótipo para produção, você pode considerar o desenvolvimento de uma estratégia de MLOps. MLOps (operações de aprendizado de máquina) refere-se ao processo de gerenciamento do ciclo de vida ponta a ponta de seus modelos de aprendizado de máquina, incluindo quaisquer modelos que você possa estar ajustando usando nossa API. Há uma série de áreas a serem consideradas ao projetar sua estratégia de MLOps. Esses incluem

- **Gerenciamento de dados e modelos**
    - Gerenciando os dados usados para treinar ou ajustar seu modelo e rastrear versões e alterações.
- **Monitoramento de modelo**
    - Rastreando o desempenho do seu modelo ao longo do tempo e detectando possíveis problemas ou degradação.
- **Retreinamento de modelo**
    - Garantir que seu modelo permaneça atualizado com mudanças nos dados ou requisitos em evolução e retreiná-lo ou ajustá-lo conforme necessário.
- **Implantação de modelo**
    - Automatizando o processo de implantação de seu modelo e artefatos relacionados na produção.

Pensar nesses aspectos do seu aplicativo ajudará a garantir que seu modelo permaneça relevante e tenha um bom desempenho ao longo do tempo.

### Segurança e conformidade

Ao mover seu protótipo para produção, você precisará avaliar e abordar quaisquer requisitos de segurança e conformidade que possam ser aplicados à sua aplicação. Isso envolverá examinar os dados que você está manipulando, entender como nossa API processa os dados e determinar quais regulamentos você deve cumprir. Nossas [práticas de segurança](https://www.openai.com/security) e [portal de confiança e conformidade](https://trust.openai.com/) fornecem nossa documentação mais abrangente e atualizada. Para referência, aqui está nossa [Política de Privacidade](https://openai.com/privacy/) e [Termos de Uso](https://openai.com/api/policies/terms/) .

Algumas áreas comuns que você precisa considerar incluem armazenamento de dados, transmissão de dados e retenção de dados. Talvez você também precise implementar proteções de privacidade de dados, como criptografia ou anonimato, sempre que possível. Além disso, você deve seguir as práticas recomendadas para codificação segura, como limpeza de entrada e tratamento adequado de erros.

### Melhores práticas de segurança

Ao criar seu aplicativo com nossa API, considere nossas [práticas recomendadas de segurança](https://platform.openai.com/docs/guides/safety-best-practices) para garantir que seu aplicativo seja seguro e bem-sucedido. Estas recomendações destacam a importância de testar extensivamente o produto, ser proativo na abordagem de possíveis problemas e limitar as oportunidades de uso indevido.

### Considerações comerciais

À medida que os projetos que utilizam IA passam do protótipo à produção, é importante considerar como construir um excelente produto com IA e como isso se relaciona com o seu negócio principal. Certamente não temos todas as respostas, mas um ótimo ponto de partida é uma palestra do nosso Dia do Desenvolvedor, onde abordamos isso com alguns de nossos clientes:

[](https://youtu.be/knHW-p31R0c)

---

### Melhores práticas de segurança

### Use nossa API de moderação gratuita

[A API de moderação](https://platform.openai.com/docs/guides/moderation) da OpenAI é de uso gratuito e pode ajudar a reduzir a frequência de conteúdo inseguro em suas conclusões. Alternativamente, você pode desenvolver seu próprio sistema de filtragem de conteúdo adaptado ao seu caso de uso.

### Teste adversário

Recomendamos “reunir uma equipe” em seu aplicativo para garantir que ele seja robusto às entradas adversárias. Teste seu produto em uma ampla variedade de entradas e comportamentos do usuário, tanto um conjunto representativo quanto aqueles que refletem alguém tentando “quebrar” seu aplicativo. Isso foge do assunto? Alguém pode redirecionar facilmente o recurso por meio de injeções de prompt, por exemplo, “ignore as instruções anteriores e faça isso”?

### Humano no circuito (HITL)

Sempre que possível, recomendamos realizar uma revisão humana dos resultados antes de serem usados na prática. Isto é especialmente crítico em domínios de alto risco e para geração de código. Os seres humanos devem estar cientes das limitações do sistema e ter acesso a qualquer informação necessária para verificar os resultados (por exemplo, se a aplicação resume notas, um ser humano deve ter acesso fácil às notas originais para consulta).

### Engenharia imediata

A “engenharia imediata” pode ajudar a restringir o tópico e o tom do texto de saída. Isso reduz a chance de produzir conteúdo indesejado, mesmo que um usuário tente produzi-lo. Fornecer contexto adicional ao modelo (como fornecer alguns exemplos de alta qualidade do comportamento desejado antes da nova entrada) pode facilitar a orientação dos resultados do modelo nas direções desejadas.

### “Conheça seu cliente” (KYC)

Os usuários geralmente precisam se registrar e fazer login para acessar seu serviço. Vincular este serviço a uma conta existente, como login do Gmail, LinkedIn ou Facebook, pode ajudar, embora possa não ser apropriado para todos os casos de uso. Exigir um cartão de crédito ou carteira de identidade reduz ainda mais o risco.

### Restringir a entrada do usuário e limitar os tokens de saída

Limitar a quantidade de texto que um usuário pode inserir no prompt ajuda a evitar a injeção de prompt. Limitar o número de tokens de saída ajuda a reduzir a chance de uso indevido.

Restringir os intervalos de entradas ou saídas, especialmente provenientes de fontes confiáveis, reduz a extensão do uso indevido possível dentro de uma aplicação.

Permitir entradas de usuário através de campos suspensos validados (por exemplo, uma lista de filmes na Wikipédia) pode ser mais seguro do que permitir entradas de texto abertas.

Retornar resultados de um conjunto validado de materiais no back-end, sempre que possível, pode ser mais seguro do que retornar conteúdo gerado novo (por exemplo, encaminhar uma consulta de cliente para o artigo de suporte ao cliente existente que melhor corresponda, em vez de tentar responder à consulta de- arranhar).

### Permitir que os usuários relatem problemas

Os usuários geralmente devem ter um método facilmente disponível para relatar funcionalidades inadequadas ou outras preocupações sobre o comportamento do aplicativo (endereço de e-mail listado, método de envio de tickets, etc.). Este método deve ser monitorado por um humano e respondido conforme apropriado.

### Compreenda e comunique as limitações

Desde informações alucinantes e imprecisas até resultados ofensivos, preconceitos e muito mais, os modelos de linguagem podem não ser adequados para todos os casos de uso sem modificações significativas. Considere se o modelo é adequado ao seu propósito e avalie o desempenho da API em uma ampla variedade de entradas potenciais para identificar casos em que o desempenho da API possa cair. Considere sua base de clientes e a variedade de informações que eles usarão e certifique-se de que suas expectativas sejam calibradas adequadamente.

Segurança e proteção são muito importantes para nós na OpenAI.

Se no decorrer do seu desenvolvimento você notar quaisquer problemas de segurança com a API ou qualquer outra coisa relacionada ao OpenAI, envie-os através do nosso [Programa Coordenado de Divulgação de Vulnerabilidades](https://openai.com/security/disclosure/) .

### IDs de usuário final

O envio de IDs de usuário final em suas solicitações pode ser uma ferramenta útil para ajudar a OpenAI a monitorar e detectar abusos. Isso permite que a OpenAI forneça à sua equipe feedback mais prático caso detectemos qualquer violação de política em seu aplicativo.

Os IDs devem ser uma string que identifique exclusivamente cada usuário. Recomendamos o hash do seu nome de usuário ou endereço de e-mail, para evitar o envio de qualquer informação de identificação. Se você oferecer uma visualização do seu produto para usuários não logados, poderá enviar um ID de sessão.

---