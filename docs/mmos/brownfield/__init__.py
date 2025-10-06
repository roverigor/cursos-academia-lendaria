"""
Brownfield Incremental Assistant

Tools for updating existing minds without reprocessing the entire pipeline.
"""

from .diff_detector import DiffDetector, SourceDiff
from .plan_generator import PlanGenerator, BrownfieldPlan, PromptTask
from .workflow_executor import WorkflowExecutor, ExecutionStep
from .regression_tester import RegressionTester, RegressionTest
from .rollback_manager import RollbackManager, RollbackStep

__all__ = [
    'DiffDetector',
    'SourceDiff',
    'PlanGenerator',
    'BrownfieldPlan',
    'PromptTask',
    'WorkflowExecutor',
    'ExecutionStep',
    'RegressionTester',
    'RegressionTest',
    'RollbackManager',
    'RollbackStep',
]
