#!/usr/bin/env python3
"""
Save InnerLens MIU fragments to Supabase (unified fragments schema).
Replaces save_fragments_to_mmos.py (SQLite) with Supabase integration.

Usage:
    python save_fragments_to_supabase.py \\
      --mind alan_nicolas \\
      --fragments alan_fragments.json \\
      --source alan_nicolas.txt \\
      --title "Self Analysis" \\
      --type self_analysis
"""

import os
import json
import argparse
from pathlib import Path
from datetime import datetime
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

# Load environment
load_dotenv()

SUPABASE_DB_URL = os.getenv('SUPABASE_DB_URL')

if not SUPABASE_DB_URL:
    raise ValueError("SUPABASE_DB_URL not set in .env")

def get_db_connection():
    """Create Supabase (PostgreSQL) connection."""
    # Remove SSL query param if present (handled separately)
    conn_string = SUPABASE_DB_URL.replace('?sslmode=require', '')

    return psycopg2.connect(
        conn_string,
        sslmode='require',
        cursor_factory=RealDictCursor
    )

def get_or_create_mind(conn, mind_slug, display_name=None):
    """Get mind UUID or create if doesn't exist."""
    cursor = conn.cursor()

    # Try to find existing
    cursor.execute("SELECT id, display_name FROM minds WHERE slug = %s", (mind_slug,))
    result = cursor.fetchone()

    if result:
        return result['id'], result['display_name']

    # Create new mind
    if not display_name:
        display_name = mind_slug.replace('_', ' ').title()

    cursor.execute("""
        INSERT INTO minds (slug, display_name, created_by)
        VALUES (%s, %s, %s)
        RETURNING id, display_name
    """, (mind_slug, display_name, 'innerlens'))

    conn.commit()
    result = cursor.fetchone()

    return result['id'], result['display_name']

def create_source_entry(conn, mind_id, mind_slug, source_title, source_file, source_type):
    """Create source entry for analyzed text."""
    cursor = conn.cursor()

    # Check if already exists (by title + mind_id)
    cursor.execute("""
        SELECT id FROM sources
        WHERE mind_id = %s AND title = %s
    """, (mind_id, source_title))
    existing = cursor.fetchone()

    if existing:
        print(f"   ✅ Using existing source: {source_title} (id={existing['id']})")
        return existing['id']

    # Read source file
    with open(source_file, 'r', encoding='utf-8') as f:
        content = f.read()

    cursor.execute("""
        INSERT INTO sources (
            mind_id, title, url, type,
            published_date, author, quality
        ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING id
    """, (
        mind_id,
        source_title,
        f"file://{source_file}",  # Local file reference
        source_type,
        datetime.now().date(),
        'self',  # Self-written
        'primary'  # InnerLens extractions are primary quality
    ))

    conn.commit()
    result = cursor.fetchone()
    db_source_id = result['id']

    print(f"   ✅ Created source: {source_title} (id={db_source_id})")
    return db_source_id

def count_words(text):
    """Count words in text."""
    return len(text.split())

def save_fragments(conn, mind_id, source_id, fragments_file):
    """Save MIU fragments to Supabase fragments table."""
    cursor = conn.cursor()

    # Load fragments
    with open(fragments_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    fragments = data.get('fragments', [])
    metadata = data.get('metadata', {})

    print(f"\n📦 Processing {len(fragments)} fragments...")

    inserted = 0
    skipped = 0

    for frag in fragments:
        fragment_id = frag.get('fragment_id')

        # Check if already exists
        cursor.execute("SELECT id FROM fragments WHERE metadata->>'fragment_id' = %s",
                      (fragment_id,))
        if cursor.fetchone():
            skipped += 1
            continue

        # Extract fields
        content_obj = frag.get('content', {})
        verbatim = content_obj.get('verbatim', '')

        structure = frag.get('structure', {})
        attribution = frag.get('attribution', {})

        # Map to unified schema
        fragment_type = 'miu'  # InnerLens MIU
        title = f"MIU: {fragment_id}"

        # Metadata (store ALL InnerLens fields)
        frag_metadata = {
            'fragment_id': fragment_id,
            'innerlens_version': metadata.get('innerlens_version'),
            'extraction_method': 'innerlens_llm',
            'structure': structure,
            'attribution': attribution,
            'context': frag.get('context', {}),
            'quality_flags': frag.get('quality_flags', {}),
            'linguistic_markers': frag.get('linguistic_markers', {})
        }

        # Tags (extract from structure/context)
        tags = []
        if structure.get('pronouns'):
            tags.append('first_person')
        if structure.get('modal_verbs'):
            tags.append('modal')
        if attribution.get('speaker') == 'subject':
            tags.append('direct_statement')

        word_count = count_words(verbatim)

        # Insert fragment
        cursor.execute("""
            INSERT INTO fragments (
                mind_id,
                source_id,
                type,
                title,
                content,
                tags,
                word_count,
                metadata
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING id
        """, (
            mind_id,
            source_id,
            fragment_type,
            title,
            verbatim,
            tags,
            word_count,
            json.dumps(frag_metadata)
        ))

        inserted += 1

        if inserted % 10 == 0:
            conn.commit()
            print(f"   Inserted {inserted}/{len(fragments)}...", end='\r')

    conn.commit()

    print(f"\n✅ Saved fragments:")
    print(f"   • Inserted: {inserted}")
    print(f"   • Skipped (duplicates): {skipped}")

    return inserted

def main():
    parser = argparse.ArgumentParser(
        description='Save InnerLens fragments to Supabase'
    )
    parser.add_argument('--mind', required=True, help='Mind slug (e.g., alan_nicolas)')
    parser.add_argument('--fragments', required=True, help='Path to fragments JSON file')
    parser.add_argument('--source', required=True, help='Path to source text file')
    parser.add_argument('--title', required=True, help='Source title')
    parser.add_argument('--type', default='self_analysis', help='Source type')
    parser.add_argument('--display-name', help='Mind display name (optional)')

    args = parser.parse_args()

    print("🚀 InnerLens → Supabase Fragment Saver\n")

    # Connect to Supabase
    print("🔌 Connecting to Supabase...")
    conn = get_db_connection()
    print("✅ Connected\n")

    try:
        # 1. Get or create mind
        print(f"👤 Processing mind: {args.mind}")
        mind_id, mind_name = get_or_create_mind(conn, args.mind, args.display_name)
        print(f"   ✅ Mind: {mind_name} (id={mind_id})\n")

        # 2. Create source entry
        print(f"📄 Processing source: {args.title}")
        source_id = create_source_entry(
            conn,
            mind_id,
            args.mind,
            args.title,
            args.source,
            args.type
        )

        # 3. Save fragments
        inserted_count = save_fragments(
            conn,
            mind_id,
            source_id,
            args.fragments
        )

        # 4. Summary
        print(f"\n✅ Complete!")
        print(f"\n📊 Summary:")
        print(f"   Mind: {mind_name} ({args.mind})")
        print(f"   Source: {args.title}")
        print(f"   Fragments inserted: {inserted_count}")
        print(f"\n💡 Next step: Generate embeddings")
        print(f"   node scripts/database/generate_embeddings.js")

    except Exception as e:
        print(f"\n❌ Error: {e}")
        conn.rollback()
        raise

    finally:
        conn.close()

if __name__ == '__main__':
    main()
