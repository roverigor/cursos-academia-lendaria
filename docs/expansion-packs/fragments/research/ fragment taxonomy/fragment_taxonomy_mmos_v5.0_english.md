# COMPLETE FRAGMENT TAXONOMY - MMOS v5.0
# Universal Classification System for Cognitive Clone Knowledge Base

taxonomy_version: "5.0"
last_updated: "2025-01-26"
status: "production"
scope: "universal"

# =============================================================================
# 1. FRAGMENT SCHEMA (CORE STRUCTURE)
# =============================================================================

fragment_schema:
  
  # REQUIRED FIELDS
  id:
    type: "string"
    pattern: "FRAG_[CAT]_[000-999]"
    required: true
    unique: true
    example: "FRAG_BIO_001"
    description: "Unique fragment identifier"
  
  category:
    type: "string"
    required: true
    description: "Human-readable category name"
    examples:
      - "Origin and Family"
      - "Cognitive Philosophy"
      - "Communication Style"
      - "Values and Beliefs"
      - "Behavioral Patterns"
      - "Social Relationships"
      - "Meta-cognitive Awareness"
  
  source:
    type: "string"
    required: true
    description: "Source identifier (e.g., SRC_001, SRC_INTERVIEW_2024_01)"
    examples:
      - "SRC_001"
      - "SRC_PODCAST_EP45"
      - "SRC_BOOK_CHAPTER3"
      - "SRC_LINKEDIN_POST_2024_01_15"
  
  location:
    type: "string"
    required: true
    description: "Where in the source this fragment was found"
    examples:
      - "Beginning of conversation, first responses"
      - "Chapter 3, page 47"
      - "Podcast timestamp 15:30-17:45"
      - "LinkedIn post dated 2024-01-15"
      - "Interview section 'Early Life'"
  
  type:
    type: "string"
    required: true
    values:
      - "direct_quote"        # Literal word-for-word quote
      - "paraphrase"          # Same idea, different words
      - "description"         # Third-party description
      - "example"             # Concrete example of behavior
      - "pattern"             # Identified pattern from multiple sources
      - "anecdote"            # Story or specific case
      - "analysis"            # Researcher analysis
      - "synthesis"           # Synthesis of multiple sources
    description: "Type of content in the fragment"
  
  relevance:
    type: "integer"
    required: true
    range: [1, 10]
    description: "Relevance score for cognitive clone (1=low, 10=critical)"
    guidelines:
      10: "Critical - Core identity, essential for clone accuracy"
      9: "Very High - Major influence on personality/behavior"
      8: "High - Important characteristic or belief"
      7: "Significant - Notable trait or pattern"
      6: "Above Average - Useful contextual information"
      5: "Average - Standard biographical/contextual data"
      4: "Below Average - Minor detail with some value"
      3: "Low - Peripheral information"
      2: "Very Low - Minimal impact on clone"
      1: "Trivial - Negligible importance"
  
  content:
    type: "string"
    required: true
    description: "The actual fragment content - the quote, description, or observation"
    examples:
      - "Well, I was born in Maricá, but I spent little time there, only until I was two years old. There I lived with my mother, father, and older brother."
      - "When facing a complex problem, Pedro always starts by drawing diagrams and mapping relationships between elements before attempting any solution."
      - "According to close colleagues, Pedro becomes visibly energized when discussing systems thinking and often loses track of time in these conversations."
  
  context:
    type: "string"
    required: true
    description: "The situational context in which this fragment was captured or what it describes"
    examples:
      - "Describing family origins"
      - "Explaining problem-solving approach"
      - "Discussing decision-making under pressure"
      - "Response to question about early influences"
      - "Spontaneous comment during team meeting"
  
  insight:
    type: "string"
    required: true
    description: "Key insight or takeaway extracted from this fragment - what this reveals about the person"
    examples:
      - "Born in Maricá (RJ), nuclear family with older brother, short time in hometown - early mobility may have influenced adaptability"
      - "Systematic visual thinker who needs to externalize mental models before analyzing - suggests strong visual-spatial intelligence"
      - "Values direct communication and becomes frustrated with ambiguous instructions - indicates preference for clarity and precision"
  
  tags:
    type: "array[string]"
    required: true
    description: "Thematic tags for categorization, search and filtering"
    examples:
      - ["origin", "maricá", "nuclear_family", "childhood", "mobility"]
      - ["problem_solving", "visual_thinking", "systems_approach", "methodology"]
      - ["communication_style", "directness", "clarity", "frustration_triggers"]
      - ["values", "integrity", "honesty", "authenticity"]
    guidelines: "Use lowercase, underscore-separated tags; include both specific and general tags"
  
  # OPTIONAL METADATA (for enhanced tracking and analysis)
  metadata:
    confidence:
      type: "float"
      required: false
      range: [0.0, 1.0]
      description: "Confidence level in this fragment (0.0-1.0)"
      guidelines:
        "0.9-1.0": "Very high - direct primary source, verified"
        "0.7-0.89": "High - primary source or corroborated secondary"
        "0.5-0.69": "Medium - secondary source or needs validation"
        "0.3-0.49": "Low - tertiary source or conflicting information"
        "0.0-0.29": "Very low - speculative or unverified"
    
    verified:
      type: "boolean"
      required: false
      description: "Whether this fragment has been verified against multiple sources"
    
    timestamp:
      type: "datetime"
      required: false
      description: "When this fragment was captured or created"
    
    related_fragments:
      type: "array[string]"
      required: false
      description: "IDs of related fragments (e.g., ['FRAG_COG_023', 'FRAG_BEH_015'])"
    
    contradicts:
      type: "array[string]"
      required: false
      description: "IDs of fragments this contradicts (for tracking inconsistencies)"
    
    notes:
      type: "string"
      required: false
      description: "Additional researcher notes, observations, or questions"

# =============================================================================
# 2. COMPLETE EXAMPLE FRAGMENT
# =============================================================================

example_fragment:
  id: "FRAG_BIO_001"
  category: "Origin and Family"
  source: "SRC_001"
  location: "Beginning of conversation, first responses"
  type: "direct_quote"
  relevance: 10
  content: "Well, I was born in Maricá, but I spent little time there, only until I was two years old. There I lived with my mother, father, and older brother."
  context: "Describing family origins in response to question about childhood"
  insight: "Born in Maricá (RJ), nuclear family with older brother, short time in hometown - early mobility may have influenced adaptability and lack of strong geographic identity"
  tags: ["origin", "maricá", "nuclear_family", "older_brother", "childhood", "mobility", "geographic_identity"]
  metadata:
    confidence: 0.95
    verified: true
    timestamp: "2024-01-15T14:30:00Z"
    related_fragments: ["FRAG_BIO_002", "FRAG_BIO_005"]
    notes: "Direct quote from primary source, high confidence. Consider exploring significance of early mobility."

# =============================================================================
# 3. CATEGORY DEFINITIONS
# =============================================================================

categories:
  
  biographical:
    name: "Biographical"
    code: "BIO"
    description: "Life history, education, formative experiences, and trajectory"
    subcategories:
      - "Origin and Family"
      - "Childhood and Adolescence"
      - "Formal Education"
      - "Formative Experiences"
      - "Milestone Events"
      - "Key Relationships"
      - "Professional Trajectory"
      - "Achievements and Milestones"
  
  cognitive:
    name: "Cognitive"
    code: "COG"
    description: "Thought systems, mental processes, and philosophical frameworks"
    subcategories:
      - "Core Philosophy"
      - "Thinking Process"
      - "Decision Making"
      - "Mental Frameworks"
      - "World Models"
      - "Epistemology"
      - "Problem Solving Approach"
      - "Learning Style"
  
  communicative:
    name: "Communicative"
    code: "COM"
    description: "Communication patterns, expression style, and language use"
    subcategories:
      - "Verbal Style"
      - "Vocabulary and Terminology"
      - "Metaphors and Analogies"
      - "Humor and Wit"
      - "Storytelling Approach"
      - "Persuasion Techniques"
      - "Teaching Style"
      - "Writing vs Speaking"
  
  behavioral:
    name: "Behavioral"
    code: "BEH"
    description: "Observable behaviors, habits, routines, and action patterns"
    subcategories:
      - "Daily Routines"
      - "Work Habits"
      - "Creative Process"
      - "Time Management"
      - "Rituals and Practices"
      - "Behavioral Triggers"
      - "Reaction Patterns"
      - "Stress Responses"
  
  values_beliefs:
    name: "Values and Beliefs"
    code: "VAL"
    description: "Core values, beliefs, principles, and ethical positions"
    subcategories:
      - "Core Values"
      - "Ethical Principles"
      - "Fundamental Beliefs"
      - "Moral Framework"
      - "Controversial Positions"
      - "Worldview"
      - "Spirituality"
      - "Political Views"
  
  social:
    name: "Social"
    code: "SOC"
    description: "Social relationships, interactions, and interpersonal dynamics"
    subcategories:
      - "Close Relationships"
      - "Professional Network"
      - "Social Influences"
      - "Group Dynamics"
      - "Leadership Style"
      - "Collaboration Patterns"
      - "Conflict Resolution"
      - "Social Boundaries"
  
  meta_cognitive:
    name: "Meta-cognitive"
    code: "META"
    description: "Self-awareness, internal contradictions, and personal evolution"
    subcategories:
      - "Self-Awareness"
      - "Internal Contradictions"
      - "Thought Evolution"
      - "Blind Spots"
      - "Recurring Dilemmas"
      - "Personal Growth"
      - "Self-Reflection Patterns"
      - "Identity Construction"
  
  validation:
    name: "Source Validation"
    code: "VAL_SRC"
    description: "Validation, verification, and fact-checking"
    subcategories:
      - "Famous Quotes"
      - "Published Works"
      - "Known Anecdotes"
      - "Fact Checking"
      - "Cross-References"
      - "Disputed Claims"

# =============================================================================
# 4. CONTENT TYPES - DETAILED SPECIFICATIONS
# =============================================================================

content_types:
  
  direct_quote:
    name: "Direct Quote"
    verbatim: true
    description: "Word-for-word literal citation from the person"
    usage: "Use when exact wording is important and available"
    examples:
      - "I think the biggest mistake people make is..."
      - "My philosophy has always been: act, measure, learn, repeat."
    best_practices:
      - "Always use quotation marks in content field"
      - "Preserve original language and tone"
      - "Note any edits with [brackets] or [...]"
      - "High relevance for signature phrases and core beliefs"
  
  paraphrase:
    name: "Paraphrase"
    verbatim: false
    description: "Same idea expressed in different words"
    usage: "Use when exact words unavailable but meaning is clear"
    examples:
      - "Pedro explained that he believes failure is just data for the next iteration"
      - "According to the interview, he approaches problems systematically"
    best_practices:
      - "Maintain original meaning faithfully"
      - "Note it's a paraphrase in context or notes"
      - "Useful when original is too long or unclear"
  
  description:
    name: "Description"
    verbatim: false
    description: "Third-party description or observation about the person"
    usage: "Use for external perspectives and observations"
    examples:
      - "Colleagues describe him as intensely focused during problem-solving"
      - "In team meetings, he consistently draws diagrams on the whiteboard"
    best_practices:
      - "Clearly attribute to observer in content or context"
      - "Note observer's relationship to subject"
      - "Useful for behavioral patterns others notice"
  
  example:
    name: "Example"
    verbatim: false
    description: "Concrete example illustrating a behavior or thought pattern"
    usage: "Use to demonstrate patterns through specific instances"
    examples:
      - "When the project faced delays, he immediately created a visual timeline and identified the critical path"
      - "In the Q&A session, he answered each question with a real-world story first, then the principle"
    best_practices:
      - "Include enough detail to be illustrative"
      - "Link to pattern or principle it demonstrates"
      - "Very useful for clone training"
  
  pattern:
    name: "Pattern"
    verbatim: false
    description: "Pattern identified across multiple observations or sources"
    usage: "Use when synthesizing consistent behavior across contexts"
    examples:
      - "Across 15 podcast interviews, he starts 73% of explanations with a real-world analogy"
      - "Pattern: Always seeks to understand 'why' before 'how' in problem-solving"
    best_practices:
      - "Note frequency and contexts where observed"
      - "Include number of observations when possible"
      - "High value for cognitive clone accuracy"
      - "Link to supporting fragments in metadata"
  
  anecdote:
    name: "Anecdote"
    verbatim: false
    description: "Story or specific narrative event"
    usage: "Use for memorable stories that reveal character or values"
    examples:
      - "He tells the story of losing everything in 2015 and how it taught him that material things are recoverable but time and relationships aren't"
    best_practices:
      - "Capture narrative arc and emotional tone"
      - "Note if frequently repeated (signature story)"
      - "Extract insights about values and beliefs"
      - "High relevance if story shapes identity"
  
  analysis:
    name: "Analysis"
    verbatim: false
    description: "Researcher's analytical interpretation"
    usage: "Use for expert analysis and psychological insights"
    examples:
      - "Analysis: His communication style shows strong influence of Socratic method, consistently using questions to guide rather than direct statements"
    best_practices:
      - "Clearly label as analysis"
      - "Note analyst credentials/expertise"
      - "Support with evidence (link fragments)"
      - "Lower confidence than primary sources"
  
  synthesis:
    name: "Synthesis"
    verbatim: false
    description: "Synthesis combining multiple sources or fragments"
    usage: "Use when integrating information from various sources"
    examples:
      - "Synthesizing 5 interviews (2020-2024): His view on AI has evolved from tool-focused to emphasizing human-AI collaboration"
    best_practices:
      - "List sources synthesized"
      - "Note any conflicts or evolution"
      - "High value for understanding development"
      - "Link all source fragments in metadata"

# =============================================================================
# 5. RELEVANCE SCORING GUIDELINES
# =============================================================================

relevance_scoring:
  
  score_10_critical:
    description: "Critical for clone identity and core functioning"
    examples:
      - "Core philosophical beliefs"
      - "Defining life experiences"
      - "Fundamental values and principles"
      - "Signature communication patterns"
      - "Essential decision-making frameworks"
    usage: "Reserve for truly defining elements - typically <5% of fragments"
  
  score_9_very_high:
    description: "Very high importance - major personality/behavior influence"
    examples:
      - "Key formative experiences"
      - "Primary cognitive patterns"
      - "Major relationship influences"
      - "Core skills and expertise"
    usage: "Major elements that significantly shape responses - ~5-10% of fragments"
  
  score_8_high:
    description: "High importance - important characteristics"
    examples:
      - "Significant behavioral patterns"
      - "Important beliefs and values"
      - "Notable skills or knowledge areas"
      - "Key professional experiences"
    usage: "Important but not absolutely essential - ~10-15% of fragments"
  
  score_7_significant:
    description: "Significant - notable traits worth knowing"
    examples:
      - "Interesting anecdotes revealing character"
      - "Specific communication preferences"
      - "Particular problem-solving approaches"
      - "Relevant background information"
    usage: "Adds depth and nuance - ~15-20% of fragments"
  
  score_5_6_average:
    description: "Average - standard biographical/contextual information"
    examples:
      - "General background information"
      - "Standard biographical facts"
      - "Routine behavioral observations"
      - "Contextual details"
    usage: "Useful context but not defining - ~30-40% of fragments"
  
  score_3_4_low:
    description: "Below average to low - minor details"
    examples:
      - "Peripheral information"
      - "Minor preferences or habits"
      - "Tangential biographical details"
      - "Low-impact observations"
    usage: "Nice to have but low priority - ~10-20% of fragments"
  
  score_1_2_trivial:
    description: "Very low to trivial - minimal importance"
    examples:
      - "Trivia and minor facts"
      - "Irrelevant personal details"
      - "Unverified rumors"
      - "Tangential information"
    usage: "Consider if worth including - <5% of fragments"

# =============================================================================
# 6. TAG TAXONOMY
# =============================================================================

tag_categories:
  
  # BIOGRAPHICAL TAGS
  biographical:
    - origin
    - family
    - childhood
    - education
    - career
    - milestones
    - relationships
    - formative_experience
    - trauma
    - success
    - failure
    - transition
    - location
    - migration
  
  # COGNITIVE TAGS
  cognitive:
    - philosophy
    - worldview
    - epistemology
    - mental_model
    - framework
    - systems_thinking
    - analytical_thinking
    - creative_thinking
    - critical_thinking
    - strategic_thinking
    - decision_making
    - problem_solving
    - learning_style
    - memory
    - attention
  
  # BEHAVIORAL TAGS
  behavioral:
    - routine
    - habit
    - process
    - methodology
    - ritual
    - discipline
    - spontaneity
    - productivity
    - procrastination
    - action_bias
    - reflection_practice
    - time_management
    - energy_management
    - trigger
    - response_pattern
  
  # COMMUNICATIVE TAGS
  communicative:
    - communication_style
    - verbal_style
    - writing_style
    - vocabulary
    - metaphor
    - analogy
    - storytelling
    - humor
    - sarcasm
    - directness
    - diplomacy
    - persuasion
    - teaching
    - questioning
    - listening
  
  # VALUES TAGS
  values:
    - integrity
    - honesty
    - loyalty
    - freedom
    - justice
    - excellence
    - growth
    - contribution
    - authenticity
    - pragmatism
    - idealism
    - courage
    - compassion
    - discipline
    - curiosity
  
  # EMOTIONAL TAGS
  emotional:
    - emotional_intelligence
    - empathy
    - resilience
    - optimism
    - pessimism
    - anxiety
    - confidence
    - fear
    - anger
    - joy
    - sadness
    - frustration
    - passion
    - calm
    - intensity
  
  # SOCIAL TAGS
  social:
    - relationship
    - collaboration
    - leadership
    - mentorship
    - networking
    - conflict
    - boundary_setting
    - influence
    - social_style
    - introversion
    - extroversion
    - trust
    - vulnerability
    - assertiveness
  
  # TECHNICAL TAGS
  technical:
    - expertise
    - skill
    - knowledge_domain
    - tool
    - methodology
    - technique
    - technology
    - industry
    - specialization
  
  # META TAGS
  meta:
    - self_awareness
    - self_reflection
    - contradiction
    - evolution
    - growth
    - blind_spot
    - paradox
    - identity
    - purpose
    - meaning

# =============================================================================
# 7. SOURCE TRACKING SCHEMA
# =============================================================================

source_schema:
  
  source_id:
    type: "string"
    pattern: "SRC_[000-999]"
    required: true
    unique: true
    example: "SRC_001"
  
  source_type:
    type: "string"
    required: true
    values:
      - "interview"
      - "podcast"
      - "video"
      - "book"
      - "article"
      - "social_media"
      - "email"
      - "document"
      - "observation"
      - "conversation"
      - "presentation"
  
  title:
    type: "string"
    required: true
    description: "Title or description of the source"
  
  date:
    type: "datetime"
    required: true
    description: "Date of source creation or publication"
  
  url:
    type: "string"
    required: false
    description: "URL if available online"
  
  quality:
    type: "string"
    required: true
    values: ["primary", "secondary", "tertiary"]
    description: "Source quality classification"
  
  metadata:
    author: "string"
    publisher: "string"
    interviewer: "string"
    duration: "string"
    page_count: "integer"
    language: "string"
    notes: "string"

# =============================================================================
# 8. WORKFLOW AND BEST PRACTICES
# =============================================================================

workflow:
  
  extraction_process:
    step_1:
      name: "Source Review"
      description: "Review source material thoroughly"
      output: "Initial fragment candidates identified"
    
    step_2:
      name: "Fragment Creation"
      description: "Create fragments with all required fields"
      output: "Draft fragments with id, category, source, location, type, content, context"
    
    step_3:
      name: "Analysis"
      description: "Extract insights and assign relevance"
      output: "Fragments enriched with insight and relevance score"
    
    step_4:
      name: "Tagging"
      description: "Apply comprehensive tags"
      output: "Fragments tagged for categorization and search"
    
    step_5:
      name: "Verification"
      description: "Verify accuracy and add metadata"
      output: "Verified fragments with confidence scores"
    
    step_6:
      name: "Relationship Mapping"
      description: "Link related fragments"
      output: "Complete fragments with relationships"
  
  quality_checklist:
    - "[ ] All required fields completed"
    - "[ ] Content is clear and accurate"
    - "[ ] Context provides sufficient situational information"
    - "[ ] Insight extracts key takeaway"
    - "[ ] Relevance score justified"
    - "[ ] Tags are specific and comprehensive"
    - "[ ] Source properly documented"
    - "[ ] Location in source is precise"
    - "[ ] Type correctly classified"
    - "[ ] Related fragments linked if applicable"
  
  best_practices:
    - "Be specific: Vague fragments have limited value"
    - "Be accurate: Verify before marking high confidence"
    - "Be comprehensive: Use multiple tags for rich categorization"
    - "Be insightful: Extract meaning, don't just record facts"
    - "Be consistent: Use standard terminology and formats"
    - "Be relational: Link fragments that inform each other"
    - "Be selective: Not everything needs to be a fragment"
    - "Be honest: Mark confidence appropriately"

# =============================================================================
# 9. VALIDATION RULES
# =============================================================================

validation_rules:
  
  required_fields_validation:
    critical:
      - id
      - category
      - source
      - location
      - type
      - relevance
      - content
      - context
      - insight
      - tags
    
    error_on_missing: true
    
  format_validation:
    id_pattern: "FRAG_[A-Z]+_[0-9]{3}"
    relevance_range: [1, 10]
    tags_minimum: 2
    tags_maximum: 20
    content_min_length: 10
    insight_min_length: 20
  
  quality_thresholds:
    minimum_relevance_for_critical_category: 7
    maximum_fragments_with_relevance_10: "5%"
    recommended_confidence_for_high_relevance: 0.7
  
  consistency_checks:
    - "Check for duplicate content"
    - "Verify source exists"
    - "Validate related fragment IDs exist"
    - "Check for contradictions"
    - "Verify tags are from approved taxonomy"

# =============================================================================
# 10. EXPORT AND INTEGRATION
# =============================================================================

export_formats:
  
  json:
    format: "json"
    structure: "array of fragment objects"
    usage: "API integration, system processing"
    example: |
      [
        {
          "id": "FRAG_BIO_001",
          "category": "Origin and Family",
          "source": "SRC_001",
          "location": "Beginning of conversation",
          "type": "direct_quote",
          "relevance": 10,
          "content": "...",
          "context": "...",
          "insight": "...",
          "tags": ["origin", "family"],
          "metadata": {...}
        }
      ]
  
  yaml:
    format: "yaml"
    structure: "fragment list"
    usage: "Human editing, version control"
  
  csv:
    format: "csv"
    structure: "flat table"
    usage: "Spreadsheet analysis, filtering"
    columns: "id,category,source,location,type,relevance,content,context,insight,tags"
  
  markdown:
    format: "markdown"
    structure: "readable document"
    usage: "Documentation, review, presentation"

# =============================================================================
# END OF TAXONOMY
# =============================================================================
