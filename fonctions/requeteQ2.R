# REQUETE 2

req2 <- function(db_nom){

con <- dbConnect(SQLite(), dbname = db_nom)

#Requête pour la Q1 de la variation du nombre d'espèce selon la longitude
requete_Q2 <- "
SELECT main.observed_scientific_name, site.lat, site.lon, site.id_site
FROM main
left JOIN site
  ON main.id_site = site.id_site
WHERE site.Quebec = True
   
"

Q2 <- dbGetQuery(con, requete_Q2)

dbDisconnect(con)                 

return(Q2)
         
}

# Q2 <- req2()
