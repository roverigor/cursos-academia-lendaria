# Task: Initialize Greenfield Course (Intelligent Context Detection)

**Type:** Atomic Task
**Responsibility:** Initialize course with intelligent detection of pre-existing brief and source materials
**Duration:** < 1 minute

## Purpose

Initialize a new course with **intelligent context detection**. Detects 3 scenarios:
1. **Greenfield Pure:** No folder exists → Create structure + empty COURSE-BRIEF
2. **Pre-Created Brief:** COURSE-BRIEF already filled → Validate and proceed
3. **Legacy Materials:** `/sources/` exists but no brief → Suggest brownfield mode

---

## Inputs

- `slug` (required) - Course identifier (kebab-case, 3-50 chars)
- `--mmos-persona {mind_name}` (optional) - MMOS persona to use
- `--skip-validation` (optional) - Skip COURSE-BRIEF validation (force mode)

---

## Execution Logic (Context Detection)

### **STEP 1: Detect Course Context**

```python
# Check if course folder exists
course_path = f"outputs/courses/{slug}/"
course_exists = os.path.exists(course_path)

if not course_exists:
    # SCENARIO A: Greenfield Pure
    context = "greenfield_pure"
else:
    # Check COURSE-BRIEF status
    brief_path = f"{course_path}/COURSE-BRIEF.md"
    brief_exists = os.path.exists(brief_path)

    if brief_exists:
        # Check if COURSE-BRIEF is filled
        brief_filled = check_brief_completeness(brief_path)

        if brief_filled >= 70%:  # At least 70% complete
            # SCENARIO B: Pre-Created Brief
            context = "pre_created_brief"
        else:
            # SCENARIO A: Greenfield (brief exists but empty)
            context = "greenfield_pure"
    else:
        # Check for legacy materials
        sources_path = f"{course_path}/sources/"
        has_sources = os.path.exists(sources_path) and len(os.listdir(sources_path)) > 0

        if has_sources:
            # SCENARIO C: Legacy Materials (suggest brownfield)
            context = "legacy_materials"
        else:
            # SCENARIO A: Greenfield (folder exists but empty)
            context = "greenfield_pure"
```

### **STEP 2: Execute Context-Appropriate Workflow**

#### **SCENARIO A: Greenfield Pure**
```bash
# Create folder structure
mkdir -p outputs/courses/{slug}/

# Create empty COURSE-BRIEF.md (8 sections)
cp templates/COURSE-BRIEF-template.md outputs/courses/{slug}/COURSE-BRIEF.md

# Create metadata
echo '{
  "slug": "{slug}",
  "mode": "greenfield",
  "context": "greenfield_pure",
  "created_at": "$(date -Iseconds)",
  "mmos_persona": "{mmos_persona}"
}' > outputs/courses/{slug}/.metadata.json

# Create README
echo "# {slug}" > outputs/courses/{slug}/README.md
```

**Output Message:**
```
✅ Course initialized: {slug}

📝 Next Step: Fill COURSE-BRIEF.md
   File: outputs/courses/{slug}/COURSE-BRIEF.md
   Sections to complete: 8

When ready, system will auto-detect and proceed to market research.
```

#### **SCENARIO B: Pre-Created Brief** 🆕 (SEU CASO!)
```bash
# Validate existing COURSE-BRIEF
python scripts/validate_brief.py outputs/courses/{slug}/COURSE-BRIEF.md

# Check for source materials
sources_path="outputs/courses/{slug}/sources/"
if [ -d "$sources_path" ]; then
    source_count=$(find "$sources_path" -type f | wc -l)
    echo "✅ Found $source_count source materials"
else
    echo "ℹ️  No source materials found (optional)"
fi

# Update metadata (preserve existing, add context)
python scripts/update_metadata.py outputs/courses/{slug}/.metadata.json \
  --context "pre_created_brief" \
  --brief_completeness "$(python scripts/check_brief.py outputs/courses/{slug}/COURSE-BRIEF.md)" \
  --has_sources "$([ -d "$sources_path" ] && echo true || echo false)"
```

**Output Message:**
```
✅ Course detected: {slug}

📊 Context Analysis:
   ✅ COURSE-BRIEF.md: {completeness}% complete
   ✅ Source materials: {source_count} files found in /sources/
   ✅ Mode: Greenfield (pre-created brief)

🎯 Next Step: Proceeding to market research
   (Skipping manual COURSE-BRIEF filling - already complete!)

System will now:
1. Run market research (competitive intelligence)
2. Reformulate COURSE-BRIEF with research insights
3. Present for your review

Continue? (Y/n)
```

#### **SCENARIO C: Legacy Materials** 🆕
```bash
# Detect legacy materials without brief
sources_path="outputs/courses/{slug}/sources/"
source_count=$(find "$sources_path" -type f | wc -l)
```

**Output Message:**
```
⚠️  Legacy Materials Detected

📂 Found {source_count} files in /sources/ but no COURSE-BRIEF.md

💡 Recommendation: Use brownfield mode instead
   Command: *upgrade {slug}

Brownfield mode will:
   - Auto-organize your source files
   - Auto-extract ICP, voice, objectives
   - Generate COURSE-BRIEF from materials
   - Run market research
   - Create optimized curriculum

Switch to brownfield mode? (Y/n)
```

---

## Execution Command

```bash
python expansion-packs/creator-os/scripts/init_course.py \
  --mode greenfield \
  --slug "$slug" \
  ${mmos_persona:+--mmos-persona "$mmos_persona"} \
  ${skip_validation:+--skip-validation}
```

---

## Outputs by Scenario

### **Scenario A: Greenfield Pure**
```
outputs/courses/{slug}/
├── COURSE-BRIEF.md (8 empty sections)
├── .metadata.json (context: greenfield_pure)
└── README.md
```

### **Scenario B: Pre-Created Brief** 🆕
```
outputs/courses/{slug}/
├── COURSE-BRIEF.md (already filled 70-100%)
├── sources/ (optional - materials de apoio)
│   ├── document1.pdf
│   ├── transcript1.txt
│   └── reference-links.md
├── .metadata.json (context: pre_created_brief, brief_completeness: 85%)
└── README.md
```

### **Scenario C: Legacy Materials**
```
outputs/courses/{slug}/
├── sources/ (materiais legados)
│   ├── legacy-video.mp4
│   └── old-course-outline.pdf
├── .metadata.json (context: legacy_materials, suggestion: brownfield)
└── README.md (with brownfield suggestion)
```

---

## Success Criteria

**All Scenarios:**
- ✅ Folder exists at `outputs/courses/{slug}/`
- ✅ .metadata.json contains slug, mode, context, created_at

**Scenario A (Greenfield Pure):**
- ✅ COURSE-BRIEF.md created with 8 empty sections
- ✅ User instructed to fill brief

**Scenario B (Pre-Created Brief):**
- ✅ COURSE-BRIEF.md validated (≥70% complete)
- ✅ Source materials detected (if present)
- ✅ User informed next step is market research
- ✅ Workflow proceeds automatically

**Scenario C (Legacy Materials):**
- ✅ Source materials counted
- ✅ User prompted to switch to brownfield mode
- ✅ Clear instructions provided

---

**Status:** ✅ Ready
