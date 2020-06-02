#--------------------
# For Apple Data ####
#--------------------

#from wikipedia
ireland_counties <- data.frame(
  stringsAsFactors = FALSE,
  check.names = FALSE,
  iso_3166_2 = c(
    "IE-CW",
    "IE-CN", "IE-CE", "IE-CO",
    "IE-DL", "IE-D", "IE-G",
    "IE-KY", "IE-KE", "IE-KK", "IE-LS",
    "IE-LM", "IE-LK", "IE-LD",
    "IE-LH", "IE-MO", "IE-MH",
    "IE-MN", "IE-OY", "IE-RN", "IE-SO",
    "IE-TA", "IE-WD", "IE-WH",
    "IE-WX", "IE-WW"
  ),
  `name` = c(
    "Carlow", "Cavan", "Clare", "Cork",
    "Donegal", "Dublin", "Galway",
    "Kerry", "Kildare", "Kilkenny",
    "Laois", "Leitrim",
    "Limerick", "Longford", "Louth",
    "Mayo", "Meath", "Monaghan",
    "Offaly", "Roscommon", "Sligo",
    "Tipperary", "Waterford",
    "Westmeath", "Wexford", "Wicklow"
  ),
  `gaelic_name` = c(
    "Ceatharlach", "An Cabh\u00e1n", "An Cl\u00e1r",
    "Corcaigh", "D\u00fan na nGall",
    "Baile \u00e1tha Cliath",
    "Gaillimh", "Ciarra\u00ed", "Cill Dara",
    "Cill Chainnigh", "Laois",
    "Liatroim", "Luimneach",
    "An Longfort", "L\u00fa", "Maigh Eo", "An Mh\u00ed",
    "Muineach\u00e1n", "U\u00edbh Fhail\u00ed",
    "Ros Com\u00e1in", "Sligeach",
    "Tiobraid \u00e1rann", "Port L\u00e1irge",
    "An Iarmh\u00ed", "Loch Garman",
    "Cill Mhant\u00e1in"
  )
)

#stringi::stri_escape_unicode("í")

korea_province <- data.frame(
  stringsAsFactors = FALSE,
  check.names = FALSE,
  iso_3166_2 = c(
    "KR-11",
    "KR-26", "KR-27", "KR-30", "KR-29",
    "KR-28", "KR-31", "KR-43",
    "KR-44", "KR-42", "KR-41", "KR-47",
    "KR-48", "KR-45", "KR-46",
    "KR-49", "KR-50"
  ),
  `Subdivision.name.(en)` = c(
    "Seoul",
    "Busan", "Daegu", "Daejeon",
    "Gwangju", "Incheon", "Ulsan",
    "North Chungcheong", "South Chungcheong",
    "Gangwon", "Gyeonggi",
    "North Gyeongsang", "South Gyeongsang",
    "North Jeolla", "South Jeolla",
    "Jeju", "Sejong"
  ),
  `Subdivision.name.(ko)` = c(
    "Seoul-teukbyeolsi", "Busan-gwangyeoksi",
    "Daegu-gwangyeoksi",
    "Daejeon-gwangyeoksi", "Gwangju-gwangyeoksi",
    "Incheon-gwangyeoksi",
    "Ulsan-gwangyeoksi", "Chungcheongbuk-do",
    "Chungcheongnam-do",
    "Gangwon-do", "Gyeonggi-do",
    "Gyeongsangbuk-do", "Gyeongsangnam-do",
    "Jeollabuk-do", "Jeollanam-do",
    "Jeju-teukbyeoljachido",
    "Sejong-teukbyeoljachisi"
  ),
  name = c(
    "Seoul",
    "Busan", "Daegu", "Daejeon",
    "Gwangju", "Incheon", "Ulsan",
    "Chungcheongbuk-do", "Chungcheongnam-do", "Gangwon",
    "Gyeonggi", "Gyeongsangbuk-do", "Gyeongsangnam-do",
    "Jeollabuk-do", "Jeollanam-do", "Jeju",
    "Sejong"
  ),
  Subdivision.category = c(
    "special city", "metropolitan city",
    "metropolitan city", "metropolitan city",
    "metropolitan city",
    "metropolitan city", "metropolitan city",
    "province", "province",
    "province", "province", "province",
    "province", "province", "province",
    "special self-governing province",
    "special self-governing city"
  )
)

subregion_name_filter <- function(adf) {
  adf %>%
    dplyr::mutate(
      location = gsub(" Region", "", location),
      location = gsub(" Prefecture", "", location),
      location = gsub(" Province", "", location),
      location = gsub("^Autonomous ", "", location),
      location = gsub("^Bailiwick of ", "", location),
      location = gsub(" County", "", location),
      location = gsub(" Metropolitan City", "", location),
      location = gsub(" Special City", "", location),
      location = gsub(" \\(state\\)", "", location),
      location = gsub(" District", "", location),
      location = gsub("Canton of ", "", location),
      location = gsub("Canton de ", "", location),
      location = gsub(" City", "", location),
      location = gsub("State of ", "", location),
      location = gsub(" \\(Prefecture\\)", "", location),
      location = gsub(" Islands", "", location),
      location = gsub(" megye", "", location),
      location = gsub("^Comunidad de ", "", location),
      location = gsub("^Comunidad ", "", location),
      location = gsub("^District de ", "", location),
      location = gsub(" \\(Brasil\\)$", "", location),
      location = gsub("Wojew\u00f3dztwo ", "", location),
      location = gsub("Region ", "", location),
      location = gsub("Regi\u00f3n de ", "", location),
      location = gsub("Regi\u00f3n ", "", location),
      location = gsub("Provincie ", "", location),
      location = gsub("^of  ", "", location)
    )
}



#----------------
# For Google ####
#----------------

goog_subdivision_lut <- function(gmob){

  gmob_subdivisions <- gmob %>%
    dplyr::filter(country_region != "Puerto Rico") %>% #Why is this a country?
    dplyr::group_by(location_code, sub_region_1) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup() %>%
    dplyr::select(location_code, sub_region_1)


  #for gmob
  fix_subregion_clean <- . %>%
    dplyr::mutate(
      subregion_1_clean = gsub("State of ", "", subregion_1_clean),
      subregion_1_clean = gsub("St. ", "Saint ", subregion_1_clean),
      subregion_1_clean = gsub("City of ", "", subregion_1_clean),
      subregion_1_clean = gsub(" Parish", "", subregion_1_clean),
      subregion_1_clean = gsub(" Region$", "", subregion_1_clean),
      subregion_1_clean = gsub(" County$", "", subregion_1_clean),
      subregion_1_clean = gsub("^County ", "", subregion_1_clean),
      subregion_1_clean = gsub(" Governorate$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Governate$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Governorate$", "", subregion_1_clean),
      subregion_1_clean = gsub(" District$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Voivodeship$", "", subregion_1_clean),
      # subregion_1_clean = gsub(" Islands$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Council$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Department$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Municipality$", "", subregion_1_clean),
      subregion_1_clean = gsub("s novads$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Province$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Area$", "", subregion_1_clean),
      subregion_1_clean = gsub(" district$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Autonomous", "", subregion_1_clean),
      subregion_1_clean = gsub(" Community$", "", subregion_1_clean),
      subregion_1_clean = gsub("^Metropolitan Municipality of ", "", subregion_1_clean),
      subregion_1_clean = gsub(" Principal$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Principle$", "", subregion_1_clean),
      subregion_1_clean = gsub(" Province$", "", subregion_1_clean),
      subregion_1_clean = gsub("^Municipality of ", "", subregion_1_clean),
      subregion_1_clean = gsub("^Administrative unit ", "", subregion_1_clean),
      subregion_1_clean = gsub("^Decentralized Administration of ", "", subregion_1_clean),
      subregion_1_clean = gsub("^Al ", "", subregion_1_clean),
      subregion_1_clean = gsub("Flanders", "East Flanders", subregion_1_clean), #AUGH
      subregion_1_clean = gsub("Normandy", "Upper Normandy", subregion_1_clean),
      subregion_1_clean = gsub("Dar es Salam", "Dar es Salaam", subregion_1_clean),
      subregion_1_clean = gsub("-", " ", subregion_1_clean),
      subregion_1_clean = tolower(subregion_1_clean),#AUGH
      subregion_1_clean = stringi::stri_trans_general(subregion_1_clean, "Latin-ASCII")
    )

  gmob_subdivisions <- gmob_subdivisions %>%
    dplyr::mutate(subregion_1_clean = sub_region_1) %>%
    fix_subregion_clean

  #those last recalcitrant few
  gmob_codefix <- tibble::tribble(
    ~location_code,                                                                ~sub_region_1,                           ~subregion_1_clean,                    ~subregion_1_match,
    "AE",                                                             "Umm Al Quawain",                             "umm al quawain",                      "umm al qaiwain",
    "CL",                                                                    "Bio Bio",                                    "bio bio",                              "biobio",
    "CL",                                          "Magallanes and Chilean Antarctica",          "magallanes and chilean antarctica",                          "magallanes",
    "CO",                                                            "North Santander",                            "north santander",                  "norte de santander",
    "CO",                                                 "San Andres and Providencia",                 "san andres and providencia",           "san andrés en providencia",
    "EC",                                                          "Galápagos Islands",                          "galapagos islands",                           "galapagos",
    "EG",                                                    "Ash Sharqia Governorate",                                "ash sharqia",                             "sharqia",
    "EG",                                                     "El Beheira Governorate",                                 "el beheira",                             "beheira",
    "EG",                                                        "Menofia Governorate",                                    "menofia",                             "monufia",
    "ES",                                                        "Valencian Community",                                  "valencian",                 "valencian community",
    "GB",                                                               "Bristol City",                               "bristol city",                             "bristol",
    "GB",                                                       "Na h-Eileanan an Iar",                       "na h eileanan an iar",                      "outer hebrides",
    "GR",               "Decentralized Administration of Epirus and Western Macedonia",               "epirus and western macedonia",                       "epirus region",
    "GR",                       "Decentralized Administration of Macedonia and Thrace",                       "macedonia and thrace",        "eastern macedonia and thrace",
    "GR", "Decentralized Administration of Peloponnese, Western Greece and the Ionian", "peloponnese, western greece and the ionian",                  "peloponnese region",
    "GR",                                 "Decentralized Administration of the Aegean",                                 "the aegean",                        "north aegean",
    "GR",                "Decentralized Administration of Thessaly and Central Greece",                "thessaly and central greece",                            "thessaly",
    "ID",                                                        "South East Sulawesi",                        "south east sulawesi",                  "southeast sulawesi",
    "KE",                                                             "Muranga County",                                    "muranga",                            "murang'a",
    "KH",                                                      "Steung Treng Province",                               "steung treng",                         "stung treng",
    "LB",                                                      "Nabatiyeh Governorate",                                  "nabatiyeh",                            "nabatieh",
    "MU",                                                     "Rivière Noire District",                              "riviere noire",                       "rivière noire",
    "MY",                                          "Federal Territory of Kuala Lumpur",          "federal territory of kuala lumpur",                        "kuala lumpur",
    "MY",                                                   "Labuan Federal Territory",                   "labuan federal territory",                              "labuan",
    "NE",                                                     "Niamey Urban Community",                               "niamey urban",                              "niamey",
    "NI",                                    "North Caribbean Coast Autonomous Region",                      "north caribbean coast",                  "costa caribe norte",
    "NI",                                    "South Caribbean Coast Autonomous Region",                      "south caribbean coast",                    "costa caribe sur",
    "OM",                                                 "Ad Dakhiliyah
Governorate",                 "ad dakhiliyah",                       "ad-dakhiliyah",
    "PK",                                                     "Azad Jammu and Kashmir",                     "azad jammu and kashmir",               "azad jammun o kashmir",
    "PK",                                         "Federally Administered Tribal Area",              "federally administered tribal", "federally administered tribal areas",
    "PY",                                                        "Boquerón department",                        "boqueron department",                            "boqueron",
    "RE",                                                                "Saint-Denis",                                "saint denis",                   "seine saint denis",
    "RE",                                                                 "Saint-Paul",                                 "saint paul",                                    NA,
    "RE",                                                               "Saint-Pierre",                               "saint pierre",                                    NA,
    "TZ",                                                        "Unguja South Region",                               "unguja south",               "unguja sud et central"
  )

  gmob_subdivisions <- dplyr::left_join(gmob_subdivisions,
                                        gmob_codefix,
                                        by = "subregion_1_clean") %>%
    dplyr::mutate(subregion_1_clean = ifelse(!is.na(subregion_1_match),
                                             subregion_1_match,
                                             subregion_1_clean))

  # subregion_codes
  subdivision_codes <- load_subdivisions() %>%
    dplyr::mutate(
      subdivision_name = gsub("^Al ", "", subdivision_name),
      subdivision_name = gsub("s lan$", "", subdivision_name),
      subdivision_name = tolower(subdivision_name))



  gmob_lut <- dplyr::left_join(gmob_subdivisions,
                               subdivision_codes,
                               by = c("location_code.x" = "country_code",
                                      "subregion_1_clean" = "subdivision_name"))
  #Filter and rename
  gmob_lut  <- gmob_lut %>%
    dplyr::select(location_code.x,
                  sub_region_1.x,
                  subregion_1_clean) %>%
    dplyr::rename(location_code = location_code.x,
                  sub_region_1 = sub_region_1.x) %>%
    dplyr::group_by(location_code, sub_region_1) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup()

  #make sure here are no dups in the LUT
  # gmob_lut1 <- gmob_lut %>%
  #   dplyr::group_by(location_code, sub_region_1) %>%
  #   dplyr::count() %>%
  #   dplyr::ungroup() %>%
  #   dplyr::arrange(desc(n))

  #return
  gmob_lut
}

goog_counties_lut <- function(gmob, counties){

  gmob_unique <- gmob %>%
    dplyr::select(sub_region_1, sub_region_2) %>%
    dplyr::group_by(sub_region_1, sub_region_2) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      sub_region_2_old = sub_region_2,
      sub_region_2 = gsub(" County", "", sub_region_2),
      sub_region_2 = gsub(" Parish", "", sub_region_2),
      sub_region_2 = gsub(" Borough", "", sub_region_2)
    )

  #fix one spelling error
  counties <- counties %>%
    dplyr::mutate(
      sub_region_2 = ifelse(location_code==22059, "La Salle", sub_region_2))

  #merge
  gmob_lut <- dplyr::left_join(gmob_unique,
                        counties)

  #return
  gmob_lut
  }

