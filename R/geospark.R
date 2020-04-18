#' Calculate geographically placed Sparklines basd upon statistical values
#'
#' @param coords Points coordinates
#' @param my_stats Values associated to points
#' @param width Width
#' @param height Height
#' @param mode normal mode or log mode
#'
#' @return returns a geometry collection (sfc)
#' @import magrittr sf dplyr
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
