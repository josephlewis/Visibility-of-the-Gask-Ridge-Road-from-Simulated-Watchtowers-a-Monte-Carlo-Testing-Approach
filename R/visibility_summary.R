visibility_summary <- function(raster, points) {
  
  if (inherits(raster, "RasterLayer")) { 
    
    vis_summary <- sum(raster::extract(x = raster, y = points), na.rm = TRUE)
    
  }

  return(vis_summary)
  
}
  
  


