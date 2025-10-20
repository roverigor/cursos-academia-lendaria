---
agent_name: "funnel-architect"
agent_version: "1.0"
status: "🚧 Coming Soon"
description: "Conversion Funnel Strategy Specialist"
planned_release: "Phase 3 (Weeks 9-12)"
---

# Funnel Architect Agent

**Agent ID:** funnel-architect
**Role:** Conversion Funnel Strategy Specialist
**Status:** 🚧 **Coming Soon** (Phase 3)
**Expansion Pack:** CreatorOS

---

## 🚧 Development Status

This agent is currently in planning phase and will be implemented in **Phase 3: Marketing Intelligence (Weeks 9-12)** according to the CreatorOS roadmap.

---

## 📋 Planned Capabilities

When implemented, the Funnel Architect will design:

### **Conversion Funnel Strategy**
- **TOFU (Top of Funnel)** - Awareness content (blog, social, video)
- **MOFU (Middle of Funnel)** - Consideration content (case studies, webinars)
- **BOFU (Bottom of Funnel)** - Decision content (demos, consultations)

### **Funnel Mapping**
- Map content pieces to funnel stages
- Identify gaps in funnel (missing MOFU content?)
- Recommend content types for each stage
- Calculate funnel conversion rates

### **Journey Design**
- Design customer journey from awareness to purchase
- Multi-touch attribution setup
- Retargeting strategy for drop-offs
- Nurture sequence recommendations

### **Performance Optimization**
- Analyze drop-off points
- Recommend A/B tests for low-performing stages
- Content repurposing for funnel optimization
- ROI calculation per funnel stage

---

## 🎯 Planned Commands

**Funnel Design:**
- `*design-funnel` - Create complete TOFU → MOFU → BOFU funnel
- `*map-content-to-funnel` - Assign content to funnel stages
- `*identify-funnel-gaps` - Find missing content in funnel

**Journey Mapping:**
- `*design-customer-journey` - Map full customer journey
- `*create-nurture-sequence` - Email/content nurture sequence
- `*setup-retargeting` - Retargeting strategy for drop-offs

**Optimization:**
- `*analyze-funnel-performance` - Calculate conversion rates
- `*recommend-improvements` - Suggest funnel optimizations
- `*calculate-funnel-roi` - ROI per stage and overall

---

## 🎯 Funnel Framework (Planned)

### TOFU - Top of Funnel (Awareness)

**Goal:** Attract cold audience, build awareness

**Content Types:**
- Blog posts (SEO-optimized)
- Social media posts (viral potential)
- YouTube videos (educational)
- Podcasts (thought leadership)
- Free tools/calculators

**Metrics:**
- Traffic (visits, impressions)
- Engagement (likes, shares, comments)
- Brand awareness (search volume)

### MOFU - Middle of Funnel (Consideration)

**Goal:** Educate warm audience, build trust

**Content Types:**
- Case studies (social proof)
- Webinars (interactive education)
- Whitepapers (deep dives)
- Email courses (nurture)
- Comparison guides (vs competitors)

**Metrics:**
- Email signups (lead generation)
- Content downloads (engagement depth)
- Webinar attendance (interest level)

### BOFU - Bottom of Funnel (Decision)

**Goal:** Convert hot leads to customers

**Content Types:**
- Product demos (show solution)
- Free trials (hands-on experience)
- Consultations (personalized)
- Pricing pages (transparent)
- Customer testimonials (social proof)

**Metrics:**
- Trial signups (intent)
- Demo requests (buying signal)
- Sales calls booked (conversion)
- Revenue ($$$ generated)

---

## 🔗 Integration Points

### With Database:
- `content_funnels` table - Funnel definitions
- `content_pieces` table - Content mapped to stages
- `content_attribution` table - Multi-touch attribution

### With Other Agents:
- **@content-pm** - Receive funnel requirements
- **@blog-writer** - Request TOFU blog content
- **@course-architect** - Request MOFU educational content
- **@ab-test-manager** - Test funnel variations
- **@growth-analyst** - Analyze funnel performance

### With External Tools:
- Google Analytics (funnel tracking)
- CRM (lead nurturing)
- Email marketing (automation)

---

## 📊 Success Metrics (Planned)

**Funnel Effectiveness:**
- TOFU → MOFU conversion: >10%
- MOFU → BOFU conversion: >25%
- BOFU → Customer conversion: >5%
- Overall funnel conversion: >1%

**Content Mapping:**
- Coverage: All stages have ≥3 content pieces
- Quality: Average fidelity ≥85%
- Performance: Each piece achieves target metrics

**Business Impact:**
- Leads generated: Track by funnel stage
- Revenue attributed: Multi-touch attribution
- ROI: Revenue / Content cost

---

## 📖 Example Interaction (Planned)

```
User: @funnel-architect

Agent: 🎯 Funnel Architect activated!
       I design conversion funnels from awareness to purchase.

User: *design-funnel

Agent: What's your product/service?
User: Online course teaching Supabase

Agent: What's your customer's journey?
       Starting awareness stage:
User: Frontend developers who don't know Supabase exists

Agent: Perfect! Let me design your funnel:

       ═══════════════════════════════════════════
       TOFU - Awareness (Cold Audience)
       ═══════════════════════════════════════════

       Goal: Attract frontend devs who need backend

       Content Strategy:
       1. Blog: "Backend without servers? Here's how"
       2. Twitter thread: "10 reasons fullstack devs use Supabase"
       3. YouTube: "Build your first backend in 15 minutes"

       Metrics Target:
       - 10K monthly blog visitors
       - 5% click to MOFU content

       ═══════════════════════════════════════════
       MOFU - Consideration (Warm Leads)
       ═══════════════════════════════════════════

       Goal: Educate about Supabase benefits

       Content Strategy:
       1. Free mini-course: "Supabase fundamentals" (3 lessons)
       2. Case study: "How Startup X shipped in 1 week"
       3. Comparison: "Supabase vs Firebase vs custom backend"

       Metrics Target:
       - 500 email signups/month
       - 30% complete mini-course
       - 25% click to BOFU

       ═══════════════════════════════════════════
       BOFU - Decision (Hot Leads)
       ═══════════════════════════════════════════

       Goal: Convert to paid course purchase

       Content Strategy:
       1. Course preview: "Free first module"
       2. Live demo: "Build real project together"
       3. Testimonials: "Students who shipped"

       Metrics Target:
       - 100 trial users/month
       - 10% conversion to paid ($79)
       - $790 monthly revenue

       ═══════════════════════════════════════════

       📊 Funnel Summary:
       - Stages: TOFU → MOFU → BOFU
       - Content pieces: 9 total (3 per stage)
       - Estimated conversion: 10K visitors → 10 customers
       - Projected revenue: $790/month

       🎯 Next Steps:
       1. *map-content-to-funnel - Assign existing content
       2. *identify-funnel-gaps - Find missing pieces
       3. Request content from specialized agents
```

---

## 🛣️ Roadmap

### Phase 3: Implementation (Weeks 9-12)
- [ ] Funnel design workflow
- [ ] TOFU/MOFU/BOFU content mapping
- [ ] Gap analysis automation
- [ ] Conversion rate calculations

### Phase 4: Advanced Features (Weeks 13-16)
- [ ] Multi-touch attribution
- [ ] Retargeting strategy automation
- [ ] A/B test integration
- [ ] ROI dashboard

---

## 🤝 Contributing

Want to help implement this agent?

**Areas for contribution:**
1. **Funnel frameworks** - Research proven funnel structures
2. **Content mapping** - Best practices for content → stage mapping
3. **Metrics** - Industry benchmarks for conversions
4. **Integration** - CRM, email, analytics tools

**Contact:** Open issue on GitHub with `[CreatorOS][funnel-architect]` tag

---

## 📄 Status Updates

**Latest Update:** 2025-10-20
**Status:** Planning complete, awaiting Phase 3 implementation
**Next Milestone:** Funnel design framework (Week 9)

Check `expansion-packs/creator-os/README.md` roadmap for updates.

---

**CreatorOS v1.0.0**
*Part of the AIOS-FULLSTACK framework*

Last Updated: 2025-10-20
