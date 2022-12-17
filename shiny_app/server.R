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
  
  output$initial_housing_map <- renderLeaflet({
    leaflet(options = leafletOptions(minZoom = 10)) %>%
      addProviderTiles(provider = "CartoDB.Voyager") %>%
      setView(lng = -86.7816, lat = 36.1627, zoom = 10) %>%
      setMaxBounds(lng1 = -86.7816 + 1, 
                   lat1 = 36.1627 + 1, 
                   lng2 = -86.7816 - 1, 
                   lat2 = 36.1627 - 1) %>%
      addCircleMarkers(data = initial_HUD_sf,
                       radius = 5,
                       color = "white",
                       weight = 1,
                       fillColor = "red",
                       fillOpacity = 0.75) %>%
      addMarkers(data = initial_sales_details_sf %>%
                   distinct(apn, .keep_all = TRUE),
                 clusterOptions = markerClusterOptions()) %>%
      addPolylines(data = boarder_shapefile)
  })
  
  output$final_housing_map <- renderLeaflet({
    leaflet(options = leafletOptions(minZoom = 10)) %>%
      addProviderTiles(provider = "CartoDB.Voyager") %>%
      setView(lng = -86.7816, lat = 36.1627, zoom = 10) %>%
      setMaxBounds(lng1 = -86.7816 + 1, 
                   lat1 = 36.1627 + 1, 
                   lng2 = -86.7816 - 1, 
                   lat2 = 36.1627 - 1) %>%
      addCircleMarkers(data = final_HUD_sf,
                       radius = 5,
                       color = "white",
                       weight = 1,
                       fillColor = "red",
                       fillOpacity = 0.75) %>%
      addMarkers(data = final_sales_details_sf %>%
                   distinct(apn, .keep_all = TRUE),
                 clusterOptions = markerClusterOptions()) %>%
      addPolylines(data = boarder_shapefile)
    
  })
  
  output$initial_dist <- renderPlot({
    ggplot(initial_sales_details_sf)+
      geom_sf(aes(colour=as.numeric(nearest_HUD_dist)))+
      geom_sf(data = initial_HUD_sf, shape=23) +
      geom_path(data = county.lines, mapping=aes(x=long, y=lat, group=group)) +
      scale_colour_gradientn(colours=rainbow(100)[75:1])+
      labs(colour='Distance') 
  })
  
  output$final_dist <- renderPlot({
    ggplot(final_sales_details_sf)+
      geom_sf(aes(colour=as.numeric(nearest_HUD_dist)))+
      geom_sf(data = final_HUD_sf, shape=23) +
      geom_path(data = county.lines, mapping=aes(x=long, y=lat, group=group)) +
      scale_colour_gradientn(colours=rainbow(100)[75:1]) +
      labs(colour='Distance') 
  })
  
  output$sales_table <- renderDataTable({
    st_drop_geometry(final_sales_details_sf) %>%
      filter(age %in% input$age_range[1]:input$age_range[2]) %>% 
      select(apn, amount, age, HUD_ID, group)
  })
  
})
