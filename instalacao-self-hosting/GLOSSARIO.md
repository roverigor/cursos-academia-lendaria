# Glossário: Instalação de Ferramentas Self-Hosting

> **Para quem é:** Empresários não-técnicos que querem entender os termos sem virar programador.
>
> **Regra:** Cada termo explicado como se fosse para alguém que nunca viu um terminal na vida.

---

## A

### API (Application Programming Interface)
**O que é:** Uma "porta" que permite que programas conversem entre si.

**Analogia:** É como o garçom de um restaurante. Você (programa A) faz o pedido pro garçom (API), ele leva pra cozinha (programa B) e traz a resposta.

**No curso:** A Evolution API é a "porta" que permite seu sistema enviar e receber mensagens do WhatsApp.

---

## B

### Bash
**O que é:** A linguagem que o terminal entende.

**Analogia:** Se o terminal é a boca do computador, Bash é o idioma que ele fala.

**No curso:** Quando você digita `ls` ou `cd`, está "falando Bash" com o computador.

---

## C

### Container
**O que é:** Uma caixinha isolada onde roda uma ferramenta.

**Analogia:** É como um cômodo da casa. Cada cômodo (container) tem seus próprios móveis (dependências) e não interfere nos outros.

**No curso:** Portainer, Evolution API, Traefik — cada um roda em seu próprio container.

### CLI (Command Line Interface)
**O que é:** Forma de usar o computador digitando comandos em vez de clicar.

**Analogia:** É conversar por texto em vez de apertar botões.

**No curso:** O terminal é uma CLI.

---

## D

### DNS (Domain Name System)
**O que é:** O sistema que traduz nomes de sites em números (IPs).

**Analogia:** É o GPS da internet. Você digita "google.com" e o DNS encontra o endereço numérico correto.

**No curso:** Você configura o DNS pra que `portainer.seudominio.com.br` aponte pro IP da sua VPS.

### Docker
**O que é:** Programa que cria e gerencia containers.

**Analogia:** É o arquiteto que constrói os cômodos da sua casa (VPS). Você diz o que quer, ele cria isolado e funcionando.

**No curso:** Docker permite instalar qualquer ferramenta com poucos comandos.

### Docker Compose
**O que é:** Arquivo que descreve como criar um ou mais containers.

**Analogia:** É a planta baixa. Você escreve o que quer (quais containers, quais portas) e o Docker constrói.

**No curso:** Cada ferramenta tem seu arquivo `docker-compose.yml`.

### Domínio
**O que é:** O nome do seu site (ex: `suaempresa.com.br`).

**Analogia:** É o nome da rua. Mais fácil de lembrar que o CEP (IP).

**No curso:** Você compra um domínio e aponta ele pra sua VPS.

---

## E

### Evolution API
**O que é:** Ferramenta open source que conecta ao WhatsApp.

**Analogia:** É como ter o WhatsApp Web, mas controlado por você, permitindo automações.

**No curso:** Substitui serviços pagos como Twilio e Z-API (economia de R$ 150-300/mês).

---

## H

### HTTP / HTTPS
**O que é:** Protocolo de comunicação da web. O "S" significa seguro (criptografado).

**Analogia:** HTTP é uma carta aberta. HTTPS é uma carta em envelope lacrado — só o destinatário lê.

**No curso:** Traefik gera HTTPS automaticamente (cadeado verde no navegador).

---

## I

### IP (Internet Protocol)
**O que é:** O endereço numérico de qualquer dispositivo na internet.

**Analogia:** É o CEP da sua casa na internet (ex: 192.168.1.1).

**No curso:** Sua VPS tem um IP fixo. Você aponta o domínio pra esse IP.

### Imagem (Docker Image)
**O que é:** O "molde" de um container. Contém tudo que a ferramenta precisa pra rodar.

**Analogia:** É a receita de bolo. O container é o bolo pronto.

**No curso:** Quando você instala Portainer, baixa a "imagem" dele e cria um container a partir dela.

---

## L

### Linux
**O que é:** Sistema operacional (como Windows ou Mac), mas gratuito e usado em servidores.

**Analogia:** É o "idioma" que a maioria dos servidores fala.

**No curso:** Sua VPS roda Linux (geralmente Ubuntu).

### Logs
**O que é:** Registros de tudo que acontece em um programa.

**Analogia:** É o diário de bordo. Quando algo dá errado, você lê os logs pra entender o que aconteceu.

**No curso:** No Portainer, você clica em "Logs" pra ver se um container teve erro.

---

## N

### N8N
**O que é:** Ferramenta de automação visual, tipo Make/Zapier, mas self-hosted.

**Analogia:** É um LEGO de automações. Você conecta peças (triggers, ações) e cria fluxos.

**No curso:** Mencionado como próxima ferramenta (economia de R$ 2.400/ano).

---

## O

### Open Source
**O que é:** Software com código aberto — qualquer pessoa pode ver, usar e modificar.

**Analogia:** É uma receita pública. Você pode fazer em casa de graça, sem pagar royalties.

**No curso:** Evolution API, N8N, Chatwoot são open source.

---

## P

### Porta (Port)
**O que é:** Número que identifica qual serviço acessar em um servidor.

**Analogia:** Se o IP é o endereço da casa, a porta é qual cômodo você quer entrar (porta 80 = sala, porta 443 = escritório).

**No curso:** Portainer usa porta 9000, Traefik usa 80 e 443.

### Portainer
**O que é:** Painel visual para gerenciar containers Docker.

**Analogia:** É a planta baixa interativa da sua casa. Você vê todos os cômodos (containers) e controla sem digitar comandos.

**No curso:** Ferramenta central para gerenciar sua infraestrutura.

### Proxy Reverso
**O que é:** Intermediário que recebe requisições e direciona pro container certo.

**Analogia:** É o porteiro do prédio. Alguém chega pedindo "apartamento 301" e ele direciona.

**No curso:** Traefik é o proxy reverso — direciona `portainer.seudominio.com` pro container do Portainer.

---

## Q

### QR Code
**O que é:** Código de barras quadrado que pode ser escaneado.

**No curso:** Você escaneia o QR Code da Evolution API com seu WhatsApp pra conectar.

---

## R

### Registro A (DNS)
**O que é:** Tipo de registro DNS que aponta um domínio pra um IP.

**Analogia:** É a linha no GPS que diz "Rua X = CEP Y".

**No curso:** Você cria registros A pra cada subdomínio (portainer, evolution, etc.).

### Root
**O que é:** Usuário administrador com acesso total ao sistema.

**Analogia:** É o dono da casa, com chave de todos os cômodos.

**No curso:** Você acessa a VPS como root: `ssh root@seu-ip`.

---

## S

### SaaS (Software as a Service)
**O que é:** Software que você paga mensalidade pra usar (na nuvem de terceiros).

**Analogia:** É alugar apartamento mobiliado. Prático, mas você paga todo mês e não é seu.

**No curso:** Self-hosting substitui SaaS — você "compra a casa" em vez de alugar.

### Self-Hosting
**O que é:** Hospedar ferramentas no seu próprio servidor, em vez de usar serviços de terceiros.

**Analogia:** É ter casa própria em vez de alugar. Mais trabalho inicial, mas você controla e economiza.

**No curso:** Tema central — hospedar Evolution, N8N, Chatwoot na sua VPS.

### SSH (Secure Shell)
**O que é:** Protocolo seguro pra acessar servidores remotamente.

**Analogia:** É uma ligação telefônica criptografada com seu servidor. Você digita comandos daqui, ele executa lá.

**No curso:** Você usa SSH pra acessar sua VPS: `ssh root@seu-ip`.

### SSL (Secure Sockets Layer)
**O que é:** Certificado que habilita HTTPS (cadeado verde).

**Analogia:** É o selo de segurança que garante que a conexão é criptografada.

**No curso:** Traefik gera certificados SSL automaticamente via Let's Encrypt.

### Subdomínio
**O que é:** Prefixo antes do domínio principal (ex: `portainer.seudominio.com.br`).

**Analogia:** Se o domínio é o nome do prédio, o subdomínio é o número do apartamento.

**No curso:** Cada ferramenta tem seu subdomínio (portainer., evolution., n8n.).

---

## T

### Terminal
**O que é:** Programa onde você digita comandos pro computador.

**Analogia:** É a boca do computador. Você fala (digita), ele responde.

**No curso:** Você usa o terminal pra acessar a VPS e executar comandos.

### Traefik
**O que é:** Proxy reverso que gerencia tráfego e gera HTTPS automaticamente.

**Analogia:** É o porteiro inteligente que também cuida da segurança (SSL) automaticamente.

**No curso:** Traefik direciona requisições pros containers e gera certificados HTTPS.

---

## U

### Ubuntu
**O que é:** Versão popular de Linux, fácil de usar em servidores.

**Analogia:** É um "dialeto" de Linux, conhecido por ser amigável.

**No curso:** Geralmente sua VPS vem com Ubuntu instalado.

---

## V

### VPS (Virtual Private Server)
**O que é:** Servidor virtual que você aluga na nuvem.

**Analogia:** É sua casa própria na internet. Você paga aluguel (~R$ 78/mês), mas tem controle total do que acontece dentro.

**No curso:** Base de tudo — onde você instala Docker, Portainer e todas as ferramentas.

### Volume (Docker Volume)
**O que é:** Pasta persistente que guarda dados de um container.

**Analogia:** É o HD do cômodo. Mesmo que derrube o cômodo e reconstrua, os móveis (dados) continuam lá.

**No curso:** Volumes guardam dados do Portainer, bancos de dados, etc.

---

## Y

### YAML
**O que é:** Formato de arquivo usado pra configurações (fácil de ler).

**Analogia:** É uma lista organizada com travessões e espaços. Humanos entendem, computadores também.

**No curso:** Arquivos `docker-compose.yml` são escritos em YAML.

---

## Comandos Essenciais

| Comando | O que faz | Analogia |
|---------|-----------|----------|
| `ls` | Lista arquivos | "O que tem aqui?" |
| `cd` | Muda de pasta | "Entra nesse cômodo" |
| `pwd` | Mostra onde você está | "Onde eu tô?" |
| `clear` | Limpa a tela | "Apaga o quadro" |
| `exit` | Fecha o terminal | "Tchau" |
| `docker ps` | Lista containers rodando | "Quem tá em casa?" |
| `ssh` | Conecta em servidor remoto | "Liga pra casa" |

---

## Analogia Central: A Cidade da Internet

> Use essa analogia em todas as aulas para manter consistência.

| Conceito | Analogia |
|----------|----------|
| **Internet** | A cidade |
| **VPS** | Sua casa própria |
| **IP** | CEP da casa |
| **Domínio** | Nome da rua (fácil de lembrar) |
| **DNS** | GPS que traduz nome → CEP |
| **Docker** | Arquiteto que constrói cômodos |
| **Container** | Cômodo isolado |
| **Portainer** | Planta baixa visual |
| **Traefik** | Porteiro inteligente |
| **SSH** | Ligação segura pra casa |
| **HTTPS** | Envelope lacrado (seguro) |

---

*Glossário criado para o curso "Instalação de Ferramentas Open Source (Self-Hosting)"*
*Público: Empresários não-técnicos | Arquétipo A: Cortar Custos*
