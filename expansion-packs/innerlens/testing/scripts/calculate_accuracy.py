#!/usr/bin/env python3
"""
InnerLens Lite - Accuracy Validation Script

Calculates Pearson correlations between self-reported Big Five scores
and InnerLens-predicted scores.

Usage:
    python calculate_accuracy.py --input results/accuracy-validation-matrix.csv --output results/accuracy-report.md

Requirements:
    pip install pandas numpy scipy matplotlib seaborn

Author: Academia Lendar[IA]
Version: 1.0
Date: 2025-01-15
"""

import argparse
import pandas as pd
import numpy as np
from scipy.stats import pearsonr
from pathlib import Path
import sys

# Optional: For visualization
try:
    import matplotlib.pyplot as plt
    import seaborn as sns
    VISUALIZATION_AVAILABLE = True
except ImportError:
    VISUALIZATION_AVAILABLE = False
    print("⚠️  WARNING: matplotlib/seaborn not available. Visualizations will be skipped.")
    print("   Install with: pip install matplotlib seaborn")


class AccuracyValidator:
    """Validates InnerLens accuracy against self-reported scores."""

    def __init__(self, data_file):
        """
        Initialize validator with CSV data.

        Args:
            data_file (str): Path to accuracy-validation-matrix.csv
        """
        self.data_file = Path(data_file)
        self.df = None
        self.traits = ['openness', 'conscientiousness', 'extraversion', 'agreeableness', 'neuroticism']
        self.results = {}

    def load_data(self):
        """Load and validate CSV data."""
        if not self.data_file.exists():
            raise FileNotFoundError(f"Data file not found: {self.data_file}")

        print(f"📂 Loading data from: {self.data_file}")
        self.df = pd.read_csv(self.data_file)

        # Validate required columns
        required_cols = ['subject_id']
        for trait in self.traits:
            required_cols.extend([f'{trait}_self', f'{trait}_innerlens'])

        missing_cols = [col for col in required_cols if col not in self.df.columns]
        if missing_cols:
            raise ValueError(f"Missing required columns: {missing_cols}")

        print(f"✅ Loaded {len(self.df)} subjects")
        return self

    def calculate_correlations(self):
        """Calculate Pearson correlations per trait and overall."""
        print("\n📊 Calculating Pearson correlations...")

        self.results['correlations'] = {}

        for trait in self.traits:
            self_col = f'{trait}_self'
            innerlens_col = f'{trait}_innerlens'

            # Calculate Pearson r
            r, p_value = pearsonr(self.df[self_col], self.df[innerlens_col])

            # Determine significance
            significant = p_value < 0.05

            self.results['correlations'][trait] = {
                'r': r,
                'p_value': p_value,
                'significant': significant,
                'n': len(self.df)
            }

            # Status emoji
            status = "✅" if r >= 0.75 else ("⚠️" if r >= 0.70 else "❌")

            print(f"  {trait.capitalize():18s}: r={r:.3f}, p={p_value:.4f} {status}")

        # Overall correlation (mean across traits)
        overall_r = np.mean([self.results['correlations'][t]['r'] for t in self.traits])
        self.results['overall_correlation'] = overall_r

        # Overall status
        overall_status = "✅ PASS" if overall_r >= 0.75 else ("⚠️ MARGINAL" if overall_r >= 0.70 else "❌ FAIL")

        print(f"\n  {'Overall (mean)':18s}: r={overall_r:.3f} {overall_status}")

        return self

    def calculate_errors(self):
        """Calculate absolute errors and error distribution."""
        print("\n📏 Calculating error distribution...")

        errors = []

        for trait in self.traits:
            self_col = f'{trait}_self'
            innerlens_col = f'{trait}_innerlens'

            # Absolute error per subject per trait
            abs_errors = (self.df[innerlens_col] - self.df[self_col]).abs()

            for idx, error in enumerate(abs_errors):
                subject_id = self.df.iloc[idx]['subject_id']
                errors.append({
                    'subject_id': subject_id,
                    'trait': trait,
                    'self_score': self.df.iloc[idx][self_col],
                    'innerlens_score': self.df.iloc[idx][innerlens_col],
                    'absolute_error': error,
                    'error_category': self._categorize_error(error)
                })

        self.results['errors'] = pd.DataFrame(errors)

        # Error category distribution
        error_dist = self.results['errors']['error_category'].value_counts(normalize=True) * 100

        print(f"  Excellent (≤10 pts): {error_dist.get('excellent', 0):.1f}%")
        print(f"  Good (11-15 pts):    {error_dist.get('good', 0):.1f}%")
        print(f"  Acceptable (16-20):  {error_dist.get('acceptable', 0):.1f}%")
        print(f"  Poor (21-30 pts):    {error_dist.get('poor', 0):.1f}%")
        print(f"  Very Poor (>30):     {error_dist.get('very_poor', 0):.1f}%")

        # Success rate (excellent + good)
        success_rate = error_dist.get('excellent', 0) + error_dist.get('good', 0)
        success_status = "✅ PASS" if success_rate >= 80 else ("⚠️ MARGINAL" if success_rate >= 70 else "❌ FAIL")

        print(f"\n  Success rate (≤15 pts): {success_rate:.1f}% {success_status}")

        self.results['error_distribution'] = error_dist
        self.results['success_rate'] = success_rate

        return self

    def _categorize_error(self, error):
        """Categorize absolute error."""
        if error <= 10:
            return 'excellent'
        elif error <= 15:
            return 'good'
        elif error <= 20:
            return 'acceptable'
        elif error <= 30:
            return 'poor'
        else:
            return 'very_poor'

    def detect_bias(self):
        """Detect systematic over/underestimation."""
        print("\n🔍 Detecting systematic bias...")

        self.results['biases'] = {}

        for trait in self.traits:
            self_col = f'{trait}_self'
            innerlens_col = f'{trait}_innerlens'

            # Mean bias (positive = overestimation, negative = underestimation)
            bias = (self.df[innerlens_col] - self.df[self_col]).mean()

            # Acceptable bias: ≤ ±5 points
            acceptable = abs(bias) <= 5

            self.results['biases'][trait] = {
                'mean_bias': bias,
                'acceptable': acceptable
            }

            # Status
            if acceptable:
                status = "✅ No bias"
            elif bias > 0:
                status = f"⚠️ Overestimates by {bias:.1f} pts"
            else:
                status = f"⚠️ Underestimates by {abs(bias):.1f} pts"

            print(f"  {trait.capitalize():18s}: {bias:+.2f} pts → {status}")

        return self

    def generate_visualizations(self, output_dir):
        """Generate correlation plots (optional)."""
        if not VISUALIZATION_AVAILABLE:
            print("\n⚠️  Skipping visualizations (matplotlib not available)")
            return self

        print("\n📈 Generating visualizations...")

        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)

        # Set style
        sns.set_style("whitegrid")
        sns.set_palette("husl")

        # Figure 1: Scatter plots (self vs innerlens) for each trait
        fig, axes = plt.subplots(2, 3, figsize=(15, 10))
        axes = axes.flatten()

        for idx, trait in enumerate(self.traits):
            ax = axes[idx]
            self_col = f'{trait}_self'
            innerlens_col = f'{trait}_innerlens'

            # Scatter plot
            ax.scatter(self.df[self_col], self.df[innerlens_col], alpha=0.6, s=100)

            # Perfect correlation line (y=x)
            min_val = min(self.df[self_col].min(), self.df[innerlens_col].min())
            max_val = max(self.df[self_col].max(), self.df[innerlens_col].max())
            ax.plot([min_val, max_val], [min_val, max_val], 'r--', lw=2, label='Perfect correlation')

            # Regression line
            z = np.polyfit(self.df[self_col], self.df[innerlens_col], 1)
            p = np.poly1d(z)
            ax.plot(self.df[self_col], p(self.df[self_col]), "b-", alpha=0.5, label='Actual correlation')

            # Labels
            r = self.results['correlations'][trait]['r']
            p_val = self.results['correlations'][trait]['p_value']

            ax.set_xlabel('Self-Reported Score', fontsize=12)
            ax.set_ylabel('InnerLens Score', fontsize=12)
            ax.set_title(f'{trait.capitalize()}\nr = {r:.3f}, p = {p_val:.4f}', fontsize=14, fontweight='bold')
            ax.legend()
            ax.grid(True, alpha=0.3)

        # Remove empty subplot
        fig.delaxes(axes[5])

        plt.tight_layout()
        scatter_path = output_dir / 'correlation_scatterplots.png'
        plt.savefig(scatter_path, dpi=300, bbox_inches='tight')
        print(f"  ✅ Saved: {scatter_path}")
        plt.close()

        # Figure 2: Error distribution histogram
        fig, ax = plt.subplots(figsize=(10, 6))

        errors_all = self.results['errors']['absolute_error']
        ax.hist(errors_all, bins=20, edgecolor='black', alpha=0.7)

        # Vertical lines for thresholds
        ax.axvline(10, color='green', linestyle='--', linewidth=2, label='Excellent threshold (≤10)')
        ax.axvline(15, color='orange', linestyle='--', linewidth=2, label='Good threshold (≤15)')
        ax.axvline(20, color='red', linestyle='--', linewidth=2, label='Acceptable threshold (≤20)')

        ax.set_xlabel('Absolute Error (points)', fontsize=12)
        ax.set_ylabel('Frequency', fontsize=12)
        ax.set_title('Distribution of Absolute Errors', fontsize=14, fontweight='bold')
        ax.legend()
        ax.grid(True, alpha=0.3, axis='y')

        hist_path = output_dir / 'error_distribution.png'
        plt.savefig(hist_path, dpi=300, bbox_inches='tight')
        print(f"  ✅ Saved: {hist_path}")
        plt.close()

        # Figure 3: Bias visualization
        fig, ax = plt.subplots(figsize=(10, 6))

        biases = [self.results['biases'][t]['mean_bias'] for t in self.traits]
        trait_names = [t.capitalize() for t in self.traits]

        colors = ['green' if abs(b) <= 5 else 'orange' for b in biases]

        ax.barh(trait_names, biases, color=colors, alpha=0.7, edgecolor='black')
        ax.axvline(0, color='black', linestyle='-', linewidth=1)
        ax.axvline(-5, color='red', linestyle='--', linewidth=1, alpha=0.5, label='Bias threshold (±5)')
        ax.axvline(5, color='red', linestyle='--', linewidth=1, alpha=0.5)

        ax.set_xlabel('Mean Bias (InnerLens - Self)', fontsize=12)
        ax.set_title('Systematic Bias per Trait', fontsize=14, fontweight='bold')
        ax.legend()
        ax.grid(True, alpha=0.3, axis='x')

        bias_path = output_dir / 'bias_analysis.png'
        plt.savefig(bias_path, dpi=300, bbox_inches='tight')
        print(f"  ✅ Saved: {bias_path}")
        plt.close()

        return self

    def generate_report(self, output_file):
        """Generate markdown accuracy report."""
        print(f"\n📝 Generating report: {output_file}")

        output_file = Path(output_file)
        output_file.parent.mkdir(parents=True, exist_ok=True)

        with open(output_file, 'w') as f:
            f.write("# InnerLens Lite - Accuracy Validation Report\n\n")
            f.write(f"**Generated:** {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"**Sample Size:** N={len(self.df)}\n")
            f.write(f"**Version:** InnerLens Lite v1.0.0-alpha\n\n")

            f.write("---\n\n")

            # Overall Results
            f.write("## Executive Summary\n\n")
            overall_r = self.results['overall_correlation']
            overall_status = "✅ **PASS**" if overall_r >= 0.75 else ("⚠️ **MARGINAL**" if overall_r >= 0.70 else "❌ **FAIL**")

            f.write(f"**Overall Correlation:** r = {overall_r:.3f} {overall_status}\n\n")
            f.write(f"**Target:** r ≥ 0.75 (Pearson correlation with self-reports)\n\n")

            success_rate = self.results['success_rate']
            success_status = "✅ **PASS**" if success_rate >= 80 else ("⚠️ **MARGINAL**" if success_rate >= 70 else "❌ **FAIL**")

            f.write(f"**Success Rate (errors ≤15 pts):** {success_rate:.1f}% {success_status}\n\n")
            f.write(f"**Target:** ≥80% of predictions within ≤15 points\n\n")

            f.write("---\n\n")

            # Correlations Table
            f.write("## Correlation Analysis\n\n")
            f.write("| Trait | Correlation (r) | P-value | N | Status |\n")
            f.write("|-------|----------------|---------|---|--------|\n")

            for trait in self.traits:
                corr = self.results['correlations'][trait]
                r = corr['r']
                p = corr['p_value']
                n = corr['n']

                status = "✅ Pass" if r >= 0.75 else ("⚠️ Marginal" if r >= 0.70 else "❌ Fail")

                f.write(f"| {trait.capitalize()} | {r:.3f} | {p:.4f} | {n} | {status} |\n")

            # Overall row
            overall_status_text = "✅ Pass" if overall_r >= 0.75 else ("⚠️ Marginal" if overall_r >= 0.70 else "❌ Fail")
            f.write(f"| **Overall (mean)** | **{overall_r:.3f}** | - | {len(self.df)} | **{overall_status_text}** |\n\n")

            # Error Distribution
            f.write("## Error Analysis\n\n")
            f.write("### Error Distribution\n\n")

            error_dist = self.results['error_distribution']

            f.write(f"- **Excellent (≤10 pts):** {error_dist.get('excellent', 0):.1f}%\n")
            f.write(f"- **Good (11-15 pts):** {error_dist.get('good', 0):.1f}%\n")
            f.write(f"- **Acceptable (16-20 pts):** {error_dist.get('acceptable', 0):.1f}%\n")
            f.write(f"- **Poor (21-30 pts):** {error_dist.get('poor', 0):.1f}%\n")
            f.write(f"- **Very Poor (>30 pts):** {error_dist.get('very_poor', 0):.1f}%\n\n")

            # Bias Analysis
            f.write("### Systematic Bias\n\n")
            f.write("| Trait | Mean Bias | Status |\n")
            f.write("|-------|-----------|--------|\n")

            for trait in self.traits:
                bias_data = self.results['biases'][trait]
                bias = bias_data['mean_bias']
                acceptable = bias_data['acceptable']

                if acceptable:
                    status = "✅ No bias"
                elif bias > 0:
                    status = f"⚠️ Overestimates"
                else:
                    status = f"⚠️ Underestimates"

                f.write(f"| {trait.capitalize()} | {bias:+.2f} pts | {status} |\n")

            f.write("\n**Note:** Acceptable bias = ±5 points or less\n\n")

            # Interpretation
            f.write("---\n\n")
            f.write("## Interpretation\n\n")

            if overall_r >= 0.75:
                f.write("✅ **InnerLens Lite meets the accuracy target (r ≥ 0.75).** The system demonstrates strong correlation with self-reported Big Five scores, suitable for production use.\n\n")
            elif overall_r >= 0.70:
                f.write("⚠️ **InnerLens Lite shows marginal accuracy (0.70 ≤ r < 0.75).** Performance is acceptable but below target. Recommend improvements before full production release.\n\n")
            else:
                f.write("❌ **InnerLens Lite does not meet minimum accuracy standards (r < 0.70).** Significant improvements needed before production use. Consider:\n")
                f.write("- Expanding linguistic marker database\n")
                f.write("- Improving detection algorithms\n")
                f.write("- Collecting more diverse training data\n\n")

            # Next Steps
            f.write("## Recommendations\n\n")

            if overall_r >= 0.75:
                f.write("1. ✅ **Proceed to production** - Epic 0 validated successfully\n")
                f.write("2. ✅ **Continue to Epic 1** - Enhanced Analysis (HEXACO, multimodal)\n")
                f.write("3. ✅ **Monitor accuracy** - Track performance with real users\n\n")
            elif overall_r >= 0.70:
                f.write("1. ⚠️ **Launch with caution** - Add disclaimer about marginal accuracy\n")
                f.write("2. ⚠️ **Prioritize Epic 1** - Improved markers should boost accuracy to 0.75+\n")
                f.write("3. ⚠️ **Extended beta testing** - Collect more validation data (N=20-30)\n\n")
            else:
                f.write("1. ❌ **Delay production launch** - Accuracy too low for reliable use\n")
                f.write("2. ❌ **Debug detection pipeline** - Review failed predictions, identify patterns\n")
                f.write("3. ❌ **Expand markers** - Implement Story 1.2 (100+ markers per trait) immediately\n")
                f.write("4. ❌ **Re-test with N=20** - Larger sample may reveal systematic issues\n\n")

            # Appendix
            f.write("---\n\n")
            f.write("## Appendix: Raw Data\n\n")
            f.write(f"Full validation matrix: `{self.data_file.name}`\n\n")
            f.write(f"Error details: `{output_file.parent / 'error_details.csv'}`\n\n")

        # Save error details
        error_file = output_file.parent / 'error_details.csv'
        self.results['errors'].to_csv(error_file, index=False)

        print(f"  ✅ Report saved: {output_file}")
        print(f"  ✅ Error details saved: {error_file}")

        return self


def main():
    """Main execution."""
    parser = argparse.ArgumentParser(description='Calculate InnerLens Lite accuracy metrics')
    parser.add_argument('--input', required=True, help='Path to accuracy-validation-matrix.csv')
    parser.add_argument('--output', default='results/accuracy-report.md', help='Path to output report (markdown)')
    parser.add_argument('--visualize', action='store_true', help='Generate visualizations (requires matplotlib)')
    parser.add_argument('--viz-dir', default='results/visualizations', help='Directory for visualizations')

    args = parser.parse_args()

    try:
        # Initialize validator
        validator = AccuracyValidator(args.input)

        # Run validation pipeline
        validator.load_data() \
                 .calculate_correlations() \
                 .calculate_errors() \
                 .detect_bias()

        # Generate visualizations (if requested and available)
        if args.visualize:
            validator.generate_visualizations(args.viz_dir)

        # Generate report
        validator.generate_report(args.output)

        print("\n" + "="*60)
        print("✅ Accuracy validation complete!")
        print("="*60)
        print(f"\n📊 Overall correlation: r = {validator.results['overall_correlation']:.3f}")
        print(f"📊 Success rate: {validator.results['success_rate']:.1f}%")
        print(f"\n📄 Full report: {args.output}")

        # Exit code based on success
        if validator.results['overall_correlation'] >= 0.75:
            sys.exit(0)  # Success
        elif validator.results['overall_correlation'] >= 0.70:
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
