#### LOAD REQUIRED LIBRARIES ####

library(rgdal)
library(raster)
library(rgdal)
library(sp)
library(rgeos)
library(rgrass7)
#library(link2GI)
library(ggplot2)
library(cowplot)
library(R.utils)

# use_sp() ensures that rgrass7 uses sp rather than stars library
use_sp()

#### LOAD FUNCTIONS AND MAKE AVAILABLE TO CURRENT SCRIPT ####

source("./R/elevation_processing.R")
source("./R/background_sample_area.R")
source("./R/watch_towers_within_region.R")
source("./R/points_along_road.R")
source("./R/random_points.R")
source("./R/visibility.R")
source("./R/visibility_summary.R")
source("./R/export_simulation_points.R")
source("./R/export_visibility_rasters.R")
source("./R/visibility_plot.R")

osgb <- "+init=epsg:27700"

#### LOAD FILES AND CREATE INTERMEDIATE OBJECTS ####

elev <- raster::raster("./Data/OS 5m/combined_5m.tif")
elev <- elevation_processing(dem = elev)
forts <- read.csv("./Data/Fortifications/Forts.csv", stringsAsFactors = FALSE)
forts <- sp::SpatialPointsDataFrame(coords = cbind(forts$X, forts$Y), data = forts ,proj4string = raster::crs(osgb))
watch_towers <- read.csv("./Data/Fortifications/Watchtowers.csv", stringsAsFactors = FALSE)
watch_towers <- sp::SpatialPointsDataFrame(coords = cbind(watch_towers$X, watch_towers$Y), data = watch_towers, proj4string = raster::crs(osgb))
road <- rgdal::readOGR("./Data/Roman road/margary 9a and 9b.shp")
gask_ridge_road <- road[2,]
# crop gask ridge road to between Strageath and Westmuir watchtower
gask_ridge_road <- raster::crop(x = gask_ridge_road, extent(c(extent(elev)[1], extent(watch_towers[watch_towers$Name == "Westmuir",])[1], extent(elev)[3], extent(elev)[4])))

# check background sample area to make sure the function has forts as a argument not fixed
background_sample_region <- background_sample_area(road = gask_ridge_road, dem = elev, watch_towers = watch_towers[watch_towers$Name == "Westmuir",], forts = forts[forts$name == "Strageath",])
gask_ridge_watchtowers <- watch_towers_within_region(watch_towers = watch_towers, region = background_sample_region)
gask_ridge_road_pts <- points_along_road(road = gask_ridge_road, dem = elev)

#### INITIALISE GRASS IN ORDER TO CALCULATE VISIBILITY #####

GRASS_loc <- "D:/GRASS GIS 7.6.0"
temp_loc <- "C:/"

initGRASS(gisBase = GRASS_loc,
          gisDbase = temp_loc, location = "visibility", 
          mapset = "PERMANENT", override = TRUE)

#### CALCULATE VISIBILITY FROM WATCHTOWERS ALONG GASK RIDGE ####

watchtower_vis_low <- visibility(dem= elev, locations = coordinates(gask_ridge_watchtowers), coordinate_system = osgb, distance = 600, observer_height = 8.65)

watchtower_vis_high <- visibility(dem= elev, locations = coordinates(gask_ridge_watchtowers), coordinate_system = osgb, distance = 600, observer_height = 11.65)

writeRaster(watchtower_vis_low, "./Outputs/Watchtower Visibility/watchtower_vis_low.tif")
writeRaster(watchtower_vis_high, "./Outputs/Watchtower Visibility/watchtower_vis_high.tif")

watchtower_vis_low_summary <- visibility_summary(raster = watchtower_vis_low, points = gask_ridge_road_pts)
watchtower_vis_high_summary <- visibility_summary(raster = (watchtower_vis_high), points = gask_ridge_road_pts)

write.csv(x = watchtower_vis_low_summary, file = "./Outputs/Visibility Summaries/Watchtower vis Low Summary.csv")
write.csv(x = watchtower_vis_high_summary, file = "./Outputs/Visibility Summaries/Watchtower vis High Summary.csv")

#### SIMULATE POINTS WITHIN BACKGROUND SAMPLE REGION ####

nsims <- 99

simulated_pts <- list()

i <- 0

while( length(simulated_pts) < nsims ) {
  
  i <-  i + 1

  simulated_pts[[i]] <- tryCatch(R.utils::withTimeout(random_points(W = background_sample_region, n = length(gask_ridge_watchtowers), min_d = 800, max_d = 1520, fixed_locations = gask_ridge_watchtowers[1,]), timeout = 10), 
                                       TimeoutException = function(ex) cat("Timeout. Skipping.\n"))
  
  if (any(sapply(simulated_pts, is.null))) { 
    
    simulated_pts[sapply(simulated_pts, is.null)] <- NULL
    
    }
  
}

export_simulation_points(sim_points_list = simulated_pts, nsims = nsims, dsn = "./Outputs/Simulated Background Sample Points", filename = "Background Sample Points", no_points = length(gask_ridge_watchtowers))

#### CALCULATE VISIBILITY FROM SIMULATED WATCHTOWERS ####

sim_watchtower_vis_low_summary <- list()
sim_watchtower_vis_high_summary <- list()

for (i in 1:nsims) {
  
  sim_watchtower_vis_low <- visibility(dem= elev, locations = coordinates(simulated_pts[[i]]), coordinate_system = osgb, distance = 600, observer_height = 8.65)
  
  writeRaster(sim_watchtower_vis_low, paste0("./Outputs/Simulated Sample Points Visibility/", "Simulated Watchtower Visibility Low ", i, ".tif"))
  
  sim_watchtower_vis_high <- visibility(dem= elev, locations = coordinates(simulated_pts[[i]]), coordinate_system = osgb, distance = 600, observer_height = 11.65)

  writeRaster(sim_watchtower_vis_high, paste0("./Outputs/Simulated Sample Points Visibility/", "Simulated Watchtower Visibility High ", i, ".tif"))
  
  sim_watchtower_vis_low_summary[[i]] <- visibility_summary(raster = sim_watchtower_vis_low, points = gask_ridge_road_pts)
  
  sim_watchtower_vis_high_summary[[i]] <- visibility_summary(raster = sim_watchtower_vis_high, points = gask_ridge_road_pts)

}

write.csv(x = unlist(sim_watchtower_vis_low_summary), file = "./Outputs/Visibility Summaries/Simulated Watchtower vis Low Summary.csv")
write.csv(x = unlist(sim_watchtower_vis_high_summary), file = "./Outputs/Visibility Summaries/Simulated Watchtower vis High Summary.csv")