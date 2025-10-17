### ETL
#### O que é ETL?

**ETL** é uma sigla em inglês que significa "Extract, Transform, Load" (Extrair, Transformar, Carregar).

![[The ETL Processs Explained.png]]

A importância do processo de ETL (Extract, Transform, Load) na criação de modelos como GPTs (Generative Pre-trained Transformers) ou no treinamento de chatbots é significativa, principalmente no que diz respeito à preparação e gestão de dados.

Vamos explorar como cada etapa do ETL contribui para este processo:

1. **Extrair (Extract):**
    - Coleta de Dados Diversificados: 
	    - Para treinar modelos como o GPT ou chatbots, é crucial coletar uma grande quantidade de dados textuais de diversas fontes. Estes dados podem incluir livros, artigos, websites, transcrições de conversas, entre outros.
    - Variedade de Dados: 
	    - A variedade é fundamental para garantir que o modelo seja capaz de entender e gerar uma ampla gama de linguagem e contextos.
2. **Transformar (Transform):**
    - Limpeza e Normalização: 
	    - Dados brutos frequentemente contêm erros, inconsistências ou informações irrelevantes. A transformação inclui limpeza (removendo ou corrigindo dados errados), normalização (padronizando formatos), e outras transformações para garantir que os dados estejam prontos para treinamento.
    - Redução de Viés: 
	    - Durante a transformação, é importante identificar e mitigar vieses nos dados. Isso é crucial para desenvolver modelos de IA justos e éticos.
    - Preparação para o Treinamento: 
	    - A transformação também envolve a conversão dos dados em um formato adequado para treinamento, como tokenização e encoding, que são essenciais para modelos baseados em linguagem natural.
3. **Carregar (Load):**
    - Armazenamento para Treinamento: 
	    - Os dados transformados são carregados em um ambiente onde o treinamento do modelo pode ocorrer. Isso pode ser em servidores locais ou na nuvem, dependendo do tamanho e da complexidade do modelo.
    - Disponibilidade para Iterações: 
	    - Durante o treinamento, pode ser necessário ajustar e refinar o processo de ETL, exigindo um carregamento eficiente dos dados para múltiplas iterações de treinamento.

---
#### Sobre Pré-Processamento

Pré-processamento pode envolver:

1. Transformar o tipo de arquivo
2. Remover excessos ou informações desnecessárias
3. Adicionar estrutura ou metadados para melhorar o entendimento da IA

#### Tipos de Arquivos

Modelos de linguagem avançados, como o ChatGPT, entendem a maioria dos documentos com base em seu texto. De fato, para qualquer entrada que não seja imagens, o modelo de linguagem converterá para texto para tentar entender.

Para melhorar o desempenho do seu modelo, a primeira coisa que você pode fazer é converter documentos como .DOCX e .PDFs para formatos de texto mais simples.

Isso geralmente é um arquivo .TXT comum ou .MD como é no Obsidian.

Arquivos de texto legíveis por humanos, como JSON e CSV, também são facilmente entendidos pelo texto que contêm.

Então, a regra de ouro é — forneça ao seu GPT formatos comuns, fáceis de ler, mesmo que tecnicamente ele possa lidar com formatos mais difíceis.

#### Removendo Excessos

Simplesmente ser convertido em texto pode ajudar com os tempos de carregamento do arquivo, mas muitas vezes você quer ir além.

Considere um arquivo HTML, por exemplo.

O HTML que executa a página onde estou escrevendo esta lição de curso tem algumas informações úteis. Mas também está repleto de outras coisas:

![[Pasted image 20240315170757.png]]

Nenhuma das informações acima está realmente ajudando o modelo de linguagem a entender o conteúdo aqui.

Então, embora tecnicamente legível por humanos, também tende a conter muitas informações inúteis que um LLM precisa filtrar.

Se eu estivesse fazendo upload desta página para um GPT ajudá-lo a entender o material do curso, uma versão muito superior seria um documento de texto simples com formatação markdown.

Algo assim:

![[Pasted image 20240317145157.png]]

#### Adicionando Estrutura e Metadados

O modelo de linguagem pode usar cabeçalhos, listas, palavras em negrito e outros elementos estruturais para ajudar a entender como o seu documento se encaixa.

Por exemplo, se cada capítulo for rotulado com um número, por exemplo:

> Capítulo 5: Como Construir uma Canoa5.1 Ferramentas necessárias5.2 Escolhendo o tipo certo de madeira5.3 Preparando seu espaço de trabalho

Da mesma forma, modelos de linguagem tendem a ser bastante bons em entender um documento a partir de sua hierarquia. Estruturar adequadamente os cabeçalhos de nível apropriado (H1, H2, H3, etc) ajuda muito.

Modelos de linguagem adoram formatação consistente.

Eles também apreciam:

- listas de itens
    
- listas numeradas quando a ordem é importante
    
- uso de **negrito** e _itálico_ para destacar palavras-chave e conceitos

#### Entendendo Imagens

Por enquanto, até modelos de linguagem avançados com visão, como o GPT-4V, não conseguem interpretar imagens em documentos carregados. (Se disserem o contrário, provavelmente estão alucinando.)

Bem, vamos dar um passo atrás para esclarecer.

Quando você faz upload de uma única imagem, o GPT pode "ver" a imagem. Então, se você está criando um GPT para criar imagens em um certo estilo, por exemplo, você pode fazer upload de uma imagem guia de estilo e escrever algo em seu prompt como: "Referencie a style.jpg em seu conhecimento. Se o usuário fizer upload de uma imagem, transforme o assunto em uma nova imagem com um estilo similar ao de style.jpg."

Isso funciona.

Mas vamos pegar um segundo exemplo: um PDF.

Imagine que seu PDF inclui imagens como gráficos, capturas de tela e imagens decorativas. O GPT não vê essas imagens da mesma maneira que a imagem acima.

Depois de converter seu PDF para texto, tudo o que o GPT pode ver são legendas de imagens, bem como talvez o nome do arquivo da imagem removida.

Então, se houver dados em um gráfico que você quer que o GPT possa usar, você precisa fazer upload separadamente como uma imagem ou, e isso é muito melhor — incluir os dados brutos do gráfico como dados de texto, como uma tabela ou planilha.

#### Você precisa processar seus dados?

Agora que você entende o que você _pode_ fazer para tornar seu conhecimento mais fácil para a IA trabalhar, quero encorajar você a prestar atenção _quando_ usar todas essas táticas.

Se você está apenas experimentando, talvez não faça nada de especial com seus dados até que algo dê errado.

Razões para processar seus dados:

- Você planeja compartilhar o GPT publicamente e quer que todos tenham uma boa experiência
    
- Você espera que seu GPT economize significativamente mais tempo se funcionar bem, portanto investir tempo no processamento de dados é útil

#### Pontos-chave

- Se o seu GPT não está lidando muito bem com o conhecimento, considere usar um formato mais fácil com melhores tags internas como:


```
<question>O que aprendizado de máquina?</question><answer>Aprendizado de máquina um subcampo da IA que permite que sistemas aprendam e melhorem a partir de experiências.</answer><course>Introdução ao Aprendizado de máquina</course><class>Conceitos Básicos de Aprendizado de máquina</class><link>https://exemplo.com/cursos/aprendizado-de-maquina/conceitos-basicos</link><ref>Smith, J. (2021). Aprendizado de Mquina para Iniciantes.</ref><keywords>IA, aprendizado de mquina, conceitos bsicos, curso, Smith</keywords>
```

- Reformatar documentos importantes para texto limpo e estruturado para desempenho melhor, GPTs lêem mais rápido .TXT ou .MD do que PDF por exemplo.

- Assuma que GPTs não podem ver imagens a menos que sejam carregadas separadamente

---
### Knowledge
#### 1. Diga ao GPT o que ele tem

Os GPTs possuem um conjunto de instruções sobre suas capacidades com navegação na web, criação de imagens com DALL·E e interpretador de python/código. Sempre que esses plugins estiverem habilitados, essas instruções são carregadas no topo do seu prompt. Considere levar essa prática para os seus arquivos de conhecimento também.

Por exemplo:

```
## Data

You are programmed to perform an embedding search to sift through comprehensive knowledge base documents and retrieve the most relevant information. You may assume any information you retrieve is 100% true. For all other knowledge, rely only on facts you have a greater than 95% confidence level in. If you're unsure, say so. If you don't know something, let the user know "I don't know" rather than making something up. Your responses should be concise, accurate, and tailored to the user's question.
```

Ou em português:

```
## Dados

Você está programado para realizar uma busca por embeddings para filtrar documentos abrangentes da base de conhecimento e recuperar as informações mais relevantes. Você pode assumir que qualquer informação que recuperar é 100% verdadeira. Para todo o outro conhecimento, confie apenas em fatos nos quais você tem um nível de confiança superior a 95%. Se não tiver certeza, diga isso. Se você não souber algo, informe ao usuário "Eu não sei" em vez de inventar algo. Suas respostas devem ser concisas, precisas e adaptadas à pergunta do usuário.
```

#### 2. Diga ao GPT para usar o conhecimento

Parece óbvio, mas não é necessariamente óbvio para o GPT.

Só porque você carregou um arquivo no conhecimento, não significa que ele saiba como usar esse arquivo.

E enquanto o GPT pode automaticamente puxar partes desse arquivo enquanto responde ao usuário, sem instruções específicas, esses dados estão apenas flutuando acima, esperando ser úteis.

Até mesmo 1-2 frases aqui podem permitir que o comportamento do GPT mude e seja mais consistente:

```
## Knowledge

In your knowledge you have a text file that contains numerous articles on topics the user may want to explore. Refer to these articles to improve your answers.
```

```
## Conhecimento

No seu conhecimento, você tem um arquivo de texto que contém vários artigos sobre tópicos que o usuário pode querer explorar. Refira-se a esses artigos para aprimorar suas respostas.
```

#### 3. Assuma que o GPT pode recuperar apenas pedaços ou resumos do seu conteúdo

Baseado em minha pesquisa e experimentos, parece que os GPTs têm múltiplos métodos para recuperar documentos. O sistema em si decide qual método usar com base em algumas características do documento, bem como características da entrada do usuário.

Não podemos ver dentro do sistema para entender como isso funciona exatamente, mas é útil saber.

Arquivos de conhecimento menores parecem ter uma chance maior de serem totalmente recuperados.

Arquivos que contêm grandes listas também parecem ser totalmente recuperados com mais frequência.

Arquivos grandes, não surpreendentemente, têm mais probabilidade de ter apenas partes relevantes trazidas de volta, o que geralmente é a decisão certa de qualquer forma.

Um dos aprendizados aqui é que você pode ser capaz de influenciar esse comportamento a partir das instruções do GPT. Então, se o seu GPT não estiver se comportando conforme planejado, você pode tentar algo assim:

```
## Knowledge

Any time the user's inquiry requires you to review files in your knowledge, always pull in the entire file and review it top to bottom.
```

```
## Conhecimento

Sempre que a consulta do usuário exigir que você revise arquivos em seu conhecimento, sempre puxe o arquivo inteiro e revise-o de cima a baixo.
```

Não posso garantir que isso funcionará todas as vezes, mas é uma área que vale a pena explorar, especialmente para GPTs que usam múltiplos arquivos grandes.

#### 4. O GPT pode salvar novos arquivos

Nós falamos um pouco mais sobre isso em outra lição, mas vamos discutir aqui também.

Se você pedir, um GPT salvará um arquivo para você em um lugar onde possa acessá-lo.

**Dizer ao GPT para salvar um arquivo serve a dois propósitos principais:**

1. Para que você possa baixar o arquivo
2. Para que ele possa escrever no arquivo e ler seu conteúdo mais tarde

Você pode usar o segundo propósito como um truque para fazer o GPT salvar e referenciar certas informações quase como um banco de dados. Este método ainda não foi muito explorado, então eu não tenho um ótimo exemplo, mas já vi pessoas fazendo isso.

Note que arquivos criados e salvos durante sua sessão estão atrelados a essa sessão. Se você limpar o chat com o GPT e começar novamente, sua nova conversa não terá esses outros downloads.

#### Você Deve Colocar Dados no Conhecimento ou no Prompt?

Antes de se empolgar demais com o upload de arquivos de conhecimento, quero fazer uma pergunta para você:

Quanta informação realmente existe lá?

Pergunto porque suas instruções podem lidar com milhares de palavras, para ser mais exato 8.000 caracteres.

Então, digamos que você queira criar um GPT que usa uma quantidade exagerada de gírias da Geração Z. (De fato, existe um.) Você pode querer incluir um dicionário dos 25 principais termos de gíria para usar.

Você poderia fazer upload disso como um arquivo, ou você poderia simplesmente colar todos os 25 termos de gíria no prompt em sua própria seção. Isso realmente não é muita informação, e parece ineficiente para mim forçar o GPT a recuperá-la de uma fonte externa, especialmente se ele usará essa informação a cada turno da conversa.

Mesmo que você tenha listas de centenas de parâmetros ou FAQs de várias páginas, eu encorajo você a tentar ambos os métodos. Colar os dados diretamente nas instruções do GPT pode produzir resultados consistentemente bons porque ele terá essa informação em todas as conversas. Vale a pena tentar.

#### Perguntas frequentes sobre upload de arquivos

A OpenAI adicionou um novo recurso para fazer upload e trabalhar com diferentes tipos de documentos dentro do ChatGPT. Esse recurso se baseia em nosso modelo existente de Análise Avançada de Dados (anteriormente conhecido como Code Interpreter) para melhorar o desempenho em documentos ricos em texto, incluindo PDFs, documentos do Microsoft Word e apresentações.

#### Como funciona o novo recurso de upload de arquivos?

O recurso de upload de arquivos foi criado para suportar as seguintes tarefas:

1. **Síntese:** Combinar ou analisar informações de arquivos e documentos para criar algo novo, por exemplo:
    1. Faça upload de uma planilha, por exemplo um CSV, com uma mistura de informações qualitativas e quantitativas, e peça ao ChatGPT para ajudá-lo a entender e visualizar os dados.
    2. Compare e contraste dois documentos.
    3. Analise o sentimento ou o tom de um documento.
    4. Analise uma planilha.
    5. Aplique uma estrutura ou rubrica de um documento ao conteúdo de outro.

2. **Transformação:** Remodelar informações de documentos sem alterar sua essência, por exemplo:
    1. Faça upload de um trabalho de pesquisa complicado e peça ao ChatGPT para fornecer um resumo simples.
    2. Faça upload de uma apresentação em PowerPoint e peça feedback ao ChatGPT sobre o conteúdo.
    3. Resuma um documento em termos simples.
    4. Reescreva um documento curto em um estilo específico.
    5. Transforme uma apresentação em um documento.

3. **Extração:** Extrair informações específicas de um documento, por exemplo:
    1. Faça upload de um PDF e faça com que o ChatGPT encontre referências a um determinado tópico.
    2. Retire citações relevantes de um documento.
    3. Pesquise qualquer menção a um tópico específico em um documento ou planilha.
    4. Extraia metadados (autor, data de criação, etc.) de um documento.
    5. Conte o número de linhas em uma planilha que contém um determinado atributo
    6. Extraia seções específicas de um documento (por exemplo, todos os títulos ou todas as listas com marcadores).

#### Quantos arquivos posso enviar de uma vez por GPT?

Até **20** arquivos por GPT durante a vida útil dessa GPT. Lembre-se de que há restrições de tamanho de arquivo e limites de uso por usuário/organização.

#### Quais são essas restrições de tamanho de upload de arquivo?

- Todos os arquivos enviados para uma conversa GPT ou ChatGPT têm um limite rígido de 512 MB por arquivo.
- Todos os arquivos de texto e documentos carregados em um GPT ou em uma conversa ChatGPT são limitados a 2 milhões de tokens por arquivo. Esta limitação não se aplica a planilhas.
- Para imagens, há um limite de [20 MB](http://imagem.al/) por imagem.
- Além disso, existem limites de uso:
    - Cada usuário final tem um limite de 10 GB.
    - Cada organização tem um limite de 100 GB.
    - Observação: um erro será exibido se um limite de usuário/organização for atingido.

#### Como excluo os arquivos que carrego?

Os arquivos carregados na Análise Avançada de Dados são excluídos em até 3 horas. Se você estiver atingindo o limite de uso de arquivos, também poderá excluir arquivos de bate-papos recentes ou de qualquer GPT que você criou, já que esses limites de compartilhamento.

#### Como os arquivos e os bate-papos são retidos?

- Bate-papos
	1. Controles de dados fornecidos indefinidamente salvos -> Histórico de bate-papo = ATIVADO
	2. Se um bate-papo for excluído do ChatGPT, ele desaparecerá da IU. Para monitorar abusos, reteremos todas as conversas por 30 dias antes de excluí-las permanentemente.

- Arquivos
	1. Arquivos processados ​​via ADA/Análise de Documentos e ao conversar com um GPT personalizado (não carregados como conhecimento na configuração do GPT): Retidos por **3 horas** .
	2. Imagens processadas via Vision e arquivos enviados como conhecimento para GPT personalizado: retidos **indefinidamente** .

#### Conclusão

Fazer o upload de conhecimento em um GPT pode ser uma maneira poderosa de adicionar informações específicas às suas sessões de chat.

Conhecimento pode ser qualquer coisa: uma imagem de referência para gerar outras imagens, uma lista de termos ou FAQs, artigos e trechos de livros, até informações do site da sua empresa ou materiais de marketing de produto.

Vale a pena tirar um segundo para pensar se você tem algum arquivo que possa ser útil para o GPT. Alguns dos melhores truques parecem acontecer quando você fornece esses conjuntos de informações específicas.

---
### Extração de Dados
#### Definindo as Informações para o seu ChatBot/GPT

O primeiro passo na criação de um chatbot eficaz é definir quais informações você deseja incluir. Você pode optar por conteúdo de:

- Sites (Baixar todos as páginas e tratar as informações)
    
- Canais do YouTube (cuidado ao pegar vídeos de entrevistas ou que o autor não fala sozinho, para não misturar as informações, procurar playlists no youtube, playlists específicas que o autor fala sozinho)
    
- Livros

---
#### Seleção de Dados: A Chave para um Chatbot Eficaz

A seleção cuidadosa de dados é crucial. Para o GPT da Chai, por exemplo, selecionei conteúdos específicos de seu site e vídeos do YouTube que eram mais relevantes, evitando entrevistas para manter a consistência da voz.

---
#### Técnicas de Extração de Dados
##### Utilizando Raspadores e Crawlers

Depois que decidimos quais informações extrair é agora hora de vermos como fazer isso!

Para extrair dados de sites, usamos raspadores ou crawlers. Contudo, escolher o crawler adequado é essencial, pois muitos podem trazer conteúdo irrelevante, como HTML desnecessário e rodapés. Testei vários, incluindo o Crawly, que oferece dados em JSON e CSV, mas frequentemente com muitas informações desnecessárias.

Existem vários testes para isso, um deles é o: [crawly.diffbot.com](http://crawly.diffbot.com/)

Ele fornece uma versão JSON e uma CSV, mas que geralmente é muita suja, cheia de html's e rodapés, o que gera muito mais trabalho.

---

##### Utilize meu próprio script 

Decidi desenvolver meu próprio script de crawler para evitar excesso de informações irrelevantes. Este script salva os dados em formato .md, facilitando o uso com ferramentas como o Obsidian. Estou aprimorando este script há meses e planejo disponibilizar uma funcionalidade para vocês usarem **em breve.**

---

##### Utilizando Ferramentas e Plugins

Existem diversas ferramentas e plugins para auxiliar na extração de dados. Por exemplo, para extrair transcrições de vídeos do YouTube, você pode usar plugins como o "YouTube Subtitle Download Helper" ou serviços pagos que oferecem funcionalidades de transcrição.

---

#### Importância da Extração Correta

A forma como você extrai os dados determinará o quanto de esforço será necessário para tratá-los posteriormente. Uma extração inadequada pode resultar em um chatbot de baixa qualidade. Portanto, escolha e extraia os dados cuidadosamente para garantir que você tenha material de qualidade para trabalhar.

---
### Tratamento / Transformação de Dados
#### Introdução ao Tratamento de Dados

Tratamento de dados envolve a estruturação e organização das informações extraídas. Esta etapa é crucial para assegurar a precisão e a relevância dos dados que serão carregados em sistemas como LLMs (Large Language Models). A meta é transformar dados brutos, muitas vezes desordenados e de múltiplas fontes, em um conjunto estruturado e coeso.

![[Pasted image 20240317153741.png]]

Organizar informações

![[Pasted image 20240317153749.png]]

#### Cuidado com os Chunks!

![[Pasted image 20240317153805.png]]

Imagina um armazém gigante cheio de caixas. Cada caixa representa um pedaço de um texto enorme. "Chunking" é o processo de organizar esse texto em várias caixas menores. Isso torna mais fácil para a LLM, uma ferramenta que ajuda a compreender e organizar textos, encontrar a informação certa rapidamente.

Agora, pense em como você organizaria essas caixas para tornar tudo mais eficiente:

1. **Tamanho Ideal:** Cada caixa deve ter um tamanho que não seja nem muito grande nem muito pequeno. Caixas grandes demais são difíceis de manusear, e pequenas demais podem perder informações importantes.
    
2. **Conteúdo Relacionado:** Agrupe coisas semelhantes na mesma caixa. Assim, quando a LLM procura um tema específico, sabe exatamente onde olhar.
    
3. **Etiquetas Claras:** Marque cada caixa com uma descrição do que tem dentro. Isso ajuda a LLM a identificar rapidamente o conteúdo de cada chunk.

Com essas estratégias, a LLM se torna como um gerente de armazém eficiente, sabendo exatamente onde cada coisa está guardada. Isso facilita e agiliza o trabalho de entender e usar grandes quantidades de texto.

O que acontece:

![[Pasted image 20240317153835.png]]

---
#### Estratégia de Sumarização:

Uma técnica eficaz de tratamento de dados é a sumarização, que pode ser realizada com a ajuda de IA. Por exemplo, um documento extenso pode ser convertido em um formato estruturado de perguntas e respostas. Este método facilita a compreensão e utilização dos dados por sistemas baseados em IA.

![[Pasted image 20240317154204.png]]

---
#### Exemplo de um Prompt Completo bem Formatado:

```
<question>O que aprendizado de mquina?</question><answer>Aprendizado de mquina um subcampo da IA que permite que sistemas aprendam e melhorem a partir de experincias.</answer><course>Introduo ao Aprendizado de Mquina</course><class>Conceitos Bsicos de Aprendizado de Mquina</class><link>https://exemplo.com/cursos/aprendizado-de-maquina/conceitos-basicos</link><ref>Smith, J. (2021). Aprendizado de Mquina para Iniciantes.</ref><keywords>IA, aprendizado de mquina, conceitos bsicos, curso, Smith</keywords>
```

---
#### Formato JSON:

Formato JSON: Utilizado para estruturar dados de forma que sejam facilmente interpretáveis por sistemas de IA. Exemplo: transformação de conceitos complexos em perguntas e respostas formatadas em JSON.

```
"question": "O que  fotossntese?","answer": "Fotossntese  o processo usado pelas plantas para converter luz solar, dixido de carbono e gua em oxignio e energia na forma de glicose.","course": "Introduo  Biologia","class": "Processos Celulares","link": "https://exemplo.com/cursos/biologia/processos-celulares","ref": "Doe, J. (2021). Biologia Bsica para Iniciantes.","keywords": "fotossntese, biologia, processos celulares, curso, Doe"
```

---
#### Formato Compacto (Meu Preferido)

Um formato simplificado que inclui elementos essenciais como perguntas, respostas, cursos, links e palavras-chave. Este formato é ideal para rápida interpretação e uso em aplicações práticas.

```
q: O que é gravidade?
a: Gravidade é uma força fundamental que atrai dois corpos com massa um em direção ao outro.
c: Introdução à Física
l: Fundamentos da Gravidade
url: https://exemplo.com/cursos/fisica/fundamentos-da-gravidade
ref: Newton, I. (1687). Philosophiæ Naturalis Principia Mathematica.
key: gravidade, física, Newton, força fundamental
```

---
#### Trabalhando com Prompts e Variáveis

Ao tratar os dados, é possível utilizar prompts específicos para extrair o conteúdo mais relevante e prático. Isso inclui manter a personalidade do autor, o estilo de escrita e a precisão das informações. Por exemplo, um prompt pode ser configurado para extrair perguntas e respostas de um texto, mantendo o tom e estilo do autor original.

```
Formato de Saída:
{a} \n \n 
Você pode aprender mais sobre isso na aula "{l}" no curso "{c}". \n
[Clique aqui para acessar a aula]({url}). \n
Referência: {ref}.
```

---
#### Para tratar dados dessa forma você pode usar prompts como o abaixo.

Prompt Q&A

```
//Prompt 2.0 Q&A
//Autores: Alan Nicolas e Bruno Picinini

Aja como um especialista em ensino interessado no conteúdo anexado criado por mim, o autor dos episódios. Sua super habilidade é extrair o melhor e mais prático conteúdo de todo material enviado a você para que esse conhecimento seja passado adiante da maneira mais clara e objetiva possível, mas mantendo a personalidade do autor.

O objetivo é criar um Q&A completo que (1) divide e transforma o conteúdo em perguntas e respostas para (2) depois usar como knowledge base para um chatbot que (3) responda exatamente como eu responderia.

Portanto, preciso que as respostas sejam extremamente similares ao que eu responderia, incluindo, mas não limitado a tom de voz, estilo de escrita, personalidade, e tudo que compreende o meu estilo de escrita que você encontrará e analisará dos meus conteúdos enviados para você.

Você vai formular o número de Q&A (perguntas e respostas) solicitadas que reflitam o conteúdo enviado seguindo as regras em `<regras></regras>`.

## Regras

<regras>

1. Crie perguntas unicamente se encontrar trechos no documento que podem ser usados para responder esta pergunta.

2. Gere sempre novas perguntas, revise as que foram criadas e crie perguntas diferentes.

3. As respostas devem ser escritas em primeira pessoa, como se fossem do próprio autor, e devem manter o estilo de escrita descrito abaixo em `<estilo></estilo>`. 

4. As respostas devem ser formatadas em markdown seguindo o padrão de perguntas e respostas conforme descrito em: `<saida></saida>`, elas devem ser preenchidas conforme o exemplo descrito em `<exemplo></exemplo>`.

5. Utilize o texto original sempre que possível. Tente variar o mínimo possível do conteúdo e estilo do autor. Crie e parafraseie somente para que a resposta faça mais sentido e flua melhor.

</regras>

## Estilo do Autor

Aqui a definição geral do estilo. Mas lembre-se: procure se basear o máximo possível no próprio material que estou enviando para você para entender qual é o estilo adequado para as respostas.

O objetivo principal é que se alguém ler uma resposta sua ou minha, ela não saberá identificar quem escreveu qual de tão semelhantes que são suas respostas ao que eu mesmo teria respondido.

<estilo>

1. **Tom e Estrutura:** Seu texto tem um tom reflexivo e introspectivo, com uma abordagem filosófica e prática. A estrutura segue um fluxo de pensamento, introduzindo conceitos, conectando-os com experiências pessoais e exemplos históricos, e finalizando com insights ou questionamentos.

2. **Temas e Conteúdo:** O conteúdo é rico em metáforas, referências filosóficas, citações de pensadores, e aplicações práticas. Inclua temas de autoconhecimento, desenvolvimento pessoal, e aprendizado através da modelagem.

3. **Estilo de Linguagem:** Use uma linguagem eloquente, mas acessível. Empregue frases bem construídas e vocabulário variado, incluindo termos técnicos quando apropriado (como "neurônios-espelho", "córtex pré-frontal").

4. **Elementos Pessoais:** Integre narrativas pessoais e experiências, demonstrando vulnerabilidade e aprendizados.

5. **Conexão com o Ouvinte/Leitor:** Fale diretamente ao leitor, com perguntas e convites à reflexão, criando uma conexão pessoal.

6. Frases simples e curtas;

7. Palavras simples, que qualquer um entende;

8. Tom escrito como se fosse para alguém da 5º série;

9. Muitos exemplos e analogias

</estilo>

## Formatação da Saída

<saida>

q: Pergunta 

\n

sq: 3 Perguntas Similares

\n

a: Resposta 

\n

t: Trecho(s) do documento usado para responder a pergunta.

\n

tags: tag1, tag2, tag3

\n

---

</saida>

### Perguntas (`q:`, `sq:`)

Faça com que as perguntas principais (`q:`) sejam aquelas com a maior chance possível de serem similares ao que um usuário que chega ao meu site perguntaria. Deixe para `sq:` aquelas menos comuns, com menos chances de aparecer. Por exemplo:

Exemplo Original:

q: Como podemos dizer que não há nada de novo debaixo do sol?

sq: Por que podemos afirmar que nada é 100% original? De que forma o progresso humano é uma recombinação do que já existe? Qual a relação entre originalidade e as limitações humanas?

Aqui era melhor que fosse assim:

Exemplo melhorado:


q: Por que você diz que nada é 100% original?

sq: O que você quer dizer com que não há nada de novo debaixo do sol? De que forma o progresso humano é uma recombinação do que já existe? A originalidade existe?

Repare como a pergunta sobre nada ser 100% original tem mais chances de uma pessoa real perguntar do que alguém aparecer no meu site e do nada perguntar se "não há nada de novo debaixo do sol". Assim como algumas das perguntas similares em `sq:`.

A formulação da pergunta também fica mais clara: é mais similar ao tipo de pergunta que alguém faria para mim, seja em meu site ou redes sociais. Elas se aproximam mais as perguntas que um usuário faria em um ambiente real.

### Resposta (`a:`)

A Resposta em `a:` precisa ser o mais similar possível a como eu escreveria a resposta. Portanto, procure variar o mínimo possível do texto encontrado no material que eu mandar para você. Procure usar as mesmas palavras, o mesmo estilo de linguagem, o mesmo tamanho de frases, etc. 

Alguém lendo sua resposta diria que era eu em pessoa escrevendo.

Procure formular respostas com o texto do material, só adaptando e parafraseando para que faça sentido… mas variando o mínimo possível.

## Exemplo

<exemplo>

q: De que maneira podemos enfrentar o medo de sair da nossa zona de conforto para explorar nossa zona de genialidade?

sq: Como superar o medo e a resistência para sair da zona de conforto? Quais estratégias você recomenda para enfrentar o medo na busca pela zona de genialidade? Como lidar com o desconforto de deixar a zona de conforto em direção à genialidade?

a: Enfrentar o medo é essencial. Reconhecer que o conforto é um obstáculo para o crescimento é o primeiro passo. Encare o desconhecido como uma oportunidade e comece com pequenos passos fora da sua zona de conforto. Lembre-se, o medo é uma reação natural, mas não deve ser um impedimento.

t: "E para você sair da zona de conforto e ir para a zona de genialidade você precisa enfrentar seus medos."

tags: genialidade, zona de conforto, desconforto, medo

---

</exemplo>

## Instruções Finais

1. Lembre-se de simular o meu tom de voz e a maneira como escrevo do jeito mais similar possível. Se 10 pessoas lessem suas respostas, então 10 pessoas deveriam acreditar que fui eu que escrevi.
2. Formate a saída conforme o formato que você encontra em `<saida></saida>` sem esquecer nenhum dos itens (q:, sq:, a:, t:, e:)
3. Lembre-se porque é muito muito muito importante: a Resposta em `a:` precisa ser o mais similar possível a como eu escreveria. A ponto de que se eu procurasse o texto que você escreveu, eu quase encontraria dito da mesma maneira no material.

Agora gere 15 perguntas e RESPOSTAS ÚNICAS seguindo estas instruções. Ou seja, não pode repetir nenhuma pergunta que você já tenha feito, seja deste ou de outro documento dentro dessa janela de contexto da nossa conversa.

Sempre escreva em português brasileiro, seguindo o `<estilo></estilo>` do autor
```

---
#### Conclusão

Ao final desta aula, fica evidente que o tratamento e a transformação de dados são passos fundamentais para a eficácia dos sistemas de IA. A técnica de 'chunking', juntamente com estratégias de sumarização e formatos eficientes como JSON e formatos compactos, são essenciais para tornar os dados mais acessíveis e utilizáveis.

A habilidade de organizar informações de maneira estratégica não apenas melhora a performance dos modelos de IA, mas também oferece uma forma mais intuitiva e direta para os usuários finais interagirem com estes sistemas. A partir da aplicação de prompts bem estruturados e a manutenção do estilo e tom do autor original, podemos transformar grandes volumes de dados em informações claras, precisas e úteis.

---
### Vocabulário

Os termos técnicos em ETL às vezes dão um nó na nossa cabeça, e também faz algo que não é tão complicado parecer MUITO mais complicado, por isso resolvi fazer uma lista aqui das palavras e siglas mais comuns em ETL e seus significados com explicações curtas e simplificadas, segue a lista abaixo:

**Big Data Analytics (Análise de Big Data)**: O processo de examinar grandes conjuntos de dados para descobrir padrões ocultos e outras informações úteis.

**Business Intelligence (Inteligência de Negócios)**: O uso de dados para ajudar empresas a tomar decisões inteligentes.

**Chunk (Pedaço)**: Como um parágrafo de um livro, é uma parte pequena de um documento maior que é tratada como uma unidade.

**Cloud Storage (Armazenamento na Nuvem)**: Guardar dados em servidores online ao invés de em seu próprio computador, como alugar um espaço em um depósito remoto em vez de guardar tudo em casa.

**Cosine Similarity (Similaridade de Cosseno)**: Uma maneira de medir o quão parecidos são dois documentos ou partes de documentos, usando matemática.

**Data Augmentation (Aumento de Dados)**: Criar dados artificiais adicionais com base nos existentes, como fazer várias cópias de uma foto, cada uma com um pequeno ajuste, para treinar melhor os modelos de IA.

**Data Cleaning (Limpeza de Dados)**: É como arrumar a casa antes de uma visita importante. Aqui, removemos ou corrigimos os dados que estão errados, incompletos ou irrelevantes.

**Data Governance (Governança de Dados)**: Conjunto de práticas e políticas para gerenciar adequadamente os dados, garantindo que sejam usados corretamente e de forma segura.

**Data Integration (Integração de Dados)**: Imagine pegar peças de diferentes quebra-cabeças e juntá-las para criar uma nova imagem. Isso envolve combinar dados de diferentes fontes para ter uma visão mais completa.

**Data Labeling (Rotulagem de Dados)**: O processo de identificar e marcar os dados com rótulos informativos, como colocar etiquetas em caixas para saber o que tem dentro. É crucial para o treinamento de modelos de IA.

**Data Lake**: Um grande depósito para guardar uma enorme quantidade de dados brutos, mantidos em seu formato original, para análise futura.

**Data Mining (Mineração de Dados)**: O processo de procurar padrões e informações úteis em grandes conjuntos de dados.

**Data Preprocessing (Pré-processamento de Dados)**: Preparar os dados para análise, como cortar e temperar os alimentos antes de cozinhar. Isso inclui normalização, transformação e redução de dimensionalidade.

**Data Quality (Qualidade de Dados)**: Avaliar se os dados são bons o suficiente para o uso. Como verificar se os ingredientes estão frescos antes de cozinhar.

**Data Security (Segurança de Dados)**: Proteger os dados contra acessos não autorizados ou alterações indesejadas, como ter um bom sistema de segurança em casa.

**Data Streaming (Transmissão de Dados)**: Processo de lidar com dados que são gerados continuamente, como acompanhar as notícias em tempo real.

**Data Warehousing (Armazenamento de Dados)**: Construir um grande depósito digital para armazenar e gerenciar dados, semelhante a um armazém que guarda diferentes tipos de mercadorias.

**Document Loader (Carregador de Documentos)**: A ferramenta que coloca os documentos no sistema e os prepara para serem encontrados e usados.

**Document Store (Armazenamento de Documento)**: Um sistema especializado para guardar e organizar esses documentos de forma que possam ser facilmente encontrados.

**Documento**: Qualquer tipo de informação, seja texto, imagem, som ou vídeo, que o sistema pode buscar e mostrar quando você pede.

**Embedding (Incorporação)**: Um método para transformar documentos ou suas partes em uma série de números, similar ao vetor, que destaca o que é importante neles.

**Feature Engineering (Engenharia de Características)**: O processo de criar 'características' ou atributos novos e úteis a partir dos dados brutos, que ajudam a melhorar o desempenho dos modelos de IA.

**Índice**: Como o índice de um livro, ajuda a encontrar rapidamente informações específicas dentro de uma grande quantidade de dados.

**Machine Learning Algorithms (Algoritmos de Aprendizado de Máquina)**: Conjunto de regras e

técnicas usadas pela IA para aprender com os dados e melhorar com o tempo, como aprender a tocar um instrumento com a prática.

**Model Training (Treinamento de Modelo)**: Ensinar a IA a reconhecer padrões e tomar decisões com base nos dados, semelhante a estudar para uma prova.

**Model Validation (Validação de Modelo)**: Testar o modelo de IA para garantir que ele está funcionando corretamente, como um ensaio geral antes de uma apresentação.

**Natural Language Processing (Processamento de Linguagem Natural)**: Uma área da IA que lida com a compreensão e manipulação da linguagem humana por computadores, como um tradutor que interpreta diferentes idiomas.

**Normalização de Dados (Data Normalization)**: O processo de arrumar os dados para reduzir repetições e erros.

**Pipeline de Dados**: Uma série de passos para mover e transformar os dados desde a coleta até a análise.

**Recuperação Full Stack**: Um sistema completo que cuida de todo o processo, desde receber os dados até entregar a informação que você procura.

**Relevância Marginal Máxima (MMR)**: Um método que ajuda a mostrar resultados de busca variados e relevantes, evitando repetições.

**Retriever (Recuperador)**: Uma ferramenta que procura e encontra os documentos mais relevantes com base na sua pergunta.

**Sentimento**: A análise do tom emocional por trás das palavras, para entender sentimentos e opiniões expressas no texto.

**Similaridade de Cosseno (Cosine Similarity)**: Uma maneira de medir o quão parecidos são dois documentos ou partes de documentos, usando matemática.

**Tamanho da Dimensão**: Refere-se à quantidade de características diferentes que podem ser usadas para descrever um documento ou sua parte.

**Vector Store (Armazenamento de Vetor)**: Um lugar especial onde esses 'resumos' numéricos dos documentos são guardados para facilitar a busca e comparação entre eles.

**Vetor**: Imagine um resumo de um documento ou parte dele, representado por uma série de números que destacam suas características principais.

---
