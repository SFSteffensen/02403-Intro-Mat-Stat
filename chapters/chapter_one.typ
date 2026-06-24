#import "../util.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/glossarium:0.5.10": print-glossary
#import "../glossary.typ": glossary-entries

#set math.equation(numbering: none)

This appendix holds a collection of formulas. All relevant equations from
definitions, methods and theorems are included — along with the associated
Python commands. They appear in the same order as in the book, except for the
distributions, which are listed together. An extra column has been added to
every reference table with instructions for the *TI-30XB / TI-30XS MultiView*
calculator where the operation is possible.

Before running the Python, install the required packages with UV:
`uv add numpy pandas scipy matplotlib statsmodels`.
At the top of each script include:

```python
import numpy as np
import pandas as pd
import scipy.stats as stats
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf
import statsmodels.api as sm
import statsmodels.stats.power as smp
import statsmodels.stats.proportion as smprop
```

= Scenario → method selector

On the exam: identify the row, compute the statistic by hand, then read the
critical value / bound the $p$-value from the relevant printed table. The Python
column is for recognising "which command is correct" questions only — it is *not*
run.

#block(
  width: 100%,
)[
  #set text(size: 8.5pt)
  #table(
    columns: (1.15fr, 1.5fr, 1fr, 0.85fr),
    align: (left, left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header([*What you're given / asked*], [*Statistic (method)*], [*Reference dist. \& df*], [*Tail / table*]),
    table.cell(colspan: 4, fill: luma(245))[*Means — one or two samples*],
    [1 sample, test $mu = mu_0$ ($sigma$ unknown)],
    [$t_("obs") = (overline(x) - mu_0)/(s\/sqrt(n))$ (3.23)],
    $t(n-1)$,
    [2-sided $t$],
    [1 sample, CI for $mu$],
    [$overline(x) plus.minus t_(1-alpha/2) s\/sqrt(n)$ (3.9)],
    $t(n-1)$,
    [$t$],
    [1 sample, CI for $sigma$ or $sigma^2$],
    [$[(n-1)s^2\/chi^2_(1-alpha/2), space (n-1)s^2\/chi^2_(alpha/2)]$ (3.19)],
    $chi^2(n-1)$,
    [both tails, $chi^2$],
    [2 samples, independent, *default*],
    [Welch $t_("obs")$ (3.49), $nu$ by (3.50)],
    $t(nu)$,
    [2-sided $t$],
    [2 samples, independent, "equal variance"],
    [pooled $t_("obs")$ (3.53), $s_p^2$ (3.52)],
    $t(n_1 + n_2 - 2)$,
    [2-sided $t$],
    [2 samples, *paired* ($x_i, y_i$ linked)],
    [$t_("obs") = overline(d)/(s_d\/sqrt(n))$, $d_i = x_i - y_i$ (3.48)],
    $t(n-1)$,
    [2-sided $t$],
    table.cell(colspan: 4, fill: luma(245))[*Proportions \& categorical*],
    [1 proportion, test $p = p_0$],
    [$z_("obs") = (x - n p_0)/sqrt(n p_0(1-p_0))$ (7.11)],
    $N(0,1)$,
    [2-sided $Z$],
    [1 proportion, CI],
    [$hat(p) plus.minus z_(1-alpha/2) sqrt(hat(p)(1-hat(p))\/n)$ (7.3)],
    $N(0,1)$,
    [$Z$],
    [2 proportions, test $p_1 = p_2$],
    [$z_("obs")$ with pooled $hat(p) = (x_1+x_2)/(n_1+n_2)$ (7.18)],
    $N(0,1)$,
    [2-sided $Z$],
    [$r times c$ table, independence / homogeneity],
    [$chi^2_("obs") = sum (o-e)^2\/e$, $e_(i j) = ("row")("col")\/n$ (7.22)],
    $chi^2((r-1)(c-1))$,
    [*upper* tail, $chi^2$],
    [Goodness-of-fit ($k$ categories)],
    [$chi^2_("obs") = sum (o-e)^2\/e$, $e_i = n p_i$ (7.20)],
    $chi^2(k-1)$,
    [*upper* tail, $chi^2$],
    table.cell(colspan: 4, fill: luma(245))[*$ >= 3 $ groups / regression*],
    [$k$ group means, one factor],
    [$F = ("SS(Tr)"\/(k-1))/("SSE"\/(n-k))$ (8.6)],
    $F(k-1, n-k)$,
    [*upper* tail, $F$],
    [Treatment + block (no replication)],
    [$F_("Tr"), F_("Bl")$ (8.22), $"MSE" = "SSE"\/((k-1)(l-1))$],
    $F(dot, (k-1)(l-1))$,
    [*upper* tail, $F$],
    [Straight-line fit, 1 predictor],
    [$hat(beta)_1 = S_(x y)\/S_(x x)$; $t = hat(beta)_j\/hat(sigma)_(hat(beta)_j)$ (5.x)],
    $t(n-2)$,
    [2-sided $t$],
    [Fit with $ >= 2 $ predictors],
    [$t = hat(beta)_j\/hat(sigma)_(hat(beta)_j)$ (6.2); overall $F$],
    $t(n-p)$,
    [read table],
    table.cell(colspan: 4, fill: luma(245))[*Sample size / power*],
    [$n$ for CI of a mean (width $=$ ME)],
    [$n = (z_(1-alpha/2) sigma\/"ME")^2$ (3.63)],
    [—],
    [$Z$],
    [$n$ for a mean, power $1-beta$],
    [$n = (((z_(1-beta)+z_(1-alpha/2))sigma)/(mu_0-mu_1))^2$ (3.65)],
    [—],
    [$Z$],
    [$n$ for CI of a proportion],
    [$n = p(1-p)(z_(1-alpha/2)\/"ME")^2$; worst case $p = 1/2$ (7.13)],
    [—],
    [$Z$],
    table.cell(colspan: 4, fill: luma(245))[*A single probability $P(X = x)$ or $P(X <= x)$*],
    [Fixed $n$ trials, count of successes],
    [Binomial (2.20)],
    $B(n,p)$,
    [by hand],
    [Draws *without* replacement],
    [Hypergeometric (2.24)],
    $H(n,a,N)$,
    [by hand],
    [Count of events per interval],
    [Poisson (2.27)],
    $"Po"(lambda)$,
    [by hand],
    [Waiting time between events],
    [Exponential (2.48)],
    $"Exp"(lambda)$,
    [$F(x)=1-e^(-lambda x)$],
  )
]

== When is the approximation valid?

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto),
    align: (left, left),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header([*Procedure*], [*Rule of thumb (from the book)*]),
    [CLT — mean treated as normal],
    [$n >= 30$ (any population shape)],
    [$t$-dist $approx$ normal (replace $t$ by $z$)],
    [$n >= 30$],
    [1-sample proportion $hat(p)$ normal (Rem. 7.4)],
    [$n hat(p) > 15$ *and* $n(1 - hat(p)) > 15$ (test: $n p_0 > 15$, $n(1-p_0) > 15$)],
    [2-sample proportion normal (after 7.15)],
    [$n_i p_i >= 10$ *and* $n_i(1 - p_i) >= 10$ for $i = 1, 2$],
    [$chi^2$ frequency-table test valid (after 7.20)],
    [all expected counts $e_(i j) >= 5$],
  )
]

The CI for $mu$, $sigma^2$, and the $t$-tests assume the data themselves are
*normally distributed* (checked by a q–q plot), independent of $n$.

= Reading simulation code (recognition only)

#st(
  [*Discrete sampler.* `a` = sample space, `p` = matching probabilities (must sum
  to 1). Equal `p` $=>$ all values equally likely.],
  $ P(X = a_i) = p_i $,
  cmd("np.random.choice(a=[...], size=k, p=[...])"),
  [In an *ecdf plot* of the result, the *jump height* at each value equals that
  value's probability $p_i$; equal jumps $=>$ uniform `p`. Read the model off the
  jumps.],
  [*Continuous samplers.* Match the call to the distribution and its parameters
  ($mu, sigma$ vs. bounds $alpha, beta$ vs. rate). A bell-shaped histogram from
  `norm`, a flat one from `uniform`.],
  $ "norm: " N(mu, sigma^2), quad "uniform: " U(alpha, alpha + "scale") $,
  [#cmd("stats.norm.rvs(loc=mu, scale=sigma, size=k)") \ #cmd("stats.uniform.rvs(loc=a, scale=b-a, size=k)")],
  [`loc` = mean (norm) or lower bound (uniform); `scale` = sd (norm) or *width*
  (uniform, so upper bound $= alpha + "scale"$).],
)

*Worked error-propagation read.* Given $C = A + B^2$ with $sigma_A, sigma_B$ and
mean of $B$ equal to $mu_B$, apply rule 4.3:
$ sigma_C = sqrt((pdv(C, A))^2 sigma_A^2 + (pdv(C, B))^2 sigma_B^2)
= sqrt((1)^2 sigma_A^2 + (2 mu_B)^2 sigma_B^2). $
The partial of $B^2$ is $2B$, *evaluated at the mean* $mu_B$ — this is the step
the distractors get wrong (they drop the factor $2 mu_B$ or forget to square it).

#v(0.4em)
*Note on the TI column.* On the TI-30XB/XS MultiView, numerical data is entered
with `[data]`, and `[2nd][data] → 1-Var Stats / 2-Var Stats` produces the summary
variables. Useful keys referenced below: `[x²]` (square), `[^]` (power), `[√]`
(root), `[x⁻¹]` (reciprocal), `e^x` via `[2nd][ln]`, and the *PRB* menu for
`nCr`, `nPr`, `!`. The calculator has *no* built-in probability-distribution
functions (no `normalcdf`, `binompdf`, inverse-normal, etc.), so cdf/quantiles of
the normal, $t$, $chi^2$ and $F$ distributions must be read from printed tables.
A handy trick used below: 1-Var Stats accepts a *frequency list* (decimal weights
allowed), so entering outcomes in `L1` and their probabilities in `L2` returns the
weighted mean $overline(x)$ and the weighted population sd $sigma x$ directly.
Each list holds at most 42 entries, so a raw sample larger than 42 must be entered
as values with a frequency list (or summarised to its statistics first).

= Introduction, descriptive statistics, commands and data visualization

#st(
  [*1.4 Sample mean.* The mean of a sample.],
  $ overline(x) = 1/n sum_(i=1)^n x_i $,
  cmd("np.mean(x)"),
  [`1-Var Stats` → $overline(x)$.],
  [*1.5 Sample median.* The value dividing a sample into two halves with an equal
    number of observations in each.],
  $ Q_2 = cases(x_((n+1)/2) & "for odd " n, (x_(n/2) + x_(n/2 + 1))/2 & "for even " n) $,
  cmd("np.median(x)"),
  [`1-Var Stats` → `Med`.],
  [*1.7 Sample quantile.* The value such that a proportion $p$ of the observations
    are less than it. The $0.5$ quantile is the median.],
  $ q_p = cases((x_(n p) + x_(n p + 1))/2 & "for " p n " integer", x_(ceil(n p)) & "for " p n " non-integer") $,
  [#cmd("np.quantile(x, p, method='averaged_inverted_cdf')") \ or \ #cmd("np.percentile(x, p, method='averaged_inverted_cdf')")],
  [Only $Q_1, "Med", Q_3$ available (`1-Var Stats`); arbitrary $p$ not supported.
  TI's $Q_1, Q_3$ use the median-of-halves rule and can differ from Def. 1.7;
  `Med` agrees.],
  [*1.8 Sample quartiles.* The five quantiles dividing the sample into four parts
    with an equal number of observations in each.],
  $ Q_0 &= q_0 = "minimum" \
  Q_1 &= q_(0.25) = "lower quartile" \
  Q_2 &= q_(0.5) = "median" \
  Q_3 &= q_(0.75) = "upper quartile" \
  Q_4 &= q_1 = "maximum" $,
  [#cmd("np.quantile(x, p, method='averaged_inverted_cdf')") \ where \ #cmd("p = np.array([0,0.25,0.5,0.75,1])")],
  [`1-Var Stats` → `minX, Q1, Med, Q3, maxX` (TI's $Q_1, Q_3$ may differ from the
  Def. 1.7 quartiles; `minX`, `Med`, `maxX` agree).],
  [*1.10 Sample variance.* Sum of squared deviations from the mean divided by
    $n-1$.],
  $ s^2 = 1/(n-1) sum_(i=1)^n (x_i - overline(x))^2 $,
  cmd("np.var(x, ddof=1)"),
  [`1-Var Stats` → $S x$; then $s^2 = (S x)^2$ via `[x²]`.],
  [*1.11 Sample standard deviation.* Square root of the sample variance.],
  $ s = sqrt(s^2) = sqrt(1/(n-1) sum_(i=1)^n (x_i - overline(x))^2) $,
  cmd("np.std(x, ddof=1)"),
  [`1-Var Stats` → $S x$ (this is $s$ directly).],
  [*1.12 Sample coefficient of variation.* Standard deviation relative to the
    mean.],
  $ "CV" = s/overline(x) $,
  cmd("np.std(x, ddof=1)/np.mean(x)"),
  [`1-Var Stats`, then key $frac(S x, overline(x))$.],
  [*1.15 Sample inter-quartile range.* The middle 50% range of the data.],
  $ "IQR" = Q_3 - Q_1 $,
  cmd("stats.iqr(x)"),
  [`1-Var Stats`, then key $Q_3 - Q_1$ — uses TI's $Q_1, Q_3$, which may differ
  slightly from a by-hand Def. 1.7 IQR.],
  [*1.18 Sample covariance.* Measure of the linear relation between two samples.],
  $ s_(x y) = 1/(n-1) sum_(i=1)^n (x_i - overline(x))(y_i - overline(y)) $,
  cmd("np.cov(x, y, ddof=1)[0,1]"),
  [Enter pairs, `2-Var Stats`, then key $s_(x y) = r times S x times S y$, or
  $s_(x y) = frac(Sigma x y - n overline(x) thin overline(y), n-1)$.],
  [*1.19 Sample correlation.* Linear strength of relation between two samples,
    between $-1$ and $1$.],
  $ r = 1/(n-1) sum_(i=1)^n ((x_i - overline(x))/s_x)((y_i - overline(y))/s_y)
  = s_(x y)/(s_x dot s_y) $,
  cmd("np.corrcoef(x, y)[0,1]"),
  [`2-Var Stats` → $r$.],
)

= Probability and Simulation

#st(
  [*2.6 Probability density function (pdf), discrete.* Satisfies $f(x) >= 0$ and
    $sum_("all " x) f(x) = 1$; gives the probability of a single value.],
  $ f(x) = P(X = x) $,
  [#cmd("stats.binom.pmf()") \ #cmd("stats.hypergeom.pmf()") \ #cmd("stats.poisson.pmf()")],
  [No built-in pmf. Evaluate the closed form by hand via `nCr`, `!`, $e^x$ (see
  distributions below).],
  [*2.9 Cumulated distribution function (cdf).* Gives probability over a range,
    $P(a < X <= b) = F(b) - F(a)$.],
  $ F(x) = P(X <= x) $,
  [#cmd("stats.norm.cdf()") \ #cmd("stats.binom.cdf()") \ #cmd("stats.hypergeom.cdf()") \ #cmd("stats.poisson.cdf()")],
  [Discrete: sum the pmf values by hand. Continuous: read a printed table.],
  [*2.13 Mean of a discrete random variable.*],
  $ mu = "E"(X) = sum_(i=1)^infinity x_i f(x_i) $,
  [—],
  [Enter $x_i$ in `L1`, $f(x_i)$ in `L2`; run `1-Var Stats` with `FRQ = L2`
  (decimal weights allowed) → $overline(x) = mu$.],
  [*2.16 Variance of a discrete random variable $X$.*],
  $ sigma^2 = "Var"(X) = "E"[(X - mu)^2] $,
  [—],
  [Same setup as 2.13; read the population sd $sigma x$, then $sigma^2 = (sigma x)^2$
  via `[x²]` (use $sigma x$, not $S x$).],
  [*2.32 pdf of a continuous random variable.* Non-negative, total area $1$.],
  $ P(a < X <= b) = integral_a^b f(x) dif x $,
  [—],
  [TI cannot integrate; obtain the area from a printed table for the relevant
    distribution.],
  [*2.33 cdf of a continuous random variable.* Non-decreasing with
    $lim_(x -> -infinity) F(x) = 0$ and $lim_(x -> infinity) F(x) = 1$.],
  $ F(x) = P(X <= x) = integral_(-infinity)^x f(u) dif u $,
  [—],
  [TI cannot integrate; read $F(x)$ from a printed table.],
  [*2.34 Mean and variance of a continuous random variable $X$.*],
  $ mu      &= "E"(X) = integral_(-infinity)^infinity x f(x) dif x \
  sigma^2 &= "E"[(X - mu)^2] = integral_(-infinity)^infinity (x - mu)^2 f(x) dif x $,
  [—],
  [Requires integration — not computable on the TI; evaluate the integrals by hand.],
  [*2.54 Mean and variance of a linear function* of a random variable $X$.],
  $ "E"(a X + b) &= a "E"(X) + b \
  "V"(a X + b) &= a^2 "V"(X) $,
  [—],
  [Plain arithmetic: key $a times "E"(X) + b$ and $a^2 times "V"(X)$ (`[x²]` for
  $a^2$).],
  [*2.56 Mean and variance of a linear combination* of random variables.],
  $ "E"(a_1 X_1 + dots.c + a_n X_n) &= a_1 "E"(X_1) + dots.c + a_n "E"(X_n) \
  "V"(a_1 X_1 + dots.c + a_n X_n) &= a_1^2 "V"(X_1) + dots.c + a_n^2 "V"(X_n) $,
  [—],
  [Sum the products $a_i "E"(X_i)$, and $a_i^2 "V"(X_i)$, term by term on the
    home screen.],
  [*2.58 Covariance* between two random variables $X$ and $Y$.],
  $ "Cov"(X, Y) = "E"[(X - "E"[X])(Y - "E"[Y])] $,
  [—],
)

== Distributions

The included distributions are listed together, with important theorems and
definitions tied to a specific distribution.

=== Binomial distribution (discrete)

$ X tilde B(n, p) $
$ f(x) = P(X = x) = binom(n, x) p^x (1-p)^(n-x), quad
binom(a, b) = (a!)/(b!(a-b)!) $
$ "E"[X] = mu = n p, quad "Var"(X) = sigma^2 = n p (1-p) $

#book2py(
  [$n$],
  [`n` (total number of draws)],
  [$p$],
  [`p` (probability of success in each event)],
  [$x$],
  [`k` (observed number of successes, out of $n$)],
)

Functions in `scipy.stats.binom`: `rvs(n, p, size=...)`, `pmf(k, n, p)`,
`cdf(k, n, p)`, `ppf(q, n, p)`, `mean(n, p)`, `var(n, p)`, `std(n, p)`.

*TI-30XB/XS:* $f(x) = "nCr"(n, x) times p^x times (1-p)^(n-x)$ by hand (`nCr` from
the PRB menu, `[^]` for the powers); cdf by summing terms; `ppf` not available.

=== Hypergeometric distribution (discrete)

$ X tilde H(n, a, N) $
$ f(x) = P(X = x) = (binom(a, x) binom(N-a, n-x))/(binom(N, n)) $
$ "E"[X] = mu = n dot a/N, quad
"Var"(X) = sigma^2 = n dot a/N dot (N-a)/N dot (N-n)/(N-1) $

#book2py(
  [$N$],
  [`M` (total number of objects)],
  [$a$],
  [`n` (total number of success objects)],
  [$n$],
  [`N` (total number of draws)],
  [$x$],
  [`k` (observed number of successes)],
)

Functions in `scipy.stats.hypergeom`: `rvs(M, n, N, size=...)`, `pmf(k, M, n, N)`,
`cdf(k, M, n, N)`, `ppf(q, M, n, N)`, `mean(M, n, N)`, `var(M, n, N)`,
`std(M, n, N)`.

*TI-30XB/XS:* evaluate $f(x)$ directly with three `nCr` calls (PRB menu) by hand.

=== Poisson distribution (discrete)

$ X tilde "Po"(lambda) $
$ f(x) = P(X = x) = lambda^x/(x!) e^(-lambda) $
$ "E"[X] = mu = lambda, quad "Var"(X) = sigma^2 = lambda $

#book2py([$lambda$], [`mu` (average rate)], [$x$], [`k` (observed number of events)])

Functions in `scipy.stats.poisson`: `rvs(mu, size=...)`, `pmf(k, mu)`,
`cdf(k, mu)`, `ppf(q, mu)`, `mean(mu)`, `var(mu)`, `std(mu)`.

*TI-30XB/XS:* $f(x) = frac(lambda^x, x!) times e^(-lambda)$ by hand (`!` from the PRB
menu, $e^x$ via `[2nd][ln]`).

=== Uniform distribution (continuous)

$ X tilde U(alpha, beta) $
$ f(x) = cases(1/(beta - alpha) & alpha <= x <= beta, 0 & "otherwise") $
$ "E"[X] = mu = (alpha + beta)/2, quad
"Var"(X) = sigma^2 = (beta - alpha)^2/12 $

#book2py([$alpha$], [`loc` (lower bound)], [$beta$], [`loc + scale` (upper bound)], [$x$], [`x` (observed value)])

Functions in `scipy.stats.uniform`: `rvs(loc, scale, size=...)`,
`pdf(x, loc, scale)`, `cdf(x, loc, scale)`, `ppf(q, loc, scale)`,
`mean(loc, scale)`, `var(loc, scale)`, `std(loc, scale)`.

*TI-30XB/XS:* $f$ and $F(x) = frac(x-alpha, beta-alpha)$ are simple arithmetic.

=== Normal distribution (continuous)

$ X tilde N(mu, sigma^2) $
$ f(x) = 1/sqrt(2 pi sigma^2) exp(- (x - mu)^2/(2 sigma^2)) $
$ "E"[X] = mu, quad "Var"(X) = sigma^2 $

#book2py([$mu$], [`loc` (mean)], [$sigma$], [`scale` (standard deviation)], [$x$], [`x` (observed value)])

Functions in `scipy.stats.norm`: `rvs(loc, scale, size=...)`,
`pdf(x, loc, scale)`, `cdf(x, loc, scale)`, `ppf(q, loc, scale)`,
`mean(loc, scale)`, `var(loc, scale)`, `std(loc, scale)`.

*TI-30XB/XS:* pdf computable by hand ($e^x$ via `[2nd][ln]`); cdf/inverse not
available — standardize with $Z = frac(x-mu, sigma)$ and read a $Z$-table.

=== Lognormal distribution (continuous)

$ X tilde "LN"(alpha, beta) $
$ f(x) = cases(1/(x sqrt(2 pi beta^2)) exp(- (ln(x) - alpha)^2/(2 beta^2)) & x > 0, 0 & x <= 0) $
$ "E"[X] = e^(alpha + beta^2/2), quad
"Var"(X) = (e^(beta^2) - 1) e^(2 alpha + beta^2) $

#book2py(
  [$alpha$ (mean of $ln(X)$)],
  [— (used via `scale`)],
  [$beta$ (std of $ln(X)$)],
  [`s`],
  [— (axis shift)],
  [`loc`],
  [$exp(alpha)$],
  [`scale`],
  [$x$],
  [`x` (observed value)],
)

Use `loc = 0`, `scale = exp(`$alpha$`)`, `s = `$beta$.
Functions in `scipy.stats.lognorm`: `rvs(s, loc, scale, size=...)`,
`pdf(x, s, loc, scale)`, `cdf(x, s, loc, scale)`, `ppf(q, s, loc, scale)`,
`mean(s, loc, scale)`, `var(s, loc, scale)`, `std(s, loc, scale)`.

*TI-30XB/XS:* pdf by hand (`ln`, `[2nd][ln]`); cdf not available.

=== Exponential distribution (continuous)

$ X tilde "Exp"(lambda) $
$ f(x) = cases(lambda e^(-lambda x) & x >= 0, 0 & x < 0) $
$ "E"[X] = mu = 1/lambda, quad "Var"(X) = sigma^2 = 1/lambda^2 $

#book2py(
  [$lambda$],
  [`1/scale` (rate)],
  [— (axis shift)],
  [`loc`],
  [$mu = 1\/lambda$],
  [`scale` (average waiting time)],
  [$x$],
  [`x` (waiting time between events)],
)

Use `loc = 0` and `scale = 1/`$lambda$ or `scale = `$mu$.
Functions in `scipy.stats.expon`: `rvs(scale, size=...)`, `pdf(x, scale)`,
`cdf(x, scale)`, `ppf(q, scale)`, `mean(scale)`, `var(scale)`, `std(scale)`.

*TI-30XB/XS:* $F(x) = 1 - e^(-lambda x)$ and $f(x)$ computable by hand
($e^x$ via `[2nd][ln]`).

=== Chi-square distribution (continuous)

$ X tilde chi^2(nu) $
$ f(x) = 1/(2^(nu\/2) Gamma(nu\/2)) x^(nu/2 - 1) e^(-x/2), quad x >= 0 $

#book2py([$nu$], [`df` (degrees of freedom)], [$x$], [`x` (observed value)])

Functions in `scipy.stats.chi2`: `rvs(df, size=...)`, `pdf(x, df)`, `cdf(x, df)`,
`ppf(q, df)`, `mean(df)`, `var(df)`, `std(df)`.

*TI-30XB/XS:* not available — use a $chi^2$-table.

=== $t$-distribution (continuous)

$ X tilde t(nu) $
$ f(x) = (Gamma((nu+1)/2))/(sqrt(nu pi) Gamma(nu/2))
(1 + x^2/nu)^(-(nu+1)/2) $

#book2py([$nu$], [`df` (degrees of freedom)], [$x$], [`x` (observed value)])

Functions in `scipy.stats.t`: `rvs(df, size=...)`, `pdf(x, df)`, `cdf(x, df)`,
`ppf(q, df)`, `mean(df)`, `var(df)`, `std(df)`.

*TI-30XB/XS:* not available — use a $t$-table.

=== $F$-distribution (continuous)

$ X tilde F(nu_1, nu_2) quad ("see book def. 2.95") $

#book2py([$nu_1$], [`dfn` (numerator df)], [$nu_2$], [`dfd` (denominator df)], [$x$], [`x` (observed value)])

Functions in `scipy.stats.f`:

- `rvs(dfn, dfd, size=...)`
- `pdf(x, dfn, dfd)`
- `cdf(x, dfn, dfd)`
- `ppf(q, dfn, dfd)`
- `mean(dfn, dfd)`
- `var(dfn, dfd)`
- `std(dfn, dfd)`

*TI-30XB/XS:* not available — use an $F$-table.

=== Distribution reference table

#st(
  [*2.20 Binomial distribution.* $n$ independent draws, success probability $p$;
    pmf of $x$ successes.],
  $ f(x; n, p) = P(X = x) = binom(n, x) p^x (1-p)^(n-x) \
  "where " binom(n, x) = (n!)/(x!(n-x)!) $,
  [#cmd("stats.binom.pmf(x,n,p)") \ #cmd("stats.binom.cdf(q,n,p)") \ #cmd("stats.binom.ppf(q,n,p)") \ #cmd("stats.binom.rvs(n,p,size)")],
  [$"nCr"(n,x) times p^x times (1-p)^(n-x)$ by hand (PRB menu, `[^]`); cdf by
  summation; `ppf` via table.],
  [*2.21 Mean and variance* of a binomial random variable.],
  $ mu = n p, quad sigma^2 = n p (1-p) $,
  [—],
  [Key $n times p$, and $n times p times (1-p)$.],
  [*2.24 Hypergeometric distribution.* $n$ draws without replacement, $a$
    successes, population $N$.],
  $ f(x; n, a, N) = P(X = x) = (binom(a, x) binom(N-a, n-x))/(binom(N, n)) \
  "where " binom(a, b) = (a!)/(b!(a-b)!) $,
  [#cmd("stats.hypergeom.pmf(x,N,a,n)") \ #cmd("stats.hypergeom.cdf(x,N,a,n)") \ #cmd("stats.hypergeom.ppf(p,N,a,n)") \ #cmd("stats.hypergeom.rvs(N,a,n,size)")],
  [Three `nCr` calls (PRB menu) by hand: $frac("nCr"(a,x) times "nCr"(N-a,n-x), "nCr"(N,n))$.],
  [*2.25 Mean and variance* of a hypergeometric random variable.],
  $ mu = n a/N, quad sigma^2 = n (a(N-a))/N^2 dot (N-n)/(N-1) $,
  [—],
  [Key $n times frac(a, N)$; variance by the formula (`[x²]` for $N^2$).],
  [*2.27 Poisson distribution.* $lambda$ = average number of events per interval;
    pmf of $x$ events.],
  $ f(x; lambda) = lambda^x/(x!) e^(-lambda) $,
  [#cmd("stats.poisson.pmf(x,l)") \ #cmd("stats.poisson.cdf(q,l)") \ #cmd("stats.poisson.ppf(p,l)") \ #cmd("stats.poisson.rvs(l,size)") \ where `l`$=lambda$],
  [$frac(lambda^x, x!) times e^(-lambda)$ by hand (`!`, `[2nd][ln]`).],
  [*2.28 Mean and variance* of a Poisson random variable.],
  $ mu = lambda, quad sigma^2 = lambda $,
  [—],
  [Both equal $lambda$ — nothing to compute.],
  [*2.35 Uniform distribution.* $alpha, beta$ define the range; equal density on
    the interval.],
  $ f(x; alpha, beta) = cases(0 & x < alpha, 1/(beta - alpha) & x in [alpha, beta], 0 & x > beta) \
  F(x; alpha, beta) = cases(0 & x < alpha, (x - alpha)/(beta - alpha) & x in [alpha, beta], 1 & x > beta) $,
  [#cmd("stats.uniform.pdf(x,min,dif)") \ #cmd("stats.uniform.cdf(q,min,dif)") \ #cmd("stats.uniform.ppf(p,min,dif)") \ #cmd("stats.uniform.rvs(min,dif,size)") \ where `min`$=alpha$, `dif`$=beta-alpha$],
  [Key $F(x) = frac(x-alpha, beta-alpha)$; $f = frac(1, beta-alpha)$.],
  [*2.36 Mean and variance* of a uniform random variable $X$.],
  $ mu = 1/2 (alpha + beta), quad sigma^2 = 1/12 (beta - alpha)^2 $,
  [—],
  [Key $frac(alpha+beta, 2)$, and $frac((beta-alpha)^2, 12)$ (`[x²]`).],
  [*2.37 Normal (Gaussian) distribution.*],
  $ f(x; mu, sigma) = 1/(sigma sqrt(2 pi)) e^(- (x - mu)^2/(2 sigma^2)) $,
  [#cmd("stats.norm.pdf(x,mu,sd)") \ #cmd("stats.norm.cdf(q,mu,sd)") \ #cmd("stats.norm.ppf(p,mu,sd)") \ #cmd("stats.norm.rvs(mu,sd,size)") \ where `mu`$=mu$, `sd`$=sigma$],
  [pdf by hand (`[2nd][ln]`); cdf/inverse via $Z$-table after standardizing.],
  [*2.38 Mean and variance* of a normal random variable.],
  $ mu, quad sigma^2 $,
  [—],
  [These are the parameters themselves; $sigma^2 = sigma^2$ via `[x²]`.],
  [*2.43 Standardization* of a normal variable $X$ into the standard normal.],
  $ Z = (X - mu)/sigma $,
  [—],
  [Key $frac(x - mu, sigma)$.],
  [*2.46 Lognormal distribution.* $alpha$ = mean and $beta^2$ = variance of
    $ln(X)$.],
  $ f(x) = 1/(x sqrt(2 pi) beta) e^(- (ln x - alpha)^2/(2 beta^2)) $,
  [#cmd("stats.lognorm.pdf(x,sdlog,scale=mu)") \ #cmd("stats.lognorm.cdf(x,sdlog,scale=mu)") \ #cmd("stats.lognorm.ppf(p,sdlog,scale=mu)") \ #cmd("stats.lognorm.rvs(sdlog,scale=mu,size=size)") \ where `mu`$=e^alpha$, `sdlog`$=beta$],
  [pdf by hand (`ln`, `[2nd][ln]`); cdf via table.],
  [*2.47 Mean and variance* of a lognormal random variable.],
  $ mu = e^(alpha + beta^2/2), quad sigma^2 = e^(2 alpha + beta^2)(e^(beta^2) - 1) $,
  [—],
  [Key $e^(alpha + frac(beta^2, 2))$ (`[2nd][ln]`, `[x²]`); variance likewise from its
  formula.],
  [*2.48 Exponential distribution.* $lambda$ = mean rate of events.],
  $ f(x; lambda) = cases(lambda e^(-lambda x) & x >= 0, 0 & x < 0) $,
  [#cmd("stats.expon.pdf(x,scale=1/lambda)") \ #cmd("stats.expon.cdf(q,scale=1/lambda)") \ #cmd("stats.expon.ppf(p,scale=1/lambda)") \ #cmd("stats.expon.rvs(scale=1/lambda,size=size)")],
  [Key $F(x) = 1 - e^(-lambda x)$ (`[2nd][ln]`); $f = lambda times e^(-lambda x)$.],
  [*2.49 Mean and variance* of an exponential random variable.],
  $ mu = 1/lambda, quad sigma^2 = 1/lambda^2 $,
  [—],
  [Key $lambda$ `[x⁻¹]` for $mu$; then `[x²]` (or $lambda$ `[x²]` `[x⁻¹]`) for
  $sigma^2$.],
  [*2.78 $chi^2$-distribution.* $Gamma(nu/2)$ is the $Gamma$-function, $nu$ the
    degrees of freedom.],
  $ f(x) = 1/(2^(nu/2) Gamma(nu/2)) x^(nu/2 - 1) e^(-x/2), quad x >= 0 $,
  [#cmd("stats.chi2.pdf(x, df=df)") \ #cmd("stats.chi2.cdf(q, df=df)") \ #cmd("stats.chi2.ppf(p, df=df)") \ #cmd("stats.chi2.rvs(df=df, size=size)")],
  [Not available — use a $chi^2$-table.],
  [*2.81* Sample variance $S^2$ from $n$ normal observations, transformed to a
    $chi^2$ variable with $nu = n-1$.],
  $ chi^2 = ((n-1) S^2)/sigma^2 $,
  [—],
  [Key $frac((n-1) S^2, sigma^2)$.],
  [*2.83 Mean and variance* of a $chi^2$ random variable.],
  $ "E"(X) = nu, quad "V"(X) = 2 nu $,
  [—],
  [$"E" = nu$; key $"V" = 2 times nu$.],
  [*2.86 $t$-distribution.* $nu$ degrees of freedom, $Gamma()$ the Gamma
    function.],
  $ f_T(t) = (Gamma((nu+1)/2))/(sqrt(nu pi) Gamma(nu/2))
  (1 + t^2/nu)^(-(nu+1)/2) $,
  [#cmd("stats.t.pdf(x,df)") \ #cmd("stats.t.cdf(q,df)") \ #cmd("stats.t.ppf(p,df)") \ #cmd("stats.t.rvs(df,size=size)")],
  [Not available — use a $t$-table.],
  [*2.87 Relation* between standard normal and $chi^2$ variables: $Z tilde N(0,1)$,
    $Y tilde chi^2(nu)$.],
  $ X = Z/sqrt(Y\/nu) tilde t(nu) $,
  [—],
  [Distributional relation — nothing to compute.],
  [*2.89* For normal $X_1, dots, X_n$ with sample mean $overline(X)$, mean $mu$,
    size $n$ and sample sd $S$.],
  $ T = (overline(X) - mu)/(S\/sqrt(n)) tilde t(n-1) $,
  [—],
  [Distributional relation; the value $t = frac(overline(x)-mu, S\/sqrt(n))$
  is plain arithmetic ($overline(x), S$ from `1-Var Stats`).],
  [*2.93 Mean and variance* of a $t$-distributed variable $X$.],
  $ mu = 0 quad (nu > 1), quad sigma^2 = nu/(nu-2) quad (nu > 2) $,
  [—],
  [$mu = 0$; key $sigma^2 = frac(nu, nu-2)$.],
  [*2.95 $F$-distribution.* $nu_1, nu_2$ degrees of freedom, $B(dot, dot)$ the
    Beta function.],
  $ f_F(x) = 1/(B(nu_1/2, nu_2/2)) (nu_1/nu_2)^(nu_1/2) x^(nu_1/2 - 1)
  (1 + nu_1/nu_2 x)^(-(nu_1 + nu_2)/2) $,
  [#cmd("stats.f.pdf(x,df1,df2)") \ #cmd("stats.f.cdf(q,df1,df2)") \ #cmd("stats.f.ppf(p,df1,df2)") \ #cmd("stats.f.rvs(df1,df2,size=size)")],
  [Not available — use an $F$-table.],
  [*2.96* The $F$-distribution as the ratio of two independent $chi^2$ variables,
    $U tilde chi^2(nu_1)$, $V tilde chi^2(nu_2)$.],
  $ (U\/nu_1)/(V\/nu_2) tilde F(nu_1, nu_2) $,
  [—],
  [Distributional relation — nothing to compute.],
  [*2.98* Independent normal samples with variances $sigma_1^2, sigma_2^2$.],
  $ (S_1^2\/sigma_1^2)/(S_2^2\/sigma_2^2) tilde F(n_1 - 1, n_2 - 1) $,
  [—],
  [Distributional relation; the ratio itself is plain arithmetic.],
  [*2.101 Mean and variance* of an $F$-distributed variable $X$.],
  $ mu      &= nu_2/(nu_2 - 2) quad (nu_2 > 2) \
  sigma^2 &= (2 nu_2^2 (nu_1 + nu_2 - 2))/(nu_1 (nu_2 - 2)^2 (nu_2 - 4))
  quad (nu_2 > 4) $,
  [—],
  [Key $mu = frac(nu_2, nu_2 - 2)$; variance from its formula (`[x²]` for
  $nu_2^2$, $(nu_2-2)^2$).],
)

= Statistics for one and two samples

#st(
  [*3.3* Distribution of the mean of normal random variables.],
  $ overline(X) = 1/n sum_(i=1)^n X_i tilde N(mu, sigma^2/n) $,
  [—],
  [Distributional result — nothing to compute (the mean is `1-Var Stats` → $overline(x)$).],
  [*3.5* Distribution of the $sigma$-standardized mean.],
  $ Z = (overline(X) - mu)/(sigma\/sqrt(n)) tilde N(0, 1^2) $,
  [—],
  [Key $z = frac(overline(x) - mu, sigma\/sqrt(n))$ ($overline(x)$ from
  `1-Var Stats`).],
  [*3.6* Distribution of the $S$-standardized mean.],
  $ T = (overline(X) - mu)/(S\/sqrt(n)) tilde t(n-1) $,
  [—],
  [Key $t = frac(overline(x) - mu, S x\/sqrt(n))$ ($overline(x), S x$ from
  `1-Var Stats`).],
  [*3.7 Standard error of the mean.*],
  $ "SE"_(overline(x)) = s/sqrt(n) $,
  [—],
  [`1-Var Stats`, then key $frac(S x, sqrt(n))$.],
  [*3.9 One-sample confidence interval for $mu$.*],
  $ overline(x) plus.minus t_(1-alpha/2) dot s/sqrt(n) $,
  [$t_(1-alpha/2)$ via \ #cmd("stats.t.ppf(1-alpha/2, df)")],
  [`1-Var Stats` → $overline(x), S x, n$; read $t_(1-alpha/2)$ from a $t$-table;
  key $overline(x) plus.minus t_(1-alpha/2) times frac(S x, sqrt(n))$.],
  [*3.14 Central Limit Theorem (CLT).*],
  $ Z = (overline(X) - mu)/(sigma\/sqrt(n)) $,
  [—],
  [Key $z = frac(overline(x) - mu, sigma\/sqrt(n))$.],
  [*3.19 Confidence interval for the variance and standard deviation.*],
  $ sigma^2: & [((n-1)s^2)/(chi^2_(1-alpha/2)), ((n-1)s^2)/(chi^2_(alpha/2))] \
  sigma:   & [sqrt(((n-1)s^2)/(chi^2_(1-alpha/2))), sqrt(((n-1)s^2)/(chi^2_(alpha/2)))] $,
  [$chi^2_(1-alpha/2)$, $chi^2_(alpha/2)$ via \ #cmd("stats.chi2.ppf(1-alpha/2, df)") \ #cmd("stats.chi2.ppf(alpha/2, df)")],
  [Read the two $chi^2$-quantiles from a table; key the endpoints (`[√]` for the
  $sigma$ interval).],
  [*3.22 The $p$-value.* Probability of a test statistic at least as extreme as
    the observed, assuming $H_0$ true.],
  $ "pval" = 2 (1 - P(T <= t_("obs"))) $,
  [#cmd("pval = 2*(1-stats.t.cdf(tobs,df))")],
  [Not available — bound the $p$-value from a $t$-table.],
  [*3.23 One-sample $t$-test statistic and $p$-value.* $H_0: mu = mu_0$.],
  $ t_("obs") = (overline(x) - mu_0)/(s\/sqrt(n)), quad
  p"-value" = 2 dot P(T > |t_("obs")|) $,
  [—],
  [`1-Var Stats` → $overline(x), S x$; key $t_("obs") = frac(overline(x) - mu_0, S x\/sqrt(n))$; $p$-value from a $t$-table.],
  [*3.24 The hypothesis test.*],
  $ "Reject: " p"-value" < alpha; quad "Accept: otherwise" $,
  [—],
  [Decision rule — compare values, nothing to compute.],
  [*3.29 Significant effect.* An effect is significant if],
  $ p"-value" < alpha $,
  [—],
  [Decision rule — nothing to compute.],
  [*3.31 Critical values.* The $alpha/2$- and $1-alpha/2$-quantiles of the
    $t(n-1)$ distribution.],
  $ t_(alpha/2) quad "and" quad t_(1-alpha/2) $,
  [#cmd("stats.t.ppf(alpha/2, df)")],
  [Read from a $t$-table (the table gives $t_(1-alpha/2)$; $t_(alpha/2) = -t_(1-alpha/2)$).],
  [*3.32 One-sample test by critical value.*],
  $ "Reject: " |t_("obs")| > t_(1-alpha/2); quad "accept: otherwise" $,
  [—],
  [Decision rule — nothing to compute.],
  [*3.33 Confidence interval for $mu$* (acceptance region, $H_0: mu = mu_0$).],
  $ overline(x) plus.minus t_(1-alpha/2) dot s/sqrt(n) $,
  [—],
  [Same procedure as 3.9.],
  [*3.36 Level $alpha$ one-sample $t$-test.* $H_0: mu = mu_0$ vs.
    $H_1: mu eq.not mu_0$.],
  $ p"-value" = 2 dot P(T > |t_("obs")|) \
  "Reject: " p"-value" < alpha "  or  " |t_("obs")| > t_(1-alpha/2) $,
  [—],
  [$t_("obs")$ as in 3.23; compare $|t_("obs")|$ with $t_(1-alpha/2)$ from a table.],
  [*3.42 Normal q–q plot* with $n > 10$. Plotting positions.],
  $ "naive: " p_i  &= i/n, quad i = 1, dots, n \
  "common: " p_i &= (i - 0.5)/n, quad i = 1, dots, n $,
  [`stats.probplot` (see 5.7)],
  [Not practical (no plotting); the positions $p_i$ are simple arithmetic.],
  [*3.47 Two-sample confidence interval for $mu_1 - mu_2$.*],
  $ overline(x) - overline(y) plus.minus t_(1-alpha/2) dot
  sqrt(s_1^2/n_1 + s_2^2/n_2) \
  nu = (s_1^2/n_1 + s_2^2/n_2)^2 /
  ((s_1^2\/n_1)^2/(n_1 - 1) + (s_2^2\/n_2)^2/(n_2 - 1)) $,
  [—],
  [`1-Var Stats` per group → $overline(x)_i, S_i, n_i$; key $nu$ and the interval
  by hand (`[√]`); $t$ from a table.],
  [*3.48 Paired two-sample $t$-test.* Use when observations come in natural pairs
    $(x_i, y_i)$; reduces to a one-sample $t$-test on the differences. The classic
    alternative to the independent two-sample test.],
  $ d_i = x_i - y_i, quad
  t_("obs") = overline(d)/(s_d\/sqrt(n)), quad "df" = n - 1 $,
  [#cmd("diffs = x - y\ntobs, pval = stats.ttest_1samp(diffs, 0)")],
  [Enter the differences $d_i$ in `L1`; `1-Var Stats` → $overline(d), S_d$; key
  $t_("obs") = frac(overline(d), S_d\/sqrt(n))$; $p$ from a $t$-table.],
  [*3.49 (Welch) two-sample $t$-test statistic.* $delta = mu_1 - mu_2$,
    $H_0: delta = delta_0$.],
  $ t_("obs") = ((overline(x)_1 - overline(x)_2) - delta_0)/
  sqrt(s_1^2/n_1 + s_2^2/n_2) $,
  [—],
  [`1-Var Stats` per group → $overline(x)_i, S_i$; key the statistic by hand
  (`[x²]`, `[√]`).],
  [*3.50 Distribution and df of the Welch statistic.*],
  $ T = ((overline(X)_1 - overline(X)_2) - delta_0)/
  sqrt(S_1^2/n_1 + S_2^2/n_2) \
  nu = (s_1^2/n_1 + s_2^2/n_2)^2 /
  ((s_1^2\/n_1)^2/(n_1 - 1) + (s_2^2\/n_2)^2/(n_2 - 1)) $,
  [—],
  [Key $nu$ from the two $S_i, n_i$ by hand (round down to use a $t$-table).],
  [*3.51 Level $alpha$ two-sample $t$-test.* $H_0: mu_1 - mu_2 = delta_0$ vs.
    $H_1: mu_1 - mu_2 eq.not delta_0$.],
  $ p"-value" = 2 dot P(T > |t_("obs")|) \
  "Reject: " p"-value" < alpha "  or  " |t_("obs")| > t_(1-alpha/2) $,
  [—],
  [$t_("obs")$ as in 3.49/3.53; compare with $t_(1-alpha/2)$ from a table.],
  [*3.52 Pooled two-sample variance estimate.*],
  $ s_p^2 = ((n_1 - 1)s_1^2 + (n_2 - 1)s_2^2)/(n_1 + n_2 - 2) $,
  [—],
  [Key from $n_1, n_2, S_1, S_2$ (`[x²]` for the $s_i^2$).],
  [*3.53 Pooled two-sample $t$-test statistic.* $delta = mu_1 - mu_2$,
    $H_0: delta = delta_0$.],
  $ t_("obs") = ((overline(x)_1 - overline(x)_2) - delta_0)/
  sqrt(s_p^2/n_1 + s_p^2/n_2) $,
  [—],
  [Compute $s_p^2$ (3.52), then key $t_("obs")$ by the formula (`[√]`).],
  [*3.54 Distribution of the pooled two-sample statistic.*],
  $ T = ((overline(X)_1 - overline(X)_2) - delta_0)/
  sqrt(S_p^2/n_1 + S_p^2/n_2) $,
  [—],
  [Distributional result; compute $t_("obs")$ as in 3.53. df $= n_1 + n_2 - 2$.],
  [*3.63 One-sample CI sample-size formula.*],
  $ n = ((z_(1-alpha/2) dot sigma)/"ME")^2 $,
  [—],
  [Read $z_(1-alpha/2)$ from a $Z$-table; key $(frac(z_(1-alpha/2) thin sigma, "ME"))^2$
  (`[x²]`).],
  [*3.65 One-sample sample-size formula* (power $1-beta$).],
  $ n = (((z_(1-beta) + z_(1-alpha/2)) sigma)/(mu_0 - mu_1))^2 $,
  [—],
  [Read $z_(1-beta), z_(1-alpha/2)$ from a $Z$-table; key the expression (`[x²]`).],
)

== Margin of error — quick reference

The *margin of error* (ME) is the half-width of a confidence interval:
$["estimate" - "ME", "estimate" + "ME"]$.

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1fr, auto),
    align: (left, left, left),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header([*Estimating*], [*Margin of error*], [*Reference*]),
    [Mean $mu$ ($sigma$ unknown)],
    $"ME" = t_(1-alpha\/2)(n-1) dot s\/sqrt(n)$,
    [(3.9)],
    [Mean $mu$ ($sigma$ known / large $n$)],
    $"ME" = z_(1-alpha\/2) dot sigma\/sqrt(n)$,
    [(3.63)],
    [Proportion $p$],
    $"ME" = z_(1-alpha\/2) dot sqrt(hat(p)(1-hat(p))\/n)$,
    [(7.3)],
  )
]

*Inverting for sample size.* Rearranging gives
$n = (z_(1-alpha/2) sigma \/ "ME")^2$ (3.63); for a proportion
$n = hat(p)(1-hat(p))(z_(1-alpha/2)\/"ME")^2$ (7.13);
worst-case (unknown $hat(p)$): $n = frac(1, 4)(z_(1-alpha/2)\/"ME")^2$.

= Simulation based statistics

#st(
  [*4.3 Non-linear approximative error-propagation rule.*],
  $ sigma^2_(f(X_1, dots, X_n)) = sum_(i=1)^n (pdv(f, x_i))^2 sigma_i^2 $,
  [—],
  [Once the partials $pdv(f, x_i)$ are evaluated by hand, sum the
  products $(pdv(f, x_i))^2 sigma_i^2$ on the home screen (`[x²]`).],
  [*4.4 Non-linear error propagation by simulation.*],
  [1. Simulate $k$ outcomes.\
      2. Compute the standard deviation:
      $ s_(f(X_1, dots, X_n))^("sim") =
      sqrt(1/(k-1) sum_(j=1)^k (f_j - overline(f))^2) $],
  [—],
  [Not feasible — requires simulation. (If $f_j$ are already in hand, `1-Var Stats`
  → $S x$ gives the sd.)],
  [*4.7 Confidence interval for a feature $theta$ by parametric bootstrap.*],
  [1. Simulate $k$ samples.\
      2. Compute the statistic $hat(theta)$.\
      3. CI: $[q^*_(100(alpha/2)%), q^*_(100(1-alpha/2)%)]$],
  [—],
  [Not feasible — requires simulation.],
  [*4.10 Two-sample CI for a feature comparison $theta_1 - theta_2$ by parametric
    bootstrap.*],
  [1. Simulate $k$ sets of 2 samples.\
      2. Compute $hat(theta)^*_(x k) - hat(theta)^*_(y k)$.\
      3. CI: $[q^*_(100(alpha/2)%), q^*_(100(1-alpha/2)%)]$],
  [—],
  [Not feasible — requires simulation.],
)

= Simple linear regression

#st(
  [*5.4 Least-squares estimators.*],
  $ hat(beta)_1      &= (sum_(i=1)^n (Y_i - overline(Y))(x_i - overline(x)))/S_(x x) \
  hat(beta)_0      &= overline(Y) - hat(beta)_1 overline(x) \
  "where " S_(x x) &= sum_(i=1)^n (x_i - overline(x))^2 $,
  [#cmd(
    "D = pd.DataFrame({'x': x, 'y': y})\nlinfit = smf.ols(formula='y ~ x', data=D).fit()\nprint(linfit.summary(slim=True))",
  ) \ Row `Intercept` $-> beta_0$, row `x` $-> beta_1$.],
  [Enter pairs, `2-Var Stats` → $a = hat(beta)_1$ (slope), $b = hat(beta)_0$
  (intercept). Note: TI's model is $y' = a x' + b$, so $a, b$ are swapped vs. the
  book's $beta_0, beta_1$.],
  [*5.8 Variance of the estimators.*],
  $ "V"[hat(beta)_0]                &= sigma^2 (1/n + overline(x)^2/S_(x x)) \
  "V"[hat(beta)_1]                &= sigma^2/S_(x x) \
  "Cov"[hat(beta)_0, hat(beta)_1] &= - (overline(x) sigma^2)/S_(x x) $,
  [—],
  [Get $S_(x x) = (n-1)(S x)^2$ from `2-Var Stats`; with $hat(sigma)^2$ key the
  three formulas by hand.],
  [*5.12 Test statistics* for $H_0: beta_0 = 0$ and $H_0: beta_1 = 0$.],
  $ T_(beta_0) = (hat(beta)_0 - beta_(0,0))/hat(sigma)_(beta_0), quad
  T_(beta_1) = (hat(beta)_1 - beta_(0,1))/hat(sigma)_(beta_1) $,
  [from `linfit.summary()`],
  [Not available (needs the standard errors $hat(sigma)_(beta_i)$).],
  [*5.14 Level $alpha$ $t$-tests for a parameter.* $H_(0,i): beta_i = beta_(0,i)$
    vs. $H_(1,i): beta_i eq.not beta_(0,i)$.],
  $ p"-value" = 2 dot P(T > |t_("obs", beta_i)|), quad
  t_("obs", beta_i) = (hat(beta)_i - beta_(0,i))/hat(sigma)_(beta_i) $,
  [from `linfit.summary()`],
  [Not available (needs $hat(sigma)_(beta_i)$ and the $t$-cdf).],
  [*5.15 Parameter confidence intervals.*],
  $ hat(beta)_0 plus.minus t_(1-alpha/2) hat(sigma)_(beta_0), quad
  hat(beta)_1 plus.minus t_(1-alpha/2) hat(sigma)_(beta_1) $,
  [#cmd("linfit.conf_int(0.05)")],
  [Not available (needs $hat(sigma)_(beta_i)$).],
  [*5.18 Confidence and prediction interval.*],
  $ "line: "      & hat(beta)_0 + hat(beta)_1 x_("new") plus.minus
  t_(1-alpha/2) hat(sigma) sqrt(1/n + (x_("new") - overline(x))^2/S_(x x)) \
  "new point: " & hat(beta)_0 + hat(beta)_1 x_("new") plus.minus
  t_(1-alpha/2) hat(sigma) sqrt(1 + 1/n + (x_("new") - overline(x))^2/S_(x x)) $,
  [#cmd(
      "Dn = pd.DataFrame({'x': xn})\ntab = linfit.get_prediction(Dn).summary_frame(alpha=0.05)\nci = tab[['mean_ci_lower','mean_ci_upper']]\npi = tab[['obs_ci_lower','obs_ci_upper']]",
    )],
  [Not available (needs $hat(sigma)$); the centre $b + a x_("new")$ is on the
  calculator (`2-Var Stats` → `y'`, input $x_("new")$).],
  [*5.23 Matrix formulation* of the estimators.],
  $ hat(bold(beta)) = (bold(X)^T bold(X))^(-1) bold(X)^T bold(Y), quad
  "V"[hat(bold(beta))] = sigma^2 (bold(X)^T bold(X))^(-1), quad
  hat(sigma)^2 = "RSS"/(n - 2) $,
  [—],
  [Not available (no matrix mode).],
  [*5.25 Coefficient of determination $R^2$.*],
  $ r^2 = 1 - (sum_i (y_i - hat(y)_i)^2)/(sum_i (y_i - overline(y))^2) $,
  [from `linfit.summary()`],
  [`2-Var Stats` → $r$, then $r^2 = ($`r`$)^2$ via `[x²]`.],
  [*5.7 Model validation of assumptions.* Check normality with a q–q plot of the
    residuals; check systematic behaviour by plotting residuals $e_i$ vs. fitted
    values $hat(y)_i$.],
  [—],
  [#cmd(
      "res = linfit.resid\nyfit = linfit.fittedvalues\nfig, ax = plt.subplots(2)\nstats.probplot(res, dist='norm', plot=ax[0])\nax[1].scatter(yfit, res)\nax[1].axhline(y=0)\nplt.tight_layout()\nplt.show()",
    ) \ (remember to set titles)],
  [Not available (no residual plots).],
)

= Multiple linear regression

#st(
  [*6.2 Level $alpha$ $t$-tests for a parameter.* $H_(0,i): beta_i = beta_(0,i)$
    vs. $H_(1,i): beta_i eq.not beta_(0,i)$.],
  $ p"-value" = 2 dot P(T > |t_("obs", beta_i)|), quad
  t_("obs", beta_i) = (hat(beta)_i - beta_(0,i))/hat(sigma)_(beta_i) $,
  [#cmd(
      "D = pd.DataFrame({'x1': x1, 'x2': x2, 'y': y})\nlinfit = smf.ols(formula='y ~ x1+x2', data=D).fit()\nprint(linfit.summary(slim=True))",
    )],
  [Not available (multiple predictors; only single-predictor fits via `2-Var Stats`).],
  [*6.5 Parameter confidence intervals.*],
  $ hat(beta)_i plus.minus t_(1-alpha/2) hat(sigma)_(beta_i) $,
  [#cmd("linfit.conf_int(0.05)")],
  [Not available.],
  [*6.9 Confidence and prediction interval.*],
  $ "line: "      & hat(beta)_0 + hat(beta)_1 x_(1,"new") + dots.c
  + hat(beta)_p x_(p,"new") \
  "new point: " & hat(beta)_0 + hat(beta)_1 x_(1,"new") + dots.c
  + hat(beta)_p x_(p,"new") + epsilon_("new") $,
  [#cmd(
      "Dn = pd.DataFrame({'x1': x1n, 'x2': x2n})\ntab = linfit.get_prediction(Dn).summary_frame(alpha=0.05)\nci = tab[['mean_ci_lower','mean_ci_upper']]\npi = tab[['obs_ci_lower','obs_ci_upper']]",
    )],
  [Not available.],
  [*6.17 Matrix formulation* of the estimators.],
  $ hat(bold(beta)) = (bold(X)^T bold(X))^(-1) bold(X)^T bold(Y), quad
  "V"[hat(bold(beta))] = sigma^2 (bold(X)^T bold(X))^(-1), quad
  hat(sigma)^2 = "RSS"/(n - (p + 1)) $,
  [—],
  [Not available (no matrix mode).],
  [*6.16 Model-selection procedure.* Backward selection: start with the full model
    and stepwise remove insignificant terms.],
  [—],
  [Procedure — nothing to compute.],
)

== Reading a `statsmodels` OLS summary table

#block(width: 100%)[
#set text(size: 9pt)
#table(
  columns: (auto, auto, auto),
  align: (left, left, left),
  inset: 6pt,
  stroke: 0.5pt + luma(60%),
  fill: (_, y) => if y == 0 { luma(235) },
  table.header([*Printed entry*], [*Symbol*], [*Formula / meaning*]),
  [`coef` (row $x_j$)],
  $hat(beta)_j$,
  [LS estimate of slope $beta_j$; intercept row $-> hat(beta)_0$],
  [`std err`],
  $hat(sigma)_(hat(beta)_j)$,
  [$hat(sigma) sqrt([(bold(X)^T bold(X))^(-1)]_(j j))$],
  [`t`],
  $t_("obs")$,
  [$hat(beta)_j \/ hat(sigma)_(hat(beta)_j)$ (tests $H_0: beta_j = 0$)],
  [`P>|t|`],
  $p$,
  [two-sided $p$-value, $2 P(T > |t_("obs")|)$, df $= n-p$],
  [`[0.025 0.975]`],
  [95% CI],
  [$hat(beta)_j plus.minus t_(0.975)(n-p) dot hat(sigma)_(hat(beta)_j)$],
  [`R-squared`],
  $r^2$,
  [$1 - "SSE"\/"SST"$],
  [`F-statistic`],
  $F_("obs")$,
  [overall test $H_0:$ all slopes $=0$; in SLR, $F = t_(beta_1)^2$],
  [`Prob (F-statistic)`],
  $p$,
  [$p$-value of the overall $F$-test],
  [`No. Observations`],
  $n$,
  [],
  [`Df Residuals`],
  $n - p$,
  [denominator df for $t$ and $F$],
  [`Df Model`],
  $p - 1$,
  [number of slopes (excl. intercept)],
)
]

To recover the slope by hand: $hat(beta)_1 = S_(x y) / S_(x x)$, and
$hat(beta)_0 = overline(y) - hat(beta)_1 overline(x)$.

= Inference for proportions

== Proportion estimator — mean and variance

For $X tilde B(n, p)$ with $hat(p) = X\/n$:

$ E[hat(p)] = p, quad
V[hat(p)] = frac(p(1-p), n), quad
"se"(hat(p)) = sqrt(frac(hat(p)(1-hat(p)), n)) $

Under $H_0: p = p_0$ use $p_0$ in the SE (not $hat(p)$):

$ "se"_0(hat(p)) = sqrt(frac(p_0(1-p_0), n)) $

The difference $hat(p)_1 - hat(p)_2$ for two independent samples:

$ E[hat(p)_1 - hat(p)_2] = p_1 - p_2, quad
V[hat(p)_1 - hat(p)_2] = frac(p_1(1-p_1), n_1) + frac(p_2(1-p_2), n_2) $

Under $H_0: p_1 = p_2 = p$ the variance becomes $p(1-p)(1\/n_1 + 1\/n_2)$, estimated
with the pooled $hat(p) = (x_1+x_2)\/(n_1+n_2)$ — this is what formula 7.18 uses.

== Formulas

#st(
  [*7.3 Proportion estimate and confidence interval.*],
  $ hat(p) = x/n, quad
  hat(p) plus.minus z_(1-alpha/2) sqrt((hat(p)(1 - hat(p)))/n) \
  "se" = sqrt((hat(p)(1 - hat(p)))/n) $,
  [—],
  [Key $hat(p) = frac(x, n)$; then the interval (`[√]`); $z_(1-alpha/2)$ from a
  $Z$-table.],
  [*7.10 Approximate proportion with $Z$.*],
  $ Z = (X - n p_0)/sqrt(n p_0 (1 - p_0)) tilde N(0, 1) $,
  [—],
  [Key $z = frac(x - n p_0, sqrt(n p_0 (1 - p_0)))$ (`[√]`).],
  [*7.11 Level $alpha$ one-sample proportion test.* $H_0: p = p_0$ vs.
    $H_1: p eq.not p_0$.],
  $ p"-value" = 2 dot P(Z > |z_("obs")|), quad Z tilde N(0, 1^2) $,
  [#cmd("zobs, pval = smprop.proportions_ztest(x, n, value=0.5, prop_var=0.5)")],
  [Key $z_("obs") = frac(hat(p) - p_0, sqrt(p_0(1-p_0)\/n))$ —
    use $p_0$ (not $hat(p)$) in the denominator; $p$-value from $Z$-table
    or bound via $z_(0.975) = 1.96$ (reject if $|z_("obs")| > 1.96$ at $alpha=0.05$).],
  [*7.13 Sample-size formula for the CI of a proportion.*],
  $ "guessed " p: & quad n = p(1 - p)(z_(1-alpha/2)/"ME")^2 \
  "unknown " p: & quad n = 1/4 (z_(1-alpha/2)/"ME")^2 $,
  [—],
  [Key the formula (`[x²]` for the squared ratio); $z_(1-alpha/2)$ from a $Z$-table.],
  [*7.15 Difference of two proportions* $hat(p)_1 - hat(p)_2$ and CI.],
  $ hat(sigma)_(hat(p)_1 - hat(p)_2) =
  sqrt((hat(p)_1(1 - hat(p)_1))/n_1 + (hat(p)_2(1 - hat(p)_2))/n_2) \
  (hat(p)_1 - hat(p)_2) plus.minus z_(1-alpha/2) dot
  hat(sigma)_(hat(p)_1 - hat(p)_2) $,
  [—],
  [Key $hat(p)_i = frac(x_i, n_i)$, then $hat(sigma)$ and the interval (`[√]`);
  $z_(1-alpha/2)$ from a $Z$-table.],
  [*7.18 Level $alpha$ two-sample proportion test.* $H_0: p_1 = p_2$ vs.
    $H_1: p_1 eq.not p_2$. Use pooled $hat(p)$ in the SE — not each group's own
    $hat(p)_i$.],
  $ hat(p) = (x_1 + x_2)/(n_1 + n_2), quad
  z_("obs") = (hat(p)_1 - hat(p)_2)/sqrt(hat(p)(1-hat(p))(1/n_1 + 1/n_2)) \
  p"-value" = 2 dot P(Z > |z_("obs")|) $,
  [—],
  [$hat(p)_i = x_i\/n_i$; pool: $hat(p) = (x_1+x_2)\/(n_1+n_2)$; key $z_("obs")$
  (`[√]`); compare $|z_("obs")|$ with $z_(1-alpha/2)$ from a $Z$-table.],
  [*7.19 Expected cell count* for $chi^2$-tests. Contingency table ($r times c$): expected count for cell $(i,j)$. Goodness-of-fit ($k$ categories): expected count for category $i$.],
  $ e_(i j) = (("row" i " total") times ("col" j " total"))/n, quad
  e_i = n p_i $,
  [Returned as `expected` from \ #cmd("stats.chi2_contingency(X, correction=False)")],
  [Key $e_(i j) = frac("row total" times "col total", n)$ per cell.],
  [*7.20 Multi-sample proportions $chi^2$-test.* $H_0: p_1 = p_2 = dots = p_c = p$.],
  $ chi^2_("obs") = sum_(i=1)^2 sum_(j=1)^c ((o_(i j) - e_(i j))^2)/(e_(i j)) $,
  [#cmd("chi2, p, dof, expected = stats.chi2_contingency(X, correction=False)")],
  [Key the sum $sum frac((o_(i j) - e_(i j))^2, e_(i j))$ by hand (`[x²]`); $chi^2$
  decision from a table.],
  [*7.22 The $r times c$ frequency-table $chi^2$-test.*
    $H_0: p_(i 1) = p_(i 2) = dots = p_(i c) = p_i$ for all rows $i$.],
  $ chi^2_("obs") = sum_(i=1)^r sum_(j=1)^c ((o_(i j) - e_(i j))^2)/(e_(i j)) \
  "Reject if " chi^2_("obs") > chi^2_(1-alpha)((r-1)(c-1)) $,
  [#cmd("stats.chi2_contingency(X, correction=False)")],
  [As 7.20: sum by hand; compare with the $chi^2$-quantile from a table.],
)

= Comparing means of multiple groups — ANOVA

#st(
  [*8.2 One-way ANOVA variation decomposition* ($"SST" = "SSE" + "SS(Tr)"$).],
  $ underbrace(sum_(i=1)^k sum_(j=1)^(n_i) (y_(i j) - overline(y))^2, "SST")
  = underbrace(sum_(i=1)^k sum_(j=1)^(n_i) (y_(i j) - overline(y)_i)^2, "SSE")
  + underbrace(sum_(i=1)^k n_i (overline(y)_i - overline(y))^2, "SS(Tr)") $,
  [—],
  [`1-Var Stats` per group gives $overline(y)_i, S_i$; then $"SSE" = sum (n_i-1)S_i^2$
  and $"SS(Tr)"$ by hand.],
  [*8.4 One-way within-group variability.*],
  $ "MSE" = "SSE"/(n-k) =
  ((n_1 - 1)s_1^2 + dots.c + (n_k - 1)s_k^2)/(n - k) \
  s_i^2 = 1/(n_i - 1) sum_(j=1)^(n_i) (y_(i j) - overline(y)_i)^2 $,
  [—],
  [$S_i$ per group via `1-Var Stats`; key $"MSE" = frac(sum (n_i-1)S_i^2, n-k)$
  (`[x²]`).],
  [*8.6 One-way test for difference in mean* for $k$ groups.
    $H_0: alpha_i = 0, space i = 1, dots, k$. $F$ has $k-1$ and $n-k$ df.],
  $ F = (("SS(Tr)")/(k-1))/(("SSE")/(n-k)) $,
  [#cmd(
      "D = pd.DataFrame({'y': y, 'group': group})\nmodel = smf.ols('y ~ C(group)', data=D).fit()\nanova_results = sm.stats.anova_lm(model, typ=2)",
    )],
  [Key $F$ from SS(Tr), SSE; compare with the $F$-quantile from a table.],
  [*8.9 Post-hoc pairwise confidence intervals.* If all
    $M = k(k-1)/2$ combinations, use $alpha_("Bonferroni") = alpha/M$.],
  $ overline(y)_i - overline(y)_j plus.minus t_(1-alpha/2)
  sqrt(("SSE")/(n-k)(1/n_i + 1/n_j)) $,
  [—],
  [Get $overline(y)_i, overline(y)_j$ from `1-Var Stats` per group. Read $"MSE" = "SSE"\/(n-k)$ from the ANOVA table. Key: $overline(y)_i - overline(y)_j plus.minus t_(1-alpha_B\/2) sqrt("MSE"(1\/n_i + 1\/n_j))$ (`[√]`); $t$ from $t(n-k)$ with $alpha_B = alpha\/M$.],
  [*8.10 Post-hoc pairwise hypothesis tests.* $H_0: mu_i = mu_j$ vs.
    $H_1: mu_i eq.not mu_j$. Test $M = k(k-1)/2$ times with
    $alpha_("Bonferroni") = alpha/M$.],
  $ p"-value" = 2 dot P(T > |t_("obs")|), quad
  t_("obs") = (overline(y)_i - overline(y)_j)/sqrt("MSE"(1/n_i + 1/n_j)) $,
  [—],
  [Key $t_("obs")$ by hand (`[√]`); $p$ from a $t$-table (use $alpha\/M$).],
  [*8.13 Least Significant Difference (LSD).*],
  $ "LSD"_alpha = t_(1-alpha/2) sqrt(2 dot "MSE"\/m) $,
  [—],
  [Once MSE known, key $t_(1-alpha/2) times sqrt(frac(2 "MSE", m))$; $t$ from a
    table.],
  [*8.20 Two-way ANOVA model and variation decomposition*
    ($"SST" = "SSE" + "SS(Tr)" + "SS(Bl)"$).

    *Model assumption:* $epsilon_(i j)$ independent
    $=> "Cov"(Y_(i j), Y_(m k)) = 0$ for all $(i,j) eq.not (m,k)$.],
  [$ underbrace(sum_(i=1)^k sum_(j=1)^l (y_(i j) - hat(mu))^2, "SST")
    = underbrace(sum_(i=1)^k sum_(j=1)^l
    (y_(i j) - hat(alpha)_i - hat(beta)_j - hat(mu))^2, "SSE") \
    + underbrace(l dot sum_(i=1)^k hat(alpha)_i^2, "SS(Tr)")
    + underbrace(k dot sum_(j=1)^l hat(beta)_j^2, "SS(Bl)") $],
  [—],
  [SS values are always given on the exam — read from the ANOVA table, do not
    compute from raw data.],
  [*8.22 Two-way ANOVA tests.*
    $"MSE" = "SSE"/((k-1)(l-1)) = hat(sigma)^2$ — the exam expresses the
    denominator as $hat(sigma)^2$ directly.],
  $ F_("Tr") = ("SS(Tr)"\/(k-1))/hat(sigma)^2 \
  F_("Bl") = ("SS(Bl)"\/(l-1))/hat(sigma)^2 $,
  [#cmd(
      "D = pd.DataFrame({'y': y, 'g1': g1, 'g2': g2})\nmodel = smf.ols('y ~ C(g1) + C(g2)', data=D).fit()\nanova_results = sm.stats.anova_lm(model, typ=2)",
    )],
  [Key $F_("Tr"), F_("Bl")$ from the sums of squares; $F$-quantiles from a table.],
)

== One-way ANOVA table

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, center, center, left, center, center),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header(
      [*Source of variation*],
      [*df*],
      [*Sums of squares*],
      [*Mean sum of squares*],
      [*Test statistic $F$*],
      [*$p$-value*],
    ),
    [Treatment],
    $k-1$,
    [SS(Tr)],
    $"MS(Tr)" = ("SS(Tr)")/(k-1)$,
    $F_("obs") = ("MS(Tr)")/("MSE")$,
    $P(F > F_("obs"))$,
    [Residual],
    $n-k$,
    [SSE],
    $"MSE" = ("SSE")/(n-k)$,
    [],
    [],
    [Total],
    $n-1$,
    [SST],
    [],
    [],
    [],
  )
]

*Reverse-engineering the one-way ANOVA table.* Any two independent cells determine the rest:

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1.3fr, 1.5fr),
    align: (left, left, left),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header([*Cell*], [*Standard formula*], [*Useful alternative(s)*]),
    [SS(Tr)],
    $sum_i n_i (overline(y)_i - overline(y))^2$,
    $"SST" - "SSE"; quad F dot (k-1) dot "MSE"$,
    [SSE],
    $sum_i (n_i - 1) s_i^2$,
    $"SST" - "SS(Tr)"; quad "MSE" dot (n-k)$,
    [SST],
    $"SSE" + "SS(Tr)"$,
    $sum_i sum_j (y_(i j) - overline(y))^2$,
    [MS(Tr)],
    $"SS(Tr)"\/(k-1)$,
    $F dot "MSE"$,
    [MSE],
    $"SSE"\/(n-k)$,
    $"MS(Tr)"\/F$,
    [$F_"obs"$],
    $"MS(Tr)"\/"MSE"$,
    [—],
  )
]

== Two-way ANOVA table

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, center, center, left, center, center),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header(
      [*Source of variation*],
      [*df*],
      [*Sums of squares*],
      [*Mean sums of squares*],
      [*Test statistic*],
      [*$p$-value*],
    ),
    [Treatment],
    $k-1$,
    [SS(Tr)],
    $"MS(Tr)" = ("SS(Tr)")/(k-1)$,
    $F_("Tr") = ("MS(Tr)")/("MSE")$,
    $P(F > F_("Tr"))$,
    [Block],
    $l-1$,
    [SS(Bl)],
    $"MS(Bl)" = ("SS(Bl)")/(l-1)$,
    $F_("Bl") = ("MS(Bl)")/("MSE")$,
    $P(F > F_("Bl"))$,
    [Residual],
    $(l-1)(k-1)$,
    [SSE],
    $"MSE" = ("SSE")/((k-1)(l-1))$,
    [],
    [],
    [Total],
    $n-1$,
    [SST],
    [],
    [],
    [],
  )
]

*Reverse-engineering the two-way ANOVA table.* Given SS(Tr), SS(Bl), and SSE (or MSE), every other cell follows:

#block(width: 100%)[
  #set text(size: 9pt)
  #table(
    columns: (auto, 1.2fr, 1.6fr),
    align: (left, left, left),
    inset: 6pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, y) => if y == 0 { luma(235) },
    table.header([*Cell*], [*Standard formula*], [*Useful alternative(s)*]),
    [SS(Tr)],
    $l dot sum_i hat(alpha)_i^2$,
    $"SST" - "SSE" - "SS(Bl)"; quad F_"Tr" dot (k-1) dot "MSE"$,
    [SS(Bl)],
    $k dot sum_j hat(beta)_j^2$,
    $"SST" - "SSE" - "SS(Tr)"; quad F_"Bl" dot (l-1) dot "MSE"$,
    [SSE],
    $"SST" - "SS(Tr)" - "SS(Bl)"$,
    $"MSE" dot (k-1)(l-1)$,
    [SST],
    $"SSE" + "SS(Tr)" + "SS(Bl)"$,
    $sum_i sum_j (y_(i j) - overline(overline(y)))^2$,
    [MS(Tr)],
    $"SS(Tr)"\/(k-1)$,
    $F_"Tr" dot "MSE"$,
    [MS(Bl)],
    $"SS(Bl)"\/(l-1)$,
    $F_"Bl" dot "MSE"$,
    [MSE $= hat(sigma)^2$],
    $"SSE"\/((k-1)(l-1))$,
    $"MS(Tr)"\/F_"Tr"; quad "MS(Bl)"\/F_"Bl"$,
    [$F_"Tr"$],
    $"MS(Tr)"\/"MSE"$,
    [—],
    [$F_"Bl"$],
    $"MS(Bl)"\/"MSE"$,
    [—],
  )
]

= The general linear model (GLM)

#st(
  [*9.1 The general linear model.* $bold(X)$ is the $n times p$ design matrix
    ($p$ = number of parameters, including the intercept); columns assumed
    linearly independent so $bold(X)^T bold(X)$ is invertible.],
  $ bold(Y) = bold(X) bold(beta) + bold(epsilon), quad
  bold(epsilon) tilde N(bold(0), sigma^2 bold(I)) $,
  cmd("smf.ols('y ~ x1 + x2', data=D).fit()"),
  [Not available (no matrix mode).],
  [*9.2 Least-squares estimator.* $hat(bold(beta))$ has exactly $p$ elements —
    one per column of $bold(X)$ (count columns to get $p$). Chosen to minimise
    the sum of squared residuals SSE.],
  $ hat(bold(beta)) = (bold(X)^T bold(X))^(-1) bold(X)^T bold(Y), quad
  hat(bold(Y)) = bold(H) bold(Y), quad
  bold(H) = bold(X)(bold(X)^T bold(X))^(-1) bold(X)^T $,
  [—],
  [Count columns of $bold(X)$ $= p$ $=$ number of $hat(beta)$ elements.],
  [*9.3 Properties of $bold(H)$.* Symmetric and idempotent. $bold(I)-bold(H)$ is
    also a projection (onto the residual space). The trace equals the rank equals
    the number of parameters.],
  $ bold(H)^T = bold(H), quad bold(H)^2 = bold(H), quad bold(H) bold(X) = bold(X) \
  op("tr")(bold(H)) = "rank"(bold(H)) = p, quad
  op("tr")(bold(I) - bold(H)) = n - p $,
  [—],
  [Conceptual — nothing to compute.],
  [*9.4 Key identity — always true.*],
  $ bold(Y)^T (bold(I) - bold(H)) bold(Y) = "SSE" = (n - p) hat(sigma)^2 $,
  [—],
  [$p$ = columns of $bold(X)$. So if $bold(X)$ has 3 columns:
    $Q = (n-3)hat(sigma)^2$.],
  [*9.5 Distribution of the parameter estimates.* $hat(bold(beta))$ is normal;
    the standard error of $hat(beta)_j$ is $hat(sigma)$ times the root of the
    $j$-th diagonal of $(bold(X)^T bold(X))^(-1)$.],
  $ hat(bold(beta)) tilde N(bold(beta), sigma^2 (bold(X)^T bold(X))^(-1)), quad
  T = (hat(beta)_j - beta_(0,j))/(hat(sigma)_(hat(beta)_j)) tilde t(n - p) $,
  [from `linfit.summary()`],
  [Read $hat(beta)_j$, $hat(sigma)_(hat(beta)_j)$ from the table; df $= n-p$.],
  [*9.6 $chi^2$-distribution of the residual quadratic form.*],
  $ ("SSE")/sigma^2 = (bold(Y)^T (bold(I) - bold(H)) bold(Y))/sigma^2
  tilde chi^2(n - p) $,
  [—],
  [Distributional — df $= n - p$.],
  [*9.7 General nested-model $F$-test.* Full model has projection $bold(H)$
    ($p$ params); reduced (null) model $bold(H)_0$ ($p_0$ params). Under $H_0$ the
    two quadratic forms are independent; their scaled ratio is $F$. ANOVA and the
    regression overall-$F$ are special cases.],
  $ (bold(Y)^T (bold(H) - bold(H)_0) bold(Y))/sigma^2 tilde chi^2(p - p_0), \
  F = (bold(Y)^T (bold(H) - bold(H)_0) bold(Y) \/ (p - p_0))
  /(bold(Y)^T (bold(I) - bold(H)) bold(Y) \/ (n - p))
  tilde F(p - p_0, n - p) $,
  [—],
  [df numerator $= p - p_0$ (rank difference), df denominator $= n - p$.],
  [*9.8 Same $bold(H)$ — what agrees and what may differ.*],
  $ bold(H) = bold(H)_2 quad => quad
  hat(bold(Y)) " identical", quad
  hat(sigma)^2 " identical", quad
  hat(bold(beta)) " may differ" $,
  [—],
  [Fitted values $hat(bold(Y))$ and variance $hat(sigma)^2$ are the same.
    Parameter estimates $hat(bold(beta))$ are *not* necessarily the same.],
  [*9.9 One-way ANOVA as projections.* $bold(H)$ is the group-mean projector
    (block-diagonal, rank $k$); $bold(H)_0 = (1\/n) bold(E)_(n,n)$ is the grand-mean
    projector (rank $1$). Then $bold(Y)^T(bold(H)-bold(H)_0)bold(Y) = "SS(Tr)"$ and
    $bold(Y)^T(bold(I)-bold(H))bold(Y) = "SSE"$.],
  $ bold(H) = "blockdiag"(1/n_i bold(E)_(n_i, n_i)), quad
  "SS(Tr)"/sigma^2 tilde chi^2(k - 1), quad "SSE"/sigma^2 tilde chi^2(n - k) $,
  [—],
  [Maps the matrix machinery onto the ANOVA table (df $k-1$ and $n-k$).],
)

= Glossary

#print-glossary(glossary-entries, show-all: true, disable-back-references: true)

= Appendix

== Functions of normal RVs — exam recipes (Q29/Q30 type)

These questions never require computation — only rewriting an expression into a
known $t$ or $F$ template, reading off the df, and doing algebra. Three facts:

#st(
  [*Square of a standard normal.*],
  $ N(0,1)^2 = chi^2(1) $,
  [—],
  [Collapse any squared $N(0,1)$ into $chi^2(1)$.],
  [*Pooling.* Independent $chi^2$ add their df.],
  $ chi^2(nu_1) + chi^2(nu_2) tilde chi^2(nu_1 + nu_2) $,
  [—],
  [e.g. $X^2 + Y$ with $Y tilde chi^2(5)$ gives $chi^2(6)$.],
  [*$F$ from two $chi^2$* (2.96) and its mean (2.101).],
  $ (U\/nu_1)/(V\/nu_2) tilde F(nu_1, nu_2), quad E[F] = nu_2/(nu_2 - 2) $,
  [—],
  [To hit an $F$, scale each $chi^2$ by *its own* df.],
  [*$t$ template* (2.87).],
  $ Z/sqrt(W\/nu) tilde t(nu), quad W tilde chi^2(nu) $,
  [—],
  [If a $nu$ is missing inside the root, factor it out: a stray $sqrt(nu)$
    moves to the other side of the inequality.],
)

*Worked — mean of a $chi^2$ ratio (Q29).* $Y = Y_1\/(X^2 + Y_2)$, with
$Y_1 tilde chi^2(5)$, $X^2 + Y_2 tilde chi^2(6)$. Build the $F$:
$ F = (Y_1\/5)/((X^2+Y_2)\/6) = 6/5 dot Y quad => quad Y = 5/6 F, quad
E[Y] = 5/6 dot 6/(6-2) = 5/4. $

*Worked — a quantile (Q30).* $P(X\/sqrt(Y_1) < a) = 0.95$, $Y_1 tilde chi^2(5)$.
Factor the root: $X\/sqrt(Y_1) = (1\/sqrt(5)) dot X\/sqrt(Y_1\/5) = (1\/sqrt(5)) T$
with $T tilde t(5)$. Then $P(T < a sqrt(5)) = 0.95 => a = t_(0.95)(5)\/sqrt(5)$.

== OLS `summary(slim=True)` — annotated

What `print(linfit.summary(slim=True))` actually outputs (two-predictor example):

```
                         OLS Regression Results
==============================================================================
Dep. Variable:                      y   R-squared:                       0.942
Model:                            OLS   Adj. R-squared:                  0.936
No. Observations:                  25   F-statistic:                     152.3
Df Residuals:                      22   Prob (F-statistic):           4.23e-13
Df Model:                           2
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
Intercept      1.2345      0.456      2.709      0.013       0.289       2.180
x1             0.5678      0.089      6.379      0.000       0.384       0.752
x2            -0.2341      0.112     -2.090      0.049      -0.466      -0.002
==============================================================================
```

*How each number in the coefficient block is computed:*

*SLR* ($y_i = beta_0 + beta_1 x_i + epsilon_i$) — hand-computable:

$ hat(beta)_1 = frac(S_(x y), S_(x x)) = frac(sum(x_i - overline(x))(y_i - overline(y)), sum(x_i - overline(x))^2), quad hat(beta)_0 = overline(y) - hat(beta)_1 overline(x) $

$ "SSE" = S_(y y) - hat(beta)_1 S_(x y), quad hat(sigma)^2 = frac("SSE", n - 2) $

*MLR* ($bold(Y) = bold(X) bold(beta) + bold(epsilon)$) — matrix form:

$ hat(bold(beta)) = (bold(X)^T bold(X))^(-1) bold(X)^T bold(Y), quad hat(sigma)^2 = frac("SSE", n - p), quad "SSE" = bold(Y)^T (bold(I) - bold(H)) bold(Y) $

where $p$ = number of columns in $bold(X)$ (= Df Model + 1) and $n - p$ = Df Residuals.

*Standard error, t-statistic, p-value, and CI for each $hat(beta)_j$:*

$ hat(sigma)_(hat(beta)_j) = hat(sigma) sqrt([(bold(X)^T bold(X))^(-1)]_(j j)) $

$ t_("obs",j) = frac(hat(beta)_j, hat(sigma)_(hat(beta)_j)) tilde t(n - p) quad "under" H_0: beta_j = 0 $

$ p"-value" = 2 P(T > |t_("obs",j)|), quad T tilde t(n - p) $

$ "95% CI": quad hat(beta)_j plus.minus t_(0.975)(n - p) dot hat(sigma)_(hat(beta)_j) $
Footer entries printed below the coefficient block:

#block(width: 100%)[
#set text(size: 9pt)
#table(
  columns: (auto, auto, auto),
  align: (left, left, left),
  inset: 6pt,
  stroke: 0.5pt + luma(60%),
  fill: (_, y) => if y == 0 { luma(235) },
  table.header([*Printed entry*], [*Symbol*], [*Formula / meaning*]),
  [`R-squared`],
  $R^2$,
  $1 - "SSE"\/"SST"$,
  [`F-statistic`],
  $F_("obs")$,
  [$"MS(model)"\/"MSE"$; overall $F$-test: $H_0$ all slopes $= 0$],
  [`Prob (F-statistic)`],
  $p$,
  [$p$-value of the overall $F$-test],
  [`No. Observations`],
  $n$,
  [],
  [`Df Residuals`],
  $n - p$,
  [denominator df for $t$ and $F$],
  [`Df Model`],
  $p - 1$,
  [number of slopes, excl. intercept],
)
]

All $t$-quantiles use df $= n - p$ (Df Residuals). Generated by #cmd("print(linfit.summary(slim=True))").

== Plot types and stochastic variable generation

#block(width: 100%)[
#set text(size: 9pt)
#table(
  columns: (auto, auto, auto),
  align: (left, left, left),
  inset: 6pt,
  stroke: 0.5pt + luma(60%),
  fill: (_, y) => if y == 0 { luma(235) },
  table.header([*Distribution*], [*Generate*], [*Typical plot*]),
  [Normal $N(mu, sigma^2)$],
  [`stats.norm.rvs(loc=mu, scale=sigma, size=n)`],
  [histogram + pdf overlay; QQ-plot (`probplot`)],
  [Binomial $B(n, p)$],
  [`stats.binom.rvs(n, p, size=N)`],
  [bar chart (`plt.bar`)],
  [Poisson $"Po"(lambda)$],
  [`stats.poisson.rvs(mu=lam, size=N)`],
  [bar chart],
  [Exponential $"Exp"(lambda)$],
  [`stats.expon.rvs(scale=1/lam, size=N)`],
  [histogram; CDF $1 - e^(-lambda x)$ overlay],
  [Lognormal $"LN"(alpha, beta)$],
  [`stats.lognorm.rvs(s=beta, scale=exp(alpha), size=N)`],
  [histogram of $X$ and of $ln(X)$],
  [Uniform $U(a, b)$],
  [`stats.uniform.rvs(loc=a, scale=b-a, size=N)`],
  [histogram (flat)],
)
]

*Histogram + theoretical pdf overlay (generic):*

```python
x = stats.norm.rvs(loc=0, scale=1, size=1000)   # replace with desired rvs
t = np.linspace(x.min(), x.max(), 300)
plt.hist(x, bins=30, density=True, alpha=0.6, label='simulated')
plt.plot(t, stats.norm.pdf(t, 0, 1), 'r-', label='pdf')  # replace pdf call
plt.legend(); plt.title('Histogram vs theoretical pdf'); plt.show()
```

*Residual QQ-plot + residuals vs. fitted (SLR/MLR):*

```python
res = linfit.resid; yfit = linfit.fittedvalues
fig, ax = plt.subplots(1, 2, figsize=(10, 4))
stats.probplot(res, dist='norm', plot=ax[0])
ax[0].set_title('Normal QQ-plot of residuals')
ax[1].scatter(yfit, res); ax[1].axhline(0, color='red', lw=1)
ax[1].set_xlabel('Fitted values'); ax[1].set_ylabel('Residuals')
plt.tight_layout(); plt.show()
```

== Two-sample proportion test — direct recipe (Thm 7.18)

$H_0: p_1 = p_2$ vs. $H_1: p_1 eq.not p_2$. Step by step:

+ Estimate each group: $hat(p)_i = x_i \/ n_i$.
+ Pool under $H_0$: $hat(p) = (x_1 + x_2) \/ (n_1 + n_2)$.
+ Compute the test statistic (the $-0$ makes the null hypothesis explicit):
  $ z_("obs") = frac((hat(p)_1 - hat(p)_2) - 0, sqrt(hat(p)(1-hat(p))(1\/n_1 + 1\/n_2))) $
+ $p$-value $= 2 dot P(Z > |z_("obs")|)$, $quad Z tilde N(0,1)$.
+ Reject $H_0$ at level $alpha$ if $|z_("obs")| > z_(1-alpha/2)$.

*In Python:*
```python
zobs, pval = smprop.proportions_ztest([x1, x2], [n1, n2], value=0)
```

The denominator uses the *pooled* $hat(p)$ — not the individual $hat(p)_i$ — because $H_0$ asserts a common true proportion. This differs from the CI formula (Thm 7.15), which uses each group's own $hat(p)_i$.

== Scipy function patterns — recognition

The exam never requires writing code, but may show a snippet and ask what it computes.
Five call patterns appear for every distribution:

#block(width: 100%)[
#set text(size: 9pt)
#table(
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  inset: 6pt,
  stroke: 0.5pt + luma(60%),
  fill: (_, y) => if y == 0 { luma(235) },
  table.header([*Pattern*], [*Returns*], [*What the exam may ask*]),
  [`dist.rvs(params, size=k)`],
  [Array of $k$ random draws],
  [Which distribution / parameters does this simulate? Histogram shape follows the distribution.],
  [`dist.pmf(k, params)` _(discrete only)_],
  [$P(X = k)$],
  [What exact probability is computed? Only valid for discrete distributions.],
  [`dist.pdf(x, params)` _(continuous only)_],
  [$f(x)$, density at $x$],
  [Not a probability — it is the height of the density curve. $P(a<X<=b)$ requires the area $F(b)-F(a)$.],
  [`dist.cdf(x, params)`],
  [$P(X <= x)$],
  [Cumulative probability. Use $F(b) - F(a)$ for $P(a < X <= b)$.],
  [`dist.ppf(q, params)`],
  [Quantile: smallest $x$ with $P(X <= x) = q$],
  [Critical value / inverse cdf. `ppf(0.975)` $= z_(0.975) approx 1.96$.],
)
]

Common calls and their meaning:

#block(width: 100%)[
#set text(size: 9pt)
#show raw: set text(size: 7.5pt)
#table(
  columns: (1.9fr, 1fr),
  align: (left, left),
  inset: 5pt,
  stroke: 0.5pt + luma(60%),
  fill: (_, y) => if y == 0 { luma(235) },
  table.header([*Call*], [*Computes*]),
  [`stats.norm.cdf(x, loc=mu, scale=sigma)`],
  [$P(X <= x)$ for $X tilde N(mu, sigma^2)$],
  [`stats.norm.ppf(0.975)`],
  [$z_(0.975) approx 1.96$],
  [`stats.t.ppf(0.975, df=nu)`],
  [$t_(0.975)$ with $nu$ df],
  [`stats.chi2.ppf(0.95, df=nu)`],
  [$chi^2_(0.95)$ with $nu$ df (upper 5% critical value)],
  [`stats.f.ppf(0.95, dfn=nu1, dfd=nu2)`],
  [$F_(0.95)$ with $(nu_1, nu_2)$ df],
  [`stats.binom.pmf(k, n, p)`],
  [$P(X = k)$ for $X tilde B(n, p)$],
  [`stats.binom.cdf(k, n, p)`],
  [$P(X <= k)$ for $X tilde B(n, p)$],
  [`stats.poisson.pmf(k, mu=lam)`],
  [$P(X = k)$ for $X tilde "Po"(lambda)$],
  [`stats.expon.cdf(x, scale=1/lam)`],
  [$F(x) = 1 - e^(-lambda x)$ for $X tilde "Exp"(lambda)$],
  [`2*(1 - stats.t.cdf(abs(tobs), df=nu))`],
  [Two-sided $p$-value for a $t$-test with observed $t_"obs"$],
  [`2*(1 - stats.norm.cdf(abs(zobs)))`],
  [Two-sided $p$-value for a $z$-test with observed $z_"obs"$],
  [`stats.chi2_contingency(X, correction=False)`],
  [$chi^2_"obs"$, $p$-value, df, and expected counts for an $r times c$ table],
)
]

== Reading plots on the exam

When the exam shows a plot image or the code that produces one, identify: (1) the plot type, (2) the distribution shape, (3) any model violations.

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr, 1fr),
    align: (left, left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (col, row) => if row == 0 { luma(235) } else if col == 0 { luma(248) },
    table.header([*Plot*], [*What it shows*], [*Healthy (assumptions met)*], [*Warning sign*]),
    [*Histogram*],
    [Distribution shape of the raw data or residuals],
    [Bell-shaped, roughly symmetric — consistent with normality],
    [Right/left skew; bimodal; hard cutoff at zero (→ exponential / lognormal)],
    [*QQ-plot* (normal)],
    [Normality: sample quantiles vs. theoretical normal quantiles],
    [Points lie close to the diagonal reference line],
    [Heavy tails: both ends curve *away* from the line; light tails: curve toward it; S-shape: skew],
    [*Residuals vs. fitted*],
    [Linearity + equal variance ($epsilon tilde N(0,sigma^2)$)],
    [Random scatter around $y = 0$, constant spread across all fitted values],
    [Fan/funnel shape → non-constant variance; curved band → non-linearity (add a polynomial term)],
    [*Residuals vs. predictor $x_j$*],
    [Whether the predictor is sufficiently captured by the current model],
    [Random scatter around $y = 0$],
    [U-shape / curvature → add $x_j^2$; wedge shape → transform $x_j$],
    [*Box plots per group*],
    [Equal variance across groups; outliers],
    [Boxes of similar height (IQR); whiskers roughly equal length],
    [Very different box heights → equal-variance assumption violated; extreme points → outliers],
    [*ECDF*],
    [Empirical CDF; jump heights equal each value's probability],
    [Smooth S-curve (normal); straight diagonal (uniform); concave (exponential tail)],
    [Unequal jump heights → non-uniform discrete; identify distribution from overall shape],
  )
]

*Quick rules.* (1) A QQ-plot checks normality of *residuals*, not the raw $y$-values. (2) Residuals vs. fitted checks linearity and equal variance — *not* independence (independence cannot be assessed from these plots). (3) In a box-plot comparison, roughly equal IQR widths (box heights) is the equal-variance check for one-way ANOVA.

*Histogram shapes*

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, row) => if row == 0 { luma(235) },
    table.header([*Shape*], [*Likely distribution / cause*], [*What to try*]),
    [*Symmetric, bell*],
    [Normal $N(mu, sigma^2)$],
    [Proceed with normality assumption],
    [*Right-skewed* (long right tail)],
    [Lognormal, Exponential, Gamma, Weibull; counts / waiting times; positive data with rare large values],
    [Log-transform $y' = ln(y)$; check QQ-plot after transform],
    [*Left-skewed* (long left tail)],
    [Bounded from above (scores, percentages near 100); reflected exponential; censored data],
    [Reflect and log: $y' = ln(c - y)$; or use a Beta model],
    [*Bimodal* (two peaks)],
    [Two subpopulations mixed together; a lurking categorical variable],
    [Split by a grouping variable; check residuals per group],
    [*Uniform / flat*],
    [Uniform distribution; discretisation artefact],
    [Verify measurement resolution; $U(a,b)$ model],
    [*Hard cutoff at zero*],
    [Exponential or Poisson (counts); mixture with a point mass at 0],
    [Exponential or Poisson model; zero-inflated model],
  )
]

#figure(image("../figures/reading_hist.svg", width: 100%))

*Normal QQ-plots — how to read them*

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, row) => if row == 0 { luma(235) },
    table.header([*Pattern*], [*What it means*], [*Action*]),
    [Points follow the line closely],
    [Data (or residuals) are approximately normal — assumption met],
    [Proceed with normal-based inference],
    [Both ends curve *away* from line (S opens outward)],
    [Heavy tails — more extreme values than normal (e.g. $t$-distributed data)],
    [Use robust methods; be cautious with small $n$ t-tests],
    [Both ends curve *toward* line (S closes inward)],
    [Light tails — fewer extreme values than normal (platykurtic)],
    [Normality still roughly holds for most tests; note for outlier analysis],
    [Lower-left below, upper-right above (concave up)],
    [Right skew — distribution has a long upper tail],
    [Log-transform or use a right-skewed model (lognormal, exponential)],
    [Lower-left above, upper-right below (concave down)],
    [Left skew — distribution has a long lower tail],
    [Reflect and transform; check for bounded/censored data],
    [One or two isolated points far from the line],
    [Outliers — unusual observations not following the bulk of the data],
    [Investigate those specific observations; do not remove without justification],
  )
]

#figure(image("../figures/reading_qq.svg", width: 95%))

*Residuals vs. fitted — three scenarios*

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, row) => if row == 0 { luma(235) },
    table.header([*Pattern*], [*What it means*], [*Action*]),
    [Random scatter around $y=0$, constant band width],
    [Linearity and equal variance ($sigma^2$ const.) — assumptions met],
    [No action needed],
    [Fan / funnel shape (spread grows or shrinks with fitted values)],
    [Non-constant variance (heteroscedasticity) — $V[epsilon]$ depends on $hat(y)$],
    [Log- or square-root-transform the response $y$; or use WLS],
    [U-shape or curved band],
    [Non-linearity — the mean function is mis-specified],
    [Add a quadratic term $x^2$; or transform $x$; or add a missing predictor],
    [Systematic pattern vs. a specific predictor $x_j$ (not fitted values)],
    [That predictor is not adequately captured (curvature or interaction)],
    [Add $x_j^2$ or an interaction term involving $x_j$],
    [Residuals cluster in horizontal bands],
    [Discrete / categorical response — continuous model may be wrong],
    [Consider a GLM (Poisson, logistic) or ordinal model],
  )
]

#figure(image("../figures/reading_resid.svg", width: 95%))

*Box plots — ANOVA equal-variance check*

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, row) => if row == 0 { luma(235) },
    table.header([*Pattern*], [*What it means*], [*Action*]),
    [Box heights (IQRs) roughly equal across groups],
    [Equal-variance assumption plausible — ANOVA is appropriate],
    [Proceed with one-way ANOVA],
    [Box heights differ substantially (largest IQR $> 2times$ smallest)],
    [Heteroscedasticity — equal-variance assumption violated],
    [Use Welch's ANOVA (not pooled); or log-transform and re-check],
    [Medians clearly separated, boxes barely overlap],
    [Strong group effect — reject $H_0: mu_1 = dots.c = mu_k$ likely],
    [Confirm with ANOVA $F$-test; follow up with Bonferroni / Tukey],
    [Boxes overlap heavily, no clear separation],
    [Little evidence of a group effect],
    [ANOVA $p$-value likely large; do not over-interpret],
    [Isolated dots beyond whiskers],
    [Potential outliers (beyond $Q_1 - 1.5 dot "IQR"$ or $Q_3 + 1.5 dot "IQR"$)],
    [Investigate; check whether they drive the ANOVA result],
  )
]

#figure(image("../figures/reading_box.svg", width: 80%))

*ECDF — reading jump heights and overall shape*

#block(width: 100%)[
  #set text(size: 8.5pt)
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: 0.5pt + luma(60%),
    fill: (_, row) => if row == 0 { luma(235) },
    table.header([*Pattern*], [*What it means*], [*Action*]),
    [Smooth S-curve],
    [Normal or approximately symmetric distribution],
    [Proceed with normal-based methods; confirm with QQ-plot],
    [Concave (rises steeply then flattens — fast early, slow late)],
    [Right-skewed / exponential-type tail; most values are small],
    [Try exponential or lognormal model; log-transform],
    [Convex (rises slowly then steeply — slow early, fast late)],
    [Left-skewed / bounded-above distribution; most values are large],
    [Reflect; check for bounded data or ceiling effects],
    [Staircase with equal jump heights $1\/n$],
    [All values distinct (continuous data) or discrete uniform],
    [No action; each jump = one observation of weight $1\/n$],
    [Staircase with *unequal* jump heights],
    [Discrete distribution — jump height at value $x_k$ equals $P(X=x_k)$],
    [Read off probabilities directly from jump sizes],
    [Flat section (no jump over a range)],
    [No probability mass in that interval — gap in the support],
    [Investigate missing range; possible data-collection artefact],
  )
]

#figure(image("../figures/reading_ecdf.svg", width: 80%))

#block(fill: luma(230), inset: 10pt, radius: 3pt, width: 100%)[
  *Hypothesis test decision rule*

  #v(0.3em)

  #grid(columns: (1fr, 1fr), gutter: 1em, block[
    *Reject $H_0$* if $quad p"-value" < alpha$

    The result is statistically significant at level $alpha$. You have sufficient evidence against $H_0$.
  ], block[
    *Fail to reject $H_0$* if $quad p"-value" >= alpha$

    Insufficient evidence against $H_0$. This does _not_ mean $H_0$ is true — never say "accept $H_0$".
  ])
]
