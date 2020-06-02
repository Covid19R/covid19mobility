load_un_locode <- function(){
  # get city codes
  locode_url <- "https://github.com/jebyrnes/unlocodeR/raw/master/data/unlocode.rda"
  f <- tempfile()
  utils::download.file(locode_url, f, quiet=TRUE)
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
      name_en = ifelse(name_en == "Bucuresti", "Bucharest", name_en),
      name_en = ifelse(name_en == "Changhua", "Changhua County", name_en),
      name_en = ifelse(name_en == "Chennai (ex Madras)", "Chennai", name_en),
      name_en = ifelse(name_en == "Denpasar, Bali", "Denpasar", name_en),
      name_en = ifelse(name_en == "Aparecida de Goiania", "Goi\u00e2nia", name_en),
      name_en = ifelse(un_locode == "DE MGL", "Mönchengladbach", name_en),
      name_en = ifelse(un_locode == "DE MUN", "Münster", name_en),
      name_en = ifelse(un_locode == "JP OTU", "Otsu", name_en),
      name_en = ifelse(un_locode == "US QPL", "Palmdale-Lancaster", name_en),
      name_en = ifelse(un_locode == "US RS3", "Reno-Sparks", name_en),
      name_en = ifelse(un_locode == "RU RND", "Rostov-on-Don", name_en),
      name_en = ifelse(un_locode == "JP SDJ", "Sendai", name_en),
      name_en = ifelse(un_locode == "KR SEL", "Seoul Capital Area", name_en),
      name_en = ifelse(un_locode == "TW TXG", "Taichung–Changhua metropolitan area", name_en),
      name_en = ifelse(un_locode == "TW TPE", "Taipei–Keelung–Taoyuan metropolitan area", name_en),
      name_en = ifelse(un_locode == "US VCV", "Victorville-Hesperia", name_en),
      name_en = ifelse(un_locode == "US WPH", "Waipahu", name_en),
      name_en = ifelse(un_locode == "TW HSZ", "Hsinchu metropolitan area", name_en),
      name_en = ifelse(un_locode == "SE MMA", "Malm\u00f6", name_en),
      name_en = ifelse(un_locode == "BE LGG", "Li\u00e8ge", name_en),
      name_en = ifelse(un_locode == "MX 9PI", "Le\u00f3n", name_en),
      name_en = ifelse(un_locode == "MX JUZ", "Ju\u00e1rez", name_en),
      name_en = ifelse(un_locode == "US EUG", "Eugene-Springfield", name_en),
      name_en = ifelse(un_locode == "AT VIE", "Vienna", name_en),
      name_en = ifelse(name_en == "Bridgeport", "Bridgeport_", name_en),
      name_en = ifelse(un_locode == "US BDR", "Bridgeport", name_en),
    )

}

#https://gis.stackexchange.com/questions/1047/seeking-full-list-of-iso-alpha-2-and-iso-alpha-3-country-codes/99540#99540
load_subregion_codes <- function(){
  readr::read_csv("https://github.com/olahol/iso-3166-2.js/raw/master/data.csv",
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

}

load_subdivisions <- function(){

  subdiv_url <- "https://github.com/jebyrnes/wikiISO31662/raw/master/data/iso_31662_subdivisions_extended.rda"
  f <- tempfile()
  utils::download.file(subdiv_url, f, quiet=TRUE)
  load(f) # loads file
  unlink(f)

  return(iso_31662_subdivisions_extended)
}

load_fips <- function(){
  # add county FIPS codes
  states <- tigris::states(cb = TRUE,
                           resolution = "20m",
                           class = "sf") %>%
    dplyr::select(STATEFP, NAME) %>%
    dplyr::rename(sub_region_1 = NAME) %>%
    dplyr::as_tibble() %>%
    dplyr::select(-geometry)

  counties <- tigris::counties(resolution = "20m",
                               cb = TRUE,
                               class = "sf") %>%
    dplyr::rename(
      sub_region_2 = NAME,
      location_code = GEOID) %>%
    dplyr::as_tibble() %>%
    dplyr::select(-geometry)

  #add state names and return
  dplyr::left_join(counties, states) %>%
    dplyr::select(sub_region_1, sub_region_2, location_code) %>%
    dplyr::arrange(sub_region_1, sub_region_2, location_code)

}

