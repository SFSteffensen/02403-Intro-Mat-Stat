# Technical University of Denmark — Page 1 of 36 pages.

**Written examination:** 15. Dec. 2024
**Course name and number:** 02403 Introduction to Mathematical Statistics
**Duration:** 4 hours
**Aids and facilities allowed:** All, except access to Internet

The questions were answered by

(student number) &nbsp;&nbsp;&nbsp; (signature) &nbsp;&nbsp;&nbsp; (table number)

This exam consists of 30 questions of the "multiple choice" type, which are divided between 12 exercises. To answer the questions, you need to fill in the "multiple choice" form on exam.dtu.dk.

5 points are given for a correct "multiple choice" answer, and −1 point is given for a wrong answer. ONLY the following 5 answer options are valid: 1, 2, 3, 4, or 5. If a question is left blank or an invalid answer is entered, 0 points are given for the question. Furthermore, if more than one answer option is selected for a single question, which is in fact technically possible in the online system, 0 points are given for the question. The number of points needed to obtain a specific mark or to pass the exam is ultimately determined during censoring.

The final answers should be given by filling in and submitting the form. The table provided here is ONLY an emergency alternative. Remember to provide your student number if you do hand in on paper.

| Exercise | I.1 | I.2 | I.3 | II.1 | II.2 | III.1 | III.2 | IV.1 | IV.2 | V.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| Question | (1) | (2) | (3) | (4) | (5) | (6) | (7) | (8) | (9) | (10) |
| Answer | 1 | 2 | 3 | 2 | 2 | 4 | 2 | 4 | 5 | 5 |

| Exercise | V.2 | VI.1 | VI.2 | VI.3 | VI.4 | VI.5 | VII.1 | VII.2 | VIII.1 | IX.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| Question | (11) | (12) | (13) | (14) | (15) | (16) | (17) | (18) | (19) | (20) |
| Answer | 5 | 4 | 4 | 3 | 2 | 5 | 3 | 3 | 1 | 1 |

| Exercise | X.1 | X.2 | XI.1 | XI.2 | XII.1 | XII.2 | XII.3 | XII.4 | XII.5 | XII.6 |
|---|---|---|---|---|---|---|---|---|---|---|
| Question | (21) | (22) | (23) | (24) | (25) | (26) | (27) | (28) | (29) | (30) |
| Answer | 4 | 4 | 5 | 3 | 4 | 4 | 5 | 3 | 2 | 1 |

The exam paper contains 36 pages. Continue on page 2

---

**Using R in this exam:** This version is the R-version of the exam. A version using Python is also available.

Please be aware that certain characters ("~", "_", "^", etc.) may not transfer correctly if you choose to copy paste from the exam template. If you get error messages please check that all the special characters are correctly typed into your code (you may need to re-type manually).

**Multiple choice questions:** Note that in each question, one and only one of the answer options is correct. Furthermore, not all the suggested answers are necessarily meaningful. Always remember to round your own result to the number of decimals given in the answer options before you choose your answer. Also remember that there may be slight discrepancies between the result of the book's formulas and corresponding built-in functions in R.

---

## Exercise I

A team of researchers evaluate a deterministic simulation model by comparing the model simulations with experimental results. The researchers consider two factors: load (kg) and velocity (knots). The researchers propose the following model

$$Y_{ij} = \mu + \alpha_i + \beta_j + \varepsilon_{ij},$$

where the errors are assumed to be independent and normally distributed with $E[\varepsilon_{ij}] = 0$ and $V[\varepsilon_{ij}] = \sigma^2$. In the model, $Y_{ij}$ is the difference between the simulated and experimental results obtained using load level $i$ and velocity level $j$, and consequently the parameters $\alpha_i$ and $\beta_j$ refer to the load and velocity effects, respectively. The table below displays the obtained differences (experimental result minus simulation result):

| | 5 knots | 10 knots | 25 knots | 50 knots |
|---|---|---|---|---|
| 100 kg | -33.72 | -26.95 | 29.11 | -38.87 |
| 200 kg | -5.75 | -3.00 | -15.41 | 20.56 |
| 300 kg | 29.96 | -24.77 | -12.05 | 1.52 |
| 400 kg | -4.72 | 5.72 | 24.39 | 43.16 |
| 500 kg | -22.36 | 23.99 | -24.17 | 33.36 |

The data can be read into R using the code chunk:

```r
D <- data.frame(
  y=c( -33.72, -26.95, 29.11, -38.87,
       -5.75, -3.00, -15.41, 20.56,
       29.96, -24.77, -12.05, 1.52,
       -4.72, 5.72, 24.39, 43.16,
       -22.36, 23.99, -24.17, 33.36),
  knots = factor(rep(c(5,10,25,50),5)),
  load = factor(c(rep(100,4),rep(200,4),rep(300,4),rep(400,4),rep(500,4))))
```

### Question I.1 (1)

What is the parameter estimate $\hat\alpha_3$ (i.e. for load level "300 kg")?

1\* □ -1.335
2 □ -0.900
3 □ 0.374
4 □ 2.705
5 □ 17.138

----------------------------------- FACIT-BEGIN -----------------------------------

The researchers specify a two-way ANOVA model. The parameter estimates in such a model can be found using equations (8-38) through (8-40):

$$\hat\alpha_3 = \bar y_{3.} - \bar y = -1.335 - 0 = -1.335$$

which is calculated using the code:

```r
mu <- mean(D$y)
alpha <- tapply(D$y, D$load, mean) - mu
beta <- tapply(D$y, D$knots, mean) - mu
alpha[3]
##  300
## -1.335
```

------------------------------------ FACIT-END ------------------------------------

### Question I.2 (2)

According to the model, SS(load) is 2454.51, SS(velocity) is 1107.10, and the total sum of squares is 11867.74. What is the residual mean square (MSE)?

1 □ 415.3
2\* □ 692.2
3 □ 2076.5
4 □ 2768.7
5 □ 8306.1

----------------------------------- FACIT-BEGIN -----------------------------------

Theorem 8.20 shows that

```r
SS_load <- 4*sum(alpha^2)
SS_knots <- 5*sum(beta^2)
SS_total <- sum((D$y - mean(D$y))^2)
```

Equation (8-42) then yields that the residual sum of squares, SSE, is

```r
SSE <- SS_total - SS_load - SS_knots
```

and finally, since $k = 5$ and $l = 4$, the MSE is given by

```r
MSE <- SSE/((5-1)*(4-1))
MSE
## [1] 692.2
```

in accordance with the ANOVA table on page 374.

Alternatively, we can find it directly as

```r
anova(lm(y ~ load + knots, data=D))
## Analysis of Variance Table
##
## Response: y
##           Df Sum Sq Mean Sq F value Pr(>F)
## load       4   2455     614    0.89   0.50
## knots      3   1107     369    0.53   0.67
## Residuals 12   8306     692
```

------------------------------------ FACIT-END ------------------------------------

### Question I.3 (3)

The researchers discard the experimental results due to a technical error. When they repeat the experiment, they find the parameter estimates given below:

| Parameter | $\alpha_1$ | $\alpha_2$ | $\alpha_3$ | $\alpha_4$ | $\alpha_5$ |
|---|---|---|---|---|---|
| Estimate | 1.00 | 2.00 | 3.00 | 4.00 | 5.00 |

| Parameter | $\beta_1$ | $\beta_2$ | $\beta_3$ | $\beta_4$ | $\mu$ |
|---|---|---|---|---|---|
| Estimate | 0.25 | 1.00 | 3.13 | 5.00 | 0.00 |

What is MS(load) according to the new parameter estimates?

1 □ 13.75
2 □ 35.83
3\* □ 55.00
4 □ 220.00
5 □ The quantity cannot be determined without knowing the complete data set.

----------------------------------- FACIT-BEGIN -----------------------------------

Equation (8-41) shows how SS(load) can be derived as

$$SS(\text{load}) = l\sum_{i=1}^{k}\hat\alpha_i^2 = 4(1^2 + 2^2 + 3^2 + 4^2 + 5^2) = 220.$$

The calculations are performed with the code:

```r
alpha <- 1:5
SS_load <- 4*sum(alpha^2)
SS_load
## [1] 220
```

The load mean square is then given as

$$MS(\text{load}) = \frac{SS(\text{load})}{k - 1} = \frac{220}{5 - 1} = 55,$$

cf. the below calculations:

```r
MS_load <- SS_load/(5-1)
MS_load
## [1] 55
```

------------------------------------ FACIT-END ------------------------------------

Continue on page 6

---

## Exercise II

In a pass/fail course, a class of $n = 30$ students was evaluated, with the results presented below. A score of 0 indicates 'failed' and a score of 1 indicates 'passed'.

```
1 0 1 1 1 0 1 1 1 1
0 0 0 0 1 1 0 1 1 1
1 1 1 1 1 1 0 0 1 1
```

The data can be read into R using the code chunk:

```r
data <- c(1,0,1,0,0,1,1,0,1,1,0,1,1,1,1,0,1,1,1,0,0,1,1,0,1,1,1,1,1,1)
```

### Question II.1 (4)

What is the estimated probability of passing the course and its 95% confidence interval, assuming the usual assumptions are satisfied (Note: The result is based on the equation given in the textbook, but confidence intervals calculated using in-built functions in R, may give slightly different results).

1 □ $\hat p = 0.70$ and $[0.49, 0.91]$
2\* □ $\hat p = 0.70$ and $[0.54, 0.86]$
3 □ $\hat p = 0.76$ and $[0.57, 0.95]$
4 □ $\hat p = 0.70$ and $[0.61, 0.79]$
5 □ $\hat p = 0.76$ and $[0.51, 0.89]$

----------------------------------- FACIT-BEGIN -----------------------------------

Since in the sample $x = 21$ of $n = 285$, we use can use the formula

```r
x <- 21
n <- 30
phat <- x/n
phat + c(-1,1) * qnorm(0.975) * sqrt(phat*(1-phat)/n)
## [1] 0.536 0.864

# alternatively:
prop.test(21, 30, correct = FALSE)
##
## 1-sample proportions test without continuity correction
##
## data: 21 out of 30, null probability 0.5
## X-squared = 4.8, df = 1, p-value = 0.03
## alternative hypothesis: true p is not equal to 0.5
## 95 percent confidence interval:
##  0.5212 0.8334
## sample estimates:
##   p
## 0.7
```

------------------------------------ FACIT-END ------------------------------------

### Question II.2 (5)

What is the standard error of $\hat p$ if the "Plus 2" approach is used in the calculation of the confidence interval?

1 □ $\hat\sigma_{\hat p} = 0.0786$
2\* □ $\hat\sigma_{\hat p} = 0.0802$
3 □ $\hat\sigma_{\hat p} = 0.0868$
4 □ $\hat\sigma_{\hat p} = 0.0883$
5 □ $\hat\sigma_{\hat p} = 0.0918$

----------------------------------- FACIT-BEGIN -----------------------------------

```r
phat2 <- (x+2)/(n+4)
sqrt(phat2*(1-phat2)/(n+4))
## [1] 0.08023
```

------------------------------------ FACIT-END ------------------------------------

Continue on page 8

---

## Exercise III

In a study examining the difference in taste between regular and decaffeinated coffee, a taster has 4 cups containing coffee. Each cup contains either regular or decaffeinated coffee. The taster knows that there are two cups of each. The taster chose two cups at random.

### Question III.1 (6)

What is the probability that the taster selected regular coffee in one of the cups and decaffeinated coffee in the other one (not taking into account the order of which they were chosen)?

1 □ 1/4
2 □ 1/3
3 □ 1/2
4\* □ 2/3
5 □ 3/4

----------------------------------- FACIT-BEGIN -----------------------------------

The experiment is a case of drawing without replacement and therefore follows the hypergeometric distribution.

```r
# Let's define that selecting the number of cups of regular coffee, x = 1;
# the number of cups containing regular coffee is m = 2, the number of cups
# containing decaffeinated coffee n = 2, and the number of cups drawn is k = 2.
dhyper(x=1, m=2, n=2, k=2)
## [1] 0.6667

# Directly, the probability of getting two cups of regular coffee
(1/2*1/3)
## [1] 0.1667

# the probability of getting two cups of decaffeinated coffee
(1/2*1/3)
## [1] 0.1667

# Hence not getting either is
1 - 2 * (1/2*1/3)
## [1] 0.6667

# Or finally, just say that the first cup drawn doesn't matter
# and the in the second draw there is 2 out of 3 that fulfills the expression.
```

------------------------------------ FACIT-END ------------------------------------

### Question III.2 (7)

In another study examining the ability to detect the difference between regular and decaffeinated coffee, 30 participants are given a cup of each type to taste. Past studies suggest a 85% probability ($p = 0.85$) that individuals can detect the difference between regular and decaffeinated. Let $Y$ represent the number of participants out of 30 who can differentiate between the two types. What is the variance of $Y$?

1 □ $V(Y) = 5.37$
2\* □ $V(Y) = 3.83$
3 □ $V(Y) = 3.11$
4 □ $V(Y) = 2.79$
5 □ $V(Y) = 1.10$

----------------------------------- FACIT-BEGIN -----------------------------------

In this setup it is "drawing" with replacement, hence $X$ follows a binomial distribution

$$X \sim B(n = 30, p = 0.85)$$

and we can use Theorem ?? to find the variance

```r
n <- 30
p <- 0.85
n*p*(1-p)
## [1] 3.825
```

------------------------------------ FACIT-END ------------------------------------

Continue on page 10

---

## Exercise IV

The lifetime of a certain type of battery, measured in years, follows an exponential distribution with a mean of 50 years.

### Question IV.1 (8)

What is the probability that a battery will last less than 25 years?

1 □ $e^{-\frac{25}{50}}$
2 □ $1 - e^{-\frac{50}{25}}$
3 □ $e^{-\frac{50}{25}}$
4\* □ $1 - e^{-\frac{25}{50}}$
5 □ $e^{-\frac{25}{50}} - e^{-\frac{50}{25}}$

----------------------------------- FACIT-BEGIN -----------------------------------

To solve this problem, we'll use the exponential distribution formula with $\lambda = \frac{1}{\mu} = \frac{1}{50}$ and $x = 25$

$$P(X \le x) = 1 - e^{-\lambda x}$$

------------------------------------ FACIT-END ------------------------------------

### Question IV.2 (9)

Below are two plots: one is a normal distribution CDF and the other is a uniform distribution CDF.

> **[Figure description:** Two side-by-side CDF plots, both with x-axis from −10 to 10 and y-axis $F(x)$ from 0.0 to 1.0.
> **Plot A** shows a smooth S-shaped (sigmoid) curve that rises gradually, passing through $F(x)=0.5$ near $x=0$ and flattening toward 1.0 around $x=10$ — characteristic of a normal CDF centered at 0 with moderate spread.
> **Plot B** shows a piecewise-linear curve: flat at 0 until about $x=1$, then a steep straight-line rise to 1.0 by about $x=3$, then flat at 1.0 — characteristic of a uniform CDF on $[1,3]$.]**

One of the statements is correct, judging from the plots, which one is that?

1 □ Plot A is a uniform distribution CDF with $a = 3$ and $b = 1$. Plot B is a normal distribution CDF with $\mu = -5$ and $\sigma = 10$.
2 □ Plot A is a uniform distribution CDF with $\mu = -5$ and $\sigma = 10$. Plot B is a normal distribution CDF with $a = 3$ and $b = 1$.
3 □ Plot A is a normal distribution CDF with $\mu = -5$ and $\sigma = 10$. Plot B is a uniform distribution CDF with $a = 3$ and $b = 1$.
4 □ Plot A is a normal distribution CDF with $\mu = 7$ and $\sigma = 1$. Plot B is a uniform distribution CDF with $a = -5$ and $b = 5$.
5\* □ Plot A is a normal distribution CDF with $\mu = 0$ and $\sigma = 3$. Plot B is a uniform distribution CDF with $a = 1$ and $b = 3$.

----------------------------------- FACIT-BEGIN -----------------------------------

Plot A is clearly the normal CDF, since it's smooth. Plot B reveals that $a = 1$ and $b = 3$, since that's the two points of the uniform CDF where a change in the slope occurs.

------------------------------------ FACIT-END ------------------------------------

Continue on page 12

---

## Exercise V

In an agricultural study, researchers are investigating the effectiveness of two different fertilizers, A and B, on increasing crop yield. They randomly select 20 plots of land and apply Fertilizer A to 10 plots and Fertilizer B to the remaining 10 plots. After the harvest, they record the yield (in units "bushels per acre" = 6.73 g/m²) from each plot. The researchers want to determine if there is a significant difference in the mean yield between the two fertilizers.

Yield data is recorded as follows:

```
Fertilizer A : 45, 48, 50, 42, 47, 49, 43, 44, 46, 41
Fertilizer B : 51, 53, 52, 50, 55, 48, 54, 49, 56, 52
```

All the measurements are assumed to be independent and the yield populations follow normal distributions.

### Question V.1 (10)

What is the test statistic and 99% confidence interval for the difference in mean crop yield between fertilizers (fertilizer A minus fertilizer B) (both results must be correct)?

1 □ -5.17, [-8.39, -4.61]
2 □ -4.17, [-8.68, -4.32]
3 □ -5.76, [-9.14, -3.85]
4 □ -5.17, [-9.15, -3.85]
5\* □ -5.17, [-10.13, -2.87]

----------------------------------- FACIT-BEGIN -----------------------------------

Read fertilizer yield data

```r
fertilizer_A <- c(45, 48, 50, 42, 47, 49, 43, 44, 46, 41)
fertilizer_B <- c(51, 53, 52, 50, 55, 48, 54, 49, 56, 52)
```

Perform two-sample t-test

```r
result <- t.test(fertilizer_A, fertilizer_B, conf.level=0.99)
c(result$statistic, result$conf.int)
##       t
## -5.166 -10.132 -2.868
```

------------------------------------ FACIT-END ------------------------------------

### Question V.2 (11)

Denoting the mean yield for fertilizer A as $\mu_A$ and the mean yield for fertilizer B as $\mu_B$, what should be the conclusion for the following null hypothesis

$$H_0 : \mu_A - \mu_B = 0$$

on significance level $\alpha = 0.05$ (both conclusion and argument must be correct)?

1 □ The null hypothesis is accepted, since the p-value is 0.23.
2 □ The null hypothesis is rejected, since the p-value is 0.0023.
3 □ The null hypothesis is rejected, since the 95% confidence interval contains zero.
4 □ The null hypothesis is rejected, since the 99% confidence interval contains zero.
5\* □ The null hypothesis is rejected, since the 95% confidence interval does not contain zero.

----------------------------------- FACIT-BEGIN -----------------------------------

The arguments of the first four are incorrect based on the theories for rejection rules and therefore the correct answer is "The null hypothesis is rejected, since the 95% confidence interval does not contain zero."

------------------------------------ FACIT-END ------------------------------------

Continue on page 14

---

## Exercise VI

A toy shop sells marbles made of glass. The marbles are approximately the same size with mean diameter (D) 1 cm, but the variance is only stated in terms of weight (W): $\sigma_W^2 = 0.03^2$. The marble weights follow a normal distribution.

The expression relating weight to diameter is

$$W = \rho \cdot \frac{4}{3} \cdot \pi \cdot \left(\frac{D}{2}\right)^3$$

and therefore the expression relating diameter to weight is

$$D = 2\left(\frac{3W}{4\pi\rho}\right)^{1/3}$$

Where $\rho = 2.6$ g/cm³ is the density (equal to the density of glass). You can use $\pi = 3.14$, and $\mu_W = W(\mu_D)$.

### Question VI.1 (12)

A customer wants to know the standard deviation of the diameter of the marbles ($\sigma_D$). Luckily, the customer has studied error propagation and knows how to approximate $\sigma_D$ from $\sigma_W$. What is the standard deviation of the diameters of the marbles?

1 □ $\sigma_D = 0.006$ cm
2 □ $\sigma_D = 0.086$ cm
3 □ $\sigma_D = 0.015$ cm
4\* □ $\sigma_D = 0.007$ cm
5 □ $\sigma_D = 0.04$ cm

----------------------------------- FACIT-BEGIN -----------------------------------

$\sigma_d$ can be calculated either using error propagation or by simulation.

```r
mean_weight <- 2.6 * 4/3 * pi * (1/2)^3
deriv <- 2 * 1/3 * ( (3*mean_weight)/(4*pi*2.6) )^(-2/3) * 3/(4*pi*2.6)
sqrt(deriv^2 * 0.03^2)
## [1] 0.007346

# alternatively simulate
marbles_weight <- rnorm(1000000, mean=mean_weight, sd = 0.03)
marbles_vol <- marbles_weight/2.6
marbles_dia <- 2* (3*(marbles_vol)/(4*pi))^(1/3)
sd(marbles_dia)
## [1] 0.007357
```

------------------------------------ FACIT-END ------------------------------------

### Question VI.2 (13)

Another brand of marbles has mean diameter of 2 cm, $\sigma_W^2 = 0.4^2$ and density $\rho = 2.6$ g/cm³. The weight of each marble may be calculated as $W = \rho \cdot \frac{4}{3} \cdot \pi \cdot \left(\frac{D}{2}\right)^3$. Which set of histograms matches the marbles from this other brand?

> **[Figure description:** Five candidate answer plots (A–E), each consisting of a pair of histograms (a "Weight" histogram and a "Diameter" histogram), all with frequency counts on the y-axis (0 to ~150000).
> - **Plot A:** Weight histogram centered around ~11 with wide spread across roughly 6–16; Diameter histogram centered around 2.0, very narrow (range ~1.8–2.2).
> - **Plot B:** Weight histogram centered around ~11, narrow; Diameter histogram centered around 1.0 (range ~0.8–1.2).
> - **Plot C:** Weight histogram centered around ~11, narrow; Diameter histogram centered around 1.0 (range ~0.8–1.2).
> - **Plot D:** Weight histogram centered around ~11, narrow (consistent with sd ≈ 0.4); Diameter histogram centered around 2.0 (range ~1.8–2.2), moderate narrow spread. **← correct match.**
> - **Plot E:** Weight histogram centered around ~5.5 (range ~3–8); Diameter histogram centered around 2.0 (range ~1.8–2.2).]**

1 □ Plot A
2 □ Plot B
3 □ Plot C
4\* □ Plot D
5 □ Plot E

----------------------------------- FACIT-BEGIN -----------------------------------

The marbles with mean diameter of 2 cm, will have a mean weight of 11 g. So the distribution of weights should be centered around 11 and have a width corresponding to sd = 0.4. This is only true for plot B, C and D. The distribution of diameters should be centered around 2 cm - this leaves only plot D as an appropriate answer. We could also check the width of the distribution of diameters - this is easily done by simulation, which gives sd = 0.025 (corresponding to the width seen in plot D).

------------------------------------ FACIT-END ------------------------------------

### Question VI.3 (14)

The toy shop gets new marbles delivered every month. Sometimes they find that some of the marbles are broken. The owner of the toy shop decides to take note of the deliveries that contain broken marbles. The time (measured in months) between deliveries containing broken marbles is stored in the variable x.

```r
x <- c(13, 4, 1, 17, 11, 2, 24, 25, 8, 4, 7, 7, 5, 6, 2, 13, 16, 3, 9, 11)
```

Use the book's definition of sample quantiles to determine the IQR ("Inter Quartile Range").

1 □ IQR = 4
2 □ IQR = 7.5
3\* □ IQR = 9
4 □ IQR = 11
5 □ IQR = 12

----------------------------------- FACIT-BEGIN -----------------------------------

The IQR is the difference between the 0.25 and 0.75 sample quantiles, here computed using Definition ??:

```r
quantile(x, 0.75, type = 2) - quantile(x, 0.25, type = 2)
## 75%
##   9
```

------------------------------------ FACIT-END ------------------------------------

### Question VI.4 (15)

The owner of the toy shop decides that they will stop buying marbles from the given vendor if the incidents of deliveries with broken marbles becomes too frequent. Without assuming any distribution of time between deliveries with broken marbles, the owner of the toy shop makes a non-parametric 95% bootstrap confidence interval for the median time between such events. Which of the following R codes calculates this confidence interval for the median correctly?

1 □
```r
simsamples <- replicate(10000, sample(x, replace = TRUE))
quantile(apply(simsamples, 2, median), c(0.05, 0.95), type = 2)
```
2\* □
```r
simsamples <- replicate(10000, sample(x, replace = TRUE))
quantile(apply(simsamples, 2, median), c(0.025, 0.975))
```
3 □
```r
simsamples <- replicate(10000, rexp(length(x), 1/mean(x)))
quantile(apply(simsamples, 2, median), c(0.05, 0.95))
```
4 □
```r
simsamples <- replicate(10000, rexp(length(x), 1/mean(x)))
quantile(apply(simsamples, 2, median), c(0.025, 0.975))
```
5 □
```r
simsamples <- replicate(10000, sample(x, replace = TRUE))
quantile(apply(simsamples, 2, median), c(0.005, 0.995))
```

----------------------------------- FACIT-BEGIN -----------------------------------

In order to obtain the desired interval, a large number of medians must be simulated. Subsequently, the endpoints of the confidence interval are chosen as the 0.025 and 0.975 sample quantiles of the simulated medians.

------------------------------------ FACIT-END ------------------------------------

### Question VI.5 (16)

After some time the vendor makes an effort to increase the quality of the marbles by manually removing bags with broken marbles. Again the owner of the toy shop decides to take note of the deliveries that contain broken marbles. The time (measured in months) between deliveries containing broken marbles is stored in the variable y.

```r
y <- c(3,2,1,14,23,38,25,4,14,28,6,34,5,25,17,20,11,19,4,9)
```

Hereafter the following calculations are made in order to test whether the new effort to increase quality has made any difference:

```r
simXsamples <- replicate(10000, rexp(length(x), 1/mean(x)))
simYsamples <- replicate(10000, rexp(length(y), 1/mean(y)))
simDiff <- apply(simXsamples, 2, median) - apply(simYsamples, 2, median)

quantile(simDiff, c(0.005,0.995), type=2)
##   0.5%  99.5%
## -15.45   5.27

quantile(simDiff, c(0.025,0.975), type=2)
##    2.5%   97.5%
## -12.459   2.992

quantile(simDiff, c(0.05,0.95), type=2)
##      5%     95%
## -10.846   1.937
```

Which of the following statements is correct?

1 □ The analysis makes no assumptions about the distributions of x and y. At $\alpha = 1\%$ significance level it may be concluded that there is no significant difference in medians.
2 □ The analysis assumes that both x and y are normally distributed. At $\alpha = 5\%$ significance level it may be concluded that there is no significant difference in medians.
3 □ The analysis assumes that both x and y are exponentially distributed. At $\alpha = 1\%$ significance level it may be concluded that there is a significant difference in medians.
4 □ The analysis makes no assumptions about the distributions of x and y. At $\alpha = 5\%$ significance level it may be concluded that there is a significant difference in medians.
5\* □ None of the statements above are correct.

----------------------------------- FACIT-BEGIN -----------------------------------

The simulations assume that the observations in both samples are exponentially distributed. As the 95% parametric bootstrap confidence interval for the difference between the medians contains 0, no significant difference is established. There is no answer stating that!

------------------------------------ FACIT-END ------------------------------------

Continue on page 20

---

## Exercise VII

Suppose we have collected exam scores from two groups:

```
Group 1: 82, 91, 85, 89, 88
Group 2: 76, 84, 80, 82, 83
```

We assume that the exam scores follow normal distributions with equal variances. Additionally, we assume that the exam scores can be considered independent and identically distributed (i.i.d.), within each group.

### Question VII.1 (17)

What is the estimate of the pooled variance?

1 □ 9.00
2 □ 27.10
3\* □ 11.25
4 □ 10.00
5 □ 8.00

----------------------------------- FACIT-BEGIN -----------------------------------

Apply Method 3.52

```r
g1 <-c(82, 91, 85, 89, 88)
g2 <-c(76, 84, 80, 82, 83)
s1= sd(g1)
s2= sd(g2)
n1 <- length(g1)
n2 <- length(g2)
sp2 = (((n1-1)*s1^2) + ((n2-1)*s2^2))/(n1+n2-2)
sp2
## [1] 11.25
```

------------------------------------ FACIT-END ------------------------------------

### Question VII.2 (18)

What is the minimum number of observations required in each group (same number of observations in both groups) to achieve a power of 99% for detecting a difference in means of at least 4 between the two groups, assuming the variance is 20 (equal variances in both groups) and a significance level of 1%?

1 □ At least 56 (or 55, depending on calculation method)
2 □ At least 39 (or 38, depending on calculation method)
3\* □ At least 62 (or 61, depending on calculation method)
4 □ At least 32 (or 31, depending on calculation method)
5 □ At least 82 (or 79, depending on calculation method)

----------------------------------- FACIT-BEGIN -----------------------------------

```r
variance <- 20
power.t.test(delta=4, sd=sqrt(variance), sig.level=0.01, power=0.99)
##
##      Two-sample t test power calculation
##
##               n = 61.77
##           delta = 4
##              sd = 4.472
##       sig.level = 0.01
##           power = 0.99
##     alternative = two.sided
##
## NOTE: n is number in *each* group
```

and round up.

------------------------------------ FACIT-END ------------------------------------

Continue on page 23

---

## Exercise VIII

In preparation for a conference, organizers need to plan coffee breaks efficiently. They estimate that the number of attendees needing coffee will follow a Poisson distribution and that, on average, 200 attendees will need coffee every hour. The organizers set up enough coffee stations to serve 240 attendees per hour.

### Question VIII.1 (19)

What is the probability that, during a randomly selected hour, the number of attendees needing coffee exceeds the capacity?

1\* □ 0.0027
2 □ 0.023
3 □ 0.11
4 □ 0.24
5 □ 0.0045

----------------------------------- FACIT-BEGIN -----------------------------------

Let $X$ represent the number of guests arriving at the coffee stations in a randomly selected hour, then $X \sim \text{Pois}(200)$. The capacity is 240 per hour, hence we need to calculate $P(X > 240) = 1 - P(X \le 240)$:

```r
1 - ppois(q=240, lambda=200)
## [1] 0.002669
```

------------------------------------ FACIT-END ------------------------------------

Continue on page 24

---

## Exercise IX

Let $X_i \sim N(0, \sigma^2)$ be i.i.d. random variables and define

$$Q = \frac{1}{n}\sum_{i=1}^{n} X_i^2.$$

### Question IX.1 (20)

For $0 < \alpha < 1$, for what $q$ do we have $P(Q > q) = 1 - \alpha$?

1\* □ $q = \dfrac{\sigma^2}{n}\chi_\alpha^2$, where $\chi_\alpha^2$ is the $\alpha$ quantile of a $\chi^2$-distribution with $n$ degrees of freedom.
2 □ $q = \dfrac{\sigma^2}{n}\chi_{1-\alpha}^2$, where $\chi_{1-\alpha}^2$ is the $(1-\alpha)$ quantile of a $\chi^2$-distribution with $n$ degrees of freedom.
3 □ $q = \dfrac{\sigma^2}{n-1}\chi_\alpha^2$, where $\chi_\alpha^2$ is the $\alpha$ quantile of a $\chi^2$-distribution with $n$ degrees of freedom.
4 □ $q = \dfrac{\sigma^2}{1-n}\chi_{1-\alpha}^2$, where $\chi_{1-\alpha}^2$ is the $(1-\alpha)$ quantile of a $\chi^2$-distribution with $(n-1)$ degrees of freedom.
5 □ $q = \dfrac{\sigma^2}{n}\chi_\alpha^2$, where $\chi_\alpha^2$ is the $\alpha$ quantile of a $\chi^2$-distribution with $(n-1)$ degrees of freedom.

----------------------------------- FACIT-BEGIN -----------------------------------

First note that

$$\frac{n}{\sigma^2}Q \sim \chi^2(n) \tag{1}$$

and therefore

$$P(Q > q) = P\left(\frac{n}{\sigma^2}Q > \frac{n}{\sigma^2}q\right) \tag{2}$$

$$= 1 - F\left(\frac{n}{\sigma^2}q\right) \tag{3}$$

and hence we need

$$F\left(\frac{n}{\sigma^2}q\right) = \alpha \tag{4}$$

solving for $q$ gives

$$q = \frac{\sigma^2}{n}F^{-1}(\alpha) \tag{5}$$

and since $F^{-1}(\alpha) = \chi_\alpha^2$ and the degrees of freedom is $n$ the correct answer is 1.

------------------------------------ FACIT-END ------------------------------------

Continue on page 25

---

## Exercise X

A technology company has recorded its monthly sales figures over a period of three years (36 months). The monthly sales numbers are summarized in the below table showing the average monthly sales and the sample standard deviation of the monthly sales for each of the three years.

| Year | 2021 | 2022 | 2023 |
|---|---|---|---|
| Average monthly sales (M DKK) | 391.2 | 402.5 | 429.4 |
| Standard deviation of monthly sales (M DKK) | 22.3 | 27.5 | 26.7 |

The engineers at the company then formulates a one-way ANOVA model for the data using the monthly sales as the response variable and the year as the treatment.

### Question X.1 (21)

In the ANOVA model, what is the residual mean square (MSE)?

1 □ 25.50
2 □ 162.56
3 □ 407.70
4\* □ 655.48
5 □ 1966.43

----------------------------------- FACIT-BEGIN -----------------------------------

The engineers apply Theorem 8.4 to calculate the residual mean square. In this question, there are $n = 36$ observations (months) equally divided into $k = 3$ groups (years), and Equation (8-14) thus becomes:

$$MSE = \frac{(n_1 - 1)s_1^2 + (n_2 - 1)s_2^2 + (n_3 - 1)s_3^2}{n - k} = \frac{11 \cdot 22.3^2 + 11 \cdot 27.5^2 + 11 \cdot 26.7^2}{36 - 3} = 655.48.$$

These calculations are performed with the code:

```r
MSE <- (11*22.3^2+11*27.5^2+11*26.7^2)/(36-3)
MSE
## [1] 655.5
```

------------------------------------ FACIT-END ------------------------------------

### Question X.2 (22)

The engineers pre-planned to calculate pairwise confidence intervals for $\mu_{2022}-\mu_{2021}$ and $\mu_{2023}-\mu_{2022}$ using an overall significance level of 10%, where $\mu_i$ refers to the mean monthly sales for year $i$. Which quantile from the t-distribution must be used in the calculations of the confidence intervals?

1 □ The 90% quantile of the t-distribution with 33 degrees of freedom
2 □ The 95% quantile of the t-distribution with 33 degrees of freedom
3 □ The 95% quantile of the t-distribution with 34 degrees of freedom
4\* □ The 97.5% quantile of the t-distribution with 33 degrees of freedom
5 □ The 97.5% quantile of the t-distribution with 34 degrees of freedom

----------------------------------- FACIT-BEGIN -----------------------------------

The engineers use Method 8.9 to calculate the pairwise confidence intervals. Since two confidence intervals are calculated, the Bonferroni corrected significance level is given as

$$\alpha_{\text{Bonferroni}} = \alpha/M = 0.10/2 = 0.05,$$

where $M$ refers to the number of confidence intervals. Therefore, the engineers must use the $1 - \alpha_{\text{Bonferroni}}/2 = 0.975$ quantile of the t-distribution with $n - k = 36 - 3 = 33$ degrees of freedom.

------------------------------------ FACIT-END ------------------------------------

Continue on page 27

---

## Exercise XI

To study crime in Denmark, researchers are interested in the number of individuals placed in pretrial detention after their arrest. These figures are recorded and available through Statistics Denmark. The annual counts from 2015 to 2022 are categorized into three age groups: "Young" (ages 15-29), "Mid-age" (ages 30-39), and "Old" (ages 40 and above). The data is read into R using the following code:

```r
tbl <- matrix(c(2048, 1072, 821,
                2208, 998, 836,
                2359, 1092, 853,
                2138, 1093, 880,
                1984, 935, 799,
                1777, 872, 860,
                1604, 818, 729,
                1564, 943, 753), ncol=3, byrow=TRUE)
row.names(tbl) <- c("2015","2016","2017","2018","2019","2020","2021","2022")
colnames(tbl) <- c("Young","Midage","Old")
```

### Question XI.1 (23)

Consider the null hypothesis that the age distribution of individuals placed in pretrial detention does not change over the years. What is the result and conclusion of the appropriate test (both argument and conclusion must be correct)?

1 □ The p-value is 0.24 and the conclusion is that there is no significant change in distribution across the years.
2 □ The p-value is $0.24 \cdot 10^{-10}$ and the conclusion is that there is a significant change in distribution in every year across all years.
3 □ The p-value is $0.24 \cdot 10^{-10}$ and the conclusion is that there is a significant change in distribution at least in one of the years.
4 □ The p-value is $4.1 \cdot 10^{-10}$ and the conclusion is that there is a significant change in distribution in every year across all years.
5\* □ The p-value is $4.1 \cdot 10^{-10}$ and the conclusion is that there is a significant change in distribution at least in one of the years.

----------------------------------- FACIT-BEGIN -----------------------------------

```r
chisq.test(tbl, correct=FALSE)
##
## Pearson's Chi-squared test
##
## data: tbl
## X-squared = 74, df = 14, p-value = 4e-10
```

------------------------------------ FACIT-END ------------------------------------

### Question XI.2 (24)

Under the null hypothesis of no change in distribution, what is the expected number of individuals placed in pretrial detention in the "Young" category if the total number of such placements in a specific year is 3000?

1 □ 978
2 □ 1364
3\* □ 1566
4 □ 1960
5 □ 2048

----------------------------------- FACIT-BEGIN -----------------------------------

Under the null hypothesis the estimate of the proportion in the Young category is found by summing over all the years, which is then multiplied with the 3000 for that year:

```r
sum(tbl[ ,1]) / sum(tbl) * 3000
## [1] 1566
```

------------------------------------ FACIT-END ------------------------------------

Continue on page 29

---

## Exercise XII

The figure below shows the average global temperature anomaly, which is the temperature minus average over the period 1900-2000 in [°C] as a function of time. The period is the years 1977 to 2023 (the x-axis is Year-2000).

> **[Figure description:** A scatter plot of temperature anomaly $y$ (°C, axis 0.0 to ~1.2) versus $x$ = Year−2000 (axis −20 to ~23). The points show a clear upward linear trend: values near 0.1–0.3 at the left ($x \approx -23$) rising to roughly 1.0–1.3 at the right ($x \approx 23$), with scatter around the trend.]**

As a first approach a simple linear regression model

$$Y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$$

is fitted to the data. In the model $Y_i$ is the temperature anomaly and $x_i$ is the year (minus 2000), of observation $i$. The result is given below:

```r
summary(lm(y ~ x, data = dat))
##
## Call:
## lm(formula = y ~ x, data = dat)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -0.3059 -0.0849 -0.0180  0.0855  0.4260
##
## Coefficients:
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept)   0.6015      0.023  26.639 3.420e-29 ***
## x             0.0195      0.002  11.734 2.758e-15 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.1548 on 45 degrees of freedom
## Multiple R-squared:  0.754, Adjusted R-squared:  0.748
## F-statistic: 138 on 1 and 45 DF, p-value: 2.76e-15
```

### Question XII.1 (25)

Which of the following statements about the assumptions of the model is not correct?

1 □ $\varepsilon_i \sim N(0, \sigma^2)$.
2 □ $\varepsilon_i$ and $\varepsilon_j$ are independent for $i \neq j$.
3 □ $V(\varepsilon_i) = V(\varepsilon_j)$ for all $(i, j)$.
4\* □ $Y_i$ and $\varepsilon_i$ are independent.
5 □ $Y_i \sim N(\beta_0 + \beta_1 x_i, \sigma^2)$.

----------------------------------- FACIT-BEGIN -----------------------------------

The assumption is $\varepsilon_i \sim N(0, \sigma^2)$ and i.i.d., hence Answer 1 is correct, Answer 2 is the first "i" in i.i.d, Answer 3 just state that the variance is the same for all $i$, hence also correct.

For answer 4 consider

$$\text{Cov}(Y_i, \varepsilon_i) = \text{Cov}(\beta_0 + \beta_1 x_i + \varepsilon_i, \varepsilon_i) = \text{Cov}(\varepsilon_i, \varepsilon_i) = V(\varepsilon_i) > 0 \tag{6}$$

hence $Y_i$ and $\varepsilon_i$ are not independent.

For Answer 5, note that if $\varepsilon_i \sim N(0, \sigma^2)$ then $\varepsilon_i + a \sim N(a, \sigma^2)$ and hence 5 is also true.

------------------------------------ FACIT-END ------------------------------------

### Question XII.2 (26)

What is the conclusion (using significance level $\alpha = 0.05$) for the relationship between time (in years) and temperature based on the model (both conclusion and argument must be correct)?

1 □ The temperature changes significantly with time (x), since $0.0195 < 0.05$.
2 □ The temperature changes significantly with time (x), since $0.002 < 0.05$.
3 □ Time (x) have a significant effect on the temperature, since $0.002 < 0.05$.
4\* □ The temperature changes significantly with time (x), since $2.758 \cdot 10^{-15} < 0.05$.
5 □ The temperature is a function of time (x), since $0.0195 < 0.05$.

----------------------------------- FACIT-BEGIN -----------------------------------

The answer where the p-value is compared to the significance level is the correct argument, and since it's lower the $\beta_1$ is significant different from zero, hence relationship is significant.

------------------------------------ FACIT-END ------------------------------------

### Question XII.3 (27)

The model can be written in matrix–vector notation as

$$Y = X\beta + \varepsilon; \quad \varepsilon \sim N(0, \sigma^2 I)$$

where the first column in $X$ is a vector of ones and the second column is the vector $[-23, -22, ..., 22, 23]^T$. Based on the model what is the 95% confidence interval for global average temperature anomaly in 2100?

1 □ [2.09, 3.01]
2 □ [1.19, 3.92]
3 □ [2.51, 2.60]
4 □ [2.17, 2.94]
5\* □ [2.22, 2.89]

----------------------------------- FACIT-BEGIN -----------------------------------

In this case we have

$$X^T X = \begin{bmatrix} 47 & 0 \\ 0 & 8648 \end{bmatrix} \tag{7}$$

and the confidence interval is

$$0.6015 + 1.9532 \pm t_{0.975}(45) \cdot 0.1548\sqrt{\frac{1}{47} + \frac{100^2}{8648}} \tag{8}$$

or in R

```r
0.6015+1.9532+c(-1,1)*qt(0.975,df=45)*0.1548*sqrt(1/47+100^2/sum((-23:23)^2))
## [1] 2.216 2.893

# or with sum as a value
0.6015+1.9532+c(-1,1)*qt(0.975,df=45)*0.1548*sqrt(1/47+100^2/8648)
## [1] 2.216 2.893
```

------------------------------------ FACIT-END ------------------------------------

### Question XII.4 (28)

In order to validate the model the following residual plots have been created.

> **[Figure description:** Three residual diagnostic plots labeled A, B, C.
> - **Plot A:** Residuals vs. fitted values — residuals (axis ~−0.2 to 0.4) plotted against fitted values (axis ~0.2 to 1.0). Points are scattered without obvious systematic pattern.
> - **Plot B:** Normal Q–Q Plot — sample quantiles vs. theoretical quantiles (axis ~−2 to 2). Points fall approximately along a straight diagonal line.
> - **Plot C:** A boxplot of the residuals (residuals(fit)), roughly symmetric around 0 with a couple of high outliers.]**

Based on the plots which of the following statements is correct (both the conclusion and the figure reference from which this can be concluded must be correct)?

1 □ The residuals seems to be independent, as seen on Plot B.
2 □ The residuals are clearly not identically distributed, as seen on Plot C.
3\* □ There does not seem to be any systematic patterns in the residuals, as seen on Plot A.
4 □ There is clearly missing a quadratic term in the model, as seen on Plot C.
5 □ The variance homogeneity property is clearly violated, as seen on Plot B.

----------------------------------- FACIT-BEGIN -----------------------------------

Plot B cannot be used for assessing independence or variance homogeneity hence 1 and 5 are not correct. Plot C is a summary of all residuals hence it cannot be used for assessing if residuals are identically distributed or for systematic patterns, so 2 and 4 are not correct. Plot A can be used for identifying systematic patterns in the residuals, and there does not appear to be any, so answer 3 is correct.

------------------------------------ FACIT-END ------------------------------------

### Question XII.5 (29)

Regardless of the conclusions in the previous questions, it is decided to fit a quadratic model

$$Y_i = \beta_0 + \beta_1 x_i + \beta_2 x_i^2 + \varepsilon_i, \quad \varepsilon_i \sim N(0, \sigma^2)$$

in the R-code below x2 represents $x^2$, further parts of the output from summary is removed, and some numbers are replaced by characters.

```r
summary(lm(y ~ x + x2))
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept) 0.5472833  0.0324647       A        D
## x           0.0195317  0.0015949       B        E
## x2          0.0002946  0.0001315       C        F
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.1483 on 44 degrees of freedom
## Multiple R-squared:  0.7789, Adjusted R-squared:  0.7688
## F-statistic: 77.49 on 2 and 44 DF, p-value: 3.821e-15
```

In order to conclude if the quadratic term should be included in the model, which of the following conclusions is correct at a significance level $\alpha = 0.05$?

1 □ C=6.6 and $\hat\beta_2$ is significantly different from 0 as the critical value is 2.02.
2\* □ C=2.2 and $\hat\beta_2$ is significantly different from 0 as the critical value is 2.02.
3 □ B=11.7 and $\hat\beta_1$ is significantly different from 0 as the critical value is 1.96.
4 □ A=26.6 and $\hat\beta_1$ is significantly different from 0 as the critical value is 1.96.
5 □ C=2.2 and $\hat\beta_2$ is not significantly different from 0 as the critical value is 2.02.

----------------------------------- FACIT-BEGIN -----------------------------------

It appear that we will need the test statistics

```r
(A <- 0.5472833/0.0324647)
## [1] 16.86
(B <- 0.0195317/0.0015949)
## [1] 12.25
(C <- 0.0002946/0.0001315)
## [1] 2.24
```

hence only answer 2 and 5 could be correct. C should be compared to the critical value

```r
qt(0.975,df=44)
## [1] 2.015
```

and since C is greater than the critical value then $\hat\beta_2$ is significantly different from 0 (answer 2).

------------------------------------ FACIT-END ------------------------------------

### Question XII.6 (30)

The standard errors in the summary above can be obtained from the matrix $\Sigma_\beta$, such that $(\Sigma_\beta)_{11} = 0.0324647^2$, $(\Sigma_\beta)_{22} = 0.0015949^2$, and $(\Sigma_\beta)_{33} = 0.0001315^2$, but which elements of the matrix $\Sigma_\beta$ is equal to zero?

1\* □ $(\Sigma_\beta)_{12}, (\Sigma_\beta)_{21}, (\Sigma_\beta)_{23},$ and $(\Sigma_\beta)_{32}$
2 □ None
3 □ All but the diagonal elements
4 □ $(\Sigma_\beta)_{12}, (\Sigma_\beta)_{21}, (\Sigma_\beta)_{13},$ and $(\Sigma_\beta)_{31}$
5 □ $(\Sigma_\beta)_{13},$ and $(\Sigma_\beta)_{31}$

----------------------------------- FACIT-BEGIN -----------------------------------

The simplest way is simply the write the design matrix and calculate $(X^T X)^{-1}$

```r
X <- cbind(1,-23:23,(-23:23)^2)
solve(t(X)%*%X)
##            [,1]      [,2]          [,3]
## [1,]  0.0479085 0.0000000 -0.0001447387
## [2,]  0.0000000 0.0001156  0.0000000000
## [3,] -0.0001447 0.0000000  0.0000007866
```

from which is is seen what the correct answer is.

------------------------------------ FACIT-END ------------------------------------

The exam is finished. Enjoy the vacation!
