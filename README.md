# Seeing while moving: Direction-Dependent Visibility of Bronze Age Monuments Along a Prehistoric Mountain Track in Cumbria, England

This repository contains all the data and scripts required to fully reproduce all analyses presented in the paper "Seeing while moving: Direction-Dependent Visibility of Bronze Age Monuments Along a Prehistoric Mountain Track in Cumbria, England" authored by Lewis, J. 


Getting Started
---------------

1. Open project using Seeing-While-Moving-Direction-Dependent-Visibility.Rproj to ensure relative paths work.
2. Run the FETE calculation R script in the R folder to reproduce the Least Cost Path Density and Least Cost Path Kernel Density shown in Figure 4.
    + **Caution: The From Everywhere to Everywhere calculation calculates 227,052 Least Cost Paths and took approximately ~3 days to run on Intel Core i5 laptop with 8GB RAM** 
    + Note: The Least Cost Path Density and Least Cost Path Kernel Density results are available in the Outputs folder. 
  
3. Run the LCP calculation R script in the R folder to reproduce the Least Cost Paths shown in Figure 5. 
    + Note: The South to North and North to South Least Cost Path results are available in the Outputs folder. 

4. Run the Direction Dependent Visibility calculation R script in the R folder to reproduce  the visibility results shown in Figure 6.
    + Note: The South to North and North to South Visibility results are available in the Outputs folder. 
    + The Direction Dependent Visibility function is in the Direction Dependent Visibility R script should you wish to use the function outside of this project. Note that you will need to set up GRASS in order for the function to work (see lines 45 to 55 of Direction Dependent Visibility calculation R script).
    
How Direction-Dependent Visibity is calculated
---------------

1. Calculate visibility in all directions from a location along the route.
2. Calculate angle between current location and location further along route. This represents the direction of movement when moving along the route.
3. Identify potential visibility field based on direction of movement (62 degrees either side).
4. Clip visibility in all directions to potential visibility field when taking into account direction of movement.

![Direction Dependent Visibility](https://i.imgur.com/r5grlGg.gif)

File Structure
---------------

```
  .
  ├── Data
  │   └── OD
  │       ├── origin_destination.shp
  │       ├── origin_destination.dbf
  │       ├── origin_destination.shx
  │   └── Regular Points
  │       ├── regular_locs.shp
  │       ├── regular_locs.dbf
  │       ├── regular_locs.shx
  │   └── SRTM
  │       ├── N54W003.hgt
  │       ├── N54W004.hgt
  │   └── Waterbodies
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.cpg
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.dbf
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.prj
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.sbn
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.sbx
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.shp
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.xml
  │       ├── WFD_Lake_Water_Bodies_Cycle_2.shx
  ├── Outputs
  │   └── density rasters
  │       ├── lcp_network_density.tif
  │       ├── lcp_network_kernel_density.tif
  │   └── visibility rasters
  │       ├── south_to_north_visibility.tif
  │       ├── north_to_south_visibility.tif
  │   └── least cost paths
  │       ├── north_to_south.dbf
  │       ├── north_to_south.prj
  │       ├── north_to_south.shp
  │       ├── north_to_south.shx
  │       ├── south_to_north.dbf
  │       ├── south_to_north.prj
  │       ├── south_to_north.shp
  │       ├── south_to_north.shx
  ├── R
  │   └── FETE calculation.R
  │   └── LCP calculation.R
  │   └── Direction Dependent Visibility calculation.R
  │   └── Direction_Dependent_Visibility.R  
  ├── README.md
  ├── Seeing-While-Moving-Direction-Dependent-Visibility.Rproj
  ├── Licenses.md
```

Session Info
---------------

```
R version 3.4.1 (2017-06-30)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

Matrix products: default

locale:
[1] LC_COLLATE=English_United Kingdom.1252  LC_CTYPE=English_United Kingdom.1252    LC_MONETARY=English_United Kingdom.1252
[4] LC_NUMERIC=C                            LC_TIME=English_United Kingdom.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] link2GI_0.3-5       rgrass7_0.1-12      XML_3.98-1.9        leastcostpath_1.2.1 gdistance_1.2-2     Matrix_1.2-10      
 [7] igraph_1.2.4.1      rgeos_0.4-3         rgdal_1.4-3         raster_2.8-19       sp_1.3-1           

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.3         lattice_0.20-35    FNN_1.1            class_7.3-14       prettyunits_1.0.2  ps_1.2.1          
 [7] zoo_1.8-1          assertthat_0.2.1   gstat_1.1-5        rprojroot_1.2      digest_0.6.16      foreach_1.4.4     
[13] R6_2.4.0           plyr_1.8.4         backports_1.1.5    e1071_1.7-1        rlang_0.4.0        rstudioapi_0.7    
[19] callr_3.1.0        R.utils_2.6.0      R.oo_1.21.0        desc_1.2.0         devtools_2.0.2     stringr_1.2.0     
[25] foreign_0.8-69     compiler_3.4.1     shapefiles_0.7     pkgconfig_2.0.2    pkgbuild_1.0.2     roxygen2_6.1.1    
[31] intervals_0.15.1   codetools_0.2-15   spacetime_1.2-0    crayon_1.3.4       withr_2.1.2        sf_0.7-4          
[37] R.methodsS3_1.7.1  commonmark_1.7     grid_3.4.1         RSAGA_1.3.0        DBI_1.0.0          magrittr_1.5      
[43] units_0.6-2        KernSmooth_2.23-15 cli_1.0.0          stringi_1.1.5      pbapply_1.4-2      fs_1.2.7          
[49] remotes_2.0.2      testthat_2.0.0     xml2_1.1.1         xts_0.10-0         iterators_1.0.8    tools_3.4.1       
[55] gdalUtils_2.0.1.7  glue_1.3.1         processx_3.2.1     pkgload_1.0.2      parallel_3.4.1     sessioninfo_1.1.1 
[61] classInt_0.4-2     memoise_1.1.0      usethis_1.4.0 
```

License
---------------

CC-BY 3.0 unless otherwise stated (see Licenses.md)
