% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geospark.R
\name{geospark}
\alias{geospark}
\title{Generates Spatial Sparklines as Simple Feature Collection (sfc)}
\usage{
geospark(coords, my_stats, width, height, direction = "ne", mode = "normal")
}
\arguments{
\item{coords}{Points coordinates}

\item{my_stats}{Values associated to points as a column-wise (long) format. For instance, one column = one date}

\item{width}{Total width of the line}

\item{height}{Total height of the line}

\item{direction}{Direction of lines, upward (north), downward (south), left (west) or right (east). For instance, "ne" will generate upward right lines, "sw" will generated downward left lines.}

\item{mode}{Normal or Log transformation mode}
}
\value{
returns a geometry collection (sfc)

returns a geometry collection (sfc)
}
\description{
Generates Spatial Sparklines as Simple Feature Collection (sfc)
}
\details{
This function calculates sparklines, based on statistical data, for instance Time-Series
You can choose width, height of the line, but also direction of the lines.
The Log transformation helps having smoother lines when having an exponential evolution.
You can pilot the rendering of individual lines with finer details, with \code{singleGeospark}
}
\examples{
library(readr)
library(sf)
f <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
geosparks <- geospark(f[, c('Long', 'Lat')], f[, 5:ncol(f)], width=20, height=20, mode = 'log')
plot(geosparks)
st_geometry(f) <- geosparks
}
\seealso{
\code{\link[geosparklines:singleGeospark]{geosparklines::singleGeospark()}}, \code{browseVignettes("geosparklines")}
}
