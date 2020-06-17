#' Refresh The Apple Covid-19 Mobility Data for Countries
#'
#' @description Pulls in the CSV of the Apple Mobility Data, filters to country, and reshapes it
#'
#' @return Returns a tibble that meets the Covid19R Project tidy data standard
#' @export
#'
#' @references \url{https://www.apple.com/covid19/mobility}
#'
#' @examples
#' \dontrun{
#'
#' mob <- refresh_covid19mobility_apple_country()
#'
#' head(mob)
#' }
#'
refresh_covid19mobility_apple_country <- function() {
  # import the apple mobility data
  mob_data <- import_apple_mob_data() %>%
    dplyr::filter(geo_type == "country/region")

  # reshape the apple mobility data
  mob_data <- reshape_apple_mob_data(mob_data) %>%
    add_country_codes()

  # return the apple mobility data
  mob_data %>%
    dplyr::mutate(location_type = "country") %>%
    reorder_apple() %>%
    dplyr::select(-sub_region, -country)
}

#' Refresh The Apple Covid-19 Mobility Data for Subregions
#'
#' @description Pulls in the CSV of the Apple Mobility Data, filters to subregions, and reshapes it
#'
#' @return Returns a tibble that meets the Covid19R Project tidy data standard
#' @export
#'
#' @references \url{https://www.apple.com/covid19/mobility}
#'
#' @examples
#' \dontrun{
#'
#' mob <- refresh_covid19mobility_apple_subregion()
#'
#' head(mob)
#' }
#'
refresh_covid19mobility_apple_subregion <- function() {
  # import the apple mobility data
  mob_data <- import_apple_mob_data() %>%
    dplyr::filter(geo_type == "sub-region")

  # reshape the apple mobility data
  mob_data <- reshape_apple_mob_data(mob_data) %>%
    add_subregion_codes()

  # return the apple mobility data
  mob_data %>%
    dplyr::mutate(location_type = "state") %>%
    reorder_apple() %>%
    dplyr::select(-sub_region)
}

#' Refresh The Apple Covid-19 Mobility Data for Cities
#'
#' @description Pulls in the CSV of the Apple Mobility Data, filters to cities, and reshapes it
#'
#' @return Returns a tibble that meets the Covid19R Project tidy data standard
#' @export
#'
#' @references \url{https://www.apple.com/covid19/mobility}
#'
#' @examples
#' \dontrun{
#'
#' mob <- refresh_covid19mobility_apple_city()
#'
#' head(mob)
#' }
#'
refresh_covid19mobility_apple_city <- function() {
  # import the apple mobility data
  mob_data <- import_apple_mob_data() %>%
    dplyr::filter(geo_type == "city")

  # reshape the apple mobility data
  mob_data <- reshape_apple_mob_data(mob_data) %>%
    add_city_codes()

  # return the apple mobility data
  mob_data %>%
    dplyr::mutate(location_type = "city") %>%
    reorder_apple()
}


# gak the data from apple
import_apple_mob_data <- function() {
  # what is the base apple mobility URL
  base_url <- "https://covid19-static.cdn-apple.com"


  # get the JSON that tells us where the data file is
  dat_json <- paste0(
    base_url,
    "/covid19-mobility-data/current/v3/index.json"
  ) %>%
    jsonlite::fromJSON()

  # make a URL for the data file
  dat_url <- paste0(
    base_url,
    dat_json$basePath,
    dat_json$regions$`en-us`$csvPath
  )

  # read in the data file as a tibble
  suppressMessages(
    readr::read_csv(dat_url)
  )
}

# reshape the data to the covid19R standard
reshape_apple_mob_data <- function(mob_data) {

  # reshape dates
  mob_data %>%
    tidyr::pivot_longer(
      cols = dplyr::starts_with("2020"),
      names_to = "date",
      values_to = "value"
    ) %>%
    dplyr::mutate(date = lubridate::ymd(date)) %>%

    # rename to covid19R standard
    dplyr::rename(
      location = region, location_type = geo_type,
      data_type = transportation_type
    ) %>%
    dplyr::mutate(location = ifelse(location == "UK", "United Kingdom", location)) %>%

    # make data types in covid19R standard
    dplyr::mutate(data_type = dplyr::case_when(
      data_type == "driving" ~ "driving_req_rel_volume",
      data_type == "walking" ~ "walking_req_rel_volume",
      data_type == "transit" ~ "transit_req_rel_volume"
    )) %>%
    janitor::clean_names()
}

reorder_apple <- . %>%
  dplyr::relocate(
    date,
    location,
    location_type,
    location_code,
    location_code_type,
    data_type,
    value
  )
