#!/usr/bin/env python3
"""Generate straightforward INSERT statements from Supabase taxonomy data."""
import os
from pathlib import Path

import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

OUTPUT_SQL = "supabase/migrations/simple_taxonomy_inserts.sql"

load_dotenv()
SUPABASE_DB_URL = os.getenv("SUPABASE_DB_URL")


def escape_sql(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


def get_connection():
    if not SUPABASE_DB_URL:
        raise SystemExit("SUPABASE_DB_URL not configured")

    conn_string = SUPABASE_DB_URL.replace("?sslmode=require", "")
    return psycopg2.connect(
        conn_string,
        sslmode="require",
        cursor_factory=RealDictCursor,
    )


def generate_sql():
    with get_connection() as conn:
        cur = conn.cursor()

        lines = []
        lines.append("-- Simple INSERT migration - generated from Supabase data")
        lines.append("-- Inserts taxonomy rows without touching structure\n")

        # Domains
        lines.append("-- Domains")
        cur.execute(
            "SELECT code, name, description FROM domains ORDER BY sort_order"
        )
        for row in cur.fetchall():
            lines.append(
                "INSERT INTO domains (code, name, description) "
                f"VALUES ({escape_sql(row['code'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])}) "
                "ON CONFLICT (code) DO NOTHING;"
            )
        lines.append("")

        # Specializations
        lines.append("-- Specializations")
        cur.execute(
            """
            SELECT sp.code, sp.name, sp.description, d.code AS domain_code
            FROM specializations sp
            JOIN domains d ON d.id = sp.domain_id
            ORDER BY sp.sort_order
            """
        )
        for row in cur.fetchall():
            lines.append(
                "INSERT INTO specializations (domain_id, code, name, description) "
                "SELECT d.id, "
                f"{escape_sql(row['code'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])} "
                "FROM domains d WHERE d.code = "
                f"{escape_sql(row['domain_code'])} ON CONFLICT (code) DO NOTHING;"
            )
        lines.append("")

        # Skills
        lines.append("-- Skills")
        cur.execute(
            """
            SELECT sk.code, sk.name, sk.description, sp.code AS specialization_code
            FROM skills sk
            JOIN specializations sp ON sp.id = sk.specialization_id
            ORDER BY sk.sort_order
            """
        )
        for row in cur.fetchall():
            lines.append(
                "INSERT INTO skills (specialization_id, code, name, description) "
                "SELECT sp.id, "
                f"{escape_sql(row['code'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])} "
                "FROM specializations sp WHERE sp.code = "
                f"{escape_sql(row['specialization_code'])} ON CONFLICT (code) DO NOTHING;"
            )
        lines.append("")

        # Traits
        lines.append("-- Traits")
        cur.execute("SELECT code, name, description FROM traits ORDER BY code")
        for row in cur.fetchall():
            lines.append(
                "INSERT INTO traits (code, name, description) "
                f"VALUES ({escape_sql(row['code'])}, {escape_sql(row['name'])}, {escape_sql(row['description'])}) "
                "ON CONFLICT (code) DO NOTHING;"
            )
        lines.append("")

        Path(OUTPUT_SQL).write_text("\n".join(lines))
        print(f"✅ Generated: {OUTPUT_SQL}")
        print(f"   Lines: {len(lines)}")


if __name__ == "__main__":
    generate_sql()
