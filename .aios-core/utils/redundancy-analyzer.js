const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Redundancy and overlap analyzer for AIOS-FULLSTACK framework
 * Identifies duplicated functionality, redundant components, and optimization opportunities
 */
class RedundancyAnalyzer {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.similarityThreshold = options.similarityThreshold || 0.7; // 70% similarity
    this.minFunctionLength = options.minFunctionLength || 5; // lines
    this.analysisCache = new Map();
  }

  /**
   * Analyze redundancy across all framework components
   */
  async analyzeRedundancy(components) {
    const analysis = {
      timestamp: new Date().toISOString(),
      redundancy_score: 0,
      duplicate_functions: [],
      similar_components: [],
      unused_dependencies: [],
      redundant_patterns: [],
      consolidation_opportunities: [],
      overlap_analysis: {},
      metrics: {
        total_components_analyzed: 0,
        duplicate_code_percentage: 0,
        potential_savings: 0,
        redundancy_hotspots: 0
      },
      recommendations: []
    };

    try {
      console.log(chalk.blue('🔍 Analyzing code redundancy and overlaps...'));

      // Filter to analyzable components
      const analyzableComponents = components.filter(comp => this.shouldAnalyzeComponent(comp));
      analysis.metrics.total_components_analyzed = analyzableComponents.length;

      // Analyze duplicate functions
      analysis.duplicate_functions = await this.findDuplicateFunctions(analyzableComponents);
      
      // Analyze similar components
      analysis.similar_components = await this.findSimilarComponents(analyzableComponents);
      
      // Analyze unused dependencies
      analysis.unused_dependencies = await this.findUnusedDependencies(analyzableComponents);
      
      // Analyze redundant patterns
      analysis.redundant_patterns = await this.findRedundantPatterns(analyzableComponents);
      
      // Find consolidation opportunities
      analysis.consolidation_opportunities = this.findConsolidationOpportunities(
        analysis.duplicate_functions,
        analysis.similar_components,
        analysis.redundant_patterns
      );
      
      // Calculate overlap analysis
      analysis.overlap_analysis = this.calculateOverlapAnalysis(analyzableComponents);
      
      // Calculate metrics
      analysis.redundancy_score = this.calculateRedundancyScore(analysis);
      analysis.metrics = this.calculateRedundancyMetrics(analysis);
      analysis.recommendations = this.generateRedundancyRecommendations(analysis);

      console.log(chalk.green(`✅ Redundancy analysis completed`));
      console.log(chalk.gray(`   Components analyzed: ${analysis.metrics.total_components_analyzed}`));
      console.log(chalk.gray(`   Redundancy score: ${analysis.redundancy_score}/10`));
      console.log(chalk.gray(`   Duplicate functions: ${analysis.duplicate_functions.length}`));

      return analysis;

    } catch (error) {
      console.error(chalk.red(`Redundancy analysis failed: ${error.message}`));
      throw error;
    }
  }

  /**
   * Find duplicate functions across components
   */
  async findDuplicateFunctions(components) {
    const duplicates = [];
    const functionSignatures = new Map();

    for (const component of components) {
      try {
        const functions = await this.extractFunctionSignatures(component);
        
        for (const func of functions) {
          const signature = this.normalizeFunctionSignature(func.body);
          
          if (functionSignatures.has(signature)) {
            const existing = functionSignatures.get(signature);
            
            // Check if it's truly a duplicate (not just similar)
            const similarity = this.calculateSimilarity(existing.body, func.body);
            
            if (similarity > this.similarityThreshold) {
              duplicates.push({
                signature,
                similarity: Math.round(similarity * 100),
                instances: [
                  {
                    component: existing.component,
                    function_name: existing.name,
                    file_path: existing.file_path,
                    line_start: existing.line_start,
                    size: existing.size
                  },
                  {
                    component: component.id,
                    function_name: func.name,
                    file_path: component.file_path,
                    line_start: func.line_start,
                    size: func.size
                  }
                ],
                consolidation_potential: this.assessConsolidationPotential(existing, func),
                estimated_savings: this.estimateSavings(existing.size, func.size)
              });
            }
          } else {
            functionSignatures.set(signature, {
              ...func,
              component: component.id,
              file_path: component.file_path
            });
          }
        }
      } catch (error) {
        console.warn(chalk.yellow(`Failed to analyze functions in ${component.id}: ${error.message}`));
      }
    }

    return duplicates;
  }

  /**
   * Find components with similar functionality
   */
  async findSimilarComponents(components) {
    const similar = [];
    
    for (let i = 0; i < components.length; i++) {
      for (let j = i + 1; j < components.length; j++) {
        const comp1 = components[i];
        const comp2 = components[j];
        
        try {
          const similarity = await this.calculateComponentSimilarity(comp1, comp2);
          
          if (similarity.score > this.similarityThreshold) {
            similar.push({
              components: [comp1.id, comp2.id],
              similarity_score: Math.round(similarity.score * 100),
              common_patterns: similarity.patterns,
              overlap_areas: similarity.overlaps,
              merge_feasibility: this.assessMergeFeasibility(comp1, comp2),
              recommendations: this.generateSimilarityRecommendations(comp1, comp2, similarity)
            });
          }
        } catch (error) {
          console.warn(chalk.yellow(`Failed to compare ${comp1.id} and ${comp2.id}: ${error.message}`));
        }
      }
    }

    return similar.sort((a, b) => b.similarity_score - a.similarity_score);
  }

  /**
   * Find unused dependencies across components
   */
  async findUnusedDependencies(components) {
    const unused = [];
    const allDependencies = new Map();
    const usageTracker = new Map();

    // Collect all dependencies
    for (const component of components) {
      if (component.dependencies) {
        for (const dep of component.dependencies) {
          allDependencies.set(dep, (allDependencies.get(dep) || 0) + 1);
          usageTracker.set(dep, new Set());
        }
      }
    }

    // Check actual usage
    for (const component of components) {
      try {
        const filePath = path.join(this.rootPath, component.file_path);
        const content = await fs.readFile(filePath, 'utf-8');
        
        for (const [dep] of allDependencies) {
          if (this.isDependencyUsed(content, dep)) {
            usageTracker.get(dep).add(component.id);
          }
        }
      } catch (error) {
        // File not accessible, skip
      }
    }

    // Find unused dependencies
    for (const [dep, declaringCount] of allDependencies) {
      const usingComponents = usageTracker.get(dep);
      const actualUsage = usingComponents.size;
      
      if (actualUsage === 0) {
        unused.push({
          dependency: dep,
          declared_in: declaringCount,
          used_in: 0,
          status: 'completely_unused',
          potential_removal: true,
          estimated_savings: this.estimateDependencySavings(dep)
        });
      } else if (actualUsage < declaringCount) {
        unused.push({
          dependency: dep,
          declared_in: declaringCount,
          used_in: actualUsage,
          status: 'partially_unused',
          potential_removal: false,
          cleanup_opportunities: declaringCount - actualUsage
        });
      }
    }

    return unused.sort((a, b) => {
      if (a.status !== b.status) {
        return a.status === 'completely_unused' ? -1 : 1;
      }
      return b.declared_in - a.declared_in;
    });
  }

  /**
   * Find redundant code patterns
   */
  async findRedundantPatterns(components) {
    const patterns = [];
    const patternMatchers = {
      // Error handling patterns
      errorHandling: [
        /try\s*\{[\s\S]*?\}\s*catch\s*\([^)]*\)\s*\{[\s\S]*?console\.(error|log)/g,
        /if\s*\([^)]*error[^)]*\)\s*\{[\s\S]*?console\.(error|log)/g
      ],
      // Validation patterns
      validation: [
        /if\s*\(!\w+\)\s*\{[\s\S]*?throw new Error/g,
        /if\s*\(!.*\.length\)\s*\{[\s\S]*?(return|throw)/g
      ],
      // File operation patterns
      fileOperations: [
        /fs\.readFile\s*\([^)]+\)\s*\.then/g,
        /await fs\.readFile\s*\([^)]+\)/g
      ],
      // Logging patterns
      logging: [
        /console\.(log|info|debug)\s*\(\s*chalk\.\w+\s*\(/g,
        /console\.(log|info|debug)\s*\(\s*['\"`][^'\"`]*['\"`]/g
      ]
    };

    const patternCounts = {};
    const patternInstances = {};

    for (const component of components) {
      try {
        const filePath = path.join(this.rootPath, component.file_path);
        const content = await fs.readFile(filePath, 'utf-8');
        
        for (const [patternType, matchers] of Object.entries(patternMatchers)) {
          patternCounts[patternType] = patternCounts[patternType] || 0;
          patternInstances[patternType] = patternInstances[patternType] || [];
          
          for (const matcher of matchers) {
            const matches = [...content.matchAll(matcher)];
            
            if (matches.length > 0) {
              patternCounts[patternType] += matches.length;
              
              matches.forEach((match, index) => {
                patternInstances[patternType].push({
                  component: component.id,
                  file_path: component.file_path,
                  pattern: match[0].substring(0, 100) + (match[0].length > 100 ? '...' : ''),
                  line: this.getLineNumber(content, match.index)
                });
              });
            }
          }
        }
      } catch (error) {
        // File not accessible, skip
      }
    }

    // Identify redundant patterns (appear in multiple components)
    for (const [patternType, count] of Object.entries(patternCounts)) {
      if (count >= 3) { // Threshold for redundancy
        const instances = patternInstances[patternType];
        const componentCount = new Set(instances.map(i => i.component)).size;
        
        if (componentCount >= 2) { // Appears in multiple components
          patterns.push({
            pattern_type: patternType,
            total_occurrences: count,
            affected_components: componentCount,
            instances: instances.slice(0, 10), // Limit examples
            redundancy_level: this.calculatePatternRedundancy(count, componentCount),
            consolidation_suggestion: this.suggestPatternConsolidation(patternType, instances)
          });
        }
      }
    }

    return patterns.sort((a, b) => b.total_occurrences - a.total_occurrences);
  }

  /**
   * Find consolidation opportunities
   */
  findConsolidationOpportunities(duplicateFunctions, similarComponents, redundantPatterns) {
    const opportunities = [];

    // Function consolidation opportunities
    duplicateFunctions.forEach(duplicate => {
      if (duplicate.consolidation_potential === 'high') {
        opportunities.push({
          type: 'function_consolidation',
          priority: 'high',
          description: `Consolidate duplicate function: ${duplicate.signature}`,
          affected_components: duplicate.instances.map(i => i.component),
          estimated_effort: 'low',
          estimated_savings: duplicate.estimated_savings,
          implementation: 'Extract to shared utility module'
        });
      }
    });

    // Component merge opportunities
    similarComponents.forEach(similar => {
      if (similar.merge_feasibility === 'feasible' && similar.similarity_score > 80) {
        opportunities.push({
          type: 'component_merge',
          priority: 'medium',
          description: `Merge similar components: ${similar.components.join(', ')}`,
          affected_components: similar.components,
          estimated_effort: 'medium',
          estimated_savings: 'Reduced maintenance overhead',
          implementation: 'Combine functionality and create unified interface'
        });
      }
    });

    // Pattern standardization opportunities
    redundantPatterns.forEach(pattern => {
      if (pattern.redundancy_level === 'high') {
        opportunities.push({
          type: 'pattern_standardization',
          priority: 'medium',
          description: `Standardize ${pattern.pattern_type} pattern`,
          affected_components: pattern.affected_components,
          estimated_effort: 'medium',
          estimated_savings: 'Improved consistency and maintainability',
          implementation: pattern.consolidation_suggestion
        });
      }
    });

    return opportunities.sort((a, b) => {
      const priorityOrder = { high: 3, medium: 2, low: 1 };
      return priorityOrder[b.priority] - priorityOrder[a.priority];
    });
  }

  /**
   * Calculate overlap analysis between components
   */
  calculateOverlapAnalysis(components) {
    const overlap = {
      functional_overlap: {},
      dependency_overlap: {},
      pattern_overlap: {},
      total_overlap_score: 0
    };

    // This would analyze overlaps between components
    // For now, return basic structure
    return overlap;
  }

  /**
   * Extract function signatures from component
   */
  async extractFunctionSignatures(component) {
    const functions = [];
    
    try {
      const filePath = path.join(this.rootPath, component.file_path);
      const content = await fs.readFile(filePath, 'utf-8');
      const lines = content.split('\n');
      
      const functionRegex = /(?:function\s+(\w+)|(const|let|var)\s+(\w+)\s*=\s*(?:async\s+)?(?:function|\([^)]*\)\s*=>)|(\w+)\s*:\s*(?:async\s+)?function)/g;
      
      let match;
      while ((match = functionRegex.exec(content)) !== null) {
        const name = match[1] || match[3] || match[4] || 'anonymous';
        const startIndex = match.index;
        const startLine = this.getLineNumber(content, startIndex);
        
        // Extract function body (simplified)
        const functionBody = this.extractFunctionBody(content, startIndex);
        
        if (functionBody.length >= this.minFunctionLength) {
          functions.push({
            name,
            line_start: startLine,
            body: functionBody,
            size: functionBody.split('\n').length
          });
        }
      }
    } catch (error) {
      console.warn(`Failed to extract functions from ${component.id}: ${error.message}`);
    }
    
    return functions;
  }

  /**
   * Calculate similarity between two text blocks
   */
  calculateSimilarity(text1, text2) {
    // Normalize text
    const normalize = (text) => text
      .toLowerCase()
      .replace(/\s+/g, ' ')
      .replace(/[{}();,]/g, '')
      .trim();
    
    const norm1 = normalize(text1);
    const norm2 = normalize(text2);
    
    if (norm1 === norm2) return 1.0;
    
    // Use Levenshtein distance for similarity
    const maxLength = Math.max(norm1.length, norm2.length);
    if (maxLength === 0) return 1.0;
    
    const distance = this.levenshteinDistance(norm1, norm2);
    return 1 - (distance / maxLength);
  }

  /**
   * Calculate component similarity
   */
  async calculateComponentSimilarity(comp1, comp2) {
    const similarity = {
      score: 0,
      patterns: [],
      overlaps: []
    };

    try {
      // Compare file contents
      const content1 = await fs.readFile(path.join(this.rootPath, comp1.file_path), 'utf-8');
      const content2 = await fs.readFile(path.join(this.rootPath, comp2.file_path), 'utf-8');
      
      // Basic text similarity
      similarity.score = this.calculateSimilarity(content1, content2);
      
      // Find common patterns
      similarity.patterns = this.findCommonPatterns(content1, content2);
      
    } catch (error) {
      // File not accessible
    }

    return similarity;
  }

  /**
   * Calculate redundancy score
   */
  calculateRedundancyScore(analysis) {
    let score = 10; // Start with perfect score
    
    // Deduct for duplicates
    const duplicateDeduction = Math.min(3, analysis.duplicate_functions.length * 0.5);
    score -= duplicateDeduction;
    
    // Deduct for similar components
    const similarDeduction = Math.min(2, analysis.similar_components.length * 0.3);
    score -= similarDeduction;
    
    // Deduct for redundant patterns
    const patternDeduction = Math.min(2, analysis.redundant_patterns.length * 0.2);
    score -= patternDeduction;
    
    // Deduct for unused dependencies
    const unusedDeduction = Math.min(1, analysis.unused_dependencies.length * 0.1);
    score -= unusedDeduction;
    
    return Math.max(0, Math.round(score * 10) / 10);
  }

  /**
   * Calculate redundancy metrics
   */
  calculateRedundancyMetrics(analysis) {
    const metrics = analysis.metrics;
    
    // Calculate duplicate code percentage
    const totalFunctions = analysis.duplicate_functions.reduce((sum, dup) => sum + dup.instances.length, 0);
    metrics.duplicate_code_percentage = Math.round(
      (analysis.duplicate_functions.length / Math.max(1, totalFunctions)) * 100
    );
    
    // Calculate potential savings
    metrics.potential_savings = analysis.duplicate_functions.reduce((sum, dup) => {
      return sum + (typeof dup.estimated_savings === 'number' ? dup.estimated_savings : 0);
    }, 0);
    
    // Count redundancy hotspots
    metrics.redundancy_hotspots = analysis.consolidation_opportunities.filter(
      opp => opp.priority === 'high'
    ).length;
    
    return metrics;
  }

  /**
   * Generate redundancy recommendations
   */
  generateRedundancyRecommendations(analysis) {
    const recommendations = [];

    // High priority recommendations
    if (analysis.duplicate_functions.length > 5) {
      recommendations.push({
        priority: 'high',
        category: 'code_duplication',
        message: `${analysis.duplicate_functions.length} duplicate functions detected`,
        action: 'Extract common functionality into shared utilities'
      });
    }

    if (analysis.similar_components.length > 0) {
      const highSimilarity = analysis.similar_components.filter(s => s.similarity_score > 85);
      if (highSimilarity.length > 0) {
        recommendations.push({
          priority: 'high',
          category: 'component_consolidation',
          message: `${highSimilarity.length} highly similar components found`,
          action: 'Consider merging or refactoring similar components'
        });
      }
    }

    // Medium priority recommendations
    if (analysis.unused_dependencies.length > 0) {
      const completelyUnused = analysis.unused_dependencies.filter(u => u.status === 'completely_unused');
      if (completelyUnused.length > 0) {
        recommendations.push({
          priority: 'medium',
          category: 'dependency_cleanup',
          message: `${completelyUnused.length} completely unused dependencies`,
          action: 'Remove unused imports to reduce bundle size'
        });
      }
    }

    if (analysis.redundant_patterns.length > 0) {
      recommendations.push({
        priority: 'medium',
        category: 'pattern_standardization',
        message: `${analysis.redundant_patterns.length} redundant code patterns found`,
        action: 'Standardize common patterns using shared abstractions'
      });
    }

    // Overall score recommendation
    if (analysis.redundancy_score < 7) {
      recommendations.push({
        priority: 'high',
        category: 'general',
        message: `Redundancy score is ${analysis.redundancy_score}/10`,
        action: 'Comprehensive code consolidation and cleanup needed'
      });
    }

    return recommendations;
  }

  // Helper methods
  shouldAnalyzeComponent(component) {
    const analyzableTypes = ['utility', 'task'];
    const analyzableExtensions = ['.js', '.mjs', '.ts'];
    
    if (!analyzableTypes.includes(component.type)) {
      return false;
    }

    if (component.file_path) {
      const ext = path.extname(component.file_path).toLowerCase();
      return analyzableExtensions.includes(ext);
    }

    return false;
  }

  normalizeFunctionSignature(body) {
    return body
      .toLowerCase()
      .replace(/\s+/g, ' ')
      .replace(/[{}();,]/g, '')
      .replace(/\b\d+\b/g, 'N') // Replace numbers with placeholder
      .replace(/['"]\w+['"]/g, 'S') // Replace strings with placeholder
      .trim();
  }

  extractFunctionBody(content, startIndex) {
    // Simplified function body extraction
    let braceCount = 0;
    let inFunction = false;
    let body = '';
    
    for (let i = startIndex; i < content.length; i++) {
      const char = content[i];
      body += char;
      
      if (char === '{') {
        braceCount++;
        inFunction = true;
      } else if (char === '}') {
        braceCount--;
        if (inFunction && braceCount === 0) {
          break;
        }
      }
    }
    
    return body;
  }

  getLineNumber(content, index) {
    return content.substring(0, index).split('\n').length;
  }

  levenshteinDistance(str1, str2) {
    const matrix = [];
    
    for (let i = 0; i <= str2.length; i++) {
      matrix[i] = [i];
    }
    
    for (let j = 0; j <= str1.length; j++) {
      matrix[0][j] = j;
    }
    
    for (let i = 1; i <= str2.length; i++) {
      for (let j = 1; j <= str1.length; j++) {
        if (str2.charAt(i - 1) === str1.charAt(j - 1)) {
          matrix[i][j] = matrix[i - 1][j - 1];
        } else {
          matrix[i][j] = Math.min(
            matrix[i - 1][j - 1] + 1,
            matrix[i][j - 1] + 1,
            matrix[i - 1][j] + 1
          );
        }
      }
    }
    
    return matrix[str2.length][str1.length];
  }

  isDependencyUsed(content, dependency) {
    // Simple usage detection
    const depName = dependency.split('/').pop().replace(/[.-]/g, '');
    const patterns = [
      new RegExp(`\\b${depName}\\b`, 'i'),
      new RegExp(`require\\s*\\(\\s*['"]\[^'"]*${dependency}[^'"]*['"]\\s*\\)`, 'i'),
      new RegExp(`from\\s+['"]\[^'"]*${dependency}[^'"]*['"]`, 'i')
    ];
    
    return patterns.some(pattern => pattern.test(content));
  }

  assessConsolidationPotential(func1, func2) {
    const sizeDifference = Math.abs(func1.size - func2.size);
    const avgSize = (func1.size + func2.size) / 2;
    
    if (sizeDifference / avgSize < 0.2) return 'high';
    if (sizeDifference / avgSize < 0.5) return 'medium';
    return 'low';
  }

  assessMergeFeasibility(comp1, comp2) {
    // Simple heuristic based on component types and sizes
    if (comp1.type !== comp2.type) return 'difficult';
    
    const sizeDiff = Math.abs((comp1.size || 0) - (comp2.size || 0));
    if (sizeDiff < 1000) return 'feasible';
    if (sizeDiff < 5000) return 'possible';
    return 'difficult';
  }

  estimateSavings(size1, size2) {
    return Math.round((size1 + size2) * 0.3); // Estimate 30% savings from consolidation
  }

  estimateDependencySavings(dependency) {
    // Rough estimates based on dependency type
    if (dependency.includes('lodash')) return 'High (large bundle impact)';
    if (dependency.includes('fs') || dependency.includes('path')) return 'Low (Node.js built-in)';
    return 'Medium';
  }

  calculatePatternRedundancy(occurrences, componentCount) {
    const redundancyRatio = occurrences / componentCount;
    if (redundancyRatio > 3) return 'high';
    if (redundancyRatio > 2) return 'medium';
    return 'low';
  }

  suggestPatternConsolidation(patternType, instances) {
    const suggestions = {
      errorHandling: 'Create a centralized error handling utility',
      validation: 'Implement shared validation functions',
      fileOperations: 'Create a file operations abstraction layer',
      logging: 'Standardize logging through a shared logger utility'
    };
    
    return suggestions[patternType] || 'Extract common pattern to shared utility';
  }

  findCommonPatterns(content1, content2) {
    // This would implement more sophisticated pattern matching
    // For now, return empty array
    return [];
  }

  generateSimilarityRecommendations(comp1, comp2, similarity) {
    const recommendations = [];
    
    if (similarity.score > 0.9) {
      recommendations.push('Consider merging these nearly identical components');
    } else if (similarity.score > 0.7) {
      recommendations.push('Extract common functionality to reduce duplication');
    } else {
      recommendations.push('Monitor for potential consolidation opportunities');
    }
    
    return recommendations;
  }
}

module.exports = RedundancyAnalyzer;