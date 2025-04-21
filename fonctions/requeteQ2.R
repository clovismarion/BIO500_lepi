# REQUETE 2

req2 <- function(){

con <- dbConnect(SQLite(), dbname="lepidoptere.db")

#Requête pour la Q1 de la variation du nombre d'espèce selon la longitude
requete_Q2 <- "
SELECT main.observed_scientific_name, site.lat, site.lon, site.site_id
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
   
"

Q2 <- dbGetQuery(con, requete_Q2)

dbDisconnect(con)                 

return(Q2)
         
}

# Q2 <- req2()
