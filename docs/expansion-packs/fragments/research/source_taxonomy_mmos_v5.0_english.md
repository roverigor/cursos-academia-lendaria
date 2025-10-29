# SOURCE TAXONOMY - MMOS v5.0
# Classification System for Information Sources in Cognitive Clone Development

taxonomy_version: "5.0"
last_updated: "2025-01-26"
status: "production"
scope: "source_tracking"

# =============================================================================
# 1. SOURCE SCHEMA (CORE STRUCTURE)
# =============================================================================

source_schema:
  
  # REQUIRED FIELDS
  id:
    type: "string"
    pattern: "SRC_[000-999]"
    required: true
    unique: true
    example: "SRC_001"
    description: "Unique source identifier"
  
  title:
    type: "string"
    required: true
    description: "Title or clear description of the source"
    examples:
      - "Discovery Interview - Life History and Origins"
      - "Podcast: The Tim Ferriss Show Episode 432"
      - "Book: Thinking, Fast and Slow by Daniel Kahneman"
      - "LinkedIn Post: Thoughts on AI and Business"
  
  type:
    type: "string"
    required: true
    description: "Type of source material"
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
      - "workshop"
      - "webinar"
  
  quality:
    type: "string"
    required: true
    description: "Source quality classification"
    values:
      - "primary"      # Direct from the person
      - "secondary"    # About the person by reliable source
      - "tertiary"     # Compilation or synthesis
  
  date:
    type: "datetime"
    required: true
    format: "YYYY-MM-DD or YYYY-MM-DDTHH:MM:SSZ"
    description: "Date of source creation, publication, or capture"
    examples:
      - "2024-01-15"
      - "2024-01-15T14:30:00Z"
  
  # OPTIONAL BUT RECOMMENDED FIELDS
  url:
    type: "string"
    required: false
    description: "URL if source is available online"
    examples:
      - "https://example.com/podcast/episode-123"
      - "https://linkedin.com/posts/username-123456789"
  
  author:
    type: "string"
    required: false
    description: "Author, creator, or interviewer"
    examples:
      - "Tim Ferriss"
      - "Internal research team"
      - "Self (subject being cloned)"
  
  language:
    type: "string"
    required: false
    default: "en"
    description: "Language of the source"
    examples:
      - "en"
      - "pt-BR"
      - "es"
  
  # METADATA
  metadata:
    duration:
      type: "string"
      required: false
      description: "Duration for audio/video"
      examples:
        - "1:45:30"
        - "45 minutes"
    
    page_count:
      type: "integer"
      required: false
      description: "Page count for written materials"
    
    word_count:
      type: "integer"
      required: false
      description: "Word count for written materials"
    
    publisher:
      type: "string"
      required: false
      description: "Publisher or platform"
    
    access_level:
      type: "string"
      required: false
      values: ["public", "private", "restricted"]
      description: "Accessibility of source"
    
    format:
      type: "string"
      required: false
      examples:
        - "mp3"
        - "mp4"
        - "pdf"
        - "docx"
        - "transcript"
    
    notes:
      type: "string"
      required: false
      description: "Additional notes about the source"
    
    fragments_extracted:
      type: "integer"
      required: false
      description: "Number of fragments extracted from this source"
    
    extraction_status:
      type: "string"
      required: false
      values: ["pending", "in_progress", "completed", "reviewed"]
    
    confidence_rating:
      type: "float"
      required: false
      range: [0.0, 1.0]
      description: "Overall confidence in this source"

# =============================================================================
# 2. SOURCE TYPES - DETAILED SPECIFICATIONS
# =============================================================================

source_types:
  
  interview:
    name: "Interview"
    quality_default: "primary"
    description: "Direct interview with the subject"
    characteristics:
      - "One-on-one or panel format"
      - "Structured or unstructured questions"
      - "High depth potential"
      - "Direct quotes available"
    subtypes:
      - "discovery_interview"       # Initial comprehensive interview
      - "deep_dive_interview"       # Focused on specific area
      - "follow_up_interview"       # Clarification and expansion
      - "biographical_interview"    # Life history focused
      - "technical_interview"       # Expertise/skills focused
    best_for:
      - "Biographical information"
      - "Core beliefs and values"
      - "Decision-making processes"
      - "Personal stories and anecdotes"
    extraction_priority: "HIGH"
    typical_fragments_per_hour: "30-50"
    
  podcast:
    name: "Podcast"
    quality_default: "primary"
    description: "Audio podcast featuring the subject"
    characteristics:
      - "Conversational format"
      - "Often long-form (1-3 hours)"
      - "Natural communication style"
      - "Multiple topics covered"
    subtypes:
      - "guest_appearance"          # Subject as guest
      - "host_episode"              # Subject as host
      - "panel_discussion"          # Multiple participants
    best_for:
      - "Communication style"
      - "Natural speech patterns"
      - "Storytelling approach"
      - "Humor and personality"
      - "Casual beliefs and opinions"
    extraction_priority: "HIGH"
    typical_fragments_per_hour: "25-40"
    notes: "Requires transcription if not already available"
    
  video:
    name: "Video"
    quality_default: "primary"
    description: "Video content featuring the subject"
    characteristics:
      - "Visual and audio information"
      - "Body language observable"
      - "Presentation style visible"
      - "Context-rich"
    subtypes:
      - "youtube_video"
      - "conference_talk"
      - "course_content"
      - "interview_video"
      - "vlog"
      - "documentary"
    best_for:
      - "Presentation style"
      - "Body language patterns"
      - "Visual communication"
      - "Teaching approach"
      - "Public persona"
    extraction_priority: "HIGH"
    typical_fragments_per_hour: "20-35"
    notes: "Transcription recommended; note non-verbal elements"
    
  book:
    name: "Book"
    quality_default: "primary"
    description: "Book written by or about the subject"
    characteristics:
      - "Highly structured content"
      - "Edited and polished"
      - "Comprehensive coverage"
      - "Intentional message"
    subtypes:
      - "authored_book"             # Written by subject
      - "co_authored_book"          # Co-written
      - "biography"                 # About the subject
      - "autobiography"             # By subject about themselves
      - "anthology_contribution"    # Chapter or section
    best_for:
      - "Refined philosophy"
      - "Structured thinking"
      - "Expertise demonstration"
      - "Core teachings"
      - "Historical information"
    extraction_priority: "VERY HIGH"
    typical_fragments_per_100_pages: "50-100"
    notes: "High-quality source; invest time in thorough extraction"
    
  article:
    name: "Article"
    quality_default: "primary or secondary"
    description: "Written article by or about the subject"
    characteristics:
      - "Focused on specific topic"
      - "Structured argument"
      - "Professional tone"
      - "Citable"
    subtypes:
      - "blog_post"                 # Subject's blog
      - "guest_post"                # Guest contribution
      - "magazine_article"          # Magazine feature
      - "academic_paper"            # Research paper
      - "opinion_piece"             # Editorial/opinion
      - "profile_article"           # About the subject
    best_for:
      - "Specific viewpoints"
      - "Technical knowledge"
      - "Professional positions"
      - "Time-specific context"
    extraction_priority: "MEDIUM to HIGH"
    typical_fragments_per_article: "5-15"
    notes: "Quality varies; verify if primary or secondary"
    
  social_media:
    name: "Social Media"
    quality_default: "primary"
    description: "Social media posts and content"
    characteristics:
      - "Short-form content"
      - "Informal tone"
      - "Real-time thoughts"
      - "Authentic voice"
    subtypes:
      - "twitter_thread"
      - "linkedin_post"
      - "facebook_post"
      - "instagram_caption"
      - "reddit_comment"
      - "youtube_comment"
    best_for:
      - "Informal opinions"
      - "Quick reactions"
      - "Current thoughts"
      - "Casual communication style"
      - "Daily life glimpses"
    extraction_priority: "MEDIUM"
    typical_fragments_per_post: "1-3"
    notes: "High volume, quick extraction; verify authenticity"
    
  email:
    name: "Email"
    quality_default: "primary"
    description: "Email correspondence"
    characteristics:
      - "Private communication"
      - "Direct and specific"
      - "Often unedited"
      - "Context-dependent"
    subtypes:
      - "personal_email"
      - "business_email"
      - "newsletter"
      - "email_list_response"
    best_for:
      - "Private thoughts"
      - "Decision-making process"
      - "Communication style"
      - "Relationship dynamics"
    extraction_priority: "MEDIUM to HIGH"
    typical_fragments_per_email: "2-8"
    notes: "Privacy considerations; ensure permission"
    
  document:
    name: "Document"
    quality_default: "primary"
    description: "Written documents and materials"
    characteristics:
      - "Formal or informal"
      - "Purpose-driven"
      - "Often comprehensive"
      - "Reference material"
    subtypes:
      - "whitepaper"
      - "report"
      - "presentation_slides"
      - "course_materials"
      - "internal_memo"
      - "personal_notes"
      - "journal_entry"
    best_for:
      - "Structured thinking"
      - "Professional work"
      - "Technical content"
      - "Private reflections"
    extraction_priority: "MEDIUM to HIGH"
    typical_fragments_per_document: "varies widely"
    notes: "Quality and relevance vary significantly"
    
  observation:
    name: "Observation"
    quality_default: "secondary"
    description: "Direct observation by researcher"
    characteristics:
      - "Real-time behavior"
      - "Unfiltered actions"
      - "Contextual"
      - "Researcher interpretation"
    subtypes:
      - "meeting_observation"
      - "work_observation"
      - "social_observation"
      - "behavioral_note"
    best_for:
      - "Behavioral patterns"
      - "Unconscious habits"
      - "Interaction styles"
      - "Environmental preferences"
    extraction_priority: "MEDIUM"
    typical_fragments_per_hour: "10-20"
    notes: "Include observer notes and context"
    
  conversation:
    name: "Conversation"
    quality_default: "primary"
    description: "Informal conversation with subject"
    characteristics:
      - "Unstructured"
      - "Natural flow"
      - "Spontaneous"
      - "Relationship-building"
    subtypes:
      - "casual_chat"
      - "phone_call"
      - "video_call"
      - "in_person_meeting"
    best_for:
      - "Natural communication"
      - "Spontaneous thoughts"
      - "Relationship patterns"
      - "Casual beliefs"
    extraction_priority: "MEDIUM"
    typical_fragments_per_hour: "15-25"
    notes: "Document immediately after; memory fades quickly"
    
  presentation:
    name: "Presentation"
    quality_default: "primary"
    description: "Formal presentation or talk"
    characteristics:
      - "Prepared content"
      - "Structured delivery"
      - "Professional context"
      - "Audience interaction"
    subtypes:
      - "keynote"
      - "workshop"
      - "webinar"
      - "conference_talk"
      - "training_session"
      - "ted_talk"
    best_for:
      - "Teaching style"
      - "Core messages"
      - "Public persona"
      - "Expertise areas"
      - "Communication techniques"
    extraction_priority: "HIGH"
    typical_fragments_per_hour: "20-30"
    notes: "Get both slides and transcript if possible"

# =============================================================================
# 3. SOURCE QUALITY CLASSIFICATION
# =============================================================================

quality_classification:
  
  primary:
    name: "Primary Source"
    definition: "Content directly from the subject"
    confidence_base: 1.0
    characteristics:
      - "First-hand account"
      - "Direct quotes available"
      - "Unmediated expression"
      - "Highest authenticity"
    examples:
      - "Interview where subject speaks"
      - "Book written by subject"
      - "Subject's social media posts"
      - "Subject's emails"
      - "Subject's presentations"
    usage_guidelines:
      - "Default for most fragments from this source"
      - "Highest priority for extraction"
      - "Minimal interpretation needed"
      - "Direct quotes preferred"
    verification_level: "Minimal (verify authenticity of source itself)"
    
  secondary:
    name: "Secondary Source"
    definition: "Content about the subject from reliable sources"
    confidence_base: 0.8
    characteristics:
      - "One degree of separation"
      - "Professional quality"
      - "Researched and verified"
      - "Expert perspective"
    examples:
      - "Biography by credible author"
      - "Interview with close collaborator"
      - "Documentary about subject"
      - "Professional article about subject"
      - "Academic analysis of subject's work"
    usage_guidelines:
      - "Use for external perspectives"
      - "Cross-reference with primary sources"
      - "Note observer bias"
      - "Valuable for behavioral patterns"
    verification_level: "Moderate (cross-check key claims)"
    
  tertiary:
    name: "Tertiary Source"
    definition: "Compilations or summaries of other sources"
    confidence_base: 0.6
    characteristics:
      - "Multiple degrees of separation"
      - "Summarized information"
      - "Potential inaccuracies"
      - "General overview"
    examples:
      - "Wikipedia articles"
      - "General summaries"
      - "Third-party aggregations"
      - "Indirect citations"
    usage_guidelines:
      - "Use sparingly"
      - "Always verify against primary sources"
      - "Useful for initial research only"
      - "Flag for verification"
    verification_level: "High (must verify all key information)"

# =============================================================================
# 4. SOURCE PRIORITIZATION MATRIX
# =============================================================================

prioritization_matrix:
  
  priority_levels:
    
    CRITICAL:
      description: "Extract immediately and comprehensively"
      characteristics:
        - "Primary source"
        - "Comprehensive coverage"
        - "Direct access to subject"
        - "High-quality content"
      source_types:
        - "Extended discovery interviews (2+ hours)"
        - "Books authored by subject"
        - "Multi-episode podcast series"
        - "Comprehensive video courses"
      extraction_approach: "Deep, thorough, multi-pass"
      time_allocation: "Maximum - worth 40%+ of total effort"
      
    VERY_HIGH:
      description: "Extract thoroughly within days"
      characteristics:
        - "Primary source"
        - "Substantial content"
        - "Good depth"
        - "Professional quality"
      source_types:
        - "Single long interview (1-2 hours)"
        - "Podcast guest appearances"
        - "Conference keynotes"
        - "Long-form articles by subject"
        - "Professional presentations"
      extraction_approach: "Thorough, systematic"
      time_allocation: "Significant - 30-40% of effort"
      
    HIGH:
      description: "Extract within 1-2 weeks"
      characteristics:
        - "Primary or quality secondary"
        - "Moderate depth"
        - "Focused content"
        - "Good quality"
      source_types:
        - "Short interviews (30-60 min)"
        - "Blog posts by subject"
        - "Social media threads"
        - "Short videos"
        - "Professional documents"
      extraction_approach: "Systematic, efficient"
      time_allocation: "Moderate - 15-25% of effort"
      
    MEDIUM:
      description: "Extract within a month"
      characteristics:
        - "Secondary sources"
        - "Specific topics only"
        - "Limited scope"
        - "Supplementary value"
      source_types:
        - "Articles about subject"
        - "Brief social media posts"
        - "Email correspondence"
        - "Observation notes"
        - "Casual conversations"
      extraction_approach: "Targeted, selective"
      time_allocation: "Limited - 5-15% of effort"
      
    LOW:
      description: "Extract if time permits"
      characteristics:
        - "Tertiary sources"
        - "Limited value"
        - "Questionable quality"
        - "Fill gaps only"
      source_types:
        - "Wikipedia entries"
        - "General summaries"
        - "Unverified claims"
        - "Tangential mentions"
      extraction_approach: "Quick scan, cherry-pick"
      time_allocation: "Minimal - <5% of effort"

# =============================================================================
# 5. SOURCE METADATA TRACKING
# =============================================================================

metadata_tracking:
  
  extraction_metrics:
    fragments_extracted:
      type: "integer"
      description: "Total fragments extracted from this source"
    
    extraction_time:
      type: "duration"
      description: "Time spent extracting (hours:minutes)"
    
    extraction_date:
      type: "datetime"
      description: "When extraction was completed"
    
    extracted_by:
      type: "string"
      description: "Who performed the extraction"
    
    review_status:
      type: "string"
      values: ["not_reviewed", "in_review", "reviewed", "approved"]
    
    reviewed_by:
      type: "string"
      description: "Who reviewed the extraction"
    
    review_date:
      type: "datetime"
      description: "When review was completed"
  
  quality_metrics:
    content_richness:
      type: "float"
      range: [0.0, 10.0]
      description: "How information-rich is this source"
    
    relevance_score:
      type: "float"
      range: [0.0, 10.0]
      description: "How relevant to clone development"
    
    clarity_score:
      type: "float"
      range: [0.0, 10.0]
      description: "How clear and unambiguous"
    
    depth_score:
      type: "float"
      range: [0.0, 10.0]
      description: "How deep vs surface-level"
    
    authenticity_score:
      type: "float"
      range: [0.0, 10.0]
      description: "How authentic and unfiltered"
  
  coverage_tracking:
    categories_covered:
      type: "array[string]"
      description: "Which categories this source provides information on"
      examples:
        - ["Biographical", "Cognitive", "Values"]
    
    topics_covered:
      type: "array[string]"
      description: "Specific topics addressed"
    
    gaps_identified:
      type: "array[string]"
      description: "What this source doesn't cover well"

# =============================================================================
# 6. SOURCE COLLECTION STRATEGY
# =============================================================================

collection_strategy:
  
  phase_1_foundation:
    name: "Foundation Building"
    duration: "Week 1-2"
    goal: "Establish core understanding"
    priority_sources:
      - "Extended discovery interview (3-4 hours)"
      - "Most recent comprehensive interview/podcast"
      - "Primary book by subject (if exists)"
      - "Recent presentations/talks"
    target_fragments: "100-200"
    coverage_goal: "Broad overview of all categories"
    
  phase_2_depth:
    name: "Depth Development"
    duration: "Week 3-4"
    goal: "Deep dive into specific areas"
    priority_sources:
      - "Focused interviews on specific topics"
      - "Multiple podcast appearances"
      - "Articles and blog posts"
      - "Additional books/chapters"
    target_fragments: "150-250"
    coverage_goal: "Deep coverage of 3-4 key categories"
    
  phase_3_breadth:
    name: "Breadth Expansion"
    duration: "Week 5-6"
    goal: "Fill gaps and add nuance"
    priority_sources:
      - "Social media content"
      - "Email correspondence"
      - "Observation notes"
      - "Secondary sources"
    target_fragments: "100-150"
    coverage_goal: "Fill identified gaps"
    
  phase_4_validation:
    name: "Validation and Refinement"
    duration: "Week 7-8"
    goal: "Verify and refine"
    priority_sources:
      - "Follow-up interviews"
      - "Clarification conversations"
      - "Cross-reference checks"
      - "Expert consultations"
    target_fragments: "50-100"
    coverage_goal: "Verify contradictions, increase confidence"

# =============================================================================
# 7. COMPLETE SOURCE EXAMPLE
# =============================================================================

example_source:
  id: "SRC_001"
  title: "Discovery Interview - Life History and Core Philosophy"
  type: "interview"
  quality: "primary"
  date: "2024-01-15T14:00:00Z"
  url: "https://internal-storage.com/interviews/001"
  author: "Research Team"
  language: "en"
  metadata:
    duration: "3:45:30"
    format: "mp4 + transcript"
    publisher: "Internal"
    access_level: "private"
    notes: "Comprehensive initial interview covering all 8 modules of the protocol. Excellent depth and authenticity. Subject was relaxed and forthcoming."
    fragments_extracted: 87
    extraction_status: "completed"
    confidence_rating: 0.95
    extraction_metrics:
      extraction_time: "12:30"
      extraction_date: "2024-01-18"
      extracted_by: "Research Team Lead"
      review_status: "reviewed"
      reviewed_by: "Senior Analyst"
      review_date: "2024-01-20"
    quality_metrics:
      content_richness: 9.5
      relevance_score: 10.0
      clarity_score: 8.5
      depth_score: 9.0
      authenticity_score: 9.5
    coverage_tracking:
      categories_covered: 
        - "Biographical"
        - "Cognitive"
        - "Communicative"
        - "Behavioral"
        - "Values and Beliefs"
        - "Social"
        - "Meta-cognitive"
      topics_covered:
        - "Family origins"
        - "Core philosophy"
        - "Decision-making framework"
        - "Communication style"
        - "Key relationships"
        - "Career trajectory"
      gaps_identified:
        - "Limited discussion of failures"
        - "Could explore spiritual beliefs more"

# =============================================================================
# 8. VALIDATION AND QUALITY CONTROL
# =============================================================================

validation_rules:
  
  required_fields_check:
    critical:
      - id
      - title
      - type
      - quality
      - date
    
    recommended:
      - url
      - author
      - language
      - metadata.notes
  
  quality_checks:
    - "Verify source authenticity"
    - "Confirm date is accurate"
    - "Validate quality classification"
    - "Check URL is accessible"
    - "Ensure proper categorization"
  
  documentation_standards:
    - "Title must be descriptive and unique"
    - "Notes should include context and assessment"
    - "Track extraction metrics for transparency"
    - "Document any concerns or limitations"
    - "Note relationship to other sources"

# =============================================================================
# END OF SOURCE TAXONOMY
# =============================================================================
