#!/usr/bin/env python3
"""
Catalog all sources in mind directories and create sources_master.yaml.
Part of Story 3.1 - Backward Compatible Additions.

Usage:
    python3 catalog_sources.py <mind_directory>
    python3 catalog_sources.py outputs/minds/sam_altman
"""

import sys
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, List, Optional

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent / 'lib'))

from yaml_utils import write_yaml, read_yaml
from logger import setup_logging
from file_scanner import scan_directory, get_file_info, count_words, get_relative_path


def generate_source_id(file_path: Path) -> str:
    """Generate source ID from file path."""
    # Use relative path from sources/ and convert to snake_case ID
    name = file_path.stem  # filename without extension

    # Clean up to snake_case
    name = name.lower()
    name = re.sub(r'[^\w\s-]', '', name)  # Remove special chars except dash
    name = re.sub(r'[-\s]+', '-', name)  # Normalize separators to dash

    return name


def infer_source_type(file_path: Path, sources_dir: Path) -> str:
    """Infer source type from directory structure or filename."""
    relative = file_path.relative_to(sources_dir)
    parts = relative.parts

    # Check parent directories for type hints
    for part in parts:
        part_lower = part.lower()

        if 'interview' in part_lower:
            return 'interview'
        elif 'book' in part_lower:
            return 'book'
        elif 'article' in part_lower:
            return 'article'
        elif 'podcast' in part_lower:
            return 'podcast'
        elif 'video' in part_lower:
            return 'video'
        elif 'testimony' in part_lower or 'testimon' in part_lower:
            return 'testimony'
        elif 'blog' in part_lower or 'post' in part_lower:
            return 'blog'
        elif 'paper' in part_lower or 'whitepaper' in part_lower:
            return 'whitepaper'

    # Check filename
    filename_lower = file_path.stem.lower()

    if 'interview' in filename_lower or 'lex-fridman' in filename_lower:
        return 'interview'
    elif 'book' in filename_lower:
        return 'book'
    elif 'testimony' in filename_lower:
        return 'testimony'
    elif 'blog' in filename_lower or 'post' in filename_lower:
        return 'blog'
    elif 'podcast' in filename_lower:
        return 'podcast'

    # Default
    return 'article'


def extract_title_from_file(file_path: str) -> Optional[str]:
    """Extract title from first H1 in file."""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                match = re.match(r'^#\s+(.+)$', line.strip())
                if match:
                    title = match.group(1)
                    # Clean markdown formatting
                    title = re.sub(r'\*\*|__|\*|_', '', title)
                    title = re.sub(r'\[([^\]]+)\]\([^\)]+\)', r'\1', title)
                    return title.strip()
    except Exception:
        pass

    return None


def extract_url_from_file(file_path: str) -> Optional[str]:
    """Extract URL from file content (markdown links or plain URLs)."""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read(2000)  # First 2000 chars

            # Look for markdown links
            match = re.search(r'\[([^\]]+)\]\((https?://[^\)]+)\)', content)
            if match:
                return match.group(2)

            # Look for plain URLs
            match = re.search(r'(https?://[^\s\)]+)', content)
            if match:
                return match.group(1)
    except Exception:
        pass

    return None


def catalog_source(file_path: Path, sources_dir: Path, mind_id: str, logger) -> Dict[str, Any]:
    """
    Catalog a single source file.

    Args:
        file_path: Path to source file
        sources_dir: Root sources directory
        mind_id: Mind identifier
        logger: Logger instance

    Returns:
        Source metadata dictionary
    """
    source_id = generate_source_id(file_path)
    source_type = infer_source_type(file_path, sources_dir)

    # Extract title
    title = extract_title_from_file(str(file_path))
    if not title:
        # Fallback: Use filename as title
        title = file_path.stem.replace('_', ' ').replace('-', ' ').title()

    # Extract URL
    url = extract_url_from_file(str(file_path))

    # Get file info
    file_info = get_file_info(str(file_path))
    word_count = count_words(str(file_path))

    # Get relative path from sources/
    rel_path = get_relative_path(str(file_path), str(sources_dir.parent))

    # Build source metadata
    source = {
        'id': source_id,
        'mind_id': mind_id,
        'type': source_type,
        'title': title,
        'file_path': rel_path,
        'status': 'processed',  # Sources already exist, assume processed
        'priority': 'medium',  # Default, needs manual review
        'confidence': 'medium',  # Default
        'word_count': word_count
    }

    # Optional fields
    if url:
        source['url'] = url

    if file_info.get('modified_at'):
        processed_at = datetime.fromtimestamp(file_info['modified_at'])
        source['processed_at'] = processed_at.isoformat() + 'Z'

    # Notes about manual review needed
    source['_notes'] = "Priority and layer_relevance require manual review"

    return source


def catalog_sources(mind_dir: str, logger) -> Optional[Dict[str, Any]]:
    """
    Catalog all sources in mind directory.

    Args:
        mind_dir: Path to mind directory
        logger: MigrationLogger instance

    Returns:
        Sources catalog dictionary, or None on error
    """
    mind_path = Path(mind_dir)

    if not mind_path.exists():
        logger.error(f"Mind directory not found: {mind_dir}")
        return None

    mind_id = mind_path.name
    sources_dir = mind_path / 'sources'

    if not sources_dir.exists():
        logger.warning(f"No sources/ directory found in {mind_dir}")
        return {
            'sources': [],
            '_notes': 'No sources directory found - empty catalog created'
        }

    logger.info(f"Scanning sources directory: {sources_dir}")

    # Scan for source files
    extensions = ['.md', '.txt', '.pdf']
    source_files = scan_directory(
        str(sources_dir),
        extensions=extensions,
        recursive=True,
        exclude_dirs={'.git', 'node_modules', '__pycache__'}
    )

    # Exclude sources_master.yaml itself
    source_files = [f for f in source_files if f.name != 'sources_master.yaml']

    logger.info(f"Found {len(source_files)} source files")

    if not source_files:
        logger.warning("No source files found")
        return {
            'sources': [],
            '_notes': 'No source files found'
        }

    # Catalog each source
    sources = []
    for file_path in source_files:
        try:
            source = catalog_source(file_path, sources_dir, mind_id, logger)
            sources.append(source)
            logger.info(f"  ✓ {source['id']} ({source['type']}) - {source['word_count']} words")
        except Exception as e:
            logger.error(f"  ✗ Failed to catalog {file_path}: {e}")

    # Build catalog
    catalog = {
        'sources': sources,
        '_metadata': {
            'total_sources': len(sources),
            'cataloged_at': datetime.now().isoformat() + 'Z',
            'requires_manual_review': ['priority', 'layer_relevance', 'confidence']
        }
    }

    return catalog


def merge_with_existing(existing_catalog: Dict[str, Any], new_catalog: Dict[str, Any],
                       logger) -> Dict[str, Any]:
    """
    Merge new catalog with existing, preserving manual edits.

    Args:
        existing_catalog: Existing sources_master.yaml content
        new_catalog: Newly generated catalog
        logger: Logger instance

    Returns:
        Merged catalog
    """
    if not existing_catalog or 'sources' not in existing_catalog:
        return new_catalog

    existing_sources = {s['id']: s for s in existing_catalog['sources']}
    new_sources = new_catalog['sources']

    merged_sources = []

    for new_source in new_sources:
        source_id = new_source['id']

        if source_id in existing_sources:
            # Source exists - preserve manual edits
            existing = existing_sources[source_id]

            # Keep manually edited fields (priority, layer_relevance, confidence, notes)
            manual_fields = ['priority', 'layer_relevance', 'confidence', 'notes']

            merged = new_source.copy()
            for field in manual_fields:
                if field in existing:
                    # Check if it was manually edited (not default value)
                    if field == 'priority' and existing[field] != 'medium':
                        merged[field] = existing[field]
                    elif field == 'confidence' and existing[field] != 'medium':
                        merged[field] = existing[field]
                    elif field == 'layer_relevance' and existing.get(field):
                        merged[field] = existing[field]
                    elif field == 'notes' and existing.get(field):
                        merged[field] = existing[field]

            merged_sources.append(merged)
            logger.debug(f"  Merged existing source: {source_id}")
        else:
            # New source
            merged_sources.append(new_source)
            logger.info(f"  Added new source: {source_id}")

    # Build merged catalog
    merged_catalog = new_catalog.copy()
    merged_catalog['sources'] = merged_sources

    return merged_catalog


def main():
    """Main execution."""
    if len(sys.argv) < 2:
        print("Usage: python3 catalog_sources.py <mind_directory>")
        print("Example: python3 catalog_sources.py outputs/minds/sam_altman")
        sys.exit(1)

    mind_dir = sys.argv[1]
    logger = setup_logging('catalog_sources')

    logger.section(f"Cataloging Sources - {Path(mind_dir).name}")

    # Catalog sources
    catalog = catalog_sources(mind_dir, logger)

    if catalog is None:
        logger.error("Failed to catalog sources")
        sys.exit(1)

    # Output path
    output_path = Path(mind_dir) / 'sources' / 'sources_master.yaml'

    # Check if already exists (idempotency)
    existing_catalog = None
    if output_path.exists():
        logger.info(f"Existing sources_master.yaml found: {output_path}")
        existing_catalog = read_yaml(str(output_path))

        if existing_catalog:
            logger.info("Merging with existing catalog (preserving manual edits)")
            catalog = merge_with_existing(existing_catalog, catalog, logger)

    # Write catalog
    if write_yaml(str(output_path), catalog, backup=True):
        logger.success(f"Created sources_master.yaml: {output_path}")

        # Show summary
        source_count = len(catalog.get('sources', []))
        logger.info(f"  Total sources: {source_count}")

        # Count by type
        if source_count > 0:
            types = {}
            for source in catalog['sources']:
                source_type = source.get('type', 'unknown')
                types[source_type] = types.get(source_type, 0) + 1

            logger.info("  Sources by type:")
            for source_type, count in sorted(types.items()):
                logger.info(f"    - {source_type}: {count}")

        if '_metadata' in catalog:
            needs_review = catalog['_metadata'].get('requires_manual_review', [])
            if needs_review:
                logger.warning(f"  ⚠ Manual review needed for: {', '.join(needs_review)}")
    else:
        logger.error(f"Failed to write sources_master.yaml: {output_path}")
        sys.exit(1)

    sys.exit(logger.summary())


if __name__ == '__main__':
    main()
