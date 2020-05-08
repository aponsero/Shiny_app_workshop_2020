library(shiny)
library(tidyverse)

# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("ramen_dataset.csv")

# get list of countries in dataset
country_list<- ramen_ratings %>% select(country) %>% unique()

# UI
ui <- navbarPage(title = "Ramen ratings",
                 footer = includeHTML("footer.html"),
                 fluid = TRUE, 
                 
                 # ----------------------------------
                 # tab panel 1 - Top ten best ramens
                 tabPanel(title = "Top ramen",
                          h1("Best Ramens in the world", align = "center"),
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
                          h1("Best Ramens in the world", align = "center"),
                          HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                          HTML('<br/>'),
                          sidebarLayout(fluid=TRUE,
                                          sidebarPanel(
                                            selectInput("style2", "Select the ramen style:",
                                                        c("Pack" = "Pack",
                                                          "Bowl" = "Bowl",
                                                          "Cup" = "Cup"), 
                                                        selected = "Pack",
                                                        multiple= FALSE),
                                            sliderInput("ratings", "Ratings :",
                                                        min = 0, max = 5, value = c(3,5), step=1
                                            ),
                                          ),
                                        mainPanel(
                                          plotOutput("continent"),
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
  
  # ----------------------------------
  # tab panel 2 - Ratings per country
  output$continent <- renderPlot({  
            display_dataset <- ramen_ratings %>% 
              filter(style == input$style2 & stars >= input$ratings[1] & stars <= input$ratings[2])
          
            display_dataset %>% ggplot(aes(fill=country, x=continent)) + 
                                geom_bar(stat="count")+
                                ggtitle("Ramens by continents") +
                                ylab("Number of Ramens")+
                                xlab("")+
                                theme_minimal(base_size = 13)
  })
  
  
}

shinyApp(server = server, ui = ui)