# Technical Lesson Quality Checklist

**Purpose:** Ensure technical lessons about tools/frameworks are accurate, up-to-date, and comprehensive by incorporating live documentation and community knowledge.

**When to Use:** For any lesson about a specific tool, framework, API, library, or technical platform.

---

## 🔍 Pre-Generation Research (Automated)

### 1. Documentation Research

**Official Documentation:**
- [ ] Identify official docs URL for the topic (e.g., `obsidian.md/docs`, `react.dev`)
- [ ] Fetch relevant documentation page(s) for this specific lesson topic
- [ ] Extract key concepts, parameters, and examples from docs
- [ ] Check for version-specific information (note which version is current)
- [ ] Identify any deprecation warnings or "best practices" sections

**Documentation Sources Checklist:**
```yaml
# Example for a lesson on "Obsidian Links"
official_docs:
  - url: https://help.obsidian.md/Linking+notes+and+files/Internal+links
    relevance: high
    extracted_concepts:
      - Wikilink syntax
      - Markdown link syntax
      - Link autocomplete
      - Aliases
  - url: https://help.obsidian.md/Linking+notes+and+files/Aliases
    relevance: medium
```

**Quality Criteria:**
- [ ] Documentation is from official source (not 3rd-party tutorials)
- [ ] Documentation is recent (< 1 year old for fast-moving tools)
- [ ] Multiple sections of docs consulted (not just one page)

---

### 2. Community Knowledge Research

**Common Questions & Issues:**
- [ ] Search Stack Overflow for top questions about this topic
- [ ] Search Reddit (r/obsidianmd, r/reactjs, etc.) for user pain points
- [ ] Search GitHub issues for common bugs/misunderstandings
- [ ] Identify 3-5 most common mistakes/confusion points

**Community Sources Checklist:**
```yaml
# Example for "Obsidian Links" lesson
community_research:
  stack_overflow:
    - query: "obsidian internal links"
      top_questions:
        - "How to link to headings in Obsidian?"
        - "Difference between [[]] and []() links?"
        - "Broken links after renaming files?"
  reddit:
    - subreddit: r/ObsidianMD
      common_pain_points:
        - "Links break when moving files between folders"
        - "Can't link to specific blocks easily"
  github_issues:
    - repo: obsidianmd/obsidian-releases
      frequent_issues:
        - Link autocomplete not working on mobile
```

**Quality Criteria:**
- [ ] At least 2 platforms searched (Stack Overflow + Reddit/GitHub)
- [ ] Top 5-10 questions/issues reviewed
- [ ] Common patterns identified (recurring confusion points)

---

### 3. Version & Currency Check

**Current State Verification:**
- [ ] Identify current version of tool/framework
- [ ] Check if lesson topic has recent updates (< 6 months)
- [ ] Note any breaking changes or major feature additions
- [ ] Verify syntax/API is still current (not deprecated)

**Version Tracking:**
```yaml
tool_version_info:
  tool: Obsidian
  current_version: "1.5.3"
  lesson_topic: "Internal Links"
  last_major_change: "v1.4.0 - Added block links"
  deprecations: null
  upcoming_changes: "v1.6.0 - Improved link autocomplete (beta)"
```

---

## ✍️ During Generation (Human/AI Validation)

### 4. Content Accuracy

**Technical Correctness:**
- [ ] All code examples are syntactically correct
- [ ] Commands/syntax match official documentation
- [ ] Parameter names and options are accurate
- [ ] No outdated or deprecated features recommended
- [ ] Version compatibility clearly stated (if relevant)

**Example Quality:**
```markdown
<!-- GOOD EXAMPLE -->
## Creating Internal Links

In Obsidian v1.5+, you can create links using:

1. **Wikilink syntax** (recommended):
   ```
   [[Note Name]]
   [[Note Name|Display Text]]
   ```

2. **Markdown syntax**:
   ```
   [Display Text](Note%20Name.md)
   ```

**Note:** Wikilinks auto-update when renaming files, while Markdown links may break.
Source: [Official Docs - Internal Links](https://help.obsidian.md/...)

<!-- BAD EXAMPLE -->
Just use [[Note Name]] to link.
```

---

### 5. Common Pitfalls Addressed

**Preemptive Troubleshooting:**
- [ ] Lesson includes "Common Mistakes" section based on community research
- [ ] Each common error has explanation + solution
- [ ] Edge cases are covered (not just happy path)
- [ ] Platform-specific issues noted (Windows/Mac/Linux, Mobile/Desktop)

**Common Pitfalls Template:**
```markdown
## ⚠️ Common Mistakes

### 1. Links Breaking After File Move
**Why it happens:** Markdown-style links use relative paths that break when files move.

**Solution:** Use Wikilinks (`[[Note]]`) instead, which Obsidian auto-updates.

**Source:** Top issue on r/ObsidianMD (127 upvotes)

### 2. Can't Link to Headings
**Why it happens:** Missing the `#` syntax after the note name.

**Correct:** `[[Note#Heading]]`
**Incorrect:** `[[Note Heading]]`

**Source:** Stack Overflow - 342 views
```

---

### 6. Up-to-Date Best Practices

**Modern Recommendations:**
- [ ] Lesson follows current best practices (not legacy approaches)
- [ ] Official recommendations prioritized over community hacks
- [ ] Performance considerations mentioned (if relevant)
- [ ] Security/privacy implications addressed (if relevant)

**Best Practices Section:**
```markdown
## 🎯 Best Practices

1. **Prefer Wikilinks over Markdown links**
   - Official recommendation (Obsidian docs)
   - Auto-update on rename
   - Better graph view integration

2. **Use aliases for long note names**
   - `[[Long Note Name|Short Name]]`
   - Improves readability

3. **Enable "Detect all file extensions" in settings**
   - Settings → Files & Links
   - Allows linking to non-Markdown files
```

---

## 📊 Post-Generation Validation

### 7. Documentation Cross-Reference

**Verification:**
- [ ] Every major claim has a source citation
- [ ] Links to official docs are included (not just mentioned)
- [ ] Screenshots/examples match current version of tool
- [ ] "Further Reading" section with official resources

**Citation Format:**
```markdown
**Source:** [Official Obsidian Docs - Internal Links](https://help.obsidian.md/Linking+notes+and+files/Internal+links) (v1.5, accessed 2025-10-19)
```

---

### 8. Community-Validated Examples

**Real-World Scenarios:**
- [ ] Examples reflect actual use cases from community
- [ ] Not just toy examples (use realistic data/scenarios)
- [ ] Cover both beginner and intermediate use cases
- [ ] Include at least one "power user" tip from community

**Example Quality:**
```markdown
<!-- GOOD: Real-world scenario -->
## Example: Building a Second Brain with Links

Let's say you're reading a book and taking notes:

1. Create daily note: `[[2025-10-19 Reading]]`
2. Link to book note: `[[Book - Atomic Habits]]`
3. Link to specific concept: `[[Book - Atomic Habits#Habit Stacking]]`
4. Create bidirectional link back from book note

This workflow comes from the Zettelkasten method, widely used in r/ObsidianMD community.

<!-- BAD: Toy example -->
Create a link like this: `[[My Note]]`
```

---

### 9. Troubleshooting Section

**Based on Community Research:**
- [ ] "Troubleshooting" or "FAQ" section included
- [ ] Covers top 3-5 issues from Stack Overflow/Reddit
- [ ] Provides step-by-step solutions
- [ ] Links to relevant GitHub issues (if applicable)

**Template:**
```markdown
## 🔧 Troubleshooting

### Q: My links aren't showing up in the graph view
**A:** Check Settings → Graph View → Filters. Ensure the note isn't excluded.

**Source:** GitHub Issue #3421

### Q: Link autocomplete stopped working
**A:**
1. Restart Obsidian
2. Check if note is in vault root (not external folder)
3. Rebuild search index: Ctrl+P → "Rebuild Index"

**Sources:** Stack Overflow (52 answers), r/ObsidianMD FAQ
```

---

### 10. Update Indicators

**Future-Proofing:**
- [ ] Lesson includes "Last Updated" date
- [ ] Tool version clearly stated
- [ ] Note if features are in beta/experimental
- [ ] Link to official changelog (if frequent updates)

**Template:**
```markdown
---
last_updated: 2025-10-19
tool_version: Obsidian 1.5.3
status: stable
official_docs: https://help.obsidian.md/
changelog: https://obsidian.md/changelog
---

**Note:** This lesson covers Obsidian v1.5.3 (current as of Oct 2025).
Link features are stable. For latest updates, see [official changelog](https://obsidian.md/changelog).
```

---

## ✅ Final Quality Gates

### Before Marking Lesson Complete:

**Accuracy Gates:**
- [ ] All code/commands tested (or validated against official docs)
- [ ] No deprecated features recommended
- [ ] Version compatibility clearly stated
- [ ] Sources cited for all major claims

**Comprehensiveness Gates:**
- [ ] Official documentation consulted
- [ ] Community pain points addressed
- [ ] Common mistakes preemptively covered
- [ ] Real-world examples included

**Freshness Gates:**
- [ ] Documentation is current (< 1 year old)
- [ ] Community research is recent (< 6 months old)
- [ ] Tool version verified
- [ ] No stale information

---

## 🚨 Red Flags (Reject Lesson if Present)

**Automatic Rejection Criteria:**
- ❌ No source citations for technical claims
- ❌ Uses deprecated features without warning
- ❌ Code examples are broken/incorrect
- ❌ Version of tool not specified
- ❌ Contradicts official documentation
- ❌ Ignores top community pain points
- ❌ No troubleshooting/FAQ section
- ❌ Outdated screenshots (if visual tool)

---

## 📚 Research Sources by Tool Type

### Developer Tools (APIs, Frameworks, Libraries)
```yaml
priority_sources:
  1. Official documentation (docs.tool.com)
  2. Stack Overflow (tag: tool-name)
  3. GitHub Issues (official repo)
  4. Official blog/changelog
  5. Reddit (r/toolname or r/programming)
```

### Productivity Tools (Obsidian, Notion, etc.)
```yaml
priority_sources:
  1. Official help center
  2. Official community forum
  3. Reddit (r/toolname)
  4. YouTube (official channel)
  5. Medium/community tutorials (for use cases)
```

### No-Code/Low-Code Platforms (Zapier, Make, etc.)
```yaml
priority_sources:
  1. Official documentation
  2. Official templates/examples
  3. Community forum
  4. Integration-specific docs
  5. Reddit/Facebook groups
```

---

## 🎯 Success Metrics

**A technical lesson passes this checklist when:**

1. **Accuracy:** 100% of technical claims are verifiable via official docs
2. **Currency:** All information is < 1 year old (< 6 months for fast-moving tools)
3. **Completeness:** Top 5 community pain points are addressed
4. **Practicality:** At least 2 real-world examples included
5. **Future-Proof:** Version clearly stated, update path documented

---

**Checklist Version:** 1.0
**Created:** 2025-10-19
**Last Updated:** 2025-10-19
**Owner:** Product Owner (Sarah)
