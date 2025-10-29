# 🧪 Week 2 Quick Test Guide - First Course Generation

**Goal:** Generate your first course with database persistence and verify everything works!

**Duration:** ~15-30 minutes

---

## ✅ Pre-flight Checklist

Before generating your first course:

```bash
# 1. Verify feature flag is enabled
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Code/mente_lendaria
source .env
echo "Feature flag: $CREATOR_OS_DB_PERSIST"
# Expected output: true

# 2. Test database connection
psql "$SUPABASE_DB_URL" -c "SELECT 1"
# Expected: (1 row)

# 3. Capture baseline
./supabase/scripts/week2-monitor.sh | grep "Week 2 Progress"
# Note the current count
```

---

## 🎯 Generate First Test Course

### Option 1: Use Existing CreatorOS Script

If you have a course generation script:

```bash
cd expansion-packs/creator-os

# Make sure .env is loaded
source ../../.env

# Run your normal course generation
# Example (adjust to your actual command):
python generate_course.py --slug test-week2-course-1 --topic "Introduction to Python"

# OR use your CLI:
./creator-os new test-week2-course-1 "Introduction to Python"
```

### Option 2: Direct Python Test

Create a minimal test:

```python
# test_week2.py
import os
import sys
sys.path.insert(0, 'expansion-packs/creator-os')

from lib.db_persister import CoursePersister

# Initialize persister
persister = CoursePersister()
print(f"Persister enabled: {persister._is_enabled()}")

# Test 1: Persist a project
project_id = persister.persist_project(
    slug='test-week2-course-1',
    name='Week 2 Test Course',
    creator_mind_id=None,  # Will test with mind_id later
    project_type='course',
    description='First test course for Week 2 staging',
    metadata={'source': 'week2_test', 'phase': 'staging'}
)

print(f"Project ID: {project_id}")

# Test 2: Persist course outline
if project_id:
    content_id = persister.persist_content(
        project_id=project_id,
        content_type='course_outline',
        title='Week 2 Test Course Outline',
        content='## Module 1\n### Lesson 1.1\n### Lesson 1.2',
        metadata={'test': True}
    )
    print(f"Content ID: {content_id}")
```

Run it:

```bash
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Code/mente_lendaria
source .env
source .venv/bin/activate
python test_week2.py
```

---

## ✅ Verification Steps

After generating the course:

### Step 1: Check Filesystem

```bash
ls -la outputs/courses/test-week2-course-1/
# Should see: curriculum.yaml, modules/, etc.
```

### Step 2: Check Database

```bash
source .env

# Check if project was persisted
psql "$SUPABASE_DB_URL" -c "
SELECT slug, name, created_at
FROM content_projects
WHERE slug = 'test-week2-course-1';
"
# Expected: 1 row

# Check if contents were persisted
psql "$SUPABASE_DB_URL" -c "
SELECT content_type, title
FROM contents
WHERE project_id = (
    SELECT id FROM content_projects WHERE slug = 'test-week2-course-1'
);
"
# Expected: 1+ rows
```

### Step 3: Run Monitoring

```bash
./supabase/scripts/week2-monitor.sh
```

**What to look for:**
- ✅ "Week 2 Progress" shows 1 course (33% of target)
- ✅ "Recent Activity" shows new project
- ✅ "Latest Projects" includes test-week2-course-1

---

## 📊 Performance Measurement

### Baseline (WITHOUT database)

1. Disable persistence temporarily:

```bash
export CREATOR_OS_DB_PERSIST=false
time python generate_course.py --slug baseline-test
# Note the "real" time
```

### With Database

2. Enable persistence:

```bash
export CREATOR_OS_DB_PERSIST=true
time python generate_course.py --slug with-db-test
# Note the "real" time
```

### Calculate Overhead

```bash
# Example:
# Baseline: 120 seconds
# With DB:  125 seconds
# Overhead: (125 - 120) / 120 * 100 = 4.2%
```

**Target:** <10% overhead

---

## 🚨 Troubleshooting

### Issue: "Database write failed"

**Check:**
```bash
# 1. Verify credentials
echo $SUPABASE_SERVICE_KEY | cut -c1-20
# Should show: eyJhbGciOiJIUzI1NiI...

# 2. Test connection
psql "$SUPABASE_DB_URL" -c "SELECT 1"

# 3. Check logs
tail -f expansion-packs/creator-os/logs/*.log
```

**Solution:**
- Ensure `SUPABASE_SERVICE_KEY` is set (not just `SUPABASE_SERVICE_ROLE_KEY`)
- Check database is online
- Verify SSL certificate is valid

---

### Issue: "Feature flag not working"

**Check:**
```bash
cd expansion-packs/creator-os
python3 -c "
import os
print('Flag from env:', os.getenv('CREATOR_OS_DB_PERSIST'))

# Load .env manually
from pathlib import Path
env_file = Path('../../.env')
for line in env_file.read_text().splitlines():
    if 'CREATOR_OS_DB_PERSIST' in line:
        print('Flag in .env:', line)
"
```

**Solution:**
- Ensure you run `source .env` before generating courses
- Verify `.env` has `CREATOR_OS_DB_PERSIST=true` (no spaces!)

---

### Issue: "Mind attribution not populated"

**Check:**
```bash
psql "$SUPABASE_DB_URL" -c "
SELECT creator_mind_id, persona_mind_id
FROM content_projects
WHERE slug = 'test-week2-course-1';
"
```

**Solution:**
- This is EXPECTED for manual tests (you didn't pass mind_id)
- Real course generation should pass `creator_mind_id` from brief parsing
- Update `brief_parser.py` integration if needed

---

## 📋 Success Criteria

After first test course:

- [x] Filesystem has course files (outputs/courses/...)
- [x] Database has project entry (content_projects table)
- [x] Database has content entries (contents table)
- [x] Monitoring script shows 1 new course
- [x] No errors in logs
- [x] Performance overhead <10% (if measured)

---

## 🎉 If Everything Works

Celebrate! 🎉 Then:

1. **Document in tracking log:**
   ```bash
   nano docs/stories/completed/creator-os-database-integration/tracking/week2-tracking.md
   # Update "Day 1" section with results
   ```

2. **Generate 2-4 more courses:**
   - Use real course topics (not test data)
   - Vary complexity (simple → complex)
   - Monitor each generation

3. **Monitor daily:**
   ```bash
   ./supabase/scripts/week2-monitor.sh >> logs/week2-daily-$(date +%Y%m%d).log
   ```

4. **Report to team:**
   - Week 2 is progressing well
   - X/5 courses generated
   - No critical issues

---

## 🚨 If Something Breaks

**ROLLBACK IMMEDIATELY:**

```bash
# 1. Disable persistence
nano .env
# Change: CREATOR_OS_DB_PERSIST=false

# 2. Verify filesystem-only works
source .env
# Generate test course
# Confirm it works

# 3. Document issue
nano docs/stories/completed/creator-os-database-integration/tracking/week2-tracking.md
# Add to "Issues Found" section

# 4. Debug
# Check logs, database state, etc.
# Fix the issue
# Re-enable and test again
```

---

**Good luck with your first Week 2 test! 🚀**

**Need help?** Run `/db-sage` in Claude Code.
