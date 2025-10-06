"""
AIOS Pipeline CLI - Auto-Execution Commands

Commands:
- execute-phase: Execute a single phase with checkpoints
- create-mind: Execute all 6 phases sequentially (full pipeline)
"""

import click
from pathlib import Path
from typing import Optional

from .phase_executor import PhaseExecutor
from .checkpoint_validator import CheckpointValidator
from .quality_checker import QualityChecker

@click.group()
def cli():
    """AIOS Pipeline - Auto-Execution Engine"""
    pass

@cli.command('execute-phase')
@click.option('--mind', required=True, help='Mind name (e.g., nassim_taleb)')
@click.option('--phase', required=True, help='Phase name (viability/research/analysis/synthesis/implementation/testing)')
@click.option('--prompts-yaml', default='docs/mmos/prompts.yaml', help='Path to prompts.yaml')
def execute_phase_cmd(mind: str, phase: str, prompts_yaml: str):
    """
    Execute a single phase for a mind

    Examples:
        aios-pipeline execute-phase --mind nassim_taleb --phase viability
        aios-pipeline execute-phase --mind jesus_cristo --phase research
    """
    click.echo(f"\n🚀 Executing {phase} phase for {mind}...\n")

    prompts_path = Path(prompts_yaml)
    if not prompts_path.exists():
        click.echo(f"❌ Error: prompts.yaml not found at {prompts_yaml}", err=True)
        return

    try:
        # 1. Execute phase
        executor = PhaseExecutor(mind, phase, prompts_path)
        phase_result = executor.execute_phase()

        click.echo(f"✅ Phase execution completed in {phase_result.total_duration_ms / 1000:.1f}s")
        click.echo(f"   Strategy: {phase_result.execution_strategy}")
        click.echo(f"   Prompts executed: {len(phase_result.prompts_executed)}")

        # 2. Quality scoring
        click.echo(f"\n📊 Running quality checks...")
        quality_scores = {}
        for execution in phase_result.prompts_executed:
            if execution.status == 'completed' and execution.output_path:
                # Run quality check
                checker = QualityChecker(expected_format='yaml')
                output_path = Path(execution.output_path)

                # For now, use simple quality check (no expected sections)
                # In production, would load expected sections from prompts.yaml
                score = checker.check_output(output_path, expected_sections=None)
                quality_scores[execution.prompt_id] = score.score

                # Update execution with quality score
                execution.quality_score = score.score
                execution.quality_metrics = {
                    'structure_valid': score.metrics.structure_valid,
                    'word_count': score.metrics.word_count,
                    'completeness_pct': score.metrics.completeness_pct
                }

        # 3. Checkpoint validation
        validator = CheckpointValidator(phase)
        decision = validator.validate_checkpoint(phase_result, quality_scores)

        # 4. Handle decision
        if decision.action == 'approve':
            click.echo(f"\n✅ {phase.title()} phase approved!\n")
        elif decision.action == 'reject':
            click.echo(f"\n❌ {phase.title()} phase rejected: {decision.rejection_reason or 'No reason provided'}\n")
        elif decision.action == 'retry':
            click.echo(f"\n♻️  Retrying {decision.retry_prompt_id}... (retry not implemented yet)\n")

    except Exception as e:
        click.echo(f"\n❌ Error executing phase: {e}\n", err=True)
        import traceback
        traceback.print_exc()

@cli.command('create-mind')
@click.option('--mind', required=True, help='Mind name (e.g., nassim_taleb)')
@click.option('--prompts-yaml', default='docs/mmos/prompts.yaml', help='Path to prompts.yaml')
@click.option('--start-from', default='viability', help='Start from phase (viability/research/analysis/synthesis/implementation/testing)')
def create_mind_cmd(mind: str, prompts_yaml: str, start_from: str):
    """
    Execute entire pipeline (all 6 phases) for a mind

    Examples:
        aios-pipeline create-mind --mind nassim_taleb
        aios-pipeline create-mind --mind jesus_cristo --start-from analysis
    """
    phases = ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']

    # Find starting phase
    if start_from not in phases:
        click.echo(f"❌ Invalid phase: {start_from}", err=True)
        return

    start_idx = phases.index(start_from)
    phases_to_run = phases[start_idx:]

    click.echo(f"\n🚀 Creating mind: {mind}")
    click.echo(f"   Phases to run: {', '.join(phases_to_run)}\n")

    for phase in phases_to_run:
        click.echo(f"\n{'='*60}")
        click.echo(f"Phase {phases.index(phase) + 1}/{len(phases)}: {phase.upper()}")
        click.echo(f"{'='*60}\n")

        # Execute phase (this will include checkpoint)
        ctx = click.Context(execute_phase_cmd)
        ctx.invoke(execute_phase_cmd, mind=mind, phase=phase, prompts_yaml=prompts_yaml)

        # Check if we should continue
        # (In production, would check checkpoint decision)

    click.echo(f"\n🎉 Mind creation complete for {mind}!\n")

if __name__ == '__main__':
    cli()
