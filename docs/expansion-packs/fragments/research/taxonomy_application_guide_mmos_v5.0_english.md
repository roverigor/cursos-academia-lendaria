# TAXONOMY APPLICATION GUIDE - MMOS v5.0
# When and How to Use Each Taxonomy at Each Stage

guide_version: "5.0"
last_updated: "2025-01-26"
status: "production"
scope: "workflow_guidance"

# =============================================================================
# OVERVIEW
# =============================================================================

purpose: |
  This guide explains WHEN and HOW to apply each taxonomy during the 
  cognitive clone development process. It provides stage-by-stage guidance
  to ensure consistent, high-quality fragment extraction and classification.

document_structure:
  - "Workflow stages overview"
  - "Stage-by-stage taxonomy application"
  - "Decision trees and flowcharts"
  - "Common scenarios and examples"
  - "Quality checkpoints"
  - "Troubleshooting guide"

# =============================================================================
# 1. WORKFLOW STAGES OVERVIEW
# =============================================================================

workflow_stages:
  
  stage_1_source_collection:
    name: "Source Collection"
    duration: "Ongoing, focus in first 2 weeks"
    primary_taxonomy: "SOURCE TAXONOMY"
    key_activities:
      - "Identify and gather sources"
      - "Classify source quality"
      - "Prioritize sources"
      - "Create source records"
    outputs:
      - "Source database"
      - "Extraction priority queue"
    
  stage_2_initial_extraction:
    name: "Initial Extraction"
    duration: "Concurrent with collection"
    primary_taxonomy: "FRAGMENT TAXONOMY (basic fields)"
    key_activities:
      - "Extract content from sources"
      - "Create draft fragments"
      - "Assign basic metadata"
    outputs:
      - "Draft fragment database"
    
  stage_3_enrichment:
    name: "Fragment Enrichment"
    duration: "Days after extraction"
    primary_taxonomy: "FRAGMENT TAXONOMY (full)"
    key_activities:
      - "Add insights and context"
      - "Assign relevance scores"
      - "Apply comprehensive tags"
      - "Add metadata"
    outputs:
      - "Enriched fragment database"
    
  stage_4_verification:
    name: "Verification and Validation"
    duration: "Week 6-8"
    primary_taxonomy: "Both (cross-reference)"
    key_activities:
      - "Verify accuracy"
      - "Cross-check sources"
      - "Identify contradictions"
      - "Confirm confidence levels"
    outputs:
      - "Verified fragment database"
      - "Gap analysis"
    
  stage_5_synthesis:
    name: "Pattern Synthesis"
    duration: "Week 7-8"
    primary_taxonomy: "FRAGMENT TAXONOMY (analysis)"
    key_activities:
      - "Identify patterns"
      - "Create synthesis fragments"
      - "Map relationships"
      - "Build cognitive signatures"
    outputs:
      - "Complete knowledge base"
      - "Pattern library"

# =============================================================================
# 2. STAGE 1: SOURCE COLLECTION
# =============================================================================

stage_1_source_collection:
  
  WHEN: "Beginning of project, ongoing throughout"
  
  PRIMARY_TAXONOMY: "Source Taxonomy"
  
  KEY_DECISIONS:
    
    decision_1_source_type:
      question: "What type of source is this?"
      taxonomy_reference: "Source Taxonomy - Section 2: Source Types"
      decision_tree:
        - "Is this audio/video content with the subject speaking?"
          yes: "interview, podcast, video, or presentation"
          no: "continue"
        - "Is this written by the subject?"
          yes: "book, article, document, social_media, or email"
          no: "continue"
        - "Is this about the subject by someone else?"
          yes: "article, book (biography), or observation"
          no: "review and categorize"
      
      examples:
        - input: "3-hour recorded conversation with subject about life history"
          output: "type: interview, subtype: discovery_interview"
        
        - input: "Subject's Twitter thread about AI"
          output: "type: social_media, subtype: twitter_thread"
        
        - input: "Book chapter written by subject"
          output: "type: book, subtype: authored_book"
    
    decision_2_source_quality:
      question: "What is the quality classification?"
      taxonomy_reference: "Source Taxonomy - Section 3: Quality Classification"
      decision_tree:
        - "Is this directly from the subject (their words, writing, or creation)?"
          yes: "quality: primary"
          no: "continue"
        - "Is this created by a reliable source about the subject (biography, documentary, professional article)?"
          yes: "quality: secondary"
          no: "continue"
        - "Is this a compilation or summary of other sources?"
          yes: "quality: tertiary"
          no: "review carefully"
      
      critical_notes:
        - "Primary = highest confidence, extract thoroughly"
        - "Secondary = useful for external perspectives"
        - "Tertiary = use sparingly, verify everything"
      
      examples:
        - input: "Podcast where subject is interviewed"
          output: "quality: primary"
          reasoning: "Subject's own words"
        
        - input: "Biography written by journalist who interviewed subject"
          output: "quality: secondary"
          reasoning: "About subject, by reliable source"
        
        - input: "Wikipedia article about subject"
          output: "quality: tertiary"
          reasoning: "Compilation of other sources"
    
    decision_3_priority:
      question: "What extraction priority should this have?"
      taxonomy_reference: "Source Taxonomy - Section 4: Prioritization Matrix"
      decision_factors:
        - "Source quality (primary > secondary > tertiary)"
        - "Content depth (comprehensive > focused > brief)"
        - "Direct access (subject speaking > about subject)"
        - "Information richness (dense > sparse)"
      
      priority_assignment:
        CRITICAL:
          criteria:
            - "Primary source"
            - "2+ hours of content"
            - "Comprehensive coverage"
            - "High quality"
          examples:
            - "Extended discovery interview"
            - "Book authored by subject"
            - "Multi-episode podcast series"
          action: "Extract immediately, allocate maximum time"
        
        VERY_HIGH:
          criteria:
            - "Primary source"
            - "1-2 hours of content"
            - "Good depth"
          examples:
            - "Single long interview"
            - "Podcast guest appearance"
            - "Conference keynote"
          action: "Extract within days, thorough approach"
        
        HIGH:
          criteria:
            - "Primary or quality secondary"
            - "30-60 minutes"
            - "Moderate depth"
          examples:
            - "Short interview"
            - "Blog post by subject"
            - "Professional presentation"
          action: "Extract within 1-2 weeks, systematic"
        
        MEDIUM:
          criteria:
            - "Secondary sources"
            - "Brief or focused"
            - "Supplementary value"
          examples:
            - "Article about subject"
            - "Social media posts"
            - "Email correspondence"
          action: "Extract within a month, selective"
        
        LOW:
          criteria:
            - "Tertiary sources"
            - "Limited value"
            - "Fill gaps only"
          examples:
            - "Wikipedia entries"
            - "General summaries"
          action: "Extract if time permits, quick scan"
  
  REQUIRED_OUTPUTS:
    
    for_each_source:
      - id: "Generate unique source ID (SRC_001, SRC_002, etc.)"
      - title: "Create descriptive title"
      - type: "Classify source type"
      - quality: "Assign quality level"
      - date: "Record source date"
      - metadata: "Document relevant metadata"
      - priority: "Determine extraction priority"
  
  QUALITY_CHECKLIST:
    - "[ ] Source ID is unique and follows pattern SRC_XXX"
    - "[ ] Title is descriptive and clear"
    - "[ ] Type accurately classified using taxonomy"
    - "[ ] Quality level (primary/secondary/tertiary) assigned"
    - "[ ] Date is accurate"
    - "[ ] URL included if available"
    - "[ ] Priority level determined"
    - "[ ] Notes include context and initial assessment"
  
  COMMON_MISTAKES:
    - "Marking secondary sources as primary"
    - "Not documenting source location/URL"
    - "Forgetting to assess extraction priority"
    - "Insufficient notes about source context"
    - "Not tracking source relationships"

# =============================================================================
# 3. STAGE 2: INITIAL EXTRACTION
# =============================================================================

stage_2_initial_extraction:
  
  WHEN: "Immediately after source collection, prioritized by source priority"
  
  PRIMARY_TAXONOMY: "Fragment Taxonomy (basic fields only)"
  
  FOCUS: "Speed and coverage - capture content, defer deep analysis"
  
  KEY_DECISIONS:
    
    decision_1_what_to_extract:
      question: "Should this be extracted as a fragment?"
      criteria:
        extract_if:
          - "Reveals something about the person's thoughts, beliefs, or behavior"
          - "Contains direct quote or specific example"
          - "Shows a pattern or characteristic"
          - "Provides biographical information"
          - "Demonstrates communication style"
        
        skip_if:
          - "Pure small talk with no substance"
          - "Administrative or purely logistical"
          - "Completely off-topic"
          - "Redundant with already captured fragments"
      
      examples:
        - input: "Subject says: 'I believe the most important thing in business is integrity'"
          decision: "EXTRACT - reveals core value"
        
        - input: "Subject says: 'Can you pass the coffee?'"
          decision: "SKIP - no meaningful content"
        
        - input: "Subject tells detailed story about overcoming failure"
          decision: "EXTRACT - reveals resilience, values, approach to challenges"
    
    decision_2_content_type:
      question: "What type of content is this?"
      taxonomy_reference: "Fragment Taxonomy - type field"
      decision_tree:
        - "Is this the subject's exact words?"
          yes: "type: direct_quote"
          no: "continue"
        - "Is this the same idea in different words?"
          yes: "type: paraphrase"
          no: "continue"
        - "Is this someone else describing the subject?"
          yes: "type: description"
          no: "continue"
        - "Is this a concrete example of behavior?"
          yes: "type: example"
          no: "continue"
        - "Is this a pattern observed across multiple instances?"
          yes: "type: pattern"
          no: "continue"
        - "Is this a story or narrative?"
          yes: "type: anecdote"
          no: "review - may be analysis or synthesis"
      
      critical_notes:
        - "direct_quote = highest fidelity, use when possible"
        - "pattern = requires multiple observations, usually added later"
        - "analysis/synthesis = typically created in later stages"
      
      examples:
        - input: 'Subject says: "I always start by drawing the problem"'
          output: "type: direct_quote"
        
        - input: "According to colleagues, he's very systematic"
          output: "type: description"
        
        - input: "When facing decisions, he creates a pros/cons list and assigns weights"
          output: "type: example"
    
    decision_3_category:
      question: "What category does this belong to?"
      taxonomy_reference: "Fragment Taxonomy - Section 3: Category Definitions"
      
      category_quick_reference:
        "About life history, upbringing, education, career":
          category: "Biographical"
          examples: ["I was born in...", "I studied...", "I worked at..."]
        
        "About thinking, philosophy, beliefs, mental processes":
          category: "Cognitive"
          examples: ["I believe...", "My approach is...", "I think about..."]
        
        "About communication style, language, expression":
          category: "Communicative"
          examples: ["I always say...", "My metaphor is...", "I explain by..."]
        
        "About habits, routines, actions, behaviors":
          category: "Behavioral"
          examples: ["Every morning I...", "When I work I...", "My process is..."]
        
        "About values, ethics, principles, morals":
          category: "Values and Beliefs"
          examples: ["What matters most is...", "I stand for...", "I believe right/wrong..."]
        
        "About relationships, interactions, social dynamics":
          category: "Social"
          examples: ["In teams I...", "My relationships...", "I collaborate by..."]
        
        "About self-awareness, contradictions, evolution":
          category: "Meta-cognitive"
          examples: ["I used to think... now...", "I'm aware I...", "My blind spot is..."]
        
        "About verification, validation, fact-checking":
          category: "Source Validation"
          examples: ["This is verified by...", "Cross-checked against..."]
  
  REQUIRED_FIELDS_AT_THIS_STAGE:
    
    minimal_viable_fragment:
      id: "Generate FRAG_[CAT]_XXX (category code + number)"
      category: "Assign category (see decision_3)"
      source: "Reference source ID (SRC_XXX)"
      location: "Where in source (timestamp, page, section)"
      type: "Classify content type (see decision_2)"
      content: "The actual quote, description, or observation"
      context: "Brief situational context"
    
    defer_to_next_stage:
      - relevance: "Will be assessed in enrichment stage"
      - insight: "Will be extracted in enrichment stage"
      - tags: "Will be added in enrichment stage"
      - metadata: "Will be completed in enrichment stage"
  
  EXTRACTION_WORKFLOW:
    
    step_1_prepare:
      - "Open source material"
      - "Have fragment template ready"
      - "Set up note-taking system"
      - "Review source metadata"
    
    step_2_extract:
      - "Go through source systematically"
      - "When something extractable appears, pause"
      - "Create new fragment"
      - "Fill in required fields"
      - "Continue to next extractable item"
    
    step_3_review:
      - "Quick review of extracted fragments"
      - "Check all required fields present"
      - "Verify IDs are unique"
      - "Ensure content makes sense"
    
    step_4_document:
      - "Update source record with fragment count"
      - "Note extraction completion"
      - "Flag any issues or questions"
      - "Save and backup"
  
  SPEED_GUIDELINES:
    
    target_extraction_rates:
      interview_1_hour: "15-30 fragments (30-45 min extraction time)"
      podcast_1_hour: "10-25 fragments (30-60 min extraction time)"
      book_100_pages: "30-60 fragments (2-4 hours extraction time)"
      article: "3-10 fragments (15-30 min extraction time)"
      social_media_post: "1-3 fragments (5-10 min extraction time)"
    
    efficiency_tips:
      - "Don't perfect at this stage - capture and move on"
      - "Use consistent location format (saves time later)"
      - "Keep content field focused - don't over-extract"
      - "Context can be brief - elaborate later if needed"
      - "Batch similar sources for efficiency"
  
  QUALITY_CHECKPOINTS:
    
    per_fragment:
      - "[ ] ID follows pattern FRAG_[CAT]_XXX"
      - "[ ] Category is appropriate"
      - "[ ] Source ID is correct"
      - "[ ] Location is specific enough to find again"
      - "[ ] Type is accurately classified"
      - "[ ] Content is clear and complete"
      - "[ ] Context provides situational understanding"
    
    per_source_completion:
      - "[ ] Extracted all high-value content"
      - "[ ] Fragment IDs are sequential and unique"
      - "[ ] Updated source record with extraction data"
      - "[ ] No required fields are missing"
      - "[ ] Ready for enrichment stage"
  
  COMMON_MISTAKES:
    - "Over-analyzing at this stage (slows down extraction)"
    - "Including too much context in content field"
    - "Skipping location information"
    - "Inconsistent category assignment"
    - "Not documenting unclear items for follow-up"
    - "Trying to add insights/relevance now (defer to next stage)"

# =============================================================================
# 4. STAGE 3: FRAGMENT ENRICHMENT
# =============================================================================

stage_3_enrichment:
  
  WHEN: "After initial extraction, before verification"
  
  PRIMARY_TAXONOMY: "Fragment Taxonomy (complete all fields)"
  
  FOCUS: "Depth and quality - add insights, relevance, tags, metadata"
  
  KEY_DECISIONS:
    
    decision_1_relevance_scoring:
      question: "How relevant is this for the cognitive clone?"
      taxonomy_reference: "Fragment Taxonomy - Section 5: Relevance Scoring Guidelines"
      
      scoring_process:
        step_1_initial_assessment:
          ask: "Does this reveal core identity or is it peripheral?"
          scale:
            "Core identity, essential for clone": "Consider 8-10"
            "Important but not essential": "Consider 5-7"
            "Interesting but low impact": "Consider 3-4"
            "Minimal importance": "Consider 1-2"
        
        step_2_refinement:
          factors_increasing_score:
            - "Reveals fundamental belief or value"
            - "Shows consistent pattern across contexts"
            - "Demonstrates unique characteristic"
            - "Critical for accurate responses"
            - "Frequently referenced or used"
          
          factors_decreasing_score:
            - "Purely biographical trivia"
            - "One-time occurrence, not pattern"
            - "Common to many people"
            - "Limited application in clone responses"
            - "Already covered by other fragments"
        
        step_3_final_score:
          guidelines:
            10: "Reserve for <5% of fragments - truly critical"
            9: "Major influence - ~5-10% of fragments"
            8: "High importance - ~10-15% of fragments"
            7: "Significant - ~15-20% of fragments"
            5-6: "Average - ~30-40% of fragments"
            3-4: "Low - ~10-20% of fragments"
            1-2: "Trivial - <5% (consider removing)"
      
      examples:
        - fragment: "Core belief: 'Systems thinking is fundamental to understanding any domain'"
          relevance: 10
          reasoning: "Core cognitive approach, defines problem-solving method"
        
        - fragment: "Uses engineering metaphors frequently when explaining concepts"
          relevance: 8
          reasoning: "Important communication pattern, signature style"
        
        - fragment: "Favorite color is blue"
          relevance: 2
          reasoning: "Trivia, no impact on clone responses"
    
    decision_2_insight_extraction:
      question: "What key insight does this fragment reveal?"
      
      insight_framework:
        good_insights:
          - "Extract the meaning, not just restate the content"
          - "Connect to broader patterns or characteristics"
          - "Explain why this matters for the clone"
          - "Link to other known information if relevant"
        
        avoid:
          - "Simply restating the content"
          - "Vague or generic statements"
          - "Over-interpreting limited data"
          - "Adding unsupported speculation"
      
      insight_template:
        pattern: "[What this reveals] - [Implication or connection] - [Why it matters]"
        
        examples:
          content: "I always start projects by mapping all stakeholders and their interests"
          bad_insight: "Subject maps stakeholders"
          good_insight: "Systematic stakeholder mapper - indicates strategic thinking and political awareness - critical for clone's approach to project planning and communication"
          
          content: "I was born in Maricá but moved frequently as a child"
          bad_insight: "Born in Maricá, moved around"
          good_insight: "Early geographic mobility (Maricá origins, frequent moves) likely contributed to adaptability and weak geographic identity - explains cosmopolitan worldview and comfort with change"
    
    decision_3_tagging:
      question: "What tags should be applied?"
      taxonomy_reference: "Fragment Taxonomy - Section 6: Tag Taxonomy"
      
      tagging_strategy:
        minimum_tags: 3
        recommended_tags: 5-8
        maximum_tags: 15
        
        tag_levels:
          level_1_specific:
            description: "Specific, narrow tags"
            examples: ["maricá", "stakeholder_mapping", "engineering_metaphor"]
            quantity: "2-4 tags"
          
          level_2_thematic:
            description: "Broader thematic tags"
            examples: ["origin", "problem_solving", "communication_style"]
            quantity: "2-3 tags"
          
          level_3_categorical:
            description: "High-level category tags"
            examples: ["cognitive", "behavioral", "values"]
            quantity: "1-2 tags"
      
      tagging_checklist:
        - "[ ] Include specific proper nouns (places, people, companies)"
        - "[ ] Include specific actions or behaviors"
        - "[ ] Include broader themes or patterns"
        - "[ ] Include emotional or psychological tags if relevant"
        - "[ ] Include category-level tags"
        - "[ ] Use lowercase with underscores"
        - "[ ] Check tags against taxonomy for consistency"
      
      examples:
        fragment: "I believe failure is just data for the next iteration"
        tags: 
          - "failure_mindset"
          - "learning_orientation"
          - "iterative_thinking"
          - "resilience"
          - "growth_mindset"
          - "values"
          - "cognitive_philosophy"
    
    decision_4_metadata_completion:
      question: "What additional metadata should be added?"
      
      metadata_priority:
        high_priority:
          confidence:
            when: "Always assess"
            how: "Use source quality as base, adjust for clarity and verifiability"
            range: "0.0-1.0"
          
          timestamp:
            when: "If source has specific date/time"
            how: "Record when content was created or captured"
        
        medium_priority:
          verified:
            when: "If verification has been performed"
            how: "Mark true only if cross-checked against other sources"
          
          related_fragments:
            when: "If obvious connections exist"
            how: "Link to fragment IDs that relate, support, or contradict"
        
        low_priority:
          notes:
            when: "If there are questions or concerns"
            how: "Document anything unclear or needing follow-up"
  
  ENRICHMENT_WORKFLOW:
    
    step_1_batch_preparation:
      - "Group fragments by category or source"
      - "Review category guidelines"
      - "Have tag taxonomy reference available"
      - "Set up consistent environment"
    
    step_2_fragment_enrichment:
      for_each_fragment:
        - "Read content and context"
        - "Assign relevance score (1-10)"
        - "Extract key insight"
        - "Apply comprehensive tags (5-8 tags)"
        - "Add confidence score"
        - "Add any relevant metadata"
        - "Flag if needs verification or follow-up"
    
    step_3_quality_check:
      - "Review relevance distribution (should be normal curve)"
      - "Check insights are meaningful (not just restatements)"
      - "Verify tags are from taxonomy"
      - "Ensure consistency within batch"
    
    step_4_documentation:
      - "Update fragment count by category"
      - "Note any patterns observed"
      - "Flag gaps or areas needing more coverage"
      - "Save and backup"
  
  QUALITY_CHECKPOINTS:
    
    per_fragment:
      - "[ ] Relevance score justified and appropriate"
      - "[ ] Insight extracts meaning, not just restates"
      - "[ ] At least 3 tags applied"
      - "[ ] Tags are from approved taxonomy"
      - "[ ] Tags include specific and general levels"
      - "[ ] Confidence score added if source allows"
      - "[ ] All required fields now complete"
    
    per_batch:
      - "[ ] Relevance scores form reasonable distribution"
      - "[ ] Insights are consistent in quality"
      - "[ ] Tagging is consistent across similar fragments"
      - "[ ] High-relevance fragments have higher confidence"
      - "[ ] Flagged items for verification where needed"
  
  TIME_GUIDELINES:
    
    enrichment_rate:
      simple_fragment: "2-3 minutes"
      average_fragment: "3-5 minutes"
      complex_fragment: "5-10 minutes"
    
    batch_efficiency:
      - "Group by category for consistent mental frame"
      - "Do relevance scoring in one pass"
      - "Do insight extraction in another pass"
      - "Do tagging in final pass"
      - "This batch approach is faster than complete-one-at-a-time"
  
  COMMON_MISTAKES:
    - "Relevance scores too high (grade inflation)"
    - "Insights that just restate content"
    - "Too few tags (missing search/filter opportunities)"
    - "Tags that aren't in taxonomy (inconsistency)"
    - "Skipping confidence scores"
    - "Not linking related fragments"
    - "Overthinking - paralysis by analysis"

# =============================================================================
# 5. STAGE 4: VERIFICATION AND VALIDATION
# =============================================================================

stage_4_verification:
  
  WHEN: "After enrichment, before synthesis (usually week 6-8)"
  
  PRIMARY_TAXONOMY: "Both Fragment and Source Taxonomies"
  
  FOCUS: "Accuracy and consistency - verify, cross-check, resolve conflicts"
  
  KEY_ACTIVITIES:
    
    activity_1_source_verification:
      description: "Verify source authenticity and quality"
      taxonomy_reference: "Source Taxonomy - Section 3 & 7"
      
      checks:
        - "Confirm source quality classification is accurate"
        - "Verify URLs are accessible"
        - "Check dates are correct"
        - "Validate author/creator information"
        - "Confirm primary sources are truly from subject"
        - "Review secondary source credibility"
      
      actions:
        if_issues_found:
          - "Update source quality if misclassified"
          - "Adjust fragment confidence scores accordingly"
          - "Flag fragments from questionable sources"
          - "Document concerns in source notes"
    
    activity_2_fragment_verification:
      description: "Verify fragment accuracy and consistency"
      taxonomy_reference: "Fragment Taxonomy - Section 7"
      
      checks:
        accuracy_check:
          - "Content accurately represents source"
          - "Location is precise and verifiable"
          - "Context is appropriate"
          - "No transcription errors in quotes"
        
        classification_check:
          - "Category assignment is correct"
          - "Type classification is accurate"
          - "Relevance score is justified"
          - "Tags are appropriate and complete"
        
        consistency_check:
          - "Similar fragments have similar relevance scores"
          - "Tagging is consistent across related fragments"
          - "Confidence scores align with source quality"
          - "Insights are at similar depth levels"
      
      actions:
        if_issues_found:
          - "Correct misclassifications"
          - "Update relevance scores if needed"
          - "Add or adjust tags"
          - "Refine insights"
          - "Adjust confidence scores"
    
    activity_3_contradiction_detection:
      description: "Identify and resolve contradictions"
      
      process:
        step_1_identify:
          method: "Review fragments by topic/theme"
          look_for:
            - "Conflicting statements about beliefs"
            - "Inconsistent behavioral descriptions"
            - "Contradictory biographical facts"
            - "Evolving positions over time"
        
        step_2_analyze:
          questions:
            - "Are these true contradictions or context-dependent?"
            - "Has position evolved over time (not contradiction)?"
            - "Is one source more reliable than the other?"
            - "Is this a known paradox in subject's thinking?"
        
        step_3_resolve:
          options:
            temporal_evolution:
              action: "Tag both with 'evolution' and note timeline"
              example: "Subject's view on AI changed from tool to collaboration partner"
            
            context_dependent:
              action: "Note contexts where each applies"
              example: "Introverted in large groups, extroverted with close friends"
            
            source_quality_issue:
              action: "Trust higher quality source, flag lower"
              example: "Primary source conflicts with tertiary - trust primary"
            
            genuine_paradox:
              action: "Document as meta-cognitive complexity"
              example: "Values spontaneity yet highly structured - known tension"
            
            requires_followup:
              action: "Flag for clarification in follow-up interview"
              example: "Conflicting info on key decision - needs direct clarification"
    
    activity_4_gap_identification:
      description: "Identify coverage gaps and needs"
      taxonomy_reference: "Fragment Taxonomy - gap tracking"
      
      analysis:
        coverage_by_category:
          - "Count fragments per category"
          - "Assess depth distribution per category"
          - "Identify under-represented areas"
        
        coverage_by_topic:
          - "Review tag frequency"
          - "Identify missing topics"
          - "Note areas with low confidence"
        
        quality_distribution:
          - "Check relevance score distribution"
          - "Assess confidence level distribution"
          - "Identify areas needing higher quality"
      
      outputs:
        gap_report:
          - "Categories needing more coverage"
          - "Topics completely missing"
          - "Areas with low confidence requiring verification"
          - "Contradictions requiring resolution"
          - "Recommendations for additional sources"
  
  VERIFICATION_WORKFLOW:
    
    step_1_source_review:
      - "Review all source records"
      - "Verify quality classifications"
      - "Check source metadata completeness"
      - "Update any incorrect information"
    
    step_2_fragment_review:
      - "Sample random fragments from each category"
      - "Verify against original sources"
      - "Check classification accuracy"
      - "Validate relevance scores"
    
    step_3_contradiction_analysis:
      - "Group fragments by topic/theme"
      - "Identify potential contradictions"
      - "Analyze and resolve each"
      - "Document resolutions"
    
    step_4_gap_analysis:
      - "Generate coverage statistics"
      - "Identify gaps and weaknesses"
      - "Create gap-filling plan"
      - "Prioritize follow-up activities"
    
    step_5_documentation:
      - "Update verification status"
      - "Document all changes made"
      - "Create gap report"
      - "Plan next steps"
  
  QUALITY_CHECKPOINTS:
    
    source_verification:
      - "[ ] All sources have accurate quality classification"
      - "[ ] Source metadata is complete"
      - "[ ] Questionable sources are flagged"
      - "[ ] Source relationships documented"
    
    fragment_verification:
      - "[ ] Sample fragments verified against sources"
      - "[ ] Classification consistency checked"
      - "[ ] Relevance scores validated"
      - "[ ] Contradictions identified and resolved"
      - "[ ] Coverage gaps documented"
    
    readiness_for_synthesis:
      - "[ ] Confidence in fragment database is high"
      - "[ ] Major contradictions resolved"
      - "[ ] Critical gaps identified"
      - "[ ] Verification complete and documented"

# =============================================================================
# 6. STAGE 5: PATTERN SYNTHESIS
# =============================================================================

stage_5_synthesis:
  
  WHEN: "After verification, final stage (usually week 7-8)"
  
  PRIMARY_TAXONOMY: "Fragment Taxonomy (creating new synthesis fragments)"
  
  FOCUS: "Pattern identification and synthesis creation"
  
  KEY_ACTIVITIES:
    
    activity_1_pattern_identification:
      description: "Identify consistent patterns across fragments"
      
      pattern_types:
        cognitive_patterns:
          - "Thinking styles and approaches"
          - "Decision-making frameworks"
          - "Problem-solving methods"
          - "Learning preferences"
          examples:
            - "Always externalizes thinking through diagrams"
            - "Uses 'why' questions to understand root causes"
        
        behavioral_patterns:
          - "Consistent actions and habits"
          - "Routine behaviors"
          - "Reaction patterns"
          - "Communication habits"
          examples:
            - "Starts presentations with a story 85% of the time"
            - "Uses engineering metaphors in 73% of explanations"
        
        value_patterns:
          - "Consistent value expression"
          - "Ethical decision-making"
          - "Priority hierarchies"
          examples:
            - "Prioritizes integrity over convenience in all observed situations"
      
      identification_process:
        step_1_group:
          - "Group fragments by theme/topic"
          - "Look for repeated elements"
        
        step_2_analyze:
          - "Count frequency of occurrence"
          - "Note contexts where pattern appears"
          - "Identify conditions and exceptions"
        
        step_3_validate:
          - "Check pattern against all relevant fragments"
          - "Ensure consistency across sources"
          - "Assess confidence level"
        
        step_4_document:
          - "Create pattern fragment (type: pattern)"
          - "Link to supporting fragments"
          - "Note frequency and contexts"
    
    activity_2_synthesis_creation:
      description: "Create synthesis fragments combining multiple sources"
      
      when_to_synthesize:
        - "Multiple fragments address same topic"
        - "Information spans multiple sources"
        - "Evolution of thought over time"
        - "Complex topic needing integration"
      
      synthesis_process:
        step_1_gather:
          - "Collect all relevant fragments"
          - "Review for consistency and evolution"
        
        step_2_analyze:
          - "Identify common threads"
          - "Note variations and changes"
          - "Assess overall pattern"
        
        step_3_synthesize:
          - "Create integrated view"
          - "Note source fragments"
          - "Document confidence level"
          - "Explain synthesis logic"
        
        step_4_validate:
          - "Check synthesis against source fragments"
          - "Ensure no over-interpretation"
          - "Verify with additional sources if possible"
      
      synthesis_fragment_structure:
        id: "FRAG_[CAT]_XXX"
        category: "(appropriate category)"
        source: "SYNTHESIS or multiple source IDs"
        location: "Synthesized from multiple fragments"
        type: "synthesis"
        relevance: "(typically high, 7-10)"
        content: "Integrated synthesis statement"
        context: "Synthesis of X fragments from Y sources over Z timeframe"
        insight: "What this synthesis reveals overall"
        tags: "(comprehensive, including 'synthesis' tag)"
        metadata:
          related_fragments: "[list of source fragment IDs]"
          confidence: "(based on consistency across sources)"
          notes: "Synthesis methodology and observations"
    
    activity_3_relationship_mapping:
      description: "Map relationships between fragments"
      
      relationship_types:
        supports:
          - "Fragment provides evidence for another"
          - "Fragment elaborates on another"
        
        contradicts:
          - "Fragment conflicts with another"
          - "Requires resolution or explanation"
        
        relates_to:
          - "Fragment is thematically connected"
          - "Fragment provides context for another"
        
        evolves_from:
          - "Fragment shows evolution from earlier fragment"
          - "Temporal relationship"
      
      mapping_process:
        - "Review fragments systematically"
        - "Identify clear relationships"
        - "Document in metadata.related_fragments"
        - "Note relationship type in metadata.notes"
    
    activity_4_cognitive_signature_creation:
      description: "Create high-level cognitive signatures"
      
      signature_elements:
        - "Core thinking patterns"
        - "Communication signatures"
        - "Decision-making approaches"
        - "Value hierarchies"
        - "Behavioral tendencies"
      
      signature_creation:
        requirements:
          - "Supported by 5+ fragments"
          - "Confidence > 0.85"
          - "Consistent across contexts"
          - "Distinctive and defining"
        
        structure:
          - "Clear pattern name"
          - "Description of pattern"
          - "Frequency and contexts"
          - "Examples (linked fragments)"
          - "Implications for clone"
  
  SYNTHESIS_WORKFLOW:
    
    step_1_preparation:
      - "Review all verified fragments"
      - "Generate fragment statistics"
      - "Identify synthesis opportunities"
    
    step_2_pattern_work:
      - "Identify patterns systematically"
      - "Create pattern fragments"
      - "Link to supporting evidence"
      - "Validate patterns"
    
    step_3_synthesis_work:
      - "Create synthesis fragments"
      - "Integrate multi-source information"
      - "Document temporal evolution"
      - "Link to source fragments"
    
    step_4_relationship_mapping:
      - "Map fragment relationships"
      - "Document connections"
      - "Create relationship network"
    
    step_5_signature_creation:
      - "Create cognitive signatures"
      - "Document core patterns"
      - "Create signature library"
    
    step_6_finalization:
      - "Generate complete knowledge base"
      - "Create documentation"
      - "Export in required formats"
      - "Deliver final product"
  
  QUALITY_CHECKPOINTS:
    
    pattern_quality:
      - "[ ] Pattern supported by 3+ fragments minimum"
      - "[ ] Pattern is consistent across contexts"
      - "[ ] Pattern frequency documented"
      - "[ ] Pattern confidence > 0.8"
    
    synthesis_quality:
      - "[ ] Synthesis integrates multiple sources"
      - "[ ] Source fragments linked"
      - "[ ] No over-interpretation"
      - "[ ] Synthesis confidence documented"
    
    overall_knowledge_base:
      - "[ ] All fragments verified"
      - "[ ] Patterns identified and documented"
      - "[ ] Syntheses created where appropriate"
      - "[ ] Relationships mapped"
      - "[ ] Cognitive signatures defined"
      - "[ ] Ready for clone integration"

# =============================================================================
# 7. DECISION TREES AND QUICK REFERENCE
# =============================================================================

quick_reference:
  
  "What source quality?":
    "From subject directly?": "primary"
    "About subject, reliable source?": "secondary"
    "Compilation/summary?": "tertiary"
  
  "What extraction priority?":
    "Primary + 2+ hours + comprehensive?": "CRITICAL"
    "Primary + 1-2 hours?": "VERY HIGH"
    "Primary + 30-60 min?": "HIGH"
    "Secondary + focused?": "MEDIUM"
    "Tertiary?": "LOW"
  
  "What content type?":
    "Exact words?": "direct_quote"
    "Same idea, different words?": "paraphrase"
    "Someone describing subject?": "description"
    "Concrete example?": "example"
    "Observed pattern?": "pattern"
    "Story/narrative?": "anecdote"
    "Your analysis?": "analysis"
    "Multiple sources combined?": "synthesis"
  
  "What relevance score?":
    "Core identity, essential?": "9-10"
    "Major influence?": "7-8"
    "Important but not critical?": "5-6"
    "Nice to know?": "3-4"
    "Trivial?": "1-2"
  
  "How many tags?":
    "Minimum": "3"
    "Recommended": "5-8"
    "Maximum": "15"

# =============================================================================
# 8. TROUBLESHOOTING GUIDE
# =============================================================================

troubleshooting:
  
  problem_1:
    symptom: "Unsure which category to assign"
    solution:
      - "Read the category definitions carefully"
      - "Ask: What does this primarily reveal about the person?"
      - "Use secondary_categories for cross-cutting content"
      - "When truly ambiguous, pick most relevant and note uncertainty"
  
  problem_2:
    symptom: "Relevance scores are all high"
    solution:
      - "Review relevance guidelines - force distribution"
      - "Reserve 9-10 for <5% of fragments"
      - "Ask: Can the clone function without this?"
      - "Be more critical in assessment"
  
  problem_3:
    symptom: "Don't know what tags to use"
    solution:
      - "Review tag taxonomy for ideas"
      - "Use specific (narrow) + general (broad) tags"
      - "Include concrete nouns from content"
      - "Add thematic and categorical tags"
      - "Aim for 5-8 tags per fragment"
  
  problem_4:
    symptom: "Can't extract good insight"
    solution:
      - "Ask: What does this reveal about the person?"
      - "Connect to broader patterns or characteristics"
      - "Don't just restate content - interpret meaning"
      - "Consider implications for clone behavior"
  
  problem_5:
    symptom: "Found contradictions between fragments"
    solution:
      - "Check if context-dependent (both may be true)"
      - "Check if temporal evolution (changed over time)"
      - "Check source quality (trust higher quality)"
      - "Check if known paradox (document as complexity)"
      - "Flag for follow-up if unresolvable"
  
  problem_6:
    symptom: "Extraction is taking too long"
    solution:
      - "Don't perfect at extraction stage - capture and move"
      - "Use batch processing for efficiency"
      - "Save deep analysis for enrichment stage"
      - "Set time limits per source"
      - "Focus on high-priority sources first"
  
  problem_7:
    symptom: "Low confidence in many fragments"
    solution:
      - "Review source quality - may be misclassified"
      - "Seek corroborating sources"
      - "Flag for verification in follow-up"
      - "Consider if worth including at all"
  
  problem_8:
    symptom: "Coverage gaps in important areas"
    solution:
      - "Create gap report with specifics"
      - "Identify needed source types"
      - "Prioritize follow-up interviews on gap areas"
      - "Review existing sources for missed content"

# =============================================================================
# END OF TAXONOMY APPLICATION GUIDE
# =============================================================================
