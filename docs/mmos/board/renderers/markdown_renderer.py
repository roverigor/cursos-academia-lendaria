"""
Markdown Renderer - Format board data as Markdown for terminal

Renders board data as formatted Markdown for terminal display.
"""

from typing import Dict, List
from datetime import datetime
import sys
sys.path.insert(0, str(__file__).rsplit('/', 3)[0])
from board.board_engine import MindProgress, MindSummary, PhaseStats, PromptStat


class MarkdownRenderer:
    """Renders board data as formatted Markdown for terminal display"""

    def render_mind_progress(self, progress: MindProgress) -> str:
        """
        Render per-mind progress view.

        Args:
            progress: MindProgress object

        Returns:
            Formatted Markdown string
        """
        lines = []

        # Header
        lines.append(f"# 🧠 MMOS Pipeline: {progress.mind}\n")

        # Progress bar
        bar_width = 40
        filled = int(bar_width * progress.completion_pct / 100)
        bar = "━" * filled + "─" * (bar_width - filled)
        lines.append(f"## Overall Progress")
        lines.append(f"{bar} {progress.completed_prompts}/{progress.total_prompts} ({progress.completion_pct:.0f}%)\n")

        # Phases
        lines.append(f"## Phase Status\n")
        for phase_name in ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']:
            if phase_name in progress.phases:
                phase_data = progress.phases[phase_name]
                lines.extend(self._render_phase(phase_data))

        # Telemetry summary
        if progress.last_updated:
            lines.append(f"\n## Telemetry")
            lines.append(f"- Last updated: {progress.last_updated.strftime('%Y-%m-%d %H:%M:%S')}")

            # Calculate total execution time
            total_time_ms = sum(
                p.duration_ms or 0
                for phase in progress.phases.values()
                for p in phase.prompts
                if p.duration_ms
            )
            if total_time_ms > 0:
                total_time_s = total_time_ms / 1000
                lines.append(f"- Total execution time: {total_time_s:.1f}s")

                # Calculate average
                completed = progress.completed_prompts
                if completed > 0:
                    avg_ms = total_time_ms / completed
                    lines.append(f"- Avg prompt duration: {avg_ms:.0f}ms")

                # Find slowest
                slowest = None
                slowest_duration = 0
                for phase in progress.phases.values():
                    for p in phase.prompts:
                        if p.duration_ms and p.duration_ms > slowest_duration:
                            slowest = p
                            slowest_duration = p.duration_ms

                if slowest:
                    lines.append(f"- Slowest prompt: {slowest.prompt_id} ({slowest_duration}ms)")

            checkpoints_passed = sum(1 for status in progress.checkpoints.values() if status == 'approved')
            lines.append(f"- Checkpoints passed: {checkpoints_passed}/6")

        return "\n".join(lines)

    def _render_phase(self, phase: 'PhaseProgress') -> List[str]:
        """Render a single phase"""
        lines = []

        # Phase header
        icon = self._get_phase_icon(phase)
        lines.append(
            f"### {icon} PHASE {phase.order}: {phase.phase.upper()} "
            f"({phase.completed}/{phase.total} prompts)"
        )

        # Prompts (show max 10, or all if <= 10)
        prompts_to_show = phase.prompts if len(phase.prompts) <= 10 else phase.prompts[:5] + phase.prompts[-5:]

        for i, prompt in enumerate(prompts_to_show):
            # Add ellipsis if we're skipping prompts
            if i == 5 and len(phase.prompts) > 10:
                lines.append(f"├─ ... ({len(phase.prompts) - 10} more prompts)")

            icon = "✅" if prompt.status == "completed" else "⏳"
            duration = f"{prompt.duration_ms}ms" if prompt.duration_ms else "pending"

            # Format timestamp
            timestamp_str = ""
            if prompt.timestamp:
                timestamp_str = prompt.timestamp.strftime('%Y-%m-%d %H:%M')

            lines.append(
                f"├─ {icon} {prompt.prompt_id} "
                f"({prompt.agent}, {duration}"
                f"{', ' + timestamp_str if timestamp_str else ''})"
            )

        # Checkpoint
        checkpoint_icon = self._get_checkpoint_icon(phase.checkpoint_status)
        lines.append(
            f"🚦 CHECKPOINT #{phase.checkpoint_num}: "
            f"{checkpoint_icon} {phase.checkpoint_status.upper()}\n"
        )

        return lines

    def _get_phase_icon(self, phase: 'PhaseProgress') -> str:
        """Get icon for phase based on completion"""
        if phase.completed == phase.total:
            return "✅"
        elif phase.completed > 0:
            return "🟡"
        else:
            return "⏸️ "

    def _get_checkpoint_icon(self, status: str) -> str:
        """Get icon for checkpoint status"""
        if status == 'approved':
            return "✅"
        elif status == 'rejected':
            return "❌"
        else:
            return "⏸️ "

    def render_overview(self, overview: Dict[str, MindSummary]) -> str:
        """Render multi-mind overview table"""
        lines = []

        lines.append("# 🧠 MMOS Pipeline Overview\n")
        lines.append("## Minds In Progress\n")

        if not overview:
            lines.append("*No minds in progress*\n")
            return "\n".join(lines)

        # Table header
        lines.append("| Mind | Phase | Progress | Last Updated | Checkpoints | Status |")
        lines.append("|------|-------|----------|--------------|-------------|--------|")

        # Table rows
        for mind_name, summary in sorted(overview.items()):
            status_icon = "🟢" if summary.status == 'active' else "🟡"

            lines.append(
                f"| {mind_name} "
                f"| {summary.current_phase} "
                f"| {summary.progress} "
                f"| {summary.last_updated} "
                f"| {summary.checkpoints_passed} "
                f"| {status_icon} {summary.status.title()} |"
            )

        lines.append("")

        # Global statistics
        lines.append("## Global Statistics")
        lines.append(f"- Total minds: {len(overview)}")

        active = sum(1 for s in overview.values() if s.status == 'active')
        lines.append(f"- Active minds: {active}")

        return "\n".join(lines)

    def render_telemetry(self, telemetry: Dict) -> str:
        """Render telemetry dashboard"""
        lines = []

        lines.append("# 📊 MMOS Telemetry Dashboard\n")

        # Phase statistics
        phase_stats = telemetry.get('phase_stats', {})
        if phase_stats:
            lines.append("## Performance by Phase (All Minds, All Time)\n")
            lines.append("| Phase | Avg Duration | Min | Max | Executions | Success Rate |")
            lines.append("|-------|--------------|-----|-----|------------|--------------|")

            for phase_name in ['viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing']:
                if phase_name in phase_stats:
                    stats = phase_stats[phase_name]
                    lines.append(
                        f"| {phase_name.title()} "
                        f"| {stats.avg_duration_ms:.0f}ms "
                        f"| {stats.min_duration_ms}ms "
                        f"| {stats.max_duration_ms}ms "
                        f"| {stats.executions} "
                        f"| {stats.success_rate:.0f}% |"
                    )

            lines.append("")

        # Slowest prompts
        slowest = telemetry.get('slowest_prompts', [])
        if slowest:
            lines.append("## Slowest Prompts (Top 10)\n")
            for i, prompt_stat in enumerate(slowest, 1):
                lines.append(
                    f"{i}. **{prompt_stat.prompt_id}**: "
                    f"{prompt_stat.max_duration_ms}ms max "
                    f"({prompt_stat.avg_duration_ms:.0f}ms avg, "
                    f"{prompt_stat.executions} executions)"
                )

            lines.append("")

        # Success rates
        success_rates = telemetry.get('success_rates', {})
        if success_rates:
            lines.append("## Success Rates\n")
            lines.append(f"- Overall: {success_rates.get('overall', 100):.1f}%")

            by_phase = success_rates.get('by_phase', {})
            if by_phase:
                for phase, rate in sorted(by_phase.items()):
                    lines.append(f"- {phase.title()}: {rate:.1f}%")

        return "\n".join(lines)
