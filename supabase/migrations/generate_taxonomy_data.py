#!/usr/bin/env python3
"""
Generate complete SQL INSERT statements from SQLite MMOS taxonomy data
"""
import sqlite3
import json
from pathlib import Path

DB_PATH = "outputs/database/mmos.db"
OUTPUT_SQL = "supabase/migrations/20251027012200_v0_8_0_taxonomy_data.sql"

def escape_sql(value):
    """Escape SQL string values"""
    if value is None:
        return "NULL"
    if isinstance(value, (int, float)):
        return str(value)
    # Escape single quotes
    return "'" + str(value).replace("'", "''") + "'"

def generate_sql():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    sql_lines = []
    sql_lines.append("-- =========================================================")
    sql_lines.append("-- v0.8.0 — MMOS Taxonomy Data")
    sql_lines.append("-- Generated from: outputs/database/mmos.db")
    sql_lines.append("-- =========================================================\n")

    # ==============
    # DOMAINS
    # ==============
    sql_lines.append("-- ==============")
    sql_lines.append("-- INSERT: domains")
    sql_lines.append("-- ==============")
    sql_lines.append("DO $$")
    sql_lines.append("DECLARE")
    sql_lines.append("  v_domain_id BIGINT;")
    sql_lines.append("BEGIN")

    cursor.execute("SELECT * FROM domains ORDER BY sort_order")
    for row in cursor.fetchall():
        metadata = {
            'icon': row['icon'] or '',
            'sort_order': row['sort_order']
        }

        sql_lines.append(f"""
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    {escape_sql(row['id'])},
    {escape_sql(row['name'])},
    {escape_sql(row['description'])},
    '{json.dumps(metadata)}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('domain', {escape_sql(row['id'])}, v_domain_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;
""")

    sql_lines.append("  RAISE NOTICE 'Domains migrated';")
    sql_lines.append("END $$;\n")

    # ==============
    # SPECIALIZATIONS
    # ==============
    sql_lines.append("-- ==============")
    sql_lines.append("-- INSERT: specializations")
    sql_lines.append("-- ==============")
    sql_lines.append("DO $$")
    sql_lines.append("DECLARE")
    sql_lines.append("  v_spec_id BIGINT;")
    sql_lines.append("  v_domain_id BIGINT;")
    sql_lines.append("BEGIN")

    cursor.execute("SELECT * FROM specializations ORDER BY sort_order")
    for row in cursor.fetchall():
        metadata = {
            'icon': row['icon'] or '',
            'sort_order': row['sort_order']
        }

        sql_lines.append(f"""
  -- {row['name']}
  SELECT supabase_id INTO v_domain_id
  FROM mmos_id_mappings
  WHERE entity_type = 'domain' AND sqlite_id = {escape_sql(row['domain_id'])};

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      {escape_sql(row['id'])},
      {escape_sql(row['name'])},
      {escape_sql(row['description'])},
      '{json.dumps(metadata)}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;

    IF v_spec_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('specialization', {escape_sql(row['id'])}, v_spec_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;
""")

    sql_lines.append("  RAISE NOTICE 'Specializations migrated';")
    sql_lines.append("END $$;\n")

    # ==============
    # SKILLS
    # ==============
    sql_lines.append("-- ==============")
    sql_lines.append("-- INSERT: skills")
    sql_lines.append("-- ==============")
    sql_lines.append("DO $$")
    sql_lines.append("DECLARE")
    sql_lines.append("  v_skill_id BIGINT;")
    sql_lines.append("  v_spec_id BIGINT;")
    sql_lines.append("BEGIN")

    cursor.execute("SELECT * FROM skills ORDER BY sort_order")
    for row in cursor.fetchall():
        sql_lines.append(f"""
  -- {row['name']}
  SELECT supabase_id INTO v_spec_id
  FROM mmos_id_mappings
  WHERE entity_type = 'specialization' AND sqlite_id = {escape_sql(row['specialization_id'])};

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      {escape_sql(row['id'])},
      {escape_sql(row['name'])},
      {escape_sql(row['description'])}
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;

    IF v_skill_id IS NOT NULL THEN
      INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
      VALUES ('skill', {escape_sql(row['id'])}, v_skill_id)
      ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
    END IF;
  END IF;
""")

    sql_lines.append("  RAISE NOTICE 'Skills migrated';")
    sql_lines.append("END $$;\n")

    # ==============
    # TRAITS
    # ==============
    sql_lines.append("-- ==============")
    sql_lines.append("-- INSERT: traits")
    sql_lines.append("-- ==============")
    sql_lines.append("DO $$")
    sql_lines.append("DECLARE")
    sql_lines.append("  v_trait_id BIGINT;")
    sql_lines.append("BEGIN")

    cursor.execute("SELECT * FROM traits ORDER BY code")
    for row in cursor.fetchall():
        trait_code = f"trait_{row['code']}"

        sql_lines.append(f"""
  -- {row['name']}
  INSERT INTO traits (code, name, description)
  VALUES (
    {escape_sql(trait_code)},
    {escape_sql(row['name'])},
    {escape_sql(row['description'])}
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;

  IF v_trait_id IS NOT NULL THEN
    INSERT INTO mmos_id_mappings (entity_type, sqlite_id, supabase_id)
    VALUES ('trait', {escape_sql(str(row['code']))}, v_trait_id)
    ON CONFLICT (entity_type, sqlite_id) DO NOTHING;
  END IF;
""")

    sql_lines.append("  RAISE NOTICE 'Traits migrated';")
    sql_lines.append("END $$;\n")

    # ==============
    # VALIDATION
    # ==============
    sql_lines.append("""-- ==============
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
""")

    # Write to file
    output_path = Path(OUTPUT_SQL)
    output_path.write_text('\n'.join(sql_lines))

    print(f"✅ Generated: {OUTPUT_SQL}")
    print(f"   Lines: {len(sql_lines)}")

    # Stats
    cursor.execute("SELECT COUNT(*) FROM domains")
    domains = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM specializations")
    specs = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM skills")
    skills = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM traits")
    traits = cursor.fetchone()[0]

    print(f"\n📊 Data to migrate:")
    print(f"   Domains: {domains}")
    print(f"   Specializations: {specs}")
    print(f"   Skills: {skills}")
    print(f"   Traits: {traits}")
    print(f"   Total mappings: {domains + specs + skills + traits}")

    conn.close()

if __name__ == "__main__":
    generate_sql()
