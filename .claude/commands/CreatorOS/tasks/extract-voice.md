# Task: Extract Voice Profile

**Type:** Atomic Task
**Responsibility:** Extract instructor voice/personality from legacy content
**Duration:** 1-3 minutes

## Purpose

Analyze writing style, tone, and teaching approach from existing materials to maintain voice consistency.

---

## Inputs

- `slug` (required) - Course identifier

---

## Execution

```bash
python expansion-packs/creator-os/scripts/extract_voice.py "$slug"
```

---

## Process

1. Load lesson content from `sources/organized/lessons/`
2. Analyze with AI:
   - Tone (formal/casual/conversational)
   - Vocabulary (technical level, signature words)
   - Teaching style (storytelling, examples, metaphors)
   - Personality traits (humor, empathy, directness)
3. Generate voice profile (YAML)
4. Update COURSE-BRIEF Section 4 (Voice & Personality)

---

## Output

```
outputs/courses/{slug}/extractions/voice-profile.yaml
```

Updates `COURSE-BRIEF.md` Section 4.

---

## Success Criteria

- ✅ Voice profile extracted (≥60% completeness)
- ✅ Tone identified
- ✅ Teaching style documented
- ✅ 5+ signature phrases/words extracted

---

**Status:** ✅ Ready
