# load the library
library(covid19mobility)

# get the data
covid19mobility_country_demo <- refresh_covid19mobility_country()

# put it into the package
usethis::use_data(covid19mobility_country_demo, overwrite = TRUE)
