#Création d'une fonction pour utiliser seulement nos données au Québec pour nos analyses

#devtools::install_github("ropensci/rnaturalearthhires")


#Chargement des packages utiles
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(devtools)
library(dplyr)


selection_qc <- function(site){
  
#Convertir le dataframe des coordonnées en un objet géospatiale en WSG84
  site_sf <- st_as_sf(site, coords = c("lon", "lat"), crs = 4326, remove=FALSE)

# Obtenir les provinces du Canada
  canada_provinces <- ne_states(country = "Canada", returnclass = "sf")

# Garder seulement le Québec comme province
  quebec <- canada_provinces[canada_provinces$name_en=='Quebec',]

# Sélectionner les coordonnées au Québec
  site_sf$Quebec <- st_within(site_sf, quebec, sparse = FALSE)
  
  site <- site_sf
  site$geometry <- NULL
  
  return(site)
}

#site <- quebec(site)


#Visualisation de nos données en montrant ceux en bleu comme ceux au Québec
#canada_provinces <- ne_states(country = "Canada", returnclass = "sf")
#plot(st_geometry(canada_provinces[canada_provinces$name_en=='Quebec',]))
#plot(st_geometry(site), col = "gray", add = TRUE)
#site_queb <- site[site$Quebec == TRUE, ]
#plot(st_geometry(site_queb$geometry), col = "blue", add = TRUE)



