# Graphique latitiude

graphLAT <- function(requete, format){
  
  switch(format,
         png  = png("rapport/lat.png"),
         jpeg = jpeg("rapport/lat.jpeg"),
         pdf  = pdf("rapport/lat.pdf"),
         stop("Unsupported format")
  )
  
  #nombre d'espèce par latitude différente
  richesse_par_lat <- requete %>%
    group_by(lat) %>%
    summarise(nb_especes = n_distinct(observed_scientific_name))
  
  plot(richesse_par_lat$nb_especes, richesse_par_lat$lat,
       pch = 16,                             # type de point plein
       cex = 0.8,                            # taille des points
       col = "black",                        # couleur des points
       xlab = "Nombre d'espèces distinctes",
       ylab = "Latitude")
  
  # Ajouter une ligne horizontale à la latitude 48
  abline(h = 48, col = "red", lwd = 2)

  grid()
  
  legend("topright",  
         inset = 0.05, # Distance from the margin as a fraction of the plot region
         legend = c("48e parallèle"),
         lty = 1,
         col = c("red"),
         lwd = 2,
         cex=0.8)
  
  dev.off()
  
}

# graphLAT()
