library(tidyverse)

# load ramen Ratings dataset
ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")

ramen_ratings %>% filter(style == "Bowl") %>% top_n(10, stars)

ramen_ratings %>% select(country) %>% unique()
