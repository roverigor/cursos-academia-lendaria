"""
WorkflowExecutor - Execute brownfield workflow with tracking

Executes BROWNFIELD_WORKFLOW.md steps:
1. Validate prerequisites (backup, docs read)
2. Execute prompts via launcher
3. Track progress with checkpoints
4. Support resume if interrupted
"""

import subprocess
import yaml
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Dict, List, Optional, Any
from datetime import datetime


@dataclass
class ExecutionStep:
    """A single execution step"""
    step: str
    timestamp: str
    details: Optional[Dict] = None
    status: str = 'completed'  # 'completed' | 'failed' | 'skipped'


class WorkflowExecutor:
    """Execute brownfield workflow with tracking"""

    def __init__(self, mind_dir: Path, plan_file: Path):
        self.mind_dir = Path(mind_dir)
        self.plan_file = Path(plan_file)
        self.plan = self._load_plan()
        self.execution_id = self._generate_execution_id()
        self.execution_log: List[ExecutionStep] = []
        self.launcher_history_file = Path('docs/mmos/launcher-history.yaml')

    def _load_plan(self) -> Dict:
        """Load brownfield plan"""
        with open(self.plan_file, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def _generate_execution_id(self) -> str:
        """Generate unique execution ID"""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M')
        return f"brownfield_{self.plan['mind']}_{timestamp}"

    def execute(self, dry_run: bool = False) -> Dict:
        """
        Execute brownfield workflow

        Args:
            dry_run: If True, only show what would be executed

        Returns:
            Execution log data
        """
        print(f"\n=== Brownfield Execution: {self.execution_id} ===\n")

        # Step 1: Validate prerequisites
        print("[1/3] Validating prerequisites...")
        if not self._validate_prerequisites(dry_run):
            raise RuntimeError("Prerequisites validation failed")

        # Step 2: Execute prompt tasks
        print(f"\n[2/3] Executing {len(self.plan['prompts_to_rerun'])} prompts...")
        for i, task in enumerate(self.plan['prompts_to_rerun'], 1):
            print(f"\n  Task {i}/{len(self.plan['prompts_to_rerun'])}: {task['prompt_id']}")
            self._execute_prompt_task(task, dry_run)
            self._checkpoint()

        # Step 3: Complete
        print("\n[3/3] Execution complete!")

        return self._get_execution_data()

    def _validate_prerequisites(self, dry_run: bool) -> bool:
        """Validate prerequisites before execution"""
        valid = True

        # Check if backup exists (if required)
        if self.plan.get('backup_required', True):
            backup_pattern = f"BACKUP_{self.plan['mind']}_*"
            parent_dir = self.mind_dir.parent
            backups = list(parent_dir.glob(backup_pattern))

            if not backups:
                print(f"[ERROR] No backup found matching {backup_pattern}")
                print(f"[ERROR] Create backup first: cp -r {self.mind_dir} {parent_dir}/BACKUP_{self.plan['mind']}_$(date +%Y%m%d)")
                valid = False
            else:
                latest_backup = max(backups, key=lambda p: p.stat().st_mtime)
                print(f"[OK] Backup found: {latest_backup}")
                self.execution_log.append(ExecutionStep(
                    step='backup_validated',
                    timestamp=datetime.now().isoformat(),
                    details={'backup_location': str(latest_backup)}
                ))

        # Check if LIMITATIONS.md exists (for review)
        limitations_file = self.mind_dir / "docs" / "LIMITATIONS.md"
        if limitations_file.exists():
            print(f"[OK] LIMITATIONS.md found (review recommended)")
        else:
            print(f"[WARN] LIMITATIONS.md not found")

        return valid

    def _execute_prompt_task(self, task: Dict, dry_run: bool = False):
        """
        Execute a single prompt task using launcher

        Args:
            task: PromptTask dict
            dry_run: If True, only show command, don't execute
        """
        cmd = [
            'python3', '-m', 'docs.mmos.launcher.cli',
            '--mind', self.plan['mind'],
            '--phase', task['phase'],
            '--prompt', task['prompt_id']
        ]

        if task.get('target'):
            cmd.extend(['--target', task['target']])

        print(f"    Command: {' '.join(cmd)}")

        if dry_run:
            print("    [DRY-RUN] Skipping execution")
            status = 'skipped'
        else:
            try:
                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    check=True
                )
                print(f"    [OK] Completed in ~{task.get('estimated_duration_ms', 60000) // 1000}s")
                status = 'completed'
            except subprocess.CalledProcessError as e:
                print(f"    [ERROR] Failed: {e}")
                status = 'failed'

        # Log step
        self.execution_log.append(ExecutionStep(
            step='prompt_executed',
            timestamp=datetime.now().isoformat(),
            details={
                'prompt_id': task['prompt_id'],
                'phase': task['phase'],
                'agent': task['agent'],
                'target': task.get('target'),
                'launcher_log_ref': self._get_last_launcher_entry()
            },
            status=status
        ))

    def _checkpoint(self):
        """Save current execution state (for resume capability)"""
        checkpoint_file = Path('docs/mmos/logs') / f"{self.execution_id}-checkpoint.yaml"
        checkpoint_file.parent.mkdir(parents=True, exist_ok=True)

        data = self._get_execution_data()
        with open(checkpoint_file, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

    def _get_last_launcher_entry(self) -> str:
        """Get reference to last launcher history entry"""
        if not self.launcher_history_file.exists():
            return None

        try:
            with open(self.launcher_history_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()
                return f"launcher-history.yaml:line_{len(lines)}"
        except:
            return None

    def _get_execution_data(self) -> Dict:
        """Get execution log data"""
        completed_prompts = [
            s.details['prompt_id']
            for s in self.execution_log
            if s.step == 'prompt_executed' and s.status == 'completed'
        ]

        pending_prompts = [
            task['prompt_id']
            for task in self.plan['prompts_to_rerun']
            if task['prompt_id'] not in completed_prompts
        ]

        return {
            'schema_version': '1.0',
            'execution_id': self.execution_id,
            'mind': self.plan['mind'],
            'plan_file': str(self.plan_file),
            'status': 'completed' if not pending_prompts else 'in_progress',
            'steps_completed': [
                {
                    'step': s.step,
                    'timestamp': s.timestamp,
                    'details': s.details,
                    'status': s.status
                }
                for s in self.execution_log
            ],
            'steps_pending': pending_prompts,
            'can_resume': len(pending_prompts) > 0,
            'last_checkpoint': self.execution_log[-1].timestamp if self.execution_log else None
        }

    def save_execution_log(self, output_path: Path):
        """Save execution log to file"""
        data = self._get_execution_data()

        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"\n[INFO] Execution log saved to {output_path}")

    @classmethod
    def resume(cls, execution_log_path: Path):
        """
        Resume from interrupted execution

        Args:
            execution_log_path: Path to previous execution log

        Returns:
            New WorkflowExecutor instance ready to continue
        """
        with open(execution_log_path, 'r', encoding='utf-8') as f:
            prev_log = yaml.safe_load(f)

        executor = cls(
            mind_dir=Path(f"minds/{prev_log['mind']}"),
            plan_file=Path(prev_log['plan_file'])
        )

        # Restore execution log
        executor.execution_id = prev_log['execution_id']
        executor.execution_log = [
            ExecutionStep(**step) for step in prev_log['steps_completed']
        ]

        print(f"\n[INFO] Resuming execution: {executor.execution_id}")
        print(f"[INFO] Completed: {len(prev_log['steps_completed'])} steps")
        print(f"[INFO] Pending: {len(prev_log['steps_pending'])} prompts\n")

        return executor
