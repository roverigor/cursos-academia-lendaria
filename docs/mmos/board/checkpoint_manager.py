"""
Checkpoint Manager - Log and query checkpoint validations

Manages checkpoint validation logging and queries.
Thread-safe writes using file locking.
"""

import yaml
import fcntl
import os
from pathlib import Path
from datetime import datetime
from typing import Optional, List, Dict


class CheckpointManager:
    """Manages checkpoint validation logging and queries"""

    def __init__(self, history_file: str = "docs/mmos/launcher-history.yaml"):
        self.history_file = Path(history_file)

    def log_checkpoint(
        self,
        mind: str,
        checkpoint_num: int,
        phase: str,
        status: str,
        validator: str,
        notes: str = ""
    ):
        """
        Log a checkpoint validation.

        Args:
            mind: Mind name
            checkpoint_num: 1-6
            phase: Phase name
            status: 'approved' | 'rejected' | 'pending'
            validator: OS username
            notes: Optional notes from validator

        Thread-safe: Uses file locking for concurrent writes
        """
        # Ensure history file exists
        if not self.history_file.exists():
            self.history_file.parent.mkdir(parents=True, exist_ok=True)
            with open(self.history_file, 'w', encoding='utf-8') as f:
                yaml.dump({
                    'schema_version': '1.1',
                    'executions': [],
                    'checkpoints': []
                }, f, allow_unicode=True, sort_keys=False)

        # Count phase executions for this mind
        executions_reviewed = self._count_phase_executions(mind, phase)

        with open(self.history_file, 'r+', encoding='utf-8') as f:
            # Lock file for atomic write
            fcntl.flock(f.fileno(), fcntl.LOCK_EX)

            try:
                data = yaml.safe_load(f) or {}

                # Ensure schema version is updated
                if data.get('schema_version') == '1.0':
                    data['schema_version'] = '1.1'

                # Ensure checkpoints key exists
                if 'checkpoints' not in data:
                    data['checkpoints'] = []

                # Add new checkpoint
                checkpoint_record = {
                    'timestamp': datetime.now().isoformat(),
                    'mind': mind,
                    'checkpoint_num': checkpoint_num,
                    'phase': phase,
                    'status': status,
                    'validator': validator,
                    'notes': notes,
                    'executions_reviewed': executions_reviewed
                }

                data['checkpoints'].append(checkpoint_record)

                # Write back
                f.seek(0)
                yaml.dump(data, f, allow_unicode=True, sort_keys=False)
                f.truncate()

            finally:
                fcntl.flock(f.fileno(), fcntl.LOCK_UN)

    def _count_phase_executions(self, mind: str, phase: str) -> int:
        """Count number of executions for a phase"""
        if not self.history_file.exists():
            return 0

        with open(self.history_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f) or {}
            executions = data.get('executions', [])

            count = 0
            for exec in executions:
                if (exec.get('mind') == mind and
                    exec.get('phase') == phase and
                    not exec.get('dry_run', False)):
                    count += 1

            return count

    def get_checkpoint_status(self, mind: str, checkpoint_num: int) -> Optional[str]:
        """
        Get status of a specific checkpoint (approved/rejected/pending)

        Returns:
            'approved' | 'rejected' | 'pending' | None
        """
        if not self.history_file.exists():
            return 'pending'

        with open(self.history_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f) or {}
            checkpoints = data.get('checkpoints', [])

            # Find most recent status for this checkpoint
            for checkpoint in reversed(checkpoints):
                if (checkpoint.get('mind') == mind and
                    checkpoint.get('checkpoint_num') == checkpoint_num):
                    return checkpoint.get('status')

            return 'pending'

    def get_all_checkpoints(self, mind: str) -> List[Dict]:
        """Get all checkpoint validations for a mind"""
        if not self.history_file.exists():
            return []

        with open(self.history_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f) or {}
            checkpoints = data.get('checkpoints', [])
            return [c for c in checkpoints if c.get('mind') == mind]

    def get_checkpoint_details(self, mind: str, checkpoint_num: int) -> Optional[Dict]:
        """Get detailed info about a specific checkpoint"""
        checkpoints = self.get_all_checkpoints(mind)

        # Find most recent record for this checkpoint
        for checkpoint in reversed(checkpoints):
            if checkpoint.get('checkpoint_num') == checkpoint_num:
                return checkpoint

        return None
