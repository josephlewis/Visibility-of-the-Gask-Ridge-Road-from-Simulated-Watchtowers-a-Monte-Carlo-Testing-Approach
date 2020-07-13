visibility <- function(dem, locations, coordinate_system, distance = distance, observer_height) {
  
  # set coordinate system as OSGB
  execGRASS("g.proj", flags = c("c"), parameters = list(proj4= coordinate_system))
  
  # write dem to GRASS
  writeRAST(as(dem, "SpatialGridDataFrame"), "dem", overwrite = TRUE)
  
  execGRASS("g.region", raster = "dem", flags = "p")
  
  vis_field <- raster::stack()
  
  for (i in seq_along(1:nrow(locations))) { 
    
    print(paste0("Iteration Number: ", i))
    
    execGRASS("r.viewshed", flags = c("overwrite","b"), parameters = list(input = "dem", output = "viewshed", coordinates = unlist(c(locations[i,])),  observer_elevation = observer_height, max_distance = distance))
    
    single.viewshed <- readRAST("viewshed")
    
    single.viewshed <-  raster(single.viewshed, layer=1, values=TRUE)
    
    vis_field <- stack(vis_field, single.viewshed)
    
  }
  
  vis_field <- sum(vis_field)
  
  vis_field <- raster::crop(vis_field, extent(287640, 305000, 715350, 723070))
  
  

  return(vis_field)
  
}
