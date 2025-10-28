# 🚀 Database Quick Reference Card

**Save this or bookmark it - check before every database task!**

---

## ⚡ 30-Second Setup

```bash
# Copy environment template
cp .env.example .env

# Fill in your Supabase DB URL
# → Get from: https://supabase.com/dashboard
# → Click: Connect → Connection pooler → PostgreSQL

# Run the magic validation script
./supabase/db-env-check.sh

# ✅ If all green → You're ready!
# ❌ If any red → See TROUBLESHOOTING.md
```

---

## ✅ Pre-Flight Checklist (Do This First!)

Before ANY database work:

- [ ] `.env` file exists (`cp .env.example .env`)
- [ ] `SUPABASE_DB_URL` is filled in
- [ ] `./supabase/db-env-check.sh` passes
- [ ] No errors about DNS, hostname, or credentials

**Time:** 2 minutes | **Status:** ✅ Pass/❌ Fail

---

## 🔧 Common Commands

### Test Connection
```bash
psql "$SUPABASE_DB_URL" -c "SELECT version();"
```

### Run Validation
```bash
./supabase/db-env-check.sh
```

### View Connection Details (redacted)
```bash
echo "$SUPABASE_DB_URL" | sed 's/:.*@/:***@/'
```

### Use DB Sage Agent
```bash
# In Claude Code
/db-sage
*help    # See all commands
```

---

## 🚨 Error? Follow This

### 1. Get the Error Message
```
Copy the exact error text
```

### 2. Run Diagnostics
```bash
./supabase/db-env-check.sh
```

### 3. Read the Guide
```
docs/database/TROUBLESHOOTING.md
```

### 4. Still Stuck?
```
Post in #database with:
• Your OS (macOS/Linux/Windows)
• Output from: ./supabase/db-env-check.sh
• The exact error message
```

---

## 📋 Error Lookup Table

| Error | Cause | Fix Time |
|-------|-------|----------|
| `nodename nor servname provided` | DNS/Network | <2 min |
| `password authentication failed` | Wrong password | <1 min |
| `connection timeout` | Firewall/Network | <5 min |
| `could not translate` | Network issue | <2 min |
| All checks pass ✅ | Ready! | 0 min |

---

## 🎯 Task-Specific Commands

### Starting a Database Feature
```bash
./supabase/db-env-check.sh    # Validate first
/db-sage                      # Use agent
*create-schema                # Design schema
```

### Running a Migration
```bash
./supabase/db-env-check.sh           # Validate
./scripts/db-verify-order.sh migrate  # Check syntax
./scripts/db-dry-run.sh migrate       # Test safely
./scripts/db-migrate.sh migrate       # Apply
```

### Debugging Issues
```bash
./supabase/db-env-check.sh    # Diagnose
cat docs/database/TROUBLESHOOTING.md  # Find solution
```

---

## 💡 Pro Tips

1. **Save this URL** → `docs/database/TROUBLESHOOTING.md`
   - Bookmark it in your browser
   - 90% of issues are covered there

2. **Run validation before you start**
   - Takes 2 minutes
   - Saves 30 minutes of debugging

3. **Watch the .env file**
   - `SUPABASE_PASSWORD` must be URL-encoded in connection string
   - Special chars like `@` become `%40`

4. **Network issues?**
   - Run `ping 8.8.8.8` to check internet
   - Check if your company blocks `*.supabase.com`

5. **Ask early, ask often**
   - Database issues are often not obvious
   - Better to ask than to waste time

---

## 📞 Help & Resources

| Need | Resource | Time |
|------|----------|------|
| Setup help | `.env.example` + comments | 5 min |
| Error help | `docs/database/TROUBLESHOOTING.md` | 10 min |
| Schema help | Run `/db-sage` in Claude Code | 5 min |
| Team help | Ask in `#database` channel | varies |

---

## ✨ Success Indicators

✅ **You're ready when:**
- `./supabase/db-env-check.sh` shows all green checks
- `psql "$SUPABASE_DB_URL" -c "SELECT 1;"` returns success
- You can see the database version: `SELECT version();`

❌ **You're not ready if:**
- Any check in the validation script shows red
- Connection fails with an error
- You're unsure about any configuration

---

## 🎓 Remember

```
⚡ 30 seconds: Copy .env.example → .env
⚡ 30 seconds: Fill in SUPABASE_DB_URL from Supabase dashboard
⚡ 30 seconds: Run ./supabase/db-env-check.sh
⚡ 30 seconds: Confirm all checks pass

= 2 minutes total setup
= Saves you 30+ minutes of debugging

DO THIS FIRST, EVERY TIME.
```

---

**Last Updated:** 2025-10-28 | **Version:** 1.0 | **Status:** Production Ready
