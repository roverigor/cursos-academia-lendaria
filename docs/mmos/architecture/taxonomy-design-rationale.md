# Taxonomy Design Rationale: Normalized vs Denormalized

**Question:** Por que usar 4 tabelas separadas ao invés de 1 tabela com subassociações JSON?

---

## Opção 1: Tabela Única (Denormalizada)

### Schema

```sql
CREATE TABLE taxonomy (
    id TEXT PRIMARY KEY,
    type TEXT NOT NULL,  -- 'domain', 'specialization', 'skill', 'proficiency'
    name TEXT NOT NULL,
    description TEXT,
    parent_id TEXT,      -- Reference to parent
    hierarchy JSON,      -- Full path: ['business', 'entrepreneur', 'business_strategy', 'market_analysis']
    metadata JSON,       -- All additional data
    sort_order INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Exemplo de Dados

```sql
INSERT INTO taxonomy VALUES
-- Domain
('business_entrepreneurship', 'domain', 'Business & Entrepreneurship', '...', NULL, '["business_entrepreneurship"]', '{"icon": "💼"}', 1, '2025-10-12'),

-- Specialization
('entrepreneur', 'specialization', 'Entrepreneur', '...', 'business_entrepreneurship', '["business_entrepreneurship", "entrepreneur"]', '{"icon": "🚀"}', 1, '2025-10-12'),

-- Skill
('business_strategy', 'skill', 'Business Strategy', '...', 'entrepreneur', '["business_entrepreneurship", "entrepreneur", "business_strategy"]', '{}', 1, '2025-10-12'),

-- Proficiency
('market_analysis', 'proficiency', 'Market Analysis', '...', 'business_strategy', '["business_entrepreneurship", "entrepreneur", "business_strategy", "market_analysis"]', '{}', 1, '2025-10-12');
```

### Queries com Tabela Única

```sql
-- Buscar todos os proficiencies de um domain
SELECT * FROM taxonomy
WHERE type = 'proficiency'
  AND json_extract(hierarchy, '$[0]') = 'business_entrepreneurship';

-- Buscar hierarquia completa de um proficiency
WITH RECURSIVE hierarchy_tree AS (
    SELECT * FROM taxonomy WHERE id = 'market_analysis'
    UNION ALL
    SELECT t.* FROM taxonomy t
    JOIN hierarchy_tree h ON t.id = h.parent_id
)
SELECT * FROM hierarchy_tree ORDER BY type;

-- Buscar todos os skills de uma specialization
SELECT * FROM taxonomy
WHERE type = 'skill'
  AND parent_id = 'entrepreneur';
```

---

## Opção 2: Tabelas Normalizadas (Atual)

### Schema

```sql
CREATE TABLE domains (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    icon TEXT,
    sort_order INTEGER
);

CREATE TABLE specializations (
    id TEXT PRIMARY KEY,
    domain_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    icon TEXT,
    sort_order INTEGER,
    FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE
);

CREATE TABLE skills (
    id TEXT PRIMARY KEY,
    specialization_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    sort_order INTEGER,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id) ON DELETE CASCADE
);

CREATE TABLE proficiencies (
    id TEXT PRIMARY KEY,
    skill_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    sort_order INTEGER,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);
```

### Queries com Tabelas Normalizadas

```sql
-- Buscar todos os proficiencies de um domain
SELECT p.*
FROM proficiencies p
JOIN skills s ON p.skill_id = s.id
JOIN specializations sp ON s.specialization_id = sp.id
JOIN domains d ON sp.domain_id = d.id
WHERE d.id = 'business_entrepreneurship';

-- Buscar hierarquia completa de um proficiency
SELECT
    d.name AS domain,
    sp.name AS specialization,
    s.name AS skill,
    p.name AS proficiency
FROM proficiencies p
JOIN skills s ON p.skill_id = s.id
JOIN specializations sp ON s.specialization_id = sp.id
JOIN domains d ON sp.domain_id = d.id
WHERE p.id = 'market_analysis';

-- Buscar todos os skills de uma specialization
SELECT * FROM skills
WHERE specialization_id = 'entrepreneur';
```

---

## Comparação Detalhada

### 1. **Performance**

| Operação | Tabela Única | Normalizadas | Vencedor |
|----------|--------------|--------------|----------|
| Buscar 1 nível (ex: skills de specialization) | `WHERE parent_id = 'X'`<br/>**Rápido** | `WHERE specialization_id = 'X'`<br/>**Rápido** | **Empate** |
| Buscar N níveis (ex: todos proficiencies de domain) | `WHERE json_extract(hierarchy, '$[0]') = 'X'`<br/>**Lento** (full scan + JSON parse) | `JOIN` em 3 tabelas<br/>**Rápido** (indexed JOINs) | **Normalizadas** ✅ |
| Contagem por tipo | `WHERE type = 'skill'`<br/>**OK** (indexed) | `SELECT COUNT(*) FROM skills`<br/>**Muito rápido** (table scan) | **Normalizadas** ✅ |
| Inserção | 1 INSERT | 1 INSERT | **Empate** |
| Validação de hierarquia | Manual (check hierarchy JSON) | Automático (foreign keys) | **Normalizadas** ✅ |

**SQLite Query Planner:**

```sql
-- Tabela única (slow)
EXPLAIN QUERY PLAN
SELECT * FROM taxonomy
WHERE json_extract(hierarchy, '$[0]') = 'business_entrepreneurship';
-- Result: SCAN TABLE taxonomy (~519 rows)

-- Normalizada (fast)
EXPLAIN QUERY PLAN
SELECT p.* FROM proficiencies p
JOIN skills s ON p.skill_id = s.id
JOIN specializations sp ON s.specialization_id = sp.id
WHERE sp.domain_id = 'business_entrepreneurship';
-- Result: INDEX lookups (~50 rows)
```

---

### 2. **Integridade de Dados**

| Aspecto | Tabela Única | Normalizadas | Vencedor |
|---------|--------------|--------------|----------|
| **Referential Integrity** | ❌ Manual<br/>`parent_id` pode referenciar ID inexistente | ✅ Automático<br/>`FOREIGN KEY` com `ON DELETE CASCADE` | **Normalizadas** ✅ |
| **Type Safety** | ❌ Manual<br/>`type` pode ter typo ('skil' vs 'skill') | ✅ Automático<br/>Impossível inserir skill sem specialization | **Normalizadas** ✅ |
| **Hierarchy Validation** | ❌ Manual<br/>Precisa validar que skill tem specialization como parent | ✅ Automático<br/>Schema garante hierarquia correta | **Normalizadas** ✅ |
| **Orphan Prevention** | ❌ Possível<br/>Deletar domain não deleta children | ✅ Impossível<br/>`ON DELETE CASCADE` cuida disso | **Normalizadas** ✅ |

**Exemplo de Problema com Tabela Única:**

```sql
-- ❌ BAD: Tabela única permite isso
INSERT INTO taxonomy VALUES ('market_analysis', 'proficiency', 'Market Analysis', NULL, 'wrong_parent_id', ...);
-- Aceita! Mas 'wrong_parent_id' não existe

-- ✅ GOOD: Normalizadas previnem isso
INSERT INTO proficiencies (id, skill_id, name) VALUES ('market_analysis', 'wrong_skill_id', 'Market Analysis');
-- ERROR: FOREIGN KEY constraint failed
```

---

### 3. **Queries Complexas**

#### Caso 1: Scoring Aggregation

**Requirement:** Calcular score médio de um mind em um domain (agregando todos proficiencies)

```sql
-- ❌ Tabela Única (complexo)
WITH proficiency_scores AS (
    SELECT ms.mind_id, ms.score, t.hierarchy
    FROM mind_scores ms
    JOIN taxonomy t ON ms.proficiency_id = t.id
    WHERE t.type = 'proficiency'
)
SELECT
    mind_id,
    AVG(score) AS domain_avg_score
FROM proficiency_scores
WHERE json_extract(hierarchy, '$[0]') = 'business_entrepreneurship'
GROUP BY mind_id;

-- ✅ Normalizadas (simples)
SELECT
    ms.mind_id,
    AVG(ms.score) AS domain_avg_score
FROM mind_scores ms
JOIN proficiencies p ON ms.proficiency_id = p.id
JOIN skills s ON p.skill_id = s.id
JOIN specializations sp ON s.specialization_id = sp.id
WHERE sp.domain_id = 'business_entrepreneurship'
GROUP BY ms.mind_id;
```

#### Caso 2: Recommendation Engine

**Requirement:** Encontrar melhor mind para cada skill em um domain

```sql
-- ❌ Tabela Única (muito complexo)
WITH skills_in_domain AS (
    SELECT id FROM taxonomy
    WHERE type = 'skill'
      AND json_extract(hierarchy, '$[0]') = 'business_entrepreneurship'
),
proficiencies_in_skills AS (
    SELECT t.id, t.parent_id AS skill_id
    FROM taxonomy t
    WHERE t.type = 'proficiency'
      AND t.parent_id IN (SELECT id FROM skills_in_domain)
),
scores AS (
    SELECT p.skill_id, ms.mind_id, AVG(ms.score) AS avg_score
    FROM mind_scores ms
    JOIN proficiencies_in_skills p ON ms.proficiency_id = p.id
    GROUP BY p.skill_id, ms.mind_id
)
SELECT skill_id, mind_id, avg_score
FROM (
    SELECT *, RANK() OVER (PARTITION BY skill_id ORDER BY avg_score DESC) AS rank
    FROM scores
)
WHERE rank = 1;

-- ✅ Normalizadas (limpo)
WITH skill_scores AS (
    SELECT
        s.id AS skill_id,
        s.name AS skill_name,
        ms.mind_id,
        AVG(ms.score) AS avg_score
    FROM skills s
    JOIN specializations sp ON s.specialization_id = sp.id
    JOIN proficiencies p ON p.skill_id = s.id
    JOIN mind_scores ms ON ms.proficiency_id = p.id
    WHERE sp.domain_id = 'business_entrepreneurship'
    GROUP BY s.id, ms.mind_id
)
SELECT skill_id, skill_name, mind_id, avg_score
FROM (
    SELECT *, RANK() OVER (PARTITION BY skill_id ORDER BY avg_score DESC) AS rank
    FROM skill_scores
)
WHERE rank = 1;
```

---

### 4. **Manutenção e Evolução**

| Cenário | Tabela Única | Normalizadas | Vencedor |
|---------|--------------|--------------|----------|
| **Adicionar campo em Skill** | Adicionar coluna na tabela única<br/>❌ Afeta todos types | Adicionar coluna só em `skills`<br/>✅ Isolado | **Normalizadas** ✅ |
| **Renomear Specialization** | `UPDATE taxonomy SET name = 'X' WHERE id = 'Y'`<br/>✅ Simples | `UPDATE specializations SET name = 'X' WHERE id = 'Y'`<br/>✅ Simples | **Empate** |
| **Mover Skill para outra Specialization** | `UPDATE taxonomy SET parent_id = 'new_parent'`<br/>❌ Risco de quebrar hierarquia | `UPDATE skills SET specialization_id = 'new_parent'`<br/>✅ Foreign key valida | **Normalizadas** ✅ |
| **Adicionar novo nível (ex: sub-proficiency)** | Adicionar novo `type` = 'sub_proficiency'<br/>❌ Schema confuso | Criar nova tabela `sub_proficiencies`<br/>✅ Schema claro | **Normalizadas** ✅ |
| **Deletar Domain** | `DELETE FROM taxonomy WHERE id = 'X'`<br/>❌ Orphans ficam | `DELETE FROM domains WHERE id = 'X'`<br/>✅ CASCADE deleta tudo | **Normalizadas** ✅ |

---

### 5. **Tamanho do Banco**

```sql
-- Tabela Única (aproximado)
-- Cada row: ~200 bytes (id, type, name, description, parent_id, hierarchy JSON, metadata JSON)
-- 6 domains + 22 specs + 78 skills + 413 proficiencies = 519 rows
-- Total: 519 * 200 bytes = 104KB

-- Normalizadas (aproximado)
-- Domains: 6 * 100 bytes = 0.6KB
-- Specializations: 22 * 120 bytes = 2.6KB
-- Skills: 78 * 100 bytes = 7.8KB
-- Proficiencies: 413 * 100 bytes = 41.3KB
-- Total: ~52KB

-- Vencedor: Normalizadas (50% menor!)
```

**Por quê?**
- Tabela única duplica informações (hierarchy JSON repete parent IDs)
- Tabela única tem overhead de `type` field (repetido 401 vezes)
- Normalizadas removem redundância

---

### 6. **Developer Experience**

#### A. Type Safety (com TypeScript/Python)

```typescript
// ❌ Tabela Única
interface TaxonomyItem {
    id: string;
    type: 'domain' | 'specialization' | 'skill' | 'proficiency'; // Manual check
    name: string;
    parent_id?: string; // May or may not exist
    hierarchy: string[]; // Could be wrong
}

// Query retorna generic TaxonomyItem - precisa type checking manual
const item = await db.query('SELECT * FROM taxonomy WHERE id = ?', [id]);
if (item.type !== 'proficiency') throw new Error('Expected proficiency');

// ✅ Normalizadas
interface Domain { id: string; name: string; icon: string; }
interface Specialization { id: string; domain_id: string; name: string; }
interface Skill { id: string; specialization_id: string; name: string; }
interface Proficiency { id: string; skill_id: string; name: string; }

// Query retorna tipo específico - type safe!
const proficiency: Proficiency = await db.proficiencies.findById(id);
// TypeScript knows this is a Proficiency, não precisa check
```

#### B. ORM Support

```python
# ❌ Tabela Única - ORM genérico
class Taxonomy(Base):
    __tablename__ = 'taxonomy'
    id = Column(String, primary_key=True)
    type = Column(String, nullable=False)
    name = Column(String, nullable=False)
    parent_id = Column(String, nullable=True)
    # ... fields misturados para todos types

# Query confusa
skills = session.query(Taxonomy).filter(Taxonomy.type == 'skill').all()

# ✅ Normalizadas - ORM específico
class Domain(Base):
    __tablename__ = 'domains'
    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    icon = Column(String)
    specializations = relationship('Specialization', back_populates='domain')

class Specialization(Base):
    __tablename__ = 'specializations'
    id = Column(String, primary_key=True)
    domain_id = Column(String, ForeignKey('domains.id'), nullable=False)
    name = Column(String, nullable=False)
    domain = relationship('Domain', back_populates='specializations')
    skills = relationship('Skill', back_populates='specialization')

# Query clara e type-safe
skills = session.query(Skill).filter(Skill.specialization_id == 'entrepreneur').all()
# IDE autocompleta: skill.name, skill.specialization.name, skill.specialization.domain.name
```

---

### 7. **Indexing e Otimização**

```sql
-- ❌ Tabela Única - Indexes complexos
CREATE INDEX idx_taxonomy_type ON taxonomy(type);
CREATE INDEX idx_taxonomy_parent ON taxonomy(parent_id);
CREATE INDEX idx_taxonomy_hierarchy ON taxonomy(json_extract(hierarchy, '$[0]')); -- SQLite limitation!

-- Query usa multiple indexes (slower)
EXPLAIN QUERY PLAN SELECT * FROM taxonomy WHERE type = 'proficiency' AND parent_id = 'X';
-- SCAN TABLE taxonomy USING INDEX idx_taxonomy_parent

-- ✅ Normalizadas - Indexes diretos
CREATE INDEX idx_specializations_domain ON specializations(domain_id);
CREATE INDEX idx_skills_specialization ON skills(specialization_id);
CREATE INDEX idx_proficiencies_skill ON proficiencies(skill_id);

-- Query usa index direto (faster)
EXPLAIN QUERY PLAN SELECT * FROM proficiencies WHERE skill_id = 'X';
-- SEARCH TABLE proficiencies USING INDEX idx_proficiencies_skill
```

---

## Quando Tabela Única Faria Sentido?

### Cenários Válidos:

1. **Hierarquia Desconhecida**
   - Se você não sabe quantos níveis terá (pode ser 3, pode ser 10)
   - Ex: comentários aninhados (reddit-style)

2. **Schema Extremamente Flexível**
   - Cada item pode ter campos completamente diferentes
   - Ex: CMS com tipos de conteúdo totalmente customizáveis

3. **Hierarquia Muito Simples**
   - Apenas 1-2 níveis
   - Ex: categorias e subcategorias de blog

4. **Leituras Extremamente Simples**
   - Só precisa buscar itens de 1 nível por vez
   - Nunca faz aggregations ou queries complexas

### MMOS Não Se Encaixa Nesses Cenários:

```
❌ Hierarquia conhecida: sempre 4 níveis (domain → spec → skill → prof)
❌ Schema fixo: todos os níveis têm mesma estrutura (id, name, description)
❌ Queries complexas: agregações, scoring, recommendations
❌ Integridade crítica: não podemos ter hierarquia quebrada
```

---

## Decisão Final para MMOS

### ✅ Usar 4 Tabelas Normalizadas

**Razões:**

1. **Performance**: JOINs indexados > JSON parsing
2. **Integridade**: Foreign keys previnem dados inconsistentes
3. **Queries**: Muito mais simples e legíveis
4. **Type Safety**: ORM e TypeScript funcionam melhor
5. **Manutenção**: Mudanças isoladas por nível
6. **Indexing**: Indexes diretos são mais eficientes
7. **Tamanho**: 50% menor (sem redundância)

**Trade-off Aceitável:**

- ❌ Mais tabelas para gerenciar (4 vs 1)
  - ✅ Mas frameworks (SQLAlchemy, Prisma) abstraem isso
- ❌ JOINs em queries
  - ✅ Mas JOINs indexados são rápidos em SQLite
- ❌ Seed data mais verboso
  - ✅ Mas só precisa rodar 1x, e é gerado programaticamente

---

## Comparação Prática: Query Real

### Caso de Uso: "Encontrar top 5 minds para copywriting"

```sql
-- ❌ TABELA ÚNICA (difícil de ler, lento)
WITH copywriting_proficiencies AS (
    SELECT t.id
    FROM taxonomy t
    WHERE t.type = 'proficiency'
      AND t.parent_id IN (
          SELECT id FROM taxonomy
          WHERE type = 'skill'
            AND parent_id = 'copywriter'
      )
)
SELECT
    m.display_name,
    AVG(ms.score) AS avg_score
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
WHERE ms.proficiency_id IN (SELECT id FROM copywriting_proficiencies)
GROUP BY m.id
ORDER BY avg_score DESC
LIMIT 5;

-- ✅ NORMALIZADAS (claro, rápido)
SELECT
    m.display_name,
    AVG(ms.score) AS avg_score
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN proficiencies p ON ms.proficiency_id = p.id
JOIN skills s ON p.skill_id = s.id
WHERE s.specialization_id = 'copywriter'
GROUP BY m.id
ORDER BY avg_score DESC
LIMIT 5;

-- Resultado:
-- Alex Hormozi (95), Eugene Schwartz (94), Dan Kennedy (92)...
```

---

## Conclusão

Para o MMOS, **4 tabelas normalizadas são objetivamente melhores** porque:

1. Hierarquia é conhecida e fixa (4 níveis sempre)
2. Queries complexas são frequentes (scoring, recommendations)
3. Integridade de dados é crítica (não podemos ter hierarquia quebrada)
4. Performance importa (queries devem ser <100ms)
5. Developer experience importa (type safety, ORM support)

**A única vantagem da tabela única seria simplicidade inicial**, mas essa vantagem desaparece rapidamente quando você começa a fazer queries complexas.

---

**Analogia:** É como organizar livros:

- **Tabela única** = Todos os livros em uma pilha gigante, com etiquetas "ficção", "não-ficção", "técnico", "infantil"
- **Tabelas normalizadas** = Estantes separadas por categoria, com prateleiras organizadas

Quando você tem 10 livros, pilha funciona. Quando tem 413, precisa de estantes! 📚

---

**END OF DOCUMENT**
