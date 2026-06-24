"""Generate educational diagnostic plots for 02403 exam prep notes."""

import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
import matplotlib as mpl
import os

np.random.seed(42)

outdir = os.path.dirname(os.path.abspath(__file__))

# ── style ────────────────────────────────────────────────────────────────────
mpl.rcParams.update({
    "font.family": "sans-serif",
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.titlesize": 9,
    "axes.labelsize": 8,
    "xtick.labelsize": 7,
    "ytick.labelsize": 7,
    "figure.dpi": 150,
})
BLUE = "#2166ac"
RED  = "#d6604d"
GREEN = "#4dac26"

# ── 1. Histogram shapes ───────────────────────────────────────────────────────
fig, axes = plt.subplots(1, 4, figsize=(11, 2.8))
fig.suptitle("Histogram shapes", fontsize=10, fontweight="bold", y=1.02)

# Normal
x1 = stats.norm.rvs(0, 1, 600)
axes[0].hist(x1, bins=28, density=True, color=BLUE, alpha=0.65, linewidth=0)
t = np.linspace(-4, 4, 300)
axes[0].plot(t, stats.norm.pdf(t), color=RED, lw=2)
axes[0].set_title("Normal\n(bell-shaped, symmetric)")
axes[0].set_xlabel("x"); axes[0].set_ylabel("density")

# Right-skewed
x2 = stats.lognorm.rvs(0.9, size=600)
axes[1].hist(x2, bins=32, density=True, color=BLUE, alpha=0.65, linewidth=0)
axes[1].set_title("Right-skewed\n(long right tail)")
axes[1].set_xlabel("x")

# Left-skewed  (mirror lognormal)
x3 = x2.max() + 0.3 - x2
axes[2].hist(x3, bins=32, density=True, color=BLUE, alpha=0.65, linewidth=0)
axes[2].set_title("Left-skewed\n(long left tail)")
axes[2].set_xlabel("x")

# Bimodal
x4 = np.concatenate([stats.norm.rvs(-2.5, 0.7, 300), stats.norm.rvs(2.5, 0.7, 300)])
axes[3].hist(x4, bins=32, density=True, color=BLUE, alpha=0.65, linewidth=0)
axes[3].set_title("Bimodal\n(two peaks)")
axes[3].set_xlabel("x")

plt.tight_layout()
plt.savefig(os.path.join(outdir, "reading_hist.svg"), bbox_inches="tight")
plt.close()
print("reading_hist.svg saved")

# ── 2. QQ-plot types ──────────────────────────────────────────────────────────
fig, axes = plt.subplots(1, 3, figsize=(9, 3))
fig.suptitle("Normal QQ-plots — how to interpret them", fontsize=10, fontweight="bold", y=1.02)

datasets = [
    (stats.norm.rvs(0, 1, 250),     "Normal data",         "[OK] Points on line → normal",     GREEN),
    (stats.t.rvs(3, size=250),       "Heavy tails (t₃)",    "[!] Ends curve away → heavy tails", RED),
    (stats.lognorm.rvs(0.8, size=250), "Right-skewed",      "[!] Upward curve → skew",          RED),
]

for ax, (data, title, note, col) in zip(axes, datasets):
    (osm, osr), (slope, intercept, _) = stats.probplot(data, dist="norm")
    ax.scatter(osm, osr, s=9, alpha=0.55, color=BLUE, zorder=3)
    lo, hi = osm.min(), osm.max()
    ax.plot([lo, hi], [slope * lo + intercept, slope * hi + intercept], color=RED, lw=1.8, zorder=4)
    ax.set_title(title)
    ax.set_xlabel("Theoretical quantiles")
    ax.set_ylabel("Sample quantiles")
    ax.text(0.04, 0.95, note, transform=ax.transAxes, fontsize=7.5,
            verticalalignment="top", color=col)

plt.tight_layout()
plt.savefig(os.path.join(outdir, "reading_qq.svg"), bbox_inches="tight")
plt.close()
print("reading_qq.svg saved")

# ── 3. Residuals vs fitted ────────────────────────────────────────────────────
fig, axes = plt.subplots(1, 3, figsize=(9, 3))
fig.suptitle("Residuals vs. fitted values — three scenarios", fontsize=10, fontweight="bold", y=1.02)

n = 180
xf = np.linspace(2, 12, n)

scenarios = [
    (stats.norm.rvs(0, 1, n),
     "Random scatter\n[OK] Assumptions met",
     "[OK] Constant spread, no pattern", GREEN),
    (stats.norm.rvs(0, 1, n) * (xf - 1) / 4,
     "Fan / funnel shape\n[!] Non-constant variance",
     "[!] Spread grows → transform y", RED),
    (2.2 * np.sin((xf - 2) * 0.75) + stats.norm.rvs(0, 0.35, n),
     "Curved band\n[!] Non-linearity",
     "[!] U-shape → add quadratic term", RED),
]

for ax, (resid, title, note, col) in zip(axes, scenarios):
    ax.scatter(xf, resid, s=9, alpha=0.45, color=BLUE)
    ax.axhline(0, color=RED, lw=1.5)
    ax.set_title(title)
    ax.set_xlabel("Fitted values")
    ax.set_ylabel("Residuals")
    ax.text(0.04, 0.97, note, transform=ax.transAxes, fontsize=7.5,
            verticalalignment="top", color=col)

plt.tight_layout()
plt.savefig(os.path.join(outdir, "reading_resid.svg"), bbox_inches="tight")
plt.close()
print("reading_resid.svg saved")

# ── 4. Box plots: equal vs unequal variance ───────────────────────────────────
fig, axes = plt.subplots(1, 2, figsize=(7, 3))
fig.suptitle("Box plots per group — ANOVA equal-variance check", fontsize=10, fontweight="bold", y=1.02)

labels = ["G1", "G2", "G3", "G4"]
means = [10, 13, 11, 15]

groups_eq  = [stats.norm.rvs(m, 1.2, 40) for m in means]
groups_uneq = [stats.norm.rvs(m, s, 40) for m, s in zip(means, [0.6, 1.2, 2.5, 5.0])]

bp_props = dict(patch_artist=True, medianprops=dict(color="black", lw=1.5),
                boxprops=dict(facecolor=BLUE, alpha=0.55),
                whiskerprops=dict(color="#444"), capprops=dict(color="#444"))

axes[0].boxplot(groups_eq, tick_labels=labels, **bp_props)
axes[0].set_title("Equal variance\n[OK] Similar box heights (IQR)")
axes[0].set_xlabel("Group"); axes[0].set_ylabel("Value")
axes[0].text(0.04, 0.97, "[OK] Equal-var. assumption met", transform=axes[0].transAxes,
             fontsize=7.5, verticalalignment="top", color=GREEN)

axes[1].boxplot(groups_uneq, tick_labels=labels, **bp_props)
axes[1].set_title("Unequal variance\n[!] Box heights differ a lot")
axes[1].set_xlabel("Group")
axes[1].text(0.04, 0.97, "[!] Different IQRs → violated", transform=axes[1].transAxes,
             fontsize=7.5, verticalalignment="top", color=RED)

plt.tight_layout()
plt.savefig(os.path.join(outdir, "reading_box.svg"), bbox_inches="tight")
plt.close()
print("reading_box.svg saved")

# ── 5. ECDF — discrete and continuous ────────────────────────────────────────
fig, axes = plt.subplots(1, 2, figsize=(7, 3))
fig.suptitle("ECDF — how to read jump heights", fontsize=10, fontweight="bold", y=1.02)

# Discrete: non-uniform
vals = np.array([3, 4, 6, 7, 8, 9])
probs = np.array([0.20, 0.10, 0.10, 0.30, 0.20, 0.10])
ax = axes[0]
y_cum = np.concatenate([[0], np.cumsum(probs)])
for i, (v, p) in enumerate(zip(vals, probs)):
    prev = y_cum[i]
    ax.hlines(prev + p, v - 0.4, v + 0.4, color=BLUE, lw=2.5)
    ax.vlines(v, prev, prev + p, color=BLUE, lw=1, linestyles="--", alpha=0.5)
    ax.annotate(f"p={p:.2f}", (v, prev + p / 2), fontsize=6.5,
                ha="center", va="center", color="#333")
ax.set_xlim(1.5, 10.5); ax.set_ylim(-0.02, 1.05)
ax.set_title("Discrete ECDF\nJump height = probability")
ax.set_xlabel("x"); ax.set_ylabel("F(x)")
ax.text(0.04, 0.97, "Read p from jump height at each value",
        transform=ax.transAxes, fontsize=7.5, verticalalignment="top", color="#333")

# Continuous: compare normal vs exponential ecdf shape
n = 400
xn = np.sort(stats.norm.rvs(5, 1.2, n))
xe = np.sort(stats.expon.rvs(scale=1.5, size=n) + 2)
y = np.arange(1, n + 1) / n
axes[1].plot(xn, y, color=BLUE, lw=2, label="Normal (S-curve)")
axes[1].plot(xe, y, color=RED, lw=2, linestyle="--", label="Exponential (concave)")
axes[1].set_title("Continuous ECDF\nShape reveals distribution")
axes[1].set_xlabel("x"); axes[1].set_ylabel("F(x)")
axes[1].legend(fontsize=7, frameon=False)
axes[1].text(0.04, 0.55, "S-shape → normal\nconcave → exponential",
             transform=axes[1].transAxes, fontsize=7.5, color="#333")

plt.tight_layout()
plt.savefig(os.path.join(outdir, "reading_ecdf.svg"), bbox_inches="tight")
plt.close()
print("reading_ecdf.svg saved")

print("\nDone — all 5 plot files written.")
