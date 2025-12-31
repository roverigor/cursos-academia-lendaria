# ROTEIRO DE FALA - AULA 2.5

**Aula:** Criando Seu Dashboard ao Vivo
**Módulo:** 2 - Dashboard Automatizado
**Duração:** 15 minutos
**Tipo:** Demo (Demonstração ao Vivo)

---

## [ABERTURA] - 30 segundos

**[PROFESSOR DIZ:]**

> Essa é a hora da verdade.
>
> Você vai me ver criando um dashboard do zero no Looker Studio.
>
> Em 15 minutos, vou sair de uma planilha crua pra um painel visual funcional.
>
> Abre o seu Looker do lado se quiser ir fazendo junto.

---

## [SETUP] - 1 minuto

**[MOSTRAR NA TELA:]**
Planilha com dados de exemplo

**[PROFESSOR DIZ:]**

> Primeiro, o contexto.
>
> Tenho uma planilha com dados de uma loja virtual.
>
> Faturamento diário, número de pedidos, ticket médio, devoluções.
>
> 6 meses de dados.
>
> Meu objetivo: um dashboard com 5 métricas principais.
>
> Vamos lá.

---

## [CONECTANDO A FONTE] - 2 minutos

**[MOSTRAR NA TELA:]**
Looker Studio aberto

**[PROFESSOR DIZ:]**

> Primeiro passo: conectar a planilha.
>
> Clico em "Criar" → "Relatório".
>
> Ele pergunta qual fonte de dados.
>
> Escolho "Google Sheets".
>
> Acho minha planilha, seleciono a aba com os dados.
>
> Clico em "Conectar".
>
> (pausa de 2 segundos)
>
> Pronto. O Looker já enxerga os dados.
>
> Ele mostra as colunas: Data, Faturamento, Pedidos, Ticket, Devoluções.
>
> Tudo certo. Clico em "Adicionar ao relatório".

---

## [CRIANDO O CABEÇALHO] - 1 minuto

**[PROFESSOR DIZ:]**

> Agora tenho uma página em branco.
>
> Primeiro, o cabeçalho.
>
> Vou em "Adicionar um texto".
>
> Escrevo: "Dashboard E-commerce - Atualizado automaticamente".
>
> Aumento a fonte, centralizo.
>
> Pronto.
>
> Agora um filtro de data no canto.
>
> "Adicionar controle" → "Intervalo de datas".
>
> Arrasto pro canto superior direito.
>
> Isso permite escolher o período que quero analisar.

---

## [ADICIONANDO KPIs] - 4 minutos

**[PROFESSOR DIZ:]**

> Agora os KPIs.
>
> Vou adicionar 5 cartões de pontuação.
>
> "Adicionar um gráfico" → "Cartão de pontuação".
>
> Arrasto pra tela.
>
> Na lateral direita, escolho qual métrica.
>
> Primeira: Faturamento.
>
> Seleciono a coluna "Faturamento", função "Soma".
>
> Pronto. Já aparece o número.

**[CONTINUAR NARRANDO:]**

> Segundo cartão: Número de pedidos.
>
> Terceiro: Ticket médio.
>
> Quarto: Devoluções.
>
> Quinto: Taxa de devolução (crio um campo calculado: Devoluções / Pedidos).
>
> (pausa enquanto cria)
>
> Olha só. 5 KPIs na tela.
>
> Agora vou adicionar cores condicionais.
>
> No cartão de Taxa de Devolução, vou nas configurações.
>
> "Formatação condicional".
>
> Se for menor que 3%, verde.
>
> Se for entre 3% e 5%, amarelo.
>
> Se for maior que 5%, vermelho.
>
> Agora o número muda de cor automaticamente baseado no valor.
>
> Isso é ouro. Em 1 segundo você sabe se tá bom ou ruim.

---

## [ADICIONANDO GRÁFICOS] - 3 minutos

**[PROFESSOR DIZ:]**

> Agora dois gráficos embaixo.
>
> "Adicionar um gráfico" → "Gráfico de linhas".
>
> Arrasto pra baixo dos KPIs.
>
> Dimensão: Data.
>
> Métrica: Faturamento.
>
> Pronto. Gráfico de tendência do faturamento.
>
> Agora vejo claramente se tá subindo, descendo ou estável.
>
> (pausa)
>
> Segundo gráfico: barras comparando meses.
>
> "Gráfico de barras".
>
> Dimensão: Mês.
>
> Métrica: Faturamento.
>
> Isso me mostra qual mês foi melhor.
>
> Pronto. Dashboard funcional.

---

## [AJUSTES FINAIS] - 2 minutos

**[PROFESSOR DIZ:]**

> Alguns ajustes finais.
>
> Alinho os KPIs em linha.
>
> Padronizo as cores — azul pra faturamento, verde pra positivo.
>
> Adiciono bordas nos cartões pra ficarem mais bonitos.
>
> E pronto.

**[MOSTRAR NA TELA:]**
Dashboard finalizado

**[PROFESSOR DIZ:]**

> Em 15 minutos, tenho um dashboard que:
>
> - Mostra 5 métricas principais
> - Tem cores condicionais
> - Tem filtro de data
> - Atualiza automaticamente quando a planilha muda
>
> Isso custaria R$5-10 mil com uma consultoria.
>
> Você fez de graça.

---

## [AÇÃO RÁPIDA] - 30 segundos

**[PROFESSOR DIZ:]**

> Sua ação rápida.
>
> Cria um dashboard com pelo menos 1 KPI.
>
> Só 1. Conecta sua planilha, adiciona um cartão de pontuação.
>
> Vê funcionando.
>
> Na próxima aula você faz o resto.

---

## [HOOK PRÓXIMA AULA] - 30 segundos

**[PROFESSOR DIZ:]**

> Você me viu fazer.
>
> Agora é sua vez de fazer o dashboard completo.
>
> Na próxima aula, você vai ter 20 minutos guiados pra construir o seu.
>
> Vou dar dicas específicas pra cada tipo de negócio.
>
> Reserva o tempo e te vejo lá.

---

## NOTAS DE PRODUÇÃO

- **Formato:** Screencast ao vivo
- **Slides:** Nenhum (tudo no Looker)
- **Recursos:** Planilha de exemplo, Looker Studio
- **Tom:** Mão na massa
- **Energia:** Alta

---

*Roteiro Aula 2.5 - Trilha 3 - Academia Lendária*
