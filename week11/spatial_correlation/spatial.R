library(ggmap)
library(ggplot2)
library(stringr)
library(readr)
library(dplyr)
library(sp)
library(rgeos)
library(rgdal)
library(raster)
library(classInt)
library(data.table)
library(SpatialPack)

register_google(key="put_your_Google_Maps_API_key_here")

setwd("~/git/AIT722/week5/data")

#Car2Go
total <- read_delim("car2go_samples.csv", delim = ",",col_names = T )
total$ID <- row.names(total)
total$ID <- as.integer(total$ID)
xy <- total[,c("lon","lat")]
points <- SpatialPointsDataFrame(coords = xy, data = total,
                                 proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))

# DC neighborhood boundaries 
gov_cluster <- readOGR("dc_neighborhood_boundaries_GovClusters.kml", 
                       layer="dc_neighborhood_boundaries_GovClusters") %>% 
  spTransform(CRS("+proj=longlat +datum=WGS84"))

# Intersecting between two layers to aggregate points to the polygon layer.
gov_cluster@data$polygon_id <- 1:nrow(gov_cluster@data)
intersections <- raster::intersect(x = points, y = gov_cluster)
point_counts <- intersections@data %>% group_by(polygon_id) %>%  
  summarise(num_car_locations=n(), ave_fuel=mean(fuel))
gov_cluster@data <- gov_cluster@data %>% left_join(point_counts, by=c("polygon_id"))

plot(gov_cluster)


###### Imortant part
###### Clifford and Richardson's t-test considering spatial correlation.
trueCentroids = gCentroid(gov_cluster, byid=TRUE)
plot(trueCentroids)
modified.ttest(gov_cluster@data$num_car_locations, gov_cluster@data$ave_fuel, coords = trueCentroids@coords)
cor.test(gov_cluster@data$num_car_locations, gov_cluster@data$ave_fuel)
