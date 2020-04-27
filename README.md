# geosparklines

`geosparklines` is an R package that you can use to create SparkLines as SimpleFeatureCollection (`sfc`) objects which can be further put on a map

## Quick Start

### Installation
```r
devtools::install_github("datagistips/geosparklines", build_vignettes = TRUE)
```

### Usage

Crteate geosparklines from a data frame
```r
library(geosparklines)
library(readr)
library(sf)

f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") # it's John Hopkins Institute Data

geosparks <- geospark(coords = f[, c("Long", "Lat")], my_stats = f[, 5:ncol(f)], width = 20, height = 20, mode = "log") # log transformed sparklines as an sfc (Simple Feature Collection)

st_geometry(f) <- geosparks
```

Or individual geosparklines, for which you can control the width, height, direction based on data
```r
sp_line <- singleGeospark(my_coords, v, width=20, height=20, direction="ne", mode="log")
```

There is also a method for generating sparklines inspired by FT Dataviz designer John Burn-Murdoch. 
```r
sp_line <- geosparkBM(my_coords, my_values, width=3, height=4, n = 21, direction = "ne"))
```

Here are for example four geosparklines with varying widths, heights, and directions

![](vignettes/RPlot.png)

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
