
# covid19mobility

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/covid19mobility)](https://CRAN.R-project.org/package=covid19mobility)
<!-- badges: end -->

The goal of covid19mobility is to make mobility data from different
sources available using the [Covid19R Project Data Format
Standard](https://covid19r.github.io/documentation/data-format-standard.html).
Currently, this package imports data from:  
\* The [Apple Mobility Trends
Report](https://www.apple.com/covid19/mobility)

  - The \[Google Covid-19 Mobility Trends\]
    (<https://www.google.com/covid19/mobility/>)

## Installation

<!--
You can install the released version of covid19mobility from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("covid19mobility")
```
-->

You can install the current version of covid19mobility from github with:

``` r
remotes::install_github("covid19r/covid19mobility")
```

## Data Format

The covid19mobility library follows the [Covid19R Project Data Format
Standard](https://covid19r.github.io/documentation/data-format-standard.html),
with some data sets holding extra data columns. To see what data is
available, use `get_info_covid19mobility()`

``` r
library(covid19mobility)

get_info_covid19mobility() %>%
  dplyr::select(data_set_name, function_to_get_data, data_details) %>%
  knitr::kable()
```

| data\_set\_name                   | function\_to\_get\_data                    | data\_details                                                                                                                                                                         |
| :-------------------------------- | :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| covid19mobility\_apple\_country   | refresh\_covid19mobility\_apple\_country   | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the country level.           |
| covid19mobility\_apple\_subregion | refresh\_covid19mobility\_apple\_subregion | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the subregion (state) level. |
| covid19mobility\_apple\_city      | refresh\_covid19mobility\_apple\_city      | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the city level.              |

The refresh methods bring in the different data sets. Currently
available are: \* `refresh_covid19mobility_apple_country()` - [Apple
Mobility Data](https://www.apple.com/covid19/mobility) at the country
level.  
\* `refresh_covid19mobility_subregion()` - [Apple Mobility
Data](https://www.apple.com/covid19/mobility) at the state/subregion
level.  
\* `refresh_covid19mobility_apple_city()` - [Apple Mobility
Data](https://www.apple.com/covid19/mobility) at the city level.
Contains some lat/longs for some cities. \*
`refresh_covid19mobility_google_country()` - [Google Mobility
Data](https://www.google.com/covid19/mobility/) at the country level.  
\* `refresh_covid19mobility_google_subregions()` - [Google Mobility
Data](https://www.google.com/covid19/mobility/) at the state/subregion
level.  
\* `refresh_covid19mobility_google_us_counties()` - [Google Mobility
Data](https://www.google.com/covid19/mobility/) at the US county level
with FIPS codes.

For example

``` r
refresh_covid19mobility_google_us_counties() %>%
  head()
#> Downloading: 16 kB     Downloading: 16 kB     Downloading: 16 kB     Downloading: 16 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 41 kB     Downloading: 41 kB     Downloading: 41 kB     Downloading: 41 kB     Downloading: 49 kB     Downloading: 49 kB     Downloading: 49 kB     Downloading: 49 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 65 kB     Downloading: 81 kB     Downloading: 81 kB     Downloading: 81 kB     Downloading: 81 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 89 kB     Downloading: 89 kB     Downloading: 89 kB     Downloading: 89 kB     Downloading: 97 kB     Downloading: 97 kB     Downloading: 97 kB     Downloading: 97 kB     Downloading: 97 kB     Downloading: 97 kB     Downloading: 110 kB     Downloading: 110 kB     Downloading: 110 kB     Downloading: 110 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 160 kB     Downloading: 160 kB     Downloading: 160 kB     Downloading: 160 kB     Downloading: 160 kB     Downloading: 160 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 190 kB     Downloading: 190 kB     Downloading: 190 kB     Downloading: 190 kB     Downloading: 190 kB     Downloading: 190 kB       |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   2%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |================                                                      |  22%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  32%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |==========================                                            |  37%  |                                                                              |==========================                                            |  38%  |                                                                              |============================                                          |  39%  |                                                                              |=============================                                         |  41%  |                                                                              |==============================                                        |  42%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  62%  |                                                                              |=============================================                         |  64%  |                                                                              |=============================================                         |  65%  |                                                                              |===============================================                       |  67%  |                                                                              |===============================================                       |  68%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |===================================================                   |  72%  |                                                                              |====================================================                  |  74%  |                                                                              |=====================================================                 |  75%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  85%  |                                                                              |=============================================================         |  87%  |                                                                              |=============================================================         |  88%  |                                                                              |===============================================================       |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |=================================================================     |  92%  |                                                                              |==================================================================    |  94%  |                                                                              |===================================================================   |  95%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |======================================================================| 100%
#> # A tibble: 6 x 8
#>   date       location location_type location_code location_code_t… data_type
#>   <date>     <chr>    <chr>         <chr>         <chr>            <chr>    
#> 1 2020-02-15 Autauga… county        01001         fips             retail_a…
#> 2 2020-02-15 Autauga… county        01001         fips             grocery_…
#> 3 2020-02-15 Autauga… county        01001         fips             parks_pe…
#> 4 2020-02-15 Autauga… county        01001         fips             transit_…
#> 5 2020-02-15 Autauga… county        01001         fips             workplac…
#> 6 2020-02-15 Autauga… county        01001         fips             resident…
#> # … with 2 more variables: value <int>, state <chr>
```

## Data Use and Licensing

Please see the relevant information about each data set and their
licenses if you plan on using these data in any published works.
