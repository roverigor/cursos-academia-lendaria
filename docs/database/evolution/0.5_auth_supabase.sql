-- =========================================================
-- 005_auth_supabase.sql — Passwordless Auth + RLS
-- =========================================================
-- Purpose: Magic Link authentication + automatic mind provisioning
-- Depends on: 0.3.sql (minds table must exist)
-- Philosophy: KISS - zero backend code needed
-- Version: 1.0
-- Date: 2025-10-26

-- =========================================================
-- 1) USER PROFILES (mapeia auth.users → minds)
-- =========================================================

CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY,                    -- = auth.users.id
  mind_id UUID NOT NULL UNIQUE REFERENCES minds(id) ON DELETE RESTRICT,

  -- Optional metadata
  onboarding_completed BOOLEAN DEFAULT false,
  preferences JSONB DEFAULT '{}'::jsonb,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- FK to Supabase auth.users
ALTER TABLE user_profiles
  ADD CONSTRAINT fk_user_profiles_auth
  FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_user_profiles_mind ON user_profiles (mind_id);

-- Trigger updated_at
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_user_profiles_updated') THEN
    CREATE TRIGGER trg_user_profiles_updated BEFORE UPDATE ON user_profiles
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- =========================================================
-- 2) FUNÇÃO: Retorna mind_id do usuário autenticado
-- =========================================================

CREATE OR REPLACE FUNCTION current_mind_id()
RETURNS uuid
LANGUAGE sql
STABLE
SECURITY DEFINER  -- Executa com permissões do owner (postgres)
AS $$
  SELECT mind_id FROM user_profiles WHERE id = auth.uid()
$$;

COMMENT ON FUNCTION current_mind_id IS 'Returns mind_id of authenticated user (via auth.uid())';

-- =========================================================
-- 3) TRIGGER: Provisiona mind + user_profile no signup
-- =========================================================

CREATE OR REPLACE FUNCTION provision_user_profile()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_mind_id uuid;
  v_slug text;
  v_display_name text;
  v_attempt int := 0;
  v_unique_slug text;
BEGIN
  -- Gera slug base do email (parte antes do @)
  v_slug := lower(split_part(NEW.email, '@', 1));

  -- Sanitiza slug (remove caracteres especiais)
  v_slug := regexp_replace(v_slug, '[^a-z0-9_]', '_', 'g');

  -- Display name: pega do metadata ou usa slug
  v_display_name := COALESCE(NEW.raw_user_meta_data->>'name', v_slug);

  -- Garante slug único (adiciona sufixo se necessário)
  v_unique_slug := v_slug;
  WHILE EXISTS (SELECT 1 FROM minds WHERE slug = v_unique_slug) LOOP
    v_attempt := v_attempt + 1;
    v_unique_slug := v_slug || '_' || v_attempt;

    -- Proteção contra loop infinito
    IF v_attempt > 100 THEN
      v_unique_slug := v_slug || '_' || gen_random_uuid()::text;
      EXIT;
    END IF;
  END LOOP;

  -- Cria a mind
  INSERT INTO minds (
    slug,
    display_name,
    subject_type,
    privacy_level,
    primary_language,
    short_bio,
    created_by
  )
  VALUES (
    v_unique_slug,
    v_display_name,
    'private_user',
    'private',
    COALESCE(NEW.raw_user_meta_data->>'language', 'pt'),
    '',
    NEW.id::text
  )
  RETURNING id INTO v_mind_id;

  -- Cria user_profile (link auth.users → minds)
  INSERT INTO user_profiles (id, mind_id)
  VALUES (NEW.id, v_mind_id);

  RAISE NOTICE 'User profile provisioned: user_id=%, mind_id=%, slug=%', NEW.id, v_mind_id, v_unique_slug;

  RETURN NEW;
END $$;

-- Trigger: dispara APÓS signup (INSERT em auth.users)
DROP TRIGGER IF EXISTS trg_provision_user_profile ON auth.users;
CREATE TRIGGER trg_provision_user_profile
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION provision_user_profile();

COMMENT ON FUNCTION provision_user_profile IS 'Auto-creates mind and user_profile on signup';

-- =========================================================
-- 4) RLS POLICIES - Row Level Security
-- =========================================================

-- ==================
-- user_profiles
-- ==================
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Usuários só veem seu próprio perfil
CREATE POLICY "users_view_own_profile"
  ON user_profiles
  FOR SELECT
  USING (id = auth.uid());

-- Usuários podem atualizar seu próprio perfil
CREATE POLICY "users_update_own_profile"
  ON user_profiles
  FOR UPDATE
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());

-- ==================
-- minds
-- ==================
ALTER TABLE minds ENABLE ROW LEVEL SECURITY;

-- Minds públicas são visíveis por todos (autenticados ou não)
CREATE POLICY "public_minds_visible_to_all"
  ON minds
  FOR SELECT
  USING (privacy_level = 'public');

-- Usuário vê sua própria mind (privada ou pública)
CREATE POLICY "users_view_own_mind"
  ON minds
  FOR SELECT
  USING (id = current_mind_id());

-- Usuário pode atualizar sua própria mind
CREATE POLICY "users_update_own_mind"
  ON minds
  FOR UPDATE
  USING (id = current_mind_id())
  WITH CHECK (id = current_mind_id());

-- ==================
-- sources
-- ==================
ALTER TABLE sources ENABLE ROW LEVEL SECURITY;

-- Usuário vê sources de minds públicas
CREATE POLICY "sources_of_public_minds"
  ON sources
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM minds
      WHERE minds.id = sources.mind_id
      AND minds.privacy_level = 'public'
    )
  );

-- Usuário vê suas próprias sources
CREATE POLICY "users_view_own_sources"
  ON sources
  FOR SELECT
  USING (mind_id = current_mind_id());

-- Usuário pode inserir sources na sua mind
CREATE POLICY "users_insert_own_sources"
  ON sources
  FOR INSERT
  WITH CHECK (mind_id = current_mind_id());

-- Usuário pode atualizar suas próprias sources
CREATE POLICY "users_update_own_sources"
  ON sources
  FOR UPDATE
  USING (mind_id = current_mind_id())
  WITH CHECK (mind_id = current_mind_id());

-- Usuário pode deletar suas próprias sources
CREATE POLICY "users_delete_own_sources"
  ON sources
  FOR DELETE
  USING (mind_id = current_mind_id());

-- ==================
-- fragments
-- ==================
ALTER TABLE fragments ENABLE ROW LEVEL SECURITY;

-- Usuário vê fragments de minds públicas
CREATE POLICY "fragments_of_public_minds"
  ON fragments
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM minds
      WHERE minds.id = fragments.mind_id
      AND minds.privacy_level = 'public'
    )
  );

-- Usuário vê seus próprios fragments
CREATE POLICY "users_view_own_fragments"
  ON fragments
  FOR SELECT
  USING (mind_id = current_mind_id());

-- Usuário pode inserir fragments na sua mind
CREATE POLICY "users_insert_own_fragments"
  ON fragments
  FOR INSERT
  WITH CHECK (mind_id = current_mind_id());

-- Usuário pode atualizar seus próprios fragments
CREATE POLICY "users_update_own_fragments"
  ON fragments
  FOR UPDATE
  USING (mind_id = current_mind_id())
  WITH CHECK (mind_id = current_mind_id());

-- Usuário pode deletar seus próprios fragments
CREATE POLICY "users_delete_own_fragments"
  ON fragments
  FOR DELETE
  USING (mind_id = current_mind_id());

-- ==================
-- mind_profiles (MMOS artifacts)
-- ==================
ALTER TABLE mind_profiles ENABLE ROW LEVEL SECURITY;

-- Usuário vê profiles de minds públicas
CREATE POLICY "profiles_of_public_minds"
  ON mind_profiles
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM minds
      WHERE minds.id = mind_profiles.mind_id
      AND minds.privacy_level = 'public'
    )
  );

-- Usuário vê seus próprios profiles
CREATE POLICY "users_view_own_profiles"
  ON mind_profiles
  FOR SELECT
  USING (mind_id = current_mind_id());

-- Usuário pode inserir profiles na sua mind
CREATE POLICY "users_insert_own_profiles"
  ON mind_profiles
  FOR INSERT
  WITH CHECK (mind_id = current_mind_id());

-- ==================
-- content_projects (CreatorOS)
-- ==================
ALTER TABLE content_projects ENABLE ROW LEVEL SECURITY;

-- Usuário vê seus próprios projetos (como creator)
CREATE POLICY "users_view_own_projects"
  ON content_projects
  FOR SELECT
  USING (creator_mind_id = current_mind_id());

-- Usuário pode criar projetos
CREATE POLICY "users_insert_own_projects"
  ON content_projects
  FOR INSERT
  WITH CHECK (creator_mind_id = current_mind_id());

-- Usuário pode atualizar seus próprios projetos
CREATE POLICY "users_update_own_projects"
  ON content_projects
  FOR UPDATE
  USING (creator_mind_id = current_mind_id())
  WITH CHECK (creator_mind_id = current_mind_id());

-- Usuário pode deletar seus próprios projetos
CREATE POLICY "users_delete_own_projects"
  ON content_projects
  FOR DELETE
  USING (creator_mind_id = current_mind_id());

-- ==================
-- content_pieces (CreatorOS)
-- ==================
ALTER TABLE content_pieces ENABLE ROW LEVEL SECURITY;

-- Usuário vê content_pieces dos seus projetos
CREATE POLICY "users_view_own_content"
  ON content_pieces
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM content_projects
      WHERE content_projects.id = content_pieces.project_id
      AND content_projects.creator_mind_id = current_mind_id()
    )
  );

-- Usuário pode inserir content nos seus projetos
CREATE POLICY "users_insert_own_content"
  ON content_pieces
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM content_projects
      WHERE content_projects.id = content_pieces.project_id
      AND content_projects.creator_mind_id = current_mind_id()
    )
  );

-- =========================================================
-- 5) HELPER FUNCTIONS (opcional mas útil)
-- =========================================================

-- Retorna display_name do usuário autenticado
CREATE OR REPLACE FUNCTION current_user_display_name()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
  SELECT m.display_name
  FROM minds m
  JOIN user_profiles up ON up.mind_id = m.id
  WHERE up.id = auth.uid()
$$;

-- Retorna slug do usuário autenticado
CREATE OR REPLACE FUNCTION current_user_slug()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
  SELECT m.slug
  FROM minds m
  JOIN user_profiles up ON up.mind_id = m.id
  WHERE up.id = auth.uid()
$$;

-- Verifica se usuário é owner de uma mind
CREATE OR REPLACE FUNCTION is_mind_owner(p_mind_id uuid)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
  SELECT EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth.uid()
    AND mind_id = p_mind_id
  )
$$;

-- =========================================================
-- 6) VIEWS COM RLS (dados do usuário autenticado)
-- =========================================================

-- View: Meu dashboard (dados do usuário logado)
CREATE OR REPLACE VIEW v_my_dashboard AS
SELECT
  m.id AS mind_id,
  m.slug,
  m.display_name,
  m.status,
  m.completeness,
  m.quality_grade,
  COUNT(DISTINCT s.id) AS sources_count,
  COUNT(DISTINCT f.id) AS fragments_count,
  COUNT(DISTINCT mp.id) AS profiles_count,
  COUNT(DISTINCT cp.id) AS content_projects_count,
  COUNT(DISTINCT cpi.id) AS content_pieces_count
FROM minds m
LEFT JOIN sources s ON s.mind_id = m.id
LEFT JOIN fragments f ON f.mind_id = m.id
LEFT JOIN mind_profiles mp ON mp.mind_id = m.id
LEFT JOIN content_projects cp ON cp.creator_mind_id = m.id
LEFT JOIN content_pieces cpi ON cpi.project_id = cp.id
WHERE m.id = current_mind_id()
GROUP BY m.id, m.slug, m.display_name, m.status, m.completeness, m.quality_grade;

-- =========================================================
-- 7) GRANTS (permissões para usuários autenticados)
-- =========================================================

-- Authenticated users podem ler lookup tables
GRANT SELECT ON categories TO authenticated;
GRANT SELECT ON tags TO authenticated;
GRANT SELECT ON traits TO authenticated;
GRANT SELECT ON domains TO authenticated;
GRANT SELECT ON specializations TO authenticated;
GRANT SELECT ON skills TO authenticated;

-- Authenticated users podem usar functions
GRANT EXECUTE ON FUNCTION current_mind_id() TO authenticated;
GRANT EXECUTE ON FUNCTION current_user_display_name() TO authenticated;
GRANT EXECUTE ON FUNCTION current_user_slug() TO authenticated;
GRANT EXECUTE ON FUNCTION is_mind_owner(uuid) TO authenticated;

-- =========================================================
-- COMMENTS & DOCUMENTATION
-- =========================================================

COMMENT ON TABLE user_profiles IS 'Maps Supabase auth.users to minds (1:1)';
COMMENT ON FUNCTION current_mind_id IS 'Returns mind_id of authenticated user';
COMMENT ON FUNCTION provision_user_profile IS 'Auto-provisions mind on signup (via trigger)';
COMMENT ON VIEW v_my_dashboard IS 'Dashboard data for authenticated user';

-- =========================================================
-- END OF SCRIPT
-- =========================================================
