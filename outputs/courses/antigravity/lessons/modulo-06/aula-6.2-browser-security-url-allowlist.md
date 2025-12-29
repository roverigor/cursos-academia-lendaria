# AULA 6.2: Browser Security - URL Allowlist

**Módulo:** 6 - Segurança Básica [PLUS]
**Duração:** 10 minutos
**Tipo:** Configuração
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender por que controlar os sites que o agente acessa
- Configurar uma URL Allowlist
- Ter controle sobre a navegação do agente

### ORIGEM (Position)
Você provavelmente:
- Já usa o Browser Integrado do Antigravity
- Quer que o agente teste suas páginas, mas não navegue livremente
- Tem preocupação com o agente acessando sites externos
- Quer mais controle sobre o que acontece na sua máquina

### ROTA (Steps)
1. Entender o risco de navegação livre
2. Saber o que é URL Allowlist
3. Configurar sua lista de sites permitidos
4. Testar a proteção

---

## ROTEIRO COMPLETO

### [ABERTURA] - 20 segundos

**[LUCAS DIZ:]**

> Lucas Charao de volta!
>
> Na aula passada você protegeu seus arquivos. Agora vamos proteger a navegação — controlar quais sites o agente pode acessar.
>
> Isso é especialmente importante se você trabalha com dados sensíveis.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Imagina essa situação:
>
> Você pede pro agente testar seu site. Ele abre o browser, testa... e de repente ele decide que precisa "pesquisar algo" e começa a navegar por aí.
>
> (pausa)
>
> Provavelmente nada de errado vai acontecer. Mas "provavelmente" não é garantia.
>
> E se ele acessar um site que baixa algo malicioso? E se ele entrar na sua conta de banco que tá logada no browser?
>
> São cenários extremos? Sim. Mas segurança é sobre prevenir antes de precisar remediar.
>
> URL Allowlist te dá esse controle.

---

### [O QUE É URL ALLOWLIST] - 1 minuto

**[LUCAS DIZ:]**

> URL Allowlist é uma lista dos sites que o agente PODE acessar.
>
> Qualquer site fora da lista? Bloqueado.

**[MOSTRAR NO SLIDE:]**

```
URL ALLOWLIST = Lista de sites PERMITIDOS

COMO FUNCIONA:
─────────────────────────────────
Site na lista     → Agente pode acessar
Site fora da lista → Agente NÃO pode acessar

EXEMPLO:
Allowlist: localhost, meunegocio.com.br

✓ localhost:3000           → Liberado
✓ meunegocio.com.br        → Liberado
✗ google.com               → Bloqueado
✗ facebook.com             → Bloqueado
✗ qualquer-outro-site.com  → Bloqueado
```

**[LUCAS DIZ:]**

> É o oposto da Deny List de arquivos.
>
> Pra arquivos, você bloqueia específicos.
> Pra sites, você libera específicos.
>
> Por quê? Porque existem milhões de sites. É impossível listar todos pra bloquear. Mais fácil listar os poucos que você quer permitir.

---

### [QUANDO USAR URL ALLOWLIST] - 1 minuto

**[LUCAS DIZ:]**

> Quando faz sentido usar?

**[MOSTRAR NO SLIDE:]**

```
USE URL ALLOWLIST QUANDO:

✓ Você só quer que o agente teste SEU site
✓ Trabalha com dados sensíveis
✓ Quer máximo controle
✓ Está em ambiente corporativo

NÃO PRECISA QUANDO:

◯ Você quer que o agente pesquise na web
◯ Confia no ambiente
◯ Não tem dados sensíveis abertos
◯ Precisa de flexibilidade máxima
```

**[LUCAS DIZ:]**

> Se você só quer que o agente teste suas páginas locais (localhost) e seu site em produção, URL Allowlist é perfeito.
>
> Se você precisa que ele pesquise coisas na internet pra te ajudar, talvez não seja a melhor opção.

---

### [CONFIGURANDO URL ALLOWLIST] - 3 minutos

**[LUCAS DIZ:]**

> Vamos configurar. Passo a passo:
>
> **Passo 1:** Abre as Settings do Antigravity.
>
> **Passo 2:** Procura por "Browser Security" ou "Navigation".
>
> **Passo 3:** Encontra "URL Allowlist" ou "Allowed Sites".
>
> **Passo 4:** Adiciona os sites que você quer permitir:

**[MOSTRAR NO SLIDE:]**

```
EXEMPLO DE URL ALLOWLIST:

# Desenvolvimento local
localhost
127.0.0.1

# Seu site em produção
meunegocio.com.br
*.meunegocio.com.br

# Serviços que você usa
vercel.app
netlify.app
```

**[LUCAS DIZ:]**

> Note o `*.meunegocio.com.br` — isso permite QUALQUER subdomínio do seu site. Tipo admin.meunegocio.com.br, api.meunegocio.com.br...
>
> **Passo 5:** Salva as configurações.
>
> **Passo 6:** Testa! Pede pro agente acessar um site que não está na lista:
>
> "Abre o google.com no browser"
>
> (pausa de 5 segundos)
>
> O agente deve recusar ou avisar que não pode acessar esse site.
>
> Se ele recusou, sua URL Allowlist está funcionando!

---

### [LISTA INICIAL RECOMENDADA] - 1 minuto

**[LUCAS DIZ:]**

> Uma lista inicial que funciona pra maioria:

**[MOSTRAR NO SLIDE:]**

```
LISTA INICIAL RECOMENDADA:

# Sempre incluir (desenvolvimento)
localhost
127.0.0.1

# Seu domínio
seusite.com.br
*.seusite.com.br

# Plataformas de hospedagem (se usar)
*.vercel.app
*.netlify.app
*.github.io

# APIs que você usa (se necessário)
api.stripe.com
api.mercadopago.com
```

**[LUCAS DIZ:]**

> Comece com o mínimo e vá adicionando conforme precisar.
>
> Se o agente reclamar que não pode acessar algo que você precisa, adiciona na lista.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> Controle de acesso é um dos princípios mais antigos de segurança.
>
> "Quem pode entrar onde?"
>
> Com a URL Allowlist, você responde: "O agente pode entrar AQUI, e só aqui."
>
> Na próxima aula, vamos fazer um checklist completo de segurança — tudo que você precisa verificar pra usar o Antigravity com tranquilidade.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 6](glossario-modulo-06.md)** para definições completas dos termos:
- URL Allowlist
- Localhost
- Subdomínio
- Wildcard (*)

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que URL Allowlist libera sites específicos
- [ ] Sei quando faz sentido usar (e quando não)
- [ ] Configurei minha lista com localhost e meu domínio
- [ ] Testei e o agente não acessa sites fora da lista
- [ ] Entendi que posso adicionar mais sites conforme precisar

---

## TEMPLATE DE URL ALLOWLIST

```
# ===== DESENVOLVIMENTO =====
localhost
127.0.0.1

# ===== MEU DOMÍNIO =====
[SEU-DOMINIO].com.br
*.[SEU-DOMINIO].com.br

# ===== HOSPEDAGEM =====
# Descomente o que usar:
# *.vercel.app
# *.netlify.app
# *.github.io

# ===== APIs EXTERNAS =====
# Adicione conforme precisar:
# api.exemplo.com
```

---

*Aula 6.2 - Browser Security: URL Allowlist*
*Duração: 10 minutos*
*Professor: Lucas Charao*
