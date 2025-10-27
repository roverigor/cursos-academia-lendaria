#!/usr/bin/env python3
"""
Generate SIMPLE INSERT statements - NO structure changes
"""
import sqlite3
from pathlib import Path

DB_PATH = "outputs/database/mmos.db"
OUTPUT_SQL = "supabase/migrations/simple_taxonomy_inserts.sql"

def escape_sql(value):
    if value is None:
        return "NULL"
    if isinstance(value, (int, float)):
        return str(value)
    return "'" + str(value).replace("'", "''") + "'"

def generate_sql():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    sql_lines = []
    sql_lines.append("-- Simple INSERT migration - NO structure changes")
    sql_lines.append("-- Just inserts data into existing Supabase tables\n")

    # DOMAINS
    sql_lines.append("-- Domains (6 rows)")
    cursor.execute("SELECT * FROM domains ORDER BY sort_order")
    for row in cursor.fetchall():
        sql_lines.append(
            f"INSERT INTO domains (code, name, description) "
            f"VALUES ({escape_sql(row['id'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])}) "
            f"ON CONFLICT (code) DO NOTHING;"
        )
    sql_lines.append("")

    # SPECIALIZATIONS (need to lookup domain_id by code)
    sql_lines.append("-- Specializations (22 rows)")
    cursor.execute("SELECT * FROM specializations ORDER BY sort_order")
    for row in cursor.fetchall():
        sql_lines.append(
            f"INSERT INTO specializations (domain_id, code, name, description) "
            f"SELECT d.id, {escape_sql(row['id'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])} "
            f"FROM domains d WHERE d.code = {escape_sql(row['domain_id'])} "
            f"ON CONFLICT (code) DO NOTHING;"
        )
    sql_lines.append("")

    # SKILLS (need to lookup specialization_id by code)
    sql_lines.append("-- Skills (73 rows)")
    cursor.execute("SELECT * FROM skills ORDER BY sort_order")
    for row in cursor.fetchall():
        sql_lines.append(
            f"INSERT INTO skills (specialization_id, code, name, description) "
            f"SELECT s.id, {escape_sql(row['id'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])} "
            f"FROM specializations s WHERE s.code = {escape_sql(row['specialization_id'])} "
            f"ON CONFLICT (code) DO NOTHING;"
        )
    sql_lines.append("")

    # TRAITS
    sql_lines.append("-- Traits (35 rows)")
    cursor.execute("SELECT * FROM traits ORDER BY code")
    for row in cursor.fetchall():
        trait_code = f"trait_{row['code']}"
        sql_lines.append(
            f"INSERT INTO traits (code, name, description) "
            f"VALUES ({escape_sql(trait_code)}, {escape_sql(row['name'])}, {escape_sql(row['description'])}) "
            f"ON CONFLICT (code) DO NOTHING;"
        )
    sql_lines.append("")

    # VALIDATION
    sql_lines.append("-- Validation")
    sql_lines.append("SELECT 'domains' as table_name, COUNT(*) as count FROM domains WHERE code LIKE '%_%'")
    sql_lines.append("UNION ALL SELECT 'specializations', COUNT(*) FROM specializations WHERE code IS NOT NULL")
    sql_lines.append("UNION ALL SELECT 'skills', COUNT(*) FROM skills WHERE code IS NOT NULL")
    sql_lines.append("UNION ALL SELECT 'traits', COUNT(*) FROM traits WHERE code LIKE 'trait_%';")

    # Write
    output_path = Path(OUTPUT_SQL)
    output_path.write_text('\n'.join(sql_lines))

    print(f"✅ Generated: {OUTPUT_SQL}")
    print(f"   {len(sql_lines)} lines")
    print(f"\n   6 domains + 22 specs + 73 skills + 35 traits = 136 INSERTs")

    conn.close()

if __name__ == "__main__":
    generate_sql()
