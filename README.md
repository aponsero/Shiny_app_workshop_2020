# Shiny_app_workshop_2020
Material for the ResBaz 2020 workshop - Intro to Shiny app development


# Setup and requirements

## Requirements

This lessons assumes that you have some minimal knowledge of the R langage and some familiarity with RStudio. In particular, being familiar with the TidyR and ggplot2 packages is recommended in order to fully understand this workshop.

## Setup

### R and Rstudio

This lesson assumes you have R and RStudio installed on your computer.

The latest version of R can be downloaded [here](https://cran.r-project.org/mirrors.html).

RStudio can be downloaded [here](https://rstudio.com/products/rstudio/download/). Make sure that you download the free Desktop version for your computer.

### R libraries

This workshop will use the following libraries: 
- Shiny
- readr
- ggplot2
- TydR and dplyR

These libraries can be installed together by installing the 'Tidyverse' package.
To install the package, open RStudio and run in the console: 
```{r}
install.packages("tidyverse")
```

### ShinyApp.io account

Although not mandatory, if you want to be able to deploy your App on the ShinyApp.io server, you'll need to create a free account on [ShinyApps.io](https://www.shinyapps.io/)