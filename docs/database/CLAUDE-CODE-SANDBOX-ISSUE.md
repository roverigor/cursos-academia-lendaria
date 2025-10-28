# 🚨 CRITICAL: Claude Code Cannot Connect to Databases

**Date:** 2025-10-28
**Severity:** High - Affects all database operations in Claude Code
**Status:** Documented - Working as designed (sandbox security)

---

## 🎯 TL;DR

**Claude Code CANNOT connect to Supabase (or any external database).**

```
❌ Claude Code → Sandboxed → Cannot reach Supabase
✅ Terminal.app → Not sandboxed → Can reach Supabase
```

**Solution: Use Terminal.app for ALL database operations.**

---

## 🔍 The Problem

### What You See
```
Error: psql: erro: não foi possível traduzir o nome de hospedeiro
"aws-1-us-east-2.pooler.supabase.com" para um endereço:
nodename nor servname provided, or not known
```

### What's Really Happening

Claude Code runs in a **sandbox** for security. The sandbox **blocks network connections** to external hosts, except for a small whitelist:

**Allowed:**
- github.com
- claude.ai
- eu-central-1-1.aws.cloud2.influxdata.com
- release-assets.githubusercontent.com

**Not Allowed:**
- ❌ Supabase (*.supabase.com)
- ❌ PostgreSQL databases
- ❌ MySQL databases
- ❌ MongoDB databases
- ❌ Any other external database service

### Why This Happens

This is **by design** for security:
- Prevents accidental data exposure
- Prevents malicious code from accessing databases
- Protects credentials from being leaked

**This is NOT a bug. This is a security feature.**

---

## ✅ The Solution

### For Database Operations: Use Terminal.app

**Step 1: Open Terminal.app (NOT Claude Code)**
```bash
# On macOS: Cmd+Space → "Terminal"
# Or: Applications → Utilities → Terminal
```

**Step 2: Navigate to Project**
```bash
cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"
```

**Step 3: Run Validation**
```bash
./supabase/db-env-check.sh
```

**Step 4: Run Your Database Commands**
```bash
# Source environment
source .env

# Connect to database
psql "$SUPABASE_DB_URL"

# Or run SQL file
psql "$SUPABASE_DB_URL" -f path/to/file.sql

# Or run single query
psql "$SUPABASE_DB_URL" -c "SELECT version();"
```

---

## 🎓 What Each Tool Is For

### Claude Code (Sandboxed)
**✅ Use for:**
- Code generation
- File editing
- Documentation
- Planning
- Architecture discussions
- Code reviews

**❌ Do NOT use for:**
- Database connections
- Database migrations
- Database queries
- Any psql/pg_dump commands
- Network operations to external services

### Terminal.app (Not Sandboxed)
**✅ Use for:**
- Database connections
- Running migrations
- Executing SQL files
- psql commands
- Any network operations
- System administration

---

## 🛠️ Alternative: Disable Sandbox (Not Recommended)

If you **absolutely must** use Claude Code for database operations, you can disable the sandbox:

### How to Request Sandbox Bypass

In Claude Code, explicitly request:
```
"Please run this command with dangerouslyDisableSandbox: true"
```

Then Claude Code will execute the command without sandbox restrictions.

### ⚠️ WARNING: Risks of Disabling Sandbox

- Removes security protections
- Could accidentally expose credentials
- Could allow malicious code to run
- Only use for trusted operations
- Never use with untrusted SQL or code

**Recommendation: Just use Terminal.app instead. It's easier and safer.**

---

## 📋 Workflow for Team Members

### When Working on Database Features:

1. **Planning & Design** → Use Claude Code
   - Design schema
   - Write migration scripts
   - Generate SQL
   - Review code

2. **Execution & Testing** → Use Terminal.app
   - Run validation script
   - Execute migrations
   - Test queries
   - Verify results

3. **Documentation** → Use Claude Code
   - Update docs
   - Write comments
   - Create guides

### Example Workflow:

```
┌─────────────────────────────────────────────────┐
│ Claude Code (Planning)                          │
│ • Design schema                                 │
│ • Write migration.sql                           │
│ • Generate documentation                        │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ Terminal.app (Execution)                        │
│ • Run: ./supabase/db-env-check.sh              │
│ • Apply: psql "$SUPABASE_DB_URL" -f migration  │
│ • Verify: psql "$SUPABASE_DB_URL" -c "SELECT"  │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ Claude Code (Documentation)                     │
│ • Update changelog                              │
│ • Document changes                              │
│ • Commit and push                               │
└─────────────────────────────────────────────────┘
```

---

## 🎯 Key Takeaways

1. **Claude Code is sandboxed** - This is intentional for security
2. **Use Terminal.app for database work** - It's not sandboxed
3. **Claude Code is still useful** - For planning, coding, documentation
4. **Validation script works in Terminal.app** - `./supabase/db-env-check.sh`
5. **This is not a bug** - It's working as designed

---

## 📞 What to Tell Team Members

### Quick Explanation:
"Claude Code can't connect to databases for security reasons. Use Terminal.app for database commands instead."

### Full Explanation:
"Claude Code runs in a sandbox that blocks external network connections. This is a security feature to prevent accidental data exposure. For database operations, you need to use your normal terminal (Terminal.app on macOS) instead. Claude Code is still great for planning and coding, just not for executing database commands."

---

## 🔗 Updated Documentation

All guides now include this information:

- ✅ `docs/database/TROUBLESHOOTING.md` - Section at the top
- ✅ `supabase/PRE-FLIGHT-CHECKLIST.md` - Critical warning added
- ✅ `supabase/QUICK-REFERENCE.md` - (Update needed)
- ✅ `docs/database/TEAM-COMMUNICATION.md` - (Update needed)

---

## 🚀 Action Items

### For the Team:
- [ ] Read this document
- [ ] Understand Claude Code limitations
- [ ] Use Terminal.app for database work
- [ ] Run validation script in Terminal.app

### For Team Leads:
- [ ] Communicate this to team
- [ ] Update onboarding docs
- [ ] Verify everyone understands
- [ ] Add to team handbook

### For Documentation:
- [x] Update TROUBLESHOOTING.md
- [x] Update PRE-FLIGHT-CHECKLIST.md
- [x] Create this document
- [ ] Update QUICK-REFERENCE.md
- [ ] Update TEAM-COMMUNICATION.md

---

## ✨ Summary

**The Problem:**
- Claude Code sandbox blocks Supabase connections
- This causes DNS errors for everyone
- It's NOT a configuration issue
- It's a security feature

**The Solution:**
- Use Terminal.app for database operations
- Keep using Claude Code for planning/coding
- Follow the pre-flight checklist
- Validate in Terminal.app before executing

**Remember:**
```bash
# ❌ Don't do this in Claude Code
psql "$SUPABASE_DB_URL" -c "SELECT 1;"

# ✅ Do this in Terminal.app instead
# (Cmd+Space → "Terminal")
psql "$SUPABASE_DB_URL" -c "SELECT 1;"
```

---

**Status:** ✅ Documented and communicated
**Last Updated:** 2025-10-28
**Owner:** Database Team
