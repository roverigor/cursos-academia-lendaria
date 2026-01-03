WEBVTT

00:00.000 --> 00:02.840
E aí, como foi a geração de Tolkien?

00:02.840 --> 00:05.020
Conseguiu ir a sua Tolkien, de fato?

00:05.020 --> 00:07.660
Conseguiu seguir o passo a passo da aula passada.

00:07.660 --> 00:10.500
Se você não conseguiu é muito importante esse Tolkien,

00:10.500 --> 00:16.940
porque sem esse Tolkien você não vai conseguir pegar os dados da API do Meta.

00:16.940 --> 00:23.260
Se você conseguiu, por próximo passo aqui, vamos focar no agente de geração de relatório.

00:23.260 --> 00:29.060
Esse é a gente, todos os dias ele pega as informações do seu Meta

00:29.280 --> 00:34.360
e depois disso, que ele pega as informações do seu conjunto de anúncios do Meta.

00:34.360 --> 00:38.780
Ele vai pegar essas informações, vai trabalhar essas informações e vai enviar

00:38.780 --> 00:42.040
como está suas companhias se estão performando ou não.

00:42.040 --> 00:45.120
Todos os dias, o horário que preferir.

00:45.120 --> 00:50.160
Sabendo disso, eu deixei um fluxo disponível aqui, tem plate de Neto-N em materiais

00:50.160 --> 00:55.560
que qualquer pessoa, seguir nesse passo a passo, vai conseguir utilizar.

00:56.560 --> 00:59.720
Qual é o processo como eu comentei?

00:59.720 --> 01:06.480
Primeiro, temos a API do Meta, temos o Workflow do N8N e a atlavés nesse Workflow.

01:06.480 --> 01:10.120
Você vai conseguir gerar os relatórios prontos para análise.

01:10.120 --> 01:14.880
Os prerrequisitos, como lembrado, é o Tolkien do Meta, a conta de anúncios,

01:14.880 --> 01:18.920
a própria Evolution API que a gente vai trabalhar aqui nessa aula

01:18.920 --> 01:24.200
e também, além disso, outras funções que a gente trouxe ali na aula passada

01:24.200 --> 01:27.400
onde você vai precisar para a gente dar andamento nesse template.

01:27.400 --> 01:32.760
Seguindo desse template, clicando no próprio material,

01:32.760 --> 01:36.200
vai abrir uma tela para vocês, onde vai ter um monte de código,

01:36.200 --> 01:40.640
mas não precisa se preocupar com isso, você vai clicar em Ctrl-A,

01:40.640 --> 01:44.480
Ctrl-C para copiar todos os códigos, depois que você copiar,

01:44.480 --> 01:49.320
vamos entrar no seu próprio N8N aqui.

01:49.440 --> 01:56.880
Pronto, você já vai ter um fluxo pronto que você pode utilizar para, de fato,

01:56.880 --> 02:01.240
você conseguir gerar o seu relatório do Meta.

02:01.240 --> 02:06.120
Mas, de tudo, você vai precisar configurar esse tipo de fluxo,

02:06.120 --> 02:09.160
o que você vai configurar exatamente.

02:09.160 --> 02:14.760
Lembra que, na última aula, fizemos o Tolkien do Meta,

02:14.760 --> 02:17.840
você vai copiar esse Tolkien.

02:17.840 --> 02:22.440
Nesse primeiro bloco, de busca de dados,

02:25.440 --> 02:29.040
vou apagar esse aqui de cima para vocês não se confundirem,

02:29.040 --> 02:33.240
já que a gente vai seguir o processo da aula e o conjunto.

02:33.240 --> 02:39.160
Vamos aqui, busca de dados, vamos colocar o nosso Tolkien aqui,

02:39.160 --> 02:43.120
então, vamos copiar o Tolkien novamente, ok?

02:45.080 --> 02:46.720
Adicineu Tolkien aqui.

02:46.720 --> 02:49.120
O restante, você vai deixar normal.

02:49.120 --> 02:54.120
E aqui, em Actra, vamos subir esse lado de anúncio,

02:54.120 --> 03:00.800
lembre-se da última aula, entrando no link que temos,

03:00.800 --> 03:04.280
Ed Manager, vai abrir essa tela.

03:04.280 --> 03:08.680
Nessa tela aqui, vamos escolher qual o portfólio tem os nossos anúncios,

03:08.680 --> 03:13.200
ou seja, as métricas que temos lá dentro do Meta Eds.

03:13.240 --> 03:17.360
E a parte disso, vamos escolher o anúncio, a colter a nosso principal.

03:17.360 --> 03:19.680
Nesse caso, vou escolher a comunidade slendária,

03:19.680 --> 03:21.840
a partir do momento que eu abri a comunidade slendária,

03:21.840 --> 03:25.440
temos aqui o número do Actra.

03:25.440 --> 03:29.480
Esse Actra, a gente vai adicionar ele aqui, exatamente,

03:29.480 --> 03:31.000
tal o número dele.

03:31.000 --> 03:36.120
E a parte disso, vamos desse destino alpim, ok?

03:36.120 --> 03:42.360
A parte disso, você pode executar.

03:42.360 --> 03:46.400
E já temos os nossos dados agora,

03:46.400 --> 03:50.240
porém, de maneira não estruturada e organizada.

03:50.240 --> 03:53.520
Então, aqui, como você pode ver,

03:53.520 --> 03:58.080
temos o nome da campanha, que é Black novembro,

03:58.080 --> 03:59.880
os dados mal trabalhados.

03:59.880 --> 04:03.800
E agora, a gente vai organizar estados no próximo passo.

04:05.840 --> 04:10.000
Para você não utilizar os seus tokens,

04:10.040 --> 04:12.040
várias vezes,

04:12.040 --> 04:14.760
a partir do momento que você fazer a primeira busca,

04:14.760 --> 04:18.080
você vai clicar na direita superior,

04:18.080 --> 04:21.040
aqui em pindeira.

04:21.040 --> 04:25.560
E a parte disso, vamos executar, agora,

04:25.560 --> 04:27.800
com você, vamos testar apenas esse bloco

04:27.800 --> 04:29.640
para você ver como a informação sai.

04:29.640 --> 04:32.720
Então, clicando aqui,

04:32.720 --> 04:35.880
criamos um código em JavaScript nesse template,

04:35.920 --> 04:40.120
onde as métodias já estão pré-configuradas.

04:40.120 --> 04:42.840
Então, se a gente veio aqui em table,

04:42.840 --> 04:45.920
todos esses dados que vocês viram aqui, bagunçados,

04:45.920 --> 04:50.680
eles se transformaram em um relatório formatado,

04:50.680 --> 04:54.720
onde você vai conseguir saber a quantidade de campanhas rodadas,

04:54.720 --> 04:57.200
lir gerados dos investimentos total,

04:57.200 --> 05:00.440
e, se realmente, de fato, traduzendo o resultado.

05:00.440 --> 05:04.760
Agora, nesse próximo bloco, que, em cima,

05:04.800 --> 05:08.080
você pode enviar tanto em um grupo de WhatsApp

05:08.080 --> 05:09.880
até no seu perfil pessoal.

05:09.880 --> 05:12.960
Nesse caso, eu vou mostrar como você pode configurar

05:12.960 --> 05:14.680
no seu perfil pessoal.

05:14.680 --> 05:17.120
Clicando aqui em cima, lembra que,

05:17.120 --> 05:20.120
falamos que vamos precisar de uma peida e evolução.

05:20.120 --> 05:22.440
Vamos clicar dentro da evolução.

05:22.440 --> 05:25.520
Eu tenho um número fixo que eu utilizo para dar a aula.

05:25.520 --> 05:29.120
Então, eu vou pegar a minha instância,

05:29.120 --> 05:33.520
eu vou trocar depois do teste.

05:33.520 --> 05:39.280
Importante, a gente pegado também o domínio.

05:39.280 --> 05:44.600
Nesse domínio, vamos modificar aqui também.

05:44.600 --> 05:46.960
É muito importante verificar.

05:46.960 --> 05:50.840
Se tudo está correto, se não tem nenhum campo apagado,

05:50.840 --> 05:52.480
para não virar conflito,

05:52.480 --> 05:59.320
aqui vamos copiar o nosso token em evolução.

05:59.320 --> 06:02.720
E, a parte disso, eu vou colocar aqui em number o número

06:02.760 --> 06:04.960
que eu vou enviar o relatório todos os dias.

06:04.960 --> 06:09.440
Então, eu vou colocar aqui o meu número pessoal,

06:12.640 --> 06:17.840
que provavelmente vai ser apagado conforme as aulas serem inditadas.

06:17.840 --> 06:22.280
Clicando aqui, pronto.

06:22.280 --> 06:26.000
Enviado o relatório no meu WhatsApp.

06:26.000 --> 06:29.120
Quer ver como ficou? Vamos ver juntos.

06:30.120 --> 06:34.120
Vamos ver em conjunto.

06:34.120 --> 06:36.120
Se fez sentido.

06:47.120 --> 06:53.120
Engage a cidadão, que é o número fixo que eu falei para vocês,

06:53.120 --> 06:56.120
que pode ser o nome que é a gerador de relatório.

06:57.120 --> 07:06.120
Quando vocês vão colocar, aqui temos o nosso template já pre-definido,

07:06.120 --> 07:11.120
onde vamos ter tanto investimento total, compras CPA.

07:11.120 --> 07:15.120
Como vocês podem ver, aqui tem um relatório gerado por X,

07:15.120 --> 07:19.120
ou relatório diário, empresa nome, trafico pago.

07:19.120 --> 07:22.120
É onde você vai ajustar o nome da sua empresa,

07:22.120 --> 07:29.120
então, voltando aqui novamente no nosso código de JavaScript,

07:29.120 --> 07:37.120
em relatório gerado por X, podemos mudar o nome aqui.

07:37.120 --> 07:40.120
Tenho sontores lá no final do código.

07:40.120 --> 07:41.120
Tenho sontores.

07:41.120 --> 07:43.120
E aqui em cima.

07:43.120 --> 07:45.120
Tenho sontores.

07:45.120 --> 07:48.120
Executando novamente.

07:49.120 --> 07:52.120
Tenho sontores.

07:52.120 --> 07:55.120
Tenho sontores no mesmo horário.

07:55.120 --> 07:58.120
Aqui você consegue editar para colocar o nome da sua empresa,

07:58.120 --> 08:01.120
ou eventualmente, nome também de um cliente,

08:01.120 --> 08:04.120
é onde você vai editar o template.

08:04.120 --> 08:08.120
Se você quiser conectar um grupo de WhatsApp,

08:08.120 --> 08:11.120
vou colocar um bloco aqui também,

08:11.120 --> 08:18.120
que você vai mudar as instâncias,

08:18.120 --> 08:25.120
as instâncias, como a gente mudou no passado.

08:25.120 --> 08:35.120
Então vamos aqui, dar as instâncias.

08:35.120 --> 08:37.120
Licando aqui.

08:37.120 --> 08:39.120
Se a gente testar esse bloco,

08:39.120 --> 08:42.120
vai vir para a gente o número de nossos grupos,

08:42.120 --> 08:45.120
tem um grupo, enviar relatório.

08:45.120 --> 08:47.120
Se a gente pega esse dia aqui,

08:47.120 --> 08:49.120
e a adiciona esse dia dentro do número,

08:49.120 --> 08:53.120
automaticamente, vai enviar a mensagem todos os dias,

08:53.120 --> 08:55.120
nesse grupo.

08:55.120 --> 09:02.120
Recapitulando, enviamos primeiro a mensagem completa,

09:02.120 --> 09:04.120
como vocês podem ver aqui,

09:04.120 --> 09:06.120
aqui dentro, especificamente,

09:06.120 --> 09:09.120
temos todas as campanhas,

09:09.120 --> 09:12.120
quem enviamos,

09:12.120 --> 09:14.120
estão lidos gerados, compras,

09:14.120 --> 09:16.120
está alcance,

09:16.120 --> 09:19.120
e aqui tem campanhas analisadas.

09:19.120 --> 09:22.120
Cada campanha tem sua avaliação de métrica.

09:22.120 --> 09:24.120
Para ter sua avaliação de métrica,

09:24.120 --> 09:27.120
por isso que a gente vai ter o restante do fluxo,

09:27.120 --> 09:29.120
o restante do fluxo,

09:29.120 --> 09:32.120
é para dividir as mensagens em 12,

09:32.120 --> 09:34.120
justamente porque as campanhas são 12.

09:34.120 --> 09:37.120
Então, imagina que de vez a gente analisar as 12 de uma vez,

09:38.120 --> 09:40.120
que é o relatório copilado.

09:40.120 --> 09:43.120
Agora, a gente vai realmente analisar,

09:43.120 --> 09:45.120
campanha por campanha.

09:45.120 --> 09:47.120
Seguindo o fluxo aqui,

09:47.120 --> 09:50.120
a gente vai mudar,

09:50.120 --> 09:52.120
mais uma vez.

09:52.120 --> 09:55.120
Vamos colocar o domínio base.

10:01.120 --> 10:04.120
Ok.

10:04.120 --> 10:07.120
Vamos colocar o domínio base.

10:15.120 --> 10:18.120
Ok.

10:18.120 --> 10:22.120
E dentro do fluxo de vocês,

10:22.120 --> 10:24.120
como vocês vão perceber,

10:24.120 --> 10:26.120
tem um noque que é o groque,

10:26.120 --> 10:28.120
que ele está em vermelho,

10:28.120 --> 10:31.120
mas como você consegue configurar o groque,

10:31.120 --> 10:33.120
clicando aqui em cima,

10:33.120 --> 10:36.120
em específico na caneta do groque aqui,

10:36.120 --> 10:40.120
você pode tanto adicionar uma conta nova,

10:40.120 --> 10:42.120
tanto para colocar uma conta antiga,

10:42.120 --> 10:45.120
como que você pode entrar no groque.

10:46.120 --> 10:48.120
Ficando em groque,

10:48.120 --> 10:50.120
com o sol,

10:50.120 --> 10:53.120
deixa esse link disponível aqui para vocês também.

10:58.120 --> 11:00.120
Groque com o sol,

11:00.120 --> 11:02.120
você tem a opção

11:02.120 --> 11:05.120
de utilizar uma iagratuita.

11:05.120 --> 11:08.120
Então, imagina que agora você não vai precisar usar o API,

11:08.120 --> 11:09.120
qualquer outro fluxo,

11:09.120 --> 11:11.120
fica a seu critério usar groque também,

11:11.120 --> 11:13.120
clicando em criar a API,

11:13.120 --> 11:15.120
depois de criar a sua conta com e-mail,

11:15.120 --> 11:17.120
então vamos deslogar aqui,

11:17.120 --> 11:20.120
pois que você criar conta com o seu e-mail.

11:29.120 --> 11:31.120
Podemos em API,

11:33.120 --> 11:35.120
criar a nova API,

11:38.120 --> 11:40.120
a sua geração de relatório,

11:43.120 --> 11:45.120
e a partir disso,

11:46.120 --> 11:48.120
podemos copiar

11:49.120 --> 11:52.120
e adicionar a API aqui,

11:52.120 --> 11:54.120
que já vai estar funcionando,

11:54.120 --> 11:55.120
depois disso,

11:55.120 --> 11:58.120
não precisa modificar nada, tá?

11:58.120 --> 12:00.120
Essa aqui é a conta do groque,

12:00.120 --> 12:02.120
com essa configuração,

12:02.120 --> 12:06.120
após você executar de novo,

12:08.120 --> 12:12.120
as campanhas vão ser enviadas automaticamente,

12:13.120 --> 12:14.120
legal?

12:15.120 --> 12:16.120
Essas campanhas,

12:16.120 --> 12:18.120
é importante dizer, em fartizar novamente,

12:18.120 --> 12:20.120
que aqui vai ser o resumo,

12:20.120 --> 12:22.120
e aqui, a gente vai analisar

12:22.120 --> 12:23.120
campanha por campanha,

12:23.120 --> 12:25.120
e algo muito importante,

12:25.120 --> 12:27.120
que antes da campanha ser enviada,

12:27.120 --> 12:29.120
individualmente,

12:29.120 --> 12:32.120
dentro do prompt, você pode modificar também,

12:32.120 --> 12:34.120
tem um especialista,

12:34.120 --> 12:35.120
um agente,

12:35.120 --> 12:37.120
que ele vai analisar,

12:37.120 --> 12:38.120
para ver se realmente

12:38.120 --> 12:41.120
essas campanhas estão sendo performáticas ou não,

12:41.120 --> 12:44.120
e a estratégia fica ao seu critério,

12:44.120 --> 12:46.120
esse prompt você pode reutilizar,

12:46.120 --> 12:48.120
mas também você pode trabalhar ele,

12:48.120 --> 12:49.120
ao longo prazo.

12:50.120 --> 12:51.120
Depois que você fez isso,

12:51.120 --> 12:53.120
vamos voltar novamente aqui,

12:53.120 --> 12:54.120
nosso WhatsApp,

12:54.120 --> 12:55.120
e agora,

12:55.120 --> 12:57.120
temos cada campanha,

12:57.120 --> 12:59.120
com o seu próprio diagnóstico,

13:00.120 --> 13:02.120
aonde você consegue,

13:02.120 --> 13:03.120
avaliar,

13:04.120 --> 13:06.120
como gestor de telefugupago,

13:06.120 --> 13:07.120
ou alguém do seu time,

13:07.120 --> 13:08.120
também,

13:08.120 --> 13:09.120
pode avaliar,

13:09.120 --> 13:10.120
para ver se as campanhas,

13:10.120 --> 13:13.120
e realmente estão performando a maneira que deveria.

13:14.120 --> 13:15.120
A princípio,

13:15.120 --> 13:16.120
depois que você fez,

13:16.120 --> 13:17.120
esse fluxo completo,

13:17.120 --> 13:18.120
e seguiu,

13:18.120 --> 13:19.120
esse passo a passo,

13:19.120 --> 13:20.120
agora,

13:20.120 --> 13:23.120
é hora de você ativar esse fluxo aqui.

13:23.120 --> 13:24.120
Tá?

13:26.120 --> 13:27.120
Esse é um segundo processo,

13:27.120 --> 13:29.120
que a gente vai seguir na próxima aula,

13:29.120 --> 13:31.120
que é o agente de análise e de conversa,

13:31.120 --> 13:33.120
então, eu vou apagar ele aqui na próxima aula,

13:33.120 --> 13:34.120
a gente segue assim,

13:34.120 --> 13:35.120
depois que,

13:35.120 --> 13:36.120
que a gente viu,

13:36.120 --> 13:38.120
vamos salvar ele,

13:39.120 --> 13:40.120
ok?

13:40.120 --> 13:41.120
E, após salvar,

13:41.120 --> 13:42.120
e ativar,

13:44.120 --> 13:45.120
você,

13:46.120 --> 13:47.120
pode colocar,

13:47.120 --> 13:48.120
qual horário,

13:48.120 --> 13:51.120
que vai ser enviado esse relatório,

13:52.120 --> 13:54.120
e qual é a quantidade de dia que ele deve ser enviado?

13:54.120 --> 13:55.120
Então, é a cada semana,

13:55.120 --> 13:56.120
é a cada mês,

13:56.120 --> 13:57.120
é a cada hora,

13:57.120 --> 13:58.120
todos os dias,

13:58.120 --> 14:00.120
eu coloquei aqui,

14:00.120 --> 14:01.120
para esse relatório,

14:01.120 --> 14:03.120
ser enviado a cinco horas da tarde.

14:03.120 --> 14:06.120
Pode ser que você queira que ele seja enviado 7 horas da manhã.

14:07.120 --> 14:09.120
Mas o ideal é que,

14:09.120 --> 14:11.120
fique ao seu critério.

14:11.120 --> 14:12.120
Então, você pode escolher,

14:12.120 --> 14:14.120
que, a cada uma semana,

14:16.120 --> 14:18.120
num sábado, por exemplo,

14:18.120 --> 14:19.120
tá?

14:19.120 --> 14:21.120
Sábado ou domingo?

14:23.120 --> 14:26.120
Você receba esse relatório no seu WhatsApp,

14:26.120 --> 14:27.120
e, se você quiser,

14:27.120 --> 14:29.120
você também pode modificar,

14:29.120 --> 14:31.120
tanto para o seu Gmail,

14:31.120 --> 14:32.120
tanto para o seu Slack.

14:32.120 --> 14:33.120
Aí,

14:33.120 --> 14:34.120
fica ao seu critério,

14:34.120 --> 14:36.120
a gente trabalhou aqui com a evolutio.

14:38.120 --> 14:39.120
Agora, eu quero saber,

14:39.120 --> 14:41.120
se realmente você conseguiu acompanhar essa aula,

14:41.120 --> 14:42.120
se essa aula faz sentido para você,

14:42.120 --> 14:45.120
se você está gostando de trabalhar esse fluxo,

14:45.120 --> 14:46.120
é importante enfartsar,

14:46.120 --> 14:48.120
que o seu aprendizado,

14:48.120 --> 14:49.120
ele pode ser artes na desse fluxo,

14:49.120 --> 14:50.120
também,

14:50.120 --> 14:51.120
fica ao critério de você,

14:51.120 --> 14:52.120
trabalhar o prompt,

14:52.120 --> 14:53.120
colocar outros modelos,

14:53.120 --> 14:54.120
e, pré-configurar,

14:54.120 --> 14:56.120
a maneira que você precisa,

14:56.120 --> 14:57.120
significa que,

14:57.120 --> 14:58.120
se passa a passo,

14:58.120 --> 15:00.120
eu tenho certeza que você vai conseguir colher uns bons resultados,

15:00.120 --> 15:01.120
e, para isso,

15:01.120 --> 15:03.120
eu quero garantir que você esteja aplicando,

15:03.120 --> 15:04.120
e praticando,

15:04.120 --> 15:05.120
e praticando,

15:05.120 --> 15:06.120
eu quero saber,

15:06.120 --> 15:07.120
se você está conseguindo realmente colocar em prática,

15:07.120 --> 15:08.120
eu vou deixar o tempo aqui,

15:08.120 --> 15:09.120
escorrendo,

15:09.120 --> 15:10.120
para você,

15:10.120 --> 15:11.120
rever a aula,

15:11.120 --> 15:12.120
e refazer,

15:12.120 --> 15:13.120
e a gente se vê,

15:13.120 --> 15:14.120
no próximo a gente,

15:14.120 --> 15:15.120
que eu agente de análise de relatório,

15:15.120 --> 15:16.120
a gente mais simples,

15:16.120 --> 15:17.120
menos complexo,

15:17.120 --> 15:19.120
mais que vai também de redor,

15:19.120 --> 15:20.120
muito frutos,

15:20.120 --> 15:21.120
então, vamos lá,

15:21.120 --> 15:23.120
de vejo na próxima aula.

