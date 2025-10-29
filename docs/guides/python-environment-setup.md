# Python Environment Setup

## Virtual Environment Configuration

This project uses Python virtual environments for dependency isolation.

### ✅ Recommended: Use `.venv`

```bash
# Create virtual environment
python3 -m venv .venv

# Activate
source .venv/bin/activate

# Install dependencies
pip install -r expansion-packs/mmos/requirements.txt
# Add other requirements as needed
```

### 🧹 Legacy Environments (Can be Removed)

The following virtual environments are legacy and can be safely deleted:

- `venv/` - Old venv format (70 packages)
- `.venv-etl/` - ETL-specific venv (66 packages) - Now deprecated with ETL consolidation

**To clean up:**
```bash
rm -rf venv/ .venv-etl/
```

All dependencies should now be managed through the single `.venv` environment (82 packages).

### 📦 Installing Expansion Pack Dependencies

Each expansion pack may have its own requirements:

```bash
# MMOS
pip install -r expansion-packs/mmos/requirements.txt

# CreatorOS
pip install -r expansion-packs/creator-os/requirements.txt

# Install all at once
find expansion-packs -name "requirements.txt" -exec pip install -r {} \;
```

### ✅ Verification

Check your environment is active:
```bash
which python
# Should show: /path/to/mente_lendaria/.venv/bin/python

pip list | wc -l
# Should show ~82 packages
```

---

**Last Updated:** 2025-10-29
**Status:** ✅ Active configuration
