# Ramen Rating Shiny App tutorial

This tutorial will show you step by step how to create the Ramen Rating Shiny App, and cover the architecture and the main basic functions available in Shiny. This is not an exhaustive view on what is possible through Shiny App, but rather a first step to create your own more complex apps.

## Create the minimal functioning App

Open R studio and create a new blank R script. Copy paste the minimal functioning app below:


```R
library(shiny)

ui <- fluidPage()

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

```

Save the script in a dedicated folder, and make sure to call this script "App.R".

You can then run this app. This will open a blank page!

## Understand the UI function

First, we'll take a look at the UI function. This function contains all that you want to display to the user.

In the code above, you see that we are using the function "fluidPage()" to create a blank web page. Inside this page we'll place all elements we want to display.

### Adding HTML elements to the UI

Now that we have a global layout, let's add HTML elements such as a title, a description and a picture. In your app, you can add directly HTML code using the function: 

```R
HTML()
```

Additionally, Shiny allows to easily add to the app the main elements you can find in an HTML page:

| Shiny function        | desc           | HTML  |
| ------------- |:-------------:| -----:|
| p()      | text | ``` <p> ``` |
| h1()...h6()     | header      |  ``` <h1>...<h6> ``` |
| a() | Link      |   ``` <a> ```|
| br() | break      |   ``` <br> ```|
| div() | Link      |   ``` <div> ``` |
| span() | in-line division of text      |   ``` <span> ```|
| img() | image      |   ``` <img> ```|
| strong() | bold text      |   ``` <strong> ```|
| em() | italicized text      |  ```  <em> ```|
| img() | image      |   ``` <img> ```|
| code() | block of code      |   ``` <code> ```|

 	
Let's add to our app a title and some descriptive text in the first tab:

```R
ui <- fluidPage(fluid = TRUE, 
                # ----------------------------------
                h1("Best Ramens in the world", align = "center"),
                p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!")
                # ----------------------------------

) # end fluidpage panel
```

Note that the elements in the fluidPage should be listed using commas. Rstudio will complain if you forget them!

When you run the app you should now see on the page the title and text we added.

Next, we want to add a picture. Download the picture from the github repo : LINK. Create a folder www in the same directory as your app. Place the picture in that folder, so the app knows where to look for the picture.
Here is the code to add a picture and center it to the page.

```R
ui <- fluidPage(fluid = TRUE, 
                # ----------------------------------
                h1("Best Ramens in the world", align = "center"),
                p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!")
                HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                br()
                # ----------------------------------

) # end fluidpage panel

```

Run the app. Note that the app is reactive to the size of the window! When you resize the window, the app will resize the elements automatically for a better display of your app on different screen sizes.

### Adding a HTML code from another file

It is also possible to directly include HTML code from another document directly into your app using the function:

```R
includeHTML()
```

As an exemple, we'll add a footer saved in a separate HTML file. Download the footer.html fine into your app directory. 
Let's link it in the App and specify that it is our footer.

```R
ui <- fluidPage(fluid = TRUE, 
                # ----------------------------------
                h1("Best Ramens in the world", align = "center"),
                p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!")
                HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                br()
                # ----------------------------------

                # ----------------------------------
                includeHTML("footer.html"),
) # end fluidpage panel
```

### Using Shiny Layouts to organize your App

More complex App layouts can also be usefull to quickly organize your page and the navigation. 
As an exemple, a navigation bar and several tabs can be created using the NavBarPage layout instead of the fluidPage.

A very popular layout is the sidebar layout. It allows to separate your page into a sidebar and a main panel. Let's use this layout for our app.

```R
ui <- fluidPage(fluid = TRUE, 
                # ----------------------------------
                h1("Best Ramens in the world", align = "center"),
                p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!"),
                HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                br(),
                # ----------------------------------
                sidebarLayout(fluid=TRUE,
                              sidebarPanel(
                                h3("side bar")
                                
                              ),
                              mainPanel(
                                h3("main panel")
                              ), # end main panel
                ),
                # ----------------------------------
                includeHTML("footer.html"),
) # end fluidpage
```

### Importing Data into the App

For most apps, you'll want to be able to use and display your own dataset. To do so, you can simply import your dataset before declaring the ui.
For our Ramen App, you'll need to download the dataset here. Place it in the same folder as your app.

To be able to manipulate our dataset, we'll import the complete tidyverse library.

```R
library(shiny)
library(tidyverse)


# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("ramen_dataset.csv")
```

### Adding widgets for user inputs

So far, we have added non-reactive elements to our app. Let's now focus on adding some user imputs. In Shiny Apps, user inputs are very often widgets. The complete gallery of widget is available in the (widget gallery)["https://shiny.rstudio.com/gallery/widget-gallery.html"]

For our Ramen App, let's add a first drop down menu to select the ramen style (Cup, Bowl and Pack).

```R
selectInput("style", label="Select the ramen style:",
            c("Pack" = "Pack",
              "Bowl" = "Bowl",
              "Cup" = "Cup"), 
            selected = "Cup",
            multiple= TRUE)
```

Each widget function requires several arguments. The first two arguments for each widget are

  - a name: The name will not be shown on the sceen, but is necessary to access the widget’s value.

  - a label: This label will appear with the widget in your app.

The remaining arguments vary from widget to widget, depending on what the widget needs to do its job. You can find the exact arguments needed by a widget on the widget function’s help page, (e.g., ?selectInput).

Let's place this first widget in the sidebar of our page:

```R
ui <- fluidPage(fluid = TRUE, 
                # ----------------------------------
                h1("Best Ramens in the world", align = "center"),
                p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!"),
                HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
                br(),
                # ----------------------------------
                sidebarLayout(fluid=TRUE,
                              sidebarPanel(
                                selectInput("style", label="Select the ramen style:",
                                            c("Pack" = "Pack",
                                              "Bowl" = "Bowl",
                                              "Cup" = "Cup"), 
                                            selected = "Cup",
                                            multiple= TRUE),
                              ),
                              mainPanel(
                                h3("main panel")
                              ), # end main panel
                ),
                # ----------------------------------
                includeHTML("footer.html"),
) # end fluidpage
```
When you run the app, you should now see your widget, allowing to select the style of the Ramen.

We want a second dropdown menu to be added for the user to be able to select the country of fabrication. Because the list of country needs to be addapted to the dataset (and because we don't want to have to type all the countries names). We'll create that list directly from the dataset before the ui.

```R
# get list of countries in dataset
country_list<- ramen_ratings %>% select(country) %>% unique()
```

Then we can use directly this list in the second drop down menu. Note that for this drop down menu, we don't want to enable the multiple selection.

```R
selectInput("country", label="Select the country of fabrication:",
                    country_list, 
                    selected = "Japan",
                    multiple= FALSE)
```

Finally, we also want two radio buttons to choose the plot view.

```R
radioButtons("pType", label="Choose View:",
             list("Barchart", "Boxplot"))
```

All in all, the complete code we have so far should look like this:

```R
library(shiny)
library(tidyverse)

# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("ramen_dataset.csv")

# get list of countries in dataset
country_list<- ramen_ratings %>% select(country) %>% unique()

# UI
ui <- fluidPage(fluid = TRUE, 
  # ----------------------------------
  h1("Best Ramens in the world", align = "center"),
  p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!"),
  HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
  HTML('<br/>'),
  # ----------------------------------
  sidebarLayout(fluid=TRUE,
    sidebarPanel(
        selectInput("style", label="Select the ramen style:",
                      c("Pack" = "Pack",
                        "Bowl" = "Bowl",
                        "Cup" = "Cup"), 
                      selected = "Cup",
                      multiple= TRUE),
                      
        selectInput("country", label="Select the country of fabrication:",
                    country_list, 
                    selected = "Japan",
                    multiple= FALSE),
    
        radioButtons("pType", label="Choose View:",
                     list("Barchart", "Boxplot"))
        
        ),
        mainPanel(
          h3("main panel")
        ), # end main panel
  ),
  # ----------------------------------
  includeHTML("footer.html"),
) # end NavPage panel


server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

Good job! you now have your UI set up!


## The server function

### Understanding the interplay between UI and server function

Up until now we have been using an empty server function:

```R
server <- function(input, output) {
}
```
In the server function happens all computing tasks that are required to modify the display in reaction to user input. 
Let's first add a title in the main Panel of our app, that reacts to the selected country: 

"Best ramens in XXX"

So in the server function, we want to create a reactive variable that will store our title and that will be updated whenever the country input is modified. In the server function, we add a renderText() element, that combine "Best ramens in " and the name of the country chosen by the user. To access this country name, we can use the input variable, in which the different widget names can be directly accessed. 

In our exemple, the country name can be accessed using the input$country variable.

```R
server <- function(input, output) {
  # Title main area
  # ----------------------------------
  output$toptitle <- renderText({
    paste("Best ramens in ", input$country)
  })
}
```

Note that we redirect this renderText element to a output variable called toptitle. We now want to display this title in the main area of our page. To do so, we need to use Outputs functions from Shiny. There are a lot of different output functions, allowing you to output text, plots, images, tables... Here we need to render a Text element, so we'll use the textOutput().

Let's add this output in the main area of of ui.

```R
# UI
ui <- fluidPage(fluid = TRUE, 
  # ----------------------------------
  h1("Best Ramens in the world", align = "center"),
  p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
                select your favorite ramen style and the country of fabrication. The table below display the best three 
                ramens for this selection!"),
  HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
  HTML('<br/>'),
  # ----------------------------------
  sidebarLayout(fluid=TRUE,
    sidebarPanel(
        selectInput("style", label="Select the ramen style:",
                      c("Pack" = "Pack",
                        "Bowl" = "Bowl",
                        "Cup" = "Cup"), 
                      selected = "Cup",
                      multiple= TRUE),
                      
        selectInput("country", label="Select the country of fabrication:",
                    country_list, 
                    selected = "Japan",
                    multiple= FALSE),
    
        radioButtons("pType", label="Choose View:",
                     list("Barchart", "Boxplot"))
        
        ),
        mainPanel(
          textOutput("toptitle")
        ), # end main panel
  ),
  # ----------------------------------
  includeHTML("footer.html"),
) # end NavPage panel


server <- function(input, output) {}

shinyApp(ui = ui, server = server)
```

It is possible to add an HTML formating on the text output elements:

```R
h3(textOutput("toptitle"), align = "left")
```

If you now run your app, you should see a reactive title, changing each time the country input variable is changed.

### Adding a tables, plots and dealing with reactive elements.

```R
server <- function(input, output) {
  
  # Title main area
  # ----------------------------------
  output$toptitle <- renderText({
    paste("Best ramens in ", input$country)
  })
  
  # ----------------------------------
  # Plot outputs
  output$barplot <- renderPlot({ 
    display_dataset <- ramen_ratings %>% filter(style %in% input$style & country == input$country)

    display_dataset %>%  ggplot(aes(x=stars, fill=style)) +
      geom_histogram(color="black",binwidth = 1)+
      scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5), limits = c(-1,6))+
      ggtitle("Ramens Ratings") +
      ylab("Number of Ramens")+
      xlab("Average Ratings")+
      theme_minimal(base_size = 13)
  })
  
  output$boxplot <- renderPlot({  
    display_dataset <- ramen_ratings %>% filter(style %in% input$style & country == input$country)

    display_dataset %>% ggplot(aes(x=style, y=stars, color=style)) +
      geom_boxplot() +
      ggtitle("Ramens Ratings") +
      ylab("Average Ratings") +
      xlab("Style of Ramen") +
      theme_minimal(base_size = 13)
  })
  
}
```

```R
        mainPanel(
          h3(textOutput("toptitle"), align = "left"),
          plotOutput("barplot"),
          plotOutput("boxplot"),
        ), # end main panel
```

```R
server <- function(input, output) {
  
  # Title main area
  # ----------------------------------
  output$toptitle <- renderText({
    paste("Best ramens in ", input$country)
  })
  
  # ----------------------------------
  # Reactive elements
  display_dataset <- reactive({
    ramen_ratings %>% filter(style %in% input$style & country == input$country)
  })
  
  # ----------------------------------
  # Plot outputs
  output$barplot <- renderPlot({  
    display_dataset() %>%  ggplot(aes(x=stars, fill=style)) +
      geom_histogram(color="black",binwidth = 1)+
      scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5), limits = c(-1,6))+
      ggtitle("Ramens Ratings") +
      ylab("Number of Ramens")+
      xlab("Average Ratings")+
      theme_minimal(base_size = 13)
  })
  
  output$boxplot <- renderPlot({  
    display_dataset() %>% ggplot(aes(x=style, y=stars, color=style)) +
      geom_boxplot() +
      ggtitle("Ramens Ratings") +
      ylab("Average Ratings") +
      xlab("Style of Ramen") +
      theme_minimal(base_size = 13)
  })
  
}
```


```R
server <- function(input, output) {
  
  # Title main area
  # ----------------------------------
  output$toptitle <- renderText({
    paste("Best ramens in ", input$country)
  })
  
  # ----------------------------------
  # Reactive elements
  display_dataset <- reactive({
    ramen_ratings %>% filter(style %in% input$style & country == input$country)
  })
  
  # ----------------------------------
  # Table output
  output$top3 <- renderTable({
    display_dataset() %>% arrange(desc(stars, review_number)) %>% slice(1:3) %>% select(-continent, -review_number)
  })
  
  # ----------------------------------
  # Plot outputs
  output$barplot <- renderPlot({  
    display_dataset() %>%  ggplot(aes(x=stars, fill=style)) +
      geom_histogram(color="black",binwidth = 1)+
      scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5), limits = c(-1,6))+
      ggtitle("Ramens Ratings") +
      ylab("Number of Ramens")+
      xlab("Average Ratings")+
      theme_minimal(base_size = 13)
  })
  
  output$boxplot <- renderPlot({  
    display_dataset() %>% ggplot(aes(x=style, y=stars, color=style)) +
      geom_boxplot() +
      ggtitle("Ramens Ratings") +
      ylab("Average Ratings") +
      xlab("Style of Ramen") +
      theme_minimal(base_size = 13)
  })
  
}
```

```R
        mainPanel(
          h3(textOutput("toptitle"), align = "left"),
          tableOutput("top3"),
          plotOutput("barplot"),
          plotOutput("boxplot"),
        ), # end main panel
```


### Conditional panels

```R
        mainPanel(
          h3(textOutput("toptitle"), align = "left"),
          tableOutput("top3"),
          conditionalPanel('input.pType=="Barchart"', plotOutput("barplot")),
          conditionalPanel('input.pType=="Boxplot"',plotOutput("boxplot")),
        ), # end main panel
```


## Deploying your app on Shiny.io