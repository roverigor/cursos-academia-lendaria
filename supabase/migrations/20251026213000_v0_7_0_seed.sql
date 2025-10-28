-- =========================================================
-- 20251026213000_v0_7_0_seed.sql — Essential Lookup Data
-- =========================================================
-- PURPOSE: Seed essential lookup tables for system to function
-- DEPENDENCIES: Requires 20251026211500_v0_7_0_baseline.sql applied first
--
-- WHAT THIS SEEDS:
--   • categories - Fragment classification (BIO, COG, VAL, PHI, PRO)
--   • traits - Big Five personality traits
--   • content_frameworks - Content creation frameworks (GPS, AIDA, PAS, Bloom)
--
-- IDEMPOTENT: Can be run multiple times safely (ON CONFLICT DO NOTHING)
--
-- DEPLOYMENT:
--   psql $DB_URL -f supabase/migrations/20251026213000_v0_7_0_seed.sql
--
-- =========================================================


-- =========================================================
-- CATEGORIES (Fragment Classification)
-- =========================================================
INSERT INTO categories (id, code, name, description) VALUES
  (1, 'BIO', 'Biographical', 'Life events, experiences, personal history'),
  (2, 'COG', 'Cognitive', 'Mental processes, thinking patterns, decision-making'),
  (3, 'VAL', 'Values', 'Core beliefs, principles, ethical stances'),
  (4, 'PHI', 'Philosophical', 'Worldview, philosophical positions, metaphysics'),
  (5, 'PRO', 'Professional', 'Work, career, expertise, professional identity')
ON CONFLICT (id) DO NOTHING;

SELECT '✅ Categories seeded: ' || COUNT(*)::TEXT FROM categories;

-- =========================================================
-- TRAITS (Big Five Personality Model)
-- =========================================================
INSERT INTO traits (code, name, description) VALUES
  ('openness', 'Openness to Experience', 'Imagination, curiosity, creativity, appreciation for art and unusual ideas'),
  ('conscientiousness', 'Conscientiousness', 'Organization, discipline, reliability, goal-directed behavior'),
  ('extraversion', 'Extraversion', 'Sociability, energy, assertiveness, positive emotions'),
  ('agreeableness', 'Agreeableness', 'Cooperation, empathy, trust, compassion toward others'),
  ('neuroticism', 'Neuroticism', 'Emotional stability, stress response, tendency toward negative emotions')
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Traits seeded: ' || COUNT(*)::TEXT FROM traits;

-- =========================================================
-- CONTENT FRAMEWORKS (Content Creation Templates)
-- =========================================================
INSERT INTO content_frameworks (code, name, type, description) VALUES
  ('gps', 'GPS Framework', 'pedagogical', 'Goal → Position → Steps: Clear learning path structure'),
  ('aida', 'AIDA', 'marketing', 'Attention → Interest → Desire → Action: Classic conversion funnel'),
  ('pas', 'Problem-Agitate-Solve', 'storytelling', 'Problem → Agitate → Solve: Emotional persuasion pattern'),
  ('bloom_taxonomy', 'Bloom''s Taxonomy', 'pedagogical', '6 cognitive levels: Remember → Understand → Apply → Analyze → Evaluate → Create')
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Content frameworks seeded: ' || COUNT(*)::TEXT FROM content_frameworks;

-- =========================================================
-- VALIDATION
-- =========================================================
SELECT '📊 Total categories: ' || COUNT(*)::TEXT FROM categories;
SELECT '📊 Total traits: ' || COUNT(*)::TEXT FROM traits;
SELECT '📊 Total content_frameworks: ' || COUNT(*)::TEXT FROM content_frameworks;
