library(tidyverse)
library(ggplot2)
library(ggmap)
library(RColorBrewer)
library(patchwork)
library(here)

location_data <- read_csv("https://raw.githubusercontent.com/AMPATH-Capstone/DataPrep/master/Original-Data/SublocationsbyTreatment.csv")
intervention <- filter(location_data, Treatment =="Intervention")
control <- filter(location_data, Treatment =="Control")

kitale_bounds <- c(34.547910, 0.779964, 35.422696, 1.301727)
kitale_map <- get_map(location=kitale_bounds, source="google", maptype="roadmap", crop=FALSE)
ggmap(kitale_map) + 
  geom_point(data = intervention, aes(x = Long, y = Lat), color = "navy", size = 1) +
  geom_point(data = control, aes(x = Long, y = Lat), color = "red", size = 1) +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        rect = element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank())
