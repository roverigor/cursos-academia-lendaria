#!/usr/bin/env python3
"""
State Manager for CreatorOS Error Recovery & Resume System
Story 3.11: Error Recovery & Resume System (EPIC-3)

Implements checkpoint-based state management for resuming course generation
after interruptions (CTRL+C, API failures, crashes).
"""

import os
import sys
import signal
import yaml
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Any


class StateManager:
    """Manages checkpoint state for error recovery"""

    CHECKPOINT_NAMES = {
        1: "organized",
        2: "brief-complete",
        3: "curriculum-approved",
        4: "lessons-progress"
    }

    def __init__(self, course_slug: str):
        self.course_slug = course_slug
        self.course_dir = Path(f"outputs/courses/{course_slug}")
        self.state_dir = self.course_dir / ".state"
        self.current_checkpoint = None
        
        self.state_dir.mkdir(parents=True, exist_ok=True)
        signal.signal(signal.SIGINT, self.handle_interrupt)
        signal.signal(signal.SIGTERM, self.handle_interrupt)

    def handle_interrupt(self, sig, frame):
        """Handle CTRL+C (SIGINT) or termination"""
        print("\n⚠️  Interruption detected...")
        if self.current_checkpoint:
            try:
                self.save_checkpoint(self.current_checkpoint)
                print("✅ Progress saved successfully.")
            except Exception as e:
                print(f"❌ Error saving state: {e}")
        self.display_recovery_instructions()
        sys.exit(0)

    def save_checkpoint(self, checkpoint_data: Dict[str, Any]) -> Path:
        """Save checkpoint state to YAML file"""
        if "timestamp" not in checkpoint_data:
            checkpoint_data["timestamp"] = datetime.now().isoformat()
        if "course_slug" not in checkpoint_data:
            checkpoint_data["course_slug"] = self.course_slug

        checkpoint_name = checkpoint_data["checkpoint"]
        checkpoint_num = None
        for num, name in self.CHECKPOINT_NAMES.items():
            if name == checkpoint_name:
                checkpoint_num = num
                break

        if checkpoint_num:
            state_file = self.state_dir / f"state-{checkpoint_num}-{checkpoint_name}.yaml"
        else:
            state_file = self.state_dir / f"state-{checkpoint_name}.yaml"

        with open(state_file, 'w', encoding='utf-8') as f:
            yaml.dump(checkpoint_data, f, default_flow_style=False, allow_unicode=True)

        print(f"💾 Checkpoint saved: {state_file.name}")
        self.current_checkpoint = checkpoint_data
        return state_file

    def get_latest_state(self) -> Optional[Dict[str, Any]]:
        """Get the latest checkpoint state"""
        state_files = sorted(self.state_dir.glob("state-*.yaml"))
        if not state_files:
            return None
        latest_file = max(state_files, key=lambda p: p.stat().st_mtime)
        with open(latest_file, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def validate_state(self, state: Dict[str, Any]) -> bool:
        """Validate state file is not corrupted"""
        required_keys = ["checkpoint", "timestamp", "course_slug", "progress", "next_step"]
        for key in required_keys:
            if key not in state:
                return False
        if state["course_slug"] != self.course_slug:
            return False
        return isinstance(state["progress"], dict)

    def validate_context(self, state: Dict[str, Any]) -> bool:
        """Validate context files still exist"""
        context = state.get("context", {})
        if "brief_path" in context:
            if not Path(context["brief_path"]).exists():
                return False
        if "curriculum_path" in context:
            if not Path(context["curriculum_path"]).exists():
                return False
        return True

    def format_progress_summary(self, state: Dict[str, Any]) -> str:
        """Format progress summary for display"""
        checkpoint = state["checkpoint"]
        progress = state["progress"]

        if checkpoint == "lessons-progress" or checkpoint == "lesson_generation":
            completed = progress.get('lessons_completed', 0)
            total = progress.get('lessons_total', 0)
            last = progress.get('last_completed', 'None')
            next_pending = progress.get('next_pending', 'Unknown')
            percentage = int((completed / total * 100)) if total > 0 else 0
            return f"""
Progress Saved:
  ✅ Lessons completed: {completed}/{total} ({percentage}%)
  ✅ Last completed: {last}
  → Next: {next_pending}
"""
        return f"Checkpoint: {checkpoint}"

    def display_recovery_instructions(self):
        """Display recovery instructions to user"""
        latest_state = self.get_latest_state()
        if not latest_state:
            print("\n❌ No progress to recover (no checkpoints found).")
            return

        progress_summary = self.format_progress_summary(latest_state)
        print(f"""
════════════════════════════════════════════════════════════
⚠️  GENERATION INTERRUPTED
════════════════════════════════════════════════════════════

{progress_summary.strip()}

════════════════════════════════════════════════════════════

💾 Progress has been saved.

To resume from where you left off:
  *continue-course {self.course_slug} --resume

To start fresh (⚠️ deletes all progress):
  *continue-course {self.course_slug} --force

════════════════════════════════════════════════════════════
        """)

    def cleanup_states(self):
        """Delete all state files on successful completion"""
        if not self.state_dir.exists():
            return
        for state_file in self.state_dir.glob("state-*.yaml"):
            state_file.unlink()
        try:
            self.state_dir.rmdir()
        except OSError:
            pass

