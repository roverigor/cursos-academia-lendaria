#!/usr/bin/env python3
"""
InnerLens Lite - Performance Analysis Script

Analyzes processing time and cost metrics from testing.

Usage:
    python analyze_performance.py --input results/performance-metrics.csv --output results/performance-report.md

Requirements:
    pip install pandas numpy

Author: Academia Lendar[IA]
Version: 1.0
Date: 2025-01-15
"""

import argparse
import pandas as pd
import numpy as np
from pathlib import Path
import sys

# Optional: For visualization
try:
    import matplotlib.pyplot as plt
    import seaborn as sns
    VISUALIZATION_AVAILABLE = True
except ImportError:
    VISUALIZATION_AVAILABLE = False


class PerformanceAnalyzer:
    """Analyzes InnerLens performance metrics."""

    def __init__(self, data_file):
        """
        Initialize analyzer with CSV data.

        Args:
            data_file (str): Path to performance-metrics.csv
        """
        self.data_file = Path(data_file)
        self.df = None
        self.results = {}

    def load_data(self):
        """Load and validate CSV data."""
        if not self.data_file.exists():
            raise FileNotFoundError(f"Data file not found: {self.data_file}")

        print(f"📂 Loading data from: {self.data_file}")
        self.df = pd.read_csv(self.data_file)

        # Validate required columns
        required_cols = ['subject_id', 'word_count', 'fragment_extraction_seconds',
                        'analysis_seconds', 'validation_seconds', 'total_seconds', 'cost_usd']

        missing_cols = [col for col in required_cols if col not in self.df.columns]
        if missing_cols:
            raise ValueError(f"Missing required columns: {missing_cols}")

        print(f"✅ Loaded {len(self.df)} performance records")
        return self

    def analyze_time(self):
        """Analyze processing time metrics."""
        print("\n⏱️  Analyzing processing time...")

        time_stats = {
            'mean': self.df['total_seconds'].mean(),
            'median': self.df['total_seconds'].median(),
            'std': self.df['total_seconds'].std(),
            'min': self.df['total_seconds'].min(),
            'max': self.df['total_seconds'].max(),
            'p90': self.df['total_seconds'].quantile(0.90),
            'p95': self.df['total_seconds'].quantile(0.95),
            'p99': self.df['total_seconds'].quantile(0.99)
        }

        self.results['time'] = time_stats

        # Status check
        p90 = time_stats['p90']
        if p90 <= 120:  # 2 minutes
            status = "✅ PASS"
        elif p90 <= 150:  # 2.5 minutes
            status = "⚠️ MARGINAL"
        else:
            status = "❌ FAIL"

        print(f"  Mean time:        {time_stats['mean']:.1f}s ({time_stats['mean']/60:.2f}m)")
        print(f"  Median time:      {time_stats['median']:.1f}s ({time_stats['median']/60:.2f}m)")
        print(f"  90th percentile:  {time_stats['p90']:.1f}s ({time_stats['p90']/60:.2f}m) {status}")
        print(f"  95th percentile:  {time_stats['p95']:.1f}s ({time_stats['p95']/60:.2f}m)")
        print(f"  Max time:         {time_stats['max']:.1f}s ({time_stats['max']/60:.2f}m)")

        # Phase breakdown
        phase_stats = {
            'extraction': self.df['fragment_extraction_seconds'].mean(),
            'analysis': self.df['analysis_seconds'].mean(),
            'validation': self.df['validation_seconds'].mean()
        }

        self.results['phase_breakdown'] = phase_stats

        print(f"\n  Phase breakdown (mean):")
        print(f"    Extraction:  {phase_stats['extraction']:.1f}s ({phase_stats['extraction']/time_stats['mean']*100:.1f}%)")
        print(f"    Analysis:    {phase_stats['analysis']:.1f}s ({phase_stats['analysis']/time_stats['mean']*100:.1f}%)")
        print(f"    Validation:  {phase_stats['validation']:.1f}s ({phase_stats['validation']/time_stats['mean']*100:.1f}%)")

        return self

    def analyze_cost(self):
        """Analyze cost metrics."""
        print("\n💰 Analyzing cost...")

        cost_stats = {
            'mean': self.df['cost_usd'].mean(),
            'median': self.df['cost_usd'].median(),
            'std': self.df['cost_usd'].std(),
            'min': self.df['cost_usd'].min(),
            'max': self.df['cost_usd'].max()
        }

        self.results['cost'] = cost_stats

        # Status check
        mean_cost = cost_stats['mean']
        if mean_cost <= 0.20:
            status = "✅ PASS"
        elif mean_cost <= 0.25:
            status = "⚠️ MARGINAL"
        else:
            status = "❌ FAIL"

        print(f"  Mean cost:   ${mean_cost:.3f} {status}")
        print(f"  Median cost: ${cost_stats['median']:.3f}")
        print(f"  Max cost:    ${cost_stats['max']:.3f}")

        return self

    def analyze_word_count_impact(self):
        """Analyze impact of word count on time and cost."""
        print("\n📝 Analyzing word count impact...")

        # Correlation between word count and time
        corr_time = self.df['word_count'].corr(self.df['total_seconds'])
        corr_cost = self.df['word_count'].corr(self.df['cost_usd'])

        self.results['word_count_impact'] = {
            'corr_time': corr_time,
            'corr_cost': corr_cost
        }

        print(f"  Word count vs Time correlation: r={corr_time:.3f}")
        print(f"  Word count vs Cost correlation: r={corr_cost:.3f}")

        # Recommendations
        if corr_time > 0.7:
            print(f"  ⚠️ Strong correlation - longer texts = much longer processing")
            print(f"     Recommend: Limit inputs to 2000 words max")

        return self

    def generate_visualizations(self, output_dir):
        """Generate performance visualizations."""
        if not VISUALIZATION_AVAILABLE:
            print("\n⚠️  Skipping visualizations (matplotlib not available)")
            return self

        print("\n📈 Generating visualizations...")

        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)

        sns.set_style("whitegrid")

        # Figure 1: Time distribution histogram
        fig, axes = plt.subplots(1, 2, figsize=(14, 5))

        # Histogram
        axes[0].hist(self.df['total_seconds'], bins=15, edgecolor='black', alpha=0.7)
        axes[0].axvline(120, color='green', linestyle='--', linewidth=2, label='Target (2 min)')
        axes[0].axvline(self.results['time']['p90'], color='orange', linestyle='--', linewidth=2,
                       label=f"90th percentile ({self.results['time']['p90']:.1f}s)")
        axes[0].set_xlabel('Total Processing Time (seconds)', fontsize=12)
        axes[0].set_ylabel('Frequency', fontsize=12)
        axes[0].set_title('Processing Time Distribution', fontsize=14, fontweight='bold')
        axes[0].legend()
        axes[0].grid(True, alpha=0.3, axis='y')

        # Box plot
        box_data = [
            self.df['fragment_extraction_seconds'],
            self.df['analysis_seconds'],
            self.df['validation_seconds']
        ]
        axes[1].boxplot(box_data, labels=['Extraction', 'Analysis', 'Validation'])
        axes[1].set_ylabel('Time (seconds)', fontsize=12)
        axes[1].set_title('Phase-wise Time Distribution', fontsize=14, fontweight='bold')
        axes[1].grid(True, alpha=0.3, axis='y')

        plt.tight_layout()
        time_path = output_dir / 'processing_time_analysis.png'
        plt.savefig(time_path, dpi=300, bbox_inches='tight')
        print(f"  ✅ Saved: {time_path}")
        plt.close()

        # Figure 2: Word count vs Time scatter
        fig, axes = plt.subplots(1, 2, figsize=(14, 5))

        # Time scatter
        axes[0].scatter(self.df['word_count'], self.df['total_seconds'], alpha=0.6, s=100)
        z = np.polyfit(self.df['word_count'], self.df['total_seconds'], 1)
        p = np.poly1d(z)
        axes[0].plot(self.df['word_count'], p(self.df['word_count']), "r--", lw=2, label='Trend line')
        axes[0].axhline(120, color='green', linestyle='--', linewidth=2, alpha=0.5, label='2 min target')
        axes[0].set_xlabel('Word Count', fontsize=12)
        axes[0].set_ylabel('Total Time (seconds)', fontsize=12)
        axes[0].set_title(f'Word Count vs Processing Time\nr={self.results["word_count_impact"]["corr_time"]:.3f}',
                         fontsize=14, fontweight='bold')
        axes[0].legend()
        axes[0].grid(True, alpha=0.3)

        # Cost scatter
        axes[1].scatter(self.df['word_count'], self.df['cost_usd'], alpha=0.6, s=100, color='green')
        z = np.polyfit(self.df['word_count'], self.df['cost_usd'], 1)
        p = np.poly1d(z)
        axes[1].plot(self.df['word_count'], p(self.df['word_count']), "r--", lw=2, label='Trend line')
        axes[1].axhline(0.20, color='orange', linestyle='--', linewidth=2, alpha=0.5, label='$0.20 target')
        axes[1].set_xlabel('Word Count', fontsize=12)
        axes[1].set_ylabel('Cost (USD)', fontsize=12)
        axes[1].set_title(f'Word Count vs Cost\nr={self.results["word_count_impact"]["corr_cost"]:.3f}',
                         fontsize=14, fontweight='bold')
        axes[1].legend()
        axes[1].grid(True, alpha=0.3)

        plt.tight_layout()
        wordcount_path = output_dir / 'wordcount_impact_analysis.png'
        plt.savefig(wordcount_path, dpi=300, bbox_inches='tight')
        print(f"  ✅ Saved: {wordcount_path}")
        plt.close()

        return self

    def generate_report(self, output_file):
        """Generate markdown performance report."""
        print(f"\n📝 Generating report: {output_file}")

        output_file = Path(output_file)
        output_file.parent.mkdir(parents=True, exist_ok=True)

        with open(output_file, 'w') as f:
            f.write("# InnerLens Lite - Performance Analysis Report\n\n")
            f.write(f"**Generated:** {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"**Sample Size:** N={len(self.df)}\n")
            f.write(f"**Version:** InnerLens Lite v1.0.0-alpha\n\n")

            f.write("---\n\n")

            # Overall Performance
            f.write("## Executive Summary\n\n")

            p90 = self.results['time']['p90']
            p90_status = "✅ **PASS**" if p90 <= 120 else ("⚠️ **MARGINAL**" if p90 <= 150 else "❌ **FAIL**")

            f.write(f"**90th Percentile Time:** {p90:.1f}s ({p90/60:.2f}m) {p90_status}\n\n")
            f.write(f"**Target:** ≤120s (2 minutes)\n\n")

            mean_cost = self.results['cost']['mean']
            cost_status = "✅ **PASS**" if mean_cost <= 0.20 else ("⚠️ **MARGINAL**" if mean_cost <= 0.25 else "❌ **FAIL**")

            f.write(f"**Mean Cost:** ${mean_cost:.3f} {cost_status}\n\n")
            f.write(f"**Target:** ≤$0.20 per analysis\n\n")

            f.write("---\n\n")

            # Time Analysis
            f.write("## Processing Time Analysis\n\n")
            f.write("### Overall Statistics\n\n")

            time_stats = self.results['time']

            f.write(f"- **Mean:** {time_stats['mean']:.1f}s ({time_stats['mean']/60:.2f}m)\n")
            f.write(f"- **Median:** {time_stats['median']:.1f}s ({time_stats['median']/60:.2f}m)\n")
            f.write(f"- **Std Dev:** {time_stats['std']:.1f}s\n")
            f.write(f"- **Min:** {time_stats['min']:.1f}s ({time_stats['min']/60:.2f}m)\n")
            f.write(f"- **Max:** {time_stats['max']:.1f}s ({time_stats['max']/60:.2f}m)\n")
            f.write(f"- **90th percentile:** {time_stats['p90']:.1f}s ({time_stats['p90']/60:.2f}m)\n")
            f.write(f"- **95th percentile:** {time_stats['p95']:.1f}s ({time_stats['p95']/60:.2f}m)\n")
            f.write(f"- **99th percentile:** {time_stats['p99']:.1f}s ({time_stats['p99']/60:.2f}m)\n\n")

            # Phase Breakdown
            f.write("### Phase Breakdown (Mean)\n\n")

            phase_stats = self.results['phase_breakdown']
            total = time_stats['mean']

            f.write("| Phase | Time | Percentage |\n")
            f.write("|-------|------|------------|\n")
            f.write(f"| Fragment Extraction | {phase_stats['extraction']:.1f}s | {phase_stats['extraction']/total*100:.1f}% |\n")
            f.write(f"| Personality Analysis | {phase_stats['analysis']:.1f}s | {phase_stats['analysis']/total*100:.1f}% |\n")
            f.write(f"| Quality Validation | {phase_stats['validation']:.1f}s | {phase_stats['validation']/total*100:.1f}% |\n")
            f.write(f"| **Total** | **{total:.1f}s** | **100%** |\n\n")

            # Cost Analysis
            f.write("---\n\n")
            f.write("## Cost Analysis\n\n")

            cost_stats = self.results['cost']

            f.write(f"- **Mean:** ${cost_stats['mean']:.3f}\n")
            f.write(f"- **Median:** ${cost_stats['median']:.3f}\n")
            f.write(f"- **Std Dev:** ${cost_stats['std']:.3f}\n")
            f.write(f"- **Min:** ${cost_stats['min']:.3f}\n")
            f.write(f"- **Max:** ${cost_stats['max']:.3f}\n\n")

            # Word Count Impact
            f.write("---\n\n")
            f.write("## Word Count Impact\n\n")

            wc_impact = self.results['word_count_impact']

            f.write(f"**Correlation with Processing Time:** r = {wc_impact['corr_time']:.3f}\n\n")
            f.write(f"**Correlation with Cost:** r = {wc_impact['corr_cost']:.3f}\n\n")

            if wc_impact['corr_time'] > 0.7:
                f.write("⚠️ **Strong positive correlation detected.** Longer texts significantly increase processing time.\n\n")
                f.write("**Recommendation:** Limit input to 2000 words for optimal performance.\n\n")
            elif wc_impact['corr_time'] > 0.4:
                f.write("**Moderate positive correlation.** Word count moderately impacts processing time.\n\n")
            else:
                f.write("**Weak correlation.** Word count has minimal impact on processing time.\n\n")

            # Interpretation
            f.write("---\n\n")
            f.write("## Interpretation\n\n")

            if p90 <= 120 and mean_cost <= 0.20:
                f.write("✅ **Performance meets all targets.** InnerLens Lite delivers <2 min processing at <$0.20 per analysis.\n\n")
            elif p90 <= 150 and mean_cost <= 0.25:
                f.write("⚠️ **Performance is marginal.** System is functional but slightly slower/costlier than target. Consider optimizations in Epic 1.\n\n")
            else:
                f.write("❌ **Performance does not meet targets.** Optimization required before production launch.\n\n")

            # Recommendations
            f.write("## Recommendations\n\n")

            if p90 <= 120:
                f.write("1. ✅ **Performance acceptable** - No blocking issues\n")
            else:
                f.write("1. ⚠️ **Optimize slow steps** - Analysis phase takes {:.1f}s (most expensive)\n".format(phase_stats['analysis']))
                f.write("   - Consider: Batch processing optimization, prompt caching\n")

            if mean_cost <= 0.20:
                f.write("2. ✅ **Cost acceptable** - Under target\n\n")
            else:
                f.write("2. ⚠️ **Reduce costs** - Mean cost ${:.3f} exceeds target\n".format(mean_cost))
                f.write("   - Consider: Prompt caching (90% cost reduction on system instructions)\n\n")

            if wc_impact['corr_time'] > 0.7:
                f.write("3. ⚠️ **Enforce word count limits** - Strong correlation with processing time\n")
                f.write("   - Recommend: Max 2000 words, warn users at submission\n\n")

            f.write("---\n\n")
            f.write(f"## Appendix: Raw Data\n\n")
            f.write(f"Full performance metrics: `{self.data_file.name}`\n\n")

        print(f"  ✅ Report saved: {output_file}")

        return self


def main():
    """Main execution."""
    parser = argparse.ArgumentParser(description='Analyze InnerLens Lite performance metrics')
    parser.add_argument('--input', required=True, help='Path to performance-metrics.csv')
    parser.add_argument('--output', default='results/performance-report.md', help='Path to output report (markdown)')
    parser.add_argument('--visualize', action='store_true', help='Generate visualizations (requires matplotlib)')
    parser.add_argument('--viz-dir', default='results/visualizations', help='Directory for visualizations')

    args = parser.parse_args()

    try:
        # Initialize analyzer
        analyzer = PerformanceAnalyzer(args.input)

        # Run analysis pipeline
        analyzer.load_data() \
                .analyze_time() \
                .analyze_cost() \
                .analyze_word_count_impact()

        # Generate visualizations (if requested)
        if args.visualize:
            analyzer.generate_visualizations(args.viz_dir)

        # Generate report
        analyzer.generate_report(args.output)

        print("\n" + "="*60)
        print("✅ Performance analysis complete!")
        print("="*60)
        print(f"\n⏱️  90th percentile time: {analyzer.results['time']['p90']:.1f}s")
        print(f"💰 Mean cost: ${analyzer.results['cost']['mean']:.3f}")
        print(f"\n📄 Full report: {args.output}")

        # Exit code based on performance
        p90 = analyzer.results['time']['p90']
        mean_cost = analyzer.results['cost']['mean']

        if p90 <= 120 and mean_cost <= 0.20:
            sys.exit(0)  # Success
        elif p90 <= 150 and mean_cost <= 0.25:
            sys.exit(1)  # Marginal
        else:
            sys.exit(2)  # Fail

    except Exception as e:
        print(f"\n❌ ERROR: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(3)


if __name__ == '__main__':
    main()
