#' Generates averaged Spatial Sparklines as Simple Feature Collection (sfc)
#' @description Generates Spatial Sparklines as Simple Feature Collection (sfc) based on a method by Financial Times Data Visualization Designer John Burn-Murdoch
#'
#' @param coords Points coordinates
#' @param my_stats Values associated to points as a column-wise (long) format. For instance, one column = one date
#' @param width Width of the line
#' @param height Height of the line
#' @param direction Direction of lines, upward (north), downward (south), left (west) or right (east). For instance, "ne" will generate upward right lines.
#' @param n Window size (default = 7)
#' @details
#' This function calculates sparklines and is based on a calculation by Financial Times Data Visualization Designer John Burn-Murdoch
#' When covering covid-19 crisis, he calculated a 7-day moving average (also called rolling average) of the covid-19 cases then log-transformed it
#' This method helps capture the dynamics of an exponential growth of the virus spread
#' Notably, it helps figure out the subtle details of slowdown of the spread
#' You can pilot the rendering of individual lines with finer details, with `singleGeosparkBM`
#' @seealso [geosparklines::singleGeosparkBM()], `browseVignettes("geosparklines")`
#' @return returns a geometry collection (sfc)
#' @import magrittr sf dplyr
#' @examples
#' library(readr)
#' library(sf)
#' f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
#' geosparksBM <- geosparkBM(f[, c('Long', 'Lat')], f[, 5:ncol(f)], width=20, height=20, n = 7) # Choose a
#' plot(geosparksBM)
#' st_geometry(f) <- geosparksBM
#' @export

geosparkBM <- function(coords, my_stats, width, height, direction="ne", n=7) {

  ## Get Max Value
  get_max_roll <- function(df) {
    max_value <- sapply(1:nrow(df), function(x){
      v1 <- df[x, ]
      v2 <- lead(v1, 1)
      diff_cases <- (v2 - v1) %>% as.numeric
      roll_v <- roll_meanr(diff_cases, 7)
      max_roll <- max(roll_v, na.rm = TRUE)
      return(max_roll)
    }) %>% max(na.rm = TRUE)

    return(max_value)
  }

  max_value <- get_max_roll(my_stats)

  ## Calculate lines
  out <- lapply(1:nrow(my_stats), function(x) {
    my_values <- my_stats[x, ] %>% as.numeric
    if(!all(my_values == 0)) {
      my_coords <- coords[x, ] %>% as.matrix
      singleGeosparkBM(my_coords, my_values, max_value,
                       width, height, direction)
    }
  })

  res <- st_sfc(out)

  return(res)
}
