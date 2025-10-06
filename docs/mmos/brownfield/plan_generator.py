"""
PlanGenerator - Generate incremental execution plan

Maps source diffs to specific prompts that need reexecution,
resolves dependencies, and estimates time/risk.
"""

import yaml
from dataclasses import dataclass, field, asdict
from pathlib import Path
from typing import Dict, List, Optional, Any
from datetime import datetime


@dataclass
class PromptTask:
    """A single prompt execution task"""
    prompt_id: str
    phase: str
    agent: str
    target: Optional[str] = None  # specific source file if applicable
    reason: str = ''
    depends_on: List[str] = field(default_factory=list)
    parallelizable: bool = True
    estimated_duration_ms: int = 60000  # default 1min


@dataclass
class BrownfieldPlan:
    """Complete brownfield update plan"""
    mind: str
    diff_source: str
    update_scope: Dict[str, Any] = field(default_factory=dict)
    areas_affected: Dict[str, bool] = field(default_factory=dict)
    prompts_to_rerun: List[PromptTask] = field(default_factory=list)
    backup_required: bool = True
    regression_tests_required: bool = True
    pre_execution_checklist: List[str] = field(default_factory=list)


class PlanGenerator:
    """Generate incremental execution plans from diff reports"""

    # Mapping: source change type → prompts to run
    SOURCE_TO_PROMPTS = {
        'new_source': [
            ('analysis_source_reading', 180000),
            ('analysis_quote_extraction', 120000),
            ('analysis_behavioral_patterns', 90000),
            ('synthesis_kb_chunker', 90000)
        ],
        'modified_source': [
            ('analysis_source_reading', 180000),
            ('analysis_quote_extraction', 120000)
        ]
    }

    # Prompt dependencies
    DEPENDENCIES = {
        'analysis_quote_extraction': ['analysis_source_reading'],
        'analysis_behavioral_patterns': ['analysis_source_reading'],
        'analysis_timeline_mapping': ['analysis_source_reading'],
        'synthesis_kb_chunker': ['analysis_source_reading', 'analysis_quote_extraction'],
        'synthesis_template_extractor': ['analysis_quote_extraction'],
    }

    def __init__(self, prompts_db: Path):
        self.prompts_db = Path(prompts_db)
        self.prompts = self._load_prompts_yaml()

    def _load_prompts_yaml(self) -> Dict:
        """Load prompts.yaml database"""
        try:
            with open(self.prompts_db, 'r', encoding='utf-8') as f:
                return yaml.safe_load(f) or {}
        except UnicodeDecodeError:
            with open(self.prompts_db, 'r', encoding='latin-1') as f:
                return yaml.safe_load(f) or {}

    def generate(self, diff_report: Dict, mind: str, diff_source: str) -> BrownfieldPlan:
        """
        Generate execution plan from diff report

        Args:
            diff_report: Output from DiffDetector
            mind: Mind name
            diff_source: Path to diff report file

        Returns:
            BrownfieldPlan with tasks, dependencies, estimates
        """
        tasks = []

        # Process new sources
        for source_diff in diff_report.get('new_sources', []):
            tasks.extend(self._map_source_to_prompts(
                source_diff,
                change_type='new_source'
            ))

        # Process modified sources
        for source_diff in diff_report.get('modified_sources', []):
            tasks.extend(self._map_source_to_prompts(
                source_diff,
                change_type='modified_source'
            ))

        # Resolve dependencies and order tasks
        tasks = self._resolve_dependencies(tasks)

        # Determine scope and impact
        scope = self._determine_scope(diff_report, tasks)
        areas_affected = self._determine_affected_areas(tasks)

        # Generate pre-execution checklist
        checklist = self._generate_checklist(mind, scope)

        plan = BrownfieldPlan(
            mind=mind,
            diff_source=diff_source,
            update_scope=scope,
            areas_affected=areas_affected,
            prompts_to_rerun=tasks,
            backup_required=True,
            regression_tests_required=True,
            pre_execution_checklist=checklist
        )

        return plan

    def _map_source_to_prompts(self, source_diff: Dict, change_type: str) -> List[PromptTask]:
        """Map a source change to relevant prompts"""
        tasks = []
        source_path = source_diff['path']

        for prompt_id, duration_ms in self.SOURCE_TO_PROMPTS.get(change_type, []):
            # Get prompt metadata from prompts.yaml
            prompt_meta = self._get_prompt_metadata(prompt_id)

            tasks.append(PromptTask(
                prompt_id=prompt_id,
                phase=prompt_meta.get('phase', 'unknown'),
                agent=prompt_meta.get('agent', 'analyst'),
                target=source_path if 'source_reading' in prompt_id or 'quote_extraction' in prompt_id else None,
                reason=change_type,
                depends_on=self.DEPENDENCIES.get(prompt_id, []),
                parallelizable=prompt_meta.get('parallelizable', True),
                estimated_duration_ms=duration_ms
            ))

        return tasks

    def _get_prompt_metadata(self, prompt_id: str) -> Dict:
        """Get prompt metadata from prompts.yaml"""
        for phase_data in self.prompts.get('pipeline', []):
            for prompt in phase_data.get('prompts', []):
                if prompt.get('id') == prompt_id:
                    return {
                        'phase': phase_data.get('name'),
                        'agent': prompt.get('agent'),
                        'parallelizable': prompt.get('parallelizable', True)
                    }
        return {}

    def _resolve_dependencies(self, tasks: List[PromptTask]) -> List[PromptTask]:
        """
        Order tasks respecting dependencies

        Simple topological sort:
        - Tasks with no dependencies first
        - Then tasks whose dependencies are satisfied
        """
        ordered = []
        task_map = {t.prompt_id: t for t in tasks}
        completed = set()
        max_iterations = len(tasks) * 2  # Safety limit
        iterations = 0

        while len(ordered) < len(tasks) and iterations < max_iterations:
            iterations += 1
            progress_made = False

            for task in tasks:
                if task.prompt_id in completed:
                    continue

                # Check if all dependencies are satisfied
                deps_satisfied = all(dep in completed for dep in task.depends_on)

                if deps_satisfied:
                    ordered.append(task)
                    completed.add(task.prompt_id)
                    progress_made = True

            if not progress_made:
                # No progress made in this iteration - break to avoid infinite loop
                # Add remaining tasks without satisfied dependencies
                for task in tasks:
                    if task.prompt_id not in completed:
                        ordered.append(task)
                        completed.add(task.prompt_id)
                break

        return ordered

    def _determine_scope(self, diff_report: Dict, tasks: List[PromptTask]) -> Dict[str, Any]:
        """Determine update scope and impact"""
        new_count = len(diff_report.get('new_sources', []))
        modified_count = len(diff_report.get('modified_sources', []))

        # Determine scope type
        if new_count == 0 and modified_count <= 1:
            scope_type = 'incremental'
            impact = 'low'
        elif new_count <= 2 and modified_count <= 2:
            scope_type = 'incremental'
            impact = 'medium'
        else:
            scope_type = 'refactoring'
            impact = 'high'

        # Estimate time
        total_ms = sum(t.estimated_duration_ms for t in tasks)
        hours = total_ms / 1000 / 60 / 60
        if hours < 1:
            time_estimate = f"{int(total_ms / 1000 / 60)} minutes"
        else:
            time_estimate = f"{hours:.1f} hours"

        return {
            'type': scope_type,
            'impact': impact,
            'estimated_time': time_estimate,
            'new_sources_count': new_count,
            'modified_sources_count': modified_count,
            'total_prompts': len(tasks)
        }

    def _determine_affected_areas(self, tasks: List[PromptTask]) -> Dict[str, bool]:
        """Determine which areas are affected"""
        areas = {
            'sources': False,
            'artifacts': False,
            'kb': False,
            'system_prompts': False,
            'specialists': False
        }

        # Always true if we're running any tasks
        if tasks:
            areas['sources'] = True

        for task in tasks:
            if task.phase == 'analysis':
                areas['artifacts'] = True
            elif task.phase == 'synthesis':
                areas['kb'] = True
                if 'template' in task.prompt_id:
                    areas['artifacts'] = True

        return areas

    def _generate_checklist(self, mind: str, scope: Dict) -> List[str]:
        """Generate pre-execution checklist"""
        checklist = [
            f"Ensure working tree is clean: git status",
            f"Create snapshot: git add . && git commit -m 'pre-brownfield: {mind}'",
            f"Read docs/LIMITATIONS.md",
            f"Document baseline behavior (test {scope.get('total_prompts', 0)} key prompts)"
        ]

        if scope['impact'] == 'high':
            checklist.append("Review BROWNFIELD_WORKFLOW.md - this is a major update")

        return checklist

    def save_plan(self, plan: BrownfieldPlan, output_path: Path):
        """Save plan to YAML"""
        data = {
            'schema_version': '1.0',
            'plan_timestamp': datetime.now().isoformat(),
            'mind': plan.mind,
            'diff_source': plan.diff_source,
            'update_scope': plan.update_scope,
            'areas_affected': plan.areas_affected,
            'prompts_to_rerun': [
                {
                    'prompt_id': t.prompt_id,
                    'phase': t.phase,
                    'agent': t.agent,
                    'target': t.target,
                    'reason': t.reason,
                    'depends_on': t.depends_on,
                    'parallelizable': t.parallelizable,
                    'estimated_duration_ms': t.estimated_duration_ms
                }
                for t in plan.prompts_to_rerun
            ],
            'backup_required': plan.backup_required,
            'regression_tests_required': plan.regression_tests_required,
            'pre_execution_checklist': plan.pre_execution_checklist
        }

        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"[INFO] Plan saved to {output_path}")
        print(f"[INFO] Scope: {plan.update_scope['type']} ({plan.update_scope['impact']} impact)")
        print(f"[INFO] Estimated time: {plan.update_scope['estimated_time']}")
        print(f"[INFO] Prompts to rerun: {len(plan.prompts_to_rerun)}")
