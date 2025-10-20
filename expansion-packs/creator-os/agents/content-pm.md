---
agent_name: "content-pm"
agent_version: "1.0"
status: "🚧 Coming Soon"
description: "Content Project Manager & Strategy Orchestrator"
planned_release: "Phase 2 (Weeks 5-8)"
---

# Content PM Agent

**Agent ID:** content-pm
**Role:** Content Project Manager & Strategy Orchestrator
**Status:** 🚧 **Coming Soon** (Phase 2)
**Expansion Pack:** CreatorOS

---

## 🚧 Development Status

This agent is currently in planning phase and will be implemented in **Phase 2: Multi-Format Generator (Weeks 5-8)** according to the CreatorOS roadmap.

---

## 📋 Planned Capabilities

When implemented, the Content PM will orchestrate:

### **Project Management**
- Create and manage content projects
- Define project goals (thought_leadership, lead_generation, etc.)
- Set default personas for consistent voice
- Manage audience profiles and segmentation
- Track project-level KPIs

### **Campaign Planning**
- Design multi-piece content campaigns
- TOFU → MOFU → BOFU content mapping
- Cross-format content orchestration
- Campaign calendar and scheduling
- Budget and resource allocation

### **Strategy Orchestration**
- Content strategy alignment with business goals
- Persona selection for content pieces
- Framework recommendation (AIDA, PAS, Hero's Journey)
- Distribution channel strategy
- Performance review and optimization

### **Team Coordination**
- Delegate to specialized agents (blog-writer, social-media-specialist, etc.)
- Review agent outputs for quality and consistency
- Ensure brand voice alignment across formats
- Manage content approval workflows

---

## 🎯 Planned Commands

**Project Management:**
- `*create-project` - Initialize new content project
- `*list-projects` - Show all projects with stats
- `*project-stats {id}` - Detailed project analytics

**Campaign Planning:**
- `*create-campaign` - Plan content campaign
- `*add-to-campaign` - Add content piece to campaign
- `*campaign-calendar` - View campaign schedule

**Strategy:**
- `*set-strategy` - Define content strategy
- `*recommend-framework` - Suggest content framework for goal
- `*recommend-persona` - Suggest best persona for content type

**Review & Approval:**
- `*review-content` - Review generated content for quality
- `*approve-content` - Approve content for publication
- `*request-revision` - Request changes from specialized agents

---

## 🔗 Integration Points

### With Other CreatorOS Agents:
- **@content-orchestrator** - Delegate multi-format generation
- **@blog-writer** - Request blog posts
- **@social-media-specialist** - Request social content
- **@video-script-writer** - Request video scripts
- **@course-architect** - Request course curriculum
- **@growth-analyst** - Request performance insights

### With MMOS:
- Load default persona for project
- Switch personas for different content types
- Validate voice fidelity across campaign

### With Database:
- `content_projects` table - Project metadata
- `content_campaigns` table - Campaign definitions
- `content_campaign_pieces` table - Campaign/content associations
- `content_performance` table - Project-level analytics

---

## 📊 Success Metrics (Planned)

**Project Management:**
- Projects created: Track adoption
- Campaign completion rate: % campaigns finished
- Multi-format campaigns: % using 2+ formats

**Content Quality:**
- Voice consistency across campaign: 85%+ fidelity
- Approval rate: % content approved without revision
- Time to publish: Days from creation to publication

**Business Impact:**
- Lead generation: Leads per project
- Engagement: Views, shares, comments per campaign
- ROI: Revenue per content project

---

## 🛣️ Roadmap

### Phase 1: Foundation (Current)
- ✅ Agent definition in config.yaml
- ✅ Database schema (`content_projects`, `content_campaigns`)
- ⏳ Agent persona design

### Phase 2: Implementation (Weeks 5-8)
- [ ] Core project management commands
- [ ] Campaign planning workflow
- [ ] Agent delegation system
- [ ] Basic approval workflow

### Phase 3: Advanced Features (Weeks 9-12)
- [ ] Advanced strategy recommendation
- [ ] Multi-persona campaign orchestration
- [ ] Performance-driven optimization
- [ ] Integration with funnel-architect

### Phase 4: Polish (Weeks 13-16)
- [ ] UI/UX refinements
- [ ] Advanced analytics dashboard
- [ ] A/B test integration
- [ ] API access for external tools

---

## 📖 Example Interaction (Planned)

```
User: @content-pm

Agent: 🎨 Content PM activated!
       Let's set up your content project.

User: *create-project

Agent: What's your project name?
User: My Awesome Blog

Agent: What are your project goals? (Select 1-3)
       1. Thought leadership
       2. Lead generation
       3. Brand awareness
       4. Customer retention
       5. Product education

User: 1, 2

Agent: Choose default persona for this project:
       1. Naval Ravikant (MMOS)
       2. Nassim Taleb (MMOS)
       3. Custom persona
       4. Generic professional voice

User: 1

Agent: Who's your target audience?
User: Tech founders, 28-45, high openness, seeking leverage

Agent: ✅ Project created: proj_a3f2b1c4

       📊 Project Summary:
       - Name: My Awesome Blog
       - Goals: Thought leadership, Lead generation
       - Persona: Naval Ravikant (90%+ fidelity)
       - Audience: Tech founders (leveraged thinkers)

       🎯 Next Steps:
       1. *create-campaign - Plan your first campaign
       2. *generate-blog-post - Create individual blog post
       3. *project-stats proj_a3f2b1c4 - View analytics

User: *create-campaign

Agent: Campaign name?
User: Leverage Series

Agent: How many pieces? (Recommendation: 4-8 for mini-campaign)
User: 6

Agent: Formats? (Select multiple)
       1. Blog posts
       2. LinkedIn posts
       3. Twitter threads
       4. Video scripts
       5. Newsletter

User: 1, 2, 3

Agent: ✅ Campaign created: camp_x7y9z2

       📋 Campaign Plan:
       - 6 pieces total
       - 2 blog posts (TOFU)
       - 2 LinkedIn posts (MOFU)
       - 2 Twitter threads (TOFU)
       - Timeline: 3 weeks

       🎯 Ready to start generating?
       *generate-campaign-content camp_x7y9z2
```

---

## 🤝 Contributing

Want to help implement this agent?

**Areas for contribution:**
1. **Persona design** - Define PM communication style
2. **Workflow design** - Map project management workflows
3. **Command structure** - Define intuitive command syntax
4. **Integration patterns** - Design agent delegation system
5. **Testing** - Create test scenarios for PM workflows

**Contact:** Open issue on GitHub with `[CreatorOS][content-pm]` tag

---

## 📄 Status Updates

**Latest Update:** 2025-10-20
**Status:** Planning complete, awaiting Phase 2 implementation
**Next Milestone:** Agent persona design (Week 5)

Check `expansion-packs/creator-os/README.md` roadmap for updates.

---

**CreatorOS v1.0.0**
*Part of the AIOS-FULLSTACK framework*

Last Updated: 2025-10-20
