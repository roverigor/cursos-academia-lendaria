#!/usr/bin/env python3
"""
Save InnerLens Big Five analysis results to MMOS database.

This script:
1. Creates Big Five traits (5 main + 30 facets) in the traits table
2. Creates source entries for analyzed texts
3. Saves MIU fragments to the fragments table
4. Saves Big Five scores to the trait_scores table

Usage:
    python save_to_database.py

Database: /Users/oalanicolas/Documents/Code/mente_lendaria/outputs/database/mmos.db
"""

import sqlite3
import json
import yaml
from pathlib import Path
from datetime import datetime
import uuid

# Paths
DB_PATH = Path("/Users/oalanicolas/Documents/Code/mente_lendaria/outputs/database/mmos.db")
TESTING_DIR = Path(__file__).parent.parent / "testing"
RESULTS_DIR = TESTING_DIR / "results"
DATA_DIR = TESTING_DIR / "data"

# Big Five traits and facets mapping
BIG_FIVE_TRAITS = {
    1: {
        "name": "Openness to Experience",
        "domain": "cognitive",
        "subdomain": "intellectual_curiosity",
        "scale_min": "Low Openness (Practical, conventional)",
        "scale_max": "High Openness (Curious, imaginative)",
        "facets": {
            11: {"name": "Imagination", "subdomain": "fantasy"},
            12: {"name": "Artistic Interest", "subdomain": "aesthetics"},
            13: {"name": "Emotionality", "subdomain": "feelings"},
            14: {"name": "Adventurousness", "subdomain": "actions"},
            15: {"name": "Intellect", "subdomain": "ideas"},
            16: {"name": "Liberalism", "subdomain": "values"}
        }
    },
    2: {
        "name": "Conscientiousness",
        "domain": "behavioral",
        "subdomain": "goal_directedness",
        "scale_min": "Low Conscientiousness (Spontaneous, flexible)",
        "scale_max": "High Conscientiousness (Organized, disciplined)",
        "facets": {
            21: {"name": "Self-Efficacy", "subdomain": "competence"},
            22: {"name": "Orderliness", "subdomain": "order"},
            23: {"name": "Dutifulness", "subdomain": "duty"},
            24: {"name": "Achievement Striving", "subdomain": "achievement"},
            25: {"name": "Self-Discipline", "subdomain": "discipline"},
            26: {"name": "Cautiousness", "subdomain": "deliberation"}
        }
    },
    3: {
        "name": "Extraversion",
        "domain": "social",
        "subdomain": "social_energy",
        "scale_min": "Low Extraversion (Reserved, quiet)",
        "scale_max": "High Extraversion (Outgoing, energetic)",
        "facets": {
            31: {"name": "Warmth", "subdomain": "friendliness"},
            32: {"name": "Gregariousness", "subdomain": "sociability"},
            33: {"name": "Assertiveness", "subdomain": "leadership"},
            34: {"name": "Activity", "subdomain": "energy"},
            35: {"name": "Excitement-Seeking", "subdomain": "thrill"},
            36: {"name": "Positive Emotions", "subdomain": "enthusiasm"}
        }
    },
    4: {
        "name": "Agreeableness",
        "domain": "social",
        "subdomain": "cooperation",
        "scale_min": "Low Agreeableness (Skeptical, competitive)",
        "scale_max": "High Agreeableness (Compassionate, cooperative)",
        "facets": {
            41: {"name": "Trust", "subdomain": "faith_in_others"},
            42: {"name": "Straightforwardness", "subdomain": "honesty"},
            43: {"name": "Altruism", "subdomain": "helpfulness"},
            44: {"name": "Compliance", "subdomain": "cooperation"},
            45: {"name": "Modesty", "subdomain": "humility"},
            46: {"name": "Tender-Mindedness", "subdomain": "empathy"}
        }
    },
    5: {
        "name": "Neuroticism",
        "domain": "emotional",
        "subdomain": "emotional_stability",
        "scale_min": "Low Neuroticism (Calm, emotionally stable)",
        "scale_max": "High Neuroticism (Anxious, emotionally reactive)",
        "facets": {
            51: {"name": "Anxiety", "subdomain": "worry"},
            52: {"name": "Angry Hostility", "subdomain": "irritability"},
            53: {"name": "Depression", "subdomain": "sadness"},
            54: {"name": "Self-Consciousness", "subdomain": "insecurity"},
            55: {"name": "Impulsiveness", "subdomain": "self_control"},
            56: {"name": "Vulnerability", "subdomain": "stress_response"}
        }
    }
}


def get_db_connection():
    """Create database connection."""
    return sqlite3.connect(DB_PATH)


def create_big_five_traits(conn):
    """Insert Big Five traits and facets into traits table."""
    cursor = conn.cursor()

    print("Creating Big Five traits...")

    # Insert main traits
    for code, trait_data in BIG_FIVE_TRAITS.items():
        cursor.execute("""
            INSERT OR IGNORE INTO traits (
                code, name, description, domain, subdomain,
                scale_min_label, scale_max_label,
                related_frameworks, created_at, version
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            code,
            trait_data["name"],
            f"Big Five: {trait_data['name']}",
            trait_data["domain"],
            trait_data["subdomain"],
            trait_data["scale_min"],
            trait_data["scale_max"],
            json.dumps(["Big Five (OCEAN)", "NEO-PI-R"]),
            datetime.now().isoformat(),
            "1.0"
        ))
        print(f"  ✅ Created trait {code}: {trait_data['name']}")

        # Insert facets
        for facet_code, facet_data in trait_data["facets"].items():
            cursor.execute("""
                INSERT OR IGNORE INTO traits (
                    code, name, description, domain, subdomain,
                    scale_min_label, scale_max_label,
                    related_frameworks, created_at, version
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                facet_code,
                facet_data["name"],
                f"Big Five Facet: {facet_data['name']} (part of {trait_data['name']})",
                trait_data["domain"],
                facet_data["subdomain"],
                f"Low {facet_data['name']}",
                f"High {facet_data['name']}",
                json.dumps([f"Big Five: {trait_data['name']}"]),
                datetime.now().isoformat(),
                "1.0"
            ))
            print(f"    ✅ Created facet {facet_code}: {facet_data['name']}")

    conn.commit()
    print(f"\n✅ Created {len(BIG_FIVE_TRAITS)} traits + {sum(len(t['facets']) for t in BIG_FIVE_TRAITS.values())} facets = {len(BIG_FIVE_TRAITS) + sum(len(t['facets']) for t in BIG_FIVE_TRAITS.values())} total")


def create_source_entry(conn, mind_id, mind_slug, source_title, file_path, source_type="blog_post"):
    """Create a source entry for the analyzed text."""
    cursor = conn.cursor()

    source_id = f"{mind_slug}_{source_type}_{datetime.now().strftime('%Y%m%d')}"

    # Check if source already exists
    cursor.execute("SELECT id FROM sources WHERE source_id = ?", (source_id,))
    existing = cursor.fetchone()

    if existing:
        db_source_id = existing[0]
        print(f"✅ Using existing source {source_id} (id={db_source_id}) for {mind_slug}")
        return db_source_id

    # Read the source file
    with open(file_path, 'r', encoding='utf-8') as f:
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
        source_id, mind_id, source_title, str(file_path),
        source_type, content, word_count, char_count,
        "monologue_format", "extracted", datetime.now().isoformat(),
        1, 1.0
    ))

    conn.commit()

    # Get the ID of the created source
    cursor.execute("SELECT id FROM sources WHERE source_id = ?", (source_id,))
    db_source_id = cursor.fetchone()[0]

    print(f"✅ Created source {source_id} (id={db_source_id}) for {mind_slug}")

    return db_source_id


def save_fragments(conn, mind_id, source_id, fragments_file):
    """Save MIU fragments to the fragments table."""
    cursor = conn.cursor()

    print(f"Loading fragments from {fragments_file}...")

    with open(fragments_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    fragments = data.get('fragments', [])

    print(f"Saving {len(fragments)} fragments...")

    for i, frag in enumerate(fragments, 1):
        fragment_id = frag['fragment_id']

        # Map InnerLens MIU to MMOS fragment structure
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
            "written_thought",  # MIUs from blog/podcast transcripts
            json.dumps({
                "verbatim": frag['content']['verbatim'],
                "word_count": frag['content']['word_count'],
                "clause_count": frag['content']['clause_count'],
                "structure": frag['structure'],
                "context": frag['context']
            }),
            "linguistic_pattern",  # Generic theme
            None,  # No DNA Mental layer assigned yet
            json.dumps(["cognitive", "linguistic"]),
            1.0,  # High confidence - these are verbatim extractions
            "MIU extracted from InnerLens Big Five analysis",
            "explicit_statement",
            "fundamental",
            frag['content']['verbatim'],
            frag['source']['char_position'][0] if 'char_position' in frag['source'] else None,
            frag['source']['char_position'][1] if 'char_position' in frag['source'] else None,
            "claude_sonnet_4_miu",
            frag['extraction']['version'],
            "innerlens_v1.0",
            frag['extraction']['timestamp']
        ))

        if i % 5 == 0:
            print(f"  Saved {i}/{len(fragments)} fragments...")

    conn.commit()
    print(f"✅ Saved all {len(fragments)} fragments")


def save_trait_scores(conn, mind_id, profile_file):
    """Save Big Five scores to trait_scores table."""
    cursor = conn.cursor()

    print(f"Loading profile from {profile_file}...")

    with open(profile_file, 'r', encoding='utf-8') as f:
        profile = yaml.safe_load(f)

    traits_data = profile['traits']

    print("Saving trait scores...")

    # Map trait names to codes
    trait_name_to_code = {
        "openness": 1,
        "conscientiousness": 2,
        "extraversion": 3,
        "agreeableness": 4,
        "neuroticism": 5
    }

    for trait_name, trait_data in traits_data.items():
        trait_code = trait_name_to_code[trait_name]

        # Collect evidence fragment IDs
        evidence_ids = [eq['source'] for eq in trait_data.get('evidence_quotes', [])]

        # Normalize score to 0-1 range (from 0-100)
        final_score = trait_data['score'] / 100.0

        score_id = str(uuid.uuid4())

        cursor.execute("""
            INSERT OR REPLACE INTO trait_scores (
                id, mind_id, trait_code,
                final_score, confidence, consistency,
                evidence_count, evidence_fragment_ids,
                is_central_trait, hierarchy, calculated_at, pipeline_version
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            score_id,
            mind_id,
            trait_code,
            final_score,
            trait_data['confidence'],
            1.0,  # Assume high consistency within single analysis
            trait_data['detection_statistics']['total_evidence_mius'],
            json.dumps(evidence_ids),
            1,  # All Big Five traits are central
            "fundamental",
            datetime.now().isoformat(),
            "innerlens_v1.0"
        ))

        print(f"  ✅ Saved {trait_name}: {trait_data['score']}/100 (confidence: {trait_data['confidence']:.2f})")

    conn.commit()
    print(f"✅ Saved all {len(traits_data)} trait scores")


def main():
    """Main execution."""
    print("=" * 60)
    print("InnerLens → MMOS Database Integration")
    print("=" * 60)
    print()

    # Connect to database
    conn = get_db_connection()

    try:
        # Step 1: Create Big Five traits
        print("\n📋 Step 1: Creating Big Five traits...")
        create_big_five_traits(conn)

        # Step 2: Process Sam Altman
        print("\n\n👤 Step 2: Processing Sam Altman...")
        sam_mind_id = 22
        sam_source_id = create_source_entry(
            conn, sam_mind_id, "sam_altman",
            "Three Observations",
            DATA_DIR / "sam_altman_sample.txt",
            "article"
        )

        save_fragments(
            conn, sam_mind_id, sam_source_id,
            RESULTS_DIR / "sam_altman_fragments.json"
        )

        save_trait_scores(
            conn, sam_mind_id,
            RESULTS_DIR / "sam_altman_bigfive_profile.yaml"
        )

        # Step 3: Process Naval Ravikant
        print("\n\n👤 Step 3: Processing Naval Ravikant...")
        naval_mind_id = 16
        naval_source_id = create_source_entry(
            conn, naval_mind_id, "naval_ravikant",
            "A Calm Mind, A Fit Body, A House Full of Love",
            DATA_DIR / "naval_sample.txt",
            "podcast_transcript"
        )

        save_fragments(
            conn, naval_mind_id, naval_source_id,
            RESULTS_DIR / "naval_fragments.json"
        )

        # Note: Naval's full profile wasn't saved to disk, only fragments
        print("  ⚠️  Naval's Big Five profile not saved to disk - skipping trait_scores")

        print("\n\n" + "=" * 60)
        print("✅ DATABASE INTEGRATION COMPLETE!")
        print("=" * 60)
        print()
        print("Summary:")
        print(f"  • Created 35 Big Five traits (5 main + 30 facets)")
        print(f"  • Saved {sam_mind_id} - Sam Altman: 18 fragments + 5 trait scores")
        print(f"  • Saved {naval_mind_id} - Naval Ravikant: 24 fragments")
        print()
        print(f"Database: {DB_PATH}")
        print()

    finally:
        conn.close()


if __name__ == "__main__":
    main()
