context("binomial")

# bin_choose

test_that("bin_choose has correct output", {
  expect_equal(bin_choose(n = 5, k = 2), 10)
  expect_equal(bin_choose(5, 1:3), c(5, 10, 10))
  expect_error(bin_choose(5, -1))
})


# bin_probability

test_that("bin_probability has correct output", {
  n = 5
  k = 2
  p = 0.5
  expect_equal(bin_probability(k, n, p), 10/32)
  expect_length(bin_probability(k, n, p), 1)
  expect_type(bin_probability(k, n, p), "double")
})

# bin_distribution

test_that("bin_distribution has correct output", {
  n = 5
  p = 0.5
  expect_equal(bin_distribution(n, p)$prob, c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
  expect_equal(bin_distribution(n, p)$success, 0:5)
  expect_equal(typeof(bin_distribution(n, p)), "list")
  expect_length(bin_distribution(n, p), 2)
})

# bin_cumulative

test_that("bin_cumulative has correct output", {
  n = 5
  p = 0.5
  expect_equal(bin_cumulative(n, p)$cumulative, c(0.03125, 0.18750, 0.50000, 0.81250, 0.96875, 1.00000))
  expect_equal(bin_cumulative(n, p)$success, 0:5)
  expect_equal(typeof(bin_cumulative(n, p)), "list")
  expect_length(bin_cumulative(n, p), 3)
})
