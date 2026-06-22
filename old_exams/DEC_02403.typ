#set page(paper: "a4", margin: (x: 2.5cm, y: 2.5cm), numbering: "1", header: context [
  #set text(9pt)
  Technical University of Denmark
  #h(1fr)
  Page #counter(page).display() of 29 pages.
])

#set text(font: "Georgia", size: 12pt, lang: "en")

#set par(justify: true, leading: 0.65em)

// Style for exercise boxes
#let exercise-box(title) = block(
  width: 100%,
  inset: (x: 6pt, y: 5pt),
  stroke: (left: 1.5pt + black),
  fill: luma(240),
)[#text(weight: "bold")[#title]]

// Style for question headings
#let question-heading(label) = [
  #v(0.8em)
  *#label*
  #v(0.3em)
]

// Hollow circle for answer options
#let circle = $circle.stroked.small$

// Answer option macro
#let opt(n, body) = [
  #grid(columns: (1.4em, 1fr), gutter: 0pt, align: (right + top, left + top), [#n $circle$], [#body])
  #v(0.35em)
]
#align(center)[
  #text(size: 14pt, weight: "bold")[Exam Question Paper]

  #v(0.5em)

  #text(size: 12pt)[Written Examination: 20 December 2025]

  #v(0.3em)

  *Course name and number:* 02403 Introduction to Mathematical Statistics

  #v(0.3em)

  *Duration:* 4 hours

  #v(0.3em)

  *Aids allowed:* All printed aids plus pocket calculator model TI30XS or TI30XB
]

#v(1em)

The final answers should be handed in by filling out a separate *"Answer Sheet"*.

This exam consists of *30 questions* of the "multiple choice" type, which are divided between *16 exercises*.

Only hand in the *"Answer Sheet"* and not the entire question paper.

*Multiple choice questions:* Note that in each question, one and only one of the answer options is correct. Furthermore, not all the suggested answers are necessarily meaningful. Always remember to round off your own result to the number of decimals given in the answer options before you choose your answer.

*The use of Python code in this exam:* This exam includes Python code. Note that we use the following libraries and abbreviations:

#block(fill: luma(245), inset: 10pt, radius: 3pt, width: 100%)[
```python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import scipy.stats as stats
import statsmodels.api as sm
import statsmodels.formula.api as smf
import statsmodels.stats.power as smp
import statsmodels.stats.proportion as smprop
```
]

#pagebreak()

// ============================================================
// EXERCISE I
// ============================================================

#exercise-box[Exercise I]

#v(0.5em)

You draw many random samples, each of size $n = 150$, from a population that is skewed to the right (meaning the distribution has a tail extending far to the right). The distribution has mean 40 and a standard deviation 10.

#question-heading[Question I.1 (1)]

According to the Central Limit Theorem (CLT), which of the following statements about the distribution of the sample means is correct?

#opt[1][The distribution of the sample means will be highly skewed to the right.]
#opt[2][The mean of the sample means will be much greater than 40 because of the skewness.]
#opt[3][The distribution of the sample means will be approximately normally distributed and centered around 40.]
#opt[4][The standard deviation of the sample means will be 10, same as the population.]
#opt[5][The distribution of the sample means will become uniform as the sample size increases.]
#opt[6][Don't know / No answer]

the CLT states thtat the sample is centred around 40, therefore 3, is the correct answer.

#v(0.5em)
_Continue on page 4_

#pagebreak()

// ============================================================
// EXERCISE II
// ============================================================

#exercise-box[Exercise II]

#v(0.5em)

The discrete random variable $X$ has the following distribution:

#v(0.5em)

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    stroke: 0.5pt,
    inset: 8pt,
    table.header[$x$][$1$][$3$][$5$][$6$],
    [$f(x)$],
    [$0.1$],
    [$0.4$],
    [$0.3$],
    [$0.2$],
  )
]

#v(0.5em)

where $f(x) = P(X = x)$ is the probability density function (pdf).

#question-heading[Question II.1 (2)]

What is the mean $E[X]$ and variance $V[X]$?

#opt[1][$E[X] = 3.75$ and $V[X] = 1.92$]
#opt[2][$E[X] = 4.00$ and $V[X] = 1.92$]
#opt[3][$E[X] = 4.40$ and $V[X] = 2.40$]
#opt[4][$E[X] = 3.75$ and $V[X] = 2.40$]
#opt[5][$E[X] = 4.00$ and $V[X] = 2.40$]
#opt[6][Don't know / No answer]

putting the x and f(x) values into a TI30XB in L1 and L2 respectively then pick 1-var with L1 and L2

$
  overline(x) = 4 \
  sigma_x = 1.549
$

where:
$
  sigma_x^2 = 2.399401 approx 2.40
$

this means that $E[X] = 4.00$ and $V[X] = 2.40$, leading to option 5 being the correct answer.

#v(0.5em)
_Continue on page 5_

#pagebreak()

// ============================================================
// EXERCISE III
// ============================================================

#exercise-box[Exercise III]

#v(0.5em)

Some data has been obtained for which we simply call the observed values "y" and "x". The data is visualized in the scatter plot below.

#v(0.5em)
#align(center)[#image("figures/1.png")]
#v(0.5em)

The following information about the data is provided:

$ overline(x) = 0.5024 $

$ overline(y) = 8.1964 $

$ S_(x x) = sum_i (x_i - overline(x))^2 = 2.5365 $

$ S_(x y) = sum_i (x_i - overline(x))(y_i - overline(y)) = 10.2153 $

Where $n$ is the number of observations in the data.

The data was stored in Python in a DataFrame called `"dat"`, containing the columns `"x"` and `"y"`. A simple linear regression model was fitted to the data using the following command in Python:

#block(fill: luma(245), inset: 10pt, radius: 3pt, width: 100%)[
```python
fit = smf.ols(formula = 'y ~ x', data = dat).fit()
```
]

The resulting regression table is printed below (although certain values have been substituted by the letters A, B, C and D):

#block(fill: luma(245), inset: 10pt, radius: 3pt, width: 100%)[
```
print(fit.summary(slim=True))

OLS Regression Results
==============================================================
Dep. Variable:     y         R-squared:            0.583
Model:             OLS       Adj. R-squared:       0.573
No. Observations:  45        F-statistic:          60.12
Covariance Type:   nonrobust Prob (F-statistic):   1.06e-09
==============================================================
             coef    std err    t       P>|t|  [0.025  0.975]
--------------------------------------------------------------
Intercept   6.1731   0.289   21.388   0.000   5.591   6.755
x             A        B      7.754   0.000     C       D
==============================================================
```
]

#question-heading[Question III.1 (3)]

Consider the statistical model that was fitted to the data and the values represented by the letters A and B (inserted in the regression table above).

Which of the following statements is correct?

#opt[1][
  $A = hat(beta)_1$ is the estimate of the parameter $beta_1$ in the statistical model: $y_i = beta_0 + beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$. $B = hat(sigma)_(hat(beta)_1)$ is the estimated standard error of $hat(beta)_1$.
]
#opt[2][
  $A = hat(beta)_0$ is the estimate of the parameter $beta_0$ in the statistical model: $y_i = beta_0 + beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$. $B = hat(sigma)_(hat(beta)_0)$ is the estimated standard error of $hat(beta)_0$.
]
#opt[3][
  $A = hat(beta)_1$ is the estimate of the parameter $beta_1$ in the statistical model: $y_i = beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$. $B = hat(sigma)_(hat(beta)_1)$ is the estimated standard error of $hat(beta)_1$.
]
#opt[4][
  $A = hat(beta)_0$ is the estimate of the parameter $beta_0$ and $B = hat(beta)_1$ is the estimate of the parameter $beta_1$ in the statistical model: $y_i = beta_0 + beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$.
]
#opt[5][
  $A = hat(beta)_1$ is the estimate of the parameter $beta_1$ and $B = hat(beta)_0$ is the estimate of the parameter $beta_0$ in the statistical model: $y_i = beta_0 + beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$.
]
#opt[6][Don't know / No answer]

The correct answer is option 1.

A corresponds to $hat(beta)_1$, where $y_i = beta_0 + beta_1 x_i + epsilon_i$, with $epsilon_i ~ N(0, sigma^2)$. B corresponds to $hat(sigma)_(hat(beta)_1)$, which is the estimated standard error of $hat(beta)_1$.

#question-heading[Question III.2 (4)]

What is the value of A?

#opt[1][$A = 0.5024$]
#opt[2][$A = 10.2153$]
#opt[3][$A = 5.10765$]
#opt[4][$A = 45\/10 = 4.5$]
#opt[5][$A = 4.0273$]
#opt[6][Don't know / No answer]

The correct answer is option 5, this can be calculated using the formula for the slope parameter in simple linear regression:
$
  hat(beta)_1 = frac(S_(x y), S_(x x)) = frac(10.2153, 2.5365) = 4.0273
$

#question-heading[Question III.3 (5)]

In order to check the model assumptions the following plots were produced:

#v(0.5em)
#align(center)[#image("figures/2.png")]
#v(0.5em)

Which of the following statements is correct?

#opt[1][The histogram and qq-plot of the residuals indicate that the assumption about normality ($epsilon_i ~ N(0, sigma^2)$) is violated --- i.e. the residuals do not seem to follow a normal distribution.]
#opt[2][The qq-plot of the residuals indicate that the assumption about independence is violated --- i.e. the residuals do not seem to be independent.]
#opt[3][The plots do not indicate a violation of the model assumptions.]
#opt[4][The scatter plot of the residuals vs. fitted values indicate that the assumption about independence is violated --- i.e. the residuals do not seem to be independent.]
#opt[5][The qq-plot of the residuals indicate that the residuals follow a normal distribution with zero mean: $epsilon_i ~ N(0, sigma^2)$.]
#opt[6][Don't know / No answer]

The correct answer is option 1. the histogram of the residuals does not look like a bell-shaped curve, and the qq-plot of the residuals does not show points that approximately follow a straight line, which indicates that the assumption about normality is violated.

#v(0.5em)
_Continue on page 8_

#pagebreak()

// ============================================================
// EXERCISE IV
// ============================================================

#exercise-box[Exercise IV]

#v(0.5em)

A group of researchers study cell activity in four different species of mice. They collect samples with sample sizes: $n_1 = 50$, $n_2 = 150$, $n_3 = 150$, $n_4 = 50$ for species 1, 2, 3 and 4 respectively.

The researchers fit a mathematical model of the form:

$ Y_(i j) = mu + alpha_i + epsilon_(i j), quad epsilon_(i j) ~ N(0, sigma^2), quad i in {1, 2, 3, 4}, $

where the errors $epsilon_(i j)$ are assumed to be independent.

The researchers compute that $S S(T r) = 6.0479$ (here "$T r$" relates to the different species) and $S S T = 163.234$, yielding a p-value of $0.0018$ when testing the null hypothesis:

$ H_0 : alpha_1 = alpha_2 = alpha_3 = alpha_4 = 0 $

#question-heading[Question IV.1 (6)]

Which of the following statements give the correct value of the test statistic in the F-test, and also states a correct conclusion?

#opt[1][The value of the test statistic is $F = 5.079$. The null hypothesis cannot be rejected at significance level $alpha = 0.01$.]
#opt[2][The value of the test statistic is $F = 5.079$. The null hypothesis cannot be rejected at significance level $alpha = 0.001$.]
#opt[3][The value of the test statistic is $F = 2.96$. The null hypothesis is rejected at significance level $alpha = 0.01$.]
#opt[4][The value of the test statistic is $F = 2.96$. The null hypothesis is rejected at significance level $alpha = 0.001$.]
#opt[5][The value of the test statistic is $F = 0.99$. The null hypothesis is rejected at significance level $alpha = 0.05$.]
#opt[6][Don't know / No answer]

$
  F = ("SS"("Tr") / (k - 1)) / (("SST" - "SS"("Tr")) / (n - k)) = (6.0479 / 3) / ((163.234 - 6.0479) / (400 - 4)) = 5.079
$

Given that the $p$-value is $0.0018$, the null hypothesis can be rejected if $p < alpha$. Therefore, the null hypothesis can be rejected at significance level $alpha = 0.01$, but not at significance level $alpha = 0.001$. leading the answer to be option 2.

#question-heading[Question IV.2 (7)]

The projection matrix associated with the model is

$ H = mat(
  frac(1, n_1) E_(n_1 \, n_1), 0, 0, 0;0, frac(1, n_2) E_(n_2 \, n_2), 0, 0;0, 0, frac(1, n_3) E_(n_3 \, n_3), 0;0, 0, 0, frac(1, n_4) E_(n_4 \, n_4);delim: "("
) , $

where $E_(n_i, n_i)$ is a $n_i times n_i$ matrix of ones. Under the null-hypothesis $H_0 : alpha_1 = alpha_2 = alpha_3 = alpha_4 = 0$, then the appropriate projection matrix is

$ H_0 = frac(1, n) E_(n,n), $

where $n = n_1 + n_2 + n_3 + n_4$.

Given that the null-hypothesis is true, what is the distribution of

$ Q = frac(1, sigma^2) Y^T (H - H_0) Y, $

where $sigma^2$ is the true (but unknown) variance of $epsilon_i$?

#opt[1][$Q ~ F(4, n - 3)$]
#opt[2][$Q ~ chi^2(3)$]
#opt[3][$Q ~ chi^2(n - 4)$]
#opt[4][$Q ~ F(4, n)$]
#opt[5][$Q ~ F(3, n - 4)$]

the answer is 2.

from notes we know that it is a $chi^2$ distribution with degrees of freedom equal to the rank of $H - H_0$. The rank of $H$ is $k = 4$ (number of groups) and the rank of $H_0$ is 1, therefore the rank of $H - H_0$ is $4 - 1 = 3$. Hence, $Q ~ chi^2(3)$.

#question-heading[Question IV.3 (8)]

The researchers proceed to perform model validation (i.e., model checking). They produce the diagnostic plots presented below:

#v(0.5em)
#align(center)[#image("figures/3.png")]
#v(0.5em)

Which of the following statements is correct (all arguments must be true)?

#opt[1][The QQ-plot indicates a violation of the assumption about normally distributed parameters. The box plots indicate an incorrect estimation of the model parameters.]
#opt[2][The QQ-plot indicates a violation of the assumption about normally distributed residuals. The box plots indicate a violation of the assumption of equal residual variance across species.]
#opt[3][The QQ-plot indicates a violation of the assumption about normally distributed residuals. The box plots indicate a violation of the assumption that $mu_(epsilon_(i j)) = 0$.]
#opt[4][The QQ-plot indicates a violation of the assumption about equal sample size within each group. The box plots indicate a disproportionate number of outliers in the data.]
#opt[5][The diagnostic plots do not indicate any violation of model assumptions.]
#opt[6][Don't know / No answer]

Look at each plot separately:

*Q-Q plot*: The points follow the line well in the middle, but the left tail curves significantly below the line (those points at -3 to -2 on y-axis drop far below the red line). That's a heavy left tail — a violation of normality.

*Boxplot*: Look at species 4 — the box (IQR) is much taller than species 1 and 2. Species 3 also has a larger spread. The boxes have very different heights across groups, meaning the within-group variance differs — that's a violation of the equal variance assumption ($sigma^2$ assumed the same for all groups in ANOVA).

So option 2 is correct because it correctly identifies both violations:
- QQ → normality violated
- Boxplot → equal variance violated

Option 3 is wrong because $mu_(epsilon_(i,j)) = 0$ (zero mean residuals) is always guaranteed by least squares — it can never be violated by definition.

#v(0.5em)
_Continue on page 12_

#pagebreak()

// ============================================================
// EXERCISE V
// ============================================================

#exercise-box[Exercise V]

#v(0.5em)

A researcher claims that the average daily screen time for educational use by university students is 6 hours. To test this claim, a random sample of $n = 20$ students was selected, giving:

$ overline(x) = 5.4 "hours" quad "and" quad s = 1.2 "hours". $

Assume screen time is approximately normally distributed.

A hypothesis test for the null hypothesis $H_0 : mu = 6$ is conducted and the computed p-value is $0.03$.

#question-heading[Question V.1 (9)]

Which of the following statements is correct?

#opt[1][Using a significance level, $alpha = 0.05$, the null hypothesis $H_0 : mu = 6$ is rejected. The researcher concludes that the mean screen time for educational use is not 6 hours.]
#opt[2][Using a significance level, $alpha = 0.05$, the alternative hypothesis $H_A : mu = 0$ is accepted. The researcher concludes that the mean screen time for educational use is significantly less than 6 hours.]
#opt[3][Using a significance level, $alpha = 0.01$, the null hypothesis $H_0 : mu = 6$ is rejected. The researcher concludes that the mean screen time for educational use is not 6 hours.]
#opt[4][Using a significance level, $alpha = 0.01$, the alternative hypothesis $H_A : mu = 0$ is accepted. The researcher concludes that the mean screen time for educational use is significantly less than 6 hours.]
#opt[5][There is not enough information to make a decision about $H_0$.]
#opt[6][Don't know / No answer]

The correct answer is option 1.

this is because $p < alpha$ (0.03 < 0.05) so we reject the null hypothesis at significance level $alpha = 0.05$. which means that the screentime is not 6 hours.

#v(0.5em)
_Continue on page 13_

#pagebreak()

// ============================================================
// EXERCISE VI
// ============================================================

#exercise-box[Exercise VI]

#v(0.5em)

150 observations of a discrete stochastic variable are simulated in Python and the resulting values are visualized in the following empirical cumulative distribution (ecdf) plot:

#v(0.5em)
#align(center)[#image("figures/4.png")]
#v(0.5em)

#question-heading[Question VI.1 (10)]

Which of the following Python codes could generate the simulated observations?

#opt[1][`np.random.choice(a=[3,4,5,6,7,8,9], size=150, p=[1/7,1/7,1/7,1/7,1/7,1/7,1/7])`]
#opt[2][`stats.uniform.rvs(loc=3, scale=6, size=150)`]
#opt[3][`stats.uniform.rvs(loc=3, scale=9, size=100)`]
#opt[4][`np.random.choice(a=[3,4,6,7,8,9], size=150, p=[2/10,1/10,1/10,3/10,2/10,1/10])`]
#opt[5][`stats.norm.rvs(loc=6, scale=2, size=150)`]
#opt[6][Don't know / No answer]

The correct answer is option 4.

it looks like the chance for 3=20%, 4=10%, 6=10%, 7=30%, 8=20% and 9=10%.

which corresponds to the code in option 4, with p-values fitting to the percentages.

#v(0.5em)
_Continue on page 14_

#pagebreak()

// ============================================================
// EXERCISE VII
// ============================================================

#exercise-box[Exercise VII]

#v(0.5em)

A researcher is studying whether students' active participation in lectures is related to higher course satisfaction. In a small pilot study with $n = 15$ students, it was found that about 60% of students, who frequently participated in lectures, rated their overall course satisfaction as "high". Since the pilot study is relatively small, the estimate of 60% is related to a high degree of uncertainty. To plan a larger study for the next semester, the researcher wants to estimate the true proportion of "high course satisfaction", among students who frequently participate in lectures. The researcher would like to give a 95% confidence interval for this proportion, with the Margin of Error (ME) being only 0.05.

To answer the following questions you may need the quantile from the standard normal distribution: $z_(0.975) = 1.96$.

#question-heading[Question VII.1 (11)]

What minimum sample size $n$ is required for the follow-up study?

#opt[1][$n = 78$]
#opt[2][$n = 185$]
#opt[3][$n = 240$]
#opt[4][$n = 369$]
#opt[5][$n = 412$]
#opt[6][Don't know / No answer]

The correct answer is option 4.

using formula *7.13 Sample-size formula for the CI of a proportion.*:

$
  n = p(1 - p)(z_(1-alpha/2)/"ME")^2 = 60%(1 - 60%)(1.96/0.05)^2 = 368.79 approx 369
$

therefore $n = 369$ is the minimum sample size required for the follow-up study.

#question-heading[Question VII.2 (12)]

If no prior estimate of $p$ were available, what is then the required sample size?

#opt[1][$n = 138$]
#opt[2][$n = 185$]
#opt[3][$n = 240$]
#opt[4][$n = 385$]
#opt[5][$n = 420$]
#opt[6][Don't know / No answer]

Same as above, but using the formula for uknown $p$:
$
  1/4 (z_(1-alpha/2)/"ME")^2 = 1/4 (1.96/0.05)^2 = 384.16 approx 385
$

therefore the answer is option 4. as $n = 385$ is the required sample size when no prior estimate of $p$ is available.

#question-heading[Question VII.3 (13)]

Disregarding the results from the two previous questions, the researcher decides to conduct a study using a random sample of 200 students. Among the 200 students 50 were classified as "Active participants" and 150 were classified as "Not active participants". The researcher wants to compare the proportion of "high course satisfaction" between the two groups and obtains the following survey results:

#v(0.3em)
- *Active Participants:* 30 out of 50 reported "high course satisfaction"
- *Not active Participants:* 75 out of 150 reported "high course satisfaction"
#v(0.3em)

The researcher conducts a two sample proportions hypothesis test, comparing the proportion of students reporting "high course satisfaction" within the two groups. The researcher uses a significance level of $alpha = 0.05$.

Which of the following conclusions is correct (both the calculation and the conclusion must be correct)?

#opt[1][The calculated $z_(o b s) = 1.23 < 1.96$, so we fail to reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$]
#opt[2][The calculated $z_(o b s) = 2.01 > 1.96$, so we reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$ and conclude that there is a significant difference between the two groups.]
#opt[3][The calculated $z_(o b s) = 1.19 < 1.96$, so we fail to reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$]
#opt[4][The calculated $z_(o b s) = 1.23 < 1.96$, so we reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$ and conclude that there is a significant difference between the two groups.]
#opt[5][The calculated $z_(o b s) = 2.01 > 1.96$, so we fail to reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$.]
#opt[6][Don't know / No answer]

The correct answer is option 1. it can be calculated using the formula for the two sample proportions z-test:
$
  z_("obs") = frac((p_1 - p_2) - 0, sqrt(p(1 - p)(1/n_1 + 1/n_2))) = frac((0.6 - 0.5) - 0, sqrt(0.525(1 - 0.525)(1/50 + 1/150))) = 1.23
$

since $z_("obs") = 1.23 < 1.96$, we fail to reject the null hypothesis of equal proportions within the two groups $(H_0 : p_1 = p_2)$, leading to the conclusion that there is not a significant difference between the two groups.

#v(0.5em)
_Continue on page 16_

#pagebreak()

#question-heading[Question VII.4 (14)]

In another study the researcher wants to investigate if students' lecture participation level is associated with their exam results. This time the student participation level is classified as "High", "Moderate", or "Low" and the exam results are classified as "High", "Medium", or "Low". In a random sample of 200 students the participation level and exam results are recorded and presented in the table below:

#v(0.5em)

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    stroke: 0.5pt,
    inset: 8pt,
    table.header(table.cell(colspan: 1)[], table.cell(colspan: 4)[*Exam Result:*]),
    [*Lecture Participation:*],
    [*High*],
    [*Medium*],
    [*Low*],
    [*Total*],
    [High],
    [30],
    [15],
    [5],
    [50],
    [Moderate],
    [25],
    [30],
    [15],
    [70],
    [Low],
    [10],
    [20],
    [50],
    [80],
    [*Total*],
    [*65*],
    [*65*],
    [*70*],
    [*200*],
  )
]

#v(0.5em)

The researcher wants to test whether the distribution of exam results is independent from lecture participation level.

The desired significance level $alpha$ has been stored in Python in a variable called `"alpha"`. Which of the following Python statements correctly calculates the critical value for the relevant hypothesis test?

#opt[1][`critical_value = stats.chi2.ppf(1 - alpha/2, df=4)`]
#opt[2][`critical_value = stats.chi2.ppf(1 - alpha, df=4)`]
#opt[3][`critical_value = stats.f.ppf(1 - alpha, dfn=2, dfd=4)`]
#opt[4][`critical_value = stats.f.cdf(1 - alpha, dfn=2, dfd=6)`]
#opt[5][`critical_value = stats.t.cdf(1 - alpha/2, df=8)`]
#opt[6][Don't know / No answer]

The answer is option 2.

Step 1:
There's 2 categorical variables: Lecture Participation (3 levels) and Exam Result (3 levels). that always means it's a $chi^2$-test of independence.

Step 2:
$Chi^2$-tests are always upper-tailed (Right skewed), so we want the critical value at $1 - alpha$ (*NOT* $1 - alpha/2$).

This alone rules out options 1, 3, 4, and 5, leaving option 2 as the correct answer.

to double check, we can calculate the degrees of freedom for a $chi^2$-test of independence:
$
  "df" = (r - 1)(c - 1) = (3 - 1)(3 - 1) = (2)(2) = 4
$
where:
- $r$ = number of rows (Lecture Participation levels)
- $c$ = number of columns (Exam Result levels)

#v(0.5em)
_Continue on page 17_

#pagebreak()

// ============================================================
// EXERCISE VIII
// ============================================================

#exercise-box[Exercise VIII]

#v(0.5em)

Consider a multiple linear regression model written in the matrix formulation:

$ Y = X beta + epsilon, quad epsilon ~ N(0, sigma^2 I) $

for which the design matrix $X$ is as follows (here we only show the top rows of the matrix):

$ X = mat(
  1, x_1, (x_1)^3;1, x_2, (x_2)^3;1, x_3, (x_3)^3;1, x_4, (x_4)^3;1, x_5, (x_5)^3;1, x_6, (x_6)^3;1, x_7, (x_7)^3;1, x_8, (x_8)^3;1, x_9, (x_9)^3;1, x_(10), (x_(10))^3;dots.v, dots.v, dots.v;delim: "["
) $

#question-heading[Question VIII.1 (15)]

How can the same regression model be written (in non-matrix formulation)?

#opt[1][$y_i = beta_0 + beta_a a_i + epsilon_i, quad epsilon_i ~ N(0, sigma^2)$]
#opt[2][$y_i = beta_0 + beta_1 x_i + beta_2 x_i^2 + epsilon_i, quad epsilon_i ~ N(0, sigma^2)$]
#opt[3][$y_i = beta_0 + beta_1 x_i + 2 dot beta_2 x_i + epsilon_i, quad epsilon_i ~ N(0, sigma^2)$]
#opt[4][$y_i = beta_0 + beta_1 x_i + beta_2 x_i^3 + epsilon_i, quad epsilon_i ~ N(0, sigma^2)$]
#opt[5][$y_i = beta_0 + beta_1 (x_i + x_i^3), quad epsilon_i ~ N(0, sigma^2)$]
#opt[6][Don't know / No answer]

To find the non-matrix formulation, we can look at the columns of the design matrix $X$:
- The first column is all 1's, which corresponds to the intercept term $beta_0$.
- The second column is $x_i$, which corresponds to the term $beta_1 x_i$.
- The third column is $x_i^3$, which corresponds to the term $beta_2 x_i^3$.

Therefore, the regression model can be written as:
$
  y_i = beta_0 + beta_1 x_i + beta_2 x_i^3 + epsilon_i, quad epsilon_i ~ N(0, sigma^2)
$

which corresponds to option 4.

#question-heading[Question VIII.2 (16)]

The model parameters are estimated using the formula (in matrix formulation):

$ hat(beta) = (X^T X)^(-1) X^T Y $

Which statement is correct?

#opt[1][The vector $hat(beta)$ has four elements $(hat(beta)_0, hat(beta)_1, hat(beta)_2, hat(sigma)^2)$ and the values of these parameters are chosen such that the sum of squared residuals $(sum_(i=1)^n epsilon_i^2)$ is minimized.]
#opt[2][The vector $hat(beta)$ has three elements $(hat(beta)_0, hat(beta)_1, hat(beta)_2)$ and the values of these parameters are chosen such that the total sum of squares $(S S T = sum_(i=1)^n (y_i - overline(y))^2)$ is minimized.]
#opt[3][The vector $hat(beta)$ has three elements $(hat(beta)_0, hat(beta)_1, hat(beta)_2)$ and the values of these parameters are chosen such that the sum of squared residuals $(sum_(i=1)^n epsilon_i^2)$ is minimized.]
#opt[4][The vector $hat(beta)$ has three elements $(hat(beta)_0, hat(beta)_1, hat(beta)_2)$ and the values of these parameters are chosen such that the variance of x-values $(s_x^2)$ is maximized.]
#opt[5][The vector $hat(beta)$ has two elements $(hat(beta)_0, hat(beta)_1)$ and the values of these parameters are chosen such that $(X^T X)^(-1) X^T Y$ is minimized.]
#opt[6][Don't know / No answer]

the correct answer is option 3. 

The vector $hat(beta)$ has three elements $(hat(beta)_0, hat(beta)_1, hat(beta)_2)$ corresponding to the three columns of the design matrix $X$. The values of these parameters are chosen such that the sum of squared residuals $(sum_(i=1)^n epsilon_i^2)$ is minimized, which is the principle of least squares estimation.

#question-heading[Question VIII.3 (17)]

Let $n$ denote the number of observations in the data set, and further let $hat(sigma)^2$ denote the usual unbiased (or central) variance estimator for the regression model. The following number is now calculated:

$ Q = y^T (I - X(X^T X)^(-1) X^T) y $

What is the value of $Q$?

#opt[1][$(n - 1) hat(sigma)^2$]
#opt[2][$(n - 3) hat(sigma)^2$]
#opt[3][$(n - 2) hat(sigma)^2$]
#opt[4][$hat(sigma)^2$]
#opt[5][$n hat(sigma)^2$]
#opt[6][Don't know / No answer]

We count the number of parameters in the model: $beta_0$, $beta_1$, and $beta_2$ (3 parameters). The degrees of freedom for the residuals is then $n - 3$. The unbiased variance estimator is calculated as:

and since the formula is:
$
  (n-p) hat(sigma)^2
$

and $p$ is the number of collums in the design matrix $X$ (which is 3), we have:
$
  Q = (n - 3) hat(sigma)^2
$

#question-heading[Question VIII.4 (18)]

Now another model is considered:

$ Y = X_2 beta + epsilon, quad epsilon ~ N(0, sigma^2 I) $

The matrix $X_2$ is constructed such that:

$ H = X(X^T X)^(-1) X^T = X_2 (X_2^T X_2)^(-1) X_2^T = H_2 $

Which of the following statements is (in general) true?

#opt[1][The parameter estimates ($hat(beta)$) are equal in the two cases, but the fitted values ($hat(Y)$) might differ.]
#opt[2][The parameter estimates ($hat(beta)$) and the fitted values ($hat(Y)$) are equal in the two cases.]
#opt[3][The fitted values ($hat(Y)$) are the same for the two models, but the variance estimate ($hat(sigma)^2$) might differ.]
#opt[4][The fitted values ($hat(Y)$) are the same for the two models, but the parameter estimates ($hat(beta)$) might differ.]
#opt[5][The design matrices are equal ($X = X_2$) and hence all values (parameter estimates, fitted values, and variance) agree for the two models.]
#opt[6][Don't know / No answer]

from 9.8:

Same $H$ means that the fitted values $hat(Y)$ and variance ($hat(sigma)^2$) are the same for both models, leaving the parameter estimates $hat(beta)$ to potentially differ. So option 4 is correct.

#v(0.5em)
_Continue on page 20_

#pagebreak()

// ============================================================
// EXERCISE IX
// ============================================================

#exercise-box[Exercise IX]

#v(0.5em)

A researcher collects a random sample of size $n = 10$ from a normally distributed population. The sample standard deviation is $s = 4.2$.

To answer this question you may need the following quantiles from the $chi^2$-distribution with $nu$ degrees of freedom:

$ chi^2_(0.025)(nu = 9) = 2.70, quad chi^2_(0.975)(nu = 9) = 19.02 $

#question-heading[Question IX.1 (19)]

Find the 95% confidence interval for the population standard deviation $sigma$.

#opt[1][$[2.93, 7.25]$]
#opt[2][$[2.89, 7.67]$]
#opt[3][$[3.10, 7.38]$]
#opt[4][$[2.85, 7.80]$]
#opt[5][$[3.40, 8.20]$]
#opt[6][Don't know / No answer]

using $chi^2_(0.025)= 2.70$ we get the upper bound: $ sqrt(((10-1)4.2^2)/2.70) = 7.6681 approx 7.67 $

which corresponds to the upper bound of option 2 only.

for the lower bound, using $chi^2_(0.975) = 19.02$ we get: $ sqrt(((10-1)4.2^2)/19.02) = 2.8891 approx 2.89 $

so the confidence interval is $[2.89, 7.67]$, which corresponds to option 2.

#v(0.5em)
_Continue on page 21_

#pagebreak()

// ============================================================
// EXERCISE X
// ============================================================

#exercise-box[Exercise X]

#v(0.5em)

A fitness coach wants to test whether a new 4-week training program has a significant effect on resting heart rate. She measures the resting heart rates (in beats per minute) of 8 participants before and after the program.

#v(0.5em)

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    align: center,
    stroke: 0.5pt,
    inset: 7pt,
    table.header([*Resting heart rate:*], [], [], [], [], [], [], [], []),
    [*Before program:*],
    [78],
    [85],
    [90],
    [76],
    [88],
    [82],
    [79],
    [84],
    [*After program:*],
    [74],
    [80],
    [85],
    [72],
    [83],
    [78],
    [75],
    [80],
  )
]

#v(0.5em)

Assume the data follow normal distributions and the test is conducted at significance level $alpha = 0.05$.

#question-heading[Question X.1 (20)]

Assume the data has been read into Python in variables named `Before` and `After`.

Which Python command should be used to correctly test whether the program significantly changed the mean resting heart rate?

#opt[1][`stats.ttest_1samp(After, popmean=75)`]
#opt[2][`stats.ttest_ind(Before, After, equal_var=False)`]
#opt[3][`stats.ttest_1samp(Before - After, popmean=Before.mean()-After.mean())`]
#opt[4][`stats.ttest_1samp(Before - After, popmean=0)`]
#opt[5][`stats.ttest_ind(Before, After, equal_var=True)`]
#opt[6][Don't know / No answer]

The correct answer is option 4.

#v(0.5em)
_Continue on page 22_

#pagebreak()

// ============================================================
// EXERCISE XI
// ============================================================

#exercise-box[Exercise XI]

#v(0.5em)

A simulation has been carried out with the following Python code:

#block(fill: luma(245), inset: 10pt, radius: 3pt, width: 100%)[
```python
A = stats.uniform.rvs(size=500, loc=0, scale=5)
B = stats.norm.rvs(size=500, loc=10, scale=1)
C = A + B**2

plt.hist(C, density=True)
plt.show()
```
]

#v(0.5em)
#align(center)[#image("figures/5.png")]
#v(0.5em)

#question-heading[Question XI.1 (21)]

Which distributions do the stochastic variables A and B follow?

#opt[1][A follows a normal distribution with mean $mu_A = 0$ and standard deviation $sigma_A = 5$. B follows a normal distribution with mean $mu_B = 10$ and standard deviation $sigma_B = 1$.]
#opt[2][A follows a uniform distribution with mean $mu_A = 0$ and standard deviation $sigma_A = 5$. B follows a normal distribution with mean $mu_B = 10$ and standard deviation $sigma_B = 1$.]
#opt[3][A is uniformly distributed between $alpha_A = 0$ and $beta_A = 5$. B follows a normal distribution with mean $mu_B = 10$ and standard deviation $sigma_B = 1$.]
#opt[4][A is uniformly distributed between $alpha_A = -5$ and $beta_A = 5$. B follows a normal distribution with mean $mu_B = 10$ and standard deviation $sigma_B = 1$.]
#opt[5][The distributions of A and B cannot be determined from the Python code.]
#opt[6][Don't know / No answer]

The answer is option 3.

For the uniform distribution, `loc` = lower bound and $"loc" + "scale"$ = upper bound. therefore $alpha_A = 0$ and $beta_A = 5$.

and for the normal distribution, `loc` = mean and `scale` = standard deviation. therefore $mu_B = 10$ and $sigma_B = 1$.

this corresponds to option 3, which correctly describes the distributions of A and B.

#question-heading[Question XI.2 (22)]

From the simulation we see that $C = A + B^2$.

Say we perform a new simulation for which $mu_A = 2.5$, $sigma_A = 5\/sqrt(12)$, $mu_B = 10$ and $sigma_B = 1$.

Use error propagation to estimate $sigma_C$. Which of the following is correct?

#opt[1][$sigma_C = sqrt(5\/sqrt(12) + 20)$]
#opt[2][$sigma_C = 5\/sqrt(12) + 200$]
#opt[3][$sigma_C = sqrt(25\/12 + 400)$]
#opt[4][$sigma_C = sqrt(25 + 400)$]
#opt[5][$sigma_C = sqrt(25\/12)$]
#opt[6][Don't know / No answer]

To estimate $sigma_C$ using error propagation, we need to calculate the variance of $C$ based on the variances of $A$ and $B^2$.
$
  sigma_C^2 = sqrt(((partial C)/(partial A))^2 sigma_A^2 + (2 mu_B)^2 sigma_B^2) = sqrt(1^2 (5/sqrt(12))^2 + (2 dot 10)^2 dot 1^2) = sqrt(25/12 + 400)
$

this corresponds to option 3, which correctly estimates $sigma_C$ using error propagation.

#v(0.5em)
_Continue on page 24_

#pagebreak()

// ============================================================
// EXERCISE XII
// ============================================================

#exercise-box[Exercise XII]

#v(0.5em)

A researcher is planning an experiment to estimate the mean reduction in blood pressure when given a specific drug. From a pilot study, the estimated standard deviation in blood pressure is $sigma = 8$ mmHg. The researcher wants to detect a mean effect size (difference in average blood pressure) of $mu_0 - mu_1 = 5$ mmHg with a significance level of $alpha = 0.05$ and a power of $1 - beta = 0.80$.

The researcher plans to conduct the experiment on a sample of $n$ test persons, where each test person has their blood pressure measured both with and without the drug.

To solve this exercise you may need the following quantiles from a standard normal distribution:

$ z_(1-beta) = z_(0.80) = 0.84 quad "and" quad z_(1-alpha\/2) = z_(0.975) = 1.96 $

#question-heading[Question XII.1 (23)]

What is the required sample size needed for the experiment, given the information above?

#opt[1][$n = 40$]
#opt[2][$n = 20$]
#opt[3][$n = 41$]
#opt[4][$n = 5$]
#opt[5][$n = 21$]
#opt[6][Don't know / No answer]

To calculate the required sample size for the experiment, we can use the formula for the sample size in a paired t-test:

$
  n = (((z_(1-beta) + z_(1 - alpha/2))sigma)/(mu_0 - mu_1))^2 = (((0.84 + 1.96)8)/5)^2 = 20.0704 approx 21
$

therefore, the required sample size needed for the experiment is $n = 21$, which corresponds to option 5.

#v(0.5em)
_Continue on page 25_

#pagebreak()

// ============================================================
// EXERCISE XIII
// ============================================================

#exercise-box[Exercise XIII]

#v(0.5em)

To gain insight into the adoption of generative AI tools (such as ChatGPT or Copilot) for learning support, a university research team surveyed a pilot group of $n = 50$ students. Among these, $x = 30$ students report using such AI tools regularly to assist with study tasks such as writing, coding, or revising concepts.

To solve this exercise you may need one of the following quantiles:

From a standard normal distribution: $z_(0.95) = 1.64$ and $z_(0.975) = 1.96$.

From a t-distribution (with $nu$ degrees of freedom): $t_(0.95)(nu = 49) = 1.68$ and $t_(0.975)(nu = 49) = 2.01$.

#question-heading[Question XIII.1 (24)]

Which of the following is the correct 95%-confidence interval (given that one uses the method described in the book) for the true proportion ($p$) of students who regularly use generative AI tools for learning, and what are the assumptions behind the calculation (both confidence interval and argument must be true)?

#opt[1][The 95%-confidence interval for the true proportion is $[0.46; 0.74]$. The calculation is based on the assumption that the sample size ($n$) is large enough for the sample proportion ($hat(p)$) to be approximately normally distributed.]
#opt[2][The 95%-confidence interval for the true proportion is $[0.46; 0.74]$. The calculation is based on the assumption that the sample size ($n$) follows a Binomial distribution.]
#opt[3][The 95%-confidence interval for the true proportion is $[0.48, 0.72]$. The calculation is based on the assumption that the sample size ($n$) is large enough for the Central Limit Theorem to be valid.]
#opt[4][The 95%-confidence interval for the true proportion is $[0.48, 0.72]$. The calculation is based on the assumption that the sample size ($n$) is large enough for the t-distribution to be well approximated by a standard normal distribution.]
#opt[5][The 95%-confidence interval for the true proportion is $[0.48, 0.72]$. The calculation is based on the assumption that the sample size ($n$) follows a Binomial distribution.]
#opt[6][Don't know / No answer]

calculating the confidence interval using the formula for a confidence interval for a proportion:
$
  hat(p) = x/n = 30/50 = 3/5 \
  hat(p) plus.minus z_(1-alpha/2) sqrt((hat(p) (1- hat(p)))/(n)) = 3/5 plus.minus 1.96 sqrt((3/5)(1 - 3/5)/50) = [0.4642, 0.7357] approx [0.46, 0.74]
$

where we use $z_(1-alpha/2) = z_(0.975) = 1.96$ because we are looking for the 95% confidence interval implying $alpha = 0.05$, therefore $1 - 0.05/2 = 0.975$.

using this we can eliminate options 3, 4, and 5, which have the wrong confidence interval.

and then we can eliminate option 2, because only $x$ itself follows a Binomial distribution, but the sample size $n$ does not follow a Binomial distribution.

therefore, the correct answer is option 1, which correctly calculates the confidence interval and states the correct assumption behind the calculation.

#v(0.5em)
_Continue on page 26_

#pagebreak()

// ============================================================
// EXERCISE XIV
// ============================================================

#exercise-box[Exercise XIV]

#v(0.5em)

An insurance company receives claims according to a Poisson process with an intensity of two claims per month. This entails that claims arrive independently and that the waiting time between two consecutive claims follows an exponential distribution with a mean of half a month. Consequently, the number of claims the insurance company receives during a given month follows a Poisson distribution with a mean of two claims per month.

#question-heading[Question XIV.1 (25)]

What is the probability that the insurance company receives fewer than two claims during a given month?

#opt[1][$13.5%$]
#opt[2][$27.1%$]
#opt[3][$30.3%$]
#opt[4][$40.6%$]
#opt[5][$50.5%$]
#opt[6][Don't know / No answer]

$
  (2^0)/(0!) dot e^(-2) = 0.1353 \
  (2^1)/(1!) dot e^(-2) = 0.2706 \
  P(X < 2) = P(X = 0) + P(X = 1) = 0.1353 + 0.2706 = 0.4059 approx 40.6%
$

this corresponds to option 4, which correctly calculates the probability that the insurance company receives fewer than two claims during a given month.

#question-heading[Question XIV.2 (26)]

Which expression correctly calculates the probability that the waiting time between two consecutive claims exceeds one month?

#opt[1][$1 - exp(-1\/2)$]
#opt[2][$integral_0^1 2 exp(-2x) dif x$]
#opt[3][$integral_1^infinity 2 exp(-2x) dif x$]
#opt[4][$integral_1^infinity frac(1, 2) exp(-frac(1, 2) x) dif x$]
#opt[5][$integral_0^1 frac(1, 2) exp(-frac(1, 2) x) dif x$]
#opt[6][Don't know / No answer]

using 2.32 from notes:
$
  P(a < X <= b) = integral_a^b f(x) "d"x
$

our $f(x)$ is $lambda e^(-lambda x) = 2 dot e^(-2 x)$

substituting $lambda = 2$ and $a = 1$ and $b = infinity$ we get:
$
  P(X > 1) = P(1 < X <= infinity) = integral_1^infinity 2 exp(-2x) dif x
$

which corresponds to option 3, which correctly calculates the probability that the waiting time between two consecutive claims exceeds one month.

#v(0.5em)
_Continue on page 27_

#pagebreak()

// ============================================================
// EXERCISE XV
// ============================================================

#exercise-box[Exercise XV]

#v(0.5em)

Consider the two-way ANOVA model with four different "Treatments" and five different "Blocks":

$ Y_(i j) = mu + alpha_i + beta_j + epsilon_(i j), quad epsilon_(i j) ~ N(0, sigma^2), quad i in {1, ..., 4},\ j in {1, ..., 5}, $

where the errors $epsilon_(i j)$ are assumed to be independent, $i$ refers to the four different treatments and $j$ refers to the five different blocks.

A data set has been obtained, and the following averages have been calculated:

#v(0.5em)

#align(center)[
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #table(
      columns: (auto, auto),
      stroke: 0.5pt,
      inset: 7pt,
      [*Overall*],
      [31.5],
      [*Treatment 1*],
      [35.1],
      [*Treatment 2*],
      [29.4],
      [*Treatment 3*],
      [28.7],
      [*Treatment 4*],
      [32.8],
    )
  ], [
    #table(
      columns: (auto, auto),
      stroke: 0.5pt,
      inset: 7pt,
      [*Block 1*],
      [31.0],
      [*Block 2*],
      [32.0],
      [*Block 3*],
      [32.3],
      [*Block 4*],
      [30.3],
      [*Block 5*],
      [31.9],
    )
  ])
]

#v(0.5em)

Furthermore, the treatment sum of squares, $S S(T r)$, has been calculated to be 134.5 (here "Tr" refers to the treatments).

Moreover, let $hat(sigma)$ denote the model estimate of $sigma$.

#question-heading[Question XV.1 (27)]

What are the covariances $"Cov"(Y_(12), Y_(13))$ and $"Cov"(Y_(22), Y_(42))$ according to the model?

#opt[1][$"Cov"(Y_(12), Y_(13)) = 0$ and $"Cov"(Y_(22), Y_(42)) = 0$]
#opt[2][$"Cov"(Y_(12), Y_(13)) = 0$ and $"Cov"(Y_(22), Y_(42)) = beta_2$]
#opt[3][$"Cov"(Y_(12), Y_(13)) = alpha_1$ and $"Cov"(Y_(22), Y_(42)) = 0$]
#opt[4][$"Cov"(Y_(12), Y_(13)) = alpha_1$ and $"Cov"(Y_(22), Y_(42)) = beta_2$]
#opt[5][$"Cov"(Y_(12), Y_(13)) = mu + alpha_1$ and $"Cov"(Y_(22), Y_(42)) = mu + beta_2$]
#opt[6][Don't know / No answer]

due to *Model assumption:* $epsilon_(i j)$ independent $=> "Cov"(Y_(i j), Y_(m k)) = 0$ for all $(i,j) eq.not (m,k)$.

"The observations in an ANOVA model are always assumed independent. Therefore, the covariance between different observations is zero."

therefore, $"Cov"(Y_(12), Y_(13)) = 0$ and $"Cov"(Y_(22), Y_(42)) = 0$, which corresponds to option 1.

#question-heading[Question XV.2 (28)]

Testing the null hypothesis $H_0 : alpha_i = 0$ for $i = 1, ..., 4$ leads to which value of the F-statistic?

#opt[1][$F = display(frac(44.83, hat(sigma)^2))$]
#opt[2][$F = display(frac(44.83, hat(sigma)))$]
#opt[3][$F = display(frac(134.5, hat(sigma)^2))$]
#opt[4][$F = display(frac(538, hat(sigma)))$]
#opt[5][$F = display(frac(538, hat(sigma)^2))$]
#opt[6][Don't know / No answer]

from note:

$
  F_("Tr") = ("SS(Tr)"\/(k-1))/hat(sigma)^2 \
  F_("Bl") = ("SS(Bl)"\/(l-1))/hat(sigma)^2
$

we're given $"SS"("Tr") = 134.5$, $k = 4$ (number of treatments), and $n = 5 dot 4 = 20$ (total number of observations).

using this we can calculate the F-statistic for the treatments:
$
  F = ("SS(Tr)"/(k-1))/hat(sigma)^2 = (134.5/3)/hat(sigma)^2 = 44.83/hat(sigma)^2
$

which corresponds to option 1, which correctly calculates the F-statistic for testing the null hypothesis $H_0 : alpha_i = 0$ for $i = 1, ..., 4$.

#v(0.5em)
_Continue on page 29_

#pagebreak()

// ============================================================
// EXERCISE XVI
// ============================================================

#exercise-box[Exercise XVI]

#v(0.5em)

Let $X$ be a standard normal distributed random variable, and $Y_1 ~ chi^2(5)$ and $Y_2 ~ chi^2(5)$. It is assumed that $X$, $Y_1$ and $Y_2$ are independent.

#question-heading[Question XVI.1 (29)]

What is the mean of

$ Y = frac(Y_1, X^2 + Y_2) ? $

#opt[1][$E[Y] = display(5/4)$]
#opt[2][$E[Y] = display(6/4)$]
#opt[3][$E[Y] = display(6/4)$]
#opt[4][$E[Y] = display(5/6)$]
#opt[5][$E[Y] = display(5/3)$]

squaring $X$ gives us a $chi^2$-distributed variable with 1 degree of freedom, so we can rewrite $Y$ as:
$
  Y = (Y_1/5)/((X^2/1) + (Y_2/5)) = F(5, 6)
$

the mean of an $F$-distributed variable with $nu_1$ and $nu_2$ degrees of freedom is given by:
$
  E[F(nu_1, nu_2)] = frac(nu_2/(nu_2 - 2), nu_1/nu_2) = frac(6/(6 - 2), 5/6) = 5/4
$

which corresponds to option 1, which correctly calculates the mean of $Y$.

// NOTE: would never be able to do this in an exam. this was 100% ai solved. notes worth jack shit

#question-heading[Question XVI.2 (30)]

What is $a$, if the following must hold:

$ P lr((frac(X, sqrt(Y_1)) < a)) = 0.95 ? $

#opt[1][$a = display(frac(t_(0.95)(5), sqrt(4)))$]
#opt[2][$a = display(frac(t_(0.95)(5), sqrt(5)))$]
#opt[3][$a = display(frac(F_(0.95)(1, 5), sqrt(5)))$]
#opt[4][$a = display(frac(t_(0.95)(4), sqrt(5)))$]
#opt[5][$a = display(frac(F_(0.95)(1,4), sqrt(4)))$]

from 2.87 we know this is a $t$-distributed variable with $nu$ degrees of freedom, where $nu$ is the degrees of freedom of the denominator variable $Y_1$, which is 5. therefore, we get
$
  t_0.95 (5)
$

this eliminates options 3 and 5, which have the wrong distribution. and option 4 which has the wrong degrees of freedom.

knowing that we had 5 degrees of freedom we get $sqrt(5)$

making the full expression:
$
  a = frac(t_(0.95)(5), sqrt(5))
$

which corresponds to option 2, which correctly calculates $a$ such that $P lr((frac(X, sqrt(Y_1)) < a)) = 0.95$.

// Heavily AI assisted, would never be able to do this in an exam. notes worth updating.

#v(2em)

#align(center)[
  #text(size: 12pt, weight: "bold")[The exam is finished.]
]
