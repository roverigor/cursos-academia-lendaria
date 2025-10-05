const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');
const { diffLines, diffWords } = require('diff');

/**
 * Conflict resolution manager for concurrent modifications
 * Handles merge conflicts, locking, and conflict resolution strategies
 */
class ConflictManager {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.lockDir = path.join(this.rootPath, '.aios', 'locks');
    this.conflictDir = path.join(this.rootPath, '.aios', 'conflicts');
    this.activeLocks = new Map();
    this.conflictHistory = [];
    this.resolutionStrategies = new Map();
    this.initializeStrategies();
  }

  /**
   * Initialize conflict resolution strategies
   */
  initializeStrategies() {
    // Automatic resolution strategies
    this.resolutionStrategies.set('auto_merge', {
      name: 'Automatic Merge',
      description: 'Automatically merge non-conflicting changes',
      canAutoResolve: true,
      resolver: this.autoMergeStrategy.bind(this)
    });

    this.resolutionStrategies.set('latest_wins', {
      name: 'Latest Wins',
      description: 'Accept the most recent modification',
      canAutoResolve: true,
      resolver: this.latestWinsStrategy.bind(this)
    });

    this.resolutionStrategies.set('priority_based', {
      name: 'Priority Based',
      description: 'Higher priority modification takes precedence',
      canAutoResolve: true,
      resolver: this.priorityBasedStrategy.bind(this)
    });

    // Manual resolution strategies
    this.resolutionStrategies.set('manual_merge', {
      name: 'Manual Merge',
      description: 'Require manual conflict resolution',
      canAutoResolve: false,
      resolver: this.manualMergeStrategy.bind(this)
    });

    this.resolutionStrategies.set('collaborative', {
      name: 'Collaborative Resolution',
      description: 'Resolve through collaborative editing session',
      canAutoResolve: false,
      resolver: this.collaborativeStrategy.bind(this)
    });
  }

  /**
   * Check for conflicts between modifications
   */
  async checkForConflicts(modification1, modification2) {
    console.log(chalk.blue('🔍 Checking for conflicts...'));

    const conflicts = {
      hasConflicts: false,
      conflictType: null,
      conflictDetails: [],
      canAutoResolve: false,
      suggestedStrategy: null
    };

    // Check if modifications affect the same component
    if (modification1.componentPath !== modification2.componentPath) {
      return conflicts; // No conflict if different components
    }

    // Check for lock conflicts
    const lockConflict = await this.checkLockConflict(modification1, modification2);
    if (lockConflict) {
      conflicts.hasConflicts = true;
      conflicts.conflictType = 'lock_conflict';
      conflicts.conflictDetails.push(lockConflict);
      return conflicts;
    }

    // Check for content conflicts
    const contentConflicts = await this.checkContentConflicts(modification1, modification2);
    if (contentConflicts.length > 0) {
      conflicts.hasConflicts = true;
      conflicts.conflictType = 'content_conflict';
      conflicts.conflictDetails = contentConflicts;
      
      // Determine if auto-resolution is possible
      conflicts.canAutoResolve = this.canAutoResolveContentConflicts(contentConflicts);
      conflicts.suggestedStrategy = this.suggestResolutionStrategy(contentConflicts);
    }

    // Check for semantic conflicts
    const semanticConflicts = await this.checkSemanticConflicts(modification1, modification2);
    if (semanticConflicts.length > 0) {
      conflicts.hasConflicts = true;
      conflicts.conflictType = conflicts.conflictType ? 'mixed_conflict' : 'semantic_conflict';
      conflicts.conflictDetails.push(...semanticConflicts);
      conflicts.canAutoResolve = false; // Semantic conflicts require manual review
    }

    return conflicts;
  }

  /**
   * Acquire lock for component modification
   */
  async acquireLock(componentPath, modificationId, options = {}) {
    await fs.mkdir(this.lockDir, { recursive: true });

    const lockFile = path.join(this.lockDir, `${this.sanitizePath(componentPath)}.lock`);
    const lockData = {
      modificationId: modificationId,
      componentPath: componentPath,
      acquiredBy: options.userId || process.env.USER || 'unknown',
      acquiredAt: new Date().toISOString(),
      expiresAt: this.calculateLockExpiration(options.duration),
      lockType: options.lockType || 'exclusive',
      metadata: options.metadata || {}
    };

    try {
      // Check if lock already exists
      const existingLock = await this.checkExistingLock(lockFile);
      if (existingLock && !this.isLockExpired(existingLock)) {
        if (existingLock.lockType === 'shared' && lockData.lockType === 'shared') {
          // Multiple shared locks allowed
          return await this.addSharedLock(lockFile, lockData);
        }
        throw new Error(`Component is locked by ${existingLock.acquiredBy} until ${existingLock.expiresAt}`);
      }

      // Create new lock
      await fs.writeFile(lockFile, JSON.stringify(lockData, null, 2));
      this.activeLocks.set(componentPath, lockData);

      console.log(chalk.green(`✅ Lock acquired for: ${componentPath}`));
      return {
        success: true,
        lockId: `${modificationId}-${Date.now()}`,
        expiresAt: lockData.expiresAt
      };

    } catch (error) {
      console.error(chalk.red(`Failed to acquire lock: ${error.message}`));
      throw error;
    }
  }

  /**
   * Release lock for component
   */
  async releaseLock(componentPath, modificationId) {
    const lockFile = path.join(this.lockDir, `${this.sanitizePath(componentPath)}.lock`);

    try {
      const existingLock = await this.checkExistingLock(lockFile);
      
      if (!existingLock) {
        console.warn(chalk.yellow(`No lock found for: ${componentPath}`));
        return { success: true, message: 'No lock to release' };
      }

      if (existingLock.modificationId !== modificationId) {
        throw new Error('Cannot release lock owned by another modification');
      }

      await fs.unlink(lockFile);
      this.activeLocks.delete(componentPath);

      console.log(chalk.green(`✅ Lock released for: ${componentPath}`));
      return { success: true };

    } catch (error) {
      console.error(chalk.red(`Failed to release lock: ${error.message}`));
      throw error;
    }
  }

  /**
   * Resolve conflicts between modifications
   */
  async resolveConflicts(conflicts, modification1, modification2, options = {}) {
    console.log(chalk.blue('🔧 Resolving conflicts...'));

    const resolutionResult = {
      resolved: false,
      strategy: options.strategy || conflicts.suggestedStrategy || 'manual_merge',
      mergedContent: null,
      resolutionDetails: [],
      requiresReview: true
    };

    // Get resolution strategy
    const strategy = this.resolutionStrategies.get(resolutionResult.strategy);
    if (!strategy) {
      throw new Error(`Unknown resolution strategy: ${resolutionResult.strategy}`);
    }

    try {
      // Execute resolution strategy
      const resolution = await strategy.resolver(conflicts, modification1, modification2, options);
      
      resolutionResult.resolved = resolution.success;
      resolutionResult.mergedContent = resolution.mergedContent;
      resolutionResult.resolutionDetails = resolution.details;
      resolutionResult.requiresReview = !strategy.canAutoResolve || resolution.requiresReview;

      // Store conflict resolution history
      await this.storeResolutionHistory({
        conflictId: `conflict-${Date.now()}`,
        modifications: [modification1.id, modification2.id],
        conflicts: conflicts,
        resolution: resolutionResult,
        timestamp: new Date().toISOString()
      });

      if (resolutionResult.resolved) {
        console.log(chalk.green(`✅ Conflicts resolved using ${strategy.name}`));
      } else {
        console.log(chalk.yellow(`⚠️ Conflicts require manual resolution`));
      }

      return resolutionResult;

    } catch (error) {
      console.error(chalk.red(`Conflict resolution failed: ${error.message}`));
      throw error;
    }
  }

  /**
   * Auto-merge strategy for non-conflicting changes
   */
  async autoMergeStrategy(conflicts, mod1, mod2, options) {
    const result = {
      success: false,
      mergedContent: null,
      details: [],
      requiresReview: false
    };

    try {
      // Load original content
      const originalContent = await this.loadOriginalContent(mod1.componentPath);
      
      // Apply modifications in sequence
      let mergedContent = originalContent;
      const changes1 = this.extractChanges(originalContent, mod1.newContent);
      const changes2 = this.extractChanges(originalContent, mod2.newContent);

      // Check if changes overlap
      const hasOverlap = this.detectChangeOverlap(changes1, changes2);
      
      if (!hasOverlap) {
        // Apply both changes
        mergedContent = this.applyChanges(originalContent, [...changes1, ...changes2]);
        result.success = true;
        result.mergedContent = mergedContent;
        result.details.push('Non-overlapping changes merged successfully');
      } else {
        result.details.push('Changes overlap - manual merge required');
        result.requiresReview = true;
      }

    } catch (error) {
      result.details.push(`Auto-merge failed: ${error.message}`);
    }

    return result;
  }

  /**
   * Latest wins strategy - newer modification takes precedence
   */
  async latestWinsStrategy(conflicts, mod1, mod2, options) {
    const result = {
      success: true,
      mergedContent: null,
      details: [],
      requiresReview: true
    };

    // Compare timestamps
    const time1 = new Date(mod1.timestamp);
    const time2 = new Date(mod2.timestamp);

    if (time2 > time1) {
      result.mergedContent = mod2.newContent;
      result.details.push(`Accepted newer modification from ${mod2.author}`);
    } else {
      result.mergedContent = mod1.newContent;
      result.details.push(`Accepted newer modification from ${mod1.author}`);
    }

    return result;
  }

  /**
   * Priority-based resolution strategy
   */
  async priorityBasedStrategy(conflicts, mod1, mod2, options) {
    const result = {
      success: true,
      mergedContent: null,
      details: [],
      requiresReview: true
    };

    const priorityLevels = { 'critical': 4, 'high': 3, 'medium': 2, 'low': 1 };
    const priority1 = priorityLevels[mod1.priority] || 0;
    const priority2 = priorityLevels[mod2.priority] || 0;

    if (priority1 > priority2) {
      result.mergedContent = mod1.newContent;
      result.details.push(`Accepted higher priority modification (${mod1.priority}) from ${mod1.author}`);
    } else if (priority2 > priority1) {
      result.mergedContent = mod2.newContent;
      result.details.push(`Accepted higher priority modification (${mod2.priority}) from ${mod2.author}`);
    } else {
      // Same priority - fall back to latest wins
      return this.latestWinsStrategy(conflicts, mod1, mod2, options);
    }

    return result;
  }

  /**
   * Manual merge strategy - prepare for user intervention
   */
  async manualMergeStrategy(conflicts, mod1, mod2, options) {
    const result = {
      success: false,
      mergedContent: null,
      details: [],
      requiresReview: true
    };

    // Create conflict markers
    const conflictFile = await this.createConflictFile(mod1, mod2, conflicts);
    
    result.details.push(`Conflict file created: ${conflictFile}`);
    result.details.push('Manual resolution required');
    result.conflictFile = conflictFile;

    return result;
  }

  /**
   * Collaborative resolution strategy
   */
  async collaborativeStrategy(conflicts, mod1, mod2, options) {
    const result = {
      success: false,
      mergedContent: null,
      details: [],
      requiresReview: true
    };

    // Create collaborative session
    const sessionId = `collab-${Date.now()}`;
    const session = {
      sessionId: sessionId,
      participants: [mod1.author, mod2.author],
      componentPath: mod1.componentPath,
      conflicts: conflicts,
      status: 'pending',
      createdAt: new Date().toISOString()
    };

    // Store session info
    await this.storeCollaborativeSession(session);

    result.details.push(`Collaborative session created: ${sessionId}`);
    result.details.push(`Participants: ${session.participants.join(', ')}`);
    result.sessionId = sessionId;

    return result;
  }

  /**
   * Create conflict file with markers
   */
  async createConflictFile(mod1, mod2, conflicts) {
    await fs.mkdir(this.conflictDir, { recursive: true });

    const conflictId = `conflict-${Date.now()}`;
    const conflictFile = path.join(this.conflictDir, `${conflictId}.conflict`);

    // Load original content
    const originalContent = await this.loadOriginalContent(mod1.componentPath);

    // Create conflict content with markers
    let conflictContent = `<<<<<<< Conflict Resolution Required >>>>>>>\n`;
    conflictContent += `Component: ${mod1.componentPath}\n`;
    conflictContent += `Modification 1: ${mod1.id} by ${mod1.author}\n`;
    conflictContent += `Modification 2: ${mod2.id} by ${mod2.author}\n`;
    conflictContent += `=======\n\n`;

    // Add conflict sections
    conflicts.conflictDetails.forEach((conflict, index) => {
      conflictContent += `<<<<<<< Conflict ${index + 1}: ${conflict.type} >>>>>>>\n`;
      conflictContent += `<<<<<<< ${mod1.author}'s version >>>>>>>\n`;
      conflictContent += conflict.content1 || mod1.newContent;
      conflictContent += `\n=======\n`;
      conflictContent += `<<<<<<< ${mod2.author}'s version >>>>>>>\n`;
      conflictContent += conflict.content2 || mod2.newContent;
      conflictContent += `\n>>>>>>>\n\n`;
    });

    // Add original version for reference
    conflictContent += `<<<<<<< Original Version >>>>>>>\n`;
    conflictContent += originalContent;
    conflictContent += `\n>>>>>>>\n`;

    await fs.writeFile(conflictFile, conflictContent);
    return conflictFile;
  }

  // Helper methods

  async checkLockConflict(mod1, mod2) {
    const lockFile = path.join(this.lockDir, `${this.sanitizePath(mod1.componentPath)}.lock`);
    
    try {
      const lock = await this.checkExistingLock(lockFile);
      if (lock && !this.isLockExpired(lock)) {
        if (lock.modificationId !== mod1.id && lock.modificationId !== mod2.id) {
          return {
            type: 'lock_conflict',
            description: `Component is locked by modification ${lock.modificationId}`,
            lockedBy: lock.acquiredBy,
            expiresAt: lock.expiresAt
          };
        }
      }
    } catch (error) {
      // No lock file exists
    }

    return null;
  }

  async checkContentConflicts(mod1, mod2) {
    const conflicts = [];

    try {
      // Compare the modifications
      const diff = diffLines(mod1.newContent || '', mod2.newContent || '');
      
      let inConflict = false;
      let conflictLines = [];
      
      diff.forEach((part, index) => {
        if (part.added && diff[index + 1] && diff[index + 1].removed) {
          // Found a conflict
          conflicts.push({
            type: 'line_conflict',
            line: index,
            content1: part.value,
            content2: diff[index + 1].value
          });
        }
      });

    } catch (error) {
      console.error(chalk.red(`Failed to check content conflicts: ${error.message}`));
    }

    return conflicts;
  }

  async checkSemanticConflicts(mod1, mod2) {
    const conflicts = [];

    // Check for conflicting function/method modifications
    if (mod1.modifiedFunctions && mod2.modifiedFunctions) {
      const commonFunctions = mod1.modifiedFunctions.filter(f => 
        mod2.modifiedFunctions.includes(f)
      );
      
      if (commonFunctions.length > 0) {
        conflicts.push({
          type: 'semantic_conflict',
          subtype: 'function_modification',
          description: `Both modifications change functions: ${commonFunctions.join(', ')}`,
          affectedElements: commonFunctions
        });
      }
    }

    // Check for conflicting API changes
    if (mod1.apiChanges && mod2.apiChanges) {
      const conflictingAPIs = this.detectAPIConflicts(mod1.apiChanges, mod2.apiChanges);
      if (conflictingAPIs.length > 0) {
        conflicts.push({
          type: 'semantic_conflict',
          subtype: 'api_conflict',
          description: 'Conflicting API changes detected',
          affectedElements: conflictingAPIs
        });
      }
    }

    return conflicts;
  }

  canAutoResolveContentConflicts(conflicts) {
    // Check if all conflicts are simple and non-overlapping
    return conflicts.every(conflict => 
      conflict.type === 'line_conflict' && 
      !this.isComplexConflict(conflict)
    );
  }

  isComplexConflict(conflict) {
    // Complex conflicts involve structural changes, multiple lines, etc.
    const complexPatterns = [
      /class\s+\w+/,
      /function\s+\w+/,
      /module\.exports/,
      /export\s+(default|const|function|class)/
    ];

    return complexPatterns.some(pattern => 
      pattern.test(conflict.content1) || pattern.test(conflict.content2)
    );
  }

  suggestResolutionStrategy(conflicts) {
    // Analyze conflicts to suggest best strategy
    if (this.canAutoResolveContentConflicts(conflicts)) {
      return 'auto_merge';
    }

    if (conflicts.some(c => c.type === 'semantic_conflict')) {
      return 'collaborative';
    }

    return 'manual_merge';
  }

  async checkExistingLock(lockFile) {
    try {
      const content = await fs.readFile(lockFile, 'utf-8');
      return JSON.parse(content);
    } catch (error) {
      return null;
    }
  }

  isLockExpired(lock) {
    return new Date() > new Date(lock.expiresAt);
  }

  calculateLockExpiration(duration = 3600000) { // Default 1 hour
    const expiration = new Date();
    expiration.setTime(expiration.getTime() + duration);
    return expiration.toISOString();
  }

  sanitizePath(componentPath) {
    return componentPath.replace(/[\/\\:*?"<>|]/g, '_');
  }

  async loadOriginalContent(componentPath) {
    try {
      const fullPath = path.resolve(this.rootPath, componentPath);
      return await fs.readFile(fullPath, 'utf-8');
    } catch (error) {
      console.error(chalk.red(`Failed to load original content: ${error.message}`));
      return '';
    }
  }

  extractChanges(original, modified) {
    const changes = [];
    const diff = diffLines(original, modified);
    
    let lineNumber = 0;
    diff.forEach(part => {
      if (part.added) {
        changes.push({
          type: 'addition',
          line: lineNumber,
          content: part.value
        });
      } else if (part.removed) {
        changes.push({
          type: 'deletion',
          line: lineNumber,
          content: part.value
        });
      }
      if (!part.removed) {
        lineNumber += part.count || 1;
      }
    });

    return changes;
  }

  detectChangeOverlap(changes1, changes2) {
    // Check if any changes affect the same lines
    for (const change1 of changes1) {
      for (const change2 of changes2) {
        if (Math.abs(change1.line - change2.line) < 3) {
          return true; // Changes are too close
        }
      }
    }
    return false;
  }

  applyChanges(original, changes) {
    // Sort changes by line number in reverse order
    const sortedChanges = [...changes].sort((a, b) => b.line - a.line);
    
    let lines = original.split('\n');
    
    sortedChanges.forEach(change => {
      if (change.type === 'addition') {
        lines.splice(change.line, 0, ...change.content.split('\n'));
      } else if (change.type === 'deletion') {
        const deleteCount = change.content.split('\n').length;
        lines.splice(change.line, deleteCount);
      }
    });

    return lines.join('\n');
  }

  detectAPIConflicts(api1, api2) {
    const conflicts = [];
    
    // Check for conflicting endpoint modifications
    if (api1.endpoints && api2.endpoints) {
      Object.keys(api1.endpoints).forEach(endpoint => {
        if (api2.endpoints[endpoint] && 
            JSON.stringify(api1.endpoints[endpoint]) !== JSON.stringify(api2.endpoints[endpoint])) {
          conflicts.push(endpoint);
        }
      });
    }

    return conflicts;
  }

  async storeResolutionHistory(resolution) {
    this.conflictHistory.push(resolution);
    
    // Also store to file
    const historyFile = path.join(this.conflictDir, 'resolution_history.json');
    try {
      let history = [];
      try {
        const existing = await fs.readFile(historyFile, 'utf-8');
        history = JSON.parse(existing);
      } catch (error) {
        // File doesn't exist yet
      }
      
      history.push(resolution);
      await fs.writeFile(historyFile, JSON.stringify(history, null, 2));
    } catch (error) {
      console.warn(chalk.yellow(`Failed to store resolution history: ${error.message}`));
    }
  }

  async storeCollaborativeSession(session) {
    const sessionFile = path.join(this.conflictDir, 'sessions', `${session.sessionId}.json`);
    await fs.mkdir(path.dirname(sessionFile), { recursive: true });
    await fs.writeFile(sessionFile, JSON.stringify(session, null, 2));
  }

  async addSharedLock(lockFile, newLock) {
    // For shared locks, append to existing lock file
    let locks = [];
    try {
      const content = await fs.readFile(lockFile, 'utf-8');
      const existingLock = JSON.parse(content);
      if (Array.isArray(existingLock)) {
        locks = existingLock;
      } else {
        locks = [existingLock];
      }
    } catch (error) {
      // No existing lock
    }

    locks.push(newLock);
    await fs.writeFile(lockFile, JSON.stringify(locks, null, 2));
    
    return {
      success: true,
      lockId: `${newLock.modificationId}-${Date.now()}`,
      expiresAt: newLock.expiresAt,
      sharedWith: locks.length - 1
    };
  }

  /**
   * Get conflict resolution history
   */
  getConflictHistory(options = {}) {
    let history = [...this.conflictHistory];

    if (options.componentPath) {
      history = history.filter(h => 
        h.modifications.some(m => m.componentPath === options.componentPath)
      );
    }

    if (options.resolved !== undefined) {
      history = history.filter(h => h.resolution.resolved === options.resolved);
    }

    return {
      total: history.length,
      resolved: history.filter(h => h.resolution.resolved).length,
      pending: history.filter(h => !h.resolution.resolved).length,
      recent: history.slice(-10)
    };
  }

  /**
   * Clean up expired locks
   */
  async cleanupExpiredLocks() {
    const files = await fs.readdir(this.lockDir);
    let cleaned = 0;

    for (const file of files) {
      if (file.endsWith('.lock')) {
        const lockFile = path.join(this.lockDir, file);
        try {
          const lock = await this.checkExistingLock(lockFile);
          if (lock && this.isLockExpired(lock)) {
            await fs.unlink(lockFile);
            cleaned++;
          }
        } catch (error) {
          // Skip problematic files
        }
      }
    }

    if (cleaned > 0) {
      console.log(chalk.gray(`Cleaned up ${cleaned} expired locks`));
    }

    return cleaned;
  }
}

module.exports = ConflictManager;