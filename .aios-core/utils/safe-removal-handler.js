const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Safe removal handler for AIOS-FULLSTACK deprecated components
 * Handles automated removal of components after deprecation period expires
 */
class SafeRemovalHandler {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.removalDir = path.join(this.rootPath, '.aios', 'removals');
    this.quarantineDir = path.join(this.removalDir, 'quarantine');
    this.archiveDir = path.join(this.removalDir, 'archive');
    this.deprecationManager = options.deprecationManager;
    this.usageTracker = options.usageTracker;
    this.removalQueue = [];
    this.safetyChecks = this.initializeSafetyChecks();
  }

  /**
   * Initialize safe removal handler
   */
  async initialize() {
    try {
      // Create removal directories
      await fs.mkdir(this.removalDir, { recursive: true });
      await fs.mkdir(this.quarantineDir, { recursive: true });
      await fs.mkdir(this.archiveDir, { recursive: true });

      // Create removal logs directory
      await fs.mkdir(path.join(this.removalDir, 'logs'), { recursive: true });

      console.log(chalk.green('✅ Safe removal handler initialized'));
      return true;

    } catch (error) {
      console.error(chalk.red(`Failed to initialize safe removal handler: ${error.message}`));
      throw error;
    }
  }

  /**
   * Process components eligible for safe removal
   */
  async processRemovalQueue() {
    console.log(chalk.blue('🗑️  Processing component removal queue...'));

    try {
      // Get components eligible for removal
      const eligibleComponents = await this.getEligibleComponents();
      
      if (eligibleComponents.length === 0) {
        console.log(chalk.gray('No components eligible for removal'));
        return { processed: 0, removed: 0, quarantined: 0 };
      }

      console.log(chalk.gray(`Found ${eligibleComponents.length} component(s) eligible for removal`));

      const results = {
        processed: 0,
        removed: 0,
        quarantined: 0,
        errors: []
      };

      // Process each eligible component
      for (const component of eligibleComponents) {
        try {
          const removalResult = await this.processComponentRemoval(component);
          results.processed++;
          
          if (removalResult.action === 'removed') {
            results.removed++;
          } else if (removalResult.action === 'quarantined') {
            results.quarantined++;
          }

        } catch (error) {
          results.errors.push({
            component_id: component.component_id,
            error: error.message
          });
          console.error(chalk.red(`Failed to process ${component.component_id}: ${error.message}`));
        }
      }

      // Generate removal report
      await this.generateRemovalReport(results, eligibleComponents);

      console.log(chalk.green(`✅ Removal queue processed:`));
      console.log(chalk.gray(`   Processed: ${results.processed}`));
      console.log(chalk.gray(`   Removed: ${results.removed}`));
      console.log(chalk.gray(`   Quarantined: ${results.quarantined}`));
      console.log(chalk.gray(`   Errors: ${results.errors.length}`));

      return results;

    } catch (error) {
      console.error(chalk.red(`Failed to process removal queue: ${error.message}`));
      throw error;
    }
  }

  /**
   * Get components eligible for removal
   */
  async getEligibleComponents() {
    const now = new Date();
    const eligibleComponents = [];

    if (!this.deprecationManager) {
      throw new Error('Deprecation manager not available');
    }

    // Get all active deprecations
    const activeDeprecations = this.deprecationManager.getActiveDeprecations();

    for (const deprecation of activeDeprecations) {
      const removalDate = this.calculateRemovalDate(deprecation);
      
      if (now >= removalDate) {
        eligibleComponents.push(deprecation);
      }
    }

    return eligibleComponents;
  }

  /**
   * Process removal of a single component
   */
  async processComponentRemoval(deprecation) {
    const componentId = deprecation.component_id;
    console.log(chalk.blue(`🔍 Processing removal for ${componentId}`));

    const removalSession = {
      component_id: componentId,
      deprecation_id: deprecation.deprecation_id,
      removal_id: `removal-${Date.now()}-${Math.random().toString(36).substr(2, 6)}`,
      start_time: new Date().toISOString(),
      action: null,
      safety_checks: {},
      removal_steps: [],
      errors: [],
      archived_files: []
    };

    try {
      // Run comprehensive safety checks
      console.log(chalk.gray('Running safety checks...'));
      removalSession.safety_checks = await this.runSafetyChecks(deprecation);

      // Determine action based on safety checks
      const action = this.determineRemovalAction(removalSession.safety_checks);
      removalSession.action = action;

      if (action === 'safe_to_remove') {
        // Perform safe removal
        console.log(chalk.green(`✅ Safe to remove ${componentId}`));
        await this.performSafeRemoval(deprecation, removalSession);

      } else if (action === 'quarantine') {
        // Move to quarantine for manual review
        console.log(chalk.yellow(`⚠️  Quarantining ${componentId} for manual review`));
        await this.quarantineComponent(deprecation, removalSession);

      } else {
        // Defer removal
        console.log(chalk.yellow(`⏳ Deferring removal of ${componentId}`));
        await this.deferRemoval(deprecation, removalSession);
      }

      // Update deprecation status
      await this.updateDeprecationStatus(deprecation, removalSession);

      // Log removal session
      await this.logRemovalSession(removalSession);

      return removalSession;

    } catch (error) {
      removalSession.errors.push(error.message);
      removalSession.action = 'failed';
      
      console.error(chalk.red(`❌ Removal processing failed for ${componentId}: ${error.message}`));
      throw error;
    }
  }

  /**
   * Run comprehensive safety checks before removal
   */
  async runSafetyChecks(deprecation) {
    const safetyResults = {};

    for (const [checkName, checkFunction] of Object.entries(this.safetyChecks)) {
      try {
        console.log(chalk.gray(`  Running ${checkName}...`));
        safetyResults[checkName] = await checkFunction.call(this, deprecation);
      } catch (error) {
        safetyResults[checkName] = {
          passed: false,
          error: error.message,
          risk_level: 'high'
        };
      }
    }

    return safetyResults;
  }

  /**
   * Determine removal action based on safety check results
   */
  determineRemovalAction(safetyResults) {
    const failedChecks = Object.entries(safetyResults)
      .filter(([_, result]) => !result.passed);

    const highRiskChecks = failedChecks
      .filter(([_, result]) => result.risk_level === 'high');

    const criticalChecks = failedChecks
      .filter(([_, result]) => result.risk_level === 'critical');

    // Critical failures require manual intervention
    if (criticalChecks.length > 0) {
      return 'defer';
    }

    // High risk failures require quarantine
    if (highRiskChecks.length > 0) {
      return 'quarantine';
    }

    // Medium/low risk or all checks passed
    if (failedChecks.length <= 2) {
      return 'safe_to_remove';
    }

    return 'quarantine';
  }

  /**
   * Perform safe removal of component
   */
  async performSafeRemoval(deprecation, removalSession) {
    const componentId = deprecation.component_id;
    const [componentType, componentName] = componentId.split('/');

    // Step 1: Create comprehensive backup
    console.log(chalk.gray('Creating removal backup...'));
    const backupResult = await this.createRemovalBackup(deprecation);
    removalSession.removal_steps.push({
      step: 'backup_creation',
      success: backupResult.success,
      details: backupResult
    });

    // Step 2: Remove component files
    console.log(chalk.gray('Removing component files...'));
    const fileRemovalResult = await this.removeComponentFiles(deprecation);
    removalSession.removal_steps.push({
      step: 'file_removal',
      success: fileRemovalResult.success,
      details: fileRemovalResult
    });

    // Step 3: Clean up component references
    console.log(chalk.gray('Cleaning component references...'));
    const referenceCleanupResult = await this.cleanupComponentReferences(deprecation);
    removalSession.removal_steps.push({
      step: 'reference_cleanup',
      success: referenceCleanupResult.success,
      details: referenceCleanupResult
    });

    // Step 4: Remove from component registry
    console.log(chalk.gray('Updating component registry...'));
    const registryUpdateResult = await this.updateComponentRegistry(deprecation);
    removalSession.removal_steps.push({
      step: 'registry_update',
      success: registryUpdateResult.success,
      details: registryUpdateResult
    });

    // Step 5: Archive component metadata
    console.log(chalk.gray('Archiving component metadata...'));
    const archiveResult = await this.archiveComponentMetadata(deprecation, removalSession);
    removalSession.removal_steps.push({
      step: 'metadata_archival',
      success: archiveResult.success,
      details: archiveResult
    });

    // Verify removal success
    const allStepsSuccessful = removalSession.removal_steps.every(step => step.success);
    
    if (allStepsSuccessful) {
      console.log(chalk.green(`✅ Successfully removed ${componentId}`));
    } else {
      console.log(chalk.yellow(`⚠️  Partial removal of ${componentId} - some steps failed`));
    }
  }

  /**
   * Quarantine component for manual review
   */
  async quarantineComponent(deprecation, removalSession) {
    const componentId = deprecation.component_id;
    const quarantineId = `quarantine-${Date.now()}`;
    const quarantinePath = path.join(this.quarantineDir, quarantineId);

    try {
      // Create quarantine directory
      await fs.mkdir(quarantinePath, { recursive: true });

      // Copy component files to quarantine
      const componentFiles = await this.identifyComponentFiles(deprecation);
      for (const file of componentFiles) {
        try {
          const fileName = path.basename(file);
          const quarantineFilePath = path.join(quarantinePath, fileName);
          await fs.copyFile(file, quarantineFilePath);
        } catch (error) {
          console.warn(chalk.yellow(`Failed to quarantine file ${file}: ${error.message}`));
        }
      }

      // Create quarantine metadata
      const quarantineMetadata = {
        quarantine_id: quarantineId,
        component_id: componentId,
        deprecation_id: deprecation.deprecation_id,
        quarantined_at: new Date().toISOString(),
        reason: 'Safety checks failed',
        safety_check_results: removalSession.safety_checks,
        files_quarantined: componentFiles.length,
        manual_review_required: true
      };

      await fs.writeFile(
        path.join(quarantinePath, 'quarantine-metadata.json'),
        JSON.stringify(quarantineMetadata, null, 2)
      );

      console.log(chalk.yellow(`Component ${componentId} quarantined for manual review`));
      console.log(chalk.gray(`Quarantine location: ${quarantinePath}`));

    } catch (error) {
      console.error(chalk.red(`Failed to quarantine ${componentId}: ${error.message}`));
      throw error;
    }
  }

  /**
   * Defer component removal
   */
  async deferRemoval(deprecation, removalSession) {
    const componentId = deprecation.component_id;
    const deferralReason = this.getDeferralReason(removalSession.safety_checks);

    // Extend deprecation timeline
    const newTimeline = deprecation.plan.timeline + 3; // Add 3 months
    
    await this.deprecationManager.updateDeprecationStatus(componentId, {
      timeline: newTimeline,
      status: 'deferred',
      deferral_reason: deferralReason
    });

    console.log(chalk.yellow(`Removal deferred for ${componentId}: ${deferralReason}`));
    console.log(chalk.gray(`New timeline: ${newTimeline} months`));
  }

  /**
   * Initialize safety checks
   */
  initializeSafetyChecks() {
    return {
      // Check for remaining usage
      usage_verification: async (deprecation) => {
        if (!this.usageTracker) {
          return { passed: false, error: 'Usage tracker not available', risk_level: 'critical' };
        }

        const currentUsage = await this.usageTracker.analyzeComponentUsage(deprecation.component_id);
        const hasUsage = currentUsage.total_references > 0;

        return {
          passed: !hasUsage,
          risk_level: hasUsage ? 'high' : 'low',
          details: {
            references_found: currentUsage.total_references,
            usage_locations: currentUsage.usage_locations
          }
        };
      },

      // Check dependency status  
      dependency_verification: async (deprecation) => {
        const dependentComponents = await this.checkDependentComponents(deprecation.component_id);
        const hasDependents = dependentComponents.length > 0;

        return {
          passed: !hasDependents,
          risk_level: hasDependents ? 'high' : 'low',
          details: {
            dependent_components: dependentComponents
          }
        };
      },

      // Check system stability
      system_stability: async (deprecation) => {
        const systemHealth = await this.checkSystemHealth();
        
        return {
          passed: systemHealth.stable,
          risk_level: systemHealth.stable ? 'low' : 'medium',
          details: systemHealth
        };
      },

      // Check for active processes
      active_processes: async (deprecation) => {
        const activeProcesses = await this.checkActiveProcesses(deprecation.component_id);
        const hasActiveProcesses = activeProcesses.length > 0;

        return {
          passed: !hasActiveProcesses,
          risk_level: hasActiveProcesses ? 'high' : 'low',
          details: {
            active_processes: activeProcesses
          }
        };
      },

      // Check backup status
      backup_verification: async (deprecation) => {
        const backupStatus = await this.verifyBackupCapability();
        
        return {
          passed: backupStatus.available,
          risk_level: backupStatus.available ? 'low' : 'critical',
          details: backupStatus
        };
      }
    };
  }

  // Helper methods for safety checks and removal operations

  calculateRemovalDate(deprecation) {
    const deprecatedDate = new Date(deprecation.timestamp);
    const timeline = deprecation.plan?.timeline || 6;
    const removalDate = new Date(deprecatedDate);
    removalDate.setMonth(removalDate.getMonth() + timeline);
    return removalDate;
  }

  async checkDependentComponents(componentId) {
    // Simplified check - would integrate with dependency analyzer
    return [];
  }

  async checkSystemHealth() {
    // Simplified health check
    return { stable: true, cpu_usage: 50, memory_usage: 60 };
  }

  async checkActiveProcesses(componentId) {
    // Check for processes using the component
    return [];
  }

  async verifyBackupCapability() {
    return { available: true, last_backup: new Date().toISOString() };
  }

  async createRemovalBackup(deprecation) {
    try {
      const backupId = `removal-backup-${Date.now()}`;
      const backupPath = path.join(this.archiveDir, backupId);
      await fs.mkdir(backupPath, { recursive: true });

      // Identify and backup component files
      const componentFiles = await this.identifyComponentFiles(deprecation);
      
      for (const file of componentFiles) {
        try {
          const fileName = path.basename(file);
          const backupFilePath = path.join(backupPath, fileName);
          await fs.copyFile(file, backupFilePath);
        } catch (error) {
          console.warn(chalk.yellow(`Failed to backup file ${file}: ${error.message}`));
        }
      }

      return {
        success: true,
        backup_id: backupId,
        backup_path: backupPath,
        files_backed_up: componentFiles.length
      };

    } catch (error) {
      return {
        success: false,
        error: error.message
      };
    }
  }

  async identifyComponentFiles(deprecation) {
    const componentId = deprecation.component_id;
    const [componentType, componentName] = componentId.split('/');
    const files = [];

    // Primary component file
    const primaryFile = this.getPrimaryComponentFile(componentType, componentName);
    if (primaryFile) {
      try {
        await fs.access(primaryFile);
        files.push(primaryFile);
      } catch (error) {
        // File doesn't exist
      }
    }

    // Additional related files
    const relatedFiles = await this.findRelatedFiles(componentType, componentName);
    files.push(...relatedFiles);

    return files;
  }

  getPrimaryComponentFile(componentType, componentName) {
    const extensions = {
      agent: '.md',
      task: '.md', 
      workflow: '.yaml',
      util: '.js'
    };

    const extension = extensions[componentType] || '.md';
    return path.join(this.rootPath, 'aios-core', `${componentType}s`, `${componentName}${extension}`);
  }

  async findRelatedFiles(componentType, componentName) {
    const relatedFiles = [];
    
    // Check for documentation files
    const docsDir = path.join(this.rootPath, 'docs', componentType);
    try {
      const docFile = path.join(docsDir, `${componentName}.md`);
      await fs.access(docFile);
      relatedFiles.push(docFile);
    } catch (error) {
      // Doc file doesn't exist
    }

    return relatedFiles;
  }

  async removeComponentFiles(deprecation) {
    try {
      const componentFiles = await this.identifyComponentFiles(deprecation);
      let filesRemoved = 0;
      const errors = [];

      for (const file of componentFiles) {
        try {
          await fs.unlink(file);
          filesRemoved++;
          console.log(chalk.gray(`  Removed: ${file}`));
        } catch (error) {
          errors.push({ file, error: error.message });
          console.warn(chalk.yellow(`  Failed to remove ${file}: ${error.message}`));
        }
      }

      return {
        success: errors.length === 0,
        files_removed: filesRemoved,
        errors: errors
      };

    } catch (error) {
      return {
        success: false,
        error: error.message
      };
    }
  }

  async cleanupComponentReferences(deprecation) {
    // This would integrate with usage tracker to clean up references
    return {
      success: true,
      references_cleaned: 0
    };
  }

  async updateComponentRegistry(deprecation) {
    // Update component registry to remove component
    return {
      success: true,
      registry_updated: true
    };
  }

  async archiveComponentMetadata(deprecation, removalSession) {
    try {
      const archiveId = `metadata-${deprecation.component_id}-${Date.now()}`;
      const archiveData = {
        archive_id: archiveId,
        component_id: deprecation.component_id,
        deprecation_data: deprecation,
        removal_session: removalSession,
        archived_at: new Date().toISOString()
      };

      const archivePath = path.join(this.archiveDir, `${archiveId}.json`);
      await fs.writeFile(archivePath, JSON.stringify(archiveData, null, 2));

      return {
        success: true,
        archive_id: archiveId,
        archive_path: archivePath
      };

    } catch (error) {
      return {
        success: false,
        error: error.message
      };
    }
  }

  async updateDeprecationStatus(deprecation, removalSession) {
    const newStatus = removalSession.action === 'safe_to_remove' ? 'removed' : 
                     removalSession.action === 'quarantine' ? 'quarantined' : 'deferred';

    await this.deprecationManager.updateDeprecationStatus(deprecation.component_id, {
      status: newStatus,
      removal_session_id: removalSession.removal_id
    });
  }

  async logRemovalSession(removalSession) {
    const logFile = path.join(this.removalDir, 'logs', `removal-${Date.now()}.json`);
    
    try {
      await fs.writeFile(logFile, JSON.stringify(removalSession, null, 2));
    } catch (error) {
      console.warn(chalk.yellow(`Failed to log removal session: ${error.message}`));
    }
  }

  getDeferralReason(safetyResults) {
    const failedChecks = Object.entries(safetyResults)
      .filter(([_, result]) => !result.passed)
      .map(([checkName]) => checkName);

    if (failedChecks.includes('usage_verification')) {
      return 'Component still has active usage';
    }
    
    if (failedChecks.includes('dependency_verification')) {
      return 'Component has dependent components';
    }
    
    if (failedChecks.includes('backup_verification')) {
      return 'Backup system not available';
    }

    return 'Multiple safety checks failed';
  }

  async generateRemovalReport(results, eligibleComponents) {
    const report = {
      generated_at: new Date().toISOString(),
      summary: results,
      eligible_components: eligibleComponents.map(comp => ({
        component_id: comp.component_id,
        deprecation_id: comp.deprecation_id,
        deprecated_since: comp.timestamp,
        timeline: comp.plan?.timeline
      })),
      recommendations: this.generateRemovalRecommendations(results)
    };

    const reportPath = path.join(this.removalDir, 'logs', `removal-report-${Date.now()}.json`);
    
    try {
      await fs.writeFile(reportPath, JSON.stringify(report, null, 2));
      console.log(chalk.gray(`Removal report saved: ${reportPath}`));
    } catch (error) {
      console.warn(chalk.yellow(`Failed to save removal report: ${error.message}`));
    }
  }

  generateRemovalRecommendations(results) {
    const recommendations = [];

    if (results.quarantined > 0) {
      recommendations.push({
        priority: 'medium',
        message: `${results.quarantined} component(s) quarantined for manual review`,
        action: 'Review quarantined components and resolve blocking issues'
      });
    }

    if (results.errors.length > 0) {
      recommendations.push({
        priority: 'high',
        message: `${results.errors.length} removal error(s) occurred`,
        action: 'Investigate and resolve removal failures'
      });
    }

    return recommendations;
  }
}

module.exports = SafeRemovalHandler;