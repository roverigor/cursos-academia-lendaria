"""
Logger Module

Logs prompt executions to launcher-history.yaml
"""

import yaml
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional
import os


class ExecutionLogger:
    """Logs prompt executions to launcher-history.yaml"""

    def __init__(self, history_file: str = "docs/mmos/launcher-history.yaml"):
        """
        Initialize the ExecutionLogger

        Args:
            history_file: Path to launcher-history.yaml
        """
        self.history_file = Path(history_file)
        self._ensure_history_file()

    def _ensure_history_file(self):
        """Create launcher-history.yaml if it doesn't exist"""
        if not self.history_file.exists():
            self.history_file.parent.mkdir(parents=True, exist_ok=True)
            initial_content = {
                'schema_version': '1.0',
                'executions': []
            }
            with open(self.history_file, 'w', encoding='utf-8') as f:
                yaml.dump(initial_content, f, allow_unicode=True, sort_keys=False)

    def _load_history(self) -> Dict:
        """Load current history from file"""
        with open(self.history_file, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f) or {'schema_version': '1.0', 'executions': []}

    def _save_history(self, history: Dict):
        """Save history to file"""
        with open(self.history_file, 'w', encoding='utf-8') as f:
            yaml.dump(history, f, allow_unicode=True, sort_keys=False)

    def log_execution(
        self,
        mind: str,
        phase: str,
        prompt_id: str,
        prompt_title: str,
        agent: str,
        output_path: str,
        parallelizable: bool,
        context_shown: bool = False,
        dry_run: bool = False,
        duration_ms: Optional[int] = None
    ):
        """
        Log a prompt execution

        Args:
            mind: Mind name
            phase: Phase name
            prompt_id: Prompt ID
            prompt_title: Prompt title
            agent: Agent identifier
            output_path: Suggested output path
            parallelizable: Whether prompt is parallelizable
            context_shown: Whether --show-context was used
            dry_run: Whether --dry-run was used
            duration_ms: Execution duration in milliseconds
        """
        history = self._load_history()

        execution_record = {
            'timestamp': datetime.now().isoformat(),
            'mind': mind,
            'phase': phase,
            'prompt_id': prompt_id,
            'prompt_title': prompt_title,
            'agent': agent,
            'user': os.getenv('USER', 'unknown'),
            'output_path': output_path,
            'parallelizable': parallelizable,
            'context_shown': context_shown,
            'dry_run': dry_run
        }

        if duration_ms is not None:
            execution_record['duration_ms'] = duration_ms

        history['executions'].append(execution_record)
        self._save_history(history)

    def get_recent_executions(self, limit: int = 10) -> List[Dict]:
        """
        Get recent executions

        Args:
            limit: Maximum number of executions to return

        Returns:
            List of recent execution records
        """
        history = self._load_history()
        executions = history.get('executions', [])
        return executions[-limit:]

    def get_executions_for_mind(self, mind: str) -> List[Dict]:
        """
        Get all executions for a specific mind

        Args:
            mind: Mind name

        Returns:
            List of execution records for that mind
        """
        history = self._load_history()
        executions = history.get('executions', [])
        return [e for e in executions if e.get('mind') == mind]

    def get_executions_by_phase(self, phase: str) -> List[Dict]:
        """
        Get all executions for a specific phase

        Args:
            phase: Phase name

        Returns:
            List of execution records for that phase
        """
        history = self._load_history()
        executions = history.get('executions', [])
        return [e for e in executions if e.get('phase') == phase]
