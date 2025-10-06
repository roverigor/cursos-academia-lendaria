"""
PhaseExecutor - Core execution engine for auto-pipeline

Handles:
- Sequential execution (respects dependencies)
- Parallel execution (up to 3 concurrent when parallelizable: true)
- Integration with launcher for individual prompts
- Execution logging and metrics
"""

import asyncio
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass
import yaml

@dataclass
class PromptExecution:
    """Result of a single prompt execution"""
    prompt_id: str
    status: str  # completed, failed, skipped
    duration_ms: int
    started_at: str
    output_path: Optional[str] = None
    error: Optional[str] = None
    retry_count: int = 0
    parallel_group: Optional[str] = None
    quality_score: Optional[str] = None
    quality_metrics: Optional[Dict] = None

@dataclass
class PhaseResult:
    """Result of entire phase execution"""
    mind: str
    phase: str
    execution_id: str
    execution_strategy: str  # sequential, parallel, mixed
    prompts_executed: List[PromptExecution]
    total_duration_ms: int
    time_saved_ms: int  # parallel time savings
    checkpoint_required: bool = True

class PhaseExecutor:
    """
    Executes a phase (collection of prompts) with intelligent scheduling

    Features:
    - Topological sort for dependency resolution
    - Parallel execution (max 3 concurrent) for parallelizable prompts
    - Sequential execution for dependent prompts
    - Integration with launcher for prompt execution
    """

    def __init__(self, mind: str, phase: str, prompts_yaml_path: Path):
        self.mind = mind
        self.phase = phase
        self.prompts_yaml_path = prompts_yaml_path
        self.prompts = self._load_prompts()
        self.max_parallel = 3  # Configurable via config.yaml later

    def _load_prompts(self) -> List[Dict]:
        """Load prompts for this phase from prompts.yaml"""
        with open(self.prompts_yaml_path, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)

        # Find phase in pipeline
        for phase_config in data.get('pipeline', []):
            if phase_config['name'] == self.phase:
                return phase_config.get('prompts', [])

        raise ValueError(f"Phase '{self.phase}' not found in prompts.yaml")

    def _resolve_execution_order(self) -> List[List[Dict]]:
        """
        Resolve execution order using topological sort + parallelization

        Returns:
            List of batches, where each batch can be executed in parallel

        Example:
            [
                [prompt1],  # Order 1, no parallel
                [prompt2, prompt3, prompt4],  # Order 2, parallelizable
                [prompt5]  # Order 3, depends on prompt2
            ]
        """
        # Group prompts by order
        order_groups: Dict[int, List[Dict]] = {}
        for prompt in self.prompts:
            order = prompt.get('order', 1)
            if order not in order_groups:
                order_groups[order] = []
            order_groups[order].append(prompt)

        # Build batches respecting order and parallelizability
        batches = []
        for order in sorted(order_groups.keys()):
            prompts_in_order = order_groups[order]

            # Separate parallelizable from sequential
            parallelizable = [p for p in prompts_in_order if p.get('parallelizable', False)]
            sequential = [p for p in prompts_in_order if not p.get('parallelizable', False)]

            # Add sequential prompts as individual batches
            for prompt in sequential:
                batches.append([prompt])

            # Group parallelizable prompts (max 3 per batch)
            if parallelizable:
                for i in range(0, len(parallelizable), self.max_parallel):
                    batch = parallelizable[i:i + self.max_parallel]
                    batches.append(batch)

        return batches

    async def _execute_prompt_async(self, prompt: Dict, parallel_group: Optional[str] = None) -> PromptExecution:
        """
        Execute a single prompt asynchronously

        This will call the launcher CLI as a subprocess
        """
        prompt_id = prompt['id']
        started_at = datetime.now().isoformat()
        start_time = time.time()

        try:
            # Build launcher command
            # TODO: Replace with actual launcher integration
            # For now, simulate execution
            await asyncio.sleep(0.5)  # Simulate API call

            # Mock execution result
            duration_ms = int((time.time() - start_time) * 1000)
            output_path = f"docs/minds/{self.mind}/artifacts/{prompt_id}.yaml"

            return PromptExecution(
                prompt_id=prompt_id,
                status='completed',
                duration_ms=duration_ms,
                started_at=started_at,
                output_path=output_path,
                parallel_group=parallel_group
            )

        except Exception as e:
            duration_ms = int((time.time() - start_time) * 1000)
            return PromptExecution(
                prompt_id=prompt_id,
                status='failed',
                duration_ms=duration_ms,
                started_at=started_at,
                error=str(e)
            )

    async def _execute_batch_parallel(self, batch: List[Dict], batch_idx: int) -> List[PromptExecution]:
        """Execute a batch of prompts in parallel"""
        parallel_group = f"batch_{batch_idx}" if len(batch) > 1 else None

        # Create async tasks for all prompts in batch
        tasks = [
            self._execute_prompt_async(prompt, parallel_group)
            for prompt in batch
        ]

        # Execute all tasks concurrently
        results = await asyncio.gather(*tasks)

        return results

    async def execute_phase_async(self) -> PhaseResult:
        """
        Execute entire phase asynchronously

        Returns PhaseResult with all execution details
        """
        execution_id = f"exec_{self.mind}_{self.phase}_{datetime.now().strftime('%Y%m%d_%H%M')}"
        phase_start = time.time()

        batches = self._resolve_execution_order()
        all_executions: List[PromptExecution] = []

        # Execute batches sequentially (but prompts within batch are parallel)
        for batch_idx, batch in enumerate(batches):
            batch_results = await self._execute_batch_parallel(batch, batch_idx)
            all_executions.extend(batch_results)

        phase_duration_ms = int((time.time() - phase_start) * 1000)

        # Calculate time savings (parallel vs sequential)
        total_prompt_time = sum(e.duration_ms for e in all_executions)
        time_saved_ms = total_prompt_time - phase_duration_ms

        # Determine execution strategy
        has_parallel = any(e.parallel_group for e in all_executions)
        execution_strategy = 'parallel' if has_parallel else 'sequential'

        return PhaseResult(
            mind=self.mind,
            phase=self.phase,
            execution_id=execution_id,
            execution_strategy=execution_strategy,
            prompts_executed=all_executions,
            total_duration_ms=phase_duration_ms,
            time_saved_ms=time_saved_ms
        )

    def execute_phase(self) -> PhaseResult:
        """
        Synchronous wrapper for execute_phase_async

        This is the main public interface
        """
        return asyncio.run(self.execute_phase_async())


# CLI-friendly function
def execute_phase(mind: str, phase: str, prompts_yaml_path: Path) -> PhaseResult:
    """
    Execute a phase for a mind

    Args:
        mind: Mind name (e.g., 'nassim_taleb')
        phase: Phase name (e.g., 'viability', 'research')
        prompts_yaml_path: Path to prompts.yaml

    Returns:
        PhaseResult with execution details

    Example:
        >>> result = execute_phase('nassim_taleb', 'viability', Path('prompts.yaml'))
        >>> print(f"Executed {len(result.prompts_executed)} prompts in {result.total_duration_ms}ms")
    """
    executor = PhaseExecutor(mind, phase, prompts_yaml_path)
    return executor.execute_phase()
