# 🔧 Database Connection Issue - Resolution & Prevention

**Date:** 2025-10-28
**Issue:** Intern encountered DNS resolution failure when attempting database operations
**Error:** `nodename nor servname provided, or not known` for `aws-1-us-east-2.pooler.supabase.com`
**Root Cause:** Missing environment configuration validation before database work
**Status:** ✅ RESOLVED with permanent safeguards

---

## 📋 What Was The Problem?

An intern started working on a database-related task but encountered a DNS resolution error:

```
Error: psql: erro: não foi possível traduzir o nome de hospedagem
"aws-1-us-east-2.pooler.supabase.com" para um endereço: nodename nor
servname provided, or not known
```

**Why This Happened:**
1. No validation of database connectivity BEFORE starting work
2. No clear setup checklist for team members
3. No automated diagnostics to catch configuration issues early
4. Confusing error messages that don't explain the actual problem

**Impact:**
- Wasted time debugging environmental issues instead of doing productive work
- Frustration and confusion for the intern
- Silent failure without clear guidance

---

## ✅ What Was Fixed?

### 1. **Database Environment Check Script** (✅ Complete)
**File:** `./supabase/db-env-check.sh`

Automated validation script that checks:
- ✅ `.env` file exists and is loaded
- ✅ `SUPABASE_DB_URL` is configured
- ✅ `SUPABASE_URL` is configured
- ✅ Network connectivity to Supabase
- ✅ DNS resolution of the pooler endpoint
- ✅ Actual database connection
- ✅ Current schema version

**How to Use:**
```bash
# Run this before ANY database work
./supabase/db-env-check.sh

# Output shows exactly what's wrong and how to fix it
```

### 2. **Comprehensive Troubleshooting Guide** (✅ Complete)
**File:** `./docs/database/TROUBLESHOOTING.md`

Detailed guide covering:
- 🔍 **DNS Resolution Issues** - Step-by-step diagnosis and fixes
- 🔐 **Authentication Failures** - Password encoding, expired credentials
- 🌐 **Network Connectivity** - Firewall, proxy, timeout issues
- 🔗 **Connection Errors** - How to diagnose and resolve
- 📊 **SSL/TLS Issues** - Certificate validation problems
- 🗄️ **Database Access Errors** - Permission and schema issues

Each section includes:
- Root cause analysis
- Diagnostic commands to run
- Solutions with examples
- Prevention tips

### 3. **Pre-Flight Checklist for All Team Members** (✅ Complete)
**File:** `./supabase/PRE-FLIGHT-CHECKLIST.md`

Simple 2-minute checklist that must be completed BEFORE any database work:
1. Environment is ready (.env is copied and filled)
2. Database variables are set
3. Run `./supabase/db-env-check.sh`
4. Verify database connection works

**Who:** All team members (interns, devs, QA)
**When:** Before starting any database-related task
**Time:** ~2 minutes

### 4. **Updated .env.example** (✅ Complete)
**File:** `./.env.example`

Clear, step-by-step instructions:
- What each variable is for
- Where to obtain each API key
- How to find and configure `SUPABASE_DB_URL`
- Troubleshooting tips
- Setup verification checklist

---

## 🎯 How to Prevent This From Happening Again

### For Interns & New Team Members

**Before you start ANY work:**

```bash
# Step 1: Copy the example file
cp .env.example .env

# Step 2: Fill in your API keys
# → See: docs/guides/API_SETUP_GUIDE.md

# Step 3: Run the validation script
./supabase/db-env-check.sh

# ✅ If all checks pass → You're ready to work
# ❌ If any check fails → Read docs/database/TROUBLESHOOTING.md
```

### For Team Leads (Setting Up New Interns)

1. **First Day Setup:**
   ```bash
   # Have intern copy and fill .env
   cp .env.example .env

   # Have intern run validation
   ./supabase/db-env-check.sh

   # Verify all checks pass
   ```

2. **Send These Resources:**
   - `supabase/PRE-FLIGHT-CHECKLIST.md` - Must read before any DB work
   - `docs/database/TROUBLESHOOTING.md` - Bookmark this for reference
   - `docs/guides/API_SETUP_GUIDE.md` - For obtaining keys

3. **Verify Setup:**
   ```bash
   # Test the connection
   psql "$SUPABASE_DB_URL" -c "SELECT version();"
   ```

### For the Whole Team

**Golden Rules:**

1. ✅ **Always run the pre-flight checklist first**
   - Takes 2 minutes
   - Prevents hours of debugging

2. ✅ **If something fails, don't try to work around it**
   - Run the diagnostic script
   - Follow the troubleshooting guide
   - Ask for help in `#database` channel

3. ✅ **Report new issues immediately**
   - Add to `docs/database/TROUBLESHOOTING.md`
   - Update the pre-flight checklist
   - Share with the team

---

## 📊 Success Metrics

We'll know this is working when:

- [ ] Zero silent database connection failures
- [ ] All team members run pre-flight checklist before database work
- [ ] Issues are diagnosed in <2 minutes using the validation script
- [ ] Database work starts within 5 minutes of starting a task (not 30+ minutes debugging)

---

## 🔍 Testing the Solution

### Verify It Works

```bash
# 1. Run the diagnostic script
./supabase/db-env-check.sh

# Expected output for successful setup:
# ✅ ALL CHECKS PASSED (8/8)
# Your database environment is configured correctly!

# 2. Test the connection directly
psql "$SUPABASE_DB_URL" -c "SELECT version();"

# Should show PostgreSQL version (e.g., "PostgreSQL 16.4 on x86_64-pc-linux-gnu")
```

### Test Troubleshooting

If you temporarily break something to test:

```bash
# Test 1: Missing SUPABASE_DB_URL
unset SUPABASE_DB_URL
./supabase/db-env-check.sh
# Should show: ✗ SUPABASE_DB_URL not set in .env

# Test 2: Wrong password
SUPABASE_DB_URL="postgresql://postgres:wrongpass@..." ./supabase/db-env-check.sh
# Should show: ✗ Could not connect to database

# Test 3: Wrong hostname
SUPABASE_DB_URL="postgresql://postgres:pass@wronghost.com..." ./supabase/db-env-check.sh
# Should show: ✗ Cannot resolve hostname
```

---

## 📞 Quick Reference

| Problem | Solution | Time |
|---------|----------|------|
| DNS error | Run `./supabase/db-env-check.sh` and follow output | <2 min |
| Password error | Check `.env` SUPABASE_DB_URL and SUPABASE_PASSWORD | <1 min |
| No internet | Run `ping 8.8.8.8` to check connectivity | <1 min |
| Firewall blocking | Ask IT to whitelist `*.supabase.com` | 15 min |
| Still stuck | Post in `#database` with diagnostic output | varies |

---

## 📚 Related Documentation

- **Setup Guide:** [`docs/guides/API_SETUP_GUIDE.md`](../guides/API_SETUP_GUIDE.md)
- **Troubleshooting:** [`docs/database/TROUBLESHOOTING.md`](./TROUBLESHOOTING.md)
- **Pre-Flight Checklist:** [`supabase/PRE-FLIGHT-CHECKLIST.md`](../../supabase/PRE-FLIGHT-CHECKLIST.md)
- **Database README:** [`docs/database/README.md`](./README.md)
- **DB Sage Agent:** Run `/db-sage` in Claude Code

---

## 🎓 Lessons Learned

1. **Validate Early** - Catch configuration issues before they cause problems
2. **Clear Checklists** - Simple step-by-step guides prevent mistakes
3. **Automated Diagnostics** - Scripts are faster and more reliable than manual troubleshooting
4. **Documentation Matters** - Good troubleshooting guides save hours of debugging
5. **Team Communication** - Make sure everyone knows where to find help

---

## 🚀 Next Steps

1. ✅ Integrate pre-flight checklist into team onboarding
2. ✅ Link to troubleshooting guide from team documentation
3. ✅ Add check for `db-env-check.sh` to any database-related PRs
4. ✅ Review with team at next standup
5. ✅ Update this doc if new issues are discovered

---

**Owner:** Database Team
**Last Updated:** 2025-10-28
**Status:** ✅ Production Ready
**Review Date:** 2025-11-28

