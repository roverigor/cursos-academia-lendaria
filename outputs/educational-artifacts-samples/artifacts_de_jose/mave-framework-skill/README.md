# 🎨 MAVE Framework - Agent Skill

**Método Amorim de Visualização Educacional**

Uma skill completa para democratizar conhecimento técnico através de experiências visuais, interativas e memoráveis.

## 📦 Conteúdo da Skill

```
mave-framework-skill/
├── SKILL.md                    # Documentação principal da skill
├── README.md                   # Este arquivo
├── metaforas.md                # Biblioteca de metáforas testadas
├── animacoes.md                # Padrões de animação temporal
├── layouts.md                  # Guia de visualização espacial
├── interatividade.md           # Tipos de interação
├── design-system.md            # Design system completo
├── casos-de-uso.md             # Exemplos reais de aplicação
├── scripts.md                  # Documentação dos scripts
├── gerar_metafora.py           # Script para sugerir metáforas
├── validar_cores.js            # Script para validar paleta
└── analisar_complexidade.sh    # Script para análise de complexidade
```

## 🚀 Instalação

### Claude.ai (Web)
1. Vá em Settings > Capabilities
2. Clique em "Upload Custom Skill"
3. Selecione a pasta `mave-framework-skill/`
4. Skill será ativada automaticamente

### Claude Code (CLI)
```bash
/plugin install mave-framework@local path/to/mave-framework-skill/
```

### API
```python
import anthropic

client = anthropic.Anthropic(api_key="your-api-key")

message = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4000,
    skills=["mave-framework"],
    messages=[
        {"role": "user", "content": "Como explicar APIs para não-técnicos?"}
    ]
)
```

## 💡 Quando Usar Esta Skill

Use a skill MAVE Framework quando precisar:

- ✅ Explicar conceitos técnicos para públicos não-técnicos
- ✅ Criar materiais educacionais visuais
- ✅ Desenvolver documentação interativa
- ✅ Transformar whitepapers em experiências
- ✅ Criar demos e POCs educacionais
- ✅ Onboarding de novos membros da equipe
- ✅ Apresentações para stakeholders

## 🎯 Os 4 Pilares MAVE

1. **M - Metáfora Universal**: Conecta desconhecido ao conhecido
2. **A - Animação Temporal**: Revela complexidade progressivamente
3. **V - Visualização Espacial**: Layout com significado semântico
4. **E - Experimentação Ativa**: Aprendizagem interativa

## 🔧 Scripts Incluídos

### Gerador de Metáforas
```bash
python gerar_metafora.py "Skills System"
```
Sugere 5 metáforas do cotidiano baseadas na estrutura do conceito.

### Validador de Paleta
```bash
node validar_cores.js arquivo.html
```
Verifica se as cores seguem o design system minimal-brand.

### Analisador de Complexidade
```bash
bash analisar_complexidade.sh conceito.md
```
Calcula score e sugere quantas camadas de progressive disclosure usar.

## 📚 Exemplos de Uso

### Exemplo 1: Explicar API REST
```
Você: "Preciso explicar API REST para o time de marketing"

Claude: [ativa mave-framework]
Vou usar a metáfora do Garçom:
- Cliente (App) → Garçom (API) → Cozinha (Backend)
- Pedido → Request
- Prato → Response
...
```

### Exemplo 2: Criar Documentação
```
Você: "Crie documentação visual para nosso sistema de Skills"

Claude: [ativa mave-framework]
Usando MAVE Framework:
M - Chef de restaurante
A - 5 camadas de revelação
V - Grid 2 colunas (Cozinha | Cliente)
E - Chat + toggles interativos
...
```

## 🎨 Design System Incluído

A skill inclui design system completo:
- Paleta de cores minimal-brand
- Tipografia (Lora + Poppins)
- Componentes (cards, botões, forms)
- Animações e transições
- Layouts responsivos

## ✅ Checklist de Qualidade

Toda experiência criada com MAVE deve ter:
- [ ] Metáfora do cotidiano universal
- [ ] Revelação progressiva (2-7 camadas)
- [ ] Layout com significado espacial
- [ ] Elementos interativos
- [ ] Design minimal-brand
- [ ] Transição metáfora → código

## 📖 Documentação Completa

Leia `SKILL.md` para documentação completa incluindo:
- Filosofia do framework
- Guias detalhados de cada pilar
- Anti-padrões a evitar
- Casos de uso reais
- Princípios pedagógicos

## 🤝 Contribuindo

Esta skill foi desenvolvida por José Carlos Amorim e está em constante evolução.

Para contribuir:
1. Teste a skill em seus casos de uso
2. Documente novas metáforas que funcionaram
3. Compartilhe exemplos de aplicação
4. Sugira melhorias nos scripts

## 📝 Changelog

### v1.0.0 (Outubro 2025)
- ✨ Lançamento inicial
- 📚 Biblioteca com 12 metáforas testadas
- 🎨 Design system minimal-brand completo
- 🔧 3 scripts auxiliares (Python, Node.js, Bash)
- 📖 Documentação completa em 8 arquivos

## 📄 Licença

MIT License - Livre para uso pessoal e comercial.

---

**Desenvolvido por José Carlos Amorim - O Tradutor Apaixonado**  
*Democratizando conhecimento, uma experiência por vez* 🎨✨
