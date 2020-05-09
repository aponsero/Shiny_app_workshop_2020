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

NEED TO ADD A SMALL EXPLANATION ON ADDING STUFF IN THE FLUIDPAGE

 
### Using Shiny Layouts to organize your App

More complex App layouts can also be usefull to quickly organize your page and the navigation. A navigation bar and several tabs can be created using the NavBarPage layout.

This Layout is composed of a NavBarPage that contain the global app. you can add to this page a main title. To create tabs, use the TabPanel() function.


```R
ui <- navbarPage(title = "Ramen ratings",
                 fluid = TRUE, 
                   
                   # ----------------------------------
                   # tab panel 1 - Top ten best ramens
                   tabPanel(title = "Top ramen",
                            
                   ), # end tabPanel panel
                   # ----------------------------------
                   # tab panel 2 - Top ten best ramens
                   tabPanel(title = "Country",
                            
                            
                   ) # end tabPanel panel
                   # ----------------------------------
) # end NavPage panel
```
Run the app, this code should have create a page with a navigation bar and two (empty) tabs.


Another popular layout is the sidebar layout. It allows to separate your screen into a sidebar and a main panel. Here we'll create a sidebar layout on the two tabs created.

```R
ui <- navbarPage(title = "Ramen ratings",
                 fluid = TRUE, 
                   
                   # ----------------------------------
                   # tab panel 1 - Top ten best ramens
                   tabPanel(title = "Top ramen",

	                   	sidebarLayout(fluid=TRUE,
	                		sidebarPanel(
	                  			p("side panel"),
	                		),
	                		mainPanel(
	                  			p("main panel"),
	                		) # end main panel
	  					), # end sidebar Layout
                            
                   ), # end tabPanel panel
                   # ----------------------------------
                   # tab panel 2 - Top ten best ramens
                   tabPanel(title = "Country",
                        sidebarLayout(fluid=TRUE,
	                		sidebarPanel(
	                  			p("side panel"),
	                		),
	                		mainPanel(
	                  			p("main panel"),
	                		) # end main panel
  					), # end sidebar Layout    
                            
                   ) # end tabPanel panel
                   # ----------------------------------
) # end NavPage panel
```

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
ui <- fluidPage(
    # ----------------------------------
           # tab panel 1 - Top ten best ramens
           tabPanel(title = "Top ramen",

               	sidebarLayout(fluid=TRUE,
            		sidebarPanel(
              			p("side panel"),
            		),
            		mainPanel(
              			p("main panel"),
            		) # end main panel
					), # end sidebar Layout
                    
           ), # end tabPanel panel
)
```

Note that the elements in the fluidPage should be listed using commas. Rstudio will complain if you forget them!

When you run the app you should now see on the page the title and text we added.

Next, we want to add a picture. Download the picture from the github repo : LINK. Create a folder www in the same directory as your app. Place the picture in that folder, so the app knows where to look for the picture.

Next, we add a picture and center it to the page.
```R
ui <- fluidPage(
  h1("Best Ramens in the world", align = "center"),
  p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
  select your favorite ramen style and the country of fabrication. The table below display the top ten 
    ramens for this selection!"),
  HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
  HTML('<br/>'),
)
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
ui <- fluidPage(
  h1("Best Ramens in the world", align = "center"),
  p("Explore the best ramens in the world, recommended by the users themselves! In this tab, you can 
  select your favorite ramen style and the country of fabrication. The table below display the top ten 
    ramens for this selection!"),
  HTML('<center><img src="1200px-Shoyu_Ramen.jpg" width="100%"></center>'),
  HTML('<br/>'),
  includeHTML("footer.html"),
)
```



### Adding widgets for user inputs





