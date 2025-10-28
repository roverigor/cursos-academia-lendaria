-- Fix empty descriptions in content_projects
-- Generated: 2025-10-28

BEGIN;

UPDATE content_projects
SET description = 'Domine Claude Code para automatizar workflows e criar aplicações inteligentes sem escrever código. Curso completo para founders que querem acelerar seus negócios com IA.'
WHERE slug = 'claude-code' AND (description = '' OR description IS NULL);

UPDATE content_projects
SET description = 'Aprenda a criar aulas que engajam e empolgam usando frameworks pedagógicos comprovados (GPS, Bloom''s Taxonomy, Semiótica da Imagem) com 20+ anos de experiência de Adriano de Marqui.'
WHERE slug = 'didatica-lendaria' AND (description = '' OR description IS NULL);

UPDATE content_projects
SET description = 'Crie aplicativos completos sem código usando IA generativa. Aprenda Vibecoding e transforme ideias em apps funcionais em minutos.'
WHERE slug = 'vibecoding' AND (description = '' OR description IS NULL);

UPDATE content_projects
SET description = 'Domine Supabase e construa backends completos sem escrever código backend. De autenticação a APIs em tempo real, tudo sem servidor.'
WHERE slug = 'supabase-zero-backend-completo' AND (description = '' OR description IS NULL);

UPDATE content_projects
SET description = 'Crie seu clone de IA para ganhar tempo ou vender expertise. Aprenda a mapear seu DNA mental e replicar seu conhecimento em escala.'
WHERE slug = 'meu-clone-ia' AND (description = '' OR description IS NULL);

COMMIT;

-- Validate
SELECT
  slug,
  name,
  CASE
    WHEN description = '' THEN 'EMPTY'
    WHEN description IS NULL THEN 'NULL'
    ELSE 'OK (' || LENGTH(description) || ' chars)'
  END as description_status
FROM content_projects
WHERE slug IN ('claude-code', 'didatica-lendaria', 'vibecoding', 'supabase-zero-backend-completo', 'meu-clone-ia', 'prompt-engineer')
ORDER BY slug;
