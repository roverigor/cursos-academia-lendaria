# 🚀 Database Pre-Flight Checklist

## ⏱️ This takes 2 minutes. Do it EVERY time before database work.

### For All Team Members (Interns, Devs, QA)

This checklist prevents 90% of database-related issues before they start.

---

## 🚨 CRITICAL: Use the Right Terminal!

**❌ DO NOT run database commands in Claude Code**
- Claude Code is sandboxed and CANNOT connect to Supabase
- You will get DNS errors every time

**✅ Use Terminal.app (normal macOS terminal)**
```bash
# Open Terminal.app:
# Cmd+Space → "Terminal"

# Navigate to project:
cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"
```

---

## ✅ The Checklist

### 1. Environment is Ready
- [ ] I have cloned the repository
- [ ] I have run `cp .env.example .env`
- [ ] I have obtained and pasted my API keys into `.env`
  - See: `docs/guides/API_SETUP_GUIDE.md`

### 2. Database Variables are Set
- [ ] `SUPABASE_URL` is set in `.env`
- [ ] `SUPABASE_DB_URL` is set in `.env`
- [ ] `SUPABASE_PASSWORD` is set in `.env`

Check with:
```bash
source .env && \
  [ -n "$SUPABASE_DB_URL" ] && echo "✓ SUPABASE_DB_URL is set" || echo "✗ SUPABASE_DB_URL is missing"
```

### 3. Run the Environment Validation Script
- [ ] I have run `./supabase/db-env-check.sh`
- [ ] All checks passed (green checkmarks)

If any checks failed, see: `docs/database/TROUBLESHOOTING.md`

### 4. Verify Database Connection
- [ ] I can connect to the database
  ```bash
  psql "$SUPABASE_DB_URL" -c "SELECT version();"
  ```
- [ ] The command returned PostgreSQL version info (not an error)

---

## 🚨 If Any Check Fails

**STOP HERE.** Do not proceed with database work.

### Quick Troubleshooting

| Check | Error | Solution |
|-------|-------|----------|
| #1 | "No such file or directory" | Run `cp .env.example .env` |
| #2 | "SUPABASE_DB_URL is missing" | Copy values from Supabase dashboard |
| #3 | "✗ Cannot resolve hostname" | See TROUBLESHOOTING.md → DNS issue |
| #3 | "✗ Could not connect" | See TROUBLESHOOTING.md → Connection issue |
| #4 | Connection failed | Run the diagnostic: `./supabase/db-env-check.sh` |

---

## ✅ Ready to Work

If all checks pass, you can now:

- **Use DB Sage:** Run `/db-sage` in Claude Code
- **Run migrations:** `./scripts/db-migrate.sh <migration.sql>`
- **Execute queries:** `psql "$SUPABASE_DB_URL" -c "YOUR QUERY"`
- **Test schema:** `./supabase/db-env-check.sh --test-schema`

---

## 📋 For Specific Tasks

### Starting a Database Feature
```bash
# 1. Pre-flight checklist (above) ✓
# 2. Create a feature branch
git checkout -b feature/database-xyz

# 3. Create migration file
touch supabase/migrations/20251028_1234_description.sql

# 4. Test locally
./supabase/db-env-check.sh

# 5. Run DB Sage to help with design
/db-sage
*create-schema
```

### Running Migrations
```bash
# 1. Pre-flight checklist (above) ✓
# 2. Verify migration syntax
./scripts/db-verify-order.sh supabase/migrations/20251028_1234_description.sql

# 3. Dry-run first
./scripts/db-dry-run.sh supabase/migrations/20251028_1234_description.sql

# 4. Apply migration
./scripts/db-migrate.sh supabase/migrations/20251028_1234_description.sql
```

### Debugging Issues
```bash
# 1. Run diagnostic first
./supabase/db-env-check.sh

# 2. If it shows issues, follow the troubleshooting guide
cat docs/database/TROUBLESHOOTING.md

# 3. Still stuck? Ask for help with diagnostic output
```

---

## 🎓 For Interns

### Your First Day

1. ✓ Run the pre-flight checklist
2. ✓ Ask your mentor to verify it passes
3. ✓ Read `docs/guides/outputs-guide.md` (5 min)
4. ✓ Read the error messages in `docs/database/TROUBLESHOOTING.md` (10 min)
5. ✓ Never ignore DNS/connection errors - ask for help immediately

### Remember

- **Always run the checklist first.** It takes 2 minutes and prevents hours of confusion.
- **If something fails, you didn't do anything wrong.** It's probably network/firewall.
- **Ask for help early.** Don't waste time debugging connectivity.

---

## 📞 Need Help?

1. Run the diagnostic: `./supabase/db-env-check.sh`
2. Read the relevant section in: `docs/database/TROUBLESHOOTING.md`
3. If you're still stuck, ping in `#database` with:
   - Your OS (macOS/Linux/Windows)
   - Output from the diagnostic script
   - The exact error message
   - What you were trying to do

---

## 🔗 Quick Links

- **Troubleshooting:** [docs/database/TROUBLESHOOTING.md](../../docs/database/TROUBLESHOOTING.md)
- **Database Docs:** [docs/database/README.md](../../docs/database/README.md)
- **API Setup:** [docs/guides/API_SETUP_GUIDE.md](../../docs/guides/API_SETUP_GUIDE.md)
- **DB Sage Agent:** Run `/db-sage` in Claude Code

---

**Last Updated:** 2025-10-28
**Target Audience:** All team members (interns, devs, QA)
**Time to Complete:** 2 minutes
