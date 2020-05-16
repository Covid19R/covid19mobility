load_un_locode <- function(){
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

}


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


