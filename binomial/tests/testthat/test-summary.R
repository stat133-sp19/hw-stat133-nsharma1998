context("binomial summary")
#aux_mean

test_that("aux_mean has correct output", {
  trials = 10
  prob = 0.3
  expect_equal(aux_mean(trials, prob), 3)
  expect_length(aux_mean(trials, prob), 1)
  expect_type(aux_mean(trials, prob), "double")
})

#aux_variance

test_that("aux_variance has correct output", {
  trials = 10
  prob = 0.3
  expect_equal(aux_variance(trials, prob), 2.1)
  expect_length(aux_variance(trials, prob), 1)
  expect_type(aux_variance(trials, prob), "double")
})

#aux_mode

test_that("aux_mode has correct output", {
  trials = 10
  prob = 0.3
  expect_equal(aux_mode(trials, prob), 3)
  expect_length(aux_mode(trials, prob), 1)
  expect_type(aux_mode(trials, prob), "integer")
})

#aux_skewness

test_that("aux_skewness has correct output", {
  trials = 10
  prob = 0.3
  expect_equal(aux_skewness(trials, prob), 0.2760262, tolerance = 0.0001)
  expect_length(aux_skewness(trials, prob), 1)
  expect_type(aux_skewness(trials, prob), "double")
})


#aux_kurtosis

test_that("aux_kurtosis has correct output", {
  trials = 10
  prob = 0.3
  expect_equal(aux_kurtosis(trials, prob), -0.1238095, tolerance = 0.0001)
  expect_length(aux_kurtosis(trials, prob), 1)
  expect_type(aux_kurtosis(trials, prob), "double")
})
