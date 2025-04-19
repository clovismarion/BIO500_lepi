#établir la connection
con <- dbConnect(SQLite(), dbname="lepidoptere.db")

#Requête pour la Q1 de la variation du nombre d'espèce selon la latitude
requete_Q1 <- "
SELECT main.observed_scientific_name, site.site_id
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = TRUE
"
Q1 <- dbGetQuery(con, requete_Q1)
View(Q1)

#Requête pour la Q2 de la variation du nombre d'espèce selon la longitude

#Requête pour variations spatiales
requete_Q2 <- "
SELECT main.observed_scientific_name, site.lat, site.lon, site.site_id,
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
   
"

Q2 <- dbGetQuery(con, requete_Q2)
View(Q2)

# requêtes pour les variations temporelles
requete_Q3 <- "
SELECT main.observed_scientific_name, site.site_id, main.dwc_event_date
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
"

Q3 <- dbGetQuery(con, requete_Q3)
View (Q3)

# requêtes nombres d'espèces
requete_Q4 <- "
SELECT main.observed_scientific_name, site.site_id,info.info_id, info.original_source ,info.creator
FROM main
left JOIN info
  ON main.info_id = info.info_id
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
"

Q4 <- dbGetQuery(con, requete_Q4)
View (Q4)

requete_Q5 <- "
SELECT main.observed_scientific_name, main.main_id, site.site_id
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True
"
Q5<- dbGetQuery(con, requete_Q5)
View(Q5)
#déconnexion de la BD


#Québec méridional
requete_Q6 <- "
SELECT main.observed_scientific_name, main.main_id, site.site_id, main.dwc_event_date
FROM main
left JOIN site
  ON main.site_id = site.site_id
WHERE site.Quebec = True AND site.lat >48
"
Q6<- dbGetQuery(con, requete_Q6)
View(Q6)

dbDisconnect(con)