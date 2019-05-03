context("checker")
#check_prob

test_that("check_prob has correct output", {
  expect_true(check_prob(0.1))
  expect_error(check_prob(c(0.1, 0.3)))
  expect_error(check_prob("Word"))
  expect_error(check_prob(-2))
  expect_error(check_prob(1.5))
})



#check_trials

test_that("check_trials has correct output", {
  expect_true(check_trials(2))
  expect_error(check_trials(c(2, 3)))
  expect_error(check_trials(1.5))
  expect_error(check_trials(-2))
})

#check_success

test_that("check_success has correct output", {
  expect_true(check_success(2, 4))
  expect_true(check_success(0:5, 5))
  expect_error(check_success(c(2.4, 3), 4))
  expect_error(check_success(5, 4))
  expect_error(check_success(0:6, 5))
})
