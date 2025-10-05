// @aios-fullstack/core - CommonJS Entry Point
const MetaAgent = require('./utils/component-generator.js');
const TaskManager = require('./utils/batch-creator.js');
const ElicitationEngine = require('./utils/elicitation-engine.js');
const TemplateEngine = require('./utils/template-engine.js');
const ComponentSearch = require('./utils/component-search.js');
const DependencyAnalyzer = require('./utils/dependency-analyzer.js');

module.exports = {
    MetaAgent: MetaAgent,
    TaskManager: TaskManager,
    ElicitationEngine: ElicitationEngine,
    TemplateEngine: TemplateEngine,
    ComponentSearch: ComponentSearch,
    DependencyAnalyzer: DependencyAnalyzer
};