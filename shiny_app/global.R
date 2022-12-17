library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(sf)
library(maps)

initial_HUD_sf <- readRDS('initial_HUD_sf.RDS')
final_HUD_sf <- readRDS('final_HUD_sf.RDS')

initial_sales_details_sf <- readRDS('initial_sales_details.RDS')
final_sales_details_sf <- readRDS('final_sales_details_sf.RDS')

county.lines <- subset(map_data('county'),region=='tennessee' & subregion=='davidson')

boarder_shapefile <- st_read('../data/Davidson County Border (GIS)/geo_export_b5e434a6-a620-409b-a8a2-610c823b7c51.shp', as_tibble = T, quiet = T) %>%
  st_transform('+proj=longlat +datum=WGS84')

