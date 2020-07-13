points_along_road <- function(road, dem) { 
  
  road <- rgeos::gBuffer(road, width = 5)
  
  road <- raster::crop(road, dem)
  
  road_raster <- raster::rasterize(x = road, y = dem)
  
  raster_pts <- raster::rasterToPoints(x = road_raster, fun= function(x){x==1}, spatial = TRUE)
  
  return(raster_pts)
  
}
