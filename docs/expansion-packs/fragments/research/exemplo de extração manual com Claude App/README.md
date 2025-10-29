# MMOS Fragment Extraction Package

**Date:** 2025-10-26  
**Source:** A Master's Secret Whispers - Kapil Gupta  
**Total Fragments:** 40

---

## 📁 Package Contents

```
mmos-extraction-package/
├── README.md                          # This file
├── validate_fragments.py              # Python validation script
├── EXTRACTION_REPORT.md               # Full extraction report
├── ALL_FRAGMENTS_40.md                # All 40 fragments in markdown
├── masters-secret-whispers-full.txt   # Complete book text (extracted)
│
└── fragments/                         # Individual YAML files
    ├── FRAG_MSW_001.yaml
    ├── FRAG_MSW_002.yaml
    ├── ...
    └── FRAG_MSW_040.yaml
```

---

## 🚀 Quick Start

### Validate Fragments

```bash
python3 validate_fragments.py
```

### View All Fragments

```bash
cat ALL_FRAGMENTS_40.md
```

### Load Fragment in Python

```python
import yaml

with open('fragments/FRAG_MSW_001.yaml', 'r') as f:
    fragment = yaml.safe_load(f)
    
print(fragment['content'])
print(fragment['tags'])
```

---

## 📊 Statistics

```yaml
total_fragments: 40
errors: 0
warnings: 0
average_relevance: 9.3/10
average_tags: 12.2

categories:
  Philosophical: 26 (65%)
  Cognitive: 6 (15%)
  Behavioral: 5 (12.5%)
  Values: 2 (5%)
  Social: 1 (2.5%)

types:
  direct_quote: 16
  principle: 9
  observation: 6
  framework: 5
  criterion: 2
  teaching_principle: 2
```

---

## 📋 Schema (13 Fields)

### Obrigatórios (7)
- `id`: Unique identifier
- `category`: Philosophical/Cognitive/Behavioral/etc
- `source`: "A Master's Secret Whispers"
- `location`: Chapter and context
- `type`: direct_quote/framework/principle/etc
- `relevance`: 1-10 score
- `content`: The actual fragment text

### Enhancement (3)
- `context`: Situational context
- `insight`: Deep interpretation
- `tags`: 5-15 hierarchical tags

### Metadata (3)
- `metadata.confidence`: 0.0-1.0
- `metadata.clarity`: 1-5
- `metadata.depth`: 1-5

---

## 🏷️ Tag Taxonomy

Tags organized in 3 levels:
1. **Domain** (broad): philosophical, cognitive, behavioral
2. **Theme** (medium): truth, mastery, mental_model
3. **Specific** (narrow): axiom, belief_rejection, etc

Most common tags:
- philosophical (28x)
- mental_model (23x)
- cognitive (15x)
- behavioral (14x)
- values (10x)

---

## 🔧 Dependencies

```bash
# Python 3.x
pip install pyyaml
```

---

## 📖 Usage Examples

### Query by Tag

```python
import yaml
from pathlib import Path

def find_by_tag(tag):
    fragments = []
    for f in Path('fragments').glob('FRAG_*.yaml'):
        with open(f) as file:
            data = yaml.safe_load(file)
            if tag in data.get('tags', []):
                fragments.append(data)
    return fragments

# Find all axioms
axioms = find_by_tag('axiom')
for a in axioms:
    print(f"{a['id']}: {a['content'][:50]}...")
```

### Filter by Relevance

```python
def high_impact_fragments(min_relevance=9):
    fragments = []
    for f in Path('fragments').glob('FRAG_*.yaml'):
        with open(f) as file:
            data = yaml.safe_load(file)
            if data.get('relevance', 0) >= min_relevance:
                fragments.append(data)
    return fragments

high_impact = high_impact_fragments(10)
print(f"Found {len(high_impact)} fragments with relevance 10")
```

### Category Analysis

```python
from collections import Counter

categories = Counter()
for f in Path('fragments').glob('FRAG_*.yaml'):
    with open(f) as file:
        data = yaml.safe_load(file)
        categories[data['category']] += 1

for cat, count in categories.most_common():
    print(f"{cat}: {count}")
```

---

## ⏱️ Performance Metrics

```yaml
extraction_time: "~9 minutes (40 fragments)"
average_per_fragment: "13.5 seconds"

batch_breakdown:
  batch_1: "10 fragments in ~1.5 min"
  batch_2: "10 fragments in ~3.5 min"
  batch_3: "20 fragments in ~5.5 min"

projected_full_book:
  total_fragments: "400-600 estimated"
  time_required: "90-135 minutes"
```

---

## 📝 Notes

- Schema follows MMOS v6.0 specification
- All fragments validated (0 errors, 0 warnings)
- Tags hierarchical but not enforced programmatically
- Source text extracted via `pdftotext`
- Fragments cover first ~3 chapters of book

---

## 🎯 Next Steps

1. **Continue extraction**: 360-560 fragments remaining
2. **Query validation**: Test if tags enable effective retrieval
3. **Agent integration**: Connect to Barbara, Charlie, etc.
4. **Database migration**: Move to SQLite when >300 fragments

---

## 📧 Metadata

```yaml
author: Kapil Gupta
book: A Master's Secret Whispers
extractor: Claude (Anthropic)
date: 2025-10-26
schema_version: MMOS v6.0
validation: ✅ PASSED
```
