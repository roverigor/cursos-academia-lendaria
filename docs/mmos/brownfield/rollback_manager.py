"""
RollbackManager - Rollback guidance and execution

Provides step-by-step rollback instructions and optionally executes rollback
to restore mind to pre-brownfield state.
"""

import subprocess
import yaml
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Dict, List, Optional
from datetime import datetime


@dataclass
class RollbackStep:
    """A single rollback step"""
    action: str
    command: str
    status: str = 'pending'  # 'pending' | 'completed' | 'failed'


class RollbackManager:
    """Manage rollback of brownfield updates"""

    def __init__(self, execution_log_path: Path):
        self.execution_log_path = Path(execution_log_path)
        self.execution_log = self._load_execution_log()
        self.backup_location = self._extract_backup_location()
        self.mind_dir = Path(f"docs/minds/{self.execution_log['mind']}")

    def _load_execution_log(self) -> Dict:
        """Load execution log"""
        with open(self.execution_log_path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def _extract_backup_location(self) -> Optional[Path]:
        """Extract backup location from execution log"""
        for step in self.execution_log.get('steps_completed', []):
            if step['step'] == 'backup_validated':
                return Path(step['details']['backup_location'])
        return None

    def generate_rollback_plan(self, reason: str = '') -> List[RollbackStep]:
        """
        Generate rollback steps based on execution log

        Args:
            reason: Reason for rollback

        Returns:
            List of RollbackStep
        """
        if not self.backup_location:
            raise RuntimeError("No backup location found in execution log")

        if not self.backup_location.exists():
            raise RuntimeError(f"Backup not found at {self.backup_location}")

        steps = []

        # Determine what was modified (from execution log)
        modified_areas = self._get_modified_areas()

        # Generate restore commands
        if modified_areas.get('sources'):
            steps.append(RollbackStep(
                action='restore_sources',
                command=f'cp -r {self.backup_location}/sources {self.mind_dir}/',
                status='pending'
            ))

        if modified_areas.get('artifacts'):
            steps.append(RollbackStep(
                action='restore_artifacts',
                command=f'cp -r {self.backup_location}/artifacts {self.mind_dir}/',
                status='pending'
            ))

        if modified_areas.get('kb'):
            steps.append(RollbackStep(
                action='restore_kb',
                command=f'cp -r {self.backup_location}/kb {self.mind_dir}/',
                status='pending'
            ))

        if modified_areas.get('system_prompts'):
            steps.append(RollbackStep(
                action='restore_system_prompts',
                command=f'cp -r {self.backup_location}/system_prompts {self.mind_dir}/',
                status='pending'
            ))

        # Add cleanup step (optional - remove failed brownfield artifacts)
        steps.append(RollbackStep(
            action='cleanup_temp_files',
            command=f'find {self.mind_dir} -name "*brownfield*" -type f',
            status='pending'
        ))

        return steps

    def _get_modified_areas(self) -> Dict[str, bool]:
        """Determine which areas were modified based on execution log"""
        areas = {
            'sources': True,  # Always assume sources might be modified
            'artifacts': False,
            'kb': False,
            'system_prompts': False
        }

        # Analyze executed prompts
        for step in self.execution_log.get('steps_completed', []):
            if step['step'] == 'prompt_executed':
                phase = step['details'].get('phase', '')
                if phase == 'analysis':
                    areas['artifacts'] = True
                elif phase == 'synthesis':
                    areas['kb'] = True
                elif phase == 'implementation':
                    areas['system_prompts'] = True

        return areas

    def execute_rollback(self, plan: List[RollbackStep], dry_run: bool = False,
                        confirm_each: bool = True) -> List[RollbackStep]:
        """
        Execute rollback plan

        Args:
            plan: List of RollbackStep
            dry_run: If True, only show commands, don't execute
            confirm_each: If True, ask for confirmation before each step

        Returns:
            Updated plan with execution status
        """
        print(f"\n=== Rollback Execution ===")
        print(f"Backup source: {self.backup_location}")
        print(f"Target: {self.mind_dir}")
        print(f"Steps: {len(plan)}\n")

        for i, step in enumerate(plan, 1):
            print(f"[{i}/{len(plan)}] {step.action}")
            print(f"  Command: {step.command}")

            if dry_run:
                print("  [DRY-RUN] Skipping execution\n")
                step.status = 'skipped'
                continue

            if confirm_each:
                response = input("  Execute? (y/n): ").lower()
                if response != 'y':
                    print("  [SKIPPED]\n")
                    step.status = 'skipped'
                    continue

            try:
                # Parse and execute command
                parts = step.command.split()
                subprocess.run(parts, check=True, capture_output=True, text=True)
                print("  [OK] Completed\n")
                step.status = 'completed'
            except subprocess.CalledProcessError as e:
                print(f"  [ERROR] Failed: {e}\n")
                step.status = 'failed'

        return plan

    def save_rollback_log(self, reason: str, plan: List[RollbackStep], output_path: Path):
        """Save rollback log to file"""
        # Preserve brownfield logs for post-mortem
        preserved_logs = []
        logs_dir = Path('docs/mmos/logs')
        if logs_dir.exists():
            execution_id = self.execution_log['execution_id']
            for log_file in logs_dir.glob(f"*{execution_id.split('_')[-2]}*.yaml"):
                preserved_logs.append(str(log_file))
            for log_file in logs_dir.glob(f"*brownfield*.yaml"):
                if log_file.name not in [p.split('/')[-1] for p in preserved_logs]:
                    preserved_logs.append(str(log_file))

        rollback_successful = all(step.status == 'completed' for step in plan)

        data = {
            'schema_version': '1.0',
            'rollback_timestamp': datetime.now().isoformat(),
            'mind': self.execution_log['mind'],
            'execution_id': self.execution_log['execution_id'],
            'reason': reason,
            'backup_source': str(self.backup_location),
            'rollback_steps': [
                {
                    'action': step.action,
                    'command': step.command,
                    'status': step.status
                }
                for step in plan
            ],
            'rollback_successful': rollback_successful,
            'preserved_logs': preserved_logs,
            'next_steps': self._generate_next_steps(reason)
        }

        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"\n[INFO] Rollback log saved to {output_path}")
        print(f"[INFO] Rollback successful: {rollback_successful}")

        if rollback_successful:
            print("\n[INFO] Mind restored to pre-brownfield state")
            print(f"[INFO] Preserved logs: {len(preserved_logs)} files")
        else:
            print("\n[WARN] Rollback incomplete, manual intervention may be required")

    def _generate_next_steps(self, reason: str) -> List[str]:
        """Generate recommended next steps after rollback"""
        steps = [
            "Review regression test failures",
            "Analyze why brownfield update caused issues",
            "Consider alternative approach (e.g., smaller incremental changes)",
            "Update BROWNFIELD_WORKFLOW.md if needed"
        ]

        if 'critical_regression' in reason.lower():
            steps.insert(0, "Investigate root cause of regression")

        return steps

    def verify_rollback(self) -> Dict[str, bool]:
        """
        Verify rollback was successful

        Returns:
            Dict with verification results for each area
        """
        verification = {}

        # Check if backup and current state match
        if self.backup_location:
            for area in ['sources', 'artifacts', 'kb', 'system_prompts']:
                backup_path = self.backup_location / area
                current_path = self.mind_dir / area

                if backup_path.exists() and current_path.exists():
                    # Simple verification: compare file counts
                    backup_count = len(list(backup_path.rglob('*')))
                    current_count = len(list(current_path.rglob('*')))
                    verification[area] = (backup_count == current_count)
                elif not backup_path.exists() and not current_path.exists():
                    verification[area] = True
                else:
                    verification[area] = False

        return verification
