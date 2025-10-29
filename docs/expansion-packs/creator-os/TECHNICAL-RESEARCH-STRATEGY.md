# Technical Research Strategy - Complete Implementation

**Purpose:** Define how to dynamically discover and fetch technical documentation for ANY tool/framework, without hardcoded URLs.

**Created:** 2025-10-19
**Status:** Complete Strategy (Ready for Implementation)

---

## 🎯 Core Principles

1. **Zero Hardcoding** - No URLs in code, everything discovered dynamically
2. **Cache for Performance** - Once found, cache for future use
3. **Graceful Fallbacks** - Handle edge cases (no docs, login-required, etc.)
4. **Multi-Source** - Official docs + Community Q&A
5. **Version-Aware** - Get latest stable version docs
6. **Language-Aware** - Match course language when possible

---

## 🔍 Step-by-Step Research Process

### **Step 1: Discover Official Documentation URL**

**Input:** `tool_name = "Supabase"`, `topic = "Authentication"`

**Process:**

```python
async def discover_official_docs_url(self, tool_name: str) -> dict:
    """
    Dynamically discover official documentation URL via web search.

    Returns:
        {
            'url': 'https://supabase.com/docs',
            'confidence': 'high',  # high/medium/low
            'source': 'web_search',
            'verified': True
        }
    """

    # 1. Check cache first (performance)
    cached = self._check_cache(tool_name)
    if cached:
        return cached

    # 2. Web search for official docs
    search_query = f"{tool_name} official documentation site"

    search_results = await self.web_search(
        query=search_query,
        prompt=f"""
        Find the official documentation URL for {tool_name}.

        Requirements:
        - Must be from the OFFICIAL website (e.g., supabase.com, NOT medium.com)
        - Must be the main documentation homepage (e.g., /docs or /documentation)
        - If multiple versions exist, return LATEST STABLE version
        - Prefer English docs unless tool is non-English (e.g., Japanese tool)

        Return format:
        {{
            "url": "https://...",
            "confidence": "high|medium|low",
            "reasoning": "why this is the official docs"
        }}
        """
    )

    # 3. Parse response
    docs_info = json.loads(search_results)

    # 4. Validate URL (is it reachable? looks like docs?)
    is_valid = await self._validate_docs_url(docs_info['url'])

    if not is_valid:
        # Fallback: ask LLM directly
        docs_info = await self._ask_llm_for_docs_url(tool_name)

    # 5. Cache result
    self._cache_docs_url(tool_name, docs_info)

    return docs_info
```

**Example Output:**
```json
{
  "url": "https://supabase.com/docs",
  "confidence": "high",
  "source": "web_search",
  "verified": true,
  "domain": "supabase.com",
  "last_checked": "2025-10-19T10:30:00Z"
}
```

---

### **Step 2: Fetch Relevant Documentation Section**

**Input:** `docs_url = "https://supabase.com/docs"`, `topic = "Authentication"`

**Process:**

```python
async def fetch_docs_for_topic(self, docs_url: str, topic: str, tool_name: str) -> dict:
    """
    Fetch specific documentation section for the lesson topic.

    Strategy:
    1. Try to find topic-specific page first
    2. If not found, fetch general docs and extract relevant section
    """

    # 1. Search within docs site for specific topic
    topic_search_query = f"site:{docs_url} {topic}"

    topic_results = await self.web_search(
        query=topic_search_query,
        prompt=f"Find the documentation page about '{topic}' in {tool_name} docs. Return the URL."
    )

    # 2. Fetch the specific page
    if topic_results and "http" in topic_results:
        specific_url = topic_results.strip()

        docs_content = await self.web_fetch(
            url=specific_url,
            prompt=f"""
            Extract documentation content about: {topic}

            Include:
            - Key concepts and definitions
            - Code examples and syntax
            - Configuration options
            - Best practices
            - Common pitfalls or gotchas
            - Current version information

            Format as structured markdown.
            """
        )
    else:
        # Fallback: fetch main docs page
        docs_content = await self.web_fetch(
            url=docs_url,
            prompt=f"Extract information about {topic} from this documentation."
        )

    return {
        'url': specific_url or docs_url,
        'topic': topic,
        'content': docs_content,
        'fetched_at': datetime.now().isoformat()
    }
```

**Example Output:**
```markdown
# Supabase Authentication Documentation

**URL:** https://supabase.com/docs/guides/auth

**Version:** 2.38.0 (Current Stable)

## Key Concepts

Authentication in Supabase supports:
- Email/Password
- Magic Links
- OAuth (Google, GitHub, etc.)
- Phone/SMS

## Code Example

```javascript
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'secure-password'
})
```

## Configuration

Set in your Supabase dashboard under Authentication → Settings.

## Best Practices

1. Always enable Row Level Security (RLS)
2. Use email confirmation in production
3. Implement password strength validation

## Common Issues

- "Invalid login credentials" → Check email confirmation status
- CORS errors → Add your domain to allowed origins in dashboard

## Version Notes

Feature available since: v2.0.0
Latest update: v2.38.0 (October 2025)
```

---

### **Step 3: Discover Community Sources**

**Input:** `tool_name = "Supabase"`

**Process:**

```python
async def discover_community_sources(self, tool_name: str) -> dict:
    """
    Dynamically discover where the community discusses this tool.

    Returns URLs for:
    - Stack Overflow tags
    - Reddit subreddits
    - GitHub repos
    - Discord/Slack (if public)
    """

    # 1. Search for Stack Overflow tag
    so_query = f"site:stackoverflow.com {tool_name}"

    so_tag = await self.web_search(
        query=so_query,
        prompt=f"What is the Stack Overflow tag for {tool_name}? Return ONLY the tag name."
    )
    # Result: "supabase"

    # 2. Search for Reddit community
    reddit_query = f'site:reddit.com "{tool_name}" subreddit'

    subreddit = await self.web_search(
        query=reddit_query,
        prompt=f"What is the main subreddit for {tool_name}? Return format: r/SubredditName"
    )
    # Result: "r/Supabase"

    # 3. Search for official GitHub repo
    github_query = f"site:github.com {tool_name} official repository"

    github_repo = await self.web_search(
        query=github_query,
        prompt=f"What is the official GitHub repository for {tool_name}? Return URL."
    )
    # Result: "https://github.com/supabase/supabase"

    return {
        'stack_overflow': {
            'tag': so_tag.strip(),
            'url': f"https://stackoverflow.com/questions/tagged/{so_tag.strip()}"
        },
        'reddit': {
            'subreddit': subreddit.strip(),
            'url': f"https://reddit.com/{subreddit.strip()}"
        },
        'github': {
            'url': github_repo.strip(),
            'issues_url': f"{github_repo.strip()}/issues"
        }
    }
```

**Example Output:**
```json
{
  "stack_overflow": {
    "tag": "supabase",
    "url": "https://stackoverflow.com/questions/tagged/supabase"
  },
  "reddit": {
    "subreddit": "r/Supabase",
    "url": "https://reddit.com/r/Supabase"
  },
  "github": {
    "url": "https://github.com/supabase/supabase",
    "issues_url": "https://github.com/supabase/supabase/issues"
  }
}
```

---

### **Step 4: Fetch Community Q&A**

**Input:** `topic = "Authentication"`, `community_sources = {...}`

**Process:**

```python
async def fetch_community_qa(self, topic: str, tool_name: str, community_sources: dict) -> dict:
    """
    Fetch common issues, solutions, and tips from community sources.
    """

    qa_data = {
        'stack_overflow': [],
        'reddit': [],
        'github': []
    }

    # 1. Stack Overflow
    so_tag = community_sources['stack_overflow']['tag']
    so_query = f"site:stackoverflow.com [{so_tag}] {topic}"

    so_results = await self.web_search(
        query=so_query,
        prompt=f"""
        Find top 5 questions about '{topic}' in {tool_name} on Stack Overflow.

        For each question, extract:
        - Question title
        - Main problem/error
        - Accepted solution (if exists)
        - Vote count (to prioritize popular issues)

        Return as JSON array.
        """
    )
    qa_data['stack_overflow'] = json.loads(so_results)

    # 2. Reddit
    subreddit = community_sources['reddit']['subreddit']
    reddit_query = f'site:reddit.com/{subreddit} "{topic}"'

    reddit_results = await self.web_search(
        query=reddit_query,
        prompt=f"""
        Find top discussions about '{topic}' in {tool_name} on Reddit.

        Extract:
        - Common pain points mentioned
        - Pro tips from experienced users
        - Gotchas or warnings

        Summarize in bullet points.
        """
    )
    qa_data['reddit'] = reddit_results

    # 3. GitHub Issues (optional, if relevant)
    github_url = community_sources['github']['issues_url']
    github_query = f"site:github.com {tool_name} {topic} is:issue"

    github_results = await self.web_search(
        query=github_query,
        prompt=f"""
        Find common issues related to '{topic}' in {tool_name} GitHub issues.

        Focus on:
        - Bug reports that users frequently encounter
        - Feature requests related to this topic
        - Workarounds mentioned in issue comments

        Return top 3 most relevant.
        """
    )
    qa_data['github'] = github_results

    return qa_data
```

**Example Output:**
```json
{
  "stack_overflow": [
    {
      "title": "Supabase authentication not working after signup",
      "problem": "User can sign up but can't log in immediately",
      "solution": "Enable email confirmation in dashboard settings",
      "votes": 47
    },
    {
      "title": "How to implement Google OAuth in Supabase?",
      "problem": "Confused about OAuth setup process",
      "solution": "Need to configure OAuth provider in Supabase dashboard first",
      "votes": 32
    }
  ],
  "reddit": {
    "pain_points": [
      "Email confirmation emails going to spam",
      "CORS issues when testing locally",
      "Confusion between Auth and Database permissions"
    ],
    "pro_tips": [
      "Always test with email confirmation OFF in dev, ON in prod",
      "Use anon key for client, service_role key for server only",
      "Row Level Security policies are separate from Auth"
    ]
  },
  "github": [
    {
      "issue": "#1234 - Auth session not persisting on refresh",
      "workaround": "Use supabase.auth.getSession() instead of getUser()"
    }
  ]
}
```

---

## 🛡️ Edge Case Handling

### **Case 1: Documentation Not Found**

```python
if not docs_url or docs_url == "not_found":
    # Fallback strategy
    fallback_content = await self.web_search(
        query=f"{tool_name} {topic} tutorial guide",
        prompt=f"Since official docs not found, find a high-quality tutorial about {topic} in {tool_name}. "
                f"Prefer: official blog, reputable tech sites (not random Medium posts)."
    )

    # Add warning to lesson
    lesson_metadata['warnings'].append({
        'type': 'no_official_docs',
        'message': f"Official documentation for {tool_name} not found. Lesson based on community tutorials.",
        'mitigation': "Manual verification recommended before publishing."
    })
```

### **Case 2: Documentation Behind Login**

```python
if response.status_code == 401 or "login required" in response.text:
    # Can't fetch - inform user
    lesson_metadata['warnings'].append({
        'type': 'docs_login_required',
        'message': f"{tool_name} documentation requires authentication. Cannot auto-fetch.",
        'action_required': "Please manually provide documentation or API reference."
    })

    # Skip web fetch for this lesson
    return None
```

### **Case 3: Outdated Documentation**

```python
# Check if docs mention version
version_match = re.search(r'version\s*:?\s*(\d+\.\d+\.?\d*)', docs_content, re.IGNORECASE)

if version_match:
    docs_version = version_match.group(1)

    # Compare with latest version (from web search)
    latest_version = await self._get_latest_version(tool_name)

    if docs_version != latest_version:
        lesson_metadata['warnings'].append({
            'type': 'version_mismatch',
            'message': f"Documentation shows v{docs_version}, but latest is v{latest_version}",
            'recommendation': "Verify examples work with latest version."
        })
```

### **Case 4: Multiple Language Docs**

```python
# Detect course language from COURSE-BRIEF
course_language = self.brief.basic_info.language  # e.g., "pt-BR", "en"

# Search with language preference
search_query = f"{tool_name} official documentation {course_language}"

# Example: "Supabase official documentation pt-BR"
# Will prioritize Portuguese docs if available
```

---

## 📊 Complete Flow Diagram

```
INPUT: tool_name="Supabase", topic="Authentication"
    ↓
[1] Discover Official Docs URL
    ├─ Check cache → Found? Use it ✅
    └─ Not cached → Web search "supabase official documentation"
        ├─ Found → Validate URL (reachable? looks like docs?)
        │   ├─ Valid → Cache & continue ✅
        │   └─ Invalid → Fallback to LLM query
        └─ Not found → Mark as "no_official_docs" ⚠️
    ↓
[2] Fetch Topic-Specific Docs
    ├─ Search within docs site: "site:supabase.com/docs authentication"
    ├─ Found specific page → WebFetch that page ✅
    └─ Not found → WebFetch main docs + extract relevant section
    ↓
[3] Discover Community Sources
    ├─ Stack Overflow tag → "supabase"
    ├─ Reddit subreddit → "r/Supabase"
    └─ GitHub repo → "github.com/supabase/supabase"
    ↓
[4] Fetch Community Q&A
    ├─ Stack Overflow → Top 5 questions about "authentication"
    ├─ Reddit → Common pain points + pro tips
    └─ GitHub → Recent issues + workarounds
    ↓
[5] Aggregate Context
    {
      official_docs: {...},
      community_qa: {...},
      version: "2.38.0",
      warnings: [...]
    }
    ↓
[6] Inject into Lesson Generation Prompt
    ↓
✅ Generate Lesson with Rich Technical Context
```

---

## 🎯 Final Implementation Code

```python
# expansion-packs/creator-os/lib/technical_researcher.py

class TechnicalResearcher:
    """
    Dynamically research technical tools and fetch documentation.
    NO hardcoded URLs - everything discovered via web search.
    """

    def __init__(self, cache_path: Path):
        self.cache_path = cache_path
        self.cache = self._load_cache()


    async def research_tool(self, tool_name: str, topic: str) -> dict:
        """
        Main entry point: research a tool for a specific topic.

        Returns complete technical context ready for lesson generation.
        """
        context = {
            'tool_name': tool_name,
            'topic': topic,
            'official_docs': None,
            'community_qa': None,
            'version': None,
            'warnings': [],
            'researched_at': datetime.now().isoformat()
        }

        try:
            # Step 1: Discover & fetch official docs
            docs_info = await self.discover_official_docs_url(tool_name)

            if docs_info:
                docs_content = await self.fetch_docs_for_topic(
                    docs_url=docs_info['url'],
                    topic=topic,
                    tool_name=tool_name
                )
                context['official_docs'] = docs_content
            else:
                context['warnings'].append({
                    'type': 'no_official_docs',
                    'severity': 'high'
                })

            # Step 2: Discover community sources
            community_sources = await self.discover_community_sources(tool_name)

            # Step 3: Fetch community Q&A
            qa_data = await self.fetch_community_qa(topic, tool_name, community_sources)
            context['community_qa'] = qa_data

            # Step 4: Cache results
            self._cache_research(tool_name, context)

        except Exception as e:
            context['warnings'].append({
                'type': 'research_failed',
                'error': str(e),
                'severity': 'critical'
            })

        return context


    # ... (all methods from above sections) ...
```

---

## ✅ Benefits of This Approach

1. **✅ Zero Hardcoding** - Works for ANY tool, even ones that don't exist today
2. **✅ Always Up-to-Date** - Fetches latest docs every time
3. **✅ Self-Learning** - Cache grows organically with usage
4. **✅ Robust** - Handles edge cases gracefully (no docs, login-required, etc.)
5. **✅ Multi-Source** - Official docs + community knowledge
6. **✅ Transparent** - Warnings inform user of limitations
7. **✅ Language-Aware** - Matches course language when possible
8. **✅ Version-Aware** - Tracks and warns about version mismatches

---

**Status:** ✅ Complete Strategy
**Next:** Implement in `lib/technical_researcher.py`
