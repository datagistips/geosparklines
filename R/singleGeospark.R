#' Generate a Spatial Sparkline as Simple Feature Geometry (sfg)
#'
#' @param coords Point coordinates
#' @param values Values associated to point
#' @param max_value Maximum value
#' @param width width
#' @param height height
#' @param mode normal mode or log mode
#' @param direction Direction of lines, upward (north), downward (south), left (west) or right (east). For instance, "ne" will generate upward right lines.
#'
#' @return returns a geometry (sfg)
#' @import magrittr sf dplyr
#' @export

singleGeospark <- function(coords, values, max_value = NULL, width, height, direction = "ne", mode = "normal") {

  ## direction
  diry <- ifelse(substr(direction, 1, 1) == "n", 1, -1)
  dirx <- ifelse(substr(direction, 2, 2) == "e", 1, -1)

  ## Max Value
  if(is.null(max_value)) max_value <- max(values)

  if(mode == "normal") {
    mult <- height / max_value
    heights <- values * mult
  } else if (mode == "log"){

    ## Shift values if < 0
    if(min(values) < 0) {
      values <- values - min(values)
      max_value <- max_value - min(values)
    }
    mult <- height / log(max_value)
    log_v <- ifelse(values == 0, 0, log(values))
    heights <- log_v * mult
  }

  coords_x <- coords[1] + dirx * seq(0, width, length.out = length(values))
  coords_y <- coords[2] + diry * heights
  coords <- cbind(coords_x, coords_y)

  ## Line
  sp_line <- st_linestring(coords)

  return(sp_line)
}
