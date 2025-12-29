# Guia de Troubleshooting - NotebookLM

## Problemas de Acesso

### ❌ "Não consigo acessar o NotebookLM"

**Possíveis causas e soluções:**

| Causa | Solução |
|-------|---------|
| Conta Google inativa | Verificar login em gmail.com primeiro |
| Região não suportada | Usar VPN (alguns países bloqueados) |
| Navegador desatualizado | Atualizar para última versão |
| Bloqueador de pop-up | Desativar para notebooklm.google.com |
| Cache corrompido | Limpar cache e cookies do navegador |

---

### ❌ "Workspace bloqueado pelo admin"

**Solução:**
1. Opção A: Solicitar ao admin da organização que libere o NotebookLM
2. Opção B: Usar conta Google pessoal (fora do Workspace)
3. Opção C: Usar modo anônimo com conta pessoal

---

## Problemas com Sources

### ❌ "PDF não processa / fica carregando"

**Possíveis causas:**

| Causa | Como identificar | Solução |
|-------|------------------|---------|
| PDF é imagem (scan) | Texto não selecionável | Usar OCR antes (Adobe, Google Docs) |
| PDF muito grande | >500K palavras | Dividir em partes menores |
| PDF protegido | Erro de permissão | Remover proteção ou usar texto |
| Formatação complexa | Muitas tabelas/gráficos | Extrair texto principal |

**Teste rápido:** Abra o PDF e tente selecionar texto. Se não selecionar, é imagem.

---

### ❌ "Vídeo do YouTube não funciona"

**Checklist:**
- [ ] Vídeo é público? (privado/não listado pode não funcionar)
- [ ] Vídeo tem legendas? (automáticas ou manuais)
- [ ] Link está correto? (formato: youtube.com/watch?v=...)
- [ ] Vídeo não é live em andamento?

**Como verificar legendas:**
1. Abra o vídeo no YouTube
2. Clique no ícone CC (legendas)
3. Se não aparecer opção, não tem legendas

**Workaround:** Use ferramenta externa de transcrição (Whisper, Otter.ai) e cole como texto.

---

### ❌ "Website não carrega como source"

**Possíveis causas:**

| Causa | Solução |
|-------|---------|
| Site muito dinâmico (JavaScript) | Copiar texto manualmente |
| Paywall/login necessário | Copiar texto após login |
| Site bloqueia bots | Usar extensão de leitura ou copiar |
| URL incorreta | Verificar se é URL completa |

**Workaround universal:**
1. Abra o site
2. Selecione todo o texto relevante (Ctrl+A ou selecionar)
3. Copie (Ctrl+C)
4. No NotebookLM: Add Source → Copied Text
5. Cole e dê título descritivo

---

## Problemas com Chat

### ❌ "Respostas não fazem sentido"

**Checklist:**
- [ ] Sources corretas estão selecionadas?
- [ ] Pergunta está clara e específica?
- [ ] Informação existe nas sources?

**Dicas:**
```
❌ Ruim: "Explica"
✅ Bom: "Explique o conceito de [X] mencionado na seção [Y]"

❌ Ruim: "O que tem aí?"
✅ Bom: "Liste os 5 principais argumentos sobre [tema]"
```

---

### ❌ "NotebookLM 'inventa' informações"

**Por que acontece:** Quando você pergunta algo que não está nas sources.

**Como evitar:**
1. Pergunte apenas sobre o que está nas sources
2. Adicione "Based only on the sources provided" no prompt
3. Verifique citações (números azuis) para confirmar fonte

---

### ❌ "Limite de 50 queries atingido"

**Soluções:**
1. **Aguardar:** Limite reseta diariamente
2. **Otimizar:** Fazer perguntas mais completas (menos queries, mais informação)
3. **Múltiplas contas:** Usar conta pessoal + trabalho
4. **Upgrade:** NotebookLM Plus tem 500 queries/dia

**Dica de economia:**
```
Em vez de 5 perguntas separadas:
"Quais são os pontos principais?"
"Quem são os autores?"
"Qual a conclusão?"
"Que dados são citados?"
"Quais as recomendações?"

Faça 1 pergunta completa:
"Crie um resumo estruturado incluindo: pontos principais,
autores mencionados, conclusões, dados citados e recomendações"
```

---

## Problemas com Audio Overview

### ❌ "Audio não gera / trava"

**Checklist:**
- [ ] Pelo menos 1 source está selecionada?
- [ ] Conexão de internet estável?
- [ ] Já tentou recarregar a página?

**Tempo normal de geração:** 1-5 minutos (dependendo do volume)

**Se demorar mais de 10 minutos:**
1. Recarregue a página
2. Tente novamente
3. Se persistir, reduza número de sources

---

### ❌ "Qualidade do audio ruim"

**Possíveis causas:**

| Causa | Solução |
|-------|---------|
| Sources de baixa qualidade | Melhorar qualidade das sources |
| Muitas sources misturadas | Selecionar 3-5 sources focadas |
| Temas muito diversos | Criar notebook mais específico |

**Regra:** Garbage in, garbage out. Sources de qualidade = áudio de qualidade.

---

### ❌ "Quero audio em português"

**Situação atual:** Audio Overview só disponível em inglês.

**Workarounds:**
1. **Aceitar em inglês:** Usar como prática de listening
2. **TTS externo:** Gerar texto no chat → usar ElevenLabs/Google TTS
3. **Aguardar:** Google provavelmente adicionará mais idiomas em 2025

---

## Problemas de Performance

### ❌ "NotebookLM está lento"

**Soluções:**
1. Fechar outras abas do navegador
2. Limpar cache
3. Usar Chrome (mais otimizado)
4. Verificar conexão de internet
5. Tentar em horário de menor uso (manhã cedo)

---

### ❌ "Notebook com muitas sources fica travando"

**Recomendações:**
- Máximo recomendado: 30 sources por notebook (mesmo que limite seja 50)
- Deletar sources não usadas
- Criar notebooks separados por subtema
- Usar "notebook de síntese" (carregar resumos de outros notebooks)

---

## Problemas de Privacidade/Segurança

### ⚠️ "Posso carregar documentos confidenciais?"

**Recomendação:** NÃO carregar:
- Dados pessoais sensíveis (CPF, senhas, dados médicos)
- Documentos sob NDA restrito
- Propriedade intelectual crítica
- Informações de clientes sem consentimento

**Alternativas para dados sensíveis:**
- Usar ferramentas on-premise
- Anonimizar dados antes de carregar
- Usar apenas para documentos públicos/internos não críticos

---

## Quando Buscar Alternativas

### Use NotebookLM quando:
✅ Precisa analisar documentos específicos
✅ Quer gerar Audio Overview
✅ Trabalha com fontes definidas
✅ Precisa de citações precisas

### Use alternativas quando:

| Necessidade | Ferramenta Alternativa |
|-------------|----------------------|
| Informação em tempo real | ChatGPT, Perplexity |
| Análise de imagens | Claude, GPT-4 Vision |
| Integração com apps | Notion AI |
| Volume muito alto | Soluções enterprise |
| Dados sensíveis | Ferramentas on-premise |

---

## Contato e Suporte

### Recursos Oficiais
- **Documentação:** support.google.com/notebooklm
- **Feedback:** Dentro do app (ícone ?)
- **Status:** status.cloud.google.com

### Comunidade
- **Reddit:** r/NotebookLM
- **Twitter/X:** @NotebookLM

---

**Problema não listado?**

Tente:
1. Recarregar a página
2. Limpar cache
3. Tentar outro navegador
4. Aguardar e tentar novamente
5. Buscar na comunidade (Reddit)
