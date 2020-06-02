test_that("The number of rows in the country dataset is equal
          or greater than it was on 2020-05-11", {
  expect_gt(nrow(refresh_covid19mobility_apple_country()), 18207 - 1) # nrows on 2020-05-11
})
