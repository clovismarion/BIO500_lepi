#Il faut que c'est objet soit dans notre environnement pour pouvoir exécuter la fct

#Convertir le dataframe des coordonnées en un objet géospatiale en WSG84
site_sf <- st_as_sf(site, coords = c("lon", "lat"), crs = 4326, remove=FALSE)

# Obtenir les provinces du Canada
canada_provinces <- ne_states(country = "Canada", returnclass = "sf")

# Garder seulement le Québec comme province
quebec <- canada_provinces[canada_provinces$name_en=='Quebec',]

# Sélectionner les coordonnées au Québec
site_sf$Quebec <- st_within(site_sf, quebec, sparse = FALSE)

site <- site_sf


site_queb <- site[site$Quebec, ]


# 1 Tracer le contour du Québec 
plot(st_geometry(canada_provinces[canada_provinces$name_en == 'Quebec',]),
     xlim = c(-80, -57), ylim = c(44, 62),
     axes = TRUE,
     xlab = "Longitude", ylab = "Latitude",
     col = "white", border = "black", 
     bg = "white")


# 2 Ajouter une ligne à chaque 1 degré

# Lignes verticales (longitudes)
abline(v = seq(-80, -57, by = 1), col = "lightgray", lty = "dotted")

# Lignes horizontales (latitudes)
abline(h = seq(44, 60, by = 1), col = "lightgray", lty = "dotted")


# 3 Mettre les points hors Québec en gris
plot(st_geometry(site), col = "gray", add = TRUE, cex = 0.5)

# 4 Ajouter les points au Québec en bleu
plot(st_geometry(site_queb$geometry), col = "blue", add = TRUE, pch = 16, cex = 0.25 )

# Ligne rouge rouge pour délimiter le Québec méridional
abline(h = 48, col = "red", lwd = 0.5)





