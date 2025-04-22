# REQUETE 1

req1 <- function(db_nom){
  
con <- dbConnect(SQLite(), dbname = db_nom)

#Requête pour la Q1 de la variation du nombre d'espèce selon la latitude
requete_Q1 <- "
SELECT main.observed_scientific_name, site.lat, site.id_site
FROM main
left JOIN site
  ON main.id_site = site.id_site
WHERE site.Quebec = True
   
"

Q1 <- dbGetQuery(con, requete_Q1)

dbDisconnect(con)

return(Q1)
}

# Q1 <- req1()
