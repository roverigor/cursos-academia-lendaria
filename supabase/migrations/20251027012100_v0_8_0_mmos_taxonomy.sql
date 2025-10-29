-- =========================================================
-- v0.8.0 — MMOS Taxonomy Migration (Phase 1)
-- SQLite → Supabase: domains, specializations, skills, traits
-- =========================================================
-- Migration: Phase 1 - Taxonomy (Low Risk)
-- Source: Supabase taxonomy snapshot
-- Tables: domains (6), specializations (22), skills (73), traits (35)
-- ID Mapping: TEXT → BIGINT (with lookup tables)
-- =========================================================

-- ==============
-- ID MAPPING TABLES (for FK resolution)
-- ==============

-- Store SQLite TEXT id → Supabase BIGINT id mappings
CREATE TABLE IF NOT EXISTS mmos_id_mappings (
  entity_type TEXT NOT NULL,      -- 'domain', 'specialization', 'skill', 'trait'
  sqlite_id TEXT NOT NULL,        -- SQLite original id (TEXT or INTEGER as string)
  supabase_id BIGINT NOT NULL,    -- Supabase generated BIGSERIAL id
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (entity_type, sqlite_id)
);

CREATE INDEX IF NOT EXISTS idx_mmos_mappings_type ON mmos_id_mappings(entity_type);
CREATE INDEX IF NOT EXISTS idx_mmos_mappings_supabase_id ON mmos_id_mappings(supabase_id);

-- ==============
-- EXTEND TABLES FOR MMOS METADATA
-- ==============

-- Add mmos_metadata column to store SQLite-only fields
ALTER TABLE domains ADD COLUMN IF NOT EXISTS mmos_metadata JSONB;
ALTER TABLE specializations ADD COLUMN IF NOT EXISTS mmos_metadata JSONB;
ALTER TABLE skills ADD COLUMN IF NOT EXISTS mmos_metadata JSONB;
ALTER TABLE traits ADD COLUMN IF NOT EXISTS mmos_metadata JSONB;

-- ==============
-- INSERT: domains (6 rows)
-- ==============
-- SQLite structure: id (TEXT PK), name, description, icon, sort_order, created_at, updated_at
-- Supabase structure: id (BIGSERIAL PK), code (TEXT UNIQUE), name, description

DO $$
DECLARE
  v_domain_id BIGINT;
BEGIN
  -- 1. business_entrepreneurship
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'business_entrepreneurship',
    'Business & Entrepreneurship',
    'Building, scaling, and operating businesses',
    jsonb_build_object('icon', '', 'sort_order', 1)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'business_entrepreneurship', v_domain_id);
  END IF;

  -- 2. marketing_sales
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'marketing_sales',
    'Marketing & Sales',
    'Attracting, converting, and retaining customers',
    jsonb_build_object('icon', '', 'sort_order', 2)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'marketing_sales', v_domain_id);
  END IF;

  -- 3. technology_engineering
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'technology_engineering',
    'Technology & Engineering',
    'Building technical products and systems',
    jsonb_build_object('icon', '', 'sort_order', 3)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'technology_engineering', v_domain_id);
  END IF;

  -- 4. creative_arts
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'creative_arts',
    'Creative & Arts',
    'Creating artistic and creative works',
    jsonb_build_object('icon', '', 'sort_order', 4)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'creative_arts', v_domain_id);
  END IF;

  -- 5. health_fitness
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'health_fitness',
    'Health & Fitness',
    'Physical and mental health optimization',
    jsonb_build_object('icon', '', 'sort_order', 5)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'health_fitness', v_domain_id);
  END IF;

  -- 6. knowledge_education
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'knowledge_education',
    'Knowledge & Education',
    'Teaching, learning, and knowledge sharing',
    jsonb_build_object('icon', '', 'sort_order', 6)
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'knowledge_education', v_domain_id);
  END IF;

  RAISE NOTICE 'Domains migration complete';
END $$;

-- ==============
-- INSERT: specializations (22 rows)
-- ==============
-- NOTE: This would be very long to write manually
-- Using COPY command is more efficient

-- First, let's create a temp table to load CSV data
CREATE TEMP TABLE temp_specializations (
  sqlite_id TEXT,
  sqlite_domain_id TEXT,
  name TEXT,
  description TEXT,
  icon TEXT,
  sort_order INT
);

-- Load from CSV (will be executed separately)
-- \copy temp_specializations FROM 'supabase/migrations/data/sqlite_specializations.csv' WITH (FORMAT csv, HEADER true);

-- Insert into specializations with FK resolution
DO $$
DECLARE
  rec RECORD;
  v_spec_id BIGINT;
  v_domain_id BIGINT;
BEGIN
  FOR rec IN SELECT * FROM temp_specializations LOOP
    -- Resolve domain_id
    SELECT supabase_id INTO v_domain_id
    FROM mmos_id_mappings
    WHERE entity_type = 'domain' AND sqlite_id = rec.sqlite_domain_id;

    IF v_domain_id IS NULL THEN
      RAISE WARNING 'Domain not found for specialization %: %', rec.name, rec.sqlite_domain_id;
      CONTINUE;
    END IF;

    -- Insert specialization
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      rec.sqlite_id,
      rec.name,
      rec.description,
      jsonb_build_object('icon', rec.icon, 'sort_order', rec.sort_order)
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    -- Store mapping
    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', rec.sqlite_id, v_spec_id);
    END IF;
  END LOOP;

  RAISE NOTICE 'Specializations migration complete';
END $$;

-- ==============
-- INSERT: skills (73 rows)
-- ==============
CREATE TEMP TABLE temp_skills (
  sqlite_id TEXT,
  sqlite_specialization_id TEXT,
  name TEXT,
  description TEXT,
  sort_order INT
);

-- Load from CSV (will be executed separately)
-- \copy temp_skills FROM 'supabase/migrations/data/sqlite_skills.csv' WITH (FORMAT csv, HEADER true);

DO $$
DECLARE
  rec RECORD;
  v_skill_id BIGINT;
  v_spec_id BIGINT;
BEGIN
  FOR rec IN SELECT * FROM temp_skills LOOP
    -- Resolve specialization_id
    SELECT supabase_id INTO v_spec_id
    FROM mmos_id_mappings
    WHERE entity_type = 'specialization' AND sqlite_id = rec.sqlite_specialization_id;

    IF v_spec_id IS NULL THEN
      RAISE WARNING 'Specialization not found for skill %: %', rec.name, rec.sqlite_specialization_id;
      CONTINUE;
    END IF;

    -- Insert skill
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      rec.sqlite_id,
      rec.name,
      rec.description
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    -- Store mapping
    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', rec.sqlite_id, v_skill_id);
    END IF;
  END LOOP;

  RAISE NOTICE 'Skills migration complete';
END $$;

-- ==============
-- INSERT: traits (35 rows)
-- ==============
-- SQLite structure: code (INTEGER PK), name, description, domain, subdomain,
--                   scale_min_label, scale_max_label, related_frameworks, inverse_of
-- Supabase structure: id (BIGSERIAL PK), code (TEXT UNIQUE), name, description

CREATE TEMP TABLE temp_traits (
  sqlite_code INT,
  name TEXT,
  description TEXT,
  domain TEXT,
  subdomain TEXT,
  scale_min_label TEXT,
  scale_max_label TEXT,
  related_frameworks TEXT,
  inverse_of INT
);

-- Load from CSV (will be executed separately)
-- \copy temp_traits FROM 'supabase/migrations/data/sqlite_traits.csv' WITH (FORMAT csv, HEADER true);

DO $$
DECLARE
  rec RECORD;
  v_trait_id BIGINT;
BEGIN
  FOR rec IN SELECT * FROM temp_traits LOOP
    -- Insert trait (code as 'trait_1', 'trait_2', etc.)
    INSERT INTO traits (code, name, description)
    VALUES (
      'trait_' || rec.sqlite_code::TEXT,
      rec.name,
      rec.description
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_trait_id;

    -- Store mapping
    IF v_trait_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('trait', rec.sqlite_code::TEXT, v_trait_id);

      -- Update trait with rich MMOS metadata
      UPDATE traits
      SET description = COALESCE(
        rec.description,
        rec.domain || ': ' || rec.name
      )
      WHERE id = v_trait_id;
    END IF;
  END LOOP;

  RAISE NOTICE 'Traits migration complete';
END $$;

-- ==============
-- VALIDATION QUERIES
-- ==============
DO $$
DECLARE
  v_domains_count INT;
  v_specs_count INT;
  v_skills_count INT;
  v_traits_count INT;
  v_mappings_count INT;
BEGIN
  SELECT COUNT(*) INTO v_domains_count FROM domains;
  SELECT COUNT(*) INTO v_specs_count FROM specializations;
  SELECT COUNT(*) INTO v_skills_count FROM skills;
  SELECT COUNT(*) INTO v_traits_count FROM traits;
  SELECT COUNT(*) INTO v_mappings_count FROM mmos_id_mappings;

  RAISE NOTICE '=== Migration Summary ===';
  RAISE NOTICE 'Domains: %', v_domains_count;
  RAISE NOTICE 'Specializations: %', v_specs_count;
  RAISE NOTICE 'Skills: %', v_skills_count;
  RAISE NOTICE 'Traits: %', v_traits_count;
  RAISE NOTICE 'ID Mappings: %', v_mappings_count;
END $$;

-- ==============
-- COMMENTS
-- ==============
COMMENT ON TABLE mmos_id_mappings IS 'Maps SQLite TEXT/INTEGER ids to Supabase BIGINT ids for MMOS migration';
COMMENT ON COLUMN domains.mmos_metadata IS 'MMOS-specific metadata (icon, sort_order) from SQLite';
COMMENT ON COLUMN specializations.mmos_metadata IS 'MMOS-specific metadata (icon, sort_order) from SQLite';
COMMENT ON COLUMN skills.mmos_metadata IS 'MMOS-specific metadata (sort_order) from SQLite';
COMMENT ON COLUMN traits.mmos_metadata IS 'Rich trait metadata (domain, subdomain, scales, frameworks) from SQLite';
