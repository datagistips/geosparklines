# geosparklines

`geosparklines` is an R package that you can use to create SparkLines as SimpleFeatureCollection (`sfc`) objects which can be further put on a map

## Quick Start

### Installation
```r
devtools::install_github("datagistips/geosparklines", build_vignettes = TRUE)
```

### Usage

```r
library(geosparklines)
library(readr)
library(sf)

f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") # it's John Hopkins Institute Data

geosparks <- geospark(coords = f[, c("Long", "Lat")], my_stats = f[, 5:ncol(f)], width = 20, height = 20, mode = "log") # log transformed sparklines as an sfc (Simple Feature Collection)

st_geometry(f) <- geosparks
```

### Vignette
See [vignette](vignettes/how-to-use-geosparklines.html) for further explanations and a reproducible example using Plate Carrée Coordinate Reference System instead ;-)

## Rendering
You can render data in R, for instance with `ggplot` or `leaflet`

Also, you can export data :

```r
st_write(f, "data/my_geosparlines.gpkg) ## f is the sf object generated above
```

Then render it in [QGIS](https://www.qgis.org/)

Here is a map of covid cases in France, rendered in QGIS :

<img src="https://raw.githubusercontent.com/datagistips/sparkline_map/master/images/map.png" width=483 align=middle></img>

## License
License : GPL-3  
Author : Mathieu Rajerison  
