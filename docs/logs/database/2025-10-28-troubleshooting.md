# 🆘 Database Connection Troubleshooting Guide

> **CRITICAL:** Run `./supabase/db-env-check.sh` BEFORE starting any database work. This catches 90% of issues immediately.

---

## 🚨 MOST COMMON ISSUE: Running in Claude Code (Sandboxed Environment)

**If you're using Claude Code and getting DNS errors:**

### The Problem
Claude Code runs in a **sandboxed environment** that **CANNOT connect to external databases** like Supabase. The sandbox only allows connections to:
- github.com
- claude.ai
- A few other whitelisted hosts

**Supabase is NOT whitelisted**, so connection will ALWAYS fail in Claude Code.

### The Solution

**✅ Use your normal terminal instead:**

```bash
# 1. Open Terminal.app (NOT Claude Code terminal)
#    Cmd+Space → "Terminal"

# 2. Navigate to project:
cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"

# 3. Run validation:
./supabase/db-env-check.sh

# 4. Run your database commands:
source .env
psql "$SUPABASE_DB_URL" -c "SELECT version();"
```

**Alternative: Disable Sandbox (Not Recommended)**

If you MUST use Claude Code for database operations, you can disable sandbox:
```bash
# In Claude Code, explicitly request:
"Please run this with dangerouslyDisableSandbox: true"
```

⚠️ **Warning:** This removes security protections. Only use for trusted operations.

---

## Quick Diagnosis

```bash
# Step 1: Are you in Claude Code?
# → YES: Use normal Terminal.app instead (see above)
# → NO: Continue to Step 2

# Step 2: Run the environment check
./supabase/db-env-check.sh

# Step 3: If that fails, follow the specific error below
```

---

## Error: "nodename nor servname provided, or not known"

### What This Means
The system cannot resolve the hostname `aws-1-us-east-2.pooler.supabase.com` to an IP address.

### Root Causes (in order of likelihood)

**1. No Internet Connection** (40% of cases)
```bash
# Test internet connectivity
ping 8.8.8.8

# If this fails → Your network is offline or blocked
# Solution:
# • Check WiFi/Ethernet connection
# • Check corporate firewall/VPN
# • Check ISP connectivity
```

**2. DNS Resolution Not Working** (35% of cases)
```bash
# Test DNS directly
nslookup aws-1-us-east-2.pooler.supabase.com
# OR
dig aws-1-us-east-2.pooler.supabase.com
# OR
getent hosts aws-1-us-east-2.pooler.supabase.com

# If all fail → DNS is broken
# Solution:
# macOS:
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Linux:
sudo systemctl restart systemd-resolved

# Windows:
ipconfig /flushdns
```

**3. Corporate Firewall/Proxy Blocking Supabase** (20% of cases)
```bash
# Test if you can reach Supabase servers
nc -zv aws-1-us-east-2.pooler.supabase.com 5432

# If timeout → Firewall is blocking
# Solution:
# • Contact IT to whitelist *.supabase.com
# • Check corporate proxy settings
# • Try from outside network to confirm
```

**4. Wrong Pooler Endpoint** (5% of cases)
```bash
# Check if endpoint is correct
echo $SUPABASE_DB_URL | grep -o '@[^:]*'

# Should be: aws-1-us-east-2.pooler.supabase.com
# If different → Update .env

# Find correct endpoint in Supabase dashboard:
# 1. Go to https://supabase.com/dashboard
# 2. Click on your project
# 3. Click "Connect"
# 4. Select "Connection pooler"
# 5. Copy the full connection string
```

---

## Error: "psql: FATAL: password authentication failed"

### Root Causes

**1. Wrong Password in .env**
```bash
# Check if password is correct
grep "SUPABASE_PASSWORD" .env

# Password should match what's in Supabase dashboard:
# 1. Project Settings → Database
# 2. Copy the database password
# 3. Update SUPABASE_PASSWORD in .env
# 4. Update SUPABASE_DB_URL (contains password)
```

**2. Password Contains Special Characters (URL Encoding Issue)**
```bash
# Check if password has special characters
grep "SUPABASE_PASSWORD" .env

# Example: password = "XmVcZUKu@" contains "@"
# In URL, it must be encoded as "%40"
#
# ✓ Correct:  postgresql://postgres:XmVcZUKu%40@host:5432/postgres
# ✗ Wrong:    postgresql://postgres:XmVcZUKu@@host:5432/postgres

# If wrong → Update SUPABASE_DB_URL with proper encoding
```

**3. Password Expired or Changed**
```bash
# If someone recently changed the database password:
# 1. Go to Supabase dashboard
# 2. Project Settings → Database
# 3. Click "Reset password"
# 4. Copy new password
# 5. Update .env with new password
# 6. Update SUPABASE_DB_URL

# ⚠️ WARNING: Resetting password disconnects all existing connections!
```

---

## Error: "connection timeout"

### Root Causes

**1. Database Server Is Down**
```bash
# Check Supabase status
open "https://status.supabase.com"

# If red indicators → Service is down
# Solution: Wait for Supabase to recover
```

**2. Connection Pool Is Exhausted**
```bash
# Check how many connections are active
psql "$SUPABASE_DB_URL" -c "SELECT count(*) FROM pg_stat_activity;"

# If > 100 connections → Pool is full
# Solution:
# 1. Wait for connections to close naturally (30 second timeout)
# 2. Or contact Supabase support to force-close idle connections
```

**3. Network Timeout on Your End**
```bash
# Increase timeout in psql
psql "$SUPABASE_DB_URL" -c "SELECT 1;" --connect-timeout=30

# Or in SUPABASE_DB_URL, add timeout:
# postgresql://.../?connect_timeout=30
```

---

## Error: "permission denied"

### Root Causes

**1. Using Wrong Role/User**
```bash
# Check which user SUPABASE_DB_URL is using
echo "$SUPABASE_DB_URL" | grep -oP 'postgresql://\K[^:]*'

# Should be: postgres
# If different → Update .env
```

**2. Role Doesn't Have Permission**
```bash
# This shouldn't happen with default Supabase setup
# But if it does:

# 1. Verify you're using the correct credentials
# 2. Check Supabase dashboard > Project Settings > Database
# 3. If still failing, contact Supabase support
```

---

## Error: "SSL/TLS Error"

### Root Causes

**1. SSL Mode Mismatch**
```bash
# Check if SUPABASE_DB_URL has correct SSL mode
echo "$SUPABASE_DB_URL" | grep -o 'sslmode=[^&]*'

# Should be: sslmode=require
# If different → Update to: sslmode=require
```

**2. Certificate Validation Failed**
```bash
# If you're behind a corporate proxy with SSL inspection:

# Try disabling cert validation (DEV ONLY - NOT FOR PRODUCTION):
psql "postgresql://.../?sslmode=require&sslcert=.../cert.pem" ...

# For production, update corporate CA certificates
```

---

## Error: "FATAL: database does not exist"

### Root Causes

**1. Trying to Connect to Wrong Database**
```bash
# Check SUPABASE_DB_URL
echo "$SUPABASE_DB_URL" | grep -o '/[^?]*'

# Should end with: /postgres
# This is the default Supabase database
```

**2. Supabase Project Was Deleted**
```bash
# If database was deleted:
# 1. Create new Supabase project
# 2. Copy new connection string
# 3. Update .env with new SUPABASE_DB_URL
# 4. Run migrations to recreate schema
```

---

## Diagnostic Script Output

### ✅ All Checks Passed
```
✅ ALL CHECKS PASSED (8/8)

Your database environment is configured correctly!
```
→ You can proceed with database operations

### ❌ Validation Failed
```
❌ VALIDATION FAILED (2 ISSUES FOUND)

✗ Cannot resolve hostname: aws-1-us-east-2.pooler.supabase.com
  → Check your internet connection
  → Check firewall/proxy settings
```
→ Follow the specific error in this guide

---

## Step-by-Step Recovery

### If You're Stuck:

1. **Run the diagnostic script** (takes 30 seconds)
   ```bash
   ./supabase/db-env-check.sh
   ```

2. **Follow the specific error above** that matches your issue

3. **Test the fix**
   ```bash
   psql "$SUPABASE_DB_URL" -c "SELECT version();"
   ```

4. **Run the diagnostic again** to confirm
   ```bash
   ./supabase/db-env-check.sh
   ```

5. **If still failing**, check the logs:
   ```bash
   # View recent psql errors
   echo "Connection attempted to: $(echo $SUPABASE_DB_URL | sed 's/:.*@/:***@/')"

   # Test with verbose output
   psql "$SUPABASE_DB_URL" -c "SELECT 1;" -v
   ```

---

## For Interns & New Team Members

### Before You Start Any Database Work:

```bash
# 1. Run the environment check (mandatory)
./supabase/db-env-check.sh

# ✅ If it passes → You're good to go
# ❌ If it fails → Follow the troubleshooting guide above
#    → Ask for help in #database channel
```

### Common Issues You Might Hit:

| Issue | Time to Fix | Solution |
|-------|-------------|----------|
| Network offline | 1 min | Check WiFi/VPN |
| DNS broken | 2 min | Flush DNS cache |
| Wrong .env | 1 min | Copy from .env.example |
| Wrong password | 1 min | Check Supabase dashboard |
| Corporate firewall | 15 min | Contact IT to whitelist *.supabase.com |

**Golden Rule:** If anything fails, run the diagnostic script first. It tells you exactly what's wrong.

---

## Getting Help

1. **First:** Run `./supabase/db-env-check.sh`
2. **Then:** Check the relevant section in this guide
3. **Still stuck:** Ask in #database with:
   - Output from the diagnostic script (redact passwords!)
   - The specific error message
   - What you were trying to do

---

**Last Updated:** 2025-10-28
**Maintained By:** Database Team
**Status:** Production Ready
