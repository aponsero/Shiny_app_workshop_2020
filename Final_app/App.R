library(shiny)
library(tidyverse)

# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")

# get list of countries in dataset
country_list<- ramen_ratings %>% select(country) %>% unique()

# UI
ui <- navbarPage(title = "Ramen ratings",
                 footer = includeHTML("footer.html"),
                 fluid = TRUE, 
                 
                 # ----------------------------------
                 # tab panel 1 - Top ten best ramens
                 tabPanel(title = "Top ramen",
                          h3("Best Ramens in the world", align = "center"),
                          HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                          HTML('<br/>'),
                          sidebarLayout(fluid=TRUE,
                                        sidebarPanel(
                                                    selectInput("style", "Select the ramen style:",
                                                                c("Pack" = "Pack",
                                                                  "Bowl" = "Bowl",
                                                                  "Cup" = "Cup"), 
                                                                selected = "Pack",
                                                                multiple= FALSE),
                                                                
                                                  selectInput("country", "Select the country of origin:",
                                                              country_list, 
                                                              selected = "Japan",
                                                              multiple= FALSE),
                                                    ),
                                        mainPanel(
                                                  tableOutput("top"),
                                                  ) # end main panel
                                        ) # sidebarlayout panel
                 ), # end tabPanel panel
                 # ----------------------------------
                 # tab panel 2 - Top ten best ramens
                 tabPanel(title = "Country",
                          h3("Best Ramens in the world", align = "center"),
                          HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                          HTML('<br/>'),
                          sidebarLayout(fluid=TRUE,
                                        sidebarPanel(
                                          
                                        ),
                                        mainPanel(
                                          
                                        ) # end main panel
                          ) # sidebarlayout panel
                 
                  ) # end tabPanel panel
                 # ----------------------------------
) # end NavPage panel


# ----------------------------------
# ----------------------------------
# ----------------------------------
# SERVER SIDE
# ----------------------------------
# ----------------------------------

server <- function(input, output) {
  
  # ----------------------------------
  # tab panel 1 - Top ten best ramens
  
  output$top <- renderTable({
    ramen_ratings %>% filter(style == input$style & country == input$country) %>% 
      arrange(desc(stars, review_number)) %>% slice(1:10)
  })
  
}

shinyApp(server = server, ui = ui)