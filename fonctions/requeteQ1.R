# REQUETE 1

req1 <- function(){
  
con <- dbConnect(SQLite(), dbname="lepidoptere.db")

#Requête pour la Q1 de la variation du nombre d'espèce selon la latitude
requete_Q1 <- "
SELECT main.observed_scientific_name, site.lat, site.site_id
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
   
"

Q1 <- dbGetQuery(con, requete_Q1)

dbDisconnect(con)

return(Q1)
}

# Q1 <- req1()
