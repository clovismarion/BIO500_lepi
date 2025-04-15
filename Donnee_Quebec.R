#Création d'une fonction pour utiliser seulement nos données au Québec pour nos analyses

#devtools::install_github("ropensci/rnaturalearthhires")


#Chargement des packages utiles
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(devtools)
library(dplyr)

#Convertir le dataframe des coordonnées en un objet géospatiale en WSG84

site_sf <- st_as_sf(site, coords = c("lon", "lat"), crs = 4326, remove=FALSE)


# Obtenir les provinces du Canada
canada_provinces <- ne_states(country = "Canada", returnclass = "sf")


# Garder seulement le Québec comme province
quebec <- canada_provinces %>% filter(name_en == "Quebec")


# Sélectionner les coordonnées au Québec
site_quebec <- site_sf[st_within(site_sf, quebec, sparse = FALSE), ]
#Le message d'avis ne semble pas être problématique 


#Visualisation des données conservées dans notre jeu de données
plot(st_geometry(site_quebec))

#Visualisation de nos données en montrant ceux en bleu comme ceux au Québec
plot(st_geometry(quebec))
plot(st_geometry(site_sf), col = "gray", add = TRUE)
plot(st_geometry(site_quebec), col = "blue", add = TRUE)



