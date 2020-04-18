#' Calculate a geographically placed Sparkline
#'
#' @param coords Point coordinates
#' @param v Values associated to point
#' @param max_v Maximum value
#' @param width width
#' @param height height
#' @param mode normal mode or log mode
#'
#' @return returns a geometry (sfg)
#' @import magrittr sf dplyr
#' @export

one_geospark <- function(coords, v, max_v = NULL, width, height, mode = "normal") {

  if(is.null(max_v)) max_v <- max(v)

  if(min(v)< 0) v <- v - min(v)

  if(mode == "normal") {

    mult <- height / max_v
    heights <- v * mult
  } else if (mode == "log"){

    mult <- height / log(max_v)
    log_v <- ifelse(v == 0, 0, log(v))
    heights <- log_v * mult
  }

  coords_x <- coords[1] + seq(0, width, length.out = length(v))
  coords_y <- coords[2] + heights
  coords <- cbind(coords_x, coords_y)

  ## Line
  sp_line <- st_linestring(coords)

  return(sp_line)
}
