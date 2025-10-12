"""
Schema validation utilities for MMOS migration scripts.
Validates YAML files against expected schemas.
"""

import re
from datetime import datetime
from typing import List, Dict, Any, Tuple


class ValidationError:
    """Represents a validation error."""

    def __init__(self, field: str, message: str, severity: str = 'error'):
        self.field = field
        self.message = message
        self.severity = severity  # 'error' or 'warning'

    def __str__(self):
        return f"[{self.severity.upper()}] {self.field}: {self.message}"


class MetadataValidator:
    """Validates metadata.yaml schema."""

    REQUIRED_FIELDS = ['id', 'display_name', 'status', 'version']
    VALID_STATUSES = ['draft', 'mapping', 'analysis', 'synthesis', 'completed', 'archived']
    VALID_ICP_MATCHES = ['high', 'medium', 'low']

    @staticmethod
    def validate(data: Dict[str, Any]) -> List[ValidationError]:
        """Validate metadata.yaml structure."""
        errors = []

        # Check if 'mind' root key exists
        if 'mind' not in data:
            errors.append(ValidationError('root', "Missing 'mind' root key"))
            return errors

        mind = data['mind']

        # Required fields
        for field in MetadataValidator.REQUIRED_FIELDS:
            if field not in mind:
                errors.append(ValidationError(field, f"Required field missing"))

        # ID validation (snake_case)
        if 'id' in mind:
            if not re.match(r'^[a-z0-9_]+$', mind['id']):
                errors.append(ValidationError('id', "Must be snake_case (lowercase, numbers, underscores only)"))

        # Status validation
        if 'status' in mind and mind['status'] not in MetadataValidator.VALID_STATUSES:
            errors.append(ValidationError('status', f"Invalid status. Must be one of: {', '.join(MetadataValidator.VALID_STATUSES)}"))

        # Version validation (semver)
        if 'version' in mind:
            if not re.match(r'^v\d+\.\d+\.\d+$', mind['version']):
                errors.append(ValidationError('version', "Must follow semver format: v1.0.0"))

        # Apex score validation
        if 'apex_score' in mind:
            try:
                score = float(mind['apex_score'])
                if score < 0 or score > 10:
                    errors.append(ValidationError('apex_score', "Must be between 0 and 10"))
            except (ValueError, TypeError):
                errors.append(ValidationError('apex_score', "Must be a number"))

        # ICP match validation
        if 'icp_match' in mind:
            if mind['icp_match'] not in MetadataValidator.VALID_ICP_MATCHES:
                errors.append(ValidationError('icp_match', f"Must be one of: {', '.join(MetadataValidator.VALID_ICP_MATCHES)}"))

        # Timestamp validation
        for ts_field in ['created_at', 'updated_at']:
            if ts_field in mind:
                if not MetadataValidator._validate_iso8601(mind[ts_field]):
                    errors.append(ValidationError(ts_field, "Must be valid ISO8601 timestamp"))

        return errors

    @staticmethod
    def _validate_iso8601(timestamp: str) -> bool:
        """Validate ISO8601 timestamp format."""
        try:
            datetime.fromisoformat(timestamp.replace('Z', '+00:00'))
            return True
        except (ValueError, AttributeError):
            return False


class SourcesValidator:
    """Validates sources_master.yaml schema."""

    REQUIRED_FIELDS = ['id', 'mind_id', 'type', 'title']
    VALID_TYPES = ['interview', 'book', 'article', 'podcast', 'video', 'testimony', 'blog', 'whitepaper']
    VALID_STATUSES = ['pending', 'processing', 'processed', 'archived']
    VALID_PRIORITIES = ['critical', 'high', 'medium', 'low']
    VALID_CONFIDENCES = ['high', 'medium', 'low']

    @staticmethod
    def validate(data: Dict[str, Any]) -> List[ValidationError]:
        """Validate sources_master.yaml structure."""
        errors = []

        if 'sources' not in data:
            errors.append(ValidationError('root', "Missing 'sources' root key"))
            return errors

        if not isinstance(data['sources'], list):
            errors.append(ValidationError('sources', "Must be an array"))
            return errors

        for idx, source in enumerate(data['sources']):
            source_id = source.get('id', f"source_{idx}")

            # Required fields
            for field in SourcesValidator.REQUIRED_FIELDS:
                if field not in source:
                    errors.append(ValidationError(f"{source_id}.{field}", "Required field missing"))

            # Type validation
            if 'type' in source and source['type'] not in SourcesValidator.VALID_TYPES:
                errors.append(ValidationError(f"{source_id}.type", f"Invalid type. Must be one of: {', '.join(SourcesValidator.VALID_TYPES)}"))

            # Status validation
            if 'status' in source and source['status'] not in SourcesValidator.VALID_STATUSES:
                errors.append(ValidationError(f"{source_id}.status", f"Invalid status"))

            # Priority validation
            if 'priority' in source and source['priority'] not in SourcesValidator.VALID_PRIORITIES:
                errors.append(ValidationError(f"{source_id}.priority", f"Invalid priority"))

            # Confidence validation
            if 'confidence' in source and source['confidence'] not in SourcesValidator.VALID_CONFIDENCES:
                errors.append(ValidationError(f"{source_id}.confidence", f"Invalid confidence"))

            # Layer relevance validation
            if 'layer_relevance' in source:
                if not isinstance(source['layer_relevance'], list):
                    errors.append(ValidationError(f"{source_id}.layer_relevance", "Must be an array"))
                else:
                    for layer in source['layer_relevance']:
                        if not isinstance(layer, int) or layer < 1 or layer > 8:
                            errors.append(ValidationError(f"{source_id}.layer_relevance", "Layers must be integers 1-8"))
                            break

        return errors


class PipelineProgressValidator:
    """Validates pipeline_progress.yaml schema."""

    REQUIRED_FIELDS = ['mind_id', 'current_phase']
    VALID_PHASES = ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']
    VALID_STATUSES = ['pending', 'in_progress', 'completed', 'blocked']

    @staticmethod
    def validate(data: Dict[str, Any]) -> List[ValidationError]:
        """Validate pipeline_progress.yaml structure."""
        errors = []

        if 'pipeline_progress' not in data:
            errors.append(ValidationError('root', "Missing 'pipeline_progress' root key"))
            return errors

        progress = data['pipeline_progress']

        # Required fields
        for field in PipelineProgressValidator.REQUIRED_FIELDS:
            if field not in progress:
                errors.append(ValidationError(field, "Required field missing"))

        # Current phase validation
        if 'current_phase' in progress and progress['current_phase'] not in PipelineProgressValidator.VALID_PHASES + ['pending']:
            errors.append(ValidationError('current_phase', f"Invalid phase"))

        # Phases validation
        if 'phases' in progress:
            if not isinstance(progress['phases'], dict):
                errors.append(ValidationError('phases', "Must be a dictionary"))
            else:
                for phase_name, phase_data in progress['phases'].items():
                    if phase_name not in PipelineProgressValidator.VALID_PHASES:
                        errors.append(ValidationError(f"phases.{phase_name}", f"Invalid phase name"))

                    if 'status' in phase_data and phase_data['status'] not in PipelineProgressValidator.VALID_STATUSES:
                        errors.append(ValidationError(f"phases.{phase_name}.status", f"Invalid status"))

                    if 'artifacts' in phase_data and not isinstance(phase_data['artifacts'], list):
                        errors.append(ValidationError(f"phases.{phase_name}.artifacts", "Must be an array"))

        return errors


def validate_file(file_path: str, validator_class) -> Tuple[bool, List[ValidationError]]:
    """
    Validate a YAML file using specified validator.

    Args:
        file_path: Path to YAML file
        validator_class: Validator class to use (MetadataValidator, SourcesValidator, etc.)

    Returns:
        Tuple of (is_valid, list_of_errors)
    """
    from .yaml_utils import read_yaml

    data = read_yaml(file_path)
    if data is None:
        return (False, [ValidationError('file', f"Could not read file: {file_path}")])

    errors = validator_class.validate(data)
    return (len(errors) == 0, errors)
