# /generate-blog-post Task

Generate complete SEO-optimized blog post (1500-2500 words) with persona voice preservation.

```yaml
purpose: "Create authentic, SEO-optimized blog posts with 85-95% voice fidelity"
prerequisites:
  - Valid persona (MMOS mind name or custom JSON path)
  - Topic or outline
  - Target audience identified
interactive: true
estimated_time: "5-10 minutes"
```

## Elicitação
```
1. Topic/Title - What's the main topic for the blog post?
2. Persona - Which voice? (MMOS mind name like 'nassim_taleb' OR custom persona JSON path)
3. Keywords - Primary keyword + 2-4 secondary keywords (or let AI extract from topic)
4. Audience - Who is the target reader? (demographics, knowledge level, desired outcome)
5. Length - Target word count? (default: 2000, range: 1500-2500)
6. Framework - Storytelling framework? (hero_journey, problem_solution, aida, pas, or auto)
```

## Passos
1. **Validate & Load Persona**
   - If MMOS: Load from `docs/minds/{mind_name}/synthesis/`
   - If custom: Load JSON and validate schema
   - Extract voice parameters (tone, complexity, style markers, signature phrases)

2. **Research & Outline**
   - Generate/validate keywords (primary + secondary + LSI)
   - Create blog structure (title, meta, 3-5 H2 sections, conclusion, CTA)
   - Apply selected storytelling framework

3. **Content Generation**
   - Write compelling hook (100-150 words, primary keyword in first 100 words)
   - Generate body sections (200-400 words each, 1-2 examples per section)
   - Write conclusion (summary + action OR story callback)
   - Create CTA (50-100 words, benefit-oriented, single clear action)

4. **SEO Optimization**
   - Validate keyword density (primary: 1-2%, secondary: 0.5-1%)
   - Check heading structure (1 H1, 3-5 H2s, keywords in 2-3 headings)
   - Calculate readability (Flesch-Kincaid 60+ target)
   - Suggest internal/external links
   - Generate SEO score (target: 8/10)

5. **Fidelity Validation**
   - Analyze 4 dimensions: vocabulary (30%), syntax (20%), style (25%), thinking (25%)
   - Calculate fidelity score (target: 85%+ custom, 90%+ MMOS)
   - Generate fidelity report with strengths/weaknesses
   - If below threshold: offer regeneration

6. **Output & Preview**
   - Save blog post to `creator-os-workspace/blog-posts/{slug}-{timestamp}.md`
   - Save fidelity report to `creator-os-workspace/fidelity-reports/`
   - Log to database (optional - `content_pieces` table)
   - Show preview with scores and offer actions (read full, regenerate, edit, approve)

## Success Criteria
- ✅ 1500-2500 words
- ✅ Fidelity 85%+ (custom) or 90%+ (MMOS)
- ✅ SEO score 8/10
- ✅ Readability Flesch-Kincaid 60+
- ✅ User would publish without major edits

## Integration
**MMOS:** Load personality profiles from `docs/minds/{mind}/synthesis/`
**InnerLens:** (Optional) Adapt content to audience psychometric profiles
**Database:** Track in `content_pieces`, `content_performance` tables

---

**Full Task Specification:** `expansion-packs/creator-os/tasks/generate-blog-post.md`
