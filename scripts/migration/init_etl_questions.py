#!/usr/bin/env python3
"""
Initialize kb/etl_questions.yaml template for future ETL processing.
Part of Story 3.1 - Backward Compatible Additions.

Usage:
    python3 init_etl_questions.py <mind_directory>
    python3 init_etl_questions.py outputs/minds/sam_altman
"""

import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, Any

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent / 'lib'))

from yaml_utils import write_yaml
from logger import setup_logging


def create_etl_template(mind_id: str) -> Dict[str, Any]:
    """
    Create ETL questions template.

    Args:
        mind_id: Mind identifier

    Returns:
        Template dictionary
    """
    template = {
        '# ETL Questions Schema v1.0': None,
        '# This file will be populated during future ETL processing (Epic 4)': None,
        '': None,  # Empty line for readability
        'etl_questions': {
            'mind_id': mind_id,
            'schema_version': '1.0',
            'questions': [],
            '# Future structure:': [
                '# - id: "q-001"',
                '#   question: "What is the core obsession?"',
                '#   answer: "Building AGI safely..."',
                '#   source_ids: ["source-1", "source-2"]',
                '#   tags: ["core_obsessions", "agi"]',
                '#   layer_relevance: [7, 8]',
                '#   confidence: high',
                '#   evidence_weight: 10',
                '#   created_at: "2025-10-12T14:00:00Z"'
            ]
        },
        'metadata': {
            'created_at': datetime.now().isoformat() + 'Z',
            'schema_version': '1.0',
            'status': 'template',
            'notes': 'Template created during Epic 3 Story 3.1 migration. Will be populated in future ETL passes.'
        }
    }

    return template


def init_etl_questions(mind_dir: str, logger) -> bool:
    """
    Initialize ETL questions template.

    Args:
        mind_dir: Path to mind directory
        logger: MigrationLogger instance

    Returns:
        True if successful, False otherwise
    """
    mind_path = Path(mind_dir)

    if not mind_path.exists():
        logger.error(f"Mind directory not found: {mind_dir}")
        return False

    mind_id = mind_path.name
    logger.info(f"Initializing ETL questions template for: {mind_id}")

    # Output path
    output_path = mind_path / 'kb' / 'etl_questions.yaml'

    # Check if already exists (idempotency)
    if output_path.exists():
        logger.skip(f"etl_questions.yaml already exists: {output_path}")
        logger.info("To regenerate, delete file first")
        return True

    # Ensure kb/ directory exists
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Create template
    template = create_etl_template(mind_id)

    # Write template
    if write_yaml(str(output_path), template, backup=False):
        logger.success(f"Created etl_questions.yaml: {output_path}")
        logger.info("  Schema version: 1.0")
        logger.info("  Status: template (empty)")
        logger.info("  Ready for future ETL processing")
        return True
    else:
        logger.error(f"Failed to write etl_questions.yaml: {output_path}")
        return False


def main():
    """Main execution."""
    if len(sys.argv) < 2:
        print("Usage: python3 init_etl_questions.py <mind_directory>")
        print("Example: python3 init_etl_questions.py outputs/minds/sam_altman")
        sys.exit(1)

    mind_dir = sys.argv[1]
    logger = setup_logging('init_etl_questions')

    logger.section(f"Initializing ETL Questions - {Path(mind_dir).name}")

    # Initialize template
    success = init_etl_questions(mind_dir, logger)

    if not success:
        logger.error("Failed to initialize ETL questions template")
        sys.exit(1)

    sys.exit(logger.summary())


if __name__ == '__main__':
    main()
