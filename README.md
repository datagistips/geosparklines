# geosparklines

`geosparklines` is an R package to generate SparkLines SimpleFeatureCollection (sfc) objects which can be further put on a Map

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
See [vignette](vignettes/how-to-use-geosparklines.html) for further explanations and an example on using Plate Carrée CRS instead ;-)

## Rendering
You can render data :

- in R with `ggplot`, `leaflet`
- or export it and render it in QGIS.

Here is a map rendered in QGIS :

<img src="https://raw.githubusercontent.com/datagistips/sparkline_map/master/images/map.png" width=500 height=500 align=middle></img>

## License
Author : Mathieu Rajerison  
License : GPL-3