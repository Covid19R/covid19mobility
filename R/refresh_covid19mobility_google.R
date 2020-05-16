#Each Community Mobility Report dataset is presented by location and highlights the percent change in visits to places like grocery stores and parks within a geographic area.
# Location accuracy and the understanding of categorized places varies from region to region, so we don’t recommend using this data to compare changes between countries, or between regions with different characteristics (e.g. rural versus urban areas).
#
# Changes for each day are compared to a baseline value for that day of the week:

# The baseline is the median value, for the corresponding day of the week, during the 5-week period Jan 3–Feb 6, 2020.
# The datasets show trends over several months with the most recent data representing approximately 2-3 days ago—this is how long it takes to produce the datasets.

refresh_covid19mobility_google_country <- function(){

  #read in
  gmob <- read_google_mobility() %>%
    #filter to nations only
    dplyr::filter(is.na(sub_region_1))
}

refresh_covid19mobility_google_subregions <- function(){

  #read in
  gmob <- read_google_mobility()%>%
    #filter to subregions
    dplyr::filter(!is.na(sub_region_1),
                  is.na(sub_region_2)
    )


  # add complete iso3316 2 codes

  # combine subregion/country

  }

refresh_covid19mobility_google_us_counties <- function(){

  #read in
  gmob <- read_google_mobility()%>%
    #filter to nations only
    dplyr::filter(!is.na(sub_region_1),
                  !is.na(sub_region_2),
                  location_code=="US")

  # add county FIPS codes

  # combine state/county

}

read_google_mobility <- function(){
  url <- "https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv"

  gmob <- readr::read_csv(url,
                          col_types = readr::cols(
                            country_region_code = readr::col_character(),
                            country_region = readr::col_character(),
                            sub_region_1 = readr::col_character(),
                            sub_region_2 = readr::col_character(),
                            date = readr::col_date(),
                            retail_and_recreation_percent_change_from_baseline = readr::col_integer(),
                            grocery_and_pharmacy_percent_change_from_baseline = readr::col_integer(),
                            parks_percent_change_from_baseline = readr::col_integer(),
                            transit_stations_percent_change_from_baseline = readr::col_integer(),
                            workplaces_percent_change_from_baseline = readr::col_integer(),
                            residential_percent_change_from_baseline = readr::col_integer()
                          )
  )

  gmob_longer <- gmob %>%
    rename(location_code = country_region_code) %>%
    tidyr::pivot_longer(cols = retail_and_recreation_percent_change_from_baseline:residential_percent_change_from_baseline,
                        names_to = "data_type",
                        values_to = "value")

  gmob_longer
}
