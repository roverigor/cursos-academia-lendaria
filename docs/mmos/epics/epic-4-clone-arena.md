---
epic-id: epic-3
name: Clone Arena - Social Debate Platform
status: proposed
priority: high
estimated-duration: 8-12 weeks
owner: MMOS Team

vision: |
  Transform cognitive clones from static tools into a dynamic social platform
  where legendary minds debate ideas, users learn from their interactions,
  and clone quality is continuously validated through competitive engagement.

business-value: |
  - Gamification increases user engagement 10x
  - Automated clone valuation reduces QA costs 80%
  - Social features create viral growth potential
  - Subscription model for premium debates
  - Data goldmine for improving clone fidelity

target-users:
  - Researchers exploring multiple perspectives
  - Students learning from expert debates
  - Decision-makers seeking diverse viewpoints
  - Content creators producing unique AI content
  - AI enthusiasts following clone performance

success-metrics:
  - 1000+ debates created in first month
  - 10,000+ registered users in 3 months
  - 85%+ average clone fidelity score
  - 50%+ user return rate (weekly active)
  - 4.5+ average debate quality rating

---

# Epic 3: Clone Arena - Social Debate Platform

## 🎯 Vision Statement

**"Where Legendary Minds Debate Ideas"**

Clone Arena transforms cognitive clones from passive Q&A tools into active debaters that challenge each other's ideas, allowing users to witness how different worldviews collide and synthesize. It's TED Talks meets intellectual combat, powered by AI clones of history's greatest thinkers.

---

## 🌟 Core Value Propositions

### For Users:
1. **Multi-Perspective Learning** - See how Sam Altman vs Elon Musk approach the same problem
2. **Decision Support** - Run debates on YOUR dilemmas (e.g., "Should I pivot my startup?")
3. **Entertainment** - Intellectual drama - who will win the debate?
4. **Social Discovery** - Follow clones, share debates, comment with community
5. **Benchmark Transparency** - Know which clones are highest quality

### For Clone Creators:
1. **Automated QA** - Every debate is a fidelity test
2. **Performance Tracking** - See exactly where clone fails/excels
3. **Competitive Benchmarking** - Compare your clone vs others
4. **Community Feedback** - Users rate what works/doesn't
5. **Continuous Improvement** - Data-driven clone enhancement

### For MMOS Platform:
1. **Viral Growth** - Shareable debate content spreads organically
2. **Data Moat** - Thousands of validated interactions = training data
3. **Quality Assurance** - Community-validated clone rankings
4. **Monetization** - Premium debates, API access, white-label
5. **Network Effects** - More clones → more debates → more users → more clones

---

## 📦 Epic Components

### **Story 3.1: Debate Engine Core** ⚡ (2 weeks)
**Goal:** Build the foundational debate execution system

**Features:**
- Clone loading and context management
- Framework execution (Oxford, Socratic, Steel Man, etc.)
- Round-by-round argument generation
- Real-time streaming for live debates
- Transcript logging and storage

**Acceptance Criteria:**
- [ ] Load 2 clones in parallel under 500ms
- [ ] Execute 5-round Oxford debate end-to-end
- [ ] Generate coherent arguments per clone personality
- [ ] Stream debate in real-time to frontend
- [ ] Save complete transcript to database

**Technical Tasks:**
- Implement debate orchestrator class
- Build prompt engineering for each framework
- Create streaming API endpoints
- Integrate with emulator.py clone loading
- Add error handling and retries

---

### **Story 3.2: Fidelity Scoring Engine** 🎯 (1.5 weeks)
**Goal:** Automatically score clone performance in debates

**Features:**
- 5 scoring dimensions (framework, style, knowledge, coherence, personality)
- Weighted scoring algorithm
- Per-round and overall scoring
- Comparative scoring (clone1 vs clone2)
- Score explanation generation

**Acceptance Criteria:**
- [ ] Score debate on all 5 dimensions
- [ ] Accuracy ±5% compared to human evaluators
- [ ] Generate score explanation (why 88% not 92%)
- [ ] Identify specific weaknesses (e.g., "missed Layer 7 obsession")
- [ ] Calculate winner based on total score

**Technical Tasks:**
- Implement scoring heuristics per dimension
- Create prompt for LLM-as-judge scoring
- Build score aggregation logic
- Generate actionable recommendations
- Validate scoring accuracy vs human baseline

---

### **Story 3.3: Database & API Layer** 🗄️ (2 weeks)
**Goal:** Persistent storage and API for all platform data

**Features:**
- PostgreSQL schema (debates, clones, users, rankings, comments, votes)
- FastAPI REST endpoints
- Authentication & authorization
- Rate limiting and caching
- Admin dashboard API

**Acceptance Criteria:**
- [ ] All tables created with indexes and triggers
- [ ] CRUD endpoints for debates, clones, users
- [ ] Leaderboard API with filtering (by clone, topic, timeframe)
- [ ] User authentication (JWT tokens)
- [ ] API docs auto-generated (Swagger)

**Technical Tasks:**
- Execute schema migration (clone-arena-database-schema.sql)
- Build FastAPI application structure
- Implement endpoint controllers
- Add authentication middleware
- Create database connection pooling
- Write API integration tests

---

### **Story 3.4: Web Interface (Frontend)** 🎨 (3 weeks)
**Goal:** Beautiful, responsive web UI for Clone Arena

**Features:**
- Home page with featured debates
- Clone selector and debate creator
- Live debate viewer with streaming
- Clone profile pages with stats
- Leaderboards (clones, users, topics)
- User dashboard
- Comment system with threading

**Acceptance Criteria:**
- [ ] Create debate in 3 clicks (select clones → topic → start)
- [ ] Watch live debate with real-time updates
- [ ] View clone profiles with performance graphs
- [ ] Browse leaderboards with filters
- [ ] Comment and vote on debates
- [ ] Mobile responsive (works on phone)

**Technical Tasks:**
- Setup Next.js + React + TypeScript
- Design component library (Tailwind CSS)
- Implement debate streaming with SSE
- Build real-time chat/comments (WebSockets)
- Create data visualization components (charts)
- Integrate with backend API
- Add authentication flow

---

### **Story 3.5: Ranking & Analytics System** 📊 (1.5 weeks)
**Goal:** Compute and display clone/user/topic rankings

**Features:**
- Clone global ranking algorithm (ELO-style)
- Topic trending algorithm
- User leaderboard (most debates created, best curator)
- Performance history tracking (clone evolution over time)
- Automated daily ranking updates

**Acceptance Criteria:**
- [ ] Clone rankings update after each debate
- [ ] Trending topics calculated daily
- [ ] User rankings based on engagement + quality
- [ ] Historical performance charts (30/60/90 days)
- [ ] Ranking changes tracked (↑↓ indicators)

**Technical Tasks:**
- Implement ELO ranking algorithm
- Build trending topics calculation (engagement score)
- Create scheduled jobs (cron) for ranking updates
- Generate performance history snapshots
- Build analytics dashboard queries
- Add caching for expensive queries

---

### **Story 3.6: Social Features** 👥 (2 weeks)
**Goal:** Community engagement and viral growth features

**Features:**
- Follow clones (get notified of new debates)
- Follow users (see what debates they create)
- Share debates (social media, direct link)
- Commenting system with threading
- Voting on debate winners
- Quality ratings (5-star debates)
- Notifications (email, push, in-app)

**Acceptance Criteria:**
- [ ] Follow/unfollow clones and users
- [ ] Receive notifications for followed clones
- [ ] Share debate link with embed preview
- [ ] Comment and reply to comments
- [ ] Vote on debate winner (community poll)
- [ ] Rate debate quality (1-5 stars)
- [ ] Notification preferences configurable

**Technical Tasks:**
- Implement follow system (tables, API)
- Build notification service
- Create sharing functionality with Open Graph tags
- Implement comment threading logic
- Add voting and rating systems
- Integrate email service (SendGrid/Mailgun)
- Build in-app notification UI

---

### **Story 3.7: Debate Frameworks Library** 📚 (1 week)
**Goal:** Expand beyond Oxford debate to 5+ frameworks

**Frameworks to Implement:**
1. **Oxford Debate** - Classic pro/con with rebuttals
2. **Socratic Dialogue** - Question-driven inquiry
3. **Steel Man** - Argue opponent's best case first
4. **Devil's Advocate** - Challenge all premises
5. **Hegelian Dialectic** - Thesis → Antithesis → Synthesis

**Acceptance Criteria:**
- [ ] All 5 frameworks implemented and tested
- [ ] Framework selection in debate creator
- [ ] Different prompt engineering per framework
- [ ] Framework-specific scoring adjustments
- [ ] Framework usage stats tracked

**Technical Tasks:**
- Create framework configuration files (YAML)
- Implement prompt templates per framework
- Build framework selector UI
- Test each framework with multiple clone pairs
- Document framework characteristics

---

### **Story 3.8: Advanced Features** 🚀 (2 weeks)
**Goal:** Premium features for power users

**Features:**
- **Roundtable Debates** - 3-4 clones discuss topic
- **Debate Tournaments** - Bracket-style competitions
- **Custom Prompts** - User injects specific questions
- **Private Debates** - Unlisted debates for personal use
- **API Access** - Programmatic debate creation
- **Export Transcripts** - Download as PDF, Markdown, JSON
- **Embed Debates** - iframe embed for blogs/websites

**Acceptance Criteria:**
- [ ] Roundtable with 3-4 clones works
- [ ] Tournament bracket generation and execution
- [ ] User can inject custom questions mid-debate
- [ ] Private debates not visible in public feed
- [ ] API keys for programmatic access
- [ ] Export in 3 formats (PDF, MD, JSON)
- [ ] Embeddable iframe widget

**Technical Tasks:**
- Extend debate engine for 3+ clones
- Build tournament bracket logic
- Implement custom prompt injection
- Add privacy controls (public/private/unlisted)
- Create API key management
- Build export functionality (PDF generation)
- Create iframe embed widget

---

## 🗺️ Implementation Roadmap

### **Phase 1: MVP (Weeks 1-4)**
**Goal:** Launch functional debate platform with core features

**Stories:**
- 3.1: Debate Engine Core
- 3.2: Fidelity Scoring Engine
- 3.3: Database & API Layer (partial)
- 3.4: Web Interface (partial - viewer only)

**Deliverable:** Users can create Oxford debates between 2 clones, watch live, see scores

---

### **Phase 2: Social Platform (Weeks 5-8)**
**Goal:** Add community features and viral growth

**Stories:**
- 3.3: Database & API Layer (complete)
- 3.4: Web Interface (complete - full features)
- 3.5: Ranking & Analytics System
- 3.6: Social Features

**Deliverable:** Full social platform with rankings, comments, follows, sharing

---

### **Phase 3: Advanced Features (Weeks 9-12)**
**Goal:** Premium features and monetization prep

**Stories:**
- 3.7: Debate Frameworks Library
- 3.8: Advanced Features

**Deliverable:** 5 frameworks, tournaments, roundtables, API access, exports

---

## 💰 Monetization Strategy

### **Free Tier:**
- Create 10 debates/month
- Watch unlimited public debates
- Comment and vote
- Follow up to 5 clones

### **Pro Tier ($19/month):**
- Create unlimited debates
- Private debates
- Custom prompts
- Follow unlimited clones
- Export transcripts
- Priority support

### **API Tier ($99/month):**
- 1000 API calls/month
- Programmatic debate creation
- Webhook notifications
- White-label embeds
- SLA guarantees

### **Enterprise Tier (Custom):**
- On-premise deployment
- Custom clone creation
- Dedicated support
- Custom frameworks
- Volume discounts

---

## 📊 Success Metrics (KPIs)

### **Engagement Metrics:**
- Daily Active Users (DAU)
- Debates created per day
- Debates watched per user
- Comments per debate
- Time spent on platform

### **Quality Metrics:**
- Average debate quality rating
- Average clone fidelity score
- User satisfaction score (NPS)
- Debate completion rate

### **Growth Metrics:**
- User sign-up rate
- Viral coefficient (shares → sign-ups)
- Retention rate (D1, D7, D30)
- Paid conversion rate

### **Technical Metrics:**
- Debate generation time (p95 < 30s)
- API response time (p95 < 200ms)
- Uptime (99.9%+)
- Error rate (<0.1%)

---

## 🔒 Security & Privacy Considerations

### **Data Privacy:**
- User data encrypted at rest and in transit
- GDPR compliance (data export, deletion)
- Anonymous viewing mode (no account required)
- Private debates not indexed/searchable

### **Content Moderation:**
- Automated toxicity detection
- User reporting system
- Moderator dashboard
- Clone behavioral guardrails

### **API Security:**
- Rate limiting per IP and API key
- OAuth 2.0 authentication
- API key rotation
- DDoS protection (Cloudflare)

---

## 🧪 Testing Strategy

### **Unit Tests:**
- Debate engine components
- Scoring algorithm accuracy
- API endpoint functionality
- Database queries

### **Integration Tests:**
- End-to-end debate creation
- Real-time streaming
- Authentication flow
- Payment processing

### **Load Tests:**
- 100 concurrent debates
- 10,000 concurrent viewers
- Database query performance
- API rate limits

### **User Testing:**
- Usability testing (5 users)
- A/B testing (debate UI variants)
- Beta program (50 users)
- Feedback surveys

---

## 🎯 Definition of Done

Epic 3 is complete when:

- [ ] MVP launched and accessible at clone-arena.com
- [ ] 100+ debates created by beta users
- [ ] All 5 debate frameworks functional
- [ ] Clone fidelity scoring accuracy >90% vs human judges
- [ ] Leaderboards live and updating
- [ ] Social features (follow, comment, vote) working
- [ ] API documentation published
- [ ] Performance benchmarks met (p95 < 30s debate generation)
- [ ] Security audit passed
- [ ] Marketing site live
- [ ] First 1000 users onboarded

---

## 🚧 Risks & Mitigations

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Clone quality inconsistent | High | Medium | Implement strict fidelity thresholds before listing |
| Debate generation too slow | High | Medium | Optimize prompts, cache common patterns, use faster models |
| Low user engagement | High | Medium | Gamification, featured debates, influencer partnerships |
| Abusive content | Medium | Low | Automated moderation, reporting system, human review |
| API abuse | Medium | Medium | Rate limiting, API key management, monitoring |
| Scaling costs | High | Medium | Caching strategy, efficient database queries, CDN |

---

## 📚 Dependencies

### **Technical:**
- MMOS Mind Mapper expansion pack (clones available)
- Database v3.0 (unified schema)
- Emulator agent (clone loading logic)
- LLM API (Claude/GPT-4 for generation)

### **Business:**
- Legal review (terms of service, privacy policy)
- Marketing site content
- Payment processor integration (Stripe)
- Email service (SendGrid)

### **Team:**
- 2 Backend engineers
- 1 Frontend engineer
- 1 Designer (UI/UX)
- 1 DevOps engineer
- 1 Product manager

---

## 🎬 Next Steps

1. **Immediate (Week 1):**
   - Review and approve this Epic
   - Prioritize stories
   - Assign story owners
   - Setup project board

2. **Short-term (Weeks 2-4):**
   - Kickoff Story 3.1 (Debate Engine Core)
   - Database migration (Story 3.3 schema)
   - UI mockups (Story 3.4)
   - API design doc

3. **Mid-term (Weeks 5-8):**
   - MVP launch (internal beta)
   - User testing and feedback
   - Iterate based on data
   - Marketing prep

4. **Long-term (Weeks 9-12):**
   - Public launch
   - Advanced features rollout
   - Monetization launch
   - Scale infrastructure

---

## 💬 Stakeholder Feedback

[Space for stakeholder comments and decisions]

---

**Epic Owner:** MMOS Product Team
**Created:** 2025-10-14
**Last Updated:** 2025-10-14
**Status:** Proposed → Awaiting Approval

---

## 🔗 Related Documents

- [Clone Arena Database Schema](/docs/mmos/architecture/clone-arena-database-schema.sql)
- [Story 3.1: Debate Engine Core](/docs/mmos/stories/story-3.1-debate-engine-core.md)
- [Story 3.2: Fidelity Scoring Engine](/docs/mmos/stories/story-3.2-fidelity-scoring-engine.md)
- [Emulator Agent Definition](/expansion-packs/mmos/agents/emulator.md)
- [MMOS PRD](/expansion-packs/mmos/PRD.md)

---

**END OF EPIC 3**
