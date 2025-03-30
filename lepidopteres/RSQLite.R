library(RSQLite)
#Connection avce le serveur/fichier
con <- dbConnect(SQLite(), dbname="lepidoptere.db")


#Création de la MAIN table

tbl_main <- "
CREATE TABLE main (
  observed_scientific_name      VARCHAR(100),
  year_obs                      INTERGER(4),
  day_obs                       INTERGER(2),
  time_obs                      TEXT(40),
  dwc_event_date                TIMESTAMP(20),
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
  code_sp                       INTERGER(10),
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


#Création de la table Ensemble

tbl_ensemble <- "
CREATE TABLE ensemble (
  observed_scientific_name      VARCHAR(100),
  dwc_event_date                TIMESTAMP(20),
  obs_id                        INTEGER NOT NULL,
  info_id                       INTEGER NOT NULL,
  code_sp                       INTERGER(10),
  lat                           REAL(7),
  lon                           REAL(7),
  PRIMARY KEY (observed_scientific_name, dwc_event_date, obs_id, info_id, code_sp),
  FOREIGN KEY (observed_scientific_name) REFERENCES main(observed_scientific_name),
  FOREIGN KEY (dwc_event_date) REFERENCES main(dwc_event_date),
  FOREIGN KEY (obs_id) REFERENCES observation(obs_id),
  FOREIGN KEY (info_id) REFERENCES observation(info_id),
  FOREIGN KEY (code_sp) REFERENCES observation(code_sp),
  FOREIGN KEY (lat) REFERENCES site(lat),
  FOREIGN KEY (lat) REFERENCES site(lat),
);"

dbSendQuery(con, tbl_ensemble)

# INJECTION DES DONNÉES
dbWriteTable(con, append = TRUE, name = "main", value = main, row.names = FALSE) #bug
dbWriteTable(con, append = TRUE, name = "observation", value = obs, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "info", value = info, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "taxo", value = taxo, row.names = FALSE) # bug à cause des codes sp 
dbWriteTable(con, append = TRUE, name = "site", value = site, row.names = FALSE)

#Faudrait faire la table pour ENSEMBLE mais jsp comment l'écrire pcq on a pas une bd contenant ces infos 
#(Voir l'exemple dans le livre)
dbWriteTable(con, append = TRUE, name = "ensemble", value = bd_collab, row.names = FALSE)


# fermeture de la connexion
dbDisconnect(con)

# test  de request pour la table info
res <- dbGetQuery(con, 'SELECT creator, title
                     FROM info
                     LIMIT 10
                  ')
View(res)
