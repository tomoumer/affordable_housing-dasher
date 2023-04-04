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
  
  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem('Dasher', tabName = 'dasher', icon = icon('people-group'), badgeLabel = "team", badgeColor = "green"),
      menuItem('Map', tabName = 'maps', icon = icon('map-location-dot')),
      menuItem('Data',tabName = 'data', icon = icon('database')),
      menuItem('Test',tabName = 'test')
    )
  ),
  
  # Main body
  dashboardBody(
    tabItems(
      tabItem(
        tabName= 'dasher',
        fluidRow(
          h2('Team Dasher'),
          p('Meet the team:'),
          tags$ul(
            tags$li('Tim Simpson'),
            tags$li('Tomo Umer'),
            tags$li('Thidathorn (Bua)  Vanitsthian')
          )
        )
      ),
      
      tabItem(tabName = 'maps',
              fluidRow(
                h2('Property Map - Initial'),
                leafletOutput('initial_housing_map')
              )#,
              #fluidRow(
              #  h2('Property Map - Final'),
              #  leafletOutput('final_housing_map')
              #)
              
      ),
        tabItem(tabName = 'data',
              h2('DataFrame'),
              sliderInput('age_range',
                          label = h3('house age range'),
                          min = final_sales_details_sf %>% 
                            pull(age) %>% 
                            min(),
                          max = final_sales_details_sf %>% 
                            pull(age) %>% 
                            max(),
                          value = c(10, 70)
              ),
              dataTableOutput('sales_table')
      ),
      
      tabItem(tabName = 'test',
              h2('Test'),
              fluidRow(
                h2('Fitting'),
                column(
                  width=6,
                  h4('Test 1')
                ),
                column(
                  width=6,
                  h4('Test 2')
                )
              ),
              
              fluidRow(
                h2('More Fitting'),
                column(
                  width=6,
                  h4('Test 3')
                ),
                column(
                  width=6,
                  h4('Test 4')
                )
              )
              
      )
      
      
    ))
))
