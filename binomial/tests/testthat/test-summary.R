context("binomial summary")
#aux_mean

test_that("aux_mean has correct output", {
  n = 10
  p = 0.3
  expect_equal(aux_mean(n, p), 3)
  expect_length(aux_mean(n, p), 1)
  expect_type(aux_mean(n, p), "double")
})

#aux_variance

test_that("aux_variance has correct output", {
  n = 10
  p = 0.3
  expect_equal(aux_variance(n, p), 2.1)
  expect_length(aux_variance(n, p), 1)
  expect_type(aux_variance(n, p), "double")
})

#aux_mode

test_that("aux_mode has correct output", {
  n = 10
  p = 0.3
  expect_equal(aux_mode(n, p), 3)
  expect_length(aux_mode(n, p), 1)
  expect_type(aux_mode(n, p), "integer")
})

#aux_skewness

test_that("aux_skewness has correct output", {
  n = 10
  p = 0.3
  expect_equal(aux_skewness(n, p), 0.2760262, tolerance = 0.0001)
  expect_length(aux_skewness(n, p), 1)
  expect_type(aux_skewness(n, p), "double")
})


#aux_kurtosis

test_that("aux_kurtosis has correct output", {
  n = 10
  p = 0.3
  expect_equal(aux_kurtosis(n, p), -0.1238095, tolerance = 0.0001)
  expect_length(aux_kurtosis(n, p), 1)
  expect_type(aux_kurtosis(n, p), "double")
})
