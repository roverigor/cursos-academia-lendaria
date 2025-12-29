# AULA 6.1: Configurando Allow/Deny Lists

**Módulo:** 6 - Segurança Básica [PLUS]
**Duração:** 10 minutos
**Tipo:** Configuração Crítica
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender o que são Allow/Deny Lists
- Configurar uma Deny List pra proteger arquivos sensíveis
- Ter confiança pra deixar o agente trabalhar sem medo

### ORIGEM (Position)
Você provavelmente:
- Já usa o Antigravity pra criar projetos
- Tem arquivos que não quer que o agente mexa
- Quer mais segurança sem complicação
- Ouviu falar de "lista de bloqueio" mas não configurou

### ROTA (Steps)
1. Entender o conceito de listas de permissão
2. Saber quando usar Allow vs Deny
3. Configurar sua Deny List
4. Testar se a proteção está funcionando

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Módulo 6: Segurança! Lucas Charao aqui.
>
> Esse módulo é [PLUS] porque é pra quem quer usar o Antigravity com mais tranquilidade. Segurança não é paranoia, é profissionalismo.
>
> Vamos começar com as listas de permissão.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Já pensou: "E se o agente deletar algo importante?"
>
> Ou: "E se ele mexer num arquivo que não deveria?"
>
> (pausa)
>
> Esse medo é normal. E sabe o que? Ele é saudável.
>
> Mas não precisa ser um medo paralisante. Você pode dizer PRO AGENTE: "Olha, você pode mexer em tudo, EXCETO nesses arquivos aqui."
>
> É como dar as chaves de casa pro funcionário, mas manter a gaveta do cofre trancada.
>
> Allow/Deny Lists são exatamente isso: você define onde o agente PODE e onde NÃO PODE mexer.

---

### [O QUE SÃO ALLOW/DENY LISTS] - 1.5 minutos

**[LUCAS DIZ:]**

> Vamos entender as duas listas:

**[MOSTRAR NO SLIDE:]**

```
ALLOW LIST (Lista de Permissão)
= Arquivos/pastas que o agente PODE acessar
= "Só mexa NISSO"

DENY LIST (Lista de Bloqueio)
= Arquivos/pastas que o agente NÃO PODE acessar
= "Mexa em tudo, EXCETO isso"

QUAL USAR?
─────────────────────────────────
Projeto pequeno → Deny List (mais comum)
   "Bloqueia só o sensível"

Projeto sensível → Allow List
   "Só libera o necessário"
```

**[LUCAS DIZ:]**

> Na prática, a maioria das pessoas usa Deny List.
>
> Você libera o agente pra trabalhar e só bloqueia o que é sensível: senhas, configurações de produção, dados de clientes...

---

### [EXEMPLOS DO QUE BLOQUEAR] - 1 minuto

**[LUCAS DIZ:]**

> O que você deveria colocar na Deny List?

**[MOSTRAR NO SLIDE:]**

```
ARQUIVOS SENSÍVEIS - SEMPRE BLOQUEAR:

🔐 Credenciais
   .env              ← Senhas e chaves de API
   .env.production   ← Variáveis de produção
   secrets/          ← Pasta de segredos

💳 Dados de Clientes
   dados-clientes.json
   planilha-vendas.xlsx
   contratos/

⚙️ Configurações Críticas
   config.production.js
   database.yml
   deploy-credentials/

📁 Pastas de Sistema
   node_modules/     ← Dependências (pesado demais)
   .git/             ← Histórico do Git
```

**[LUCAS DIZ:]**

> Basicamente: senhas, dados de pessoas, e configurações que podem quebrar seu sistema em produção.

---

### [CONFIGURANDO A DENY LIST] - 3 minutos

**[LUCAS DIZ:]**

> Vamos configurar juntos. Passo a passo:
>
> **Passo 1:** Abre as Settings do Antigravity.
>
> **Passo 2:** Procura por "Security" ou "File Access".
>
> **Passo 3:** Encontra "Deny List" ou "Blocked Files".
>
> **Passo 4:** Adiciona os arquivos que você quer proteger:

**[MOSTRAR NO SLIDE:]**

```
EXEMPLO DE DENY LIST:

.env
.env.*
secrets/
*.production.*
dados-clientes/
contratos/
node_modules/
.git/
```

**[LUCAS DIZ:]**

> Viu o padrão `*.production.*`? Isso bloqueia QUALQUER arquivo com "production" no nome.
>
> E `secrets/` com a barra no final? Bloqueia a PASTA inteira.
>
> **Passo 5:** Salva as configurações.
>
> **Passo 6:** Testa! Pede pro agente ler um arquivo bloqueado:
>
> "Mostra o conteúdo do arquivo .env"
>
> (pausa de 5 segundos)
>
> O agente deve recusar ou avisar que não tem acesso.
>
> Se ele recusou, sua Deny List está funcionando!

---

### [DICAS DE SEGURANÇA] - 1 minuto

**[LUCAS DIZ:]**

> Algumas dicas importantes:
>
> **1. Comece conservador**
> Bloqueie mais do que menos. Você pode desbloquear depois.
>
> **2. Use padrões (wildcards)**
> `*.env*` pega .env, .env.local, .env.production...
>
> **3. Não confie só nisso**
> Deny List é uma camada de proteção, não a única.
>
> **4. Revise periodicamente**
> Projeto novo = revisar o que precisa ser bloqueado.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Segurança é sobre CAMADAS.
>
> A Deny List é uma camada. As políticas de revisão são outra. Backups são outra.
>
> Nenhuma sozinha é perfeita. Mas juntas, elas te protegem.
>
> Na próxima aula, vamos configurar a segurança do Browser — controlar quais sites o agente pode acessar.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 6](glossario-modulo-06.md)** para definições completas dos termos:
- Allow List
- Deny List
- Wildcard
- Arquivo sensível

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi a diferença entre Allow List e Deny List
- [ ] Sei que Deny List é mais comum pra projetos normais
- [ ] Configurei minha Deny List com arquivos sensíveis
- [ ] Testei e o agente não consegue acessar os arquivos bloqueados
- [ ] Entendi que segurança é feita em camadas

---

## LISTA SUGERIDA DE BLOQUEIO

```
# Credenciais e Segredos
.env
.env.*
secrets/
*.key
*.pem

# Dados Sensíveis
dados-clientes/
contratos/
financeiro/

# Configurações de Produção
*.production.*
config.prod.*

# Sistema
node_modules/
.git/
```

---

*Aula 6.1 - Configurando Allow/Deny Lists*
*Duração: 10 minutos*
*Professor: Lucas Charao*
