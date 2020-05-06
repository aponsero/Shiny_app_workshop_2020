library(tidyverse)

# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("ramen_ratings.csv")
continents <- readr::read_csv("countries_continent.csv")

dataset<- left_join(ramen_ratings, continents, by= "country")
write.csv(dataset, "ramen_dataset.csv", row.names=FALSE)
