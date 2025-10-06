"""
AIOS Launcher CLI

Command-line interface for the MMOS Launcher MVP
"""

import click
import sys
from pathlib import Path
from time import time

from .prompt_loader import PromptLoader, PromptNotFoundError
from .context_loader import ContextLoader
from .path_resolver import PathResolver
from .logger import ExecutionLogger
from .deps_checker import DependencyChecker


@click.command()
@click.option(
    '--mind',
    required=True,
    help='Mind name (e.g., steve_jobs)'
)
@click.option(
    '--phase',
    required=True,
    help='Phase name (e.g., analysis)'
)
@click.option(
    '--prompt',
    'prompt_id',
    required=True,
    help='Prompt ID (e.g., analysis_mental_models)'
)
@click.option(
    '--show-context',
    is_flag=True,
    help='Display loaded context files'
)
@click.option(
    '--show-deps',
    is_flag=True,
    help='Display dependency check results'
)
@click.option(
    '--dry-run',
    is_flag=True,
    help='Dry run (do not log execution)'
)
def main(mind: str, phase: str, prompt_id: str, show_context: bool, show_deps: bool, dry_run: bool):
    """
    AIOS Launcher - MVP for MMOS Pipeline Orchestration

    Maps prompts to agents, injects context, and logs executions.

    Example:

        aios-launcher --mind steve_jobs --phase analysis --prompt analysis_mental_models
    """
    start_time = time()

    # Initialize components
    loader = PromptLoader()
    logger = ExecutionLogger()
    deps_checker = DependencyChecker(logger)

    try:
        # Load prompt
        click.echo(f"🔍 Loading prompt: {prompt_id}")
        prompt = loader.get_prompt(prompt_id)

        # Validate phase
        if prompt['phase'] != phase:
            click.echo(
                f"⚠️  Warning: Prompt '{prompt_id}' belongs to phase '{prompt['phase']}', "
                f"not '{phase}'",
                err=True
            )

        # Initialize path resolver
        resolver = PathResolver(mind)

        # Check if mind directory exists
        mind_dir = resolver.get_mind_dir()
        if not mind_dir.exists():
            click.echo(f"❌ Error: Mind directory not found: {mind_dir}", err=True)
            click.echo(f"   Please create the directory first.", err=True)
            sys.exit(1)

        # Load context
        context_loader = ContextLoader(mind_dir)
        context = context_loader.load_all_context()

        # Check if MIND_BRIEF exists (warning if not found)
        if not context['mind_brief']:
            click.echo(f"⚠️  Warning: MIND_BRIEF.md not found in {mind_dir}", err=True)
            click.echo(f"   This file is recommended for the MMOS pipeline.", err=True)

        # Check dependencies
        deps_result = deps_checker.check_dependencies(prompt, mind, strict=False)

        # Display prompt information
        click.echo("\n" + "=" * 60)
        click.echo(f"📋 Prompt: {prompt['title']}")
        click.echo(f"🔖 ID: {prompt['id']}")
        click.echo(f"📍 Phase: {prompt['phase']}")
        click.echo(f"🤖 Agent: @{prompt['agent']}")
        click.echo(f"⚡ Parallelizable: {'Yes' if prompt.get('parallelizable') else 'No'}")
        click.echo("=" * 60)

        # Display prompt file path
        prompt_file = Path("docs/mmos") / prompt['file']
        click.echo(f"\n📄 Prompt file: {prompt_file}")

        if not prompt_file.exists():
            click.echo(f"⚠️  Warning: Prompt file not found at {prompt_file}", err=True)

        # Display output paths
        if prompt.get('outputs'):
            click.echo(f"\n📤 Expected outputs:")
            for output in prompt['outputs']:
                resolved_path = resolver.resolve(output['path'])
                click.echo(f"   • {resolved_path}")
                click.echo(f"     ({output.get('description', 'No description')})")

        # Display dependencies if requested
        if show_deps:
            click.echo(f"\n🔗 Dependencies:")
            click.echo(f"   {deps_checker.format_deps_for_display(deps_result)}")

        # Display context if requested
        if show_context:
            click.echo(f"\n📚 Context loaded:")
            context_summary = context_loader.format_context_for_display(context)
            for line in context_summary.split('\n'):
                click.echo(f"   {line}")

        # Display next steps
        click.echo(f"\n🚀 Next steps:")
        click.echo(f"   1. Open prompt file: {prompt_file}")
        click.echo(f"   2. Activate agent: @{prompt['agent']}")
        click.echo(f"   3. Copy prompt content to Claude")
        click.echo(f"   4. Review loaded context (MIND_BRIEF, PRD, sources)")
        click.echo(f"   5. Execute the prompt")

        # Log execution
        duration_ms = int((time() - start_time) * 1000)

        if not dry_run:
            # Get first output path for logging
            output_path = "N/A"
            if prompt.get('outputs'):
                output_path = resolver.resolve(prompt['outputs'][0]['path'])

            logger.log_execution(
                mind=mind,
                phase=phase,
                prompt_id=prompt_id,
                prompt_title=prompt['title'],
                agent=prompt['agent'],
                output_path=output_path,
                parallelizable=prompt.get('parallelizable', False),
                context_shown=show_context,
                dry_run=False,
                duration_ms=duration_ms
            )
            click.echo(f"\n✅ Execution logged to launcher-history.yaml")
        else:
            click.echo(f"\n🔍 Dry run - execution NOT logged")

        click.echo(f"⏱️  Duration: {duration_ms}ms\n")

    except PromptNotFoundError as e:
        click.echo(f"❌ Error: {e}", err=True)
        click.echo(f"\n💡 Available prompts for phase '{phase}':", err=True)
        try:
            prompts = loader.get_prompts_by_phase(phase)
            if prompts:
                for p in prompts:
                    click.echo(f"   • {p['id']} - {p['title']}", err=True)
            else:
                click.echo(f"   No prompts found for phase '{phase}'", err=True)
                click.echo(f"\n   Available phases:", err=True)
                for phase_name in loader.list_phases():
                    click.echo(f"   • {phase_name}", err=True)
        except Exception:
            pass
        sys.exit(1)

    except Exception as e:
        click.echo(f"❌ Unexpected error: {e}", err=True)
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
