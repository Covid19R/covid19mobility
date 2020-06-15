# things to test against
refresh_col_names <-
  c(
    "date",
    "location",
    "location_type",
    "location_code",
    "location_code_type",
    "data_type",
    "value"
  )


location_types <- read.csv("https://github.com/Covid19R/covid19Rdata/raw/master/controlled_vocabularies/location_type.csv", stringsAsFactors = FALSE)[, 1]
location_code_types <- read.csv("https://github.com/Covid19R/covid19Rdata/raw/master/controlled_vocabularies/location_code_type.csv", stringsAsFactors = FALSE)[, 1]
data_types <- read.csv("https://github.com/Covid19R/covid19Rdata/raw/master/controlled_vocabularies/data_type.csv", stringsAsFactors = FALSE)[, 1]

# helper function

expect_contains <- function(vec1, vec2) {
  vec1 <- unique(vec1)

  expect(
    all(vec1 %in% vec2),
    paste0(
      "Some or all values of ",
      paste0(vec1, collapse = ","),
      "\ndo not match ",
      paste0(vec2, collapse = ","),
      "\nIf this is a new controlled vocabulary entry ",
      "please file an issue at\nhttps://github.com/Covid19R/covid19R/issues"
    )
  )
}


# OK, the testing!

# the function to run the tests

test_one_refresh_for_vocab <- function(arow) {

  res <- eval(call(arow$fun))

  # make sure there's there there
  expect_gt(nrow(res), 0)

  last_col <- 7

  # make sure column names are in order
  if (arow$fun == "refresh_covid19mobility_google_us_counties") {
    refresh_col_names <-
      c(
        "date",
        "location",
        "location_type",
        "location_code",
        "location_code_type",
        "state",
        "data_type",
        "value"
      )

    last_col <- 8
  }

  expect_named(res[, 1:last_col], refresh_col_names) # allow for other cols

  # loc types
  expect_contains(res$location_type, location_types)

  # loc codes
  expect_contains(res$location_code_type, location_code_types)

  # dat types
  expect_contains(res$data_type, data_types)
}

# run all tests

# check the number of rows is greater than it was when the
# function was added to the package
for (i in seq_len(nrow(refresh_funs))) {
  test_that(glue::glue("{refresh_funs[i,]$fun} works and has propercontrolled format and vocab"), {
    test_one_refresh_for_vocab(refresh_funs[i, ])
  })
}
