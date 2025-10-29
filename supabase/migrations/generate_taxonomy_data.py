#!/usr/bin/env python3
"""
Generate SQL INSERT statements from the live Supabase taxonomy tables.

Usage:
    SUPABASE_DB_URL=postgresql://... python supabase/migrations/generate_taxonomy_data.py
"""
import json
import os
from pathlib import Path

import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

OUTPUT_SQL = "supabase/migrations/20251027012200_v0_8_0_taxonomy_data.sql"

load_dotenv()
SUPABASE_DB_URL = os.getenv("SUPABASE_DB_URL")


def escape_sql(value):
    """Escape SQL string values for inclusion in plain text files."""
    if value is None:
        return "NULL"
    if isinstance(value, (int, float)):
        return str(value)
    return "'" + str(value).replace("'", "''") + "'"


def get_connection():
    if not SUPABASE_DB_URL:
        raise SystemExit(
            "❌ SUPABASE_DB_URL not set. Export it or add it to your .env before running."
        )

    # Strip trailing sslmode so psycopg2 can manage SSL configuration explicitly
    conn_string = SUPABASE_DB_URL.replace("?sslmode=require", "")

    return psycopg2.connect(
        conn_string,
        sslmode="require",
        cursor_factory=RealDictCursor,
    )


def generate_sql():
    with get_connection() as conn:
        cursor = conn.cursor()

        sql_lines = []
        sql_lines.append("-- =========================================================")
        sql_lines.append("-- v0.8.0 — MMOS Taxonomy Data")
        sql_lines.append("-- Source: Supabase (minds taxonomy tables)")
        sql_lines.append("-- Snapshot generated via generate_taxonomy_data.py")
        sql_lines.append("-- =========================================================\n")

        # Domains
        sql_lines.append("-- ==============")
        sql_lines.append("-- INSERT: domains")
        sql_lines.append("-- ==============")
        sql_lines.append("DO $$")
        sql_lines.append("DECLARE")
        sql_lines.append("  v_domain_id BIGINT;")
        sql_lines.append("BEGIN")

        cursor.execute(
            "SELECT code, name, description, mmos_metadata, sort_order, icon"
            " FROM domains ORDER BY sort_order"
        )
        for row in cursor.fetchall():
            metadata = {
                "icon": row.get("icon") or "",
                "sort_order": row.get("sort_order"),
                "source": "supabase_snapshot",
            }

            sql_lines.append(
                f"""
  INSERT INTO domains (code, name, description, mmos_metadata)
  VALUES (
    {escape_sql(row['code'])},
    {escape_sql(row['name'])},
    {escape_sql(row['description'])},
    '{json.dumps(metadata)}'::jsonb
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_domain_id;
"""
            )

        sql_lines.append("  RAISE NOTICE 'Domains exported';")
        sql_lines.append("END $$;\n")

        # Specializations
        sql_lines.append("-- ==============")
        sql_lines.append("-- INSERT: specializations")
        sql_lines.append("-- ==============")
        sql_lines.append("DO $$")
        sql_lines.append("DECLARE")
        sql_lines.append("  v_spec_id BIGINT;")
        sql_lines.append("  v_domain_id BIGINT;")
        sql_lines.append("BEGIN")

        cursor.execute(
            """
            SELECT sp.code,
                   sp.name,
                   sp.description,
                   sp.mmos_metadata,
                   sp.sort_order,
                   sp.icon,
                   d.code AS domain_code
            FROM specializations sp
            JOIN domains d ON d.id = sp.domain_id
            ORDER BY sp.sort_order
            """
        )
        for row in cursor.fetchall():
            metadata = {
                "icon": row.get("icon") or "",
                "sort_order": row.get("sort_order"),
                "source": "supabase_snapshot",
            }

            sql_lines.append(
                f"""
  -- {row['name']}
  SELECT id INTO v_domain_id
  FROM domains
  WHERE code = {escape_sql(row['domain_code'])};

  IF v_domain_id IS NOT NULL THEN
    INSERT INTO specializations (domain_id, code, name, description, mmos_metadata)
    VALUES (
      v_domain_id,
      {escape_sql(row['code'])},
      {escape_sql(row['name'])},
      {escape_sql(row['description'])},
      '{json.dumps(metadata)}'::jsonb
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_spec_id;
  END IF;
"""
            )

        sql_lines.append("  RAISE NOTICE 'Specializations exported';")
        sql_lines.append("END $$;\n")

        # Skills
        sql_lines.append("-- ==============")
        sql_lines.append("-- INSERT: skills")
        sql_lines.append("-- ==============")
        sql_lines.append("DO $$")
        sql_lines.append("DECLARE")
        sql_lines.append("  v_skill_id BIGINT;")
        sql_lines.append("  v_spec_id BIGINT;")
        sql_lines.append("BEGIN")

        cursor.execute(
            """
            SELECT sk.code,
                   sk.name,
                   sk.description,
                   sk.sort_order,
                   sp.code AS specialization_code
            FROM skills sk
            JOIN specializations sp ON sp.id = sk.specialization_id
            ORDER BY sk.sort_order
            """
        )
        for row in cursor.fetchall():
            sql_lines.append(
                f"""
  -- {row['name']}
  SELECT id INTO v_spec_id
  FROM specializations
  WHERE code = {escape_sql(row['specialization_code'])};

  IF v_spec_id IS NOT NULL THEN
    INSERT INTO skills (specialization_id, code, name, description)
    VALUES (
      v_spec_id,
      {escape_sql(row['code'])},
      {escape_sql(row['name'])},
      {escape_sql(row['description'])}
    )
    ON CONFLICT (code) DO NOTHING
    RETURNING id INTO v_skill_id;
  END IF;
"""
            )

        sql_lines.append("  RAISE NOTICE 'Skills exported';")
        sql_lines.append("END $$;\n")

        # Traits
        sql_lines.append("-- ==============")
        sql_lines.append("-- INSERT: traits")
        sql_lines.append("-- ==============")
        sql_lines.append("DO $$")
        sql_lines.append("DECLARE")
        sql_lines.append("  v_trait_id BIGINT;")
        sql_lines.append("BEGIN")

        cursor.execute("SELECT * FROM traits ORDER BY code")
        for row in cursor.fetchall():
            sql_lines.append(
                f"""
  INSERT INTO traits (code, name, description)
  VALUES (
    {escape_sql(row['code'])},
    {escape_sql(row['name'])},
    {escape_sql(row['description'])}
  )
  ON CONFLICT (code) DO NOTHING
  RETURNING id INTO v_trait_id;
"""
            )

        sql_lines.append("  RAISE NOTICE 'Traits exported';")
        sql_lines.append("END $$;\n")

        # Validation summary
        sql_lines.append(
            """-- ==============
-- VALIDATION
-- ==============
DO $$
DECLARE
  v_domains INT;
  v_specs INT;
  v_skills INT;
  v_traits INT;
BEGIN
  SELECT COUNT(*) INTO v_domains FROM domains;
  SELECT COUNT(*) INTO v_specs FROM specializations;
  SELECT COUNT(*) INTO v_skills FROM skills;
  SELECT COUNT(*) INTO v_traits FROM traits WHERE code LIKE 'trait_%';

  RAISE NOTICE '=== Taxonomy snapshot ===';
  RAISE NOTICE 'Domains: %', v_domains;
  RAISE NOTICE 'Specializations: %', v_specs;
  RAISE NOTICE 'Skills: %', v_skills;
  RAISE NOTICE 'Traits: %', v_traits;
END $$;
"""
        )

        Path(OUTPUT_SQL).write_text("\n".join(sql_lines))
        print(f"✅ Generated: {OUTPUT_SQL}")
        print(f"   Lines: {len(sql_lines)}")


if __name__ == "__main__":
    generate_sql()
