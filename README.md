
# covid19mobility

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/covid19mobility)](https://CRAN.R-project.org/package=covid19mobility)
<!-- badges: end -->

The goal of covid19mobility is to make mobility data from different
sources available using the [Covid19R Project Data Format
Standard](https://covid19r.github.io/documentation/data-format-standard.html).
Currently, this package imports data from:  

  - The [Apple Mobility Trends
    Report](https://www.apple.com/covid19/mobility)

  - The [Google Covid-19 Mobility
    Trends](https://www.google.com/covid19/mobility/)

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

| data\_set\_name                       | function\_to\_get\_data                        | data\_details                                                                                                                                                                                                                                     |
| :------------------------------------ | :--------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| covid19mobility\_apple\_country       | refresh\_covid19mobility\_apple\_country       | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the country level.                                                                       |
| covid19mobility\_apple\_subregion     | refresh\_covid19mobility\_apple\_subregion     | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the subregion (state) level.                                                             |
| covid19mobility\_apple\_city          | refresh\_covid19mobility\_apple\_city          | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the city level.                                                                          |
| covid19mobility\_google\_country      | refresh\_covid19mobility\_google\_country      | Changes for each day are compared to a baseline value for that day of the week as compared to the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories.                                                          |
| covid19mobility\_google\_subregions   | refresh\_covid19mobility\_google\_subregions   | Changes for each day are compared to a baseline value for that day of the week as compared to the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories. Data is aggregated at the state or subdivision level.    |
| covid19mobility\_google\_us\_counties | refresh\_covid19mobility\_google\_us\_counties | Changes for each day are compared to a baseline value for that day of the week as compared to the 5-week period Jan 3-Feb 6, 2020 for visits to places falling in to certain categories. Data is aggregated at the county level for the USA only. |

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
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   1%  |                                                                              |=======                                                               |   9%  |                                                                              |==========                                                            |  14%  |                                                                              |================                                                      |  22%  |                                                                              |===================                                                   |  27%  |                                                                              |=========================                                             |  35%  |                                                                              |============================                                          |  39%  |                                                                              |==================================                                    |  48%  |                                                                              |=====================================                                 |  52%  |                                                                              |===========================================                           |  61%  |                                                                              |==============================================                        |  65%  |                                                                              |====================================================                  |  74%  |                                                                              |=======================================================               |  78%  |                                                                              |=============================================================         |  87%  |                                                                              |================================================================      |  91%  |                                                                              |======================================================================| 100%
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  31%  |                                                                              |======================                                                |  31%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  68%  |                                                                              |================================================                      |  68%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> # A tibble: 6 x 7
#>   date       location location_type location_code location_code_t… data_type
#>   <date>     <chr>    <chr>         <chr>         <chr>            <chr>    
#> 1 2020-02-15 Autauga… county        01001         fips_code        retail_a…
#> 2 2020-02-15 Autauga… county        01001         fips_code        grocery_…
#> 3 2020-02-15 Autauga… county        01001         fips_code        parks_pe…
#> 4 2020-02-15 Autauga… county        01001         fips_code        transit_…
#> 5 2020-02-15 Autauga… county        01001         fips_code        workplac…
#> 6 2020-02-15 Autauga… county        01001         fips_code        resident…
#> # … with 1 more variable: value <int>
```

## Data Use and Licensing

Please see the relevant information about each data set and their
licenses if you plan on using these data in any published works.
