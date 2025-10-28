# SCAN SYSTEM - QUICK IMPLEMENTATION CHECKLIST

> ✅ Check each box as you complete the step. Follow in order!

## 📋 Pre-Flight Checks

- [ ] In project root directory (`pwd` ends with `/mente_lendaria`)
- [ ] Git is initialized (`git status` works)
- [ ] `expansion-packs/super-agentes/` exists
- [ ] `docs/design-system/` exists

## 🔧 Phase 1: Directory Structure

- [ ] Create scan-system directories:
  ```bash
  mkdir -p expansion-packs/super-agentes/scan-system/lib
  mkdir -p expansion-packs/super-agentes/scan-system/templates
  mkdir -p docs/design-system/analysis/.metadata
  ```

## 📄 Phase 2: Core Files

- [ ] Create registry.yaml:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 2.1
  ```

- [ ] Create config.yaml:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 2.2
  ```

- [ ] Create scan-core.sh:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 2.3
  chmod +x expansion-packs/super-agentes/scan-system/lib/scan-core.sh
  ```

## 📝 Phase 3: Task Files

- [ ] Create generic-scan.md:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 3.1
  ```

- [ ] Create ds-scan-artifact.md:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 3.2
  ```

## 🎨 Phase 4: Templates

- [ ] Create ds-artifact-analysis.md template:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 4.1
  ```

## 🔧 Phase 5: Agent Configuration

- [ ] Create AGENT-SCAN-CONFIG.md:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 5.2
  ```

## ✅ Phase 6: Setup Script

- [ ] Create setup-scan-system.sh:
  ```bash
  # See SCAN-IMPLEMENTATION-GUIDE.md Step 6.1
  chmod +x expansion-packs/super-agentes/setup-scan-system.sh
  ```

## 🎯 Phase 7: Verification

- [ ] Run final verification:
  ```bash
  # All 8 files should show ✅
  ls -la expansion-packs/super-agentes/scan-system/registry.yaml
  ls -la expansion-packs/super-agentes/scan-system/config.yaml
  ls -la expansion-packs/super-agentes/scan-system/lib/scan-core.sh
  ls -la expansion-packs/super-agentes/tasks/generic-scan.md
  ls -la expansion-packs/super-agentes/tasks/ds-scan-artifact.md
  ls -la expansion-packs/super-agentes/templates/ds-artifact-analysis.md
  ls -la expansion-packs/super-agentes/setup-scan-system.sh
  ls -la docs/design-system/AGENT-SCAN-CONFIG.md
  ```

## ⚡ Alternative: Quick Setup

Instead of manual steps, run the automated setup:

```bash
bash expansion-packs/super-agentes/setup-scan-system.sh
```

This will create all files automatically!

## 🧪 Testing

- [ ] Test core library loads:
  ```bash
  source expansion-packs/super-agentes/scan-system/lib/scan-core.sh
  # Should output: "Scan core library loaded successfully"
  ```

- [ ] Test environment validation:
  ```bash
  validate_scan_environment "design-system"
  # Should output: "Environment validated for design-system"
  ```

- [ ] Test ID generation:
  ```bash
  get_next_artifact_id "design-system"
  # Should output: "001"
  ```

## 📚 Documentation

- [ ] Main guide exists: `docs/design-system/SCAN-IMPLEMENTATION-GUIDE.md`
- [ ] This checklist exists: `docs/design-system/SCAN-IMPLEMENTATION-CHECKLIST.md`
- [ ] Agent config guide exists: `docs/design-system/AGENT-SCAN-CONFIG.md`

## 🎉 Done!

If all boxes are checked:
1. The scan system is fully implemented
2. Ready to use with Design System agent
3. Can be extended to other agents

### First scan test:
```bash
# 1. Have an HTML file ready
# 2. Activate Design System agent
# 3. Run: *scan path/to/file.html
# 4. Check report in: docs/design-system/analysis/
```

---

**Troubleshooting?** See SCAN-IMPLEMENTATION-GUIDE.md troubleshooting section.

*Checklist Version: 1.0.0*
*Created: 2025-10-28*