# Data Collection Guidelines for Test Subjects

**Study:** InnerLens Lite Validation
**Version:** 1.0
**Date:** 2025-01-15

---

## 📋 Quick Checklist

Before submitting your text, make sure:

- [ ] **Word count:** 500-2000 words (check with `wc -w yourfile.txt` or online word counter)
- [ ] **Language:** English only (MVP limitation)
- [ ] **Format:** Plain text (.txt) or PDF (we'll convert)
- [ ] **Content type:** Personal writing (see examples below)
- [ ] **Privacy:** Removed names, emails, phone numbers, addresses
- [ ] **Consent:** Reviewed and signed informed consent form
- [ ] **Self-assessment:** Completed IPIP-NEO-50 questionnaire

---

## 🎯 What Makes Good Text for Analysis?

### ✅ GOOD: Personality-Revealing Content

InnerLens works best with text that shows **how you think, feel, decide, and behave**. Look for content with:

**1. Personal opinions and beliefs**
```
✅ "I think the biggest mistake people make is..."
✅ "I believe strongly in..."
✅ "In my view, the most important thing is..."
```

**2. Behavioral descriptions**
```
✅ "I always finish what I start"
✅ "I hate leaving things unfinished"
✅ "I'm constantly reading papers across 10+ disciplines"
✅ "I thrive in social settings"
```

**3. Decision-making patterns**
```
✅ "When I face a difficult choice, I..."
✅ "My approach to problem-solving is..."
✅ "I tend to prioritize X over Y because..."
```

**4. Emotional expressions**
```
✅ "I love exploring new ideas"
✅ "That frustrates me to no end"
✅ "I find routine boring"
✅ "I stay calm under pressure"
```

**5. Self-descriptions**
```
✅ "I'm very systematic in how I..."
✅ "I'm not naturally outgoing"
✅ "I'm pretty even-keeled emotionally"
```

**6. Value statements**
```
✅ "I value honesty over politeness"
✅ "Fairness is essential to me"
✅ "I prioritize learning over comfort"
```

**7. Hypotheticals and aspirations**
```
✅ "I would never compromise on..."
✅ "If I could change one thing, I'd..."
✅ "My ideal environment is..."
```

---

### ❌ BAD: Factual or Generic Content

InnerLens struggles with text that lacks behavioral patterns:

**1. Pure biographical facts**
```
❌ "I was born in 1985"
❌ "I studied computer science at MIT"
❌ "I worked at Google for 5 years"
❌ "I live in San Francisco"
```
*Why bad?* No personality signals - just facts.

**2. Generic descriptions**
```
❌ "The weather was nice"
❌ "The meeting started at 2pm"
❌ "The product has these features: X, Y, Z"
```
*Why bad?* No personal perspective or behavior.

**3. Purely professional content**
```
❌ "This quarter's revenue was $X million"
❌ "The project timeline is as follows:"
❌ "Please find attached the report"
```
*Why bad?* Formal, impersonal, no self-revelation.

**4. Code without explanation**
```
❌ def calculate(x, y):
      return x + y
```
*Why bad?* No language, no personality.
*Fix:* Include commit messages with reasoning ("I refactored this because I hate duplicate code")

**5. Lists without context**
```
❌ "Top 10 movies: 1. X, 2. Y, 3. Z..."
```
*Why bad?* No explanation of *why* you like them.
*Fix:* "I love X because it challenges conventional thinking" (shows Openness)

---

## 📝 Recommended Content Types

### Tier 1: Excellent (500-1000 words each)

**1. Personal Essays**
- Topic: Meaningful experience, personal growth, life philosophy
- Example prompts:
  - "Describe a time you faced a difficult decision. How did you approach it?"
  - "What are your core values and where do they come from?"
  - "Write about a challenge that changed how you think"
  - "Describe your ideal day"

**2. Interview Transcripts**
- Format: Q&A about you, your work, your philosophy
- Example sources:
  - Podcast appearance (transcribed)
  - Job interview responses (behavioral questions)
  - Informational interview you gave
- **Tip:** Use free transcription tools like Otter.ai, Whisper, or Rev

**3. Blog Posts / Articles You Wrote**
- Topic: Personal perspective on any subject
- Best if: First-person narrative, includes opinions and reasoning
- Avoid: Pure news reporting, tutorials without personal commentary

---

### Tier 2: Good (300-500 words each, combine 2-3)

**4. Email Conversations (Personal)**
- **Include:** Personal discussions, advice to friends, decision explanations
- **Exclude:** Spam, newsletters, automated messages, purely professional scheduling
- **Privacy:** Remove names, company names, sensitive details

**5. Journal Entries**
- Best: Reflective entries about decisions, emotions, growth
- Avoid: Daily logs ("Went to store, bought milk")

**6. Social Media Posts**
- **Twitter/X:** Long threads where you explain your thinking
- **LinkedIn:** Articles or posts about your professional philosophy
- **Reddit:** Comments where you share opinions, advice, or experiences
- **Avoid:** Short reactions ("Cool!"), memes, retweets

**7. Letters You Wrote**
- Best: Letters to friends, family, or yourself (future self letters)
- Avoid: Formal business letters, cover letters (too generic)

---

### Tier 3: Acceptable (combine 3-5 sources)

**8. Code Commit Messages (with explanations)**
- **Include:** Commit messages where you explain *why* you made decisions
- Example: "Refactored login flow because I hate duplicate code and wanted cleaner architecture"
- **Exclude:** One-line commits ("Fixed bug"), code without commentary

**9. Meeting Notes (Personal)**
- Best: Notes where you recorded your own thoughts, not just facts
- Example: "Meeting takeaway: I think we're approaching this wrong because..."

**10. Book/Movie Reviews**
- Best: Reviews where you explain *why* you liked/disliked something
- Example: "I loved this book because it challenges conventional thinking about..." (Openness)
- Avoid: Star ratings without explanation

---

## 📐 Word Count Guidelines

**Minimum:** 500 words
- Below 500: Likely insufficient evidence
- You'll get warnings: "Low confidence due to limited text"

**Ideal:** 1000-2000 words
- Sweet spot for accuracy vs. processing time
- Enough evidence for all 5 traits
- Analysis time: <2 minutes

**Maximum:** 2000 words (soft limit)
- Above 2000: Diminishing returns on accuracy
- Longer processing time (3-4 minutes)
- Higher cost ($0.25-0.30 vs $0.18-0.20)

**How to check word count:**
```bash
# Command line (Mac/Linux)
wc -w yourfile.txt

# Online tools
https://wordcounter.net/
https://charactercountonline.com/
```

---

## 🔒 Privacy Protection

**REMOVE before submitting:**

### 1. Personal Identifiable Information (PII)
- ❌ Your full name → Use [NAME] or [SELF]
- ❌ Other people's names → Use [PERSON1], [FRIEND], [COLLEAGUE]
- ❌ Email addresses → Remove or replace with [EMAIL]
- ❌ Phone numbers → Remove entirely
- ❌ Addresses → Use [CITY] or [LOCATION]
- ❌ Social security numbers, IDs → Remove entirely

### 2. Sensitive Professional Information
- ❌ Company names (if sensitive) → Use [COMPANY] or generic "my company"
- ❌ Proprietary project details → Generalize or remove
- ❌ Client names → Use [CLIENT]
- ❌ Non-public financial figures → Remove or anonymize

### 3. Sensitive Personal Information
- ❌ Medical conditions (beyond general health) → Generalize
- ❌ Legal issues → Remove if sensitive
- ❌ Extremely private family matters → Your judgment

**✅ KEEP (these are personality-relevant):**
- ✅ Opinions, beliefs, values
- ✅ Behavioral descriptions ("I always...", "I never...")
- ✅ Emotional reactions ("I love...", "I hate...")
- ✅ Decision-making patterns
- ✅ Generic locations ("San Francisco", "Europe")
- ✅ General professions ("software engineer", "teacher")

**Example anonymization:**

Before:
> "John and I were at Acme Corp when we launched Project Phoenix in 2023. My email (sarah.jones@acmecorp.com) got 50 responses!"

After:
> "[COLLEAGUE] and I were at [COMPANY] when we launched [PROJECT] in 2023. My email got 50 responses!"

Or keep personality-relevant context:
> "A colleague and I were at my previous company when we launched a risky new project. I was nervous but excited - I love taking on challenges that others avoid."

---

## 📤 Submission Instructions

### Step 1: Prepare Your File

**File naming convention:**
```
subject_<ID>_<content_type>.txt

Examples:
subject_001_essay.txt
subject_002_interview_transcript.txt
subject_003_blog_posts_combined.txt
```

**If you don't have an ID yet:**
```
<yourname>_<content_type>.txt
We'll assign an ID when processing
```

**Format:**
- **Preferred:** Plain text (.txt, UTF-8 encoding)
- **Acceptable:** PDF (we'll convert), Word (.docx)
- **Avoid:** Images of text (no OCR available)

### Step 2: Combine Multiple Sources (if needed)

If using multiple sources to reach 1000+ words:

```
=== Source 1: Personal Essay (500 words) ===
[Your essay text here...]

=== Source 2: Interview Transcript (400 words) ===
[Transcript here...]

=== Source 3: Blog Post Excerpt (300 words) ===
[Blog post here...]

Total: 1200 words
```

**Label each source** so we know the context.

### Step 3: Submit

**Email to:** alan@academialendaria.ai

**Subject:** `InnerLens Study - Text Submission - [Your Name or ID]`

**Attach:**
1. Your text file (subject_XXX_*.txt)
2. Screenshot or CSV of your IPIP-NEO-50 scores
3. Signed consent form (if not already submitted)

**Email body template:**
```
Hi,

Attached is my text submission for the InnerLens Lite validation study.

- Subject ID (if assigned): [e.g., subject_001]
- Word count: [e.g., 1247 words]
- Content type: [e.g., Personal essay + interview transcript]
- Privacy check: ✅ All PII removed
- Consent form: ✅ Signed and submitted

Questions/comments: [Any special notes about your submission]

Thanks,
[Your Name]
```

---

## ❓ FAQ

**Q: I have 300 words. Is that enough?**
A: Minimum is 500 words. Can you add another essay, blog post, or email thread to reach 500+? Quality over quantity, but we need sufficient evidence.

**Q: Can I submit text in Portuguese/Spanish?**
A: Not for v1.0 (English only). We're planning multilingual support for v1.2 (3-4 months). I can reach out when ready!

**Q: My writing is very personal/embarrassing. Should I still share it?**
A: Only share what you're comfortable with. You can:
- Anonymize heavily (remove context that identifies you)
- Choose less personal content (blog posts instead of journal)
- Remove specific embarrassing details while keeping the personality patterns

Remember: We only see "subject_001", not your real name. And data is stored encrypted.

**Q: I'm a creative writer. Can I submit fiction I wrote?**
A: Fiction can work if it's first-person and reflects your personality. But non-fiction (essays, interviews) is better because it's more directly about you.

**Q: Can I submit code?**
A: Only if accompanied by extensive comments or commit messages explaining your reasoning. Pure code doesn't have personality signals.

**Q: I talk differently in professional vs personal settings. Which should I submit?**
A: Ideally, mix both! The system will average across contexts. If only one, choose the context where you're most "yourself."

**Q: How do I know if my text is good for analysis?**
A: Ask yourself: "Does this show how I think, feel, decide, or behave?" If yes, it's good. If it's purely factual or generic, it's not ideal.

**Q: Can I edit my text after submitting?**
A: Yes, until we start analysis (we'll notify you). After analysis starts, edits would invalidate results.

**Q: What if I realize I included sensitive info after submitting?**
A: Email immediately. We'll pause processing and let you submit a revised version.

---

## ✅ Before You Submit - Final Checklist

- [ ] Word count: 500-2000 words ✅
- [ ] Language: English ✅
- [ ] Content type: Personal writing (essays, interviews, blogs, emails) ✅
- [ ] Personality signals: Includes opinions, behaviors, emotions, decisions ✅
- [ ] Privacy: All PII removed (names, emails, addresses, phone numbers) ✅
- [ ] Format: Plain text (.txt) or PDF ✅
- [ ] File name: `subject_XXX_<type>.txt` or `<yourname>_<type>.txt` ✅
- [ ] Self-assessment: IPIP-NEO-50 completed ✅
- [ ] Consent form: Signed and submitted ✅
- [ ] Email: Sent to alan@academialendaria.ai with subject "InnerLens Study - Text Submission" ✅

**Once submitted, you're done!** You'll receive your results within 3-5 days.

---

## 📊 Example Submissions

### Example 1: Personal Essay (Excellent)

**Subject ID:** subject_001
**Word count:** 1150 words
**Content type:** Personal essay
**Prompt:** "Describe your approach to challenges"

```
I've always been fascinated by how things work at a fundamental level. When I was a kid, I'd take apart radios just to see the components inside. That curiosity never went away—I'm constantly reading papers across 10+ disciplines just to find interesting connections. The status quo bores me.

I'm very systematic in how I approach problems. I keep detailed notes, always follow through on commitments, and I hate leaving things unfinished. My calendar is color-coded, and I plan my week every Sunday evening. Some people think I'm too rigid, but it works for me.

I'm not naturally outgoing. Large social gatherings drain my energy, and I prefer deep one-on-one conversations over small talk. I can be assertive when needed, but I don't seek the spotlight. I'm comfortable working alone for long periods.

I try to be helpful and considerate, but I'm also very direct. I'd rather tell someone the truth than make them feel good with a lie. I believe in fair play, but I'm not naïve—people can be selfish, and you need to watch out for yourself.

I'm pretty even-keeled emotionally. I rarely get anxious, even in high-pressure situations. When things go wrong, I focus on solutions rather than dwelling on problems. Friends say I'm unusually calm, almost stoic. I don't worry much about things I can't control.

[... continues for 1150 words total]
```

**Why this is excellent:**
✅ Personal behavioral descriptions ("I'd take apart radios")
✅ Self-assessments ("I'm very systematic", "I'm not naturally outgoing")
✅ Value statements ("I'd rather tell the truth")
✅ Emotional patterns ("I rarely get anxious")
✅ Decision patterns ("I focus on solutions")

**Expected results:** High confidence (80%+) for all traits

---

### Example 2: Interview Transcript (Good)

**Subject ID:** subject_002
**Word count:** 890 words
**Content type:** Podcast interview transcript
**Source:** Personal podcast appearance

```
Interviewer: What drives you in your work?

Subject: Honestly, I think I'm driven by a need to create things that didn't exist before. I get bored easily with routine tasks. I need intellectual challenge to stay engaged. When I'm working on something novel, I can go 12 hours without noticing. But ask me to do the same task twice? I'll procrastinate endlessly.

Interviewer: How do you handle setbacks?

Subject: I'm pretty resilient. I don't take failure personally. When something doesn't work, I analyze what went wrong, adjust, and try again. I think emotional reactivity is counterproductive in most situations. My teammates sometimes joke that nothing rattles me.

[... continues for 890 words total]
```

**Why this is good:**
✅ Behavioral patterns revealed through Q&A
✅ Self-awareness ("I get bored easily", "I don't take failure personally")
✅ Specific examples
✅ Conversational format still shows personality

**Expected results:** Medium-High confidence (75-85%) - slightly lower than essay because shorter

---

### Example 3: Multiple Sources Combined (Good)

**Subject ID:** subject_003
**Word count:** 1340 words
**Content types:** Blog post (500w) + Email thread (400w) + LinkedIn article (440w)

```
=== Source 1: Blog Post - "Why I Quit My Job" (500 words) ===

Last year, I made the scariest decision of my life: I quit my stable job to pursue [PROJECT]. Everyone thought I was crazy. My parents were worried. My friends were skeptical. But I knew I had to do it.

Here's why: I realized I was optimizing for the wrong things. I was chasing prestige and stability, but I was miserable. Every Sunday night, I'd feel this knot in my stomach. I knew something had to change.

[... continues 500 words]

=== Source 2: Email Thread - Advice to Friend (400 words) ===

Hey [FRIEND],

I've been thinking about your question about whether to take the promotion. Here's my take...

I think you need to ask yourself: What do you actually value? Is it money? Impact? Work-life balance? There's no right answer, but you need to be honest with yourself.

[... continues 400 words]

=== Source 3: LinkedIn Article - "Lessons from Failure" (440 words) ===

I failed spectacularly last quarter. [PROJECT] crashed and burned despite months of work. Here's what I learned:

1. Failing fast is better than failing slowly...
2. Feedback loops are everything...
3. Ego is the enemy...

[... continues 440 words]

Total: 1340 words across 3 sources
```

**Why this is good:**
✅ Sufficient word count (1340)
✅ Diverse contexts (personal, professional, reflective)
✅ Consistent personality across sources (validates authenticity)

**Expected results:** Medium-High confidence (75-85%) - diverse sources boost reliability

---

## 🎓 Pro Tips

**Tip 1: Quality > Quantity**
1000 words of rich, personality-revealing text beats 2000 words of generic content.

**Tip 2: Mix Personal + Professional**
Combining both contexts gives a more complete picture and increases confidence.

**Tip 3: First-Person is Best**
"I think...", "I believe...", "I always..." are gold. Third-person or impersonal writing has weak signals.

**Tip 4: Explain Your Reasoning**
Don't just say what you did - explain *why*. "I chose X because I value Y" is perfect.

**Tip 5: Be Authentic**
Don't try to game the system. We're testing accuracy, not judging your personality. Authentic text yields better results.

---

**Guidelines Status:** ✅ Ready to Use
**Last Updated:** 2025-01-15
**Version:** 1.0

© 2025 Academia Lendar[IA] - InnerLens Lite Research Materials
