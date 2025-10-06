"""
AIOS Board CLI - Command-line interface for orchestration board

Provides commands for viewing progress, telemetry, and managing checkpoints.
"""

import click
import os
import time
from pathlib import Path
from typing import Optional

from .board_engine import BoardEngine
from .renderers.markdown_renderer import MarkdownRenderer
from .checkpoint_manager import CheckpointManager


@click.group()
def board():
    """MMOS Pipeline Orchestration Board"""
    pass


@board.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--watch', is_flag=True, help='Auto-refresh every 10s')
@click.option('--refresh-interval', default=10, type=int, help='Refresh interval in seconds')
def view(mind: str, watch: bool, refresh_interval: int):
    """View progress for a specific mind"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    if watch:
        try:
            while True:
                # Clear screen (cross-platform)
                click.clear()

                try:
                    progress = engine.get_mind_progress(mind)
                    output = renderer.render_mind_progress(progress)
                    click.echo(output)
                    click.echo(f"\n🔄 Auto-refreshing every {refresh_interval}s... (Ctrl+C to stop)")
                except Exception as e:
                    click.echo(f"❌ Error: {e}", err=True)

                time.sleep(refresh_interval)
        except KeyboardInterrupt:
            click.echo("\n\n👋 Stopped watching")
    else:
        try:
            progress = engine.get_mind_progress(mind)
            output = renderer.render_mind_progress(progress)
            click.echo(output)
        except Exception as e:
            click.echo(f"❌ Error: {e}", err=True)
            raise


@board.command()
def overview():
    """View overview of all minds"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    try:
        overview = engine.get_overview()
        output = renderer.render_overview(overview)
        click.echo(output)
    except Exception as e:
        click.echo(f"❌ Error: {e}", err=True)
        raise


@board.command()
def telemetry():
    """View telemetry dashboard"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    try:
        telemetry = {
            'phase_stats': engine.calculate_phase_telemetry(),
            'slowest_prompts': engine.find_slowest_prompts(10),
            'success_rates': engine.calculate_success_rates()
        }

        output = renderer.render_telemetry(telemetry)
        click.echo(output)
    except Exception as e:
        click.echo(f"❌ Error: {e}", err=True)
        raise


@board.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--phase', required=True, type=click.Choice([
    'viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing'
]), help='Phase name')
@click.option('--approve', 'action', flag_value='approve', help='Approve checkpoint')
@click.option('--reject', 'action', flag_value='reject', help='Reject checkpoint')
@click.option('--notes', default='', help='Validation notes')
def checkpoint(mind: str, phase: str, action: Optional[str], notes: str):
    """Log checkpoint validation"""

    if not action:
        click.echo("❌ Error: Must specify either --approve or --reject", err=True)
        return

    # Map phase to checkpoint number
    phase_to_checkpoint = {
        'viability': 1,
        'research': 2,
        'analysis': 3,
        'synthesis': 4,
        'implementation': 5,
        'testing': 6
    }

    checkpoint_num = phase_to_checkpoint.get(phase)
    if not checkpoint_num:
        click.echo(f"❌ Invalid phase: {phase}", err=True)
        return

    manager = CheckpointManager()
    status = 'approved' if action == 'approve' else 'rejected'
    validator = os.getenv('USER', 'unknown')

    try:
        manager.log_checkpoint(
            mind=mind,
            checkpoint_num=checkpoint_num,
            phase=phase,
            status=status,
            validator=validator,
            notes=notes
        )

        icon = "✅" if status == 'approved' else "❌"
        click.echo(f"\n{icon} Checkpoint #{checkpoint_num} ({phase}) {status.upper()}")
        click.echo(f"   Mind: {mind}")
        click.echo(f"   Validator: {validator}")
        if notes:
            click.echo(f"   Notes: {notes}")
        click.echo(f"\n✅ Logged to launcher-history.yaml")

    except Exception as e:
        click.echo(f"❌ Error logging checkpoint: {e}", err=True)
        raise


@board.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--output', help='Output file path (default: auto-generated)')
def export(mind: str, output: Optional[str]):
    """Export board snapshot to file"""
    from datetime import datetime

    engine = BoardEngine()
    renderer = MarkdownRenderer()

    try:
        progress = engine.get_mind_progress(mind)
        content = renderer.render_mind_progress(progress)

        if not output:
            timestamp = datetime.now().strftime("%Y%m%d-%H%M")
            output = f"docs/mmos/logs/{timestamp}-{mind}-board.md"

        output_path = Path(output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(content, encoding='utf-8')

        click.echo(f"✅ Board exported to: {output}")

    except Exception as e:
        click.echo(f"❌ Error exporting board: {e}", err=True)
        raise


if __name__ == '__main__':
    board()
