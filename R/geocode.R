library(tidyverse)
library(ggmap)
library(jsonlite)

api <- readLines("google.api") # Text file with the API key

register_google(key = api)
getOption("ggmap")

adresy <- paste0(vysledky_2018_adresy$ulice, ", ", vysledky_2018_adresy$mesto, ", ", vysledky_2018_adresy$okres, ", ", vysledky_2018_adresy$kraj, ", Czech Republic")
locations <- geocode(adresy)

world <- map_data("world")
ggplot() +
  geom_polygon(data = world,  aes(long, lat, group = group), fill = "grey") +
  geom_point(data = locations, aes(lon, lat), colour = "red", size = 5) + 
  coord_map("ortho", orientation = c(30, 80, 0)) +
  theme_void()


