#!/usr/bin/env python3
"""
Extract metadata from mind directories and create metadata.yaml files.
Part of Story 3.1 - Backward Compatible Additions.

Usage:
    python3 extract_metadata.py <mind_directory>
    python3 extract_metadata.py outputs/minds/sam_altman
"""

import sys
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent / 'lib'))

from yaml_utils import write_yaml, read_yaml
from logger import setup_logging
from file_scanner import find_file, get_file_info


def extract_display_name_from_readme(readme_path: str) -> Optional[str]:
    """Extract display name from README.md first H1."""
    try:
        with open(readme_path, 'r', encoding='utf-8') as f:
            for line in f:
                match = re.match(r'^#\s+(.+)$', line.strip())
                if match:
                    # Clean up markdown formatting
                    name = match.group(1)
                    name = re.sub(r'\*\*|__|\*|_', '', name)  # Remove bold/italic
                    name = re.sub(r'\[([^\]]+)\]\([^\)]+\)', r'\1', name)  # Remove links
                    return name.strip()
        return None
    except Exception:
        return None


def extract_description_from_readme(readme_path: str) -> Optional[str]:
    """Extract description from README.md (first paragraph after H1)."""
    try:
        with open(readme_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            found_h1 = False
            description_lines = []

            for line in lines:
                line = line.strip()

                # Find first H1
                if not found_h1:
                    if re.match(r'^#\s+', line):
                        found_h1 = True
                    continue

                # Skip empty lines after H1
                if not line:
                    if description_lines:
                        break  # End of first paragraph
                    continue

                # Stop at next heading
                if re.match(r'^#+\s+', line):
                    break

                description_lines.append(line)

                # Limit to first paragraph (~3-5 lines)
                if len(description_lines) >= 5:
                    break

            if description_lines:
                return ' '.join(description_lines)
        return None
    except Exception:
        return None


def extract_tags_from_description(description: str) -> list:
    """Extract potential tags from description."""
    if not description:
        return []

    tags = []
    description_lower = description.lower()

    # Common role tags
    role_keywords = {
        'entrepreneur': 'entrepreneur',
        'ceo': 'ceo',
        'founder': 'founder',
        'investor': 'investor',
        'writer': 'writer',
        'author': 'author',
        'speaker': 'speaker',
        'consultant': 'consultant',
        'coach': 'coach',
        'professor': 'professor',
        'researcher': 'researcher',
        'scientist': 'scientist',
        'engineer': 'engineer',
        'developer': 'developer',
        'designer': 'designer',
        'marketer': 'marketer',
        'copywriter': 'copywriter',
        'ai': 'ai_leader',
        'artificial intelligence': 'ai_leader',
        'technology': 'technologist',
        'tech': 'technologist'
    }

    for keyword, tag in role_keywords.items():
        if keyword in description_lower and tag not in tags:
            tags.append(tag)

    return tags[:5]  # Limit to 5 tags


def generate_snake_case_id(directory_name: str) -> str:
    """Generate snake_case ID from directory name."""
    # Already snake_case, just validate
    if re.match(r'^[a-z0-9_]+$', directory_name):
        return directory_name

    # Convert to snake_case
    name = directory_name.lower()
    name = re.sub(r'[^\w\s]', '', name)  # Remove special chars
    name = re.sub(r'\s+', '_', name)  # Spaces to underscores
    return name


def extract_metadata(mind_dir: str, logger) -> Optional[Dict[str, Any]]:
    """
    Extract metadata from mind directory.

    Args:
        mind_dir: Path to mind directory (e.g., outputs/minds/sam_altman)
        logger: MigrationLogger instance

    Returns:
        Metadata dictionary, or None on error
    """
    mind_path = Path(mind_dir)

    if not mind_path.exists():
        logger.error(f"Mind directory not found: {mind_dir}")
        return None

    mind_id = generate_snake_case_id(mind_path.name)
    logger.info(f"Processing mind: {mind_id}")

    # Find README
    readme_path = find_file(mind_dir, 'README.md', recursive=False)
    if not readme_path:
        readme_path = find_file(str(mind_path / 'docs'), 'README.md', recursive=False)

    # Extract display name and description
    display_name = None
    description = None

    if readme_path:
        logger.info(f"  Found README: {readme_path}")
        display_name = extract_display_name_from_readme(str(readme_path))
        description = extract_description_from_readme(str(readme_path))

    # Fallback: Use directory name as display name
    if not display_name:
        # Convert snake_case to Title Case
        display_name = ' '.join(word.capitalize() for word in mind_id.split('_'))
        logger.warning(f"  Could not extract display_name from README, using: {display_name}")

    # Get directory timestamps
    dir_info = get_file_info(mind_dir)
    created_at = datetime.fromtimestamp(dir_info.get('created_at', datetime.now().timestamp()))
    updated_at = datetime.fromtimestamp(dir_info.get('modified_at', datetime.now().timestamp()))

    # Infer status from artifacts
    status = infer_status(mind_path, logger)

    # Extract tags
    tags = extract_tags_from_description(description or display_name)

    # Build metadata
    metadata = {
        'mind': {
            'id': mind_id,
            'display_name': display_name,
            'status': status,
            'version': 'v1.0.0',
            'apex_score': 0.0,  # NEEDS_REVIEW flag
            'icp_match': 'medium',  # NEEDS_REVIEW flag
            'created_at': created_at.isoformat() + 'Z',
            'updated_at': updated_at.isoformat() + 'Z',
            'flags': {
                'needs_review': ['apex_score', 'icp_match']
            }
        }
    }

    # Optional fields
    if description:
        metadata['mind']['description'] = description

    if tags:
        metadata['mind']['tags'] = tags

    return metadata


def infer_status(mind_path: Path, logger) -> str:
    """Infer mind status from artifacts."""
    # Check for system prompts (implementation complete)
    system_prompts_dir = mind_path / 'system_prompts'
    if system_prompts_dir.exists() and any(system_prompts_dir.iterdir()):
        return 'completed'

    # Check for synthesis artifacts
    synthesis_artifacts = [
        mind_path / 'artifacts' / 'communication_templates.md',
        mind_path / 'synthesis' / 'communication_templates.md'
    ]
    if any(f.exists() for f in synthesis_artifacts):
        return 'synthesis'

    # Check for analysis artifacts (Layer artifacts)
    analysis_artifacts = [
        mind_path / 'artifacts' / 'beliefs_core.yaml',
        mind_path / 'artifacts' / 'values_hierarchy.yaml',
        mind_path / 'artifacts' / 'mental_models.md'
    ]
    if any(f.exists() for f in analysis_artifacts):
        return 'analysis'

    # Check for sources
    sources_dir = mind_path / 'sources'
    if sources_dir.exists() and any(sources_dir.iterdir()):
        return 'research'

    # Default to draft
    return 'draft'


def main():
    """Main execution."""
    if len(sys.argv) < 2:
        print("Usage: python3 extract_metadata.py <mind_directory>")
        print("Example: python3 extract_metadata.py outputs/minds/sam_altman")
        sys.exit(1)

    mind_dir = sys.argv[1]
    logger = setup_logging('extract_metadata')

    logger.section(f"Extracting Metadata - {Path(mind_dir).name}")

    # Extract metadata
    metadata = extract_metadata(mind_dir, logger)

    if not metadata:
        logger.error("Failed to extract metadata")
        sys.exit(1)

    # Output path
    output_path = Path(mind_dir) / 'metadata.yaml'

    # Check if already exists
    if output_path.exists():
        logger.warning(f"metadata.yaml already exists: {output_path}")
        existing = read_yaml(str(output_path))

        # Check if it's a manual file (has no flags.needs_review)
        if existing and 'mind' in existing:
            if 'flags' not in existing['mind'] or not existing['mind'].get('flags', {}).get('needs_review'):
                logger.skip("Skipping - appears to be manually curated (no needs_review flags)")
                logger.info("To regenerate, delete metadata.yaml first")
                sys.exit(0)

    # Write metadata
    if write_yaml(str(output_path), metadata, backup=True):
        logger.success(f"Created metadata.yaml: {output_path}")

        # Show summary
        mind = metadata['mind']
        logger.info(f"  ID: {mind['id']}")
        logger.info(f"  Display Name: {mind['display_name']}")
        logger.info(f"  Status: {mind['status']}")
        logger.info(f"  Version: {mind['version']}")

        if 'flags' in mind:
            needs_review = mind['flags'].get('needs_review', [])
            if needs_review:
                logger.warning(f"  ⚠ Manual review needed for: {', '.join(needs_review)}")
    else:
        logger.error(f"Failed to write metadata.yaml: {output_path}")
        sys.exit(1)

    sys.exit(logger.summary())


if __name__ == '__main__':
    main()
