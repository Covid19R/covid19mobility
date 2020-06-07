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
use_package("gganimate", type = "Suggests")
use_package("sf", type = "Suggests")
use_package("lubridate")
use_package("utils")
use_package("tigris")
use_package("stringi")
use_package("glue")
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
use_vignette("google_work_v_play")
use_vignette("apple_cities_across_space_and_change")
use_vignette("animating_covid19_mobility")

#tests
use_test("check_country_length")
use_test("test_get_info")
use_test("test_controlled_vocab")
use_test("test_refresh_data_length")


#make sure everything is a-ok
devtools::spell_check()
styler::style_pkg()
goodpractice::gp()

#remake the website
pkgdown::build_site()

#build vignette
devtools::install(build_vignettes = TRUE)

#start github
use_git(message = "Initial Commit")


#-------------
# Release ####
#-------------


# for release - checks!
devtools::spell_check()
devtools::check_win_release()
devtools::check_rhub()
devtools::release_checks()

#devtools::release()
