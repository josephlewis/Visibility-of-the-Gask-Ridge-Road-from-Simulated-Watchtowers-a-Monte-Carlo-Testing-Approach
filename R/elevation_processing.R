elevation_processing <- function(dem) { 

#### DIGITAL ELEVATION MODEL PREPROCESSING ####

elev <- dem

crs(elev) <- crs(osgb)

# crop raster to smaller area that surrounds the Gask Ridge Roman road
elev <- crop(elev, as(extent(277965, 312590, 704285, 728370), "SpatialPolygons"))

return(elev)

}