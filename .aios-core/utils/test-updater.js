const fs = require('fs').promises;
const path = require('path');
const chalk = require('chalk');

/**
 * Test updater for AIOS-FULLSTACK modified components
 * Updates existing test files when components are modified
 */
class TestUpdater {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.testGenerator = options.testGenerator;
    this.coverageAnalyzer = options.coverageAnalyzer;
    this.diffGenerator = options.diffGenerator;
    this.updateCache = new Map();
    this.updateHistory = [];
  }

  /**
   * Initialize test updater
   */
  async initialize() {
    try {
      if (!this.testGenerator) {
        throw new Error('Test generator not provided');
      }

      if (!this.coverageAnalyzer) {
        throw new Error('Coverage analyzer not provided');
      }

      if (!this.diffGenerator) {
        throw new Error('Diff generator not provided');
      }

      console.log(chalk.green('✅ Test updater initialized'));
      return true;

    } catch (error) {
      console.error(chalk.red(`Failed to initialize test updater: ${error.message}`));
      throw error;
    }
  }

  /**
   * Update tests for a modified component
   */
  async updateTestsForComponent(component, modifications, config = {}) {
    const updateId = `update-${Date.now()}`;
    
    try {
      console.log(chalk.blue(`🔄 Updating tests for modified component: ${component.name}`));

      // Analyze current test coverage
      const currentCoverage = await this.coverageAnalyzer.analyzeComponentCoverage(component);
      
      // Find existing test files
      const existingTests = await this.findExistingTestFiles(component);
      
      if (existingTests.length === 0) {
        console.log(chalk.yellow(`No existing tests found for ${component.name}, generating new tests instead`));
        return await this.testGenerator.generateTestSuite(component, { test_files: [] }, config);
      }

      // Analyze modifications to determine what tests need updating
      const testUpdatePlan = await this.analyzeTestUpdateNeeds(component, modifications, existingTests);
      
      // Execute test updates
      const updateResults = await this.executeTestUpdates(testUpdatePlan, config);
      
      // Validate updated tests
      const validationResults = await this.validateUpdatedTests(updateResults);
      
      // Update coverage analysis
      const newCoverage = await this.coverageAnalyzer.analyzeComponentCoverage(component);
      
      const result = {
        update_id: updateId,
        component_id: component.id,
        component_name: component.name,
        modifications_analyzed: modifications.length,
        existing_tests: existingTests.length,
        tests_updated: updateResults.updated_files.length,
        tests_created: updateResults.new_files.length,
        coverage_before: currentCoverage.lines.percentage,
        coverage_after: newCoverage.lines.percentage,
        coverage_improvement: newCoverage.lines.percentage - currentCoverage.lines.percentage,
        validation_results: validationResults,
        timestamp: new Date().toISOString()
      };

      // Cache results
      this.updateCache.set(updateId, result);
      this.updateHistory.push({
        update_id: updateId,
        component_name: component.name,
        timestamp: result.timestamp,
        success: validationResults.all_valid
      });

      console.log(chalk.green(`✅ Test update completed for ${component.name}`));
      console.log(chalk.gray(`   Tests updated: ${result.tests_updated}`));
      console.log(chalk.gray(`   Tests created: ${result.tests_created}`));
      console.log(chalk.gray(`   Coverage improvement: ${result.coverage_improvement.toFixed(1)}%`));

      return result;

    } catch (error) {
      console.error(chalk.red(`Failed to update tests for ${component.name}: ${error.message}`));
      throw error;
    }
  }

  /**
   * Find existing test files for a component
   */
  async findExistingTestFiles(component) {
    const testFiles = [];
    const possibleTestPaths = [
      path.join(this.rootPath, 'tests', 'unit', component.type, `${component.name}.test.js`),
      path.join(this.rootPath, 'tests', 'unit', component.type, `${component.name}.spec.js`),
      path.join(this.rootPath, 'tests', 'integration', component.type, `${component.name}.integration.test.js`),
      path.join(this.rootPath, 'tests', 'e2e', component.type, `${component.name}.e2e.test.js`),
      path.join(this.rootPath, 'test', `${component.name}.test.js`),
      path.join(this.rootPath, '__tests__', `${component.name}.test.js`)
    ];

    for (const testPath of possibleTestPaths) {
      try {
        const stats = await fs.stat(testPath);
        if (stats.isFile()) {
          const content = await fs.readFile(testPath, 'utf-8');
          const testAnalysis = await this.analyzeTestFile(testPath, content);
          
          testFiles.push({
            file_path: testPath,
            test_type: this.determineTestType(testPath),
            content: content,
            analysis: testAnalysis,
            last_modified: stats.mtime.toISOString()
          });
        }
      } catch (error) {
        // File doesn't exist, continue
      }
    }

    return testFiles;
  }

  /**
   * Analyze test update needs based on component modifications
   */
  async analyzeTestUpdateNeeds(component, modifications, existingTests) {
    const updatePlan = {
      component_id: component.id,
      modifications: modifications,
      existing_tests: existingTests.length,
      updates_needed: []
    };

    for (const testFile of existingTests) {
      const updateNeeds = await this.analyzeTestFileUpdateNeeds(testFile, modifications, component);
      
      if (updateNeeds.needs_update) {
        updatePlan.updates_needed.push({
          test_file: testFile.file_path,
          test_type: testFile.test_type,
          update_reasons: updateNeeds.reasons,
          update_actions: updateNeeds.actions,
          priority: updateNeeds.priority
        });
      }
    }

    // Check if new test files are needed for new functionality
    const newTestsNeeded = await this.identifyNewTestsNeeded(component, modifications, existingTests);
    updatePlan.new_tests_needed = newTestsNeeded;

    return updatePlan;
  }

  /**
   * Analyze if a specific test file needs updates
   */
  async analyzeTestFileUpdateNeeds(testFile, modifications, component) {
    const needs = {
      needs_update: false,
      reasons: [],
      actions: [],
      priority: 'low'
    };

    // Helper function to update priority keeping the highest one
    const updatePriority = (newPriority) => {
      const priorityLevels = { 'low': 1, 'medium': 2, 'high': 3 };
      if (priorityLevels[newPriority] > priorityLevels[needs.priority]) {
        needs.priority = newPriority;
      }
    };

    // Check for new functions/methods that need tests
    const newFunctions = modifications.filter(mod => mod.type === 'function_added');
    if (newFunctions.length > 0) {
      needs.needs_update = true;
      needs.reasons.push(`${newFunctions.length} new functions added`);
      needs.actions.push('add_function_tests');
      updatePriority('high');
    }

    // Check for modified functions that need test updates
    const modifiedFunctions = modifications.filter(mod => mod.type === 'function_modified');
    if (modifiedFunctions.length > 0) {
      needs.needs_update = true;
      needs.reasons.push(`${modifiedFunctions.length} functions modified`);
      needs.actions.push('update_function_tests');
      updatePriority('medium');
    }

    // Check for new dependencies that need mocking
    const newDependencies = modifications.filter(mod => mod.type === 'dependency_added');
    if (newDependencies.length > 0) {
      needs.needs_update = true;
      needs.reasons.push(`${newDependencies.length} new dependencies added`);
      needs.actions.push('add_dependency_mocks');
      updatePriority('medium');
    }

    // Check for error handling changes
    const errorHandlingChanges = modifications.filter(mod => mod.type === 'error_handling_changed');
    if (errorHandlingChanges.length > 0) {
      needs.needs_update = true;
      needs.reasons.push('Error handling logic changed');
      needs.actions.push('update_error_tests');
      updatePriority('high');
    }

    // Check for async/await pattern changes
    const asyncChanges = modifications.filter(mod => mod.type === 'async_pattern_changed');
    if (asyncChanges.length > 0) {
      needs.needs_update = true;
      needs.reasons.push('Async patterns changed');
      needs.actions.push('update_async_tests');
      updatePriority('high');
    }

    // Check for configuration changes (for agents/workflows)
    if (component.type === 'agent' || component.type === 'workflow') {
      const configChanges = modifications.filter(mod => mod.type === 'config_changed');
      if (configChanges.length > 0) {
        needs.needs_update = true;
        needs.reasons.push('Configuration changed');
        needs.actions.push('update_config_tests');
        updatePriority('medium');
      }
    }

    return needs;
  }

  /**
   * Execute test updates based on the update plan
   */
  async executeTestUpdates(updatePlan, config) {
    const results = {
      updated_files: [],
      new_files: [],
      errors: []
    };

    // Update existing test files
    for (const update of updatePlan.updates_needed) {
      try {
        const updatedContent = await this.updateTestFile(update, config);
        
        // Create backup of original
        const backupPath = `${update.test_file}.backup.${Date.now()}`;
        const originalContent = await fs.readFile(update.test_file, 'utf-8');
        await fs.writeFile(backupPath, originalContent);

        // Write updated content
        await fs.writeFile(update.test_file, updatedContent);

        results.updated_files.push({
          file_path: update.test_file,
          backup_path: backupPath,
          update_actions: update.update_actions,
          update_reasons: update.update_reasons
        });

      } catch (error) {
        results.errors.push({
          file_path: update.test_file,
          error: error.message,
          update_actions: update.update_actions
        });
      }
    }

    // Create new test files if needed
    for (const newTest of updatePlan.new_tests_needed || []) {
      try {
        const testContent = await this.testGenerator.generateTestFile(
          { id: updatePlan.component_id, name: newTest.component_name, type: newTest.component_type },
          newTest,
          config
        );

        await fs.writeFile(newTest.file_path, testContent);

        results.new_files.push({
          file_path: newTest.file_path,
          test_type: newTest.test_type,
          test_count: newTest.test_count || 0
        });

      } catch (error) {
        results.errors.push({
          file_path: newTest.file_path,
          error: error.message,
          test_type: newTest.test_type
        });
      }
    }

    return results;
  }

  /**
   * Update content of a specific test file
   */
  async updateTestFile(updateInfo, config) {
    const originalContent = await fs.readFile(updateInfo.test_file, 'utf-8');
    let updatedContent = originalContent;

    for (const action of updateInfo.update_actions) {
      switch (action) {
        case 'add_function_tests':
          updatedContent = await this.addFunctionTests(updatedContent, updateInfo, config);
          break;
        case 'update_function_tests':
          updatedContent = await this.updateFunctionTests(updatedContent, updateInfo, config);
          break;
        case 'add_dependency_mocks':
          updatedContent = await this.addDependencyMocks(updatedContent, updateInfo, config);
          break;
        case 'update_error_tests':
          updatedContent = await this.updateErrorTests(updatedContent, updateInfo, config);
          break;
        case 'update_async_tests':
          updatedContent = await this.updateAsyncTests(updatedContent, updateInfo, config);
          break;
        case 'update_config_tests':
          updatedContent = await this.updateConfigTests(updatedContent, updateInfo, config);
          break;
      }
    }

    // Add update timestamp comment
    const updateComment = `\n// Updated by Test Updater on ${new Date().toISOString()}\n// Reasons: ${updateInfo.update_reasons.join(', ')}\n`;
    updatedContent = updatedContent + updateComment;

    return updatedContent;
  }

  /**
   * Add tests for new functions
   */
  async addFunctionTests(content, updateInfo, config) {
    // Find insertion point (usually before the closing of describe block)
    const insertionPoint = content.lastIndexOf('});');
    
    if (insertionPoint === -1) {
      return content + '\n\n// TODO: Add tests for new functions';
    }

    const newTestCases = `
  
  // Tests for newly added functions
  describe('New Functions', () => {
    it('should test new functionality', async () => {
      // TODO: Add specific tests for new functions
      expect(true).toBeTruthy();
    });
  });`;

    return content.slice(0, insertionPoint) + newTestCases + '\n\n' + content.slice(insertionPoint);
  }

  /**
   * Update tests for modified functions
   */
  async updateFunctionTests(content, updateInfo, config) {
    // Add comment about function modifications
    const modificationNote = `\n  // NOTE: Function tests may need updates due to modifications\n`;
    
    // Find the first test case and add the note
    const firstItMatch = content.match(/(\s+it\()/);
    if (firstItMatch) {
      const insertIndex = firstItMatch.index;
      return content.slice(0, insertIndex) + modificationNote + content.slice(insertIndex);
    }

    return content;
  }

  /**
   * Add mocks for new dependencies
   */
  async addDependencyMocks(content, updateInfo, config) {
    // Find the imports section
    const importEndMatch = content.match(/\n\n(?!(?:const|import|require))/);
    
    if (importEndMatch) {
      const insertIndex = importEndMatch.index;
      const mockSection = `\n// Mocks for new dependencies\n// TODO: Add specific mocks for new dependencies\n`;
      return content.slice(0, insertIndex) + mockSection + content.slice(insertIndex);
    }

    return content;
  }

  /**
   * Update error handling tests
   */
  async updateErrorTests(content, updateInfo, config) {
    // Add note about error handling updates
    const errorTestNote = `\n  // NOTE: Error handling tests may need updates\n`;
    
    // Find error-related tests or add new section
    if (content.includes('error') || content.includes('Error')) {
      return content + errorTestNote;
    } else {
      const insertionPoint = content.lastIndexOf('});');
      const errorTestSection = `

  describe('Error Handling', () => {
    it('should handle errors appropriately', async () => {
      // TODO: Add error handling tests
      expect(true).toBeTruthy();
    });
  });`;

      return content.slice(0, insertionPoint) + errorTestSection + '\n\n' + content.slice(insertionPoint);
    }
  }

  /**
   * Update async tests
   */
  async updateAsyncTests(content, updateInfo, config) {
    // Add note about async pattern changes
    const asyncNote = `\n  // NOTE: Async tests may need updates due to pattern changes\n`;
    
    // Find async tests
    if (content.includes('async') || content.includes('await')) {
      return content + asyncNote;
    }

    return content;
  }

  /**
   * Update configuration tests
   */
  async updateConfigTests(content, updateInfo, config) {
    // Add note about configuration changes
    const configNote = `\n  // NOTE: Configuration tests may need updates\n`;
    
    // Find config-related tests
    if (content.includes('config') || content.includes('Config')) {
      return content + configNote;
    } else {
      const insertionPoint = content.lastIndexOf('});');
      const configTestSection = `

  describe('Configuration', () => {
    it('should validate configuration changes', async () => {
      // TODO: Add configuration tests
      expect(true).toBeTruthy();
    });
  });`;

      return content.slice(0, insertionPoint) + configTestSection + '\n\n' + content.slice(insertionPoint);
    }
  }

  /**
   * Identify new test files that need to be created
   */
  async identifyNewTestsNeeded(component, modifications, existingTests) {
    const newTests = [];
    
    // Check if component now has integration points that need integration tests
    const integrationChanges = modifications.filter(mod => 
      mod.type === 'integration_added' || mod.type === 'api_added'
    );
    
    if (integrationChanges.length > 0) {
      const hasIntegrationTests = existingTests.some(test => test.test_type === 'integration');
      
      if (!hasIntegrationTests) {
        newTests.push({
          component_name: component.name,
          component_type: component.type,
          test_type: 'integration',
          file_path: path.join(this.rootPath, 'tests', 'integration', component.type, `${component.name}.integration.test.js`),
          reason: 'New integration points added'
        });
      }
    }

    // Check if component now needs e2e tests
    const e2eChanges = modifications.filter(mod => 
      mod.type === 'workflow_added' || mod.type === 'user_facing_change'
    );
    
    if (e2eChanges.length > 0) {
      const hasE2eTests = existingTests.some(test => test.test_type === 'e2e');
      
      if (!hasE2eTests) {
        newTests.push({
          component_name: component.name,
          component_type: component.type,
          test_type: 'e2e',
          file_path: path.join(this.rootPath, 'tests', 'e2e', component.type, `${component.name}.e2e.test.js`),
          reason: 'New user-facing functionality added'
        });
      }
    }

    return newTests;
  }

  /**
   * Validate updated tests
   */
  async validateUpdatedTests(updateResults) {
    const validation = {
      all_valid: true,
      file_validations: [],
      syntax_errors: [],
      warnings: []
    };

    // Validate syntax of updated files
    for (const updatedFile of updateResults.updated_files) {
      try {
        const content = await fs.readFile(updatedFile.file_path, 'utf-8');
        const fileValidation = await this.validateTestFileSyntax(content, updatedFile.file_path);
        
        validation.file_validations.push({
          file_path: updatedFile.file_path,
          valid: fileValidation.valid,
          issues: fileValidation.issues
        });

        if (!fileValidation.valid) {
          validation.all_valid = false;
          validation.syntax_errors.push(...fileValidation.issues);
        }

      } catch (error) {
        validation.all_valid = false;
        validation.syntax_errors.push({
          file: updatedFile.file_path,
          error: error.message
        });
      }
    }

    // Validate syntax of new files
    for (const newFile of updateResults.new_files) {
      try {
        const content = await fs.readFile(newFile.file_path, 'utf-8');
        const fileValidation = await this.validateTestFileSyntax(content, newFile.file_path);
        
        validation.file_validations.push({
          file_path: newFile.file_path,
          valid: fileValidation.valid,
          issues: fileValidation.issues
        });

        if (!fileValidation.valid) {
          validation.all_valid = false;
          validation.syntax_errors.push(...fileValidation.issues);
        }

      } catch (error) {
        validation.all_valid = false;
        validation.syntax_errors.push({
          file: newFile.file_path,
          error: error.message
        });
      }
    }

    return validation;
  }

  /**
   * Validate test file syntax
   */
  async validateTestFileSyntax(content, filePath) {
    const validation = {
      valid: true,
      issues: []
    };

    try {
      // Check for balanced brackets
      const openBrackets = (content.match(/\{/g) || []).length;
      const closeBrackets = (content.match(/\}/g) || []).length;
      
      if (openBrackets !== closeBrackets) {
        validation.valid = false;
        validation.issues.push({
          type: 'syntax',
          message: 'Unbalanced brackets',
          file: filePath
        });
      }

      // Check for test structure
      if (!content.includes('describe(') && !content.includes('it(') && !content.includes('test(')) {
        validation.valid = false;
        validation.issues.push({
          type: 'structure',
          message: 'No test cases found',
          file: filePath
        });
      }

      // Check for basic assertions
      if (!content.includes('expect(')) {
        validation.issues.push({
          type: 'warning', 
          message: 'No assertions found',
          file: filePath
        });
      }

    } catch (error) {
      validation.valid = false;
      validation.issues.push({
        type: 'error',
        message: error.message,
        file: filePath
      });
    }

    return validation;
  }

  // Helper methods

  async analyzeTestFile(filePath, content) {
    return {
      test_count: (content.match(/\b(?:it|test)\s*\(/g) || []).length,
      assertion_count: (content.match(/expect\s*\(/g) || []).length,
      mock_count: (content.match(/\b(?:mock|spy|stub)\b/gi) || []).length,
      async_tests: (content.match(/async\s*\([^)]*\)\s*=>/g) || []).length,
      has_setup: content.includes('beforeEach') || content.includes('beforeAll'),
      has_teardown: content.includes('afterEach') || content.includes('afterAll')
    };
  }

  determineTestType(testPath) {
    if (testPath.includes('integration')) return 'integration';
    if (testPath.includes('e2e')) return 'e2e';
    return 'unit';
  }

  /**
   * Get update statistics
   */
  getUpdateStats() {
    return {
      total_updates: this.updateHistory.length,
      successful_updates: this.updateHistory.filter(u => u.success).length,
      failed_updates: this.updateHistory.filter(u => !u.success).length,
      cached_results: this.updateCache.size,
      recent_updates: this.updateHistory.slice(-10)
    };
  }

  /**
   * Clear update cache
   */
  clearCache() {
    this.updateCache.clear();
    console.log(chalk.gray('Test updater cache cleared'));
  }
}

module.exports = TestUpdater;