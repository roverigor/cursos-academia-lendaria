"""
Board Engine - Core analytics and data aggregation

Central analytics engine for MMOS pipeline data.
Aggregates executions, calculates telemetry, tracks checkpoints.
"""

import yaml
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Set
from dataclasses import dataclass
from collections import defaultdict

# Import from launcher module
import sys
sys.path.insert(0, str(Path(__file__).parent.parent / "launcher"))
from prompt_loader import PromptLoader


@dataclass
class PromptExecution:
    """Single prompt execution record"""
    prompt_id: str
    prompt_title: str
    status: str  # completed | pending | failed
    agent: str
    duration_ms: Optional[int]
    timestamp: Optional[datetime]
    parallelizable: bool


@dataclass
class PhaseProgress:
    """Progress for a single phase"""
    phase: str
    order: int
    total: int
    completed: int
    prompts: List[PromptExecution]
    checkpoint_num: int
    checkpoint_status: str  # approved | pending | rejected


@dataclass
class MindProgress:
    """Complete progress for a mind"""
    mind: str
    total_prompts: int
    completed_prompts: int
    completion_pct: float
    phases: Dict[str, PhaseProgress]
    checkpoints: Dict[int, str]  # {checkpoint_num: status}
    last_updated: Optional[datetime]


@dataclass
class MindSummary:
    """Summary info for overview"""
    mind: str
    current_phase: str
    progress: str  # "12/59 (20%)"
    last_updated: str  # "5min ago"
    checkpoints_passed: str  # "1/6"
    status: str  # active | stalled


@dataclass
class PhaseStats:
    """Statistics for a phase"""
    phase: str
    avg_duration_ms: float
    min_duration_ms: int
    max_duration_ms: int
    executions: int
    success_rate: float


@dataclass
class PromptStat:
    """Statistics for a specific prompt"""
    prompt_id: str
    prompt_title: str
    avg_duration_ms: float
    max_duration_ms: int
    executions: int


class BoardEngine:
    """
    Central analytics engine for MMOS pipeline data.
    Aggregates executions, calculates telemetry, tracks checkpoints.
    """

    # Phase order mapping
    PHASES = ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']
    PHASE_TO_CHECKPOINT = {
        'viability': 1,
        'research': 2,
        'analysis': 3,
        'synthesis': 4,
        'implementation': 5,
        'testing': 6
    }

    def __init__(self, history_file: str = "docs/mmos/launcher-history.yaml"):
        self.history_file = Path(history_file)
        self._cache = None
        self._cache_mtime = None
        self.prompt_loader = PromptLoader()

    # --- Data Loading ---

    def _load_data(self) -> Dict:
        """Load and cache history file (reload if modified)"""
        if not self.history_file.exists():
            return {'schema_version': '1.0', 'executions': [], 'checkpoints': []}

        current_mtime = self.history_file.stat().st_mtime

        if self._cache is None or self._cache_mtime != current_mtime:
            with open(self.history_file, 'r', encoding='utf-8') as f:
                self._cache = yaml.safe_load(f) or {}
                self._cache_mtime = current_mtime

                # Ensure keys exist
                if 'executions' not in self._cache:
                    self._cache['executions'] = []
                if 'checkpoints' not in self._cache:
                    self._cache['checkpoints'] = []

        return self._cache

    # --- Mind-Specific Queries ---

    def get_mind_progress(self, mind: str) -> MindProgress:
        """
        Calculate progress for a specific mind.

        Returns:
            MindProgress with complete phase breakdown
        """
        # Get all prompts from prompts.yaml
        all_prompts = self.prompt_loader._load_prompts()
        total_prompts = len(all_prompts)

        # Get executions for this mind
        executions = self.get_mind_executions(mind)
        completed_prompt_ids = set(e.get('prompt_id') for e in executions if not e.get('dry_run', False))
        completed_count = len(completed_prompt_ids)

        # Calculate completion percentage
        completion_pct = (completed_count / total_prompts * 100) if total_prompts > 0 else 0

        # Build phases
        phases = {}
        for phase_name in self.PHASES:
            phases[phase_name] = self._build_phase_progress(
                phase_name,
                all_prompts,
                completed_prompt_ids,
                executions,
                mind
            )

        # Get checkpoint statuses
        checkpoints = self._get_checkpoint_statuses(mind)

        # Get last updated timestamp
        last_updated = None
        if executions:
            last_exec = max(executions, key=lambda e: e.get('timestamp', ''))
            try:
                last_updated = datetime.fromisoformat(last_exec.get('timestamp', ''))
            except:
                pass

        return MindProgress(
            mind=mind,
            total_prompts=total_prompts,
            completed_prompts=completed_count,
            completion_pct=completion_pct,
            phases=phases,
            checkpoints=checkpoints,
            last_updated=last_updated
        )

    def _build_phase_progress(
        self,
        phase_name: str,
        all_prompts: List[Dict],
        completed_ids: Set[str],
        executions: List[Dict],
        mind: str
    ) -> PhaseProgress:
        """Build progress for a single phase"""
        # Get prompts for this phase
        phase_prompts = [p for p in all_prompts if p.get('phase') == phase_name]
        total = len(phase_prompts)

        # Build prompt execution records
        prompt_execs = []
        for prompt in phase_prompts:
            prompt_id = prompt['id']

            # Find execution for this prompt
            exec_record = None
            for e in executions:
                if e.get('prompt_id') == prompt_id and not e.get('dry_run', False):
                    exec_record = e
                    break

            status = 'completed' if prompt_id in completed_ids else 'pending'

            timestamp = None
            duration_ms = None
            if exec_record:
                try:
                    timestamp = datetime.fromisoformat(exec_record.get('timestamp', ''))
                except:
                    pass
                duration_ms = exec_record.get('duration_ms')

            prompt_execs.append(PromptExecution(
                prompt_id=prompt_id,
                prompt_title=prompt.get('title', prompt_id),
                status=status,
                agent=prompt.get('agent', 'unknown'),
                duration_ms=duration_ms,
                timestamp=timestamp,
                parallelizable=prompt.get('parallelizable', False)
            ))

        completed = len([p for p in prompt_execs if p.status == 'completed'])

        # Get checkpoint status
        checkpoint_num = self.PHASE_TO_CHECKPOINT.get(phase_name, 0)
        checkpoint_status = self._get_checkpoint_status(mind, checkpoint_num)

        return PhaseProgress(
            phase=phase_name,
            order=self.PHASES.index(phase_name) + 1,
            total=total,
            completed=completed,
            prompts=prompt_execs,
            checkpoint_num=checkpoint_num,
            checkpoint_status=checkpoint_status
        )

    def get_mind_executions(self, mind: str) -> List[Dict]:
        """Get all executions for a mind, sorted by timestamp"""
        data = self._load_data()
        executions = data.get('executions', [])
        mind_execs = [e for e in executions if e.get('mind') == mind]
        return sorted(mind_execs, key=lambda e: e.get('timestamp', ''))

    def get_mind_checkpoints(self, mind: str) -> List[Dict]:
        """Get all checkpoint validations for a mind"""
        data = self._load_data()
        checkpoints = data.get('checkpoints', [])
        return [c for c in checkpoints if c.get('mind') == mind]

    def _get_checkpoint_status(self, mind: str, checkpoint_num: int) -> str:
        """Get status of specific checkpoint (approved/rejected/pending)"""
        checkpoints = self.get_mind_checkpoints(mind)

        # Find most recent status for this checkpoint
        for checkpoint in reversed(checkpoints):
            if checkpoint.get('checkpoint_num') == checkpoint_num:
                return checkpoint.get('status', 'pending')

        return 'pending'

    def _get_checkpoint_statuses(self, mind: str) -> Dict[int, str]:
        """Get all checkpoint statuses for a mind"""
        return {
            num: self._get_checkpoint_status(mind, num)
            for num in range(1, 7)
        }

    # --- Multi-Mind Queries ---

    def get_all_minds(self) -> List[str]:
        """Get list of unique minds from executions"""
        data = self._load_data()
        executions = data.get('executions', [])
        minds = set(e.get('mind') for e in executions if e.get('mind'))
        return sorted(minds)

    def get_mind_summary(self, mind: str) -> MindSummary:
        """Get summary for a single mind"""
        progress = self.get_mind_progress(mind)

        # Find current phase (first incomplete phase)
        current_phase = 'viability'
        for phase_name in self.PHASES:
            phase = progress.phases[phase_name]
            if phase.completed < phase.total:
                current_phase = phase_name
                break

        # Format progress
        progress_str = f"{progress.completed_prompts}/{progress.total_prompts} ({progress.completion_pct:.0f}%)"

        # Calculate last updated relative time
        if progress.last_updated:
            delta = datetime.now() - progress.last_updated
            if delta.total_seconds() < 60:
                last_updated = "just now"
            elif delta.total_seconds() < 3600:
                mins = int(delta.total_seconds() / 60)
                last_updated = f"{mins}min ago"
            elif delta.total_seconds() < 86400:
                hours = int(delta.total_seconds() / 3600)
                last_updated = f"{hours}h ago"
            else:
                days = int(delta.total_seconds() / 86400)
                last_updated = f"{days}d ago"
        else:
            last_updated = "never"

        # Count approved checkpoints
        approved = sum(1 for status in progress.checkpoints.values() if status == 'approved')
        checkpoints_passed = f"{approved}/6"

        # Determine status
        if progress.last_updated:
            delta = datetime.now() - progress.last_updated
            status = 'stalled' if delta.total_seconds() > 7200 else 'active'  # 2h threshold
        else:
            status = 'stalled'

        return MindSummary(
            mind=mind,
            current_phase=current_phase,
            progress=progress_str,
            last_updated=last_updated,
            checkpoints_passed=checkpoints_passed,
            status=status
        )

    def get_overview(self) -> Dict[str, MindSummary]:
        """Get summary for all minds"""
        minds = {}
        for mind in self.get_all_minds():
            minds[mind] = self.get_mind_summary(mind)
        return minds

    # --- Telemetry Queries ---

    def calculate_phase_telemetry(self) -> Dict[str, PhaseStats]:
        """Calculate statistics per phase across all minds"""
        data = self._load_data()
        executions = data.get('executions', [])

        # Group by phase
        by_phase = defaultdict(list)
        for exec in executions:
            if not exec.get('dry_run', False) and exec.get('duration_ms'):
                phase = exec.get('phase')
                by_phase[phase].append(exec.get('duration_ms'))

        # Calculate stats
        stats = {}
        for phase in self.PHASES:
            durations = by_phase.get(phase, [])
            if durations:
                stats[phase] = PhaseStats(
                    phase=phase,
                    avg_duration_ms=sum(durations) / len(durations),
                    min_duration_ms=min(durations),
                    max_duration_ms=max(durations),
                    executions=len(durations),
                    success_rate=100.0  # TODO: track failures
                )
            else:
                stats[phase] = PhaseStats(
                    phase=phase,
                    avg_duration_ms=0,
                    min_duration_ms=0,
                    max_duration_ms=0,
                    executions=0,
                    success_rate=0
                )

        return stats

    def find_slowest_prompts(self, limit: int = 10) -> List[PromptStat]:
        """Identify slowest prompts by max duration"""
        data = self._load_data()
        executions = data.get('executions', [])

        # Group by prompt
        by_prompt = defaultdict(list)
        for exec in executions:
            if not exec.get('dry_run', False) and exec.get('duration_ms'):
                prompt_id = exec.get('prompt_id')
                by_prompt[prompt_id].append(exec.get('duration_ms'))

        # Calculate stats
        prompt_stats = []
        for prompt_id, durations in by_prompt.items():
            prompt_stats.append(PromptStat(
                prompt_id=prompt_id,
                prompt_title=self._get_prompt_title(prompt_id),
                avg_duration_ms=sum(durations) / len(durations),
                max_duration_ms=max(durations),
                executions=len(durations)
            ))

        # Sort by max duration
        prompt_stats.sort(key=lambda p: p.max_duration_ms, reverse=True)
        return prompt_stats[:limit]

    def _get_prompt_title(self, prompt_id: str) -> str:
        """Get prompt title from ID"""
        try:
            prompt = self.prompt_loader.get_prompt(prompt_id)
            return prompt.get('title', prompt_id)
        except:
            return prompt_id

    def calculate_success_rates(self) -> Dict:
        """Calculate success rates per phase/prompt"""
        # TODO: Implement when we track failures
        return {
            'overall': 100.0,
            'by_phase': {phase: 100.0 for phase in self.PHASES}
        }
