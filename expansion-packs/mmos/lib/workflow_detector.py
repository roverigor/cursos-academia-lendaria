"""
MMOS Workflow Detector

Automatically detects which workflow to execute (greenfield vs brownfield)
and determines the appropriate mode based on available data.

Part of MMOS-E001 Story 1: Auto-Detection Engine
"""

import os
import requests
from typing import Dict, List, Optional, Tuple
from datetime import datetime, timedelta

from .metadata_manager import read_metadata, get_pipeline_status


# Cache for web search results (24 hour TTL)
_web_search_cache: Dict[str, Tuple[bool, datetime]] = {}
CACHE_TTL_HOURS = 24


def auto_detect_workflow(person_slug: str, person_name: Optional[str] = None) -> Dict:
    """
    Main entry point: Auto-detect workflow type and mode.

    Args:
        person_slug: File-safe slug (e.g., "pedro_valerio")
        person_name: Human-readable name for web search (optional)

    Returns:
        {
            "workflow_type": "greenfield" | "brownfield",
            "mode": str,
            "decision_log": List[str]
        }

    Example:
        result = auto_detect_workflow("pedro_valerio", "Pedro Valério")
        # {"workflow_type": "greenfield", "mode": "public", "decision_log": [...]}
    """
    decision_log = []

    # Step 1: Detect workflow type
    workflow_type = detect_workflow_type(person_slug, decision_log)

    # Step 2: Detect mode
    if workflow_type == "greenfield":
        mode = detect_greenfield_mode(person_slug, person_name, decision_log)
    else:  # brownfield
        mode = detect_brownfield_mode(person_slug, decision_log)

    # Step 3: Log final decision
    print(f"\n{'='*60}")
    print(f"🔍 Auto-Detection Results")
    print(f"{'='*60}")
    print(f"Workflow Type: {workflow_type}")
    print(f"Mode: {mode}")
    print(f"\nDecision Log:")
    for log_entry in decision_log:
        print(f"  {log_entry}")
    print(f"{'='*60}\n")

    return {
        "workflow_type": workflow_type,
        "mode": mode,
        "decision_log": decision_log
    }


def detect_workflow_type(person_slug: str, decision_log: List[str]) -> str:
    """
    Detect if workflow should be greenfield or brownfield.

    Logic:
    1. Check if outputs/minds/{slug}/ exists
    2. If NO → greenfield (new mind)
    3. If YES → Check metadata.yaml
       - Missing → greenfield (interrupted)
       - Exists → Check pipeline_status
         - < "completed" → greenfield (resume)
         - == "completed" → brownfield (update)

    Args:
        person_slug: Mind slug
        decision_log: List to append decisions to

    Returns:
        "greenfield" | "brownfield"
    """
    mind_path = f"outputs/minds/{person_slug}"

    # Check if mind directory exists
    if not os.path.exists(mind_path):
        decision_log.append("✓ Mind directory not found → greenfield")
        return "greenfield"

    decision_log.append("ℹ Mind directory exists")

    # Check if metadata.yaml exists
    metadata = read_metadata(person_slug)
    if metadata is None:
        decision_log.append("✓ metadata.yaml missing (interrupted) → greenfield")
        return "greenfield"

    decision_log.append("ℹ metadata.yaml found")

    # Check pipeline status
    pipeline_status = metadata['mind']['pipeline_status']
    decision_log.append(f"ℹ Pipeline status: {pipeline_status}")

    if pipeline_status == 'completed':
        decision_log.append("✓ Pipeline completed → brownfield")
        return "brownfield"
    else:
        decision_log.append(f"✓ Pipeline incomplete ({pipeline_status}) → greenfield (resume)")
        return "greenfield"


def detect_greenfield_mode(person_slug: str, person_name: Optional[str],
                           decision_log: List[str]) -> str:
    """
    Detect greenfield mode: public | no-public-interviews | no-public-materials

    Logic:
    1. Run quick_web_search(person_name)
       - If content found → "public"
    2. If no web content, check sources/
       - If files exist → "no-public-materials"
    3. If neither → Ask user

    Args:
        person_slug: Mind slug
        person_name: Name for web search (optional)
        decision_log: List to append decisions to

    Returns:
        "public" | "no-public-interviews" | "no-public-materials"
    """
    # Use slug as name if not provided
    if person_name is None:
        person_name = person_slug.replace('_', ' ').replace('-', ' ').title()

    # Step 1: Try web search
    has_web_content = quick_web_search(person_name)

    if has_web_content:
        decision_log.append(f"✓ Web search found content for '{person_name}' → public mode")
        return "public"

    decision_log.append(f"ℹ Web search: No public content found for '{person_name}'")

    # Step 2: Check if sources/ directory has files
    sources_path = f"outputs/minds/{person_slug}/sources/"
    if os.path.exists(sources_path) and _has_files(sources_path):
        file_count = len([f for f in os.listdir(sources_path)
                         if os.path.isfile(os.path.join(sources_path, f))])
        decision_log.append(f"✓ Found {file_count} file(s) in sources/ → no-public-materials mode")
        return "no-public-materials"

    decision_log.append("ℹ sources/ directory empty")

    # Step 3: Ask user
    decision_log.append("⚠ No web content and no materials → asking user")
    return _ask_user_for_input_method(person_name, decision_log)


def detect_brownfield_mode(person_slug: str, decision_log: List[str]) -> str:
    """
    Detect brownfield mode based on existing metadata.

    Logic:
    - Read metadata.yaml → extract source_type
    - Map to brownfield mode:
      - "public" → "public-update"
      - "no-public-interviews" | "no-public-materials" → "no-public-incremental"

    Args:
        person_slug: Mind slug
        decision_log: List to append decisions to

    Returns:
        "public-update" | "no-public-incremental"
    """
    metadata = read_metadata(person_slug)

    if metadata is None:
        # This shouldn't happen (already checked in detect_workflow_type)
        decision_log.append("⚠ Error: metadata.yaml missing for brownfield → defaulting to greenfield")
        raise ValueError(f"Metadata missing for brownfield mind: {person_slug}")

    source_type = metadata['mind']['source_type']
    decision_log.append(f"ℹ Metadata source_type: {source_type}")

    if source_type == "public":
        decision_log.append("✓ Public mind → public-update mode")
        return "public-update"
    elif source_type in ["no-public-interviews", "no-public-materials"]:
        decision_log.append(f"✓ Private mind ({source_type}) → no-public-incremental mode")
        return "no-public-incremental"
    else:
        # Edge case: unknown source_type (migration from another system)
        decision_log.append(f"⚠ Unknown source_type '{source_type}' → defaulting to no-public-incremental")
        return "no-public-incremental"


def quick_web_search(person_name: str) -> bool:
    """
    Quick web search to check if person has public content.

    Uses DuckDuckGo Instant Answer API (no API key required).
    Falls back gracefully if API is unavailable.

    Args:
        person_name: Name to search for

    Returns:
        True if public content found, False otherwise
    """
    # Check cache first
    if person_name in _web_search_cache:
        result, timestamp = _web_search_cache[person_name]
        if datetime.now() - timestamp < timedelta(hours=CACHE_TTL_HOURS):
            print(f"  [Cache] Web search for '{person_name}': {'Found' if result else 'Not found'}")
            return result

    print(f"  [Search] Searching for '{person_name}'...")

    try:
        # Use DuckDuckGo Instant Answer API (free, no key required)
        url = "https://api.duckduckgo.com/"
        params = {
            'q': person_name,
            'format': 'json',
            'no_html': 1,
            'skip_disambig': 1
        }

        response = requests.get(url, params=params, timeout=5)
        response.raise_for_status()

        data = response.json()

        # Check if we got meaningful results
        has_content = bool(
            data.get('Abstract') or
            data.get('AbstractText') or
            data.get('RelatedTopics')
        )

        # Cache result
        _web_search_cache[person_name] = (has_content, datetime.now())

        print(f"  [Search] Result: {'Found' if has_content else 'Not found'}")
        return has_content

    except requests.RequestException as e:
        print(f"  [Search] Web search failed: {e}")
        print(f"  [Search] Falling back to user input")
        return False
    except Exception as e:
        print(f"  [Search] Unexpected error: {e}")
        return False


def _has_files(directory: str) -> bool:
    """
    Check if directory has any files (not just subdirectories).

    Args:
        directory: Path to check

    Returns:
        True if directory contains files, False otherwise
    """
    if not os.path.exists(directory):
        return False

    for item in os.listdir(directory):
        item_path = os.path.join(directory, item)
        if os.path.isfile(item_path):
            return True

    return False


def _ask_user_for_input_method(person_name: str, decision_log: List[str]) -> str:
    """
    Ask user to choose between interviews or materials.

    Args:
        person_name: Name of person
        decision_log: List to append decision to

    Returns:
        "no-public-interviews" | "no-public-materials"
    """
    print(f"\n{'='*60}")
    print(f"No public content found for '{person_name}'.")
    print(f"\nHow would you like to create this cognitive clone?")
    print(f"{'='*60}")
    print(f"1. Conduct interviews (8-12 hours, highest fidelity)")
    print(f"2. I have materials (transcripts, documents, emails)")
    print(f"{'='*60}\n")

    while True:
        choice = input("Type 1 or 2: ").strip()

        if choice == "1":
            decision_log.append("✓ User selected: interviews → no-public-interviews mode")
            return "no-public-interviews"
        elif choice == "2":
            decision_log.append("✓ User selected: materials → no-public-materials mode")
            return "no-public-materials"
        else:
            print("Invalid choice. Please type 1 or 2.")


def clear_cache():
    """Clear web search cache (useful for testing)."""
    global _web_search_cache
    _web_search_cache = {}
    print("✓ Web search cache cleared")
