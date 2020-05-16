#' Add country codes to a data frame
#'
#' @param adf tibble of data
#'
#' @keywords internal
#' @noRd
#' @return tibble
#'
add_country_codes <- function(adf) {

  # get country codes from somewhere
  country_codes <- jsonlite::fromJSON("https://raw.githubusercontent.com/dieghernan/Country-Codes-and-International-Organizations/master/outputs/Countrycodesfull.json") %>%
    dplyr::mutate(
      NAME.EN = ifelse(NAME.EN == "Czechia", "Czech Republic", NAME.EN),
      NAME.EN = ifelse(NAME.EN == "Hong Kong SAR China", "Hong Kong", NAME.EN),
      NAME.EN = ifelse(NAME.EN == "Macao SAR China", "Macao", NAME.EN),
      NAME.EN = ifelse(NAME.EN == "South Korea", "Republic of Korea", NAME.EN),
    )

  # merge in country codes, and then pivot to covid19R standard and return
  location_code_merge_pivot(country_codes, adf,
    name_col = "NAME.EN",
    code_col = "ISO_3166_2",
    code_name = "iso_3166_2"
  )
}


#' Add subregion codes to a data frame
#'
#' @param adf tibble of data
#'
#' @keywords internal
#' @noRd
#' @return tibble
#'
add_subregion_codes <- function(adf) {
  # get subregional codes
  # from https://github.com/olahol/iso-3166-2.js
  subregion_codes <- readr::read_csv("https://github.com/olahol/iso-3166-2.js/raw/master/data.csv",
    col_names = c(
      "Country",
      "iso_3166_2",
      "name",
      "type",
      "Country iso_3166_2"
    ),
    col_types = "ccccc"
  ) %>%
    dplyr::bind_rows(ireland_counties, korea_province)

  # subregion_codes <- rnaturalearth::ne_states(returnclass="sf")

  # make a data frame with modified locations for correct merging with international standards
  adf <- adf %>%
    dplyr::mutate(old_loc = location)

  # merge in codes and pivot to covid19R standard and return
  adf <- location_code_merge_pivot(subregion_codes,
    adf %>% subregion_name_filter(),
    name_col = "name",
    code_col = "iso_3166_2"
  ) %>%
    dplyr::mutate(location = old_loc) %>%
    dplyr::select(-old_loc)

  # deal with codes that didn't go through
  adf2 <- adf %>%
    dplyr::filter(is.na(location_code)) %>%
    dplyr::select(-location_code, -location_code_type) %>%
    dplyr::mutate(
      old_loc = location,
      location = ifelse(is.na(alternative_name), location, alternative_name)
    )

  adf <- adf %>%
    dplyr::filter(!is.na(location_code))

  adf2 <- location_code_merge_pivot(subregion_codes,
    adf2 %>% subregion_name_filter(),
    name_col = "name",
    code_col = "iso_3166_2"
  ) %>%
    dplyr::mutate(location = old_loc) %>%
    dplyr::select(-old_loc)

  # merge codes that didn't go through with codes that did and return
  # note - this still isn't perfect, as apple's location names are weird.
  dplyr::bind_rows(adf, adf2)
}

#' Add city codes to a data frame
#'
#' @param adf tibble of data
#' @keywords internal
#' @noRd
#' @return tibble
#'
add_city_codes <- function(adf) {
  # get city codes
  locode_url <- "https://github.com/jebyrnes/unlocodeR/raw/master/data/unlocode.rda"
  f <- tempfile()
  utils::download.file(locode_url, f)
  load(f) # loads unlocode
  unlink(f)

  # some changes to the locode to make merging happen
  unlocode <- unlocode %>%
    dplyr::mutate(
      name_en = ifelse(name_en == "New York" & subdivision == "NY", "New York City", name_en),
      name_en = ifelse(name_en == "Washington" & subdivision == "DC", "Washington DC", name_en),
      name_en = ifelse(un_locode == "US STL", "St. Louis", name_en),
      name_en = ifelse(un_locode == "DE FRA", "Frankfurt", name_en),
      name_en = ifelse(un_locode == "IN BOM", "Mumbai", name_en),
      name_en = ifelse(un_locode == "GB BHM", "Birmingham - UK", name_en),
      name_en = ifelse(un_locode == "US BHM", "Birmingham - Alabama", name_en),
      name_en = ifelse(un_locode == "DE BOM", "Bochum - Dortmund", name_en),
      name_en = ifelse(name_en == "San Francisco" & subdivision == "CA", "San Francisco - Bay Area", name_en),
      name_en = ifelse(name_en == "Ciudad de Mexico", "Mexico City", name_en),
      name_en = ifelse(name_en == "Nagoya, Aichi", "Nagoya", name_en),
      name_en = ifelse(name_en == "Helsingfors (Helsinki)", "Helsinki", name_en),
      name_en = ifelse(name_en == "Holon/Tel Aviv", "Tel Aviv", name_en),
      name_en = ifelse(name_en == "Jakarta, Java", "Jakarta", name_en),
      name_en = ifelse(name_en == "Saint Petersburg", "Saint Petersburg - Clearwater (Florida)", name_en),
      name_en = ifelse(name_en == "Saint Petersburg (ex Leningrad)", "Saint Petersburg - Russia", name_en),
      name_en = ifelse(name_en == "Brussel (Bruxelles)", "Brussels", name_en),
      name_en = ifelse(name_en == "Vienna", "Vienna_", name_en),
      name_en = ifelse(un_locode == "AT VIE", "Vienna", name_en),
      name_en = ifelse(name_en == "Bridgeport", "Bridgeport_", name_en),
      name_en = ifelse(un_locode == "US BDR", "Bridgeport", name_en),
    )

  # merge in codes and pivot to covid19R standard and return
  adf2 <- location_code_merge_pivot(unlocode, adf,
    name_col = "name_en",
    code_col = "un_locode"
  )

  # check for dups
  # dups <- adf2 %>%
  #   dplyr::group_by(location, date, data_type) %>%
  #   dplyr::count() %>%
  #   dplyr::ungroup() %>%
  #   dplyr::filter(n>1) %>%
  #   dplyr::group_by(location) %>%
  #   dplyr::slice(1L)
  #
  # View(dups)
  #
  # unlocode %>% dplyr::filter(grepl("Bridgeport", name_en)) %>% View
  # unlocode %>% dplyr::filter(grepl("GR ATH", un_locode)) %>% View

  # return
  adf
}


#' Merge and pivot data in a standardized way
#'
#' @param codes tibble with a column containing standardized codes
#' @param adf tibble of data
#' @param name_col what column in the codes tibble contains the name matching info
#' @param code_col what column in the codes tibble contains the standardized codes
#' @param code_name what is the name of the code standard - defaults to the same as code_col
#'
#' @keywords internal
#' @noRd
#' @return
#'
location_code_merge_pivot <- function(codes, adf, name_col, code_col, code_name = code_col) {
  dplyr::left_join(adf,
    codes %>%
      dplyr::select({{ name_col }}, {{ code_col }}),
    by = c("location" = name_col)
  ) %>%
    tidyr::pivot_longer(
      cols = !!code_col,
      names_to = "location_code_type",
      values_to = "location_code"
    ) %>%
    dplyr::mutate(location_code_type = code_name)
}
