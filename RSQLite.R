library(RSQLite)
#Connection avce le serveur/fichier
con <- dbConnect(SQLite(), dbname="lepidoptere.db")


#Création de la MAIN table

tbl_main <- "
CREATE TABLE main (
  observed_scientific_name      VARCHAR(100),
  year_obs                      INTEGER,
  day_obs                       INTEGER,
  time_obs                      TIME,
  dwc_event_date                DATE,
  PRIMARY KEY (observed_scientific_name, dwc_event_date)
);"
dbSendQuery(con, tbl_main)



#Création de la table Observation

tbl_observation <- "
CREATE TABLE observation (
  obs_id            INTEGER NOT NULL,
  obs_unit          VARCHAR(40),
  obs_variable      VARCHAR(50),
  obs_value         VARCHAR(200),
  PRIMARY KEY (obs_id)
);"
dbSendQuery(con, tbl_observation)



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



#Création de la table Taxo
tbl_taxo <- "
CREATE TABLE taxo (
  observed_scientific_name      VARCHAR(100),
  code_sp                       INTEGER,
  PRIMARY KEY (code_sp)
);"
dbSendQuery(con, tbl_taxo)



#Création de la table Site
tbl_site <- "
CREATE TABLE site (
  lat     REAL(7),
  lon     REAL(7),
  PRIMARY KEY (lat, lon)
);"
dbSendQuery(con, tbl_site)



# INJECTION DES DONNÉES
dbWriteTable(con, append = TRUE, name = "main", value = main, row.names = FALSE) #bug
dbWriteTable(con, append = TRUE, name = "observation", value = obs, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "info", value = info, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "taxo", value = taxo, row.names = FALSE) # bug à cause des codes sp 
dbWriteTable(con, append = TRUE, name = "site", value = site, row.names = FALSE)


# test  de request pour la table info
res <- dbGetQuery(con, 'SELECT creator, title
                     FROM info
                     LIMIT 10
                  ')
View(res)

#déconnexion de la BD
dbDisconnect(con)
