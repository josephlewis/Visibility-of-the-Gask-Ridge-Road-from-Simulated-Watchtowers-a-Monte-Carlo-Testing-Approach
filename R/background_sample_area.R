background_sample_area <- function(road, dem, watch_towers, forts) {
  
  road_buffer <- rgeos::gBuffer(spgeom = road, byid = FALSE, width = 190)
  
  forts <- rgeos::gBuffer(forts, width = 1750)
  
  road_buffer <- rgeos::gDifference(road_buffer, forts)
  
  westmuir <- rgeos::gBuffer(watch_towers, width = 800)
  
  road_buffer <- rgeos::gDifference(road_buffer, westmuir)
  
  road_buffer <- crop(road_buffer, as(extent(290665, 302695, 717415, 721340), "SpatialPolygons"))
  
  return(road_buffer)
  
}
