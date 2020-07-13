random_points <- function(W, n, min_d, max_d, iter = 20, fixed_locations = NULL) {
  
  if (!inherits(W, "SpatialPolygons")) {
    stop("W expecting SpatialPolygons")
  }
  
  if (n < 1) {
    stop("n expecting number of 1 or greater")
  }
  
  if (min_d < 0) {
    stop("min_d expecting number of 0 or greater")
  }
  
  if (max_d < 0) {
    stop("max_d expecting number of 0 or greater")
  }
  
  if (min_d > max_d) {
    stop("min_d greater than max_d. Expecting max_d to be greater than min_d")
  }
  
  if (iter < 1) {
    stop("iter expecting number of 1 or greater. See iter argument in sp::spsample for details.")
  }
  
  if (inherits(fixed_locations, "SpatialPoints")) {
    
  pts <- fixed_locations
  
  pts <- as(pts, "SpatialPoints")
  
  crs(pts) <- crs(W)
    
  } else {
  pts <- spsample(W, n= 1, type='random', iter = iter)
  
  }
  
  while(length(pts) <= n - 1) { 
    
    add <- spsample(W, n= 1, type='random', iter = iter)
    
    if ( (all(rgeos::gDistance(pts, add, byid = TRUE) > min_d) ) & (min(rgeos::gDistance(pts, add, byid = TRUE)) < max_d)) {
      pts <- base::rbind(pts, add)
      
    } else { 
      
      next
    }
    
  }
  
  pts$id <- 1:length(pts) 
  
  return(pts)
  
}
