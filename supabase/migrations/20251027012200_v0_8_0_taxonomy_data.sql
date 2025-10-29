-- =========================================================
-- v0.8.0 — MMOS Taxonomy Data
-- Generated from: Supabase taxonomy snapshot
-- =========================================================

-- ==============
-- INSERT: domains
-- ==============
DO $$
DECLARE
  v_domain_id BIGINT;
BEGIN

  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'business_entrepreneurship',
    'Business & Entrepreneurship',
    'Building, scaling, and operating businesses',
    '{"icon": "", "sort_order": 1}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'business_entrepreneurship', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'marketing_sales',
    'Marketing & Sales',
    'Attracting, converting, and retaining customers',
    '{"icon": "", "sort_order": 2}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'marketing_sales', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'technology_engineering',
    'Technology & Engineering',
    'Building technical products and systems',
    '{"icon": "", "sort_order": 3}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'technology_engineering', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'creative_content',
    'Creative & Content',
    'Creating compelling content and experiences',
    '{"icon": "", "sort_order": 4}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'creative_content', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'strategy_consulting',
    'Strategy & Consulting',
    'Advising on strategic decisions',
    '{"icon": "", "sort_order": 5}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'strategy_consulting', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    'personal_development',
    'Personal Development',
    'Growth, mindset, and self-improvement',
    '{"icon": "", "sort_order": 6}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', 'personal_development', v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;

  RAISE NOTICE 'Domains migrated';
END $$;

-- ==============
-- INSERT: specializations
-- ==============
DO $$
DECLARE
  v_spec_id BIGINT;
  v_domain_id BIGINT;
BEGIN

  -- Entrepreneur
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'business_entrepreneurship';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'entrepreneur',
      'Entrepreneur',
      'Building companies from scratch',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'entrepreneur', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Copywriter
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'marketing_sales';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'copywriter',
      'Copywriter',
      'Writing persuasive marketing copy',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'copywriter', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Software Engineer
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'technology_engineering';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'software_engineer',
      'Software Engineer',
      'Building software applications',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'software_engineer', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Writer
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'creative_content';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'writer',
      'Writer',
      'Creating written content',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'writer', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Strategist
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'strategy_consulting';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'strategist',
      'Strategist',
      'Developing strategic plans',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'strategist', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Life Coach
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'personal_development';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'life_coach',
      'Life Coach',
      'Guiding personal growth',
      '{"icon": "", "sort_order": 1}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'life_coach', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Operator/CEO
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'business_entrepreneurship';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'operator',
      'Operator/CEO',
      'Running and scaling organizations',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'operator', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Marketer
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'marketing_sales';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'marketer',
      'Marketer',
      'Growing audiences and driving demand',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'marketer', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- AI Researcher
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'technology_engineering';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'ai_researcher',
      'AI Researcher',
      'Advancing AI/ML capabilities',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'ai_researcher', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Speaker/Presenter
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'creative_content';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'speaker',
      'Speaker/Presenter',
      'Public speaking and presentations',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'speaker', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Consultant
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'strategy_consulting';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'consultant',
      'Consultant',
      'Solving business problems',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'consultant', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Philosopher
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'personal_development';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'philosopher',
      'Philosopher',
      'Exploring fundamental questions',
      '{"icon": "", "sort_order": 2}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'philosopher', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Investor
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'business_entrepreneurship';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'investor',
      'Investor',
      'Evaluating and funding ventures',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'investor', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Salesperson
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'marketing_sales';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'salesperson',
      'Salesperson',
      'Closing deals and driving revenue',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'salesperson', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Product Manager
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'technology_engineering';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'product_manager',
      'Product Manager',
      'Defining product strategy and roadmap',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'product_manager', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Designer
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'creative_content';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'designer',
      'Designer',
      'Visual and UX design',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'designer', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Executive Coach
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'strategy_consulting';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'coach',
      'Executive Coach',
      'Developing leaders',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'coach', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Mindset Coach
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'personal_development';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'mindset_coach',
      'Mindset Coach',
      'Developing mental frameworks',
      '{"icon": "", "sort_order": 3}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'mindset_coach', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Brand Strategist
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'marketing_sales';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'brand_strategist',
      'Brand Strategist',
      'Building memorable brands',
      '{"icon": "", "sort_order": 4}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'brand_strategist', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Data Scientist
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'technology_engineering';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'data_scientist',
      'Data Scientist',
      'Extracting insights from data',
      '{"icon": "", "sort_order": 4}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'data_scientist', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Video Producer
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'creative_content';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'video_producer',
      'Video Producer',
      'Video content creation',
      '{"icon": "", "sort_order": 4}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'video_producer', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Productivity Expert
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = 'personal_development';

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      'productivity_expert',
      'Productivity Expert',
      'Optimizing time and energy',
      '{"icon": "", "sort_order": 4}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', 'productivity_expert', v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;

  RAISE NOTICE 'Specializations migrated';
END $$;

-- ==============
-- INSERT: skills
-- ==============
DO $$
DECLARE
  v_skill_id BIGINT;
  v_spec_id BIGINT;
BEGIN

  -- Business Strategy
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'entrepreneur';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'business_strategy',
      'Business Strategy',
      'Strategic planning and market positioning'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'business_strategy', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Leadership
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'operator';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'leadership',
      'Leadership',
      'Leading teams and driving culture'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'leadership', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Deal Evaluation
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'investor';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'deal_evaluation',
      'Deal Evaluation',
      'Assessing investment opportunities'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'deal_evaluation', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Direct Response Copywriting
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'copywriter';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'direct_response_copywriting',
      'Direct Response Copywriting',
      'Writing copy that drives immediate action'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'direct_response_copywriting', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Growth Marketing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'marketer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'growth_marketing',
      'Growth Marketing',
      'Systematic audience and revenue growth'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'growth_marketing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Closing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'salesperson';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'closing',
      'Closing',
      'Converting prospects to customers'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'closing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Brand Identity
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'brand_strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'brand_identity',
      'Brand Identity',
      'Creating distinctive brand personality'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'brand_identity', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Programming
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'software_engineer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'programming',
      'Programming',
      'Writing code in various languages'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'programming', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Machine Learning
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'ai_researcher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'machine_learning',
      'Machine Learning',
      'Building ML models'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'machine_learning', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Product Strategy
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'product_manager';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'product_strategy',
      'Product Strategy',
      'Long-term product direction'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'product_strategy', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Data Analysis
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'data_scientist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'data_analysis',
      'Data Analysis',
      'Extracting insights from data'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'data_analysis', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Writing Styles
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'writer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'writing_styles',
      'Writing Styles',
      'Various writing formats'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'writing_styles', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Public Speaking
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'speaker';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'public_speaking',
      'Public Speaking',
      'Speaking to audiences'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'public_speaking', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Visual Design
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'designer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'visual_design',
      'Visual Design',
      'Aesthetic and graphic design'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'visual_design', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Video Production
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'video_producer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'video_production',
      'Video Production',
      'Creating video content'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'video_production', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Strategic Thinking
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'strategic_thinking',
      'Strategic Thinking',
      'Long-term planning and foresight'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'strategic_thinking', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Problem Diagnosis
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'consultant';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'problem_diagnosis',
      'Problem Diagnosis',
      'Identifying root causes'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'problem_diagnosis', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Leadership Coaching
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'leadership_coaching',
      'Leadership Coaching',
      'Developing leadership skills'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'leadership_coaching', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Coaching
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'life_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'coaching_skills',
      'Coaching',
      'Core coaching competencies'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'coaching_skills', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Philosophy
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'philosopher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'philosophy',
      'Philosophy',
      'Philosophical thinking'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'philosophy', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Mindset Development
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'mindset_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'mindset_development',
      'Mindset Development',
      'Building empowering beliefs'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'mindset_development', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Time Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'productivity_expert';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'time_management',
      'Time Management',
      'Optimizing time usage'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'time_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Fundraising
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'entrepreneur';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'fundraising',
      'Fundraising',
      'Raising capital from investors'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'fundraising', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Execution
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'operator';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'execution',
      'Execution',
      'Getting things done efficiently'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'execution', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Portfolio Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'investor';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'portfolio_management',
      'Portfolio Management',
      'Managing investment portfolio'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'portfolio_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Sales Letters
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'copywriter';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'sales_letters',
      'Sales Letters',
      'Long-form persuasive writing'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'sales_letters', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Positioning
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'marketer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'positioning',
      'Positioning',
      'Market positioning and messaging'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'positioning', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Prospecting
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'salesperson';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'prospecting',
      'Prospecting',
      'Finding qualified leads'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'prospecting', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Brand Storytelling
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'brand_strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'brand_storytelling',
      'Brand Storytelling',
      'Crafting brand narratives'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'brand_storytelling', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- System Architecture
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'software_engineer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'architecture',
      'System Architecture',
      'Designing scalable systems'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'architecture', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Deep Learning
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'ai_researcher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'deep_learning',
      'Deep Learning',
      'Neural network architectures'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'deep_learning', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- User Research
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'product_manager';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'user_research',
      'User Research',
      'Understanding user needs'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'user_research', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Statistical Modeling
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'data_scientist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'statistical_modeling',
      'Statistical Modeling',
      'Building predictive models'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'statistical_modeling', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Content Creation
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'writer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'content_creation',
      'Content Creation',
      'Generating ideas and content'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'content_creation', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Presentation Design
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'speaker';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'presentation_design',
      'Presentation Design',
      'Creating compelling slides'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'presentation_design', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- UX Design
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'designer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'ux_design',
      'UX Design',
      'User experience design'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'ux_design', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Video Editing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'video_producer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'video_editing',
      'Video Editing',
      'Post-production editing'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'video_editing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Strategic Frameworks
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'frameworks',
      'Strategic Frameworks',
      'Using proven strategy tools'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'frameworks', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Recommendation Development
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'consultant';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'recommendation_development',
      'Recommendation Development',
      'Creating actionable solutions'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'recommendation_development', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Performance Coaching
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'performance_coaching',
      'Performance Coaching',
      'Improving individual performance'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'performance_coaching', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Goal Achievement
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'life_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'goal_achievement',
      'Goal Achievement',
      'Helping clients reach goals'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'goal_achievement', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Critical Thinking
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'philosopher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'critical_thinking',
      'Critical Thinking',
      'Logical reasoning'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'critical_thinking', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Limiting Beliefs
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'mindset_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'limiting_beliefs',
      'Limiting Beliefs',
      'Overcoming mental blocks'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'limiting_beliefs', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Energy Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'productivity_expert';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'energy_management',
      'Energy Management',
      'Maximizing energy levels'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'energy_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Scaling Operations
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'entrepreneur';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'scaling_operations',
      'Scaling Operations',
      'Growing teams and processes'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'scaling_operations', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Financial Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'operator';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'financial_management',
      'Financial Management',
      'Managing budgets and cash flow'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'financial_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Value Creation
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'investor';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'value_creation',
      'Value Creation',
      'Helping portfolio companies grow'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'value_creation', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Persuasion Psychology
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'copywriter';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'persuasion_psychology',
      'Persuasion Psychology',
      'Understanding psychological triggers'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'persuasion_psychology', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Content Marketing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'marketer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'content_marketing',
      'Content Marketing',
      'Creating valuable content'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'content_marketing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Objection Handling
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'salesperson';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'objection_handling',
      'Objection Handling',
      'Overcoming buyer resistance'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'objection_handling', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Visual Branding
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'brand_strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'visual_branding',
      'Visual Branding',
      'Logo, colors, and design systems'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'visual_branding', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- DevOps
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'software_engineer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'devops',
      'DevOps',
      'Deployment and infrastructure'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'devops', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Research Methodology
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'ai_researcher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'research_methodology',
      'Research Methodology',
      'Scientific research process'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'research_methodology', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Roadmap Planning
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'product_manager';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'roadmap_planning',
      'Roadmap Planning',
      'Prioritizing features'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'roadmap_planning', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Data Visualization
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'data_scientist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'data_visualization',
      'Data Visualization',
      'Communicating insights visually'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'data_visualization', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Editing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'writer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'editing',
      'Editing',
      'Refining and improving writing'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'editing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Stage Presence
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'speaker';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'stage_presence',
      'Stage Presence',
      'Commanding attention'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'stage_presence', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- UI Design
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'designer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'ui_design',
      'UI Design',
      'User interface design'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'ui_design', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Cinematography
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'video_producer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'cinematography',
      'Cinematography',
      'Camera work and lighting'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'cinematography', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Scenario Planning
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'strategist';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'scenario_planning',
      'Scenario Planning',
      'Planning for multiple futures'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'scenario_planning', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Client Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'consultant';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'client_management',
      'Client Management',
      'Managing consulting relationships'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'client_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Team Coaching
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'team_coaching',
      'Team Coaching',
      'Developing teams'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'team_coaching', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Self-Awareness
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'life_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'self_awareness',
      'Self-Awareness',
      'Building self-understanding'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'self_awareness', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Wisdom Transmission
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'philosopher';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'wisdom_transmission',
      'Wisdom Transmission',
      'Teaching timeless truths'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'wisdom_transmission', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Resilience Building
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'mindset_coach';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'resilience_building',
      'Resilience Building',
      'Developing mental toughness'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'resilience_building', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Systems Building
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'productivity_expert';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'systems_building',
      'Systems Building',
      'Creating productivity systems'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'systems_building', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Product Development
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'entrepreneur';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'product_development',
      'Product Development',
      'Building products customers love'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'product_development', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Crisis Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'operator';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'crisis_management',
      'Crisis Management',
      'Handling emergencies and setbacks'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'crisis_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Email Marketing
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'copywriter';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'email_marketing',
      'Email Marketing',
      'Email sequences and newsletters'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'email_marketing', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Paid Advertising
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'marketer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'paid_advertising',
      'Paid Advertising',
      'Running profitable ad campaigns'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'paid_advertising', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Relationship Building
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'salesperson';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'relationship_building',
      'Relationship Building',
      'Long-term customer relationships'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'relationship_building', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Debugging
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'software_engineer';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'debugging',
      'Debugging',
      'Finding and fixing bugs'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'debugging', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;


  -- Stakeholder Management
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = 'product_manager';

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      'stakeholder_management',
      'Stakeholder Management',
      'Aligning cross-functional teams'
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', 'stakeholder_management', v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;

  RAISE NOTICE 'Skills migrated';
END $$;

-- ==============
-- INSERT: traits
-- ==============
DO $$
DECLARE
  v_trait_id BIGINT;
BEGIN

  -- Openness to Experience
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_1',
    'Openness to Experience',
    'Big Five: Openness to Experience'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '1', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Conscientiousness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_2',
    'Conscientiousness',
    'Big Five: Conscientiousness'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '2', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Extraversion
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_3',
    'Extraversion',
    'Big Five: Extraversion'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '3', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Agreeableness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_4',
    'Agreeableness',
    'Big Five: Agreeableness'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '4', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Neuroticism
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_5',
    'Neuroticism',
    'Big Five: Neuroticism'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '5', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Imagination
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_11',
    'Imagination',
    'Big Five Facet: Imagination (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '11', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Artistic Interest
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_12',
    'Artistic Interest',
    'Big Five Facet: Artistic Interest (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '12', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Emotionality
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_13',
    'Emotionality',
    'Big Five Facet: Emotionality (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '13', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Adventurousness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_14',
    'Adventurousness',
    'Big Five Facet: Adventurousness (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '14', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Intellect
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_15',
    'Intellect',
    'Big Five Facet: Intellect (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '15', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Liberalism
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_16',
    'Liberalism',
    'Big Five Facet: Liberalism (part of Openness to Experience)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '16', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Self-Efficacy
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_21',
    'Self-Efficacy',
    'Big Five Facet: Self-Efficacy (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '21', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Orderliness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_22',
    'Orderliness',
    'Big Five Facet: Orderliness (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '22', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Dutifulness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_23',
    'Dutifulness',
    'Big Five Facet: Dutifulness (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '23', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Achievement Striving
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_24',
    'Achievement Striving',
    'Big Five Facet: Achievement Striving (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '24', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Self-Discipline
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_25',
    'Self-Discipline',
    'Big Five Facet: Self-Discipline (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '25', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Cautiousness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_26',
    'Cautiousness',
    'Big Five Facet: Cautiousness (part of Conscientiousness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '26', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Warmth
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_31',
    'Warmth',
    'Big Five Facet: Warmth (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '31', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Gregariousness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_32',
    'Gregariousness',
    'Big Five Facet: Gregariousness (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '32', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Assertiveness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_33',
    'Assertiveness',
    'Big Five Facet: Assertiveness (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '33', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Activity
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_34',
    'Activity',
    'Big Five Facet: Activity (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '34', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Excitement-Seeking
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_35',
    'Excitement-Seeking',
    'Big Five Facet: Excitement-Seeking (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '35', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Positive Emotions
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_36',
    'Positive Emotions',
    'Big Five Facet: Positive Emotions (part of Extraversion)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '36', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Trust
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_41',
    'Trust',
    'Big Five Facet: Trust (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '41', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Straightforwardness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_42',
    'Straightforwardness',
    'Big Five Facet: Straightforwardness (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '42', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Altruism
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_43',
    'Altruism',
    'Big Five Facet: Altruism (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '43', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Compliance
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_44',
    'Compliance',
    'Big Five Facet: Compliance (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '44', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Modesty
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_45',
    'Modesty',
    'Big Five Facet: Modesty (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '45', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Tender-Mindedness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_46',
    'Tender-Mindedness',
    'Big Five Facet: Tender-Mindedness (part of Agreeableness)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '46', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Anxiety
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_51',
    'Anxiety',
    'Big Five Facet: Anxiety (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '51', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Angry Hostility
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_52',
    'Angry Hostility',
    'Big Five Facet: Angry Hostility (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '52', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Depression
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_53',
    'Depression',
    'Big Five Facet: Depression (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '53', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Self-Consciousness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_54',
    'Self-Consciousness',
    'Big Five Facet: Self-Consciousness (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '54', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Impulsiveness
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_55',
    'Impulsiveness',
    'Big Five Facet: Impulsiveness (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '55', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;


  -- Vulnerability
  INSERT INTO traits (code, name, description)
  VALUES (
    'trait_56',
    'Vulnerability',
    'Big Five Facet: Vulnerability (part of Neuroticism)'
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', '56', v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;

  RAISE NOTICE 'Traits migrated';
END $$;

-- ==============
-- VALIDATION
-- ==============
DO $$
DECLARE
  v_domains INT;
  v_specs INT;
  v_skills INT;
  v_traits INT;
  v_mappings INT;
BEGIN
  SELECT COUNT(*) INTO v_domains FROM domains WHERE mmos_metadata IS NOT NULL;
  SELECT COUNT(*) INTO v_specs FROM specializations WHERE mmos_metadata IS NOT NULL;
  SELECT COUNT(*) INTO v_skills FROM skills;
  SELECT COUNT(*) INTO v_traits FROM traits WHERE code LIKE 'trait_%';
  SELECT COUNT(*) INTO v_mappings FROM mmos_id_mappings;

  RAISE NOTICE '=== Migration Summary ===';
  RAISE NOTICE 'Domains (MMOS): %', v_domains;
  RAISE NOTICE 'Specializations (MMOS): %', v_specs;
  RAISE NOTICE 'Skills (MMOS): %', v_skills;
  RAISE NOTICE 'Traits (MMOS): %', v_traits;
  RAISE NOTICE 'ID Mappings: %', v_mappings;
  RAISE NOTICE '';
  RAISE NOTICE 'Expected: domains=6, specs=22, skills=73, traits=35, mappings=136';
END $$;
