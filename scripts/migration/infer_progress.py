#!/usr/bin/env python3
"""
Infer pipeline progress from existing artifacts and create pipeline_progress.yaml.
Part of Story 3.1 - Backward Compatible Additions.

Usage:
    python3 infer_progress.py <mind_directory>
    python3 infer_progress.py outputs/minds/sam_altman
"""

import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, List, Optional

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent / 'lib'))

from yaml_utils import write_yaml, read_yaml
from logger import setup_logging
from file_scanner import scan_directory, get_file_info, find_file


# Phase artifact patterns
PHASE_ARTIFACTS = {
    'viability': {
        'patterns': [
            'docs/logs/*viability*',
            'docs/logs/*icp_match*',
            'docs/PRD.md',
            'docs/README.md'
        ],
        'required': 1  # At least 1 artifact needed
    },
    'research': {
        'patterns': [
            'sources/sources_master.yaml',
            'sources/**/*.md',
            'kb/qa_dataset*.jsonl',
            'kb/qa_dataset*.md',
            'metadata/temporal_context.yaml'
        ],
        'required': 2  # At least 2 artifacts
    },
    'analysis': {
        'patterns': [
            'artifacts/quotes_database.yaml',
            'artifacts/writing_style.md',
            'artifacts/behavioral_patterns.md',
            'artifacts/values_hierarchy.yaml',
            'artifacts/beliefs_core.yaml',
            'artifacts/mental_models.md',
            'artifacts/unique_algorithm.yaml',
            'artifacts/contradictions.yaml',
            'analysis/**/*.yaml'
        ],
        'required': 3  # At least 3 Layer artifacts
    },
    'synthesis': {
        'patterns': [
            'artifacts/communication_templates.md',
            'artifacts/signature_phrases.md',
            'synthesis/**/*.md',
            'kb/chunk_*.md'
        ],
        'required': 1
    },
    'implementation': {
        'patterns': [
            'system_prompts/**/*.md',
            'system_prompts/*.md'
        ],
        'required': 1
    },
    'testing': {
        'patterns': [
            'docs/logs/*test*',
            'docs/logs/*validation*',
            'docs/logs/*personality*'
        ],
        'required': 1
    }
}


def find_artifacts_for_phase(mind_path: Path, phase: str, logger) -> List[str]:
    """Find artifacts matching phase patterns."""
    phase_config = PHASE_ARTIFACTS.get(phase, {})
    patterns = phase_config.get('patterns', [])

    artifacts = []

    for pattern in patterns:
        full_pattern = str(mind_path / pattern)

        # Use glob for pattern matching
        matches = list(mind_path.glob(pattern))

        for match in matches:
            if match.is_file():
                # Get relative path
                rel_path = str(match.relative_to(mind_path))
                if rel_path not in artifacts:
                    artifacts.append(rel_path)

    return sorted(artifacts)


def get_latest_timestamp(artifacts: List[str], mind_path: Path) -> Optional[str]:
    """Get latest modification timestamp from artifacts."""
    if not artifacts:
        return None

    latest = None

    for artifact_path in artifacts:
        full_path = mind_path / artifact_path
        if full_path.exists():
            file_info = get_file_info(str(full_path))
            modified_at = file_info.get('modified_at')

            if modified_at:
                if latest is None or modified_at > latest:
                    latest = modified_at

    if latest:
        return datetime.fromtimestamp(latest).isoformat() + 'Z'

    return None


def infer_phase_status(artifacts: List[str], required: int) -> str:
    """Infer phase status from artifacts count."""
    if len(artifacts) >= required:
        return 'completed'
    elif len(artifacts) > 0:
        return 'in_progress'
    else:
        return 'pending'


def infer_current_phase(phases: Dict[str, Any]) -> str:
    """Determine current phase from completed phases."""
    phase_order = ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']

    # Find last completed phase
    last_completed = None

    for phase in phase_order:
        if phases[phase]['status'] == 'completed':
            last_completed = phase
        elif phases[phase]['status'] in ['in_progress', 'pending']:
            # First non-completed phase is current
            return phase

    # All completed
    if last_completed == 'testing':
        return 'completed'

    # Return next phase after last completed
    if last_completed:
        idx = phase_order.index(last_completed)
        if idx + 1 < len(phase_order):
            return phase_order[idx + 1]

    return 'viability'  # Default to first phase


def infer_progress(mind_dir: str, logger) -> Optional[Dict[str, Any]]:
    """
    Infer pipeline progress from artifacts.

    Args:
        mind_dir: Path to mind directory
        logger: MigrationLogger instance

    Returns:
        Pipeline progress dictionary, or None on error
    """
    mind_path = Path(mind_dir)

    if not mind_path.exists():
        logger.error(f"Mind directory not found: {mind_dir}")
        return None

    mind_id = mind_path.name
    logger.info(f"Inferring pipeline progress for: {mind_id}")

    phases = {}

    # Analyze each phase
    for phase in ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']:
        logger.info(f"  Analyzing {phase} phase...")

        artifacts = find_artifacts_for_phase(mind_path, phase, logger)
        required = PHASE_ARTIFACTS[phase]['required']
        status = infer_phase_status(artifacts, required)
        completion_date = get_latest_timestamp(artifacts, mind_path) if status == 'completed' else None

        phases[phase] = {
            'status': status,
            'completion_date': completion_date,
            'artifacts': artifacts
        }

        logger.info(f"    Status: {status} ({len(artifacts)} artifacts found, {required} required)")

        if len(artifacts) > 0:
            logger.debug(f"    Artifacts: {', '.join(artifacts[:3])}")

    # Determine current phase
    current_phase = infer_current_phase(phases)

    # Build progress data
    progress = {
        'pipeline_progress': {
            'mind_id': mind_id,
            'current_phase': current_phase,
            'phases': phases,
            '_metadata': {
                'inferred_at': datetime.now().isoformat() + 'Z',
                'note': 'Progress inferred from existing artifacts. Manual verification recommended.'
            }
        }
    }

    return progress


def main():
    """Main execution."""
    if len(sys.argv) < 2:
        print("Usage: python3 infer_progress.py <mind_directory>")
        print("Example: python3 infer_progress.py outputs/minds/sam_altman")
        sys.exit(1)

    mind_dir = sys.argv[1]
    logger = setup_logging('infer_progress')

    logger.section(f"Inferring Pipeline Progress - {Path(mind_dir).name}")

    # Infer progress
    progress = infer_progress(mind_dir, logger)

    if not progress:
        logger.error("Failed to infer progress")
        sys.exit(1)

    # Output path
    output_path = Path(mind_dir) / 'docs' / 'pipeline_progress.yaml'

    # Ensure docs/ directory exists
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Check if already exists
    if output_path.exists():
        logger.warning(f"pipeline_progress.yaml already exists: {output_path}")
        logger.skip("Skipping - to regenerate, delete file first")
        sys.exit(0)

    # Write progress
    if write_yaml(str(output_path), progress, backup=False):
        logger.success(f"Created pipeline_progress.yaml: {output_path}")

        # Show summary
        pipeline = progress['pipeline_progress']
        logger.info(f"  Current Phase: {pipeline['current_phase']}")

        # Count completed phases
        completed = sum(1 for p in pipeline['phases'].values() if p['status'] == 'completed')
        logger.info(f"  Completed Phases: {completed}/6")

        # Show phase status
        logger.info("  Phase Status:")
        for phase, data in pipeline['phases'].items():
            status_icon = '✓' if data['status'] == 'completed' else '⊙' if data['status'] == 'in_progress' else '○'
            logger.info(f"    {status_icon} {phase}: {data['status']} ({len(data['artifacts'])} artifacts)")

    else:
        logger.error(f"Failed to write pipeline_progress.yaml: {output_path}")
        sys.exit(1)

    sys.exit(logger.summary())


if __name__ == '__main__':
    main()
