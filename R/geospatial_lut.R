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
    "Ceatharlach", "An Cabhán", "An Clár",
    "Corcaigh", "Dún na nGall",
    "Baile Átha Cliath",
    "Gaillimh", "Ciarraí", "Cill Dara",
    "Cill Chainnigh", "Laois",
    "Liatroim", "Luimneach",
    "An Longfort", "Lú", "Maigh Eo", "An Mhí",
    "Muineachán", "Uíbh Fhailí",
    "Ros Comáin", "Sligeach",
    "Tiobraid Árann", "Port Láirge",
    "An Iarmhí", "Loch Garman",
    "Cill Mhantáin"
  )
)

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
      location = gsub("Województwo ", "", location),
      location = gsub("Region ", "", location),
      location = gsub("Región de ", "", location),
      location = gsub("Región ", "", location),
      location = gsub("Provincie ", "", location),
      location = gsub("^of  ", "", location)
    )
}
