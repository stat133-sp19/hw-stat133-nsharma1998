
### 1.1) Private Checker Functions

# Checks whether the probability is valid (between 0-1)

check_prob = function(prob){
  if (length(prob) > 1){
    stop("p has to have length 1")
  }
  if (!(is.numeric(prob))) {
    stop("p has to be a number")
  }
  if (prob < 0 | prob > 1) {
    stop("p has to be betwen 0 and 1")
  }
  else {
    return(TRUE)
  }
}

# Checks whether the number of trials is valid (non-negative)

check_trials = function(trials){
  if (length(trials) > 1){
    stop("trials has to have length 1")
  }
  if (!(is.numeric(trials)) | floor(trials) != trials) {
    stop("trials has to be an integer")
  }
  if (trials < 0){
    stop("trials must be positive")
  }
  else {
    return(TRUE)
  }
}

# Checks whether the number of successes is valid (non-negative)
# Takes in single value or vector

check_success = function(success, trials){
  if (!(is.numeric(success))| sum(as.integer(success) != success) > 0){
    stop("success must be an integer")
  }
  if (sum(success < 0) > 0){
    stop("success cannot be negative")
  }
  if (sum(success > trials) > 0){
    stop("success must be smaller than trials")
  }
  else{
    return(TRUE)
  }
}

### 1.2) Private Functions

# Returns the mean of binomial

aux_mean = function(trials, prob) {
  return(trials * prob)
}

# Returns the variance of binomial

aux_variance = function(trials, prob) {
  return(trials*(prob)*(1-prob))
}

# Returns the mode of the experiment

aux_mode = function(trial, prob){
  mode = (trial + 1) * prob
  if (as.integer(mode) == mode){
    mode_two = mode - 1
    return(c(mode_two, mode))
  }
  else{
    return(as.integer(mode))
  }
}

# Returns the skewness of binomial

aux_skewness = function(trial, prob){
  skewness = (1-(2*prob))/sqrt(trial*(prob)*(1-prob))
  return(skewness)
}

# Returns the kurtosis of binomial

aux_kurtosis = function(trial, prob){
  kurtosis = (1- (6*(prob)*(1-prob)))/(trial*(prob)*(1-prob))
  return(kurtosis)
}

### 1.3) Function bin_choose()

#' @title binomial choose factor
#' @description computes binomial choose factor
#' @param n integer value for number of trials
#' @param k integer value for number of successes
#' @return integer value for choose factor
#' @export
#' @examples
#'
#' bin_choose(5, 2) returns 10
#' bin_choose(5, 1:3) returns c(5, 10, 10)


bin_choose = function(n,k){
  if (check_trials(n) != TRUE){
    stop("invalid trials value")
  }
  if (check_success(k, n) != TRUE){
    stop("invalid success value")
  }
  if (sum(k > n) > 0){
    stop("k cannot be greater than n")
  }
  else{
    return(factorial(n)/(factorial(k)*factorial(n-k)))
  }
}

### 1.4) Function bin_probability()

#' @title binomial probability
#' @description computes probability of success for binomial distribution
#' @param success integer value for number of successes
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return computed binomial probability
#' #' @examples
#'
#' bin_probability(5, 2, 0.5) returns 10/32
#' bin_probability(5, 1:3, 0.5) returns c(5/32, 10/32, 10/32)

bin_probability = function(success, trials, prob){

  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  if (!(check_success(success, trials))){
    stop("invalid success value")
  }
  else{
    probability = (bin_choose(trials,success))*
      (prob^success)*((1-prob)^(trials-success))
    return(probability)
  }
}

### 1.5) Function bin_distribution

#' @title binomial distribution
#' @description computes the probability for success for all values of success
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return vector of binomial probabilities
#' #' @examples
#'
#' bin_distribution(5, 0.5)
#' bin_distribution(5, 0.2)

bin_distribution = function(trials, prob){
  success <- 0:trials
  prob <- bin_probability(success, trials, prob)
  object <- data.frame(success, prob)
  class(object) = c("bindis", "data.frame")
  return(object)
}


plot.bindis <- function(object) {
  barplot(object$prob,
          xlab = "number of successes", ylab = "probability of success", names.arg = c(object$success))
}

##1.6 Bin Cumulative

#' @title binomial cumulative distribution
#' @description computes the cumulative probability for success for all values of success
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return vector of cumulative binomial probabilities
#' #' @examples
#'
#' bin_cumulative(5, 0.5)
#' bin_cumulative(5, 0.2)

bin_cumulative = function(trials, prob){
  success <- 0:trials
  prob <- bin_probability(success, trials, prob)
  object <- data.frame(success, prob, cumulative = cumsum(prob))
  class(object) = c("bincum", "data.frame")
  return(object)
}

#' @export
plot.bincum = function(object){
  plot(object$success, object$cumulative, type = "b",xlab = "number of successes", ylab = "cumulative probability of success")
  lines(object$success, object$cumulative)
}


##1.7 Bin Variable
#' @title binomial variable
#' @description creates a binomial random variable object
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return binomial random variable object
#' #' @examples
#'
#' bin_variable(5, 0.5)
#' bin_variable(5, 0.2)
bin_variable <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  res <- list(trials = trials, prob = prob)
  class(res) <- "binvar"
  return(res)
}

#'@export
print.binvar <- function(x) {
  cat('"Binomial variable""\n\n')
  cat("Parameters\n")
  cat("- Number of trials:", x$trials, "\n")
  cat("- Prob of success:", x$prob, "\n")
  invisible(x)
}

#'@export
summary.binvar <- function(x) {
  freqs <- data.frame(
    trials = x$trials,
    prob = x$prob,
    mean = aux_mean(x$trials, x$prob),
    variance = aux_variance(x$trials, x$prob),
    mode = aux_mode(x$trials, x$prob),
    skewness = aux_skewness(x$trials, x$prob),
    kurtosis = aux_kurtosis(x$trials, x$prob)
  )
  obj <- list(freqs = freqs)
  class(obj) <- "summary.binvar"
  return(obj)
}

print.summary.binvar <- function(x) {
  cat('"Binomial variable""\n\n')
  cat("Parameters\n")
  cat("- Number of trials:", x$freqs$trials, "\n")
  cat("- Prob of success:", x$freqs$prob, "\n\n")
  cat("Measures\n")
  cat("- Mean:", x$freqs$mean, "\n")
  cat("- Variance:", x$freqs$variance, "\n")
  cat("- Mode:", x$freqs$mode, "\n")
  cat("- Skewness:", x$freqs$skewness, "\n")
  cat("- Kurtosis:", x$freqs$kurtosis)
  invisible(x)
}


##1.8


#' @title binomial mean
#' @description finds the mean of the binomial
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return mean of binomial
#' #' @examples
#'
#' bin_mean(5, 0.5)
#' bin_mean(10, 0.2)
bin_mean <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  return(aux_mean(trials, prob))
}

#' @title binomial variance
#' @description finds the variance of the binomial
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return variance of binomial
#' #' @examples
#'
#' bin_variance(5, 0.5)
#' bin_variance(10, 0.2)
bin_variance <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  return(aux_variance(trials, prob))
}

#' @title binomial mode
#' @description finds the mode of the binomial
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return mode of binomial
#' #' @examples
#'
#' bin_mode(5, 0.5)
#' bin_mode(10, 0.2)
bin_mode <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  return(aux_mode(trials, prob))
}

#' @title binomial skewness
#' @description finds the skewness of the binomial
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return skewness of binomial
#' #' @examples
#'
#' bin_skewness(5, 0.5)
#' bin_skewness(10, 0.2)
bin_skewness <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  return(aux_skewness(trials, prob))
}

#' @title binomial kurtosis
#' @description finds the kurtosis of the binomial
#' @param trials integer value for number of trials
#' @param prob numeric value for the probability of success
#' @export
#' @return kurtosis of binomial
#' #' @examples
#'
#' bin_kurtosis(5, 0.5)
#' bin_kurtosis(10, 0.2)
bin_kurtosis <- function(trials, prob) {
  if (!(check_trials(trials))){
    stop("invalid trials value")
  }
  if (!(check_prob(prob))){
    stop("invalid prob value")
  }
  return(aux_kurtosis(trials, prob))
}
