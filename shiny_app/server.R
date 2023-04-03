#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic 
shinyServer(function(input, output) {
  
  output$initial_housing_map <- renderLeaflet({
    map <- leaflet(options = leafletOptions(minZoom = 10, preferCanvas = TRUE)) %>%
      addProviderTiles(provider = "CartoDB.Voyager") %>%
      setView(lng = -86.7816, lat = 36.1627, zoom = 10) %>%
      setMaxBounds(lng1 = -86.7816 + 1, 
                   lat1 = 36.1627 + 1, 
                   lng2 = -86.7816 - 1, 
                   lat2 = 36.1627 - 1) %>%
      addCircleMarkers(data = initial_sales_details_sf %>%
                         distinct(apn, .keep_all=TRUE),
                       radius = 1.5,
                       color = ~pal_initial(nearest_HUD_dist),
                       weight = 1,
                       fillColor = ~pal_initial(nearest_HUD_dist),
                       fillOpacity = 0.75,
      ) %>%
      addCircleMarkers(data = initial_HUD_sf,
                       radius = 4,
                       color = "black",
                       weight = 2,
                       fillColor = "gray",
                       fillOpacity = 0.75) %>%
      addPolylines(data = boarder_shapefile) 
  })
  
  
  output$sales_table <- renderDataTable({
    st_drop_geometry(final_sales_details_sf) %>%
      filter(age %in% input$age_range[1]:input$age_range[2]) %>% 
      select(apn, amount, age, HUD_ID, group)
  })
  
})
