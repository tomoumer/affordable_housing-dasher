library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(sf)

initial_HUD_sf <- readRDS('initial_HUD_sf.rds')
final_HUD_sf <- readRDS('final_HUD_sf.rds')

initial_sales_details_sf <- readRDS('initial_sales_details_sf.rds')
final_sales_details_sf <- readRDS('final_sales_details_sf.rds')

# this is the binning used (in miles):
# 0, 0.5, 1, 1.5, 2, 3, 4, 5, 6, 7, Inf
pal_initial <- readRDS('pal_initial.rds')

boarder_shapefile <- st_read('../data/Davidson County Border (GIS)/geo_export_b5e434a6-a620-409b-a8a2-610c823b7c51.shp', as_tibble = T, quiet = T) %>%
  st_transform('+proj=longlat +datum=WGS84')

