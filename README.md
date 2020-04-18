# geosparklines

Turn your stats into a SparkLine Map !

geosparklines is an R package to create geographically placed sparklines

## Quick Start

### Installation
```r
devtools::install_github("datagistips/geosparklines", build_vignettes = TRUE)
```

### Usage

```r
f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

geosparks <- geospark(f[, c("Long", "Lat")], f[, 5:ncol(f)], width=20, height=20, mode = "log") # log transformed sparklines
```

### Vignettes
See [vignette](vignettes/how-to-use-geosparklines.html) for further explanations ;-)

## Example map
Example map on COVID-19 cases in France rendered in QGIS

## Licence
Author : Mathieu Rajerison  
CC-BY