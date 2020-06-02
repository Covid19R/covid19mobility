#'-----------------------------------------
#' Setup script for covid19mobility
#'-----------------------------------------

library(devtools)
library(usethis)

#create_tidy_package("./covid19mobility")

#setup the package
usethis::use_mit_license(name = "Jarrett Byrnes")
use_code_of_conduct()

#add some functions
use_r("refresh_covid19mobility_apple")
use_r("refresh_covid19mobility_google")
use_r("geospatial_utils.R")
use_r("geospatial_lut.R")
use_r("geospatial_load.R")
use_r("get_info_covid19mobility.R")

#what packages will we need to make our lives easy
use_package("jsonlite")
use_package("readr")
use_package("tidyr")
use_package("dplyr")
use_package("rnaturalearth", type = "Suggests")
use_package("lubridate")
use_package("utils")
use_package("tigris")
use_package("stringi")
use_pipe()
use_package("ggplot2", type = "Suggests")

#setup the data for the package
use_data_raw("covid19mobility_country_demo")
use_data_raw("nat_codes")
use_r("data.R")
use_r("globals.R")
use_r("lut.R")

#make vignettes
use_vignette("plot_us_mobility")

#tests
use_test("check_country_length")

#make sure everything is a-ok
devtools::spell_check()
styler::style_pkg()

#remake the website
pkgdown::build_site()

#build vignette
devtools::install(build_vignettes = TRUE)

#start github
use_git(message = "Initial Commit")


#Final checks for release
#devtools::check_rhub()
#devtools::check_win_release()
devtools::release_checks()

#devtools::release()
