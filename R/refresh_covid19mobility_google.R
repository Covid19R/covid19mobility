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

  gmob %>%
    dplyr::select(-sub_region_1, sub_region_2) %>%
    dplyr::rename(location = country_region) %>%
    dplyr::mutate(location_code_type = "iso_3166_2",
                  location_type = "country") %>%
    dplyr::select(date, location, location_type,
                 location_code, location_code_type,
                 data_type, value) %>%
    dplyr::mutate(location_code = ifelse(location=="Namibia", "NA", location_code)) #agh!
}

refresh_covid19mobility_google_subregions <- function(){

  #read in
  gmob <- read_google_mobility()%>%
    #filter to subregions
    dplyr::filter(!is.na(sub_region_1),
                  is.na(sub_region_2)
    )

  #put puerto rico in properly
  pr <- gmob %>%
    #filter to subregions
    dplyr::filter(country_region=="Puerto Rico") %>%
    dplyr::select(-location_code) %>%
    dplyr::mutate(sub_region_2 = sub_region_1,
                  sub_region_1 = "Puerto Rico",
                  country_region = "United States")%>%
    dplyr::filter(is.na(sub_region_2))

  gmob <- dplyr::bind_rows(gmob %>% dplyr::filter(country_region != "Puerto Rico"),
                           pr)


  #make a clean subregion_1
  gmob <- dplyr::left_join(gmob,
                           goog_subdivision_lut(gmob))
  # subregion_codes
  subdivision_codes <- load_subdivisions() %>%
    dplyr::mutate(
      subdivision_name = gsub("^Al ", "", subdivision_name),
      subdivision_name = gsub("s lan$", "", subdivision_name),
      subdivision_name = tolower(subdivision_name)) %>%
    dplyr::group_by(code, country_code, subdivision_name) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup()

  gmob_joined <- dplyr::left_join(gmob,
                                  subdivision_codes,
                                  by = c("location_code" = "country_code",
                                         "subregion_1_clean" = "subdivision_name"))
  #Add PR FIPS codes
  # pr <- tigris::counties(state = "PR", class="sf") %>%
  #   dplyr::select(GEOID, NAME)


  #return
  gmob_joined <- gmob_joined %>%
    dplyr::rename(country_code = location_code,
                  location = sub_region_1,
                  location_code = code) %>%
    dplyr::mutate(location_type = "state",
                  location_code_type = "iso_3166_2") %>%
    dplyr::select(date,
                 location,
                 location_type,
                 location_code,
                 location_code_type,
                 data_type,
                 value)

  gmob_joined

}

refresh_covid19mobility_google_us_counties <- function(){

  #read in
  gmob <- read_google_mobility()%>%
    #filter to nations only
    dplyr::filter(!is.na(sub_region_1),
                  !is.na(sub_region_2)) %>%
    dplyr::select(-location_code)

  #get puerto rico
  pr <- read_google_mobility()%>%
    #filter to subregions
    dplyr::filter(country_region=="Puerto Rico") %>%
    dplyr::select(-location_code) %>%
    dplyr::mutate(sub_region_2 = sub_region_1,
                  sub_region_1 = "Puerto Rico",
                  country_region = "United States") %>%
    dplyr::filter(!is.na(sub_region_2))

  #combine and make a clean column
  gmob <- dplyr::bind_rows(gmob, pr)

  #make a counties lookup table
  suppressMessages(
    counties_lut <- goog_counties_lut(gmob, load_fips())
    )

  # combine state/county
  suppressMessages(
    gmob_joined <- dplyr::left_join(gmob,
                         counties_lut)
  )

  # reshape and return
  gmob_joined %>%
    dplyr::rename(state = sub_region_1,
                  location = sub_region_2) %>%
    dplyr::mutate(location_type = "county",
                  location_code_type = "fips") %>%
    dplyr::select(date, location, location_type,
                  location_code, location_code_type,
                  data_type, value,
                  state)
}

read_google_mobility <- function(){
  url <- "https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv"

  gmob <- readr::read_csv(url, na = c("", "N/A"), #col_types = "ccccDiiiiii")
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
    dplyr::rename(location_code = country_region_code) %>%
    tidyr::pivot_longer(cols = retail_and_recreation_percent_change_from_baseline:residential_percent_change_from_baseline,
                        names_to = "data_type",
                        values_to = "value")

  gmob_longer
}
