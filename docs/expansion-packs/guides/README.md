# Integration Guides

**Step-by-step guides for working with expansion packs**

---

## Purpose

Integration guides provide:
- ✅ **How-to tutorials** for common integration patterns
- ✅ **Best practices** for cross-pack development
- ✅ **Troubleshooting** for integration issues
- ✅ **Code examples** for implementing integrations

---

## Available Guides

### Getting Started
- `getting-started.md` - Overview of expansion pack system
- `quick-start-guide.md` - 5-minute introduction

### Integration Guides
- `etl-mmos-integration.md` - Collecting data for minds
- `innerlens-mmos-integration.md` - Adding personality to minds
- `mmos-creator-os-integration.md` - Using minds for voice preservation
- `database-integration.md` - Writing to unified database

### Development Guides
- `creating-new-expansion-pack.md` - How to create new pack
- `adding-integration-point.md` - How to integrate with existing pack
- `contract-design-guide.md` - How to design good contracts
- `testing-integrations.md` - How to test cross-pack features

### Operations Guides
- `deploying-expansion-packs.md` - Deployment patterns
- `monitoring-integrations.md` - Health checks and monitoring
- `troubleshooting-guide.md` - Common issues and solutions

---

## Guide Template

```markdown
# [Guide Title]

**Audience:** [Developers | Users | Architects]
**Prerequisites:** [What you need to know]
**Time:** [Estimated time to complete]

---

## Overview

[What this guide covers, why it's useful]

---

## Prerequisites

**Required:**
- [Prerequisite 1]
- [Prerequisite 2]

**Optional but recommended:**
- [Recommended 1]

---

## Step-by-Step Instructions

### Step 1: [Action]

**Goal:** [What we're trying to achieve]

**Instructions:**
1. [Detailed instruction 1]
2. [Detailed instruction 2]

**Example:**
```bash
# Example command
*command-name
```

**Expected Output:**
```
[What you should see]
```

**Troubleshooting:**
- **Issue:** [Common problem]
  **Solution:** [How to fix]

---

### Step 2: [Action]

...

---

## Complete Example

[Full end-to-end example with all steps]

```javascript
// Complete working code example
```

---

## Best Practices

1. **Practice 1:** [Description]
   - Why: [Reason]
   - How: [Implementation]

2. **Practice 2:** [Description]

---

## Common Pitfalls

### Pitfall 1: [Description]

**Problem:**
[What goes wrong]

**Solution:**
[How to avoid or fix]

**Example:**
```javascript
// Wrong way
...

// Right way
...
```

---

## Advanced Topics

### Topic 1: [Advanced technique]

[When to use, how to implement]

---

## Troubleshooting

### Problem: [Common issue]

**Symptoms:**
- [Symptom 1]
- [Symptom 2]

**Diagnosis:**
- [How to confirm this is the issue]

**Solution:**
- [Step-by-step fix]

---

## Related Guides

- [Link to related guide 1]
- [Link to related guide 2]

---

## Additional Resources

- [External documentation]
- [Blog posts]
- [Video tutorials]

---

**Last Updated:** YYYY-MM-DD
**Author:** [Name]
**Feedback:** [How to provide feedback]
```

---

## How to Contribute

### Adding New Guide

1. **Identify need** - What integration pattern needs documentation?
2. **Check existing guides** - Does similar guide exist?
3. **Create guide** using template above
4. **Add examples** - Real, working code examples
5. **Test instructions** - Follow your own guide
6. **Get review** from Integration Owner
7. **Add to index** in this README

### Updating Existing Guide

1. **Note outdated info** - What needs updating?
2. **Update guide** - Make changes
3. **Test updated instructions** - Verify they work
4. **Update "Last Updated" date**
5. **Notify users** if significant changes

---

## Guide Quality Checklist

Before publishing guide:

- [ ] **Clear audience** - Who is this for?
- [ ] **Prerequisites listed** - What knowledge/tools needed?
- [ ] **Step-by-step** - Concrete, actionable steps
- [ ] **Code examples** - Working, tested code
- [ ] **Expected output** - What success looks like
- [ ] **Troubleshooting** - Common issues addressed
- [ ] **Tested** - Author followed guide start-to-finish
- [ ] **Reviewed** - At least one other person reviewed

---

**See also:**
- [Workflows](../workflows.md) - High-level workflow orchestrations
- [Contracts](../contracts/) - Integration contract specs
- [Architecture](../architecture.md) - System architecture
