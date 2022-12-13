#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$housing_map <- renderLeaflet({
    leaflet(options = leafletOptions(minZoom = 10)) %>%
      addProviderTiles(provider = "CartoDB.Voyager") %>%
      setView(lng = -86.7816, lat = 36.1627, zoom = 12) %>%
      setMaxBounds(lng1 = -86.7816 + 1, 
                   lat1 = 36.1627 + 1, 
                   lng2 = -86.7816 - 1, 
                   lat2 = 36.1627 - 1) %>%
      addCircleMarkers(data = total_HUD_sf,
                       radius = 5,
                       color = "white",
                       weight = 1,
                       fillColor = "red",
                       fillOpacity = 0.75) %>%
      addMarkers(data = sales_and_HUD_sf,
                 clusterOptions = markerClusterOptions()) %>%
      addPolylines(data = boarder_shapefile)
    
  })
  
})
