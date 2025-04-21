#Chargement des packages utiles
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(devtools)
library(dplyr)


carteQC <- function(){
  site_sf <- st_as_sf(site, coords = c("lon", "lat"), crs = 4326, remove=FALSE)
  canada_provinces <- ne_states(country = "Canada", returnclass = "sf")
  quebec <- canada_provinces[canada_provinces$name_en=='Quebec',]
  site_sf$Quebec <- st_within(site_sf, quebec, sparse = FALSE)
  site_fct <- site_sf
  

# 1 Tracer le contour du Québec 
plot(st_geometry(canada_provinces[canada_provinces$name_en == 'Quebec',]),
     xlim = c(-80, -57), ylim = c(44, 62),
     axes = TRUE,
     xlab = "Longitude", ylab = "Latitude",
     col = "white", border = "black", 
     bg = "white",
     main = "Observations de lépidoptères au Québec (1859-2023)")


# 2 Ajouter une ligne à chaque 1 degré

# Lignes verticales (longitudes)
abline(v = seq(-80, -57, by = 1), col = "lightgray", lty = "dotted")

# Lignes horizontales (latitudes)
abline(h = seq(44, 60, by = 1), col = "lightgray", lty = "dotted")


# 3 Mettre les points hors Québec en gris
plot(st_geometry(site_fct), col = "gray", add = TRUE, cex = 0.5)

# 4 Ajouter les points au Québec en bleu
plot(st_geometry(site_queb$geometry), col = "blue", add = TRUE, pch = 16, cex = 0.25 )

# Ligne rouge rouge pour délimiter le Québec méridional
abline(h = 48, col = "red", lwd = 0.5)

legend("topright",  
       inset = 0.005, # Distance from the margin as a fraction of the plot region
       legend = c("Québec", "Hors-Québec", "48e parallèle"),
       pch = c(16,1 ,NA),
       lty = c(NA,NA ,1),
       col = c("blue", "grey", "red"),
       lwd = 2,
       cex=0.8)
}

carteQC()
