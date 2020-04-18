# geosparklines

`geosparklines` is an R package to put SparkLines on a Map

## Quick Start

### Installation
```r
devtools::install_github("datagistips/geosparklines", build_vignettes = TRUE)
```

### Usage

```r
library(geosparklines)
library(readr)

f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

geosparks <- geospark(f[, c("Long", "Lat")], f[, 5:ncol(f)], width=20, height=20, mode = "log") # log transformed sparklines as an sfc (Simple Feature Collection)

st_geometry(f) <- geosparks
```

### Vignettes
See [vignette](vignettes/how-to-use-geosparklines.html) for further explanations ;-)

## Example map
[Example map on COVID-19 cases in France rendered in QGIS](https://github.com/datagistips/sparkline_map/blob/master/images/map.png)

## Licence
Author : Mathieu Rajerison  
CC-BY