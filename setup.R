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
use_r("refresh_covid19mobility")
use_r("geospatial_utils.R")
use_r("geospatial_lut.R")

#what packages will we need to make our lives easy
use_package("jsonlite")
use_package("readr")
use_package("tidyr")
use_package("dplyr")
#use_package("rnaturalearth")
use_package("lubridate")
use_package("utils")
use_pipe()

#setup the data for the package
use_data_raw("covid19mobility_country_demo")
use_r("data.R")
use_r("globals.R")

#tests
use_test("check_country_length")

#make sure everything is a-ok
devtools::spell_check()
styler::style_pkg()

