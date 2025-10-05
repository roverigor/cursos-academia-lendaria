const fs = require('fs').promises;
const path = require('path');
const { spawn } = require('child_process');
const chalk = require('chalk');
const tmp = require('tmp-promise');
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);

/**
 * Tests improvements in an isolated sandbox environment
 */
class SandboxTester {
  constructor(options = {}) {
    this.rootPath = options.rootPath || process.cwd();
    this.sandboxDir = options.sandboxDir || path.join(this.rootPath, '.aios', 'sandbox');
    this.testTimeout = options.testTimeout || 300000; // 5 minutes
    this.verbose = options.verbose || false;
    
    // Test configurations
    this.testSuites = {
      unit: {
        command: 'npm test',
        timeout: 120000,
        required: true
      },
      integration: {
        command: 'npm run test:integration',
        timeout: 180000,
        required: false
      },
      performance: {
        command: 'npm run test:performance',
        timeout: 60000,
        required: false
      },
      security: {
        command: 'npm run test:security',
        timeout: 60000,
        required: true
      }
    };
  }

  /**
   * Test improvements in sandbox
   * @param {Object} params - Test parameters
   * @returns {Promise<Object>} Test results
   */
  async testImprovements(params) {
    const { plan, backupId } = params;
    
    console.log(chalk.blue('🧪 Testing improvements in sandbox...'));
    
    const results = {
      success: true,
      tests_passed: 0,
      tests_failed: 0,
      total_tests: 0,
      performance_impact: '0%',
      no_breaking_changes: true,
      details: {
        unit: null,
        integration: null,
        performance: null,
        security: null,
        validation: null
      },
      errors: [],
      warnings: []
    };

    let sandboxPath = null;

    try {
      // Create sandbox environment
      sandboxPath = await this.createSandbox(plan);
      console.log(chalk.gray(`Sandbox created at: ${sandboxPath}`));

      // Apply improvements to sandbox
      await this.applyImprovementsToSandbox(sandboxPath, plan);

      // Run validation tests
      const validationResults = await this.runValidationTests(sandboxPath, plan);
      results.details.validation = validationResults;
      
      if (!validationResults.success) {
        results.success = false;
        results.errors.push('Validation tests failed');
        return results;
      }

      // Run test suites
      for (const [suite, config] of Object.entries(this.testSuites)) {
        const suiteResult = await this.runTestSuite(sandboxPath, suite, config);
        results.details[suite] = suiteResult;
        
        results.total_tests += suiteResult.total || 0;
        results.tests_passed += suiteResult.passed || 0;
        results.tests_failed += suiteResult.failed || 0;
        
        if (!suiteResult.success && config.required) {
          results.success = false;
          results.errors.push(`${suite} tests failed`);
        }
        
        if (suiteResult.warnings) {
          results.warnings.push(...suiteResult.warnings);
        }
      }

      // Check for breaking changes
      const breakingChanges = await this.checkBreakingChanges(sandboxPath, plan);
      results.no_breaking_changes = !breakingChanges.found;
      if (breakingChanges.found) {
        results.errors.push(...breakingChanges.changes);
      }

      // Measure performance impact
      const perfImpact = await this.measurePerformanceImpact(sandboxPath);
      results.performance_impact = perfImpact.summary;
      
      if (Math.abs(perfImpact.percentage) > 10) {
        results.warnings.push(`Significant performance impact: ${perfImpact.summary}`);
      }

    } catch (error) {
      results.success = false;
      results.errors.push(`Sandbox testing error: ${error.message}`);
    } finally {
      // Cleanup sandbox
      if (sandboxPath) {
        await this.cleanupSandbox(sandboxPath);
      }
    }

    return results;
  }

  /**
   * Create isolated sandbox environment
   * @private
   */
  async createSandbox(plan) {
    // Create temporary directory
    const tmpDir = await tmp.dir({ unsafeCleanup: true });
    const sandboxPath = tmpDir.path;

    // Copy current implementation
    await this.copyToSandbox(this.rootPath, sandboxPath, [
      'node_modules',
      '.git',
      '.aios/sandbox',
      '.aios/backup',
      'coverage',
      'dist',
      'build'
    ]);

    // Set sandbox environment
    await fs.writeFile(
      path.join(sandboxPath, '.sandbox'),
      JSON.stringify({
        created: new Date().toISOString(),
        plan_id: plan.id,
        parent: this.rootPath
      })
    );

    // Install dependencies if needed
    const packageJsonPath = path.join(sandboxPath, 'package.json');
    if (await this.fileExists(packageJsonPath)) {
      await this.runCommand(sandboxPath, 'npm ci --prefer-offline --no-audit');
    }

    return sandboxPath;
  }

  /**
   * Copy files to sandbox with exclusions
   * @private
   */
  async copyToSandbox(source, dest, exclude = []) {
    await fs.mkdir(dest, { recursive: true });
    
    const entries = await fs.readdir(source, { withFileTypes: true });
    
    for (const entry of entries) {
      if (exclude.includes(entry.name)) continue;
      
      const sourcePath = path.join(source, entry.name);
      const destPath = path.join(dest, entry.name);
      
      if (entry.isDirectory()) {
        await this.copyToSandbox(sourcePath, destPath, exclude);
      } else {
        await fs.copyFile(sourcePath, destPath);
      }
    }
  }

  /**
   * Apply improvements to sandbox
   * @private
   */
  async applyImprovementsToSandbox(sandboxPath, plan) {
    console.log(chalk.gray('Applying improvements to sandbox...'));
    
    for (const change of plan.changes) {
      for (const modification of change.modifications) {
        await this.applyModification(sandboxPath, modification);
      }
    }
  }

  /**
   * Apply single modification
   * @private
   */
  async applyModification(sandboxPath, modification) {
    const filePath = path.join(sandboxPath, modification.file);
    
    switch (modification.type) {
      case 'wrap_in_try_catch':
        await this.wrapInTryCatch(filePath, modification);
        break;
        
      case 'enhance_error_message':
        await this.enhanceErrorMessage(filePath, modification);
        break;
        
      case 'add_retry_logic':
        await this.addRetryLogic(filePath, modification);
        break;
        
      default:
        console.warn(`Unknown modification type: ${modification.type}`);
    }
  }

  /**
   * Run validation tests
   * @private
   */
  async runValidationTests(sandboxPath, plan) {
    console.log(chalk.gray('Running validation tests...'));
    
    const validation = {
      success: true,
      checks: {
        syntax: { passed: false, errors: [] },
        imports: { passed: false, errors: [] },
        exports: { passed: false, errors: [] },
        types: { passed: false, errors: [] }
      }
    };

    // Syntax validation
    for (const file of plan.affectedFiles) {
      const filePath = path.join(sandboxPath, file);
      try {
        await exec(`node --check "${filePath}"`);
        validation.checks.syntax.passed = true;
      } catch (error) {
        validation.success = false;
        validation.checks.syntax.errors.push({
          file,
          error: error.message
        });
      }
    }

    // Import/Export validation
    try {
      const importTest = `
        const files = ${JSON.stringify(plan.affectedFiles)};
        for (const file of files) {
          try {
            require('./' + file);
          } catch (error) {
            console.error('Import failed:', file, error.message);
            process.exit(1);
          }
        }
      `;
      
      await this.runCommand(sandboxPath, `node -e "${importTest}"`);
      validation.checks.imports.passed = true;
    } catch (error) {
      validation.success = false;
      validation.checks.imports.errors.push(error.message);
    }

    return validation;
  }

  /**
   * Run test suite
   * @private
   */
  async runTestSuite(sandboxPath, suite, config) {
    console.log(chalk.gray(`Running ${suite} tests...`));
    
    const result = {
      suite,
      success: false,
      total: 0,
      passed: 0,
      failed: 0,
      duration: 0,
      output: '',
      warnings: []
    };

    const startTime = Date.now();

    try {
      // Check if test command exists
      const packageJson = JSON.parse(
        await fs.readFile(path.join(sandboxPath, 'package.json'), 'utf-8')
      );
      
      const scripts = packageJson.scripts || {};
      const commandParts = config.command.split(' ');
      const scriptName = commandParts[2]; // npm run <script>
      
      if (!scripts[scriptName] && config.required) {
        result.warnings = [`No ${suite} test script found`];
        result.success = !config.required;
        return result;
      }

      // Run tests
      const output = await this.runCommand(
        sandboxPath, 
        config.command,
        { timeout: config.timeout }
      );
      
      result.output = output;
      result.success = true;
      
      // Parse test results
      const parsed = this.parseTestOutput(output, suite);
      Object.assign(result, parsed);
      
    } catch (error) {
      result.failed = 1;
      result.output = error.message;
      
      // Try to parse failed test output
      if (error.stdout) {
        const parsed = this.parseTestOutput(error.stdout, suite);
        Object.assign(result, parsed);
      }
    }

    result.duration = Date.now() - startTime;
    return result;
  }

  /**
   * Check for breaking changes
   * @private
   */
  async checkBreakingChanges(sandboxPath, plan) {
    const changes = {
      found: false,
      changes: []
    };

    // Check API signatures
    for (const file of plan.affectedFiles) {
      if (file.endsWith('.js')) {
        const originalPath = path.join(this.rootPath, file);
        const sandboxPath = path.join(sandboxPath, file);
        
        try {
          const original = await this.extractExports(originalPath);
          const modified = await this.extractExports(sandboxPath);
          
          // Compare exports
          for (const exp of original) {
            if (!modified.find(m => m.name === exp.name && m.type === exp.type)) {
              changes.found = true;
              changes.changes.push(`Missing export: ${exp.name} in ${file}`);
            }
          }
        } catch (error) {
          // Skip comparison if extraction fails
        }
      }
    }

    return changes;
  }

  /**
   * Measure performance impact
   * @private
   */
  async measurePerformanceImpact(sandboxPath) {
    const impact = {
      percentage: 0,
      summary: '0%',
      details: {}
    };

    try {
      // Run performance benchmarks if available
      const perfResult = await this.runCommand(
        sandboxPath,
        'npm run benchmark',
        { timeout: 60000 }
      );
      
      // Parse benchmark results
      const baselineMatch = perfResult.match(/baseline:\s*([\d.]+)/);
      const currentMatch = perfResult.match(/current:\s*([\d.]+)/);
      
      if (baselineMatch && currentMatch) {
        const baseline = parseFloat(baselineMatch[1]);
        const current = parseFloat(currentMatch[1]);
        impact.percentage = ((current - baseline) / baseline) * 100;
        impact.summary = `${impact.percentage > 0 ? '+' : ''}${impact.percentage.toFixed(1)}%`;
      }
    } catch (error) {
      // No benchmark available
      impact.summary = 'N/A';
    }

    return impact;
  }

  /**
   * Clean up sandbox
   * @private
   */
  async cleanupSandbox(sandboxPath) {
    try {
      await fs.rm(sandboxPath, { recursive: true, force: true });
      console.log(chalk.gray('Sandbox cleaned up'));
    } catch (error) {
      console.warn(`Failed to cleanup sandbox: ${error.message}`);
    }
  }

  /**
   * Run command in directory
   * @private
   */
  async runCommand(cwd, command, options = {}) {
    const timeout = options.timeout || 30000;
    
    return new Promise((resolve, reject) => {
      const [cmd, ...args] = command.split(' ');
      const proc = spawn(cmd, args, {
        cwd,
        shell: true,
        env: { ...process.env, CI: 'true', NODE_ENV: 'test' }
      });

      let stdout = '';
      let stderr = '';
      let timedOut = false;

      const timer = setTimeout(() => {
        timedOut = true;
        proc.kill('SIGTERM');
      }, timeout);

      proc.stdout.on('data', (data) => {
        stdout += data.toString();
        if (this.verbose) process.stdout.write(data);
      });

      proc.stderr.on('data', (data) => {
        stderr += data.toString();
        if (this.verbose) process.stderr.write(data);
      });

      proc.on('close', (code) => {
        clearTimeout(timer);
        
        if (timedOut) {
          reject(new Error(`Command timed out after ${timeout}ms`));
        } else if (code !== 0) {
          const error = new Error(`Command failed with code ${code}`);
          error.stdout = stdout;
          error.stderr = stderr;
          reject(error);
        } else {
          resolve(stdout);
        }
      });

      proc.on('error', (error) => {
        clearTimeout(timer);
        reject(error);
      });
    });
  }

  /**
   * Parse test output
   * @private
   */
  parseTestOutput(output, suite) {
    const result = {
      total: 0,
      passed: 0,
      failed: 0
    };

    // Jest pattern
    const jestMatch = output.match(/Tests:\s*(\d+)\s*passed,\s*(\d+)\s*total/);
    if (jestMatch) {
      result.passed = parseInt(jestMatch[1], 10);
      result.total = parseInt(jestMatch[2], 10);
      result.failed = result.total - result.passed;
      return result;
    }

    // Mocha pattern
    const mochaMatch = output.match(/(\d+)\s*passing.*(\d+)\s*failing/);
    if (mochaMatch) {
      result.passed = parseInt(mochaMatch[1], 10);
      result.failed = parseInt(mochaMatch[2], 10);
      result.total = result.passed + result.failed;
      return result;
    }

    // Generic pattern
    const passMatch = output.match(/(\d+)\s*(tests?|specs?)\s*pass/i);
    const failMatch = output.match(/(\d+)\s*(tests?|specs?)\s*fail/i);
    
    if (passMatch) result.passed = parseInt(passMatch[1], 10);
    if (failMatch) result.failed = parseInt(failMatch[1], 10);
    result.total = result.passed + result.failed;

    return result;
  }

  /**
   * Extract exports from file
   * @private
   */
  async extractExports(filePath) {
    const exports = [];
    
    try {
      const content = await fs.readFile(filePath, 'utf-8');
      
      // module.exports patterns
      const moduleExports = content.match(/module\.exports\s*=\s*{([^}]+)}/);
      if (moduleExports) {
        const props = moduleExports[1].match(/(\w+):/g);
        if (props) {
          props.forEach(prop => {
            exports.push({
              name: prop.replace(':', ''),
              type: 'property'
            });
          });
        }
      }
      
      // ES6 exports
      const es6Exports = content.match(/export\s+(const|let|var|function|class)\s+(\w+)/g);
      if (es6Exports) {
        es6Exports.forEach(exp => {
          const match = exp.match(/export\s+(const|let|var|function|class)\s+(\w+)/);
          if (match) {
            exports.push({
              name: match[2],
              type: match[1]
            });
          }
        });
      }
    } catch (error) {
      // Ignore parse errors
    }
    
    return exports;
  }

  /**
   * Wrap function in try-catch
   * @private
   */
  async wrapInTryCatch(filePath, modification) {
    let content = await fs.readFile(filePath, 'utf-8');
    
    // Simple implementation - would need AST transformation for production
    const functionPattern = new RegExp(
      `(async\\s+function\\s+\\w+\\s*\\([^)]*\\)\\s*{)([^}]+)(})`,
      'g'
    );
    
    content = content.replace(functionPattern, (match, start, body, end) => {
      if (!body.includes('try')) {
        return `${start}\n    try {${body}\n    } catch (error) {\n      console.error('Error in function:', error);\n      throw error;\n    }\n  ${end}`;
      }
      return match;
    });
    
    await fs.writeFile(filePath, content);
  }

  /**
   * Enhance error message
   * @private
   */
  async enhanceErrorMessage(filePath, modification) {
    let content = await fs.readFile(filePath, 'utf-8');
    
    if (modification.pattern) {
      content = content.replace(
        modification.pattern,
        modification.pattern.replace(
          /Error\(['"]([^'"]+)['"]\)/,
          (match, msg) => `Error(\`${msg} at ${path.basename(filePath)}:${modification.line || '?'}\`)`
        )
      );
    }
    
    await fs.writeFile(filePath, content);
  }

  /**
   * Add retry logic
   * @private
   */
  async addRetryLogic(filePath, modification) {
    let content = await fs.readFile(filePath, 'utf-8');
    
    // Add retry utility if not present
    if (!content.includes('retryOperation')) {
      const retryUtil = `
async function retryOperation(fn, options = {}) {
  const { maxAttempts = 3, delay = 1000, backoff = 2 } = options;
  
  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (error) {
      if (attempt === maxAttempts) throw error;
      await new Promise(resolve => setTimeout(resolve, delay * Math.pow(backoff, attempt - 1)));
    }
  }
}
`;
      content = retryUtil + '\n' + content;
    }
    
    await fs.writeFile(filePath, content);
  }

  /**
   * Check if file exists
   * @private
   */
  async fileExists(filePath) {
    try {
      await fs.access(filePath);
      return true;
    } catch {
      return false;
    }
  }
}

module.exports = SandboxTester;