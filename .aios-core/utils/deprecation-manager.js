const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Deprecation manager for AIOS-FULLSTACK framework
 * Manages component deprecation lifecycle, tracking, and timeline management
 */
class DeprecationManager {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.deprecationDir = path.join(this.rootPath, '.aios', 'deprecations');
    this.deprecationRegistry = path.join(this.deprecationDir, 'registry.json');
    this.scheduledTasks = path.join(this.deprecationDir, 'scheduled-tasks.json');
    this.deprecationHistory = [];
    this.scheduledTasksList = [];
  }

  /**
   * Initialize deprecation manager
   */
  async initialize() {
    try {
      // Create deprecation directory
      await fs.mkdir(this.deprecationDir, { recursive: true });

      // Load deprecation registry
      await this.loadDeprecationRegistry();

      // Load scheduled tasks
      await this.loadScheduledTasks();

      console.log(chalk.green('✅ Deprecation manager initialized'));
      return true;

    } catch (error) {
      console.error(chalk.red(`Failed to initialize deprecation manager: ${error.message}`));
      throw error;
    }
  }

  /**
   * Record a new component deprecation
   */
  async recordDeprecation(componentId, deprecationData) {
    const deprecation = {
      component_id: componentId,
      deprecation_id: deprecationData.deprecationId,
      timestamp: deprecationData.timestamp || new Date().toISOString(),
      status: 'active',
      plan: deprecationData.plan,
      results: deprecationData.results,
      usage_tracking: {
        initial_usage_count: deprecationData.plan?.usageCount || 0,
        tracking_enabled: true,
        last_check: new Date().toISOString()
      },
      timeline_events: [
        {
          event: 'deprecation_recorded',
          timestamp: new Date().toISOString(),
          details: 'Component marked as deprecated'
        }
      ]
    };

    // Add to registry
    this.deprecationHistory.push(deprecation);

    // Save registry
    await this.saveDeprecationRegistry();

    // Create detailed deprecation file
    await this.createDeprecationFile(deprecation);

    return deprecation;
  }

  /**
   * Get deprecation status for a component
   */
  async getDeprecationStatus(componentId) {
    const deprecation = this.deprecationHistory.find(d => d.component_id === componentId && d.status === 'active');
    
    if (!deprecation) {
      return {
        deprecated: false,
        deprecationId: null,
        status: 'active'
      };
    }

    return {
      deprecated: true,
      deprecationId: deprecation.deprecation_id,
      deprecatedSince: deprecation.timestamp,
      removalVersion: deprecation.plan?.removalVersion,
      replacement: deprecation.plan?.replacement,
      reason: deprecation.plan?.reason,
      severity: deprecation.plan?.severity,
      timeline: deprecation.plan?.timeline,
      status: deprecation.status,
      usageTracking: deprecation.usage_tracking
    };
  }

  /**
   * Update deprecation status
   */
  async updateDeprecationStatus(componentId, updates) {
    const deprecationIndex = this.deprecationHistory.findIndex(
      d => d.component_id === componentId && d.status === 'active'
    );

    if (deprecationIndex === -1) {
      throw new Error(`No active deprecation found for component: ${componentId}`);
    }

    const deprecation = this.deprecationHistory[deprecationIndex];

    // Update fields
    if (updates.status) {
      deprecation.status = updates.status;
    }

    if (updates.usageCount !== undefined) {
      deprecation.usage_tracking.initial_usage_count = updates.usageCount;
      deprecation.usage_tracking.last_check = new Date().toISOString();
    }

    // Add timeline event
    deprecation.timeline_events.push({
      event: 'status_updated',
      timestamp: new Date().toISOString(),
      details: `Updated: ${Object.keys(updates).join(', ')}`,
      changes: updates
    });

    // Save changes
    await this.saveDeprecationRegistry();
    await this.updateDeprecationFile(deprecation);

    return deprecation;
  }

  /**
   * Get all active deprecations
   */
  getActiveDeprecations() {
    return this.deprecationHistory.filter(d => d.status === 'active');
  }

  /**
   * Get deprecations by timeline urgency
   */
  getDeprecationsByUrgency() {
    const active = this.getActiveDeprecations();
    const now = new Date();

    return {
      critical: active.filter(d => this.isDeprecationCritical(d, now)),
      urgent: active.filter(d => this.isDeprecationUrgent(d, now)),
      warning: active.filter(d => this.isDeprecationWarning(d, now)),
      normal: active.filter(d => !this.isDeprecationCritical(d, now) && 
                                !this.isDeprecationUrgent(d, now) && 
                                !this.isDeprecationWarning(d, now))
    };
  }

  /**
   * Schedule a deprecation-related task
   */
  async scheduleTask(task) {
    const scheduledTask = {
      task_id: `task-${Date.now()}-${Math.random().toString(36).substr(2, 6)}`,
      type: task.type,
      scheduled_for: task.scheduledFor,
      component_id: task.component,
      message: task.message,
      status: 'scheduled',
      created_at: new Date().toISOString(),
      metadata: task.metadata || {}
    };

    this.scheduledTasksList.push(scheduledTask);
    await this.saveScheduledTasks();

    return scheduledTask;
  }

  /**
   * Get scheduled tasks due for execution
   */
  getDueTasks(date = new Date()) {
    const dueTasks = this.scheduledTasksList.filter(task => {
      const scheduledDate = new Date(task.scheduled_for);
      return scheduledDate <= date && task.status === 'scheduled';
    });

    return dueTasks;
  }

  /**
   * Execute scheduled task
   */
  async executeScheduledTask(taskId) {
    const taskIndex = this.scheduledTasksList.findIndex(t => t.task_id === taskId);
    
    if (taskIndex === -1) {
      throw new Error(`Scheduled task not found: ${taskId}`);
    }

    const task = this.scheduledTasksList[taskIndex];
    
    try {
      // Execute based on task type
      const result = await this.executeTaskByType(task);

      // Update task status
      task.status = 'completed';
      task.completed_at = new Date().toISOString();
      task.result = result;

      await this.saveScheduledTasks();

      return {
        success: true,
        task: task,
        result: result
      };

    } catch (error) {
      // Mark task as failed
      task.status = 'failed';
      task.failed_at = new Date().toISOString();
      task.error = error.message;

      await this.saveScheduledTasks();

      throw error;
    }
  }

  /**
   * Get deprecation metrics and statistics
   */
  getDeprecationMetrics() {
    const total = this.deprecationHistory.length;
    const active = this.getActiveDeprecations().length;
    const completed = this.deprecationHistory.filter(d => d.status === 'removed').length;
    const urgencyBreakdown = this.getDeprecationsByUrgency();

    return {
      total_deprecations: total,
      active_deprecations: active,
      completed_removals: completed,
      urgency_breakdown: {
        critical: urgencyBreakdown.critical.length,
        urgent: urgencyBreakdown.urgent.length,
        warning: urgencyBreakdown.warning.length,
        normal: urgencyBreakdown.normal.length
      },
      scheduled_tasks: this.scheduledTasksList.filter(t => t.status === 'scheduled').length,
      failed_tasks: this.scheduledTasksList.filter(t => t.status === 'failed').length
    };
  }

  /**
   * Generate deprecation report
   */
  async generateDeprecationReport() {
    const metrics = this.getDeprecationMetrics();
    const urgencyGroups = this.getDeprecationsByUrgency();
    const dueTasks = this.getDueTasks();

    const report = {
      generated_at: new Date().toISOString(),
      summary: metrics,
      critical_deprecations: urgencyGroups.critical.map(d => ({
        component_id: d.component_id,
        deprecation_id: d.deprecation_id,
        reason: d.plan?.reason,
        removal_version: d.plan?.removalVersion,
        days_remaining: this.calculateDaysUntilRemoval(d)
      })),
      urgent_deprecations: urgencyGroups.urgent.map(d => ({
        component_id: d.component_id,
        deprecation_id: d.deprecation_id,
        reason: d.plan?.reason,
        removal_version: d.plan?.removalVersion,
        days_remaining: this.calculateDaysUntilRemoval(d)
      })),
      due_tasks: dueTasks.map(t => ({
        task_id: t.task_id,
        type: t.type,
        component_id: t.component_id,
        message: t.message,
        scheduled_for: t.scheduled_for
      })),
      recommendations: this.generateRecommendations(urgencyGroups, dueTasks)
    };

    // Save report
    const reportPath = path.join(this.deprecationDir, `deprecation-report-${Date.now()}.json`);
    await fs.writeFile(reportPath, JSON.stringify(report, null, 2));

    return {
      report: report,
      report_path: reportPath
    };
  }

  // Helper methods

  async loadDeprecationRegistry() {
    try {
      const content = await fs.readFile(this.deprecationRegistry, 'utf-8');
      this.deprecationHistory = JSON.parse(content);
    } catch (error) {
      // Registry doesn't exist yet
      this.deprecationHistory = [];
    }
  }

  async saveDeprecationRegistry() {
    await fs.writeFile(
      this.deprecationRegistry, 
      JSON.stringify(this.deprecationHistory, null, 2)
    );
  }

  async loadScheduledTasks() {
    try {
      const content = await fs.readFile(this.scheduledTasks, 'utf-8');
      this.scheduledTasksList = JSON.parse(content);
    } catch (error) {
      // Tasks file doesn't exist yet
      this.scheduledTasksList = [];
    }
  }

  async saveScheduledTasks() {
    await fs.writeFile(
      this.scheduledTasks, 
      JSON.stringify(this.scheduledTasksList, null, 2)
    );
  }

  async createDeprecationFile(deprecation) {
    const filename = `${deprecation.component_id}-${deprecation.deprecation_id}.json`;
    const filePath = path.join(this.deprecationDir, filename);
    
    await fs.writeFile(filePath, JSON.stringify(deprecation, null, 2));
  }

  async updateDeprecationFile(deprecation) {
    const filename = `${deprecation.component_id}-${deprecation.deprecation_id}.json`;
    const filePath = path.join(this.deprecationDir, filename);
    
    await fs.writeFile(filePath, JSON.stringify(deprecation, null, 2));
  }

  isDeprecationCritical(deprecation, currentDate) {
    const timeline = deprecation.plan?.timeline || 6;
    const deprecatedDate = new Date(deprecation.timestamp);
    const monthsElapsed = this.calculateMonthsDifference(deprecatedDate, currentDate);
    
    // Critical if > 90% of timeline has passed
    return monthsElapsed >= (timeline * 0.9);
  }

  isDeprecationUrgent(deprecation, currentDate) {
    const timeline = deprecation.plan?.timeline || 6;
    const deprecatedDate = new Date(deprecation.timestamp);
    const monthsElapsed = this.calculateMonthsDifference(deprecatedDate, currentDate);
    
    // Urgent if > 75% of timeline has passed
    return monthsElapsed >= (timeline * 0.75) && monthsElapsed < (timeline * 0.9);
  }

  isDeprecationWarning(deprecation, currentDate) {
    const timeline = deprecation.plan?.timeline || 6;
    const deprecatedDate = new Date(deprecation.timestamp);
    const monthsElapsed = this.calculateMonthsDifference(deprecatedDate, currentDate);
    
    // Warning if > 50% of timeline has passed
    return monthsElapsed >= (timeline * 0.5) && monthsElapsed < (timeline * 0.75);
  }

  calculateMonthsDifference(startDate, endDate) {
    const start = new Date(startDate);
    const end = new Date(endDate);
    
    const yearDiff = end.getFullYear() - start.getFullYear();
    const monthDiff = end.getMonth() - start.getMonth();
    
    return yearDiff * 12 + monthDiff;
  }

  calculateDaysUntilRemoval(deprecation) {
    const timeline = deprecation.plan?.timeline || 6;
    const deprecatedDate = new Date(deprecation.timestamp);
    const removalDate = new Date(deprecatedDate);
    removalDate.setMonth(removalDate.getMonth() + timeline);
    
    const now = new Date();
    const diffTime = removalDate - now;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    
    return Math.max(0, diffDays);
  }

  async executeTaskByType(task) {
    switch (task.type) {
      case 'deprecation_reminder':
        return await this.sendDeprecationReminder(task);
      
      case 'removal_preparation':
        return await this.prepareForRemoval(task);
      
      case 'usage_check':
        return await this.checkComponentUsage(task);
      
      default:
        throw new Error(`Unknown task type: ${task.type}`);
    }
  }

  async sendDeprecationReminder(task) {
    console.log(chalk.yellow(`📅 Deprecation reminder: ${task.message}`));
    return { action: 'reminder_sent', message: task.message };
  }

  async prepareForRemoval(task) {
    console.log(chalk.red(`🗑️  Removal preparation: ${task.message}`));
    return { action: 'removal_prepared', component: task.component_id };
  }

  async checkComponentUsage(task) {
    // This would integrate with usage tracker
    console.log(chalk.blue(`🔍 Usage check: ${task.message}`));
    return { action: 'usage_checked', component: task.component_id };
  }

  generateRecommendations(urgencyGroups, dueTasks) {
    const recommendations = [];

    if (urgencyGroups.critical.length > 0) {
      recommendations.push({
        priority: 'critical',
        message: `${urgencyGroups.critical.length} deprecations require immediate attention`,
        action: 'Review critical deprecations and plan removal'
      });
    }

    if (urgencyGroups.urgent.length > 0) {
      recommendations.push({
        priority: 'high',
        message: `${urgencyGroups.urgent.length} deprecations are approaching removal deadline`,
        action: 'Begin migration planning for urgent deprecations'
      });
    }

    if (dueTasks.length > 0) {
      recommendations.push({
        priority: 'medium',
        message: `${dueTasks.length} scheduled tasks are due for execution`,
        action: 'Execute due deprecation tasks'
      });
    }

    return recommendations;
  }
}

module.exports = DeprecationManager;