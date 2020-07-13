visibility_plot <- function(dem, visibility_raster, road, watchtowers, forts, background_region, dsn, filename, title = NULL, legend = TRUE) { 

  elev <- raster::crop(dem, extent(287640, 305000, 715350, 723070))
  
  visibility_raster[visibility_raster == 0] <- NA
  
  slope = terrain(elev, opt='slope')
  aspect = terrain(elev, opt='aspect')
  hill = hillShade(slope, aspect, 40, 270)
  
  road <- raster::crop(road, elev)
  
  png(paste0(dsn, filename, ".png"), height = 6, width = 10, units = 'in', res=300)
  
  plot(hill, col = gray.colors(20, start = 0, end = 1), legend=FALSE, xaxt='n', yaxt = 'n', bty="n", axes=FALSE, frame.plot=FALSE, box=FALSE, main = title, adj = 0, line = -0.8)
  
  plot(visibility_raster, add = T, legend.args = list(text = 'Number of Times Cells Visible', side = 4, 
                                                      font = 2, line = 2.5, cex = 0.8))
  
  if(inherits(background_region, "SpatialPolygons")) { 
  
  plot(background_region, add = T, border = "black", lty=2)
    
  }

  plot(road, add = T, col = "red")
  plot(watchtowers, add = T, col = "black", pch = 16)
  plot(forts, add = T, bg = "red", col = "red", pch = 22, cex = 1.5)
  
  if (legend) {
    
    if(inherits(background_region, "SpatialPolygons")) { 
      
      legend("bottomleft", legend=c("Watchtowers", "Gask Ridge\nRoman road", "Strageath Roman Fort", "Background Sample Region"),
             col=c("black", "red", "red", "black"), lty=c(NA, 1, NA, 2), pch = c(16, NA, 22, NA), border = c(NA, NA, NA, "black"), cex=0.8, box.lty=0, ncol = 4, bty ="n", pt.cex = c(1,1, 1.5, NA), pt.bg = c(NA, NA, "red", NA))
      
    } else { 
    
      legend("bottomleft", legend=c("Watchtowers", "Gask Ridge\nRoman road", "Strageath Roman Fort"),
             col=c("black", "red", "red"), lty=c(NA, 1, NA), pch = c(16, NA, 22), border = c(NA, NA, NA), cex=0.8, box.lty=0, ncol = 3, bty ="n", pt.cex = c(1,1, 1.5), pt.bg = c(NA, NA, "red"))
      
    }
    
  }
  
  dev.off()
  
}
