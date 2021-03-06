% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_layer_hexagon.R
\name{add_hexagon}
\alias{add_hexagon}
\title{Add hexagon}
\usage{
add_hexagon(map, data = get_map_data(map), polyline = NULL,
  lon = NULL, lat = NULL, layer_id = NULL, radius = 1000,
  elevation = NULL, elevation_function = c("total", "average"),
  colour = NULL, colour_function = c("total", "average"),
  elevation_scale = 1, auto_highlight = FALSE,
  highlight_colour = "#AAFFFFFF", colour_range = NULL,
  update_view = TRUE, focus_layer = FALSE, transitions = NULL)
}
\arguments{
\item{map}{a mapdeck map object}

\item{data}{data to be used in the layer. All coordinates are expected to be in
Web Mercator Projection}

\item{polyline}{column of \code{data} containing the polylines}

\item{lon}{column containing longitude values}

\item{lat}{column containing latitude values}

\item{layer_id}{single value specifying an id for the layer. Use this value to
distinguish between shape layers of the same type. Layers with the same id are likely
to conflict and not plot correctly}

\item{radius}{in metres. Default 1000}

\item{elevation}{column containing the elevation of the value. This is used to calculate the
height of the hexagons. The height is calculated by the sum of elevations of all the coordinates
within the \code{radius}. If NULL, the number of coordinates is used.}

\item{elevation_function}{either "total" or "average"}

\item{colour}{column containing numeric values to colour by.
The colour is calculated by the sum of values within the \code{radius}.
If NULL, the number of coordinates is used.}

\item{colour_function}{either "total" or "average"}

\item{elevation_scale}{value to sacle the elevations of the hexagons. Default 1}

\item{auto_highlight}{logical indicating if the shape under the mouse should auto-highlight}

\item{highlight_colour}{hex string colour to use for highlighting. Must contain the alpha component.}

\item{colour_range}{vector of 6 hex colours}

\item{update_view}{logical indicating if the map should update the bounds to include this layer}

\item{focus_layer}{logical indicating if the map should update the bounds to only include this layer}

\item{transitions}{list specifying the duration of transitions.}
}
\description{
The Hexagon Layer renders a hexagon heatmap based on an array of points.
It takes the radius of hexagon bin, projects points into hexagon bins.
The color and height of the hexagon is scaled by number of points it contains.
}
\details{
\code{add_hexagon} supports POINT and MULTIPOINT sf objects
}
\section{data}{


If the \code{data} is a simple feature object, the geometry column is automatically
detected. If the sf object contains more than one geometry column and you want to use a specific one,
you'll need to set the active geometry using \code{sf::st_geometry( x ) <- "your_column" },
where \code{"your_column"} is the name of the column you're activating. See \code{?sf::st_geometry}
}

\examples{
\dontrun{

## You need a valid access token from Mapbox
key <- 'abc'

df <- read.csv(paste0(
'https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/'
, '3d-heatmap/heatmap-data.csv'
))

df <- df[!is.na(df$lng), ]

mapdeck( token = key, style = mapdeck_style("dark"), pitch = 45) \%>\%
add_hexagon(
  data = df
  , lat = "lat"
  , lon = "lng"
  , layer_id = "hex_layer"
  , elevation_scale = 100
)

library( sf )
sf <- sf::st_as_sf( df, coords = c("lng", "lat"))
mapdeck( token = key, style = mapdeck_style("dark"), pitch = 45 ) \%>\%
add_hexagon(
  data = sf
  , layer_id = "hex_layer"
  , elevation_scale = 100
)

## Using elevation and colour
df$weight <- 1
df$colour <- 1
df[10, ]$weight <- 100000
df[1000, ]$colour <- 100000

mapdeck( token = key, style = mapdeck_style("dark"), pitch = 45) \%>\%
add_hexagon(
  data = df
  , lat = "lat"
  , lon = "lng"
  , layer_id = "hex_layer"
  , elevation_scale = 100
  , elevation = "weight"
  , colour = "colour"
)


}

}
