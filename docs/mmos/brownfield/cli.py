"""
Brownfield CLI - Command-line interface for brownfield operations

Commands:
- detect: Detect source differences
- plan: Generate incremental plan
- execute: Execute brownfield workflow
- test: Run regression tests
- rollback: Rollback to backup
- status: Show current brownfield status
- complete: Mark brownfield update as complete
"""

import click
import yaml
from pathlib import Path
from datetime import datetime

from .diff_detector import DiffDetector
from .plan_generator import PlanGenerator
from .workflow_executor import WorkflowExecutor
from .regression_tester import RegressionTester
from .rollback_manager import RollbackManager


@click.group()
def brownfield():
    """Brownfield Incremental Assistant - Update existing minds without full reprocessing"""
    pass


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--output', default=None, help='Output path for diff report')
def detect(mind: str, output: str):
    """Detect source differences (AC1)"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    click.echo(f"\n=== Brownfield: Detect Changes ===")
    click.echo(f"Mind: {mind}\n")

    # Run diff detection
    detector = DiffDetector(mind_dir)
    diff_result = detector.detect()

    # Display results
    click.echo(f"New sources: {len(diff_result['new_sources'])}")
    for diff in diff_result['new_sources']:
        click.echo(f"  ✅ {diff.path} ({diff.details['source_type']}, {diff.priority} priority)")

    click.echo(f"\nModified sources: {len(diff_result['modified_sources'])}")
    for diff in diff_result['modified_sources']:
        click.echo(f"  ⚠️  {diff.path} ({diff.details['old_size']} → {diff.details['new_size']} bytes)")

    click.echo(f"\nMissing sources: {len(diff_result['missing_sources'])}")
    for diff in diff_result['missing_sources']:
        click.echo(f"  ❌ {diff.path} (not found)")

    # Save report
    if output is None:
        timestamp = datetime.now().strftime('%Y%m%d-%H%M')
        output = f'docs/mmos/logs/{timestamp}-brownfield-diff.yaml'

    output_path = Path(output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    detector.save_report(diff_result, output_path)
    click.echo(f"\n[INFO] Diff report saved to {output_path}")


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--diff-file', default=None, help='Path to diff report (auto-detect if not provided)')
@click.option('--output', default=None, help='Output path for plan')
def plan(mind: str, diff_file: str, output: str):
    """Generate incremental plan (AC2)"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    # Auto-detect latest diff file if not provided
    if diff_file is None:
        logs_dir = Path('docs/mmos/logs')
        diff_files = sorted(logs_dir.glob('*brownfield-diff.yaml'), reverse=True)
        if diff_files:
            diff_file = str(diff_files[0])
            click.echo(f"[INFO] Using latest diff: {diff_file}")
        else:
            click.echo("[ERROR] No diff file found. Run 'brownfield detect' first.")
            return

    # Load diff report
    with open(diff_file, 'r', encoding='utf-8') as f:
        diff_report = yaml.safe_load(f)

    click.echo(f"\n=== Brownfield: Generate Plan ===")
    click.echo(f"Mind: {mind}")
    click.echo(f"Diff source: {diff_file}\n")

    # Generate plan
    prompts_db = Path('docs/mmos/prompts.yaml')
    generator = PlanGenerator(prompts_db)
    brownfield_plan = generator.generate(diff_report, mind, diff_file)

    # Save plan
    if output is None:
        timestamp = datetime.now().strftime('%Y%m%d-%H%M')
        output = f'docs/mmos/logs/{timestamp}-brownfield-plan.yaml'

    output_path = Path(output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    generator.save_plan(brownfield_plan, output_path)


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--plan', required=True, help='Path to brownfield plan')
@click.option('--resume', is_flag=True, help='Resume from checkpoint')
@click.option('--dry-run', is_flag=True, help='Show commands without executing')
def execute(mind: str, plan: str, resume: bool, dry_run: bool):
    """Execute brownfield workflow (AC3)"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    plan_path = Path(plan)
    if not plan_path.exists():
        click.echo(f"[ERROR] Plan not found: {plan_path}")
        return

    click.echo(f"\n=== Brownfield: Execute Workflow ===")
    click.echo(f"Mind: {mind}")
    click.echo(f"Plan: {plan_path}")
    if dry_run:
        click.echo("[DRY-RUN MODE]")
    click.echo()

    # Execute workflow
    if resume:
        # Find latest checkpoint
        execution_logs = sorted(Path('docs/mmos/logs').glob('*brownfield-execution.yaml'), reverse=True)
        if execution_logs:
            click.echo(f"[INFO] Resuming from {execution_logs[0]}")
            executor = WorkflowExecutor.resume(execution_logs[0])
        else:
            click.echo("[ERROR] No checkpoint found to resume from")
            return
    else:
        executor = WorkflowExecutor(mind_dir, plan_path)

    try:
        execution_data = executor.execute(dry_run=dry_run)

        # Save execution log
        timestamp = datetime.now().strftime('%Y%m%d-%H%M')
        output_path = Path(f'docs/mmos/logs/{timestamp}-brownfield-execution.yaml')
        output_path.parent.mkdir(parents=True, exist_ok=True)

        executor.save_execution_log(output_path)

    except KeyboardInterrupt:
        click.echo("\n\n[INFO] Execution interrupted")
        click.echo(f"[INFO] Resume with: brownfield execute --mind {mind} --plan {plan} --resume")
    except Exception as e:
        click.echo(f"\n[ERROR] Execution failed: {e}")


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--execution', default=None, help='Execution ID (auto-detect if not provided)')
def test(mind: str, execution: str):
    """Run regression tests (AC4)"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    # Auto-detect latest execution if not provided
    if execution is None:
        logs_dir = Path('docs/mmos/logs')
        execution_logs = sorted(logs_dir.glob('*brownfield-execution.yaml'), reverse=True)
        if execution_logs:
            with open(execution_logs[0], 'r', encoding='utf-8') as f:
                log = yaml.safe_load(f)
                execution = log['execution_id']
            click.echo(f"[INFO] Using latest execution: {execution}")
        else:
            click.echo("[ERROR] No execution found. Run 'brownfield execute' first.")
            return

    click.echo(f"\n=== Brownfield: Regression Tests ===")
    click.echo(f"Mind: {mind}")
    click.echo(f"Execution: {execution}\n")

    # Run tests
    tester = RegressionTester(mind_dir, execution)
    results = tester.run_tests()

    # Save results
    timestamp = datetime.now().strftime('%Y%m%d-%H%M')
    output_path = Path(f'docs/mmos/logs/{timestamp}-regression-test.yaml')
    output_path.parent.mkdir(parents=True, exist_ok=True)

    summary = tester.save_results(results, output_path)

    # Display recommendation
    if summary['recommendation'] == 'approve':
        click.echo("\n✅ RECOMMENDATION: APPROVE")
        click.echo("All tests passed, brownfield update successful")
    elif summary['recommendation'] == 'revise':
        click.echo("\n⚠️  RECOMMENDATION: REVISE")
        click.echo("Some warnings detected, review before approval")
    else:
        click.echo("\n❌ RECOMMENDATION: ROLLBACK")
        click.echo("Critical issues detected, rollback recommended")


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--execution', required=True, help='Execution ID')
@click.option('--reason', default='', help='Reason for rollback')
@click.option('--dry-run', is_flag=True, help='Show commands without executing')
def rollback(mind: str, execution: str, reason: str, dry_run: bool):
    """Rollback to backup (AC5)"""
    # Find execution log
    logs_dir = Path('docs/mmos/logs')
    execution_log_path = None

    for log_file in logs_dir.glob('*brownfield-execution.yaml'):
        with open(log_file, 'r', encoding='utf-8') as f:
            log = yaml.safe_load(f)
            if log['execution_id'] == execution:
                execution_log_path = log_file
                break

    if not execution_log_path:
        click.echo(f"[ERROR] Execution log not found for {execution}")
        return

    click.echo(f"\n=== Brownfield: Rollback ===")
    click.echo(f"Mind: {mind}")
    click.echo(f"Execution: {execution}")
    if reason:
        click.echo(f"Reason: {reason}")
    if dry_run:
        click.echo("[DRY-RUN MODE]")
    click.echo()

    # Generate rollback plan
    manager = RollbackManager(execution_log_path)
    plan = manager.generate_rollback_plan(reason)

    click.echo(f"Rollback plan ({len(plan)} steps):")
    for i, step in enumerate(plan, 1):
        click.echo(f"  {i}. {step.action}: {step.command}")

    click.echo()

    # Execute rollback
    updated_plan = manager.execute_rollback(plan, dry_run=dry_run, confirm_each=not dry_run)

    # Save rollback log
    timestamp = datetime.now().strftime('%Y%m%d-%H%M')
    output_path = Path(f'docs/mmos/logs/{timestamp}-brownfield-rollback.yaml')
    output_path.parent.mkdir(parents=True, exist_ok=True)

    manager.save_rollback_log(reason, updated_plan, output_path)

    # Verify rollback
    if not dry_run:
        verification = manager.verify_rollback()
        click.echo(f"\n=== Rollback Verification ===")
        for area, success in verification.items():
            status = "✅" if success else "❌"
            click.echo(f"{status} {area}: {'restored' if success else 'mismatch'}")


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
def status(mind: str):
    """Show current brownfield status"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    click.echo(f"\n=== Brownfield Status: {mind} ===\n")

    # Check for latest logs
    logs_dir = Path('docs/mmos/logs')

    # Latest diff
    diff_files = sorted(logs_dir.glob('*brownfield-diff.yaml'), reverse=True)
    if diff_files:
        with open(diff_files[0], 'r', encoding='utf-8') as f:
            diff = yaml.safe_load(f)
        click.echo(f"Latest diff: {diff_files[0].name}")
        click.echo(f"  New sources: {len(diff.get('new_sources', []))}")
        click.echo(f"  Modified sources: {len(diff.get('modified_sources', []))}")

    # Latest plan
    plan_files = sorted(logs_dir.glob('*brownfield-plan.yaml'), reverse=True)
    if plan_files:
        with open(plan_files[0], 'r', encoding='utf-8') as f:
            plan = yaml.safe_load(f)
        click.echo(f"\nLatest plan: {plan_files[0].name}")
        click.echo(f"  Scope: {plan['update_scope']['type']} ({plan['update_scope']['impact']} impact)")
        click.echo(f"  Prompts: {len(plan['prompts_to_rerun'])}")

    # Latest execution
    execution_files = sorted(logs_dir.glob('*brownfield-execution.yaml'), reverse=True)
    if execution_files:
        with open(execution_files[0], 'r', encoding='utf-8') as f:
            execution = yaml.safe_load(f)
        click.echo(f"\nLatest execution: {execution_files[0].name}")
        click.echo(f"  Status: {execution['status']}")
        click.echo(f"  Completed: {len(execution['steps_completed'])} steps")
        if execution.get('steps_pending'):
            click.echo(f"  Pending: {len(execution['steps_pending'])} prompts")

    # Latest test
    test_files = sorted(logs_dir.glob('*regression-test.yaml'), reverse=True)
    if test_files:
        with open(test_files[0], 'r', encoding='utf-8') as f:
            test = yaml.safe_load(f)
        click.echo(f"\nLatest test: {test_files[0].name}")
        summary = test['summary']
        click.echo(f"  Results: {summary['passed']}/{summary['total_tests']} passed")
        click.echo(f"  Recommendation: {summary['recommendation'].upper()}")


@brownfield.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--execution', required=True, help='Execution ID')
def complete(mind: str, execution: str):
    """Mark brownfield update as complete, archive backup"""
    mind_dir = Path(f'docs/minds/{mind}')

    if not mind_dir.exists():
        click.echo(f"[ERROR] Mind not found: {mind_dir}")
        return

    # Find execution log
    logs_dir = Path('docs/mmos/logs')
    execution_log_path = None

    for log_file in logs_dir.glob('*brownfield-execution.yaml'):
        with open(log_file, 'r', encoding='utf-8') as f:
            log = yaml.safe_load(f)
            if log['execution_id'] == execution:
                execution_log_path = log_file
                break

    if not execution_log_path:
        click.echo(f"[ERROR] Execution log not found for {execution}")
        return

    with open(execution_log_path, 'r', encoding='utf-8') as f:
        log = yaml.safe_load(f)

    # Find backup
    backup_location = None
    for step in log.get('steps_completed', []):
        if step['step'] == 'backup_validated':
            backup_location = Path(step['details']['backup_location'])
            break

    click.echo(f"\n=== Brownfield: Complete ===")
    click.echo(f"Mind: {mind}")
    click.echo(f"Execution: {execution}")

    if backup_location and backup_location.exists():
        # Archive backup
        archive_dir = Path('docs/mmos/backups/archive')
        archive_dir.mkdir(parents=True, exist_ok=True)

        archive_path = archive_dir / backup_location.name

        import shutil
        shutil.move(str(backup_location), str(archive_path))

        click.echo(f"\n✅ Backup archived to {archive_path}")
    else:
        click.echo(f"\n⚠️  Backup not found, skipping archive")

    click.echo(f"✅ Brownfield update complete!")
    click.echo(f"\nLogs preserved in {logs_dir}")


if __name__ == '__main__':
    brownfield()
