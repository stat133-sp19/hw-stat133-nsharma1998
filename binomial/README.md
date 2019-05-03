
Overview
--------

The package `"binomial"` is an [R](http://www.r-project.org/) package that provides functions to view and visualize the binomial distribution as well as view characteristics of the distribution.

This package includes the following functions:

-   bin\_choose() finds the number of ways in which k successes can occur in n trials.
-   bin\_probability() finds the probability of getting k successes in n trials for a binomial distribution.
-   bin\_distribution() finds the entire probability distribution of a binomial random variable. The distribution can also be plotted using plot.bindis().
-   bin\_cumulative() finds the entire cumulative probability distribution of a binomial random variable. The distribution can also be plotted using plot.bincum().
-   bin\_variable() returns a list specifying the number of trials and the probability of success for a binomial random variable.summary.binvar() allows you to view the summary statistics of the random variable.
-   bin\_mean() finds the mean of a binomial random variable.
-   bin\_variance() finds the variance of a binomial random variable.
-   bin\_mode() finds the mode of a binomial random variable.
-   bin\_skewness() finds the skewness of a binomial random variable.
-   bin\_kurtosis() finds the kurtosis of a binomial random variable.

Motivation
----------

This package has been developed as part of a project for Statistics 133.

Installation
------------

Install the development version from GitHub via the package `"devtools"`:

``` r
# development version from GitHub:
#install.packages("devtools") 
# install "binomial" (without vignettes)
devtools::install_github("stat133-sp19/hw-stat133-nsharma1998binomial")
# install "binomial" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-nsharma1998/binomial", build_vignettes = TRUE)
```

Usage
-----

``` r
library(binomial)

# 55 heads in 100 tosses of a loaded coin with 45% chance of heads
bin_probability(success = 55, trials = 100, prob = 0.45)
#> [1] 0.01075277
 

# binomial probability distribution
bin_distribution(trials = 5, prob = 0.5)
#>   success    prob
#> 1       0 0.03125
#> 2       1 0.15625
#> 3       2 0.31250
#> 4       3 0.31250
#> 5       4 0.15625
#> 6       5 0.03125


#binomial cumulative distribution
bin_cumulative(trials = 5, prob = 0.5)
#>   success    prob cumulative
#> 1       0 0.03125    0.03125
#> 2       1 0.15625    0.18750
#> 3       2 0.31250    0.50000
#> 4       3 0.31250    0.81250
#> 5       4 0.15625    0.96875
#> 6       5 0.03125    1.00000
 

#Binomial with n=10, p=0.3
bin_mean(10, 0.3)
#> [1] 3
bin_variance(10, 0.3)
#> [1] 2.1
bin_mode(10, 0.3)
#> [1] 3
bin_skewness(10, 0.3)
#> [1] 0.2760262
bin_kurtosis(10, 0.3)
#> [1] -0.1238095
```
