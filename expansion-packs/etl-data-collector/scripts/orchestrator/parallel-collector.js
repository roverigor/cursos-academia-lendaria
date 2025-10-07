/**
 * Parallel Collector - Master Orchestrator
 * Coordinates parallel collection across all source types
 */

import yaml from 'js-yaml';
import fs from 'fs/promises';
import path from 'path';
import { TaskManager } from './task-manager.js';
import { ProgressTracker } from './progress-tracker.js';
import { YouTubeCollector } from '../collectors/youtube-collector.js';
import { WebCollector } from '../collectors/web-collector.js';
import { PDFCollector } from '../collectors/pdf-collector.js';
import { PodcastCollector } from '../collectors/podcast-collector.js';
import { SocialCollector } from '../collectors/social-collector.js';

export class ParallelCollector {
  constructor(configPath) {
    this.configPath = configPath;
    this.config = null;
    this.downloadRules = null;
    this.collectors = {};
    this.results = {
      successful: [],
      failed: [],
      startTime: null,
      endTime: null
    };
  }

  async initialize() {
    // Load download rules
    const rulesPath = path.join(path.dirname(this.configPath), 'download-rules.yaml');
    const rulesContent = await fs.readFile(rulesPath, 'utf8');
    this.downloadRules = yaml.load(rulesContent);

    // Initialize collectors
    this.collectors = {
      youtube: new YouTubeCollector(this.downloadRules),
      blog: new WebCollector(this.downloadRules),
      pdf: new PDFCollector(this.downloadRules),
      podcast: new PodcastCollector(this.downloadRules),
      social: new SocialCollector(this.downloadRules)
    };
  }

  async collectAll(sourcesPath, outputDir) {
    this.results.startTime = Date.now();

    // Load sources
    const sourcesContent = await fs.readFile(sourcesPath, 'utf8');
    const sourcesData = yaml.load(sourcesContent);
    const sources = sourcesData.sources || [];

    // Group by type
    const grouped = this._groupByType(sources);

    // Create task manager
    const taskManager = new TaskManager({ maxConcurrent: 5 });
    const progress = new ProgressTracker(sources.length);

    // Add tasks for each source
    for (const [type, typeSources] of Object.entries(grouped)) {
      for (const source of typeSources) {
        taskManager.addTask({
          id: source.id,
          type,
          source,
          execute: async () => {
            const collector = this.collectors[type];
            return await collector.collect(source, outputDir);
          }
        });
      }
    }

    // Monitor progress
    taskManager.on('task_completed', (task) => {
      this.results.successful.push(task);
      progress.increment(task.type, true);
      progress.display();
    });

    taskManager.on('task_failed', (task) => {
      this.results.failed.push(task);
      progress.increment(task.type, false);
      progress.display();
    });

    // Wait for completion
    await this._waitForCompletion(taskManager);

    this.results.endTime = Date.now();

    // Generate report
    return this._generateReport(sources.length);
  }

  _groupByType(sources) {
    const grouped = {};

    for (const source of sources) {
      const type = source.type || 'blog';
      
      if (!grouped[type]) {
        grouped[type] = [];
      }

      grouped[type].push(source);
    }

    return grouped;
  }

  async _waitForCompletion(taskManager) {
    return new Promise((resolve) => {
      const checkInterval = setInterval(() => {
        const stats = taskManager.getStats();
        
        if (stats.running === 0 && stats.pending === 0) {
          clearInterval(checkInterval);
          resolve();
        }
      }, 1000);
    });
  }

  _generateReport(totalSources) {
    const duration = (this.results.endTime - this.results.startTime) / 1000;

    return {
      total: totalSources,
      successful: this.results.successful.length,
      failed: this.results.failed.length,
      successRate: ((this.results.successful.length / totalSources) * 100).toFixed(1),
      duration: Math.floor(duration),
      results: this.results
    };
  }
}

export default ParallelCollector;
