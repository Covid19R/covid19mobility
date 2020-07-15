library(testthat)
library(covid19mobility)
library(glue)
library(dplyr)

refresh_funs <- dplyr::tribble(
  ~fun, ~len, ~date_check,
  "refresh_covid19mobility_apple_country", 18207, "2020-05-11",
  "refresh_covid19mobility_apple_subregion", 91590, "2020-06-04",
  "refresh_covid19mobility_apple_city", 453690, "2020-06-04", # as of 2020
  "refresh_covid19mobility_google_country", 83160, "2020-06-04", # as of 2020
  "refresh_covid19mobility_google_subregions", 1081764, "2020-06-04", # as of 2020
  "refresh_covid19mobility_google_us_counties", 1708692, "2020-06-04" # as of 2020
)

refresh_funs <- refresh_funs %>%
  dplyr::mutate(dat = lapply(fun, function(x) eval(call(x))))

test_check("covid19mobility")
