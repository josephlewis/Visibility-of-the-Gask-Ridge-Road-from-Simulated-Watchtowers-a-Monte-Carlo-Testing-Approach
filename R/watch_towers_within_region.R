watch_towers_within_region <- function(watch_towers, region) {
  
  watch_towers <- raster::crop(watch_towers, region)
  
  return(watch_towers)
  
}
