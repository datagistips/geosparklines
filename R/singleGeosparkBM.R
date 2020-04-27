#' Generates averaged Spatial Sparkline as Simple Feature Geometry (sfg)
#' @description Generate a Spatial Sparkline as Simple Feature Geometry (sfg) based on a method by Financial Times Data Visualization Designer John Burn-Murdoch
#'
#' @param my_coords Point coordinates
#' @param my_values Values associated to point
#' @param max_value Maximum value
#' @param width Width
#' @param height Height
#' @param direction Direction of lines, upward (north), downward (south), left (west) or right (east). For instance, "ne" will generate upward right lines.
#' @param n Window size (default = 7)
#'
#' @return returns a geometry (sfg)
#' @import magrittr sf dplyr RcppRoll
#' @importFrom utils head
#' @export

singleGeosparkBM <- function(my_coords, my_values, max_value = NULL, width, height, direction = "ne", n = 7) {

  ## Calculate difference of cases
  v1 <- my_values
  v2 <- lead(my_values, 1)
  diff_cases <- v2 - v1

  ## Direction
  diry <- ifelse(substr(direction, 1, 1) == "n", 1, -1)
  dirx <- ifelse(substr(direction, 2, 2) == "e", 1, -1)

  ## Max Value
  if(is.null(max_value)) max_value <- max(my_values)

  ## Roll mean that
  roll_values <- roll_meanr(diff_cases, n)
  roll_values <- roll_values[n:(length(roll_values)-1)] # padding : remove 7 first days and the last day because of leading

  ## Shift values if < 0
  if(min(roll_values) < 0) {
    roll_values <- roll_values - min(roll_values)
    max_value <- max_value - min(roll_values)
  }

  ## Skip zero values
  w <- which(roll_values > 0) %>% head(1)
  roll_values <- roll_values[w : length(roll_values)] # skip zero values
  width2  <- width * (length(roll_values) / length(my_values)) # update width

  ## Log that
  log_values <- ifelse(roll_values == 0, 0, log(roll_values))

  ## Shift log values to the first value
  log_values2 <- log_values - log_values[1]
  max_log_value <- log(max_value) - log_values[1]

  ## Calculate heights
  mult <- height / max_log_value # changer multiplicateur
  heights <- log_values2 * mult

  coords_x <- my_coords[[1]] + dirx * seq(0, width2, length.out = (length(log_values2)))
  coords_y <- my_coords[[2]] + diry * heights
  coords_line <- cbind(coords_x, coords_y)

  ## Lines
  sp_line <- st_linestring(coords_line)

  return(sp_line)
}
