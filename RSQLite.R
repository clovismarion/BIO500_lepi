library(RSQLite)

#Connection avec le serveur/fichier

# Au besoin, si les table sont déjà existantes on peut utiliser ceci 
file.remove("lepidoptere.db")


con <- dbConnect(SQLite(), dbname="lepidoptere.db")

#Création de la table observation
tbl_observation <- "
CREATE TABLE observation (
  obs_id            INTEGER NOT NULL,
  obs_unit          VARCHAR(40),
  obs_variable      VARCHAR(50),
  obs_value         VARCHAR(200),
  PRIMARY KEY (obs_id)
);"
dbSendQuery(con,tbl_observation)



#Création de la table Info

tbl_info <- "
CREATE TABLE info (
  info_id                INTEGER NOT NULL,
  original_source        VARCHAR(200),     
  creator                VARCHAR(100),
  title                  VARCHAR(100),
  publisher              VARCHAR(200),
  intellectual_rights    VARCHAR(200),
  license                VARCHAR(200),
  owner                  VARCHAR(100),
  PRIMARY KEY (info_id)
);"
dbSendQuery(con, tbl_info)

# Création de la table Site
tbl_site <- "
CREATE TABLE site (
  site_id INTEGER PRIMARY KEY AUTOINCREMENT,
  lat     REAL(7),
  lon     REAL(7)
);"
dbSendQuery(con, tbl_site)

#Création de la MAIN table

tbl_main <- "
CREATE TABLE main (
  id                            INTEGER PRIMARY KEY AUTOINCREMENT,
  observed_scientific_name      VARCHAR(100),
  year_obs                      INTEGER,
  day_obs                       INTEGER,
  time_obs                      TIME,
  dwc_event_date                DATE,
  Obs_id                        INTEGER,
  info_id                       INTEGER,
  site_id                       INTEGER,
  FOREIGN KEY (obs_id) REFERENCES observation(obs_id)
  FOREIGN KEY (info_id) REFERENCES info(info_id)
  FOREIGN KEY (site_id) REFERENCES site(site_id)
);"
dbSendQuery(con, tbl_main)
  

# INJECTION DES DONNÉES
dbWriteTable(con, "main", main, append = TRUE, row.names = FALSE)
dbWriteTable(con, "observation", obs, append = TRUE, row.names = FALSE)
dbWriteTable(con, "info", info, append = TRUE, row.names = FALSE)
dbWriteTable(con, "site", site, append = TRUE, row.names = FALSE)


#Requête pour la Q1 de la variation du nombre d'espèce selon la latitude
requete_Q1 <- "
SELECT main.observed_scientific_name, site_id
FROM main
INNER JOIN site ON main.site_id = site_id;
"

Q1 <- dbGetQuery(con, query)
View(result)

#Requête pour la Q2 de la variation du nombre d'espèce selon la longitude

requete_Q2 <- "
SELECT main.observed_scientific_name, site.lat
FROM main
left JOIN site
  ON site.site_id = site_id;
#Where main.Qc is True
   
"

Q2 <- dbGetQuery(con, query)
View(result)


requete_Q2 <- "
SELECT main.observed_scientific_name, site.lon
FROM main
left JOIN site
  ON site.site_id = site_id;
#Where main.Qc is True
"
Q3 <- dbGetQuery(con, requete_Q3)
View (Q3)


#déconnexion de la BD
dbDisconnect(con)
