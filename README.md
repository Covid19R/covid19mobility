
<!-- README.md is generated from README.Rmd. Please edit that file -->

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

| data\_set\_name                   | function\_to\_get\_data               | data\_details                                                                                                                                                                         |
| :-------------------------------- | :------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| covid19mobility\_apple\_country   | refresh\_covid19mobility\_country     | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the country level.           |
| covid19mobility\_apple\_subregion | refresh\_covid19mobility\_subregion   | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the subregion (state) level. |
| covid19mobility\_apple\_city      | refresh\_covid19mobility\_apple\_city | Data reflects relative volume of directions requests compared to a baseline volume on January 13th, 2020 for multiple transportation modes aggregated at the city level.              |

The refresh methods bring in the different data sets. Currentail
available are: \* `refresh_covid19mobility_apple_country()` - [Apple
Mobility Data](https://www.apple.com/covid19/mobility) at the country
level.  
\* `refresh_covid19mobility_subregion()` - [Apple Mobility
Data](https://www.apple.com/covid19/mobility) at the state/subregion
level.  
\* `refresh_covid19mobility_apple_city()` - [Apple Mobility
Data](https://www.apple.com/covid19/mobility) at the city level.
Contains some lat/longs for some cities.

For example

``` r
refresh_covid19mobility_apple_city() %>%
  head()
#> # A tibble: 6 x 10
#>   location_type location data_type alternative_name `sub-region` country
#>   <chr>         <chr>    <chr>     <chr>            <chr>        <chr>  
#> 1 city          Aachen   driving   <NA>             North Rhine… Germany
#> 2 city          Aachen   driving   <NA>             North Rhine… Germany
#> 3 city          Aachen   driving   <NA>             North Rhine… Germany
#> 4 city          Aachen   driving   <NA>             North Rhine… Germany
#> 5 city          Aachen   driving   <NA>             North Rhine… Germany
#> 6 city          Aachen   driving   <NA>             North Rhine… Germany
#> # … with 4 more variables: date <dttm>, value <dbl>, location_code_type <chr>,
#> #   location_code <chr>
```

## Data Use and Licensing

Please see the relevant information about each data set and their
licenses if you plan on using these data in any published works.
