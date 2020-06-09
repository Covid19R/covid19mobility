# a function to run a test for a single refresh function
# that checks it's length
check_len <- function(arow) {
  test_that(
    glue::glue("The number of rows from {arow$fun} is equal to
                 or greater than {arow$date_check}"),
    expect_gt(
      nrow(eval(call(arow$fun))),
      arow$len - 1
    ) # nrows on 2020-05-11
  )
}

# check the number of rows is greater than it was when the
# function was added to the package
for (i in seq_len(nrow(refresh_funs))) {
  check_len(refresh_funs[i, ])
}
