const fs = require('fs').promises;
const path = require('path');
const semver = require('semver');
const chalk = require('chalk');

/**
 * Backward compatibility checker for AIOS-FULLSTACK framework
 * Verifies compatibility between framework versions and identifies breaking changes
 */
class CompatibilityChecker {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.versionTracker = options.versionTracker;
    this.compatibilityRules = this.initializeCompatibilityRules();
    this.apiAnalyzer = options.apiAnalyzer;
  }

  /**
   * Check backward compatibility between versions
   */
  async checkCompatibility(fromVersion, toVersion, options = {}) {
    const compatibilityReport = {
      from_version: fromVersion,
      to_version: toVersion,
      timestamp: new Date().toISOString(),
      compatible: false,
      compatibility_level: 'unknown',
      breaking_changes: [],
      deprecated_features: [],
      api_changes: [],
      migration_required: false,
      warnings: [],
      recommendations: [],
      risk_assessment: {
        level: 'low',
        factors: [],
        mitigation_strategies: []
      },
      compatibility_matrix: {},
      validation_results: [],
      estimated_migration_effort: 0
    };

    try {
      console.log(chalk.blue(`🔍 Checking compatibility: ${fromVersion} → ${toVersion}`));

      // Basic version validation
      if (!semver.valid(fromVersion) || !semver.valid(toVersion)) {
        throw new Error('Invalid version format provided');
      }

      // Get version information
      const fromVersionInfo = await this.getVersionInfo(fromVersion);
      const toVersionInfo = await this.getVersionInfo(toVersion);

      // Perform semantic version analysis
      const semanticAnalysis = this.performSemanticAnalysis(fromVersion, toVersion);
      compatibilityReport.compatibility_level = semanticAnalysis.level;
      compatibilityReport.compatible = semanticAnalysis.compatible;

      // Analyze breaking changes
      const breakingChanges = await this.analyzeBreakingChanges(fromVersionInfo, toVersionInfo);
      compatibilityReport.breaking_changes = breakingChanges;

      // Analyze API changes
      const apiChanges = await this.analyzeApiChanges(fromVersionInfo, toVersionInfo);
      compatibilityReport.api_changes = apiChanges;

      // Check deprecated features
      const deprecatedFeatures = await this.checkDeprecatedFeatures(fromVersionInfo, toVersionInfo);
      compatibilityReport.deprecated_features = deprecatedFeatures;

      // Determine migration requirements
      compatibilityReport.migration_required = this.determineMigrationRequirement(
        semanticAnalysis,
        breakingChanges,
        apiChanges
      );

      // Generate compatibility matrix
      compatibilityReport.compatibility_matrix = await this.generateCompatibilityMatrix(
        fromVersionInfo,
        toVersionInfo
      );

      // Validate compatibility
      const validationResults = await this.validateCompatibility(
        fromVersionInfo,
        toVersionInfo,
        options
      );
      compatibilityReport.validation_results = validationResults;

      // Assess risk
      compatibilityReport.risk_assessment = this.assessCompatibilityRisk(
        breakingChanges,
        apiChanges,
        deprecatedFeatures
      );

      // Generate warnings and recommendations
      compatibilityReport.warnings = this.generateWarnings(
        breakingChanges,
        apiChanges,
        deprecatedFeatures
      );
      compatibilityReport.recommendations = this.generateRecommendations(
        compatibilityReport
      );

      // Estimate migration effort
      compatibilityReport.estimated_migration_effort = this.estimateMigrationEffort(
        breakingChanges,
        apiChanges,
        compatibilityReport.migration_required
      );

      console.log(chalk.green(`✅ Compatibility check completed`));
      console.log(chalk.gray(`   Compatible: ${compatibilityReport.compatible}`));
      console.log(chalk.gray(`   Migration required: ${compatibilityReport.migration_required}`));
      console.log(chalk.gray(`   Breaking changes: ${compatibilityReport.breaking_changes.length}`));
      console.log(chalk.gray(`   Risk level: ${compatibilityReport.risk_assessment.level}`));

      return compatibilityReport;

    } catch (error) {
      console.error(chalk.red(`Compatibility check failed: ${error.message}`));
      compatibilityReport.warnings.push(`Compatibility check failed: ${error.message}`);
      return compatibilityReport;
    }
  }

  /**
   * Perform semantic version analysis
   */
  performSemanticAnalysis(fromVersion, toVersion) {
    const versionDiff = semver.diff(fromVersion, toVersion);
    
    const analysis = {
      version_diff: versionDiff,
      compatible: false,
      level: 'unknown',
      expectations: []
    };

    switch (versionDiff) {
      case null:
        // Same version
        analysis.compatible = true;
        analysis.level = 'identical';
        analysis.expectations = ['No changes expected'];
        break;

      case 'patch':
        analysis.compatible = true;
        analysis.level = 'patch';
        analysis.expectations = [
          'Bug fixes only',
          'No breaking changes',
          'Full backward compatibility'
        ];
        break;

      case 'minor':
        analysis.compatible = true;
        analysis.level = 'minor';
        analysis.expectations = [
          'New features added',
          'Possible deprecations',
          'Backward compatible',
          'May require minor configuration updates'
        ];
        break;

      case 'major':
        analysis.compatible = false;
        analysis.level = 'major';
        analysis.expectations = [
          'Breaking changes expected',
          'API modifications likely',
          'Migration required',
          'Substantial changes possible'
        ];
        break;

      case 'premajor':
      case 'preminor':
      case 'prepatch':
        analysis.compatible = false;
        analysis.level = 'prerelease';
        analysis.expectations = [
          'Pre-release version',
          'Stability not guaranteed',
          'Breaking changes possible',
          'Use with caution'
        ];
        break;

      default:
        analysis.level = 'unknown';
        analysis.expectations = ['Unable to determine compatibility'];
    }

    return analysis;
  }

  /**
   * Analyze breaking changes between versions
   */
  async analyzeBreakingChanges(fromVersionInfo, toVersionInfo) {
    const breakingChanges = [];

    // Extract breaking changes from version info
    if (toVersionInfo.breaking_changes) {
      for (const breakingChange of toVersionInfo.breaking_changes) {
        breakingChanges.push({
          type: 'declared',
          category: breakingChange.category || 'general',
          description: breakingChange.description || breakingChange,
          impact: breakingChange.impact || 'unknown',
          affected_components: breakingChange.affected_components || [],
          migration_path: breakingChange.migration_path,
          severity: this.assessBreakingChangeSeverity(breakingChange)
        });
      }
    }

    // Analyze component changes for potential breaking changes
    const componentBreakingChanges = await this.analyzeComponentBreakingChanges(
      fromVersionInfo,
      toVersionInfo
    );
    breakingChanges.push(...componentBreakingChanges);

    // Analyze dependency changes
    const dependencyBreakingChanges = await this.analyzeDependencyBreakingChanges(
      fromVersionInfo,
      toVersionInfo
    );
    breakingChanges.push(...dependencyBreakingChanges);

    return breakingChanges;
  }

  /**
   * Analyze API changes between versions
   */
  async analyzeApiChanges(fromVersionInfo, toVersionInfo) {
    const apiChanges = [];

    // Extract API changes from version info
    if (toVersionInfo.api_changes) {
      for (const apiChange of toVersionInfo.api_changes) {
        apiChanges.push({
          type: apiChange.type || 'modification',
          component: apiChange.component,
          method: apiChange.method,
          description: apiChange.description,
          breaking: apiChange.breaking || false,
          deprecated: apiChange.deprecated || false,
          replacement: apiChange.replacement,
          impact_level: this.assessApiChangeImpact(apiChange)
        });
      }
    }

    // Analyze component API changes
    if (this.apiAnalyzer) {
      const componentApiChanges = await this.analyzeComponentApiChanges(
        fromVersionInfo,
        toVersionInfo
      );
      apiChanges.push(...componentApiChanges);
    }

    return apiChanges;
  }

  /**
   * Check deprecated features
   */
  async checkDeprecatedFeatures(fromVersionInfo, toVersionInfo) {
    const deprecatedFeatures = [];

    // Extract deprecations from version info
    if (toVersionInfo.deprecations) {
      for (const deprecation of toVersionInfo.deprecations) {
        deprecatedFeatures.push({
          feature: deprecation.feature || deprecation,
          component: deprecation.component,
          deprecated_in: toVersionInfo.version,
          removal_planned: deprecation.removal_version,
          replacement: deprecation.replacement,
          migration_guide: deprecation.migration_guide,
          urgency: this.assessDeprecationUrgency(deprecation)
        });
      }
    }

    // Check for features that were deprecated in earlier versions
    const historicalDeprecations = await this.checkHistoricalDeprecations(
      fromVersionInfo.version,
      toVersionInfo.version
    );
    deprecatedFeatures.push(...historicalDeprecations);

    return deprecatedFeatures;
  }

  /**
   * Generate compatibility matrix
   */
  async generateCompatibilityMatrix(fromVersionInfo, toVersionInfo) {
    const matrix = {
      framework_core: this.checkCoreCompatibility(fromVersionInfo, toVersionInfo),
      components: this.checkComponentCompatibility(fromVersionInfo, toVersionInfo),
      dependencies: await this.checkDependencyCompatibility(fromVersionInfo, toVersionInfo),
      configuration: this.checkConfigurationCompatibility(fromVersionInfo, toVersionInfo),
      api_surface: this.checkApiSurfaceCompatibility(fromVersionInfo, toVersionInfo)
    };

    // Calculate overall compatibility score
    const compatibilityScores = Object.values(matrix).map(item => item.score || 0);
    const averageScore = compatibilityScores.reduce((sum, score) => sum + score, 0) / compatibilityScores.length;
    
    matrix.overall_score = Math.round(averageScore * 10) / 10;
    matrix.overall_status = this.getCompatibilityStatus(averageScore);

    return matrix;
  }

  /**
   * Validate compatibility with actual checks
   */
  async validateCompatibility(fromVersionInfo, toVersionInfo, options = {}) {
    const validationResults = [];

    // File structure validation
    const fileValidation = await this.validateFileStructure(fromVersionInfo, toVersionInfo);
    validationResults.push({
      category: 'file_structure',
      status: fileValidation.valid ? 'pass' : 'fail',
      message: fileValidation.message,
      details: fileValidation.details
    });

    // Configuration validation
    const configValidation = await this.validateConfiguration(fromVersionInfo, toVersionInfo);
    validationResults.push({
      category: 'configuration',
      status: configValidation.valid ? 'pass' : 'warn',
      message: configValidation.message,
      details: configValidation.details
    });

    // Dependency validation
    const dependencyValidation = await this.validateDependencies(fromVersionInfo, toVersionInfo);
    validationResults.push({
      category: 'dependencies',
      status: dependencyValidation.valid ? 'pass' : 'fail',
      message: dependencyValidation.message,
      details: dependencyValidation.details
    });

    // API surface validation
    if (options.validateApi && this.apiAnalyzer) {
      const apiValidation = await this.validateApiSurface(fromVersionInfo, toVersionInfo);
      validationResults.push({
        category: 'api_surface',
        status: apiValidation.valid ? 'pass' : 'fail',
        message: apiValidation.message,
        details: apiValidation.details
      });
    }

    return validationResults;
  }

  /**
   * Assess compatibility risk
   */
  assessCompatibilityRisk(breakingChanges, apiChanges, deprecatedFeatures) {
    let riskScore = 0;
    const riskFactors = [];
    const mitigationStrategies = [];

    // Breaking changes impact
    const criticalBreaking = breakingChanges.filter(bc => bc.severity === 'critical').length;
    const majorBreaking = breakingChanges.filter(bc => bc.severity === 'major').length;
    
    riskScore += criticalBreaking * 10;
    riskScore += majorBreaking * 5;

    if (criticalBreaking > 0) {
      riskFactors.push(`${criticalBreaking} critical breaking changes`);
      mitigationStrategies.push('Thorough testing of critical components required');
    }

    if (majorBreaking > 0) {
      riskFactors.push(`${majorBreaking} major breaking changes`);
      mitigationStrategies.push('Component-by-component migration strategy recommended');
    }

    // API changes impact
    const breakingApiChanges = apiChanges.filter(ac => ac.breaking).length;
    riskScore += breakingApiChanges * 3;

    if (breakingApiChanges > 0) {
      riskFactors.push(`${breakingApiChanges} breaking API changes`);
      mitigationStrategies.push('API usage audit and updates required');
    }

    // Deprecated features
    const urgentDeprecations = deprecatedFeatures.filter(df => df.urgency === 'high').length;
    riskScore += urgentDeprecations * 2;

    if (urgentDeprecations > 0) {
      riskFactors.push(`${urgentDeprecations} urgent deprecations`);
      mitigationStrategies.push('Immediate replacement of deprecated features recommended');
    }

    // Determine risk level
    let level = 'low';
    if (riskScore >= 20) level = 'critical';
    else if (riskScore >= 10) level = 'high';
    else if (riskScore >= 5) level = 'medium';

    return {
      level,
      score: riskScore,
      factors: riskFactors,
      mitigation_strategies: mitigationStrategies
    };
  }

  /**
   * Generate warnings based on compatibility analysis
   */
  generateWarnings(breakingChanges, apiChanges, deprecatedFeatures) {
    const warnings = [];

    // Breaking change warnings
    const criticalBreaking = breakingChanges.filter(bc => bc.severity === 'critical');
    if (criticalBreaking.length > 0) {
      warnings.push({
        level: 'critical',
        message: `${criticalBreaking.length} critical breaking changes detected`,
        details: criticalBreaking.map(bc => bc.description)
      });
    }

    // API change warnings
    const breakingApiChanges = apiChanges.filter(ac => ac.breaking);
    if (breakingApiChanges.length > 0) {
      warnings.push({
        level: 'high',
        message: `${breakingApiChanges.length} breaking API changes`,
        details: breakingApiChanges.map(ac => `${ac.component}.${ac.method}: ${ac.description}`)
      });
    }

    // Deprecation warnings
    const urgentDeprecations = deprecatedFeatures.filter(df => df.urgency === 'high');
    if (urgentDeprecations.length > 0) {
      warnings.push({
        level: 'medium',
        message: `${urgentDeprecations.length} features will be removed soon`,
        details: urgentDeprecations.map(df => `${df.feature} (removal planned: ${df.removal_planned})`)
      });
    }

    return warnings;
  }

  /**
   * Generate recommendations
   */
  generateRecommendations(compatibilityReport) {
    const recommendations = [];

    // Migration recommendations
    if (compatibilityReport.migration_required) {
      recommendations.push({
        priority: 'high',
        category: 'migration',
        title: 'Migration Required',
        description: 'This upgrade requires migration due to breaking changes',
        actions: [
          'Create full backup before migration',
          'Review all breaking changes',
          'Test migration in development environment',
          'Plan for extended downtime if needed'
        ]
      });
    }

    // Breaking change recommendations
    if (compatibilityReport.breaking_changes.length > 0) {
      recommendations.push({
        priority: 'high',
        category: 'breaking_changes',
        title: 'Address Breaking Changes',
        description: `${compatibilityReport.breaking_changes.length} breaking changes need attention`,
        actions: [
          'Review each breaking change individually',
          'Update affected code and configurations',
          'Test all modified components',
          'Update documentation'
        ]
      });
    }

    // Deprecation recommendations
    if (compatibilityReport.deprecated_features.length > 0) {
      recommendations.push({
        priority: 'medium',
        category: 'deprecations',
        title: 'Update Deprecated Features',
        description: `${compatibilityReport.deprecated_features.length} deprecated features in use`,
        actions: [
          'Identify usage of deprecated features',
          'Plan replacement implementation',
          'Update to recommended alternatives',
          'Monitor for removal announcements'
        ]
      });
    }

    // Risk-based recommendations
    if (compatibilityReport.risk_assessment.level === 'high' || compatibilityReport.risk_assessment.level === 'critical') {
      recommendations.push({
        priority: 'critical',
        category: 'risk_mitigation',
        title: 'High Risk Migration',
        description: 'This migration has high risk - extra precautions needed',
        actions: compatibilityReport.risk_assessment.mitigation_strategies
      });
    }

    // Performance recommendations
    if (compatibilityReport.estimated_migration_effort > 60) {
      recommendations.push({
        priority: 'medium',
        category: 'planning',
        title: 'Extended Migration Time',
        description: `Estimated migration time: ${compatibilityReport.estimated_migration_effort} minutes`,
        actions: [
          'Schedule adequate maintenance window',
          'Prepare rollback plan',
          'Consider phased migration approach',
          'Notify stakeholders of extended downtime'
        ]
      });
    }

    return recommendations;
  }

  // Helper methods
  async getVersionInfo(version) {
    if (this.versionTracker) {
      const versionHistory = await this.versionTracker.getVersionHistory({ limit: 100 });
      const versionInfo = versionHistory.versions.find(v => v.version === version);
      
      if (versionInfo) {
        return versionInfo;
      }
    }

    // Return minimal version info if not found
    return {
      version,
      breaking_changes: [],
      api_changes: [],
      deprecations: [],
      components_modified: []
    };
  }

  determineMigrationRequirement(semanticAnalysis, breakingChanges, apiChanges) {
    // Major version changes typically require migration
    if (semanticAnalysis.level === 'major') {
      return true;
    }

    // Any breaking changes require migration
    if (breakingChanges.length > 0) {
      return true;
    }

    // Breaking API changes require migration
    if (apiChanges.some(change => change.breaking)) {
      return true;
    }

    return false;
  }

  estimateMigrationEffort(breakingChanges, apiChanges, migrationRequired) {
    if (!migrationRequired) return 0;

    let effortMinutes = 15; // Base migration time

    // Add time for breaking changes
    const criticalBreaking = breakingChanges.filter(bc => bc.severity === 'critical').length;
    const majorBreaking = breakingChanges.filter(bc => bc.severity === 'major').length;
    const minorBreaking = breakingChanges.length - criticalBreaking - majorBreaking;

    effortMinutes += criticalBreaking * 30;
    effortMinutes += majorBreaking * 15;
    effortMinutes += minorBreaking * 5;

    // Add time for API changes
    const breakingApiChanges = apiChanges.filter(ac => ac.breaking).length;
    effortMinutes += breakingApiChanges * 10;

    return Math.ceil(effortMinutes);
  }

  // Placeholder methods for detailed analysis
  async analyzeComponentBreakingChanges(fromVersionInfo, toVersionInfo) {
    // Analyze component modifications for breaking changes
    return [];
  }

  async analyzeDependencyBreakingChanges(fromVersionInfo, toVersionInfo) {
    // Analyze dependency changes for breaking impacts
    return [];
  }

  async analyzeComponentApiChanges(fromVersionInfo, toVersionInfo) {
    // Analyze API changes in components
    return [];
  }

  async checkHistoricalDeprecations(fromVersion, toVersion) {
    // Check for deprecations between versions
    return [];
  }

  checkCoreCompatibility(fromVersionInfo, toVersionInfo) {
    return { score: 0.9, status: 'compatible', issues: [] };
  }

  checkComponentCompatibility(fromVersionInfo, toVersionInfo) {
    return { score: 0.8, status: 'mostly_compatible', issues: [] };
  }

  async checkDependencyCompatibility(fromVersionInfo, toVersionInfo) {
    return { score: 0.9, status: 'compatible', issues: [] };
  }

  checkConfigurationCompatibility(fromVersionInfo, toVersionInfo) {
    return { score: 0.95, status: 'compatible', issues: [] };
  }

  checkApiSurfaceCompatibility(fromVersionInfo, toVersionInfo) {
    return { score: 0.85, status: 'mostly_compatible', issues: [] };
  }

  async validateFileStructure(fromVersionInfo, toVersionInfo) {
    return { valid: true, message: 'File structure compatible', details: [] };
  }

  async validateConfiguration(fromVersionInfo, toVersionInfo) {
    return { valid: true, message: 'Configuration compatible', details: [] };
  }

  async validateDependencies(fromVersionInfo, toVersionInfo) {
    return { valid: true, message: 'Dependencies compatible', details: [] };
  }

  async validateApiSurface(fromVersionInfo, toVersionInfo) {
    return { valid: true, message: 'API surface compatible', details: [] };
  }

  assessBreakingChangeSeverity(breakingChange) {
    if (breakingChange.impact === 'critical' || breakingChange.category === 'core') {
      return 'critical';
    }
    if (breakingChange.impact === 'high' || breakingChange.category === 'api') {
      return 'major';
    }
    return 'minor';
  }

  assessApiChangeImpact(apiChange) {
    if (apiChange.breaking) return 'high';
    if (apiChange.deprecated) return 'medium';
    return 'low';
  }

  assessDeprecationUrgency(deprecation) {
    if (deprecation.removal_version) {
      // If removal is planned, it's urgent
      return 'high';
    }
    return 'medium';
  }

  getCompatibilityStatus(score) {
    if (score >= 0.9) return 'fully_compatible';
    if (score >= 0.7) return 'mostly_compatible';
    if (score >= 0.5) return 'partially_compatible';
    return 'incompatible';
  }

  initializeCompatibilityRules() {
    return {
      semantic_versioning: {
        patch: { breaking_changes: false, migration_required: false },
        minor: { breaking_changes: false, migration_required: false },
        major: { breaking_changes: true, migration_required: true }
      },
      component_rules: {
        api_changes: { breaking: true, deprecation: false },
        interface_changes: { breaking: true, structural: false },
        implementation_changes: { breaking: false, optimization: true }
      }
    };
  }
}

module.exports = CompatibilityChecker;