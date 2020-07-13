export_simulation_points <- function(sim_points_list, dsn, filename, nsims, no_points) { 

  sim_points <- do.call(rbind, sim_points_list)
  
  sim_points$sim_no <- rep(1:nsims, each= no_points)
  
  writeOGR(obj = sim_points, dsn = dsn, layer = filename, driver = "ESRI Shapefile")
    
}
