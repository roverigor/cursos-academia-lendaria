"""
YAML utilities for MMOS migration scripts.
Provides safe YAML reading/writing with error handling.
"""

import yaml
from pathlib import Path
from typing import Any, Dict, Optional
import logging

logger = logging.getLogger(__name__)


def read_yaml(file_path: str) -> Optional[Dict[str, Any]]:
    """
    Safely read YAML file and return parsed content.

    Args:
        file_path: Path to YAML file

    Returns:
        Parsed YAML content as dict, or None if file doesn't exist or is invalid
    """
    path = Path(file_path)

    if not path.exists():
        logger.warning(f"YAML file not found: {file_path}")
        return None

    try:
        with open(path, 'r', encoding='utf-8') as f:
            content = yaml.safe_load(f)
            return content if content is not None else {}
    except yaml.YAMLError as e:
        logger.error(f"YAML parse error in {file_path}: {e}")
        return None
    except Exception as e:
        logger.error(f"Error reading {file_path}: {e}")
        return None


def write_yaml(file_path: str, data: Dict[str, Any], backup: bool = True) -> bool:
    """
    Safely write data to YAML file with optional backup.

    Args:
        file_path: Path to YAML file
        data: Dictionary to write as YAML
        backup: If True and file exists, create .bak backup before writing

    Returns:
        True if write succeeded, False otherwise
    """
    path = Path(file_path)

    # Create parent directories if needed
    path.parent.mkdir(parents=True, exist_ok=True)

    # Backup existing file if requested
    if backup and path.exists():
        backup_path = path.with_suffix(path.suffix + '.bak')
        try:
            path.rename(backup_path)
            logger.info(f"Created backup: {backup_path}")
        except Exception as e:
            logger.warning(f"Failed to create backup: {e}")

    # Write YAML
    try:
        with open(path, 'w', encoding='utf-8') as f:
            yaml.safe_dump(
                data,
                f,
                default_flow_style=False,
                allow_unicode=True,
                sort_keys=False,
                indent=2
            )
        logger.info(f"Wrote YAML file: {file_path}")
        return True
    except Exception as e:
        logger.error(f"Error writing {file_path}: {e}")
        return False


def merge_yaml(existing: Dict[str, Any], new: Dict[str, Any],
               preserve_manual_edits: bool = True) -> Dict[str, Any]:
    """
    Merge new data into existing YAML, optionally preserving manual edits.

    Args:
        existing: Existing YAML data
        new: New data to merge
        preserve_manual_edits: If True, preserve fields not in new data

    Returns:
        Merged dictionary
    """
    if not preserve_manual_edits:
        return new

    merged = existing.copy()

    for key, value in new.items():
        if isinstance(value, dict) and key in merged and isinstance(merged[key], dict):
            # Recursive merge for nested dicts
            merged[key] = merge_yaml(merged[key], value, preserve_manual_edits)
        else:
            merged[key] = value

    return merged


def validate_yaml_structure(data: Dict[str, Any], required_fields: list) -> tuple[bool, list]:
    """
    Validate YAML structure has required fields.

    Args:
        data: YAML data to validate
        required_fields: List of required field names (supports nested with dot notation)

    Returns:
        Tuple of (is_valid, list_of_missing_fields)
    """
    missing = []

    for field in required_fields:
        parts = field.split('.')
        current = data

        for part in parts:
            if not isinstance(current, dict) or part not in current:
                missing.append(field)
                break
            current = current[part]

    return (len(missing) == 0, missing)


def append_to_yaml_array(file_path: str, array_key: str, new_item: Any) -> bool:
    """
    Append item to array in YAML file (idempotent for logs).

    Args:
        file_path: Path to YAML file
        array_key: Key of array to append to (e.g., 'invocations')
        new_item: Item to append

    Returns:
        True if append succeeded, False otherwise
    """
    # Read existing
    existing = read_yaml(file_path)
    if existing is None:
        existing = {array_key: []}

    # Ensure array exists
    if array_key not in existing:
        existing[array_key] = []

    # Append new item
    existing[array_key].append(new_item)

    # Write back
    return write_yaml(file_path, existing, backup=False)
