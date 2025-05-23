library(RSQLite)

#supprimer fichier du dossier pour éviter les problèmes
file.remove("lepidoptere.db")

#établir la connection
con <- dbConnect(SQLite(), dbname="lepidoptere.db")

#Création de la table observation
tbl_observation <- "
CREATE TABLE observation (
  obs_id            INTEGER PRIMARY KEY,
  obs_unit          VARCHAR(40),
  obs_variable      VARCHAR(50),
  obs_value         VARCHAR(200)
);"
dbSendQuery(con,tbl_observation)


#Création de la table Info
tbl_info <- "
CREATE TABLE info (
  info_id                INTEGER PRIMARY KEY,
  original_source        VARCHAR(200),     
  creator                VARCHAR(100),
  title                  VARCHAR(100),
  publisher              VARCHAR(200),
  intellectual_rights    VARCHAR(200),
  license                VARCHAR(200),
  owner                  VARCHAR(100)
);"
dbSendQuery(con, tbl_info)


# Création de la table Site
tbl_site <- "
CREATE TABLE site (
  site_id INTEGER PRIMARY KEY,
  lat     REAL(7),
  lon     REAL(7),
  Quebec  BOOLEAN
);"
dbSendQuery(con, tbl_site)


#Création de la MAIN table
tbl_main <- "
CREATE TABLE main (
  main_id                       INTEGER PRIMARY KEY,
  observed_scientific_name      VARCHAR(100),
  year_obs                      INTEGER,
  day_obs                       INTEGER,
  time_obs                      TIME,
  dwc_event_date                TEXT,
  obs_id                        INTEGER,
  info_id                       INTEGER,
  site_id                       INTEGER,
  FOREIGN KEY (obs_id) REFERENCES observation(obs_id)
  FOREIGN KEY (info_id) REFERENCES info(info_id)
  FOREIGN KEY (site_id) REFERENCES site(site_id)
);"
dbSendQuery(con, tbl_main)
  
# INJECTION DES DONNÉES
dbWriteTable(con, "main", main, row.names = FALSE, overwrite=TRUE)
dbWriteTable(con, "observation", obs, row.names = FALSE, overwrite=TRUE)
dbWriteTable(con, "info", info, overwrite = TRUE, row.names = FALSE)
dbWriteTable(con, "site", site, overwrite = TRUE, row.names = FALSE)

#déconnexion de la BD

dbDisconnect(con)
