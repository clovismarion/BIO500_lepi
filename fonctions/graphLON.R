graphLON <- function(requete, format){
  
  switch(format,
         png  = png("rapport/lon.png"),
         jpeg = jpeg("rapport/lon.jpeg"),
         pdf  = pdf("rapport/lon.pdf"),
         stop("Unsupported format")
  )
  
  #nombre d'espèce par latitude différente
  richesse_par_lon <- requete %>%
    group_by(lon) %>%
    summarise(nb_especes = n_distinct(observed_scientific_name))
  
  plot(richesse_par_lon$lon, richesse_par_lon$nb_especes, 
       pch = 16,                             # type de point plein
       cex = 0.8,                            # taille des points
       col = "black",                        # couleur des points
       xlab = "Nombre d'espèces distinctes",
       ylab = "Longitude")

  
  grid()
 
  #reg <- lm(nb_especes ~ lon, data = richesse_par_lon)
  #abline(reg, col="grey")
  
  dev.off()
  
}

# graphLON()


