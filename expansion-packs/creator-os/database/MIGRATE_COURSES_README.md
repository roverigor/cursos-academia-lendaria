# 🚀 Migração Automática de Cursos

Script Python para migrar automaticamente todos os cursos de `outputs/courses/` para o banco Supabase.

## ⚡ Quick Start

```bash
# 1. Instalar dependências
pip install psycopg2-binary PyYAML

# 2. Configurar ambiente
source .env

# 3. Executar migração
python3 expansion-packs/creator-os/database/migrate_all_courses.py
```

## 📋 O que faz

- ✅ Detecta automaticamente todos os cursos em `outputs/courses/`
- ✅ Exclui `dominando-obsidian` (já migrado) e `no-migration`
- ✅ Lê `curriculum.yaml` de cada curso
- ✅ Cria/encontra professor no banco
- ✅ Cria projeto, outline, módulos e lições
- ✅ Linka professor a todo conteúdo
- ✅ Trata duplicatas (ON CONFLICT)

## 🎯 Cursos Detectados (6)

1. claude-code
2. didatica-lendaria
3. meu-clone-ia
4. prompt-engineer
5. supabase-zero-backend-completo
6. vibecoding

## 📊 Estrutura Gerada

```
Para cada curso:
├── Project (content_projects)
├── Outline (contents: course_outline)
└── Módulos (contents: course_module)
    └── Lições (contents: course_lesson)
```

## 🔍 Validação

```bash
# Ver resumo após migração
psql "$SUPABASE_DB_URL" << 'EOF'
SELECT
    cp.name,
    COUNT(DISTINCT CASE WHEN c.content_type = 'course_module' THEN c.id END) as modules,
    COUNT(DISTINCT CASE WHEN c.content_type = 'course_lesson' THEN c.id END) as lessons
FROM content_projects cp
LEFT JOIN contents c ON c.project_id = cp.id
GROUP BY cp.id, cp.name
ORDER BY cp.name;
EOF
```

## ⚠️ Segurança

- ✅ Usa transações (rollback em caso de erro)
- ✅ ON CONFLICT DO NOTHING (evita duplicatas)
- ✅ Commits só no final de cada curso
- ✅ Não sobrescreve conteúdo existente

## 🛠️ Troubleshooting

**Erro: psycopg2 not found**
```bash
pip install psycopg2-binary
```

**Erro: SUPABASE_DB_URL not set**
```bash
source .env
echo $SUPABASE_DB_URL  # Deve mostrar URL
```

**Curso já existe**
- Script detecta e pula (ON CONFLICT)
- Mostra aviso: "⚠ Outline exists"

## 📝 Log de Execução

O script mostra progresso em tempo real:

```
🚀 Migrating 6 courses to database...

📚 Migrating: Claude Code Mastery
  ✓ Professor: abc-123-def
  ✓ Project: xyz-789-ghi
  ✓ Outline: qwe-456-rty
  ✓ Module 1: 5 lessons
  ✓ Module 2: 4 lessons
  ✅ Total: 2 modules, 9 lessons

...

✅ Migration complete! 6 courses processed.

📊 Database Summary:
────────────────────────────────────────────────────────────
  Claude Code: 2 modules, 9 lessons
  Didática Lendária: 3 modules, 12 lessons
  ...
```

## 🔄 Re-executar

Pode executar múltiplas vezes:
- ✅ Cursos já migrados serão pulados
- ✅ Novos cursos serão detectados
- ✅ Sem risco de duplicatas

## 📦 Dependências

```txt
psycopg2-binary>=2.9.0
PyYAML>=6.0
```

## 🎓 Após Migração

Verifique no Supabase Dashboard:
1. `content_projects` - Todos os projetos criados
2. `contents` - Outline, módulos, lições
3. `content_minds` - Professores linkados

---

**Criado:** 2025-10-28
**Para:** Migração rápida de múltiplos cursos
**Tempo estimado:** ~1-2 minutos para 6 cursos
