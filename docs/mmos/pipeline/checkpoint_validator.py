"""
CheckpointValidator - Human approval gates with quality highlights

Features:
- Display checkpoint criteria
- Highlight poor/acceptable quality outputs
- Prompt for approval/rejection/retry
- Retry mechanism for failed prompts
"""

from pathlib import Path
from typing import Dict, List, Optional
from dataclasses import dataclass

@dataclass
class CheckpointCriteria:
    """Criteria for a checkpoint"""
    phase: str
    criteria: List[str]

@dataclass
class CheckpointDecision:
    """Human decision at checkpoint"""
    action: str  # approve, reject, retry
    retry_prompt_id: Optional[str] = None
    rejection_reason: Optional[str] = None

class CheckpointValidator:
    """
    Validates checkpoints with human approval

    Displays:
    - Summary of outputs created
    - Quality scores (highlights poor outputs)
    - Checkpoint criteria
    - Prompt for human decision
    """

    # Checkpoint criteria by phase
    CRITERIA = {
        'viability': [
            'ICP match score ≥70%',
            'Temporal coverage ≥60%',
            'At least 3 priority sources identified',
            'Viability decision: GO/NO-GO'
        ],
        'research': [
            'All priority sources gathered',
            'Source diversity validated',
            'Research plan complete'
        ],
        'analysis': [
            'All key quotes extracted',
            'Behavioral patterns identified',
            'Timeline mapped'
        ],
        'synthesis': [
            'KB structure defined',
            'Chunking strategy validated',
            'Synthesis complete'
        ],
        'implementation': [
            'System prompts generated',
            'Specialist prompts created',
            'Quality validated'
        ],
        'testing': [
            'Conversations tested',
            'Edge cases validated'
        ]
    }

    def __init__(self, phase: str):
        self.phase = phase
        self.criteria = self.CRITERIA.get(phase, [])

    def _format_quality_badge(self, score: str) -> str:
        """Format quality score with color/emoji"""
        badges = {
            'excellent': '✅',
            'good': '✅',
            'acceptable': '⚠️ ',
            'poor': '⚠️ '
        }
        return badges.get(score, '❓')

    def _format_output_line(self, prompt_id: str, quality_score: str, output_path: str, file_size: str) -> str:
        """Format a single output line"""
        badge = self._format_quality_badge(quality_score)
        highlight = ' 👈 REVIEW' if quality_score in ['poor', 'acceptable'] else ''
        return f"{badge} {prompt_id} ({quality_score}) - {output_path} ({file_size}){highlight}"

    def display_checkpoint(self, phase_result, quality_scores: Dict[str, str]) -> None:
        """
        Display checkpoint summary

        Args:
            phase_result: PhaseResult from PhaseExecutor
            quality_scores: Dict of {prompt_id: quality_score}
        """
        print(f"\n=== CHECKPOINT: {self.phase.title()} Phase ===\n")

        # Outputs created
        print("Outputs Created:")
        for execution in phase_result.prompts_executed:
            if execution.status == 'completed':
                quality = quality_scores.get(execution.prompt_id, 'unknown')
                # Mock file size for now
                file_size = "2.5KB"
                output_line = self._format_output_line(
                    execution.prompt_id,
                    quality,
                    execution.output_path or 'unknown',
                    file_size
                )
                print(output_line)

        # Quality issues
        poor_outputs = [pid for pid, score in quality_scores.items() if score in ['poor', 'acceptable']]
        if poor_outputs:
            print(f"\n⚠️  Quality Issues Detected ({len(poor_outputs)}):")
            for prompt_id in poor_outputs:
                # Would show specific issues from QualityMetrics here
                print(f"  - {prompt_id}: Review recommended")

        # Failed prompts
        failed = [e for e in phase_result.prompts_executed if e.status == 'failed']
        if failed:
            print(f"\n❌ Failed Prompts ({len(failed)}):")
            for execution in failed:
                print(f"  - {execution.prompt_id}: {execution.error or 'Unknown error'}")

        # Checkpoint criteria
        print(f"\nCheckpoint Criteria (from AIOS_WORKFLOW.md):")
        for criterion in self.criteria:
            print(f"- {criterion}")

        # Execution stats
        duration_s = phase_result.total_duration_ms / 1000
        print(f"\nExecution Stats:")
        print(f"- Duration: {duration_s:.1f}s")
        print(f"- Strategy: {phase_result.execution_strategy}")
        if phase_result.time_saved_ms > 0:
            saved_s = phase_result.time_saved_ms / 1000
            print(f"- Time saved (parallel): {saved_s:.1f}s")

    def prompt_for_decision(self) -> CheckpointDecision:
        """
        Prompt human for checkpoint decision

        Returns:
            CheckpointDecision
        """
        print("\nAction: [approve/reject/retry <prompt_id>]")
        user_input = input("> ").strip().lower()

        if user_input == 'approve':
            return CheckpointDecision(action='approve')
        elif user_input == 'reject':
            reason = input("Rejection reason (optional): ").strip()
            return CheckpointDecision(action='reject', rejection_reason=reason or None)
        elif user_input.startswith('retry '):
            prompt_id = user_input.split(' ', 1)[1]
            return CheckpointDecision(action='retry', retry_prompt_id=prompt_id)
        else:
            print("Invalid action. Defaulting to reject.")
            return CheckpointDecision(action='reject', rejection_reason='Invalid user input')

    def validate_checkpoint(self, phase_result, quality_scores: Dict[str, str]) -> CheckpointDecision:
        """
        Full checkpoint validation flow

        Args:
            phase_result: PhaseResult from PhaseExecutor
            quality_scores: Dict of {prompt_id: quality_score}

        Returns:
            CheckpointDecision
        """
        self.display_checkpoint(phase_result, quality_scores)
        decision = self.prompt_for_decision()

        # Confirmation message
        if decision.action == 'approve':
            print(f"\n✅ {self.phase.title()} phase approved. Proceeding...\n")
        elif decision.action == 'reject':
            print(f"\n❌ {self.phase.title()} phase rejected. Execution stopped.\n")
        elif decision.action == 'retry':
            print(f"\n♻️  Re-executing {decision.retry_prompt_id}...\n")

        return decision


# CLI-friendly function
def validate_checkpoint(phase: str, phase_result, quality_scores: Dict[str, str]) -> CheckpointDecision:
    """
    Validate a checkpoint for a phase

    Args:
        phase: Phase name
        phase_result: PhaseResult from PhaseExecutor
        quality_scores: Dict of {prompt_id: quality_score}

    Returns:
        CheckpointDecision

    Example:
        >>> decision = validate_checkpoint('viability', phase_result, quality_scores)
        >>> if decision.action == 'approve':
        ...     print("Proceeding to next phase")
    """
    validator = CheckpointValidator(phase)
    return validator.validate_checkpoint(phase_result, quality_scores)
