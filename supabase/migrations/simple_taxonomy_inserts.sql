-- Simple INSERT migration - NO structure changes
-- Just inserts data into existing Supabase tables

-- Domains (6 rows)
INSERT INTO domains (code, name, description) VALUES ('business_entrepreneurship', 'Business & Entrepreneurship', 'Building, scaling, and operating businesses') ON CONFLICT (code) DO NOTHING;
INSERT INTO domains (code, name, description) VALUES ('marketing_sales', 'Marketing & Sales', 'Attracting, converting, and retaining customers') ON CONFLICT (code) DO NOTHING;
INSERT INTO domains (code, name, description) VALUES ('technology_engineering', 'Technology & Engineering', 'Building technical products and systems') ON CONFLICT (code) DO NOTHING;
INSERT INTO domains (code, name, description) VALUES ('creative_content', 'Creative & Content', 'Creating compelling content and experiences') ON CONFLICT (code) DO NOTHING;
INSERT INTO domains (code, name, description) VALUES ('strategy_consulting', 'Strategy & Consulting', 'Advising on strategic decisions') ON CONFLICT (code) DO NOTHING;
INSERT INTO domains (code, name, description) VALUES ('personal_development', 'Personal Development', 'Growth, mindset, and self-improvement') ON CONFLICT (code) DO NOTHING;

-- Specializations (22 rows)
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'entrepreneur', 'Entrepreneur', 'Building companies from scratch' FROM domains d WHERE d.code = 'business_entrepreneurship' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'copywriter', 'Copywriter', 'Writing persuasive marketing copy' FROM domains d WHERE d.code = 'marketing_sales' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'software_engineer', 'Software Engineer', 'Building software applications' FROM domains d WHERE d.code = 'technology_engineering' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'writer', 'Writer', 'Creating written content' FROM domains d WHERE d.code = 'creative_content' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'strategist', 'Strategist', 'Developing strategic plans' FROM domains d WHERE d.code = 'strategy_consulting' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'life_coach', 'Life Coach', 'Guiding personal growth' FROM domains d WHERE d.code = 'personal_development' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'operator', 'Operator/CEO', 'Running and scaling organizations' FROM domains d WHERE d.code = 'business_entrepreneurship' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'marketer', 'Marketer', 'Growing audiences and driving demand' FROM domains d WHERE d.code = 'marketing_sales' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'ai_researcher', 'AI Researcher', 'Advancing AI/ML capabilities' FROM domains d WHERE d.code = 'technology_engineering' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'speaker', 'Speaker/Presenter', 'Public speaking and presentations' FROM domains d WHERE d.code = 'creative_content' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'consultant', 'Consultant', 'Solving business problems' FROM domains d WHERE d.code = 'strategy_consulting' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'philosopher', 'Philosopher', 'Exploring fundamental questions' FROM domains d WHERE d.code = 'personal_development' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'investor', 'Investor', 'Evaluating and funding ventures' FROM domains d WHERE d.code = 'business_entrepreneurship' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'salesperson', 'Salesperson', 'Closing deals and driving revenue' FROM domains d WHERE d.code = 'marketing_sales' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'product_manager', 'Product Manager', 'Defining product strategy and roadmap' FROM domains d WHERE d.code = 'technology_engineering' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'designer', 'Designer', 'Visual and UX design' FROM domains d WHERE d.code = 'creative_content' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'coach', 'Executive Coach', 'Developing leaders' FROM domains d WHERE d.code = 'strategy_consulting' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'mindset_coach', 'Mindset Coach', 'Developing mental frameworks' FROM domains d WHERE d.code = 'personal_development' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'brand_strategist', 'Brand Strategist', 'Building memorable brands' FROM domains d WHERE d.code = 'marketing_sales' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'data_scientist', 'Data Scientist', 'Extracting insights from data' FROM domains d WHERE d.code = 'technology_engineering' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'video_producer', 'Video Producer', 'Video content creation' FROM domains d WHERE d.code = 'creative_content' ON CONFLICT (code) DO NOTHING;
INSERT INTO specializations (domain_id, code, name, description) SELECT d.id, 'productivity_expert', 'Productivity Expert', 'Optimizing time and energy' FROM domains d WHERE d.code = 'personal_development' ON CONFLICT (code) DO NOTHING;

-- Skills (73 rows)
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'business_strategy', 'Business Strategy', 'Strategic planning and market positioning' FROM specializations s WHERE s.code = 'entrepreneur' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'leadership', 'Leadership', 'Leading teams and driving culture' FROM specializations s WHERE s.code = 'operator' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'deal_evaluation', 'Deal Evaluation', 'Assessing investment opportunities' FROM specializations s WHERE s.code = 'investor' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'direct_response_copywriting', 'Direct Response Copywriting', 'Writing copy that drives immediate action' FROM specializations s WHERE s.code = 'copywriter' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'growth_marketing', 'Growth Marketing', 'Systematic audience and revenue growth' FROM specializations s WHERE s.code = 'marketer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'closing', 'Closing', 'Converting prospects to customers' FROM specializations s WHERE s.code = 'salesperson' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'brand_identity', 'Brand Identity', 'Creating distinctive brand personality' FROM specializations s WHERE s.code = 'brand_strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'programming', 'Programming', 'Writing code in various languages' FROM specializations s WHERE s.code = 'software_engineer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'machine_learning', 'Machine Learning', 'Building ML models' FROM specializations s WHERE s.code = 'ai_researcher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'product_strategy', 'Product Strategy', 'Long-term product direction' FROM specializations s WHERE s.code = 'product_manager' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'data_analysis', 'Data Analysis', 'Extracting insights from data' FROM specializations s WHERE s.code = 'data_scientist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'writing_styles', 'Writing Styles', 'Various writing formats' FROM specializations s WHERE s.code = 'writer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'public_speaking', 'Public Speaking', 'Speaking to audiences' FROM specializations s WHERE s.code = 'speaker' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'visual_design', 'Visual Design', 'Aesthetic and graphic design' FROM specializations s WHERE s.code = 'designer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'video_production', 'Video Production', 'Creating video content' FROM specializations s WHERE s.code = 'video_producer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'strategic_thinking', 'Strategic Thinking', 'Long-term planning and foresight' FROM specializations s WHERE s.code = 'strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'problem_diagnosis', 'Problem Diagnosis', 'Identifying root causes' FROM specializations s WHERE s.code = 'consultant' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'leadership_coaching', 'Leadership Coaching', 'Developing leadership skills' FROM specializations s WHERE s.code = 'coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'coaching_skills', 'Coaching', 'Core coaching competencies' FROM specializations s WHERE s.code = 'life_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'philosophy', 'Philosophy', 'Philosophical thinking' FROM specializations s WHERE s.code = 'philosopher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'mindset_development', 'Mindset Development', 'Building empowering beliefs' FROM specializations s WHERE s.code = 'mindset_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'time_management', 'Time Management', 'Optimizing time usage' FROM specializations s WHERE s.code = 'productivity_expert' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'fundraising', 'Fundraising', 'Raising capital from investors' FROM specializations s WHERE s.code = 'entrepreneur' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'execution', 'Execution', 'Getting things done efficiently' FROM specializations s WHERE s.code = 'operator' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'portfolio_management', 'Portfolio Management', 'Managing investment portfolio' FROM specializations s WHERE s.code = 'investor' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'sales_letters', 'Sales Letters', 'Long-form persuasive writing' FROM specializations s WHERE s.code = 'copywriter' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'positioning', 'Positioning', 'Market positioning and messaging' FROM specializations s WHERE s.code = 'marketer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'prospecting', 'Prospecting', 'Finding qualified leads' FROM specializations s WHERE s.code = 'salesperson' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'brand_storytelling', 'Brand Storytelling', 'Crafting brand narratives' FROM specializations s WHERE s.code = 'brand_strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'architecture', 'System Architecture', 'Designing scalable systems' FROM specializations s WHERE s.code = 'software_engineer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'deep_learning', 'Deep Learning', 'Neural network architectures' FROM specializations s WHERE s.code = 'ai_researcher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'user_research', 'User Research', 'Understanding user needs' FROM specializations s WHERE s.code = 'product_manager' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'statistical_modeling', 'Statistical Modeling', 'Building predictive models' FROM specializations s WHERE s.code = 'data_scientist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'content_creation', 'Content Creation', 'Generating ideas and content' FROM specializations s WHERE s.code = 'writer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'presentation_design', 'Presentation Design', 'Creating compelling slides' FROM specializations s WHERE s.code = 'speaker' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'ux_design', 'UX Design', 'User experience design' FROM specializations s WHERE s.code = 'designer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'video_editing', 'Video Editing', 'Post-production editing' FROM specializations s WHERE s.code = 'video_producer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'frameworks', 'Strategic Frameworks', 'Using proven strategy tools' FROM specializations s WHERE s.code = 'strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'recommendation_development', 'Recommendation Development', 'Creating actionable solutions' FROM specializations s WHERE s.code = 'consultant' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'performance_coaching', 'Performance Coaching', 'Improving individual performance' FROM specializations s WHERE s.code = 'coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'goal_achievement', 'Goal Achievement', 'Helping clients reach goals' FROM specializations s WHERE s.code = 'life_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'critical_thinking', 'Critical Thinking', 'Logical reasoning' FROM specializations s WHERE s.code = 'philosopher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'limiting_beliefs', 'Limiting Beliefs', 'Overcoming mental blocks' FROM specializations s WHERE s.code = 'mindset_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'energy_management', 'Energy Management', 'Maximizing energy levels' FROM specializations s WHERE s.code = 'productivity_expert' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'scaling_operations', 'Scaling Operations', 'Growing teams and processes' FROM specializations s WHERE s.code = 'entrepreneur' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'financial_management', 'Financial Management', 'Managing budgets and cash flow' FROM specializations s WHERE s.code = 'operator' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'value_creation', 'Value Creation', 'Helping portfolio companies grow' FROM specializations s WHERE s.code = 'investor' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'persuasion_psychology', 'Persuasion Psychology', 'Understanding psychological triggers' FROM specializations s WHERE s.code = 'copywriter' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'content_marketing', 'Content Marketing', 'Creating valuable content' FROM specializations s WHERE s.code = 'marketer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'objection_handling', 'Objection Handling', 'Overcoming buyer resistance' FROM specializations s WHERE s.code = 'salesperson' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'visual_branding', 'Visual Branding', 'Logo, colors, and design systems' FROM specializations s WHERE s.code = 'brand_strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'devops', 'DevOps', 'Deployment and infrastructure' FROM specializations s WHERE s.code = 'software_engineer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'research_methodology', 'Research Methodology', 'Scientific research process' FROM specializations s WHERE s.code = 'ai_researcher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'roadmap_planning', 'Roadmap Planning', 'Prioritizing features' FROM specializations s WHERE s.code = 'product_manager' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'data_visualization', 'Data Visualization', 'Communicating insights visually' FROM specializations s WHERE s.code = 'data_scientist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'editing', 'Editing', 'Refining and improving writing' FROM specializations s WHERE s.code = 'writer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'stage_presence', 'Stage Presence', 'Commanding attention' FROM specializations s WHERE s.code = 'speaker' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'ui_design', 'UI Design', 'User interface design' FROM specializations s WHERE s.code = 'designer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'cinematography', 'Cinematography', 'Camera work and lighting' FROM specializations s WHERE s.code = 'video_producer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'scenario_planning', 'Scenario Planning', 'Planning for multiple futures' FROM specializations s WHERE s.code = 'strategist' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'client_management', 'Client Management', 'Managing consulting relationships' FROM specializations s WHERE s.code = 'consultant' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'team_coaching', 'Team Coaching', 'Developing teams' FROM specializations s WHERE s.code = 'coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'self_awareness', 'Self-Awareness', 'Building self-understanding' FROM specializations s WHERE s.code = 'life_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'wisdom_transmission', 'Wisdom Transmission', 'Teaching timeless truths' FROM specializations s WHERE s.code = 'philosopher' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'resilience_building', 'Resilience Building', 'Developing mental toughness' FROM specializations s WHERE s.code = 'mindset_coach' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'systems_building', 'Systems Building', 'Creating productivity systems' FROM specializations s WHERE s.code = 'productivity_expert' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'product_development', 'Product Development', 'Building products customers love' FROM specializations s WHERE s.code = 'entrepreneur' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'crisis_management', 'Crisis Management', 'Handling emergencies and setbacks' FROM specializations s WHERE s.code = 'operator' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'email_marketing', 'Email Marketing', 'Email sequences and newsletters' FROM specializations s WHERE s.code = 'copywriter' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'paid_advertising', 'Paid Advertising', 'Running profitable ad campaigns' FROM specializations s WHERE s.code = 'marketer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'relationship_building', 'Relationship Building', 'Long-term customer relationships' FROM specializations s WHERE s.code = 'salesperson' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'debugging', 'Debugging', 'Finding and fixing bugs' FROM specializations s WHERE s.code = 'software_engineer' ON CONFLICT (code) DO NOTHING;
INSERT INTO skills (specialization_id, code, name, description) SELECT s.id, 'stakeholder_management', 'Stakeholder Management', 'Aligning cross-functional teams' FROM specializations s WHERE s.code = 'product_manager' ON CONFLICT (code) DO NOTHING;

-- Traits (35 rows)
INSERT INTO traits (code, name, description) VALUES ('trait_1', 'Openness to Experience', 'Big Five: Openness to Experience') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_2', 'Conscientiousness', 'Big Five: Conscientiousness') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_3', 'Extraversion', 'Big Five: Extraversion') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_4', 'Agreeableness', 'Big Five: Agreeableness') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_5', 'Neuroticism', 'Big Five: Neuroticism') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_11', 'Imagination', 'Big Five Facet: Imagination (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_12', 'Artistic Interest', 'Big Five Facet: Artistic Interest (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_13', 'Emotionality', 'Big Five Facet: Emotionality (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_14', 'Adventurousness', 'Big Five Facet: Adventurousness (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_15', 'Intellect', 'Big Five Facet: Intellect (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_16', 'Liberalism', 'Big Five Facet: Liberalism (part of Openness to Experience)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_21', 'Self-Efficacy', 'Big Five Facet: Self-Efficacy (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_22', 'Orderliness', 'Big Five Facet: Orderliness (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_23', 'Dutifulness', 'Big Five Facet: Dutifulness (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_24', 'Achievement Striving', 'Big Five Facet: Achievement Striving (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_25', 'Self-Discipline', 'Big Five Facet: Self-Discipline (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_26', 'Cautiousness', 'Big Five Facet: Cautiousness (part of Conscientiousness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_31', 'Warmth', 'Big Five Facet: Warmth (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_32', 'Gregariousness', 'Big Five Facet: Gregariousness (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_33', 'Assertiveness', 'Big Five Facet: Assertiveness (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_34', 'Activity', 'Big Five Facet: Activity (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_35', 'Excitement-Seeking', 'Big Five Facet: Excitement-Seeking (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_36', 'Positive Emotions', 'Big Five Facet: Positive Emotions (part of Extraversion)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_41', 'Trust', 'Big Five Facet: Trust (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_42', 'Straightforwardness', 'Big Five Facet: Straightforwardness (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_43', 'Altruism', 'Big Five Facet: Altruism (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_44', 'Compliance', 'Big Five Facet: Compliance (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_45', 'Modesty', 'Big Five Facet: Modesty (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_46', 'Tender-Mindedness', 'Big Five Facet: Tender-Mindedness (part of Agreeableness)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_51', 'Anxiety', 'Big Five Facet: Anxiety (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_52', 'Angry Hostility', 'Big Five Facet: Angry Hostility (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_53', 'Depression', 'Big Five Facet: Depression (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_54', 'Self-Consciousness', 'Big Five Facet: Self-Consciousness (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_55', 'Impulsiveness', 'Big Five Facet: Impulsiveness (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;
INSERT INTO traits (code, name, description) VALUES ('trait_56', 'Vulnerability', 'Big Five Facet: Vulnerability (part of Neuroticism)') ON CONFLICT (code) DO NOTHING;

-- Validation
SELECT 'domains' as table_name, COUNT(*) as count FROM domains WHERE code LIKE '%_%'
UNION ALL SELECT 'specializations', COUNT(*) FROM specializations WHERE code IS NOT NULL
UNION ALL SELECT 'skills', COUNT(*) FROM skills WHERE code IS NOT NULL
UNION ALL SELECT 'traits', COUNT(*) FROM traits WHERE code LIKE 'trait_%';