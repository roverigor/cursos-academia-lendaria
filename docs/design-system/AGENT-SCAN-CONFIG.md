# Design System Agent - Scan Command Configuration

## Add to Agent Definition

Add the following to your `design-system.md` agent file:

```yaml
commands:
  scan: "Analyze artifact and save structured report - Usage: *scan {target}"
  scan-list: "List all scanned artifacts"
  scan-view: "View a specific scan report - Usage: *scan-view {id}"

dependencies:
  tasks:
    - generic-scan.md
    - ds-scan-artifact.md

  templates:
    - ds-artifact-analysis.md
```

## Command Usage

- `*scan {target}` - Analyze a new artifact
- `*scan-list` - List all scanned artifacts
- `*scan-view {id}` - View specific report

## Output Location

Reports: `docs/design-system/analysis/`
Metadata: `docs/design-system/analysis/.metadata/`
