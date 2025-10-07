/**
 * Task Manager
 * Manages task queue with priority and concurrency control
 */

import EventEmitter from 'events';

export class TaskManager extends EventEmitter {
  constructor(options = {}) {
    super();
    
    this.maxConcurrent = options.maxConcurrent || 5;
    this.queue = [];
    this.running = new Map();
    this.completed = [];
    this.failed = [];
  }

  addTask(task) {
    this.queue.push({
      ...task,
      status: 'pending',
      attempts: 0,
      addedAt: Date.now()
    });
    
    this.emit('task_added', task);
    this._processQueue();
  }

  async _processQueue() {
    while (this.running.size < this.maxConcurrent && this.queue.length > 0) {
      const task = this.queue.shift();
      this._executeTask(task);
    }
  }

  async _executeTask(task) {
    task.status = 'running';
    task.startedAt = Date.now();
    this.running.set(task.id, task);
    
    this.emit('task_started', task);

    try {
      const result = await task.execute();
      
      task.status = 'completed';
      task.completedAt = Date.now();
      task.result = result;
      
      this.running.delete(task.id);
      this.completed.push(task);
      
      this.emit('task_completed', task);
      
    } catch (error) {
      task.attempts++;
      task.error = error.message;
      
      if (task.attempts < (task.maxRetries || 3)) {
        task.status = 'retrying';
        this.queue.push(task);
        this.emit('task_retrying', task);
      } else {
        task.status = 'failed';
        this.running.delete(task.id);
        this.failed.push(task);
        this.emit('task_failed', task);
      }
    }

    this._processQueue();
  }

  getStats() {
    return {
      pending: this.queue.length,
      running: this.running.size,
      completed: this.completed.length,
      failed: this.failed.length,
      total: this.queue.length + this.running.size + this.completed.length + this.failed.length
    };
  }
}

export default TaskManager;
