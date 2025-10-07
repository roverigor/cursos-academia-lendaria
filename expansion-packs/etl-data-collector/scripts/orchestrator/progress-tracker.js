/**
 * Progress Tracker
 * Real-time progress tracking with ETA calculation
 */

import EventEmitter from 'events';

export class ProgressTracker extends EventEmitter {
  constructor(total) {
    super();
    
    this.total = total;
    this.completed = 0;
    this.failed = 0;
    this.startTime = Date.now();
    
    this.byType = {};
  }

  increment(type = 'default', success = true) {
    if (success) {
      this.completed++;
    } else {
      this.failed++;
    }

    if (!this.byType[type]) {
      this.byType[type] = { completed: 0, failed: 0, total: 0 };
    }

    if (success) {
      this.byType[type].completed++;
    } else {
      this.byType[type].failed++;
    }

    this.emit('progress', this.getProgress());
  }

  getProgress() {
    const processed = this.completed + this.failed;
    const percentage = (processed / this.total) * 100;
    
    const elapsed = Date.now() - this.startTime;
    const rate = processed / (elapsed / 1000);
    const remaining = this.total - processed;
    const eta = remaining / rate;

    return {
      total: this.total,
      completed: this.completed,
      failed: this.failed,
      processed,
      percentage: percentage.toFixed(1),
      elapsed: Math.floor(elapsed / 1000),
      eta: Math.floor(eta),
      byType: this.byType
    };
  }

  display() {
    const progress = this.getProgress();
    const bar = this._createProgressBar(progress.percentage);
    
    console.log(`\n${bar} ${progress.percentage}% (${progress.processed}/${progress.total})`);
    console.log(`✓ ${progress.completed} | ✗ ${progress.failed} | ETA: ${progress.eta}s`);
  }

  _createProgressBar(percentage, width = 40) {
    const filled = Math.floor((percentage / 100) * width);
    const empty = width - filled;
    return '█'.repeat(filled) + '░'.repeat(empty);
  }
}

export default ProgressTracker;
