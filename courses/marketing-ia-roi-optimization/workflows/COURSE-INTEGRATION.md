# Course Integration Guide
## Marketing IA ROI Optimization - n8n Workflows

**Target Audience:** Marketing professionals, SDRs, growth marketers, founders
**Prerequisites:** Basic computer skills, willingness to learn APIs, ~$50-100 budget for API trials
**Course Duration:** 12-16 hours of instruction + 8-12 hours of hands-on practice

---

## Module 2: Aquisição & Conversão (6 Lessons, ~8 hours)

### Lesson 2.1: Your First n8n Workflow - Pipedrive to Sheets
**Duration:** 60 minutes (30 min instruction + 30 min hands-on)

#### Learning Objectives
By the end of this lesson, students will be able to:
- Create an n8n account and understand the interface
- Configure OAuth2 credentials for Google Sheets and Pipedrive
- Import a pre-built workflow and execute it manually
- Troubleshoot basic connection errors
- Understand data mapping between services

#### Pre-Lesson Preparation
**Student Tasks (assign 1 week before):**
- [ ] Create n8n cloud account (or install self-hosted)
- [ ] Sign up for Pipedrive 14-day trial
- [ ] Create Google account (if don't have one)
- [ ] Watch prerequisite video: "What is an API?" (10 min)

**Instructor Tasks:**
- [ ] Test workflow with fresh accounts
- [ ] Prepare troubleshooting flowchart for common errors
- [ ] Set up backup API keys in case student keys fail
- [ ] Create sample Pipedrive data (5-10 deals)

#### Lesson Outline (30 minutes)

**Introduction (5 min)**
- Why automation matters: 40 hrs/week → 5 hrs/week
- Show end result: Live Google Sheet syncing with Pipedrive
- Address common fear: "I'm not technical enough" (yes, you are!)

**Walkthrough (20 min)**
1. **n8n Interface Tour** (3 min)
   - Left sidebar: Workflows, Credentials, Executions
   - Canvas: Where magic happens
   - Nodes: Building blocks of automation

2. **Importing the Workflow** (2 min)
   - Download JSON from course materials
   - Import into n8n
   - Explain each node visually

3. **Configuring Pipedrive Credentials** (5 min)
   - Live demonstration: Getting API token
   - Adding credential in n8n
   - Testing connection

4. **Configuring Google Sheets Credentials** (5 min)
   - OAuth2 flow explanation
   - Granting permissions
   - Selecting spreadsheet and sheet

5. **Executing the Workflow** (3 min)
   - Click "Execute Workflow"
   - Watch data flow through nodes
   - Verify data in Google Sheets

**Q&A (5 min)**
- Common questions:
  - "Can I use this with other CRMs?" (Yes, n8n has 400+ integrations)
  - "Is my data secure?" (Yes, OAuth2 + n8n encryption)
  - "What if I don't have Pipedrive?" (HubSpot, Salesforce, Airtable work too)

#### Hands-On Exercise (30 minutes)

**Task:** Sync your own Pipedrive deals to a new Google Sheet

**Step-by-Step Guide for Students:**
1. Create a new Google Sheet named "My Pipeline Tracker"
2. Add column headers: Date | Deal | Stage | Value
3. Import the workflow JSON file
4. Configure your Pipedrive credential
5. Configure your Google Sheets credential
6. Update the Sheet ID in the workflow
7. Execute workflow
8. Verify 5+ deals appear in your sheet
9. Take screenshot and submit to course portal

**Common Student Mistakes:**
- Forgetting to click "Save" after configuring credentials → Workflow fails silently
- Selecting wrong sheet in Google Sheets node → Data goes to wrong place
- Using personal Google account when company has disabled OAuth → Switch to personal account

**Instructor Support:**
- Monitor course forum for questions
- Provide individual help via screen share if needed
- Share recording of live setup for students to replay

#### Assessment Criteria

**Passing (80%+ required):**
- [ ] Workflow executes without errors
- [ ] At least 5 deals appear in Google Sheet
- [ ] Screenshot submitted shows correct data mapping
- [ ] Student can explain what each node does

**Bonus Points (optional):**
- [ ] Student customizes column names in Google Sheet
- [ ] Student adds a filter to only sync "Open" deals
- [ ] Student schedules workflow to run daily

#### Common Student Questions & Answers

**Q: "Do I need to keep n8n open for this to work?"**
A: No! n8n cloud runs in the background 24/7. Self-hosted needs server to stay on.

**Q: "How much does this cost?"**
A: n8n cloud free tier includes 1,000 workflow executions/month. Pipedrive is $14/month after trial. Google Sheets is free.

**Q: "Can I use this for my actual business?"**
A: Absolutely! Many students turn this into their production CRM reporting system.

**Q: "What if Pipedrive changes their API?"**
A: n8n automatically updates integrations. In worst case, workflow breaks and you revert to manual sync temporarily.

**Q: "Is this legal/ethical?"**
A: Yes, you're using official APIs with proper authentication. This is how APIs are meant to be used.

---

### Lesson 2.2: Web Scraping Basics - Extract Contact Info from Websites
**Duration:** 90 minutes (40 min instruction + 50 min hands-on)

#### Learning Objectives
- Understand ethical web scraping principles
- Set up Apify account and actor
- Process data in batches to avoid timeouts
- Export scraped data to CSV
- Handle empty results gracefully

#### Pre-Lesson Preparation
**Student Tasks:**
- [ ] Sign up for Apify (free $5 credit)
- [ ] Review "Web Scraping Ethics" reading (15 min)
- [ ] Prepare list of 10 company websites to scrape

**Instructor Tasks:**
- [ ] Test Apify actor with various website types
- [ ] Prepare backup list of scrapable websites
- [ ] Create troubleshooting guide for "No data found" errors
- [ ] Record video: "When web scraping goes wrong (and how to fix it)"

#### Lesson Outline (40 minutes)

**Introduction (5 min)**
- Why web scraping? Manual data entry is soul-crushing
- Legal landscape: robots.txt, rate limiting, ToS
- When NOT to scrape: password-protected sites, explicit bans

**Live Demo (25 min)**
1. **Apify Platform Overview** (5 min)
   - Actors = pre-built scrapers
   - Dataset = scraped results
   - API = connect to n8n

2. **Testing the Email & Phone Extractor Actor** (10 min)
   - Input: Website URLs
   - Run actor manually
   - Examine results dataset
   - Understand success/failure rates

3. **Connecting Apify to n8n** (10 min)
   - Apify API key setup
   - Configuring HTTP Request node
   - Parsing JSON response
   - Handling pagination

**Case Study (10 min)**
- Show real example: "I scraped 500 SaaS company websites in 2 hours"
- Before: 40 hours of manual research
- After: 2 hours of setup + 2 hours of data cleaning
- ROI: $800 saved (at $20/hr labor rate)

#### Hands-On Exercise (50 minutes)

**Task:** Scrape 20 company websites for contact information

**Requirements:**
1. Create Google Sheet with website URLs
2. Configure Apify actor to scrape emails and phones
3. Run workflow in n8n
4. Export results to CSV
5. Calculate success rate (how many had findable contacts?)

**Deliverable:**
- CSV file with at least 15 rows of data
- Screenshot of n8n execution log
- Short paragraph: "What I learned about web scraping ethics"

**Assessment Rubric:**
- **Technical (60%):** Workflow runs successfully, data exported correctly
- **Quality (20%):** At least 75% of websites yielded contact info
- **Ethics (20%):** Student demonstrates understanding of legal/ethical boundaries

#### Common Errors & Solutions

**Error:** "Apify actor timed out after 2 minutes"
**Solution:** Reduce batch size from 50 → 10 websites at a time

**Error:** "No emails found on any website"
**Solution:** Check if websites have contact pages (many hide emails nowadays)

**Error:** "$5 Apify credit depleted"
**Solution:** Actor costs ~$0.03/website. Student scraped ~170 websites. Reduce scope or upgrade plan.

---

## Module 3: Conteúdo & Engajamento (5 Lessons, ~10 hours)

### Lesson 3.1: Complete Outreach Automation - Apollo to Gmail
**Duration:** 150 minutes (60 min instruction + 90 min hands-on)

#### Learning Objectives
- Orchestrate 5+ APIs in a single workflow
- Understand data flow through complex automation
- Generate personalized cold emails with AI
- Set up email deliverability authentication
- Track open rates and responses

#### Pre-Lesson Preparation
**Student Tasks (assign 1 week before):**
- [ ] Sign up for Apollo.io (50 free credits)
- [ ] Sign up for ZeroBounce (100 free verifications)
- [ ] Sign up for Unipile (7-day trial)
- [ ] Sign up for OpenAI ($5 credit)
- [ ] Set up SPF/DKIM records for sending domain (instructor provides guide)
- [ ] Watch: "Cold email best practices" (20 min video)

**Instructor Tasks:**
- [ ] Verify all APIs are working (APIs change frequently!)
- [ ] Create fallback workflow using Hunter.io instead of Apollo
- [ ] Prepare email templates for students without writing skills
- [ ] Record: "Setting up email authentication (SPF/DKIM/DMARC)"

#### Lesson Outline (60 minutes)

**Introduction (10 min)**
- The cold email funnel: Scrape → Enrich → Verify → Personalize → Send → Track
- Show example campaign: 100 leads → 25 opens → 8 replies → 2 meetings
- Address elephant in room: "Isn't this spam?" (No, if done ethically)

**Architecture Walkthrough (20 min)**
1. **Form Trigger** (3 min)
   - Why forms? Easy testing + reusable
   - Collecting: Job Title, Company Size, Keywords, Location

2. **Apollo Scraper** (5 min)
   - AI-generated search URL (GPT-4)
   - Apify actor execution
   - Rate limiting (10 leads at a time)

3. **Profile Enrichment** (4 min)
   - Unipile for LinkedIn data
   - LinkedIn → Email finder
   - Company website scraping

4. **Email Verification** (3 min)
   - ZeroBounce API
   - Filter: valid + catch-all only
   - Bounce protection = sender reputation

5. **AI Personalization** (5 min)
   - GPT-4 prompt engineering
   - Using scraped data as context
   - Structured output parsing

**Live Coding: Building the Workflow** (20 min)**
- Start from blank canvas
- Add nodes one by one
- Explain connections and data mapping
- Execute at each step to show progress

**Q&A (10 min)**

#### Hands-On Exercise (90 minutes)

**Task:** Launch a mini cold email campaign to 10 prospects

**Phase 1: Setup (30 min)**
1. Import workflow JSON
2. Configure all 6 API credentials
3. Test each node individually
4. Fix any credential errors

**Phase 2: Customize (30 min)**
1. Update AI prompt with your product/service
2. Write email signature
3. Test AI with 3 sample profiles
4. Refine prompt based on output quality

**Phase 3: Execute (20 min)**
1. Fill out form trigger with search criteria
2. Execute workflow with limit=10
3. Monitor execution log
4. Verify emails sent successfully

**Phase 4: Analyze (10 min)**
1. Check Gmail "Sent" folder
2. Review personalization quality
3. Set up tracking pixels (optional)
4. Document learnings in 1-page report

**Deliverable:**
- Screenshot of successful workflow execution
- PDF of 3 generated emails (redact real names)
- 1-page report: "What worked, what didn't, what I'd change"

**Assessment Criteria:**
- **Setup (30%):** All APIs configured correctly
- **Execution (30%):** Workflow runs end-to-end without errors
- **Quality (30%):** Emails are personalized and professional
- **Analysis (10%):** Student provides thoughtful reflection

#### Common Student Struggles

**Struggle:** "Too many APIs, too overwhelming"
**Support:** Provide checklist: "APIs to set up (check off as you complete)"

**Struggle:** "AI-generated emails sound robotic"
**Support:** Share prompt engineering workshop recording

**Struggle:** "Emails going to spam"
**Support:** Offer 1-on-1 email authentication setup call

**Struggle:** "Spending too much on API costs"
**Support:** Remind about free tiers, suggest testing with 5 leads first

---

## Module 4: Parcerias & Otimização (4 Lessons, ~8 hours)

### Lesson 4.1: LinkedIn Enterprise Lead Gen - Ghost Genius + Sales Navigator
**Duration:** 150 minutes (60 min instruction + 90 min hands-on)

#### Learning Objectives
- Understand LinkedIn automation risks and limits
- Set up Sales Navigator integration safely
- Implement rate limiting and random delays
- Generate 3-email sequences with AI
- Update CRM with enriched lead data

#### Pre-Lesson Preparation
**Student Tasks (assign 2 weeks before):**
- [ ] Sign up for LinkedIn Sales Navigator ($79.99/mo, 1-month trial)
- [ ] Sign up for Ghost Genius API (7-day free trial)
- [ ] Complete "LinkedIn Automation Safety" quiz (pass required)
- [ ] Read case study: "How I got banned from LinkedIn (and how to avoid it)"

**Instructor Tasks:**
- [ ] Verify Ghost Genius API endpoints still work
- [ ] Create "LinkedIn Limits Cheat Sheet" handout
- [ ] Prepare alternative workflow using Phantombuster (Ghost Genius backup)
- [ ] Record: "Setting up Sales Navigator filters for best results"

#### Lesson Outline (60 minutes)

**Critical Safety Briefing (15 min)**
- LinkedIn limits: 100 connection requests/week, 2,500 Sales Navigator searches/day
- Detection methods: Velocity, patterns, bot-like behavior
- Consequences: Temporary restriction → permanent ban → legal action (rare but possible)
- Safe usage: <70 requests/week, random delays 30-90 sec, human-like patterns

**Ghost Genius Platform Deep Dive (15 min)**
1. **Cookieless Mode** (5 min)
   - How it works: Ghost Genius's own accounts
   - Benefits: Lower risk, no personal account needed
   - Tradeoffs: Slight cost increase

2. **API Endpoints** (5 min)
   - `/search/companies` - Find target companies
   - `/profile` - Enrich personal profiles
   - `/company` - Get company details
   - `/contact/email` - Find verified emails

3. **Rate Limiting Implementation** (5 min)
   - `splitInBatches` with limit=10
   - `Wait` node with 1500ms intervals
   - Error handling with `onError: "continueRegularOutput"`

**Workflow Architecture** (20 min)**
- **Stage 1:** Search companies (AI-scored 0-10)
- **Stage 2:** Find decision-makers (by title)
- **Stage 3:** Profile enrichment
- **Stage 4:** Email finder + verification
- **Stage 5:** AI personalization (3-email sequence)
- **Stage 6:** Google Sheets storage

**Case Study: Real Student Success** (10 min)**
- Student ran this workflow for 3 months
- 1,200 companies scraped → 340 qualified (score ≥7) → 120 decision-makers found → 95 emails verified
- Results: 28 replies, 7 meetings booked, 2 clients signed ($30k revenue)
- Cost: $450 (APIs) + 10 hours (monitoring) = $30k ROI

#### Hands-On Exercise (90 minutes)

**Task:** Set up production-ready LinkedIn lead gen system

**Phase 1: Safety Configuration (20 min)**
1. Set up Ghost Genius account with Sales Navigator
2. Configure rate limiting (max 100 companies/day)
3. Add random delays (30-90 seconds)
4. Test with 5 companies

**Phase 2: Workflow Customization (30 min)**
1. Define your ICP (Ideal Customer Profile)
2. Set search filters (location, company size, keywords)
3. Customize AI scoring criteria
4. Write decision-maker job title variations

**Phase 3: AI Personalization (30 min)**
1. Update system prompts with your value proposition
2. Generate 10 sample emails
3. Evaluate quality (are they personalized enough?)
4. Refine prompts, regenerate, compare

**Phase 4: Production Deployment (10 min)**
1. Enable schedule trigger (daily at 9 AM)
2. Set up error notifications (Telegram/Slack)
3. Monitor first 3 executions closely
4. Document any issues in course forum

**Deliverable:**
- Production-ready workflow JSON file
- Screenshot of successful 5-company test run
- PDF with 5 AI-generated email sequences
- "Safety Checklist" filled out and signed

**Assessment Criteria:**
- **Safety (40%):** Rate limiting implemented correctly, delays randomized
- **Technical (30%):** Workflow runs reliably, error handling in place
- **Quality (20%):** AI emails are personalized and professional
- **Documentation (10%):** Student documented process and issues

---

## Teaching Tips & Best Practices

### For Live Instruction

**Do:**
- Share your screen for 80% of live demos
- Pause frequently for questions ("Anyone lost? Let me know in chat")
- Use analogies: "APIs are like electrical outlets - standardized way to get power"
- Celebrate small wins: "Great job! You just automated a 2-hour task"

**Don't:**
- Go too fast - assume students need 2x longer than you
- Skip error handling - that's where students learn most
- Assume prior knowledge - define every technical term
- Overload with information - one concept per lesson segment

### For Asynchronous Learning

**Provide:**
- Video recordings with chapters/timestamps
- Downloadable workflow JSON files
- PDF step-by-step guides with screenshots
- "Common Errors" troubleshooting docs

**Encourage:**
- Forum posts: "Share your workflow results!"
- Peer review: "Give feedback on 2 classmates' workflows"
- Office hours attendance: "Stuck? Join weekly Q&A"
- Incremental progress: "Complete one node per day"

### For Assessment

**Effective Assessment Methods:**
- Screenshot submissions (proves workflow works)
- Short reflection essays (demonstrates understanding)
- Peer review exercises (teaches critical thinking)
- Live troubleshooting demos (shows problem-solving skills)

**Ineffective Assessment Methods:**
- Multiple choice quizzes (too theoretical)
- Long essays (students copy from ChatGPT)
- Unguided projects (students get stuck, frustrated)

---

## Student Success Metrics

### Course-Level KPIs
- **Completion Rate:** 75%+ (benchmark: online courses average 15%)
- **Average Time to Complete:** 3-4 weeks (benchmark: varies widely)
- **Student Satisfaction:** 4.5/5 stars (benchmark: 4.0+ is excellent)
- **Post-Course Application:** 60%+ implement at least one workflow in real work

### Lesson-Level KPIs
- **Exercise Completion:** 85%+ per lesson
- **Forum Engagement:** 50%+ students post at least once per module
- **Office Hours Attendance:** 30%+ students attend at least once
- **Peer Help:** 20%+ students help answer another student's question

### Business Impact KPIs (Tracked 3-6 months post-course)
- **Time Saved:** Average 15-20 hours/week on prospecting
- **Cost Savings:** Average $800-1,200/month vs. hiring VA
- **Revenue Impact:** 30%+ report increased pipeline or closed deals
- **Career Advancement:** 15%+ promoted or transitioned to growth roles

---

## Troubleshooting Guide for Instructors

### Technical Issues

**Student reports: "Workflow won't import"**
- Check: File size (n8n cloud has 1MB limit)
- Solution: Compress JSON or use self-hosted n8n
- Workaround: Provide workflow as multi-part files

**Student reports: "API key doesn't work"**
- Check: Copy-paste included extra spaces (common!)
- Solution: Have student regenerate API key
- Workaround: Instructor provides temporary key for testing

**Student reports: "Workflow takes forever to run"**
- Check: Batch size too large? Timeout too short?
- Solution: Reduce batch size, increase timeout
- Workaround: Run workflow locally instead of cloud

### Learning Issues

**Student seems stuck on same lesson for 2+ weeks**
- Reach out personally: "I noticed you're on Lesson X. Can I help?"
- Offer 1-on-1 call: "Let's screen share and solve this together"
- Provide alternative path: "This lesson is hard - try Lesson Y first"

**Student complains: "This is too technical for me"**
- Validate feelings: "Automation is challenging - you're not alone"
- Show progress: "Look - you configured 3 APIs already! That's huge"
- Simplify: "Let's use this pre-built template instead of building from scratch"

**Student asks: "Why are we learning n8n instead of [Zapier/Make.com]?"**
- Explain: "n8n is open-source, more powerful, and future-proof"
- Acknowledge: "Zapier is easier for beginners, but limits what you can build"
- Reassure: "Skills transfer - once you know n8n, other tools are easier"

---

## Appendix: Resource Library

### Pre-Made Materials
- [ ] Workflow JSON files (tested and documented)
- [ ] Video recordings (one per lesson, with chapters)
- [ ] PDF guides (step-by-step with screenshots)
- [ ] Prompt templates (for AI personalization)
- [ ] Troubleshooting docs (top 20 errors + solutions)
- [ ] Safety checklists (LinkedIn, email, APIs)
- [ ] Cost calculators (estimate monthly API spend)
- [ ] ROI worksheets (calculate time/money saved)

### Ongoing Support
- [ ] Course forum (Discourse or similar)
- [ ] Weekly office hours (Zoom, 1 hour)
- [ ] Student Slack/Discord (peer support)
- [ ] Instructor email (24-48 hour response time)
- [ ] 1-on-1 troubleshooting (booked via Calendly)

### Continuous Improvement
- [ ] Student feedback surveys (after each module)
- [ ] Workflow update log (when APIs change)
- [ ] Success story collection (for marketing)
- [ ] Curriculum review (quarterly with pilot students)

---

**Last Updated:** December 3, 2025
**Course Version:** 1.0
**Maintained By:** [Instructor Name]
