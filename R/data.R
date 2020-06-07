#' Demo Data of the Apple Covid-19 Mobility Data for Countries
#'
#'
#' @format A data frame with 22032 rows and 8 variables:
#' \describe{
#' * date - The date in YYYY-MM-DD form
#' * location - The name of the location as provided by the data source. The counties dataset provides county and state. They are combined and separated by a `,`, and can be split by `tidyr::separate()`, if you wish.
#' * location_type - The type of location using the covid19R controlled vocabulary.
#' * location_code - A standardized location code using a national or international standard. In this case, FIPS state or county codes. See https://en.wikipedia.org/wiki/Federal_Information_Processing_Standard_state_code and https://en.wikipedia.org/wiki/FIPS_county_code for more
#' * location_code_type The type of standardized location code being used according to the covid19R controlled vocabulary. Here we use `fips_code`
#' * data_type - the type of data in that given row. Includes `total_cases` and `total_deaths`, cumulative measures of both.
#' * value - number of cases of each data type
#' * alternative_name - the alternative name for the country
#' }
#' @source \url{http://www.diamondse.info/}
"covid19mobility_apple_country_demo"


#' Demo Data of the Apple Covid-19 Mobility Data for Countries
#'
#'
#' @format A data frame with 83160 rows and 7 variables:
#' \describe{
#' #' * date - The date in YYYY-MM-DD form
#' * location - The name of the location as provided by the data source. The counties dataset provides county and state. They are combined and separated by a `,`, and can be split by `tidyr::separate()`, if you wish.
#' * location_type - The type of location using the covid19R controlled vocabulary.
#' * location_code - A standardized location code using a national or international standard. In this case, FIPS state or county codes. See https://en.wikipedia.org/wiki/Federal_Information_Processing_Standard_state_code and https://en.wikipedia.org/wiki/FIPS_county_code for more
#' * location_code_type The type of standardized location code being used according to the covid19R controlled vocabulary. Here we use `fips_code`
#' * data_type - the type of data in that given row. Includes `total_cases` and `total_deaths`, cumulative measures of both.
#' * value - number of cases of each data type
#' }
#' @source \url{http://www.diamondse.info/}
"covid19mobility_google_country_demo"
