const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Change propagation predictor for AIOS-FULLSTACK framework
 * Predicts how modifications will propagate through the component dependency chain
 */
class ChangePropagationPredictor {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.propagationCache = new Map();
    this.componentInterfaceMap = new Map();
    this.changePatterns = new Map();
    this.propagationHistory = [];
  }

  /**
   * Predict change propagation for a component modification
   */
  async predictPropagation(targetComponent, dependencyImpact, options = {}) {
    const predictionId = `prop-${Date.now()}`;
    
    try {
      console.log(chalk.blue(`🌊 Predicting change propagation for: ${targetComponent.path}`));
      
      const config = {
        depth: options.depth || 'medium',
        modificationType: options.modificationType || 'modify',
        confidenceThreshold: options.confidenceThreshold || 0.7,
        includeIndirectEffects: options.includeIndirectEffects !== false,
        ...options
      };

      // Analyze target component interface
      const componentInterface = await this.analyzeComponentInterface(targetComponent);
      
      // Predict direct propagation effects
      const directEffects = await this.predictDirectPropagationEffects(
        targetComponent, 
        dependencyImpact, 
        componentInterface, 
        config
      );
      
      // Predict indirect cascading effects
      const cascadingEffects = config.includeIndirectEffects ? 
        await this.predictCascadingEffects(directEffects, dependencyImpact, config) : [];
      
      // Analyze propagation patterns
      const propagationPatterns = await this.analyzePropagationPatterns(
        directEffects, 
        cascadingEffects, 
        config
      );
      
      // Calculate confidence scores
      const confidenceAnalysis = await this.calculatePropagationConfidence(
        directEffects, 
        cascadingEffects, 
        propagationPatterns
      );
      
      // Identify critical propagation paths
      const criticalPaths = await this.identifyCriticalPropagationPaths(
        directEffects, 
        cascadingEffects, 
        dependencyImpact
      );
      
      // Generate propagation timeline
      const propagationTimeline = await this.generatePropagationTimeline(
        directEffects, 
        cascadingEffects, 
        config
      );

      const result = {
        predictionId: predictionId,
        targetComponent: {
          path: targetComponent.path,
          type: targetComponent.type,
          interface: componentInterface
        },
        modificationType: config.modificationType,
        directEffects: directEffects,
        cascadingEffects: cascadingEffects,
        propagationPatterns: propagationPatterns,
        confidenceAnalysis: confidenceAnalysis,
        criticalPaths: criticalPaths,
        propagationTimeline: propagationTimeline,
        statistics: {
          totalEffects: directEffects.length + cascadingEffects.length,
          maxDepth: Math.max(
            ...directEffects.map(e => e.propagationDepth),
            ...cascadingEffects.map(e => e.propagationDepth),
            0
          ),
          highConfidenceEffects: [...directEffects, ...cascadingEffects]
            .filter(e => e.confidence >= config.confidenceThreshold).length,
          criticalPathsCount: criticalPaths.length
        },
        predictionTimestamp: new Date().toISOString()
      };

      // Cache prediction results
      this.propagationCache.set(predictionId, result);
      
      // Add to history for pattern learning
      this.propagationHistory.push({
        targetComponent: targetComponent.path,
        modificationType: config.modificationType,
        effectsCount: result.statistics.totalEffects,
        timestamp: new Date().toISOString()
      });
      
      console.log(chalk.green(`✅ Change propagation prediction completed`));
      console.log(chalk.gray(`   Direct effects: ${directEffects.length}`));
      console.log(chalk.gray(`   Cascading effects: ${cascadingEffects.length}`));
      console.log(chalk.gray(`   Max propagation depth: ${result.statistics.maxDepth}`));
      
      return result;
      
    } catch (error) {
      console.error(chalk.red(`Change propagation prediction failed: ${error.message}`));
      throw error;
    }
  }

  /**
   * Analyze component interface to understand change impact points
   */
  async analyzeComponentInterface(component) {
    try {
      const content = component.content || await fs.readFile(component.fullPath || component.path, 'utf-8');
      
      const interfaceAnalysis = {
        exports: this.extractExports(content),
        imports: this.extractImports(content),
        publicMethods: this.extractPublicMethods(content),
        configurations: this.extractConfigurations(content),
        contracts: this.extractContracts(content, component.type),
        changePoints: []
      };

      // Identify potential change points
      interfaceAnalysis.changePoints = this.identifyChangePoints(interfaceAnalysis, component.type);
      
      // Cache interface analysis
      this.componentInterfaceMap.set(component.path, interfaceAnalysis);
      
      return interfaceAnalysis;
      
    } catch (error) {
      console.warn(chalk.yellow(`Failed to analyze interface for ${component.path}: ${error.message}`));
      return {
        exports: [],
        imports: [],
        publicMethods: [],
        configurations: [],
        contracts: [],
        changePoints: []
      };
    }
  }

  /**
   * Extract exports from component content
   */
  extractExports(content) {
    const exports = [];
    
    // Module.exports patterns
    const moduleExports = content.match(/module\.exports\s*=\s*(\w+)/g) || [];
    moduleExports.forEach(match => {
      const exportName = match.match(/=\s*(\w+)/)[1];
      exports.push({ name: exportName, type: 'default', pattern: 'module.exports' });
    });

    // Named exports
    const namedExports = content.match(/exports\.(\w+)\s*=/g) || [];
    namedExports.forEach(match => {
      const exportName = match.match(/exports\.(\w+)/)[1];
      exports.push({ name: exportName, type: 'named', pattern: 'exports' });
    });

    // ES6 exports
    const es6Exports = content.match(/export\s+(?:default\s+)?(?:function\s+)?(\w+)/g) || [];
    es6Exports.forEach(match => {
      const exportName = match.match(/(\w+)$/)[1];
      const isDefault = match.includes('default');
      exports.push({ name: exportName, type: isDefault ? 'default' : 'named', pattern: 'es6' });
    });

    return exports;
  }

  /**
   * Extract imports from component content
   */
  extractImports(content) {
    const imports = [];
    
    // Require statements
    const requires = content.match(/const\s+(\w+)\s*=\s*require\s*\(\s*['"](.*?)['"]\s*\)/g) || [];
    requires.forEach(match => {
      const matches = match.match(/const\s+(\w+)\s*=\s*require\s*\(\s*['"](.*?)['"]\s*\)/);
      imports.push({ 
        name: matches[1], 
        source: matches[2], 
        type: 'require' 
      });
    });

    // ES6 imports
    const es6Imports = content.match(/import\s+.*?\s+from\s+['"](.*?)['"]/g) || [];
    es6Imports.forEach(match => {
      const source = match.match(/from\s+['"](.*?)['"]/)[1];
      const importMatch = match.match(/import\s+(.*?)\s+from/)[1];
      imports.push({ 
        name: importMatch.trim(), 
        source: source, 
        type: 'es6' 
      });
    });

    return imports;
  }

  /**
   * Extract public methods from component content
   */
  extractPublicMethods(content) {
    const methods = [];
    
    // Function declarations
    const functionDeclarations = content.match(/(?:async\s+)?function\s+(\w+)/g) || [];
    functionDeclarations.forEach(match => {
      const methodName = match.match(/function\s+(\w+)/)[1];
      if (!methodName.startsWith('_')) { // Exclude private methods
        methods.push({ 
          name: methodName, 
          type: 'function',
          isAsync: match.includes('async')
        });
      }
    });

    // Class methods
    const classMethods = content.match(/(?:async\s+)?(\w+)\s*\([^)]*\)\s*\{/g) || [];
    classMethods.forEach(match => {
      const methodName = match.match(/(\w+)\s*\(/)[1];
      if (!methodName.startsWith('_') && methodName !== 'constructor') {
        methods.push({ 
          name: methodName, 
          type: 'method',
          isAsync: match.includes('async')
        });
      }
    });

    return methods;
  }

  /**
   * Extract configurations from component content
   */
  extractConfigurations(content) {
    const configurations = [];
    
    // Configuration objects
    const configPatterns = [
      /config\s*[:=]\s*\{([^}]+)\}/gi,
      /options\s*[:=]\s*\{([^}]+)\}/gi,
      /settings\s*[:=]\s*\{([^}]+)\}/gi
    ];

    configPatterns.forEach(pattern => {
      const matches = content.match(pattern) || [];
      matches.forEach(match => {
        const configContent = match.match(/\{([^}]+)\}/)[1];
        const configKeys = configContent.match(/(\w+)\s*:/g) || [];
        configKeys.forEach(key => {
          const keyName = key.match(/(\w+)/)[1];
          configurations.push({ 
            name: keyName, 
            type: 'configuration' 
          });
        });
      });
    });

    return configurations;
  }

  /**
   * Extract contracts (interfaces, schemas) from component content
   */
  extractContracts(content, componentType) {
    const contracts = [];
    
    // Agent contracts
    if (componentType === 'agent') {
      const agentNameMatch = content.match(/agent_name\s*[:=]\s*['"](.*?)['"]/);
      if (agentNameMatch) {
        contracts.push({ 
          name: 'agent_name', 
          value: agentNameMatch[1], 
          type: 'identifier' 
        });
      }

      const capabilitiesMatch = content.match(/capabilities\s*[:=]\s*\[(.*?)\]/s);
      if (capabilitiesMatch) {
        contracts.push({ 
          name: 'capabilities', 
          type: 'interface' 
        });
      }
    }

    // Task contracts
    if (componentType === 'task') {
      const taskNameMatch = content.match(/task_name\s*[:=]\s*['"](.*?)['"]/);
      if (taskNameMatch) {
        contracts.push({ 
          name: 'task_name', 
          value: taskNameMatch[1], 
          type: 'identifier' 
        });
      }

      const parametersMatch = content.match(/parameters\s*[:=]\s*\{/);
      if (parametersMatch) {
        contracts.push({ 
          name: 'parameters', 
          type: 'schema' 
        });
      }
    }

    // Workflow contracts
    if (componentType === 'workflow') {
      const workflowNameMatch = content.match(/workflow_name\s*[:=]\s*['"](.*?)['"]/);
      if (workflowNameMatch) {
        contracts.push({ 
          name: 'workflow_name', 
          value: workflowNameMatch[1], 
          type: 'identifier' 
        });
      }

      const stepsMatch = content.match(/steps\s*[:=]\s*\[/);
      if (stepsMatch) {
        contracts.push({ 
          name: 'steps', 
          type: 'workflow' 
        });
      }
    }

    return contracts;
  }

  /**
   * Identify potential change points in the interface
   */
  identifyChangePoints(interfaceAnalysis, componentType) {
    const changePoints = [];
    
    // Method signature changes
    interfaceAnalysis.publicMethods.forEach(method => {
      changePoints.push({
        type: 'method_signature',
        name: method.name,
        impactLevel: 'high',
        reason: 'Method signature changes break dependent code'
      });
    });

    // Export changes
    interfaceAnalysis.exports.forEach(exportItem => {
      changePoints.push({
        type: 'export',
        name: exportItem.name,
        impactLevel: exportItem.type === 'default' ? 'critical' : 'high',
        reason: 'Export changes require updates in importing components'
      });
    });

    // Configuration changes
    interfaceAnalysis.configurations.forEach(config => {
      changePoints.push({
        type: 'configuration',
        name: config.name,
        impactLevel: 'medium',
        reason: 'Configuration changes may require dependent component updates'
      });
    });

    // Contract changes (critical for framework components)
    interfaceAnalysis.contracts.forEach(contract => {
      let impactLevel = 'high';
      if (contract.type === 'identifier') {
        impactLevel = 'critical'; // Name changes break everything
      }
      
      changePoints.push({
        type: 'contract',
        name: contract.name,
        impactLevel: impactLevel,
        reason: 'Contract changes affect component integration'
      });
    });

    return changePoints;
  }

  /**
   * Predict direct propagation effects
   */
  async predictDirectPropagationEffects(targetComponent, dependencyImpact, componentInterface, config) {
    const directEffects = [];
    
    for (const affectedComponent of dependencyImpact.affectedComponents) {
      const effect = await this.analyzePropagationEffect(
        targetComponent,
        affectedComponent,
        componentInterface,
        config,
        1 // Direct effect depth
      );
      
      if (effect) {
        directEffects.push(effect);
      }
    }
    
    return directEffects.sort((a, b) => b.impact - a.impact);
  }

  /**
   * Predict cascading effects from direct effects
   */
  async predictCascadingEffects(directEffects, dependencyImpact, config) {
    const cascadingEffects = [];
    const processedComponents = new Set();
    
    for (const directEffect of directEffects) {
      if (directEffect.impact >= 7) { // Only high-impact effects cause cascading
        const cascading = await this.predictEffectCascade(
          directEffect,
          dependencyImpact,
          config,
          processedComponents
        );
        
        cascadingEffects.push(...cascading);
      }
    }
    
    return cascadingEffects.sort((a, b) => b.impact - a.impact);
  }

  /**
   * Analyze specific propagation effect
   */
  async analyzePropagationEffect(targetComponent, affectedComponent, componentInterface, config, depth) {
    try {
      // Determine the type of change required
      const changeType = this.determineRequiredChangeType(
        targetComponent,
        affectedComponent,
        componentInterface,
        config.modificationType
      );
      
      // Calculate impact score
      const impact = this.calculatePropagationImpact(
        changeType,
        affectedComponent,
        depth
      );
      
      // Calculate confidence
      const confidence = this.calculateEffectConfidence(
        changeType,
        affectedComponent,
        componentInterface
      );
      
      // Skip low-confidence predictions
      if (confidence < config.confidenceThreshold) {
        return null;
      }

      return {
        targetComponent: targetComponent.path,
        affectedComponent: affectedComponent.path,
        affectedComponentType: affectedComponent.type,
        changeType: changeType,
        impact: impact,
        confidence: confidence,
        propagationDepth: depth,
        estimatedEffort: this.estimateChangeEffort(changeType, affectedComponent),
        requiredActions: this.identifyRequiredActions(changeType, affectedComponent),
        riskFactors: this.identifyRiskFactors(changeType, affectedComponent),
        timeline: this.estimateChangeTimeline(changeType, affectedComponent)
      };
      
    } catch (error) {
      console.warn(chalk.yellow(`Failed to analyze propagation effect for ${affectedComponent.path}: ${error.message}`));
      return null;
    }
  }

  /**
   * Determine required change type for affected component
   */
  determineRequiredChangeType(targetComponent, affectedComponent, componentInterface, modificationType) {
    // Analyze the type of dependency relationship
    const dependencyType = affectedComponent.dependencyType;
    
    switch (modificationType) {
      case 'remove':
        return {
          type: 'removal_adaptation',
          severity: 'breaking',
          description: 'Component removal requires alternative implementation'
        };
        
      case 'deprecate':
        return {
          type: 'deprecation_migration',
          severity: 'warning',
          description: 'Component deprecation requires migration to alternative'
        };
        
      case 'refactor':
        if (dependencyType === 'internal') {
          return {
            type: 'interface_update',
            severity: 'moderate',
            description: 'Interface changes require import/usage updates'
          };
        } else {
          return {
            type: 'reference_update',
            severity: 'minor',
            description: 'Reference updates may be required'
          };
        }
        
      case 'modify':
      default:
        // Analyze which part of the interface is likely to change
        const changePoints = componentInterface.changePoints || [];
        const criticalChanges = changePoints.filter(cp => cp.impactLevel === 'critical');
        
        if (criticalChanges.length > 0) {
          return {
            type: 'breaking_change_adaptation',
            severity: 'breaking',
            description: 'Critical interface changes require major updates'
          };
        } else {
          return {
            type: 'compatibility_update',
            severity: 'minor',
            description: 'Minor updates may be required for compatibility'
          };
        }
    }
  }

  /**
   * Calculate impact score for propagation effect
   */
  calculatePropagationImpact(changeType, affectedComponent, depth) {
    let baseImpact = 5;
    
    // Severity multiplier
    switch (changeType.severity) {
      case 'breaking':
        baseImpact = 9;
        break;
      case 'moderate':
        baseImpact = 6;
        break;
      case 'warning':
        baseImpact = 4;
        break;
      case 'minor':
        baseImpact = 2;
        break;
    }
    
    // Component type multiplier
    const typeMultiplier = {
      'agent': 1.3,
      'workflow': 1.2,
      'task': 1.1,
      'util': 1.0
    };
    
    baseImpact *= (typeMultiplier[affectedComponent.type] || 1.0);
    
    // Depth penalty
    baseImpact = Math.max(1, baseImpact - (depth - 1));
    
    // Original impact score influence
    if (affectedComponent.impactScore) {
      baseImpact = (baseImpact + affectedComponent.impactScore) / 2;
    }
    
    return Math.min(10, Math.round(baseImpact));
  }

  /**
   * Calculate confidence for effect prediction
   */
  calculateEffectConfidence(changeType, affectedComponent, componentInterface) {
    let confidence = 0.7; // Base confidence
    
    // Higher confidence for well-defined relationships
    if (affectedComponent.dependencyType === 'internal') {
      confidence += 0.2;
    }
    
    // Higher confidence for breaking changes
    if (changeType.severity === 'breaking') {
      confidence += 0.15;
    }
    
    // Higher confidence with detailed interface analysis
    if (componentInterface.changePoints && componentInterface.changePoints.length > 0) {
      confidence += 0.1;
    }
    
    // Lower confidence for deeper propagation
    confidence -= (affectedComponent.depth || 1) * 0.05;
    
    return Math.min(0.95, Math.max(0.1, confidence));
  }

  /**
   * Predict effect cascade from a high-impact direct effect
   */
  async predictEffectCascade(directEffect, dependencyImpact, config, processedComponents) {
    const cascadingEffects = [];
    
    if (processedComponents.has(directEffect.affectedComponent)) {
      return cascadingEffects;
    }
    
    processedComponents.add(directEffect.affectedComponent);
    
    // Find components that depend on the affected component
    const secondaryAffected = dependencyImpact.affectedComponents.filter(comp => 
      comp.depth > directEffect.propagationDepth &&
      !processedComponents.has(comp.path)
    );
    
    for (const secondaryComponent of secondaryAffected.slice(0, 10)) { // Limit cascade size
      const cascadingEffect = {
        ...directEffect,
        affectedComponent: secondaryComponent.path,
        affectedComponentType: secondaryComponent.type,
        propagationDepth: directEffect.propagationDepth + 1,
        impact: Math.max(1, directEffect.impact - 2), // Reduced impact for cascading
        confidence: directEffect.confidence * 0.8, // Reduced confidence
        cascadeSource: directEffect.affectedComponent,
        changeType: {
          ...directEffect.changeType,
          type: 'cascading_' + directEffect.changeType.type
        }
      };
      
      if (cascadingEffect.confidence >= config.confidenceThreshold) {
        cascadingEffects.push(cascadingEffect);
      }
    }
    
    return cascadingEffects;
  }

  /**
   * Analyze propagation patterns
   */
  async analyzePropagationPatterns(directEffects, cascadingEffects, config) {
    const allEffects = [...directEffects, ...cascadingEffects];
    
    const patterns = {
      depth_distribution: this.analyzeDepthDistribution(allEffects),
      component_type_impact: this.analyzeComponentTypeImpact(allEffects),
      change_type_frequency: this.analyzeChangeTypeFrequency(allEffects),
      propagation_bottlenecks: this.identifyPropagationBottlenecks(allEffects),
      common_patterns: this.identifyCommonPatterns(allEffects)
    };
    
    return patterns;
  }

  /**
   * Analyze depth distribution of effects
   */
  analyzeDepthDistribution(effects) {
    const distribution = {};
    
    effects.forEach(effect => {
      const depth = effect.propagationDepth;
      distribution[depth] = (distribution[depth] || 0) + 1;
    });
    
    return distribution;
  }

  /**
   * Analyze component type impact
   */
  analyzeComponentTypeImpact(effects) {
    const typeImpact = {};
    
    effects.forEach(effect => {
      const type = effect.affectedComponentType;
      if (!typeImpact[type]) {
        typeImpact[type] = { count: 0, totalImpact: 0 };
      }
      typeImpact[type].count++;
      typeImpact[type].totalImpact += effect.impact;
    });
    
    // Calculate average impact per type
    Object.keys(typeImpact).forEach(type => {
      typeImpact[type].averageImpact = typeImpact[type].totalImpact / typeImpact[type].count;
    });
    
    return typeImpact;
  }

  /**
   * Analyze change type frequency
   */
  analyzeChangeTypeFrequency(effects) {
    const frequency = {};
    
    effects.forEach(effect => {
      const changeType = effect.changeType.type;
      frequency[changeType] = (frequency[changeType] || 0) + 1;
    });
    
    return frequency;
  }

  /**
   * Identify propagation bottlenecks
   */
  identifyPropagationBottlenecks(effects) {
    const componentImpactCount = {};
    
    effects.forEach(effect => {
      const component = effect.affectedComponent;
      componentImpactCount[component] = (componentImpactCount[component] || 0) + 1;
    });
    
    // Identify components with high impact frequency (bottlenecks)
    const bottlenecks = Object.entries(componentImpactCount)
      .filter(([component, count]) => count > 2)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([component, count]) => ({
        component: component,
        impactCount: count,
        reason: 'High dependency convergence point'
      }));
    
    return bottlenecks;
  }

  /**
   * Identify common patterns
   */
  identifyCommonPatterns(effects) {
    const patterns = [];
    
    // Pattern: High-impact cascading
    const highImpactCascading = effects.filter(e => 
      e.changeType.type.startsWith('cascading_') && e.impact >= 7
    );
    
    if (highImpactCascading.length > 2) {
      patterns.push({
        type: 'high_impact_cascading',
        count: highImpactCascading.length,
        description: 'Multiple high-impact cascading effects detected'
      });
    }
    
    // Pattern: Breaking change spread
    const breakingChanges = effects.filter(e => e.changeType.severity === 'breaking');
    
    if (breakingChanges.length > 5) {
      patterns.push({
        type: 'breaking_change_spread',
        count: breakingChanges.length,
        description: 'Widespread breaking changes across components'
      });
    }
    
    return patterns;
  }

  /**
   * Calculate propagation confidence
   */
  async calculatePropagationConfidence(directEffects, cascadingEffects, patterns) {
    const allEffects = [...directEffects, ...cascadingEffects];
    
    if (allEffects.length === 0) {
      return {
        overall: 0.9,
        directEffects: 0.9,
        cascadingEffects: 0.0,
        factors: ['No propagation effects predicted']
      };
    }
    
    const directConfidence = directEffects.length > 0 ? 
      directEffects.reduce((sum, e) => sum + e.confidence, 0) / directEffects.length : 0.9;
    
    const cascadingConfidence = cascadingEffects.length > 0 ? 
      cascadingEffects.reduce((sum, e) => sum + e.confidence, 0) / cascadingEffects.length : 0.9;
    
    const overallConfidence = (directConfidence + cascadingConfidence * 0.7) / 
      (1 + (cascadingEffects.length > 0 ? 0.7 : 0));
    
    const factors = [];
    if (directEffects.length > 10) factors.push('High number of direct effects');
    if (cascadingEffects.length > 5) factors.push('Significant cascading effects');
    if (patterns.common_patterns.length > 0) factors.push('Common propagation patterns identified');
    
    return {
      overall: Math.round(overallConfidence * 100) / 100,
      directEffects: Math.round(directConfidence * 100) / 100,
      cascadingEffects: Math.round(cascadingConfidence * 100) / 100,
      factors: factors
    };
  }

  /**
   * Identify critical propagation paths
   */
  async identifyCriticalPropagationPaths(directEffects, cascadingEffects, dependencyImpact) {
    const allEffects = [...directEffects, ...cascadingEffects];
    const criticalPaths = [];
    
    // Group effects by propagation chains
    const propagationChains = this.groupEffectsByChain(allEffects);
    
    for (const chain of propagationChains) {
      const totalImpact = chain.reduce((sum, effect) => sum + effect.impact, 0);
      const maxDepth = Math.max(...chain.map(effect => effect.propagationDepth));
      const avgConfidence = chain.reduce((sum, effect) => sum + effect.confidence, 0) / chain.length;
      
      if (totalImpact >= 20 || maxDepth >= 4 || chain.length >= 5) {
        criticalPaths.push({
          pathId: `path-${Date.now()}-${Math.random().toString(36).substr(2, 4)}`,
          effects: chain,
          totalImpact: totalImpact,
          maxDepth: maxDepth,
          avgConfidence: avgConfidence,
          criticalityReason: this.determineCriticalityReason(totalImpact, maxDepth, chain.length),
          mitigationPriority: totalImpact >= 30 ? 'critical' : totalImpact >= 20 ? 'high' : 'medium'
        });
      }
    }
    
    return criticalPaths.sort((a, b) => b.totalImpact - a.totalImpact);
  }

  /**
   * Group effects by propagation chain
   */
  groupEffectsByChain(effects) {
    const chains = [];
    const processed = new Set();
    
    for (const effect of effects) {
      if (processed.has(effect.affectedComponent)) continue;
      
      const chain = [effect];
      processed.add(effect.affectedComponent);
      
      // Find connected effects
      const relatedEffects = effects.filter(e => 
        !processed.has(e.affectedComponent) &&
        (e.cascadeSource === effect.affectedComponent || 
         e.targetComponent === effect.affectedComponent)
      );
      
      chain.push(...relatedEffects);
      relatedEffects.forEach(e => processed.add(e.affectedComponent));
      
      if (chain.length > 1) {
        chains.push(chain);
      }
    }
    
    return chains;
  }

  /**
   * Determine criticality reason
   */
  determineCriticalityReason(totalImpact, maxDepth, chainLength) {
    if (totalImpact >= 30) {
      return 'Extremely high cumulative impact';
    } else if (maxDepth >= 4) {
      return 'Deep propagation chain with potential for widespread effects';
    } else if (chainLength >= 5) {
      return 'Large number of components affected in propagation chain';
    } else {
      return 'Significant propagation impact requiring attention';
    }
  }

  /**
   * Generate propagation timeline
   */
  async generatePropagationTimeline(directEffects, cascadingEffects, config) {
    const timeline = {
      phases: [],
      totalDuration: 0,
      criticalPath: null
    };
    
    // Phase 1: Direct effects (immediate)
    if (directEffects.length > 0) {
      const directPhase = {
        phase: 1,
        name: 'Direct Impact',
        description: 'Immediate effects on dependent components',
        effects: directEffects,
        estimatedDuration: Math.max(...directEffects.map(e => e.timeline?.duration || 1)),
        parallelizable: true
      };
      timeline.phases.push(directPhase);
    }
    
    // Phase 2: Cascading effects (delayed)
    if (cascadingEffects.length > 0) {
      const cascadingPhase = {
        phase: 2,
        name: 'Cascading Impact',
        description: 'Secondary effects propagating through dependency chains',
        effects: cascadingEffects,
        estimatedDuration: Math.max(...cascadingEffects.map(e => e.timeline?.duration || 2)),
        parallelizable: false
      };
      timeline.phases.push(cascadingPhase);
    }
    
    // Calculate total duration
    timeline.totalDuration = timeline.phases.reduce((sum, phase) => 
      sum + (phase.parallelizable ? Math.max(...phase.effects.map(e => e.timeline?.duration || 1)) : 
             phase.effects.reduce((phaseSum, e) => phaseSum + (e.timeline?.duration || 1), 0)), 0);
    
    // Identify critical path
    timeline.criticalPath = this.identifyCriticalTimepath(directEffects, cascadingEffects);
    
    return timeline;
  }

  /**
   * Identify critical time path
   */
  identifyCriticalTimepath(directEffects, cascadingEffects) {
    const allEffects = [...directEffects, ...cascadingEffects];
    
    if (allEffects.length === 0) return null;
    
    // Find the longest sequential chain
    const longestChain = allEffects
      .sort((a, b) => (b.timeline?.duration || 1) - (a.timeline?.duration || 1))
      .slice(0, 5);
    
    return {
      effects: longestChain,
      totalDuration: longestChain.reduce((sum, e) => sum + (e.timeline?.duration || 1), 0),
      description: 'Longest sequential propagation chain'
    };
  }

  // Helper methods for effect analysis

  estimateChangeEffort(changeType, affectedComponent) {
    const baseEffort = {
      'removal_adaptation': 8,
      'breaking_change_adaptation': 6,
      'interface_update': 4,
      'deprecation_migration': 3,
      'compatibility_update': 2,
      'reference_update': 1
    };
    
    return baseEffort[changeType.type] || 3;
  }

  identifyRequiredActions(changeType, affectedComponent) {
    const actionMap = {
      'removal_adaptation': [
        'Find alternative implementation',
        'Update imports and dependencies',
        'Test functionality with new implementation'
      ],
      'breaking_change_adaptation': [
        'Update method calls and interfaces',
        'Modify component configuration',
        'Run comprehensive testing'
      ],
      'interface_update': [
        'Update import statements',
        'Modify method invocations',
        'Update type definitions'
      ],
      'deprecation_migration': [
        'Plan migration timeline',
        'Update to recommended alternative',
        'Remove deprecated usage'
      ],
      'compatibility_update': [
        'Review component compatibility',
        'Update if necessary',
        'Verify continued functionality'
      ],
      'reference_update': [
        'Update references and documentation',
        'Verify continued validity'
      ]
    };
    
    return actionMap[changeType.type] || ['Review and update as needed'];
  }

  identifyRiskFactors(changeType, affectedComponent) {
    const riskFactors = [];
    
    if (changeType.severity === 'breaking') {
      riskFactors.push({
        type: 'breaking_change',
        severity: 'high',
        description: 'Breaking changes may cause functionality failure'
      });
    }
    
    if (affectedComponent.type === 'agent' || affectedComponent.type === 'workflow') {
      riskFactors.push({
        type: 'critical_component',
        severity: 'medium',
        description: 'Changes to critical components affect system behavior'
      });
    }
    
    if (affectedComponent.dependencyType === 'internal') {
      riskFactors.push({
        type: 'tight_coupling',
        severity: 'medium',
        description: 'Tight coupling increases risk of propagation issues'
      });
    }
    
    return riskFactors;
  }

  estimateChangeTimeline(changeType, affectedComponent) {
    const baseDuration = {
      'removal_adaptation': 5,
      'breaking_change_adaptation': 3,
      'interface_update': 2,
      'deprecation_migration': 2,
      'compatibility_update': 1,
      'reference_update': 0.5
    };
    
    const duration = baseDuration[changeType.type] || 1;
    
    return {
      duration: duration,
      unit: 'hours',
      description: `Estimated time to implement ${changeType.type}`
    };
  }

  /**
   * Get cached prediction
   */
  getCachedPrediction(predictionId) {
    return this.propagationCache.get(predictionId);
  }

  /**
   * Clear prediction cache
   */
  clearCache() {
    this.propagationCache.clear();
    console.log(chalk.gray('Change propagation cache cleared'));
  }

  /**
   * Get prediction statistics
   */
  getPredictionStats() {
    return {
      cachedPredictions: this.propagationCache.size,
      totalPredictions: this.propagationHistory.length,
      averageEffects: this.propagationHistory.length > 0 ? 
        this.propagationHistory.reduce((sum, p) => sum + p.effectsCount, 0) / this.propagationHistory.length : 0,
      recentPredictions: this.propagationHistory.slice(-10)
    };
  }
}

module.exports = ChangePropagationPredictor;