/**
 * Component Preview System for AIOS-FULLSTACK
 * Generates formatted previews of components before creation
 * @module component-preview
 */

const chalk = require('chalk');
const yaml = require('js-yaml');
const diff = require('diff');
const hljs = require('highlight.js');

class ComponentPreview {
  constructor() {
    this.previewFormatters = {
      agent: this.formatAgentPreview.bind(this),
      task: this.formatTaskPreview.bind(this),
      workflow: this.formatWorkflowPreview.bind(this)
    };
  }

  /**
   * Generate preview for a component
   * @param {string} componentType - Type of component
   * @param {string} content - Generated content
   * @param {Object} metadata - Component metadata
   * @returns {string} Formatted preview
   */
  async generatePreview(componentType, content, metadata = {}) {
    const formatter = this.previewFormatters[componentType];
    if (!formatter) {
      throw new Error(`Unknown component type: ${componentType}`);
    }
    
    return formatter(content, metadata);
  }

  /**
   * Format agent preview with syntax highlighting
   * @private
   */
  formatAgentPreview(content, metadata) {
    const lines = [];
    
    // Header
    lines.push(chalk.blue.bold('\n╔══════════════════════════════════════════════════════════════╗'));
    lines.push(chalk.blue.bold('║                    AGENT PREVIEW                             ║'));
    lines.push(chalk.blue.bold('╚══════════════════════════════════════════════════════════════╝\n'));
    
    // Metadata
    if (metadata.name) {
      lines.push(chalk.gray('Name: ') + chalk.white.bold(metadata.name));
    }
    if (metadata.path) {
      lines.push(chalk.gray('Path: ') + chalk.cyan(metadata.path));
    }
    lines.push('');
    
    // Content with syntax highlighting
    const highlighted = this.highlightYAML(content);
    lines.push(chalk.gray('─'.repeat(60)));
    lines.push(highlighted);
    lines.push(chalk.gray('─'.repeat(60)));
    
    return lines.join('\n');
  }

  /**
   * Format task preview with markdown highlighting
   * @private
   */
  formatTaskPreview(content, metadata) {
    const lines = [];
    
    // Header
    lines.push(chalk.green.bold('\n╔══════════════════════════════════════════════════════════════╗'));
    lines.push(chalk.green.bold('║                     TASK PREVIEW                             ║'));
    lines.push(chalk.green.bold('╚══════════════════════════════════════════════════════════════╝\n'));
    
    // Metadata
    if (metadata.name) {
      lines.push(chalk.gray('Name: ') + chalk.white.bold(metadata.name));
    }
    if (metadata.path) {
      lines.push(chalk.gray('Path: ') + chalk.cyan(metadata.path));
    }
    lines.push('');
    
    // Content with markdown highlighting
    const highlighted = this.highlightMarkdown(content);
    lines.push(chalk.gray('─'.repeat(60)));
    lines.push(highlighted);
    lines.push(chalk.gray('─'.repeat(60)));
    
    return lines.join('\n');
  }

  /**
   * Format workflow preview
   * @private
   */
  formatWorkflowPreview(content, metadata) {
    const lines = [];
    
    // Header
    lines.push(chalk.magenta.bold('\n╔══════════════════════════════════════════════════════════════╗'));
    lines.push(chalk.magenta.bold('║                   WORKFLOW PREVIEW                           ║'));
    lines.push(chalk.magenta.bold('╚══════════════════════════════════════════════════════════════╝\n'));
    
    // Metadata
    if (metadata.name) {
      lines.push(chalk.gray('Name: ') + chalk.white.bold(metadata.name));
    }
    if (metadata.path) {
      lines.push(chalk.gray('Path: ') + chalk.cyan(metadata.path));
    }
    lines.push('');
    
    // Parse and display workflow structure
    try {
      const workflow = yaml.load(content);
      lines.push(chalk.yellow('Workflow Structure:'));
      lines.push(this.formatWorkflowStructure(workflow));
      lines.push('');
    } catch (error) {
      lines.push(chalk.red('Error parsing workflow: ' + error.message));
    }
    
    // Full content
    const highlighted = this.highlightYAML(content);
    lines.push(chalk.gray('─'.repeat(60)));
    lines.push(highlighted);
    lines.push(chalk.gray('─'.repeat(60)));
    
    return lines.join('\n');
  }

  /**
   * Format workflow structure overview
   * @private
   */
  formatWorkflowStructure(workflow) {
    const lines = [];
    
    if (workflow.workflow) {
      const w = workflow.workflow;
      lines.push(chalk.gray('  Type: ') + chalk.white(w.type || 'standard'));
      
      if (w.triggers && w.triggers.length > 0) {
        lines.push(chalk.gray('  Triggers:'));
        w.triggers.forEach(trigger => {
          lines.push(chalk.gray('    - ') + chalk.cyan(trigger.type || trigger));
        });
      }
      
      if (workflow.steps && workflow.steps.length > 0) {
        lines.push(chalk.gray('  Steps: ') + chalk.white(workflow.steps.length));
        workflow.steps.forEach((step, idx) => {
          lines.push(chalk.gray(`    ${idx + 1}. `) + chalk.cyan(step.name || step.id));
        });
      }
    }
    
    return lines.join('\n');
  }

  /**
   * Generate diff view for manifest updates
   * @param {string} oldContent - Current manifest content
   * @param {string} newContent - Updated manifest content
   * @returns {string} Colored diff output
   */
  generateManifestDiff(oldContent, newContent) {
    const lines = [];
    
    lines.push(chalk.yellow.bold('\n╔══════════════════════════════════════════════════════════════╗'));
    lines.push(chalk.yellow.bold('║                  MANIFEST CHANGES                            ║'));
    lines.push(chalk.yellow.bold('╚══════════════════════════════════════════════════════════════╝\n'));
    
    const changes = diff.diffLines(oldContent, newContent);
    
    changes.forEach(part => {
      const color = part.added ? chalk.green : part.removed ? chalk.red : chalk.gray;
      const prefix = part.added ? '+ ' : part.removed ? '- ' : '  ';
      
      part.value.split('\n').forEach(line => {
        if (line) {
          lines.push(color(prefix + line));
        }
      });
    });
    
    return lines.join('\n');
  }

  /**
   * Highlight YAML content
   * @private
   */
  highlightYAML(content) {
    try {
      // Simple YAML highlighting without external dependencies
      return content
        .split('\n')
        .map(line => {
          // Comments
          if (line.trim().startsWith('#')) {
            return chalk.gray(line);
          }
          
          // Keys
          const keyMatch = line.match(/^(\s*)([a-zA-Z_-]+):/);
          if (keyMatch) {
            return keyMatch[1] + chalk.cyan(keyMatch[2]) + chalk.gray(':') + 
                   line.substring(keyMatch[0].length);
          }
          
          // List items
          if (line.trim().startsWith('-')) {
            const listMatch = line.match(/^(\s*)(-)(.*)$/);
            if (listMatch) {
              return listMatch[1] + chalk.gray(listMatch[2]) + listMatch[3];
            }
          }
          
          // Strings
          const stringMatch = line.match(/:\s*["'](.+)["']/);
          if (stringMatch) {
            return line.replace(stringMatch[1], chalk.green(stringMatch[1]));
          }
          
          return line;
        })
        .join('\n');
    } catch (error) {
      return content; // Return unhighlighted on error
    }
  }

  /**
   * Highlight Markdown content
   * @private
   */
  highlightMarkdown(content) {
    try {
      return content
        .split('\n')
        .map(line => {
          // Headers
          if (line.match(/^#+\s/)) {
            return chalk.bold.blue(line);
          }
          
          // Code blocks
          if (line.trim().startsWith('```')) {
            return chalk.gray(line);
          }
          
          // Lists
          if (line.match(/^[\s]*[-*]\s/)) {
            return chalk.gray('• ') + line.substring(line.indexOf(' ') + 1);
          }
          
          // Bold
          line = line.replace(/\*\*(.+?)\*\*/g, chalk.bold('$1'));
          
          // Italic
          line = line.replace(/\*(.+?)\*/g, chalk.italic('$1'));
          
          // Code
          line = line.replace(/`(.+?)`/g, chalk.gray('`') + chalk.yellow('$1') + chalk.gray('`'));
          
          return line;
        })
        .join('\n');
    } catch (error) {
      return content; // Return unhighlighted on error
    }
  }

  /**
   * Save preview to file for later reference
   * @param {string} preview - Preview content
   * @param {string} outputPath - Path to save preview
   */
  async savePreviewToFile(preview, outputPath) {
    const fs = require('fs-extra');
    
    // Strip ANSI color codes for file output
    const cleanPreview = preview.replace(
      /[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g, 
      ''
    );
    
    await fs.writeFile(outputPath, cleanPreview, 'utf8');
  }

  /**
   * Create interactive confirmation prompt with preview
   * @param {string} preview - Preview content
   * @param {Object} options - Confirmation options
   * @returns {Promise<boolean>} User confirmation
   */
  async confirmWithPreview(preview, options = {}) {
    console.log(preview);
    console.log('');
    
    const inquirer = require('inquirer');
    const { confirm } = await inquirer.prompt([{
      type: 'confirm',
      name: 'confirm',
      message: options.message || 'Do you want to proceed with this component?',
      default: options.default !== false
    }]);
    
    return confirm;
  }

  /**
   * Generate summary statistics for preview
   * @param {string} content - Component content
   * @param {string} componentType - Type of component
   * @returns {Object} Statistics
   */
  getPreviewStats(content, componentType) {
    const stats = {
      lines: content.split('\n').length,
      characters: content.length,
      size: Buffer.byteLength(content, 'utf8')
    };
    
    switch (componentType) {
      case 'agent':
        try {
          const agent = yaml.load(content);
          stats.commands = agent.commands ? agent.commands.length : 0;
          stats.dependencies = 0;
          if (agent.dependencies) {
            Object.values(agent.dependencies).forEach(deps => {
              if (Array.isArray(deps)) stats.dependencies += deps.length;
            });
          }
        } catch (e) {}
        break;
        
      case 'task':
        stats.sections = (content.match(/^##\s/gm) || []).length;
        stats.codeBlocks = (content.match(/```/g) || []).length / 2;
        break;
        
      case 'workflow':
        try {
          const workflow = yaml.load(content);
          stats.steps = workflow.steps ? workflow.steps.length : 0;
          stats.triggers = workflow.workflow?.triggers ? workflow.workflow.triggers.length : 0;
        } catch (e) {}
        break;
    }
    
    return stats;
  }
}

module.exports = ComponentPreview;