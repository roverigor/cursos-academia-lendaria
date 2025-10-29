#!/usr/bin/env python3
"""
MMOS Fragment Validator
Valida schema completo e gera estatísticas
"""

import yaml
import os
from pathlib import Path
from collections import Counter

# Schema completo esperado
REQUIRED_FIELDS = ['id', 'category', 'source', 'location', 'type', 'relevance', 'content']
ENHANCEMENT_FIELDS = ['context', 'insight', 'tags']
METADATA_FIELDS = ['metadata']

def validate_fragment(filepath):
    """Valida um fragmento contra schema completo"""
    errors = []
    warnings = []
    
    with open(filepath, 'r', encoding='utf-8') as f:
        try:
            data = yaml.safe_load(f)
        except yaml.YAMLError as e:
            return [f"YAML parse error: {e}"], []
    
    # Check required fields
    for field in REQUIRED_FIELDS:
        if field not in data:
            errors.append(f"Missing required field: {field}")
    
    # Check enhancement fields
    for field in ENHANCEMENT_FIELDS:
        if field not in data:
            warnings.append(f"Missing enhancement field: {field}")
    
    # Check metadata
    if 'metadata' in data:
        meta = data['metadata']
        if 'confidence' not in meta or 'clarity' not in meta or 'depth' not in meta:
            warnings.append("Incomplete metadata (missing confidence/clarity/depth)")
    else:
        warnings.append("Missing metadata section")
    
    # Check tags count
    if 'tags' in data:
        tag_count = len(data['tags'])
        if tag_count < 5:
            warnings.append(f"Too few tags: {tag_count} (expected 5-15)")
        elif tag_count > 15:
            warnings.append(f"Too many tags: {tag_count} (expected 5-15)")
    
    # Check relevance score
    if 'relevance' in data:
        rel = data['relevance']
        if not (1 <= rel <= 10):
            errors.append(f"Relevance out of range: {rel} (expected 1-10)")
    
    return errors, warnings

def generate_stats(fragment_dir):
    """Gera estatísticas dos fragmentos"""
    fragments = list(Path(fragment_dir).glob('FRAG_*.yaml'))
    
    stats = {
        'total': len(fragments),
        'categories': Counter(),
        'types': Counter(),
        'avg_relevance': 0,
        'avg_tags': 0,
        'all_tags': Counter(),
        'errors': 0,
        'warnings': 0
    }
    
    relevances = []
    tag_counts = []
    
    print(f"\n{'='*60}")
    print(f"VALIDATION REPORT - {len(fragments)} fragments")
    print(f"{'='*60}\n")
    
    for frag_path in sorted(fragments):
        errors, warnings = validate_fragment(frag_path)
        
        if errors or warnings:
            print(f"📄 {frag_path.name}")
            if errors:
                stats['errors'] += len(errors)
                for err in errors:
                    print(f"  ❌ {err}")
            if warnings:
                stats['warnings'] += len(warnings)
                for warn in warnings:
                    print(f"  ⚠️  {warn}")
            print()
        
        # Collect stats
        with open(frag_path, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)
            
            if 'category' in data:
                stats['categories'][data['category']] += 1
            if 'type' in data:
                stats['types'][data['type']] += 1
            if 'relevance' in data:
                relevances.append(data['relevance'])
            if 'tags' in data:
                tag_counts.append(len(data['tags']))
                for tag in data['tags']:
                    stats['all_tags'][tag] += 1
    
    if relevances:
        stats['avg_relevance'] = sum(relevances) / len(relevances)
    if tag_counts:
        stats['avg_tags'] = sum(tag_counts) / len(tag_counts)
    
    return stats

def print_stats(stats):
    """Imprime estatísticas"""
    print(f"\n{'='*60}")
    print("STATISTICS")
    print(f"{'='*60}\n")
    
    print(f"Total fragments: {stats['total']}")
    print(f"Errors: {stats['errors']}")
    print(f"Warnings: {stats['warnings']}")
    print(f"Average relevance: {stats['avg_relevance']:.1f}/10")
    print(f"Average tags per fragment: {stats['avg_tags']:.1f}")
    
    print(f"\nCategories:")
    for cat, count in stats['categories'].most_common():
        print(f"  {cat}: {count}")
    
    print(f"\nTypes:")
    for typ, count in stats['types'].most_common():
        print(f"  {typ}: {count}")
    
    print(f"\nMost common tags (top 15):")
    for tag, count in stats['all_tags'].most_common(15):
        print(f"  {tag}: {count}")
    
    print(f"\n{'='*60}")
    
    if stats['errors'] == 0:
        print("✅ ALL FRAGMENTS VALID")
    else:
        print(f"❌ {stats['errors']} ERRORS FOUND")
    
    if stats['warnings'] > 0:
        print(f"⚠️  {stats['warnings']} WARNINGS")
    
    print(f"{'='*60}\n")

if __name__ == '__main__':
    fragment_dir = '/home/claude/mmos-fragments/kapil-gupta/masters-secret-whispers'
    stats = generate_stats(fragment_dir)
    print_stats(stats)
