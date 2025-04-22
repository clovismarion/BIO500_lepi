# REQUETE 3

req3 <- function(db_nom){
  
  con <- dbConnect(SQLite(), dbname = db_nom)

  #obtenir de l'information sur la provenance des données
requete_Q4 <- "
SELECT main.observed_scientific_name, site.site_id,info.info_id, info.original_source ,info.creator
FROM main
left JOIN info
  ON main.info_id = info.info_id
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
"

Q3 <- dbGetQuery(con, requete_Q3)

dbDisconnect(con)                 

return(Q3)

}