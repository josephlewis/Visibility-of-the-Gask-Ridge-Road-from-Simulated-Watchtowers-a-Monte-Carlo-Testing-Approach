export_visibility_rasters <- function(raster_list, dsn, filename) { 
  
  for (i in 1:length(raster_list)) { 
    
  writeRaster(raster_list[[i]], filename = paste0(dsn, filename, i, ".tif"))
  
  }
  
}