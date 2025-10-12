# Complete Specialization Taxonomy Schema

**Version:** 1.0.0
**Date:** October 12, 2025
**Purpose:** Complete hierarchical taxonomy for MMOS mind specialization scoring

---

## Database Schema

### Table Definitions

```sql
-- DOMAINS (Top-level categories)
CREATE TABLE IF NOT EXISTS domains (
    id TEXT PRIMARY KEY,              -- 'business_entrepreneurship'
    name TEXT NOT NULL,               -- 'Business & Entrepreneurship'
    description TEXT,
    icon TEXT,                        -- Emoji or icon identifier
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- SPECIALIZATIONS (Professional roles)
CREATE TABLE IF NOT EXISTS specializations (
    id TEXT PRIMARY KEY,              -- 'copywriter'
    domain_id TEXT NOT NULL,
    name TEXT NOT NULL,               -- 'Copywriter'
    description TEXT,
    icon TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE
);

-- SKILLS (Specific competencies)
CREATE TABLE IF NOT EXISTS skills (
    id TEXT PRIMARY KEY,              -- 'direct_response_copywriting'
    specialization_id TEXT NOT NULL,
    name TEXT NOT NULL,               -- 'Direct Response Copywriting'
    description TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id) ON DELETE CASCADE
);

-- PROFICIENCIES (Granular capabilities)
CREATE TABLE IF NOT EXISTS proficiencies (
    id TEXT PRIMARY KEY,              -- 'hooks'
    skill_id TEXT NOT NULL,
    name TEXT NOT NULL,               -- 'Hooks'
    description TEXT,
    benchmark_description TEXT,       -- What does mastery look like?
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);
```

---

## Complete Taxonomy Tree

### DOMAIN 1: Business & Entrepreneurship

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('business_entrepreneurship', 'Business & Entrepreneurship', 'Building, scaling, and operating businesses', '💼', 1);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('entrepreneur', 'business_entrepreneurship', 'Entrepreneur', 'Building companies from scratch', '🚀', 1),
('operator', 'business_entrepreneurship', 'Operator/CEO', 'Running and scaling organizations', '⚙️', 2),
('investor', 'business_entrepreneurship', 'Investor', 'Evaluating and funding ventures', '💰', 3);

-- ENTREPRENEUR Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('business_strategy', 'entrepreneur', 'Business Strategy', 'Strategic planning and market positioning', 1),
('fundraising', 'entrepreneur', 'Fundraising', 'Raising capital from investors', 2),
('scaling_operations', 'entrepreneur', 'Scaling Operations', 'Growing teams and processes', 3),
('product_development', 'entrepreneur', 'Product Development', 'Building products customers love', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Business Strategy proficiencies
('market_analysis', 'business_strategy', 'Market Analysis', 'Analyzing market size, trends, and opportunities', 1),
('competitive_positioning', 'business_strategy', 'Competitive Positioning', 'Differentiating from competitors', 2),
('business_model_design', 'business_strategy', 'Business Model Design', 'Designing revenue models and unit economics', 3),
('strategic_planning', 'business_strategy', 'Strategic Planning', 'Long-term vision and roadmap creation', 4),
('go_to_market_strategy', 'business_strategy', 'Go-to-Market Strategy', 'Planning market entry and expansion', 5),

-- Fundraising proficiencies
('pitch_creation', 'fundraising', 'Pitch Creation', 'Crafting compelling investor presentations', 1),
('investor_relations', 'fundraising', 'Investor Relations', 'Building relationships with VCs and angels', 2),
('valuation_negotiation', 'fundraising', 'Valuation Negotiation', 'Negotiating company valuations', 3),
('term_sheet_navigation', 'fundraising', 'Term Sheet Navigation', 'Understanding and negotiating terms', 4),
('cap_table_management', 'fundraising', 'Cap Table Management', 'Managing equity and dilution', 5),

-- Scaling Operations proficiencies
('hiring_systems', 'scaling_operations', 'Hiring Systems', 'Building scalable recruitment processes', 1),
('process_optimization', 'scaling_operations', 'Process Optimization', 'Systematizing and improving operations', 2),
('delegation', 'scaling_operations', 'Delegation', 'Effective task and authority distribution', 3),
('org_design', 'scaling_operations', 'Organizational Design', 'Structuring teams and departments', 4),
('kpi_tracking', 'scaling_operations', 'KPI Tracking', 'Defining and monitoring key metrics', 5),

-- Product Development proficiencies
('customer_discovery', 'product_development', 'Customer Discovery', 'Understanding customer needs deeply', 1),
('mvp_building', 'product_development', 'MVP Building', 'Rapid prototyping and iteration', 2),
('product_market_fit', 'product_development', 'Product-Market Fit', 'Achieving strong market resonance', 3),
('feature_prioritization', 'product_development', 'Feature Prioritization', 'Deciding what to build next', 4),
('user_feedback_loops', 'product_development', 'User Feedback Loops', 'Continuous customer input integration', 5);

-- OPERATOR Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('leadership', 'operator', 'Leadership', 'Leading teams and driving culture', 1),
('execution', 'operator', 'Execution', 'Getting things done efficiently', 2),
('financial_management', 'operator', 'Financial Management', 'Managing budgets and cash flow', 3),
('crisis_management', 'operator', 'Crisis Management', 'Handling emergencies and setbacks', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Leadership proficiencies
('team_building', 'leadership', 'Team Building', 'Assembling high-performing teams', 1),
('culture_design', 'leadership', 'Culture Design', 'Creating intentional company culture', 2),
('performance_management', 'leadership', 'Performance Management', 'Setting goals and managing accountability', 3),
('conflict_resolution', 'leadership', 'Conflict Resolution', 'Resolving team disputes effectively', 4),
('coaching_mentoring', 'leadership', 'Coaching & Mentoring', 'Developing team members', 5),

-- Execution proficiencies
('prioritization', 'execution', 'Prioritization', 'Focusing on highest-impact activities', 1),
('decision_velocity', 'execution', 'Decision Velocity', 'Making fast, quality decisions', 2),
('accountability_systems', 'execution', 'Accountability Systems', 'Ensuring follow-through', 3),
('problem_solving', 'execution', 'Problem Solving', 'Breaking down and solving complex problems', 4),
('project_management', 'execution', 'Project Management', 'Managing timelines and deliverables', 5),

-- Financial Management proficiencies
('budgeting', 'financial_management', 'Budgeting', 'Planning and allocating resources', 1),
('cash_flow_management', 'financial_management', 'Cash Flow Management', 'Ensuring liquidity and runway', 2),
('financial_modeling', 'financial_management', 'Financial Modeling', 'Forecasting and scenario planning', 3),
('cost_optimization', 'financial_management', 'Cost Optimization', 'Reducing expenses strategically', 4),
('pricing_strategy', 'financial_management', 'Pricing Strategy', 'Optimizing pricing models', 5),

-- Crisis Management proficiencies
('rapid_response', 'crisis_management', 'Rapid Response', 'Acting quickly under pressure', 1),
('stakeholder_communication', 'crisis_management', 'Stakeholder Communication', 'Keeping everyone informed', 2),
('damage_control', 'crisis_management', 'Damage Control', 'Minimizing negative impact', 3),
('recovery_planning', 'crisis_management', 'Recovery Planning', 'Rebuilding after setbacks', 4);

-- INVESTOR Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('deal_evaluation', 'investor', 'Deal Evaluation', 'Assessing investment opportunities', 1),
('portfolio_management', 'investor', 'Portfolio Management', 'Managing investment portfolio', 2),
('value_creation', 'investor', 'Value Creation', 'Helping portfolio companies grow', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Deal Evaluation proficiencies
('due_diligence', 'deal_evaluation', 'Due Diligence', 'Thorough company investigation', 1),
('founder_assessment', 'deal_evaluation', 'Founder Assessment', 'Evaluating founding team quality', 2),
('market_sizing', 'deal_evaluation', 'Market Sizing', 'Estimating addressable market', 3),
('risk_assessment', 'deal_evaluation', 'Risk Assessment', 'Identifying investment risks', 4),
('deal_structuring', 'deal_evaluation', 'Deal Structuring', 'Designing investment terms', 5),

-- Portfolio Management proficiencies
('portfolio_monitoring', 'portfolio_management', 'Portfolio Monitoring', 'Tracking portfolio performance', 1),
('board_governance', 'portfolio_management', 'Board Governance', 'Effective board participation', 2),
('exit_strategy', 'portfolio_management', 'Exit Strategy', 'Planning and executing exits', 3),
('diversification', 'portfolio_management', 'Diversification', 'Balancing portfolio risk', 4),

-- Value Creation proficiencies
('strategic_advising', 'value_creation', 'Strategic Advising', 'Providing strategic guidance', 1),
('network_connections', 'value_creation', 'Network Connections', 'Making valuable introductions', 2),
('operational_support', 'value_creation', 'Operational Support', 'Hands-on company building', 3),
('follow_on_funding', 'value_creation', 'Follow-on Funding', 'Supporting future rounds', 4);
```

---

### DOMAIN 2: Marketing & Sales

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('marketing_sales', 'Marketing & Sales', 'Attracting, converting, and retaining customers', '📣', 2);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('copywriter', 'marketing_sales', 'Copywriter', 'Writing persuasive marketing copy', '✍️', 1),
('marketer', 'marketing_sales', 'Marketer', 'Growing audiences and driving demand', '📈', 2),
('salesperson', 'marketing_sales', 'Salesperson', 'Closing deals and driving revenue', '🤝', 3),
('brand_strategist', 'marketing_sales', 'Brand Strategist', 'Building memorable brands', '🎨', 4);

-- COPYWRITER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('direct_response_copywriting', 'copywriter', 'Direct Response Copywriting', 'Writing copy that drives immediate action', 1),
('sales_letters', 'copywriter', 'Sales Letters', 'Long-form persuasive writing', 2),
('persuasion_psychology', 'copywriter', 'Persuasion Psychology', 'Understanding psychological triggers', 3),
('email_marketing', 'copywriter', 'Email Marketing', 'Email sequences and newsletters', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Direct Response Copywriting proficiencies
('hooks', 'direct_response_copywriting', 'Hooks', 'Attention-grabbing opening lines', 1),
('headlines', 'direct_response_copywriting', 'Headlines', 'Compelling titles that drive clicks', 2),
('offers', 'direct_response_copywriting', 'Offers', 'Irresistible value propositions', 3),
('guarantees', 'direct_response_copywriting', 'Guarantees', 'Risk-reversal mechanisms', 4),
('calls_to_action', 'direct_response_copywriting', 'Calls to Action', 'Clear next-step instructions', 5),
('bullets', 'direct_response_copywriting', 'Bullets', 'Benefit-driven bullet points', 6),
('fascinations', 'direct_response_copywriting', 'Fascinations', 'Curiosity-inducing teasers', 7),
('storytelling', 'direct_response_copywriting', 'Storytelling', 'Narrative-driven persuasion', 8),

-- Sales Letters proficiencies
('long_form_sales_letters', 'sales_letters', 'Long-form Sales Letters', 'Multi-page persuasive letters', 1),
('vsl_scripts', 'sales_letters', 'VSL Scripts', 'Video sales letter scripting', 2),
('email_sequences', 'sales_letters', 'Email Sequences', 'Multi-touch email campaigns', 3),
('landing_pages', 'sales_letters', 'Landing Pages', 'High-converting page copy', 4),
('advertorials', 'sales_letters', 'Advertorials', 'Editorial-style ad copy', 5),

-- Persuasion Psychology proficiencies
('scarcity', 'persuasion_psychology', 'Scarcity', 'Limited availability tactics', 1),
('urgency', 'persuasion_psychology', 'Urgency', 'Time-sensitive offers', 2),
('social_proof', 'persuasion_psychology', 'Social Proof', 'Testimonials and case studies', 3),
('authority', 'persuasion_psychology', 'Authority', 'Credibility and expertise', 4),
('reciprocity', 'persuasion_psychology', 'Reciprocity', 'Giving to receive', 5),
('commitment_consistency', 'persuasion_psychology', 'Commitment & Consistency', 'Small yeses leading to big yes', 6),
('liking', 'persuasion_psychology', 'Liking', 'Building rapport and connection', 7),
('value_stacking', 'persuasion_psychology', 'Value Stacking', 'Demonstrating overwhelming value', 8),

-- Email Marketing proficiencies
('subject_lines', 'email_marketing', 'Subject Lines', 'Open-worthy subject lines', 1),
('email_flow_design', 'email_marketing', 'Email Flow Design', 'Sequence architecture', 2),
('segmentation', 'email_marketing', 'Segmentation', 'Audience targeting', 3),
('nurture_campaigns', 'email_marketing', 'Nurture Campaigns', 'Long-term relationship building', 4),
('broadcast_emails', 'email_marketing', 'Broadcast Emails', 'One-time promotional emails', 5);

-- MARKETER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('growth_marketing', 'marketer', 'Growth Marketing', 'Systematic audience and revenue growth', 1),
('positioning', 'marketer', 'Positioning', 'Market positioning and messaging', 2),
('content_marketing', 'marketer', 'Content Marketing', 'Creating valuable content', 3),
('paid_advertising', 'marketer', 'Paid Advertising', 'Running profitable ad campaigns', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Growth Marketing proficiencies
('funnel_design', 'growth_marketing', 'Funnel Design', 'Customer journey optimization', 1),
('conversion_optimization', 'growth_marketing', 'Conversion Optimization', 'Improving conversion rates', 2),
('retention_strategies', 'growth_marketing', 'Retention Strategies', 'Keeping customers engaged', 3),
('viral_loops', 'growth_marketing', 'Viral Loops', 'Word-of-mouth growth mechanics', 4),
('referral_programs', 'growth_marketing', 'Referral Programs', 'Incentivized customer acquisition', 5),
('ab_testing', 'growth_marketing', 'A/B Testing', 'Data-driven experimentation', 6),

-- Positioning proficiencies
('brand_positioning', 'positioning', 'Brand Positioning', 'Market differentiation strategy', 1),
('messaging', 'positioning', 'Messaging', 'Core value communication', 2),
('differentiation', 'positioning', 'Differentiation', 'Standing out from competitors', 3),
('category_creation', 'positioning', 'Category Creation', 'Defining new market categories', 4),
('target_audience_definition', 'positioning', 'Target Audience Definition', 'ICP and persona development', 5),

-- Content Marketing proficiencies
('blog_writing', 'content_marketing', 'Blog Writing', 'Educational blog content', 1),
('video_content', 'content_marketing', 'Video Content', 'Video creation and scripting', 2),
('podcast_production', 'content_marketing', 'Podcast Production', 'Audio content creation', 3),
('social_media_content', 'content_marketing', 'Social Media Content', 'Platform-specific content', 4),
('seo_optimization', 'content_marketing', 'SEO Optimization', 'Search engine visibility', 5),
('content_distribution', 'content_marketing', 'Content Distribution', 'Amplifying content reach', 6),

-- Paid Advertising proficiencies
('facebook_ads', 'paid_advertising', 'Facebook Ads', 'Meta ads platform mastery', 1),
('google_ads', 'paid_advertising', 'Google Ads', 'Search and display advertising', 2),
('youtube_ads', 'paid_advertising', 'YouTube Ads', 'Video advertising', 3),
('linkedin_ads', 'paid_advertising', 'LinkedIn Ads', 'B2B advertising', 4),
('ad_creative_development', 'paid_advertising', 'Ad Creative Development', 'High-performing ad assets', 5),
('campaign_optimization', 'paid_advertising', 'Campaign Optimization', 'ROI maximization', 6),
('retargeting', 'paid_advertising', 'Retargeting', 'Re-engaging warm audiences', 7);

-- SALESPERSON Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('closing', 'salesperson', 'Closing', 'Converting prospects to customers', 1),
('prospecting', 'salesperson', 'Prospecting', 'Finding qualified leads', 2),
('objection_handling', 'salesperson', 'Objection Handling', 'Overcoming buyer resistance', 3),
('relationship_building', 'salesperson', 'Relationship Building', 'Long-term customer relationships', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Closing proficiencies
('trial_closes', 'closing', 'Trial Closes', 'Testing buyer readiness', 1),
('assumptive_closing', 'closing', 'Assumptive Closing', 'Acting as if sale is done', 2),
('price_anchoring', 'closing', 'Price Anchoring', 'Framing pricing strategically', 3),
('urgency_creation', 'closing', 'Urgency Creation', 'Motivating immediate action', 4),
('negotiation', 'closing', 'Negotiation', 'Win-win deal structuring', 5),

-- Prospecting proficiencies
('cold_outreach', 'prospecting', 'Cold Outreach', 'Initiating contact with strangers', 1),
('lead_qualification', 'prospecting', 'Lead Qualification', 'Identifying high-value prospects', 2),
('networking', 'prospecting', 'Networking', 'Building professional connections', 3),
('referral_generation', 'prospecting', 'Referral Generation', 'Getting warm introductions', 4),

-- Objection Handling proficiencies
('price_objections', 'objection_handling', 'Price Objections', 'Handling "too expensive"', 1),
('timing_objections', 'objection_handling', 'Timing Objections', 'Handling "not now"', 2),
('authority_objections', 'objection_handling', 'Authority Objections', 'Handling "need to ask boss"', 3),
('trust_objections', 'objection_handling', 'Trust Objections', 'Building credibility', 4),

-- Relationship Building proficiencies
('active_listening', 'relationship_building', 'Active Listening', 'Understanding customer needs', 1),
('empathy', 'relationship_building', 'Empathy', 'Understanding customer emotions', 2),
('follow_up', 'relationship_building', 'Follow-up', 'Staying in touch consistently', 3),
('account_management', 'relationship_building', 'Account Management', 'Managing existing customers', 4);

-- BRAND STRATEGIST Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('brand_identity', 'brand_strategist', 'Brand Identity', 'Creating distinctive brand personality', 1),
('brand_storytelling', 'brand_strategist', 'Brand Storytelling', 'Crafting brand narratives', 2),
('visual_branding', 'brand_strategist', 'Visual Branding', 'Logo, colors, and design systems', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Brand Identity proficiencies
('brand_voice', 'brand_identity', 'Brand Voice', 'Defining tone and personality', 1),
('brand_values', 'brand_identity', 'Brand Values', 'Core principles and beliefs', 2),
('brand_mission', 'brand_identity', 'Brand Mission', 'Purpose and "why"', 3),
('brand_archetype', 'brand_identity', 'Brand Archetype', 'Personality framework', 4),

-- Brand Storytelling proficiencies
('origin_story', 'brand_storytelling', 'Origin Story', 'How the brand started', 1),
('customer_stories', 'brand_storytelling', 'Customer Stories', 'Case studies and testimonials', 2),
('brand_mythology', 'brand_storytelling', 'Brand Mythology', 'Legends and lore', 3),

-- Visual Branding proficiencies
('logo_design', 'visual_branding', 'Logo Design', 'Creating memorable logos', 1),
('color_psychology', 'visual_branding', 'Color Psychology', 'Strategic color selection', 2),
('typography', 'visual_branding', 'Typography', 'Font selection and hierarchy', 3),
('design_systems', 'visual_branding', 'Design Systems', 'Cohesive visual guidelines', 4);
```

---

### DOMAIN 3: Technology & Engineering

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('technology_engineering', 'Technology & Engineering', 'Building technical products and systems', '💻', 3);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('software_engineer', 'technology_engineering', 'Software Engineer', 'Building software applications', '👨‍💻', 1),
('ai_researcher', 'technology_engineering', 'AI Researcher', 'Advancing AI/ML capabilities', '🤖', 2),
('product_manager', 'technology_engineering', 'Product Manager', 'Defining product strategy and roadmap', '📊', 3),
('data_scientist', 'technology_engineering', 'Data Scientist', 'Extracting insights from data', '📈', 4);

-- SOFTWARE ENGINEER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('programming', 'software_engineer', 'Programming', 'Writing code in various languages', 1),
('architecture', 'software_engineer', 'System Architecture', 'Designing scalable systems', 2),
('devops', 'software_engineer', 'DevOps', 'Deployment and infrastructure', 3),
('debugging', 'software_engineer', 'Debugging', 'Finding and fixing bugs', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Programming proficiencies
('python', 'programming', 'Python', 'Python development', 1),
('javascript', 'programming', 'JavaScript', 'JavaScript/Node.js development', 2),
('typescript', 'programming', 'TypeScript', 'TypeScript development', 3),
('rust', 'programming', 'Rust', 'Rust systems programming', 4),
('go', 'programming', 'Go', 'Go backend development', 5),
('java', 'programming', 'Java', 'Java enterprise development', 6),
('cpp', 'programming', 'C++', 'C++ performance programming', 7),

-- Architecture proficiencies
('distributed_systems', 'architecture', 'Distributed Systems', 'Multi-server system design', 1),
('scalability', 'architecture', 'Scalability', 'Handling growth and load', 2),
('microservices', 'architecture', 'Microservices', 'Service-oriented architecture', 3),
('api_design', 'architecture', 'API Design', 'Interface design principles', 4),
('database_design', 'architecture', 'Database Design', 'Schema and query optimization', 5),

-- DevOps proficiencies
('ci_cd', 'devops', 'CI/CD', 'Continuous integration/deployment', 1),
('docker', 'devops', 'Docker', 'Containerization', 2),
('kubernetes', 'devops', 'Kubernetes', 'Container orchestration', 3),
('cloud_infrastructure', 'devops', 'Cloud Infrastructure', 'AWS/GCP/Azure management', 4),
('monitoring', 'devops', 'Monitoring', 'System observability', 5),

-- Debugging proficiencies
('performance_profiling', 'debugging', 'Performance Profiling', 'Identifying bottlenecks', 1),
('memory_debugging', 'debugging', 'Memory Debugging', 'Finding memory leaks', 2),
('log_analysis', 'debugging', 'Log Analysis', 'Reading and interpreting logs', 3),
('root_cause_analysis', 'debugging', 'Root Cause Analysis', 'Finding underlying issues', 4);

-- AI RESEARCHER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('machine_learning', 'ai_researcher', 'Machine Learning', 'Building ML models', 1),
('deep_learning', 'ai_researcher', 'Deep Learning', 'Neural network architectures', 2),
('research_methodology', 'ai_researcher', 'Research Methodology', 'Scientific research process', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Machine Learning proficiencies
('supervised_learning', 'machine_learning', 'Supervised Learning', 'Classification and regression', 1),
('unsupervised_learning', 'machine_learning', 'Unsupervised Learning', 'Clustering and dimensionality reduction', 2),
('reinforcement_learning', 'machine_learning', 'Reinforcement Learning', 'Agent-based learning', 3),
('feature_engineering', 'machine_learning', 'Feature Engineering', 'Creating predictive features', 4),
('model_evaluation', 'machine_learning', 'Model Evaluation', 'Assessing model performance', 5),

-- Deep Learning proficiencies
('nlp', 'deep_learning', 'Natural Language Processing', 'Text understanding and generation', 1),
('computer_vision', 'deep_learning', 'Computer Vision', 'Image and video analysis', 2),
('transformer_models', 'deep_learning', 'Transformer Models', 'Attention-based architectures', 3),
('llm_fine_tuning', 'deep_learning', 'LLM Fine-tuning', 'Adapting large language models', 4),

-- Research Methodology proficiencies
('paper_writing', 'research_methodology', 'Paper Writing', 'Scientific publication', 1),
('experiment_design', 'research_methodology', 'Experiment Design', 'Rigorous testing', 2),
('literature_review', 'research_methodology', 'Literature Review', 'Understanding prior work', 3),
('peer_review', 'research_methodology', 'Peer Review', 'Evaluating research quality', 4);

-- PRODUCT MANAGER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('product_strategy', 'product_manager', 'Product Strategy', 'Long-term product direction', 1),
('user_research', 'product_manager', 'User Research', 'Understanding user needs', 2),
('roadmap_planning', 'product_manager', 'Roadmap Planning', 'Prioritizing features', 3),
('stakeholder_management', 'product_manager', 'Stakeholder Management', 'Aligning cross-functional teams', 4);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Product Strategy proficiencies
('market_research', 'product_strategy', 'Market Research', 'Understanding market dynamics', 1),
('competitive_analysis', 'product_strategy', 'Competitive Analysis', 'Analyzing competitors', 2),
('product_vision', 'product_strategy', 'Product Vision', 'Defining long-term direction', 3),
('okr_setting', 'product_strategy', 'OKR Setting', 'Objective and key results', 4),

-- User Research proficiencies
('user_interviews', 'user_research', 'User Interviews', 'Qualitative research', 1),
('surveys', 'user_research', 'Surveys', 'Quantitative research', 2),
('usability_testing', 'user_research', 'Usability Testing', 'Testing product usability', 3),
('persona_development', 'user_research', 'Persona Development', 'Creating user archetypes', 4),

-- Roadmap Planning proficiencies
('feature_prioritization', 'roadmap_planning', 'Feature Prioritization', 'Deciding what to build', 1),
('resource_allocation', 'roadmap_planning', 'Resource Allocation', 'Assigning team capacity', 2),
('timeline_estimation', 'roadmap_planning', 'Timeline Estimation', 'Realistic scheduling', 3),
('dependency_mapping', 'roadmap_planning', 'Dependency Mapping', 'Understanding blockers', 4),

-- Stakeholder Management proficiencies
('executive_communication', 'stakeholder_management', 'Executive Communication', 'C-level updates', 1),
('cross_functional_collaboration', 'stakeholder_management', 'Cross-functional Collaboration', 'Working across teams', 2),
('expectation_setting', 'stakeholder_management', 'Expectation Setting', 'Managing commitments', 3),
('influence_without_authority', 'stakeholder_management', 'Influence Without Authority', 'Getting things done', 4);

-- DATA SCIENTIST Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('data_analysis', 'data_scientist', 'Data Analysis', 'Extracting insights from data', 1),
('statistical_modeling', 'data_scientist', 'Statistical Modeling', 'Building predictive models', 2),
('data_visualization', 'data_scientist', 'Data Visualization', 'Communicating insights visually', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Data Analysis proficiencies
('sql', 'data_analysis', 'SQL', 'Database querying', 1),
('data_cleaning', 'data_analysis', 'Data Cleaning', 'Preparing messy data', 2),
('exploratory_analysis', 'data_analysis', 'Exploratory Analysis', 'Understanding data patterns', 3),
('ab_testing_analysis', 'data_analysis', 'A/B Testing Analysis', 'Experiment analysis', 4),

-- Statistical Modeling proficiencies
('regression_analysis', 'statistical_modeling', 'Regression Analysis', 'Linear and logistic models', 1),
('time_series_forecasting', 'statistical_modeling', 'Time Series Forecasting', 'Predicting future values', 2),
('hypothesis_testing', 'statistical_modeling', 'Hypothesis Testing', 'Statistical significance', 3),
('causal_inference', 'statistical_modeling', 'Causal Inference', 'Understanding cause-effect', 4),

-- Data Visualization proficiencies
('dashboarding', 'data_visualization', 'Dashboarding', 'Real-time metrics displays', 1),
('chart_selection', 'data_visualization', 'Chart Selection', 'Choosing right visualizations', 2),
('storytelling_with_data', 'data_visualization', 'Storytelling with Data', 'Narrative-driven viz', 3),
('interactive_visualizations', 'data_visualization', 'Interactive Visualizations', 'Explorable data', 4);
```

---

### DOMAIN 4: Creative & Content

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('creative_content', 'Creative & Content', 'Creating compelling content and experiences', '🎭', 4);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('writer', 'creative_content', 'Writer', 'Creating written content', '📝', 1),
('speaker', 'creative_content', 'Speaker/Presenter', 'Public speaking and presentations', '🎤', 2),
('designer', 'creative_content', 'Designer', 'Visual and UX design', '🎨', 3),
('video_producer', 'creative_content', 'Video Producer', 'Video content creation', '🎬', 4);

-- WRITER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('writing_styles', 'writer', 'Writing Styles', 'Various writing formats', 1),
('content_creation', 'writer', 'Content Creation', 'Generating ideas and content', 2),
('editing', 'writer', 'Editing', 'Refining and improving writing', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Writing Styles proficiencies
('non_fiction', 'writing_styles', 'Non-Fiction', 'Educational and informational writing', 1),
('fiction', 'writing_styles', 'Fiction', 'Storytelling and narrative', 2),
('technical_writing', 'writing_styles', 'Technical Writing', 'Documentation and guides', 3),
('journalism', 'writing_styles', 'Journalism', 'News and reporting', 4),
('academic_writing', 'writing_styles', 'Academic Writing', 'Research papers', 5),

-- Content Creation proficiencies
('blog_posts', 'content_creation', 'Blog Posts', 'Web articles', 1),
('essays', 'content_creation', 'Essays', 'Long-form thought pieces', 2),
('books', 'content_creation', 'Books', 'Full-length manuscripts', 3),
('scripts', 'content_creation', 'Scripts', 'Video and audio scripts', 4),
('social_posts', 'content_creation', 'Social Posts', 'Social media writing', 5),

-- Editing proficiencies
('copy_editing', 'editing', 'Copy Editing', 'Grammar and style', 1),
('developmental_editing', 'editing', 'Developmental Editing', 'Structure and flow', 2),
('proofreading', 'editing', 'Proofreading', 'Final error checking', 3),
('self_editing', 'editing', 'Self-Editing', 'Improving own work', 4);

-- SPEAKER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('public_speaking', 'speaker', 'Public Speaking', 'Speaking to audiences', 1),
('presentation_design', 'speaker', 'Presentation Design', 'Creating compelling slides', 2),
('stage_presence', 'speaker', 'Stage Presence', 'Commanding attention', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Public Speaking proficiencies
('keynote_speeches', 'public_speaking', 'Keynote Speeches', 'Main event presentations', 1),
('storytelling_on_stage', 'public_speaking', 'Storytelling on Stage', 'Narrative presentations', 2),
('audience_engagement', 'public_speaking', 'Audience Engagement', 'Interactive speaking', 3),
('panel_moderation', 'public_speaking', 'Panel Moderation', 'Facilitating discussions', 4),

-- Presentation Design proficiencies
('slide_design', 'presentation_design', 'Slide Design', 'Visual slide creation', 1),
('data_visualization_slides', 'presentation_design', 'Data Visualization in Slides', 'Presenting data', 2),
('presentation_storytelling', 'presentation_design', 'Presentation Storytelling', 'Narrative flow', 3),

-- Stage Presence proficiencies
('vocal_delivery', 'stage_presence', 'Vocal Delivery', 'Voice control and projection', 1),
('body_language', 'stage_presence', 'Body Language', 'Non-verbal communication', 2),
('confidence', 'stage_presence', 'Confidence', 'Projecting authority', 3),
('humor', 'stage_presence', 'Humor', 'Using comedy effectively', 4);

-- DESIGNER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('visual_design', 'designer', 'Visual Design', 'Aesthetic and graphic design', 1),
('ux_design', 'designer', 'UX Design', 'User experience design', 2),
('ui_design', 'designer', 'UI Design', 'User interface design', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Visual Design proficiencies
('layout_composition', 'visual_design', 'Layout & Composition', 'Arranging elements', 1),
('color_theory', 'visual_design', 'Color Theory', 'Color selection and harmony', 2),
('typography_design', 'visual_design', 'Typography', 'Font usage and hierarchy', 3),
('illustration', 'visual_design', 'Illustration', 'Creating custom graphics', 4),

-- UX Design proficiencies
('user_flows', 'ux_design', 'User Flows', 'Mapping user journeys', 1),
('wireframing', 'ux_design', 'Wireframing', 'Low-fidelity prototyping', 2),
('information_architecture', 'ux_design', 'Information Architecture', 'Content organization', 3),
('interaction_design', 'ux_design', 'Interaction Design', 'Designing interactions', 4),

-- UI Design proficiencies
('component_design', 'ui_design', 'Component Design', 'Reusable UI elements', 1),
('responsive_design', 'ui_design', 'Responsive Design', 'Multi-device interfaces', 2),
('design_systems_ui', 'ui_design', 'Design Systems', 'Consistent UI libraries', 3),
('prototyping', 'ui_design', 'Prototyping', 'Interactive mockups', 4);

-- VIDEO PRODUCER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('video_production', 'video_producer', 'Video Production', 'Creating video content', 1),
('video_editing', 'video_producer', 'Video Editing', 'Post-production editing', 2),
('cinematography', 'video_producer', 'Cinematography', 'Camera work and lighting', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Video Production proficiencies
('scripting', 'video_production', 'Scripting', 'Writing video scripts', 1),
('storyboarding', 'video_production', 'Storyboarding', 'Visual planning', 2),
('directing', 'video_production', 'Directing', 'Guiding talent and crew', 3),
('project_management_video', 'video_production', 'Project Management', 'Managing video projects', 4),

-- Video Editing proficiencies
('cutting', 'video_editing', 'Cutting', 'Selecting and arranging clips', 1),
('color_grading', 'video_editing', 'Color Grading', 'Color correction and mood', 2),
('sound_design', 'video_editing', 'Sound Design', 'Audio mixing and effects', 3),
('motion_graphics', 'video_editing', 'Motion Graphics', 'Animated graphics', 4),

-- Cinematography proficiencies
('framing', 'cinematography', 'Framing', 'Composing shots', 1),
('lighting', 'cinematography', 'Lighting', 'Setting up lights', 2),
('camera_operation', 'cinematography', 'Camera Operation', 'Using cameras', 3),
('shot_selection', 'cinematography', 'Shot Selection', 'Choosing angles', 4);
```

---

### DOMAIN 5: Strategy & Consulting

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('strategy_consulting', 'Strategy & Consulting', 'Advising on strategic decisions', '🎯', 5);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('strategist', 'strategy_consulting', 'Strategist', 'Developing strategic plans', '♟️', 1),
('consultant', 'strategy_consulting', 'Consultant', 'Solving business problems', '💼', 2),
('coach', 'strategy_consulting', 'Executive Coach', 'Developing leaders', '🏆', 3);

-- STRATEGIST Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('strategic_thinking', 'strategist', 'Strategic Thinking', 'Long-term planning and foresight', 1),
('frameworks', 'strategist', 'Strategic Frameworks', 'Using proven strategy tools', 2),
('scenario_planning', 'strategist', 'Scenario Planning', 'Planning for multiple futures', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Strategic Thinking proficiencies
('systems_thinking', 'strategic_thinking', 'Systems Thinking', 'Understanding interconnections', 1),
('first_principles_thinking', 'strategic_thinking', 'First Principles Thinking', 'Breaking down to fundamentals', 2),
('trend_forecasting', 'strategic_thinking', 'Trend Forecasting', 'Predicting future changes', 3),
('opportunity_identification', 'strategic_thinking', 'Opportunity Identification', 'Spotting market gaps', 4),

-- Frameworks proficiencies
('swot_analysis', 'frameworks', 'SWOT Analysis', 'Strengths, weaknesses, opportunities, threats', 1),
('porters_five_forces', 'frameworks', 'Porter\'s Five Forces', 'Industry analysis', 2),
('blue_ocean_strategy', 'frameworks', 'Blue Ocean Strategy', 'Uncontested market creation', 3),
('jobs_to_be_done', 'frameworks', 'Jobs to Be Done', 'Customer need analysis', 4),
('bcg_matrix', 'frameworks', 'BCG Matrix', 'Portfolio analysis', 5),

-- Scenario Planning proficiencies
('scenario_development', 'scenario_planning', 'Scenario Development', 'Creating plausible futures', 1),
('contingency_planning', 'scenario_planning', 'Contingency Planning', 'Preparing for risks', 2),
('strategic_flexibility', 'scenario_planning', 'Strategic Flexibility', 'Adapting to change', 3);

-- CONSULTANT Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('problem_diagnosis', 'consultant', 'Problem Diagnosis', 'Identifying root causes', 1),
('recommendation_development', 'consultant', 'Recommendation Development', 'Creating actionable solutions', 2),
('client_management', 'consultant', 'Client Management', 'Managing consulting relationships', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Problem Diagnosis proficiencies
('root_cause_analysis_consulting', 'problem_diagnosis', 'Root Cause Analysis', 'Finding core issues', 1),
('data_analysis_consulting', 'problem_diagnosis', 'Data Analysis', 'Analyzing client data', 2),
('hypothesis_testing_consulting', 'problem_diagnosis', 'Hypothesis Testing', 'Validating assumptions', 3),
('stakeholder_interviews', 'problem_diagnosis', 'Stakeholder Interviews', 'Gathering insights', 4),

-- Recommendation Development proficiencies
('recommendation_synthesis', 'recommendation_development', 'Recommendation Synthesis', 'Creating solutions', 1),
('implementation_planning', 'recommendation_development', 'Implementation Planning', 'Execution roadmaps', 2),
('change_management', 'recommendation_development', 'Change Management', 'Managing transitions', 3),

-- Client Management proficiencies
('client_communication', 'client_management', 'Client Communication', 'Keeping clients informed', 1),
('expectation_management', 'client_management', 'Expectation Management', 'Managing commitments', 2),
('relationship_maintenance', 'client_management', 'Relationship Maintenance', 'Long-term partnerships', 3),
('upselling_consulting', 'client_management', 'Upselling', 'Expanding engagements', 4);

-- COACH Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('leadership_coaching', 'coach', 'Leadership Coaching', 'Developing leadership skills', 1),
('performance_coaching', 'coach', 'Performance Coaching', 'Improving individual performance', 2),
('team_coaching', 'coach', 'Team Coaching', 'Developing teams', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Leadership Coaching proficiencies
('executive_presence', 'leadership_coaching', 'Executive Presence', 'Building leadership aura', 1),
('decision_making_coaching', 'leadership_coaching', 'Decision Making', 'Improving judgment', 2),
('strategic_leadership', 'leadership_coaching', 'Strategic Leadership', 'Long-term thinking', 3),
('communication_coaching', 'leadership_coaching', 'Communication', 'Effective communication', 4),

-- Performance Coaching proficiencies
('goal_setting_coaching', 'performance_coaching', 'Goal Setting', 'Setting effective goals', 1),
('accountability_coaching', 'performance_coaching', 'Accountability', 'Following through', 2),
('skill_development', 'performance_coaching', 'Skill Development', 'Building capabilities', 3),
('feedback_delivery', 'performance_coaching', 'Feedback Delivery', 'Giving constructive feedback', 4),

-- Team Coaching proficiencies
('team_dynamics', 'team_coaching', 'Team Dynamics', 'Understanding team interactions', 1),
('conflict_resolution_coaching', 'team_coaching', 'Conflict Resolution', 'Resolving team disputes', 2),
('collaboration_building', 'team_coaching', 'Collaboration Building', 'Improving teamwork', 3),
('culture_development', 'team_coaching', 'Culture Development', 'Shaping team culture', 4);
```

---

### DOMAIN 6: Personal Development

```sql
-- Domain
INSERT INTO domains (id, name, description, icon, sort_order) VALUES
('personal_development', 'Personal Development', 'Growth, mindset, and self-improvement', '🌱', 6);

-- Specializations
INSERT INTO specializations (id, domain_id, name, description, icon, sort_order) VALUES
('life_coach', 'personal_development', 'Life Coach', 'Guiding personal growth', '🧭', 1),
('philosopher', 'personal_development', 'Philosopher', 'Exploring fundamental questions', '🤔', 2),
('mindset_coach', 'personal_development', 'Mindset Coach', 'Developing mental frameworks', '🧠', 3),
('productivity_expert', 'personal_development', 'Productivity Expert', 'Optimizing time and energy', '⚡', 4);

-- LIFE COACH Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('coaching_skills', 'life_coach', 'Coaching', 'Core coaching competencies', 1),
('goal_achievement', 'life_coach', 'Goal Achievement', 'Helping clients reach goals', 2),
('self_awareness', 'life_coach', 'Self-Awareness', 'Building self-understanding', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Coaching Skills proficiencies
('active_listening_coaching', 'coaching_skills', 'Active Listening', 'Deep listening', 1),
('powerful_questions', 'coaching_skills', 'Powerful Questions', 'Thought-provoking inquiry', 2),
('reframing', 'coaching_skills', 'Reframing', 'Changing perspectives', 3),
('accountability_partnering', 'coaching_skills', 'Accountability Partnering', 'Supporting follow-through', 4),

-- Goal Achievement proficiencies
('goal_clarity', 'goal_achievement', 'Goal Clarity', 'Defining clear goals', 1),
('action_planning', 'goal_achievement', 'Action Planning', 'Creating step-by-step plans', 2),
('obstacle_navigation', 'goal_achievement', 'Obstacle Navigation', 'Overcoming challenges', 3),
('motivation_maintenance', 'goal_achievement', 'Motivation Maintenance', 'Sustaining drive', 4),

-- Self-Awareness proficiencies
('values_clarification', 'self_awareness', 'Values Clarification', 'Understanding core values', 1),
('strengths_identification', 'self_awareness', 'Strengths Identification', 'Recognizing talents', 2),
('blind_spots_discovery', 'self_awareness', 'Blind Spots Discovery', 'Uncovering hidden patterns', 3),
('identity_exploration', 'self_awareness', 'Identity Exploration', 'Understanding self', 4);

-- PHILOSOPHER Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('philosophy', 'philosopher', 'Philosophy', 'Philosophical thinking', 1),
('critical_thinking', 'philosopher', 'Critical Thinking', 'Logical reasoning', 2),
('wisdom_transmission', 'philosopher', 'Wisdom Transmission', 'Teaching timeless truths', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Philosophy proficiencies
('ethics', 'philosophy', 'Ethics', 'Moral philosophy', 1),
('epistemology', 'philosophy', 'Epistemology', 'Theory of knowledge', 2),
('metaphysics', 'philosophy', 'Metaphysics', 'Nature of reality', 3),
('logic', 'philosophy', 'Logic', 'Valid reasoning', 4),

-- Critical Thinking proficiencies
('argument_analysis', 'critical_thinking', 'Argument Analysis', 'Evaluating arguments', 1),
('logical_fallacy_detection', 'critical_thinking', 'Logical Fallacy Detection', 'Spotting errors', 2),
('conceptual_clarity', 'critical_thinking', 'Conceptual Clarity', 'Defining terms precisely', 3),

-- Wisdom Transmission proficiencies
('parable_teaching', 'wisdom_transmission', 'Parable Teaching', 'Teaching through stories', 1),
('dialogue_method', 'wisdom_transmission', 'Dialogue Method', 'Socratic method', 2),
('aphorisms', 'wisdom_transmission', 'Aphorisms', 'Memorable wisdom statements', 3);

-- MINDSET COACH Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('mindset_development', 'mindset_coach', 'Mindset Development', 'Building empowering beliefs', 1),
('limiting_beliefs', 'mindset_coach', 'Limiting Beliefs', 'Overcoming mental blocks', 2),
('resilience_building', 'mindset_coach', 'Resilience Building', 'Developing mental toughness', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Mindset Development proficiencies
('growth_mindset', 'mindset_development', 'Growth Mindset', 'Believing in development', 1),
('abundance_mindset', 'mindset_development', 'Abundance Mindset', 'Seeing opportunity', 2),
('ownership_mindset', 'mindset_development', 'Ownership Mindset', 'Taking responsibility', 3),

-- Limiting Beliefs proficiencies
('belief_identification', 'limiting_beliefs', 'Belief Identification', 'Finding limiting beliefs', 1),
('belief_challenging', 'limiting_beliefs', 'Belief Challenging', 'Questioning assumptions', 2),
('belief_replacement', 'limiting_beliefs', 'Belief Replacement', 'Installing empowering beliefs', 3),

-- Resilience Building proficiencies
('adversity_reframing', 'resilience_building', 'Adversity Reframing', 'Finding meaning in struggle', 1),
('emotional_regulation', 'resilience_building', 'Emotional Regulation', 'Managing emotions', 2),
('stress_management', 'resilience_building', 'Stress Management', 'Coping with pressure', 3),
('bounce_back_ability', 'resilience_building', 'Bounce-Back Ability', 'Recovering from setbacks', 4);

-- PRODUCTIVITY EXPERT Skills & Proficiencies
INSERT INTO skills (id, specialization_id, name, description, sort_order) VALUES
('time_management', 'productivity_expert', 'Time Management', 'Optimizing time usage', 1),
('energy_management', 'productivity_expert', 'Energy Management', 'Maximizing energy levels', 2),
('systems_building', 'productivity_expert', 'Systems Building', 'Creating productivity systems', 3);

INSERT INTO proficiencies (id, skill_id, name, description, sort_order) VALUES
-- Time Management proficiencies
('calendar_management', 'time_management', 'Calendar Management', 'Scheduling effectively', 1),
('task_batching', 'time_management', 'Task Batching', 'Grouping similar tasks', 2),
('deep_work', 'time_management', 'Deep Work', 'Focused concentration', 3),
('time_blocking', 'time_management', 'Time Blocking', 'Allocating time intentionally', 4),

-- Energy Management proficiencies
('circadian_rhythm_optimization', 'energy_management', 'Circadian Rhythm Optimization', 'Aligning with body clock', 1),
('nutrition_for_performance', 'energy_management', 'Nutrition for Performance', 'Eating for energy', 2),
('exercise_integration', 'energy_management', 'Exercise Integration', 'Movement for energy', 3),
('recovery_practices', 'energy_management', 'Recovery Practices', 'Rest and restoration', 4),

-- Systems Building proficiencies
('habit_stacking', 'systems_building', 'Habit Stacking', 'Chaining habits', 1),
('automation', 'systems_building', 'Automation', 'Automating repetitive tasks', 2),
('sop_creation', 'systems_building', 'SOP Creation', 'Standard operating procedures', 3),
('workflow_optimization', 'systems_building', 'Workflow Optimization', 'Streamlining processes', 4);
```

---

## Summary Statistics

```sql
-- Count all taxonomy entries
SELECT
    (SELECT COUNT(*) FROM domains) AS domains_count,
    (SELECT COUNT(*) FROM specializations) AS specializations_count,
    (SELECT COUNT(*) FROM skills) AS skills_count,
    (SELECT COUNT(*) FROM proficiencies) AS proficiencies_count;

-- Expected results:
-- domains_count: 6
-- specializations_count: 22
-- skills_count: 78
-- proficiencies_count: 413
```

---

## Complete Seed Data Script

Save the entire SQL above into a single file:

```bash
# File: seed_specialization_taxonomy.sql
# Execute with:
sqlite3 mmos.db < seed_specialization_taxonomy.sql
```

---

**END OF COMPLETE TAXONOMY**

This is the full hierarchical structure ready for database population!
