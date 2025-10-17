#!/usr/bin/env python3
"""
Calculate accuracy metrics for InnerLens Big Five validation from YAML format.

Usage:
    python validate_from_yaml.py --subjects testing/validation/subjects.yaml

Requirements:
    pip install pyyaml numpy scipy matplotlib
"""

import yaml
import numpy as np
from scipy.stats import pearsonr
import matplotlib.pyplot as plt
from pathlib import Path
from datetime import datetime
import sys

def load_subjects(filepath):
    """Load subject data from YAML file."""
    with open(filepath, 'r') as f:
        data = yaml.safe_load(f)
    return data['subjects']

def calculate_correlations(subjects):
    """Calculate Pearson r for each Big Five trait."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    results = {}

    for trait in traits:
        self_report = [s['self_report']['scores'][trait] for s in subjects]
        innerlens = [s['innerlens_results']['scores'][trait] for s in subjects]

        r, p = pearsonr(self_report, innerlens)
        mae = np.mean(np.abs(np.array(self_report) - np.array(innerlens)))

        results[trait] = {
            'correlation': r,
            'p_value': p,
            'mae': mae,
            'self_report': self_report,
            'innerlens': innerlens
        }

    return results

def calculate_confidence_calibration(subjects):
    """Calculate confidence vs error correlation."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    all_confidences = []
    all_errors = []

    for subject in subjects:
        for trait in traits:
            confidence = subject['innerlens_results']['confidence'][trait]
            error = abs(
                subject['self_report']['scores'][trait] -
                subject['innerlens_results']['scores'][trait]
            )
            all_confidences.append(confidence)
            all_errors.append(error)

    r, p = pearsonr(all_confidences, all_errors)

    return {
        'correlation': r,
        'p_value': p,
        'confidences': all_confidences,
        'errors': all_errors
    }

def plot_results(correlation_results, calibration_results, output_dir):
    """Generate visualization plots."""
    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']

    # Plot 1: Scatter plots per trait
    fig, axes = plt.subplots(2, 3, figsize=(15, 10))
    fig.suptitle('InnerLens vs Self-Report Big Five Scores', fontsize=16)

    for idx, trait in enumerate(traits):
        ax = axes[idx // 3, idx % 3]
        data = correlation_results[trait]

        ax.scatter(data['self_report'], data['innerlens'], alpha=0.7)
        ax.plot([0, 100], [0, 100], 'r--', label='Perfect correlation')
        ax.set_xlabel('Self-Report Score')
        ax.set_ylabel('InnerLens Score')
        ax.set_title(f'{trait.capitalize()}\nr={data["correlation"]:.2f}, MAE={data["mae"]:.1f}')
        ax.legend()
        ax.grid(True, alpha=0.3)

    # Remove extra subplot
    fig.delaxes(axes[1, 2])

    plt.tight_layout()
    plt.savefig(output_dir / 'trait_correlations.png', dpi=300)
    print(f"✅ Saved: {output_dir / 'trait_correlations.png'}")

    # Plot 2: Confidence calibration
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.scatter(calibration_results['confidences'], calibration_results['errors'], alpha=0.6)
    ax.set_xlabel('Confidence Score (0.0-1.0)')
    ax.set_ylabel('Absolute Error (points)')
    ax.set_title(f'Confidence Calibration\nr={calibration_results["correlation"]:.2f}')
    ax.grid(True, alpha=0.3)

    # Add trend line
    z = np.polyfit(calibration_results['confidences'], calibration_results['errors'], 1)
    p = np.poly1d(z)
    ax.plot(sorted(calibration_results['confidences']),
            p(sorted(calibration_results['confidences'])),
            "r--", alpha=0.8, label='Trend')
    ax.legend()

    plt.tight_layout()
    plt.savefig(output_dir / 'confidence_calibration.png', dpi=300)
    print(f"✅ Saved: {output_dir / 'confidence_calibration.png'}")

def generate_report(subjects, correlation_results, calibration_results, performance_stats, output_file):
    """Generate markdown validation report."""

    traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']
    mean_r = np.mean([data['correlation'] for data in correlation_results.values()])

    report = f"""# InnerLens Epic 0 Validation Report

**Test ID:** EPIC-0-VAL-001
**Date:** {datetime.now().strftime('%Y-%m-%d')}
**Sample Size:** N={len(subjects)}
**Instrument:** IPIP-NEO-120
**InnerLens Version:** v1.1.0

---

## Executive Summary

"""

    # Add correlation results
    report += "### Accuracy Results (Pearson Correlation)\n\n"
    report += "| Trait | Correlation (r) | p-value | MAE | Status |\n"
    report += "|-------|----------------|---------|-----|--------|\n"

    for trait, data in correlation_results.items():
        status = "✅ PASS" if data['correlation'] > 0.75 else "🟡 ACCEPTABLE" if data['correlation'] > 0.60 else "❌ FAIL"
        report += f"| {trait.capitalize()} | {data['correlation']:.3f} | {data['p_value']:.4f} | {data['mae']:.1f} | {status} |\n"

    # Overall row
    overall_status = "✅ PASS" if mean_r > 0.75 else "🟡 ACCEPTABLE" if mean_r > 0.60 else "❌ FAIL"
    report += f"| **Overall (mean)** | **{mean_r:.3f}** | - | - | **{overall_status}** |\n\n"

    # Add confidence calibration
    report += "### Confidence Calibration\n\n"
    report += f"**Correlation (Confidence ↔ Error):** r = {calibration_results['correlation']:.3f}\n"
    report += f"**p-value:** {calibration_results['p_value']:.4f}\n\n"

    if calibration_results['correlation'] < -0.40:
        report += "✅ **Well-calibrated:** Higher confidence predicts lower error\n\n"
    else:
        report += "⚠️ **Needs improvement:** Confidence not well-calibrated\n\n"

    # Add performance stats
    report += "### Performance Metrics\n\n"
    report += f"- **Median Processing Time:** {performance_stats['median_time']:.1f}s\n"
    report += f"- **Median Cost:** ${performance_stats['median_cost']:.3f}\n"
    report += f"- **Success Rate:** {performance_stats['success_rate']:.1%}\n\n"

    # Add conclusion
    report += "## Conclusion\n\n"

    if mean_r > 0.75:
        report += "✅ **VALIDATED:** InnerLens Big Five analysis meets target accuracy (r > 0.75)\n\n"
        report += "**Recommendation:** Proceed to Epic 1 (Enhanced Analysis)\n\n"
    elif mean_r > 0.60:
        report += "🟡 **PROVISIONAL:** InnerLens shows moderate accuracy (r > 0.60), improvements recommended\n\n"
        report += "**Recommendation:** Implement Story 1.2 (expanded markers) and re-test\n\n"
    else:
        report += "❌ **FAILED:** InnerLens does not meet minimum accuracy threshold (r < 0.60)\n\n"
        report += "**Recommendation:** Major improvements needed before production\n\n"

    # Subject details
    report += "## Test Subjects\n\n"
    report += "| ID | Age | Gender | Education | Word Count | Validation Outcome |\n"
    report += "|----|-----|--------|-----------|------------|--------------------|\n"

    for subject in subjects:
        report += f"| {subject['id']} | {subject['demographics']['age']} | {subject['demographics']['gender']} | "
        report += f"{subject['demographics']['education']} | {subject['text_sample']['word_count']} | "
        report += f"{subject['innerlens_results']['performance']['validation_outcome']} |\n"

    report += "\n"

    # Save report
    with open(output_file, 'w') as f:
        f.write(report)

    print(f"✅ Saved: {output_file}")

def main():
    import argparse

    parser = argparse.ArgumentParser(description='Calculate InnerLens accuracy from YAML subjects file')
    parser.add_argument('--subjects', required=True, help='Path to subjects.yaml')
    parser.add_argument('--output-dir', default='testing/validation/results', help='Output directory')
    args = parser.parse_args()

    # Load data
    print(f"📂 Loading subjects from {args.subjects}...")
    subjects = load_subjects(args.subjects)

    if not subjects:
        print("❌ No subjects found in YAML file. Add test subjects and try again.")
        sys.exit(1)

    print(f"✅ Loaded {len(subjects)} subjects")

    # Calculate metrics
    print("\n📊 Calculating correlations...")
    correlation_results = calculate_correlations(subjects)

    print("\n📊 Calculating confidence calibration...")
    calibration_results = calculate_confidence_calibration(subjects)

    # Calculate performance stats
    times = [s['innerlens_results']['performance']['processing_time_seconds'] for s in subjects]
    costs = [s['innerlens_results']['performance']['cost_usd'] for s in subjects]
    success_rate = len([s for s in subjects if s['innerlens_results']['performance']['validation_outcome'] in ['VALIDATED_HIGH', 'VALIDATED_MEDIUM']]) / len(subjects)

    performance_stats = {
        'median_time': np.median(times),
        'median_cost': np.median(costs),
        'success_rate': success_rate
    }

    # Create output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    # Generate plots
    print("\n📈 Generating visualizations...")
    plot_results(correlation_results, calibration_results, output_dir)

    # Generate report
    print("\n📝 Generating report...")
    generate_report(subjects, correlation_results, calibration_results, performance_stats, output_dir / 'validation_report.md')

    # Print summary
    mean_r = np.mean([data['correlation'] for data in correlation_results.values()])

    print("\n" + "="*60)
    print("✅ Validation analysis complete!")
    print("="*60)
    print(f"\n📊 Overall correlation: r = {mean_r:.3f}")
    print(f"📊 Confidence calibration: r = {calibration_results['correlation']:.3f}")
    print(f"📊 Success rate: {performance_stats['success_rate']:.1%}")
    print(f"\n📄 Full report: {output_dir / 'validation_report.md'}")
    print(f"📊 Visualizations: {output_dir}/")

    # Exit based on results
    if mean_r > 0.75:
        print("\n✅ VALIDATED - Proceed to Epic 1")
        sys.exit(0)
    elif mean_r > 0.60:
        print("\n🟡 PROVISIONAL - Improvements recommended")
        sys.exit(1)
    else:
        print("\n❌ FAILED - Major improvements needed")
        sys.exit(2)

if __name__ == '__main__':
    main()
