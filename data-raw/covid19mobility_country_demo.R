# load the library
library(covid19mobility)

# get the data
covid19mobility_apple_country_demo <- refresh_covid19mobility_apple_country()
covid19mobility_google_country_demo <- refresh_covid19mobility_google_country()

# put it into the package
usethis::use_data(covid19mobility_apple_country_demo, overwrite = TRUE)
usethis::use_data(covid19mobility_google_country_demo, overwrite = TRUE)
