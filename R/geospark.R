#' Generates Spatial Sparklines as Simple Feature Collection (sfc)
#'
#' @param coords Points coordinates
#' @param my_stats Values associated to points as a column-wise (long) format. For instance, one column = one date
#' @param width Total width of the line
#' @param height Total height of the line
#' @param mode Normal or Log transformation mode
#'
#' @return returns a geometry collection (sfc)
#' @import magrittr sf dplyr
#' @examples
#' library(readr)
#' library(sf)
#' f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
#' geosparks <- geospark(f[, c('Long', 'Lat')], f[, 5:ncol(f)], width=20, height=20, mode = 'log')
#' plot(geosparks)
#' st_geometry(f) <- geosparks
#' @export

geospark <- function(coords, my_stats, width, height, mode = "normal") {
  max_v <- max(my_stats)
  out <- lapply(1:nrow(coords), function(x) {
    v <- my_stats[x, ] %>% as.numeric
    my_coords <- coords[x, ] %>% as.matrix
    one_geospark(my_coords, v, max_v, width, height, mode)
  })

  res <- st_sfc(out)
  return(res)
}
