# Individual Workflow Documentation Files

This document lists all 9 individual workflow README files that should be created. Each file follows the template structure provided and contains detailed setup instructions, troubleshooting guides, and customization tips.

---

## Files to Create

### 1. `pipedrive-to-google-sheets-README.md`
**Workflow:** Track Pipedrive Deals in Google Sheets for Sales Pipeline Reporting
**Complexity:** Iniciante (2/10)
**Key Content:**
- How to get Pipedrive API token
- Google Sheets OAuth2 setup
- Data mapping: stage_id → stage_name conversion
- Schedule trigger configuration (daily sync)
- Common errors: Wrong sheet selected, OAuth expired

---

### 2. `octave-decision-makers-README.md`
**Workflow:** Discover Decision-Makers by Responsibilities (Not Titles) with Octave & Airtable
**Complexity:** Iniciante (3/10)
**Key Content:**
- Octave API account setup and pricing
- How to define "responsibilities" vs "titles" search
- Airtable base configuration
- Manual trigger vs scheduled execution
- Use case: Finding "owns infrastructure" instead of "VP Engineering"

---

### 3. `apify-email-extractor-README.md`
**Workflow:** Extract Emails, Phones & Social Links from Websites with Apify and Google Sheets
**Complexity:** Iniciante (4/10)
**Key Content:**
- Apify actor selection and configuration
- Cost optimization: $1.20 per 1000 leads
- Batch processing to avoid timeouts
- Handling empty results (no contact info found)
- Web scraping ethics and legal considerations

---

### 4. `decodo-google-maps-leads-README.md`
**Workflow:** Scrape & Enrich Google Maps Leads with Decodo API and Gemini 2.5 Flash
**Complexity:** Intermediário (6/10)
**Key Content:**
- Decodo API authentication (HTTP Header Auth)
- Google Maps search query syntax
- AI lead scoring (1-10 scale) with Gemini
- Generating personalized outreach hooks
- Hot leads filtering (score ≥7 with contact info)
- Monthly cost: $30-80

---

### 5. `rapidapi-hunter-prospecting-README.md`
**Workflow:** Automated B2B Prospecting with RapidAPI, Hunter.io, GPT & Gmail
**Complexity:** Intermediário (5/10)
**Key Content:**
- RapidAPI Local Business Data API setup
- Hunter.io email finder integration
- GPT-4 prompt engineering for cold emails
- Email verification flow
- Google Tasks integration for manual follow-up
- Monthly cost: $25-40

---

### 6. `apollo-linkedin-gmail-outreach-README.md`
**Workflow:** Automate Cold Outreach with Apollo, LinkedIn & Gmail using GPT-4
**Complexity:** Intermediário (6/10)
**Key Content:**
- Apollo.io scraper via Apify
- Unipile LinkedIn profile scraper
- ZeroBounce email verification
- GPT-4 personalized email generation
- Gmail OAuth2 sending setup
- Form trigger for easy testing
- Monthly cost: $30-60

---

### 7. `linkedin-crunchbase-gemini-outreach-README.md`
**Workflow:** Personalized Email Outreach with LinkedIn and Crunchbase Data and Gemini AI Review
**Complexity:** Intermediário (7/10)
**Key Content:**
- RapidAPI Cold Outreach Enrichment Scraper
- Multi-source data collection (LinkedIn profile, company, Crunchbase)
- Two-agent AI system: Writer + Judge
- Approval routing and iteration loops
- n8n Data Table usage
- Wait nodes for async scraping
- Monthly cost: $20-50

---

### 8. `ghost-genius-lead-gen-system-README.md`
**Workflow:** AI-Powered Lead Generation System with Email Personalization and LinkedIn
**Complexity:** Avançado (9/10)
**Key Content:**
- Ghost Genius API setup (LinkedIn without cookies)
- LinkedIn Sales Navigator integration
- Company search and AI scoring (0-10 scale)
- Multi-stage enrichment (company → employees → profiles → emails)
- 3-email sequence generation with GPT-4
- Rate limiting (100 companies/day max)
- Error handling and recovery
- Schedule trigger (daily execution)
- Monthly cost: $100-200

---

### 9. `linkedin-personalization-ghost-genius-README.md`
**Workflow:** Lead Generation: Automate on LinkedIn Personalisation & Enrichment
**Complexity:** Avançado (8/10)
**Key Content:**
- Sales Navigator search URL generation with AI
- Duplicate detection (avoid re-processing companies)
- Profile details enrichment
- Email waterfall enrichment (multiple sources)
- 3-stage personalization (context → emails → subjects)
- Google Sheets as CRM database
- Loop architecture with SplitInBatches
- Monthly cost: $80-150

---

## Recommended Creation Order

### Phase 1: Beginner Workflows (Week 1)
Create these first to support Module 2 launch:
1. pipedrive-to-google-sheets-README.md
2. apify-email-extractor-README.md
3. octave-decision-makers-README.md

### Phase 2: Intermediate Workflows (Week 2-3)
Create these to support Module 3:
4. rapidapi-hunter-prospecting-README.md
5. apollo-linkedin-gmail-outreach-README.md
6. decodo-google-maps-leads-README.md

### Phase 3: Advanced Workflows (Week 4-5)
Create these to support Module 4:
7. linkedin-crunchbase-gemini-outreach-README.md
8. ghost-genius-lead-gen-system-README.md
9. linkedin-personalization-ghost-genius-README.md

---

## Documentation Template Structure

Each README file should follow this structure (as specified in original request):

### Standard Sections
1. **Overview** (name, purpose, complexity, setup time, cost)
2. **What You'll Build** (visual description)
3. **Use Cases** (3-5 specific scenarios)
4. **Architecture** (ASCII flow diagram)
5. **Prerequisites** (accounts, credentials, cost breakdown)
6. **Step-by-Step Setup** (5 steps: import, credentials, parameters, test, activate)
7. **Node-by-Node Breakdown** (every node explained)
8. **Sample Data** (input/output examples)
9. **Customization Ideas** (3-5 ways to adapt)
10. **Troubleshooting** (top 5-10 common errors)
11. **Cost Optimization Tips** (3-5 money-saving strategies)
12. **Next Steps** (what to learn next)
13. **Related Workflows** (links to similar workflows)
14. **Resources** (API docs, n8n community links)

### Special Sections (where applicable)
- **Safety Warnings** (for LinkedIn automation workflows)
- **Legal Disclaimers** (for web scraping workflows)
- **Performance Benchmarks** (processing speed, API limits)
- **Real-World Examples** (student success stories)

---

## Estimated Creation Time

**Per Workflow README:**
- Research and testing: 2-3 hours
- Writing: 3-4 hours
- Screenshots and diagrams: 1-2 hours
- Review and editing: 1 hour
- **Total:** 7-10 hours per README

**Full Set (9 READMEs):**
- Optimized (parallel work): 4-5 weeks
- Sequential: 8-10 weeks

---

## Quality Checklist

Before publishing each README, verify:
- [ ] All API endpoints tested and working (last 7 days)
- [ ] Screenshots up-to-date with current UI
- [ ] Pricing information accurate (checked vendor websites)
- [ ] Code examples copy-paste ready (no syntax errors)
- [ ] Troubleshooting section addresses top 5 forum questions
- [ ] Related workflows linked correctly
- [ ] Markdown formatting valid (no broken links or images)
- [ ] Technical reviewer approved (another instructor/TA)
- [ ] Student beta-tested (at least one student followed it successfully)

---

## Continuous Maintenance Plan

### Monthly Tasks
- [ ] Check all API pricing (update if changed)
- [ ] Test one workflow per week (rotate through 9)
- [ ] Update troubleshooting with new forum questions
- [ ] Add student success stories (collect via surveys)

### Quarterly Tasks
- [ ] Major version review (are workflows still best-in-class?)
- [ ] Competitive analysis (new tools/APIs available?)
- [ ] Student feedback incorporation (top 3 requests)
- [ ] Video tutorials refresh (if UI changed significantly)

### Annual Tasks
- [ ] Complete workflow overhaul (rebuild from scratch if needed)
- [ ] Curriculum alignment check (still matches course goals?)
- [ ] Cost-benefit analysis (are these still the most cost-effective workflows?)

---

## Additional Recommendations

### Interactive Elements to Add
1. **Video Walkthroughs** (5-10 min per workflow)
   - Hosted on YouTube or Vimeo
   - Embedded in README with timestamp chapters
   - Show successful execution from start to finish

2. **Interactive Diagrams** (using Mermaid.js)
   - Visual workflow architecture
   - Embedded directly in markdown
   - Clickable nodes that expand with details

3. **Live Demos** (optional, advanced)
   - Host test n8n instance with public workflows
   - Students can see executions in real-time
   - Read-only access for safety

### Student Support Resources
1. **Quick Reference Cards** (1-page PDF per workflow)
   - Key credentials needed
   - Common error messages
   - Support contact info

2. **Video Library** (organized by workflow)
   - Setup walkthrough
   - Troubleshooting common errors
   - Customization examples
   - Student success interviews

3. **Community Templates** (optional)
   - Students submit their customized versions
   - Instructor reviews and features best ones
   - Create "workflow gallery" on course website

---

## Sample README Excerpt

Here's how the **Node-by-Node Breakdown** section should look:

```markdown
## Node-by-Node Breakdown

### Node 1: Manual Trigger (Trigger Node)

**Purpose**: Starts the workflow manually when you click "Execute Workflow"

**Configuration**:
```yaml
trigger: manual
description: "Click to run workflow once"
```

**Input**: None (this is the starting point)

**Output**: Empty object `{}` (just starts the flow)

**Common Issues**:
- **Issue**: Node doesn't appear to do anything
  **Solution**: This is normal! It just triggers the next nodes.

**Customization Tips**:
- Replace with Schedule Trigger for daily automation
- Replace with Webhook Trigger for API-triggered execution
- Replace with Form Trigger for user input

---

### Node 2: Get Target Accounts (Airtable Node)

**Purpose**: Retrieves list of companies to prospect from Airtable database

**Configuration**:
```yaml
operation: search
base: your-airtable-base-id
table: Target Accounts
filters:
  status: Active
returnAll: true
```

**Input**: None (reads directly from Airtable)

**Output**: Array of company objects
```json
[
  {
    "id": "rec123abc",
    "Company Name": "Acme Corp",
    "Domain": "acme.com",
    "Target Title": "VP Engineering"
  }
]
```

**Common Issues**:
- **Issue**: "Base not found" error
  **Solution**: Check Base ID in Airtable URL (after `airtable.com/app`)

- **Issue**: No results returned
  **Solution**: Verify filter matches data (check "status" field exists and has "Active" value)

**Customization Tips**:
- Add filters for company size, industry, or location
- Connect to Google Sheets instead of Airtable
- Read from CSV file uploaded to n8n
```

This level of detail ensures students can troubleshoot independently!

---

**Next Steps:**
1. Prioritize which 3 README files to create first
2. Assign writing tasks to team members (if multiple writers)
3. Set up review process (technical accuracy + pedagogical clarity)
4. Begin with Phase 1 workflows (beginner-friendly)

---

**Questions for Course Designer:**
1. Do you want all 9 READMEs created immediately, or phased rollout?
2. Should we include video walkthroughs, or text/screenshots only?
3. What's your preferred hosting for screenshots (Imgur, course CDN, GitHub)?
4. Do you have access to all APIs for testing, or need trial accounts?
5. Should READMEs be student-facing only, or instructor-facing versions too?
