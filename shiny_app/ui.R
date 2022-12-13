#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define UI for application that draws a histogram
shinyUI(dashboardPage(
  
  # Application title
  dashboardHeader(title='Davidson County HUD'),
  
  # Sidebar with a slider input for number of bins
  dashboardSidebar(
    sidebarMenu(
      menuItem('Map', tabName = 'map', icon = icon('map-location-dot')),
      menuItem('Data',tabName = 'data', icon = icon('database'))
               #badgeLabel = "new", badgeColor = "green"
    )
  ),
  
  # Show a plot of the generated distribution
  dashboardBody(
    tabItems(
      tabItem(tabName = 'map',
              h2('Map'),
              leafletOutput('housing_map')
      ),
      tabItem(tabName = 'data',
              h2('Data')
      )
      
    )
    
  ))
)
  