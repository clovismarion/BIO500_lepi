# REQUETE 3

req3 <- function(db_nom){
  
  con <- dbConnect(SQLite(), dbname = db_nom)

  #obtenir de l'information sur la provenance des données
requete_Q3 <- "
SELECT main.observed_scientific_name, site.id_site,info.id_infos, info.original_source ,info.creator
FROM main
left JOIN info
  ON main.id_infos = info.id_infos
left JOIN site
  ON main.id_site = site.id_site
WHERE site.Quebec = True
"

Q3 <- dbGetQuery(con, requete_Q3)

dbDisconnect(con)                 

return(Q3)

}