library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(sf)

sales_and_HUD_sf <- st_read(dsn='sales_and_HUD_sf', layer='sales_and_HUD_sf')
total_HUD_sf <- st_read(dsn='total_HUD_sf', layer='total_HUD_sf')
boarder_shapefile <- st_read('../data/Davidson County Border (GIS)/geo_export_b5e434a6-a620-409b-a8a2-610c823b7c51.shp', as_tibble = T, quiet = T) %>%
  st_transform('+proj=longlat +datum=WGS84')