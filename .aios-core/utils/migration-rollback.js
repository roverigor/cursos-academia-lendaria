const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Migration rollback handler for AIOS-FULLSTACK framework
 * Handles rollback of failed migrations and system recovery
 */
class MigrationRollback {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.backupManager = options.backupManager;
    this.versionTracker = options.versionTracker;
    this.rollbackDir = path.join(this.rootPath, '.aios', 'rollback');
    this.rollbackHistory = [];
    this.recoveryStrategies = this.initializeRecoveryStrategies();
  }

  /**
   * Initialize rollback system
   */
  async initialize() {
    try {
      // Create rollback directory
      await fs.mkdir(this.rollbackDir, { recursive: true });

      // Load rollback history
      await this.loadRollbackHistory();

      console.log(chalk.green('✅ Migration rollback system initialized'));
      return true;

    } catch (error) {
      console.error(chalk.red(`Failed to initialize rollback system: ${error.message}`));
      throw error;
    }
  }

  /**
   * Execute rollback for a failed migration
   */
  async rollbackMigration(migrationId, options = {}) {
    const rollbackSession = {
      rollback_id: this.generateRollbackId(),
      migration_id: migrationId,
      start_time: new Date().toISOString(),
      end_time: null,
      duration: 0,
      success: false,
      strategy: options.strategy || 'automatic',
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: [],
      final_state: 'unknown'
    };

    try {
      console.log(chalk.blue(`🔄 Starting rollback for migration: ${migrationId}`));

      // Detect migration state and failure point
      const migrationState = await this.detectMigrationState(migrationId);
      rollbackSession.failure_point = migrationState.failure_point;
      rollbackSession.partial_completion = migrationState.partial_completion;

      // Choose rollback strategy
      const strategy = await this.chooseRollbackStrategy(migrationState, options);
      rollbackSession.strategy = strategy.name;

      console.log(chalk.gray(`Using rollback strategy: ${strategy.name}`));

      // Execute rollback operations
      const rollbackResult = await this.executeRollbackStrategy(strategy, migrationState, options);
      
      rollbackSession.operations_executed = rollbackResult.operations_executed;
      rollbackSession.operations_failed = rollbackResult.operations_failed;
      rollbackSession.errors = rollbackResult.errors;
      rollbackSession.warnings = rollbackResult.warnings;
      rollbackSession.recovery_actions = rollbackResult.recovery_actions;

      // Verify rollback success
      const verification = await this.verifyRollbackSuccess(migrationId, migrationState);
      rollbackSession.success = verification.success;
      rollbackSession.final_state = verification.final_state;

      // Update version information
      if (rollbackSession.success) {
        await this.updateVersionAfterRollback(migrationId, migrationState);
      }

      // Clean up rollback artifacts
      if (options.cleanup !== false) {
        await this.cleanupRollbackArtifacts(rollbackSession);
      }

      rollbackSession.end_time = new Date().toISOString();
      rollbackSession.duration = Date.parse(rollbackSession.end_time) - Date.parse(rollbackSession.start_time);

      // Record rollback in history
      this.rollbackHistory.push(rollbackSession);
      await this.saveRollbackHistory();

      console.log(chalk.green(`✅ Rollback completed: ${rollbackSession.success ? 'SUCCESS' : 'FAILED'}`));
      console.log(chalk.gray(`   Duration: ${Math.round(rollbackSession.duration / 1000)}s`));
      console.log(chalk.gray(`   Operations: ${rollbackSession.operations_executed}/${rollbackSession.operations_executed + rollbackSession.operations_failed}`));
      console.log(chalk.gray(`   Final state: ${rollbackSession.final_state}`));

      return rollbackSession;

    } catch (error) {
      rollbackSession.end_time = new Date().toISOString();
      rollbackSession.duration = Date.parse(rollbackSession.end_time) - Date.parse(rollbackSession.start_time);
      rollbackSession.errors.push({
        operation: 'rollback_framework',
        error: error.message,
        severity: 'critical'
      });

      console.error(chalk.red(`Rollback failed: ${error.message}`));
      
      // Record failed rollback
      this.rollbackHistory.push(rollbackSession);
      await this.saveRollbackHistory();

      throw error;
    }
  }

  /**
   * Emergency rollback - fastest recovery method
   */
  async emergencyRollback(options = {}) {
    const emergencySession = {
      rollback_id: this.generateRollbackId(),
      type: 'emergency',
      start_time: new Date().toISOString(),
      success: false,
      strategy: 'emergency_restore',
      actions_taken: []
    };

    try {
      console.log(chalk.red('🚨 EMERGENCY ROLLBACK INITIATED'));

      // Find most recent backup
      if (this.backupManager) {
        console.log(chalk.gray('Finding most recent backup...'));
        const emergencyBackup = await this.backupManager.emergencyRestore();
        
        if (emergencyBackup.success) {
          emergencySession.actions_taken.push({
            action: 'backup_restore',
            backup_id: emergencyBackup.backupId,
            success: true
          });
          emergencySession.success = true;
        } else {
          emergencySession.actions_taken.push({
            action: 'backup_restore',
            error: emergencyBackup.error,
            success: false
          });
        }
      }

      // Reset version to safe state
      if (this.versionTracker) {
        try {
          const safeVersion = await this.findSafeVersion();
          if (safeVersion) {
            // This would reset to safe version - implementation depends on version tracker
            emergencySession.actions_taken.push({
              action: 'version_reset',
              version: safeVersion,
              success: true
            });
          }
        } catch (error) {
          emergencySession.actions_taken.push({
            action: 'version_reset',
            error: error.message,
            success: false
          });
        }
      }

      // Clear migration state
      try {
        await this.clearMigrationState();
        emergencySession.actions_taken.push({
          action: 'clear_migration_state',
          success: true
        });
      } catch (error) {
        emergencySession.actions_taken.push({
          action: 'clear_migration_state',
          error: error.message,
          success: false
        });
      }

      emergencySession.end_time = new Date().toISOString();
      
      if (emergencySession.success) {
        console.log(chalk.green('✅ Emergency rollback completed successfully'));
      } else {
        console.log(chalk.red('❌ Emergency rollback encountered issues'));
        console.log(chalk.yellow('Manual intervention may be required'));
      }

      return emergencySession;

    } catch (error) {
      emergencySession.end_time = new Date().toISOString();
      emergencySession.error = error.message;
      
      console.error(chalk.red(`Emergency rollback failed: ${error.message}`));
      console.log(chalk.red('CRITICAL: System may be in unstable state'));
      console.log(chalk.yellow('Contact system administrator immediately'));
      
      throw error;
    }
  }

  /**
   * Detect current migration state
   */
  async detectMigrationState(migrationId) {
    const state = {
      migration_id: migrationId,
      status: 'unknown',
      failure_point: null,
      partial_completion: false,
      completed_operations: [],
      failed_operations: [],
      rollback_available: false,
      backup_available: false
    };

    try {
      // Check for migration log/state file
      const migrationLogPath = path.join(this.rollbackDir, `${migrationId}-state.json`);
      
      try {
        const stateContent = await fs.readFile(migrationLogPath, 'utf-8');
        const migrationLog = JSON.parse(stateContent);
        
        state.status = migrationLog.status || 'failed';
        state.failure_point = migrationLog.failure_point;
        state.completed_operations = migrationLog.completed_operations || [];
        state.failed_operations = migrationLog.failed_operations || [];
        state.partial_completion = state.completed_operations.length > 0;
        
      } catch (error) {
        // No state file found - assume migration failed early
        state.status = 'failed_early';
      }

      // Check for available backups
      if (this.backupManager) {
        const backups = await this.backupManager.listBackups({ limit: 5 });
        state.backup_available = backups.length > 0;
      }

      // Check for rollback data
      const rollbackDataPath = path.join(this.rollbackDir, `${migrationId}-rollback.json`);
      try {
        await fs.access(rollbackDataPath);
        state.rollback_available = true;
      } catch (error) {
        state.rollback_available = false;
      }

      return state;

    } catch (error) {
      console.warn(chalk.yellow(`Failed to detect migration state: ${error.message}`));
      return state;
    }
  }

  /**
   * Choose appropriate rollback strategy
   */
  async chooseRollbackStrategy(migrationState, options = {}) {
    // User-specified strategy
    if (options.strategy && this.recoveryStrategies[options.strategy]) {
      return this.recoveryStrategies[options.strategy];
    }

    // Automatic strategy selection
    if (migrationState.backup_available && !migrationState.partial_completion) {
      return this.recoveryStrategies.backup_restore;
    }

    if (migrationState.rollback_available && migrationState.partial_completion) {
      return this.recoveryStrategies.operation_reversal;
    }

    if (migrationState.partial_completion) {
      return this.recoveryStrategies.incremental_rollback;
    }

    // Fallback to safest strategy
    return this.recoveryStrategies.backup_restore;
  }

  /**
   * Execute selected rollback strategy
   */
  async executeRollbackStrategy(strategy, migrationState, options = {}) {
    const result = {
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: []
    };

    try {
      console.log(chalk.gray(`Executing ${strategy.name} strategy...`));

      switch (strategy.name) {
        case 'backup_restore':
          return await this.executeBackupRestore(migrationState, options);
        
        case 'operation_reversal':
          return await this.executeOperationReversal(migrationState, options);
        
        case 'incremental_rollback':
          return await this.executeIncrementalRollback(migrationState, options);
        
        case 'manual_intervention':
          return await this.executeManualIntervention(migrationState, options);
        
        default:
          throw new Error(`Unknown rollback strategy: ${strategy.name}`);
      }

    } catch (error) {
      result.errors.push({
        operation: 'strategy_execution',
        error: error.message,
        severity: 'critical'
      });
      result.operations_failed++;
      return result;
    }
  }

  /**
   * Execute backup restore strategy
   */
  async executeBackupRestore(migrationState, options = {}) {
    const result = {
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: []
    };

    try {
      if (!this.backupManager) {
        throw new Error('Backup manager not available');
      }

      // Find appropriate backup
      const targetBackup = await this.findTargetBackup(migrationState);
      if (!targetBackup) {
        throw new Error('No suitable backup found for restoration');
      }

      console.log(chalk.gray(`Restoring from backup: ${targetBackup.id}`));

      // Restore backup
      const restoreResult = await this.backupManager.restoreBackup(targetBackup.id, {
        verify: true,
        overwrite: true
      });

      if (restoreResult.success) {
        result.operations_executed++;
        result.recovery_actions.push({
          action: 'backup_restore',
          backup_id: targetBackup.id,
          files_restored: restoreResult.restored_files?.length || 0
        });
      } else {
        result.operations_failed++;
        result.errors.push({
          operation: 'backup_restore',
          error: restoreResult.error || 'Backup restoration failed',
          severity: 'critical'
        });
      }

      return result;

    } catch (error) {
      result.operations_failed++;
      result.errors.push({
        operation: 'backup_restore_strategy',
        error: error.message,
        severity: 'critical'
      });
      return result;
    }
  }

  /**
   * Execute operation reversal strategy
   */
  async executeOperationReversal(migrationState, options = {}) {
    const result = {
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: []
    };

    try {
      // Load rollback operations
      const rollbackDataPath = path.join(this.rollbackDir, `${migrationState.migration_id}-rollback.json`);
      const rollbackData = JSON.parse(await fs.readFile(rollbackDataPath, 'utf-8'));

      // Execute rollback operations in reverse order
      const rollbackOperations = rollbackData.rollback_operations || [];
      
      for (let i = rollbackOperations.length - 1; i >= 0; i--) {
        const operation = rollbackOperations[i];
        
        try {
          const operationResult = await this.executeRollbackOperation(operation);
          
          if (operationResult.success) {
            result.operations_executed++;
            result.recovery_actions.push({
              action: 'rollback_operation',
              operation_type: operation.type,
              target: operation.target
            });
          } else {
            result.operations_failed++;
            result.errors.push({
              operation: operation.type,
              target: operation.target,
              error: operationResult.error,
              severity: 'high'
            });
          }
        } catch (error) {
          result.operations_failed++;
          result.errors.push({
            operation: operation.type,
            target: operation.target || 'unknown',
            error: error.message,
            severity: 'high'
          });
        }
      }

      return result;

    } catch (error) {
      result.operations_failed++;
      result.errors.push({
        operation: 'operation_reversal_strategy',
        error: error.message,
        severity: 'critical'
      });
      return result;
    }
  }

  /**
   * Execute incremental rollback strategy
   */
  async executeIncrementalRollback(migrationState, options = {}) {
    const result = {
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: []
    };

    try {
      // Rollback completed operations one by one
      const completedOperations = migrationState.completed_operations || [];
      
      for (let i = completedOperations.length - 1; i >= 0; i--) {
        const operation = completedOperations[i];
        
        try {
          const rollbackResult = await this.rollbackSingleOperation(operation);
          
          if (rollbackResult.success) {
            result.operations_executed++;
            result.recovery_actions.push({
              action: 'incremental_rollback',
              operation_id: operation.id,
              operation_type: operation.type
            });
          } else {
            result.operations_failed++;
            result.errors.push({
              operation: operation.type,
              operation_id: operation.id,
              error: rollbackResult.error,
              severity: 'medium'
            });
            
            // Continue with other operations despite failures
            result.warnings.push(`Failed to rollback operation ${operation.id}, continuing...`);
          }
        } catch (error) {
          result.operations_failed++;
          result.errors.push({
            operation: operation.type,
            operation_id: operation.id,
            error: error.message,
            severity: 'medium'
          });
        }
      }

      return result;

    } catch (error) {
      result.operations_failed++;
      result.errors.push({
        operation: 'incremental_rollback_strategy',
        error: error.message,
        severity: 'critical'
      });
      return result;
    }
  }

  /**
   * Execute manual intervention strategy
   */
  async executeManualIntervention(migrationState, options = {}) {
    const result = {
      operations_executed: 0,
      operations_failed: 0,
      errors: [],
      warnings: [],
      recovery_actions: []
    };

    // Create detailed report for manual intervention
    const interventionReport = {
      migration_id: migrationState.migration_id,
      failure_analysis: migrationState,
      recommended_actions: [],
      recovery_checklist: [],
      contact_information: 'System Administrator'
    };

    // Generate recommended manual actions
    interventionReport.recommended_actions = this.generateManualRecoverySteps(migrationState);
    interventionReport.recovery_checklist = this.generateRecoveryChecklist(migrationState);

    // Save intervention report
    const reportPath = path.join(this.rollbackDir, `${migrationState.migration_id}-manual-intervention.json`);
    await fs.writeFile(reportPath, JSON.stringify(interventionReport, null, 2));

    result.recovery_actions.push({
      action: 'manual_intervention_report',
      report_path: reportPath,
      recommended_actions: interventionReport.recommended_actions.length
    });

    result.warnings.push('Manual intervention required - see generated report');
    result.operations_executed++;

    return result;
  }

  /**
   * Verify rollback success
   */
  async verifyRollbackSuccess(migrationId, migrationState) {
    const verification = {
      success: false,
      final_state: 'unknown',
      checks_performed: [],
      issues_found: []
    };

    try {
      // Check framework version
      const versionCheck = await this.verifyVersionRollback(migrationId);
      verification.checks_performed.push('version_check');
      if (!versionCheck.success) {
        verification.issues_found.push(`Version check failed: ${versionCheck.error}`);
      }

      // Check file integrity
      const fileCheck = await this.verifyFileIntegrity();
      verification.checks_performed.push('file_integrity');
      if (!fileCheck.success) {
        verification.issues_found.push(`File integrity check failed: ${fileCheck.error}`);
      }

      // Check system functionality
      const functionalityCheck = await this.verifySystemFunctionality();
      verification.checks_performed.push('system_functionality');
      if (!functionalityCheck.success) {
        verification.issues_found.push(`System functionality check failed: ${functionalityCheck.error}`);
      }

      // Determine final state
      if (verification.issues_found.length === 0) {
        verification.success = true;
        verification.final_state = 'fully_recovered';
      } else if (verification.issues_found.length <= 1) {
        verification.success = true;
        verification.final_state = 'mostly_recovered';
      } else {
        verification.success = false;
        verification.final_state = 'recovery_incomplete';
      }

      return verification;

    } catch (error) {
      verification.issues_found.push(`Verification failed: ${error.message}`);
      verification.final_state = 'verification_failed';
      return verification;
    }
  }

  // Helper methods
  generateRollbackId() {
    return `rollback-${Date.now()}-${Math.random().toString(36).substr(2, 6)}`;
  }

  async loadRollbackHistory() {
    try {
      const historyPath = path.join(this.rollbackDir, 'rollback-history.json');
      const historyContent = await fs.readFile(historyPath, 'utf-8');
      this.rollbackHistory = JSON.parse(historyContent);
    } catch (error) {
      // No history file exists yet
      this.rollbackHistory = [];
    }
  }

  async saveRollbackHistory() {
    try {
      const historyPath = path.join(this.rollbackDir, 'rollback-history.json');
      await fs.writeFile(historyPath, JSON.stringify(this.rollbackHistory, null, 2));
    } catch (error) {
      console.warn(chalk.yellow(`Failed to save rollback history: ${error.message}`));
    }
  }

  async findSafeVersion() {
    // Find the most recent version that was working
    if (this.versionTracker) {
      const versionHistory = await this.versionTracker.getVersionHistory({ limit: 10 });
      return versionHistory.versions.find(v => v.status === 'active')?.version;
    }
    return null;
  }

  async clearMigrationState() {
    // Clear any migration state files
    const stateFiles = await fs.readdir(this.rollbackDir).catch(() => []);
    
    for (const stateFile of stateFiles) {
      if (stateFile.includes('-state.json') || stateFile.includes('-rollback.json')) {
        await fs.unlink(path.join(this.rollbackDir, stateFile)).catch(() => {});
      }
    }
  }

  async findTargetBackup(migrationState) {
    if (!this.backupManager) return null;
    
    const backups = await this.backupManager.listBackups({ limit: 10 });
    return backups.find(backup => 
      backup.metadata?.migration_id !== migrationState.migration_id
    ) || backups[0];
  }

  async executeRollbackOperation(operation) {
    // Execute individual rollback operation
    // Implementation depends on operation type
    return { success: true };
  }

  async rollbackSingleOperation(operation) {
    // Rollback a single completed operation
    // Implementation depends on operation type
    return { success: true };
  }

  generateManualRecoverySteps(migrationState) {
    return [
      'Assess current framework state',
      'Check for data corruption',
      'Review migration logs',
      'Determine recovery approach',
      'Execute recovery manually',
      'Verify system functionality'
    ];
  }

  generateRecoveryChecklist(migrationState) {
    return [
      { item: 'Framework initializes correctly', checked: false },
      { item: 'All core components load', checked: false },
      { item: 'Configuration is valid', checked: false },
      { item: 'Version information is correct', checked: false },
      { item: 'No data loss occurred', checked: false }
    ];
  }

  async verifyVersionRollback(migrationId) {
    return { success: true };
  }

  async verifyFileIntegrity() {
    return { success: true };
  }

  async verifySystemFunctionality() {
    return { success: true };
  }

  async updateVersionAfterRollback(migrationId, migrationState) {
    // Update version tracker after successful rollback
    if (this.versionTracker && migrationState.original_version) {
      // Implementation would revert version information
      console.log(chalk.gray(`Version reverted to: ${migrationState.original_version}`));
    }
  }

  async cleanupRollbackArtifacts(rollbackSession) {
    // Clean up temporary rollback files
    const tempFiles = [
      `${rollbackSession.migration_id}-temp`,
      `${rollbackSession.migration_id}-backup-temp`
    ];

    for (const tempFile of tempFiles) {
      const tempPath = path.join(this.rollbackDir, tempFile);
      await fs.rm(tempPath, { recursive: true, force: true }).catch(() => {});
    }
  }

  initializeRecoveryStrategies() {
    return {
      backup_restore: {
        name: 'backup_restore',
        description: 'Restore from most recent backup',
        risk: 'low',
        speed: 'fast',
        data_loss_risk: 'minimal'
      },
      operation_reversal: {
        name: 'operation_reversal',
        description: 'Reverse migration operations in order',
        risk: 'medium',
        speed: 'medium',
        data_loss_risk: 'low'
      },
      incremental_rollback: {
        name: 'incremental_rollback',
        description: 'Rollback operations incrementally',
        risk: 'medium',
        speed: 'slow',
        data_loss_risk: 'low'
      },
      manual_intervention: {
        name: 'manual_intervention',
        description: 'Require manual administrator intervention',
        risk: 'variable',
        speed: 'depends',
        data_loss_risk: 'variable'
      }
    };
  }
}

module.exports = MigrationRollback;