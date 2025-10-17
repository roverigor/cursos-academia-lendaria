#!/usr/bin/env python3
"""
Generic script to save InnerLens fragments to MMOS database.
Works for ANY mind, not specific to one person.

Usage:
    python save_fragments_to_mmos.py \\
      --mind alan_nicolas \\
      --fragments testing/validation/profiles/alan_fragments.json \\
      --source testing/validation/text_samples/alan_nicolas.txt \\
      --title "Estilo Escrita Provocativa" \\
      --type self_analysis
"""

import sqlite3
import json
import argparse
from pathlib import Path
from datetime import datetime

# Constants
DB_PATH = Path("/Users/oalanicolas/Documents/Code/mente_lendaria/docs/mmos/mmos.db")

def get_db_connection():
    """Create database connection."""
    return sqlite3.connect(DB_PATH)

def get_or_create_mind(conn, mind_slug, display_name=None):
    """Get mind_id or create if doesn't exist."""
    cursor = conn.cursor()

    # Try to find existing
    cursor.execute("SELECT id, display_name FROM minds WHERE slug = ?", (mind_slug,))
    result = cursor.fetchone()

    if result:
        return result[0], result[1]

    # Create new mind
    if not display_name:
        display_name = mind_slug.replace('_', ' ').title()

    cursor.execute("""
        INSERT INTO minds (slug, display_name, created_at)
        VALUES (?, ?, ?)
    """, (mind_slug, display_name, datetime.now().isoformat()))
    conn.commit()

    return cursor.lastrowid, display_name

def create_source_entry(conn, mind_id, mind_slug, source_title, source_file, source_type):
    """Create source entry for analyzed text."""
    cursor = conn.cursor()

    source_id = f"{mind_slug}_{source_type}_{datetime.now().strftime('%Y%m%d')}"

    # Check if already exists
    cursor.execute("SELECT id FROM sources WHERE source_id = ?", (source_id,))
    existing = cursor.fetchone()

    if existing:
        print(f"   ✅ Using existing source {source_id} (id={existing[0]})")
        return existing[0]

    # Read source file
    with open(source_file, 'r', encoding='utf-8') as f:
        content = f.read()

    word_count = len(content.split())
    char_count = len(content)

    cursor.execute("""
        INSERT INTO sources (
            source_id, mind_id, title, file_path, type,
            clean_content, word_count, char_count,
            structural_format, status, processed_at,
            tier, priority_score
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        source_id, mind_id, source_title, str(source_file),
        source_type, content, word_count, char_count,
        "auto_detected", "extracted", datetime.now().isoformat(),
        1, 1.0
    ))

    conn.commit()
    db_source_id = cursor.lastrowid

    print(f"   ✅ Created source {source_id} (id={db_source_id})")
    return db_source_id

def save_fragments(conn, mind_id, source_id, fragments_file):
    """Save MIU fragments to database."""
    cursor = conn.cursor()

    # Load fragments
    with open(fragments_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    fragments = data.get('fragments', [])

    if not fragments:
        print("   ⚠️  No fragments found in JSON file")
        return 0

    print(f"   📊 Found {len(fragments)} fragments")

    # Save each fragment
    saved_count = 0
    for i, frag in enumerate(fragments, 1):
        fragment_id = frag['fragment_id']

        cursor.execute("""
            INSERT OR REPLACE INTO fragments (
                id, mind_id, source_id,
                fragment_type, content,
                cognitive_theme, layer, domains,
                confidence, why_significant, evidence_type,
                hierarchy, raw_excerpt, char_start, char_end,
                extraction_method, extraction_version, pipeline_version,
                created_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            fragment_id,
            mind_id,
            source_id,
            "written_thought",
            json.dumps({
                "verbatim": frag['content']['verbatim'],
                "word_count": frag['content']['word_count'],
                "clause_count": frag['content']['clause_count'],
                "structure": frag.get('structure', {}),
                "attribution": frag.get('attribution', {})
            }),
            "extracted_miu",
            None,  # layer assigned later by analysis
            json.dumps(["cognitive", "linguistic"]),
            1.0,  # High confidence for verbatim extractions
            "MIU extracted from InnerLens for personality profiling",
            "explicit_statement",
            "fundamental",
            frag['content']['verbatim'],
            frag['source'].get('char_position', [None, None])[0],
            frag['source'].get('char_position', [None, None])[1],
            frag['extraction'].get('method', 'unknown'),
            frag['extraction'].get('version', '1.0.0'),
            "innerlens_v1.1",
            frag['extraction'].get('timestamp', datetime.now().isoformat())
        ))

        saved_count += 1

        if i % 10 == 0:
            print(f"      💾 Saved {i}/{len(fragments)} fragments...")

    conn.commit()
    print(f"   ✅ Saved all {saved_count} fragments")

    return saved_count

def verify_save(conn, mind_id, source_id, expected_count):
    """Verify fragments were saved correctly."""
    cursor = conn.cursor()

    cursor.execute("""
        SELECT COUNT(*) FROM fragments
        WHERE mind_id = ? AND source_id = ?
    """, (mind_id, source_id))

    actual_count = cursor.fetchone()[0]

    if actual_count == expected_count:
        print(f"   ✅ Verification passed: {actual_count}/{expected_count} fragments saved")
        return True
    else:
        print(f"   ❌ Verification FAILED: {actual_count}/{expected_count} fragments saved")
        return False

def main():
    parser = argparse.ArgumentParser(description='Save InnerLens fragments to MMOS database (generic, works for any mind)')
    parser.add_argument('--mind', required=True, help='Mind slug (e.g., alan_nicolas, sam_altman)')
    parser.add_argument('--fragments', required=True, help='Path to fragments.json file')
    parser.add_argument('--source', required=True, help='Path to original source text file')
    parser.add_argument('--title', required=True, help='Human-readable source title')
    parser.add_argument('--type', required=True, help='Source type (self_analysis, article, podcast_transcript, etc)')
    parser.add_argument('--display-name', help='Optional display name for mind (default: auto-generate from slug)')

    args = parser.parse_args()

    # Validate inputs
    fragments_file = Path(args.fragments)
    source_file = Path(args.source)

    if not fragments_file.exists():
        print(f"❌ Error: Fragments file not found: {fragments_file}")
        return 1

    if not source_file.exists():
        print(f"❌ Error: Source file not found: {source_file}")
        return 1

    # Connect to database
    conn = get_db_connection()

    try:
        print("=" * 70)
        print("InnerLens → MMOS: Save Fragments (Generic)")
        print("=" * 70)
        print()

        # Step 1: Get or create mind
        print(f"🔍 Step 1: Get/Create Mind '{args.mind}'...")
        mind_id, display_name = get_or_create_mind(conn, args.mind, args.display_name)
        print(f"   ✅ Mind: {display_name} (id={mind_id})")

        # Step 2: Create source entry
        print(f"\n📄 Step 2: Create Source Entry...")
        source_id = create_source_entry(conn, mind_id, args.mind, args.title, source_file, args.type)

        # Step 3: Save fragments
        print(f"\n💾 Step 3: Save Fragments...")
        saved_count = save_fragments(conn, mind_id, source_id, fragments_file)

        # Step 4: Verify
        print(f"\n🔍 Step 4: Verify Save...")
        verification_passed = verify_save(conn, mind_id, source_id, saved_count)

        # Summary
        print("\n" + "=" * 70)
        if verification_passed:
            print("✅ SUCCESS!")
        else:
            print("⚠️  COMPLETED WITH WARNINGS")
        print("=" * 70)
        print()
        print(f"📊 Summary:")
        print(f"   • Mind: {display_name} (id={mind_id})")
        print(f"   • Source: {args.title} (id={source_id})")
        print(f"   • Fragments: {saved_count} MIUs saved")
        print(f"   • Database: {DB_PATH}")
        print()

        return 0 if verification_passed else 1

    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return 2

    finally:
        conn.close()

if __name__ == "__main__":
    exit(main())
