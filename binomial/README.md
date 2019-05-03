
<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

The package `"binomial"` is an [R](http://www.r-project.org/) package that provides functions to view and visualize the binomial distribution as well as view characteristics of the distribution.

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
 
# plotting binomial probability distribution
dis1 <- bin_distribution(trials = 5, prob = 0.5) 
plot(dis1)
```

![](README-unnamed-chunk-2-1.png)

``` r

#binomial cumulative distribution
bin_cumulative(trials = 5, prob = 0.5)
#>   success    prob cumulative
#> 1       0 0.03125    0.03125
#> 2       1 0.15625    0.18750
#> 3       2 0.31250    0.50000
#> 4       3 0.31250    0.81250
#> 5       4 0.15625    0.96875
#> 6       5 0.03125    1.00000
 
# plotting binomial cumulative distribution
dis2 <- bin_cumulative(trials = 5, prob = 0.5)
plot(dis2)
```

![](README-unnamed-chunk-2-2.png)

``` r

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
