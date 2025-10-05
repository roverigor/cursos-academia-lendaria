const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');
const EventEmitter = require('events');

/**
 * Modification synchronization system for collaborative modification
 * Handles real-time synchronization of modifications across multiple agents
 */
class ModificationSynchronizer extends EventEmitter {
  constructor(options = {}) {
    super();
    this.rootPath = options.rootPath || process.cwd();
    this.syncDir = path.join(this.rootPath, '.aios', 'sync');
    this.stateFile = path.join(this.syncDir, 'sync_state.json');
    this.syncInterval = options.syncInterval || 5000; // 5 seconds
    this.activeSessions = new Map();
    this.pendingSync = new Map();
    this.syncHistory = [];
    this.isRunning = false;
    this.syncTimer = null;
    this.conflictManager = null;
  }

  /**
   * Initialize synchronizer
   */
  async initialize() {
    await fs.mkdir(this.syncDir, { recursive: true });
    
    // Load existing sync state
    await this.loadSyncState();
    
    // Initialize conflict manager
    const ConflictManager = require('./conflict-manager');
    this.conflictManager = new ConflictManager({ rootPath: this.rootPath });

    console.log(chalk.green('✅ Modification synchronizer initialized'));
  }

  /**
   * Start synchronization service
   */
  async startSync() {
    if (this.isRunning) {
      console.log(chalk.yellow('Synchronizer already running'));
      return;
    }

    this.isRunning = true;
    console.log(chalk.blue('🔄 Starting modification synchronizer...'));

    // Start sync loop
    this.syncTimer = setInterval(() => {
      this.performSync().catch(error => {
        console.error(chalk.red(`Sync error: ${error.message}`));
      });
    }, this.syncInterval);

    // Initial sync
    await this.performSync();

    this.emit('sync_started');
  }

  /**
   * Stop synchronization service
   */
  async stopSync() {
    if (!this.isRunning) {
      return;
    }

    this.isRunning = false;
    if (this.syncTimer) {
      clearInterval(this.syncTimer);
      this.syncTimer = null;
    }

    // Save final state
    await this.saveSyncState();

    console.log(chalk.blue('⏹ Modification synchronizer stopped'));
    this.emit('sync_stopped');
  }

  /**
   * Register modification for synchronization
   */
  async registerModification(modification) {
    const syncEntry = {
      id: modification.id || `mod-${Date.now()}`,
      componentPath: modification.componentPath,
      type: modification.type,
      author: modification.author || process.env.USER || 'unknown',
      timestamp: new Date().toISOString(),
      status: 'pending',
      content: modification.content,
      metadata: modification.metadata || {},
      syncVersion: 0
    };

    // Add to pending sync
    this.pendingSync.set(syncEntry.id, syncEntry);

    // Emit event for real-time updates
    this.emit('modification_registered', syncEntry);

    console.log(chalk.green(`✅ Modification registered: ${syncEntry.id}`));
    
    // Trigger immediate sync if high priority
    if (modification.priority === 'critical' || modification.priority === 'high') {
      await this.performSync();
    }

    return syncEntry;
  }

  /**
   * Perform synchronization cycle
   */
  async performSync() {
    if (this.pendingSync.size === 0) {
      return; // Nothing to sync
    }

    console.log(chalk.gray(`Syncing ${this.pendingSync.size} modifications...`));

    const syncBatch = {
      batchId: `sync-${Date.now()}`,
      timestamp: new Date().toISOString(),
      modifications: [],
      conflicts: [],
      results: []
    };

    // Process each pending modification
    for (const [id, modification] of this.pendingSync) {
      try {
        const result = await this.syncModification(modification, syncBatch);
        syncBatch.results.push(result);

        if (result.success) {
          this.pendingSync.delete(id);
        }
      } catch (error) {
        console.error(chalk.red(`Failed to sync ${id}: ${error.message}`));
        syncBatch.results.push({
          modificationId: id,
          success: false,
          error: error.message
        });
      }
    }

    // Store sync history
    this.syncHistory.push(syncBatch);
    
    // Emit sync complete event
    this.emit('sync_complete', syncBatch);

    // Save state
    await this.saveSyncState();

    console.log(chalk.green(`✅ Sync complete: ${syncBatch.results.filter(r => r.success).length}/${syncBatch.results.length} successful`));
  }

  /**
   * Synchronize individual modification
   */
  async syncModification(modification, batch) {
    const result = {
      modificationId: modification.id,
      success: false,
      conflicts: [],
      merged: false
    };

    try {
      // Check for conflicts with other modifications
      const conflicts = await this.checkForConflicts(modification);
      
      if (conflicts.length > 0) {
        result.conflicts = conflicts;
        batch.conflicts.push(...conflicts);

        // Attempt conflict resolution
        for (const conflict of conflicts) {
          const resolution = await this.resolveConflict(modification, conflict);
          if (resolution.resolved) {
            modification = resolution.mergedModification;
            result.merged = true;
          } else {
            throw new Error(`Unresolved conflict with ${conflict.modificationId}`);
          }
        }
      }

      // Apply modification
      await this.applyModification(modification);
      
      // Update sync version
      modification.syncVersion++;
      modification.status = 'synced';
      modification.syncTimestamp = new Date().toISOString();

      // Broadcast to other agents
      await this.broadcastModification(modification);

      result.success = true;
      batch.modifications.push(modification);

    } catch (error) {
      result.error = error.message;
      modification.status = 'failed';
      modification.lastError = error.message;
    }

    return result;
  }

  /**
   * Check for conflicts with other modifications
   */
  async checkForConflicts(modification) {
    const conflicts = [];

    // Load all active modifications for the same component
    const activeModifications = await this.getActiveModifications(modification.componentPath);

    for (const activeMod of activeModifications) {
      if (activeMod.id !== modification.id) {
        // Check if modifications overlap
        const conflict = await this.detectConflict(modification, activeMod);
        if (conflict) {
          conflicts.push({
            modificationId: activeMod.id,
            type: conflict.type,
            severity: conflict.severity,
            details: conflict.details
          });
        }
      }
    }

    return conflicts;
  }

  /**
   * Detect conflict between two modifications
   */
  async detectConflict(mod1, mod2) {
    // Time-based conflict detection
    const timeDiff = Math.abs(new Date(mod1.timestamp) - new Date(mod2.timestamp));
    const timeThreshold = 60000; // 1 minute

    if (timeDiff < timeThreshold) {
      // Modifications are too close in time
      if (mod1.type === mod2.type && mod1.type !== 'comment') {
        return {
          type: 'concurrent_modification',
          severity: 'high',
          details: 'Modifications made within conflict window'
        };
      }
    }

    // Content-based conflict detection
    if (mod1.content && mod2.content) {
      const hasContentOverlap = await this.detectContentOverlap(mod1.content, mod2.content);
      if (hasContentOverlap) {
        return {
          type: 'content_overlap',
          severity: 'medium',
          details: 'Modifications affect overlapping content areas'
        };
      }
    }

    // Semantic conflict detection
    if (mod1.metadata.modifiedElements && mod2.metadata.modifiedElements) {
      const commonElements = mod1.metadata.modifiedElements.filter(e => 
        mod2.metadata.modifiedElements.includes(e)
      );
      
      if (commonElements.length > 0) {
        return {
          type: 'semantic_conflict',
          severity: 'high',
          details: `Both modify: ${commonElements.join(', ')}`
        };
      }
    }

    return null;
  }

  /**
   * Resolve conflict between modifications
   */
  async resolveConflict(modification, conflict) {
    const resolution = {
      resolved: false,
      mergedModification: null,
      strategy: null
    };

    try {
      // Load conflicting modification
      const conflictingMod = await this.loadModification(conflict.modificationId);

      // Use conflict manager for resolution
      const conflictData = {
        hasConflicts: true,
        conflictType: conflict.type,
        conflictDetails: [conflict]
      };

      const resolutionResult = await this.conflictManager.resolveConflicts(
        conflictData,
        modification,
        conflictingMod,
        { strategy: 'auto_merge' }
      );

      if (resolutionResult.resolved) {
        resolution.resolved = true;
        resolution.mergedModification = {
          ...modification,
          content: resolutionResult.mergedContent,
          metadata: {
            ...modification.metadata,
            merged: true,
            mergedWith: conflict.modificationId,
            mergeStrategy: resolutionResult.strategy
          }
        };
        resolution.strategy = resolutionResult.strategy;
      }

    } catch (error) {
      console.error(chalk.red(`Conflict resolution failed: ${error.message}`));
    }

    return resolution;
  }

  /**
   * Apply modification to component
   */
  async applyModification(modification) {
    const componentPath = path.resolve(this.rootPath, modification.componentPath);
    
    // Create backup
    const backupPath = await this.createBackup(componentPath);
    
    try {
      // Apply the modification
      if (modification.content) {
        await fs.writeFile(componentPath, modification.content);
      }

      // Update modification metadata
      const metadataFile = path.join(this.syncDir, 'applied', `${modification.id}.json`);
      await fs.mkdir(path.dirname(metadataFile), { recursive: true });
      await fs.writeFile(metadataFile, JSON.stringify({
        ...modification,
        appliedAt: new Date().toISOString(),
        backupPath: backupPath
      }, null, 2));

    } catch (error) {
      // Restore from backup on failure
      await this.restoreBackup(componentPath, backupPath);
      throw error;
    }
  }

  /**
   * Broadcast modification to other agents
   */
  async broadcastModification(modification) {
    // Write to shared modification feed
    const feedFile = path.join(this.syncDir, 'feed', 'modifications.jsonl');
    await fs.mkdir(path.dirname(feedFile), { recursive: true });
    
    const feedEntry = {
      timestamp: new Date().toISOString(),
      modification: modification,
      broadcaster: process.env.USER || 'system'
    };
    
    await fs.appendFile(feedFile, JSON.stringify(feedEntry) + '\n');

    // Emit event for real-time subscribers
    this.emit('modification_broadcast', modification);
  }

  /**
   * Subscribe to modification updates
   */
  async subscribeToModifications(callback) {
    // Watch modification feed
    const feedFile = path.join(this.syncDir, 'feed', 'modifications.jsonl');
    
    // Initial read of existing modifications
    try {
      const content = await fs.readFile(feedFile, 'utf-8');
      const lines = content.trim().split('\n').filter(line => line);
      
      for (const line of lines) {
        try {
          const entry = JSON.parse(line);
          callback(entry.modification);
        } catch (error) {
          // Skip invalid lines
        }
      }
    } catch (error) {
      // Feed file doesn't exist yet
    }

    // Subscribe to new modifications
    this.on('modification_broadcast', callback);

    return () => {
      this.removeListener('modification_broadcast', callback);
    };
  }

  /**
   * Get active modifications for a component
   */
  async getActiveModifications(componentPath) {
    const modifications = [];
    
    // Check pending modifications
    for (const [id, mod] of this.pendingSync) {
      if (mod.componentPath === componentPath) {
        modifications.push(mod);
      }
    }

    // Check recently applied modifications
    const appliedDir = path.join(this.syncDir, 'applied');
    try {
      const files = await fs.readdir(appliedDir);
      
      for (const file of files) {
        if (file.endsWith('.json')) {
          const content = await fs.readFile(path.join(appliedDir, file), 'utf-8');
          const mod = JSON.parse(content);
          
          if (mod.componentPath === componentPath) {
            // Only include recent modifications (last 5 minutes)
            const age = Date.now() - new Date(mod.appliedAt).getTime();
            if (age < 300000) {
              modifications.push(mod);
            }
          }
        }
      }
    } catch (error) {
      // Applied directory doesn't exist yet
    }

    return modifications;
  }

  /**
   * Load modification by ID
   */
  async loadModification(modificationId) {
    // Check pending sync
    if (this.pendingSync.has(modificationId)) {
      return this.pendingSync.get(modificationId);
    }

    // Check applied modifications
    const appliedFile = path.join(this.syncDir, 'applied', `${modificationId}.json`);
    try {
      const content = await fs.readFile(appliedFile, 'utf-8');
      return JSON.parse(content);
    } catch (error) {
      throw new Error(`Modification not found: ${modificationId}`);
    }
  }

  /**
   * Detect content overlap between modifications
   */
  async detectContentOverlap(content1, content2) {
    // Simple line-based overlap detection
    const lines1 = content1.split('\n');
    const lines2 = content2.split('\n');
    
    // Check if modifications affect similar line ranges
    // This is a simplified implementation
    const commonLines = lines1.filter(line => lines2.includes(line));
    
    return commonLines.length > lines1.length * 0.3; // 30% overlap threshold
  }

  /**
   * Create backup of component
   */
  async createBackup(componentPath) {
    const backupDir = path.join(this.syncDir, 'backups');
    await fs.mkdir(backupDir, { recursive: true });
    
    const timestamp = new Date().toISOString().replace(/[:]/g, '-');
    const backupName = `${path.basename(componentPath)}.${timestamp}.backup`;
    const backupPath = path.join(backupDir, backupName);
    
    try {
      const content = await fs.readFile(componentPath, 'utf-8');
      await fs.writeFile(backupPath, content);
      return backupPath;
    } catch (error) {
      console.warn(chalk.yellow(`Failed to create backup: ${error.message}`));
      return null;
    }
  }

  /**
   * Restore from backup
   */
  async restoreBackup(componentPath, backupPath) {
    if (!backupPath) return;
    
    try {
      const content = await fs.readFile(backupPath, 'utf-8');
      await fs.writeFile(componentPath, content);
      console.log(chalk.green(`✅ Restored from backup: ${componentPath}`));
    } catch (error) {
      console.error(chalk.red(`Failed to restore backup: ${error.message}`));
    }
  }

  /**
   * Load sync state
   */
  async loadSyncState() {
    try {
      const content = await fs.readFile(this.stateFile, 'utf-8');
      const state = JSON.parse(content);
      
      // Restore pending modifications
      if (state.pendingSync) {
        this.pendingSync = new Map(state.pendingSync);
      }
      
      // Restore sync history (last 100 entries)
      if (state.syncHistory) {
        this.syncHistory = state.syncHistory.slice(-100);
      }
      
      console.log(chalk.gray(`Loaded sync state: ${this.pendingSync.size} pending modifications`));
      
    } catch (error) {
      // No existing state
    }
  }

  /**
   * Save sync state
   */
  async saveSyncState() {
    const state = {
      version: 1,
      timestamp: new Date().toISOString(),
      pendingSync: Array.from(this.pendingSync.entries()),
      syncHistory: this.syncHistory.slice(-100), // Keep last 100 sync batches
      statistics: this.getSyncStatistics()
    };
    
    await fs.writeFile(this.stateFile, JSON.stringify(state, null, 2));
  }

  /**
   * Get synchronization statistics
   */
  getSyncStatistics() {
    const stats = {
      totalSynced: 0,
      totalConflicts: 0,
      totalResolved: 0,
      pendingCount: this.pendingSync.size,
      activeSessions: this.activeSessions.size
    };
    
    this.syncHistory.forEach(batch => {
      stats.totalSynced += batch.results.filter(r => r.success).length;
      stats.totalConflicts += batch.conflicts.length;
      stats.totalResolved += batch.results.filter(r => r.merged).length;
    });
    
    return stats;
  }

  /**
   * Get sync status
   */
  getSyncStatus() {
    return {
      running: this.isRunning,
      pendingModifications: this.pendingSync.size,
      activeSessions: this.activeSessions.size,
      lastSync: this.syncHistory.length > 0 ? 
        this.syncHistory[this.syncHistory.length - 1].timestamp : null,
      statistics: this.getSyncStatistics()
    };
  }

  /**
   * Clear sync history
   */
  async clearSyncHistory() {
    this.syncHistory = [];
    await this.saveSyncState();
    console.log(chalk.green('✅ Sync history cleared'));
  }

  /**
   * Create collaborative session
   */
  async createCollaborativeSession(componentPath, participants) {
    const sessionId = `session-${Date.now()}`;
    const session = {
      id: sessionId,
      componentPath: componentPath,
      participants: participants,
      status: 'active',
      createdAt: new Date().toISOString(),
      modifications: []
    };
    
    this.activeSessions.set(sessionId, session);
    
    // Notify participants
    this.emit('session_created', session);
    
    console.log(chalk.green(`✅ Collaborative session created: ${sessionId}`));
    return session;
  }

  /**
   * Join collaborative session
   */
  async joinSession(sessionId, participant) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Error(`Session not found: ${sessionId}`);
    }
    
    if (!session.participants.includes(participant)) {
      session.participants.push(participant);
    }
    
    this.emit('participant_joined', { sessionId, participant });
    
    console.log(chalk.green(`✅ ${participant} joined session: ${sessionId}`));
    return session;
  }

  /**
   * End collaborative session
   */
  async endSession(sessionId) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Error(`Session not found: ${sessionId}`);
    }
    
    session.status = 'ended';
    session.endedAt = new Date().toISOString();
    
    // Save session history
    const sessionFile = path.join(this.syncDir, 'sessions', `${sessionId}.json`);
    await fs.mkdir(path.dirname(sessionFile), { recursive: true });
    await fs.writeFile(sessionFile, JSON.stringify(session, null, 2));
    
    this.activeSessions.delete(sessionId);
    this.emit('session_ended', session);
    
    console.log(chalk.green(`✅ Collaborative session ended: ${sessionId}`));
  }
}

module.exports = ModificationSynchronizer;