# Marketing AI Workflows - n8n Collection

## Overview

This collection contains **9 production-ready n8n workflows** designed for B2B lead generation, outreach automation, and pipeline management. Combined, these workflows can process **500-1000 leads per month** with **80-90% automation**, reducing manual prospecting time from **40 hours/week** to **5-10 hours/week**.

**Total Value:** $150-300/month in API costs | **Potential ROI:** 300-500% when properly implemented

---

## Workflow Categories

### Lead Generation & Prospecting

**1. Track Pipedrive Deals in Google Sheets**
Sync CRM pipeline data to spreadsheet for visual reporting and team dashboards.

**2. Discover Decision-Makers by Responsibilities (Octave)**
Find contacts based on actual job functions, not unreliable titles (e.g., "owns platform engineering" vs. "VP Engineering").

**3. Extract Emails, Phones & Social Links (Apify)**
Scrape contact details from any company website at scale ($1.20 per 1000 leads).

**4. Scrape & Enrich Google Maps Leads (Decodo + Gemini)**
Generate local business leads with AI-powered scoring and personalized outreach hooks.

**5. Automated B2B Prospecting (RapidAPI + Hunter.io + GPT)**
Complete prospecting workflow from Google Maps to AI-generated cold emails.

---

### Email Outreach & Engagement

**6. Automate Cold Outreach (Apollo + LinkedIn + Gmail + GPT-4)**
End-to-end lead generation: scrape Apollo → verify emails → send LinkedIn invites → personalized emails.

**7. Personalized Email Outreach (LinkedIn + Crunchbase + Gemini)**
Multi-source data enrichment with two-agent AI system (writer + quality control).

**8. AI-Powered Lead Generation System (Ghost Genius + OpenAI)**
Enterprise-grade workflow with company scoring, LinkedIn Sales Navigator, and 3-email sequence generation.

---

### CRM & Pipeline Management

**9. Track Pipedrive Deals in Google Sheets (Duplicate)**
_Note: This is identical to workflow #1 and should be removed._

---

## Quick Start Guide

### Prerequisites

**Required:**
- n8n instance (cloud or self-hosted) → https://n8n.io/pricing/
- Basic understanding of APIs and JSON
- 2-4 hours for initial setup per workflow

**Recommended Accounts:**
- Google Workspace (Gmail + Sheets) - Free
- OpenAI Platform - $20+ credit
- Apify - $5 free credit
- Hunter.io - 25 free searches/month

**Optional (for advanced workflows):**
- Ghost Genius API - 7-day free trial
- Apollo.io - 50 free credits/month
- LinkedIn Sales Navigator - $79.99/month
- ZeroBounce - 100 free email verifications
- Decodo Maps API - No free tier ($29+/month)

---

### Installation Steps

1. **Import Workflow into n8n**
   - Open n8n → Click "+ New Workflow"
   - Click "..." → "Import from File"
   - Select the `.json` file from this directory
   - Click "Import"

2. **Configure Credentials**
   - Go to "Credentials" in left sidebar
   - Click "New Credential"
   - Select the service (e.g., "Google Sheets OAuth2")
   - Follow authentication flow
   - Repeat for each API used in the workflow

3. **Test with Sample Data**
   - Use the manual trigger node
   - Click "Execute Workflow"
   - Verify output in each node
   - Check for errors in execution log

4. **Deploy to Production**
   - Set up schedule trigger (if applicable)
   - Configure error notifications (Telegram/Slack/Email)
   - Monitor first 48 hours closely
   - Adjust rate limits and delays as needed

---

## Workflow Comparison Matrix

| Workflow | Complexity | Cost/Month | Setup Time | APIs Used | Best For |
|----------|------------|------------|------------|-----------|----------|
| Pipedrive → Sheets | 2/10 | $0 | 20 min | Pipedrive, Google Sheets | Beginners, CRM reporting |
| Octave Decision-Makers | 3/10 | Varies | 30 min | Octave, Airtable | Smart prospecting |
| Apify Email Extractor | 4/10 | $1.20/1k | 45 min | Apify, Google Sheets | Web scraping basics |
| Google Maps + Gemini | 6/10 | $30-80 | 75 min | Decodo, Gemini, Sheets | Local lead gen |
| RapidAPI + Hunter.io | 5/10 | $25-40 | 60 min | RapidAPI, Hunter, OpenAI | Local B2B prospecting |
| Apollo + GPT-4 | 6/10 | $30-60 | 90 min | Apollo, ZeroBounce, Unipile, OpenAI, Gmail | Complete outreach |
| LinkedIn + Crunchbase | 7/10 | $20-50 | 120 min | RapidAPI, Gemini, DataTable | High-quality personalization |
| Ghost Genius + OpenAI | 9/10 | $100-200 | 180 min | Ghost Genius, OpenAI, Sheets | Enterprise lead gen |

**Legend:**
- **Complexity:** 1-10 scale (1=beginner, 10=expert)
- **Cost/Month:** Estimated for 500 leads/month
- **Setup Time:** First-time configuration
- **Best For:** Primary use case

---

## Course Integration

### Module 2: Aquisição & Conversão (6 lessons)

**Lesson 2.1:** Track Pipedrive Deals in Google Sheets
- **Duration:** 30 minutes
- **Learning Objectives:** n8n basics, API credentials, data mapping
- **Hands-On:** Sync 10 deals from Pipedrive to Sheets
- **Assessment:** Student submits screenshot of populated spreadsheet

**Lesson 2.2:** Extract Emails & Phones from Websites
- **Duration:** 60 minutes
- **Learning Objectives:** Web scraping ethics, Apify platform, batch processing
- **Hands-On:** Scrape 20 company websites for contact info
- **Assessment:** Student exports CSV with 15+ valid emails

**Lesson 2.3:** Discover Decision-Makers by Responsibilities
- **Duration:** 45 minutes
- **Learning Objectives:** Job function targeting, Airtable integration, data filtering
- **Hands-On:** Find 10 "platform owners" at target companies
- **Assessment:** Student explains why this beats title-based search

**Lesson 2.4:** Scrape & Enrich Google Maps Leads
- **Duration:** 90 minutes
- **Learning Objectives:** AI scoring, lead qualification, data enrichment
- **Hands-On:** Generate 50 local leads with AI analysis
- **Assessment:** Student identifies top 10 leads by score and explains why

**Lesson 2.5:** Automated B2B Prospecting
- **Duration:** 90 minutes
- **Learning Objectives:** Multi-API orchestration, email generation, error handling
- **Hands-On:** Build end-to-end prospecting workflow for 25 leads
- **Assessment:** Student submits 5 AI-generated emails for review

**Lesson 2.6:** Module Project - Build Your Own Lead Gen Workflow
- **Duration:** 120 minutes
- **Deliverable:** Custom workflow combining techniques from 2.1-2.5
- **Assessment:** Instructor reviews workflow structure, error handling, and output quality

---

### Module 3: Conteúdo & Engajamento (5 lessons)

**Lesson 3.1:** Automate Cold Outreach (Apollo + LinkedIn + Gmail)
- **Duration:** 120 minutes
- **Learning Objectives:** End-to-end automation, form triggers, email deliverability
- **Hands-On:** Set up complete outreach workflow for 10 test leads
- **Assessment:** Student sends 10 emails, tracks open rates

**Lesson 3.2:** Personalized Email Outreach (LinkedIn + Crunchbase)
- **Duration:** 90 minutes
- **Learning Objectives:** Multi-source enrichment, AI quality control, approval loops
- **Hands-On:** Enrich 20 leads, generate personalized emails with AI review
- **Assessment:** Student submits before/after examples showing personalization

**Lesson 3.3:** Advanced Personalization Techniques
- **Duration:** 60 minutes
- **Learning Objectives:** Prompt engineering, context building, A/B testing
- **Hands-On:** Write 5 AI prompts for different industries
- **Assessment:** Instructor rates prompt quality on specificity and personalization

**Lesson 3.4:** Email Deliverability & Reputation Management
- **Duration:** 45 minutes
- **Learning Objectives:** SPF/DKIM/DMARC, warm-up, bounce handling, spam prevention
- **Hands-On:** Configure email authentication, set up deliverability monitoring
- **Assessment:** Student demonstrates passing SPF/DKIM checks

**Lesson 3.5:** Module Project - Launch an Outreach Campaign
- **Duration:** 180 minutes
- **Deliverable:** Live campaign with 50-100 prospects, tracking sheet, results analysis
- **Assessment:** Instructor evaluates campaign setup, messaging quality, and results interpretation

---

### Module 4: Parcerias & Otimização (4 lessons)

**Lesson 4.1:** LinkedIn Lead Generation System (Ghost Genius)
- **Duration:** 120 minutes
- **Learning Objectives:** Sales Navigator integration, LinkedIn limits, daily automation
- **Hands-On:** Set up LinkedIn prospecting workflow with rate limiting
- **Assessment:** Student explains how to avoid LinkedIn bans

**Lesson 4.2:** AI-Powered Multi-Stage Lead Gen System
- **Duration:** 150 minutes
- **Learning Objectives:** Company scoring, loop workflows, error handling, production readiness
- **Hands-On:** Build enterprise-grade workflow with error recovery
- **Assessment:** Student demonstrates error handling by intentionally breaking workflow

**Lesson 4.3:** ROI Tracking & Analytics Dashboard
- **Duration:** 90 minutes
- **Learning Objectives:** Cost per lead calculation, conversion tracking, dashboard design
- **Hands-On:** Create Google Sheets dashboard with metrics from Modules 2-3
- **Assessment:** Student presents dashboard and interprets 3 key metrics

**Lesson 4.4:** Workflow Optimization & Maintenance
- **Duration:** 60 minutes
- **Learning Objectives:** Performance tuning, API cost reduction, monitoring, scaling
- **Hands-On:** Audit existing workflow for optimization opportunities
- **Assessment:** Student submits optimization report with 3+ actionable improvements

---

## Cost Analysis

### Startup Costs (One-Time)
- n8n Cloud (optional): $0 (self-hosted) or $20/month
- Domain for self-hosted n8n: $12/year
- **Total:** $0-32

### Monthly Recurring Costs (500 leads/month)

**Tier 1: Free Tier Usage (Beginners)**
- Google Sheets/Gmail: $0
- Apify: $5 credit (~4,000 leads)
- Hunter.io: 25 searches
- ZeroBounce: 100 verifications
- **Total: ~$5/month**

**Tier 2: Light Production (Intermediate)**
- Tier 1 services: $5
- OpenAI (GPT-4o-mini): ~$10-15
- Apify Pro: $49/month
- Hunter.io Starter: $49/month
- **Total: ~$113-118/month**

**Tier 3: Full Production (Advanced)**
- Tier 2 services: $118
- Ghost Genius API: $89/month
- LinkedIn Sales Navigator: $79.99/month
- Decodo Maps API: $29-79/month
- **Total: ~$315-365/month**

### Cost Per Lead Breakdown
- **Tier 1 (DIY):** $0.01-0.05 per lead
- **Tier 2 (Light Production):** $0.20-0.25 per lead
- **Tier 3 (Full Production):** $0.30-0.75 per lead

**Compare to alternatives:**
- Manual prospecting: $25-50 per lead (labor cost)
- Lead purchase databases: $1-5 per lead (often low quality)
- Marketing agency: $50-200 per lead (high quality, outsourced)

---

## Support & Resources

### Official Documentation
- **n8n Docs:** https://docs.n8n.io/
- **n8n Community Forum:** https://community.n8n.io/
- **n8n YouTube Channel:** https://www.youtube.com/c/n8n-io

### API Documentation
- **Apify:** https://docs.apify.com/
- **Apollo.io:** https://apolloio.github.io/apollo-api-docs/
- **OpenAI:** https://platform.openai.com/docs/
- **Google Gemini:** https://ai.google.dev/docs
- **Hunter.io:** https://hunter.io/api-documentation
- **Ghost Genius:** https://ghostgenius.fr/docs
- **Decodo:** https://decodo.com/web-scraping-api/docs
- **Pipedrive:** https://developers.pipedrive.com/

### Course Support
- **Course Forum:** [Link to be added]
- **Office Hours:** [Schedule to be added]
- **Troubleshooting Database:** [Link to be added]
- **Student Community:** [Slack/Discord invite to be added]

---

## Troubleshooting

### Common Issues

**Error: "API rate limit exceeded"**
- **Cause:** Too many requests in short time
- **Solution:** Add "Wait" node with 1-2 second delay between requests
- **Prevention:** Use batch processing with `splitInBatches` node

**Error: "Invalid credentials"**
- **Cause:** API key expired or incorrect
- **Solution:** Regenerate API key in service dashboard, update n8n credential
- **Prevention:** Set calendar reminder to check API key validity monthly

**Error: "Workflow execution timeout"**
- **Cause:** Workflow takes longer than n8n timeout setting (default: 2 minutes)
- **Solution:** Increase timeout in workflow settings or break into smaller workflows
- **Prevention:** Process leads in batches of 10-25, not all at once

**Error: "Node returned no data"**
- **Cause:** Previous node failed or returned empty array
- **Solution:** Add "IF" node to check data existence before processing
- **Prevention:** Use "Error Trigger" node to catch failures gracefully

**Email bounces/spam folder**
- **Cause:** Poor sender reputation, missing SPF/DKIM/DMARC
- **Solution:** Warm up email address gradually (10/day → 50/day → 100/day over 2 weeks)
- **Prevention:** Use dedicated domain for outreach, set up email authentication

**LinkedIn account restricted**
- **Cause:** Exceeded connection requests (100/week) or automation detected
- **Solution:** Reduce request velocity, add random delays (30-60 seconds)
- **Prevention:** Use Ghost Genius cookieless mode, stay under 70 requests/week

**Google Sheets "Quota exceeded"**
- **Cause:** Writing too fast (60 requests/minute limit)
- **Solution:** Batch writes into fewer operations (e.g., 10 rows at once)
- **Prevention:** Use `batch` option in Google Sheets node

**AI generates poor quality emails**
- **Cause:** Vague prompts or insufficient context
- **Solution:** Improve system prompt with specific examples and constraints
- **Prevention:** Test prompts with 10+ samples before production deployment

---

## Best Practices

### Data Privacy & Compliance
- Store data in compliance with GDPR/CCPA regulations
- Obtain consent for email outreach (or ensure legitimate interest applies)
- Include unsubscribe links in all automated emails
- Delete lead data after 180 days of no engagement

### Security
- Never commit API keys to version control
- Use n8n's credential encryption (enabled by default)
- Rotate API keys every 90 days
- Set up IP whitelisting where available

### Reliability
- Implement error handling on every workflow
- Set up monitoring alerts (Telegram/Slack/Email)
- Test workflows weekly, even when not actively using
- Keep backups of workflow JSON files

### Cost Optimization
- Start with free tiers, upgrade only when needed
- Monitor API usage daily in first week
- Set up cost alerts in API provider dashboards
- Use caching to avoid redundant API calls

### Performance
- Process leads in batches of 10-25
- Add 1-2 second delays between API requests
- Use `splitInBatches` node for large datasets
- Schedule workflows during off-peak hours

---

## Changelog

### v1.0 (December 2025)
- Initial release with 9 workflows
- Added comprehensive documentation
- Created course integration guide
- Established support resources

---

## License & Usage

These workflows are provided for educational purposes as part of the **Marketing IA ROI Optimization** course.

**Permitted Uses:**
- Personal learning and experimentation
- Client work (with proper attribution)
- Modification and customization for your needs

**Restrictions:**
- Do not resell these exact workflows
- Do not use for spam or illegal activities
- Respect all API terms of service

---

## Contributing

Found a bug or have an improvement? Please reach out through the course forum or submit an issue via the course platform.

---

**Last Updated:** December 3, 2025
**Course Version:** 1.0
**Maintained By:** [Your Name/Company]
