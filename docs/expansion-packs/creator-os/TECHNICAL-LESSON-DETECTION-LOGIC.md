# Technical Lesson Detection Logic

**Purpose:** Define how the system determines if a lesson requires technical research (web fetch of documentation + community Q&A).

**Created:** 2025-10-19
**Owner:** Product Owner (Sarah)

---

## 🎯 Detection Hierarchy

```
1. Check COURSE-BRIEF → course_type field
   ├─ "technical" → ✅ ALL lessons are technical
   ├─ "conceptual" → ❌ NO lessons are technical
   └─ "mixed" → Analyze each lesson individually (proceed to step 2)

2. Check LESSON TITLE + OBJECTIVES (only if mixed)
   ├─ Contains tool/framework keywords → ✅ Technical
   ├─ Contains "install", "configure", "setup" → ✅ Technical
   └─ Generic teaching concepts → ❌ Not technical
```

---

## 📚 Examples

### Example 1: TECHNICAL Course (All Lessons Technical)

**COURSE-BRIEF.md:**
```markdown
**Tipo de Curso:**
[x] 🔧 TÉCNICO

**Ferramenta:** Supabase
```

**Result:**
- Lesson 1.1: "Introdução ao Supabase" → ✅ Technical (fetch docs)
- Lesson 1.2: "Criando Database" → ✅ Technical (fetch docs)
- Lesson 2.1: "Autenticação" → ✅ Technical (fetch docs)
- **ALL lessons** → Fetch Supabase official docs + community Q&A

---

### Example 2: CONCEPTUAL Course (No Lessons Technical)

**COURSE-BRIEF.md:**
```markdown
**Tipo de Curso:**
[x] 💡 CONCEITUAL

**Ferramenta:** (vazio)
```

**Result:**
- Lesson 1.1: "GPS - Método de Ensino" → ❌ Not technical
- Lesson 2.1: "7 Elementos Didáticos" → ❌ Not technical
- **NO lessons** → Skip web fetch (pure pedagogical content)

---

### Example 3: MIXED Course (Detect Per Lesson)

**COURSE-BRIEF.md:**
```markdown
**Tipo de Curso:**
[x] 🔀 MISTO

**Ferramenta:** ChatGPT, Obsidian
```

**Result:**
- Lesson 1.1: "Mindset para Produtividade com IA" → ❌ Not technical (conceptual)
- Lesson 2.1: "Instalando ChatGPT Desktop" → ✅ Technical (contains "instalando")
- Lesson 2.2: "Configurando Prompts no Obsidian" → ✅ Technical (tool name + config)
- Lesson 3.1: "Criando Rotina Matinal" → ❌ Not technical (soft skill)

**Detection Logic:**
- "Instalando ChatGPT" → Keyword "instalando" + tool "ChatGPT" → ✅ TECHNICAL
- "Mindset para Produtividade" → No tool keywords → ❌ NOT TECHNICAL

---

## 💻 Python Implementation

### Updated `lesson_generator.py`

```python
class LessonGenerator:
    def __init__(self, course_slug: str, brief_data: CourseBrief):
        self.course_slug = course_slug
        self.brief = brief_data

        # Cache course-level technical status
        self.course_type = brief_data.basic_info.course_type
        self.main_tool = brief_data.basic_info.tool_name


    def is_lesson_technical(self, lesson_data: dict) -> bool:
        """
        Determine if a lesson requires technical research.

        Hierarchy:
        1. If course_type = "technical" → Always True
        2. If course_type = "conceptual" → Always False
        3. If course_type = "mixed" → Analyze lesson individually

        Args:
            lesson_data: Lesson spec with title, objectives, etc.

        Returns:
            True if lesson needs technical web fetch
        """
        # Level 1: Course-wide check
        if self.course_type == "technical":
            return True  # ALL lessons in technical course are technical

        if self.course_type == "conceptual":
            return False  # NO lessons in conceptual course are technical

        # Level 2: Lesson-specific check (only for "mixed" courses)
        if self.course_type == "mixed":
            return self._detect_technical_lesson_content(lesson_data)

        # Default: fallback to content analysis
        return self._detect_technical_lesson_content(lesson_data)


    def _detect_technical_lesson_content(self, lesson_data: dict) -> bool:
        """
        Analyze lesson title/objectives to detect technical content.

        Returns:
            True if lesson appears to be about a tool/framework
        """
        # Combine title + objectives for analysis
        title = lesson_data.get('title', '').lower()
        objectives = ' '.join(lesson_data.get('objectives', [])).lower()
        full_text = f"{title} {objectives}"

        # Technical action keywords
        action_keywords = [
            'install', 'instala', 'configure', 'config',
            'setup', 'integra', 'conecta', 'deploy',
            'api', 'authentication', 'autenticação',
            'database', 'banco de dados', 'backend',
            'frontend', 'library', 'biblioteca'
        ]

        # Tool/framework names (add to this list)
        tool_keywords = [
            'supabase', 'obsidian', 'notion', 'chatgpt',
            'openai', 'claude', 'git', 'github', 'vscode',
            'python', 'javascript', 'react', 'node',
            'zapier', 'make', 'n8n', 'airtable'
        ]

        # Check for technical keywords
        for keyword in action_keywords:
            if keyword in full_text:
                return True

        # Check for tool names
        for tool in tool_keywords:
            if tool in full_text:
                return True

        # Check if main_tool from COURSE-BRIEF appears in lesson
        if self.main_tool and self.main_tool.lower() in full_text:
            return True

        return False


    async def generate_lesson(self, lesson_id: str, lesson_data: dict) -> LessonResult:
        """
        Generate a single lesson with optional technical enhancement.
        """
        # Detect if technical
        is_technical = self.is_lesson_technical(lesson_data)

        if is_technical:
            print(f"🔬 Technical lesson detected: {lesson_data['title']}")
            print(f"   Course type: {self.course_type}")
            print(f"   Main tool: {self.main_tool or 'N/A'}")

            # Fetch technical context
            technical_context = await self._fetch_technical_context(lesson_data)
            print(f"   ✅ Fetched {len(technical_context.get('official_docs', []))} docs, "
                  f"{len(technical_context.get('community_research', []))} community sources")
        else:
            print(f"💡 Conceptual lesson: {lesson_data['title']} (skipping web fetch)")
            technical_context = None

        # Generate lesson with or without technical context
        lesson_content = await self._generate_lesson_content(
            lesson_data=lesson_data,
            technical_context=technical_context
        )

        # ... rest of GPS + DL validation ...

        return lesson_result


    async def _fetch_technical_context(self, lesson_data: dict) -> dict:
        """
        Fetch official docs + community Q&A for technical lesson.

        Returns:
            {
                'official_docs': [...],
                'community_research': [...],
                'tool_version': '...'
            }
        """
        context = {
            'official_docs': [],
            'community_research': [],
            'tool_version': None
        }

        # Extract tool name (prioritize main_tool from COURSE-BRIEF)
        tool_name = self.main_tool or self._extract_tool_from_lesson(lesson_data)
        topic = lesson_data['title']

        # 1. Fetch official documentation
        docs_url = self._get_official_docs_url(tool_name)
        if docs_url:
            # WebFetch official docs
            docs_result = await self._web_fetch(
                url=docs_url,
                prompt=f"Extract documentation for '{topic}' in {tool_name}. "
                       f"Include: syntax, examples, best practices, version info."
            )
            context['official_docs'].append({
                'tool': tool_name,
                'url': docs_url,
                'content': docs_result
            })

        # 2. Fetch Stack Overflow common issues
        so_query = f"site:stackoverflow.com {tool_name} {topic}"
        so_result = await self._web_search(
            query=so_query,
            prompt="List top 5 common issues/questions with solutions"
        )
        context['community_research'].append({
            'source': 'Stack Overflow',
            'query': so_query,
            'issues': so_result
        })

        # 3. Fetch Reddit discussions
        reddit_query = f'site:reddit.com "{tool_name}" "{topic}"'
        reddit_result = await self._web_search(
            query=reddit_query,
            prompt="Extract common pain points and user tips"
        )
        context['community_research'].append({
            'source': 'Reddit',
            'query': reddit_query,
            'insights': reddit_result
        })

        return context


    def _get_official_docs_url(self, tool_name: str) -> str:
        """Map tool name to official documentation URL."""
        docs_map = {
            'supabase': 'https://supabase.com/docs',
            'obsidian': 'https://help.obsidian.md/',
            'notion': 'https://www.notion.so/help/',
            'chatgpt': 'https://platform.openai.com/docs',
            'claude': 'https://docs.anthropic.com/',
            'git': 'https://git-scm.com/doc',
            'github': 'https://docs.github.com/',
            'python': 'https://docs.python.org/',
            'javascript': 'https://developer.mozilla.org/en-US/docs/Web/JavaScript',
            'react': 'https://react.dev/',
            'zapier': 'https://zapier.com/help',
            'make': 'https://www.make.com/en/help',
        }
        return docs_map.get(tool_name.lower(), '')
```

---

## 🔄 Complete Workflow Example

### Scenario: "Curso de Supabase"

**COURSE-BRIEF.md:**
```markdown
**Tipo de Curso:** [x] 🔧 TÉCNICO
**Ferramenta:** Supabase
```

**Lesson Generation:**

```
Lesson 1.1: "Introdução ao Supabase"
  ↓
Check: course_type = "technical" → ✅ TRUE
  ↓
Web Fetch:
  - https://supabase.com/docs/introduction
  - Stack Overflow: "supabase introduction common issues"
  - Reddit: r/Supabase "getting started"
  ↓
Context Injected:
  - Official docs: "Supabase is an open source Firebase alternative..."
  - Common issue #1: "Can't connect to database" → Solution: Check API keys
  - Reddit tip: "Use Row Level Security from day 1"
  ↓
Generate Lesson:
  - GPS framework ✅
  - Didática Lendária ✅
  - Technical accuracy ✅ (from docs)
  - Troubleshooting section ✅ (from community)
  ↓
Validate:
  - GPS score: 30/30 ✅
  - DL score: 85/100 ✅
  - Technical checklist: PASS ✅
    - [x] Official docs cited
    - [x] Version specified (from docs)
    - [x] Common issues addressed
    - [x] Troubleshooting included
  ↓
✅ Save lesson
```

---

## 📋 Summary Table

| Course Type | Lesson Analysis | Web Fetch? | Example |
|-------------|----------------|------------|---------|
| **TÉCNICO** | N/A (all are technical) | ✅ YES (ALL lessons) | "Curso de Supabase" |
| **CONCEITUAL** | N/A (none are technical) | ❌ NO (NO lessons) | "Didática Lendária" |
| **MISTO** | Per-lesson keyword detection | ✅ CONDITIONAL (only technical lessons) | "Produtividade com IA" |

---

## 🎯 Key Benefits

1. **User Control:** Course creator marks course type in COURSE-BRIEF
2. **Smart Detection:** System auto-detects mixed scenarios
3. **Efficiency:** Avoids unnecessary web fetches for conceptual content
4. **Accuracy:** Technical lessons get latest docs + community insights
5. **Transparency:** Logs show exactly why/when web fetch happens

---

**Status:** ✅ Ready for Implementation
**Next Step:** Create Story 4.6 with this logic
