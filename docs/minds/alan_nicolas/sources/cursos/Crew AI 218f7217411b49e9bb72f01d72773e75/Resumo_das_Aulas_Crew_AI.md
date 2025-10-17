### Instalação do Python
#### Passo 1: Instalar o Python

Instalação Windows

1. **Visite o site oficial do Python:** Abra seu navegador e vá para [python.org](https://python.org/).
    
2. **Download:** Na página inicial, procure o botão "Download Python" e clique nele. Se estiver em um sistema Windows, o site geralmente sugere a melhor versão para você.
    
3. **Instalação:** Execute o instalador baixado. **Importante:** Certifique-se de marcar a caixa "Add Python to PATH" antes de clicar em "Install Now". Isso facilitará a execução do Python a partir do terminal ou prompt de comando.
    

Instalação Mac

#### Passo 1: Instalar o Homebrew

Se você ainda não tem o Homebrew instalado no seu macOS, abra o Terminal e execute o seguinte comando:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Este comando baixa e executa o script de instalação do Homebrew. O script explicará o que será feito e solicitará sua confirmação antes de prosseguir.

#### Passo 2: Verificar a Instalação do Homebrew

Após a instalação, você pode verificar se o Homebrew foi instalado corretamente executando:

```
brew --version
```

Se o Homebrew estiver instalado corretamente, este comando retornará a versão do Homebrew instalada.

#### Passo 3: Instalar o Python com Homebrew

Com o Homebrew instalado, você pode instalar facilmente o Python. Para fazer isso, execute o seguinte comando no Terminal:

```
brew install python
```

Este comando instalará a versão mais recente do Python. O Homebrew instala o Python 3, e python e pip serão vinculados aos comandos python3 e pip3, respectivamente, para garantir que não haja conflito com o Python 2.x pré-instalado no macOS.

#### Passo 4: Verificar a Instalação do Python

Após a instalação, verifique se o Python foi instalado corretamente e sua versão, usando:

```
python3 --version
```

#### Passo 2: Verificar Instalação do Python

- **Abra o Terminal ou Prompt de Comando** e digite python --version ou python3 --version. Se o Python estiver corretamente instalado, você verá a versão do Python exibida.
    

#### Passo 3: Instalar a Extensão Python no VSCode

1. **Abra o VSCode.**
    
2. **Acesso ao Marketplace:** Clique no ícone de extensões na barra lateral (ou pressione Ctrl+Shift+X).
    
3. **Procure por Python:** Na barra de pesquisa, digite "Python" e procure a extensão oficial da Microsoft.
    
4. **Instale a Extensão:** Clique no botão de instalação da extensão Python da Microsoft.

---
### Instalação VSCode

Para instalar o Visual Studio Code (VSCode), um editor de código fonte leve e poderoso suportado pela Microsoft para Windows, macOS e Linux, siga estes passos mágicos. O VSCode é popular entre os desenvolvedores por sua interface de usuário eficiente, suporte extensivo de extensões e integração com uma vasta gama de ferramentas e linguagens de programação, incluindo Python, JavaScript, C++, entre outros.

#### Passo 1: Baixar o VSCode

1. **Acesse o Site Oficial:** Navegue até o site oficial do Visual Studio Code usando o seu navegador. O endereço é [https://code.visualstudio.com/](https://code.visualstudio.com/).
    
2. **Escolha a Versão Correta:** O site detectará automaticamente o sistema operacional que você está usando, mas você pode também escolher manualmente a versão para Windows, macOS ou Linux, conforme necessário. Clique no botão de download correspondente ao seu sistema operacional.
    

#### Passo 2: Instalar o VSCode

Para Windows:

- **Execute o Instalador:** Localize o arquivo baixado (geralmente em sua pasta de Downloads) e dê um duplo clique para iniciar a instalação.
    
- **Aceite o Acordo de Licença:** Leia os termos e, se concordar, aceite para continuar.
    
- **Escolha as Opções de Instalação:** Você pode selecionar o local de instalação e outras opções, como adicionar o VSCode ao PATH (recomendado) e criar um ícone na área de trabalho.
    
- **Concluir a Instalação:** Siga as instruções na tela para completar a instalação. Ao final, você pode optar por lançar o VSCode imediatamente.
    

Para macOS:

- **Monte o Arquivo DMG:** Após o download, abra o arquivo .dmg baixado.
    
- **Arraste o VSCode para a Pasta de Aplicativos:** Isso instalará o Visual Studio Code em sua pasta de Aplicativos.
    
- **Abra o VSCode:** Você pode precisar clicar com o botão direito no ícone do VSCode e selecionar "Abrir" na primeira vez para contornar as restrições de segurança do macOS.
    

Para Linux:

- **Usando Pacotes DEB ou RPM:** Se você baixou um pacote .deb (para Debian/Ubuntu) ou .rpm (para Fedora/SUSE), você pode instalar o VSCode usando o seu gerenciador de pacotes preferido (por exemplo, dpkg, apt, ou yum). Para instalar com dpkg:
    
    ```
    sudo dpkg -i <nome_do_arquivo>.deb
    ```
    
    Para instalar com yum:
    
    ```
    sudo yum install <nome_do_arquivo>.rpm
    ```
    
- **Via Terminal:** Para muitas distribuições Linux, você pode também instalar o VSCode via terminal usando os comandos do gerenciador de pacotes. Consulte a documentação oficial do VSCode para instruções específicas da sua distribuição.
    

#### Passo 3: Executar o VSCode

Após a instalação, você pode iniciar o Visual Studio Code a partir do menu Iniciar no Windows, Launchpad no macOS, ou do seu launcher de aplicativos no Linux.

---
### Criando ambiente virtual (VENV)

Criar um ambiente virtual em Python com venv é uma prática recomendada para isolar as dependências de projetos diferentes. Isso evita conflitos entre versões de pacotes e permite que você mantenha seus projetos organizados. O processo de criação de um ambiente virtual é bastante semelhante em todos os sistemas operacionais. Aqui está um guia passo a passo universal:

#### Passo 1: Instalar o Python

Certifique-se de que o Python está instalado em sua máquina. A maioria das instalações do Python 3.3 e posteriores inclui a ferramenta venv por padrão. Você pode verificar a instalação e a versão do Python executando python --version ou python3 --version no terminal (Linux/macOS) ou no Prompt de Comando (Windows).

#### Passo 2: Abrir o Terminal ou Prompt de Comando

- **Windows:** Abra o Prompt de Comando ou o PowerShell.
    
- **macOS e Linux:** Abra o Terminal.

#### Passo 3: Navegar até o Diretório do Projeto

Use o comando cd para navegar até o diretório onde você deseja criar o ambiente virtual. Se o diretório ainda não existir, você pode criá-lo com mkdir nome_do_projeto e então navegar até ele com cd nome_do_projeto.

#### Passo 4: Criar o Ambiente Virtual

Execute o seguinte comando para criar um ambiente virtual dentro do diretório do projeto:

```sh
python -m venv nome_do_ambiente
```

ou

```sh
python3 -m venv nome_do_ambiente
```

Substitua nome_do_ambiente pelo nome que você deseja dar ao seu ambiente virtual. Isso criará um diretório nome_do_ambiente dentro do diretório do projeto, contendo o ambiente virtual.

#### Passo 5: Ativar o Ambiente Virtual

Para começar a usar o ambiente virtual, você precisa ativá-lo com um comando específico do seu sistema operacional.

- **Windows (Prompt de Comando):**
    
    ```cmd
    .\nome_do_ambiente\Scripts\activate
    ```
    
- **Windows (PowerShell):**
    
    ```powershell
    .\nome_do_ambiente\Scripts\Activate.ps1
    ```
    
    Nota: Você pode precisar alterar a política de execução para permitir a execução de scripts. Use Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser.
    
- **macOS e Linux:**
    
    ```bash
    source nome_do_ambiente/bin/activate
    ```
    

Após a ativação, o nome do ambiente virtual aparecerá no prompt do terminal, indicando que todas as operações do Python e do pip serão executadas no contexto do ambiente virtual.

#### Passo 6: Trabalhando no Ambiente Virtual

Com o ambiente virtual ativado, você pode instalar pacotes usando pip install nome_do_pacote sem afetar o sistema global ou outros ambientes virtuais.

#### Passo 7: Desativar o Ambiente Virtual

Quando terminar o trabalho no ambiente virtual, você pode desativá-lo executando:

```sh
deactivate
```

Isso retornará você ao ambiente global do sistema ou ao ambiente anterior.

E assim, você configurou um ambiente virtual Python com venv em sua máquina, pronto para desenvolver seus projetos de forma isolada e segura.

---
### Instalação do CrewAI
#### Passo 1: Preparação

Certifique-se de que o Python e o pip estão instalados em seu sistema. Você pode verificar suas instalações com os seguintes comandos no terminal (ou prompt de comando no Windows):

```bash
python --version
pip --version
```

Se o Python estiver instalado, mas o pip não estiver, você precisará instalar o pip primeiro.

#### Passo 2: Ativar o Ambiente Virtual (Opcional)

Se você estiver trabalhando dentro de um ambiente virtual (recomendado para evitar conflitos entre dependências de projetos diferentes), ative-o com o comando adequado para o seu sistema operacional, como descrito na sua pergunta anterior.

#### Passo 5: Ativar o Ambiente Virtual

Para começar a usar o ambiente virtual, você precisa ativá-lo com um comando específico do seu sistema operacional.

- **Windows (Prompt de Comando):**
    
    ```cmd
    .\nome_do_ambiente\Scripts\activate
    ```
    
- **Windows (PowerShell):**
    
    ```powershell
    .\nome_do_ambiente\Scripts\Activate.ps1
    ```
    
    Nota: Você pode precisar alterar a política de execução para permitir a execução de scripts. Use Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser.
    
- **macOS e Linux:**
    
    ```bash
    source nome_do_ambiente/bin/activate
    ```
    

Após a ativação, o nome do ambiente virtual aparecerá no prompt do terminal, indicando que todas as operações do Python e do pip serão executadas no contexto do ambiente virtual.

#### Passo 3: Instalar a Biblioteca

Com o pip, você pode instalar a biblioteca desejada executando:

```bash
pip install crewai
```

Se a biblioteca crewai estiver disponível em uma fonte específica ou requerer uma versão específica, o comando pode variar, por exemplo:

- Para instalar uma versão específica:
    
    ```bash
    pip install crewai==x.y.z
    ```
    
- Para instalar de um repositório GitHub:
    
    ```bash
    pip install git+https://github.com/usuario/crewai.git
    ```
    
    Substitua https://github.com/usuario/crewai.git pelo URL correto do repositório.
    

#### Passo 4: Verificar a Instalação

Após a instalação, você pode verificar se a biblioteca foi instalada corretamente executando:

```bash
pip list
```

Este comando lista todas as bibliotecas instaladas no ambiente atual, e você deve ver crewai listado entre elas.

Exemplo de estrutura do código CrewAI

Para criar um exemplo completo de código usando o CrewAI, vamos construir uma estrutura que envolve a definição de agentes, tarefas, uma tripulação (crew) e o processo de inicialização da tripulação para trabalhar em um projeto específico. Este exemplo irá ilustrar como definir cada componente com todas as propriedades relevantes e incluir comentários explicativos em cada linha para facilitar a compreensão.

```python
from crewai import Agent, Task, Crew, Process

# Define um agente com papel de "Analista de Dados"
# Este agente tem como objetivo analisar dados para gerar insights valiosos.
analista_de_dados = Agent(
  role='Analista de Dados',  # Define o papel do agente na tripulação.
  goal='Analisar dados para descobrir tendências importantes.',  # Descreve o objetivo do agente.
  backstory='Você é um analista de dados com anos de experiência em transformar dados brutos em insights valiosos.',  # Uma breve história de fundo para adicionar profundidade ao agente.
  verbose=True  # Habilita a saída detalhada do processo de trabalho do agente.
)

# Define um agente com o papel de "Especialista em Visualização de Dados"
# Este agente foca em criar visualizações de dados para facilitar a compreensão dos insights.
especialista_visualizacao = Agent(
  role='Especialista em Visualização de Dados',
  goal='Criar visualizações claras e impactantes dos dados analisados.',
  backstory='Com uma paixão por contar histórias através de dados, você transforma números complexos em gráficos compreensíveis.',
  verbose=True
)

# Cria uma tarefa para o analista de dados.
# Esta tarefa envolve a análise de um conjunto de dados específico para encontrar tendências.
tarefa_analise = Task(
  description='Analise o conjunto de dados XYZ para identificar as principais tendências.',  # Descrição do que precisa ser feito.
  agent=analista_de_dados,  # Atribui esta tarefa ao analista de dados.
)

# Cria uma tarefa para o especialista em visualização.
# Esta tarefa requer a criação de visualizações baseadas nas tendências identificadas.
tarefa_visualizacao = Task(
  description='Crie visualizações dos insights encontrados pelo analista de dados para melhor compreensão.',
  agent=especialista_visualizacao,
)

# Instancia a tripulação com um processo sequencial.
# Isso significa que as tarefas serão executadas uma após a outra.
crew = Crew(
  agents=[analista_de_dados, especialista_visualizacao],  # Lista dos agentes participantes.
  tasks=[tarefa_analise, tarefa_visualizacao],  # Lista das tarefas a serem realizadas.
  verbose=True,  # Habilita a saída detalhada do processo de trabalho da tripulação.
  process=Process.sequential  # Define o processo como sequencial.
)

# Inicia o trabalho da tripulação.
# Isso fará com que as tarefas sejam executadas na ordem definida e os resultados sejam gerados.
result = crew.kickoff()

# Imprime o resultado do trabalho da tripulação.
print(result)
```

Este exemplo abrange a criação de uma estrutura básica usando o CrewAI, com definições claras de agentes, tarefas, e a execução de um processo sequencial pela tripulação. Cada linha de código é comentada para explicar o propósito e como cada componente se encaixa no contexto mais amplo da aplicação CrewAI.

---
### Config Chave API

- Criar arquivo ENV: OPENAI_API_KEY=INSIRA_AQUI_SUA_CHAVE_API
    
- Instalar DOTENV: pip install python-dotenv
    
- Importar DOTENV: from dotenv import load_dotenv
    
- Importar OS: import os
    
- Carregar DOTENV: load_dotenv

#### Config MODELO LLM

- Atribuir API_KEY a uma variável: openai_api_key = os.getenv('OPENAI_API_KEY')
    
- Instalar LANGCHAIN: pip install langchain langchain_community
    
- Importar CHAT_MODEL: from [langchain_comm](http://community.chat/)unity.chat_models import ChatOpenAI
    
- Atribuir LLM a uma variável: openai_llm = ChatOpenAI(model_name='gpt-4-1106-preview', api_key=openai_api_key)
    

#### Agente Organizador de Eventos

```
from crewai import Agent, Task, Crew, Process
from dotenv import load_dotenv
import os
from langchain_community.chat_models import ChatOpenAI

# Define chave API
load_dotenv()
openai_api_key = os.getenv('OPENAI_API_KEY')
openai_llm = ChatOpenAI(model_name='gpt-4-1106-preview', api_key=openai_api_key)

# Agente de Pesquisa de Eventos
agente_pesquisa_eventos = Agent(
    role='Pesquisador de Eventos Culturais',
    goal='Identificar os eventos culturais e sazonais mais relevantes com base nos interesses do usuário.',
    backstory="Você é um especialista em cultura e eventos, com amplo conhecimento sobre festivais, exposições artísticas e celebrações sazonais. Sua missão é descobrir eventos que ofereçam experiências autênticas e enriquecedoras.",
    verbose=True,
    llm=openai_llm
)

# Agente de Planejamento de Itinerários
agente_planejamento_itinerarios = Agent(
    role='Planejador de Itinerários',
    goal='Criar itinerários personalizados que integrem os eventos identificados, otimizando a experiência do usuário.',
    backstory="Com sua habilidade em logística e planejamento de viagens, você transforma a pesquisa de eventos em um itinerário detalhado, considerando localização, datas e preferências do usuário para garantir uma experiência inesquecível.",
    verbose=True,
    llm=openai_llm
)

# Tarefa para o Agente de Pesquisa de Eventos
tarefa_pesquisa_eventos = Task(
    description='''
    Identifique eventos culturais e sazonais que correspondam aos interesses e à disponibilidade do usuário delimitado entre as tags <evento></evento>. Sua resposta final deve ser uma lista de eventos recomendados, com detalhes sobre cada um, incluindo datas, localizações e uma breve descrição.
    
    <evento>
    - Disponibilidade: 16 a 18 de fevereiro de 2024
    - Eventos de interesse: Concerto de música clássica
    </evento>
    ''',
    agent=agente_pesquisa_eventos
)

# Tarefa para o Agente de Planejamento de Itinerários
tarefa_planejamento_itinerarios = Task(
    description='Com base nos eventos identificados, crie um itinerário detalhado que otimize a viagem do usuário. Inclua recomendações de transporte, acomodações e dicas locais. A resposta final deve ser um plano de viagem completo, com um cronograma diário.',
    agent=agente_planejamento_itinerarios
)

# Criando a equipe com processo sequencial
equipe = Crew(
    agents=[agente_pesquisa_eventos, agente_planejamento_itinerarios],
    tasks=[tarefa_pesquisa_eventos, tarefa_planejamento_itinerarios],
    verbose=True
)

# Iniciar o trabalho da equipe
resultado = equipe.kickoff()
```