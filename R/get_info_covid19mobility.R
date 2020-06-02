#' Get information about the datasets provided by covid19mobility
#'
#' @description Returns information about the datasets in this package for covid19R harvesting
#'
#' @return a tibble of information about the datasets in this package
#' @export get_info_covid19mobility
#'
#' @examples
#' \dontrun{
#'
#' # get the dataset info from this package
#' get_info_covid19mobility()
#' }
#'
get_info_covid19mobility <- function(){
  dplyr::tribble(
    ~data_set_name, ~package_name, ~function_to_get_data,
    ~data_details, ~data_url, ~license_url,
    ~data_types, ~location_types,
    ~spatial_extent, ~has_geospatial_info,

    "covid19mobility_apple_country",
    "covid19mobility",
    "refresh_covid19mobility_apple_country",
    "Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the country level.",
    "https://www.apple.com/covid19/mobility",
    "https://www.apple.com/covid19/mobility",
    "driving, walking, transit", #COMMA SEPARATED STRING OF DATA TYPES
    "country", #COMMA SEPARATED STRING OF LOCATION TYPES
    "global", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE, #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE

    "covid19mobility_apple_subregion",
    "covid19mobility",
    "refresh_covid19mobility_apple_subregion",
    "Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the subregion (state) level.",
    "https://www.apple.com/covid19/mobility",
    "https://www.apple.com/covid19/mobility",
    "driving, walking, transit", #COMMA SEPARATED STRING OF DATA TYPES
    "state", #COMMA SEPARATED STRING OF LOCATION TYPES
    "global", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE, #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE

    "covid19mobility_apple_city",
    "covid19mobility",
    "refresh_covid19mobility_apple_city",
    "Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the city level.",
    "https://www.apple.com/covid19/mobility",
    "https://www.apple.com/covid19/mobility",
    "driving, walking, transit", #COMMA SEPARATED STRING OF DATA TYPES
    "city", #COMMA SEPARATED STRING OF LOCATION TYPES
    "global", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    TRUE, #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE,

    "covid19mobility_google_country",
    "covid19mobility",
    "refresh_covid19mobility_google_country",
    "Changes for each day are compared to a baseline value for that day of the week as compared to  the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories.",
    "https://www.google.com/covid19/mobility/",
    "https://www.google.com/covid19/mobility/",
    "retail_and_recreation_percent_change_from_baseline,grocery_and_pharmacy_percent_change_from_baseline,parks_percent_change_from_baseline,transit_stations_percent_change_from_baseline,workplaces_percent_change_from_baseline,residential_percent_change_from_baseline", #COMMA SEPARATED STRING OF DATA TYPES
    "country", #COMMA SEPARATED STRING OF LOCATION TYPES
    "global", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE, #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE

    "covid19mobility_google_subregions",
    "covid19mobility",
    "refresh_covid19mobility_google_subregions",
    "Changes for each day are compared to a baseline value for that day of the week as compared to  the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories. Data is aggregated at the state or subdivision level.",
    "https://www.google.com/covid19/mobility/",
    "https://www.google.com/covid19/mobility/",
    "retail_and_recreation_percent_change_from_baseline,grocery_and_pharmacy_percent_change_from_baseline,parks_percent_change_from_baseline,transit_stations_percent_change_from_baseline,workplaces_percent_change_from_baseline,residential_percent_change_from_baseline", #COMMA SEPARATED STRING OF DATA TYPES
    "state", #COMMA SEPARATED STRING OF LOCATION TYPES
    "global", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE, #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE

    "covid19mobility_google_us_counties",
    "covid19mobility",
    "refresh_covid19mobility_google_us_counties",
    "Changes for each day are compared to a baseline value for that day of the week as compared to  the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories. Data is aggregated at the county level for the USA only.",
    "https://www.google.com/covid19/mobility/",
    "https://www.google.com/covid19/mobility/",
    "retail_and_recreation_percent_change_from_baseline,grocery_and_pharmacy_percent_change_from_baseline,parks_percent_change_from_baseline,transit_stations_percent_change_from_baseline,workplaces_percent_change_from_baseline,residential_percent_change_from_baseline", #COMMA SEPARATED STRING OF DATA TYPES
    "county", #COMMA SEPARATED STRING OF LOCATION TYPES
    "country", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE

  )

}
