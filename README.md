# Visibility of the Gask Ridge Road from Simulated Watchtowers: a Monte Carlo Testing Approach

This repository contains all the data and scripts required to fully reproduce all analyses presented in the paper "Visibility of the Gask Ridge Road from Simulated Watchtowers: a Monte Carlo Testing Approach" authored by Lewis, J. 

Getting Started
---------------

1. Open project using Gask Ridge Fort Locations.Rproj to ensure relative paths work.
2. Run the main R script in the R folder to recreate the simulated spatial points of the watchtowers, the viewsheds from the true location of the watchtowers along the gask Ridge Roman road, and the viewsheds from the simulated spatial points representing the watchtowers. 
    + **Caution: The creation of the viewsheds representing the cumulative viewsheds from the true locations of watchtowers and the simulated watchtowers requires the total calculation of 1,000 viewsheds. The temporary folder to store the intermediate viewsheds can be stated on line 53, with the location of the GRASS installation stated on line 52** 
    + **For testing purposes, it is recommended to change the nsims (line 76) to a smaller number than 99.**
    
License
---------------

CC-BY 3.0 unless otherwise stated (see Licenses.md)
