const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');
const GitWrapper = require('./git-wrapper');

/**
 * Tracks and manages modification history for meta-agent changes
 */
class ModificationHistory {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.git = new GitWrapper(options);
    this.historyFile = path.join(
      this.rootPath,
      '.aios',
      'modification-history.json'
    );
    this.maxHistorySize = options.maxHistorySize || 1000;
    this.enableAnalytics = options.enableAnalytics !== false;
  }

  /**
   * Initialize history tracking
   * @returns {Promise<void>}
   */
  async initialize() {
    const historyDir = path.dirname(this.historyFile);
    
    try {
      await fs.mkdir(historyDir, { recursive: true });
      
      // Check if history file exists
      try {
        await fs.access(this.historyFile);
      } catch {
        // Create initial history file
        await this.saveHistory({
          version: '1.0.0',
          created: new Date().toISOString(),
          modifications: [],
          statistics: {
            totalModifications: 0,
            successfulModifications: 0,
            failedModifications: 0,
            rolledBackModifications: 0
          }
        });
      }
    } catch (error) {
      console.error(chalk.red(`Failed to initialize history: ${error.message}`));
    }
  }

  /**
   * Load modification history
   * @returns {Promise<Object>} History data
   */
  async loadHistory() {
    try {
      const content = await fs.readFile(this.historyFile, 'utf-8');
      return JSON.parse(content);
    } catch (error) {
      console.error(chalk.red(`Failed to load history: ${error.message}`));
      return {
        modifications: [],
        statistics: {}
      };
    }
  }

  /**
   * Save modification history
   * @param {Object} history - History data to save
   * @returns {Promise<void>}
   */
  async saveHistory(history) {
    try {
      // Ensure history doesn't exceed max size
      if (history.modifications && history.modifications.length > this.maxHistorySize) {
        history.modifications = history.modifications.slice(-this.maxHistorySize);
      }
      
      await fs.writeFile(
        this.historyFile,
        JSON.stringify(history, null, 2)
      );
    } catch (error) {
      console.error(chalk.red(`Failed to save history: ${error.message}`));
    }
  }

  /**
   * Record a new modification
   * @param {Object} modification - Modification details
   * @returns {Promise<string>} Modification ID
   */
  async recordModification(modification) {
    await this.initialize();
    
    const history = await this.loadHistory();
    const modificationId = this.generateModificationId();
    
    const record = {
      id: modificationId,
      timestamp: new Date().toISOString(),
      type: modification.type,
      target: modification.target,
      action: modification.action,
      status: 'pending',
      branch: await this.git.getCurrentBranch(),
      commit: null,
      files: modification.files || [],
      metadata: modification.metadata || {},
      user: modification.user || process.env.USER || 'unknown',
      duration: null,
      error: null,
      rollbackInfo: null
    };

    history.modifications.push(record);
    history.statistics.totalModifications++;
    
    await this.saveHistory(history);
    
    console.log(chalk.green(`✅ Recorded modification: ${modificationId}`));
    return modificationId;
  }

  /**
   * Update modification status
   * @param {string} modificationId - Modification ID
   * @param {Object} updates - Updates to apply
   * @returns {Promise<void>}
   */
  async updateModification(modificationId, updates) {
    const history = await this.loadHistory();
    const modification = history.modifications.find(m => m.id === modificationId);
    
    if (!modification) {
      throw new Error(`Modification not found: ${modificationId}`);
    }

    // Update fields
    Object.assign(modification, updates);
    
    // Update statistics based on status
    if (updates.status === 'completed' && modification.status !== 'completed') {
      history.statistics.successfulModifications++;
    } else if (updates.status === 'failed' && modification.status !== 'failed') {
      history.statistics.failedModifications++;
    } else if (updates.status === 'rolledback' && modification.status !== 'rolledback') {
      history.statistics.rolledBackModifications++;
    }

    // Calculate duration if completed
    if (updates.status === 'completed' || updates.status === 'failed') {
      const startTime = new Date(modification.timestamp);
      const endTime = new Date();
      modification.duration = endTime - startTime;
    }

    await this.saveHistory(history);
  }

  /**
   * Get modification by ID
   * @param {string} modificationId - Modification ID
   * @returns {Promise<Object>} Modification record
   */
  async getModification(modificationId) {
    const history = await this.loadHistory();
    return history.modifications.find(m => m.id === modificationId);
  }

  /**
   * Get modifications by filter
   * @param {Object} filter - Filter criteria
   * @returns {Promise<Array>} Filtered modifications
   */
  async getModifications(filter = {}) {
    const history = await this.loadHistory();
    let modifications = history.modifications;

    // Apply filters
    if (filter.type) {
      modifications = modifications.filter(m => m.type === filter.type);
    }
    
    if (filter.target) {
      modifications = modifications.filter(m => 
        m.target.toLowerCase().includes(filter.target.toLowerCase())
      );
    }
    
    if (filter.status) {
      modifications = modifications.filter(m => m.status === filter.status);
    }
    
    if (filter.user) {
      modifications = modifications.filter(m => m.user === filter.user);
    }
    
    if (filter.dateFrom) {
      const dateFrom = new Date(filter.dateFrom);
      modifications = modifications.filter(m => 
        new Date(m.timestamp) >= dateFrom
      );
    }
    
    if (filter.dateTo) {
      const dateTo = new Date(filter.dateTo);
      modifications = modifications.filter(m => 
        new Date(m.timestamp) <= dateTo
      );
    }

    // Sort by timestamp (newest first)
    modifications.sort((a, b) => 
      new Date(b.timestamp) - new Date(a.timestamp)
    );

    // Apply limit
    if (filter.limit) {
      modifications = modifications.slice(0, filter.limit);
    }

    return modifications;
  }

  /**
   * Get modification timeline
   * @param {Object} options - Timeline options
   * @returns {Promise<Object>} Timeline data
   */
  async getTimeline(options = {}) {
    const {
      groupBy = 'day',
      limit = 30
    } = options;

    const modifications = await this.getModifications();
    const timeline = {};

    modifications.forEach(mod => {
      const date = new Date(mod.timestamp);
      let key;

      switch (groupBy) {
        case 'hour':
          key = date.toISOString().substring(0, 13);
          break;
        case 'day':
          key = date.toISOString().substring(0, 10);
          break;
        case 'week':
          const week = this.getWeekNumber(date);
          key = `${date.getFullYear()}-W${week}`;
          break;
        case 'month':
          key = date.toISOString().substring(0, 7);
          break;
        default:
          key = date.toISOString().substring(0, 10);
      }

      if (!timeline[key]) {
        timeline[key] = {
          date: key,
          total: 0,
          successful: 0,
          failed: 0,
          rolledback: 0,
          types: {},
          modifications: []
        };
      }

      timeline[key].total++;
      if (mod.status === 'completed') timeline[key].successful++;
      if (mod.status === 'failed') timeline[key].failed++;
      if (mod.status === 'rolledback') timeline[key].rolledback++;
      
      timeline[key].types[mod.type] = (timeline[key].types[mod.type] || 0) + 1;
      timeline[key].modifications.push(mod.id);
    });

    // Convert to array and sort
    const timelineArray = Object.values(timeline)
      .sort((a, b) => new Date(b.date) - new Date(a.date))
      .slice(0, limit);

    return {
      groupBy,
      entries: timelineArray,
      summary: this.generateTimelineSummary(timelineArray)
    };
  }

  /**
   * Get modification statistics
   * @returns {Promise<Object>} Statistics
   */
  async getStatistics() {
    const history = await this.loadHistory();
    const modifications = history.modifications;

    // Calculate additional statistics
    const typeDistribution = {};
    const userActivity = {};
    const statusDistribution = {};
    const averageDuration = {};
    const monthlyTrend = {};

    modifications.forEach(mod => {
      // Type distribution
      typeDistribution[mod.type] = (typeDistribution[mod.type] || 0) + 1;
      
      // User activity
      userActivity[mod.user] = (userActivity[mod.user] || 0) + 1;
      
      // Status distribution
      statusDistribution[mod.status] = (statusDistribution[mod.status] || 0) + 1;
      
      // Average duration by type
      if (mod.duration && mod.status === 'completed') {
        if (!averageDuration[mod.type]) {
          averageDuration[mod.type] = { total: 0, count: 0 };
        }
        averageDuration[mod.type].total += mod.duration;
        averageDuration[mod.type].count++;
      }
      
      // Monthly trend
      const month = new Date(mod.timestamp).toISOString().substring(0, 7);
      if (!monthlyTrend[month]) {
        monthlyTrend[month] = { total: 0, successful: 0, failed: 0 };
      }
      monthlyTrend[month].total++;
      if (mod.status === 'completed') monthlyTrend[month].successful++;
      if (mod.status === 'failed') monthlyTrend[month].failed++;
    });

    // Calculate average durations
    Object.keys(averageDuration).forEach(type => {
      averageDuration[type] = Math.round(
        averageDuration[type].total / averageDuration[type].count
      );
    });

    // Success rate
    const successRate = history.statistics.totalModifications > 0
      ? (history.statistics.successfulModifications / history.statistics.totalModifications * 100).toFixed(2)
      : 0;

    return {
      ...history.statistics,
      successRate: `${successRate}%`,
      typeDistribution,
      userActivity,
      statusDistribution,
      averageDuration,
      monthlyTrend,
      mostActiveUser: this.getMostActive(userActivity),
      mostCommonType: this.getMostActive(typeDistribution),
      recentActivity: await this.getRecentActivity()
    };
  }

  /**
   * Get recent activity summary
   * @returns {Promise<Object>} Recent activity
   */
  async getRecentActivity() {
    const last24Hours = await this.getModifications({
      dateFrom: new Date(Date.now() - 24 * 60 * 60 * 1000),
      limit: 10
    });

    const last7Days = await this.getModifications({
      dateFrom: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)
    });

    const last30Days = await this.getModifications({
      dateFrom: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000)
    });

    return {
      last24Hours: last24Hours.length,
      last7Days: last7Days.length,
      last30Days: last30Days.length,
      recentModifications: last24Hours.slice(0, 5).map(m => ({
        id: m.id,
        type: m.type,
        target: m.target,
        timestamp: m.timestamp,
        status: m.status
      }))
    };
  }

  /**
   * Generate impact report for a modification
   * @param {string} modificationId - Modification ID
   * @returns {Promise<Object>} Impact report
   */
  async generateImpactReport(modificationId) {
    const modification = await this.getModification(modificationId);
    if (!modification) {
      throw new Error(`Modification not found: ${modificationId}`);
    }

    const impactReport = {
      modification: {
        id: modification.id,
        type: modification.type,
        target: modification.target,
        timestamp: modification.timestamp,
        status: modification.status
      },
      directImpact: {
        filesModified: modification.files.length,
        files: modification.files
      },
      gitImpact: {},
      dependencyImpact: [],
      relatedModifications: []
    };

    // Get git impact if commit exists
    if (modification.commit) {
      try {
        const diff = await this.git.getDiff({
          from: `${modification.commit}^`,
          to: modification.commit
        });
        
        const lines = diff.split('\n');
        let additions = 0;
        let deletions = 0;
        
        lines.forEach(line => {
          if (line.startsWith('+') && !line.startsWith('+++')) additions++;
          if (line.startsWith('-') && !line.startsWith('---')) deletions++;
        });
        
        impactReport.gitImpact = {
          commit: modification.commit,
          additions,
          deletions,
          netChange: additions - deletions
        };
      } catch (error) {
        console.warn(`Could not get git impact: ${error.message}`);
      }
    }

    // Find related modifications (same target or type)
    const relatedMods = await this.getModifications({
      limit: 10
    });
    
    impactReport.relatedModifications = relatedMods
      .filter(m => 
        m.id !== modificationId && 
        (m.target === modification.target || m.type === modification.type)
      )
      .slice(0, 5)
      .map(m => ({
        id: m.id,
        type: m.type,
        target: m.target,
        timestamp: m.timestamp,
        relation: m.target === modification.target ? 'same-target' : 'same-type'
      }));

    return impactReport;
  }

  /**
   * Export history to different formats
   * @param {Object} options - Export options
   * @returns {Promise<string>} Export data
   */
  async exportHistory(options = {}) {
    const {
      format = 'json',
      filter = {},
      includeStatistics = true
    } = options;

    const modifications = await this.getModifications(filter);
    const statistics = includeStatistics ? await this.getStatistics() : null;

    const exportData = {
      exported: new Date().toISOString(),
      version: '1.0.0',
      modifications,
      statistics,
      filter
    };

    switch (format) {
      case 'json':
        return JSON.stringify(exportData, null, 2);
        
      case 'csv':
        return this.exportToCSV(modifications);
        
      case 'markdown':
        return this.exportToMarkdown(exportData);
        
      default:
        throw new Error(`Unsupported export format: ${format}`);
    }
  }

  /**
   * Generate modification ID
   * @private
   */
  generateModificationId() {
    const timestamp = Date.now();
    const random = Math.random().toString(36).substring(2, 6);
    return `mod-${timestamp}-${random}`;
  }

  /**
   * Get week number
   * @private
   */
  getWeekNumber(date) {
    const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
    const dayNum = d.getUTCDay() || 7;
    d.setUTCDate(d.getUTCDate() + 4 - dayNum);
    const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
    const weekNum = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
    return weekNum;
  }

  /**
   * Get most active item from distribution
   * @private
   */
  getMostActive(distribution) {
    let maxCount = 0;
    let mostActive = null;
    
    Object.entries(distribution).forEach(([key, count]) => {
      if (count > maxCount) {
        maxCount = count;
        mostActive = key;
      }
    });
    
    return mostActive;
  }

  /**
   * Generate timeline summary
   * @private
   */
  generateTimelineSummary(timeline) {
    const total = timeline.reduce((sum, entry) => sum + entry.total, 0);
    const successful = timeline.reduce((sum, entry) => sum + entry.successful, 0);
    const failed = timeline.reduce((sum, entry) => sum + entry.failed, 0);
    
    return {
      totalModifications: total,
      successfulModifications: successful,
      failedModifications: failed,
      successRate: total > 0 ? ((successful / total) * 100).toFixed(2) + '%' : '0%',
      periodsCovered: timeline.length
    };
  }

  /**
   * Export to CSV format
   * @private
   */
  exportToCSV(modifications) {
    const headers = [
      'ID',
      'Timestamp',
      'Type',
      'Target',
      'Action',
      'Status',
      'User',
      'Branch',
      'Commit',
      'Duration (ms)',
      'Files Modified'
    ];

    const rows = modifications.map(mod => [
      mod.id,
      mod.timestamp,
      mod.type,
      mod.target,
      mod.action,
      mod.status,
      mod.user,
      mod.branch,
      mod.commit || '',
      mod.duration || '',
      mod.files.length
    ]);

    const csv = [
      headers.join(','),
      ...rows.map(row => row.map(cell => `"${cell}"`).join(','))
    ].join('\n');

    return csv;
  }

  /**
   * Export to Markdown format
   * @private
   */
  exportToMarkdown(data) {
    const { modifications, statistics } = data;
    
    let markdown = '# Modification History Export\n\n';
    markdown += `**Exported:** ${data.exported}\n\n`;
    
    if (statistics) {
      markdown += '## Statistics\n\n';
      markdown += `- **Total Modifications:** ${statistics.totalModifications}\n`;
      markdown += `- **Success Rate:** ${statistics.successRate}\n`;
      markdown += `- **Most Common Type:** ${statistics.mostCommonType}\n`;
      markdown += `- **Most Active User:** ${statistics.mostActiveUser}\n\n`;
    }
    
    markdown += '## Modifications\n\n';
    
    modifications.forEach(mod => {
      markdown += `### ${mod.id}\n`;
      markdown += `- **Type:** ${mod.type}\n`;
      markdown += `- **Target:** ${mod.target}\n`;
      markdown += `- **Status:** ${mod.status}\n`;
      markdown += `- **Timestamp:** ${mod.timestamp}\n`;
      markdown += `- **User:** ${mod.user}\n`;
      if (mod.commit) {
        markdown += `- **Commit:** ${mod.commit}\n`;
      }
      markdown += '\n';
    });
    
    return markdown;
  }
}

module.exports = ModificationHistory;